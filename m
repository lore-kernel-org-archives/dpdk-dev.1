Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA4CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 12:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8292240262;
	Mon, 17 Nov 2025 13:03:00 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14]) by mails.dpdk.org (Postfix) with ESMTP id 4937B4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 13:02:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXNNz7Ra8C7jsNuP54ehUhCZWAc30yeyz5cyUcE/H+3o8RZlI9pPVSJtXjO1iTYt3WXO9tuSXkImLw0mjGFAPLuDz+Ppa+oWgJP5kGjlE9+FXWBt16t0a9y/ZSBbp8/MwKYFutudJXap15ey2Ne5ja0bjFnqAziNm0guAYOA/o2XE9TcTfn82c/hO39K/KBKb7HhKz0nMndbP37PQIniCpmrBATbelhYWHC0Qz1OBGB9Q3OMcHlt0Zva14l+S/mk/eqJP6AjCBMvxaprl9D9pc2llnrvS0JOu0jClPpKISE97/kSmnMrw1vdZSKlkXm1rsSbB7UvX8OthR91P/2cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b+rmtDZsM8fT1fD18VidHJX6wiwk6MdP4rbRRG15Hw=;
 b=EzaMgVDNNrnXAwr1inscOvFCFuKSTxteAozq2d8y4HG4s/KSLWr1aF6NlsNgGBx8uq0O75KCrLuPAJpSrbjiB6LTk2IQBCbjFgDewdSlWpHVx9hi7+bRPcM2sV1MSqCIGy1HVlj64WDyQ1qam3lrudKr5rh9aSq7c+EjNxgtxk15UxwtxmB6d41yLFk+Mqu6q2ZIOcc2YaCPSfKnMLjWyj5wQ/Y6eZis0neusMaDnrSq28mTlQIHzgWwPKXQIu+vL82r5pu4Skyy0QyCgBpaNu+s4E4w/IQNZzOnKzE+QORVKq2VSVqDirg3uu12IHQfOCq/v7/LclL+VFa2/E+U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b+rmtDZsM8fT1fD18VidHJX6wiwk6MdP4rbRRG15Hw=;
 b=Ms2Awtw6oueYVQzimckJcnvnIG2VOE1a62NXK9NZGM2R8LpYDTQ1ifn+wGUL9jTfjpgMh6TBZeKWGmh/ZU3b7QIAOFTiwipUGxF9BLRU9DvmVGCOf/NQOAptK2cNOmZzhQ6NwTrHZ2OCL5Lmc/yYenPmvT+WhjUpOFXUeQoDYLTbQP0E1Y7MeydJ2Yq+Bog5c+a7k0095nuw0JiDw7Y4PgeXAyTprZlFPFAN9Q2KUwLQNJX5Q6DBo2oLC1BiVpsGkLYuK5ezuEKqgCcZiq1rqExCiyNaSI6CoWKLmEwzQa7j2N43/6QDbS4mnXKM9Ha4JQBvCHA4tvRQL6K0auxW5Q==
