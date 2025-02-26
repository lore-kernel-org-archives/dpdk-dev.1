Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C2C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 18:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C0440608;
	Wed, 26 Feb 2025 19:44:40 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 94A4E402E2;
 Wed, 26 Feb 2025 19:44:37 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q8e5AM010967;
 Wed, 26 Feb 2025 10:44:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 zg2nkgOFDRO2tI0nNg0mqdcRsm6Ljmt2P761leWvZY=; b=ODEdd6IEZnNsl+kTT
 DB1bPODt4S3RVWmTdUfcxH61tUb6xkMY3HBhvwE9hRgIKd0jEVewPksZIvLxaSDp
 snCE58X7NnSrToqhU5eq3pKijLTyTuySBAxSSJLp4u8FuxGZ9Q8DlEKdJR1oBg6t
 qkgRjmbljmm8BjmQUg20RAmMzAnIlXZYWz7+iz3NZbEMdKni8Pn8nuCnv2jLonCU
 ewS05kvvXiL+2aoqkTZrCvaEZv0GsTRoaeIzqzMZaa6MC/y+VKlRrOm2BDKBK6fS
 U3H/ttUemoOMejrqdyYfXpJJwt/3tsVzNMDoPVVNt598yFtb7vK05nlF/WA3bHu9
 Ne11A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 451yn39bpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 10:44:36 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Feb 2025 10:44:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Feb 2025 10:44:35 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.81])
 by maili.marvell.com (Postfix) with ESMTP id 762323F7071;
 Wed, 26 Feb 2025 10:44:32 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v6 1/5] vhost: skip crypto op fetch before vring init
Date: Thu, 27 Feb 2025 00:13:12 +0530
Message-ID: <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740594750.git.gmuthukrishn@marvell.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mqhZOjVuvSvuPTI0P56eQjefQLZ38dkw
X-Authority-Analysis: v=2.4 cv=BLRJrEQG c=1 sm=1 tr=0 ts=67bf6114 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=hgvQOYaPpAByZaqCu4gA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mqhZOjVuvSvuPTI0P56eQjefQLZ38dkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
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

Until virtio avail ring is initialized (by VHOST_USER_SET_VRING_ADDR),
worker thread should not try to fetch crypto op, which would lead to
memory fault.

Fixes: 939066d96563 ("vhost/crypto: add public function implementation")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
---
v6:
 - added lock checks.
---
 lib/vhost/vhost_crypto.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3dc41a3bd5..d3d13eff07 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -8,6 +8,7 @@
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
 
+#include "iotlb.h"
 #include "rte_vhost_crypto.h"
 #include "vhost.h"
 #include "vhost_user.h"
@@ -1580,7 +1581,26 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
 	vq = dev->virtqueue[qid];
 
+	if (unlikely(vq == NULL)) {
+		VC_LOG_ERR("Invalid virtqueue %u", qid);
+		return 0;
+	}
+
+	if (unlikely(rte_rwlock_read_trylock(&vq->access_lock) != 0))
+		return 0;
+
+	vhost_user_iotlb_rd_lock(vq);
+	if (unlikely(!vq->access_ok)) {
+		VC_LOG_DBG("Virtqueue %u vrings not yet initialized", qid);
+		vhost_user_iotlb_rd_unlock(vq);
+		rte_rwlock_read_unlock(&vq->access_lock);
+		return 0;
+	}
+
 	avail_idx = *((volatile uint16_t *)&vq->avail->idx);
+	vhost_user_iotlb_rd_unlock(vq);
+	rte_rwlock_read_unlock(&vq->access_lock);
+
 	start_idx = vq->last_used_idx;
 	count = avail_idx - start_idx;
 	count = RTE_MIN(count, VHOST_CRYPTO_MAX_BURST_SIZE);
-- 
2.25.1

