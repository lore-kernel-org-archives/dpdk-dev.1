Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09985C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F1740655;
	Tue, 25 Aug 2026 14:19:04 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by mails.dpdk.org (Postfix) with ESMTP id D08F4400D5;
 Tue, 25 Aug 2026 14:19:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et66IGhVkskZN4xI6FinkVT/FA/VL2yHkd+i3TYdKkP80mM5Fts+bEIfGiFXUMtFW/UYIfToE7UEzrIoX2tMe2nzr3PTleZVWBhc5xJHfbOVGEWWIyIrqRnkTp1m6USJwDn0WPXBxyGkMpYUz/QElshzE4Dj/IqiokJdgdUnYgqwPZGCHUaGwY687rccOvyWf6lNNCrKFFHgK6x+C5KdnYu/T7eHaOyCHe2YGHvO6KhnZ85BYJnGXksPBCAzxj5ysfyh3wKC8Q4x7WlF4AY9ZiFTgNeiZ7Mwl+C+KoAWtLaSFfoRK/5Yj1gmxIUvBcq6WKDaslQo62Nu7OeqmqZlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHXZL8iMlOH154QwU67Rb3LG3p20PKCevnFhc2uYhe4=;
 b=IcxJhwEEZhYr3Uxc7/dDtNhOnkKAOh2D8lyWlcLIJ0sFBoUc4SZDR474l7HXe9ZLRmx4xM29yWVI5la8j5Vqw+TcnSI3W+K9ZPBVL7ilBJRwR9WA9Nr8d8p9KH1b1TjeGKp5MqQvuPwh0WzHbPwCYDiKv2fd716PWdYTTtWXPzBGA5auC7C8Tx9J2Mjjhu+9FkWE3yQXX5WuBRwZjJR4QT0SggyNyGrEJHlwxdU7ZEhawIyGND/psxRI2kY+y66q5+60RhW528KvdgB0jtmdnfMtW3tkMggL6hjCzMaXTJ3M8GWGe54SYRD6+Hp6Hxg8zm5fJ9SKmDfyiUumClCk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHXZL8iMlOH154QwU67Rb3LG3p20PKCevnFhc2uYhe4=;
 b=t6uziQIyfhvEl6zMZSqfEPfGXjRowl4B0yH2lUWanXn7bAauF2jM2fhKSljegbCT7I5NtsgMYSX4qPKveEkFCy0VWjTcDsBmZh4DUfag+2CF8moCNKZb9qo1mZQOPp7IrXFfI8bfw781b/HUKUrsj9MfGK+52l0IDeQiXfC0Y8D7zs2+HmBKiWjiavI1SBeJeqiOONMv4gbYD+EA0SUkhz7lLnuUXXT5aMAc4KSXOw076q1OntuhNoFAVfe0IVg1VM+iMx5r7vhWOz2fTKr8XL9FBYtAcnEqDcOV7x5Vvo/orx0eCNcsGSI3GtsCb+2Zf2H8tcgQuTZQl2Ml70Vwvg==
Received: from CH0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:610:cd::6)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 12:18:56 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::6a) by CH0PR03CA0091.outlook.office365.com
 (2603:10b6:610:cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 12:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:18:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:18:31 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:18:31 -0700
Date: Tue, 25 Aug 2026 14:18:23 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: Re: [PATCH 12/17] net/mlx5: replace strncpy with strlcpy
Message-ID: <qilctevxayrrvgza5lsasipqirch6ckkm2jhxlhobwuxjznzub@mvrexxmoan5b>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623165150.765443-13-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623165150.765443-13-bruce.richardson@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: d4afe2b6-4bbd-4330-83b0-08df02a3066f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J7dMNDLN7Y8vkL/dC/B/Tc/w41uXCIrZ4BAHmbxnEgFX95BuL6fK5c4hWz6DoUpeC0RcfT30KNoeCofduMQ5SXpMK2ig/qp/Fpq4cQtwEEcs2Fi5C0TbIFoUPbtPBt5aRKbx6FHMu+X4gnQXyas+uIrW6y9+6suMZTbcytThLUQRfRq/MgwlmUM5jXAhCH9wHZHs5eiQ5/nDJCyfggof2CTCOUNDoQN+dgHgHlPYX+4Fp1peN4wlVoKyL+IzX+3kQ3Dx8ryql4oQ/IytB9PtZrVNR7uhvI2dBIncPmfPHRrlM/FUeixbDqXlrpY9eZlJuWzlkDEPBBcekwJJLAIo8S88ZLzur4eFXdKOXbrzqfyjwxcnMm1ufVGnlghuYzIerwCbyoQCMTur4YRunIruH8QBP0GFV7fahd8VqH22v6Ymnv3uIAZuxmtkMTi52XZX0fAamD6A6RYJu5yrKUXzug9vfByrGEkfws3veb/PNje+YME909Ym8fmjIOQStqkQgmHU27Cgax5JdDxQfn+rOahm67YQxYRiHx/qDHVLqYFgD1rOqev0zReFLisomxF2cQ9DUIekVc4JEswB0hzReZ9kwY4O0FqYWe/iXRw6Axx2uOUHnQt/RMoWzHCmiFDaOHMAEX7iqWU5hMrlDWs+bzANggT5XyccR4UfuoOlJwhTMO82EfBEf5BJHKcttvo83TxS69Ph1Zpq9hnZ4LXpow==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H1GEEJNVLM1dgluXobmeyK2lK/tbUMNaKe55t2tsX/XHnp0aJDhoSb0bwmDcQ0qidP4XMtiWuolA8bCCothllpe9Y1mfMVsQF4kBsnrI4kwRhk8G7ebnqptixKoFx1PaO13SfRyC/bP8bVAyXsa+KnPc72bVudSTCHSjvoIQSeirJ5RGXqqLmjnADieTCO0LiUACg8yba/4UNg11+lA8evYKjn4n635ls++NCmbJQ0+bdnvH4hA3OeuTHaViclGD+FUV6avojLcvp2FxoJ+jOkHDzPjV29KGdSs7g7rAw2/72OWlSwudY61y9M/mijyW0wK7XzThXl3OQ4C1bpTP6wnr1O5MZZcSHgyxucG4wSUuxdSlHMlZZvaXmpMmuG+VTGqPUaWWz4XU+R7kspEuhvvs8X19SQTlQZZ/f2U8SE2Z/CXjJGU1rjxRH+OgMYy6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:18:51.9283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4afe2b6-4bbd-4330-83b0-08df02a3066f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

On Tue, Jun 23, 2026 at 05:51:42PM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: ca1418ce3910 ("common/mlx5: share device context object")
> Fixes: 9e58a50c059f ("net/mlx5: fix interface name parameter definition")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
