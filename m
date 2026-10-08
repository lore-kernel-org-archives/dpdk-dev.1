Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4564ACA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764CE40274;
	Thu,  8 Oct 2026 12:01:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8BEA84026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453690; x=1822989690;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WkIrG+ew+o0GhtJRA3hF6YKLGKViQv8COtX1pixCsHQ=;
 b=TKtS0HBg7yPF0IggeZDto1IpvgS9nnGyxFLSnlufQ0rVuopgaZ7IhE9L
 9AiNxYsiK/CWeBUgmE46MbgyjSNC4JH8ew2ACMQ5jqcdEGHv8WMuILno7
 2nr8JI1Wf8K1rRdIM9DMUOZALPKIPkG0Dhy0oM+/mxu5XW9weYe3HSOH2
 +7oyrQ18Kah8wgywsjYWeTz767goD038B6yZikrB2Kf8y1BP2t++TNQNK
 FaMRHRJsLv4802z/Tgc2dsE0EySN3D2QmpHNrwTh/55rBnf9w6rZJREPw
 xR2/puobbgSde4s7CxozOpiJDQzZIRySYGT9aKz1tXJvLFzdhCW99S99Q g==;
X-CSE-ConnectionGUID: CnrsBb+GSHKhHcQpbFh7aQ==
X-CSE-MsgGUID: fM4hrUbwQJSs/84WF9ihTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="130509"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="130509"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:01:29 -0700
X-CSE-ConnectionGUID: DL/KRIrFSCCJLaTTaHxluA==
X-CSE-MsgGUID: g91jAvErTIyqbkEUoqsicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1744866"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:01:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:01:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:01:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcWqvbdC8jmMW8iiiYzGevjaQ09gvW1rs56QnQpj20grOey3zCAMrGU5vbpxB27EjBrp6qCC1YFEzh+utxL4XyuOH1K410ZtDlW9v5By7Ehpf0OkTwqv4jHqOATfcOpGjyFKqETdYuaHUIl9dvJWXbLf5LUH6tG3LFxHnxVqHxlxkJcqDrkWBZbs56g5Lq2DxUaI7ZSvV6ffMVt2mknuwDhSLBAAgVvkDEHnPjQFmoUK3M4F41QQNv+wXqRyd2L+wXm+5dTkhGWwhFIzaotFgPjFMgFeIv4rB/5V1OfDxLvyp/CS/o+UoPfdJ0V4PrDyJmDAgSLLLWFzr+0dNt3+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVh1xl7l7L0e9tA7uwWHfniCuGh+2G1GqV/MrB2gfPs=;
 b=FFQzu9AN+408/IvF2fsUos3Gn4u8DSOrS3bPuNIBflGIwF0L9vKrp1fEx/EfCN1xrl3sxq3Wq59isS9vNcuz6dxgaW4QeJv4U9QVqh4UEskBnoS/Qq6DDzx/beKyvvfQc58kwV4K2Sdh+6e6xTSkbwtjReo1Z5Mb0A6VfSC02Gx2uXvEq2zc0zRJ0NqPwCr5xLPteVEq4m/hP71reh+fCVJE1z1l81phHAisASHZLojLSbPzoC1noByJYConmR3tPLua5IJeuvCSj0Fr88oiVbSF/LEqtlhWl81SMkYfWuP/FdAnJTMDKGI3tLuG8lHAib44FN6Pg8dmcdMyAvIqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:01:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:01:11 +0000
Date: Thu, 8 Oct 2026 11:01:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH 03/20] eal: promote explicit zero and sensitive free to
 stable
