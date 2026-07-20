Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FAC44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C1940290;
	Mon, 20 Jul 2026 14:13:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id CB4594028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784549614; x=1816085614;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PAyuxzG3l/as3FBxl2EVEvuyVI+j+7gby1uz0CdA1NA=;
 b=ljF9FGf+1lla2YB2QEVqzWPuRTThLVFt+3mopI20rMxGJYTAOAAHSTip
 YzmwBOnQ21wHcmP0habmqmYLcMloPQpK4qIIj3kmnFL9Fhskvmd7IBezL
 xAv5K/wZmxUJkHOGHoXAJggtTsO9lscpqqop1EMbvOrQiK1mwTBlPChwU
 ze8GgtYZFigWyZ/4i51GUiLYt6EYtTIv28NZjEgFDHXqK5AKaW07hYDUA
 4ECF/VwR2/+bPGulo1f2F+61y4i8hTpOf7pCkwGmT80I/EWrtLeaN0N4I
 3VArQ+HqappsOdPe9vyUVHp8JqjJJeN6cUMHjPtvBIqnoHTakPClyP8mF Q==;
X-CSE-ConnectionGUID: lfv8hR8mTI+si+v7eTCo7g==
X-CSE-MsgGUID: yYx69irjR5+6YXHu0hsM8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84254216"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="84254216"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:13:26 -0700
X-CSE-ConnectionGUID: snZp/fvxT7uNpj6UdcmT9w==
X-CSE-MsgGUID: 36YO6WbFSGC/0GmCUeQyzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253069551"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:13:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:13:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 05:13:25 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJMXUIZai8E4TIID4c/rV+xAvHrlcnHlbk1goaDMOn49iXnRkqPDngzf+KAVu+DT/99uJYIkPrMFwx98F2QETjjpCNoZ/c9umVFJ8xBBbcPwwxuYbbZNpRAcSqWypzFrXMcpjkzooaR20TWlbPYDOMztf2Jlimg6eGw3hVW0nIdhvt1Pd9cpo2S3G2gmvnEMFteGW37jqHrKYgRbMF2WjDWXSWRW+VVmFI9oB8f5pyt8mcvT/XbFr664Rb1xAzjb182sdpwXgwmo/yTDrq0yUkA/kYzRVlNNrONOwDxp2vByhYBz8enGyEImh/vbhAfvZb3kst3sl/dGLFevYC14qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIJ0FTYrzfwNCxuUaPUn4L/hnOhXndG4T2LUAKfuoo0=;
 b=Az+PRHMpSGUYngZU/BtrPXujPAttRJ7AimM78SvpXpSvTszeqmSf0ApBA1n74iVfybEBL+/Sin1F535vV4GUV7sojygjTIydSSG6SKWGbFfz1NfctP1PXc5kIkpQGFvK1kp7PVwpnP6V5mlunmmU+TcJnPkI9XsuWtmd/pt3muK4nxjMRvvr9Z3WPZTkDO1R+5IwmsmU9NQLG3pexFUE1aArqp6kSSVdrYPoA5h0XvfTPxPOimJeYWyKspbwgvca83tvS/Yc4dhN9dfbcEiFouSmC7HZk8veR+Z2M9uZveMUv6hLmBpGYrdgmGzGyAKtMTLbAI8WaIw/gHBvLRU1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Mon, 20 Jul
 2026 12:13:22 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 12:13:21 +0000
