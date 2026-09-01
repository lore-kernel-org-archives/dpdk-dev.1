Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39234C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9876440E2A;
	Tue,  1 Sep 2026 22:33:00 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 70B2140DD8
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:59 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso257128b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294778;
 x=1788899578; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XY4XFG0cuqTtczI72ggIbzAZml86FLsaqNyeJO4wlRg=;
 b=wqWkfx7tDwkJjqMgDL+znJfRLaj50BgTx7GhQ06XD28RQFcSGAwk2whGHtnkYxuzxR
 RRqmbAywOWx1E8hlc8Lipq2PwGwpTtFZYW34bqSSaWCUVxXxIrE7+l88M/kgXa+eoCfM
 EN7UlvsTN8aulDo5TIMVHpWz2H9XQj+jETwm4F3/KZuGQFk3hzC9tBmko8n6Yk9+qNEi
 /BTE/+svZA2rO7Y0KUErP9XjoL2bmE54sNa8xchzVY/iD0Y+3BHaWIXG0geu5Si5F5VF
 rIPM+vAeaiJsPrFURypPJCXQs+m/tDnmWhpnQ4O0DYM0nJjNbnszxSYXYg79NvHmfQTq
 RYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294778; x=1788899578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XY4XFG0cuqTtczI72ggIbzAZml86FLsaqNyeJO4wlRg=;
 b=klw+FPeDB7Xz0YciQIp04Hjz2GHwzXPzv3bRpmTsMUu5Fr+HG82z9pSQLbKkZi2yAG
 J+BzCEBtGRpVFlJ/ReK73lGV5827iUjq/aPqCDxFoG4yzIv2x+EONMz5Ab30Vrd0/ij7
 bTRaXpSk/w5DolE1EXvZp/Fk0eGS1uUTpdlVbNs8SSAVTveLeUYqva/G2AlAo9MUWyD+
 x8pgWj09jZqQ71wn5uySxseQNiWk2EE1LwC12DMw0duWokGiKuEyYWS4PwKsfIxmJKI3
 jxaF5xfmncao1qU4rL7Jbz9FYhM797D/Xv+7YKq6rEvoJvlD/ALpgl6H3ijtoNV2IbOx
 BISw==
X-Gm-Message-State: AFuF++npgOTvJ7xQqsnyYYIBtNXe0XVfj7+mr9cOh9JtrRVqEm/BGrzW
 gUKOny/410TnM7P1fbUFrSKusTUdFbJRgkUhSJsvxOnP5A+SvchbVogMovHbvsqmKTHCt+z+773
 uqDY9
X-Gm-Gg: AR+sD12IYYH2+i2GP9cX9PlqBdzN5E/qa0nOGZJk2tjcuEeozT268DWrjIWIKqZHFkl
 kWrXHy47lthrdLA8Wt5V0zFbtSnYuxOCpxe5sBwD2ygwhQEQwsqt+U8wLaCXXk5irv2OwSvuE/K
 R9HsmUMhx8byQYGlqowPW/9VPNvfuQQjTFx03EQhYM3ij2/jh6hr319GijulKNdGXWtFbgRxTK/
 FYEX5UlpBFC2chACO2cqIIXWzk6UFpbBjxi5x2L13oqvyHNlywHJJY6c3iy4wJh8cZdPb3BiQEh
 icNFQQ+hQwbnOQTlSszSiPVdGC8uwH48/06geuozM5wxzmSSHKyLlTjji0HEUzkGEtru9BriJIA
 b7CykTGxcEx1yNgIWm7YukE8bVFkuNJq+10z+7pKtHLoXqpGLxWf+u9V6qZATYTWbQydW4nYE4Q
 wYnKT6yzoYpfsSJtu8avTndmm/LEZzE/wcp5FpDYaVD40562V9wmfB+ON0dii/AlhHHj89C/L2n
 GWBfv8XdmGf3XMpT+QNhGA3cPZ1Mu8opnbhLg==
