Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C632CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 250E44025A;
	Wed, 17 Sep 2025 11:52:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8DD5940144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758102764; x=1789638764;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yDibxDOWtOOSHo8iWRoFAxqhBqkVnQq6NTlGpwTXdh4=;
 b=iCAL5Abk6bOpaoFJGrz3hYUT06D+Mi0jDCOjJpOuLcgzbiY6pOy38v8F
 UfKhM7yEK2J+8lw0MIlxUvjfpnAy2RDEZdFiTTQXCGifkDNLLi+rtPoUX
 kB5FghkB3XgUjdKVS+u03mf39hrlIOZFI3VYRxxZOFtE/dEA9WkxlTUvS
 /+n1zbKQ5uR3nN1mGzD4gunChUniHxgRk+Si1VuNdnAXZfTEZY4znyM9Z
 Aa6LF1sELkv79G80NBcU/xOtf/L3HAE3J34YRgBdDxHbIFopLnPQt/C/Q
 VzRySdTcmQn0zbs13cseZRnMjP21SSmJz751I90fsqRvEVIN86shGrwPu w==;
X-CSE-ConnectionGUID: evsBO1hOTRCh1zL0CFVXNw==
X-CSE-MsgGUID: cDC5+DSDQMixWle1111lhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71507443"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="71507443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:52:04 -0700
X-CSE-ConnectionGUID: edYZJGZjSBOMoc718qroVg==
X-CSE-MsgGUID: nkwa/BssRnOAGv/u9ybeFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174307810"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:52:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 02:52:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 02:52:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 02:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsW8qG1gRYGSOZBzhfd6sm6PAlHeSOs9DmmpSrIJI0tRvIEtUfiPesPgrwP+BgRgbCsuU7GrTi03AVoztfSlkDxMuay/Mt3GtxlTOMGkfoz8q6oVadESuB5i8Vz2ffIIhr94yIxAbFhBZzgR1zYmQGzcpW/zzy9AIJLaVgv/jf4HHkEFS8XhdpxHuQ7fi5PyLPbKPAc6yGJW9F5jNIjW7v2gb0MTb7ruI1LpXLputxDdwyPfFR0tYM3eEktBL0ea2hcbrO5lV2EcnzPLEFoN0LwDOVxPoPA9cyGJzi32p46xsplhSyAYEDJ/ep90fidaUItzz61tjwt6YJ1WcnQICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/8EZtJQNC6FhZFEWyB4g60GabMk9QC9FvAa+fbhsjs=;
 b=DWUkXM+kTcOjnxP98QpElTjzDelaz3KcpMdV4a7yiM8XazI4wONiJiCu0231e0w8OcO5SlqZ+2NwSGo+9ISe4PWFQffCX3MMVa2Gyq2JyuUz6EgYug5QXRyogK7QV9PO9NXSlzAapTLkLCBWQwLJdNZBiN1nziUpeq8HyL9aRibQxX0zNu6LHbuTasE/IAIWpSCEyq2jB6Gtq1a1aAcOOEilO9eJLJMAIDdWarZppKT2lFD27ohtu93q/dvvXkLDK/IozK9H13MNu/RArIFeEVHprtf8SybQcvP+WusADB6EHqJBO2Omv8stPXpMkaW4s8lJ8QMuTn0T9tIj3hAfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 09:52:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 09:52:00 +0000
