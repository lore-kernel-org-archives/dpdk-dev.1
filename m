Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46369CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 16:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4E640658;
	Wed,  6 May 2026 18:17:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6FEEF40278;
 Wed,  6 May 2026 18:17:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778084236; x=1809620236;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FF7/7hcQZXFQfCYz9o3wy3k1faoHTt7P3MFkmF6KKkE=;
 b=OQ1lXFqcyot6eRRrWDnv4zv4qtNl8sn38C5teoKIjh59qZAsPkJc4FIs
 pLdzVuhCrs6omNmmKBGFHUJj/svaBNlDOYADL4huTZfBoMyJhm4SY5+L/
 Y5TiXIxUXg9jnRY2wYpw7VMOI6bRiyq4OUOHE0MZhSVYr6GzcmkepBtYh
 MMRhhqUB10l00CAKqGJgAxisNstROyA5b0oJuowrUwYEqXNSAD27WDiBU
 YZeJRktr890wHPXbRwkJvIM7IWHO4XcMV4/NQ88vxzBK5bh7eCW/OAoR/
 zUh8nvBDNWJJUpbWhCYnQWVxpqd3hSIGHxfgn7ymRPU646SqX23NPtI4m A==;
X-CSE-ConnectionGUID: s/vLiW9YSwWKK7cd4+/ofA==
X-CSE-MsgGUID: nFhhOUo8RjGqErQ33V1sig==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82643129"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="82643129"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:17:14 -0700
X-CSE-ConnectionGUID: pKgyOwlHQ62ezQoLQ86Gpw==
X-CSE-MsgGUID: qX41DLiJSQqiUTIaj/a5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="241190076"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:17:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:17:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 09:17:13 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdAu/+8uclDGM4AdG06YsRssW24oBz4jCYHOV+GX1DC+9181FO8wvN7NYXpV5jAB0nxmoRfDJXDvL6yr2u3o/WRT/frKWxaSSbBRMCZ43AaJz3+08BmLUdT0zgq5Rd7aRlIsDXXn/+7693TJb4YSUAPIEGB29xgdUjl8ZytahhGC71QGQN7nvpnA0bzHKWw+ABKGUp6YBI2yz9F726DRuFShzfU8pNZdtLt0A5w12fuqkKO8BDlaIaOBi3tBNPHWlFDRJ+guP521kPZgW9Joa64TDhFOvTs/u0skymI1qx+6wLKNjbI3QXm82rb7GrPu3egFBJzM5BSiSxU8Ep7RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD4YYQkC8mI1+2Nv06GeLTp89XF5pB66z4w4R+BzFBk=;
 b=I+haX/Jb0NeTX8iRseU5LWovQFa4simdMWflbGCwhLBSYHOXvMFa9dTd6Wm6r/x8Q3LC7pFFb0iIgteKE8uDgkSo8VrnPq4uPW3+Pq8XMQycdxUAm+R2+VgM75I3Qhis9/KrlifWgc/UCKN5I3en9+xJ2fXrW1vdBXbzn1I0XC0vfL3O9bMvnVQuexDdzS8GG04635JlystETGUu1hTkQVvV9iCQiE/XeI3OKTe2rnl5U43rXPFGeqqxtLhLpvdv/E8Gb6QDSpQhob4/ZAUNi3Dgjp/TiqVqFJgtMcQfEpGeCzOFj1WzSWf6X14jQEfyD9jZA87eFlt9iRd9SSSBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:17:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 16:17:09 +0000
