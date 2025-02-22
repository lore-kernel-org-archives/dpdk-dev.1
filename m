Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047CDC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 08:39:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1905942D27;
	Sat, 22 Feb 2025 09:38:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C7CA42B71
 for <dev@dpdk.org>; Sat, 22 Feb 2025 09:38:52 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M7prEC020033;
 Sat, 22 Feb 2025 00:38:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 Imhj8j8p5Ig4cEyjrO4FzMo3p+hcbl1dTwz5Kn1sQc=; b=MYCWoO8fqrr4f7vFQ
 lk1344bsOBm33eL64EYufRIzfn5lUkt73KUgqb8Lx4dgn0VYtQA/F9aRjMFDf5uS
 CwJv609g36+T1MwSbpuvKRms2iVKIlH0Ds8zvEXNQa5zG4G1xyvWDa6OLtxlHDts
 UVFmu79+porJ63P9uv51Hp2qJc3QDo0+vD3enZCuVlveEf8Us1mB3hIMtTc9J59p
 Pf+GLB7og2ZbhhlizdNFK6JnR1pPblASEqLQayai2M3a2M+Nw/dOf5jI41u9jCXU
 5QGDaagoQX8QHD9CtQlohT6DeqTyIF4l8cthP/ctf2XPemBQ9btlwNf6uG6EZB1B
 te+iQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgje0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 00:38:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 00:38:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 00:38:50 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 53A055B6938;
 Sat, 22 Feb 2025 00:38:45 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v4 5/5] examples/vhost_crypto: support asymmetric crypto
Date: Sat, 22 Feb 2025 14:08:10 +0530
Message-ID: <80ac8ed50df809d22504dd8dd424eef4dc5cb8e1.1740212213.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212213.git.gmuthukrishn@marvell.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xUo-xHJOgO7CcfSHIOUVZnMEHcC8oVjW
X-Proofpoint-ORIG-GUID: xUo-xHJOgO7CcfSHIOUVZnMEHcC8oVjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
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

Support asymmetric crypto operations.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 examples/vhost_crypto/main.c | 50 +++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index b1fe4120b9..8bdfc40c4b 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -59,6 +59,7 @@ struct vhost_crypto_options {
 	uint32_t nb_los;
 	uint32_t zero_copy;
 	uint32_t guest_polling;
+	bool asymmetric_crypto;
 } options;
 
 enum {
@@ -70,6 +71,8 @@ enum {
 	OPT_ZERO_COPY_NUM,
 #define OPT_POLLING         "guest-polling"
 	OPT_POLLING_NUM,
+#define OPT_ASYM            "asymmetric-crypto"
+	OPT_ASYM_NUM,
 };
 
 #define NB_SOCKET_FIELDS	(2)
@@ -202,9 +205,10 @@ vhost_crypto_usage(const char *prgname)
 		"  --%s <lcore>,SOCKET-FILE-PATH\n"
 		"  --%s (lcore,cdev_id,queue_id)[,(lcore,cdev_id,queue_id)]\n"
 		"  --%s: zero copy\n"
-		"  --%s: guest polling\n",
+		"  --%s: guest polling\n"
+		"  --%s: asymmetric crypto\n",
 		prgname, OPT_SOCKET_FILE, OPT_CONFIG,
-		OPT_ZERO_COPY, OPT_POLLING);
+		OPT_ZERO_COPY, OPT_POLLING, OPT_ASYM);
 }
 
 static int
@@ -223,6 +227,8 @@ vhost_crypto_parse_args(int argc, char **argv)
 				NULL, OPT_ZERO_COPY_NUM},
 		{OPT_POLLING, no_argument,
 				NULL, OPT_POLLING_NUM},
+		{OPT_ASYM, no_argument,
+				NULL, OPT_ASYM_NUM},
 		{NULL, 0, 0, 0}
 	};
 
@@ -262,6 +268,10 @@ vhost_crypto_parse_args(int argc, char **argv)
 			options.guest_polling = 1;
 			break;
 
+		case OPT_ASYM_NUM:
+			options.asymmetric_crypto = true;
+			break;
+
 		default:
 			vhost_crypto_usage(prgname);
 			return -EINVAL;
@@ -376,6 +386,7 @@ vhost_crypto_worker(void *arg)
 	int callfds[VIRTIO_CRYPTO_MAX_NUM_BURST_VQS];
 	uint32_t lcore_id = rte_lcore_id();
 	uint32_t burst_size = MAX_PKT_BURST;
