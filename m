Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51999D5B84C
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 16:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 432654029A;
	Mon, 15 Dec 2025 17:36:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8853040151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 17:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765816594; x=1797352594;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E26yP8EO2PZzCdDy07Fz+7SH/l+YWu5emyKk1B3UAA4=;
 b=imijlsNE7E1i5EwsawyelWWZAP8vEjsLm4WnAvH+rHDACIWzd93IWI/F
 hC/WLAoms9Ltm0LT+/okpB2jm7+6Jq4aEALJIvDTfz379SvvFs8C3kvcr
 Q4mzmYEiHI2Au2C+MZY37LgQ6bPDH4FHVUW2975sEL0L4IKSVuTHwfnzd
 5br/c9E10uRufBRxfrLqQFne14mGAjpfFff0ig3EeW04T7KwldI7krQxb
 VsrmiKTjDFyV+X/3oULj0ZFNVWLAJ43pvJvIRq4F7qCHdKVqTpYdRR7jS
 KVcpcA/wrnK1fvxKhThwiEihhAGuCe0CpkcJfHppoLsjTe8bge4c0hrP1 A==;
X-CSE-ConnectionGUID: xWqxt9u8QrSO4DnhPtZoLA==
X-CSE-MsgGUID: 3kgzbtNkSweQy8EkpGN2bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="85133141"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="85133141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 08:36:33 -0800
X-CSE-ConnectionGUID: AgIi+t4wSYip+fML2bJgVg==
X-CSE-MsgGUID: 0qh1r3R+Q1ifA9VWWYMOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="201946203"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 08:36:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 08:36:31 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 08:36:31 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 08:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8F8TqL1tv3PXJPhSYKYkqV/xMp2nSPU4CGNlWW7eDG63x7PAdVhX1PuT/j6vG/evq9388NtIRE92phMjxo/57UM+cJvaqM1CBPoQ/6lr7Ar2V6z1dND4o5K7KxgbWcwYt/X4JuDYBYZE9byIA3sRoU0DMmjTf6iw5ydg7zlEyBA3smw/+e9oa0+E6UF4NHD1px8yxKfi+rWTH+7uFKMwInWDSRBKZLKDuz7aPO8sjfrs7rhoCyANvYMbePgnqLf2qXBaFV5go8hGuRogtijkbvwn023jLDnbr5Et0N6Pc4EXoCLVyr5AEdMJvSGjQvbjSyYhvWp7IxzidZi8+crDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDvbEEslBGejTsgpt342tYcFHBS0JJ23nwTxivItvUY=;
 b=GV/vi0AwKQim2QzWZ7OxQYlUHwpq3vyvaFBqQti/sdYcVHh+YYxnBq0wrSkShZpLeK2jr6JLPQBrF+UievbWcmRWgJEqMWisbtnOt1JUad9SDulOH92/IbrI6nwTEMgZ6+PSUcOd65ASZVsHVDYsfDtdTBeJZwQxiMDjXaXqaKP9Dt4d20Xn5uFueCT37vQBTDV9gQ/zsSspt4Uo9Aa6AR8QGxCqEyc8k5l01gs+3CcxP2SIQd2ywDMrAeMdR5Dg/cxAWyJ/HVre8C0DsOLRUwnrVuxPKt2JEkZzyPz/j2VlNcI1Ih/1EuaWOzbEY/HoFCV49VTBRctAax1A+NMsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:36:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:36:29 +0000
