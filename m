Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEDC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 09:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 392EE4028E;
	Thu,  5 Jun 2025 11:32:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF654026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 11:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749115956; x=1780651956;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4A92cS4kWghtHcdTLDcqKmE4ueJjE8G9gvkBuZU5abg=;
 b=JbRC2eCuPN6BlleHw65JTAKgdGHw2a8cdVx2RKmTzMNdePFjnuNuJQge
 n8C32abNsxQuHOb49GYaYjI0ozXwjuDYCLmXhaAGjtrlSiQZzD+pW+wN6
 VXvUFKEfeqJGXOlcWgM8THkqNq8dNYy/ydsHf+PyBIQvnB/H/nY4fhDiv
 evT6+NE3jzOVAMJ8zqK7n12QR6C9PIqRQs4sJBbcjyx4tP5ukMKIOfXyY
 MS1FNwmPamGxexeP10FWC6pC9W7Z+Feg3bNabSU83ExovyeUPYmsWmdGs
 sfGKibSZjTHPezWao9AMLZiz8sRMu8CmUmFaYPl4Ep79LY+LRSqlvvKwX w==;
X-CSE-ConnectionGUID: BF/SuaNTTSucAdHyUtXUgw==
X-CSE-MsgGUID: qocR/XyUQ/S2GqgrzaGFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50464737"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="50464737"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:32:35 -0700
X-CSE-ConnectionGUID: XJDnZL9oTdCsozzZFRG/Pg==
X-CSE-MsgGUID: RZztgyIdScmOTj+hFzbbmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="182665006"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:32:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 02:32:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 02:32:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 02:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiNrdZjGByy2iPFZRUbdqhutESiOoFQ4oO58vGKGPwlv/jPnpSwoKWQApvWnDr9vPdBI18D/SsvSD517BjkRPl59xXRRvbLJdS5AhL0vueIIeCxCLRlfDnR2U9AnEAnMoWjzl2VwsCxem6jbWycOa2Z+96+FnICuQwlGd0mS8t+dv9khV7zFmFKAvgGL4ljnbwVDGjml0g2FzcjrNH7m3Ufl4a197tAZAA026ANkKzzS996EccQJKwP5B+YT0tiL1zP6/T1xZONJP8MRuxEARQIygDheSqZJbMyVCAYfM/kwjO9SB5n/wgTBKrhGzthkkX9jeQE7xaK6kEkr/f176w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7vDwKbkRknOUlKKtng9XqsEVXBvdHe74ohC+OsefmU=;
 b=XwY3Dj9z2f9iXEO/Hv2U4TNK+X5oqvWd9OKSCCb2U/NKc4XyDMyYSNIKBnbWEn1CLQdczWQScstfyLr+BEU5OAayBlHBko+EEPqHS/ET7yAlmMqvI8cqUllVqBG8M6Fanv6WskG5wVIKPfEbhEy08fM+J/wV0JZz8zmCAZrxdQyWf6o6Hk7hzznc1RfgR/PYgnfuGQ8H5CN4hMdSZSenU4k7LBZhoaEx1RtAKDf3bYg3q4E0jtbk9kZr3bMMPzu0ZX78vWNsBKpREhelksnAwMn4tWfoVUlIPb2/6cjbC9zFy06TIL1BYSO9qBssFqMUn4LokIqycrjWuZUbo8RKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 5 Jun
 2025 09:32:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Thu, 5 Jun 2025
 09:32:04 +0000
Date: Thu, 5 Jun 2025 10:31:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 23/25] net/intel: support wider x86 vectors for Rx rearm
Message-ID: <aEFkD1gYW3vAVZC4@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <b7864d189e468484a6af5aa774ed566b2a37818f.1748612804.git.anatoly.burakov@intel.com>
 <aEBfPb8Imy6nemXw@bricha3-mobl1.ger.corp.intel.com>
 <e9a7a3e8-2154-4c4f-9846-5d2241627d36@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9a7a3e8-2154-4c4f-9846-5d2241627d36@intel.com>
