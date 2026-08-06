Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAC0C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E78E4027E;
	Thu,  6 Aug 2026 19:48:01 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9868640262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:48:00 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cf452def93so10205145ad.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786038479;
 x=1786643279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EUHbWMpE2Mkngp5WCqbc0F71WQhJD2k51ht+z99gxn0=;
 b=ovIftbpQBNXqt0/LE3QvTp0AXgjopa4xi6HpeMt6I6KqSgLlKX77xmA9Q/WtheFlZh
 gtl52zKRJMu8IJFyNaUmAgXkCQqDsPl4moNa9yY5d6vji4iQ6xeIlcN8XZlk4yOXl7lx
 vujHnvcgS1/Njm5xDGk9jVUFSHBPATGLmtei8MSe8lD9iMvkJrXyhEAdVykd2Sd4COf6
 oOaaNJ4Sp4z68wyYk6/itFR8ap0GDSU+W2HJvnWNMNsdoxdwMmflzwqc2JO2eGO6DDlE
 kYe/1BQMFkGBbjcSw/NzERrcmoRTen/aEtU4pCVr5drXoCO7GbwvO/+jELWzzsGv0Xop
 MXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038479; x=1786643279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EUHbWMpE2Mkngp5WCqbc0F71WQhJD2k51ht+z99gxn0=;
 b=kL3CTtA91EQhgFZNJrZIcmB4fVUYWDD5R80dtQULbxuG4uTCtAFhp8J64veszwcG4x
 I17fx88nKP4dexlQy1tT8ffoNTCKHdHpf+CwT/9VD1/Se59ULfs5bzXtGyobuwfBk5Vb
 +OndQMTg8CNR1EZpwK0MPk2DW/4EnWJb7fEkVXZtqF8lJaLq8cDFwexY/uuoBHNrIMAZ
 mwcEp10MrkJcJ2FvF7V70igFbhDopSlNBEDiI7LQhpoo0DGnsSXPcUQRwzQmMsHs8oND
 0tolwVwmVFMTp2fDAzo7EzKaaFkCfd75ZYhVKahtTn72Bm986C+P8HpcK9KCHE3FxRs4
 lzvg==
X-Gm-Message-State: AOJu0Yy8id2oIXzwCT44U6gwfxFAf9ZJGeW1Nf2HM1eYI2CsHXcmc7B8
 sJ4m5I+e8OWez0UaMX5VZBY4PGG/dt8MjVI2wIGcGQVfmldYOWOJuGv6kHVM2bpbTsIYzuTcQVP
 h6bVwmd0=
X-Gm-Gg: AR+sD1306c3ilKksrv/Or8RpZa6X1U+E+zCmQacB+8hVE1NT4RCQYeTzG6YJyQMkwMG
 GipIKO68FTTcUDdFEwU6Sc4gcaxMDlBh4AWMQRw6DfjkO5K/qdh35vzjC/WNYShxBDURcJeDxGx
 MIJJJBuOHnZDuu+ccxrk/Tw/J5HasBg+y6XQiB5jCb6PKiRkQSzxMrzSmQXTigdcvAKO2b7BPV5
 Z2zzFn4IQKuux8Y3bq1qrBp16waNJ1kri9TxTtlydxEWv51gJbfHpZDALq2Yyh9dnyOjZHVFohT
 ZFxY0YTJErSSdfPY6YMMPUs0CqSRVz3v1vg8fsog6eJV3Rb82+woy+pLr8bfyx6dmj5HVWStZ1V
 VQPzXdRHx+Bul8OmMwbkH5XRfIhxKLoar9JXgbJcujO4JLC0D+T6XnQfqCzC6FX+dBE0v3Eu0cY
 Li8/IUxiplc6jVJWEZtmwnv8nWbmfRlY4aznswb7Tei9VLqnoL1jErFvEKr/xdz53BXfHdwylqM
 +B5Xj4/ofDbkw9ihBM2iR2fkG0=
