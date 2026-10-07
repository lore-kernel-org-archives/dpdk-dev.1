Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4EFCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12C6841157;
	Wed,  7 Oct 2026 10:04:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A7E5640290
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791360274; x=1822896274;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hwlNJUXP24vswmxnbZeY/1RpFMq0jF7rgotdOoA1xjs=;
 b=TXSZX8XhIXIsRtwwafOCJVt5GOXpmIqr0pTVKsNwHucOjZvMQkW5C/iZ
 l2cpL+RfkUcR1wHeiZ9+HhUA2Fjs+/XDPLLvIJORw4tTPFya/g/Apg5rG
 QMjBtEW6avYWQpMGt7Q+11279LLd/HXOoCuUUWS8/RjuQjqF2TB2BuB1z
 1+fRD+UTmPoiT05MH1DrQsDO/xuz9FIfkjHzoa9dtf1dgoRtMxuqithZ1
 Du04AhhuICOu/kEyRaOx0kHsBwPiNXOkeIArmnyXN4/StCp+v3VhZTdrc
 LJkgGZdGjO83lmauqmFzN7hXAN+wW1LNyRVzv63MycvO0axBYBxUl3lM1 w==;
X-CSE-ConnectionGUID: 1R7n867yQcOVdkRe7YpZ/g==
X-CSE-MsgGUID: EXOGZpm2QPa+KZs4BlLHpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="10525"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="10525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:04:33 -0700
X-CSE-ConnectionGUID: MbOfBnO2QcSISd0x4lCvVg==
X-CSE-MsgGUID: gjZLRDyDT5GK0Zmt1O31jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="126625"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:04:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:04:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 01:04:31 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV6ieYdbL262EC1Qeyj6qY0k3tgluGUwLmkn+WW7p1rokpCCz40wQvc2jgOOdzCeMEEt6S5ZDOpF6jz39QnjhJdZRp0bevmGgl42ZUpmaBFpgmGHmxjRul7Pa5aYMqToRxNgCEW4Cd+vZ4kuabec/U2QZusbGZ3rTfmtq4ZaJsZRBAbdWpGpKnFCXm2VLZsIZd1bP7fwRCIrFh751iLdgzrRbmlVSI//5jP6loW99fPHH+haP8C/QXarxCX2VoPchdT/Ka7emG2IYRRX+Hb87BjCUiB03HSXg3TkiSnTNuXW9QK4Tm65I5f0esd+rpHWMfvVenOmSKfeolgJk2YmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAaoGH6BTz/GZz92yn+TY/1w21bJXgHGxxR710OGhG4=;
 b=LPXFE9BsDOaThKNehWvuLfJGYbgLRKdgqr5CUrn1OW6Zh4ipOwVpMsG3hIv8yS9Uz1ITcrs26gCyajer32RS5WE98TJjIW173icdYqzrd5KrHwDHVKNiy/9Uy4VgaERZmh5DdRmFee33dRzjmmsSkMsrUGY/d+r1Wl/bTd809Yh3B/iFY8qs88fZuu3/81QTMvqISUL1NeM+x0FY3xczCz2m840U23u0mVdARLS6zBiLFX2vnBpOy2QOVGeRejBmPMbLl5qyRtlaLtqUIEioSEuVkaRPLoHaiO852Anlg79PXLD1OB0ine0d4g9GIxC6AszVL0rVdJjhk9qFSZCxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB798475.namprd11.prod.outlook.com (2603:10b6:8:528::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:04:29 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 08:04:29 +0000
Date: Wed, 7 Oct 2026 09:04:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/2] net/ice: free memory with matching allocator
Message-ID: <asX9CRRFZAsArLss@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1791356190.git.anurag.mandal@intel.com>
 <c9d029d702469ebb734cdc1117ee55bfcafeadb0.1791356190.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9d029d702469ebb734cdc1117ee55bfcafeadb0.1791356190.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0167.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB798475:EE_
