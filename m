Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E385E8537A
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 16:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E8A40296;
	Fri,  3 Apr 2026 18:08:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 656694028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 18:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775232526; x=1806768526;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bRu8v7qIZrlEDClwOgL6OJy7C9dsq5ph9msojFK6v9U=;
 b=Dn0TTaIlzJuVQ8t5t+VJ3t8k4Cs74TDvsQwLB987/7IhM3i9SERJBxiE
 WMYVqaHcEqGuRXxuGyn24p01U+1+FxgDNVs2Y8S6Hdl2Z7e02I/xVmGOq
 zKitKQtGIyLLqTufYkzdgKnShXRNRd4Wj7TrIDV5lcFMZGeHo9sVOEzKa
 68S+vH0Qh5hkdNdz0V/z49vIxUOMic+zvQxFz7d3wbbWp1Yp1wfWbOCmu
 qp0MIpstVg3Cs2vpCeQc6fgP9mI929ZobDiaACjmJReaJH0Yinv1ipb08
 5qZzeBMAKzERM8ZlJ0CmixQ16WVOdl23ri4sS8hGM7hjSTnM7CFpW5BMU A==;
X-CSE-ConnectionGUID: +a24Yg7UTcWsiUQSBbJKZw==
X-CSE-MsgGUID: Hk9XelnaSF6ohQY3FDdWcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76313689"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="76313689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 09:08:45 -0700
X-CSE-ConnectionGUID: Ddjg2XSOQM6jOi6pL605Dw==
X-CSE-MsgGUID: xQF6jYMCSr6UR7jwFMXJ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; d="scan'208";a="227532740"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 09:08:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:08:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:08:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbeSFhUFhIJYZ8J4TsuQN8qQak2jkOwjAyl9xizdir70/om8uI7F0Y8xlIqfbNLE9k80nhQk9Mx5Esltchcozgnad8uU6SAU563n4NvbHwaiQK+5AS3dGmk1PHNfMdXBiG44QNyLY2eSoytZeUDtb/h+vv+QGUUs1tCxRluKfIvGzJ+D43BxZoxVcd6DF2saNZTUrwRBz36El288eDdGqvgKYyAOyJ2djhegHtzxlucM4Tjk1nVmIuTjCgQkiYQuzADeCMnE8gS9ayyb97myhZC3MYoZYMEppl0FGVzk6pIgQEnbA/zTN6GQKR1rHPZFw7k32ROsZEED59RIDau1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHcwHapv/HR51E6ns8Sipbll+eAKmRHNXDm1pZ8ZPfM=;
 b=L+D3Rbs2EDGK1lX/y4WZY0UQna2SwKmqJXI5Ck66BY3T4QxxbouAtEwfBYcs9YiRv7l9yFDJag3Km6ImD1BII+eRZ74uSH2Auek5AKq4rqrGOOhj5UMOWNI9Pf9pDe+3FFe9zG6e77zWxbwYFB8kfAP4rRX6xLRle4GaU7NwAd5dXfZls7DygY7TKyKpLjq5Qa/FctXesYPXoKz6F/KJmy11QjYtn9iGjowGys2I86CbNugKTqVjAhWi/OPFB7hPoBInRpEjf55UgwCYB6DzchTtqjeaoPDH88IzVmtu1AaWFh+ZLQDbmYNTCfIMjI6oa42sz/XG40l+ArYDaaT+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 16:08:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:08:40 +0000
