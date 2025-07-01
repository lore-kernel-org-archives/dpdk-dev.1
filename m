Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A173C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21B97402A5;
	Tue,  1 Jul 2025 15:44:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D1D1240264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751377467; x=1782913467;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/ZHNUEYi3VP9Vz1e05GB2zpwG2KWZHHc/UJ4NoUQXE0=;
 b=FH8lp9jiQ5J5U9Ka2Qf/Z+j7d7bA60PeUL2sChiZa3TL3274jcPGukpI
 qVFNtMezanJLHcLxgFbBul2XZenf9ImbgK1MHOg2p/IX32nE+teqIqz2r
 VJ/RbzKJnxVdN+tX0aFPihq0s8Fzec9Dv1/IGmyAKCdZEHWbBJWGrBOIc
 v7WFCJzOVNMZ38rGZsAOy8+iXkesMROxopYCMP+GYTMOTxpO9rrU1Gw7M
 oB8HDXrD64kPSRYI9B76BUUqlRfcZP99aMIw2pk4DXrM6yYhp+47yCT/f
 dD00K9Nw4negRIPZA4E3Fnqu6qy3q5hwBeZVmPBd0AybCfNoAqJNvvwxy A==;
X-CSE-ConnectionGUID: 3cqsn0epTPqD9tU7J355vQ==
X-CSE-MsgGUID: +jXmDX9zSqGhR0UJiX79cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64696079"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="64696079"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 06:44:26 -0700
X-CSE-ConnectionGUID: RnPNDlq7QTyiVlUh4upOnA==
X-CSE-MsgGUID: kUxciTSiQ4qFr+ay+OgrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="177446633"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 06:44:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:44:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 06:44:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 06:44:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htKtHnEbKGegDqxhiS3aMeGtI0LvL1+teOaUMuKy2Sw2vHhaMwpCZngHxtNdt+W2tKjDt85oxcl5jepA8mhFYkcz+53cxOORp/5u5HyvbTRtlrCEm18yj1ahU/gUBtmv6tYt1llXN8k8XI/tNjuxnaK9/wAtXhcc16Z4TUMxWMWL7K18I2ZkCV9cBbHFMX2zy5rygSMNp8MVCwWHuDwx/eI0CQ7zLKd1cnhlNKtK/MnkaMe/RAWy0/EcpvfDZwYvdbvTivWWHG+xAUoQPcqsHSEudzFc4HH4y3/9jTA4yulheEWjDDRER6Kvz/BH1nZ9y6TKv6DAw35C1K+HgrJHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bkIggGvAFE37RiOFkltkjhpTFHb3OLIgy5DWL/a4+Q=;
 b=dQKwQCCMi2BvRCCkUasodoUYF5dQbeyrq3hl3RsM93Z8FVhD7CnfteRKbaoG9MV3CvnNgNVWYS5w5Vjxm08eeEjUQIqZcvSC8kZszQma5jInIN2SlcrEBHr6rTlBf/d5rdhQAQW2T2HNyE+AhiEafQTX5tbmf3jmKw/1QFQLExA8N8ETz5FGT6dTBvGTEjDX2uVFPTVD4KDip1b6KnTMJrjQ3gMBQa1N4vat0GaGwjaQSe6KdgX6524M/b/h6QfQwBDTzTlvgxWe+vIj6KY7abifxV+pAKn8enDP3fZCh7yJZJXT5mBMhcjxMYZ8+jUyOxaOhTbaZmn3zmgFCkcKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 13:44:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:44:24 +0000
