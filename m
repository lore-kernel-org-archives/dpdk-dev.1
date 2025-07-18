Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51331C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 10:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D0E34014F;
	Fri, 18 Jul 2025 12:52:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CCF24013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 12:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752835931; x=1784371931;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4OA+7cuRnhPStMHcioyRMrzqSjPTUz/Djahm7uZxaIY=;
 b=Lu8yHIM5vzbqu0EcovzIyqdGAGIQrNALVVHghUM6xzuuW7nV9ft7+bcC
 uIOztdl6E+i1cvxGfS5ESROkH1QQPuGCjIG0jF7pA9yizvaQvVReAbZFg
 L5dalKE2eoWvzTMugz4/i5eHevduz2FEditeeVUouL4+67NmrJ7SJv9EM
 x8CUiJajpyfsUaJYLzkJRyWhcI+YBwnPvfUlUGGt6wjJk8DpKr0LoZU7v
 /JsUuYEx/HjmfsnY6TouTaFNxvISnXbdbhKKn1Tp56C5PfItnfrPUrSq2
 /bjoZp/iw1j8JRxiWtWB+mrpaXbEdrhVnEdTAeFuMM34olnNBseHAum/7 A==;
X-CSE-ConnectionGUID: yPIQsroMRPulpZ3/bzL1XQ==
X-CSE-MsgGUID: cLPTVbKVRCOA+lwKzHumzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72580128"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72580128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:52:10 -0700
X-CSE-ConnectionGUID: 5q5H+CYLSrKNFTZR3D25EQ==
X-CSE-MsgGUID: yahL5qK/S+eyXYkIQto4pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="162545589"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:52:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 03:52:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 03:52:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 03:52:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb+61xbdS0U7nW3RCwFlG7+XIQP48C+M5wCORxMFKp6UBPynXNfJZv1ND/Z7W/gq7SBbPV+29NLgt9h8+T8WBvvyBN91cFDHV0hIeTdMqFRcNBPOcQb1OmTgdLQ2rB87gn0zS13QSCDHpfMW3ZAG+DCvsZeM1jHGvOlD42lnPH5NuJlnL+m+KlOeuzJPnSX+W6DfSeCklnQF2xvElB2xC5rDUKzU79v2pA9kNmDdZp6F8hOMCkxnJcRyXXjgu6RD8b5lAKS3DEjZb7HzS64cdMBt90OuIyqrc3NDdfGuB0McE0c4bq832/GNLJpEL7Zay1rFh5v+10yb1p7L5SfGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkLjgEd5x6so2wDoV8uN8U1OkoFOouXY+/IVybeZW/0=;
 b=NY9Nt06ovriqpnc2b26w1wcB6n1q+lyWVW0kRHQr+92PhmKotORqL9vjBzAKQOpl69JkBsvn160+PJ4E1wI7nT6ebrhJQ5K2JTlRNlM9iQtpKB5J2XEjFEpGlOzKv4ZPbhkdrDZ1JJsQEavipl0Y+ha/cA6fH6QuKh8fpfO50FKeBZSkODgQB/0QhWQbRtZZgLfoIJsKh5fOGdbF40ou+3U8QSlh3eZ1/I+euUrVS7+zhME5sjU4wWl3uS5IZUPwD8zbtiELN6tfiGSxX+hwkAbUSNTHKIjDMDXMznoHnMKlwk5AUn2dEtGoHXAunr2SKmBX5ixEwMiXIgtv1Ao8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 18 Jul
 2025 10:52:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:52:00 +0000
Date: Fri, 18 Jul 2025 11:51:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1] net/ixgbe: add nic and updated recommended matching
 list
