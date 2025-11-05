Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E4CCFA07
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 09:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA9F402D7;
	Wed,  5 Nov 2025 10:13:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 93524400D7;
 Wed,  5 Nov 2025 10:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762334031; x=1793870031;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8w+8ST+6u0ve2J2og5Ued5vF8H0L3GSjUZI6o9sCWB8=;
 b=KE8V2spJc/BdJmFzcoTYvhn72yqyIB9tE82x4z05IHi+SX9Qyntj8SQH
 UNHRqIF8pW/N7nhwJS1Qa3POWGbI5nsuV1cvpdXnoesV8ZWEadjV4GOvQ
 b8YfqRFM6yXvdQUkwy+knIB7JlEQ2KurTr7wTyB1RYmxIVESoNEXo7Nks
 N24nr9k3ApyIfcCLSwQxcBri4vfp0muy8KjgQrl1O2avNvVQjfw9/n64L
 qYRHCkSdtmirIxCsIPfkfQDqIvdmr8sze2aNfKgYOsJeLacTgjQFiiBCd
 1sa4xEN8QORvuB8JheJsQfD8PHtCGMyHywzDwXU2lFBU1UqEUsclhwiQK g==;
X-CSE-ConnectionGUID: ECOun9i7SRCDupd2Yaiofg==
X-CSE-MsgGUID: t02sYrb0Txah7WeiG65B7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="82070247"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="82070247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 01:13:50 -0800
X-CSE-ConnectionGUID: pj2esBgdRW+hQdE2cKMq5A==
X-CSE-MsgGUID: 8wzznPhvQv2b8J26fali5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="186650594"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 01:13:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 01:13:49 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 01:13:49 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 01:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1z4UC37WVIUhm9kVFP3o+8D4z/jkFSA/RGOthqokSmjXJB/nNivqHqZuxf4fLd6ZlcBkQDx++/7dmIMvIm4BinI1XMTV6ButMgFzAL3Zh+mR5Po7s/LhJ3u2uHuDUnl3uwi9IUxjpV2amvzuKiPsvJP7alSgJ0IEQslYprUivykTJBpoY3uciHTtIdoIv75pxRoZeNYCJkX0oIPbDMyobrgbAKu/jlyOOIV7k5YIRfknzGoA7aPkolemlmA8SM5VdYcgkJWgK07jZeghZDG5w/nNIF9479dTrcsn4KI2+ZM4Y40z0GdgXK1ulY32slr9elyjmgDlcclSRk25TjWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRz+sMmNOghqFRDImb/3avKbwkRP+Bbvnx7CuE1PDZ8=;
 b=PSNaRhWdlKw+s9McDTDqAVqTmntehnIf2Y0EM+nd1680wt2HydJyxUQvSm+p7vSZDs4EdqF4WOHwVWFXuzUgW3F7rogQ/oF+2+3D35ReQEk6cKVcTEE9nOpop2Ir+sk2qRHxt4f/q+JCko4TpCMt/TkQpMeheiu8elKGr94T5XOe43Vn4geI1RYUHpBiYvdQ8iwSi5GGZ3JeycPOgjrvyXZIacb3aucC0WMJTA2bq3tfi5zB2IcwCc2oOr5PUH6qsxlx+uv2P9WJXQ3hiZwDPNoPOU8u+j8NgpzkcU/4jOkN1FKXeHmmG4U5ErLzZ+XBZ+/RrksPlExzf+p6ON3npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 09:13:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 09:13:47 +0000
