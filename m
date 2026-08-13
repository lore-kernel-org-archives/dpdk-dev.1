Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89792C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 12:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5481406BB;
	Thu, 13 Aug 2026 14:26:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DE8A5400D5
 for <dev@dpdk.org>; Thu, 13 Aug 2026 14:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786623999; x=1818159999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cQEG4vUTlgG4+6IuEuDXdpBOugKOkhgtvbFclWRq3Q0=;
 b=krpwJr3q0DW4KaEXZVRQE/jTkA5VT13ipMEiJZXWqU5pCnc/dQxe75xI
 D2Ad15j55xh+J7Zhe/sFRzDtiZe9FJPRtXdzhRcKySFnD2zgzAGbt0HhB
 HhhHevzMbnmnihd9MaethXwnoIZ9BscdwoBuWuPTwzycSDPiVsaZC8CUL
 BPhs8PfQcqYnVSqYV2HwrH4CsQNjp8Q1llk1g5jmaJkfTl46Si2MUM0Qr
 r9lsNn9m0yJGF10eNTwj5Rto0/WhsDrlpstBZQ+hu5lSUL3Err4lkApXw
 j+qqA+J2mfEJLJiX0O3w5EnK1h6PRC9HT+xgA0tXZp5fd08MaVxU1oDfa A==;
X-CSE-ConnectionGUID: kY4UPymUSPKLhoQ4zOcalQ==
X-CSE-MsgGUID: 7uFHJReAQzmWoXJCYkb5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98348892"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="98348892"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 05:26:38 -0700
X-CSE-ConnectionGUID: A0z4NV83QVigvb9Kz35q6Q==
X-CSE-MsgGUID: I26lnGYUT4mF4fngNHJNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="261299218"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 05:26:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:26:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 05:26:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLZ8k3OUCNARAVOTBuRaNsonU98vJZB9oMGi0C4/w4B4XPLBfpsp7vem/2/+uGkH6VwxuHEptXf90POVi2aBYh57EVPypuX4DASFfow67JxnuQIzjU6902lj3YXWrD1ozL3vnqjbXabzAakQAPf4e4R/LNklDnsRuqJRUtDvOjh+qZGKlJmBRl5Ng9DXtu8HYNltVjcaBdh6HagNDgeiOCeiUH0fE4RtHCuYe9y4rUCGK7WtYVAsc/C+g9MkrsmZ/RgwsRJM6c0F1/CORJZRXJk5H8Llz8EpL2Q45E3KsdAOKaQF2VgR+CcOkC5aAgzWlxo4astmnnwtd0Eome2Y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZcjcIW/jQiVr/OQ4U67+0XuQT3mJgBcudp/88bzaAc=;
 b=dSSPNKrLv8LTWmAHRnp/MJmTZptC2ZN45fJYWBEJe60+k4XP3P5263H4BMmLozF5ND2Gw0EnQIqw/itt8T/rmobyjsU3OoU/C9l6EM+paAdg2A9gyq4f+LINZYs9sYRwXI//EnKAkP+WuNL3MsXpCBL8WoGZj9k19dghDyKhIlIDP0Lca0Wtos5f9wlJSw2LJTpGH3UIneB0s5OQ9JkmbAoSVJ5etSQwgRQgJ1JP8Zoa39I90z+/YFb7kjZq1ZgMAQph+hj6ROAjokLbSrw4vf5c+N8ELaYtAhV/pxSViuLY7CdoVR+lrzUdzkgSPcjfnTNlIKhuQ6du5pwVm5zuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 12:26:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:26:31 +0000
Date: Thu, 13 Aug 2026 13:26:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH v2 5/9] net/e1000: remove queue stats mapping
Message-ID: <an238ySE1OkENtKw@bricha3-mobl1.ger.corp.intel.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <20260723202936.378793-6-stephen@networkplumber.org>
 <CAJFAV8zH1jA+c-CDMvJXMpbmLDywcgRWKyaL=XfrLa67EuYuNQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zH1jA+c-CDMvJXMpbmLDywcgRWKyaL=XfrLa67EuYuNQ@mail.gmail.com>
