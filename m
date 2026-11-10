Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59B606A339
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NEiWO3g9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7AF940296;
	Tue, 10 Nov 2026 16:15:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 61EEB40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794323741; x=1825859741;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Qgmy6tNxp1Iq/XXemn86wDc34UDsdAaznVfnhelvl3M=;
 b=NEiWO3g9I+csMM5RivOqFAKOFg3mSktKra212GFyU4LhGblXmjPezj04
 7DHVc8+wgydNr1zMMokF8GJO+ZO9V++HnRlE9/7bIl6DerhAyOj88i+p/
 CKexZbFhoIpvoG0JFcSorpoVM0CbxWhFr8WgQOse7tnRDbsK/lW9kqNad
 nmKr+Fz7LhT4DTW3TNajoO99HaakVmAXUxJo/+dpHQ+rKZmgZeCd1Efrj
 ZwVj6Fw/VAZn+lVXFqy5IfFj0do9xYwU9Ad2UDuPI+XWbtHbPknB7GaKc
 zlYOFO5lJA0BV4dKodpqu5VplIZmHDw2YG+MJIT0h/Vky2/YIEgC+YEcM A==;
X-CSE-ConnectionGUID: aqTL9kYGR7i4C53u68KMDA==
X-CSE-MsgGUID: ILl4lZzLSbuVA6kkYYksjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2949983"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2949983"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:15:39 -0800
X-CSE-ConnectionGUID: 9YR6M68LRvWgofs/aCrCDw==
X-CSE-MsgGUID: d9QyLk/gR46uRtFCq2aGpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8481210"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2026 07:15:37 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH] compress/qat: add Gen 6 support
Date: Tue, 10 Nov 2026 15:15:29 +0000
Message-ID: <20261110151529.2966094-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for Gen 6 QAT compression devices.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/compressdevs/qat_comp.rst         |   1 +
 doc/guides/cryptodevs/qat.rst                |   2 +-
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/common/qat/meson.build               |   1 +
 drivers/common/qat/qat_adf/icp_qat_fw_comp.h |   5 +
 drivers/compress/qat/dev/qat_comp_pmd_gen6.c | 135 +++++++++++++++++++
 drivers/compress/qat/dev/qat_comp_pmd_gens.h |   8 ++
 drivers/compress/qat/qat_comp.c              |  21 ++-
 8 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 drivers/compress/qat/dev/qat_comp_pmd_gen6.c

diff --git a/doc/guides/compressdevs/qat_comp.rst b/doc/guides/compressdevs/qat_comp.rst
index 78b1ad9c23..7c6c8e1074 100644
--- a/doc/guides/compressdevs/qat_comp.rst
+++ b/doc/guides/compressdevs/qat_comp.rst
@@ -15,6 +15,7 @@ support for the following hardware accelerator devices:
 * ``Intel QuickAssist Technology C3xxx``
 * ``Intel QuickAssist Technology DH895x``
 * ``Intel QuickAssist Technology 300xx``
+* ``Intel QuickAssist Technology 6xxx``
 
 
 Features
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 27713913ae..8c118b3c5f 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -486,7 +486,7 @@ to see the full table)
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
    | Yes | Yes | Yes | 5   | 420xx    | linux/6.8+    | qat_420xx     | 420xx      | 4946   | 2    | 4947   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
-   | Yes | Yes | No  | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6xxx       | 4948   | 1    | 4949   | 16     |
+   | Yes | Yes | Yes | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6xxx       | 4948   | 1    | 4949   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
 
 * Note: Symmetric mixed crypto algorithms feature on Gen 2 works only with IDZ driver version 4.9.0+
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fdcf155e07..81971ee38a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -59,6 +59,10 @@ New Features
 
   * Added support for Gen 6 QAT devices.
 
+* **Updated Intel QuickAssist Technology (QAT) compression driver.**
+
+  * Added support for Gen 6 QAT devices.
+
 
 Removed Items
 -------------
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index db792864a2..c7ad535c69 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -123,6 +123,7 @@ if qat_compress
             'dev/qat_comp_pmd_gen3.c',
             'dev/qat_comp_pmd_gen4.c',
             'dev/qat_comp_pmd_gen5.c',
+            'dev/qat_comp_pmd_gen6.c',
         ]
         sources += files(join_paths(qat_compress_relpath, f))
     endforeach
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
index da45cb8f7d..625fdc055f 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
@@ -20,6 +20,11 @@ enum icp_qat_fw_comp_cmd_id {
 	/**< Delimiter type */
 };
 
