Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0818CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 08:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBD07402A0;
	Fri, 10 Oct 2025 10:41:50 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 53F5440285;
 Fri, 10 Oct 2025 10:41:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=mAocq6eMWXueAhPYqLWzIWK2oHRheg7/eVl+Fkwyi1c=;
 b=FL7MsrTIY3haBNYEdPbR6WdwqpJRqf8rRlM/6eRHp4THOwyp91j+K8AHg1jIldlVnU3P/VMT3
 2/rqyAwLV9sBYXqwYOI/6bjPNtrQaRidIfkJpg6Nfvj52koCKeaugV+N2bZwLkBsLMSfvCmcSN9
 bSNZO0GCZ/FNRAx/Y1VqZBg=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cjgF634GdzcZy3;
 Fri, 10 Oct 2025 16:40:58 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 98BC6180489;
 Fri, 10 Oct 2025 16:41:47 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 16:41:47 +0800
Received: from localhost (10.174.243.191) by kwepemq100013.china.huawei.com
 (7.202.195.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 16:41:47 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <dev@dpdk.org>
CC: <maxime.coquelin@redhat.com>, <jerry.lilijun@huawei.com>, Yunjian Wang
 <wangyunjian@huawei.com>, <stable@dpdk.org>
Subject: [PATCH v3] vhost: fix a double fetch when dequeue offloading
Date: Fri, 10 Oct 2025 16:41:36 +0800
Message-ID: <1760085696-35028-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
References: <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.243.191]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100013.china.huawei.com (7.202.195.192)
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

The hdr->csum_start does two successive reads from user space to read a
variable length data structure. The result overflow if the data structure
changes between the two reads.

To fix this, we can prevent double fetch issue by copying virtio_hdr to
the temporary variable.

Fixes: 4dc4e33ffa10 ("net/virtio: fix Rx checksum calculation")
Cc: stable@dpdk.org

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
v3: update code styles suggested by Stephen Hemminger
---
 lib/vhost/virtio_net.c | 50 ++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 77545d0a4d..0658b81de5 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -2870,25 +2870,28 @@ vhost_dequeue_offload(struct virtio_net *dev, struct virtio_net_hdr *hdr,
 	}
 }
 
-static __rte_noinline void
+static __rte_always_inline int
 copy_vnet_hdr_from_desc(struct virtio_net_hdr *hdr,
-		struct buf_vector *buf_vec)
+			const struct buf_vector *buf_vec,
+			uint16_t nr_vec)
 {
-	uint64_t len;
-	uint64_t remain = sizeof(struct virtio_net_hdr);
-	uint64_t src;
-	uint64_t dst = (uint64_t)(uintptr_t)hdr;
+	size_t remain = sizeof(struct virtio_net_hdr);
+	uint8_t *dst = (uint8_t *)hdr;
 
-	while (remain) {
-		len = RTE_MIN(remain, buf_vec->buf_len);
-		src = buf_vec->buf_addr;
-		rte_memcpy((void *)(uintptr_t)dst,
-				(void *)(uintptr_t)src, len);
+	while (remain > 0) {
+		size_t len = RTE_MIN(remain, buf_vec->buf_len);
+		const void *src = (const void *)(uintptr_t)buf_vec->buf_addr;
 
+		if (unlikely(nr_vec == 0))
+			return -1;
+
+		memcpy(dst, src, len);
 		remain -= len;
 		dst += len;
 		buf_vec++;
+		--nr_vec;
 	}
+	return 0;
 }
 
 static __rte_always_inline int
@@ -2917,16 +2920,12 @@ desc_to_mbuf(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	 */
 
 	if (virtio_net_with_host_offload(dev)) {
-		if (unlikely(buf_vec[0].buf_len < sizeof(struct virtio_net_hdr))) {
-			/*
-			 * No luck, the virtio-net header doesn't fit
-			 * in a contiguous virtual area.
-			 */
-			copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec);
-			hdr = &tmp_hdr;
-		} else {
-			hdr = (struct virtio_net_hdr *)((uintptr_t)buf_vec[0].buf_addr);
-		}
+		if (unlikely(copy_vnet_hdr_from_desc(&tmp_hdr, buf_vec, nr_vec) != 0))
+			return -1;
+
+		/* ensure that compiler does not delay copy */
+		rte_compiler_barrier();
+		hdr = &tmp_hdr;
 	}
 
 	for (vec_idx = 0; vec_idx < nr_vec; vec_idx++) {
@@ -3372,7 +3371,6 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
 {
 	uint16_t avail_idx = vq->last_avail_idx;
 	uint32_t buf_offset = sizeof(struct virtio_net_hdr_mrg_rxbuf);
-	struct virtio_net_hdr *hdr;
 	uintptr_t desc_addrs[PACKED_BATCH_SIZE];
 	uint16_t ids[PACKED_BATCH_SIZE];
 	uint16_t i;
@@ -3391,8 +3389,12 @@ virtio_dev_tx_batch_packed(struct virtio_net *dev,
 
 	if (virtio_net_with_host_offload(dev)) {
 		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-			hdr = (struct virtio_net_hdr *)(desc_addrs[i]);
-			vhost_dequeue_offload(dev, hdr, pkts[i], legacy_ol_flags);
+			struct virtio_net_hdr hdr;
+
+			memcpy(&hdr, (void *)desc_addrs[i], sizeof(struct virtio_net_hdr));
+			rte_compiler_barrier();
+
+			vhost_dequeue_offload(dev, &hdr, pkts[i], legacy_ol_flags);
 		}
 	}
 
-- 
2.33.0