X-Received: by 2002:a17:903:2f0f:b0:2cf:70d2:da7c with SMTP id
 d9443c01a7336-2d0f1c3c54dmr116013115ad.12.1786038479468; 
 Thu, 06 Aug 2026 10:47:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867d4929sm31089771eec.30.2026.08.06.10.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:47:57 -0700 (PDT)
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
Subject: [PATCH v4] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Thu,  6 Aug 2026 10:47:54 -0700
Message-ID: <20260806174755.890910-1-stephen@networkplumber.org>
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

Update all in-tree callers to pass the size of the buffer
and add checks for return value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c                           |  8 +++---
 app/pdump/main.c                             |  8 +++---
 app/test-pmd/config.c                        | 13 ++++++----
 app/test/test_event_eth_tx_adapter.c         |  4 +--
 app/test/test_pmd_ring_perf.c                |  4 +--
 app/test/test_pmd_tap.c                      |  6 ++---
 doc/guides/rel_notes/deprecation.rst         |  4 ---
 doc/guides/rel_notes/release_26_11.rst       |  3 +++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c        |  4 +--
 drivers/net/cnxk/cnxk_flow.c                 | 10 +++++---
 examples/multi_process/hotplug_mp/commands.c |  5 ++--
 examples/pipeline/cli.c                      |  4 ++-
 lib/ethdev/rte_ethdev.c                      | 27 +++++++++++++-------
 lib/ethdev/rte_ethdev.h                      | 12 ++++++---
 lib/pdump/rte_pdump.c                        |  8 +++---
 15 files changed, 71 insertions(+), 49 deletions(-)

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
index aa03eb99cc..b58304e484 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -697,8 +697,8 @@ device_infos_display(const char *identifier)
 							      &mac_addr) == 0)
 					print_ethaddr("\n\tMAC address: ",
 						      &mac_addr);
-				rte_eth_dev_get_name_by_port(port_id, name);
-				printf("\n\tDevice name: %s", name);
+				if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) == 0)
+					printf("\n\tDevice name: %s", name);
 				if (rte_eth_dev_info_get(port_id, &dev_info) == 0)
 					device_infos_display_speeds(dev_info.speed_capa);
 				printf("\n");
@@ -830,8 +830,8 @@ port_infos_display(portid_t port_id)
 	       info_border, port_id, info_border);
 	if (eth_macaddr_get_print_err(port_id, &mac_addr) == 0)
 		print_ethaddr("MAC address: ", &mac_addr);
