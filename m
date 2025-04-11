Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59568C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 08:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6818E40B8C;
	Fri, 11 Apr 2025 10:10:40 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE6840B91
 for <dev@dpdk.org>; Fri, 11 Apr 2025 10:10:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuVpkcwPIaeEHmOBwSXJsMrnaDtJs64WES38zoea6K8G3S1hFlueIpp9dt96NDM05OpEeqMOVctMEsrYe2MlqjK+MQsT1F5pjlb5MXkGRR25MpEXoioJrSFe8dUrPrdtBwPX0z2hSKauxQmHyfmr5Kf22nw+kqzG0aPKLb+1JcR/BJAv1TWIZ88vGGsgsh6q1H43oEc7xpB7ioy50sitxFs66//nSAcYuPpUwbYb7ZuUkxboTNWQ+dxqN6Zn5lA+u4DKBXNSda+IT3GBbGu0c3mFVDXA3tmaCekzaDzG5zzEl6y0iBAcS2SzLLd2MdSX26wvRvFUkKQtBe72SbHm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q32/BBx0sUZHhWZPDxLqdOCEDe9ZYgqweJSCUCSy5uY=;
 b=i3Madw8orTiS4In5Q2kCxVuS5WVs2A1XvvTSPQTl1ReoYNfTZeXyaQex2OGrZvBe1m0z+PaNSiCoPFnd1ly57s6NBz3DboQSqzPGJflX6VZv0oQE168GmDa5WQF72YzTt+fcv9r0Z9+Osj44XBqxl9e26aZkWPhV5L/w+BkgYaXc48eaCGJoHqOR6kDeo7waq/4Y1ccT67fBCeoMG0RRuuWZoieqq8ksYbCgcAhsbspBGmhR0UaCnoypE/JGFkQ1SXWrrj8pqoXz4GhydwcuvmPe57FsJ1HB+XPilsqmx0eM3K2Zal42ldXkT5RDTPpp8WS8EC9LF9yvFD2cwXqzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32/BBx0sUZHhWZPDxLqdOCEDe9ZYgqweJSCUCSy5uY=;
 b=mbbcmP2231Ack6iGaagjHHEx9qA1KrL+In8IjpI8eggYCcVXBJXdMAuYvE461NHLKRraESCIlwPzvW6CVJnVl7YwJoMEz8PVojbH08ZkySAW5bKzGfFxwtn96n2+gnjHHZEfu90bb9ra6tmPX6ggQYLYvgOD0ryMIIrbWilkq9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by DM6PR13MB3940.namprd13.prod.outlook.com (2603:10b6:5:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:10:36 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 08:10:36 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 3/3] app/testpmd: add a command to show VLAN filter IDs
