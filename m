Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22359ECD6D6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44AB94026A;
	Wed, 11 Feb 2026 19:12:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5C5CA400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833544; x=1802369544;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=omamUHVcGbtJXPDGbI4S2oe2og222megcM37LaocB0M=;
 b=Wk3YjcdhIqLWm8YWby4KZewTqJOZ6iVjO7nVndEx43tguboBuTOn9HSY
 DqQzVv78mrKJVqmZ5R0fcJ/jXYUG6d4kb9vd6cWj/FIOJuGit/eMJKebb
 R2irFUHpIBP6kCBIGl0ue5K8DnI1U0zsIqaIkDu3KGSmxaVlT8xt54See
 y8jTdeA2+epKYHWNImVBWikd/qatrxLnVwPBIGh1LVHTraxNzjVU8r+ev
 Dd/A6bkHd3Sk7TS4+xyor3VoRdTi9hD6hjECe395LbY0qnnBB1xvoN1aT
 kzdhzlKwshf5216nv0rvZ29toeqGEyVfqBfl0e2mCY/DOlnsOd4+Vkbe+ w==;
X-CSE-ConnectionGUID: 0nplmGU0SNGZ/Oo6bteYiQ==
X-CSE-MsgGUID: U3R/clUNRaiVh58FmqvfCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71706165"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="71706165"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:12:23 -0800
X-CSE-ConnectionGUID: UpaCkNWvQbStAMBxQ6GE0w==
X-CSE-MsgGUID: wT8t0xEbTI+g2XxkEdvn1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="235314099"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:12:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 10:12:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 10:12:21 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 10:12:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upG2G4TdDJiMix2unNAK/Xsm6Goyr7sWT/iu1aqhG9jpxfqxPnHvJzthF5Dzl66etfkbrSXECO60co3mdHPQrT5b+UvrYvo1/k5DmmOPXVvc13eIIU94o2WoF+1cpyRs+8QP9BXuD4ecxXsRobR39A7jpS0AGuJdowLFhrw6vMaWlppbeSKo6Os9MoSNx6fdhoUJXaOGV0n3MhAtUnkfYyVzpQn3JrqxzQzrWeVsDnXqTOsoBkGmzA8oFahgbKdfmSWsw8arkkH+7+iMgQi/fJ0RXZzMSykSc5OnJhHLiruap9ehFKqVLiw304+tS/DTZ3wPfDGgDeNR7QEzrLj3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCiH4Kwp6a044nDhlFu9oEpA08+V/HS++Ppo1UG0/9o=;
 b=Bs/A0RhnZwRBIeMLrMYon/AJjP6gBfcrBFRTJWsIM0yRYmUOkO8OUzyJsRRzDk7/tdD7jFkexeE4I10Z4YFyCKdBKoMlwbCD8HhQlS4/mHjDeE1BW5z8BYWFUPpvkNRlTgS3rjdAX5gxnljDEEkUv3Ufy8cvC+2OGy3nh+tLKkBcfPfRWKmP0nwJYu5LvWj0z7YxfSuF9nf5qyFrKOz56o7A3wOD2cTCwGroGSCJk2zPiB6Fc7ujRfUKDfxc9a+S+mo1CwdjTExdyq+sJUr1jXPC5kOXXl+/Vii7bFvCOTgPH1l9jdeFo8eXgOggUA2sUOcsG7rjmt0hrNVn/n9bDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 18:12:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 18:12:18 +0000
Date: Wed, 11 Feb 2026 18:12:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 22/35] net/intel: mark mid-burst ring cleanup as
 unlikely
