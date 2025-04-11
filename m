Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C43C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 08:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC51D40A76;
	Fri, 11 Apr 2025 10:10:36 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
 by mails.dpdk.org (Postfix) with ESMTP id 4274540695
 for <dev@dpdk.org>; Fri, 11 Apr 2025 10:10:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFnB+2GwQDa3Fh+xc9ddeRKiAkyEwme8wiRd0dHut/m2fuTkjVC7980UvgPT1UeQHGBaELaLt1Do7jSDcKgAMntXZ2/b+hj4h903X4FX1Ji0JqX+AI2cw002uug8VWGyiwuG14WpPtuu72L9N9AzDO5lGytWYblL3QFMdzyUzvlX4plVwuNa4QjgIWLY4rcDQuQCmmqfzPwO4wluN5qx/gBvrU9R2L4zFgClFWD0vlhqskrYsA1BhfR1FAHPhK18mLIieGB1PRnIXciIzxOve8ClUFSoEetNXJZlZIH8CxNdzi2X8NUiXHH2BKunr+MDXRPxB1ascuAKO9I0Hy3biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u45C/U9KsFY/uXC3T6EXCe38EFwWKf+LTP9S15VJg+U=;
 b=nsQIifk4jh8OjDRWcjLzzHM4UKi7WJGL1B/zh2xKj6Ue6D7RMJ/E0q9BpqoSzfESPNCIEnAYfQ02q5bpI23e3nRYhxyoaZk/JFlkXjXVxp3OLTpRAApF0w1UmDPqPNXSlJqQFDUH9meXFe62a2MX4LLe1kvJg/Tq3wW/ANoRDBV4XeJR0BC95K9ASiqWWYCi0aJBTY2GXcr03eOBBuhO8xfs+kq/LV46gHHV3ohjiR3iJ/nA+kPqgWVulcNj9qlRxoV1Gvo+3kfF2wzzfJh8SWZXy9o+Fm9pO+X901auxR0csz7MSN35v0/f7edVut2BMrMXuXodaY6nd2Dmjpji5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u45C/U9KsFY/uXC3T6EXCe38EFwWKf+LTP9S15VJg+U=;
 b=wFGCpHCndmbKptp3HE7FfZ+RDKGYSboO7P9MPBeLG6VwyrIyF19VFAgN7HK7vvWrq8PP7MJuhIHgl701+ob4Ayo+TrpgolnysDIyuPMQ27qo0PSRBzCxHyvaPWuTD6BO2JDt89XFUkJdkdcdtlBZNiWR2CyBRZNkflBFXw3VNac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by DM6PR13MB3940.namprd13.prod.outlook.com (2603:10b6:5:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:10:32 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 08:10:32 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 1/3] app/testpmd: add/remove multiple VLAN filter IDs at once
