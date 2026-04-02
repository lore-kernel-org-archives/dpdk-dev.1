Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94016D39415
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 11:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8861240DF6;
	Thu,  2 Apr 2026 13:38:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7F29D4028B
 for <dev@dpdk.org>; Thu,  2 Apr 2026 13:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775129930; x=1806665930;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BEmfS9bJ6GXhYI2XOUIejxiZwZrMpnAniv7owpXzuhk=;
 b=Zv4WWiyLdHaXCqqqOv/XEEnf0MK77aPXsnqAWFn6OHQ6XMNTXXi6sUGw
 vVSC0m3PtFfWJfId8+q63f9nhxgt0+jpGEam/TTGtqfmnpdvXDpvOYeLE
 FjEUMluqxFaVlWrRYnWMEfCHUVvXia3eXz08A/J9EtPWf6ZP8nEKWviec
 zt3E3HZLuUyLJQNPXB9AZDhV9w8EwnuoEYjRq9I7WZaKISzzgIu4vOTS4
 iRw7U5eEmCwTKpWf/ekAKbkYOULXGSxPgA2+VBvtJ9ywG4xyfcmNODZj1
 kgNH18XymlEqaIFMY8qxK3MT7EqKwmvb9idAkLYlb/wGRDbAIguWYw/DA w==;
