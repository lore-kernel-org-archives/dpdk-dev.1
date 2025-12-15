Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB8D59D99
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 11:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16ED74026F;
	Mon, 15 Dec 2025 12:47:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9B0BC40151;
 Mon, 15 Dec 2025 12:47:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765799222; x=1797335222;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UrWs12Hhplaqi+IacYk3DXmY8xNZ+i5KWycverlfBRk=;
 b=T1CdB374eSrFDCX0/BS/hRSGPfqSO0DxkLKCf/xjb9N67oAd5ogllIwY
 O3pdGg6V6yta61UfYS4R4lRz9Qf2HL5X7eet1KV7TDHzvmIosPmqhn8Jl
 4YdHckeII15gvYCtIoE43MGLeycCGWwH+Z11TUM2WJitUyG6/cbP1CODw
 nhvMLx1u54mwwaHFmQZfz4gXaRS9tiktmYnmgcGmO6L5b/JUlh8bfo8K2
 E5Eqr49PEqgDq2mpNcNYqyEgiSsjVB/WvlTS6amCT2cQuZMt1vm9XDRct
 ig1GwQLQsCPoCrDXbd67kUY6Gt8FYya8LjLiH0lt1seMKK1cGMwNlihiO g==;
X-CSE-ConnectionGUID: oUUndRx0SSuKsteqrjX5TA==
X-CSE-MsgGUID: GHgliBVySS+MEIr4Lc5u1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="79069712"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79069712"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 03:47:01 -0800
X-CSE-ConnectionGUID: ZFQXx4KIRuCk+Hzh9ey05Q==
X-CSE-MsgGUID: JVTe9HvASDiqo+XPu83Q4w==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 03:47:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 03:47:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 03:47:00 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 03:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4Pu/sBxxbW6iXPHmTmW9AUc3AaD63RjKoeF4QDfGpq/YTqtD6UrgHaaAOsBeGBhQAo5GkFNfifRtauQcoddNBngx+HoT7wgy+p2lGsD4XDJdsVvr2mu2wgl5bIFBQPWaAVNeJ52U7zj55W9n/JVoa0P6eLs4xUKuPM+J/iruSDbxzEIM3fNraFM7HJJHY9b1o1O/EfY6UXrxSXir040H9Qa5nxRgPQfOuBb0qJY8K6pgEVWtYaBkQDl/oNs6K7jZnUkm4N8OPZctkw58mszbLxCnv10dkUVashDohjK1SL5P/k0GPZg5ieopqLQvqb+Z1hnkOzxnR4h5m6FXHELuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4En6UrgNS+3LO0wnAkY941ThWUuCg5m40Mhp2sOJws=;
 b=Es9e5nBgSIF3BWbEGtJ4SGK8kfpXlgAQXwVGGa5DlyYTDALKUP8ZZE8X5h6+qDqoUgsZl9aMo6VuP4lKq3+gOn69HgHU66z/yKFnM/OBq9uoxokl/qKbemNCcBS8zE7ZttnZ+ianaqUwE7nD1OQewlNF/2KOkSKUIc2GouG8C4QTv8qF3XeI/hrrNYooZOng7aBMtxRMZzeuB+DQjf6BCNaB+5jnRm1OWM7prJGRGZlqEmXU+d7VqZVaxLD5E47Xfr5mCYGRvCIsIyuuF619hJdzE8MWSceSgN4ja5QdjHuW/Pt4U8drgylXjUPfIgf8F0A5u1S00NPOidUlHe4wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 11:46:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:46:53 +0000
