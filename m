Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C497C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49409402AC;
	Thu, 13 Aug 2026 16:36:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 941D940298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786631782; x=1818167782;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=H97cQZMXS66A40rLKKJREj6AYkP7usqwB4MY4IUgfVo=;
 b=A162ceV2dMhqm5sGAsqOJ45yBHCBY3pMeTBWmkZHDTBx1b3grNC2+xpZ
 F7Nq4hkZemDKK4go9yQjFXtgGMIGPn+mmzS/luX25stX0w+4liBcvhdOM
 34s4uSE1WzfhfURq9Slq+uYsd9RLcSyVE8a1i5N39R3COpVWP++bTUo/l
 6Pi2Kbbfqb08Z7IRRSDfjaXjRVktFslIzmVqP6H/hfUUWxDWlmO7OIXZX
 R+mi8iwS9z+oGaIDBT1JpeIOd90l/LB5cAq/UCZLZ7G8apNxzqi7aWfFk
 s0oSzh6qhyhGUcgSBrGCksouRnlH3gK0pBLxC08mdi8e2dhGz0VXIzYKL g==;
X-CSE-ConnectionGUID: rCH6OrNsTEihLMan12ZBDA==
X-CSE-MsgGUID: YnfIf4/dQAypzf/Lhi7VQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87423275"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87423275"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:36:04 -0700
X-CSE-ConnectionGUID: n08hgUZkSRKlPNcksk9rtw==
X-CSE-MsgGUID: VG91i33FR5KrxdNpeU17SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="265939416"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:36:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:36:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 07:36:03 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk2Ja93ATucVL86r2ZngRBl3Y04Wi+JdeLSxuD0JPfVVq6XHBwaWt+39fyInf4KN8uyI1NeCZjOEM+SmE62qx0MxQwhbZGFwU2E597NerENsraS+YwfDFtY2XR5hCKZkGEr9tgsm/9cpDz3n32uvlCXOcBUrRvF5ydw9yjuZ86+eAg46+8+a6ZUkk3K3x4QKs8ulXN1GxWk3Cn6/4HUuVEe8v8Dnyhn9W+X6ejbHy/CwhBMH+dvmFnlBbs8C8ArFRDHEojB5292fSKziEJADNnKKkYRe/1fwaKPzXKz0N9wUr8pjkQEtTlxwotK3PnJ4uoc+KEP9YcUdO/+Qnik8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ned2UC0yTliW9xgEV8RhRrmLDRfRP5IagMc61Nvx9D0=;
 b=M4nAvdUxHHkd0LUMe15sft9GxTzMeOs1gb6i0RlwglmKCIwdaeqcDWJEomLnFNIkrx6qN7t1ZtwM/A8M5frTaQ7Xm+GAgUU1ovlxwgd7HaEuJSKYGr2yhvXWb0OpeeW5dynvZTpBShqWzV5mePPVynZemP9k2CUlmj6ronYKAKb+268XlBXySK/G2PC7oO0aIyrEAvT1/dWGh0hB5kKEiOtzP7oZp3yP8Y1P9UUGZ9FWzTMcISeF7Wen5f6H9jhKDwMUn89xE69ZIqEOuUgeC6f/JV3QHQKWY/B0+fZYpNHxOGjRovhUXbNs53HS2T+3jmOvKM9IuWwyD2f4w6mHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 14:36:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:36:01 +0000
