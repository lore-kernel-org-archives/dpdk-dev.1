Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77BC982FE
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 14:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1EA8402B0;
	Tue, 22 Sep 2026 16:10:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 7C17E400D5;
 Tue, 22 Sep 2026 16:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790086231; x=1821622231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zB4gpA1iq0EZfbsRakVV7a2s6ZLmpGuqcVvixbrUuJM=;
 b=Y3E8j/z9OyWfwHvjN+d4oBDzjpdVI2gVaQfAjXSBr4rmLbcQbfiA8h+1
 rup0yv17NUIAAsCo249IRd9JmTAmZBA1FTR8PhU4ylUlSr0BmpEF6Thzt
 i969li3x2F8QEO71hxxITY3H4BRBxFbg7jgML5uFHYZMC8dcv2pdxl8rU
 gHU6Nm+wnmsh9SL9NTJ/pBpllYLK+YT8klsCKv/KPIkmu04Im2PEV6O7w
 KR6PY7xSkqudqofu+GWk5lSuet9UU23TQrGdi2pRtOigsKamM8+XDaIhf
 fa0qX3f7tQcqGrrlrDWdvKgpivA8VWbmqc8DsOVjLNVuhR3WTIq6uSvpe A==;
X-CSE-ConnectionGUID: +2HtE/S4Sp2QgLNXmdF6Vw==
X-CSE-MsgGUID: LlxK3upFRwakneZtobI4Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1199888"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1199888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:10:07 -0700
X-CSE-ConnectionGUID: x7oXlZuFRWu0vx/zNjaSfQ==
X-CSE-MsgGUID: wAkyaDI/TyK8iMgsqw9Kgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272349573"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:10:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:10:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 07:10:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJzQ8FAjjI0VfNxh5+P1vH/5Up6b8jtJtUNjyGfZsmc01vxkxffWF5yXS/G1rXUNhXzbmwKKpW1KDHaEe02eF/qKzjL7Gt1xAXKKtnMi5mGbq36QALXxDSYFtvTN4huomE3xR72oU4r+Ca3XQ5GYLFdmjJ5/AY32MBdzXmj7xWGA6fqjiAYSxFCZri4q/+xMP02YvAiSMjVoIu1eQdeJopvhsIqM94jVTRAat0MMbu8NmjzyTZnVMqBd/bempBGJzrvFh6LZO+InYD56EOZOZnEsrBkwFCEJi5uRBX91KZnv9rZBnJw5rRLvrfKN9GSImy6xqy6VtwoMpInawYBHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICG4yQWmwQcdnAfSAwr83LA8E90sTPa+eiOsPKzFpzY=;
 b=QfMHYtNwBhpctBngK7vdL4LvNYmXEsD+W2ltLx9QH3wvvqJ8hE4Do4T/5/Yl8/5r8/pWHZdQad0At8stvTHmpp0jfFsZ28kchbtsdT8acS7tBfewO23zFwrB2W8fbIKWQw0xHxP/xPi6FIzlJQtOECXfRsI0GI/aAFXypJVGoU8McqXnzVEp/LJZiqVx5CAlHkmTQwdzRPNeX9NKxUwOro8as7DwbpKdRZlN5RGbUG+sindPPrArASInkixVdGvKko/JUYl+d1HepiuepTniP9JhMglfGk/BDW1POHv+4CNv9foGaFdCan2B7MZb39I/UBad/HS+81ZQjFyC8pdvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPF1A7C623DA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::816) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:10:04 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 14:10:03 +0000
Date: Tue, 22 Sep 2026 15:09:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ring: remove internal devarg
Message-ID: <arKMN5dwo0PD6teP@bricha3-mobl1.ger.corp.intel.com>
References: <20260922113614.2952557-1-bruce.richardson@intel.com>
 <20260922063401.6f2faa98@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922063401.6f2faa98@phoenix.local>
