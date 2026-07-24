Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2343C531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABCE640685;
	Fri, 24 Jul 2026 18:45:31 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1A998406B6
 for <dev@dpdk.org>; Fri, 24 Jul 2026 18:45:29 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so480686a12.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784911528;
 x=1785516328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CbvSuU4IBNe4wdz/2qmgbG2ByOEbQdKWuC/gzZX11LE=;
 b=ouF7Dl0+QJTGCSYM+loYumleNhNPMSx4KTiYKIYGnOMylzoeZDbmYbCHG1HYRydGAn
 DhfxOE/QtiDOcuUSLNEKY7zeBvzxj1WXw9C2Gm2LR7ZK1VQX6ESJIeKuQBha7ojJFXeI
 swOCN18gBguQxp+bRqt8FkbOlCRiIjSznXVifEjNI7fRNyoXOsoKZH6FfxDYIEqTmYQO
 U8kePAE943hlXFvahZogz0/DY30nItaJWNB3UHFJ5WnSdBkfjU2Mh1clBPwxZq/Jw6/I
 +pdIzaB0QW77fDyc8SlvWYjJF0Hwn8lAkv2yZRe/OedvyD0RNI6QurDWF7itmLIxFVTS
 x2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911528; x=1785516328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CbvSuU4IBNe4wdz/2qmgbG2ByOEbQdKWuC/gzZX11LE=;
 b=E57A9hMZVeJl0CoFLoHyJr31cEotWbz/GSbGdtgmS194lmsqyQaYB50NoC39gw5rjn
 SlOX3fQ+YNfy0lsP6YMP2OCdpuzUk1qIE2vkOAAJojT1XxQuCyeiq+hmCz1QNINKuXGM
 viX8AqQA4TwONGYjdR6kWKZM3mF3mfY+nCit2WoHrRujFivoLqwiZ+sG4FBvXncKIX0U
 mTD+QiIwxk7dVTFyModDILqWnHF6Tlkp+5DEt7VOYRm90TkXoc/dXCik2SSMR3ClOM3W
 EWR8Dt1gZg/vqDnskyPHuSdPtnpiTaKjUHMuPg+nnPyDHo7Vu9/0uheKMr7GfqheDxFr
 3uhw==
X-Gm-Message-State: AOJu0Yx3AMy9jt8BQC+W5RmqH6M7tX8tXSJgaLIFTtWkXerklkLtlUYN
 LoYirOqFLE7nWAUpTNaSdTOWlh6w5dXWmpUW34hxPqoR12EZ8cqsau5+ZvHBi0X7KXNjdYEwBtW
 ZHjG8
X-Gm-Gg: AR+sD12nzDJB4Bc0BRIVT3v7YbORv1Zvcd8T5oolGXIkFqO4Fdn1xWNphHM6pL1TgyJ
 +k1FYPhZvflBifqc4m5BQsbAfKIs0ZwOXhCiDgSMVdz1Hp9Jvg7F064G1USQWtlr+k91Btirx7L
 ODv3my0Of41aWubAuvsgU+8CfvehXizeaxgfj3DVEASSYyVV8KMUjerEvyLth9c3lKZelR01dvW
 eY5ifDjyndIQgehoQeWPnRhaY4wvPnZpmEX6nfin301VC+iyXv1lFG/SBZpSAk6W7Bi5mFyeO+b
 p1M3uwDWhryegqU9qwTXEdwZejpWupo7KRoYJ5zrylH5g/ibS9J/GickIXKU/fxepaDcFYbIAoo
 B7/ipxgjbb7pyOLqBREfiFqiBzwhdWck+5EKE+sDE/8SSOccvODFmPHefKgZ8ZLddk0DVBI1gCi
 TxahQJ59xDwJHC5bwPbnSpLunPK0PFa9HdyAlt6OYp
X-Received: by 2002:a05:6a20:12c8:b0:3c3:875d:704d with SMTP id
 adf61e73a8af0-3c44b00802bmr9168392637.25.1784911526668; 
 Fri, 24 Jul 2026 09:45:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc549cacsm972872eec.16.2026.07.24.09.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:45:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 2/6] app/test-pipeline: remove application
Date: Fri, 24 Jul 2026 09:43:58 -0700
Message-ID: <20260724164520.192203-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164520.192203-1-stephen@networkplumber.org>
References: <20260724164520.192203-1-stephen@networkplumber.org>
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

The test-pipeline application is built on the legacy pipeline
library API (rte_pipeline_*), which was announced for removal
in the 24.11 release. Remove it before removing the library.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                                   |   2 -
 app/meson.build                               |   1 -
 app/test-pipeline/config.c                    | 230 ---------
 app/test-pipeline/init.c                      | 273 ----------
 app/test-pipeline/main.c                      | 188 -------
 app/test-pipeline/main.h                      | 132 -----
 app/test-pipeline/meson.build                 |  21 -
 app/test-pipeline/pipeline_acl.c              | 251 ----------
 app/test-pipeline/pipeline_hash.c             | 471 ------------------
 app/test-pipeline/pipeline_lpm.c              | 175 -------
 app/test-pipeline/pipeline_lpm_ipv6.c         | 168 -------
 app/test-pipeline/pipeline_stub.c             | 137 -----
 app/test-pipeline/runtime.c                   | 160 ------
 doc/guides/rel_notes/release_26_11.rst        |   3 +
 .../sample_app_ug/img/test_pipeline_app.png   | Bin 67410 -> 0 bytes
 doc/guides/sample_app_ug/index.rst            |   1 -
 doc/guides/sample_app_ug/test_pipeline.rst    | 237 ---------
 17 files changed, 3 insertions(+), 2447 deletions(-)
 delete mode 100644 app/test-pipeline/config.c
 delete mode 100644 app/test-pipeline/init.c
 delete mode 100644 app/test-pipeline/main.c
 delete mode 100644 app/test-pipeline/main.h
 delete mode 100644 app/test-pipeline/meson.build
 delete mode 100644 app/test-pipeline/pipeline_acl.c
 delete mode 100644 app/test-pipeline/pipeline_hash.c
 delete mode 100644 app/test-pipeline/pipeline_lpm.c
 delete mode 100644 app/test-pipeline/pipeline_lpm_ipv6.c
 delete mode 100644 app/test-pipeline/pipeline_stub.c
 delete mode 100644 app/test-pipeline/runtime.c
 delete mode 100644 doc/guides/sample_app_ug/img/test_pipeline_app.png
 delete mode 100644 doc/guides/sample_app_ug/test_pipeline.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 77a41b3fcf..4c06f85706 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1739,8 +1739,6 @@ F: lib/pipeline/
 F: lib/port/
 F: lib/table/
 F: doc/guides/prog_guide/packet_framework.rst
-F: app/test-pipeline/
-F: doc/guides/sample_app_ug/test_pipeline.rst
 F: examples/ip_pipeline/
 F: examples/pipeline/
 F: doc/guides/sample_app_ug/ip_pipeline.rst