X-ClientProxiedBy: DU2P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 74078ee1-0062-4292-571e-08dda413d536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24KXw4qODXZbnd4u419qJcm7LDxahsy+WhObMxbf/HnYzQxz8xEBrfegn7XO?=
 =?us-ascii?Q?/w/rq7pB48EAero/OQgveSY6GiI+oACF6EhqFOG0RyRw0Pb70rNveHaUX7Fw?=
 =?us-ascii?Q?gy5Xq89hp/XRuP3JiLFLeCRTpnsf8tODDdwyWHhfiUqRSR7Rh6e24zckzhcv?=
 =?us-ascii?Q?NCntpWEdu/Jd21PHUhFjG6HAtwPa7auok89hbxCjjorOYPj10fPqX4tzVYbh?=
 =?us-ascii?Q?IP6MvdZ4JVC9GYx3CnSeoReDxOwyRfP9d8T5moTPhocdfSCX9iH7Zj/GR3bH?=
 =?us-ascii?Q?QfkD3scY2kP5dGpJX0idVLXINMgEUdZcmmqiCDDSqYtS3F9TpafGvsasXztP?=
 =?us-ascii?Q?vEr+ppZUrYgAjTrbKjg49WXAXwt7ZLp4cX2ugigSLxCmv9vtxs0Z5y0VNQ3r?=
 =?us-ascii?Q?VelByVFqqWFn6Rhuhuui6Uo1qz4Up9+YhCwMc6kOHL685ael7Ml03xD8PF//?=
 =?us-ascii?Q?yQcFvYxmwgITdTSsX/syVn7lzihJQOqTUQz/vBVz9OOMAITMN7nGBurVKYFn?=
 =?us-ascii?Q?hDVcMQ/rQsQVbvBod7DuCUiTM45G2hZaQ37MzISepsnYVFpt0coTzddZcr63?=
 =?us-ascii?Q?g6lRCAlw81urEaHgvaYkZ2JIX5zA4WOFz3uJUuNpmr+huAWd5urw/iCzcM2o?=
 =?us-ascii?Q?AiXxI4zXLpgec/et4j21qRkbNx8kOUYlbYdgxgRhV2gNDUWavstLK9qJiCVd?=
 =?us-ascii?Q?URiHdw3HWoh+EG0P0oyJr970VeLcMP4HLDOYV0dRLdV/YO+2TEh5v2OIP9Rb?=
 =?us-ascii?Q?GlUvmsOkv26w2VYFejpE6Q//RVolYtGoNVxeaDHkdmnzmgcucvBIvoHtI3eJ?=
 =?us-ascii?Q?eJ9EhVF8DGQaa2YXZ6QxhBLHcsZHWmDBmAUpc5X3qpJkrJ1qPfOBrLD22855?=
 =?us-ascii?Q?KsH7yuu75rtJclWGL2p5Q3Dbn6kP1TWBOw5U+VNAjA454P/eJNkdmocrZWOw?=
 =?us-ascii?Q?6OIPXEctCTvxsXcYMjPTEsWc97XzW1fs+7yoYo1HHamS0+Luth3cxzD2WVBc?=
 =?us-ascii?Q?Zqsg7L8iFv3w8DjoFGosKSWVU3kf+oYU921XRW/5lRuCD88vgl7CM0om3os2?=
 =?us-ascii?Q?n3q62niA+XPcJc2d+Qn4YE5bepxr/EoS54UeC5OeDp12v6byCTAXucXiWKiU?=
 =?us-ascii?Q?E3rM67oSBsV8aLtsI7spjTmfORhrGPoU8uX2jKPIU9UujBR3L3EcgA93dnv4?=
 =?us-ascii?Q?y70BgBRQuZX3FS05zPp2eFhjEZVNhcsPbARjh0LhKsltWMz4BKMfHuefz4sO?=
 =?us-ascii?Q?v8Yw2OhcExwlBF3/M1zGiwioNCuEMkxug6Px0RiXwq98xegZG3JttNyQqxj9?=
 =?us-ascii?Q?T07asWrMwIaxakdg2b6d6vgB4+75wlQrW0mEKnPrXxctXLWT1En8loyKFf2u?=
 =?us-ascii?Q?G1klTvHN4rd41m3PtstppdKL3rYXIu14RTk2xLhKoU+Fk5/Nf3hDgZs95CZ7?=
 =?us-ascii?Q?h7SVIPPD+vs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YZm0i0C31tp1rU4gtKaGHrUgs6rP0QJSfY0RP//bfbhenRs7y0VK9O+EeizH?=
 =?us-ascii?Q?YncMUKeN4h50yV2+bnbWLb8Jh7mRwsaUsWHbhNqtRzcS63ZZPyqn1C3bLJpy?=
 =?us-ascii?Q?cIVfqpOmyJO8WKmmnQhf6hRAl1t9ppU46JSiDLWofqh/5dfhJ5xqVxsM4T10?=
 =?us-ascii?Q?+S9tPu11xS/2VDbdmYBWK8tu24oYsXShBJqCGggVSHcCPYdS4QNb0lUtqXZy?=
 =?us-ascii?Q?PCDwshBVYuggJE3iPT7bVo6X2yoohI5DB3YyXyqtawa+Hjp13DcRhizyGLGM?=
 =?us-ascii?Q?OXChqdS8Y2LJhlfu56RXwtnVRtmLcD4UisaY4zVMt6T4ZAEHgfw3UwE9oLXV?=
 =?us-ascii?Q?j+xUhHKt79rX8JwqfsQwD1t19Ze3+4gPOBTwIYrRWUtUPwS9oEHAp3/MvQTr?=
 =?us-ascii?Q?1gmdMqcfTWvn3TIL8jETluOKyPxTbncYfruax3MK3U+UK3s0cMUAl4/npt2W?=
 =?us-ascii?Q?SQpJGg1xKHMrMR71YKDljfDATXCw95aOWdpu7WU86hwye6A7+zqF85TrN6YJ?=
 =?us-ascii?Q?tqVNjiE0s4uuETnsanOqfu1Zu08lexVcEmVJeJ7Ufb6l2A3/28O+DmHuYhgv?=
 =?us-ascii?Q?TlSKU4gm0qLJ+QUU/ai4pO/xJgC+bz/thFJ2UFqgIVF6wd0eUzTEO8gTPzIL?=
 =?us-ascii?Q?b3fGDNA7teGBCmn3ok0udYpQ7lu5qTOxe6jWPBDCI0s1AH9nGs99b/WDXaog?=
 =?us-ascii?Q?3er31Ix5XZf/OBqmhajcx02RvELJjpQMv7QktN83tpQ/3ZzX0hDdhuuzcy0l?=
 =?us-ascii?Q?AgmOelBBwnDPQKvq36l53zd9dCojjKkjTBov+ocehI3hP/c+wHA9Wva4Rrcp?=
 =?us-ascii?Q?ZKZ0kijL4jSmd7c0Z0m4oS9nZNejx8Kk8mTfr3EiG78jzYKf5aRBnNP/Qryx?=
 =?us-ascii?Q?P7/tD2mqzvPerI89OeP2GCHyWvpmKFliLvQbdaX9+NJR8YuyTihOfxSUyZy0?=
 =?us-ascii?Q?AdFGsvm0XZfSPgtLmNdN2ngqsxs64uEtcspm9PPplDrWlLqMevQgPyR0Ozx9?=
 =?us-ascii?Q?61PTDKFVrQ+y2rjLIvC0wSSGESW1TLFHmxbGR+V822pY142j255kyE2Dok5K?=
 =?us-ascii?Q?q2C68kt5heOss7pJ+6MgGFNFMq8nROW5NwgnafrBnLdz0cMnh2eSDWO0E+XL?=
 =?us-ascii?Q?1aMirdZ5BdA5sRmptZpa+CCqpRV6Vue+ugdH3Ur4sfwFdI6fgasNRoP1F3QJ?=
 =?us-ascii?Q?2eXWipR4w06UiioGcElUgIYU7EJi1yA0m5Q/d+8Yhly+MxN/f886Uyh2+nrR?=
 =?us-ascii?Q?pZC2ooPVnb22l9ZwArLsHgwp6mhOq96PA+Q+VY4oC0KuMZBIFaruYu5Ou73e?=
 =?us-ascii?Q?re+Fv9iDopCdISxYibnjbhzjSMKwAYGKYWSVTb66RjWTBJ1bZHx/3pQc8XOM?=
 =?us-ascii?Q?bd9492HnSDuSlOVMzv/hwUC/E/0YM2NPEPaJ88OSPIkhWgKFrW5gLdhizlqC?=
 =?us-ascii?Q?gV2A+mIZPzuwybKPP41AUCCzLuWFk71PO52pscF9JGF/dFMBXk8Hm6i7Cs08?=
 =?us-ascii?Q?q8IdeDtNqjsjOP44BfJalhmAHiAw97BfkvjAqmLhw9B2iCLiH/s/BWkKQUnz?=
 =?us-ascii?Q?1ymYLIqoZmHSMGO9a+mGllSINuqJ/I8+6lQGQUEeWFhjEdW/nNUNsVPWWXAz?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74078ee1-0062-4292-571e-08dda413d536
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:32:04.6608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/9g0S6hrSmi1xMNmGXh1/dntNrxnr+s7ngbkO5f4oKLnN5qEHiAvnUgefMNVCntidIUNcoZDyURYeafZsF/pLTHV+waDGuTLhGiIUuzrAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
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

