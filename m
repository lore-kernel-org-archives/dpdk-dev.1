Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DDC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1D9406B4;
	Thu,  2 Jul 2026 18:12:53 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 29C7940696
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:12:52 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so590325ad.1
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783008771;
 x=1783613571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f2dYgWmbNBS/OAdQS8RQsMLZD5sanfFfgSp2HdE1sWA=;
 b=h8THs13YZ06z7nSa03RzYiERfS2aLRz1eZ490jyH29GqoMAhjoMadnDHy7sGLwRW/U
 jnJgzb8wHVmg73yWLmEeq8lK29r1ppoUwwtMRs0qEQLbGCYufkS084U3S5LyXYvI4T0B
 vqDrCW3ySpbuntjsuF31+PZ5VLlqslz0Fq01eQMy9xXcysx0JZ/315KcxQ6o37+umZnI
 Hj9G6trYJ9WhNC3F3AWosX2BwbWlkFNeyC9DkmB1uZInJER/UuV5OJ4D+TuK92OdN4FS
 m57WLUhnNj9dBeutKfdJ4t4kszTPTvcQSpvV91nABp4oc3XDXcs+bgZY5nzYsjXp2oDR
 4gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008771; x=1783613571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f2dYgWmbNBS/OAdQS8RQsMLZD5sanfFfgSp2HdE1sWA=;
 b=C7SdW3MSNCtFbCq6VJJuWQggXOgyvSioEbvSjUG5eHHgCJGGzgYGqOA9iemOZHOb/j
 FQV1i0mwm+jnNZLmUR+sAzNw1jWpPfca4iaZBLgcxXkmqJW5y0meHzoHuKA4Pj70eix2
 6YiOsQDS9fS6omjnIgGSDrTSziRVHSPGK59wB3cOO7EyAHGFF7wrZZBpEZqvBJxWKeqG
 O0JCFEQrcBchf198k/Z9jGKAjCX4Jl19kkudvRzPWq628sYjcgNI7JiQ3rRmXuIuESRL
 FIFuGz7/B/15fFyKgZ5pzJCY5GUjo8yIrcne2udJxBPHukSD0vZobR9p4VYwYhvU8tUO
 fZUQ==
X-Gm-Message-State: AOJu0Yzn211PL9I4/POqBKpAZJrtz20Ynd+QeOvtuZn6SivMqJBf/CRA
 CoqAn/424Kd63cAKvBa+0rIL//a66dAF3b9lb2WQ8YPgQ4y9pE0URMF/1ySrghwA1IIgrl3S2tb
 W8v3T
X-Gm-Gg: AfdE7ckNPRrJVCo/NgKCdNJ1NGMiwZhLnvnn9mu12NNba+QM51WzqFPdxdHFeNnk7XM
 lVQv2OyIUW0rP40BqyvmspvxApZhLv6kdIrYNrFtoBfOHt3FxSOlCnGedvQYUFGmG+ISrocRZP7
 Pm6+dOV/PEUohIMW4P3v8eBPQMwIzTEqWrPNTV6DxdCMi+V+VZ36+a5zKb9ZJOUhUZSC5w5xyY+
 XX8lIxfathGUWgl78TDzUL4oZ1Z02yvBQ+lQWwY1qsTQI6UEulgigu7NjyTbYNsXuralWNuCcnQ
 OD1dmk3ZJRsW1BLNxFIwuHiJlT9Nt47x++TSC0C6HzeDdwaWibaTNQjbwLdDBTo0eqrDXBqODny
 67LpHoPLpWDXQjvVxG7tzj3qfDGA5y/LRSx5NS/ePsPpIi7A3g94doUxIcECxvM7FGl051mQ0Yg
 VPtkeoTGBXwhyXY21WLPrsdXILRo9ubmwFzTKQ6w7J1VQaEuRyVO0=
X-Received: by 2002:a17:902:e806:b0:2c2:cf20:213 with SMTP id
 d9443c01a7336-2ca911d8b80mr62672755ad.29.1783008771175; 
 Thu, 02 Jul 2026 09:12:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm9849304c88.4.2026.07.02.09.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:12:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 3/4] app/testpmd: display any socket ID as text
