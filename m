Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4ACC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CD5340B9F;
	Mon, 16 Jun 2025 09:30:14 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by mails.dpdk.org (Postfix) with ESMTP id 4391A40B95
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:30:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGThiYHPM7fhpVVQg4KKz6xfhKpxxt22nG6ICPG4rvB+MNf4Iglp/woeYwwYCuzfGOzLNFypALmFbcZ2gBelDIYh/jpnthUm4hWVPyuQDxFLOZVdSh8Sz5WJT84A33uJFZCzK0G7saJc7r+tsitF6D06x+rg0mLK41rjcBw6mxVsH1j5FE3IYRiQnDMIGhkTXOE45v2OWKnbr6PzOKRagvxZeEle8xBJtKJmGw64U/XD9TvOCADJF+rWx7vHKvSXR/KvBUd2xqRkgIUySktjt/KwMqPhgsSrSqDcRi8MfG8hFXwZoxR6u/ZOUVpfTRv4BxSp2XUShL0+vdtmQnLT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zv/laXo046HVHKWQx1N3WnckClrHGVu5WUO2ReSSOE=;
 b=SoAbugNlUztR4O0xykLwFrCElzyZVNKdi5kkJ+khoi6VzWPEnOk9rZY1nIhpvl0yDBB17rkbptQuNcbrqNbIF8ocpF/2hrw+7gRqTnRDmNZ9fWfK3rwnf2CJZmQWSIWCCraqeg6CQwKzT6yhxDvywCcmyuasj/OSLbzLHXZlub+hV3+ig3kaxL5j9pVV1Rn8h7eIRA9uT4zTnrwoIClEsiEn82WbGbXtPmSR3b6rIfUbl3f3UrAmIIC+oi7jYIlowPq76hkJS7LSGzEg1SIRJMRe46WlX6vT6Kw2xrDwfA9jq7i2dyUqSnh2bcOZ1Uj7BdSgdLYtRXuWSrhZARs1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zv/laXo046HVHKWQx1N3WnckClrHGVu5WUO2ReSSOE=;
 b=mADkXtJefSEO4LwILBNGTAYsCMxrtZryAEaA3GBozqEsC+UQxxe9cWBjuJ4pdU/gXdnligjTWMWw4ofO/EoHUFbNslGwP+NpugD2aLpbmILUyMlT2waCbbnCAcRyNzmqvIWkxk7es5+Zyv71Tez1ypd0JmsxiEDm6+hQW0mjuJ7JiEv3P0bN54U/5Y/QW9HLCYZker9ZWI98OY8n5B4loeTG/TOv79z77b2h6zc//ffftMsCoCc91SqsalOLAXvAsjNlcw0DbKvKNYpJWrSw4KRQcrH1jEj3VExfO6PE9u/eNi5MFuDekIzgOkk/t/ylL2ZRU4kitmJk9Fwx5AkE0g==
Received: from BL0PR0102CA0043.prod.exchangelabs.com (2603:10b6:208:25::20) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 07:30:08 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::f8) by BL0PR0102CA0043.outlook.office365.com
 (2603:10b6:208:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 07:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 07:30:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 00:29:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 00:29:49 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 00:29:48 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC PATCH 4/5] app/testpmd: add testpmd command to dump mempool
 history
