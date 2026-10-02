Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA4ACA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C929440608;
	Fri,  2 Oct 2026 09:44:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB1384003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 09:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790927095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFBYtWj1A6yjKqBQZ8WeMiJLKE9v50ZNTlLUCjHXm0M=;
 b=emOcC/Tq9h24iMEzEml5kLWZp9OaEAQrGwQaVao93NRoZkXeMNYXVrXafP49/phYJDPj3s
 QY4j7NJ4S5VoiPqLCHEfdOV7h5RQN+xxwD4wxhx7r6qWw4N57m//OHEKVFUYUl4bt6jSXW
 KcanHhD+DokneTPmHTKHJGvPS4mXo2Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-_vax3PQkO8WWN9bmGx4vyQ-1; Fri,
 02 Oct 2026 03:44:52 -0400
X-MC-Unique: _vax3PQkO8WWN9bmGx4vyQ-1
X-Mimecast-MFC-AGG-ID: _vax3PQkO8WWN9bmGx4vyQ_1790927091
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0C12184AE64; Fri,  2 Oct 2026 07:44:50 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72D215BC; Fri,  2 Oct 2026 07:44:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 1/6] vhost: decouple guest pages population from async
 datapath
Date: Fri,  2 Oct 2026 09:44:35 +0200
Message-ID: <20261002074440.2551536-2-david.marchand@redhat.com>
In-Reply-To: <20261002074440.2551536-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20261002074440.2551536-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7znvRQEvbH02IKe33BKGPV3eWpnGqGBNsjmzxGeCs_o_1790927091
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

The vhost crypto zero-copy feature relies on the
RTE_VHOST_USER_ASYNC_COPY flag to enable guest page tracking
(guest_pages array population and MAP_POPULATE during mmap).

Introduce a RTE_VHOST_USER_MAP_POPULATE flag that maps to
RTE_VHOST_USER_ASYNC_COPY at this point in time.

Adjust vhost_crypto example and remove the unnecessary
ALLOW_EXPERIMENTAL_API flag as this example does not use any
experimental APIs.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
Changes since v2:
- updated release notes for new flag,
- fixed checks on map populate feature,

---
 doc/guides/prog_guide/vhost_lib.rst    |  9 +++++++++
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 examples/vhost_crypto/Makefile         |  1 -
 examples/vhost_crypto/main.c           |  2 +-
 examples/vhost_crypto/meson.build      |  1 -
 lib/vhost/rte_vhost.h                  |  1 +
 lib/vhost/socket.c                     | 19 +++++++++++++++----
 lib/vhost/vhost.h                      |  1 +
 lib/vhost/vhost_user.c                 |  4 ++--
 9 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 345a621716..2bea814a62 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -118,6 +118,15 @@ The following is an overview of some key Vhost API functions:
 
     It is disabled by default.
 
+  - ``RTE_VHOST_USER_MAP_POPULATE``
+
+    Guest memory regions will be mapped with ``MAP_POPULATE`` when this flag
+    is set, pre-faulting pages into memory. This is useful for applications
+    requiring direct access to guest memory, such as vhost-crypto zero-copy
+    operations.
+
+    It is disabled by default.
+
   - ``RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS``
 
     Since v16.04, the vhost library forwards checksum and gso requests for
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea..ecc575ff09 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -309,6 +309,10 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* vhost: Introduced ``RTE_VHOST_USER_MAP_POPULATE`` as a replacement of
+  ``RTE_VHOST_USER_ASYNC_COPY`` for users that did not rely on the vhost
+  async copy feature but expected guest pages to be prefaulted.
+
 * reorder: Promoted the following API from experimental to stable:
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
diff --git a/examples/vhost_crypto/Makefile b/examples/vhost_crypto/Makefile
index cc7f2abb90..130953c38e 100644
--- a/examples/vhost_crypto/Makefile
+++ b/examples/vhost_crypto/Makefile
@@ -6,7 +6,6 @@ APP = vhost-crypto
 
 # all source are stored in SRCS-y
 SRCS-y := main.c
-CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 PKGCONF ?= pkg-config
 
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 8bdfc40c4b..53bd8fa825 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -623,7 +623,7 @@ main(int argc, char *argv[])
 
 		for (j = 0; j < lo->nb_sockets; j++) {
 			ret = rte_vhost_driver_register(lo->socket_files[j],
-				RTE_VHOST_USER_ASYNC_COPY);
+				RTE_VHOST_USER_MAP_POPULATE);
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1, "socket %s already exists\n",
 					lo->socket_files[j]);
diff --git a/examples/vhost_crypto/meson.build b/examples/vhost_crypto/meson.build
index 1c294c286f..47c8fa829f 100644
--- a/examples/vhost_crypto/meson.build
+++ b/examples/vhost_crypto/meson.build
@@ -6,7 +6,6 @@
 # To build this example as a standalone application with an already-installed
 # DPDK instance, use 'make'
 
