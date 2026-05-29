Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A5CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9D240264;
	Fri, 29 May 2026 02:07:55 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 0807F4021F
 for <dev@dpdk.org>; Fri, 29 May 2026 02:07:54 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso9281604eec.0
 for <dev@dpdk.org>; Thu, 28 May 2026 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780013273;
 x=1780618073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gys4wchGvooFwSBsdPIwqrzTnE4zU9jbxLHrnpE6AJc=;
 b=GTZ83aJb6sfysQDsPu6Upm060vFh7QbC6oD1lQF1de8MUq+ZssGP0OqSNKTgEld7kU
 1dzVp174ZgcpyGOo3jK6Y94zFxXyQyHsRf4LEYO4P6+8YYFFo40vziV3yIfUhCucfMfj
 TiH8L9sUJDtYJl2nTa/e1dToFdJ+KUllVPbuvOGS4PeqVrSRrg/detPFxbFQDQ2mOLX3
 0BcQVFD1NCygm0B13e2HgIElDP9EifdrN5vlWGRgNXOsylcSqqwsGF6F0AjN9hx7rVM3
 F7gDqtvcWs83InCbhnK6gWBIG1nwa26A2qe38YtWdNRAm1jt/TuXN/P57W6THQQ6ZKCt
 QkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780013273; x=1780618073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gys4wchGvooFwSBsdPIwqrzTnE4zU9jbxLHrnpE6AJc=;
 b=Iat9zJbCd3VSPNiqNRRIUO0Xn0MhNUhXclzZA9NQILaIp75/esWxLsGx7INbrr9yYr
 qBDAN5hVZ4URKSFx36iZzoHT9QV6hWeQ5m8ae1FyMndRHPNUgjthtagVbdRkMme0cqW6
 DOprSgY56w5e4Rneae5V6DhnR1BpGKbps2s7CiwTO+5OOC4o0NMk2V6KycDo/gg6+rMp
 veOCJQ7OOKtlt1UertVAdmpDtSDL5ywZZTm1c9Mysv2HVnDFytfucvQ/jB07+59G7GYe
 9WiFRiGFJzhdS9ZIzx1ykiuI/zTMf0+7Ib9euepG5P8mV1l4IlY+W7l1AstXD2hiSjBH
 l0dw==
X-Gm-Message-State: AOJu0Yy526eJzaHdkgpgGpzn54jLF2ugy2v9ya1hK7dVizMczJZNHkGv
 cLdvUuXB7jw4h3e5eOYDnHJrdBANtcSUJaC6VDLQxCJFDgfKFJU3GzSfBEGXPCJbFrJplWAfimC
 f70Ki
X-Gm-Gg: Acq92OG1EDaAsTM57zU51gQqnn3D1TVZMA+a8LEjDB2PJbxe0ZYuB/KiLBc6kLx/4go
 8aQNtojpwd90gDvPJr9sBdZ40BKs3JBOTSp7CsWMyWQvaB3bCNBr64SaTpoz94Dvr18+QfA7taO
 CU3Hu0tSM2Aq/tDA6RfoiFl4Sn3JzYvRbJvqcW5S5pDKwI5C620wOIKoM55hrgfiB0qGIk8GL2p
 aS5ILa9uF8dW0o+cn76Gl9bIppDaKD8ylu58C3fVoduZ18FM8Ihk001q+qR3T90YvpyA3Eo+CT5
 SpGOciUlEwM7hdjpFLntnWztt7Xd4Ys2Gh7zHAa4xk5Kd/spnEr9atGUg2y7cP45nKN0seFa8ov
 yhlu486vM+lPQtpKTdGh/ai6GL3Qnniy3KoOB9LClpGQ31xY4qdHIyX/ZxNty/Lcr+MLsZCQP8R
 DyqvvaNoqh5rUAkGUVCGCYyFyNqRBdlQWa+2xcyZck8MlqvGcD/bQHK+xYjyONXFao7l622ZXn
X-Received: by 2002:a05:7300:324a:b0:302:8cb5:af0b with SMTP id
 5a478bee46e88-304eb1bc29amr349193eec.13.1780013272744; 
 Thu, 28 May 2026 17:07:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53f002sm72807eec.18.2026.05.28.17.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:07:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Thu, 28 May 2026 17:07:48 -0700
Message-ID: <20260529000748.275863-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409013658.965613-1-stephen@networkplumber.org>
References: <20260409013658.965613-1-stephen@networkplumber.org>
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

rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
buffer with no bounds checking. A mistaken caller that supplies a
buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.

