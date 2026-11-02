Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0B606AA2A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Twh/i+Hr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C054640264;
	Mon,  2 Nov 2026 13:22:24 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 09E884003C;
 Mon,  2 Nov 2026 13:22:22 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29FDNE1926057; Mon, 2 Nov 2026 04:22:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=F/N6e2db/GWlaoJTRF/JUL5
 o28dvZWNraQ1h+eGw09k=; b=Twh/i+HrMx/6dVunP339ToP8FOYdS66DYqZ9Sp3
 53oaz2LZOV9IEw9/5d6sxg/5+Mlly0zr2Cu+oIqCO8sm8mLlFJ1C4DZfa4hcfZve
 DYT8Qu03h/DJegQ2KX8Vj12/KBbdJoaV/MAs9+xp8rZJnjYHeP2BDSPAYdrYWiN5
 wgwxGyGPMpIw3Evax+zNx/A2pp/t19AwH7FhqQSLBlArwzwGy33nVYkNyXOauA9V
 9/5p8EW6ltblx+0jIT+pQmwxuTzHoc8LKxzZElANEfjNmQr2fAJJNh1e4TkHIEnB
 KWWyjLZg7z37zEbcFJGoefu7m3wXiP5LWcBfKjvDBTr2C0Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hndpmnsa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 04:22:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 04:22:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 04:22:20 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 9445A3F7078;
 Mon,  2 Nov 2026 04:22:16 -0800 (PST)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Akhil Goyal <gakhil@marvell.com>, Vamsi Attunuru
 <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <rbhansali@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 1/5] common/cnxk: fix macsec teardown use-after-free
Date: Mon, 2 Nov 2026 17:51:49 +0530
Message-ID: <20261102122154.2611710-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VOZIDNPX c=1 sm=1 tr=0 ts=6ae8807d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=FAAhV8DvIT9rjqnw1pEA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX47nsImPNguPM
 O+nghBS+V0Yz7G3g9XvoO08LJl7spb/gosgm7uRumoZF51njZdtXhfAggNp2pcHZrYfsYRwLMdd
 R7hek16thVS+b6a+XTnSPhX3XAvyOjQ=
X-Proofpoint-ORIG-GUID: 3HIqj63_HhmRoAxzT0kOJqpluN1initt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXw6Gtiq5n2gyJ
 TXTU7FTiEFZe29Wwrtkexg2GOwNv28tVAvuPpEDFt4mOs3QjvBfEpy/onS/8w/7k4vGDOb2KjeY
 Uh+yXR5KOzq1QONEAtYIpyFSnJLuvsO63EjEpB3GmaGqwwlIYzvBKuPJYJAOzRq68mq3h/HPu/e
 FIDZlr7ph45XBSxpxr+/V+rsGrCguhX0WYAIvm8vCe1RGCMzvPF/WtRI8YoRLt6SRhU9z/lBMv7
 I9/lRj+AEzcr24n8tIFslFdEtcaugClkQTMC5wGRsSS0nfXJ8eVQepwfZ1+uO/cU8uGbkqLFEDJ
 KlmJj0W/okYNFeOyBq6Kf9i+uP5HlBIvxripgDYLuMZfHoaICbocGvQN6dCl1GxxSeXfy2crG4f
 AN1pWyBskyVUxvrB5sT8UJHUP13iFgv5CKcr9wMSW6iRXkoAcu2hZT1yKuJoQuTYFahurEPgG9u
 HHhPH9QYD+WKDZ6a6dA==
X-Proofpoint-GUID: 3HIqj63_HhmRoAxzT0kOJqpluN1initt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The idev mcs_list is walked from the mailbox interrupt thread via
roc_idev_mcs_get() and dereferenced in mcs_event_cb_process(), while
the control thread can concurrently free the mcs in roc_mcs_dev_fini().
With no lock on the list, an MCS interrupt during teardown could read
freed memory or corrupt the TAILQ mid-splice.

Add a dedicated idev mcs_lock, held across the lookup+callback in the
interrupt handler, the list insert in roc_mcs_dev_init(), and the
TAILQ_REMOVE in roc_mcs_dev_fini() (which drains any in-flight
interrupt before mcs and sa_port_map are freed). List helpers stay
lock-free to avoid recursive locking.

