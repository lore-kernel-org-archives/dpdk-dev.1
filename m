Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53404C79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1308340ED2;
	Wed,  9 Sep 2026 14:47:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 756ED40A76
 for <dev@dpdk.org>; Wed,  9 Sep 2026 14:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788958057; x=1820494057;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lL3DQRjQ6Vfp76VlpX7drL7UKd4LpdQC6kQD/CRADlY=;
 b=Pnx8D6scMfMvvBb/cRdclNY4t5xvN0WDkNy6NmN/RcLCCMWCjs2PZuDr
 ZVQ67AcESopwi/nH8zpmxLPFfkubJVovkTrZU8L1ZMBrTMTgw3Cvj20Z/
 IM+7FgaaV8lbQMFCE6z5Ip/6QwdGpJT+j+yHYWRAl9bAvrptDzMJGnY4v
 dU3UPJpC43fx4ZwJT4t8P9ykcM0hAFqfJVKHduYNSvqxOhI0LfBJ2Z/pG
 enH0CBQmO7txkx4vnctU9qmn0bhAOHa4fn7PgwKvm0xJ84Ogd0N4k5Gic
 PCx3HoXexLEoZftJqNxhtTRdSHScVuGidsWjaVNgAO1oHi2wOXwLITCaw A==;
X-CSE-ConnectionGUID: U47q7kTAQQKADpol0C3vkA==
X-CSE-MsgGUID: 7KbtOrcqR82l/+fs7KThNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89592262"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89592262"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:47:36 -0700
X-CSE-ConnectionGUID: zN7HKMW9TL2eJDNMtoeSSQ==
X-CSE-MsgGUID: 5YWlwBOTQ+qIebBouP7/Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="273281184"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:47:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 05:47:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 05:47:34 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 05:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EONIDcBl7CV2aYWTlHqOyKjqGVUsQnUrV9Z5obE/Q+aPiDZ24eIfx0/OY+PG+yRzXJriLWIEvBYqBYkMgbcDPnxiU0z++MH/Nl8vj5IVfv7Cg/N41gdMMw63R/ttSJzQszDimN1M15EC2PLZd9tqtxFSER/1jcQez2/hpeWip8LpgqUc3TplCw3CHI72AHN145eGQ50ZAfor/5bwPoHeAFGocRIOWYcJlEg/LxcKvQ8H3yryyKOGvcy7fr3/DmATtUrbsNV9nTohMcubmv5JY0sybiAbpP8XlxFL6a6dlgak4csRfpmfd+LnUJrfvPD1tUE50PHtdwINFbdROCMjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17J3LrpYfpcmhXxnNlSkPE2a8MEwlbw8lAh92YAe/D4=;
 b=WV4m0WXoyh9DgHPrRbS2XWcU8X8jf4NdaukOUhx9/CR04bqkw+9mhd6Y4MoQ92ycVz8eXJ0RJ90knced6oPOSAbw1HU/pO8lemqEwmcf9LH5vdjOwEvt4Tlgiq/EGXdEq6qZYVWNNuJ3sd/a6gNBGAhG72E2d+KnH9pqJD0BgO+lWLQ7jRa50K0WR42wHnuH1mV3qXd3UYmtwc7MKcPfhj1CzVIloTAisC/0aVHL0d+J+3ZAnaaRbaTLhZugzFJufagxd1WLrGcGgwByzAo9HcIxvmDa7D3xL6E3zArgTAoBysJud/zeGheqToVroK4I1eZRKW3bPF60NaHhbSXfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 12:47:27 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 12:47:27 +0000
