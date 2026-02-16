Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F84EF5872
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:37:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31E0740296;
	Mon, 16 Feb 2026 18:37:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3852D40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263473; x=1802799473;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Jo8aha8QubFLZaySk74S6AKtTI7bRuhR31g0Mcx7LMI=;
 b=iSWUwIMOwZXntFOdb53S+c7zv6Xd1ol/Q+DC1kXz6SZcAHZYsUBCfT5X
 9fBIhYxWIVCllLcrn8BHpkVEYcGrmRhDpiVcnfJ1mDpRtsieB8SvluLMz
 X7n4AXd5qFers02PhqkLqBrlcRBr9Z5EbbS+jmJFXrdNrlDjXhB5B5byv
 gWhxedpOTHjZXqPbO/dy0G5fXpvV66oziOvjyHAUALJ46x9I6vMRq+TVX
 7judPCy6sFhpZvCU9c5YFjpEc1+eltOvULU7toKFDJUlTAq9Qq7y+irRq
 Zjju2pemCTeUxM2rj+hqHKVKCpvuPiDyBOAz/1jYJX4eiQoe8KArQZFmk w==;
X-CSE-ConnectionGUID: 38r/iTC4TsKYseCo+EuGGQ==
X-CSE-MsgGUID: pI8vYQE2RDOM1jHJAyevuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72518908"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72518908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:37:49 -0800
X-CSE-ConnectionGUID: U+g8mj6vSuCL3gvRGw7LJw==
X-CSE-MsgGUID: CJ1IE2S7SDK2/f/pAcBdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212446070"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:37:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:37:47 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:37:47 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU9d6FLPttF0MwWehjG2VeIyCKCs1DGm66q+Y1BXyIT0TCUDTTRWVkz1M0crpO/347nLD5fd3CU9iGzT/1fY+5KTxAOCHOprp3alYEoPbcozCvq1vupChgM9qqegBgs52zV4GBwZYLqaZLyvVzUAtbfpveqd6M8MPI5FYdcT8QMJmY9me14DiRFfj543Lp4+IZ4gR6Kv6SpUqhK5lcPtbW3U1HaW2T3j+kvvYTUHso9ev6pgubN/XNOB1QLxSdZe9DvwWBHrOLJ/ipBmiiQ1dE68d/zwxIR6pvo2J3dNA9D3kpNrHDGz3EYWGHiQ/ReXmU7rqDk9cDFCYgOlzb+blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKqLsMYJp45YZjV3rRtazknj7OU/Az1ZJswcmqJy5pM=;
 b=fEmGLFBgRc/SaUJUdCds9RcQZN0amRn0qpWJgqmVs03pnj8TL7PYc3ByczoyFozCf7nu5XRLXnuzSoqDqB86HbKCmTrQFhjjo2IXrftgpzvskvmMVJLQes+E1uHsRS8DA+r+txupBL3YD5rmPKiKyMvzkEBTSOq01TcrUG9X6IDkECQNzlziBXXBVDGic1IkRQ+D1zeNohPSvIrU6RjfpYN6Zox7g4t0QOPMUdBgFw6U8PhvimVDWdeJTtWq98L0YLaU/iSgKkXBZRjVFv0nFB02R3ygS8EFFaB4gB4o86TDmixdkNO351ieqfp1/m0F22od9c5dPsZKR7uKHM9fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7944.namprd11.prod.outlook.com (2603:10b6:208:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:37:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:37:42 +0000
Date: Mon, 16 Feb 2026 17:37:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 27/27] net/ice: avoid rte malloc in flow pattern match
Message-ID: <aZNV4WRmz51Ojhzs@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <cede863bb4f30cec73029f5aa60ed5b09f8f3976.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cede863bb4f30cec73029f5aa60ed5b09f8f3976.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cec9bc-c868-48ab-33ac-08de6d821645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fqc98OJxazK9shVnWkgpw1ZALVjqZnaRx3kVvNcFN5nY7UQRjc0W55FCxbkz?=
 =?us-ascii?Q?isr66I409m9GOEASm51rVQc5oARKiH1UlZheAVMc7Pi4FuvNzm/eDTJkI5qp?=
 =?us-ascii?Q?M5MNjRHmHM2K1J0Is3qjpThkC/cKsvrU0mdXNT3qv/7/33rSXWIckwj4DVr1?=
 =?us-ascii?Q?yrw6KyOFOqgNq1U2EQ48dnOHgoqgsHq0O5kJQoW7wBH0NXqex+RShQYMhqNn?=
 =?us-ascii?Q?QiuRlOfqz6IeNNpUR8hjWJfDHOLQdgQaO0rghOGRnVeAIV9y66QI0Qok91BX?=
 =?us-ascii?Q?SRa3cvvzzcgGlrhw+jc4Okkym5oB1VNkLFVUdOfNnxGdmiQ7wLNqe2UXkfsU?=
 =?us-ascii?Q?uOAOEfZ+CWBhjS/sV6S7BH9r4PfyfCKyOww2DOu7WSV/Wy8Wfum04iPlJ3jb?=
 =?us-ascii?Q?ERRcZzlMYzvYguZHNoU8iWM/am+2QeukEqmJHlPiXaMNt03eJjjqVu1hYS6I?=
 =?us-ascii?Q?hYgO5UTH3x5vXNpi2oiORUcbE8iY1XjNrCXK+1rgdJlUKdyBk9EpZkDLf412?=
 =?us-ascii?Q?6xzqMtd50yajUkcaXgpvvl+OzGUMLw6Qs8zwTzxAgXbmbbyR6RRxgRDQ6hF8?=
 =?us-ascii?Q?JdxqPQrSlKx1YNYUxkmN7NJ+a15TXWu1/xd8Frf5iW+l8VhehWzNiMoWa8/8?=
 =?us-ascii?Q?QdoWIaFc1NutB8ANQ7ih0ivf4/qH54o5gKgC52oeRucDniCWbLVJ44vWawPQ?=
 =?us-ascii?Q?h+i+BsuhJqpTKPvqVPZ91g2dLTpF+k0RXHiX41nQQ09Si/YnN72QNuvS3BR2?=
 =?us-ascii?Q?OEitCV5lyg4bZTbW4Te0AhPE1QH0YFH6gTijn49Z8DzePEP7LjnazPqa94+b?=
 =?us-ascii?Q?IfylBfgwp79msYrYA+j+gMheytIQpt6MZOxRrsk4JYkYyZEXIelljrBQxkd6?=
 =?us-ascii?Q?OJAWXLv61qi4+Hgor5j06l3ayyDTcE57l8vgmKGPBkgDQXbcf8QoJlZKvfF4?=
 =?us-ascii?Q?2QDWzPvKiRMQcoVRLcjD2Sp1BDWHIYO4L62eeGctdh84ARDk10Q0kY7ZxGRZ?=
 =?us-ascii?Q?sgsjnjL+hA+8RWT3bhHXG0DTRapn0Z/eU0UAdHhynCOj1j6+zJnr5wOpX5Rx?=
 =?us-ascii?Q?cBu/dy1ziz+x4Y62gxmoTFh01LqtDIzd5kn91FmJh1WORLphzXQGTo1VMvyo?=
 =?us-ascii?Q?TQh14s8Pggy7+fwoNT/bRc4mECkMy5075iiUcBX5yr6EdTnMfFr8PpnIKqzP?=
 =?us-ascii?Q?oampnX7CVqm29+fTXIG/CSugGXAnteiBpfwxlgVRKthsOVu3HXIH1dGvvu/I?=
 =?us-ascii?Q?7+dnNW6FvD/BJuDDbPrIOt4HddgfMBDfPxpH9pVWV9CcwURA7ww3ROFvZlp+?=
 =?us-ascii?Q?rnRvu5X3RSQlL3BZHt0tiFlDOPbaU5UkzjwlaD62RDOoc6FeeVHX5aAb9dmm?=
 =?us-ascii?Q?08rt/84fkZooS4uIvOt9y4grsDZno36UE6F+A0jnQRqhqZjuCex2UtyHNsTm?=
 =?us-ascii?Q?HwQ9Cm6FnGYsUWJJamrwP0m9L54vqAHAcSF+3WhbSLsnLn1/IqyP5rTeF1f2?=
 =?us-ascii?Q?zuEiLzN7VCWIsSsZW2AzERShXR2LIfwHxnUmm0RhlKSG7FEywUnLFBa/hTNb?=
 =?us-ascii?Q?nliafeRlb80OG58rjXk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ei5CJiy/Gr4Joa6auUIoh2hTx8pFWAmLIFAlVeGDsYdbOV8TMqkGYbdhR8VQ?=
 =?us-ascii?Q?P6YSYZ78y9oK1aJKxAQkC1kJOVJrFib1FODXlTnaMg62MRNbCKyYQkH0kkI1?=
 =?us-ascii?Q?W9Q23AQ8hLVbRSrSkzVZcrWCjavVA9g9mCqeof5pPywSZM7XQ8iPwepNgf/j?=
 =?us-ascii?Q?oEb5fl3G3ctmMrx+j5NU9mJj9LDTk8Jn/gSpkOhRM5Dz+3doGYI722MXMgKm?=
 =?us-ascii?Q?IqRTl/DFi4HsRRm3WzPFg1SypygriMqPmtBw6tEnyENawf4JVCvG93u6qTjv?=
 =?us-ascii?Q?3QBlP4eHj/hyEnN0YCgwvfd8D/lgEVMlJJ6L9EAoQxTNd3Da7zzOM8Zc9fnG?=
 =?us-ascii?Q?++9RuwJUyI3T7E/tLNAuz9vpH7Bsf7JcDJ2rFKt+NSoCvbbwx1LviI69KZo3?=
 =?us-ascii?Q?h/YV9aEHrxq4OHk+kExbVV7zQFeaSHSFeKS5XUACQPqIcs3Bpz+wvUb/idjM?=
 =?us-ascii?Q?psjRgjB2tjXNYIi8zbWf+DpbIlcWIAdXPkjpnCtg+r7erWVajIEDNczf30iw?=
 =?us-ascii?Q?8+zQwx2QgSy2FScMgfVGVTlieZ+w1HWHxJh4nro9wiiuvvfC0/HgyZ8x0L0J?=
 =?us-ascii?Q?7/1TaxPvhpcUaIMeBlhpAPJxPlQLcsyTgVPNL/eI3FXrTVCRN2CeN/KI3ovP?=
 =?us-ascii?Q?zGsuoJg+eIyEJaX/CDzEw03a+pKAr9KXZXPBJFClanoyIJ6JOpdlS1ifDSej?=
 =?us-ascii?Q?pzD1d7vXfdq2lzi7z8lzvfBkeFvLtlrCoWJWk2jKbJXNNevADD2ivSbO9+AL?=
 =?us-ascii?Q?bpvXU4tty6BDytojwKfwe7B8jZY9ZYnYq92eydcqMIH4XG1DuKUChx9SaUA1?=
 =?us-ascii?Q?VM7mr/mCwh5fOEaj/heIjlFCnLSgeicKQCbVMTLXUF1e1qCCQK9v8nOmgpiz?=
 =?us-ascii?Q?X6d9Sapzf26oy9Rzi86vQ4nu22Msd8tEP4G64lbk68ZJyPtLAnipn2OWavcg?=
 =?us-ascii?Q?tCPVCYAFnLFAbQdNcwz8J9OLwWIfzRkiRdaXi791Ir9Bc041VsrJSwadLxjL?=
 =?us-ascii?Q?EXEAZAv43CSgJyt3GTUADUwiEzr59aa4XvyvK2HRDzjvrcAhgKlkbdYetCwI?=
 =?us-ascii?Q?iGcW7D3hoPTm+3K1VU2igTOpmooNLKGL87/CZERVYlh5BrevQ+gTdVTrrYa3?=
 =?us-ascii?Q?4x1aPTZxwnGnja1CCBV9nIW6vkyNkrxvIcAHLllS6fSf3rFM+ez8g0OxDvUT?=
 =?us-ascii?Q?jktPmIifAuOPlP7uyxF55+n6bMFGLLeYpK/XsgnycJDR2A5G9ZYrnWzyIGTx?=
 =?us-ascii?Q?z+tqf9EJoWrC6zyxTrawRKrh8W173xcdvYzqCajVdBv13CkSbNMQWO2Bg0jM?=
 =?us-ascii?Q?/KRcutVKMtkAwMvK21tG3dqDpM62buEbFn84lZpotgQxRDlAbJkmXgf17zEK?=
 =?us-ascii?Q?s2+3vpZim/Dlr5hz+ZkOvjxLWLRn/dumZg5YJ1z3dvwqoy8aNRnXsZqS3/4k?=
 =?us-ascii?Q?5T1Z7E4bzKFOk2i/k7dtRrpfsyrYq8OAi5jYXI/WO7ebc7t0il/pP+PmbfVC?=
 =?us-ascii?Q?eL2dY48rqiqARyjPeqs0WwKTloZmXdfY4hEVil840PVEZXq7vBRrT8ePDgPO?=
 =?us-ascii?Q?n23m3BotAiVZ4NSxzsFJzeSdA9F8AS9lcU3ZAvWajNVef5VS2Z2mdqfK/A0/?=
 =?us-ascii?Q?bLGZKueO+8NUQSJuL74oyNvIaXW0wlk7+u2xhqn3IA7ss3NUfG4Wd8rO/DvI?=
 =?us-ascii?Q?e2pIRclmi6kVc2Rp3bwxA6h7FN+aUfxrDXPSL0CDX35MP6mUk9MB2D5aB6Ib?=
 =?us-ascii?Q?msAttZSt2A80DodKtwDbaDQYr6Aku7M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cec9bc-c868-48ab-33ac-08de6d821645
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:37:42.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge5iNskqzivuZqDw9PsPoz6sUayMWpvn9r7JJB8hVw7NyypdCBwY6xyeIMIkZDSh4QCI4IDIZC/QWLHwraEXU2nc4Esoqt4LnTfJfTzlWeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
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

