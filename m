Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8418FD9E37
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 04:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E58F40679;
	Fri, 27 Feb 2026 05:38:06 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6383740656
 for <dev@dpdk.org>; Fri, 27 Feb 2026 05:38:04 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QNonks096657 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 Z3R7UGJBS9WN86buuf461eEPu0SOEUMuLnWcf1bwJE=; b=BY2enWI6G2xhxJL0U
 OZbzREOe+xKDdyRWHSPP1gx8jGC6ck+06jn+p4WO0PYw61vlEeNagv+ES3aMDlhs
 Tg3hmg3fmTxXqr3xuEW005r/H33hsWf06vJrwAWCLaUqmt/xv7eNsstmOcof53RM
 Oc47uScpVyXrrIdoe1wyMopWWyKOMsilkCPxKC5Dr/eLH2x16JB6miV4Z+thNaiF
 9ZT8/cCQpDE7RSIXK5MnTjz/2MnYi+GiynL1UcUhoJ4pPnZbbz8fpLZq81S4Dozp
 /0dAD/4VF9gRVmDitUv4/1DrXr+GRDPKWCZTE0xHGTYOrKDJfqA1QB5bNjIa/uV/
 D3v3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cjpuhjafk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:38:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 20:38:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 20:38:02 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 22F5F3F70CE;
 Thu, 26 Feb 2026 20:37:59 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 6/8] net/cnxk: update SA context push size
Date: Fri, 27 Feb 2026 10:07:21 +0530
Message-ID: <20260227043723.1986183-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227043723.1986183-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260227043723.1986183-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ECw2hYzlkNjnfoXbKEmPQXwE8b0umhju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzMSBTYWx0ZWRfX3tmTEQN5NvhK
 vVKDaoxTzDlEoIRALZNnmjnEDXWikuyRusJVJPGhC5KHNCfhpEOED0tnwh2QPRMT1FF13S+2HWx
 vq5aaDrlmkTQ1H3FyIcncPgRNJCqyEaXhnZXISxDfKqO4RkuXINpfRuqhC7Q9DphWplpFz0kcmM
 FL0h4sC+IyojKRxA7V9zkewEi3nlxbtxh5dm/mEf45ugxWr+OH18Dj8oyGCcx65srqKxvgl9mSx
 AqmbXx/ATFOPjNRT6+MucemqF5FOwRhSHKjtVqb7mj2luDJTDxR1doaMn08DinVeay6QEcUklo8
 JdmSlhyX7rmU9fPPd/1XAHEScL6G6cszlqsg7MMaJDOTf1FEQrBfsDcNi4IfU9590o0u7UujZ4C
 K+8JnaJxLiAw4You/Xs2+9sGRS8s7tgA8d9/rRrxFla0tiUHmHqYjZaXpOjvhe8HSuIAqP2oETA
 Y0cEf5rnoC+X5qkDw8g==
X-Proofpoint-GUID: ECw2hYzlkNjnfoXbKEmPQXwE8b0umhju
X-Authority-Analysis: v=2.4 cv=f7JFxeyM c=1 sm=1 tr=0 ts=69a11fab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=QwcIpLxO80J5Nep98W0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
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

Reduce SA context push size to 128 byte for AES_GCM encryption
for CPT performance improvement on CN20k platform.
Also, corrects few macros for cn20k specific.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: SA context push size change on security session update APIs also.
Changes in v3: No change.

 drivers/net/cnxk/cn20k_ethdev_sec.c | 107 +++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index e406f0e879..eab06be68f 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -655,16 +655,71 @@ outb_dbg_iv_update(struct roc_ow_ipsec_outb_sa *outb_sa, const char *__iv_str)
 	}

 	/* Update source of IV */
-	outb_sa->w2.s.iv_src = ROC_IE_OT_SA_IV_SRC_FROM_SA;
+	outb_sa->w2.s.iv_src = ROC_IE_OW_SA_IV_SRC_FROM_SA;
 	free(iv_str);
 }