X-CSE-ConnectionGUID: /Z3IvUvlTZ6kbpTREj+zIg==
X-CSE-MsgGUID: mudl44q2TFGwtT47nedtQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="86488705"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="86488705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 04:38:48 -0700
X-CSE-ConnectionGUID: nIbcmEc5TQmsGHx0dlweuw==
X-CSE-MsgGUID: BvQXZT3sQ4+zEqk5tV9TjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="231754110"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 04:38:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 04:38:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 04:38:47 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 04:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+B9u0o8qBO+Bol44pdVFLxJcPlnJ7aXjfg7ndk1D04fGzWau7aluYWyMzK6ltzpK5kaJjpi6rO/eQIgh8gzYXA87aBVRjlMvz8O1kkS6C4kHno2y5rY4nijPVxfeXAXTCkyq64aIHJqNV0WN3jc+KhIb9LwiUW4W2AAheN0npi4aCk3k407W442/QX2MYE13wzDmALvq23ZCSlhMGUxo5iFKt9j5tVzx80z2nXNq1/9juFtp7uBBRkTZuVloDWmomuHR0B1BO9qfEb17Be+Ca9zdnyq0SmS+E+PtflG2cwDiJ5oeDE9TXOuWGQb/D4IzwkCOKF3rlPZPRXub4AcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+oM3s92gDsJLUq/rMwqhIEXsy9Zi6BvoNqW6d0SFI=;
 b=VehD1Nj+b7IZKglcNR9VbpI8JX4w8o4+C68YP4bslWE+94bLWuovrb047QbmDibjf+NNU8hFwSIWTkRGCINq2hgmxyBxCFUaMbb755zyvqE/zu6GEgYLbk5feW3wMn6DA9a4dEqhL4SjzUDYPVwKbWor1nGHtQWffIhDKEpd+X44BVIXvrGCKFoEToWljb8nZwOtH1a4Uy308pAJOOq24ifti18yjSMYgK0voYqEUYJ1yD+29U0soL7A9A9LZ6bLw1dgL/fcTxQGhEDHj9reblbY1LkM/d0XKFcLKSZPHhDH08u4TMQeec9nJVSP9cUsyZ8WksitlzRDVtr+R6qkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6970.namprd11.prod.outlook.com (2603:10b6:806:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:38:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 11:38:39 +0000
Date: Thu, 2 Apr 2026 12:38:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] version: 26.07-rc0
Message-ID: <ac5VOtwRuV5I0ohZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260402112803.537002-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260402112803.537002-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: d66748af-1a33-467b-a42b-08de90ac623b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: /CxVL+IJBviRAHjeVrPgY4Iwokmr8XhSsMM+KxGybGV3muLoINkGlm1WdI2gUryUhZCWbIdZ24KSwFqlWSLC0zeEz8Xf8rBVw+hMIufYfHPa44xf/rQZe2Uu3jkxY48+1fZm0bSUQBgANT/qCtEFdTqpaUvCzrvsvl2cAo9mVq/lSWWtaTA3meb7gyiifwfCFLVMvkqqV3DpT0M5xYv2pzfRAd/fvvzHB+IsVjN8pvWBWGG+Hp0XYZu3si+ta1EXZhlJTkdjLWEUGMjyfW636THf9WSuWOTQ1cQzU23ikTO9rnB17Wehdh/DVGfdhLrEoPD4R9jTDwZbJ2aFCDVSpRJHfipW6bn5TGyRKJkYi42hLfi6Wt2yC4CEWRzv1o87UTL735ZWndT62uzuxoUNjjeNGdEN+c9V5h+xNCAwkHLOYckMR3lh7NvnsR2bnL4riVP9U3329oZJkLwNgYk5LFolnp9GnzQfq4FgbbCjhwzoF0HUNUeCylDKpT/UfN94viTKfQRMNklop7v3j/eQQ98DRDw9BcylaDLyUUZuoH/Pdv4rg/ZeXCCf5tFUwVrO3JInX5OpCAmxdOM6+msEzBIiiJyZEv+nKtC3iDQ2pVbUEjdycm16h+6eeIMwNJt0P/8HqU+xFWpiqgD6dYQanvoShfUhxYPpMZsYp6zIMeMS2zPHV4ttX9fSvxGpRkZdi5Xr2vulRMStBnstpq2IirHtUMtimo9BAFTmUDXd8X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dThb+W9PorYmQlR2lcrchJOzJrZO9sS6GOJvfJuQrGOQB2gPm5Q+l+AkyJOn?=
 =?us-ascii?Q?drkVZQVd9YcuhB1ykyW2FPI2Kuyr3SAMpxB7n9csg8XHsP3yU/jww/ChZYi1?=
 =?us-ascii?Q?fRvknN53VLnxVJMT24MGTO5k+rQDgj4YT+lBimA316pJWgtJBVB0/EHXm4Ce?=
 =?us-ascii?Q?sJ77zCrzJGJ7FRYDySGaF4f/RgXCmODmXn87bHxhObI6B9E9UGyFHr6GHhH4?=
 =?us-ascii?Q?52gJvoWEUlBZGz3M6EPXIhwJAmcPIkOZ8/dxhg9eCMhv2j2EZXXxZC2G0OMI?=
 =?us-ascii?Q?sNKrlSZXkJU9Wyk7QBHYvgwYO3vIkUd+YJp0PML2TNXyjRms0IxD33kwScf8?=
 =?us-ascii?Q?93bTwL4fP1EIoHAT/Knl4328YhGFMRNwYHCrbxvBWR2htZB8UQ3bTCNBf/i6?=
 =?us-ascii?Q?1bK9kyqN+k0YM8aeMRuzhGKANiUlauvl/Hl514u80HUD4vfSNfvmAJI2zXd3?=
 =?us-ascii?Q?6mtHmZdKrNZ49y4XQA+mEpCAHg/5C/bl6WJmCxoW43r29QvSCX3GTgMTJn+8?=
 =?us-ascii?Q?tjS2ZwFWhoqLD7//djJjBR+hvxEFb30pvONzjL7pNTHHjbOK9j/apx5Tt7SS?=
 =?us-ascii?Q?TwuIwGNghGPo5mKGQWXA7I2GACT6Rx1vOcGTFUQVfuW5/yvYBLt+caCYx2ck?=
 =?us-ascii?Q?j4XJSCU5yLcvoL58AXCIdIXdQYKzwbVK6QjMxmrTDDcDd5q0rI7AxBs8GhQN?=
 =?us-ascii?Q?T3QaDZd8YkktPsFzkCpq/ElZ03kCUZbcpKhW63w/l4GSur+1bzn7mC2KgIRt?=
 =?us-ascii?Q?YfuQCr8pxILfZRl3ztgSdj5PyKTGuGV/iAM4QGZlfnL+qeH+Nhw2Y9RdjoHv?=
 =?us-ascii?Q?8aRUSVVBg5xTrQP7Dy+3XWSRv6kKJmpcw6FvyDxEKYGcTtrIKLGScA7/Z2CV?=
 =?us-ascii?Q?eHJH+U+le+hFjivv9yNj+HVpd2IKpJKdNcJ0jCvmjpo55R62dR73vUX9Cr0F?=
 =?us-ascii?Q?qzwe65UaIoiDkhbuYXaIURjCq11Xe9uO+Owe+tlE0v5wJ2vQ+aDaGSEbBLsb?=
 =?us-ascii?Q?aikDFXcBIBIgkZ58Fycskfw5Jhr5cj8lto/LVzhJXI9e2To8cPPP0D3i5cbi?=
 =?us-ascii?Q?hJIkabz8fkJw0O4xANgdOAt3OZa3pbPaPYjfPoq0K3KTW0ph5Nl/sAd6vjnJ?=
 =?us-ascii?Q?70PbuhKryNYHYAt0KJIzC5gBhajvJY/EqzWE0nH+ki7jMuleatsPxhR+UUxS?=
 =?us-ascii?Q?lbk96oFffoN0CHjGLENOE1+EAiwFKqUzzJ3T4Nxa4WrhLiTBgtLUm+o4uu85?=
 =?us-ascii?Q?AHB/v4cf2HByQQh7wEC8d8bebd8fAvNyevUef4+9kt8FF9yBvtgNsUdN5H8q?=
 =?us-ascii?Q?5zXbc7Nq68sLJogI6zueSU0EjjNfMcKPfAHLTOLZutcl7va5RFumM5AZGBs2?=
 =?us-ascii?Q?UQ54NQkZ2JnGxHMWs/ZWn0s8/LKop979OG5X9QFLyI1MGiYMyBfgp9SQEvSa?=
 =?us-ascii?Q?zWFXk15GQV1R+or2V4ax0Gig6OtpLS/46JUVZ9qsmT29r4eXawzX3nHHqKgz?=
 =?us-ascii?Q?KS5kVKuQH51f7JkXxszNfqsou3J37UdOvo83ycecJGyPqVvpfHyv8aJoaQc+?=
 =?us-ascii?Q?Gy0F4q2l0xkKB7r71q5XeFuQMMKtk7OH1bKdv5T+jYtS1d2dWnRhWjXBOqdZ?=
 =?us-ascii?Q?zCLwPrZjzBiTo3pIVf/SUGxj8Q0sHHliX1/+qWQrlGaat5M6QtND4DnqQ/wh?=
 =?us-ascii?Q?HQwtb+Y3BUjxbWr9uNgdXrF7kihoBrZP4Wdushysy8tP2qyl5ekufrCUBNv2?=
 =?us-ascii?Q?DxCMTOGeDEAQ5IoOvoy2YjXc8vQYFwY=3D?=
