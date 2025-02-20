Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E1C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AA4E402DA;
	Thu, 20 Feb 2025 21:44:40 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1065340292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:44:38 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2212a930001so37302785ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740084277;
 x=1740689077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UYusXE9dpEWZcjIOQ8x3Q2vSBjCOKwR+13Cos13irXI=;
 b=EM2oBo91dfGuHf2YMy/V+ADxtrZaOG4CXDWFRaZs8HNot4yAAMsaYGF59JC5whKCaq
 35V+ryu7sLssbjAD55RLqTPtITskLv0u/PeJFHbE54Nxgv40T38k8Od/pt93oYbe3Dgo
 dpmw8u6Bp7d2mNv7O7iRvWE3Ae7K7EjvE3MzQIZ6EuQpRkCauXp03cTg5IHWNMtJdBmx
 y0NZXe1oeGZ3vN6YwpB7l1fTrqkEzJadiH7NDUsqQQBGpmtDGCdUQSMtWrXmYmlNVhII
 jOSuyqU7GwrWFV633z60IWyL6AvWQ7tVbkraXrzI9jftLCQl8oxEnZ4ewRoWqi0G/YPH
 9IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084277; x=1740689077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYusXE9dpEWZcjIOQ8x3Q2vSBjCOKwR+13Cos13irXI=;
 b=ITi0ONTH7JULjBqTsTF5sJL00e1bL4Rk4hwLXpz4IanHV0gfHdBKLKIAMSd4ySMV64
 OOgkXbwmnyw2m83+dfVqrcqfdoNN10E849TKnThXhn0yv+c7psqoWtyK1oNK/azGg6rG
 JNYaJBIS4p6b+dMkp/FyM+l+KMXgm3oyrA6YgkNZsOfwcFfyCnJT9xGP1sk2El9KbJup
 +infNd+47ceppYNJYEwH2v1QLQv5Y6Dz78gVKZwCulSc5e2JiN6U/5rUUn9L/9+cUaND
 buclNNs8Lojz2UuksNSMH+zZkSu0MMbDO3Ezk3CKia03oufrRdN6/FY3wrVHPhCBqAEp
 ZvKw==
X-Gm-Message-State: AOJu0Yz+IV1R9eDRlc0hq3OEmAU8itiZ9IYy3yeigXhnaBn31PNYSgu3
 futWJ0Xpg3EgfmJz9K6AHBuAn7JFtu/jdLXHKwBtU1Qrmm0CRAAOSTz0cTRDQzJfQbNCOBkp2Vy
 O
X-Gm-Gg: ASbGnctFEgPIdjGicEPiP0epKzh12F9dW3+KcuQTbt1OS/oMKq/cd+AyUIFDwo6uBLT
 GA24pI948WXwcHMyQpA4KNoRafS4ErrvGeTEbseMMCMDeQhej+yljwXWH1u8qZDaGH2wiCDqMSV
 z9Mw7AwTRQ1UMHHJu30FRZXNbKhhoFsOQfh8gSOlVRfHw7nKGw05ngsj7USUSPYNuKriU1YkF5B
 M3RRIaokUnMgbHzyHqK1aVBKdtad7lGentLlU4BFMjMyEOMNsTIO+IUNmhvoKvlryGjuAqIx5qc
 0sp8Q369I7Bk9e3i4bTArdMofJkQu/q5i/2ooSBdx4dEtscQwcs2HQuUYf+uJoI+ZbRm
X-Google-Smtp-Source: AGHT+IGqUSfc78qu+rV2Ezcs1dwvQi/rY9w2UUVaHDwclm4WVYh1tX1xvkddJOL8KAgTyyAiRFP9Ww==
X-Received: by 2002:a17:902:cecc:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-221a0ed71c5mr1674735ad.13.1740084277032; 
 Thu, 20 Feb 2025 12:44:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5364385sm125182195ad.63.2025.02.20.12.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:44:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Wei Dai <wei.dai@intel.com>
Subject: [PATCH] app/testpmd: fix out-of-bound reference in offload config
Date: Thu, 20 Feb 2025 12:44:26 -0800
Message-ID: <20250220204427.213965-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

When configuring offloads, need to check the port id before
indexing into the ports[] array. This can easily be done
by moving the call to oh_dev_conf_get_print_err() to before
the checks for port stopped.

