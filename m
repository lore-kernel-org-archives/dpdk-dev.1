Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6CE8536F
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4EB740296;
	Fri,  3 Apr 2026 16:33:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C91FF4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 16:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775226825; x=1806762825;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xTwBGTBmrDtmD7ll60Xsej2qLYvtI0Eg76pEohFO2tU=;
 b=EhYUOp4NuLV7ZUuceKjpn6TixYKVFelJlC516sRLUN9yFjGglCTyZ1FS
 FjElmMyJmCo+zClATB6u4vteA4k0lASvKQbYPP8I+g2CF+NzSysrmALA6
 3akRJA3OLwGOMrDsuTHVRXsIKF1e5S80HpdKcp8B557VgW+uvuLis+ew5
 PJTse6twPeIyJxKWOSbk3ylIHoreO2Zq3PtDRK8vWNZLaiGS5uZx5ZidV
 bqa2cO4jNMvgvIQ/jHHMOl7upelWudKOHTREx/IQ6NuJhp22nqzOQ36XF
 goM7nJToCd67s/0AJT1beOtRmpgBfY7EkwXJrgrNW0ZDIb2k6JC2XBUR7 w==;
X-CSE-ConnectionGUID: T91rwSXwT8yIKENBke3bMg==
X-CSE-MsgGUID: Z18SlmknQnauA723YUwQkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76407551"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76407551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 07:33:43 -0700
X-CSE-ConnectionGUID: kha7ActySGWUroOenXiiqg==
X-CSE-MsgGUID: duS8a8GXR4+64Oi9GvqzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="222423910"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 07:33:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 07:33:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 07:33:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 07:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrwHCFWgN5mNEBtYqGOuCTkeyECxbcP22IvpenhDGsQLEwRnoqw5bAXKAunQ40vcb74wVm63+zGK/wA4IaptvnsOOC9k1RN3e2xbGOdGDlzejeuIZ/R5H5b6Sa/5m3MnwnwgkdILHJLbYhEhiGyGjRv3JUj8H8VH7JnQ9/UQqYKNQZwA49dNCMdhsUVode6iCiOmqmskKknfNywWiYlBHIugL6QPiS9uXYeE0OGxvJgG3Zhkmfz94Q2Q6YwmCNmxo6EJD6EXr00fWi8EUa/DFSPCxYaT+xVExeAF/fTm2L56e720/3zN+v1uUm1pUu+lupPUMvydwu4ZuntgPL6CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAfYUs+MXSc8OHXzENmbjzBqWPpj0GG4ZsLkq5O4ZOg=;
 b=k7r59CYv61/yeuz/Mul3Kog0zlwTdkubpOT1BFvIEGk9/y07E9GMTyIJIWsEtKeakuStoXDvn6IxtcudvUSQMvDOCilCNRMHG8Aq3hWKZfaM6LZ3VsSt75CIH9qSX+Dk3+IO02iMo+CQqM5fxzM6FS7UYddKZesIK5Byi2nzEzeoDWlTbjpniPz7zIqJxJpFXHQxYMILg6SsZbvldnRnAr/5h010L4/LZD8OYbO7n8qIwa/Iqpx5Sca0DvYDX2fasCecpxjOU+4OXlSs2r5EiqINobyEjc2tiNwErIJTUj0VR82Wh2HfkQIBkRqg6cecu7Qca/S/LViPeq6snDcmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 14:33:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 14:33:40 +0000
Date: Fri, 3 Apr 2026 15:33:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <nd@arm.com>
Subject: Re: [PATCH v2] net/ice: add NEON-optimised Rx/Tx vector paths
Message-ID: <ac_Pv0hhrBFlY5oy@bricha3-mobl1.ger.corp.intel.com>
References: <20260323183231.3988257-2-jay.wang2@arm.com>
 <20260324162525.4083381-1-jay.wang2@arm.com>
 <20260324162525.4083381-3-jay.wang2@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324162525.4083381-3-jay.wang2@arm.com>
