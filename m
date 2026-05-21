Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39FCD5BA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 09:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5637C402B0;
	Thu, 21 May 2026 11:35:14 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by mails.dpdk.org (Postfix) with ESMTP id C91A040290
 for <dev@dpdk.org>; Thu, 21 May 2026 11:35:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaVTuasScMFFgmJuybrdHEZH8VmtOmkLDKE0cuWlq7/uuLwFCJtRQaH36UUxiZ78Vc+HV7OR5kYPdcjA1jfDw0zAVG22OGacbLlbmY7K7lSqanoCN14Xno/8AhksIcJ+A3QgurO6sCZ/jY3b2pX910o+9y8R1tLK1oLlSk+yC0CyftJNAfx0/wCRFPQZjgS0JU/JRoZ1iwu/LQWDjiY5TO5UczRLl+AvC4ICs4ClJ3JZIP4hvSIp2RqBf/d+CHez8/RPQjL9fhUiwV4SRPqbNcgVsjOYe78FIv1Z8AOJp3FfYNte82/QwUxgSGTrTaCJIC4eXR8CKatVcRTBalY2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXu2+1PNgsKEoaujTGFZZ463t2/NYO3YnlcOb2jsofA=;
 b=PyBfi00g6YQ4kTL9zdvAs/CG5RRsnWBMuT6roVOVtaVYKnxPpcDqa/u05zcA8KrP4qoxeWTMPsOUSTiL1vd0pS2zO2suIavh5srfBNP7c6cwCuhGsQDMHU2EUUbKDsuf1+FDtCljAlgw3rftxtCAEYi+VRyzwjMDLE+thJKMCqZwDh3J/CHUTaxZGLBzts78YvfhadLpOid9KqOSbYr7P4iHNfAADNJzcw3FKQEhJXJBP7S6QtbUUQacDj2SW4c9qXm3MC4cG72J4r4vY6Z+/qHk2AOLQb1+DYc4taul+pL8+37AKRkD+SImJxfLebsp/A8osJ6biQzqn0ou3PJv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXu2+1PNgsKEoaujTGFZZ463t2/NYO3YnlcOb2jsofA=;
 b=Onh0lT+NFQWk5s93GdR5FRU8ck7SCbVTW/LyCYhPf42igyEAMEu7aBg60UyjxbAANtQWOWpcyXaSqvXSwVS/khzO2BkbXD+6EblxV8aPkOjnl1dv5+elhfErk52jpY1h3R/i6sHc8K7CWxNNHyDc53d8yMmPAH0++OjuIOuv3veyxzF/T1sBKPW1SPrxg2hyfDHgZ+170mj6BMAwEKgp5/Ttp0GAXuAnuVQv+DLw5669VSAgjOSG24eLmZ2qWiy9UyqIcKt2XKapNp9EHHpIQ7OQkT3nDkZQLrIBNsHCToVA7rs9GW6iYfR3h9lKEuewXBK71Td7ZAyMwB+lXCWI4Q==
Received: from PH8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:510:2d2::18)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 09:35:06 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::2a) by PH8PR15CA0012.outlook.office365.com
 (2603:10b6:510:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 09:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 09:35:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 02:34:41 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 02:34:40 -0700
Date: Thu, 21 May 2026 11:34:40 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3] net/mlx5: prepend implicit items in sync flow
 creation path
