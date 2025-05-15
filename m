Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D4EC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEF8D40E3E;
	Thu, 15 May 2025 14:56:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C78AF402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 14:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747313773; x=1778849773;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k8+OR+UeRutjRVJBidPRS6XrgoAAJ3rH0EOsOHc8zEA=;
 b=NjeDkP7M+OUf4WzpdRK/l5t0c0LHJmXOS/WdPoZyZDT1a70sO5KY577k
 6+lWc2MZ2ZUu2k3XtyKSpqDRG/lPfvYoIXM6gsrCnaM+qoOW9ipfCWHuf
 NBy7OJqTCP1kzt98A8yF+1QXyUSUX+aFxKQFY/KKb78YMzZc4+P3ZPhBz
 gZU1Il6cdtVPDnLD6UK8JM9kV4yFYb0axZWRHgBZT4pp6yQ1T+Dnyluy+
 ivmjAHUINck/Jz5c5OG2ELlX9yUv573WR0nCmqpO3oAKhkBVjpm511TS9
 sREBzT2JQdRhBTdBg5nGVPSMaVPkxgpU1C7gFnTphzJ43hIyg2fLiONFM A==;
X-CSE-ConnectionGUID: RTIPCJkbTGeBewDRAmrx1A==
X-CSE-MsgGUID: wYLaxQ5cS1i518tjfFlLVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36863973"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="36863973"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:56:12 -0700
X-CSE-ConnectionGUID: yCCisyMUTPqDOrtJ6ivRgg==
X-CSE-MsgGUID: So+lfc0JTra+1uW1pT16fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="139354602"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:56:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 05:56:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 05:56:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 05:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXst0JtHAd3xljRmoK+2UW7ZYk+Lg0M9SsKLbnlLpoa4+29hRE6agTfpNF9WciNTuYUvsA9cuNpgqYsdZ/qk/DAJknwcA1gs3mEkn2xVj8+H9f7atEP9SYr9P5TfjqGWKl73c6ckg0mwspiN4gxVflxi6ANFuOWj1AuxA+Ri8xnj9HVKRhCiwH4pWpFP9DFnhYHPyGG3NjENj+vaPPv7EampLldYVsAzoFwtYlq+Q6TQ6/7mFHFhkn9bLUAUJThxSm6q1ZONDO6lAnoh4OR7rIIjE+MKOWUHbTcF/kEy3PaSDwLLcSGMoDOJ3vcgtuzCnbsJdfpMCMTsf8M+X0eyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXdNL42V4CeahCS0iQLSGChS4kk6dKM1e7mZjoEJvWQ=;
 b=WLUkNsgQzjKrZcxkPrmezl7ycrAd2pPIwJkdbkMmg7fHd1vSzdaimVH7wvou2rqfN2Mqnh8JzvkfCH/sy7A/eB3bR6wnBLNvPEMvncjxWgLKoVA3DkTZw+VWcK7U5CWNXRfHnp4wSgx4JVqHTkWL6kxOMe3QOsAooznaxadxQ4Yn3z1Y9KloYfTwXehNE/aFu28kxBhaCJ8ZkTYcvQu/xr2k9kRgGNIzrRDMDUEQp3iPklM0c+514fQJm63kgdpWqbiw9b2DSlg2bL5NwARYRTRadCTfnb9O8epOvie7NyQnA0FG65KhkDCu5yTu1c0Ulkqx1q55zl3EVTPufx7vTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:56:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:56:01 +0000
Date: Thu, 15 May 2025 13:55:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v3 04/13] net/i40e: use the common Rx queue structure
Message-ID: <aCXkXSgOSo0mUeOP@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <d9f86c4577c1b0ee9923fef1d0fa61ac812803d8.1747054471.git.anatoly.burakov@intel.com>
 <aCTKVAL2nSNU4rRP@bricha3-mobl1.ger.corp.intel.com>
 <313f5667-0627-4436-815f-bf95d9ffbe87@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <313f5667-0627-4436-815f-bf95d9ffbe87@intel.com>
