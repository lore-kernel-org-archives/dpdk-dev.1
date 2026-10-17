Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7BCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 19:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05D0840291;
	Sat, 17 Oct 2026 21:49:02 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 2D88240276
 for <dev@dpdk.org>; Sat, 17 Oct 2026 21:49:00 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3a0aaa0fd13so917504a91.2
 for <dev@dpdk.org>; Sat, 17 Oct 2026 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792266539;
 x=1792871339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=30T9W+jzwlt9dkkIeBTtRCTpiWw9ykqOdNjv8LQR+N8=;
 b=T62Tb4K0+JtA8PaZutbz/8fktRqhTAAcVA+oubjZQ5CqUdmjsoVXMKv4hzw9kL67Vt
 SXpJX+ntfiAKlOKdgCUIktJMQ7b3qFuzotRd9TvOcQY/VUCRpCJ2xFTy/rERgks0EjRJ
 Fz4m6zfzGXmEEQ+UfdNL9tfEyxiB2pbwthCc/xdbzXmVK9rSRRYCNcFz5Mfe3nj9jU8K
 hm+5KULo2J+s9ZGylqS+gVVlVB5V8r+2bbiPsZtB4nny05FpuYbyvHpIwiU9qEwn7Zqy
 3R3+RlCaemwdkzcsU8NLmiCiWslLc28eY87fcCJ0GdEu5pl20CZuXhfIRvmOivsP1Ld6
 4nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792266539; x=1792871339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=30T9W+jzwlt9dkkIeBTtRCTpiWw9ykqOdNjv8LQR+N8=;
 b=w7X+GnOmFfpJ+1EgQyY/SKYcTxEA/Ir5AHkqQUa7FsQetgMm1xZEKqQoUHL4lHUHlF
 S9mVqEdRz5eNINH4AxRThxedPryjR9kvidUbRG5z3nYElSfbw7Z0VIpkbT5YFHGeIfcY
 1kaZbfFVIHKqfjjwImm65/HJQClRx3cbNFM89/8s6IVOoFCtjzcylG2Uf71mSJMuIUww
 f7LdqF2xCUswE7ifHSPW+ROQFi32FFTFA70iquKdjeCcF8hbJ81X7knQGxafidytVZjl
 TMYYPxmWVT823dUe3oj+2MAyV4yKAZ/9nSOieDMQ29xUPRWg0WxOevt18ufndu3ZQNb8
 jZdw==
X-Gm-Message-State: AFq9FYJtlV8omfQ3d2vBAGYAXkEc86fozPWlTaBQllu2m1WWoLBZKqps
 9IopEXwFe8tKJV0I3lBdGd6jOnRaldJxJC2yY0PbPYMktWlu3WblcxJtkdC0Wf9psRMerMrW9T3
 hc55Vf5I=
X-Gm-Gg: AYBFou10VZsvu5dmhDKKfV9ibUKxEJF7ESLZ4Vt+xJXi86gOALGa0utqgq3ao4dLSD8
 k1/hXfEkpkgLs9LCPBq2VnhLt/1GBtcOJ/Eb8FtPQJmFBvTlGYF6HLt7MhgL6cpJgKcyheMgoWo
 OerLA0J6vdSIvgTqjEXohAYDYov0BVs3lhv0C6G0pq9MwPxYUjMSXl9PkVoe9fyaMBLWRXpz9qZ
 uK0fAh/t9XduD8FxNXrJK0VLX0W13iNxsiPwl9SynkmFkO/CPKcF+7PFJ+tbAZsg0+a4Ovc0m2a
 oZqmUmQXLReDB0cnqhRppXrSVLIUylGQFPEhdWZH1C5M2lZ8xj/tFSX5RKXSfEL8emnStnrU1XM
 saryDrEJNau1qYYfL3O9KtHj9Qh2O6JWwcz/4ZwoIN5HzYsdAUy9fAbVNimaDaCKzMOmwp6wtgE
 Hku9WsYsly7VLnrCGkIRAxDyGvMb33+VFFMq2nRtQgeiWcS8Sv598a0P3oRkOLJJaCtvxLvZTmo
 9jdd9XzjRfnpfLCPXEbgWhV0gW+Hahjc4gVAA==
X-Received: by 2002:a17:90b:4c49:b0:3ac:9c37:9418 with SMTP id
 98e67ed59e1d1-3aceeb92896mr3057399a91.19.1792266538982; 
 Sat, 17 Oct 2026 12:48:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc980a548sm4533655a91.0.2026.10.17.12.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:48:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 1/2] app/testpmd: add option to set flow control mode
Date: Sat, 17 Oct 2026 12:48:54 -0700
Message-ID: <20261017194856.2950241-1-stephen@networkplumber.org>
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

When doing benchmarking it is important to disable NIC
flow control. Testpmd can do this only from the interactive
command line, there was no option to do this from a script.

Add --flow-ctrl=none|rx|tx|full, applied each time a port
is started. Devices without flow control support are skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/parameters.c             | 18 +++++++++++++++++
 app/test-pmd/testpmd.c                | 28 +++++++++++++++++++++++++++
 app/test-pmd/testpmd.h                |  1 +
 doc/guides/testpmd_app_ug/run_app.rst |  5 +++++
 4 files changed, 52 insertions(+)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 833b14eda4..f031dd7445 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -207,6 +207,8 @@ enum {
 	TESTPMD_OPT_NO_LSC_INTERRUPT_NUM,
 #define TESTPMD_OPT_NO_RMV_INTERRUPT "no-rmv-interrupt"
 	TESTPMD_OPT_NO_RMV_INTERRUPT_NUM,
+#define TESTPMD_OPT_FLOW_CTRL "flow-ctrl"
+	TESTPMD_OPT_FLOW_CTRL_NUM,
 #define TESTPMD_OPT_PRINT_EVENT "print-event"
 	TESTPMD_OPT_PRINT_EVENT_NUM,
 #define TESTPMD_OPT_MASK_EVENT "mask-event"
@@ -357,6 +359,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_DISABLE_DEVICE_START),
 	NO_ARG(TESTPMD_OPT_NO_LSC_INTERRUPT),
 	NO_ARG(TESTPMD_OPT_NO_RMV_INTERRUPT),
