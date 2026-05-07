Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF2CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 13:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58031402A7;
	Thu,  7 May 2026 15:39:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 30B3540265;
 Thu,  7 May 2026 15:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778161157; x=1809697157;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WOA7w0Pg1zVC1Y4IAZ50kyFTBNDeayPmz5nax2cXlWE=;
 b=BnWq8BfupCcXyo1FJeyPFoU3jsUwzAWL994pZ0VbmcgKQ/BezyYtYj4/
 XRqQyke2p8HqAHHyAcYaKe64B/ZUG2NQLL8D34OGGYqLMuzHvzyErxNGP
 xOsed7/vq9sKk6F9feX7Q+8GxYYg6mXaJIRDBKyyYEOl6x65p+ImS0fxf
 EJXwvopZ7QsA2zNOjxkYaqTDH2NeiuPQuv0ftle3tYciN50WwKQfd0eVE
 2HIWa+Zaw4Fa2xgPSb9NJgU6N1PlzI/vpUumCXoruKVOJzC2vfHveQopM
 ROnr5+qq+qNKUDD5XO8qDzAxvbz9S3aHIAI+wkjrSarjKKYyWWV3taejM Q==;
X-CSE-ConnectionGUID: gIVxEYOIQsaDgORgIzw9JA==
X-CSE-MsgGUID: +BrvjDy1QzW7WyddYwvOMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79218896"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79218896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:39:15 -0700
X-CSE-ConnectionGUID: eB0M2fULRFqL09MjHCq7gg==
X-CSE-MsgGUID: tPUdfoccSkqaO1gRAcKblg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="232113699"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:39:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:39:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:39:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5iv77n5lbYA53Io8OJ1P0R55W4xINQMig/wTjD2zWe+mPOZ9aorwlTXqMkFrQYAjMesPYilp+0DqPPZ1E5hpZUxGBu2kfiIdd5Q1QX0uydaf/y2jB2QmbzHkuq5icK2yzCNi72KCjtlGnnpTiMlDFoYK0GYp6tZSiEGtP+XoQU7xrTBpqaaFr7/9xD1CZqV5ZIbdXoNF8KHBnE9DFbPeY8YE2VOhJnUW/3/fhFo5jpLcmFAN1VWn7+1nBdG/14FqWJ7r8SVhqVzIQBMnIJI9pHa6QkWU1DbgbL+EW0rRtrKpoq+ZyMDHDS9deMLtph5o0lL0r0IVkckF8Iz75/7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9a7cFz3rZgjL8mYzD2kRyKLy7XCkDbgaXOA3tEiYhQ=;
 b=IgGzQvi66C7FDTLjveR341ivvhB5gPhgR1Pi39n4COUEU5LXUxqELrqRjo5lbjlyyX7x8Dew66LeHkRrnF2aZi+ywZCUDdY8Ausldj6khSMiPpBqGbsrXiVyTUN9DZp7uxgFRDWkRvMFiuVxO1wp4RuDKk9ghQ4sIaEWPrF9FyjyDwRpQUinGBsg9bHpgMJuS0h55oqjGOZsmH61WYHyiyjEDyMdLqHUn34bHVfOiRVBJxr6FxbOvEILs+QZyzuNcOwxvjEqgWIrUhJ/f7qqKDueAViwbgPb1GqgAv/1thOLtqElQ50bk21O9YwqymjTEbYyOqhwGSiRHjmUXFdRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 13:39:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 13:39:11 +0000