-	rte_eth_dev_get_name_by_port(port_id, name);
-	printf("\nDevice name: %s", name);
+	if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) == 0)
+		printf("\nDevice name: %s", name);
 	printf("\nDriver name: %s", dev_info.driver_name);
 
 	if (rte_eth_dev_fw_version_get(port_id, fw_version,
@@ -1031,7 +1031,10 @@ port_summary_display(portid_t port_id)
 	if (ret != 0)
 		return;
 
-	rte_eth_dev_get_name_by_port(port_id, name);
+	ret = rte_eth_dev_get_name_by_port(port_id, name, sizeof(name));
+	if (ret != 0)
+		return;
+
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
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..880d39c31a 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -136,10 +136,6 @@ Deprecation Notices
   The legacy actions should be removed
   once ``MODIFY_FIELD`` alternative is implemented in drivers.
 
-* ethdev: Starting in 26.11, the function ``rte_eth_dev_get_name_by_port()``
-  will take a size parameter as well as the string buffer.
-  This will detect and prevent accidental overwriting of caller provided buffer.
-
 * graph: The internal scheduling mechanism of ``struct rte_graph``
   will change in DPDK 26.11.
   The circular buffer fields (``head``, ``tail``, ``cir_mask``, ``cir_start``)
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
index 900eb9f774..e84e130b3c 100644
--- a/examples/multi_process/hotplug_mp/commands.c
+++ b/examples/multi_process/hotplug_mp/commands.c
@@ -31,12 +31,13 @@ cmd_list_parsed(__rte_unused void *parsed_result,
 			    __rte_unused void *data)
 {
 	uint16_t port_id;
-	char dev_name[RTE_DEV_NAME_MAX_LEN];
 
 	cmdline_printf(cl, "list all etherdev\n");
 
 	RTE_ETH_FOREACH_DEV(port_id) {
-		rte_eth_dev_get_name_by_port(port_id, dev_name);
+		char dev_name[RTE_DEV_NAME_MAX_LEN] = "";
+
+		rte_eth_dev_get_name_by_port(port_id, dev_name, sizeof(dev_name));
 		if (strlen(dev_name) > 0)
 			cmdline_printf(cl, "%d\t%s\n", port_id, dev_name);
 		else
diff --git a/examples/pipeline/cli.c b/examples/pipeline/cli.c
index 901706fab9..644ae56fd3 100644
--- a/examples/pipeline/cli.c
+++ b/examples/pipeline/cli.c
@@ -396,7 +396,9 @@ ethdev_show(uint16_t port_id, char **out, size_t *out_size)
 	if (rte_eth_link_get(port_id, &link) != 0)
 		return;
 
-	rte_eth_dev_get_name_by_port(port_id, name);
+	if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) != 0)
+		return;
+
 	rte_eth_stats_get(port_id, &stats);
 	rte_eth_macaddr_get(port_id, &addr);
 	rte_eth_dev_get_mtu(port_id, &mtu);
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..5446af84ec 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -723,25 +723,34 @@ rte_eth_dev_count_total(void)
 
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
 int
-rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
+rte_eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
 {
-	char *tmp;
-
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
 	if (name == NULL) {
-		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u name to NULL",
-			port_id);
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u name to NULL", port_id);
+		return -EINVAL;
+	}
+
+	if (size == 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u name with zero-size buffer",
+				    port_id);
 		return -EINVAL;
 	}
 
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
+		RTE_ETHDEV_LOG_LINE(ERR, "ethdev port %u name exceeds buffer size %zu",
+				    port_id, size);
+		return -ERANGE;
+	}
 
 	rte_ethdev_trace_get_name_by_port(port_id, name);
 
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..9ccc1c0845 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5704,14 +5704,20 @@ rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id);
  * @param port_id
  *   Port identifier of the device.
  * @param name
- *   Buffer of size RTE_ETH_NAME_MAX_LEN to store the name.
+ *   Buffer to store the name.
+ * @param size
+ *   Size of the buffer pointed to by *name*.
+ *   Must be large enough to hold device name,
+ *   RTE_ETH_NAME_MAX_LEN is always sufficient.
  * @return
  *   - (0) if successful.
  *   - (-ENODEV) if *port_id* is invalid.
- *   - (-EINVAL) on failure.
+ *   - (-EINVAL) if *name* is NULL or *size* is 0.
+ *   - (-ERANGE) if the buffer is too small for the device name,
+ *               result is truncated.
  */
 int
-rte_eth_dev_get_name_by_port(uint16_t port_id, char *name);
+rte_eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size);
 
 /**
  * Check that numbers of Rx and Tx descriptors satisfy descriptors limits from
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..3d494592b3 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -726,7 +726,7 @@ pdump_validate_flags(uint32_t flags)
 }
 
 static int
-pdump_validate_port(uint16_t port, char *name)
+pdump_validate_port(uint16_t port, char *name, size_t len)
 {
 	int ret = 0;
 
@@ -736,7 +736,7 @@ pdump_validate_port(uint16_t port, char *name)
 		return -1;
 	}
 
-	ret = rte_eth_dev_get_name_by_port(port, name);
+	ret = rte_eth_dev_get_name_by_port(port, name, len);
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

