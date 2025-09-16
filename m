Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2961CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA6540673;
	Tue, 16 Sep 2025 17:12:59 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013022.outbound.protection.outlook.com
 [40.93.196.22]) by mails.dpdk.org (Postfix) with ESMTP id 32BCF40673
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:12:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sF7inq2o0xpAdZN8BhXJfAGo/YSq9VBy87P5svfVTsMXBYvdpobGcWe1K80ncwxjn/wax6YyrsU9hKObKaULmEbM/6Omvb0ePJZYMtrfwhHFmoyiyU4LBA5SJX9+ZzxXcligmiIrnpgiw/dCgCQJ0MtCP8B31M//pV9h2T9NHSikwfNUjpbs3rAzXfHKo7qD5IT20mXbf71tUGJ2YEKJZzbx4VC1Nj0IbN/qpZCnE/wAUol/SnXKAq/Yv7yjCpRFzxbebVMLgbikd7u71yqDOD/h9Dpga/1eGwAxhvg8m/768FBjq5RxXYa3xYd6I5249tVBHUW27TQvN7jk57liog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbjT2UzJAjPUZQPUajtmibrGkUe5HyC0o5Klf9YXu5Q=;
 b=PmOBhFTRu7YHBQyU1uDu8AW9IC1dsTq6rV2fU++mpn9WNKlqa+Sd+7BjqlNUNY9M2b6w6uEafBBz5pPMsRCp1XAZS7VEiT0nNApZDWU0+P66gtwct6O/woy3SEb+gXeWn3NYPVO9XfXGQ8qcgS1ICD5BA9SsT9Cgk3E5y0HB7wAanE7j9s321HAX5zOrHHPgRX3iNN2altHhzCEcYr5bHYLGkZAGyjRjXxEtYci6cugnOgpQXNAmX0rPS9i5LVBG46KPS/sWEloMbaVfi1u9XDU5nkYSuxry4+oVXNKJAMHM7jeWjksV16ce7FFAuKmx5rwLk8tYEfZID5xE4lpnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbjT2UzJAjPUZQPUajtmibrGkUe5HyC0o5Klf9YXu5Q=;
 b=BTnwl9Wx6GVEGB4EjV7E6Ib/2ZAd+8JhC18rj9QencL97lXM2orhAcQh1X3xyPLw8E9tqtdAZ2zxzBkZL8Al20gnmVeKq2sPnwhCJ6UthcbeWiXvYaO4Bx/9HEhj8TstMJR+qE+81JmTPNxgX+3Pi1JlC0rHe44JwzNzfMM4Vzv+rJO9D1qHOxtoE6QKEnwa/hWf4CDE0AKI876r9oSFroqYsCo/QDTDWpnMdbvd1JdspdjKNvGIt4SMcXgCsKKuyIePIOwwbhks9w/S2RKb0wkrMzGTBJJVARGNNgE1S9uZioCqGhIu5RZIr+fHs7sJeiVWlO97VUQs6ceIk1ppLA==
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 15:12:53 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::45) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 15:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 15:12:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:37 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 08:12:33 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>, "Shani
 Peretz" <shperetz@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 3/4] app/testpmd: add testpmd command to dump mbuf history
