Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A6C44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 10:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66754402D3;
	Wed, 15 Jul 2026 12:49:04 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by mails.dpdk.org (Postfix) with ESMTP id E3D504028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 12:49:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHcu/Ba5Whp2WBM31HtnScwMpdd3DSNvmJulWaZ9psPKoFnO4Id4YvsHDC9fMvpIa0Whj7wZcLwgookuOGdGjGQm2abpZSDWMwWy9UeJEOdChzRzgdz69GU9AGohWafopPvSTHVkmCem95NmnoLYI4DTuBmoQeAXZZhrpt7zYtxYxQutiuPiYQrcdqostQg4IXHLcXTNoMqXZ2zTEnY8UKEyK+G2IgOaW8wy3h21RIganEm3Z03T9izj+6KJHrRgDxwS7WvXLIb67+k8+KHnr1dmVOKxcBvKs11mqagTAWXfwmNuDK1fC2liG74dwLgFOvsDsEYe06O2mwEc6Z6ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp3uXRucZjK4D+i2qNXKZb3Y5jdTtZHqmPVBBt7OBUY=;
 b=OIlMDZ2Ex/jiYrc+TVZDTTMCVQStNcdqgQM7fpBQ11kyyTaJk6ptzS978w6Fl+MdtwwUlZNWUMwWPhn17n3xC/eqKcqyGlDQV36indNnecqOlC6+uN6ARwkweiar7q3qpP+cN3RdA1w4fY0L7yPOB5N/iPEBojywxhnwujZsMbtH4aSd1cnp6eJbRO/QyCEFkn/rT8BQaQ1G37CUefY5IyCqpUUwB2qTrC7/SjZJfjmfE6rWeR26NEm6aUxN3Gzb3kqBZO26cPUGHCN5ZVBnINhUOb5w1YaQecGLK0RcmWrz14q/dTHQ7SN0vIxZglMWEdf8A+cCaG/HygHtON3V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp3uXRucZjK4D+i2qNXKZb3Y5jdTtZHqmPVBBt7OBUY=;
 b=CrQKK4RB9trPYJ0LeFc3oqGMcd6BgLzdEl/ARcSTUiq1W60o0gteS78rlXUb1CCsxanyffTrwYOj8zIj7G6vfDtSobnj82GV061p6KTTfoPzbI/b0D9k5fIO+K55Nt0rKNTs+gVJSZlCBPkDnF2dDp18aHXYEtO5OiTHEDgGXPw=
Received: from DS7PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:3b5::9) by
 MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 10:48:56 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::1b) by DS7PR03CA0034.outlook.office365.com
 (2603:10b6:5:3b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 10:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 10:48:54 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 05:48:50 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kevin Laatz <kevin.laatz@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "David
 Marchand" <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2] dmadev: clarify last_idx documentation for completion
 APIs
Date: Wed, 15 Jul 2026 16:18:33 +0530
Message-ID: <20260715104833.3668419-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7ce41207-c13f-4c35-8303-119d8241f74f@huawei.com>
References: <20260715060630.3450172-1-raghavendra.ningoji@amd.com>
 <7ce41207-c13f-4c35-8303-119d8241f74f@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a79ff9-12ce-4b4d-6288-08dee25eaa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|4143699003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +OexD9H2VtGrKA3YaF7hqj0gTOhwd4n75o2i4NmobdBephxyTOrrotKtinGZ9rpVbGklNVWhl9XySAAKjl8Z884W1Y4OLCESiBsPZ7YRDnpCtm06YhkLanayuEQQDb57sVhzbzDu+LfeeG05QQcTmuTtt8qeX7XeIE02UynzNts0ZnSyJ2NfRsI3RR7Q3QYGhCGLme+HliYjP3aUnHDbW1lpejKeWxcv2POieXm/5tdnUuktuaQ2Tj2f0F53dijr2l1ymWxbVlMNZi/c5yNswuiPz0+HLDsAev8iq0eFNz2rcCYxat2TUjEs0xk/ym0ZIIQqEsRAK+upZ1q6w7qqH4d05Kz8Wqfhl0ZFwO+zNIu575O0YIoZZDhTSmWEWsrkMbAQwILMI7XBbNjMzF1CRppTN8WXchTemnxcuKTHyRYUj9/7nMAvUHpotasrT3SDDZmrc/Ea5F96VmS8yhhohRDFKaPGKIPX14Aa8R5uH0oFzHJddv3umIo7ckm4l6w+KZFQyIMt4a2A0Z+v66Sd3ZywKDp1xctmhaFoJcFhCQt1ETsJtPkawi5DM2XE3cp1c4GgFA7ivaLdu24xYHId20F9HSRAAyz6WkDxnsvLryMYTYzLV4qXdLDjr9L6vp8I46uGCdpYl1BIbD+vmYeKCbU1LKEpooVbNG/Cv8Izz1pHmsr5cGC7drJA7AMuxxX2pKkIoGmpbTmTURLGn7QYYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MB2LyvKTkXxr94Gs3Y3oqUXCx4dXKckE1af6nkUUPuC1J+391fYIeKOvYcYhtlgCnheMgn25yWMtFwGXaioi3ufz/VBR4kX8dU7sXHlYdOt9+OKPm8Agxkujerz3Y684/0amgKjLOQgy3eASBnZxtHT1xbAQ2Ur2aAAN3R3OzfkzqAB33j1OKRPIA71WOBaKIAAmuc/MJSlA8Gp7zoRcMK7ef4iAsHmixmmBupG89VEU8x7yGTdECd+6DbEPGxt8aqkLzI+L7dpHb2oymDNw2fuQp11PnZ7DYlEwPoQEc+c4XTpYgzQJZaBqqfw0/021T2mTD3m+ARqfUAkYmRrE3l3Tq9aHWiv4rBtw5TXZSzIiadJZg16zNdBZUK0orK/FfpEFrHCp/vHtMoUxzM6UdkctUCIXhCSlvNYpG6ME53tUAe7Liy1Hkxd9b3CqbSiS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:48:54.6415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a79ff9-12ce-4b4d-6288-08dee25eaa66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

On Wed, 15 Jul 2026, fengchengwen <fengchengwen@huawei.com> wrote:
>
> Apart from the comment for the last_idx field, I think the others also
> need to be updated.
>
> Based on your v2, I have refreshed the comments for these two functions.
> [...]
> You can send a v3 version based on this.

Thanks, that reads much better. I have adopted your refreshed comments
for both rte_dma_completed() and rte_dma_completed_status() and will
send them as v3.

Thanks,
Raghavendra
