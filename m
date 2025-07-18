Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A9C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EA3402DB;
	Fri, 18 Jul 2025 17:19:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id AB02F40144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752851969; x=1784387969;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ziarlb2Vj8wuW5IGuFB2RygH6zsTBKLTBx4m6I1AsVc=;
 b=PUTk+HuJH+XvogYvOaY19+FPnxY5apIiIN/5i82hqTXuuFBsBEvdpRAU
 WGm//XxZJlvZRbP28qjmx64ectoOPKY8twciu2BNflzvzJzyWnvOTW04O
 8chFEkOp6ZW2X2O8MpzCdjmrg4iMSHWDT7mEWi5rTdqukU4PdCUx+1w3b
 EdWsw6k7W7T+dP/und3POGUR5RjoTQ7w3MgxcUu9pWceLGfX7QM0daRNL
 yX8h2U0mzpjlgLZXLDvQrobYfJYO6uyohY/N3T/ypdADNE34/uGwHFHkT
 YdTkSyHdaF1TgVowSZyWXC8nLcj+8w0js8X3SqjlZmPhaNkqgMHwCCI36 w==;
X-CSE-ConnectionGUID: a4xUoJhoTT2SBr9dsKR1Hw==
X-CSE-MsgGUID: EyaGUTDhSVOXQqYU5DrNEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72715699"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72715699"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 08:19:28 -0700
X-CSE-ConnectionGUID: 71EMTKysQ3GikzVegeLzfQ==
X-CSE-MsgGUID: Iswv46R0SfKUKIE42meMYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="163605914"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 08:19:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:19:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 08:19:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkCNblNJ+gCtoR9Nc9ismfN6j60Nq5FOU2ZxG4JfmM1q9+QjUogLvl2EmGEZnZ/3ZPqbHyjUtXNIfEt0T3/AzjUJMAUwbwUbJKlR4X1OuteO5vDalwRmcarWtSanedMzX/Dzii0uIzwOfJeinFsId560gyyOAXqj/7BlR3USauyULnkP7aqyL9bMEg0oa8EfOtyHTK4O++ER/H2+2GDWc6pUXDjWPPzIIMDA8tO/whMjjuW8ezn1U3jToeNyFja2W3j9juyaCaFUn5iPH2cWvaAjm74+1IlJZvRNPAq2xNJYZlmNMC8Q8A2osPeHNQkGdnTUqEcztYqwe6BZSekXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEC5dWbucBS33v6svX1Wvu+Mtcs5xCpYT9ost8l7thA=;
 b=g5MaBlq34bdItbotYcC6MOs4CmfQIr8KkhXKH+ulwcs+zWAPGbxSBRrCvF1c4kITt6slfK46DlZhWddcAiADosXU8/810eW50s18lrciURuH6R9XLB/rKf6F1qfJwtSZeguRSJXf9DGKwnhac6g3E4AmTArYs4AsC0LLw13k6mc3tFEFQQglUIkEQ5EGC2ABBQW89yhnUEjh2NektVvjQ3rHUVvDINZczYevEJL9o6OWIsUi5Tkrj9yC2t6cbRw5SK6IekHrrAB41hiE1mdAroMW7PkbBCg1TWCKbrLDeuHCzz85SB2JpZU+onEkO7D0xqLMdaBkSeBxdc3dwKQjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 15:19:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:19:10 +0000
