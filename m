Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C72CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8432440ED0;
	Tue,  6 Oct 2026 16:31:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 947284025A;
 Tue,  6 Oct 2026 16:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297112; x=1822833112;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eFGur+heTNH3UKGN7TrVHApkCb5WGfsxfQMGI5ChII8=;
 b=YR3/yle2EseALWUXnUJmwncIl+1oBUEyl9qVmkVXxbMUBNqEWib/zbhH
 iAghbvoOtt+sqFEVewqj53ADH0vCiaIqa0IBxi3QIY+mEiqXQt4cKEs2i
 PMqIBVG3TT+OXjRn48SC+vkPRJhybY0YS7q1jXpi4DejMfcX1MTXlE7vs
 dVeUk57sIMlwbSOx7CTS0ejWg4LnhwheLkKU/FeNA0RiYHfMCvQ44Ca1k
 O8qVep9R+uFUvDoAn0Nk3Fx59UF2gzW7GP4Lt8HVA5so5AzTcY7PyCn1P
 agSE5r7ltgnFCh8O2RCQwrVIVSPVxZN0HpVBwX48aSGaVr+zDcuguysed Q==;
X-CSE-ConnectionGUID: 5fDqjXheSG+TaTDfR5mAmQ==
X-CSE-MsgGUID: 9T34V82LRUCrV0EkBxzDOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="28781"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="28781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:31:51 -0700
X-CSE-ConnectionGUID: R8BbBi4oRrKty2zrqjp73g==
X-CSE-MsgGUID: x7aY+oL3Sf+bd7iKanIwrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276287602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:31:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:31:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:31:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLnhINBrlemCYigIiKC3mq7EN96GqiiAX04N3PyxrNNsPcyQJCk5Qj5EHd0lxsDAJvUdAJAdLTfr6D5SYyLiRwrSE1kv/V9J5Mplzz7bJBbB3HTFYaZ4oyjswbW4I2De/uNEZlJhxZvitwxNODF2Geg0oiTSut05oadN1f4ODdSWsIfXitpaV+l/LRN4n6Zn1LwHL7WOZh9Ep3FSw8P3pz6E0AFgq+C0l9oGWwKchgtYSW4exatNGun6/4ZxIOFDR0k3wnKSfJJOGrGzNoMIiJKBgtKZqRYnF2761Ouw9Qc5/9cRn9ltPcloHuKi4JDa/Tz8NYooOnAv6/rWWO92AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKhkfzHrqdKxCKB5PEmi6YxWq+VhbGTTsOQeg3sAnq0=;
 b=yypweX6isow+VDjpYF19zy5/Jr+3bFFa5SPi20bhiejIofPbk5BLWdToj4yex6aPR2LG9bvNmnhzZCInym25PkOcnY0Vu9F7rPajkCeghw9RtpV+elezZoPIDLdwb+5663O72x6tcxY4CcxBu4QkAFMrhYxkAUqbnD4n4bgoWVslJcBlgrtvyuBDJ3LeXVsGlbD5D7Alz0tKz/179Wwgt2CAIn5XUjDWB7mzWZBNDQOSsEuKAF/dg5iKCVley1GCDPKvtTwr9YHlRZd+7MsGB8tgSN/yhLjintmNxYOTSvIj9HwYNCA/w+tN0aayoLY5g2mLe610S1CXaq6fnBIPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB5922.namprd11.prod.outlook.com (2603:10b6:806:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 14:31:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 14:31:40 +0000
Date: Tue, 6 Oct 2026 15:31:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Omar Munchaev <omarmunchaev@gmail.com>, <dev@dpdk.org>, Omar Munchaev
 <omar.munchaev@gmail.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix missing type casts for flex descriptors
Message-ID: <asUGRzhI31TM6uWs@bricha3-mobl1.ger.corp.intel.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
 <e01185dc-89d1-452e-b2d6-e75082befe55@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e01185dc-89d1-452e-b2d6-e75082befe55@intel.com>
X-ClientProxiedBy: DU2P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: e54e0c6c-566a-4fa2-e914-08df23b6894f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NyJUX1EX+MBqfrWerr1+6WaL+0EPN1dOkfpxyxKCxJKBPes3TxnrYngXNONqFJDKlm3iBOvnUVD1sGUP1il4iSVodPj3NgtdzsWsAHm97awGZrd9Uiy5g9JROmDz9DdLuSHblR2qt/THiC2o2HAc+spiAelngiuacq+d1VdgfTIHf1H6JGGqT1Mh0YCj6qZf7liq8qEmoTKlaaFKfjkyVrkC+9FXXFTHJzi/xutXQFT7W7z9Kj8chCkQjBsYsXjbvlr2fUZDYGd69OgljylS/xBq32UNSv90LA4armakUmianhM39XIJROfThJaiaS4q2ywodpZeYML+meX3ITQVhLd9DW1kv88Pnhg2GL0UOawMNP8dWwPFbePiOjpaUv2SKcHf0SJlxYNFq0Ls+aETJJTUhgTDLLVSssCwRKjqyEIvfESUK/PvTmoJpPXO+WMMcCN7D5XKfzhEhsI3VJFjIUaU41mYxIxEMakCZ6G00oNPPGc191g9Lm96vA2DtGikrtB8YKTO8zxh4PWa43qAuFWGxGTQ5hsIR29wgTPOofa7hYP5MeOtJWTbJn+vUcOBnvZM6q+NIu+mkSzXahzjXhYnNhaaMBosLPuH83Whgr7jKFWt+CeD5PKV1V89itrBX9cACmoWCFG/D7Fm4seS2+s5E2Jm3YkUO1god1gUfxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JghpX+pxwujPS59aPBjgh0WZc3A/glDoj1lm+blSUUIABDOKdnhkd13DoOTX?=
 =?us-ascii?Q?M0TLA/y6qMb7J4B3jd+EnbIc82a4a4mtdTJtncgp9G38KEsIgCDfUSL9kpP0?=
 =?us-ascii?Q?ksvDW2O6dQv6T1EMGEG/uCiBHot5PHtWnp0TwMOXtfDeEf6QSsF4YLVGcZ/J?=
 =?us-ascii?Q?t85jkrhN/UI31lduG3tZO8WVMRVN7l84PX0wjWdaRDLvUN+KRK11BTqa7TnI?=
 =?us-ascii?Q?YL4XiK4SrI3W3Idt/JQ9A7nP9ypJk3+9bezRVEdYZfcm7IVgR8r383UKxivx?=
 =?us-ascii?Q?kYasvRzZ5VYmEgUMueWt9bBy3thhNydvZPXuuLqEJOTvwbJiOCalcZ3LuP38?=
 =?us-ascii?Q?hwlk/MlwD5/3Nrc1gfyi7e/eO16p+kHnn5NEMUm9RLaXwpRiXUU5DtWFD7Wv?=
 =?us-ascii?Q?pMmh3hcfKLR3EWzqaNfPj4jNbK2+Q7Vsxy0m05lKIXzU/92koDiGv/54Mksr?=
 =?us-ascii?Q?LlD+LKYUEjJOe/zQgMQkdx6tCY1PJNXDL7l2gjO7PDPYMW5AqYG4Eqt/gwz6?=
 =?us-ascii?Q?R23pMz8GbTsTQkBiR8/1ofzvcDV2176NANn+Lg/Ev0/hcn/Su3f739HdO0B6?=
 =?us-ascii?Q?PVcAbc/g6M4DN1BY4jG2uShX6okvQs9dL+qiCoQx0p2OiDfB8OhjMMnanu70?=
 =?us-ascii?Q?tivqaYIkhkTDBXAhlgs7PG3IY+BjbOW9uQfHC5dt/4/tiWqCuaqRlPFdcnqF?=
 =?us-ascii?Q?boS8n3+KtZZI37XEc5/j1Mbvz+v93WJ9A7WfonSP5UEDnrMOtWncpbjxLOi1?=
 =?us-ascii?Q?rNXbKB5VtoB7aeTQQXsa9D7CFSq0dgVrvHCTDlUOUwh+B8nt4XKak1uciGaf?=
 =?us-ascii?Q?fhDQF/wqYlt6D89WdyqG2KONgWNos4IrgEo78UiXxoe///VDmEImuHG/R7cM?=
 =?us-ascii?Q?YleUx9m7Xhmn61l2HlaEHxUKrXuVjf0LmOHFb7UpXpw1NnXYZuRbszJqgO/R?=
 =?us-ascii?Q?95BXuTsWbRzLnIs/ZPPJsnGypuKoJfgx6jCQrwIB6UM1MtmvFwsBVRlh5MlP?=
 =?us-ascii?Q?d6AEh3ioTLYONwY+Jl2w0l7LU6KKtpTQ5IfGDqn3HZMABJOBnvlJyQblRZWJ?=
 =?us-ascii?Q?d/OWGyViefHPNge/+cbZF5sVVumYquQJTJTNJFqB1vIjSd8ImSKmcJb9mu/B?=
 =?us-ascii?Q?7YcAOlE8/mqAWQAml2MEDMJblWmMZjvOpGcjiXyb5+0MRqDisCqTebmxGwz3?=
 =?us-ascii?Q?j8Q4GUWVYGqsd2Oqklu7MpwKXef0KszCAD+uHfLcyAPEoluhwkBAa9xeePPC?=
 =?us-ascii?Q?u0M0lqPn+P03gSE5k7ovJw4x8YGKp8rJ8Xa8YF8vefMllQX2cnqOTlhdvC1E?=
 =?us-ascii?Q?flqmpRiw5ERJe0SyLwrNHoeNO2dTVs/PLHWSQjuUMf08eSRXFknrejLDo7cN?=
 =?us-ascii?Q?DZB0U0l3T/0UifInXqSd5dETbsoWBW0YYrrA7JYtmXkmmuyDZM5PVdck1gtw?=
 =?us-ascii?Q?JwbNQWOHTI2T7zgGdKDFdxO8jPQLR2Zw7OxAqzSAQ2HYRz6li9PgM1SO/Ple?=
 =?us-ascii?Q?5FMPDNQOvkW/w4iStBs4li07qsAGetAP5OqlbcBNRSfA9xkidfPzWZ2/TBPh?=
 =?us-ascii?Q?UoHroYO+QDd36KdzNFiXeNmKJTpylg1y2jITO2XvatVUSSqezN0YELA/1vjJ?=
 =?us-ascii?Q?xS42vWm8yiW7enYUbFEw+VMUwLSSWrlpuEfxb46Lr+mT7HXkz2KgNlbpv1ci?=
 =?us-ascii?Q?Na6bqYSebuZZDrOWIjS/95VymNYUHY7WnWLFe4GgLuGocVtacn+S1DVOmJ7k?=
 =?us-ascii?Q?Kyb4pQljQbBDxLwo9RHDhokgjFYEshQ=3D?=
X-Exchange-RoutingPolicyChecked: HhWK3GLIkIY02PUMGE21CNip9em0EQQFhjedd1T5MP6uFV/+kLRTPF+zaaj5QBmxhUV9YaM+7hR5X2g2eIzY6M0W1NfKnnWansFfloW+oUJj3m6ftb6k/VxIEJLk4Dg1XoNczuRO0m6QTjkN8a/vQwiDQw0FM5RHdv/tMZa7RxEmcysv+kQJ40LFP4pkPUhCqKHOEPzPNwZT9bFE2E+NeXSjfbbmddW+7Ld5gvNwKlWjU8+WXVJ713qODOfJGWIi18E0QEJgoJoFVE1eKbeqo7iv49SgYGsQAJTk2qudHXpp64KRnb97U4VReAaKzYgV04wHuMFgC+TeEVJ/M56fsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e0c6c-566a-4fa2-e914-08df23b6894f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:31:40.6472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC9WnaX/7cG7LtKz1NX/1ebevC74uAiXt/o1TwbNkgylVud7rdGeKmYvsTtM/ZlBakmNAgWf0dMLvNGoUAZTCrs/0xIh4z8ejlLl4cJDx6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5922
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

On Tue, Oct 06, 2026 at 04:21:43PM +0200, Burakov, Anatoly wrote:
> On 9/28/2026 7:27 PM, Omar Munchaev wrote:
> > When ice driver was ported to use the common Rx descriptor format,
> > some type casts were missed. Add them.
> > 
> > Fixes: e70342ba90a83 ("net/ice: use common Rx queue structure")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> > ---
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel

Thanks,
/Bruce
