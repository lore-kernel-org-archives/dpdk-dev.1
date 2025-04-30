Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B85C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEFF640653;
	Wed, 30 Apr 2025 15:49:26 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0DCB8402C4
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:19 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2113.outbound.protection.outlook.com [104.47.11.113]) by
 mx-outbound21-53.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jz0l2SbFmXrUhL0+hKDp7iOeX9+K53W5khzx1Kc1Py6V2W7wqMCJp59TDolJCgr09CveWUjY4DB3AvvfPur8ohwxzr2VULRTbbep5S06dMaA/ycabLH9qtRezI4Brx3TZqp6KhTFWj+X36TXcvzsXYMwKnjEOwT5oq74V8TCj/DlBams0x6t1HbBA8qrK/qFRnxqRrwTKm1b2FzaDQZk4K4evA7hl94QVVakNqnn5F8L4ZkgSbCdWAfjAiz+tQf2nTPM6Rupge8f38wDCNV/7JjYzvNtAUczdcT1OZGcKx1vSWz26ueibEGlXOxbHwSVTGmX/uKpQKElVs5yzNRqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCeFC95RdpYADCEkC1WlfZ1rrajHYUVWIkdt/H8bV64=;
 b=V9AvRVaI6pxHpjnUFF2LCRvAEQo3EUSLaPv0bizPVaE/eDaUr7E9+NpXNB4vJ7h9C6Bc/2FwmNOYj92TnAbYhgQ7FDWS4LtDolouj2Cw7HP6JOuwGg/WDzqidP4pmbXdMtfT++O48kUQOS5E0yyFAj3DowRgfmLKbBuNdggB0+DkMmaTgH2aKUN6ZAWH0TeI0w3/ChomvhHIqq3q4zfyxGZhnet0wEoD54foL5mYqfhZXigAWVYktoi+zY37UqdqdvJRn1cjkE8XH4P0wA8LVpUL6LK/FfINcT8u5lOKxKUBxf/DVILzFhXck2YTR1Z1keSrTSKjO7Ma1v+oD/TaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCeFC95RdpYADCEkC1WlfZ1rrajHYUVWIkdt/H8bV64=;
 b=mGfWCD9E8JmjFuK9y8nkTb6+DodDaQ+S1bQkjrc+K5cJcR86ji8dZqsZ5eg7zefWdnL437JCib6TwbXvngrBpoj5bu22BNJLG/j2HYwei6Gf4JzwKTZoMJFU3KwJu6T9Ha78PxTrSgauWMP20U2/j9CDGuNWgrbaokM92Hlq7/w=
Received: from AM9P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::28)
 by AM9P190MB1074.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:272::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 13:49:14 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::3c) by AM9P193CA0023.outlook.office365.com
 (2603:10a6:20b:21e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:14 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 13/25] net/ntnic: add explicitly specificator