X-ClientProxiedBy: DUZP191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPF1A7C623DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f441116-fa06-4300-bd50-08df18b3326f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6oCNT97X/x5N5AWoeaQZxyHLTTSCYqpzA4/OZVZHyFi0x/A91VbyzanYbeqf4Iw3YJIGZp1j+Kmbn1QC7+v+HCR0HJ4MbtO1A3yQqCHtHLsiqyAFC2VTW7TBC8zZoDwLWT/EQ4qd7WPrbk4LPjd7kuuWTYVIyyI1qF9x+Znn2CWx/8Rkk7fC3YjmT0wXCR183El+MNgeoU5UH8mhPreiDsb3UbyT1ZSigV8euer403doQ0QKURdzLrtwjX3FxHANGHVsNhPmFgjkeukuOM1VrXwFXwMxMbr3ZS5ykxqGl7M2e3dn46p2yBJgEEFOpoLnZhLpwUzIhCBnJwYJs314ChVgsMx9cHeqY4VZJlGQmNQChgPYihIay9GycDejNE1do0+p2EZWgDm8Pj7T2WOCuCqgtvXw3AB1bL8PI6GmTDHU6fjXDZv2yubuHbFdZukzVfCq1wr8GrVtlyrl0RyWopXd0yA1Lp0+RTzPTP0JS67eKDGX0gmreGn6COcDdA3JkfBBsmC+LKVhVzl+lrtNSeLLUAb28HLjJizdjm2XN7nrfVjJP7SThHRB2uUEAN/rBGHcEWld6Kr6ClaHcEiCsRr5MK141m3eciZ+4JNpzC6VRh2RxJXwmNwcCDXkmo/6cVAy3BG+DFyVESfioArcElwehmi7AtViORqV76Narlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yzSSZXibnG1Ij4/LaRHgifWbh5LcqnCUCsmbDvekRznG717e6G7rZ/ltug0?=
 =?us-ascii?Q?2lRDUU6e2ZG4Z1OrtfofVEDj1pacZv3Bq/R/yoEoxrtxywcr19ud9W4DxO39?=
 =?us-ascii?Q?muqTxLdDvKeGmUDL75yeU8va3GosA1UKPEdtiVcsg4KmTKakq5/opL1zHj96?=
 =?us-ascii?Q?LlZJLfuc5gAiL9cghR8px/2LgbnxZ0efBGyM0msE7f8sP7XiE+1MnE1yFppd?=
 =?us-ascii?Q?YQWLlOWqXHYNHRT2QXuB4qYUt8GcXqFIjSrBMck7QQJwvDLR4MnznFuIBu3e?=
 =?us-ascii?Q?HHx57PrZtor7kbwTggQg5MYclP8j3X7Ty0a4uc6pyZ6SwKH1yJaNOsMlUmLM?=
 =?us-ascii?Q?M+wo8vgeku9v8rSAUSOBjScGjQeE+Vw7qyyLLefbstMxWwJta1dHFyM9Ys9J?=
 =?us-ascii?Q?3PfUhzE69KOoQBvtUbpj++xXInKqgPwGJeh3N9cyVot8yekI8kAogbNsw5DT?=
 =?us-ascii?Q?UrZjb13qtnFyp8tLY66sPfB6wmryQ8xFMCNi5mfYjkOiyTYPcpKd8TTS5Ex0?=
 =?us-ascii?Q?FfZO+dzJfKPvcSdodMhFhiQ/gOUCFvLEAUpYQRk5gldUqJi9t3zISmKHlLP4?=
 =?us-ascii?Q?t8/OIn2v8Uhm5pb4iPor3GOEMYuy3dNRt04vJsdlzTAEfFlRdlhYtGmuc90d?=
 =?us-ascii?Q?6POCegx6BsoQ17Sa2leB/Z9UX1zhIlOgbUWZuY7PDdV0cKDd+ADuhLuMXHMM?=
 =?us-ascii?Q?A0JkJ0v8yjPniPtVbGD4QJs7sh/FhxXAObEGSoP6kpQMZe9BtNtiXVblFgvy?=
 =?us-ascii?Q?vaKmYZzDFoJt5XdQ0BwkH97FcXYkitYtiLTKvoadTHppzyasi6PvP0seqFt0?=
 =?us-ascii?Q?IxY24jljlAOPFbR8chvKyCU+XEaj2nlOMj1a+xhd4lcpSEmU0Hsis8yXlN8h?=
 =?us-ascii?Q?AnwZQ5kRdYFPcQQNxgcxPFR+jRELQwJ4DagDv9zjyse2P5shD7ZNiDtOM7eZ?=
 =?us-ascii?Q?qyxaP3TrEocvTzMLQUlIeFNLlYQuGl+iVfCujLD6zppJZBavd9Ink1UZhxV6?=
 =?us-ascii?Q?LXoz55g4j3NJSf9xh0LyfKHTkLE6FvvZIrx+PwGT6mT3lIHRrSWiyWTq243h?=
 =?us-ascii?Q?T3mvIzhRx4WUiyfoHvoEyPxk5ABex+5oiFqftkDLHpYFIsMZfAWJ5HVS3ILX?=
 =?us-ascii?Q?FmknvbGK6OHg1rqjvYjXkMgNSt4y7JDas2Y/Cz+lA621oM8OuXmRuHRQOlCD?=
 =?us-ascii?Q?0zTzxr9iL+MoChj5cdYoHpj0L6zdkaqD0eJjhL4vt37t7cb5Ljpd7mGJUQpp?=
 =?us-ascii?Q?yQjSrPSnwoLQwKtYViMt5PiC1lXRHB04HjszSfruSnSBKdu0Sq4QWM2+gHQK?=
 =?us-ascii?Q?CLM0UQnPbYu8kvzySDI0bB01Zu5GvEbHA1SBPLCN93+bQNY+9ianc+VlmxB8?=
 =?us-ascii?Q?CkqCvWDwwbybI3rTWjFoNhPYWIzJOTqQvK+MdXAB4AJtUG1ViJKie/ZAU83O?=
 =?us-ascii?Q?7ZInfKvmfNovY8H9C4XwC6xPEvnzXKDFMplFYd3RNX1LF2eY32fGU7seY/nC?=
 =?us-ascii?Q?yl1WQcMxDRkaBnz+m6P0fiJiVKrw9K2vraikUxw0hIoVdPDk2tj4ESG0gS8F?=
 =?us-ascii?Q?Y75I03TeFJgtT7q2lbrLZutEHSYD3n0oOfmRbbbN1xDEHI6vHYVt7Fxfet7j?=
 =?us-ascii?Q?1/sPYRhWcu4u+TmFAM/YySleh8y7PkQMQ8WieQHXetg6+3YWBz+GBMi70MRh?=
 =?us-ascii?Q?Y1/WEeu3wY9YDfaopQnHVlitNzDqpUU2ZnKtqn9r78Rs3qEEjGScyiA4uddI?=
 =?us-ascii?Q?IXgdLPSJ1W0MGJw6oYuI4TLfVdnhvWo=3D?=
