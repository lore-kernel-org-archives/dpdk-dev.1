Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F9C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 16:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE020400EF;
	Mon, 17 Feb 2025 17:17:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A949F400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 17:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739809037; x=1771345037;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=CgzW18h0O5yE2NqGgXZd07h6TkP7fNZdvZtRbr7tY3k=;
 b=cLoXccJGOZDQv7VXzqqzMAYXfloDTVBRL3ezCjjOnDzh3FF1YjqfYCIA
 oWPs25Fli5TODL8eebCfQE0WeNjgbBtL15v471z47sPsVvLdSRGRP90IA
 FPY49kbzNq1wd4AbffAYeHhn9kKLwAJtZqu2kxcxEcd5wYOgQ9KF/GHwI
 /fvD5UyKmYzV4eGIhjkYP1vz7ze6q6sYMvRQ8xRq+BQVGX2RqlTrMczgJ
 qzS5dyy2dYllouKHyeKpG7zX7nbnP+5v2uVkTBq5yDb1jEUTsmoUK20lQ
 pkN/oenhbsexZucRQ27/R5Xl6UzpoNaY2uQ1ZWCdaN2jxZA9pIACKc5MI Q==;
X-CSE-ConnectionGUID: 8AP9bVmkQpmMkMdR/u4wAg==
X-CSE-MsgGUID: /gdlYNybQUOGl4XB32JEMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40621130"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208,217";a="40621130"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 08:17:16 -0800
X-CSE-ConnectionGUID: HL8J2+KwRy6fRbX91hvhHw==
X-CSE-MsgGUID: ci8Fy5vqRPySFghaZL7w2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="114632521"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Feb 2025 08:17:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 08:17:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 08:17:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 08:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Q8IUxgI8iif7y+O0cbwjR/56h3l30KuSqut/xzbSuLC6el20nBjxtO2jP/xPo8wha4xANawNb5IVOCe0iju3qtRGW37gv3jwIeWseXePsCTKEMr+/d4FT2FIYMe6qXtUtuHbjuSvMICim2yCEFCV8mZDNz20y+UBTR6xjyHCJe+5JVh0lSBBP4Ma9d3sf7xcEGXSeNU7x2D8IGcFueVvtgqKg/DSsQxrmRS1Q2NYHgGt5exQPjAUojLmLpQrHWIN68Sf9AfrNXwn1uihbkYcBt3+soHdwj2+X728psildzqylWL6/EMgTaDegYCzx4AuYSXoV0TuRSD1oK+Kg9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmTSYcZsk/XsHocUgR2A55/r003gJLbw/eicIDHS+m4=;
 b=JXHjUGVkcG41lEnyCRQYTVlsEZyVr5VmrCMMJinsJKRR/x4sIchvoSQost+WqZSSqPR2ew8hVPzwK7/hucXvxprM0PvjEstv3+6pvob16XW203lAbkmb14xKC/6YDcgyy76QW/gi7kPVvz1vcxysCPWxzAoGPDq2qNNZhuNPc0zgEfbzx4QQ15DQV0JFD3h6eoCm8vFctSw216ZdgQLzQ+Zss0+Cchm63NSy1WpG2agp0m9uvCvmUMj4T97sLGKoSdolfxDJH076dWqBmMS7vZTA8DMIgYg0IvBb+rgl1N7X2rexruE372FYvIm9ZIMlRSDNt7Hpfku5mtPkQfn6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 16:17:12 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:17:12 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>
