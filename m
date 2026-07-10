Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62FC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A93C40274;
	Fri, 10 Jul 2026 09:23:15 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by mails.dpdk.org (Postfix) with ESMTP id ABEA44026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:23:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjXudagIpX+YX65p5R3+nzOp38z3Ycnytj3c6tAtSf+0ipEH7UeB99xssOOsoXltDcL2r41Fkd9IMwLWXhxbNweLi6ElL+1jr+kkpUG0RM49B7yVF0PD60Z7fzwmJAdLMB9NGFcbp6sI0ZGsLqu1XyQpRA1k/5jbgUTe7VYPphBI4zs2FkpnTCAdOWSEfkaQeFYhEk0St8PebK0Q0OTl5IcOl2NnuSFU22jpFil52rUgyBo+QNG0PZhL1Xs/upLvI/d4Z4GYHLjj2Hh6jEAkZugG/a6+EaVvWJ7zwsvTfRCNebr695FU9XMVUbpqUutqFEh6qob0EgQauFwTCK5r2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhhABw+o46VTAwo6osxMiX9H+0ECY0LrwIwagyGxd+k=;
 b=by9Yv8mpupofhHqpyjclwAFlpUNebZRxx5wuzU4wNC0ZQX+bpxAsHkhx1QposmKkuCFQEOOVjRu1Iu//zpMNkCTERG5VRuX54WWbV2G4L6/KjEAOPBYTD1dGw4oA+CqYPFNOAxIULMEGdr4U8Zddx73IFkTkWTZ5yHAjcTvRSiBCcT6liWBkPMLF8B34EbXN97lCFIHQ2fLNZ9pkOMrA+K3V31wfciYUsjpXz+XUAFGVmfBweANkrt7x3pfGMNZY7QSY2rvOfH7HC9/k49Yy0a2oHQS4Ys17nEJ7snQqMmBWZAqaucCedeYfS4+nNOPYizvom6OiJ01nx3HKr1ZuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhhABw+o46VTAwo6osxMiX9H+0ECY0LrwIwagyGxd+k=;
 b=Ft4JHtCHAhXaE3OjaLS7B6tY5lmgQTE1P+uwNZ0yextov+cA72ZOV/ZZ/jgazF/FrZ5QhrwjxsyFoWACe2BXYc92ey9DcKqQExFqLB/EqTZW6iOEbuIjwamOxA+oak6wwFiZB0STR8m+N/bUPaO3Wz3h4x/22yyIryTO3f+/MmI=
Received: from CH2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:4e::23)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 07:23:08 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::61) by CH2PR02CA0013.outlook.office365.com
 (2603:10b6:610:4e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend
 Transport; Fri, 10 Jul 2026 07:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:23:06 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:23:04 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v4 1/4] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Date: Fri, 10 Jul 2026 12:52:48 +0530
Message-ID: <20260710072250.3034265-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <30d17d21-5dc2-49e4-9104-61d8c475b6c7@huawei.com>
References: <30d17d21-5dc2-49e4-9104-61d8c475b6c7@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e47f0e9-8a9b-4e59-7e56-08dede541692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0AimF+OiByT0A5AFDyPLuFcOSlpSMIzpdAvmzuX+2dYhhn9cuFFFjduUiXvi2BCHMAFpC6BWZy5X34MLptmyE4JmWHTBntiVwt4MDzKZTAEpGh0Ou7i0YIrJWR7O+lVXxu/y2LerKMWvTeUqXeIrJM+wyIsTRhOyXUMiRH3eF7Nws6spH826Q34soJKbgCHVodrRGBe6TfzxSrutZXJGF6L8QIrxnn5R772MnSlE3a/1j1QI/euZ8gZhMx+OwboljzBh+UVQmxHCuwVVv0YvD/aZBVQLf9/d9GFCJFz7sJuTWW++QGRNZWHgWiqXcxXzCeaO8w1GljD1eITUyABSk8noZaoDLD9yH47yGJi8xz7jOfbygIJC1kTkzjQB2RTTZqpCN3gFRmd8aTThjk74EfKjCdC5USM63Ul7C7KMQkGch57sSRZ5AZ/RW6ukW6Dtgh0FFZuE7wZ3WMbpaPUY/hFy62/p+QpUpmF8zMxW+YVQ1Rcs4lbYSrkhuAQeSbb7I/iZ46gX0GGVkk6eEvwtK7YDZd71+Y3dBhqEd2hExVG35FfhmlSipKYuQZTif2r9Gk8hrwjij2m6F8rEPZUz1Z9RrMcIP8svG6NDFZQ6Mo0fmrRGcqqIqF56J2uyc6zujxLHwosbGXvDBe63XQS+vE6gPzFCQLOhdxsaRuUsRIx/uN5gMFvjgxVJ9svRzdDc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bnJYWETt0KRz+2CG/UIDWeihAqtru3Pf9Ghuru2omU+rESX+wuCN0F7Ulle4Nj6FJk9RUXQTlNHxBmS1SC2qh5XaL7BTVtV0K6iM4xXH0quGmdYLghtUxx/9Xx4EHyeECl9lc5weqeEpGW7Z278Y1u91vE4QGzQPCejyFa+ulkeLYLhCfEtpWaQ3HXXWusUf5N8J/Fm77meqA42BrAzgvfkdaqt60cFlsXTc01sBGkjsFKaysOZ5vAvLshYFYtvHF6ZyMdYZw9q9QiEEDieVOlBy699zgmvrdB+wf/WR2P60sgLP2RF1TcwPUj1bSM+TllurnSScWmHy7vp20PEsNJ/AULE1M+fuZqvoiQgPoHP4ihO5qRusio5g0KKm0wSnGYF1tkrvpFBcEYeHBD/139jsPAP8O2LLbfygWblL6lp9FKS3pM1S99z3ARQbf1V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:23:06.9961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e47f0e9-8a9b-4e59-7e56-08dede541692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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

On Mon, 7 Jul 2026 at 06:54, fengchengwen <fengchengwen@huawei.com> wrote:
>
> > +#define AE4DMA_BIT(nr)			(1UL << (nr))
>
> Why not use RTE_BIT32() in rte_bitops.h which already included ?

Good point. The custom AE4DMA_BIT macro is removed in v5 and the
DWORD0 control-bit defines now use RTE_BIT32() directly
(rte_bitops.h is already included).

> > +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)
>
> How about use RTE_BIT32(6) ?

Done. Both the destination and source IOMEMORY defines now use
RTE_BIT32(4) / RTE_BIT32(6) instead of open-coded shifts.

Thanks,
Raghavendra
