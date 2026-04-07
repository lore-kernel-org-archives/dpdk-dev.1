Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20B8FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A035C40A4B;
	Tue,  7 Apr 2026 17:18:12 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 89B444025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:11 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c76bde70ec9so2087379a12.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575091;
 x=1776179891; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYb/meOdogEN9gjmvIk8BLgfPRAqHnDlV06f7Pc9leY=;
 b=pTuiiPKB8ykGUSNOaRbIXoyywaHfT7GJIPrq7wpyczKWx1RbKQcCSXZ6Aeyx/YEsPF
 W773VeJ3HiGIcEIOERPnD10wukupO6Y1RmWXPpGbb4Q/aRa3IyVGT1SgBOTE0uMbvZ8C
 yys6AcdEEPFx/QGl5Ie0Yv1eu2bAiWYKEheeF04R+H49kwOBT6vHjHPdG5ZM24lIr0qh
 8OAoqTJhKVdUAnorugtroFt/LCQfB+bbLgf1kPCT0T1WE0CHstfpYiYxWCYsgX5RwnMI
 QRCvkGTKOA31o51ZohuVRNzPi92dddr5uj2NiDSi+hsE4fSYaVsraDt4/i0zyoXg/1cJ
 CHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575091; x=1776179891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JYb/meOdogEN9gjmvIk8BLgfPRAqHnDlV06f7Pc9leY=;
 b=D8URb3QrEoTm30fhYYjEXm4fkz6bEXmEBIv7Y3BD8VsMK78nxDIyBCyzqxDFS05Lyr
 NVqh1cVZbZubqI9sLVLNL34Dbxqwx3a2ekrcjqIMQfFchsLsUZZTr1OK9Kp6a6TLxSmp
 Sga2dhNFEWsvqRSVnG3ORZXO4emzoAsjrGe/nZNk9D5J2IPp6cVswz20r2phwXlnhlbV
 1eKvAC/hZs2Qbk1NbwU9/6HrTfAQRbY7DmfSmrpNQO7ioYOa1dRnNv+c8Szo0Mrn/TR6
 +IFQf/KN4xQCKiPoisKyLjrerMHru+SdUr6a54LNCztbNeP7SbSAwPjLKjzoiES3SHot
 FWLg==
X-Gm-Message-State: AOJu0YwzQ6mmOeKfqPH/wo0v/e2YRfM3mcNQdae3Vm+9zmeoyqDMwEn/
 YbRBRIHzlHNNBjTYdA9qebAtq5C4GBIigo5v03xTs9JtEV+bRgnmfkN8d7OHkmB6RXiQHv9/tXD
 VKoJU
X-Gm-Gg: AeBDieuV1UqrRG0bO2CKEIEhZDBz6nvI76XkPkLZRysMrFP5zEJatFzyljfJHj6T1bM
 TKvZs1qF0EP4yCPcDcbNXVmB3vRdeEEvMzKXQvmZ/XVmYcLfLduEWwgzdc3JRtP0RSHpWnvflTX
 jPVc9mCqr37fM6JAExDDJ4i3T6vurIXHZ3n07qLlNaDcUlxGe6+/p2LDXO1UoNOXnAoFPw7N5U0
 CZ1TeMGomw9dH2mTtA8O8b5KdGirBKRshhJxquKmLJnS9eiYV9Dpu7QckJRqIJlUYbbZuj062wm
 bs3OXl39aYD6UjYVovvap1gn10Zc+N5VK2sb0FZ3vv65582VtTFahGCjYw2qujEHN7gA/FMwKPn
 rXUYo67cCZy4pAvhS3X/OhF8GMi/7Ea7jkWnDhS7crkSs8V6+n7WGL3biV2NqXZsetxPAT5niuU
 eIL4ParejvQWGDXkzuKqCKqYNX902XerpO
X-Received: by 2002:a05:6a20:7346:b0:39b:ef0f:a6e with SMTP id
 adf61e73a8af0-39f2f04772dmr18761546637.11.1775575090620; 
 Tue, 07 Apr 2026 08:18:10 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v2 09/23] examples/ipsec-secgw: resolve shadowed variable
 warnings
