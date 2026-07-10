Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8883C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 201FD40274;
	Fri, 10 Jul 2026 09:23:46 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44]) by mails.dpdk.org (Postfix) with ESMTP id 0461F4026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:23:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsqYTLkN0lEWfBsRX0ZrTlTiXfYZiZb2Ulp7WNVOlrWTue+oYGDd0Jolb8IqMYs5u4EndIbxVQb8yvIH8JXx7FP2ydffQZcLX4uI71MvdC6w/afiHk1DvpG1i5TSKci9r1fGXIppNixvK1OnS3lZe8SPws96bGANktXVchwUCfr9s/IyhrDAI2/WN3PtV9nwL23s5d/GmpM/Lths1cTqPO0fAowK0l/ITZ6s/FiTa6DMiX+7J1vW1ISUiqVhfpcMSNJRNp18C9osVMZ3WgVvRmwAe57E3ZS5Fp8nwI08iWCBw91aOw0Jgu8pcQY1Cl6rw1si4vdabqPGLqzMS3wedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CQzrK2zMQ99pEObW7gYSPjaAniyPLPLS7DT6EtMY58=;
 b=OUs3hpXj08CNYIAZL7RozqP7HPDimzOmbyUQz/sLwSHDKuNN3PpKgypjEFSE1cCtus8EuVcSaY5WBZ+2ltK9vf6/Bot4PhzOJt4Xvy/VoFlPF6I5OtesxaL8nF/vO4P6s1/sNOLXuD29h2g5tmBt0RUSIEIcdmVbbJIU0CRMMU07wxSlzXrKl8XhI4EL+N/hMaCD/NslZ0YLE2owS8jtcBndV+pna2bL06UMpE2BKYEdfOHjmvHp82S+OF2G2pRbGYuYHs2YS9ubk5Wd1nigs5sx50YFVu0rSdV9xNqNXvoLit0rrAnzIK8URGXkzvGiLcmWVB8xU2JyvLVPa17V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CQzrK2zMQ99pEObW7gYSPjaAniyPLPLS7DT6EtMY58=;
 b=CvGFGHBV5rKLE10FLZ6kzqd8PwUQA9DJKddbLxvfPug+VUL8rmyqTLaYMYqvx321s8IRdTiY7ToMg3sF47TlaZwAFT9T0fV5/Euj0YF2rlHDtPqHXy45oiB0B1dIm1M7Y3c8gL+hVQFI78Yb9DSrWYRxGapPMrFYQqbphOf0zGE=
Received: from CH0PR03CA0321.namprd03.prod.outlook.com (2603:10b6:610:118::17)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 07:23:38 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::5e) by CH0PR03CA0321.outlook.office365.com
 (2603:10b6:610:118::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 07:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:23:36 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:23:33 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v4 4/4] test/dma: skip instance suite on low burst capacity
Date: Fri, 10 Jul 2026 12:52:51 +0530
Message-ID: <20260710072250.3034265-3-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <44a99399-6050-4374-9f3f-64f6b8ed70d2@huawei.com>
References: <44a99399-6050-4374-9f3f-64f6b8ed70d2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f63b37-d9a9-4d5f-71e5-08dede5427ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BzGc7jeLbyM/zxO2gsxH8rn375QOZc7u1tQz1eZiHcE5LTkxwrMIQL+X15KhHwdRDcM0NWwZmt6HiXfxFVDM0kOyTihPSRV3EGR+DuoH/46TgWIkVdjqB4uOYV6b3pHMaW8iIKr7YvLhPbKT1qgpZCVJEIvXAZbcY+6SsJ6LqmtBBbE1BHMWIp+yjKdBdgpqv2Aj7JD1pUxj4NK+qT41Ls/D66/k0AiMzsT/SKrSaGFlINlqRqkDqS9tFGQS5evBtslhfEtoeuQbwpgCsOmms4BRohTNPVzcHW9LQBYJ1XNe4dfxbDe/JCNSJFwXq2psOp7iF/1Aen4xKzIbRTpDvAF6OkhUNg92WsZj6B0TvOJ71dNp947JMbFtGnNQKp57VcyJc/uKqzpU2g8vfcuFUAApovySQmLP9L21MYTMrp6+HrdkBbj/VbSObM93LoplTy/3Mcz77rncfcbyaBceE5RDUoE2tFvJteSMVE4yESGEpZcJ+uD26yStaUVvWqBWlnibRve2WuWwPANK2f4qe+0SFw1XeoritcTI8vgIKrCA8xJC/hch4FWCf+XML4MhYjXQzMSHJl7v39pRsFLcQbKslWFCNvpsDX1bNfgXS4fd5tbcdHK6uJM6psvSN7IB3tWCL2zNVzMIQ5d4a/hFnQruhlu9I2BlOEh+tjxzEdmNLLI12K7LGM40KarcVCr+6vImLALarYVe5YYFZWLU/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ewmj6iqdKpmHC5tJfn7vf0ny3fH7I9e7CVqZ1LHEygqbjzgt7fdN4BbAlS+BTVsEDAGV/FBDbTczQBSCg81NGtMXnfmqUetJ1WMjhhqUgY/cD+jbfge88EDu58ZlZ56Ayct5yimslxEqemoYd3PSzGBjNlM7R7gccAYJEIv8wnWvKDk5U6NFr8clFBul7U/71wFSdO/feJ7M/Wxhv6mBoSz/82Ame7kmCzp5W+/5p+acfaktHK9X1Zib+68hVtjXJCC5PGcld2BRDorO7mIxVC0/6tBvM7Y4Gj8Y5LkVvkoXWHtGZcAl/cLfEnDhBnZWfsHL1ZRGkxalZPvix3RE5ezIW/YkibPBNk2W0WvwsA0TxHfh97z6KVJdiMV1EWBpTrfSmq5ki1kgcyMfIt2rIq1q4SzuvjASTfpgJGGQJAfYuVkE+yEfEA76s0tIpq0L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:23:36.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f63b37-d9a9-4d5f-71e5-08dede5427ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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

On Mon, 7 Jul 2026 at 07:11, fengchengwen <fengchengwen@huawei.com> wrote:
>
> This approach is also acceptable, but I think this test, as a community
> "free gift", should be supported as much as possible. So I would suggest
> you modify the relevant code to support this test, but it is not mandatory.

Thanks. Keeping the TEST_SKIPPED approach as-is for this series.

Thanks,
Raghavendra
