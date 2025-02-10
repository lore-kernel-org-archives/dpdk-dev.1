Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AE7C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:44:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 277B340B91;
	Mon, 10 Feb 2025 18:44:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E95540A77
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739209496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gz0yP260dx7ZxS8I5+aaegGmJcLQv07GkdvupUev5ks=;
 b=WWnWZF2Mh9/PGyN7NSep3qXC6mxqiSyUEff29rAA48MgwOAsxpXponDbKnv0flZ1jDNKwT
 AEAZGaIpROne/Kzjwpervg9Get7TQ3fko5a5gihT3FIRRrCcmMAJ/iztcLV8zV6FhXU61k
 Bejs/N6PXh1DQOe58pheIX04W0Wg90c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-_6qquusvPTabgRRrcOX2ZA-1; Mon,
 10 Feb 2025 12:44:52 -0500
X-MC-Unique: _6qquusvPTabgRRrcOX2ZA-1
X-Mimecast-MFC-AGG-ID: _6qquusvPTabgRRrcOX2ZA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 479E819560B4; Mon, 10 Feb 2025 17:44:49 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA48C19560AE; Mon, 10 Feb 2025 17:44:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, fengchengwen@huawei.com,
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/6] trace: support expression for blob length
Date: Mon, 10 Feb 2025 18:44:19 +0100
Message-ID: <20250210174424.3364021-4-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xP7o6UMzVIEUukOgKgQJzu0lq323NJjJiyNJWRrUUcQ_1739209489
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

Support any expression as a blob length by using an intermediate
variable in the trace point emitter itself.
This also avoids any side effect on the passed variable.

On the "register" side, prefix the length variable in the trace metadata
with the name of the emitted argument.

With this, we can update ethdev traces and avoid intermediate variables.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v2:
- fixed length field in CTF metadata,

Changes since v1:
- removed code relying on arguments in "registering"
  rte_trace_point_emit_blob implementation (see patch 3),
- moved build check in non registering __rte_trace_point_emit,

---
 lib/eal/common/eal_common_trace_ctf.c      |  1 +
 lib/eal/include/rte_trace_point.h          | 12 ++++++----
 lib/eal/include/rte_trace_point_register.h |  7 ++++--
 lib/ethdev/ethdev_trace.h                  | 27 ++++++----------------
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index 3e4228ee7f..6bc8bb9036 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -377,6 +377,7 @@ char *trace_metadata_fixup_field(const char *field)
 		".",
 		"->",
 		"*",
