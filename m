Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91873C44500
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:50:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDA324066C;
	Fri,  3 Jul 2026 16:50:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 15B744003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783090201; x=1814626201;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+lJcUeSY3aad5M5BDt8aBclrVyRr/v+PiP9swNMB2Os=;
 b=CWfzK6qWjod8PhMnXB4GnfPwAOMFx5WhYqzByT+BNQjsoEj+Wmdt2uxS
 Wcn2/hHYvCNwXz3wcOJ/CpAGB5nzjEIdcgbUCVr1jiDzyt/zYGoKBOQYe
 cNUBneglLDQDvNRXJiK4H414aoNkSseJ7TMRDbPOIQs+lljIkQEMxD2RU
 YZvNfHC7jeaXcTtE4C7+ReTMiSd5qej5Fk/wd8+7n54tufWpfrLOwd7ON
 n0SJOxYGgwI7mboc5hW1L0LJmPCKYlR/pwrgtsDRo2Q42Z3Ku+qaAF/rf
 MoiWYjDDWXhnm1JkfEmn+nroHsCtdYvwG3yN5ueHHxxFQxrAXII9KzS64 Q==;
X-CSE-ConnectionGUID: CIE3BJikQAye+pT1dlO59g==
X-CSE-MsgGUID: V9j47mVFQKa7Hy4gUqiYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="86393571"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="86393571"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 07:50:00 -0700
X-CSE-ConnectionGUID: kmwjxtkkSieVKW4syxt5FA==
X-CSE-MsgGUID: VUmcn5dMSA2lJ1BpEPjLyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="252068708"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa010.jf.intel.com with ESMTP; 03 Jul 2026 07:49:59 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, Radu Nicolau <radu.nicolau@intel.com>,
 jianjay.zhou@huawei.com, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] crypto/virtio: cookies are allocated from mempool
Date: Fri,  3 Jul 2026 14:49:31 +0000
Message-ID: <20260703144931.2541180-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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
---
 drivers/crypto/virtio/virtio_cryptodev.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 6f079f15f6..7cf94dc57c 100644
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
 
@@ -175,30 +169,14 @@ virtio_crypto_queue_setup(struct rte_cryptodev *dev,
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
+	rte_mempool_free(vq->mpool);
 	rte_free(vq);
 	return -ENOMEM;
 }
-- 
2.52.0

