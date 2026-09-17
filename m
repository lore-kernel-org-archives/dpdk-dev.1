Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306BAC982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD94427A5;
	Thu, 17 Sep 2026 09:14:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D4151400D5;
 Thu, 17 Sep 2026 09:14:33 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H68gC4086320; Thu, 17 Sep 2026 00:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 DX9zPPJnQaIrCCEJbvjaPumgRTp40bTSr90NTEMsSU=; b=gM6Gu9Vk355LvwFD2
 AjfqdLNrAUntme/dB/zMJPjZyjZL0YnqT4mURUjFJVGNzWmPdE1fim4Xa9Soz6P4
 PL5a1Y20r0/cMhrY7q9t0HKbhRPkrkMbsmNgKjLjvvaxsRMftcH7fePjWpk0YV1h
 0S2cGJStq3pCMEC1s6W7vRb5ymklEdX6QzCrRHuDgX4ejTHMXQSE3FqMVfeu/UqW
 tEX9iGtBsYYiEArBzmK4JQBIRO5Ln8khhz5kjXShV3gfMEU3sx6XCASdt6LHftDV
 IeA+9AALTHDvvMTCu+w3vjTYg20SflT99hYGOZhRVvEN2twbTcyQkkithxSGhuoM
 8e8zg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujq6uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 00:14:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:31 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 3B1B05C68E2;
 Thu, 17 Sep 2026 00:14:26 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 06/14] common/cnxk: fix null deref and irq ack in CPT CQ
 handler
Date: Thu, 17 Sep 2026 12:40:08 +0530
Message-ID: <20260917071016.2366467-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX0QvIiFO6exRv
 Ezb0c0qVtCd02hp7qBOrdbzR42sgzGSodecLV2GkM+XAlM5CQpnhNrqtDb++gad7JQi9MfCCsyo
 KikuArMoz62yZpinMLx3DeVM9K/A4p+gUvShhLrP8GSHIt/1LgAwZSp87T3tPK/bbjGqIhU+5fB
 eoLLH5RcbmFv+/z7xiozjKr/xb7BQblk+ZVMWL5ASa3PYEtGucJm7N4J1H7f3NJSYX8Zu5qpkL/
 u5IW6/ypBWLuKd0XXszro6iO2AqDjuOsghDipDhI8Msqc7llP47Ot5lWkSCrlUK2HMl3dMpnsMo
 l/3U0xh8VXFKx1qF3TZL7Zh+gDRyPMOS84GHJzfeCoagu6E+KCb+esikqQb2RMVv9/a/ZBQhVEf
 NnAtb+8Gxu4Onw+701ADrDTd82Nlvt1Za33sRgLxkwEvUcbOEjbGQLO4/H3b9JGlkI2ktJQEFI0
 +uV5VWBOD9GepLUhpdw==
X-Proofpoint-GUID: YWCWbR-bIIOA9MbSbdoemR8M81tu4vNP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX5TFiJAMqvMZ3
 jy2t4Yefh1cfqFexilz8y4lMmLEv13MHdoO4ns5H95RVAdHBCTWR9//iYhB6ccrt8S4N3cdAxME
 uuC6rPKNyh9rRkcfnqdC/gJRrTjhjFA=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aab9358 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=eevqtdH7Ol_K10fEkBkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: YWCWbR-bIIOA9MbSbdoemR8M81tu4vNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

The CPT CQ interrupt handler (nix_inl_cpt_cq_cb) unconditionally
dereferences lf->dev->roc_nix to obtain roc_nix, nix, and port_id.
For inbound, the CPT LF belongs to the inline device which is not
an ethdev, so roc_nix is NULL and the dereference crashes.

Additionally, error paths returned without writing CPT_LF_DONE_ACK,
leaving CQ entries unacknowledged causing the completion queue to
fill up.

Fix by deferring roc_nix/nix/port_id derivation into the outbound
branch where roc_nix is valid, setting port_id to UINT32_MAX for
inbound, and routing all error paths through a common cq_ack label
that drains entries and writes CPT_LF_DONE_ACK.

