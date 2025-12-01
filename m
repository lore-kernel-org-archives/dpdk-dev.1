Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D6D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A181940DFD;
	Mon,  1 Dec 2025 12:45:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0440240B9B
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589527; x=1796125527;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LSmMI2LQIbsOxyfgzUOulXAaGztJXsU7TpECTidvDsI=;
 b=Kk9C1jocceKyctzNyYN0uRtdYX5t2oesMtla0o6uoqJ1QMInAu22iu0z
 YPVFjTRnCvMg0L02UVEyUMb0Th+E7XbPRlDyPuAnbi4jObAUHzHIFbSMk
 L77AcFDjhgv+DoCkyaX6FZXK7FitOn4NCO/Q2RMFQs8187QQdQXEJb+uX
 MNvcKQN8GxrvP1SUIAiYJ/CT+GcJXOguvTt2C6DHg4MHUEgS6USxDM8cW
 UYfNA1Ug93Xi1YoMncKavXzpCTJAD+MReQpR41YnDzsBnh25dY5SFd9Yc
 uG6IUMtTvmd3/cpBNMmQCimsu9JzspIQ7eRkgTVqblV898rWtcysNaqUG A==;
X-CSE-ConnectionGUID: jbA2/qZVSKqqT0JYAokHIA==
X-CSE-MsgGUID: mQXeg8HsTjOCdmybGHLyAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991759"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:27 -0800
X-CSE-ConnectionGUID: mFg4K+QgRGaioYAky3huzA==
X-CSE-MsgGUID: vgEA+ZvxRtmQXCDJDKOUxA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 22/31] app/test-compress-perf: rename local vars to fix
 shadowing