X-Exchange-RoutingPolicyChecked: AY99E+hU6mgKuAI8VeZ1C2/Tsn89cBeCp/UD79Myy1eqwYz0qFE2xK4p2n5mkgYsis1Iu/HMLaVJSQB52r/oGyk7GmtIHI5MsXoRBLkYjHG5m7KPfDIg/FSAwYRnHJeVhD912PmeffuF9PdoF0LGRoFtnhBc2PV9ikew7elKe5UkLpP+o07+C++VDUvAviprFO39DUpsU5xxytju0EO/VsDQ5tU4h6edgbRrPM19Own03wz5gxZz9Nj2aQ500Q2fmd3E3PWotUCLIWJMsz0nX/eaW1S+JPXd4sQGOIK4ao8R2JXiMhhuyQ5MOI5B3oK2faXUbRz8N6dhpIECI7Rhlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f441116-fa06-4300-bd50-08df18b3326f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:10:03.7709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKESG8m+3Bl3s2dl81oHf/e5281nDoN6vBkujgOEIAFDFxsDLHINNPSxpxZcoZLKkn55gcY+CZFBpz9XknO26mvGK2+o20BeW8l3NqIUBO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A7C623DA
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

On Tue, Sep 22, 2026 at 06:34:01AM -0700, Stephen Hemminger wrote:
> On Tue, 22 Sep 2026 12:36:14 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The devarg "internal" was used to pass a pointer to the creation
> > function to reuse set parameters. However, this meant it could also be
> > used as a devarg on the commandline leading to incorrect behaviour.
> > Redesign the passing of the args parameters to use a per-thread global
> > instead. The wrapper function sets the global to a valid value before
> > calling the main creation function, skipping passing a devarg, before
> > resetting the pointer back to NULL when the function returns.
> > 
> > Bugzilla ID: 1687
> > Fixes: 96cb19521147 ("net/ring: use EAL APIs in PMD specific API")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Minor nits from Opus review:
> 
> Review: [PATCH] net/ring: remove internal devarg
> Patchwork: 169914
> 
> Applies cleanly to main, builds with -Dwerror=true. Fixes tag hash
> 96cb19521147 verified. Removing a user-reachable devarg that is
> dereferenced as a raw pointer is the right fix.
> 
> Warning
> 
> The per-lcore pointer is still set while user callbacks run.
> do_eth_dev_ring_create() calls rte_eth_dev_probing_finish(), which
> fires RTE_ETH_EVENT_NEW callbacks synchronously on the same thread.
> If a callback calls rte_vdev_init("net_ring_foo", "nodeaction=...")
> the nested probe sees eth_ring_internal_args != NULL, ignores the
> user's devargs, and attaches net_ring_foo to the outer caller's
> rings.
> 

That's an unrealistic scenario, is it not? Having an ethdev creation
callback which creates another ethdev just leads to an infinite chain of
callbacks.

> Clear the pointer in probe right after reading it:
> 
> 	internal_args = RTE_PER_LCORE(eth_ring_internal_args);
> 	RTE_PER_LCORE(eth_ring_internal_args) = NULL;
> 	if (internal_args != NULL) {
> 
> Keep the reset after rte_vdev_init() in rte_eth_from_rings() to
> cover the paths where probe is never reached (-EEXIST, no driver
> match). This also makes the comment "consumed and cleared by probe"
> true; as written, probe does not clear it.
> 
> Alternatively add the vdev name to struct ring_internal_args and
> require a match in probe. Either works; clearing is simpler.
> 
> Info
> 
> No test coverage. app/test/test_pmd_ring.c could add a case that
> "net_ring_x,internal=0x1" no longer dereferences the value (it now
> falls into the "Ignoring unsupported parameters" path).
> 

Since there is no "internal" parameter any more, I don't see this as being
necessary.

> Double space before "*/" in the comment above
> RTE_DEFINE_PER_LCORE.

Something that can be fixed on apply, I think, if it's a concern.

/Bruce
