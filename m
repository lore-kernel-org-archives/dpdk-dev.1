Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCD8C982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 466A540ED8;
	Mon, 21 Sep 2026 10:32:19 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12]) by mails.dpdk.org (Postfix) with ESMTP id 04D3B40E1D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:32:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqqdFOBWdFsxrksLw84kUh8Q2RNgoa1yk5oa5mJGAo1EzBJrpAoc4G91aG0iWYMjC5ohCaw6tai00Ne0sDNWkaoXvzQzaT6eWALXKZ1LfZztL5OkUvKOzgqs6H+RrBFK+KjNVksO/Q5jWehbgkDEXGNGc3irR1NcaVjYREXMy3jpaV/lxGtbbTSJaVrsJOxdSQH9cCJUGu4iGACHrwdPwiMlizNS7jFpQzkZ50jKiisU2lKuv0H1NDdz6YRDxcKIzlGHerB3bSLikt/uQRhq6F81GXieC0odqUpfiEappTOlpyaNBbSxW4GnJvr+HWVlNjtfgRznPvwCymgIglxgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn785mq/8M9PAQaOjBAEWWOLSLlwNWl9AHoNQoIyaqI=;
 b=pQgcgkd1/EUMplazZQv9Kq7VWLynUVQ0oKYBxtL0XuRhc1Yi9O02jvlMmmzCChhKaILOJck30A2GKQ3K+GdE6v6R9Q37l2TIEtoCBrdeoM3FVOUF2bhxkTUIbWV7DsNjW/PmttwZ2iIXksA+cfQzHM52S7jipXwESx9DRh+BuoDfxK9f+5EBPqzSG829cnVEBGh/QKIiw23SGIXrb7W7h05eceXOVEVmeWn5+jaLxXe4bdGUx1I84JlrkrJgA5AMvLsU7Bt9RreHmkAeTw5EBRhwMIWnA+bJZoQ6W55WtbFbR0HJ4if2y97vMh0jFKZKsy1iL1B9sGy5U73fnl4O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn785mq/8M9PAQaOjBAEWWOLSLlwNWl9AHoNQoIyaqI=;
 b=OOFAgugPcwIZ/oRpglspQZu2Bgj88BvUehXldQ2ml98oJrj9VLXtEbbwmtQ+JCSxwjNF30tZ+3tonIZ0Tnpy3Blcm9Lhd3SOQMJhyekwGvpRCXQmrQIhIKMcfkEFFmbehEYnDzv3OCFLQ1Xaia3nXnjvimDZ+7nWl5v7jD2ms1m7aBLxXwRH45wDoiU4pyodBP7azYGDtjzEzhM5jAzb779NbIdJHTGdqZVMzD8Y1AeBjwDfkqGJwoRVhftaS/v7Ik/FukJSRhDrP6hqIeysm25G0OYsski/HYSg8mYnIqOVb+UZGUfuCYlaqG4BvJxzrlHkCMyCBCvFF7fANxsJbg==
Received: from CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:32:09 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4d) by CH0PR03CA0065.outlook.office365.com
 (2603:10b6:610:cc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:56 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:54 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v7 3/5] net/mlx5: pass maximum number of unicast MAC to
 common code
Date: Mon, 21 Sep 2026 11:31:24 +0300
Message-ID: <20260921083125.40120-3-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914144234.1540150-3-david.marchand@redhat.com>
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-3-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: c113e96a-92ae-4f51-637a-08df17bad3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 0JCB6D90sX/QIyAr8k3M2svxXfB336+fLlOPsTApXfxXQb6/wWwOlUMIcOeLqbFQCSvBtDUJxQjoPkaR0dqUq7W5IqjDNfxoBEKUrOkCmBoj0SWR6wYL7C8vT3kzCC5Iu7GV1F5hGluH4BY2e3jJI7KYcYLa3v1eXCXKqj1/ql11TPyMz44vbFjyKZtBB3ca/APAtkSEahbWOgxl85Be0T24+C05fjJZ3mZSdqqQD1t8NQkTNmL474Vw/Z0oNzKCT+hpCKGZ5Dvhm660vgLAjYWaHnE8+4PUW5FYlIH1cG41XSotEzAM9tKOHjlPL9lbHu/qBPjU8b01Ui+97gvGINAUWqwIOAbSxr5TIMxMRPba0SfQI9XYQxQlugNOnL/blNdq4PVK3qyCkbhO2U/qZSEBed0ZzODJFu4bxojZ3FWr5hGiaK96VBfyUmcuK1s3fNl2PvIGL1v2n/bTZhTmJ3C5LQkr7b027KMoJBQz4RPM0RDcALoTusesMiblpsa/8mctDlbShn93p/QP78pop6Rl+V672qDUatg+89kmiNMVUp0mhJ3A+S9+k9eQPhmPWq9+zUFYjIcSmDp4tL10Ua9LzQ5AvyDdGOMcvgLn9SkxJCcmFdvMTDA8lwpMZIfIGvKhYr6xLwlfnGX8N7LQcO6oR41O7ET4oUhxVWE2pn2r1hg9wAc8v1mUHHP4njb3yWy5upZdFqltgUNfFvtQbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NE7cf6yF7/Fi7Xd93j4W8coT+QSQXNsAcMTJANefjJWR7MN57pjV5q0cT+jQE0qpEBx2KNdGtuBUEedZatCLUm4ofdnP6DF6JBHEcyLp1InvgByP7PF4J0WP5UvJtLSVUWZOaDMTr92JMZKIp3Sv4z+PW3R4wf9aEq0T9H31XJ0AMzzFzV05oeKgXlSGqLFl9rEmylBEHlNYGMXYYKkGC0YsLFhypgWJKNwkaW16WuqaM0WvIrLg8+1/qX4d7jXUHkqD2z5ypJxs09BRMwtPDVVyYcFEDEHuAb6082Z3jBnC7rl8XJods35R4a9QOW49mz6jbSbBRAIgkypCi3X3yiBpG4Jc0GgBCle7JNEEXhj6bt74iewOXNehRCKI4gyMYSkDeuYRw7QoWbfrkRy9MvS/r2bMnME1x6ZbdyOy+O0H48j07dL1O9kwJimvTO9Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:32:09.2610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c113e96a-92ae-4f51-637a-08df17bad3c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

Hi David,

🤖 This review was drafted with assistance from Claude (Anthropic) and reviewed by me before posting.

In mlx5_nl_mac_addr_sync() (drivers/common/mlx5/linux/mlx5_nl.c), `n` is
now the caller-supplied array size rather than the old fixed
MLX5_MAX_MAC_ADDRESSES (256):

	struct rte_ether_addr macs[n];

This VLA scales with whatever `n` the caller passes, and by the end of
the series that can be as large as the device-reported unicast MAC
capability (up to ~4096 per the release note added later in the series)
-- roughly 25KB on the stack versus ~1.5KB before this series.
mlx5_nl_mac_addr_sync() can be reached from interrupt/alarm-thread or
hotplug contexts where stack budgets are tighter than the main lcore
stack, so this can overflow the stack. Could you switch this to a heap
allocation (or a bounded scratch buffer) now that `n` is no longer a
small compile-time constant?

--
Raslan Darawsheh
