Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092EA606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e78gqj9d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D8F402BF;
	Wed, 21 Oct 2026 11:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6A43840041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792574259; x=1824110259;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yY75dkL3OzKOdrQvcPfeC0+Xu5cIIqY7Vb33XA3zHks=;
 b=e78gqj9dilQd29lNIpaDQLgdhM4DHwNmeGTPnEzD5ifC/ht2UuMxvI1t
 7EHc8lT8oi2tC+poZrr6x8i5ykiH6zZsNzgHvGRvMdakztgBCrFXy1ums
 XiG/trO/hw8fyZ11pXmL6zvE16spWBzXnol4HsMDgkKRJgnMYP7GhgQ6y
 1yxpb7re6Ae+8XS76EX+QwTwj0BEShdxa8/psqWyu4TwqlT4eBSWQ56T3
 CLNn1z3MjvAcsQfyfjIDNRXcTawIoCBo586rpi+SmaKCVSdHvhBQt+4Ai
 FtqQcmzW5pasF2KHbdz5/2LCeHFkp65RJgCral6UA2tHvj+mroN2X8leJ A==;
X-CSE-ConnectionGUID: 5NHi95bdSaKPA0omKlBpXA==
X-CSE-MsgGUID: QNFfJBmbRNaWmOGF6L1R/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1304216"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1304216"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:17:35 -0700
X-CSE-ConnectionGUID: ZF28JrDaSymued3c7uf57Q==
X-CSE-MsgGUID: Jcu2LjazTvaDC3WFtvB2pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3359536"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:17:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:17:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:17:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMFknQyv/AJ4UffSWOjnh31Es3p2FpXOcGJ+/+2odyHc7n5Z3BcfWOUn6cBY39E02igIDhilrLqa+WhjSnXAfV2PzI7qknvnK26t+h+98+hzCJjv1mChy6pQ8j6rfjw3ziJmxdsCspP5YNvaSLUFj5OqcMkK1MNjdD4S++3gEr22gNWYNiM8acLkWmQ6OUSm7tVkErpOP3d8ANf6ayQzYPfv+tvuZ1n3U7Z/j8FJowqUynMsDyYAtdKMm9JYG9U9E2gvXnMNPoUFoKofPkD7DU1pJc5ci/HMnjEZ04rOEcGwu9gmsPLVZIqXyRayNlUz9t6USqY1XGHcVKguQmITaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12sOmPtzFY/DcXDaFxxzs0JWc/eZlYgNBvcpA1S4yS4=;
 b=gHsm5zbpQYgF2nqmBsWLB2bb/JUNeB4mZrSbqWd6WrxYIb7hkzHTGK/7WMeBMABijT23RzaQXZiLiT3vPH0qs10mgmx1Id1LJijFQS8JZIJBMx5XQ5Isxgbt1uL9/7Fw63UAmjQv+bkfNq8yus2DiqX1ks4tZHQgWS8ZhnMjvYGYzky/xMtRhZkpNqMEBX3b8z+7u9pSL9TVtNXol/63CcFV2K6FgsZgbr/1w4HlF4uUzBywBYrdtOgcfi3qHEgZwXfZxBzU/HRR1bNkZHwWgEy9rJ/L3MCaJL00Iy8h1t4sytvtf6iripZLMQMftL1i/lgyrVY1hUSzpOD9L9fnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 09:17:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:17:25 +0000
Date: Wed, 21 Oct 2026 10:17:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>, Xuan Ding
 <xuan.ding@intel.com>, Simei Su <simei.su@intel.com>
