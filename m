Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A68C021A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 15:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07E91402DA;
	Tue, 11 Feb 2025 16:54:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2A004402C9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 16:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739289244; x=1770825244;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=eoo73kxywONzGQK554edfVa7XohGFUWGn6dXHydB96U=;
 b=bg6EJ8KA4oOv9ZxE23boNJG+l+ic3ZLg94jW49EAoQ63rFPPt6WZCU/B
 wfas6bDio4Mu6rwSN1EYbBY/T0GuDthwrLBgshHk1TUykjX7jtB+gVtPj
 JM6/JZOSIwUukzzUytri79mRG4gDe4Uc8JbubZPh+TyGO7biMLBIq0w1i
 K5HW7ODlpw2S1SHMb5KzTK+jdFjNjbAXTcobWp3CseHkaMihhTNaYpo1X
 WKBozGAuAkp0HMYKXVEapjavEtB9p02ljH/SesR+l9EQG7ksmfb1YH9IM
 VQhY+UWVH+i89iTzFQfGyfd/w8vrkA6RQLiN0lyWwURtdJP2cIkqABt6Y w==;
X-CSE-ConnectionGUID: BM+rVnNNQBuR6ryD8ByTpg==
X-CSE-MsgGUID: i6Qsw43OSKWKGjAx8UDMsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40181757"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="40181757"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 07:54:03 -0800
X-CSE-ConnectionGUID: gyNl9qGTRFiuU0CiTJwPAQ==
X-CSE-MsgGUID: tB/jEqEcQn2BeelkpZxIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="117562722"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 07:54:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 07:54:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 07:54:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 07:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIjU11EzXJiWhZOCzoljaJUzQlRGmshKtjdIrWafdgSRK/US8lnvHGWCip2As80oKERUJz6jreFu6p7Pfg7wnDUIGxkRZPJDnSMSM4A5VyXDmIJ3JArmf8Nqg7Y8XeB7DInV7PPyDTfGuHPOYgvwFMqx57elUv7qoDUqJSheWuMHaIhO/F24lSs+PyvZEDR0gi5xaMMrtJAVFOQj76w+d6DRdztQyG5Ubaq428eLY4ed+/vvD3VcWY1qDlqKN/ayl0J+/lgXcIMb2fUYGBsoh9FFiJg16M7t0WxXa6PFzoRmF+d/zljcyja1/BEOesvexNDdr8zyvwmdNYqGIRfGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXTSQ+L11ckd5uvaCDAWeg7K1KP33LN8DDywnUQTIbo=;
 b=bmHt7dEGhWq/IuyM7Cg4X9hWkrvh4+Y3mGVH3G5gFy2/arCNH988u0QT5Ly7f3tHu4Y+fN4MjM5ZX/ysHO4rr4t79trDsDs6b25rmFtJ7dngg0ZSMqId6fVciWYjFzNII46g9iBF4EX0RC4Mbz3knnLg9PhrJmMAePn3pepzN9nPN18BziXNXII3Dbf6GBFIkwl/Ob25kHbFnA7oUEl4mrBQ3/rUZLe8KVjSaHhhouYm9wIh51puUXOPYiF7Jux/puLu+sYR2bGnagJOieykiOp2xeZQiv4qkUnBEoqLpGMiu0aOoJzq+4XvsVDV22ICPUT8Vi62fh2aV7GhCdhppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 15:53:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:53:32 +0000
