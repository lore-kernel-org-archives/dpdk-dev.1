Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AF606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WUmnZ8Uh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 527AA402C4;
	Fri, 27 Nov 2026 16:09:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 6FB1A402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 16:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795792184; x=1827328184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BG6CHzXjRETAug+vEqHupE6+oc0Y4eOwe11kPjU4Apc=;
 b=WUmnZ8UhD6zHVQSBr3dPzi2o/JhYO2Yma66wIHkukuKGNizTN+eK7/MF
 PnoC97fUovd7TPYHBeTHg2CjLZ2rWC+5jx4OhvX/SqMd1zH8XoX4FOOyU
 mBkA5/QizkGhVz4swjU/UhGwt9py5tcbBaQOBIhtUYRwHScP/o2FJudj7
 xmZWDwApaWtsgPsA6Vs+KFliOSqSvPISQgUlZeXK4YGAfEFg++jvOwwnT
 D53Nzcc75KFWBmxKd9Sd9FMSKpjEZSJ9AW9E6pnYwLPvB75WWzvVeWLlN
 T07KjmjVL0H84eOK1M61gTOjVMZG4kWOoZIWMQpJRwg24UD7CCsAt0l3j w==;
X-CSE-ConnectionGUID: fS+88c5WSUiz1rddwGrUMw==
X-CSE-MsgGUID: GoIKXdBaR42CGhNVxhlSYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4666701"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4666701"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 07:09:42 -0800
X-CSE-ConnectionGUID: BUN5YytiSHW0+qi8ll9j5Q==
X-CSE-MsgGUID: F7NSppviRR2Yek6a02WFxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12651447"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa003.fm.intel.com with ESMTP; 27 Nov 2026 07:09:40 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH v2] compress/qat: add Gen 6 support
Date: Fri, 27 Nov 2026 15:08:47 +0000
Message-ID: <20261127150938.3658267-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110151529.2966094-1-radu.nicolau@intel.com>
References: <20261110151529.2966094-1-radu.nicolau@intel.com>
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
Acked-by: Kai Ji <kai.ji@intel.com>
---
v2: updated target version to 27.03

 doc/guides/compressdevs/qat_comp.rst         |   1 +
 doc/guides/cryptodevs/qat.rst                |   2 +-
 doc/guides/rel_notes/release_27_03.rst       |   3 +
 drivers/common/qat/meson.build               |   1 +
 drivers/common/qat/qat_adf/icp_qat_fw_comp.h |   5 +
 drivers/compress/qat/dev/qat_comp_pmd_gen6.c | 135 +++++++++++++++++++
 drivers/compress/qat/dev/qat_comp_pmd_gens.h |   8 ++
 drivers/compress/qat/qat_comp.c              |  21 ++-
 8 files changed, 174 insertions(+), 2 deletions(-)
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
diff --git a/doc/guides/rel_notes/release_27_03.rst b/doc/guides/rel_notes/release_27_03.rst
index a91813faca..5b4174db3f 100644
--- a/doc/guides/rel_notes/release_27_03.rst
+++ b/doc/guides/rel_notes/release_27_03.rst
@@ -54,6 +54,9 @@ New Features
      This section is a comment. Do not overwrite or remove it.
      Also, make sure to start the actual text at the margin.
      =======================================================
+* **Updated Intel QuickAssist Technology (QAT) compression driver.**
+
+  * Added support for Gen 6 QAT devices.
 
 
 Removed Items
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

