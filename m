Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957FC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 11:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69FCE402CE;
	Thu,  6 Feb 2025 12:07:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9CD784026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 12:07:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738840064; x=1770376064;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nLG0t/N4Lm9OEShqxGE84ez6NL+1uwtjsjJvzKJAzJs=;
 b=N+Dq9PV1QSNuhpCQ6a4EuxiYKwzqwwGZP+5dRNIKq/Rehm1B4Im4fioq
 3WIURQ0oOY31Y8TgLlPMSwL3tUjNYiSqDjwz8z7tj/kATUX4Nbu433naL
 BX6fwXBydf4yQWn6QQy2kEPMRcvspFupK1DwoSO2IokDOGL6i1XDk+Ih/
 luJ3HBdqucXN3SkDvCs517j0bQbDykNur+VvhK/B+b8NNpO0beNKmV6BJ
 kbUv0Cb9BRikbfPgvdqpjLPNArSETe/ZL3kohnROtqqluxi3798kFapqe
 xqK5fInXCff4rHtwXGZBGo6ru2dSt/OK9YLaVJJ2FgRsxbHaanpIGV1h4 g==;
X-CSE-ConnectionGUID: 0U1zGlQSQv+pMoQ4D0GiHg==
X-CSE-MsgGUID: RdCO93S6TlymcrB/6MrceA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43361973"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="43361973"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 03:07:43 -0800
X-CSE-ConnectionGUID: o7aF2ARlR7C6bo4qM51rqQ==
X-CSE-MsgGUID: DUah8dzBT3mOflbhg5D9hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111759432"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Feb 2025 03:07:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 03:07:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 03:07:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 03:07:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNGjfaD3XakSM6LoKklyXfVqxZKSsOswLV19dMSyE7+mBaAda2Z9GpZrfVmvn8pCiWV5gpDyqA4kvIKsuAL4ue+Nhvx/SzQPRsO45jwvwRtSGW2V+omPSmvhmSJ53VN06/Y1UAvwm/sNNkraiCLCGB2ycYRPTu8fbC0OI36Lcqxnlcx+TLAUOK7pfFFk9US7GEPU0GLSnNtU0/7Of6fxmk5qg8FqBnae7PnHCSLzH/9NFN1KwzSfBSseWXLPqdwf64xjK21c+4EZgwGafVFBT8q2l2J/Zi7NNyhOo2WCobhTlY/xAzHUV+7v/epkBoCPOwGEhnqYeIFqLY6gXWBDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxU4kqgumusf3ejYZKtRWqgQ5wGBx6S7+KKgiTUCv5I=;
 b=cTJpF0MWTCAQ5XZYVQq4K/VJmhmUHZ/qqadzMrNcp63oABpkCNG9aa6QgsK+ag2vikhrlQ2/zsfNszbS6HouDD80EcAKsCyWKDyUi7d2wfT7Y8Fp+RLPTPhirMnVgZ8qzLynwWj4hv1K7Z2krlTwnGpY4mH0spP/25HqAE6vBPp3Xil2fNpnVGzFq2rN7FX7enrjuw71BolDkIdtWedUatqItgEOIwlJ4SnOI+kbnP5krNUZ73v1K2W5yuPKfyKab4LnQZCyrpjOlSJmsZOrjKvdS1fIy+hkPaEOizuAVell+SkbG+eiDWyduCQUx9O+bKajR2TzQSaUpOz97MTc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 11:07:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 11:07:39 +0000
