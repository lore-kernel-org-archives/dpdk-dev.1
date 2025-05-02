Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BECC3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 14:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38071402A0;
	Fri,  2 May 2025 16:44:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9C33A4029E
 for <dev@dpdk.org>; Fri,  2 May 2025 16:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746197085; x=1777733085;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Z9EkOH+dwYjae5G5xKz5PA+i1iHMZ0P0+jzanM7coqw=;
 b=mLFjvNhNeYtnyy/+JmXkGLWk3RcYX9L2Je0GJ7aYyocVee1UIVneFC9L
 L7S0YMELMhG4abvPtrfPeJZnPVeuzOcyX13/kdTEE6uesGkJDK7xHqLww
 SW86jUk+S5050mW/4Yu3aJUrwWfd5WwLUbyeToEtfovQ4UbaXNpyul9Nq
 tPKMn2m+trNKW8c61nONgFzg42FWGvoTQYH1TyYxJuhcpJ/oL9VfpDdBG
 zn+w83f3N6lHErprwMJ7pR9y8AvksRxcITd7P6M1MsREKd3TvX+ec/alc
 PD93SVhfxKBo0k5vy6Kr927NLH17ZLIKOGB3u9PclsN8NSQ7etMn7G9NX g==;
X-CSE-ConnectionGUID: u6FBQfRWSbmWVpbyuzcoeg==
X-CSE-MsgGUID: 9rzELD+yR3qZvHXFmS2rPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47764017"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47764017"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 07:44:44 -0700
X-CSE-ConnectionGUID: fxTjqs/VSLKKMqISyrozPg==
X-CSE-MsgGUID: RbboUOiHSYSyIlCZQXCtKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="134553305"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 07:44:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 07:44:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 07:44:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 07:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLRLgNoeE/f7XkAVp5duMT4dSH+JjOhIk4DS1kjapf4uRCm5C6VTcAi2qUme7IaKItPbqDq6Ml6foJ73FzdLplunFzB3DEEeOhYXBmnsz8Lg7aTLlF7SLPQgt7SfiOcN7AE8pkSXFxfbS2sXOlzptva2DTXJIcxyMAvDkpGeaFmMWy1bEDKv3DzP/hXuZOm6KCduRMvK25kUZSqU1ZbdZN7LSEcVKqcrtfhpCvpYVbbVdWTDgqiIjKmQuX8ffG4V8X5glbbhB5ss9nMBQ4DY1Ba/lMs1pz2IEicxDcOHRVCZm6qFx2MzN4K1mpISjkwwRuYYFI/OBvSD75BgtTadCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igQtQ0oHRX+jyK6TVMDdcPshL/uRhac7Jd0bKSWAlqk=;
 b=nshfCHqU0Mmck2KGPVPp7efCNwM5KppDelFiT6W2lENCd4qW45UhqQKamwGXe8DghKp4p7jybiW6YjbWGNkp/tG9RSRy+Oxp+VA3QAh7mrrqXqwdmHEnqQVKWoXjtQeaNa65Fi24c9jXq3gYWZFjC7GeomUn3Q1T5NaErWYBKx/6k9SBTRBSjTr2KjHqmD/+46lbeJ1+X+z3U71b3STs7fx7CJT17zMeRzw+G91CTgX+8+fEgih+f0mhwov7zL1dRYCcZNnid/7gqsidPFRLeVNTA0TgPWiOTzralgKQmCR1aTEFg5a9Zb/hObhW52I3zQ9esac6YSH16KfwFij7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6616.namprd11.prod.outlook.com (2603:10b6:806:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 14:44:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 14:44:00 +0000
Date: Fri, 2 May 2025 15:43:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 1/1] app/testpmd: add sleep command
Message-ID: <aBTaK9NnqTiQTP8F@bricha3-mobl1.ger.corp.intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <aBS8e9GZkyXiCCJS@bricha3-mobl1.ger.corp.intel.com>
 <60e02461-362c-4edd-b917-36a524670c5d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60e02461-362c-4edd-b917-36a524670c5d@intel.com>