Date: Wed, 9 Sep 2026 13:47:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 4/4] net/ice: split VSI queue count into Rx/Tx
Message-ID: <aqFVWdRANdu3IujS@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260907130750.3406004-1-ciara.loftus@intel.com>
 <20260907130750.3406004-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907130750.3406004-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::40) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fe2923-22dc-4b97-469e-08df0e708093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RVBpSEFCHEXx48VR2+pxk2CNiTHITdAmEKY5bbicUqun0gj5LDCpf+jJOlWx2C9dre20PzhZzKhgAH4BdsqxxoSLSntvDujH4M5KOO7dS6vxc4xQPD9NWxHuB41QtE2D0cymJrmulMN9VCOVd6m4xaskXrybbqMZ/Q2OvDQ6/IBTPXKqKoSriHKGD8s1DPEDkPsnmGgwzm4oV45+pZ5hRa6vaJSq3r7+LiErrQeCzL9L1wiKEWdVLz5V80lCkKIFpFRePFq8nQQlgiZMrac/gE6zOFCe1nm7HL2OD7cYvCVzNHDD3+QpBzH/3Br3RIBspj//n8QAuX1T79B1kg/3wm5I/AaLfJhTlxkZzJTDBuz9BLi4mDYpTWi77iI7LyktY1uCNE5Je2DOyJ04Cf2BWfRIoEDJeKqGAc4Sptf2A168O9H4mOGP/Zw7sSnw7liRjqzW/j/XybVGWjKornXoqn0yWY9aEoS+CAHyQZVICOV3F+qIws8o27oKfcdCCBFtnpXdmPaFxiBY9zWB62PmCHCAe37pr/DPO5s8Ced61kOaey6i+wgXSdEtyg6Z4eSd0sRCdrHdF7ypoHXHc5M8qwP5ro+ltoq4gqsswWpTC7APMowT3CvtJaVrqpLr7B1mnv6Be5YMlhbkqLLbRBKKmX4OaS+2LaHclCg68X68fGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuTvr35qmLnD1DcppwGXmnwoM4cv/BhtUlU26RPBsbWpohSWDrXNDK+D4aYL?=
 =?us-ascii?Q?1pXR4U9wr7Q+sbgMKx9tiWkou1fKoqQz0f1QwFy0XXtwCf6dH+uoFTv+xe++?=
 =?us-ascii?Q?6ITGNZgvNecYHqB16jUNbhCheYOTYcuEf0muWjnwAmZXMvy1e/dH7lbdhp2a?=
 =?us-ascii?Q?bHtcUDgpXSCG+5/ns31Q8Shx/vv4zZbBiUMocVxe+8uk9fIur060yCJRAHN6?=
 =?us-ascii?Q?BI/Gch6SbVvqcd/C073kytnu74CbQNUld4wdVxfLhiYutRrnEDRZmS0RJY7d?=
 =?us-ascii?Q?mdMXNDIBV8t3LnT6bcFN/y31tV9gGUf9Qd4HpdcgntaChEIPoRO4vBLcx2ck?=
 =?us-ascii?Q?u4KCqjhjnE/bSIKugp+Y92XCmKi0VrvItYpYKOh75v8lPyJ0k87YMgDxVPVv?=
 =?us-ascii?Q?Vlqqt8t1Ol21/80uq7D9HTNOfticRhVNCmOvhozgBuVdAwQKLaFsyU9bL544?=
 =?us-ascii?Q?DNTydnRHFaOeSXya4P7mDSnEwIv/hIo/nWIUbo6F9VaHEyvUr+F2SkATORtQ?=
 =?us-ascii?Q?2OtCR+8c9tAGWE3kbjEQ6nDOqmHGbLrPz9LGNWXkzT9UiSrtIlH6LObVXx3V?=
 =?us-ascii?Q?63B+X88DTytZebit7iH5RCrysa19zmbkgX1Nw6t2Oq7ZVb02hlms8u87CLUI?=
 =?us-ascii?Q?2wv6K461bBFOWh4ZV/Dmvqmg3Ln5Croy3zM6V+59SjHBZHBdIu9UhCuDBBVE?=
 =?us-ascii?Q?fgdkMW4l9cnvEh9rYoeNVm9LfiEVQtOAZZ7/Lkp1TloUnwc/xT5pmj2x6dBC?=
 =?us-ascii?Q?r3soMWwKkBbbla4t1wskabhf46+ou+bY+1hJvx6u2cDGadgP6sOQLQrknvDd?=
 =?us-ascii?Q?MrkizW3It1WrV0TImOQeH2XpG8EbetqQX4Ww5IOh5wIDaG0mCf/KxRFYJH8L?=
 =?us-ascii?Q?GPqVj/93bhYUYM5wZ0jpC6tZHinMIWzOCdV7sq0WgWTm/Xu/pyiG5/Gf3Tpw?=
 =?us-ascii?Q?aI3s0P26tJgXrM/+Lok7T8pnzCpjUhKvFw3OkX18S/0cPykX4JRf/xqABdIT?=
 =?us-ascii?Q?GrYEudira/9CpAIiaZbsklLNJB4W0MOImI06ddtb1EMPXgGfjR1381VbI1By?=
 =?us-ascii?Q?gzeCg8sqVOK38HiwgigkquY0EMpgNDjIlrjk59Hx8JMsWidM8m4E2mnWeRAp?=
 =?us-ascii?Q?A20EWU2hK/ufvKX0lVw7g4T2b+cOmCOi2iZrM2cjRLvinAEuwfDhfJlzYDRx?=
 =?us-ascii?Q?u68Dbs360K/YInIrfD3maWuKSN7/gw/1ROR14n5qTowQR7insnQr2c+vCa+Q?=
 =?us-ascii?Q?IkK+dHNh61OhDEOyzdR+L6XZEIZO9Zt9WMXInm6y0VCr+N4nXjvPRjYfk32u?=
 =?us-ascii?Q?DYPQVrFoNqurs2Vx2YwjK+8VvWkARNnadaRvf3thwwK1oTfQZRPm4UVsC602?=
 =?us-ascii?Q?7OT5GSBEtdLiw1yzz+eE8jLTdbRio8czduVx2AsojPENnx2tb3zIarsfSK4n?=
 =?us-ascii?Q?1pVmqp5TlzrwxcLpOcm19T5dRdxwf0koK4gHRxk+tYgry8MPhesGJlDezXyA?=
 =?us-ascii?Q?Fvqe/c+HLXzgDFDtw6QJ5e/m3J5LzA56wHSeDS7TFlnX/m2+xXGTHhTaBgXo?=
 =?us-ascii?Q?m6Bk82P15p4yq10vvZuEaqoA7Upx/U8fcN02NRuYawUk+79sSWTcPCjTWkqc?=
 =?us-ascii?Q?Rdgd7cGUCvQafXeiCBHpRqGyntwNIAcOEELRPHNU3vxz2YGZC8MCcjLhxCIG?=
 =?us-ascii?Q?bL3FVzHEBKV1tG9R/GjtQmT8AeoopbZaH4PQtHjBh+HEJKIPP3YhGuqkg6sQ?=
 =?us-ascii?Q?2KxYnoaITenHdTAyQd23R/DRUQqGu+U=3D?=
