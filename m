Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7D606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fm46C/Bh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CFD740270;
	Tue, 20 Oct 2026 11:19:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2E52640144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487943; x=1824023943;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gC4jCHUzWk7ESpohe9iQzb0+if/Acle1Kxeq7U93eGc=;
 b=fm46C/Bh2ETfbMz2ZhRPhk4h6HGPPwNIZIb0yxJ/VIytG5Xi9b5lCzuN
 OOvhYKx/8/n3WuArv9CS9E143u6mule/xqhouCHhUhunCt0YFEpkp2lZi
 lz1PTm0BZxwgFjERhfAc4bOx9mOGcCEIQr8jeAtEB8Kh3CgieiKZiG+sD
 rI1k4r2Mz8qgAACjrlDVI1dQZBmttb0YRET3rdGApI86KenfTws/+ofRz
 qsnKSOicW3JUtFbQqRLjw0ouKefCMM05IyhHyWB4sQi3UT80Kj6cypAuV
 RPl/tQyHY1SEVMzCOWAS4+l1S+uGotSdaHgBDjRjGvqDFL+KYRXK03CFS Q==;
X-CSE-ConnectionGUID: v0yKCQGoSjivNl9wAvecJQ==
X-CSE-MsgGUID: cS2s51XmROmrghisU3oY5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1069292"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1069292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:19:02 -0700
X-CSE-ConnectionGUID: XLE0+k4hSTmOXlzvUghJjQ==
X-CSE-MsgGUID: 6r1n9OiiRdu9YeRs86o3ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2730232"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:19:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:19:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 02:19:00 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sShU3Kortfm5SAWMMETLhRsa6Hl6X/2XJVkDoJmn/9ofzncT8WmGNvRl1gGB2WN6M67U83ppA10sbOswlcf5hR2LrY8ZVm+txY2JEIyvWBX3+9pgzZbh88cb7poAhYPxVvs8CdFdYwGZ35jxK4YxWKeqgy1P1iqiBd/CpOJIaKi8bz7ye98Q/4fb4dDUIKlRCB6/doo2Vnx9owpeExZ3R8XcQ9yDeFel0ioRK37bzZj+lZes0F+D2BsxsZlz31HW56shQbIeOZXxc8EJQ3OLA8x+vh+EJx3agdIGaKF/DF3c3oP5BtrtPe8p5KL/s9Zk1Uftvu1MtN7OLjE61LaKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfdRtN4NnvMfSB85VI+lqncEqtA+pCPkb79C/HGsAgg=;
 b=ZG/8gCHKENrfzd18CE9gzrCZIl7B6ErmtTm2qexRbNqV3i2vvq5aMw20czM3w5FMuHgalMwVF2tMsP80G4Acq9IsyZdLtaVPrF6Kr4MBkDDURsRyJqGp9eBp4cJz3q4L0ejI46f1jGhjPeMFmFepdpm9/WPRwHHuQKrLgFgUgGqkUtNFVrdCIdhUGjYwzNAbp5t+qXaxk+S44KIPmsiIfxEM30mkBWLktlUo1HM+FF1fUmXzOExWix8FWPvy0UbKXbIsVh+qhWl07zmC0wiaaiaR/zlhuULgBXwjZUPq+33otTENI5FuoJX4ZuTcfmNRazVo4zAjTKVmhSNO03iUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:18:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:18:52 +0000
Date: Tue, 20 Oct 2026 10:18:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Stephen Hemminger
 <stephen@networkplumber.org>, Ali Alnubani <alialnu@nvidia.com>