Date: Fri, 11 Apr 2025 16:10:03 +0800
Message-ID: <20250411081005.1133509-2-chaoyong.he@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: c65dfb75-8325-497a-b1f8-08dd78d054bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xTU0TdT1epUQtlGgf/7v754yJYhi3RrS/waDE+S/Eu45sqf3BDma1enKwXxz?=
 =?us-ascii?Q?kq5iA0gmLsYWvH3UprLuqohDSOnUc2ITFlgqVGMA80H6ZHueqCBl95YT6xku?=
 =?us-ascii?Q?BQ3R8h0bV45hbKPvFvwd/1iynBZss8Mo4Gwfqr16/baOa860ZxUHwMEaRamZ?=
 =?us-ascii?Q?tA8TGDKe0PMUSQep9izZKuLx2K6fDmzgYQAo59m3wwl0wkgT9IG38WssHOWH?=
 =?us-ascii?Q?/CChQtriq/rEtiInrxlrX+YZknjb8PqZi6FX8ZsPrrpbV+jl+2RzP2f7oizj?=
 =?us-ascii?Q?waXqJ9It4mOz5JX8ZjI4aMeLX4EMfSj+HBX+LOEd6f0X3lCyHMlCQiYxdR2t?=
 =?us-ascii?Q?2Mi7hvcMweETrbU88oitP4s2KanbaHKUiKTBEeDJEQn9FF9+7HyOhuCkxWlV?=
 =?us-ascii?Q?N0p2xjCGNyIK1y3+6CkUwLXqWG+/GROSmgeMAaxXlhvLMxIQcTLQ87nJhvRF?=
 =?us-ascii?Q?kRgmMvxeMa3UWRrGZPAyLZ/nyONGeCVkOBzm1j9Uinc5Th6zPuMXeg1JMiFu?=
 =?us-ascii?Q?aZFgki+1/L0ZS9261L/aOne8ZEWbVbgD0mWHz5LPdwLqF8TLOsb3z7IQE+8W?=
 =?us-ascii?Q?KeTNFTjDDNN8DfHYgLSdxVqvlp6UxulQyDgLWXonSduCPXRv5Irjv3fH13S8?=
 =?us-ascii?Q?ngy4NEtDT2nj3r9hxO97kiXOVIaC6deP4djtvnYpAhYYesRDTIVoKZSOWbYP?=
 =?us-ascii?Q?Kma+EEOCrFknJ+mCcNH5IRQhpM+d4mIHyVWlvhQmp858IdHF8JmzeexYRIAj?=
 =?us-ascii?Q?x+EjvBEh1Eefq6zU3G78ecUUX2k8117s9InAxreikaV5dd3nbWySA8IAy1Rx?=
 =?us-ascii?Q?mu3zDKCYOlbkpeHcI64HQg59F46wVkGLLyZPEoqfcpvF8DJL4NZB3Jp0yBRZ?=
 =?us-ascii?Q?yVbwgiSFE4+j8Faa/5ihsHDWx3cPMlMzLUYRVGqAv0nRnNIY6SlyM2CJQL5K?=
 =?us-ascii?Q?KBmLvfXsUPcyQdY8s5MvStI917vqlbQeGThwgIBvtmlukvu1sF4+KHAEbHI5?=
 =?us-ascii?Q?doXZQpC6XIroHnBZGKQK1HXvojGnpHqkJMBNNChfQmymdr27eyRwwAk9KJ3S?=
 =?us-ascii?Q?qnxgcms4JHzRUmVXdR7RHX1L0BH+JQ0728YBLT8+4VnG9ITHo4OidBvS1nhM?=
 =?us-ascii?Q?Wo0h5ja3f6Nrc9I4A6qiNgCu3gAp4IYktPH8dRO3H68fnRIX+1iKLQyQV10e?=
 =?us-ascii?Q?4jMBFWxCJpBRzWb2gf/ElwFKOlnU1PD0noKx7eTuiyfMXmDo9vvXGAuvvwYr?=
 =?us-ascii?Q?g13GbhGXG52aombUEkt/CDhZjBqzZoL4tEeFAXcUN1ROcKMrcNWuBVvwAC0S?=
 =?us-ascii?Q?JFy36oFyYv+bUSnKuZQI/L769RnJ5n0E3DC/rT8jCaz73SnPo3HnITWhhlsw?=
 =?us-ascii?Q?p+5nH1lgvUZ4wwRbrvYylZScmWEPh/IcxYggN15Zju0n7GfCuLVquP+pgc69?=
 =?us-ascii?Q?qM/WReWqRjOIS/VBBkxZ1IKu2kcoQnJClj0jhL44MqLQRmF+H1skrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ux24KyAfbyHkxekJYGxocbwnv1tuhEOlr31aBl0R7g48amdfS+LkEjbWk2Y?=
 =?us-ascii?Q?Aj/v6oahnOihwzuN3DCZlrxQ+9htgbvVKyd62wYGO+geAhhPdD40AKZbjjsB?=
 =?us-ascii?Q?sNbVOA0kxSMS1s6e5pKypVtFE0Y5D2iAprtOdyZ1y1jl7p7evq37ryneA+zp?=
 =?us-ascii?Q?YJsoeV0ebY3Ek6bXyJh3CV9bHzLrebpHHLUVrDiVMYWnlDvR3y9e1ARbD7OK?=
 =?us-ascii?Q?yyYdB/F4BscEJAhMEvaysjTw8VWnG4E3+O2t2+/PITdovCN7W1Vd/eScjwfK?=
 =?us-ascii?Q?fRvZ6PVSdt7MiPv3x4WemI47u0nJkoaJdQ79jQpCkFe+kSV6CDSFFl3jlRs/?=
 =?us-ascii?Q?YhxC3CuSrePT/JuVUcK3DnOf67T9S+8xmuyB/Y/p6ikWRzjqv1IcPcPXYNVe?=
 =?us-ascii?Q?6mIZRG8bDom0tWaqd5qKV0MmV6uockvjAdaieOB9wbyx5wCAlQEsGcq3sP7N?=
 =?us-ascii?Q?sDkdUNFe643Dmpkdr0gwPvFo6ZNV4bQyztH1Q9LOsj5Nf58zV9bSl4NDTBdR?=
 =?us-ascii?Q?71TGioP1nD4xh4Fzw8UiL1tLytloAwzxKNrpWi5vmzmhuLWCCIVUlk4XJJs7?=
 =?us-ascii?Q?Ujdxz0qh8Xy5rCvjEo07bdRbq4GcBDbdn6sCtY+wrL3fyy9M5A2tqyjq3bHP?=
 =?us-ascii?Q?n+LyaNDqBnINBgkHbTpn7s355GUfQsroKMISAcDsbpppoaBr+aapQRU3YUFQ?=
 =?us-ascii?Q?/Rg+WZT0MKdqekm3O1oGj2kHp1VkOIIqsNmNxsFsWTDjTxu5gWrVR820mZ2L?=
 =?us-ascii?Q?6p2b92QtxpDri8AcaT5PF6DoE0zDz4X+hcGtbFGB3pNvvKGtDDojIyYWS3+P?=
 =?us-ascii?Q?ynyczwGy72p758bJUqaoVsjSriyKoK0ZYS0zgsIWLs4O9j+7GSnXlbXgn27S?=
 =?us-ascii?Q?DSB8PC7kLSXV51A61Ky8X0cjUUy0WuZR5eM0Ws/+s11UaZCY23m0wVRLKMLN?=
 =?us-ascii?Q?GnyJBw9CznH6i92IaHFdgHcTuZIocLh4jZUwVXvz5A32eNFOLOQPXtFnJSX7?=
 =?us-ascii?Q?w5Gxb53mzEs9nfBEkPaIgdenAQybcpDrev/30vgmAJO1QslNW02fyxyu3Go2?=
 =?us-ascii?Q?p1f7jNtzj3NOuwwohmpaeVVxx7lwCz3C7OSxdFun2HDn604rzKspTXuh1V/X?=
 =?us-ascii?Q?oM7DkWJc00eCDdwns82GTJpjWUg4Gf8EYk2HgJmuw0Xvw6ZCd3SYReG4lLnS?=
 =?us-ascii?Q?lVVYsVVn4A8IAIK1+tUKPlyDXI0fT2tPbU+cNbN5208q7kziVayvzeSMMoom?=
 =?us-ascii?Q?qviQO4onVG7NOfonyraTuSW0zH66uCHVr52/Kfb3wSvMNx6j1pwDoCSroo7H?=
 =?us-ascii?Q?jGOh1BMN5/d7VITc4J2F0o7LJWGNy0/NCZqZmEW1i2ufecfLq73+zkNCMkLU?=
 =?us-ascii?Q?uHMKIA8LnpgztWAZMEkxQF+ADCjqLELRUkPTZptTf82XBpvNneB+x1eB/xSi?=
 =?us-ascii?Q?CfNTFCNnlvEbsTdeWKAOBhMIOuvC5eU/pKf6EB59ArCdwhGTzG+fYReC1DKY?=
 =?us-ascii?Q?sJBJMB07EKpi4TIIaYuFZkEhpHXLnPG5sAM5Lc8KMHiC5Bb6aiZzU2E7QjZ7?=
 =?us-ascii?Q?1NOI0/gFMmAtcZdHOcGpDKx0EPQzDIYHUrbATQEVbKSnj9MhOBabkeoeTkg2?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65dfb75-8325-497a-b1f8-08dd78d054bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:10:32.8405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J36yRYXqJTQRrsvqgdaWdoPRxsAKBr9++gG6Wd21yTaCDKfnJZ36cQJcuWyEkyAZrGTb+Imy860sIyC7YLhCKWBB4F9hvWiWPNXAHuBHseo=
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

