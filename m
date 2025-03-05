Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E487C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:20:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 780A140156;
	Wed,  5 Mar 2025 10:20:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EA589400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741166413; x=1772702413;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gCmoPwj8jdVSBbcDCTD1fWZ/s2R3fOzLGhAmtFKAhnA=;
 b=OhcGgjP7QRNBk0xwOSbVNnMWWKCNPVuhroaZzKXEf+xdZyTpchPv2lDr
 MORngaESOZmNXcSEYq3pI5Vd07kMSB1fUIF9t3UZOimYCb16EHnL0CIRh
 ohURuzUS9bP0qilHnibyKKJShiqTr+awnp+VwRyQxyoKIefG/iS+y7zoZ
 nJve+Xf/271xFUESs3uKATVn7U+0BeMakP7WIDj8DwTLqHQXxdgUfspgR
 wh19KTznTtm8kEDii8mTe/JltZRF+sGOuO1YqwRCT+XKMVDfF4SlNn5tp
 ECL/j713Y3lJs0+yIY6THajQZCk2mqJsYr+i3FEJM3isuTjyMzW/34d/W w==;
X-CSE-ConnectionGUID: 2yj5DXYcQ3WCzW4pltfHUQ==
X-CSE-MsgGUID: daAcN0IAS+2gfHOdpfjHJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42008097"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="42008097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 01:20:12 -0800
X-CSE-ConnectionGUID: YNlQ8Zi0TtyhofgZ05yomA==
X-CSE-MsgGUID: lOZV4Iy1QHK6F9PO3NNruA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="123232799"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 01:20:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 01:20:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 01:20:11 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 01:20:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdHqbRxBVVI/QP3czub1lRjJHylmrrrPOkXsxfIwsbYN6Qp1cWR0nwjn6VxpfQktkuV+JAZh+aV0hCe3EaWmadTlc4eCkIf7MC4k5C8vQIeSQP+zb4n/ylRKll4Gbetiv49hbTpTbbpzjTd4tFMtRAUIHLzRDqAviZR/3FRlcuL3cnawhNc6HF+eiajeTnOJthgzUQtH4wBhZOx0zH6+2dSjzAfM4YQ0ihF26K8oJlmuh2wBhOUqNNmBccqNh6VQHhGEeytn9Po6vpVasu0GesmTnIwK6gQg6EF4wzBpE6xLjbiV25vrEzH5b6QZQvkP0kfIw9gXc3UMOEQOPvoIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agA2TEJNNcdkyv3Uopy9rz1kluHH/wGEuiEh4mNT9h0=;
 b=fWvunSRVQ+HOziX8yhfWSB5t2lyg0l/Xm27AAxpzvtQJTV8U8Qu7Wrn5jFMdya/kGCu4ATHf5JP550q/Zg0fBWRXIyfqjPhCrg4xoaEtBXLk3t2Evux/+zY/7Qqbdq6Dqv48zS0BnYxgtpt5rJa6xiTP27xcQ0vs722uEaiXdLVrdvgeWtgtH9LSLxnTvR/cOS91Pc4CXZ30Z5codf6o3xaMkWhvN4hCh2/Fep61plkI9Lec4ZE6PzWDGqTY31WdLOHM5JkL5EwgD0G7uWtn6vA5I9b2YGzzHkkhMU0JmpBP4kR7rRCHfMx6F3eWTT3/Nyi2JoD6WZMNHJHuHI9eFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 09:20:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:20:08 +0000
Date: Wed, 5 Mar 2025 09:20:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>, 
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 2/2] app/test: add test_init_m128i using compiler
 intrinsic
