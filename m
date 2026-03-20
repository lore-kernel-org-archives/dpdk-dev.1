Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85BC1098787
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB01D40430;
	Fri, 20 Mar 2026 15:02:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 82C0C402B2;
 Fri, 20 Mar 2026 15:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774015343; x=1805551343;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9HDVr7t8eh7JBrHaibKHUV6N4g01gLP9yxzGRwhfzjA=;
 b=jcWNLIhRXR2oPQhB0aYBiMwmn3E3zZsFgI0Cs+8uFCW+cVerCFaK/Ups
 hMNAH2BObWUGNAV9dmChG+MSFjBGJ9u3n5tNeiSqXvfmQhExr7Xe+lOf+
 BJNM2nybjbVzcRHlcXkUg6gDvJCVw7I9U+6UWXvwmTu2TGQX9XX/hG6+H
 BJJQzjsjSGLPiWns1tmmLjdG+WmsDlw9CHp6NV4d4GBDHZvmopZ1LzPie
 TOTJ/wiqSMH4lwghqDp1bOZLNyDmnV7KnK22tym+pG34X6tI1HwKXgzbO
 FHt9yz+4rE43PMRjD+DDl2P/fFDHHGPWTE8JitiXm2jCLi0SvM2jr9JyR Q==;
X-CSE-ConnectionGUID: QR/oLI3/RXee6IEjc1ILJA==
X-CSE-MsgGUID: YFlg1h9bSMmSA2CiD5cbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="100554057"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100554057"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:02:05 -0700
X-CSE-ConnectionGUID: 0GBnd9UAQ8yDNMB9xa7sMw==
X-CSE-MsgGUID: vJTy9heMRyGKZLX1RpycPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="220631010"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:02:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:02:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:02:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt1AAgIMetD1/jN1LJXfm/+rtXYbOHn7L9b9ElrEhxiSfCszwiXQ8VTOUhv+N69Uf5LjL9dRziphcuKEpUSz9iYHTfFfXFRhTkG11x5k6zyVi8bwMSExNjeAVyxhJDG+u/Hi4n8KIZJbF4GA4CbW/WgGSm5rImlf6eVk8E4RcSyoQ+yWHIDlCCm0Wv4bCKip5Snl2BXPoR5d0srJ7wwQJWIoju/6hyle/AdhB35i0O/sOVA5WjCWObaC+b5yoJToYxVeflNluYu2Rc/B+kJ1xnT/9oYHXh3GpUkSK+agYtyCDaLcSGSfv0Gj607keoI1cPdK6a8wG2PT+3/0pyWdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EJyzkgekLuNBVROtUV5e1alc/PCVqLDD/mtoLp6i/Y=;
 b=b5J93JKa+yXhABh3hYcSGBWJa3LgXnUCCehLh6YWP96lBGNc7kmG4WSD4U3X/0QFVQGVvzK5wFjb3QFIU+bWQ5miF56RxNrkBZcLxyNDAhFXLsJ1zNNXgVddjbs8G80aXWL3cHEdkJ6jGyq7ADX91/Zv8yXaIvWERfJ0Hzl/Pz0HGYzvivlRGRPZ2q80J8BhUkh85I+NtnkJTIoJxeIgC1POP9qG1BRkvgeHcTI1wmFuswRwzf75E12njeoe+srRQUFyBH3Xz8kEx2rvdNww5OzF5E3ZneZ5evzEqUIUuAl99jMcwuAqH/wAunBC5mkY3o+XC89eV/7bUC5zIFuD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 14:01:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9723.014; Fri, 20 Mar 2026
 14:01:59 +0000
