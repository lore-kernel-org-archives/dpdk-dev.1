Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C53C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64024427C0;
	Fri,  7 Feb 2025 09:51:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 31171427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:51:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738918290; x=1770454290;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hp7VbqhsmwD4hmZPC8rw/21lkDqb6mpjJ6OH6SY6AMc=;
 b=RGFpg6d6814RQ14dSsR/hRI3DsmXoe60IUM+9KKpBdNWpnIZj/sg/2zV
 YHK2U17p1E6IukOanw5uMCE0vwKOZKTsg95tzGTkhlcxqi3/E0pkOsk3z
 w5aPgbIS5vWrsmieShsYYaJnedqNf0C74RjtBbilUCcOnBsz0L2X8EL4k
 QzNP0pUJ3IhAS8Msy7f4SBAWvOso9tc12IwSc6Hra5yjpUfhSyenuVB9h
 qbTBRSzAwvswl5hlV1XLVjbQFzwBxn5PVrqie545kVwpcBLjUTrgRY6/3
 SvGJbz1HvKnJ4aWwQ08iviHVkPYR2koQ8yiwAMn1Ud9DZ7j+e+J2hSs2L g==;
X-CSE-ConnectionGUID: SIqtiagHTjCjvTTL39Gp/w==
X-CSE-MsgGUID: 6bqofspYS1uIR0Wf0S8X2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39426739"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="39426739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 00:51:30 -0800
X-CSE-ConnectionGUID: pomv7bK7RcGOXL9lk9hbQg==
X-CSE-MsgGUID: mCemwg3DRSWKfiHvNtGhBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116408528"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 00:51:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 00:51:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 00:51:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 00:51:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktcd4XxTgTHqku2JQNRbyOhNvq8QKQh4Q8gMmAC7lTp+f8XF3Y6mlBrne2rbK4VU0xeDkvmj9EbiPKPmHvAW9mZn+JScv0IbBpeiSNexi3Qd3jfztod9hiwl+XJ4Sb/6Qz4Zk2RR9nxKcLxo9qYFi51LBOTNPAVwF4addwWUrhcHIZlNC4tQ1maoNLwUt4mkxtGkgwYtWDnWwnOJxAZlSYMp2NUq7PLcG6OVr+BGDszTH+wIyz8Zjruj5AjznGRoJUxpg49rTeo4GXbfi7NI2LNXa4LeZCpuWG9UP3OQrhshUxKBo1oVvBsdmFAEHZC6rDlUHmdLV+EkhHMFKyUTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQGSbEUzErBXzKLZD57Ert9Z6oL0PLLO9n+Dy2zQ0gw=;
 b=VtfEKVkwFjfY6Ru6r0Ox6QenkbPWFer2/8sAqj61t8QA8AR7OdfTXWdgS5o1PMnA/rzIH+ktbi6G7p0Nw7IZEWZpf/aV/lzOAOGot+NerHYRYveFp8YCqO32nW4zVufaAkkPLCnwpFxy/Tlu+M5of8wloPJKF9rExcrmTWcqPWJjmZOZA33EWQj7wpcOVEWacgSsS2fbuFeYQH1fnXC3PTpmn4hXiZZCNB3Tp3Fdtwz1eZ/oQuNi6n1LxdPijWM1JtzzRL8GTgU6HYQI/6bpiUxHp5LTkgHLNNiZnRvZGVmUqttiHnoXt/hp+c8RTrO4AhqOq7LVrrlAsaGgEjj4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 08:51:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 08:51:21 +0000
