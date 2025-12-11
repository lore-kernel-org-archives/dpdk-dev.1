Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DBDD41C12
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 09:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E773B40B98;
	Thu, 11 Dec 2025 10:46:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 635A340285;
 Thu, 11 Dec 2025 10:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765446367; x=1796982367;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XL/6mlRnL2iTiJIS8jb7SDf9nT9rrxH+nqUXCy0TyDM=;
 b=BlOYTdTxwePOd5Uyxt3+WGVi9CZID1j3nPi1/JGC1JVSjhTkWoAQai51
 q+0u0v+6yFth4giszZMHU8QaQGjQGZLrV7AOW2De//JmEoJdCif9tD2Hn
 +Ag8NITXeTgrBm3HOVHJMKIHJS1VwAOFMEh6E2iOJPFUO9l3toF4AS+w/
 D29LJuEBpGchdPr6eevrRAP00O3kIRYStWXwrKCbUxU1DYNW8A4o5ajaA
 Ygji95t3uiFeLGvfJrqWnCkhOEd87se8OJLzwxveYfIuSAjxRrYFavNiP
 EdbNpXlpAJxEw5T1egRgGEVr/XsBYT/Z1wdiVaCXdlTEf9l03lK0CiZEc g==;
X-CSE-ConnectionGUID: LRTKksZXSaewKaRBUxxX3A==
X-CSE-MsgGUID: RD2a2kh8SL+IEI28u48HZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="77740837"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="77740837"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:46:05 -0800
X-CSE-ConnectionGUID: /1Wxk9wIRfeNMirUg9FJqQ==
X-CSE-MsgGUID: aT2562o3RRCCghWA8zP+sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201674493"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:46:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:46:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 01:46:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:46:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auW+zJH6/zorsHAaj0LvkTUirDj/nURA/XUBDNs7KnPnbjN8Kc8xlSjer7SSmDChrV/3fT9a6FRFW+DxCl1jmv+flnUnTLcP8Ilf9qRa6PaifoQM4cThEiE6Q1AXXCo6KC5vo9quHjH/rGQnRM1dloA6Ewn3fcMSniXABVmbI7AnSIRzHN5Jng7b8tcWdhizQLWi/tN/6puy9Z6LD4pwAp0m9BklwMx7lZp+uafmEMYontj5Sl3EwTkixd2hVYRfTrV7P0CR6axTuf53rUi1BW+G1BUR8DrTtgfF01vfC7wP5gsAGRJCmbRXdKbt2LIMKu5ENzxcIYMvV8BMZEJqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSbYeHd643w+B7jZlEIxxkrUp3gGv0hvxXRXgfZNCPQ=;
 b=ByyQ4ajRPYTSDa11mhlihNUQYndvMQao7IxOQbZIfzQi0gMSGTX9nx29C4vo12AXnMYkmG5k9uPGY03SkGGdgfEVxQikeIv8qfaMcm2M+FMo2TlL/6Hgt8y1U73TLWSlr3N6LQC/cJvT9O2clAeH9miFgjO/N0OBRS9q9lsH1dwjD5QxBVtJAbGwJ63MshXplP5YOzjjpXBijaaOv5KbFnBaopiW7SGMkpTECYovOkAGmM6hDZYTJR1rPGjNoaUwbfGAwlGnZJaua/OK9B4EOTDBse5DMxbOiuvZ+MZ6Ukw3wg6YE+xvLVkvEEY+6u8LO29AOWryVJa0ylBQrj9YHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 11 Dec
 2025 09:46:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 09:46:00 +0000
