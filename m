Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53FCA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 07:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5722E4069D;
	Thu, 28 Aug 2025 09:42:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B567B4025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 09:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756366950; x=1787902950;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KgjugNUBXRAFyxb0m2Xw673aFCtVUjVH5wkGy/jd4q4=;
 b=QFMuBt78bRWMt+EVld7Pm5xIxAOKKWNIt/h0e8XGrqZn0KGdSV5KqwjZ
 WXVMtJnJrocJ9xq1yUTvvfgfbQ14FcBXDAdgEkC1xleMoyT9ByRy8kGZG
 xqBX54MfpXpIWIz4pl2CfDWmooJg0ZqlAvRieGn6+H0JZ6EXmCmXQiL+D
 wi2p/JfyPMHLuj/uZQCl8dAdf6QbRpPEoO7RhR/OtJpiwTLPSuWz5O7iQ
 q6G6hJjiyXILMSnAlq4/0bKmFDVq5OmGqiamtfkUMVYggrOMISbrcdf+1
 fkw85Yb7ac5yzEzmsCvbddhmGkcQKEvRwavLG7gvOqS5o5NqqWac6TDmG g==;
X-CSE-ConnectionGUID: WEbFqIB0SImdrEE+Zh3pUA==
X-CSE-MsgGUID: +Ez59fMfT4yjyWzXQO+1+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69721474"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69721474"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:42:28 -0700
X-CSE-ConnectionGUID: Y+L2vAqlQ5iafNtEje+ZNA==
X-CSE-MsgGUID: m4JAXFAPQAODXc0pnVumOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175317479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 00:42:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:42:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 00:42:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 00:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdJJAHsci4G4joxgVrXefpmoQSCX8x8uP4RX0F96BEmIi4z7xWcW37eRYRTYEc1O0JHoluipSeObLnVXEGzeORE0u5X/MNVlgxIKfUB20uT5/ca4Ub1MTUXRblmfEBlHeBneTkbtfzipGyOZZU0QueOmCj3ekr3YtmlbPrZ80vPLxzpoyw4AR1VCyNTRJbISOPYwj0sQf6vJdhUZ7NZSYaPxne/bOCj87vkA75F/AgtJwvFVdIZ02QkUkHDjUeoEcfwIBcExZNu65JjKiAJ6Dm90KvFk8ZgsZ7qjIJ5j76rumZVvsjFp6bgU0HmBb2pMRxXHcOzSZo0VRKdUV5JXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oelYGID06FTGp/kiodg3TIFzUSKOzbgF5Q0aSPuSXlY=;
 b=Qspx5PeZ2nGMYQr/vd1ftePDUFEvzUcTikWs7LNZJlIdw7YP+eSrxTYAn3l8RPodRKvWhe5m1T5Ibd6kQdaezUhhA2qfE7639J2vnac4Tm+Cdaaq7+df1yfu7lOS6O7GA1jDO/LOmooC1fEUl8ak45OOxQObfm0JS7TcX1bOSbzw8eQBw5FJXZxw/Ow21rAbpusMUQiG+A4sFjkjixcl34T6UUHbJrKDY8WILwR92tgs03NZXuPEdFD0OEpReo/fq1rHV+W9gKMMFiH5PX7ECh2LM7RJvIPYgKxF4+0IGlEcjZP8V6OTkcvtVaM3CPKkPFyuzFNoZVjigoz8ofcePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 07:42:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:42:24 +0000