X-ClientProxiedBy: DUZPR01CA0287.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: ce98f152-7ed3-4f63-e236-08de918dffce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: l1zn0M4NYTb7+MXovYg1P42xBMKLztC4XlGrxyQxa6Lx69amay8h9rTXAAmw4ZI1tOY5gbrh4o/QBFQOqIVKey2Kf52J4ZZ1hSVoBTv1Dw07Qduo6l6nMrS4nAkAGgaVKkXJm/8bSXLIbL0ygswXZ9m6Vc7U66t6lO2Ya42eHSjHuPjLysYkiAxj3Qz2iXXPYT+4Afj8CuIyI+tfPl0N4P8jPRomvTa29lN5+yAQoPr3i6nfaZAbWyLcaoX3GI1UFcUWY6jcZp7EVT/ARoiphkWpuZIJd68695RRV9cfJ/coNuhEiBWiMvyzrHaGNgMRgPP48WNr9Jawf+xzWW1S9GxMA4T2lq5B2DSdG4tBv8Oh8KvBRAN6iPzqWkK6F+LqLOiP6OGbTR6UmzFbfO1lDLlj7QrzP17UfhcQBw+WuWmE7ZomLaUcMsUuaN8e1/V6tFxoX6dP5h1zADBVVwZSOVhaOW8LcDZJDK1VTcNDHL3S58t9AsUNioHDBgDZD8j7CRBCio7JH3jems0IVSfSq/hDon01r2TlUCN9x6DdLI2KEEoAroiODJRysnDxkjOlyKo5cGcb+6YJpfYxicEWPThvZtZK3if6Azr4oHTKDAsluEGug4GG4P2VYkWhfq3vgRLwNQemgct1MqiZyOk8S/sqo6QvAXfx6+i+1EMaIpO4iTo3d4V1HsGe1xnWsiprpcggEoPkM+Htm0Vak18EGWOJfQ6A6i5vSpJTrPtWHXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+ZXWRc0m7MOrZ7ufiZd/BDEF/s++oNBl0Zlv6xYgQ2mgmz+QYLjI8xyWvxp?=
 =?us-ascii?Q?v6R/EEvIW9ZSAaxGe1mVWEFRJFKf+JspyPCK2O8L2bHCMVBv7Bx2I4zbiAhV?=
 =?us-ascii?Q?oG/UhLMdrm7qfLLjZBOajC9mHGFdD5i82j+uy2hWUMntoqE/qRFCsxOoTsqc?=
 =?us-ascii?Q?WYwcyaFCJZB+eMdrg5YOtKFfnpBM4U7Q6Lg6BQw4SLJWmR/PGFYFbeEKXR1r?=
 =?us-ascii?Q?O9aFIAzDrimdpZzZJQoyn+s/2lsFe5CneebsQCKzkBqq1h7GXV3maf55wh9f?=
 =?us-ascii?Q?xfXKelaiEQEYOMnEz0+l4EHgfYu1xGnn+sf0AhK7cJlLNWIaR91MQBQo3yH/?=
 =?us-ascii?Q?BMxNeW5I0uO616/jMA+4P+3esn5lW3r7s/OuRcbW35bXK9Ao8K1OqFRi/Hby?=
 =?us-ascii?Q?cj4oaRe0BNwD/nLUx4iCIWjnR5LBcX6sejDu1A1Aw6e2xzUlQbnsSghgljpv?=
 =?us-ascii?Q?+WeCsr8o3+XYi2z6rjMHE90cObkgMyjRvvViJ0bmg6dhlWJh854DdMXNIkfi?=
 =?us-ascii?Q?HGv74qiMcV9DEw33K0G+hAsfq2hT84pN1g3vraC3Qvo8isWo4pPEKa8fIubH?=
 =?us-ascii?Q?mzrz5bbAGnMYx1Ma8bShuS7GsJH3v8mZT1icVO8nWsW95DWEPc257s1tSulZ?=
 =?us-ascii?Q?I5PvLr5kEZXUexP4popPW168swZB/4X1T8OhKAWFcsf+kc/h4K/tS/74Z55n?=
 =?us-ascii?Q?QD4TEEb2PlmIPr3gBUmHB8oS3n6QwawllFdZaL7+nQTDLOyuNuXBo0Bnk1rO?=
 =?us-ascii?Q?L524XfBn4z/TdI5jCEHyTSEHBEC8qsC3ClIt7PW/XdCSk3IlGqFbLGoKbIVT?=
 =?us-ascii?Q?SVVVtYaIPUd/UrvAdGx6lCOQJwa+9VFfUhACa0DbN9Y4DzRlmJjWbklMcINl?=
 =?us-ascii?Q?XsLjCrbg2aHCI9ik/ovaosvfGW8YbMrxGMQrPiwOCxilz40Xkd4iKp5hgph6?=
 =?us-ascii?Q?WdW/XtsJWEbvbTEMzKYzpN+XMsJHA+5rP86uKml/O/+LsGsHQs+08HqQGsrG?=
 =?us-ascii?Q?iwXqeXD7yutq0GShDL8JaMDjCjVUjks8UM+M3k5u1v/x6ggutkA2pu52Bd2U?=
 =?us-ascii?Q?0YlJhrOd0eoqxDJaJbqwPLBHZmZC5Tz+EFC0ahfcCJsb+PyQvwAtOGgxr9yo?=
 =?us-ascii?Q?pOJAu/IAEXJMapXRzSyNas1f5Xb5seka5QjDUQkdC0gjBiNITtK2+zEYgHZk?=
 =?us-ascii?Q?JLSYOVsFKtNt3ipT9YKgdMFBDS1v+FCwxadnZKEOy0/09XMpyZx9zGtadJlm?=
 =?us-ascii?Q?NInpQ/AbWgIwR0sWoUD+FBz6bDpzQySSDKdlmnNlLG0J0LkGd1Gydj+8ICLm?=
 =?us-ascii?Q?EZhkOt1zPIQpHij4L7YFelctyGKTTzQDzo0N2TJ/e3eva9qkibHX72jWaM07?=
 =?us-ascii?Q?r77V56wwkkflWTiFGj/mVV7I+fMO1OK99fc7uXbQxoOGyyTCqYb25M3mQ9/r?=
 =?us-ascii?Q?/LRbz7+nyZyguT/sQIhg6bINEgC1Q2HN32XfsPegDVoYOmBJOx0CIoJrRhYc?=
 =?us-ascii?Q?mKxEuwc2ViLVzr9R+u0H469qH9GogX2q4DqsOiPm3JowKMn3P4FGHxUA8Tq9?=
 =?us-ascii?Q?CQddLjwu41Qey3d/RpOdiqL8KHafvg7+zqVw/bLCYf51LTsscfE4H7gLo8bo?=
 =?us-ascii?Q?luFvS/kLZ8b7ZfOVgrqye08qmdhCPqi/hynZUR4EIysZmH78W4/LMOj1+Cs0?=
 =?us-ascii?Q?d05wiSPi+gb1G93Wz3fnll/sbt2iztNna+3pfBsPttKPVs2hFqVfVJzYRG0Q?=
 =?us-ascii?Q?Z8/lTQf02n3E9Uq8atjC2wk6PPqLklU=3D?=
