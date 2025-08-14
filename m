Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2BCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 09:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7197F402A8;
	Thu, 14 Aug 2025 11:36:14 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by mails.dpdk.org (Postfix) with ESMTP id ACF504026D;
 Thu, 14 Aug 2025 11:36:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0FF23A7no3GibrL3YC8bYCdUVPYOtViS3STvf+w8c3gYRBX58AZ7dPkmrWy/BLsfU54lOXfm4usXelBWdXBOgBULAgyy410/mQESTV2eStPJAd/kl0ob3dwDSxSgDT3osBgeG9Ndb6UBDX777fTKBiR0oeNeCjxfU+j7ZgHXjjTDfkWjPfOFORVk1vUlDMhZ9EikDS8qWieVcA5r2PqPHDaayCBrl228eSYVCIi/8GdwANER6qtYgJXST4f79J2Ud9kxDGUWwvBzk9dfHKZUkGjG8VbKitazxHbFJOjx+IkyuNPlYk7N6A+VCsDVeN0Gv5dQVzPhx+PwgRIH3JEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voptmS41SClL2iOBPhD6s1Ll8DcjfxhlbT6WLbermdk=;
 b=R5xfX82AnPJBtNaA+0SVAGESGJ2bLqFv4Y6mVFGgS2QS7CbZ0GoUq/xEcmqRB7MfDj7vtIjMXZrk6S7UHBojckIjtVcFHL+HS/ariLMtEuPWt5xFkdXv9+QxBBCWlm3PfwwUbP8WZYbIQRCWox3kdgMs334UrlAgX2xZdqh9oTXtL25c+COE9rnT53htG0sQ27BPjjCIU6pCCFZpvSakRGcWArSXeeFXe9QsotIHgaTm4zA/a7dyAUGYPOPBROnm2fDinALYiR+Cpbnosou8bnoZ+g4T5HJ91EhU1Q/HLV+7FTjCqwgXAMomH0jvt4VF+TTJKQGBrA5ijYvkZTy8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voptmS41SClL2iOBPhD6s1Ll8DcjfxhlbT6WLbermdk=;
 b=emd9GnxYswKBUydv949rwff7e/gOHiOilqsa1rXUBGlzJbECA1UkJqaJtHVrP6C4sDb+plsHVsYKP0fhROKNwfSPXOmehrdGiEf+NY09IxZL9GKDku2ypMeMTPJxMoitYQPJZN5DE4+7JTvKLtfy9PyrLgzPRxPl+gXVMNZZSRhHLuim1o7hQJ4lP7hkwciuj799qdTf1/wMpPc8ij/MCMYQeogkRX8xuH14FGTWapge/3+3V+T0PeiOOU3yV1qNulA9Mw2m0ITwwcKEJ7h1mXPRP+bI+VF4r5ao3ckxtvoYrERbKgY6pJqhdkMwIFANRTdcmyAOjaIV0wn73kgheA==
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 14 Aug
 2025 09:36:07 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::2e) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 09:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 09:36:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:35:18 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 02:35:17 -0700