Subject: Re: [PATCH] stack: fix pile GCC memcpy warnings
Message-ID: <atcx9-0kXa2XrzrB@bricha3-mobl1.ger.corp.intel.com>
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020084944.3188987-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU6P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: fcafee03-ebdd-426f-c574-08df2e8b28a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: El41BB8UOayOZiTwY6DZuCDmnFMhI+WDrBCfw59+SRTQn2Wz1Rkfw7qU4wH/hFVRAWA9EmBaAMw6rwAxTH3dm4YsDNCJwMhrDPvFKk5RsaLIWEasAAH5zqkVKtBRYgFc4sDImdBI18dn3JGnkHXozDJQNI+VT9OwxOtb95tk6EMtgRjcpAwetTsMnQLUDPYzZyHrbUJ5Oqu6mosT6QF+S8pJprLInCURw06Ho5W0o/7y8QHLWe3eEntX0nHyUlsldBWgyAFNSdrkE39z70oq0Spm1rDNHn+fso+/kQ1Q6+ZYa+MVYFoRttJ3pbgH+RGbgpMfHaQ9NDCequfNxPAROvFgGvpmhj58fBf8nbfFeCyiAOiW0zPEGlEYn2BOHXxrojidoogEzY9h9UITjjmC6SNlL66vnJhtqmNC1OMG2pFSoEfc0WKH23xo1o3zBGDWOzmj72N5srVkkMAI8LfrArHz1dPHRWBiy1mL0NAnGex/aKmTWXYON46UHxo9ift4zVnzHCwKbdvlZHP9ukfnkCiEtAgWhLy3Ge2e7Kj3TYV2EWCw7bmnCQZqjWlVLTddZsK4KfTGNb3POQSQIn2TlBssi/1iIxfrt0YfSeMite8iGL97l0GYmGJ6MjiJt0uEN8nMjEytezDRvX5i88kyLMmp/bGyzt/oIj6hC8ked5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NZSspEN/upZzCz3m0Tqi/LsJqmzMRKqrMAeFcOJWhwwIInzEymqx83AF4b?=
 =?iso-8859-1?Q?JqoUr7hTT5lOAZ69JDj3wTBy2R8C710dd5qecNcJt+mISrg1QKNl3IVrav?=
 =?iso-8859-1?Q?5YIMYBRvjk2G09vAzNmb5FLH3wy8pCisg1vUNRpZKEK+Dhd0o1vE6qb3Xb?=
 =?iso-8859-1?Q?tMIuO8No8C4JvIBOpnJMQm4jxnY1rFq/JbXBwnIPP1PB1eC4Exw8WUa8qc?=
 =?iso-8859-1?Q?zJNAw8JeCnPIZP4exNJzDpP/888wrSfXQTRicoFX1dlLS75teU52RdR7Cr?=
 =?iso-8859-1?Q?+GHXAmMlpWKdbja20SgLXocdG+LdcGSOW18bN5ysEplEIB5RrLBVEubw29?=
 =?iso-8859-1?Q?wmbHjtR+083d+jzFc7lSnyGPeqlwTaj3kdlqSRCygCbqMIhWEqpRrhvK+J?=
 =?iso-8859-1?Q?qXZoaolOaqkDXoG4henycNXQpIU1raCwG7pDcDvME5d8SZT2voHnByVUGY?=
 =?iso-8859-1?Q?4zVxw1bk6jr51A9IsgGQSWQTxefFcG2zKrHQvwMb9jSueo4BhY5PztlOzQ?=
 =?iso-8859-1?Q?5y+bliU7iksG0HdfDjPDC7EfVep3PySHINToKop5wgF27Oc7mdJIrBbd0F?=
 =?iso-8859-1?Q?TKgo4lvqBrsNn1nYaKRkN19o99v7AylLFeHpGoE8cnsECBNsahSdR2Oo3D?=
 =?iso-8859-1?Q?0JTrtJNu8K736DlrJkABtCuWa+QF2mwQpbc7oGx6oSr6+lxG8qfCxjF3++?=
 =?iso-8859-1?Q?r6axUf5bCidQb5iQckthYyi7mzLSBaCPn/12QpOoFeqoQQU4GTLse0KXTG?=
 =?iso-8859-1?Q?kxNoCa7rIj8wK4A40SQVd/9oSjjqft033alJibNbtZBQdJggTSXO2SuEgK?=
 =?iso-8859-1?Q?UfhzVmSSuwhyNPyn/l2TIgN3Aa/sEIg5824grtapk5BZGVGSxoAT9Y+iN/?=
 =?iso-8859-1?Q?PSk6va8oLcMtuAjbQVLybn7ZFwZ25gLtDHFJAsUF9CjiBkRXXV33J0dGOF?=
 =?iso-8859-1?Q?SS9L7PuXXKVAbtQ8qh7Y7lTTWot7vvuMBPBGBW7UhWENq7os1SfYOtZIel?=
 =?iso-8859-1?Q?v/wVXrXGWC9LOS9beCbdvjD3lBDYGkXivWSv0dmw+ZYgciArAlahtvPXnu?=
 =?iso-8859-1?Q?WaSVurA58520+8+U1vpTGG8WiFyuO7q/KW/SDVYVIpoVOd5WEzwiQ4iwUH?=
 =?iso-8859-1?Q?hAN6sSiDxPzM5VnwbNaSlpk/HzCNPQgtdQ+0gf7KgXetBckXzqgr7mFi5J?=
 =?iso-8859-1?Q?luwECNY/nq7zQiaZC9qwZRNbSmsspEinTzjNRixVrBIapMWBvOp4UIMQaU?=
 =?iso-8859-1?Q?F1UBFMdY24n8S1F5TyWt9QOkZI1t6PFKvMFV+00XlXjhh9rkApwQkzRHyR?=
 =?iso-8859-1?Q?Lmui54cBZ9kC3VW+Q62irG2vIdugVa29ze4Y/o7+SJtBYF3xA0O0/04oQB?=
 =?iso-8859-1?Q?f7WgHt8M6csTId03Hcu8DFC2DzXFPVRXR+aQl0FqsUou42hOX8h+8AZvfS?=
 =?iso-8859-1?Q?+7L2dP8jrYZO3ghE11BHAQVvSGKkzGUtltR6VPUzjwMjK2g0tlLzv7tg55?=
 =?iso-8859-1?Q?havVSkKYNT/gbgr6wg1RfXkZYQXSoqRFv6I1pTTESKNp1cV+x/ZxbBwW4h?=
 =?iso-8859-1?Q?DVJ4mGeRViFINsUeU3bVVe4HhJmrPQTOFs712+dD3abee0Tv2gLhah+ckH?=
 =?iso-8859-1?Q?ksdyuO3U4LU2IVq7OGGUujBFTOLYISEywaV/iRnoxIIgSY/CFWyDQzud5J?=
 =?iso-8859-1?Q?09Gurh/FIt5m8fuBEzgOiMq9bhAgK6/s9BbRwo8y9owoQ+6rzoBaDGfWrG?=
 =?iso-8859-1?Q?rUHQ84BKEis/mYCAc+wG+Sp9Q3aaSon81MAyX6d497BcqO9gVRhRlJSHE7?=
 =?iso-8859-1?Q?c0FHOoE08W5aNF+yvIClWyH21mC2RrM=3D?=