Date: Tue, 11 Feb 2025 15:53:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v5 0/4] remove common iavf and idpf drivers
Message-ID: <Z6tydj1CB7C457yr@bricha3-mobl1.ger.corp.intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250210164427.1118265-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250210164427.1118265-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c06d280-c6b6-4a30-ce5e-08dd4ab43c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XdqLHNeI/tgzU/8GyfziZKqLSD6sE/0kI+4oo5rwg0pvoN2yccSZBxz4zXxe?=
 =?us-ascii?Q?hIeCinh7HBN3KdlG6thUCXTOZgkgYdKvcY0RBLJPzz6upDyEePX2Yn3RdPU1?=
 =?us-ascii?Q?9PPWpBKD7y96LKKMZLWI8sW/Q/m2GqZvQsZwJqLwwVwLUgz4Rbs7erJnQFre?=
 =?us-ascii?Q?0YJ2XkDyHRy3hJLNaxe/4qY+Pn/VLTyFnSEnu9VM1Vs/a5nOC/9vMpC5E5YI?=
 =?us-ascii?Q?ngYKsrIudJiREUap6fHYHXbMbnwQpO/8tgrWbKySfRi1dwcEOVuvZptI4tOz?=
 =?us-ascii?Q?/SCs1WQrKKDBzhkQe4SjT8nUAH9WT6BnLTjZRHJZ62nP83hkqnf8ZNHxwNNp?=
 =?us-ascii?Q?YCDwabJgY3MAtxm+zOX3JSxO/m6ouEZRlfmPUVFYZEJIn0lqAllj/Q/uTtRs?=
 =?us-ascii?Q?3I+/73URrn6dc3sbCZcbM0Jg5X7JZ+oNSxqiPrAd8AJCyhSeP5fNQiPwp+XL?=
 =?us-ascii?Q?I82RDynQsPK9Xr6jLI2F/DOiNYu3s57X/SnKcbPBFxnQo1AztEyBMCvDaeJF?=
 =?us-ascii?Q?k9LFovD3A0/eh8uelswcq+cFnFh5OSkJnZv7T+R3RvG/cgF5mSw5uy0pVB3D?=
 =?us-ascii?Q?pwGLCbVqCaRIWmfqW9BN0KBqAuWtyhH3GaSFPzaFv5uIfKq6qLBG2bqYPJNZ?=
 =?us-ascii?Q?TJ6TTSuALATd57c7hHH2R0k7zHsTEd5h0X1ICHkMrvs9atBPYBwye/h3wqtE?=
 =?us-ascii?Q?mD7oejsBcMDLYeBbrpPB7dUDXRGeAutlbl4EYdY7IhZxnTPACboFxJ3Z9rmq?=
 =?us-ascii?Q?0iakzDNssJ0qmhelWc/TlH5OsFtqdsFex0jPRKlIJqXWBmgx2Ctz3xbe4H4Q?=
 =?us-ascii?Q?Pv5UHUXL22IY4y0zPDiUWSvRtBgcGPcmzEtHDhLC+U8X1m2/vxAfFOKAPIb3?=
 =?us-ascii?Q?OseiF/vfYWP3eUSSeoyoWck9/Os/qPf0HBgx+rN32WRmLOPsEZgOogZ8iJ5o?=
 =?us-ascii?Q?KnRPXccoL4mVqYqI7RjWAsvwozK+ub0YmE/0xTCAgT7sF2EUdDJP1Zlkw7tC?=
 =?us-ascii?Q?XewkAv/4zyowchaAgcmePWSVm8NpXrSm9jRm49sTtwOIt4/R5787waKZp04O?=
 =?us-ascii?Q?9QE27SggLH6lv3WQB69L4Xtwpa2o2cDePP0++urdMVF+FA0otTt/nCIr9N6d?=
 =?us-ascii?Q?LboeHuU0l6fAkO8Z+x1pFQ7/V0vN4pp8hh9q6FIs/aN656JhwUgI6n+cC2mo?=
 =?us-ascii?Q?LofQOyAdLIpJZxePrbW6LknL87BoLHzkTy3SB79neExmEqxIIAmppwYXtf0O?=
 =?us-ascii?Q?HJRsewTXzZRaU/RMaJWzv1Ru6rJQrN8AF7Z2GMuOGOUtJyGUmAvIaL1LOSsH?=
 =?us-ascii?Q?T0IiQANxXXD8/ONkYln9DsZfoDY+Hdi2qKJd80n1urWLoqc3psLTroty3Z0B?=
 =?us-ascii?Q?31qwjdhLY6kmSYEMH1YLhMLWI8Oo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjNsVqsI4VcQhL2Ech25RcsROBsT+wBWNzzLU2zrIIlLIG7r8Q3KRtLnBsF2?=
 =?us-ascii?Q?omOHtyqBxVexcn+tcmy3Ub8mHD2aB9Qar/NI2ZnN0ICegH1mSyLdkzxN3DGU?=
 =?us-ascii?Q?JQnPnZDgrGYIxP69w5DeQoHIzokOmNOe/wHrXyD+hij9fD4ytMztGpzY8P2o?=
 =?us-ascii?Q?NsiwnyTwMPgAbBb09/i0JTGTbXA5vcIaRgbBSKKe+leZI3dvrQuRYrkrpWFd?=
 =?us-ascii?Q?JA6g4xGXEbxdRNq6UWyHK6DhupWaoyoFX5F5qAub23VOQQ9Hizhn6tUOdKVp?=
 =?us-ascii?Q?XJkK8c/EyQU9gCRCUiIWHObzPbH9TwF3U9NpsFDiaWJV6NSqcRdnM5Raz1RE?=
 =?us-ascii?Q?8HtHvdN63pMcChe7YzupPolqb0ECFk/tKpsiXs86j/9Rb9KBGU2fWfyWafI4?=
 =?us-ascii?Q?6qEqTNPNo0+lMQkE7NahTdTzCwa3jB7s69ZnnPBKHBLox/LKf+3LVAGIzrss?=
 =?us-ascii?Q?tbN+uM58aTLElKj8XW6/ax1i3ntszA1TYQGehDJnuxuk5mW6WXpiXxgwpGQL?=
 =?us-ascii?Q?ly862taNyA8oXAPwFJvoihKIl0HU3tasQmdjkkZ9UTHBNR97GlWNwD5dak/Q?=
 =?us-ascii?Q?GwLHnPPoHQZ/YMoBWRiFifbaWRHvABpBj1QMtIMJmz47tTCTYgb9LZoLNkMp?=
 =?us-ascii?Q?uEzBN5HQvzsp3GIh3plNODfAWGuhBXpA/Y9HxnnCvrWS1Ml2wy/3soQS9gpn?=
 =?us-ascii?Q?nTXcBbqllMwHnibtGijv0H1LOCP00Yww709i+gLZCJt18/AS/M1JA0Z9ij+d?=
 =?us-ascii?Q?ue4gcobXXJJhAklaMphDvtUg2Aj5Cmk0AmDhmnsqVwtvJ1Ng7G81ztrklL9r?=
 =?us-ascii?Q?YDTrYgIYw3vqye2r/rQwZ6ZVccIH7xwbjTDdAigs1uLSp6FefAhOiNMS1wjp?=
 =?us-ascii?Q?eIGXZvvbkMs431fcDItFkERK5jB75WPm8TubsbRxy23wJ3DHsHxb8HqmU8b9?=
 =?us-ascii?Q?e49BNpUMP3AED2oMC7SEbcAn5AvzrdLo6WuBduHLdUpdNIOuFxv7dthGwFsE?=
 =?us-ascii?Q?9QWRt/MAD823zljTuIKcDY4nu58DgGGqYPl08M7Uxo8lMFyng8ttIGfehTO/?=
 =?us-ascii?Q?MvxEM9Z9Tt5D0Z7FdgoqtDXGMHTaw2t50aVV2+SJVhY+VjOkgI+vxxDyphY3?=
 =?us-ascii?Q?XHzH3Q+jl8qszYrg3uDV0rS921BlTxH3O2HKg3LUQy4OX/Ct6GtG1c0176t9?=
 =?us-ascii?Q?MiDcC3Q2uqKCbSI+P8JZ97Gcu1rkSkgEID7tQx943RgB1BpUmKDBnpkVhlyI?=
 =?us-ascii?Q?g1V27pMk2nQaOCXnZpFOwgKyYGqxc6nYOdJd0EDYJUpEHNUSBWdYNfBzmwcJ?=
 =?us-ascii?Q?kN7aut/WPS5WcfmrKEqhPHSbLrJoBHH+51F8bw17Py3cYYNXIhK+aOSFyB3Z?=
 =?us-ascii?Q?8WYuCvwz/Vf4dIToXC7kIZraCD5Zvlm57jr7rX/gsyZpGFJBrxe3q8TAk3r/?=
 =?us-ascii?Q?tj0QI+BHT2sACUJmjq0kx5URelx2LPDyLSAB5p6xVBYQDzOL5d25h1Uiyeht?=
 =?us-ascii?Q?YDiA0KR5SLjPt/N7/EPVkn5/qjcFKvanlE3vTvmtV2HnSlLJePx9T8sjeA6u?=
 =?us-ascii?Q?PHK2cWTDVoLyjBi+sPoyxEVWDf58lyFLfpDMv2Blq+opXpUdjaoyfn48INzT?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c06d280-c6b6-4a30-ce5e-08dd4ab43c4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:53:32.5116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeR3beFIurEXXdmGIwhQjGGMLrTa0sZloWRQGPpbQO7gOFiqAXa+cL+OjFImdBHHJV0VqHlbo7yXe/4PGXljHH/2VCUem182dn0q9l67G7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
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

