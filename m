Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB7CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 03:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2798540288;
	Wed, 17 Sep 2025 05:34:06 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id AF20D4027A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:34:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cRPVT0drKzQwNs;
 Wed, 17 Sep 2025 11:33:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 14AA518048B;
 Wed, 17 Sep 2025 11:33:59 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 11:33:58 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v2 05/10] app/dma-perf: support list DMA devices
Date: Wed, 17 Sep 2025 11:33:51 +0800
Message-ID: <20250917033356.13358-6-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250917033356.13358-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20250917033356.13358-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
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
	    max-segs: 0 numa-node: 0

	DMA device: 0000:7b:00.0-ch1
	    transfer-capa: mem2mem
	    max-segs: 0 numa-node: 0

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/main.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 1d0850e7a6..601e2a73a0 100644
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
@@ -569,6 +574,51 @@ parse_args(int argc, char **argv)
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
+		printf("    max-segs: %u numa-node: %d\n", info.max_sges, info.numa_node);
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
@@ -582,6 +632,11 @@ main(int argc, char *argv[])
 
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

