Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C066C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 252AF40A8A;
	Mon,  5 May 2025 09:13:43 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 56E9340685
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:39 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2237.outbound.protection.outlook.com [104.47.11.237]) by
 mx-outbound16-191.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHGrHlD9h+QMcWAw1+63k8TZBokER/iMVAgIXFr3EbLOFeqUMn1EndeRr/tcx18TOpsaGhDPMHgPkOUjvtiDecqc0wGvVtBoYi/9SR80Wifze2mBed5drrXbf/i7Ac7OLi9YWIQWWDtu5IMTSr2vdPum9RBr3DJYr1xyhXETawrp1j1m4Ey5Q997MWLc2YGpSnWM2Nm9fxrN7Q8OOIoXSp0XQ9ypwjnLm6CXfP8tcP6nM/t93b2QF0j9TMXPbIMIx3/vnqVDRq7r7ourQY3qHti8QXbwXUX6F02xyThFvskcpZ3bshKGbrJiFaI7yFQHCGx27ZiaBLe6F6o5cfUIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIrISKNU4hn+swioLwqTypCJ7PpEMe2nz5PWPpIJKGo=;
 b=hU/qLsvZe7w4oVpaC7M1Nf4XrkcgyZj8rp9Z6lAJ7EvNl8Q2fZ4j89PzWW5db+iaR7FgJIpQK5DnOTd8C44fi6FO26jfuWAeCwykrmzNsKT4GzNHmElvGUEcPvmn/BEva415NTuSiVeXP8wwcq180pmtVO9AH5NStr9fcEgJnIvV8dmcJYz6TrXYNZGOhcl4L8j4tu56qm91CbZQwfDVV1v8y5euOwOzfC/QtgG99uMgb+BJXbcMDLnKu4D5tOoUnCQK/J+/354olj1dBqkE3mChkE8ptyvDiPON3z6eZb8O3sL12PMqwoLPaSl3sl7cfLpb67wVmCaRGXG540y80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIrISKNU4hn+swioLwqTypCJ7PpEMe2nz5PWPpIJKGo=;
 b=HvJtGLBE3w05iMKqctR6li63nyZy0LJgfFgKPREymC/svQO2LljDnRIW6SsTTDL4czEbMcqmQY39XmgfsvTrLS2lKZ+FXYT5j+k3R8k9njJSCJDVJv/nQdFQaALp3cdaHRRrC7SsqKKiGn7ty/HkSX/VtuRbQYArDK1oAKDdaUs=
Received: from DU7P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::11)
 by PAWP190MB2191.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:46e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:13 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::f0) by DU7P191CA0018.outlook.office365.com
 (2603:10a6:10:54e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:13
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 02/26] net/ntnic: handle string truncations when using
 strlcpy
