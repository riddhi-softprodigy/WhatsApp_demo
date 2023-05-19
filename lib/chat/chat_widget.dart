import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.chatUser,
    required this.userRef,
    required this.userProfile,
  }) : super(key: key);

  final String? userName;
  final String? userEmail;
  final DocumentReference? chatUser;
  final DocumentReference? userRef;
  final String? userProfile;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.safePop();
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Color(0xFFA19999),
                                      size: 24.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 45.0,
                                      height: 45.0,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        widget.userProfile!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userName!,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          widget.userEmail!,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(
                            Icons.more_vert_rounded,
                            color: FlutterFlowTheme.of(context).accent2,
                            size: 24.0,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Color(0xFFDDD7D7),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 1.0,
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(),
                            child: StreamBuilder<List<ChatMessagesRecord>>(
                              stream: queryChatMessagesRecord(
                                queryBuilder: (chatMessagesRecord) =>
                                    chatMessagesRecord
                                        .where('chat_user',
                                            isEqualTo: widget.chatUser)
                                        .orderBy('timestamp'),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF075E54),
                                      ),
                                    ),
                                  );
                                }
                                List<ChatMessagesRecord>
                                    listViewChatMessagesRecordList =
                                    snapshot.data!;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewChatMessagesRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewChatMessagesRecord =
                                        listViewChatMessagesRecordList[
                                            listViewIndex];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if ((listViewChatMessagesRecord.user !=
                                                currentUserReference) &&
                                            (listViewChatMessagesRecord.image !=
                                                    null &&
                                                listViewChatMessagesRecord
                                                        .image !=
                                                    ''))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    widget.userProfile!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 300.0,
                                                  height: 200.0,
                                                  constraints: BoxConstraints(
                                                    maxWidth: 260.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUVFRgWFhYZGBgYHBoYGBoYGhgYGBgYGBoZGRgYGBocIS4lHB4rIRgYJjgmKy8xNTU1GiQ7QDs0Py40NTEBDAwMEA8QHxISHzQrJCs0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NP/AABEIAMIBAwMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAEBQADBgIBB//EAD0QAAIBAwMCAggDBgUEAwAAAAECAAMEERIhMQVBUWEGExQicYGRoTKx0RVCYoLB8CNDUnKistLh8TOSk//EABkBAAMBAQEAAAAAAAAAAAAAAAECAwAEBf/EACoRAAICAgICAQMEAgMAAAAAAAABAhEDIRIxBEETIjJRFHGBkRWhBVJh/9oADAMBAAIRAxEAPwDGWKBWyeJd1GqXGBPWpHE7o0sjecCytIz6EjNiD+rJOZoq/S8jMVLQOsL54nRGToQY9I6O9Ugb4m+sOhCmnH6mX+iVmqoCecR3fV1XaXjHirHihFa9OKtvuD49pq+n2aaQcDMAWsuBvzGdBgozwI1sLFvW9CAnaYp+nhz5n7Dwmg63cB2xn4Ty2sii5iSbboLE6dIZCNJ84D1W6dB9szQ1rgpuZner1g4IkZyUUL0ITU+8FqPvLKplGnJxIpexew6zfI3gXUE3jG2p6Vgl6md5obZqBrKppl15datsxW1XBxD7SgWIlPjuXIN+i2z6eWOTG6UlQeEZ21qqp5zNdRuDqIiSg29gaDX6j2zKkfUYrVjCraoRAoKJrCK1vkwy3QgTmmSSNpbXq6RJSl6MlYJXqEGUtWkqVQZS6mGMfyaw22uhnEZmhlciIKKYMeW14NODBldL6QxVsWXTkTm3cNGF3SVgTELoUbyiQkpxpaY7XEZ+rKnIl9Q6lxF63e06S6zA4N7YFIAq2zZO0kZetWSV+WX4NRS11tLLYljtBK6bbSWN1oPvSkYxFHlzW0JgzN+u9/PgYXedRDbDiCCntmVb4gZtOldfCqAeZbV6zrOAc5mPpNG/Srf3swxm26YyZuekpxnMaX9zpTSDvM+bv1ac/OLE6i9VjgyrlQbGfT7TVU1MeI+ruFXMzAvWTGxz9pTcdZOMGLypGs66pfKJnK9bMvvyz7wG3pFjv4zllGTdsV7ZS1MnfEFdsGaWrQUCKmtVLSyj6BQF7SZ7WqjT5wmrbDgS39jOU1R4xoOzK1N2+c0PT6ZKA77RP6rD4PI2M2/SkQUxGvZiyhcBRg9xM11FBrOPGEdVuSr7HaCWWGbLnO8Eqk6M9lltTBO8NFvngcQk2y4BEupgKN5OarQKBBXCYzKLm8VxtKuprq+EFpU8SKxWrYej1Z360ZlTnElOnvvM1oCLnq4ElPU3EprAQ3plPPMEUnoaqZw1VhtKaq5GYzubaBVcCZxr7UZv8iuvTInNu+8YaQRBWtMbiFNVTN+wRoJnk9RthJFpjWisHacNSJELtae28IdO00pU9E7M81Mho3s01CdvaAy61TQY7lyiZOih6WkxlY3OmK76rvKUrk7QpasA+v74kYB2h3o26gEHk/lMsSZ2l4y8GblJOxkz6cVQjtmZnq6oHyPnM8nWKnGqeLcsx3Md5LM2PaIDCAXHuQ7p7qVG+IJ1QAnaP6MCVLpmGJw9XAwJbStiZ2LQlgCJuLMd2FozkEzWVWQU99iBvL+idNUqPGX9d6b7jfCWWkMj5Le71mI7n+s0dgxCDbmIKlPDkmNrNmbAUyKmmwUe31iWJOYrWlpYf3mbBumsEzuTzM1e0HUnPaPKlsDDrarkb8CH0ipHl/fEE6XR18biE3duUU44mirVhoB6hoAOJnnrEQi5dsnfYxdWftMxWWm4zOhXaV2yAwz1QG8lKrBZwQ+M4jTplQ8Qf1y4hNpt2irTGQyqozb+EX3NLxjWjX1bSm5ts7xmtGoQu4WUtXJll/QIMrtE8ZOSSVs1smkyQ/Ankl8jDxReiSO2PjPKdwCNoK+pjDxdi2XmvnacMxnlBMHeE3OAsZUtAYD6rVOvZtMDa+0nadtdEiFphQbpBgFwuJ4l3ic16+qMog9lIaXpVMG1TpGjcTDGjdMO8YWhLnf4RGhJmr9G6AJEMLbo2zUdH6OukEjmW3nR8HK8xvauFAE7rVMAkidL0UFls7UgC0G6z1hSpXPIlfU+qKQQN5mLgE8mQyZElowku0yc+JjjoKKjDMXuNzG3SrOpVyKa504ySQqrk4GWOwyZy45tSCaxr1NONvKZTrNRcGe3NB6TBXBGRlSCGVh4qy5BEXdTqDGAdz2nVGfJbFYT0OuF2HjL+rXqE4zxF9kFRc9/ziHqt57xxKJ60Euvq6niL0olzt38IOjljvNL0WmBzzAxasViiU5GIwtenu42zGt304v9uJpeh2gRQCJ53l+THCgqNujDJ011cagcZmqs7JSvEb9Rs1YcTiztcDeefm/5BSinHsZRoV1qSoM4i64uh2mju7HVt2gz9EGknEvg824pPszTMdd1AYJSeMup2ukkRZRonVO1faydhGlpIeCJJHkyv0iywbaGMcbxXbVcCFrWBnU1si2XZzK7h9sSF9toLVaZRCjmjagnJnlywUS2nVlNdM7w029mQvbcy6kJTUGDLqAlH0AsZZNOJe1GeUqBPMVOw2eUGjbp969NgROLPpmTGdWxCgGBKUXaMlZpej9TL/3tHV91FAmCRM/0soEAHMW9Tt3L5wdM6G2lY5xcVVLMe3aLri6zCqlHaAVbbE5JLk7EspcZMZdHq1Ef3G0+OwI+YO3GR8CfGKmcjtNL6J9ErXGHVDo94Fy4RAV0+7gqSxOW3HGnzgjG5aGSd6CbZyzutwddKqV8jRcDSDTBzhSBwPA5zmLOt9Gei+DhlPvI44dexHh5ibW46KgR6VNjUZiFdipOhQQ2kKucMcDc+HaB9R1CiKNZSCN6TlW2YcrqI7gflGm6s6JQcop+z55fsUXA5i206fr85prjprOcShLF6RzjaRXkLjUXs5nYDT9Hm5EcdM6OQw1Zhlp1FcYMa21yp4nn5vLzRtBigmhZKBxLCuOJU17jmVNfr4zj3kX1BbS6DRVHedLUEUtdKe8DqdS0nmR/TSfRuZo9YnteoCIjpXmrvCEq+c0cc4O0HmB1umh2JO8ovukBVyBvHWrG8resG2M6I583JASRhXpPk7TybL1CeEk9D53+BaPmtKmQJaARLwoCyqs+kZxPSTsWi+kfGdBATFQujnELt6xhcWZaCmtTK69q4XODiMrWsveN7msjJtjiNBWg3ZgHbeX0zOb1ffOOMy62pZhkBoIStiXUqo5lTW+0EqMVOBzJJb0ZI1HTr0A5+sNvbnWMdpkqNcgZORv9tv1jOneYAznB4/8AEtG/YUaToOA6gnabSrboUPHE+RVOsspBwRjjbEZ2/pU+nBBwe+4lG1VDWO7iiA+BxviB3rAA5xB6XUNefCdPTNV0RTjUwAJ7ZPPy5kZRXHQUrH/oz0Ki6evrpqQ5CLk4fHJOO3YfONuudeakiW1vRwzjQiqDhUxyByDz9MwKte/6SEpoCAO5RFGy4Gw/D4fi8pmuu9W9WNWC9xVGp2OSKdL92mn+knG/fc+MhDWkdcYRS2Nrnqi2tD1VIn1z4au+rdDzoAU7Y2B+JnXSKThDWr1DTTYEspLOzZ90Jx+fER9FrpST2uodQOoUUx+N9vfII2A94Z33J8pZaPVunatXcpTQ5d2yFQdlRe5xjYb7/UyVjrQ9TTnIOR2PGR2PlA+puNJxCnoAIpphjTP4GZSNQ+Y3MHe11fing8XDI2/TOOfbRnqWCcR7aYUQK46bg7bQ22tiBvmVy5IyViJHZTWZXfdNIXMLobGWXbMwxOZ5KkqG4qjHeudSRmWIjOcwm6siMmF9OTAwZ3/IuNok0VU0dRKzeuDHwCmVmyUnic7zJP6kGhUOpNidp1Fe8PewXHEy/V00H3ZTC4zloz0OG6gPGSZP1rSTt+IWzkqROazjGJKlwCIucnM74q+wnrLvmX0H7T2igMKp0lEMmkYraqQNpzTrngmS5IHEDd5o7Rgmu4MiXOIGHM60xkqMnQYt7K0qhmPnx9R9f/cFeE2dDJgaS2YsZCAoO+WHw5G3w2+8qpli+N+B5bkDV8zvGVSyyJdY2A7yXzJKwoV1UxjI90FS22Nhtx8z9fKRFbVn4dt8kgNv3B97yja/sx2gPsJjxzJq2ZHNC5bSmO+358f34TUeieo1GfH4FqEbbBvdVOOTlz95m0sseU0vo+xCVKaIxaoMArz7pBxj6xJ5U9Ipjrkg6/YaUpuSTUIDcg6O6DPBbYfXwmOJa6uC2dKucsQB7ihudRHAXA+IxNn1i2KLkf8AyacKB7zBj+9gdxn7zMX1j7HQanzWqjDgblE8PImLCS9HZKLB7++NeogTOgZp0FHAUAhSo8SR+U2PS7BWVKD6TTpHU4wMPUOnUd+QuNI8cHzmS6FYtTKtsajqGByMUqZIwR4Mwz8B8Ztba4QHGRkDY87nt2888/imm/S6NH8s1tMqbd6ewVVOO4BXcdudh9ZnGPl/f9iFC6K0sYwXxt3C9yfDJgL5E8vypRlJL8HNmf1aB6lTB3hC11K7RXfEmU22e8isca2RTHFJwDLKlUQELBrmowEKwRbsNsOqFSIvqVsHaA+3HuZ0lUGVcK9C0Gpd4hdG8zFa0MwlFC8yeSCa6Cgy6qMV2mde2d2OZoaNcNsASfAbmWrZNnJAX/eyJ9mIMfBjltRRqMz+yG8JJrvZ28af/wCif90kvw8j8P8Ao1HyCk5Jhvqdpo7Kn0o406gfB6jgfVcH7Q6oKaDKWSVV8UqO/wDxZw3y0z2eLDxMQrkSw1DNI/WLHOl7IU28G9Ypz9QYRbv0t9yjr5Co2n77n6wcGzOBjWJPM8KCfR1S1AzbpbE9hWR2O/fUS+0HuLq6Q5WzoPjvS9WdvDbDfaHgzcD58dpZS3mouvSRxgVbMD/fSUjHxK5yPjK7f0jticm1o/JBz/Lj75mcf/TcBGli77IjN/tUsfsI1suhXIwfUuAeNWEz3/eIjtfSWg6FW124ydIpMhQAEgZBU7nnA8YHcU2felf5zuA6lT9Ub+kHxWuw8V7DaHRq+MNSf5AN/wBOZ0vTahJCo5YcgK2fpiIvbryluWDqf9LhuPEHBPE1Pot6SV6mpXDMijfWCVB8PfBwfgZJ+PFPsPx2UL6O3LkD1eP9zID9Ccy9/Q24U7lFHcsw+oC5zGjXyM+UfQScgD3s/DYn8u0l31dsaGGeM+8xO3OcjbbsPGBwiuikcKOR02jbINCLWc7s9TdF8QiY3x5wSt1jTpwQEPOkKn+oYCoN+DvxFt9WZ2GHGWDDBHCjn4gY79yJfbi0Qr77Mw76ttzqYgDheN5JwtnRHjBaK63UHLH1aBNvdf8AEwB5OdscmZ+7rUkbLnLsDlmznPcnzwRH9x1K0RirOxYYxj3QMHbGMZIyfGY7rtmjEvTq69ZJIIXIz2yDx247SmPBQuTN+BjW6tTpZajUDuzDWpU5ZNtOglcDGD37zU9Ke3dBUSohbGoo7BWXfJCq2xx/6nyqnRqA+6AfhiHW11XT9wkd9s/P4yk8EZKm2v2IfJI+iXHWqSMdT5PJGGJ+OcYM9TrlNs84G+duD+9vjaYqh6Tuvusi+YI07+OPGXjrlu2NdrTOeSqhSD4griR/x+B92/5Eo2LVKL5/xQO+4ByPEaWJI+U9pUqZ/wA9PEc7jxAODMTUNg/C1KZ/hckfEBsyg2FDPuXDY594A/liP+gw11/s1I+mU7ekBvWRmxnTqKD5uykYgV7VqrvTs1qAjZlqpU+Pul9x8p87ei6fhqqccfiX9ZzT6jWTcM3npbvHhgwwWkGjUV/SKrTJ12IXg+9RGBj+JVGR855S9MaJJ1UE1eDKo+IBUfcgxEnpPXXlz89vy2+04r9bD/jRW88D8xLNQfpf0Y2Vt6WWuRrtx8RqHzGk6T9BGX7foOD6mslJu2qkjAfMaSR9Z8wbSwyiN/Jqx+kqZW7Bj8UP5iTXBPpGpH0i56p1EZ9XUoVF/gbQ2fEK+MfUxRcel16h/wAaj5ElMj4g7j7zIIawwVVx4YDEfTEKp1bo7BXIPipH5ynOC90YeD0wpd7Wjnv/AIdP9J7Efslyf8k/8f1kg+WH/ZGsBR6R/EoHmM/0h9ChT/crOnmDkRjbWoQ4ZFb4qD/SO6KUgM+qT/6L+k5ZeZx9WBST9GfFGuy49opVFO2Kg/UGBXHRqu5CID/A+30M0V306g+4QKf4SV+w2ilujHPus+PjHj5UJK2mjckJja1030n6j+hliX9wn7zD+YHb5x0no+Ty7/UfpGdr6J0SMtrb4sR/04gl5eOKuzKSM2npJX4ZyfJt5GvGq/5Yf+XP3xtHl70yjSI0ov0yfqZQ9YAbTfqOauKA50I2tH7UyP5h+WZ1R6bXY4Vd/Mr/AEMPWsSY16cjhgcbSeTPKCvQFNsEtvRa6bkoo7+8x+wGJoundOuaaaPWKU22C4JOe5xkfWOqVx7uDCKTZ5nm/wCQyylVpfwPyroxl/ZVUYvVqoueN2J5zsMZ+5lC3OE0g7Dc9tXluP73E2FWzXUWxk8DO5HkD2i5ujprz8z335wPnOyHkprbKKYssuku+STpTOM8sdsnHicY8h5xZe+jVZ2zrp4Gyj3xgA7Abfeae9q6QfAbDHaKxdEGIvIbl9JOeRvozzeiNx2ZD/O2fus4f0XuByU+Tn/tmmfqDAbQRLp2O4MuvIlV2hOTEC+jFbP40HmGY4/4y1fR+ov+fj4AnPx3E0jMcbzhCDEflZHtMDk7M7+wKp/zl+YMpb0afvUX5AzaLb5E8eiBJPzp9WMn+TIUvRtu9U/Jf1MLpejyd3f5aR/SN6tTHE5oIzQPysj22FNAq9AoY31n4sf6YlqejlueVY/zt+sNdCsItmyInzzq+TM2Lz0S2XimD8WdvzM7trOmpytNB/KufriMHtzPUtzJSzSktt/2DkRagxArqoTssYi1notwOZFSp2DsRtqA3lK3G8a9VQadpmXJBnZianEVjtbqSIfXtPY/wo1mobSe0vWkuILWTPEFauyc52k4zT0GqDHTBlqOFHEqt6msS5rUkQc4t0wMoW8y3Ec2ze7FdHpuGzHdBAonN5Uo9RDEzHWrR2b3YoNg/Bm/ZFM4NqhhxeXKEUmjONmPsenEHOJo7ZFA3hooIO0Gqacxpz+YWqLlx2l9N4LTOeJGq4nP8Lb0MmF16mBFNW73O8l7cnEz9S6JMvDA0ByGdapq2zLbaw1RUlQxha3xWVUeKpBGidNUcy72VFHaBe3kwW4uG8YrjJ+zBlzQUwUUlWDLcN45liIW5mUJR9mCfXgQK4cmFPQwMwAsScYmjBJ2K9lLAxjZ7TuhaZlzUNMMkpKjKzmsmrtOranie06kIUHtItuK4hsITSBK2uFEBuQ54gLU3zmaEE9tmbHL3a+MHevmKajESla+O8uoJrQaHVYAiJLm3zCRebYk9as0U4szFfskkaZEkrzZg20TA3ltamrDEWvdnG0oW9bMj8MnKzDOlQ0HbiHI+IkF0xl3tBjPFuzDtrkYlIrknaJnrnMItqneLLDFijcZhCA4in2vBln7RivFH8BsPq7xfcUm7GT2k+MtFYEbzKNPQQeg5HMruK+TJcv4QUOJXHHZga/u8DETM+8Y3qajtKVsjLcooFM8t3zCGfE5S3xO3pyTabHiH2D5hVWjmL7U6Yalck47RJt+hWCVaemVe36Y4qUAwiS5sCWwIMc09SMW/tMNtJTrjOZ3bdH7mWXVmqiN8kLpGCqHUV4lz3ikTMYIMtVjnmVUUChubgZhtC6XvEqLtO2YgSc8fJm6RpUuEI7QStUTPaZ012HeWU6+eTEjh4gWxpXVSJn784MPq3AA5iuu+TKwjTGBlqGE063jKNQlTVMGXqzDT1kkWevki8GYdUHU8mFtQTmZIV2ziGUr1wMGVlGgI0dOqg5xPKl0nbEzzVSZwGPjJqN9haoeOQd5SLwKcQVbnAxAq2SYyihR291qlPtGIHbI0ZezZHEhNqLD2cC9hlKqTAE6exOwjOjalRJylH0wHr7wb1RMNVRmWsABAsmqQyFAAU7y4kYntShk5hNGgMTNe2M3YGFhNvbBuZTdsFg1C9IO0HFtWgJD9LBRPHtR2gtG9JEYWr5O8H7i2cJSYbdpXVTHaMKt0qjtA/bEY4kpRa2jWAvdsO0DuazMN46rqmIBcUxjaNjafoAkJ3liAQW7fBntGrO3i6sKGdDfmX3IAEX2dTLbzRLRVl3ksuVRfRmZGs5J2lvqmAzHtXp652nlzZEriB506MkZx6hMoYxvT6WxJkrdGaUWaCdWFCcYlbiEXVmV5gIcky8dq0NSLMCSc6DJHDR4fxQvtJJBk9E4nM9PM9kihkeGX20kkEuhl0NLcRnS4kknn5RQikJ3W4kkkQMXnmdGSSXRkcdpFnsktL7AoXX0EpSSTR+0f0NrWM6fEkkWPZNgd9F6HeeSR/QoYh2lh/DJJEQTM9Q/FOE4nsk619qGXQTaR1QY+Mkk5s/YrDk5EuPE9knIwxPFnT8SSScuzIzHXIioTySetg+waPYXJJJGKH//2Q==',
                                                      ).image,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(24.0),
                                                      bottomRight:
                                                          Radius.circular(24.0),
                                                      topLeft:
                                                          Radius.circular(3.0),
                                                      topRight:
                                                          Radius.circular(24.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if ((listViewChatMessagesRecord.user ==
                                                currentUserReference) &&
                                            (listViewChatMessagesRecord.image !=
                                                    null &&
                                                listViewChatMessagesRecord
                                                        .image !=
                                                    ''))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 300.0,
                                                  height: 200.0,
                                                  constraints: BoxConstraints(
                                                    maxWidth: 260.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                        listViewChatMessagesRecord
                                                            .image,
                                                      ).image,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(24.0),
                                                      bottomRight:
                                                          Radius.circular(24.0),
                                                      topLeft:
                                                          Radius.circular(24.0),
                                                      topRight:
                                                          Radius.circular(3.0),
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.9, 0.9),
                                                        child: StreamBuilder<
                                                            List<ChatsRecord>>(
                                                          stream:
                                                              queryChatsRecord(
                                                            singleRecord: true,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        0xFF075E54),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<ChatsRecord>
                                                                iconChatsRecordList =
                                                                snapshot.data!;
                                                            // Return an empty Container when the item does not exist.
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Container();
                                                            }
                                                            final iconChatsRecord =
                                                                iconChatsRecordList
                                                                        .isNotEmpty
                                                                    ? iconChatsRecordList
                                                                        .first
                                                                    : null;
                                                            return FaIcon(
                                                              FontAwesomeIcons
                                                                  .checkDouble,
                                                              color: Color(
                                                                  0xFF25D366),
                                                              size: 16.0,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if ((listViewChatMessagesRecord.user !=
                                                currentUserReference) &&
                                            (listViewChatMessagesRecord.text !=
                                                    null &&
                                                listViewChatMessagesRecord
                                                        .text !=
                                                    ''))
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  widget.userProfile!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        6.0, 6.0, 0.0, 0.0),
                                                child: Container(
                                                  width: 300.0,
                                                  constraints: BoxConstraints(
                                                    maxWidth: 260.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(24.0),
                                                      bottomRight:
                                                          Radius.circular(24.0),
                                                      topLeft:
                                                          Radius.circular(3.0),
                                                      topRight:
                                                          Radius.circular(24.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16.0,
                                                                16.0,
                                                                16.0,
                                                                16.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              listViewChatMessagesRecord
                                                                  .text,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              dateTimeFormat(
                                                                  'jm',
                                                                  listViewChatMessagesRecord
                                                                      .timestamp!),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: Color(
                                                                        0xFFBDB7B7),
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if ((listViewChatMessagesRecord.user ==
                                                currentUserReference) &&
                                            (listViewChatMessagesRecord.text !=
                                                    null &&
                                                listViewChatMessagesRecord
                                                        .text !=
                                                    ''))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 6.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 300.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 260.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                24.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                24.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                24.0),
                                                        topRight:
                                                            Radius.circular(
                                                                3.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  16.0,
                                                                  16.0,
                                                                  16.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                listViewChatMessagesRecord
                                                                    .text,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    dateTimeFormat(
                                                                        'jm',
                                                                        listViewChatMessagesRecord
                                                                            .timestamp!),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Outfit',
                                                                          color:
                                                                              Color(0xFFBDB7B7),
                                                                          fontSize:
                                                                              12.0,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    FaIcon(
                                                                      FontAwesomeIcons
                                                                          .checkDouble,
                                                                      color: Color(
                                                                          0xFF25D366),
                                                                      size:
                                                                          12.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).accent2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.textController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Type  Something...',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodySmall,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0,
                                  child: VerticalDivider(
                                    thickness: 1.0,
                                    color:
                                        FlutterFlowTheme.of(context).grayIcon,
                                  ),
                                ),
                                StreamBuilder<List<ChatsRecord>>(
                                  stream: queryChatsRecord(
                                    singleRecord: true,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF075E54),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ChatsRecord> iconChatsRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final iconChatsRecord =
                                        iconChatsRecordList.isNotEmpty
                                            ? iconChatsRecordList.first
                                            : null;
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          maxWidth: 300.00,
                                          maxHeight: 300.00,
                                          imageQuality: 50,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];
                                          var downloadUrls = <String>[];
                                          try {
                                            showUploadMessage(
                                              context,
                                              'Uploading file...',
                                              showLoading: true,
                                            );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl =
                                                  downloadUrls.first;
                                            });
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload data');
                                            return;
                                          }
                                        }

                                        final chatMessagesCreateData =
                                            createChatMessagesRecordData(
                                          user: currentUserReference,
                                          chatUser: widget.chatUser,
                                          timestamp: getCurrentTimestamp,
                                          image: _model.uploadedFileUrl,
                                        );
                                        await ChatMessagesRecord.collection
                                            .doc()
                                            .set(chatMessagesCreateData);

                                        final chatsUpdateData =
                                            createChatsRecordData(
                                          lastMessageTime: getCurrentTimestamp,
                                        );
                                        await iconChatsRecord!.reference
                                            .update(chatsUpdateData);
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: FlutterFlowTheme.of(context)
                                            .grayIcon,
                                        size: 24.0,
                                      ),
                                    );
                                  },
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: FlutterFlowTheme.of(context).grayIcon,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: StreamBuilder<List<ChatsRecord>>(
                              stream: queryChatsRecord(
                                singleRecord: true,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF075E54),
                                      ),
                                    ),
                                  );
                                }
                                List<ChatsRecord> containerChatsRecordList =
                                    snapshot.data!;
                                // Return an empty Container when the item does not exist.
                                if (snapshot.data!.isEmpty) {
                                  return Container();
                                }
                                final containerChatsRecord =
                                    containerChatsRecordList.isNotEmpty
                                        ? containerChatsRecordList.first
                                        : null;
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (_model.textController.text != null &&
                                        _model.textController.text != '') {
                                      final chatMessagesCreateData =
                                          createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chatUser: widget.chatUser,
                                        text: _model.textController.text,
                                        timestamp: getCurrentTimestamp,
                                      );
                                      await ChatMessagesRecord.collection
                                          .doc()
                                          .set(chatMessagesCreateData);

                                      final chatsUpdateData =
                                          createChatsRecordData(
                                        lastMessageTime: getCurrentTimestamp,
                                        lastMessage: _model.textController.text,
                                      );
                                      await containerChatsRecord!.reference
                                          .update(chatsUpdateData);
                                      setState(() {
                                        _model.textController?.clear();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please type message',
                                            style: GoogleFonts.getFont(
                                              'Roboto',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .accent2,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30.0,
                                          borderWidth: 1.0,
                                          buttonSize: 30.0,
                                          icon: Icon(
                                            Icons.send,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 20.0,
                                          ),
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