Date: Wed, 5 Nov 2025 09:13:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3] net/ice: add source prune configuration API
Message-ID: <aQsVRmR5OVpcUxDL@bricha3-mobl1.ger.corp.intel.com>
References: <20251101182934.67105-1-anurag.mandal@intel.com>
 <20251102011919.68783-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251102011919.68783-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d61f8c-5c38-4f4a-e581-08de1c4ba052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jkCNlEFkS0Ym0gUtbdIrsQ93wPjKMPJYcyyf1rtELVFILqAzksBSyWJ0cC3o?=
 =?us-ascii?Q?n6TSBtP7fvG68MfxIo6m1ozzzSLgRzyt8cdiduvbwWCXsWFFS11F0AtTPpSk?=
 =?us-ascii?Q?x0q+eaV5NRP0t5a8tBrIu9/cUIjdU/E9I8F0O3TubrVNjThnZxMxI1pk+oqC?=
 =?us-ascii?Q?21Nj3oDEUbGj69G2jgAcaqY4+yth71UZPtIlNe9f+PGYrP0WsUqsd5nAhukb?=
 =?us-ascii?Q?5tRBdEyfHYMOWI7o4l80KaPrX0aiVgo+05WN2Y42QE1kiprTgzHvShGQAmx6?=
 =?us-ascii?Q?2duO9RvSyV+ZIMP0TZWKIc8IogqML95H4dhtETd4K7qZ80mnVsyo7rI8s37X?=
 =?us-ascii?Q?KZ7l6JMs8sg1dmNhYQNPqB9VzTLnpIbXMh3kcqQCgHPNTA7plm/aDUxkI2gX?=
 =?us-ascii?Q?Wyp2dTMAEoEEDkvBMJJQwgXK0GMgES+LHJwODOFNg1Pp269zgahckwsuLMIX?=
 =?us-ascii?Q?f7b3tSn7efmMB2zXRi8/lSFtRzNzGlIoPMJcFJT4PCzWPFkhHpHeZmLVHyUF?=
 =?us-ascii?Q?2/nyu3cXgcSZCD81/0zXJ3MFQX4W8nWaSxBLy0dZKGFZ/52m38KCkEm5cCiP?=
 =?us-ascii?Q?bGEMFZq9LL7Lh4b3+1u/wxTjppf9dAuHYNgh3BrJNQ7WcXbEelBgn2dRo+fi?=
 =?us-ascii?Q?bkIoEQh9mx+G7sjAtSnVMITJMWZazcOtBM+TC4kB6JTJe9AphZzAo6lYyihm?=
 =?us-ascii?Q?GljuACr+5TMnX2bALSQ7Hikp4qoyqAGCKbiqZPNMvOX7LcQYzRDEuR+VZM3A?=
 =?us-ascii?Q?0i9T/u5Hy9osrCJk22bEulEC0fsmn3pfFIO5/Oo0qB7J7pLHgPql3i2n+1YT?=
 =?us-ascii?Q?YXfOa9RLhQA0SIxYi7Z63b/AquUayqFnQUZMtE7eR827+UwjsborJszs+EUR?=
 =?us-ascii?Q?9cAO3KsBquTORmN6/RMiJ/fOhz6oClDtQo+bldTclJfaqvWO4uPXn4lX2r7+?=
 =?us-ascii?Q?97myxCGAmXxA/+ko/ihTpBfyUCyXrAFPbTndW1R5o631zveLYTtVSsqksds/?=
 =?us-ascii?Q?Fi3FtHq7d8XJDV/CzxIFzlZeBIeuGSOUws4TBv21RvQVPkl7iTQl+n9zNHg4?=
 =?us-ascii?Q?HeLnTL8znRT1bYG0yE0VW1Z/eIOsYQ/Bm1405ZsSB/+wA0E2ZGUZWlYPskT5?=
 =?us-ascii?Q?Z+pUTmak/F/WIB17wHbG33+AMKzGY+br0XEFRWH2qXi0FoJJwIjcN6PKhtQr?=
 =?us-ascii?Q?jcLPTKDL20RBG7qsQNyifx6a+aZX9Sb7InKb/sM0QDZtNIufNagWMevxlDF2?=
 =?us-ascii?Q?VxaqHxHTK+SrZvbeih+UyoxjcWuoSwpk+RbC9y2StRfqKgBofn3A+U0YZhyK?=
 =?us-ascii?Q?xV3tVvjhLHUmFX0Q7CJ9EBKdz7LW0lO2JHN8w4pV1ZVnNwYA7X13xxcNBwv0?=
 =?us-ascii?Q?dfTZr3XGs8ypKdohn9nPePcusO8/B7sCzopV7UhsUUNU1YTLGNWPdHfbKjcv?=
 =?us-ascii?Q?TDp66CzbfN9xhw3+fIgoSJ0D3Kbsw4JC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arrNJcjYNnDhO/t+IEuh2/7xeC4v/qlD5vs7n3goZQYgwIyxWLhf/yqlhHOK?=
 =?us-ascii?Q?nI5kSrID7y7eXMmSrra0/XfRPg1QJKqYq/d7i/eFnGL7RMF/KcPZQe/nEHXo?=
 =?us-ascii?Q?Vk0NDVZ5Qgn1Y/qfDCmCWBZ1eVLorseGJ63mlm1B9d6+d1/lqIGH7H8imzIc?=
 =?us-ascii?Q?D+VhugvE5P9MhclaT5LOqawX22Eq2oSEy7RYfxSSxGilVRDEb0yCWsSIVJzE?=
 =?us-ascii?Q?9DwjjW6LTX1rtpOOGi9MHag8uZTEDojKkj1w+p5U2Om8n0kYY8S5iTUCWZlt?=
 =?us-ascii?Q?HtHMD/xcnpyxEGW6fl68VjAQlGYQyeXPl4AbjUPSKMrxpOhMmB4wU1zVRXzc?=
 =?us-ascii?Q?GCDadUN+SZqdoqU7EEtcmPBsr9CZKg9XGuNtQPpAc2c0lPw1OMGM4ecUPmcm?=
 =?us-ascii?Q?KTfkPuA0jdLbG5ShO9N6RFwPJKnzjpBMwqNXyLS3O9kcKvOKkcoPtiG7hypD?=
 =?us-ascii?Q?LYf9Fz93vDT9L0vKcz+rocp75lMT0VnhEmHuV4+JkQ052K+XoxwVBbzNIR3N?=
 =?us-ascii?Q?I8AFBZwvhEHjfBth3j66S8u3rRdGzZUoS0Alg9B3AvbXApbFAizgxXZnZ/up?=
 =?us-ascii?Q?Mg4LvLa9HQz6eNTIG2NP2yfJAtf4V8R9EfdMcTZo4VYbAnnT1pLct4sTv+on?=
 =?us-ascii?Q?6tGP7tZNv68MXXW8se6uWppbPVviNxtajdE82uB7IgVce1lelaK/lYJxpDd4?=
 =?us-ascii?Q?vbimz3mI+bUo5Ibp9P94iUOW4N8DZI/kyQzFadL/T36A9BC/SPRA/Z5qIxEl?=
 =?us-ascii?Q?HiuWPCwQGJr3PIcL/Pe4DC4km53mQvh2jasOZMYFFIL+jhG60RUJhoCpJRZ4?=
 =?us-ascii?Q?qI5/WXtCXoJNXD0GW0sB3kpIX+DlaqrVG9ICYJWQcRZsOo9/6UKkRdw7E/xB?=
 =?us-ascii?Q?Gyy52y/uY2rNajMqhwm3jIg/nUhOFbTgP5+xHg7AyIdWBn4t+YqfBmlXgii4?=
 =?us-ascii?Q?ou44zuR3SaurYpTLett7XM/E/kSQjkprPadN2YavuCmNTiqEimUaupLIf688?=
 =?us-ascii?Q?qKw50wssvStZZAfaSxvAP/SdAJQTw3WqjsdLuhv/BCT8o8qP/MURwRyulo3z?=
 =?us-ascii?Q?utPDg6OpwtlhBbvrG4UbHIX1qJacoLfxbd2JPYPFfQ1CwjQfjgmslMsT4Bdy?=
 =?us-ascii?Q?CJkwbV+itavx2UkgxaTwkWYSMtEVrS7FhNCsisEWOgKPSneHYyAysz0W7C5G?=
 =?us-ascii?Q?LdqcQDKMkETfDeh4VFPxBFut8Y+orOo3mzLIE4csKYNJLKs6bcIL9oSEkzCQ?=
 =?us-ascii?Q?JyJRucqD91FEnMiTw3m+VMsPiuY+qjC2GYDo/Tur3SK5Ym4khrtyJRFZdF8W?=
 =?us-ascii?Q?tfCnFyyCV4JYG0Yjjk6OzK5bklX9fhlZas+9yFG7S+liwXSJccskXwTvX4Dc?=
 =?us-ascii?Q?o350X7Vz6ejO9hQwnJCIphR/VPwkvrYBhWb5FhJ7pNtoCJ6pHrk0XuJUe8JE?=
 =?us-ascii?Q?6l816KobSdJgN+h/8Xvj1XatIvOIOFcumckT6X2MDgP1oFVv5/mPHjLc0tfC?=
 =?us-ascii?Q?d/LmMo8/P7QvaZgwChkj8fZxyNpNmgkr5ZQkiTmwG/zMSpk6wY+UvjNiVEtL?=
 =?us-ascii?Q?22Kn7tPf35i6I/tdUFPFSyu659hSwp/t8RWmmP44Djt2WIyp/HndFGXPDP5U?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d61f8c-5c38-4f4a-e581-08de1c4ba052
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 09:13:47.4006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1CEo9GyJzVAqj1OEZvY30H53LjKBtObdzpGOvlK8Odnv77Z6WlDA+U335HrGXN+NkIWrrHzt9LonorNsRrRohkTxNZ6qOKvMlBCvbE9shg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
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

On Sun, Nov 02, 2025 at 01:19:19AM +0000, Anurag Mandal wrote:
> Source prune is disabled by default to support
> VRRP advertisement packets in a vsi of ice PF.
> There is no way to enable source prune itself.
> 
> This patch adds a PMD specific API to enable/disable
> source prune for all PF ports or for an individual PF port.
> 
> Tested the following with VRRP advertisement packets in a
> vsi of ice PF:
> 1. Source prune default mode.
> 2. Enable source prune for an individual PF port.
> 3. Disable source prune for an individual PF port.
> 4. Enable source prune for all PF ports.
> 5. Disable source prune for all PF ports.
> 
> Fixes: 6f866eb93e79 ("net/ice: fix dropped packets when using VRRP")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c  | 72 +++++++++++++++++++++++
>  drivers/net/intel/ice/ice_ethdev.h  | 16 ++++++
>  drivers/net/intel/ice/ice_testpmd.c | 88 +++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+)
>
Rather than having a new private API for this, would a device arg (devarg)
passed on the commandline be a better choice? Private APIs are not really
nice in DPDK, and for this feature I can't see it being something that
needs enabling/disabling at runtime by apps. Just having it as a device
setting, set at init should probably work.

/Bruce 
