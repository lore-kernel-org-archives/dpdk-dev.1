Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934BECAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 09:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9154402DD;
	Mon,  6 Oct 2025 11:47:42 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16]) by mails.dpdk.org (Postfix) with ESMTP id C22F1402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 11:47:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aquvCyynDPo8IVkC7zoYFbnAbHf6nFUML9h+n2wCRTEa7DfUKPdAZZBVlh3Bp0w4bncr7He3juxXP3mi6C5kgk9/LHdc5P/p6Isi1tfoii/HacClQjsBsMDSqaj/Gs/8S7LtW49dPkSmdMBig3Vyf5mgZmqf/MZlPrDVOHSugxZ7iPT+kCPpL3pN46tfM6xtd0G1f7VfyiKSkClqiKmcOpYjWNJWU/h/tcv2Pmdvc/VaxVC5IY/kpFAU+yWU4T72BVrXTRevFysNjtPHk+a/IuFaFFj3nfY3u8xuifed4evNL3xtjKREq/+uZekVKfBA1qaCzX/OMowqTkL1ezVErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYWpGBxfFpdTG43vEKHZcWJ9XIXui1cOC+SSDImptEA=;
 b=CZ4vgEXs7PhddBT0KijBzgMqAoeixM5Wn+kaBUwjYySPodcZDz5Bozvv9T3GkuqQeAFdsZiZijUhvckQJLX9l4gWzK6pB3Y2bWB5pZjWZJIRSxOE6HZBbYF6Par2NshPJNnpm1NEv5vD/+NSfHGjmz9oGrsiU5TT/FEXTvnqAYK9cDUPWVEC+IWeWRhEbc3wtjNyMiNICHo76pll5Y2lxLmhvHr10xq4QntIj/tLDRb3G5tALBvvjrpZG0pbwdR1vtuWAyEtQbYcOlHRUTGdJEKq8Fo53RU/WL3oWsyBKqjE5MLdalmVBcgbB2JbsQBVYdcIoSguf1lBw1nkxeZgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=smartsharesystems.com smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYWpGBxfFpdTG43vEKHZcWJ9XIXui1cOC+SSDImptEA=;
 b=xatYGJ230csiEJclpahO30nVLuwdMsuU6J3+544+sveVuT/f0eOfwVa0e2B7OSCIC2uGCOYCaNyAMgy40H7pp/KM/Io/csmTrYWXHLqI/7r68p9Ho24b9zkyCiJvXbwuPVFqtmg8xs8FIpJPRPVfNWDvf4e7whvhvIZNBkGfolA=
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Mon, 6 Oct
 2025 09:47:33 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::e2) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 09:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 09:47:33 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 02:47:31 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <bruce.richardson@intel.com>, <maxime.coquelin@redhat.com>,
 <aconole@redhat.com>, <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: document telemetry command name restrictions
