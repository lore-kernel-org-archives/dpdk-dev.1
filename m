Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303A3FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5734066D;
	Thu, 30 Apr 2026 12:31:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7093540664
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777545108; x=1809081108;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DC+sANEwe4NQEhWaw7WQWExqBcIp/Zm0iDTgrzh4HCI=;
 b=XPpnMKaC4Fqy0aIwuVmkSQTOV31WfsaAvWzy8uEbickAn7gKlCE3LSY9
 AOKhpNLOqHF1hYk/U0kTLU75MV3S+smGdazjgSRHBQojR+sM5LSlHiQor
 ToFApBhNGGkjYN43fcEU7vosX+j9l0DmguyR3gniEtlCQiqOkJXkN5jnN
 VQ+PPkyvKsSu/nenZ4ETaIb8TClRgSJuDzI8Fa3RS8Lp5rDqW/qUt1BhR
 pOQqXQmbEbD9BqkkTZN2Tipf4KDw0WkUCM+ZCuiopeNqDffZWEydQaDxg
 wEpXHOlK74IKR5ti9eQH/P5ZuMhIwO/3Pj+g1xu1ynmnczAT9wkCbHlzp A==;
X-CSE-ConnectionGUID: kP+5IrVTRhq85PMbpqaOFQ==
X-CSE-MsgGUID: HaXRzfYHQfiEN1EOpKmlZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82097490"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82097490"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 03:31:47 -0700
X-CSE-ConnectionGUID: xAfskFMfTBSLzcL0KeK30w==
X-CSE-MsgGUID: ho+A5gR4S0Geu39rVVQw5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234584376"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 30 Apr 2026 03:31:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 3/4] net/iavf: implement flow dump
Date: Thu, 30 Apr 2026 11:31:40 +0100
Message-ID: <b466d5aa5cdc33aa1aa2770a111eac2f40cfb8d6.1777545092.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
References: 
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

Implement flow dumping API.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c         |  2 +
 drivers/net/intel/iavf/iavf_fsub.c         |  2 +
 drivers/net/intel/iavf/iavf_generic_flow.c | 77 ++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_generic_flow.h |  2 +
 drivers/net/intel/iavf/iavf_hash.c         |  2 +
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  2 +
 6 files changed, 87 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 9eae874800..ee63d082d0 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -437,7 +437,9 @@ static struct iavf_flow_engine iavf_fdir_engine = {
 	.create = iavf_fdir_create,
 	.destroy = iavf_fdir_destroy,
 	.validation = iavf_fdir_validation,
+	.name = "fdir",
 	.type = IAVF_FLOW_ENGINE_FDIR,
+	.rule_size = sizeof(struct iavf_fdir_conf),
 };
 
 static int
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index a00d02ded5..f08a8ae726 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -730,7 +730,9 @@ iavf_flow_engine iavf_fsub_engine = {
 	.create = iavf_fsub_create,
 	.destroy = iavf_fsub_destroy,
 	.validation = iavf_fsub_validation,
+	.name = "fsub",
 	.type = IAVF_FLOW_ENGINE_FSUB,
+	.rule_size = sizeof(struct iavf_fsub_conf),
 };
 
 static struct
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 42ecc90d1d..803bc913bd 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -17,6 +17,7 @@
 
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include <rte_hexdump.h>
 
 static struct iavf_engine_list engine_list =
 		TAILQ_HEAD_INITIALIZER(engine_list);
@@ -39,6 +40,10 @@ static int iavf_flow_query(struct rte_eth_dev *dev,
 		const struct rte_flow_action *actions,
 		void *data,
 		struct rte_flow_error *error);
+static int iavf_flow_dev_dump(struct rte_eth_dev *dev,
+		struct rte_flow *flow,
+		FILE *file,
+		struct rte_flow_error *error);
 
 const struct rte_flow_ops iavf_flow_ops = {
 	.validate = iavf_flow_validate,
@@ -46,6 +51,7 @@ const struct rte_flow_ops iavf_flow_ops = {
 	.destroy = iavf_flow_destroy,
 	.flush = iavf_flow_flush,
 	.query = iavf_flow_query,
+	.dev_dump = iavf_flow_dev_dump,
 };
 
 /* raw */
@@ -2418,3 +2424,74 @@ iavf_flow_query(struct rte_eth_dev *dev,
 	}
 	return ret;
 }
