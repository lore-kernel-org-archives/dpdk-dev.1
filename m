Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E1E7E36C
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 10:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B4740296;
	Fri,  3 Apr 2026 12:43:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E00174028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 12:43:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775212982; x=1806748982;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DNU377Ba5N+5PvaJRlPnYy65gPpt/ExQsK7k1mMAHEs=;
 b=Vgs9rW/vsUPloRejC/P79DFA3n2LZxaOkodbZ4Wx4lMUyeQatH2Y1Kp3
 WgqzF9ubQCK2hr5KuIWmL6zaRmhrvKBw/PQc5NY0ERfuMyDhxe9yOSEn6
 9NoY2AGRBxWA1qd3y4oMTDsz34bK8A1Lc0glved0pHygt7h19ksBIqqbV
 4isPRYnLBODYflFLEcMQsWW+bisWBTWAv5dU6Jg+KH3dlo7mBL1TysiJM
 Qm0eL+ulIB1Gl7zXpw7yT+vMou8vhsCO4g8VEM/IlRTr+vxG63JLahLbf
 u6WFH/eYmgvggAJ28sqL5qAYVRof00PNT8LFPOz6Ql4JpzUQQxSUCbtwR A==;
X-CSE-ConnectionGUID: VeT3bBisSbGGz0eH8KTd8Q==
X-CSE-MsgGUID: iKOgT/CzQD2M6ABLX4iTvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76468550"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76468550"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:43:01 -0700
X-CSE-ConnectionGUID: KHalaTHpTJ+fzbRLQQpY5Q==
X-CSE-MsgGUID: eicYVaWrSMOlGMZIXl/Jtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="227169826"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 03:43:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:43:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:43:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOWd3rkT0Qgp5r2LSlZihS7JcOtRQDt3m69ew+0/fZtgOupnD5tBPTLMCHBgDqSfqg5OhT0IadV3zIJl46pBSbH3C5pIuqcRA4jzf8+LE4XHWNedqp6Lx76oqdRLrAu8oM9ZetUENmh/+MzwEdHtGHWGFJLs6+SX8tPJN30HdnUbWNPO5czSb6QN6GmqebFaKP+GfP5Rz/BGMfUSEiIu74j/idbZ/OMiIs95rot+q5wXlfkAzORIhUReIpTLFg1kladk5g9MxmgpWU9mnAVmL4WCbiHl/LuKqrzLDJcx00NgH1s35lYIwCvL9UDzVIsqoL2RkYqrxJhbF07svnkQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj7qjrjjNMZSchPZL0bSF+iyKhdR4lhQiMB18WYvJ6s=;
 b=XyLqBCj5AIS1TpNyocLVIT26tHzguTv9R5nc3aCwt/w1sUynhQqviBC6V2u00ng/P3kiMc0pMwyN2T6oKREdT/P8CkRUciW420hCd8UFvpRYvfJqU58C645nQe73dv1cJ7IvuS8R7d8zP54Vs4hLI++Z4qGznKZBwFw44lCWuOZKNhaMtfh053vv9siK3TbMeiBxmIp4McX1j17qHyb8JNEuVpPo3RzG2eJnJoTF9NyHOYLSiH/7gFtu/zP3N6R/AAdqNxVlYMsc0ZDn6mFnS3uNzT7W/nfMakKC7gzPZU+vMTu9aj5fMr1Un0qqro3gSwjePK7zelpjsw1XCQbT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7932.namprd11.prod.outlook.com (2603:10b6:8:e5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.11; Fri, 3 Apr 2026 10:42:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:42:52 +0000
Date: Fri, 3 Apr 2026 11:42:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 3/8] net/iavf: add virtchnl interrupt enable flag
Message-ID: <ac-ZpozZp2fvN1tf@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <2a9e9fbceaf98b0f3224de5b5928477b87c033f9.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a9e9fbceaf98b0f3224de5b5928477b87c033f9.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:10:232::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: d4066912-b241-40d9-b4dd-08de916dc179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5mX81yCjrxVenGs+DNrCbh9yy1PytoveTWG1zu07/a7uB4x0me4sn1GVBBfwZNHuPOW0rVL08Kx7+YHKy6ZTuuPdystTwzRhq4Ins/K2hxsoH3OARNzuwdI5e23kw3jYaPQ5R+BqoYOGD7bp5xGkSzmV77pDKC6JZhQpiel9yzGRHH4WmwPg6r325O+4dIGJbp4SfFHUBOnslrRg8exf3MJhWCVNI8yO/ohcRCP2xZN9YrKT/jvw1+ncLydha7FXNtnv9Xrg9In+SBvt3s4pCPONL9BXluMFVtdKtZafJF/3bd7ININFJLpadw2Rdbs//pcuXi/VfhRF5KE2AQBNAtGf/t6X01Q/7nPjF5zhRtKB9eFttoWCto/Y3jQ82AmPL5Yo5UDYRuhb0z8CZl9BT3DUU7iJ8OiTQIDyneNI1e7N5/Cx3uEpIdTyoyv5Wk4MLdq8laPaPs5M0dGexb0K31DWZSJl7X265urUySIK9Dj7O9EV/0zO7y7SAVYrZZMuQEMO92a5tikBfNVQq0uKGqQ07hxzV25fSjO9g6yCZsPVzWxANVBgbgmIq6U+mURssbfZuuppfsmM9eg/P4JnTb2fMeote/3NekmLlTKFrRs0nTjSHhCJYkUM8nnh2xZh4r2apoBcQKKK8sht9U0dKmMlu84QGPu61twPFhJM/31td5jz9iCA9G6lcdZic4k7Dbrhcx9lfXFsNyFsfzoAc9xi7cmxOWpd9/NP4Y1bwc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKe0ZLEqG52LYreLAQ75zwn0fa2gOSD/qkhXhJslsbZ2CY6BfcZ1xOIx/8yx?=
 =?us-ascii?Q?OxnC8ioUyQDAfe7t5NRLQuZAktK7HXU8Oe8yeSgYOXIrsxgESLxfJs3CikmY?=
 =?us-ascii?Q?QrHha0gqOSKT+DOBuhU3hedbKh6ArWB2jo6eOo8Er3L4FhJgnNHU0NQmd+ii?=
 =?us-ascii?Q?DGdVExjWDW82QCUB8+rVlw3hmOYCMkD0f9yFxAifGQ9I9ZFOGHOOi/QDtHdU?=
 =?us-ascii?Q?s6Er6cWTs3A+nTmcjrlJVYL7+6BlH2L9MG3GBeJTvU8nNQedRd/pM01GC4nv?=
 =?us-ascii?Q?07FYKtDnfIfsx7nniCwDctOvHrYrLZdVxUTAo5m/+mkpyYFqRJat/S/Qb8+s?=
 =?us-ascii?Q?UMwNGZxQeROZbCwAruJN5fwMI/Cs7ZA6VIdF4+FQH/cTjhXOUZ+pnh8Bda98?=
 =?us-ascii?Q?vMKAtooddCS/NAUz45Ttc3CFUXJjmEbXfKrdImGpX/e11VD4LndxGamSBMEY?=
 =?us-ascii?Q?p++fmCOLI+7iPMCvs1Exky1Z2dSsF7QlbaPvleNmFo1QAgaNyhYW7ECdZCyr?=
 =?us-ascii?Q?YDgEFAejGsG6zBx2P7qEHWLGGieAVW9slc/izVdyFSqXpyns/j/g53mguY4q?=
 =?us-ascii?Q?Sx9GsFhAe5UeOzHFt+9G+RD3FbimRqUHDRDAfNOGvcNPal2KE18FMZWYLYif?=
 =?us-ascii?Q?CWsJUmf5IqLccG3jWyKzGUDVWYSwGBZqxmiMziPCv0QH74ls+In9p9ylDnXt?=
 =?us-ascii?Q?Ei7j+2k08EthCPRZCTt2J/Txa7mWTSEWezO/Wi9zDc3etv20NZtfbCC2u7Pv?=
 =?us-ascii?Q?M7eFvb5suHd8AwKzEH2tlakCLMu6VEwO/ZvRtW0VHPKSu+I8UsYOcZ8KyaQO?=
 =?us-ascii?Q?8lGIAW9X/r02T3FLEtJiC35mFor4i09FzXjFF53UlsOb6ChVKrzk5/jtri7l?=
 =?us-ascii?Q?CJwM5mHVYqfMLTC6AY8fyNR6N4UwQ/gvOUh2Rtf2UZ+tLZsSIT6i0dAg4/Vl?=
 =?us-ascii?Q?rL1wkvuzQUSNHfw4+fUW3ALPkafHEdkTe2epHlDFg2h24qVKDiL0qMGkj4Uc?=
 =?us-ascii?Q?/nGDZCrs05G8Ip9FAZapBRsKyrgncCvIg0Mh55i0a+yepy6Ikrujn2g09hNC?=
 =?us-ascii?Q?FM75g5aZvr+qF1OvXrS4+DNJYF30hNyPymhEDeOPc7AkCKZynph9CKYCZgWQ?=
 =?us-ascii?Q?SZMBKP1p9zlE+cVjQRRbaMwdedTRVFcScE4ujlDZgQg7Q0OwhkX0plYyIY6C?=
 =?us-ascii?Q?ztSweqQ9NoFHSFZ2AGq8GsKTjm3A1SjawT9e7fRgR9i0OnL4kXOIyrbkozAY?=
 =?us-ascii?Q?ehjswYc2zROK3I7IeAlbj2n4t7ULOBU4e4lbHdZ7wl6+Oaq9HLMWclBbEYoA?=
 =?us-ascii?Q?M1Uamk0NgZ/bcZnviDpZ4p8QGQjelBbmY5JaSvqH1WELQPsy5iQVgr893xM7?=
 =?us-ascii?Q?ki8RZifbJUHDDxWXaPbW/ihayGE87TFGr3vHMo/HK/f0yT2uwz6qswleOx8b?=
 =?us-ascii?Q?hx9UDvyd0emcxdtJt/IGXjC45PiFEITbKn5+IfUwQFMI92pvXyRkcVRgO9ff?=
 =?us-ascii?Q?nQ80YT7owQ12EbjVp495DoCf0sjoAkHHdCVmWU7AsS5ta5nqkiZNBCFyZiQX?=
 =?us-ascii?Q?aqHzjhisCupFXdCm+DBdVdW/NYFmnmTah2Tok2ZM1/dxrQyrQuDQL4RwHBj0?=
 =?us-ascii?Q?8RVPE89aGXiFzCS/WlFIwVgdKWsyZtBdVaJpo0IAoEwZXWBa1hpiSLG2XaAL?=
 =?us-ascii?Q?rjTOKDXiMcpGaQxHDgWSmUo6DJctdh/xWHj9aoEdJbN5Vmo2JyY9cqbEZKor?=
 =?us-ascii?Q?jA1CSuN+q5+f5t9WypwhjEWckdlJweg=3D?=
