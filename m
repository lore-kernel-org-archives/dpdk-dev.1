Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E27740E64;
	Tue,  3 Jun 2025 18:21:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 235D540E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967665; x=1780503665;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ssFxsYVAGdxnDfOkIepLc4BTSTQ40B815YugztFr8mE=;
 b=K7mSHMXnkRV+GaFWBecNBp5FTbIzKzNKKnaDaDwABsJSz2w6J+Gq1mxQ
 JoV3K09jF89jcHtW+MGm74kgfMbZruFVREHEssGdjkoKpsrW93uQ3+JE+
 GUGohsIWTwDod775oOXuF3xcFmqNemPtgF+iLzwl3gHkYY6IlkU9gVccG
 5sXiS77DsvVtRbTLnE6k4ar+H3eMKYG0EKBT1JsM911X0EOsDMhE1TbFV
 qKc6mDUXRwopS2+VtoFBtGwDKylDq3OUL0B5RTxXxfqPMqBG6H3cvgcWO
 SPzYT585PsfTaYvgS5ATaDK5+89eH0Quj9veSFFDl1/DD7PNyBffS6J/m w==;
X-CSE-ConnectionGUID: xXD1sXvyRIOY+9r6KQ34GA==
X-CSE-MsgGUID: noLe83RJR7Wi6R3CTQyvPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62070548"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="62070548"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:21:04 -0700
X-CSE-ConnectionGUID: yH/hKw9hTiyuguwmqPTYtw==
X-CSE-MsgGUID: nL/NZcKKQbOGuBgGN1Z8DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149952324"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:21:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:21:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:21:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrxPG/TAUee/mC3oUCmk/njcoFPcoljzbME46YDIc0Neap8SsPL3zoAzJsdi3kopKFBuEKEih02P/ObPb+hckZDxgcNABELnZMkTdC43askSfrfVrzkfYP8z7FgKf5GGnD6GtL+L10MqCqi0XiZglfRJOqHoXz1B8xq6/Zv9lc7xS82E7BJX26X3Wh44mYk4SRjClkYFRrWQ9bV6jGmLW+wTdfjlMvsrOQ+fLXpfu7niQol9zXIRWnHm3+lz9k6z+0Rg/BmW2eq0uGwGj0jbGQPiw1akcVSz4S3dwbeF5qnnyuwHK5MKbogOnD7E1PIs6SuhFcMYlq24yBxoXqUwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5gejTUMWSbH9PrNinIyDdf4wstsXgRdvKSoEgKk/MI=;
 b=fr4q3/djjsJmOWQan02KOxl23ao1q+onK6evUI0hWsxv7YCSM7WEU+cKsmX1dYbebGNEWYFUNn0k5DgMQSebMeZlfA9iSW5eQ9XatuUkvpv7wKfFrZkxZ58KUn4zTyr+SJpFS1EAnNytbnWw2WvTqKzFbLUCZWXvg17ecg07OafLG+UnVzHhCOPjhck07xXkJT/iIVMwSN7eioCFmQ7lQDRb9bfUN9sD//X+00CHWa9u/WORRzVDV3kDxKhfE4K3qeXHvd1oGZtyytGg/S4lj7UsOxs6RQBrc0RhWWS/n2Y85COAroZScIywYyfe21jgODpfDM0zZhDl7Nkhe+9tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFEDAA4523C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 16:20:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:20:46 +0000
