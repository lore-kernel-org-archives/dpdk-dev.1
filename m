Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E21EF483DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 17:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E620E40268;
	Mon, 23 Mar 2026 18:56:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5234025F;
 Mon, 23 Mar 2026 18:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774288563; x=1805824563;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xhKb17El3mQJcbf7TGCknFiU5tVi3olOwU52CkbSycY=;
 b=hpFxAYtr8+b8I2NIDGIae/pZGNLEjeROts9nhiXSQKXEsXdS2jLepy6R
 7aNTwaFpS8iAYAfeYZZi+xmyqiI34lrLU/2mzpfHlTi9GUdwul/TS4Pxb
 HqVPgW15hFxmwN/CnvMuOeCK5KSaB3mFt8MLTOXsxUkLwvZDLNP6LDV2C
 3JWb9s6h3+GQp/fHZkadjvz7MaJduoRmUI1K1EI0rPXfk5sQ1tfBl4qpg
 1AwuC5/9YzEhTM/o/o5gP3xdjrzfOLzb9GOj5QgKOTX7gkWTe1P+GZza1
 AT4mzq2DRyDti4VUfEnkU8fHODk+wHx6QM85cVwG7fflQAsjJUbSCqwTA w==;
X-CSE-ConnectionGUID: XlVhpNTgRGKIWAnfv6kpPg==
X-CSE-MsgGUID: AJ5FmEXFRAGeRmH0Hapylw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92868411"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="92868411"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:56:02 -0700
X-CSE-ConnectionGUID: lot6nHF3Q9200dP9oKRn0A==
X-CSE-MsgGUID: 7cBDdn/YRuuuwF2QXgS79g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="254584413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:56:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:56:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 10:56:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 10:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8Akee+8GBsoVNxjgUiHTMuJ9qbi1tg/HkBXURLTwU1BgciUMfCu2QyhGhHL60NuIM5BpkMx6wSZYpZ2lyWq6X6+wwFw5Ixbf8vhnndEekNy9f4iiaXYBvC+mKEBANzQggnbfcCWpWLNy/d4a1ToiE1rxMZv0sSYawnhY0j4f6vi1vzCKbzT031tU03trMTYES2Y/JsnjKFhZiOxpjMyAHMxxk508lyNrBfCF/j5W7gz/FdrTQXqUHsNP+w+fDiwGhISx1G8mDXtZe/HLr7WsRiKANo5lasoMqIWDJV4qtfqFEZnRXOS9QejbrFLdpX/rBedUo1YzU2l04bz3xtSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x4hs8aHx7hP7DCH4MDGjEmV9B1oHTRGMKoRtfSSKeQ=;
 b=Xc8HZvKhT4x0h4NPLnihnhlr8VQw9q9tjhrINzprfqX2+5fUFittNMJFSxPa8viK30sfrYxkNLHNkFLDw1st2ZbzuAnkCTtLi+SZqkSXlr7kaaLEHU8Qz4JVeLX0Du0emlSV+bHd8fmu1wV6rrKDCo7jeavhzaaJkEgH2mQ/WLx0O9jOP3SnBr2UfiTQFgQxtz1iCLuot0mGR1sOKhtpF1ztM31ndndY1jWk7SRjw56VCq2Wn45a2X6QicaGroer6+esmmZOkBfQCf0J2MW08cATXNJOTE+ByClDRKrJNzNlIYtifh0CZzb9p2/EJkJH5XN3WjtH/Hhbstt4L9OHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 17:55:58 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 17:55:58 +0000
