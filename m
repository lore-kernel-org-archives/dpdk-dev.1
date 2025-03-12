Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA64C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6FE04029E;
	Wed, 12 Mar 2025 16:19:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3A90C40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:19:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741792766; x=1773328766;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FPOQPT02+p9cc3BKd/daqDJplU+SGL2jcLYrmAbjBGc=;
 b=QG7zjS+THpGJrKNMNGS4ApAUElGBgyWt9R9BW+ofmEL0fDEip3JDcrDa
 oiziBSe2PEaA6KDzm6fP+pSq4LOOBolWUMsvFsr9KuNvU2Omg8NMWy5dJ
 Bd/q7Iqz1IN0lTeWF5GOjdmZBD7E84WI3GZbcpaP86xuAvmRhdf4IxVMV
 6kbe19e3vLP6ytHN7nKziP5JkdpZzyDUtq7puCGjfmHAjQhyFATMa613H
 nIyvMl3/Pl7C9xuGxgg5ZP+SWiQ1tDpD0/CZ62eYT4wfIhUFHjgphSJLt
 i6TUjtw3J+l3ZMqRm4aTWuJBr5qxzpia9rCxwcwgjMogDkoIOgw5qAcZq g==;
X-CSE-ConnectionGUID: mnwCactbSmKt/TOqTT0yCA==
X-CSE-MsgGUID: nc3D4oGfTGGajPGyV5IvZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46787588"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="46787588"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:19:25 -0700
X-CSE-ConnectionGUID: 5Ti5ohFAQNmVb9WkLV6hWw==
X-CSE-MsgGUID: 5F8axUgWTRCZdDughYXSkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="125731298"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:19:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 08:19:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 08:19:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 08:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwlBfnulrfB40QJDLOex9PVTZ4G9a5llJg3KQ78DNMUaiiIw0CR7++6XCDzQ8Esu3edATzPWfQUzKUI2gMpDECLerWSoVvSL8gBEgZowpSLD/O0ZVvS+ix9JFswhWhVafOrS8PIPcTgU2O4l5GrL9pK4ki5l48vFLxwh8EBcPkUfP+sWiH8L4FDT6Er62FYHZAQzfcDa5fKUTL84Kuel822aQ2jmBfEMi0VaKL+P4ilwzRJZ2wx9uuzO3nuOaXmHiyDae7nAaK3qySklFMXl2CsKF28dcCj9kxiJAdusvMKVHBnvAZYT9c4NmLSiW8bFMFLvRzFZ60AGTICczY17nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67m/X2APQeGRxH2lY3V9ApntmBhaCOZmR99NmvrhMIk=;
 b=y3h7Ybf6slIAtcvfo7MyYEgMqX5ohlhBkXp48sIoNMKnuleoAMlD89k0PFpqjavAUog3avErOy13EuxQ9a3vmdLdLIFkaeANbo9zwx/s/wkx5/SSplMM30spA8/FqM0YxK5amwsifuUsvd+8dA3OASCWXqWkUK2dkzHnfrpgHxD4Egh7AotLKKjdWLzgluBbAzKESF8aqx4pbwnfFpMkHKdvNQQQFLkjLH9arACQipKx5C0txhXpqvyHFmiNmNcnIIrhhU7I7KbvMLR3e8InrZf5c4M8BH01ZDPrA+kG28DdTp2AA2+LPwlz9ic9t4TEn59+yzojq2idqN0hHUnIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8872.namprd11.prod.outlook.com (2603:10b6:208:5a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:18:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:18:39 +0000
Date: Wed, 12 Mar 2025 15:18:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Ian Stokes <ian.stokes@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH] drivers: remove invalid options for MSVC
Message-ID: <Z9Glyi4qOjAFBHTG@bricha3-mobl1.ger.corp.intel.com>
References: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 453ae48f-f285-4eb0-c119-08dd61792a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FmacOewBc0VNffv4WYiXvbQO/uTC7mBVgh0Z8DCgF278E8WPpaTJGYAyZuVc?=
 =?us-ascii?Q?Gw+yLZXGRwOIxkg/faok+Hej6nAD+MVLIa8OTYlj2yqWqCvpql3NEvvaB29+?=
 =?us-ascii?Q?7xldnNpglw5HVA1AsLGWpJuPfN7bE48QkbNq2GkzYt8nwFHmy+I4YvC/VK8W?=
 =?us-ascii?Q?AyG5v7waE2byUHBCrE+YbHdiAhYjbXOSFQGyzJ4G4mbGsRxb7B3RVE99TKQT?=
 =?us-ascii?Q?GPZv3sbOraSt/KW37lEAIHT1boy/Ey3T83sQNci1b/Or0BbFd8e6sjcs9YIW?=
 =?us-ascii?Q?BTYzYpooaQW4/5xZanxEIqhnoJzqDoZNz8h0zh9t0cUlHbXIDFD/vGz/cqnY?=
 =?us-ascii?Q?mTWbOi/XpMGVoQZKiBEqvwo7RUMXChqbBknAQaT8392hQ+FUKb2KMXbG7xiX?=
 =?us-ascii?Q?WhmaTbxewpFNEfgP2MgdDsUzFDMUsouvMXkX6+7Jn0fZ0exS6SUPf9y3mxJY?=
 =?us-ascii?Q?jupWF4dCPIKlMHl/GSfazKWmgm3DaAefMcHnHoOAvy0HR7P1ObUDN//M74as?=
 =?us-ascii?Q?hTdFadTaK66iY3job7g3V8Q4/Vq1NgSoGL7F4VoNfv2SQyAS1d6rmSOVYtzu?=
 =?us-ascii?Q?HyRlTO5ipagCxtM6e+AR5lV9S+SZfzhrQEaRuepCzFUWsJuPq+d8kkEMu6cX?=
 =?us-ascii?Q?c56F+OkcYTUCNwx1gmnMH0bcuuPEpeS81M+D/6lMcM0JbTTwHTFiSjNUZsAs?=
 =?us-ascii?Q?LhJfT/lBTkBSxZYhjPppbe+Eu2nRS13Z1sFVbFwewkUv7gITd5CChjt8TOhI?=
 =?us-ascii?Q?ZSi8/AOjYs3RivAGTDAZKt80O84yJ2vgmE8jrEyGTd30IYUbT81+gayyjHmd?=
 =?us-ascii?Q?bSg8msB11VXcRsnF3psm+UyY8ltj2tYajhYpIiFPfr4KzKdJiGuLnzi57hg4?=
 =?us-ascii?Q?nPozSCWe9opff1WRz0gM9jvdJGIdYa5f94vxTIXak3HYtINJjls6EpdKYqK6?=
 =?us-ascii?Q?IwPvbMWL5DAAUyo2Wmu/RuManIOIQ6uxqRywjYfEJaN3ad9ZAY5t5Ef+d09y?=
 =?us-ascii?Q?0p2vESlaAOfxiI8M5Tzm7OVZ6VvqQDqmInXIV1gXsQXPfo0THC0lTcfXh5AN?=
 =?us-ascii?Q?uMfGnuxTbscgP1eK1OkcXqvLJXRY2LOeDr0AgRe0ZD8DvQk2C7Xv9ZHLwxej?=
 =?us-ascii?Q?HI0mgIj1FNrwOmIVgGFL2zjvEITKK2pZ/dsREp7hlBT9q9etN5aSOVLF91w3?=
 =?us-ascii?Q?YRdJGzid4v9A8tfjfq+J2Z+oVctWUdBIrOvG+Ol8rVePjQvB86VgHDa4LikL?=
 =?us-ascii?Q?A+I3i3Nc+HnKZjVKhu3Io1xL3l9IIY5pOFjcezkNsPecoww8hjVhnokkDB7c?=
 =?us-ascii?Q?KvZf5rQSW9ztGQ/gVXCmFSb/SzXe6Yw5GEua+plWMcA4Y0LbasrXwcDCku6W?=
 =?us-ascii?Q?GlvDywW2mfXB0GL+2dDC8qq1YWNE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZUFLKaGyzdgr6JBUz4Y3NzbM3O/8OPxQdWkv0sox2oDDuhZrzPye/ZdVLqjX?=
 =?us-ascii?Q?5+hqKDB2EDlqROFud6l/llZc3g+o18iIUTK8Tevkya9KIXaH2nN6Hjz3cMsz?=
 =?us-ascii?Q?sYsnb1uj6qf20VMHqFP9mRdEzPC9TJpf5pwom2riYjldSpK/xS/RkvA/tZmW?=
 =?us-ascii?Q?ls23B87ZKCb4aFRPVLe9G7yP7OfN/NxlCvhDc8fNXDFOEiM11JyGsoIhUnxf?=
 =?us-ascii?Q?yq9b+RgYIEUn7DOWstCzXllYyY9uo6f1R0yu/SRtzXz2YrRil5To0F0CShvF?=
 =?us-ascii?Q?XgXjx5PFqhozcxj+1ay2mp4EvTRyYmYDZEEUsNCo+HKF7JALpINbgIqZxCnU?=
 =?us-ascii?Q?CDKs7cReoFuq3HGkkDzl9SksyWvVK+PLSwvsbOQ+XY+U3nFz2IUcmayiWOJh?=
 =?us-ascii?Q?QKw2oSbZIqFA62KJW3/aZYV4zFVhG0A59Qs3EhCqg5iBjPqT113s33ruDVH1?=
 =?us-ascii?Q?IlgeU+6wU91u0owZb3JdhV6EBfsBm02Pe7szW8HMLIe6pr5IV6/wguj7mv/C?=
 =?us-ascii?Q?yudsMUFwR4rtS0bVQI9pb4dlUb3wyGiD6t9w0B1yxn0mxP4uL4n00OeHxj3R?=
 =?us-ascii?Q?7WsGzaAHYgQt91ioOKD5/gwgz5GYHGyokBCEgoGAuGEuxRZcN2bh86GberoI?=
 =?us-ascii?Q?dsdB+mwSoe/aDtIq+GxJdN+uwl8d45ne6mF6c/rORk41goggNUn9MEVLyi83?=
 =?us-ascii?Q?glMkr5qocpDGnJv8Z3HyTgHudFSFVdAksU2dh0LltMHUG35YFjNNz14/wsB5?=
 =?us-ascii?Q?fsNEWvnPGE0VK8zArsYCU8ryWDySuj95ItdmdEby+YbwG5e2rY8pGmFSGk8o?=
 =?us-ascii?Q?+hvaAGTWfg3XE4o26QgZsEsHqJqgnhNeizhRn/oq2D8CTidiF+3iYlXJBuLQ?=
 =?us-ascii?Q?MqM9MHo2d/UYReJ4Vd1VdnwEMiZ29dStRpOeCnlDoYT7thAs4YuHkUYoIZkF?=
 =?us-ascii?Q?Z9OpZJKmsDuWqDgdUJ/7Y/ofCS1dP1LgnwozPP8tCPlEctLv2OPrIAnehRVZ?=
 =?us-ascii?Q?NS/C+wQlt/m0o9bnqDN6uJQSt4UtGVERATOtupLhPVUGOx1vrG2pDvRLS4np?=
 =?us-ascii?Q?DB6D25kiGgnL0O2OvYRRV+bumBZVFzkm2W2e9cCxmseLZ7Rqqb4VTXo6oRjx?=
 =?us-ascii?Q?mY7hyC2v56SkUhU0TyTiYonaoU9PQa5LHe7ZQEsgoz4ZacdFzqEHTa3ZMKJb?=
 =?us-ascii?Q?fGQAyf/jnhLAVpmRLhkFbaAJs9u8y0WeYhMSCgUNpwGLumf0MoCxrX9Z+0zM?=
 =?us-ascii?Q?ZA/e6FpqelE5CgsczRHyYlYLBwSmqTA3eset40dFMauDJKyjXPrTVzmoDFu9?=
 =?us-ascii?Q?R1JQlE1aeQKgw2P6RVLsPb/G3nTCoW/19YkIb//7Tyw97tkE1piLBPdbpXV/?=
 =?us-ascii?Q?pZgSB1YDnIE3l7LNAwY3tlq0Vuf66C0TG4o7Dhbc1PxO4SX2LD6cYAn0SQic?=
 =?us-ascii?Q?ZIKbz37t1DWg7sxW22Z6s6ut6EiAxsE2WkiqmfHgKmJ9DdLItjbhU0b8bMt4?=
 =?us-ascii?Q?i/bf068Ro0wGTehWNArnS6Yd3nPDYhU8o30s7EYZIVHF3S3UpxjOl5CEOtfL?=
 =?us-ascii?Q?ZsTIt47Xf7AUezG234FkWvS6cYjYwDcOI3VDG17Zi0fLtjwsQtGZAiHEgQTH?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 453ae48f-f285-4eb0-c119-08dd61792a99
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:18:39.1870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXXYolF7a/gdrEovKLX0kfSqpL7fpDxCS9t9lMOWui1EPThmO3AU854/Cr4HkLD1nJDrQtES9PwPPnkAS1P5H8gSNllWjR7J5AR0k//sJlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8872
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

