Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10391FC5913
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:57:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEAA4021F;
	Thu, 26 Feb 2026 10:57:32 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by mails.dpdk.org (Postfix) with ESMTP id DFCC2400D6;
 Thu, 26 Feb 2026 10:57:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuSUf22gi2PQEhABL0W/eBkP1rWytXHFxht8V0sZE0muR59KmH+VBXPTDYgxyXbw8g5/VnhZZXGb+zjre0PXfa4Hk088w2PQnDr5DY1CH1iXV5G/cOhEMbwCezpWGBeY9d+1emDifQ5/2Zr88KvpU/9C/Ke68VEtbnFXOZWOxTqTN1weP/o8zSp+pj7bsDa1tAPoo6bNWb90waGTlXX4oTNSx0OENJSfp4X+dI7jBN6I7cZcTjr+4rrmLPD5x+E25Hfd1W4F3WMdxPLWhp/BNf6uqmffUpc/4KLZFXso54GVimm9vEXHN38H5O1jtjgmF7WSLLnO5o3J24mkpzlD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5NOuh3TUSicklofSDkNeD+5qDy10Q3m022hBr+6Ln0=;
 b=P/Bp3fcMZXWtri9B9CRchXs/qd3v4R8TdFsX3U6Iw3cI8MbgUxTleP0GCn1F5P9nwwDph3y2J5rbeorm5QNM1xPJUCQeRmtNxrlU60glZKfZpGbJmHDhIfsM0WKLV4lpJSqtzrgo5kgJ4tMVIaGQap1DMbigvRsNPjiRprCy6OjSSYK0YADHNpXwbwPwZLchbkC3lbFPX1yQA3xAHd06JPNx2kBNaoFGtLkVn3XdBUAISgO+Wnd8z5kbzB7Ta0uQ2q5R5512FGXtepZMsViojve/6gO1YT0V/ylqSu7dCXB05Zr2iDzFkrR0U5L5KvjX1xnIyqI5zrfX1OM41JTUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5NOuh3TUSicklofSDkNeD+5qDy10Q3m022hBr+6Ln0=;
 b=gYGghnCQ7cZ8WE00H5ZAkOeAg27zLgOl4Z9reHd4oCjJjmOBwEoPOp9BCwO4XbEqohwKPCXiXWbZYMw9O09NYbcikqvG82pPkToZPSh4Hnkj4dVzb8EgQ62KGQ/wSX1iWjONZnT/xG4xg8qC21agOHAlAyz546c89H2c7AFvta5njkWU59dgeNGbhIDYbjJkqnRa3QR8hTk6sJ6mpDWue0ulBJtttIljs75/67AZk9yhC2BeuWv5HghNcHkUIaD7Rsb0FiL0nNsV3yAVuAHBdQ7bKlTUdKVh9aR38KaQ8WMwxCEbXtreNiVkGrMYMuCXITtc/KRMeIVkJ6sXnEOpgA==
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 09:57:27 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::14) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 09:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:57:10 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:57:09 -0800
Date: Thu, 26 Feb 2026 10:57:04 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFT 2/4] net/mlx5: fix counter leak in hairpin queue setup
Message-ID: <hu6yztlrley4kfbmhn5eddmhcuqjfphc4bjwozgalcwiccqjll@32i7e24khf7h>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
 <20260217150635.134031-3-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217150635.134031-3-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d22dc0-c477-4c7c-608a-08de751d7297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: ObJNwo98xFwWEUHUcjfbLc4lG97JxCvsFxU5svwxmlYXNGUDWfqVWPmfUGr3CWZLwwKa8gc+dJmoBL4RsH5UxidoOOyYT66Rw91VCLe2wdtKxhTd/U7rQgwXbmNMtBN5AOBtSffJlBJBpxEF2VQdj5YNAaIxAn+hqk/W1DtvbAgDz35EOMqjMB4MIhi3JS09miKL1a/nag9BjgShoBLyxHBUoYnUQA4rfNC3cB++dmd6eGviF+7F43UNh0n8VEliUE6j4uBF5a+hB6PqwFUW3NSBUz+OlxsomUP1kUh6qLNJBPdBVa0cVTAgBqMklrfjX39nmdpyS9RamgCGyYxwltMwR9G9SVJ2mHapgKcwPL62V0e73JuRcGkpGxugB35/vDQg1NMALP4ueDzSo9kB6mf1fyaR3iNYc9skCR/GIa8kVIB18sLUmcmt8Z3uiexA2YhYEDiNBc4KRVE8E/Wb76RwOfPqDI8K2SwsBK6m1bmxGE8L+aFaBFASP1xtSSKXbqMG3jFOjsaZyBNqL0uiZTXgmM6y/2aympTuF0TAp8g7mjsnZXhtpDsGZG/NskA6wxtgSObywA6SIEE7bP2newQEeZU6S7EAOFqVldRkcR/3IJcEmFnD2HA3tXotXMB5q+Me7Go7TK5DVm6REWTNCpJRTPDJJS4JS/pUqlkMlVPb9kY/lgKQTkIMbhG4uxe4XvB0ZB4Nba+xtCElo3K5lOzb+ID5UjVbR56cZq+jI5hNjSP1FrfKkX7qwwB88fUKnjYoBPy2/DdqAWWVI9wz2wacgw+R9bZ+K7OO3ekCmPIxNxwvct4qFcwTBZkruI3kXNSC8tWXuaYXLqXaGl+AOA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vS31Pg2eINKmFP8Sf/Puv5FsTwLzr9Ww9oycONKAmbh5+JYyTIYsszSQNEvXnYYcCkvjtGMG2rvumOSI6OSakacNoq4gQQLl/FPulLZLrTLOyUfGDm5+dbDx06BKsjZGmOFDN1NEqid3U84WOcMgolBZucFeupMSEuWRbSUpEBISLljNvtJ3ypAjGXaDSSeJd6vrltzqtyJ0czpaFyGEBawPilO/RkrgQ+afSD73WFBtWloeRZL0WAvY1cvCvtmbycwDJehgzo+7nZIKYYpngh4eGLSyOFcqMRhCU9I6DVToGz/PtIGRF202JIGC5YxRCrWNzdZiQNiLprlpNchbPnY75sDOETe7u7+edsvSVIOVgHp/xkdLf723C4qSfgbly6ctDrEMzR3PoSwm82aAH9w1qc0EFRO0x/lcg+5SeA2IGVu7iyY4yXmva5Ln3n2I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:57:26.9267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d22dc0-c477-4c7c-608a-08de751d7297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

On Tue, Feb 17, 2026 at 07:05:00AM -0800, Stephen Hemminger wrote:
> When rxq_obj_modify_counter_set_id() fails in
> mlx5_enable_per_queue_hairpin_counter(), the freshly allocated DevX
> queue counter object is not destroyed before returning.  Destroy it
> on the error path.
> 
> Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