Message-ID: <aHonS9mrtq_mU2s-@bricha3-mobl1.ger.corp.intel.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-3-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717061604.3288049-3-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6538e91f-ae42-4da0-0a4b-08ddc5e91f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mOUWYiMRH7Rq8OtwSj0fZFG2bsjp9bp44e7AJJtUQCNH3HTqB0i5DJO2jqrJ?=
 =?us-ascii?Q?ZLZp3Fux/8BaP8YLaC7+6dx/nfpiUiENclhSEZbhjViW6Zc+MptjIexBfMI9?=
 =?us-ascii?Q?9SdyT7Y8dRf/fKgvcaHJt0AAupgFEgzyv2xPNt3hm4NpAi3Z7MM7HPhiQX4w?=
 =?us-ascii?Q?TmZJgkxrsXgrcfl31OSMm7OWoT0lYCkm4B8CFtfAKeRlai7fGgjZ6/IAT2uf?=
 =?us-ascii?Q?GCnMQ6VZqBE8+uw7hNttFqgwKMfRf9IF543oRL0sKa8WJUBxbzYxMEJNKdbW?=
 =?us-ascii?Q?XRP8JGeKW+H0J7Fzv7ZlUf75GDQeNQaRU9Hj41hkQwrQkybc0bglg7T0qymX?=
 =?us-ascii?Q?fWDk4RiwFOq7fO4WF6PORCba1X/A7B5RJ4Ejim7TAlb6vkr7qGDtwVIbdF5h?=
 =?us-ascii?Q?vRENECxm7+Ul9sQmtp++GsZWbhgIyfQ+r6R7nXYwCzLxEVLKQo71p37KU00D?=
 =?us-ascii?Q?csJjf3e52ZcCs1hYqffvhiaf4Fs4zexWlmm3LvsWgTTMtKUEB3B+r1URZGL/?=
 =?us-ascii?Q?symoAFsanA4P/37ALttuG46wESe6IKdRTItry8aRfK7HE4wBmKqeO+AUKJhV?=
 =?us-ascii?Q?7T3ULJGJk5zbwOiAF4pa7+6Ug2p7ulRiZfeRjO18eg+iafMkrTSTjnWjNKmF?=
 =?us-ascii?Q?RKqIEeDNIKzpRZxVA1Yxq/K+T7izs2rwGBZ9bafKfPPexJ0Jx82ygSAM+Kte?=
 =?us-ascii?Q?6f/5wHpuLlam2dLbogd2svzfSRF2h1AGf3x26bOuMk0li+qecYMM9fqn9KLY?=
 =?us-ascii?Q?0OzjlHZCaK6JE3hk1G80EoP7j+LdRpp+IMoAKtXz2iERLizRGAsf6hbah+BT?=
 =?us-ascii?Q?Xq1gy04IwYx5BE9ix/3U/N+Yw0qR/5izc78C4fk/If3pv82IkLL3SbnTLQBH?=
 =?us-ascii?Q?FHjK+m2M+yhd/NbvKG4iD+x6ydfUTRa0yY/V6G38WGkgH+/4zcH98mG50djp?=
 =?us-ascii?Q?8WywqZX3hjcnE6B8kWNUuVEFMBL5nWBYjlkOxORK7RnIq61BHtFvg3O1lOxk?=
 =?us-ascii?Q?jC0yoHSvGFElD2NXU49Y0/UW531M4v0c6V5Sr1CfsGitPDvywF2pVovSuggO?=
 =?us-ascii?Q?rtcwABfp43dI7/ZGXH00NPUghcumZyouLlPy1ni4JbwR0TVnyRfbUy28a6k6?=
 =?us-ascii?Q?vrXh4i8KZOBAznDAXvjtq1W4tdvxwOGi9Frso+xlI34PK8Ypv+8Eu38NLb2O?=
 =?us-ascii?Q?b+gxgloRYdoR9QnOK5rgorB+gUQ1ot/+UhyS5GlhR8+GPwEAQbhyhPJPoLCv?=
 =?us-ascii?Q?RQYnSHumuJAbrsq0cJK0pi2TCY91rtvqGui/06awWExc6mh6azeuBNJIHfu6?=
 =?us-ascii?Q?20cs4dz/jbao84by8RHyIGgv8pfjewwceit1oI5KX64f0vvLp8xJ+Dp2As07?=
 =?us-ascii?Q?hiDlFH/6u7SM80du8Z3/rmz9WHjcledHKqM5qVFFP4uVkyiKgT8bkJ/n3oMH?=
 =?us-ascii?Q?2RUIlEMytuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP6pQJKtovWxouGiA1YgWVNevYdd2EUAxr6aZyRrGpb1wvahZCbFXwXNVIxb?=
 =?us-ascii?Q?oS0DYkzJtBhW6wlBNO3GKghvkpPs6zyrm2e/ofmZa0kCMI6hOq4nBB48FV7c?=
 =?us-ascii?Q?xzRQ/WOmDgBXZ/r4+DFY7eV5BukYg3kXxbvppwfR5qblim7FUinsgKJstpes?=
 =?us-ascii?Q?7N/lWwGcas+pczvj82Pqk1xGrVNwdK2M15/XJwxo6ljap+KW3l7qcmv1QWEH?=
 =?us-ascii?Q?yb2SOW23Q+BoYrvpUXxDrZntUKRN2EBHTStI3xcCmDv8kZ6wLufrXyqYFaNg?=
 =?us-ascii?Q?M2Yr0ZQEwzLTWeJK0hdeW68tTCkX6/HlPPGuQ91PTry3eDLf+9ZbBw8PWQWA?=
 =?us-ascii?Q?BrNFsqPmo4BGAO7oNRm9vFFp/ZLJVZt9AvN76fVk+4Q9QnTK2uPgjZ5Indsp?=
 =?us-ascii?Q?MNbEdS2Q7Ll3FPh11L1HWk1ImUCkpy9q3wRUM9tEzIRPF3hyF+IswhEZls+c?=
 =?us-ascii?Q?eXyt8B17/FHAAAGSE3uyySIULjLoSrx7NRdBgwGKafzAq9bGHkDa73kJYxhb?=
 =?us-ascii?Q?pL2aJQ+oXXk5HvON4oYb7nByDkAjdIGCG/KCCtGD8nrC1erZ4RZNqunjyexy?=
 =?us-ascii?Q?aJ8e1WegylwCvysi9Eq9MRXh7q+nFFAzDN2R2hXIHO+vRVjbw9Hd7OTYei4H?=
 =?us-ascii?Q?HOfTf4uyExV4fzoVynD4n/gwp3R1ouheE3tGpzqF6IrF7eo1djtz2r/s0Lw7?=
 =?us-ascii?Q?CXmCNamh6B7xTQMnrrR/xJKJWzFVQrDuEk44wXhk1dtihVmU0MMzV2eQfpS2?=
 =?us-ascii?Q?Ry0jz9p9tYCzYpFl+mB8mYhmPX047flG6jvk8c2off2Kf/M8jOg8+/MkpZev?=
 =?us-ascii?Q?33Bg9z+OBP7U5lfIC4ysebuhRtvv8XgVzvSPxqmyUIjnEAKtuQ5AwxeLYqej?=
 =?us-ascii?Q?lD0woKNgKcBnA5BjEHFcaEju3fyQqNjueMY25wOmJX6VoO9n8Irbb+DVEYQH?=
 =?us-ascii?Q?8a5cYoSIXP5lkziimIrTKyv1xKZOT4Ej5Tl54sfz42x/kyPsi8YlcUh3PvU9?=
 =?us-ascii?Q?MDl8xxSAIFq7HMtVJu6Wfw3i04JYoiyPQC5RvfItMAP5wiGvYF/Z3l7GPFxm?=
 =?us-ascii?Q?DgrYktDAS1D0rmSYdulT8MYnb4bw2Xt+uCmbUlOxEc/0tdz6gZkPHltD0RRH?=
 =?us-ascii?Q?ScT9qxpqWU6Uq5z1eCZplaQeEwainYaKhkwa7kM0tNi8u99foYs7ZSXeCkkK?=
 =?us-ascii?Q?lA0V318MEECv1QuYwQ1Qqma2V2V/eI/SSg52kkD51C3xGIiaQkLEntgaPrGU?=
 =?us-ascii?Q?z2W6lKUEBkSEy1Qc1YNEHSEraY26U+GMUCkr4rEmdKAdQHRucu1AW5byr+2W?=
 =?us-ascii?Q?Bcdi5ufBnWMcjpfBSoq+i6JrjUAuv/ElbN4hQTNVoQ8SecKIyli2GjPgXtwI?=
 =?us-ascii?Q?gGpdubeyyo6sm3Hzbds7f1kQE0USzqBKW/w62CBGsOdeKzY3SVvo5dPFtoN9?=
 =?us-ascii?Q?/x1rkO+Th4KMfrP+gIxPls+PyP9M40VBuJG6fs87cWch0pj/wfI3GhQJQqNN?=
 =?us-ascii?Q?a9+mdNWGOOcm9ug3dr9nOOjWjeoyvL6h2SZC5VGemJBlP/s6OHi0UBh1lKUb?=
 =?us-ascii?Q?GFGdKa9kra76HI9YdxvWxpgOAb89HAaiRpu4eGebgEM0eynFGUNMeLlMDhbY?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6538e91f-ae42-4da0-0a4b-08ddc5e91f2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:51:59.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkbbQ7QjAVH/fVl+Dxssu2X2q6w0fFb2D4hOcRilhTJjfXcGa0f+wwaoE0jNMrNbgx/bgVVx5yvZ3SkGR4QEVZpMARgmX1UTZg27a1YlVok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
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

