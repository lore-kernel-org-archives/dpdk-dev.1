Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6DCCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E72142707;
	Mon, 17 Nov 2025 08:29:52 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32]) by mails.dpdk.org (Postfix) with ESMTP id 69B0E402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:29:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOGfnsuoNPN2LptILvJmTe/nuPmTNc2GAcxC4uRxbACxEN+fxZA9wdh7lh5Dt4m/oZGhZKkRIoijBN9f9EbkOc0mSvWs+y45qvLez+xrrkJW84IsyNDqCAmHJtC30jPEgoeNaZWBPj22OYgdeK5d1wz9RZxXg9t4Pl+g6o8OgEM0Lx0QzfHE7F6CM0BFVzFYsha1BI4shS06Gme8ZTMx55JSnf7IVNWCswON8yhrUOGWhJQI48oqBtRZbEjEOwV2jFji4qJJe235No8Wm3H6ROtH1b07o8KRkrrAV5veGCHXF93poJy8OdNY95IHIRN2MZ3WNDF4RNlqV9O5PgWwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOJvVqyhl9K000YCd9HXLdu6NWUvGutnwXo2lgXZNXE=;
 b=kaDDg41Yd89NTCASICqOCAwEgnnaU1huX0cxJKKGBsMio5kfPMYqD5Sg60CbHsaWHVrwErk4wwEDKZ99cl+6r2GZsSvvevCVDAdTHhu8OxYnASkqY/bSxPcvpB1IWHpwPM4ouM4kkc8VheY+Tsn02rMRiOt6mizCkPDm+DrOMQGvZRDgX4R/r3ZVKYVnS2qfJFami/y/azAXLD5ZIrX+ckQJMBbV5oPl2gs+YSv9nA+d9gbQBalsjqi4we0rOAeJr2d5oNpl1emwvYDopT2vZEipFTRUfFy7WOAwtzvRZoE9y6B5BoNmZSdwVHRdhvWeZpSkC0WGSDuODHgwOk7+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOJvVqyhl9K000YCd9HXLdu6NWUvGutnwXo2lgXZNXE=;
 b=TAzrPs8ZI31TYbY8h/DsDqHq5CPkNH9rIqGrePhRNuGtakFW9dEhZh6LY+KXEZTAeGPsUPc+qYhCnB+mPxg/tmRv5bchQ6xFNDGTFJicqbvRQy3YT/AINSl45IKJXZyF6e+nIWfmIlAUK0P2IA/7p87BfQNVDgGLp3xxk5OjSOtbuPZFAm0KbMaUISXsldPv8a3F3hyOnUVU2b9T9lVPn8+hbWYp4rCG+Wdu5AFwu/dLAnj7t55mAlJU8TLzWMsh15HCsaTKNup1l6r50i7ZjFN4+lTaDPAp5SOP5TCZlCsjkU6prWzPKcf9BOkFiQT7e5JOtuz4kVswSZcPTOrbgg==