Date: Mon, 16 Jun 2025 10:29:09 +0300
Message-ID: <20250616072910.113042-5-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2ce051-28d7-4513-2d65-08ddaca79eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNcKzcrA1ivMQkVNwhGUNp2KA11a4/9VkxMclNQi3L7UwZtEJ03WZTQ9CY8k?=
 =?us-ascii?Q?trIU0dmqs1jo3XZmNrTrur1AMD3bNPhoJtzEEnb82JoRtpTvXyaLpG3CufGA?=
 =?us-ascii?Q?LQM8db0aybPVUo75C8Hap/PXKi5CPVY0Pf0UCT8LhEa7r0kia5w76gXzNbeX?=
 =?us-ascii?Q?JtNWOLBnQwaj7d9qtjj3zEKCUuo2vqTWSRUm5ii+/J3+CJ7Eex/MjuCf+A6J?=
 =?us-ascii?Q?C36rZ20g/Garw7lLTwnmRcq9UnF0hF+k6rM6fB6Y0hAQgO0WSDnmsLAM2Nei?=
 =?us-ascii?Q?mQ2NSg1m65eryXNv6atkKHfCB2v2N4SKIJwMjsBtugMGMsohzwIhRJphA/Gy?=
 =?us-ascii?Q?1SKQ9NKW+0GdPExiKkfQQ6iaHBXisrEltN9vBGUW11l6f0NT4ChV8+i4ZoRF?=
 =?us-ascii?Q?w02x7YDdkaGmKQs2fXRx520gpf50If+hn1HFXxWeufVCEMevy8XeVV0MgCmE?=
 =?us-ascii?Q?MPOuqAWX4FCfHr1V2M6SeDFzeTp5mEUZKCgxBDlQ96jn9iMmnEJk/uK8B792?=
 =?us-ascii?Q?/k8fcWOZrH+hgQL7BRolPR5vWWm6sbf75ueZfH/gsAT/IF7ub1G7K3OiHN6x?=
 =?us-ascii?Q?O3k1OGbTySaZIgpiZglmP4M7OLB3Kxh/6iw1RNxuoR5kIL3fPtZ0oo19pM3+?=
 =?us-ascii?Q?jPj5fnmqBm3IeztcgDaH10lhDqwCg9KCKhQyou/ZmVcWeTLwE9yjRzJC52+b?=
 =?us-ascii?Q?BVr7Otp/rnSJ1wzkVBJh8ghMM5AyBQUKnxXvFqDRXu7PvE5kfkiDHGlxPKuO?=
 =?us-ascii?Q?pBcF0YqzWF5Od0iKO+Ul2plhIaEpvXKoCBTKfBB14xMhqi723XNSNlNks5Zu?=
 =?us-ascii?Q?30W7DK/Lhsb1ESjAm7s3YvmiOATw1SVZT09A1/6sKCLzR4FTVUy+O5BFkoR+?=
 =?us-ascii?Q?3+2dNIXil2nJriM5WFiSnBqtAY3gqIdIVW5U2bhNHGJiePAVmx8Qwe9h7VIQ?=
 =?us-ascii?Q?vv1z5Q1fQwIXMPCEaEBAMgGwUMwc0H1071uI3OqMX2PM/p3Rw0lVmQyIwrNK?=
 =?us-ascii?Q?RUoigwiXuFAWvXMg03GTZt78cwM6va7NLa3BKFe5OPbMJ628Qf75FKJ93zaE?=
 =?us-ascii?Q?E+i8tQyEwMOGsOe8dFH+nUWS8PCKrS1pxAfeEX+r2oNvE7QytFnkUKB3UIwS?=
 =?us-ascii?Q?UkCebuOwDP8eUMDCrWYFW/c4qOiFcO7orJweVlvNW0j7UcbmCk/s85WWsQOj?=
 =?us-ascii?Q?tzdNDLRZ1XdL4BsyE8AWXhWbwC6YBBnW+fVGnYye/lyJHAQXVVAFuYnaYEu+?=
 =?us-ascii?Q?7vQ9/g7vbfdPSWgRJeJq0mBY2b11BebzYNqeqdk2vJXKj3rDhfs+rtdtFIxA?=
 =?us-ascii?Q?77rZkpMkMR+mOJWLOp8lXX9ZsPJ6qCg23wY3BJWhFunexQpryRkoLLxHhg0Z?=
 =?us-ascii?Q?ihjaUR3dtp9zK4NQvESudTwgGDTVw78agM8fpQOeGco33HbFpl4BbhCTHpp1?=
 =?us-ascii?Q?qsJvKpF8eG6VEN9MbiG7JiaGGYRf5sYzlAU/pGOtDxg4+U613X10o1iutkXS?=
 =?us-ascii?Q?Z1tLSQhD4Ig1Nz/QR6wZJ4PdCjfEKKX6dg71?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:30:08.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2ce051-28d7-4513-2d65-08ddaca79eea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

