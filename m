Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA47C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 11:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6941D42798;
	Fri,  7 Feb 2025 12:17:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id ADA2B40DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 12:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738927022; x=1770463022;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pNltOePfrAIAz4Fy6n9WgYDzJ9qfRxw8f5QyPvaVtZs=;
 b=gHS2fYllpVIpKzPhHtGYEpHcQZcxxYtQFs1xv69lGRbAPGreuVQ7DhlL
 CrH9XRREvC3+d9lFH2IRVhXrdnZ/L6PHTjGqhjHOyFT0LoL2gnsxQRNka
 pu+unfAQgxtTOw2FPfefD3CY5V4PPzUU1EVxQuhrARNmpu+oFdpvcDScE
 JzBrqS5Ok5BeRyOaZWJFRBrf8qtk9ecpx14ZFCW95T7594Hd+g5ZXo5AA
 EhbCmda4Xwg0aPT0thep8D0n96cwXvRKnMCNCluImZzULpZKDFunVyeTt
 r1/1+8viTdlWa/t6M05x9HywSFBJSTRQXnMW6u4cdP69Qaiz40fLnxTw8 Q==;
X-CSE-ConnectionGUID: zDo9T/chQHiN+Lj4rRCtSg==
X-CSE-MsgGUID: fyzu53cvR9yPcF5DvUPAZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43324810"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="43324810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 03:17:00 -0800
X-CSE-ConnectionGUID: +MwvouvnSpOg18kJx7BO4g==
X-CSE-MsgGUID: xHk03PvsT/WXRfslKvauIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="112125196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 03:17:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 03:16:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 03:16:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 03:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHwJJmEkMX7erDlb+tBfFG+rC0cTq2yXMNBZgYqZlTidi+Gr5zlu4010AW/938VgJThugV3U6fuZLdrXy3iaf7y7dbaoa8FdouU6IYOUOyOvHxPLp8d9MxOeYtySUuWxhIZ79Yol3W3lWVSQitoIad2G2urfrfhNtPnoble5w/zBtmovHCEr8E0FZSQOnx3EeovUjGPB5nTYPYx0scgmmlYKBEJPTlNQGcjs92lLCXzK+qCx+/BOyEjNa3UE9prDisi1Yn0oqY1YNgtLGSPTB5/MvAatHoVQasIh6s3o2cTsINCgv6SRMfS2PkSNh3Fg4g5hYw5ShGWUrZGVGgp+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WGx106iIoXSyz/8XY134uFSioPXbRgDlav3A7+B7GA=;
 b=ItCDI/1Fs6m6J73DCz3bIJpyR6GnhpnY0vQW+9gc05rTNXncG884BjTOvbn+7L43lwlhM0+P/OBiCo8duHZemkgDDPRbnZJthav5kBTseoxGmTxHXyFVlTNks+MywDM+TwNPCmFm/JHaUSKAdT3hxe+iK5AdgCz5spaCJbdOI4hMtgdv5V9/GtTQTjfyIEfPZIPPqFkV23ZuY6ri7PH28jVMwjCw1MC/R1O/hPZvVQ9JOm35bjUtYSl6kH/R/vdmR1AO74b1ndcmJHDUp8k1PtHjWxrjtpg/Qtjp30VMd41PoFeSkbNO3ZWEXIMA+9HkfjFrcrRhI++Sb2bPSf0mGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 11:16:43 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 11:16:43 +0000
