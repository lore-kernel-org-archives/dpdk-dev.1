Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5EC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7522A4278E;
	Thu, 17 Sep 2026 09:10:50 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D57C74278E;
 Thu, 17 Sep 2026 09:10:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60BVU2202649; Thu, 17 Sep 2026 00:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 19cC2OqE3Nif6RIWZ1Jsg7O7TORmEdSbKxDh24WQwE=; b=QOyKJt+yWoFjhkn/Q
 q7gFYnfcb5GKqGtKYTpgCB/WCSYXieoTPnG1l4chiiO+AKcZ2JQmFZcEyjoaFCY0
 ftTvWMXZgvW4HBB2X+sHQbNw6e1rLqbggjQVNgU1b0FW/YtlHbLg/uyBK1zuc8h4
 3xh0tdoAm6MjvHAQEXiDy8NgiYAXChMGfJf8xBVws92SuPkomCzyzegeOzhtjZSx
 CYBjvmiII8jF5ALpf4LlTN6sssApyyR4sBCrEqiZEKgsZ5n//Q4snojf/yO93ay+
 Hl7FcZdCq36p5GPMVfOLrCVKf/QOs8p2hjqZRMC9z70wVeQ8TT2I5heHfx5/hAs9
 yzd8Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5ygdkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 00:10:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:10:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:10:47 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 9EE505C68E2;
 Thu, 17 Sep 2026 00:10:43 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 03/14] common/cnxk: fix NIX QINT count reset
Date: Thu, 17 Sep 2026 12:40:05 +0530
Message-ID: <20260917071016.2366467-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfXwNCCPMlzD7Io
 9t/bnEw+3iGTwWe2LbcKFZN7wS+Kgbzt52klfo3sTb8x10YLSqDmhrRELlXReYDyce4T4x9Vadf
 x/fYfhM8kYzARnks+ZeiTk44rVXN1Z0=
X-Proofpoint-GUID: k3vud--nSlN1NQidaacda9l6pe6hLGJl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfXzpZVRpLdTMXU
 2iag8jA//CYEzZnOKfeb05MjJvzBk4nR8VyJviFczbM6OY9HSpuqXAcod8W48eLpO2idLkPZSmh
 AtCE3JMAFv3N5i8waxsC667iEG2QHEq951ogYUS/QNYyBju6Drrk4/18FktBk644WygmSlcIP85
 7Ol7w6x47oaWe3XHuKPoGG6nGiBq9W0M+J3guvXFabVFf/GCaKV6EnAx0Jj7UC3qHR/ITgrlsad
 BsB037YUXoQg5Zpw5yXw9py1klofgtYYl2QyK19ULG2fmJMsj0bORJBuaYU8SYn1tA/LnLcMfk1
 QlYNc1xpewpFv6ONyLIMiG3E7731OXTNqc1OcA7cpfVTKKFwCs6ptz7utPrBxqWB9P+lYU94RwK
 JZcz+a6vbbWxGNxH0d05gabhHW6L3u2ApnChQ7BOUb38juss9JfIn/bh8eYxyQLv99pmEDQ3qEU
 2buwHYG/kOT0qBTXduw==
X-Proofpoint-ORIG-GUID: k3vud--nSlN1NQidaacda9l6pe6hLGJl
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9277 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=-v0yPzLholfQ3jWOHdAA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Fix QINT count reset on NIX queue IRQs register and
unregister.
Queue interrupt will be cleared by individual queue
interrupt operation register update.

Fixes: f6d567b03d28 ("common/cnxk: support NIX IRQ")
Fixes: 3c100e0e6b9c ("common/cnxk: support per-port RQ in inline device")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev_irq.c | 21 ++++++++++++---------
 drivers/common/cnxk/roc_nix_irq.c         | 12 ++++++------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev_irq.c b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
index 30986e780a..afbf966f78 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev_irq.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev_irq.c
@@ -396,6 +396,7 @@ nix_inl_nix_register_irqs(struct nix_inl_dev *inl_dev)
 	struct nix_inl_qint *qints_mem;
 	int rc, q, ret = 0;
 	uint16_t msixoff;
+	uint64_t cnt;
 	int qints;
 
 	msixoff = inl_dev->nix_msixoff;
