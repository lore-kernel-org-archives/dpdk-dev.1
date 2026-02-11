Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941CE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E31AB4026A;
	Wed, 11 Feb 2026 15:19:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3EFB440268
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819584; x=1802355584;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q4d7mjjQPPCidGm+ijw6FEIcThmKrO7hPgjCqebBaRI=;
 b=YTK4klTh75uciMuDZy2XdRfyLQRJfC6INHsfL7ciaFjEJKFpradBcE5w
 4l3Vmyn0JQQnUOLP7X613pOlLEEb+eK2hrsAZaCzzity2mZR0ANswUVqe
 gDzg8AfwiY9Mmkd5fql2ZEW1Jpe8LaZtu+1chGomF9/sbKfjWGejTtleU
 e2RMuIPeIHf8EMYLHFy5X0Wdwo1aFsjX1oFVGCOf8pI9w8Ep1YVZOYgHa
 tZXeUlaVmnl0pTTn80KWE/QQlGpLsuo/Tb/Jdc+IAxenzDFHKHUrDkWEm
 2pp6SNoy4Zju/k5nyp3/2qEkRiC4wDiatqvHci+V6lEBy+VR8ayzYYHPp Q==;
X-CSE-ConnectionGUID: aKeT0PSZQ3Cw/5aOci+C6Q==
X-CSE-MsgGUID: XlemNK59SiKSahmoMNVSww==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72063850"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72063850"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:19:43 -0800
X-CSE-ConnectionGUID: 1ElPbSp6TPO0Ids2U8fgnQ==
X-CSE-MsgGUID: KY8l1zm/QRmBayNk8luVKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216772669"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:19:43 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:19:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 06:19:42 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:19:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmsUiRx/P0nQse3MPWzhVT4ZWRPZ1SUKEr/841/bQDf4Rvwjq/vmbKaxsxxgPJKtqAQKNOzOML3+xQiT9xLTzPpMoWJLCRFoonLWgngzb3GlZeR9lyVfBVfs2ok5+7Ow6HH1BwAesv0WJVMS50tcUpEG/I/AX9cyHIlZxJBhLdnwSTFEyVLIR+um+6jqA6JfOnZE8v0lPqLZizxS2kInwww0Vx0XhOGrZ/szgkpqmRTkWHlYoXimtdXj+dREqjMhDnPp7r+XF469kyAekUgBdxVp4Kz+aY7X78hYvb6v99tQlU4Km57qg1xLWvDL/mChPj0Njl4GOuJI7USMlhtoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLGO5r0hJi3MzYNA8u5U3ZC9igOeNHg6oKbuBCrNOko=;
 b=mGrvlpVV880KRVDuuG0EOCeIzun//boTv8ucL4vKcetLmAQJUd9c1IOjIxuRcGYwqQdcjfZtZyZyimq3Ff66pUAyOdDejDnGyYiErrQOH/bJjkQXFLrOe4sbDN6tSXRr18G2AL+jEQtP7zMI4AulSmGIWz1NFfuHFOVUBV3TQH2Nhy1alwwJ81E7FQVszjoL8/SJ20xdufnbAHcskVMdOXPkgGu64YrOMn3EXaS+LXyaXTCiyDIKXCRE+KgR8va0yeR4N5Aaje3/aUZ6lj/FzAoCcM/UaSPoEgZzApqn/SmtNzcj0i+tKOfH7rUuRcrZHfI6hEFyE2IFBIzKFb70IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:19:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:19:39 +0000
Date: Wed, 11 Feb 2026 14:19:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 14/35] net/intel: support configurable VLAN tag
 insertion on Tx
Message-ID: <aYyP9dj5sFT_hAAr@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-15-bruce.richardson@intel.com>
 <6d8f5c9d-c014-4763-bff0-215b43656b9d@intel.com>
 <aYt20BirTtIdIutY@bricha3-mobl1.ger.corp.intel.com>
 <6ac617d4-7e22-463b-b4a6-3d93961edc95@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ac617d4-7e22-463b-b4a6-3d93961edc95@intel.com>
