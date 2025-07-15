Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D6C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D5440608;
	Tue, 15 Jul 2025 16:17:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 813D04028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752589075; x=1784125075;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8Z2yw8Cy+nKjss6xx0cGbPiY0zzPZhab/XIodJDC8Bk=;
 b=BtsytW+FkoMJG1udjuVZrwnlXoLTs+ELFU/1BTNu35o1vtJKYGeWJVUC
 XjLT/0MfS95RMfdLFfZTnbNPkZEM9C0IzDx5KC0j7scof11giYUNRrhz3
 JIsjosPeFNCyctMjC/6CFM1Jj9SkYjRu1izzfQslv3sb3bnaE3jV6mKry
 uwF7aHAzSoJDxwrKZxE659uGF9UdyQyWxCBefY4//a0pXkl1j/8RFgD10
 EbRC9sfGfJ77JjK0Ywkppsy7PEIvHwtNHLqGkAfm6IzOSuW7Zt/ipFzE+
 b9MbsISPJwaZq0YR/VgiZ8mmJtQ09C2cSBWh83YxM84Ix4++uAuEBFtYC w==;
X-CSE-ConnectionGUID: cZbkHrh8TG2r/HpyFuRyMw==
X-CSE-MsgGUID: JF1t/kOLTKWnpdyZjIWK5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65508311"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="65508311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 07:17:54 -0700
X-CSE-ConnectionGUID: qkfiD8dtRh6cDFzYIr93cA==
X-CSE-MsgGUID: YN3hbK8ET7GYt+3I6uNESQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="188221376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 07:17:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:17:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 07:17:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTHxmlbKqP90I6s2tySgwNSANNsJRqDd7XuhBtu/yVol1e7Sy+6viQalZJ/1VBm3QsvmnDy3OfKD1A/k/RRJseO7WKrBiih01w43OWZgD1s3c0Wzu+mRqDQKUg2WWuItbe7GRpDI+Fa5zE9FNn98dj1D9SNMwvnN2doxmZCQm93dQlFGYK7fQLb3WCxqJZ74f/mR69G3gIt8+5HFLwmQL2NQH61LGvOgJAWohQeduIir6ewI55seKiLwBCFRa55rhUclmolKJhnZMUHHQ2nvjYhwCoVMq2wKZDBuxVKKmc1hxDzsWrVtwzBNPx21LUFRGhK+Svjg3+BYOgYuaNP+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxzmVgdCtAqLCbt5AazdtPa8VD16JmahabJ7ZWBbcgw=;
 b=aLPDUnTehs57cdQpA0r973/FC5u/8IZvArOJ3tluFcvvDsepPwEwnBFkiicOWJVGd2sNMWuNK4/zoeISse4iNK2TGGDRTd/fwqw9GF/+TCjTNxLSLDtB262Q3Tiv5UhSwyWUqOcWeReq76OQuNCpq8z0FXSxge9xCmLiI7C79rsiH2dBA9gXS2zCkMixOLLt7uRqQoIn4f1gmjv6FMxE2yuQSr9La9FBn2Zkb+FtT3Q/8xLg4sCYjhfmox7IHuypW9JyoeQxJ8ntNq9BKjFdEGAVm0FvIKCH5XnRSTVt1tjY45ruz2JY3neLy1DDeLFmPQ361/MAUycLLQ+VWv+C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 15 Jul
 2025 14:17:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:17:08 +0000
Date: Tue, 15 Jul 2025 15:17:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Amit Prakash Shukla <amitprakashs@marvell.com>, <dev@dpdk.org>,
 <fengchengwen@huawei.com>, <kevin.laatz@intel.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>, <g.singh@nxp.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, <jerinj@marvell.com>,
 <vattunuru@marvell.com>, <anoobj@marvell.com>, <mb@smartsharesystems.com>,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH v4] doc: announce changes to dma device structures
Message-ID: <aHZi3mRo7UNbYbvD@bricha3-mobl1.ger.corp.intel.com>
References: <20240730125302.2132377-1-amitprakashs@marvell.com>
 <CALBAE1NkQuJCj+qOsVy-cZ2baj1+UqNhgut6jEtQitapp6DW1w@mail.gmail.com>
 <3321231.G96rZvMJ2N@thomas> <8204600.JRmrKFJ9eK@thomas>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8204600.JRmrKFJ9eK@thomas>
