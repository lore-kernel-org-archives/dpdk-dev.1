Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08035C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFD040DC9;
	Fri, 23 May 2025 15:52:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C9D6940DDA
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:28 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8SI006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 aS3bOraI5Csy6LHQ9yw4x+CZskiVRwoPnwLgjIiG1Q=; b=Huuv9PHaqL9sQjhjL
 6Wh7DY348HJYLn+XncN7+xZ6KttO/FomEQUuGTRlYo+nWZlSM6tAjgZ/dFdBauMc
 ss+s+7QXidkCTLNg4HLTLv9SJyubgK9qCuefx58MRsL/vz0Ldc/4LzzxYe412i6n
 mgE8yWllo3J22ShNo0c0vgnzp7FIiDmVBbISTCFCIrbmV8CPCntDetyM2c6d0m/g
 CE2rQbKAAW4nzNPBXcQcpRkzaloB/GN6Vk1dglQpprpcppCBkSX7dKroyIdxXCPj
 h9w7Tdrbp5kSOEviNisZ6RRBksu5AWT/2EcA6ZR92ykgcZ/Lgy/xuH72KIGgCDwa
 oq81Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:47 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C57D73F7041;
 Fri, 23 May 2025 06:51:44 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 10/40] crypto/cnxk: add skeletion for enq deq functions
Date: Fri, 23 May 2025 19:20:41 +0530
Message-ID: <20250523135111.2178408-11-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXys3szfGou849
 3s7smHTxZdXaLeSeVWEmfR3vjPis+j9r6BTydRcldWLq61OE1MA9cZLskQ53Y8FRZicAe4BrGAg
 letH3U7GNQttrRCI3DZlAAQnrTan4BZ0M2d2aTAh4vyWPOMlyIPZU6kfSH7XvODwsKJzg0I+DZm
 IFrb3P2bb3zeSfKcDhH76mXYWr/RGe2NJLZwwo+VxG1tgIw066b4Ey/KyXeMVr2ADQSAKYE6yz/
 VGRmkFBGxMhMSniDHS6KXZSTiHR1Xg1nnCPPYK2Z8wr9VCOF58VcK8ZJnDnE9aqF5LsioXl8kPu
 6EjDIOHp73qpe2NtikCkPJCtIKjLyVij+O684lMpigKsjDB8v8iAmK8bNtpgPXt/y8vZNSer+Vb
 Jg3NpEJHWgRtgfgkDqEjkFQxwPDv87Miqyhkc7aYNrhx1iGrYiVuM0PP7QYS7VHa662P+8V5
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d9c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=oHHSJpLJoGYO9f13fccA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0C8AZY9qMvqWD4rP3FPlKJcPJaMYxqM0
X-Proofpoint-ORIG-GUID: 0C8AZY9qMvqWD4rP3FPlKJcPJaMYxqM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