X-ClientProxiedBy: DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ecb9f9-db0f-4ccf-fe53-08dd93afd864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdQt/v7z5nvW2fhH8D/6+69TMS0f0kxNpoBRuwIBXk/20u59D3M+CmLqbJWO?=
 =?us-ascii?Q?Sk5s8KN//2a+FzyrDrRQZ4XrHJ0YrqTbqtaCwm/Uz09teq2VoCuk9LLPpqq8?=
 =?us-ascii?Q?QBb498eNhfXNRmoXQutuIaqylA2ee04tKvKe+nRGTSLf77vZi59Z1k1T6aDG?=
 =?us-ascii?Q?BWCxz+dHBt/C2UAILgrYWyR78cJwkJ0IYmRLctLnRrtwwyeHzn07xpvUdR5Z?=
 =?us-ascii?Q?KbL+TqczCSXJuq8PmDRDGi+S5/8mCr91juwVdAHeh+MoA1bQogMkS2Fbl8Se?=
 =?us-ascii?Q?nDBk5mmuwjkn6OvTdyuOLb/adS5a9j+VYqL7cMwLSnx6crKB83+fHYoXQeej?=
 =?us-ascii?Q?B2MES/Mgj9EF5OaVkLOu+jmMxMqgAbBKYeFpkefFp93821Yah+U+AsiZFLhO?=
 =?us-ascii?Q?3VybmtrQep27DaBJkVZ/Q8+1JwuAawjkh7PxMyZfV76pOghnMGs7ptQSCKZC?=
 =?us-ascii?Q?NprAS8V6eon8x5rwz8yzzIelWGtYJUwhPU5uGKqWNUe9lIIiHnoPRn8PZbXR?=
 =?us-ascii?Q?BlHK5fFyhlOEyDgwZqiMuatWb63FB8pp4n7u/cEDZvr+RSBvURlU3+Lp4HCf?=
 =?us-ascii?Q?4a9P6TTwX1aVTiRI9ogtWjm3yby/AlYwdklocKUlDlqegaw0HnE9NnCSTqXZ?=
 =?us-ascii?Q?LOQ8x8RmeAPHD39XzobMSSXIJVVgBX0YzQ86uDjJNOBP1in9SFPNWKaIIOgU?=
 =?us-ascii?Q?Ykf+WXC4uoCLu55VvqL2N0FOSMLiHaNp0aEYsE3Un5bB1z6UyWJpdXkQaGBx?=
 =?us-ascii?Q?/7HYcNRX4OS8jxwmH2Trb919TVMUYLIvgdTkcoT1LqmUBXsgKW0VUjkN3VZB?=
 =?us-ascii?Q?9UwnX+xW0qXUt4tuMRysUxmZTuKUxC8XmYu8clgLdP+u11w5VrclJgmn4jEC?=
 =?us-ascii?Q?2bv5meIkpd25PugA4Pi6XEn4kAz57O1r0xTNDGO+7dFeC1yDYzcQvcWYqjm4?=
 =?us-ascii?Q?xV0M+vlgfF+Fa83F2Z8qp4PJytltmnQPq9++cT0sH01ezG3VIOXpVrOlMuNj?=
 =?us-ascii?Q?py0PmaYL+lRKJjaYFjHGNT0r3yVFeB3PxcEI7GQSGo/bDwG6Hrg+feENxoy1?=
 =?us-ascii?Q?4cc13rqvNFnKJEaK+WuvYhmktnhShwYaZO1Dw6uLBF8mfUVMctsCqH6cyGr7?=
 =?us-ascii?Q?hIe/kG4e8pxq3GKCSNarhLXY1yRGZn665JfNQllP04YGWUIyAGu38CaxDCJk?=
 =?us-ascii?Q?4sNoTp+fyP8LZzHh3QA3rknkOc+IpmOzlMWWZzTmAgvzIIQwLTXQSfRg7Kdo?=
 =?us-ascii?Q?w18utEOWBv/nJlBLzV8Qbz/BEPSxEH2bFkd3dq5nPFu95GFtCfHecJkcacQi?=
 =?us-ascii?Q?VtCyzR8pmmwosX1M9QOYgVo0Zjla1+pa3tWZ5CeBrb5tkyfYwbZm6RhB6qfQ?=
 =?us-ascii?Q?asHbNkTikIAt28G7zgACE5nCv2R9/35lZ4dSLmtNbrYywMGj7NZ93rCyBTls?=
 =?us-ascii?Q?qH/qRSphkEg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJRO6IRud9wnM/8+KyNCWEH8aiFBvkMqbqknOZmVdEuyuzRjvgaif7Am74xB?=
 =?us-ascii?Q?OOh7KBuBjaR0NbBoT5j4vTaYcMlHwdpEgeMm1YxsiHlKrC2VuWCfxHhrdnXV?=
 =?us-ascii?Q?OY/joVB/mMwMXnBgjyjzurUNkS3x8YlssAr6DdiKyaT/waZsusT4JRroQ5j+?=
 =?us-ascii?Q?3ke9k6Vk8JDRT6th4WwVVzIrt2Spbyj8FmGbkdTjVMHGi3u9uZGclGO/xYVp?=
 =?us-ascii?Q?Z8GSqM39ff0DYoJUHKe0c3S5Z3g62QyiyREqV1HktwkkFvtGEEfHWi6OLb/L?=
 =?us-ascii?Q?ew4GeW2mcZoKQio5dKXGLzHebuOvWgx4ovMz7pmEHBjuNVN3kjc/PUxgvDj2?=
 =?us-ascii?Q?jInmgZnPdGmB1RECWWtbHPvFlVpIZOMLssqoWD+ghJUFDUDCYjANPMFTpTmO?=
 =?us-ascii?Q?NwL2w02NA94SLkdXzifzk2+7FXu3WzdUyUOgeAsOEiAe5Tt0NKEhwn+MAf0p?=
 =?us-ascii?Q?TLUEsM7etWf6hBsvrc4LjWTXSucBgWdaJbNo7CobvHGLeoxrlG227KzuDuh+?=
 =?us-ascii?Q?5lCwCcUCO86yXoEwseTeuFSSzYcez/xmj01XLhAK6oYfdP/ZyHya2TSLAR5K?=
 =?us-ascii?Q?Snh8gxg4qRvzyamMyAPVF1aKXwtv2aDAK5aQ1cz0Or99Nz1DXl7brsPLKr1P?=
 =?us-ascii?Q?Uo9a1Sjse0RDcDIAbno24Y2Our8SfT6o+SNTjclbCAp3nA5XZRzv1LEkfc+q?=
 =?us-ascii?Q?s1mf4dAJpEc7eV3nafkPQiJcdlO9tZxSOXe4DErU6/wt2Z94hZqH8OurLkJb?=
 =?us-ascii?Q?QZQLcZlUXOQ4fiJKq4SGpgqxjADAnlWiiUx/WcxgBZAXYed+CisIsbr7HiHo?=
 =?us-ascii?Q?fZ4DEonXLLtdxRphEs32Cpdiauh2Hl0DE/7t+2TK6rSTUTE6bawuyBsvB1mh?=
 =?us-ascii?Q?1UeQXKQPH8GLC8SBvmhyaFnYI4gEFystbyaeCwloIOEdi9xvAlpxGaW79q0T?=
 =?us-ascii?Q?zvdA7jSU9eMr8Ix5zEoS0JHgTUdlMpc+OrFrEv41dcXPkVGstn+1adOZVbIM?=
 =?us-ascii?Q?uzk8hFNCDE2zQeCs9/J8p7AH9f4PtYy++UWWOYe+4N5BfX5Frirngdul1b/v?=
 =?us-ascii?Q?SOaYO7Pramkv4VbQmeS4cL8BjU9lg/FARVR2C+BpYTRXwpgItTQvQfaqJsuP?=
 =?us-ascii?Q?sl4QmoheFxH5Z7BBYtrzNQqvPoua/Omuk6+W8e3jcSa8a3qR4oGtvZ2rVwQw?=
 =?us-ascii?Q?ryuBQODe0ya/CpCJkUiFeXUClYIEgaVvaDyRTczjIEbXqDlXPcOZraoWsU2K?=
 =?us-ascii?Q?nkcDgpfGeLhaoLJESnVT9QhzL2/a1lMRU74GToz4Bk5FB8qisc0jPwv8VBcM?=
 =?us-ascii?Q?YQx9ZRfA8xxIOtSVd+peMeZJbT7lsjPr/ByjLkzbwDe4ea7AtqKZ0dpNJcTi?=
 =?us-ascii?Q?LL9OXtr4ygGGJKhlunTHQePZEJabImAGWLcrRHQIAuFeTS92NQSCabAKT8bR?=
 =?us-ascii?Q?YetOGiBYk3yvKwPkLlRhj0q4bXEr5o/Rq6Hgxd92q3L9Mo7t6kbOYGdUoXOM?=
 =?us-ascii?Q?Niyf/cZ1jH2cgNtVFGQNI07T2Dp0u2FxnDCWhISwc/waZ/OrCp9wEzG0f8zL?=
 =?us-ascii?Q?Igptfm5Zc0omMlmqwSn9oz0cnqXF+R2qYp8+bcBnLJgEfha+MmfxaTy5//7J?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ecb9f9-db0f-4ccf-fe53-08dd93afd864
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:56:01.7431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXCmKBzFzy1wR2o+e+4Zfup6c209XD9zrxAEW9UbXDy1n6rUeZ75KhtyYGZOZKsIHjX9BMy2J3Bc+zZtZ1lgxqElIuqN2ccyp2R0LNSh0j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
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

