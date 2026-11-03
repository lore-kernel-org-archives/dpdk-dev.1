Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C6606A794
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ekme3GL+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC37141104;
	Tue,  3 Nov 2026 15:55:45 +0100 (CET)
Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 703304111C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:44 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=emFxiu+vOwwZ1JzAYcDxHrrex5ADs/zamHRQDVGxxCA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717744; v=1; x=1794322544;
 b=ekme3GL+WMDwl+utOHfiIU2FdYXsjLR6cryvsSeNNoiSP2F1Wi6ppAxB4NpHColrp/HPYkvi
 hLL78bt1akw0GgBqfClDRc64rPrzL9WyoC1rY7YXJedokXrdo871M93xlODxm6LrG9h5agG7Fi5
 ePUMlC8z1c11G496eYg4kSJw=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 5f3a4461cba2b929;
 Tue, 03 Nov 2026 14:55:44 +0000
X-Mizu-Trace-ID: 5f3a4461cba2b929
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 016/227] gro: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:34 +0800
Message-ID: <20261103145306.487255-17-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the numa_id field of rte_gro_param (was socket_id),
keeping socket_id as a deprecated union alias, and update
in-tree users accordingly.

Also rename socket_id parameters, internal variables and
comments to the NUMA node terminology, and switch internal
calls to rte_zmalloc_numa() and rte_numa_id().

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/testpmd.c   |  2 +-
 lib/gro/gro_tcp4.c       | 14 +++++++-------
 lib/gro/gro_tcp4.h       |  6 +++---
 lib/gro/gro_tcp6.c       | 14 +++++++-------
 lib/gro/gro_tcp6.h       |  6 +++---
 lib/gro/gro_udp4.c       | 14 +++++++-------
 lib/gro/gro_udp4.h       |  6 +++---
 lib/gro/gro_vxlan_tcp4.c | 14 +++++++-------
 lib/gro/gro_vxlan_tcp4.h |  6 +++---
 lib/gro/gro_vxlan_udp4.c | 14 +++++++-------
 lib/gro/gro_vxlan_udp4.h |  6 +++---
 lib/gro/rte_gro.c        |  8 ++++----
 lib/gro/rte_gro.h        | 17 ++++++++++++-----
 13 files changed, 67 insertions(+), 60 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index c99b54a003..bbef4a8580 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1886,7 +1886,7 @@ init_config(void)
 	gro_param.max_flow_num = GRO_MAX_FLUSH_CYCLES;
 	gro_param.max_item_per_flow = MAX_PKT_BURST;
 	for (lc_id = 0; lc_id < nb_lcores; lc_id++) {
-		gro_param.socket_id = rte_lcore_to_socket_id(
+		gro_param.numa_id = rte_lcore_to_numa_id(
 				fwd_lcores_cpuids[lc_id]);
 		fwd_lcores[lc_id]->gro_ctx = rte_gro_ctx_create(&gro_param);
 		if (fwd_lcores[lc_id]->gro_ctx == NULL) {
diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d..e4956c7618 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -10,7 +10,7 @@
 #include "gro_tcp_internal.h"
 
 void *
-gro_tcp4_tbl_create(uint16_t socket_id,
+gro_tcp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
@@ -24,18 +24,18 @@ gro_tcp4_tbl_create(uint16_t socket_id,
 	if (entries_num == 0)
 		return NULL;
 
-	tbl = rte_zmalloc_socket(__func__,
+	tbl = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_tcp4_tbl),
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl == NULL)
 		return NULL;
 
 	size = sizeof(struct gro_tcp_item) * entries_num;
-	tbl->items = rte_zmalloc_socket(__func__,
+	tbl->items = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->items == NULL) {
 		rte_free(tbl);
 		return NULL;
@@ -43,10 +43,10 @@ gro_tcp4_tbl_create(uint16_t socket_id,
 	tbl->max_item_num = entries_num;
 
 	size = sizeof(struct gro_tcp4_flow) * entries_num;
-	tbl->flows = rte_zmalloc_socket(__func__,
+	tbl->flows = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->flows == NULL) {
 		rte_free(tbl->items);
 		rte_free(tbl);
diff --git a/lib/gro/gro_tcp4.h b/lib/gro/gro_tcp4.h
index 245e5da486..a55814970c 100644
--- a/lib/gro/gro_tcp4.h
+++ b/lib/gro/gro_tcp4.h
@@ -46,8 +46,8 @@ struct gro_tcp4_tbl {
 /**
  * This function creates a TCP/IPv4 reassembly table.
  *
- * @param socket_id
- *  Socket index for allocating the TCP/IPv4 reassemble table
+ * @param numa_id
+ *  NUMA node index for allocating the TCP/IPv4 reassemble table
  * @param max_flow_num
  *  The maximum number of flows in the TCP/IPv4 GRO table
  * @param max_item_per_flow
@@ -57,7 +57,7 @@ struct gro_tcp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_tcp4_tbl_create(uint16_t socket_id,
+void *gro_tcp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_tcp6.c b/lib/gro/gro_tcp6.c
index ab4cd6c68b..3d8914d1c7 100644
--- a/lib/gro/gro_tcp6.c
+++ b/lib/gro/gro_tcp6.c
@@ -10,7 +10,7 @@
 #include "gro_tcp_internal.h"
 
 void *
-gro_tcp6_tbl_create(uint16_t socket_id,
+gro_tcp6_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
@@ -24,18 +24,18 @@ gro_tcp6_tbl_create(uint16_t socket_id,
 	if (entries_num == 0)
 		return NULL;
 
-	tbl = rte_zmalloc_socket(__func__,
+	tbl = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_tcp6_tbl),
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl == NULL)
 		return NULL;
 
 	size = sizeof(struct gro_tcp_item) * entries_num;
-	tbl->items = rte_zmalloc_socket(__func__,
+	tbl->items = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->items == NULL) {
 		rte_free(tbl);
 		return NULL;
@@ -43,10 +43,10 @@ gro_tcp6_tbl_create(uint16_t socket_id,
 	tbl->max_item_num = entries_num;
 
 	size = sizeof(struct gro_tcp6_flow) * entries_num;
-	tbl->flows = rte_zmalloc_socket(__func__,
+	tbl->flows = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->flows == NULL) {
 		rte_free(tbl->items);
 		rte_free(tbl);
diff --git a/lib/gro/gro_tcp6.h b/lib/gro/gro_tcp6.h
index acf3971bb6..8e9f628c26 100644
--- a/lib/gro/gro_tcp6.h
+++ b/lib/gro/gro_tcp6.h
@@ -49,8 +49,8 @@ struct gro_tcp6_tbl {
 /**
  * This function creates a TCP/IPv6 reassembly table.
  *
- * @param socket_id
- *  Socket index for allocating the TCP/IPv6 reassemble table
+ * @param numa_id
+ *  NUMA node index for allocating the TCP/IPv6 reassemble table
  * @param max_flow_num
  *  The maximum number of flows in the TCP/IPv6 GRO table
  * @param max_item_per_flow
@@ -60,7 +60,7 @@ struct gro_tcp6_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_tcp6_tbl_create(uint16_t socket_id,
+void *gro_tcp6_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_udp4.c b/lib/gro/gro_udp4.c
index 019e05bcde..7313a96246 100644
--- a/lib/gro/gro_udp4.c
+++ b/lib/gro/gro_udp4.c
@@ -9,7 +9,7 @@
 #include "gro_udp4.h"
 
 void *
-gro_udp4_tbl_create(uint16_t socket_id,
+gro_udp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
@@ -23,18 +23,18 @@ gro_udp4_tbl_create(uint16_t socket_id,
 	if (entries_num == 0)
 		return NULL;
 
-	tbl = rte_zmalloc_socket(__func__,
+	tbl = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_udp4_tbl),
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl == NULL)
 		return NULL;
 
 	size = sizeof(struct gro_udp4_item) * entries_num;
-	tbl->items = rte_zmalloc_socket(__func__,
+	tbl->items = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->items == NULL) {
 		rte_free(tbl);
 		return NULL;
@@ -42,10 +42,10 @@ gro_udp4_tbl_create(uint16_t socket_id,
 	tbl->max_item_num = entries_num;
 
 	size = sizeof(struct gro_udp4_flow) * entries_num;
-	tbl->flows = rte_zmalloc_socket(__func__,
+	tbl->flows = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->flows == NULL) {
 		rte_free(tbl->items);
 		rte_free(tbl);
diff --git a/lib/gro/gro_udp4.h b/lib/gro/gro_udp4.h
index 6467d7bc3b..d6e1b0cd95 100644
--- a/lib/gro/gro_udp4.h
+++ b/lib/gro/gro_udp4.h
@@ -87,8 +87,8 @@ struct gro_udp4_tbl {
 /**
  * This function creates a UDP/IPv4 reassembly table.
  *
- * @param socket_id
- *  Socket index for allocating the UDP/IPv4 reassemble table
+ * @param numa_id
+ *  NUMA node index for allocating the UDP/IPv4 reassemble table
  * @param max_flow_num
  *  The maximum number of flows in the UDP/IPv4 GRO table
  * @param max_item_per_flow
@@ -98,7 +98,7 @@ struct gro_udp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_udp4_tbl_create(uint16_t socket_id,
+void *gro_udp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_vxlan_tcp4.c b/lib/gro/gro_vxlan_tcp4.c
index 29d4a2e13d..d3b9412269 100644
--- a/lib/gro/gro_vxlan_tcp4.c
+++ b/lib/gro/gro_vxlan_tcp4.c
@@ -10,7 +10,7 @@
 #include "gro_vxlan_tcp4.h"
 
 void *
-gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
+gro_vxlan_tcp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
@@ -24,18 +24,18 @@ gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
 	if (entries_num == 0)
 		return NULL;
 
-	tbl = rte_zmalloc_socket(__func__,
+	tbl = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_vxlan_tcp4_tbl),
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl == NULL)
 		return NULL;
 
 	size = sizeof(struct gro_vxlan_tcp4_item) * entries_num;
-	tbl->items = rte_zmalloc_socket(__func__,
+	tbl->items = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->items == NULL) {
 		rte_free(tbl);
 		return NULL;
@@ -43,10 +43,10 @@ gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
 	tbl->max_item_num = entries_num;
 
 	size = sizeof(struct gro_vxlan_tcp4_flow) * entries_num;
-	tbl->flows = rte_zmalloc_socket(__func__,
+	tbl->flows = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->flows == NULL) {
 		rte_free(tbl->items);
 		rte_free(tbl);
diff --git a/lib/gro/gro_vxlan_tcp4.h b/lib/gro/gro_vxlan_tcp4.h
index 662db01a88..6dcae3a32d 100644
--- a/lib/gro/gro_vxlan_tcp4.h
+++ b/lib/gro/gro_vxlan_tcp4.h
@@ -66,8 +66,8 @@ struct gro_vxlan_tcp4_tbl {
  * This function creates a VxLAN reassembly table for VxLAN packets
  * which have an outer IPv4 header and an inner TCP/IPv4 packet.
  *
- * @param socket_id
- *  Socket index for allocating the table
+ * @param numa_id
+ *  NUMA node index for allocating the table
  * @param max_flow_num
  *  The maximum number of flows in the table
  * @param max_item_per_flow
@@ -77,7 +77,7 @@ struct gro_vxlan_tcp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_vxlan_tcp4_tbl_create(uint16_t socket_id,
+void *gro_vxlan_tcp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/gro_vxlan_udp4.c b/lib/gro/gro_vxlan_udp4.c
index ca8cee270d..7895fa8e3d 100644
--- a/lib/gro/gro_vxlan_udp4.c
+++ b/lib/gro/gro_vxlan_udp4.c
@@ -10,7 +10,7 @@
 #include "gro_vxlan_udp4.h"
 
 void *
-gro_vxlan_udp4_tbl_create(uint16_t socket_id,
+gro_vxlan_udp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow)
 {
@@ -24,18 +24,18 @@ gro_vxlan_udp4_tbl_create(uint16_t socket_id,
 	if (entries_num == 0)
 		return NULL;
 
-	tbl = rte_zmalloc_socket(__func__,
+	tbl = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_vxlan_udp4_tbl),
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl == NULL)
 		return NULL;
 
 	size = sizeof(struct gro_vxlan_udp4_item) * entries_num;
-	tbl->items = rte_zmalloc_socket(__func__,
+	tbl->items = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->items == NULL) {
 		rte_free(tbl);
 		return NULL;
@@ -43,10 +43,10 @@ gro_vxlan_udp4_tbl_create(uint16_t socket_id,
 	tbl->max_item_num = entries_num;
 
 	size = sizeof(struct gro_vxlan_udp4_flow) * entries_num;
-	tbl->flows = rte_zmalloc_socket(__func__,
+	tbl->flows = rte_zmalloc_numa(__func__,
 			size,
 			RTE_CACHE_LINE_SIZE,
-			socket_id);
+			numa_id);
 	if (tbl->flows == NULL) {
 		rte_free(tbl->items);
 		rte_free(tbl);
diff --git a/lib/gro/gro_vxlan_udp4.h b/lib/gro/gro_vxlan_udp4.h
index d045221243..38a3b6a6f6 100644
--- a/lib/gro/gro_vxlan_udp4.h
+++ b/lib/gro/gro_vxlan_udp4.h
@@ -67,8 +67,8 @@ struct gro_vxlan_udp4_tbl {
  * This function creates a VxLAN reassembly table for VxLAN packets
  * which have an outer IPv4 header and an inner UDP/IPv4 packet.
  *
- * @param socket_id
- *  Socket index for allocating the table
+ * @param numa_id
+ *  NUMA node index for allocating the table
  * @param max_flow_num
  *  The maximum number of flows in the table
  * @param max_item_per_flow
@@ -78,7 +78,7 @@ struct gro_vxlan_udp4_tbl {
  *  - Return the table pointer on success.
  *  - Return NULL on failure.
  */
-void *gro_vxlan_udp4_tbl_create(uint16_t socket_id,
+void *gro_vxlan_udp4_tbl_create(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..15d4830b69 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -14,7 +14,7 @@
 #include "gro_vxlan_tcp4.h"
 #include "gro_vxlan_udp4.h"
 
-typedef void *(*gro_tbl_create_fn)(uint16_t socket_id,
+typedef void *(*gro_tbl_create_fn)(uint16_t numa_id,
 		uint16_t max_flow_num,
 		uint16_t max_item_per_flow);
 typedef void (*gro_tbl_destroy_fn)(void *tbl);
@@ -99,10 +99,10 @@ rte_gro_ctx_create(const struct rte_gro_param *param)
 	uint64_t gro_types = 0;
 	uint8_t i;
 
-	gro_ctx = rte_zmalloc_socket(__func__,
+	gro_ctx = rte_zmalloc_numa(__func__,
 			sizeof(struct gro_ctx),
 			RTE_CACHE_LINE_SIZE,
-			param->socket_id);
+			param->numa_id);
 	if (gro_ctx == NULL)
 		return NULL;
 
@@ -115,7 +115,7 @@ rte_gro_ctx_create(const struct rte_gro_param *param)
 		if (create_tbl_fn == NULL)
 			continue;
 
-		gro_ctx->tbls[i] = create_tbl_fn(param->socket_id,
+		gro_ctx->tbls[i] = create_tbl_fn(param->numa_id,
 				param->max_flow_num,
 				param->max_item_per_flow);
 		if (gro_ctx->tbls[i] == NULL) {
diff --git a/lib/gro/rte_gro.h b/lib/gro/rte_gro.h
index c83dfd9ad1..b9d1a7d424 100644
--- a/lib/gro/rte_gro.h
+++ b/lib/gro/rte_gro.h
@@ -53,11 +53,18 @@ struct rte_gro_param {
 	/**< max flow number */
 	uint16_t max_item_per_flow;
 	/**< max packet number per flow */
-	uint16_t socket_id;
-	/**< socket index for allocating GRO related data structures,
-	 * like reassembly tables. When use rte_gro_reassemble_burst(),
-	 * applications don't need to set this value.
-	 */
+	union {
+		/** NUMA node index for allocating GRO related data structures,
+		 * like reassembly tables. When use rte_gro_reassemble_burst(),
+		 * applications don't need to set this value.
+		 */
+		uint16_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		uint16_t socket_id;
+	};
 };
 
 /**
-- 
2.55.0