On Thu, Jul 17, 2025 at 02:16:04PM +0800, hailinx wrote:
> Signed-off-by: hailinx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index a03ec7a7e8..6380e18feb 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -36,6 +36,8 @@ Supported Chipsets and NICs
>  - Intel Ethernet Converged Network Adapter X540-T2
>  - Intel Ethernet Converged Network Adapter X550-T1
>  - Intel Ethernet Converged Network Adapter X550-T2
> +- Intel Ethernet Network Adapter E610-XT2
> +- Intel Ethernet Network Adapter E610-XT4
>  
>  Vector PMD for IXGBE
>  --------------------
> @@ -93,6 +95,25 @@ Windows Prerequisites and Pre-conditions
>  - Loading of private Dynamic Device Personalization (DDP) package
>    is not supported on Windows.
>  
> +Kernel driver and Firmware Matching List
> +----------------------------------------
> +
> +It is highly recommended to upgrade the ixgbe kernel driver and firmware
> +to avoid the compatibility issues with ixgbe PMD.
> +The table below shows a summary of the DPDK versions
> +with corresponding out-of-tree Linux kernel drivers and firmware.
> +The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
> +and Linux distributions that were tested and verified
> +are listed in the Tested Platforms section of the Release Notes for each release.
> +
> +For E610,
> +
> +   +--------------+-----------------------+------------------+
> +   | DPDK version | Kernel driver version | Firmware version |
> +   +==============+=======================+==================+
> +   |     25.07    |         6.1.5         |        1.0       |
> +   +--------------+-----------------------+------------------+
> +
>  
>  Feature not Supported by RX Vector PMD
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -- 
> 2.25.1
> 
