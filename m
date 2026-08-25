Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F6C61DC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:21:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD49C402D6;
	Tue, 25 Aug 2026 14:21:18 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by mails.dpdk.org (Postfix) with ESMTP id A0A03402EB;
 Tue, 25 Aug 2026 14:21:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6EApGuaX0PHaWfCPohPrqj/UUX/XMCldKpZ15N+D65petn9T9cGyuJ3vjN7kKYTqepA7luBKnKwIjJ21vgvnYwVkRxrAruLJb5zFU5XnmAfYhlsQx87logUphuskhNdhHqPfGXDXI0YLjJJpNoL6LkKB9bficrWOyg8o/w4pnTYdm0LrLrYwqLMc5jlnErwZ6E1QGoee7/7OH4SNIbSOoaFDoiNpOMaatUbkxCCfPh0Yng1wIyz1y8W9rVo9ByvZfsKqMVtALYjXYXp8G8uqWAkspil0A19WEX4d6+KR6yBFii6W4eXCjNlct32zun2K5h6riu1k/f0LVL3TBRubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTGQ4LM151SOSY3ZNrmoGzS3SuPlCutMkdfNYzX/Tnk=;
 b=T0i2YSRv+5zXaAW5H7Za5cfhPUPPOl6caJejzAbtXmrPpEMfYAcTi8O1/OhLRk4z6WvWQIMArKbXjMVgRJ6uZBcuGyCzQAH338O4L+Y8VoSy2G6pzzrp1RWy3G/SG+ka3xo3FmOrjesUbTHGlTABoB9aSLQGwJ9i6nvcu5f0A7njp1uh5/YD/PP/lIgEVoqhUf3LSz9aZ1WIGJyTWlVOdrIMizxSJ/rDq9z8rPmsNfoxIBbpy2NuAoBNnxCUw1+URzz5DPjbDBJ1Wv7rt2795Txo8e4UELvEQonOdEx6fsjf1wV/KLwaa+r8zblWvruARoETF/4+/T6ksJ1ECEsYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTGQ4LM151SOSY3ZNrmoGzS3SuPlCutMkdfNYzX/Tnk=;
 b=XLKpTUGBqKub2Fgvr1v+jIHGvEm37jvKE+IfP/DodwpvkYcAeIT2TmPdXSw4LdipZoDwuCa4UFFsA7Ut9BPvy6kwWUZM5eQKnUPW2ztlIA8oI6vZ8Jfsm2T3oNrGU50TNI7QzbAORQZ9gZhQ/4ZRh1BFFtOaHjPAfeNR40nRQ5W29b4v6S3GeQzaKAPiziS4iqtxOq7Z9HcJAxHA4V/D6/NBvp9pcTf4gEFb3HnwyyhsK/PaRxv4zj+Mnxw6/5x8ibrTx2prKBu6e59361DHKOtZrRgfbxpvhyheRVrlkojigxh0EZ2Vpf9MRnhVmDididrudafybEO75bZ92E2xCA==
Received: from DS1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:8:23f::9) by
 CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 12:21:09 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:23f:cafe::32) by DS1PR05CA0023.outlook.office365.com
 (2603:10b6:8:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 12:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:21:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:49 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:48 -0700
Date: Tue, 25 Aug 2026 14:20:40 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: Re: [PATCH v2 12/17] net/mlx5: replace strncpy with strlcpy
Message-ID: <qeud52v26dqfgmtbzxgfkiu5teq6fmy55d6qex7hzf7qxhdqbe@j5v7p3suflx7>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
 <20260624103658.792750-13-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624103658.792750-13-bruce.richardson@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 881599e8-d05b-4957-4847-08df02a35871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: RFS1GsA0uOkvXNXHDmwqKe17eq/Y4IiSKBx0zayc4R6vfDTyyfhUJlaGh3j+b0XcgeJbUu9zHBkKFfOgug9FQxh3jcqwmwX6157siXjQ3ZFHg3otZczduYYjEeMkIE0U5TwWennZ8IPv8DlFLLx1aioNDZXTJlfOIW6QnyUuFh6Vu31zMpDGeqeAd2svJpTKtkjyvugX+MbBp0z9ViYu/tl6f/MVUob8v0GNvytz5j48RItCVdWMs5nOJjzOAoqzN+LtCFuHB7otFO75nLxm+LOqutxxO5El+bj81e7QoW2yUVbg7pwiEMFeRY+RzU8q6YWKO5UV6L0wEhr03DN6sDw8e6dOYiDf9ScVANGv5qZDDf3g+bwU9rpdeNNyIO33MbJs7I3JzTzloMj3aZSQLd2H+rnPzQ2HwKrvCU8g9T/h8vFfdovHVsFDR5yOR/anCeki/aFLg09pmatmx+/qNu+XBon9Ko5kzGipdqKpmASwTleDtjKH0R0OQgnw/Aq4pi39D4da0L461lCZ16HH1PKvEYsC6hQ82z7Jr1z09JSC8M8yYp/RfjnHLMpIXDFkdtOVN1L3ymjDUszIzEuEwzj4KmjltQT5l2tuq7ii5cOF6edBgB35hjyBTifMPQ/PHWq7NnCTHioGq7xD9Ph8rC25GXdaRCI9L4rSc2ExSS6ENDVgivy37DK0D/gKfvuydO6r4RlKUxWbu6MSehFVUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9YmNr/oS5Tpaoj8WNFbdlPgQjjotgNPjnwPlA+Dub+ZDEvS39XE/Hi+bP1rWo6HjWB+Vt2iXs2R6Uqc7VEBBUiGKk/YvUoMj5BT39g0jdVB1Ow13QGYXuRW3AtS0RKQbJFYZxHB0KYn/JsTvQya/rYTzLsws1ubXWC5cTa3o3P+P01SQLyw1eeQzX5DEw91MIj/aroCCDH4mrDu4U6e0Oqey7cQQCDQot9NzbQIi3yCMPzIksR9/DdnxXmMayrZ8L/t5PorLWF8FTaKmd8MHy/PfVxlL5XM2gK5PFaXdaq/pkoicJhRSvSCMjCuqzgzhZBcjliVdVJqWj/KcIgc5FEEbm/NDcTMHR2hscIwbBzr2G84MgmBprY63cbPmm3dB9raK1f1PWE52uLFzzMLCbr16UrIfw8XFsgIeXJIfIC4bxSpkqHwjlbsuA3gpNX1j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:21:09.5155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881599e8-d05b-4957-4847-08df02a35871
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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

On Wed, Jun 24, 2026 at 11:36:51AM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: ca1418ce3910 ("common/mlx5: share device context object")
> Fixes: 9e58a50c059f ("net/mlx5: fix interface name parameter definition")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I sent the previous ack on v1, sorry about that.