+		" ",
 	};
 	const char *ctf_reserved_words[] = {
 		"align",
diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index b24db3b6da..a162502002 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -378,6 +378,7 @@ do { \
 
 #define __rte_trace_point_emit(in, type) \
 do { \
+	RTE_BUILD_BUG_ON(sizeof(type) != sizeof(typeof(in))); \
 	memcpy(mem, &(in), sizeof(in)); \
 	mem = RTE_PTR_ADD(mem, sizeof(in)); \
 } while (0)
@@ -392,13 +393,14 @@ do { \
 
 #define rte_trace_point_emit_blob(in, len) \
 do { \
+	uint8_t size = len; \
 	if (unlikely(in == NULL)) \
 		return; \
-	if (len > RTE_TRACE_BLOB_LEN_MAX) \
-		len = RTE_TRACE_BLOB_LEN_MAX; \
-	__rte_trace_point_emit(len, uint8_t); \
-	memcpy(mem, in, len); \
-	memset(RTE_PTR_ADD(mem, len), 0, RTE_TRACE_BLOB_LEN_MAX - len); \
+	if (size > RTE_TRACE_BLOB_LEN_MAX) \
+		size = RTE_TRACE_BLOB_LEN_MAX; \
+	__rte_trace_point_emit(size, uint8_t); \
+	memcpy(mem, in, size); \
+	memset(RTE_PTR_ADD(mem, size), 0, RTE_TRACE_BLOB_LEN_MAX - size); \
 	mem = RTE_PTR_ADD(mem, RTE_TRACE_BLOB_LEN_MAX); \
 } while (0)
 
diff --git a/lib/eal/include/rte_trace_point_register.h b/lib/eal/include/rte_trace_point_register.h
index 748c931830..8d0959c403 100644
--- a/lib/eal/include/rte_trace_point_register.h
+++ b/lib/eal/include/rte_trace_point_register.h
@@ -37,7 +37,7 @@ RTE_INIT(trace##_init) \
 
 #define __rte_trace_point_emit(in, type) \
 do { \
-	RTE_BUILD_BUG_ON(sizeof(type) != sizeof(typeof(in))); \
+	RTE_SET_USED(in); \
 	__rte_trace_point_emit_field(sizeof(type), RTE_STR(in), \
 		RTE_STR(type)); \
 } while (0)
@@ -52,7 +52,10 @@ do { \
 #define rte_trace_point_emit_blob(in, len) \
 do { \
 	RTE_SET_USED(in); \
-	__rte_trace_point_emit(len, uint8_t); \
+	RTE_SET_USED(len); \
+	__rte_trace_point_emit_field(sizeof(uint8_t), \
+		RTE_STR(in) "_" RTE_STR(len), \
+		RTE_STR(uint8_t)); \
 	__rte_trace_point_emit_field(RTE_TRACE_BLOB_LEN_MAX, \
 		RTE_STR(in)"[" RTE_STR(RTE_TRACE_BLOB_LEN_MAX)"]", \
 		RTE_STR(uint8_t)); \
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 5951ae2d99..c65b78590a 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -860,10 +860,8 @@ RTE_TRACE_POINT(
 	rte_ethdev_trace_mac_addr_add,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_ether_addr *addr, uint32_t pool, int ret),
-	uint8_t len = RTE_ETHER_ADDR_LEN;
-
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_blob(addr->addr_bytes, len);
+	rte_trace_point_emit_blob(addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 	rte_trace_point_emit_u32(pool);
 	rte_trace_point_emit_int(ret);
 )
@@ -872,20 +870,16 @@ RTE_TRACE_POINT(
 	rte_ethdev_trace_mac_addr_remove,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_ether_addr *addr),
-	uint8_t len = RTE_ETHER_ADDR_LEN;
-
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_blob(addr->addr_bytes, len);
+	rte_trace_point_emit_blob(addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 )
 
 RTE_TRACE_POINT(
 	rte_ethdev_trace_default_mac_addr_set,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_ether_addr *addr),
-	uint8_t len = RTE_ETHER_ADDR_LEN;
-
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_blob(addr->addr_bytes, len);
+	rte_trace_point_emit_blob(addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 )
 
 RTE_TRACE_POINT(
@@ -1102,11 +1096,9 @@ RTE_TRACE_POINT(
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_ether_addr *mc_addr_set, uint32_t nb_mc_addr,
 		int ret),
-	uint8_t len = nb_mc_addr * RTE_ETHER_ADDR_LEN;
-
 	rte_trace_point_emit_u16(port_id);
 	rte_trace_point_emit_u32(nb_mc_addr);
-	rte_trace_point_emit_blob(mc_addr_set, len);
+	rte_trace_point_emit_blob(mc_addr_set, nb_mc_addr * RTE_ETHER_ADDR_LEN);
 	rte_trace_point_emit_int(ret);
 )
 
@@ -1214,13 +1206,10 @@ RTE_TRACE_POINT(
 	rte_ethdev_trace_get_dcb_info,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_eth_dcb_info *dcb_info, int ret),
-	uint8_t num_user_priorities = RTE_ETH_DCB_NUM_USER_PRIORITIES;
-	uint8_t num_tcs = RTE_ETH_DCB_NUM_TCS;
-
 	rte_trace_point_emit_u16(port_id);
 	rte_trace_point_emit_u8(dcb_info->nb_tcs);
-	rte_trace_point_emit_blob(dcb_info->prio_tc, num_user_priorities);
-	rte_trace_point_emit_blob(dcb_info->tc_bws, num_tcs);
+	rte_trace_point_emit_blob(dcb_info->prio_tc, RTE_ETH_DCB_NUM_USER_PRIORITIES);
+	rte_trace_point_emit_blob(dcb_info->tc_bws, RTE_ETH_DCB_NUM_TCS);
 	rte_trace_point_emit_int(ret);
 )
 
@@ -2126,10 +2115,8 @@ RTE_TRACE_POINT_FP(
 	rte_eth_trace_macaddr_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
 		const struct rte_ether_addr *mac_addr),
-	uint8_t len = RTE_ETHER_ADDR_LEN;
-
 	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_blob(mac_addr->addr_bytes, len);
+	rte_trace_point_emit_blob(mac_addr->addr_bytes, RTE_ETHER_ADDR_LEN);
 )
 
 /* Called in loop in examples/ip_pipeline */
-- 
2.48.1