On Mon, Feb 10, 2025 at 04:44:22PM +0000, Bruce Richardson wrote:
> The iavf and idpf common directories were used only to share code
> between multiple net drivers and did not need to be drivers in their own
> right, since it is just as easy to have a dependency from one net driver
> on another as a net driver on a common one.
> 
> This patchset therefore aims to eliminate the two unnecessary common
> drivers. It does so as follows:
> 
> * merging common/idpf into net/idpf and updating the cpfl dependency to
>   point to the net driver.
> * merging common/iavf into net/iavf and similarly updating the
>   dependencies, including the paths from idpf (which does not directly
>   depend on iavf, but does make use of the definitions in the iavf
>   header files).
> 
> Separately, two other cleanups are done - one to remove an unnecessary
> warning disable flag. The second is a little more complex - it makes the
> dependency between ice and iavf an optional one, by having ice compile
> in the necessary iavf shared code files in case iavf is disabled in the
> build.
> 
> v5: rebase on top of next-net-intel tree
> v4: fix meson indentation issue flagged by check-meson.py
> v3: add libabigail exclusions for removed libs
> v2: include Release note updates
> 
> Bruce Richardson (4):
>   drivers: merge common and net idpf drivers
>   net/idpf: re-enable unused variable warnings
>   drivers: move iavf common folder to iavf net
>   net/intel: allow building ice driver without iavf
> 
Series applied to dpdk-next-net-intel

/Bruce