X-MS-Office365-Filtering-Correlation-Id: 2381e04b-7544-4fc4-a164-08df24499d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Z78mUhEppunql9l6L46WnnMkfksQx1a+1o6GD2lfH3G/BYFpYGVg5V469k7IQYIHSNueP4kttwY+4BuQGjiExNJt26y61p39AxiB90E9v77fffrJ0ihquL1b2JmsXASnCS04RHAkWw0rYeRKsHKmcEMPDaWMZja0n1SH4LxBe1berOjnHlvREcPVA6RoAmU6umayGP7dPSe+5lQ3tqWzlXCRW6T7SwkzHpvXxa1wx/HOZXOjj6+4gYKkTAr8zJdTyRCJWiC4o5py7VV/bC6fiyW7DOMieMCCjxFQnIcG/Ny1xUNy6+sq7OoQ1jv1kkjCY5Vg0PwmS5nGZ13ZoQfZJ1ig5RRPc8JDlCU+uV+lWN1DSZ9wURV5JZ4mm1icubFHeh88nzzsrzC44Bl2OGSmogsD6cJZD3Rfm6mcwSjkUpb3BxCt/t8VfuOIdCWnfqb8Kj5YHpK1izX/PEwPgYZ1AC7wn3doDFx0oqqDeADM7lm6VCx9whrFsuGjv4XfQtVnmxGtDBHSUw98ABj8j1qzpwoI+5FHJvmSmZS5rLrhQgp3twwBzkCO662OntRPEGlojDO/DHFGb2+9rILeWr+1v+9c1GO60aLayR903POMpBavTdIp+PRRx0ukevnrey4gFv7eO3Hg603E1EeuJ0WtjIhNDv+gz5uG4taEfTkFuWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Tzh7u+dU8Gxf1rcNAHY1JOCbBHQkJ3v46xUiFROEHTnOnZfw9TyS46BnyzF?=
 =?us-ascii?Q?YWitA2GXDeyImleSxZ+GB9jDeefjPDE2Y5p7x57ZyvCCb4TwwKoOzeIpO7TX?=
 =?us-ascii?Q?k6coFOFx3K3IipND1lAbxjea9a8Sdc8Du4I/EhPrVfAe6y614yNWC6NG7GLO?=
 =?us-ascii?Q?IAzSt5XgPokoM0kV2un98XNlagWeH5ySo6PTyhFCB+HkhlZ0P/dOYQH9uvuG?=
 =?us-ascii?Q?lU8g8NcRFljwdEbVMSY7ZE6glMNEsXvpXjgIuzhRLPRyOaK+ZuFGGevhmJcn?=
 =?us-ascii?Q?dRQ56azeG8I/JvoOlodbCzrE8EZ/fUysxVdz7leOsYJrL9S1ZijXvMScyl6A?=
 =?us-ascii?Q?sSSwcomnxAIL7EFL9CejYht+Qu+AnRwsYDKiN5MWWr2KmyVw5BTWi6CANxxZ?=
 =?us-ascii?Q?q/8Wiw9YtcesWx1WfhRMKoFGNRRSOP6NFjGgxWjo/dtNgSRfIuzaKmAt/POL?=
 =?us-ascii?Q?CfDUj4YF8Ky68lngTbS4LWhKgGOH3BTe189YFYeXXeXD91m0aBP7CIZgclS5?=
 =?us-ascii?Q?E/AVTSSwhSUO/3Nx22+64AWemSLlRpVoaNEGGvfNgeKn+byaTnCXQnFSHs3z?=
 =?us-ascii?Q?btegiziohqN/WiY5AhV8tw1A6zd7dtrU4RCSKJVVvOZTwt47kVKkiIQl9QDx?=
 =?us-ascii?Q?F8Y4nkFv+MD9qdGnz/KfShNKu6zEFqDnvIt7tA/GT1jeeAmfhypgi60bx6Jm?=
 =?us-ascii?Q?x7ugtGNWxfxlZoyLlrhu5SnMUT+fwhs0OSVBotMMxBcivb1Me9/Z/UUS+iuK?=
 =?us-ascii?Q?nrggC5rOJzxHMFNa2a5gWZE5pGp03yw/8DMzjKifUv7VPYyG9YC526C+C5m2?=
 =?us-ascii?Q?76FTlzVkm/PcvzVOE/x3B9CxIzRaGjceyDXr+kvpfOKEDfLIRN0oAJANjpWY?=
 =?us-ascii?Q?4SxumgdBYNiUpyF16Ztpq2YGy3nCEuVF5fDtu/zrUnmcju1QmRxztkFNeDEK?=
 =?us-ascii?Q?wiq80lhMnxSFLNd2tJGSoXrqaOxgxNMe1hxMbDLR0NjEaKvQ36GwVkOwALc2?=
 =?us-ascii?Q?CPbzB4eSJn0muUqiDL/9fVFHR3HUDYa4u7i+iGjw3qqYsfSDuCgxLsx/+1Sy?=
 =?us-ascii?Q?b/jjaweNnGgjMWEUTvbhtRf7ulLHixI66bhxXYD13scF04VOGSxdBfBUXd2Q?=
 =?us-ascii?Q?fl2RGLcEQEQMozU3jBe37SI9Dr6hWh/v0axPtPAW3TMAEqh99fxCO8uW1adi?=
 =?us-ascii?Q?IsZzUyEb4yX/kgYoPw5JGyz5AeOzr9SwF5bzPXPo6FUNdxMi9HZjPJuNZPyG?=
 =?us-ascii?Q?vCTYYe0nPgk5/DFllBk1jZcyH3ufqYmlr1J0+o/ls26Pc6uRxAld3DCqY+pI?=
 =?us-ascii?Q?tGGj71khiVIVvz9O6erIeupyOneniCbs5MpUK/uevR35p8TpWOISchqf/lsd?=
 =?us-ascii?Q?4aAWZlKxzIYvW6V/7HXSjd8fKnerkXUWN9BSDYS+fIHMNjKjI6Rw62gRz8K8?=
 =?us-ascii?Q?5mlz6N7UBxVu3t73SzwEhYuRrphR+ozJYFE0f9zHNcoaRnpBX2vXO+84scIJ?=
 =?us-ascii?Q?2auu6gGv2jf3iZtGYnUBhoz4Ghs94tZecJv832H45rxzZuUDC03M58r6cG6h?=
 =?us-ascii?Q?t+fKkEWCvzBnDZvn2ulpVb03k0vM2ebAzv6xiX4vN2O66QKjDn1elBpc8W06?=
 =?us-ascii?Q?r9/KMwusqjEuqmzy/QqoP6d7mGZ7fN/cuju9HZxH11tjBP9XY8E5go5XrOTy?=
 =?us-ascii?Q?2HyYltUOkjeQnTgpZz0nnw/KFKw5wsVdTAzgsP3OUqedao+vnlVJwoQ4Jryr?=
 =?us-ascii?Q?Fu2h7/2YeomRHP7MslUEZW/Q1pHyHks=3D?=
