Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE5C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F41A340290;
	Mon, 20 Jul 2026 14:05:22 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37]) by mails.dpdk.org (Postfix) with ESMTP id 37A364028E;
 Mon, 20 Jul 2026 14:05:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnKKmNJfP36JD+7TNfow/SK+X2uCB0ESQyGX2ViWkrqffoqfcCRVQqGX0WwOug/8qp0lrOda2+kPmIaIoifG323OdWNhL5+bHYfQDOYi96TKux31JTdhEKF5aNq62nPRn85UVHpqaUUPjpSwzQTPUAjqlSTFqomxwPTmnuVnfQEkT2BUW2nSeNf5jNRAHiBftRGL6nHolAPkhFGZdq5pLFFSXtQh1TwrJpTNhrQnH7bO3KX5RhL5qPh7fNNxJeVhVHDcucn3x0TzOGihuN7KxGA2c35RVjNmBpkfrQcTSw+N9D5FJyEvcHhj3F6dkqcFAf+KmDB0BdxUkZCt4z/FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3XZZSEw62kg/rj+7vbYIpoFvHM6EnF+VFoq6WTwQZA=;
 b=X03V6Qvr9EjMU52z5RG6Gyz3HPiYRr8nk3br5QrH2uXVBEftw6b1wNrgNjDxNgS3rr68Wy3jlddY01LWvt8ozVF95Mbrk+ume9pZ7sQBZQn/E4ewia11sgLna+7TxbmirzqbSbuq9BiV52/StG9OMetHYheDGOPKnYLgQtR+taV0lLtMvTCntwNEeg0tWVWYxKuCd5XYoTocBluiN3621KPX31F11RV4rN6cSYpCmNYOKhwWpWKA/e2eBrKnB7Uok7QVrqVrDBBrmeVTcBs8O9qgQx4rhbCVVCoODV3L0T3u+xEijiELG04dznXR34hX2OaX3A7KtQSCCAc+jRt8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3XZZSEw62kg/rj+7vbYIpoFvHM6EnF+VFoq6WTwQZA=;
 b=NGxUsA7hVfgQkY7yBCH9XE94QyQ36wV7WLxEpS1bPlp6vbTaqhJXZVJJAX3DiPrXfzHiXzJ6tZDoznVH+HzA8KqcgNW83TuiHfQWznb5Tnqn/TAhfuAnXkgmw03D1zXsCfEX56dGpliNYxe02knKM2jphnFTdfFHMggqmHlBKAX2UKUjRhMy4CgV0VzH2D+Hk7nwvCctfSNCCyHgDClh3a4k/l1c6PznJevhwxSKR8sc6/ligzs5H+9W3KsexkzcU1mv94mp3qKcS7vp2brxer3q4ha1Uf65G7C2ThN9CXSf9Ntd9zTEUhN9XXqXWASKSFbxLFxtdLlu/HCv72vnIA==
Received: from PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::17)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 12:05:16 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::40) by PH5P222CA0003.outlook.office365.com
 (2603:10b6:510:34b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 12:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 12:05:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Jul
 2026 05:04:56 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Jul
 2026 05:04:55 -0700
Date: Mon, 20 Jul 2026 14:04:47 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Pier Damouny <pdamouny@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Banoth Saikumar <banoth.saikumar@oracle.com>
Subject: Re: [PATCH] net/mlx5: revert fallback to Verbs Tx allocation
Message-ID: <ekuco7abfynbgdovhotzbvbgynu3ldld65jlh7cpxwl4iz2amj@bzdg33appnnl>
References: <20260720114929.2998238-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720114929.2998238-1-thomas@monjalon.net>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: a03a51c7-408f-4286-5db7-08dee6572911
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: e6H2pUjR5Jd1D7Rwm+Yz06AzwbsHT621sU0ByTw0XgoECUnWIQR035QUKpmP3t/zLfj8UOf/bFu6OcPAKCm7t7FFiqsyfpG+OzfNhGI1aSgyh+FKsVjQvHpbvPjI30c/1JCh5OXp8d1WxRs1RfEHuc4Sf+M3EE1yen9JkVqiiWk+1jK9t45t7Jtyaq1BWq5lzsV8NpKuHwSyphi/E7mrQFzX92zHE0dZMr5BT2TkRx8Gw62kVHnhI8JIOFXKeD/sq50bIme1KSCn5j023nLE8JKhmlDf1IhNuFU5TXpDPpQ8BGzOW/Nyx12bqzEYDjXGcPbRT2O16SLO7lXK/UKjA7U+wF6CbR6I/FX6zuenRg1o2tolrs68YYLWIL4mWNADrhqHqACueMuMepzvPKkcxLC/0mGu0e6AWJ5nJULwX4shD4kTfaj4Yno2sZK/ZmxX/Feg45Rpc7IKtJRGk9Vba2LRs36mK2MkFfE1WmFfAkwpqnSF8n6QuXYqpc+L1fqVrljJOjPj1UePjJp5vvNDPVZNFn/I5Fewg87kB00h4HdR/94I11dFhYNtgWwAQ01Z5ydB9SWsDFrMQ4GTNOgaiywwmWLT3g7sNh517nh9d3lR6qjMSyYtK/Ksgh85I9rSdw6ZxQueW2DfxVtDv7tUxwLAKKJoyfgd380b4kwBeTKSXmQ1I7MGDU7ivk8rArgsTi0RIKNdG2OMv8v93tsqkw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DDWw9E4Nl7xqqS6xT8W/UMMWbN+iKK0GNB9fjgvG44QJlkwQ76ZJUYbskEgYHIhY7cnp7lSgqyF0S3N4iiIQDTsPmVc2ETGswb4kjdnGPJ9UXzC+hjxV5kKgmnVWFf1D52fqipnWUdEZCzJe8Qwx+VMz/UxBM1JQ9J2giRRXjlPUjBgtcBoulW9jXi4Yj2yeunADNksP8LtEj3RgI980AlW01SRL7AywOROT/J6pu4g9XuarK71B+FA1DI/kJ1R4Tfw5GXkYWpeZjaa0rhyxdNpPfstH2rgfEgq28w1AE+d6WvMLULMWHmq5dv68owHdt/bbnIhu9l/nPJSr0iLFUzmcSQ67oXrsPmirlrn/AiSv65XHnjw3xKb3OYMyOLmUXaA4PQ8ZeQBNwExqgsUFPPVaQQNVBgS3+6RzcxWCIzkw/+QeYmIix4RWRcDizRCs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:05:15.7609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03a51c7-408f-4286-5db7-08dee6572911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

On Mon, Jul 20, 2026 at 01:49:29PM +0200, Thomas Monjalon wrote:
> On Windows, DevX CQ creation was failing because
> of a different allocation fallback behaviour.
> 
> Fixes: 4abc12b9331c ("net/mlx5: fall back to Verbs Tx allocation without DevX")
> Cc: stable@dpdk.org
> 
> Reported-by: Pier Damouny <pdamouny@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
