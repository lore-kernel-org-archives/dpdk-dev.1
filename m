Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3C9CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F744067A;
	Fri,  5 Sep 2025 17:36:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 484DE40674
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757086560; x=1788622560;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mtNiWJ7QbqFM4F1W1JBMT/Ns4yTulYvMl32ldlm3Dpo=;
 b=NnCYRmdd1YSxJahFq8rKIGIJqjcZEUO8Gr883Y9z+WDXNy3ubg0YSK5e
 oTr5bXeQu4yhPAC3Zbx/yZuaCpMlnbjsOctE8fW0QQBCjMsAYGJE/2qTb
 D3hOXqGjJoddCdAdvLz0Exvo88pbYKci3PGIXFmFH9hz3e6nK6dQt0mmA
 91vrzEcow4h/B/czKNiY0nzAAGu+ieLHncvGdOh7lL/nw33Iiq4ZIkVGC
 Ikkkbovb6oisZMh7aVzO+2TdramI8Pgi24//oPHJJQWDbb5gCIpfL7Y/1
 wviHKU6GRrnymHk1dXNIvomwXYk6orh3lM5SKI6LvyCjo7j943VpBoGiu Q==;
X-CSE-ConnectionGUID: YaNA2y0aSiiapqrpNLGMQA==
X-CSE-MsgGUID: wnN+g9h7TSqcNTdquVMT6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="84876058"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="84876058"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:59 -0700
X-CSE-ConnectionGUID: eA1SyNaVRNOKJn6JuFUd1w==
X-CSE-MsgGUID: jztzQnjvSAyoho8VlyQWvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171468230"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:35:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:35:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:35:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRpyK+seNXXsWPqIXfgTP9rQ+tICVYZNbmRZk7shNqL/y9iOQJXfQQBBwpm+wsctxfV/jNV2ypB4h0NY6IiV4zIpnNzojFXFNHUWf+MSWPcwvtljMQaUylD7SwIYfAmEtXwKYsw6P015hO6ljl4L60GtMxZBgMMTsbucphmm/E4ZxQEXMkcqM/am2xr4Nd0SxXtQHvhUIe4ewOkN/eZ+iJMm/8Qt8EGv0jKGBWl97rfssI5BIsPJLeb8F76Lg/WmqagULrUR5WzVdLO9cdg+Y22BVSD8zST6KMe3O7714KAocTn0xZQ56pT2VxYK3iJdDjAfNihRj0kGSB3LwdRMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS6s9nexEkFyXGtFw/E7ZBmIDS8VVIa/sXWKwXgWBiY=;
 b=y+k6E8g1z1ddQ0+7OQH72Ez2xwp9DYLdHhbTOAFN3ir5vEojjPX1wuJF0mLbEXBC0zI0PoMwFOuihhuasBwsU5xZaQSviQJrl1oaxdoPc7o0pycq9YL4D9dC8moXmWWxae1OnUVDTI+1wKEQdFqpUTockSrwWJWGpE3aNA1YeTSIJPTxOJd9JGUPwywdtugeVFvNstPUeckqTPk0RqfLfGaeeqk0dX5kbzGRwHBwLfRGZexH6cGqErKYLuV7DKJGHEpLFCDd/COI9/3YoanGlBZYJZk9n7uQrgl+etmdqdsWmlwrh7RUnGJP6vX53L6ru92a4L/6UfKXsyMNGACf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 15:35:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:35:55 +0000