Date: Thu,  2 Jul 2026 09:10:13 -0700
Message-ID: <20260702161244.363233-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702161244.363233-1-stephen@networkplumber.org>
References: <20260702130729.26577-1-mkashani@nvidia.com>
 <20260702161244.363233-1-stephen@networkplumber.org>
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

When NUMA support is disabled the port socket id is SOCKET_ID_ANY,
which was displayed as 4294967295 in "show port info", the
"Configuring Port" message, the mbuf pool creation log and the
pool lookup error message. Print "any" instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c |  6 ++++--
 app/test-pmd/config.c  | 18 ++++++++++++------
 app/test-pmd/testpmd.c | 28 ++++++++++++++++++----------
 app/test-pmd/testpmd.h | 11 +++++++++++
 4 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3c39e27aa8..bb62778a26 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3078,9 +3078,11 @@ cmd_setup_rxtx_queue_parsed(
 
 		mp = mbuf_pool_find_first(socket_id);
 		if (mp == NULL) {
+			char buf[16];
+
 			fprintf(stderr,
-				"Failed to setup RX queue: No mempool allocation on the socket %d\n",
-				rxring_numa[res->portid]);
+				"Failed to setup RX queue: No mempool allocation on the socket %s\n",
+				socket_id_str(socket_id, buf, sizeof(buf)));
 			return;
 		}
 		ret = rx_queue_setup(res->portid,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d457ca88e..166caa10b0 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -808,6 +808,7 @@ port_infos_display(portid_t port_id)
 	static const char *info_border = "*********************";
 	uint16_t mtu;
 	char name[RTE_ETH_NAME_MAX_LEN];
+	char buf[16];
 	int ret;
 	char fw_version[ETHDEV_FWVERS_LEN];
 	uint32_t lanes;
@@ -841,7 +842,8 @@ port_infos_display(portid_t port_id)
 
 	if (rte_dev_devargs(dev_info.device) && rte_dev_devargs(dev_info.device)->args)
 		printf("\nDevargs: %s", rte_dev_devargs(dev_info.device)->args);
-	printf("\nConnect to socket: %u", port->socket_id);
+	printf("\nConnect to socket: %s",
+	       socket_id_str(port->socket_id, buf, sizeof(buf)));
 
 	if (port_numa[port_id] != NUMA_NO_CONFIG) {
 		mp = mbuf_pool_find(port_numa[port_id], 0);
@@ -849,7 +851,8 @@ port_infos_display(portid_t port_id)
 			printf("\nmemory allocation on the socket: %d",
 							port_numa[port_id]);
 	} else
-		printf("\nmemory allocation on the socket: %u",port->socket_id);
+		printf("\nmemory allocation on the socket: %s",
+		       socket_id_str(port->socket_id, buf, sizeof(buf)));
 
 	printf("\nLink status: %s\n", (link.link_status) ? ("up") : ("down"));
 	printf("Link speed: %s\n", rte_eth_link_speed_to_str(link.link_speed));
@@ -5642,6 +5645,7 @@ pkt_fwd_config_display(struct fwd_config *cfg)
 	struct fwd_stream *fs;
 	lcoreid_t  lc_id;
 	streamid_t sm_id;
+	char buf[16];
 
 	printf("%s%s%s packet forwarding%s - ports=%d - cores=%d - streams=%d - "
 		"NUMA support %s, MP allocation mode: %s\n",
@@ -5664,12 +5668,14 @@ pkt_fwd_config_display(struct fwd_config *cfg)
 		       fwd_lcores[lc_id]->stream_nb);
 		for (sm_id = 0; sm_id < fwd_lcores[lc_id]->stream_nb; sm_id++) {
 			fs = fwd_streams[fwd_lcores[lc_id]->stream_idx + sm_id];
-			printf("\n  RX P=%d/Q=%d (socket %u) -> TX "
-			       "P=%d/Q=%d (socket %u) ",
+			printf("\n  RX P=%d/Q=%d (socket %s) -> ",
 			       fs->rx_port, fs->rx_queue,
-			       ports[fs->rx_port].socket_id,
+			       socket_id_str(ports[fs->rx_port].socket_id,
+					     buf, sizeof(buf)));
+			printf("TX P=%d/Q=%d (socket %s) ",
 			       fs->tx_port, fs->tx_queue,
-			       ports[fs->tx_port].socket_id);
+			       socket_id_str(ports[fs->tx_port].socket_id,
+					     buf, sizeof(buf)));
 			print_ethaddr("peer=",
 				      &peer_eth_addrs[fs->peer_addr]);
 		}
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 04f0e15bee..69e631d386 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1263,6 +1263,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 		 unsigned int socket_id, uint16_t size_idx)
 {
 	char pool_name[RTE_MEMPOOL_NAMESIZE];
+	char sock_str[16];
 	struct rte_mempool *rte_mp = NULL;
 #ifndef RTE_EXEC_ENV_WINDOWS
 	uint32_t mb_size;
@@ -1274,14 +1275,17 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 		rte_mp = rte_mempool_lookup(pool_name);
 		if (rte_mp == NULL)
 			rte_exit(EXIT_FAILURE,
-				"Get mbuf pool for socket %u failed: %s\n",
-				socket_id, rte_strerror(rte_errno));
+				"Get mbuf pool for socket %s failed: %s\n",
+				socket_id_str(socket_id, sock_str,
+					      sizeof(sock_str)),
+				rte_strerror(rte_errno));
 		return rte_mp;
 	}
 
 	TESTPMD_LOG(INFO,
-		"create a new mbuf pool <%s>: n=%u, size=%u, socket=%u\n",
-		pool_name, nb_mbuf, mbuf_seg_size, socket_id);
+		"create a new mbuf pool <%s>: n=%u, size=%u, socket=%s\n",
+		pool_name, nb_mbuf, mbuf_seg_size,
+		socket_id_str(socket_id, sock_str, sizeof(sock_str)));
 
 	switch (mp_alloc_type) {
 	case MP_ALLOC_NATIVE:
@@ -1366,8 +1370,9 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 #endif
 	if (rte_mp == NULL) {
 		rte_exit(EXIT_FAILURE,
-			"Creation of mbuf pool for socket %u failed: %s\n",
-			socket_id, rte_strerror(rte_errno));
+			"Creation of mbuf pool for socket %s failed: %s\n",
+			socket_id_str(socket_id, sock_str, sizeof(sock_str)),
+			rte_strerror(rte_errno));
 	} else if (verbose_level > 0) {
 		rte_mempool_dump(stdout, rte_mp);
 	}