Date: Fri, 7 Feb 2025 11:16:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/24] Fixes for igc and e1000
Message-ID: <Z6XrlQcUj0vUOV0Y@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR03CA0106.eurprd03.prod.outlook.com
 (2603:10a6:10:72::47) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: b04546d4-6e64-4999-e28c-08dd4768e714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jxaqO069oAz9z8JHKZXH69zlywfvt9833XrkIda5gPk0Y951tMe6P3sxpyHM?=
 =?us-ascii?Q?WYX+fLzQ8StdFNr5gIKu85AEMTSpjcbkO7Fi8iIoIT80Mdz8KQWaM8XKWJGl?=
 =?us-ascii?Q?9v7bgqVh5h5MHrK5U35vt0IBIKTjfr8ZX2vKiAcvszbyZgYkPA4fWLvX1iA7?=
 =?us-ascii?Q?wHLH2ixy1mH5aJjl1YFmGd2pFvbihHalT4Wl5G/nbwOXoFYrknIdaIUlf33Y?=
 =?us-ascii?Q?d8PEcM+T1w14Keyf6Se6/2G/sm//HVF/hPzmOMWvz5KrJP3UtP6S5jfBBV77?=
 =?us-ascii?Q?EVUWXobSvlY1UvHuKks/0rMADZW4buVn1uOmw0xBCoMZhXmirD4udrdpDoEL?=
 =?us-ascii?Q?ErhtlGmppJYua7bsIzFOSq1A08MZ4GOfSlULjRZN5qG+0khGBv+eMaIe0sdg?=
 =?us-ascii?Q?5S9VRBhSOQvaskl6+aW8FH7liUjGf6/ZESQOOup7NfD9A0jNwyKQx1ezuYUZ?=
 =?us-ascii?Q?TTlx6UEwsV8kfEsaXXvVuHEe/Q0cY2rVM832u9o3vIf84fmTuj1ZcE24iMuJ?=
 =?us-ascii?Q?uGXZZkURfyq1KSyYLGKTVdN4FoDWDgc2CUpOFCn6Kfgv8RX/P5WgrZRjc6b1?=
 =?us-ascii?Q?0cRZGAFwtqXbsCztvATwNLnW/HdJ3F93Z1rW7WLQy8zaYS/WFr4+zJ9EtX48?=
 =?us-ascii?Q?LN4FI+MqBHTJbbepEmMbWO/M+BiNgo0gc23a7Dr00fc7/ijlt25P/cKVbc0v?=
 =?us-ascii?Q?QhHBD8HBRs6aGe41KI/jT6AIPIY5fxVMQQGmhIBbvHTiKxrJlwrXqRQTqUSs?=
 =?us-ascii?Q?3hDC22bHhiF1dHfA0Eye4z7aF1H3cp8juwJctdmPaBy/hmxhXQY6YZqkCGLN?=
 =?us-ascii?Q?1zWHDXyJJGcTqvuYn/3DAgoI3Kt02hFL4w0RLyFPXTucSWwTii+NaBg7aIBE?=
 =?us-ascii?Q?lJ1bjvc9PA2H2vCmyCoicG5MQ91IxYBedtFxGmd1h+OCGoTwzofUHkVeEcRk?=
 =?us-ascii?Q?OxMg3N2KwCGRzQr4DNLtIjBf1Sd2E4JInfTj0iAjlNPXJzoCfag6usMcyrPH?=
 =?us-ascii?Q?dWWRzeoDf14mIEMT+dpZO/cV1T5FrgIaGcbD9Ho9xVyhYpE05rTDFjuQi79w?=
 =?us-ascii?Q?+0a7qgjKaCGLtyurepGKQN77HLgivRkVBfahRIuHLI/gd/+8aCOFIjD3aH/T?=
 =?us-ascii?Q?b//eWzfrNvY12wNPpP83O7STgIXCxZGlqyazghfHzYa7XNyn12qZf+poTqkK?=
 =?us-ascii?Q?+Z1xdcM1OMqiuUmUpIKVlCTXk9y6hZKuZetgbWlp6x7q9fFLJIiv/8VyDbo7?=
 =?us-ascii?Q?ceyCQmrkpjIbYj8nl0Sw+VfBnXd/DN3F4+H34cK/ZnJNFucP7hivazAeVIc+?=
 =?us-ascii?Q?wLen2zviHrZb7bkB/cN1jHGGECUnbqAiuwTaK08MtlZiLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQgTgoomfY1RfxpW5+RJqFvUzZ82y4/CyknymEDcy2K26SAMrZzc2DoGpq6Y?=
 =?us-ascii?Q?6hP/2T4+sqXy/SGweEJ5u6rj8Rzfju/39wfp+CN6yYr9cdlrb7LH/ZwPMXpA?=
 =?us-ascii?Q?Mj/7B6iIkuUeKovIgOG5sMq6HvgyO6LEK4afPuF1tAqo9VC7dhnsdLpk9qSf?=
 =?us-ascii?Q?zaUJvioShbYvwF8DjyeMIC3XYH3sozdBdusM4BR8E1Fb7NRh8S/wh9nXjToO?=
 =?us-ascii?Q?v4JRDFgKCxyLteXJo0Q1FEsloiCuFbJN9rw8ENopYzwFOv7MMRAX88g+mBi8?=
 =?us-ascii?Q?kPESvNQIE5ZZgrTDOLMC8GsFn8QDuMwv5EgN8jV3dVSnMgqLCSp/dWxj9F+T?=
 =?us-ascii?Q?MJIOBeRC+k6i+CL5cHqO/MCSOV1529xewNCObDElwSc1bH/gXn59uJu7sM5c?=
 =?us-ascii?Q?wj3QXkhXId6+y1IeDM0OzabtaUxyiYKFKmjWbAfhMb/pxhxLt+YKqXGSGelM?=
 =?us-ascii?Q?qCys+rFcY0SFA/ObUP66r29zn4hFiuW3+1aMKfmJ42fvbh7wwsMuvHqWQFP5?=
 =?us-ascii?Q?e+pTjSHrCLx2D6vrCbafc5sliFQTuA6RYd9zHblBfxb7gCZZD40opCasjkCZ?=
 =?us-ascii?Q?a98wDegwVSNOhBye/Hs6SbIn3/Fw+pgcOaYZQvWGzvQ9MFiU4wVVDQKWA2yB?=
 =?us-ascii?Q?RPEc+lmFHf/P/4ljvr571pRm/48s2n1y01dQZEvAkQHMtGTLV4AWuf1sp9B7?=
 =?us-ascii?Q?CbgFRYb7AD/xP7PFARN900pe4Vh42zvaCJ81ut8YXYBbQPMyfMbfoYQTEUVf?=
 =?us-ascii?Q?PyUFSiaNswmNgmHIdA9ILPbUsM971kqmkRNvRI8zKaXK+NhfjcSqSS3EC1vF?=
 =?us-ascii?Q?ebnn76V44g3fgG7IbA+UduJoJe32m6yKg4cPj2Idbg7zakJgy94c+AEoJgy0?=
 =?us-ascii?Q?ZrAdtdTitkIjS5guhjD2YCOu0QZ239+7nKjNHNMQlDQLEh+zS59bLeCe49Bd?=
 =?us-ascii?Q?Y9RCHeAcnY9BjWwJafLBB9lbq2oUj4OjeW1/ulBZUgF7vi8v7Yqj9gq22sJq?=
 =?us-ascii?Q?OIwBxEvklhKvOwfD6kh99Vp/D4D2HZd4Porwt94CLQ7EAVg1e964Fp61Xl99?=
 =?us-ascii?Q?diyr0PbCDNvRPsq5wx1l2swkpvvH1/PrNnBQ+MQT55CqFpzqUqJ4Jv2Mr7N3?=
 =?us-ascii?Q?3J42K0cXJTdpWU9/jPJMpyR0mQWtdL4PIGSJ7yIRi91FHRAKD8w+Qo/nKaeV?=
 =?us-ascii?Q?E1QHHOQJcQBSfoPOAS8sbLuuoJUYsnIym5nDWBtWFbq/HDo9qupXzq/YxJwm?=
 =?us-ascii?Q?mRCBmfW84dafLgC8sygj6x+eGRconEC7vUnFH2wr2qGmMVqKkwkA4WncP8hk?=
 =?us-ascii?Q?0R3LqTWhd5udNbNq/L+N4gtj5vGzIQRY+Pbzmv9GQ8SwPFXwLeHZYtJGTYZ9?=
 =?us-ascii?Q?TW7OhzzEhPQWymQq6tdR14ONbKQKkgX407pukTQ//cgnlCz0LKEv9KtA3wOJ?=
 =?us-ascii?Q?obk/7gJe6/xdKSYBapibpQT7Y7xMp9sujO46WId+fDemz8zC14LlTz0CyXZO?=
 =?us-ascii?Q?nbD383WjYi9CtHMU+8xYUX2dS79ezRyYz+qTn9Ds7l9po/X2oWiMwYgNVxOX?=
 =?us-ascii?Q?MaULp1ijOfGNLVSF+pCRPMHv+iyYhStFDp5einhE3FmETnQTNQKbl5lxpHd2?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b04546d4-6e64-4999-e28c-08dd4768e714
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:16:43.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdpI8uiI7Gwfdvp6UkE9c2CK63ileoPuoGMHTgNaxA8MPcQQaOpxTahfbWE/ayswEs+UQ1x1c+0GkY9pJ81p3SumSaVzFBP8zcJcI2fWm3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
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

