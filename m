Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF15C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 18:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B81A3402C1;
	Fri, 13 Jun 2025 20:56:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 94A81402B6
 for <dev@dpdk.org>; Fri, 13 Jun 2025 20:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749840967; x=1781376967;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3U9VMrZwX99UHgZpf2jmW1zklSncrgwKFIcD0E+8nwE=;
 b=ZaAoMB07Mc64LabA6e18W+QFBroH45EABuoSo20h0mGDS4iCyKqnwoDq
 HoqygqmCgJYN012e/Dm3z7M5jnkPQ6jwiIcKtLxo7HrDgOjKoJL/bsSDR
 PxgDFH6g8gSlwIsxp9l7zZq7Gl4RxfACc90A2O9ERH+zF9N8HAmEdpQsq
 BXnmNkHG28FVD/PqVuMKYjaSXNm06yQ8R9D/3SKYpbt8dcIG59VH23XOV
 U5I4wBa73LRJQeHpL0+e/T3LzHemyrVWaK8Fb2AD0vPWC8qukasaW0utQ
 u+qh7ZH6ttyDSzfoE288eELM0VB5d12+RkEN8PrDPbRfrepQ+d6vOmjxD w==;
X-CSE-ConnectionGUID: DXklMF0qQQSy9en5ZJDLkg==
X-CSE-MsgGUID: ySOA8lfwScmtjm0k9YMKwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="55867017"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; d="scan'208";a="55867017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 11:56:05 -0700
X-CSE-ConnectionGUID: Y302VttSRXOBrAXqGz3kLQ==
X-CSE-MsgGUID: lWSsKj7/TY6xp/wDyiMiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; d="scan'208";a="147746479"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 11:56:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 11:56:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 11:56:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 11:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoKFhXCpKtm90ezIQVI7xwgmR7hdHP3DmkHsMveHsd+aMoB/CBtVJFRDEBzbwiHpJkXeB2n0gmSUvLuFyCm0u0LrEoAEvKUfP7hKxQhWHcSgYoM4v36KFznVoRkvL0JZ9OZDBSEtxe/9/zrge6UMv342wT82wGQ+D+73tgcQuFrhQioVI08OLlFmEBq94va2EsbSlb7SfhMuvNdUbKrzD9TLjsMJk+QVtxOI9cqiHc09CHumRF/vZIkzxM70sFpY5khviZhYzU5OMNkvhmyqWNQ9YhTtePuubhqQpoDwIyffoPFb/geYEhtssnuGPLhLzXwbizymny/wcNpGKZeUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U9VMrZwX99UHgZpf2jmW1zklSncrgwKFIcD0E+8nwE=;
 b=GOpnrm+wieYRJWZ/AO3L4nW/s/R5HygPzWGk1L84KjXgjWjtFOqhidRtlSjgFTiV/zav+Y9ir/h0rBg7zF9hf8k0X+ywtdE4vDWYOpWr118IjtIf8P4ZxbiDI2g3hy4C7NpN5WIXtCsL6fbKFu3rsy//fIhUscR+u67likibe+j0bzHU/PmPfeEv/QnYHweP/7xocNjW3WXCr1LSJVLTrLrY0h1Pr2poICFDbmXxPzX41dQ0tiStIPHYW88SC902n8GD9FO9CKegRBgJA+mxz9ppAW7sl8v8kFqcm0duTWXJugG2lZS7OjXmKMjJQYiA3Any0of+xQnTecvj2JOX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 18:55:47 +0000
Received: from IA3PR11MB9302.namprd11.prod.outlook.com
 ([fe80::4e88:4339:fd2d:aa1a]) by IA3PR11MB9302.namprd11.prod.outlook.com
 ([fe80::4e88:4339:fd2d:aa1a%3]) with mapi id 15.20.8813.036; Fri, 13 Jun 2025
 18:55:47 +0000
