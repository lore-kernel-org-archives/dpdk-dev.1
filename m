Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F55CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C08F40DFD;
	Tue,  6 Oct 2026 12:47:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C7619402A2
 for <dev@dpdk.org>; Tue,  6 Oct 2026 12:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791283644; x=1822819644;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OQb9OzNo7EbfeALk5mHA+9bqTwlOXBEvr1UZtG7y7SI=;
 b=DtORpyQXT8z2hpYErKuaiQ3Egj/xVdJ9a7a8vPrdv8oiJg1YYgZI3aih
 Q5A+jEFbDTG4GcAo2TFQTqqJ0cLLLJ1hvTkwpuz3W/VOpgPX0WjwejTEm
 /KrocIohcSUTZWAKdeCNJJNPE/X4FtvSoll81ghhdztcu4sV6kOo8AkzK
 VgY2pd7gmuI9xbhVmQinHlI61341GjBTWI0WN3iKG1CpodtTbBFN+71dE
 jnnYD4ev4qF/cp+eXA9pXbtDkwmg6SQZZcAYC3XwK3fiHgPA66SRpjS5E
 4w293weiJ5lJ4f6iqiD3wY1GE4E3iDsnABhkHt1Y52wkNahyCEYJ4KO5m g==;
X-CSE-ConnectionGUID: 9U/A+KngRNeCPVrFkrcNfQ==
X-CSE-MsgGUID: OrTpwLaBQimRMQpK3ysjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="27156"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="27156"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:47:23 -0700
X-CSE-ConnectionGUID: nx2Wjc1dQN+5bTv+Dtp4uA==
X-CSE-MsgGUID: gkIxveyZRq+Jtvvv/02YHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1186601"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:47:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:47:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:47:22 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/swBNHPQr5i2eRdw0aSp4tEfRIDLrChzxI/FJriw8ZwGBPQwYaq8+J3cBltAyR/3qaupkoUKOgM561bp7DoxmAcJ9B0FSExczzyi8h56kPY3nKQ6GKXNe0FNtfaJh60S9Ls8lQ/Q2QsE0a7v/oJEkVyL9vp8m28RHdedFWcKOBFWDN7VgDzLjhcmNdVmUZqUn8kSOlXr+z2oSsAKHemeYd3t1HRt9uFzouQKeEKELibb+4rlrson0CR0bDPXm/ypmP1nWPDQH8rTon4Ro9QpSQHUfqO/hshBY1aCYJitfKyirIG66OANGaJcG4zMge47KYqtVDWF/e1bO7YFrd86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caoaDH1eojrpCWekiud2Ln0SuOYKI3xlaUxlVYjjQnM=;
 b=bQNa+MTfvBtxlMaHc+5fCdc0MltX0zcm3dKk7+u741NSPFGeOHCXoUFJEz3JNnXU+UL43A+Eh1AOm3CDtpKvCq451i4O14emgpNIaQgYZqdokv7dnP1pUOjpDgisNXGMpGwe+kbDInnLAPzvpWC4K16rrv/vIpDB/QX8Epu163TvsP0ddBzm97rsUKm48uKJF8mFkaX0ApGWV6BdSNPCFG0P3xjy73dCi0GK9zk06NAfmMG0cVryLzMgB+ol9QPaWdy1s4w+vKJQNkR8lKHj9EPiEYMfDd7rNTAUjlULWB9rIYDTBKP1d6lVZs8IoRHm+kchkfgvrwWJb4XcFgr80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 10:47:15 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 10:47:15 +0000