Add a size parameter and replace strcpy() with strlcpy(), returning
-ERANGE if the name is truncated. The copy is now performed under
the ethdev shared data lock so that the name cannot be mutated by
another process between reading and copying.

The previous ABI is preserved via symbol versioning (DPDK_26) with a
thin wrapper that delegates to the new implementation with
RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.

Update all in-tree callers to pass sizeof(name) as the new parameter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/dumpcap/main.c                           |  8 ++--
 app/pdump/main.c                             |  8 ++--
 app/test-pmd/config.c                        |  6 +--
 app/test/test_event_eth_tx_adapter.c         |  4 +-
 app/test/test_pmd_ring_perf.c                |  4 +-
 app/test/test_pmd_tap.c                      |  6 +--
 doc/guides/rel_notes/release_26_07.rst       |  4 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c        |  4 +-
 drivers/net/cnxk/cnxk_flow.c                 | 10 +++--
 examples/multi_process/hotplug_mp/commands.c |  2 +-
 examples/pipeline/cli.c                      |  2 +-
 lib/ethdev/meson.build                       |  2 +
 lib/ethdev/rte_ethdev.c                      | 42 +++++++++++++++-----
 lib/ethdev/rte_ethdev.h                      | 10 +++--
 lib/pdump/rte_pdump.c                        |  8 ++--
 15 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..47483535fc 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -244,7 +244,7 @@ static void find_interfaces(void)
 
 		/* maybe got passed port number string as name */
 		intf->port = get_uint(intf->name, "port_number", UINT16_MAX);
-		if (rte_eth_dev_get_name_by_port(intf->port, intf->name) < 0)
+		if (rte_eth_dev_get_name_by_port(intf->port, intf->name, sizeof(intf->name)) < 0)
 			rte_exit(EXIT_FAILURE, "Invalid port number %u\n",
 				 intf->port);
 	}
@@ -261,7 +261,7 @@ static void set_default_interface(void)
 	uint16_t p;
 
 	RTE_ETH_FOREACH_DEV(p) {
-		if (rte_eth_dev_get_name_by_port(p, name) < 0)
+		if (rte_eth_dev_get_name_by_port(p, name, sizeof(name)) < 0)
 			continue;
 
 		intf = add_interface(name);
@@ -278,7 +278,7 @@ static void dump_interfaces(void)
 	uint16_t p;
 
 	RTE_ETH_FOREACH_DEV(p) {
-		if (rte_eth_dev_get_name_by_port(p, name) < 0)
+		if (rte_eth_dev_get_name_by_port(p, name, sizeof(name)) < 0)
 			continue;
 		printf("%u. %s\n", p, name);
 	}
@@ -498,7 +498,7 @@ static void statistics_loop(void)
 
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
 		RTE_ETH_FOREACH_DEV(p) {
-			if (rte_eth_dev_get_name_by_port(p, name) < 0)
+			if (rte_eth_dev_get_name_by_port(p, name, sizeof(name)) < 0)
 				continue;
 
 			r = rte_eth_stats_get(p, &stats);
diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1e62c8adc1..1f6135b20e 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -539,16 +539,16 @@ cleanup_pdump_resources(void)
 
 		/* Remove the vdev(s) created */
 		if (pt->dir & RTE_PDUMP_FLAG_RX) {
-			rte_eth_dev_get_name_by_port(pt->rx_vdev_id, name);
-			rte_eal_hotplug_remove("vdev", name);
+			if (rte_eth_dev_get_name_by_port(pt->rx_vdev_id, name, sizeof(name)) == 0)
+				rte_eal_hotplug_remove("vdev", name);
 		}
 
 		if (pt->single_pdump_dev)
 			continue;
 
 		if (pt->dir & RTE_PDUMP_FLAG_TX) {
-			rte_eth_dev_get_name_by_port(pt->tx_vdev_id, name);
-			rte_eal_hotplug_remove("vdev", name);
+			if (rte_eth_dev_get_name_by_port(pt->tx_vdev_id, name, sizeof(name)) == 0)
+				rte_eal_hotplug_remove("vdev", name);
 		}
 
 	}
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c950793aaf..1cf441acf5 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -697,7 +697,7 @@ device_infos_display(const char *identifier)
 							      &mac_addr) == 0)
 					print_ethaddr("\n\tMAC address: ",
 						      &mac_addr);
-				rte_eth_dev_get_name_by_port(port_id, name);
+				rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
 				printf("\n\tDevice name: %s", name);
 				if (rte_eth_dev_info_get(port_id, &dev_info) == 0)
 					device_infos_display_speeds(dev_info.speed_capa);
