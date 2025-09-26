Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA8CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 07:58:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3410540262;
	Fri, 26 Sep 2025 09:58:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F05474025D;
 Fri, 26 Sep 2025 09:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758873505; x=1790409505;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8Lqt0/gerPL8vIHCRh4ZLRzsELyd4cF6DQhdPj6W7yM=;
 b=cNyczkDKoejd+it8gJyzdzzGwgcq6k0o14o3p3VTYAQ3rTddz0ejralE
 9tA41ALahWNQ3AZpZEwwx8tCH26wunG7dFFMPWm1VlxJt8LL3cWEiCGgw
 BSm5JZfuZvHzUu0rYGUysZ0rtj2HClo6nSTig8tNEzgOeFk6Gm2jDSx4k
 lztthyC5WTkdDkCklif1ohH7DtZ0SsQpWPxqgtojhdOkybHuK/mjP418t
 uf0s8yQD4UjiXmKdWpewMjytRvYC6kwpj5bIANFFzGRyM9ZFnEsofdxyT
 8lrZQLW/y9MpJ63UFSxIvTTyh5ngis0G48K8Kc0RX5c0nFj9s9+eZVID0 g==;
X-CSE-ConnectionGUID: V9f42/LNS02LPxDQm02P7g==
X-CSE-MsgGUID: S+K4WA1nSR2zu33glU6sBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="86646923"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="86646923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 00:58:23 -0700
X-CSE-ConnectionGUID: +ZKF8uw7T+unNNBabz+4zw==
X-CSE-MsgGUID: 5goR2icSQ1mhlRc9MNVUrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="181550215"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 00:58:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:58:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:58:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcXd1oBGh21kOgNjGF3hJ+olHrHKfMCC3uUDCbx5MUiJt2hZeMl9RZngXo3TJUMSHoL7mz/n1kZj/oKQQw3lcTlS3dumkkzTaAj9+QVo0r1FL96O2dKrjspffRozXXnAYyqWn0iIIgf01IfZ8fU6RegOFLKKGs1oarV/OVHC8+iA3rzVSfG30XFyMqd2/GKTsTld11lBPL/HLjEM/R8hOJOkGjDpjMqNhOtLpQaEAcYIIOlaQt7+J34HAF5EP43uMFW5Ra3o0jBJ7Cr/dNslkmTqMjpgMqnNUxevAPpG2DbkC4CMeSfBMxHPCkrbcKkBj+gM8OrlXiTzerBvbM3eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeBtJjR5seOLSpQVJ+6a5+yub2skneRLntt6P8b06b4=;
 b=b24bWX1ZJ8lKI2p3Z0yzqgCxPVSEsW1tq3sT1UrDf7EpEecvy8zdsy2KGDDXbclH54l3Jnuqat4WiULOVIAcvNTM93CAmv2mcgU+XNYb19E5pXL24eF2Z+NUqmLqWoSQV6YXCmUVT6FfLHZ551WxNLSdQ2HD6l4I/ZslStHDxBk0+Y18tgLA2KeZuInAYAAGWjugb0VFCyxOuTyb/H95856hZB8hbAp9c41EDe8RPoLguu6SE9gjUdfUDFtyFsApWtJpiA5R3twxBi1aXiAwUqBdFewX8q3Ho3ioHjVi3iAyLOWAV2OVDOj8rsEfow3qcByEPkSdHHkz/rMszDDkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8822.namprd11.prod.outlook.com (2603:10b6:208:5aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:58:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 07:58:18 +0000
Date: Fri, 26 Sep 2025 08:58:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>, David Marchand
 <david.marchand@redhat.com>, <stable@dpdk.org>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>, "Akhil
 Goyal" <gakhil@marvell.com>
Subject: Re: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Message-ID: <aNZHlcgZTCcFkrhn@bricha3-mobl1.ger.corp.intel.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <3819475.yaVYbkx8dN@thomas>
 <aNZHCww6m8NJ_BHN@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNZHCww6m8NJ_BHN@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc47d25-ac41-4d7a-e0dd-08ddfcd2743e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8m2OLhvTrhQXJ/kHisdZDUf0ePFRq7QKhv+0STG8t8jsS5wtVP4JqxPS+LnO?=
 =?us-ascii?Q?dPmr2gFyHfcTut0VxpbJgkoC7Nf5sgK0pYMm9xR17NaN4s3r30gN+ZNVa6JM?=
 =?us-ascii?Q?AO5mz8h3kJPBhA4ScSN5VSBXmeoW5h1KBmQC8JoqOtdYw09HleKhBuyvM5JA?=
 =?us-ascii?Q?8wm2eAvK3EmrCQFAu17LBgQSCC6MwNDwmzLfzoEHFcQiEE96PT72slMo80Cl?=
 =?us-ascii?Q?LqEjWz9qybuPUNg93K4BRGW913QTo4jq42EQAX86eeFywS8zR682k68zM0gI?=
 =?us-ascii?Q?5R9jj2qLsRwVTj7EjtWD0/W70McOxe0KYbSj+nKTJse9C9dMmeggX8AmzaiJ?=
 =?us-ascii?Q?JivnbVz7MEAapxy1cFx179JKINUyO0itSH17qwYj6OaJjqe++takNO48Zc7n?=
 =?us-ascii?Q?mwSmuuPZjUKj/ON9C8iBSMhCqIfSGXjuBd61ezcZdHyaxSNVpZyhiSjQ0pIj?=
 =?us-ascii?Q?SRq0LzXNE23Z8i/PayoCGgtQ3f5SxELTTXuExDI4XAX4MHrzWrmK1IZxLMJa?=
 =?us-ascii?Q?82sBZFTQSmwwZGUchki4TPGq7VapfXlaOPV4P3uWJg88U7EUIpH0MqKMrLvg?=
 =?us-ascii?Q?l9vLfApUdAgEXLhIqEBs1vNmzEMORcP5PQBHvOgzALeobC9BKxKKQzMNroUW?=
 =?us-ascii?Q?j4TjqP2jfPeC0e3rZDBKkYFWJqBJXv4Pw2ezs9cZ7mf605ldeonEQOLIShaW?=
 =?us-ascii?Q?+/6HqzL1td2H0SWcOElBkT6kbSCgyvsvcA0QZ5N/UbcTe6GmslkQ7xWBDHae?=
 =?us-ascii?Q?h/8gKaLdg+LlnfBlaSqSpTd7lUiw4UQJVD5uNz818ZjlbVDupv6vIzOzQTHB?=
 =?us-ascii?Q?urYx3K3aP0UCxvbU0M3XrY1/stZOWZjU6t83NFSibfESDJAGK7RKeAHzLRj6?=
 =?us-ascii?Q?v4MuHJg2opP3MI4t7lNGC6rXvSM/KDEAL4gfajmQO+YgPUVh+gEsAPMy4qdX?=
 =?us-ascii?Q?yuaWfwQjx72qRdVqMW5Yjf/ATCT/NCZQ/unqNtqXyt5MmTiw2NHK/ybx146f?=
 =?us-ascii?Q?vmT3uNADlOCLr8H86BnJKmIGNLVkn7RDWfCtOrWGgOVKp3oFXTKlNB9468iR?=
 =?us-ascii?Q?EbJ6GQnBV/UrDnwuz/hj7jp/mlwMb/Qi+pwC/b2lm1ked7DAnlFcXbHpzGil?=
 =?us-ascii?Q?TrKAwMdYlVfflcOKeTsAryzT31cYA7XoBRqCfQUq0wg44fXcrfLCAsZKcHTS?=
 =?us-ascii?Q?2+MlluHEu+oBz96Z5rIAEXALXw0casJ203M7rL5lbYJBrlUNhH3GKuZPvkXC?=
 =?us-ascii?Q?FqC+tjH9CpB71z7V4mTSwL2hYg+sgOfLbk+w+ZqIl7op5UTwyOmcgR/X2262?=
 =?us-ascii?Q?jFHUlVXp3EVxBMvZCpGfwVIAB/kTKV4UnF3AuX7eJfPQdCC/QxLdqkt1wXIO?=
 =?us-ascii?Q?9nLxTEVIkxNR0M+DbDzj6KVE43zxqfNywEqF2DwW/Il9Qn6NpjYJnnYH+mcw?=
 =?us-ascii?Q?dHVCXmGX5CY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00Ie3AxEoJ0lrHDBj11ceZbVcpqyeEq6fb7X3Iha8otLUtwamCT/4A0lUXhX?=
 =?us-ascii?Q?HZQKHztLGvyAm54jKL1XoIWQcEE/N1Mlr3Cy0Ynk9dbeY4qbDjOPlOthtAgO?=
 =?us-ascii?Q?bcS5l7S66PwvqhTDZpauLBoDX43w8plPwgLSUfbMAIq04UPpXcsxoSHZ7HfV?=
 =?us-ascii?Q?6wRsO3AtwCSA1TlTGFbbhqV+2YBqzS2fgSqK+9Qebc8GfXL4sZTLDPElLayf?=
 =?us-ascii?Q?i4YDmV/G7bgyydNvg2nZoU7g0d3ZV2zhl25N+dxYCTgGLiGl+e6Hgqr3JbZ6?=
 =?us-ascii?Q?Er//USgoNAIFwPF/f6UmfQaazdE7ZhJwD4LjLbuaWL8ED69fXz+HpYzq8uPb?=
 =?us-ascii?Q?e28xNnQKvrLspeSEksTg4hcpKwIg9UzNLk0CLNm8YysG4STcgXcMlty8aHfS?=
 =?us-ascii?Q?NBegLy6aGjhtQ8kq3f82oFEI9barc/Zz8qDUpu8ElHYRWln2PZfKEI31lPVb?=
 =?us-ascii?Q?Pn79Q9UGADPXKuC/IXPGa+i+1q27mzDynNfwntoVF/I4GnOkj76E1FHkK/Ja?=
 =?us-ascii?Q?ddOAfoM30FvX5AhZW4L5UCZsojQtrfiG/IOvLV1ntGmZdxzNCC1rlZ08ZChb?=
 =?us-ascii?Q?up/aewBnY/dQ589RIFkmK0MyPGCCfB+0VkH54Fvb9iNkP39rF1IRChk2o9qX?=
 =?us-ascii?Q?tinSvwEQjlDylU10/fsLFEtCfC0c/nsFTyTzTFus+FoV3ta0HEhYh/mpo9Ly?=
 =?us-ascii?Q?WtZmDQulmWnhhJmkkKs1sc+YBYjkJ2AL3swX06th3cDhy0Oazq4JSyYlPfJ5?=
 =?us-ascii?Q?C1RU8XsZnsvg93LROqllL9CJIJ8+Ecr4zOGrJoTDQyajc64WMlHDoysX2rxT?=
 =?us-ascii?Q?CIkjBuVMoCwHQdff1BkqMpK5bjGmcfXmV2t0/ihTS+4infZb5kmniO+cQSp3?=
 =?us-ascii?Q?HC2BVR9aVkjTjRNjuQCR3ekL4Fprypr6zdimK3AcTA5rIcn2I5CBwiYRx2lW?=
 =?us-ascii?Q?8JL/ZJcnI4PC5u1Y0NYEKkppOthCvwKOPPH681dWq9bqbZxLoOT0PRZcWAVG?=
 =?us-ascii?Q?w1x6AliYUSOILgzljkHo8O2uWxoo248NaDaCnXJiaI708+wv5a2BGYN7kcJe?=
 =?us-ascii?Q?SpNkduccVczDkyIlOqFvvtNVnBQ+AWwDaWdq9PRDzdyGRTKRCam2KQBLbSnH?=
 =?us-ascii?Q?FoUOQJliXA7N+HPwKojXfBQ/MTvUHDWqEOZQwOXnZjNqW1tLRFwvGQxqLcbb?=
 =?us-ascii?Q?tiBRyjbjfRoyj2zrSwoMSvcFcW+rJKciQkDGrbfwZ81dO4Eiy7yTb7L11EgM?=
 =?us-ascii?Q?9hoBZfW2UbakrOOgTgUAR1KOgF+S32BVa72pDGd2oEp3lZC5HmGk5tcCrNI+?=
 =?us-ascii?Q?tHeDnFBn5wkiANJwNOU1TvYAT5WhqitLQkyfbcRpLq67K8WWFIEE8BdXDTfl?=
 =?us-ascii?Q?yXB24wMsoke99xiKfx8rMW9bB4La6hRZ2Wsh/IO7bbzCXD1Yyas6CIAc79Gw?=
 =?us-ascii?Q?1UqIblSo+Vmwr4xjAnmZ2DygZ/lEMY8O2SLvRmQgiNxYf9RRR/cS8U0F40vx?=
 =?us-ascii?Q?fjaWLG2y9V7jAe2kOc9XMr/MES5xUaGM2Tku6IEvEDAV83iI/efLWar8UTnZ?=
 =?us-ascii?Q?ou/gvC23b5lKzvbHArYgEe9FVJ9rZ/BZ9WuEtPuAGH7DVvyIrtmTEWyaUzOH?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc47d25-ac41-4d7a-e0dd-08ddfcd2743e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:58:18.2148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpeTU85gW2eCVTF5rCfZvp08cQsSVWnh4UQOUCsbO9rGeWVzHgDmhezaEjZgrX1JVQAjTtJt5UBLGcmsiUO2N8SHg2FwL3yuVpxQekTWXOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8822
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

On Fri, Sep 26, 2025 at 08:55:55AM +0100, Bruce Richardson wrote:
> On Thu, Sep 25, 2025 at 10:47:42PM +0200, Thomas Monjalon wrote:
> > 25/09/2025 12:33, Akhil Goyal:
> > > > +/**
> > > > + * Constant-time memory comparison for cryptographic use.
> > > > + * Returns 0 if the memory regions are equal, nonzero otherwise.
> > > > + * Runs in constant time with respect to the length to prevent timing attacks.
> > > > + *
> > > > + * @param a
> > > > + *   Pointer to the first memory region.
> > > > + * @param b
> > > > + *   Pointer to the second memory region.
> > > > + * @param n
> > > > + *   Number of bytes to compare.
> > > > + * @return
> > > > + *   0 if memory regions are equal, nonzero otherwise.
> > > > + */
> > > > +#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
> > > > +	const volatile uint8_t *__pa = (const volatile uint8_t *)(a); \
> > > > +	const volatile uint8_t *__pb = (const volatile uint8_t *)(b); \
> > > > +	uint8_t __result = 0; \
> > > > +	for (size_t __i = 0; __i < (n); __i++) \
> > > > +		__result |= __pa[__i] ^ __pb[__i]; \
> > > > +	__result; \
> > > > +})
> > > 
> > > I believe this is not the right place to add this define.
> > > It should be somewhere in common eal if it is already not there.
> > 
> > Yes indeed.
> > cryptodev is the API for managing crypto devices.
> > A new memcmp function would be better hosted in libc,
> > and in EAL for compatibility with all supported libc.
> > 
> > I mean please add it in EAL, and propose it to glibc as well.
> > 
> 
> Just for reference, there is a good discussion of such functions and
> reference code under MIT license at [1]. After reading that, I note that
> the proposed macro above it not strictly a memcmp function because it just
> returns a zero/non-zero value, rather than a value indicating which array
> value is greater. Therefore some feedback on this code:
> * Use an inline function returning bool rather than a macro
> * A more accurate name might be rte_consttime_memneq, since the code
>   returns 0 (false) if equal.
> 

Or better, change the return value from result to !result to make it a
"memeq" function, which also has the benefit of clamping return values to
just 0 and 1.

> Regars,
> /Bruce
> 
> [1] https://github.com/chmike/cst_time_memcmp