CC: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH 0/3] Rx adapter API to add Rx queues in burst
Thread-Topic: [PATCH 0/3] Rx adapter API to add Rx queues in burst
Thread-Index: AQHbeWoLGIMo3JJYm0eRbqrdCQtpBrNLu5aK
Date: Mon, 17 Feb 2025 16:17:12 +0000
Message-ID: <SN7PR11MB70449B905B53E5EBFB474F87A1FB2@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
In-Reply-To: <20250207140910.721374-1-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|CY8PR11MB6916:EE_
x-ms-office365-filtering-correlation-id: 36210af2-0a8e-45ad-7ffe-08dd4f6e8929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pbLropN9DCE3o5fqof+uax7dd4kypz/E5HqKiQrnPBkC5OdQ5O1CMA0IAG?=
 =?iso-8859-1?Q?Dj3UpspwGJuTy3R0YLbL48PJyZR/PeNM0wT4QCvKOLBZbvcv+j9S3EY6Xg?=
 =?iso-8859-1?Q?+7wRZGddKOWT8lBtFyGRzoq/fO8pu0drzVsHbK9PFft0k0eAEgP/nIBVgf?=
 =?iso-8859-1?Q?nViBh7aEMrBTkOWGhT0ug2SRSYC/G9lBRdVr1uyoV/de2vm4VrgqpoLmDN?=
 =?iso-8859-1?Q?UpGv5JfiHA6wt4NZViDlQGYUDmK1Z6T3iGK4G26hjW3xHKV6JRhUpgwXln?=
 =?iso-8859-1?Q?Mmo8z4f8K8eBrE0xhyfH5y4aqm14BlYwpM/ixYiLemhTvlLezV1SdXzSCW?=
 =?iso-8859-1?Q?rgP0Jh6ZErsn/8odztRYQdop8ycKrEX36Cmc+dTTms3VBMK+bhKo4UJt+n?=
 =?iso-8859-1?Q?g+nEYFMZNALce0iBmDqEWkd24LOj9SPw2sJXAZOlX9OFP03pSbKFlrTri/?=
 =?iso-8859-1?Q?IBKLwkH5mS6LwIup914Zu2uXQ/2OjNbdPAqVi+YvjRt0RX02ztTXgV7j8G?=
 =?iso-8859-1?Q?+NC2j57hn4dBBBO+bgJ+rj8wEwYrdkInSiSuRr4XIuDuL2eFqBTz/T7T5J?=
 =?iso-8859-1?Q?JqrG9zgDm1/Mw+6wFtjFZ2VhW7gHRM21UbaYgNv3jjSwkZAm+iJMASsgtW?=
 =?iso-8859-1?Q?3vBZzWjmntqgjCCnltqq9wxmW9uCwFUurQkW9d+uLp2HBjfh/T03hntjtR?=
 =?iso-8859-1?Q?gAJNa+Oxp1Uc/ccW2LdD/clIZDjw/O2Q+whvRaOWp0fDtUzpR4s1iJJC5v?=
 =?iso-8859-1?Q?JMfy6xXRKxzazByAD368hHPAwAa2zpuPyxQQanUvrX2T7ONzcw2b+6CcDQ?=
 =?iso-8859-1?Q?pusI8uw7uMhLfLJkrUquYchSnQ7lMjRuMXxbD2Ys3qUinbaIXpdMytZG5+?=
 =?iso-8859-1?Q?UtUHvgnP/9VUjf14nf9VQainKjPhW7g4dJOVBLjxkgd60RpQNTVKvrBUS3?=
 =?iso-8859-1?Q?pBlMXv43wDSOpOsWcD6e5KEq7uw08PUujyyYFeVgKRd2eyCXYOf8vR4lBe?=
 =?iso-8859-1?Q?sMSZuh3G1m0/KG2XMxCb1ntNp5A3DDYF1W+9onI/phUi4NjevFenIGnTvP?=
 =?iso-8859-1?Q?X3A47PW2VAr6+2lvslKUsNOTdqCzQKSC2yi1ph4aoPUXDGPOeb/5Gh4/BC?=
 =?iso-8859-1?Q?chCAWFReHGC2PS+QMQM9FLxR6Eu7PnPV7+/nBCBjNhtuwLTCeEffYLfQ4H?=
 =?iso-8859-1?Q?1dS1dKLLNAUSs2TPQQ/SgMtVZGm62dwDxAAZ0wtn004nhfG3+MS4hw5fLq?=
 =?iso-8859-1?Q?L+FwYvUR1+3NEgYkUGbQ2b8ripxlEMFfu9TE8wZc2C1ocgkZxrw5Y5nsaL?=
 =?iso-8859-1?Q?Avl9nz77HNRgXYyLutkZB6ryrrGjcH/VguRCiewi7pte+1zPJWIIu0VNmt?=
 =?iso-8859-1?Q?Vy4UxcLwgEyGEUtIq53gBuRXiSA3UasecvQ6e4TK70mRR3xYFNxZKTUXpg?=
 =?iso-8859-1?Q?JfkrvD9KVr9hmY1t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iARtZKvcdeaoOhSxX94Yp42XqIUFrmQJvCNyqCk6PXgp8FYuJ258uulDnO?=
 =?iso-8859-1?Q?hykmJj+6H54jxevU2A96tJyGNnblYz9FgNs/s4Kwz1Okl7nVTbu+hHh2CF?=
 =?iso-8859-1?Q?zniEISetTmbthML6sdu4mOK/AMv5c6EeYZxK3jgY4rphSxrfTntaL9MLld?=
 =?iso-8859-1?Q?H7FEoBMOomPrVS/NoEjeOzUrShhXIiyBWkboqwLk+ITTplAB/zdGVif86b?=
 =?iso-8859-1?Q?6UMfGoeksxxbEzoj/yTxBR8B1SljVvjaT+ueC+iZVqbv9JEkrJYX+BITCX?=
 =?iso-8859-1?Q?wuCTn0UUk4yPLoJ/WMW6A1A72lpnidwkt6/QgfmD0jfD0QvsyBDbQd9FJG?=
 =?iso-8859-1?Q?0PiwkpN9vzKuPnxU/zqCcNTwrQ+2nyEAc1OVUPLlYW7IuqkQVnItoN/UK2?=
 =?iso-8859-1?Q?UAEZd6TkS4W3K7BoUF9lk3+zDROupo3voO3PyfU/GbbFD505l7ntdvKoDN?=
 =?iso-8859-1?Q?vtwNdB8huNJFCidFCeuCl3+24coYPZ5THpL5u5iWttCruYV/3HjP18Bil+?=
 =?iso-8859-1?Q?jy5CMLau6swazLCOixBOpbqdDsKq8cZSfZJLb3MZNC3CApkYGcbARvZxVY?=
 =?iso-8859-1?Q?fnpCM3/fhKQXGBY1mYCQxWgXwOpu2h/ttiPNT14jsN7tyI4THvSfGYuowH?=
 =?iso-8859-1?Q?V/ZdnB2yG07Zm2pA2zFW0UmbxRg0psU9hUPJ1KVAmzqZJiOaOYFMN8k6JJ?=
 =?iso-8859-1?Q?MEDb1pQ5BCq/Ud9eDi8MhYwlV6kxZrj05aXyvCV3zldLDZo6cItZcH8Ot0?=
 =?iso-8859-1?Q?oMx4gZzFDdd4hk2XcJMf6PD99DKuqimVKtaXBOmHcU36xZcJUA2EBnJIVf?=
 =?iso-8859-1?Q?hjkdJgueYbLcdv35/4UTYeJTQ0UDWfcUcX0hTyKTqFJvEzJQ7pCZmJ2O3Y?=
 =?iso-8859-1?Q?I4Ak5yW1b/TIFU3FfnfeiWrLAtnnQ51P3t88ZPZWz9LfEgX27/qIrH30A0?=
 =?iso-8859-1?Q?aE6LEK/bztWF9gCVIMIKMo9n/UEQXSveZOWGSQnpQW3hOzH0Z9aV9B3Gcs?=
 =?iso-8859-1?Q?puZYz4DnA9FlfEYUCsKgPKDu9CgFvDS0NvHQDKmzf0JDg76Gfg0Q6OKpRZ?=
 =?iso-8859-1?Q?UnrB1MTF8zRhLceEmpz0BSBwItiTJpjtomdqQYnhJYET19sDJ1MsipN89u?=
 =?iso-8859-1?Q?TH2k5ieOzKZ8onWM+eYPebAwHOFIpv1gFjzBzeSLXNDL+PB4jSai3VtAMi?=
 =?iso-8859-1?Q?1dHOuqsMVf5DVDCJ3Ps38baYca6g8y2tvYS3gPcp8MYVS7v5+PK8u5hL24?=
 =?iso-8859-1?Q?och1Tm5Nwtv+W12iRu6Jeuf9CaoKejYlnuPSmigj/3EaNDZE9vvch6dxbU?=
 =?iso-8859-1?Q?jzQ/UI6bx7S8BM2xG1NolQgAckd7+X1raNlGMtDTHl/NKEi+WepKf2k7r1?=
 =?iso-8859-1?Q?dh7Ar80umzjrUoFchs6KnfaN7Yp4HUg8Vko4piKJQgD17MTt16gUMdOZS9?=
 =?iso-8859-1?Q?aU2MFMK70SbyVhgUqY6yEVAKYTOwRmPoMRfRn4G2L+f48F7ca6RJP8GWSB?=
 =?iso-8859-1?Q?/OI67YW1PcYDaoOyKegfnKHMl8JKL8ebV+LFeLeOgbCHXjBs5bn/8gEmZv?=
 =?iso-8859-1?Q?mfkr8dlU6zUdYHpzgytQ4VuMlIcjsSCXGG4rLEe9NVc73jdPAcmzKymlde?=
 =?iso-8859-1?Q?/YbyIsQlsgbdJKUDBJkdPOZHD+o30nHUS4?=