Date: Fri, 3 Apr 2026 17:08:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/4] net/iavf: improve VF reset resilience
Message-ID: <ac_mBFKgkjqfaP3a@bricha3-mobl1.ger.corp.intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331130120.2471971-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 44495c93-ca01-453d-8e71-08de919b4597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 592ni+ymeElW3fZPwlZ8kIr2uhzj0w+hXx0nqDFlK/Hxea79FjX73kILGRefH+ZqoO3fvrxsBASvtvAiZ+H15/lL3ZjFfflfC2g4RuiBkBSjbZWrh0W4HahvsQVABLBBr8H34OkgwRpRbuyTrbK4qe2InyoqTT1JpaEDJnM9Q04ac3cOqJFjGkpBM5oCGkDoPR03wVfIFIhkR0qZrlrc08pm0G9Gv/kB7UltC9Y7pbqIjND7Q5AUW8pjWp7tsmanmo3Cfm3Ugn/eQ+++9/sNwcvj1cJq2QEkP+FPuT/2V1FraaarZmJp4GyY6MFpSmJK65xfBJTlGHdnJOVxD6n45RsXnLGRkPryNl8o9nGS0HlaPtEfXbZ2hGK6IuBAIIYbL1JfhsMPkSuHhkaBajHeKvKJK5iU8omDavkJWlAy1Zfq5EpDXGDT4yOZMxci3HDwRGN0R3zKee+Rg8TCy7Mv1ZgknipVLijmM+ozryIlMvmXIsQzPsofaaJVQr9QX9wOGQ40vlBSx8rCnJBb653edYugxGQfMyIKZYTNR4ioPIBgKVbd2JHRStA7mdLLA6RJV8e8oxhD3EpI7XHWrwjzhu3K0hcsvc4gMp3vnnHeeuoDWyCPCdV5V8vhJV3D64UVmzdW/3wr+inbQ6ZpuqHIG3ssYSQSAG8QAP//iDyL1OuyXRI7840O2YT2kY9YKvPzKyDGsdOJ/d5hvlpXuLd6q0RLvlnwxM/J0ISWfCKtfAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWvbMXDJ0koZpySjrQVbbMOsiodz23mNGJylgnhQ3DFPh1+go8nX9PLZvbDu?=
 =?us-ascii?Q?isfN+NKCcSnY/HfkaMhj6Coy7cUMYY3+AQmdOA5FInxchGPXa50vkFgzLUW1?=
 =?us-ascii?Q?+mMsmgTq7iTq/oK+Zm0FrbHv1rAAQBZ713i8YsN0y7erYCooKON9GW+HoVqv?=
 =?us-ascii?Q?6OZGr2gjGJVTgNWBoB8BOpFR2a3Gcf8Evxn9pRHZGGOfZSRzTdgylocvx0Y+?=
 =?us-ascii?Q?tSDTbdhltOKvphnn8BdA6DpvRbLCkItv6kbL6mVBOIh1/Uz2WXnGnxckFKKj?=
 =?us-ascii?Q?KtKdLnirKtFzgTSq70qS9BFXVRDTTEhogIzF3YhvY7Lqpd5hNfG2tRniAH+U?=
 =?us-ascii?Q?epwSt67Hd9zcKYT8tyzYb459BTvdm+1X/DoV4c0TFvDKpQIcPiiUeWyYGRgn?=
 =?us-ascii?Q?RGaNiv7jzJMGqdID9SWZjkzRnmUmfJYgmeFE50UcvY0YAG4QtRAcfgVZ7s+o?=
 =?us-ascii?Q?Vz3ap8gzsxJKYfpbIB7VvLoXeRnZm98wqwY0Owq0uYPVUVcpcQ+vASczMQ3Q?=
 =?us-ascii?Q?zRNvHwKWJrTDw5UyBPm7ZMGEgH1k2O+Ebkaz8LmrKMhcmx+Ei/078YivSyba?=
 =?us-ascii?Q?n1oziD4uMHOUtrT2D06dvGdQHOg0Lak48uEtJgQvBLRYvXnVIXDbqG4ukWv5?=
 =?us-ascii?Q?ubracNwzWVX+yfthj/XC3OM4xRjb0n/AcRvUnRtChVWSb++Px5gItQFAlVex?=
 =?us-ascii?Q?ECz+N55+IS6izzYJCxNqwOjV/R6qEceVfVggSAsBRK1Y71oQNy29t1bhouHH?=
 =?us-ascii?Q?+4G2gNfT/P/fWCwZgyW22oPXDiiKf15GCebXSfnvXb/0ibBdfKBNVWVA79ga?=
 =?us-ascii?Q?hW9QzFfYr1DXq7S2BYyZfTPtuPLvkiIfs/aHBwd1n/Ocv4jR2Rj7G+1RuKeV?=
 =?us-ascii?Q?lneLvc9boqV6exnts9x9ixMeqngzu6ukk52485ySSyl+kJhfYyFPkEMD7gK8?=
 =?us-ascii?Q?5Pzh8aze8++N2P33FYgQV+xhRcwuTEgVlSo613iGP1qMdzOayWisPeOaa+Zv?=
 =?us-ascii?Q?HHTMwagDuxRfWhXuTHI0nPXj2SIzcQeemoJLratO0NuCsPAeyu6ADjjtwyT7?=
 =?us-ascii?Q?k6PsokCIAzsG7UYi0GB9HTzxd2zGrwu04THjsAc+rzFFQJckPP+6N1qRVbJ3?=
 =?us-ascii?Q?xjNLZYQIv5rfIrZ8aaJSFLa1PaEKDHt0FWWUMPHV3ULknEjN9DSTcAyS1QLz?=
 =?us-ascii?Q?fJKtWKBC/RmqvWjIPtmWhagv/1LEpj5ttLRh+aryk1osHqgTuigXWOsa6bo9?=
 =?us-ascii?Q?6Xj1sDVC/T0VhLW5+WOsLylNTeOY/08JvZ8MMRwQxggDOfeMRs6qzf7nBp4c?=
 =?us-ascii?Q?AOsR3qtZFa/mRJqv5SKaMfpnXhtJNVekNIh3biLlGP8jRAa4Zhi3nP3x9pfd?=
 =?us-ascii?Q?cVBEDCN9k6WkV5dbkzKmJxYzJRpVuzZtYTVfeC+kQ9dLE3tfqGxfJST3Cczm?=
 =?us-ascii?Q?ZO9u+BxOxwljtjYPbctLDXi3j2FTAZHKfoQ7PGmb8L/x3LxkFxF1K29n+bXq?=
 =?us-ascii?Q?gOEa5/GiD/0kT5bYLbwhXRm6ZCHhmztwNohtOi81nBnoq7B2nJUWlGnOqmJC?=
 =?us-ascii?Q?o1SooFWAfi+2XicTz9QR48C6pTN3RwT0ybjHn+Bt02KZ+ffuxYgLk0jdygWr?=
 =?us-ascii?Q?dY6NpGKCnZuFutCYHdIRICXZU+f84OFuZyk9kASCJYvBNfwFBu+hSW5ZJtIr?=
 =?us-ascii?Q?Qnka0sb+SQCoY8vv9ZbrlMkstH30T4pKPGmsodkCBAkQwNL+GMCE8NCmHn9n?=
 =?us-ascii?Q?ZtVSlJiLZXluWLbBN4lWurTuQeWFQJ0=3D?=
