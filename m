Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F517E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 08:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8198E402EA;
	Thu, 19 Feb 2026 09:59:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D6A79402AC;
 Thu, 19 Feb 2026 09:59:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771491586; x=1803027586;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gVtQwDmvAeH8FkSuJJXp6Tpe6cic0Vjz2fGyml27V80=;
 b=UZwVu9gHPb/z6i0zvISE8vGjsBJCRAKEbagsxCfeV4la8nDV0x6oGglU
 Mld0hExVt/T6Nu+rXqfpAOcQX216KMb/DWdVbl0fT9xi1LuCR2QcjmCd4
 iL5kEQc5xWKSuY54oZtaYKBb4m3OMyh4udxZgS3ZPufECBVzn17grNZ3w
 UMUr/AD2UdEvCN0eMkocL/sqllLBzUsOi5JHcxA5zPUgrYSzxTmKKvTUB
 W59lhytZiSA6sKA9+27OvWDQoAAVn7Vy5igc6JK1IMnOXpw/2CwLB3pPf
 rKuLx+uQ7pSB5OJsIBRYZmS2PurdaY0+THdCFEQsz9Xq0sZ8vZO6vAXOu w==;
X-CSE-ConnectionGUID: 5xRZ7TjvSBiVnzjk0jKz9w==
X-CSE-MsgGUID: L5PA4MUvTvaw6i8VQX/YIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="98035644"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="98035644"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 00:59:45 -0800
X-CSE-ConnectionGUID: pg7sAGQCT8S9cv0ZDj0jCg==
X-CSE-MsgGUID: XRG2Ki8ESWuVN00OnCLA8g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 00:59:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 00:59:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 00:59:44 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 00:59:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/QNc3uaz6jYyilouvZGKkZ2aIowzX4P21wnnggP230yNd0aka0fQtvO5SLkaliFAoYmUrubfSG+VWT/cZeAfuPPWekbft5T3BM90wX/dsE3MvbeNFN2t3dyHJ5esCW4gehXt7OPQRbWc5jvntpWcVlnV8Q5FvzXC4u/8UaCJv7oqc2uexjHwDcogmR8aG/KrR1CklDNyUyG0jRQ1OtT3AWPSdWpQsmerBu1CxqTg9QY+DNr1MROSqzugrMkBqRKWKMIt4O1Fbh2rA/S8h1EsDqdXNpyBuWN/EHOvUtw72PzNERiRGLU828JXsgUTDzpumv1oVlMAA9QYmb++2jjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wLWKnu9cn5/tZH4XYrcjy3XAnBLdGFBC5bUkA4ijNk=;
 b=cOL10HIRfvSak12zIP6RB8fSaCePTlAWTBhHQ/bqOB0V+oVm/3MAjGsQHhbh0F/KS3qr8yfsq7QR839gvjLVyQ/LVWv6bMI+V1D0DIiJHiX0UxVWAIKAHmEMkpdRDu8TiYw4/rTb6+IspYyZHof6cFmUY453SiipM5WwZFvTpvB7pIf2Gzx2N89oY3I401XUkChEDP9gTxysnqMroDrbDLgfjlnNZF1O3SC5DLWFDsYn7ARz+DEoASIFJ/Mr10JEabj3Qz3QIcrlfPpjTei+e+i5+RBdF6oWalqHoWtwEf68RiMY41Qi1PR2g3PLg56zCG8LEpikpmc9j9wIoTb0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:59:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:59:41 +0000
Date: Thu, 19 Feb 2026 08:59:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Jingjing Wu <jingjing.wu@intel.com>,
 Helin Zhang <helin.zhang@intel.com>