Message-ID: <Z8gXQylzSC2geGp_@bricha3-mobl1.ger.corp.intel.com>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741125199-1217-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DUZPR01CA0315.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b66535b-4fd7-4a4f-7489-08dd5bc6ec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u357fOXLW3BscyS/UGfZkNLGY20iyUbizQydvnp6AJRPmucWLywSgKDpUapS?=
 =?us-ascii?Q?cbeadG/+r9+AtugGxLUFkg2Fhkfut6Ftgm0EiQP41CHFCD7ovkDU/qAwna73?=
 =?us-ascii?Q?8argcZELm6qjfE3NPs3e+MjXVz+WGlsH7LR1UdJjbwKzBIhHGlrMmArZ1po1?=
 =?us-ascii?Q?V/Dd0hfg9/eJCSQKh27lHGWhfoU+rFc+kOy2kslBPsYg+C4xfnHV6TDgQDV8?=
 =?us-ascii?Q?Y6PNU9xC7bQp5XMfhft77RynR0+kGXmcrcvfAHW2TloL9OLxAyczBM4ujoY2?=
 =?us-ascii?Q?CmLmcklfGemkSUYaW/O7NbzmszdZZBJi3pIzoA44BcCpOKOvRNnKfheb+gay?=
 =?us-ascii?Q?85+fOCEAiIXzgAzDv8YvwNDzCcwAsIm6JAklHPpHzimEhi2qXaiUISsIVasc?=
 =?us-ascii?Q?TnpCZPqc+0F3ndrTo1EOflCoj22pZZ6pUarkuICeSKPG/KSoPzrLAY/LHzKf?=
 =?us-ascii?Q?JuwLv3PimZEA06xjIy+FUXbjRr7UMs6tcBvxVe11axKbWtRB1T/QEX8r1r2f?=
 =?us-ascii?Q?W4OuuP8/g4pO+9xkRAmvh8P2pz6zLHkxZYZrzzJm20DqIjWrHfmmi9z5lyH9?=
 =?us-ascii?Q?VJJLMR+6K6vm1NfvBIO45kdBSWnxqbd6NeVtuHjVdcNf5fsHdJJHSSULQK4d?=
 =?us-ascii?Q?DywK0Tb9d8rXPUOGVUF9KpdxTXVbMbeoXQ4bZ1VhScTbydox36A+cFhrLS97?=
 =?us-ascii?Q?SjX2x3so7gK+TWSE2HQXRIgGI5LWHt4BrzfuzdAM8+QgEVR52QjbvKSKL2eQ?=
 =?us-ascii?Q?gDc5B3tT0IwvsbUyAE4lrWLQkMXVFm532G35KZbR70KPqdQuuvFH1T316Jnc?=
 =?us-ascii?Q?5gtZclSYGFmEbLlJCdzdds/I36uR5EsbJ9JJBD5ReuoGVdrMZUnzIPkqRl90?=
 =?us-ascii?Q?nX0HO72CI1HzmV191b3bY2uu1N5e/cGcbgqcHvgMQRyVnD7agHRVg4bqDOTh?=
 =?us-ascii?Q?pjA9xaaPBHaYCgm05vK23PebApUkKrsD+w5OpHvu3G0GBqkuAF8f6fv51+rA?=
 =?us-ascii?Q?r8sbHEeZoNmhDbMPjECQSJ2qY9R+gHSX2Jmy84mKP4+JmbNhwXrO3EJdqAnY?=
 =?us-ascii?Q?+UYq0oLxpwJSx5LDEx1GdwGxyiLQzlk/EneN3yhErb2SjptXNXplABSVdlV+?=
 =?us-ascii?Q?y/FzUa3lqAHIK6vCHwIB1NhL1BWrc6H3fmJ8itZSEBf8/k3suaB2Ab0qie4t?=
 =?us-ascii?Q?erwq4INXjdeVoLraUwcdPdijW4EsVqWfoI1ut6h2E0OO0tJlYIxwmllcFZwR?=
 =?us-ascii?Q?inozXapMQPXIlh4+ESysI5VruyexT7gmuvmiHBR7tE+25RypOmRBU7FEWdEj?=
 =?us-ascii?Q?irg1QwkyBH3bQXNwndvkmwcXJ9kcm8gVXt9zFnNJm4yB+OwXll+wSmtxq5DA?=
 =?us-ascii?Q?JFJvdgOfq0UQHeeoSPmmywKCb5Mo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7xwWAFMyrCFZflG92Z2ywt04z2lLg3kHc8FxvnQK7snaGaqR5W4Z2gyGzyF?=
 =?us-ascii?Q?43W/2+sqXhx/EyNjQ11MSb+rbk3/8I+fZWeZ3NjfycpSILvCE302eIjsp4vW?=
 =?us-ascii?Q?cGmT5mn0BzrYwodYhdUhel0UGK4CB9Gt1qreQuo7Yx+RbgdOGLnorg9gP34c?=
 =?us-ascii?Q?u1/RRkPQE3gdTY6eggmGJRiovKvHQ7z3oGYkl83YwJO7/fyCCdh+UTsO9VHB?=
 =?us-ascii?Q?sGaHxVoExdqDSQtfkd70YO/Tlef0qRQO83+r2wvToZJh+ac0Z0S6UfO6d4C0?=
 =?us-ascii?Q?KDNWWtw3MZfnVKS1BJeaMZkctrYeSzYMBdlWXlan+ToczsbcDFEJe8Nukiz2?=
 =?us-ascii?Q?9ZkUbvNiZiodeX1IueAC8eHhnV/izBTQceKvqmessnwuUmgI9yA5rOEI84jn?=
 =?us-ascii?Q?75D2BSixHs0Yh44Ek4InIFhCFSdv/o7uf0fl9hWW4dFLk30nAAYQx66t1RK5?=
 =?us-ascii?Q?lf29JnWW/bs6MwTNmhdgZhKzZJZc5pIR6Cjl2wiLuux7Y1yIfdqtwgICNeKA?=
 =?us-ascii?Q?Ur/Mp4wggIE6UFaM14mfekxwjuoLX0/ix2LUAApk1QirlrIfb65nZXe3TSMq?=
 =?us-ascii?Q?QwaLhDf9hrE6BsVWm/IFz+O/M03AbWD/3v6E+jCE2ITcJtFmzgIRGT5e9vB/?=
 =?us-ascii?Q?0pM4hoH57+foQ4bjEcCqvY70+1NaktDcKlFqgku9CQv1vBMmfpJH9J0zPIaA?=
 =?us-ascii?Q?gaMMkPD5nyJ9/M6Ppgg2120xLRPcu0Zip5Jbb9QqLm4WirFU25/+0Wfs1wJZ?=
 =?us-ascii?Q?q3nAshCBVXN97T9jnlCsEjoaBHG5e5y23cYX71G3EngxTSpHez5srX47JIUc?=
 =?us-ascii?Q?1QIHtS0kXqUUFK7voGoxIhGdOHFiGXQ5QtsspaDmQHLzw5yHbzGlADvAMQgf?=
 =?us-ascii?Q?JxdAsXIia3hbXMKFLcyF1jmS8hmDR5OivA4LSSbARc4J5P7Rvx+nKJu3ezKO?=
 =?us-ascii?Q?r36E3ZaqlJNv6dmvkwcvX6vmgwdwaYN0NeiEwtjTQxb7PYVMTwBOn/Y1KNS/?=
 =?us-ascii?Q?tbzUMIZPYX1Zdg7CUFAwcGh5HzZQ7VhX+xSDg/Lijc35TeVYrHMY19y+hnnB?=
 =?us-ascii?Q?isFJMqUOQTD4sEtka6UPimnlrgHs0WaNXz+JaSNtuwipe8lyhmtitRYntpLb?=
 =?us-ascii?Q?lMePyWdWWp85baHNDhpyBMzZ8+uA8h17sWlzXK5bhpNnRS9BaiJQSIlWEbb7?=
 =?us-ascii?Q?vAJrVgzNwx4KOHJ1nDGwx+bkN3tgSi0MWYzFb2RYuJdqzb0OGaX4XMj0fMPM?=
 =?us-ascii?Q?J1htv4taIAwMVkpNWJMxQvEatLBTdu4sqKahWZXVe91axOtrEc3HwkDXyYOh?=
 =?us-ascii?Q?95WaUdz4xhU4VZo6HDzmCR3OFzTQynIhLNymxiVt/I7xRDylFk5yvAewkKwp?=
 =?us-ascii?Q?lDHQCeOjGaigkjnjiX696kXOwGa4AtWFaVWyNZdUGjLVF29Hi32MR7K2l0CU?=
 =?us-ascii?Q?zwWNVlmNnpLPqtQJVfp1tu2kcXHjZAtiiUOROYJY7kxgZgIYpPgneLWp4lHn?=
 =?us-ascii?Q?+JAJJDcqaQCs+bMqdyLf88MO6apVy7QiCmtv8aQHzJ4lcaLP5Ra4bcUPaQ9q?=
 =?us-ascii?Q?uyXKkrRiacit1cZRptX4kNABSUfXtPO8ytEvgXMOiXGhfTYVkPXRJOsNc8dG?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b66535b-4fd7-4a4f-7489-08dd5bc6ec10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 09:20:08.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27OppeZE/kkjwFoNH6MiFL9rN2kj0rfFM+Un0ORHutYVcDgKSuD1mNnVqLUv/fWXnXhdTijH68K+KLXzbPDiPKGFjLihfTHi4zBGKhogtBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
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