The command of setting VLAN filter IDs can only set one VLAN filter
ID at once. For example:
testpmd> rx_vlan add 100 0

This is very inefficient in some case because it forces the
user type this command as many times as the VLAN filter IDs
they want to set.

This patch supports the user set any number valid VLAN filter
IDs just through one command and it is also backwards compatible.
For example:
testpmd> rx_vlan add 100,102-103,200 0
The VLAN filter IDs 100, 102, 103, 200 will be added to port 0.

Signed-off-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
---
 app/test-pmd/cmdline.c                      | 46 ++++++++++-----
 app/test-pmd/config.c                       | 64 +++++++++++++++++++++
 app/test-pmd/testpmd.h                      |  1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 20 +++++--
 4 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d4bb3ec998..5a627a9bc6 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -411,12 +411,12 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Set the VLAN TPID for Packet Filtering on"
 			" a port\n\n"
 
-			"rx_vlan add (vlan_id|all) (port_id)\n"
-			"    Add a vlan_id, or all identifiers, to the set"
+			"rx_vlan add (vlan_id_list|all) (port_id)\n"
+			"    Add a list of vlan_id, or all identifiers, to the set"
 			" of VLAN identifiers filtered by port_id.\n\n"
 
-			"rx_vlan rm (vlan_id|all) (port_id)\n"
-			"    Remove a vlan_id, or all identifiers, from the set"
+			"rx_vlan rm (vlan_id_list|all) (port_id)\n"
+			"    Remove a list of vlan_id, or all identifiers, from the set"
 			" of VLAN identifiers filtered by port_id.\n\n"
 
 			"rx_vlan add (vlan_id) port (port_id) vf (vf_mask)\n"
