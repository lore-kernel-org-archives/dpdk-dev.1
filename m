Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365BC28B28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 500CA4114B;
	Thu, 13 Mar 2025 18:34:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DC40041141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741887241; x=1773423241;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3JHoUt6pcRkoIm5hozuVlZJj+ACKF0AGJInquxQ2mzk=;
 b=RUj6qbWu+ZWjBwBPTQuAcCldBvL619bfgU1TSK34E0qtq/+y84+NEgPn
 ETpFc3mYup6Uo86nry3ymeo1KJqYs5ZOL1Mkx9UqFrp5ybQTvSEFsRbyC
 HP0A5q0yUvINli9jvBXGAp8/zp6qEi8hWMBK6xz+JXysaFYW1+Ohi/h1e
 iD7YsZRxoaH2ERK2FnN73OIroy0stzNXoSG932LA1uU/nx0ws9aEibcdx
 TUNPgWUVIfxXuIVclioVCxOD7amnlL8MmHo9IUAvUEcpvztTs6Pg7ZUZC
 sT4TQpgh83F0bdXvWtFNfB3D2LzSthj5MCgVsbPalXKcnVAgEX9ABHyed A==;
X-CSE-ConnectionGUID: DsgeRaYlTvWdZNkeBmgD3w==
X-CSE-MsgGUID: i2C/JltqTNaLfcUE1C4qnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42884018"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="42884018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:34:00 -0700
X-CSE-ConnectionGUID: q5DQ+H5HRXib9NSQOdZ3iQ==
X-CSE-MsgGUID: AEmmWqPDTI+sygy2wKZxkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="151888072"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 10:34:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 10:33:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 10:33:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 10:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAJJ8z+9F3peETJ5aINUR/9ClaXvZncDUrPsbFjjsRTI9bi4eQcQMc1qQthyAcoGvvkhYSw6VBMy4G6hqN1lPHUyzz1sxRhaLoHGfMD9by2Wh9QxogpEIYWWlgrbyQK9I0KUVSE2NdegrXeGkvv5eO0h+d1hOv63tTpv/YENErqTbiowKMpRL6Avgz3uSKMxkqoN0HS6EukigtHEYEuH38m+Xrk3gdws3VFd70YWo2bE9Ky28D3gqAI6OA2BLrjqHsDq9aCK52vGkLy6gyjqsHuGVUd33wAqIezbXihlQOu8EKNOAIrUfnFPCY9UIsbWGrRKHq0fndFIuM8nhFyfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksCl0vFMSVhDWavaVdhgM0NwfRfseVWdxPqoJjhZGNg=;
 b=EFCnATMu1c6FXebEI+1lUjD+lOEb6PsJ0LmkBczT+FWTecT0SDcoXTEwxWiUowcvjHWhoPTBcAECe8QGCHSKHzZhox6O7kJDoL6WWhrWQFdv6WlmxS4rAsHhXSvAfQ485j2/eX6gdKbycGyKvIk9AhI4i20B+D44sm2PexzOaxgn7ngHQQDdDiywM5XDrP3RkagLqRRiXB0Ove3gjHI6uYmumTE5+rzHoz9w68/xGWFbXWtwWSxt1y1kbWYfBFWTnNWywZqNj93+35PQd1yl/GCWbVYOYlirRBSLGDxuJ7sKSjoML2kEOR0o9YQAhUzwEFEbj6z20x4jIRvqJ0w8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:33:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 17:33:57 +0000