Date: Thu, 14 Aug 2025 11:33:50 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v3] net/mlx5: fix connection tracking state item validation
Message-ID: <20250814093350.5ecaiakzdgvfjbwk@ds-vm-debian.local>
References: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd32245-9242-491c-b03a-08dddb15fdcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fjhtEaWzRduZCN2yfPmbq2CVCALiWcLjayrriulaKM/7kVA3AzPiLpdyBXwi?=
 =?us-ascii?Q?H+xQfLXtsc3txGgy6CH0+U1waQf0JRQzKkh5ew3VnijewORlJzuMELIcfIp+?=
 =?us-ascii?Q?xSUIy+xKaGkYft45na0pqNuf0z30hW2T/kOQd8aovCHRLKekjh/Okr7AglFI?=
 =?us-ascii?Q?BQwcZJHi9uD4OBzKi541H2zhXRlL45quOoyyoDJBTdGFwzieeG/K0X4NS7C3?=
 =?us-ascii?Q?GWjapkSBOdwW3P723jUi1afzd92SSovB14bdqV+GJFLGW7IslncK5EePFxdk?=
 =?us-ascii?Q?cJkW8BH612b1pDfxlSL5Uowj3gHczCcY9BQDQLvnjI9id00sGtx4MhSiG94A?=
 =?us-ascii?Q?Yyo1nTy7mjdjGyQGAoCE43a93Ls0vaXvlQN3eNqi4uYezvenMC83IRpr1BbM?=
 =?us-ascii?Q?P6pr1wFFD3w0UpGv2kuz8yswe54TLDFvtPcuFk9GOaskKOzPGn8QqLg+3YzE?=
 =?us-ascii?Q?2NDUwIxNL0oNLBFCHZdwl7i8BccXRUlnZibPwByeGuxJuUIN+g7G88OOnhny?=
 =?us-ascii?Q?5nAELALoFLxoDfNZC/yJFzgJFisLL44w0TGFlDUbF+fsogJA38aykQnoHQCZ?=
 =?us-ascii?Q?Gwc5ChmBXwNtI5Q4AwNUzpbKnyzfaJeUIjxkOoGepZONJA0qdG8qU8a5Wd5v?=
 =?us-ascii?Q?hkKjzEMnvh8h3LJ90bCSOrL48+szw6JnOlaL3MM/lVk1p5FZaOaYXLpXZmce?=
 =?us-ascii?Q?7QOYlg3tIemEErl+7Ny+5PdIdbholDiEOlGx8gP5uuuutD3fVUvzPwgqojOd?=
 =?us-ascii?Q?D9f8v4Ta+KnlldM3Mv7opQP42TOHuZ332bym54MneBP/m2BVouAg3ToVpuVg?=
 =?us-ascii?Q?bQl0MVdSYoA4JGF8USQNd9VzAJHg5igrTXxUcwRGzk4ASxQDX4yK+k1dZAwK?=
 =?us-ascii?Q?9CTPEpMSV6Vsb5uyDz9iot9IVB69/yITGaxxdEUB91dirhKFT6dc7Dr29ENJ?=
 =?us-ascii?Q?dzsiVimi0CubyFZnnpoNOczBCnCDAJY1tJ/XdjBZgvkmk2oEsOeR8QWflnNf?=
 =?us-ascii?Q?ocpX4AKZd62BxHF/TDt6UQ58+yKxZB7+uitbl5+m8ASHWVO0I022QntU3GwQ?=
 =?us-ascii?Q?HSQL3OSL+MTOEHjpVWylit35g5hPOSZWKF8qNo+K6baFJevQ9ODI55tdBZx+?=
 =?us-ascii?Q?sfnq4d7hjsBjdt0etqcf41yBBtDhOcXVvZMsr97R1PM4LH3YTCJen/HEY+7d?=
 =?us-ascii?Q?H1KQL784NLFxOBeA0CyQ1JWmqcVTR651Efnr7G+rw5Y9dzoNh+hE9zKwBABD?=
 =?us-ascii?Q?OjSl15XaLpVgTtohzAZ3RmoR14OE5EAqOnz9A1AEp8ZgvkOA2nadiw7O1K11?=
 =?us-ascii?Q?8t4N+m7rkqeLINGvzKgOWnYeXHCavnEf3rDaTG6QCKOBQZdQwdV5cTHysL9w?=
 =?us-ascii?Q?2WCFk0g8p/9JTgngqYbyhRkWPHhiy9wM2YV+x0OuW6aM5nMRLbC3CGitQ6XT?=
 =?us-ascii?Q?VFOynJteYGbsAQIp5ORmZaJyk7AcPvqkXxEMxZINS3R8G1aYXy4pLNiyD54w?=
 =?us-ascii?Q?nR2bDnPW5aqJlUu7R8YbTYNuL0Jhfb22XoId?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:36:05.3302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd32245-9242-491c-b03a-08dddb15fdcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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

On Thu, Aug 14, 2025 at 04:58:31AM -0400, Khadem Ullah wrote:
> [ snip ]
>
> +#define MLX5_FLOW_CONNTRACK_PKT_STATE_ALL(flags_all) \
> +	(flags_all = (RTE_FLOW_CONNTRACK_PKT_STATE_VALID) | \
> +	RTE_FLOW_CONNTRACK_PKT_STATE_CHANGED | \
> +	RTE_FLOW_CONNTRACK_PKT_STATE_INVALID | \
> +	RTE_FLOW_CONNTRACK_PKT_STATE_DISABLED | \
> +	RTE_FLOW_CONNTRACK_PKT_STATE_BAD)

Please define this macro without setting the variable.
It should define only the constant value.

Defining this macro as proposed requires the user of that macro
to declare a variable, which is not needed for comparison against item's flags.
I mean something like this:

	if (spec->flags & ~MLX5_FLOW_CONNTRACK_PKT_STATE_ALL)

If macro is defined in the fashion allowing that,
the flags_all variable definition will not be needed.

Could you also please add an empty line between the macro definition and
the comment appearing after it, so they appear separated?

>  /*
>   * When HW steering flow engine is used, the CT action handles are encoded in a following way:
>   * - bits 31:29 - type
>
> [ snip ]

Best regards,
Dariusz Sosnowski