Content-Type: multipart/alternative;
 boundary="_000_SN7PR11MB70449B905B53E5EBFB474F87A1FB2SN7PR11MB7044namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36210af2-0a8e-45ad-7ffe-08dd4f6e8929
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 16:17:12.2468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVXsexekIhhxKpSfuXN7ummnsmho//YZpjzb3e0trMeLiJONbMrTuR8smEVUAmd04OSbR/FGwiMCWWTcXgyKrrg1gRRpZb68UOeJF+wtrkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
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

--_000_SN7PR11MB70449B905B53E5EBFB474F87A1FB2SN7PR11MB7044namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Documentation update is missing.

________________________________
From: Shijith Thotton <sthotton@marvell.com>
Sent: Friday, February 7, 2025 7:39 PM
To: jerinj@marvell.com <jerinj@marvell.com>
Cc: pbhagavatula@marvell.com <pbhagavatula@marvell.com>; Shijith Thotton <s=
thotton@marvell.com>; dev@dpdk.org <dev@dpdk.org>
Subject: [PATCH 0/3] Rx adapter API to add Rx queues in burst

This patch series introduces the rte_event_eth_rx_adapter_queues_add()
API, allowing multiple Rx queues to be added to an Rx adapter in a
single burst. This enhancement benefits applications that require bulk
addition of Rx queues.