Message-ID: <aYzGfaCdFXX2FaR0@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-23-bruce.richardson@intel.com>
 <fbe24b80-d463-4dda-92ec-9c8a8f702a63@intel.com>
 <aYs9HVCcD-TwnoUr@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aYs9HVCcD-TwnoUr@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 772a5222-92db-49e0-96b2-08de6999179f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBL6w7FJUCGoxCU6kgjw+W2+my60rUmEA3/QKxEXLo32JXHfwD5rKT0AkZRI?=
 =?us-ascii?Q?LK70hKXCuZo7r4gonwAnXuj53WNJRh1a6hxT2LTTNshxsWrnUIoCeoJxv/Z+?=
 =?us-ascii?Q?7SsH2grAYwyqi+2YvNPQcaFXS0l/uv0yG0hmQbPFgTlUfEs5JIR86mKynQ+n?=
 =?us-ascii?Q?AIKomIRrMs6yQt540tG0cy8/URtet1wIAaZP/FGahna+OMARRj8anwS5BoHD?=
 =?us-ascii?Q?UGhhLkh8RGjmu9TbB45Kd5Uzms4sE+fktoPCikzA0QtObbOHuFl2gXbUzWvu?=
 =?us-ascii?Q?5uH5ZtLFymtxCC7VKw9DuRy4TXhg0+Zww8/ZegKAJm2kK8B7sg0w7D4uOrQU?=
 =?us-ascii?Q?xQUxgfQVd1+fztXxj0iGU3dlZwu17BynkLFSMMHm4PyQ36fwIptd/5z09W4l?=
 =?us-ascii?Q?7njxLLRguSXts10EBjXeIEam4RgGSV9/qQMwBVj/GGIYho7cwjlz+u40qxcd?=
 =?us-ascii?Q?XRPFYQsB5i5FOR5VfST22NH1IkEG62pfS6WlAPzdjZnh3dXHXpu+DosKhygA?=
 =?us-ascii?Q?aje6snUucVr58h77CRIrF9R5ZHdzkIUBjPwyvC7mfbrni35O1AyAjwAFhsyI?=
 =?us-ascii?Q?sWKap5zjndkkOOPkaFYmGGVr5R4gDsTmChL1z6jM+6bXzj+jV+0P7dQ/H5Uc?=
 =?us-ascii?Q?VnmSF/LgMRyQxFMEYg2Ww7i+OPd9FOXuzCt7ck2/3ct4lYcDsOhufrHj9BgH?=
 =?us-ascii?Q?rDs6lKGQXGfO4cTtBv2HcuRsWLMw1jCXiNRRK/EKNnGyPD+sICeS5b7QDYNd?=
 =?us-ascii?Q?i/C+JRZ1C2WZg3zWmAtJH07m00/jI+CeyvbcM4KCgNzJFK5su9VQiEuk8wBw?=
 =?us-ascii?Q?JbRn0MHko1S9ZIigQAlDWJgHpNIVGy7zs/GyDs+giV0Hdg1erT1TcGFcI9jP?=
 =?us-ascii?Q?4LYPKu0tqQ0frZgtgkuidmZwbJKQuFzgMyTKlufCuziAlED92c2qNR3IUCpX?=
 =?us-ascii?Q?eai9rwn8mz+4/tKkuulPTNUNSxWkqfNALHjH2wpHmrAYHICcBgvcg85Fs0ot?=
 =?us-ascii?Q?61dXx2KBUzdtJg3OJJ3x0mghxlY5q+lHl/3NnSYrRMowX3HizMbRAOOqEqli?=
 =?us-ascii?Q?TZD8MrysyCZssXoEGUA6b6NvEa4VnlVKf8lsMXlEkQaHot/Kw5pbE+WT/lEX?=
 =?us-ascii?Q?AnGfonhhiBEPYajJTEU//evURLglvdClVTsW4wbAOrURI0/0XkSk9HPag3GS?=
 =?us-ascii?Q?b4/2sBg/ID+wudF38qjZAInzZexqpRCBuBIZu2zdSChThptP9acknVhv7vqc?=
 =?us-ascii?Q?WYHgilcM3qFZhT5VrWvnUAua4S3uAugzR6Vg7k0tTM7zHLITHnsMQ9/RBIe1?=
 =?us-ascii?Q?Zza/KfJbLsIPBIdgQvROrnaSt6hUDxg64F2RaVf3JniKwTgLv9T6967PXBxy?=
 =?us-ascii?Q?8M0EHEe2Zb4jWtKWRDa1dencJNm4IWFYJOcNHZDYMtUHxRye8DxTxt9zoV0n?=
 =?us-ascii?Q?7biStHKAA0+NP6VJ2dCW8YtjwZSI4uyq9cn3/cQWTSRrmeB77v3QLT65Rb+c?=
 =?us-ascii?Q?KbhEe0Q5Vmfh3+rKNcELcZcuipjlGG8a43j971fCCmAfKOqflyE8AjkCl7h2?=
 =?us-ascii?Q?T/p+cRC+ehKbEZObEL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXk0lIoFTMX+XfxRfZiWqfEnDfF0m/N/+CMjFYmaTHVhOzRZUrxow0ApMjQO?=
 =?us-ascii?Q?Je4WcR1x9aiYqdPN08L8XYNvTT8OogC9US/ZVocGCUHLy8IEF3ERwOp8Bg4N?=
 =?us-ascii?Q?95kymH8HXBN645Kcz/adqWzEOADcPHRnkkKiGGRRL54wkUpt6hWXlLBSS2d1?=
 =?us-ascii?Q?9pINV8Q9366BW3blI+D9E8wRuY3uC8YdV7cFAW+BYORFV9x4kPN8WiSgp77J?=
 =?us-ascii?Q?ViEDoeblgObvBOzv7NEWfx0BrgHN4Q1TXKeTgAbpSqBoVzPJcEgrFUCtevuK?=
 =?us-ascii?Q?74EUl1EzFyCAB4fYpxfLRW8xmoVFM70E4jUTMOlzhErNYsxXoyc0OWY/7L8s?=
 =?us-ascii?Q?QAI3SoZQNREXADgWZTo1XpZEu8oN6OwEACVdvnHpG87qMX7JFXe3ggkHYbff?=
 =?us-ascii?Q?rjk4HzXX8EAT0DhiRrU582WmP+vucQgFgIdp/G/TI/0NF4tAgnhjNjplqPOb?=
 =?us-ascii?Q?64XupM1k2R7r8ouETJS0thH8imF6GpXioJ53j1YSCPqOuQ2Yy4HsM07WGnV+?=
 =?us-ascii?Q?LHrChepbAMffc1jDrp9wlastQmrdsIjqmeCx0feM6M8OmBK6a0/ZExcF/wcI?=
 =?us-ascii?Q?aQ4PT10Z8rd5fB8Erl9iGUY3GpdXpJo3JxaYkCRfDficKWktS6P082Zazi0f?=
 =?us-ascii?Q?eKDDjpPcRVbCYWoa/eVgOp23lJccgWehC6q1IOVP4G39gBCDn/NEHekX/Cou?=
 =?us-ascii?Q?IMFLSQg3DoWAMRqhtANtt6d4JZOdCNGHPAERj3bvGijOiPlXpcfiaVL1rwqI?=
 =?us-ascii?Q?AjMfAjfHYbPu/av1//6tkoEmgJIEwmu4T/ZYXvZ+yAG4bTWJYriHSRNryp0G?=
 =?us-ascii?Q?Ol2tNBO23WTsGJeaBwQQv08onf14NqLiNWazgZL4J4Fm/eHc7tNjh3N6Euln?=
 =?us-ascii?Q?GsCplxlCEI/0CqafVV2ldHxyM9pEvnHXuoOP5abtcaqDUbHCzxK6nSqx7i6s?=
 =?us-ascii?Q?lAteu2q4cRiAtiXMl6C/+gPtKGALUcB7zR5ijy98FAysjcsayRHKe/GvnmW8?=
 =?us-ascii?Q?uXUWapPlypIk+4FLXpMrp7qihbO7N33OTY+1c8nEGUQwhsYYAOeF+xKADS2B?=
 =?us-ascii?Q?Y4mplnODeJve3gpOOKwGxpHHvDDa+rcrpDO5PN9kWzWiTCgF3Kjevh5wM8Li?=
 =?us-ascii?Q?4l2HmIGCJFKbamiajSxcbquNHdAwIq1uduN1bCL45QHkugb1mqlneukD6VO8?=
 =?us-ascii?Q?HBeHDqFSwTbufCc2Hn/TeHvRym5SwqDRuLsoi9AP3PS4Ht4R3OpkO0+kTopM?=
 =?us-ascii?Q?ap5EQGpsPONDQ9SJ8tZO9tkE58qmmH5reS2+wcuefONpJ4dcP8zaUa2a1dT3?=
 =?us-ascii?Q?zQlTeAaXsj7MQ93e4RjXD3EahXXLOrdg5dCg9O7JSZA4EzPhLaLt1InTWA2P?=
 =?us-ascii?Q?UkBukrMymP3JTlybFz6QK2lmnrPUDjdCN+hpd2ddFRRzS43zb84L4Jdl1OE2?=
 =?us-ascii?Q?bygovMgUD9a6qwO9G+gpLRg9LFZ067yrfK6cE+CzegjCsYndqFHDK7PgyI44?=
 =?us-ascii?Q?GBxaE4jfWdYLo2s46BRJC34X/iVyEjDWF2TZQreizSjFMM6IVCVddBJYJ0vD?=
 =?us-ascii?Q?d5HIv9SvZPrBiBUh7sWjOkLVMOpEkhsOjOsXjSF+n54sI+gUMc54C3Q3g72+?=
 =?us-ascii?Q?WIt5U3cvq5bZm952YLhoLwx73uMjVYpBwOMvI/3P57+DfKZASgf4yzrtn3GM?=
 =?us-ascii?Q?W7ddRkhxkO+ELYCBGYJsjx2qlcnGrRbMJxHS/roFQgFFY8pqi9zMoV+vN9cZ?=
 =?us-ascii?Q?Bcm6bDefm6FjL3rZq2UaxbpjXjXI8gc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a5222-92db-49e0-96b2-08de6999179f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:12:18.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX7RhiYjt8B/4EVGPniABstkWe/4bB780lXNFdQBh5xIPriI1sPVC9z3tOjvuVY6WiV7Cnf9jTC+yabgJMtVaRm4/iGyviN0ABadAJCjUZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
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

On Tue, Feb 10, 2026 at 02:13:49PM +0000, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 02:36:56PM +0100, Burakov, Anatoly wrote:
> > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > It should rarely be the case that we need to cleanup the descriptor ring
> > > mid-burst, so mark as unlikely to help performance.
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > 
> > Does it measurably help performance? I'm by no means a performance person so
> > this isn't really my wheelhouse, but I remember enough patches removing
> > "unlikely() for performance reasons" to get suspicious!
> > 
> > -- 
> Yes, I tend to be suspicous too. I will reverify and, if not measurable,
> will drop this patch from the set.
> 
This patch doesn't help performance when tested at the end of the series.
Will drop from v5.