On Thu, Feb 06, 2025 at 04:08:23PM +0000, Anatoly Burakov wrote:
> This patchset is taken out of recent e1000/igc driver update [1].
> 
> [1] https://inbox.dpdk.org/dev/cover.1738681725.git.anatoly.burakov@intel.com/
> 
> Aleksandr Loktionov (2):
>   net/igc/base: fix MAC addr hash bit shift
>   net/e1000/base: fix MAC addr hash bit shift
> 
> Amir Avivi (2):
>   net/igc/base: fix iterator type
>   net/e1000/base: fix iterator type
> 
> Anatoly Burakov (1):
>   net/e1000/base: correct mPHY access logic
> 
> Barbara Skobiej (3):
>   net/igc/base: fix data type in MAC hash
>   net/e1000/base: fix data type in MAC hash
>   net/e1000/base: fix reset for 82580
> 
> Carolyn Wyborny (1):
>   net/e1000/base: skip MANC check for 82575
> 
> Dima Ruinskiy (5):
>   net/igc/base: fix deadlock in i225
>   net/igc/base: fix infinite loop
>   net/igc/base: fix typo in LTR calculation
>   net/igc/base: fix unused value
>   net/e1000/base: fix unchecked return
> 
> Jakub Buchocki (1):
>   net/e1000/base: fix uninitialized variable usage
> 
> Pawel Malinowski (2):
>   net/igc/base: fix semaphore timeout value
>   net/e1000/base: fix semaphore timeout value
> 
> Przemyslaw Ciesielski (4):
>   net/igc/base: fix bitwise op type mismatch
>   net/igc/base: fix static analysis warning
>   net/e1000/base: fix static analysis warning
>   net/e1000/base: fix static analysis warning
> 
> Sasha Neftin (3):
>   net/igc/base: increase PHY power up delay
>   net/igc/base: reset loop variable
>   net/igc/base: fix LTR for i225
> 
>  .mailmap                                      |  3 +++
>  .../net/intel/e1000/base/e1000_80003es2lan.c  |  2 +-
>  drivers/net/intel/e1000/base/e1000_82575.c    |  5 ++--
>  drivers/net/intel/e1000/base/e1000_base.c     |  3 ++-
>  drivers/net/intel/e1000/base/e1000_defines.h  |  1 +
>  drivers/net/intel/e1000/base/e1000_ich8lan.c  |  2 ++
>  drivers/net/intel/e1000/base/e1000_mac.c      | 12 +++++----
>  drivers/net/intel/e1000/base/e1000_nvm.c      |  4 +--
>  drivers/net/intel/e1000/base/e1000_phy.c      | 25 +++++++++----------
>  drivers/net/intel/e1000/base/e1000_vf.c       | 12 +++++----
>  drivers/net/intel/igc/base/igc_defines.h      |  1 +
>  drivers/net/intel/igc/base/igc_i225.c         | 24 ++++++++++++------
>  drivers/net/intel/igc/base/igc_mac.c          | 10 +++++---
>  drivers/net/intel/igc/base/igc_nvm.c          |  4 +--
>  drivers/net/intel/igc/base/igc_phy.c          |  8 +++---
>  15 files changed, 68 insertions(+), 48 deletions(-)
> 

Patches all LGTM. I see a couple of fixes have to be applied to both e1000
and igc - which is another reason why we are deduplicating and merging
those drivers - but agree with the decision to keep the fixes in separate
patches here for easier reviewing/backporting/cherry-picking.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel

Thanks,
/Bruce