To support this API, a new internal eventdev PMD operation for adding Rx
queues has been implemented. The second patch in the series enables this
operation for the CNXK PMD.

Additionally, a unit test has been added to validate the API's
functionality.

RFC: https://patches.dpdk.org/project/dpdk/patch/20241219073405.1724200-1-s=
thotton@marvell.com/

Shijith Thotton (3):
  eventdev/eth_rx: add API to burst add queues to Rx adapter
  event/cnxk: enable PMD op to burst add queues to Rx adapter
  test/event: unit test to burst add Rx queues to adapter

 app/test/test_event_eth_rx_adapter.c     |  86 ++++++++++
 drivers/event/cnxk/cn10k_eventdev.c      |  82 ++++++++--
 drivers/event/cnxk/cn20k_eventdev.c      | 195 ++++++++++++++++-------
 drivers/event/cnxk/cn9k_eventdev.c       |  38 ++++-
 drivers/event/cnxk/cnxk_eventdev.h       |   8 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c | 102 +++++++-----
 lib/eventdev/eventdev_pmd.h              |  34 ++++
 lib/eventdev/eventdev_trace.h            |  14 ++
 lib/eventdev/eventdev_trace_points.c     |   3 +
 lib/eventdev/rte_event_eth_rx_adapter.c  | 146 +++++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h  |  33 ++++
 lib/eventdev/version.map                 |   3 +
 12 files changed, 627 insertions(+), 117 deletions(-)