X-ClientProxiedBy: DU6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8798af-70b1-4af5-5b35-08de69789779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WsIPXCQEHhiQypTzUg0BiMNS6GqpZeB7nTKwUrjXhZ/O3hnNwMKxNbCWHd8T?=
 =?us-ascii?Q?BUdtvEbpepaovldNdjvck4K5BRsdJkfEOwZuA42L98rVHyPpyNk78JAudgph?=
 =?us-ascii?Q?gT+JH25lUgHCR0BgWbHn3l4Oek1RbtuobrSfkz8kyRM+HdNX9MZh33WH5jd/?=
 =?us-ascii?Q?tZipdBfqOFToqMnTgV4dBjv1XPK+UW7Nj57vNpic3x/pVE/yFNyqiMyaaw7x?=
 =?us-ascii?Q?QOHcvkCbd5h2veTu7MHT8caaWWqYJrc0Efb501poy6SfEkWFrZKsYP7rZY6i?=
 =?us-ascii?Q?V1+wRptf5CPAbXoRfaoxYFSvVE7n57dT5SClcxeLnNAP3cZAGi3jj4iE0J4H?=
 =?us-ascii?Q?gB7L3LrEIwCaVsWfnymQY+6zzID2h3KNYdFuRXz1ZvdQwhEXZR0pLaQBhVSL?=
 =?us-ascii?Q?Kbd+WJ/IyCMl79oCB+FXaOMGby95CRRjOKisFLLmnLkiHv/uDYQ1m8niARgt?=
 =?us-ascii?Q?u7O9TcKeeeatUEdax6+LH9dlBfR2Z4XJdA6fiOkWo0pbzNyjJjU/WMH4QA7p?=
 =?us-ascii?Q?0J++mmqvMw3DDnOqxfEuqelU8co+ffUis24W9n90Csert6co4LbPXfdZ6uFa?=
 =?us-ascii?Q?B4g3cdSFotOH/AhnspTGHkhakgBRpNyyvz6T6jX5efCLOaecOz6aUCjnIspK?=
 =?us-ascii?Q?l13UDyL83HCnigJVMnWi3IUe/pUr/c9i+Jn/SaHPi3FxCeT5OHny7gWtApz6?=
 =?us-ascii?Q?5WhCYf/2/lGuxXKzf7L55gGaaRRnkq361S2zoOQgn5422A0X89GWPqURSgnT?=
 =?us-ascii?Q?GpXP4ikVD5Z2BtOa2ggtRMBZVwGang/vsnl3pcp7Qm7zNl5rSG1mW9g9Xa4I?=
 =?us-ascii?Q?fSDkOsqrf6QFnX6p5CgSJsUQjKwW6QyQhZHMEBqoOWwtzpVYS8rb8bTgCud7?=
 =?us-ascii?Q?SKzsAO/TEw4UU4gok02aezpHjQNM8nC30y82nqUP9ZvRFGYHGCgljumVcXRG?=
 =?us-ascii?Q?cH07vq/MWUN1um6W/+RoGfAcKeBsz6RhtArgp6pbq+jKfAVhFhllH0N3fOXd?=
 =?us-ascii?Q?Q8Q0u1PvgXfhEpf7SFgHfJGCb/bvTPSGfrJS6qgeutzvezMFJqFYdp/6+zDZ?=
 =?us-ascii?Q?48gGchASt158GtAs1mhbZp8XBJ6yDzZsGU7gZWlpILB+3K5SCR+leX7/xCve?=
 =?us-ascii?Q?jwIm3lpwIoY0xs4twKR0MJvzKWfPM3RlLvZ/TYk+gC8FwnWBdZYqPY1zAkR6?=
 =?us-ascii?Q?sKz+xeDQRcktlcyAiZYWJJDscksVrastpHyOsgVu9RvO4kNOIiqAYM2agW0a?=
 =?us-ascii?Q?lGaRuo2H5be37BFANnnW2Bi7B/bV9Wg25HZVSBUYMzSFjy+UScQxF+V8enQo?=
 =?us-ascii?Q?alA4BaCn1nzgWGE0ZeYhzmdvb29oCiVxasJ8h6uxwdDLxaNTffT60kkf8FNq?=
 =?us-ascii?Q?LgHuWg3tqbjZVVe1qdU0vvz1I4XbuJ1bxWalCc/WsdnJDxf5CLaXMWjqQgSH?=
 =?us-ascii?Q?ceLrsFdUv4RlFE5JAmTz+tUANwJgomQ+q2iB7X6WjccMq8ez3tOZB+ZNWQM0?=
 =?us-ascii?Q?z+WgfcoEDzlqxyiAQ+efRqG0GeuoR1CWOLQvLrDBSOu25DEetx4Qk7Kt2v9B?=
 =?us-ascii?Q?yl85S0t7oXTLwdOCAp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOoft40RbSsnwTyk1O0pYWgZ9mPxRF3HV12xEAR2juNls285Hz7Wc8PRzmWs?=
 =?us-ascii?Q?Du2fu/Ln9j1zWC43b1m0l9dtzx3nIDnSbwp/EM25IcEcH9sXzuU+x6gWezR8?=
 =?us-ascii?Q?NH7B7g+/69q/jXjPXlNmUuPt0HqaivhyT1S/A2WV7MV59+rXR/Q/t+Q3+DhE?=
 =?us-ascii?Q?THEPuETAg5FdL5FFVpjK10G+8yhBsjgUa49ownxL1MZ0yt0vUIcxPcehyRli?=
 =?us-ascii?Q?DQoFHL3nSEV8aH5MMnVozOocnAi2JWYhO2UbtpgVGP2sNfHfQk+F17/BSbGm?=
 =?us-ascii?Q?t8p7x7Y5oMGXJxsiNDrT+R8+AdIaSaxg/xWSe2LxT+hgNVKH1W2Q1ni9JeKB?=
 =?us-ascii?Q?GWPgCEsyiiBiETTJUgsc20V9Ldd3F2Lvo/PfIOzKYZbM3X6CI3uCw7/Lv23Q?=
 =?us-ascii?Q?Ln5uvLm5b7dXozw+bh4sao1vnbORayWuNIH/2oLolMirvEWYK/nIMmbvgWCS?=
 =?us-ascii?Q?/D6sBwa3s8eCzHuLsnoDA/+scjJ7V3XzcqCJBWMvoWACD7f5aQDASAIZrft3?=
 =?us-ascii?Q?ZJNhr/5PAGgSJuANUCtF47WtS+x81rx4Avuy1pYxTUm6Y23r2/qKXAhRPV3E?=
 =?us-ascii?Q?GO0jDnMM6kVswUHNmfKhXDdNERXK5ZIZ0anxvgNaxkOwb8Vt0yxpO7WNqtu1?=
 =?us-ascii?Q?PMxNGiQa0Spa+JjMRWe799SJ/T5AAdXFl8/+GK7h4YBoTn1qyjvnUVX6izfv?=
 =?us-ascii?Q?WkjwcTSdVteVR1Hjh87T2UyW37x8jas9vlia4UUrPPOLwbfkXK+Pfg/tEDwW?=
 =?us-ascii?Q?nlS3/Vsf+pdtO8ygbOtpAAK49G/IYzlqOTgh0qyNucDQm2zLYVnnGoP1H5RE?=
 =?us-ascii?Q?URPBbKsL6AabLhS2CSqrO/gfCWGR8SEzgkX6/0lPN6D2jLhpQ3B89AXgjVzq?=
 =?us-ascii?Q?y4KhW3nJJNehSzK2xYBLw3CGB2PxGItiv5TP1u39UdVdgWg6V4uh3jykjZ8G?=
 =?us-ascii?Q?AA15KTvuIsfSItHf84DCutzIW+g9fbjpeASZzYfZjWfX74mDf9QaVZyAySZB?=
 =?us-ascii?Q?ydKTpcRGr61xNnQf4PDza8p7eYjqcUNfv9+gDQ3BkvQNFinJtjCM49DDL217?=
 =?us-ascii?Q?a1Y0U39AyjzSRPNbybWhlqpak4EWlJupnaurZnU068mJDG+My4OS8hYm0Cjv?=
 =?us-ascii?Q?0Rm2aTAoDjda4rDS3T36+p+QRv1Z8OJI6hoZ7M66Kk4jihXAdQBS9+HDYaUy?=
 =?us-ascii?Q?6+Gp1R5MD13io3iKHWHq7DHOCZM5Azad/QsYEVhKET7rtyjOJXkC2lNsQnlE?=
 =?us-ascii?Q?P4GRzU4X4hm8vf1itzT+nR0SL46E1H5GDSF7dJqneiKLIPOcQ/JgF9vxu6ET?=
 =?us-ascii?Q?2vITUynZqQOv4HOMvRHSnYZqTjfKc875WH44AawEb9t70actLrSv+h+sjshB?=
 =?us-ascii?Q?SQ0VaFTv9bsejb/ATIHNgLQ/WrS7B5zpq7p3nK9EQinaiiNpZrDSbeqQfOm5?=
 =?us-ascii?Q?h8L+SKMi1h514RVeWw7rEmgJNCC8KngYn7D0yGztx7WWRwPttRGUqpRFaKS0?=
 =?us-ascii?Q?OZu06+r+pmsRZ835nY963g8qltPTOplxPec4jKszsQo5m0GwIOSgmG/2A+HO?=
 =?us-ascii?Q?EVXAeHT46YgZmfTMut1unqQxO/AJQqjHHESds/hbWsENXIGjbcs5BQBE7AKg?=
 =?us-ascii?Q?QGhDPsV6WwlFu1clGQU8lMyV05V/DH5bWExQmvxgCWQ/h1pBBJOYEqd+NUPc?=
 =?us-ascii?Q?pVuAYbxvpHw5tltFg3pH2QKfnjjnbxEuZVe821AA+xzbsw1iwB5CAf6+K1l1?=
 =?us-ascii?Q?N1Zli9pjswJFaOi76Rrm3N1J05hAWPw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8798af-70b1-4af5-5b35-08de69789779
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:19:39.2792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLpCfW1vtHJYbQNJQZ0z0z9owLynSmCrtg92UIznWRIyY3Isc0NlQ4JGm4/qcVsKiUd/tnmHTrop594mmBrR59NJaXlTsp7exthQXIyV+h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
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

