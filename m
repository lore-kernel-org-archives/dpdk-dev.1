Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B450AE81A5C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:14:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E7940296;
	Mon, 16 Feb 2026 18:14:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4688040289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262084; x=1802798084;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=p1C8ckgxatxJSQxedvDhXmTEzOmyKf6MXBl0tWt0hyM=;
 b=RBNVdRr6gEkan/NQycR+y4tWw/iAObIzz4CuDQaOBSb2iELwbZ61NZYH
 6W017GG4EbZRyz6haJ1PuT2zncHRXjkzk9/6PwaEj6P9sbgqDiQjxAWmT
 C3vSYq0pa1ax0co5Ofare9p591U7y1b+vb5FhZKqCFI+zONeupBjiydnf
 yZ1niMyRmSBBnIx687WLEM0S69nOnnEk7fLNUHzZ8FJfG+VDabzOQmVhv
 Sd7nFWbvx519qWL4bmAlCOHS7XKqozKJZAXC8lD8w4LNDEBArI1Qp3sQV
 i01c8oRUY0RgpF9GOXGgJDDe0gAud+KcOzczVQ5xibpXo6zn/p7EDS02o Q==;
X-CSE-ConnectionGUID: YnONDRcIQhOnKk8dyZsRTg==
X-CSE-MsgGUID: ZA1Un/94SEySq3Zr5ezH5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83068511"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83068511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:14:37 -0800
X-CSE-ConnectionGUID: nimbbmNLT+iHpl+UBhKi9Q==
X-CSE-MsgGUID: TBuYU5baRSKEuh1pZdfuLQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:14:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:14:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:14:37 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq1TprG4DmKa2wKmmy9XNCQ8VhChAjYOGgmApo0q4xPbiIyOoJTq91S1GOxk29cxlSw4jsiaH0/GuxTonlp7uq39BpD+IS8/5f89/B7PkFmQsw17KIJ4RN4kxREDvVYKFnPVi9MQy5P/ftIZOfgi9iNR+omvjEryQOqcplVYbcQJEgEb23fffoCWKgCRRyO4wMV0tUqUBRcMPXd3lY+YMsEazScA63/qGaImIpgL6Q9mxeh1QyQmf7m58RiLYCDn4IT2HQnEZU5hQgpNIPvFOCsYvtdvuPfcbZJ1g5BDjV0WVMwQSumXGpF31vSr1nCU9JNWJkE/ggJJDawt/eH2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0c6kd5TgVH8m8ekD+PKDRb8mLwYpjGwShfM968hKxY=;
 b=TaqcLEdyTuUA/EtQ5y4C/cIwaZxWtGL35yezo4H9I73aV/sfffImH6yycjvglDVhqFI7t+DiRkUNt0tgjgBPEEQhwBxvBFsdYJczWanjsnGA1K46Bh2FxwCAkCIHILFDsbrxKP5Jx7XlixvRivgrEhjgAwtBN9OfJDSGkT9udlyYkQqIVr7m2V+lCXWCB3a2OoCdhasqQo4VYVTOnBEoivultRVio8Kah79jvQKqfzg9Gw3gxcFUDtv99Lhp35GW/HU2YouJtbxYV/keNeCUKh01g6ls1PzUK6tIyMORYKiOANqzEHRZimhZerxW94EN6aFZERezjKop1HkBwBjElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:14:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:14:34 +0000
