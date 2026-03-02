Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1065AE9B34B
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 10:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25614028C;
	Mon,  2 Mar 2026 11:21:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 45F2B4025F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 11:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772446866; x=1803982866;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9hRd3L4MS/4ZQyQ0D+Dw90NpnA24o4UyIslrjIIujRc=;
 b=C3qWFpfn4wYxhhsfrO3TE5dUMR+LvrIwPe4Wp+5Ejar6I2OYZoBl4ISl
 LXyBGERVysmgW2UE3/yI5JOHpSGGUoUnCElKLeRQDBEHhmASSg7aS80Ia
 mRIvJz1HHskRLC/NMvDprBMW2Z55YjM7t4zKBL3T0LeIc0ICuq5OgQz/P
 9ORLW4tMg76gOKOH+4KBdqOthXnYcMfAv/r8U91SPytCCN3QYS2W6xurH
 Lc3X/NwGY11Jgbmf51xY3Lwr9jlPaXyvTur1VRbmNe7J8Iu4vbYyKWbdd
 XGRQ8NWQ74j7IOxJlF1AhncemsbUFNLiQLlwhgf5UhLQuiXUXdNmH1OZu A==;
X-CSE-ConnectionGUID: C3oWbDAJTY6WPl/9LqJvRA==
X-CSE-MsgGUID: KWwGliyORCi/SSHfLX1VSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73635296"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73635296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 02:21:05 -0800
X-CSE-ConnectionGUID: w1faY9FVQiWl64yoA48xFQ==
X-CSE-MsgGUID: L/FoZ0nNSq6bwEC8L9Niuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="255466804"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 02:21:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:21:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 02:21:04 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:21:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBWJfGyn0xYwwe6epyzse1LNu8JyJRr4vGYtiTvP3MdnXF4EvFxHzsyPphZuzShCDLs4gd94i/MrSMxDSUxkUz4ggoXWwvEs3geHbtktRIW4Z4UM7b3CJK5EppP0iR7TkyANgD+DssPGZt303mKBEhmzIMbxrRFuZ4mOg9PaqIV5O/QFeyjqF2F5l9H3nxu88BoCpRp2fra2XlzP0PMeKyY59o68AF8FxDaxefjZYCSee1gDd2mFlc4GRqEnOUhvCoYPYt7YYACuyDvrX+0N9Gztm44mYsznOaciZJr03GFGGnHYk9dOSs451d4/zzOiPFgTjoilTvsOmUtmtbAymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2mO+NBs6Zva84TWe/M2eKw+UhAFCaO0j/ll4l2TMkM=;
 b=CVDu//ovn4yp5XbwPPZEFCIGlQBEJxkiVy/5SFlu+yDwSEUbebwIYQYL/q4hONTYTBbNxwebHyd6s3SqPNbZFUau9KhGFB4aqDxEA7R3uZP44kHOkiJwrkqWgkrovVEyAz+rCDrxlYk4wJC4qMlmJsHyNxtCMg4ycK4GhKDa1j+GczAg8zq7xJWL1XhFpyUpE/FX5Nz1nXbDmePF55br/A0z2kP0hnAASZKtpLQsTy5VqoTbWaZQ1uSS6OuBNe+EbpgcUvN3jswGgNfLDj0K7teloLz/TDlz8Vay4cCWJp95/0f1g/YcqW7A4r5y6AnqH2w3NfQI8JGtnWYscpf5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 10:21:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 10:21:01 +0000
Date: Mon, 2 Mar 2026 10:20:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/intel: fix wrap-around check in simple Tx scalar path
Message-ID: <aaVkiEVp7Gmw10zZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260226153636.3925387-1-bruce.richardson@intel.com>
 <8ef07213-7871-44bb-9320-454f74f8cb1f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ef07213-7871-44bb-9320-454f74f8cb1f@intel.com>
