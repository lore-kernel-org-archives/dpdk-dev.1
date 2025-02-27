Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F451C19F2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 14:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5C6340B97;
	Thu, 27 Feb 2025 15:00:14 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0594540B98;
 Thu, 27 Feb 2025 15:00:12 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R92Gni030946;
 Thu, 27 Feb 2025 06:00:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 9oxRrJn8UYH8wWm0VdP7djUIbucmvC3KQ0YsRcprjA=; b=XixQ4v309cASpSNwA
 ozc9N+sSjtZ8ri6PVeoTBtAcR4Pq76KrgEJvZQaI/DiK8wb3EDdju7M7jWbmEhnK
 DeH2J8KgRWHkTCc077y2wJQTh2q/1tyGumI2xke08/ow0u7aIEtiW3rme4mRmcK3
 C5pPMGfOiak6cLW2tiyWdYieX3ysaK5UbngIjQwhLCSs6i/mAuywHP4HqyVSQeM+
 cjjXaloem1/5QEwUr1v/w1rgyJXr0UBhWP7PnvKUau3HEAbpB8tnYmcq4NVbG7sJ
 dh7EXB9z76ZlJNWN9Aas5BcCMW4IaRJzqy7gpJ9AfLdjshChqDrEFotUjC2xxdpn
 WG1Gg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452n29rg5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:00:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 06:00:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 06:00:10 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id E88535B692F;
 Thu, 27 Feb 2025 06:00:07 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v7 1/5] vhost: skip crypto op fetch before vring init
Date: Thu, 27 Feb 2025 19:29:45 +0530
Message-ID: <f66f3532933b3d101cc8bb258bac0e820c54e787.1740664527.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740664527.git.gmuthukrishn@marvell.com>
References: <cover.1740664527.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aaubnQot c=1 sm=1 tr=0 ts=67c06feb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=V3-Mqpc_tUjGiEsRQoUA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 51g02Wse6hFRIS_KhH3qFS9BqiJujk78
X-Proofpoint-GUID: 51g02Wse6hFRIS_KhH3qFS9BqiJujk78
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
v7:
 - updated locks in fetch req func.
---
 lib/vhost/vhost_crypto.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3dc41a3bd5..3967d68d77 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -8,6 +8,7 @@
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
 
+#include "iotlb.h"
 #include "rte_vhost_crypto.h"
 #include "vhost.h"
 #include "vhost_user.h"
@@ -1131,7 +1132,6 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		struct vhost_virtqueue *vq, struct rte_crypto_op *op,
 		struct vring_desc *head, struct vhost_crypto_desc *descs,
 		uint16_t desc_idx)
-	__rte_no_thread_safety_analysis /* FIXME: requires iotlb_lock? */
 {
 	struct vhost_crypto_data_req *vc_req = rte_mbuf_to_priv(op->sym->m_src);
 	struct rte_cryptodev_sym_session *session;
@@ -1580,6 +1580,20 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
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
@@ -1587,7 +1601,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 	count = RTE_MIN(count, nb_ops);
 
 	if (unlikely(count == 0))
-		return 0;
+		goto out_unlock;
 
 	/* for zero copy, we need 2 empty mbufs for src and dst, otherwise
 	 * we need only 1 mbuf as src and dst
@@ -1597,7 +1611,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count * 2) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1627,7 +1641,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		if (unlikely(rte_mempool_get_bulk(vcrypto->mbuf_pool,
 				(void **)mbufs, count) < 0)) {
 			VC_LOG_ERR("Insufficient memory");
-			return 0;
+			goto out_unlock;
 		}
 
 		for (i = 0; i < count; i++) {
@@ -1656,6 +1670,10 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 
 	vq->last_used_idx += i;
 
+out_unlock:
+	vhost_user_iotlb_rd_unlock(vq);
+	rte_rwlock_read_unlock(&vq->access_lock);
+
 	return i;
 }
 
-- 
2.25.1

