Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3FDC021B8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 09:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 262FB402CA;
	Sat,  1 Mar 2025 10:29:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 403B840281
 for <dev@dpdk.org>; Sat,  1 Mar 2025 10:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740821361; x=1772357361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ssIjxLPPaGlU7Wx3nOzVtrTChdGQeiYPbLFGQYWEBpQ=;
 b=HSi7cRyD31jb33qDEPuh4w3GbPZrc5XfH6B9SWz6R3hGYreuW+VoY4tX
 +NIj+7KcqmCGgyPVheJS7QDUsKY88wmHT49xiTrR12CBQOdoGmgltJYuJ
 15pDdQw9SkknUZW9o+uld+5ypmFhPR2AiyKMgXzMBltjHTh0MzELBkFZo
 0JtQabRVkq4CbV3DwOPN4BEkDm1VX5F5gSM/pT6myVaDRVRS+NQWLvKy7
 sPfPXRSMfOWK0LHEM3qRdCP8EbIJQjMQl7orQH1KFdhjkNeW9ONR9AD/D
 PF4fEqzxxLv60VivR9oZP4WHZMnHzMpnUcuOlb0/pTiw2kAcZU7bbZVAl A==;
X-CSE-ConnectionGUID: L+9FvpV5R6a/gFG0FyI4Fg==
X-CSE-MsgGUID: QSyJ7i0uSD+mCI7wirICFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="51949778"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; d="scan'208";a="51949778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2025 01:29:20 -0800
X-CSE-ConnectionGUID: WVvuAQlqSFOlg3SPtQMvXQ==
X-CSE-MsgGUID: hhJLPfr1SaiSENFM4nfXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; d="scan'208";a="118046751"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Mar 2025 01:29:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 1 Mar 2025 01:29:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 01:29:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 01:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6NtrOudOFjiAUq72cnToTVPjlGnbYZYdjHS/CZNimdsjD5C5jDE2sXbtxljdJuXvmBXOKpr8w1UK8v39OTbD8gf5g7xdr129RNoaEtTjNfaXfKYwZQMGCfsNjqkQo0IeAmkQziBOg2jdZXQtcOTRsDSlv0QIMcZBp7FQ9p/GCQ6bW5cx2JtBeEimhklidDLpFwifVgno8kKHenkOt7/xWslPve7R7WALIGs7fZnqsAkj/zfQa21z6fb+R9KDaakYoBrIY31oBblJkCUKqvB/1Xn6kVhYRwB9HJklLT0Gb3wCmIjCdU22v4rRPkewlTcsAWw41MQFJyhpcUJijV51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohxjkg+NDjMio+kXUxKXlDIOZUMYnd10RhpYZ2a8OrU=;
 b=er+pY3nEdFOeJxCf3iaFZcdNwMadZ8OVvNEzOW0+FyIskm13XoBd/qHRSbOFk5tIPRKegy9oxe8peTgoOHecwe9EfEDTBXsQhDdyhfclZpV4WIJB8osIvLfim0uCcX9YYVoYlLAVDRjKmG770/ydaksQ54NkLvSVz1j8A9hc+RAMluAkO1CzPdy8BSZ61abv85x1L5bcwjgw7BOYGbiINXEbiwFc1gPHUnLt4omqB1lE4wixfWn4ekh88xKOR1XAzitg8Q7gVz3NQ7Fdf20GrVPZzmOAMQabBhBuSZ4mmOvQlijUO0Bx67f5BKZ81n6XHqSpbhy5lA+XunOFP274mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 09:28:30 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%3]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 09:28:30 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>, "Pathak, Pravin" <pravin.pathak@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Mattias R_nnblom <mattias.ronnblom@ericsson.com>,
 Liang Ma <liangma@liangbit.com>, "Mccarthy, Peter"
 <peter.mccarthy@intel.com>, "Van Haaren, Harry" <harry.van.haaren@intel.com>, 
 "Carrillo, Erik G" <erik.g.carrillo@intel.com>, "Gujjar, Abhinandan S"
 <abhinandan.gujjar@intel.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Thread-Topic: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues to
 Rx adapter
Thread-Index: AQHbhpgiVcrQJEldnki9+hhu5Q/BsbNeC0Rw
Date: Sat, 1 Mar 2025 09:28:30 +0000
Message-ID: <SN7PR11MB704428213D9E051B0E2FD70BA1CF2@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250218091543.282270-1-sthotton@marvell.com>
 <cover.1740383918.git.sthotton@marvell.com>
 <445d0930473314311091700bb4b9913c6266ffb2.1740383918.git.sthotton@marvell.com>
