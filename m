Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9664FC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 18:15:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF32640B9C;
	Thu, 27 Feb 2025 19:15:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 92CD940A4B;
 Thu, 27 Feb 2025 19:15:44 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFeArX016570;
 Thu, 27 Feb 2025 10:15:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 EEfUHsppMADzm69nkNlu9X57Bhk1t2YEj0b1SzoodQ=; b=cSxmvVBLTTW1iy6fr
 05QiDldBmcs5UOVzumHpnT1tftz7+sNRYwjYllhR68D3Loc3RmzQRTnZHAM4IseZ
 XtzeCF5qw0HAruFgUSQCt/KrH8kG617lGrQVdG9jnE7qu5geCETaoe6X+7zJFhi5
 1EYwZD+cqILWpTw8B1kV2xcKkXuigITIwfjFGINt+kV8Kcx9kn0NggtJztz38/n7
 1EBPO0o6bRRE2DLmANrmVuR29uHTRqsfCY1hwEkcXiWC6YfKdtC6j7dkGANhZRAC
 FtFD0XiAFPhhzlig8U967ViojFWtqyy02Yr23UM7H2UBzYd/gIbEtIhU+qBaFJ29
 eEf3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tvrrchs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:15:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 10:15:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 10:15:41 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id EECE83F7071;
 Thu, 27 Feb 2025 10:15:38 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v8 1/5] vhost: skip crypto op fetch before vring init
Date: Thu, 27 Feb 2025 23:45:22 +0530
Message-ID: <c80681bc1f357c47c832ecfe5f97eb78e7779a99.1740679955.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740679955.git.gmuthukrishn@marvell.com>
References: <cover.1740679955.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wiJ8TgHhtY3DS58UqGbrQ9aHtJbMk9KD
X-Authority-Analysis: v=2.4 cv=COHQXQrD c=1 sm=1 tr=0 ts=67c0abcf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=fOnq-zMywcwtGl3uzMkA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: wiJ8TgHhtY3DS58UqGbrQ9aHtJbMk9KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
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
v8:
 - fix CI issue.
---
 lib/vhost/vhost_crypto.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3dc41a3bd5..a805d29a0e 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -8,6 +8,7 @@
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
 
+#include "iotlb.h"
 #include "rte_vhost_crypto.h"
 #include "vhost.h"
 #include "vhost_user.h"
@@ -1580,6 +1581,20 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
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
+		goto out_unlock;
+	}
+
 	avail_idx = *((volatile uint16_t *)&vq->avail->idx);
 	start_idx = vq->last_used_idx;
 	count = avail_idx - start_idx;
@@ -1587,7 +1602,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 	count = RTE_MIN(count, nb_ops);
 
 	if (unlikely(count == 0))
-		return 0;
+		goto out_unlock;
 
 	/* for zero copy, we need 2 empty mbufs for src and dst, otherwise
 	 * we need only 1 mbuf as src and dst
@@ -1597,7 +1612,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count * 2) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1627,7 +1642,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1656,6 +1671,10 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
 	vq->last_used_idx += i;
 
+out_unlock:
+	vhost_user_iotlb_rd_unlock(vq);
+	rte_rwlock_read_unlock(&vq->access_lock);
+
 	return i;
 }
 
-- 
2.25.1