Date: Fri, 11 Apr 2025 16:10:05 +0800
Message-ID: <20250411081005.1133509-4-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250411081005.1133509-1-chaoyong.he@corigine.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|DM6PR13MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fc0ba8-bca2-43f9-6b61-08dd78d0570a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OyuPLtHDvN6+LYz3+S81JJbJUVyEAHXk0Xd3CbK03wz4xPNOITGeaHsn1PQi?=
 =?us-ascii?Q?pLHcKhW1bkDRpzij/Dc0NAF8mkYmbPtfaB4fdmecsdMcGaLNtal3MVF0bWf+?=
 =?us-ascii?Q?lTflH4SfMYjX9v1s+gs4J9WIjXFM3XsAvLxdDTgawiQAOkm2Q9pOeV0T9A0K?=
 =?us-ascii?Q?vZxkPhOTN1+GuBqjIJuZsUey4nUkgwlW7TFjh8rTTuHfQPJU50DGOfxpZKyy?=
 =?us-ascii?Q?jZPRnOlCZ3ewnLioRyMr+8MaP2i73A0DB2Zpb1F6JaD98ScUzy1YGgQYX/jl?=
 =?us-ascii?Q?fbh4gyZ7VWf55k6YlFsPgaKC9YbDB4KL+hF6V5nKucktDhWyNMSXx8JwF81z?=
 =?us-ascii?Q?r0MfMwkAjBsYVQEgnXq+dCAsI7T1CVaKDhKU3s1oAwNuwneZjM3ulbvwphID?=
 =?us-ascii?Q?wog46r4VLbubj9KynNzF+jYu1jYJFxq68Gltc057eWFQ/6vPT7IlI+zggci6?=
 =?us-ascii?Q?HQ46edgyc8lEZ8GA26yh9oHEl/doQvTKDwtNdEn/5AMcGBuWlhplpeeVw7Mu?=
 =?us-ascii?Q?yiW/kBcdKBBL3jXh/vPvrFFRMZ+OUwkkEdYWHUtnpiQVlwmurmZGRgp1XLQY?=
 =?us-ascii?Q?nhVrcHuxH1eU85DFEw7EbljR4dRSkH/jwksYw0Fq5NNjIVxCdz6GAHjL21Ib?=
 =?us-ascii?Q?YMDix+gLVaPj3Krmf3tu8Wq9F7lKwEtKQjVUdwZYkijbv1qMIZvthHTcurTA?=
 =?us-ascii?Q?vvXhH75PyT+24st2ltABWpOi+TVYPb/y+BhyPy5/r4omTSZWM+Z+ZrykwU1+?=
 =?us-ascii?Q?vU7/A6R97S2NP4xP0MacIPK0ZDIHdPK6wJhbK/Trp5a3fVo5YvPycxps34Zf?=
 =?us-ascii?Q?8zHCuqRu7Gy2yn7/QFYlPSU+VHjHULPps1g6vLYqIdQlvo7Syrks+i4TPBNC?=
 =?us-ascii?Q?oXcRXBp7aLhPpm09zwhBHBlBAKXLh03gNOJlghqk8yefFztBB+eNwJd+Qg5F?=
 =?us-ascii?Q?q/NLROzxtMb8DlbZWl4VY8Mj4IXpHD5WCRVejux2W5KvrcBniDPhErKhsqfF?=
 =?us-ascii?Q?Ac5jwyduaqU59KhjKIeQN6QkwcmerPiizhG/IVi9tfncNHeXEjQ62wNP05DK?=
 =?us-ascii?Q?yFmPttEsu5s+MR0hjLZFacOyvPR37oE2hFXZK7HwSiC05o8crdzU4tSCV9wN?=
 =?us-ascii?Q?55V7UhwrQOBwTmGwaQPaW+BIjUsOgVIaEMT5N2WTis4mLYwiF/Wop0a8Vipn?=
 =?us-ascii?Q?dq9oumcrWEpa6BYPZabA8MxCULFnNcARd5OwE9VD3JZGGHU7kLKqG0ETUqrt?=
 =?us-ascii?Q?rSsyuU5jYXgqfvag6cF1x5dQMj/idlKUFvstfp2BZQttLbHPfcwWo2sbF8XJ?=
 =?us-ascii?Q?LT81u4P8iRnlktJB+HpUWa+rIik4ucK5sWN//1IVKCovnx1ohI0JSXvWBjiT?=
 =?us-ascii?Q?1VFpFZrs1s2/0eiQwvsdNK5s8GCweQs/ibnUEYke4WwMAZjwIO9AsqtUABBW?=
 =?us-ascii?Q?Hp8R2Ghf4XCiomVc/ocSzDerlAUoVNDJrJoI0ndCdmP4a9wrsuo6bQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y9RW4fCZ400Zam22htdbzk2vzf6WVvIz3iVTOw9cQaIQiDW8+ZSfvTHZwQlF?=
 =?us-ascii?Q?D8mk09WVSc8RfvFYFSC//l3pRciPVW2yTZK1x35VGFiEmo1+EN8owTUqr4BY?=
 =?us-ascii?Q?zi1dCs+tpK+ZJmFxDcSKUdG0vxcyD070Nr5pvaHGrgRz3BMkX870is4Lpm1q?=
 =?us-ascii?Q?oGjzImV8lfEohqC2w1i/g6Zydn5cqP4HExgK2YDX0bmBlCJOV1OC3/qENRZV?=
 =?us-ascii?Q?qCQ462M0lRH0AsBOApPRGuzxpFb7pSjfjJM7YuypoXSr94ZntHEqtO5Uj0yy?=
 =?us-ascii?Q?qJbmmMBYMH8znZ5fxt9jyd3or4/IVDpB1RgdvXLtJTCO9YdFy11C+U67Km9D?=
 =?us-ascii?Q?qqPUlaY2rwZzSgMqRBFgdcdjhfX1PR6lhDLyVIWEnD9rT+4vKohBIA3SO34Z?=
 =?us-ascii?Q?R9FTxmmqMKoyEX2PT4SsN0qIPKPCngMPsn1cNfnROZQDgZFePOarMR59upj3?=
 =?us-ascii?Q?DXxQuIDbZ7OjcxXxgA5Gznau+1Wcn+ZzfX8DclnYsqyAE5cWxW8FaQ5RQtWo?=
 =?us-ascii?Q?ER30oQn2yRpuGYIWtqRl9wzLZ6pxmY6nDnvQAkjvLfA7cI1uhNH3TvsJip20?=
 =?us-ascii?Q?DQqJAseYCfCQziGjIuoiEQUV6YgurqW6eChwccnkTf1QxsageVvEDSCYWjKv?=
 =?us-ascii?Q?kHhJlAIKQj2Xif7PAf+uGcZpVBirMTStoe9o2akRVjtkkbDTM6CzyzAiTkKD?=
 =?us-ascii?Q?NDNnbEYGiZBukX3izNIXnJNn7r0WxOR0P/9eO+KsmsYCfRX5Glyhy2z08gd4?=
 =?us-ascii?Q?ckGYLwmQCBu1F3X1aExVQBUWOFBhSpvC/0rwvJzA3oXjJTw/nAzZ92BOIO3F?=
 =?us-ascii?Q?+n+9EX17Zz60kIj0wRNEGxsmVYgzx9XMxWuBd6tk1JQO2nrDMr7J/AEofHch?=
 =?us-ascii?Q?GuDcy81i7zZUcuV1qsFaMgTvAm5b1/hRGjnY9DpqpxuSyz86mYqG4Rd70Ils?=
 =?us-ascii?Q?vVz8qUBQqErdmLIn0K1sRE2UXYqIubyrl1X9BnKPpcWx8tXpcBWyZYxo2r8A?=
 =?us-ascii?Q?zlhsRebzHks1GT/bl9oNlE87AVi44NI51fBoAEcQlvoNrLDOiEhSnk6FNlh3?=
 =?us-ascii?Q?v4K1Ih7CWXtyisfsFmVbmeQqThr/9SitPVwwweHCVLBwSfGLmuoxKRYdrdDm?=
 =?us-ascii?Q?dGvE5rjuHGDkiw15QHTiahHw5O5fAfKvUcp+0bDgfC+rVpYMyI53fvnWcKNr?=
 =?us-ascii?Q?UDTfHkMUi8G+rs22CRu+kVEatEK+bts+6AlRKJdsnnr9nvQRwExlxfGbcxDE?=
 =?us-ascii?Q?uBalm9DiNeE9zb2L/HIKrLtaunkaADMxR5le09Zm3jmGN4phsxKV2s4XS438?=
 =?us-ascii?Q?ESJAYOvLPi4VVG6W47dbfh9FpOerveIooi7Kyl/UJ3foKUgbCYGJocEAWuZ6?=
 =?us-ascii?Q?f8PDa1j5VX/t5T3xW451nvuDfDoLqnInniPLUCgACdrk7bfLPGcrofjpLGz4?=
 =?us-ascii?Q?kHb25/yHm5ay54cosKJeSkkd4Po+oUMNqNDnFKOZMZRRfXzjvqmouMx7wCAA?=
 =?us-ascii?Q?0OYtsMbOQfUnC3J6ePYhJE9kYLdAoAT9QpDffAFcRcOaK81SWGecm7Oycf9X?=
 =?us-ascii?Q?+TBs+3RaNyx8oa8OBkxiNXenTe9UpJMvDFd0hmmo8a68aKh11J+Ld14ed8Ym?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fc0ba8-bca2-43f9-6b61-08dd78d0570a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:36.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEE3pCuyPOVBJ8FHVf7j1jKoyjHSPndbpQC1NaeF9+a9RpwGSolpS9xqSu7+meehhpvRNtIjMATSgKVXtD0Rdp/qthdMoRxpGbbY94Z45i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3940
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

