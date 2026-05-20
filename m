Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7ECD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 14:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB2B840608;
	Wed, 20 May 2026 16:58:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 07B194042F
 for <dev@dpdk.org>; Wed, 20 May 2026 16:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779289121; x=1810825121;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=McsokfiB0AZiLRWx6dpscfhJmp77gNeQrjiVmBx9NGY=;
 b=F5NDY4hroSs0SPgu0nLiLf1D1ED/EzawvD8xMpRXZZylWanrDerKZavi
 fmYCcBjDIe9k9XBYIM7/fxDrgiE3TxrHM5gEfX7JYVpzSTwyNjl1e3C7v
 cuvEeBdWilA49ekB30yUteMhp+3Uj2tqcY9nJ9LnJVqwe3lJSwNpMYfnU
 O3kmPeaynGSCoP6Ct8mAKe7oRehrlQ3jZWxnDDBlHXLWn15s4Mgp72Vi2
 TxG//+bYMQUjqCeTOFIpeX4iA5HhBtLEy0BEdVUHb9q3ToZbPdcmsqyEM
 zADOYSTHQDTagA3ZZmN7nnjeTLnQZNkpVjOYqxFr048tofnHxTy2aPc9e Q==;
X-CSE-ConnectionGUID: WVxUXehKQtKyVFZ0MHgmiw==
X-CSE-MsgGUID: X6ouD6W9QYq95xQq6sXGGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91657958"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91657958"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:58:39 -0700
X-CSE-ConnectionGUID: MrGgJgYzTKqTTD5Z92aZ3A==
X-CSE-MsgGUID: AN2jEZVaQTuifaggXIqc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237205768"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 07:58:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:58:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 07:58:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeZ8NqY96/niZBmsfXDuAhQrNUGux+uzvVFq64Ygn3iiGBJ5Tk5mVHXSMwUeVPCe5RHF0zdPzXQ/13JwpaAP2+BVRaW+pkTmmr+MkdozyC0a/SoSAqdUqCCNlKfpGfzpMh/jTsR9LfW5GDjg/s8LFcw40MP8g7S//mDzbbKsXcvw7//FCT/7VXFBflpJ5msYOIaely6fW/UjOAxTvVAzTk6oUqz9PgrdwVuSVi6SJjAi1v1oNFfpMg0LPrllFGiGg/3kTEc8myiphXAEl6u/5ztL5w6hQT7pfEgE1LKrUQ1bEMucLOTUwmizU9+jr42xDbm71A1l+n5+KRnJ9gRSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFYxmXGToVKJ176D1hQ38vHZjBjBLSm/kwV2i8UVSJ0=;
 b=NAcqK1ylzSnsN4yAWlHiB1dtF+7lhUIN6u+D5lOxVEQxquH2dXp04EWOve9Kq4Nhe12NXTj1uIuJI+5fWUtrx4WKm2a2xR6yNCqf85nM5RPo3QPt7ryf5AEvveB0i/ef/rTMF8gE5aLdmjMUPcKojFPDtDSzp9RMXUY9nQrX+Jz5qvPv1TMymrtsVtiKdrsTeYXzfRLtsWN1Rxl2/Jzfs95IyJ4Mg9fl0tL7nb7NRQiqLp9phoVhXdKJEYKfRVycQjv21bsY/903gEBQkLR+SX992XXjwMhzEtFYrFKim8hkLDkk1PAZ9bmDvUb+aGrp6JQxgIA2McCFOJ2wQPo2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.27; Wed, 20 May
 2026 14:58:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:58:32 +0000