Date: Mon, 15 Dec 2025 16:36:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: add fragment RSS types for symmetric Toeplitz
Message-ID: <aUA5CG_Lx2qg2mk1@bricha3-mobl1.ger.corp.intel.com>
References: <20251205175537.137011-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205175537.137011-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2278a6-6355-41e6-3702-08de3bf818ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bj8qXmKPlHpWgh9bV3um0ch2VA7K2N+mPzzBUAAMdlXh+8NVAcWYEzifup/f?=
 =?us-ascii?Q?LD71VCVtyJJFx7ezFlcT4x+mcsgPpPo69Rdv3Y+H8nEO658vL/3zlYzr1oF5?=
 =?us-ascii?Q?wOOM3cdPNYRvytk/m1I73rkHam+pF01dt/tH14/GD/IcFOC+CmxdLdlIyfH6?=
 =?us-ascii?Q?sGxLiZjTF93HWqceSG8Vw/Qu1NL5R8K57GCmDNXIEJ5gi+e5B1l4zASiUcRS?=
 =?us-ascii?Q?34LlNXwsiwIyeta/2m5mPwk1G3YSzR8amMDRuPah0JBRneYOL+B9+7IOCoqi?=
 =?us-ascii?Q?4BN/uzIX423tKj8xc4E3QsWOx5fhy83VwvTaUyW0sJfgIl7rXtf++JzbstW/?=
 =?us-ascii?Q?+mI0aROZIpbVzkhOHo+sw6sRjeRQY0Dw6BDI3Oo8e78HS3KiIszKef8bQqaB?=
 =?us-ascii?Q?Un2i19s9Yv4bjMoKs7vNfXMm+3c7W+HnzM/lSVgvENpv77rHI74xmYwfYciJ?=
 =?us-ascii?Q?A1Lqgq1aAPUt8WpLyU6mFBVaL9NlM4M/jfmcMMrm1cqKcRmjXYuFOulzT23h?=
 =?us-ascii?Q?HFdNn/m+VCzBJ9EHHGheUsBqlVybo4ub9HMY9ZMvM/vhh8YaoFjAKgApviwO?=
 =?us-ascii?Q?rd+SklXvFuLcqA4LOHIVsm4E6UHROsZDAtlAiW9d5NE+5vAeWhvtLvXcpcHn?=
 =?us-ascii?Q?W1px103fb6Lftgworr3UfiOQ3yvQKeE5dvVFuxkOmWvCoqSgTan31uYRpeV0?=
 =?us-ascii?Q?96tLw/RGW4Vvspa7mDL/pIQUPNxYZxYWdJdAQYX2Yr6EQnE9wbU/eDOnzKPM?=
 =?us-ascii?Q?WIp/mJ9hm3ASqcOpw4gRQqm03fA9V5fJFdltmbU90FLGk1TRep8BVhnB3QdB?=
 =?us-ascii?Q?yI3xKmJt/5mU821KTFobIADjGDTrlEuW4GLvcqOsGpTd99gF00bdWI3EGH9P?=
 =?us-ascii?Q?bMEF6le/GX3MuKkjNhXFSWRSJe0keoF2QnxZkmZmpMBLWL/LV3ZDKw3Z2MZ4?=
 =?us-ascii?Q?yYYtkd6EuEYVyAJ9xNxQ5rIm3sLwqvyJ5V+eA950z3kOQ9PoztPA7NN2MyDV?=
 =?us-ascii?Q?taHj/iFtm63Texn2ocXrzJPE8fg41OBqEPGDCUQWJJNcgIBTJMmAF87UNVfW?=
 =?us-ascii?Q?w4b4MQIXDlV4JdA9LXkNcBrSVSWZjRZ/bL+8HjYcCPPH8UtIB47qxGXxNZrG?=
 =?us-ascii?Q?e8JHvJMbusAxvZItWht1oySAt300YAXAhljK8HRGxn4Fq6YtmV+MegyLFNzp?=
 =?us-ascii?Q?2g4g6fdkMfn4yNCGyGUi7fSVl6fPEtGZAVF2PajrjbAPi2nqDteIeISUsnMc?=
 =?us-ascii?Q?CmbDihqZMS/KCoOBOTDN5VX6Bie6FhrAlfY7QSJv2vKd5GubkudqFgMBthjo?=
 =?us-ascii?Q?8JB+nR/lxcGsqnAC/3yd2ZJVlg/dlbAIIzInqUDDsItD/mfy5gLydKmiqcpF?=
 =?us-ascii?Q?n/Jn8UrKG7nnEjGukSNwOjOonpRt9ZH7I2IRhqNYAqAi9aRh259O36p5lI61?=
 =?us-ascii?Q?Qkn+2ptGCQH6ofLiBbrhCf8PF7+yUhMa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zyz3a66a8nK2PoUw7K7ft6PWj+LjYojYjeApzfHtNW3U3XHmBRgwsUi4zf92?=
 =?us-ascii?Q?9DwNmUPLs4IG0DGtSi+xT5/fopu2r36/Ajf6LJ0NCnh5J9bB37AcQWgh3axF?=
 =?us-ascii?Q?cahSXTmcuPP585BlMurYIbrLMq4S1LTKRy8NlwOZKd34SSAbIUT0usicKXAE?=
 =?us-ascii?Q?2NSOFGy8GXtekjJF65tAFeW7y3BBg5d/7/JgUuncrXa9N5t8tMrt+lakCQoe?=
 =?us-ascii?Q?eeOgqewNWjzQQctB4oLTbWIFen32zBzkl3HDAN/bq+MEzwuozRId+taS7VXl?=
 =?us-ascii?Q?QQuR99Ul/GOCgQUyaCLxeGxDejSDDyqjZZz+14Bh9A3yn2bLc3y76KuT11kx?=
 =?us-ascii?Q?dGBWMkGTw4tCJfEiKOUgBLHqXc8Hgirn3YGox0RJAjdCzgLCykm3dCMqh3qI?=
 =?us-ascii?Q?bxvhZxCwb3CNoLlzxNjZsNVuCS1z8Upai9Z7UFuYbmxzILV2+yxOzXODHfpr?=
 =?us-ascii?Q?XqJnqhEre52W7HxZeZysN/uCmfxdO1ij5t6RN9P3sCuQ4zYSMZ/sNgn0yh46?=
 =?us-ascii?Q?GLtL0pTH5WBToT3hDASg60JSA6iwMFIKmUttbfzH8IqqZieqbmFBS1mwTOQo?=
 =?us-ascii?Q?TEapZrqtjAuE80kqJ1LyZrGvPn1fjzBfeFc6BtiHvF9brdr48AIaaZ/9IG7m?=
 =?us-ascii?Q?FogILB9b4qL81i4sDKtErmyDyW7e2r3UXIjHzKqPeK22N4M5+YK/2Yd8iNE7?=
 =?us-ascii?Q?8IRuTxftiD3RNbHDQtxMWK39fsINqHkMv7MsoCiaxuEKOq9x9kroBkgm4mc0?=
 =?us-ascii?Q?JBXW4cVaQ8mtNnhTvpBGS1tuVkAnpB6Wbq0YIP4kzcpoYedmdj3xvmCIguyN?=
 =?us-ascii?Q?KopkJlMdvdeeCq4GIKSrcuetxO7JfzmyVZTwpFd73WAuaACCnTzzUIdzwaEW?=
 =?us-ascii?Q?oxOdVNH3W/TlmIRyZ2MXdbMptQBUhB7aq+vwrnP9ZMeIHcQ+bZ4Q2q3WKkMq?=
 =?us-ascii?Q?U/IGLJ3FB3xNs1rMj5lCfiojm2nAX5D8zHD4QaSjMRfleDb/nVOjb6DtuOGZ?=
 =?us-ascii?Q?loIM3W7Fq8le3hfez8CRYikG834nSKthuCyqlFKvFzeMSwRdHr1lEBeZTaTX?=
 =?us-ascii?Q?rM72NAW/DzmYBXTUgCBuP94MYJV7ZKenKKZc0FhAifsuGEFRhIvwObDYUudQ?=
 =?us-ascii?Q?oIuR79AlzKeFs+zTkbtpi6jQgfCJKX/jWJHyQAJU0c4SoQJvE6ussExYWozY?=
 =?us-ascii?Q?2Nwo3vU2ZfAKMtEAbJytCGqZqzpDvP++6OnR0UsnPFLNj06/qylGxqkZEait?=
 =?us-ascii?Q?frdbD4XBgy2hW5sKQkGvu1abitXQ4K0IW+lCu4Z1sG7yw/gIh3yxixWjhy+8?=
 =?us-ascii?Q?4KVOJ5Mz5QNMu14Q2Axo7glkNpq2DDx3LpbElafjH0t7BquUOBITC8Ty9lo1?=
 =?us-ascii?Q?+5wt7Vu5FptxlqD40mk+wq9bx/JDsR4AeRLISUae4fYeD2PgozDOHlHqWHan?=
 =?us-ascii?Q?l+3vNAYmpdt/C7bwiGrqRgMD2ZJKqql5xvAn3gqxuPL/gC6IotU1P++Iieud?=
 =?us-ascii?Q?Wkd/RKV8PUc5ETWKSkZSQbRI9VhiTD6Re+0W/BNJ0jMN6CUOjGEa/gQt2Dco?=
 =?us-ascii?Q?n8K2iryJxC50iS0pwaNrCMsDEihxiVhD+87UYfw1KaQ4ptj0YethK/kXBbpA?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2278a6-6355-41e6-3702-08de3bf818ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:36:29.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfRZaSzO6UxtCbBWboxN3nhsXFnpYuxQSKZCyD9XGMes5KgfEwJIp7ejw/CNFquG++NCr/NO4xLM4Hpz/QRfyZfQvdbP/GZlRXZok3lhLfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
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

On Fri, Dec 05, 2025 at 12:55:37PM -0500, Sandeep Penigalapati wrote:
> The ICE PMD supports RTE_ETH_RSS_FRAG_IPV4 and RTE_ETH_RSS_FRAG_IPV6
> with symmetric Toeplitz, but these were missing from IAVF PMD.
> Added the fragment RSS types to enable fragment hashing support in VF,
> matching the PF driver capability.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks.