Received: from CY8PR10CA0023.namprd10.prod.outlook.com (2603:10b6:930:4f::19)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 12:02:56 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::96) by CY8PR10CA0023.outlook.office365.com
 (2603:10b6:930:4f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 12:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 12:02:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:02:42 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:02:41 -0800
Date: Mon, 17 Nov 2025 13:02:44 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <thomas@monjalon.net>, <wisamm@nvidia.com>
Subject: Re: [PATCH] test-flow-perf: fix the incorrect array length
Message-ID: <20251117120244.ovgvpkee4m67s6f7@ds-vm-debian.local>
References: <20251117072858.9318-1-bingz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251117072858.9318-1-bingz@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: c930dc72-ac37-439f-50bd-08de25d13e69
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5eXuYafthdPV0Jv2QtPp1rc9DtalFepmZ9gZo5px/FpyJTO247hPSv2fjcOA?=
 =?us-ascii?Q?+5cmjHaanNrDC3x2FkKxMzg8fPUIoPMfBPkVEqTCcv2BMo4zUQXPGR8waG+j?=
 =?us-ascii?Q?i/QBvh59YMm/catu6k4cKdDJJDnqwDBfjyumH/UclscrkZXVLb56mtCF+Z0H?=
 =?us-ascii?Q?Wbn+3iXCC3CdpHYTiCPlsodGyC0MnIkelqPiOBBvLoyLtqnMAWBWuaz1VMSj?=
 =?us-ascii?Q?bw4dvZRoY6btF3/nXzu0TwKKIdi1kyEkWL9ZIiY50dgyDd7TKWDcsDdSdA7H?=
 =?us-ascii?Q?nrR5FltZ8CK5S5r++Ln7U9viJbILKp46bTpe9YWEw4Tj+/P+tSX0UBxKNrGX?=
 =?us-ascii?Q?yznbcDHsdpSXz1UJmZ5S4vY5lpEl23XCehXkoiluq6qcFmPj56BM/Dd4qYhH?=
 =?us-ascii?Q?poDJ2S+niTa6aDbf//SNUA792KgI55O1NfPKCcb0LT6NW2k3N36Unuu6Qp+y?=
 =?us-ascii?Q?9y3+3+Ws1cEIIpAZWHtvLZly+aqg305oFPuMrIyB3EuqFKgeH/9b+yn31S7J?=
 =?us-ascii?Q?G3y5qjtyZGy6ec6NBzKlD6uuVb9CLs9ZDWW004TtA+j5CzjTn5H8Sut8vDt8?=
 =?us-ascii?Q?ZgFs5vO1yCgc6W0KJvxe9F6S599XebrfYrjLRnPYEFDh+BQeZilbA1LdlfGC?=
 =?us-ascii?Q?gB6AbG2SnL0QxiVkJ/Hz1rMK2Siyn94HZt73MoiY8qL3uafjmGdoUt0A9UEv?=
 =?us-ascii?Q?RZhl/pbOj+yJRfyxyEpcfZGCqUTTeFVz8V3t3DSYbHy+UhAcTUZ/6Ojin6Aw?=
 =?us-ascii?Q?NtDDEunCLBppbOmvr98fssv+DPwEx5PGbRbaB7JvXpqKWlmC2KB+Rdj7HY1I?=
 =?us-ascii?Q?oNUMStnvpnfCd9a5ux1JObbPMjMnhfd+8nGdDbu1vLj/pSEIzlsk5um/8ZXZ?=
 =?us-ascii?Q?OoMiHIFWnOiTsv8PQz2Fq2yNmvjIfmMoU93iQyRgQ+/uu0MAHmR6wOYyixwn?=
 =?us-ascii?Q?Pzjij/pijYlDbFKyfHrbvdVh7Ugko6RTdlL9cLLRoWGHcJ3M5Nc3ZlnYEWqa?=
 =?us-ascii?Q?ADSFb9Rlq2zEEHtOTBHRPCLnEDZ/I8KIQC92AoHkSDXUaueaPpdNI/M4c0hC?=
 =?us-ascii?Q?Q+rO6kcA9fWH4l0r46zAMWWba/rOxtYYw6fL48WaEklAzVq5iwoDCkeouqsr?=
 =?us-ascii?Q?6cG0TwDm9OITV3AJ6Nw2QiOY/PpbJz8s/fOPvEuWNKasryGX2SAb2dAXRqzG?=
 =?us-ascii?Q?saMKEssAUlQcc7ttnTSgtnjeaWDVzjQ3yuen18bUYV2w4qTKFtAsyblj5WDZ?=
 =?us-ascii?Q?ctzp1Xv5FsdlEFonx8InIHHqDz25T3kuvt173dL/S/we5R5sdxQyuAF/FkFI?=
 =?us-ascii?Q?7APlqy/8VHE+kJMw8spAoWEXyKKVBuw0AqOkKPhobx3/H5+tCjQkfZuHJF8r?=
 =?us-ascii?Q?p+YNEBPB0HkisxT5kky3q27BjnwPCVMdtc/A5sIJxFdWqbUuN+xC5No5aDOA?=
 =?us-ascii?Q?Y+y6KmyuEzghJV5eVXTkfiU3uNzRtjuHUDNxHH3YYW43xlVS7G4KW6qaSrbz?=
 =?us-ascii?Q?RsxVCfgS4OnjK8rx1Z62pU2/mFOrMwlxubWYf8gNxYkK4d1J64FGBYKroKaj?=
 =?us-ascii?Q?TKEqVkCIEvPeUPTgyew=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:02:55.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c930dc72-ac37-439f-50bd-08de25d13e69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

On Mon, Nov 17, 2025 at 09:28:58AM +0200, Bing Zhao wrote:
> The array used to save the flow rules pointer was allocated with an
> incorrect length. 1 more rule space should be appended but not 1 byte.
> 
> Fixes: 070316d01d3e ("app/flow-perf: add multi-core rule insertion and deletion")
> Cc: wisamm@nvidia.com
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Looks good to me.

Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