X-ClientProxiedBy: DU2P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::33) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d93a6e-2af8-4b9e-84c8-08def9361b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ITEJcYHQFp4i8MIg2YUybtBIc05hK3gq+eGLXJKe3qXj5yPm5ZMv/kOTbWTyZx674M0AVdAUC4x9xC6Am7pxk2E2DwKP9IjzaoLd9Oi2APqeAmk5mHE/5E8vGe9sWArfmPowEbeotASY0NrZj0ls6kyVUOPnmRCuWvbn2P5pBetqxG2IeNAKLfPok7Vf2JiEb4/TV6pVIP9jNbfezi3z+zdy2ZaarNwKg5g1hPWxakx8Gv5zCnraArupF78WxdniPpv0VTBTN86qtDM1MzOtJtS8j7ld1ly800fkPiq42nBaxcrpYQcZev5uAES94IVt2pSGmfk2LlZ2mZcqUwA8ousmhFyHXfVkIqg4WDTfNERh9WTufvIDqIdTn3+umNAhj2ufEOd5LjBFOyB4Ohntn9SaZDK0jxvkkl5ZHyl8GD10dIYAmpF9ag+V5thxIlVGJIHz0pHmhlwQ1m2VGk6R9mkLWjnX2XWi47ZQT08aSPzzDK0nv5ETgdgZXkF0AUDAjDooF9t3SyMdpGYenUFqA28oDmS+WcK/R6CDnxrZrVDuhxvO3rQ90TwHYzrn2dCMC/Zb/nM5E83qlku0u2zrDrtS14Nk5cID3PNhrsJRtL2o7bmfKF9n0Klxc8TTPn+vWS6/q/dUMtbZJU/QEsBXgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJirZKFfF8cfViJeoKXLSyMe/t+acLEH7emB7TEYktrM46ICjY5NL8HQqE1V?=
 =?us-ascii?Q?6AJ80UjsT2k6L4DOg5HhdG7vDjuknERTqSsqggBp6Hr48kcJo/ZSmUPVEfdz?=
 =?us-ascii?Q?rPNJ2XSgdDI3mlu7rmaZlbTT5KFL9DepEot6DPaIqXB7r748tCu/SbRoPvPG?=
 =?us-ascii?Q?gmBoRnkwRqvNYDDFUPJZUwtGlpBCuB7WfBBuA97tCn2FqtyQBEsb045gkEg3?=
 =?us-ascii?Q?sEprliZo6/lsvcwSh34LNYRofXE+Avf+lW3wnpU3aNVLO1Gpz54PJtbg+cPp?=
 =?us-ascii?Q?Mfx45H3tqJ7JmvjYxinqPRWMTbQcrdCztUzPU5F4XbS5eh9tewwpKURtGx4c?=
 =?us-ascii?Q?u/YW4LtKYJ0P/gwI9TVp3L3+pGOLq5VQCmFoftrjoAjg+OjGsi1A3ocRY3pd?=
 =?us-ascii?Q?MNADuyeKdBU22oHBs3Slt/4lS3fRQvScEF/e2LcfGmlFNnslvK+x9jYtommW?=
 =?us-ascii?Q?dJP1lgfQ780qqSmARnvWKbeybeloGGu/1ZNnY6rzJHCGibbd42fCq0jstAYv?=
 =?us-ascii?Q?XU8uBwzhjirE3A+mpCm6xTa59hZxiyPZlMwcr1jnjzMRvVmtu/ipD5ubFN25?=
 =?us-ascii?Q?H7RbYx8J/MrxL95ScuU+R7p+4tG/hSkVcfnsLsqdgUfLXhERKkqaQ4u31UyM?=
 =?us-ascii?Q?7s5hU4UMglpt+AnnZTtS+sWVRhUtZm4JI7cK1AZWrOmutMZSrYVl0WP7vcC3?=
 =?us-ascii?Q?3pCT9IdSj1Xg2GFy1oZpejkYbVq6oj2dHCKGPdiptWplS/qX3qIY0GdBzNgn?=
 =?us-ascii?Q?QVRmIVkD9u7HGLeZuvz6NEZ3b2J6SUbz6ABpnY/wXMlgJ6BU0FHcsb9HBPCt?=
 =?us-ascii?Q?yxKvAHq32wZgGEXAljJen8PObXetJrbha1GUGSQKgDVLY7DoNH6ZqTlrA5tO?=
 =?us-ascii?Q?nBmvMBx+nD/FmXGNjHaZL3c6SiW4BAwBXMzy13NFko/rdHpmv+Oc9y1hmjQe?=
 =?us-ascii?Q?Pq4b051pM1a3BlkWxpcUnLEeJe3WXGv/xyOKJAXyvTNN0pOdnubNeQtk30Fz?=
 =?us-ascii?Q?eYhM/XyCDJ3CpnNtlkqkZMqq24NWL5oMpLw7ji7riJ1Tr4k5FGl8us2saG6V?=
 =?us-ascii?Q?KucSYO3Xx+3Ta1w1sjnwVUfGHThBWWn5YDhvVv288M2cP+T5iKxk6u+zEA+g?=
 =?us-ascii?Q?RbpdV7yg8JE49HyniAFOUFe4QmK88k4DqgeiMCY584qmtNxZjIJwLbxO9ej2?=
 =?us-ascii?Q?ooRWBDGVgZ3wKOdNO33TUupUSdYQODu2rhltE/9FiNsopz1taLJMA0nvpBx9?=
 =?us-ascii?Q?9Xj+t2p5Yb1A95Xeucmk0QnNN1/UNoFXgnCOh7qGMhGgSJRhOoFwqhiFcF/y?=
 =?us-ascii?Q?NATDPfynlf3IyLOmP0GGmyakJxg1MOGickpXbjlqBoTqd+sk4pRtKxRXs1fE?=
 =?us-ascii?Q?knLkEUja71zrCm1aVFJDH/jGwwB0sRPkfE407VVMExLxAv6Fm4BM0r7W4aGQ?=
 =?us-ascii?Q?s6aXxJ8m6SFCMGeGzwU5PXp0n4VxWV/68cHGEKS7wwxclU701WnkUsU+OA8Z?=
 =?us-ascii?Q?VPiFYr78pKEjlV/DX4rf5IVKBndmwCrj8FWDRh6oZ9iCYubpxK7OxdEDxeeN?=
 =?us-ascii?Q?1/4aaBstq2wViBewLfCjHrKi6DWA4ASxO8LxFPLYpbSX7IAUwqhbumtjtdkl?=
 =?us-ascii?Q?ERqPDBnBfqdQcXtFis2jEiWF2z3llglia/ohjgyUWliS7hhOBMVSH6Zx2H9+?=
 =?us-ascii?Q?2hNMx5RQewm6Sccw22JxqcKTkpJxgxLrvLyCqmwTBLxaoKpjyW24vXC8iTuB?=
 =?us-ascii?Q?/ttNEgmVtqhHHDPMXvSElHjn7zEFIhA=3D?=
