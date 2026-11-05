Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50077606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c2dvKgL4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3048840DD7;
	Thu,  5 Nov 2026 08:40:16 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by mails.dpdk.org (Postfix) with ESMTPS id 5113340296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:40:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC8yyPSJLsqq8u6UZTaqRhMxxi+Bl/K2HA8grV6ryd0BeLccHEQuTdeBDhUS3N4YOkowM3J+sRNak4ZatoMxMnjffGIy9To1GuvItYy4rrMZU1dil4IQh9fxRrbXaqQxtqj424uo/89XgY+/UwfM7qOvJ55kaLWajIutSGm21GLKzB8iUCCDlXNn2oPWMdTFNaIjZ4vIyjen1aqZ7DlLNG783uTae5jmhXXB5Jz3SFm8Sm6Fs+jcRVQB3lFhdMOKItxnmSxYlDNtWo96FKqewS01tN8XVQPWEG3pd5aTCPdTzpQmCKv9LOEmFDOwjhAG41+8CV5SGX7J3NrX3EPh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=f4QExi/iCDuMwbo+PV/nIz6s8oYz2HXVE9t/VzcZqhlnnbgLJYft6p6YibLSJjjc7A0u5V1pb7+O/d6jA//BCb0wzXtWPLkQgkJ0pDiqptSQknauOHPngSbQ8cjHCTI8d5s0fvTYh9ijwd94JCO8uSNp7V3sAeEHirSlGPK9Ut0giqsi3DmfhJTLqTynxxg+DAJkRlF6MHPPTs9EHp6VKmMOzlwWpTFFlFX3W8futDiPmsx49nt2n/H0pH6Ogp9gOzz62jrzkga5FJc9K6xSUZ/E1x9xHhCcyYqGM+wPBhY7ZaCKHt43EMQvuv9i5Yo6ld67N4DDITrzV+/2lU7dFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=c2dvKgL4TSz0guifbgpOZXBQfGgRKoMz1lzZvprfTtW9RhX0qbwb8PZZSfEtjNxfzQJ1JIoMed66vkG7R+e5s5X3qoI7S6Rtip/Xps8jj/B4KRkBD1o8itqo/6nEIhmjggT+kcuSV95JhrO5JSR9CtoGa0ksSeRa1TW5v0RqrR5VYgIJ7/F4xMCmhrE2m7hljcOq58l5wJYfm/1c2/tykAcRnRzO0oszjnf9avl0dkcmt+nHgSgVjcPTNrASmV74TOLHKi/Omt3OOEs1eqRVg8j8gvpEObBj9NCvD6ZjzEUGikkHWHE+ebbiYJ+zzdoudXXkCX0gkR9sqlr+9XPRCw==
Received: from PH8P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::35)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:38:10 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::49) by PH8P221CA0008.outlook.office365.com
 (2603:10b6:510:2d8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:38:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:53 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:51 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: document mlx5 range matching limits
Date: Thu, 5 Nov 2026 09:37:41 +0200
Message-ID: <20261105073743.20470-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102091526.3263931-1-mkashani@nvidia.com>
References: <20261102091526.3263931-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1a2c28-6074-4fbc-cd26-08df3b0fbd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7K+OGJZx0Q7HM8Ij57JBEhmeZt2UZwUqzhAKDdEYoILO3rmnadjG/v2o/vI4GUhUh/VebcGi5eb080JT82gfNJ0ez2dPGiehpvvcIFQB5L9j0t9kcnwzQnOOPguJw3PJFJUqbmI3QF9Jmld0d9tbIFSf7K9eMSiVkRZ101uIIOulhEKlPRW+QtJ1G+wfSIBRhpDkegl8W+yEq4BSbuHSpt1XUZKuXF3sOJAT9Xc1hh3yvZjyswvX75k65cNeL5aX0CruXn9nloAcVHZlFG250ponftlNM18TfFyuTBr3LhiCMKhlEfZz4idqokBzAjc7s09gyAcfV80CazLPPMaDlhRwB35lLF07ui+qTnRk8VzfjeJrTIE1GBZ21uWf2k0kWK9MUgadud1uvUoltuYDy9MaA6do+siDuFaeUPkaX7rjztL5DzSZW/OAYUIeUXlGElgTz8BlN3WPvBs9tMgVlXSHkeNsgH9F3A26MbOG7KPtkodvWbMSeTOsdKgg7FhGrh0fuko7NwCR+HbWwa2xYFcbXMImo7/QGSO7D/0Qrl/c7g1X3nWbIXhp2ZUU2SuF3vSKPZV14DMT2/tcbUB08OSM9RCZ5JVBbXFBL1K97gXV2LVOlcOEO3iK5QGXi7MRFeNzimo0XwaGdaD7GisY2kDWnQ8PAXAfjgI7O5TmNxHHT+QoJOoVzmaxZuJvHNqPjaTXvmb3TmlAd2PzhA3A0Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 62X31clu2wWsHlCTw0U9S9wDbkSN+bQXhb5fzdGzK1rJ+lnbl1quLEY7Q5XDJ6iOe9FBhrbogjaGSNOwLtS2sEZQAJ98Fcj9fnxlQjJjhs54p5YNRB1jqaXSBxoTZw92vSgFz01AFhVfPCwZUv9/Jbjr1nds99zE0Kx4iPXer4iV7tVIkd6iSCe3KGfQ3iaA1UXUHYlU0tZ8dTWUmDD5P6pB9mTBeHuOvu8y2XMTy3qbVPZzT7DUlZKKfN7op/E50ArNR7k2+QqG7gCgavZ+J5n4X2lzxYBenrSLcMFbsa2rcHkBkmRrTrZMS9Ich53gQONLfIsLdVSAMlqQCrjcd6GlUyBWw8rDx4FHtImGmXOZx4VdVOGCGUIse5NVzX+0+g4iM6sYMNoFUKSo04y8FaREkN5NFRwal9pHB83Vk64c270tnAviS7iCHZeoOxWM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:38:09.8116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a2c28-6074-4fbc-cd26-08df3b0fbd89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