Date: Fri, 18 Jul 2025 16:19:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: deprecate some SSE paths
Message-ID: <aHpl6L51T1in1wPW@bricha3-mobl1.ger.corp.intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
 <0c964d09-7b83-4367-b6cf-6cc05bd64967@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c964d09-7b83-4367-b6cf-6cc05bd64967@redhat.com>
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f5ad90-6ffa-4092-48eb-08ddc60e71f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I/s/5qFhY5523OiQc74WpyyI9uB1TNOhnM+qrFrZPhBfBqZqUf/2KkMLhh+h?=
 =?us-ascii?Q?5d9oahQxW04AgMVi/RF+PhL9MQqMjrCYOfxOQLP8Agi9g2eY6vrU1AtI9jQv?=
 =?us-ascii?Q?dYl1nF6Q2eIZGHPzER5zh+Ulqei/iFuKw5aTZvm5zn3SnCagnI985HRZG+0k?=
 =?us-ascii?Q?7w+3RNTbw/F3Bbov9lI1oKCTwZ9T49V4t3bx88IE0dU00BUuVR23dmmRQkiv?=
 =?us-ascii?Q?8vYTMg+1g/V5yAeIzaMonr+zW43G3ujNShxctSchJak1exNS1RJcr8GAae/u?=
 =?us-ascii?Q?80n1ggIUbIQMgUiKtxtTZyZh5e7HAM/4fwM8u/aZw3NI2M1BK3gmGem25ShD?=
 =?us-ascii?Q?+8BUciWZPBxzP7Oh2elj/jDRRH9YmkRlAgf243kj06301YjP0Z2e37YaTtbb?=
 =?us-ascii?Q?tTRP2ht/Ix2/Qo6c4eLc+cfzy7PittEsNi5y2IFV1g0rMMNoYnE0kJ/S5KOT?=
 =?us-ascii?Q?ZyHfV7nK2YSEzjQYvRdaYcX/tCrHjOUmYnDR2y1sNy6TPrWBd4ywm2ZrJvg/?=
 =?us-ascii?Q?VYhseJSBEVwRoK7Q8wEsGPzFALBSDJhtGhDnlp0wtj/ABVIGmc2rqrppOxbr?=
 =?us-ascii?Q?QdTuDbAgRTG9pjXN56iAiQWPxASOp5IxO8urbXWTKB+9XrDtE4P+IueI6t06?=
 =?us-ascii?Q?kQX6ScPJ2o+1zNBlVzqaY8LRpUcSrYpxAeHw8jbJtzjTvmI5EB6o5bEPnjn4?=
 =?us-ascii?Q?kKd/KpTaMwrYSqDx9g69qZeBwsOw5CISbjcmVY1YikokuR/MEuS4D9rYIj8R?=
 =?us-ascii?Q?sDI783n+ZSlqkwQT24eelBh195m50zNK/niKdbXA4qvLIhH50vGgWewB5vGQ?=
 =?us-ascii?Q?1gXrUrpSA+iXWhVDJ0wQlzECPptKNoihhaIMSlWbTaxkSBovSG0huOGXX3X4?=
 =?us-ascii?Q?0kUzR9jqA33cGzvHs14uxkMxNzyr62Kqfm/4LiB2J5BWOCJ4MZPTMgWkWFE9?=
 =?us-ascii?Q?aqPo1/qGjl9SOE2k/5Xj/uAJJ4AyDJd/MTm1YolgCPOuN/Ez0WNEZ0B/lA0A?=
 =?us-ascii?Q?frgDWKTUVocg2OqncK/Jw5cPspq6a593/2G+uhnAtZArG+kLkTDlQl43f6vB?=
 =?us-ascii?Q?0i4dkmLDbCLMxZ4S+dvMdweKhLBOEh42geD3zLZEK/TThXAFdCPonol5mIyc?=
 =?us-ascii?Q?qfqNcsfQenbeFPNCErzshJtKHP3zMoRM8XrlbtehmtyrWDkFrx/in0e+mM7M?=
 =?us-ascii?Q?t40UvCKg9ckPxOhTXjNLqBO/c/NW30sLwbAhfQUGYtGO55yUZ7HrRjwU2Hr6?=
 =?us-ascii?Q?ZkiMbPoa8eorlYv+lWDKTKuu9ySl3QejhI5oJluZHZFysPnrdRfaY5HJ0x1D?=
 =?us-ascii?Q?vg0P652NuPT7yGMO91iOHN9WvcIBzenVONTNVLbDWzLqCO4VlwnxwRNOLlvL?=
 =?us-ascii?Q?ri0QbYFhdFSdv4+px/b0wPNgWketDyU3rl3mp+Rqh8hTPlUgcRG6dpCAotDL?=
 =?us-ascii?Q?ef8J8Z29O94=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hc2poK0hHZOunKxg3BAT/lBdXzSO/XbOEu6wA5dW0b5j+C88daCbg8XI6qAD?=
 =?us-ascii?Q?Pap2kVqEIQ5XvyEWQNB0m5Oeh+kje0UfwsBzImDdYM++LHl/UOM/Ll/fKjx0?=
 =?us-ascii?Q?H9bNQ/RVrHPyMXEhU2TBTQbX/6WGONhnWv22u1vSn31V8Cnq5J7X6oV4sUm4?=
 =?us-ascii?Q?cg/u9OmiXfeS7A1Er/E7zF0YYGatIPxYG1YekhsaOgP6bHLfUuolMQNp5nlg?=
 =?us-ascii?Q?Z3ZfHsGrbF8/5HwG3JnxPLX3q+Foozz0VguqmVh8XfR9xHVKL4TopxebG5U6?=
 =?us-ascii?Q?mGQfi35qHVZ8v+kUELHYvTbPAKllFyODaRHTcZOeUTdSpdSCfTmqMpwgwXtW?=
 =?us-ascii?Q?X9PfbbmDp30Jw83KUnq/S2TVMEQsyxpP3RyZe/RceFoX7R2qMvkCkrYIGlVC?=
 =?us-ascii?Q?QsucfeA8llFxVB1Wa9UvcoL1pKEQerD5uZdi/5behti0TMX8DtC0/+SLxnPx?=
 =?us-ascii?Q?yFIqEKVI4KqzmGIs/RRXT/MGv0lZNDGYtLkeJuKzRjL6rmFsMI0dGF2l/qiC?=
 =?us-ascii?Q?Xi8yM9Xf3sGOue3oxvj2KKdHEkrn+aWJ66M0mDEu9Sb6o2ygaa8xbvR46X9h?=
 =?us-ascii?Q?oKr8C2IbbIqWJLrKzpSXWMoLAWRLtdLAJhHsPvgvUSnvg8oHQLkZmH7nsy+5?=
 =?us-ascii?Q?VoEEIgYezCzjh3A56RjZK/wUXCrVjx/6xmtq1j3oGggFwa8fRe0Xj5EDlfrT?=
 =?us-ascii?Q?d6xX+ty/mPZna4t/HJcqQeeMdcm/24EzT93BGsTxpggxcU2DBNVY4msNz2Kq?=
 =?us-ascii?Q?CJGsI5hpvOo0JNGb+SYd72fpyqAgggcTaIXKXBT/s0gyLf/gjsn2Ao1h9jlZ?=
 =?us-ascii?Q?63aJD3TyuovKpBCxWKYJ0B6o1cqZAdJhzgQOgjomYHMXEjmMPp5Ef5hHX6Bb?=
 =?us-ascii?Q?cl3RUJkjuOpGvrcNw8CVySDdBvHdgMcRwQsJ4PUFiw7utH2eSJJdT8p0NAk6?=
 =?us-ascii?Q?biP+mM73aAWpR0T4AsFHdQUcJX9edKP7fMTQRtEKoA41Yd4BC0u2EfA6HlE9?=
 =?us-ascii?Q?ZmE2kr+ksiZfyBW53A/Ux7DoGWj4dQsUxDG1AFkbxrYiEgIpmYIn2fQaKk/w?=
 =?us-ascii?Q?Bk0JCyp2djHWok7zYuRDMyuvnHxuLCAWsLK/h93x19K7VFiU/nGDxEsag5X2?=
 =?us-ascii?Q?seSZ1qtU8cPDS8GLNbJWMOw0MAF4knLTGxAESiNk4Ie5+KE1ZzxlH1gwYyyg?=
 =?us-ascii?Q?o0J899a0ZwZYO0IBvg40/GUf1YrWMkLyvIyYpXSsv8QqRg/+DkAkobyX8FRP?=
 =?us-ascii?Q?49/howmkmIabwYHETaBtZJQFsHtrJ81wqSfEFqCG0sW6XfRTNjPTSs13RdwE?=
 =?us-ascii?Q?B6N6sinUAWOJUKeQB5CmTWKkCrhuj2kEjBKEwsfgl7oZVOvPJYzN9xJGMCpU?=
 =?us-ascii?Q?+CfeGL5y3izNUz/Xyrk4uU2gypYlLQJwxo6qeOJmesrTLhfmZ7vLSOjdTiPB?=
 =?us-ascii?Q?4B9kqu8oWbZIQQd/Xq32qkqjkcmXi6fyfYq27p/kBW5J315M3K1ecFMtYfgN?=
 =?us-ascii?Q?InYVBA/s9C7Kx6Izjph1LPQltZqe9GNZGuMY9yJG75Y+cIl2rf+jOZOj+oBH?=
 =?us-ascii?Q?RFFQ0aMw++WjRsbwGLvCn7Kv+uA8MnGYoDu5XAS7Tt1Rl76Vjh/k9Se7kdoE?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f5ad90-6ffa-4092-48eb-08ddc60e71f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:19:10.1545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ1Dpr8Vk+O+7uISKvo3DmUDUFXdhNdk82Sc40i548ZaTPCdbOiKX0/M9/HT0U/tB3Qfe//eLcVFn+5qkSurXfL/2xQb/wnLfJx4DdIpjuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
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