@@ -823,7 +823,7 @@ port_infos_display(portid_t port_id)
 	       info_border, port_id, info_border);
 	if (eth_macaddr_get_print_err(port_id, &mac_addr) == 0)
 		print_ethaddr("MAC address: ", &mac_addr);
-	rte_eth_dev_get_name_by_port(port_id, name);
+	rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
 	printf("\nDevice name: %s", name);
 	printf("\nDriver name: %s", dev_info.driver_name);
 
@@ -1011,7 +1011,7 @@ port_summary_display(portid_t port_id)
 	if (ret != 0)
 		return;
 
-	rte_eth_dev_get_name_by_port(port_id, name);
+	rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
 	ret = eth_macaddr_get_print_err(port_id, &mac_addr);
 	if (ret != 0)
 		return;
diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index bec298a8b8..a7cbe39367 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -192,8 +192,8 @@ deinit_ports(void)
 
 	for (i = 0; i < RTE_DIM(default_params.port); i++) {
 		rte_eth_dev_stop(default_params.port[i]);
-		rte_eth_dev_get_name_by_port(default_params.port[i], name);
-		rte_vdev_uninit(name);
+		if (rte_eth_dev_get_name_by_port(default_params.port[i], name, sizeof(name)) == 0)
+			rte_vdev_uninit(name);
 		for (j = 0; j < RTE_DIM(default_params.r[i]); j++)
 			rte_ring_free(default_params.r[i][j]);
 	}
diff --git a/app/test/test_pmd_ring_perf.c b/app/test/test_pmd_ring_perf.c
index 3636df5c73..ac60f506ab 100644
--- a/app/test/test_pmd_ring_perf.c
+++ b/app/test/test_pmd_ring_perf.c
@@ -157,8 +157,8 @@ test_ring_pmd_perf(void)
 	/* release port and ring resources */
 	if (rte_eth_dev_stop(ring_ethdev_port) != 0)
 		return -1;
-	rte_eth_dev_get_name_by_port(ring_ethdev_port, name);
-	rte_vdev_uninit(name);
+	if (rte_eth_dev_get_name_by_port(ring_ethdev_port, name, sizeof(name)) == 0)
+		rte_vdev_uninit(name);
 	rte_ring_free(r);
 	return 0;
 }
diff --git a/app/test/test_pmd_tap.c b/app/test/test_pmd_tap.c
index 6d0e8b4f54..ded26bc5e3 100644
--- a/app/test/test_pmd_tap.c
+++ b/app/test/test_pmd_tap.c
@@ -594,7 +594,7 @@ test_tap_multi_queue(void)
 	uint16_t port;
 	RTE_ETH_FOREACH_DEV(port) {
 		char name[RTE_ETH_NAME_MAX_LEN];
-		if (rte_eth_dev_get_name_by_port(port, name) == 0 &&
+		if (rte_eth_dev_get_name_by_port(port, name, sizeof(name)) == 0 &&
 		    strstr(name, "net_tap_mq"))
 			goto found;
 	}
@@ -739,7 +739,7 @@ test_tap_setup(void)
 	/* Find the port IDs */
 	RTE_ETH_FOREACH_DEV(port_id) {
 		char name[RTE_ETH_NAME_MAX_LEN];
-		if (rte_eth_dev_get_name_by_port(port_id, name) != 0)
+		if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) != 0)
 			continue;
 
 		if (strstr(name, "net_tap0"))
