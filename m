Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CDCAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 07:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F77B4027A;
	Wed, 17 Sep 2025 09:48:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7975D4025A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 09:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758095286; x=1789631286;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ypXH6fVm+MVX3oEuGC/lcH4DlcdeKlm+IMRWft0ySPw=;
 b=dytfMgAJ9x4+uiZYmHwlpOz7x0/yyMxJBrqA7HS6XbVSA31oqAPA1QRO
 Bhn7SdcQgHq/YpxOnvNh9HbRMRd76PGj/I6xiaXprRXk36+wpwyFVxzbq
 gUbGNRT5HAXIH7/W/IP3WcV8a5WwbvRStJQQAYzha9I2DJ76D1P7Tf00f
 vMk7pN+DW2+CYsPMNYtFlMyJbDmMGOPDDoLi6spatqGXSGUafX3rF20MV
 broPyik1lrMTDbnpZ4VTHTO5bjoD5/QOryst9SV7UxAnjaW8LGa6IuhV+
 ngvDA94KosCtxR7aKTXeLYNj2ZEvorffeLQjX92IpnkSTGtG4qq9WQy3k g==;
X-CSE-ConnectionGUID: XmorxRBERGmo0SeVW57ZFA==
X-CSE-MsgGUID: UcBSlmcyTWWqJ/8e4cbg2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60319632"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60319632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 00:48:04 -0700
X-CSE-ConnectionGUID: L+sI6sRYTvGUejf9PD3R3A==
X-CSE-MsgGUID: 2w1+FUmaQXKpbBI94YTJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="212326602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 00:48:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:48:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 00:48:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 00:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URWK6GO50txEduuoIKTzHQIObILF4i7Ti49cYYD2pldmhkQc5X5TqSZWSQQmVLACzPSE3LU39wfvfCSOxCM2Qya1/EklqZq+O8uuz8hfKmZlWLnDARhbTsGOXurfRvOkzwSQfpkf+pfarnzMGC6i/3sNsE+HRjlonb6hTykD648h/n5b5FMRg41fVZQkyhN8z20H3368fwClS9y8kChLxMOtuH/3BeyMfmQGDkgs+2bvx3cAmR/RLwgS2r6cmh9of3Rm66q2DTIPMi4ifvwfwm7LBSJ2OPvIHZaSTLqf6fF/3fldA53GhfzIRnRxOe1VrAbqUwrWOGT79Rl2axrmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3kDGyq+TkYlQhzuw1CM1QTDQycCas0QQ6TGtIKkVYY=;
 b=Vqnc7u0SlGZk3dKUmA/6CM380jD7amhoNoB9PvByAGtTuUfm3EKs+lKrQ8JAdpEr4ydhoT+jBz2K9jgqMPgEYHk/HkqQ9SYdTG8NBuBuCG6xWB7KdEXJSh7kmTgNTcA3x3Rw3fV46an8JRFbtU32g+4BVh+1nwYyE9+kPlIvnRFQ4auOdKXL4gQSHQATMTsBJ0xf9qn1G96It/X/mXwZvOSXZ4BUggzd7uCU0hvMBqqi/usnZtrAYW5nBS0BaXark3lff4e0KiCkmH2QCgUhAVXpjgihCQ2cM5wZX/jSQXEIC/zWxWGd5F3aPjd/iqpHhdT+xdnc7il/8rFXLkOwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:47:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 07:47:58 +0000
Date: Wed, 17 Sep 2025 08:47:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ola Liljedahl <Ola.Liljedahl@arm.com>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, "Dhruv
 Tripathi" <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Message-ID: <aMpnqVPUDIsCj0zI@bricha3-mobl1.ger.corp.intel.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
 <590A2369-28AC-494F-9E27-7CA9C670426C@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <590A2369-28AC-494F-9E27-7CA9C670426C@arm.com>
