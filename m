Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30EFCFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 12:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5EB840671;
	Mon, 24 Nov 2025 13:20:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9F374402E5
 for <dev@dpdk.org>; Mon, 24 Nov 2025 13:20:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763986844; x=1795522844;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GnjQU7MKur4gJTQOw5fd57IcZPZwvLTko3r97pkHRdg=;
 b=Kvi/NvmEO2/Ctqo8R5PEKdYtgvZ0ynpAjXdkzODYvWAQ0vpJox+LcP9N
 mIs7R/8PaTqFPdzRFGSqHO3BS+PCFPUNV+OeRuiCionzEHDPOJ6f3/L6r
 ATblQ1vRaA4B6ZG9rPfsWYSDFFE1mvXv5paQUspjptyMfn/nrjbTAkjpG
 5pCD/KX+l8dyelnOV2D2xayhs9CiROIl09Ezo9xBNGrk9aYyYHE8Dreog
 SAef+204vxHozeBAIlRp6PMC9dIaYBueXXyGRXSZ/P1WKdO87IIpB0B4W
 craWps4QxKQsSVzi2c9866ynR4a5SOg64BlHzd8Q7ls58aMJYaHjlwxl2 g==;
X-CSE-ConnectionGUID: wJsEtVw0TsOhGv7WCY8RAQ==
X-CSE-MsgGUID: Tw4Az004R12mwuf7ot5W5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69848458"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="69848458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:20:42 -0800
X-CSE-ConnectionGUID: vstQUL5pTheClbU6yY5Amg==
X-CSE-MsgGUID: /JeBL1uoT/6/Kg9HKTml3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="222971678"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:20:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 04:20:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 04:20:41 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 04:20:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Rn8nIQF/9mZGhalJHo4OI7EDuhEQbqY6qMfrDmOAUUmZ227vgap2XAhrKNybMIFUlOMg0Iudg5KkCcnFi8DUY24P/3gquyfDfeNea0xdaImXmwmSQzUjdhCpkhBHyz9cJdRRG1DCTEN2gF5T0yH9l3M8e00a6Mntl2buHsvPcmca7QyjPBB6TV+DIFBTLWbgMpHpFQ0d348ljbwJILNo+d7LTJSqelAmrEu1i8S/3T21BRsKIRkSxQO0cQxh3ioLE3Op5oFcCruA5MIp0Dctsc1Flm8IjDSL/I+SzP8CjqahL7+hK5dbp+yXTT0DA0491uNZezeAFWvQfEHFApsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dfy6SlxyFubHWtlshRwQFaEKAzSWBy4EYdHVXz1IFA=;
 b=H+X/s6Ii2FYSlg5SoqQNEEHz1KzdJrcQhYgdv/C2SY0K4LklVahGOESz+KHzbjj2R8LaFNhtJVNxj1amOvyId2UNTZzAMpCwTBXyWnq6ftia8SmX8w4D5LiWAjYNWxy0TEsbEBl5O/8dKE4o5qANp/fEXuaBPUhLc5eC+O86Sln64XXxoe6PXn0RBUK2Q7Ja6inkcK+AH+NF+OyDqS0RPDpFNG6pudG2PNzJzqBBZXXQAPGAFGAYiBruQitcjFmC6PunrtRJSNBihGZohA/aR9CwWxhJQ0Q0O4IljNWoIuf4TNV9FOHoPE/pxxsvd/k3S6LPdFuVvrkg7lGmaoONiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:20:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:20:35 +0000
