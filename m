Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF49FB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30BFA40B94;
	Tue,  7 Apr 2026 05:52:39 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 1385340A6C
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:34 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12732165d1eso6303481c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533953;
 x=1776138753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LWjd1DK88E93odXSJtkd7pPEVEmaoVGq/97EDBz3vk=;
 b=uAB5vs5peaZ0xiyq1V9C0QHVrq0LnDNFem1Zc0fk1RpRDTA9LJzymbYjfgk/T5S0nC
 VAKicqhZD4VgT3btsDoN96vwWQuToTwj/0g6iCy7J/DF07mjAFxRTSXbuNoE7GgVedlW
 Tf2gUEHY0SFaaZ6fYXE9JI21/FcBokTXcJsiPkEfGFNkgHbNpmtDKOhIxzWGsDHwz1az
 r/OAADYtG6rrid/IKEZSAlzJzNI4AOQIdfPUAqN/5ceGMD3AR97TZKvD73tZeb6uEzF2
 9TVWJXU3/J57APYxMLOxRvemzamhxUIyt2RVAxnDGzEDSRqJL7VGQ/tTSR6Mq7JUYtsx
 NFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533953; x=1776138753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4LWjd1DK88E93odXSJtkd7pPEVEmaoVGq/97EDBz3vk=;
 b=e8kQnmmzOCRI+htlvnwoeeBV3tOOItpT7vIrY0RV8LeeWDm8Ly/Be7FEd8IjCT58wQ
 rWe/6QZXbSHI/InfIykpNFV9Xw84BIPubGAIuuVGJ5e3JDQoIDCMIFSBupsrS3AyaIxa
 NetymIPKvTvIJ/wgcr16dja/XG8lvn6CWUNnpklxRzGbys4nBMNJHelEgdLwrTt6OpaU
 qoFonDWmbSXehTfmk2AyoXtn7YrLrUK5Yt0ZTf+6mJgP7bNczIFhN6cYvjSxuv4J5zIX
 PZDTcqkvo3WQGJFwFaEZLFHs1Y5aAKroq0mw0ajJ1V25ybyZnWVmXHWBV+3i7t3WfJDf
 5IrQ==
X-Gm-Message-State: AOJu0YxttoxViJgEEIGP0Hy/XgYnPsBJ8aCrVYac+fBVqmBpgCwEs68V
 HYs7Ts7wEyog86h943QAiNIXb8ERZSGQCw4i1/FE0G5DNJbQYM0kCAD8t57DVXuXqBKBAGki9s/
 vrbrL
X-Gm-Gg: AeBDiesNv/HNRawkCbh84nBX0EX80sOcCBIqV6lIU6Hz0AtIRnDmisLmuc6HvE+TYkx
 TEEN1JNvW9rephMzhw4meoDnk13+JolyAxPPZ2VaCFqpjlP0/kBkY8sQ9hsGgQWZuI06aWI1utr
 jvJW7GMACHWq6DS210JPHmsyn3zerZdSu447L+5gypJ9ZwOzGkZamKFxbJUQKLSKGIc5Yv0ARVg
 u6YD35qlWMhMj/auIIKXc0Mwz/k2nZVKRHUssKP9nvIP4Y+5SXroNQVT4PfUN5rZrwseyfyQ4C3
 UGCdQOLYpla6ySNaeIDW8npf1wRPtrs0PHQkZjInPuKGlPZQfMfAM9idnZpbZobwUjFKW/1RyyL
 0+MN/Y8E42OI7XG9ughkoBs6cUyGgF0UyiRoNnrJGnDcc3DcnXmoEDPLAu7OteAiUotq9c1IuF/
 YDDGiEt93xJM3hF3YxrIY/VplIZzTNJVxNafZrssViWkc=
X-Received: by 2002:a05:7023:b0c:b0:119:e56b:98a4 with SMTP id
 a92af1059eb24-12bfb700b66mr7568344c88.11.1775533952935; 
 Mon, 06 Apr 2026 20:52:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 22/23] examples/l3fwd: fix shadow variable warnings
Date: Mon,  6 Apr 2026 20:49:48 -0700
Message-ID: <20260407035209.650419-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l3fwd/l3fwd.h        |  2 +-
 examples/l3fwd/l3fwd_em.c     | 32 ++++++++++++++++++--------------
 examples/l3fwd/l3fwd_em_hlm.h |  8 ++++----
 examples/l3fwd/l3fwd_lpm.c    |  4 ++--
 examples/l3fwd/l3fwd_route.h  | 12 ++++++------
 examples/l3fwd/main.c         | 12 ++++++------
 examples/l3fwd/meson.build    |  1 -
 7 files changed, 37 insertions(+), 34 deletions(-)

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
index 4c64194794..8e65472d3d 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -94,7 +94,7 @@ xmm_t val_eth[RTE_MAX_ETHPORTS];
 uint32_t enabled_port_mask;
 
 /* Used only in exact match mode. */
-int ipv6; /**< ipv6 is false by default. */
+bool ipv6_enabled; /**< ipv6 is false by default. */
 
 struct lcore_conf lcore_conf[RTE_MAX_LCORE];
 
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