Subject: Re: [PATCH v1 1/6] net/ice: release ACL slot on entry creation failure
Message-ID: <atiDIDd4BC5FQ6PC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <c84ac911518d38194909537a1da3c6bc931fc86a.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c84ac911518d38194909537a1da3c6bc931fc86a.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e29cc3-8e7a-45e3-6d0a-08df2f541ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1t3TMaBZozbEisj1w4sabwltKULdeuNRFGybln/iN13l//FGfS1JryxGBAkQRDhE+4He8VgbJn5eP5QqUoN6ISkfKlpkSGQY0FEy+er9DarORkPGXJVAQ2UvSW+oEbjutQ/M/0Fnz9n/ILHO5tXI+N4F2kb3SpabmELE/ZfWDoae2EJIs7nhorq0pvuPUFPM1HjT1NLzM5ED9OUUkzpqIX4FZKKbo9nagGJahN63LcL/agOncqCaHg0P8qxsc0oElauHAtfwiX4awRE9h63dDmjw+9v2EO88s0YtiZdBNh2aJq4ieD3SqVoHffFP+GyePKEvXmvTo2zXKdSd8snQXHOuRk1n27u4ZwlBsMGzj7xlIS0TuJ+L7D+OP4eNYWCjyMeBvrFjoPu1fXUcBuHFW+sdQPTFBBQyyPKAEF0qILsgAG97V70s0AZaNwWirxVsIU87Z7n2yy26oCCdkMfjVF1YYctIUt035O+2GH+DPOHzdqr62Z5Ruyc6lLike87ah5ohNWcgpQce6CgeNEZXlR4bd8MNKJA7XDVGk6z52KE4zY+sSfD4nJkKKIL6UY97+1Sw/T7DLABiAqfyXxM18h4ldsE6wBPYHQTesJmAb2Zg20dWkywvnU9T6srDU0KeHd1FVSCr4KWxcM6mrEIiDWjkG+6aVYEzJ1jCsgkq/RA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHdMbFUGzCO/JO+q0wkT/dFY4mDJgFx0WqASjpI8YcTaxkdrAvVeCUjKCe3v?=
 =?us-ascii?Q?wd1Ubi1n0eIUZUET/qXjZTJrUXMyD+R4YIiOWRyDPeFrPT8KJMJXqFsh/cdW?=
 =?us-ascii?Q?NRAi7Z690c526Dox19sOjkbAZC3ggJi2XTEt/1eGS/MekhC4LQPSz4296tsW?=
 =?us-ascii?Q?X2CxPta0Jf8pyycvvAhrqMlsrL6UighODEUeosa20uh32x8e/7ur7Q40EaIL?=
 =?us-ascii?Q?4Tx8mKt4/TgIwgKx/69p2r8obF4/JUd1Mq5Zl/fFmDpEBuEIVc8zFGEL12TV?=
 =?us-ascii?Q?pKrgT3sGv0V8POXwaGDF5WYmlBUwKgOSy4gzkZlqzrZIwab3A21gWEGWF+Z1?=
 =?us-ascii?Q?Urra8PiF68G2rlkkMNZeneJBln0FCFDpzmlJq2oo6pULjQZcQ/+8lS0hXieP?=
 =?us-ascii?Q?o0khYvOI+62jMKdYfNbXzSTUa7RYewBbWLP1fvG3N+/62zGzWRguJQZiNqa/?=
 =?us-ascii?Q?ztIK7+5HzJGra8gNuXUgk7ujCvn0nZQl2Y8UbnQjmTTdTq1CSHTgwEeU+Mqh?=
 =?us-ascii?Q?gAq9FxSq1GHqtoo/ON+EF2cPLhbvJO8rST6BcISBpPTKpfQqRqd7PyP+N+LZ?=
 =?us-ascii?Q?IBVjCZkSwkVvNJRq0IOGhY6YT1MrsN0DZ87OKxnXudxKy7h2678fiatxEHqA?=
 =?us-ascii?Q?AFq6ifflDZE4yhslX9UwlvPrE7rX6iys75kykmckgqs2aDnBQ5P8CgbR9Cl7?=
 =?us-ascii?Q?DAmASAKHkgsz04WAoWhaQ2Lkh/9WPpZeLyS1mlQrvu+tt4MeR8esTR/i4ECr?=
 =?us-ascii?Q?2JBY8XkFOytEmUCECwWinDLxHQSxlW9B1Zcm3u82ODqQfmCzhifmHfr+9qWa?=
 =?us-ascii?Q?6OJUxtX3mLdWPhY+dYhmR+sLU0tnywUpGpAhYYib+zYJyWXD+wADzEZhxvMg?=
 =?us-ascii?Q?H1HRAFv8knlqJy+pEQ6v7HMd/SyNoPZFXmfC8BxwarQNtbHrGLdKPgGRbQoD?=
 =?us-ascii?Q?9PiiECZCHwXHpN6cYAqkL6MNoc9P7tsG8fovyXIF3t3seuX+Iufu6w0tLdSM?=
 =?us-ascii?Q?fB/gpYeY4ELuerROvzd/zfvt6ntXXIGSj2OR/DFauEZAQl1gGSK/qQZZ8D42?=
 =?us-ascii?Q?y0DfB4cin2EwgqlPMXMON3qutGBcuNM3viVcz0Yqvuh61AkZBvu0kcCTYhbR?=
 =?us-ascii?Q?ZvnPiWtkgvkQ3DfU7gb14+4k2R7RMswAknJj8BmErO+bv7s16VJJcyUGSEGg?=
 =?us-ascii?Q?lj7WEK9IjVzNwilJEZE7N+v2vF/7RsHNy24DdliKa0PMmConKgAVtZGo3Bj2?=
 =?us-ascii?Q?6PkmwRrGR6WFqbTlFDg8ygk/zuaSKpMeiVBx2k4Xblv9yiOoWel8Uuk4m3c/?=
 =?us-ascii?Q?fEURgD1E3vFxyGg6lfy1l+MIdY3fAb4mzqg+hBe+FtLPYZw1oyQ4PUyZ4nn3?=
 =?us-ascii?Q?ojy0nYn0RO2z9Kfn1NVe00GlhjydpDaFFk7OEp9Eg5TYpDQW6j9mRwrI67/T?=
 =?us-ascii?Q?AhbE5d1HLiCT2FRkKcywezCxDCD9JxHflIY2Sf86ZEffnhJNHjQ8OLcvmlet?=
 =?us-ascii?Q?b02PwgLSMjMhq7RHVuqgQR4CLFL1wDP54qef7AueLNXjUGk/n2wEbQrji2Qk?=
 =?us-ascii?Q?agTx/vubje1np54fZQbcBaVQAMaQ0fzNXsq2+3hvKC3F3McEUYr4f9uKNIvb?=
 =?us-ascii?Q?cC42itgRnloNM1kNHJQVlU5V19tqse5z0fu5wz79GSbu4kHRFotocWST0MrC?=
 =?us-ascii?Q?NV1VC3KyO+DvGdrZrV1PQI+C2VDf2fDOdiz9NoLIhBCMwOokNpYmK9Go04Oe?=
 =?us-ascii?Q?eKYv1DBdyr3vHxroeJct9mKJOUZ8odQ=3D?=