X-Exchange-RoutingPolicyChecked: fRXMENtkMYFBizFFoRuj7znbnL0yEtWiFp97laefg2HnBP9OJlWubNvU1jhLtMVKHlsoFRuX+7c6tGmCc7vtU37xKkkSzRk6DwM+fm79EM8eY5YJ4qIXlntFLUHjtuwxExfvCanzVZ3nJir/k1U9hVX94zNgU5Xsg33xiUn/VtepIXWeJdqJDGzP3d7pj9/AiKBZtj98ZCxtiZDC6Cs1feLVoUZ1i/gsRLmYuoElM0jhg8IGLed1zbKgMgEI2er5YGfUfppDnEP0HjFJSusS9aX4cx46D8G6ACt0GmVcNobwSi/jys9FMQSywOoP0aO7vfnvjaWtZiL7k08eTSVn2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d93a6e-2af8-4b9e-84c8-08def9361b52
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:26:31.8207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITvAJdO/PpsR4Y+m7xAyi5+KvaCwnJu8wPte4ticgW066uaLaLB24zDo68zpa3wrU6gZSR/CCKPWNpKySJ59vPNCtdenkLphXWGuAIycwlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
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

On Fri, Jul 24, 2026 at 09:31:21AM +0200, David Marchand wrote:
> On Thu, 23 Jul 2026 at 22:30, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> > @@ -2070,19 +2060,11 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
> >         /* Get per-queue statuses */
> >         if (qstats) {
> >                 for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
> > -                       /* GET TX queue statuses */
> > -                       int map_id = igc->txq_stats_map[i];
> > -                       if (map_id >= 0) {
> > -                               qstats->q_opackets[map_id] += queue_stats->pqgptc[i];
> > -                               qstats->q_obytes[map_id] += queue_stats->pqgotc[i];
> > -                       }
> > -                       /* Get RX queue statuses */
> > -                       map_id = igc->rxq_stats_map[i];
> > -                       if (map_id >= 0) {
> > -                               qstats->q_ipackets[map_id] += queue_stats->pqgprc[i];
> > -                               qstats->q_ibytes[map_id] += queue_stats->pqgorc[i];
> > -                               qstats->q_errors[map_id] += queue_stats->rqdpc[i];
> > -                       }
> > +                       qstats->q_opackets[i] += queue_stats->pqgptc[i];
> > +                       qstats->q_obytes[i] += queue_stats->pqgotc[i];
> > +                       qstats->q_ipackets[i] += queue_stats->pqgprc[i];
> > +                       qstats->q_ibytes[i] += queue_stats->pqgorc[i];
> > +                       qstats->q_errors[i] += queue_stats->rqdpc[i];
> >                 }
> >         }
> >
> 
> I suppose this is harmless.. but strange to read all queues regardless
> of what has been configured.
> 
I'd tend to agree. Even though IGC_QUEUE_PAIRS_NUM is set to just 4, I'd
still check for each of the stats if it's less than configured rxq's or
txq's.

Otherwise:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

