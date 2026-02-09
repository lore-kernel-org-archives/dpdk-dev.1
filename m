Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C441E81BCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 15:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8FED402C4;
	Mon,  9 Feb 2026 16:00:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 92E4C4028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 16:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770649230; x=1802185230;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XVsY1FYDix7z9KHx65bnQgoi9ASj1ITY4e1Zqe+M0yE=;
 b=cmkvNebzCiSzSzLtzuALYU+p50q6Latkij15CywPmqfXaPAtSFiRJ05s
 ZTDMkdQkCymGPV9Eww3DVuGHyDBMxcBN6dYMj5s/v70IWNo+j/lVvgD+Q
 MrEe7pffk9LPvRNSLmg5BVWbRhJW+AtWBanLKGmTUwKdYJwynBkG9C+uy
 5ctWLU6jz52THFRw31+gK6ZKOHyq8z/PnLhS94SQW265lwpYTAuRAmIYS
 Yx3K+e/X3hkocP5SEqREymm0+OQgqJ5a9e0MsUrK7ixYX6TNo+68uz/lf
 /w4u3QWqfhe4Un642QFtyyWEJIHAploHSSVJdAbuJN1XereUY2OjkQN4k w==;
X-CSE-ConnectionGUID: DlXd+X6uRfytqTcupyOXHw==
X-CSE-MsgGUID: F3cmi4RgQR63vIc1Wz8zog==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89344465"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="89344465"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 07:00:29 -0800
X-CSE-ConnectionGUID: RD35OIn+TFidwAkP+OT8Jg==
X-CSE-MsgGUID: LTSGMumWSGGY42QbzR55kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="216576078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 07:00:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 07:00:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 07:00:28 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 07:00:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y11KSRPDonwyjelrjMmRseZYN/bO7bETHRPR7dLvtlwSmwufUXC1SZlZBr9NOn3FGCdJMt6faq1QV00vMJtfxmcGlX0Wz4p/2XZn92Z6KyW9CIa/VoE38OwJNRJB+9aw0MORvvE5KF2wvbDdWr+DcU3f6If+DcZC3knSaHiVISF5Cp/0bXK69kHlNxTlFiGXBeNBWj5sjBH+pUmCBacRlalT8K82/67trtHAyD67Lkolv9giAuHX5ILj+fJ+t8IdddcipGMM6zVD3r32sPFz0noI+l978TDhAnMgUIs+iK0kHnsf5/vUeiDsPan3BfeKLJ0wzGraFCvz56jPNRn7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Epzh+hcrp+Ghl9hfrmH8942YEE2Cj6YHSDCuC5X8Z0=;
 b=lkr0xgdM7pDIPVTk3HNBNu4UfGA1by/O92l2PzI988Qfr3kV3AghO2ewwttJ487h+p6bT/zsmF9vJFXMqBJ3chDLgDFLlAhNiYzWffqo4tM3xzG/Prrz3TQaNWCXzysET0U0VJ0aMNiNs6+2xOhHlItuZLg/xX2w3bFVUEpuSMAII9P8/NJ2OiWy0I0alyuVuDQqV8c0uuAu37k6v+bKza0OVyk3lTjEZghKE5iajMT8AVoxvlb4vLsontCdEt8asLtt8U/zSq3fOAU/EdqTntMpUbxEfUVMMVO0b4NDdcdCMhk0SOxJ8moTaDCVveLGILk8yHB0yt/S0o/rCRMEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 15:00:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 15:00:24 +0000
