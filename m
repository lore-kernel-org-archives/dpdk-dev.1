Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BCC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 10:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFA91402DF;
	Wed, 26 Mar 2025 11:37:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 22394402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 11:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742985460; x=1774521460;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9Wvvx652fxVdATwaxfq1p/cm+h+jWpGQrCanPdAeeEQ=;
 b=VhXMNL/XyKm6GTZT6eEdhxzBn/ccMnw9Yajn+N0pFr4sdV4gKzxaaqHR
 uT+Ywn+6L6VIWXv4rmclp7yOD64pm8cKZBBdapB4jChIdUhD7Nbw47AJ+
 y5LgAxz7AS3BoLsoWGudwygiXT2PwAlICgdOyeJJPu4xiG161UBFwMvAZ
 6Ou+h099XBHnE79goftcDIEEgsXdCOSr5NPcF+qDdKfnnu0xj4bVRt8++
 g999UlwJVPJWhAPuHeiHKRM0fSeiFurBLynnW1oEJliRSJgMKyM3NwdHe
 LH4tg2zlXpbgF1my+hJNEtkekos2vTakamfD9yZcoAtXTYksU3/LK4c5d A==;
X-CSE-ConnectionGUID: m0Vxh6z2T2Gzdl64G6dxSw==
X-CSE-MsgGUID: HRVCEODrQpG3rK2uQPCTng==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44144737"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="44144737"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 03:37:34 -0700
X-CSE-ConnectionGUID: VUr9Ik5jQNqaP5Y1fZiNxA==
X-CSE-MsgGUID: l4CuMiA4R+e4IrRbnYUY5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="161923922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 03:37:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 03:37:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 03:37:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 03:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGqUOUEBIUmS13GC4iAfTO5kTHDG+Gb5RVRsiWy62+nl1DV4q76NPawtGx6Wg9kynx0ClZtSF2EGMrClPz+fIY5CoYYUJzXWEmG9jgsgFEkxkzFo5ska2Ee7yRaDq8qkmE7z3sbesQM+fWp0i/2DqJtRwBTSmaFdl/cRt7VnYAIrepO9L3tp6T8fYgHrf11SVT6REI1KRfEJmjo2EsDnkyw/qQMBc9bAo/YCjoCJ0Tixw9cPr4O0wCZFe4zYz2Ekfl9vlIwiX3UqH/33Za2SC644ORgNx4KppMSIMErS6io1qo170mksXuMbxgvU2Tv1QXmR95oShF3f/9VEcAmx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctyIv/6iznrskFYKKwuwrFq4iPADxOr5+td69LewpTo=;
 b=IMMD/ekpN0CVG+r8ai7iSX5P8veAW+mxHNJLKLU3Er1Re5sFkRYWj3kSKs54n3jfj/T7007i3p4uDgHPhn3kW2H6kJ8lcUwnBKma2C4FxXYZMFvMM4fjbTdPU7HLhsP1uiUyd8g9qPJaURwPopW5nQnOR3vqhdvVQS6i0xAEHWmLewD6jmuGkisBl5K56CCUEnl/qPovV2WSRjesaxjiCARQBFtw6ol7J3dsdnCw+xsb3EkdEp0vzMXxmjXXo0v9THEXrcdNV2tww23t3yZWJG9vXFgogIh5DUzf/87H4bCKrdrvIjfZQxbMS9SxTdvy3fGtHJtm79fVqbiGHrzIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:37:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 10:37:16 +0000