X-ClientProxiedBy: DU7PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: d67452f7-af9c-4831-b535-08ddf5be8517
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h0taW4iBUBBuM8AY/nFiX3qrwNA5drFC+hHlOkTEwdyQ5Mdep13my4GJCsri?=
 =?us-ascii?Q?nWc8kcvUzUnHfc7WqCVnXWuY/YY1PhhR67NtGqxR82vaNApOLL84Za+nC1zC?=
 =?us-ascii?Q?hSGq922QwrET2/KU5Lv/4DpZg9ZMP7CIWFbrLbegGO4fm2Q5AVA7OoC8qt4L?=
 =?us-ascii?Q?1Z8THrMgj4fMMShAINs8L7OB0lhY/b0S3pRYjqYKPju+0dRc3EY4p45rxmrU?=
 =?us-ascii?Q?/K00aQzRz8Zab31Ii7hPVK01HGUsvEXYPWY/qqEtzbey6/zQwQG51LSj2mIK?=
 =?us-ascii?Q?KrbQwY2L78wBxGevIpX8f+x3nQ3dG/3fOwJydwDJukhpTWLG36xNHDWCPWqN?=
 =?us-ascii?Q?fdiUFn5oE2pXf72tcJ5IGPNHITRy74X/e42uhGn5E5ygd1E4+WiARMrHP4RC?=
 =?us-ascii?Q?xuou9m5jBeskCcTJ6KDCb7AmaVhULuodIoyCgf+eVTV23kQeHVv0GmCh+d8I?=
 =?us-ascii?Q?FLyg+D4KFBNJgxVpf2Bby8fYyM9G3rYlohAooUArAYiRvvFuJw+/MaAZEiwi?=
 =?us-ascii?Q?AC0uk1B82ulwA8FRmO9XUkMi3OWVLZg0LutZoS7jUpj+ZzjbbBz56aLR7tO8?=
 =?us-ascii?Q?fgJQnYGiMOiiXrykd0vBGC/Zyx9Cwwcl5tfy4Sl/i76lXlTci8di0duNo8bo?=
 =?us-ascii?Q?bUQUKyBW6dxswBKwgMtkObTXqLFPUYqXpew5Mbml2BMJtl2311s40R/NSO6W?=
 =?us-ascii?Q?a+K2PF7S9hk9mfjTdQZrgVrj8TovddUd5naOQ6B1xyXi+meVS7Kdh025MSP5?=
 =?us-ascii?Q?bKJnk3RQORa2sBNo56bUKSpTsLRxEw7P0KpQ7Gn1S8hUz4TIVkqwAITLcB2S?=
 =?us-ascii?Q?K1DjHytcAMca9YbaNHthm+HKJq+agFUmIzZaVal52bfEln4Yx486Q3BntL9B?=
 =?us-ascii?Q?A3cebbC0yr8ayuCoqAtf1quRBepfUa1Mw8nc/LquArKkp0p9YQfU20+LXDcB?=
 =?us-ascii?Q?JZta8CaH0jvFF9ge8obKtbq6btyzrJquDKb33XZ6B1uPciZBXfXjYiAdZ2qf?=
 =?us-ascii?Q?I35uxQXt0RbkleMDXHuGkNJLAlP/iZPEMS0dHfnq6UN6uXmi8E1UhN77pUVd?=
 =?us-ascii?Q?+1rvUoijM23opKhYU66jeCHuIB9z3ETc2hfzwRrRujmOpU0qw4Qc7Mff9xni?=
 =?us-ascii?Q?5uS0JW4OW4fkbvqpV5E4CtIY3WJKMOkdwky/QsJC8/HD+Ix1Es+nCDUKxDb4?=
 =?us-ascii?Q?Q+MRl/D7M6eoOYnDObijDAufm5WbYfKR31AiPJ+nbKPvIBVHxCnvmItYLlx0?=
 =?us-ascii?Q?TbWsFqn6FXcuj49qnPcDLU2yuaRvfvgwmrAFqAdjsCDR6o8eZwCtpeUGP7+h?=
 =?us-ascii?Q?keX164TZwrpLghVo96GW0brXkzhdLCd7Qz1Easx70J7KDzRASre6XJTflE17?=
 =?us-ascii?Q?6eKVkkp8ErA+fH6gqAqZxj9Si81LZMotpaR+cu3sKcYRsKp9gcdvBNyrxncW?=
 =?us-ascii?Q?ypSHqfz4uVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVYtZLgtOE6p/weoKJ178YbcHFcyPiMf6lfywf8e2GXgQ3uk+lTWFRqH9w1H?=
 =?us-ascii?Q?gxi9kbNsiLpmtEITUd3Fje/sBSrTO1jdiIKbHjyqCGKfHtIt4egfZkh8WTmL?=
 =?us-ascii?Q?PbhRDP8OQ/g731y3ayOGxcnxl83NexvomS/8voa80v7I/vAb9VsUOCI7Siin?=
 =?us-ascii?Q?ZYeOl9MiOWw6/cYZjHNcCC8ZEpwRjaP6orhjCcKsNQtp0AH+TP4YLJaMEsg7?=
 =?us-ascii?Q?la6M3dileIE9G3TdmGw/Db7bJqhCyl7vhks4pZegR4j7Q+urlx3872aYUf6i?=
 =?us-ascii?Q?HSYu1+4I/cdFCavygm/QKWiCcPOk+eD7YxecrHygC0z9/yhCpA2IlU2z/0qP?=
 =?us-ascii?Q?82dAs7geJ9vLMrWrD88j7UYCR3DR5USXP6YPBzxKeIyIgPcxgJYQpV5LjBzl?=
 =?us-ascii?Q?tha0bLonEkMP9hPnf37fJHyRmjE7kD2V1KGkpeqAaclQr/FJYpS/iNZGaBhc?=
 =?us-ascii?Q?hlZ5IkeKXKxDxd/4QciuWiplM0y64usgoKAm/XY8HV0fts5g+dkerc5wEzk2?=
 =?us-ascii?Q?t9wjPxkPTLUr5sUa2j0lNXm1s1KS3FxGaC/Ba62+DtBwC1yCQuZ/Bp62ZOnO?=
 =?us-ascii?Q?9rxoadVN1G3tGAlRUPlPUJVoe3uz919ivOhg+x+N5u/L+U8/Q/sjvYgmvkTY?=
 =?us-ascii?Q?tucqCgFQd7xX7BK/Yzk4uSptf93bo2yU1XeuZQ6fTVDvM0edgxMXQk8wlCJp?=
 =?us-ascii?Q?qL/gJ81RYryseuuPyy3sXtEl/PeaIMXQds/gPsKOY3Go5mx8aMTmKV1OYmT3?=
 =?us-ascii?Q?hQTsmS8XpuSik/tD4AUh07fAX2Vegs5WIpdI7DuE/7b2T9m+yTmvx8PvcunV?=
 =?us-ascii?Q?SnjuXXbJ6vC9qGNnajvVwyx4i6isLJWtJGXO6KBONVC8Sd7ahwI2pJj0xnD2?=
 =?us-ascii?Q?dxWkv5jk+dGOsoM6QsqqJaqelN13R9hIHU3eUftP5tAAGv8l9ewl8rz4wWXM?=
 =?us-ascii?Q?xSVazz3XnxOA/YbCJiQwHPbbhn2W7V7bE+RYCxBZS9Fw8pvd5csm7tferDW4?=
 =?us-ascii?Q?CMDn5iTQADy7KaRkhbl6oRyJXgOexcv74DO6em4Abv8lJP+CUhqgNBM3IHmC?=
 =?us-ascii?Q?CuTiSxPGpMZdcTG5niubtGZVKljtubVPvDk8SUuPPDXDwh/l0fFZU/TRqys4?=
 =?us-ascii?Q?aV7EVoc5WZEKJ7y31MjM0Yy3n4ylKkeVI9xNTxASyyF5/7EOaN7YXL1e6ZH3?=
 =?us-ascii?Q?uD6HZrZB1App/cfVt4bYpfLZEjQ87nx21o+YPIXJ1MOSazAE4Ly19gb573Wt?=
 =?us-ascii?Q?KvFmbTP+mIECIEmsuVBuj3dKzirZs2aZTgvTbGpY5xgjaxOJ8BwalFDjaxqh?=
 =?us-ascii?Q?kLW26mivsRvafyEflqhK2z2Qevzoouj2N6wrqx9QJxV34XSCBX4CzOMNyUcK?=
 =?us-ascii?Q?KRow3TaxFSCjL1EUyevOSaHxaHkVaVzkCKwznxzgJxdRNvVfYVcJDalDQiuM?=
 =?us-ascii?Q?Z8L2Kl6XL+2Es3Qhml0V8LNjPH5GOMBnGc+sxF74CybydhKYwSoKnOLx4HlC?=
 =?us-ascii?Q?BBg4+lI7X++OGV0TMgieazJzYE968HSOupHLggjLeYWj4WB/RQUkx5aIrtdZ?=
 =?us-ascii?Q?DtplQibIT/p2VgyLQlQIxE2hjl3EtZqitCq4r6PBtM49yNCkb6HnoRarHbQ+?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d67452f7-af9c-4831-b535-08ddf5be8517
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:47:58.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FLl4So07WjcjZQi+jPXuJ3djB/Dqogwca/6DxRR3aUOTbUCZS6at34rOb/fiLtqAgGCvEz4Oi8To1eRgRnpb0G9hRPBmAiBoeQplIep6U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
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