Date: Thu, 13 Aug 2026 15:35:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/iavf: remove auto reconfig devarg
Message-ID: <an3WTdgw1L8Cj8_S@bricha3-mobl1.ger.corp.intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
 <20260805125735.3900483-1-ciara.loftus@intel.com>
 <20260805125735.3900483-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260805125735.3900483-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d0dbe0-5ca3-4557-f60a-08def9483264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CAvV1GuH6cQrr78k2iQUQJjXzNr2gjCnbIx8VUisGcB53rw9PGog61rJQQs8v7iHgFHPnqenSD9KmPZgEul4dB647g64jFXT9RiI657lP5/uNeXmJy/Y3l5qjZblYtK20T1iFMcbrg7n9hKkKAlwsxLu2yaMTCgytcp8O5/2KY0DREl9Xgxenq13PkJuPtw421UhA0/1qsuyWvAQlthyXGEDc5+i3m0pPXSK5k3Dt6CpaxMoCVIvYedX1ScarYYRxzlF9jRfo8Y/5FEo+P3SOIIXoK1fBP5xo3ujnEQwPq3DurqAnBRUdOBeFN1Ea8pB28jpjTYtpYaMu8Q0zy3faVYYtvjmZeBRwuKpiIXJWODwKkkNkW32cMnjclnGdtzMj59xvrzsYoKQurE0iYrkXSW2JKKiKOqHbR25OXpOaB7glV8ra8Hua1/Yi2kGilyn9WJ2AKoI99m0Am1w4F7YRiED26zev/oZeFpELY8dez2JwSuWqA4jPmZ3Xq104wyb+8USB9JjN3d8OPjONLEJeV0DxutYdPVJ1lE0Ij99YBBu6uGvqBlJIPXubxpfOtyR/AhkcOD1KOQbsbuCGzbOCZDUFeQT/kJKVt/wFAQdnXObVvDpJoxWUzdntiz2H1TAKxgLQ8onjlwaSZrOTQNqRWi4qojpsIq0CCJGbrWgKCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/trsXjP+iAgcbuc6LhTrZEAte17eQ4GLVbc9We9APu3gTypwLKBTIG2+qPCp?=
 =?us-ascii?Q?xu8tvfhLJm8jalaclBBbV1ConbreVm5WFhFNCoBbs+r0LLXXT8mhaBONiIYy?=
 =?us-ascii?Q?F9IniUVV9kiRWNoqo7I3PpPTtZW0ZjkZMo1YtHVBCikyEoZ0YJrEUGcDs5/L?=
 =?us-ascii?Q?t6g7D3n8ysX5IEK6owUOCGklwtKdf54StnhJ7ukRNEXo1E5dLiw2qjzKk1dF?=
 =?us-ascii?Q?KgNIT48WuRUICNv/wOJW+izDNnpkaHBjDRSlCaKBgx7HHIQIKwDRTW81N2PE?=
 =?us-ascii?Q?9B6PLAhR/uOhJeX5MZVOYNLfA9m4bX+QPNMfRoxpcstNceRfYgDxfZjsMgSV?=
 =?us-ascii?Q?8rloP7QFLKwluzer9GhmewtucnOTePeeyPGWRUOiZgEDgt0R9rUVc6xw+X/8?=
 =?us-ascii?Q?vQWYtnesiRd9avAF+s9bglmpzw0xbx3pCKDm1mLCW/I2aY0g9ZGstRiP2WU9?=
 =?us-ascii?Q?qcM9iIrTNX7rJx6zhaDUTYZWZrekxY8h9sJfQtNCCQUVBQ3h063IE1Ka0idZ?=
 =?us-ascii?Q?RniCgcvqMxWtVnPHAKKCtwgtxRpg9gxkomMupCOZl/ystG7AY2SKrLt0bgG3?=
 =?us-ascii?Q?5qnuErQRCAcbCIoseVHKsEKQegGeP4iMBMUioMPfAeuWgmenNsLqMp9yx1i8?=
 =?us-ascii?Q?EwBhhY7LIEYB5KJYeUENwAIB+uczn1YHojkoZxXEMwEGg0hZsN2q0MK5dp/V?=
 =?us-ascii?Q?9+XbgRex+nToU6hQD6dzBJmt8Z58CGe238diS39YKqcA8tKGj9SbZgDL8l62?=
 =?us-ascii?Q?QJAZS+CTKYyBsd7GlDjX41dS5fdcYiQi7olhHbO/JZAcxlMm9VD4KCMu7xYc?=
 =?us-ascii?Q?z9vVdaWP7JspSUdypkEWy0uvf8mPCqwvGYn5VQbCT8NNPBfqjdw8hSl1KI9b?=
 =?us-ascii?Q?u2XcQ02c8FqeRomwvFdx+o/R6Vc8gE8WRBJovdi3kojqCvYRFfqjo9zfHE9p?=
 =?us-ascii?Q?ahKKEfzgG5IPp0aXtEeJ70DyT9LH29UWvsWoyq3ZvECIJ9KSPzY8/1E5noKM?=
 =?us-ascii?Q?GD1/txXKzmZ1w6gTcFd7loPB3HMrj6tXa5edoKN/YDhWvijwKyzKQvxk9CGA?=
 =?us-ascii?Q?OuDVZz9ucR71NNodYO65/vs3PS/DWZOjwcVP7qshKLTp4EFny0p5Wo9qDclV?=
 =?us-ascii?Q?LOS6UPcfxoSoc/HQG+sauu01qg0u+TAULpuAy2/MHpbIAfJmY+Fl4kLI80Ud?=
 =?us-ascii?Q?P3qYJCGoE0A+5qOn/Ytxh9UG10x0mEENrTPvU/KSbC90lRTK7bcx8pqiCMY3?=
 =?us-ascii?Q?1hPf/5Y2gzZp2jt5BBk5461pkRsVIpSIYZIdZklZ/eTR1UcDViD04kUfpkX7?=
 =?us-ascii?Q?3jfges3qULipZrkz0olgO1fo2fMYs3KnagEBFzl+LkpUq/eb+yrD85Yei6Ft?=
 =?us-ascii?Q?UGrCX+MjSo5vlPecfu/HnBJtXIwoS7+xhpzRUd2f1sXTGBc+amhCbz4FhK5l?=
 =?us-ascii?Q?sNeu0MxAEw6GCz/H/gAaFjLfewUUdUytTgox5ttWrm1sWumaxGBTcmhWMA65?=
 =?us-ascii?Q?zVEuHQkGRg9bTFMc4mHodIeeyL7CyhFYoSw/xKzjnuY8DM2kFMPOhJVTZ1Cc?=
 =?us-ascii?Q?WMi475S1p2bLfCVGqTqmpSjoX5hy5Qoo+4kcOtanyxT0Af6eCKVuq5J62Fxl?=
 =?us-ascii?Q?LJVo8R5PAWFWx9JO7EtjOz4IhOTdOIjPIUStldS3kPtDeen1iOjpJ7NoWrR8?=
 =?us-ascii?Q?qrqeRSJDCK7j4FIsgXzUs51xzRB5aDZqut4d9qnawlScFI0oocg2ovdVqe+3?=
 =?us-ascii?Q?cVG/TEPy7w38aeAC7Z4oUkqOgYw1TMA=3D?=
