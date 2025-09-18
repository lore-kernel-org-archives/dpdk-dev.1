Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016CDCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 08:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC0C8402C9;
	Thu, 18 Sep 2025 10:59:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 04E4D402C5
 for <dev@dpdk.org>; Thu, 18 Sep 2025 10:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185953; x=1789721953;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=E2TyeyLjyfrwI5HdtG9ZSTWj44kPHw7z8dmZ4hUOaZg=;
 b=NWz7DLJ5GBjjoKQBM0RNCY8Rzqzfmz22+PdfIzsigtuFecEjqR3uPlXQ
 vRHlDxg9lXzWGqCyYIUVoQ58wTMfEgKI3zAuSRXPPFB2ajQqcwI/cGDEd
 YGaUZcNyZrJHbXK/X/k7cRNqj/yGtJ6XEmI2HPQS5ZJJjJdwKIKMasSmK
 uypqlUzXieDbFUVIOx9rUQkBUZAF5EcUNdQw39vDbyI8k4UGAUjdn5uDa
 ZpeKxWOp/9ss3ue7x0bG0lYPVk4nVrI/L4+wtPF6/V+/CBEkk5C8Sns04
 OSE0qY/B4FFdRWBomf99sqVj0npFNSCYF7wESTT4RUYzzS3pZCmunC4T3 g==;
