Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27756C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 15:34:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE7294027B;
	Tue,  7 Jul 2026 17:34:25 +0200 (CEST)
Received: from smtp1.ptsecurity.com (smtp1.ptsecurity.com [155.212.252.50])
 by mails.dpdk.org (Postfix) with ESMTP id 40E9D4025F;
 Tue,  7 Jul 2026 15:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ptsecurity.com;
 s=202601; t=1783432321;
 bh=Fu/ivxjD94wx2CDIYlZhQlvJsXdOfwhdiljyW+vW2lo=;
 h=From:To:CC:Subject:Date:From;
 b=FmGxfwZSEOvkudoZCk1pEOnwGW2IDkKf2xHvGwGnS64ULvIj1R6fmZ06CIRwI/JCP
 qZK083LmelgCdKvRSTbFwx+Tb8uMUrhegHhDWcJeU9MN1brlMsYjDS5lHPk+rfYhLc
 MGnHOZL5Wuo5NAXY9Y1y3X0nDirSXIybPys5l2sUTrT7HymK9/18RlBt7rJ01PPfkp
 jhIa6bI5EDEGus9A627unq4ZFqXYF2ahFLIpvJQP7Plo/VA4yuyPGGld17sl1K9VHx
 hzAVZ4s69SKoups2ikxxHH+qpKjxvF+j95mM0I8LyEUr6Zf9xYv/PraI7kTQsUPBsj
 9QlXx6mHK5Xkg==
From: Anton Vanda <avanda@ptsecurity.com>
To: Thomas Monjalon <thomas@monjalon.net>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Yuan Wang
 <yuanx.wang@intel.com>, Cheng Jiang <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <cheng1.jiang@intel.com>, Anton Vanda
 <avanda@ptsecurity.com>
Subject: [PATCH] vhost: fix null dereference in async packed dequeue
Date: Tue, 7 Jul 2026 16:50:44 +0300
Message-ID: <20260707135044.7488-1-avanda@ptsecurity.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 07 Jul 2026 17:34:24 +0200
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

In the batch path of the asynchronous packed ring dequeue, the address
of the virtio net header is obtained from vhost_iova_to_vva(), which
returns 0 when a guest-provided descriptor address cannot be fully
translated.  The batch check only validates that the descriptor address
is non-zero and that the length is consistent. A malicious or buggy
guest could therefore trigger a NULL pointer dereference and crash the
vhost application (denial of service).

Check the translation result and leave the batch fast path with an error
on failure, so the single-packet path handles the invalid descriptor, as
is already done for the non-batch async dequeue path.

Perform the header translation before the DMA iovec setup so that the
early return cannot leave the async iterator state partially updated.

Fixes: c2fa52bf1e5d ("vhost: add batch dequeue in async vhost packed ring")
Cc: stable@dpdk.org

Signed-off-by: Anton Vanda <avanda@ptsecurity.com>
---
 .mailmap               |  1 +
 lib/vhost/virtio_net.c | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 05a55c0bd6..9215581a29 100644
--- a/.mailmap
+++ b/.mailmap
@@ -141,6 +141,7 @@ Antara Ganesh Kolar <antara.ganesh.kolar@intel.com>
 Anthony Fee <anthonyx.fee@intel.com>
 Anthony Harivel <aharivel@redhat.com>
 Antonio Fischetti <antonio.fischetti@intel.com>
+Anton Vanda <avanda@ptsecurity.com>
 Anup Prabhu <aprabhu@marvell.com>
 Anupam Kapoor <anupam.kapoor@gmail.com>
 Anurag Mandal <anurag.mandal@intel.com>
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 0658b81de5..6528c06ea4 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -4039,6 +4039,23 @@ virtio_dev_tx_async_packed_batch(struct virtio_net *dev,
 	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE)
 		rte_prefetch0((void *)(uintptr_t)desc_addrs[i]);
 
+	if (virtio_net_with_host_offload(dev)) {
+		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
+			desc_vva = vhost_iova_to_vva(dev, vq, desc_addrs[i],
+						&lens[i], VHOST_ACCESS_RO);
+			/*
+			 * A malformed or unmapped guest descriptor makes the
+			 * IOVA translation fail (returns 0). Bail out of the
+			 * batch fast path so the single-packet path handles the
+			 * error, instead of dereferencing a NULL header.
+			 */
+			if (unlikely(!desc_vva))
+				return -1;
+			hdr = (struct virtio_net_hdr *)(uintptr_t)desc_vva;
+			pkts_info[slot_idx + i].nethdr = *hdr;
+		}
+	}
+
 	vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
 		host_iova[i] = (void *)(uintptr_t)gpa_to_first_hpa(dev,
 			desc_addrs[i] + buf_offset, pkts[i]->pkt_len, &mapped_len[i]);
@@ -4053,15 +4070,6 @@ virtio_dev_tx_async_packed_batch(struct virtio_net *dev,
 		async->iter_idx++;
 	}
 
-	if (virtio_net_with_host_offload(dev)) {
-		vhost_for_each_try_unroll(i, 0, PACKED_BATCH_SIZE) {
-			desc_vva = vhost_iova_to_vva(dev, vq, desc_addrs[i],
-						&lens[i], VHOST_ACCESS_RO);
-			hdr = (struct virtio_net_hdr *)(uintptr_t)desc_vva;
-			pkts_info[slot_idx + i].nethdr = *hdr;
-		}
-	}
-
 	vq_inc_last_avail_packed(vq, PACKED_BATCH_SIZE);
 
 	vhost_async_shadow_dequeue_packed_batch(vq, ids);
-- 
2.51.0