Message-ID: <c0b32ce9-8b47-4d90-a890-0131eaae36fe@intel.com>
Date: Fri, 20 Mar 2026 15:01:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] test/external_memory: skip test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>, <david.marchand@redhat.com>, 
 <stable@dpdk.org>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-6-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260319171334.1151425-6-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: bf96a24a-0f2f-498a-6ae1-08de86894139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: w0TH/eP28SrNYpzAMegrpCYdxpCu0X7CozzRC5bhb5EDNBsCeKPBBFrmiB0oXOvQP0y4rCgnvd3uizTYxzq5Pm1PNqFnFlhiOjjQIvGbxutWNO36715Am52LYIcnqYuiQHIqSSfdk0lM6cvmNXiFhOnUg0Lel7gots1gxmQusI+UiDcE5QkuTjsOI81GMjjAM87n9TqE31LeV4kUVZe9N2gTnP0rzY6F9hSa6HiB+ZVnuEQWOvaLVnVtrs1gz1x7Cj+NuJvFQL4VKG5z9BdL0lr1EfZoFdqxIBldvR73ZRnxh2QfWEgKtFjN4OX3Xr7nGGYsw8jOENcYNoht0Sw0l094PSzLhqLW0ePPYUT94a00sTDoJCYwqzA2VbxukPQ6XR4XqO6m3mo6kT6zPVrGX9VgM3leX4xutbsKP+T1vJfjXdvtOBKi/pwaiHD6NG/O1pUNC+Rfawl+or4mmHXSwMWxBEBzTni7NVmefKnJDzTEc7JAbhw7NFFvkeFHbSc2BaiL4AshH712GcQHA/I2uxc4yHR5RnjxTUyhmegbPqv0Vw9h9oXpU1PwATkj4yJioA+sdmQnH7gAvNooTN0YXJHdrtLoQx/HGOmgXMEQ9PEXGeHBX+VAqXBSuDIa3JBfq8nbJwyhDRW1b0Of27+KDop9CGQayOdyk/Y3Y64Ki7J7W355gruDtEXtiwOcbGoAkLOwUwK13UuKD3nFaei9dzaEwAtbH2rXPTeUzimidWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlcrb2x0QjVpR2dSRmhtYy8xSS9hc24xNHhmLzQ1L0tScGdOVUxkNkJ4ZDhC?=
 =?utf-8?B?VzFROHViWVlYS2Y4aWlOSGZrK1gyN3NMNThaSTlzcm00QTloQitNMHpVUmp6?=
 =?utf-8?B?Q0I1VHRXK2pTcTFxZlpvSW0rQnFzUmRQZTl1eEpXMjg2TkJtaDdrelhnR3c3?=
 =?utf-8?B?Q1ZVQkRtYVlYNXc4WVRiMmdlS1ByZWRmb2VmQUpoMXViZ0NRUlpHL2gvTHps?=
 =?utf-8?B?MXBkbTFJSEVJd3liSWxtOUx1MFlGcnhQYzVyc01FeDloeTZOUnliYks5MThQ?=
 =?utf-8?B?bjVIZ1Nrdjl1aGJlc1RNY2VKV2FQaGtiUlNqRVBhVEdDVWphL1BTalJwN2th?=
 =?utf-8?B?R0l6SU10UWFmY0J6aEtsSVNaRTlOaUlPdlBoT3Y1UTZ6OCs0Nk9SeU1SK3JV?=
 =?utf-8?B?Zy83cFA5T3F6c0VMRGU5MXYyc2tjb2k4TjJuRnRpb3NjOFd2aDc4UGtJc204?=
 =?utf-8?B?cWtFQnhKRmxwaElXZ1d0Zzd5SVZSYkNQdkZ3N2VsdHFweHZ2WStVRlJ6ODdU?=
 =?utf-8?B?bTZGUk52SndmSWw1dXFPSFlrcWJOSmtldTJhTVQ0ZzZycVNnekZQMkJKMWt0?=
 =?utf-8?B?ZHcwRjhlc01ZQm90cmtXUWEzYXFFVHhHODRNSm9xSkNIYWhFRURRT2hFZWNo?=
 =?utf-8?B?alFBZUVxNytlM3dnTUNacU5LMGVvemZXSHprOTBwSkFPcnZBQVVvcG1zWlZh?=
 =?utf-8?B?ZC93QXdrMUoxSTJTaGdKS3BrK2JJaE54cjR1RWlrZkhiR1BGeUJjVkM4WGs5?=
 =?utf-8?B?dXJwYWRNOXQxK3gwbjA3bDljK1Qvd2taUUczZXpRNXg3aHFYNXhxQy90Nnkx?=
 =?utf-8?B?QWZiOHh2UUx0b2o3K2g4Wk1MQ3dtQzcwdkkzQmpUeEdQMktadHpnKzlUa29q?=
 =?utf-8?B?bXRMNjJOemcyR25tYjJiTmhlb2pHdWdLOXc1OEZlemJvV216eGhrU2pURU00?=
 =?utf-8?B?RExic1hlTXg5KzV4VTFlcE1tcFEraDBBcTBIZFQrd213eDJqQ2lnTW5aY2g3?=
 =?utf-8?B?UlkxdHdRUVNiTHdJWURFaFV5dndLTWhBNzBqMXphZEF5TVVMOURWRGR4K3Jk?=
 =?utf-8?B?V0R6d2g0dnVreXdBd2VtRXNsd3dDaDZiTjkvR29zUXFmRzhjRjRtTGxLMmJj?=
 =?utf-8?B?OVhvd0RUNERjMVVRS1VsUm1OK09tcjd1ZnF5UnUvRTZJV2RMdWZTWjRqd2FO?=
 =?utf-8?B?SlM1YVl3aUs2WHh0V1BJSXorTEwyWEJkOExSdVZvcmlqbEQyRTlvL1NtaURn?=
 =?utf-8?B?bzdtaWI5RUhhUk5tbEkxTno0aUYvZ2RVUUh6ZVJ0T2tLOE9GVUx2T2h4L2JH?=
 =?utf-8?B?WkRlOXZOenFTT05VcWNEdHJzbExoNkQxVDU5VUk3YjdSVW0rQko1ZG9xSWJJ?=
 =?utf-8?B?TFZnNlVyVThNcjFCdHVTNExBSHJCU1NzZmprT0ZVK1pUaUdMSGUwaWRPOHdO?=
 =?utf-8?B?enlQM0RwTStpR1N4MXhWRnRSOUpzQ3dsTjQvMENtVlNLM2E3azNmVDVXd1Fm?=
 =?utf-8?B?ckloN0dEaElzQ1RBY0NOc3lBN2tNeE91MVZpY0JFZUwxRWRLL2c5N3NmSytI?=
 =?utf-8?B?RVNCTzZZRDRpTThEOTMrRVRGa2xvSlpUd0JuV2RrWWpUZmhXeDN1NWZ5Q2lQ?=
 =?utf-8?B?NFZ6amhpZERTUjdlTWVxbVZza3pjOERaL2dwV2NwTjYrZXg4S1l2SzhETHRa?=
 =?utf-8?B?N2RaZmhPRXBOSVJmcWJobHhqU1dDczZtc2pkRGNLd1dLVS9oWWhXK2VlVzRQ?=
 =?utf-8?B?a2d0M1Z3OEIxYnZzRk1mZFRPdEFCMzc0TFlBanFHRDJoQUZQdTNiTW5IdEI1?=
 =?utf-8?B?enRxbFZlS3pjKzdiSXVsVzFoa0pTU1NHNWFFdTBHSTRmeDFKVkJsZW9QTWVS?=
 =?utf-8?B?RkhnQXJYOGxLcmJIYUF1c3dqWmVHODFBTm53T2MyRElCUlZ4T1dsazh6SEhT?=
 =?utf-8?B?SzgyaFQ3VUNBbUJwYUJDcVBTZmJVd2VUM0FGMzRHL2ZmRjJUQlF0OGNuQ3VL?=
 =?utf-8?B?MnpkVkd6a0NkMHpCdG1JOEw2QkZ1YloxY25nUktsNExGbEpSUzBpZ0x1c0o5?=
 =?utf-8?B?SEpmdTlLZndxaklObnhLWHNnV0V5aVlWQXVpUTFIdTQ2Wk40Skd3TGUvcEFI?=
 =?utf-8?B?RDk5UlNHNWE5MVEwb24vRmIyek1LRTlzRE9SQmM0S3hHV1Z6Qy9YeTYyTWor?=
 =?utf-8?B?RDlvV3I2VSs1MkVCc1BWTklQZXU3dEJrTU8yVGM0OTdYYU5JV3d2eWc1RHFK?=
 =?utf-8?B?UlFCRVFCaFh3bFZvM3dML1g2Z1BveXp0dVVLb1BuWTQ4cDAvdkdMR1lQL0cw?=
 =?utf-8?B?TDRIbzFRSlZlMjBYYTNkS0p2ZzFULzc5Y3JhSDZmaUw0TExUTGdhcEEvZEhQ?=
 =?utf-8?Q?LgA4YV0qiMZP1Ovw=3D?=
