Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84D606A31F
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kjkjNB3e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A6B40150;
	Sun, 15 Nov 2026 22:36:46 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTPS id C3F17400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:36:45 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso1476869a12.0
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794778604;
 x=1795383404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J78/Q/IewJyt2Rmhj5LUxm8BQxEzwUX90wKjv0st+6w=;
 b=kjkjNB3eSrRI8zoUGMGkGBaGRmFO7RaA+FcUJL4kiea008EtirHKGc6S5iGfqsjZ6n
 eSAJcO7mfU8f5+5etReIlAErEKhbf53+G17D6seiJMxfW/GtC17F9kHWTzNRufbqUKks
 8+/iZ97gC8vvsCV0rlWmjtbmq/DwMEDC109VCL0JtIJQ0H6/pjvLFnsL+8LNGvGAwk5w
 pt1hVuBfFRQJgtAq5ICa0dcDWyYBR2NhRWwL5Ea/uawfLmUy8ZV04FIgqD5f8gt8JPGt
 fA/xb3n02VjyM3xkW+ac7BkM7dqc43tdxxSuuIh5LjmrvdSvRpN648+YlWc9biJpvn25
 C5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794778604; x=1795383404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J78/Q/IewJyt2Rmhj5LUxm8BQxEzwUX90wKjv0st+6w=;
 b=Y7CY9lvbG6E0F3rveOmw3RcSMIHLbFHlzHW64axPA+n/xiSobkDQGYVaFV4MoBQLab
 jXJKGaNEuBBXs5dD+7Zbuj6eFJ4miNg2EETukNmzubKVLc4QbIEXWnKAh0zI1o637ONu
 keo1lc+TSnjQ5BK7+WVi4FMkfm0UUFikPcgdx/480HBpD760W/M8He356ZiQFg2imi4+
 F22L9JjGVv92Y+HDRCbsTXgZ2V0sGwoZImmkwUk/r8oTM9BDAGaQfCe6k+Y5OkeBB0mO
 ZIG8aDwaeTPyJnsvDOtU+uaGyDgwnO0fKV1U1ajrPFeYmxyqZXy0wItuiHhZn0dIIS4v
 BuKA==
X-Gm-Message-State: APuU4Z+8yyzW4z/OU8DN8FibSkHqHkznbm3SVdsfBftn2c9TYEMxI66d
 NnRGFHYzbAH13TNHpfImaxo7V8VrFNR8ClcuuVSolcYq3udSVya7CoAOdvACFajKVyMCuiIlxVf
 5IuPbSmE=
X-Gm-Gg: AYBFou3Npsczk2afXBuFDT3fMf2KKthDb+zgFE6c5pyKFkeoxL5tzQNjnT/95TVVDEb
 KcT3eUP2n2v+Pt5GRW34v+5EMF7EqdmlKiAwzACKtOPobklmssCRRsxw5f9ZlsePY0M5n+ouGya
 qW55yNTn3Ke3CXcckM0drjwlRujfkn9w+dyhjkoWW9WYaPNWYBXTWTi5no7WwzDTOY0j6UKpFbE
 vpXKHFVK/I2l8g/YZf6dBqBxnyvVRxyWST5RvA7L1zutMtQrBgieFWmpJiI4+LkohtNr61kyTC7
 t6C7nc46fhrvwlIy3Cwzs333UHQlodoCMlIHR/lC+E7obKxFYRtjvWdgRzDL4lpfNNrZhhJnjRC
 ZP7Cx+3wb6BWYssmGLTq/yJrjPR8GZkxMUN8ktggdnG3MXvvNTcriO8/Q4Uszx2GM+UHhsmRg2z
 vyW4EdB8xLLEezws002kFjTTEnJLmtNoi8LljTO35JmrS89GxtM5A8fS2xVk+87fwBz6+4BNIVQ
 gBjhedwzED3dCorqSFw+pwPkoEZd1HyMlmwcoHWCVXebjo/Nt48deETTqTmVADoyr2SPz6JMgj9
 s3SZJ6XaIchHJafyiJNdF8wZ7SkUK295gQgtOTRjpOBVqkP8RPXfQM1XqGx2zv+gpBJLHvg=