dumps the mempool object history to console or to a file.

The dump will contain:
- Operation history for each mempool object
- Summary and statistics about all mempool objects

testpmd> dump_mempool_objects_history
testpmd> dump_mempool_objects_history <file_name>

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 app/test-pmd/cmdline.c | 59 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..3233b9d663 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -296,6 +296,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"dump_log_types\n"
 			"    Dumps the log level for all the dpdk modules\n\n"
 
+			"dump_mempool_objects_history\n"
+			"    Dumps the mempool objects history\n\n"
+
 			"show port (port_id) speed_lanes capabilities"
 			"	Show speed lanes capabilities of a port.\n\n"
 		);
@@ -9170,6 +9173,8 @@ static void cmd_dump_parsed(void *parsed_result,
 #endif
 	else if (!strcmp(res->dump, "dump_log_types"))
 		rte_log_dump(stdout);
+	else if (!strcmp(res->dump, "dump_mempool_objects_history"))
+		rte_mempool_objects_dump(stdout);
 }
 
 static cmdline_parse_token_string_t cmd_dump_dump =
@@ -9191,7 +9196,8 @@ cmd_dump_init(void)
 #ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
 #endif
-		"dump_log_types";
+		"dump_log_types#"
+		"dump_mempool_objects_history";
 }
 
 static cmdline_parse_inst_t cmd_dump = {
@@ -9253,6 +9259,56 @@ static cmdline_parse_inst_t cmd_dump_one = {
 	},
 };
 
+/* Dump mempool objects history to file */
+struct cmd_dump_to_file_result {
+	cmdline_fixed_string_t dump;
+	cmdline_fixed_string_t file;
+};
+
+static void cmd_dump_to_file_parsed(void *parsed_result, struct cmdline *cl,
+				__rte_unused void *data)
+{
+	struct cmd_dump_to_file_result *res = parsed_result;
+	FILE *file = stdout;
+	char *file_name = res->file;
+
+	if (strcmp(res->dump, "dump_mempool_objects_history")) {
+		cmdline_printf(cl, "Invalid dump type\n");
+		return;
+	}
+
+	if (file_name && strlen(file_name)) {
+		file = fopen(file_name, "w");
+		if (!file) {
+			fprintf(stderr, "Failed to create file %s: %s\n",
+				file_name, strerror(errno));
+			return;
+		}
+	}
+	rte_mempool_objects_dump(file);
+	printf("Flow dump finished\n");
+	if (file_name && strlen(file_name))
+		fclose(file);
+}
+
+static cmdline_parse_token_string_t cmd_dump_to_file_dump =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_to_file_result, dump,
+				 "dump_mempool_objects_history");
+
+static cmdline_parse_token_string_t cmd_dump_to_file_file =
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_to_file_result, file, NULL);
+
+static cmdline_parse_inst_t cmd_dump_to_file = {
+	.f = cmd_dump_to_file_parsed,  /* function to call */
+	.data = NULL,      /* 2nd arg of func */
+	.help_str = "dump_mempool_objects_history <file_name>: Dump mempool objects history to file",
+	.tokens = {        /* token list, NULL terminated */
+		(void *)&cmd_dump_to_file_dump,
+		(void *)&cmd_dump_to_file_file,
+		NULL,
+	},
+};
+
 /* *** Filters Control *** */
 
 #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
@@ -13992,6 +14048,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_cleanup_txq_mbufs,
 	&cmd_dump,
 	&cmd_dump_one,
+	&cmd_dump_to_file,
 	&cmd_flow,
 	&cmd_show_port_meter_cap,
 	&cmd_add_port_meter_profile_srtcm,
-- 
2.34.1