Date: Mon,  1 Dec 2025 11:44:39 +0000
Message-ID: <20251201114448.1441377-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Rename the parameter to 3 functions to avoid shadowing a global variable
of the same name.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-compress-perf/main.c | 122 +++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 59af073f12..c9ead02cb4 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -53,33 +53,33 @@ static const struct cperf_test cperf_testmap[] = {
 static struct comp_test_data *test_data;
 
 static int
-comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
+comp_perf_check_capabilities(struct comp_test_data *td, uint8_t cdev_id)
 {
 	const struct rte_compressdev_capabilities *cap;
 
-	cap = rte_compressdev_capability_get(cdev_id, test_data->test_algo);
+	cap = rte_compressdev_capability_get(cdev_id, td->test_algo);
 
 	if (cap == NULL) {
 		RTE_LOG(ERR, USER1,
 			"Compress device does not support %u algorithm\n",
-			test_data->test_algo);
+			td->test_algo);
 		return -1;
 	}
 
 	uint64_t comp_flags = cap->comp_feature_flags;
 
 	/* Algorithm type */
-	switch (test_data->test_algo) {
+	switch (td->test_algo) {
 	case RTE_COMP_ALGO_DEFLATE:
 		/* Huffman encoding */
-		if (test_data->huffman_enc == RTE_COMP_HUFFMAN_FIXED &&
+		if (td->huffman_enc == RTE_COMP_HUFFMAN_FIXED &&
 		    (comp_flags & RTE_COMP_FF_HUFFMAN_FIXED) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not supported Fixed Huffman\n");
 			return -1;
 		}
 
-		if (test_data->huffman_enc == RTE_COMP_HUFFMAN_DYNAMIC &&
+		if (td->huffman_enc == RTE_COMP_HUFFMAN_DYNAMIC &&
 		    (comp_flags & RTE_COMP_FF_HUFFMAN_DYNAMIC) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not supported Dynamic Huffman\n");
@@ -88,14 +88,14 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 		break;
 	case RTE_COMP_ALGO_LZ4:
 		/* LZ4 flags */
-		if ((test_data->lz4_flags & RTE_COMP_LZ4_FLAG_BLOCK_CHECKSUM) &&
+		if ((td->lz4_flags & RTE_COMP_LZ4_FLAG_BLOCK_CHECKSUM) &&
 		    (comp_flags & RTE_COMP_FF_LZ4_BLOCK_WITH_CHECKSUM) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not support LZ4 block with checksum\n");
 			return -1;
 		}
 
-		if ((test_data->lz4_flags &
+		if ((td->lz4_flags &
 		     RTE_COMP_LZ4_FLAG_BLOCK_INDEPENDENCE) &&
 		    (comp_flags & RTE_COMP_FF_LZ4_BLOCK_INDEPENDENCE) == 0) {
 			RTE_LOG(ERR, USER1,
@@ -111,8 +111,8 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 	}
 
 	/* Window size */
-	if (test_data->window_sz != -1) {
-		if (param_range_check(test_data->window_sz, &cap->window_size)
+	if (td->window_sz != -1) {
+		if (param_range_check(td->window_sz, &cap->window_size)
 				< 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not support "
@@ -121,18 +121,18 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 		}
 	} else
 		/* Set window size to PMD maximum if none was specified */
-		test_data->window_sz = cap->window_size.max;
+		td->window_sz = cap->window_size.max;
 
 	/* Check if chained mbufs is supported */
-	if (test_data->max_sgl_segs > 1  &&
+	if (td->max_sgl_segs > 1  &&
 			(comp_flags & RTE_COMP_FF_OOP_SGL_IN_SGL_OUT) == 0) {
 		RTE_LOG(INFO, USER1, "Compress device does not support "
 				"chained mbufs. Max SGL segments set to 1\n");
-		test_data->max_sgl_segs = 1;
+		td->max_sgl_segs = 1;
 	}
 
 	/* Level 0 support */
-	if (test_data->level_lst.min == 0 &&
+	if (td->level_lst.min == 0 &&
 			(comp_flags & RTE_COMP_FF_NONCOMPRESSED_BLOCKS) == 0) {
 		RTE_LOG(ERR, USER1, "Compress device does not support "
 				"level 0 (no compression)\n");
@@ -143,19 +143,19 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 }
 
 static int
-comp_perf_initialize_compressdev(struct comp_test_data *test_data,
+comp_perf_initialize_compressdev(struct comp_test_data *td,
 				 uint8_t *enabled_cdevs)
 {
 	uint8_t enabled_cdev_count, nb_lcores, cdev_id;
 	unsigned int i, j;
 	int ret;
 
-	enabled_cdev_count = rte_compressdev_devices_get(test_data->driver_name,
+	enabled_cdev_count = rte_compressdev_devices_get(td->driver_name,
 			enabled_cdevs, RTE_COMPRESS_MAX_DEVS);
 	if (enabled_cdev_count == 0) {
 		RTE_LOG(ERR, USER1, "No compress devices type %s available,"
 				    " please check the list of specified devices in EAL section\n",
-				test_data->driver_name);
+				td->driver_name);
 		return -EINVAL;
 	}
 
@@ -186,13 +186,13 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 	 * 2 queue pairs will be set up per device but one queue pair
 	 * will left unused in the last one device
 	 */
-	test_data->nb_qps = (nb_lcores % enabled_cdev_count) ?
+	td->nb_qps = (nb_lcores % enabled_cdev_count) ?
 				(nb_lcores / enabled_cdev_count) + 1 :
 				nb_lcores / enabled_cdev_count;
 
 	for (i = 0; i < enabled_cdev_count &&
 			i < RTE_COMPRESS_MAX_DEVS; i++,
-					nb_lcores -= test_data->nb_qps) {
+					nb_lcores -= td->nb_qps) {
 		cdev_id = enabled_cdevs[i];
 
 		struct rte_compressdev_info cdev_info;
@@ -200,7 +200,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 
 		rte_compressdev_info_get(cdev_id, &cdev_info);
 		if (cdev_info.max_nb_queue_pairs &&
-			test_data->nb_qps > cdev_info.max_nb_queue_pairs) {
+			td->nb_qps > cdev_info.max_nb_queue_pairs) {
 			RTE_LOG(ERR, USER1,
 				"Number of needed queue pairs is higher "
 				"than the maximum number of queue pairs "
@@ -211,25 +211,25 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 			return -EINVAL;
 		}
 
-		if (comp_perf_check_capabilities(test_data, cdev_id) < 0)
+		if (comp_perf_check_capabilities(td, cdev_id) < 0)
 			return -EINVAL;
 
 		/* Configure compressdev */
 		struct rte_compressdev_config config = {
 			.socket_id = socket_id,
-			.nb_queue_pairs = nb_lcores > test_data->nb_qps
-					? test_data->nb_qps : nb_lcores,
+			.nb_queue_pairs = nb_lcores > td->nb_qps
+					? td->nb_qps : nb_lcores,
 			.max_nb_priv_xforms = NUM_MAX_XFORMS,
 			.max_nb_streams = 0
 		};
-		test_data->nb_qps = config.nb_queue_pairs;
+		td->nb_qps = config.nb_queue_pairs;
 
 		if (rte_compressdev_configure(cdev_id, &config) < 0) {
 			RTE_LOG(ERR, USER1, "Device configuration failed\n");
 			return -EINVAL;
 		}
 
-		for (j = 0; j < test_data->nb_qps; j++) {
+		for (j = 0; j < td->nb_qps; j++) {
 			ret = rte_compressdev_queue_pair_setup(cdev_id, j,
 					NUM_MAX_INFLIGHT_OPS, socket_id);
 			if (ret < 0) {
@@ -253,9 +253,9 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 }
 
 static int
-comp_perf_dump_input_data(struct comp_test_data *test_data)
+comp_perf_dump_input_data(struct comp_test_data *td)
 {
-	FILE *f = fopen(test_data->input_file, "r");
+	FILE *f = fopen(td->input_file, "r");
 	int ret = -1;
 	size_t actual_file_sz, remaining_data;
 	uint8_t *data = NULL;
@@ -274,34 +274,34 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 	 * input data size = file size
 	 */
 
-	if (test_data->input_data_sz == 0)
-		test_data->input_data_sz = actual_file_sz;
+	if (td->input_data_sz == 0)
+		td->input_data_sz = actual_file_sz;
 
-	if (test_data->input_data_sz <= 0 || actual_file_sz <= 0 ||
+	if (td->input_data_sz <= 0 || actual_file_sz <= 0 ||
 			fseek(f, 0, SEEK_SET) != 0) {
 		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
 		goto end;
 	}
 
-	if (!(test_data->test_op & COMPRESS) &&
-	    test_data->input_data_sz >
-	    (size_t) test_data->seg_sz * (size_t) test_data->max_sgl_segs) {
+	if (!(td->test_op & COMPRESS) &&
+	    td->input_data_sz >
+	    (size_t) td->seg_sz * (size_t) td->max_sgl_segs) {
 		RTE_LOG(ERR, USER1,
 			"Size of input must be less than total segments\n");
 		goto end;
 	}
 
-	test_data->input_data = rte_zmalloc_socket(NULL,
-				test_data->input_data_sz, 0, rte_socket_id());
+	td->input_data = rte_zmalloc_socket(NULL,
+				td->input_data_sz, 0, rte_socket_id());
 
-	if (test_data->input_data == NULL) {
+	if (td->input_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the input "
 				"file could not be allocated\n");
 		goto end;
 	}
 
-	remaining_data = test_data->input_data_sz;
-	data = test_data->input_data;
+	remaining_data = td->input_data_sz;
+	data = td->input_data;
 
 	while (remaining_data > 0) {
 		size_t data_to_read = RTE_MIN(remaining_data, actual_file_sz);
@@ -320,15 +320,15 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 	}
 
 	printf("\n");
-	if (test_data->input_data_sz > actual_file_sz)
+	if (td->input_data_sz > actual_file_sz)
 		RTE_LOG(INFO, USER1,
 		  "%zu bytes read from file %s, extending the file %.2f times\n",
-			test_data->input_data_sz, test_data->input_file,
-			(double)test_data->input_data_sz/actual_file_sz);
+			td->input_data_sz, td->input_file,
+			(double)td->input_data_sz/actual_file_sz);
 	else
 		RTE_LOG(INFO, USER1,
 			"%zu bytes read from file %s\n",
-			test_data->input_data_sz, test_data->input_file);
+			td->input_data_sz, td->input_file);
 
 	ret = 0;
 
@@ -338,15 +338,15 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 }
 
 static int
-comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
+comp_perf_dump_dictionary_data(struct comp_test_data *td)
 {
-	FILE *f = fopen(test_data->dictionary_file, "r");
+	FILE *f = fopen(td->dictionary_file, "r");
 	int ret = -1;
 
 	if (f == NULL) {
 		RTE_LOG(ERR, USER1, "Dictionary file not specified\n");
-		test_data->dictionary_data_sz = 0;
-		test_data->dictionary_data = NULL;
+		td->dictionary_data_sz = 0;
+		td->dictionary_data = NULL;
 		ret = 0;
 		goto end;
 	}
@@ -367,40 +367,40 @@ comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
 
 	size_t actual_file_sz = (size_t)file_sz;
 
-	if (test_data->dictionary_data_sz == 0)
-		test_data->dictionary_data_sz = actual_file_sz;
+	if (td->dictionary_data_sz == 0)
+		td->dictionary_data_sz = actual_file_sz;
 
 	if (fseek(f, 0, SEEK_SET) != 0) {
 		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
 		goto end;
 	}
 
-	test_data->dictionary_data = rte_zmalloc_socket(NULL,
-				test_data->dictionary_data_sz, 0, rte_socket_id());
+	td->dictionary_data = rte_zmalloc_socket(NULL,
+				td->dictionary_data_sz, 0, rte_socket_id());
 
-	if (test_data->dictionary_data == NULL) {
+	if (td->dictionary_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the dictionary "
 				"file could not be allocated\n");
 		goto end;
 	}
 
-	size_t remaining_data = test_data->dictionary_data_sz;
-	uint8_t *data = test_data->dictionary_data;
+	size_t remaining_data = td->dictionary_data_sz;
+	uint8_t *data = td->dictionary_data;
 
 	while (remaining_data > 0) {
 		size_t data_to_read = RTE_MIN(remaining_data, actual_file_sz);
 
 		if (fread(data, data_to_read, 1, f) != 1) {
 			RTE_LOG(ERR, USER1, "Input file could not be read\n");
-			if (test_data->dictionary_data)
-				rte_free(test_data->dictionary_data);
+			if (td->dictionary_data)
+				rte_free(td->dictionary_data);
 			goto end;
 		}
 		if (fseek(f, 0, SEEK_SET) != 0) {
 			RTE_LOG(ERR, USER1,
 				"Size of input could not be calculated\n");
-			if (test_data->dictionary_data)
-				rte_free(test_data->dictionary_data);
+			if (td->dictionary_data)
+				rte_free(td->dictionary_data);
 			goto end;
 		}
 		remaining_data -= data_to_read;
@@ -408,15 +408,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
 	}
 
 	printf("\n");
-	if (test_data->dictionary_data_sz > actual_file_sz)
+	if (td->dictionary_data_sz > actual_file_sz)
 		RTE_LOG(INFO, USER1,
 		  "%zu bytes read from file %s, extending the file %.2f times\n",
-			test_data->dictionary_data_sz, test_data->dictionary_file,
-			(double)test_data->dictionary_data_sz/actual_file_sz);
+			td->dictionary_data_sz, td->dictionary_file,
+			(double)td->dictionary_data_sz/actual_file_sz);
 	else
 		RTE_LOG(INFO, USER1,
 			"%zu bytes read from file %s\n",
-			test_data->dictionary_data_sz, test_data->dictionary_file);
+			td->dictionary_data_sz, td->dictionary_file);
 
 	ret = 0;
 
-- 
2.51.0