X-Exchange-RoutingPolicyChecked: X3nHf15gk4FooxkNperdYLf6UpRtT8INjVY07libxpAnYrbVgEeA+JTW+CkQ5qfeGAFVsdQHL0PhavcwRs0PTL3/3ZIbWpUWNvquhewhWM7oxSbXgXriy3K4dzi1x25EPz+bwPj9dWjKctBWpQXXCOH5JtjPnrNUXEWZUOQ0gEoudsQ96vvmVYlnXLTJgYP8uM/z8pV4WrTCMae8XJ84VYMoFOtJEJzvMARgqvqD9PAC3qc472UsDnZiXGgIZ1PdbYa8VUbgnxQLcLRlRTcIGwDFJrzZin/6Jm9Gz/zWZ19smxCtZ05uP7SsYcZIyhA4iIHqw4SiRfBiktWub8XAnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4066912-b241-40d9-b4dd-08de916dc179
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:42:51.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOQSalwkHYNcog8Jo/z2opFmaxPqiP8t/w6Np7m/Nl2kfkSywaocFG9l/GXD4KCgw8EHtutTbeJ0o/i/5rBL9RX0B95ev9OUJZ/ma0isU2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7932
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

On Fri, Mar 06, 2026 at 10:58:19AM +0000, Anatoly Burakov wrote:
> For some functionality, we will need to know if the virtchnl message queue
> interrupts are enabled (i.e. if the new virtchnl messages will be delivered
> into an interrupt thread as opposed to having to directly poll the queue).
> Add such flag and track its status during init/close.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