Date: Mon, 9 Feb 2026 15:00:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
Message-ID: <aYn2gX_S9bIdYlP3@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-11-bruce.richardson@intel.com>
 <DM3PPF7D18F34A12FEC34AE8A326C0E0F928E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aYnHveC5Y4_iNat5@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aYnHveC5Y4_iNat5@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0182.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 263af99b-8a2c-497c-6964-08de67ebf43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ot1kDjsJc8Pvy4i7JQwVR7Vo+wqXzfrlDhyoWRluGzJKd51Nzp9OCkXbSrh?=
 =?us-ascii?Q?nOPIUxu/L4ayuDJiMczog5I+jRMbCe5QFi7D33HZ1YvdKRTO6BR/GGWpLQ1D?=
 =?us-ascii?Q?COQBqTvZk3knPxNfoN9mtO2DLAfB5odaJrjZWQVNWakt4gVBjQQQbhb3ZILs?=
 =?us-ascii?Q?T9DwlH52B44W42n9oJwhc0+TAGHaLO7KFaasWvxsOVK7rfQpA1A5b53V62CR?=
 =?us-ascii?Q?9COneY3G0CWznm0Kc2sbokuiF3Kpm8wTmhp59qJcqGWkhdveD+s8knH0G0H/?=
 =?us-ascii?Q?k6g9YlA131t5v4dOwMbC3Zhfpp05NRDW2I9WnGZMBZ+XUDkosFpgW1/HPZnj?=
 =?us-ascii?Q?KhNqh5D86avmVtsB8VFoIowj3JjlgxOaI04PlYhD0cUcijTgKp12sD6SpQ75?=
 =?us-ascii?Q?Xd6O+NAjJN4YAGGc6VQvZxWllbthqwiupYbrBZ1Wy7we17aT3rUIP6Gf2wh+?=
 =?us-ascii?Q?y9aAWArO9R2q2Ze8wUhufqeN+OuMyK/b3kAoX3QbnemkmkXqFQw1e4nTjueQ?=
 =?us-ascii?Q?/vLgf51Mlhx3KouLRCF1jinUNY1YrvJ9UlX0LWE/HR57CC7ubLePsQMdFvTD?=
 =?us-ascii?Q?bkDS95xCbyC91gx/D5je+XHwaLd7DLh83p9CRj8PmSD9IdqG/FquyyX6KJUG?=
 =?us-ascii?Q?KnIvab5WmC6g6WLxQRyAnJ4G2BL74FzaXOG0Aqm2oJVs8TkpFV0ejvx+URAH?=
 =?us-ascii?Q?JLB1hkuck4+wy+DRaWKrFLskcOeMyqhx23wEWy1awy8f5I08LhR7QcMTKSZe?=
 =?us-ascii?Q?+5PEslCHG05J5+Q0ATmtIq+mZtrNz4D/5dG2Z4QCmjt9Z1hhjFkhy8FRLg64?=
 =?us-ascii?Q?tBvwh1yk5uHogIIuzG1qTgb693R+nvV3s2I0pmFksF1mJqrMU4KQdu95nOC7?=
 =?us-ascii?Q?5KjvhLgfoUYV9g5l9BMT0rOlXI/M/olAWtKXv9VLagMeLJjIvO8gUZS+qDUp?=
 =?us-ascii?Q?NG/Ro8WcerwBlJ9RdhB8NhvOco3XYsqh9svvavXp5ljTM2iNrtk2HW4VqmYv?=
 =?us-ascii?Q?jBezl5PhSCoGHlNZTRy8btfzBEMxAsj3uKqB19TPlyDLqo6FpcqJqyEewV6g?=
 =?us-ascii?Q?W/mcCr9qK/pfrJCRvYM0C96abpXaetuh+ZRhvlpuCp1Kc6M0S67yXQO6K9iK?=
 =?us-ascii?Q?+B5UsyxLGW9Z52crvqpNE7YYlsSMqvX9468GqUG2snKCr9EtfHs5aXD4Ae0Q?=
 =?us-ascii?Q?pMTL3MS3HLxzxZ/9m093tfw8RL1emYuIpDrCpMpHgLwnlaHJFdcEHcdDMocB?=
 =?us-ascii?Q?QG294DEnmDEon2jyJ2o1Pi9zMJLEIPjh/dwLDk/ya4zFDRMjoKO/+KhVK6SR?=
 =?us-ascii?Q?qfmfaL2T7eWcJ+LqLCFVkMFnuQONLpubfV+WfvoYzZ3IUJYLAGc+vNd8UvbH?=
 =?us-ascii?Q?sl00a2b4TMmsoEMws4rsFvy2HDEG7Wr2aFzJBdScRk5q1MO00IBWgWFgtcWB?=
 =?us-ascii?Q?Sin0QjS3nv7p+owUEM8mfsxmeOUmZQB/xX0FvvSV9wQzxEeAvXlIOABESN1f?=
 =?us-ascii?Q?IQEMJwklglbjviJuHZLso75F4v0dnXpcHmzPau+ZMTvUOOUMq1T1zvOAfomZ?=
 =?us-ascii?Q?SC0ARvQ5OHLWhKICh1I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtdpjKrXLj08bOwBjzGaygbGgSJkhANXoFh6+WzpcrD1gwyT2qHkyUJGI/Ae?=
 =?us-ascii?Q?/gcz73O5UIDsJNRKG7D0mxlVBCyAkPR22HQnkey9xtsYl9dIP6x9CYMur0KU?=
 =?us-ascii?Q?b3wdcIlMxf9Ytt+pIvfLaYJQNR6Gdv0eVIZ5R1UZQS8Cd1E6b8mIrrlmzWeI?=
 =?us-ascii?Q?dwS4GfUSLcE+8zfpBTzwkYz9/uIZcm9qdPT2EbOSky2iGKRNeZNxnnAW0CUv?=
 =?us-ascii?Q?XFpBA8k9A5fzSfLIe3q8nxi4hz64VdryNhtyGAC4aZimBT4TFHJvodvG1ltJ?=
 =?us-ascii?Q?CbtAyukAvP8kMoqveUBz9NlpT/uyBzzuX5TbIWAXHbN4yr+h6at2gho1aYfy?=
 =?us-ascii?Q?AUML+v1WyTumOSCs/qXKIb6h+VR0BbuDaqIRXtK/GL72Ex1J359trTtdCvmo?=
 =?us-ascii?Q?Cjl+3e+mCy57Jw3DjpU4zfVQepw3X3bj4i7GVmVv/I0V9AGSWkeeWKRZAgvc?=
 =?us-ascii?Q?AGp2x3ixfJeCJtMK9UhuqgiO1BSOiDrIeFihYv9PUj8W5uYYpEXTnonXHfA9?=
 =?us-ascii?Q?8diAkZo68VdXooC/i0kWVbRQdoADAfiESmZ7UygtHnnVaAbC/Jjh/2iHrXZH?=
 =?us-ascii?Q?cA5vg8TRJkc1HC2Hv9QhqyIE9CnUrqHFZThsdj5CEsfWUfQt/WnSQHlLAEM8?=
 =?us-ascii?Q?i2liOSNE+zUAH4SQPt5MDazIwiwHj/mDfOlDdnvn/EpyCos9ub+9nTj2BnAT?=
 =?us-ascii?Q?lqbFEcB2t0Jr3vdYj9s9fZeG3wslMqtLLMjnQJA1iadkxLMlJVZ2yLc0GeeL?=
 =?us-ascii?Q?WmmLnA6H4O2i5hA5nzpXHL2Mzk9QhxDpDBCu5vZTYHjNTCwfoztrQV9qIxIV?=
 =?us-ascii?Q?t8bFwBE9gNfZT9Fk0TZ9I+EMaMyVn2MRr1kYbU+6qwb2L417fi4D9vZFkBjZ?=
 =?us-ascii?Q?rdWrovPWjLcPH6C2Tc/lqcYhX5x5DWntQHrfq7coGCNBcKfd9M5etw1NMAEC?=
 =?us-ascii?Q?Ltojl+nyXo3kGDlXKh0tNM1I8p0R8FjxxqmzHHYQXgiUrcm/0zTN6dM2bipF?=
 =?us-ascii?Q?WfQzEEYpvyJ+lGnmcAM0ewo8nIHbeuov0vUB2/jmAd7FmnGR7wi/AZZ20cI6?=
 =?us-ascii?Q?mB2RsYN/6llHqIv3SEIQ3F02TPpNKJ9Iw6ZkeIbmGU10LgWlkfDzGqcgR6aL?=
 =?us-ascii?Q?mb6Ac+OYW9yZnB0knw4vX7yqdUyzQIof1VCwiFJs6rhsvbSkqq0nzraJ8Nt8?=
 =?us-ascii?Q?j71wc1VTE6Yfs5PSN0lE4S0mhG8pAZkZazj8Znb5b87Qp00nPSxBHJdSuIL7?=
 =?us-ascii?Q?I4Bu6T6EZPTrx9TtZsaDNacOmJ79fsKEWtRmwv/tSJgbictGSm3i0GJA7PgI?=
 =?us-ascii?Q?qCP/m3uCIsGFuwmMIC00No7MkBS85h54ggcKTWAMmPOVIWvCur02ZxXL1IbU?=
 =?us-ascii?Q?NZ6hZ1G3dL++P0rQoTXcJ9ogG91gqLy0D2rJ6yLnebrlwho/7xrPPstUn2Rg?=
 =?us-ascii?Q?Ie/D3Wdj6fALK6GZkBYMtYxucPvj3zXCZKQRoQMX6GNbfIZtItS+QlywJm2k?=
 =?us-ascii?Q?Zz0oDaocwkVzM6B0p8FyG3Ndy/qj4Wrr3VDbKqTQ++wzp1uMtsMijNQYNuyc?=
 =?us-ascii?Q?YYibiGJTcjqqVCAVNWsjbalhWpjA2sleGBCU4kslteEhUrc+HSf6OJhsJXmo?=
 =?us-ascii?Q?BO+xlnGNoDyMcjjfimi96g2rMhdUtQi8WKlOHu/ZMLbJWEZD9ne98QoO0C0R?=
 =?us-ascii?Q?i8rhwCM8R7eIse+NidhWLFZezDaGGKYq0PJROoNtrYbGAT9FZGt7a6up0hTx?=
 =?us-ascii?Q?o8HRHIVDWutJBSv4co9wBzFB/IAvtaQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 263af99b-8a2c-497c-6964-08de67ebf43d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:00:24.8499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lK2ZSEXbFvYOW5Ez1FJFsB3pO/3bPOeljXNORxaYDn7aTlg0x6uqx6sP0qQA/XOVxyC8pOfeOoUzYZYQSbTohsO4ftUB502ehkwwv6WH4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
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

