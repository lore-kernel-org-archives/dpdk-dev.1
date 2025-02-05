Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A621C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A4440E2E;
	Wed,  5 Feb 2025 11:46:45 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0FD8140B9D
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:32 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMf4EmU1UHehiWpw6Y5z8jhnCOEE3w42JUqpLts4JbgVzYrmyNN/DuXYcIbohnkp7r7AOuUtNLSgQJqmurHe+eCsML39xkRzsMtM3lhUMqUWYmSO/HYqyfJeieU2uTFnA0LQib+Ww4ZEFyD05YlWSXUAy1nioqR5GNLDGd7GNZ+lpnsI/4WD/nBCRgmdcB0Q5Fw/SZau4zGQOwhcICwV49fzTrlVEIIcfkNauxmduhdc9eUZ49cmYJI7wLLVSeI4X0A1HZPJ86DiPFUW7ZniarFjBQumE2Rpc6iLYIX6K8rgKJiv2iLxzv92DIc5OfxNzGjZ9Q6k5aA9ZEf5gES8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ0LcvJ+dLcZ0G6YblLrLscnqmnKqTj+WWYHBfGD/Do=;
 b=ERniFhP/fE68xT/q+PwP/82UswwQIInVsFo30s5ownz8w9XKk+6q7X/0i04OBO3u65Zty+ePyBbxaiq0oYpOpv58iAQNNeyncJE18GDbZ+vjKPPVS54bpxz4QjGZSRH+rPnRHezcIdYBtEEf3WFaTZ9/2vutCwMejKOYC+pSrw8aPU9a8duXapdxMBOWh7BeFtMZeCSmQ5LcNnjvr/8IY1uylJ8VzmBNdEXkSm8W8QPgQdyBKXQxiDnNmod5rb9j26BR1++yitIHG3AeAuxzDpgaS7CqT7hCxRAm88U8pQ0TsBfFeb9Da94qk0RpTmEY3z+YkdwMU++KnS6ul8NopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ0LcvJ+dLcZ0G6YblLrLscnqmnKqTj+WWYHBfGD/Do=;
 b=c0dfExzyDM/Wn5j+J1qcYXAvtm9ahDjBW3S1H/T0/Dr6ugBpvTNbk7oiOIHHBNeIO2W8PYqciZTHu+ipTh8enbVKsS/mzvJqhgYSdfDK5CvXGbhXDBTydQHy6WIvUuo5VMyCUxzmYNv+Dm8Sa4xsk0liIzx1qaXlF4+ZheXcR7s=
