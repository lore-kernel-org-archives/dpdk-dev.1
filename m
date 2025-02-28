Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F0C282C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 13:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C16140E5E;
	Fri, 28 Feb 2025 14:47:47 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C773A40609;
 Fri, 28 Feb 2025 14:47:45 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDUcDI018895;
 Fri, 28 Feb 2025 05:47:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 pK0LT/HEfGpr6pJEL0Mh/u1BGPtbP7AnPqIdbYpf7A=; b=CzlThMUux6bjCBN32
 S5IvTXQ5CFqLOVaqAxFTo6Wxj7iQGwWyC491WRlYnr8BVYL214NZ02FoR3phzCKv
 ZFjLHF7rHBdsePlezkfZZ1HBfXSW/MCqmuG4QIEc8U6eeZpKxXWMuORfI0U+vodm
 bi9vJaRiM/10wkrAdFlOtOF1CMtonxRxRoRNlWPZed8LkAu4x9f4DFv51zM/oMd+
 D/lk/pvYBydXSU9pvyEYtX/tLUQ8W2p3cExQeJ4CPSA5y+XYEprM2EuktCQKoh4F
 wnWZco++pdgZ2c0YCSjgkvIygjFivGs2ZDwoCOEKOrDtdQIeMXiyyVWiu+jUT5jB
 K8RvQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 453bgw885w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 05:47:45 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Feb 2025 05:47:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Feb 2025 05:47:44 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id C82265B692E;
 Fri, 28 Feb 2025 05:47:40 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v9 2/6] vhost: skip crypto op fetch before vring init
Date: Fri, 28 Feb 2025 19:17:09 +0530
Message-ID: <1166acf3f2be66e41fe87324eff57c4f2bdfacf6.1740749809.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740749809.git.gmuthukrishn@marvell.com>
References: <cover.1740749809.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZMQtmW7b c=1 sm=1 tr=0 ts=67c1be81 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=fOnq-zMywcwtGl3uzMkA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BAygtXo-NqHg3nDzTO_tBqoMEiFbnHnz
X-Proofpoint-GUID: BAygtXo-NqHg3nDzTO_tBqoMEiFbnHnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
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
 lib/vhost/vhost_crypto.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 4c36df9cb2..38c5a7f06f 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -8,6 +8,7 @@
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
 
+#include "iotlb.h"
 #include "rte_vhost_crypto.h"
 #include "vhost.h"
 #include "vhost_user.h"
@@ -1586,6 +1587,20 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
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
@@ -1593,7 +1608,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 	count = RTE_MIN(count, nb_ops);
 
 	if (unlikely(count == 0))
-		return 0;
+		goto out_unlock;
 
 	/* for zero copy, we need 2 empty mbufs for src and dst, otherwise
 	 * we need only 1 mbuf as src and dst
@@ -1603,7 +1618,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count * 2) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1633,7 +1648,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1662,6 +1677,10 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
 	vq->last_used_idx += i;
 
+out_unlock:
+	vhost_user_iotlb_rd_unlock(vq);
+	rte_rwlock_read_unlock(&vq->access_lock);
+
 	return i;
 }
 
-- 
2.25.1

