Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249B606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m1wuOoIG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90310402D1;
	Fri,  6 Nov 2026 06:54:49 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42]) by mails.dpdk.org (Postfix) with ESMTPS id 64BA840297
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:54:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEWBgTeKIzbqYhb1bTwwEhB0Z/hj412zrShY6DoOUNrW5NQ8/nIVN6SoecnDvs1iNSZc6Ys+PhW1/SzAKggxlRo5n0Iopc0AJiDS9thOAlD7BmZGTlDIC2HqGNP7jYW7GIWnGTgycjc5qRmXSRPIYAyZ6ENboS019rh/ZSNbGOAljwec/s1b85Cypjt9kvUIb2b0XgM5EgPm6r32nIFn5qTioB8lwvYXF0VugJyuK0apoFAk/ijkahVbalAiaGCiUG+zu6ha80pgfrQYMw2gNjeirkZSazuHvEbfrodg45g741kIIA0Gyh3ckdtUU32GqamKUXcicbzT+eUXD/f+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/4qvFEV3DegFihrrEpt+5Ot/QCFrO6xG7C9T6s1LlE=;
 b=cTdbq1EUZLszrVUXRr9Vz/1OyDHRZ1RfL/Dbh2WXlx0xYli9hxBJ3BVv0KGg/bqSOvQY0KkLRnTXneIeUX5lKQB2RZksulgCcqynaoN28O0bqVUQGqXEpVGh+p1kJaAD1HyEPVzXI5SgAehxrUGqnWLIJHaAmXm1uuPbRRV0GHKG+qZi3/BwKaN0g9QIKYMso08eCdnOcla3B566SIsM2aCoYpvsAun9tsxdp6WqUKzpXljikZhlk9ftqUuOuHdcCinmASd/DlJhEWeBTIR9GpFflygoeoYyBX4JZ0BO8u5p4lbGL+w/a6MABqPLv42yGsI0tCyZQlCQnC/sTGdBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/4qvFEV3DegFihrrEpt+5Ot/QCFrO6xG7C9T6s1LlE=;
 b=m1wuOoIGsLToX4JxiiW3xRLW+pJRKOAfyyK7noaK/jRQk0jOUESdYsKR2aU0RaJneZtxKJG8kY0IDb0kp3jgV2+cDzfPwadwJ4nwus95SwWqqBE1irkPfnkQ+U5zH73fGhkU5IkO49lzHxTKl7euOMwcIeeV+M8C43CqHZjXe/Y=
Received: from CH2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:610:54::17)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:54:38 +0000
Received: from BL2PEPF000352D6.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::80) by CH2PR11CA0007.outlook.office365.com
 (2603:10b6:610:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:54:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D6.mail.protection.outlook.com (10.167.254.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:54:38 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:54:35 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Selwin Sebastian <Selwin.Sebastian@amd.com>,
 Bhagyada Modali <bhagyada.modali@amd.com>, <bruce.richardson@intel.com>
Subject: Re: [PATCH 00/13] raw/ntb: post-merge fixes
Date: Fri, 6 Nov 2026 11:24:20 +0530
Message-ID: <20261106055420.722104-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104132457.78d41700@stephen-xps.local>
References: <20261104132457.78d41700@stephen-xps.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D6:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e8f755-55f7-4d6c-e71c-08df3bca715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|11063799006|261026121527099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5d97oUMGxiWQpZbbBTUIblo9oBnPsIV+yulpERsCtn4QDWvOqHHnllzvq3pMQyyvtLF06E+3jccY+PXiGISPXel1mZOymEGGYASPMPnRmywikWFyp1TjWybSKfgxxOXhjGYUUvfP4DNaekNpwg5KTTlV5kWj5S77lDV0qofbsJOwGZRCmnLO87niVtcqzu99ZMKD+AhNlD9iQdWD/Yyw0EK0rdvbdjRFbMySnMAoQqkf0TGtASo2/RMiElee2ebnJ//5y+sPdEbAGG3GdFjr1S67vBq9X0NEnoU6FbYqYtFz+9WGJuNkVOMOW+xcHFFGUOcGaUAoW6vSCOTdJQFVi6H+tsVmOOxzXw3em1ORi3Y+dTJaUg7oAOQeISl7Wji24XBUtmf0XHXDmIWMaK+QOhDIeIHKMo8vZHHZJgG52WGyZ/HrV9u86OYBIRyBSCX/hMxOsai7ZeQOyKUdM20E8Qc5To6UC8vZ78d9xpkHKzM9l50oEoC3qoK+vPsME9vtafLt+gJXY7R91BIGnz9xQJ4VIblswVJPqs/mXkRnShxro18nwznefqp9EwrnVyES9ADS0Y6UmIHDV6I2Rf1FQLWIg7J49c9OPNSesioW3hvw1fnndUAmOoir2c6WaSeJxbbu9qbfxdmDtHGckbtHBXqOP5usSJSLvk8ye+nwnzwxqxPqzQJeBjzqwbWE+V8uSEZX+mCnM35G1dzM1Ab9eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261026121527099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bsolr841AVoGOIw4yv/aeA3nRPrWMgkXrIYAE+dVXHNEGaIb5eWwSD7uW1Maaf98ORelLxdvg1zNKCHrmv4ded8BewbOZgwk3xQ44lPqNJY0+aB0WbZxmWHabC6XV/P6PRNZyIi0Hr0wO5KvXwy5xLWGHasEnTsg4icCLGPQa12gRy3nqYaZlJAvuO1YdChpl9/beSdTyzePZV/uR2/4AS9egt4kYDvnJ0fXomga1/vDmTqOGHiZhkhUU56RFK502R5VTDTgj9h5eHBvL8BXu3nBwAtyCpYkQCXoMxL/XUpepVLQgIQPFWoDKzm+vQKcrnVpAKgCnCa4pRqbxxAc1MVGzZFahcrncioSks2HXNrO5bvTqM454GtvXwBKi61K+nJhbRRiXWO5zQ+Jw8vAyWHW/MXY5lQ4Y7BEQKIgu/0kRlGoRRT8MTNdySEWYpju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:54:38.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e8f755-55f7-4d6c-e71c-08df3bca715d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

Thanks for the review. All the points are addressed in v2:

- mw_size is now embedded in struct ntb_hw, as suggested (patch 4).
- The doorbell interrupt handle array uses calloc() (patch 5).
- peer_dev_up uses atomic accesses (new patch 14).
- Queue setup checks are added, before any allocation, for both Rx and
  Tx (new patch 15).

Thanks,
Raghavendra