+enum icp_qat_fw_comp_cmd_id_gen6 {
+	ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_COMP = 1,
+	ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_DECOMP = 2,
+};
+
 /**< Flag usage */
 
 #define ICP_QAT_FW_COMP_STATELESS_SESSION 0
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gen6.c b/drivers/compress/qat/dev/qat_comp_pmd_gen6.c
new file mode 100644
index 0000000000..40be10b1ea
--- /dev/null
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gen6.c
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_memzone.h>
+
+#include "qat_logs.h"
+#include "qat_comp.h"
+#include "qat_comp_pmd.h"
+#include "qat_comp_pmd_gens.h"
+#include "icp_qat_hw_gen4_comp.h"
+
+static const struct rte_compressdev_capabilities
+qat_gen6_comp_capabilities[] = {
+	{/* COMPRESSION - deflate */
+	 .algo = RTE_COMP_ALGO_DEFLATE,
+	 .comp_feature_flags = RTE_COMP_FF_MULTI_PKT_CHECKSUM |
+				RTE_COMP_FF_CRC32_CHECKSUM |
+				RTE_COMP_FF_ADLER32_CHECKSUM |
+				RTE_COMP_FF_CRC32_ADLER32_CHECKSUM |
+				RTE_COMP_FF_SHAREABLE_PRIV_XFORM |
+				RTE_COMP_FF_HUFFMAN_DYNAMIC |
+				RTE_COMP_FF_HUFFMAN_FIXED |
+				RTE_COMP_FF_OOP_SGL_IN_SGL_OUT |
+				RTE_COMP_FF_OOP_SGL_IN_LB_OUT |
+				RTE_COMP_FF_OOP_LB_IN_SGL_OUT,
+	 .window_size = {.min = 15, .max = 15, .increment = 0} },
+	 RTE_COMP_END_OF_CAPABILITIES_LIST() };
+
+static struct rte_compressdev_ops qat_comp_ops_gen6 = {
+
+	/* Device related operations */
+	.dev_configure		= qat_comp_dev_config_gen4,
+	.dev_start		= qat_comp_dev_start,
+	.dev_stop		= qat_comp_dev_stop,
+	.dev_close		= qat_comp_dev_close,
+	.dev_infos_get		= qat_comp_dev_info_get,
+
+	.stats_get		= qat_comp_stats_get,
+	.stats_reset		= qat_comp_stats_reset,
+	.queue_pair_setup	= qat_comp_qp_setup,
+	.queue_pair_release	= qat_comp_qp_release,
+
+	/* Compression related operations */
+	.private_xform_create	= qat_comp_private_xform_create,
+	.private_xform_free	= qat_comp_private_xform_free,
+	.stream_create		= qat_comp_stream_create,
+	.stream_free		= qat_comp_stream_free
+};
+
+/* GEN6 specific. */
+int
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,
+			       __rte_unused const struct rte_memzone *interm_buff_mz,
+			       const struct rte_comp_xform *xform,
+			       __rte_unused const struct qat_comp_stream *stream,
+			       enum rte_comp_op_type op_type,
+			       enum qat_device_gen qat_dev_gen)
+{
+	struct icp_qat_fw_comp_req *comp_req;
+	int res;
+
+	if (unlikely(qat_xform == NULL)) {
+		QAT_LOG(ERR, "Session was not created for this device");
+		return -EINVAL;
+	}
+
+	/* Template below carries no stream state, so stateful ops would run stateless. */
+	if (unlikely(op_type == RTE_COMP_OP_STATEFUL)) {
+		QAT_LOG(ERR, "QAT GEN6 PMD does not support stateful operations");
+		return -ENOTSUP;
+	}
+
+	comp_req = &qat_xform->qat_comp_req_tmpl;
+
+	/* Initialize header */
+	if (qat_xform->qat_comp_request_type == QAT_COMP_REQUEST_FIXED_COMP_STATELESS ||
+	    qat_xform->qat_comp_request_type == QAT_COMP_REQUEST_DYNAMIC_COMP_STATELESS)
+		comp_req->comn_hdr.service_cmd_id = ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_COMP;
+	else if (qat_xform->qat_comp_request_type == QAT_COMP_REQUEST_DECOMPRESS)
+		comp_req->comn_hdr.service_cmd_id = ICP_QAT_GEN6_FW_COMP_CMD_DEFLATE_DECOMP;
+
+	comp_req->comn_hdr.service_type = ICP_QAT_FW_COMN_REQ_CPM_FW_COMP;
+
+	comp_req->comn_hdr.hdr_flags =
+	    ICP_QAT_FW_COMN_HDR_FLAGS_BUILD(ICP_QAT_FW_COMN_REQ_FLAG_SET);
+
+	comp_req->comn_hdr.serv_specif_flags = 0;
+
+	comp_req->comn_hdr.comn_req_flags = ICP_QAT_FW_COMN_FLAGS_BUILD(
+		QAT_COMN_CD_FLD_TYPE_16BYTE_DATA, QAT_COMN_PTR_TYPE_FLAT);
+
+	res = qat_comp_gen_dev_ops[qat_dev_gen].qat_comp_set_slice_cfg_word(
+			qat_xform, xform, op_type,
+			comp_req->cd_pars.sl.comp_slice_cfg_word);
+	if (res != 0)
+		return res;
+
+	comp_req->comp_pars.initial_adler = 1;
+	comp_req->comp_pars.initial_crc32 = 0;
+	comp_req->comp_pars.req_par_flags =
+		(ICP_QAT_FW_COMP_BFINAL << ICP_QAT_FW_COMP_BFINAL_BITPOS);
+
+#if RTE_LOG_DP_LEVEL >= RTE_LOG_DEBUG
+	QAT_DP_HEXDUMP_LOG(DEBUG, "qat compression message template:", comp_req,
+		    sizeof(struct icp_qat_fw_comp_req));
+#endif
+	return 0;
+}
+
+static struct qat_comp_capabilities_info
+qat_comp_cap_get_gen6(struct qat_pci_device *qat_dev __rte_unused)
+{
+	struct qat_comp_capabilities_info capa_info = {
+		.data = qat_gen6_comp_capabilities,
+		.size = sizeof(qat_gen6_comp_capabilities)
+	};
+	return capa_info;
+}
+
+RTE_INIT(qat_comp_pmd_gen6_init)
+{
+	qat_comp_gen_dev_ops[QAT_GEN6].compressdev_ops =
+			&qat_comp_ops_gen6;
+	qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_capabilities =
+			qat_comp_cap_get_gen6;
+	qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_num_im_bufs_required =
+			qat_comp_get_num_im_bufs_required_gen4;
+	qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_ram_bank_flags =
+			qat_comp_get_ram_bank_flags_gen4;
+	qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_set_slice_cfg_word =
+			qat_comp_set_slice_cfg_word_gen4;
+	qat_comp_gen_dev_ops[QAT_GEN6].qat_comp_get_feature_flags =
+			qat_comp_get_features_gen1;
+}
diff --git a/drivers/compress/qat/dev/qat_comp_pmd_gens.h b/drivers/compress/qat/dev/qat_comp_pmd_gens.h
index e329fe3e18..6a0b281abd 100644
--- a/drivers/compress/qat/dev/qat_comp_pmd_gens.h
+++ b/drivers/compress/qat/dev/qat_comp_pmd_gens.h
@@ -41,4 +41,12 @@ qat_comp_dev_config_gen4(struct rte_compressdev *dev,
 
 extern struct rte_compressdev_ops qat_comp_ops_gen1;
 
+int
+qat_comp_create_templates_gen6(struct qat_comp_xform *qat_xform,
+		const struct rte_memzone *interm_buff_mz,
+		const struct rte_comp_xform *xform,
+		const struct qat_comp_stream *stream,
+		enum rte_comp_op_type op_type,
+		enum qat_device_gen qat_dev_gen);
+
 #endif /* _QAT_COMP_PMD_GENS_H_ */
diff --git a/drivers/compress/qat/qat_comp.c b/drivers/compress/qat/qat_comp.c
index 559948a46a..35fa513631 100644
--- a/drivers/compress/qat/qat_comp.c
+++ b/drivers/compress/qat/qat_comp.c
@@ -18,6 +18,7 @@
 #include "qat_logs.h"
 #include "qat_comp.h"
 #include "qat_comp_pmd.h"
+#include "dev/qat_comp_pmd_gens.h"
 
 static void
 qat_comp_fallback_to_fixed(struct icp_qat_fw_comp_req *comp_req)
@@ -814,7 +815,7 @@ qat_comp_create_req_hdr(struct icp_qat_fw_comn_req_hdr *header,
 }
 
 static int
-qat_comp_create_templates(struct qat_comp_xform *qat_xform,
+qat_comp_create_templates_genx(struct qat_comp_xform *qat_xform,
 			  const struct rte_memzone *interm_buff_mz,
 			  const struct rte_comp_xform *xform,
 			  const struct qat_comp_stream *stream,
@@ -933,6 +934,24 @@ qat_comp_create_templates(struct qat_comp_xform *qat_xform,
 	return 0;
 }
 
+static int
+qat_comp_create_templates(struct qat_comp_xform *qat_xform,
+			  const struct rte_memzone *interm_buff_mz,
+			  const struct rte_comp_xform *xform,
+			  const struct qat_comp_stream *stream,
+			  enum rte_comp_op_type op_type,
+			  enum qat_device_gen qat_dev_gen)
+{
+	if (qat_dev_gen == QAT_GEN6)
+		return qat_comp_create_templates_gen6(qat_xform,
+			interm_buff_mz, xform, stream, op_type,
+			qat_dev_gen);
+
+	return qat_comp_create_templates_genx(qat_xform,
+			interm_buff_mz, xform, stream, op_type,
+			qat_dev_gen);
+}
+
 /**
  * Create driver private_xform data.
  *
-- 
2.52.0

