Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCEBC982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F3ED40E31;
	Mon, 21 Sep 2026 10:32:18 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19]) by mails.dpdk.org (Postfix) with ESMTP id CC2B740E1D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:32:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkTliOm/V1sw31WI6v60UGfvKN+Nr53DnFoszuSu5ZSQ0vpqTpvxFaBSSCIobkGu5eVyRymlUcm03/esna00LwcWRw0XtcjFY8sfygkFS9ZsBUJ+uRDVMUaTM0W06J0wYbTpioLIzv6zC/OqFccB7vvqGNp667vTKopqVagV+YarWRqrecem3jXY5aBrThkAoFII4suMSGC4BphYlWIWhTI49Ot83twrDcpSYmQPe02Gm4rt1Io/89GTH4+vqbtUO9XCBCZyuId3DmtCd4aaqQNosfik6QqpLaGPJYFTd6Lv7XdtnvbavICAD62m2f+D+5kar4sgapLxepDo7ceGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzOdBynFNbeKbOc+YiXvUdMQfsjUA2DHgGWyh4YGIrU=;
 b=GVp45jlycvNXEQ/kVzga2ghP699dygvSu5d0BbFfRDoHRF2UZOP5r5vou1bwChC8UGy0UGoxX/OhC4QCuZZDet/cyi3eiy+tcI8N1yghGPDu6mDZU4bKDN6I6SVwQFU4RSV6GI0C78+De5f5elMijihDx4HKQie9hIbceCDOdaf2d7yeGWCgGaKOK3t+tV2lDcRkIeWL//uwnC+DipHV+mOQ9xVMqNnOp/oNwa5q4qPAtavRzzKYeDf+RVs/EvLoP7s9m3VDegnhVRUjxOwibMruD45NzP2Gz87cGiGvV3tsmE46AixQdSZsMYM1bAg+bQqPdEfFNrUdbRR82LLAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzOdBynFNbeKbOc+YiXvUdMQfsjUA2DHgGWyh4YGIrU=;
 b=EyTFufNHa195D/nGUWpWAqla4a1QTf7bOwcUBwNvpZTro6IWReHEjYqVlILcj55y2Xv4yY9ZrfjOdKdD6q5mibyjxhnrL8MapfyUkSi6HYcppkY4HA4jdB3CmpTYV8MiZfktesBqOXPkVpVj6raNrSbwionTyLMNVuZtI9uwN7Gud1nAGXLw34vIKsYlUtxotUrm9OW2fFh3NHtbt+RcFxrMXSWFkBztEZ2megdA5fQe4b5YHr30pIMjG7OgOhk1Lb0yLIULQ5y7jYMEXd+IUG5OLf1u9S8jC7pnS7GPVnODOS6BEacK+np+8hw1iV3L8VLz9LAcQf+ErjV4qvgWUQ==
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by LV2PR12MB332773.namprd12.prod.outlook.com (2603:10b6:408:3b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:32:09 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::96) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:51 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:49 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: remove MAC addresses flush helper on
 Linux
Date: Mon, 21 Sep 2026 11:31:22 +0300
Message-ID: <20260921083125.40120-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914144234.1540150-1-david.marchand@redhat.com>
References: <20260914144234.1540150-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|LV2PR12MB332773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df0d6a2-ef7f-4cb2-a4cb-08df17bad3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: EuLHFVq51Vo2yJYF7+NGthEjgpHER+vTp6ZDz6Pd/8v2LJEmKksDYevx7ZIWrR9JX7hohoOdRXe/VqwNTJK/xHRwpLCxt5+x33mOUQnL42Ekx8UvgFY5gZZvf6qDG//5nRAt2qpp6N/u1VzYKV3I7oM5eIsV1suCl0XJTSWlCDb0hvfipb97bJb8MwUDndFw8fivLPtQ0s7Zt6EEkwQDdvgtcA9+aUrszlPMh4NQWId4Nv3gCgdqEdgCeIu+djQohNYBkrr8HmHgAevvKGDX7DU8sLQeAIS8+mzQChBn2JURHg1XR4tfQd8SndFla7GHeW2HKfT1h3fkj3cUv65V/hNKvS1gQMDtz9vFIWl8X12LzKMtMHgL8AttoAzLhB2oPhoT2ZaZDHn8W27hK4vYFzNoZYhF71BTBjTHd1647jXfOgqL6dksWHp/Twylxn5rFK8XtOscqVOC6WoCzDheJMOFO6qSr6SCRfjkh6WWqX/zpObhaOQrtbIBIYNfFZE9bWeMfl7nowC3kEZjQ2UmOcJ9epqgE/Z+lpp0mxYVCfDKxVj4Rp2JA+YzbEgql80ZlKJvRQ2S49vPDrfmtL7uy0oP/KlOlf/+jt/blC0Pwiv7ok8tB0j9qvvCsLucM1R0KxUWfL9XC2U9Z1KDbjkGmD6ZWXpvHWCCLQOb7N8AHNw6qQA2Ufr/p9BqJx0080GywkCftkJquf+710vudgo8Ww==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ssjSrdxnFqMhgqrFK26EOKuoFfFEvhVa629DfaJI/OlwwjybWwfvII67lWqHi5gMgKkaafEnY7vnaKWCAs651uY1xFpPokRZ9841VHYxC6dxvnYQZXFsSR8rAoiaJ04e6WnmElA+iv9iCqM4AEsJLNRVNU3dDTO2WVgNgu5J47MvzVvgg0eDTtkA7lQml/ASFfRjpBKQE6pNxn9yJxqiqq8sifdF+6HRS9KzBRViGmKbt9i/V9zAQYKxyvIfjwxkOQv2NMhnITwEssG548JlqPFm3UgaSqHqgQ2seGF7RTfdroQf8n9WqCn0IM4+LCKOGt6oBSeUVYWKJpKvVubENSlMga/NNDsSkRtYYDYF0kZeppFJeUPFCh19wtpFwH0i8CSbQUq/ZQCqT+3Mawg1Ka7dcf5YIWQbVGcPcJoftIWu7iCeEBdtF84enI8El8H0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:32:09.4335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df0d6a2-ef7f-4cb2-a4cb-08df17bad3e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB332773
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

No functional concerns with this patch in isolation. Flagging for context
going into the rest of the series: by the end of it, the fixed
MLX5_MAX_MAC_ADDRESSES / MLX5_MAX_UC_MAC_ADDRESSES bound is replaced by a
device-reported dynamic limit, but mlx5_flow_hw.c's HWS control-flow paths
are never updated to match it (see my reply on patch 5/5,
"net/mlx5: accept more unicast MAC addresses").

--
Raslan Darawsheh
