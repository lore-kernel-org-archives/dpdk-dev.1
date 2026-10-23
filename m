Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8FE606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OElrIj+Y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1768340276;
	Fri, 23 Oct 2026 16:55:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 19A7340265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792767348; x=1824303348;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LJ67Fl51gtnpYQ+qH68uBjurKd8eigq6D4e+prH44AU=;
 b=OElrIj+Yz7T0WNy/fnDzHhBR/9SdgvX6BPEM5lqp6StfhDd1XywiMCuC
 ERsvMp0GIYUxR/pEBpywVF0Y3K7xtGrV1kG9vhl7SoMi2UxkP2amWvw0M
 9CoArPI0FW3W1oQG8mpprUrPl7T4x7a98GZ13e43AWdWNI6/kukQnUz+h
 epkgcoFfyxx0/TgBwiedtdLHzzMg2AyDQrZQgjktUqW9i5QnQ98Egimvm
 A99XIzHTLmTHeQpIE9t9wzadZaAvR2uBmKK8HZs1QvPRDiZTfeAzfsZsr
 GTKjRJwowc0PhIIfpsmcCTDjhd19PQoAXM8Lnf3yRsX1FTAjMxSv9Wj3h A==;
X-CSE-ConnectionGUID: 7tGk2MsLRrOoQ1ExazrsCw==
X-CSE-MsgGUID: ABVh7lp3T9WdN/X0RkWw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1539882"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1539882"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:23 -0700
X-CSE-ConnectionGUID: WDABfniFSVuX8HYcL3GV5g==
X-CSE-MsgGUID: 42fWd/7eT6mRMVy/OrmSqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4022080"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:55:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:55:22 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCXJJLH/M/SzK2jxdTuHEeY8qLjjJa6BLI0QFSF+GH/x08PpNJQUgQGxnw9amYj0+O5/HmTSNYTKZ9Blw/5BZnGCx6HHFqtI6as4J2ALPlFu8TPuQxmXXP+bEW9UxQLOF4U0g72q00K9oH00fJLUJNtnIDV2f4F2VzJAqYiIXczYyIJan+EnpyeAbId2rowA0JmV2KhCpn8CnOrsjCgtt2Aq9mOK1vPO0OTGcGkRS+T2aLo+5viehVWHsWmKYBeldEk4tlUoLmVzPO2R1G5X4o49jAy5Y5Cn8Bgl7Kw7xOZ7HZtFDlt4uAyZUqkiH2N4tNi4gROMfkfliKaYwg0PDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnDS/HRkm8kCqU+eNcjq3HK2Fzj6CkezRoMu+Tv9TZ8=;
 b=FgpxWZmkV64xdCSLbKVFBiI3l/llVd6u/amKYIo5/gr3W9B3qCCd9Gtn1+6wX8BtrbwB00klU4lJivD6AHSxkYNBlkMNfNqNkR3/egu1OE38vfKdZwR4gaKI3sWr4EXYJeOAurmZf8XrVU1S182SbdZO6Xe7YCVZrw7EcZZ7Dk494txAqy6s0OHW9cdXTbu+qExKxyr7MH0WONguZN/3MaOQprYX7+pweMjaWVcrhreRAA6jaQskTtEqLHOQA2Pm0ZALGF7LPNVsG0hNEn40XF+DmMlgx6Pwq5/kBVbrraZntD/p1FwTWJaVwGGMdc7azLKRBTIqEgWNDpH5de4tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PPF0A1E7F360.namprd11.prod.outlook.com (2603:10b6:f:fc02::504)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:55:14 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 14:55:12 +0000
