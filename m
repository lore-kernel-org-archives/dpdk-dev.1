Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A3C9EC72
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 11:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ECAF40A6C;
	Mon, 12 Jan 2026 12:11:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5AAA940288
 for <dev@dpdk.org>; Mon, 12 Jan 2026 12:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768216293; x=1799752293;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yolPy11Adu9bVvye98E0JmK19AlYV7Gb2wByxn2uXBk=;
 b=EkABbCtroodhf/XXszfuDhJJp5hI3SCEd7xuOG+PhQPgOR7Ykx2w0Xkk
 acuHG21PcGGvLyKpgt8JCGmwU7WVVoXCDaAhqZB4OMaLWn3xhTbN1aj34
 GlWlEkSrBdUgCT6fW3x27V4sS8i7gN8wIXS7wcOG1IoiobTB63GnQec0t
 Ui1OfuPMG7dwcxHMTwmdv/8BWEvAzHO2LsmgQydpW5urxxpzsqr8ZNqwR
 KUc+CUTbj/IWMtlsDSaUlQtwxki02ixT0VTvaRqjM8ihBHDZdjQD2yfUX
 pYxwQI7zqOGmVl00JrvS88DpCyNhMWWlADk0wjAnUrmMVmz3rlpxCujUy Q==;
X-CSE-ConnectionGUID: MKuoduIeRPukJjwAYfT8ug==
X-CSE-MsgGUID: HwT2ozrqSI68qaNKElMmig==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69473067"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="69473067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 03:11:31 -0800
X-CSE-ConnectionGUID: kUPqtqYIQteNd09aGtzKDQ==
X-CSE-MsgGUID: 0hqCOpH/SJKC9p11j0OVEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="209135105"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 03:11:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:11:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:11:30 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:11:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE626ZUFlXIDUXVLvEzChGbFgnlro0e/7vhoRrLO8Jf2LZJ/TIL/X2iPteo+ntZg8Vt6Lw9jXi6oB9MuvZ84/EUAboppIPaMAyJYH0kLhrYBRJWCEONlFoUcFkGeKmb4KYNhHqedkd09izYCoW9JOjrcoQC+arPwlDLE9VXFyF2mTAlwE7tsflBwEvzIiXjJBCXnrNPr6S1MZfh/C+GUr+XuXnz+e9syXXcacs1jeSYprJ0hAo9xKzJhIhRJ2ELEXiEPFDTDUPS62rPjjc+Oej3uhfMgbD2N0uLu4N91XfPVZL6qrYhzVxhd1GUHeSONyGyhWHJrTkb1xwFHU3ONqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMTgI95OseXQATQHfwx9c/WqQNl9X8XBB7KSUkOtOHQ=;
 b=c7nVldYVKVvftMNAgN0Fm/KWdktQfX6Wfvph0kP0LM971dLK8sTTRewkVjhzthlmZc9fu0tPgXVnuG1Ga9pxE5856R1JyJk1Bp5hAokqYnSGJMowr5dLIn9bPEgl9hI4RN2Z2fD4ttGNpTtpK5SteAC1wCiWawHb96HXInaR2QN0q+lpUFtDtNQHCDF+hGnDvYfXvFo44YX1HizIHlxpLnz9ts/azvokZXucy6UBl3OSUvvNwq7GZardX9e+pjRTGJZlLhxlhrYl7qWkNoWFwTsk7LsHI7k0Gwc98mfS6AlA5ykjOzbBOgz6ga4F2xxWjKpAFxJuzCYNqWdreTSnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4990.namprd11.prod.outlook.com (2603:10b6:a03:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:11:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:11:28 +0000
Date: Mon, 12 Jan 2026 11:11:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>,
 <scott.k.mitch1@gmail.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <aWTW2uA0LmUFgKsm@bricha3-mobl1.ger.corp.intel.com>
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
 <20260111150033.81760-2-scott.k.mitch1@gmail.com>
 <20260111075919.082d12b2@phoenix.local>
 <aWS7YdU11DNPbz4o@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65652@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65652@smartserver.smartshare.dk>
X-ClientProxiedBy: LO4P123CA0486.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: e470347b-7f7c-41cb-39b0-08de51cb5522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Nc/+2dk85lMvpMAYXOY3v5OewATcwm08EsUgBaVaImSEmUlXijb0q/EtUQ?=
 =?iso-8859-1?Q?eJ1A7bzTFRBJol4SbEP0YxxKVJNRso+BQuOrrx/WSnwdah989QC16KfXwc?=
 =?iso-8859-1?Q?nyu+jhwxNEvVL63SjHNp4BCbwFk889WfC0u8ocPQeRc2I7ztu+I+V7GkT6?=
 =?iso-8859-1?Q?IN4gVLnSLcFkvFKpij3HTx+t3MRtj+lh/ZUNCAKUmNXwd/HParReiZJBuo?=
 =?iso-8859-1?Q?fCtLEK3stH/uSWkXekeiEpiM5Q/ZntlPdrkBU7adUVqPlEwDP4q1jfMQOb?=
 =?iso-8859-1?Q?drxZbHMb9zmQkpiZ04yHLFZrSGgJsBYY4pyYY56vvAhRwMhpWJhdv/b3SV?=
 =?iso-8859-1?Q?3d5lOabRZ05VG9mU05Vd5eUeoDVjUoJbOK2K/Yqnk1awkD5rmNDyigzkjH?=
 =?iso-8859-1?Q?xw1l/s+/94NeAja48n9E9+FkcIg7Bdm97b4pt3vZuykoGuQQzNpwtFCCJ+?=
 =?iso-8859-1?Q?ZhlUOLfCEbIZx02tMxR1PXIg1E9leAA28ZIebEP0Q9X8//yNsCmyfog9dr?=
 =?iso-8859-1?Q?wjMNRw247YurmCzfQALplu5ovCYw5IzYks7BERux+zLRPPE8THrXcHgrOo?=
 =?iso-8859-1?Q?Rd05mCyI+C+vJwAenwtiFwLxAZzLD1PWqjTiyz6XvNN1GlI6BSpuCx9TZN?=
 =?iso-8859-1?Q?MziLN7YXZ8tk5yBMsPQf1VNEvptSQYc9ZW9HdJaaqYpyTS+IL1R9zJ9dJB?=
 =?iso-8859-1?Q?oyGwDvrCAiR/na7e2VukM2immsJ/KSePs8ofy/2WRP9CvcJOr3IYY9mXFn?=
 =?iso-8859-1?Q?Uxj2g+gg3Q5KEPNMJC3Viz1Nnx9xp3y/NXO9qjjU+Lgmiqp7icJempB/0N?=
 =?iso-8859-1?Q?o57kbOty5crWvBZfydxdVWFdAO06Yp5TzkieFs8TcczONC9WxgqiP0881m?=
 =?iso-8859-1?Q?A0Qik5cnuyTyS8gf02KbcaorN7XoeT8Iw5FDsespuJTJYVHHMrktISO4mG?=
 =?iso-8859-1?Q?f6hkLK1Tr97rm2lkN59goFh51bDGvLp9LljDabx3h5zasL6ALOn/o4td17?=
 =?iso-8859-1?Q?5ntY51OLVImWmNDnjQMaXO3EaZfG9LD6Y1BmnouPTz+zyajvp8gSCDSJp9?=
 =?iso-8859-1?Q?Tdf4DFmcCse94DtnaTIz9p0jH5tj8qJTz3pJhTx/sNlm554xw56EZwujoj?=
 =?iso-8859-1?Q?hcdZJBRcMtRQO+GagBwwV2sIuXIA8tmWsxskqaeKIxwwTFUFDIMKvYZhNI?=
 =?iso-8859-1?Q?Ha+3UFURRn9VtL233GrwtBnaMEaC69JzdR7Rm4KH0gh1iS/27neGTNxRl1?=
 =?iso-8859-1?Q?/iH0gMTqbPsia9AUuM6KxGVIbnK72+xUyFFZLVlE/JHxB/56DcYrILdD6T?=
 =?iso-8859-1?Q?Vv6do70CR5JEyv6hL+A/4G3Qimo/xNylTPV+LQDA1mNZE4FPARt7Z8oOm7?=
 =?iso-8859-1?Q?TEfXxI0UXNEsSVee84p4c6CXL1c6E7boxP7i+21xGXbNBzFbNCP0CFPFFw?=
 =?iso-8859-1?Q?OA90p53GSfbCRPsHToxdebCBDvbfSoS7tQ4jIrCitC8yYoJQsrCP65qkGt?=
 =?iso-8859-1?Q?u/GOvoYUdj22SA1r4TvPY2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oDBc0bxqiiRxNC8ShtMcKRvX1FTs4xzKa+0kXW6uciZPJNRsbvMAJMW5O5?=
 =?iso-8859-1?Q?t9HO2jVv2xA0bFEiJefq87PCc321bqtK8iEQa3xikaaDyOgxxusMRlFGIs?=
 =?iso-8859-1?Q?7pDxC5t79WPnYHeWy5DvxWbgr5Z5ZlWTCPR+aJ8ll7RMMn6oflY6fH8ds4?=
 =?iso-8859-1?Q?JCpEBD1oDFOg7XBwdVcXapxAtAqrSiJou3BwErEZQ4fIsvuhTbdCm1UrVp?=
 =?iso-8859-1?Q?26i72CebmM5gaSMbOM4vfgn5+FfwYK73+6kp2HZ+MTBgvxM0xjpoRaJu1S?=
 =?iso-8859-1?Q?vJmcatLLc7gVPUqdXM3LK2NpClfIRciTE9s+ZGwJEAtyb3VjdYhost7kOT?=
 =?iso-8859-1?Q?8OJGAp7KFPfIdfGI4YtYFS7dGqJJEznmzSNvGf1nfNJ9DsiDQLyoSmZnt/?=
 =?iso-8859-1?Q?QoErCy0wdh9ByNRmNkMDwgck6NSY0tsuyPLt4PuPKKB9KxhLJ2p63/ud0K?=
 =?iso-8859-1?Q?+/Feqjmid2moxt0rtd44Ivs2+6bplF6XKlvRTgEkgqvpsPZ/6KcLHAi9Au?=
 =?iso-8859-1?Q?ixXCVayN/zyaLyp1J3+DSEm8cLzqGNxtslsAzkowBTVMhv27Xr7pqqs/q+?=
 =?iso-8859-1?Q?XZWbV8RArf0MDEahnhMTvaOONxAdPBhH6VixX9UkpaRaSaWKEcDvph8IQp?=
 =?iso-8859-1?Q?/ONY8Aa8kO+wXHQWhh9iP3kVUA5vSbwqbB5J601BNohzHxmEVAFPMfRSse?=
 =?iso-8859-1?Q?H/ZWica0+YYDwTfgLY7VJwghlIBoshueVnxtbrcftQ6LIfTgUe5h7rG/qF?=
 =?iso-8859-1?Q?2Ddb1TAtmSbxZnS9mZ3PM/GyzrdIaKcw02cY/JEJ8S4iYxLNPKvhhKuWxF?=
 =?iso-8859-1?Q?ALJGiaVOHzIHo5CkG8OEHbSiCW4Y1WA+YcDCQUVheLsfGFy5+DJn+70blt?=
 =?iso-8859-1?Q?xR5OnVdisLpMp34WRDPF8SNbqBR9RB7LHUpYpkAmwzFDyc1f8YaaSktfRA?=
 =?iso-8859-1?Q?G+aBGtZZ/ozXi++MqC2CLitkrZZRejWRvAXY1AToHvpMW6GRRnmT81azkG?=
 =?iso-8859-1?Q?FeFtitboCuf3GMT7YgKBr/0/KVrwvS72pQ+r2d3NpQNqnuDuR+lU95j7v1?=
 =?iso-8859-1?Q?Scw96i9yWQE+BxgPYpbiO6k3GWx2JUuPDWyNYMhKW3IWjPuGepYj4xLndf?=
 =?iso-8859-1?Q?PnIZeoQqJL0dla+Yh/jB2eVITPLqSPtrxh6iKK+eNWKIk8oABsIPsNKCO6?=
 =?iso-8859-1?Q?43ENpNN8/91YEdRb4AVUuIZb5oA9ymYVPfAMWKWh1MPRgPl/RHR6D6d5Kp?=
 =?iso-8859-1?Q?Ra49VmgRhxYjF2ubxh17n5FZcnxMstuF23B55g0RbryCQEdR0rLSXlPddk?=
 =?iso-8859-1?Q?rOB8mvWw9KVlDMlHa0ApfcggjuLWqqqzFnhrA3iGN2j76Z6STL6+S1nMqY?=
 =?iso-8859-1?Q?SLzJfISfsV1eVdUpW/k+YvXzqUgynuy5FbVehN1OLbZa4B2+UTTbRznWJQ?=
 =?iso-8859-1?Q?qrIxry9upXL+tiQ1Jd52FZ6Lrm3g+Sc6RUEKY7WkyPCH69xqKNRPv+ENYk?=
 =?iso-8859-1?Q?0wDbv7LszymfYpFUM8ZUKndX+42Vd64HBXyTMyIyNwttlV4ywtP6Kix9U/?=
 =?iso-8859-1?Q?HFbfVunEH/Lz7sFCiKjPqcMUdR2LgW/cjIvnYok91K5Ivj65jqHu/TG8Dp?=
 =?iso-8859-1?Q?W4Y7rHh0BxyvntUFV6MHjOsvqfjBN71RIzg+bfNDB97qZLPoWdBRkBns29?=
 =?iso-8859-1?Q?XdfedFHqyJoJQsrCHm1zJ4uF+/mFtw53rn+BdGhg/LywASOCCbVuBYKLYb?=
 =?iso-8859-1?Q?ZH9WG1HzFM0UHAjKEGAmRNKJMGWROf3IszK0m23EqQaOkNq1sTmrKThHpx?=
 =?iso-8859-1?Q?bcnd3mj87iBfeDzbQGs54KsQ6vZ41Y8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e470347b-7f7c-41cb-39b0-08de51cb5522
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:11:28.3708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb5UmIh9MXhDqDbh3RkajaABLWAQFs6wrqaJrPvw9OVQBkQ8d8htZ2qfcrau23sisVLcBiqhYz6AM8uhAvVqcDMDIWLfSlJZUeQsyjrer2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
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

On Mon, Jan 12, 2026 at 12:01:21PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com] Sent:
> > Monday, 12 January 2026 10.14
> > 
> > On Sun, Jan 11, 2026 at 07:59:19AM -0800, Stephen Hemminger wrote:
> > > On Sun, 11 Jan 2026 10:00:32 -0500 scott.k.mitch1@gmail.com wrote:
> > >
> > > > +#define RTE_PTR_ADD(ptr, x) \ +	(__extension__ ({ \ +
> > > > /* Diagnostics suppressed for internal macro operations
> > only. \
> > > > +		 * Compiler type-checks all _Generic branches even
> > > > when
> > unselected, \
> > > > +		 * triggering warnings with no external impact. */
> > > > \ +		__rte_diagnostic_push \ +
> > > > __rte_diagnostic_ignored_wcast_qual \ +		_Pragma("GCC
> > > > diagnostic ignored \"-Wconditional-type-
> > mismatch\"") \
> > > > +		/* Uses uintptr_t arithmetic for integer types (API
> > compatibility), \
> > > > +		 * and char* arithmetic for pointer types (enables
> > optimization). */ \
> > > > +		__auto_type _ptr_result = _Generic((ptr), \ +
> > > > unsigned long long: ((void *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			long long:          ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			unsigned long:      ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			long:               ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			unsigned int:       ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			int:                ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			unsigned short:     ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			short:              ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			unsigned char:      ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			signed char:        ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			char:               ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			_Bool:              ((void
> > > > *)((uintptr_t)(ptr) +
> > (x))), \
> > > > +			/* Ternary with null pointer constant: per
> > > > C11, if
> > one operand \
> > > > +			 * is a null pointer constant and the other
> > > > is a
> > pointer, the \
> > > > +			 * result type is qualified per the pointer
> > > > operand,
> > normalizing \
> > > > +			 * const T* to const void* and T* to void*.
> > > > */ \ +			default: _Generic((1 ? (ptr) : (void *)0),
> > > > \ +				const void *: ((void *)((const char
> > > > *)(ptr) +
> > (x))), \
> > > > +				default:      ((void *)((char
> > > > *)(ptr) + (x))) \ +			) \ +		); \ +
> > > > __rte_diagnostic_pop \ +		_ptr_result; \ +	}))
> > >
> > > Good idea in general but the macro is way to big and therefore hard
> > to read.
> > > The comments could be outside the macro.
> > >
> > > Any code that adds dependency on a pragma to work is brittle and
> > likely
> > > to allow bugs through. Please figure out how to do it without.
> > 
> > Do we need to handle the case of users calling RTE_PTR_ADD with integer
> > values? Using this macro to essentially cast an integer to pointer
> > seems strange. Even if it's occasionally used, I think keeping things
> > simple and just globally changing to use "char *" is a better approach.
> > 
> > The only case where I'd consider trying to keep compatibility using
> > uintptr_t is if the pointer parameter is a volatile one. Even then, we
> > can probably handle that as with the "const" modifier, right?
> 
> None of the RTE_PTR_ macros can handle qualifiers (const, volatile).
> Maybe it would be better to provide a new set of macros with a qualifier
> parameter, instead of adding new macros with e.g. _CONST in the names.
> 

RTE_PTR_ADD/SUB can right now, because by casting the pointer to an integer
value, the volatile or const or what is being pointed too becomes
irrelevant, since we treat the value of the pointer as a number. By using
"char *" for the arithmetic, we keep things as a pointer and so we do need
to keep track of whether the pointed to object is const, volatile etc.

We need to ensure that the following still works, for example:

  const int *x = $foo;
  const int *y = RTE_PTR_ADD(x, 8);

/Bruce