Date: Wed, 20 May 2026 15:58:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>, <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Message-ID: <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 404a0d8e-3520-445c-923d-08deb6804258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|4143699003|6133799003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: j67cPUuOCac4/gUQb4oR49MAmeRAKyN0b9RRn7I3xIc9IUuiEFffgqntIT6g+LSc8GQ4+nQ6e6suYcebSL9KCkQmh9T0D7fpPMDG5VZ2X+5eMWw8Zc9PEkoOPbLwADzf+ioMtCFGo2jW9mUSLkLoPLHoblsJjWLwnw+E+32vdt6kI48h0XSU54b/hkuhka6fzwiwhjQhBkRwfMEnv3RTd4z5zSBP0KeuEiFL6T+DoA4exqojHSD5D3FmizdVssqrz5jYZJbOdqg0zXTduDIl2N2fMsqbgcd33f0cm+OMHifVHw+tyjceNoDUIPr86okDSHeJHB8rQ5Ol+2mWZK/7/xDk09LzEa/e1N6FCOSqHus7goLVo6tChN9dZeA2MJKPrbiD12nPpCwMir8GMMqG+ioeeq+GFIYzgtQCn6hTMbPxbfSKlE0QRzjMdX7t6rRsg1s17YHI2lVqKB5rtV8Wy2ArhF1LXSr91YvobNoC+xKYrKok1JYxcGfiepuSeAEYgsVRxIQ6QCq8nQPP7adp7esW+M7UEV+qdvdIHe7XJ+z0YhtJS+QOd9BntrrkVjnoOF2abgOvKrsWAf92o7W26JxCesB2lp2X8/geJFGReM2sxkv3pCu1aHW+fhECQ2FHGmmX7+pnIYEF8G2gsCm6gTVXuCE88V3YIaZ06Xt5MLxLWvUj/G/TGTFxBoSYRinv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(4143699003)(6133799003)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iJkV3dldPnir4fHY0IqKHDvb0mKTkezl/spj8EctVwB5hlQpUAk1Jg7jIT?=
 =?iso-8859-1?Q?w528TQhoIhcydI+1OIF9HeEjN0iELCAODh72k34Biujd1t5PV1vY1xxD8v?=
 =?iso-8859-1?Q?YIT5AtD7fSIUW6FJsQ0gBYWwPE1bvny/j5+eYnAF5ZzZzoZ4AIi2iob/vJ?=
 =?iso-8859-1?Q?PR2fPUpTEwiEF6JPhlQl+ANSpBv7kSi37UMDKgHOvM2C1yiWm6Yx7XWIzJ?=
 =?iso-8859-1?Q?vp72lqSMBEM7N25btvNOXYDME4llWQZ3fsZezNSfvS4OZGHL3Zf9EA4dEP?=
 =?iso-8859-1?Q?X+keI4ADTsBdZS7IHLt5nUZfSynTmMURKNa0s9PZSgJY+X7hgPLrO+3vcN?=
 =?iso-8859-1?Q?7i1flkcdla+KgHqRl+Hk1X5Z9/7pbhM6/bMOl4/3m+usQxsjec50lNixbB?=
 =?iso-8859-1?Q?BHdu7RRa9VDpBT5gtu6xjX35aKDCB/3Qnn/LMiOZ6XVCu/wekG4JbPkAj8?=
 =?iso-8859-1?Q?8jOGLSffjNLvjxwza3mmDqOzJREnMjKZcWz6vVFpVEpzIp8vXYrsU9SUWI?=
 =?iso-8859-1?Q?zifsXnMdI7/CisyJozodlm075xEuydcjr7Dz+UCeoY6Qlia9mDORhxwpoe?=
 =?iso-8859-1?Q?eHWCb2mVqy2a9CuRkK4NtU4cf55dWlJ2pl0Jd8GIzoltQfCBKoXohM5oZO?=
 =?iso-8859-1?Q?5ekwSgKG9S/L1c2VxiS2qL85Xpg/A/lIGFtJ8RiJaQvED69QC2MZxOtEmX?=
 =?iso-8859-1?Q?H81G22vHMKmo/5ObcrKl21SuMggayhDW9yHXBj/feTjGakegRvr7KP5JxV?=
 =?iso-8859-1?Q?vXK8wRNs/bcg126vijzzYXUr4Qp+dkrl7rrb6Tnjx9GrHgROGXO+MLJKLi?=
 =?iso-8859-1?Q?EMd0W9PVvrckCB4PCKDVh2u5WMsXWJ7MM8fJLFsKruTy/uoghEf32UG8c3?=
 =?iso-8859-1?Q?n+T2kCrdvr/pOQhRGFt7NyatdjuzLfoW4o72Mf0ymaFfUhwdr1kU08yb/7?=
 =?iso-8859-1?Q?WqbO8M9BZecXo5OxaEI+JJtxbhv82/eQM7Bx4ssZCTfO/XTEwFsMhSOp+i?=
 =?iso-8859-1?Q?pscF4f1hgml3bl+HovulX32rLA6JULUEpxWyNSNebOgzqLlIMBkdDtXAi5?=
 =?iso-8859-1?Q?T/AMtgFZij5+3LC2LJqX+bAM+5Z3zPsszrhHi8HFlzJ4mYiGvMvZA4aXfN?=
 =?iso-8859-1?Q?nSi/xjwRF6KgkH2z5bsEr4kUjp0xvkT0lB2TJcnkbdfNRLFsWs4StFEf3y?=
 =?iso-8859-1?Q?+DfsgwU7f9xZAJqJlUuPzetZVp5r09zNEOPe7ubvEfOdxt6tY6CIF9FB3j?=
 =?iso-8859-1?Q?ijjwRXIHvMUeDIUZz+bpCSiDIapIAaJH3NgJViSwV6RNB6p/T3QBo03DnV?=
 =?iso-8859-1?Q?fDhDERU+U8wQR3znHrDd2ow31twTnY6auVHPGKsB7VHsYPCTWw1tYt4ozu?=
 =?iso-8859-1?Q?nlIt5Qx09RIX4+lPDminMTk2qfpUoho0sEMYAJIP2IJ9rJq3/WI/OyMHnb?=
 =?iso-8859-1?Q?G6KQTdOOImSlw0oBwtltv7I7hr25eDqJU/gPrVPeXFstKw2rl4Mz83Xths?=
 =?iso-8859-1?Q?hlnBOWVbEU1wPbb90tSvmspd/+1Ek50xIxDA9siGtANAFW0ja/+ZB0ftBh?=
 =?iso-8859-1?Q?di/2yqlIipIXx7cP+luCFEpnhAJ39yz1A8/wxLY5HQEWCZDeZMLjrhfhSx?=
 =?iso-8859-1?Q?M3+5cwIHcPuH6zuHIh8xlDIIOOlkbg855Tp/MaE+guH9eFaxsQTnU6ocMs?=
 =?iso-8859-1?Q?woemRaGX2nWMh/0W+9x9fDxf/jleizBFc4U8VZ6BI16qmh8psy1UPQh8pL?=
 =?iso-8859-1?Q?rBBzvjEqF9oxEIVoaEMr57I770YiiX915MsAE0g8DP6HcYWkbs/t9GdGT6?=
 =?iso-8859-1?Q?v1a7g1kr5fMuVf9OtgCW4DosVYFyhQA=3D?=