On Mon, Feb 09, 2026 at 11:40:45AM +0000, Bruce Richardson wrote:
> On Fri, Feb 06, 2026 at 11:25:36AM +0000, Loftus, Ciara wrote:
> > > Subject: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
> > > 
> > > Create a common definition for checksum masks across iavf, idpf, i40e
> > > and ice drivers.
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/common/tx.h             | 8 ++++++++
> > >  drivers/net/intel/i40e/i40e_rxtx.c        | 7 +------
> > >  drivers/net/intel/iavf/iavf_rxtx.c        | 2 +-
> > >  drivers/net/intel/iavf/iavf_rxtx.h        | 8 --------
> > >  drivers/net/intel/ice/ice_rxtx.c          | 8 +-------
> > >  drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
> > >  drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
> > >  7 files changed, 14 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > > index 01e42303b4..928fad1df5 100644
> > > --- a/drivers/net/intel/common/tx.h
> > > +++ b/drivers/net/intel/common/tx.h
> > > @@ -53,6 +53,14 @@
> > >  /* Common maximum data per TX descriptor */
> > >  #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >>
> > > CI_TXD_QW1_TX_BUF_SZ_S)
> > > 
> > > +/* Checksum offload mask to identify packets requesting offload */
> > > +#define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |
> > > 		 \
> > > +				   RTE_MBUF_F_TX_L4_MASK |		 \
> > > +				   RTE_MBUF_F_TX_TCP_SEG |		 \
> > > +				   RTE_MBUF_F_TX_UDP_SEG |		 \
> > > +				   RTE_MBUF_F_TX_OUTER_IP_CKSUM |
> > > 	 \
> > > +				   RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
> > > +
> > >  /**
> > 
> > 
> > <snip>
> > 
> > > diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h
> > > b/drivers/net/intel/idpf/idpf_common_rxtx.h
> > > index b88a87402d..fe7094d434 100644
> > > --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> > > +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> > > @@ -39,13 +39,8 @@
> > >  #define IDPF_RLAN_CTX_DBUF_S	7
> > >  #define IDPF_RX_MAX_DATA_BUF_SIZE	(16 * 1024 - 128)
> > > 
> > > -#define IDPF_TX_CKSUM_OFFLOAD_MASK (		\
> > > -		RTE_MBUF_F_TX_IP_CKSUM |	\
> > > -		RTE_MBUF_F_TX_L4_MASK |		\
> > > -		RTE_MBUF_F_TX_TCP_SEG)
> > > -
> > >  #define IDPF_TX_OFFLOAD_MASK (			\
> > > -		IDPF_TX_CKSUM_OFFLOAD_MASK |	\
> > > +		CI_TX_CKSUM_OFFLOAD_MASK |	\
> > 
> > With this change should the features in idpf.ini be updated to include
> > Inner L3/L4 checksum?
> > And IDPF_TX_SCALAR_OFFLOADS update to include
> > RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
> > RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
> >
> 
> I didn't add it because I hadn't tested it, but since it's using the same
> code as other drivers it's probably safe enough to add, I suppose.
>
Changed my mind here, as I am doing the rework on this set. Leaving this
as-is for now until I get to validate it.

/Bruce 