Message-ID: <f5db5995-00a9-43c4-8aec-c420def29b94@intel.com>
Date: Mon, 23 Mar 2026 17:55:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ice: fix RSS hash function implementation
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <qiming.yang@intel.com>, <alex.chapman@arm.com>, <stable@dpdk.org>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <20260317103203.404781-1-anurag.mandal@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260317103203.404781-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::23) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 8825589a-35e9-4017-3599-08de89056fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: c9hnK/Q/m4m9limXFKRbYRcU6TgRvmkDTT/TumltejhbtYsQPp/S9IxLuhNaTpDvJECsC6Gw241ZJJaib21DV8sGtF1ZATj3OxFuQsYBUolMFhovGXy0pbITYqhQUM8pnZ7vt0BYeW/qm8jOdHrBhoUWAoWiospuz8gP6KwZKMQH2XvhS7WqrhY1kV2544IC1a+lc3MaUy+O0DvlmCiP3Ytdnqr0c1Otiswttd+RQXhwyhtwU0UaWH3y/1GGNoG7wL18mUPznXrS64dJNYmpbOaZVb7L7BtHAAkvkmAMIevxT4RsTfuIDAlHb7LzBsPtovYzZEsDoCa7PVr9AeKlhq9IAHiA+RYB7uVNQyJQA6RQyMEcOGuEEoCy4IdaNvo+XloweGeBzv3PkwAdzJz3PDCxfv5UM0Ne9s3Qt6V87C3d2XPPaiiR04ulWhwFsynWKyGytBH0X4c5S7K2XMwNXFV1CYn8E/tlcHM78W1dtbScp2pmk+VvYCRVa5qGEXAsSf3DEXeUtzqANcetLUT/ikxnzjr2nM7oGqIgEXa3oEI+iSBGUGC+IjrhZAlBKtoXrgQtmWYlGVEj0lmly1sM2QuXoY6z0yNUFwiEKuoav0C+RiwTfuBkhBWpbTWA67Fcyi6ic7Ol3puaQlPIPZ5hyNIfJEMI/Gtbo81KEQh8hA/vHRImOC5uXeGF2zqF5ECZWSwuOyYzJm49WTUQdyf7wMns8jgxCwqqkAHNShXFV98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1l0ZXZab0lkT2VMQlJ2S253SUZlN3VjVFRodGg2RTlWUVVOdGJjdlFENjBo?=
 =?utf-8?B?eC90YTJtMlMrR0NscmNrd01RVXpxalN3Q1E2L2RoUHhLUWNLWk1ZU3I3ZmZ1?=
 =?utf-8?B?U3VMNTNVdnFRQW9iV1Q5UWZ4UFJWNk45b0RrMjYxeDlZR0UxT0VMWDJtZVNh?=
 =?utf-8?B?SWhVTVNXa21zbG5mWVV3WHpsL3hnVlAxVS91cXBDQXd4L2RwR251YnFWVjYz?=
 =?utf-8?B?b3Y2WjNSQ0k1ZXdQRUtBckx2Vm9CemZJelhod0MrSmpEbzNIZ243c2NJU0h3?=
 =?utf-8?B?Y2VGZlI1djcwRWJLNEpOc3BRcUpPUjQveHRBS1oySTkyZUxzY0R1S3lZRXFi?=
 =?utf-8?B?TUNaSndmTWs4M0c3bElWRVNtdUVsQ3ZqNjdCL1R2U1hoOS9pZEpOMm1mcVpH?=
 =?utf-8?B?TWVkVkdmNEFFdjI4WjdzR3NCeHE1ZTJBMDFQZjJGTTk4Wlh1MVFabE5hNkcw?=
 =?utf-8?B?QnJmMFEyeXptY1laZjE2U0FnYVJJL29neDYwZ25XWlhCRS8yTzY2OG1VQS9J?=
 =?utf-8?B?MzN1US9LZTIvVWRGVkNwd3hBQ2dicWJYd3dXTXpKMmlUK2o1T1lCNGNTQUxE?=
 =?utf-8?B?VlYrd2hnWW5UdFdGNFpPTEhqbHJVRE8wZ1FkVjVrZVZBWXBHNVBiUXVTWmRY?=
 =?utf-8?B?aXdHcTN4TlBLN2svQ2E3M0pWZWJYd1dULzhIZ1dDd2lTVnZXR045N0l1NmFM?=
 =?utf-8?B?MnUwU2RwZ2FDclhXenVFS1VhWUxJanovTWtvNW91eDMwR3lpUHhGeUtGTjg2?=
 =?utf-8?B?dmxaY0lkY2lYaFZnd2Q0Z0cySjR6R1ZYbm5Sd3p0djM4VzlYUWpQb054TWZD?=
 =?utf-8?B?V2graEczRWdDdVFrVEJEN1ZDK2NuVUsvcEU2dUJ1ZHRjUUlDSUpTM2RObVRp?=
 =?utf-8?B?N3dtcXNMNFovY3YySjBYdldPUG1LN3BPaUhrdjlKRjdETTk0Snl4T2FIVzAy?=
 =?utf-8?B?ZkkyM2hzMmFQclhXVFlRTXRtdHFNazdaVGg0c0VzVjU0bzFXUkU0RmdPS0xl?=
 =?utf-8?B?L0FaLzRxZkZFYUl2b3pPY0hINkRtYU90NkVzUElUbmF2aG54dFdEN2k4aG8v?=
 =?utf-8?B?WC9tY3B0eHFHVUNYLzE0UUx1QmtCS2xLTFdYSHFPd2FwZWZIVXoxeEtLRW9s?=
 =?utf-8?B?bE1aSXVNZS9vTUJya09HR0VPY204QTlNL3RoQ3pCd2lFQzFXeU5rT1pBMkdM?=
 =?utf-8?B?SVN3djkwVkQrWFhJaVRlc2xRaTMzcXhCeERaRFB0N1hHSkxOb2ZoZFNoZTVC?=
 =?utf-8?B?dlZteVduc3Q4b2hIdURoeXBSYXdjc0xnYzdLVWFxNXBxMjFCRWFCYk9Nb1Vy?=
 =?utf-8?B?VVpYQTJ1ZS9PR0wxdVFzaGJoOGpxS3lxM094V3JpYUVkVWFaZURvVHY3THVa?=
 =?utf-8?B?TEc0T2xncEpEMStMMWxUaWxJVjUrdlEzZzN4d3RaZkEyT29sUnFOWHlkUEg3?=
 =?utf-8?B?NTEwVUJQcHYwNWtmaGVzTnJFckprcjBUaGlNTU1zWlRuV1V4amRaREVYek9I?=
 =?utf-8?B?eVB4VUExWnBIMkxzRVdhLzUyY2VxNWI2aWNITmNSUnBHOERjdndYeTJKRGRz?=
 =?utf-8?B?MFp5WG9uQTN6TU9JYTR6ZHFxWHdsczhQeTNlVUdHWmpJTm01ZUkyOWJzVTAv?=
 =?utf-8?B?WFA5Z2tlRk9vcDhscHdZTVpMRitaK1BmcVI2TTE1RjNwelE2M1FpUFFuZnh6?=
 =?utf-8?B?OUlZd3JKMkRacjU5dytWbU9qelRod3d0bnJOVVpqK3JyT3VSbXR5RmxGbzdy?=
 =?utf-8?B?L0RXUEtTSkhlWlZZbmp5SldyNnZyMmF6NkJzbWV2bDBQQ3VjeUNTWHBBQThs?=
 =?utf-8?B?YVZJRTJQTDhERUozRStUaDRwYlJHQkRoTHBoQUtaV0VIQ2NSY2U1ZUROUjl0?=
 =?utf-8?B?NXRxWTZZTS9LSlRXbFg2Q0VBcGVFSmVIeDh6NTdJTWxSSFRCWXFtQ09KRjFV?=
 =?utf-8?B?KzQ3dDhGa2pNSXF1QUQ1bG1BLy94Y2dIeXV3TEVrdkFkQmVpSHppZFEvS0RI?=
 =?utf-8?B?bVBMekVRQTRBNWVhQnVCM01NQWRvNjBtTm10alp4SUJBWHh0VXk1Y0hKWTBX?=
 =?utf-8?B?dlplSGVYYVFKQS9tOEpsdGpQb1JSUENkd3FCMjlCbTNnbW5FMi9ZYzBsNmlI?=
 =?utf-8?B?SUpzb3JuV0Y0MTdmWEJUeUxOb0UrRzFEaTl6d3R5UDY0VW9UeWhjN0wwYzZh?=
 =?utf-8?B?aVJqRGFEbUNsUk5ucmtpK1crekdSbTZ0b255ZWJyclFHTEZwWldpQVU5ZW1m?=
 =?utf-8?B?TXJDV1lEN3Rkcld2ZFJQdnZ0UE1FdXdLOE9PYmViVk8yRWN1MjRYQUhETzd4?=
 =?utf-8?B?aFljL1hoSW13TE5qbzZJSmpzSmlUaFBlOEdGSUFndGtOMmNzR2V2ZWNSTGhK?=
 =?utf-8?Q?vGwEJ+U+Bg13LQNI=3D?=