@@ -785,7 +785,7 @@ test_tap_rx_queue_setup(void)
 	port = -1;
 	RTE_ETH_FOREACH_DEV(port_id) {
 		char name[RTE_ETH_NAME_MAX_LEN];
-		if (rte_eth_dev_get_name_by_port(port_id, name) == 0 &&
+		if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) == 0 &&
 		    strstr(name, "net_tap_neg")) {
 			port = port_id;
 			break;
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b4f8401e2..6c91487a11 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -116,6 +116,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: Added ``size`` parameter to ``rte_eth_dev_get_name_by_port()``
+  to prevent buffer overflows. The old ABI version without the size parameter
+  is preserved using symbol versioning and will be removed in 26.11.
+
 
 ABI Changes
 -----------
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 6ca9d3309b..e1ffc64c5e 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -608,7 +608,7 @@ ulp_tf_ctx_shared_session_open(struct bnxt *bp,
 
 	memset(&parms, 0, sizeof(parms));
 	rc = rte_eth_dev_get_name_by_port(ethdev->data->port_id,
-					  parms.ctrl_chan_name);
+					  parms.ctrl_chan_name, sizeof(parms.ctrl_chan_name));
 	if (rc) {
 		BNXT_DRV_DBG(ERR, "Invalid port %d, rc = %d\n",
 			     ethdev->data->port_id, rc);
@@ -786,7 +786,7 @@ ulp_tf_ctx_session_open(struct bnxt *bp,
 	memset(&params, 0, sizeof(params));
 
 	rc = rte_eth_dev_get_name_by_port(ethdev->data->port_id,
-					  params.ctrl_chan_name);
+					  params.ctrl_chan_name, sizeof(params.ctrl_chan_name));
 	if (rc) {
 		BNXT_DRV_DBG(ERR, "Invalid port %d, rc = %d\n",
 			     ethdev->data->port_id, rc);
diff --git a/drivers/net/cnxk/cnxk_flow.c b/drivers/net/cnxk/cnxk_flow.c
index c1c48eb7ab..eb51ce37e8 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -117,7 +117,7 @@ npc_parse_port_id_action(struct rte_eth_dev *eth_dev, const struct rte_flow_acti
 
 	port_act = (const struct rte_flow_action_port_id *)action->conf;
 
-	rc = rte_eth_dev_get_name_by_port(port_act->id, if_name);
+	rc = rte_eth_dev_get_name_by_port(port_act->id, if_name, sizeof(if_name));
 	if (rc) {
 		plt_err("Name not found for output port id");
 		goto err_exit;
@@ -517,7 +517,8 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
 			in_actions[i].conf = actions->conf;
 			act_ethdev = (const struct rte_flow_action_ethdev *)actions->conf;
-			if (rte_eth_dev_get_name_by_port(act_ethdev->port_id, if_name)) {
+			if (rte_eth_dev_get_name_by_port(act_ethdev->port_id, if_name,
+							 sizeof(if_name))) {
 				plt_err("Name not found for output port id");
 				goto err_exit;
 			}
@@ -557,7 +558,7 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 				    actions->type != RTE_FLOW_ACTION_TYPE_PORT_ID ?
 					    act_ethdev->port_id :
 					    port_act->id,
-				    if_name)) {
+				    if_name, sizeof(if_name))) {
 				plt_err("Name not found for output port id");
 				goto err_exit;
 			}
@@ -713,7 +714,8 @@ cnxk_map_pattern(struct rte_eth_dev *eth_dev, const struct rte_flow_item pattern
 		if (pattern->type == RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT ||
 		    pattern->type == RTE_FLOW_ITEM_TYPE_PORT_REPRESENTOR) {
 			rep_eth_dev = (const struct rte_flow_item_ethdev *)pattern->spec;
-			if (rte_eth_dev_get_name_by_port(rep_eth_dev->port_id, if_name)) {
+			if (rte_eth_dev_get_name_by_port(rep_eth_dev->port_id, if_name,
+							 sizeof(if_name))) {
 				plt_err("Name not found for output port id");
 				goto fail;
 			}
diff --git a/examples/multi_process/hotplug_mp/commands.c b/examples/multi_process/hotplug_mp/commands.c
index 900eb9f774..92a4f0378b 100644
--- a/examples/multi_process/hotplug_mp/commands.c
+++ b/examples/multi_process/hotplug_mp/commands.c
@@ -36,7 +36,7 @@ cmd_list_parsed(__rte_unused void *parsed_result,
 	cmdline_printf(cl, "list all etherdev\n");
 
 	RTE_ETH_FOREACH_DEV(port_id) {
-		rte_eth_dev_get_name_by_port(port_id, dev_name);
+		rte_eth_dev_get_name_by_port(port_id, dev_name, sizeof(dev_name));
 		if (strlen(dev_name) > 0)
 			cmdline_printf(cl, "%d\t%s\n", port_id, dev_name);
 		else
diff --git a/examples/pipeline/cli.c b/examples/pipeline/cli.c
index 215b4061d5..51c8864077 100644
--- a/examples/pipeline/cli.c
+++ b/examples/pipeline/cli.c
@@ -396,7 +396,7 @@ ethdev_show(uint16_t port_id, char **out, size_t *out_size)
 	if (rte_eth_link_get(port_id, &link) != 0)
 		return;
 
-	rte_eth_dev_get_name_by_port(port_id, name);
+	rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
 	rte_eth_stats_get(port_id, &stats);
 	rte_eth_macaddr_get(port_id, &addr);
 	rte_eth_dev_get_mtu(port_id, &mtu);
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a2..b2c4222fe6 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -62,3 +62,5 @@ endif
 if get_option('buildtype').contains('debug')
     cflags += ['-DRTE_FLOW_DEBUG']
 endif
+
+use_function_versioning = true
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d0273e3f7b..1638cab231 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -721,12 +721,9 @@ rte_eth_dev_count_total(void)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
-int
-rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
+static int
+eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
 {
-	char *tmp;
-
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
 	if (name == NULL) {
@@ -735,19 +732,46 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
 		return -EINVAL;
 	}
 
+	if (size == 0) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Cannot get ethdev port %u name with zero-size buffer", port_id);
+		return -EINVAL;
+	}
+
 	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
-	/* shouldn't check 'rte_eth_devices[i].data',
-	 * because it might be overwritten by VDEV PMD */
-	tmp = eth_dev_shared_data->data[port_id].name;
+	/*
+	 * Use the shared data name rather than rte_eth_devices[].data->name
+	 * because VDEV PMDs may overwrite the per-process data pointer.
+	 */
+	size_t n = strlcpy(name, eth_dev_shared_data->data[port_id].name, size);
 	rte_spinlock_unlock(rte_mcfg_ethdev_get_lock());
 
-	strcpy(name, tmp);
+	if (n >= size) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+				    "ethdev port %u name exceeds buffer size %zu",
+				    port_id, size);
+		return -ERANGE;
+	}
 
 	rte_ethdev_trace_get_name_by_port(port_id, name);
 
 	return 0;
 }
 
+/* new ABI version: bounded copy using caller-provided size */
+RTE_DEFAULT_SYMBOL(27, int, rte_eth_dev_get_name_by_port,
+		   (uint16_t port_id, char *name, size_t size))
+{
+	return eth_dev_get_name_by_port(port_id, name, size);
+}
+
+/* old ABI version: delegate to new version with max buffer size */
+RTE_VERSION_SYMBOL(26, int, rte_eth_dev_get_name_by_port,
+		   (uint16_t port_id, char *name))
+{
+	return eth_dev_get_name_by_port(port_id, name, RTE_ETH_NAME_MAX_LEN);
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_port_by_name)
 int
 rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 3f4d2438e4..17c000dbf2 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5691,14 +5691,18 @@ rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id);
  * @param port_id
  *   Port identifier of the device.
  * @param name
- *   Buffer of size RTE_ETH_NAME_MAX_LEN to store the name.
+ *   Buffer to store the name.
+ * @param size
+ *   Size of the buffer pointed to by @p name. Should be at least
+ *   RTE_ETH_NAME_MAX_LEN bytes.
  * @return
  *   - (0) if successful.
  *   - (-ENODEV) if *port_id* is invalid.
- *   - (-EINVAL) on failure.
+ *   - (-EINVAL) if *name* is NULL or *size* is 0.
+ *   - (-ERANGE) if the buffer is too small for the device name.
  */
 int
-rte_eth_dev_get_name_by_port(uint16_t port_id, char *name);
+rte_eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size);
 
 /**
  * Check that numbers of Rx and Tx descriptors satisfy descriptors limits from
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..ba36949b01 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -726,7 +726,7 @@ pdump_validate_flags(uint32_t flags)
 }
 
 static int
-pdump_validate_port(uint16_t port, char *name)
+pdump_validate_port(uint16_t port, char *name, size_t name_size)
 {
 	int ret = 0;
 
@@ -736,7 +736,7 @@ pdump_validate_port(uint16_t port, char *name)
 		return -1;
 	}
 
-	ret = rte_eth_dev_get_name_by_port(port, name);
+	ret = rte_eth_dev_get_name_by_port(port, name, name_size);
 	if (ret < 0) {
 		PDUMP_LOG_LINE(ERR, "port %u to name mapping failed",
 			  port);
@@ -818,7 +818,7 @@ pdump_enable(uint16_t port, uint16_t queue,
 	int ret;
 	char name[RTE_DEV_NAME_MAX_LEN];
 
-	ret = pdump_validate_port(port, name);
+	ret = pdump_validate_port(port, name, sizeof(name));
 	if (ret < 0)
 		return ret;
 	ret = pdump_validate_ring_mp(ring, mp);
@@ -912,7 +912,7 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags)
 	int ret = 0;
 	char name[RTE_DEV_NAME_MAX_LEN];
 
-	ret = pdump_validate_port(port, name);
+	ret = pdump_validate_port(port, name, sizeof(name));
 	if (ret < 0)
 		return ret;
 	ret = pdump_validate_flags(flags);
-- 
2.53.0