Date: Tue,  7 Apr 2026 08:16:05 -0700
Message-ID: <20260407151732.272195-10-stephen@networkplumber.org>
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

Rename variables where local variable shadows a global declaration.
Remove unused lcore_conf parameter from sa_init().
Replace shadowed optarg with parameter named arg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ipsec-secgw/ipsec-secgw.c  | 17 +++++++--------
 examples/ipsec-secgw/ipsec.c        |  3 +--
 examples/ipsec-secgw/ipsec.h        |  1 -
 examples/ipsec-secgw/ipsec_worker.c | 30 ++++++++++++-------------
 examples/ipsec-secgw/ipsec_worker.h |  4 ++--
 examples/ipsec-secgw/meson.build    |  1 -
 examples/ipsec-secgw/sa.c           | 34 +++++++++++++----------------
 7 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index fe489f9a56..eba7560c9b 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -1108,11 +1108,11 @@ print_app_sa_prm(const struct app_sa_prm *prm)
 }
 
 static int
-parse_transfer_mode(struct eh_conf *conf, const char *optarg)
+parse_transfer_mode(struct eh_conf *conf, const char *arg)
 {
-	if (!strcmp(CMD_LINE_ARG_POLL, optarg))
+	if (!strcmp(CMD_LINE_ARG_POLL, arg))
 		conf->mode = EH_PKT_TRANSFER_MODE_POLL;
-	else if (!strcmp(CMD_LINE_ARG_EVENT, optarg))
+	else if (!strcmp(CMD_LINE_ARG_EVENT, arg))
 		conf->mode = EH_PKT_TRANSFER_MODE_EVENT;
 	else {
 		printf("Unsupported packet transfer mode\n");
@@ -1123,18 +1123,18 @@ parse_transfer_mode(struct eh_conf *conf, const char *optarg)
 }
 
 static int
-parse_schedule_type(struct eh_conf *conf, const char *optarg)
+parse_schedule_type(struct eh_conf *conf, const char *arg)
 {
 	struct eventmode_conf *em_conf = NULL;
 
 	/* Get eventmode conf */
 	em_conf = conf->mode_params;
 
-	if (!strcmp(CMD_LINE_ARG_ORDERED, optarg))
+	if (!strcmp(CMD_LINE_ARG_ORDERED, arg))
 		em_conf->ext_params.sched_type = RTE_SCHED_TYPE_ORDERED;
-	else if (!strcmp(CMD_LINE_ARG_ATOMIC, optarg))
+	else if (!strcmp(CMD_LINE_ARG_ATOMIC, arg))
 		em_conf->ext_params.sched_type = RTE_SCHED_TYPE_ATOMIC;
-	else if (!strcmp(CMD_LINE_ARG_PARALLEL, optarg))
+	else if (!strcmp(CMD_LINE_ARG_PARALLEL, arg))
 		em_conf->ext_params.sched_type = RTE_SCHED_TYPE_PARALLEL;
 	else {
 		printf("Unsupported queue schedule type\n");
@@ -3123,8 +3123,7 @@ main(int32_t argc, char **argv)
 		if ((socket_ctx[socket_id].session_pool != NULL) &&
 			(socket_ctx[socket_id].sa_in == NULL) &&
 			(socket_ctx[socket_id].sa_out == NULL)) {
-			sa_init(&socket_ctx[socket_id], socket_id, lcore_conf,
-				eh_conf->mode_params);
+			sa_init(&socket_ctx[socket_id], socket_id, eh_conf->mode_params);
 			sp4_init(&socket_ctx[socket_id], socket_id);
 			sp6_init(&socket_ctx[socket_id], socket_id);
 			rt_init(&socket_ctx[socket_id], socket_id);
diff --git a/examples/ipsec-secgw/ipsec.c b/examples/ipsec-secgw/ipsec.c
index c65efd1c16..c3e37f76d1 100644
--- a/examples/ipsec-secgw/ipsec.c
+++ b/examples/ipsec-secgw/ipsec.c
@@ -415,7 +415,7 @@ int
 create_inline_session(struct socket_ctx *skt_ctx, struct ipsec_sa *sa,
 		struct rte_ipsec_session *ips)
 {
-	int32_t ret = 0;
+	int ret = 0;
 	void *sec_ctx;
 	struct rte_security_session_conf sess_conf = {
 		.action_type = ips->type,
@@ -489,7 +489,6 @@ create_inline_session(struct socket_ctx *skt_ctx, struct ipsec_sa *sa,
 
 	if (ips->type == RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO) {
 		struct rte_flow_error err;
-		int ret = 0;
 
 		sec_ctx = rte_eth_dev_get_sec_ctx(sa->portid);
 		if (sec_ctx == NULL) {
diff --git a/examples/ipsec-secgw/ipsec.h b/examples/ipsec-secgw/ipsec.h
index e3cc43ef3b..20757eeba1 100644
--- a/examples/ipsec-secgw/ipsec.h
+++ b/examples/ipsec-secgw/ipsec.h
@@ -439,7 +439,6 @@ sa_spi_present(struct sa_ctx *sa_ctx, uint32_t spi, int inbound);
 
 void
 sa_init(struct socket_ctx *ctx, int32_t socket_id,
-	struct lcore_conf *lcore_conf,
 	const struct eventmode_conf *em_conf);
 
 void
diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-secgw/ipsec_worker.c
index 04609964cd..612f78f2dc 100644
--- a/examples/ipsec-secgw/ipsec_worker.c
+++ b/examples/ipsec-secgw/ipsec_worker.c
@@ -94,7 +94,7 @@ ev_vector_attr_update(struct rte_event_vector *vec, struct rte_mbuf *pkt)
 }
 
 static inline void
-prepare_out_sessions_tbl(struct sa_ctx *sa_out,
+prepare_out_sessions_tbl(struct sa_ctx *out_ctx,
 			 struct port_drv_mode_data *data,
 			 uint16_t size)
 {
@@ -102,12 +102,12 @@ prepare_out_sessions_tbl(struct sa_ctx *sa_out,
 	struct ipsec_sa *sa;
 	uint32_t i;
 
-	if (!sa_out)
+	if (!out_ctx)
 		return;
 
-	for (i = 0; i < sa_out->nb_sa; i++) {
+	for (i = 0; i < out_ctx->nb_sa; i++) {
 
-		sa = &sa_out->sa[i];
+		sa = &out_ctx->sa[i];
 		if (!sa)
 			continue;
 
@@ -1597,7 +1597,7 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 	uint64_t prev_tsc, diff_tsc, cur_tsc;
 	struct ipsec_core_statistics *stats;
 	struct rt_ctx *rt4_ctx, *rt6_ctx;
-	struct sa_ctx *sa_in, *sa_out;
+	struct sa_ctx *in_ctx, *out_ctx;
 	struct traffic_type ip4, ip6;
 	struct lcore_rx_queue *rxql;
 	struct rte_mbuf **v4, **v6;
@@ -1621,11 +1621,11 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 
 	sp4_in = socket_ctx[socket_id].sp_ip4_in;
 	sp6_in = socket_ctx[socket_id].sp_ip6_in;
-	sa_in = socket_ctx[socket_id].sa_in;
+	in_ctx = socket_ctx[socket_id].sa_in;
 
 	sp4_out = socket_ctx[socket_id].sp_ip4_out;
 	sp6_out = socket_ctx[socket_id].sp_ip6_out;
-	sa_out = socket_ctx[socket_id].sa_out;
+	out_ctx = socket_ctx[socket_id].sa_out;
 
 	qconf->frag.pool_indir = socket_ctx[socket_id].mbuf_pool_indir;
 
@@ -1676,11 +1676,11 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 			free_pkts(trf.ipsec.pkts, trf.ipsec.num);
 
 			if (is_unprotected_port(portid)) {
-				inbound_sp_sa(sp4_in, sa_in, &trf.ip4,
+				inbound_sp_sa(sp4_in, in_ctx, &trf.ip4,
 					      trf.ip4.num,
 					      &stats->inbound.spd4);
 
-				inbound_sp_sa(sp6_in, sa_in, &trf.ip6,
+				inbound_sp_sa(sp6_in, in_ctx, &trf.ip6,
 					      trf.ip6.num,
 					      &stats->inbound.spd6);
 
@@ -1692,12 +1692,12 @@ ipsec_poll_mode_wrkr_inl_pr(void)
 				ip4.num = 0;
 				ip6.num = 0;
 
-				outb_inl_pro_spd_process(sp4_out, sa_out,
+				outb_inl_pro_spd_process(sp4_out, out_ctx,
 							 &trf.ip4, &ip4, &ip6,
 							 true,
 							 &stats->outbound.spd4);
 
-				outb_inl_pro_spd_process(sp6_out, sa_out,
+				outb_inl_pro_spd_process(sp6_out, out_ctx,
 							 &trf.ip6, &ip6, &ip4,
 							 false,
 							 &stats->outbound.spd6);
@@ -1733,7 +1733,7 @@ ipsec_poll_mode_wrkr_inl_pr_ss(void)
 	struct lcore_rx_queue *rxql;
 	struct ipsec_sa *sa = NULL;
 	struct lcore_conf *qconf;
-	struct sa_ctx *sa_out;
+	struct sa_ctx *out_ctx;
 	uint32_t i, nb_rx, j;
 	int32_t socket_id;
 	uint32_t lcore_id;
@@ -1746,9 +1746,9 @@ ipsec_poll_mode_wrkr_inl_pr_ss(void)
 	socket_id = rte_lcore_to_socket_id(lcore_id);
 
 	/* Get SA info */
-	sa_out = socket_ctx[socket_id].sa_out;
-	if (sa_out && single_sa_idx < sa_out->nb_sa) {
-		sa = &sa_out->sa[single_sa_idx];
+	out_ctx = socket_ctx[socket_id].sa_out;
+	if (out_ctx && single_sa_idx < out_ctx->nb_sa) {
+		sa = &out_ctx->sa[single_sa_idx];
 		ips = ipsec_get_primary_session(sa);
 		sa_out_portid = sa->portid;
 		if (sa->flags & IP6_TUNNEL)
diff --git a/examples/ipsec-secgw/ipsec_worker.h b/examples/ipsec-secgw/ipsec_worker.h
index 8f96161293..6db5951b9b 100644
--- a/examples/ipsec-secgw/ipsec_worker.h
+++ b/examples/ipsec-secgw/ipsec_worker.h
@@ -469,7 +469,7 @@ get_hop_for_offload_pkt(struct rte_mbuf *pkt, int is_ipv6)
 
 static __rte_always_inline void
 route4_pkts(struct rt_ctx *rt_ctx, struct rte_mbuf *pkts[],
-	    uint32_t nb_pkts, uint64_t tx_offloads, bool ip_cksum)
+	    uint32_t nb_pkts, uint64_t ol_flags, bool ip_cksum)
 {
 	uint32_t hop[MAX_PKT_BURST * 2];
 	uint32_t dst_ip[MAX_PKT_BURST * 2];
@@ -536,7 +536,7 @@ route4_pkts(struct rt_ctx *rt_ctx, struct rte_mbuf *pkts[],
 		if (ip_cksum) {
 			struct rte_ipv4_hdr *ip;
 
-			pkt->ol_flags |= tx_offloads;
+			pkt->ol_flags |= ol_flags;
 
 			ip = (struct rte_ipv4_hdr *)(ethhdr + 1);
 			ip->hdr_checksum = 0;
diff --git a/examples/ipsec-secgw/meson.build b/examples/ipsec-secgw/meson.build
index 20fd7c6c5f..e6a0e18a73 100644
--- a/examples/ipsec-secgw/meson.build
+++ b/examples/ipsec-secgw/meson.build
@@ -25,7 +25,6 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
 
 app_cflags = ['-Wno-address-of-packed-member']
 foreach flag:app_cflags
diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index a1a996dee8..866ba04b86 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -1696,7 +1696,6 @@ sa_spi_present(struct sa_ctx *sa_ctx, uint32_t spi, int inbound)
 
 void
 sa_init(struct socket_ctx *ctx, int32_t socket_id,
-	struct lcore_conf *lcore_conf,
 	const struct eventmode_conf *em_conf)
 {
 	int32_t rc;
@@ -1828,8 +1827,8 @@ outbound_sa_lookup(struct sa_ctx *sa_ctx, uint32_t sa_idx[],
  * Select HW offloads to be used.
  */
 int
-sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
-		uint64_t *tx_offloads, uint8_t *hw_reassembly)
+sa_check_offloads(uint16_t port_id, uint64_t *rx_flags,
+		uint64_t *tx_flags, uint8_t *hw_reassembly)
 {
 	struct ipsec_sa *rule;
 	uint32_t idx_sa;
@@ -1837,8 +1836,8 @@ sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
 	struct rte_eth_dev_info dev_info;
 	int ret;
 
-	*rx_offloads = 0;
-	*tx_offloads = 0;
+	*rx_flags = 0;
+	*tx_flags = 0;
 	*hw_reassembly = 0;
 
 	ret = rte_eth_dev_info_get(port_id, &dev_info);
@@ -1855,9 +1854,9 @@ sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
 				rule_type ==
 				RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL)
 				&& rule->portid == port_id)
-			*rx_offloads |= RTE_ETH_RX_OFFLOAD_SECURITY;
+			*rx_flags |= RTE_ETH_RX_OFFLOAD_SECURITY;
 		if (IS_HW_REASSEMBLY_EN(rule->flags)) {
-			*tx_offloads |= RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+			*tx_flags |= RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 			*hw_reassembly = 1;
 		}
 	}
@@ -1875,20 +1874,17 @@ sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
 				 * non-IPSec packets, there is no need of
 				 * IPv4 Checksum offload.
 				 */
-				*tx_offloads |= RTE_ETH_TX_OFFLOAD_SECURITY;
+				*tx_flags |= RTE_ETH_TX_OFFLOAD_SECURITY;
 				if (rule->mss)
-					*tx_offloads |= (RTE_ETH_TX_OFFLOAD_TCP_TSO |
-							 RTE_ETH_TX_OFFLOAD_IPV4_CKSUM);
+					*tx_flags |= RTE_ETH_TX_OFFLOAD_TCP_TSO |
+						     RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
 				break;
 			case RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO:
-				*tx_offloads |= RTE_ETH_TX_OFFLOAD_SECURITY;
+				*tx_flags |= RTE_ETH_TX_OFFLOAD_SECURITY;
 				if (rule->mss)
-					*tx_offloads |=
-						RTE_ETH_TX_OFFLOAD_TCP_TSO;
-				if (dev_info.tx_offload_capa &
-						RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
-					*tx_offloads |=
-						RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
+					*tx_flags |= RTE_ETH_TX_OFFLOAD_TCP_TSO;
+				if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
+					*tx_flags |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
 				break;
 			default:
 				/* Enable IPv4 checksum offload even if
@@ -1896,13 +1892,13 @@ sa_check_offloads(uint16_t port_id, uint64_t *rx_offloads,
 				 */
 				if (dev_info.tx_offload_capa &
 				    RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
-					*tx_offloads |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
+					*tx_flags |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
 				break;
 			}
 		} else {
 			if (dev_info.tx_offload_capa &
 			    RTE_ETH_TX_OFFLOAD_IPV4_CKSUM)
-				*tx_offloads |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
+				*tx_flags |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
 		}
 	}
 	return 0;
-- 
2.53.0