Fixes: c73a9071877a ("app/testpmd: add commands to test new offload API")
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c | 57 +++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 86d763b66a..d059b65003 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -11627,7 +11627,7 @@ cmd_rx_offload_get_configuration_parsed(
 	struct cmd_rx_offload_get_configuration_result *res = parsed_result;
 	struct rte_eth_dev_info dev_info;
 	portid_t port_id = res->port_id;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	struct rte_eth_conf dev_conf;
 	uint64_t port_offloads;
 	uint64_t queue_offloads;
@@ -11635,12 +11635,13 @@ cmd_rx_offload_get_configuration_parsed(
 	int q;
 	int ret;
 
-	printf("Rx Offloading Configuration of port %d :\n", port_id);
-
 	ret = eth_dev_conf_get_print_err(port_id, &dev_conf);
 	if (ret != 0)
 		return;
 
+	port = &ports[port_id];
+	printf("Rx Offloading Configuration of port %d :\n", port_id);
+
 	port_offloads = dev_conf.rxmode.offloads;
 	printf("  Port :");
 	print_rx_offloads(port_offloads);
@@ -11741,12 +11742,17 @@ static void
 config_port_rx_offload(portid_t port_id, char *name, bool on)
 {
 	struct rte_eth_dev_info dev_info;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	uint16_t nb_rx_queues;
 	uint64_t offload;
 	int q;
 	int ret;
 
+	ret = eth_dev_info_get_print_err(port_id, &dev_info);
+	if (ret != 0)
+		return;
+
+	port = &ports[port_id];
 	if (port->port_status != RTE_PORT_STOPPED) {
 		fprintf(stderr,
 			"Error: Can't config offload when Port %d is not stopped\n",
@@ -11754,10 +11760,6 @@ config_port_rx_offload(portid_t port_id, char *name, bool on)
 		return;
 	}
 
-	ret = eth_dev_info_get_print_err(port_id, &dev_info);
-	if (ret != 0)
-		return;
-
 	if (!strcmp(name, "all")) {
 		offload = dev_info.rx_offload_capa;
 	} else {
@@ -11943,10 +11945,15 @@ cmd_config_per_queue_rx_offload_parsed(void *parsed_result,
 	struct rte_eth_dev_info dev_info;
 	portid_t port_id = res->port_id;
 	uint16_t queue_id = res->queue_id;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	uint64_t offload;
 	int ret;
 
+	ret = eth_dev_info_get_print_err(port_id, &dev_info);
+	if (ret != 0)
+		return;
+
+	port = &ports[port_id];
 	if (port->port_status != RTE_PORT_STOPPED) {
 		fprintf(stderr,
 			"Error: Can't config offload when Port %d is not stopped\n",
@@ -11954,10 +11961,6 @@ cmd_config_per_queue_rx_offload_parsed(void *parsed_result,
 		return;
 	}
 
-	ret = eth_dev_info_get_print_err(port_id, &dev_info);
-	if (ret != 0)
-		return;
-
 	if (queue_id >= dev_info.nb_rx_queues) {
 		fprintf(stderr,
 			"Error: input queue_id should be 0 ... %d\n",
@@ -12145,7 +12148,7 @@ cmd_tx_offload_get_configuration_parsed(
 	struct cmd_tx_offload_get_configuration_result *res = parsed_result;
 	struct rte_eth_dev_info dev_info;
 	portid_t port_id = res->port_id;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	struct rte_eth_conf dev_conf;
 	uint64_t port_offloads;
 	uint64_t queue_offloads;
@@ -12153,12 +12156,12 @@ cmd_tx_offload_get_configuration_parsed(
 	int q;
 	int ret;
 
-	printf("Tx Offloading Configuration of port %d :\n", port_id);
-
 	ret = eth_dev_conf_get_print_err(port_id, &dev_conf);
 	if (ret != 0)
 		return;
 
+	printf("Tx Offloading Configuration of port %d :\n", port_id);
+	port = &ports[port_id];
 	port_offloads = dev_conf.txmode.offloads;
 	printf("  Port :");
 	print_tx_offloads(port_offloads);
@@ -12263,12 +12266,17 @@ static void
 config_port_tx_offload(portid_t port_id, char *name, bool on)
 {
 	struct rte_eth_dev_info dev_info;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	uint16_t nb_tx_queues;
 	uint64_t offload;
 	int q;
 	int ret;
 
+	ret = eth_dev_info_get_print_err(port_id, &dev_info);
+	if (ret != 0)
+		return;
+
+	port = &ports[port_id];
 	if (port->port_status != RTE_PORT_STOPPED) {
 		fprintf(stderr,
 			"Error: Can't config offload when Port %d is not stopped\n",
@@ -12276,10 +12284,6 @@ config_port_tx_offload(portid_t port_id, char *name, bool on)
 		return;
 	}
 
-	ret = eth_dev_info_get_print_err(port_id, &dev_info);
-	if (ret != 0)
-		return;
-
 	if (!strcmp(name, "all")) {
 		offload = dev_info.tx_offload_capa;
 	} else {
@@ -12469,10 +12473,15 @@ cmd_config_per_queue_tx_offload_parsed(void *parsed_result,
 	struct rte_eth_dev_info dev_info;
 	portid_t port_id = res->port_id;
 	uint16_t queue_id = res->queue_id;
-	struct rte_port *port = &ports[port_id];
+	struct rte_port *port;
 	uint64_t offload;
 	int ret;
 
+	ret = eth_dev_info_get_print_err(port_id, &dev_info);
+	if (ret != 0)
+		return;
+
+	port = &ports[port_id];
 	if (port->port_status != RTE_PORT_STOPPED) {
 		fprintf(stderr,
 			"Error: Can't config offload when Port %d is not stopped\n",
@@ -12480,10 +12489,6 @@ cmd_config_per_queue_tx_offload_parsed(void *parsed_result,
 		return;
 	}
 
-	ret = eth_dev_info_get_print_err(port_id, &dev_info);
-	if (ret != 0)
-		return;
-
 	if (queue_id >= dev_info.nb_tx_queues) {
 		fprintf(stderr,
 			"Error: input queue_id should be 0 ... %d\n",
-- 
2.47.2