Date: Thu, 11 Dec 2025 09:45:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
CC: "Zage, David" <david.zage@intel.com>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v2 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Message-ID: <aTqS0910WRdL6Tgl@bricha3-mobl1.ger.corp.intel.com>
References: <20251108080613.123969-1-yoong.siang.song@intel.com>
 <aTmp_sa2vA_2N3bN@bricha3-mobl1.ger.corp.intel.com>
 <IA3PR11MB9254B5F33796A18695D658C1D8A1A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <aTqJdlxzmd6m2G5d@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTqJdlxzmd6m2G5d@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0265.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c80d63-e6f2-409d-3ff2-08de389a1743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B8NUhDnvkeVWzTr1DdrcAPOmiFrRbc9hV6uWpltk7AYwQK82FCAIXQDBWPKg?=
 =?us-ascii?Q?yiGvyi/zuqedEzR4564mAtf1HEzFmFm2HK/5iSWpri3n8l/jDoioX9Xgh64i?=
 =?us-ascii?Q?o+5tymCQ4NaETY8EcdumBXB2GbdVbHgBwhyBWTh8/OxUWwuUwCfZM2GeAOJR?=
 =?us-ascii?Q?Eo2qGDj2ABQdJban3yDlyZdBLY6UIlApuOav0dosmAaBQbNPQd+Ztm9l8i3+?=
 =?us-ascii?Q?t72IrJpqhxm43oTJ5oe2/CvS5zJlaEWNmkInZO5HxiTwex9vM6t512wBFSIU?=
 =?us-ascii?Q?dHxHL/jReG3Tp3oPKjAd3VEiQ0hHBmJfOw9qXrsfnZGtw0vlGJFfVwz3iSfE?=
 =?us-ascii?Q?PFQDxDPgMdgHVI23lrq/tEICY830LTjVZh6I0euTu7EsH9LQx1mudb+qHLY/?=
 =?us-ascii?Q?2tVbxYwEfUTfuANutOPUUP2nO8vR4Kv51DGuW9RG1UP5QmjjJ46eqOF1DyQC?=
 =?us-ascii?Q?l1ExoBOyXe5boVxHj6LiqVzqv81wsUxrcHC8kzTnmlIxSH4yBhxzvFPxkOHl?=
 =?us-ascii?Q?9n9696HmTVJbpMPi4d3azOPMqxIFa9FOL49O3Zqe9kROepEiSd0ap4/HsZuc?=
 =?us-ascii?Q?kSOiXP9FDQ8vb/rRrmQD+0brx/RSJZreDFUJ3WuaGjnUFbK8SEXBRttIO2tv?=
 =?us-ascii?Q?hxcZWADzd5BN99+geROItfepewigtylLHHsaCJ4N1IsdmEIgvO3FMGGiD47b?=
 =?us-ascii?Q?FAwLCbxxYqPqRPbp2hI2x8Vv87FlDoZPQviE8jY59GEFDQ9FZ+kWp5rZtsFI?=
 =?us-ascii?Q?XKGaf9CHAK3MzOdwFu+/bnghJeLc5S/MxaUQZERW4DACCF1XROqRZEbo6Ejn?=
 =?us-ascii?Q?bKcHC0o134ue2/C5nMmrN9O5w8/5xeoN5jkRC8omg30Vbz5qEXXIb1JBhUAs?=
 =?us-ascii?Q?3wIJ5TtzeLzFJs/pGyPZJzERvUK6chUnti/Ma4hmzx+70IftkZyJtrQg+qQP?=
 =?us-ascii?Q?3Qa4SOjU8K8N1G17zSyBLiQkexwgmANqHkReualJFfj4L3U4pc+GL0i9DfB9?=
 =?us-ascii?Q?s/9c7mDaoJCnk5Ji/xiJ/3yLgvSKpRUJgfAvHJvu78IQU6I5bQZKaYiIVDVa?=
 =?us-ascii?Q?luPL7anR43MjdjYCQiLzcqoY7aYDO+Au7ie5VjKJOyF+CvNjRYFNHdLX1402?=
 =?us-ascii?Q?JVIMzB8Q+XbvrjVutpxMBEx/lCVj9K2lfp35mJuQf5sRM1ewlPhsa5Ya14Jq?=
 =?us-ascii?Q?B1iR0jVs3m+6ih/84D/NId0CxQhDI+LqZzY6bZgPJlG5env1DyCz1OtJgPS8?=
 =?us-ascii?Q?8wlTXacDi5cBzX+8GZApSn5g7N0DhFZMl8y8CbAZG4/KK1ujqfjNlmrVHajp?=
 =?us-ascii?Q?XO2IXjOlIa/kI2rZzjgOWypnF0ScNmSoflk1ntINX8NytEoXgIwPCAjJxCy7?=
 =?us-ascii?Q?ENbUPS/NFw+kosqX1QxUpRGyuk3wJgPt9Rjma887fESjtd49gYNkOuu4fCKF?=
 =?us-ascii?Q?dtI7mAkEDnOvOgtefJORdDBCq+Qja6JvrcCKkACeETHkvMCdC2iP0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0d2pwRtIeiiVThx6yudoOY0l20GIeKJTMoLzNg5wdFbw1T6OLVG35iXF0r1t?=
 =?us-ascii?Q?+BUGx+e9Va9MAT3ORsa2Ko2eROaLUnzP0CBR/dhslIAGZdDfutkUhUDXoJLe?=
 =?us-ascii?Q?15rODWz+mEYF+kbLD7bQeIs0hGBKEqWChFIw4Ir85nEjtXykqPASJjxKNd2J?=
 =?us-ascii?Q?hVgmW7IXzRjAFGlSYEY+fBaQUqNYRqLpDKT+hUEltRfHmCDsBwdFOsKehInl?=
 =?us-ascii?Q?KnPBXp1HDMw1gWJ6v5zks//eINgWqNZ+2JN0HEM1Oq3+Z/S73E8vbE5YyR/j?=
 =?us-ascii?Q?aRZp6PU9oD0D3X0JzjsoKDj96Xf1kGx+C8qKEQPmK+gDNapbh0ghm+SHZO3Z?=
 =?us-ascii?Q?EFmbruuICg68vXJNlckXmwnJTnWXbOUAOlrhJ2fUxT1jAEC9wmmnZgvLacaL?=
 =?us-ascii?Q?ib/TQoEQbhXZWpCBdCJEw5lJeGJHjuq9WtWrTXSSQOczDyZ3EOj4RIupaKBM?=
 =?us-ascii?Q?OlcViKAYT/3CGgXUKv05uh6KqMDbvYzx1R7KLeQn7UE0rggMAyliHlKzBJnY?=
 =?us-ascii?Q?34FOgwLafRyWX2BbhQrSZ76B2gez6bJU/57FUEc1JoCdmZACJm45XrIQDlN8?=
 =?us-ascii?Q?sz5WkmATjl6XuOnfJTCVGf2z4DJWxcClqf4OEc/e9VaNNtCNjm+8vOrRVlyW?=
 =?us-ascii?Q?9sJRYAK2ZkIxe0cBnI7GEFS3cRRxjTSG6XLLeVAVSuvUEstKPQJhN5+chVKS?=
 =?us-ascii?Q?D0AILQ7I5WpPcNtWhLBwGOJs65eCr0XQbvUZJVZa46ruCwszJxibRpH0ga7h?=
 =?us-ascii?Q?8EO0V2aXuXuF6/z5JBBYFzTleC0X1pR3W9wz3rKgmL0sBn9oq9bZWlZ+UN7m?=
 =?us-ascii?Q?Y+KsV3dbV8xnlAyk+px24ztJYFWiu4PkLWn8j9htXjItKIJbRimp4mHzeipb?=
 =?us-ascii?Q?VG7rm7y9UF/3qJkOmig+k+hrskrjwwxxrKiAOl5cykmMSvhCFzNZ0YFsl9al?=
 =?us-ascii?Q?/Ssm6seBcvknmPEibjKjo6ZhnjIWZdM1cZ2uy42POETyq9KgVVsMhoNPjnIK?=
 =?us-ascii?Q?IrHF+6PYhTQUZPJi2FBaucBGRbF60bBIANVvf71+KEIv/QPjUsZZfN0W0nFg?=
 =?us-ascii?Q?S8ynqkDCDLfndoabWXGEw2U9GsyHb+LMU8wInTm7NpdvxjIJlRR92x74eo5R?=
 =?us-ascii?Q?I+kd6IbvdMEKMp7rypLEh/wCtKF3N5RDNFAm21WVBC+3thjKY5so99qxCwDM?=
 =?us-ascii?Q?M/Oyfpapr5KRomm9WXhGbTaBKCxdKuJaNJaV9IrG854uAfjN6QBreJQn4REi?=
 =?us-ascii?Q?WyvTah5eMQoKVnOdn8FFiaBJPMuMfJnO7oIMEQ2S8XfESJIh2LI19KMwIIgD?=
 =?us-ascii?Q?qrc40umwANN4q4dx4oGjj03e9SerALi8B1O2yL6bL3RkvC0nYIrVC2/OYO9C?=
 =?us-ascii?Q?ACnmACbcQhSHxJOqAvXOCtl1VcLY3QDKfnHPuobygjs295/VBKxWooAGnYoe?=
 =?us-ascii?Q?awqRgx9gWD8OZJaPjSTRAQ6SIGm9dZmhWHHZnwtsOSQKRQ1YpZrwvPxI1M+Q?=
 =?us-ascii?Q?BZHilOVbCczl0Z6uji3oolqKSPc431ABDXHrDfdXJRZsG3syvA11/D8uRPKJ?=
 =?us-ascii?Q?3RoJsWCDgV6nqqFaULRLpJruTkqYU8o+5U0r8+k91lei92RE/J33ZUYeIlzy?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c80d63-e6f2-409d-3ff2-08de389a1743
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:46:00.0949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBGrkRcXV6wJymLdXzG2EixDLqOv+d3BT4wTtjywjch8ezbxqroG48UCDvbzJAQavRFN4LuFLZz4EzsESj8zEaYivIhrQG7yJhZYRZ0+NaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
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