+
+#define IAVF_FLOW_DUMP_CHUNK_BYTES 32
+
+static void
+iavf_flow_dump_blob(FILE *file, const char *engine,
+		    const void *data, size_t data_len)
+{
+	const uint8_t *raw = (const uint8_t *)data;
+	const size_t nchunks =
+		(data_len + IAVF_FLOW_DUMP_CHUNK_BYTES - 1) /
+		IAVF_FLOW_DUMP_CHUNK_BYTES;
+	char title[64];
+	size_t ci;
+
+	fprintf(file, "FLOW DUMP: driver=iavf engine=%s\n", engine);
+	fprintf(file, "FLOW DUMP: DATA size=%zu chunks=%zu chunk_bytes=%d\n",
+		data_len, nchunks, IAVF_FLOW_DUMP_CHUNK_BYTES);
+
+	for (ci = 0; ci < nchunks; ci++) {
+		const size_t off = ci * IAVF_FLOW_DUMP_CHUNK_BYTES;
+		const size_t clen =
+			RTE_MIN((size_t)IAVF_FLOW_DUMP_CHUNK_BYTES,
+				data_len - off);
+		snprintf(title, sizeof(title), "FLOW DUMP: chunk %03zu/%03zu",
+			 ci + 1, nchunks);
+		rte_memdump(file, title, raw + off, clen);
+	}
+}
+
+static int
+iavf_flow_dev_dump(struct rte_eth_dev *dev,
+		   struct rte_flow *flow,
+		   FILE *file,
+		   struct rte_flow_error *error)
+{
+	struct iavf_adapter *ad =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+	struct rte_flow *f;
+	bool found = false;
+
+	rte_spinlock_lock(&vf->flow_ops_lock);
+	TAILQ_FOREACH(f, &vf->flow_list, node) {
+		size_t rule_size = 0;
+		const void *rule_data = NULL;
+
+		if (flow != NULL && f != flow)
+			continue;
+
+		found = true;
+		if (f->engine != NULL) {
+			rule_size = f->engine->rule_size;
+			if (f->rule != NULL)
+				rule_data = f->rule;
+		}
+
+		if (f->engine != NULL)
+			iavf_flow_dump_blob(file,
+				f->engine->name != NULL ?
+					f->engine->name : "unknown",
+				rule_data, rule_size);
+	}
+	rte_spinlock_unlock(&vf->flow_ops_lock);
+
+	if (flow != NULL && !found)
+		return rte_flow_error_set(error, ENOENT,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Flow not found");
+
+	return 0;
+}
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index b97cf8b7ff..1b87c486d5 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -495,7 +495,9 @@ struct iavf_flow_engine {
 	engine_destroy_t destroy;
 	engine_query_t query_count;
 	engine_free_t free;
+	const char *name;
 	enum iavf_flow_engine_type type;
+	size_t rule_size;
 };
 
 TAILQ_HEAD(iavf_engine_list, iavf_flow_engine);
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index cb10eeab78..8bf5d106b1 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -682,7 +682,9 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.destroy = iavf_hash_destroy,
 	.uninit = iavf_hash_uninit_parser,
 	.free = iavf_hash_free,
+	.name = "hash",
 	.type = IAVF_FLOW_ENGINE_HASH,
+	.rule_size = sizeof(struct virtchnl_rss_cfg),
 };
 
 /* Register parser for comms package. */
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 47102e75f2..75da9f6413 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1942,7 +1942,9 @@ static struct iavf_flow_engine iavf_ipsec_flow_engine = {
 	.uninit = iavf_ipsec_flow_uninit,
 	.create = iavf_ipsec_flow_create,
 	.destroy = iavf_ipsec_flow_destroy,
+	.name = "ipsec_crypto",
 	.type = IAVF_FLOW_ENGINE_IPSEC_CRYPTO,
+	.rule_size = sizeof(struct iavf_ipsec_flow_item),
 };
 
 static int
-- 
2.47.3