Date: Tue, 1 Jul 2025 14:44:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: Re: [PATCH] test/event: disable vector adapter test
Message-ID: <aGPmM4Upj39rmKvm@bricha3-mobl1.ger.corp.intel.com>
References: <20250701131524.2493132-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701131524.2493132-1-thomas@monjalon.net>
X-ClientProxiedBy: DU2PR04CA0037.eurprd04.prod.outlook.com
 (2603:10a6:10:234::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 59df4d27-4f20-478b-2e4e-08ddb8a563e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eIXjEnBm6O9dcNZ8W/nwYP9wROfs1YQxAVgg0B0mgytr3tm4QpKLFgaSkmce?=
 =?us-ascii?Q?WR/jZCRRPexk5tL8cu/4iFj9MA3lZ7loLU7MmG2vmgVwrQQsTcKqjG/ySL2p?=
 =?us-ascii?Q?nwrMHhVZtzS4QQa5tpitIigNVsE4GmDIxCwVaKDV8/lYQ8N2JtPKzMKXJa/t?=
 =?us-ascii?Q?JVjaQZhtCssIKvKOBirljFs2UbkeksaL6i+QbXnZwbxvDWE62MY4KWpva4FO?=
 =?us-ascii?Q?guge1Cevbc4+0vmzBYMtLnerOKvVCMG/NdzT+991WUYcS+gohVyhrdCoI//v?=
 =?us-ascii?Q?bDVFd7g1dohjgKvyDUpW/t+I9OopS4squZXMqgvamh3OmUtCiKD5MD3L/hRD?=
 =?us-ascii?Q?1WIO4A5E3xQtS0OhR1Pmd0qMizv6/kyb7Jwll8EOjBK3M9qzSLBFpZWN+2Ep?=
 =?us-ascii?Q?i6zGrr76BZ/1ho2eLMW6PdRg/bSV/Rm9DxMaBta3FkHg5CuRXOnQUttnu5pa?=
 =?us-ascii?Q?veKnkDQQNr0xcuJsvCtXkV5iacfqlFJaq+ZETBJNG29LkJ5/3HftDUTOtMVK?=
 =?us-ascii?Q?W61+W04MGttNXLJ+IAgGGC75fShP3MWYNzZA+4JpwQbjHeuRjS3ZvoZkqPWP?=
 =?us-ascii?Q?+Ho4YCa1XXm/rcy5WNAxn2agMQSI18wAu+voU/gYZRJ5Fjoa/3rWZoVGysja?=
 =?us-ascii?Q?bayOeNPXATYvWrjXeHj/LC1CqTxJlS6PSlopNE1Kq6SPzCkTYvpKYq0S0N3M?=
 =?us-ascii?Q?nXzKsnlziju/hvPqjuFOflGYre6Cy180X/W+YLD4/TKR8Pa3VysB1Q2bJtpt?=
 =?us-ascii?Q?t7uD3t4sBTqD0Ww2QzCa5EiXPiDsWrGL9aauamyowkEyKKy5pVlcqLdBfbeu?=
 =?us-ascii?Q?y5mGIBIsA3lG2vGX2FmkDy2PrRmGkzQP9U7eEaCBN1GfmTRJZzB7W7rNFWsc?=
 =?us-ascii?Q?bq/yEGHgWsEHXif8faRylGvOcBSEgjo8VpDOLeJeBSDfY+6MnEhO8wl7Y824?=
 =?us-ascii?Q?3EoeSdofSx7dHWJkTwTzS4ED3K87+cUT43ePpEk6qWz9C1fQEPkUmy8dcnlA?=
 =?us-ascii?Q?zClcQHR4ik83rtNNe3RXdennDNNJmBu0hINCEbDjvHoluvSuvIQfK/flyX4b?=
 =?us-ascii?Q?j+Lp1aGjtt+NojKybanj6tQZHKnNS3G9teS7w4OQ7G4nWEVii1x4GHtyl0Qp?=
 =?us-ascii?Q?hjRKsWQX0zZnG4ceWnOmcTrQqmPt/br5ETCepnbrb4nGucmQKOKEje+WggK+?=
 =?us-ascii?Q?FSW0y5KyRtliIEBHOk3uV9ivgRLWEm6Jwfe0NqbVtHpaly0B9Pw1MTYP9byY?=
 =?us-ascii?Q?tWQ0d4OnbG7xPl9zkNSrbHfgE+WcicjiK+/Iu9GzzSj4xwr40uydWbT52Pb0?=
 =?us-ascii?Q?biwQgipv52iLN+aWv0CaRigSVStR+KfmPObsrvy4Gn0bV3s4i8FLapniLIfh?=
 =?us-ascii?Q?jBST8beGrzbJP0kReYy2pzQViQA9/IpUHvfeReqsbOepQh2ueBUAj+C8h9iD?=
 =?us-ascii?Q?ZwRaOI9QjOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsuL6zbhOH2VZM3ZvpwWljJTzv1efthUQEybmNTwm0lqE+qVMyeh6XyCR85X?=
 =?us-ascii?Q?y4V2PXQMgX9c7gSu3TLsc8fC00w9GcqdcOVU0JEucSPQ3d4OS+Ld0hHueeGd?=
 =?us-ascii?Q?57x+guk0xSO6yq7vfz053Jf0GDSxFxqXTyhy+51l0CokbUC5AB9zNFjFUy+v?=
 =?us-ascii?Q?CxFsGO+JrGd16F5T9PtEWADRdMV6/rMptpdHa4BCEkkLQLC9gJ1RALv99XTS?=
 =?us-ascii?Q?6PB3lyryy/ptoD0hYekHIQWer4voo/YWnsnE34qE1ISKIZCQ2dKabw6Ec3PL?=
 =?us-ascii?Q?mJzN/++jye/vYEbovBKUafsJ2MWIZhZf0RTONtAXPf438zTdVcmVv/k0sAdQ?=
 =?us-ascii?Q?aUln6hZEDJOj2N3HP/Cg4BoRGJDL5tSbuQjv5e+b/XsKirEZ+zsbJaTLOgwI?=
 =?us-ascii?Q?PLitfs2h9f1AD1NaOqv7AwlrWpQt3JSJNxJKRf0poxKORfF/5as16gzlaNqI?=
 =?us-ascii?Q?Jvm6javkWiOZUlC/MDu4UTi0m0ThcmGx8XPRLvblTTwI01ez+VWhgSVxA/co?=
 =?us-ascii?Q?46x9mx+0wOt1dakkJp+S1wDQvSnhJL2ISrgE3/X2VzpSzu0xpBqI4KLz+28K?=
 =?us-ascii?Q?99Cpmrhr4RZsaFwewVKCynDU9yBymeAv9LnIgC7upVkhe5oHslbo55HZDqwi?=
 =?us-ascii?Q?5LQvES4PFgYb6NbqlS+UhUgjQV12Eg6tdYTinWz4wAYhkFyrQsz7Y0zmzK7H?=
 =?us-ascii?Q?kySB4NWXb/N3PgT9CusHxTn61Fiv8tO37TsNe7J/in1EINWAc5SYbcXglIFs?=
 =?us-ascii?Q?GWv39lTVAhM8IQvJQaNvrT8BkvIPSawz+BMcUFMkC6cluvMKHYwrg9SBpvfD?=
 =?us-ascii?Q?TirNSY4WhX0Of1KRxJotgf5lopj8NOZUuRGdBvINWhMr0cpJdTlPOSJEfhbq?=
 =?us-ascii?Q?rz41t6Nvj4bZYP+uXQd7wo4SmFXcjkvKPsFZCCpXrci/n+KYF63s82l5wX3e?=
 =?us-ascii?Q?kv/eJ/QVxiX1c4npF/b0DUI339p66IGnPT45i4WDqEOv9A0s8QqwHbSv2aij?=
 =?us-ascii?Q?T5ocegCp+jKbDMRRL8HqZWhZHzK0CdUdVjfL8FhMV8wai8wPGPp4HKQ7+4oU?=
 =?us-ascii?Q?m78csrdv2HU8Ol3HlLXNz4yMpIS+mcFwhQO0mQbEXNIXFjQQtnYpmiWqPtP/?=
 =?us-ascii?Q?0KvP2QqPwl1NNqacAWE+r5oW72JHk2fL6Z2TOFQWGIeLI3c4/Xspvgm8jyPK?=
 =?us-ascii?Q?8FGNTbjwpmFcve7DKRbpMilxuwa0h3jimo5lgdd8uJ3hnKbPatbsDJ9YwLLe?=
 =?us-ascii?Q?93tnovkhhnqsuQfsvWdLNTctTwVvu7/WDKLuhtdRrPYCnwZTk++VJQ7yx24p?=
 =?us-ascii?Q?qaWaLhny4U/E8Mtp6aLvNfEc8nh7WFhysz/OE+Awy84rDXQDzVtOoezNdZLW?=
 =?us-ascii?Q?3bMojV+sd/JSx6udduox0omOFslJOcH7YUDO+LcTUDuIYbNBhm6XDCoJtbxC?=
 =?us-ascii?Q?CvRYoIujhnplQfo648VkvpNY95XbrV7CrV1y54Bvg/J3wMErnEwKHBENiBsm?=
 =?us-ascii?Q?uKi2NMz1P+I+lMVFsmz4yUR3TvXyTg5nN9jb+G9NgbYeAdNh6rnWPZlDP762?=
 =?us-ascii?Q?t2EwelYPqaccR0wo1MW1IEnkqKsyHsBKF4e0Umh3MbX+rIpZmO4RaiYcxcjs?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59df4d27-4f20-478b-2e4e-08ddb8a563e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:44:24.3979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPQGUbIPx2GXDuqFdIhXNBIHpdrLicvqOSuRKepBMoroGGcNmt8bHaYLvBdrMH6t/17J3ncL9deQDIKLraDE+fXM/RpLS9AwlVz1U9JQFDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
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

On Tue, Jul 01, 2025 at 03:15:24PM +0200, Thomas Monjalon wrote:
> This test triggers failures in the CI:
> 
> 	event_vector_adapter_autotest  FAIL
> 	3.39s   (exit status 255 or signal 127 SIGinvalid)
> 
> Disable it until we have a fix.
> 
> Bugzilla ID: 1720
> Fixes: 2eca0f4cd5da ("test/event: fix event vector adapter timeouts")
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  app/test/test_event_vector_adapter.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
> index ae173c7715..739352bdff 100644
> --- a/app/test/test_event_vector_adapter.c
> +++ b/app/test/test_event_vector_adapter.c
> @@ -10,7 +10,7 @@
>  #include "test.h"
>  
>  #ifdef RTE_EXEC_ENV_WINDOWS
> -static int
> +static int __rte_unused
>  test_event_vector_adapter(void)
>  {
>  	printf("event_vector_adapter not supported on Windows, skipping test\n");
> @@ -700,7 +700,7 @@ static struct unit_test_suite functional_testsuite = {
>  	}
>  };
>  
> -static int
> +static int __rte_unused
>  test_event_vector_adapter(void)
>  {
>  	return unit_test_suite_runner(&functional_testsuite);
> @@ -708,4 +708,6 @@ test_event_vector_adapter(void)
>  
>  #endif
>  
> -REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
> +/* disabled because of reported failures, waiting for a fix
> + * REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
> + */
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for this. It will be good to have patchwork reports "clean" again.

/Bruce
