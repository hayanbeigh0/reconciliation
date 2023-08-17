import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reconciliation/business_logic/delete_downloadable_files/delete_downloadable_files_cubit.dart';
import 'package:reconciliation/business_logic/file_download/file_download_cubit.dart';
import 'package:reconciliation/business_logic/get_downloadable_files/get_downloadable_files_cubit.dart';
import 'package:reconciliation/business_logic/get_job_details/get_job_details_cubit.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/functions/date_formatter.dart';
import 'package:reconciliation/presentation/utils/functions/snackbars.dart';

class Downloads extends StatefulWidget {
  static const routeName = '/downloads';
  const Downloads({super.key});

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    BlocProvider.of<DownloadableFilesCubit>(context).getDownloadableFilesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DeleteDownloadableFilesCubit,
          DeleteDownloadableFilesState>(
        listener: (context, state) {
          if (state is DeletedDownloadableFileState) {
            BlocProvider.of<DownloadableFilesCubit>(context)
                .getDownloadableFilesList();
            SnackBars.sucessMessageSnackbar(
                context, 'Downloadable file deleted successfully!');
          }
          if (state is DeletingDownloadableFileFailedState) {
            SnackBars.errorMessageSnackbar(
                context, 'Failed deleting the downloadable file!');
          }
        },
        builder: (context, state) {
          if (state is DeletingDownloadableFileState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.colorPrimary),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Available Downloads',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 63, 70, 83),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Divider(),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<DownloadableFilesCubit, DownloadableFilesState>(
                builder: (context, state) {
                  if (state is LoadingDownloadableFilesState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    );
                  }
                  if (state is LoadingDownloadableFilesFailedState) {
                    return Center(
                      child: Column(
                        children: [
                          const Text('Failed loading available downloads!'),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<DownloadableFilesCubit>(context)
                                  .getDownloadableFilesList();
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is DownloadableFilesLoadedState) {
                    return Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Text(
                                  'Reference',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                const Expanded(
                                    child: Text(
                                  'Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<DownloadableFilesCubit>(
                                                context)
                                            .getDownloadableFilesList();
                                      },
                                      icon: const Icon(Icons.refresh),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.downloadableFiles.length,
                              itemBuilder: (context, index) {
                                return DownloadListItem(
                                  downloadableFilesLoadedState: state,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DownloadListItem extends StatelessWidget {
  const DownloadListItem({
    super.key,
    required this.downloadableFilesLoadedState,
    required this.index,
  });
  final DownloadableFilesLoadedState downloadableFilesLoadedState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: AppColors.colorPrimary,
        // ),
        border: Border(
          left: const BorderSide(
            color: AppColors.colorPrimaryBorderLight,
          ),
          right: const BorderSide(
            color: AppColors.colorPrimaryBorderLight,
          ),
          top: const BorderSide(
            color: AppColors.colorPrimaryBorderLight,
          ),
          bottom:
              index == downloadableFilesLoadedState.downloadableFiles.length - 1
                  ? const BorderSide(
                      color: AppColors.colorPrimaryBorderLight,
                    )
                  : BorderSide.none,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                downloadableFilesLoadedState
                    .downloadableFiles[index].reconciliationReference
                    .toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimaryBorderLight,
            ),
            Expanded(
              child: Text(
                // DateFormatter.formatDateTime(date),
                DateFormatter.formatDateTime(downloadableFilesLoadedState
                    .downloadableFiles[index].createdDate
                    .toString()),
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColors.colorPrimaryBorderLight,
            ),
            // VerticalDivider(),
            BlocBuilder<GetJobDetailsCubit, GetJobDetailsState>(
              builder: (context, state) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<FileDownloadCubit>(context)
                          .getResultFilesUrl(
                        reconciliationReferenceId: downloadableFilesLoadedState
                            .downloadableFiles[index]
                            .reconciliationReferenceId!,
                        downloadId: downloadableFilesLoadedState
                            .downloadableFiles[index].downloadId!,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.colorPrimary,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Download',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.colorWhite,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  BlocProvider.of<DeleteDownloadableFilesCubit>(context)
                      .deleteDownloadableFile(
                    downloadId: downloadableFilesLoadedState
                        .downloadableFiles[index].downloadId!,
                    reconciliationReferenceId: downloadableFilesLoadedState
                        .downloadableFiles[index].reconciliationReferenceId!,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: const Text(
                    'Delete',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