X-ClientProxiedBy: DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: f18e4f2a-69fb-4a75-03be-08dd8987c695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUHt+Ix5CZVS/kkJ+rMzqneHLq9MmB8oXWPK/SIx+KUtlNgQLv6PCaxsOIjr?=
 =?us-ascii?Q?12cN8oHpyKIVMNlUVbIrPHPfDmslnYtGFv172Y28oB3xp3KqK21CcdQjO3l2?=
 =?us-ascii?Q?THcAGmITzKUI0nO8Q0GFgB1B3cS7AGwxGUxoAJUmtbXaNLNNRutE3GoVZ0sD?=
 =?us-ascii?Q?DoFBvg5RQtDgVp+sIUEsyLhTF3mUcChOXtHNEDBDhb5rZ1HuHW8LzV4MN+EL?=
 =?us-ascii?Q?7StXmO/yhR+l/nzK+tsDMdMbUEmw/hyc2ddvQKL6YW8S67ssQTJKknqVF8mu?=
 =?us-ascii?Q?XZ98bYUKQ4XJSKhYeK6niXPnfb4YdbUCYQAfsyr7GoUvHsLZx7G/7Pt0+5ZZ?=
 =?us-ascii?Q?s6CKW1bApWcZPmlRhmx+mR0UET5uUKosuWOIh2ZdrHcrZaupIc/mfakwkxdC?=
 =?us-ascii?Q?LeoxHSPObYZkCk66Oz8hpetUc38WYC3L27kf1xLOatHLhG9+YaJ2XTpD+pd/?=
 =?us-ascii?Q?ltLg4IHLS84C3BF2FhsInQe8W+E6Hx5jkDLWUIO0a8b40H++aIHaWfv91kiC?=
 =?us-ascii?Q?efMy8dDG/fLdltAOE5tj7oBMfV3Us0YYKg09z8hWPcLKBognnc7JVoGf7CMe?=
 =?us-ascii?Q?oCQ4ku7FrIbGZRsZMLzXyCYQOTliDpwHWe75iCcSC1lP1O+FfxjvsC84D37m?=
 =?us-ascii?Q?n0JznjD7w32FpSnnHVAW07iJ32Z7XQKHPjDK2Dci3ZEPPpWSjrK1RL2EsrQW?=
 =?us-ascii?Q?/exPcxDSzU626hsPM1bV4p/SaWtuyy9gEMskUGsWlDTuue9kNOu6qc+jqQ7z?=
 =?us-ascii?Q?n5pcxtcBxFQVKDBZcchzakPIDbIEh32shHXOpj3TxQKrO0jMZdMn4ie5W5jK?=
 =?us-ascii?Q?XKTYCw78BrWLjHjELq3jepRP4GS7XIjjpKQ/laAa6h4sHRmxeUiPBIHRyydX?=
 =?us-ascii?Q?wKWcM3kNEwtorE4BMGqsrSB2ZUmQU/Bqvuwz2FTAHndzSiMEC0lPT3s2IE1n?=
 =?us-ascii?Q?esSgAqL5H9qf4yjuiF58Z2UF1nO3NmjhJXOrcT5DDnzr1xLiMatRYVshNroH?=
 =?us-ascii?Q?3ujXnSypyHlmblypDPdwZycYnG5pK/h/gVmjj06IUovyWel4B1a88BzbFTDa?=
 =?us-ascii?Q?zRhKZ+gyLBs6a3oUEC4ESTv333UtLNT1nmCT7EZ3gi76y6pHf5fBl2oo9xXT?=
 =?us-ascii?Q?dReGv5ztC8rak6py4hKAMiIq2ufieBDyJkcalegzdauzP2rT/HBtk5ioz7MK?=
 =?us-ascii?Q?gfQIIWVSot+E+UfAC+QQN+P/AIaHAHydx0cS6PwLlQCqMvpQkDneOtErT24b?=
 =?us-ascii?Q?Dlu9+WjRcS2kyL2X56jQ79HWFuT4Xd0d5sKuPERARQEOtUJksSZMV1LpZlrc?=
 =?us-ascii?Q?bfAul28RKDvrthp1TwcwOXEZQfMxawsKkm8ggaJ07oEs0Ony67wDTFXxfl5R?=
 =?us-ascii?Q?0y+DyTxE+cZov1OR7jf+BYAj8WxljUADDDWVeVXO1qGBZmrfaHtpLZzo5Kt4?=
 =?us-ascii?Q?KHf2pnBK7Sc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4brdEnlLkscIEykoyTrmyoJrssbU0/JQoJkGbRZd+pgd5ZKB7MqDZ5JG56z?=
 =?us-ascii?Q?pBOgEwPqCVjJf0vl94Po0Uf600DFRss8/v8inXrA89Qn2aZL5Z9Ko8QIG8Jp?=
 =?us-ascii?Q?80Z0WpNBLZpeyIpImBCv8LrmENpu+Zw9tLLCcipfhSyXXEEZOQVrLbX5etit?=
 =?us-ascii?Q?J5TvjHzt13Owu60IlYZnaG8IiY7DysY+pkIN9Yor2mjBEdIClYX9nPTXxGOA?=
 =?us-ascii?Q?9VKYG71jmUeWJQiP67TcoSTgUbR/9j+ocJJ12oyH6Be0y+kEYURyMUKeEZK7?=
 =?us-ascii?Q?d58z9PNL4oSKIH2WKoLY/iJvDoJT/4pWd5KuyGIWn5+RW1suFT6bHLBj5Is8?=
 =?us-ascii?Q?EuSG4H4zE0rv/7mPAVTLnUtpTgnVBSsC6AvWitl2vATRGC799VorLZeN2twc?=
 =?us-ascii?Q?sLqYqm6a5Bb7QkgiACL/Ac6YLDADo6mXzUtpHAQ9xX7Gc78apKWEU3deff5y?=
 =?us-ascii?Q?0dN7aG4fFfYsertAdR8jaBKuPVg6MJq3fUjkOztmxe1Nahxfd8RyX7nViEKv?=
 =?us-ascii?Q?Kad/28X8DpBLXx33zohAEStzoD703XukPxMvG5Py5UPn1jkS/dxBL1ZUteJv?=
 =?us-ascii?Q?ik0HTzcKs4xkc4mj+qk4RTHZ8taNT78BQahcU2+kXMdKE3XPMFxLV5xBvAVG?=
 =?us-ascii?Q?xZZVmOpXNGPh0qesc3bRDRrGuVSlEIDLL/C4Ox6uzP5Pxt2/S1LsZiZTAfNP?=
 =?us-ascii?Q?xiRf3Ua1kVei5p/yabstqfiRzkvgpu9lIMdXq2lZhZNsp0sIfPPmalKkv1QB?=
 =?us-ascii?Q?kHnFb4Xbj0UaSa4ydnYki3llRtAqn1yUExSsfzvtsHfCRcxprtrI03cF049J?=
 =?us-ascii?Q?Airo6ZhtPCWJbMZo/5N38mCOn3TGQpgK5QHnKVdsF8n27+KW24NJ6IUpIBs6?=
 =?us-ascii?Q?P6POiskfMVYvB66ymDtZ2gqdnGCvYbWXgXwX4RN6otvd1FnimYEZXPNemzv4?=
 =?us-ascii?Q?WPPB2SfP266gfI3sStj98sfio9IFCGROPJ63aGFaxZZllNGg4H1s1Bpv/7pC?=
 =?us-ascii?Q?QtB+ivLwL6JEJ1ex1JQasXWv+ycP+uyaBB04KcDjCX2t9tuCVQaK0Xxyum3E?=
 =?us-ascii?Q?s/ZIVmbpOdMl7gyCDRk2fGA0Gw6FUfaeNG1LawjHYt/pt5oxqA+qiNNnlIjY?=
 =?us-ascii?Q?J6m5dlyi5/8X85PQ9t2cM9j5NJgxxSiDpkTVLD28XMdQVc1zf2Ld6vhE9uTQ?=
 =?us-ascii?Q?nPdllw8oWPS78VHOWTKSM5KYKzF5QDznqIq98Tk418Ytk77G2UHJIQxF/rge?=
 =?us-ascii?Q?lFqzohv5Ghicxq2qxYgZzlvqDZjxsop32MxiCjLKoEJddIHPvNhJD6/Sprdr?=
 =?us-ascii?Q?E+0zdbM3/Tx5RyxJtaaN9ky9b1QT/0myssnnh8vcGElAo9NpqoUntMBz+4eF?=
 =?us-ascii?Q?SW4CdHVpl4Q9uVVC6ge8+xGkqZ6VnDUsJ5D+dvYDG3KpCpPluSPUAzhZC6h1?=
 =?us-ascii?Q?CSbif547tEKzHSKhLTjBx6X6skYhCnq18toy9repW7wkylYN3MAsnO21Vmk6?=
 =?us-ascii?Q?1llZ+boYzbNqcVohaPXiHd/VVDthdaF7lUKmNJFbUlaZK+8p7NHMx8l/938N?=
 =?us-ascii?Q?uSvVHFfxY6AAVdSElqW3aTq8QEphi/QXoH3uxMTl2zWyglWeNGwnoyRpbOnM?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f18e4f2a-69fb-4a75-03be-08dd8987c695
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 14:44:00.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJX+igpbByvrkE38W9YGqFEwjcux9XircMutjCBDpJxUY7qdr9EhBFOdpGIwFI1/K+rphc1bR09AUPeWPxIOSIf9xd2WRDEerONgHgLWKt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6616
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

