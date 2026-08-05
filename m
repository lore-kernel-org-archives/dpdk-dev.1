Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDBC55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 17:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B6FC4027E;
	Wed,  5 Aug 2026 19:00:51 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 857D44021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 19:00:49 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso979245a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785949248;
 x=1786554048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RPDjMQLTWdi6HpS/w2WjK2hvMFca6Po2oI1z6UXywRQ=;
 b=Jt0U1tTZkX0X7NOS03PFeKnwOYm6c4LkRcd8Q5DN2su4iPniarBYl737ApwqwQk31a
 ebE7zl3huJOvlNtjRSARLp7UHhGO9kClB3w9qW295cxbgBkl4uzBxbRwmRfITgkJbDQn
 yG0aMJyPQp3iousLZpo0xH2T6BB4HwEgZXr+8lKuVZmlJ/tFSZ+beUy+gEg6Y4tjUsmM
 JYl1xbp7OKBzHO540fRnq76U36YZf2/plAv20k0PEnOzXuihM04B9Au6VKBTYWxyLrxT
 4iOZx+a14BZwgWL74A+QVy561HhLSnzoDMdSDwQGziYGmMgrpnEPnSifbqWc3wvQrpj1
 DHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785949248; x=1786554048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RPDjMQLTWdi6HpS/w2WjK2hvMFca6Po2oI1z6UXywRQ=;
 b=NjOvAZzwoIC77yU9V4+PSPnl0uVERqISqIWAUfHVHo14QZMAm5ePvwlUlOPL0GPOBh
 xI6LAe5SSFwwhY05Pj+NaOkwO/v1WjytUBm9hmP4Q1GKfUz0KVIBcAD1fxotrE2nhIqM
 ytLezZRl86qw/KFyjxw8h4EVQf5t4WrZe4SJBBAEX9xQbrOFm+wd17c+sz/gpo3sneq3
 tZaABbn+gfrwiknrnXJTBpzrEfabVbko0uMuELPrU35xhnA3RA1WQ4dlsFUnUHcRfaj8
 IXbnML1REwwwYB8Unpiii6/NlBuWQQzsAwnkHe9in4gj/gplFaxocuqnGMwAXjo5VyR9
 ywMA==
X-Gm-Message-State: AOJu0Yynem9Hn3riDOdTo56KPL6cO2y06Nyrd1yetAyaGEyb1HH59Cit
 sUeg0gvqheDVf4n/ve3k1HcKgfdwsX8wbv/U83Kq/6zS71MJ2LOJHzGtD+MlPa/kQw8/kNaiW4U
 LW6CH
X-Gm-Gg: AR+sD10EtYUWugeycQKSQ686/LMqRlRvS7eSLvdIXtdfMcz7fQrl43rB2XQMEpyMMQs
 /to+6PE3o9leeMfc69hktqSV5NnVCC4kHYnD0viuQuzrSD6wfh4wgUd23bfzvb/Bt8+yhhXsWBa
 /IATNONsT7Wm+lKA/ikaUXG/CRqp2yKLTMdtMx9Rzb915cUiOe598H58uO/VJmMU1RifyfhbLhX
 ZGfxuLE0nSOBj9qVSogwJpF3RYBq3G4LZbD6ahX3+LpZjQ7HflyOzbzk6XyYr9isWrh8XrdwzvD
 FLLcUVDhxlEqyD7yQY/PpMQ2EciOjL7VeRodkDqzltqyWPn3FX3wQS1kBUacQrNDAeedXT73BsA
 k79gw/sJuLFMNlQxAA4zBqJT9WcQ+E2/0NPvRz2LQxEed6rLO69QTOVi2Fh5YBjpMbgNf7C5Olw
 4zp1md1o2iVVqSzNN881Jpb6jRnE88/BXcAOnZYD16mKjJUncqNz4cPwGL6ERigLp0QvY1PBTHU
 ASuLz6UiPZ9q8xm9iXxQSg26dQ=
X-Received: by 2002:a05:6a20:6a10:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3cb85ef7a4cmr8963868637.27.1785949247735; 
 Wed, 05 Aug 2026 10:00:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586401507sm17787987eec.9.2026.08.05.10.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:00:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Wed,  5 Aug 2026 10:00:18 -0700
Message-ID: <20260805170043.199622-1-stephen@networkplumber.org>
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

Update all in-tree callers to pass sizeof(name) as the new parameter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c                           |  8 +++----
 app/pdump/main.c                             |  8 +++----
 app/test-pmd/config.c                        |  6 ++---
 app/test/test_event_eth_tx_adapter.c         |  4 ++--
 app/test/test_pmd_ring_perf.c                |  4 ++--
 app/test/test_pmd_tap.c                      |  6 ++---
 doc/guides/rel_notes/release_26_11.rst       |  3 +++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c        |  4 ++--
 drivers/net/cnxk/cnxk_flow.c                 | 10 ++++----
 examples/multi_process/hotplug_mp/commands.c |  2 +-
 examples/pipeline/cli.c                      |  2 +-
 lib/ethdev/rte_ethdev.c                      | 25 ++++++++++++++------
 lib/ethdev/rte_ethdev.h                      | 10 +++++---
 lib/pdump/rte_pdump.c                        |  2 +-
 14 files changed, 57 insertions(+), 37 deletions(-)

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
index aa03eb99cc..b470b95694 100644
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
@@ -830,7 +830,7 @@ port_infos_display(portid_t port_id)
 	       info_border, port_id, info_border);
 	if (eth_macaddr_get_print_err(port_id, &mac_addr) == 0)
 		print_ethaddr("MAC address: ", &mac_addr);
-	rte_eth_dev_get_name_by_port(port_id, name);
+	rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
 	printf("\nDevice name: %s", name);
 	printf("\nDriver name: %s", dev_info.driver_name);
 
@@ -1031,7 +1031,7 @@ port_summary_display(portid_t port_id)
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..c271174af7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: Added ``size`` parameter to ``rte_eth_dev_get_name_by_port()``
+  to prevent buffer overflows.
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
index 901706fab9..b65c6c8be6 100644
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
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..23219ae992 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -723,10 +723,8 @@ rte_eth_dev_count_total(void)
 
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
 int
-rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
+rte_eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
 {
-	char *tmp;
-
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
 	if (name == NULL) {
@@ -735,13 +733,26 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
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
 
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..f11b54f184 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5704,14 +5704,18 @@ rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id);
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
index ac94efe7ff..57c81d4322 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -736,7 +736,7 @@ pdump_validate_port(uint16_t port, char *name)
 		return -1;
 	}
 
-	ret = rte_eth_dev_get_name_by_port(port, name);
+	ret = rte_eth_dev_get_name_by_port(port, name, sizeof(name));
 	if (ret < 0) {
 		PDUMP_LOG_LINE(ERR, "port %u to name mapping failed",
 			  port);
-- 
2.53.0

