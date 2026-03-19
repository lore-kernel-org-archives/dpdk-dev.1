Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57203108E1FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 12:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AA2402C4;
	Thu, 19 Mar 2026 13:03:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DE9834025D
 for <dev@dpdk.org>; Thu, 19 Mar 2026 13:03:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773921792; x=1805457792;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=NtUZAZtg4Nj97H3TjMA96qO9U8Cq1FfCdD3xsAYm8aE=;
 b=KmBNB1LjN0+6njvM2gB6EPFQevKQtDCYjLx9owHnt1qiDNG3DEGey99G
 UDrkyOx1yDwbcUWb2ngO65Znt3+O1QWL3hN2q9SJjosgoO/KgNKMvlD9V
 xnDrq6b28BoaXfPei3WTruowL/Mo9pSPoCRDVKFmT7onAMjvrslPotWF1
 HxY9pBOhuhoasSXW8Rk+KZo1ePHBgm/+VbqtgZTfBmNxBvOC/2WX6oqAo
 g5pSu9hOzezbRzF2rHqmLuQaaDOuJgrM4GpI/NO/uEbIsbm92gxAbYMo/
 TPdikHkV+hCq08ckuNF8eDxV4bf/eM16kZny7YSmbkOictFwFISkDeVDn w==;
X-CSE-ConnectionGUID: rZ6ObV0AQ+C8fYmxA5IXUQ==
X-CSE-MsgGUID: S87BJSApTzGDGLTCxl06Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86350461"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="86350461"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 05:03:10 -0700
X-CSE-ConnectionGUID: GPPPE/uaS8+JP0veYQdVNA==
X-CSE-MsgGUID: STKrs0fFTT6AOWt36YMV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227426356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 05:03:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:03:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 05:03:10 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh7ow+2IRYOoRA3152y1QwbENmXU4vqhabF+QLA6rdhDkncAid0U6f8HOZ7CQembtkAb1YZRs1aLwhj6/cLhIchzb3PZPcf80R+90QkRkz9n5MPHsq+qWf1cdEXlYBG09GRHXx5lc49NsWQmwjleGouRKZFVH+rvjhCLy2ZhCDHXVx18LNXEMm2P/Uf45x89CFAZZjbwW2XSWRLAjsO24fslat/re+Udqka9KVWc2/WKAe07vmvOPuwRvCPoRFWGWOkb7HOoYHRWLwiWi0ToS2FhE9CHN4gLo9UX1tf5e/kt0XByWptZRQSrqZZI0RxSFOKStBa3CJhiCUmBuEKRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LveVhpSV/ik6vfmx9bYhCywL9MkICG9YYzRkLZGsOso=;
 b=GjTm6KHxrwCGq+o8VxW+36Z6sKNPakuVh2AEEnKAWMIXimolRjRd5HO83svsjZErNHI9qYjNs8B4h3uUCc/dv33Vr3gn810JpkrwfCbXdpxKbNrIz9BOhOjtZpWFXPLUX7U1SRk21Oni4Q247+HqPXkLNb36cvrCX/P3tfM+Csqh2N6Ci4tZbD+bdmPO8O+DJrhOwCj6WNohenm9SIXZyvtxQcaNs6AloR0vnrpZm/ukFAdn31MYicUqkRdGUeZLPEZBTQwZaku424YWa+MGds8e9abtaM74A5exUKhvX0XGXiqMCfqnzNZQTNzoKF4DV+KzDAPeemuDAcerqq6jFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:03:04 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 12:03:04 +0000