X-Exchange-RoutingPolicyChecked: R6q0dJg/4ttxyUJEHrh+ba0Gty4nNRdOSh0/KXsWBenU5xkHr/5nxO6+pQhGx/7+o7GsaGL+Y1t8+Uf+ByAZFQ8TM29c8Txd4w+Feevqm9lED9CW+iGKTk/vUDh29S2k3MGOeJx/l9Ln7QkV0EI/7PAs8NIpOrJhpoGNoUEJBxEgF8sNFIXN76lXVD5asaRfwJkgahtIWcsOz7J5i2sPrHVj06PKdEd708TDsvty6w3a2IXFh50A0IbtVP4aIbPP5Oe10hRhunmrFDcPrpvJmpJT9/690RmoQem4WXPNppgzs38pYv4W2nvq+vhw9OIrgVrkZfXsfpAPaVc9Fx5xgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d0dbe0-5ca3-4557-f60a-08def9483264
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:36:01.2750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwPjP8kL8zTdnVkEVq1tCSyEJAwbu+KzvRK8p63HaYkGDLCxLrzbQrWdaoCD7YeNn+Zi+tqcQDncX9kp5n3J8W3voIw5Cz5vjRLJhp22OmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
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

On Wed, Aug 05, 2026 at 12:57:34PM +0000, Ciara Loftus wrote:
> The `auto_reconfig` devarg controlled whether the promiscuous and
> all-multicast states were restored after a VF reset. Remove it and always
> restore those states after a reset, for two reasons.
> 
> First, a VF almost always wants those states restored after a reset. For
> the rare cases where a different post-reset state is wanted, a post-reset
> callback can be registered and used to adjust the state once the
> reset completes.
> 
> Second, the devarg was inconsistent: it only affected promiscuous and
> all-multicast, while MAC addresses, the multicast address list, VLAN
> configuration and RSS were restored regardless of its value. The "reconfig"
> name was also ambiguous, potentially suggesting it governed all settings
> when it did not.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