Date: Tue, 3 Jun 2025 17:20:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 13/25] net/ice: clean up definitions
Message-ID: <aD8g2V1YjdufKOJy@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <85fcf321a961c6542878d81315458d4a7aabba13.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85fcf321a961c6542878d81315458d4a7aabba13.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFEDAA4523C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdf285f-b210-4465-71d9-08dda2ba9868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jwpU0Suv7Lz+9zW0z8KfQmhjFffmFCs41f8Fm1lkjRKlkeYlJeSe8mQ0jlHx?=
 =?us-ascii?Q?oWw2z33pIsOj2RtJ9nRW8eE5W4yIKeEN6HrmtOusIDmL392YYEcUWge+7um3?=
 =?us-ascii?Q?bGTRm+DYbUHAyRRlDfiLoqnkzbAZsMlJwB2tVLQHSYuwNOfv3O+t8H+gXsRL?=
 =?us-ascii?Q?EgJ1bIt+VUqyBatHIohPHAokogUFh+yKl+zVysEadECjRhtEdQnKIHpY8LKw?=
 =?us-ascii?Q?ggeD5LJb/UYLLmV//jsrQQYH71TSX6G2m4HWU/dEcrCUri4lQh0amVpSqXKL?=
 =?us-ascii?Q?dfrckxCqE1ONz7aKTi+DmgPn5ApUJ61Xd6+aTIWkTCIUVG5WfxnHo/oU2MAO?=
 =?us-ascii?Q?tedfs0a1oa6gcyim8AXZbrQl/6Z4kNaKFQVRlwiu4gOqd7ksWSOfDWUnO2Pu?=
 =?us-ascii?Q?8kxdk8qaSgVwjE2dwemBjjJH2l3qWmgKfDzVBVqpiWDs9Cjc20HVEReWIRmI?=
 =?us-ascii?Q?3sLZxp91S424vJA4Vp8jJUhlq0d3LamB69/DrHEFTNd2/b7+FNjWVvnIYzpR?=
 =?us-ascii?Q?/gtrXlzikEqQEtbTpGfKGtWXrtaALy8y1Th76hRDbD5PtAYisyMlERLgBgOS?=
 =?us-ascii?Q?clmxvC9sfi1MIoNHk+URBIYOH69xaL3fMPOx9j1/+mscj5aJaJwSGNdKNBwO?=
 =?us-ascii?Q?pG9V67e4uwbVXrEhWmlgGCm3hqLt/EKmHMDLarGgKFrBsH/KI/E3d+dwOuyC?=
 =?us-ascii?Q?fNvySvG6sEcuUPjPlvL4LnDhWx7Stt1vPRSOKWeni1xL+2h1YJ5ztWz5GEyH?=
 =?us-ascii?Q?1y6e4w4+ikpI3gmva28zP7buP26jUJZD1zOkO1D2YLIUUruMLMUuKSxZPu0V?=
 =?us-ascii?Q?Y0xV+C694N5wOm8ne/K6t69vG1ocCobN7++o9dWRhxetzm8cGjm96uoNDckM?=
 =?us-ascii?Q?nsQWuucAU+yqFKRJsyEgL2upLjmXxdhd+VYcVpcHQfeA9QfjFaSIEjY+U5hA?=
 =?us-ascii?Q?HlMA4gbN26wEo4G3jL0m+PJV4jOgkocz4NN6azY8rprx43asVndij+1uavsD?=
 =?us-ascii?Q?EeDvUHI6FjEN+K+eVzsozxWXZXTlXhFCFtIHPTHNENdxHwiqKm0lXnBz92YT?=
 =?us-ascii?Q?9P+tY2YNB/jfvvYQs/LUvPicTZ9HuC906LRFrgMdvE+Fi8LbpRWfTT6ZtE36?=
 =?us-ascii?Q?XrdJWEN87WnD448qAJWXbetIXW4sctTpFDfRop6js/vQeSOnjEp9sjT0LiPr?=
 =?us-ascii?Q?yBUinvl6kDU1ryxCu+Z3yAinDSP9XjjSYIPcIDfSEN2ewmp42HwheOD6zYao?=
 =?us-ascii?Q?qh9OJUyPBIYErnv5wCM8Lac1P7Z3dNT0EonQl/SOcF3FXyZ/t64l3AHfYmvU?=
 =?us-ascii?Q?9Xedb6tmVpJL1rGzeTo3hCbDRNkKbSe0Syp2dYGL00NezfBcoVB0v8ouIIhx?=
 =?us-ascii?Q?RG01cTp1MTMwMkcLJh/uyZ9dPMmWxdVpEA5HgNJ7QhN2ZL8iuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQZ2d2oZA/BjfRfQd1lN+1BC5zPQHf9YH8cbvTIOBrU4/CN4bfWx6sgOq+Gw?=
 =?us-ascii?Q?jlzvLTfj8XwoDhQKiBTGTkxhAaIGI8hnEw2BFEiQpRcT1KUz/efXaCnms4ff?=
 =?us-ascii?Q?BNSV2OJG0HPYUBEJEgJhzIsAtp3ScwoSOgUjaSpNK3uwPAh0at+nGyt2jPz5?=
 =?us-ascii?Q?hAJVoxkKP4Fvw29m4sSs1mKKwbpIjRGjSsAOgHwSoIPbadONb421W32VBBLy?=
 =?us-ascii?Q?f1AdGSzUwmf45ZmPFEWtFOJgjmdgryf74n0gDgJsddMgGHQN4kSTSV7aoH5Q?=
 =?us-ascii?Q?0G1L63zTFLWB8c9FIew9lsYu+2tPqVaRU57hVAJgveNJZ4vdocvE+cTbg0Qp?=
 =?us-ascii?Q?DNRKofKUpbH2qBhOEDZoveW5uRgVhsK9yFJX5JutfftlYefftAb0T211YUDY?=
 =?us-ascii?Q?4X7CUHWHmXSn/LU/95eJkpy9h9Z324JIlUNbXrfDHU/EqdmZTnfFEnDT7i2E?=
 =?us-ascii?Q?BsR82IpmAnNaft+y2px9e7/BukzoD3Yh+nrqbAmfQVHpH2AdUUvWibB5ZaGx?=
 =?us-ascii?Q?JNQRVTgARTTdDbrb043Bn5caMvMR+LMLyJ3iW4fpOGDkarWAbUYQd/j5lQrG?=
 =?us-ascii?Q?IFf5u8eeTQNrkFOLmaeI/qbcQDftYfEZVGTZIVYD9exal34lvSfVtiG4iw1q?=
 =?us-ascii?Q?d+pFnGpemDqYuFtiosF9U3ySALCJaRBpGX2Giesel4TdBWqVFxpAyHILPM4o?=
 =?us-ascii?Q?LzvXaIUByvqJ0DsUn19YaezxiJDDyY9+DQvM8B4SHcbKKMq9duWAVAAgl7/H?=
 =?us-ascii?Q?n7XZsZEWwKQG/0npqu/a0n3mqUG63l/9s507S+Jppjodx1Y50G38ePND07c4?=
 =?us-ascii?Q?VcvtIq0h/zr60l2h6Fk30cSoedw21NN8meAHKx70c4Zjoq7fDN95HXJXXFa+?=
 =?us-ascii?Q?LyN18SYoKASESmrXB6yo/Pm4IAYLoLFjNWbau/JBvfppx3IbomA3PeVSMGsS?=
 =?us-ascii?Q?qf4gI5QWNnf9skmK63JRQC+vw020MK5p/YqPYRr6fDTi0srYR1ZlyDV4qFXj?=
 =?us-ascii?Q?bfPCr75v76/AduFoYlsEK/uC8F4/Kms624QiPR0WkPLibvqDJLY3OLX/MCTK?=
 =?us-ascii?Q?3N8yF0W6Jz9I1IprVMA6dd86X5E1ptQDY6C4ExqmnhBsMnHnU+98BtvvdZKc?=
 =?us-ascii?Q?tWTcJl7kcB/ctsGEnrd87OJFqMSIH5icMWHQ70/1UyxG+jO6iKRJfDf86+gz?=
 =?us-ascii?Q?mhOPqyOJhBn2vPXcmikJKu9idU200fdxe0OuQBWMU6cjSMOnZLjKThW+4/sT?=
 =?us-ascii?Q?RU25k7iqQ6fFzwru7drDQ+3e83GrU+8OtfsFjzYCY54CYdEzKYx+918LH7BR?=
 =?us-ascii?Q?krmPcJ4QJKcqAgdm1bBm+Mj5lLunbgEDhk4VOZqALKpFuFj3LaCngNacm9b5?=
 =?us-ascii?Q?dwzjc7xjnGEzPFpdjTis/ceLvJOrExnlxzzzRgyVhPKG+91FzmykG/67TQUK?=
 =?us-ascii?Q?FWkRQ44k6Bzl61I7xFw4kv63TS78AF76IMD6v60RnKycOlLsVk+IhFjxBb0m?=
 =?us-ascii?Q?8X8wis98OCfw2YozsrLbqhmu3sPu+LooM6fTh+bW+YsA0hx6s230ydKN9vse?=
 =?us-ascii?Q?UmGSIYLaQiG5ttLXTHQsJjh9m1ooEDSqjlZp3UNAsv2X9CEnyaGfmGGB44jJ?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdf285f-b210-4465-71d9-08dda2ba9868
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:20:46.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLOjeB2bUEPCOO0gFaWWDZtoSofiKIZTlsfinJ91gP7HRUUSb8/nd4L9gvoQ2ghKaMqXr/wUFIeOr4qssOnXXMwZuB+SyZDPpoGBnkCAXfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEDAA4523C
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

On Fri, May 30, 2025 at 02:57:09PM +0100, Anatoly Burakov wrote:
> This commit does the following cleanups:
> 
> - Mark vector-PMD related definitions with a special naming convention
> - Remove unused definitions
> - Create "descriptors per loop" for different vector implementations
>   (regular for SSE, Neon, wide for AVX2, AVX512)
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