Date: Tue, 6 Oct 2026 11:47:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: fix unchecked Tx time context allocation
Message-ID: <asTRrur4gQF2Bbj_@bricha3-mobl1.ger.corp.intel.com>
References: <20261002021937.391321-1-anurag.mandal@intel.com>
 <e5809107-013f-4f3d-b1ac-741eb6788b9b@intel.com>
 <AT6PR11MB0445268173D71C808640CEF8A2E4952@AT6PR11MB044526.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AT6PR11MB0445268173D71C808640CEF8A2E4952@AT6PR11MB044526.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0270.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: c5eae2cd-cf58-48bb-675a-08df23972f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l52KgCenmahJFphzndMNTrgMg5rGmkEMw29CVs+F/lq67xOU8m3uvO0u55BbikS/53HNc+rcZISeIHKbKXfwatKmyb2C029ajkXHeOgXNPoNFTzbZkkKP7g64Lh5o+kJzulqyDwgKkfvU7IkatoqIs5QIeOVjwA1hi2/nMOnLeUEpe1QcySXSKSw6wq7yqSDgT/JMmE1AAi+D02PvnBy2EKlF50UvdCJyJpJHc+Y+pt11Pm4A0+nXz/zpjKMK8yNbkUb3+KUTd0ziBELTDoNllBl+oKQmhbDtjpM1Pu9mjYDDU2WKrGXefb/Jb5NE72lhj39Y2TZ0n/idkz8+Q+O2BDdg41mZtpNMzbLlroM7VuVuH/7ursomToXX4crT4eB3jh51NTPKdG61gfr1dL2gT6dwZih7ZJ87Bdr/NVs/OERx4Tue6TVkFGZf/3nZ1R7wUU8Li1gy6UO3uxFUwQf3/eSx9htxI6nobIbkh2eT56my8yG0ZyuaO1abAW7LRnJhjxQmUKcndqKFYOl7/pEIzbPMRP/5On23QHWSjfNNXpQaC7HnH5Npl662iobZwh20Vzxw1DoMkiaadkmW1iI/FenRzGxhDOEddw5tUvlotcWo8MJaE2iGCLtE/NzXzcXtM4gFdZr5+o6KRPacWgRius5ItsQUbSQk4+UsVg14zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4bqV65n6mOqc9aP4GV/boANLykzd2zeWdrXqCY6HCmu1aQLGuYxDyhNiV0H9?=
 =?us-ascii?Q?cMwavkNgh0e8Nlr5tTZt+oFvJJ2oM1I9ga9b9jdjed0d7WEc9ucaDimUFXX+?=
 =?us-ascii?Q?cMr68zj+8pOImRnOk4ZvcNpW30LFDJ7J2RetAdar4GJ0yPWwKZO4d/8gMOi7?=
 =?us-ascii?Q?qlNp1mE1eC/1XFcoIBJlvIKM7ywT+6hi83VvyKo2UOjL4b7ETGQrpRU6nJiK?=
 =?us-ascii?Q?JoXBLK2aOw6xKZbmq8RuIy2WBqk/Sd+0Ebm/ZQ2dzcUTlKysOredPk9BH/qs?=
 =?us-ascii?Q?qO5uX6joIhkykh4fTgzdxBjWSsFIEhs6/bc6JVwRd9AuiZeah21TZS/+OWQz?=
 =?us-ascii?Q?to85PPKVvdyGQNEhJ3g0lAosURVI+qiP2B89anpaledcYUkmPN3WqTi/7PYc?=
 =?us-ascii?Q?3b0enwmoMKetB0/JMljPEhGOVetTBqKTFFeXPtLq6C+dj8MXer1iG/zqZNQs?=
 =?us-ascii?Q?y/1juckusxg6rX+kAD3pV/AOkpWvMTSeOYn93j4mxjGpSuqZdTBhB3t3LDjR?=
 =?us-ascii?Q?WQww+Y7EjvAM/GTw/r2q59K8WYl/e1VkpZcNSAsuCuJJ2HIM58/PLkhuJ6dk?=
 =?us-ascii?Q?gsvqHnh9hJ/jH1qRO8d9YVGRvFbGeQvWTPLez38VCh5lr+79Q7cXCERpe8Bz?=
 =?us-ascii?Q?aimzWyckE7j8P7yjipLplKdPMwCakgnf8ZYIvJf+8u3XSre2cjTg2t8U4mg5?=
 =?us-ascii?Q?NdFf+GAKhcJ5uHe0hckqM2miIVHJVOS2qVbeeIhq4iXWDtKlungEIZDLzFo7?=
 =?us-ascii?Q?dfpFMBQta1Rgz2ExbLIJ0l3Jf9uZcbjbpUS2R5hPFMbs9nSZBp1GShEbsKI6?=
 =?us-ascii?Q?uZ+oj4T94PTW36Ek38ABh5/tn+CDXNvAFkYaAah44e+vzNoZwVFZ+EkN95Fv?=
 =?us-ascii?Q?mVpAARrJoV2lN8pbgOUZsbtx6P00j0+VvistLPB/iyo657TTxbR5oMmZhhyB?=
 =?us-ascii?Q?+cuk+JLUQjaWefzzGuwtk3QEmhazlvcftCFgLD3b1ohOXl6lMzEvDmYLHB44?=
 =?us-ascii?Q?Y39YINhr8vMvOvmGm4nBzlXKMfzHK0bcqLT8fggSI32r4kFBGIWwJNyGmgR9?=
 =?us-ascii?Q?op6pdlO2mHXJOlNmdUAQNcMMpNXUXzbcrMdxtth7GBPdJWoccgtI9LSB8ual?=
 =?us-ascii?Q?Gsp20HitnuTvjxAbXpajFnrNWq16pv1Sjz5obAlCR3BEg5OTKCVp7wOPybyj?=
 =?us-ascii?Q?wPCipTlB8Fva/9JEyopN9mNyWKSsxbFcPd5M5oqntaPGdBB2bHiT1Vhl2oWj?=
 =?us-ascii?Q?8Psy6vT1lcNEiIq7sln4H2sqNQg97z00mRQJa+FvjKsKAc/pP9W8R4ojTA87?=
 =?us-ascii?Q?NgeUsq+1L8vKrks+tCax5f2H1DtuevMAN+57Z34aEdAKpSwXTlx4iiE2Q3So?=
 =?us-ascii?Q?/MiFda+hXUKj1CYvoHEdrdpoDmlQ7ZCMpgGh0bvBePg86kBREMc8SzxIT7rl?=
 =?us-ascii?Q?V26Ys7BWM9LrrYUHhZyMk/+7fZua4qFU1AhrdI1lJW9xS6ZHTNi4AtwAE2Ok?=
 =?us-ascii?Q?GvDf6KA9PwtgcIjCnI5BAIp4LHli2n5VrvRjsZSQhH9XrlfVbXVDbhoSF20M?=
 =?us-ascii?Q?jB3Tyuu8A30WIBWxNBBL7N6QxsvqoFRhhyCsaAlKEzPj1pYLlPypGxO0xG5P?=
 =?us-ascii?Q?alJnWdraqFLjhOSAg2TWAW/nGPuo4C6C1kwI2fjyX8rwv61pjXtlA0jJLpyn?=
 =?us-ascii?Q?J/V247eJBBn56grmvpp0F/lCsPFR65XIDnjkZ0/lPHlY5CJwuKj9xv+LAPrh?=
 =?us-ascii?Q?xidZTLmiN+ARfJFqPAJKj7zAwVk6pWo=3D?=