On Thu, Jun 05, 2025 at 11:29:11AM +0200, Burakov, Anatoly wrote:
> On 6/4/2025 4:59 PM, Bruce Richardson wrote:
> > On Fri, May 30, 2025 at 02:57:19PM +0100, Anatoly Burakov wrote:
> > > Currently, for 32-byte descriptor format, only SSE instruction set is
> > > supported. Add implementation for AVX2 and AVX512 instruction sets. Since
> > > we are using Rx descriptor definitions from common code, we can just use
> > > the generic descriptor definition, as we only ever write the first 16 bytes
> > > of it, and the layout is always the same for that part.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > > 
> > 
> > Like the idea. Feedback inline below.
> > 
> > /Bruce
> > 
> 
<snip>

> 
> > > -		/**
> > > -		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
> > > -		 * into the high lanes. Similarly for 2 & 3, and so on.
> > > -		 */
> > > -		const __m256i addr0_256 = _mm256_castsi128_si256(vaddr0);
> > > -		const __m256i addr2_256 = _mm256_castsi128_si256(vaddr2);
> > > -		const __m256i addr4_256 = _mm256_castsi128_si256(vaddr4);
> > > -		const __m256i addr6_256 = _mm256_castsi128_si256(vaddr6);
> > > +			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
> > > +			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
> > > +			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
> > > +			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
> > > -		const __m256i addr0_1 = _mm256_inserti128_si256(addr0_256, vaddr1, 1);
> > > -		const __m256i addr2_3 = _mm256_inserti128_si256(addr2_256, vaddr3, 1);
> > > -		const __m256i addr4_5 = _mm256_inserti128_si256(addr4_256, vaddr5, 1);
> > > -		const __m256i addr6_7 = _mm256_inserti128_si256(addr6_256, vaddr7, 1);
> > > +			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, zero, vaddr1, zero);
> > > +			reg1 = _ci_rxq_rearm_desc_avx512(vaddr2, zero, vaddr3, zero);
> > 
> > I can't help but thinking we can probably do a little better than this
> > merging in zeros using AVX-512 mask registers, e.g. using
> >   _mm256_maskz_broadcastq_epi64()  intrinsic, but it will be ok for now! :-)
> > 
> 
> You're welcome to submit patches, this is a very welcoming community!
> 
> (seriously though, I'll look into it)
> 
Great, but I also think this is fine for now if you want to keep it as-is.
We can do a post-rework optimization patchset after this goes in. Main
thing is just to ensure we don't see a perf regression after this work.

/Bruce
