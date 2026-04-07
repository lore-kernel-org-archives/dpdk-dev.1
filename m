Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522CCFF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E654C406FF;
	Tue,  7 Apr 2026 17:18:58 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0341240DDB
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:57 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1830229a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575136;
 x=1776179936; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XjgGeG9lr15W23vx5jA6qvPUR3c1sPOs8fd/W4PXDw=;
 b=UqmElkfo8nTVQxr/ml7xwpnYImW9Q+j3XVQeFZjHs1FmDYpacSXZzNFF53ArI0H3a+
 9i4dx1XgleVK+qSZPtEuPEhIv2Zv9scJtmHPVorPy+160W66f30Zu/i1t3ngkgsJno3B
 3tzZsBMJHxDh7G3J86iB7ckhfy+h/86yeRoG8Dgj+v+yJOe1nGaNe8m5QIh4v0t7T0cD
 Ziv/zHobI+I4QGWyAPmRN3OqJjakX/KhqlbuIH5yx7d6pOmTE1diBhv5Lq1kbUzRj2Pu
 MBNf+Uhb8qx9cSeTNCfMzK3c1tZukF4fyoscsQVTrBKBBe4MFrcUbEwtm/pvrC3Cl23q
 owAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575136; x=1776179936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3XjgGeG9lr15W23vx5jA6qvPUR3c1sPOs8fd/W4PXDw=;
 b=VJ4SL3Yc//72q5DFhURP6I6iQRiufqzHkYAASnBlnMoHd4XXDIz4ph3tMmYVIrKzv0
 RKCW4Ks/WYkpZHsrQEJ3QAdtUxegONGxokE+WgGakO/npzvdPihlv8KCvafhFHk4kdUI
 iGz588wU+fyyc4t6nCJcTIYNI3qsH8R50Up4ZyNXXpodHLlnn0W2BGveL0AAAoyKsmYb
 FO55ed15ZxKWE32DDKKbNK26qKBWWKTlbmuQO4OXhv8F/+tvjnNLJbvWZPoT0BQfkkR+
 95L6KPWuyIj9FuMJKpQiG0oAYT7Kn6mpwGUdpBweadZjCeZFAUIlEvKWPtZZwB8bfHdz
 4c9A==
X-Gm-Message-State: AOJu0YzS8uHtz0i9XOoN0rhgllZpvb7bWFulhheWr/u6V1QsSesMWNX/
 xrTQrVMVCnr8zCFuRVkbXEIQ714kHcQhQmfuG/Zg2QujOyWaxGtlcxmWEvZjYsVs1YYk3eeOIq3
 8vwri
X-Gm-Gg: AeBDietVl8IHx+oZp6XWZGtVWO9fQILI241VUQEMJkgRKJMNZ1D9QDQvUSODpYSHz04
 yWwDn7ZMjEc9uZEjkrUVm73XRFYz/PideB2/El8+fBYVwox3MHxaQwRJlwNbEHBNnJ/W+tN8Xd+
 gtoh5NzYmFy1ppSR0Z5/Z0B3xMjr7SD0YOHrLhTQU8MQJ8L9LH0jPawGZ2CM/HcuIR7Aq0T4CfK
 mAHjXpg6PLyWkqrxLIZXNBqLzG8gtvtpgmQMv6nM+VE8VABha2eSbM6B+jHkKrvFpb/ikUwW9jG
 QHySNkcT8Lob25oofx96YJsHDYF+CBiCQ8ItyK8lj1Vu0C4EkBpiWPAsyIYt1oUSUZNDohiZtUJ
 preQmeRrlIkBzvbWb+aioIe1u3yQizGX18Etk5zT7zcPaAvbU+r3CZ6zZa9r8gOdx216tnccvpX
 6XPb7tgsycNIhYswYS004rVhYsLyjTYryA
X-Received: by 2002:a05:6300:2109:b0:39c:39de:3cdd with SMTP id
 adf61e73a8af0-39f2f00cbaamr17537375637.25.1775575136018; 
 Tue, 07 Apr 2026 08:18:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 22/23] examples/l3fwd: resolve shadow variable warnings