X-Exchange-RoutingPolicyChecked: 32s/X0N2PKoPkUlBSfII19CqSGWaVTBa1vn7eq/+nIbpEVIV+XXA9cdufba8/f4ES5iOwV0V+39sCrS1mvW03DNk8ndk3v+70C3I3KeIz+oWKnWoizzKgIayGVCHg4+yEy1XRXncqKanHMBLB3KDEnLEQn9cITTYg+j9fX25Qvt1Q/UvLqTGzgvWP1qB/o5WAANuCHdhQS6uOpJy/YmG+2pT28VQuJX0F6i/iXQgIcuHHjSqvaCKdPk2ZpkbwVgtJSc3GJTelRyykCdV12U4dfM7A33YXgQJiRzMgWn+4GmL2xZwEpJ+7+MOce+FVSvZrT/JdRH8s1ivn1JnXXiJEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2381e04b-7544-4fc4-a164-08df24499d12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:04:29.7486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfW7DY/x/Le4Puek8Q8yiQv8sSJeaRKmlo6AADsVjjS6765XcCoyWrPULDru6a1np7yo85MvWT6+ZfZkqjX3iIFdzEDKK+BNdNCJpOsOYQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB798475
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

On Wed, Oct 07, 2026 at 07:58:19AM +0000, Anurag Mandal wrote:
> Several buffers allocated with ice_malloc(), ice_calloc() or
> ice_memdup() were released using rte_free() instead of ice_free().
> Both APIs currently map to the same underlying allocator.
> However, mixing them is inconsistent and could break if the
> inconsistent and could break if the OS abstraction layer changes.
> 
> Use ice_free() for all memory obtained through the ice_malloc()
> family.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