X-Exchange-RoutingPolicyChecked: N0D0wkAdNn7DwakHRZi5n74pNWvODUrJfw5aDBTMTz65mEZn5Cg/slOwIiEm+1bJCXUFf88VOLDBOT03XwBbdrLDmKkOj0uuJGc3Bzwon4IoqKafZ3I8Dhm1ytyuSf/ZHQFdme0WVE77/BNKmeGCPo8zzam1ZoOUVzV5pY2h78No1b/5z7E0JxaDv6D3GB6f5hZoSRXDRGpYFtwI8SW8qm6KRXTvAJ++y3CTqcPOcEWVMHb4rgnr/JKpFm6YqzCL8GQNCOLBYMwJ2Wl8krP7cdU0Vs6oOvZek+po7mvs0qWUt/kH2NHJOcy0op1prhQ2uohKSulQJ/Sk01N7lPpGfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d66748af-1a33-467b-a42b-08de90ac623b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:38:39.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmhyoBiD7EwdehyJcrH2hIQbtkrQv5VykjrLoztD2Tw6wobGAzi7b1zvfNF9PKt7y+gyGUtOgjSyAPDJwg5vnhSfJi3rzDEOiHKFhgdKu5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6970
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

On Thu, Apr 02, 2026 at 01:28:03PM +0200, David Marchand wrote:
> Start a new release cycle with empty release notes.
> Bump version and ABI minor.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .github/workflows/build.yml            |   2 +-
>  ABI_VERSION                            |   2 +-
>  VERSION                                |   2 +-
>  doc/guides/rel_notes/index.rst         |   1 +
>  doc/guides/rel_notes/release_26_07.rst | 138 +++++++++++++++++++++++++
>  5 files changed, 142 insertions(+), 3 deletions(-)
>  create mode 100644 doc/guides/rel_notes/release_26_07.rst
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