From: Long Wu <long.wu@corigine.com>

Introduce a new command to show the VLAN identifiers
filtered by a port.
Usage example:
testpmd> rx_vlan show port 0
VLAN filter IDs:
1,4-5,9,12,14,18,3864-3865,3869,3874,3878,4076-4091,4093,4095,
testpmd>

Signed-off-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
---
 app/test-pmd/cmdline.c                      | 46 +++++++++++++++
 app/test-pmd/config.c                       | 64 +++++++++++++++++++++
 app/test-pmd/testpmd.h                      |  1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
 4 files changed, 118 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 5a627a9bc6..0ac50545b0 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -4718,6 +4718,51 @@ static cmdline_parse_inst_t cmd_rx_vlan_filter = {
 	},
 };
 
+/* *** SHOW VLAN IDENTIFIERS FROM A PORT VLAN RX FILTER *** */
+struct cmd_rx_vlan_filter_show_result {
+	cmdline_fixed_string_t rx_vlan;
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t port;
+	portid_t port_id;
+};
+
+static void
+cmd_rx_vlan_filter_show_parsed(void *parsed_result,
+			       __rte_unused struct cmdline *cl,
+			       __rte_unused void *data)
+{
+	struct cmd_rx_vlan_filter_show_result *res = parsed_result;
+
+	rx_vft_dump(res->port_id);
+}
+
+static cmdline_parse_token_string_t cmd_rx_vlan_filter_show_rx_vlan =
+	TOKEN_STRING_INITIALIZER(struct cmd_rx_vlan_filter_show_result,
+				rx_vlan, "rx_vlan");
+static cmdline_parse_token_string_t cmd_rx_vlan_filter_show_show =
+	TOKEN_STRING_INITIALIZER(struct cmd_rx_vlan_filter_show_result,
+				show, "show");
+static cmdline_parse_token_string_t cmd_rx_vlan_filter_show_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_rx_vlan_filter_show_result,
+				port, "port");
+static cmdline_parse_token_num_t cmd_rx_vlan_filter_show_portid =
+	TOKEN_NUM_INITIALIZER(struct cmd_rx_vlan_filter_show_result,
+				port_id, RTE_UINT16);
+static cmdline_parse_inst_t cmd_rx_vlan_filter_show = {
+	.f = cmd_rx_vlan_filter_show_parsed,
+	.data = NULL,
+	.help_str = "rx_vlan show port <port_id>: "
+		"Show VLAN identifiers from the set of VLAN identifiers "
+		"filtered by a port",
+	.tokens = {
+		(void *)&cmd_rx_vlan_filter_show_rx_vlan,
+		(void *)&cmd_rx_vlan_filter_show_show,
+		(void *)&cmd_rx_vlan_filter_show_port,
+		(void *)&cmd_rx_vlan_filter_show_portid,
+		NULL,
+	},
+};
+
 /* *** ENABLE HARDWARE INSERTION OF VLAN HEADER IN TX PACKETS *** */
 struct cmd_tx_vlan_set_result {
 	cmdline_fixed_string_t tx_vlan;
@@ -13756,6 +13801,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_vlan_tpid,
 	&cmd_rx_vlan_filter_all,
 	&cmd_rx_vlan_filter,
+	&cmd_rx_vlan_filter_show,
 	&cmd_tx_vlan_set,
 	&cmd_tx_vlan_set_qinq,
 	&cmd_tx_vlan_reset,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 61f93a9ca5..313d49812d 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6676,6 +6676,70 @@ rx_vft_list_parse(uint16_t *vlan_id, char *vlan_id_list)
 	return count;
 }
 