Received: from DS7PR03CA0273.namprd03.prod.outlook.com (2603:10b6:5:3ad::8) by
 IA1PR12MB9739.namprd12.prod.outlook.com (2603:10b6:208:465::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Mon, 17 Nov 2025 07:29:47 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::f5) by DS7PR03CA0273.outlook.office365.com
 (2603:10b6:5:3ad::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 07:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 07:29:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:29:34 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 23:29:30 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <wisamm@nvidia.com>
Subject: [PATCH] test-flow-perf: fix the incorrect array length
Date: Mon, 17 Nov 2025 09:28:58 +0200
Message-ID: <20251117072858.9318-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: a832d0df-c7f3-46f6-0400-08de25ab1653
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yMu2FLhmw1LVvM22VB6K6LXJCwnkCFt0FkuGVuzBYGXx3UZbE7qX0dQR6ycH?=
 =?us-ascii?Q?qhg6Y0M9+OvyPVQmSPtgEox3T3wRq2qZ3+U6OV9PnWf0XFcfEiaDi79ndfUO?=
 =?us-ascii?Q?Ef6ARtLd0hLonj790h7A854AXzzN/nzPcGMfL6MSAcPiRHN/lanGhH2ViI72?=
 =?us-ascii?Q?nZPGQJODtJiAHEsC1ZnzzoIDMoSHPqlvsHOGqKZCUdiiYtGoPrThhl7+IdMx?=
 =?us-ascii?Q?9GvfFdp47/2KHc296n6Fj167S2I8C9X8U6uYArPVsrksT9UmqBUmn/biIBfN?=
 =?us-ascii?Q?HzXCVBCCMAIhDVS45e4A94v8ug2eEyWqxVsaW0bh4d9e4mU2mkP+uqSuQgl2?=
 =?us-ascii?Q?0vHUrEiSc1r3tKNKyzz5Gf/Mlsu89jW8uSCBrUv85/oqrYXsz/au8X6JGPd5?=
 =?us-ascii?Q?8Apg5l1u9JH+zHF27D7d9a9UcHIbFJNERaw3asf5qawaIypr4jOswYSjQOzM?=
 =?us-ascii?Q?im/kquWfOhjMUlUOluZr+LWy5vBw6nJ39lvBI7gYapBDu41lK5ENrZCsFhUw?=
 =?us-ascii?Q?HTyEAR67OrzdCCEX0ttGhHm6dMBwguSEY/aHkWW16X/b6LVeWMUFvOYJWO7r?=
 =?us-ascii?Q?YNGaGtvnzngH4VE+qjsaSFXRxNbL+N5lPLtGX3yiZ/zT2UGLaIjXDCmnFLu7?=
 =?us-ascii?Q?HmJ+jMyslATCQIQrWbeOmgjkewlJUMJr9csZBvwEHTeSSvMDL7LEdMubBKzh?=
 =?us-ascii?Q?Y+V4VBJdAss19JO0rqd5NKFqR9eG3YqJv5CD+uia3F8ryJCEP6EDUuyxEpdq?=
 =?us-ascii?Q?kZRhjYKJqON3pgpxyczVe+g/Ew3wGQ129K0q5diqk8/umgxs0B0BIUAtli/R?=
 =?us-ascii?Q?aj4xDwt4ytJ5WX5mSCz3/6I+iANxkep0Y0AdfCnGvkixXILmtxp4DzCaPVcf?=
 =?us-ascii?Q?fwp/B7lmy7Q3f647qlLa/Ctlk7wB7WNz2cqlHaZ81PpeQkLHfhxTlFvQlHz0?=
 =?us-ascii?Q?/MgtgdOLZBp3BhdIiU4JZKxcyIJhmVMFDfu0eFzWQtHnv6q5SAi/R3qTZZYM?=
 =?us-ascii?Q?nklT8fdMGSK+bPVu3tuLdKljln3dlHf7p15qWlHv18soh7fmr8XboM+RrBOp?=
 =?us-ascii?Q?nTr25Y+f6H4UNgCBwP424JJeaAc9lAvejHYkOWs2n3MeplfmGfDwxX0ML8RP?=
 =?us-ascii?Q?kV2BpuiPm4thsvKv4MJz5JSKdXuuAHd8dKujWSrqmILgqZi74XeY7DhK1O15?=
 =?us-ascii?Q?tvrJCHmKKBSuIsHFb4JBoSOA/7634XiwCS/hAinpJaaeufcKunG++/TikD2/?=
 =?us-ascii?Q?87/HaFqDV/fbQ5+sGOLwXDKbid00Az38qDNLeltS/jzNzuKvalksfpsdTQf3?=
 =?us-ascii?Q?obM/2pT2WWiy1SKDQxMJzyq91OHfnbxEVtwMWtfbtxaZ8QYtxcCdZm5Ecwmg?=
 =?us-ascii?Q?YUNfvbfNt/Ghb0NGKn6wjUkCQGe2H1tLIz8zpXJthzG8FfC/vpTG73sWZBGv?=
 =?us-ascii?Q?PbSzcF87u8bBBDbWhXLSxx7gPY65jxnDjFSJggX4MwTFMb5t18RpYrexKvyq?=
 =?us-ascii?Q?AOqLUXO5QXH917pmHqok8D75sWQGLXLZp0Mg2oJXXjnb4ByIUwk9U5bOOREE?=
 =?us-ascii?Q?22TlqVfILutjn7grz2A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:29:47.6287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a832d0df-c7f3-46f6-0400-08de25ab1653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739
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

The array used to save the flow rules pointer was allocated with an
incorrect length. 1 more rule space should be appended but not 1 byte.

Fixes: 070316d01d3e ("app/flow-perf: add multi-core rule insertion and deletion")
Cc: wisamm@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 app/test-flow-perf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index b2084b93dd..a8876acf1f 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -1487,7 +1487,7 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 	global_actions[0] = FLOW_ITEM_MASK(RTE_FLOW_ACTION_TYPE_JUMP);
 
 	flows_list = rte_zmalloc("flows_list",
-		(sizeof(struct rte_flow *) * rules_count_per_core) + 1, 0);
+		(sizeof(struct rte_flow *) * (rules_count_per_core + 1)), 0);
 	if (flows_list == NULL)
 		rte_exit(EXIT_FAILURE, "No Memory available!\n");
 
-- 
2.34.1