X-CSE-ConnectionGUID: wI3IwasIRhiR1JC+h/jpSg==
X-CSE-MsgGUID: CqS/KirwS5GfwQByL2L1Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60657175"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="60657175"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:12 -0700
X-CSE-ConnectionGUID: V4loISMpSr6WLB0LqzGubw==
X-CSE-MsgGUID: 7j+/BFmlS9iaoKepCvdSzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="179486201"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 01:59:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 01:59:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 01:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/pBRvIhV4UckeJxcsPnB5ENcPoC/VhkE+ZtFU9yO1Mh5NyPsflJ/6Bah+H3+4vqmCnk5Wn5QA0eSEB+Qg87xH3RHBaTUfkp60U4uTMJLz07KnQ/AdC+ur+9I5xM3rP6k5M5/m439wKVAgjXO26XjzjyWr1JPTl8WhItnx8ZKRSPR+Nx/5OG/xbx5kXaHrvnfmztcOMeg5D/H4XF8YGGsAdtDv5ermfDcH2dAR4J2NsPWy9xHnn+nQp4/qSQSuNQ1tDphoL72W3Zs6UcZL1rjezLk4BI3uM5wgzM+aqm5jvPQAg2AH4XqctY6dpUCvOxx/zpnI5zij/gD84IJ2g7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIoU88OxPXeojPurlGNQnnJ4H2zBbkmFc8c8b+yIYGY=;
 b=AqYWn4Ce2PdwumppQeND0FlnAiV0RxC0VB2Co7tKwsASTyca6XyvFiJVvFuIe+9e6LWHzB0QpJU1ckzFj1L1PCyUV8CVotMmCIl/n+HREA1mv+kZ/qFqbYbm8jzVeXALscDphR6qG69B9PmK29KY2J2ISSmuefWTVmWkncLqg2pXXr6w7rpHMOUdD9IBRs0rLsYpZ/XOF0m2RlMbzueEIW3EABV4S3yBIiIwOka3JhV7NhT7eH59X9kNjFXNswaf/Gy5nz7esDx5Yp2lwVqYEMttetWPl1IbP5Pq95EyWhUjo7BHpkpb5B13BHh6zsY1LbSywl3IYkCvy1qK3A4nOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9135.namprd11.prod.outlook.com (2603:10b6:208:579::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:59:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 08:59:09 +0000
Date: Thu, 18 Sep 2025 09:59:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] lib: fix AVX2 checks and macro exposure
Message-ID: <aMvJ2E077LzcIp4S@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <24958055.6Emhk5qWAg@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24958055.6Emhk5qWAg@thomas>
X-ClientProxiedBy: DB6PR0301CA0089.eurprd03.prod.outlook.com
 (2603:10a6:6:30::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: ae741247-8321-4d5e-ef79-08ddf691a13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+ASVfhWw4ZL/hYRTcHMW8m7pvIjhnGAkJ5dO2iBW8AUMzZ7bifgda4LvHCk?=
 =?us-ascii?Q?svypvAIjs6UgCXH2MLn5iN+QJVo1hM642eDFhoXfBS1yyMy4i3LL+shpvSrb?=
 =?us-ascii?Q?2cRBg4d+t3GzBYLMgH1+wBtLty14ku15WHc4J4xucJUKsoRuGHzMFL+Ihj9C?=
 =?us-ascii?Q?BUEWdA9f+mUj80q2jDV+vasRnH8wip+7WAagoXuLokn/PyHNapal3342ZD2m?=
 =?us-ascii?Q?iPV1XULANjxXJ5VZEVVBIRZqg2r07kWKX2R61ZaHke4ce579QV5pQcJkROmF?=
 =?us-ascii?Q?Ii6uGTIJvCtMdLCQtIozhTJVIlaRqrWptzt7+8BuuCX18ZvlUk64CC0oPJEg?=
 =?us-ascii?Q?gTrn17oJoEubZMJQjf8ZPAWr5PsE+c3Bq9wAeeAaaa8UI+m3NyHjtLnPxBbZ?=
 =?us-ascii?Q?TwGu+gR8k8Y+iy0G0bIfrQRmx8MRFWtJs0jtCeNyDIQ5xyPwaKUHclYXsZkV?=
 =?us-ascii?Q?nlrPMAAzZQTPYv2tcyqd+2cWtaVZRGyG4CbJAafAEugEyVBuDL+uww15pRMf?=
 =?us-ascii?Q?ATZb59nFg9JmPzynN84nSqy4K52FnHwm0bGGiWNtC2SiKXwkOgAxBzI0W6Sp?=
 =?us-ascii?Q?0mWV0b8H2yJn+RXHlvTIlogAqbcqGdNVSJJuW88NjWEYBwqB4303UauValYd?=
 =?us-ascii?Q?+o5o2JZrpVCY9mxsQRM/lYp6Jxva1xZLELX9pFNLLfqYyO730CjJwEBOudZ5?=
 =?us-ascii?Q?YbSqG5nGegIy8RxFxNOwONOGRqfB2mLXPL0EO2sq8JTzDxhPCAtjoSwfBCXb?=
 =?us-ascii?Q?vWF+vkvKtxZT9O8Uv0r9Bo8X82AiVk9Hnb0OKeF0l+GRG1FGefwaV7S9i2ur?=
 =?us-ascii?Q?7o6/h9MM7+dC7mQ8RnYucyvu1u+Wpta+RWvMKItp0Un+bgisyfdBVUMBNbgj?=
 =?us-ascii?Q?En03XAeUcv5tFoetSH4iW850QfAIemVStJNcpYLYSV44dvd2sbOWxCc4O9jA?=
 =?us-ascii?Q?+emZVGhZjG8LeVzt8QzjeVZ7hYvIn2GCMHFdyk1GPa1QaGVQilK+uP+cK+5y?=
 =?us-ascii?Q?gB8bMDjHzpufJKaXQ2qUcM4RFNK/vRVRiE364JQa+46XrPMsU3fQFtzY0OY1?=
 =?us-ascii?Q?DFQKiXEwt7QAflxbA98NvDvSeJQUHv2bzNYFtOIBxNJHcYnCdeusGzKvnF0I?=
 =?us-ascii?Q?JgudfdGSIuq1b/171CNq/BLVo/zr2O6lL/F7tNa+GCfDRWj8Mouigw7fRuO0?=
 =?us-ascii?Q?smyqc9ZAI8L5f4v14bL61hwNn3YVzL+T8naqqYLTtj/cHIW8BeGCE4kF2LTK?=
 =?us-ascii?Q?neuer1jScXsKrDmSRnLISD+4zHWxyP+8qqAkIbT9Bkb20N5D1A/5pja0ptNH?=
 =?us-ascii?Q?52Z7Fhb2XTO6G+rX3QBrfWpTJdCXuv43kc6cUsx6h8+7aNBEm7jVm/eajlSs?=
 =?us-ascii?Q?Cb89QF3mD/bYi2VJtV2En9mslhudvl5bY7l88uZL8+P6+qXtypQXDwgOEFxQ?=
 =?us-ascii?Q?iUOZ6J8Wzcg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UynTNjSMpaTb/+K7MVuhsbCCKyV7wMjfvEf7QV6S3s86N4v9V19DRRQPSv9c?=
 =?us-ascii?Q?4rlUQ8XSqqfvSpJL2tJHcDD2q5Au4+KOcuISZgMU2ng9hAHIgxXG0v2k5VaT?=
 =?us-ascii?Q?JSVRJMY2CMHV2pGGtxf+2Zbqc5cF+BIH5oXjgeixoaen9CcIXPiYs67vhZVS?=
 =?us-ascii?Q?zzOkLRn/VwgtnUGnGHlTWmbjh5PvdRY3rOtTLXSXg2dwRgGVQMwC5KETw8J7?=
 =?us-ascii?Q?UtM1pf8y0lGVDjzxMUukaC6DEjktkeSidqKxkoyckpPmBJ/Tj28IarHo2LaK?=
 =?us-ascii?Q?FQV6Wxc77FDjJu+cMCMV1rfSu4l54LkgcbfEJB8UurtdPBBz9pylQ/QQgOae?=
 =?us-ascii?Q?5GgdqhDqO3eDEf3w47n4zPXIVteq2n8JlUvAMjDx7BK+Dvz3eSIFOLjDypKl?=
 =?us-ascii?Q?XnbW9oXAF5QW670/1GSm2o6S3jtIpJ0NpSdJScQHSJeRaQncZrHAZy+S3yuZ?=
 =?us-ascii?Q?cDGYhshZuIOSSnAVlOoMNX1+cGDirxiEq7Jo4KWAzx6Dbpan0aYll3cTKbTJ?=
 =?us-ascii?Q?CB+bb+7HtPXWPWN3djA3sKB3fVb9HoXTE8fgXQnLypw30ZhNopwTJJa6MSCK?=
 =?us-ascii?Q?A3elUfyg3SZ1+dbop8rWuW6anC6Mpal0DSke6UDUfgPk+gnyDw5FCmNLJHsy?=
 =?us-ascii?Q?qerhDlH2b6FTXm8EIy1Y4NqNOR2rXLibddWQE4V57dGL9ZIK4tFI5U2c2zqp?=
 =?us-ascii?Q?syRepMPplYkfglKyY4v5JHDRdg+lSg3+M4t489PJ6zcJ39O+ImSnFrRYabxM?=
 =?us-ascii?Q?jngczdwXVBgGT64jGNBSv4M5yiT/Xf5aIxa2ZkBomTWrGa2UNu3fgbN2RcTU?=
 =?us-ascii?Q?AvrVaEi5i8bE33lX9qUD+oXWnAvHVcEMv1M89RY7csuc+u2OAoCx6u9nDu14?=
 =?us-ascii?Q?LbKqrqo3YznDvgR/AaeYoHPZ3HDACYzTxYi/FrqqZ+7BGs1RAM5AgisDanou?=
 =?us-ascii?Q?v+SP6UWIE8h2t+wjOCpTW01gslTlK7leDtiATRCVsrz1rASiiXVSmO4x5lUs?=
 =?us-ascii?Q?DZt9WpWZpEmP9kgmeIht1BuxcWAugUEL2CcyxIQFhDUG75hPZT3Vg4c5Bc3p?=
 =?us-ascii?Q?LPNgWMOZ6GYrdeUIDIVKFdJthG/+UKIA9qQxKymswcm3gdj+3pax1xHNQS6Z?=
 =?us-ascii?Q?jiAhrtcSm0/3S/WIJ5sryy/PXlhWfxPolJnux5oJsPp2xI2sgn+To/TzXr2d?=
 =?us-ascii?Q?mbiPzCezdQ92iDa1cVO/6zML0yWrRG/wftz8VvEIO42Wpa3v5B0DMsY1XTOg?=
 =?us-ascii?Q?FU4NRGiOzqFZ/JE7C0eJ2LyLPRu8i2j/06bqQTaBwjbEVYuEH2VZKg9odBBK?=
 =?us-ascii?Q?/ZYb+NkFKgH6RtATsb+/6IXH15MshMnICR2DsfeLpfVfrkF/L9bsx21UZG/J?=
 =?us-ascii?Q?/zPzparqNKeUe5sNOGBS8UmvffZI94cRW4elUnkv8X/FBZAcFsGQxMNKq5o0?=
 =?us-ascii?Q?mrRvDTyq18Q8KEcv8tXdBaHtIghIg/K0Q8h2ybollBmxVMcABbDVtwpyauzT?=
 =?us-ascii?Q?WuRRO+Q+mim4Y1CjPRXpxNRvkwOIVay39zZsupzs0Ue8S0/nw3utJEIMH7gu?=
 =?us-ascii?Q?5A6JprR1D9xN5dasGxN461pbKxdoAnA5qUyXVCuhvHLc5vx9ODdgI39ltX0M?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae741247-8321-4d5e-ef79-08ddf691a13d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:59:09.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0y/KOUJS7kaM8OTQq36Mnfl9+iGA3WxVR3Y/0sAd/axjKbC9meLb5/kZUuOzS9sbK/i3jS1SkiBrOzToAdybhi2x+pdN2H9/+QOsJTwrLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
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

On Thu, Sep 18, 2025 at 10:10:59AM +0200, Thomas Monjalon wrote:
> 18/09/2025 09:28, Thomas Monjalon:
> > These are fixes for AVX2 in efd and member libraries.
> > While at it, I've hidden a macro which was wrongly exported in the API
> > without having a correct prefix.
> > 
> > Thomas Monjalon (3):
> >   efd: fix AVX2 support
> >   member: remove AVX2 build-time checks
> >   member: hide internal macro
> 
> The AVX2 changes break the compilation of "x86-generic" with these messages:
> 
> lib/member/rte_member_x86.h: In function 'search_bucket_single_avx':
> lib/member/rte_member_x86.h:35:28: error: AVX vector return without AVX enabled changes the ABI [-Werror=psabi]
>    35 |         uint32_t hitmask = _mm256_movemask_epi8((__m256i)_mm256_cmpeq_epi16(
> 
> lib/efd/rte_efd_x86.h: In function 'efd_lookup_internal_avx2':
> lib/efd/rte_efd_x86.h:24:17: error: AVX vector return without AVX enabled changes the ABI [-Werror=psabi]
>    24 |         __m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);
> 
> AVX2 must be forced on these headers.
> The solution is probably to move these functions in .c files
> declared as sources_avx2 in meson.build.
>
Yes, this is probably the best approach 