On Tue, Sep 16, 2025 at 06:19:41PM +0000, Ola Liljedahl wrote:
> (I am sending this from Outlook, I hope I have been able to fake a proper
> email client)
> 
> > On 2025-09-16, 17:43, "Bruce Richardson" <bruce.richardson@intel.com > <mailto:bruce.richardson@intel.com>> wrote:
> >
> >
> > On Mon, Sep 15, 2025 at 06:54:50PM +0000, Wathsala Vithanage wrote:
> > > The function __rte_ring_headtail_move_head() assumes that the barrier
> > > (fence) between the load of the head and the load-acquire of the
> > > opposing tail guarantees the following: if a first thread reads tail
> > > and then writes head and a second thread reads the new value of head
> > > and then reads tail, then it should observe the same (or a later)
> > > value of tail.
> > >
> > > This assumption is incorrect under the C11 memory model. If the barrier
> > > (fence) is intended to establish a total ordering of ring operations,
> > > it fails to do so. Instead, the current implementation only enforces a
> > > partial ordering, which can lead to unsafe interleavings. In particular,
> > > some partial orders can cause underflows in free slot or available
> > > element computations, potentially resulting in data corruption.
> > >
> > > The issue manifests when a CPU first acts as a producer and later as a
> > > consumer. In this scenario, the barrier assumption may fail when another
> > > core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
> > > this violation. The problem has not been widely observed so far because:
> > > (a) on strong memory models (e.g., x86-64) the assumption holds, and
> > > (b) on relaxed models with RCsc semantics the ordering is still strong
> > > enough to prevent hazards.
> > > The problem becomes visible only on weaker models, when load-acquire is
> > > implemented with RCpc semantics (e.g. some AArch64 CPUs which support
> > > the LDAPR and LDAPUR instructions).
> > >
> > > Three possible solutions exist:
> > > 1. Strengthen ordering by upgrading release/acquire semantics to
> > > sequential consistency. This requires using seq-cst for stores,
> > > loads, and CAS operations. However, this approach introduces a
> > > significant performance penalty on relaxed-memory architectures.
> > >
> > > 2. Establish a safe partial order by enforcing a pair-wise
> > > happens-before relationship between thread of same role by changing
> > > the CAS and the preceding load of the head by converting them to
> > > release and acquire respectively. This approach makes the original
> > > barrier assumption unnecessary and allows its removal.
> > >
> > > 3. Retain partial ordering but ensure only safe partial orders are
> > > committed. This can be done by detecting underflow conditions
> > > (producer < consumer) and quashing the update in such cases.
> > > This approach makes the original barrier assumption unnecessary
> > > and allows its removal.
> > >
> > > This patch implements solution (3) for performance reasons.
> > >
> > > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com <mailto:wathsala.vithanage@arm.com>>
> > > Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com <mailto:ola.liljedahl@arm.com>>
> > > Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com <mailto:honnappa.nagarahalli@arm.com>>
> > > Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com <mailto:dhruv.tripathi@arm.com>>
> > > ---
> > > lib/ring/rte_ring_c11_pvt.h | 10 +++++++---
> > > 1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > Thank you for the very comprehensive write-up in the article about this.
> > It was very educational.
> >
> >
> > On the patch, are we sure that option #3 is safe to take as an approach? It
> > seems wrong to me to deliberately leave ordering issues in the code and
> > just try and fix them up later. Would there be a noticable performance
> > difference for real-world apps if we took option #2, and actually used
> > correct ordering semantics?
> I am pretty sure that all necessary orderings for safely transferring elements
> from producers to consumers (and empty slots from consumers to producers)
> are present in the code (I still have some questions on the use of memory
> order relaxed in __rte_ring_update_tail, we should create a litmus test for
> this, to see what is required by the C memory model). What other metrics
> for correctness do you suggest?
>

Not suggesting any other metrics for correctness. I'm instead just wanting
to double-check the cost-benefit of taking the approach of putting in a
fix-up, or workaround, in the code here, rather than actually correcting
the memory ordering use.  Also, given that the workaround uses subtraction
to detect underflow, are we 100% sure that we have guaranteed correct
behaviour on counter wraparound at uint32_t max?

/Bruce 
