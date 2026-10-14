Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54010CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E76EC40DCE;
	Wed, 14 Oct 2026 17:01:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5CACC40B97
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWUR/yH5JygSitijRIsi9/FviUE6Y0SNnFIgcmMEcxg=;
 b=HsL8GhkoFokYoqLdWQauGm1LcAJTbagcZJ2/9EusMt4hYuy4VKKHL92jLiBdAJxGp3jPRD
 KJY3vpOSRSpsGC4Qd5xpEzyKTAOsQT4bsetV5PUkWACpTWZgBxveX78KFAxrQ8PH2lDwj9
 CS+Przx6QHFA1zuh3Vm1vrtBvKeuWUo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-CKUvPGDfMAiMqFZSaqrnAg-1; Wed,
 14 Oct 2026 15:01:07 +0000
X-MC-Unique: CKUvPGDfMAiMqFZSaqrnAg-1
X-Mimecast-MFC-AGG-ID: CKUvPGDfMAiMqFZSaqrnAg_1791990066
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CA3E1955F02; Wed, 14 Oct 2026 15:01:06 +0000 (UTC)
Received: from max-p1.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF94D1800446; Wed, 14 Oct 2026 15:01:04 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 09/14] vhost/crypto: fix write back chains termination
Date: Wed, 14 Oct 2026 17:00:44 +0200
Message-ID: <20261014150049.2540538-9-maxime.coquelin@redhat.com>
In-Reply-To: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
References: <20261014150049.2540538-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2pUrQjnh2XIAFUCw8YTbrci3fYmIaOos8LTmUY8Kpm4_1791990066
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: David Marchand <david.marchand@redhat.com>

Early failures (like a mempool depletion) while building a write back
chain can result in unfinished chains since the ->next field is not
explicitly set to NULL on allocation.

Such an unterminated chain results in an infinite loop and double free
issues.

CVE-2026-86847
Bugzilla ID: 2023

Fixes: cd1e8f03abf0 ("vhost/crypto: fix packet copy in chaining mode")
Cc: stable@dpdk.org

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/vhost/vhost_crypto.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index a072324083..38a7bd75d6 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -859,6 +859,15 @@ copy_data(void *data, struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return 0;
 }
 
+static void
+init_wb_data(struct rte_mempool *mp __rte_unused, void *opaque __rte_unused,
+		void *obj, unsigned int obj_idx __rte_unused)
+{
+	struct vhost_crypto_writeback_data *wb_data = obj;
+
+	wb_data->next = NULL;
+}
+
 static void
 write_back_data(struct vhost_crypto_data_req *vc_req)
 {
@@ -869,6 +878,8 @@ write_back_data(struct vhost_crypto_data_req *vc_req)
 		memset(wb_data->src, 0, wb_data->len);
 		wb_last = wb_data;
 		wb_data = wb_data->next;
+
+		wb_last->next = NULL;
 		rte_mempool_put(vc_req->wb_pool, wb_last);
 	}
 }
@@ -877,9 +888,10 @@ static void
 free_wb_data(struct vhost_crypto_writeback_data *wb_data,
 		struct rte_mempool *mp)
 {
-	while (wb_data->next != NULL)
+	if (wb_data->next != NULL)
 		free_wb_data(wb_data->next, mp);
 
+	wb_data->next = NULL;
 	rte_mempool_put(mp, wb_data);
 }
 
@@ -920,7 +932,7 @@ prepare_write_back_data(struct vhost_virtqueue *vq,
 		uint32_t max_n_descs)
 	__rte_requires_shared_capability(&vq->iotlb_lock)
 {
-	struct vhost_crypto_writeback_data *wb_data, *head;
+	struct vhost_crypto_writeback_data *wb_data, *head = NULL;
 	struct vhost_crypto_desc *desc = *cur_desc;
 	uint64_t dlen;
 	uint8_t *dst;
@@ -959,8 +971,7 @@ prepare_write_back_data(struct vhost_virtqueue *vq,
 			}
 
 			wb_data = wb_data->next;
-		} else
-			wb_data->next = NULL;
+		}
 	} else
 		offset -= desc->len;
 
@@ -1002,8 +1013,7 @@ prepare_write_back_data(struct vhost_virtqueue *vq,
 			}
 
 			wb_data = wb_data->next;
-		} else
-			wb_data->next = NULL;
+		}
 	}
 
 	if (unlikely(desc - head_desc == (int)max_n_descs))
@@ -1851,7 +1861,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 	vcrypto->wb_pool = rte_mempool_create(name,
 			VHOST_CRYPTO_MBUF_POOL_SIZE,
 			sizeof(struct vhost_crypto_writeback_data),
-			128, 0, NULL, NULL, NULL, NULL,
+			128, 0, NULL, NULL, init_wb_data, NULL,
 			rte_socket_id(), 0);
 	if (!vcrypto->wb_pool) {
 		VC_LOG_ERR("Failed to creath mempool");
@@ -1944,7 +1954,7 @@ rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 		vcrypto->wb_pool = rte_mempool_create(name,
 				VHOST_CRYPTO_MBUF_POOL_SIZE,
 				sizeof(struct vhost_crypto_writeback_data),
-				128, 0, NULL, NULL, NULL, NULL,
+				128, 0, NULL, NULL, init_wb_data, NULL,
 				rte_socket_id(), 0);
 		if (!vcrypto->wb_pool) {
 			VC_LOG_ERR("Failed to creath mbuf pool");
-- 
2.56.0