Date: Tue, 16 Sep 2025 18:12:06 +0300
Message-ID: <20250916151207.556618-4-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916151207.556618-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: a5374c06-bc55-4b9d-6143-08ddf533822c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1DqbaOta2ZAK8m+vJYGpfGHwILEvqvxTB0a4plLPS8EU+4mnW3ijGCYWgiO?=
 =?us-ascii?Q?nP88KUmzj4tsSykH+U45UykDXZtNucqXKn6ccGX6T+hzPsM+YVGqmjrkiwpz?=
 =?us-ascii?Q?n0E1qWscoMk1XUEQc5LudXG6bIPhkiIz+vGPdOuWPhL67hIWyH+AY9/HDKpq?=
 =?us-ascii?Q?B91Iwrzu3UBry6wTluDJsGfpRj7dqtHNRLtq6aeiwVet5kP8BYiaMUay2/Kb?=
 =?us-ascii?Q?YrsLR1Z+GTcgt7dlK84f2GkALW1oMYBU5kRriJOOEGI5BEiBfRXeJm2XElYx?=
 =?us-ascii?Q?vYkib5yEmbDIdrwmc/7JvEVAj4A4Mebn9XFxN4zHUDqIGKjWfOjk8EWu0PjP?=
 =?us-ascii?Q?MNtDfiZcZOiPf+5aG6yuThY8muQIDfIHRE00+BCdWH1c2vk8H5Yu07alYy81?=
 =?us-ascii?Q?9HXOKOWXKqwT6pZglHwzjFK1pUoZKx73Cw+Q08Q2GDPRadW2iPUx6v3WPBOZ?=
 =?us-ascii?Q?naiWTaiWcJ3Vda7BALvRF0DA0tbgys4GvF1VPxywQAGf5pUyWnYGs6oDtc4S?=
 =?us-ascii?Q?hwpj1UV3Nz4dccwHWUoYkFlW60dlscLzbk7t+e+23K0OBO7zlT+9joVyEInZ?=
 =?us-ascii?Q?27uw0R1+3ZKx7R9I6GAuCyG6C/WrTiQ6GB4eU/f3HTvbHAtiHYt03hrsic+H?=
 =?us-ascii?Q?0moTxeS4dcbQ3JyJUgc65bSkvHFPnjqhdDFjhn7ueAO6v+KV1JkYQcBidM26?=
 =?us-ascii?Q?20TVDWkG8Xptpkkn3thHbb4QJSyPiLkVc8dnmRo2w6V7w0ZamYvyqWthr2dg?=
 =?us-ascii?Q?XgbZLuseMyL0NE2DPIzcCVgcHA3uvpadpvyjheDkbDxfXZxojLz/atk3FSn7?=
 =?us-ascii?Q?9Zzq4gUq/tVKD21Tu7ZCBgV7BtQWWNYmMZTWt+ZqgCIpr1crIR4Ku5wWzvc6?=
 =?us-ascii?Q?1pH9fOMwr/gSrrQfZzmKfu5i4xpmsadnGh+cp4OrgWHzDn8WzMTTVIXv54nU?=
 =?us-ascii?Q?WXtVv0GTBa9jpW4K+phYGK8Jurqw7SoWtH7CjdRVzLfatYMAgaWWbUQno0CM?=
 =?us-ascii?Q?CfS3LlHQrTVvk+P1gGw6e3U6dAlDmsyswyKaLus5HyuFd7dMwPGXaHr+RPWB?=
 =?us-ascii?Q?8di/WT4S0EoZ3U7WoWlfXaSPBhZxq6FEy60P6IwOyt4Y3yBrvmYiWBruoQXv?=
 =?us-ascii?Q?29QDfkB3jGeYIMcnkEVEwDb738UVoCR9GV5qh3iLmEzdLtvNtowT4gW6X3P1?=
 =?us-ascii?Q?2F3epsKlYls/M90D7XDsJKHNO+ExP80CAo2e3Z6OXDVM5YWUN1eUEzu7OOeG?=
 =?us-ascii?Q?aQo8LnarXc4G4O4UwgiRLfuZWLD5sQJSLNBGaRAOb7N72aIRB4NrVQ6aLNM6?=
 =?us-ascii?Q?ssk0G0PhWsMCjlKq1WJYTPE44IuqXk67/yCKhMQY0pK4PZpi361A8fVrU+Xz?=
 =?us-ascii?Q?7kBNANBl7t5jc+mwmbY4FBGRhRTCBMshv4jxqMBe7pmZi4q8P9V1Apd+WZlR?=
 =?us-ascii?Q?P0cW3iHmtQ1zbv8iMSEnd2MGc8o1V0044KoN5F0DlpyXYF4hd81pMx7A7PI8?=
 =?us-ascii?Q?vlieIlXA1L2jfj0pEeE+IvwfoTQ5C29K71fS?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:12:53.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5374c06-bc55-4b9d-6143-08ddf533822c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