X-ClientProxiedBy: DUZPR01CA0202.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: c13db3cb-4e46-45cc-5431-08de7845677f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: F3WsFUFPOXyl1e3q57x9Uo8V+Ybdnl4tXVIE5jeDkWS3Cjj6ZKBVVZHWjUwJ8k566dN4EgSsUBwI4hv9ED3tQ/kY9NKXxjJoMk3VCqlnVB1OysFFanKedgzw/toyy9m+b+wHjjjbXPpMJl+Gj8qGzA77ouS90LOhQEasTcmARcv4+4b4UqUJ/Mx/XrSGgNsdbHupr2InBJb/+5uYJ+oIx/PJ+5Nmi4Go0bqLyPe2Qbt2CZXlLrLNJG54RruJZXKTtnwmnw3+zb4Wfn5exqGuYOeSq6E78TESVN00DwtdJjS5wL2u4ZMg+oKFC4FcULOdukh2XGBRtmvhwTZ0jy2ZERwAjW3BnP5alxdqGkPHNImDJK+ixhMHfwiTX0ADFUEjgsQ6/dIW3IkLhNhzaq9idy5C9J5s7KzA2pPcR6XvNu2xB7GUOVG3OXIYsgkdVr0WuIe97fRLEwIbnrwOnIdH8oeNHj7hF8J2IoVIgnyOfq4biuvI18RfSdXXg8sKbWSuo3bT68H7KqzvNFJ2bI2bMRaIcGNjgw72oAu9SRD5ThLIcSwoOwfcwLXqYFKQhdWmYdloc3nTgVUeGdA8TIAAW9NdB+83eSYYWdvuDhhBtrhQfqvmkoKi+ypGZ3yoggP+FS6WE4LCz337cWsrGoNNONS4Gqn7AvhY5BcixkBTFYUWi9ne+wfqIIFqf2XdPV8mpGNtlszBvya9gsmLobhQ/NjFK3InZx1yVcJlWfmV3O8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8Qli91kqOtQLAqPCJJlxmoupgNV/9rsQqUeO+l03KaLdFoIYKZg/hUr42y4?=
 =?us-ascii?Q?sIGj/2s/oOtt7Vr2BOPe2tV171KFn1+bFbTSI7URubdfJJ4UsQPg7zkSki0K?=
 =?us-ascii?Q?bZB+3ADaBeNv+pFHpbQoGrWKafuyICoqJAVKpPoCvvwVghNWWz3wkWpX+ZvT?=
 =?us-ascii?Q?yAEBpPJ/Zu5grUbnet+xVvzZ5ZHYq+0ZAhw0NpCkjhywpVb4Df8njOKEBHcR?=
 =?us-ascii?Q?B4+c8T0a9wqEkm+i5F6MjzI3WXeer1aBnjSlK2Fu9b3wh87xXRRjMsRCZRVv?=
 =?us-ascii?Q?ChVCihQHdsDcFNpInSleEj42fYwAEyaB6P/CK6VIUMWWf6kPUJTb0J+TOTao?=
 =?us-ascii?Q?7baioj98LqIYb/t7AJlkdnuCnwvQ6AKr/UhQ21qYXMTVV4cRaeKYwUvek5eN?=
 =?us-ascii?Q?Oc5K4jsinV66DDyFMoL36SFYrUEsYn8qvJu3zDWsW5fexjbjB9nifYnYK2Bm?=
 =?us-ascii?Q?N3w4mnjlhaJOe7kjhBY3FAF4vjmrirZLPOzxRuqNV8AU+KO2+Yp6TGTl1BNu?=
 =?us-ascii?Q?P7E8hvVUjUXmhlU7/NEvT2bFisGJ9DrsfWvYM230YlVaDamGEeY+zb734gzn?=
 =?us-ascii?Q?IBO9nJ4nfi1o5C8LE788kTfxSA2IMjqp3L6hlSORYPFnwlgiDczJ9o1XvblC?=
 =?us-ascii?Q?e1wuaZW5ZzJE83AjEXBS+ZNDst8EgZ5Ax13BNBiwim4U05BTjQkjKmlfMujs?=
 =?us-ascii?Q?lEtjcNmBjpPLYBfrluKY7HlWrIm83PMVZQdP8nFkMMQ561h4B7fq2FgMC0sV?=
 =?us-ascii?Q?0vjmspbpA9WLke2ik45i75MdRVmhPrbA/1Rj6pXWiIHvm8V8N79XtsDj5QDp?=
 =?us-ascii?Q?fOx541M+DzvSxefdKSfZ9rMrJflZmWzvFBH961EtZTvNewOYNBHM0DD1/tUN?=
 =?us-ascii?Q?6H4c6YXCiXuCLfnow1lo1tdDNOyL3wxFP4bEy8Q9Ezd3LZJzdyE7szN3xshh?=
 =?us-ascii?Q?q3eCsZ6RVuzSNW5xXBMRYsCYxYbJU4LR1QZrE45EUopigC1dKZ86jW98J6WQ?=
 =?us-ascii?Q?kIw0+HAbLQyhQFKrcpVGwMWTxutYfnJ/dakMTT9+hNYUJeWt3lZHeOGDDVYV?=
 =?us-ascii?Q?+jeI3+4OdQy+72aq1k0rPk9RPpv5G8AlIKQLYmiMOYVnr0DrnhZfRaSmWpCM?=
 =?us-ascii?Q?GisNkgZ3wQ56qjKmkH/L73ackTwZEQu1WPPsD0p7KM25MfTOIS4dsVdq4CqE?=
 =?us-ascii?Q?P/LuRt+0qKIgOj0fqGEyuu22h1librABJMNZLiJNm0WWv3hyZpNNcadqbzBN?=
 =?us-ascii?Q?sj/IB6oKZ1jc7WagFhHBlvDeBSeRy6GpEvcS5YtECa5vpeU1cW/Z53vykYwB?=
 =?us-ascii?Q?d+JP8qX6PDr1mwlfy2KzDxMzRL+Y7h/hlAQAM9DLORezZWvjV/9D7Q897Nb8?=
 =?us-ascii?Q?phpFCLAXAC7YegAEOgC4zl9v2+RkIUmyYxc9+oo1mNI1tg8oSgR+ScQmphBG?=
 =?us-ascii?Q?snUwYnb5XlDr+xUYCRV4tVBThFSC3/5f9mbWCCU2tWV+rQB+k8L0Wse00da4?=
 =?us-ascii?Q?PugiqjfGre35KZry8W83+pxAmhKF/GWTVZqtR68+3THpXgbRwVBg0UxzHSOd?=
 =?us-ascii?Q?LmqYb9K1j8FICh71DDmTWbFE6+f4CTCzYH5hkmDGl+GrcFEtOiDKIPpDqHt1?=
 =?us-ascii?Q?cTYJ5MuBDzACjkDfpU8B0wo73soJ7KkniZUslnXUB/oyw8ujPrjwdHQnm/wb?=
 =?us-ascii?Q?NTIII+bA21xOqdLlV7fT6cpQPPR35EMo3oju+zVfT1fuX193auS7BP3gLUKu?=
 =?us-ascii?Q?MYXMxvEk19IWsOUBVCJ2HBKx34AqoYc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c13db3cb-4e46-45cc-5431-08de7845677f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 10:21:01.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdijtRbPmpFDRGTDZarNH0WIr3vNDkxYRnDwdVg9FKlLA0JJMezGjkBTvOKQIpKdAn4+7NF7/M5KT5muEDaNAoAdi3K4+EM0lgxyxA0d6tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
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

On Thu, Feb 26, 2026 at 05:08:01PM +0100, Burakov, Anatoly wrote:
> On 2/26/2026 4:36 PM, Bruce Richardson wrote:
> > There was an error condition when the burst of packets being transmitted
> > ended exactly on the last descriptor of the ring. In that instance
> > alone, we ended up writing an invalid tx_tail value to the hardware, of
> > ring_size rather than of zero. Add an explicit check for this case to
> > the simple Tx path code.
> > 
> > Fixes: 9bacf6a81b92 ("net/intel: align scalar simple Tx path with vector logic")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to next-net-intel.

/Bruce