Date: Fri, 7 Feb 2025 08:51:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>
Subject: Re: [RFC 06/10] net/fm10k: remove weak symbols
Message-ID: <Z6XJhSeiZSmNQNSN@bricha3-mobl1.ger.corp.intel.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250207083252.3131588-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207083252.3131588-7-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0278.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d3c844-9ced-4b91-fd63-08dd4754987a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dqMAHYK6enS1DbpaIcyMJYyd5XH5C0HGoOYcPSKz3D8Z0VVFg0hVIy9ip/HI?=
 =?us-ascii?Q?7GvJ2coculO55Uf9/fgCV+e/CutRz38qHN7NQTuP2p9kZEM2upoyw3uow5qP?=
 =?us-ascii?Q?ewMChJMwZD+IAdupy9U7TRtWQvoPfXcn2+3MA6twVyyRx6VvCq4PT42ipABh?=
 =?us-ascii?Q?e93F86K3DYcy9Fpv/k62uOjat5Clbfhqib5QbAzt0q99a0prLItNdHwlzRln?=
 =?us-ascii?Q?p0jhRWLdorBCyz+bLw0P9FQZpRkNzi2iD56FF+slEgvcaiO4up8tvnvb6Rfl?=
 =?us-ascii?Q?H8n103xQGMakavrI5d//1YpVCSeADoh5BUn7d57NFYdxOhiDyTvKYxcM9Bq1?=
 =?us-ascii?Q?xm0bXiqRn2LWA17X8AoverkkNodNB7ghjmL9XkIfK3CjyIrdbZGkoKXn+8R+?=
 =?us-ascii?Q?6nJsmy1LVvnt3mcP+cazZG3tPypnJ0sje/jb1O+YgXwH15+M29d/ZVJLpI4D?=
 =?us-ascii?Q?y4eFMGFUBKEtJ/Nxi3LoP4rPFkghRdsY+EbEBKy1sKTb5pAzbTBj7GZpMHP1?=
 =?us-ascii?Q?M9JCJbOO+mQ7r7J8uicatAJgQ7HrjxQqWsDYXOeD5wdhvxHYj8sRnsTktWec?=
 =?us-ascii?Q?y4U0Ridyhnr40HwNwJ3iTDafOlSzcj3UzDCjQC6sPJrMqDm7FoeNOsL8BDpe?=
 =?us-ascii?Q?ZqRJM4cP91PnUVMONYbL9k1A5DUFHQGWX5IF7MRNbXqdf6wvugQxpSGoWhqT?=
 =?us-ascii?Q?zncPD4VVRZAj2sNoLO+OUNaigfAiDF2MXLGAYEMw04LxSUsNS0eEDH138HYJ?=
 =?us-ascii?Q?8WcyO9cPCFZsBo0qHWMZF9xGimrAVa31nu8LJh9ls7nCPNLYZ4HBuXy/bMoY?=
 =?us-ascii?Q?xnrir7MvCwuQY83q5kelX5WP3IMda1eS980EcjzBGeV2dc/ozna/6+gL0rx9?=
 =?us-ascii?Q?tJI0jKo+57CzOYn3dtC2Ol2YCUujGr3Svu5cEKGwa2LD869Zo56WPETz4qnr?=
 =?us-ascii?Q?T9vMfrK2a/LSePctjAqResJj6eo3nMkT5k7RGyAvjIkmsjfjNdFFaO2SGcdR?=
 =?us-ascii?Q?M+lYAoMXt0/qK6Ke+OBtOpUz8zN00bp7LKTLj+vDH67QXSlrzjA/fBZvnrZp?=
 =?us-ascii?Q?Jhl75HDKgo0jaPzL9y32wQN8HdNVUbx7ZkLmaiZFPofTDgCuz/cWeu+asjWr?=
 =?us-ascii?Q?klxrxirDMLlgdQawYKu4Xu/BRRzi08KeCQmJjuqlzROthiiApZ0brZlHNL8j?=
 =?us-ascii?Q?spM+Zk11xSRjDixGEMB9R1ISmAu/z3HhjBsDniiSYLnzDP84fbH+q67ubFO2?=
 =?us-ascii?Q?CJK16pd5VmwVVmSIrpNLd+iNPvq+/wfMQ9zXEOyXdevyt4nQMkGwdh95Kn4H?=
 =?us-ascii?Q?T/2k3b/w4/1fALDiUsfEmBeYJoaYq9c+KSLEjrz5SHu029bKf2Amdm8j/oGM?=
 =?us-ascii?Q?uTNeCjwQSH4lSS95lhXGEQQkPT1V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+vv90QUjLRDGwnRxigXyabfOIsjk3k2JvUdGYZK9hqhoR0DmObaK2LwtVa0?=
 =?us-ascii?Q?bNMok7HVBi6x6xphRmlKk0e0n1eW8sh/v766Aq8p/iylZLshvaeGMOP6FtxM?=
 =?us-ascii?Q?qKw6JFDd41pJ6AVZAc9V91jn7woFWBr1iKEqhg9+hfUHzS5Bw3lIKGdlojk6?=
 =?us-ascii?Q?4+t0Fsvn1OfPZkHN/rCsYyxN1j2YIfo6zZ5UHtE0f2oNLiYex/4PnHZm4iAl?=
 =?us-ascii?Q?PgmoknBOPKXR4N8BwGdUx5/6xUgkGWxQmL3eR71BdRhkB0Qret9XlIf72ZOB?=
 =?us-ascii?Q?XBw9U6Mg8jyWxHXAY0Au/ukzmWMYMq0wtZmHEHbwzYk3QNNMf+CshIXIV+b/?=
 =?us-ascii?Q?XHM1ydTlABM3s55hYjx/nqkwCaTEIAP1Ft4SszpR2GdIbb45zmvPgAqCwzfa?=
 =?us-ascii?Q?itmJatieHZYmO7i72mqOyhOynF8bS1tLsr51pVD8RnSh73eXNptoEBzV2/CX?=
 =?us-ascii?Q?cgitSPsHZopgITUScPW+SaVCOLH6bBZB/F63zMprNCv/bLryeIZoHz0kNGNT?=
 =?us-ascii?Q?loP43ui3MZqCOWscXZxmlh7/ZKBA8Vat9EbBLdo0Udog+ijQ44wQ5sOyD0bM?=
 =?us-ascii?Q?aqjlpKhmR6IblM07i7sdgqEmdjpsJfZxKHuw8MeCI0gCLZiKbr+1F9P4BbE0?=
 =?us-ascii?Q?t6iYgGbvLbD4T6DEiqEIvPuuc+J3VdDzYogGXGzDyVpQfH5SSrP9dStZQ8N0?=
 =?us-ascii?Q?2XMQVf007e1QNe2FpALvm/10haZNyrWM952nWaX2RT5Hh/9CUk7wpExpu1WS?=
 =?us-ascii?Q?Y1QacTe+Fpw/QKJCNetjAN7dqoKrjnaa/pQe8NhYeYfm4nnPgMF1MY1cbNmW?=
 =?us-ascii?Q?+7IWn0zHy31Rn6/L+n5vEB/c5VzK2MS1idKWnkgkozBgfkDiAN+ugH0poQlw?=
 =?us-ascii?Q?0W836gqLkovcYmK4xXlyTCZjy+Py1DXh1YH8Xfw5ZxzAi+4hp1PJqwGTYhPm?=
 =?us-ascii?Q?4iRhOzlFT9qTHQRipOHl2y5UVB2ewmlVEhAKNZ8gqOzzjc9pu9oZM1I0hFIH?=
 =?us-ascii?Q?1mkkHaIEv6sIAD7KYXB/pctyI47pwAyPoe/xGDGwIaeNCHFM54FZenrlUXza?=
 =?us-ascii?Q?urgZzuTQlZh1b/u4EjRNSmiM1RwCUWVkT8tQMHkAgOAIMSGMDQW/u7o+8+VM?=
 =?us-ascii?Q?VFeBfmWZ6p8iozvD98yafNnCjKWU4BYEgF/sXtw+UGwJsVKO81RvaqV6J/67?=
 =?us-ascii?Q?C+WqbaN95vzWQU2JREFad6gU+2ch3G+z7PpS86Yvp7IKrqqE+rUKiMobVFWE?=
 =?us-ascii?Q?oz19kzh4iM1tkhu9kRhZ7FpAf9nQPw1hQWKXl4I+W+QroLE2tI3/xevoUqtl?=
 =?us-ascii?Q?jo85R980WGGvEdqlVjFYEPUQ70N+IauEgAH05o88AdkbxdIM9cA2du7h0W0k?=
 =?us-ascii?Q?z1LRWbWDdZRTAsVsRE4xt/vMCyE1CmL9AnumybhEEoBS6DZerGfjvTohhuq5?=
 =?us-ascii?Q?SnWriISEO2iTT7ZLhVSIeXrMS5XmIw9SIyghniINo82zN0GCirBvXNCfWWWj?=
 =?us-ascii?Q?F2EHf7NDnDGiXypcwK3YpiSfTr06D44EjQjlnbGXH0yomiaQ1MF9OXI9PS3S?=
 =?us-ascii?Q?KiZy1uNjFBxYis6V3JVVytNkUL11jFjZprjUM7lGWZA08ekpx5Mn0vHUVnWY?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d3c844-9ced-4b91-fd63-08dd4754987a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:51:21.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkDWDyEj3pWXHluSIZ9tWHRmE8gO4+pweMG9cIbzwflXBMwiKABH5UWufozh+bBTDbPwkXvdRuahHMg3MEyaVPHyFgR9TRAsQtWPsMvbpVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412
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

On Fri, Feb 07, 2025 at 09:32:46AM +0100, David Marchand wrote:
> Rather than use weak symbols, expose stubs symbols when needed.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/intel/fm10k/fm10k_ethdev.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