Received: from CWLP265CA0344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::20)
 by AM8P190MB0804.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:27 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::cb) by CWLP265CA0344.outlook.office365.com
 (2603:10a6:401:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:27
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 34/34] net/ntnic: remove tag EXPERIMENTAL
Date: Wed,  5 Feb 2025 11:45:43 +0100
Message-ID: <20250205104548.1533554-35-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AM8P190MB0804:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21592783-a6f0-45f6-e5d3-08dd45d257c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a95BKuGOpalra7WR4N7lk93qj1FOcKNRVAuJ9fXTbkWpDWd52NN94txp5OYS?=
 =?us-ascii?Q?I5Yvu9f9REiqcD1nGD7MuK2eiHWqh9fURSo2Z0g0AxLCXgj6vLUb9YQYFnIF?=
 =?us-ascii?Q?lH2EaABI+Vmn+ljM2T05AVxO+vuu2gZdOrBWD3CwUH48nKanmCisYShGYxft?=
 =?us-ascii?Q?pFi4ua00CQZWGLO1P88Z+NWmuOXMK/qTLil1waD2T+etcMq5mgq8wo9UvZMz?=
 =?us-ascii?Q?FgoQrBQKxjAOXZodLlQ+qFdDFBal4neBz7BLW0G0NFtfX8UHPkTsi9l/Pt9s?=
 =?us-ascii?Q?AEiID4VPucCQ2i3JXs+X6ixfnL+6zMCeEA+5sRs2K26xvRGld00XIkTHPiuo?=
 =?us-ascii?Q?dl+kM4mQRub4+Fh4RVyKBiwM9eX0WxtMSBzi2GRqHOGJK76OntTQxUXGPIB8?=
 =?us-ascii?Q?Sr3l1aeEQHrARW3ckrGj+029vjALs7nfwo2ZLLapkGznXSWQ/Y433NCZMCPP?=
 =?us-ascii?Q?lmFDPKY2CNPw05H/tB0iyxJUFY9jFX9IQN62WieMxWC/eoCISk4Z968Ce+82?=
 =?us-ascii?Q?wyOZkJBAtb86/57bZC9S85b5MbLDFoo5+/zqOSoGDQU5C+o07SwpwVLCjdJN?=
 =?us-ascii?Q?Jk8x2deiSDxM6Nx1haNtcOV9iQvKorrf7ZldKSaLhIxQHWgoPy7jO/2vbbwe?=
 =?us-ascii?Q?e7RnnsWGGqD+KONcQfK4eXxbj6KfnZX1V6lDIf9Oe1VE4i9xryZHpFw8zXI3?=
 =?us-ascii?Q?nNRPJKKNxpVtWIQE+zmSAfKpnNk3BdlurgmQRmFYx6o5d/wo3WOMF5v7OuMa?=
 =?us-ascii?Q?r7YiabwsHnG/fegpY0r0Rp6UYJFWNbPiWR7NAqZSu8e8O0myAKZBVe6AxFil?=
 =?us-ascii?Q?ogcewReKxWBKAMHvpQ+0cIvvMtMp31+CNq7EAXt8USmhy0gXtxCJMp5UjrKQ?=
 =?us-ascii?Q?MNGXPdAgcmjkePW3SgvKdLw6FkwVIT2+xeTvpRTz2asv0iQBwTmTJIo/2J5Z?=
 =?us-ascii?Q?m3g4+boKPWcFR+gbmF688aU2NaqVCNMLmrKpPKoU2jnXPzrORgkycjNLfNFe?=
 =?us-ascii?Q?TliKDQ8kzqD2wToP9/Ki1CyRW7TxP3D+ZHGkdcNn7Hu2dm3ZA5OL1y5KzwFV?=
 =?us-ascii?Q?SI/pziUhucQHeppm+ncfuIlJAFX+XVi3Q5z0Szx0sZ2ewzRWPDQnd5PldLNd?=
 =?us-ascii?Q?ob9M8xP7QPOS8yhkvfHaAUnsvD+bQZGqSOZt8fUEQYkF9gnCrRVnUmxTBvmz?=
 =?us-ascii?Q?5Lr5tPiB1i26b/GSWcgiRBSUJYaatrRh8MCLpByxUbcpIBPK2Ehwdm1nvk9p?=
 =?us-ascii?Q?M5W5SnUD+Gty4Hi52OObbb6cS6hWUGOdkRg7+guL4CnfyZcnNd1Ay8SIYD+P?=
 =?us-ascii?Q?zkrYMFG77hSPdv0Yy31UoOw4CHW4BRN5znvgiI81MrlWywGKxFH371ZQUDO6?=
 =?us-ascii?Q?ZAM+yAX9zbLj1u3W7Yyme5PCghA46JkUH98XYXtZUNhjQ1KF3u8UyAOZKE5Q?=
 =?us-ascii?Q?pWLfnT7Uzo96Boq+9FXW3JBXP4w3sP79DgLe1LL3SdxQ3lsqPTlrANtfhbY+?=
 =?us-ascii?Q?0KvP+NdzYxM2Smk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ilK1bif/xEaDONv6Zb7goh2VlKug/p5aC+4muBMksicqoqpBX8/G6d3K6SR3OAbbBXiz7cZrwLIgMH0sGJuB/bAUwjcU144eRhQdK72ODoDjqtdpzD5BvXVBgEnMwhEJoI7ACOA6/ZIvqGBQNFgDpWpAoJ/3OzM/jlSNKez2CvpsuwrqiDubDB444wAwBGbx/lhfJCnC9IH9LdRdsRHKG8GpOKUbqXItln8BszTypzJMe+Tki+QEapIHaDhLxN36//C3SFenbaOzXjHh/06LWst2H6u+jT0+wCe+4kyQeW/gQcaAgpR0HlPhwaZ4TpNwE9LHmKj0JSYQ9KJJcMlOvxajF3gOJXZW8mXAqU5znLzE9a85sgxrT7T8gkZ4UX0nXPF2wW43fLNXc5csuuKlKXd1TjsPJXhf0SWgCH9Xg4IfEV5UebWgyJMmFswGUnI9muKiyKvh+btf90Qqu6LMwOl35v+kJJtgCh0s3EwzJNDK6Ig4LTy6CxjWwJB6SDvZYnB4orvfYLz4U9rtrP4v2HASSnEs3+NhyS5jY7EcvqMybrh2pi3OPvcMW3SQJ76f8D1XBzujhMhW55s6GS7ry1xqOQufnRBLJ0Zplj9ceydvgJTzj1VWpbmK13VJWRpcZ1m1RMfXeNNIAeedKM/aQQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:27.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21592783-a6f0-45f6-e5d3-08dd45d257c7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0804
X-BESS-ID: 1738752389-306009-7768-641-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGxkBGBlDMyNTAKDnVNDnVKN
 HS1MjQ2MAyOdXY2MjC3MQkycAgyVKpNhYAVV+ndUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan23-176.eu-central-1b.ess.aws.cudaops.com]
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

Since nitnic PMD driver for is fully added and verified,
the tag EXPERIMENTAL may be removed

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b86cdd266b..b04951de85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,7 +890,7 @@ F: drivers/net/octeon_ep/
 F: doc/guides/nics/features/octeon_ep.ini
 F: doc/guides/nics/octeon_ep.rst
 
-Napatech ntnic - EXPERIMENTAL
+Napatech ntnic
 M: Christian Koue Muf <ckm@napatech.com>
 M: Serhii Iliushyk <sil-plv@napatech.com>
 F: drivers/net/ntnic/
-- 
2.45.0