In-Reply-To: <445d0930473314311091700bb4b9913c6266ffb2.1740383918.git.sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|BL1PR11MB6028:EE_
x-ms-office365-filtering-correlation-id: 98d0becb-9967-4832-1d14-08dd58a36dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QU9zKciFTq8Y71i33Xi2ktC/HuUTCgWfl6Rcbuj/8CiLOtP09bSIfMHsNO5k?=
 =?us-ascii?Q?ED9+HCmAgUl/k6Z6669GbmSbYBSjnnyE/tQTYXEkYkYIoyCaCtH81J7T339x?=
 =?us-ascii?Q?UO8YL1weD+Z9TGSl62vxP8pAE9kEUlOBwMC3kL5k9HYpx+R/ksw1dscrYHV6?=
 =?us-ascii?Q?sf6U8S4GJfdALZDpkj9UBlABekuQDEAyiTN0/BqCQqDNng1MpvhzHgfWB/Q3?=
 =?us-ascii?Q?7AGowGCI7RsiruxtKHjBU2dr0gurasl8/SUEsMhIdB1eYW2/aT4LYJE4z5Bt?=
 =?us-ascii?Q?FgHaM6Qbl8cIt0MBmGMo/TlGgNe4d1MWlbEuFbDTuZqLsVJX4hejagyMcS9p?=
 =?us-ascii?Q?lC7glhCdxoImud34NOdXANWe7G3vL5MTJV4nDeH2inZGponGgURgPPCeJpH0?=
 =?us-ascii?Q?GtH3IBjKpMN9b7FriUqvcIcQAIQgtoB5Eb5a817ci62um7cc0cevlTnUm9ef?=
 =?us-ascii?Q?vv06K3lczrXdzVI/vbrTPbs0kDyX4r54/TYxb88nFfhVCjF13oPW0TjSXd2b?=
 =?us-ascii?Q?GRaGywpiKL9WfyR5dkGk3tZP0KJ73umRSvviXcim4X+w+RcXZW4fzFDoSXzm?=
 =?us-ascii?Q?WsiRXtZXqqjsjkh4UG9QbPbtoL5CsWXe1571HkrhBOLD672Fh4SClor7AoF1?=
 =?us-ascii?Q?ssms7JGXUV5yB2SGwDzy2uvnoOklX2Q2xF2A6uEaxNEXPHW8Qk1NMei8MqYM?=
 =?us-ascii?Q?0eUSezSlPdePre99DroDe4HZ4pk10ltWG7CV1Yjqo35HTRdGe7k2WIHYgg38?=
 =?us-ascii?Q?CF7ELaHw2w8Ba3Re8YpBr6hGeZVTPkykxESUQxL5B6Sr+xD47Y9d3XhvkRvf?=
 =?us-ascii?Q?Wx1bnGRmobSBauaG6D6UvSEB6txcExxFcmxIIf2lVD5FNwIhkmBaQdoPT8JQ?=
 =?us-ascii?Q?7U6q8p8Dw8KFOm0EhtZza0HPPu8qrfGtRuspSPigIRqEL6zZmG7FxeIUGwm7?=
 =?us-ascii?Q?y0SaL9RZjMqv7vayMR6gvOxGztjm0q7gGK5pkIK8HwIn2TW1+CQfIdzVozNS?=
 =?us-ascii?Q?LdUVdVWO94iq6ti3lvn4D68bOm2AeE+k+DMaVbenWxG3YYhP0lKfiBsaW+rt?=
 =?us-ascii?Q?BXx7wytXHKH/IopYcFm8heK4tM0RfaniUtWPp4Mqh0D3bPAOKfOwCniMS6Ye?=
 =?us-ascii?Q?tpHSpKCcR3T2xZwTg/xnazFXQM8gdZcMboxcpngt5Un0i3VonvqWcI9Pv4Qt?=
 =?us-ascii?Q?+xYyjChVm1XhdW7cxseHuS458efe2GptT8SIiPy3twMCKvE1IErGgBdhpQWg?=
 =?us-ascii?Q?i4MkWntL3+2sQPz4YJBsWXFJuUjvAXsdlt+Fz5yqEz5IHyxtU6ePuCGXjOZA?=
 =?us-ascii?Q?bATJTDoughRBETie0jyuggII5bS0QJLYEfIwt7jS1eX4oBeOoB2YXl2v1TCq?=
 =?us-ascii?Q?rIrZTkb3LOsEUYaeRf7xQl8NSRHnbI/rGtiSy/SpNx9uNGnUu/yuF6gmzzmH?=
 =?us-ascii?Q?gIelkqDNdXOnqR+03/eTwodHCf8/aKIX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ndPMEXpIw7j4kcxYn7bwLkdiK/vBclAav/++clYD4OKwvgyrGT2OazakF4cz?=
 =?us-ascii?Q?9p69eeU2QnkKUDR6QASF+159gqGoRX4nIwtZMsddf9kRINuyQ3BWIyiXfCBR?=
 =?us-ascii?Q?8Q7qJzHHsm8T10m0ybkQblMS2ix3bAdq8X1iQkXD/2FnwISzjUpQ7NKyNpD1?=
 =?us-ascii?Q?aC1aJwUVsbJt7Qzhd2FFyXVQ6XSNOniW6LLogg2O01vcvTOo6C9SYw2anP8R?=
 =?us-ascii?Q?x4PtCV+Q3I2zvvfd/+aPfPHCh51SOOBrMVGmyTk1vUkAiY5YaHUOLaoRHRE3?=
 =?us-ascii?Q?gW+Lh39QQgyf5c/MSwN0L9mAt2ya4Zn3wdHAugmP81W6kCqGn4DeUnd/jmTb?=
 =?us-ascii?Q?HOaMpfRydSgBdosqVGGH1mJAuG8tXbizOVL7clXrXrwvC6wbENtFK5n5e6PT?=
 =?us-ascii?Q?cy0TecxD2QVNPfAHxzcbI5kzC4oIExa/xN+XBpCT+lDlI+FSxoov1u+7TDN2?=
 =?us-ascii?Q?FjHMSzS/DsNmxBchVaZBI2v4OAnPXYH18M0yVJ2mUqodww8gNExBpljdmBAx?=
 =?us-ascii?Q?UdPfkFPqdANwl/caKoaPeDfSedH45fe45y5CwlKevDon+zwLx8AEvZvHx2Hb?=
 =?us-ascii?Q?nQNgsXJNw1LQdeO4yed/NhZPGcaRyooZ8OAoi0DUCU56x0gZEPxI9bdo4gRQ?=
 =?us-ascii?Q?V5pFZrc6P64syG0V5z5VqZxU+2ihi1+e6358XTd1LcjSuWb7AVdd6PHdFRaK?=
 =?us-ascii?Q?CqqSio43cA/a+2C1sECLT8TWkOUNIfKuydo/45CnTgJCI+izaGoLjfcEMqQs?=
 =?us-ascii?Q?93UFoBTN7UTPvUlolfsC4T37RxEXEp/Q2FhEnl4lWPUL4PLbBFR/Doemthi0?=
 =?us-ascii?Q?0Ksr7vlUa3oTzw1qPBsQhHfemXPzoNTHlNhejbVqTaCr277XXZMPUiEIUp39?=
 =?us-ascii?Q?w+Nw/TgSZJSb+aFATWihCaFVpzDnSZl5ekCFkOAZu1DFHbdxn7sWO/AdrYki?=
 =?us-ascii?Q?ku765M18yRROLlQUGwXEn1mtHE/7cOAujGC6/f8v2uwSzUWZFBRSAycdin7l?=
 =?us-ascii?Q?WDmdaFyfodrO4ReIl9yw0/9UEswZYagGS7+Atcs/pRJo/6b2EXJ1iqErgGIb?=
 =?us-ascii?Q?uTBFA9G9NdJFVyVzFedeLUsQhkLTdCWbSthCI36BQMwcEbJ4POxEA7byodgF?=
 =?us-ascii?Q?/k1VIJdCE4OKPv/QNRxTc2sdPUI2ZS07wLJg1juOut0h69foPBA3p6as0Qjd?=
 =?us-ascii?Q?ZgQ8EjtkP/X8ah0/9xXXDAcZbovGuwvjH4229Tdna/kCc10tOK4QrM76QkwZ?=
 =?us-ascii?Q?pfnIk3lggDQ36/mMOiNWc0pDb8OQ0Z1+jXOFcnuSESs0CgAwpt/2HUdh+seK?=
 =?us-ascii?Q?Hs3WHdFU6nTx3gUZDnhw4J/MmaetTV27GfBscRL2BMDwl4PkFxhsnYkZOacP?=
 =?us-ascii?Q?S8x6nMjjnltqlQEc8lp/53ppDqrv8I04NLJrrf4LdMN/CIBTJHCN4RtpYhH/?=
 =?us-ascii?Q?FHZNlGDNljS3dtHyHiDBI1wCXf/MLQqD1FuNvBLoWOTLtqPZ0ZI8/lp+n9GY?=
 =?us-ascii?Q?ShktcJZWfMrDISdi/itHBoC/odWqZB+eXEM8Y8rO65FydXJe820WPKWWFmgj?=
 =?us-ascii?Q?ECAQi7HMocjs0tjOJRpxvZxSwqHmmYvfV8LaHThv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0becb-9967-4832-1d14-08dd58a36dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 09:28:30.4343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQ9x+80g5+UXxvRyNPc4PldRRDTpupGorJqj4wjiXgRv85QcLpWXdfR7joHrFqGssVksWg3i68TfDQQk5nBBsAJZEWbzyf9gIWu1/bo4ccs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
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
> From: Shijith Thotton <sthotton@marvell.com>
> Sent: Monday, February 24, 2025 2:12 PM
> To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>; jerinj@marvell.com
> Cc: Shijith Thotton <sthotton@marvell.com>; dev@dpdk.org;
> pbhagavatula@marvell.com; Pathak, Pravin <pravin.pathak@intel.com>;
> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Mattias R_nnblom
> <mattias.ronnblom@ericsson.com>; Liang Ma <liangma@liangbit.com>;
> Mccarthy, Peter <peter.mccarthy@intel.com>; Van Haaren, Harry
> <harry.van.haaren@intel.com>; Carrillo, Erik G <erik.g.carrillo@intel.com=
>;
> Gujjar, Abhinandan S <abhinandan.gujjar@intel.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: [PATCH v3 1/3] eventdev/eth_rx: add API to burst add queues to R=
x
> adapter
>=20
>=20
> This patch introduces a new API, rte_event_eth_rx_adapter_queues_add(),
> to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.
>=20
> The existing rte_event_eth_rx_adapter_queue_add() API supports adding
> multiple queues by specifying rx_queue_id =3D -1, but it lacks the abilit=
y to apply
> specific configurations to each of the added queues.
>=20
> A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t, has
> been introduced to enable this functionality. It takes an array of receiv=
e queue
> IDs along with their corresponding queue configurations.
>=20
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Acked-by: Naga Harish K S V <s.v.naga.harish.k@intel.com>
> ---
>  .../eventdev/event_ethernet_rx_adapter.rst    |  60 +++++--
>  lib/eventdev/eventdev_pmd.h                   |  34 ++++
>  lib/eventdev/eventdev_trace.h                 |  14 ++
>  lib/eventdev/eventdev_trace_points.c          |   3 +
>  lib/eventdev/rte_event_eth_rx_adapter.c       | 160 ++++++++++++++++++
>  lib/eventdev/rte_event_eth_rx_adapter.h       |  33 ++++
>  lib/eventdev/version.map                      |   3 +
>  7 files changed, 297 insertions(+), 10 deletions(-)
>=20
> diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> index 2e68cca798..bae46cc7d7 100644
> --- a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> +++ b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
> @@ -96,16 +96,23 @@ when the adapter is created using the above-
> mentioned APIs.
>  Adding Rx Queues to the Adapter Instance
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> -Ethdev Rx queues are added to the instance using the -
> ``rte_event_eth_rx_adapter_queue_add()`` function. Configuration for the =
Rx -
> queue is passed in using a ``struct rte_event_eth_rx_adapter_queue_conf``
> -parameter. Event information for packets from this Rx queue is encoded i=
n the
> -``ev`` field of ``struct rte_event_eth_rx_adapter_queue_conf``. The -
> servicing_weight member of the struct
> rte_event_eth_rx_adapter_queue_conf
> -is the relative polling frequency of the Rx queue and is applicable when=
 the -