Date: Thu, 19 Mar 2026 12:02:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] doc: remove obsolete mempool creation advice
Message-ID: <abvl8iM040DNc1pv@bricha3-mobl1.ger.corp.intel.com>
References: <20260319091300.652853-1-mb@smartsharesystems.com>
 <abvEoELb6QIAHBnW@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A4@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657A4@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::16) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d0f23c-bb11-4e2b-62f6-08de85af7972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: sf97JtGj45CpsA0Pj79W66X+utRFmktjNOGqojWc1eYcLzaqbwb+9Djkf7y7AecqhxdLApmYqyQvQKYjxRGVXNePrVqt/8ogJtmPcnYWwliHBcMtVsUfA98w8J+fWSUnVu3uissycS2o5FsEHaJTXV4i1MQZZ/M50vAsdN9Dacymx7ELsElNcjsDAnFumGMeGj6xWdKsI8hGxQIFDkTRRXt2ldn+tqwX3liQas+/N4aA5zBWDn8SAqSZ84CjjoTMA0OZx7FCc4kC84P3WPWlIG/5R0k4JET3YUw75sSw5yI51BGzTq9jqFyI+i0pToZCm7+rmP5yvsTy74S5YqQvTXcEBgWTYdGXIqq/UG/CegDnJbsLfGFkbyIhnc4t4rUabrj7d8XWZH9k9iQCwHPTv68MTTPrxQ6BwILCHd5MqMzTDfbxGuOvt3rcOwb1hw5pGjZ3jJT1CCLEOz1aDLEgMS3bv/g2wRy4tvKU4KxXcyC+XqtQ7olJRo2MJ624rIPsEEqcXifIScqChLJCCGs+vXpZjMI//6fDYkkyIWL9B+CuAwmGdxcejHK3SgV4Cpoja3Fz5gjNZ8GezscwMttillZWKKGmG5KWnQZcA+1mVGGOr6knm8asYx5l1C5M/c3Z2jos8TVtvmDJHJALYTHIMDlW6jTJZlxyhXK0MNTjJQdrbkXABDrfp1WsfZHmjabqudDQEZPFLWORlJCNMhyTU0PpmVof8Pb22+ZxEmjZe1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+JrRXiTX6N74PsXPL6ai4exyS8emkzTarvBYvJ1QovNWo23gsJGjciiZQM?=
 =?iso-8859-1?Q?ZpmWgBdY8IqyMO69e68WX34ryIcz8TCkuzhl0r1CmPwz5bolZZ/V0aiaRX?=
 =?iso-8859-1?Q?i8wDANHUfEWBp6+9ZgWuAoo/B61rL8oWLKslPyDZrDcD2rU0Qv5qxS3ZdS?=
 =?iso-8859-1?Q?aS59sr09z3IhmrA3p7iqP9/tsfWVYuceumcvppFg23BK7qfT/WdZUOGcRu?=
 =?iso-8859-1?Q?KEpTQI0t6qY1Y9jW8hSDAWbtxSEbiJLMdRXZOxIcT5er6rhUTRTg3PJot6?=
 =?iso-8859-1?Q?b96QXpRnjc8x3WjJr+onfLOD08Qt+TV9r95FzCY/h/AAEWEj2pwT+nB5uV?=
 =?iso-8859-1?Q?1sXL4+qU1ZSNITMeWW+Sp98CxL0oZpSGkVhuHMKxJaXYLRJddIUSGrvWNA?=
 =?iso-8859-1?Q?s4mDxHqS203KT/ASILkVDL0azAYWSgYIZwm6c4qm++hKD1ZXIrxh8ol6k5?=
 =?iso-8859-1?Q?R6eUqxfkbVvgwvbsEMrL1BjJOcL/8EHuti3YMuTXTLAQFTW9cO0M9qSHCh?=
 =?iso-8859-1?Q?+PewV1VXxTzGBpHBkA1YSG6SaYAREuyNaOsr7w05RE+Z43S9opkGHX2uwr?=
 =?iso-8859-1?Q?beagwQc/TkScKEusGOQKyU8Anz9TkQpQhR1ZorRqyCicF4+0ngUJ82e0cL?=
 =?iso-8859-1?Q?+JETRr/eMz3S1ZvqB7aldGNQzHbuQlKnBulZ3Zz5emDQFg42HjsXA3nGSX?=
 =?iso-8859-1?Q?D9A5RqjpmLmVPmgcvlyKyn3XPmSMhra+RgDwKcCNSJoEjMNaJhsNZPEO89?=
 =?iso-8859-1?Q?3j4GK9Q+AwsYOOpMtMpxOaN44oYkHVuDtgi3QDiVV+dKo8L4ep8E3KH+ns?=
 =?iso-8859-1?Q?sz+zfTdwYSYBzlYm8VFEZcvoYrUHgHM2IMVE02Aqf9GFqO1NYivS9BW5Cy?=
 =?iso-8859-1?Q?3vy4Okwpmc2UtHdk3F0IRMY4+gL5T1Ig2sOn9rSuxo/UdntmQ4f9Ixs0lT?=
 =?iso-8859-1?Q?HeoqtUxy0GPDVoIrs9AtK1cGMENCBBuVXbkOU4GSyo96f/GhuzbiwV/yOH?=
 =?iso-8859-1?Q?WJToM/PdiNo2lkxAF5yx43g1c33vgfCPSsH3lVmCXQzl9v8Aa07HNV+SpL?=
 =?iso-8859-1?Q?HseeN1vzHYHRanfHPeDjfM230fynW6HB0nU6jja/w6kJ9ei17Pu3SDFbgO?=
 =?iso-8859-1?Q?JAZL7Vo1hW6wV1dxfWaIVbCLsoXC9Yu4sVIhrtMEuD+tE3/fdG+SBZy0zL?=
 =?iso-8859-1?Q?vNKDeEeISKiDBJrTrD+7+CKkpruVian7GKphxqYbPiutpdnem70oejf6F6?=
 =?iso-8859-1?Q?ceYCyr7zqTZ/IWCPfv5ljbAXn5yd3gb+beQcg71wBV9o4fX+WxT11xBI1N?=
 =?iso-8859-1?Q?J+qqipVbWueNdBI2mQQR4D7Db0utIa4jFDxiddc9Y0Wl55dJ93BtOj/Oc2?=
 =?iso-8859-1?Q?7t2kweHSPIhxVn11ZAuT6cOWyF1pb6QiCxpbLOZkvjwpvKT9diKlZXMo+n?=
 =?iso-8859-1?Q?t0cUYHN4fS1PPiNSBxk+1frEvp8JuJIrgIBKQwfZM/NszxgpTY2H7M6AYs?=
 =?iso-8859-1?Q?7NCAveMGIJ7Z7ClLdiaee6NSr9tRRkpYgVqyx//CDcrnWeS6GCimZz9XL4?=
 =?iso-8859-1?Q?R1RbYrwPCGLNFUudYIpZaD/zyRonaZBNgTNAnaWbDHPMEA7SpYOoy7dN8m?=
 =?iso-8859-1?Q?6yhSaZIp1PxxdGTi1aG5LDKLcS5rrdJo2/JeHZCvf+RVQutHSQCm8rW3eI?=
 =?iso-8859-1?Q?QE/ShtOyzjwCvRtJiYIizUaRDjw4r9dmhfWOW4kBQ6ZRkKPPFDaE0+bFpx?=
 =?iso-8859-1?Q?AHaHY11Mqjw6wU39wAqcU6AReDYdn2B69xxaBXn7IBHCF9Ov06PH3Uszxj?=
 =?iso-8859-1?Q?GW8Gfq+WZN3ci5gx7OHqQymGlA3ChO4=3D?=
