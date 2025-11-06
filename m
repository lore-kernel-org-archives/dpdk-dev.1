Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B87CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 13:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D2E5402BC;
	Thu,  6 Nov 2025 14:41:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B21EE4021F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 14:41:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762436495; x=1793972495;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MtOSZggDUFb95RTlxFLtfYLeVfngSbEEpmITwVBCsLo=;
 b=NApQ0lMl72mxWYmsq8eGchX3JK6UDqVfGOkBGahlCUrbsYIi6bA7Gz+Z
 3gHWewphmJx9TGkR2tGWnKNb9HCErccoLE7Glt8aXw5YqcnpqitFjs8Wy
 6L9M0ryi2kUI8THqPdQetpwiEQBB8Vs+DzGIFvMrOdGS3gT9EL6amu5Ny
 aVFZnJ4Gpm3Sapjls8qmveUEHZKK51jZ5y2RkiKv0ecDrst0wyOU0oxEQ
 qmJ/l4Rczbl/735AU0eQx8gmT8dz4rlRyyUM2InflhLEQTAPCTFLtoWun
 +HXebnDcETH1i/o7w9qzNJTp+Uhsjlp7Me4Xc6vVF1PWt7QrDqGmFsoY4 g==;
X-CSE-ConnectionGUID: rFTq1Re5Rjuiiotxp7aHZA==
X-CSE-MsgGUID: 74FjI294STaBEM1xTSxLxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="74861859"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="74861859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 05:41:34 -0800
X-CSE-ConnectionGUID: iKHsBq4TSDyHPef6qAZKkQ==
X-CSE-MsgGUID: BZniSQUhRryM20lUFc7P0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187047873"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 05:41:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:41:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 05:41:33 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:41:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+7SdfYNqngLKJZDF4pEEW9xan1RyR7Cg1SfjqBB2rNMYNINlPivc+Tt4bgGBlTzYVaQgZtfr4OTuct8Cxeh9AumPmEveNrSkEoHgd1migxcEX8S1tTdwY18hO66PdSAaq9EHL05rzhuekblX+emvYKfLWwzbGEq8VKJnsFTQ/N8Bk3RfcKhn8t03eTojPfJL2Lkm66F1/jj0jeNwqXFVlH0wCJiTJXsCLW7s4KImSqLT5RIrhtNvuHmlY7lVegtQAv3O4NhoZRt4D/OLpfVU7Qh+MDq5uuTyZTFJhxIvEGabCqVyZVy+R9Oe88YcYCsl5qrY5hKhjA1mCg/lsEZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ht51iMtRGBE5vPjayh0aogmMfflNiw0hOd6cltZIQE=;
 b=MrgnzSXk8L9hV5A2N7pSlnkfcgn+MDgrjB3mq4EFgFMAbN3J3QgGR1ItctZYel1reohlMulSYffbwDuUpgtmKG4ni0WtT5CKbC//LLbClNtNwtuclY5z+VDOJjVsTVhHDzC45FcBci4sLKu1LKPhMI98b1ntm8prdSIRMMa+fSSHe5upKeaok+tkvQDDaR/7fPqc9Znoc61d04emcKW8SjYbNxFh6Dy7R4fKQBD9hZ2QlTNu936/7MVJ6uj+YPttqBJuIiI15O0pgzCSYmjpmV+zKPD/HqcRs0M/G6swQLspZNJKlQDxMX7HW5Av53dlHJvW/MjB2IwiCaPVuavIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 13:41:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 13:41:30 +0000