Date: Mon, 15 Dec 2025 11:46:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea575ee-4221-4932-d2b6-08de3bcfa3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Y68yCJQOw+h7WxUnLcUEc2lnmvXXfOHWUdNSZPfupvKU6d0K5hC1fb2TCE?=
 =?iso-8859-1?Q?waw+LLSyqvJPofdCoci3iK2DTDPQUuSdzH0K5Up441Z/MSihgVxqv9HPQ5?=
 =?iso-8859-1?Q?n3xyY7CxWeI/oVaMe5UnXTvJ7a1+lT/fkKXbKdyoDcKlO5QjAS5qHO+rNp?=
 =?iso-8859-1?Q?8rBRueURNnVr3vL9d44jmXPHhKCox25KNpNPYBldO6rhBcR4fuGJLcRTkb?=
 =?iso-8859-1?Q?o0Wu/qNDDB+LKCHb4uEThcnZgL8LrE7qIZzmHuEe3SfkSFVlDrBdiEOWQY?=
 =?iso-8859-1?Q?Os0OrS8jerpdVBs32BimI4tcfO7eG5neoQ1x7KM/okpfRDLhoQJdvbBwwj?=
 =?iso-8859-1?Q?QSFjs2OhjCUsrtQtL6y9c9VWPlrhm9ngkKHsqs82KvjSEehWLiT5ADKJTE?=
 =?iso-8859-1?Q?yr8TfO9rw6sJpONqq7FO0bLEbUEKzGVBXjchymmO1zOJKGZ9bEdKsBTGne?=
 =?iso-8859-1?Q?D5S/oAgAQ5IoDwQerjLLQTXWIwAw1j9f43MnIB/yY6d1bQH8bILChqLd1n?=
 =?iso-8859-1?Q?6vAf4PKsDifNJQDzjq02BaVZmm+fg5SJBZr3IRNLqKXjDNXHeWXouNeRfi?=
 =?iso-8859-1?Q?tW6kIEjZzgBypFcH3QzXeL3wqMU2aN0Pfmm2eLfJPETT7kEt7WfkL4ikW4?=
 =?iso-8859-1?Q?uVJFXrZrF2n07+RSDgwDNNnTD7tB8i0w7SZUGyNi2JrVxsmEUx+eQwEWNG?=
 =?iso-8859-1?Q?FIVPtZRgR4LLbBjO3ogLqhEnelupBvI3jkxEQumxPKcs84124SHs3TfB9k?=
 =?iso-8859-1?Q?9Y8kQFgIo9bTkwoVvdhdXwszOzw568GRFAUmnrt7pYezXcl+J4muGRcZU3?=
 =?iso-8859-1?Q?QXrU4fPWDQj7R6ZejAL2S0Cg40CZ4uEgrT4s1GZWeMT6TRRYbLuxzTLuym?=
 =?iso-8859-1?Q?Hu2claKspQuYYxYJcjorQ28Q73nBteUBbVq2ttxgBLls32qVk0h2N18an/?=
 =?iso-8859-1?Q?OLehpxVoB7ikPrwWc/pR9BLd5P21xQK+Er2p75h/mDcFrePX1qv10WmCZ9?=
 =?iso-8859-1?Q?eJwTUqKpTXtqxcz1XGvD7oeOtyL0oJQxBsjMakrY3DDtASdOXRAijQepyA?=
 =?iso-8859-1?Q?hsHAbcqKTE2JAZeiTd3zeSRIugWyy7Ed+WnUP/QC8VqzwCTx1lEP2UIrJ0?=
 =?iso-8859-1?Q?1pBHkxdYnfMC/oKYAjxq3EvC7Rbg6mZf1Q7GUOKkfa6iZ93+vkRfrAzcPJ?=
 =?iso-8859-1?Q?+zHsIuLnJ0ATkU5y3mWrsCLfSkoop8HCEb5a2EFlqLDlXpukbeN6cHs6jD?=
 =?iso-8859-1?Q?pxbjyM7exzOgMVmGOnhhnyHo+oLtoUuPgAzofuDsSnvCcS1eeNVJ0Cm1Eg?=
 =?iso-8859-1?Q?InP7ZAT9C82a8kgB4O+n1Dogm6svrEYr8Yp5TFEE0vnz72yILhOGyCw/40?=
 =?iso-8859-1?Q?0sMt7QOz13VJBjVskYIWiwdRzInjPv5TDjs8VpMqRRL3gLCoqdOx43xMSV?=
 =?iso-8859-1?Q?2vtTnQd+FUoS6MZ4bUMnnZm7SWIBBYz4Z6UdBoM2RMa9CbBVtxPYdd0GZ7?=
 =?iso-8859-1?Q?CeBK2EL8p3GhbHsXN9FQkO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1xq9cq96wEoT464C22KrhJF0khymHFZxfj7Csr9Cy5sHDLARD5LVdh2MgG?=
 =?iso-8859-1?Q?nEssGZQKiSDWljaPGj2TOncbxdQo1MDeKfqYaPKaYjJ61KeU5JmOPrqV7T?=
 =?iso-8859-1?Q?JRw+k5zxOJf0pgCc5Am50biA3iI3Wfc/gaa+Lqm9kMVsc8CnJYnObG9fuN?=
 =?iso-8859-1?Q?8BB9Tx+/e3fISDFG+E5Xh3RtydRjLGjTzpfB5zQL3hsx47Zh2GM0i/HtA3?=
 =?iso-8859-1?Q?56ZwOT6tJaA/RnwYshbXvdW3MbTg+tdQiWGYwH7sddEbIIxhO/70NiWcy+?=
 =?iso-8859-1?Q?hAB6hrokJoUVhA+GhhTOBi2LCwu5LvOHhQhKx2TdNy8hAQAkEueZFq9sKg?=
 =?iso-8859-1?Q?1jBeZuknEBfe3XdC8HWw/qqIaJbzPNnPa7F8x3XaB2aFzA8dOGG/qntyIl?=
 =?iso-8859-1?Q?PseD4+5iQ5KlHWlleLjz8Nl3ImIsymcg1jVxMJepJR/b7sDU/NlLgP4Tok?=
 =?iso-8859-1?Q?fja+vI9NJwBjii0W+BXBDbXgm5L8+7VkiAkCP4QkQO/dwec9vIu1hJNki1?=
 =?iso-8859-1?Q?G5HxdMVnRZCGnA7YX0uZI2cy7CDrL4GNDFxMHlp0/X8WONRcYu7tRUqBOs?=
 =?iso-8859-1?Q?UyAnr+7kDtTHh58nYGeWXpB+/SfQKy6sNvqEq8S9o556Ro+xWkcet9e8Ov?=
 =?iso-8859-1?Q?A/ZTKxNx9xkvSSa4ugrv99O1Kel5ZXlD7IB+xkD9bkYTRFW0LDaeZy5I8J?=
 =?iso-8859-1?Q?5YjNd8TIc8usQ85ifavHrvec+dQvt2LqY+4ryE+hLbQpEY++RO7Rx9w0ez?=
 =?iso-8859-1?Q?gqDvY8RRAYyc7xU0pejmOhTFRzSB80VYKS8XPUkpqUOfZpnTQZvAOfOisr?=
 =?iso-8859-1?Q?r2a0FR7GkOUVlHEo2/xHzrgf4mWwVS5lS67pMWszToYEiDAG6mCfAlAxKF?=
 =?iso-8859-1?Q?sT7Ww59aL88BDOs8PnbngTgXi3tcElLLhXDE2cp42puJpwgQGKAIjCT7Tz?=
 =?iso-8859-1?Q?5FsnI8zQb+h6mn+LNc1SKGllMeYQo6OwoMr6DW3i+7R60ZhKuvrHX53zBe?=
 =?iso-8859-1?Q?lcJl+5wv/YQ9VQzbJk9LV8/9ktKrKQH3oON+6h8l2tubxYl+X6o+FOl0pC?=
 =?iso-8859-1?Q?Z1UKFC1Lb+l3+0ghXq873IG98vQDqMpzJG/o07euUzMYO+QUJmOBbEi038?=
 =?iso-8859-1?Q?yN6u9TsVyuFq/vsp5ov+5BNjrFrcS33Wq48ZqRBC21PCjHA186+6xQwg8E?=
 =?iso-8859-1?Q?9H+7SPVcHShRIljSOAx3UXENM5WHdnj43hAlKzLXmiK+RVYUpKEQo7Xchk?=
 =?iso-8859-1?Q?kKKbVjsUwo7NWLTwwk9JhAFR5WKncDqGhu+q/l7Ja5RDQ0BLhP+Lm0+skV?=
 =?iso-8859-1?Q?VnSQ3ayYSmkwzmzV5DOHg6A9aLPUdQxh+bB10y3RftHxo3jVVxMzZU1dsk?=
 =?iso-8859-1?Q?VuEBxzStTekULKOc93T+1IunBvJB8liEPA0GF07arI7PAfMduiuRifuCcg?=
 =?iso-8859-1?Q?qGm4EWMLHMa6zjXB6tD8K2Gu65/pKA6ZLye1uBkZq9r3bCd7euZjY2hxKr?=
 =?iso-8859-1?Q?Yl74p8RYOzdXeOvt6RdGID3R5/A8OhHtBfDZjmNUseoVQfOwDgKSPQzVyV?=
 =?iso-8859-1?Q?B0bt78MEL67+/mnFHuYDbif3tq0AQyHhIhnVSTNwfE14v0nGS0/NXQsXY3?=
 =?iso-8859-1?Q?oroWlw+rnc4I3KZQMcPE971XKlJB3OwiI8nuDNWoc060hoeIENbN9m/w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea575ee-4221-4932-d2b6-08de3bcfa3f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:46:53.0245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVt2WsFhEwcLJcegROX7b5+/EgJ1kSj+Kffms4z29OOtuWxCUSdBV0FX6pUHTD4CBXRQ/XkbOPdBSE81ylxaaUNayeVlob/G9mpA4NCJ4JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
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