From: "Chautru, Nicolas" <nicolas.chautru@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] test_bbdev: enable to be compiled on Windows
Thread-Topic: [PATCH] test_bbdev: enable to be compiled on Windows
Thread-Index: AQHb264xh86zFNC+iEaQeNt7ZvRAjrQBcfyA
Date: Fri, 13 Jun 2025 18:55:47 +0000
Message-ID: <IA3PR11MB9302BE3FF3BAB6ADCB780589F877A@IA3PR11MB9302.namprd11.prod.outlook.com>
References: <1749741884-13081-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1749741884-13081-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9302:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: 8375ca9a-6bb6-40fc-74f5-08ddaaabe8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5B01ZsziPZ3KvfaYMN8SqU6sNX2wf8LTfKayHEwuMqThwL5QXZ49YWUSoDNE?=
 =?us-ascii?Q?H/+q6T+7y22Vw+Tqkqpep2nepml0xTaEKe/kObUMqjZifbrFuIONRPnJI/3b?=
 =?us-ascii?Q?gB3WOdOIX6WDYR2p447goQou1xiXi4UqsPbVWNwEOKgtvfN+jzUVBW6hinYe?=
 =?us-ascii?Q?r27hooA0xP18G2LbZBc6R769nJUmm+9Mxo1bmIpvo9k+TeMqIm33yrpPjph+?=
 =?us-ascii?Q?C7+9zFoHA/EZwli3jSXgkjuXZ8g0MFfnEV2T+1ZdrurzP6TdnGW/AaiCj2eb?=
 =?us-ascii?Q?7LM+rLjXPzOQivgB4HS7PrIUwostmHobH9bGh05/ZUD2GxrsgVnqDEkdGRvz?=
 =?us-ascii?Q?9ryLIKTkeu9is/12YupXfCrqk/oyXUgWV22tvXwMsd9G/bs+NkbZxIe+8AG4?=
 =?us-ascii?Q?Kopidc9Sx6N06hop4fkk47HboyeFftSBE76kKqPRgA72IPPueqSv0ey0o7Dt?=
 =?us-ascii?Q?rHUjKBM2ecPPVEHboJpD+EyZxo/IhgiL5p5DUeKKenfw0Yo3sl5Sy1PeOGob?=
 =?us-ascii?Q?EBwCOjk8uHG7Z8KvTheo367m1o6f0XA2cNvmt0nksiiX48ZD3hYmJ02IisWo?=
 =?us-ascii?Q?eOIVJ8jEFhSyV8H1EDPlddvpAcLcVHrLu2KZl4jGvg1gUrNqbhDDnxT52TP0?=
 =?us-ascii?Q?+Y9UmTC89asrHhNbAxOdh3Q24O6cy9+FGw9c32vN0+7mPpDboWXt5lOOq2Qi?=
 =?us-ascii?Q?PSG4i1IqZ3wpVmmPXctILABz2Lio41CWf3jrHAVB8Sg6R6mtPb2mrpZLNncw?=
 =?us-ascii?Q?tfJh/2rhALB74J5LC6R/bIxxqV5TwSkERLojYHk6/pyQFaj9mqn6epi7hn+X?=
 =?us-ascii?Q?VRSPXsnd3grcou6o0PE/HJ6WF71jnLI1i2XbMVUXEMqeddMjvER+3CyvonMQ?=
 =?us-ascii?Q?y796GtrNJw/RuiPGKxUyRKOAGfCvC4ytQeDD+dPBICGIbFQt2sII8hE+Wp1Q?=
 =?us-ascii?Q?xw2+UxnbHG/G0fEcyvQyAUA6Lqj1OhU9tQl+sFKvKslNmqkERYhwq9OZYQ5n?=
 =?us-ascii?Q?76dZNc/6Eq+luFT46GhXEFg1oBPlsnqgbfh7XeRhYMnfDvGUw1dV/kD1QqbK?=
 =?us-ascii?Q?Yp3WdKjCCjLMeMhaAvilRjFkC+H8kCG2PTunyqHhgu1jjCtxkCDUUT2ShMU7?=
 =?us-ascii?Q?FW6dyTccgoeJFckxrpdTPc26Wi2Oh2sHlOKCsdXSsy0KgWUKOotsYZTYCByQ?=
 =?us-ascii?Q?tCdTH4dOFAwgVoUZ5fjLKxa3CyPvB8fof6eNkAxvw2vcurntzovA2rDI41ch?=
 =?us-ascii?Q?/nseO2dkGZaMrJKNiDryFquqC3kIrIaJR13+kkjqc1a9PJI2YUZwSLBBGtqd?=
 =?us-ascii?Q?x+k7c7wqSqh2H6v9jf2szbpc4Q8PYOV4BIfPVgRD+oDsb0vEV6vcfFkcA66D?=
 =?us-ascii?Q?cOqaAB8S6OoPC5jSAhxpnqIhbyvZhaczJlg2AVe9JQJgY66YBP66qnXXzunX?=
 =?us-ascii?Q?QpAfLvAZtXSLSZyTFhj02ak/wQB66JmZRLa4Z5HzEqcafj4zmkcQ7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9302.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/JcT0aCrYUvcLRK5g/k5IK5CQHgqPxiuVwgXCbl34YXR3mHirvCu8wtPNZL0?=
 =?us-ascii?Q?WZhup6wfUsL3Ph8k2c753PTdpKrJjxG7Nx0iMrI/YGkdoBcHvLAJmqeYDBrz?=
 =?us-ascii?Q?hOcKG8bkArbrX/3vUvtXAHH3/VkTgP6PL3sgO5OsOHSUjamDm2ECd1Wtvulm?=
 =?us-ascii?Q?XeaGxj/wWK7VYVz8mRr+tUUGSqfZiWfNBUOENjL/EP7LTPHlCalCpKA3GjUE?=
 =?us-ascii?Q?/LRbzscIIzIYi9wB/dfnZH3qTiGU8/2fTw+gejDb2flxVxMmVq+3A8KcgDAL?=
 =?us-ascii?Q?WQ5vSTTNITNDXwZPiHbu9IM2EFdYkYdldZ/oE7U+qsl49qlh03H8dnOzp8qw?=
 =?us-ascii?Q?KUxk47aRkDaIxAqViVt/spt2STaOOaZz1oqPOCQC0Up5CXRTEPQL8Zp3eL8z?=
 =?us-ascii?Q?BmfIoE85hwer6TD+P5uL/g+Vb7U4s4RkrESQ16WlO8WIQAj4hFWYmurFGfot?=
 =?us-ascii?Q?xDNHJu7QcjlNZ0a4DOdTlDYO1zLSkYwV5pSnWzCJQ+qaz32lCN98mJxZymCk?=
 =?us-ascii?Q?9X5K6PUXxwt5dQ1RcLN4YeDgy6GUZZMLEe4gfOHM9WRKG+TJYpKK3rhypBFk?=
 =?us-ascii?Q?BxKeWJ8Y8NmMDp5XwSMqPbHpRxmqiAFPw7c22G5kgPUieM3aSSfegS449abD?=
 =?us-ascii?Q?tf6spWVnfACtD3+0PH1vF8unsITvJCu+t3HLM8b/rrpCS4AJ8Lwc+iYDkpDv?=
 =?us-ascii?Q?2jc0/GoLovVwiFeO5MykwP16P567OBeQgwKmvTxt+uCJMX0e14dYCVdqEQzW?=
 =?us-ascii?Q?eriCtrE05vyVMYtqFqTLjKnrI5df+8MwCMOpPMePIsXChuzPXnIXxMNJRiz1?=
 =?us-ascii?Q?bAUX9u+eGbZJEk8tlINtcBqXhDTIogsJ0HTU2Xw7M5AsPbvJFd5nCdGxY69m?=
 =?us-ascii?Q?rU/Xbb0ynhKqZfDWsn5qY++LpsVbug5cCiKGRxcgezHajzm40OiHQ7wxn1w9?=
 =?us-ascii?Q?CCC3GTxJ32BmfrueDFeWIEfomdKMY9J0FqnIl/xE6wxRUtSfyPqzoIPZO5dN?=
 =?us-ascii?Q?oVjJq8haDgOZtaqlsviqjlmmS0csPO/iDPdb1Btf4v17tHKHRUCnQGeJXzo8?=
 =?us-ascii?Q?bXVhr9595j5+wLjSC7aG8fVCxcw0hmhs2u5yI/HFMjpiRYZS98iVLc/2pj/k?=
 =?us-ascii?Q?BWKerLj4dn2HpNYoKrljfj31StGHbNo6s+IcuZWnK43z49/C8xpZsJ4iI6Fe?=
 =?us-ascii?Q?9bK1G0MIiR3UW2ZFJXO1vmhX19dLx1/mIdNISzTaihiKTFpyXG9QcbS3PTLW?=
 =?us-ascii?Q?kBwYuXjRnkEJuZCv9SKxU4YJxkPkSY5gy5UJ3dQPW/xXYCMSbwIcv4PzRpCD?=
 =?us-ascii?Q?BI1g26C5DXsa0bGlkMUbSyYjfEnq2qg+wgnmOJbN35Ev4nre9D7IvKe1BsaZ?=
 =?us-ascii?Q?a1+n1jDFYKbQnsZQ4N5XRsIZZ69C/EgewYjld+nOnLXXwyjJFdlXgXUi/6cY?=
 =?us-ascii?Q?SfgBtk6iftTTZOQC2DRqKLgDc6Pt3Y2D+KPQUiRaE7oQPK9lMEC0dfkBOTOq?=
 =?us-ascii?Q?T9+BUQ6SJQ1d80wok69Yj96AZ7WAl1424qCM6p2txJoT+XJcd1KVshFWnBP6?=
 =?us-ascii?Q?p0k98RavjcAWmncLSlynwwFwIIQ/cNGzHv5wFTY9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8375ca9a-6bb6-40fc-74f5-08ddaaabe8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 18:55:47.5644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnRIxmMEmhMpibZ3eG3X+lKgDWzj76M/09qFjoR/GF5K5MlJzCTxGljtovYq7v6j2fDcPYImdQwPqs7NoI0gieUKtEkk9ex55oeQiLUNArQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
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


> -----Original Message-----
> From: Andre Muezerie <andremue@linux.microsoft.com>
> Sent: Thursday, June 12, 2025 8:25 AM
> To: Chautru, Nicolas <nicolas.chautru@intel.com>; Dmitry Kozlyuk
> <dmitry.kozliuk@gmail.com>; Tyler Retzlaff <roretzla@linux.microsoft.com>
> Cc: dev@dpdk.org; Andre Muezerie <andremue@linux.microsoft.com>
> Subject: [PATCH] test_bbdev: enable to be compiled on Windows
>=20
> This patch fixes a few issues which were preventing this test from gettin=
g
> compiled on Windows:
>=20
> 1) VLAs were removed: Variable Length Arrays are not supported by MSVC.
> Where possible constant C arrays were used. Where that approach was not
> possible alloca() was called instead.
>=20
> 2) rte_os_shim is included because this test relies on getline() function=
, which
> is not provided by Windows APIs.
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Acked-by: Nic Chautru <nicolas.chautru@intel.com>