+static void
+cn20k_eth_sec_inb_sa_misc_fill(struct roc_ow_ipsec_inb_sa *sa,
+			       struct rte_security_ipsec_xform *ipsec_xfrm)
+{
+	struct roc_ow_ipsec_inb_ctx_update_reg *ctx;
+	size_t offset;
+
+	if (sa->w2.s.enc_type != ROC_IE_SA_ENC_AES_GCM)
+		return;
+
+	/* Update ctx push size for AES GCM */
+	offset = offsetof(struct roc_ow_ipsec_inb_sa, hmac_opad_ipad);
+	ctx = (struct roc_ow_ipsec_inb_ctx_update_reg *)((uint8_t *)sa + offset);
+	sa->w0.s.hw_ctx_off = offset / 8;
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+
+	if (ipsec_xfrm->life.bytes_soft_limit)
+		ctx->soft_life = ipsec_xfrm->life.bytes_soft_limit + 1;
+
+	if (ipsec_xfrm->life.packets_soft_limit)
+		ctx->soft_life = ipsec_xfrm->life.packets_soft_limit + 1;
+
+	if (ipsec_xfrm->life.bytes_hard_limit)
+		ctx->hard_life = ipsec_xfrm->life.bytes_hard_limit + 1;
+
+	if (ipsec_xfrm->life.packets_hard_limit)
+		ctx->hard_life = ipsec_xfrm->life.packets_hard_limit + 1;
+}
+
 static int
 cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_outb_sa *sa,
 				void *sa_cptr, struct rte_security_ipsec_xform *ipsec_xfrm,
 				uint32_t sa_idx)
 {
+	struct roc_ow_ipsec_outb_ctx_update_reg *ctx;
 	uint64_t *ring_base, ring_addr;
+	size_t offset;
+
+	if (sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM) {
+		offset = offsetof(struct roc_ow_ipsec_outb_sa, hmac_opad_ipad);
+		ctx = (struct roc_ow_ipsec_outb_ctx_update_reg *)((uint8_t *)sa + offset);
+		sa->w0.s.hw_ctx_off = offset / 8;
+		sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+
+		if (ipsec_xfrm->esn.value)
+			ctx->esn_val = ipsec_xfrm->esn.value - 1;
+
+		if (ipsec_xfrm->life.bytes_soft_limit)
+			ctx->soft_life = ipsec_xfrm->life.bytes_soft_limit + 1;
+
+		if (ipsec_xfrm->life.packets_soft_limit)
+			ctx->soft_life = ipsec_xfrm->life.packets_soft_limit + 1;
+
+		if (ipsec_xfrm->life.bytes_hard_limit)
+			ctx->hard_life = ipsec_xfrm->life.bytes_hard_limit + 1;
+
+		if (ipsec_xfrm->life.packets_hard_limit)
+			ctx->hard_life = ipsec_xfrm->life.packets_hard_limit + 1;
+	} else {
+		ctx = &sa->ctx;
+	}

 	if (roc_nix_inl_is_cq_ena(roc_nix))
 		goto done;
@@ -675,8 +730,8 @@ cn20k_eth_sec_outb_sa_misc_fill(struct roc_nix *roc_nix, struct roc_ow_ipsec_out
 			return -ENOTSUP;

 		ring_addr = ring_base[sa_idx >> ROC_NIX_SOFT_EXP_ERR_RING_MAX_ENTRY_LOG2];
-		sa->ctx.err_ctl.s.mode = ROC_IE_OT_ERR_CTL_MODE_RING;
-		sa->ctx.err_ctl.s.address = ring_addr >> 3;
+		ctx->err_ctl.s.mode = ROC_IE_OW_ERR_CTL_MODE_RING;
+		ctx->err_ctl.s.address = ring_addr >> 3;
 		sa->w0.s.ctx_id = ((uintptr_t)sa_cptr >> 51) & 0x1ff;
 	}
 done:
@@ -751,7 +806,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		uintptr_t sa;

 		PLT_STATIC_ASSERT(sizeof(struct cn20k_inb_priv_data) <
-				  ROC_NIX_INL_OT_IPSEC_INB_SW_RSVD);
+				  ROC_NIX_INL_OW_IPSEC_INB_SW_RSVD);

 		spi_mask = roc_nix_inl_inb_spi_range(nix, inl_dev, NULL, NULL);

