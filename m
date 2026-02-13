Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F946EF48E8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:50:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EBC0402B2;
	Fri, 13 Feb 2026 09:50:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B9275402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770972656; x=1802508656;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lXCNKV3l2GIw4YWeYNFDb/xfWkEyKyO8RqWhGYP1+CE=;
 b=oFV0IczRNDqFTpnQIS2fWPa77gZwKiOZXy7Gb2Wt/yxoJjRQT8epInjy
 oxcXJpbtpae2WLVatCr31UjOhtuzHFFwAbcPEBAQj0nmpMJQLZCaoDQ8R
 PLiPb8r5K6aQF/xNVe0DSWxdZuVnqM1p4URrtUBC1CkShIawmp5Vhhkl4
 +lLNgFExMkzinZ7xpImBqJ+SdOuoUFepPBUhYaDgiTJp/tTNoMQBleR9M
 BPooTsTf4+z89k2ISs9ZoY2eJGbQZ+S9rg5J4G0ADfnsLDAnvJf+M3vjB
 sYAzYc2fC3CYmXiyhxKoxRm4E+kEFZ06c9HnVsyPk4vvI0bZfGuaTHd+C Q==;
X-CSE-ConnectionGUID: HePTW4z+TvCIj7gwK4IUdw==
X-CSE-MsgGUID: cdTlVAbWQ+mSxkkuI//teQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71869133"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="71869133"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:50:55 -0800
X-CSE-ConnectionGUID: poIPT3ulRqiM6eeLoQDJdA==
X-CSE-MsgGUID: GHO3A8FCTt2JP2KWKvrNSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217007527"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:50:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:50:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 00:50:54 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:50:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRdrr8yI990g0L3Mxy9ofeJ0WHudSINxISUdjqM7Fv+gOMADD5sxkGdvEMF6C8kSrkRppTUKIWwBO4oiUXNfFvrsntojBaRNUDQgft5Ks/jRar7IPQwexRx19mYLrwBYVL0HIhRGeDupPiVKdITl1cI6wz9D6IgBg5DxtPdyrgV5g8ZFyxgcOAuxDRe9BUUqKqeGeHYVwiwJJtw4SyUXkNUaJUOYPqwdfOGp3dWpeT6+Z2AJLXpSC7uQ8TKzEC3ncSn93y0fPjk6gZI6jm5+LILyY5FtVApdSD0XzwFFMlCQSobse1beJt7TMZzupSYyFyurLE8dwbpNaRsG5p843A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ItnXpCd47ZfJMVkTo5yJSkB7B49NsbdEhP2M2UeD0w=;
 b=jVdN0njVa5ZefPn6XF98KxBomE9YoIuN4BC0fvgLoBu2T8KYWyo610RAc0MI/Sqc/YBwbDTKZtyuKwq1bSk5IjTAJxR0yP0zFYO38Trhb5D12+2vLtrRNHbxj+6/p5WojrBm8QqZjX6XdNWA3nMA2QpYblprq4MXv7FsDiaiFlDd0T5FHxi/RpWCivZaQ2qWZ7gaI8FPQ6qDo+6Z3z6uMB31MqO3Lk3Zild+pLSJ729mPj9Wkh8RcHOtcRRWvZgYD3vP4UCevg+x5DN5akUpC1TUao1Lv1UHEXmMmGzWw3UbPFbkyqja7KJJ8QhwGxJBofSjzusF6BDiPXxh4uuQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFD25B21260.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::856) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 08:50:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:50:51 +0000
Date: Fri, 13 Feb 2026 08:50:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Subject: Re: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
Message-ID: <aY7l5korgdyG4qcd@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
 <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
 <6cdb4c37-0e01-42d5-a2a4-e80bb7c4d390@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cdb4c37-0e01-42d5-a2a4-e80bb7c4d390@intel.com>