On Mon, Dec 15, 2025 at 12:06:38PM +0100, Morten Brørup wrote:
> Executive Summary:
> 
> My analysis shows that the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
> 
> 
> Detailed Analysis:
> 
> The purpose of the mbuf fast-free Tx optimization is to reduce
> rte_pktmbuf_free_seg() to something much simpler in the ethdev drivers, by
> eliminating the code path related to indirect mbufs.
> Optimally, we want to simplify the ethdev driver's function that frees the
> transmitted mbufs, so it can free them directly to their mempool without
> accessing the mbufs themselves.
> 
> If the driver cannot access the mbuf itself, it cannot determine which
> mempool it belongs to.
> We don't want the driver to access every mbuf being freed; but if all
> mbufs of a Tx queue belong to the same mempool, the driver can determine
> which mempool by looking into just one of the mbufs.
> 
> REQUIREMENT 1: The mbufs of a Tx queue must come from the same mempool.
> 
> 
> When an mbuf is freed to its mempool, some of the fields in the mbuf must
> be initialized.
> So, for fast-free, this must be done by the driver's function that
> prepares the Tx descriptor.
> This is a requirement to the driver, not a requirement to the application.
> 
> Now, let's dig into the code for freeing an mbuf.
> Note: For readability purposes, I'll cut out some code and comments
> unrelated to this topic.
> 
> static __rte_always_inline void
> rte_pktmbuf_free_seg(struct rte_mbuf *m)
> {
> 	m = rte_pktmbuf_prefree_seg(m);
> 	if (likely(m != NULL))
> 		rte_mbuf_raw_free(m);
> }
> 
> 
> rte_mbuf_raw_free(m) is simple, so nothing to gain there:
> 
> /**
>  * Put mbuf back into its original mempool.
>  *
>  * The caller must ensure that the mbuf is direct and properly
>  * reinitialized (refcnt=1, next=NULL, nb_segs=1), as done by
>  * rte_pktmbuf_prefree_seg().
>  */
> static __rte_always_inline void
> rte_mbuf_raw_free(struct rte_mbuf *m)
> {
> 	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
> 	rte_mempool_put(m->pool, m);
> }
> 
> Note that the description says that the mbuf must be direct.
> This is not entirely accurate; the mbuf is allowed to use a pinned
> external buffer, if the mbuf holds the only reference to it.
> (Most of the mbuf library functions have this documentation inaccuracy,
> which should be fixed some day.)
> 
> So, the fast-free optimization really comes down to
> rte_pktmbuf_prefree_seg(m), which must not return NULL.
> 
> Let's dig into that.
> 
> /**
>  * Decrease reference counter and unlink a mbuf segment
>  *
>  * This function does the same than a free, except that it does not
>  * return the segment to its pool.
>  * It decreases the reference counter, and if it reaches 0, it is
>  * detached from its parent for an indirect mbuf.
>  *
>  * @return
>  *   - (m) if it is the last reference. It can be recycled or freed.
>  *   - (NULL) if the mbuf still has remaining references on it.
>  */
> static __rte_always_inline struct rte_mbuf *
> rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
> {
> 	bool refcnt_not_one;
> 
> 	refcnt_not_one = unlikely(rte_mbuf_refcnt_read(m) != 1);
> 	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) != 0)
> 		return NULL;
> 
> 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> 		rte_pktmbuf_detach(m);
> 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
> 	}
> 
> 	if (refcnt_not_one)
> 		rte_mbuf_refcnt_set(m, 1);
> 	if (m->nb_segs != 1)
> 		m->nb_segs = 1;
> 	if (m->next != NULL)
> 		m->next = NULL;
> 
> 	return m;
> }
> 
> This function can only succeed (i.e. return non-NULL) when 'refcnt' is 1
> (or reaches 0).
> 
> REQUIREMENT 2: The driver must hold the only reference to the mbuf,
> i.e. 'm->refcnt' must be 1.
> 
> 
> When the function succeeds, it initializes the mbuf fields as required by
> rte_mbuf_raw_free() before returning.
> 
> Now, since the driver has exclusive access to the mbuf, it is free to
> initialize the 'm->next' and 'm->nb_segs' at any time.
> It could do that when preparing the Tx descriptor.
> 
> This is very interesting, because it means that fast-free does not
> prohibit segmented packets!
> (But the driver must have sufficient Tx descriptors for all segments in
> the mbuf.)
> 
> 
> Now, lets dig into rte_pktmbuf_prefree_seg()'s block handling non-direct
> mbufs, i.e. cloned mbufs and mbufs with external buffer:
> 
> 	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> 		rte_pktmbuf_detach(m);
> 		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
> 	}
> 
> Starting with rte_pktmbuf_detach():
> 
> static inline void rte_pktmbuf_detach(struct rte_mbuf *m)
> {
> 	struct rte_mempool *mp = m->pool;
> 	uint32_t mbuf_size, buf_len;
> 	uint16_t priv_size;
> 
> 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> 		/*
> 		 * The mbuf has the external attached buffer,
> 		 * we should check the type of the memory pool where
> 		 * the mbuf was allocated from to detect the pinned
> 		 * external buffer.
> 		 */
> 		uint32_t flags = rte_pktmbuf_priv_flags(mp);
> 
> 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) {
> 			/*
> 			 * The pinned external buffer should not be
> 			 * detached from its backing mbuf, just exit.
> 			 */
> 			return;
> 		}
> 		__rte_pktmbuf_free_extbuf(m);
> 	} else {
> 		__rte_pktmbuf_free_direct(m);
> 	}
> 	priv_size = rte_pktmbuf_priv_size(mp);
> 	mbuf_size = (uint32_t)(sizeof(struct rte_mbuf) + priv_size);
> 	buf_len = rte_pktmbuf_data_room_size(mp);
> 
> 	m->priv_size = priv_size;
> 	m->buf_addr = (char *)m + mbuf_size;
> 	rte_mbuf_iova_set(m, rte_mempool_virt2iova(m) + mbuf_size);
> 	m->buf_len = (uint16_t)buf_len;
> 	rte_pktmbuf_reset_headroom(m);
> 	m->data_len = 0;
> 	m->ol_flags = 0;
> }
> 
> The only quick and simple code path through this function is when the mbuf
> uses a pinned external buffer:
> 	if (RTE_MBUF_HAS_EXTBUF(m)) {
> 		uint32_t flags = rte_pktmbuf_priv_flags(mp);
> 		if (flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF)
> 			return;
> 
> REQUIREMENT 3: The mbuf must not be cloned or use a non-pinned external buffer.
> 
> 
> Continuing with the next part of rte_pktmbuf_prefree_seg()'s block:
>  		if (RTE_MBUF_HAS_EXTBUF(m) &&
> 				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> 				__rte_pktmbuf_pinned_extbuf_decref(m))
> 			return NULL;
> 
> Continuing with the next part of the block in rte_pktmbuf_prefree_seg():
> 
> /**
>  * @internal Handle the packet mbufs with attached pinned external buffer
>  * on the mbuf freeing:
>  *
>  *  - return zero if reference counter in shinfo is one. It means there is
>  *  no more reference to this pinned buffer and mbuf can be returned to
>  *  the pool
>  *
>  *  - otherwise (if reference counter is not one), decrement reference
>  *  counter and return non-zero value to prevent freeing the backing mbuf.
>  *
>  * Returns non zero if mbuf should not be freed.
>  */
> static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
> {
> 	struct rte_mbuf_ext_shared_info *shinfo;
> 
> 	/* Clear flags, mbuf is being freed. */
> 	m->ol_flags = RTE_MBUF_F_EXTERNAL;
> 	shinfo = m->shinfo;
> 
> 	/* Optimize for performance - do not dec/reinit */
> 	if (likely(rte_mbuf_ext_refcnt_read(shinfo) == 1))
> 		return 0;
> 
> 	/*
> 	 * Direct usage of add primitive to avoid
> 	 * duplication of comparing with one.
> 	 */
> 	if (likely(rte_atomic_fetch_add_explicit(&shinfo->refcnt, -1,
> 				     rte_memory_order_acq_rel) - 1))
> 		return 1;
> 
> 	/* Reinitialize counter before mbuf freeing. */
> 	rte_mbuf_ext_refcnt_set(shinfo, 1);
> 	return 0;
> }
> 
> Essentially, if the mbuf does use a pinned external buffer,
> rte_pktmbuf_prefree_seg() only succeeds if that pinned external buffer is
> only referred to by the mbuf.
> 
> REQUIREMENT 4: If the mbuf uses a pinned external buffer, the mbuf must
> hold the only reference to that pinned external buffer, i.e. in that case,
> 'm->shinfo->refcnt' must be 1.
> 
> 
> Please review.
> 
> If I'm not mistaken, the mbuf library is not a barrier for fast-freeing
> segmented packet mbufs, and thus fast-free of jumbo frames is possible.
> 
> We need a driver developer to confirm that my suggested approach -
> resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> preparing the Tx descriptor - is viable.
> 
Excellent analysis, Morten. If I get a chance some time this release cycle,
I will try implementing this change in our drivers, see if any difference
is made.

/Bruce
