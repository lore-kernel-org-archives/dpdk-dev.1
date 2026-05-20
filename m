Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF1ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 07:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1848402EB;
	Wed, 20 May 2026 09:50:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2F05940276
 for <dev@dpdk.org>; Wed, 20 May 2026 09:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779263405; x=1810799405;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=dS7ETl3ur0Hd14Ta45YuZr0KJ25+8M8Omi/Ku9X+tjw=;
 b=g8GKnlWyIX9O1oinu4p+ibvAzmtoYtWrVwcFiMcZjnnmHmmCJt7qvyWd
 IiHdEG4MWEQp2dTJGteHUqD6fxRo0Tx05zHlvLdu7aDYl2HgbgfOv3RJs
 mb1wbYBYkmK+PSTh84p23dkl1BX8juf7Jt197ICnYqWIDstO9ikJYhSU/
 sZoa8NmQsIon7muVJImHN940B+oNLmAONxdDx9kWFYedmtIQ2PmJ6ABIP
 vtbh3QZjrzwKmD4hV6rM6Sqwp2nQDl+luJdfvHotQH/JC9vb5RNaDbi8Y
 Tpid36Xk7T/28SUxlvTt9ZIpd0NppgjigaN58u6ajLma1hgzhufoYvTWI w==;
X-CSE-ConnectionGUID: DUxyayqpR5KvsrYu9sqXsw==
X-CSE-MsgGUID: 9O12xBVMRrawbl23GArcOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="97583940"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="97583940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:50:04 -0700
X-CSE-ConnectionGUID: ALpJ4SqhR+6v0t3PuKwX3Q==
X-CSE-MsgGUID: t6l5/1KsS3OkkQwv4t0IIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="235802509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 00:50:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:50:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:50:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGtOnVyPhEilRDeU+IC6NBE8GFmvFDEE0gOv6Om6LmGfpQzR9NTnx96DgCTir3k8CDPEkgmzYjJuz7tXNKu0v9toS0J2o3Tr77Vt31Zbe9/tE+PqpidJuHIJkg5z/JxJiqe0z82Ssy9T1MY8L9TDfK9bhT9BQPQD83/qmssRSuVXonrGPfUZySGwcEQ0TrNzUXYkplE0EZpnuwZmzO9Utp/m/nxNpFeq0RN+kNny+n+oLX1VPyTh5DfpklLwhOt8PD8c0U0U7p3eOK5OQ3zjDO4aM8UtUArj2BeOhOMIUuzh8VuCNzFp7b2eoBZTPHP9sN+hUhHFnbKxVl7+feyaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlkPad27NTf4qR8yNpdmfBh880uDiPGi1ZbRzczQbIE=;
 b=hMrKjRquoLGtFZOLt6WxEtN17lI4N1n4GpcBd/1KmKJt5YeSlEnu8WTpxtVCHCLIM4TPeUdWQ0JngnC/Zkv3NnYyWJ7bdPKXussCmAv2SU3kLyjB4ZRtPgb1AzDRZpoh223mQL1G7G+d/I1r4kFmyxXGqoXOORP0UICx2gqb08IRLRiCe714vdstXgaotHjYP0tQBpiRX1C65uvfdxZc8JTY6PLnZfejwXpZZLwQiPnpXbsaBI7uEw4PsHQWoMOggcxHqa9T/I/niUYXHVn80Rho81PWm/y88kpk3o1NQRnAhXDBLELh9pdxbbkwqBELhAgZNCmlkNnEWhapSu117Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LVXPR11MB9755.namprd11.prod.outlook.com (2603:10b6:408:389::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 07:49:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:49:56 +0000
Date: Wed, 20 May 2026 08:49:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH 0/2] enhance telemetry list endpoint with device name
Message-ID: <ag1nny7mJpM1pum6@bricha3-mobl1.ger.corp.intel.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65885@smartserver.smartshare.dk>
 <689a32bf-b6e2-4646-8073-cd1f895b692b@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689a32bf-b6e2-4646-8073-cd1f895b692b@huawei.com>