X-Exchange-RoutingPolicyChecked: Uz39n5xfOWcHJCk5Pa/0IuP+lswHOABbixsTGOsCeQXnNbKZ2ulM7BGP1UvIW+2I/ychsfqjxiZix8AIHNRltfOY8uj86Bjc8Vw/h8aPFiAnid06ikezs8aN2NBnTemH6NNAPM9bMm+7k4NpuZwf8GZC7eocDbp4ne5zqwEX8/6PJcZTa2tywK0yXzHAqv+2/5jz5hY47Mtok8vZrK/ymEji55+EQioTmXeJbwxSlL0SnBCTIN7XofA+y+3wGl734moE8D0exO5fJdAFXstnfk5EyOw/WbBqwQsbYadbPE2v53+rpCNM/jDIjWANzJ8Sdv1nm5RKnpaSwju59hrmXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d0f23c-bb11-4e2b-62f6-08de85af7972
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:03:03.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVuzKY8qyfnY/6gVNtwPqae7Hz5XnUSU1t3cLVhra0yyT06oz1d/FScwq8j4XyoOAIIvRvN5aO/KM7KBga2dgQGOt45CMSE4W257uj9kVVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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

On Thu, Mar 19, 2026 at 11:55:11AM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 19 March 2026 10.41
> > 
> > On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Brørup wrote:
> > > The descriptions for the mempool creation functions contained advice
> > for
> > > choosing the optimum (in terms of memory usage) number of elements
> > and
> > > cache size.
> > > The advice was based on implementation details, which was changed
> > long
> > > ago, making the advice completely irrelevant.
> > >
> > 
> > The comment is still correct in most cases, since the default backing
> > storage remains an rte_ring. If passing a power-of-2 size to mempool
> > create
> > one will get a backing rte_ring store which is twice as large as
> > requested,
> > leading to lots of ring slots being wasted. For example, for a pool
> > with
> > 16k elements, the actual ring size allocated will be 32k, leading to
> > wasting 128k of RAM, and also potentially cache too. The latter will
> > occur
> > because of the nature of the ring to iterate through all mempool/ring
> > entries, meaning that even if only 16k of the 32k slots will ever be
> > used,
> > all 32k slots will be passed through the cpu cache if it works on the
> > mempool directly and not just from the per-core cache.
> 
> You are right about the waste of memory in the ring driver. And good point about the CPU cache!
> 
> However, only pointer entries (8 byte each) are being wasted, not object entries (which are much larger). This is not 100 % clear from the advice.
> 
> Furthermore, with 16k mbufs of 2368 byte each, the mempool itself consumes 37 MB worth of memory, so do we really care about wasting 128 KB?
> 
> IMHO, removing the advice improves the quality of the documentation.
> I don't think a detail about saving 0.3 % of the memory used by the mempool should be presented so prominently in the documentation.
> 

Ok, point taken. It would actually be the cache wastage that would worry me
more, but again the cache use from the extra ring space is probably small
compared to that from the buffers if we are cycling through the whole
mempool.

/Bruce

