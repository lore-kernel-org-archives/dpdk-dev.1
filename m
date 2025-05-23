Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D755C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 518AF40DFB;
	Fri, 23 May 2025 15:52:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E86EA406B8
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8SH006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 NT2PMZaoGjHXal4xNlt+JkO/H2fS+M8nOvxS5d6cIw=; b=Fqnqlylr/BqPpsnW8
 LRwRVd2gFu9phqEMWsHypBahSuwwqm8Pm5CBHipYKZhKD3hyxQDeKhiQPz36n4q8
 wpkwOvJNtr3ZSgyFHd5yaLpSGF3kbnU9ttdrJMIbLEpeLB7HA6gZVBbOdo7lA+gQ
 z8ohkAwKx/saMXjbyDa4xKilKroEiBG5IsLu7y5fGWdDxsEsIgBMn84sHOCaeWGp
 0RFGo+wMS/MnMFVOz1TKxEZkLm2P3tn8qpOq7+Pg+2aDBbvAgiV6dnKjD3JrpuzM
 HlHyk7xhwY2OnF+AWpaSFCgNxz4sVrB0PzaWJOIpFqWZP2rG8DwB7bPygJhZmMBz
 9Rqqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:44 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 8085B3F7041;
 Fri, 23 May 2025 06:51:41 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 09/40] crypto/cnxk: add dev info get
Date: Fri, 23 May 2025 19:20:40 +0530
Message-ID: <20250523135111.2178408-10-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX9gNOj5TbJVm8
 bSN7gd/Mu1IuPOJvTS4NNjrVizDec5DUGuAtbjS/z8TGGaWqmrYsl5OoJFH4Ri5O8NcvLFwRa9J
 vFDBN99syZpj4lmwy9glqB6l+Xbxl+aQdS9bILMy2KM4sT65cNH/O2Yav/yJJd7FfXXE9lgdCub
 4VhvQAxG7Y0rK40VgCGhNCUHMQANTNSjTS9lJ2AMk3X3k5AGi+Iwilo7V3r7S8bG7toN1IN1ZRr
 fVYuSu7LmmC2Ve2Yd2I5Tk8kL/DgU0fd71Wg3bnkVJRSzGFxo8ZN5rJA1S9ihVC8k/sSbh25x9O
 sI0eaBjJatzTLH82A6Qbo/GccMyC3DMG2H5qDX7e/xkmOa1JJKokoANyUb/WM+6MmtSiawHnV1f
 6jQIBaasDuzC4XX7uvp3I51Ni6LhGyHuoKD9pUxzxwmjTzyujYnmxFl3EEDquxIcIxn/Pn9k
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d9b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Pe1cafgnUAMM2Of7aycA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4afDWNeQsRE3PSfSi9GfaRB3HZ4zrtdT
X-Proofpoint-ORIG-GUID: 4afDWNeQsRE3PSfSi9GfaRB3HZ4zrtdT
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

Add dev info get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 64ab285235..ac321a2b91 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -33,8 +33,10 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 static void
 cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
 {
-	(void)dev;
-	(void)info;
+	if (info != NULL) {
+		cnxk_cpt_dev_info_get(dev, info);
+		info->driver_id = cn20k_cryptodev_driver_id;
+	}
 }
 
 static int
-- 
2.25.1