@@ -796,6 +851,8 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 			goto err;
 		}

+		cn20k_eth_sec_inb_sa_misc_fill(inb_sa_dptr, ipsec);
+
 		inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(inb_sa);
 		/* Back pointer to get eth_sec */
 		inb_priv->eth_sec = eth_sec;
@@ -856,7 +913,7 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		uint32_t sa_idx;

 		PLT_STATIC_ASSERT(sizeof(struct cn20k_outb_priv_data) <
-				  ROC_NIX_INL_OT_IPSEC_OUTB_SW_RSVD);
+				  ROC_NIX_INL_OW_IPSEC_OUTB_SW_RSVD);

 		/* Alloc an sa index */
 		rc = cnxk_eth_outb_sa_idx_get(dev, &sa_idx, ipsec->spi);
@@ -1065,6 +1122,9 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		rc = cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
 		if (rc)
 			return -EINVAL;
+
+		cn20k_eth_sec_inb_sa_misc_fill(inb_sa_dptr, ipsec);
+
 		/* Use cookie for original data */
 		inb_sa_dptr->w1.s.cookie = inb_sa->w1.s.cookie;

@@ -1096,6 +1156,14 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 		if (rc)
 			return -EINVAL;

+		/* Fill outbound sa misc params */
+		rc = cn20k_eth_sec_outb_sa_misc_fill(&dev->nix, outb_sa_dptr, outb_sa, ipsec,
+						     eth_sec->sa_idx);
+		if (rc) {
+			plt_err("Failed to init outb sa misc params, rc=%d", rc);
+			return rc;
+		}
+
 		/* Save rlen info */
 		cnxk_ipsec_outb_rlens_get(rlens, ipsec, crypto);

@@ -1138,6 +1206,7 @@ cn20k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
 	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct cnxk_eth_sec_sess *eth_sec;
+	size_t offset;
 	int rc;

 	eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, sess);
@@ -1152,11 +1221,31 @@ cn20k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
 	stats->protocol = RTE_SECURITY_PROTOCOL_IPSEC;

 	if (eth_sec->inb) {
-		stats->ipsec.ipackets = ((struct roc_ow_ipsec_inb_sa *)eth_sec->sa)->ctx.mib_pkts;
-		stats->ipsec.ibytes = ((struct roc_ow_ipsec_inb_sa *)eth_sec->sa)->ctx.mib_octs;
+		struct roc_ow_ipsec_inb_sa *sa = (struct roc_ow_ipsec_inb_sa *)eth_sec->sa;
+		struct roc_ow_ipsec_inb_ctx_update_reg *ctx;
+
+		if (sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM) {
+			offset = offsetof(struct roc_ow_ipsec_inb_sa, hmac_opad_ipad);
+			ctx = (struct roc_ow_ipsec_inb_ctx_update_reg *)((uint8_t *)sa + offset);
+		} else {
+			ctx = &sa->ctx;
+		}
+
+		stats->ipsec.ipackets = ctx->mib_pkts;
+		stats->ipsec.ibytes = ctx->mib_octs;
 	} else {
-		stats->ipsec.opackets = ((struct roc_ow_ipsec_outb_sa *)eth_sec->sa)->ctx.mib_pkts;
-		stats->ipsec.obytes = ((struct roc_ow_ipsec_outb_sa *)eth_sec->sa)->ctx.mib_octs;
+		struct roc_ow_ipsec_outb_sa *sa = (struct roc_ow_ipsec_outb_sa *)eth_sec->sa;
+		struct roc_ow_ipsec_outb_ctx_update_reg *ctx;
+
+		if (sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM) {
+			offset = offsetof(struct roc_ow_ipsec_outb_sa, hmac_opad_ipad);
+			ctx = (struct roc_ow_ipsec_outb_ctx_update_reg *)((uint8_t *)sa + offset);
+		} else {
+			ctx = &sa->ctx;
+		}
+
+		stats->ipsec.opackets = ctx->mib_pkts;
+		stats->ipsec.obytes = ctx->mib_octs;
 	}

 	return 0;
--
2.34.1