-allow_experimental_apis = true
 deps += ['vhost', 'cryptodev']
 sources = files(
         'main.c',
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index a7f9700538..095f9b6d3c 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -39,6 +39,7 @@ extern "C" {
 /* support only linear buffers (no chained mbufs) */
 #define RTE_VHOST_USER_LINEARBUF_SUPPORT	(1ULL << 6)
 #define RTE_VHOST_USER_ASYNC_COPY	(1ULL << 7)
+#define RTE_VHOST_USER_MAP_POPULATE	RTE_VHOST_USER_ASYNC_COPY
 #define RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS	(1ULL << 8)
 #define RTE_VHOST_USER_NET_STATS_ENABLE	(1ULL << 9)
 #define RTE_VHOST_USER_ASYNC_CONNECT	(1ULL << 10)
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 0943b3e9bb..956f3b2d71 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -44,6 +44,7 @@ struct vhost_user_socket {
 	bool extbuf;
 	bool linearbuf;
 	bool async_copy;
+	bool map_populate;
 	bool net_compliant_ol_flags;
 	bool stats_enabled;
 	bool async_connect;
@@ -246,6 +247,13 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 			dev->async_copy = 1;
 	}
 
+	if (vsocket->map_populate) {
+		dev = get_device(vid);
+
+		if (dev)
+			dev->map_populate = 1;
+	}
+
 	VHOST_CONFIG_LOG(vsocket->path, INFO, "new device, handle is %d", vid);
 
 	if (vsocket->notify_ops->new_connection) {
@@ -937,6 +945,7 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	vsocket->extbuf = flags & RTE_VHOST_USER_EXTBUF_SUPPORT;
 	vsocket->linearbuf = flags & RTE_VHOST_USER_LINEARBUF_SUPPORT;
 	vsocket->async_copy = flags & RTE_VHOST_USER_ASYNC_COPY;
+	vsocket->map_populate = flags & RTE_VHOST_USER_MAP_POPULATE;
 	vsocket->net_compliant_ol_flags = flags & RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 	vsocket->stats_enabled = flags & RTE_VHOST_USER_NET_STATS_ENABLE;
 	vsocket->async_connect = flags & RTE_VHOST_USER_ASYNC_CONNECT;
@@ -945,9 +954,10 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	else
 		vsocket->iommu_support = flags & RTE_VHOST_USER_IOMMU_SUPPORT;
 
-	if (vsocket->async_copy && (vsocket->iommu_support ||
+	if (vsocket->map_populate && (vsocket->iommu_support ||
 				(flags & RTE_VHOST_USER_POSTCOPY_SUPPORT))) {
-		VHOST_CONFIG_LOG(path, ERR, "async copy with IOMMU or post-copy not supported");
+		VHOST_CONFIG_LOG(path, ERR,
+			"guest pages prefaulting not supported with IOMMU or post-copy");
 		goto out_mutex;
 	}
 
@@ -973,10 +983,11 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 		vsocket->protocol_features  = VHOST_USER_PROTOCOL_FEATURES;
 	}
 
-	if (vsocket->async_copy) {
+	if (vsocket->map_populate) {
 		vsocket->supported_features &= ~(1ULL << VHOST_F_LOG_ALL);
 		vsocket->features &= ~(1ULL << VHOST_F_LOG_ALL);
-		VHOST_CONFIG_LOG(path, INFO, "logging feature is disabled in async copy mode");
+		VHOST_CONFIG_LOG(path, INFO,
+			"logging feature is disabled with guest pages prefaulting");
 	}
 
 	/*
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index bb4708aed5..7b5c6ccbe2 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -499,6 +499,7 @@ struct __rte_cache_aligned virtio_net {
 	RTE_ATOMIC(int16_t)	broadcast_rarp;
 	uint32_t		nr_vring;
 	int			async_copy;
+	int			map_populate;
 
 	int			extbuf;
 	int			linearbuf;
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 020c993b29..e87ab82e63 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -1384,7 +1384,7 @@ vhost_user_mmap_region(struct virtio_net *dev,
 		return -1;
 	}
 
-	populate = dev->async_copy ? MAP_POPULATE : 0;
+	populate = dev->map_populate ? MAP_POPULATE : 0;
 	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_SHARED | populate, region->fd, 0);
 
@@ -1398,7 +1398,7 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	region->host_user_addr = (uint64_t)(uintptr_t)mmap_addr + mmap_offset;
 	mem_set_dump(dev, mmap_addr, mmap_size, false, alignment);
 
-	if (dev->async_copy) {
+	if (dev->map_populate) {
 		if (add_guest_pages(dev, region, alignment) < 0) {
 			VHOST_CONFIG_LOG(dev->ifname, ERR,
 				"adding guest pages to region failed.");
-- 
2.54.0