X-ClientProxiedBy: DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab0ea12-ef42-4888-6850-08ddc3aa4830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtKRW90U0tiR29UazcxU3J2WEhmV3gzQmhGN09pVHNqekNqVVIxZ3FGdmpM?=
 =?utf-8?B?Wlg2QjRZb3lxZ0d2bVJBcmtaRnRmdXFtZHhIbkZ5YWJ1TXZKa3VUc29yeGxi?=
 =?utf-8?B?OXI1cnphVmNPODRiT0YyOURibTdUcXc5b3orakJHaGd5d3FwNmJDbUtRb1My?=
 =?utf-8?B?L2g2TXY3allvWCtqWjN0eDhRNitZVzdrQWFDaGNyenU5TEVrMU1tSzlBSXda?=
 =?utf-8?B?c2dNZEMrbmpvNDFGZDdoWjhyazF5VHdrVGJxc0c3Ukx0SmcvUUM0NFhFc0hz?=
 =?utf-8?B?cXB2WGpXUlQrYVRwdUxJZGhQMGd6Lzc2ZnFBQkdpT04rWSs1Y2tjTEFpSy9X?=
 =?utf-8?B?dnkvMjV6VnFDd0ljbklXMkVmZkwwZk81SFkyYkd4UmozTFE2WTFMYWFDYjU1?=
 =?utf-8?B?c3VNNWZibzVRVjY4eVlsSnBjeHdBL0RjWWpQazZyV3hTSTVXQjRoY1BkK2NL?=
 =?utf-8?B?aU9IYUlhVlZCWWdBMjRpYlBlUklzcm1XaHBxbHlmUHFQSm5EYndVZlB1eS8x?=
 =?utf-8?B?Y2NBekpmbUZrUkhRbTZhVFhQbFhWR3N4cC9EVjNvamZjcjY4WmtOZTRIV2pF?=
 =?utf-8?B?b3M1cllDOFFIWWJxSnRVSGRKTEg5WlFjNHdJRHBLcUdFQTdHaFNmVUJRaWFy?=
 =?utf-8?B?UDZEMlpyU1NOTE9LNFZ3ZTgwOUhkYUlWaWgxeXlyZEorZzk3RllHcm1ZOHhk?=
 =?utf-8?B?cTN0em5ydjBVRlcrc0s1Rk93MUEydnlxcTA5aERaVHQ2YUZBRU1EOGJxdFRx?=
 =?utf-8?B?V1NHMTRWK2JWM1BkYy9JVy9nakNZN0p1ZzZqRXBMQ2w0aTZYOUt0M3I3QUlq?=
 =?utf-8?B?VWN4aWEvajF3MVJzcmI3a1RsSzJvQVJnV0FRL3pMUG1HMHBvWXVjV3d5cTkx?=
 =?utf-8?B?UENZNEZDVjdISmxKcWxmU0krY0taZk9CazlMNkFDd2hFODhKOUNFa29tT3du?=
 =?utf-8?B?WlRwMjRycHY0VXZ3UDVLVzMwNnFacUVGbWxZWERvbFd0bVV3STBCeXhwR3BD?=
 =?utf-8?B?QlphdDNGa1JqWUJURkRzeVE0RlhVSW1CMGxNNS8zS2xpa1UwOVZaQmpiNUIr?=
 =?utf-8?B?QndVN2ZncmdNaEthTDNtdldka0FIRnE2MDJYVWRmTCtyMDFlQlRGQWp6TnQ1?=
 =?utf-8?B?WDAxV2w4T0xOMUlrQVczNks5bU91WDZoQ1RGR3lkNTJFSmYyVSthSlFkdHhD?=
 =?utf-8?B?NlQyMmVxakZNYkJtcmVDMlczQ1QzK3NqeC9mWDB5NVBMRWNtMjZYTThsZE9R?=
 =?utf-8?B?UXVBS3JaTVgycmJJNDNST3JLaVBvUTFUY2VBalkwbFVheThMaDJUSlRSK09N?=
 =?utf-8?B?ZzVhbjlOZTRFNncxQkhRYXBDaDNTUFZtZ2U4MkxkMml1SWI5ZGZkN3oyWmV0?=
 =?utf-8?B?T1pjQXRoWlRkZ092cFRFUG9xTURxWlNNUW9ReGZWR09WR2RVZTBEbGtEZ0o1?=
 =?utf-8?B?bmJmajQzeUNOSjdtc3AxTENBVjZENjBZUStVVXIwNmZaL0hIQjhBLzEzWXRl?=
 =?utf-8?B?VE5IYjhXNlpSbW9PQTFkY2NFUnp5RTIyeGw4QWNjN0VQbVJqTXdWcW9qaGl2?=
 =?utf-8?B?dTVRdERuN0VEQWNYcVIycmRMVlBlWGRmU1JPc1NQdUR4S09kSkh0azZNVGp6?=
 =?utf-8?B?akdzcU15eHpRTmV4bnhaS0pkM1ZDWk9CdXg1YkcyZlBneVJWNnpKUmxNekxV?=
 =?utf-8?B?b25jbjZVOVpTdHlIVEd6OFVlQVo4UGhMdEU3QnZBRndzY0F2RTZub2Y1TVU2?=
 =?utf-8?B?Rmw4Nm04Mm1rSE5LM2xLRlA4eWJIQ2dIZ2pRUU9qd2FYRTI4Tlg4VnRiMk5G?=
 =?utf-8?B?a0JBQ1JKVG9ZTGxxS2I5aWhVN2w4K1NZcndnZ2M4N2wvanhnTlpvVG1PNlJv?=
 =?utf-8?B?ajZma281YnlyWnJ6TzZiUHNsSnVlcG9ZZmtMeTdQVWFDdjJPSEsvM1RzU3NX?=
 =?utf-8?Q?aLMRfknAQyU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxIVEg2YjZKQzA0UDAybEN1cUhQazFUTXJsMHFVOTlsRFZiaHh2U0JSUGx6?=
 =?utf-8?B?WERaT0NCQkhQaENJR0pEdngxZEJTZzhaRGp5bWpUVnNFa2c2WEFxT1U4eEth?=
 =?utf-8?B?QWszNGtQR1JxcW9nRlNKUFFyM3FHSDBzcXVHNnNSa2FqNDRNaW1jZXZSajBI?=
 =?utf-8?B?TmpYOVhucTU5UGJNUVJaUXRad3Y4QjlRZENsNEo2bnhBWEc4ZlBEUGRnQ0FI?=
 =?utf-8?B?WkJJT3RvTGdBeDJnSDFLUm45MUNWbDc2UzJhbGViaE9oOUN2cHBEV3lENTYy?=
 =?utf-8?B?eVZzb1hGcjZHUWRTWUlZNmpZTE14Yi9BYlluVTFQUktQb2dWeTJaazI2S3JH?=
 =?utf-8?B?VzFGdlo0VEQ0V0FEVGg2WE11VnhIQjlVNk4rKy9QYkhmU2ZKazRMeStCRzNO?=
 =?utf-8?B?RXo3OVNyUUNFTlM4YXRXVzlReHRnM0dZVmVEaXp1Y2ZnSElYTlRDVVZha0t2?=
 =?utf-8?B?ZlJYVjJCZSsyMUxrZjBsMmt6bWozUVdRWUtwN1cyVysybnhvMk1lT09xYndS?=
 =?utf-8?B?UnRUQkFXU2xpUTRJWXhWSDk2dHhzYno1NkY0bE83T0JoSVpieUFocXRjVitG?=
 =?utf-8?B?dGdjRDh0VUFOTWFDSXdPc2VxaU1ITThvcXMzRHV0WC9BeHkrR3FmOTZDSFFz?=
 =?utf-8?B?MThsT2dWRWhFM3pmMFdWRTR3TEJYYjNuNkYyNzdneHR3LzhJQVRxYnU0Y2Fm?=
 =?utf-8?B?eTN5eForaUN0V01IZUdFTmVmVFM2cWFJME16Q1R2TEpaTlFod1pUNlJnK3li?=
 =?utf-8?B?Y25oMU1jQ01ZTHFNbkVWTHBZNTV3TXdSTjF0L0hUOC85MmgwY0JCaFd0V0ti?=
 =?utf-8?B?ek01ODk2bG9PTUVoVFBFVW1JUWx3N245WGdFZUpjekNhb3RrejRsKzlyRkpL?=
 =?utf-8?B?QU5QaEhwb1p0OEZVUldrNGdsRHlxQjRmcC8xd05qUEdJa0t3ODY1aUQzTlNF?=
 =?utf-8?B?bDFIaThvc1hQK1pHS3JBbkFvWEVseFAvaVcyY09wNmhwVWRDb293Y1VJZjFv?=
 =?utf-8?B?MmdwdDkyQlgxcGs0bE9ucW1UenRGTUlCN1lMK3ZQektmeTNGa0g4a2Y4NUR1?=
 =?utf-8?B?TWVlZWNjM3FTbk1Zd2xMeSsvei95TTR4YVg3TklYTVJtU1JkYTlETTVqMUxz?=
 =?utf-8?B?Y2dINTBkajR5L0hCalJwVjBWY3BmYnR3enRPTnhGczhubk9HK1RLTnU4Um4v?=
 =?utf-8?B?SEVldFZ6ek9xOXBjYjk2UW5vV0Z3V0tuM0V1RWhLYXE5UVpnRHFOb1ZtNnp0?=
 =?utf-8?B?UXZwVkUxQ0UzM1h6alh5N1owNnE4N1ZrelNsUXoyOURJYkVDSUtsdTZBeE1a?=
 =?utf-8?B?V0VjSnlPeW1TME9xS0U1OEsrYW9XVUtYeXBwSHZhck9VYXQ5eWxEZFdwY2t6?=
 =?utf-8?B?OXpjTHRiWlg2bHQ4cHFxQUdBUkRaUjYwWnlzWjgrUGs0ZlNVUWF2UGtQSFpX?=
 =?utf-8?B?cUxpQTdmc3c0SnlEcG5ndDYydFB6S2JYZkFTQVpDa0JuUUVKZEEyYWVOZ1VL?=
 =?utf-8?B?My9YMG5kdDR2NXlLQ3BrSDIwaDh1bkpGcUJhQ2dXeEFZeUU4SGJpTGZ1RDJL?=
 =?utf-8?B?Y3ptMlZIZnhvc0Y3WW0vT1RTSXQvVmtuUWVvVXFJTXkxS2s1OHJTbXAvMHBO?=
 =?utf-8?B?Y2JWRnR3dGl6RW5wVHVrc1VTem5GM0FkNVV5b1pBdE5OOU10ZXhnL0RMVkQv?=
 =?utf-8?B?ejY4Qk52TVc0Zld1OVFNendVWUVwMjFMT2ZqVTAzdjNmdHhkbzNiOWdnaW9O?=
 =?utf-8?B?UWpjUzh1N2lic05KanFOWjRIK2ZrOEZQWGI2TzRUTnlnalNDbnhSMW1qMkNL?=
 =?utf-8?B?S1l0Q3Q2L0JNb1FEWm1VWGVxdFU1Ung0R1I0U1prcnhBRWV5LzY4NGU4NVdr?=
 =?utf-8?B?cHpRRWhMNkQrNUZrc0xQMVBWS2tOdTM4bGRienJHNXM5eENHR21CY0lqZnpW?=
 =?utf-8?B?SVV2a0twTWNtVlB1QjVQQ3JyL2dNRUJPcEx6eWVZb2N2TVV1Rnl1U0tVRFhZ?=
 =?utf-8?B?YmZQVFZKaTBiOUdDNkRXdUF0N0VLL2E5YndpWVFrSDhycXliSXR4YnVFRHFk?=
 =?utf-8?B?MmJ3U05vbmQ2WThqNW51b0J2bDl2UGIwOFRFdjZzVmg4SE5FN0crTFRKOGNr?=
 =?utf-8?B?b21qd2dIMTg2cURXRE1CSjhUWlRYNjM1QVBJRk1CNGRRQnRYb2EyUDd3clFD?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab0ea12-ef42-4888-6850-08ddc3aa4830
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:17:08.2554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4CFVy1p45qJgAOBHkV+y18E/qrTg2vY8EINl2IDggN6u+U1fv7c544rQwnoy5avlI12QfKgw30OK+Ko17Ii3k5ng+k1Y8dckVx84n68sLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
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