Date: Mon, 16 Feb 2026 17:14:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 11/27] net/i40e: avoid rte malloc in MAC/VLAN filtering
Message-ID: <aZNQdo2Qf4qIdOpR@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <23db78cd50f33e2a7d701e240972ae93b6bfaac0.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23db78cd50f33e2a7d701e240972ae93b6bfaac0.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: ddad7103-5482-4224-adaf-08de6d7edb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fX9LHR1l5qvchGoI0NCpf7VZqTF8tpkykkPLbVIpeOA5umQLDJs3EwoAtEog?=
 =?us-ascii?Q?tgvYG03xL6WNB1tCPUPWv6QQGfAj9G7vPEfhZZaO3+TslMkYeu6kAMsldbju?=
 =?us-ascii?Q?/xbnxspAwjkWN8g6Y2d+dOxclgsK2fJdlo1oeCNrLJNsGmchHw3SCsQGqaGM?=
 =?us-ascii?Q?Jw/E3Tm8rV78VcYTg/OsCMwF8GI6OsFLNP1OimHsQ8IgnYnnZGURkR/SY6nG?=
 =?us-ascii?Q?r4SloRzOrU4fuez6u92qnlrozOwy+0JECsFY5z3o+lPCHLCyQnmVDZ1c/xaD?=
 =?us-ascii?Q?CmlsRbnTRojWPi+9SxRgOsZX0sH9Fu3jY37YOs6/ox//6vRebaWV2jQQEsaC?=
 =?us-ascii?Q?DZo7ZgNDQnONbY34cL+YYEech2dA1dIc8xNrntzZyXVJ4G0d2cX16qDdma9p?=
 =?us-ascii?Q?RKK/+8OOPt8hhg0ET8oxgBUjNBdxOQnRNjwFrk6SPxxobRjeOPBQxF3vvG4x?=
 =?us-ascii?Q?SDQVCpJo5qzouBU5yKbO8ULQ3TVQWwl8/IXnooFjFl0islnpSi+TyxSbUmPc?=
 =?us-ascii?Q?2vNkb+VwPMbrReZaSzAeXAS8WJ/Ukq5m9xN8pVJ+QKx+RFBHUI3m80iJNeF2?=
 =?us-ascii?Q?VCw/kx853RQvmZWIeuzTlmES8o41dqp9ozpDmgPihkecoENbc6lzWXvvjcTZ?=
 =?us-ascii?Q?cPYvrgNqD/tAEo7AzpNwrhtWp0QGJVT7Hy9lYfIXasy8HRyIwBAVfHIvmmOJ?=
 =?us-ascii?Q?AaQ8P0L2JiufXvlPgl+DMDxEbTyp49gkSZ4nGmzIIIpnoMtvlnrs/N6L2CMf?=
 =?us-ascii?Q?nviDU5J0GsJonqrMd6vG3EYvEbqz4uz5Px+ZMoUAt+PTj0voJcbJdI5BbiO+?=
 =?us-ascii?Q?i2eMRe3Mu3wdzuE5nnU8HnfKUN11uz4R1O8AZQbcSkNWa+NjkzMAPwn+4NwC?=
 =?us-ascii?Q?NlMnDPwnUJmy5gV/5gsudNwuvD0jq3EEmMzJ5MiwMYRm5wPolF1L3KbBnTdP?=
 =?us-ascii?Q?JXT2oxPmMM6ccnDo5T8bkszr1jHFt/qqMlItOwpULsTdTDb6szuCjmxdw5JE?=
 =?us-ascii?Q?sq+RfR66nvqLZnUusf1YqU1LZyFXF96wN0JyB8kYTcqIIOjyM0xc/KlDPtxP?=
 =?us-ascii?Q?2nYgZkqztApv9EZh1Zc3VMrUaX0psJAc9ISGyPySQqCLwrlRXgdjRJM3af/A?=
 =?us-ascii?Q?qVGpyMpI6EtCBY3KYRou+HozYEYLnCvEbmprVwwwfeH6pr/a289pLZWX1OCV?=
 =?us-ascii?Q?ecBQPtEZl4SL7/aiJgrm3L1kkrZUTpOmjJfMxNj852mrAexAZxrjVtOODV+l?=
 =?us-ascii?Q?akUbOPKNvFAF+QMxP25GXFXIGIZiSeDnQWxQ5lrpw6bMImq2B71TapayGf5e?=
 =?us-ascii?Q?jJuE/5vmdlucmN2ZoL4VZCR8wCdSUHIyQpDLiCCihEYPAKRz05pCWG0sfUM8?=
 =?us-ascii?Q?WzBXED0i6VtJ6u4INHtNu/FXznB2913B85mLkOStzHf6uTK1wRcXQrxfjFa2?=
 =?us-ascii?Q?2+ZlCLMqTJ2NScB/ZmPo3Tuuthl5vtiosnGiai2FDjM1Lcpx2qVtFUH2NLdz?=
 =?us-ascii?Q?Bn6falMSgm8+RXEn7chGdBpiWl+wbD/AIxZ5nZwqm974nCWYfY6cnDUNVXZY?=
 =?us-ascii?Q?8aH6HNnUSDFnpBufTAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8buNhB0GBrvfzEFaYwdvURhbJsQxo2aFLrOnoc9qR7nz29MZ2ecx6RiVJLRn?=
 =?us-ascii?Q?sGYHgNO2iRVILlt/AUFg1zzAWKQasTjHlgmchz830VIjBiUtg9eqS1TVMu2F?=
 =?us-ascii?Q?Ixnc3CCZzZLhrcFk2HZ3H/cNfxEki2tpLo1WlyPxPC4mPRaRKQbcQDVDNh5x?=
 =?us-ascii?Q?RnohANxad4elwoYUvbLY27DTMqtOBZqhiv/aC70ZT8IKQL7/n5ussBDsh1+V?=
 =?us-ascii?Q?Sh68wqHT2WjU/DTyKEL25dCTkMiDlZE3Idn8iliC3KLYcgvsUBS5camziIt3?=
 =?us-ascii?Q?Lix5PJyaklb/+5l7L0zvRPOaldWl3qD3x7rAyt2bGSylg/zTc/fBt0mK7h2R?=
 =?us-ascii?Q?RKwudBrYX015dvED/GFgHJkmA55k3z9WQaA0BZMvH86FzOU0qOS0g3Oy01HI?=
 =?us-ascii?Q?8Q37XkfUnjuWISV3QZ8wW10PaCqeaaLjelNABauK9CwP+X3/jYxK65JH52kO?=
 =?us-ascii?Q?VisG8JZtJfVQbu8KUxz5II81+UN/o2DZup7vUg8F4y2GVsKzDLfa9SsY16lK?=
 =?us-ascii?Q?P9v85T7taPBcurbQS3s64cpqhGJjV9viNIX68r1ltUT/mijHwqtoBMHUllq0?=
 =?us-ascii?Q?czDUOsT2yvnCTELDw0FiYYRKQf98YFZRnKfNh0JI6NWKcL7lKsoZgabZ79ee?=
 =?us-ascii?Q?yQBJEcWKeRA4MtnUHW//LsMU9u8UL1/7230HHNZ6KFcxRF/mobtqU2owsHkT?=
 =?us-ascii?Q?90aSbJEVfK73YVR2/FH//VZYR//9o8MPpPwts7M21lEjv7F1vCBrBV39n1fK?=
 =?us-ascii?Q?M86LPYi6QXYCo+JCcFOLh667QKP9IwtLbXJ3aoPoh44D7q2URf+TN6YvbFUR?=
 =?us-ascii?Q?R510WDSms2AszWy1Y8aC8x9DJbhRL4gyqiXZbvy4WEZ0L0nV6utbGuIIyDYs?=
 =?us-ascii?Q?2yHYnY/A6nelzMBze2IN7jHogqO2isPm9ndEmKjGvDJ8VbctpG3XgDuSco2t?=
 =?us-ascii?Q?917eexlnQFCyNt9CE66EG4hHiwYiiv1INFOjvFPoYiCoUJDkHGIZu7Ic0dY4?=
 =?us-ascii?Q?sRhLWMmOhBChG2uDukcYvhFzFPKRxwPx7SXqyKeCAZx2Ebw2qWxHMsidmk8d?=
 =?us-ascii?Q?N0hyQpew3befLW1TWDGEQRJAmjKvsbceYR9A6xiyJNl84yh1mvSd9PU0+Hbk?=
 =?us-ascii?Q?4Q9S5yjut+lnM97roXjHtdNrjAysF/rDcGESaAU15Eh7ASWAGFyyy31W7lES?=
 =?us-ascii?Q?+R5DkO7LAwTbCnr7n3ir05YiagkrBxS/2Ji0OWylhnMcW7Mdy+EtZXuudEh6?=
 =?us-ascii?Q?OMEzycvex+8OpXCPpRrDgBjqjhADsJwlcGII/wz/GTWr2jG1seiMzt0pvOZu?=
 =?us-ascii?Q?S+hh20No5gptcoZkNMOlbU8Z5//4EArP/mjgfQCIYjkQxCO99Cjuf/CvmqJT?=
 =?us-ascii?Q?CDGaM9UviDkBJaUrFqpTzNu6mNE5TAoM4/+0NsyZSs2A9bbIsWTrdStzryJ5?=
 =?us-ascii?Q?K5R7Q/DTeN2ooFlBhATZanilzviQ/2ZnjPE3IquyfsZCpZlbfgPgV0R8hYpG?=
 =?us-ascii?Q?2zTtrPnsz2xqzQTw4Ws21CF16j58ynfSSVwgaWRAqeYB1dm6ihOs9Zs8AQ7J?=
 =?us-ascii?Q?r+MCV5mlweig3kQx2v+zpLi7XtTDsSl+gkZaH6ix4IqjB4OkMHdb6JFeFuSR?=
 =?us-ascii?Q?bV6kCaEa9eN1HQ2vTP2UVecy+5JqzUf/oA4TR1STZNOLU16Mekm2XA1TwnZz?=
 =?us-ascii?Q?BANUAQ6j24qmGz+VTmUGimI4S1k6P3jm5eOzVbD/PMg6yoDMzOafawp/+g1J?=
 =?us-ascii?Q?tRJSaDyKdiCs/948gL5Cns8H4z/mk4o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddad7103-5482-4224-adaf-08de6d7edb5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:14:34.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUqsRMh/pir9LWi94PjivIve8Y4skncOp5w9MySavivLnTtHYIqLexpUm1XUS6bmH2YrSwDXEn1pPOcyrpm5pw1Q9/0vVYvPXiflmi55P60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
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

On Fri, Feb 13, 2026 at 10:26:22AM +0000, Anatoly Burakov wrote:
> Currently, when adding, removing, or configuring MAC and VLAN filters,
> we are using rte_zmalloc followed by an immediate rte_free. This is not
> needed as this memory is not being stored anywhere, so replace it with
> regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c  | 38 +++++++++++++--------------
>  drivers/net/intel/i40e/rte_pmd_i40e.c | 16 +++++------
>  2 files changed, 26 insertions(+), 28 deletions(-)
> 
As done on v3:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

