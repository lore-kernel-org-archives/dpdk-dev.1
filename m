Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E17CC88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62F63427E9;
	Fri, 11 Sep 2026 11:42:27 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71]) by mails.dpdk.org (Postfix) with ESMTP id 6CF2F42830
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:42:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9GcFrR9S5qLh9sDHc7vxP8dQJkm50vTQdQ/JHvj9uNgpP468jlMNKHqdker4d6sN6nJ8LOURPVUn9jScKjtwMAzg7u6aoQk/IWGklncdJrIqGjRUmIWt2Lku+Vpw6vFSD+HE/wiQByPD1p6DlbQB+Tc5mLW43IkCpFTdJXOowzGnZPx7L5cFTOlNJvIsnFdlfeszBSH0qHRa8DV83ee+EViNzr4Y1zCLbvJcEEh8zAXdlNherMkCBapcnn8m02XN8+nfSEcOqP1uNIE4hVa3c5EERNlxQK9KP4dUko5NGD02xYe4rfqE1OdM6XKngXT5UwOagWJmUxRY3mHepqS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97gypVQleC5xExbISyQlRrov9Kgs7/tkX1DNTEhl4uE=;
 b=Ly32ODxKL33w7nKjGXjVlVpmqmVPhb7/Zj5+ak6ThamNT7z5iuR646LBAzezljKWl1mf6AsdGA2N3jprd0axT9Mo/u1wfow+QBlQbMqRVY1hFUBJKm27Ued3wiS1Vt0VldNMLvc9VLw0WxrNXl0L+6tr4t2GaLcl3/6dnej39HZKP+QubQ1Aeqb0C7YHqzD34oihtZ6swRQL/u9hIolsBLhGAnGhMFZVP17j9nuDEpjpWSm6dEfKenAmE3DlAeVMzdVQas1gKomm2TrR1opvtIWOYrIBBs69kBDdkZKZ2AecJrlgzsLblDIHmTKN6arieinGYAq3iATsmJZZA02A4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97gypVQleC5xExbISyQlRrov9Kgs7/tkX1DNTEhl4uE=;
 b=oChp1tyIxi8mPSmuWLX89g7gdREbdRW0uXeEP1mJBBZURelLQDhLlcbxOLP/JHb5x1K6sP9i1PnmXZ++vFeaK57Cddwy16e6T95R43Gbi4veHywkfi/B4wAu72BLUl+/ob1gmrik5o+kh653lyOAcILGi8q5Q21cyqjr2tH+yQNLc+4ur8MM+IfvRJMRcZC2xLeMkoaoEprCwpy9Md6tYeLc9V2aF7GCga2zsHIT0+aRUym9j3HWH9mS/zb4JqJ2jJHkDtpRn8X5cE1V8gRKhuXYNJyjISqOJrGB3zVhuLpIW3k8j6eQUhjj8EHm3T373mqJ2l40TpVrhNs7E5JcxQ==
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 09:42:20 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::3e) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 09:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:42:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:42:01 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:42:00 -0700
Date: Fri, 11 Sep 2026 11:41:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v2 38/68] net/mlx5: replace use of rte_memcpy
Message-ID: <z2ge2pytmwlti7ajntogppsk63cohjlofozoro7yca6vuo6sum@gyr7lfoginbz>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-39-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-39-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e10ef3-4e2c-4d5b-1ec7-08df0fe8f908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Qc8aium99+LsJINWcnx2GT76fPI6LYY72LTdTOFr2zWqPO4oDJigu5fR7/jQTAfmMvEgkywcGyk2vBB3ceELkA+CZ+ovbNk/vcQ6etplQCKpUE9VsxFmWg0XjT3kqAOs8bwAMsLeFeWnc68I3orimRmz5VQlFFeaFu4H2e/sZwlhF7N2Nj8ElM4+zgMPfiwo9aHnJexWucjBVGYhcB4S4vzRUeU3CCYoLzVks5lL0NigJjzrck61GVdRqvZDCSpG18wOLHP5kjinnquisdqGY4/uZOGBOTWhd7ocWzDuOqsxXxgryvU8NtbaIBPVIYvuMKnFHuIa2mtQcY6fYexqipkeEtux6XAJap6blktTjgyWQLEmguAU34mBdvtSJaiJyDftEQNtPnuQIlIh3gAutHhEm7oumsRAdxaF10k+BDWhY4388We8+HQQ6Iw3eEOCoXpLBl4qHy9GNuIKjnfXB6UIifjSZscSe8hJA+oah8cbKvp7O2qFs9gcy0mlTNwleCWo7qT3Qdi5bF+Xi0VO3emVxWqZSpTVtfqLObOOHDgXVLkkyx+2D3lTJCS47vhb2LbawLZGEbYPyhjbN0Y5oV1vyEr+RuCPVI56dpiq6ni2KpX/cegKbj9bp22TbZd8D8l7mVNSL4uSgBaAi8EwJYE6GiBOTLwh1odl0Vf9DuAGalmT+PlXXkNUoXRj2zdO0DcEBgxvjSnbJsnlq5d+ZQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YTfVmUUAP8eoyULSzK0JVWPpNs8eJ/soRoLauvubATRQeHg2acvB8QQQAseFADkrEViDBA2DBVI7Gd26J8qTY9HLWVz7pvaJKmK1Xxqz1+Ig7yWXVWQUzi0kJAE2NfPG9SSQ1niB8UytjcGMbpQCcsbsZqQvgnRchnpckya3irxskk9Hh3+VT7a3RZ9VE5CfFMnmZ9YYNiJQkwLfGrRnVQ23kBf0UT5GF59fQZB9DCVr9iRTHtavObFZ6LYLOnmhmgztDpIeJPqyGdbqCTvYQ/PUne8WW/NHGpWCeA+ncUrM9yGRbo/cAIvXYCW6/Jsr/dQGBzOdhKmx3W70+lnMI4ZuYyQu5oncsIiGWLX9DK5u+7Pz0QEioAoguJ7R2zkOpvZzKKEdNrSUhFsId4VeaiR4zeMuAdv70IJu0NDBXPnHNxp1o+K/2rqJaWzoUaZ5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:42:19.2981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e10ef3-4e2c-4d5b-1ec7-08df0fe8f908
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

On Fri, Aug 21, 2026 at 12:24:33PM -0700, Stephen Hemminger wrote:
> Don't need rte_memcpy for fixed size value.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
