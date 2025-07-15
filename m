Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA6C83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 12:04:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2735D4028C;
	Tue, 15 Jul 2025 14:04:09 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by mails.dpdk.org (Postfix) with ESMTP id 4D4BA4021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 14:04:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClFUuxn6keMbzRqgrtrcS1ent4OS61RcdZEBk10xrlUlZWMlikBKle9iTeYZYbOd6zMaV1e3rnqiN1LRPk2EYCxrwjpfkYQLr/6Gk+JeRdfe9MDaXXbv2jxRx/ITqNl7D5/PqMQ9uU551Lp1JrqGMf0lwRFai1oqK5TQRZGi7qAmr46bDj9x9no9hnx1VfadaaslqRr6kCkk+6jNcvV7tm4YEIll7ysDKmf8RGJkuc5mQG0f5z/3tNR1S1oOgXFe9emORsQBNduesQF2J7mfBUlPt1k+X8LFl9f+ikmagA8979hH2oue4P95SudPEaNukEga4gPaC2LkRomjtsLRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aWrrPCt8SiYRXLNNIJDfklMxRmsvC29LkytUQ0jpbE=;
 b=x3lcxFclcwloqp5N81KxaquJeDP4uNhV0IUQ1MFf7CX08MTjA5ikdYwr34fDA+DzBhK6HxkpiKbrSQoXg5qKz4iFitdvSRACa3LgMKk6jB1Nz6h2L5JDkONCT1NJmO3gSC6oQsO9clRc+BZuJNEExZ0x5a8k5iSbDnNBIRtHXwBxiIY/pV48f03EaAdHVznGuhiMWQhpk4boqFjppwaFHCovgCZw1QqxocKQT8IbtVYzC3+JJ0cA6ZA4MGxNSem/6k2Y7yBnPbhuk9bnEZyU/zSV/GSPsnPwLTwA+qdhzYPkCAIgo245TyMLR06zQSN2Ls9BaXc5V6DqsEhbmiWaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aWrrPCt8SiYRXLNNIJDfklMxRmsvC29LkytUQ0jpbE=;
 b=qG3hqI1HOiYizRjzD4kdIhyyydT1aI6orLAQAMFI5ezZbpiSvacmCAoqbo/9Ax7IIiqckAXbONyJFYOcPzcqNshfCgaHsTXVlOixkC0vjH5nq5LoaMpdh3I8pvaIYRexRIi7egKnMWw99sgV26Xik+0nlte1KBEDuwWfqUY7+dsfclkl4nHAYb33bNftqQ0olY+ArA5KtWfI7sGPb3e6jtC+cPgVAv2pCC2N8IZTJ4glJom95tmCeAK3VCaJsikSYOZTT3K4HaEP6t1KUSGrQ1eKuxsjBNHwWfE9KxPRwYUkSJEJKohGwkdJFuQK3Ug7hPZ9l4cpFWRLz/0IFcCqvQ==