On Thu, May 15, 2025 at 01:09:31PM +0200, Burakov, Anatoly wrote:
> On 5/14/2025 6:52 PM, Bruce Richardson wrote:
> > On Mon, May 12, 2025 at 01:54:30PM +0100, Anatoly Burakov wrote:
> > > Make the i40e driver use the new common Rx queue structure.
> > > 
> > > Because the i40e driver supports both 16-byte and 32-byte descriptor
> > > formats (controlled by RTE_LIBRTE_I40E_16BYTE_RX_DESC define), the common
> > > queue structure has to take that into account, so the ring queue structure
> > > will have both, while the actual descriptor format is picked by i40e at
> > > compile time using the above macro. Direct usage of Rx queue structure is
> > > now meant to be replaced with a macro access that takes descriptor size
> > > into account.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/common/rx.h                 |  14 ++
> > >   drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
> > >   drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
> > >   drivers/net/intel/i40e/i40e_fdir.c            |  16 +--
> > >   .../i40e/i40e_recycle_mbufs_vec_common.c      |   6 +-
> > >   drivers/net/intel/i40e/i40e_rxtx.c            | 126 +++++++++---------
> > >   drivers/net/intel/i40e/i40e_rxtx.h            |  74 +++-------
> > >   drivers/net/intel/i40e/i40e_rxtx_common_avx.h |   6 +-
> > >   .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  22 +--
> > >   drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  12 +-
> > >   drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  12 +-
> > >   drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
> > >   drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  24 ++--
> > >   drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  24 ++--
> > >   14 files changed, 160 insertions(+), 188 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> > > index 524de39f9c..db49db57d0 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -30,6 +30,8 @@ struct ci_rx_queue {
> > >   	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
> > >   	union { /* RX ring virtual address */
> > >   		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
> > > +		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
> > > +		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
> > 
> > Rather than doing this, would it not be better to keep using the current
> > scheme of just having an #ifdef aliasing i40e_rx_desc to either the 16byte
> > or 32byte variants?
> > 
> > /Bruce
> 
> I had that in my first iteration, but I don't really like having
> driver-specific #ifdefs in a common header. Plus, it also introduces header
> ordering dependencies (need to include header with definitions before
> including this one), so I decided against it.
> 
The header ordering should not be a problem. The definition placeholder for
the 16-byte descriptors is in the global rte_config.h.

/Bruce