X-Exchange-RoutingPolicyChecked: HrSwFmcGomgNdFvlw/UF1bgfAmPlNJxNUh6qoTKQh+8tS/E4GuIGbFf7yhqp1IpsjQcjbOvpxHtPU4s+sKRHhCgRvWP2rkgyfKBgWAqY83+PLiDBkDtVf6S3IyQmXzQXeGUf12ojwk6HyWJKwP5RSbPlFu9633z07hElLn+I1XWK/mu2Pl2vfL4Un1Kcdq+RcCjVkkDddZWxxLpFjz4PsiZruMBmr0oJI5UsCgIE/wlDCZy2/ChjhLynOPXlTeYv3Yq/MfPQhomYpRy1zo4zY08JpKn/kuRZnBhPYaG8B2wZChQT6rUhkc6Vdo/Tnpxi+WBlFK1pHunaT1hlTvJxTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8825589a-35e9-4017-3599-08de89056fca
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:55:57.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNS5ekw0Y+APEDGVUhJ5lBBL1bEJaU8/K223ExmEmFIrg5y+rhrPqJq3R3tGyqjnK1yEdJoSHCtV42KE5Rok7euJdQHJsaKP7w0N68vfqNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
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

Hi Anurag,

On 3/17/2026 10:32 AM, Anurag Mandal wrote:
> Hash function type is not meaningful for non-empty patterns as they
> are per VSI i.e. they are set globally only &  not per pattern.
> So, for non-empty patterns, user should not specify hash function.
> ICE PMD does not adhere to these rules.
>
> This patch fixes that by implementing the following:
> - interpret "default" hash function as "currently set up"
> - store the "current" hash function globally per VSI
> - for empty patterns, overwrite the setting
> - for non-empty patterns, disallow hash function that is not "default"
> or does not match currently selected global hash function type
>
> Tested the following:
> 1. non-empty pattern with default hash function
> 2. empty pattern with simple_xor/symmetric_toeplitz hash function
> 3. non-empty pattern with simple_xor/symmetric_toeplitz hash function
> 4. empty pattern with no/default hash function
>
> Bugzilla ID: 1518
> Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V2: Addressed Vladimir Medvedkin's feedback
>   - interpret "default" hash function as "whatever is currently set up"
>   - store the "current" hash function globally somewhere (in VSI context)
>   - for empty patterns, overwrite the setting
>   - for non-empty patterns, disallow hash function that is not "default"
>     or does not match currently selected global hash function type
>
>   drivers/net/intel/ice/ice_ethdev.c |  3 +++
>   drivers/net/intel/ice/ice_ethdev.h |  1 +
>   drivers/net/intel/ice/ice_hash.c   | 20 ++++++++++++++++----
>   3 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 0d6b030536..0948a8cb23 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3741,6 +3741,7 @@ static int ice_init_rss(struct ice_pf *pf)
>   	vsi->rss_key_size = ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE +
>   			    ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE;
>   	vsi->rss_lut_size = pf->hash_lut_size;
> +	vsi->hash_function = rss_conf->algorithm;

