Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD90CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725CD40B90;
	Mon, 19 Oct 2026 15:08:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C87854067B
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:45 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8O18V288031 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 dbAcXCJzEZnbQGvy1FIcT46QnNWa1emJHe/LFe79tw=; b=Lod/I3KwA/J/Jqu7Q
 toKiXEoUBA2xS4D9prrDn/u+npqUJQkkx2oOsrYvcKdr/soaD3eMM4jtU243Q9fD
 zCwYaoPCwTC+BPk12KPWBabG731QQ2neCFXt65oiEgPLPd7SuI22e5T4BSAIhZB7
 F7sI8HsOnq5VPoZJpw+Eh5HcfOSH6NHYtxR5Kx6Vt0MDaDhJwe0dp5SijKRkhD3S
 xseMREudpdWGoHkWQpaVFXi60ijOLk0nMvN4sakxxAFs3mGx9/bEzLuuHTO+IYPk
 KEObnDOxg+hcElA4DpjSwmmdjnH9xIRBOO+mEvnUP/bcJ3zvsE1il1xXrYs23ebk
 clKdA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hcss7b555-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:44 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 054FB3F704D;
 Mon, 19 Oct 2026 06:08:41 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 15/16] crypto/cnxk: add cq_ena devarg for CPT CQ mode
Date: Mon, 19 Oct 2026 18:37:56 +0530
Message-ID: <20261019130759.2181566-16-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RdAFmFtv c=1 sm=1 tr=0 ts=6ad6165d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=svVPj3fh9E0r5xnMiQ0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2ScmVbKjWbUX
 w3ZzrnCPRW+LSmEcb3EqieQJZSPyS6GqsyGJZqViYAoqZnGpSsiXkRIlSio9uY4dNDAW2utroz3
 tKQ6u8Wbbi9IE3QSBRKGviJr1OVc4SE=
X-Proofpoint-ORIG-GUID: JwGFPAfmYySA0KAL_iH96RQpIVth5lP9
X-Proofpoint-GUID: JwGFPAfmYySA0KAL_iH96RQpIVth5lP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX51kTXFH7d0sn
 lHqG5X/vG5HEZgWrggRtY8139G0kK6pehw3hQPDoR6D/ejidxHZj54ZUnyjNUBhKDJBj+i3PNg8
 Ov+3NI8uIyVIs8FEukDtrF4RTfOt2qx+CwzUCcIUCmL8Pb2pOy1uSxjAs38rJnLNEFpNCzEOnlX
 07SQW25liRuw9Rc0Dmw4RT6qG1DR2cZSKTi5sKV3E9scOtYrcjklck+lVDLHWRd+2SgoGUaC+J/
 Q7iCShpit3r1ZDnl0zX+SPxNrgtYmwxvNXd50Q7ZvdQiv41Ep3UHGInJLRNA7zmZ4fXDyysfosh
 ELGrvBDJtHa0HAaKuzgscEXUQIMwn9jyc6mPEUx1/lLKv788/BerPYAv7xG4V2CuHPqySpJ/I4o
 TN/Li3OQYsnAWYXp1cQJhP/5Z5QLnoMEdxDipCOWSFf6rWAcIzb4ZyJPWpULQINwvRfAw5EjtmS
 4pKPqm0GQ6d7iWoZTOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

Add a cq_ena devarg (0 or 1, default 0) to control whether the CPT
completion queue is used on CN20K crypto queue pairs. When set to
0, completions are written to res_addr. When set to 1, completions
are reported through the CPT CQ for all instructions.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 doc/guides/cryptodevs/cnxk.rst               | 16 +++++++++++
 drivers/common/cnxk/roc_cpt.c                | 10 ++++---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c    |  2 +-
 drivers/crypto/cnxk/cnxk_cryptodev.h         |  1 +
 drivers/crypto/cnxk/cnxk_cryptodev_devargs.c | 28 +++++++++++++++++++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c     |  3 ++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h     |  2 ++
 7 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/doc/guides/cryptodevs/cnxk.rst b/doc/guides/cryptodevs/cnxk.rst
index c0392f4f9c..3c90a12dca 100644
--- a/doc/guides/cryptodevs/cnxk.rst
+++ b/doc/guides/cryptodevs/cnxk.rst
@@ -211,6 +211,22 @@ Runtime Config Options
   With the above configuration, CPT initial context fetch size
   will be set to ``4+1`` 128 bytes blocks.
 
+- ``CPT completion queue enable`` (default ``0``)
+
+  Controls whether the CPT completion queue (CQ) is used for all instructions
+  on CN20K. Can be configured during runtime by using ``cq_ena`` ``devargs``
+  parameter. Accepted values are ``0`` and ``1``.
+
+  When set to ``1``, completions of all instructions are reported through the
+  CQ. When set to ``0``, completions are written to the result address
+  (``res_addr``) of the instruction instead.
+
+  For example::
+
+      -a 0002:20:00.1,cq_ena=1
+
+  With the above configuration, CPT completions are reported through the CPT CQ.
+
 Debugging Options
 -----------------
 
diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index eae3f134e9..645c205480 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -704,10 +704,12 @@ cpt_lf_cq_init(struct roc_cpt_lf *lf)
 	/* Disable CPT completion queue */
 	roc_cpt_cq_disable(lf);
 
