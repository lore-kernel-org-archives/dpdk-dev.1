Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3A606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ay4loWrN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C7D940299;
	Fri, 23 Oct 2026 12:26:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C903440268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792751209; x=1824287209;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4uy9FIYyiUanm9FfMG1J7rqnVINqjovGso9DWWYNSsQ=;
 b=ay4loWrN2P57qdCZtcuIEDiCto7onkQ6ohx06B8GtDeZR2PCu7ykuUsr
 L+wg0+gJr2WzzPNB6xepp8RZT3RHW9s712h4z9ltFgMUHCzcKtx6s+RXs
 ZgbiDqPFrsgqi6yZenT/glnKVSL1CFdWG3EnM8Iy2hX08YpS1WAsLHs+4
 7R4cuSE7DvDJGiPsnWVc3lVUXWElP7yxAXbSb35mLva3t9srjNkl9ZPI5
 xuOsfgyj3NHUS568R8hR7qSW+DCQcWsBjFv5i1gmmE47yhZsayawS4HMc
 eHmnhlwLHpnmDDmcULw+aniIyLqLiSwaOcVg7cYnrl9iQ3Pj48Z8HAWw8 A==;
X-CSE-ConnectionGUID: U3I85BnBSIO2PBWM8mdIhA==
X-CSE-MsgGUID: xdN7X6rzRkGw+nuFnH8eoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1390974"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1390974"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:26:47 -0700
X-CSE-ConnectionGUID: lOqHez5uT9+2BhqSXJzJag==
X-CSE-MsgGUID: Y34m4sBAT/OqJa6buYb5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3488289"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:26:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:26:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 03:26:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVk2ZNbQ2e+6tLnCN3wh063bU/kUwwuMRJ5voxxMNtI2PZiqg6SSTikZvNMB0OiJQfz4B2VJUfy7UUkdclkVfN+fx0TuiqGVVPLOHp5AK/I95v+Gtj17e7qZoJ2hUoqJVnjK4zh7Q0nzeOZJ8wvCt8JrRPkLLwlRhXrN8dnJ7iS3/Ls5uaQLQzZJCYnePEEtnPKTc44EwkKsHyob/a1U6IzcNvNIgL+mZ+Lc8sA06kEIgrCv/bcHMNTa6m2NPHpS+/OOWViaBVspo94ir4woK7C4VYMs7p7SCjqj0J6aIBoI9Gz2YCeDEndj6K4Rwe+C3J747OPDxxgv7/s0JYXTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tXm0bFn++Q/FyQctr6pPnQet4iLhUE8bv5FElqzfOU=;
 b=h0HzFsemOqNf696dW0LyLkyHMjuqiuIhhe8lKvmHxfYvE+UJbeEVfBZx6plf4M39weZkKenMh0YQujhfaCpkL5Lc0YT8lujrpEZYXrRLlYTFKwKH08o8TzBC41hk/AtQ8t44L5BddI7uBuyrpWPwYInm5kBfuhvZT0a/nvefztlJX52SSbTfeScLlwyXMqdbQDCcdB+ouX89UaknV+lO3bBUDFsYkA+1BsssjGV393SXo4cJcB8g/c70EWpRjDz19I+oH6QJViDo+dXpppJeV9zhO5PlFe8fDlbG+ZZW/+hfX+QWkGkd983R91XZ8lTHFHlKumnGrWP+pHxX8f4WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB245380.namprd11.prod.outlook.com (2603:10b6:806:52d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 10:26:45 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 10:26:44 +0000
Date: Fri, 23 Oct 2026 11:26:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 00/10] IAVF Fixes
Message-ID: <ats2X3wPXLxCcPuQ@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1791991100.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB245380:EE_
X-MS-Office365-Filtering-Correlation-Id: 239ae422-3692-471d-cdc7-08df30f022d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261021121427099003|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: hEVsMrucZ0w7h4c4AJ2BZMO1J8Oj9qmmRZnZCcyLiHWps/NzJp3vSKiWbVd/81uKCHsKokBbEmyEh7HEx2sFicwBz5YEze3OIGb2cbTxaGpmgwUEfIQ+SwHHYvTqZMKwOr2JAQgkRELFOet3jQjsrgMaOQHDAgzahZT+zKJuDqafWv+MY2mbqeNT7Xf/ZcGfoLkZGBsm9b9cAmyoDx/SkfbPOvRSneVw+wVZgCbYSHZHy4cWXLxwquEUGCixDmbxK4FbA0ijK9Qgr4oRVMkB+AqZivL2beOTaufBDJDvb+4O8j7ABOKxHdQIcsPFk1zVn9piEiQ5Ph64iTu5f7C8GvZ712YQ1AFCfP/OZucB2hi1f9iciv+K7hrKvIvpRKwXCe34ImJOrNpDLucR/IkJLv0X1adAtv7sfaO1i8VrtXuMrYBVbXS0ud1QIBBPw0oFLjpuiIV+aaThsicDvSPhUqjZNJvT4Eo+5HxUWTr76Om33kcoJ3U1rnMfKN+G5QHHy54bx6AK+DyHgNEevH2t0D3vV08jN2Q53s7VpTk1w9o72j3zETP/fvQhLKrFTEH9Slv7iJil2734TNEZfzXbjqECZ/jYrb6fdXnXjrufI3rd8qxMY9O4AMgvKU994BZ+sjV3m5V2KpTTz+flIURFSntDPMfwUKd8b9XXmY3rxNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUihwsqw9g5kfK+y0vC2lbsmtHJqiS397Z36aPWJ6FxPHlxxbglnNh7wBBnx?=
 =?us-ascii?Q?kWoJfQOV6/9S/AQ4Tosgx9Nv/BjfOgswVTAB4RxY7dn+B5iITwaBsl/f3roX?=
 =?us-ascii?Q?gk7jeutRsyBXYDfKfV30SmtT8nBXcJrElh6Ztc9JJgeZpp92nIA5Gdfd4Nsa?=
 =?us-ascii?Q?WwD6ni+k46qHHmZwnbJPyHahJqeTgJV1Adz8/Y5oYaLsXdAZDMEt8hg/a21B?=
 =?us-ascii?Q?C+DUCT7E2zlgsiCaszidVluZuEjOIeu6nP+XWqOCkq/76n2T1/DFG5Nq8cVv?=
 =?us-ascii?Q?aA7R4kNjLEg6Dx/9LPD/bOgGYT/+W0+FgPQwHvTk//EHDE4RHIlIO+XSOPCx?=
 =?us-ascii?Q?woNxfR9YYbWp1Jski8Xdr+vJPxUBJeg89FAG2vl24GpjtwGQDw/BujdkYK72?=
 =?us-ascii?Q?GEDQF81HzjpCABQkcBbIed9jbMnppkpOrKF/ZmXX8nftBF5FxBuH0eKb7uf/?=
 =?us-ascii?Q?408MBOdeN0kP105CLqhlshoM5mn0Sy2MsENfEW0AveIO1avsasqU6Kz+lHrM?=
 =?us-ascii?Q?8A5CJmIak1mIXI427bYkoTC/sF6yNRedjAhA4BBZE6qG4KybpY2F1TOawn0V?=
 =?us-ascii?Q?ouAjjhP+7NoSXJxzy7J/s8n9JfRFmyQkE5y25qgg+c5+LLRnAItPcODRMFcb?=
 =?us-ascii?Q?rZiAJl2rP+nMy+Pix574zM8r4DuipaCMhvwHiNR3PyOoIQCRwsmk6w7m2bpx?=
 =?us-ascii?Q?6dVFntpiNxKGZSH/AIkYsTf/f4vz3tZhYMRbQGNf+ZyuEma5be3eyk/kgDj6?=
 =?us-ascii?Q?1vA7trCUWoscTJt8mglGZUxhlGfhCMcbX3rD51er5coEGCjaUEGPq9tof40Z?=
 =?us-ascii?Q?1x0YgUC7e66jHa5HG7lwXkaRNOJGRH7MCcCZGh5Go6oJ+r93WnSJn1CZ3ZDx?=
 =?us-ascii?Q?eMWdeSQS8swYLWGISPd5l9BdG4R1OWGeHNaN3eBrxDJbr5rxU8Devr3ZnFJ2?=
 =?us-ascii?Q?iniZok6RPiKJSnh5teap9YoAY2LlZE19rDzrAjgcIdkcV9nClKGKfPGCRHxj?=
 =?us-ascii?Q?Wi0j6gtpa5r+Z072odVV8TZR3ZEy8N9/JvVXcrJx24ccmKwjoRT5JHQfz711?=
 =?us-ascii?Q?uLMvga8EzdJWIxGzMiIWX/XIZ+E9fTIQnSqEpTkPUJ/8Hs9cZMcNuDjmUd9/?=
 =?us-ascii?Q?GPgPEbvTGHj/2Jj+7Ae3rX3thUJNEipTNt1BEvS5zs8j76/P6TIHIGEHuMhi?=
 =?us-ascii?Q?o5lgDhhl/RM8kEhIgsOwl979gN9ln0+oLrruhtClg8lS2qNxFsCLuzluqKZI?=
 =?us-ascii?Q?YQh/xfoeyFzdAZSk/rQbl0iJxvBDbneuAN8r+Wz3equxctwZU1CdLHRuQN4v?=
 =?us-ascii?Q?zKXpiwKrWMtzR00J5XJWPBkCssp4cEgorKD7Sr5yeio9e/VG0VuOQidk0W0L?=
 =?us-ascii?Q?UmuuNK6aAmZDKRTBe7y61nWaACIlzOYallRT9rxcCWWgrvpe+duFIcxm6XT/?=
 =?us-ascii?Q?aUJ7N+utwgQeZmb1yW53kCJFhyX/gLI79tqEC/5Eo5GfcJWXZXT6ymd7FA6N?=
 =?us-ascii?Q?TwOVwA+mA12XcCNlzvVeNnw+Pkjg7LZUoiN7xPkuqtoLJfPb3Mua0HTAATDw?=
 =?us-ascii?Q?gl8U6ZZdffj9uJF2Ls36nCJdp7N9vrP80u+0JqedSIfLEVk++ophVXVAMfSy?=
 =?us-ascii?Q?5xOAjlXQhXmSbenvIKsk5Anbpbc7QIM+Ppw9YGcqnREg0gRkoOKe4TT40CTJ?=
 =?us-ascii?Q?TploceXgS6V6EeutkOux3Uly2YfjEeGwWri6xwjwS1srHpTLG09UQJPPbNoN?=
 =?us-ascii?Q?NCpG6ZP2za2YDeBH+eHsik8hkMD2fZQ=3D?=