Date: Mon, 20 Jul 2026 13:13:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] doc: drop recommendation against bool in structures
Message-ID: <al4Q3f3Lfbv8i8V-@bricha3-mobl1.ger.corp.intel.com>
References: <20260720114602.787429-1-maxime@leroys.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260720114602.787429-1-maxime@leroys.fr>
X-ClientProxiedBy: DB9PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 53046b5e-67d3-49f2-732c-08dee6584a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qZAqG6BXbyc1g+SoufPM1sHuX/Coz94kgWfrn90rios2YqCoCmXmxL9OjOlNoxC/3Rwz4hsJIG8m53BhHrGqn7bw5JFucW5fBTd+LpqMcVKjN0jtRFog9QoSSwa6i9zMoyDb9/51Yq53bItPcUtytMOoWJ0muHCM94RxhrRww402XJ/FC3agmWjgG9yAAVNmZO7mBZI3/5bmxlf3ECE4RjPytX0Umt4tCDQ5+aWqymXAF0xDqsXHWJD0T2bwDMDFOc2HwWhwyh0OJmeQHWKZRqgavL48uM4ouJPP/fE0aY74Vtk9jbiZn9PEZLDlOPIJxQWHK91RLRb+3uvcDFWlImEhtk321epBH/EutIOCvJpDziT167yopPMXEAWnQ2OxFMr6c9vsU7n6oYPTtwc/j7/kk9bglTlHucXaxWf8QjyKxq8lGWVBxHjHepTfoDaqgtUAGLkXYDHv6HFN7nanhdXAGtKW7f3MKPtkpnC3KgZVwYwchrAKnvKu77MT3YBIpNzIsVzzHIPLY9zrVG6B4VBwFKgGL0i7CE2b29e7p0Fbc5Dejn5togDfOQ9fArgxlMf96jUKqP6Ck5G/cH5W7D/Gj+fgryIF5s5LLk6/YwHxQh5ZeU55wLra8A4CE8O8p7pDs1+PqqrRHS1IVIWjGLhYW2ol9uulyx8aJl3iGR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rKxNF0b5vjkUzZxoXFGC1fc5DtiuYEfWAW+X9ZbalcBBh9A+FUCPepJxWDB?=
 =?us-ascii?Q?+9xWzGZIQCPbbXovb2qpER7n0fnPdS4+HTgT7hbGEaV90hJRifX99WjNiT6q?=
 =?us-ascii?Q?etnXaffuCGgtIxTy2ua9yFGjnZv30SotEe5fDk6gYk2Gs4PZ8R4Mj3GszHRC?=
 =?us-ascii?Q?PC4oIdf+hpHuyJrYLVkw+hjN2MqmJNOsA0uvvi5RA842r84DQGlFQbSK1h/b?=
 =?us-ascii?Q?N+JyvaFLXGp2dUesHN80hXETgYIx2BxLS9CHAERAqlZoGJ++lcUGTBQlZATr?=
 =?us-ascii?Q?/3lBUHJ5Ac/dGd8U0tkACkRZxiMMt92bWOnmrgXbdk7IrRpm1pFcGlnn/GCW?=
 =?us-ascii?Q?bfBht6jDrBSE8iwou/VWg1I2HILkDRhR0vxv82ccodJZtxd3R3yXkn744Dyw?=
 =?us-ascii?Q?MC0qwTD1xCo7RgadM/2tWf4xwco5rsgnc75ZljMbZV9WU3MkV+fbgPl6Dj8e?=
 =?us-ascii?Q?Ge4odEH3qIVA2wBUCfpUTCqjwP2QGGVax20npzEp+NUPG91qyIIXrQeXxCB7?=
 =?us-ascii?Q?R7bvczQXyqcXCzLz1gpQogO3OgvuP6D8xzLaYOtgU79HrE10aS9ZnMUCyim5?=
 =?us-ascii?Q?u76o38eLO+mU1fcrqLUMGEBTeNmsYWb2Zbh6zfkCDNvcEjVkyxM0nrT4p1+M?=
 =?us-ascii?Q?zfu5Ox7o4Jn6lTr7zYk3ojAL7dOppDcv+F1vJJnO/RHM21D5tlCVM/qfw/6J?=
 =?us-ascii?Q?s8pawvqUvnAV/XGf4ho3v6IqhSoQok3RShQ55ST2IconMSoHDDY47/Djmww+?=
 =?us-ascii?Q?cLrV/GQva6BKtmavZJ8iIyJyCAGAmtk/Lu8pWO+oEyWmgiysmkqUmUBAywOe?=
 =?us-ascii?Q?8nWMdUlY+cxMn+zc2SMfc/PHlUcaHBu2T+YJw7M3MFYXctxynI5crujLl56B?=
 =?us-ascii?Q?TjhUYmBiMqZB85O3+idGbC2Bk7B2KKg6zdHPKEdQI9xrvsA9ohewahWs3wjD?=
 =?us-ascii?Q?VXEN7zZjcT6bet0Apvdg7lTp1paH/57pymffh8CAQlPu2QXDFbITcKthWkqX?=
 =?us-ascii?Q?0b73zf8E4UzOFvC4QWmOLiX/iItvLQg7ZrWaW8yDDpowQxCGYPauF1nTxYsA?=
 =?us-ascii?Q?DDYK85EEXJp0XIyXaffyhinxLmFE4ke8YF6cFECWEGsCcupM2wK6SS3rspho?=
 =?us-ascii?Q?tApodp+AwE7Fo+9y8itZGffNb+cIag9Sz9dssy4k0o0SBRVOdd+uIpP2Dd9s?=
 =?us-ascii?Q?mgCcOm93iXD85PmRSJ2yQOOhqgFXrgrMgqSqfANc9/tH0V+fyIkiYSGMkjeg?=
 =?us-ascii?Q?KcJv3S8S8+NVplyfYvmkngsNAwkGL6TvYqEi5UUo4pdA26yFPy4bYFZnIH9X?=
 =?us-ascii?Q?2m8R3XF71lQXSjd7GuUR4KHZGPyMX0qGoR53Onrvuo4tQNkAJ5n5/6v/qVnj?=
 =?us-ascii?Q?Uk1sgD26zIraqVjOQ9nl6xnmQu9jigAsvzwkNz4STdaQZAkl70OlOBHvFghX?=
 =?us-ascii?Q?/LyrK6WR+CNU1sipbT0FvcdaMFp6BJuYonub4H9nO9cgyJOIftBU+0Ov8dzR?=
 =?us-ascii?Q?G72ZggFH4W3xdm2wQ8YwR2TtiGX+4BuE6rUZfUbl3Nlvatqsl3dvSPBA7Pb1?=
 =?us-ascii?Q?PNgDdUZupfsfx3FHeKDmSC8ygn+GOpnqN2uPK7qvG5B52xGUN7VSYNoNlfZe?=
 =?us-ascii?Q?1z8FjJuK3CworE/p/wllmNtNeNTkSQmUpc98ttJOtHQvgBtVR74tvqp2PRWg?=
 =?us-ascii?Q?AFaQktIhgWMkn8nG1Gxnm/FdGRCrCr5kqG3sh7A2r47uc0v/XS3WM3hb6t4J?=
 =?us-ascii?Q?5Zq+bRJhlPklo/jglVdnhTs5yB/GJrc=3D?=