X-Exchange-RoutingPolicyChecked: IGeDfkgWbPGTabEPkeOVFECaKC9gwa1QPZXctiqo5BSUyAR6KDaZzjs/j9Jems0BqwAI8BieldfHL3NqV58rHsJJAF8VOPnS1x0oO8AQ4YEPtnuMDOpHIvZoYcYrlkIScqTGbY0wfk9vQqnDPFItNdd3PaKUx8s4U3+gHsxxygXkdNi735pF26slsRU95+gWACFCeJBYNlY/BL2QskFOCX+HeO3icK/CEfTC+9jVhUwC923OdtfoFvpDul0LW3BtllpoeceSuYsXB1hBUR+UtfoqCArKtGuDxh1Gc1WoOZcgBiGcGbtsRIw1f3crt5GzlxMrU7SsmX9inynd4RGYBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fe2923-22dc-4b97-469e-08df0e708093
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:47:26.8614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT6x7vUFRPklWqKE02B8q/Td4YzfGf/3pSidIjL13dQuXHnfoNj2UZ05GCfDy59/lwEEuFCdaDIyvEqPSUP4/7SkG7E3dwj6DmDHVAElV8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
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

On Mon, Sep 07, 2026 at 01:07:50PM +0000, Ciara Loftus wrote:
> The number of rxqs and txqs ie. "queue pairs" was tracked in a single
> variable `vsi->nb_qps` prior to this commit. A second variable `nb_tm_txqs`
> was then introduced to track the number of txqs independently of the rxqs,
> since the TM hierarchy could grow the number of txqs beyond the initial
> symmetric allocation. Since the number of rxqs and txqs can diverge, it
> doesn't make much sense to maintain the `vsi->nb_qps` variable anymore.
> This commit drops that variable and instead introduces two variables
> `vsi->nb_txqs` and `vsi->nb_rxqs` to track txqs and rxqs separately.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 37 ++++++++++++++----------------
>  drivers/net/intel/ice/ice_ethdev.h |  4 ++--
>  drivers/net/intel/ice/ice_tm.c     |  8 +++----
>  3 files changed, 23 insertions(+), 26 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
