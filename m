Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D1C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 270F0406B6;
	Tue,  3 Jun 2025 13:50:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5867E406B7
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55399gjE011316
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 99/6PHDMUieS/KCs2LFYLOqZM8EX8BHRV6SRDrQdKQ=; b=T2J5WnY9ladRqVd09
 vr48MRI35RM1iEBbZe4fdkY+29++yVzznhvsweW8aZJnJRIZZCwtgL0ZWFVZILLp
 c3ebGfH3TFN4y+Q47cMXdAXxPuzGWE5SKSsoJcOyXTKQE3SMVR+04//RhTSB3Dqy
 Mf8MN+vR6OuPsB9uhZMv0CMSbZcpTJ3bdNA3KzCE08MY+MNh5A0hIBgxJ7s6SRcM
 vEoZOf7YyWZ7VqPVbhrU1fja6eu9xDqeyibPZ1AvdlD7NjQw2wEZJkwwo7yTnmYE
 tbOPl0IK0xHVgDMvJ5Af7mpzJZEGt1XKN7OujuVavPcNjTZjHinzADlNoMgqSDDG
 XKl6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98hw6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:38 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 940F25B6922;
 Tue,  3 Jun 2025 04:50:36 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 04/25] crypto/cnxk: add cn20k datapath skeleton
Date: Tue, 3 Jun 2025 17:20:05 +0530
Message-ID: <20250603115026.2664706-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX6USNVvtUKOfL
 R/Tt5NBIfZ06sYt9x44j4q2jUCdSCw1fk1sk32WjmUER8h1tFH3TcmvzXWz/mgogaE0IyRdSWqU
 okbHpkg3WKBlEmWZO6WCs3MgZH3N0lUtIuQ91MggjYTBtLDC85OD/cXBl76ZTUGpWsPlAATwH9e
 113Rzzpv9NHJB5gy7xOwbCPcp2eu4P5l/wgerS/WIOt6JcoJ6ifqpoam6Yzu4nQWHVkrF/22m9b
 lbsfJyLW84vq1RDW/H+bAnqJ8Yi2YZyvA8gFYB3MYwryhNpuWptv5OtYW8imwx7CpfIhI56hlGf
 c8+PZQHpL265EZZSpYwWya7KR1euOyNZ30yLKdJpCnYGSlVKMcvqi+6Jcf3xCUR3/a0VQMqNtp6
 y8DMOxwUVjv2rp/Lb2opO7JJeKA+kJ3SK19bEUcOBcgucDxk9I/0GUOSdeIMHqReUtJbcyGK
X-Proofpoint-ORIG-GUID: zdmCY7KTJUzEjpcrboVR6V0Oi9hP86aV
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683ee18f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=oHHSJpLJoGYO9f13fccA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: zdmCY7KTJUzEjpcrboVR6V0Oi9hP86aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Add skeleton for cn20k enqueue-dequeue functions

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev.c     |  1 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 29 +++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index 980ea7df97..4c70c15ca9 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -92,6 +92,7 @@ cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_
 	dev->feature_flags = cnxk_cpt_default_ff_get();
 
 	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
+	cn20k_cpt_set_enqdeq_fns(dev);
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index ac321a2b91..37a4472e31 100644
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
+cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev)
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
index d7c3aed22b..d9594513d1 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -20,4 +20,5 @@
 
 extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
+void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev);
 #endif /* _CN20K_CRYPTODEV_OPS_H_ */
-- 
2.25.1