Date: Mon,  5 May 2025 09:12:42 +0200
Message-ID: <20250505071309.586015-3-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|PAWP190MB2191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee9e7cd0-16ff-4fc9-cebd-08dd8ba44c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HkUigztmD0kq+grQWlg4Ure3nY5eaNnxzGA6EjShx+Tf8uCzVSL1N49Qjwg?=
 =?us-ascii?Q?RgHMwxRTQNx4db9iFBFKgIsx8KkGZp89hrU8rGIQpxpJKFipN5GFgI04P0em?=
 =?us-ascii?Q?NDG12QlF2/2qFdU6sHTTaNSsj1mlYamvr4IZRZX30tAbPsJh8HCBUvAR8LeB?=
 =?us-ascii?Q?Bh+7CZ7t8OyqmhfCzxnt1oJQc88KsEX7vJ8je2AfN5v2duYDIwytmJZrD06N?=
 =?us-ascii?Q?GCFMq7/04NhcyPPgIQ91Qpz/M+bDJ2M45gmlcM9YtwSS7EAE9aZdXHkALSdI?=
 =?us-ascii?Q?KXyVaAsKpKHxQadMj6j+SlyLfq4wroeycCr2K8p3XxISG2KDPqmIi1L9LnhW?=
 =?us-ascii?Q?+nxtHiTc1r6CwBruwafsammFORyZ2cmgxl0XDLJP8GsT3/ev+eZuUkL4t76r?=
 =?us-ascii?Q?MqWsaDxwPD7ZCxtlzbNNnekpetFVOjb2hlpQrb4BP4DOc/NxdkgEl+lET0R2?=
 =?us-ascii?Q?WIXYwwf2eXa1J2wGR/QOohXIohqzLewF3ny/ct0jTJ/1oMUR75kD7nsPm9Ox?=
 =?us-ascii?Q?2Vh4kFe0+9kX7gOUQjsZj3nbAMR4IFNz9J4Fo1l9tMSRSpJ+gFGrmetXF/bv?=
 =?us-ascii?Q?QHJgoQIdvYiRYdv2XqCCbOkJKXDACAed0ahFAz3Ru5cfxs1kHYaBPm+/6K19?=
 =?us-ascii?Q?K816sAUjxDKFEYgdlP2iC2lO+owaOpGKA/TEJrBecvAI82gsW6UAVZSMqaUV?=
 =?us-ascii?Q?xxfWTw8sdIPkvxc4QJVEQoYHsKk6UW97RXCcExiH78kbc2WiR8uzY+KdWwON?=
 =?us-ascii?Q?ayVAzR3fNk7QogXRzI4jWlo/h2EDJgjBbjYftoUFa47fSLCNoGSPUlAexoqz?=
 =?us-ascii?Q?U3QH+qmQ0SeauNX8U4GfQUz5uiEUCDFsTepNm4e4+owsssAWI1Trbdsch3Du?=
 =?us-ascii?Q?8eb42KcP9kLhzXvZjt6e9nO2Ltf6sKKJ93+ZnZEG65iDXzIvuiQYiqmhvt+C?=
 =?us-ascii?Q?4FwL6oVToJgxbMkyYwQmoginNVY8afbSk5PIWU5TRpj14fMQhEL29Uk40bJX?=
 =?us-ascii?Q?Pw+e4Gqji9pM05k20bNRCDGGW0TjoHOhijll52AdOOOGOHcz/ntymc8p0MXD?=
 =?us-ascii?Q?J1HlyoBunrYqO+p6VDVFEq/4ZAeV7nBVyxWXrXC8wXPz/ufzACht5gh/qC9k?=
 =?us-ascii?Q?mDDlmu0wF8BSVQMMxHNJDh0QnJjIEdZUYuXVsczNzfgvuPbScf6h2EVyt5N6?=
 =?us-ascii?Q?y1sozJJUQdF0VbAuZMoQf6uabntZcgpm1Xbm5Pjp8f88A1wkvyFh3QR7/Byz?=
 =?us-ascii?Q?Vn8tRkCXfDx98u2I+iL3h3oxu6CpaMf263JI76oRrRZFOr405XC96SHBbZCi?=
 =?us-ascii?Q?CxeytuCYPRXELePnrR++fH8jLtVSyDMAqCgznvfFoFhMHB9JK+Hfdh3ssfmh?=
 =?us-ascii?Q?xOg0F9o+Yx6vpAQ2+Z4SA6PQ/mIqNwrZFvSAam/4twFU/5RpklBnGU8sMwCq?=
 =?us-ascii?Q?fq0a99wC0BPtjEYk5bdi1MpWUdrIv8haxXcvwMwLE60jfBIZWccDveT9aP4x?=
 =?us-ascii?Q?am4J3c9VI25Tkk7qqUDFnpntRpNGIfQRkr8S?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ug4ZuDuttfb08W+oabps75plkJD0hodoAv+O6AB2u0qevSob42+DcFtwKiBkuCQ/K2F/I+J5dku2zQeoG8KeADJwipUHyTfFNkFK7rTzmuUULEkRttbTEiew85TuHALCQD0mzcpjyIznFfj65q39ELryfXpZYSl7gXzWVf0C2N28MR6Gjqm1IosO1FrUrCahjSKet99nlhX+MfuFWZdscqNBGBNhxVHhB2ylh6OCC82b+ZgaNELZtEWPFxIPrsSeCTlWU1sQqu7eL2ewRKvi7b+FMu6MsDMf87Ysc5I/Qd81EhwEj9OQD3LKsc2YnnATJ+MunG+0cNTI2jKGx5ofBatBtFXOnnGFC5fP5fKr+wsejlKw9T155B4k89POzT71N8mNaI8MlE4tmPy2w5UifgKM0qFgY+IqGLBIhSqrvOfikYW/ATQfP+zVViV4fpGCP64N2nuGJRCcIld9aHLuTMvUxGtrOQbMRpEF0wDwGM0ECFI+qjH7mWvCxSpJ/DQRJm7COa2ao9ZU9FR7vEkLXIEKKiBQyn7ccRwQ17Bf5KPtnLWqD8pU3iFnaVJ8uVoYHogEumtEn7SPECDtsoSVvfWYr/km4v95VIxzvYEiBHAZErW8qAD39zmlOzTVFJlVWlhKqPECiHwgYnptqVpvDA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:13.0433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9e7cd0-16ff-4fc9-cebd-08dd8ba44c93
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP190MB2191
X-BESS-ID: 1746429194-304287-7663-5325-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.237
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFmZAVgZQ0DzV0jjNIs0gMT
 Ex2djS0tzAwtDY2DLRIjExydDE2DBFqTYWAPVyNUtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan16-240.eu-central-1b.ess.aws.cudaops.com]
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

While strlcpy prevents out-of-bounds access,
it allows bugs to remain unnoticed.
If unexcepted truncation took place,
the respective warning message is emitted.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index cf3271d5de..a26cf5a07a 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -758,7 +758,10 @@ static int nthw_xstats_get_names(nt4ga_stat_t *p_nt4ga_stat,
 		return nb_names;
 
 	for (i = 0; i < size && i < nb_names; i++) {
-		strlcpy(xstats_names[i].name, names[i].name, sizeof(xstats_names[i].name));
+		size_t written =
+			strlcpy(xstats_names[i].name, names[i].name, sizeof(xstats_names[i].name));
+		if (written >= sizeof(xstats_names[i].name))
+			NT_LOG(WRN, NTNIC, "xstats name %s truncated", names[i].name);
 		count++;
 	}
 
@@ -795,9 +798,11 @@ static int nthw_xstats_get_names_by_id(nt4ga_stat_t *p_nt4ga_stat,
 
 	for (i = 0; i < size; i++) {
 		if (ids[i] < nb_names) {
-			strlcpy(xstats_names[i].name,
+			size_t written = strlcpy(xstats_names[i].name,
 				names[ids[i]].name,
 				RTE_ETH_XSTATS_NAME_SIZE);
+			if (written >= RTE_ETH_XSTATS_NAME_SIZE)
+				NT_LOG(WRN, NTNIC, "xstats name %s truncated", names[ids[i]].name);
 		}
 
 		count++;
-- 
2.47.1