diff --git a/app/meson.build b/app/meson.build
index 1798db3ae4..4515688471 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -28,7 +28,6 @@ apps = [
         'test-flow-perf',
         'test-gpudev',
         'test-mldev',
-        'test-pipeline',
         'test-pmd',
         'test-regex',
         'test-sad',
diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
deleted file mode 100644
index daf838948b..0000000000
--- a/app/test-pipeline/config.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <string.h>
-#include <sys/queue.h>
-#include <stdarg.h>
-#include <errno.h>
-#include <getopt.h>
-
-#include <rte_common.h>
-#include <rte_byteorder.h>
-#include <rte_log.h>
-#include <rte_memory.h>
-#include <rte_memcpy.h>
-#include <rte_eal.h>
-#include <rte_per_lcore.h>
-#include <rte_launch.h>
-#include <rte_cycles.h>
-#include <rte_prefetch.h>
-#include <rte_lcore.h>
-#include <rte_branch_prediction.h>
-#include <rte_interrupts.h>
-#include <rte_pci.h>
-#include <rte_random.h>
-#include <rte_debug.h>
-#include <rte_ether.h>
-#include <rte_ethdev.h>
-#include <rte_mempool.h>
-#include <rte_mbuf.h>
-#include <rte_ip.h>
-#include <rte_tcp.h>
-#include <rte_lpm.h>
-#include <rte_lpm6.h>
-#include <rte_string_fns.h>
-
-#include "main.h"
-
-static const char usage[] = "\n";
-
-void
-app_print_usage(void)
-{
-	printf(usage);
-}
-
-static int
-app_parse_port_mask(const char *arg)
-{
-	char *end = NULL;
-	uint64_t port_mask;
-	uint32_t i;
-
-	if (arg[0] == '\0')
-		return -1;
-
-	port_mask = strtoul(arg, &end, 16);
-	if ((end == NULL) || (*end != '\0'))
-		return -2;
-
-	if (port_mask == 0)
-		return -3;
-
-	app.n_ports = 0;
-	for (i = 0; i < 64; i++) {
-		if ((port_mask & (1LLU << i)) == 0)
-			continue;
-
-		if (app.n_ports >= APP_MAX_PORTS)
-			return -4;
-
-		app.ports[app.n_ports] = i;
-		app.n_ports++;
-	}
-
-	if (!rte_is_power_of_2(app.n_ports))
-		return -5;
-
-	return 0;
-}
-
-struct {
-	const char *name;
-	uint32_t value;
-} app_args_table[] = {
-	{"none", e_APP_PIPELINE_NONE},
-	{"stub", e_APP_PIPELINE_STUB},
-	{"hash-8-ext", e_APP_PIPELINE_HASH_KEY8_EXT},
-	{"hash-8-lru", e_APP_PIPELINE_HASH_KEY8_LRU},
-	{"hash-16-ext", e_APP_PIPELINE_HASH_KEY16_EXT},
-	{"hash-16-lru", e_APP_PIPELINE_HASH_KEY16_LRU},
-	{"hash-32-ext", e_APP_PIPELINE_HASH_KEY32_EXT},
-	{"hash-32-lru", e_APP_PIPELINE_HASH_KEY32_LRU},
-	{"hash-spec-8-ext", e_APP_PIPELINE_HASH_SPEC_KEY8_EXT},
-	{"hash-spec-8-lru", e_APP_PIPELINE_HASH_SPEC_KEY8_LRU},
-	{"hash-spec-16-ext", e_APP_PIPELINE_HASH_SPEC_KEY16_EXT},
-	{"hash-spec-16-lru", e_APP_PIPELINE_HASH_SPEC_KEY16_LRU},
-	{"hash-spec-32-ext", e_APP_PIPELINE_HASH_SPEC_KEY32_EXT},
-	{"hash-spec-32-lru", e_APP_PIPELINE_HASH_SPEC_KEY32_LRU},
-	{"acl", e_APP_PIPELINE_ACL},
-	{"lpm", e_APP_PIPELINE_LPM},
-	{"lpm-ipv6", e_APP_PIPELINE_LPM_IPV6},
-	{"hash-cuckoo-8", e_APP_PIPELINE_HASH_CUCKOO_KEY8},
-	{"hash-cuckoo-16", e_APP_PIPELINE_HASH_CUCKOO_KEY16},
-	{"hash-cuckoo-32", e_APP_PIPELINE_HASH_CUCKOO_KEY32},
-	{"hash-cuckoo-48", e_APP_PIPELINE_HASH_CUCKOO_KEY48},
-	{"hash-cuckoo-64", e_APP_PIPELINE_HASH_CUCKOO_KEY64},
-	{"hash-cuckoo-80", e_APP_PIPELINE_HASH_CUCKOO_KEY80},
-	{"hash-cuckoo-96", e_APP_PIPELINE_HASH_CUCKOO_KEY96},
-	{"hash-cuckoo-112", e_APP_PIPELINE_HASH_CUCKOO_KEY112},
-	{"hash-cuckoo-128", e_APP_PIPELINE_HASH_CUCKOO_KEY128},
-};
-
-int
-app_parse_args(int argc, char **argv)
-{
-	int opt, ret;
-	char **argvopt;
-	int option_index;
-	char *prgname = argv[0];
-	static struct option lgopts[] = {
-		{"none", 0, 0, 0},
-		{"stub", 0, 0, 0},
-		{"hash-8-ext", 0, 0, 0},
-		{"hash-8-lru", 0, 0, 0},
-		{"hash-16-ext", 0, 0, 0},
-		{"hash-16-lru", 0, 0, 0},
-		{"hash-32-ext", 0, 0, 0},
-		{"hash-32-lru", 0, 0, 0},
-		{"hash-spec-8-ext", 0, 0, 0},
-		{"hash-spec-8-lru", 0, 0, 0},
-		{"hash-spec-16-ext", 0, 0, 0},
-		{"hash-spec-16-lru", 0, 0, 0},
-		{"hash-spec-32-ext", 0, 0, 0},
-		{"hash-spec-32-lru", 0, 0, 0},
-		{"acl", 0, 0, 0},
-		{"lpm", 0, 0, 0},
-		{"lpm-ipv6", 0, 0, 0},
-		{"hash-cuckoo-8", 0, 0, 0},
-		{"hash-cuckoo-16", 0, 0, 0},
-		{"hash-cuckoo-32", 0, 0, 0},
-		{"hash-cuckoo-48", 0, 0, 0},
-		{"hash-cuckoo-64", 0, 0, 0},
-		{"hash-cuckoo-80", 0, 0, 0},
-		{"hash-cuckoo-96", 0, 0, 0},
-		{"hash-cuckoo-112", 0, 0, 0},
-		{"hash-cuckoo-128", 0, 0, 0},
-		{NULL, 0, 0, 0}
-	};
-	uint32_t lcores[3], n_lcores, lcore_id, pipeline_type_provided;
-
-	/* EAL args */
-	n_lcores = 0;
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (rte_lcore_is_enabled(lcore_id) == 0)
-			continue;
-
-		if (n_lcores >= 3) {
-			RTE_LOG(ERR, USER1, "Number of cores must be 3\n");
-			app_print_usage();
-			return -1;
-		}
-
-		lcores[n_lcores] = lcore_id;
-		n_lcores++;
-	}
-
-	if (n_lcores != 3) {
-		RTE_LOG(ERR, USER1, "Number of cores must be 3\n");
-		app_print_usage();
-		return -1;
-	}
-
-	app.core_rx = lcores[0];
-	app.core_worker = lcores[1];
-	app.core_tx = lcores[2];
-
-	/* Non-EAL args */
-	argvopt = argv;
-
-	app.pipeline_type = e_APP_PIPELINE_HASH_KEY16_LRU;
-	pipeline_type_provided = 0;
-
-	while ((opt = getopt_long(argc, argvopt, "p:",
-			lgopts, &option_index)) != EOF) {
-		switch (opt) {
-		case 'p':
-			if (app_parse_port_mask(optarg) < 0) {
-				app_print_usage();
-				return -1;
-			}
-			break;
-
-		case 0: /* long options */
-			if (!pipeline_type_provided) {
-				uint32_t i;
-
-				for (i = 0; i < e_APP_PIPELINES; i++) {
-					if (!strcmp(lgopts[option_index].name,
-						app_args_table[i].name)) {
-						app.pipeline_type =
-							app_args_table[i].value;
-						pipeline_type_provided = 1;
-						break;
-					}
-				}
-
-				break;
-			}
-
-			app_print_usage();
-			return -1;
-
-		default:
-			return -1;
-		}
-	}
-
-	if (optind >= 0)
-		argv[optind - 1] = prgname;
-
-	ret = optind - 1;
-	optind = 1; /* reset getopt lib */
-	return ret;
-}
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
deleted file mode 100644
index 558f0e428d..0000000000
--- a/app/test-pipeline/init.c
+++ /dev/null
@@ -1,273 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <string.h>
-#include <sys/queue.h>
-#include <stdarg.h>
-#include <errno.h>
-#include <getopt.h>
-
-#include <rte_common.h>
-#include <rte_byteorder.h>
-#include <rte_log.h>
-#include <rte_memory.h>
-#include <rte_memcpy.h>
-#include <rte_eal.h>
-#include <rte_per_lcore.h>
-#include <rte_launch.h>
-#include <rte_cycles.h>
-#include <rte_prefetch.h>
-#include <rte_lcore.h>
-#include <rte_branch_prediction.h>
-#include <rte_interrupts.h>
-#include <rte_pci.h>
-#include <rte_random.h>
-#include <rte_debug.h>
-#include <rte_ether.h>
-#include <rte_ethdev.h>
-#include <rte_ring.h>
-#include <rte_mempool.h>
-#include <rte_mbuf.h>
-#include <rte_string_fns.h>
-#include <rte_ip.h>
-#include <rte_tcp.h>
-#include <rte_lpm.h>
-#include <rte_lpm6.h>
-
-#include "main.h"
-
-struct app_params app = {
-	/* Ports*/
-	.n_ports = APP_MAX_PORTS,
-	.port_rx_ring_size = 128,
-	.port_tx_ring_size = 512,
-
-	/* Rings */
-	.ring_rx_size = 128,
-	.ring_tx_size = 128,
-
-	/* Buffer pool */
-	.pool_buffer_size = 2048 + RTE_PKTMBUF_HEADROOM,
-	.pool_size = 32 * 1024,
-	.pool_cache_size = 256,
-
-	/* Burst sizes */
-	.burst_size_rx_read = 64,
-	.burst_size_rx_write = 64,
-	.burst_size_worker_read = 64,
-	.burst_size_worker_write = 64,
-	.burst_size_tx_read = 64,
-	.burst_size_tx_write = 64,
-};
-
-static struct rte_eth_conf port_conf = {
-	.rxmode = {
-		.offloads = RTE_ETH_RX_OFFLOAD_CHECKSUM,
-	},
-	.rx_adv_conf = {
-		.rss_conf = {
-			.rss_key = NULL,
-			.rss_hf = RTE_ETH_RSS_IP,
-		},
-	},
-	.txmode = {
-		.mq_mode = RTE_ETH_MQ_TX_NONE,
-	},
-};
-
-static struct rte_eth_rxconf rx_conf = {
-	.rx_thresh = {
-		.pthresh = 8,
-		.hthresh = 8,
-		.wthresh = 4,
-	},
-	.rx_free_thresh = 64,
-	.rx_drop_en = 0,
-};
-
-static struct rte_eth_txconf tx_conf = {
-	.tx_thresh = {
-		.pthresh = 36,
-		.hthresh = 0,
-		.wthresh = 0,
-	},
-	.tx_free_thresh = 0,
-	.tx_rs_thresh = 0,
-};
-
-static void
-app_init_mbuf_pools(void)
-{
-	/* Init the buffer pool */
-	RTE_LOG(INFO, USER1, "Creating the mbuf pool ...\n");
-	app.pool = rte_pktmbuf_pool_create("mempool", app.pool_size,
-		app.pool_cache_size, 0, app.pool_buffer_size, rte_socket_id());
-	if (app.pool == NULL)
-		rte_panic("Cannot create mbuf pool\n");
-}
-
-static void
-app_init_rings(void)
-{
-	uint32_t i;
-
-	for (i = 0; i < app.n_ports; i++) {
-		char name[32];
-
-		snprintf(name, sizeof(name), "app_ring_rx_%u", i);
-
-		app.rings_rx[i] = rte_ring_create(
-			name,
-			app.ring_rx_size,
-			rte_socket_id(),
-			RING_F_SP_ENQ | RING_F_SC_DEQ);
-
-		if (app.rings_rx[i] == NULL)
-			rte_panic("Cannot create RX ring %u\n", i);
-	}
-
-	for (i = 0; i < app.n_ports; i++) {
-		char name[32];
-
-		snprintf(name, sizeof(name), "app_ring_tx_%u", i);
-
-		app.rings_tx[i] = rte_ring_create(
-			name,
-			app.ring_tx_size,
-			rte_socket_id(),
-			RING_F_SP_ENQ | RING_F_SC_DEQ);
-
-		if (app.rings_tx[i] == NULL)
-			rte_panic("Cannot create TX ring %u\n", i);
-	}
-
-}
-
-static void
-app_ports_check_link(void)
-{
-	uint32_t all_ports_up, i;
-	char link_status_text[RTE_ETH_LINK_MAX_STR_LEN];
-	all_ports_up = 1;
-
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_eth_link link;
-		uint16_t port;
-		int ret;
-
-		port = app.ports[i];
-		memset(&link, 0, sizeof(link));
-		ret = rte_eth_link_get_nowait(port, &link);
-		if (ret < 0) {
-			RTE_LOG(INFO, USER1,
-				"Failed to get port %u link status: %s\n",
-				port, rte_strerror(-ret));
-			all_ports_up = 0;
-			continue;
-		}
-		rte_eth_link_to_str(link_status_text, sizeof(link_status_text),
-				    &link);
-		RTE_LOG(INFO, USER1, "Port %u %s\n",
-			port,
-			link_status_text);
-		if (link.link_status == RTE_ETH_LINK_DOWN)
-			all_ports_up = 0;
-	}
-
-	if (all_ports_up == 0)
-		rte_panic("Some NIC ports are DOWN\n");
-}
-
-static void
-app_init_ports(void)
-{
-	uint32_t i;
-	struct rte_eth_dev_info dev_info;
-
-	/* Init NIC ports, then start the ports */
-	for (i = 0; i < app.n_ports; i++) {
-		uint16_t port;
-		int ret;
-		struct rte_eth_conf local_port_conf = port_conf;
-
-		port = app.ports[i];
-		RTE_LOG(INFO, USER1, "Initializing NIC port %u ...\n", port);
-
-		ret = rte_eth_dev_info_get(port, &dev_info);
-		if (ret != 0)
-			rte_panic("Error during getting device (port %u) info: %s\n",
-					port, rte_strerror(-ret));
-
-		/* Init port */
-		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
-			dev_info.flow_type_rss_offloads;
-		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
-				port_conf.rx_adv_conf.rss_conf.rss_hf) {
-			printf("Warning:"
-				"Port %u modified RSS hash function based on hardware support,"
-				"requested:%#"PRIx64" configured:%#"PRIx64"\n",
-				port,
-				port_conf.rx_adv_conf.rss_conf.rss_hf,
-				local_port_conf.rx_adv_conf.rss_conf.rss_hf);
-		}
-
-		ret = rte_eth_dev_configure(
-			port,
-			1,
-			1,
-			&local_port_conf);
-		if (ret < 0)
-			rte_panic("Cannot init NIC port %u (%d)\n", port, ret);
-
-		ret = rte_eth_promiscuous_enable(port);
-		if (ret != 0)
-			rte_panic("Cannot enable promiscuous mode for port %u: %s\n",
-				port, rte_strerror(-ret));
-
-		/* Init RX queues */
-		ret = rte_eth_rx_queue_setup(
-			port,
-			0,
-			app.port_rx_ring_size,
-			rte_eth_dev_socket_id(port),
-			&rx_conf,
-			app.pool);
-		if (ret < 0)
-			rte_panic("Cannot init RX for port %u (%d)\n",
-				(uint32_t) port, ret);
-
-		/* Init TX queues */
-		ret = rte_eth_tx_queue_setup(
-			port,
-			0,
-			app.port_tx_ring_size,
-			rte_eth_dev_socket_id(port),
-			&tx_conf);
-		if (ret < 0)
-			rte_panic("Cannot init TX for port %u (%d)\n",
-				(uint32_t) port, ret);
-
-		/* Start port */
-		ret = rte_eth_dev_start(port);
-		if (ret < 0)
-			rte_panic("Cannot start port %u (%d)\n", port, ret);
-	}
-
-	app_ports_check_link();
-}
-
-void
-app_init(void)
-{
-	app_init_mbuf_pools();
-	app_init_rings();
-	app_init_ports();
-
-	RTE_LOG(INFO, USER1, "Initialization completed\n");
-}
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
deleted file mode 100644
index e5efafdf28..0000000000
--- a/app/test-pipeline/main.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <string.h>
-#include <sys/queue.h>
-#include <stdarg.h>
-#include <signal.h>
-#include <errno.h>
-#include <getopt.h>
-#include <unistd.h>
-
-#include <rte_common.h>
-#include <rte_byteorder.h>
-#include <rte_log.h>
-#include <rte_memory.h>
-#include <rte_memcpy.h>
-#include <rte_eal.h>
-#include <rte_per_lcore.h>
-#include <rte_launch.h>
-#include <rte_cycles.h>
-#include <rte_prefetch.h>
-#include <rte_lcore.h>
-#include <rte_branch_prediction.h>
-#include <rte_interrupts.h>
-#include <rte_pci.h>
-#include <rte_random.h>
-#include <rte_debug.h>
-#include <rte_ether.h>
-#include <rte_ethdev.h>
-#include <rte_mempool.h>
-#include <rte_mbuf.h>
-#include <rte_ip.h>
-#include <rte_tcp.h>
-#include <rte_lpm.h>
-#include <rte_lpm6.h>
-
-#include "main.h"
-
-bool force_quit;
-
-static void
-signal_handler(int signum)
-{
-	if (signum == SIGINT || signum == SIGTERM)
-		force_quit = true;
-}
-
-int
-main(int argc, char **argv)
-{
-	uint32_t lcore;
-	uint32_t i;
-	int ret;
-
-	/* Init EAL */
-	ret = rte_eal_init(argc, argv);
-	if (ret < 0)
-		return -1;
-	argc -= ret;
-	argv += ret;
-
-	force_quit = false;
-	signal(SIGINT, signal_handler);
-	signal(SIGTERM, signal_handler);
-
-	/* Parse application arguments (after the EAL ones) */
-	ret = app_parse_args(argc, argv);
-	if (ret < 0) {
-		app_print_usage();
-		return -1;
-	}
-
-	/* Init */
-	app_init();
-
-	/* Launch per-lcore init on every lcore */
-	rte_eal_mp_remote_launch(app_lcore_main_loop, NULL, CALL_MAIN);
-	RTE_LCORE_FOREACH_WORKER(lcore) {
-		if (rte_eal_wait_lcore(lcore) < 0)
-			return -1;
-	}
-
-	/* Close ports */
-	for (i = 0; i < app.n_ports; i++) {
-		uint16_t port;
-
-		port = app.ports[i];
-		printf("Closing port %d...", port);
-		ret = rte_eth_dev_stop(port);
-		if (ret != 0)
-			printf("rte_eth_dev_stop: err=%d, port=%u\n",
-					 ret, port);
-		rte_eth_dev_close(port);
-		printf("Done\n");
-	}
-
-	/* Clean up the EAL */
-	rte_eal_cleanup();
-
-	return 0;
-}
-
-int
-app_lcore_main_loop(__rte_unused void *arg)
-{
-	unsigned lcore;
-
-	lcore = rte_lcore_id();
-
-	if (lcore == app.core_rx) {
-		switch (app.pipeline_type) {
-		case e_APP_PIPELINE_ACL:
-			app_main_loop_rx();
-			return 0;
-
-		default:
-			app_main_loop_rx_metadata();
-			return 0;
-		}
-	}
-
-	if (lcore == app.core_worker) {
-		switch (app.pipeline_type) {
-		case e_APP_PIPELINE_STUB:
-			app_main_loop_worker_pipeline_stub();
-			return 0;
-
-		case e_APP_PIPELINE_HASH_KEY8_EXT:
-		case e_APP_PIPELINE_HASH_KEY8_LRU:
-		case e_APP_PIPELINE_HASH_KEY16_EXT:
-		case e_APP_PIPELINE_HASH_KEY16_LRU:
-		case e_APP_PIPELINE_HASH_KEY32_EXT:
-		case e_APP_PIPELINE_HASH_KEY32_LRU:
-		case e_APP_PIPELINE_HASH_SPEC_KEY8_EXT:
-		case e_APP_PIPELINE_HASH_SPEC_KEY8_LRU:
-		case e_APP_PIPELINE_HASH_SPEC_KEY16_EXT:
-		case e_APP_PIPELINE_HASH_SPEC_KEY16_LRU:
-		case e_APP_PIPELINE_HASH_SPEC_KEY32_EXT:
-		case e_APP_PIPELINE_HASH_SPEC_KEY32_LRU:
-		/* cases for cuckoo hash table types */
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY8:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY16:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY32:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY48:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY64:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY80:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY96:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY112:
-		case e_APP_PIPELINE_HASH_CUCKOO_KEY128:
-			app_main_loop_worker_pipeline_hash();
-			return 0;
-
-		case e_APP_PIPELINE_ACL:
-#ifndef RTE_LIB_ACL
-			rte_exit(EXIT_FAILURE, "ACL not present in build\n");
-#else
-			app_main_loop_worker_pipeline_acl();
-			return 0;
-#endif
-
-		case e_APP_PIPELINE_LPM:
-			app_main_loop_worker_pipeline_lpm();
-			return 0;
-
-		case e_APP_PIPELINE_LPM_IPV6:
-			app_main_loop_worker_pipeline_lpm_ipv6();
-			return 0;
-
-		case e_APP_PIPELINE_NONE:
-		default:
-			app_main_loop_worker();
-			return 0;
-		}
-	}
-
-	if (lcore == app.core_tx) {
-		app_main_loop_tx();
-		return 0;
-	}
-
-	return 0;
-}
diff --git a/app/test-pipeline/main.h b/app/test-pipeline/main.h
deleted file mode 100644
index ee9c58ac4c..0000000000
--- a/app/test-pipeline/main.h
+++ /dev/null
@@ -1,132 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#ifndef _MAIN_H_
-#define _MAIN_H_
-
-#ifndef APP_MBUF_ARRAY_SIZE
-#define APP_MBUF_ARRAY_SIZE 256
-#endif
-
-struct app_mbuf_array {
-	struct rte_mbuf *array[APP_MBUF_ARRAY_SIZE];
-	uint16_t n_mbufs;
-};
-
-#ifndef APP_MAX_PORTS
-#define APP_MAX_PORTS 4
-#endif
-
-struct __rte_cache_aligned app_params {
-	/* CPU cores */
-	uint32_t core_rx;
-	uint32_t core_worker;
-	uint32_t core_tx;
-
-	/* Ports*/
-	uint32_t ports[APP_MAX_PORTS];
-	uint32_t n_ports;
-	uint32_t port_rx_ring_size;
-	uint32_t port_tx_ring_size;
-
-	/* Rings */
-	struct rte_ring *rings_rx[APP_MAX_PORTS];
-	struct rte_ring *rings_tx[APP_MAX_PORTS];
-	uint32_t ring_rx_size;
-	uint32_t ring_tx_size;
-
-	/* Internal buffers */
-	struct app_mbuf_array mbuf_rx;
-	struct app_mbuf_array mbuf_tx[APP_MAX_PORTS];
-
-	/* Buffer pool */
-	struct rte_mempool *pool;
-	uint32_t pool_buffer_size;
-	uint32_t pool_size;
-	uint32_t pool_cache_size;
-
-	/* Burst sizes */
-	uint32_t burst_size_rx_read;
-	uint32_t burst_size_rx_write;
-	uint32_t burst_size_worker_read;
-	uint32_t burst_size_worker_write;
-	uint32_t burst_size_tx_read;
-	uint32_t burst_size_tx_write;
-
-	/* App behavior */
-	uint32_t pipeline_type;
-};
-
-extern struct app_params app;
-
-extern bool force_quit;
-
-int app_parse_args(int argc, char **argv);
-void app_print_usage(void);
-void app_init(void);
-int app_lcore_main_loop(void *arg);
-
-/* Pipeline */
-enum {
-	e_APP_PIPELINE_NONE = 0,
-	e_APP_PIPELINE_STUB,
-
-	e_APP_PIPELINE_HASH_KEY8_EXT,
-	e_APP_PIPELINE_HASH_KEY8_LRU,
-	e_APP_PIPELINE_HASH_KEY16_EXT,
-	e_APP_PIPELINE_HASH_KEY16_LRU,
-	e_APP_PIPELINE_HASH_KEY32_EXT,
-	e_APP_PIPELINE_HASH_KEY32_LRU,
-
-	e_APP_PIPELINE_HASH_SPEC_KEY8_EXT,
-	e_APP_PIPELINE_HASH_SPEC_KEY8_LRU,
-	e_APP_PIPELINE_HASH_SPEC_KEY16_EXT,
-	e_APP_PIPELINE_HASH_SPEC_KEY16_LRU,
-	e_APP_PIPELINE_HASH_SPEC_KEY32_EXT,
-	e_APP_PIPELINE_HASH_SPEC_KEY32_LRU,
-
-	e_APP_PIPELINE_ACL,
-	e_APP_PIPELINE_LPM,
-	e_APP_PIPELINE_LPM_IPV6,
-
-	e_APP_PIPELINE_HASH_CUCKOO_KEY8,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY16,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY32,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY48,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY64,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY80,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY96,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY112,
-	e_APP_PIPELINE_HASH_CUCKOO_KEY128,
-	e_APP_PIPELINES
-};
-
-void app_main_loop_rx(void);
-void app_main_loop_rx_metadata(void);
-uint64_t test_hash(void *key,
-	void *key_mask,
-	uint32_t key_size,
-	uint64_t seed);
-
-uint32_t test_hash_cuckoo(const void *key,
-	uint32_t key_size,
-	uint32_t seed);
-
-void app_main_loop_worker(void);
-void app_main_loop_worker_pipeline_stub(void);
-void app_main_loop_worker_pipeline_hash(void);
-void app_main_loop_worker_pipeline_acl(void);
-void app_main_loop_worker_pipeline_lpm(void);
-void app_main_loop_worker_pipeline_lpm_ipv6(void);
-
-void app_main_loop_tx(void);
-
-#define APP_FLUSH 0
-#ifndef APP_FLUSH
-#define APP_FLUSH 0x3FF
-#endif
-
-#define APP_METADATA_OFFSET(offset) (sizeof(struct rte_mbuf) + (offset))
-
-#endif /* _MAIN_H_ */
diff --git a/app/test-pipeline/meson.build b/app/test-pipeline/meson.build
deleted file mode 100644
index 3add6b637b..0000000000
--- a/app/test-pipeline/meson.build
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2019 Intel Corporation
-
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
-sources = files(
-        'config.c',
-        'init.c',
-        'main.c',
-        'pipeline_acl.c',
-        'pipeline_hash.c',
-        'pipeline_lpm.c',
-        'pipeline_lpm_ipv6.c',
-        'pipeline_stub.c',
-        'runtime.c',
-)
-deps += ['pipeline', 'pci']
diff --git a/app/test-pipeline/pipeline_acl.c b/app/test-pipeline/pipeline_acl.c
deleted file mode 100644
index 9eb4053e23..0000000000
--- a/app/test-pipeline/pipeline_acl.c
+++ /dev/null
@@ -1,251 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-#include <rte_log.h>
-#include <rte_ethdev.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
-#include <rte_byteorder.h>
-
-#include <rte_port_ring.h>
-#include <rte_table_acl.h>
-#include <rte_pipeline.h>
-
-#include "main.h"
-
-enum {
-	PROTO_FIELD_IPV4,
-	SRC_FIELD_IPV4,
-	DST_FIELD_IPV4,
-	SRCP_FIELD_IPV4,
-	DSTP_FIELD_IPV4,
-	NUM_FIELDS_IPV4
-};
-
-/*
- * Here we define the 'shape' of the data we're searching for,
- * by defining the meta-data of the ACL rules.
- * in this case, we're defining 5 tuples. IP addresses, ports,
- * and protocol.
- */
-struct rte_acl_field_def ipv4_field_formats[NUM_FIELDS_IPV4] = {
-	{
-		.type = RTE_ACL_FIELD_TYPE_BITMASK,
-		.size = sizeof(uint8_t),
-		.field_index = PROTO_FIELD_IPV4,
-		.input_index = PROTO_FIELD_IPV4,
-		.offset = sizeof(struct rte_ether_hdr) +
-			offsetof(struct rte_ipv4_hdr, next_proto_id),
-	},
-	{
-		.type = RTE_ACL_FIELD_TYPE_MASK,
-		.size = sizeof(uint32_t),
-		.field_index = SRC_FIELD_IPV4,
-		.input_index = SRC_FIELD_IPV4,
-		.offset = sizeof(struct rte_ether_hdr) +
-			offsetof(struct rte_ipv4_hdr, src_addr),
-	},
-	{
-		.type = RTE_ACL_FIELD_TYPE_MASK,
-		.size = sizeof(uint32_t),
-		.field_index = DST_FIELD_IPV4,
-		.input_index = DST_FIELD_IPV4,
-		.offset = sizeof(struct rte_ether_hdr) +
-			offsetof(struct rte_ipv4_hdr, dst_addr),
-	},
-	{
-		.type = RTE_ACL_FIELD_TYPE_RANGE,
-		.size = sizeof(uint16_t),
-		.field_index = SRCP_FIELD_IPV4,
-		.input_index = SRCP_FIELD_IPV4,
-		.offset = sizeof(struct rte_ether_hdr) +
-			sizeof(struct rte_ipv4_hdr),
-	},
-	{
-		.type = RTE_ACL_FIELD_TYPE_RANGE,
-		.size = sizeof(uint16_t),
-		.field_index = DSTP_FIELD_IPV4,
-		.input_index = SRCP_FIELD_IPV4,
-		.offset = sizeof(struct rte_ether_hdr) +
-			sizeof(struct rte_ipv4_hdr) + sizeof(uint16_t),
-	},
-};
-
-
-
-void
-app_main_loop_worker_pipeline_acl(void) {
-	struct rte_pipeline_params pipeline_params = {
-		.name = "pipeline",
-		.socket_id = rte_socket_id(),
-	};
-
-	struct rte_pipeline *p;
-	uint32_t port_in_id[APP_MAX_PORTS];
-	uint32_t port_out_id[APP_MAX_PORTS];
-	uint32_t table_id;
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1,
-		"Core %u is doing work (pipeline with ACL table)\n",
-		rte_lcore_id());
-
-	/* Pipeline configuration */
-	p = rte_pipeline_create(&pipeline_params);
-	if (p == NULL)
-		rte_panic("Unable to configure the pipeline\n");
-
-	/* Input port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_reader_params port_ring_params = {
-			.ring = app.rings_rx[i],
-		};
-
-		struct rte_pipeline_port_in_params port_params = {
-			.ops = &rte_port_ring_reader_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-			.burst_size = app.burst_size_worker_read,
-		};
-
-		if (rte_pipeline_port_in_create(p, &port_params,
-			&port_in_id[i]))
-			rte_panic("Unable to configure input port for "
-				"ring %d\n", i);
-	}
-
-	/* Output port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_writer_params port_ring_params = {
-			.ring = app.rings_tx[i],
-			.tx_burst_sz = app.burst_size_worker_write,
-		};
-
-		struct rte_pipeline_port_out_params port_params = {
-			.ops = &rte_port_ring_writer_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-		};
-
-		if (rte_pipeline_port_out_create(p, &port_params,
-			&port_out_id[i]))
-			rte_panic("Unable to configure output port for "
-				"ring %d\n", i);
-	}
-
-	/* Table configuration */
-	{
-		struct rte_table_acl_params table_acl_params = {
-			.name = "test", /* unique identifier for acl contexts */
-			.n_rules = 1 << 5,
-			.n_rule_fields = DIM(ipv4_field_formats),
-		};
-
-		/* Copy in the rule meta-data defined above into the params */
-		memcpy(table_acl_params.field_format, ipv4_field_formats,
-			sizeof(ipv4_field_formats));
-
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_acl_ops,
-			.arg_create = &table_acl_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the ACL table\n");
-	}
-
-	/* Interconnecting ports and tables */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id))
-			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id);
-
-	/* Add entries to tables */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_pipeline_table_entry table_entry = {
-			.action = RTE_PIPELINE_ACTION_PORT,
-			{.port_id = port_out_id[i & (app.n_ports - 1)]},
-		};
-		struct rte_table_acl_rule_add_params rule_params;
-		struct rte_pipeline_table_entry *entry_ptr;
-		int key_found, ret;
-
-		memset(&rule_params, 0, sizeof(rule_params));
-
-		/* Set the rule values */
-		rule_params.field_value[SRC_FIELD_IPV4].value.u32 = 0;
-		rule_params.field_value[SRC_FIELD_IPV4].mask_range.u32 = 0;
-		rule_params.field_value[DST_FIELD_IPV4].value.u32 =
-			i << (24 - rte_popcount32(app.n_ports - 1));
-		rule_params.field_value[DST_FIELD_IPV4].mask_range.u32 =
-			8 + rte_popcount32(app.n_ports - 1);
-		rule_params.field_value[SRCP_FIELD_IPV4].value.u16 = 0;
-		rule_params.field_value[SRCP_FIELD_IPV4].mask_range.u16 =
-			UINT16_MAX;
-		rule_params.field_value[DSTP_FIELD_IPV4].value.u16 = 0;
-		rule_params.field_value[DSTP_FIELD_IPV4].mask_range.u16 =
-			UINT16_MAX;
-		rule_params.field_value[PROTO_FIELD_IPV4].value.u8 = 0;
-		rule_params.field_value[PROTO_FIELD_IPV4].mask_range.u8 = 0;
-
-		rule_params.priority = 0;
-
-		uint32_t dst_addr = rule_params.field_value[DST_FIELD_IPV4].
-			value.u32;
-		uint32_t dst_mask =
-			rule_params.field_value[DST_FIELD_IPV4].mask_range.u32;
-
-		printf("Adding rule to ACL table (IPv4 destination = "
-			"%u.%u.%u.%u/%u => port out = %u)\n",
-			(dst_addr & 0xFF000000) >> 24,
-			(dst_addr & 0x00FF0000) >> 16,
-			(dst_addr & 0x0000FF00) >> 8,
-			dst_addr & 0x000000FF,
-			dst_mask,
-			table_entry.port_id);
-
-		/* For ACL, add needs an rte_table_acl_rule_add_params struct */
-		ret = rte_pipeline_table_entry_add(p, table_id, &rule_params,
-			&table_entry, &key_found, &entry_ptr);
-		if (ret < 0)
-			rte_panic("Unable to add entry to table %u (%d)\n",
-				table_id, ret);
-	}
-
-	/* Enable input ports */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_enable(p, port_in_id[i]))
-			rte_panic("Unable to enable input port %u\n",
-				port_in_id[i]);
-
-	/* Check pipeline consistency */
-	if (rte_pipeline_check(p) < 0)
-		rte_panic("Pipeline consistency check failed\n");
-
-	/* Run-time */
-#if APP_FLUSH == 0
-	while (!force_quit)
-		rte_pipeline_run(p);
-#else
-	i = 0;
-	while (!force_quit) {
-		rte_pipeline_run(p);
-
-		if ((i & APP_FLUSH) == 0)
-			rte_pipeline_flush(p);
-		i++;
-	}
-#endif
-}
diff --git a/app/test-pipeline/pipeline_hash.c b/app/test-pipeline/pipeline_hash.c
deleted file mode 100644
index 194e5c5dcc..0000000000
--- a/app/test-pipeline/pipeline_hash.c
+++ /dev/null
@@ -1,471 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-#include <rte_log.h>
-#include <rte_ethdev.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
-#include <rte_byteorder.h>
-
-#include <rte_port_ring.h>
-#include <rte_table_hash.h>
-#include <rte_hash.h>
-#include <rte_table_hash_cuckoo.h>
-#include <rte_pipeline.h>
-
-#include "main.h"
-
-static void
-translate_options(uint32_t *special, uint32_t *ext, uint32_t *key_size)
-{
-	switch (app.pipeline_type) {
-	case e_APP_PIPELINE_HASH_KEY8_EXT:
-		*special = 0; *ext = 1; *key_size = 8; return;
-	case e_APP_PIPELINE_HASH_KEY8_LRU:
-		*special = 0; *ext = 0; *key_size = 8; return;
-	case e_APP_PIPELINE_HASH_KEY16_EXT:
-		*special = 0; *ext = 1; *key_size = 16; return;
-	case e_APP_PIPELINE_HASH_KEY16_LRU:
-		*special = 0; *ext = 0; *key_size = 16; return;
-	case e_APP_PIPELINE_HASH_KEY32_EXT:
-		*special = 0; *ext = 1; *key_size = 32; return;
-	case e_APP_PIPELINE_HASH_KEY32_LRU:
-		*special = 0; *ext = 0; *key_size = 32; return;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY8_EXT:
-		*special = 1; *ext = 1; *key_size = 8; return;
-	case e_APP_PIPELINE_HASH_SPEC_KEY8_LRU:
-		*special = 1; *ext = 0; *key_size = 8; return;
-	case e_APP_PIPELINE_HASH_SPEC_KEY16_EXT:
-		*special = 1; *ext = 1; *key_size = 16; return;
-	case e_APP_PIPELINE_HASH_SPEC_KEY16_LRU:
-		*special = 1; *ext = 0; *key_size = 16; return;
-	case e_APP_PIPELINE_HASH_SPEC_KEY32_EXT:
-		*special = 1; *ext = 1; *key_size = 32; return;
-	case e_APP_PIPELINE_HASH_SPEC_KEY32_LRU:
-		*special = 1; *ext = 0; *key_size = 32; return;
-
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY8:
-		*special = 0; *ext = 0; *key_size = 8; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY16:
-		*special = 0; *ext = 0; *key_size = 16; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY32:
-		*special = 0; *ext = 0; *key_size = 32; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY48:
-		*special = 0; *ext = 0; *key_size = 48; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY64:
-		*special = 0; *ext = 0; *key_size = 64; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY80:
-		*special = 0; *ext = 0; *key_size = 80; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY96:
-		*special = 0; *ext = 0; *key_size = 96; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY112:
-		*special = 0; *ext = 0; *key_size = 112; return;
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY128:
-		*special = 0; *ext = 0; *key_size = 128; return;
-
-	default:
-		rte_panic("Invalid hash table type or key size\n");
-	}
-}
-void
-app_main_loop_worker_pipeline_hash(void) {
-	struct rte_pipeline_params pipeline_params = {
-		.name = "pipeline",
-		.socket_id = rte_socket_id(),
-	};
-
-	struct rte_pipeline *p;
-	uint32_t port_in_id[APP_MAX_PORTS];
-	uint32_t port_out_id[APP_MAX_PORTS];
-	uint32_t table_id;
-	uint32_t i;
-	uint32_t special, ext, key_size;
-
-	translate_options(&special, &ext, &key_size);
-
-	RTE_LOG(INFO, USER1, "Core %u is doing work "
-		"(pipeline with hash table, %s, %s, %d-byte key)\n",
-		rte_lcore_id(),
-		special ? "specialized" : "non-specialized",
-		ext ? "extendible bucket" : "LRU",
-		key_size);
-
-	/* Pipeline configuration */
-	p = rte_pipeline_create(&pipeline_params);
-	if (p == NULL)
-		rte_panic("Unable to configure the pipeline\n");
-
-	/* Input port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_reader_params port_ring_params = {
-			.ring = app.rings_rx[i],
-		};
-
-		struct rte_pipeline_port_in_params port_params = {
-			.ops = &rte_port_ring_reader_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-			.burst_size = app.burst_size_worker_read,
-		};
-
-		if (rte_pipeline_port_in_create(p, &port_params,
-			&port_in_id[i]))
-			rte_panic("Unable to configure input port for "
-				"ring %d\n", i);
-	}
-
-	/* Output port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_writer_params port_ring_params = {
-			.ring = app.rings_tx[i],
-			.tx_burst_sz = app.burst_size_worker_write,
-		};
-
-		struct rte_pipeline_port_out_params port_params = {
-			.ops = &rte_port_ring_writer_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-		};
-
-		if (rte_pipeline_port_out_create(p, &port_params,
-			&port_out_id[i]))
-			rte_panic("Unable to configure output port for "
-				"ring %d\n", i);
-	}
-
-	struct rte_table_hash_params table_hash_params = {
-		.name = "TABLE",
-		.key_size = key_size,
-		.key_offset = APP_METADATA_OFFSET(32),
-		.key_mask = NULL,
-		.n_keys = 1 << 24,
-		.n_buckets = 1 << 22,
-		.f_hash = test_hash,
-		.seed = 0,
-	};
-
-	struct rte_table_hash_cuckoo_params table_hash_cuckoo_params = {
-		.name = "TABLE",
-		.key_size = key_size,
-		.key_offset = APP_METADATA_OFFSET(32),
-		.key_mask = NULL,
-		.n_keys = 1 << 24,
-		.n_buckets = 1 << 22,
-		.f_hash = test_hash_cuckoo,
-		.seed = 0,
-	};
-
-	/* Table configuration */
-	switch (app.pipeline_type) {
-	case e_APP_PIPELINE_HASH_KEY8_EXT:
-	case e_APP_PIPELINE_HASH_KEY16_EXT:
-	case e_APP_PIPELINE_HASH_KEY32_EXT:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_ext_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_KEY8_LRU:
-	case e_APP_PIPELINE_HASH_KEY16_LRU:
-	case e_APP_PIPELINE_HASH_KEY32_LRU:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_lru_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY8_EXT:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key8_ext_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY8_LRU:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key8_lru_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY16_EXT:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key16_ext_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table)\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY16_LRU:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key16_lru_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY32_EXT:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key32_ext_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-
-	case e_APP_PIPELINE_HASH_SPEC_KEY32_LRU:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_key32_lru_ops,
-			.arg_create = &table_hash_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY8:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY16:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY32:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY48:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY64:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY80:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY96:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY112:
-	case e_APP_PIPELINE_HASH_CUCKOO_KEY128:
-	{
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_hash_cuckoo_ops,
-			.arg_create = &table_hash_cuckoo_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the hash table\n");
-	}
-	break;
-
-	default:
-		rte_panic("Invalid hash table type or key size\n");
-	}
-
-	/* Interconnecting ports and tables */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id))
-			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id);
-
-	/* Add entries to tables */
-	for (i = 0; i < (1 << 24); i++) {
-		struct rte_pipeline_table_entry entry = {
-			.action = RTE_PIPELINE_ACTION_PORT,
-			{.port_id = port_out_id[i & (app.n_ports - 1)]},
-		};
-		struct rte_pipeline_table_entry *entry_ptr;
-		uint8_t key[32];
-		uint32_t *k32 = (uint32_t *) key;
-		int key_found, status;
-
-		memset(key, 0, sizeof(key));
-		k32[0] = rte_be_to_cpu_32(i);
-
-		status = rte_pipeline_table_entry_add(p, table_id, key, &entry,
-			&key_found, &entry_ptr);
-		if (status < 0)
-			rte_panic("Unable to add entry to table %u (%d)\n",
-				table_id, status);
-	}
-
-	/* Enable input ports */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_enable(p, port_in_id[i]))
-			rte_panic("Unable to enable input port %u\n",
-				port_in_id[i]);
-
-	/* Check pipeline consistency */
-	if (rte_pipeline_check(p) < 0)
-		rte_panic("Pipeline consistency check failed\n");
-
-	/* Run-time */
-#if APP_FLUSH == 0
-	while (!force_quit)
-		rte_pipeline_run(p);
-#else
-	i = 0;
-	while (!force_quit) {
-		rte_pipeline_run(p);
-
-		if ((i & APP_FLUSH) == 0)
-			rte_pipeline_flush(p);
-		i++;
-	}
-#endif
-}
-
-uint64_t test_hash(
-	void *key,
-	__rte_unused void *key_mask,
-	__rte_unused uint32_t key_size,
-	__rte_unused uint64_t seed)
-{
-	uint32_t *k32 = key;
-	uint32_t ip_dst = rte_be_to_cpu_32(k32[0]);
-	uint64_t signature = (ip_dst >> 2) | ((ip_dst & 0x3) << 30);
-
-	return signature;
-}
-
-uint32_t test_hash_cuckoo(
-	const void *key,
-	__rte_unused uint32_t key_size,
-	__rte_unused uint32_t seed)
-{
-	const uint32_t *k32 = key;
-	uint32_t ip_dst = rte_be_to_cpu_32(k32[0]);
-	uint32_t signature = (ip_dst >> 2) | ((ip_dst & 0x3) << 30);
-
-	return signature;
-}
-
-void
-app_main_loop_rx_metadata(void) {
-	uint32_t i, j;
-	int ret;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing RX (with meta-data)\n",
-		rte_lcore_id());
-
-	while (!force_quit) {
-		for (i = 0; i < app.n_ports; i++) {
-			uint16_t n_mbufs;
-
-			n_mbufs = rte_eth_rx_burst(
-				app.ports[i],
-				0,
-				app.mbuf_rx.array,
-				app.burst_size_rx_read);
-
-			if (n_mbufs == 0)
-				continue;
-
-			for (j = 0; j < n_mbufs; j++) {
-				struct rte_mbuf *m;
-				uint8_t *m_data, *key;
-				struct rte_ipv4_hdr *ip_hdr;
-				struct rte_ipv6_hdr *ipv6_hdr;
-				uint32_t ip_dst;
-				uint32_t *signature, *k32;
-
-				m = app.mbuf_rx.array[j];
-				m_data = rte_pktmbuf_mtod(m, uint8_t *);
-				signature = RTE_MBUF_METADATA_UINT32_PTR(m,
-						APP_METADATA_OFFSET(0));
-				key = RTE_MBUF_METADATA_UINT8_PTR(m,
-						APP_METADATA_OFFSET(32));
-
-				if (RTE_ETH_IS_IPV4_HDR(m->packet_type)) {
-					ip_hdr = (struct rte_ipv4_hdr *)
-						&m_data[sizeof(struct rte_ether_hdr)];
-					ip_dst = ip_hdr->dst_addr;
-
-					k32 = (uint32_t *) key;
-					k32[0] = ip_dst & 0xFFFFFF00;
-				} else if (RTE_ETH_IS_IPV6_HDR(m->packet_type)) {
-					ipv6_hdr = (struct rte_ipv6_hdr *)
-						&m_data[sizeof(struct rte_ether_hdr)];
-
-					memcpy(key, &ipv6_hdr->dst_addr, 16);
-				} else
-					continue;
-
-				*signature = test_hash(key, NULL, 0, 0);
-			}
-
-			do {
-				ret = rte_ring_sp_enqueue_bulk(
-					app.rings_rx[i],
-					(void **) app.mbuf_rx.array,
-					n_mbufs,
-					NULL);
-			} while (ret == 0 && !force_quit);
-		}
-	}
-}
diff --git a/app/test-pipeline/pipeline_lpm.c b/app/test-pipeline/pipeline_lpm.c
deleted file mode 100644
index 8a59bd0042..0000000000
--- a/app/test-pipeline/pipeline_lpm.c
+++ /dev/null
@@ -1,175 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-#include <rte_log.h>
-#include <rte_ethdev.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
-#include <rte_byteorder.h>
-
-#include <rte_port_ring.h>
-#include <rte_table_lpm.h>
-#include <rte_pipeline.h>
-
-#include "main.h"
-
-#ifndef PIPELINE_LPM_TABLE_NUMBER_TABLE8s
-#define PIPELINE_LPM_TABLE_NUMBER_TABLE8s 256
-#endif
-
-void
-app_main_loop_worker_pipeline_lpm(void) {
-	struct rte_pipeline_params pipeline_params = {
-		.name = "pipeline",
-		.socket_id = rte_socket_id(),
-	};
-
-	struct rte_pipeline *p;
-	uint32_t port_in_id[APP_MAX_PORTS];
-	uint32_t port_out_id[APP_MAX_PORTS];
-	uint32_t table_id;
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing work (pipeline with "
-		"LPM table)\n", rte_lcore_id());
-
-	/* Pipeline configuration */
-	p = rte_pipeline_create(&pipeline_params);
-	if (p == NULL)
-		rte_panic("Unable to configure the pipeline\n");
-
-	/* Input port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_reader_params port_ring_params = {
-			.ring = app.rings_rx[i],
-		};
-
-		struct rte_pipeline_port_in_params port_params = {
-			.ops = &rte_port_ring_reader_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-			.burst_size = app.burst_size_worker_read,
-		};
-
-		if (rte_pipeline_port_in_create(p, &port_params,
-			&port_in_id[i]))
-			rte_panic("Unable to configure input port for "
-				"ring %d\n", i);
-	}
-
-	/* Output port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_writer_params port_ring_params = {
-			.ring = app.rings_tx[i],
-			.tx_burst_sz = app.burst_size_worker_write,
-		};
-
-		struct rte_pipeline_port_out_params port_params = {
-			.ops = &rte_port_ring_writer_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-		};
-
-		if (rte_pipeline_port_out_create(p, &port_params,
-			&port_out_id[i]))
-			rte_panic("Unable to configure output port for "
-				"ring %d\n", i);
-	}
-
-	/* Table configuration */
-	{
-		struct rte_table_lpm_params table_lpm_params = {
-			.name = "LPM",
-			.n_rules = 1 << 24,
-			.number_tbl8s = PIPELINE_LPM_TABLE_NUMBER_TABLE8s,
-			.flags = 0,
-			.entry_unique_size =
-				sizeof(struct rte_pipeline_table_entry),
-			.offset = APP_METADATA_OFFSET(32),
-		};
-
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_lpm_ops,
-			.arg_create = &table_lpm_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the LPM table\n");
-	}
-
-	/* Interconnecting ports and tables */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id))
-			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id);
-
-	/* Add entries to tables */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_pipeline_table_entry entry = {
-			.action = RTE_PIPELINE_ACTION_PORT,
-			{.port_id = port_out_id[i & (app.n_ports - 1)]},
-		};
-
-		struct rte_table_lpm_key key = {
-			.ip = i << (24 - rte_popcount32(app.n_ports - 1)),
-			.depth = 8 + rte_popcount32(app.n_ports - 1),
-		};
-
-		struct rte_pipeline_table_entry *entry_ptr;
-
-		int key_found, status;
-
-		printf("Adding rule to LPM table (IPv4 destination = %"
-			PRIu32 ".%" PRIu32 ".%" PRIu32 ".%" PRIu32 "/%" PRIu8
-			" => port out = %" PRIu32 ")\n",
-			(key.ip & 0xFF000000) >> 24,
-			(key.ip & 0x00FF0000) >> 16,
-			(key.ip & 0x0000FF00) >> 8,
-			key.ip & 0x000000FF,
-			key.depth,
-			i);
-
-		status = rte_pipeline_table_entry_add(p, table_id, &key, &entry,
-			&key_found, &entry_ptr);
-		if (status < 0)
-			rte_panic("Unable to add entry to table %u (%d)\n",
-				table_id, status);
-	}
-
-	/* Enable input ports */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_enable(p, port_in_id[i]))
-			rte_panic("Unable to enable input port %u\n",
-				port_in_id[i]);
-
-	/* Check pipeline consistency */
-	if (rte_pipeline_check(p) < 0)
-		rte_panic("Pipeline consistency check failed\n");
-
-	/* Run-time */
-#if APP_FLUSH == 0
-	while (!force_quit)
-		rte_pipeline_run(p);
-#else
-	i = 0;
-	while (!force_quit) {
-		rte_pipeline_run(p);
-
-		if ((i & APP_FLUSH) == 0)
-			rte_pipeline_flush(p);
-		i++;
-	}
-#endif
-}
diff --git a/app/test-pipeline/pipeline_lpm_ipv6.c b/app/test-pipeline/pipeline_lpm_ipv6.c
deleted file mode 100644
index 6558e887c8..0000000000
--- a/app/test-pipeline/pipeline_lpm_ipv6.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-#include <rte_log.h>
-#include <rte_ethdev.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
-#include <rte_byteorder.h>
-
-#include <rte_port_ring.h>
-#include <rte_table_lpm_ipv6.h>
-#include <rte_pipeline.h>
-
-#include "main.h"
-
-void
-app_main_loop_worker_pipeline_lpm_ipv6(void) {
-	struct rte_pipeline_params pipeline_params = {
-		.name = "pipeline",
-		.socket_id = rte_socket_id(),
-	};
-
-	struct rte_pipeline *p;
-	uint32_t port_in_id[APP_MAX_PORTS];
-	uint32_t port_out_id[APP_MAX_PORTS];
-	uint32_t table_id;
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1,
-		"Core %u is doing work (pipeline with IPv6 LPM table)\n",
-		rte_lcore_id());
-
-	/* Pipeline configuration */
-	p = rte_pipeline_create(&pipeline_params);
-	if (p == NULL)
-		rte_panic("Unable to configure the pipeline\n");
-
-	/* Input port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_reader_params port_ring_params = {
-			.ring = app.rings_rx[i],
-		};
-
-		struct rte_pipeline_port_in_params port_params = {
-			.ops = &rte_port_ring_reader_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-			.burst_size = app.burst_size_worker_read,
-		};
-
-		if (rte_pipeline_port_in_create(p, &port_params,
-			&port_in_id[i]))
-			rte_panic("Unable to configure input port for "
-				"ring %d\n", i);
-	}
-
-	/* Output port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_writer_params port_ring_params = {
-			.ring = app.rings_tx[i],
-			.tx_burst_sz = app.burst_size_worker_write,
-		};
-
-		struct rte_pipeline_port_out_params port_params = {
-			.ops = &rte_port_ring_writer_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-		};
-
-		if (rte_pipeline_port_out_create(p, &port_params,
-			&port_out_id[i]))
-			rte_panic("Unable to configure output port for "
-				"ring %d\n", i);
-	}
-
-	/* Table configuration */
-	{
-		struct rte_table_lpm_ipv6_params table_lpm_ipv6_params = {
-			.name = "LPM",
-			.n_rules = 1 << 24,
-			.number_tbl8s = 1 << 21,
-			.entry_unique_size =
-				sizeof(struct rte_pipeline_table_entry),
-			.offset = APP_METADATA_OFFSET(32),
-		};
-
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_lpm_ipv6_ops,
-			.arg_create = &table_lpm_ipv6_params,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id))
-			rte_panic("Unable to configure the IPv6 LPM table\n");
-	}
-
-	/* Interconnecting ports and tables */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-			table_id))
-			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id);
-
-	/* Add entries to tables */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_pipeline_table_entry entry = {
-			.action = RTE_PIPELINE_ACTION_PORT,
-			{.port_id = port_out_id[i & (app.n_ports - 1)]},
-		};
-
-		struct rte_table_lpm_ipv6_key key;
-		struct rte_pipeline_table_entry *entry_ptr;
-		uint32_t ip;
-		int key_found, status;
-
-		key.depth = 8 + rte_popcount32(app.n_ports - 1);
-
-		ip = rte_bswap32(i << (24 -
-			rte_popcount32(app.n_ports - 1)));
-		memcpy(&key.ip, &ip, sizeof(uint32_t));
-
-		printf("Adding rule to IPv6 LPM table (IPv6 destination = "
-			RTE_IPV6_ADDR_FMT "/%u => port out = %u)\n",
-			RTE_IPV6_ADDR_SPLIT(&key.ip),
-			key.depth, i);
-
-		status = rte_pipeline_table_entry_add(p, table_id, &key, &entry,
-			&key_found, &entry_ptr);
-		if (status < 0)
-			rte_panic("Unable to add entry to table %u (%d)\n",
-				table_id, status);
-	}
-
-	/* Enable input ports */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_enable(p, port_in_id[i]))
-			rte_panic("Unable to enable input port %u\n",
-				port_in_id[i]);
-
-	/* Check pipeline consistency */
-	if (rte_pipeline_check(p) < 0)
-		rte_panic("Pipeline consistency check failed\n");
-
-	/* Run-time */
-#if APP_FLUSH == 0
-	while (!force_quit)
-		rte_pipeline_run(p);
-#else
-	i = 0;
-	while (!force_quit) {
-		rte_pipeline_run(p);
-
-		if ((i & APP_FLUSH) == 0)
-			rte_pipeline_flush(p);
-		i++;
-	}
-#endif
-}
diff --git a/app/test-pipeline/pipeline_stub.c b/app/test-pipeline/pipeline_stub.c
deleted file mode 100644
index 48a638aad7..0000000000
--- a/app/test-pipeline/pipeline_stub.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2016 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-#include <rte_log.h>
-#include <rte_port_ring.h>
-#include <rte_table_stub.h>
-#include <rte_pipeline.h>
-
-#include "main.h"
-
-void
-app_main_loop_worker_pipeline_stub(void) {
-	struct rte_pipeline_params pipeline_params = {
-		.name = "pipeline",
-		.socket_id = rte_socket_id(),
-	};
-
-	struct rte_pipeline *p;
-	uint32_t port_in_id[APP_MAX_PORTS];
-	uint32_t port_out_id[APP_MAX_PORTS];
-	uint32_t table_id[APP_MAX_PORTS];
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing work (pipeline with stub "
-		"tables)\n", rte_lcore_id());
-
-	/* Pipeline configuration */
-	p = rte_pipeline_create(&pipeline_params);
-	if (p == NULL)
-		rte_panic("Unable to configure the pipeline\n");
-
-	/* Input port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_reader_params port_ring_params = {
-			.ring = app.rings_rx[i],
-		};
-
-		struct rte_pipeline_port_in_params port_params = {
-			.ops = &rte_port_ring_reader_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-			.burst_size = app.burst_size_worker_read,
-		};
-
-		if (rte_pipeline_port_in_create(p, &port_params,
-			&port_in_id[i]))
-			rte_panic("Unable to configure input port for "
-				"ring %d\n", i);
-	}
-
-	/* Output port configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_port_ring_writer_params port_ring_params = {
-			.ring = app.rings_tx[i],
-			.tx_burst_sz = app.burst_size_worker_write,
-		};
-
-		struct rte_pipeline_port_out_params port_params = {
-			.ops = &rte_port_ring_writer_ops,
-			.arg_create = (void *) &port_ring_params,
-			.f_action = NULL,
-			.arg_ah = NULL,
-		};
-
-		if (rte_pipeline_port_out_create(p, &port_params,
-			&port_out_id[i]))
-			rte_panic("Unable to configure output port for "
-				"ring %d\n", i);
-	}
-
-	/* Table configuration */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_pipeline_table_params table_params = {
-			.ops = &rte_table_stub_ops,
-			.arg_create = NULL,
-			.f_action_hit = NULL,
-			.f_action_miss = NULL,
-			.arg_ah = NULL,
-			.action_data_size = 0,
-		};
-
-		if (rte_pipeline_table_create(p, &table_params, &table_id[i]))
-			rte_panic("Unable to configure table %u\n", i);
-	}
-
-	/* Interconnecting ports and tables */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_connect_to_table(p, port_in_id[i],
-				table_id[i]))
-			rte_panic("Unable to connect input port %u to "
-				"table %u\n", port_in_id[i],  table_id[i]);
-
-	/* Add entries to tables */
-	for (i = 0; i < app.n_ports; i++) {
-		struct rte_pipeline_table_entry entry = {
-			.action = RTE_PIPELINE_ACTION_PORT,
-			{.port_id = port_out_id[i ^ 1]},
-		};
-		struct rte_pipeline_table_entry *default_entry_ptr;
-
-		if (rte_pipeline_table_default_entry_add(p, table_id[i], &entry,
-			&default_entry_ptr))
-			rte_panic("Unable to add default entry to table %u\n",
-				table_id[i]);
-	}
-
-	/* Enable input ports */
-	for (i = 0; i < app.n_ports; i++)
-		if (rte_pipeline_port_in_enable(p, port_in_id[i]))
-			rte_panic("Unable to enable input port %u\n",
-				port_in_id[i]);
-
-	/* Check pipeline consistency */
-	if (rte_pipeline_check(p) < 0)
-		rte_panic("Pipeline consistency check failed\n");
-
-	/* Run-time */
-#if APP_FLUSH == 0
-	while (!force_quit)
-		rte_pipeline_run(p);
-#else
-	i = 0;
-	while (!force_quit) {
-		rte_pipeline_run(p);
-
-		if ((i & APP_FLUSH) == 0)
-			rte_pipeline_flush(p);
-		i++;
-	}
-#endif
-}
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
deleted file mode 100644
index 752f783370..0000000000
--- a/app/test-pipeline/runtime.c
+++ /dev/null
@@ -1,160 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <inttypes.h>
-#include <sys/types.h>
-#include <string.h>
-#include <sys/queue.h>
-#include <stdarg.h>
-#include <errno.h>
-#include <getopt.h>
-
-#include <rte_common.h>
-#include <rte_byteorder.h>
-#include <rte_log.h>
-#include <rte_memory.h>
-#include <rte_memcpy.h>
-#include <rte_eal.h>
-#include <rte_per_lcore.h>
-#include <rte_launch.h>
-#include <rte_cycles.h>
-#include <rte_prefetch.h>
-#include <rte_branch_prediction.h>
-#include <rte_interrupts.h>
-#include <rte_pci.h>
-#include <rte_random.h>
-#include <rte_debug.h>
-#include <rte_ether.h>
-#include <rte_ethdev.h>
-#include <rte_ring.h>
-#include <rte_mempool.h>
-#include <rte_mbuf.h>
-#include <rte_ip.h>
-#include <rte_tcp.h>
-#include <rte_lpm.h>
-#include <rte_lpm6.h>
-#include <rte_malloc.h>
-
-#include "main.h"
-
-void
-app_main_loop_rx(void) {
-	uint32_t i;
-	int ret;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing RX\n", rte_lcore_id());
-
-	while (!force_quit) {
-		for (i = 0; i < app.n_ports; i++) {
-			uint16_t n_mbufs;
-
-			n_mbufs = rte_eth_rx_burst(
-				app.ports[i],
-				0,
-				app.mbuf_rx.array,
-				app.burst_size_rx_read);
-
-			if (n_mbufs == 0)
-				continue;
-
-			do {
-				ret = rte_ring_sp_enqueue_bulk(
-					app.rings_rx[i],
-					(void **) app.mbuf_rx.array,
-					n_mbufs, NULL);
-			} while (ret == 0 && !force_quit);
-		}
-	}
-}
-
-void
-app_main_loop_worker(void) {
-	struct app_mbuf_array *worker_mbuf;
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing work (no pipeline)\n",
-		rte_lcore_id());
-
-	worker_mbuf = rte_malloc_socket(NULL, sizeof(struct app_mbuf_array),
-			RTE_CACHE_LINE_SIZE, rte_socket_id());
-	if (worker_mbuf == NULL)
-		rte_panic("Worker thread: cannot allocate buffer space\n");
-
-	while (!force_quit) {
-		for (i = 0; i < app.n_ports; i++) {
-			int ret;
-
-			ret = rte_ring_sc_dequeue_bulk(
-				app.rings_rx[i],
-				(void **) worker_mbuf->array,
-				app.burst_size_worker_read,
-				NULL);
-
-			if (ret == 0)
-				continue;
-
-			do {
-				ret = rte_ring_sp_enqueue_bulk(
-					app.rings_tx[i ^ 1],
-					(void **) worker_mbuf->array,
-					app.burst_size_worker_write,
-					NULL);
-			} while (ret == 0 && !force_quit);
-		}
-	}
-}
-
-void
-app_main_loop_tx(void) {
-	uint32_t i;
-
-	RTE_LOG(INFO, USER1, "Core %u is doing TX\n", rte_lcore_id());
-
-	while (!force_quit) {
-		for (i = 0; i < app.n_ports; i++) {
-			uint16_t n_mbufs, n_pkts;
-			int ret;
-
-			n_mbufs = app.mbuf_tx[i].n_mbufs;
-
-			ret = rte_ring_sc_dequeue_bulk(
-				app.rings_tx[i],
-				(void **) &app.mbuf_tx[i].array[n_mbufs],
-				app.burst_size_tx_read,
-				NULL);
-
-			if (ret == 0)
-				continue;
-
-			n_mbufs += app.burst_size_tx_read;
-
-			if (n_mbufs < app.burst_size_tx_write) {
-				app.mbuf_tx[i].n_mbufs = n_mbufs;
-				continue;
-			}
-
-			n_pkts = rte_eth_tx_burst(
-				app.ports[i],
-				0,
-				app.mbuf_tx[i].array,
-				n_mbufs);
-
-			if (n_pkts < n_mbufs) {
-				uint16_t k;
-
-				for (k = n_pkts; k < n_mbufs; k++) {
-					struct rte_mbuf *pkt_to_free;
-
-					pkt_to_free = app.mbuf_tx[i].array[k];
-					rte_pktmbuf_free(pkt_to_free);
-				}
-			}
-
-			app.mbuf_tx[i].n_mbufs = 0;
-		}
-	}
-}
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..10e4352cac 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,9 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* Removed the ``dpdk-test-pipeline`` application, which was based on
+  the legacy pipeline library API.
+
 
 API Changes
 -----------