X-Exchange-RoutingPolicyChecked: FkgvtlOmEu2XDR2tm8x0t841izvCSKvNZ0IC1r3PqvemCewiYdqk1IIfrgnIO2AtYKw2dfsjkWLzFJ1K3eKyJM44oc9veNy1YvdbZ0EVPhmW2XKYJFlOj0T85xmafbtdxoSu0bUhh3sYGx9tdKRaXfKbTCaetkNiUyu6OzYDHw0pumRsk/Kd0uGLy07AIla/VP6rhDQcarKSd2MH//G28cRDwbSn0TjH5xNUCXxUWTKR627awGu07rq8BlHW3nxZGf3JyK5yfRo1mwoyMJk/RxsNS9cPDFuXdOokrxwNj0VFUaMF2BoDir6zalDBW5YE+bFKtaROasGjiVBdoVtj/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce98f152-7ed3-4f63-e236-08de918dffce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:33:40.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKf+kBbgwNohM17H4Ohb5Yq83g6oPSQK5hxj8wyfa7EsyOMIcB2VkqDTWKGTX77gh/5ahYrc/Lioi8lO2pgxR558AFT2XvD/ZHIXH0YHV2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
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

On Tue, Mar 24, 2026 at 04:25:24PM +0000, Jay Wang wrote:
> This patch adds the NEON-optimised Rx and Tx paths to the ice driver.
> 
> Tested on Ampere One platform with Intel E810-C NIC and 100G connection.
> Tested with a single core and testpmd io forwarding mode. Observed
> ~30% performance boost in the above test compared to the default scalar
> path.
> 
> Signed-off-by: Jay Wang <jay.wang2@arm.com>
> ---
>  .mailmap                                  |   1 +
>  drivers/net/intel/ice/ice_ethdev.h        |   3 +
>  drivers/net/intel/ice/ice_rxtx.c          |  53 +-
>  drivers/net/intel/ice/ice_rxtx.h          |   6 +
>  drivers/net/intel/ice/ice_rxtx_vec_neon.c | 761 ++++++++++++++++++++++
>  drivers/net/intel/ice/meson.build         |   2 +
>  6 files changed, 824 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