On Tue, Mar 04, 2025 at 01:53:19PM -0800, Andre Muezerie wrote:
> This test initializes an __m128i data type using the old
> non-portable way used until now and the more portable way
> using compiler intrinsics. The test ensures the resulting
> values after initialization match.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  app/test/test_thash.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> index 33b0c6adac..5f7081a3ad 100644
> --- a/app/test/test_thash.c
> +++ b/app/test/test_thash.c
> @@ -1029,6 +1029,35 @@ test_keygen(void)
>  	return TEST_SUCCESS;
>  }
>  
> +#ifdef RTE_ARCH_X86
> +#ifndef RTE_TOOLCHAIN_MSVC
> +static int
> +test_init_m128i(void)
> +{
> +	/* When initializing __m128i with two constant values like below
> +	 * MSVC issues warning C4305:
> +	 *     'initializing': truncation from 'unsigned __int64' to 'char'
> +	 */
> +	static const __m128i a = {
> +			0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
> +
> +	/* Using compiler intrinsics to initialize __m128i is therefore
> +	 * preferred, like below
> +	 */
> +	const __m128i b = _mm_set_epi64x(
> +			0x0C0D0E0F08090A0BULL, 0x0405060700010203ULL);
> +
> +	if (memcmp(&a, &b, sizeof(a)) != 0) {
> +		printf("Same value was expected when initializing data "
> +				"type using compiler intrinsic\n");
> +		return -1;
> +	}
> +
> +	return TEST_SUCCESS;
> +}
> +#endif
> +#endif
> +
Do we still need this patch? I don't think its necessary.
