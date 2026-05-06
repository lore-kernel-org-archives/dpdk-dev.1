Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA6CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61D41406B8;
	Wed,  6 May 2026 17:57:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 73D2340A75
 for <dev@dpdk.org>; Wed,  6 May 2026 17:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778083026; x=1809619026;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YHFr6CmLMiR9vPkoSBwU8VRjUy6DaZdvU4fxBdp/5/o=;
 b=IzkwW9GEf1/zwO5AnZun/CySbzNoo/BNd13JS6r08NqzqZeOFVTezj4X
 2e5Ibe5OTAcs/iCudt3mEwRP9I5YBz3duRh/xcV2aw7oLvkqA505N30Dk
 Zp1aKm8r62XRL8ZhPbN3b27TufrZ8bNWI1AKp7sVSH7AeXXoMVyNaWXfd
 RyggvbYB/wprP0DX3XZwqQ51LSv13WyqIpB9rrBuUhIVfu57TgL2uPHr+
 GU6IaHBxW7+2oyMzQFeKBX9LyZf2Nq0yXJf7cppqrPNWN1mirwHbSZSX4
 g05h9NzF8wXmIVB6uNm40rGvRJj6Nnekype/Ag+Al1pnJ0XrFxV2EebCf A==;
X-CSE-ConnectionGUID: k2F5YROrR1+OKb14X/VPew==
X-CSE-MsgGUID: mZFWKyKRRpSiDtmR4tqX9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78046494"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78046494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:56:38 -0700
X-CSE-ConnectionGUID: yU8WR0lRQliqC8mys6Zwlw==
X-CSE-MsgGUID: S+TYnviTR7CbZbeVYwSQIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="240521895"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:56:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:56:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 08:56:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNAPC4NOkLZ+MuOeQtOPWVcqZ6jzusPaMNj1WCfi029Q2fWKTDe+Z6Kqxl0n0nPEW90za8dwU7rJpi5jWcFzxZx7yhXK4fPLjr26wksRoEDuq4wlTyCYzKkQLw8SH9eByrGwAQdxbfIe2KjbfQ/2CYRsAtWBpfxQJrqHmKQYa+hfVkTTdUYOI/r/XrOQjaqD6aVc3CGh5CBfOu589ir3z7mOt+hogtOi05k8ucOagSyqJts6RjLAO+jPphk5yVEBpGq8/hj6+Zm1hvcQn/XFdIBol9EfGFVZczIjY+9NkNObc2S3s6MEzJJjfNgmnIGUt9Cc/TAAd7OZEX2LXoDkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4a2uGUfjObHvIp74wErUljy4gJ1dtwIQYEtXokuuzc=;
 b=VroNKSQBh6hurFEntoBYAQksJwwU58q32rMj8A7x03cxRr5RL0NjQ/wEKlmMPKvZ2e3Kk6HtNPoLnQp+kOWYWTXEbMvqSp6QsmOJECFcmFdrm8Uq2UfIAxXcNVI8ZI7uOxuUSOZj89/uO/vvCP6WbEJqGODK08f7KBRUsqSJRCfVotKlYuECudJdahdiqKhSjKc5HVmgFWA7FWGaRuqbAYLH0qGQwBZ89pJ1+x8Www6sz2NO4s+acoNzgLQ7CiY3T3b0cUZ7qgfCytbHKKZqE5rKz3YL5VEixlEtOJAfxn9LGzh4pRwxswtUVpFN/uHrTuRJ1Lc+aI7eiDKblX/OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9500.namprd11.prod.outlook.com (2603:10b6:8:258::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 15:56:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 15:56:35 +0000
Date: Wed, 6 May 2026 16:56:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Message-ID: <aftkrgIfFPNUpbE2@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <20260506033338.480610-2-stephen@networkplumber.org>
 <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
 <20260506084632.5cfc676e@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506084632.5cfc676e@phoenix.local>
X-ClientProxiedBy: DUZP191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: a82eaca5-441b-42a3-95c3-08deab880ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: E4xmjX2qXij5FKUfv4WRJK7R9UfjqPqyyOQyCus3rLUY6OXDkP/bztgmEWw8ceTBigM+sq4sEgGfIIDdVyIHUY5yrVP9Xu6HmcRCxL2chvgBcl0zVIooR1Z9h/2+obdcDrCnuUi3aWLtTVOgJmfwA9MK0FJ1vhlWWewMHzuUf26G/yb/CrxCkR/od8fLc/V2mmq6wt2p4n5PPCvWn/V8Wp+gQOoW7sU3k1qPJNfi3TF+k+vYfT7EJr3gdz1zd46eZfF8FPzmAn9R2p9/Elq+qz3yUYR+iyO/+ryXAxEXROEPnfEvbBRQ5IM9+mgn+/+/r8Ght+5kMHhwVSM2QYQN4ayQhuVySa8/xntbXtfgG7sn7p0wbkzEOcc7CMjI2rMtkY+rrllVqwhJ5DqVt99U8RFuq1kp6aUB9VXZgJwp54iVCMXeY4ZpRyn9mudJUM1Fvt8swWlObrmrlKSFHZHXm+GezSYsyNWWIKJPilZyaZoOKGmoxBvjndhTPsMsFVY43QqzQ0Q+JgeA/k/UPNzAfkkEIg/xOqxwU8cfGqJcpiQumpm0jJ8sLhvZTEpetWg1e99a8KkZP8WP6OZP0Yl/E9uOOFFu51lM/BeJ3j4WjLvAMK/QLjye4EiHvfDikIkbNaTVZE47X2X/ASfX3MyuCTxQw4BTtf9dsbe1ugbNqCzf9uT65Q6ep78i2XPDHblm3vQxNzfl0g3viQbfcApkHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SV2WW6/4z4+8RBEbvbyhnBOUNJ10y7A393fZYUD1NB4e2ht5aLC/LOFeJQ9p?=
 =?us-ascii?Q?VjT5lOZSEe+Y00skV1emSlcsHqrXOuH08Pl6srVKcrj3Ilv1KZk0rV8/j6MH?=
 =?us-ascii?Q?O4h4CyE9LYPf2mTkgXpUKE9QdtJwl6DgBkdbCuEu3kADTJOnaoK0hXjGRYmm?=
 =?us-ascii?Q?c/WFt1ADVtzp4Vd835hCYQWsR1wq+7PzpZyjLaMBceOTF3pJtrRJao3MW0lr?=
 =?us-ascii?Q?h5GBtRuPWN1q2Z5TvoZheeDk5SSmoDc3gZahl7bLIOtFNd86d+3mhJnklMz8?=
 =?us-ascii?Q?kjeFaExD9lOGYv1WeQdnF7ah6gGf4kO+aSDE3xmomW0Cg/imsLRUwCHnXTAJ?=
 =?us-ascii?Q?h+gZFg7Zv9b4w5im2SBvkXdJOsy3rCshgES8Jev48mpCvIePtyTSFV1LEq31?=
 =?us-ascii?Q?HB5FrtWOXyzUy8ih891Uv17SGNXJ752oGIRf/weARclJV2NnoBS2YBxT3oTq?=
 =?us-ascii?Q?gTjGbTzWqaOHcbtfSCvyIm90TnPYpsZ+1v/Oh6CGP0qS8FrCXgJoUrvJW3gh?=
 =?us-ascii?Q?ou2vcnu63cjR2Z9XJ1vzFQRvx6gxQgtWUTkCs1h4+BqXQHJPXiEFE6q/36yp?=
 =?us-ascii?Q?nbiEZmZ0iMyxXKlfAMBjJEAXSUBshy2fzxoR8AsuvMCi/o7Wx8HfC1olHHl2?=
 =?us-ascii?Q?ytV9EHP0+WTTwfDC4/iR2bixAGvziNme+wVIFUQE73BT9ar+CwTHqDGV60I0?=
 =?us-ascii?Q?2uQjRXp5skpskeOZLcD3Oe9Yu1yV3YzcnWEklFg4f3cDWvH/2YC1Zb9y60tu?=
 =?us-ascii?Q?Powbg7FGekWl2Z2gJskJ5J882cEfwBqNHLGnp9ykv9fP9cr+F4TxZN1/YPA3?=
 =?us-ascii?Q?SVgngYKOvwvF2ZOVkDdEL1zhBWXRgeWOl55s7hoOel6QhRc4GNzZOeq+49lh?=
 =?us-ascii?Q?/vCYjLZPvwkrF459NcmkBgvSpSPXgEyEizbJmobZVtrUXMlHiAOfAFIInw7v?=
 =?us-ascii?Q?ZnHeSDys7Nu1KmK0/ZaMidAR1swcTA1HQhwh7gNnD2kqBEUVof4jTVAqiCwv?=
 =?us-ascii?Q?MjMT/IzTsEvp1FpyjK4bz/1wSIvb7eKIIvLIJmFaqIWe5zZJ5sBeSSgoBqvr?=
 =?us-ascii?Q?4AdtbCbK/r7xrdGu8g6ajhDWGLxpMXJMVOzxcPolBPGCkcQ1wornbFNjG6u8?=
 =?us-ascii?Q?mvn3moxAQDvXskc8CWbbBeZ4aza/Ysn1y2rp/KgtVb8xqkmFo3Du328wzMaE?=
 =?us-ascii?Q?ANZtui/Cba9+cUY8SBz944XAlSEukADZZOnTdLBNZXCz0O5/SXiTNrfTUnbd?=
 =?us-ascii?Q?60bnVxpCKsJEDAUtUP6SPVRXTj0eFPBU7Ws0vUhx9NMt3OuWEfR4SixCOVmn?=
 =?us-ascii?Q?8UUNAQLmbsFb3oFZVH2xmhxft2VMcjhMWpGaJXKPdMKNc16IOVACGNDVRETl?=
 =?us-ascii?Q?LmorVULk3/w6mvvReFPLpgUb4bdMr+aNlNfFMBeCdVpbZ9PsL59MqXtxe3OH?=
 =?us-ascii?Q?awMHiITjZq+4SCIe+a1qj7PqfPlDQYRJzCiY5C4yENduGvvOxbi2b9S6At9B?=
 =?us-ascii?Q?pWJIXZZi6qB9mbJjktKgoSu/9SSrbDMvcCYBJ/E+eGZhdP1uWqsfh/++HN+6?=
 =?us-ascii?Q?vcvMJrDofGu4eOyueukn7KGSbRWc+yen3Qc36/tm40zCZHVaV2RisZ4OTMxi?=
 =?us-ascii?Q?XitI5uPcVdiulahjKRAhFSr1yCJzYj77AWyBi8+ZGrzUzp/I6vdfoxHlyDRL?=
 =?us-ascii?Q?ea6zwq3tY53H4062+2QsXcGDkT9LPW/GrSo0MTJ8dtS6yOziUCKOAceQL8nD?=
 =?us-ascii?Q?Ux++Zu2kPuftEmACrLSHER6qAZCxsw4=3D?=
X-Exchange-RoutingPolicyChecked: fKxtT4lrD3CAt8qT+KceqTVWpIqX/jRZYTan2miUZ4se8nX/KoQqMXjXJzqhM5DnNMjz+jD5+2qNSvZuWiBWpuRfFeOGg4A0YR5rqKolJ8KwzexuDg5yuUesbdWyJSzOTfU1Xx+60IYT1xDmyT8/vPi+S3Vg5DxjLow4JDb7PCVw83lAXZ/tSCmw0iuxH7oPUL/oWZVT5e8IHjL3Knb8rI3r2Gck/jYMUHTNHug/KWuxaT8Q1WrZ8HbrXOj+ieg2QmSLXvCPY7VQpuVuTFEiccyMEpgmlscRDjr33oMz3gm5BPgUOzI/4tKGSliBhU0bNEFmiC27HSm+rN5T6U5Qbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a82eaca5-441b-42a3-95c3-08deab880ccc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:56:35.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PczucbEP/HhNqHhs5gZ3YRvAyZZiCfFiVOYxV0iOXdyNgoDgNEkKFMbxOIyIi0dXcIDPHPOTAxsT0PS41BdNBIdS6lVshXr6bxTWjRiKKWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9500
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

On Wed, May 06, 2026 at 08:46:32AM -0700, Stephen Hemminger wrote:
> On Wed, 6 May 2026 09:06:22 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > > 
> > > Dependencies are limited to rte_ethdev and rte_net; no
> > > librte_cmdline, no flex/bison, no platform-specific headers.
> > > The grammar follows testpmd's syntax so familiar rules carry
> > > over and is documented in the programmer's guide.
> > >   
> > Was there a particular reason to avoid using flex/bison here, or did their
> > use just not make sense? In general I would prefer using code-generation
> > tools where possible rather than maintaining (metaphorically) hand-written code.
> > 
> > /Bruce
> 
> As long as we are willing to accept flex/bison as build dependency,
> it would make sense to use it.

Google search points to https://github.com/lexxmark/winflexbison as
available ports for Windows, so I see no issue with making these build
dependencies.

/Bruce