Date: Thu, 7 May 2026 14:39:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Mukul Katiyar <mukul@versa-networks.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/ice: properly handle TM hierarchy deletion
Message-ID: <afyV-nKj-gSkptz9@bricha3-mobl1.ger.corp.intel.com>
References: <20260507125930.1668860-1-ciara.loftus@intel.com>
 <afyPdAwI6_ClTYFK@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afyPdAwI6_ClTYFK@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB7PR05CA0023.eurprd05.prod.outlook.com
 (2603:10a6:10:36::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF23335A1E7:EE_
X-MS-Office365-Filtering-Correlation-Id: 466ac4ad-899b-4161-35bc-08deac3e056c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: EA2BZWbsI+44cgnd0X+gvd2dP9tBfCDBhH5GIu7iKdiyk6A/5Ui81Mv540iEvLi1rm1QhbnpYebQRiFdLd4PEEKq7UKnVH4StBwIW8qix0dyo1Q834ThGvY7hdq17vDiof8bFXz988pM6KJTNac1uVLbRrqi7Dx8v+UifajF7lKH0MxQD6sB29UZYextdXNAOOsc2Q3l/IlB0zvGqVrviO30qsbKmHiUEuT/RyXhYfOraG2WGPKJA7HHUOqU+wHqgrlTsBgWDMxUDh0M7kLClqkLvPkf2zdp3LJb7cvXBBFN9SRWnWRMTpIFnhClqHb/qHbYfD0VZC0i2eAqU+o/0p6JQZbZBuoqigZgmY4o8RgI/rxu/GiOqaZEAgBGw/MDyB9WMift/XGmN5g2vHN/0AjwpDIJn8PB4s0UAWZWLLPOHoXa0GEOUD1oReSYE4Muriwydf6wBkOgiTNmHVC8vsZ8YkCHxrKGiw9hNzf1Gav5pFcVADDxG51/FWweBg9LWGDkrZJ8bw4ro+DDD8dCfPzHYicSfH6hcdwdAACWBu5C+6Z9RYuesx+9L2Fya3dLZ2O9Fe8bI27VTL/kb7faUTOKOT+gcHt+YM2bKEAvSWO/09r6z2bYKkzMqE/1E4UtlHFWi2iEuwz8lGWlCMi4YgLDRHOPi/oec9pod/zpl04eMYW/Uyu5TsujMmLG8IPi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmJ9cUrB0tntJLGcNP/prDHt6d8jkodGAice/AEa0QwwlL4QUnpxAbd9KPDq?=
 =?us-ascii?Q?krcE9ckOAF/Tiv0B4RsSdZ9Z05RImb1pQ5LTe/maGHTE+8h2M/V9DhKIdKYk?=
 =?us-ascii?Q?K5/FGBVNDtbSY1gFpm2j2P0W1g7pAeyhk46PjEr4JlTANKIR5PYKzMJzDrwE?=
 =?us-ascii?Q?bt/ZBndoUtlilsnPgSzSkyzYPw6t66fleHd3S3C0rzll9eW8rlWNtjsHP1Vl?=
 =?us-ascii?Q?aoqqR4eoHY6XBYWWeHAh5GcKI5kIFJcSZ5sKt433x6pL+DVq+ADxmqtiqu5c?=
 =?us-ascii?Q?lEyRbwtuym9sdyfU3N5PDrMNVLm7EL60W70Uh36gh2m7ojQTOxBI8jHf4OHo?=
 =?us-ascii?Q?2zSXDDnuCESoE4zKhU6l+0bwEQwndswRCMh0xvfh/Zn6TxD4JlTfGhR+ljKx?=
 =?us-ascii?Q?e1S6+fvilYyuWapWPsxsf8+Wi7M4Sy4+o6UwJAyylvltMqaOqBdoqURWCEw2?=
 =?us-ascii?Q?qtyQTnq23Nh8AYkCqVjpU1C3Kh474WUitR8LY4EXxtQH5qyMSw81n/Th169y?=
 =?us-ascii?Q?xih84F5BgIl6F5uNZ9MlSImENhQ7uGRsJ3bN773mB9UMPySNdd7DdP8nNUJQ?=
 =?us-ascii?Q?OuJEW6qLP6pPnh0OZY+YnQmlN/6sFEdD7r5oqUITY8ilJi+t1WlXl4O5jTEa?=
 =?us-ascii?Q?mw/W++iLdJVYg7Hpg/k5C1bp8QqXj3M4SHXWXIsXzk3AQoOudgdAxKQONM/4?=
 =?us-ascii?Q?nAVK95QWN+nheWQgKBQxR1HxYqXPrUkusuw1tjxUD1F3xBTh6htlJzva6gP3?=
 =?us-ascii?Q?K/9pwFwiJqW7KOSxOhuf3odSHRpyRZ8VMClxjb8/NGgBUZET54nIq4f0yYlb?=
 =?us-ascii?Q?m2cQkb0U7wbPMYEuyNDWwWkDqE3IazP9gqpup7dACbPcH31U7KbfGCVVauvY?=
 =?us-ascii?Q?bEC2Re+FfHqzk1Q/umYpB3z1aDK2Ej0/RcbML62gEMAk3vrxuqMpR3tcUr9C?=
 =?us-ascii?Q?QC5P5Hw7u7eRNu7ZrDpjqdHF+85BucZGt81GwtNAlsy9bPb6igydcoOKNhHN?=
 =?us-ascii?Q?9Rla4jkyFSh74Sf+8uyFPH6TkWCWH0/l+kEuXPvnWxxEVlBzXG/rrpCvY5xy?=
 =?us-ascii?Q?HVENENiRL4UlcsgfdBZrGqZMQFtsmiiHZmMSuS0MEBYoGLgky5eQCvbITVrM?=
 =?us-ascii?Q?focc0yrMButiP9QKUFcLu+JuoQ/mWivC9MJNHVPOb3Cyok7pfHDZn9PcCZlF?=
 =?us-ascii?Q?4Dmfrnwp08U5+1373AYYLaMqwSOY2wHj2meOGd2+xLBIqaF0yUqdcwbrLFiJ?=
 =?us-ascii?Q?sgA8Qjy8QpsLfvWIWmioaFhT0AEUY63sw+lwNy3gdZj5xkosH3xo+lxK83pP?=
 =?us-ascii?Q?JNca0Gn0/SqFkp+RVT6PcEX3y0QeLbbCznJeKEf9h+WKvtTQIYuWmkP01v4O?=
 =?us-ascii?Q?7IioUT4HkFKMnVhtqEACxC5CqEHlauqGym01vV/ca8DGOyGjxdyDlfCLIP1o?=
 =?us-ascii?Q?5f7Ni+73dil/EavjFVLVutYuFZVIDNkMGPBZ+fN13zqQSeZdrlCCSjnqKg3C?=
 =?us-ascii?Q?iuLR5q1R6IVurhiY8iVZoEHPY3INjVERoxq6HOGaSmxHKAW0/4t6scvgQsj2?=
 =?us-ascii?Q?/yUg5PvxDvEQzKIALtO+Gvh+o+osq89oZBaNJ0cnAaZ50UUMru8CRueJsfTs?=
 =?us-ascii?Q?IQ6yaISAFfJNa2ARWLzWoiaQT8CJl4gCOUDwTxEeV9iKkyeQqXiCv0+TUflF?=
 =?us-ascii?Q?TLjqt5H3W5npgOiWfyjwEJlzMdTSqjTreq53QCLcI4cbSP89vJLh9hKW5iHH?=
 =?us-ascii?Q?/hjuAFcjehjrYAdE3+KQ4CBUNs2EBcI=3D?=
X-Exchange-RoutingPolicyChecked: noKMzJ1ImVuWNZcMo1IvUeqo0jGb7LbrPtWABBRX2iP3SlN+IhLblngTq6h0VOYSEW8ZsNSczCUaPUsob6tzJYW+PC/NSanoypXxrpb34M/Zfl+A5VXsfcbAnICR0vNGLmufxKRfC94yI2gJZ4gBBxEVfeKceQZqtzE0w1/oGTS/hPVAsWL94H/W1PDgy+zAE/adcgyX5wZEkpAVagiREDmRcFLh4hxWe97nvgvSJ7gVT9YozKDeVr5Gr0KaWekr3js13YzVmc+HINXwCzab/weE/xrpPdcP5f9YCgADLNjD/0CLd3wgtsepX16LVUIV3il+d4e6ZPMwjlKYmeeXuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 466ac4ad-899b-4161-35bc-08deac3e056c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:39:11.4706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV7I2LqYhNXspcLHuDdaraLE90BT0Q3pYyX4EeVQyOLemQXc7fGAwpQS4zyTp7aCm3gGb4tyaOU0sGH0goF5RnIMuZE6GQsCEgcpdGNHAXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7
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

On Thu, May 07, 2026 at 02:11:16PM +0100, Bruce Richardson wrote:
> On Thu, May 07, 2026 at 12:59:29PM +0000, Ciara Loftus wrote:
> > From: Mukul Katiyar <mukul@versa-networks.com>
> > 
> > When a TM hierarchy is fully deleted and then committed, the hardware
> > scheduler nodes may be left with any bandwidth limits that were
> > programmed by the previous hierarchy commit. These stale limits may
> > remain in effect the next time the device starts, permanently throttling
> > traffic even though the TM hierarchy was removed.
> > 
> > Fix this by resetting all descendant hardware scheduler nodes to their
> > default state when committing an empty hierarchy. Also restore the port
> > queue count to its hardware default and clear the committed flag so the
> > port starts cleanly without any TM configuration applied.
> > 
> > Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Mukul Katiyar <mukul@versa-networks.com>
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> > v2:
> > * Ensure restore is only performed if a hierarchy has already been
> > committed
> > ---
> >  .mailmap                       |  1 +
> >  drivers/net/intel/ice/ice_tm.c | 24 ++++++++++++++++++++++--
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