On Fri, Feb 13, 2026 at 10:26:38AM +0000, Anatoly Burakov wrote:
> Currently, when allocating buffers for pattern match items and flow item
> storage, we are using rte_zmalloc followed by immediate rte_free. This is
> not needed as these buffers are only used temporarily within the function
> scope, so replace it with regular calloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c    |  3 ++-
>  drivers/net/intel/ice/ice_fdir_filter.c   |  5 +++--
>  drivers/net/intel/ice/ice_generic_flow.c  | 15 +++++++--------
>  drivers/net/intel/ice/ice_hash.c          |  3 ++-
>  drivers/net/intel/ice/ice_switch_filter.c |  5 +++--
>  5 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index 38e30a4f62..6754a40044 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <stdlib.h>
>  #include <rte_debug.h>
>  #include <rte_ether.h>
>  #include <ethdev_driver.h>
> @@ -1009,7 +1010,7 @@ ice_acl_parse(struct ice_adapter *ad,
>  		*meta = filter;
>  
>  error:
> -	rte_free(item);
> +	free(item);
>  	return ret;
>  }

Should this code be reworked so that the error is propagated back to caller
and the item freed there so as allocation and freeing occur together in the
one function - or even in the same file?

>  
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index 5f44b5c818..8cca831fa9 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -3,6 +3,7 @@
>   */
>  
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <rte_flow.h>
>  #include <rte_hash.h>
>  #include <rte_hash_crc.h>
> @@ -2504,11 +2505,11 @@ ice_fdir_parse(struct ice_adapter *ad,
>  		rte_free(filter->pkt_buf);
>  	}
>  
> -	rte_free(item);
> +	free(item);
>  	return ret;
>  error:
>  	rte_free(filter->pkt_buf);
> -	rte_free(item);
> +	free(item);
>  	return ret;
>  }
>  
> diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
> index 4049157eab..3f7a9f4714 100644
> --- a/drivers/net/intel/ice/ice_generic_flow.c
> +++ b/drivers/net/intel/ice/ice_generic_flow.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <stdlib.h>
>  
>  #include <rte_ether.h>
>  #include <ethdev_driver.h>
> @@ -2136,19 +2137,17 @@ ice_search_pattern_match_item(struct ice_adapter *ad,
>  	}
>  	item_num++;
>  
> -	items = rte_zmalloc("ice_pattern",
> -			    item_num * sizeof(struct rte_flow_item), 0);
> +	items = calloc(item_num, sizeof(struct rte_flow_item));
>  	if (!items) {

<snip for brevity>