+	enum rte_crypto_op_type cop_type;
 	uint32_t i, j, k;
 	uint32_t to_fetch, fetched;
 
@@ -383,9 +394,13 @@ vhost_crypto_worker(void *arg)
 
 	RTE_LOG(INFO, USER1, "Processing on Core %u started\n", lcore_id);
 
+	cop_type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
+	if (options.asymmetric_crypto)
+		cop_type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
+
 	for (i = 0; i < NB_VIRTIO_QUEUES; i++) {
 		if (rte_crypto_op_bulk_alloc(info->cop_pool,
-				RTE_CRYPTO_OP_TYPE_SYMMETRIC, ops[i],
+				cop_type, ops[i],
 				burst_size) < burst_size) {
 			RTE_LOG(ERR, USER1, "Failed to alloc cops\n");
 			ret = -1;
@@ -411,12 +426,11 @@ vhost_crypto_worker(void *arg)
 						fetched);
 				if (unlikely(rte_crypto_op_bulk_alloc(
 						info->cop_pool,
-						RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+						cop_type,
 						ops[j], fetched) < fetched)) {
 					RTE_LOG(ERR, USER1, "Failed realloc\n");
 					return -1;
 				}
-
 				fetched = rte_cryptodev_dequeue_burst(
 						info->cid, info->qid,
 						ops_deq[j], RTE_MIN(burst_size,
@@ -477,6 +491,7 @@ main(int argc, char *argv[])
 	struct rte_cryptodev_qp_conf qp_conf;
 	struct rte_cryptodev_config config;
 	struct rte_cryptodev_info dev_info;
+	enum rte_crypto_op_type cop_type;
 	char name[128];
 	uint32_t i, j, lcore;
 	int ret;
@@ -539,12 +554,21 @@ main(int argc, char *argv[])
 			goto error_exit;
 		}
 
-		snprintf(name, 127, "SESS_POOL_%u", lo->lcore_id);
-		info->sess_pool = rte_cryptodev_sym_session_pool_create(name,
-				SESSION_MAP_ENTRIES,
-				rte_cryptodev_sym_get_private_session_size(
-				info->cid), 0, 0,
-				rte_lcore_to_socket_id(lo->lcore_id));
+		if (!options.asymmetric_crypto) {
+			snprintf(name, 127, "SYM_SESS_POOL_%u", lo->lcore_id);
+			info->sess_pool = rte_cryptodev_sym_session_pool_create(name,
+					SESSION_MAP_ENTRIES,
+					rte_cryptodev_sym_get_private_session_size(
+					info->cid), 0, 0,
+					rte_lcore_to_socket_id(lo->lcore_id));
+			cop_type = RTE_CRYPTO_OP_TYPE_SYMMETRIC;
+		} else {
+			snprintf(name, 127, "ASYM_SESS_POOL_%u", lo->lcore_id);
+			info->sess_pool = rte_cryptodev_asym_session_pool_create(name,
+					SESSION_MAP_ENTRIES, 0, 64,
+					rte_lcore_to_socket_id(lo->lcore_id));
+			cop_type = RTE_CRYPTO_OP_TYPE_ASYMMETRIC;
+		}
 
 		if (!info->sess_pool) {
 			RTE_LOG(ERR, USER1, "Failed to create mempool");
@@ -553,7 +577,7 @@ main(int argc, char *argv[])
 
 		snprintf(name, 127, "COPPOOL_%u", lo->lcore_id);
 		info->cop_pool = rte_crypto_op_pool_create(name,
-				RTE_CRYPTO_OP_TYPE_SYMMETRIC, NB_MEMPOOL_OBJS,
+				cop_type, NB_MEMPOOL_OBJS,
 				NB_CACHE_OBJS, VHOST_CRYPTO_MAX_IV_LEN,
 				rte_lcore_to_socket_id(lo->lcore_id));
 
@@ -567,6 +591,8 @@ main(int argc, char *argv[])
 
 		qp_conf.nb_descriptors = NB_CRYPTO_DESCRIPTORS;
 		qp_conf.mp_session = info->sess_pool;
+		if (options.asymmetric_crypto)
+			qp_conf.mp_session = NULL;
 
 		for (j = 0; j < dev_info.max_nb_queue_pairs; j++) {
 			ret = rte_cryptodev_queue_pair_setup(info->cid, j,
-- 
2.25.1