Received: from BN8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:408:c0::33)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::988) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 15 Jul
 2025 12:04:04 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:c0:cafe::a7) by BN8PR15CA0020.outlook.office365.com
 (2603:10b6:408:c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 12:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 12:04:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 05:03:50 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 05:03:49 -0700
Date: Tue, 15 Jul 2025 14:03:45 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] doc: update parameters to use for mlx5 on Windows
Message-ID: <20250715120345.rnr6x5bm5l3wqw5m@ds-vm-debian.local>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: cb214e5d-2785-47f1-9923-08ddc397b11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vM25rRM7OR4BPKNMLKnJ5hR2hI5GMOZpYDC0YWzFv7Wrl7A5elhBNntkAIVH?=
 =?us-ascii?Q?fJh9sjgxSugaL5VkTH9PvNZf5MpAwE9EAeH4LPGNixBp5XhXOg0jh+gYLWKv?=
 =?us-ascii?Q?AxgVwfUX1vv3BITnyc0G8JmE33ZS8VOS9Sn7OSw1l+mATlkN7iqGDQRUH4s3?=
 =?us-ascii?Q?a8hvjg4Lpdzq+5/C7FcmA0N9O+ZDkmPfGYHxi35xxTpegqJivyWNAPckZgZO?=
 =?us-ascii?Q?ipBLew/6sXCWZtWIgQjZIZjA208BuwCiHbtFVLfu+gXutg29J6GbUvVoz3IM?=
 =?us-ascii?Q?w3khGOc5Y+6dlTz4744+tlVH9EUFcZ2wJ0gl/TwD7vur/J8pmcUFCMD/MI+c?=
 =?us-ascii?Q?8rGg48p7Efl0oE0jYB0mqSqfHeJDS5N1GHvMGT25t943jbLR5jAFyUq65s9A?=
 =?us-ascii?Q?Hg6q60zpzDGUpurbHszA9RQkAeLajTpQnHyViV1lIt0cQS9m/tB7burNBJem?=
 =?us-ascii?Q?Wj3MIfLgLDCO98l4DOYD2b5CMe3BxStw31+L3zKkRpt1dcb3MYsZdrlNPPTf?=
 =?us-ascii?Q?+1MhtSSaE5ma3/rmeLCcmdRZK+ExUwzW63f5Rgagt4/KXyzjnIH3gN5Sqep9?=
 =?us-ascii?Q?+Tz8ereeT4CSqhkn5adABjc23oQY2EwB9LKGnOAoG5WXXSN55TrITdHuC/iH?=
 =?us-ascii?Q?KaVHa1Rs0WLSFoE0s1Oth4VeIRfxfPBudspGam8UtOYFTq87wLX9A59ZvsU8?=
 =?us-ascii?Q?AhWWqEzuJJqEWiCBA1Me4fRxLmw15IM8PLtdhDzoCwy5B61gA5wjaYyHGSLj?=
 =?us-ascii?Q?73iUdb3qH4GdxauPtcDfnABDODo0iqTp1TL/aHpGvnN0YvpqoLZqJQKBeAqC?=
 =?us-ascii?Q?2L17/hz7CRQyznyJz+ghxPiaQMsZxQFR1whKZo+y3ZtyRWsapBaP8b8nbwfW?=
 =?us-ascii?Q?+enny34WW5cz9OGFqpJ/0x+Gk8kCkgcJllGQ8SdFY9umMZdOTKzrCFlINJSA?=
 =?us-ascii?Q?btJIyI5s0jpQpPK5PZlIIoY7wrZbQU1ObOaCpjdO7QJtTj4jeKk3HA7TIyau?=
 =?us-ascii?Q?wrXJ+QlO33PLv4aSICp1zYbUFzIsbreDXQvpxBxOirnAbA6trsQOUSsD36me?=
 =?us-ascii?Q?WMxPEqxygeL71HzGLO+yUggXFH6wn8VVQADnUgXpS9+rLrcZIncWWcXiLCLM?=
 =?us-ascii?Q?F/+wy6uzBF9ucbautsK5AU8lFJpjRAqARmeHRdqFe2MPb4cHlhemdtv81F0h?=
 =?us-ascii?Q?w9RDho+7ODk8UqV7j7sJ7L8oBv69njRtfojB9KSzg/9Dq8Y8QDnMkKCrFHR2?=
 =?us-ascii?Q?fhUNKe1MIxarFiexdKVfDx3IK+K3Ixcpq3Cy2WRxHZjoARAZm0+rVtagiHJ9?=
 =?us-ascii?Q?6GSMKtmHi+5r1mg7XByXwAl7NulHYmvxLXD986k+yX1Z/JkE8m3XuKjU/CE+?=
 =?us-ascii?Q?awDsj2ruVvFCLGLfJwmePaFHwulJHKrqb5EBLh4p5H8wqRxAFpQsiRVOjikP?=
 =?us-ascii?Q?CSJYB2gzIaBHLVgUZmOl4dRk4YZ7wkxEqOzn0ZUxihGUb8V703Ow/SUa6aPi?=
 =?us-ascii?Q?D7AVY70/3XZ279XTahiYdgdAaEIUulZY2YAm?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:04:03.3588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb214e5d-2785-47f1-9923-08ddc397b11d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
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

Hi,

On Mon, May 05, 2025 at 08:22:41AM -0700, Andre Muezerie wrote:
> The linker parameters to use with MSVC and Clang differ.
> Showing explicitly what to use with each in the documentation.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  doc/guides/platform/mlx5.rst | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
> index ab3107209a..7a5bea3b49 100644
> --- a/doc/guides/platform/mlx5.rst
> +++ b/doc/guides/platform/mlx5.rst
> @@ -268,14 +268,26 @@ configured by the ``ibverbs_link`` build option:
>  Compilation on Windows
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> -The DevX SDK location must be set through CFLAGS/LDFLAGS,
> -either::
> +The DevX SDK location must be set through CFLAGS/LDFLAGS.
> +When compiling with MSVC, use either::
>  
> -   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\"" "-Dc_link_args=-L\"%DEVX_LIB_PATH%\"" ...
> +   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
> +   "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" -Denable_stdatomic=true ...

This long command line can be split for readability,
using caret as line break:

	meson.exe setup ^
	  "-Dc_args=-I\"%DEVX_INC_PATH%\"" ^
	  "-Dc_link_args=-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
	  -Denable_stdatomic=true ^
	  ...

The same applies to commands for clang.

>  
>  or::
>  
> -   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...
> +   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%" &&
> +   meson.exe setup -Denable_stdatomic=true ...

&& are not really needed here and
it can be splitted into multiple lines for readability:

	set CFLAGS=-I"%DEVX_INC_PATH%"
	set LDFLAGS=-LIBPATH:"%DEVX_LIB_PATH%"
	meson.exe setup -Denable_stdatomic=true ...

The same applies to commands for clang.

> +
> +When compiling with Clang, use either::
> +
> +   meson.exe setup "-Dc_args=-I\"%DEVX_INC_PATH%\""
> +   "-Dc_link_args=-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ...

Shouldn't clang linker parameters stay as it was previously i.e., "-L..."?

> +
> +or::
> +
> +   set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%" &&
> +   meson.exe setup ...
>  
>  
>  .. _mlx5_common_env:

Best regards,
Dariusz Sosnowski
