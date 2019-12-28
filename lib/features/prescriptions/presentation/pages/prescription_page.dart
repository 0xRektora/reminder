import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/static/c_s_styles.dart';
import 'package:reminder/features/prescriptions/presentation/widgets/f_presc_presc_tile_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/bloc/app_bloc.dart';
import '../../../../core/bloc/bloc.dart';
import '../../../../dependency_injector.dart';
import '../../domain/entities/f_pill_entity.dart';
import '../bloc/bloc.dart';
import '../widgets/f_presc_form_widget.dart';

class PrescriptionPage extends StatefulWidget {
  PrescriptionPage({Key key}) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  /// Confirm dialaog to add new presc
  /// Add a new event to the feature bloc
  Future<void> _confirmDialog(
    BuildContext context,
    String pillName,
    int total,
    int current,
    int qtyToTake,
    int remindAt,
    DateTime remindWhen,
  ) async {
    final FPPillEntity entity = FPPillEntity(
      pillName: pillName,
      total: total,
      current: current,
      qtyToTake: qtyToTake,
      remindAt: remindAt,
      remindWhen: remindWhen,
      taken: false,
    );
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      final uid = appState.user.uid;
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescAddPillEvent(pillEntity: entity, uid: uid));
    }
  }

  /// Function that show an alert with the content
  /// provided as params
  Future<bool> _showAlert(
    BuildContext context,
    String title,
    Widget formWidget,
    List<DialogButton> actionDialog,
  ) {
    return Alert(
      style: CSFPresc.alertStyle,
      title: title,
      type: AlertType.none,
      context: context,
      content: formWidget,
      buttons: actionDialog,
    ).show();
  }

  /// Build a listview of [FPrescTileWidget] with a separator
  ListView _buildPresc(List<FPrescTileWidget> tiles) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return tiles[index];
      },
      itemCount: tiles.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
      ),
    );
  }

  /// Build the page with the given widget and add on top the positioned
  /// button
  Container _buildPage(BuildContext context, List<Widget> widgets) {
    return Container(
      child: Stack(
        children: <Widget>[
          ...widgets,
          _positionedButton(context),
        ],
      ),
    );
  }

  /// Render a widget a bottom right to add prescriptions
  Widget _positionedButton(BuildContext context) {
    final FPrescFormWidget form = FPrescFormWidget();
    final List<Widget> actionDialog =
        form.actionDialog(context, _confirmDialog);
    final String title = "Add prescription";

    final btn = Positioned(
      bottom: 20.0,
      right: 20.0,
      child: MaterialButton(
        height: 60.0,
        onPressed: () => _showAlert(
          context,
          title,
          form,
          actionDialog,
        ),
        color: Colors.blue,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
    return btn;
  }

  /// Function to delete the pill
  /// Call a feature event
  void _deletePill(BuildContext context, String pillName) {
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      BlocProvider.of<PrescriptionsBloc>(context).add(
        FPrescDeletePillEvent(
          pillName: pillName,
          uid: appState.user.uid,
        ),
      );
    }
  }

  /// Page to show when initial prescription event is on
  Widget isInitialPrescriptionsStateEvent(BuildContext context) {
    final appState = BlocProvider.of<AppBloc>(context).state;
    if (appState is AppLoggedState) {
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescListPillEvent(uid: appState.user.uid));
    }

    return _buildPage(context, []);
  }

  /// Function to process the list of Entities of prescription through a map
  /// Always return a [Widget]
  FPrescTileWidget _processListPills(FPPillEntity pillEntity) {
    final FPrescFormWidget form = FPrescFormWidget(
      pillEntity: pillEntity,
    );
    final List<Widget> actionDialog =
        form.actionDialog(context, _confirmDialog);
    final String title = "Change prescription";

    return FPrescTileWidget(
      deleteAction: (String pillName) {
        _deletePill(context, pillName);
      },
      title: pillEntity.pillName,
      onLongPress: () => _showAlert(
        context,
        title,
        form,
        actionDialog,
      ),
    );
  }

  /// Page to show when list pill event is on
  Widget isFprescListPillStateEvent(
    BuildContext context,
    FprescListPillState featureState,
  ) {
    final List<FPrescTileWidget> tiles =
        featureState.allPill.map(_processListPills).toList();
    return _buildPage(context, [_buildPresc(tiles)]);
  }

  /// Bloc event processing of the feature page
  Widget _featureBlocBuilder(BuildContext context, PrescriptionsState state) {
    if (state is InitialPrescriptionsState)
      return isInitialPrescriptionsStateEvent(context);
    else if (state is FprescListPillState)
      return isFprescListPillStateEvent(context, state);
    else
      return _buildPage(context, []);
  }

  /// Bloc listener of the feature page
  void _featureBlocListener(BuildContext context, PrescriptionsState state) {
    if (state is FPrescAddPillState)
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescListPillEvent(uid: state.uid));
    if (state is FPrescDeletePillState)
      BlocProvider.of<PrescriptionsBloc>(context)
          .add(FPrescListPillEvent(uid: state.uid));
  }

  /// Bloc builder + bloc listener
  Widget _blocBuilder(BuildContext context) {
    return BlocListener<PrescriptionsBloc, PrescriptionsState>(
      child: BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
        builder: _featureBlocBuilder,
      ),
      listener: _featureBlocListener,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrescriptionsBloc>(
      create: (_) => sl<PrescriptionsBloc>(),
      child: _blocBuilder(context),
    );
  }
}
