Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3766E6BF25
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 16:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9BE5402AF;
	Fri, 30 Jan 2026 17:24:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5842D40274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 17:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769790275; x=1801326275;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/zPcASczUETFlvg1qTvCZQ7CaVaiFsvrnl68z0zheXo=;
 b=Kf8aliCNutjF/0uLTZF7kvNIbRMS4vjVuHAPBVVWQWESEjGtHG0D0vk9
 up3OvmpkisUjCh4RymERkkRgB8J+PBgFBFWfJLjk5xJIKwJqHaPwtpsoU
 nO3coB3hHyWM8JIRDzsoT2VEaNEoDV+SLgJCsebiH8ffb9HP6duccG6SA
 QYLLtwOi96UUt9N6V0ljjdgDedO1zyN7cgkRnQy5G82KWgbgUb5qoRTQR
 Ro0OXMCJp3rOFsx8gx42xcSFJ5UGODlw5eZBnifL0KqLhIG5z7R4ELgyt
 /nafW0aN7MpyjhSlJoBTKoPvNZ0KNGNV0+CdfotTop2jw9LtkpgzfCAkd w==;
X-CSE-ConnectionGUID: 9pkohXinTHSId0jUx97NEQ==
X-CSE-MsgGUID: BcVsHlytTuOE19J5+ddyYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="70939065"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="70939065"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 08:24:34 -0800
X-CSE-ConnectionGUID: Z6dSeY6lQei8aSMOVCZNOw==
X-CSE-MsgGUID: 4ZRcCbVtT6auxXvIdtND5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; d="scan'208";a="209243114"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 08:24:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 08:24:33 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 08:24:33 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 08:24:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzOZeqYYISQj6hl66raHvXVvjN6K20gcFiycwc08T2tmpzjGOO47WMY0yhiLlORT4f5mgyG2P7Wn0o/4GcvNwgqeH+59GVPC64iXYCy2/5/UdgaU49NQ6WMiu/6qYzgwErcO+FsLYcbMemD5TChfGP/pKvy3I7+HhKLb4dUvzo0bPH0djxrGMK+aeH3fCF+zfkQXycnJDikrHzvDlY/wj4rWDHUd4i8RZeOxphX5iyVKOIgq80PMT/Dlgi0CG7c4zOk7GYV6xazIheIGuiLtLF7i6va7S9SBK/Upma68lCc2F6RBT1e9FUPLnUjVYlb5fdsYbMySpNyx/kGHETWGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwXgCUw2LDnnOIieD5/Hntuf+RzbSHEgcACftQA3CZw=;
 b=ZfBnjG7jV8AtmMHZgFPl97N5uoCavGqIMgr8IhN6CQei7epOmMIUM/ydJJhrNIdAdy2pj3n0iVIZOASXAGWjqMFKFRPlrHPhbzsqE8wdTTLW/zaDqKgF50wt9mAqE2e3VeA8qNm6vPTl2BTO8EqCyoH39rEyRrfqmQ0+pTVOOEr+t46CYHhbBu9gJDHX7tORT6eUrP2mLBwaLtYgoqvi9LSjvVHEnvS17EIZzJdeBn8T8m33FVEkuOU3ZW5IAVomBxWOlHqqd77xWE+kjfyt/ZtCodXe8ZIWYIDMOdokIz2LNg1DHpPOlgsTFBAqAr9FqnQXomqMwJj3uEYH3mZOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 16:24:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 16:24:24 +0000