X-Received: by 2002:a17:90b:254e:b0:3b0:cc3e:68b5 with SMTP id
 98e67ed59e1d1-3b1b09f5d74mr8392015a91.21.1794778603669; 
 Sun, 15 Nov 2026 13:36:43 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc1889960sm3469852a12.15.2026.11.15.13.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:36:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
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
Subject: [PATCH v5] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Sun, 15 Nov 2026 13:36:21 -0800
Message-ID: <20261115213640.1037602-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409013658.965613-1-stephen@networkplumber.org>
References: <20260409013658.965613-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
v5 - rebase and update new pmd memif test

 app/dumpcap/main.c                           |  8 +++---
 app/pdump/main.c                             |  8 +++---
 app/test-pmd/config.c                        | 13 ++++++----
 app/test/test_event_eth_tx_adapter.c         |  4 +--
 app/test/test_pmd_memif.c                    |  2 +-
 app/test/test_pmd_ring_perf.c                |  4 +--
 app/test/test_pmd_tap.c                      |  6 ++---
 doc/guides/rel_notes/release_26_11.rst       |  3 +++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c        |  4 +--
 drivers/net/cnxk/cnxk_flow.c                 | 10 +++++---
 examples/multi_process/hotplug_mp/commands.c |  5 ++--
 examples/pipeline/cli.c                      |  4 ++-
 lib/ethdev/rte_ethdev.c                      | 27 +++++++++++++-------
 lib/ethdev/rte_ethdev.h                      | 12 ++++++---
 lib/pdump/rte_pdump.c                        |  8 +++---
 15 files changed, 72 insertions(+), 46 deletions(-)

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
index 6bd5292836..8986d6998f 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -699,8 +699,8 @@ device_infos_display(const char *identifier)
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
@@ -832,8 +832,8 @@ port_infos_display(portid_t port_id)
 	       info_border, port_id, info_border);
 	if (eth_macaddr_get_print_err(port_id, &mac_addr) == 0)
 		print_ethaddr("MAC address: ", &mac_addr);
-	rte_eth_dev_get_name_by_port(port_id, name);
-	printf("\nDevice name: %s", name);
+	if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) == 0)
+		printf("\nDevice name: %s", name);
 	printf("\nDriver name: %s", dev_info.driver_name);
 
 	if (rte_eth_dev_fw_version_get(port_id, fw_version,
@@ -1033,7 +1033,10 @@ port_summary_display(portid_t port_id)
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
index 0c161897ce..a0d53414dc 100644
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
diff --git a/app/test/test_pmd_memif.c b/app/test/test_pmd_memif.c
index 9bab43adb0..225640bdf2 100644
--- a/app/test/test_pmd_memif.c
+++ b/app/test/test_pmd_memif.c
@@ -81,7 +81,7 @@ find_port(const char *frag)
 	char name[RTE_ETH_NAME_MAX_LEN];
 
 	RTE_ETH_FOREACH_DEV(port_id) {
-		if (rte_eth_dev_get_name_by_port(port_id, name) == 0 &&
+		if (rte_eth_dev_get_name_by_port(port_id, name, sizeof(name)) == 0 &&
 		    strstr(name, frag) != NULL)
 			return port_id;
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
index d3ab3662dd..8387949ef3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -666,6 +666,9 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* ethdev: Added ``size`` parameter to ``rte_eth_dev_get_name_by_port()``
+  to prevent buffer overflows.
+
 * raw/ntb: Removed the ``mw_size_align`` field from ``struct ntb_dev_info``.
   Applications must now query the required memory window base-address alignment
   with the new ``rte_pmd_ntb_get_mem_align()`` function instead of relying on this field.
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
index 1562b7389e..d52c61fc3e 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -117,7 +117,7 @@ npc_parse_port_id_action(struct rte_eth_dev *eth_dev, const struct rte_flow_acti
 
 	port_act = (const struct rte_flow_action_port_id *)action->conf;
 
-	rc = rte_eth_dev_get_name_by_port(port_act->id, if_name);
+	rc = rte_eth_dev_get_name_by_port(port_act->id, if_name, sizeof(if_name));
 	if (rc) {
 		plt_err("Name not found for output port id");
 		goto err_exit;
@@ -519,7 +519,8 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
 			in_actions[i].conf = actions->conf;
 			act_ethdev = (const struct rte_flow_action_ethdev *)actions->conf;
-			if (rte_eth_dev_get_name_by_port(act_ethdev->port_id, if_name)) {
+			if (rte_eth_dev_get_name_by_port(act_ethdev->port_id, if_name,
+							 sizeof(if_name))) {
 				plt_err("Name not found for output port id");
 				goto err_exit;
 			}
@@ -559,7 +560,7 @@ cnxk_map_actions(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
 				    actions->type != RTE_FLOW_ACTION_TYPE_PORT_ID ?
 					    act_ethdev->port_id :
 					    port_act->id,
-				    if_name)) {
+				    if_name, sizeof(if_name))) {
 				plt_err("Name not found for output port id");
 				goto err_exit;
 			}
@@ -715,7 +716,8 @@ cnxk_map_pattern(struct rte_eth_dev *eth_dev, const struct rte_flow_item pattern
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
index a72169d80d..f280ecf7c3 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -715,25 +715,34 @@ rte_eth_dev_count_total(void)
 
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
index 2c0ef6a4e5..599299a781 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5553,14 +5553,20 @@ rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id);
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

