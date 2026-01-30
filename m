Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2177FD49C92
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 10:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1828040274;
	Fri, 30 Jan 2026 11:53:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E97B940150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 11:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769770386; x=1801306386;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1ae+LXf2OG/lgYpRU7aFHVki06NxtUGeB5tUgycIgMM=;
 b=lvwAoja98ahq7pPxFATDSx7Qefzk/CCRCrrrr1zfciqUkI6ACMv+iN2y
 8VVwkR2g/9NOmGBt95r3kB1wQjTojv+lWAoMK6I0wloNSxxEZaSBh04kH
 4HIDBF7+MktLV3VXQV5XcdEW+ep/KVInak07POmQnrCAKw5I3F6U1sr6W
 8AEhJGmgFbtsJd3PCHFVDHPAg/7u0sZwJWGpzsDd3WHSnyyqo519a0Omf
 BVySEkB08UIvhnMmimCSe5FkGrI7vAnir6y1QI8aLsAfCxk+meuJLPwRJ
 gNUZ8dgi6TpAan5WbFRGE9iRKaMHKVPLz6zF+0tuT3kGG6gu4Im4V3aM0 w==;
X-CSE-ConnectionGUID: ceWBwiTsTiGC6BSvvfjLcQ==
X-CSE-MsgGUID: e9TQCC+wQ7+S1JbYoLzt+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="93679004"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="93679004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 02:53:03 -0800
X-CSE-ConnectionGUID: I2zkMPqvQgygp5yJ/8FwLA==
X-CSE-MsgGUID: 1udDiDo1RNaAAE7MwDNEHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="208932646"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 02:53:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:53:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 02:53:02 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.41)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 02:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siBo9WLt4YPl3GoT3CqMcG51FV+FaosSoc/fDuEE8nKNniJTzb+hVEozacYbnlcLG5yOMjf7/D6+Q8sE8DbqeDF48qnOC5fFlH6g2AtwOWziP7GvvZbOUguS1Ed0A2D8mFFd7SK6XgN1NtSfeWnepn3eYRttPrF0xIcRZM8ZYeHgZJEOy6+cGeFzrSeEMYT005z4Dri9oSrBU+CY1TkTTBxU9AFdrQTnQROxuFQJnYblcFRTwIcS0/oENJJcZ92mpqk0TY1nNzopnpF7vJnW5oNuGs1WvNt/iq7/oqUZgw5t6pzHKzQCyP/pwxYTLYtDJJbEExNVVoLOJjPfG33fNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHPaifuXfNxDYN1V01vDEm7EDj5iHUZvRDyU/iiDAfE=;
 b=BWbZrL8csHAHeoKWBX2/5qz+B7xfRwdvBMEda8wzW31UUW4DxhEPc6vkoOvSScvGttOzEUk6gA8Tew8OSH6K4C3e7YTIVugB8H+Sb4OpZzXVBlDLCNHLrCdiAOl0HKnCivON++2/k4LH7KaE9SakmEQmstdm1xf1UujkL7UKtmMer7hd291Rri9Ki/35S0VlpCX7p13y6cwwAZddesb2/m97B3WtVV87/7w6p1H7AIv6pm3xtb6x2+W6vnN/LjVJ9chP6heJja3F5iQXXwaghDZLSf4nEr5SCZSnva4f5fKK/JJMWnkMANj0HemCaxKU5a9Or+q9FxXyGzrjZLlHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 10:53:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 10:52:59 +0000