On Tue, Mar 11, 2025 at 07:13:56PM -0700, Andre Muezerie wrote:
> When compiling "drivers" directory with MSVC the errors below popped up:
> 
> 1)
> LINK : warning LNK4044: unrecognized option
> '/Wl,/def:V:\github\dpdk\build\drivers\rte_bus_vdev_exports.def'; ignored
> 
> 2)
> cl : Command line warning D9002 : ignoring unknown
>     option '-fno-asynchronous-unwind-tables'
> 
> The fix is to remove the unnecessary/invalid option when using MSVC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/meson.build                 | 6 +++++-
>  drivers/net/intel/i40e/meson.build  | 2 +-
>  drivers/net/intel/iavf/meson.build  | 2 +-
>  drivers/net/intel/ice/meson.build   | 2 +-
>  drivers/net/intel/ixgbe/meson.build | 2 +-
>  5 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 05391a575d..fc7f7eed8c 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -289,7 +289,11 @@ foreach subpath:subdirs
>                          output: '@0@_exports.def'.format(lib_name))
>                  lk_deps += [def_file]
>  
> -                lk_args = ['-Wl,/def:' + def_file.full_path()]
> +                if is_ms_compiler
> +                    lk_args = ['/def:' + def_file.full_path()]
> +                else
> +                    lk_args = ['-Wl,/def:' + def_file.full_path()]
> +                endif
>              else
>                  mingw_map = custom_target(lib_name + '_mingw',
>                          command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
> diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
> index 2973ed1a01..fce5d997ed 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -41,7 +41,7 @@ includes += include_directories('base')
>  if arch_subdir == 'x86'
>      sources += files('i40e_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> +    if is_windows and cc.get_id() == 'gcc'
>          cflags += ['-fno-asynchronous-unwind-tables']
>      endif
>  
> diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
> index f7eac7c57a..d801527ada 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -29,7 +29,7 @@ includes += include_directories('base')
>  if arch_subdir == 'x86'
>      sources += files('iavf_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> +    if is_windows and cc.get_id() == 'gcc'
>          cflags += ['-fno-asynchronous-unwind-tables']
>      endif
>  
> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
> index cbdf38c1c4..a28d62173c 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -35,7 +35,7 @@ endif
>  if arch_subdir == 'x86'
>      sources += files('ice_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> +    if is_windows and cc.get_id() == 'gcc'
>          cflags += ['-fno-asynchronous-unwind-tables']
>      endif
>  
> diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
> index 0ae12dd5ff..3553b0ffe1 100644
> --- a/drivers/net/intel/ixgbe/meson.build
> +++ b/drivers/net/intel/ixgbe/meson.build
> @@ -27,7 +27,7 @@ deps += ['hash', 'security']
>  if arch_subdir == 'x86'
>      sources += files('ixgbe_rxtx_vec_sse.c')
>      sources += files('ixgbe_recycle_mbufs_vec_common.c')
> -    if is_windows and cc.get_id() != 'clang'
> +    if is_windows and cc.get_id() == 'gcc'
>          cflags += ['-fno-asynchronous-unwind-tables']
>      endif
>  elif arch_subdir == 'arm'

Out of interest I've just tried compiling up DPDK builds without these
unwind-tables flag, and they all pass, including the mingw build. This is
using:

$ x86_64-w64-mingw32-gcc --version
x86_64-w64-mingw32-gcc (GCC) 13-win32
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Therefore, I wonder if we can just remove all these flags completely for
mingw now? They may only be needed for historical versions.

/Bruce