@@ -2973,6 +2978,7 @@ int
 start_port(portid_t pid)
 {
 	int diag;
+	char buf[16];
 	portid_t pi;
 	portid_t p_pi = RTE_MAX_ETHPORTS;
 	portid_t pl[RTE_MAX_ETHPORTS];
@@ -3027,8 +3033,9 @@ start_port(portid_t pid)
 				}
 			}
 			configure_rxtx_dump_callbacks(0);
-			printf("Configuring Port %d (socket %u)\n", pi,
-					port->socket_id);
+			printf("Configuring Port %d (socket %s)\n", pi,
+					socket_id_str(port->socket_id,
+						buf, sizeof(buf)));
 			if (nb_hairpinq > 0 &&
 			    rte_eth_dev_hairpin_capability_get(pi, &cap)) {
 				fprintf(stderr,
@@ -3156,8 +3163,9 @@ start_port(portid_t pid)
 							(port->socket_id);
 					if (mp == NULL) {
 						fprintf(stderr,
-							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
-							port->socket_id);
+							"Failed to setup RX queue: No mempool allocation on the socket %s\n",
+							socket_id_str(port->socket_id,
+								buf, sizeof(buf)));
 						return -1;
 					}
 					diag = rx_queue_setup(pi, qi,
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 3d4b36d668..1732fa1c19 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -873,6 +873,17 @@ current_fwd_lcore(void)
 void
 parse_fwd_portlist(const char *port);
 
+/* Format a socket id for display, SOCKET_ID_ANY as "any". */
+static inline const char *
+socket_id_str(unsigned int socket_id, char *buf, size_t size)
+{
+	if (socket_id == (unsigned int)SOCKET_ID_ANY)
+		snprintf(buf, size, "any");
+	else
+		snprintf(buf, size, "%u", socket_id);
+	return buf;
+}
+
 /* Mbuf Pools */
 static inline void
 mbuf_poolname_build(unsigned int sock_id, char *mp_name,
-- 
2.53.0