Date: Fri, 30 Jan 2026 10:52:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130104617.535413-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ee5d49-88dd-48f6-297a-08de5fedbbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?b8PzhLhsojH9dfuHERS09Bv5atyS0Sb2Tembjewqy88R3qMTaE3yJkxZOP?=
 =?iso-8859-1?Q?uBB8GT9NzG76eEOj1RikVuxCBtmXRDEphm5mBtxNXiBp2YnZEGhsW56R32?=
 =?iso-8859-1?Q?emC/ZE3zxaRuqTULhZSipwPwRZ6JAV5FPc8Hje+JDzypNUpOsv5Zx0z0QX?=
 =?iso-8859-1?Q?BBmP0FxMkMIADJ8Ds0umoRXuoO6iVt2AP6dSg5e8o0dpVBsknkna+qWyXI?=
 =?iso-8859-1?Q?bBLIXh9FFUUO6i6cNgr2Rxb/tSHuvxWF3NKfr00IWqYpSkuCbtsE8hkKrx?=
 =?iso-8859-1?Q?b20Jntnz0PqDk1fLCrzvZJtIjR6kcqxNsAP+Qyg0cuvAg2mMuOqAV2wBlV?=
 =?iso-8859-1?Q?8N4Layd4hctrNb8Q2/9oHi8217d9HFWFzb7ANTA6VT6uq7njR+U86Aqv/1?=
 =?iso-8859-1?Q?czOnFG2lXU171dF5g2gIvoMfFmExkFLcuX2hY7XrIlwcPe+uQbh8BEk+pc?=
 =?iso-8859-1?Q?pKZ4H1GdGXkDngnwZp040TkiYjXFi93/ctjTx/ulDXs7U/sP2DtfDsjqKY?=
 =?iso-8859-1?Q?Xs0o0rFhyC19EiTU6t6awN/fo4NXIlEwYe3NlwrUIJaCaXtKG41rTDBnls?=
 =?iso-8859-1?Q?SG/zs7YAX8zFBTI5hjdQVdEqXaYISriW/8rzPs5uFOZpom+2yf9RFCdnuB?=
 =?iso-8859-1?Q?U/Z1XDgbgwNfh++Soi6P4TwnMZDDXENkePaDGxQmcmQoN0FRIpzJDSme/g?=
 =?iso-8859-1?Q?+M6C/VALQIOeTyXCuR7QyrkfgWLr/gkzOLf5aH5f8EVR3924Sx1H4Y9a9h?=
 =?iso-8859-1?Q?OBMjtHcPhP+OmXugKFrVgK91sPJalzGAKByEVVgW4jQs5DEpe3ggUN1Xcw?=
 =?iso-8859-1?Q?pMqYexMsk4gae9jbDkYSe6/lRviJYm2kC9+PetKynLiIiELOdoBzpGW2Uj?=
 =?iso-8859-1?Q?eqKoigEIMSoS6zokbdd6nDmwoQqTvT0uld5hQsnfqJ/4NTpFqN1obBUEhr?=
 =?iso-8859-1?Q?G7iiKzg7dOrW0+QdmcKoHd9DhIQyCuyigUE3xBCz4WaAmEz7HD4PIHjiPG?=
 =?iso-8859-1?Q?U+gDTCBBnnyIA4iC64lUs6atlhLyMKDyGhQZf5OF4NJKA4fPdR4v1qHWsl?=
 =?iso-8859-1?Q?KNRkQ4o2WLIMXtWh4CXnCpXDMSQaiteeMS1cS8b6rdZRkKGXvSEhnuZrxL?=
 =?iso-8859-1?Q?6knyKK0wdhjZVctrw4q6XdmPKWEoOFMC8qI4zhbqvP+dqJqFpBdUKYUgRD?=
 =?iso-8859-1?Q?VEk3TL2SBnYu0F1rGFzRL7kQej8MUfT+JnDYnVD3kMPUeF/M9UJp1alv/Y?=
 =?iso-8859-1?Q?X4+0mRbX7BrMr5viJwXOHiAk/ix05PYZhlnlI0LUvInCJDwKrSvMS6USmg?=
 =?iso-8859-1?Q?9TMRYMQLQNcu01diZ5GX96Go039W5vcV3S1R6zsNAu7vCvU3j3dWJfs55u?=
 =?iso-8859-1?Q?lRKSkfchXf4dIR1tiXvjNpwYR6ydSN81T6ob5yxDTqoCWx05JeDjCQO5Ys?=
 =?iso-8859-1?Q?Lf52EJyI0Upwyy4Mlcy6o2phtPpibRov+HGlmBH3yFAyAm8axZsqRKDoDd?=
 =?iso-8859-1?Q?wnrBvPeVbD5Gpea9QTXd5BQ7gpPKxGDGFI6QSDKIz9Fq7aMexjdOx0tLUu?=
 =?iso-8859-1?Q?gXQKfBM/Hqd4SmU/X3T6IZG6du8ex/zK9yQZY0flXCGi/FsEmkPPfw3qM0?=
 =?iso-8859-1?Q?ISxE3Dhv2ckig=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oG7lSpxueFyVVAciJFLoNe9mkr8AgzpSyZSJR6A1DplSj+GqT2y6lFczV+?=
 =?iso-8859-1?Q?42BJP7+7/BaQjdPyhmqu5JNswP5K8mjnuFdUd+Y/s6agsc6MzZUQDBmdBB?=
 =?iso-8859-1?Q?+ec8PH6h+gbqQzIw215HJYkiuq7cDMjM7EYYejwECH5n9WJXC6CVRsKWYb?=
 =?iso-8859-1?Q?4W+2ZX3bZByVapDMWomlLZmr1yA2lI5FRUbz3Gi4lAtYlWpiUgbYSbUMLv?=
 =?iso-8859-1?Q?urO8VXF/Z3t5yWz+FJSRmqHAhp9DMYW/B+PFgfLQyXpG6CxZ+HL8ZouR7L?=
 =?iso-8859-1?Q?030SPXjfUgiaIRu2dCTKaG1pMhG+ScFR2T3az4dGwf/Sn6HOUlnY0A3wOO?=
 =?iso-8859-1?Q?8xZwtpxE/ig7AZYtZxjhHhT9IWVmDa+4Nxb6zaiMQL29GKngpu+ru1K6fp?=
 =?iso-8859-1?Q?TY+IDBijwqLYVFqzvXVB0o0uH8ri5Zk5Rh08z4NVjCEi/W0ey+wpeKntX2?=
 =?iso-8859-1?Q?Ipse56hC2Uye5mT/343kHp/J1BwIwutoMd+soLiBZlM/Ocn4gEM8e/Oyn7?=
 =?iso-8859-1?Q?I2TAFMaVyOHintYVLAcFONzdSS3187pKrfHTpx7vfhjRqShCKCyDKE2DOO?=
 =?iso-8859-1?Q?gcznl4oRAbdfdqHGWfpOk6yyX4/ebB2dF5OZXZXG6buhn0Jgr8ky5NWDsK?=
 =?iso-8859-1?Q?j6zJGPmRXBYAqvvHUfP4yvZ0tukxEOGUo8htK45QD0JVxlBTN/CKS+0F8z?=
 =?iso-8859-1?Q?DBl08jJ0VBSXJ8ydezZVxcH9tgW5bX5DeHd5HmkgQM1atbGWW6QmomJbf+?=
 =?iso-8859-1?Q?VAVcxmlmV/kHIjX4gtrAj8ihLrlLjVLRNF3GtTLkIvF7xhWkUfhI9fJ1cI?=
 =?iso-8859-1?Q?phalHOW78/7xAGto6XRg21ZP0Hg83CYQEwpLS7jVBr9hNYd8o4MfZmgCnn?=
 =?iso-8859-1?Q?y6+7JnTR0eAbsdVXneL861wK+bnl7pFm8krHn28weyiKMu5CsSPR/UuRDN?=
 =?iso-8859-1?Q?rEDQxJZkg7zV1MrqtjDg1A2r/OcMrlcYcYwiPtKsM7EcNjy6U3ZlOmBvkV?=
 =?iso-8859-1?Q?MEkS675eXXNny2t+mNntleDJY/BsUYZ35IZJnWSITaUnRRAtBi7StiylUR?=
 =?iso-8859-1?Q?qyGborim6Xcb7Gx7fpDX6HtoqYNZjSg0E/PsHPZrOytbwrmiKUmLlsxzPO?=
 =?iso-8859-1?Q?n8QAgZRvSR4mBioDv/HgXY1/WZHDOBslPbJCI3nv1PQMgmOYPvtHSnF5Mt?=
 =?iso-8859-1?Q?6kRhEw7EjxXcAMqMHOif52J9qnrdk5zQG4P8SMVgDPXFRnqPWxgkYktDo1?=
 =?iso-8859-1?Q?Mh4iZp5iMzQ4J80ygQFmwrM6mo0laDTqtezzZUFTqNVjHFARAz/LpMz5uU?=
 =?iso-8859-1?Q?vrIAP/fHJC3GFX7Q/7a6o3IAks91IdSIInmvkW0Po6jQ4nFwXtzW8HZ/gk?=
 =?iso-8859-1?Q?uPAdE3t0lHfiBUvQObkkOQtjHz76T5i5EJgs+kLucFPZcsqZ9TQN/1QItb?=
 =?iso-8859-1?Q?s3JWI/xfJky1fFOCnjV2cipij0ceVdQmFZhmFMWBbf3hRbD44vx1VlnW6r?=
 =?iso-8859-1?Q?NNC5JOO8Sq8EixHZLPles+QC0UaxWSwnOPtXN/xYl9DzWLhqFopuyT6Jll?=
 =?iso-8859-1?Q?sh3TQK6pqMjO8ql2AQUcFSxUijQ5aTiJXdYSB3lpZgKCCnVxwFTSb80cml?=
 =?iso-8859-1?Q?hgIlibRnbdSzI6pLHIq30Iklnc5Vs4cSED11F3K1pt1uGLq85t0MwGOOnL?=
 =?iso-8859-1?Q?yqrR3+KjooWbPi4HbMLv+KcwbPYBXDyz0lhJYXeRryhc9hdXpjv2vEEfYi?=
 =?iso-8859-1?Q?FyGBAoxOiftaTev9EcBKTjDtYAcKkMZ4iHMtbXQl9+Y7gqd/NATnJ9zj7h?=
 =?iso-8859-1?Q?61ImEE0yq1LGXNM3Dk0oclkI6yp3KIw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee5d49-88dd-48f6-297a-08de5fedbbc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:52:59.8218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrA956IRuFHDPyylKliAw66T8Zo0grFE8AfcJCB4LNBAYRpkHkxrV8qp2O28op3V2UzIOjVj1CQgeH38NwAeS1+kgA9pkgpSbym8XUNUqHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
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