X-Exchange-RoutingPolicyChecked: moYzg+L+jeMiRa/0ld4TxGGuS60K45u0nERqeeiaLc93h/3h4CJQhCFy3IrFmQceS776RIOeycA1gAO3EpWyOVWtw6crn4qhuBeQ3Cl0lyF09syWfaY/hPHhqJFMhhAUTZ71COEjywR7cihkVR/Eacqj0RzUzmh1UDUCbdO4wdCqVIfd56W19+U3okmqLPYnAsejhfquEBTS5EwhtxhNlBLOjpvkJpvgmgqEtPBH4jS/LSdi6sghsn24EDE3UYFbQijuh1LTRQopwhSXoC79+gizgShuI9DR0wwd0NdGd/p3sNtbY2vvRFIvWTewl1LV6NdR+r0ZxmjP0AV/6v4WPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e29cc3-8e7a-45e3-6d0a-08df2f541ee1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:17:25.5121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uvwVqqIoZIMmONiE27WCHubD2NZgelW9+uWJ/bftNfV6EQ/hPlkLHdYRITArjI4YUTSa1zHBDmw+kK7y91qQfnFUgP3O6KANKhjK9AioFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
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

On Tue, Oct 20, 2026 at 01:11:04PM +0100, Anatoly Burakov wrote:
> ACL entry creation reserves a bitmap slot before programming hardware.
> If programming fails, the reserved slot is not restored, so repeated
> failures consume the available slots. The slot is also left reserved
> when it exceeds the supported entry limit.
> 
> Restore the bitmap slot on both failure paths. Keep it reserved only
> when entry creation succeeds.
> 
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index a91bd558f3..eb5d88ccc5 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -462,6 +462,7 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
>  					 acts, act_cnt, &hw_entry);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to add entry.");
> +			rte_bitmap_set(pf->acl.slots, slot_id);
>  			return ret;
>  		}
>  		rule->entry_id[entry_idx] = entry_id;
> @@ -469,6 +470,7 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
>  	} else {
>  		PMD_DRV_LOG(ERR, "Exceed the maximum entry number(%d)"
>  			    " HW supported!", MAX_ACL_NORMAL_ENTRIES);
> +		rte_bitmap_set(pf->acl.slots, slot_id);
>  		return -1;
>  	}
>  
> -- 
> 2.52.0
> 