X-Exchange-RoutingPolicyChecked: P63s3acgDLMJu+N8/id8ukrcbqxCYOc2ZIvNe00Yk24s65G3kZjJ4EB6LebBQbQVJ0l+ea743QhhRwO7winShLOGu2ceKLhPYHeoVAj6rOmEsvGPlocnVk3KErgEQMuBcmLwBKJWEnh/efZ0F0QNY9uJDkLMNmS77GHKZNZqjKksNGNZJdPwfvMpVUCGRPRb3odWed5JzOoxie77g3auLla8zItlne23IJ769mCzjOPdsuK9sfsHJ3NXEBUPXqjukPQZE4mhN8SDBQiUXzQQ9AnblDT8Wr4+RJewY1e11oaz+u8FhU99FrR8CTh9xVAC5jQ17blSu6A3+9qrEFOlvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 404a0d8e-3520-445c-923d-08deb6804258
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:58:32.0172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgBfrnnBiEoQekDbrhfJvJ6xTN9wzhTAP1Y6+VgEsoQYaPQKveKGXf2n79yBbsDhGBc7GUbhUGgiGpRuzBUNF7IFuzdR4YRdPYcjikSak6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
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

On Wed, May 20, 2026 at 03:29:36PM +0200, Morten Brørup wrote:
> > From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> > Sent: Wednesday, 20 May 2026 11.38
> > 
> > Add /ethdev/list_names telemetry endpoint which returns a dictionary
> > keyed by port ID with device name as the value, so users can
> > identify ports by name directly from the telemetry output.
> > 
> > Original /ethdev/list output:
> >   {"/ethdev/list": [0, 1]}
> > 
> > New /ethdev/list_names output:
> >   {"/ethdev/list_names": {"0": "0000:7d:00.0",
> >   "1": "0000:7d:00.1"}}
> > 
> 
> <rant>
> 
> Unfortunately, the telemetry protocol in DPDK is not using a common design, but takes parameters specific to each path.
> It should have used OData or something similar, to standardize listing, filtering, etc.
> Then we could have queried this like:
> /ethdev/info?$select=port_id,name

If you are up for implementing something like that, it should be possible
to have syntax like the above work alongside our existing syntax too.
The current telemetry scheme was set up with the overarching objective
being simplicity.

> And return something like:
> [
> 	{
> 		"port_id": 0,
> 		"name": "0000:7d:00.0"
> 	},
> 	{
> 		"port_id": 1,
> 		"name": "0000:7d:00.1"
> 	}
> ]
> or:
> [
> 	{
> 		0,
> 		"0000:7d:00.0"
> 	},
> 	{
> 		1,
> 		"0000:7d:00.1"
> 	}
> ]
> 
> But now we are stuck with what we have.
> 
> </rant>
> 
> So /etdev/list_names is OK.
> 
> I'm not really familiar with the DPDK telemetry, so I wonder if indexed arrays are normally returned as an object, like in this patch?
> 
> I would have expected a list function (such as list_names) to return an array.
> Either a simple list:
> {
> 	"/ethdev/list_names":
> 	[
> 		"0000:7d:00.0",
> 		"0000:7d:00.1"
> 	]
> }
> 

I think it would prefer this, but it does get a bit harder to read with a
long list.

> Or a list of objects:
> {
> 	"/ethdev/list_names":
> 	[
> 		{
> 			"port_id": 0,
> 			"name": "0000:7d:00.0"
> 		},
> 		{
> 			"port_id": 1,
> 			"name": "0000:7d:00.1"
> 		}
> 	]
> }
> 

Agree that this also would be slightly better.

However, a *completely* different approach would be to instead solve this
issue by adding additional functionality to the interactive telemetry
script itself. After all, the data for the list of names of ethdevs is
already available from the telemetry endpoints already present in DPDK. All
we need to do is to extend the python script to have "virtual endpoints" if
you will, which do the necessary queries in the background and then present
the data to the user. I think that would be a cleaner approach to things
like this, rather than always adding more C code.

/Bruce