X-Exchange-RoutingPolicyChecked: lHnllc+5QYopxvVidahHivbWZtgJC+h+QmyXkuoSTD/lxEf02+v9Zq472VDTiphlSRm1/FZwbaync5vo2sAejWam//lXrLERmqi2jbfq/MKzskAfLPs58jwyXijprsdVP93ujKoQVt8Cp82oYXm3kiGQg9Vr2/lXpY9Bqs8n9gz1Hf6o5yToIJaSO7/HocthOGB7wI0iqnfkReX4RrUoowbGy7AnNlS++AJFAMc23m449b5Qb7x28yzq891TIMBz2LQ0qc4ahzxCnjtP6INpLDcMF+8vibaytwfl5s9/G6s8IDjZBCm24AXeOSCColQ4+5wPwBA0GAfrWf8A2Y6b4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44495c93-ca01-453d-8e71-08de919b4597
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 16:08:40.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvE35sXXJAI7V2bkGaQT4pCbCNs/7n9mDL+rGW5JINfGYIXpH4/eQYz5h/jRA6d5/BNIRC5tXVDQ5113mcNRg3kSWSzFnZPzvpwNjcE2Inw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
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

On Tue, Mar 31, 2026 at 01:01:16PM +0000, Ciara Loftus wrote:
> Previously, VF recovery from PF-initiated resets required explicit
> opt-in via auto_reset, leaving VFs non-functional by default after a
> reset unless the application handled it. This series makes transparent
> recovery including the restoration of settings the default, and
> implements some fixes related to the reset path as well.
> 
> Patch 1 fixes a regression which prevented promiscuous mode from being
> disabled before sending the RESET_VF message to the PF during device
> close.
> 
> Patch 2 enables the auto_reset and no-poll-on-link-down devargs
> by default so VFs recover from resets without the need to introduce any
> reset handling in the application.
> 
> Patch 3 introduces a new auto_reconfig devarg (on by default) which
> extends the recovery path to restore unicast and multicast promiscuous
> state after a reset. Restoration of additional settings such as VLAN
> filters could be added under the same mechanism in a follow-up series.
> 
> Patch 4 fixes a minor logging issue.
> 
> Ciara Loftus (4):
>   net/iavf: fix disabling of promiscuous modes on device close
>   net/iavf: enable auto reset by default
>   net/iavf: enable post-reset restoration of VF settings
>   net/iavf: fix reset handling error log
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