On Fri, May 02, 2025 at 04:35:08PM +0200, Burakov, Anatoly wrote:
> On 5/2/2025 2:37 PM, Bruce Richardson wrote:
> > On Fri, May 02, 2025 at 01:27:29PM +0100, Anatoly Burakov wrote:
> > > Test-pmd already has a way to run a list of commands from file, but there
> > > is no way to pause execution for a specified amount of time between two
> > > commands. This may be necessary for simple automation, particularly for
> > > waiting on some asynchronous operation such as link status update.
> > > 
> > > Add a simple sleep command to wait until certain number of milliseconds has
> > > passed.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> > > index d4bb3ec998..1e429e6d0a 100644
> > > --- a/app/test-pmd/cmdline.c
> > > +++ b/app/test-pmd/cmdline.c
> > > @@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void *parsed_result,
> > >   			"quit\n"
> > >   			"    Quit to prompt.\n\n"
> > > +
> > > +			"sleep ms\n"
> > > +			"    Sleep for ms milliseconds.\n\n"
> > >   		);
> > >   	}
> > 
> > A "sleep" command, I would expect to sleep for a certain number of seconds,
> > for compatibility e.g. with terminal "sleep" command.
> > To keep this as "ms" granularity, how about making it explicit as a
> > "sleep_ms" command. Alternatively, how about adding a usleep command? [Not
> > sure "msleep" works, which is why I suggested sleep_ms instead]
> > 
> > /Bruce
> 
> I have no strong opinions on what it should do. My initial version *was* a
> "sleep in seconds" command, I just thought that maybe someone would want it
> more flexible. I suspect that actually "sleep" and second granularity is
> just fine.
> 

I think we do need to support sub-second sleep granularity, though. If we
only add "sleep" with time specified in seconds, I think we'd also need to
add in usleep with micro-sec granularity too.

Other alternatives:
- have sleep take an option 3rd parameter of time in
  minisecond. So "sleep 1" is to sleep for one second, but "sleep 0 500" is
  to sleep for 1/2 sec, and "sleep 2 750" is to sleep for 2.75 seconds.
- add floating point support to the cmdline library, and then allow sleep time
  specified in seconds using that.

/Bruce