Date: Wed, 6 May 2026 17:17:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: fix good octets CRC adjustment
Message-ID: <aftpgK7oMYufLKK8@bricha3-mobl1.ger.corp.intel.com>
References: <20260504141524.114604-1-dish@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504141524.114604-1-dish@amicon.ru>
X-ClientProxiedBy: DU6P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddf9467-0700-4b24-8e42-08deab8aec7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: dX03op6RGkqjnSFTfTmORUoh0ixEG91ELv1cXi9CyYwOMAH5LoPabnedxX2BfSMk+XGdJMylxseXrsJwIUcp0bk1HhNbdTDPixjIS7zPnZu5RkseOSsRiEGJfq5ZuD023kPCvHysvB4pb9Io5E4+KVaF5RwNB4TjkATYuMavsJOLlPMDd+O2iLWPwmvMaNq1qBxg3tuCtabd5+FVxZ3+JcIsGV7BqMcuA8GQib6E9NNWCPtG7uszxRydChAF/bXS9WbWY5i3DiC0ICOuSVwlWP3c5vz5FI8/BwMr6mDoUDhBOuOGQ88T9Bj7d2mureHS4Mh4mdGbLSsWJZcwKBKwBsGpvW+qTxb3xE7A1cA/e2jm4JsEarTRLGs2r3+4ePzJnQovcD1REbAPTymyDBoyNF3pWNgcnZuw3OpoqYWFOBYOW1UHQd5xANBrXAcZz1//jzN3O0Iavk9Dma0pER53Sqpz8SZmue7q9uoB4jzgS1mRqagF13xCCOi8Hn3zAdvMLJ6f9FS20jhtgkNpks3bj/jU7q6/9GvgcbzxzLtiexIzvVOtUngdgRE2rPd5EYdFs8u4b5SoTfLsQHQuWEqwCGxtcu0MIGf5eYuWIAEy7ZrdzQhRc7Ortw83m+HZdJa7YrNXCrc+KATonu32yAQ7m+IQhEn2HWgxmNikC0dqj3k9kSNQNNUJWSgX4wJjNK1I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+bWGDj3FzUbKOQUCAVmXwXBM+7lBehMXop2qVlX7aOzh74qlXLgSJfOJ1pQ?=
 =?us-ascii?Q?qqUa9h6EuA7gKgHDx0fKfvgB4kp4u/bOPYyu2anlCYcY3mL0aOxPpnBDCf2o?=
 =?us-ascii?Q?RuNjIul+crm0/cE0BGgnT9YkkdmZ7IU1IBFr8NXKIPeQzz24WXKkgEmJBSua?=
 =?us-ascii?Q?aHcak2hLb/2jaYxx3GbQ5D6c9/2lNJrkUwmJc3OrJVdzIWhE7W4CRDHPVsAB?=
 =?us-ascii?Q?CpAby4JvF1KZTc3Scyf5icV2zrcIn16ywEtOoJEOKrkIHgBDybb6Ekyc//LF?=
 =?us-ascii?Q?LU7GGtOUqiHgugVlXLDpfA6SwqfHXhaUCfpkLA3A3J7pd274CAQK4kVuCy5w?=
 =?us-ascii?Q?mTvDPJ+P0HV3d3uUB6KAYLIY0ZJXxM/P2Yl67u469zJJ29DuJYpQ7ir+L85H?=
 =?us-ascii?Q?pQHGeZp616QpS9Fi+OU5JxGZr2Jc6OYptzr+3Rc9R5qdMuWUsdGG/1EIbPCO?=
 =?us-ascii?Q?+8CDgyVfClrZ4vBulpJMhD6riAGchZG4h9b/sDDOzGT38E5TlPpeRWhWqWpr?=
 =?us-ascii?Q?m3OCO0sirxiTSoNTptv/V+z9upAKNZkVM1JJxpPmHkUJ2HUaCesOSkQYdPc8?=
 =?us-ascii?Q?pclcJjYN9mYKG/gcFh5JSa1YpamN8e9nn/AiykwcBuvqmi85e0Ipp5Eyj+gk?=
 =?us-ascii?Q?PwDgO2nn44EF/2RFVXKDeF0jzQGuw2lpZ+d8WXDEPNAASFgaxlZR5C9orR1Y?=
 =?us-ascii?Q?OZn8VxeijjGb02KR26BLuobSh/pcbV4uMjNxdkfcFeuCBEu/nhU/NOVVOMaU?=
 =?us-ascii?Q?Jx43tHWapqS1kNmRUSGvI2in1lvyKgK90r5eGERWM/xSEY3gtaBgmmL3nrbs?=
 =?us-ascii?Q?iyRQGdlZX2hZS6GwBSsHSynsGyJcnbwCtoFy4nwJhetgy1S62xgpmTfcZkR2?=
 =?us-ascii?Q?86auE5Z/QWjF6Q7M3UfpWWCGlkCM068v/5G2oQPWCaOIG7LnuVrh5aNayXec?=
 =?us-ascii?Q?nHwYO9lqrviGtwksLzXoy1wwbVauJJ+Jbakzy8yZFGndLq/i0PRao9wAgLzn?=
 =?us-ascii?Q?z76hE1LC1uHexdzYiWXXbOsz6X9WN489aCb0dvIZF7NPIzTL0XpoSlV+XYMt?=
 =?us-ascii?Q?74C+fp+rtnEPdEWuFotSy33qSzN9pYqdi9TFp8bCsQoSRVxfsGKYG+VdIwMR?=
 =?us-ascii?Q?u8fVphkEsrXM8VaN1aFvKaBXODBAbmqc7gOU2Ba3ZH5kLNHJvkvLV/kgBp4p?=
 =?us-ascii?Q?rZQ2pxo+y2c96ha/bDXpkZMHxImr+dSoBJjbftA6yAMZJbj64KMqvAtjjw7z?=
 =?us-ascii?Q?/B+myCsl5SkfZUw4wbB+8l6hrqy0grsEoGyd44jSrKwYdeS1CqIJwapEPsgu?=
 =?us-ascii?Q?Wy4bam2uBkyaf9VpN2gdPFzM8e7JoRPw6CihYoutUq68opygNai4I0EiMGtv?=
 =?us-ascii?Q?+Z9VyT2ehtnr2Ps/M/U5Suj1MpmN4HRpDl9CHvu3A0mZFijKIRX2Fxj7RIub?=
 =?us-ascii?Q?0+lGGjGiRI5T8fgdmgjmySnYj9szXwuiFH0Tt90xzPvciwGGUHgJIB+u5kxo?=
 =?us-ascii?Q?ESaWrEEieUK97DFs5SEQihaZ8PiqOWeJscGFLfN91DCdtosrjpXNsunfxRJE?=
 =?us-ascii?Q?0O/NToM+jlOIeidQ9u9CDzWAmaFmb+cBdqICU6GroB/xLpQNNKgxpD88/A7t?=
 =?us-ascii?Q?vBEo7YlmBKfM64Trr7fs39NWO9S2h/wy4SGGhRCTpY8ayrE8u/a+3GJKoeWL?=
 =?us-ascii?Q?RCr2uPTaNptoruEDkC2C6H96RC+U6gdBtNxigEycBi8N07XBESngMq8Zgzc5?=
 =?us-ascii?Q?CeSuFf0cNPj3TDGT0A5vewVS6RSZEkQ=3D?=