X-ClientProxiedBy: DUZP191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LVXPR11MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: b07a199a-06de-4e26-5429-08deb64462e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3023799007|18002099003|56012099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: axViqe5bjsMb897cWB2keF5q3drcIZOAKnCru1u4O1B9OsRpynIazlSZM842h1vh036rKW7u+Ax9u4tovdevoSi8QKOQPNSkG7oiULJZ8JaVQotBr4FCCOsPAwwzjRxS68uwJ3IwJvfVC0gmBdmz47a1ppXlEVr31yN6TbJzatewx7OK5ecX3WS+nvQd41uU0h7t56sgbvM7xQ/scHE4FyrnwrEX+a5dtLeFTzgBV/Rf6MupvEUMu1EnyDKoo3G85HhGt2BnrtR8gnIOdulSquDkNqhQGi+DkREOoMfZ6sDRQ8rDvP+lxkbhyWVBx3CiM5R+CjHDR+zWXgp6P8VFl9uuBdVfBcZLEWzBGMiuWuzBCo0wV8fuzBvs5KhvBLr8HUUaMLSU1pQAz7ci1MhBxUIq2XBFCEJl87hJ8goD5sea/DYcNgRcTG0pjb+4c7K7T+fim+lp/91I9w/db0xZs62CuysE8miYs6VYoOGkFhj4A/pK7KylkiIGbkAhFbAGlBbVt0jr33dOetVhlb3Z1fDdJ61b7pw20AwEbDnU4VYK6V7n+WgycUdP80i4TPibVROJ23YyhmqDLrgbzneX2Usm5c5KT6OzQAxW79sIABFiFnFha38m4Nf8O+i/RKVc9yo3S6UKtJSJCZZHBVNmjr99aUeTJbEi8yW6JSlANjMAuEVxXYNq16SytoyIBLf6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(18002099003)(56012099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?N+lDzhcb4yfXckwLDJv24MW7F5AeYz56r2/aDarXjxC4CFU0eq6xY4jUeO?=
 =?iso-8859-1?Q?WH4LGFa8Jgx54HtFzSah7vxWjs0EJywtLwsD6Xa54AgAinhricFPT/2Ihb?=
 =?iso-8859-1?Q?1Tw1lY188KJ1BVZXPFqOisEPCSpQazQeUtC5pf1He0xSHED+IqcxA1epQl?=
 =?iso-8859-1?Q?lfP43EYQX5yu7OfhxWRglhQZYtZGP9iIg8TFsKo84UnQ9piVzjnMumOlth?=
 =?iso-8859-1?Q?7C9de6BIhXvg2+k20gSWoou387fIje9Dj2iudPEhyznFdcVpulTsrQcQn1?=
 =?iso-8859-1?Q?r3ftJh6nuTwluL0Ek5iMNSSWxR69md9mSqZ6yJ6ppsmD7k4aZ9GGMOnVuI?=
 =?iso-8859-1?Q?PMauVmB5BoB3IiZGJ9vkKwTWIkTEF/gMpDG144YQ2FAkSNzlxzYqZK/vgy?=
 =?iso-8859-1?Q?DrbVIbp8ytBdutlt0aH5qC7Kc86MRVVk0V62tSHf9bbDMRHQ5ywkgtzl3g?=
 =?iso-8859-1?Q?W3fjbr46EW3ZvF6yiW+dlpduyjXmjrGXxCaQj5Ug4LOZFB/n6MIb8f62+A?=
 =?iso-8859-1?Q?lmK8Pvrteb4PoZY6BbPo0MN4Js73Po7F/49wKG/2GYIy8trUlD86ia6Hq1?=
 =?iso-8859-1?Q?wdSmM9eREijQJg5rY1Okm/6TYn5ddIfBMK6BWE+5nf6ppOcHMDdQDq74Kh?=
 =?iso-8859-1?Q?YML3cGUzwklFZjLYSCghWDPjARw3j9NJuGP6g/Aqoo41d2LoU2sdcdgEAc?=
 =?iso-8859-1?Q?nwFxMWtM7SRKko2EJjkCR5IS8gZM3u9Cx2ZTGdh8N1ymCZjoz0dUuLUusL?=
 =?iso-8859-1?Q?MNO+/AhcVszpHn7LYPDwyh1BnjcJ7DS49H/vGf8PAEAipKa4DWrMLZ0Tfy?=
 =?iso-8859-1?Q?vxKDa9bZ8zpV952EHZF79QV0AZX2fLh9VLyQiq5Uue2Bl1lnBacPQAsBAu?=
 =?iso-8859-1?Q?LQ9vOjLh3Y6fvOKyGYuJ7+kAxNNGxWU7tZqoTlqLiwn88Wp7B0UY6zxh2D?=
 =?iso-8859-1?Q?5viW6qrsyu8aU3WQvyJ86OJNTd9HH/BtHNdkXFS9ADB8dvlKMbH/gQ0FNE?=
 =?iso-8859-1?Q?JqUAisdpEQSkdn7rdfjk/IQfoi7B9bRqgquurLlN8fpgtR42WtKXEyJizM?=
 =?iso-8859-1?Q?8LwOd5eVtlSTs/kbG6TdsaME8BGdBk48D4pf1IqeQKelajQv/Uy/NIZE/z?=
 =?iso-8859-1?Q?XLkHsRF5MNIKEO4/JtK7Kf2m0g1yujpwHiJMcawq2oWcO62yYDQXmlJ7oB?=
 =?iso-8859-1?Q?2hWLxN/FqCXr9GRxafwNyFFTYQ5hPD9cD8fxgz1M1kFUKTRuHXA3Kq22Kb?=
 =?iso-8859-1?Q?UZguDen9RgJUx3YZodUXagVefvn/hpBdU/GndeQgd+fNWLm7fm63DRkLNs?=
 =?iso-8859-1?Q?cJqZZasn6WSGQ52BB5gs4AcB3puS6L+yrn7yZXRGLibOCofm4VYO4LBdqu?=
 =?iso-8859-1?Q?qQ4jrD8Rs+zYU2rljLK/qW7v8mLc4W1/vIWfksYF3gkhfsDtpzE8mV4s/Y?=
 =?iso-8859-1?Q?Iwto97lDCdjOcnRBd75nb7hMMQtIi/Kit7lvOWsrt2XpMEp3dgc8IiqF/h?=
 =?iso-8859-1?Q?P5Adjef3+bDZIgXc0F10Nj4zPRlansZ0URcfBQDczuDqa2l2EOoGS5lo96?=
 =?iso-8859-1?Q?dNgSMXExnlo4IiC94u+Pgohr4DjZeVZxujJGkRlf93rjK3uYSRvWjxGPkj?=
 =?iso-8859-1?Q?OPIQu9BsOnqufAd+IG5Y3QEEdCi8hoYTil2vzX26F5vTJluHpdGLZ1pHq/?=
 =?iso-8859-1?Q?MUItARTX+MloLvzOWv20+KqVhisxC1EQ3692rnn2dsl4Rg6mBcDqshqIid?=
 =?iso-8859-1?Q?bBP64sf5Uajy2w9NbE78TXzNpu9GIGwYk+QlOx1/+wd4uqcPUkRVb/xtpU?=
 =?iso-8859-1?Q?m3mfiDN6wBAmoSBTAAbUrzhw4qNy2GQ=3D?=
X-Exchange-RoutingPolicyChecked: JZ+1upcs6fM4CBQ8faC8aQT6CyMv2SkWuxYNN6n0SYxkch2sOgwn38f6ZU9mn4DiLouxW4sH42EndxiSFyz+bUkmUzJts3U6HUFglHAI9osP1t+jdi4Ii6H44Nrh/elbgEPXllZz0l5DbKS48KIc5SxtVlYURGlGUZ26zSm3Cmkxvp/vPlAC5RNcgpkx95JVjt+wK/9gcEwn1kaPSP9RMxSub1FX6S5yGYBsDVeHnDI0fAZboe9hZxAMmCjNPhFp2XeNQcbjp8ZzUSj5Xybvgvfs140mnUYqdEOf7L2DWbZ1budjbNYh6GyfvxdKmNSDQ92QZTuQWE2oohkjQAvIpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b07a199a-06de-4e26-5429-08deb64462e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:49:56.8615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9SmQn2hdAWhV7tr4oQ8U1MIbodjfPng6wg0fcGuKlJ1wugI04Ur3HFWcEwHreq5kURiDemJUW+2Tk6ekLB1JwwKZnwBzCu9xsKCpQGZN4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9755
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

On Wed, May 20, 2026 at 03:31:57PM +0800, fengchengwen wrote:
> On 5/20/2026 1:40 PM, Morten Brørup wrote:
> >> From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> >> Sent: Wednesday, 20 May 2026 05.57
> >>
> >> Currently, the /dmadev/list and /ethdev/list telemetry endpoints return
> >> only integer IDs, making it hard to identify devices. This series
> >> changes
> >> both to output strings in "ID    NAME" format for better usability.
> > 
> > For machine reading of the JSON output, it would be better returning an object with an integer and a string field, {ID, "NAME"}.
> 
> The TEL_DICT could do {"ID", "NAME"}, which like:
>   "/ethdev/list": {
>     "0": "0000:7d:00.0",
>     "1": "0000:7d:00.1"
>   }
> 
> Maybe we could add one TEL_INT_DICT which is int-value pairs, we may get:
>   "/ethdev/list": {
>     0: "0000:7d:00.0",
>     1: "0000:7d:00.1"
>   }
> 
> I prefer the first one, However, the capacity is reduced from 512 (RTE_TEL_MAX_ARRAY_ENTRIES) to 256 (RTE_TEL_MAX_DICT_ENTRIES), but I think it is enough.
> 
> What's your opinion?
> 

I'm not sure about this change at all. This change is only relevant for
those using the script interactively, for any other use, I would expect the
the /ethdev/list call would be followed by the /ethdev/info calls for each
port to get the name. That was the basic design in mind for this, the list
call was purely to provide the ids, any other info you make separate calls
for.

Also, while not officially part of the ABI of DPDK, I think it would be
wrong to go changing the types of the returned data from this /ethdev/list
call. Any user-written interfaces to telemetry will be relying on the
current behaviour to list and query ports. If you really want to have an
easy way to get the names of the ports, I suggest adding instead an
"/ethdev/list_names" API, which can either return the objects above, or
else simply an array of names.

/Bruce