Date: Thu, 28 Aug 2025 08:42:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <honnappa.nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Gavin Hu <gahu@nvidia.com>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: Re: [RFC 1/8] test/ring: avoid shadow variable usage
Message-ID: <aLAIW3PRwpEILsAa@bricha3-mobl1.ger.corp.intel.com>
References: <20250827231528.236172-1-stephen@networkplumber.org>
 <20250827231528.236172-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827231528.236172-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: a88f9e77-7053-4f8d-3be2-08dde6066dc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CKnvHzfpTEJHISw6pJ4uY2gTzTQZRd/9/v9HDLZl1ywzJEuaAXwntYwfGfo7?=
 =?us-ascii?Q?7K2EiSRpzt1N+rnOUUvT55FguabGVTGabLbGLaompFLy6m8K/ng+bAGX/Ou5?=
 =?us-ascii?Q?7XHfP/c6QfTxN7U+r63lLgpZM8iFr6gTzBYwuSZv4L+pMl6I0A4SAx5fdh/s?=
 =?us-ascii?Q?D/Oma2iBooDv3sgNJ3nWrNBYoCgyi35AZ27pm4+KZKYWnidhXRY8JPQ5oA9Z?=
 =?us-ascii?Q?esNH2kYs4RG4wx8Ll+aqAy3hBR98c/uAKpk4dNG3ZwGPjQaKrPH8IDnXWST7?=
 =?us-ascii?Q?/91kmByOebfa4mRuLmkRgC1Mu+SCUK53r1YBRjaBVuYqQzDuymO9DdFwnSZm?=
 =?us-ascii?Q?zzl0mzlL230enppkKI0vOPTRv4Q/FLa7YiHDpF46/y5zqeznOyxleT8u/rZK?=
 =?us-ascii?Q?1wb/ifICOYagUhypC3kEb6eqHh5B+HxulGBNVEq0KopDgCOas8KT1BVEAtQf?=
 =?us-ascii?Q?dR8SBdNMDmpBmTAWfLiGi9mseeYQdbsH1IsJhG42gDP5EUK0HeyCMuwi6chP?=
 =?us-ascii?Q?cDEg2sB4xnAnf5D4I3TA5MchMhvb9B4D9OtQv/53yTtgoeGTC0rlYPeUsHDU?=
 =?us-ascii?Q?XQ+KXp/3KpaA+htUvbRNPcUWPUZrb4XYCnVIwNPf+cIub/5vdrRE366YVkBO?=
 =?us-ascii?Q?ox4pNQ4MJ7OiCO17LstoWPQrKrHndOkh7+Ld3w5SYeIrT2qfDwZTWtb1mIfe?=
 =?us-ascii?Q?f5VjPSLRw0CXLcRvgy8VJCRqWqGUAe9RddEWJnzJjMxQm6ykZ8Zqc/mFajL+?=
 =?us-ascii?Q?B720UJKJBOle673kVh9Jd4UuTn/lvmTLZzcHpWBpCBRzP8ahnSrEw9XSNkHT?=
 =?us-ascii?Q?YbHhxefdtjT9WUCCQxi8DLP3XyIZKCTmRW+Utv3kQ19nGaFn+cUZJUTeNeD4?=
 =?us-ascii?Q?9I6FelCVOEkFVwZbAbG5KFoalBgrAhbu9Eje0S0ernABb41vNoB+Pve8sIEn?=
 =?us-ascii?Q?IwYG1Z+vyekIoHM0vLrTk89KBnjD8uCa7gGuvxaQi8NT/nltQdni3wyO1na0?=
 =?us-ascii?Q?bqXv+GFrimujy0UIwD61Y9kZ7VASPo7tQJ9VX20vVfyoaTliUVGiFmFazbL+?=
 =?us-ascii?Q?IBcrDt7HpqIyoduyXuPbt6TmYi4S4JmFogijScJH09TdE2fTmaCmv5s2tHvO?=
 =?us-ascii?Q?y5DZ1abLCHIDZBr9i5A8Zi9dY+lolxKZSHgu0GVM9ylhGRgYZn4L490BHior?=
 =?us-ascii?Q?4q/TIGH4SYioWbEDg7xClSInM+vrnZNDJcmvKFc/ElP6rHNA5tTzoq2w9Yiy?=
 =?us-ascii?Q?xWsJlUc1Fh8PL9MSfSSu5VMH/XKziCnO0GjXvLQr8RpagZ6PD0E4pBn2E6fo?=
 =?us-ascii?Q?9HNOAwNXr8nI9kZ/A7MoJjCX1HOOFYWgD4QLoXDmNtgilcbwXtG32DMe+M2k?=
 =?us-ascii?Q?QQq9X8gOchU0fCMEgs8/IXTprI9LHcJEPRvDtXqaUe7pjAwZgiV5yhD1JMax?=
 =?us-ascii?Q?01Q6zGaYg/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BeAO3PPCTCLvDdf1cCYs+ml8oIPOniv9z5/hANBZWWOjQKQsi6Hhc/Fk2059?=
 =?us-ascii?Q?5brAsBU9/vxd2SAyp8Tg43ARS33r8G0Fea0DBZlEiTPK1YmsCI3owfLWcG0B?=
 =?us-ascii?Q?C4S4TFy6YhC+wVZc62inwekueJHWk93D0C131SER849R4aPi5hl/JbeBtrw8?=
 =?us-ascii?Q?QXM65sl9R8Vc5ZXfOzwmWKBs4WEUqBXlD3a2Qwy0xWG72Hq+okRpyw0rNGFc?=
 =?us-ascii?Q?gbZyRIjaHVDsQ939vnbfmmQ1nGGCjB3Zc5yMIcuXcm6NhAFz2vTdaOm5Tdo8?=
 =?us-ascii?Q?vXbVRIGCKY9pEgGOz3+cAD8uaLIxPp6+kIGuI2DsqCeGjOsQppyenX/Y+ix5?=
 =?us-ascii?Q?2Y0WGzZMeBqs+OhxZnHjwSyoQNqNClmBfmiuzTywvKD8i/shCBrgsXeKr7hq?=
 =?us-ascii?Q?WeB4DL3Klv6iS119t+tfVC3GmHtc9hF/KMc1wXpoMjPFxng9leREhGnyMDq4?=
 =?us-ascii?Q?3W/rSQkB4gQcXsgSCaWy4lOluxMlU5z/Mp8G8NSjVsv8Upg+EMBDJD72PVyT?=
 =?us-ascii?Q?vN9TmfVal+1nJPI9Udg27mzjlvij3EvkcO+7N3GsyeRHaS2mLc6FFaGzgahO?=
 =?us-ascii?Q?o3ewfC4tgMNqY/T6E88rtIxq3j/YHGH/RAy1V6AjCeJsvQAFN+gTAg7YSDuV?=
 =?us-ascii?Q?Ie/EkMvkFPHyo4iCgMeiSj2ZsSZ1uEYpj7sTwaWC+cAwi184Kym85neHpn5s?=
 =?us-ascii?Q?J0V+3fwRoRRzAv0JYI3drMG3pG91e60S63zWpwWwkCsPtWP61SqqkMPJkrui?=
 =?us-ascii?Q?2ODBNrt3Wj+HDx5bsWnGs0ZdbBKT3sy6MZsGhq3+05M4sg3F+Qy7dFv33jT9?=
 =?us-ascii?Q?qWcBsJFoJnxckig3MmDqdnvMcVEauQa+D2XHcniVnrEkN8ENs+i0uuYenIoh?=
 =?us-ascii?Q?dnTuntvj1PNqQbKeFZjBYnTIcQWIjOw/QZjTQuWJRbzl64R6o8X8vYJ8PqnH?=
 =?us-ascii?Q?6E+z3wy571ykug3x4svXN31jECVSNZCE4KRXvOXkMq/6qQELsbrs8hMgCjNt?=
 =?us-ascii?Q?If04MWvtIbTGSGs4ldEs6iCUeLqI6CV1vLzFI+nD2OzByqa5uJ187E5swEuV?=
 =?us-ascii?Q?XYNdmzJmhpbzX1f6VLdONoUVvINKhaQJtCMN+LTv5UNOirEdvcev97Ju/605?=
 =?us-ascii?Q?m8wGfGL9pi6+t6Xm7jWIViCVjyuRJ8LfnqXcpKzT1PX5saQoUXDbOBeBL8Pr?=
 =?us-ascii?Q?97RLu+PQIE+V5L4f2bOQ8HRnUkY1KqZ6m57Vek704TVDeysH2J7JB8DE8oGH?=
 =?us-ascii?Q?HuepFaPkaDVgIJp8ijeM0sEFE8e6K85vMti1gX7UOn/mHubcX1jU/sGTEKL7?=
 =?us-ascii?Q?HxpXKfcQsteXIWi/OZF6BLI6UWcdbWzmgrCCu1wyfiD4KKRC3zXrQG0JpHrq?=
 =?us-ascii?Q?6P8p6wqhyMToVrtCQ4ZIyuzFk2FuPKRpLJ9jbYUKQdhQ8pTvF4gRNk8qHG9f?=
 =?us-ascii?Q?Pwq8N7BgM2XtCNIU7p1sCjgLO/8rI34elX/2+aLFBXWcS6fDQCCVLLaxLDdx?=
 =?us-ascii?Q?LDBqZ+CBBQIrGyqtI1WdolcURKxDNzYFNBsMfR04hyp5IkISs6ng1uZ8I6rl?=
 =?us-ascii?Q?5T40SFLZnUL+dUNY2KFf7TC/3hh9shv32kFXDE605xdahYlbHjKSIL1LjLrf?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88f9e77-7053-4f8d-3be2-08dde6066dc9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:42:24.4059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ePhEkmQUIUdBfnop+NKYn8RQEJsJh3A7XFP4PqLgqRvarl9FW8IcwYxuqLD3Np0hMQ4qKBMPHMIzZUdYuP8+wAzRBEn1axTvLb2sDVhVoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
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

On Wed, Aug 27, 2025 at 04:14:04PM -0700, Stephen Hemminger wrote:
> The code had a global array "esize" and also local variable
> with same name. This would cause warnings if -Wshadow was enabled.
> Fix by renaming the array to "esizes".
> 
> Fixes: a9fe152363e2 ("test/ring: add custom element size functional tests")
> Cc: honnappa.nagarahalli@arm.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_ring.c | 190 +++++++++++++++++++++----------------------
>  1 file changed, 95 insertions(+), 95 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