Date: Thu, 6 Feb 2025 11:07:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <jochen.behrens@broadcom.com>, <vladimir.medvedkin@intel.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v4] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <Z6SX9MGQC3f776nN@bricha3-mobl1.ger.corp.intel.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:10:232::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: c554c53e-58e0-4eaa-1bb3-08dd469e77ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jIXlGNfvH9Hh1/ROCQYFeGjKL2EPa9lvUdunExatzOJxaSL9vYUPILUMMu2t?=
 =?us-ascii?Q?nSAaQBI7LCEGZJLkYLjjAk45pqB/vjl0ILFruJM+l1BO2u2Ay9JqeQjQloGd?=
 =?us-ascii?Q?WmS8VM6PFVQ1DqxCtITkfxEtkY0vK28zl5PJwhF//Kn8ynppj68qJxuRIq75?=
 =?us-ascii?Q?6pO7I0McHN/sWAr5r6Q7gYELsH5y3ElNnBA88RdONDflJFnCZs5kJIUz8JDo?=
 =?us-ascii?Q?lmvTAy19e3pdjgkpjAzBrqmr6q/syiy38gEeNtyBahH0WSPP2v8STxcZDcVV?=
 =?us-ascii?Q?hJWvW/R05hIfu+C8c9xycicQkHQ7Hhd3qdjr6s0CUzwQNtGuh8ME+qrJl+tX?=
 =?us-ascii?Q?VAJwBa0oFE4ANF+XHN+Fp+Kp5NtlFRPtvGrrQokr0BEXfA1s2VM4BbWzfGmE?=
 =?us-ascii?Q?P4SsyDb//CDyTVqedxF2r9BSzo8PVYLzT6lrwu0Mz4ONPzknWIhj3LNwWO/k?=
 =?us-ascii?Q?AHjpxWK8LY5vXwpnUHpVzBiQ/NolyPRC8PQsjEU4RZ3JvyhfvX+YiFoXOh56?=
 =?us-ascii?Q?idsrNYbqLZjou7Odjg/nc842uK9EctHm+u2mTCvqrlR6UrFhuIWvRaUMHX1n?=
 =?us-ascii?Q?0+CGYa5KdODj8BfR6eHMCYol8oGYqymnoygrRER1gueHnSaHmXsQtJxACRct?=
 =?us-ascii?Q?Zc6EBy6cs3wNbmbHGqPpbocjH7BHpBU/PH0dD/wS9zvGLqrFAN/N19o45m65?=
 =?us-ascii?Q?tyfK5ZD2aRLnJsa6LHFoLhPe7XhjqIcwzcBqlW3J6OnhHrsE2+tdqY8gIVdY?=
 =?us-ascii?Q?dovjjGgnu1hSsYshnllxUFnZvrckwMz28Hq/c7zPJAZhVFtAvXAJiEvT/svQ?=
 =?us-ascii?Q?nV5roUPGMPGwDivUe5QXvUYIB0lp7YyLMmWk+yOYkNDoReG4s3IQ8DfzD2yf?=
 =?us-ascii?Q?Zjy7qjBpTYdCKgE20Z7N6m0YTCGiMUM7Z24fyFgHRT1KDbVs4/B2Ro4Owg7L?=
 =?us-ascii?Q?rU8OPp1QqWofaIsGBUR98ZvISOOrnRfhLK3oWwImGBCTKqj1pFPsQPlVtbuB?=
 =?us-ascii?Q?e14a61GS3ustprzTIDHvB3t4vbl8+oVG82NM33X1Oquz27aNOyBUFMCCP/qe?=
 =?us-ascii?Q?UHvHONxpDg57DDUAqEuKJyxhQoClOe/M4J6G3UUPGVOt9FKrRvTBSw+QXO7r?=
 =?us-ascii?Q?GyTtc6OD/C2LJwSDI9istzZIWo6Wt1pLfK9ghdxUsqe0+piS9My9eMrUUKwF?=
 =?us-ascii?Q?hgmCzHkvOFP44p2RfxRFxQpY80HyoSaezpb8bEQ1HfZa5/zrmhhc0jrof/w2?=
 =?us-ascii?Q?gS0JDIH/B+m7kq+gshYooMj/rbFU1nVh3EVbdw7FQzbg9ay+TIApnz9hIBEh?=
 =?us-ascii?Q?YUxAia0HMIz06HE95WClzu7DDR3NtyN8SnFny2OtU+sAhYZGgR8IBYiN6Wb8?=
 =?us-ascii?Q?s9SozyhUTQswk67m0AM3T7+wfJ6l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKTTBuZayRe7znSzBsNTTnw+9EUBfUNybBQJZQO7Z7kdv1JXSMvIOgSP+7mb?=
 =?us-ascii?Q?x6Gk7c5lx54E0gDdZkVADdoUk51NK+bj69qEXemhRJ2jsM34XteMmGdw1zBB?=
 =?us-ascii?Q?pGLe25UFJxmH4vRDvHXho/usASFbE6d17icsTVEVCw6eU/BUIk/7rwWVPCmS?=
 =?us-ascii?Q?FJvTZy92wBZCniB1xY6DFKnjDovtd0mzlpANF8jiE0HkcB9rCcEyLnoRY7Tl?=
 =?us-ascii?Q?0TIehfzX6FzI0wP6k4yklrzfZxshYZ3+Zp1nkM0IRyxko9LBiNEnnncB39yH?=
 =?us-ascii?Q?l9H4mJe152bag9dbzomqssT4jATFR7DD28VswEPse/+l39lAIVHG5kE9Hzmw?=
 =?us-ascii?Q?Q+IjjelJqpdH4CceNhOS28q6OfrEnh2TB0y0JyoQEibFllswj+rSOOb/zRwU?=
 =?us-ascii?Q?8xOmkTGMK0/iN4t5pN0I4hZQpI/Pk/jYHSwMlDAyi0KZtldkOWYt5bpWEf9y?=
 =?us-ascii?Q?EzR80p3y1qYIaDC44bJZ2VQHWW1lToP7hbNGqyVscvc7RvorFFFiNfNa9apC?=
 =?us-ascii?Q?fntFqT3poIwBSmykDptDbxivjx9yOfdqOodZ5gcaTW3jI6lQGjvykVu87f/h?=
 =?us-ascii?Q?VMQR0CsHgH/OEBSCMIM1wVKmfEpliiJRHFVYc7qlM6QnLA58Fg8iJ1DGNz2H?=
 =?us-ascii?Q?SIjWhuEajVdWbxDnEKscykRkjzHeBPvwOJta5bUozhXmikrpfDG7NUUDPFVM?=
 =?us-ascii?Q?hOKaZyrGGO5sr1lDSuXXxN8uciNZANdfDQZsM8/egEy25rP02Ut4PEJTP7iu?=
 =?us-ascii?Q?kNnz8cJEZ3ydg0NhHvK/N5vjpchRmx1sSjxeYOGQNgeK+YFsMiI3v7nXB29s?=
 =?us-ascii?Q?YdiMTgsEPfFc1ig0VqoGmRkIaPcCaemhHkczvvjXpHOe0RvuWfa9bW/PNm0R?=
 =?us-ascii?Q?6lPg5ZYjRUUA9S63VmO4ucDmVcKgITgxZsmltAUhX3pABHdyL8Zc3dk1K7x3?=
 =?us-ascii?Q?+XMUJd5/PiDc4k9sPn31YgV0kOQXWXNPf1xPKDJ6mI2DcPrs+Dl1L7UVs7zN?=
 =?us-ascii?Q?YvmaiwclytNGJOrOGM6PoPABom2ZIKHzOyx9IEpbc/UuV8OZeO4er3fgnSX7?=
 =?us-ascii?Q?UQ5yDUTJy0rbUbB3zWbsybY8B01dRKF+rz9vGKH4/QnvP2QQmXXEa9saoMFo?=
 =?us-ascii?Q?n8Tf718L9KDxoONtajyg2M26BKiHouYSdYzorNipt4Vb69nls/Uyw1DCOQsf?=
 =?us-ascii?Q?I7eXnj4sZxcJikajXOGBe46cDaZ6Ogzjym2zkfEsIzXntNxtgqHQPbRP9QQO?=
 =?us-ascii?Q?+vMmc/7ER87492OqAYQpfNmr7/OJIcMJMnDS4IK7r0jiCJydhZgCbUfkpKuE?=
 =?us-ascii?Q?VrYu/Q706DXNvIp+V5vYDVxS0A3gSbQ88il8l2ibWxVHb7oNdulU7vbxjvnJ?=
 =?us-ascii?Q?IyEV9Fmd9hLw+hZ16lsFsg4XV4b+EYvbBXNIn2vTJQAIXk+J8q/0cOmbRayb?=
 =?us-ascii?Q?MEZQPvqheMHTtnnWL/hoXJ/73NYkpVxj8cTyXl2tu72s9lfv2DeBJhST9a6/?=
 =?us-ascii?Q?ao1JEjah/Gg/JKO0/XZdQ2I+OFLN5i059lGoLQYtCWMvVb1/07tNjbQ3KhC1?=
 =?us-ascii?Q?QS1bvhftspbSNvBdtF1e8FiggFPONMualNipVPlxab46YukMHnRcjj3+vvhg?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c554c53e-58e0-4eaa-1bb3-08dd469e77ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:07:39.3498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH48O+Cibj6wJKyC/K+J1/Mu7g1qYg/QmUuNWlSYZuadb3wEfv9zit++2bO8+gLIWKtZWwC2TKep7rZRhvwhIDkqpemRPK7BVpKdqNXbxPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
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