X-ClientProxiedBy: DU7P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFD25B21260:EE_
X-MS-Office365-Filtering-Correlation-Id: 26998446-1928-431c-3060-08de6adcfd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFQKcOo5FF9fLOfPTBjMj9m7C2InVOoqUuAe490du8FyeZbQXFC3U89huSaa?=
 =?us-ascii?Q?p1Qv1swZwk7BAM0960Mwnu+PE+m303RtEgsDDjamP+sZo+9/FajJjeVDCjUE?=
 =?us-ascii?Q?SF9vu7bSsz6nfv4VeI0w2MJvydWMkSgBVi4VLN6eQB6LMEJoxV5EP9Tvs6Mw?=
 =?us-ascii?Q?C0ZsOE/0aWjC8xhLW9lsvzlZ0S1BuyZ1mBekTa+QmHFwUddBa7a6y8lkqSoP?=
 =?us-ascii?Q?FwmxsrVJ24hRX5ppcH6TZX4Yf7GFUmEmsO+WFyWinGAmzU/pBp8bsGKuJvFw?=
 =?us-ascii?Q?+zOZFAuRNKlrPFCluOUqwsKHc+Q/+9Pb6NMKFr/iS9Wml1lwjgSFTNjzXU2P?=
 =?us-ascii?Q?Vv1QcxBIjsso651mfBKZ5a/3ukrKvBnhNzhhlHwl/AG2cRsYLXuBQeetv/wW?=
 =?us-ascii?Q?+Q2WquJQqR4GlwB6P7p5/icvZEe68QidpxJIHAXCHKHgF/iTaIMCmrNtUwah?=
 =?us-ascii?Q?p5Hd2uSiaCdXYoKE5t7eVMuvG2h5tdtXFfppK1NMffDTCllQgPZgVkJ7Kcyk?=
 =?us-ascii?Q?UOVUvhoIEHcTcJzprm/5K4oWbtlRyQZcCiyFW3G3abJ5OADivwdbbxDXI1TO?=
 =?us-ascii?Q?Sl2wFkTgpgXnhu+rwuaUJ1OMLE3inCY2T/wgfaFrE8zm72J1qEk8KIPhSbIH?=
 =?us-ascii?Q?2LIVm6Jja4Top6O0LhM6ZnYOhEuGBxOs27EgJy/fBN2aNFaf5wjqV6pk03vw?=
 =?us-ascii?Q?SBUgVNoaxPiNklNF7+bQpxSPhkcP6z/kV0+hXPY8JwSq7X0cVP6UuvH7imCB?=
 =?us-ascii?Q?kqtNMgM1wRwxxGN6IhbSkMP+vzs5cPTKsfc5/YmxJVbdhEwpSZkNc9yAGg2t?=
 =?us-ascii?Q?wR235+yh0gNWkC5/nk9qwyjloIy0hPfNPpxvP8BJB0qfV3c7dODr0cYCgbzT?=
 =?us-ascii?Q?VqMBG0x2M5GIz1Ep62Zg2JmXGGjMSE+Bi017t4JOVYM3R7Kpb1Pt7lEcO0Uk?=
 =?us-ascii?Q?A7btHCghUr90NdVxBUmCXLdB+ouS/tSBkN5zkRiCXPYAkesNRWf1BubyIMF2?=
 =?us-ascii?Q?FPq76TvUtR3oJZNASw066hWl2QLyzXvudaIwytvzt43DiFMvKoCZwyVnrpLf?=
 =?us-ascii?Q?+Pvf9NZ0JRE/gX4XoJxtz3cxwJtaFD9eTBj3zmR8jFo3TczxIX9xswDE/7fn?=
 =?us-ascii?Q?aHVDtkMOnKqMUskB2smdESrKR28VoNvEXU2AiOoOsHEE69FaAj3A8kcGVb5r?=
 =?us-ascii?Q?uRSF+fzqwEhlXO/CLiEuW8DA+HeVSQtsjtByRsK91LYDTHOfpi6LirSsnTFw?=
 =?us-ascii?Q?BV342FOttOPECWLKssoLyXw9WsrwKE2Oqbk7kzaDk64c9cVY0T1d1/9xLisM?=
 =?us-ascii?Q?I9ehwaP2/t2UHafan93HuQ6Xaz7pZNvXXczly0YfxDOQ0yYhnYg7XmqYb/yr?=
 =?us-ascii?Q?Beu6+114FNzjxorShDUTKGTkmLvEvgZ4YL96CToF4jfDyBMQZPV0dtpsqyYU?=
 =?us-ascii?Q?dSGo9keT9cM0hoTKlFU6t2qijqfsoUYODq7FsJ06RashNkObZYOYBq4FHmp2?=
 =?us-ascii?Q?MytCUQ7l8uU9r6B5V5R9vpODecG1oH2v37+5r+8+UrYFPb9KBm+JhA62TqWl?=
 =?us-ascii?Q?LRZEP6dWlpceHIDJVx0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sB2tKQ1/GzHkrH3VE3cEcy5YvQDGnha8FUessaKIIZNR2tlWespzIp0Db89?=
 =?us-ascii?Q?7wUgFg7X5hrf5UqcwMMIGLDdBLsPEU9fr1pYJvJxCJHzI6zy08Po5FUx6Qpq?=
 =?us-ascii?Q?SDKV/wjxzGAy+fs+ySFYp5UeZW9LCS4evhkgHmmKyHR9asgH4Oji+qYO2I81?=
 =?us-ascii?Q?rBL7NB1hnvwyqnvpi45Dxf2D1Y97ZhG3G3q+sgDuFjbBphmPO6RQhMk7Nrwl?=
 =?us-ascii?Q?eBAtDSeRvq0Wd1Lsyqum4eSk0PL4+opfQIAG0LJAcvQAbcC50P9h6GzNYjz8?=
 =?us-ascii?Q?VT+16Zf+/xRELQBK1uix6zp/wrQvbwy/j9EG/eeFrdR+/uA/cMdn24mPz+oi?=
 =?us-ascii?Q?Y7VYusYokw7RLgOHWOZ1uhuT2ulRmeWNcseFnRd3DMIaR0uh8pU0SCGd5570?=
 =?us-ascii?Q?am9gnnMGSSLFfbzyetqZvL2IYHh4iFe/a2jwUyagrSNqCiqXLUeTwhdp5gzc?=
 =?us-ascii?Q?XURxW+3mlQlkYseQMtwKLCxiXjDy2s6L2rCEAYJMxnwS4uJWBDF1sSQVmQ+3?=
 =?us-ascii?Q?DL7BaPdPMIf68ifGLqzTBWmyys9gwwR9Je+6LOfRqtXnfcsbGn6rLeXiTBTz?=
 =?us-ascii?Q?zDRJ2TjGL8loj4HtYLlz4n2w6e/hoBbRuF8BoocpSGUjouwrQvNskQXmYa8e?=
 =?us-ascii?Q?UTrs0/alN0e+8wbALalnYcfNWO69+I4+0mjA+k+E8e7ts2ddd6InGlNsuFAd?=
 =?us-ascii?Q?eY5/Z6YZaQoArX5fyt0aLwplpmCR513zYBxgz7+QxILXz/CA4/I8I0NXJsD6?=
 =?us-ascii?Q?mhzMQ/KxklPuXcZcAvyiXOq6LWj/ARcBATIYUj/DTnYubucllxYAT3vdhdRk?=
 =?us-ascii?Q?znNjmkhjByc8f8LKAGJ8ECBi3BI9I17BrZIvUX+pfBNp5lNsZi9QGoyTXVA/?=
 =?us-ascii?Q?oqvtsMqbOpgcrGuexa/o5scYQbK+lZDha7FeHgBoOU4V7TG2i6E0cztdAOic?=
 =?us-ascii?Q?V2Sb9PuK1UDLvlP5bfhjoyF2FBJ0SYM7Fp7ldzVJyeBuFE8/U2pKLKoOou3K?=
 =?us-ascii?Q?DaokTJ0kXmbPPyx8CsLOFoyDGLYHAClD5Oa/h4rt0Vnpa/zS4B67ox2qVfp4?=
 =?us-ascii?Q?EzckVbuVdBZH2uR/KuRVRURQ+tg20jftWoaM5ksOqtRCeD7XjVGJcRph8zfp?=
 =?us-ascii?Q?lX+juZ8LILhFhBvgMScgkJ7hNdLWKBjIowuFbiiEO2gw8+tjbQeDUzW3gDRX?=
 =?us-ascii?Q?4WQyEfJSetjxQX4gh4RZh1N16HBLewGSW/DBEYo2B7AkwYkSAOCl8jtTgaKX?=
 =?us-ascii?Q?ZKd7xHbOEZKXLVARvkvYtp395mJw03j5N/fgFjdz8d6C+5IGdE+LQ3jcCuky?=
 =?us-ascii?Q?mDr6B7bQcKTe/jBZD+ZF1YuoqOKdH/Gkig2zwtq7QZ6GlUVrecxhlsCWc3BE?=
 =?us-ascii?Q?pjvH9FabEZ9v5zY4HD85rQDmxXUjGbnGIndzxgiaXaK2Ljt4xzvvnWj4NuX+?=
 =?us-ascii?Q?1D5I2SbgQCHU0TStUSi24g0vJ8WbTfnRNF8RpXYIux1/wO0bXNEzW/u5bmE9?=
 =?us-ascii?Q?aDsN4zFNdyobHA7uQH/V5Z0EUk0i8XzmKW6ESzNe+Uz028Hhl2BDrkSpsdeY?=
 =?us-ascii?Q?77Tt4v2lt3COcBgdLvSr6NsAdQcnht/rwIaCdrgwNVrXSvgwbtqyrq7LOIbT?=
 =?us-ascii?Q?NkIZF1R5Crc87JAKALkpEsfdcHnS9QsUGs43uVGLbHnFYThEBkN36yTI9DiM?=
 =?us-ascii?Q?NuUaloNnIR/qLQ2ePP1xT5qwZqGpwvoHCfIGrovHH2npAAmpB/Lptd+7Miwg?=
 =?us-ascii?Q?oTLC1OVoaPqtkJfPRZYwmJ+jNFKeLSM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26998446-1928-431c-3060-08de6adcfd51
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:51.0439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBQqyCTv+SBbw99EHkwIeAwiWAHZ6EDgLa6+oFarGmD+Aa3j0cjg3oaObvA5Ky7Sk2YJiXh+8pyw+XLV5/ATSWABlFCS5faZ0Jpc8fkSXOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD25B21260
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