On Fri, Jul 18, 2025 at 04:03:17PM +0100, Kevin Traynor wrote:
> On 03/07/2025 15:31, Ciara Loftus wrote:
> > The SSE rx and tx paths will be removed from the i40e, iavf and ice
> > drivers in the 25.11 release. Each of these drivers have faster vector
> > paths (AVX2 and AVX-512) which have feature parity with the soon to be
> > removed SSE paths. In environments where AVX2 or AVX-512 are not
> > supported, the scalar path will still be used, which also has feature
> > parity.
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  doc/guides/rel_notes/deprecation.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> > index e2d4125308..0d020c9c1f 100644
> > --- a/doc/guides/rel_notes/deprecation.rst
> > +++ b/doc/guides/rel_notes/deprecation.rst
> > @@ -80,6 +80,13 @@ Deprecation Notices
> >    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
> >    will be removed in DPDK 25.11.
> >  
> > +* net/intel: drivers that have an SSE vector path alongside other vector paths,
> > +  namely i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11.
> > +  Modern x86 systems all support AVX2, if not AVX-512, so the SSE path is no longer
> > +  widely used. This change will not result in any feature loss, as the fallback
> > +  scalar paths which have feature parity with SSE will be used in the cases where
> > +  the SSE paths would have been used.
> > +
> >  * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
> >    should start with relevant protocol header structure from lib/net/.
> >    The individual protocol header fields and the protocol header struct
> 
> I'm not aware of anyone using hardware that old and relying on SSE, but
> it seems a bit short notice for a patch to remove hardware support.
> 
> Would it hurt much to give it a longer deprecation so anyone who needs
> to prepare by upgrade, or taking 25.11 with support etc. can do that ?
> 
Do we think that will make a difference? After all, dropping the SSE path
won't break DPDK on older hardware, it will only run a bit slower using the
scalar path. Beyond that, it would only affect deployments with new/latest
DPDK on old hardware - obviously old hardware running older DPDK would be
unaffected.

/Bruce