On Wed, Feb 05, 2025 at 11:32:24AM -0800, Andre Muezerie wrote:
> This patch avoids warnings like the ones below emitted by MSVC:
> 
> 1)
> ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
>     result of 32-bit shift implicitly converted to 64 bits
>     (was 64-bit shift intended?)
> 
> 2)
> ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
>     signed/unsigned mismatch
> 
> The fix for (1) is to use 64-bit shifting when appropriate
> (according to what the result is used for).
> 
> The fix for (2) is to explicitly cast the variables used in the
> comparison.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
>  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
>  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
>  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
>  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
>  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
>  drivers/net/vmxnet3/vmxnet3_ethdev.h   |  6 +++---
>  10 files changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index bf5560ccc8..7a962c239d 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -3094,7 +3094,7 @@ i40e_stat_update_48_in_64(struct i40e_hw *hw, uint32_t hireg,
>  	/* enlarge the limitation when statistics counters overflowed */
>  	if (offset_loaded) {
>  		if (I40E_RXTX_BYTES_L_48_BIT(*prev_stat) > *stat)
> -			*stat += (uint64_t)1 << I40E_48_BIT_WIDTH;
> +			*stat += RTE_BIT64(I40E_48_BIT_WIDTH);
>  		*stat += I40E_RXTX_BYTES_H_16_BIT(*prev_stat);
>  	}
>  	*prev_stat = *stat;
> @@ -4494,7 +4494,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>  	pool_sel = dev->data->mac_pool_sel[index];
>  
>  	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
> -		if (pool_sel & (1ULL << i)) {
> +		if (pool_sel & RTE_BIT64(i)) {
>  			if (i == 0)
>  				vsi = pf->main_vsi;
>  			else {
> @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
>  	for (i = 0; i < reta_size; i++) {
>  		idx = i / RTE_ETH_RETA_GROUP_SIZE;
>  		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> -		if (reta_conf[idx].mask & (1ULL << shift))
> +		if (reta_conf[idx].mask & RTE_BIT64(shift))
>  			lut[i] = reta_conf[idx].reta[shift];
>  	}
>  	ret = i40e_set_rss_lut(pf->main_vsi, lut, reta_size);
> @@ -4674,7 +4674,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
>  	for (i = 0; i < reta_size; i++) {
>  		idx = i / RTE_ETH_RETA_GROUP_SIZE;
>  		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> -		if (reta_conf[idx].mask & (1ULL << shift))
> +		if (reta_conf[idx].mask & RTE_BIT64(shift))
>  			reta_conf[idx].reta[shift] = lut[i];
>  	}
>  
> @@ -6712,7 +6712,7 @@ i40e_vmdq_setup(struct rte_eth_dev *dev)
>  	loop = sizeof(vmdq_conf->pool_map[0].pools) * CHAR_BIT;
>  	for (i = 0; i < vmdq_conf->nb_pool_maps; i++) {
>  		for (j = 0; j < loop && j < pf->nb_cfg_vmdq_vsi; j++) {
> -			if (vmdq_conf->pool_map[i].pools & (1UL << j)) {
> +			if (vmdq_conf->pool_map[i].pools & RTE_BIT64(j)) {
>  				PMD_INIT_LOG(INFO, "Add vlan %u to vmdq pool %u",
>  					vmdq_conf->pool_map[i].vlan_id, j);
>  
> @@ -6761,7 +6761,7 @@ i40e_stat_update_32(struct i40e_hw *hw,
>  		*stat = (uint64_t)(new_data - *offset);
>  	else
>  		*stat = (uint64_t)((new_data +
> -			((uint64_t)1 << I40E_32_BIT_WIDTH)) - *offset);
> +			RTE_BIT64(I40E_32_BIT_WIDTH)) - *offset);
>  }
>  
>  static void
> @@ -6789,7 +6789,7 @@ i40e_stat_update_48(struct i40e_hw *hw,
>  		*stat = new_data - *offset;
>  	else
>  		*stat = (uint64_t)((new_data +
> -			((uint64_t)1 << I40E_48_BIT_WIDTH)) - *offset);
> +			RTE_BIT64(I40E_48_BIT_WIDTH)) - *offset);
>  
>  	*stat &= I40E_48_BIT_MASK;
>  }
> @@ -7730,7 +7730,7 @@ i40e_config_hena(const struct i40e_adapter *adapter, uint64_t flags)
>  		return hena;
>  
>  	for (i = RTE_ETH_FLOW_UNKNOWN + 1; i < I40E_FLOW_TYPE_MAX; i++) {
> -		if (flags & (1ULL << i))
> +		if (flags & RTE_BIT64(i))
>  			hena |= adapter->pctypes_tbl[i];
>  	}
>  
> @@ -7749,7 +7749,7 @@ i40e_parse_hena(const struct i40e_adapter *adapter, uint64_t flags)
>  
>  	for (i = RTE_ETH_FLOW_UNKNOWN + 1; i < I40E_FLOW_TYPE_MAX; i++) {
>  		if (flags & adapter->pctypes_tbl[i])
> -			rss_hf |= (1ULL << i);
> +			rss_hf |= RTE_BIT64(i);
>  	}
>  	return rss_hf;
>  }
> @@ -10162,7 +10162,7 @@ i40e_flowtype_to_pctype(const struct i40e_adapter *adapter, uint16_t flow_type)
>  	if (flow_type < I40E_FLOW_TYPE_MAX) {
>  		pctype_mask = adapter->pctypes_tbl[flow_type];
>  		for (i = I40E_FILTER_PCTYPE_MAX - 1; i > 0; i--) {
> -			if (pctype_mask & (1ULL << i))
> +			if (pctype_mask & RTE_BIT64(i))
>  				return (enum i40e_filter_pctype)i;
>  		}
>  	}
> @@ -10174,7 +10174,7 @@ i40e_pctype_to_flowtype(const struct i40e_adapter *adapter,
>  			enum i40e_filter_pctype pctype)
>  {
>  	uint16_t flowtype;
> -	uint64_t pctype_mask = 1ULL << pctype;
> +	uint64_t pctype_mask = RTE_BIT64(pctype);
>  
>  	for (flowtype = RTE_ETH_FLOW_UNKNOWN + 1; flowtype < I40E_FLOW_TYPE_MAX;
>  	     flowtype++) {
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 328c224c93..9cd2b0c867 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2485,7 +2485,7 @@ iavf_init_proto_xtr(struct rte_eth_dev *dev)
>  		if (!xtr_ol->required)
>  			continue;
>  
> -		if (!(vf->supported_rxdid & BIT(rxdid))) {
> +		if (!(vf->supported_rxdid & RTE_BIT64(rxdid))) {
>  			PMD_DRV_LOG(ERR,
>  				    "rxdid[%u] is not supported in hardware",
>  				    rxdid);
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index c48c98e5e6..657963750d 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -3871,7 +3871,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
>  			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d] is legacy, "
>  				"set rx_pkt_burst as legacy for all queues", rxq->rxdid, i);
>  			use_flex = false;
> -		} else if (!(vf->supported_rxdid & BIT(rxq->rxdid))) {
> +		} else if (!(vf->supported_rxdid & RTE_BIT64(rxq->rxdid))) {
>  			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d] is not supported, "
>  				"set rx_pkt_burst as legacy for all queues", rxq->rxdid, i);
>  			use_flex = false;
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index c74466735d..6feca8435e 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1263,7 +1263,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
>  #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
>  		if (vf->vf_res->vf_cap_flags &
>  		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
> -			if (vf->supported_rxdid & BIT(rxq[i]->rxdid)) {
> +			if (vf->supported_rxdid & RTE_BIT64(rxq[i]->rxdid)) {
>  				vc_qp->rxq.rxdid = rxq[i]->rxdid;
>  				PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d]",
>  					    vc_qp->rxq.rxdid, i);
> diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
> index addb922ac9..dc5956f92c 100644
> --- a/drivers/net/intel/ice/base/meson.build
> +++ b/drivers/net/intel/ice/base/meson.build
> @@ -31,18 +31,25 @@ sources = [
>          'ice_vf_mbx.c',
>  ]
>  
> -error_cflags = [
> -        '-Wno-unused-but-set-variable',
> -        '-Wno-unused-variable',
> -        '-Wno-unused-parameter',
> -]
> +if is_ms_compiler
> +    error_cflags = [
> +            '/wd4101', # unreferenced local variable
> +            '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
> +    ]
> +else
> +    error_cflags = [
> +            '-Wno-unused-but-set-variable',
> +            '-Wno-unused-variable',
> +            '-Wno-unused-parameter',
> +    ]
> +endif
>  

Do we actually need these if-else blocks here? The way
the code is structured is that we check if the flags work to the current
compiler and use only those that are relevant. Therefore, we should just be
able to have a list of error flags and leave meson to filter out the
incorrect ones.

>  # Bugzilla ID: 678
>  if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
>      error_cflags += ['-Wno-array-bounds']
>  endif
>  
> -if is_windows and cc.get_id() != 'clang'
> +if is_windows and not is_ms_compiler and cc.get_id() != 'clang'

Are there other supported compiler options for windows other than MSVC and
clang? For what compiler are we adding this flag?

>      cflags += ['-fno-asynchronous-unwind-tables']
>  endif
>  
> diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> index 7967c35533..2832d223d1 100644
> --- a/drivers/net/intel/ice/ice_dcf_sched.c
> +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> @@ -174,7 +174,7 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
>  	}
>  
>  	/* for non-leaf node */
> -	if (node_id >= 8 * hw->num_vfs) {
> +	if (node_id >= (uint32_t)(8 * hw->num_vfs)) {
>  		if (params->nonleaf.wfq_weight_mode) {
>  			error->type =
>  				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 80eee03204..6f6f618a2f 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -2469,13 +2469,13 @@ ice_get_supported_rxdid(struct ice_hw *hw)
>  	uint32_t regval;
>  	int i;
>  
> -	supported_rxdid |= BIT(ICE_RXDID_LEGACY_1);
> +	supported_rxdid |= RTE_BIT64(ICE_RXDID_LEGACY_1);
>  
>  	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
>  		regval = ICE_READ_REG(hw, GLFLXP_RXDID_FLAGS(i, 0));
>  		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
>  			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
> -			supported_rxdid |= BIT(i);
> +			supported_rxdid |= RTE_BIT64(i);
>  	}
>  	return supported_rxdid;
>  }
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 8dd8644b16..87a9d93e89 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -399,7 +399,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
>  	PMD_DRV_LOG(DEBUG, "Port (%u) - Rx queue (%u) is set with RXDID : %u",
>  		    rxq->port_id, rxq->queue_id, rxdid);
>  
> -	if (!(pf->supported_rxdid & BIT(rxdid))) {
> +	if (!(pf->supported_rxdid & RTE_BIT64(rxdid))) {
>  		PMD_DRV_LOG(ERR, "currently package doesn't support RXDID (%u)",
>  			    rxdid);
>  		return -EINVAL;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 5f18fbaad5..078f7b47c3 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -2722,7 +2722,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
>  					ixgbe_set_vf_rate_limit(
>  						dev, vf,
>  						vfinfo[vf].tx_rate[idx],
> -						1 << idx);
> +						RTE_BIT64(idx));
>  	}
>  
>  	ixgbe_restore_statistics_mapping(dev);
> diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> index e9ded6663d..e59cb285f4 100644
> --- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
> +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> @@ -186,14 +186,14 @@ static inline uint8_t
>  vmxnet3_get_ring_idx(struct vmxnet3_hw *hw, uint32 rqID)
>  {
>  	return (rqID >= hw->num_rx_queues &&
> -		rqID < 2 * hw->num_rx_queues) ? 1 : 0;
> +		rqID < (uint32)2 * hw->num_rx_queues) ? 1 : 0;

Why uint32 rather than uint32_t which are the normal types we use in DPDK?
Could this also be simplified to just 2U?

>  }
>  
>  static inline bool
>  vmxnet3_rx_data_ring(struct vmxnet3_hw *hw, uint32 rqID)
>  {
> -	return (rqID >= 2 * hw->num_rx_queues &&
> -		rqID < 3 * hw->num_rx_queues);
> +	return (rqID >= (uint32)2 * hw->num_rx_queues &&
> +		rqID < (uint32)3 * hw->num_rx_queues);
>  }
>  
>  /*
> -- 
> 2.47.2.vfs.0.1
> 