@@ -4653,11 +4653,11 @@ static cmdline_parse_inst_t cmd_vlan_tpid = {
 	},
 };
 
-/* *** ADD/REMOVE A VLAN IDENTIFIER TO/FROM A PORT VLAN RX FILTER *** */
+/* *** ADD/REMOVE A LIST OF VLAN IDENTIFIERS TO/FROM A PORT VLAN RX FILTER *** */
 struct cmd_rx_vlan_filter_result {
 	cmdline_fixed_string_t rx_vlan;
 	cmdline_fixed_string_t what;
-	uint16_t vlan_id;
+	cmdline_fixed_string_t vlan_id_list;
 	portid_t port_id;
 };
 
@@ -4666,12 +4666,28 @@ cmd_rx_vlan_filter_parsed(void *parsed_result,
 			  __rte_unused struct cmdline *cl,
 			  __rte_unused void *data)
 {
+	int i;
+	int on = 0;
+	int vlan_id_count;
+	uint16_t vlan_id[4096];
 	struct cmd_rx_vlan_filter_result *res = parsed_result;
 
-	if (!strcmp(res->what, "add"))
-		rx_vft_set(res->port_id, res->vlan_id, 1);
-	else
-		rx_vft_set(res->port_id, res->vlan_id, 0);
+	vlan_id_count = rx_vft_list_parse(vlan_id, res->vlan_id_list);
+	if (vlan_id_count <= 0) {
+		fprintf(stderr, "Please input correct vlan id list\n");
+		return;
+	}
+
+	if (strcmp(res->what, "add") == 0)
+		on = 1;
+
+	for (i = 0; i < vlan_id_count; i++) {
+		if (rx_vft_set(res->port_id, vlan_id[i], on) != 0) {
+			fprintf(stderr, "Failed to %s vlan id %d\n",
+					res->what, vlan_id[i]);
+			break;
+		}
+	}
 }
 
 static cmdline_parse_token_string_t cmd_rx_vlan_filter_rx_vlan =
@@ -4680,9 +4696,9 @@ static cmdline_parse_token_string_t cmd_rx_vlan_filter_rx_vlan =
 static cmdline_parse_token_string_t cmd_rx_vlan_filter_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_rx_vlan_filter_result,
 				 what, "add#rm");
-static cmdline_parse_token_num_t cmd_rx_vlan_filter_vlanid =
-	TOKEN_NUM_INITIALIZER(struct cmd_rx_vlan_filter_result,
-			      vlan_id, RTE_UINT16);
+static cmdline_parse_token_string_t cmd_rx_vlan_filter_vlanid =
+	TOKEN_STRING_INITIALIZER(struct cmd_rx_vlan_filter_result,
+				 vlan_id_list, NULL);
 static cmdline_parse_token_num_t cmd_rx_vlan_filter_portid =
 	TOKEN_NUM_INITIALIZER(struct cmd_rx_vlan_filter_result,
 			      port_id, RTE_UINT16);