Date: Thu, 6 Nov 2025 13:41:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <maxime.coquelin@redhat.com>, <aconole@redhat.com>, <ferruh.yigit@amd.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH] doc: document telemetry command name restrictions
Message-ID: <aQylhdIWMJRNNDHV@bricha3-mobl1.ger.corp.intel.com>
References: <20251006094712.180432-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006094712.180432-1-sivaprasad.tummala@amd.com>
X-ClientProxiedBy: DU6P191CA0054.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b261083-0e69-46fc-01c5-08de1d3a3141
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2PXbyLsirpIhTcRhY9rUUaXpIYLCep3ufeDqLmtKNahUyKD/V8SruyUiIAoU?=
 =?us-ascii?Q?DHFh3/afdbwkZu6/NtTlDPU/c1Yz9NozsKXBd21S5GZqrNw/tL0Vihw2lcMM?=
 =?us-ascii?Q?SWii4+vsrlaouue7QnfLmDIT6Bc2XWUuh2zOIm888BcYlgmDVZXZxQQr+r31?=
 =?us-ascii?Q?dSXkGLO3/O4S3FRT+Xb1doJ/U2T0sCCV3A//g3Zy5svE9hOZl9JQMz124uqO?=
 =?us-ascii?Q?lDXEv5cCWXi+/rVaQG0z0AIB6FNTiGRae9WOTBKLnJ2xqDLdyCLYaa9Etw9g?=
 =?us-ascii?Q?9t7frWYGwAA4lhnJP2FOKK+PastFF3JOa4CfTkPl+0oku2zVepv1GDTKg5GX?=
 =?us-ascii?Q?NKKDD9gUnufUL9jKRjXqaLrzqT3lhM4RWXqqduUd2FOldBkc2+KC43Z2K2qL?=
 =?us-ascii?Q?mrs6fyM+bXQx07R7SZ0a4RcI/iwHj9XEaWlcJ11nwRpwthjgJVxR1ndvknyF?=
 =?us-ascii?Q?Zlu6fsFVJw8xf5VDomkOkd6H9aXr4OfNLRRlZcQLzXHsdhjEK+vOaslkQPm3?=
 =?us-ascii?Q?82NVNP5sP9DwTWENejDQNUHI/WaK2EmwUH+n1BfdAvsnhnf8nxV101Ih0TGU?=
 =?us-ascii?Q?daZxGzdqtJQ+PdLtHIbqLgWilyZlQk5MnBeQHs5MmJPL8ujci8juHgnba57n?=
 =?us-ascii?Q?T4Jkym+1xFLjR+wWfV+S0/SThF86NuQfzjeFjKu7Yfq8XZKCnECXD6yZVpvV?=
 =?us-ascii?Q?ly0d5Z+MEVK8J6lfXYLjG7IrxqXmeISN7DbibspIBlM/hODvrzUVHTochL03?=
 =?us-ascii?Q?o6pUayB3bDsjmpHVJNEsjcT67lr00GgCoXKFcY7JefV+/wk7pmtLhzPtfzAf?=
 =?us-ascii?Q?gcAJALVeXWehD09yyWcSjoI7+gzsaA8jkMqbULlwZOFRK276Sx0MM63jmjJq?=
 =?us-ascii?Q?nijI5rGEjV0i3LMqQak0ozb+D3EMTFXtSDW+dX/7uAdO+hbx7/flXsQRLkzo?=
 =?us-ascii?Q?Hu63YnYBLDXFctaTtYyqcwNPntEZkWOfYsGsDBP1VC6FvVpc7Wmx8bpkeKZQ?=
 =?us-ascii?Q?dnk5tjgfeVh3bVnU2fq+ia2nY+eCjBxDKG1BAwVcm4zXvn7Ml+eLmzZwzhsT?=
 =?us-ascii?Q?mOnTU/8ufTIyBwe5jlKsK61O7og7x+ae/IYYW1w6EwtSCBUL3KiD3KtNWpnj?=
 =?us-ascii?Q?Z/ULG0Y5G8+EpcuIbMRSqMpQnUdTcavQ2GIc7y/ao/vMF2I4Kk8eCQY5ChYH?=
 =?us-ascii?Q?dXArjbV+3Qp+jlUQ2Nszm8WeapQ7xewYtHLx3os8JsYNp9kUsxC4GyMydTxa?=
 =?us-ascii?Q?42i13vTzbujSUjuXNg9AN/0KIgkTe2KURndnkxxUGoJEXZZDC92XoZq8BhOx?=
 =?us-ascii?Q?unMGtfxEZHX31F3IrW1zwYzhJvtL0V0EkZMMRsSN34BzibPCNAkhW5rZwgs0?=
 =?us-ascii?Q?uw0lFaDwaYnWAcOmXCr2UBJa8s0f2HOt/Pl+Et3QVzIGIiSOa//Lgw6YMBoB?=
 =?us-ascii?Q?adNPmlCZTd5q6XBoPVBhFEpWRaQY1GBu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/iaHw1ven49h50Nx+vXhIB+XgQAGhku+YiGz28jT8XUKw/aZ+RK4Ze9/+cp?=
 =?us-ascii?Q?5nNGI4RpZELdjoil/4RsuQexFBdTC3isEBU4AhJlsxq7wbnd3OZs02zD5BOp?=
 =?us-ascii?Q?0rQgwHsOD+kf1/FQVfe10tYx0XQWH8KZBnUM3CZTVZQE4wvJcCdp9oHe6krq?=
 =?us-ascii?Q?JMLzbG+aB7hkJWz7JAGL+rYYtc0JrSiEXVNEOto0ulNdyQK0UBAaHV+/OeLL?=
 =?us-ascii?Q?VOM7sKHB3P7iSQruNY2meRSe55XSU2PcXBXQeD/VHzXcBHVv6NhmeHJNrDyk?=
 =?us-ascii?Q?diuYy4eKlFFJOkYf4POCnQu5esbwjlGgiC6TIyVoDwWoLtZySJApjLHgKVZ3?=
 =?us-ascii?Q?+wGDrCXEvX6KTImZtjbO33SRvHQ39IxLXu2yt8Dmc+bQAlDMDZ4RHEWCAsnx?=
 =?us-ascii?Q?kSOsNIbb0FVi50UH2QQhTgs20UNuXqXovxulC8XfzpG19wabO2e9OecOnaZe?=
 =?us-ascii?Q?kDMO41mVYMc2kGYyMKKvKwbUa5/6o9RgrPCPJd59rzM14XGOpQJ0L+05mr2V?=
 =?us-ascii?Q?K3Dtr3+91p+OSFHakVxP5MXrBHipy3PdBLNN44HSZl1hedzCqv1vJQEt/QZN?=
 =?us-ascii?Q?BRshDuG0GUbVUAzbWElusXfJjvXtWxcvb7SnRD3qq80M6PtY+yZtDcLq5HMJ?=
 =?us-ascii?Q?dMiYA/1m8i2Ai9lyGWAEuBDHpDwQoxiW7vRHjuy0+2UwPK56V34WNlL4KXNm?=
 =?us-ascii?Q?VM5jnHEujDa7ogRtqSr44o0O9T05hMQI9dZiPQx8lLS/2ABqR3g6cM9cEAzK?=
 =?us-ascii?Q?2tWKxUc/cfdXblWIgbazBNLBXxxa8dBBCg2PHCIcr4pLTFJTwxWqld3Rj3o1?=
 =?us-ascii?Q?iT+H3MaZpUxeDIZvntSOik/yfdiu8UWVUXJDHIfA7mkbIxRoLXvtNyYG3m2/?=
 =?us-ascii?Q?GnHiBdoyz7LXu1DZWDifYjFOZMkUcGSs0MZ5j6hQ65tC/r1v7bKGhthSGHmt?=
 =?us-ascii?Q?zRy0W5uV4PfdQLELwUfHutXvTFGuQ0rFNERlgdNDFu3bv9rC7nuia8VY7uN4?=
 =?us-ascii?Q?C5zXXHOYsIFTiTs7VBKDV/35Vt6c3Y7faRVzEkKNL2xsgrmFPXDxyFfc3A1e?=
 =?us-ascii?Q?YYUgAvl3hW3TAMVjKVs/VgP6X1JhMhFbiQ/WXesJ6Zaqg57FN2ZIQHR5POSj?=
 =?us-ascii?Q?kInO51BKezVrugVsgDOYfYKa8jg2snZsQJ7OO9dNQsdVrIaqpwv205zjAjH1?=
 =?us-ascii?Q?2NCMGAM5KlyzF/WfHiRDMXYp3eGkWGOJ7np5uG6Tyx0r7vbbAXfOLsiij/3s?=
 =?us-ascii?Q?cqUrA4rGNSyjE315eZMbLKwBc7T5YFMuhpJfJRiM0mg/7B4Thy0G55Agmi/o?=
 =?us-ascii?Q?ufbPUkCljCHI7wb5sEjRvZzOhKIHKvkZvWh/XXuI7vemvBEBZXKooDi6Stcy?=
 =?us-ascii?Q?QEVe7YfM347wjGAnO2HBh6VhUOV3fUYvflgugjIMsyqjFe96FmA+0z21C0w1?=
 =?us-ascii?Q?TawnJgIiGZKSyTzLm5MqAZQGUKRQGbwOAGpw1qgqxMatp3v+fpKTCmcLz5ld?=
 =?us-ascii?Q?tmRztwInOwJ6Pmoz1tlSmDkxAg6L1u9WhPc5SE6EJTOOv5J6N+qRuThXlYv0?=
 =?us-ascii?Q?y2tDBfPY7OShu998N/D6D/+V3/Io1TC8Wc5WgrsEx8JNTXnw9Ln0ZYtai/Wm?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b261083-0e69-46fc-01c5-08de1d3a3141
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:41:30.7190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7CcPp/QytXL99J9DM0qaCEN24iobjhRikZrUMy6Ii/Vt5gU2fTTtNMGNFHucyrYDC4XJfbXIewlLTTR2Q8DCnVOsEujD4bzR4KB/TS91BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
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