Date: Wed, 26 Mar 2025 10:37:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] version: 25.07-rc0
Message-ID: <Z-PY13RS1eeZHCKd@bricha3-mobl1.ger.corp.intel.com>
References: <20250326090003.858426-1-david.marchand@redhat.com>
 <Z-PEn4gSkJyCEbUs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yY10dBOHf-fT3gK39RqDDZJfx8u5BWpsVthEuz3Gr+GA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yY10dBOHf-fT3gK39RqDDZJfx8u5BWpsVthEuz3Gr+GA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0343.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2495a817-f70a-4d56-218b-08dd6c522d66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXVKa1BCUkNZV3BDemdWYzdvb2xwYXpHWlZ2THJPYVR5SGxSdnhyNS9wV2xO?=
 =?utf-8?B?ZVBENkR5R1FPa3pnM3JTN3Yrc2tYUlREY2ZSc3RWTmZYN080QzdzRVlDNGll?=
 =?utf-8?B?NTdlblZFZHZKU3BETmZIMW1jaWEwTGRxZy84UEVFMm1TdWdGWWVIZW1tNlpp?=
 =?utf-8?B?dHlkTUNHQlZkdjVtSGNwQ1o0MVFjSXR3L1BTYzd3RjhkZDQ3NGlEY1JRWCtO?=
 =?utf-8?B?bkdvMFprZVk1cGt0L0t2aklDc0lSTlpQRTk2Q2VxRDlxVDVjN1lXMzNCQWp4?=
 =?utf-8?B?Yk1XQXc2TU9IbThEMG8yNTVTRkh0N0ZMYzd4KzhMNjduL09BakNYaHh4SjRW?=
 =?utf-8?B?V2dqbjZYWDZnOERCS2srTkVac2tCam4wRXR0TEFIVXFKWGt5Rk5MdnpkRVdl?=
 =?utf-8?B?U3F1T3hDclMrVzR5dXh0VmFmVEVRcG0rWUVzbTFwVU9SNFNCN1dTeExmM2dL?=
 =?utf-8?B?QkdFRU1HWU1Qa2w5dUlobzliVlN6c1N0MU5mTlNIcmZQR2pmY0xZdjhmdnV2?=
 =?utf-8?B?L1I3N3pmMUwrWGR2bUxVT3pGSVdaTG1XSzZBYnpibzhveVJqL01uWmE4a3A4?=
 =?utf-8?B?bHBTQndDRFkzSkRLaVJJWXdlSFFtQkM0RlZDdTJiSmFJcU94REZwR3JHU3BQ?=
 =?utf-8?B?b1UrL1N0OXJOVDRmNUZwQVowVWFBZ09FdkZiL2hKUkRteGZKVUN4T2FsaWtW?=
 =?utf-8?B?V2pBRmNHS2pPd1ZEYmtMdmRqaXdaTXR2Zmw3WkZhbHR5cHhRbTMyVmxmelJv?=
 =?utf-8?B?NGxvVHlvU2dCNXdQdnhzV2YwT2I0YmdkS01LUmxKdjZrSGRuak9ZRSszOFZt?=
 =?utf-8?B?UlhCWFVnYWtXb0pYUDh5NHNlb09lZ241Z0ZhUDJ6Q0JzRDNObnZvRjZyeEVi?=
 =?utf-8?B?dmlVK2daOTY5Rmh6Z1hUOGI3MldsdmNKellpRmlQUlVtWmZUdHhHMnNxOTNo?=
 =?utf-8?B?ZmJOaVcxem0xWEFxNGU1eG1VOHpOTlo3NTdoNCs2dmdxemY1NmhpbE9JOUEx?=
 =?utf-8?B?UGZGdkpMMXZaUkMyRU5OSW1XS2ZPUmI1Z0g5K0M2Z0gyVG9zcXlMMWEvZGxP?=
 =?utf-8?B?c3cxb2J0Z2RpOFg1RFkrODVuR0tJdDg4UXpqdVJGeDhRaHNkUWlTaTk0cjhj?=
 =?utf-8?B?YUlMYTJPUmJPZDlVbzhtSDhCRndQTU40bVNTRmYyK2NCeW1iR0RXNmdrdXow?=
 =?utf-8?B?N3pzYmtCaWRYQ1J4dHJxaGkwNDVFamlyeU9IamRnQzBrMmtHRTJsS3pIZUo1?=
 =?utf-8?B?NnJiK2FDaVFzcVh0LzZOYkVQZlRVYnNsMGJ5RmpCRC9QaWcvQytYb1dMbnpM?=
 =?utf-8?B?UUluckNLWkNxMzU3WVdESEVTU2c1WklBUDNEZHZoMFVKL21FdCt6Q3UzVnVu?=
 =?utf-8?B?c21Eb0NUTWdzeko5SUpuRFY5OFl4dWxhRmNBM3Bna0JsbXMxbVhlc3kzYVQ1?=
 =?utf-8?B?aVpuTENiSm13clhDckRZNmpqV1FEcllSck9QaHlQVC9CTjNGK3JNazFqQkdU?=
 =?utf-8?B?VFlueHIxT0dGV1ZBWXZnSldReUtGbmIvYWVNNHBnSE5GanNuQmQxd0pOQXVs?=
 =?utf-8?B?SWVUNUhLdGMyMVdUa0xSMXBPdlhBb2pRU3JzNjdBNXUxVkFyRnM1bmVacSty?=
 =?utf-8?B?bzIzWERTQUhuS2hmcXBMQmJGVkt6bnZOMHFWUlJhTlNsb0liSTRqYU5VZzVB?=
 =?utf-8?B?S2p3YjFScEMvUDczakFzK0lZeUcxYXdqY1RNT3JaUG9yTW1WMXhjclI3bnUr?=
 =?utf-8?B?Ynp5WFo1Z1pXYlUzUHV2ZUpwRTN5UU56N3VhWldEdHJhcFpzWGFzNGk2UDFn?=
 =?utf-8?B?TXUxS3R4MHNQVUlNMkhxUWFDVHdxNmZLbTdrNWdqcko3QXdDb0t6YXBZc09Q?=
 =?utf-8?Q?Czv6KyGyZlxMQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkswczZucVJQRklESFJZTGdScElnMXkzTVJYdTdWaE9FOUlsYVBQL3kvM1B6?=
 =?utf-8?B?akxTWGhUNCtsVWptKy8rZWQ0QlBLZGxpQ2lwWDZpcXNBN1VNRXVWNkcyaUJL?=
 =?utf-8?B?K3YxWWNFZlFZM3kzNmF3cXMrVDQzRFNsRTZ5MGFoZDh6dzlOTDVTNG5mR0FV?=
 =?utf-8?B?Q3k4M1Q2elFUU05Ubi9hUTd1SEZMazJYSUFOTmVPWGsvV1pzNWp4SUhvUkRL?=
 =?utf-8?B?a0xRbWZYOUdUV0RTUUtZaHg0M09iR2xpbTJzeXprRGNvRDM5OUtRdXV4U1NT?=
 =?utf-8?B?clcyTTc3ejZ0UldiOHl1OWFjRHNYcjZXYzBOeXkvTEVwYlN5MWs0YUNJbVIw?=
 =?utf-8?B?SGgxaEVvVFpzS005SXZ4UWpnRTVSanRwTjRvY2hobFErZDlTbVhFNnNMNjhN?=
 =?utf-8?B?L1V0V2VHWTB5aWpUTGM1RlU4alUyVXo3SmFxeVI5ZHdBMVNOcGhyUHBpOXJn?=
 =?utf-8?B?a1E4UmlPaSszdHVYaUh6akZyV1BYVFV6aXd1MW9hZ2tFVURhTHgzeXlkcjVS?=
 =?utf-8?B?cEsrYkNLNWpHOEd3NDBjbzRWSUdWS0VYUUQ1aThnK1JSTHJjRG1MRmR6WnJY?=
 =?utf-8?B?UUs0Q0dveE1tWGFrakxXTlNrL0xuWDF2MzRSbjBMdkJQdGlXYkQ0TWJXMzlw?=
 =?utf-8?B?YnBtTm11VjFjUmRPZ1ZoaytlME9mYk1LY2RQRUNGS0FaeGtuVTNwYUZFZTFP?=
 =?utf-8?B?ZlRwU3F0WmZCY2U2MjNjVlhycElnUFJpdDFZaGp6K05vQmt4N2l5eXppVFhz?=
 =?utf-8?B?Q0l5SUNKenZ4VGNvNmpaVlBDQUJkN2FjSkdXZDlWSWlLS1NTQzUvRWV5Y3dv?=
 =?utf-8?B?UE1CYUJ2QnkvQURuZjdZWFY3cFMxWWVuNW9OUlJLT1Z3YzlQL1EvaTVHdm1l?=
 =?utf-8?B?MnZHSHk5aXRsSzVxLzQrdnE5RlZWbnlWSkE1dnRqaEFFUHFBeTQzQU4xaHNw?=
 =?utf-8?B?eGJ5Y1NqNDB2S3NQNmJWSlMrVXVwNlRuOUczd3RmTkJpd090OHIyQm5vK0RC?=
 =?utf-8?B?dzdqTWsrbDFETEc3MlVwUEJnK3RZWlE2YXZWT0xiUkhtYVZtcDd3VW9nWkpi?=
 =?utf-8?B?OWYrSkZZYTdPWU0zelUzWDhVcUlqV1QxYnpuVHRISnA4VlBsSmQ0a25KSkEx?=
 =?utf-8?B?ZkJ4Z3Q0TWczRUlMME42MHlZeFc1OHVXbjRNaU9nNEsraXhpVUoxbllXSzIz?=
 =?utf-8?B?NjJvdGVLSmFlSlhxWElGYkJ3emdFZE5QaU85Qm55M2NSNGpPd3lVV3hVeHd2?=
 =?utf-8?B?ZGFkeGcvTGN3bEJEeDJxTjFFUllOcDBQaVZEL2llUzl3V1djenNQLzZobjRq?=
 =?utf-8?B?bThTZlRJQThLUXFhNG5pMExXVnUwR25wNDVucmRRanZYTllrZXZER0JJMXJP?=
 =?utf-8?B?RktJS0VFdHh4eGg1M0pjanJGOHlKMzl2Tm9scWsxcFM4anVlVWF2V2dvZEVj?=
 =?utf-8?B?RHhJREpERVNLSy9KYTdncEdHOUpKRDRUNDFFdjlaRWtXSXU1KzdUZmMwYlRU?=
 =?utf-8?B?a2R0NkdiMk9qQmZrQi9jeFJaeWVvQW1SemdPL1JRMDVvMnJkVmRmeC9iL3Fn?=
 =?utf-8?B?RlVXMGlBeEU2ZURlUFVya2FJa3JQNml2bVVBbTljaDJpZXlzdHJjWWJYV2ZI?=
 =?utf-8?B?VHJDdXVkaFdqM1FCV3VsNWdMRzIrR2pRWkFQRGwxcm9takw1YVhodU0vZENt?=
 =?utf-8?B?VTVqcWFYN3BZa08zd1BMM3p3NnAyTWJEaUhaQ3crdGhIM00wUWF0dU9vZUoy?=
 =?utf-8?B?OHZQNmxkQ0ttT2R0ZDEvSVo3MVArRkVOdkFqTnRZNjR4WUppditMcis4cDZ3?=
 =?utf-8?B?UlNVdlpOcHdjcm0vSnRKNXpDVXl1c3MvMm95VGM0bjNzOTVBME40ZGZwN1Fo?=
 =?utf-8?B?QkJ1S1F3eDlPQVdUaW41amZXVHYraUllOXJCR3Fwc0ZWbVAxc2d3bS9Xa2I1?=
 =?utf-8?B?aW8xdnFtZXNxazNmMHhvQzJhQzVKZUd3SEZwOUxoZlVlNDZpYjI1ZlIwcFNq?=
 =?utf-8?B?YTNSeG9nL0hZUkFCcGJvVjBNMWVPTGFuYmRpeVdKTEtJRjE2UWVPRXFFMmls?=
 =?utf-8?B?bFdCZEl5Wk52TGJCV3JnYno2K2ZCZEY1MmxWS1hCSXVENXBZN2FmTUlWaGF4?=
 =?utf-8?B?YzlTUkxlekliTGlxeFJFNWJIYmQ0S0Uwd04rdG5GZDVMTWd2SjIvRXhnZi9E?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2495a817-f70a-4d56-218b-08dd6c522d66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:37:16.2538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/HYDu/jXjYmtPvZyeAFtMF9d8DYLzW+SPPPtzxjMY2oHp+6dlH0J0TyIEdR4dq7i7ds/26tYfvTvVK8JgkInYZMx8yd2Q0sdDBXLeJTciI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
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

On Wed, Mar 26, 2025 at 11:09:50AM +0100, David Marchand wrote:
> On Wed, Mar 26, 2025 at 10:11 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> > > index fba46b920f..0cc4d12b0b 100644
> > > --- a/.github/workflows/build.yml
> > > +++ b/.github/workflows/build.yml
> > > @@ -12,7 +12,7 @@ defaults:
> > >  env:
> > >    REF_GIT_BRANCH: main
> > >    REF_GIT_REPO: https://github.com/DPDK/dpdk
> > > -  REF_GIT_TAG: v24.11
> > > +  REF_GIT_TAG: v25.03
> > >
> > Do we not keep comparing against 24.11 for the whole of the 25-ABI cycle?
> 
> Comparing the new release against v24.11 would not detect breakage of
> symbols introduced for the next ABI, during v25.03.
> Like for example the changes in 52633e3a3fa8 ("net: add thread-safe CRC API").
> 
Ah, yes, thanks for the explanation.

/Bruce