@@ -4690,8 +4706,8 @@ static cmdline_parse_token_num_t cmd_rx_vlan_filter_portid =
 static cmdline_parse_inst_t cmd_rx_vlan_filter = {
 	.f = cmd_rx_vlan_filter_parsed,
 	.data = NULL,
-	.help_str = "rx_vlan add|rm <vlan_id> <port_id>: "
-		"Add/Remove a VLAN identifier to/from the set of VLAN "
+	.help_str = "rx_vlan add|rm <vlan_id_list0[,vlan_id_list1]*> <port_id>: "
+		"Add/Remove a list of VLAN identifiers to/from the set of VLAN "
 		"identifiers filtered by a port",
 	.tokens = {
 		(void *)&cmd_rx_vlan_filter_rx_vlan,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..61f93a9ca5 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6612,6 +6612,70 @@ rx_vlan_all_filter_set(portid_t port_id, int on)
 	}
 }
 
+int
+rx_vft_list_parse(uint16_t *vlan_id, char *vlan_id_list)
+{
+	int i;
+	int min;
+	int max;
+	bool dup;
+	int index;
+	int count = 0;
+	char *end = NULL;
+
+	/*
+	 * The acceptable VLAN ID list format should be like: 1,3-4,7.
+	 * Use `,` to separate VLAN ID list.
+	 * Use `-` to represent range.
+	 */
+	min = -1;
+	do {
+		while (isblank(*vlan_id_list))
+			vlan_id_list++;
+		if (*vlan_id_list == '\0')
+			return -1;
+
+		errno = 0;
+		index = strtol(vlan_id_list, &end, 10);
+		if (errno || end == NULL)
+			return -1;
+		if (index < 0)
+			return -1;
+
+		while (isblank(*end))
+			end++;
+
+		if ((*end == ',') || (*end == '\0')) {
+			max = index;
+			if (min == -1)
+				min = index;
+			for (index = min; index <= max; index++) {
+				dup = false;
+
+				for (i = 0; i < count; i++) {
+					if (vlan_id[i] == index)
+						dup = true;
+				}
+				if (dup)
+					continue;
+				if (count >= 4096)
+					return -1;
+
+				vlan_id[count++] = index;
+			}
+			min = -1;
+		} else if (*end == '-') {
+			min = index;
+		} else {
+			return -1;
+		}
+
+		vlan_id_list = end + 1;
+	} while (*end != '\0');
+
+	return count;
+}
+
 void
 vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type, uint16_t tp_id)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 05ccdec8d2..ac4f716408 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1103,6 +1103,7 @@ void rx_vlan_strip_set_on_queue(portid_t port_id, uint16_t queue_id, int on);
 void rx_vlan_filter_set(portid_t port_id, int on);
 void rx_vlan_all_filter_set(portid_t port_id, int on);
 void rx_vlan_qinq_strip_set(portid_t port_id, int on);
+int rx_vft_list_parse(uint16_t *vlan_id, char *vlan_id_list);
 int rx_vft_set(portid_t port_id, uint16_t vlan_id, int on);
 void vlan_extend_set(portid_t port_id, int on);
 void vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index eeef49500f..b35722d2f5 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1035,9 +1035,15 @@ Set the inner or outer VLAN TPID for packet filtering on a port::
 rx_vlan add
 ~~~~~~~~~~~
 
-Add a VLAN ID, or all identifiers, to the set of VLAN identifiers filtered by port ID::
+Add a list of VLAN IDs, or all identifiers, to the set of VLAN identifiers filtered by port ID::
 
-   testpmd> rx_vlan add (vlan_id|all) (port_id)
+   testpmd> rx_vlan add (<vlan_id_list0[,vlan_id_list1]*>|all) (port_id)
+
+For example, to add some VLAN identifiers filtered by port:
+
+.. code-block:: console
+
+   testpmd> rx_vlan add 1,3-4,7 0
 
 .. note::
 
@@ -1048,9 +1054,15 @@ Add a VLAN ID, or all identifiers, to the set of VLAN identifiers filtered by po
 rx_vlan rm
 ~~~~~~~~~~
 
-Remove a VLAN ID, or all identifiers, from the set of VLAN identifiers filtered by port ID::
+Remove a list of VLAN IDs, or all identifiers, from the set of VLAN identifiers filtered by port ID::
+
+   testpmd> rx_vlan rm (<vlan_id_list0[,vlan_id_list1]*>|all) (port_id)
+
+For example, to remove some VLAN identifiers filtered by port:
+
+.. code-block:: console
 
-   testpmd> rx_vlan rm (vlan_id|all) (port_id)
+   testpmd> rx_vlan rm 1,3-4,7 0
 
 rx_vlan add (for VF)
 ~~~~~~~~~~~~~~~~~~~~
-- 
2.43.5