X-Exchange-RoutingPolicyChecked: qaMRRd0uld+WpgQVNprkqg7yBtkzktHifbgQJ4aqFRon0ag2MJLiFJvLT3TluvYtMQLDFlF3+KRtJBMAaDCZKROvnr1jxTsq3gQLs26AcnV27fLNmIu03H9C2M2R4kASmiyFyf36pD5lpn3m+VzkeOSWeUBhdsH96JQWmKaH8KKAYMR0DjtE3b3TU7FixZpqHeHFG+KWf2nwr11U9W1K3E/JTtM34IKbxQ+WLfh7guv7nhl32YOa7qtGdLkb5gn8x48sTWyisemdc5eWVJchDA2G1YuGGA9pLWUtDD7Tohydsn7VDd27pOwwQiw1as4HyaYmeLkOTkm6uHSGMS5Ekw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fcafee03-ebdd-426f-c574-08df2e8b28a2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:18:52.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcqCWAVCO98gl3Nz06UuA6PxqVZQfLuEeHl0zVKstQeNnrbbsXbTvQ9pM++Pd18wwfcsdnypFUnN85gLSfUgQGoyDjdeWqwp1KkGlGlzuV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 08:49:44AM +0000, Morten Brørup wrote:
> On architectures where rte_memcpy() is defined as memcpy(),
> GCC warns about source/destination overflow when copying more than the
> source/destination size, even for code paths that are not taken in cases
> where the sizes are smaller.
> 
> The relevant compiler warnings were disabled for GCC at the two
> occurrences, and comments describing the reason were added.
> 
> NB:
> It has not been investigated which GCC versions are affected.
> GCC version 10 and up was chosen because that was what the previous
> versions of x86 rte_memcpy() disabled sligthly similar warnings for.
> 
> PS:
> The alternative was to obfuscate the code, but that would make the code
> less readable, and might have unintended effects on architectures and
> compilers not suffering by this issue.
> 
> Bugzilla ID: 2061
> Fixes: ee0822a0ef41 ("stack: introduce pile")
> 
> The pile was introduce with this DPDK release, so no need to backport.
> 
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/stack/rte_stack_pile.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/lib/stack/rte_stack_pile.h b/lib/stack/rte_stack_pile.h
> index 819bd1d47a..69aa0cbf88 100644
> --- a/lib/stack/rte_stack_pile.h
> +++ b/lib/stack/rte_stack_pile.h
> @@ -154,12 +154,25 @@ __rte_stack_pile_push(struct rte_stack *s,
>  	 * Construct the bulk elements.
>  	 * Copy bulks in reverse order, but ignore the object order within each bulk.
>  	 */
> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
> +/*
> + * On architectures where rte_memcpy() is defined as memcpy(),
> + * although GCC knows that this code path is not taken when the source's size is smaller than
> + * RTE_STACK_PILE_BULK_SIZE, it still warns about memcpy() source overread.
> + * So we disable the compiler warning for this memcpy() instance.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wstringop-overread"
> +#endif
>  	tmp = (struct rte_stack_lf_elem *)bulk_first;
>  	__rte_assume(n_bulk > 0);
>  	for (i = 0; i < n_bulk; i++, tmp = tmp->next)
>  		rte_memcpy(((struct rte_stack_pile_bulk_elem *)tmp)->objs,
>  				&obj_table[(n_bulk - i - 1) * RTE_STACK_PILE_BULK_SIZE],
>  				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);

An rte_assume before the memcpy asserting the sizes doesn't help?

> +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
> +#pragma GCC diagnostic pop
> +#endif