Fixes: f752780f30dc ("common/cnxk: add ROC MACsec initialization")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_dev.c       | 11 +++++++++--
 drivers/common/cnxk/roc_idev.c      |  1 +
 drivers/common/cnxk/roc_idev_priv.h |  1 +
 drivers/common/cnxk/roc_mcs.c       | 30 +++++++++++++++++++++--------
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/common/cnxk/roc_dev.c b/drivers/common/cnxk/roc_dev.c
index a432fb8710..6d918bf17b 100644
--- a/drivers/common/cnxk/roc_dev.c
+++ b/drivers/common/cnxk/roc_dev.c
@@ -669,15 +669,20 @@ static int
 mbox_up_handler_mcs_intr_notify(struct dev *dev, struct mcs_intr_info *info, struct msg_rsp *rsp)
 {
 	struct roc_mcs_event_desc desc = {0};
+	struct idev_cfg *idev = idev_get_cfg();
 	struct roc_mcs *mcs;
 
 	plt_base_dbg("pf:%d/vf:%d msg id 0x%x (%s) from: pf:%d/vf:%d", dev_get_pf(dev->pf_func),
 		     dev_get_vf(dev->pf_func), info->hdr.id, mbox_id2name(info->hdr.id),
 		     dev_get_pf(info->hdr.pcifunc), dev_get_vf(info->hdr.pcifunc));
 
+	if (idev == NULL)
+		goto exit;
+
+	plt_spinlock_lock(&idev->mcs_lock);
 	mcs = roc_idev_mcs_get(info->mcs_id);
 	if (!mcs)
-		goto exit;
+		goto unlock;
 
 	if (info->intr_mask) {
 		switch (info->intr_mask) {
@@ -739,12 +744,14 @@ mbox_up_handler_mcs_intr_notify(struct dev *dev, struct mcs_intr_info *info, str
 			desc.metadata.lmac_id = info->lmac_id;
 			break;
 		default:
-			goto exit;
+			goto unlock;
 		}
 
 		mcs_event_cb_process(mcs, &desc);
 	}
 
+unlock:
+	plt_spinlock_unlock(&idev->mcs_lock);
 exit:
 	rsp->hdr.rc = 0;
 	return 0;
diff --git a/drivers/common/cnxk/roc_idev.c b/drivers/common/cnxk/roc_idev.c
index 6aa5b10ee9..17b99682fd 100644
--- a/drivers/common/cnxk/roc_idev.c
+++ b/drivers/common/cnxk/roc_idev.c
@@ -45,6 +45,7 @@ idev_set_defaults(struct idev_cfg *idev)
 	TAILQ_INIT(&idev->roc_nix_list);
 	plt_spinlock_init(&idev->nix_inl_dev_lock);
 	plt_spinlock_init(&idev->npa_dev_lock);
+	plt_spinlock_init(&idev->mcs_lock);
 	__atomic_store_n(&idev->npa_refcnt, 0, __ATOMIC_RELEASE);
 }
 
diff --git a/drivers/common/cnxk/roc_idev_priv.h b/drivers/common/cnxk/roc_idev_priv.h
index dde555535b..ca47f6948e 100644
--- a/drivers/common/cnxk/roc_idev_priv.h
+++ b/drivers/common/cnxk/roc_idev_priv.h
@@ -45,6 +45,7 @@ struct idev_cfg {
 	struct idev_nix_inl_rx_inj_cfg inl_rx_inj_cfg;
 	plt_spinlock_t nix_inl_dev_lock;
 	plt_spinlock_t npa_dev_lock;
+	plt_spinlock_t mcs_lock;
 	uint8_t dma_cs_offset;
 };
 
diff --git a/drivers/common/cnxk/roc_mcs.c b/drivers/common/cnxk/roc_mcs.c
index 0ae5618c09..1b45f5dad9 100644
--- a/drivers/common/cnxk/roc_mcs.c
+++ b/drivers/common/cnxk/roc_mcs.c
@@ -839,17 +839,24 @@ struct roc_mcs *
 roc_mcs_dev_init(uint8_t mcs_idx)
 {
 	struct mcs_event_cb_list *cb_list;
+	struct idev_cfg *idev;
 	struct roc_mcs *mcs;
 	struct npa_lf *npa;
 
 	if (!(roc_feature_bphy_has_macsec() || roc_feature_nix_has_macsec()))
 		return NULL;
 
-	mcs = roc_idev_mcs_get(mcs_idx);
-	if (mcs) {
-		plt_info("Skipping device, mcs device already probed");
-		mcs->refcount++;
-		return mcs;
+	idev = idev_get_cfg();
+	if (idev) {
+		plt_spinlock_lock(&idev->mcs_lock);
+		mcs = roc_idev_mcs_get(mcs_idx);
+		if (mcs) {
+			plt_info("Skipping device, mcs device already probed");
+			mcs->refcount++;
+			plt_spinlock_unlock(&idev->mcs_lock);
+			return mcs;
+		}
+		plt_spinlock_unlock(&idev->mcs_lock);
 	}
 
 	mcs = plt_zmalloc(sizeof(struct roc_mcs), PLT_CACHE_LINE_SIZE);
@@ -870,8 +877,11 @@ roc_mcs_dev_init(uint8_t mcs_idx)
 	cb_list = (struct mcs_event_cb_list *)roc_mcs_to_mcs_cb_list(mcs);
 	TAILQ_INIT(cb_list);
 
+	idev = idev_get_cfg();
+	plt_spinlock_lock(&idev->mcs_lock);
 	roc_idev_mcs_set(mcs);
 	mcs->refcount++;
+	plt_spinlock_unlock(&idev->mcs_lock);
 
 	return mcs;
 exit:
@@ -882,12 +892,18 @@ roc_mcs_dev_init(uint8_t mcs_idx)
 void
 roc_mcs_dev_fini(struct roc_mcs *mcs)
 {
+	struct idev_cfg *idev = idev_get_cfg();
 	struct mcs_priv *priv;
 	int i;
 
+	plt_spinlock_lock(&idev->mcs_lock);
 	mcs->refcount--;
-	if (mcs->refcount > 0)
+	if (mcs->refcount > 0) {
+		plt_spinlock_unlock(&idev->mcs_lock);
 		return;
+	}
+	roc_idev_mcs_free(mcs);
+	plt_spinlock_unlock(&idev->mcs_lock);
 
 	priv = roc_mcs_to_mcs_priv(mcs);
 
@@ -902,7 +918,5 @@ roc_mcs_dev_fini(struct roc_mcs *mcs)
 
 	plt_free(mcs->sa_port_map);
 
-	roc_idev_mcs_free(mcs);
-
 	plt_free(mcs);
 }
-- 
2.43.0