X-Exchange-RoutingPolicyChecked: NyVm98omxlObdnHScFZ/MTi0KmePLwtmuynR9SUqeHgj78iFb9LHFrBXHPAZ9uu9QQQztlAb5wVl0EiHOt+r0EvOI3/pk8OFmK+LEcCCTj78KmdCS+hXIel3HTtdbzJDWKljGno/KjQYm9HG2EkCvyK4hDBBsBn5tlIlQ376LKHcjZWwpbwz4m97wMzBwZ4P+63kX+huv1g56Ei5cxUTrgDMkBrYJOLdEziEaBtLn+DeUIDM4vU4CsIvSO2GGZY6EkbJzSRZooNa3sG65/A5NlskPG34CjwblbvxrnMgCP0FL1rBD9K21RTzU/bzwmdEUi56QAXvGg4NSuxXggrrEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddf9467-0700-4b24-8e42-08deab8aec7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:17:09.7446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC27O6j9xccC0EvpoWQFIfwwoIPqmHj0ObUKq8TatJdVzdULTR+4PrUuryKp1P44D2X4cYx/8tiBS/VtIhidh4Z0IJtRaTd/FDYEyjqixLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
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

On Mon, May 04, 2026 at 05:15:24PM +0300, Daniil Iskhakov wrote:
> On some devices, such as 82599, GORC is a 36-bit clear-on-read counter,
> while GPRC is a 32-bit clear-on-read counter.
> ixgbe_read_stats_registers() accumulates GORC in a 64-bit software
> counter and, when CRC stripping is disabled, subtracts the CRC bytes
> accounted for each received packet.
> 
> The driver does not read GPRC directly. Due to an erratum, it derives
> the good packet delta from the sum of per-queue packet receives instead.
> The 32-bit QPRC registers are used for this purpose.
> 
> delta_gprc is used as an accumulator for those per-queue deltas and is
> then used to compute the CRC-byte adjustment. Keeping it 32-bit may wrap
> the accumulated packet delta before it is used to adjust the 64-bit GORC
> counter.
> 
> Make delta_gprc 64-bit so the accumulated packet delta and the CRC-byte
> adjustment are computed without 32-bit overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c03fcee9abbd ("ixgbe: remove CRC size from byte counters")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