+	REQUIRED_ARG(TESTPMD_OPT_FLOW_CTRL),
 	REQUIRED_ARG(TESTPMD_OPT_PRINT_EVENT),
 	REQUIRED_ARG(TESTPMD_OPT_MASK_EVENT),
 	REQUIRED_ARG(TESTPMD_OPT_TX_OFFLOADS),
@@ -515,6 +518,8 @@ usage(char* progname)
 	printf("  --disable-device-start: do not automatically start port\n");
 	printf("  --no-lsc-interrupt: disable link status change interrupt.\n");
 	printf("  --no-rmv-interrupt: disable device removal interrupt.\n");
+	printf("  --flow-ctrl=none|rx|tx|full: set Ethernet flow control"
+	       " mode when ports are started.\n");
 #ifdef RTE_LIB_BITRATESTATS
 	printf("  --bitrate-stats=N: set the logical core N to perform "
 		"bit-rate calculation.\n");
@@ -1635,6 +1640,19 @@ launch_args_parse(int argc, char** argv)
 		case TESTPMD_OPT_NO_RMV_INTERRUPT_NUM:
 			rmv_interrupt = 0;
 			break;
+		case TESTPMD_OPT_FLOW_CTRL_NUM:
+			if (!strcmp(optarg, "none"))
+				flow_ctrl_mode = RTE_ETH_FC_NONE;
+			else if (!strcmp(optarg, "rx"))
+				flow_ctrl_mode = RTE_ETH_FC_RX_PAUSE;
+			else if (!strcmp(optarg, "tx"))
+				flow_ctrl_mode = RTE_ETH_FC_TX_PAUSE;
+			else if (!strcmp(optarg, "full"))
+				flow_ctrl_mode = RTE_ETH_FC_FULL;
+			else
+				rte_exit(EXIT_FAILURE,
+					 "flow-ctrl must be none, rx, tx or full\n");
+			break;
 		case TESTPMD_OPT_FLOW_ISOLATE_ALL_NUM:
 			flow_isolate_all = 1;
 			break;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index d6211a9a8a..e1766eec72 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -446,6 +446,12 @@ uint8_t lsc_interrupt = 1; /* enabled by default */
  */
 uint8_t rmv_interrupt = 1; /* enabled by default */
 
+/*
+ * Ethernet flow control mode applied on port start.
+ * Negative means leave the device default.
+ */
+int flow_ctrl_mode = -1;
+
 uint8_t hot_plug = 0; /**< hotplug disabled by default. */
 
 /* After attach, port setup is called on event or by iterator */
@@ -2973,6 +2979,26 @@ update_bonding_port_dev_conf(portid_t bond_pid)
 #endif
 }
 
+static void
+port_flow_ctrl_apply(portid_t pi)
+{
+	struct rte_eth_fc_conf fc_conf;
+	int ret;
+
+	if (flow_ctrl_mode < 0 || !is_proc_primary())
+		return;
+
+	memset(&fc_conf, 0, sizeof(fc_conf));
+	ret = rte_eth_dev_flow_ctrl_get(pi, &fc_conf);
+	if (ret == 0) {
+		fc_conf.mode = flow_ctrl_mode;
+		ret = rte_eth_dev_flow_ctrl_set(pi, &fc_conf);
+	}
+	if (ret != 0 && ret != -ENOTSUP)
+		fprintf(stderr, "Port %u: failed to set flow control: %s\n",
+			pi, rte_strerror(-ret));
+}
+
 int
 start_port(portid_t pid)
 {
@@ -3229,6 +3255,8 @@ start_port(portid_t pid)
 			fprintf(stderr, "Port %d can not be set into started\n",
 				pi);
 
+		port_flow_ctrl_apply(pi);
+
 		if (eth_macaddr_get_print_err(pi, &port->eth_addr) == 0)
 			printf("Port %d: " RTE_ETHER_ADDR_PRT_FMT "\n", pi,
 					RTE_ETHER_ADDR_BYTES(&port->eth_addr));
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 2ca4aaf086..6d4c3e8f84 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -541,6 +541,7 @@ extern uint8_t no_device_start; /**<set by "--disable-device-start" parameter */
 extern volatile int test_done; /* stop packet forwarding when set to 1. */
 extern uint8_t lsc_interrupt; /**< disabled by "--no-lsc-interrupt" parameter */
 extern uint8_t rmv_interrupt; /**< disabled by "--no-rmv-interrupt" parameter */
+extern int flow_ctrl_mode; /**< set by "--flow-ctrl" parameter */
 extern uint32_t event_print_mask;
 /**< set by "--print-event xxxx" and "--mask-event xxxx parameters */
 extern bool setup_on_probe_event; /**< disabled by port setup-on iterator */
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index bcfbf33f92..e678058b97 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -224,6 +224,11 @@ The command line options are:
 
     Disable RSS (Receive Side Scaling).
 
+*   ``--flow-ctrl=mode``
+
+    Set the Ethernet flow control mode of all ports each time they are started.
+    The possible values are ``none``, ``rx``, ``tx`` and ``full``.
+
 *   ``--port-topology=mode``
 
     Set port topology, where mode is ``paired`` (the default), ``chained`` or ``loop``.
-- 
2.53.0