diff --git a/doc/guides/sample_app_ug/img/test_pipeline_app.png b/doc/guides/sample_app_ug/img/test_pipeline_app.png
deleted file mode 100644
index d322a9e46e5e714126988a76456c9eae41635879..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 67410
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%0D%V3H
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

diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index f12623bb66..c8b50b801c 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -45,7 +45,6 @@ Sample Applications User Guides
     vhost_crypto
     vdpa
     ip_pipeline
-    test_pipeline
     pipeline
     eventdev_pipeline
     dist_app
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
deleted file mode 100644
index e53d77a170..0000000000
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ /dev/null
@@ -1,237 +0,0 @@
-..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2010-2014 Intel Corporation.
-
-Test Pipeline Application
-=========================
-
-The Test Pipeline application illustrates the use of the DPDK Packet Framework tool suite.
-Its purpose is to demonstrate the performance of single-table DPDK pipelines.
-
-Overview
---------
-
-The application uses three CPU cores:
-
-*   Core A ("RX core") receives traffic from the NIC ports and feeds core B with traffic through SW queues.
-
-*   Core B ("Pipeline core") implements a single-table DPDK pipeline
-    whose type is selectable through specific command line parameter.
-    Core B receives traffic from core A through software queues,
-    processes it according to the actions configured in the table entries that
-    are hit by the input packets and feeds it to core C through another set of software queues.
-
-*   Core C ("TX core") receives traffic from core B through software queues and sends it to the NIC ports for transmission.
-
-.. figure:: img/test_pipeline_app.*
-
-   Test Pipeline Application
-
-Compiling the Application
--------------------------
-To compile the sample application see :doc:`compiling`
-
-The application is located in the ``dpdk/<build_dir>/app`` directory.
-
-
-Running the Application
------------------------
-
-Application Command Line
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-The application execution command line is:
-
-.. code-block:: console
-
-    ./dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE
-
-The ``-l/--lcores`` EAL CPU corelist option has to contain exactly 3 CPU cores.
-The first CPU core in the core mask is assigned for core A, the second for core B and the third for core C.
-
-The PORTMASK parameter must contain 2 or 4 ports.
-
-Table Types and Behavior
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-:numref:`test_pipeline_table_1` describes the table types used and how they are populated.
-
-The hash tables are pre-populated with 16 million keys.
-For hash tables, the following parameters can be selected:
-
-*   **Configurable key size implementation or fixed (specialized) key size implementation (e.g. hash-8-ext or hash-spec-8-ext).**
-    The key size specialized implementations are expected to provide better performance for 8-byte and 16-byte key sizes,
-    while the key-size-non-specialized implementation is expected to provide better performance for larger key sizes;
-
-*   **Key size (e.g. hash-spec-8-ext or hash-spec-16-ext).**
-    The available options are 8, 16 and 32 bytes;
-
-*   **Table type (e.g. hash-spec-16-ext or hash-spec-16-lru).**
-    The available options are ext (extendable bucket) or lru (least recently used).
-
-.. _test_pipeline_table_1:
-
-.. table:: Table Types
-
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | **#** | **TABLE_TYPE**         | **Description of Core B Table**                          | **Pre-added Table Entries**                           |
-   |       |                        |                                                          |                                                       |
-   +=======+========================+==========================================================+=======================================================+
-   | 1     | none                   | Core B is not implementing a DPDK pipeline.              | N/A                                                   |
-   |       |                        | Core B is implementing a pass-through from its input set |                                                       |
-   |       |                        | of software queues to its output set of software queues. |                                                       |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 2     | stub                   | Stub table. Core B is implementing the same pass-through | N/A                                                   |
-   |       |                        | functionality as described for the "none" option by      |                                                       |
-   |       |                        | using the DPDK Packet Framework by using one             |                                                       |
-   |       |                        | stub table for each input NIC port.                      |                                                       |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 3     | hash-[spec]-8-lru      | LRU hash table with 8-byte key size and 16 million       | 16 million entries are successfully added to the      |
-   |       |                        | entries.                                                 | hash table with the following key format:             |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [4-byte index, 4 bytes of 0]                          |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Sendto output port", with the output port index      |
-   |       |                        |                                                          | uniformly distributed for the range of output ports.  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | At run time, core A is creating the following lookup  |
-   |       |                        |                                                          | key and storing it into the packet meta data for      |
-   |       |                        |                                                          | core B to use for table lookup:                       |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [destination IPv4 address, 4 bytes of 0]              |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 4     | hash-[spec]-8-ext      | Extendable bucket hash table with 8-byte key size        | Same as hash-[spec]-8-lru table entries, above.       |
-   |       |                        | and 16 million entries.                                  |                                                       |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 5     | hash-[spec]-16-lru     | LRU hash table with 16-byte key size and 16 million      | 16 million entries are successfully added to the hash |
-   |       |                        | entries.                                                 | table with the following key format:                  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [4-byte index, 12 bytes of 0]                         |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Send to output port", with the output port index     |
-   |       |                        |                                                          | uniformly distributed for the range of output ports.  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | At run time, core A is creating the following lookup  |
-   |       |                        |                                                          | key and storing it into the packet meta data for core |
-   |       |                        |                                                          | B to use for table lookup:                            |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [destination IPv4 address, 12 bytes of 0]             |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 6     | hash-[spec]-16-ext     | Extendable bucket hash table with 16-byte key size       | Same as hash-[spec]-16-lru table entries, above.      |
-   |       |                        | and 16 million entries.                                  |                                                       |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 7     | hash-[spec]-32-lru     | LRU hash table with 32-byte key size and 16 million      | 16 million entries are successfully added to the hash |
-   |       |                        | entries.                                                 | table with the following key format:                  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [4-byte index, 28 bytes of 0].                        |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The action configured for all table entries is        |
-   |       |                        |                                                          | "Send to output port", with the output port index     |
-   |       |                        |                                                          | uniformly distributed for the range of output ports.  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | At run time, core A is creating the following lookup  |
-   |       |                        |                                                          | key and storing it into the packet meta data for      |
-   |       |                        |                                                          | Lpmcore B to use for table lookup:                    |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [destination IPv4 address, 28 bytes of 0]             |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 8     | hash-[spec]-32-ext     | Extendable bucket hash table with 32-byte key size       | Same as hash-[spec]-32-lru table entries, above.      |
-   |       |                        | and 16 million entries.                                  |                                                       |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 9     | lpm                    | Longest Prefix Match (LPM) IPv4 table.                   | In the case of two ports, two routes                  |
-   |       |                        |                                                          | are added to the table:                               |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.0.0.0/9 => send to output port 0]                  |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.128.0.0/9 => send to output port 1]                |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | In case of four ports, four entries are added to the  |
-   |       |                        |                                                          | table:                                                |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.0.0.0/10 => send to output port 0]                 |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.64.0.0/10 => send to output port 1]                |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.128.0.0/10 => send to output port 2]               |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [0.192.0.0/10 => send to output port 3]               |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | At run time, core A is storing the IPv4 destination   |
-   |       |                        |                                                          | within the packet meta data to be later used by core  |
-   |       |                        |                                                          | B as the lookup key.                                  |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-   | 10    | acl                    | Access Control List (ACL) table                          | In the case of two ports, two ACL rules are added to  |
-   |       |                        |                                                          | the table:                                            |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [priority = 0 (highest),                              |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | IPv4 source = ANY,                                    |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | IPv4 destination = 0.0.0.0/9,                         |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | L4 protocol = ANY,                                    |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | TCP source port = ANY,                                |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | TCP destination port = ANY                            |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | => send to output port 0]                             |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | [priority = 0 (highest),                              |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | IPv4 source = ANY,                                    |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | IPv4 destination = 0.128.0.0/9,                       |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | L4 protocol = ANY,                                    |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | TCP source port = ANY,                                |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | TCP destination port = ANY                            |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | => send to output port 0].                            |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          |                                                       |
-   |       |                        |                                                          | The default table rule (used in the case of a lookup  |
-   |       |                        |                                                          | miss) is to drop the packet.                          |
-   |       |                        |                                                          |                                                       |
-   +-------+------------------------+----------------------------------------------------------+-------------------------------------------------------+
-
-Input Traffic
-~~~~~~~~~~~~~
-
-Regardless of the table type used for the core B pipeline,
-the same input traffic can be used to hit all table entries with uniform distribution,
-which results in uniform distribution of packets sent out on the set of output NIC ports.
-The profile for input traffic is TCP/IPv4 packets with:
-
-*   destination IP address as A.B.C.D with A fixed to 0 and B, C,D random
-
-*   source IP address fixed to 0.0.0.0
-
-*   destination TCP port fixed to 0
-
-*   source TCP port fixed to 0
-- 
2.53.0