dumps the mbufs history to console or to a file.

The dump will contain:
- Operation history for each mbuf
- Summary and statistics about all mbufs

testpmd> dump_mbuf_history
testpmd> dump_mbuf_history <file_name>

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/cmdline.c | 60 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 3731fba370..7a1cba5094 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -40,6 +40,7 @@
 #include <rte_gro.h>
 #endif
 #include <rte_mbuf_dyn.h>
+#include <rte_mbuf_history.h>
 #include <rte_trace.h>
 
 #include <cmdline_rdline.h>
@@ -296,6 +297,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"dump_log_types\n"
 			"    Dumps the log level for all the dpdk modules\n\n"
 
+			"dump_mbuf_history\n"
+			"    Dumps the mbuf history\n\n"
+
 			"show port (port_id) speed_lanes capabilities"
 			"	Show speed lanes capabilities of a port.\n\n"
 		);
@@ -9177,6 +9181,8 @@ static void cmd_dump_parsed(void *parsed_result,
 #endif
 	else if (!strcmp(res->dump, "dump_log_types"))
 		rte_log_dump(stdout);
+	else if (!strcmp(res->dump, "dump_mbuf_history"))
+		rte_mbuf_history_dump(stdout);
 }
 
 static cmdline_parse_token_string_t cmd_dump_dump =
@@ -9198,7 +9204,8 @@ cmd_dump_init(void)
 #ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
 #endif
-		"dump_log_types";
+		"dump_log_types#"
+		"dump_mbuf_history";
 }
 
 static cmdline_parse_inst_t cmd_dump = {
@@ -9260,6 +9267,56 @@ static cmdline_parse_inst_t cmd_dump_one = {
 	},
 };
 
+/* Dump mbuf history to file */
+struct cmd_dump_mbuf_to_file_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t file;
+};
+
+static void cmd_dump_mbuf_to_file_parsed(void *parsed_result, struct cmdline *cl,
+				__rte_unused void *data)
+{
+	struct cmd_dump_mbuf_to_file_result *res = parsed_result;
+	FILE *file = stdout;
+	char *file_name = res->file;
+
+	if (strcmp(res->dump, "dump_mbuf_history")) {
+		cmdline_printf(cl, "Invalid dump type\n");
+		return;
+	}
+
+	if (file_name && strlen(file_name)) {
+		file = fopen(file_name, "w");
+		if (!file) {
+			rte_mbuf_history_dump(stdout);
+			return;
+		}
+	}
+	rte_mbuf_history_dump(file);
+	printf("Flow dump finished\n");
+	if (file_name && strlen(file_name))
+		fclose(file);
+}
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result, dump,
+				 "dump_mbuf_history");
+
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_file =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result, file, NULL);
+
+static cmdline_parse_inst_t cmd_dump_mbuf_to_file = {
+	.f = cmd_dump_mbuf_to_file_parsed,  /* function to call */
+	.data = NULL,      /* 2nd arg of func */
+	.help_str = "dump_mbuf_history <file_name>: Dump mbuf history to file",
+	.tokens = {        /* token list, NULL terminated */
+		(void *)&cmd_dump_mbuf_to_file_dump,
+		(void *)&cmd_dump_mbuf_to_file_file,
+		NULL,
+	},
+};
+
+
 /* *** Filters Control *** */
 
 #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
@@ -13999,6 +14056,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_cleanup_txq_mbufs,
 	&cmd_dump,
 	&cmd_dump_one,
+	&cmd_dump_mbuf_to_file,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
-- 
2.34.1