On Wed, Feb 11, 2026 at 10:29:17AM +0100, Burakov, Anatoly wrote:
> On 2/10/2026 7:20 PM, Bruce Richardson wrote:
> > On Tue, Feb 10, 2026 at 02:21:49PM +0100, Burakov, Anatoly wrote:
> > > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > > Make the VLAN tag insertion logic configurable in the common code, as to
> > > > where inner/outer tags get placed.
> > > > 
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > 
> > > Hi Bruce,
> > > I might be missing something obvious, but...
> > > 
> > > > -		/* Descriptor based VLAN insertion */
> > > > -		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
> > > > +		/* Descriptor based VLAN/QinQ insertion */
> > > > +		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
> > > > +		 * for qinq offload, we always put inner tag in L2Tag1
> > > > +		 */
> > > > +		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
> > > > +				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
> > > >    			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
> > > >    			td_tag = tx_pkt->vlan_tci;
> > > >    		}
> > > 
> > > I can see that we insert VLAN tag on TX_VLAN and VLAN_IN_TAG1. But then...
> > > 
> > > 
> > > > @@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> > > >    	/* TX context descriptor based double VLAN insert */
> > > >    	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> > > >    		cd_l2tag2 = tx_pkt->vlan_tci_outer;
> > > > -		cd_type_cmd_tso_mss |=
> > > > -				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
> > > > +		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
> > > 
> > > this logic is only triggered for QinQ. Meaning, there's nowhere we insert
> > > VLAN tag on TX_VLAN and VLAN_IN_TAG2?
> > > 
> > For VLAN_IN_L2TAG2 the vlan tag goes in the context descriptor, and
> > creating the context descriptor is the responsibility of each individual
> > driver. The two drivers using this common path, i40e and ice both put the
> > tag in the TAG1 slot, so don't have a path to add it to the TAG2 slot. We
> > make it configurable in this patch so that in the next patches we can add
> > in support for the iavf driver - which does support putting the VLAN tag in
> > the Tag2 slot, in it's context descriptor function.
> > 
> > /Bruce
> 
> Perhaps we need to document that more explicitly then, and double-check that
> all driver paths actually do this in all required cases (i.e. not just for
> QinQ but also for regular VLAN insertion case).
> 
 There's already a comment at the top of the enum definition, but I've also
expanded out the documentation on the L2TAG2 value to clarify that drivers
need to set the value themselves rather than relying on the common Tx code.

/Bruce