X-Received: by 2002:a05:6a00:3494:b0:847:7ffd:ce35 with SMTP id
 d2e1a72fcca58-85ed23de939mr779277b3a.8.1788294778637; 
 Tue, 01 Sep 2026 13:32:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 08/22] ethdev: promote flow tunnel offload API to stable
Date: Tue,  1 Sep 2026 13:23:07 -0700
Message-ID: <20260901203217.1485915-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

The tunnel offload model was added in v20.11 to let PMDs split
tunnel handling between the match and the decap stages and to let
applications recover the missed packet state.

The only change since was in v23.06, when flow restore was made
discoverable through an mbuf dynamic flag; the function prototypes
were not touched. The API is implemented by several PMDs
(mlx5, sfc, bnxt, cnxk, nfp), so promote it as one unit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/ethdev/rte_flow.c                  | 10 +++++-----
 lib/ethdev/rte_flow.h                  |  5 -----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9b5e3cf902..fe76ffa7ad 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -110,6 +110,10 @@ API Changes
   * flow dump: ``rte_flow_dev_dump``
   * FEC: ``rte_eth_fec_get_capability``, ``rte_eth_fec_get`` and ``rte_eth_fec_set``
   * link speed: ``rte_eth_link_speed_to_str`` and ``rte_eth_link_to_str``
+  * flow tunnel: ``rte_flow_tunnel_decap_set``, ``rte_flow_tunnel_match``,
+    ``rte_flow_tunnel_item_release``,
+    ``rte_flow_tunnel_action_decap_release`` and
+    ``rte_flow_get_restore_info``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 827305385f..6223096278 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1424,7 +1424,7 @@ rte_flow_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_decap_set, 20.11)
+RTE_EXPORT_SYMBOL(rte_flow_tunnel_decap_set)
 int
 rte_flow_tunnel_decap_set(uint16_t port_id,
 			  struct rte_flow_tunnel *tunnel,
@@ -1454,7 +1454,7 @@ rte_flow_tunnel_decap_set(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_match, 20.11)
+RTE_EXPORT_SYMBOL(rte_flow_tunnel_match)
 int
 rte_flow_tunnel_match(uint16_t port_id,
 		      struct rte_flow_tunnel *tunnel,
@@ -1484,7 +1484,7 @@ rte_flow_tunnel_match(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_restore_info, 20.11)
+RTE_EXPORT_SYMBOL(rte_flow_get_restore_info)
 int
 rte_flow_get_restore_info(uint16_t port_id,
 			  struct rte_mbuf *m,
@@ -1540,7 +1540,7 @@ rte_flow_restore_info_dynflag_register(void)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_action_decap_release, 20.11)
+RTE_EXPORT_SYMBOL(rte_flow_tunnel_action_decap_release)
 int
 rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				     struct rte_flow_action *actions,
@@ -1570,7 +1570,7 @@ rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_item_release, 20.11)
+RTE_EXPORT_SYMBOL(rte_flow_tunnel_item_release)
 int
 rte_flow_tunnel_item_release(uint16_t port_id,
 			     struct rte_flow_item *items,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 15ad58f699..2fe9d6ca12 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -5270,7 +5270,6 @@ struct rte_flow_restore_info {
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_tunnel_decap_set(uint16_t port_id,
 			  struct rte_flow_tunnel *tunnel,
@@ -5301,7 +5300,6 @@ rte_flow_tunnel_decap_set(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_tunnel_match(uint16_t port_id,
 		      struct rte_flow_tunnel *tunnel,
@@ -5345,7 +5343,6 @@ rte_flow_restore_info_dynflag(void);
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_get_restore_info(uint16_t port_id,
 			  struct rte_mbuf *m,
@@ -5368,7 +5365,6 @@ rte_flow_get_restore_info(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				     struct rte_flow_action *actions,
@@ -5391,7 +5387,6 @@ rte_flow_tunnel_action_decap_release(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_tunnel_item_release(uint16_t port_id,
 			     struct rte_flow_item *items,
-- 
2.53.0

