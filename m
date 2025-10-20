Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC80CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 066B842E53;
	Mon, 20 Oct 2025 18:44:15 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 03BB440ECF
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022119.outbound.protection.outlook.com
 [52.101.66.119]) by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VftzCJoFrIw+m3TG6jbjSi9zORl/9JaB++rjzZ41Sw9qMe7cE79yiCDF4L4h7ySxIiNIxPYjSKzP19PKijgc+uHtjJSFwLnfibk67S6B/ulCg636QWZOXTTCWQd4HHHVVpiPg1Ic0ibRDhZiOEgVD9A9SPfEZZZ4ryzWNVKdqE66fGWVz1s7TumWfbOkAMQCn8X0Ym8A67XdbLYObrv72/3BlkZyzcE6jRXT1zUT9kIPYbIjkfhgmGPwtIE3RIoN2rwyZSYGNPJMP0l+m+BqR6oZT7eYXFGEZTy/3qNbfx2RSjrKjvabgIeJj8m6GXqiS4OJr/FVp8Qh7ExIiL4i5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Q23eD046qRmgVWxEOckjtuDJpVewlrSREG7uHEQR0=;
 b=lkIwl7QwblAutrvOR/1NF70kL+XbG+8uJ7oMD9AHfaZi0kcrcqzXFYtAXLbi+9GmrWfATQAHmbd5NJawZ6v3LF73PWq+Fysvs9BU8YJjlEZvYCcjlym0hsPDf0jctaJejhtjKXbQJTPdARNx4z0coigBTldZ+QEz30udh/XILZplRnIJVgD0zmpyCH+C5GRb1eL6/e+zTFyVKkfMNYsFSGG9I7PHe5uJnMEvomtAg8itah5l7v/FHjmRyaKgCfRch4xL/jRSM2t8V32HVUC/VHDcCF6bjGj/NX68UQQ3FUqUL3TBkyGq06VnBG387mUxKGAtlpxQyLC8RN03J1X5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Q23eD046qRmgVWxEOckjtuDJpVewlrSREG7uHEQR0=;
 b=l9LbkhQqf7hoDATRB6N47f1M4yZ1IlGj1RblWJ/KqsPmDqZZ+WEz1pHg90P6BwQ3tWlpZhH9+83EI3hNwnpdCazmrTBj/l00Dr8ntAA8Hle0v7dv4XdTagAbKkmPIqCHF0uuiASAlBtgF7q1sZM8IbLIUDAgQiXgiYOqnZxaJzE=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by GVXP190MB1848.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:50 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::6a) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:50
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 14/21] net/ntnic: add handling exception path option
Date: Mon, 20 Oct 2025 18:43:23 +0200
Message-ID: <20251020164336.283664-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|GVXP190MB1848:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b98653-c617-432f-a4c6-08de0ff7d8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUd0UmRTbnRGNHA0WE9hQXdzMGtBUVlydEhCUHI0Y2pjUTJvUkZ0UEVtVEdK?=
 =?utf-8?B?L0NmakpVdXBMTnNzNTE5UzdlQjNHR1RHQ295NWdDZGdSMDRxNjhrN0xONFZu?=
 =?utf-8?B?K1oybTdZU2QyNXBkemNnRHJVN3pLVWZYYllpZDM2bFVIdkpndFRwS2U4RVMv?=
 =?utf-8?B?Rm5Ud3R3TE5YT3pMMld0R0RlVFB3b3FYZmNwSUxjeE95ZGVYejJDQ0VraUZo?=
 =?utf-8?B?TlUzczczbWEwd29kak1nZFZQcjVwWEpQK29xWFJ5YzNPZUE2ZTFUL0NDVFRy?=
 =?utf-8?B?SnJLVi9KcWZySkdkcjdpeUNwOE9IOTY3bzUzT3JYOWEwNWF1NitDY3BhYng2?=
 =?utf-8?B?dUs3VzVRVXZDNUdZSGg3RnJTK3M2VFZ0VEtsZUJJZnpyTW1nY213QzlJNnpo?=
 =?utf-8?B?VGRiRnhhd0I2emdGcjdrTlJHTytzRkJYZFkwYWVmdUMvRDV2NW1RYThIUXlt?=
 =?utf-8?B?b2tIb3M1OWllaStFL09rczJSd1N6b1k4alFRNXJkRGxOdWFSMUR6SE5FTnVU?=
 =?utf-8?B?di9aRU42KzlPNEt5ZDB3a3A0ZVhWdlE2QWEvcFUzY0FiMmVrZFhFSmh3OTEw?=
 =?utf-8?B?U0tuSnp4RTJIUmtXUHVYR1MzUm5tT3d2NDB5Wks2YWx2clBQejRYeCs0Rjl6?=
 =?utf-8?B?UlVtNmY5U1laSXdaM0d1enpiMUdqZHBoNEg2RjZ2ZmlQeHlMZ1lnaUJoMWt4?=
 =?utf-8?B?S0dMb0VBaGpUSkljNUs0S3Z4cGRxQmNPWk9vbXNaVWVCWnptMlBzR1JXOUtt?=
 =?utf-8?B?L21LSnhBSmEvZTVqb3lqRytQUCttRWY3TU80SzFTSlFsWkNxWGJjN0diU0p0?=
 =?utf-8?B?UXZ5U3MxSUp4a2N1cGNldjRReHk1S0hXNCtEeTcrZnJuZzhGV1pGK054NU1P?=
 =?utf-8?B?SjJOdE90aVVZTzJ5WW01Zk1zSm01bmNyVzRrVXRwTWR6czk2UVdGN1BqSGty?=
 =?utf-8?B?c0lQQTNqeU0yY2JhUGNMWWNFMjl3bDdUeWN5NFJJZW1FbWRZQ0dYQlhNQ1d5?=
 =?utf-8?B?TnQwYVhBQi9SbGFUV0hLOE1HUU54TE1XeHdaNzI4T081ellqYWdRU0lTYldI?=
 =?utf-8?B?VUVGbEtMbmNDVmxWUy9ESlN0R3dWSHhHeGlJV1FzMWRlL25HeEZUNXVVaFpP?=
 =?utf-8?B?N0syMUVTdmdvQXZkZGZvZDRkMWU5eUpCc0JCOHlKekVYWXFQdUduajJzMGxa?=
 =?utf-8?B?L253Z0w0NkxSSnpSaGtzVkUvZjVZdXFETUkvK0JrcUt0NTYwRm5JWkp6ekhD?=
 =?utf-8?B?TjYwcndxOEhVQ203U0k0NU44N25tTWhHTXM0V3gvRTFyeXp5OVJ1U3JMbHEv?=
 =?utf-8?B?QmlXdGJWZ3ZoendlUXN6bHdQYUtSZ3BQUjNtQ2daaWhaYlVTL29RT2ZDZ29K?=
 =?utf-8?B?VjZVSkhBbjRXN1Ryb3h3TEd4Mk9sS0twTUxIVE52Y0t6aGl4WTc3eVVRYzI1?=
 =?utf-8?B?clIya3JjQ1lNMS8vbW9PT2ZveUdDV2ZreDBaY1pCRjVha1ZjY2ZHVHVvU2pj?=
 =?utf-8?B?MWVxMUNqeUpGK0I3VVBpLzRnVDE2K3J0TFJXKzhMNlNEOFJvRzJmMDYzcS90?=
 =?utf-8?B?Wkxwd2Jtdi9HSUVzTlRvekExMXZXczhGd1lKTGdZZFZob21jRUZHaGNoMHdQ?=
 =?utf-8?B?MlNFRXFuQ0hleUdYVDJXWVlRVXphU0FVMlpWRWNoemZ6eitnSTNOaXh2bmt6?=
 =?utf-8?B?VURHRHVvUnRVelJRRk95TUxvaE5ZaDliTi9NaG5RMCtIN09OL2VkRUNWalJY?=
 =?utf-8?B?Z2pYMDBlakQxQWFEeFRseUVodGY1RGhiRDdHak1Tcmd0Z0dsa2hDVXArV05R?=
 =?utf-8?B?ZTc1V0FPY2dUMnBKU1BFQnc2cjBOeU53NFE3UkhFUmduUVp0QS8xVnB4RWJJ?=
 =?utf-8?B?UXlpNEF2dEZqVGhncnJYSmgyRGlETUxOVTZaZmVTSUxRMml2a3BINEQ3RElw?=
 =?utf-8?B?U3lLc1BKMzZmc01YaVoySDJEMTBPaHJnQk5jUzNwdVlRNkdiSjNzSVRXZUhl?=
 =?utf-8?B?SDQ2VngxYVlCYVlHUC9uKzdpT3ZDMWdsenJkWFFPQUh4M3d4amJvRmRJN1pY?=
 =?utf-8?B?N0EwZGVCdXZMRTNlSWhUbkl1RlFnbUxJQjgrSDFIQ3YzQ0NjVXptM0o4bUdG?=
 =?utf-8?Q?w028=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: myVduMVc5LoMODnC12kgPgG53RhAQlkOKF2axgX3x05s2MxqKHgjPug70tFw5cPFPtoI6OE3KIrV/Xrkj5fC4zthQIxq4DG6MVPYWgWZftvoOnbcBEAHl0K83bfTCO4UjaUlMeT897EHHzqIhksxWegnAq1NcLis2LOHBCKZVTp69onvXCu9ByoXf4f78/wmSHcfNP8jWw5INU6+sT2aHzbWdloB1fm5rUrjwhLzM4S4FTi0S56zDITBYbWDIPlALYi7ux6Taj2OTN/5SqpPXI9jNfSUX937gz8AQdPFoBMHT43p1GPSideZIXm6TAlHBdpt44ERRcLlnltRXYDgP0qmvHNUdYkl2lmxtBuScjHLzIO7N34XJe3vS4x1RGYp9Fx2HQOo7kBCPD3ZB119YLEiv/FMuwo5jx+zr7FNw+L/MzMPrFeKbGQB4O8EpTTyGS04oTjG3FjjL4l3jzfepPKgxRjI4plAcW17o16B7DlVEdx6ZAcr+7RnOMbo/GOC3xfTffCR8oZjcAdhdmFV38PttnjUQgNkxyhK2pWrutbYbiAZFpH/UyIuASIZr9RUApJBA1p6LPdpcYpzlLf9INnqoRxVF6HHWUIu9zeztpRykgRhz3aBzFpp/FS0quYwy/qa2929MPirrxx77ZcxiaWnGe5sXKN6ajtqj8gHwB4=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:50.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b98653-c617-432f-a4c6-08de0ff7d8c6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB1848
