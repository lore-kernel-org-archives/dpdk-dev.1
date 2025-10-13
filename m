Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19100CCD187
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 03:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 394444064C;
	Mon, 13 Oct 2025 05:03:25 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 698084021E
 for <dev@dpdk.org>; Mon, 13 Oct 2025 05:02:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=k0aLs+3ly61lpfrqx6G2HgJUxAL/S9dgSGQQYitVTkc=;
 b=uBwpW3+yRQyLUFonGmuFY/FHh5AYNAaAt4APLPaYYFb1VP9yV5SX+4DUImR24GCwO8ARmX9Jm
 jH5Ds+VaQnn4E98T4wv8giYinEWMt0o53zjkltw9ufNU13O0ryL8gXm02+5AHcp3bYw8GG3/M+z
 PaKeZDicoiorSxD7lWUXFeM=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4clMb809fRzLlVC;
 Mon, 13 Oct 2025 11:02:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E68D1180044;
 Mon, 13 Oct 2025 11:02:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 11:02:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v3 05/13] app/dma-perf: support list DMA devices
Date: Mon, 13 Oct 2025 11:02:28 +0800
Message-ID: <20251013030236.3861-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251013030236.3861-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251013030236.3861-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Because the names of dmadevs are different, this commit support list
DMA devices, so that user could quickly know how to set the lcore_dma
parameters.

The command: dpdk-test-dma-perf --config ./config.ini --list-dma
The output like:
	DMA device: 0000:7b:00.0-ch0
	    transfer-capa: mem2mem
	    max-segs: 0 numa-node: 0 min-desc: 32 max-desc: 8192

	DMA device: 0000:7b:00.0-ch1
	    transfer-capa: mem2mem
	    max-segs: 0 numa-node: 0 min-desc: 32 max-desc: 8192

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/main.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 1d0850e7a6..eb51bc7afa 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -43,6 +43,7 @@ static struct global_configure global_cfg;
 
 static char *config_path;
 static char *result_path;
+static bool  list_dma;
 
 __rte_format_printf(1, 2)
 void
@@ -529,6 +530,10 @@ parse_args(int argc, char **argv)
 			  (void *)&result_path, NULL,
 			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR,
 			},
+			{ "--list-dma", NULL, "Optional, list dma devices and exit",
+			  (void *)&list_dma, (void *)true,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
+			},
 			ARGPARSE_ARG_END(),
 		},
 	};
@@ -569,6 +574,52 @@ parse_args(int argc, char **argv)
 	return 0;
 }
 
+static void
+list_dma_dev(void)
+{
+	static const struct {
+		uint64_t capability;
+		const char *name;
+	} capa_names[] = {
+		{ RTE_DMA_CAPA_MEM_TO_MEM,  "mem2mem" },
+		{ RTE_DMA_CAPA_MEM_TO_DEV,  "mem2dev" },
+		{ RTE_DMA_CAPA_DEV_TO_MEM,  "dev2mem" },
+		{ RTE_DMA_CAPA_DEV_TO_DEV,  "dev2dev" },
+	};
+	struct rte_dma_info info;
+	uint32_t count = 0;
+	int idx = 0;
+	uint32_t i;
+	int ret;
+
+	ret = rte_eal_init(global_cfg.eal_argc, global_cfg.eal_argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Invalid EAL arguments\n");
+
+	RTE_DMA_FOREACH_DEV(idx) {
+		ret = rte_dma_info_get(idx, &info);
+		if (ret != 0)
+			continue;
+
+		printf("\nDMA device name: %s\n", info.dev_name);
+		printf("    transfer-capa:");
+		for (i = 0; i < RTE_DIM(capa_names); i++) {
+			if (capa_names[i].capability & info.dev_capa)
+				printf(" %s", capa_names[i].name);
+		}
+		printf("\n");
+		printf("    max-segs: %u numa-node: %d min-desc: %u max-desc: %u\n",
+			info.max_sges, info.numa_node, info.min_desc, info.max_desc);
+		count++;
+	}
+
+	printf("\n");
+	if (count == 0)
+		printf("There are no dmadev devices!\n\n");
+
+	rte_eal_cleanup();
+}
+
 int
 main(int argc, char *argv[])
 {
@@ -582,6 +633,11 @@ main(int argc, char *argv[])
 
 	case_nb = load_configs(config_path);
 
+	if (list_dma) {
+		list_dma_dev();
+		return 0;
+	}
+
 	printf("Running cases...\n");
 	for (i = 0; i < case_nb; i++) {
 		if (test_cases[i].is_skip) {
-- 
2.17.1