Date: Wed, 17 Sep 2025 10:51:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/2] net/idpf: enable AVX2 for split queue Rx/Tx
Message-ID: <aMqEvK1WhhfgFzL8@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5fa2a3-99fa-4a98-3f1b-08ddf5cfd901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pQ5JDkYaMWgT1j8c6NVhMDlUUVPhcbZaqaEvUoa0jdXPE0lmhr2I0OBBJ8is?=
 =?us-ascii?Q?CVOSYyLSCd6sUo6x3SDLhuOqL6E6l3Oqc4cjIIeva7V1PR5OHw/kM2AaYJg7?=
 =?us-ascii?Q?BiRUxuLEuqZ6PPonL4uDjoiNgzddPP4tMsJLR7yhFJLCusZQ76/RHf4AbEmk?=
 =?us-ascii?Q?8ySiZwTqz8AFOkuj/yEzODegH9olSinLuoiW3wzlXmvhGOaqn6FtZMLugA1M?=
 =?us-ascii?Q?XaaVeeaz28sSqC6+XZDdAWKASd13xJkX0f+DpI5xG0NKZ2xb+jYxoQcdcZ83?=
 =?us-ascii?Q?0C6zMSIWUtILgyW0M/WqlbhJhS93NGvrt3Ja6IK4HUBpAwOjmm7P5Jn/TPgV?=
 =?us-ascii?Q?65cUuwR9UMKOO4/Nrg+WA0xwSred0hft8uF1Qihye7Iod8EUYKOBG5hi/Dye?=
 =?us-ascii?Q?nYmgTrsvpu1hwMN0/DPEFtuwHil3GkaFN9AgJpxMCXJVm+Ua5012te+BP47D?=
 =?us-ascii?Q?3nGyJMNy7VFpeqiVCnPmbyFb1kSBEFdQ8xwjmkATMz/Gct6er3g5iF6Bil2w?=
 =?us-ascii?Q?3Y09jN8Qct1rzhKnKbUIRvI35OQ+tae18WzF2G/wOij44S3rQKj0ViUSkBlQ?=
 =?us-ascii?Q?yXMfgbdK6Tmi5w8xrgUBBcV5W2IGNC8J2bO/lZ5eZnT4dUvkZMxa8mZsZLMk?=
 =?us-ascii?Q?/iZfKm7pKbbQ4R0MsJtDQbVi3XOto0Bimz/eEP28aE6TjOjua4/Vw8C9kDU+?=
 =?us-ascii?Q?VCve5nNAPMjrOuHT/zv9M98bNYHgCAe/Kr3SER+9sVP0e9nGWCaWgwVA1k07?=
 =?us-ascii?Q?X8s74YLTZcPp4w57M3KzCq9zvPY5TZoBWxMcmaWYsxjGigX5de9yPGkyi949?=
 =?us-ascii?Q?ZsmCzoD9ZbH3XyzuTNu+UXkJYcSgMBOdQXZxSadlkQrdZ4MHJ1Q6es0E52Ih?=
 =?us-ascii?Q?v+1bPVx8gFfVNKJEQMlsZiPewHYMl8YDTUvjlyE3UQMijcvDqmEXK8ejRnGX?=
 =?us-ascii?Q?P6DI1iXXn1IDPw7JR5x3YTQZEXLYK9H09TvTgNP2J6Gb4sfuWCWYRJsUARv9?=
 =?us-ascii?Q?zXYj3G5wla7civmf8QA807w5zX7w8TEvyYId1WxTT2mslWZlEEtnJLYovHDT?=
 =?us-ascii?Q?vfgMOMRV6xXYnaBYLB2wAP1cTJFJxfvCX7xuKpA1pynQsYW+PYlthCTmf8B+?=
 =?us-ascii?Q?ZoEG6dEH7nTCL2cHUwp3+3lShe1CaLR29fyRql05Uh1U4UG49iuoQ6+PZ0YC?=
 =?us-ascii?Q?BBEK15PpihMZILjB4Zle5y9QpsVjfKg6nkG1Wop5lnwGbMKV02aCpI+KD5lG?=
 =?us-ascii?Q?rDNuFL03Fm2/JYRJl2xnyTfpChoR2IMKiV1OK6oO0bOrpckfrzLAL+lXhjH0?=
 =?us-ascii?Q?JfLykAG7u96dif24Q0XsMzp2rZmyoKxnW+TlzWRfRrDxx+YaDhho+Y0ebEMX?=
 =?us-ascii?Q?mAIShXs21Ep61SGTpymW4kINm/Ob?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oD7xwijiEW0rhHunJCP73xYOXbUiL4tcGbZHn+oKlzer6MAD7lS63szDtDY?=
 =?us-ascii?Q?ILm37cPAVYg2JAM5ZMFKo+6F/nVuMtwjZn4oizm08qvA/VcJYrVkgqI2eDe7?=
 =?us-ascii?Q?aaLeuFBsYEJD/7MzEUxl9hLV5tOcXW9CEIBx7Zl3AhVFoa5IwXAdJOMnaHBa?=
 =?us-ascii?Q?mwCq8clJmeJZiDET6DUgXw8JY3hTj16yYK4WNXhW05EBuBH05MGw8xjquwjm?=
 =?us-ascii?Q?XEY33njWMCKicIZN1pdadK4LaQ/gRXrb5Rnp9hUkCTjRBuXZHQ4kUu9qGqQ9?=
 =?us-ascii?Q?9bVBFlnnFmQCFB8t2HRLXCwWVqoG20UiavCRr3RrqCfZpPI4/wxSJSSW/Eul?=
 =?us-ascii?Q?vTT1E/yMPFVBtyWQJFDSaBjEkA46Z9kKAaWjQfc8AtFHGlt8J4XnLMLG0w4K?=
 =?us-ascii?Q?tx6nA6KJrlhCXz4PEDL4D6/VMJHkHSeYVWBQ6QzGdM4xgBP9nLLVkaeT5McM?=
 =?us-ascii?Q?1p1hZpo5pSN84UXJX1DQX8bSEQr2IX/Ovs68QSVulzNH/K4K9xxAVVJinq2K?=
 =?us-ascii?Q?FwMdZ2pHOTo1Ky7nOrGufnWPi+X8R9d1r5oC6U63hIxvUTS73HWM3xHNxY8C?=
 =?us-ascii?Q?J5dtbUqOzThOribJIJcMc7dtVbayqQqsXjp8XS6iXKRaOkmqbZGo+p8iw3kw?=
 =?us-ascii?Q?KaXRTIaLU9bvkivRdJP7Grjju1cM/XTj8CGLYEhMmIG4tLaNdBXEOu3x1G5P?=
 =?us-ascii?Q?0kN86/UM61StCBNg7tcNwM0pBiJM83eq9KxaC4SI8uZivlMsWCHw70TQOpMu?=
 =?us-ascii?Q?CZp9oPHaE55/gZsyR4svAxXW5A+TxE1DbXdDVkmXbQkdP6uEq053haGXqBwU?=
 =?us-ascii?Q?54QKsO2EmlaecxtdeeAbH9YSKnRw2gSx4EleWMhnpKTKC3OK/Ts5Srvdj0LC?=
 =?us-ascii?Q?E0reGxw7aDQNrvJAJll9RGlaPOFLfLEx42FFQSkraDN0/7/uItNdMT5Qio8o?=
 =?us-ascii?Q?OZcGl5PVwCye+vDF1a2V+yMJx5oqN2btvN0yVSfAubFOwRzGa6fmnUd2vJOz?=
 =?us-ascii?Q?bUCFDGTDlQ3lSz8+uheQa/LeKgrh055vOw39dz6El4TlmYiMuwwrAZD+vNfy?=
 =?us-ascii?Q?XJbtHyGZGmrjGtg6iEVa0hFHpB8fKxS10ucD+yw3QL09Di2brwlnURG9RFm+?=
 =?us-ascii?Q?shw+rtAq1Ed7BU7qDW6EnDH0NzoZ1gNIaCXiXkHRtfKCh+deDXIc30M1sHjN?=
 =?us-ascii?Q?ZvSqxUGm4Jacy6QMd9+eojHWWL2l7zPgfFrOLbStWhMLoEAMIm6x9hSNq4mB?=
 =?us-ascii?Q?DAuTYO6dGRYSz0N4mLiEFVd7nB3Tmqmpeu9nCnrFbSWJkoeG+UszhvTNahG5?=
 =?us-ascii?Q?7kP0qPJezpeTFz5WDZEvQtfTUHJHPqGBgPV+kl3RLzltz2heJ2I6F074JCxH?=
 =?us-ascii?Q?xGA92BPvYJXYVRf/T468n/9vtst7tPtEPMGZdcT+W7ONF3TLHBEp5BVYWcd1?=
 =?us-ascii?Q?oC0xFQEyxR07PD7rSA0RT6v6ZsPooXnvaWaf2OfuO48ySW+T3G/aHi3YoxBo?=
 =?us-ascii?Q?PYV4C5DD8OL/LGKlZPZn+oB5XqIoUguAhWF8YcdLJLCZYHcUZ3J0ayrL6Zhn?=
 =?us-ascii?Q?3G7ZFFfAxVDcBAeZovb5gGAtKR60bh7270VdhCOoeT0RVZhs1HUmR7Mi/ETq?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5fa2a3-99fa-4a98-3f1b-08ddf5cfd901
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:52:00.5576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyD6mimZRwfw1q83uSUDyFlbXp6jifCfvk++K0H+k/e+0fAc+YjsV3ebLtyHnDL+UlB2XrQh/Up1iEL/9u3O2CiHVajraY1nHgPvSubpbkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
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

On Wed, Sep 17, 2025 at 10:56:56AM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Shaiq Wani (2):
>   net/idpf: enable AVX2 for split queue Tx
>   net/idpf: enable AVX2 for split queue Rx
> 
The code changes in some of these patches look to conflict with changes
made in [1]. Can you please review those changes to check they are ok for
idpf/cpfl, and then rebase this series on top of them?

Thanks,
/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=36148