Date: Wed, 30 Apr 2025 15:48:25 +0200
Message-ID: <20250430134840.402553-14-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM9P190MB1074:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4db8defd-08f6-4f40-2f23-08dd87edcb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?daufHvNKKrCkoeCfp/qS9xQIcNiJFTvwYr0WIBjTSVXLHKuSjfwlHx/+WXEe?=
 =?us-ascii?Q?k/THnlZEW8qk+jgHgrLezMyI/178iOrGK25uovNK7GRV6WWsEBJQc+HqG73b?=
 =?us-ascii?Q?wRkm77d20R4TK6S1A/cST36QecNZLF/+2aglArMyC4cUeTGzE9VLSvZp25Pj?=
 =?us-ascii?Q?nev/SIzw+BKTvKpODqsoPSjs2IZ4x6jvKF0M3k5ecvVTIS5E54TEna8nQph0?=
 =?us-ascii?Q?b3vt6GgMmKBUUHJe+ziOrIo5o1kSQX98g/nViZGrJOnaWWmcc6c++EngyZaa?=
 =?us-ascii?Q?OMyk/+aChrXT3s8B74+BDKMRJH5wuXl39TVCPUhiGpfRRxK81UxQqJpbIT6p?=
 =?us-ascii?Q?O1XsBx8HvNH3I2M427atxHLZnjQniWsv0F2SiKIp2kuXhgcqbz5fKBMap0LG?=
 =?us-ascii?Q?qha/WPLQerCOjLxZS97UGTrvgPXTXVdDjbq3YeKL4HZr00om8OjkLxTCJr8o?=
 =?us-ascii?Q?zdkjkEgKzfsVdQ9Ln3JCA35b98G3xczWu0olkJvd89ubP6mNLus9i2/6bxtG?=
 =?us-ascii?Q?CtKihOq5/ZZvr8YkoiWUSO2M2sqpdeZcWbGO4hPEV1/rCgMY2WcAU+LfUqqP?=
 =?us-ascii?Q?e/Mm8YTY2PGUHai5yIkTZEYh2Hg1NgmmKGVu5XcR4+bjiXail8oInZ7juAl4?=
 =?us-ascii?Q?E06P2LtPeJ4+IYqRmp361cw5+cFhZ5kq2Tktx0UrJxo9PdQzsZn6iy4b1qH4?=
 =?us-ascii?Q?tprW38Q+sBcQtN8MTHr/14C5y8eiGcL61HlIHd+DXOTCjY7s9gDpQPC1SGI1?=
 =?us-ascii?Q?CwcRqNoHG6Hpc5ckYf7NZrTxO9A2Qs01u2x7NOjluWqn0FJlrlPvKh6F77Yp?=
 =?us-ascii?Q?2LIcC3ASNmBvX4szItS/6exTSEpLSNxVmveF+VJqMOTXn2OMVfmN6UGTW2rq?=
 =?us-ascii?Q?XhveMql0MlS4NVMCBTRqJIWt5E8PdD0vs1qXhCvhqMjVq7C1hJe4ycjA2ufk?=
 =?us-ascii?Q?b8BZjao5/uvNpVjNxa1qTIPhqbEedvWiPsvrBlWkbX6KFMAGZGEMk3i/77gj?=
 =?us-ascii?Q?O3Qa1W7jXkBq4msJq90qdnNRiLYFyVW/CF6MQSK93oH2rN3oipAVb71JAJAN?=
 =?us-ascii?Q?mWRk8BtqM70SCJGewFJCUPjCuCJmiydtKybzjtGtUmGFD6+hle+eRDiqIuNa?=
 =?us-ascii?Q?XYXE0Mjjq/nAloU7WMzdiv7n2O3eWM6QW4X8I/wFBDkEM/xAHa8vSj6U5r2i?=
 =?us-ascii?Q?KYyDuZzEUdtToW3e0wazSTjulNpsravSmTALKC7SL5VwsCI/DpFyHikvyc1J?=
 =?us-ascii?Q?6c0Urf2stOWSEwkcg1L9n/snWEijxjX9RB3lzoXnClAgl3QNYmejKCZ5J+A6?=
 =?us-ascii?Q?8n3+PcgzXVA7CSpDW3f2EYVTSUPgUCpnNt0R882m2Ip4YC9e/pYMzo2JZIjJ?=
 =?us-ascii?Q?zmGKyDQ5LvgX1USEdS7UxVLBQzlTqOMHK8nVQvjRmi+ORgNFr4w1AYuTqYQ8?=
 =?us-ascii?Q?46Uls1Ye5sQqW1ax/fiYKIrpBFg2dn1LrbxbaVX62S+bMj1zreXIN3L6hVsD?=
 =?us-ascii?Q?e4AyovE5VShMVoi0SGG+SEZxdlMn7ey+yCQT?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: knHuU/Q3bggtgpjxfswkCZiR6kMmuoG7ZqxTjxhhrW9Yal0UMDZAkdeqlP13JQHCAFwZXOMe74FPg82A/37yrKTA3jhyYmtWpZTS+DrfSZuvf9e5td5mY/ScwJins+WsLw6PLhHKxXWiTdFii12YagUxJ/n55f4EY5JxPTMpU7ivWg2Vis6t08Mo+INfNHiPabELUvMKDzw8mT6Cq5IG0Xs0V50tgDKMWcWjTcaXUkJdJhPXTSuTpHIu3+GsufpzZzzbL1O74uPN+jTT3dYQU2AI0JWk/pT+NQQQzAW08JjHyt8UNR61WMFPevnI1qjQueHqMgFbU6+usPF7PEorOgWiz46ZeuKgcUMOzd4jRMH0jAeeu8+WWKA7yZYD41iA2Ey6mD2axieM0CL6Emn++grwk7BptzQZkQfWR7B8We+DRwSC7upKBIy5a1omG6Me7AueQq5nW+akKG26Sb805Mx8JqVyYb/RmA8zRw5J8lznjlZAYWymsBeqFtsr+bihpcVPRAXTSPa6jDgs0H/p/49qaHSXf3P0StVylCsGQ7qo52S9rJvH31gQGpfcjpwHJPhxmRtMUo4BFddqlVFUNEVLVJFtAec0iLqm+TW3wn4Xod0QFbDf5/w+fK9+mEvX3rKkeVU+KvyGLuiVujzgYg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:14.2631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db8defd-08f6-4f40-2f23-08dd87edcb49
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1074
X-BESS-ID: 1746020955-305429-7636-9233-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGBsZAVgZQMMXU0DDJ1DLZNN
 E4xSTJ0NQw0dw0xcDSyNLSIM3AyMJUqTYWACawr7FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan10-46.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add unsigned long long type to the value to ensure that
the value 1 is explicitly treated as a 64-bit unsigned integer.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index c674531396..3fb867c993 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -114,7 +114,7 @@ static inline uint64_t convert_policing_parameter(uint64_t value)
 	}
 
 	if (shift != 0) {
-		uint64_t tmp = POLICING_PARAMETER_OFFSET * (1 << (shift - 1));
+		uint64_t tmp = POLICING_PARAMETER_OFFSET * (1ULL << (shift - 1ULL));
 
 		if (tmp > value) {
 			res = 0;
-- 
2.47.1