Subject: Re: [PATCH] examples/vmdq_dcb: initialize all configuration structures
Message-ID: <aZbQ-QZN_c-35Muv@bricha3-mobl1.ger.corp.intel.com>
References: <20260219003354.83183-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219003354.83183-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 0356122a-d434-4bf6-ce42-08de6f953845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9/qs1MKsRrSCBdVnClDDdC0eSz3FbQCp69NDtI34+heTscSn+b2B010wiGPS?=
 =?us-ascii?Q?lz3zYEoZZ72lHkjRg1MX0msnVfoyO7ZMMwk8dkK4eaXskm7flJIILhmcv5Zw?=
 =?us-ascii?Q?cn44WI2Un8q+uFftmZ32Dq5BWPpYyRyPsYoQzLJDBWJ4Z1aiqcSOVshK80aD?=
 =?us-ascii?Q?+OJn0Vh1n3dkk993lTrvcfxgxN4A59F0RxqNhPlwNoDlN0sjbXyqw2w5pzMI?=
 =?us-ascii?Q?kALDoKt05XfaGT+0IdSGPB2iWJMwPnS0q3ck7CHqf+Iu5hUvOREvTETG3oRn?=
 =?us-ascii?Q?VRYLGp78+9E5ZWOxIjrF6mn53OXbO3yg6/AaMFyoGBsSrYvKS0yDIk1Clyo6?=
 =?us-ascii?Q?uw8YiQIxRECt935NkWsApVPC3auCGLHFZpPRJykV2xeNmHaaXshEgdWTP0uI?=
 =?us-ascii?Q?ym+ue7+x3H2BFSlSRE7eB/43DCoB2r0l4m8eqRK1D7hdTm3RuB06+ShiUk9S?=
 =?us-ascii?Q?H5JXE2AqPqG4IL2lQL9y2C6dmIZnaHqE7ILFpggHLj7g+MkKyKC8Wo//MWRW?=
 =?us-ascii?Q?McXLN0lVKtqmQ+s4lDUJVp4z0qbGLq31dHqPNU6LcxSxUyCQuClRjBCZaJOT?=
 =?us-ascii?Q?sl9YuhLXOeugs3BhnYNBMCd61fgJSKiXMieDZPgmN/YWObuBhGJ0YFejU9Ta?=
 =?us-ascii?Q?nwsP3KlAFwVlON3x8pSutQ2R6ekuDhzHV/ehV3am53U8BgLsp2XMJubxawzf?=
 =?us-ascii?Q?sVZvbcWgUX/V/kgqH1wWUfpaVHXKw6QqCXU3snjMdnuEuziZmCOz37xD1QtB?=
 =?us-ascii?Q?lP8A1mOkKjh/jWHpxT+METVNAPGwL6eM1HDqezOavK3UAOF/tVpCaeXKtRR/?=
 =?us-ascii?Q?9AuPyTo57CCr5x1z+RBADUnVxBKKtJd3J37ggEd0nn01MM86gCc0hC/SOr8q?=
 =?us-ascii?Q?JDjp31W/qt/9Jj8eAI5AFhgPOrZsvww8XL0hpCyR08EH7+IWKFIgWI1lapXv?=
 =?us-ascii?Q?LII8AgyueWhB1OnSLirgLlaEx9bbvdh52/BLxYDpjsew6paD18JPK7vi2ym5?=
 =?us-ascii?Q?v/rCVbYaLzT7I8DeMla74yXUDS1IKQpiqLFQsE5B0O4FKlI1knGEEIimbB9f?=
 =?us-ascii?Q?kHufrn2aATqYEOVpylsBqZSBoIY6x4cT+ckLQ2MK21BGhxwVmWPFFgfxVQEg?=
 =?us-ascii?Q?y2TxYH7FygEsity+qamuR/YJQXLYVccQFpG9fFnSzlZfy/2rPXdH5XkKlA+G?=
 =?us-ascii?Q?/bYmzafiGc5ITVRe7SpT2PyJWmPuPF7M91ZGLvxzeBBhccEFQI6mbwvEvH4k?=
 =?us-ascii?Q?NqeIkS5DICJfZwpImYreRa0zYe0X/4vVyYkFU8khlr1vuskcQ7r4YFh/mP3V?=
 =?us-ascii?Q?0OIE4gbYDV9K9Mf/EawxGZPVrDGgr6uT2dheM+5pYV47TINchp9LDBHy78oQ?=
 =?us-ascii?Q?wTJeBKS5wg/7SWpBDPQGWHqAgCptANdOYPxGvWmWLJoJl0Kcpb3i9F+kT9Yn?=
 =?us-ascii?Q?OcOPeint0LtN73eo1Prr4wwiPrXEqH5X9O0LE/22WS1sQLEzsjFtE+dRK5E9?=
 =?us-ascii?Q?qyLJRBBYl3rfWKSEPa90JE7FhLZe0XsD1bKRtCYOvBVJjyCDASLIm4RfmlXr?=
 =?us-ascii?Q?ooNmLaw6Q2XyKRA0oFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72puXzytVMNyH7LBHsU6lZ4PtUnhpb6mFQcUbXIHuO/08TpKPVzOIh6imGAO?=
 =?us-ascii?Q?2tKhd/x0E8NnpWsmk8kc+DMeSlY5K8E6uei59BKj9+muscNjGPVklFmsoFnH?=
 =?us-ascii?Q?wtBq1un5gBurklmA8qrwUoNWLHBdbIJERK+Cv60J2JQynb/slIcYP2ti8520?=
 =?us-ascii?Q?yIf3ifdaVqzZ3fr+7XRFXV+/2L2Ev5a8fuMgvFxVFcmTN9Wy0D09L9aai967?=
 =?us-ascii?Q?PVhOQst5jsBIoqY458CWGV618QfJ6jSsWaDdC2Kcv9h6CbFke1/IaV4z067/?=
 =?us-ascii?Q?XR3exAn/HZ6TOU/ZhiQ6/yVnkElmQJeCfedxRNQ1/sW/JaqGzhfduc/BE748?=
 =?us-ascii?Q?tGWabQ/hJrM0u9jXt9GacOsq2nE/8QCt/1dk9+aITCc30SAOag29AgbC3A9V?=
 =?us-ascii?Q?7eeeNg9RxqkFX9Bf6YfzKOEThik8BPukr8+pruilz/O8WfLM6Zk+9+1dUfZu?=
 =?us-ascii?Q?eYj7RBVFpWPYaD8W9x88VdHKHeIPAVa8ysT5JZlEXz9T2SIA84OqE0t41zkY?=
 =?us-ascii?Q?geqNmWKqfRhcLkrq9O7wUxhuQxH60u34urm7QfMPmQZfs0tRJm3LDx9eysBP?=
 =?us-ascii?Q?4HsYE9yC/jp6NZK8U5h86SkDz1PJrvfqMhx4VALRnaQZuKehcavU6NeWohTg?=
 =?us-ascii?Q?l3zr3v+qLRKgrzJELiyjtS9UcncT3PGFvfWTeWvrHeo8LT/JI41hkOlOubX9?=
 =?us-ascii?Q?LH5PuNdPtbYf8LSogSlXD1aDhOLIk7MNG171kLALeGCuO6ZbjGWGAtdNJsIv?=
 =?us-ascii?Q?gMnCqQ+dwZZz2BdbGEIFbxW9/QLn8+HIEzHvukmiv5EFD4XfMVHf0MCsye3U?=
 =?us-ascii?Q?8guoLcVelgKacGsphm3prd4RXEyfMYeguYmaBIl5OSgO0+auQeUDX4ounzIG?=
 =?us-ascii?Q?qg9FXxiFp/iunvLt9TYf4IjOyUhPLA/WfDu+7APQME9bFdGFqYsT6LKQ5Ev2?=
 =?us-ascii?Q?L/RT3XVDjy+k3tZYA2/J/4Ef1sO+v+m+WS+TXloRf+HGOlduDyLW8yAXd3aj?=
 =?us-ascii?Q?BepOMVHEGuLtJACb9NlZNcZoH4PyBp8fgcEAaAvEFsGEg55cq+i3ITV9xTjJ?=
 =?us-ascii?Q?s49fS0Vbo4o2rKGSXzsptESh6Ulf3uv9dXp3vc1O99Gzt8JcXqWEhGXLbI8G?=
 =?us-ascii?Q?WtegVMfxwyk4vTOW4vUld7j0WlYLXif7vxNoYiwpHjrBeLjZ8y271buweFvp?=
 =?us-ascii?Q?b7FYqZNeb3YUR+N2j0QEfB8UxDMSuoWgbOvk8C+eOnJcNHrw2V4Kk1Zyzmih?=
 =?us-ascii?Q?a609bnFSTIo4ulPFGdNqQ1A8iqrL/bDqSaPWHh220Nz8abklffNgSMC4wK35?=
 =?us-ascii?Q?UzJurDm1wz3El5S95n1gyZsT3YWFoqPbAMhP10hHDdaINcZlEvAJLMrKvc4y?=
 =?us-ascii?Q?twuRA2jzmyMTmL16Mja3AUfHzNfBTBqHJgA1irwB6bg4mw/xUMfaaDm/JEWF?=
 =?us-ascii?Q?D6geAlL3pDFWq9orrIQDAuewJkxRXPmV8IvaYcVocREFtN6irOPRPqJylBlZ?=
 =?us-ascii?Q?8kQSMh6vcEHDih2RUtXmPcf/LI7wcqD3MKe56nHBJ6pSGok6XDG6UfCHOzRJ?=
 =?us-ascii?Q?0Mr6/csm4ZhmuytSRaQB5//4ksQO7iJ11p2XEMPPxpugVqSqG1P/9Um4mgty?=
 =?us-ascii?Q?/or0LRKr1mBZ2is4mm/JqdD07iTxW+X1Bw3hBYJwt0C0ZsCLD5U2O6ns/VaT?=
 =?us-ascii?Q?bOMcBAkEIGKIYnoVPCMR8yMoJEe6TfUADbkAClZJUHrx936rL/c1PLyvX3bn?=
 =?us-ascii?Q?64aeokHtrKrVoyLuU1+T0IIDnKl2VSw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0356122a-d434-4bf6-ce42-08de6f953845
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:59:41.9178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GelIH8jqjqDywvMVwsoEmxIx9VlM1MOERyUWaKOsVCQU1HtzOdhMx7alWbmeEftUWUcQfMkwjslwO5/HIKGefp9DI3IIOnrZOQnNASG1Z5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
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

On Wed, Feb 18, 2026 at 04:33:54PM -0800, Stephen Hemminger wrote:
> Replace field-by-field assignment of local configuration structures
> with designated initializers. This ensures all fields, including
> enable_loop_back and any padding, are zero-initialized.
> 
> The Coverity warning was always latent; the earlier use of
> rte_memcpy() was hiding it from the analyzer.
> 
> Coverity issue: 501603
> Fixes: 8cc72f2814dd ("examples/vmdq_dcb: support X710")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  examples/vmdq_dcb/main.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