Message-ID: <asdp4mjlfcTe1y_L@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-4-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0037.eurprd04.prod.outlook.com
 (2603:10a6:10:234::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 653d90bf-39e6-4bbf-a187-08df2523146f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +hbVQuZBfPNhzOme88UZZQIKjFi+Y987cBGyNt2+OqfsNmDon9STVWtfl6U50ZXZB0JkuyolKiUTbzXVOZ6KEpHGHZQylr/D7ZlK5QkE8vdBEdcu+Rxe15xubvh+L8VwCFxD7FXqnRd17lAVVWqispsD/XSIKq0/knoABR0n1FuinVOdguNc9FHhuRpbg8ilTLkgJ7y8gFEcbm1jGlvrdO7Iw12fIJV2nSfhEy4ESWTgRyBZGwfGofj+0XWPjhiwFlJW4oyJDTacjkJyfWvYQ4vcup5q9TNheZ1GLSxIJtJO9FdMSgolXhE0EZJf95MeHStKJ+kqAF/gRDd57HZXsnowAO3rl8INql86C8YR3uA+Do2dTd6K+xTcCe362soRVKCwx9eavp90UJLK+6tYhErLzjG1OK7T0cHJ5CdMS6oP7BwJVWe0FY3/7Q2N5e2qnKnT7bXmOk+yAQVu1u/3nP/NMv4fjuqbM+l8YA2xeL4IT+gnUz3E35jpgIgDNjMWOC7JE9M0MeLN58EUOQfqJaf9Z4PSTFv8uxG/iV61yHHRYdZ5gU/T9Au0Rd2fTIdSK1c5b23/0JkFLHX9gZH/FqxkU7UdvxaHjIBS44AJ3m8q3fSfod3q73YLYQRYSyY1v3sFVGpd5ZKt4VrCTjpqNoLK22fDFQhp3cVKButTlpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKSC6IAs1sLXreUMeH5N2BOuhNZqlvszNS5dfBcN9YrDluv/DqQ621gobmRZ?=
 =?us-ascii?Q?Xm16y/4MWIXaxbTBuNUJgrs2wyVqBdbXqgWzspiRc6xljXEbkv3bh3EZldM5?=
 =?us-ascii?Q?Xn3kzmehnGxzlOvQsW63vUCv5BXAcvZ/gFcdcRb8DuwzQQr1yFraN4IdkzIs?=
 =?us-ascii?Q?NS42jhRvbwB+oQq9s0/2RXAB7ie8LBq0ek8wdVDr1Wl7/H/5N6y6OonU6tG4?=
 =?us-ascii?Q?tgnCpyXHuwoZ/H3mo4BHbR6UJsbf1NnH9SCOOGpl8+7emnBzBRCsZgjoIq+W?=
 =?us-ascii?Q?Rr8PCUQrwW3DzVfzxP+gRiN+qO62Q0gNdHhQZYa0vmk6FaR7cyzm7QGh3uNy?=
 =?us-ascii?Q?Yn4wJrn4PnYKqCXTmLiN7p0ECE3FCyh7yHuHRVFamlS01HQFk8GIxSOX/Cxz?=
 =?us-ascii?Q?eEv09/RJE7eg10zfC54Fq94Cy5gt3oGYOEH+o0oz155k+fXJeYZ5tnwZob00?=
 =?us-ascii?Q?8GoSBGkkjXvsoO1rwLvsKAoDqFlJH4k3oZL4Ecw4GjN8BhHVQ8HjZZ7ALStT?=
 =?us-ascii?Q?XCrSaSyG0eu2dRnyYQrNjB50mcbKuzm0rxEMPAshs1ZISralp6DKEsAuiTwW?=
 =?us-ascii?Q?dWJjlB8gE+pUu4jIDU3os3HtXyaNe1Nh1Kwz+YWsFe/5qf4uWtT0K3aL82PD?=
 =?us-ascii?Q?xgPCFDM4xUaS9raM4EK6oDiC+c6wF6XH29SJwom3t15Rwp7i6+csa3zZ/WPE?=
 =?us-ascii?Q?pS+LXdwzhXv7/Mq0+Dq+I9YIgaXl3UtBi77/hal1M/urwC4ZCxOGINlFS/0d?=
 =?us-ascii?Q?MQotTdx9OocF+4CrptCsOqKZlxISE2k0zZuaE6qEe2Evg2GI7AiC7O4EAMQT?=
 =?us-ascii?Q?4wh/P3tRZj/aCWP6WloaaqdJdmCQLTutzoW4vuSxwImRVatB61GbimcPGT/k?=
 =?us-ascii?Q?29m4mJeUCv887KhgmfpWdrjkxcWxbvZtG7NigKXQYgWQhLxgo2jgJZngVN+j?=
 =?us-ascii?Q?5TKSFvKM7t0qmTOGNnU8MgRRl+WevKVYs1dnLCfFq1wgjppWF406sCziWSx2?=
 =?us-ascii?Q?YJ3FcXyIHh8eDWuyRPan/m3WyuIp1hKy0VXlt2Jx/mUvUKbiiZzVjArnl5x0?=
 =?us-ascii?Q?HwlZu9LmvL0QPXSHOjnylfzZwiPWcVj52CvV3TkNr0o6dMbgKszybnc8nZDz?=
 =?us-ascii?Q?Z8RDPGXsJ56tz7icNmtNK4oKOm3niLFKuLd1Br5MbV92nLjS1WRTPsoueGZe?=
 =?us-ascii?Q?DRIL8rTKvYN4s7gdBLHcYHIPBZgIQvIeyzPNujImFw3WJLARx8RIFYOjQPM/?=
 =?us-ascii?Q?0xbtpeXwcodJO4LkmE48nH9i5acqe922xROr132Y5qpjhyoWILjdhB4X0kQP?=
 =?us-ascii?Q?EWMu/RryqbLXoMsp3YZ9sWqPDTcrnrrK2E6UmxKfZcNxp2HFDtm9U5MHSB16?=
 =?us-ascii?Q?NcBQtpPcfdS0fgPP4Mlo/ugn9DfZVIzxl63g291cK1Ms+46O83bvmOM0et0x?=
 =?us-ascii?Q?2xXRGI9dSBMGaso/PD1msOdAkzXBI9QyFInXkirDBx/tUJkW9hsbWWsCgQ9z?=
 =?us-ascii?Q?uNiPGHpBVfQoTtKfXzsZrlGNsASMTZgzNw1iBEVB9tcuh+70DO1d8ZNmKWNB?=
 =?us-ascii?Q?BI+7rtwRwJNE0eFBxDzIXkNMek91QJx2wUrnTRcOlupVRWI1fysSL1QmRUAN?=
 =?us-ascii?Q?2TF7RtqxVSM7ZEZjgn3D7n/k86icnLrmAFb0D6yfFhijAHnm5DVRfkU1OTcu?=
 =?us-ascii?Q?kYquABkiBbfl282vii+NBXvxzd0D9nhQu7SB6OLvsWRRM7MgwXmOjhPtpKeK?=
 =?us-ascii?Q?qpoBYlOwxk/qbgJPd+R/V7dkvyST70Q=3D?=
X-Exchange-RoutingPolicyChecked: HYD6Pak5mcxpwNH/9nnCAiFf6bSmSGDSMcB5AhapKeIq9s2iEECGvfuS/ihjTXNwuKda4rjGS/wxpD/iDP4wYizhAM4rnbLANDgrzpFtr7M2nGpumCaWhxMY/tKwRWxD2JjiiygObR6Yl05tDKx0102DMP2/WxMKfjUMZkAtoqnsICZxAqTFsP1JZSaaWNZandrLI7EcfPObRc4yVB8YXWNY8Aqw9ccC/FkypaorpNrH/05qdGy8K5s7/I0EqJi9kthkSSBtf7S4YanSV9zMtwSvbYDIXH1jSvuoReETEZk42XQk4mIBJG38xB7KmDXvIJI10gJ8CyQ0wyGZnvX7Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 653d90bf-39e6-4bbf-a187-08df2523146f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:01:11.0885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnRnZ4Hp5ao6lx0pMVLLJv5Rwd+Rifp7/OyfVRxTY8w23UMD6finZ1eLPPB/412wwKsb3z3/Slvwia/C9is28374sW+skB28b9MwQ12Inq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
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

On Wed, Oct 07, 2026 at 02:39:33PM -0700, Stephen Hemminger wrote:
> rte_memzero_explicit() and rte_free_sensitive() were added in 25.07 and
> have not changed since. They are used by the QAT crypto driver for
> asymmetric and symmetric session keys and by the ixgbe IPsec code, which
> are exactly the sensitive data paths they exist for.
> 
> An API for clearing keys is of little use to applications while it is
> marked as subject to change, so promote it.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
