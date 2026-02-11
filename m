Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A5CECD6C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C948740668;
	Wed, 11 Feb 2026 17:15:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B170040689
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbjJoguxxxoK4IVu7md87jgQp/Kn/pTW/NQp7aJC8bM=;
 b=LX/lPPXHuPGLanG4CMttWzpRlWB/tCNIvK+sUi47iHfByBJLxEfWnD1KBWoHmPDJ780p9H
 DhYweh5RrPJLASFWFRT4GMBBPuN+nLQ5ywQhz84Waks7z4pt2n+K3ct1qaEW/hO4Xdqa6d
 HVpFpCuD7UAbyTZ5eGmlIir8yFDRW6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-s4uS-U1mNJeLoF8zQP0eag-1; Wed,
 11 Feb 2026 11:15:09 -0500
X-MC-Unique: s4uS-U1mNJeLoF8zQP0eag-1
X-Mimecast-MFC-AGG-ID: s4uS-U1mNJeLoF8zQP0eag_1770826508
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BD9B1955DC3; Wed, 11 Feb 2026 16:15:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D04BD18004AD; Wed, 11 Feb 2026 16:15:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, david.marchand@redhat.com, mst@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com
Subject: [RFC 02/10] vhost: introduce ASID support
Date: Wed, 11 Feb 2026 17:14:49 +0100
Message-ID: <20260211161457.2703686-3-eperezma@redhat.com>
In-Reply-To: <20260211161457.2703686-1-eperezma@redhat.com>
References: <20260211161457.2703686-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CO5WJ_wW5ziqi0vqlHs7__F59Z_Wfu3LEdv7zEqNtgI_1770826508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/iotlb.c      | 226 +++++++++++++++++++++++++----------------
 lib/vhost/iotlb.h      |  14 +--
 lib/vhost/vduse.c      |  11 +-
 lib/vhost/vhost.c      |  16 +--
 lib/vhost/vhost.h      |  13 +--
 lib/vhost/vhost_user.c |  11 +-
 6 files changed, 171 insertions(+), 120 deletions(-)

diff --git a/lib/vhost/iotlb.c b/lib/vhost/iotlb.c
index f2c275a7d77e..112d3d0e359b 100644
--- a/lib/vhost/iotlb.c
+++ b/lib/vhost/iotlb.c
@@ -11,6 +11,16 @@
 #include "iotlb.h"
 #include "vhost.h"
 