Date: Fri, 5 Sep 2025 16:35:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 12/12] net/ice: update README
Message-ID: <aLsDV7EeLxigBWwP@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <188e136f855d4089bc2733ba00db3f986d3ef50f.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <188e136f855d4089bc2733ba00db3f986d3ef50f.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ea1c1a-522e-4331-2656-08ddec91e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6z1XeP+OHej7Tghcv4tc8ISaI7aviFD6gPUQft8qh9glMhIc35bzqd9LNyR?=
 =?us-ascii?Q?4cObhy2JJZC+IF4zJHZ/Pghe3j4yHnoQvMkxFg4TznZgCLRSH/yjoG5cCTM6?=
 =?us-ascii?Q?pzi5kGnD0E5N3imIv/3mq7Kbdh4alxx5wk259PIlBYjHNfdj+chFqg5u7nm/?=
 =?us-ascii?Q?047IGRTPHcXtuYcwecS02+r0oSukdvhvmgGsDzk+ZBJCU6lEiMHRh9BT9Q3Q?=
 =?us-ascii?Q?gZaQwVqvyF84kbL0oNa3KKXKQQUvERu5NOROWbTZrmXYNWDeqi00dCS6I35O?=
 =?us-ascii?Q?Rsf8g4e0wIIoBcjwB8FiJDoIe2OxgVn6ad9/idOA3F/IvSNQYL9AhnGk6qex?=
 =?us-ascii?Q?zWS8clnD5n6CX2pn9PmGdN9mCSFEHIi+07jdw/hy62H8Sorx0opVYWrr6fZ/?=
 =?us-ascii?Q?KbU5dNHXk1uMN4zSO+NH0lGFwWf4cmcHsKlXvz5aYfVZDUKvJDI6GouTuP0B?=
 =?us-ascii?Q?9CVEfZJfCUi4waGO6ggjS3vKqefYtRzVZOE82qy4/4zpD9Py0lahAfSAsISS?=
 =?us-ascii?Q?nMIH3DTUHv4U3yzLe7IKFO2EiId0kJKifJOAidFmnBVsiZz0Xqj0+9Uxf6Ep?=
 =?us-ascii?Q?050K7DFp7bSLHRmK4N1+aBQPjD3o0gqYjypGAVjP6bpP4DXn/wdkvU4HoMMd?=
 =?us-ascii?Q?460Nh5jOaEkonZvFcfurDV0BrYySkYtCsd/LTe7N2aaaQFAeAjGsR3Uf+brl?=
 =?us-ascii?Q?qo2memVMJ9iFjH91PkFM0XGM/siQI+Qwsb4vKdAQVzhYD/DBhtUylokR88Cs?=
 =?us-ascii?Q?yifxxxaG70AB2XPmbNgKJO6orhqzCFtkuDGoECvnpnGBuY7h2DEJJ3WSoPqa?=
 =?us-ascii?Q?kMJ2jppoQUIH3OWr1BvYlgR6EEabeKgEy5WVItol/JPzahbmRgZr3mvo/Cht?=
 =?us-ascii?Q?WqEuWu75Tm+hns4JcUJM+VAKp9yWbyvku0BKKiOXJtr+9lZJIoo7dpBaPHVr?=
 =?us-ascii?Q?qwGXlx7EjSiVmpEnRufN2QSnIKxIHkXEPRsKzngEO8nYt0sb87py3Ai6EPjU?=
 =?us-ascii?Q?2En46Ek7Dq7ldNXY2TSQp+V1nsGQQuCGUzbdI/3f8iAm/esqA0uUcz4mFTce?=
 =?us-ascii?Q?u7TAVDsgJsowWL7iUuxVndY4uqnbljNEJp58zuzngcCONSzoD4eCGLkGD07z?=
 =?us-ascii?Q?pQ4SFnWSFsMkxPnE0M5wYrDRQOy0b0/V7bCQy3hh6OWiSW5tBakR9I4YjMWm?=
 =?us-ascii?Q?EvQlWCbkkcEuipygExjUdB9BiKnRC3Oda1SvIdXWiagZYp8nNrcXJNfe5Uju?=
 =?us-ascii?Q?zZSk85dB4weX+CinnAE5LYZE/qTUFsHLDPP3SrEfpVMKbBbUFKPutFKmpQc2?=
 =?us-ascii?Q?o7tKtjBK5YVKBUFUoC6Si7/rfh+tpJKWCVpAag6qj8baqvKvmMHByNxfB+Wi?=
 =?us-ascii?Q?LKixEm3XFfHrzSol7/GcdQ0HMEfRqTMi4kip4jCRsShLq5+2gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4sndl8Eglvm7Y0imLLfYXIxSEwnxaRXq842H/Un2SRWxDnVGQMGHPaHscT7?=
 =?us-ascii?Q?fIvPyfJewsbYWvabgt+Ym4VYpzJHyJ6T8Z7YdGAY9q4hTwxKo3ett6s1mzba?=
 =?us-ascii?Q?hpUoYB2d1k2wbLGCUsyOmf4AG2pRRhGUjtFq7AdsRwA+nkXxG5tbPe6hYcjp?=
 =?us-ascii?Q?+RsVH16fx0cyDrZRYTjDo+XI5fibLi/V/pZASK+pmCbDcBRAm1ypFnRDXJYh?=
 =?us-ascii?Q?3J2NQMSdud7wYRGmwxvLhQMCxvtyOQqIspxhQrGdPXdkQ5xlA4/xxoDa8KP1?=
 =?us-ascii?Q?Ee/lSLF+LitaVGA8DS/DzztISDLLmhyz0uDNPTy5otXxBzxCT0I+5jzpxTCz?=
 =?us-ascii?Q?e7jZ/bDGzcP3kKTDpvfmcGFSDBoiLjwvcVjCRFXBQhT5+oLZ18jVroTO5p8w?=
 =?us-ascii?Q?kczkqM/bplC8T7y8c2d2Tz2R8ZMETUHTxehagNGTG2qsGAcDGJe53NF74CZD?=
 =?us-ascii?Q?HQV1lZGyaKPpjxlFZvrzoOBFD8IsfxTJB0FmYrnsHiz49eookpGxaxK11jD+?=
 =?us-ascii?Q?54V9TXgV2UFH1uUEdufSGb7JINIsCPITkQSiDocjZErAJAinxeoDDMaedXn3?=
 =?us-ascii?Q?owM5LgP7JUiODx0tZKLHJ2+l/2ra29GKojww+8VN/sP34Guk4ZAfaT69cNr7?=
 =?us-ascii?Q?NZ19VCwTDoG6ky2SZ/ADm/HMzN7iA1YlzFUpd/xonm+XekGXakXy4AOwljZT?=
 =?us-ascii?Q?iUQxyUg6QFtBxt28bSoEju58KNoXNxcnc9hPidV4CkDGPwi608kKhSO0NKRy?=
 =?us-ascii?Q?zLFn2i8djOSGLHg8ye6MF50LnAi+aVPykilJnbttKlkBK39Bx1meag0lhWZz?=
 =?us-ascii?Q?2IWtg7ZzRhcFd7Uor3M6w0dg+Afx0Ft8Y5H6hBrZTwaCz3u6El/O/xNCcB40?=
 =?us-ascii?Q?utZCs2APsUeQDh5JVMQoq0v8STcbG9u7k/XNmKgIGDTJCCkoEUCqURxWBrUi?=
 =?us-ascii?Q?G0T3+0uqDFr0gdvS9+StwsS6d8jpayEp9nPJqHWIt1YcoLtNj6lY3Nt+H8V2?=
 =?us-ascii?Q?VIZoU6+whv/R9pGYApkgX3Blt3uev/TuOyPnAnv3+cPWqKaDYq/+YJ2lXCul?=
 =?us-ascii?Q?6gBeiZMtG8XAK9/N3OTNpV+V6oRQCFR7sVPJFKTG8mgYYJr5CobbS5UwerhG?=
 =?us-ascii?Q?etFyBytUoUnSPrwhX/rK4jS7G65HAoEwOmu8UVJTTN4aSOYMZYdYBcIxqu6s?=
 =?us-ascii?Q?sVl8csVm/OslMxInpccSpU2rzD2j3QCekKXzXbthpZ9T9t6zlPoE+db2Qtz+?=
 =?us-ascii?Q?N9JxOS+U2G+7beEwf0LisL61axHceR33+PujtpfKz0EawsCRKSF0oqTHB7FN?=
 =?us-ascii?Q?yIi1/VQTPlaZi131uRfHlfbOKX6T9SQE7H9I/pGSEIywn/v2HL7O05b34BFt?=
 =?us-ascii?Q?WZ5r1btg6MtsA1s1Bmbs/yTv0L4HMCS1xsfmNxkum1z6887omTBojUh4NyHB?=
 =?us-ascii?Q?v0EJ2mv4fFJeqfEAygB575FEMHRZK1n4jppqhty1bQ8p3aKa19uvA4rEAFPU?=
 =?us-ascii?Q?93tPRWCeG5wTBQuUgNticUerrchhKXMSK9Hpa2tsO2LAnC0BHGSV1eYMMRrS?=
 =?us-ascii?Q?9Tb1/WNZJk9Grx9vC0EVQnrLdJGOftXsmY2FvwRjbwlq8kgEz7hMPhf800PG?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ea1c1a-522e-4331-2656-08ddec91e7a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:35:55.8631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEDOo8LwdCzurFA7nCyX9rETDU8atz6LvkZY42A9leXsDBoUZRjfcveOctfTDkdbtvEl4QNgkfDBSX+POKVmA4z156aG64BxGhAJ9DUUrYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
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

On Tue, Sep 02, 2025 at 06:27:02PM +0100, Anatoly Burakov wrote:
> Update the README with date of latest driver snapshot.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