-	/* Set completion queue (CQ) base address */
-	len = lf->cq_size;
-	if (roc_model_is_cn20k() && lf->cq_all)
-		len++;
+	/* Set completion queue (CQ) base address.
+	 * On CN20K the pending-queue pointer (req_queue) is always positioned
+	 * at cq_vaddr + 1 entry so that the hardware-managed reserved slot
+	 * sits at cq_vaddr[0].  Allocate the extra entry unconditionally.
+	 */
+	len = lf->cq_size + 1;
 	len = PLT_ALIGN(len * (ROC_CPT_CQ_ENTRY_SIZE_UNIT << lf->cq_entry_size), ROC_ALIGN);
 	lf->cq_vaddr = plt_zmalloc(len, ROC_ALIGN);
 	if (lf->cq_vaddr == NULL)
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index bb3384023f..c654dbf88d 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -261,7 +261,7 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	}
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	inst[0].cq_ena = 1;
+	inst[0].cq_ena = qp->inst_cq_ena;
 	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), res.u64[0],
 				  rte_memory_order_relaxed);
 	infl_req->cop = op;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev.h b/drivers/crypto/cnxk/cnxk_cryptodev.h
index bdc5752905..4ce2cb255a 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev.h
@@ -39,6 +39,7 @@ struct cnxk_cpt_vf {
 	uint16_t max_qps_limit;
 	uint16_t rx_inject_qp;
 	uint8_t ctx_ilen;
+	bool cq_ena;
 };
 
 uint64_t cnxk_cpt_default_ff_get(void);
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c b/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
index 3623e5aa76..ff0ddb6ed8 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_devargs.c
@@ -14,6 +14,7 @@
 #define CNXK_RX_INJECT_QP      "rx_inject_qp"
 #define CNXK_CPT_CTX_ILEN      "ctx_ilen"
 #define CNXK_MAX_CPT_CTX_ILEN  7
+#define CNXK_CPT_CQ_ENA	       "cq_ena"
 
 static int
 parse_rx_inject_qp(const char *key, const char *value, void *extra_args)
@@ -82,6 +83,21 @@ parse_cpt_ctx_ilen(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
+static int
+parse_cpt_cq_ena(const char *key, const char *value, void *extra_args)
+{
+	RTE_SET_USED(key);
+	uint32_t val;
+
+	val = atoi(value);
+	if (val > 1)
+		return -EINVAL;
+
+	*(bool *)extra_args = val ? true : false;
+
+	return 0;
+}
+
 int
 cnxk_cpt_parse_devargs(struct rte_devargs *devargs, struct cnxk_cpt_vf *vf)
 {
@@ -89,6 +105,7 @@ cnxk_cpt_parse_devargs(struct rte_devargs *devargs, struct cnxk_cpt_vf *vf)
 	struct rte_kvargs *kvlist;
 	uint16_t rx_inject_qp;
 	uint16_t ctx_ilen = 0;
+	bool cq_ena = false;
 	int rc;
 
 	/* Set to max value as default so that the feature is disabled by default. */
@@ -126,16 +143,25 @@ cnxk_cpt_parse_devargs(struct rte_devargs *devargs, struct cnxk_cpt_vf *vf)
 		goto exit;
 	}
 
+	rc = rte_kvargs_process(kvlist, CNXK_CPT_CQ_ENA, parse_cpt_cq_ena, &cq_ena);
+	if (rc < 0) {
+		plt_err("cq_ena should be 0 or 1");
+		rte_kvargs_free(kvlist);
+		goto exit;
+	}
+
 	rte_kvargs_free(kvlist);
 
 null_devargs:
 	vf->max_qps_limit = max_qps_limit;
 	vf->rx_inject_qp = rx_inject_qp;
 	vf->cpt.ctx_ilen = ctx_ilen;
+	vf->cq_ena = cq_ena;
 	return 0;
 
 exit:
 	return -EINVAL;
 }
 
-RTE_PMD_REGISTER_PARAM_STRING(crypto_cnxk, CNXK_MAX_QPS_LIMIT "=<1-63>");
+RTE_PMD_REGISTER_PARAM_STRING(crypto_cnxk, CNXK_MAX_QPS_LIMIT "=<1-63> " CNXK_CPT_CQ_ENA
+							      "=<0-1> " CNXK_CPT_CTX_ILEN "=<0-7>");
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 95f64a79ae..a5b8aff146 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -535,7 +535,8 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		/* CQ entry size is 128B(32 << 2) */
 		qp->lf.cq_entry_size = 2;
 		qp->lf.cq_size = nb_desc;
-		qp->lf.cq_all = true;
+		qp->lf.cq_all = vf->cq_ena;
+		qp->inst_cq_ena = vf->cq_ena;
 	}
 
 	ret = roc_cpt_lf_init(roc_cpt, &qp->lf);
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 7bf26d67dc..6c4265f339 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -108,6 +108,8 @@ struct crypto_adpter_info {
 struct cnxk_cpt_qp {
 	struct roc_cpt_lf lf;
 	/**< Crypto LF */
+	bool inst_cq_ena;
+	/**< Set CQ enable bit on instructions */
 	struct pending_queue pend_q;
 	/**< Pending queue */
 	struct roc_cpt_lmtline lmtline;
-- 
2.43.0