Date: Fri, 30 Jan 2026 16:24:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <aXzbM3v7pcRecrtd@bricha3-mobl1.ger.corp.intel.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <20260130082028.1d3ebeb9@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130082028.1d3ebeb9@phoenix.local>
X-ClientProxiedBy: LO4P123CA0493.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 723b42c6-dd9e-411a-6055-08de601c07ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WA3L8SG8XLbNUh5mCjQYw7VCp8ISeC3tQRmA89uonnSCvegHwICOLagfXA?=
 =?iso-8859-1?Q?DOR9bsbbzJznkVTEc288QneqRh6kcW56WpQ4Jnyx1gGCoUF39JTxzfPmq2?=
 =?iso-8859-1?Q?dh5ORMLNTNFVcgxZgunL94I4RaMmWJ8OYr25exiGjs03vrjIOtuctg2rH4?=
 =?iso-8859-1?Q?wPvgA2gYAcyR65ePcLxla6heb25N7GAtNZMm8V9rjVWTPfonIqZVgFKqoz?=
 =?iso-8859-1?Q?NOZJvOdHRO67G1x4r2+wmcrumfSicxi96VwsayadshtObuyxQnnXhMjCZB?=
 =?iso-8859-1?Q?L1MDYohhAkRAXnztfIaInIjHRNOGrGWnKYt+kKmQHxRQAzOTX10TozlcOG?=
 =?iso-8859-1?Q?VqKQP6w3OHV8vKWJZWPFXh1J7VKb5CkIke1winRctVl9i3NkYUIKA7hZCw?=
 =?iso-8859-1?Q?DfD1WmVdiw9UX4ivbLsSPS8AhfM0whgfVvM+kFeJH5krAOa2rdM8DasvgO?=
 =?iso-8859-1?Q?oQIeDk1So6REz7DgGX4gjHocNMr4lgH3etMRKTAMxosvEK0Q9Oj6yrf2mj?=
 =?iso-8859-1?Q?lczLAk524Li7C2ObMiSIrwrKUWp7BvomKtpvSiDf4ePz6hfaFkv8SqXqC1?=
 =?iso-8859-1?Q?ok8lm+BwOD4ChfAnuM0Ie4ZYgTElToekMp0PC/Dq7KE5Pii7hVThcpsRgO?=
 =?iso-8859-1?Q?eya1bqAU1MaQLeW0AQD/TQBfU1k5+vgaGA8O8HG8DNxiG+BMZiMsSydAxF?=
 =?iso-8859-1?Q?hqU5aTN8nnYAhDds8iHwlsmHNTUkl1mv27nY536/mZ/cNe4XQTJRfBgD4B?=
 =?iso-8859-1?Q?FM8gUMEMIgHvmGxIxR7m7N/lN8/bWDAiZOINUb0ma3X0HKKRuvMgy8l1DT?=
 =?iso-8859-1?Q?L1dc3S1dUmCE36+P1ETeFXpJ3IuM5jpU0/JAkYnJtUiUMzyCfXrGFU84e9?=
 =?iso-8859-1?Q?WvHfGJyjNv61EGHhFD9zKoTfFzlNY0sqLC0r30deT/oyUtjpCS+FWli2e7?=
 =?iso-8859-1?Q?EhF6RF/n6Wy1nyf9GiL5p16Ub+FsnCOL4MMetUS7BXXw9SmpWQ0Z9I946h?=
 =?iso-8859-1?Q?oxqRtwf5c/AxLAcgsnNuzZAsnSFmGSrk8+PNE1omxPsESePh6T3APMMd+Q?=
 =?iso-8859-1?Q?6zHc9NTjVTy5lkJgSLE7wCZCuaEs/3pOyXzGqiL379ly/ZOwiqWAtp2zcG?=
 =?iso-8859-1?Q?RfIZSur/39Dz7UoD4EAg79XCdj3Xy+vQPZKjBFklBKYlsWsLpNisA1GnK2?=
 =?iso-8859-1?Q?gC7CWofNnaiChDGsWA6fapypfIJ9ZiDwSDvwLCeqxTlJJklZy6TOKxy8rE?=
 =?iso-8859-1?Q?pU1252sX6xruJ14U39G7snOTJCLKeOQgmqs3DB1m9tRtf2e2dhBXSvh9bI?=
 =?iso-8859-1?Q?nwXX5AnrhHzJUVtvt2zBsFd0uCDCZUVgqTnD0nP7OqSoc/qdeXeFtEupe6?=
 =?iso-8859-1?Q?x4543ZACgKoWYqUifX7Dmilau0kSxGHZrIDUSKum9lmMQjLYHD7d/PX1mp?=
 =?iso-8859-1?Q?sLtpQS2QMbP2PHLBiMVxYFgmebLFdn1vwjHa/L/5vwXkbOzOT6/LZosvH9?=
 =?iso-8859-1?Q?hSXMN4j9tJtKA19KregsALxbZlYtsuAatdH3LjpwHgxFJ0yzX3lMZMjJBO?=
 =?iso-8859-1?Q?6vhQkWQewfSwFsZ+pxjwrEZMSzEu/NYEuvmIDU7VUy0xT4OCEjlmKwlLx3?=
 =?iso-8859-1?Q?drVJvgERWdn7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ijjbab8ty4IUdkOfEKBJsSBiEf9YuRo3NMoogJebZbjw1dfo3T7zD2slBP?=
 =?iso-8859-1?Q?+dItmCjn3KHh31ziYCpr9qeJkNAOGR3hj5WM+cOuBxeY1SBwzQn2Trsx9X?=
 =?iso-8859-1?Q?61dmyzznisiLbGDaxXQDTDFowP2yyvKCLvpI7A1SOip5yWrDj2K9We/esW?=
 =?iso-8859-1?Q?OQNgRBs0e9IdNB6j5XdG4UaYURKQRJIpl94CWDleHzmwFpg6jk+aaCLHI7?=
 =?iso-8859-1?Q?37l7RzsFW2uJgZ8Bvc8SNL+LLtcEKGfht3MOzadHBp6roGSq/EHCCBEOC/?=
 =?iso-8859-1?Q?19CbzjfOzhLAtp3vRbnPxcHgGkZJVce37lYaO4rHPprk+JoYHmJS+HhLJO?=
 =?iso-8859-1?Q?pjxxrrGsQWiRv7b+y7yzprXHXlPo0LjzX8+s8TbjcsRgAZR9LZG7bewOw5?=
 =?iso-8859-1?Q?9JKgGGI3RcPjNJP6VJND74FCnboqei/zmYLb4D1MXoMPglptjDP06jGK/l?=
 =?iso-8859-1?Q?sem4GD/6u3N/IMSwJqiADC0oABUiSRWYDH0+fWPds/+G2ZqrjBvcQYRPTZ?=
 =?iso-8859-1?Q?wFtAIeAcqee0nbEdTQ0aY68Fgd0AV4AXPf/9uDrIH8fjk9747p78OphqeS?=
 =?iso-8859-1?Q?9mXTFCelOGBL/GFFgXQ7er6Eb8PKQ5oMsqcPjuIBuviuNtnNZEIy+7y+no?=
 =?iso-8859-1?Q?dummJhb6M58uKBOQek1AGT5wfofarXLMkSxN43008WUukolELYt173oZ4a?=
 =?iso-8859-1?Q?WWRANxI2f8Ky6IRbkY45AF7X9N1wGqZSAXQO7CSbF2YCtgI5ARz0xpa11a?=
 =?iso-8859-1?Q?kaiXQUaPJqLZqubwKgkvTkQGXYhIhfkL9Tp7+nLLkIhARh6wgNKinGcAWO?=
 =?iso-8859-1?Q?hsFtZB/3jlvjj6xsuY+9n6QOdz53A0+8tHtmWs0WL0kBahy44EQGQEqsp8?=
 =?iso-8859-1?Q?6PN2y5l06g5amPHNa4e1ILm7+fOE9HGauITSia2eScAZjLPSDLjAUc6tlB?=
 =?iso-8859-1?Q?hqZrZgLWdIdGgv0mpcgD+btIapjYagmJSOF3BI+ICWdxywmTugJ8Sy03ic?=
 =?iso-8859-1?Q?twrL+E+Qo2GblSIlHmXb5g6H9lBlzv0k9+HMRn9qZjEmViulo6CoYcxKAI?=
 =?iso-8859-1?Q?uDXD8q9bM1sBhKufhkup2AEZgfQqc3yf3h0zY574zNvuD9j42KfIA25Cy1?=
 =?iso-8859-1?Q?oE0eaew41dN0X8r86feyQJTvDyBaYAwzW0UFYI9IPMBw5v5LDDvhBicF3M?=
 =?iso-8859-1?Q?v+sH/JnYLLP+4DbVPjJGke6J7s2M01xSozJfc00cpfUh/BaJNkNG9mV26S?=
 =?iso-8859-1?Q?DmwjHJlK2O2jp3aVOznZv6qhE/het5yd6nkL4uOZrQpWYdCH2ZBaD9Nj0i?=
 =?iso-8859-1?Q?TyqzIKm+kodMf5Gp7xTZuy1VDORwXjRD5Tahxr8zepoc6n1koO6ERS0dkZ?=
 =?iso-8859-1?Q?2593KmGxNs6c/KbFuxy60eYd88K887Ml0FhXGbnMEoLaNQrkqdphlyg8gh?=
 =?iso-8859-1?Q?lyM0RQAWxijDGZm02zzr2vQe/2tnb0964CEktTN8s4eZ7EdKC/ICJ6iHou?=
 =?iso-8859-1?Q?ViJSxJhiGCrwT+TMZOQhVYMY5YYxaX2lcdtP7xFjNEA6gji6FgtxVe0fxx?=
 =?iso-8859-1?Q?61IZMMHUWRPt409L1VNAZlB25HdH972xfX8lKvOBqkzsspzztz+hK2E65t?=
 =?iso-8859-1?Q?W4PQwFFRwe2Ed9C6Iz1za00FwVeinJtTqLat6W14+MXuWtW4p+o8MPZxCL?=
 =?iso-8859-1?Q?ANmQZG7EWrzdA5pCBTJLM97aLaAVJo1Iere6yUcS1qz5QJh3aac7kHTqvD?=
 =?iso-8859-1?Q?Cqn/cpyZpW+hTuz7Vkl89IeDQ6HgeaRxl6b5OlV+RfATpQ+EGg9sUOoyXu?=
 =?iso-8859-1?Q?k1u6sWT4NKAc3+ELIaAzwS2+pyLPVkI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 723b42c6-dd9e-411a-6055-08de601c07ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 16:24:24.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4wkOdMWOJaExqGoDHbcr5UAqv+zYnWYtI9kAgmBHG9y2qO7pSbM0FjwJIEN9vj5HqQk569jlJFis7W5+IrTDOG0wDMEQVm3PA7bhvjKUw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
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

On Fri, Jan 30, 2026 at 08:20:28AM -0800, Stephen Hemminger wrote:
> On Fri, 30 Jan 2026 10:46:16 +0000
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
> > +__rte_pure
> >  static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
> >  				     const struct rte_ether_addr *ea2)
> >  {
> > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const unaligned_uint32_t *)ea2)[0]) |
> > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t *)ea2)[2])) == 0;
> > +#else
> >  	const uint16_t *w1 = (const uint16_t *)ea1;
> >  	const uint16_t *w2 = (const uint16_t *)ea2;
> >  
> >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) == 0;
> > +#endif
> >  }
> >  
> 
> FYI in Linux:
> 
> static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
> {
> #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> 	u32 fold = ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
> 		   ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));
> 
> 	return fold == 0;
> #else
> 	const u16 *a = (const u16 *)addr1;
> 	const u16 *b = (const u16 *)addr2;
> 
> 	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2])) == 0;
> #endif
> }
> 
> In FreeBSD kernel, there is no helper they just use memcmp

+1 for just memcmp :-)