X-Exchange-RoutingPolicyChecked: SYwsAptDC0TItPai8Xz5hwGUbOuISqIyzqXb4rGjzLzdc/TPUI8+vRMeZgpmfBYSXlx3xe2iIYLeWqINjD1iCDkuxjL28QWXZH+x1MkfONxoI3WLHh4lzXCKpwGR7LRqHP7i8bt6yPqtHQrz/nqhjckoUrMHONYp60WeD+dg+wdB4CRy7g3qkHCu6hG8iOd2NstAcANAjQ4EJRszjOw6s7130FMY/lmNtrbQ0OqzA7AhGiCgS9tDslzDvMXM7tSOTD7n2bU6nJpiaTSk/ihVS4yTORaCthNwswBHAtxjDVj6Du63f0AuSE5pipCuFGnbA06HWs1ZgQJkGbB88t7bIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53046b5e-67d3-49f2-732c-08dee6584a8f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:13:21.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4YAxwCZ4vlMqyIJev6GY4qF7E6Ikj1FpTjek7SG0e+ng+TQ7Y3o4G+K84C5D3gfc2V5R2vXde3+AqmFOd9SDOlGzKpBv/2KNVZR6dsp9bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
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

On Mon, Jul 20, 2026 at 01:46:02PM +0200, Maxime Leroy wrote:
> The coding style advised against bool in structures, citing space and
> type-size concerns inherited from the Linux kernel. That does not match
> DPDK practice: bool is already used in over 1400 structure fields across
> the tree, including core APIs such as rte_flow. Drop the note so the
> style guide reflects actual usage.
> 
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---

Definite +1

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  doc/guides/contributing/coding_style.rst | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
> index 976a1e1de3..11de3bb39a 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -313,15 +313,6 @@ Structure Declarations
>  * Use of the structures should be by separate variable declarations and those declarations must be extern if they are declared in a header file.
>  * Externally visible structure definitions should have the structure name prefixed by ``rte_`` to avoid namespace collisions.
>  
> -.. note::
> -
> -    Avoid using ``bool`` in structures because it wastes space and
> -    the type size is unclear. A preferred use of
> -    ``bool`` is mainly as a return type from functions that return true/false,
> -    and maybe local variable functions.
> -
> -    Ref: `LKML <https://lkml.org/lkml/2017/11/21/384>`_
> -
>  Queues
>  ~~~~~~
>  
> -- 
> 2.43.0
> 