X-Exchange-RoutingPolicyChecked: yNn9Qpf5G+3c0q/o0E6yQjFgleaxyL9VqGAG8F9oo+qJB2oZxPtAaNato6MLhcTG2b8LpylGbD/3cPnzr+XvFT0t6QwNFhWrcbwvDrQmUQPhHpmxgbLtfx8mt2E9jb5Pz9fNdhqGh7f6kh/oa2wT05SpXWBPtSF1YMP1HgpG47wfJuYDVLzHPTdBf4gRhDqoEvlut/m8NgXAYikGGRkv6BdgXIUJS3sydUXRrSWhjCHjTne5pAy1yLkbwGoaT0Gm4hAch5BDHRL1Q1PK1E9okrHSmqL9FL6Lkr95QwwIDvWRMc+prw42m/MvTOxqdnNtCMyTR4WLLdc4hpGM9orEVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eae2cd-cf58-48bb-675a-08df23972f31
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:47:15.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUGmqrtz2+TNIOyc0FC24AWzIKRwjqmi5ShS6WXfNNMIsZNmR3RKCngIrrRvAmJTex18thqs+zn/WNzf7+zgzJqccU81U4MN4uBNxzxL0+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
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

On Tue, Oct 06, 2026 at 11:36:54AM +0100, Mandal, Anurag wrote:
> 
> > -----Original Message-----
> > From: Burakov, Anatoly <anatoly.burakov@intel.com>
> > Sent: 06 October 2026 15:33
> > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; stable@dpdk.org
> > Subject: Re: [PATCH] net/ice: fix unchecked Tx time context allocation
> > 
> > On 10/2/2026 4:19 AM, Anurag Mandal wrote:
> > > ice_tx_queue_start() dereferences the Tx time queue context buffer
> > > returned by ice_malloc() without NULL check.
> > > On allocation failure, the E830 send-on-timestamp path therefore
> > > crashes instead of reporting "No Memory" error, and also the already
> > > allocated txq_elem buffer gets leaked.
> > >
> > > Added the necessary allocation failure check and freed txq_elem buffer
> > > in case of failure to avoid the memory leak.
> > >
> > > Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> > >   drivers/net/intel/ice/ice_rxtx.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/net/intel/ice/ice_rxtx.c
> > > b/drivers/net/intel/ice/ice_rxtx.c
> > > index b333444cbf..873aca0100 100644
> > > --- a/drivers/net/intel/ice/ice_rxtx.c
> > > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > > @@ -898,6 +898,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> > uint16_t tx_queue_id)
> > >   		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
> > >
> > >   		ts_elem = ice_malloc(hw, ts_buf_len);
> > > +		if (!ts_elem) {
> > > +			rte_free(txq_elem);
> > > +			return -ENOMEM;
> > > +		}
> > >   		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
> > >   		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> > >   				ts_elem->txtimeqs[0].txtime_ctx,
> > 
> > I don't particularly like the fact that we're allocating using `ice_malloc` but
> > freeing using `rte_free`. This works only accidentally (because `ice_malloc`
> > resolves to `rte_malloc`).
> > 
> > Not a blocker for this patch, as this is following established convention in this
> > function, but IMO this code could benefit from a separate patch replacing
> > direct `rte_free` calls with `ice_free`.
> > 
> > Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > 
> 
> I will be sending a separate patch to change replacing direct `rte_free` calls with `ice_free`for buffers allocated via 'ice_malloc'
> 
That would be great. I think I'd prefer to take that patch first, so can
you put it in a 2-patch set with this one (reworked to use ice_free)?