On Wed, Jul 31, 2024 at 06:06:33PM +0200, Thomas Monjalon wrote:
> 31/07/2024 13:01, Thomas Monjalon:
> > 30/07/2024 19:27, Jerin Jacob:
> > > On Tue, Jul 30, 2024 at 8:25 PM Amit Prakash Shukla
> > > <amitprakashs@marvell.com> wrote:
> > > >
> > > > A new flag RTE_DMA_CAPA_QOS will be introduced to advertise dma
> > > > device's QoS capability. In order to support the parameters for this
> > > > flag, new fields will be added in rte_dma_info and rte_dma_conf
> > > > structures to get device supported priority levels and to configure the
> > > > required priority level.
> > > >
> > > > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > > > Signed-off-by: Amit Prakash Shukla <amitprakashs@marvell.com>
> > > 
> > > 
> > > Acked-by: Jerin Jacob <jerinj@marvell.com>
> > 
> > Acked-by: Thomas Monjalon <thomas@monjalon.net>
> 
> The RFC and the deprecation notices are sent a bit late.
> We cannot conclude there is consensus.
> 
> I propose to raise it to the techboard if an ABI breakage is still required for 24.11.
> As dmadev is quite new, I don't think it is big issue.
> 
No objection to changing the structures. However, for the actual
implementation we'll have to review the changes to ensure they are clear
enough to allow potential alternative implementations. For example, I
worry about just having one "QoS" flag defined - how would we manage if
different QoS schemes are implemented by various hw vendors in different
ways?

For the notice about structure changes though:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