X-BESS-ID: 1760978634-303027-28481-63652-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.66.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaG5oZAVgZQ0Mwg2dLU0tIg2c
 zA3DDNNCXVLNXIwDLF0sg8ycjQ2NxCqTYWAHYa/19BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-215.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Enable exception path for unmatched packets to go through queue 0.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst        |  9 +++++++++
 drivers/net/ntnic/ntnic_ethdev.c | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index 5375d89a2d..01b6dca652 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -136,6 +136,15 @@ Multiple arguments for the same device are separated by ‘,’ comma.
 
    By default, the value is set to 1.
 
+``exception_path`` parameter [int]
+
+   Enable exception path for unmatched packets to go through queue 0.
+
+   To enable exception_path::
+
+      -a <domain>:<bus>:00.0,exception_path=1
+
+   By default, the value is set to 0.
 
 Logging and Debugging
 ---------------------
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 01b3fe00ef..29508888a3 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -73,11 +73,13 @@ uint64_t rte_tsc_freq;
 #define ETH_DEV_NTNIC_HELP_ARG "help"
 #define ETH_DEV_NTHW_RXQUEUES_ARG "rxqs"
 #define ETH_DEV_NTHW_TXQUEUES_ARG "txqs"
+#define ETH_DEV_NTHW_EXCEPTION_PATH_ARG "exception_path"
 
 static const char *const valid_arguments[] = {
 	ETH_DEV_NTNIC_HELP_ARG,
 	ETH_DEV_NTHW_RXQUEUES_ARG,
 	ETH_DEV_NTHW_TXQUEUES_ARG,
+	ETH_DEV_NTHW_EXCEPTION_PATH_ARG,
 	NULL,
 };
 
@@ -2260,6 +2262,25 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 			NT_LOG_DBGX(DBG, NTNIC, "devargs: %s=%u",
 				ETH_DEV_NTHW_TXQUEUES_ARG, nb_tx_queues);
 		}
+
+		kvargs_count = rte_kvargs_count(kvlist, ETH_DEV_NTHW_EXCEPTION_PATH_ARG);
+
+		if (kvargs_count != 0) {
+			assert(kvargs_count == 1);
+			res = rte_kvargs_process(kvlist, ETH_DEV_NTHW_EXCEPTION_PATH_ARG,
+					&nthw_string_to_u32, &exception_path);
+
+			if (res < 0) {
+				NT_LOG_DBGX(ERR, NTNIC,
+					"problem with command line arguments: res=%d", res);
+				return -1;
+			}
+
+			NT_LOG_DBGX(DBG, NTNIC, "devargs: %s=%u",
+				ETH_DEV_NTHW_EXCEPTION_PATH_ARG, exception_path);
+		}
+
+		rte_kvargs_free(kvlist);
 	}
 
 
-- 
2.45.0