--
2.25.1


--_000_SN7PR11MB70449B905B53E5EBFB474F87A1FB2SN7PR11MB7044namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"color: rgb(0, 0, 0);"><span style=3D=
"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt;"><br>
</span><span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;=
, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;He=
lvetica Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb=
(255, 255, 255);">Documentation update is missing.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shijit=
h Thotton &lt;sthotton@marvell.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, February 7, 2025 7:39 PM<br>
<b>To:</b>&nbsp;jerinj@marvell.com &lt;jerinj@marvell.com&gt;<br>
<b>Cc:</b>&nbsp;pbhagavatula@marvell.com &lt;pbhagavatula@marvell.com&gt;; =
Shijith Thotton &lt;sthotton@marvell.com&gt;; dev@dpdk.org &lt;dev@dpdk.org=
&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 0/3] Rx adapter API to add Rx queues in burst</=
span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">This patch series =
introduces the rte_event_eth_rx_adapter_queues_add()<br>
API, allowing multiple Rx queues to be added to an Rx adapter in a<br>
single burst. This enhancement benefits applications that require bulk<br>
addition of Rx queues.&nbsp;<br>
<br>
To support this API, a new internal eventdev PMD operation for adding Rx<br=
>
queues has been implemented. The second patch in the series enables this<br=
>
operation for the CNXK PMD.<br>
<br>
Additionally, a unit test has been added to validate the API's<br>
functionality.<br>
<br>
RFC: <a href=3D"https://patches.dpdk.org/project/dpdk/patch/20241219073405.=
1724200-1-sthotton@marvell.com/" id=3D"OWA8e8d82ef-cbde-1dea-861e-04c071521=
8e1" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://patches.dpdk.org/project/dpdk/patch/20241219073405.1724200-1-sthott=
on@marvell.com/</a><br>
<br>
Shijith Thotton (3):<br>
&nbsp; eventdev/eth_rx: add API to burst add queues to Rx adapter<br>
&nbsp; event/cnxk: enable PMD op to burst add queues to Rx adapter<br>
&nbsp; test/event: unit test to burst add Rx queues to adapter<br>
<br>
&nbsp;app/test/test_event_eth_rx_adapter.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
86 ++++++++++<br>
&nbsp;drivers/event/cnxk/cn10k_eventdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 82 ++++++++--<br>
&nbsp;drivers/event/cnxk/cn20k_eventdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1=
95 ++++++++++++++++-------<br>
&nbsp;drivers/event/cnxk/cn9k_eventdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 38 ++++-<br>
&nbsp;drivers/event/cnxk/cnxk_eventdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 8 +-<br>
&nbsp;drivers/event/cnxk/cnxk_eventdev_adptr.c | 102 +++++++-----<br>
&nbsp;lib/eventdev/eventdev_pmd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 ++++<br>
&nbsp;lib/eventdev/eventdev_trace.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 ++<br>
&nbsp;lib/eventdev/eventdev_trace_points.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +<br>
&nbsp;lib/eventdev/rte_event_eth_rx_adapter.c&nbsp; | 146 +++++++++++++++++=
<br>
&nbsp;lib/eventdev/rte_event_eth_rx_adapter.h&nbsp; |&nbsp; 33 ++++<br>
&nbsp;lib/eventdev/version.map&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;12 files changed, 627 insertions(+), 117 deletions(-)<br>
<br>
--<br>
2.25.1<br>
<br>
</div>
</body>
</html>

--_000_SN7PR11MB70449B905B53E5EBFB474F87A1FB2SN7PR11MB7044namp_--