Date: Fri, 23 Oct 2026 15:55:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] net/i40e: fix memory leaks
Message-ID: <att1S3FueufwFbqD@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792750212.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792750212.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB8PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:10:110::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PPF0A1E7F360:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ace582-34d3-4bfb-4d55-08df3115a3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261021121427099003|18002099003|10067099003|261022113327099003|22082099003|56012099006|11063799006|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: eqBvfDREKU3xfbEqO5Gz3TEOxwZqpi9XC0Cxv297YTNm53sLyfOp6rtmuCySn6a4PWqgEdRtfzo5HRaSFudOWKRnpCHOwzaNiSJvJ5ngp1l+42McwP5nBoQUMUl26nXvLs7AfTnpfT2fg309RZJzW1RfNUKn3ReAh3BvNCYytC4emC+ckaVaVzFsFAenODLwSdexxPWuCjfl2JNeSrEIUyf1AWh+5JMhaEJzH7YTeXh8qw5XuqRSw/h9ccJn3zGE2Q9XoyViLnjL0KA0JlfUQR9dyEF5kN9gMxlQ9TeME0HwoRRTRKfHf1zbuikGs7UXOVuQsk3AQGi9L6S1w4eYolvweXloG+qCxQ0ZOZdcEHTM68KmRoO+8cZaUl8rLiqQDRr+6h6WuZYyrj0pWGewv0sk/BWshZUmua2U0B5bw46Bcltms6v5vRFTx0uYKsgpyODYHfxKb2Q4T4KZD6nfqLOQ0AAQQ8R4d+T/BRvNGVNVOYoRJrN+mnyO/8rNYqYF9cQUK/ToVBYcDvGjQrZpTmfqYhHVCYH5DIGHR9FY/jTIDXtufCd+nkbgWtZ98Dv2f8793rCOZvYsCDQJbWr/8k4UuHqxbqHV5Gk1fBwSvPA+fH7/YUIH+ICfcXkGKbUX+h5abKo5jnC6uX/iEssFZXDwQRAjr1sIhU/zxiP0aKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261021121427099003)(18002099003)(10067099003)(261022113327099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voyNKDVwYhY9Z6QB0Ul3Zz2OJMRfMTX1H99xVGAdPO0wYTrJbsTpU3xGYNck?=
 =?us-ascii?Q?LDHVd9LVBEPmyQeFGPjZi6V3XkR4SXf7uWPgUteQe2sawwqtdG7l4Kzcxp46?=
 =?us-ascii?Q?INCxYQ1CylnUchiMeMfRcbn1gIJ9r1f5m/Uc3ZVZfbD4DbHHVBvP68RI0BSd?=
 =?us-ascii?Q?rhz9XNzdxS7pEIE4wMI2Yy8nP7WFnU2JFyOCl5VV3z4abdwHAYsp8LyCMCYV?=
 =?us-ascii?Q?n3H6wyBFdiA0tb1ytjDkQjjobf5P3enOJFBuZySJ7MVzmZWbk4Jnpp0txXIV?=
 =?us-ascii?Q?Ac3tOxEY2K5drVUlMRB17Ez1qVi0ssaFHDScnHjsErBqr1NUndPhBuhTDS6W?=
 =?us-ascii?Q?UWvr+kqhHR4WWK82vmSwsTbhYA/z4vCxlXYEc6zAZySj3h/yoIb3lvovZnKz?=
 =?us-ascii?Q?N5fkA9AUWHBK0VQncms4IN14hElVoSug1MCLZoyvaPVT6n7sym/akAogPGA0?=
 =?us-ascii?Q?nPBuv/H+MrSC1ZUS7zXg1JIfKDscP81Nz2ouh6k9LV3U+4hYt3oz2lGftLPN?=
 =?us-ascii?Q?legJD9LUsHEoryKwZW5IMdNTPbFkmGqNMmVTm4dbpng+rC1L5v9wJv5s2P93?=
 =?us-ascii?Q?SZ8iQ6ZqHaokqZeNrsf5pFN8CP4TMtb4A/Ryv3IW4YaHUV0LYgc97aGGSiF4?=
 =?us-ascii?Q?Y2kiP6CmAEQ73tcpIar6CqcNd/qcK+Fa1XAOQuo0Lef/J8tuEg773KePyxKx?=
 =?us-ascii?Q?Ede9E+dVW1uStX6Wqd+37P9uKIhAx8Te763QoIUwCsp7i/bdNDmlNDjmCm0D?=
 =?us-ascii?Q?Lwd84ViS6aYN9r4xSdycIfefHxqz5ZHZvKFiXXKHMiPZHjhPC0icRtOpDPXi?=
 =?us-ascii?Q?M26xisbu1ZzucXd3CjsPp+oGQcZs/bOVUrdPsRURN8FCNx68KK8cfc3+XLHn?=
 =?us-ascii?Q?OUqAi0gfO/HmpDIWfguVQQLtcqdNFpVPMN1ydDmK/+jI9kSBV6G06gWB0JIx?=
 =?us-ascii?Q?VYwM1puIf3/1FM3ygnHpkyw/MpacHcHZAuCgaATpE6QUFO55Iyax7PGwFYSq?=
 =?us-ascii?Q?ToRMScGKFgV5R/60g9XaFxg3RpkIElMvH1RTnnVMQpy+3DQVIJsyRtkh6WSX?=
 =?us-ascii?Q?KMmRB+4KrgJT35LoZa5umXdj8W603G7NBc2K0w16tC2FnlSP3iMrYmlUKBdh?=
 =?us-ascii?Q?cBqQn5rAsNDh2Rjk3qusysdq5z4zyeSU0o2bfqPNlx9R5jpmKh1qs3BExndz?=
 =?us-ascii?Q?upjotLYbddejXVpFTSh2+s5/tqoNz4D9pguM16pLM35IhsoflejkWpEfWgit?=
 =?us-ascii?Q?BAtfkQQdn9hN9mLAFAurlTYy/2kdTfH+LQwWiQQZDbiXPdqeMtMz6yiIeAUl?=
 =?us-ascii?Q?r0Yf9WYhSBJAJ8/bWymaxBqVld+ATim2esRd9afJGnaiiy4VVfsspz0z9wsZ?=
 =?us-ascii?Q?Mo31so47FjXWIc/BxHxcWJjvFL0oIOP3xRWvq2e5eDOBJ8p5tAY56a3vUVfj?=
 =?us-ascii?Q?LT6zV57HwScHe/mEyoHlX+L151K4faetupExJF8Uslg8yW8kuPBs88DePboh?=
 =?us-ascii?Q?6VqgCtKmRnn1rRwrq9qfMoenOJYd0H5t4H4jJ7FQMwRFrlbZZH5M7K+PBPio?=
 =?us-ascii?Q?f/jwAfyGlcI9jieXfDaaUf7kodBVWcNTePfayHb8tjcjsa6INeCdvzvBooTG?=
 =?us-ascii?Q?qdp+VxvhJqE1tnKCAHD9vPQhTmyKqeqJLSIefvjfCrMsrFhRI6uoTLV8n1ss?=
 =?us-ascii?Q?jUeZM9SFzVkCTwE1MxdsnLDkI3knPgQFNPfmMBObwyB0bglpIuP4gWn6KSuk?=
 =?us-ascii?Q?ATevojHF1w+ZOoOUvPok1b5Y6mR/+rA=3D?=
X-Exchange-RoutingPolicyChecked: lZTxttqJPSZOeHXechPS/0Tct+h1DQASEf9F7gqmKMfdF2b13o0+b/5FCq8L542oB9Gbty8I2yNfPzyJ41UdCft/5dt4NSufMoPVyqm5SW7bowLdJx0Z3W0MTOg/DP8CTG6xeVouWEDlowv24jIAIhsE72MRpYLh6HZTqqhlqX/Qc5aD2SWvYYY1wZTQEQRmUVAP2rb1+/dv5KcHpgIMpCV808Qeh20Opz7Lmsbvf2X2yPEREiBNPND6mMjdji290q/JfjvFumM4d9hNJLuVRqZYtqa/vdCFhIyObWNbo6yV+nQ6hENk3KMU4RwBucNt+rl1J2J+OS5/GAHjUuwtEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ace582-34d3-4bfb-4d55-08df3115a3ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:55:12.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtsxR80SLmmfNjWyUG4iTlcZbMI/o82vidlcfIWFgWNZCmChCl+adwTk35T+Oi/eo8OBnLa/goY2ZTQw/f27JSQM6NqJbI1QQO0CiVkgqhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPF0A1E7F360
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 10:31:28AM +0000, Anurag Mandal wrote:
> This series fixes few memory leaks in the i40e PMD:
> 
> 1. When the main VSI was released, only the VSIs attached 
>    to the floating VEB were released, not the VEB itself,
>    leaking the VEB structure and its switch element. 
>    This only affects setups with floating VEB enabled.
> 
> 2. The flow director programming packet memzone was reserved
>    at setup but never freed, so it leaked whenever the port 
>    was closed.
> 
> Anurag Mandal (2):
>   net/i40e: fix floating VEB leak
>   net/i40e: fix FDIR memzone leak
> 
>  drivers/net/intel/i40e/i40e_ethdev.c | 1 +
>  drivers/net/intel/i40e/i40e_ethdev.h | 1 +
>  drivers/net/intel/i40e/i40e_fdir.c   | 4 ++++
>  3 files changed, 6 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel,
Thanks,
/Bruce