On Thu, Dec 11, 2025 at 09:05:58AM +0000, Bruce Richardson wrote:
> On Thu, Dec 11, 2025 at 03:24:42AM +0000, Song, Yoong Siang wrote:
> > On Thursday, December 11, 2025 1:13 AM, Richardson, Bruce <bruce.richardson@intel.com> wrote:
> > >On Sat, Nov 08, 2025 at 04:06:13PM +0800, Song Yoong Siang wrote:
> > >> Change eth_igc_read_clock() to read from hardware timestamp registers
> > >> (E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().
> > >>
> > >> This ensures that the clock reading is consistent with the hardware's
> > >> internal time base used for Qbv cycle and launch time scheduling,
> > >> providing better accuracy for Time-Sensitive Networking applications.
> > >>
> > >> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> > >> Cc: stable@dpdk.org
> > >>
> > >> Signed-off-by: David Zage <david.zage@intel.com>
> > >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> > >> ---
> > >> v1: https://patches.dpdk.org/project/dpdk/patch/20251107031507.3890366-1-
> > >yoong.siang.song@intel.com/
> > >>
> > >> changelog:
> > >> v1 -> v2
> > >> - reuse the existing eth_igc_timesync_read_time() (Soumyadeep).
> > >> ---
> > >>  drivers/net/intel/e1000/igc_ethdev.c | 12 +++++++++---
> > >>  1 file changed, 9 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/net/intel/e1000/igc_ethdev.c
> > >b/drivers/net/intel/e1000/igc_ethdev.c
> > >> index b9c91d2446..d4edc82668 100644
> > >> --- a/drivers/net/intel/e1000/igc_ethdev.c
> > >> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> > >> @@ -2813,6 +2813,12 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev,
> > >struct timespec *ts)
> > >>  {
> > >>  	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
> > >>
> > >> +	/*
> > >> +	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
> > >> +	 * shadow register for coherent access. As long as we read SYSTIML first
> > >> +	 * followed by SYSTIMH, we avoid race conditions where the time rolls
> > >> +	 * over between the two register reads.
> > >> +	 */
> > >
> > >Not sure this is true. If the nsec value == 999,999,999 on read, then the
> > >rollover occurs, the resulting timestamp will be almost 1 second out,
> > >right?
> > 
> > Thanks for your comment.
> > 
> > According to Section 7.5.1.3.1 of the Intel(r) Ethernet Controller I225/I226
> > Software User Manual (Revision 1.4.5), the hardware provides atomic access
> > to the timestamp through a latching mechanism: When SYSTIML is read, the
> > hardware automatically latches the upper 32 bits into a SYSTIMH shadow
> > register. This ensures that subsequent reads of SYSTIMH return the value
> > that was present at the time SYSTIML was read, providing coherent access to
> > the full timestamp. Therefore, the SYSTIML-first, SYSTIMH-second read
> > sequence is guaranteed by hardware to be atomic and eliminates the rollover
> > race condition you mentioned.
> >
> 
> Great, thanks for clarifying!
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
