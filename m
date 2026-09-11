Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5805EC88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:40:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37D4140269;
	Fri, 11 Sep 2026 11:40:19 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14]) by mails.dpdk.org (Postfix) with ESMTP id 5EEA440264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:40:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ/7YFho71XMzhz4K80hGtmutCQFk6+9YB6rgTs6T4gjGYECwNHu6lmV6ry0RdRwMEo6FwjEmtO23YB18sPTY3xf9If9IB+ILbhQqLUkalBPbNdWy767u4NUIfBOyPBBFk7WUakCPNVeLjdH2KsW7SRhIWwYvSr5mwBKVNhrOYCFl4yNK7cVJeCFrwyILN5hxcJ+Nd3zyD9gLqWhJni+CYeoa8JdXIXLp8f1Xp3vNDu4apwO07/8pJ83pyTsPZ4K077kQZotUKjnAtiakpvNtlldDu2f09rQs2sUfJwNBbDlsAiGKYh7lp4h0PRhh1ezLS6fgis9z5VWsDeFKyWHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e+sQFeGZX3k68EeBmJsIziJE7Ttzoq1KpsiNqX0XoM=;
 b=rpKX5XpemOHNLSSjzmsOqOhMPTnDNo7ubBO81iCUXZdms49rjcM6cHNEVJhP47hNbai0+x424ojVPyDKnABFLlWzXu4MnjMiRhwaJMvIhK88pu5fA7NzY5dstUWo3f1IFHFkyPnTiWwluCdtx36pPNkj2B7kGsAenDzk2Je2YvyI0GPM2jZPskpwhAH2L0eUBUWJyRFU6jYASuoNjlEZO3KmuPRG7YpJH43qOJ3lx0HQuwP5q6+Po1QmWihkL/J90QolJB4NpOIgwRZgfQ0n2b/Gf9d1L7vUAedDYGkJpJtW0jCA08N5XoKFNWqOpNXweJz68CbM6CI9Qkr1aNhAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e+sQFeGZX3k68EeBmJsIziJE7Ttzoq1KpsiNqX0XoM=;
 b=T19RRTon74EId2NuMC+AIAWe4OfCT+u2M9xv4h88+CQhdV8BGYw5r4tOozMAYsYFn2kd0bdRYFYj2YerSXr/YO1K59Z2CwfJ/VSLiMCHaFsbo282FJOh0KO4jNwxKxGeKBMOCW1URCnoHFwUfqsEQZpGtS8CtdyVIuEb5QuA0+AxxOpHQWcnr+5Shpmuo2KdblVCCFw1SISm9egpwAsNBWJCQ3FC1YKZDEI/mC2/JGIhv378ZRmekHy6c8KMeAmtJetVf6YpQlcnLgaJ5xWGtpbywW0Q19G04CPhpCveidmAiaBDs+TUX3b/z3f5o8Nmx3meKcP9qRBAgegzAyj+MQ==
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:40:13 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::89) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 09:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:40:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:39:52 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:39:51 -0700
Date: Fri, 11 Sep 2026 11:39:51 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Nicolas Chautru <nicolas.chautru@intel.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: Re: [PATCH v2 05/68] drivers: add missing include of rte_memcpy.h
Message-ID: <3xasvzotg4h27pg6lgpjm2ozd7equzjizft2ljl23c2ggdquue@uj2jiyxqzmqx>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-6-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-6-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c622122-1726-4f40-4397-08df0fe8ad9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|18002099003|11063799006|4143699003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: CoHY/JiGPHYqE9S2Xwad5njijEQ+gxi8tyef6ZI3+B9OBwuK7KC8N/2e95wbbZHGte8RSawPaucq6se+k8o0urKFKlhbyxSrloRm3yIIet5JpQzOwoIAhKVFcjWziGwcjAJscNactWeU8EbuGE1i4ZTzI9sgSPzAfmy2fR/ruCHJnycKtxBDmhNCCRbvNfNKxikU6ep5BeijvJVJyhURt4fHXd/ZNqm5L2q+TCTPfU+RNLB0AZg5CON+uThaU86kWfQQOVQ8FoXY3giDsDYaOlHRNKsDmJgG8LV7ZB5xZhPrMUfX01N/Zt7nE4neGfTAFUNi7eeRVmHyk7JHs8SpuPNtkIsLJGZwLwT/tn2ABmyVOHnWrlTp9s0u4sXL5lfsM0Jkpi9hiMzAarUzi6fJAlkmrRvwS4duO0XZHSqI1HzGypAkvSmEaO+kR9YJi4nAu7u+jovmARzegOp4dHnYeB+FMUMuVRhFo5Ib7Dq2wDFAG7CemnzqhkgkjLMN6/qWAFnG0OaqT1Xg1ZTbdDCGUYTtKNrxGfrCfM+7+giXlY9OY7NALNbt9FdAR/Qv/d+Gp82b0GZGsF6z4P+F/lmPXYlP6lcjTdvwowXfopDqr5d9G9+IBGUArSk4NjBi5e8hHKZFk+sz+JIxocOM2SmTrQvZ/b/8M2VHMwvfgc6Mch2yISOY+E5nLm7aMDTZVshL/Vmwo9ZHwOnjMXiFUt0w8Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(18002099003)(11063799006)(4143699003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gMfZaVBgQFafYh6ptW1LCqRmq3gUNK0F8u6KqzrwDeL7ie3c5QBNFA/+CtSxiOEtZlDtYnaFWNUu6yPa5d+xJl9CzjTExOP15fFkIFEDz/Naq2QBJiqkPv8SX456sf4K+miAfUWh7UV2dmY4MqFCr7ykxINS6qNAaCqUghJ9Opmrdp1Z1DcKdk0NkXA33ihC9rysTOtuPRNo9V0LEHncCJptT9bEMUgEwa/kWf9S0am99TgIVfId25EUYNbmoQaui8mtxSmmHWrRPSuZcCQk2R8zAQaKvOuGDWCShCo3Wl9cmYYJH0GqmZw+obyxQNSQjU9NwW2b/WQ4Xr5l9bwuQleOoXblv7Gle81qprbXub8zX2Kyi0V+pKeDVht/frmK7990gG9EUUmawEMYYiN1eIgSTxy+gyHPmvH5pPQbSd6m/GIWsZICln42yqxOLjKi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:40:12.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c622122-1726-4f40-4397-08df0fe8ad9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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

On Fri, Aug 21, 2026 at 12:24:00PM -0700, Stephen Hemminger wrote:
> These files use rte_memcpy() but relied on rte_memcpy.h being
> included indirectly via another header. Add the direct include
> so that later patches which remove now-unnecessary includes of
> rte_memcpy.h do not break the build.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