ok, you set the hash function in this new field, but you don't change 
the HW state, hash function for this VSI is still symmetric Toeplitz

>   
>   	if (nb_q == 0) {
>   		PMD_DRV_LOG(WARNING,
> @@ -5700,6 +5701,8 @@ ice_rss_hash_update(struct rte_eth_dev *dev,
>   	if (rss_conf->rss_hf == 0)
>   		pf->rss_hf = 0;
>   
> +	vsi->hash_function = rss_conf->algorithm;
> +

Same here


>   	/* RSS hash configuration */
>   	ice_rss_hash_set(pf, rss_conf->rss_hf);
>   
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 4b3718f715..d8a01fe7fa 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -351,6 +351,7 @@ struct ice_vsi {
>   	bool offset_loaded;
>   	/* holds previous values so limitations can be enlarged to 64 bits */
>   	struct ice_vsi_get_stats_fields old_get_stats_fields;
> +	enum rte_eth_hash_function hash_function;
>   };
>   
>   enum proto_xtr_type {
> diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
> index 77829e607b..8e97a6fd42 100644
> --- a/drivers/net/intel/ice/ice_hash.c
> +++ b/drivers/net/intel/ice/ice_hash.c
> @@ -1084,6 +1084,10 @@ ice_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
>   	/* check not allowed RSS type */
>   	rss_type &= ~VALID_RSS_ATTR;
>   
> +	/* For Empty patterns */
> +	if (!allow_rss_type)
> +		return false;
> +
I'm not sure I understood this part, could you please provide a more 
verbose comment here?
>   	return ((rss_type & allow_rss_type) != rss_type);
>   }
>   
> @@ -1091,7 +1095,8 @@ static int
>   ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>   		const struct rte_flow_action actions[],
>   		uint64_t pattern_hint, struct ice_rss_meta *rss_meta,
> -		struct rte_flow_error *error)
> +		struct rte_flow_error *error,
> +		enum rte_eth_hash_function *vsi_hash_function)
>   {
>   	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
>   	enum rte_flow_action_type action_type;
> @@ -1110,8 +1115,8 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>   
>   			/* Check hash function and save it to rss_meta. */
>   			if (pattern_match_item->pattern_list !=
> -			    pattern_empty && rss->func ==
> -			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
> +			    pattern_empty && rss->func &&
> +			    rss->func != *vsi_hash_function) {
>   				return rte_flow_error_set(error, ENOTSUP,
>   					RTE_FLOW_ERROR_TYPE_ACTION, action,
>   					"Not supported flow");
> @@ -1119,6 +1124,7 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>   				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
>   				rss_meta->hash_function =
>   				RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
> +				*vsi_hash_function = rss_meta->hash_function;
>   				return 0;
>   			} else if (rss->func ==
>   				   RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
> @@ -1161,7 +1167,12 @@ ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>   					RTE_FLOW_ERROR_TYPE_ACTION,
>   					action, "RSS type not supported");
>   
> +			/* For Empty patterns*/
> +			if (cfg->hash_flds == ICE_HASH_INVALID)
> +				cfg->hash_flds = 1;
what does this "1" mean here? Hashing on Ethernet DST MAC address? Why?
>   			rss_meta->cfg = *cfg;
> +			if (rss->func)
> +				*vsi_hash_function = rss_meta->hash_function;
>   			ice_refine_hash_cfg(&rss_meta->cfg,
>   					    rss_type, pattern_hint);
>   			break;
> @@ -1193,6 +1204,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
>   	struct ice_pattern_match_item *pattern_match_item;
>   	struct ice_rss_meta *rss_meta_ptr;
>   	uint64_t phint = ICE_PHINT_NONE;
> +	struct ice_vsi *vsi = ad->pf.main_vsi;
>   
>   	if (priority >= 1)
>   		return -rte_errno;
> @@ -1230,7 +1242,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
>   
>   	/* Check rss action. */
>   	ret = ice_hash_parse_action(pattern_match_item, actions, phint,
> -				    rss_meta_ptr, error);
> +				    rss_meta_ptr, error, &vsi->hash_function);
Ok, your vsi->hash_function may be updated, how does the HW know about 
this?
>   
>   error:
>   	if (!ret && meta)

-- 
Regards,
Vladimir