Message-ID: <rlxxgzsqr4f5za2acjan7iqbcmi5ajstcsco3rjxnwmdllbvrp@5ycahx42qdgi>
References: <20260420085236.2356342-1-maxime.peim@gmail.com>
 <20260427123217.510662-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427123217.510662-1-maxime.peim@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dadc12-f100-439d-df50-08deb71c3dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|13003099007|18002099003|56012099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: uZR4/2gQORv7usNWPhoqBK8q/lYVSJpoWqDODG9Y3hRIXU+ZnuFv32SQBJeAEqbgDPjh+sVVXw4hXVm7cHLkAd3XIj6AXSB3+9W865EvKmn1xuCvdak/1azoZbeOAe68+NAlCXuOlTZPHAINZxkgjYI9vLYsmZ1Oxk9TnEM28ChxzXj9sys3UjaX270ZrvXvJfX4sX0qX6p9C4/UdmRwumuq8KhZl8o2xGhI6AMI9unt5B1s3nGz3XH2N8Ebln8/efRm5P96k53KEY2l/8nf/lidp5A+h2cgyU3x1r1yGJLHHC1cdivbZStfrOAYRrUyulp/J4jfthBbgq3o3kosQ8Jnbn0uzNBl7e11KqFXm18I75G2WJse5jTViDE+gKc6fIzm99c0eYJAfI7MKBi6B4fzMrTIYg6aOSrLJy3WacgnhFD3ytlrKj6uPp23Ssnu3h0y0C4s5vQ+ZUkhrmbRagINQTYz+S41wnZnYEyjV/luU+F5RXgSyXAocgVQXp8H0U4Go4oYB9DJGS0D03adRsZ2+m2p9aWs2H5Pn2Yk/xK11gM5KotCbQKMKjXnjPVV61g6Xcr2P6nQpSjLniyagOfOlT+zzzKhCHoX7qbRsQCz7tLeueKiiuG/l56IrHgCb99ZqNgW1f/x7ibHWojXPJCoH/gjGCTtCxsrAnmtl5llmh6u4BmGnBe8FEEmgOVy746UAmTADBomLLtMhJAE1Fod9qdWZJGJL0p8usqnsR0=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n7q/r2U3eda4bBI6pb7OKdU0J6EFldU6hPyPs1/FG8Zz3e+UAKvw3Cp2L/l8PWesvGsFEoHzooaoA5QcRtGFwUWUX9P4twsxGpDcbmYdcbjxuoYLSBuy36rnCpN/kQ1LssNEgmFUpA4lU8B8ymXlPfhYwq4i6bavn6Yo+sjEk5ipQHDJ5tJEcHORpyLwhhSLSs5b3NsSAo/MOdwk15zbRF/JT5f98df98N4KwUC3SFpdVnU5ILeU6Mg0BygYzSI179dhlUyVirqvKjd1vr/txmA0PDZnxY1WbIzHRjn04o8oSGl0pAPPrOyT1qLsv8akF7X43rK6ZZ2BBfvjh++enjUdtQtxCzwETViKj8fvp/jyroP1eIv1aGf2aojVkg957PUdb/agdFYR10GSSnxkwB1h4eYDnPJsojKZRe4AQHVa/4/y6LoQTMK/UYRG/foq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:35:05.5730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dadc12-f100-439d-df50-08deb71c3dcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

On Mon, Apr 27, 2026 at 02:32:17PM +0200, Maxime Peim wrote:
> In eSwitch mode, the async (template) flow creation path automatically
> prepends implicit match items to scope flow rules to the correct
> representor port:
>   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
>   - Egress: REG_C_0 TAG item matching the port's tx tag value
> 
> The sync path (flow_hw_list_create) was missing this logic, causing all
> flow rules created via the non-template API to match traffic from all
> ports rather than being scoped to the specific representor.
> 
> Add the same implicit item prepending to flow_hw_list_create, right
> after pattern validation and before any branching (sample/RSS/single/
> prefix), mirroring the behavior of flow_hw_pattern_template_create
> and flow_hw_get_rule_items. The ingress case prepends
> REPRESENTED_PORT with the current port_id; the egress case prepends
> MLX5_RTE_FLOW_ITEM_TYPE_TAG with REG_C_0 value/mask (skipped when
> user provides an explicit SQ item).
> 
> Also fix a pre-existing bug where 'return split' on metadata split
> failure returned a negative int cast to uintptr_t, which callers
> would treat as a valid flow handle instead of an error.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>

Since you sent v4 to the mailing list,
could you please mark v3 of this patch as superseded in Patchwork [1]?

[1]: https://patches.dpdk.org/project/dpdk/patch/20260427123217.510662-1-maxime.peim@gmail.com/

Best regards,
Dariusz Sosnowski
