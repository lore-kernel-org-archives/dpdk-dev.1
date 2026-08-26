Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A62C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 14:02:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5516C40430;
	Wed, 26 Aug 2026 16:02:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5717C4042E
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787752947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APfenMobTYTJMArR/pW47owxxz0n4ul2zpAIslchGgM=;
 b=g7QxNPwSsXTgh68wDz5eQ/PvKnO4z3yXH9ICu/GTvCEvoqklwPisC/8lqk0f1KK04ORBMQ
 cLY5qSy1emDsgFZUXcO0X67PNxywNJj9VaZBYEoZfPfF6OIi5vGO8DFkZWM+zCkANjHjD+
 UeSNsOq82JPre8ddicb4iGTSRQCKNpM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-0Y0qrHRVM6ucPgDPDIHb3A-1; Wed,
 26 Aug 2026 10:02:25 -0400
X-MC-Unique: 0Y0qrHRVM6ucPgDPDIHb3A-1
X-Mimecast-MFC-AGG-ID: 0Y0qrHRVM6ucPgDPDIHb3A_1787752945
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 422411905620; Wed, 26 Aug 2026 14:02:15 +0000 (UTC)
Received: from dmarchan.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AA9C1955F43; Wed, 26 Aug 2026 14:02:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: maxime.coquelin@redhat.com,
	dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 1/5] vhost: decouple guest pages population from async datapath
Date: Wed, 26 Aug 2026 16:02:02 +0200
Message-ID: <20260826140206.1099433-2-david.marchand@redhat.com>
In-Reply-To: <20260826140206.1099433-1-david.marchand@redhat.com>
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20260826140206.1099433-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4mtkgj6J5iJEsNnkzIKFDlNRGqq2t95NT0KZKs3iKbw_1787752945
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
---
 doc/guides/prog_guide/vhost_lib.rst | 9 +++++++++
 examples/vhost_crypto/Makefile      | 1 -
 examples/vhost_crypto/main.c        | 2 +-
 examples/vhost_crypto/meson.build   | 1 -
 lib/vhost/rte_vhost.h               | 1 +
 lib/vhost/socket.c                  | 9 +++++++++
 lib/vhost/vhost.h                   | 1 +
 lib/vhost/vhost_user.c              | 4 ++--
 8 files changed, 23 insertions(+), 5 deletions(-)

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
index 70e582a18d..8b29271f97 100644
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
@@ -248,6 +249,13 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
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
@@ -939,6 +947,7 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	vsocket->extbuf = flags & RTE_VHOST_USER_EXTBUF_SUPPORT;
 	vsocket->linearbuf = flags & RTE_VHOST_USER_LINEARBUF_SUPPORT;
 	vsocket->async_copy = flags & RTE_VHOST_USER_ASYNC_COPY;
+	vsocket->map_populate = flags & RTE_VHOST_USER_MAP_POPULATE;
 	vsocket->net_compliant_ol_flags = flags & RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
 	vsocket->stats_enabled = flags & RTE_VHOST_USER_NET_STATS_ENABLE;
 	vsocket->async_connect = flags & RTE_VHOST_USER_ASYNC_CONNECT;
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index ee61f7415e..8575a9bb1c 100644
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

