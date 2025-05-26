Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3864BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A21C940A87;
	Mon, 26 May 2025 18:59:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9126140A87
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:17 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGeWE3000522
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 jPXR9BoUUXvRwWR115cyz1xAfQsDeoixyWyl6TM1B0=; b=MTqlcHEurr1mTuHA/
 S3SO7AltdikzqxEVXkIJ9pPu+HmFR66O5dJkVkFbblfXudn/IcC6vZiEis7oN1Vf
 c4lHT5KwlW4i0epldayosBjqAbd2yFHTApfFMuUSWaIX8f3RpCNI99alReifae+s
 bl/8Zqt73WastohcnNg0zRrc7GMWwqceWizcG4miU7kW+SA1C5q1XAiLWjent5cy
 5iPB/e24egB/VVPoe06LwxQG6tDcb5Yp0FzvzG0OrxRHH4t5GKA93TNxh/l4wIt8
 N1Javt3hM6s9O2D3qO/cee0YfxDFVvA6qRH1V9T7VoTANK2e6sIYxbyS61ts8S9H
 6Z1fg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:15 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id D34CF3F7048;
 Mon, 26 May 2025 09:59:12 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 16/40] crypto/cnxk: add security session creation
Date: Mon, 26 May 2025 22:27:55 +0530
Message-ID: <20250526165819.2197892-17-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TPuIbqPskR2NsfGM9cm5WoGtMPoZcCbY
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349de4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=6DM_orCjHzrhloRL1IcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX09Js5SB+CsWT
 yWTerLGYUeYGmTVPmyimerfauesBvLaTIb8unQA1PUzzesyo0FzW1uVt9x6YqmrJwW1OCrBmv4P
 r07FwdZNN7viQAPe1vaEolqgsut9B28rGIH5J2tPiZhxKc50bpDYIT15WkpXqkuylOiN2SIQrlo
 B7TYBod1zTVB7Vtkd1wurpoNVFeUHf+/GEunAiyRLlxOr/lszppqVcEVGBUAm0hkisA+GxTwcwY
 c2ppuZxO6VfWwFuW8Akj85F2QAztr4PdfJgloEu5Bgc1jp71jfdrF6Y84Vxftw5mx8hBhbPQ3GV
 3DPTBXbxVBW9WJ/pDdO0zVWi2oPyGpOBcXLnx+xdVaS70LziyKlJrpkaZ+vkl01bna1ic1jbLyv
 8TKP6ElUPLHJ57UW8t9Ycs9Dex3bd1AHub6hxkkngVDWODnVqX4YjHccRcWSGVHSysyEDMuH
X-Proofpoint-GUID: TPuIbqPskR2NsfGM9cm5WoGtMPoZcCbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add rte security session creation for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c |  22 +-
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h |  33 +++
 drivers/crypto/cnxk/cn20k_ipsec.c         | 250 +++++++++++++++++++++-
 3 files changed, 296 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 04c8e8f506..0bb4b7db63 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -12,9 +12,25 @@ static int
 cn20k_sec_session_create(void *dev, struct rte_security_session_conf *conf,
 			 struct rte_security_session *sess)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(conf);
-	RTE_SET_USED(sess);
+	struct rte_cryptodev *crypto_dev = dev;
+	struct cnxk_cpt_vf *vf;
+	struct cnxk_cpt_qp *qp;
+
+	if (conf->action_type != RTE_SECURITY_ACTION_TYPE_LOOKASIDE_PROTOCOL)
+		return -EINVAL;
+
+	qp = crypto_dev->data->queue_pairs[0];
+	if (qp == NULL) {
+		plt_err("Setup cryptodev queue pair before creating security session");
+		return -EPERM;
+	}
+
+	vf = crypto_dev->data->dev_private;
+
+	if (conf->protocol == RTE_SECURITY_PROTOCOL_IPSEC) {
+		((struct cn20k_sec_session *)sess)->userdata = conf->userdata;
+		return cn20k_ipsec_session_create(vf, qp, &conf->ipsec, conf->crypto_xform, sess);
+	}
 
 	return -ENOTSUP;
 }
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.h b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
index 5cd0e53017..4d6dcc9670 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
@@ -16,4 +16,37 @@
 #define SEC_SESS_SIZE sizeof(struct rte_security_session)
 
 void cn20k_sec_ops_override(void);
