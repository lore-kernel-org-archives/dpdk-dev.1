Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C5C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD07402C3;
	Mon,  6 Jul 2026 11:58:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id DB19B4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783331898; x=1814867898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=peUTy46irViZUO1O1eU04CayV8rTgRmpeRKMk7kROFk=;
 b=mUUO5r76/XVDSC9xvuhNabn4UEIKOxjBBWqUJB+gcSp+E+RghlijRQZd
 4WB7yrQHDq6OhNDVodpBat7KsFwf4YC8Z2LNpxNLwS62u92J20Nalhdwr
 6n0wFFQEdhYU1ajbR6TKQWgPQigWPOQJuj5NwVX9tmVQAOjrUeDDnGttp
 yJpzq6O03nrtQ1VNEUNQTm0DtR5mvexNAdDZgp0sbOnGxnFw9V/3EYOB0
 yRWNsUJEPgo/yzkYPpmmqyB/h1+yJw3NshH4gSQ0zSdsbiY10k0Xyfm6I
 7Ej6ALWdLZ3EgT2asug8qMgskvVIBUB20KmwhOVL3qYyRrPfFd+mauEiZ A==;
X-CSE-ConnectionGUID: HevX/QQfTnWdZmc/dI0mEw==
X-CSE-MsgGUID: YTOpkP8oQgqqit6m7nQUMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="94565694"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="94565694"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 02:58:16 -0700
X-CSE-ConnectionGUID: ZV3in04kQzCze90hXzr+QQ==
X-CSE-MsgGUID: yr2hkpEwQnKa6LM+nP1aGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="251929913"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa006.jf.intel.com with ESMTP; 06 Jul 2026 02:58:16 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, david.marchand@redhat.com,
 Radu Nicolau <radu.nicolau@intel.com>, jianjay.zhou@huawei.com,
 Yu Jiang <yux.jiang@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2] crypto/virtio: cookies are allocated from mempool
Date: Mon,  6 Jul 2026 09:57:46 +0000
Message-ID: <20260706095746.2586714-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703144931.2541180-1-radu.nicolau@intel.com>
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Rx/Tx functions allocate cookies as needed, no need to
allocate and free from heap.

Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
Cc: jianjay.zhou@huawei.com

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Tested-by: Yu Jiang <yux.jiang@intel.com>
---
v2: removed redundant mempool free

 drivers/crypto/virtio/virtio_cryptodev.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 6f079f15f6..d70651646e 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -68,7 +68,6 @@ void
 virtio_crypto_queue_release(struct virtqueue *vq)
 {
 	struct virtio_crypto_hw *hw;
-	uint16_t i;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -80,9 +79,6 @@ virtio_crypto_queue_release(struct virtqueue *vq)
 		hw->vqs[vq->vq_queue_index] = NULL;
 		rte_memzone_free(vq->mz);
 		rte_mempool_free(vq->mpool);
-		for (i = 0; i < vq->vq_nentries; i++)
-			rte_free(vq->vq_descx[i].cookie);
-
 		rte_free(vq);
 	}
 }
@@ -102,8 +98,6 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 	unsigned int vq_size;
 	struct virtio_crypto_hw *hw = dev->data->dev_private;
 	struct virtqueue *vq = NULL;
-	uint32_t i = 0;
-	uint32_t j;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -175,29 +169,12 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
 					"Cannot create mempool");
 			goto mpool_create_err;
 		}
-		for (i = 0; i < nb_desc; i++) {
-			vq->vq_descx[i].cookie =
-				rte_zmalloc("crypto PMD op cookie pointer",
-					sizeof(struct virtio_crypto_op_cookie),
-					RTE_CACHE_LINE_SIZE);
-			if (vq->vq_descx[i].cookie == NULL) {
-				VIRTIO_CRYPTO_DRV_LOG_ERR("Failed to "
-						"alloc mem for cookie");
-				goto cookie_alloc_err;
-			}
-		}
 	}
 
 	*pvq = vq;
 
 	return 0;
 
-cookie_alloc_err:
-	rte_mempool_free(vq->mpool);
-	if (i != 0) {
-		for (j = 0; j < i; j++)
-			rte_free(vq->vq_descx[j].cookie);
-	}
 mpool_create_err:
 	rte_free(vq);
 	return -ENOMEM;
-- 
2.52.0