Date: Mon, 24 Nov 2025 12:20:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 0/2] updated latest recommended matching list
Message-ID: <aSRNjXjyjF2JV5Ns@bricha3-mobl1.ger.corp.intel.com>
References: <20251124085010.707091-1-hailinx.xu@intel.com>
 <aSRNLEQEGG8qgOc7@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSRNLEQEGG8qgOc7@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P250CA0016.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: d883472b-d797-4360-c67d-08de2b53de84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xefq3WKXOfZEZv1vbpElodrI8Wd1vq24HX0jYzECR8CcjPhs7x/KT+FjE62A?=
 =?us-ascii?Q?eH4+MDM9A/+SriolFH1eNq0BydJ34DCJe7XVHXpCVOcp6vasWQukC0RFFIpZ?=
 =?us-ascii?Q?STVFV8oKEu085eEpXHvqMBdJiF2lISE3LLhMpGuyDr2pZ5Rccswqq10lUmRJ?=
 =?us-ascii?Q?hgux+9aYRk2ZRucYrZu7EfqWCI1m8Q0O7zKv8AtSv6jhc9Ndg+axOk0t1fit?=
 =?us-ascii?Q?pPKd/vMKhx6uocpTNtyFYIWke/tdv5BuhEQWA+AygzsUfAAeRHEjEwZflN0R?=
 =?us-ascii?Q?Hhc1SFRQsGBhciaqNunQEW4ge+pY7E4U2rRfDA25KZ7hSl/cFjnVovY90IuY?=
 =?us-ascii?Q?YJOQQYrRW8g7YAwiSAzEOscXeGbNJRSU9PDFI5QjYoWPC34YngtCTb88S3xC?=
 =?us-ascii?Q?G47QnOGLtQPuF2bB8xmH16HqSRf/GP7/9oDlOLLlg5v6s6PY4FG7VVnJhIXC?=
 =?us-ascii?Q?SzaKlrjJMzJJPgmCktl8m6JON82jR0cV7cFHwmqgGKZItmMfNV8H/uGysEWy?=
 =?us-ascii?Q?M5Kyak/XTpDQyd3ss6exqAL9ME0INAdgr8LZGugQUkBO4y4gY44X7raBskK2?=
 =?us-ascii?Q?0dwd7gI1pnX3oXC0lQK37M+gg9z8x3NjtzK3RTuscwmCeF+t1wvssJqXsSTz?=
 =?us-ascii?Q?BrujFSRd8wQLPQBRoJZIAD8h6gUD42AdcLZxB7WNuT2B8AssSczRUkw3mWI/?=
 =?us-ascii?Q?K07OUbEBmIAVcRSb3GqC481IYN5/Hl/ezjj71BRRt8AGvsgGpZYQsw2fGfFJ?=
 =?us-ascii?Q?btAdDjv9xLgCvJTRRtdmYzIu0u7QmjssNHlDQ6a3jl7vC7YUbnAVqnjvW/Vi?=
 =?us-ascii?Q?6vdyXaTVVPhPmTEK5jPpZlEfqXJcauRk2I94mwq9RvsS4jTpOIqhC2OCw9Ed?=
 =?us-ascii?Q?PVzxv4EVllfi71+50edOHgjYrDq2EChcaI44cdxdlmoDkPHmUN5/O1284OLz?=
 =?us-ascii?Q?j4JGKWzgXc+tzpSPmEr+MzIAJLZYMJ8Qz+0kpoWZyNiOFNlZkU9m930FLXpJ?=
 =?us-ascii?Q?HydOJmdsA8LC+1QNi25AzOEhqKr8nG0hyTkuq3jfz9/a8ZUg15or/WE0rrLF?=
 =?us-ascii?Q?cJM5edVUoLKlEGulZT6VsQ7CUoytuu5wj2PE2J0u/FXo1lCSmK3hR9xwCkKF?=
 =?us-ascii?Q?VCwcjEY4e+vTH/dkaaryoxZcHyxj/+uaDW9N2txLPw3/dOkAFNWzLT1bxLmx?=
 =?us-ascii?Q?wWgo43stSNdwJtyFPGOs9TKb2NxUkOnwZqYFuE0c8TmRjt2OFjRJ99SwdDmV?=
 =?us-ascii?Q?JUxcXP7GP1UOk0n8AmjAO/mMukDQ5pL8Yh+vAWQn7E8hQD60uX3YBH7OiyE6?=
 =?us-ascii?Q?wtMsTakrNlXqBAdgoSIUzYlFcFpENtJXBvnE71atYqG+NG7t3El18a3kU/Cu?=
 =?us-ascii?Q?WMinOcDmFJHSMRK4yDC9iZNn1Hln3VFREsRL1pLdCw1Z2+J9mdSZaxbAGk+d?=
 =?us-ascii?Q?ThiBrDorKQMqQM+oKIA0/CfXOWwh+gNz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8veu0eg9zxadlhNWWLoGorhJUkRgpaykAAd8Vlw/Yp+8hkfsYtbyB/vBH7v?=
 =?us-ascii?Q?ME/s+ErCzx7VJbcLIVk+amPu8M9zg3w2VdGErTNkE1JXwOQLENbz715jHAZv?=
 =?us-ascii?Q?UVV6nFFP7GQHgtCAuhD1B+c1SOFnVJHgwlkYSgsKnOyr/L9stUTrBNQrBmL7?=
 =?us-ascii?Q?FqCXYbCRCXcCwnU4uUP0egEXRB0pYPyFKmts+UMH3WzlLIyikqdG8usiwpAz?=
 =?us-ascii?Q?Kyw/Klt/4Cuv2GG3aV5Fbtx8U8iPWXOx4FkzZjhM5U06c4OKhtA8545oq7Sc?=
 =?us-ascii?Q?nIEDvSJjL50zK8wiagaEzsQ2DS8IiClJvsnucFpz1cNQl9sp/EIZXllQADFC?=
 =?us-ascii?Q?FsZQnp2J5Jm5eLkdQxCdm9rAHdm6/lOIDrSgWYHTc0EzeRwGgDkoy7STEp+o?=
 =?us-ascii?Q?fCMbz7NJTaTm5+CaozdNZb95rqaEbo1C9fhmPWKjtbPaNybku7IBwgKOdwqs?=
 =?us-ascii?Q?mxY1mZGZqj3LuuxBiXNaevi/CTkcJsg9nOfizQkO0/08gV7Ai0I2/9aUHWpZ?=
 =?us-ascii?Q?2kus75HefIpZVGXuvl/voImRgiHuFzXONAXoe022YWSYRZ6X0+0oGcx2wsSO?=
 =?us-ascii?Q?tk6F8gTM7tdVSc9GKG66QZygK/KSlrFVhDuUF+7UUDpqv5VCezRfYyTQXuaA?=
 =?us-ascii?Q?CTTx3WqHd6cQSnGRXAyN4UAUo8nZ9yr4j0pTQHk/cnIvJAqFj5ULZ+/Kj6gc?=
 =?us-ascii?Q?+UX0lBj8Xlu5HugJhI0fSDr7zoyib35p6kMihDZAqB69cL8wjUO0MgKsFDCZ?=
 =?us-ascii?Q?nintln/iKHd9Rnc/cau7um8PGtUjX2Cb/NWra7LFe81SVpWzX2hWbjZ5Rgbk?=
 =?us-ascii?Q?rqW08Ae1fICRAy1oaKD/QjVCEIkO8MbJ/UhrlEuUgry5m7XKuRKMjYGsMtXM?=
 =?us-ascii?Q?eNql/f3p82muAGuV+rIwXCELwpSryjsIQMBV1CghwiSx+ENyO4AvKrE1nBns?=
 =?us-ascii?Q?9UPqPRr+Sxq14f17tCrxtHlq79rOYwHl220TEbGXGew7hYjIofYTcFJ8t8kl?=
 =?us-ascii?Q?r26gSMrSkLQXwHmg7vy9SGMTnJoD05vCDVx1s9Xma2ZsdaGZir3wmFC30ybT?=
 =?us-ascii?Q?GM58BVSnnrYjPC1oA5Ri+gTanMiROn1B6BmwOOFnRngnhAZ/MC4Mw2uwtUja?=
 =?us-ascii?Q?ofZ1nCBkR04c2HZ+TXjbILdjl3kkVoQGJIHaVwch1TiP0zgKoI5RXFazGP2e?=
 =?us-ascii?Q?dsu98WOqQyJPRdB0hoC1b1FNeRwHFDgsbi63xS/Ega5743nBhU9fiM6v/5rg?=
 =?us-ascii?Q?527m1g5YeFH4qCGNaE4KVxnTp5bUGbTprY+WhrMMcoEqSCVbfx73Yqe4LxOE?=
 =?us-ascii?Q?mHxQHbD3XOG1yurtLV/dO9h4byCZlAmRKkn8w9L5+GNXtjABGKsRDkyqzXez?=
 =?us-ascii?Q?aL4KogVlYGm0h95Ag8QPMI7gWI3H7I8ajktdG/6EkSAFFjhXQhjoQQHElS/J?=
 =?us-ascii?Q?v0cwMmSgo1w98zw6ZGRFmlLv4yRqUnElSMAmcIoFm6zSTg3mBw9qAZ8bDyfn?=
 =?us-ascii?Q?zFJaVfGH33IGv/VHcm4C1lWonxELVha2tK2x3N/crBmUoV0EZqwFvzHndvCO?=
 =?us-ascii?Q?sqQTsROB7Ipa5stVoqYbFWDIkO56PoWc/CuYRtgGYLvoZZZPWELPMs6hXwFX?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d883472b-d797-4360-c67d-08de2b53de84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:20:34.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D7q5EfdfTecADzM2qlhcLfRTiy5YkuSySsIpNajjRbT4/i3WC7VovJwWAZzsKMdExGtby+d+IO08gWV4xIRCU8gfsSBYolShWcHfwESYFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
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

On Mon, Nov 24, 2025 at 12:18:52PM +0000, Bruce Richardson wrote:
> On Mon, Nov 24, 2025 at 08:50:08AM +0000, hailinxx wrote:
> > 1. Remove recommended versions before 21.11
> > 2. Update 25.11 recommended matching list
> > 
> > Hailin Xu (2):
> >   net/ice: updated latest recommended matching list
> >   net/i40e: updated latest recommended matching list
> > 
> Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to next-net-intel. [Squashed both patches into one.]

Thanks,
/Bruce