Fixes: 3fdf3e53f3c4 ("common/cnxk: enable CPT CQ for inline IPsec inbound")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 48 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index afbf966f78..f99c32f30b 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -48,41 +48,57 @@ nix_inl_sso_work_cb(struct nix_inl_dev *inl_dev)
 static void
 nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 {
-	struct roc_nix *roc_nix = (struct roc_nix *)lf->dev->roc_nix;
-	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct idev_cfg *idev = idev_get_cfg();
-	uint32_t port_id = roc_nix->port_id;
 	struct nix_inl_dev *inl_dev = NULL;
 	enum nix_inl_event_type cq_type;
 	union cpt_lf_cq_base cq_base;
 	union cpt_lf_cq_ptr cq_ptr;
+	struct roc_nix *roc_nix;
 	struct cpt_cq_s *cq_s;
 	uint8_t fmt_msk = 0x3;
 	uint32_t count, head;
+	uint32_t port_id = UINT32_MAX;
 	uint32_t nq_ptr;
+	struct nix *nix;
 	uint64_t i;
 	void *sa;
 
+	/* Read CQ state early so we can always acknowledge the interrupt */
+	head = lf->cq_head;
+	cq_base.u = plt_read64(lf->rbase + CPT_LF_CQ_BASE);
+	cq_ptr.u = plt_read64(lf->rbase + CPT_LF_CQ_PTR);
+	count = cq_ptr.s.count;
+	nq_ptr = cq_ptr.s.nq_ptr;
+
 	if (idev)
 		inl_dev = idev->nix_inl_dev;
 
 	if (!inl_dev) {
 		plt_nix_dbg("Inline Device could not be detected");
-		return;
+		goto cq_ack;
 	}
 
-	head = lf->cq_head;
-	cq_base.u = plt_read64(lf->rbase + CPT_LF_CQ_BASE);
-	cq_ptr.u = plt_read64(lf->rbase + CPT_LF_CQ_PTR);
-	count = cq_ptr.s.count;
-	nq_ptr = cq_ptr.s.nq_ptr;
-
-	if (lf->dev == &inl_dev->dev)
+	if (lf->dev == &inl_dev->dev) {
+		/* Inbound: CPT LF belongs to inline device.
+		 * roc_nix is NULL here as inline dev is not an ethdev.
+		 * port_id will be derived from SA in the PMD work callback.
+		 */
 		cq_type = NIX_INL_INB_CPT_CQ;
-	else if (lf->dev == &nix->dev)
+	} else {
+		/* Outbound: CPT LF belongs to an ethdev */
+		roc_nix = (struct roc_nix *)lf->dev->roc_nix;
+		if (!roc_nix) {
+			plt_nix_dbg("CPT LF dev has no roc_nix");
+			goto cq_ack;
+		}
+		nix = roc_nix_to_nix_priv(roc_nix);
+		if (lf->dev != &nix->dev) {
+			plt_nix_dbg("CPT LF dev mismatch with nix dev");
+			goto cq_ack;
+		}
 		cq_type = NIX_INL_OUTB_CPT_CQ;
-	else
-		return;
+		port_id = roc_nix->port_id;
+	}
 
 	for (i = 0; i < count; i++) {
 		cq_s = (struct cpt_cq_s *)(uintptr_t)(((cq_base.s.addr << 7)) + (head << 5));
@@ -106,11 +122,13 @@ nix_inl_cpt_cq_cb(struct roc_cpt_lf *lf)
 		head = (head + 1) % lf->cq_size;
 	}
 
+cq_ack:
+	/* Drain unprocessed entries and acknowledge the interrupt */
+	head = (lf->cq_head + count) % lf->cq_size;
 	lf->cq_head = head;
 	if (unlikely(nq_ptr != head))
 		plt_err("CPT LF[%d] CQ head %d != NQ ptr %d", lf->lf_id, head, nq_ptr);
 
-	/* Acknowledge the number of completed requests */
 	plt_write64(count, lf->rbase + CPT_LF_DONE_ACK);
 }
 
-- 
2.34.1