X-Exchange-RoutingPolicyChecked: buco8vr0CIsGcWlVJXD5WjPtX0g3RNd6DaWj57J5/NDfXXLGMrdAr+H69wDuGzEwYwpEcqJ1V0H9HU6Ij3VlL5H9cxN7AH5xVuBkUlCaN4/oBn3S2wJbh8Q4xcbCDBEtDKZVPzCo73doxw0FxUTHSwG4ILjVSiQZLCymdmf8lvV20NZjeRGBf/Wwf1T64EUPCsdSQi8oVMRwTMWlR9w/uetqatk+FzUI5vn1D5M5+n98ay4KXgytAh6NJI4xGmbrzmSvOWjyP9KO4t1i+eQR9M154YdyZvGczPAoJ1S/2Ubvbn6O+/WZMq34d7X4gGF9InSPwlxwOnsrbTB03zlbEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ae422-3692-471d-cdc7-08df30f022d5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:26:44.6381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj0t/ofYVVNR9LSEhm5wuslj0s+LnqZO/BEvDeqpzSq8yEDDoggS/2/Rx+OGRg6EVm3CKQNDWE7CRi0HsZ0zqIXsqZQUgXm8FiBMtoaPzAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB245380
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 10:32:20AM +0100, Anatoly Burakov wrote:
> An assortment of IAVF flow-related memory leak fixes and cleanups.
> 
> v4 -> v5:
> - Dropped the unnecessary EFD disable from patch 4
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