Date: Tue,  7 Apr 2026 08:16:18 -0700
Message-ID: <20260407151732.272195-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Correct for shadow variables by renaming:
  - global ipv6 becomes ipv6_enabled (convert int to bool)
  - lcore_params used by eventdev becomes config_parsed
  - masks for sse globals get xmm_ prefix
  - replace global optarg with parameter named arg

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l3fwd/l3fwd.h        |  2 +-
 examples/l3fwd/l3fwd_em.c     | 32 +++++++++--------
 examples/l3fwd/l3fwd_em_hlm.h |  8 ++---
 examples/l3fwd/l3fwd_lpm.c    |  4 +--
 examples/l3fwd/l3fwd_route.h  | 12 +++----
 examples/l3fwd/main.c         | 68 +++++++++++++++++------------------
 examples/l3fwd/meson.build    |  1 -
 7 files changed, 65 insertions(+), 62 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 471e3b488f..349fc37c79 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -99,7 +99,7 @@ extern struct rte_ether_addr ports_eth_addr[RTE_MAX_ETHPORTS];
 extern uint32_t enabled_port_mask;
 
 /* Used only in exact match mode. */
-extern int ipv6; /**< ipv6 is false by default. */
+extern bool ipv6_enabled; /**< ipv6 is false by default. */
 extern uint32_t hash_entry_number;
 
 extern xmm_t val_eth[RTE_MAX_ETHPORTS];
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index 58c54ed77e..d8748a0edd 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -211,9 +211,9 @@ ipv6_hash_crc(const void *data, __rte_unused uint32_t data_len,
 static alignas(RTE_CACHE_LINE_SIZE) uint8_t ipv4_l3fwd_out_if[L3FWD_HASH_ENTRIES];
 static alignas(RTE_CACHE_LINE_SIZE) uint8_t ipv6_l3fwd_out_if[L3FWD_HASH_ENTRIES];
 
-static rte_xmm_t mask0;
-static rte_xmm_t mask1;
-static rte_xmm_t mask2;
+static rte_xmm_t xmm_mask0;
+static rte_xmm_t xmm_mask1;
+static rte_xmm_t xmm_mask2;
 
 #if defined(__SSE2__)
 static inline xmm_t
@@ -275,7 +275,7 @@ em_get_ipv4_dst_port(void *ipv4_hdr, uint16_t portid, void *lookup_struct)
 	 * Get 5 tuple: dst port, src port, dst IP address,
 	 * src IP address and protocol.
 	 */
-	key.xmm = em_mask_key(ipv4_hdr, mask0.x);
+	key.xmm = em_mask_key(ipv4_hdr, xmm_mask0.x);
 
 	/* Find destination port */
 	ret = rte_hash_lookup(ipv4_l3fwd_lookup_struct, (const void *)&key);
@@ -298,7 +298,7 @@ em_get_ipv6_dst_port(void *ipv6_hdr, uint16_t portid, void *lookup_struct)
 	void *data2 = ((uint8_t *)ipv6_hdr) + sizeof(xmm_t) + sizeof(xmm_t);
 
 	/* Get part of 5 tuple: src IP address lower 96 bits and protocol */
-	key.xmm[0] = em_mask_key(data0, mask1.x);
+	key.xmm[0] = em_mask_key(data0, xmm_mask1.x);
 
 	/*
 	 * Get part of 5 tuple: dst IP address lower 96 bits
@@ -314,7 +314,7 @@ em_get_ipv6_dst_port(void *ipv6_hdr, uint16_t portid, void *lookup_struct)
 	 * Get part of 5 tuple: dst port and src port
 	 * and dst IP address higher 32 bits.
 	 */
-	key.xmm[2] = em_mask_key(data2, mask2.x);
+	key.xmm[2] = em_mask_key(data2, xmm_mask2.x);
 
 	/* Find destination port */
 	ret = rte_hash_lookup(ipv6_l3fwd_lookup_struct, (const void *)&key);
@@ -375,8 +375,9 @@ populate_ipv4_flow_into_table(const struct rte_hash *h)
 	char srcbuf[INET6_ADDRSTRLEN];
 	char dstbuf[INET6_ADDRSTRLEN];
 
-	mask0 = (rte_xmm_t){.u32 = {BIT_8_TO_15, ALL_32_BITS,
-				ALL_32_BITS, ALL_32_BITS} };
+	xmm_mask0 = (rte_xmm_t) {
+		.u32 = { BIT_8_TO_15, ALL_32_BITS, ALL_32_BITS, ALL_32_BITS }
+	};
 
 	for (i = 0; i < route_num_v4; i++) {
 		struct em_rule *entry;
@@ -427,10 +428,13 @@ populate_ipv6_flow_into_table(const struct rte_hash *h)
 	char srcbuf[INET6_ADDRSTRLEN];
 	char dstbuf[INET6_ADDRSTRLEN];
 
-	mask1 = (rte_xmm_t){.u32 = {BIT_16_TO_23, ALL_32_BITS,
-				ALL_32_BITS, ALL_32_BITS} };
+	xmm_mask1 = (rte_xmm_t){
+		.u32 = { BIT_16_TO_23, ALL_32_BITS, ALL_32_BITS, ALL_32_BITS }
+	};
 
-	mask2 = (rte_xmm_t){.u32 = {ALL_32_BITS, ALL_32_BITS, 0, 0} };
+	xmm_mask2 = (rte_xmm_t){
+		.u32 = { ALL_32_BITS, ALL_32_BITS, 0, 0 }
+	};
 
 	for (i = 0; i < route_num_v6; i++) {
 		struct em_rule *entry;
@@ -507,11 +511,11 @@ em_check_ptype(int portid)
 		}
 	}
 
-	if (!ipv6 && !ptype_l3_ipv4_ext) {
+	if (!ipv6_enabled && !ptype_l3_ipv4_ext) {
 		printf("port %d cannot parse RTE_PTYPE_L3_IPV4_EXT\n", portid);
 		return 0;
 	}
-	if (ipv6 && !ptype_l3_ipv6_ext) {
+	if (ipv6_enabled && !ptype_l3_ipv6_ext) {
 		printf("port %d cannot parse RTE_PTYPE_L3_IPV6_EXT\n", portid);
 		return 0;
 	}
@@ -1010,7 +1014,7 @@ setup_hash(const int socketid)
 	 * Use data from ipv4/ipv6 l3fwd config file
 	 * directly to initialize the hash table.
 	 */
-	if (ipv6 == 0) {
+	if (!ipv6_enabled) {
 		/* populate the ipv4 hash */
 		populate_ipv4_flow_into_table(
 			ipv4_l3fwd_em_lookup_struct[socketid]);
diff --git a/examples/l3fwd/l3fwd_em_hlm.h b/examples/l3fwd/l3fwd_em_hlm.h
index c1d819997a..ccf5e34496 100644
--- a/examples/l3fwd/l3fwd_em_hlm.h
+++ b/examples/l3fwd/l3fwd_em_hlm.h
@@ -31,7 +31,7 @@ em_get_dst_port_ipv4xN(struct lcore_conf *qconf, struct rte_mbuf *m[],
 	const void *key_array[EM_HASH_LOOKUP_COUNT];
 
 	for (i = 0; i < EM_HASH_LOOKUP_COUNT; i++) {
-		get_ipv4_5tuple(m[i], mask0.x, &key[i]);
+		get_ipv4_5tuple(m[i], xmm_mask0.x, &key[i]);
 		key_array[i] = &key[i];
 	}
 
@@ -58,7 +58,7 @@ em_get_dst_port_ipv6xN(struct lcore_conf *qconf, struct rte_mbuf *m[],
 	const void *key_array[EM_HASH_LOOKUP_COUNT];
 
 	for (i = 0; i < EM_HASH_LOOKUP_COUNT; i++) {
-		get_ipv6_5tuple(m[i], mask1.x, mask2.x, &key[i]);
+		get_ipv6_5tuple(m[i], xmm_mask1.x, xmm_mask2.x, &key[i]);
 		key_array[i] = &key[i];
 	}
 
@@ -85,7 +85,7 @@ em_get_dst_port_ipv4xN_events(struct lcore_conf *qconf, struct rte_mbuf *m[],
 	const void *key_array[EM_HASH_LOOKUP_COUNT];
 
 	for (i = 0; i < EM_HASH_LOOKUP_COUNT; i++) {
-		get_ipv4_5tuple(m[i], mask0.x, &key[i]);
+		get_ipv4_5tuple(m[i], xmm_mask0.x, &key[i]);
 		key_array[i] = &key[i];
 	}
 
@@ -112,7 +112,7 @@ em_get_dst_port_ipv6xN_events(struct lcore_conf *qconf, struct rte_mbuf *m[],
 	const void *key_array[EM_HASH_LOOKUP_COUNT];
 
 	for (i = 0; i < EM_HASH_LOOKUP_COUNT; i++) {
-		get_ipv6_5tuple(m[i], mask1.x, mask2.x, &key[i]);
+		get_ipv6_5tuple(m[i], xmm_mask1.x, xmm_mask2.x, &key[i]);
 		key_array[i] = &key[i];
 	}
 
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index a71eee69ec..2d2651e750 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -681,12 +681,12 @@ lpm_check_ptype(int portid)
 			ptype_l3_ipv6 = 1;
 	}
 
-	if (!ipv6 && !ptype_l3_ipv4) {
+	if (!ipv6_enabled && !ptype_l3_ipv4) {
 		printf("port %d cannot parse RTE_PTYPE_L3_IPV4\n", portid);
 		return 0;
 	}
 
-	if (ipv6 && !ptype_l3_ipv6) {
+	if (ipv6_enabled && !ptype_l3_ipv6) {
 		printf("port %d cannot parse RTE_PTYPE_L3_IPV6\n", portid);
 		return 0;
 	}
diff --git a/examples/l3fwd/l3fwd_route.h b/examples/l3fwd/l3fwd_route.h
index b02b9cc11c..fd688504c6 100644
--- a/examples/l3fwd/l3fwd_route.h
+++ b/examples/l3fwd/l3fwd_route.h
@@ -14,14 +14,14 @@
 #define	IPV6_ADDR_U32	(IPV6_ADDR_LEN / sizeof(uint32_t))
 
 #define GET_CB_FIELD(in, fd, base, lim, dlm)	do {            \
-	unsigned long val;                                      \
-	char *end;                                              \
+	unsigned long _val;                                     \
+	char *_end;                                             \
 	errno = 0;                                              \
-	val = strtoul((in), &end, (base));                      \
-	if (errno != 0 || end[0] != (dlm) || val > (lim))       \
+	_val = strtoul((in), &_end, (base));                    \
+	if (errno != 0 || _end[0] != (dlm) || _val > (lim))     \
 		return -EINVAL;                                 \
-	(fd) = (typeof(fd))val;                                 \
-	(in) = end + 1;                                         \
+	(fd) = (typeof(fd))_val;                                \
+	(in) = _end + 1;                                        \
 } while (0)
 
 struct ipv4_l3fwd_route {
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 4c64194794..df035b508c 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -94,7 +94,7 @@ xmm_t val_eth[RTE_MAX_ETHPORTS];
 uint32_t enabled_port_mask;
 
 /* Used only in exact match mode. */
-int ipv6; /**< ipv6 is false by default. */
+bool ipv6_enabled; /**< ipv6 is false by default. */
 
 struct lcore_conf lcore_conf[RTE_MAX_LCORE];
 
@@ -254,21 +254,21 @@ const struct ipv6_l3fwd_route ipv6_l3fwd_route_array[] = {
  * API's called during initialization to setup ACL/EM/LPM rules.
  */
 void
-l3fwd_set_rule_ipv4_name(const char *optarg)
+l3fwd_set_rule_ipv4_name(const char *arg)
 {
-	parm_config.rule_ipv4_name = optarg;
+	parm_config.rule_ipv4_name = arg;
 }
 
 void
-l3fwd_set_rule_ipv6_name(const char *optarg)
+l3fwd_set_rule_ipv6_name(const char *arg)
 {
-	parm_config.rule_ipv6_name = optarg;
+	parm_config.rule_ipv6_name = arg;
 }
 
 void
-l3fwd_set_alg(const char *optarg)
+l3fwd_set_alg(const char *arg)
 {
-	parm_config.alg = parse_acl_alg(optarg);
+	parm_config.alg = parse_acl_alg(arg);
 }
 
 /*
@@ -559,17 +559,17 @@ parse_config(const char *q_arg)
 }
 
 static void
-parse_eth_dest(const char *optarg)
+parse_eth_dest(const char *arg)
 {
 	uint16_t portid;
 	char *port_end;
 	uint8_t c, *dest, peer_addr[6];
 
 	errno = 0;
-	portid = strtoul(optarg, &port_end, 10);
-	if (errno != 0 || port_end == optarg || *port_end++ != ',')
+	portid = strtoul(arg, &port_end, 10);
+	if (errno != 0 || port_end == arg || *port_end++ != ',')
 		rte_exit(EXIT_FAILURE,
-		"Invalid eth-dest: %s", optarg);
+		"Invalid eth-dest: %s", arg);
 	if (portid >= RTE_MAX_ETHPORTS)
 		rte_exit(EXIT_FAILURE,
 		"eth-dest: port %d >= RTE_MAX_ETHPORTS(%d)\n",
@@ -587,14 +587,14 @@ parse_eth_dest(const char *optarg)
 }
 
 static void
-parse_mode(const char *optarg __rte_unused)
+parse_mode(const char *arg __rte_unused)
 {
 #ifdef RTE_LIB_EVENTDEV
 	struct l3fwd_event_resources *evt_rsrc = l3fwd_get_eventdev_rsrc();
 
-	if (!strcmp(optarg, "poll"))
+	if (!strcmp(arg, "poll"))
 		evt_rsrc->enabled = false;
-	else if (!strcmp(optarg, "eventdev"))
+	else if (!strcmp(arg, "eventdev"))
 		evt_rsrc->enabled = true;
 #endif
 }
@@ -633,15 +633,15 @@ parse_queue_size(const char *queue_size_arg, uint16_t *queue_size, int rx)
 
 #ifdef RTE_LIB_EVENTDEV
 static void
-parse_eventq_sched(const char *optarg)
+parse_eventq_sched(const char *arg)
 {
 	struct l3fwd_event_resources *evt_rsrc = l3fwd_get_eventdev_rsrc();
 
-	if (!strcmp(optarg, "ordered"))
+	if (!strcmp(arg, "ordered"))
 		evt_rsrc->sched_type = RTE_SCHED_TYPE_ORDERED;
-	if (!strcmp(optarg, "atomic"))
+	if (!strcmp(arg, "atomic"))
 		evt_rsrc->sched_type = RTE_SCHED_TYPE_ATOMIC;
-	if (!strcmp(optarg, "parallel"))
+	if (!strcmp(arg, "parallel"))
 		evt_rsrc->sched_type = RTE_SCHED_TYPE_PARALLEL;
 }
 
@@ -665,15 +665,15 @@ parse_event_eth_rx_queues(const char *eth_rx_queues)
 #endif
 
 static int
-parse_lookup(const char *optarg)
+parse_lookup(const char *arg)
 {
-	if (!strcmp(optarg, "em"))
+	if (!strcmp(arg, "em"))
 		lookup_mode = L3FWD_LOOKUP_EM;
-	else if (!strcmp(optarg, "lpm"))
+	else if (!strcmp(arg, "lpm"))
 		lookup_mode = L3FWD_LOOKUP_LPM;
-	else if (!strcmp(optarg, "fib"))
+	else if (!strcmp(arg, "fib"))
 		lookup_mode = L3FWD_LOOKUP_FIB;
-	else if (!strcmp(optarg, "acl"))
+	else if (!strcmp(arg, "acl"))
 		lookup_mode = L3FWD_LOOKUP_ACL;
 	else {
 		fprintf(stderr, "Invalid lookup option! Accepted options: acl, em, lpm, fib\n");
@@ -683,13 +683,13 @@ parse_lookup(const char *optarg)
 }
 
 static void
-parse_mbcache_size(const char *optarg)
+parse_mbcache_size(const char *arg)
 {
 	unsigned long mb_cache_size;
 	char *end = NULL;
 
-	mb_cache_size = strtoul(optarg, &end, 10);
-	if ((optarg[0] == '\0') || (end == NULL) || (*end != '\0'))
+	mb_cache_size = strtoul(arg, &end, 10);
+	if ((arg[0] == '\0') || (end == NULL) || (*end != '\0'))
 		return;
 	if (mb_cache_size <= RTE_MEMPOOL_CACHE_MAX_SIZE)
 		mb_mempool_cache_size = (uint32_t)mb_cache_size;
@@ -699,7 +699,7 @@ parse_mbcache_size(const char *optarg)
 }
 
 static void
-parse_pkt_burst(const char *optarg, bool is_rx_burst, uint32_t *burst_sz)
+parse_pkt_burst(const char *arg, bool is_rx_burst, uint32_t *burst_sz)
 {
 	struct rte_eth_dev_info dev_info;
 	unsigned long pkt_burst;
@@ -708,8 +708,8 @@ parse_pkt_burst(const char *optarg, bool is_rx_burst, uint32_t *burst_sz)
 	int ret;
 
 	/* parse decimal string */
-	pkt_burst = strtoul(optarg, &end, 10);
-	if ((optarg[0] == '\0') || (end == NULL) || (*end != '\0'))
+	pkt_burst = strtoul(arg, &end, 10);
+	if ((arg[0] == '\0') || (end == NULL) || (*end != '\0'))
 		return;
 
 	if (pkt_burst > MAX_PKT_BURST) {
@@ -871,7 +871,7 @@ parse_args(int argc, char **argv)
 	char **argvopt;
 	int option_index;
 	char *prgname = argv[0];
-	uint8_t lcore_params = 0;
+	bool config_parsed = false;
 #ifdef RTE_LIB_EVENTDEV
 	uint8_t eventq_sched = 0;
 	uint8_t eth_rx_q = 0;
@@ -924,7 +924,7 @@ parse_args(int argc, char **argv)
 				print_usage(prgname);
 				return -1;
 			}
-			lcore_params = 1;
+			config_parsed = true;
 			break;
 		case CMD_LINK_OPT_ETH_LINK_SPEED_NUM:
 			speed_num = atoi(optarg);
@@ -966,7 +966,7 @@ parse_args(int argc, char **argv)
 			break;
 
 		case CMD_LINE_OPT_IPV6_NUM:
-			ipv6 = 1;
+			ipv6_enabled = true;
 			break;
 
 		case CMD_LINE_OPT_MAX_PKT_LEN_NUM:
@@ -1056,9 +1056,9 @@ parse_args(int argc, char **argv)
 		}
 	}
 
-	RTE_SET_USED(lcore_params); /* needed if no eventdev block */
+	RTE_SET_USED(config_parsed); /* needed if no eventdev block */
 #ifdef RTE_LIB_EVENTDEV
-	if (evt_rsrc->enabled && lcore_params) {
+	if (evt_rsrc->enabled && config_parsed) {
 		fprintf(stderr, "lcore config is not valid when event mode is selected\n");
 		return -1;
 	}
diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
index a5c47c02b4..74144c7979 100644
--- a/examples/l3fwd/meson.build
+++ b/examples/l3fwd/meson.build
@@ -22,4 +22,3 @@ if dpdk_conf.has('RTE_LIB_EVENTDEV')
     deps += 'eventdev'
 endif
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

