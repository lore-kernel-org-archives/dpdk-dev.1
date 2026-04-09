Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD3B10FC456
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 01:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A325A402D1;
	Thu,  9 Apr 2026 03:37:04 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 31C0A402B3
 for <dev@dpdk.org>; Thu,  9 Apr 2026 03:37:03 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2d3eb307324so99825eec.0
 for <dev@dpdk.org>; Wed, 08 Apr 2026 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775698622;
 x=1776303422; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Xtlzxjf7ySHVtO2OluC2N7PUzpIGKC4DFi3zHo+RPM=;
 b=UDpFEyhxZ3N6Vck+odHm1tDrCj4R+NQTFLNj7xvWJokGPI+PpDFPAnZqUGODKQIUFp
 CQ2VHyhOKgYp+GlJahT7AqOt08Zow2P0gpi92XQKMVKftNfPrN3kehagr3CUx010yWoY
 3OSUkgQlXL8t2OlYLFSap9tkkhK5JxSHOVd48D2k6w7iz6NCBgUgHXedf8920yI+brNx
 Ij7qyRj18Gh1IvC6xRtD3ZtjPggJkdUls9IYn3Jahq586xFK/ID0M0RRuySLrW/MK5A/
 /vhyLXDqmh/tmAfrzds9KIyBOpb6aAy86Dsw8Od+S7aZsUT92GuelR/i/1XNRhRDDL82
 ALMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775698622; x=1776303422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Xtlzxjf7ySHVtO2OluC2N7PUzpIGKC4DFi3zHo+RPM=;
 b=HzP3/y3bt1eouOeRj+XeJopfof1e8L/M17edglhouWyClAcYGd1iqHI1wSBvQlGPlH
 nkrhkFSmZLoJRn6fnxUJYHijREkFVKcVmvCNfxcx+gaS7jFWs6O5Z6grSguZybgc6iyH
 dS8uUR8HKg7lQNiJDNXQtzlNaAHl+ehP5qXtkVFyh0eolmF3rdQ4yF/8lX4tubYBxUqm
 AybNGO+yi/rfku+YQyYTSReU62CwYkIe2VVhTlFhnlldTsJOzJMsXVEHFjUjvPi7RtYG
 K3VJkoclpSkqUCgSpax3Yl7D/VXDlZ2erPK43OE5ARlcOovsDlbqcgFmxoLp7SXUrEgA
 wiRQ==
X-Gm-Message-State: AOJu0YxSjqXTL0t9No2/PbrrwRkbc5jB/P+xdcIdJPvn2n3aB94F6ZGe
 U5AAUuIMvCdDx7QRj8Q5OiCVW1rBskZXwP4ievqX5Xktq6Y7suZUs3mnTmHXJ1UOgOee9F9SmDY
 +zqFq
X-Gm-Gg: AeBDiet3sTYzsZ0+z+heMoZE/qnGlgGDZq6XCP7nvQcoA1BRMRiro2iAyJd7uoeKFqF
 kXb1hh6B7CUuABboaoTG3kZ/bMKYxulI1d3iI5Wf0zPp1kK/Zz1CTWSCI86GSgT1FNmZkXOOBPv
 XAv52s4sp9gVtPewxclOInJCXeEhTj30muehRVEanHIB+6WLMS115hCNIiI7Bl5vjeOvb4y3Qds
 IwjZi0HAODiEU1CFHAabOH/fJcaO0Fs3ihzw1DHPxIC2SuwMCdAxCOaUqNtgcVTitfIShNUEzp/
 YfalVOQVPenlVAMYRhQO7BK4AVuePPtiDcQDOTySGFRnOkdRO8EsPoar+47MlJU/w65tzm3HH4V
 sOxXgYtSqesZHHjRtaHe996RAyh1ZUD9txdPbAKCK5paR1pT9KxCTqfEbm24gCvVPAt0J/7WGfE
 92x6/c9hVvyqU+zUTrQIjvuejqTTJTv2M4r2bF7Jcey9c=
X-Received: by 2002:a05:7300:cd95:b0:2c5:1104:9c3 with SMTP id
 5a478bee46e88-2d40dff9ef4mr827371eec.5.1775698622008; 
 Wed, 08 Apr 2026 18:37:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d16d115c00sm10505580eec.12.2026.04.08.18.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 18:37:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
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
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Wed,  8 Apr 2026 18:36:57 -0700
Message-ID: <20260409013658.965613-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
 lib/pdump/rte_pdump.c                        |  2 +-
 15 files changed, 75 insertions(+), 39 deletions(-)

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
index 32c885de0b..7b3743e00f 100644
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
index 060b26ff61..f0bf4a4c1b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -84,6 +84,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: Added ``size`` parameter to ``rte_eth_dev_get_name_by_port()``
+  to prevent buffer overflows. The old ABI version without the size parameter
+  is preserved using symbol versioning and will be removed in 26.11.
+
 
 ABI Changes
 -----------
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index bc347de202..bff5ea8c3f 100644
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
index 2edc7a362e..586a56bd46 100644
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
index 0d8e2d0236..cdf26b97b8 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5667,14 +5667,18 @@ rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id);
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