+struct iotlb {
+	rte_rwlock_t			pending_lock;
+	struct vhost_iotlb_entry 	*pool;
+	TAILQ_HEAD(, vhost_iotlb_entry)	list;
+	TAILQ_HEAD(, vhost_iotlb_entry)	pending_list;
+	int				cache_nr;
+	rte_spinlock_t			free_lock;
+	SLIST_HEAD(, vhost_iotlb_entry)	free_list;
+};
+
 struct vhost_iotlb_entry {
 	TAILQ_ENTRY(vhost_iotlb_entry) next;
 	SLIST_ENTRY(vhost_iotlb_entry) next_free;
@@ -85,78 +95,78 @@ vhost_user_iotlb_clear_dump(struct virtio_net *dev, struct vhost_iotlb_entry *no
 }
 
 static struct vhost_iotlb_entry *
-vhost_user_iotlb_pool_get(struct virtio_net *dev)
+vhost_user_iotlb_pool_get(struct virtio_net *dev, int asid)
 {
 	struct vhost_iotlb_entry *node;
 
-	rte_spinlock_lock(&dev->iotlb_free_lock);
-	node = SLIST_FIRST(&dev->iotlb_free_list);
+	rte_spinlock_lock(&dev->iotlb[asid]->free_lock);
+	node = SLIST_FIRST(&dev->iotlb[asid]->free_list);
 	if (node != NULL)
-		SLIST_REMOVE_HEAD(&dev->iotlb_free_list, next_free);
-	rte_spinlock_unlock(&dev->iotlb_free_lock);
+		SLIST_REMOVE_HEAD(&dev->iotlb[asid]->free_list, next_free);
+	rte_spinlock_unlock(&dev->iotlb[asid]->free_lock);
 	return node;
 }
 
 static void
-vhost_user_iotlb_pool_put(struct virtio_net *dev, struct vhost_iotlb_entry *node)
+vhost_user_iotlb_pool_put(struct virtio_net *dev, int asid, struct vhost_iotlb_entry *node)
 {
-	rte_spinlock_lock(&dev->iotlb_free_lock);
-	SLIST_INSERT_HEAD(&dev->iotlb_free_list, node, next_free);
-	rte_spinlock_unlock(&dev->iotlb_free_lock);
+	rte_spinlock_lock(&dev->iotlb[asid]->free_lock);
+	SLIST_INSERT_HEAD(&dev->iotlb[asid]->free_list, node, next_free);
+	rte_spinlock_unlock(&dev->iotlb[asid]->free_lock);
 }
 
 static void
-vhost_user_iotlb_cache_random_evict(struct virtio_net *dev);
+vhost_user_iotlb_cache_random_evict(struct virtio_net *dev, int asid);
 
 static void
-vhost_user_iotlb_pending_remove_all(struct virtio_net *dev)
+vhost_user_iotlb_pending_remove_all(struct virtio_net *dev, int asid)
 {
 	struct vhost_iotlb_entry *node, *temp_node;
 
-	rte_rwlock_write_lock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_lock(&dev->iotlb[asid]->pending_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next, temp_node) {
-		TAILQ_REMOVE(&dev->iotlb_pending_list, node, next);
-		vhost_user_iotlb_pool_put(dev, node);
+	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb[asid]->pending_list, next, temp_node) {
+		TAILQ_REMOVE(&dev->iotlb[asid]->pending_list, node, next);
+		vhost_user_iotlb_pool_put(dev, asid, node);
 	}
 
-	rte_rwlock_write_unlock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_unlock(&dev->iotlb[asid]->pending_lock);
 }
 
 bool
-vhost_user_iotlb_pending_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm)
+vhost_user_iotlb_pending_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm)
 {
 	struct vhost_iotlb_entry *node;
 	bool found = false;
 
-	rte_rwlock_read_lock(&dev->iotlb_pending_lock);
+	rte_rwlock_read_lock(&dev->iotlb[asid]->pending_lock);
 
-	TAILQ_FOREACH(node, &dev->iotlb_pending_list, next) {
+	TAILQ_FOREACH(node, &dev->iotlb[asid]->pending_list, next) {
 		if ((node->iova == iova) && (node->perm == perm)) {
 			found = true;
 			break;
 		}
 	}
 
-	rte_rwlock_read_unlock(&dev->iotlb_pending_lock);
+	rte_rwlock_read_unlock(&dev->iotlb[asid]->pending_lock);
 
 	return found;
 }
 
 void
-vhost_user_iotlb_pending_insert(struct virtio_net *dev, uint64_t iova, uint8_t perm)
+vhost_user_iotlb_pending_insert(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm)
 {
 	struct vhost_iotlb_entry *node;
 
-	node = vhost_user_iotlb_pool_get(dev);
+	node = vhost_user_iotlb_pool_get(dev, asid);
 	if (node == NULL) {
 		VHOST_CONFIG_LOG(dev->ifname, DEBUG,
 			"IOTLB pool empty, clear entries for pending insertion");
-		if (!TAILQ_EMPTY(&dev->iotlb_pending_list))
-			vhost_user_iotlb_pending_remove_all(dev);
+		if (!TAILQ_EMPTY(&dev->iotlb[asid]->pending_list))
+			vhost_user_iotlb_pending_remove_all(dev, asid);
 		else
-			vhost_user_iotlb_cache_random_evict(dev);
-		node = vhost_user_iotlb_pool_get(dev);
+			vhost_user_iotlb_cache_random_evict(dev, asid);
+		node = vhost_user_iotlb_pool_get(dev, asid);
 		if (node == NULL) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR,
 				"IOTLB pool still empty, pending insertion failure");
@@ -167,21 +177,22 @@ vhost_user_iotlb_pending_insert(struct virtio_net *dev, uint64_t iova, uint8_t p
 	node->iova = iova;
 	node->perm = perm;
 
-	rte_rwlock_write_lock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_lock(&dev->iotlb[asid]->pending_lock);
 
-	TAILQ_INSERT_TAIL(&dev->iotlb_pending_list, node, next);
+	TAILQ_INSERT_TAIL(&dev->iotlb[asid]->pending_list, node, next);
 
-	rte_rwlock_write_unlock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_unlock(&dev->iotlb[asid]->pending_lock);
 }
 
 void
-vhost_user_iotlb_pending_remove(struct virtio_net *dev, uint64_t iova, uint64_t size, uint8_t perm)
+vhost_user_iotlb_pending_remove(struct virtio_net *dev, int asid,
+				uint64_t iova, uint64_t size, uint8_t perm)
 {
 	struct vhost_iotlb_entry *node, *temp_node;
 
-	rte_rwlock_write_lock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_lock(&dev->iotlb[asid]->pending_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next,
+	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb[asid]->pending_list, next,
 				temp_node) {
 		if (node->iova < iova)
 			continue;
@@ -189,53 +200,53 @@ vhost_user_iotlb_pending_remove(struct virtio_net *dev, uint64_t iova, uint64_t
 			continue;
 		if ((node->perm & perm) != node->perm)
 			continue;
-		TAILQ_REMOVE(&dev->iotlb_pending_list, node, next);
-		vhost_user_iotlb_pool_put(dev, node);
+		TAILQ_REMOVE(&dev->iotlb[asid]->pending_list, node, next);
+		vhost_user_iotlb_pool_put(dev, asid, node);
 	}
 
-	rte_rwlock_write_unlock(&dev->iotlb_pending_lock);
+	rte_rwlock_write_unlock(&dev->iotlb[asid]->pending_lock);
 }
 
 static void
-vhost_user_iotlb_cache_remove_all(struct virtio_net *dev)
+vhost_user_iotlb_cache_remove_all(struct virtio_net *dev, int asid)
 {
 	struct vhost_iotlb_entry *node, *temp_node;
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb[asid]->list, next, temp_node) {
 		vhost_user_iotlb_clear_dump(dev, node, NULL, NULL);
 
-		TAILQ_REMOVE(&dev->iotlb_list, node, next);
+		TAILQ_REMOVE(&dev->iotlb[asid]->list, node, next);
 		vhost_user_iotlb_remove_notify(dev, node);
-		vhost_user_iotlb_pool_put(dev, node);
+		vhost_user_iotlb_pool_put(dev, asid, node);
 	}
 
-	dev->iotlb_cache_nr = 0;
+	dev->iotlb[asid]->cache_nr = 0;
 
 	vhost_user_iotlb_wr_unlock_all(dev);
 }
 
 static void
-vhost_user_iotlb_cache_random_evict(struct virtio_net *dev)
+vhost_user_iotlb_cache_random_evict(struct virtio_net *dev, int asid)
 {
 	struct vhost_iotlb_entry *node, *temp_node, *prev_node = NULL;
 	int entry_idx;
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	entry_idx = rte_rand() % dev->iotlb_cache_nr;
+	entry_idx = rte_rand() % dev->iotlb[asid]->cache_nr;
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb[asid]->list, next, temp_node) {
 		if (!entry_idx) {
 			struct vhost_iotlb_entry *next_node = RTE_TAILQ_NEXT(node, next);
 
 			vhost_user_iotlb_clear_dump(dev, node, prev_node, next_node);
 
-			TAILQ_REMOVE(&dev->iotlb_list, node, next);
+			TAILQ_REMOVE(&dev->iotlb[asid]->list, node, next);
 			vhost_user_iotlb_remove_notify(dev, node);
-			vhost_user_iotlb_pool_put(dev, node);
-			dev->iotlb_cache_nr--;
+			vhost_user_iotlb_pool_put(dev, asid, node);
+			dev->iotlb[asid]->cache_nr--;
 			break;
 		}
 		prev_node = node;
@@ -246,20 +257,20 @@ vhost_user_iotlb_cache_random_evict(struct virtio_net *dev)
 }
 
 void
-vhost_user_iotlb_cache_insert(struct virtio_net *dev, uint64_t iova, uint64_t uaddr,
+vhost_user_iotlb_cache_insert(struct virtio_net *dev, int asid, uint64_t iova, uint64_t uaddr,
 				uint64_t uoffset, uint64_t size, uint64_t page_size, uint8_t perm)
 {
 	struct vhost_iotlb_entry *node, *new_node;
 
-	new_node = vhost_user_iotlb_pool_get(dev);
+	new_node = vhost_user_iotlb_pool_get(dev, asid);
 	if (new_node == NULL) {
 		VHOST_CONFIG_LOG(dev->ifname, DEBUG,
 			"IOTLB pool empty, clear entries for cache insertion");
-		if (!TAILQ_EMPTY(&dev->iotlb_list))
-			vhost_user_iotlb_cache_random_evict(dev);
+		if (!TAILQ_EMPTY(&dev->iotlb[asid]->list))
+			vhost_user_iotlb_cache_random_evict(dev, asid);
 		else
-			vhost_user_iotlb_pending_remove_all(dev);
-		new_node = vhost_user_iotlb_pool_get(dev);
+			vhost_user_iotlb_pending_remove_all(dev, asid);
+		new_node = vhost_user_iotlb_pool_get(dev, asid);
 		if (new_node == NULL) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR,
 				"IOTLB pool still empty, cache insertion failed");
@@ -276,36 +287,36 @@ vhost_user_iotlb_cache_insert(struct virtio_net *dev, uint64_t iova, uint64_t ua
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	TAILQ_FOREACH(node, &dev->iotlb_list, next) {
+	TAILQ_FOREACH(node, &dev->iotlb[asid]->list, next) {
 		/*
 		 * Entries must be invalidated before being updated.
 		 * So if iova already in list, assume identical.
 		 */
 		if (node->iova == new_node->iova) {
-			vhost_user_iotlb_pool_put(dev, new_node);
+			vhost_user_iotlb_pool_put(dev, asid, new_node);
 			goto unlock;
 		} else if (node->iova > new_node->iova) {
 			vhost_user_iotlb_set_dump(dev, new_node);
 
 			TAILQ_INSERT_BEFORE(node, new_node, next);
-			dev->iotlb_cache_nr++;
+			dev->iotlb[asid]->cache_nr++;
 			goto unlock;
 		}
 	}
 
 	vhost_user_iotlb_set_dump(dev, new_node);
 
-	TAILQ_INSERT_TAIL(&dev->iotlb_list, new_node, next);
-	dev->iotlb_cache_nr++;
+	TAILQ_INSERT_TAIL(&dev->iotlb[asid]->list, new_node, next);
+	dev->iotlb[asid]->cache_nr++;
 
 unlock:
-	vhost_user_iotlb_pending_remove(dev, iova, size, perm);
+	vhost_user_iotlb_pending_remove(dev, asid, iova, size, perm);
 
 	vhost_user_iotlb_wr_unlock_all(dev);
 }
 
 void
-vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t size)
+vhost_user_iotlb_cache_remove(struct virtio_net *dev, int asid, uint64_t iova, uint64_t size)
 {
 	struct vhost_iotlb_entry *node, *temp_node, *prev_node = NULL;
 
@@ -314,7 +325,7 @@ vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t si
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb[asid]->list, next, temp_node) {
 		/* Sorted list */
 		if (unlikely(iova + size < node->iova))
 			break;
@@ -324,10 +335,10 @@ vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t si
 
 			vhost_user_iotlb_clear_dump(dev, node, prev_node, next_node);
 
-			TAILQ_REMOVE(&dev->iotlb_list, node, next);
+			TAILQ_REMOVE(&dev->iotlb[asid]->list, node, next);
 			vhost_user_iotlb_remove_notify(dev, node);
-			vhost_user_iotlb_pool_put(dev, node);
-			dev->iotlb_cache_nr--;
+			vhost_user_iotlb_pool_put(dev, asid, node);
+			dev->iotlb[asid]->cache_nr--;
 		} else {
 			prev_node = node;
 		}
@@ -337,7 +348,8 @@ vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t si
 }
 
 uint64_t
-vhost_user_iotlb_cache_find(struct virtio_net *dev, uint64_t iova, uint64_t *size, uint8_t perm)
+vhost_user_iotlb_cache_find(struct virtio_net *dev, int asid,
+			    uint64_t iova, uint64_t *size, uint8_t perm)
 {
 	struct vhost_iotlb_entry *node;
 	uint64_t offset, vva = 0, mapped = 0;
@@ -345,7 +357,7 @@ vhost_user_iotlb_cache_find(struct virtio_net *dev, uint64_t iova, uint64_t *siz
 	if (unlikely(!*size))
 		goto out;
 
-	TAILQ_FOREACH(node, &dev->iotlb_list, next) {
+	TAILQ_FOREACH(node, &dev->iotlb[asid]->list, next) {
 		/* List sorted by iova */
 		if (unlikely(iova < node->iova))
 			break;
@@ -378,25 +390,28 @@ vhost_user_iotlb_cache_find(struct virtio_net *dev, uint64_t iova, uint64_t *siz
 }
 
 void
-vhost_user_iotlb_flush_all(struct virtio_net *dev)
+vhost_user_iotlb_flush_all(struct virtio_net *dev, int asid)
 {
-	vhost_user_iotlb_cache_remove_all(dev);
-	vhost_user_iotlb_pending_remove_all(dev);
+	vhost_user_iotlb_cache_remove_all(dev, asid);
+	vhost_user_iotlb_pending_remove_all(dev, asid);
 }
 
-int
-vhost_user_iotlb_init(struct virtio_net *dev)
+static int
+vhost_user_iotlb_init_one(struct virtio_net *dev, int asid)
 {
 	unsigned int i;
 	int socket = 0;
 
-	if (dev->iotlb_pool) {
-		/*
-		 * The cache has already been initialized,
-		 * just drop all cached and pending entries.
-		 */
-		vhost_user_iotlb_flush_all(dev);
-		rte_free(dev->iotlb_pool);
+	if (dev->iotlb[asid]) {
+		if (dev->iotlb[asid]->pool) {
+			/*
+			 * The cache has already been initialized,
+			 * just drop all cached and pending entries.
+			 */
+			vhost_user_iotlb_flush_all(dev, asid);
+			rte_free(dev->iotlb[asid]->pool);
+		}
+		rte_free(dev->iotlb[asid]);
 	}
 
 #ifdef RTE_LIBRTE_VHOST_NUMA
@@ -404,31 +419,68 @@ vhost_user_iotlb_init(struct virtio_net *dev)
 		socket = 0;
 #endif
 
-	rte_spinlock_init(&dev->iotlb_free_lock);
-	rte_rwlock_init(&dev->iotlb_pending_lock);
+	dev->iotlb[asid] = rte_malloc_socket("iotlb", sizeof(struct iotlb), 0, socket);
+	if (!dev->iotlb[asid]) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to allocate IOTLB");
+		return -1;
+	}
+
+	rte_spinlock_init(&dev->iotlb[asid]->free_lock);
+	rte_rwlock_init(&dev->iotlb[asid]->pending_lock);
 
-	SLIST_INIT(&dev->iotlb_free_list);
-	TAILQ_INIT(&dev->iotlb_list);
-	TAILQ_INIT(&dev->iotlb_pending_list);
+	SLIST_INIT(&dev->iotlb[asid]->free_list);
+	TAILQ_INIT(&dev->iotlb[asid]->list);
+	TAILQ_INIT(&dev->iotlb[asid]->pending_list);
 
 	if (dev->flags & VIRTIO_DEV_SUPPORT_IOMMU) {
-		dev->iotlb_pool = rte_calloc_socket("iotlb", IOTLB_CACHE_SIZE,
+		dev->iotlb[asid]->pool = rte_calloc_socket("iotlb_pool", IOTLB_CACHE_SIZE,
 			sizeof(struct vhost_iotlb_entry), 0, socket);
-		if (!dev->iotlb_pool) {
+		if (!dev->iotlb[asid]->pool) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR, "Failed to create IOTLB cache pool");
 			return -1;
 		}
 		for (i = 0; i < IOTLB_CACHE_SIZE; i++)
-			vhost_user_iotlb_pool_put(dev, &dev->iotlb_pool[i]);
+			vhost_user_iotlb_pool_put(dev, asid, &dev->iotlb[asid]->pool[i]);
 	}
 
-	dev->iotlb_cache_nr = 0;
+	dev->iotlb[asid]->cache_nr = 0;
 
 	return 0;
 }
 
+int
+vhost_user_iotlb_init(struct virtio_net *dev)
+{
+	int i;
+
+	for (i = 0; i < IOTLB_MAX_ASID; i++)
+		if (vhost_user_iotlb_init_one(dev, i) < 0)
+			goto fail;
+
+	return 0;
+fail:
+	while (i--)
+	{
+		rte_free(dev->iotlb[i]->pool);
+		dev->iotlb[i]->pool = NULL;
+	}
+
+	return -1;
+}
+
 void
 vhost_user_iotlb_destroy(struct virtio_net *dev)
 {
-	rte_free(dev->iotlb_pool);
+	int i;
+
+	for (i = 0; i < IOTLB_MAX_ASID; i++)
+	{
+		if (dev->iotlb[i]) {
+			rte_free(dev->iotlb[i]->pool);
+			dev->iotlb[i]->pool = NULL;
+
+			rte_free(dev->iotlb[i]);
+			dev->iotlb[i] = NULL;
+		}
+	}
 }
diff --git a/lib/vhost/iotlb.h b/lib/vhost/iotlb.h
index 72232b0dcf08..52963d6c4de0 100644
--- a/lib/vhost/iotlb.h
+++ b/lib/vhost/iotlb.h
@@ -57,16 +57,16 @@ vhost_user_iotlb_wr_unlock_all(struct virtio_net *dev)
 		rte_rwlock_write_unlock(&dev->virtqueue[i]->iotlb_lock);
 }
 
-void vhost_user_iotlb_cache_insert(struct virtio_net *dev, uint64_t iova, uint64_t uaddr,
+void vhost_user_iotlb_cache_insert(struct virtio_net *dev, int asid, uint64_t iova, uint64_t uaddr,
 		uint64_t uoffset, uint64_t size, uint64_t page_size, uint8_t perm);
-void vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t size);
-uint64_t vhost_user_iotlb_cache_find(struct virtio_net *dev, uint64_t iova,
+void vhost_user_iotlb_cache_remove(struct virtio_net *dev, int asid, uint64_t iova, uint64_t size);
+uint64_t vhost_user_iotlb_cache_find(struct virtio_net *dev, int asid, uint64_t iova,
 					uint64_t *size, uint8_t perm);
-bool vhost_user_iotlb_pending_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm);
-void vhost_user_iotlb_pending_insert(struct virtio_net *dev, uint64_t iova, uint8_t perm);
-void vhost_user_iotlb_pending_remove(struct virtio_net *dev, uint64_t iova,
+bool vhost_user_iotlb_pending_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm);
+void vhost_user_iotlb_pending_insert(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm);
+void vhost_user_iotlb_pending_remove(struct virtio_net *dev, int asid, uint64_t iova,
 						uint64_t size, uint8_t perm);
-void vhost_user_iotlb_flush_all(struct virtio_net *dev);
+void vhost_user_iotlb_flush_all(struct virtio_net *dev, int asid);
 int vhost_user_iotlb_init(struct virtio_net *dev);
 void vhost_user_iotlb_destroy(struct virtio_net *dev);
 
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 0b5d158feeb9..49f2f23b9703 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -57,7 +57,7 @@ vduse_iotlb_remove_notify(uint64_t addr, uint64_t offset, uint64_t size)
 }
 
 static int
-vduse_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm __rte_unused)
+vduse_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm __rte_unused)
 {
 	struct vduse_iotlb_entry entry;
 	uint64_t size, page_size;
@@ -102,7 +102,7 @@ vduse_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm __rte_unuse
 	}
 	page_size = (uint64_t)stat.st_blksize;
 
-	vhost_user_iotlb_cache_insert(dev, entry.start, (uint64_t)(uintptr_t)mmap_addr,
+	vhost_user_iotlb_cache_insert(dev, asid, entry.start, (uint64_t)(uintptr_t)mmap_addr,
 		entry.offset, size, page_size, entry.perm);
 
 	ret = 0;
@@ -398,7 +398,8 @@ vduse_device_stop(struct virtio_net *dev)
 	for (i = 0; i < dev->nr_vring; i++)
 		vduse_vring_cleanup(dev, i);
 
-	vhost_user_iotlb_flush_all(dev);
+	for (i = 0; i < IOTLB_MAX_ASID; i++)
+		vhost_user_iotlb_flush_all(dev, i);
 }
 
 static void
@@ -445,8 +446,8 @@ vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 	case VDUSE_UPDATE_IOTLB:
 		VHOST_CONFIG_LOG(dev->ifname, INFO, "\tIOVA range: %" PRIx64 " - %" PRIx64,
 				(uint64_t)req.iova.start, (uint64_t)req.iova.last);
-		vhost_user_iotlb_cache_remove(dev, req.iova.start,
-				req.iova.last - req.iova.start + 1);
+		vhost_user_iotlb_cache_remove(dev, 0, req.iova.start,
+				req.iova.last - req.iova.start + 1); /* ToDo: use ASID once API available, using 0 for now */
 		resp.result = VDUSE_REQ_RESULT_OK;
 		break;
 	default:
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 7e68b2c3be92..cb3af28671cc 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -62,9 +62,9 @@ static const struct vhost_vq_stats_name_off vhost_vq_stat_strings[] = {
 #define VHOST_NB_VQ_STATS RTE_DIM(vhost_vq_stat_strings)
 
 static int
-vhost_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm)
+vhost_iotlb_miss(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm)
 {
-	return dev->backend_ops->iotlb_miss(dev, iova, perm);
+	return dev->backend_ops->iotlb_miss(dev, asid, iova, perm);
 }
 
 uint64_t
@@ -78,7 +78,7 @@ __vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
 
 	tmp_size = *size;
 
-	vva = vhost_user_iotlb_cache_find(dev, iova, &tmp_size, perm);
+	vva = vhost_user_iotlb_cache_find(dev, vq->asid, iova, &tmp_size, perm);
 	if (tmp_size == *size) {
 		if (dev->flags & VIRTIO_DEV_STATS_ENABLED)
 			vq->stats.iotlb_hits++;
@@ -90,7 +90,7 @@ __vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
 
 	iova += tmp_size;
 
-	if (!vhost_user_iotlb_pending_miss(dev, iova, perm)) {
+	if (!vhost_user_iotlb_pending_miss(dev, vq->asid, iova, perm)) {
 		/*
 		 * iotlb_lock is read-locked for a full burst,
 		 * but it only protects the iotlb cache.
@@ -100,12 +100,12 @@ __vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
 		 */
 		vhost_user_iotlb_rd_unlock(vq);
 
-		vhost_user_iotlb_pending_insert(dev, iova, perm);
-		if (vhost_iotlb_miss(dev, iova, perm)) {
+		vhost_user_iotlb_pending_insert(dev, vq->asid, iova, perm);
+		if (vhost_iotlb_miss(dev, vq->asid, iova, perm)) {
 			VHOST_DATA_LOG(dev->ifname, ERR,
 				"IOTLB miss req failed for IOVA 0x%" PRIx64,
 				iova);
-			vhost_user_iotlb_pending_remove(dev, iova, 1, perm);
+			vhost_user_iotlb_pending_remove(dev, vq->asid, iova, 1, perm);
 		}
 
 		vhost_user_iotlb_rd_lock(vq);
@@ -113,7 +113,7 @@ __vhost_iova_to_vva(struct virtio_net *dev, struct vhost_virtqueue *vq,
 
 	tmp_size = *size;
 	/* Retry in case of VDUSE, as it is synchronous */
-	vva = vhost_user_iotlb_cache_find(dev, iova, &tmp_size, perm);
+	vva = vhost_user_iotlb_cache_find(dev, vq->asid, iova, &tmp_size, perm);
 	if (tmp_size == *size)
 		return vva;
 
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index ee61f7415ee3..fef493016df5 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -85,7 +85,7 @@ struct vhost_virtqueue;
 
 typedef void (*vhost_iotlb_remove_notify)(uint64_t addr, uint64_t off, uint64_t size);
 
-typedef int (*vhost_iotlb_miss_cb)(struct virtio_net *dev, uint64_t iova, uint8_t perm);
+typedef int (*vhost_iotlb_miss_cb)(struct virtio_net *dev, int asid, uint64_t iova, uint8_t perm);
 
 typedef int (*vhost_vring_inject_irq_cb)(struct virtio_net *dev, struct vhost_virtqueue *vq);
 /**
@@ -326,6 +326,7 @@ struct __rte_cache_aligned vhost_virtqueue {
 	uint16_t		batch_copy_nb_elems;
 	struct batch_copy_elem	*batch_copy_elems;
 	int			numa_node;
+	int 			asid;
 	bool			used_wrap_counter;
 	bool			avail_wrap_counter;
 
@@ -483,6 +484,8 @@ struct inflight_mem_info {
 	uint64_t	size;
 };
 
+#define IOTLB_MAX_ASID 2
+
 /**
  * Device structure contains all configuration information relating
  * to the device.
@@ -504,13 +507,7 @@ struct __rte_cache_aligned virtio_net {
 	int			linearbuf;
 	struct vhost_virtqueue	*virtqueue[VHOST_MAX_VRING];
 
-	rte_rwlock_t	iotlb_pending_lock;
-	struct vhost_iotlb_entry *iotlb_pool;
-	TAILQ_HEAD(, vhost_iotlb_entry) iotlb_list;
-	TAILQ_HEAD(, vhost_iotlb_entry) iotlb_pending_list;
-	int				iotlb_cache_nr;
-	rte_spinlock_t	iotlb_free_lock;
-	SLIST_HEAD(, vhost_iotlb_entry) iotlb_free_list;
+	struct iotlb 		*iotlb[IOTLB_MAX_ASID];
 
 	struct inflight_mem_info *inflight_info;
 #define IF_NAME_SZ (PATH_MAX > IFNAMSIZ ? PATH_MAX : IFNAMSIZ)
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98ce..5581da12d21c 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -1433,7 +1433,8 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 
 		/* Flush IOTLB cache as previous HVAs are now invalid */
 		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
-			vhost_user_iotlb_flush_all(dev);
+			for (i = 0; i < IOTLB_MAX_ASID; i++)
+				vhost_user_iotlb_flush_all(dev, i);
 
 		free_mem_region(dev);
 		rte_free(dev->mem);
@@ -2267,7 +2268,7 @@ vhost_user_get_vring_base(struct virtio_net **pdev,
 	ctx->msg.size = sizeof(ctx->msg.payload.state);
 	ctx->fd_num = 0;
 
-	vhost_user_iotlb_flush_all(dev);
+	vhost_user_iotlb_flush_all(dev, vq->asid);
 
 	rte_rwlock_write_lock(&vq->access_lock);
 	vring_invalidate(dev, vq);
@@ -2716,7 +2717,7 @@ vhost_user_iotlb_msg(struct virtio_net **pdev,
 
 		pg_sz = hua_to_alignment(dev->mem, (void *)(uintptr_t)vva);
 
-		vhost_user_iotlb_cache_insert(dev, imsg->iova, vva, 0, len, pg_sz, imsg->perm);
+		vhost_user_iotlb_cache_insert(dev, 0, imsg->iova, vva, 0, len, pg_sz, imsg->perm);
 
 		for (i = 0; i < dev->nr_vring; i++) {
 			struct vhost_virtqueue *vq = dev->virtqueue[i];
@@ -2733,7 +2734,7 @@ vhost_user_iotlb_msg(struct virtio_net **pdev,
 		}
 		break;
 	case VHOST_IOTLB_INVALIDATE:
-		vhost_user_iotlb_cache_remove(dev, imsg->iova, imsg->size);
+		vhost_user_iotlb_cache_remove(dev, 0, imsg->iova, imsg->size);
 
 		for (i = 0; i < dev->nr_vring; i++) {
 			struct vhost_virtqueue *vq = dev->virtqueue[i];
@@ -3326,7 +3327,7 @@ vhost_user_msg_handler(int vid, int fd)
 }
 
 static int
-vhost_user_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm)
+vhost_user_iotlb_miss(struct virtio_net *dev, int asid __rte_unused, uint64_t iova, uint8_t perm)
 {
 	int ret;
 	struct vhu_msg_context ctx = {
-- 
2.53.0