+static void
+rx_vft_dump_printf(int left, int right, int *c_count)
+{
+	if (left == right)
+		*c_count += printf("%d,", left);
+	else
+		*c_count += printf("%d-%d,", left, right);
+
+	if (*c_count >= 120) {
+		*c_count = 0;
+		printf("\n");
+	}
+}
+
+void
+rx_vft_dump(uint16_t port_id)
+{
+	int ret;
+	uint16_t vidx;
+	uint16_t vbit;
+	uint64_t vmap;
+	int left, right, c_count;
+	struct rte_vlan_filter_conf vfc;
+
+	ret = rte_eth_dev_get_vlan_filter_conf(port_id, &vfc);
+	if (ret != 0) {
+		fprintf(stderr,
+			"Get VLAN filter configuration from port %u failed, ret = %d\n",
+			port_id, ret);
+		return;
+	}
+
+	printf("VLAN filter IDs:\n");
+
+	left = -1;
+	right = -1;
+	c_count = 0;
+	for (vidx = 0; vidx < 64; vidx++) {
+		vmap = vfc.ids[vidx];
+		for (vbit = 0; vbit < 64; vbit++) {
+			if ((vmap & RTE_BIT64(vbit)) != 0) {
+				if (left == -1)
+					left = vidx * 64 + vbit;
+
+				continue;
+			}
+
+			if (left != -1) {
+				right = vidx * 64 + vbit - 1;
+				rx_vft_dump_printf(left, right, &c_count);
+				left = -1;
+				right = -1;
+			}
+		}
+	}
+
+	if (left != -1 && right == -1) {
+		right = 4095;
+		rx_vft_dump_printf(left, right, &c_count);
+	}
+
+	printf("\n");
+}
+
 void
 vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type, uint16_t tp_id)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index ac4f716408..610e130c56 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1104,6 +1104,7 @@ void rx_vlan_filter_set(portid_t port_id, int on);
 void rx_vlan_all_filter_set(portid_t port_id, int on);
 void rx_vlan_qinq_strip_set(portid_t port_id, int on);
 int rx_vft_list_parse(uint16_t *vlan_id, char *vlan_id_list);
+void rx_vft_dump(uint16_t port_id);
 int rx_vft_set(portid_t port_id, uint16_t vlan_id, int on);
 void vlan_extend_set(portid_t port_id, int on);
 void vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index b35722d2f5..0eb326e1d2 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1064,6 +1064,13 @@ For example, to remove some VLAN identifiers filtered by port:
 
    testpmd> rx_vlan rm 1,3-4,7 0
 
+rx_vlan show
+~~~~~~~~~~~~
+
+Show VLAN identifiers from the set of VLAN identifiers filtered by a port::
+
+   testpmd> rx_vlan show port (port_id)
+
 rx_vlan add (for VF)
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.5

