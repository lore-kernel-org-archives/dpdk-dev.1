Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10956C61DBD
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5387540655;
	Tue, 25 Aug 2026 14:20:45 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by mails.dpdk.org (Postfix) with ESMTP id C9993402A3;
 Tue, 25 Aug 2026 14:20:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Qh56hyK9auFR2xIK57Z6HKmeioyKZwQVY9t2BKbVmjYNgW2gVWvfbuzO0tKctAuqr7FWob11EIob3nqrS8OCMqhAZGGnPBIvUYf2Lc2Un2GGHFvDuY+V9dWnVRP3JvUwXopAjIddhJxqVEJPKv9sW1/5WgJMm1GE/PupQxJALKNtj/2QB78IkyT5HnXwOwQYXx9+ehaUKJ/cX2JBARv/z/SPLI0TIOp0V+SWZ8P0iO3qeothu97R9oemJsHgop6D6UUyUWHuwUUjdLn7VvZdZYGsiOHvdeL1H/5ZwFd65Tn9GJi+0nGgFt8jquKgToBK1mFFbjV0BBFuFMGiV8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+sLnvvBZq9hVZspUez3rZs73gDAlFEJGcOS2OsNi6w=;
 b=O13D4baYSXZW+9scIc4uYuWfpdup2jAITpIGrIajwN+LLLtuSAKOLc1hgwUxkzLFyR0fJDyOo6l2EKhcL3eGY/aS1MjBdr3IF5u2QHWlZMJMMKi302pm1t+WpOoDaAg3yvlVUNjIKTSYdmmOmQVAjv+6G1Jyo2rMuHO1YM3PHWPG98m2G/qbTzHfc++0efOqtdS11PPQu7k1QUDlHGf847W9mPPKDAZS5zn9kJRPUgbLKSJ5B+fUNPA12qzlO6H8imwpAc5pRh3t0G4HdYYGNQLUGjDTgY8UBWqrmGJQPoXFTR8e/+U3rLUos6womxo+GQZgxxnN2fsgFHziiiw3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+sLnvvBZq9hVZspUez3rZs73gDAlFEJGcOS2OsNi6w=;
 b=H7HSjH8rN0AZYBtilPooZC1UHq/Es7dXdS0GDtFMWpi4nE2+Gdmq2ckOJZdD9FnhsA+LfJkSVIPGZxmApOSSZ5s2M0sTzwiJgNteqJrZeUUhFiRcaQAnMLIQAMKb2BsHqdGzWSVKym3KLL3qTPtvEGdU1jirIx88IoUAOOmb8CzResyuQLtlfwnnATNtABVQDZ0CgskvU1dojZLCtyU9uU8osAfAmEn/2/qe3mmc6RbDZcLf3ILOSFkPKDaCFBYyJOqH5anzR/idBT4hoYbQPwsNiTxmLntx2HxTRmIp0g9Olf983iWjJnfkIDu8vtlbAXfaBd9VMR8G+QWjX3tPKA==
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:20:35 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::5) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 12:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:20:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:10 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:09 -0700
Date: Tue, 25 Aug 2026 14:20:07 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2 02/17] common/mlx5: replace strncpy with strlcpy
Message-ID: <faj5eezkhee3psiynvlmic4pewxw6gnfgh5br3l3uqg7tf5t6p@ed6ym7xlnmlt>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
 <20260624103658.792750-3-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624103658.792750-3-bruce.richardson@intel.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f22a153-1eb9-456e-e2c1-08df02a3441d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fNUIcj09Pf7f+ecmqCM4W8GmhgVj4Rk3ExCtKhenQ9G7oZBrhlIZBOeRCSkq2hZOdafHRVY+C8NA6/CmOcbK7+MuVF86VfymAXROz9nP3wjF88wWbc9zWFroD8z0FQ7oiLWF/+ghruxmiL1U53ct4oMYhdSyBkc1KFw1GYfipoNP/p3L7qAFmJ0fiBdYNzbhf7zhyLWX5E/e5HMG0P4NAQQt79WwLkpL/dpkLAK36WwddARvOMN8wOlv4BOOizt4e3XXokfiJbQ4/DZi+YDlkuuojO9LJ7xjQlOGLkX2VSpHPXPUJZ5laD28YZvkgBUsOHDPAwDDlC53dseTNzHMnZnjT66Bx7UjY+AXmrvoNH8qLccw2v69/qbEd0cKSFqjhoEsdk+fXkXZL+F2rPPOR4BSqe9eYdoOD/Z7EIZIlnqNSt68a8fyd9QvcuKTCPcB42NqpV5wfANQ9P6tlAJ1DpvelytNzIiMK6Zgg31FwVovjxHhTWfbjpBf0dXSx+qbB1z2ozh/iBQtgQSwEEswRREn4rwFSa71v2TGl5VVpamUAEkK1kwl18yWN6UZma0P4dlW2wvUU/eg8xs1YAhjegj5YhVoGjQNx6SKOp1P7/SWYaqF4RSCi1CxAAai6Bs9VnMY0egMQndEJI80wn9Oc4YBJkcJGGmceOSA183PElHbMOkxAQX+kcP+myLDgWN6fk3IQO9/Lw0HfJ6UqxBhTw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wjWVXCmQwp3MzjHf9rEhIVaUk+CT8X4Dd7XGNggH7L3jHiO2k75Kk/iFsRfgxtMEkRJe0xIxpyuONe6C8V31EnfsDBFWFIdxlji1prQi+rVOpbNfPfsOTskvGNStjnufTUgAJeLQr2fYgC2mjsRc2GpXwtJpXb/UftdJiswZjA06cFX3ji0qAFwX7PcseMt5GuAJLRPynpdPnQlb4p/N0DnJ7/SufpZH0rmcK+f3nq7uNho4YyehY7z71XUHf6yxRDhbHeQhqp7Y/ZlMpWG5cw5eVL1Dw0uyF9yA+Hb687iRGOS2WSK1jboaip+f3dbItI4UeFKLrN4sZr4CLQ3cS3MGEWGlIkIRPSC9pGzqPVmEktR1QWDOdt4VhrACupHi5Ng+yDM3SA8stkUOhjUtIAOdoLyy/3n+sZABoWIFbbBOKs0OWchQguNN8vdwlN5c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:20:35.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22a153-1eb9-456e-e2c1-08df02a3441d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

On Wed, Jun 24, 2026 at 11:36:41AM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: aec086c9f1c8 ("common/mlx5: share kernel interface name getter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I sent the previous ack on v1, sorry about that.