> adapter uses a service core function. The applications can configure queu=
e -
> event buffer size in ``struct
> rte_event_eth_rx_adapter_queue_conf::event_buf_size``
> -parameter.
> +Ethdev Rx queues can be added to the instance using either the
> +``rte_event_eth_rx_adapter_queue_add()`` function or
> +``rte_event_eth_rx_adapter_queues_add()``. The former is used to add a
> +single Rx queue at a time, while the latter allows adding multiple Rx
> +queues in a single call.
> +
> +Single Queue Addition
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``rte_event_eth_rx_adapter_queue_add()`` API allows adding a single
> +Rx queue to the adapter instance. Configuration for the Rx queue is
> +passed using a ``struct rte_event_eth_rx_adapter_queue_conf``
> +parameter. Event information for packets from this Rx queue is encoded
> +in the ``ev`` field of this struct. The ``servicing_weight`` member of
> +the struct determines the relative polling frequency of the Rx queue
> +and is applicable when the adapter uses a service core function.
> +Applications can also configure the queue event buffer size using the
> ``event_buf_size`` parameter in ``struct
> rte_event_eth_rx_adapter_queue_conf``.
>=20
>  .. code-block:: c
>=20
> @@ -122,6 +129,39 @@ parameter.
>                                                  eth_dev_id,
>                                                  0, &queue_config);
>=20
> +Bulk Queue Addition
> +^^^^^^^^^^^^^^^^^^^
> +
> +The ``rte_event_eth_rx_adapter_queues_add()`` API allows the addition
> +of multiple Rx queues in a single call. While
> +``rte_event_eth_rx_adapter_queue_add()`` supports adding multiple
> +queues by specifying ``rx_queue_id =3D -1``, it does not allow applying
> +specific configurations to each queue individually.  The
> +``rte_event_eth_rx_adapter_queues_add()`` API accepts an array of
> +receive queue IDs along with their corresponding configurations,
> +enabling control over each Rx queue's settings.
> +
> +.. code-block:: c
> +
> +        struct rte_event_eth_rx_adapter_queue_conf
> queue_config[nb_rx_queues];
> +        int rx_queue_id[nb_rx_queues];
> +
> +        for (int i =3D 0; i < nb_rx_queues; i++) {
> +            rx_queue_id[i] =3D i;
> +            queue_config[i].rx_queue_flags =3D 0;
> +            queue_config[i].ev.queue_id =3D i;
> +            queue_config[i].ev.sched_type =3D RTE_SCHED_TYPE_ATOMIC;
> +            queue_config[i].ev.priority =3D 0;
> +            queue_config[i].servicing_weight =3D 1;
> +            queue_config[i].event_buf_size =3D 1024;
> +        }
> +
> +        err =3D rte_event_eth_rx_adapter_queues_add(id,
> +                                                 eth_dev_id,
> +                                                 rx_queue_id,
> +                                                 queue_config,
> +                                                 nb_rx_queues);
> +
>  Querying Adapter Capabilities
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
> index 36148f8d86..ad13ba5b03 100644
> --- a/lib/eventdev/eventdev_pmd.h
> +++ b/lib/eventdev/eventdev_pmd.h
> @@ -25,6 +25,7 @@
>  #include <rte_mbuf_dyn.h>
>=20
>  #include "event_timer_adapter_pmd.h"
> +#include "rte_event_eth_rx_adapter.h"
>  #include "rte_eventdev.h"
>=20
>  #ifdef __cplusplus
> @@ -708,6 +709,37 @@ typedef int
> (*eventdev_eth_rx_adapter_queue_add_t)(
>  		int32_t rx_queue_id,
>  		const struct rte_event_eth_rx_adapter_queue_conf
> *queue_conf);
>=20
> +/**
> + * Add ethernet Rx queues to event device in burst. This callback is
> +invoked if
> + * the caps returned from rte_eventdev_eth_rx_adapter_caps_get(,
> +eth_port_id)
> + * has RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT set.
> + *
> + * @param dev
> + *   Event device pointer
> + *
> + * @param eth_dev
> + *   Ethernet device pointer
> + *
> + * @param rx_queue_id
> + *   Ethernet device receive queue index array
> + *
> + * @param queue_conf
> + *   Additional configuration structure array
> + *
> + * @param nb_rx_queues
> + *   Number of ethernet device receive queues
> + *
> + * @return
> + *   - 0: Success, ethernet receive queues added successfully.
> + *   - <0: Error code returned by the driver function.
> + */
> +typedef int (*eventdev_eth_rx_adapter_queues_add_t)(
> +		const struct rte_eventdev *dev,
> +		const struct rte_eth_dev *eth_dev,
> +		int32_t rx_queue_id[],
> +		const struct rte_event_eth_rx_adapter_queue_conf
> queue_conf[],
> +		uint16_t nb_rx_queues);
> +
>  /**
>   * Delete ethernet Rx queues from event device. This callback is invoked=
 if
>   * the caps returned from eventdev_eth_rx_adapter_caps_get(, eth_port_id=
)
> @@ -1578,6 +1610,8 @@ struct eventdev_ops {
>  	/**< Get ethernet Rx adapter capabilities */
>  	eventdev_eth_rx_adapter_queue_add_t eth_rx_adapter_queue_add;
>  	/**< Add Rx queues to ethernet Rx adapter */
> +	eventdev_eth_rx_adapter_queues_add_t
> eth_rx_adapter_queues_add;
> +	/**< Add Rx queues to ethernet Rx adapter in burst */
>  	eventdev_eth_rx_adapter_queue_del_t eth_rx_adapter_queue_del;
>  	/**< Delete Rx queues from ethernet Rx adapter */
>  	eventdev_eth_rx_adapter_queue_conf_get_t
> eth_rx_adapter_queue_conf_get; diff --git a/lib/eventdev/eventdev_trace.h
> b/lib/eventdev/eventdev_trace.h index 8ff8841729..6b334d8bd1 100644
> --- a/lib/eventdev/eventdev_trace.h
> +++ b/lib/eventdev/eventdev_trace.h
> @@ -159,6 +159,20 @@ RTE_TRACE_POINT(
>  	rte_trace_point_emit_int(rc);
>  )
>=20
> +RTE_TRACE_POINT(
> +	rte_eventdev_trace_eth_rx_adapter_queues_add,
> +	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
> +		uint16_t nb_rx_queues, void *rx_queue_id,
> +		const void *queue_conf,
> +		int rc),
> +	rte_trace_point_emit_u8(adptr_id);
> +	rte_trace_point_emit_u16(eth_dev_id);
> +	rte_trace_point_emit_u16(nb_rx_queues);
> +	rte_trace_point_emit_ptr(rx_queue_id);
> +	rte_trace_point_emit_ptr(queue_conf);
> +	rte_trace_point_emit_int(rc);
> +)
> +
>  RTE_TRACE_POINT(
>  	rte_eventdev_trace_eth_rx_adapter_queue_del,
>  	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id, diff -
> -git a/lib/eventdev/eventdev_trace_points.c
> b/lib/eventdev/eventdev_trace_points.c
> index e7af1591f7..8caf6353a1 100644
> --- a/lib/eventdev/eventdev_trace_points.c
> +++ b/lib/eventdev/eventdev_trace_points.c
> @@ -65,6 +65,9 @@
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_free,
>=20
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_ad
> d,
>  	lib.eventdev.rx.adapter.queue.add)
>=20
> +RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queues_
> add,
> +	lib.eventdev.rx.adapter.queues.add)
> +
>=20
> RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_del
> ,
>  	lib.eventdev.rx.adapter.queue.del)
>=20
> diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c
> b/lib/eventdev/rte_event_eth_rx_adapter.c
> index 39674c4604..2063ceaede 100644
> --- a/lib/eventdev/rte_event_eth_rx_adapter.c
> +++ b/lib/eventdev/rte_event_eth_rx_adapter.c
> @@ -2793,6 +2793,166 @@ rte_event_eth_rx_adapter_queue_add(uint8_t
> id,
>  	return 0;
>  }
>=20
> +int
> +rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id,
> int32_t rx_queue_id[],
> +				    const struct
> rte_event_eth_rx_adapter_queue_conf queue_conf[],
> +				    uint16_t nb_rx_queues)
> +{
> +	struct rte_event_eth_rx_adapter_vector_limits limits;
> +	struct event_eth_rx_adapter *rx_adapter;
> +	struct eth_device_info *dev_info;
> +	struct rte_eventdev *dev;
> +	uint32_t cap, i;
> +	int ret;
> +
> +	if (rxa_memzone_lookup())
> +		return -ENOMEM;
> +
> +	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(id, -EINVAL);
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(eth_dev_id, -EINVAL);
> +
> +	rx_adapter =3D rxa_id_to_adapter(id);
> +	if ((rx_adapter =3D=3D NULL) || (queue_conf =3D=3D NULL))
> +		return -EINVAL;
> +
> +	if (nb_rx_queues && rx_queue_id =3D=3D NULL)
> +		return -EINVAL;
> +
> +	if (nb_rx_queues > rte_eth_devices[eth_dev_id].data->nb_rx_queues)
> {
> +		RTE_EDEV_LOG_ERR("Invalid number of rx queues %" PRIu16,
> nb_rx_queues);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rte_event_eth_rx_adapter_caps_get(rx_adapter->eventdev_id,
> eth_dev_id, &cap);
> +	if (ret) {
> +		RTE_EDEV_LOG_ERR("Failed to get adapter caps edev %"
> PRIu8 "eth port %" PRIu16, id,
> +				 eth_dev_id);
> +		return ret;
> +	}
> +
> +	if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ) =3D=3D 0)
> {
> +		for (i =3D 1; i < nb_rx_queues; i++) {
> +			if (queue_conf[i].ev.queue_id !=3D
> queue_conf[0].ev.queue_id) {
> +				RTE_EDEV_LOG_ERR("Rx queues can only be
> connected to single "
> +						 "event queue, eth port: %"
> PRIu16
> +						 " adapter id: %" PRIu8,
> +						 eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	for (i =3D 0; i < (nb_rx_queues ? nb_rx_queues : 1); i++) {
> +		const struct rte_event_eth_rx_adapter_queue_conf *conf;
> +
> +		conf =3D &queue_conf[i];
> +		if ((cap &
> RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) =3D=3D 0 &&
> +		    (conf->rx_queue_flags &
> RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID)) {
> +			RTE_EDEV_LOG_ERR("Flow ID override is not
> supported in queue_conf[%" PRIu32
> +					 "], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					 i, eth_dev_id, id);
> +			return -EINVAL;
> +		}
> +
> +		if (conf->rx_queue_flags &
> RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
> +			if ((cap &
> RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR) =3D=3D 0) {
> +				RTE_EDEV_LOG_ERR(
> +					"Event vectorization is unsupported in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			ret =3D
> rte_event_eth_rx_adapter_vector_limits_get(rx_adapter->eventdev_id,
> +
> eth_dev_id, &limits);
> +			if (ret < 0) {
> +				RTE_EDEV_LOG_ERR("Failed to get event
> device vector limits,"
> +						 " eth port: %" PRIu16 "
> adapter id: %" PRIu8,
> +						 eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			if (conf->vector_sz < limits.min_sz || conf->vector_sz
> > limits.max_sz ||
> +			    conf->vector_timeout_ns < limits.min_timeout_ns
> ||
> +			    conf->vector_timeout_ns > limits.max_timeout_ns
> ||
> +			    conf->vector_mp =3D=3D NULL) {
> +				RTE_EDEV_LOG_ERR(
> +					"Invalid event vector configuration in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +
> +			if (conf->vector_mp->elt_size < (sizeof(struct
> rte_event_vector) +
> +							 (sizeof(uintptr_t) *
> conf->vector_sz))) {
> +				RTE_EDEV_LOG_ERR(
> +					"Invalid event vector configuration in
> queue_conf[%" PRIu32
> +					"], eth port: %" PRIu16 " adapter id:
> %" PRIu8,
> +					i, eth_dev_id, id);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if ((rx_adapter->use_queue_event_buf && conf-
> >event_buf_size =3D=3D 0) ||
> +		    (!rx_adapter->use_queue_event_buf && conf-
> >event_buf_size !=3D 0)) {
> +			RTE_EDEV_LOG_ERR("Invalid Event buffer size in
> queue_conf[%" PRIu32 "]", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	dev =3D &rte_eventdevs[rx_adapter->eventdev_id];
> +	dev_info =3D &rx_adapter->eth_devices[eth_dev_id];
> +
> +	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
> +		if (*dev->dev_ops->eth_rx_adapter_queues_add =3D=3D NULL)
> +			return -ENOTSUP;
> +
> +		if (dev_info->rx_queue =3D=3D NULL) {
> +			dev_info->rx_queue =3D
> +				rte_zmalloc_socket(rx_adapter->mem_name,
> +						   dev_info->dev->data-
> >nb_rx_queues *
> +							   sizeof(struct
> eth_rx_queue_info),
> +						   0, rx_adapter->socket_id);
> +			if (dev_info->rx_queue =3D=3D NULL)
> +				return -ENOMEM;
> +		}
> +
> +		ret =3D (*dev->dev_ops->eth_rx_adapter_queues_add)(
> +			dev, &rte_eth_devices[eth_dev_id], rx_queue_id,
> queue_conf, nb_rx_queues);
> +		if (ret =3D=3D 0) {
> +			dev_info->internal_event_port =3D 1;
> +
> +			if (nb_rx_queues =3D=3D 0)
> +				rxa_update_queue(rx_adapter, dev_info, -1,
> 1);
> +
> +			for (i =3D 0; i < nb_rx_queues; i++)
> +				rxa_update_queue(rx_adapter, dev_info,
> rx_queue_id[i], 1);
> +		}
> +	} else {
> +		rte_spinlock_lock(&rx_adapter->rx_lock);
> +		dev_info->internal_event_port =3D 0;
> +		ret =3D rxa_init_service(rx_adapter, id);
> +		if (ret =3D=3D 0) {
> +			uint32_t service_id =3D rx_adapter->service_id;
> +
> +			if (nb_rx_queues =3D=3D 0)
> +				ret =3D rxa_sw_add(rx_adapter, eth_dev_id, -1,
> &queue_conf[0]);
> +
> +			for (i =3D 0; i < nb_rx_queues; i++)
> +				ret =3D rxa_sw_add(rx_adapter, eth_dev_id,
> rx_queue_id[i],
> +						 &queue_conf[i]);
> +
> +			rte_service_component_runstate_set(service_id,
> +
> rxa_sw_adapter_queue_count(rx_adapter));
> +		}
> +		rte_spinlock_unlock(&rx_adapter->rx_lock);
> +	}
> +
> +	rte_eventdev_trace_eth_rx_adapter_queues_add(id, eth_dev_id,
> nb_rx_queues, rx_queue_id,
> +						     queue_conf, ret);
> +	return ret;
> +}
> +
>  static int
>  rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limi=
ts)
> { diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h
> b/lib/eventdev/rte_event_eth_rx_adapter.h
> index 9237e198a7..758e1c5f56 100644
> --- a/lib/eventdev/rte_event_eth_rx_adapter.h
> +++ b/lib/eventdev/rte_event_eth_rx_adapter.h
> @@ -553,6 +553,39 @@ int rte_event_eth_rx_adapter_queue_add(uint8_t
> id,
>  			int32_t rx_queue_id,
>  			const struct rte_event_eth_rx_adapter_queue_conf
> *conf);
>=20
> +/**
> + * Add multiple receive queues to an event adapter.
> + *
> + * @param id
> + *  Adapter identifier.
> + *
> + * @param eth_dev_id
> + *  Port identifier of Ethernet device.
> + *
> + * @param rx_queue_id
> + *  Array of Ethernet device receive queue indices.
> + *  If nb_rx_queues is 0, then rx_queue_id is ignored.
> + *
> + * @param conf
> + *  Array of additional configuration structures of type
> + *  *rte_event_eth_rx_adapter_queue_conf*. conf[i] is used for
> rx_queue_id[i].
> + *  If nb_rx_queues is 0, then conf[0] is used for all Rx queues.
> + *
> + * @param nb_rx_queues
> + *  Number of receive queues to add.
> + *  If nb_rx_queues is 0, then all Rx queues configured for
> + *  the device are added with the same configuration in conf[0].
> + * @see RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ
> + *
> + * @return
> + *  - 0: Success, Receive queues added correctly.
> + *  - <0: Error code on failure.
> + */
> +__rte_experimental
> +int rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id,
> int32_t rx_queue_id[],
> +					const struct
> rte_event_eth_rx_adapter_queue_conf conf[],
> +					uint16_t nb_rx_queues);
> +
>  /**
>   * Delete receive queue from an event adapter.
>   *
> diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map index
> 42a5867aba..44687255cb 100644
> --- a/lib/eventdev/version.map
> +++ b/lib/eventdev/version.map
> @@ -153,6 +153,9 @@ EXPERIMENTAL {
>  	__rte_eventdev_trace_port_preschedule_modify;
>  	rte_event_port_preschedule;
>  	__rte_eventdev_trace_port_preschedule;
> +
> +	# added in 25.03
> +	rte_event_eth_rx_adapter_queues_add;
>  };
>=20
>  INTERNAL {
> --
> 2.25.1

