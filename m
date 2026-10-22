Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DB606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PjX7uSUj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B62040264;
	Thu, 22 Oct 2026 18:49:36 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by mails.dpdk.org (Postfix) with ESMTP id 3DB894003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:49:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGu71plz2+8BLNFKaPcx1h26B3y+bt4Vziod1T+DARml24t5dQ+nsW6Gsf8/GrcXWIW2ZCnFS1MqUkCIC2MUjtUDAto2ezpj8VGNspJVSUXUw9XPfWY81w/Dz709iDDlDrFS+J6+nBS82RB74nyy2c2XG2/Maf/wDGkrgPtTQvxGsO6dK7hxtlaijewFNokq+cj6V8Jv/RTj20WALoleCVtYlKWTcFCWfH9G9yecrTisnL6mNZManDNpRg5WiH1jDuRgm+WxMPPDC4OIXGU/8c55eDmDQJD4BY5eVQn4ezgYkib2BTvCeT9UpgAIeAm280+6WS1H5V5aheIYBtN65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gHEerst903RSJiP703DaZgAvGDYI0HyPqYG62fDkOs=;
 b=OT6WegHyJl2VzzWVtVLpcy1ZTTyHN2uBPzzHCLfD25D8sBGu5EQTegnmloWzdZeRsFvAOe04XapLfCavyA03fSeT/zfdDLwmP0zdIZgd9YaqhAA+duKk8n/F319Tn60rSY52cHxtojxBKFMmE96Oh5mFjdhObhwqK6PlDxkMPIbXJVbgRl363zcQ77qdfU4J+TcIs/+RO6Q8XD32AGU3qh3gf9yY97/BT6Te5b+Gm7NajCAvHcBOPMcpz0KFI/3EYyphR5t7l236HTYunC4VTIbzlU1YSWwn8AR6UUoqbED3tAh7gYFcfFXkHcWl50767xhpCaRox/5t+4t6E43kMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oktetlabs.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gHEerst903RSJiP703DaZgAvGDYI0HyPqYG62fDkOs=;
 b=PjX7uSUjAvvYSlFOx7kRRALO3bKT4WH7zBOzzds/K2a2WMPyQvB14B8Uip/YhwLDvoyJH7AfClivYnNAR1j+PndzVywH4wyAE6Efj+Ja4XKKL8NGoxBf9rssazZSoQbBLoOec3gAHlle69c1Qs40CcUvq0xurV0pQW/jigTJytNLCHYrLIoByqwGI/0SFvrxLLobMvyR+wqmOk97TO1JvI0eUnImOeQf6ByLEsWZOHPdogaKJlaoUhjGYDL/PQk1VThPTeJMWS13Vbze/iDcqe0pEMT+DRatWP14bhl+yYl8yQhCMjJUSadfx/9g1vr1A8fXK2iwOdGonKyCqvYlIg==
Received: from CY5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:930:1c::7)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Thu, 22 Oct
 2026 16:49:29 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com (2603:10b6:930:1c::4)
 by CY5PR10CA0007.outlook.office365.com (2603:10b6:930:1c::7) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17
 via Frontend Transport; Thu, 22 Oct 2026 16:49:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 16:49:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 22 Oct
 2026 09:49:04 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 09:49:03 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>, "Konstantin
 Ananyev" <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: remove cache flush threshold deprecation notice
Date: Thu, 22 Oct 2026 18:48:43 +0200
Message-ID: <20261022164844.34845-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff43fd0-b3dc-4dc9-a6d9-08df305c6fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|11063799006|261009223027099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9sr3y/iQ8fnKao5keRGW/h+wnxIZ8E1Ci4OJAyB85XHzxsC5A3iGgzJ+xPiuOGSODk8HkuC5UUOf2URsy1n3HwmSf7ojNF5bGyQSPH9o2H/VcwTjQrugUSD8UifvgDIsMoVhNIuABrthC//FPODk2y2tZas+8fNvGrlrOgraUjAPnHLdX9R+XlbgXEr0XUid4t2/8v9N8/aXLZ1hyAZKQpOWYT4NrMzsWC913A7TKt5hawwduAfz5tRTnK4GXXKzuhPJj7Q3njBFwaeqQ2U6MKsHvd2zV6MgdjnjT/nuczSs9FXcxMMYb1M8sfEjqNsYVg1vNhK5we7cyBY4fLfefZyZCnvLNhM8mLHdLlzvdhNTUNdib96NTuzpUlypAxE3HwqmE/fLQeDtptd/DYNhFGWgJBXV6pnBm2Xp8HSPSWK2EMPxL1tSVbunaPfLI/pAgYKmcJmeoggLM6MW5ci4qPIvt+n+RpOxvFj8JqWDSwwgNTpUN5BahAIvbPt1Az8VXIndr04ba9ihKBlUrjsY9OHGvI1A0u/ArUk3gx2I86muI1JCWMgi08z52Du2iWJqMri0soUWq5FSPfTbWrPjCTwipeOOWZcX4b0LdY6hHWNfg7EZ4jZn6/R7ySGQ0dGxzaWkYSAHjI7W7toE91kqVGKFySrQP9eRnBPYJuOvKTVrhKqxOs2I7t3SyjypzkpXYK6Q8SLyvLESt4ldyLIjAw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pXe5+ySDxHJYKkcgtgeO5NLKrbv+e6iPZXFCC1OvODnc75wN2pJNzecWdFuC7m4ObG/X9GRegJSwYgc/mkv9Ja2lGi3NEMlw4aTZKq+qOGNR7vNksZC2w5pvt7f+N9/Nkwo6eFuYds8unVajbkhC/n+TstxkBGfZONy8ogU8XcWaisiIsWhXtGnseClZCHX20H/ZVvFbzDArKu6zCRPzYCmkl/1fpIpleChbRF8511znhPlTB6tiL0kDb5kPWghEeA+Cns1xJDbg1B/kq8ddBSpDEn26h6uPonz2xzI02K/IQmfy7pGUzPpfHt1Bm9h6r4I96baE0K/OIvv1fkBX+E8NQ9J4Pz4TelTVAWYrEuRHEHI8ezmhN49Jp4SLJrXzEqIRPp9uQTv8Wt2YcbZQ5tuQxjl459NbW70vhFYZNezdtBpcuP3N30EJmlljBFCq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:49:28.1164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff43fd0-b3dc-4dc9-a6d9-08df305c6fdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the deprecation notice for flushthresh field
in struct rte_mempool_cache, which was removed in the offending commit.

Fixes: 7dbec9e69c36 ("mempool: remove deprecated cache flush threshold")
Cc: mb@smartsharesystems.com

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/rel_notes/deprecation.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 29fb7d56d6..44826a0cf2 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,9 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
-* mempool: The ``flushthresh`` field in ``struct rte_mempool_cache`` is obsolete,
-  and will be removed in DPDK 26.11.
-
 * mempool: The object array in ``struct rte_mempool_cache`` is oversize by factor two,
   and will be reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE`` in DPDK 26.11.
 
-- 
2.43.0

