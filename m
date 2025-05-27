Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4480C5B542
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40A814069F;
	Tue, 27 May 2025 13:02:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D95540685
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:32 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsaX001051
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 aS3bOraI5Csy6LHQ9yw4x+CZskiVRwoPnwLgjIiG1Q=; b=fLvgobx7r8Kw621OX
 RlGW/PHnKYPTKnhe2pDO3DPhwtuxacUkBALwM/5USkkn53pTTkTYwGsYm0VZ3lgU
 F2jEZjAOspFerndZUPQzFXjg8h/dWxMPGoBB9OwyZlYoZDNzVmsZxL7Yf8Uyur8C
 OzCUDri4s9emvlYyaMllgs4spnznoshntqOFlFLcAYbuMtXcsemYWXbgyQ76Kee7
 RBPYYoP2nvA/JH94BGoTgCIgH1e9Tmt5KWoXxLQxi58BMtRmVi+WX1FX0nbYL1ha
 uNdf7C+euJYJdeftX+v9v9PYHvIFp589gdqDOAbBs5NSAvO9bEz6Mm3o0c5HB/If
 vxlKA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21293nw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:17 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 082DF3F707D;
 Tue, 27 May 2025 04:02:15 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 04/25] crypto/cnxk: add skeletion for enq deq functions
Date: Tue, 27 May 2025 16:31:44 +0530
Message-ID: <20250527110205.2300800-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68359bc6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=oHHSJpLJoGYO9f13fccA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: nRlruCI7r2FQJmNRqGoDPKeL3yuqxtnB
X-Proofpoint-ORIG-GUID: nRlruCI7r2FQJmNRqGoDPKeL3yuqxtnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX4XGAzUVr2Inm
 sqAQ1wNBcj4a1uHAhftA0PK8Fa6q8jHwvIZL9uex1gWSps8/KLdCOPKQKKXg6Akd4tW645CfvKK
 yC6dHQP9tXvIw3yHBSrb6Tt8v7JwZVTWMBLA8Re0hVEiBh+cKcQJe9Obknl2+2jNIlitrajv8M9
 OV6fxp/HnVhqJmOm97ylyRTJLZmyTUK0JHoEKpPyk0E215Le2SN0AHD3x+AODMR4i5q9lu8KDJd
 /i9DT7a3mMLRRzOsc7TcPMGnX95BxXwJucY6THSk0ZDZMGKHZeeDk1uv14BL3L3vy7h/6ZC5K0H
 X2n+HG/XYAKmX43p0F7L7ERfuXZO9cpnWjYQ/puxucD11r//zVX4ftBblFGkjJ/URv4uZf9EyYs
 GN/fqixQzQaCkvjXoYlHMwvY4my/h2kI7ZXPlkgwtVC/cGaHg/TGfta01d4PDui3uZeeQZRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

Add skeletion for cn20k enq deq functions

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev.c     |  1 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 29 +++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index 980ea7df97..0845c1e20d 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -92,6 +92,7 @@ cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_
 	dev->feature_flags = cnxk_cpt_default_ff_get();
 
 	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
+	cn20k_cpt_set_enqdeq_fns(dev, vf);
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index ac321a2b91..e3bea9aaf6 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -30,6 +30,35 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 	return 0;
 }
 
+static uint16_t
+cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
+{
+	(void)qptr;
+	(void)ops;
+	(void)nb_ops;
+
+	return 0;
+}
+
+static uint16_t
+cn20k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
+{
+	(void)qptr;
+	(void)ops;
+	(void)nb_ops;
+
+	return 0;
+}
+
+void
+cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt_vf *vf)
+{
+	dev->enqueue_burst = cn20k_cpt_enqueue_burst;
+	dev->dequeue_burst = cn20k_cpt_dequeue_burst;
+
+	rte_mb();
+}
+
 static void
 cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
 {
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index d7c3aed22b..d6f1592a56 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -20,4 +20,5 @@
 
 extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
+void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt_vf *vf);
 #endif /* _CN20K_CRYPTODEV_OPS_H_ */
-- 
2.25.1