Date: Thu, 13 Mar 2025 17:33:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>, 
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v4 0/3] fix how large numbers are printed by hash tests
Message-ID: <Z9MXAEFzaQ0Ab5HH@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741884706-21546-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741884706-21546-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:10:234::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 85186a11-6bf4-41d5-2581-08dd62553bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1dwmwJoBQ3SWUFOEa7fL28v+SVUanRqTTZJuc6djo7ezP14QyvqKTi47RrDH?=
 =?us-ascii?Q?jh4/OTIkgMai68dO5fRp0bL+qFtPaoHHMUh0UQceIwFIYxQWUbc6I/9ZayPL?=
 =?us-ascii?Q?CU9/DQgrB8+Dj69pKa/XRBLJmKPV8O5gx9rLoOcf1MiKrSfA4v8H8uR1mzII?=
 =?us-ascii?Q?DfKKBZbNs/sLkakL3L5qkPxuSDatLnDpv63sni0CcMzT73ujbZUOi1uZYg1n?=
 =?us-ascii?Q?brzBFmBQBj6DUXKFJHQSPCzDkpmTriAjeuy/9uAg73/aoQB6LgSfMMI7nv11?=
 =?us-ascii?Q?MhdbnRffM4lKkFgmvD5MTm7St4lVgsE69lPyNd+bDoVueRcNvoDQihPhAYXC?=
 =?us-ascii?Q?AbbQ6LnZVbi0gEEWoEHDQwx9Xe3x8dpFbYfse6A4IAIcGyw7xsaDkpQZ3cLe?=
 =?us-ascii?Q?W4GREFjDANQ9i3BxEwHDZJXSCQ8IWhtJ04Ye/eXSAYkB3H7xhJ59zz4xkFPe?=
 =?us-ascii?Q?9AfjWi8YqPapuKPTbSF+qL1pwd2zbX6vZiWGwp0INAcVaYjs/Hf7umuvRE/G?=
 =?us-ascii?Q?QOLnsvK7s7FbotONe4UxBX5g8J4ir/f+gDNP32iENOizp2tBRBVaUGIcI0l9?=
 =?us-ascii?Q?RD173FLnf28EPzzzLhbN0RhpdlKQPB87jFIS40KXVsJ3lafvW1ajmW7nkpyN?=
 =?us-ascii?Q?0VOqiHmbMu5vpVDz7Mx/gUStBCXPwc+6ilMmBoymNdm7sXTS52NUcEDQraGx?=
 =?us-ascii?Q?rtJgnJ5ucc1RDEqpTpTNyUkqRq5oIT0IL+Es36QCYoFFMgN4QCZ7S4UVkuJr?=
 =?us-ascii?Q?HBkKSadxCNvSf9RR+SfofQR7RTXgCSmZAacg2mE/jDZ/nurjebNLz6oobBdZ?=
 =?us-ascii?Q?Cxk7BuvOnpbB9M7E87umAs1DqpAqx6hkAFHiMGSO9LocLDn9dO6VnxvDBIfy?=
 =?us-ascii?Q?OgAOzu+0hum1+nNZGgI3Pwa3KSqySJibPGYVwzgJI828woQELXjZHGL8lQVt?=
 =?us-ascii?Q?GPzEghCPIarm/OQjpIe9dJJ7QBY2smtley10Cuioou5KlWw3eAc3Eh7Jtu4x?=
 =?us-ascii?Q?0vrLHGW5EUtGKZ+kVLdRzV7PiNygxlyym4G3wcoPQRD4CDpQDXZbzVwxkYkS?=
 =?us-ascii?Q?cAVIFc8PD6jqviICPk6DvuVo/sTo8AqnztoUStI9ciTkDg5VPXTWu6weLBlO?=
 =?us-ascii?Q?gXwkHJz7PoMVrXJZdm+Zd3w3UEF+/ebcylJQ+TVFNgewzdS7HVzoi6mg9pYd?=
 =?us-ascii?Q?UozFZB8Aa3V9jiZkCuvcpH2dhh3qTo0MeBPQ9JqSNNOFJ4ZOFRZ5FzuFHMCy?=
 =?us-ascii?Q?EVw9lo2ZNryEw4Jh+MrJwEWbXLNhaj9vFgJ83E8nsXLDrK5mb6rCZG815onF?=
 =?us-ascii?Q?8MBbtgUZFHnDVW6wvwhIRMvOpVGFWT2avyip7c2q5UsJjVPhKD22xkMgbg1D?=
 =?us-ascii?Q?j2U0lqsH/45G2XOpYB0Q2ViTAt/6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUru2kcoHpGJTZ0cQpGWvbWckDybhhU/50WrFeNpLvCzpw65qW/tvRraMQGj?=
 =?us-ascii?Q?n5+j7IOChKHVnOWUSlTXGVqnDKKLPmZDgF36E7+KNX821HbaWosnuXgjXfXk?=
 =?us-ascii?Q?kT5Glw8I2NbnL+lxzfSwCspWASI9CYjUvSUy4PESH8fWKWgelQoTlTL2PXZ3?=
 =?us-ascii?Q?hzUCNwe/vmc4alcTxo1A7hXx77Z7r8iodPzQrA3dW6yZtpfIoUuYHLTaefqt?=
 =?us-ascii?Q?SHVpcc/oFfWeNuobx9dOBv6T4Yp2BeXXfurSKl4iiMSPJ1lYHYukvBTZg+/9?=
 =?us-ascii?Q?M7oR6JnZ+b4wyKHpr9S3UZ0QuyBh9aVVQT/kFUW+BcTOItx9eFHKQHQu5YFc?=
 =?us-ascii?Q?BG+tNg/luBUKj6TI7vG0LgaDpi3HPnJnmzwy/nplgU5p+rx7t5fqYnS0BlZM?=
 =?us-ascii?Q?uFsKi9n9a+ePXRMhv5R/Yh4m5Q/LRT9ABf51eBg6LW5kWsY+CrSRu1/ad0gE?=
 =?us-ascii?Q?VCnWrVH7hTxR/3kuMyGJhJWDQCohJiux/ptOr3SjLBOzMdeYE8Hp/5Zj4+Ji?=
 =?us-ascii?Q?qOhw5Iq6VbwXaPBCvr1qoLGwlvDFFAlNKdCTTRfIO4EViq023zAHB7ray+p1?=
 =?us-ascii?Q?hyD31eVHDlN41OEY++n4xG3Fbansk8USWajm6W0QLHLUeA8bOH5eb+t2o8Tr?=
 =?us-ascii?Q?DR3yIwaIpyD0ygpJd5bSZKKWRp/VbRxCgzYhFnepgoGuR/kf3Zyt0/uJck3h?=
 =?us-ascii?Q?xNzh3+qoIdPp4qQo010gWiF2RtG0aJLTQPS+u1bwLecwXa1zwK4Fqj8AJpqX?=
 =?us-ascii?Q?kMgxwjh6oQnq1UDiK83L3TNIJy3qPfEnXUuZiN7vxxCfP9bAihgmouEiFew4?=
 =?us-ascii?Q?ClvfhAPnkXcFwoDgk/eDFkyW264GsqJSCcgk9vk6r0MHGVDnrzBTtIwh5cHk?=
 =?us-ascii?Q?IN/vNuNZK4ZlzxajNNWkEAUxCVQzJaH3A9s0L/vG18frMag2qsKSpHr3Gk2y?=
 =?us-ascii?Q?Z+7fUCeCffecsc4T9TWMrESL1yKFOElJmSf0m28R2S2Q/qWBVI5MvJjzTpDh?=
 =?us-ascii?Q?Ui0QOqFFLavO714GsD989ZsJki0AaHl9+byH+Vn9eV04ojdA3FA1xmKS+vZR?=
 =?us-ascii?Q?UANobnGCeEgzpqHKhCj0+oRF2BaGWo0fW7LdOw1i6DYZ0lJrkarXZH2y6UYY?=
 =?us-ascii?Q?Offr81Th1mx1RP81c0IijjC12/nyieb34pqbGU0EwPoSWAtf0N2XP3BUiSLF?=
 =?us-ascii?Q?cyE5DhcNALyWRwybBzHAMh9nrMepbrwm62gCXDMlt+m4q2dxSB26pJrn9CsS?=
 =?us-ascii?Q?NnnivYZ7zpslXeHX8/9lp5EIXC2DZogJ9uMUvP8DZGMbv6xXdBF6A0iZtuc5?=
 =?us-ascii?Q?/SlUvKexLMi+5jyCrKX223pZKlyTgg4ncPJgiyXqhYOGZuB2/n5Dll9uM79N?=
 =?us-ascii?Q?Q9hccA02oTvRYfboL1kG73i9A6sC9tpd5oPbjcRoxCKbawjxH68aAkhCq2u4?=
 =?us-ascii?Q?P1IwIgatyl9V2BgB7jLB96Yg5wrUGLv26KUDUinrb+qi8gVpta28v7Gkj6Eb?=
 =?us-ascii?Q?3374wtYMsJ9CjKZWWD2NIhfhwfDQ9ZsYJcQKeYU6DHwIbOXbzXO2KYQZvqQT?=
 =?us-ascii?Q?BYlf20p0BZ7WEU2Yu9w8CuvhaigKdXKdOQCpry3XntHXU5xCcBYL/5U2M1pF?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85186a11-6bf4-41d5-2581-08dd62553bcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:33:57.2975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPpP7g22iFNYp3fRhOidolegNLeQK0rTdW0OOY+UdbzVK1/DBFngU5b54oa0WTSCly3zzUqeK7wt9eIElhi1/Vp/ySzefmAj2aH+vwldPx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
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

On Thu, Mar 13, 2025 at 09:51:43AM -0700, Andre Muezerie wrote:
> v4:
>  - Added parameter "unit", which allows rte_size_to_str() to be smarter
>    about the need to append a space after the number. This keeps the
>    function easy to use and avoids the need for complex explanations
>    about the space that could be needed between number and multiple/unit.
>  - Changed the return type of rte_size_to_str() to be buf, or NULL on
>    error, allowing the function to be inlined.
>  - Removed a line wrap.
> 
>  v3:
>  - Added rte_size_to_str to version.map (marked experimental for 25.07) so
>    that symbol gets exported when building with -Ddefault_library=shared
>  - Added sample outputs
>  - Added a space between the number and the postfix (if a postfix is
>    present)
> 
> Andre Muezerie (3):
>   eal: add function rte_size_to_str
>   hash_multiwriter_autotest: fix printf parameters
>   hash_readwrite_autotest: fix printf parameters
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