@@ -434,8 +435,10 @@ nix_inl_nix_register_irqs(struct nix_inl_dev *inl_dev)
 
 	for (q = 0; q < qints; q++) {
 		/* Clear QINT CNT, interrupt */
-		plt_write64(0, nix_base + NIX_LF_QINTX_CNT(q));
 		plt_write64(~0ull, nix_base + NIX_LF_QINTX_ENA_W1C(q));
+		cnt = plt_read64(nix_base + NIX_LF_QINTX_CNT(q));
+		plt_write64((uint64_t)(-(int64_t)cnt), nix_base + NIX_LF_QINTX_CNT(q));
+		plt_write64(~0ull, nix_base + NIX_LF_QINTX_INT(q));
 
 		/* Register queue irq vector */
 		ret = dev_irq_register(handle, nix_inl_nix_q_irq, &qints_mem[q],
@@ -443,9 +446,7 @@ nix_inl_nix_register_irqs(struct nix_inl_dev *inl_dev)
 		if (ret)
 			break;
 
-		plt_write64(0, nix_base + NIX_LF_QINTX_CNT(q));
-		plt_write64(0, nix_base + NIX_LF_QINTX_INT(q));
-		/* Enable QINT interrupt */
+		/* Enable QINT interrupt (count/INT already drained above) */
 		plt_write64(~0ull, nix_base + NIX_LF_QINTX_ENA_W1S(q));
 
 		qints_mem[q].inl_dev = inl_dev;
@@ -463,6 +464,7 @@ nix_inl_nix_unregister_irqs(struct nix_inl_dev *inl_dev)
 	struct nix_inl_qint *qints_mem = inl_dev->qints_mem;
 	uintptr_t nix_base = inl_dev->nix_base;
 	uint16_t msixoff;
+	uint64_t cnt;
 	int q;
 
 	msixoff = inl_dev->nix_msixoff;
@@ -477,17 +479,18 @@ nix_inl_nix_unregister_irqs(struct nix_inl_dev *inl_dev)
 			   msixoff + NIX_LF_INT_VEC_POISON);
 
 	for (q = 0; q < inl_dev->configured_qints; q++) {
-		/* Clear QINT CNT */
-		plt_write64(0, nix_base + NIX_LF_QINTX_CNT(q));
-		plt_write64(0, nix_base + NIX_LF_QINTX_INT(q));
-
-		/* Disable QINT interrupt */
+		/* Clear QINT CNT, interrupt */
 		plt_write64(~0ull, nix_base + NIX_LF_QINTX_ENA_W1C(q));
 
+		cnt = plt_read64(nix_base + NIX_LF_QINTX_CNT(q));
+		plt_write64((uint64_t)(-(int64_t)cnt), nix_base + NIX_LF_QINTX_CNT(q));
+		plt_write64(~0ull, nix_base + NIX_LF_QINTX_INT(q));
+
 		/* Unregister queue irq vector */
 		dev_irq_unregister(handle, nix_inl_nix_q_irq, &qints_mem[q],
 				   msixoff + NIX_LF_INT_VEC_QINT_START + q);
 	}
+	inl_dev->configured_qints = 0;
 
 	plt_free(inl_dev->qints_mem);
 	inl_dev->qints_mem = NULL;
diff --git a/drivers/common/cnxk/roc_nix_irq.c b/drivers/common/cnxk/roc_nix_irq.c
index 6874435a4e..50a1943411 100644
--- a/drivers/common/cnxk/roc_nix_irq.c
+++ b/drivers/common/cnxk/roc_nix_irq.c
@@ -324,9 +324,6 @@ nix_lf_q_irq(void *param)
 			plt_err("SQ=%d NIX_SQINT_SQB_ALLOC_FAIL", sq);
 	}
 
-	/* Clear interrupt */
-	plt_write64(intr, nix->base + NIX_LF_QINTX_INT(qintx));
-
 	/* Call reset callback */
 	if (intr_cb && dev->ops->q_err_cb)
 		dev->ops->q_err_cb(nix_priv_to_roc_nix(nix), NULL);
@@ -338,6 +335,7 @@ roc_nix_register_queue_irqs(struct roc_nix *roc_nix)
 	int vec, q, sqs, rqs, qs, rc = 0;
 	struct plt_intr_handle *handle;
 	struct nix *nix;
+	int64_t val;
 
 	nix = roc_nix_to_nix_priv(roc_nix);
 	handle = nix->pci_dev->intr_handle;
@@ -358,7 +356,8 @@ roc_nix_register_queue_irqs(struct roc_nix *roc_nix)
 		vec = nix->msixoff + NIX_LF_INT_VEC_QINT_START + q;
 
 		/* Clear QINT CNT */
-		plt_write64(0, nix->base + NIX_LF_QINTX_CNT(q));
+		val = plt_read64(nix->base + NIX_LF_QINTX_CNT(q));
+		plt_write64(-val, nix->base + NIX_LF_QINTX_CNT(q));
 
 		/* Clear interrupt */
 		plt_write64(~0ull, nix->base + NIX_LF_QINTX_ENA_W1C(q));
@@ -375,7 +374,6 @@ roc_nix_register_queue_irqs(struct roc_nix *roc_nix)
 		if (rc)
 			break;
 
-		plt_write64(0, nix->base + NIX_LF_QINTX_CNT(q));
 		plt_write64(0, nix->base + NIX_LF_QINTX_INT(q));
 		/* Enable QINT interrupt */
 		plt_write64(~0ull, nix->base + NIX_LF_QINTX_ENA_W1S(q));
@@ -389,6 +387,7 @@ roc_nix_unregister_queue_irqs(struct roc_nix *roc_nix)
 {
 	struct plt_intr_handle *handle;
 	struct nix *nix;
+	int64_t val;
 	int vec, q;
 
 	nix = roc_nix_to_nix_priv(roc_nix);
@@ -398,7 +397,8 @@ roc_nix_unregister_queue_irqs(struct roc_nix *roc_nix)
 		vec = nix->msixoff + NIX_LF_INT_VEC_QINT_START + q;
 
 		/* Clear QINT CNT */
-		plt_write64(0, nix->base + NIX_LF_QINTX_CNT(q));
+		val = plt_read64(nix->base + NIX_LF_QINTX_CNT(q));
+		plt_write64(-val, nix->base + NIX_LF_QINTX_CNT(q));
 		plt_write64(0, nix->base + NIX_LF_QINTX_INT(q));
 
 		/* Clear interrupt */
-- 
2.34.1