Date: Mon, 6 Oct 2025 09:47:12 +0000
Message-ID: <20251006094712.180432-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d9082e-771b-4165-6783-08de04bd5fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iB7jQV5P5xjWn7UUPTGpGh0HfjolY/6YtLP0943TM6F5DPrrxPdkoZb8hTVy?=
 =?us-ascii?Q?t2j4AxvDzC8x2+HLI93CnLR5L/RdQHc0u9gFDy6K2LnwYF3bPme50HzsqgF4?=
 =?us-ascii?Q?c99H1PI4Bp9nOO9xURX9xUHHAqdO7fcTSu89Vj6b+rTTnhp3PYsKx+JeDS33?=
 =?us-ascii?Q?AaoJkPBuBDP2HbgP7/EohhL3gDC0tqEnj7e/wmPTuVBEhq4ZyFUwHSB2l685?=
 =?us-ascii?Q?MCW4aQJ5UcRzLwN6KwggRStEfUG/t/TIuaH0HQse9gCaB8A1ZnBFHLWa8mmt?=
 =?us-ascii?Q?iOOsbjW3PJ8dk5mm+weq805ipEFmpsa69HNxnnJiEibWcgQM2e6pj7DMgeei?=
 =?us-ascii?Q?bEJX8KZlfVWUjcETT/9McjV/dDFTwnviR1Yn6qiz0LhTiPCYH9WEn3L1YqW9?=
 =?us-ascii?Q?xxjJkDXzJQMDA8wj+31aOwEMMKgTDOU0GBRueb3NCcCZy/bDC21f/rxup81C?=
 =?us-ascii?Q?9i4janZqEaXcXhVG2zK4cif/Tgr7fMZEu+nrUujLIr060uCpklI7pef6/Joi?=
 =?us-ascii?Q?Xmz8bcQHKDePoDO7najVnR4AHknRgGzLpM8MnzUDyLSTsp+KALLgOhGNNMt6?=
 =?us-ascii?Q?2jTQLyI8EgsofAiwaVeuaTIjJysv9ParX33HV/qrg24GRkHKWQfkL+dRYAPU?=
 =?us-ascii?Q?MEJvRXYN5aiognAOstF/+2q3JGfApkDPAyPIddbsWz4P3819l8GnxqENHnEj?=
 =?us-ascii?Q?pUNpLssnJczYpc1kFVmwFEIC5BYJrnm5pmncXDRPWr6fgErH71b5Eqey/F4G?=
 =?us-ascii?Q?oS2b1oFQLlg22FDDRiAeUV9kDSfVnAH7G8xwytsSxXNVs8K+tOBsQzuGphSd?=
 =?us-ascii?Q?Prq2LvO2SbK8bxWFziV+HqqW6DPbejpZNXjj9fUsdzMusCC9VW32rTfKFznG?=
 =?us-ascii?Q?xh9lpaI9y8+oXRUqFuSq6nsIz1d8+8nY9zNBB1uZ9jqa8XM9H+p26xmmcLCv?=
 =?us-ascii?Q?Zp172rytHBXDnNyWfX9OIvWCS9I15JRmdsIZtsMofa9yDaJkac8ea9YcQPaH?=
 =?us-ascii?Q?mAlp6WnnsjEkw5u/MBAIUafSKIZ1QU9+Vemlf3xbYGzjF6+WchuRLTgGuyOE?=
 =?us-ascii?Q?gszozkV/gFVxsfOcxEcTvHv/H187AaLyfE7KGT+KF7KYuxP4xlQ1nN9B4BtY?=
 =?us-ascii?Q?sd292gLN/xaEoqvq3k1z85eu0lW943e+lEMzDIIJSJ4Pp4xxLUlq8KeLw0ub?=
 =?us-ascii?Q?vYCnNNDueIYJw7OdBq5En3fTUk91u2mx4mr/tmHRF2yHTomiMbo5PeDQtbF/?=
 =?us-ascii?Q?ELnAPYwwmwBRGtozBtbWU7BXZaQbWWoOOBUMAk48ua7m3p/Ef1pXjL27XqCm?=
 =?us-ascii?Q?DIlcNMvTQsXLQb8IL5P4iO9g6VLLiVzbB8BWOkWeZeK7LnEJ2jFMvOSzlytf?=
 =?us-ascii?Q?pbjMJbksVe9qDsWAZK857zTKIkTgngtEEilH1PLqH0XY0+7kDwDpTKK5qaOa?=
 =?us-ascii?Q?icg0Ugei/cMG6zX/giPpwO6Tjt6FLCguNEuSLVrSTWWoAdfKqqyZvv7ZOY6L?=
 =?us-ascii?Q?kW5h7x7Fv8frCIYj8jtQjvm6cKoEP5iWVvuRIV56HAAkKaTNJwOhfWTbdVo4?=
 =?us-ascii?Q?btYShmvVRVPxtpXwPo3FvxDyaBQHSFIa/rNKkhrM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 09:47:33.1727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d9082e-771b-4165-6783-08de04bd5fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

Telemetry command names must contain only alphanumeric characters
(`A-Z`, `a-z`, `0-9`), underscore (`_`), and forward slash (`/`).
Other characters, including hyphens (`-`), are not allowed and
cause registration to fail.

This patch updates the documentation to explicitly state these
restrictions and highlights the existing invalid example
"/l3fwd-power/stats" (in l3fwd-power app).

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 doc/guides/prog_guide/telemetry_lib.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/prog_guide/telemetry_lib.rst b/doc/guides/prog_guide/telemetry_lib.rst
index 32f525a67f..6ae5067474 100644
--- a/doc/guides/prog_guide/telemetry_lib.rst
+++ b/doc/guides/prog_guide/telemetry_lib.rst
@@ -157,6 +157,10 @@ command. An example command being registered is shown below:
     rte_telemetry_register_cmd("/example_lib/string_example", handle_string,
             "Returns an example string. Takes no parameters");
 
+The command name **must consist only of alphanumeric characters (`A-Z`, `a-z`,
+`0-9`) and the special characters underscore (`_`) and forward slash (`/`)**.
+Any other characters, including spaces, are not permitted and will cause the
+command registration to fail.
 
 Using Commands
 --------------
-- 
2.43.0