On Mon, Oct 06, 2025 at 09:47:12AM +0000, Sivaprasad Tummala wrote:
> Telemetry command names must contain only alphanumeric characters
> (`A-Z`, `a-z`, `0-9`), underscore (`_`), and forward slash (`/`).
> Other characters, including hyphens (`-`), are not allowed and
> cause registration to fail.
> 
> This patch updates the documentation to explicitly state these
> restrictions and highlights the existing invalid example
> "/l3fwd-power/stats" (in l3fwd-power app).
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  doc/guides/prog_guide/telemetry_lib.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/prog_guide/telemetry_lib.rst b/doc/guides/prog_guide/telemetry_lib.rst
> index 32f525a67f..6ae5067474 100644
> --- a/doc/guides/prog_guide/telemetry_lib.rst
> +++ b/doc/guides/prog_guide/telemetry_lib.rst
> @@ -157,6 +157,10 @@ command. An example command being registered is shown below:
>      rte_telemetry_register_cmd("/example_lib/string_example", handle_string,
>              "Returns an example string. Takes no parameters");
>  
> +The command name **must consist only of alphanumeric characters (`A-Z`, `a-z`,
> +`0-9`) and the special characters underscore (`_`) and forward slash (`/`)**.
> +Any other characters, including spaces, are not permitted and will cause the
> +command registration to fail.
>  
>  Using Commands
>  --------------
> -- 
> 2.43.0
> 