+
+struct __rte_aligned(ROC_ALIGN) cn20k_sec_session {
+	uint8_t rte_sess[SEC_SESS_SIZE];
+
+	/** PMD private space */
+	alignas(RTE_CACHE_LINE_MIN_SIZE)
+
+	/** Pre-populated CPT inst words */
+	struct cnxk_cpt_inst_tmpl inst;
+	uint16_t max_extended_len;
+	uint16_t iv_offset;
+	uint8_t proto;
+	uint8_t iv_length;
+	union {
+		uint16_t u16;
+		struct {
+			uint8_t ip_csum;
+			uint8_t is_outbound : 1;
+		} ipsec;
+	};
+	/** Queue pair */
+	struct cnxk_cpt_qp *qp;
+	/** Userdata to be set for Rx inject */
+	void *userdata;
+
+	/**
+	 * End of SW mutable area
+	 */
+	union {
+		struct cn20k_ipsec_sa sa;
+	};
+};
+
 #endif /* __CN20K_CRYPTODEV_SEC_H__ */
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index da8f818d87..4fa3872ef9 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -20,19 +20,257 @@
 
 #include "roc_api.h"
 
+static int
+cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
+			   struct rte_security_ipsec_xform *ipsec_xfrm,
+			   struct rte_crypto_sym_xform *crypto_xfrm,
+			   struct cn20k_sec_session *sec_sess)
+{
+	union roc_ow_ipsec_outb_param1 param1;
+	struct roc_ow_ipsec_outb_sa *sa_dptr;
+	struct cnxk_ipsec_outb_rlens rlens;
+	struct cn20k_ipsec_sa *sa;
+	union cpt_inst_w4 inst_w4;
+	void *out_sa;
+	int ret = 0;
+
+	sa = &sec_sess->sa;
+	out_sa = &sa->out_sa;
+
+	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
+	sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_outb_sa), 8);
+	if (sa_dptr == NULL) {
+		plt_err("Could not allocate memory for SA dptr");
+		return -ENOMEM;
+	}
+
+	/* Translate security parameters to SA */
+	ret = cnxk_ow_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	if (ret) {
+		plt_err("Could not fill outbound session parameters");
+		goto sa_dptr_free;
+	}
+
+	RTE_SET_USED(roc_cpt);
+
+#ifdef LA_IPSEC_DEBUG
+	/* Use IV from application in debug mode */
+	if (ipsec_xfrm->options.iv_gen_disable == 1) {
+		sa_dptr->w2.s.iv_src = ROC_IE_OW_SA_IV_SRC_FROM_SA;
+		if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+			sec_sess->iv_offset = crypto_xfrm->aead.iv.offset;
+			sec_sess->iv_length = crypto_xfrm->aead.iv.length;
+		} else if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+			sec_sess->iv_offset = crypto_xfrm->cipher.iv.offset;
+			sec_sess->iv_length = crypto_xfrm->cipher.iv.length;
+		} else {
+			sec_sess->iv_offset = crypto_xfrm->auth.iv.offset;
+			sec_sess->iv_length = crypto_xfrm->auth.iv.length;
+		}
+	}
+#else
+	if (ipsec_xfrm->options.iv_gen_disable != 0) {
+		plt_err("Application provided IV not supported");
+		ret = -ENOTSUP;
+		goto sa_dptr_free;
+	}
+#endif
+
+	sec_sess->ipsec.is_outbound = 1;
+
+	/* Get Rlen calculation data */
+	ret = cnxk_ipsec_outb_rlens_get(&rlens, ipsec_xfrm, crypto_xfrm);
+	if (ret)
+		goto sa_dptr_free;
+
+	sec_sess->max_extended_len = rlens.max_extended_len;
+
+	/* pre-populate CPT INST word 4 */
+	inst_w4.u64 = 0;
+	inst_w4.s.opcode_major = ROC_IE_OW_MAJOR_OP_PROCESS_OUTBOUND_IPSEC | ROC_IE_OW_INPLACE_BIT;
+
+	param1.u16 = 0;
+
+	param1.s.ttl_or_hop_limit = ipsec_xfrm->options.dec_ttl;
+
+	/* Disable IP checksum computation by default */
+	param1.s.ip_csum_disable = ROC_IE_OW_SA_INNER_PKT_IP_CSUM_DISABLE;
+
+	if (ipsec_xfrm->options.ip_csum_enable)
+		param1.s.ip_csum_disable = ROC_IE_OW_SA_INNER_PKT_IP_CSUM_ENABLE;
+
+	/* Disable L4 checksum computation by default */
+	param1.s.l4_csum_disable = ROC_IE_OW_SA_INNER_PKT_L4_CSUM_DISABLE;
+
+	if (ipsec_xfrm->options.l4_csum_enable)
+		param1.s.l4_csum_disable = ROC_IE_OW_SA_INNER_PKT_L4_CSUM_ENABLE;
+
+	inst_w4.s.param1 = param1.u16;
+
+	sec_sess->inst.w4 = inst_w4.u64;
+
+	if (ipsec_xfrm->options.stats == 1) {
+		/* Enable mib counters */
+		sa_dptr->w0.s.count_mib_bytes = 1;
+		sa_dptr->w0.s.count_mib_pkts = 1;
+		sa_dptr->w0.s.count_glb_pkts = 1;
+		sa_dptr->w0.s.count_glb_octets = 1;
+	}
+
+	memset(out_sa, 0, sizeof(struct roc_ow_ipsec_outb_sa));
+
+	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
+	memcpy(out_sa, sa_dptr, 8);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	/* Write session using microcode opcode */
+	ret = roc_cpt_ctx_write(lf, sa_dptr, out_sa, sizeof(struct roc_ow_ipsec_outb_sa));
+	if (ret) {
+		plt_err("Could not write outbound session to hardware");
+		goto sa_dptr_free;
+	}
+
+	/* Trigger CTX flush so that data is written back to DRAM */
+	ret = roc_cpt_lf_ctx_flush(lf, out_sa, false);
+	if (ret == -EFAULT) {
+		plt_err("Could not flush outbound session");
+		goto sa_dptr_free;
+	}
+
+	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+sa_dptr_free:
+	plt_free(sa_dptr);
+
+	return ret;
+}
+
+static int
+cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
+			  struct rte_security_ipsec_xform *ipsec_xfrm,
+			  struct rte_crypto_sym_xform *crypto_xfrm,
+			  struct cn20k_sec_session *sec_sess)
+{
+	union roc_ow_ipsec_inb_param1 param1;
+	struct roc_ow_ipsec_inb_sa *sa_dptr;
+	struct cn20k_ipsec_sa *sa;
+	union cpt_inst_w4 inst_w4;
+	void *in_sa;
+	int ret = 0;
+
+	sa = &sec_sess->sa;
+	in_sa = &sa->in_sa;
+
+	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
+	sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_inb_sa), 8);
+	if (sa_dptr == NULL) {
+		plt_err("Could not allocate memory for SA dptr");
+		return -ENOMEM;
+	}
+
+	/* Translate security parameters to SA */
+	ret = cnxk_ow_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm);
+	if (ret) {
+		plt_err("Could not fill inbound session parameters");
+		goto sa_dptr_free;
+	}
+
+	sec_sess->ipsec.is_outbound = 0;
+	RTE_SET_USED(roc_cpt);
+
+	/* Save index/SPI in cookie, requirement for Rx Inject */
+	sa_dptr->w1.s.cookie = 0xFFFFFFFF;
+
+	/* pre-populate CPT INST word 4 */
+	inst_w4.u64 = 0;
+	inst_w4.s.opcode_major = ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC | ROC_IE_OW_INPLACE_BIT;
+
+	param1.u16 = 0;
+
+	/* Disable IP checksum verification by default */
+	param1.s.ip_csum_disable = ROC_IE_OW_SA_INNER_PKT_IP_CSUM_DISABLE;
+
+	/* Set the ip chksum flag in mbuf before enqueue.
+	 * Reset the flag in post process in case of errors
+	 */
+	if (ipsec_xfrm->options.ip_csum_enable) {
+		param1.s.ip_csum_disable = ROC_IE_OW_SA_INNER_PKT_IP_CSUM_ENABLE;
+		sec_sess->ipsec.ip_csum = RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+	}
+
+	/* Disable L4 checksum verification by default */
+	param1.s.l4_csum_disable = ROC_IE_OW_SA_INNER_PKT_L4_CSUM_DISABLE;
+
+	if (ipsec_xfrm->options.l4_csum_enable)
+		param1.s.l4_csum_disable = ROC_IE_OW_SA_INNER_PKT_L4_CSUM_ENABLE;
+
+	param1.s.esp_trailer_disable = 1;
+
+	inst_w4.s.param1 = param1.u16;
+
+	sec_sess->inst.w4 = inst_w4.u64;
+
+	if (ipsec_xfrm->options.stats == 1) {
+		/* Enable mib counters */
+		sa_dptr->w0.s.count_mib_bytes = 1;
+		sa_dptr->w0.s.count_mib_pkts = 1;
+		sa_dptr->w0.s.count_glb_pkts = 1;
+		sa_dptr->w0.s.count_glb_octets = 1;
+	}
+
+	memset(in_sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
+
+	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
+	memcpy(in_sa, sa_dptr, 8);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	/* Write session using microcode opcode */
+	ret = roc_cpt_ctx_write(lf, sa_dptr, in_sa, sizeof(struct roc_ow_ipsec_inb_sa));
+	if (ret) {
+		plt_err("Could not write inbound session to hardware");
+		goto sa_dptr_free;
+	}
+
+	/* Trigger CTX flush so that data is written back to DRAM */
+	ret = roc_cpt_lf_ctx_flush(lf, in_sa, true);
+	if (ret == -EFAULT) {
+		plt_err("Could not flush inbound session");
+		goto sa_dptr_free;
+	}
+
+	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+sa_dptr_free:
+	plt_free(sa_dptr);
+
+	return ret;
+}
+
 int
 cn20k_ipsec_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
 			   struct rte_crypto_sym_xform *crypto_xfrm,
 			   struct rte_security_session *sess)
 {
-	RTE_SET_USED(vf);
-	RTE_SET_USED(qp);
-	RTE_SET_USED(ipsec_xfrm);
-	RTE_SET_USED(crypto_xfrm);
-	RTE_SET_USED(sess);
+	struct roc_cpt *roc_cpt;
+	int ret;
 
-	return 0;
+	ret = cnxk_ipsec_xform_verify(ipsec_xfrm, crypto_xfrm);
+	if (ret)
+		return ret;
+
+	roc_cpt = &vf->cpt;
+
+	if (ipsec_xfrm->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS)
+		return cn20k_ipsec_inb_sa_create(roc_cpt, &qp->lf, ipsec_xfrm, crypto_xfrm,
+						 (struct cn20k_sec_session *)sess);
+	else
+		return cn20k_ipsec_outb_sa_create(roc_cpt, &qp->lf, ipsec_xfrm, crypto_xfrm,
+						  (struct cn20k_sec_session *)sess);
 }
 
 int
-- 
2.25.1