On Fri, Feb 13, 2026 at 09:44:49AM +0100, Burakov, Anatoly wrote:
> On 2/12/2026 6:10 PM, Bruce Richardson wrote:
> > On Thu, Feb 12, 2026 at 12:53:25PM +0000, Anatoly Burakov wrote:
> > > Currently, security flows are implemented as a special case and do not go
> > > through the normal flow create/destroy infrastructure. However, because of
> > > that, it is impossible to destroy such flows once created. Fix it by adding
> > > a flag to rte_flow indicating that it is a security flow, so that it can be
> > > destroyed later.
> > > 
> > > Additionally, security flows return pointer to allocated `rte_flow` struct
> > > unconditionally, even though the underlying call to ipsec code might have
> > > failed. Fix that by checking the return value from the filter function
> > > before returning.
> > > 
> > > Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> > > Cc: radu.nicolau@intel.com
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> <snip>
> 
> > > @@ -3350,6 +3354,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
> > >   		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
> > >   	struct ixgbe_rss_conf_ele *rss_filter_ptr;
> > > +	/* Special case for SECURITY flows */
> > > +	if (flow->is_security) {
> > > +		ret = 0;
> > 
> > Rather than assigning ret explicitly here, I think it might be better just
> > to set it = 0  at definition, and leaving this as a simple goto free. [It
> > would also head off any future compiler warnings about ret being
> > uninitialized :-)]
> > 
> 
> I actually remember a lot of commits *removing* that sort of thing, with the
> idea being that we *want* to have these warnings to make sure every path is
> covered. Additionally, I personally prefer it this way for clarity (i.e.
> explicitly indicating success).
> 
> I can still fix it if you have strong feelings on it, but I'd rather leave
> it as is.
> 

True. It was just fresh in my mind having had to fix an issue with the hash
gfni code where the compiler had failed to realise that the variable had
to have been initialized and so was giving a false positive warning.
If you prefer it this way, I'm ok to keep as-is.

/Bruce