X-Exchange-RoutingPolicyChecked: sTioWHphcNW1h92DCypMuO2Dit4BbWw25mitG0nvKryDfx68IwklHFDQoLWSzuw+GfUnJq1nvpsVSoW5V6t2kbTy2xndSQrIV74JxqLtX/sXE0wd0WtBiVFWH30u5ANclUmxoeMh2juZpgrl0NDo6hmWZX3REdhxbGql8m8p6Eqof/94Usi49DBqBMeOg6WT5Onm//EJlcbrkkEdHbHO+yfHZHqjQLODxXs4UsoUFZiCepBc10tzWeaHGwFbuO39GOLwQoADZMVzItRJAvT0gWmI9eQFUHk8rNscCYiseuhQGrdwNPNGEqLpVQ9e8OIbVbYC6CmtALXKMn5+zuZg3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf96a24a-0f2f-498a-6ae1-08de86894139
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:01:59.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXftpW5UJVLfLj5QLP3c9j7kb31ipNQb2l43Ts7dZOiz0NfbNj4GsjcYVMNqcZlkcpq+2pGsm08IM+mVuxIh47jjDI8XdbZ96DUhtwkLebM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
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

On 3/19/2026 6:11 PM, Bruce Richardson wrote:
> FreeBSD doesn't support external memory, so skip the test.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: b270daa43b3d ("test: support external memory")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   app/test/test_external_mem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
> index 1c977b749b..53300983ed 100644
> --- a/app/test/test_external_mem.c
> +++ b/app/test/test_external_mem.c
> @@ -10,11 +10,11 @@
>   #include <string.h>
>   #include <fcntl.h>
>   
> -#ifdef RTE_EXEC_ENV_WINDOWS
> +#ifndef RTE_EXEC_ENV_LINUX
>   static int
>   test_external_mem(void)
>   {
> -	printf("external_mem not supported on Windows, skipping test\n");
> +	printf("external_mem only supported on Linux, skipping test\n");
>   	return TEST_SKIPPED;
>   }
>   

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