On Fri, Jan 30, 2026 at 10:46:16AM +0000, Morten Brørup wrote:
> For CPU architectures without strict alignment requirements, operations on
> 6-byte Ethernet addresses using three 2-byte operations were replaced by a
> 4-byte and a 2-byte operation, i.e. two operations instead of three.
> 
> Comparison functions are pure, so added __rte_pure.
> 
> Removed superfluous parentheses. (No functional change.)
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/net/rte_ether.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> index c9a0b536c3..5552d3c1f6 100644
> --- a/lib/net/rte_ether.h
> +++ b/lib/net/rte_ether.h
> @@ -99,13 +99,19 @@ static_assert(alignof(struct rte_ether_addr) == 2,
>   *  True  (1) if the given two ethernet address are the same;
>   *  False (0) otherwise.
>   */
> +__rte_pure
>  static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
>  				     const struct rte_ether_addr *ea2)
>  {
> +#if !defined(RTE_ARCH_STRICT_ALIGN)
> +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const unaligned_uint32_t *)ea2)[0]) |
> +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t *)ea2)[2])) == 0;
> +#else
>  	const uint16_t *w1 = (const uint16_t *)ea1;
>  	const uint16_t *w2 = (const uint16_t *)ea2;
>  
>  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) == 0;
> +#endif
>  }

Is this actually faster? For architectures that support strict alignment,
this looks like something that the compilers should be doing using proper
cost-benefit evaluation based on target architecture, rather than us doing
it in our code.

/Bruce
