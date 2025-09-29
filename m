Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE6CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 19:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AC13402D8;
	Mon, 29 Sep 2025 21:53:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1B6534028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 21:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759175598; x=1790711598;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vp8wyh6Mj5o0km+v9B8CiLYBbK+25NUpIM+wPV0yQcQ=;
 b=GuUA2/VdSK8TDWCTkPEoYrj7xY84QuvmzL+E3K4e8NshiURxPVK5vkkl
 6/Opjv3xyE+frEVwoP6hHtTX7GnWWbGuE58USy7X8Mm4AvHKI+Uhhb9a1
 A+i6uUZbJS9KtDjDzL6pja1hYrjp4K4WuhLH/wIQNTQXl6G73AsH0vrKp
 fZ31OeA777pOrrUB18+UfqMuCdI4fsAhbTs+8Jo1igFshYUiz0N0JZZuk
 c5435PbrDSnwc+j1ZE1FPxQhch4kgjKUTz+Pc+9epv8hgfMj1gJToYRqR
 DG8TWRTB/EsTc8g5V7hhMSHWy0AvQ0NdsCI9Gt5MTXL5FeIpruQuKLdvN g==;
X-CSE-ConnectionGUID: 2NqrR0TpRBObDY5fan96tg==
X-CSE-MsgGUID: +wrHPnTjShmNAXbLs/JuQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="60637947"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="60637947"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 12:53:17 -0700
X-CSE-ConnectionGUID: LyrB2ELESgiGiCO9qLI/3w==
X-CSE-MsgGUID: D7mMJuqZR+2nH03b21qtyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="178361941"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 12:53:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 12:53:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 12:53:15 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 12:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1rPHhp5026f+g5O0T7t6Vl734krnYUWCaisCApl3p/LJ6W6zffhTq5ye3nd+UiscftHn9h6nZy4b0IVG2eBp3u+yW7qdB/SoYRKgows9ZhnO0ndKS/j994Xu1WT4m0Onjx/qsAnMhrWAVTsxRFDnIaCqus7b3zweMUMyn1Cm7omoO4AWXVyyJ32HMz0mHGWNjNPR8L+1Z8mk7jxBzxmdGu9Qonj5G/kwlDlYMqJKrHbzclhg+u0UH8x/XD7atMMhOd0xX3G9Iu1H4jJxvOXWTI4hqCqaHLlFV700HF88MG/uNm9qXYi5DzLZSlnmjg3M88B23JYvo/UK3vEWXq2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1XhdmEaejbgOL1wX1Uop29qkpCmgIKrD+NqUHanbW4=;
 b=ZD3z5sZIo/iM0pbLF8y6iCYFh06Cwf0MPAM5aj4l3IMMchXpFYnLIBbbZS6yPPRMbafw7tw/uHoYg8EQKBaVCf2iaWH6Yo5/pMD4HV9dJSSE/QUNSSInl/2YqG6kwd4fcn2i+qYmSJ9UweEjU7IwHixNb+vE5lii6UFO2SHSuX5817tJuu9Uq8cgtbCA9ezg5f2AmhlOhely8ttLb6fRnz3/6VtaH0+R+dUM99PjtfMp5HSo8+ea5NfQ5w8y0xU18bpvt5W2T4mo0+k6nazDlLN8Y+Imb232RzhFxpLqGJS8IRgXtFOJkoWdKAX3+Lza+diodGHI4LzT4vZluqR9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by MW6PR11MB8412.namprd11.prod.outlook.com
 (2603:10b6:303:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 19:53:13 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Mon, 29 Sep 2025
 19:53:13 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shukla, Dhananjay" <dhananjay.shukla@intel.com>, "Patel,
 Atul" <atul.patel@intel.com>
Subject: RE: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Thread-Topic: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Thread-Index: AQHcLG0eTTSZzwEpeUW7P41XX21gTLSqNF8AgABYNdA=
Date: Mon, 29 Sep 2025 19:53:13 +0000
Message-ID: <DM3PPF291EF9BF18F7EF5D14F1ADF7F83EE9D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-4-praveen.shetty@intel.com>
 <aNqMSu1HDRB8qsvd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNqMSu1HDRB8qsvd@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|MW6PR11MB8412:EE_
x-ms-office365-filtering-correlation-id: 4dac1610-e6fe-4a98-0faa-08ddff91d322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vbmah3IpFazBPRqmkTiZDLD7TT5c5j9QUNNNZRGZOmJlxZqBDAeBVbIbqYhs?=
 =?us-ascii?Q?Swovo048oNVkvjfs560nGlNfLgSSxOa3HoxtILuZZkrf/CcPQELbPJbLljTt?=
 =?us-ascii?Q?0aw/qZ2ZBOyqW+wwHOMsOkiDVI/sgnMEYFMOzV7S77EavMPxVyVKpg/fvklP?=
 =?us-ascii?Q?2ULFDVVJ7j7q8yw68iuBFqBJ32qXGS/9K0DMO86D+ywIr2Q6mPJ6fCyU+12s?=
 =?us-ascii?Q?iUGlqZvSCO6Lyw2z2A2TE6vjYDc9WeaSgpqXv9yLD/1VG0RI2JXV1r9eR252?=
 =?us-ascii?Q?7/Rjf7MRTzsm+nADdfOKcpKxoHgCyznjD/+Wvnoivc0o4UXDm7k+KPrnH4Ma?=
 =?us-ascii?Q?RM1VlP00d2Db9Hf59BMJhFWsm0Ng3PBDN4sj9TTNwxSjLnDFqSvtD1uuHD+e?=
 =?us-ascii?Q?iHcxoaaF6axv2OSJaydzCYOA6nlv3/GNd0z75ejUd85L91vdFU4of7oJ3im0?=
 =?us-ascii?Q?X046eNtQx4pEU0KRyDPf4OnzVr4qzylK7TGTq6ZSGKeq4yMvJLd/1sc3LzWF?=
 =?us-ascii?Q?QtflvHG/f9Mqg88Bez9eH7edaPsQ7+xIaFUpTZsQ9g4wGYrTb5j06GWkp6jr?=
 =?us-ascii?Q?NOtqgS2yV+zqY4FMN9pm92KHCEzDK5uzDTM7R/LA0KfERzbe3xzVHCvU4Jhu?=
 =?us-ascii?Q?F8+jXg4Fx7w0hWwWPS81FhxncJD+g4wwErPTJWa0RChYJiXZNLYDhDUeNSf2?=
 =?us-ascii?Q?OEuZhwQU/XJoHbaQzRANxVaRrvN0pSx/jv8ZZF/HnuqCk8/WrkEGp7mtBnl9?=
 =?us-ascii?Q?k0UzDfeHJVLVorHadUTVxalliK/r8qOeIxlbrL5JwKnNqjZrlQMcFwVAlU4z?=
 =?us-ascii?Q?2cDm30NNWMCM9SyydVktI3/34WxrtKF6nds4pHZFXoz2x3azIt9m6ZWxjxsc?=
 =?us-ascii?Q?F3554ZDJi3DM2GPzUkdl1UXwpUfiicavjZWr13wFVc5t3qy8K9NK8zCX3aAr?=
 =?us-ascii?Q?Jjrrmm+TbLz22OIIvLcYgj1cmAqehf/C4vIk8qTV8H5IuG0DhAEoqtcHf4S+?=
 =?us-ascii?Q?Kx2Aj8gjeLg6vt3JWgSEEMRUylW+FAydmf/bcLPI5pWmn5CeZqq5f7icGFdz?=
 =?us-ascii?Q?38C9YxfclzI3het6f4xLGSgWPahZT9Dq12FJIu5pXMvdwViCl5SzqWWjxJMB?=
 =?us-ascii?Q?0nRG2LZj1L5AA0t7jSatcj5xH5MeHde6WywsMePbOP94tsBjPrOTXELDaTa+?=
 =?us-ascii?Q?Dp+jmILk9xwOisatUy9sYtQQ8SsUNp3RmblshLw5ei0l2rsg8O+0fi6ZFyUS?=
 =?us-ascii?Q?1yHmQH5mKSZw2QksWkLOQTKtQRj+xXOmhIZzPviFdJsR+jUql9D37qlMR8Dp?=
 =?us-ascii?Q?7vmsQ0pd2eabnxa/q2c3csV6EnCCWeQ0pgAFUqXBWQS9qVy5Jq+XY0wvRiSu?=
 =?us-ascii?Q?n5G5yWkKgcIjdjxntTmv3PERgX0etANqVtLDv6ueLE5N1nV7UL7Sx6OWJCvA?=
 =?us-ascii?Q?onlnY1D/z//YpUj1PITO9nDDGmJ0P+J/F/j9UPRR7/YJ391SOHQ5jqreDtNE?=
 =?us-ascii?Q?8SsdbGA/FNR01CZoOR6b8kuwJGiYnnkYsdbx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ibCCQDcg4Vtx0d3UJOdk/RIr4Oz+iTuVvmJQUjwfYrFNnvrQllF9cJvle3T2?=
 =?us-ascii?Q?90wUvwnnmHArpu3CwdGhvzfteueW7i6h6e2maWMaOkt4PHGs93647sj3yBf2?=
 =?us-ascii?Q?UOeOkYNxywwArO2SZ35y8H3Bb9Np2dToqJ3SB2wxR/q9Ko+G3IvXn+pB7uIR?=
 =?us-ascii?Q?oO2iBQHtZNW9Wso+wv5kUv0SvogDTx7S+g2bKMiIS4VD0lP2HhyYh7YEOLAI?=
 =?us-ascii?Q?y/aUin6JLCPkAIUrmg9EZhQMjoOnfSrFNONXGyng3FdrLaaDr9nUgzEXI+mq?=
 =?us-ascii?Q?ja/mVPPfmc888VBg9FAt8hU3GhU3WHRaMdLw4VDu8hZqpOg4oqtaTonmuXSz?=
 =?us-ascii?Q?sPS/iGCEaMjwwJjDyxJIE6mpuKMCni8zdEb8N5ji0IYW2HVqzEL+W2THxV6I?=
 =?us-ascii?Q?0kT/j/fZaYleUYsEbCBJCpXC3bbjBfsV/L8YgoIvsM4KrpK8BzgJGjvf4gnQ?=
 =?us-ascii?Q?gKzeK57T2Zw1ZVfJTrcKzOKPmCVAnkjAL2KhaqedN7AIJu275lOMeIioSjEC?=
 =?us-ascii?Q?FV+yy5AvFlyorlXlihkgiQtwCNSarxs+kRTXmQn70wautwHEMGpcffXN1DQd?=
 =?us-ascii?Q?vg0nbhmhCpFxXzcCV/uu8QB8u8/cgf6mtMwAOL296J3b+Gm2kFwBjh5eKih3?=
 =?us-ascii?Q?QVP7BNl3nun1WWvAFIwy4vtRv6R2cscqLxuAM7weO5ez1m/drb/rrDsvXqGm?=
 =?us-ascii?Q?WFmTuG+PYisjDXvfqd63KOhMvD2ap37uhrDBWNzCYaS3HakydO/xHZ21k5Cu?=
 =?us-ascii?Q?vmYCWCpkYZNOPXLppF/t4qxXR3Mo8O91uWx1G2HPsGpcuVlwAlGYhTdoKSSW?=
 =?us-ascii?Q?bHrZLFP0zXAC6XvvN//nd6cC+PUNUOMfI3S2wD7KcFluRFrD3runEyIiv9pY?=
 =?us-ascii?Q?opZNKUG/lijWSIMh1gv7wbDCrXLBov7ftlVhTVO1fh7R5FT5tufxJrk/DvxX?=
 =?us-ascii?Q?d6o+F/warm8aIK7Gy4B/L76O0lFVMyhQJ07TbxnKsYR8QK+mAziAVzNh5bal?=
 =?us-ascii?Q?1IYg0GLhe7RiKtHC2Sz4doQxCXQXHX62sExF98o5aI8vEpM/6xLao/wXaoNt?=
 =?us-ascii?Q?1fgBU5GLhQVQwDQsKxE753NNiD9r9OEn3viCeedgeo/FRF027/F4zZ40TDyV?=
 =?us-ascii?Q?kip4ttL/anbL/iknEmv8bxjdD975dGpyNWt4XCuJd+fv6R6G1Uu3viWAxH6n?=
 =?us-ascii?Q?QJuiQ7W6fPRenTWC1bmWRasNDS8gdDrOYcPW8ykCK5MeQpa32bLmaY8kMEXq?=
 =?us-ascii?Q?7qLikLVLbBSHeNxlWEdksFfG+Fp7SE4iT/sjdtcowOgcP1HxmlYr0vdZQaZA?=
 =?us-ascii?Q?KECcCe1s0e2zScgoqMXpR4NzhHMKU6yKjdFM0Km6Bpg+GHE/T9EQUr6HUJlS?=
 =?us-ascii?Q?anXh5YW6IGGJciDVKvGCXYYgvQ7yMWAbPPlceJBn+8HkWnZZ2V4k/4X9mZmL?=
 =?us-ascii?Q?tPlQ5i7hGojzBXMdNSy0t86X6GzM1BzqI9+PGLabzDnETKQ4ateo9TsEsqT2?=
 =?us-ascii?Q?z4dwpUDE8yiFsec6ivkoKIc8Bb6x/JSdgZ0JEB7APzH/oV2kI51o945hOMGM?=
 =?us-ascii?Q?6Fkn5oCeCzlalNTYCziGT2LxWkY4FmmM8becumgB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac1610-e6fe-4a98-0faa-08ddff91d322
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 19:53:13.3965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66djUILi4Bp1WvXglKNkBrVfjnW/mGQrVybQ2gknaC6Vq5xwuTdFDz5xKm+b/AbwVfHqaPgGdC4jmDGNCBvtqF6kb3LuSgWyTFpCvwoUHBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8412
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


On Tue, Sep 23, 2025 at 02:54:54PM +0200,  Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
>=20
> A "configuration queue" is a software term to denote a hardware=20
> mailbox queue dedicated to NSS programming.
> While the hardware does not have a construct of a "configuration=20
> queue", software does to state clearly the distinction between a queue=20
> software dedicates to regular mailbox processing (e.g. CPChnl or=20
> Virtchnl) and a queue software dedicates to NSS programming (e.g.=20
> SEM/LEM rule programming).
>=20

Please provide expansions or clarifications for the acronyms used in the co=
mmit message, so that the commit log is understandable for those unaware of=
 what the NSS is, or what SEM/LEM refers to. As far as I know, these are no=
t generally known terms in the industry.
>> Sure - will address this in v4.

Also, you say that the hardware doesn't have a config queue, but software d=
oes -  I think that needs a bit of explanation as to what exactly the patch=
 is doing/implementing? How is software providing a special config queue if=
 the facility is not provided by HW.

>> From the HW perspective, both mailbox and the config queues are "control=
" queues.
>> For HW, "opcode" in the queue descriptor is one of the key differentiati=
ng factors between mailbox queues and the config queues(operation code is d=
ifferent for mailbox queues and the config queues).
>> Mailbox queues are used for Virtchnl and the CPChnl communication betwee=
n the driver and the FW.
>> Config queues are used for programming the FXP pipeline(Flexible packet =
processor).
>> This patch will request for the queues from the fw using add_queue virtc=
hnl message and configures it as a config queue.
>> vCPF driver will then use this config queues to program the FXP pipeline=
 using rte_flow.
>> will add this information in the v4.

> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> Tested-by: Atul Patel  <atul.patel@intel.com>
> ---

Couple of small comments inline below.

/Bruce

>  drivers/net/intel/cpfl/cpfl_ethdev.c          | 274 +++++++++++++++---
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  38 ++-
>  drivers/net/intel/cpfl/cpfl_vchnl.c           | 143 ++++++++-
>  drivers/net/intel/idpf/base/idpf_osdep.h      |   3 +
>  drivers/net/intel/idpf/base/virtchnl2.h       |   3 +-
>  drivers/net/intel/idpf/idpf_common_device.h   |   2 +
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  38 +++
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |   3 +
>  8 files changed, 449 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index d6227c99b5..c411a2a024 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -29,6 +29,9 @@
>  #define CPFL_FLOW_PARSER	"flow_parser"
>  #endif
> =20
> +#define VCPF_FID	0
> +#define CPFL_FID	6
> +
>  rte_spinlock_t cpfl_adapter_lock;
>  /* A list for all adapters, one adapter matches one PCI device */ =20
> struct cpfl_adapter_list cpfl_adapter_list; @@ -1699,7 +1702,8 @@=20
> cpfl_handle_vchnl_event_msg(struct cpfl_adapter_ext *adapter, uint8_t *ms=
g, uint
>  	}
> =20
>  	/* ignore if it is ctrl vport */
> -	if (adapter->ctrl_vport.base.vport_id =3D=3D vc_event->vport_id)
> +	if (adapter->base.hw.device_id =3D=3D IDPF_DEV_ID_CPF &&
> +			adapter->ctrl_vport.base.vport_id =3D=3D vc_event->vport_id)
>  		return;
> =20
>  	vport =3D cpfl_find_vport(adapter, vc_event->vport_id); @@ -1903,18=20
> +1907,30 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)  {
>  	int i, ret;
> =20
> -	for (i =3D 0; i < CPFL_TX_CFGQ_NUM; i++) {
> -		ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, fals=
e,
> +	for (i =3D 0; i < adapter->num_tx_cfgq; i++) {
> +		if (adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF)
> +			ret =3D idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[0].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, false);
> +		else
> +			ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false,=20
> +false,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
> +
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to disable Tx config queue.");
>  			return ret;
>  		}
>  	}
> =20
> -	for (i =3D 0; i < CPFL_RX_CFGQ_NUM; i++) {
> -		ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, false=
,
> -								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
> +	for (i =3D 0; i < adapter->num_rx_cfgq; i++) {
> +		if (adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF)
> +			ret =3D idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[1].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, false);
> +		else
> +			ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, fals=
e,
> +							VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
> +
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to disable Rx config queue.");
>  			return ret;
> @@ -1922,6 +1938,7 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
>  	}
> =20
>  	return 0;
> +
>  }
> =20
>  static int
> @@ -1941,8 +1958,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
>  		return ret;
>  	}
> =20
> -	for (i =3D 0; i < CPFL_TX_CFGQ_NUM; i++) {
> -		ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, true=
,
> +	for (i =3D 0; i < adapter->num_tx_cfgq; i++) {
> +		if (adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF)
> +			ret =3D idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[0].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, true);
> +		else
> +			ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false,=20
> +true,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to enable Tx config queue."); @@ -1950,8=20
> +1972,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
>  		}
>  	}
> =20
> -	for (i =3D 0; i < CPFL_RX_CFGQ_NUM; i++) {
> -		ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, true,
> +	for (i =3D 0; i < adapter->num_rx_cfgq; i++) {
> +		if (adapter->base.hw.device_id =3D=3D IXD_DEV_ID_VCPF)
> +			ret =3D idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[1].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, true);
> +		else
> +			ret =3D idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true,=20
> +true,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to enable Rx config queue."); @@ -1971,14=20
> +1998,20 @@ cpfl_remove_cfgqs(struct cpfl_adapter_ext *adapter)
> =20
>  	create_cfgq_info =3D adapter->cfgq_info;
> =20
> -	for (i =3D 0; i < CPFL_CFGQ_NUM; i++) {
> -		if (adapter->ctlqp[i])
> +	for (i =3D 0; i < adapter->num_cfgq; i++) {
> +		if (adapter->ctlqp[i]) {
>  			cpfl_vport_ctlq_remove(hw, adapter->ctlqp[i]);
> +			adapter->ctlqp[i] =3D NULL;
> +		}
>  		if (create_cfgq_info[i].ring_mem.va)
>  			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].ring_mem);
>  		if (create_cfgq_info[i].buf_mem.va)
>  			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].buf_mem);
>  	}
> +	if (adapter->ctlqp) {
> +		rte_free(adapter->ctlqp);
> +		adapter->ctlqp =3D NULL;
> +	}
>  }
> =20
>  static int
> @@ -1988,7 +2021,16 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
>  	int ret =3D 0;
>  	int i =3D 0;
> =20
> -	for (i =3D 0; i < CPFL_CFGQ_NUM; i++) {
> +	adapter->ctlqp =3D rte_zmalloc("ctlqp", adapter->num_cfgq *
> +				sizeof(struct idpf_ctlq_info *),
> +				RTE_CACHE_LINE_SIZE);
> +
> +	if (!adapter->ctlqp) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for control queues");
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < adapter->num_cfgq; i++) {
>  		cfg_cq =3D NULL;
>  		ret =3D cpfl_vport_ctlq_add((struct idpf_hw *)(&adapter->base.hw),
>  					  &adapter->cfgq_info[i],
> @@ -2007,6 +2049,62 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
>  	return ret;
>  }
> =20
> +static
> +int vcpf_save_chunk_in_cfgq(struct cpfl_adapter_ext *adapter) {
> +	struct virtchnl2_add_queues *add_q =3D
> +		(struct virtchnl2_add_queues *)adapter->addq_recv_info;
> +	struct vcpf_cfg_queue *cfgq;
> +	struct virtchnl2_queue_reg_chunk *q_chnk;
> +	u16 rx, tx, num_chunks, num_q, struct_size;
> +	u32 q_id, q_type;
> +
> +	rx =3D 0; tx =3D 0;
> +
> +	cfgq =3D rte_zmalloc("cfgq", adapter->num_cfgq *
> +				sizeof(struct vcpf_cfg_queue),
> +				RTE_CACHE_LINE_SIZE);
> +

I suspect you can probably fix both sides of the multiply on a single line =
here, and still be within 100 chars. That will mak ethe code slightly easie=
r to read.
>> Thanks, will address this in v4.

> +	if (!cfgq) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for cfgq");
> +		return -ENOMEM;
> +	}
> +
> +	struct_size =3D idpf_struct_size(add_q, chunks.chunks, (add_q->chunks.n=
um_chunks - 1));
> +	adapter->cfgq_in.cfgq_add =3D rte_zmalloc("config_queues",=20
> +struct_size, 0);

Missing check for a failed zmalloc call.
>> thanks, will address this in v4.

> +	rte_memcpy(adapter->cfgq_in.cfgq_add, add_q, struct_size);
> +
> +	num_chunks =3D add_q->chunks.num_chunks;
> +	for (u16 i =3D 0; i < num_chunks; i++) {
> +		num_q =3D add_q->chunks.chunks[i].num_queues;
> +		q_chnk =3D &add_q->chunks.chunks[i];
> +		for (u16 j =3D 0; j < num_q; j++) {
> +			if (rx > adapter->num_cfgq || tx > adapter->num_cfgq)
> +				break;
> +			q_id =3D q_chnk->start_queue_id + j;
> +			q_type =3D q_chnk->type;
> +			if (q_type =3D=3D VIRTCHNL2_QUEUE_TYPE_MBX_TX) {
> +				cfgq[0].qid =3D q_id;
> +				cfgq[0].qtail_reg_start =3D q_chnk->qtail_reg_start;
> +				cfgq[0].qtail_reg_spacing =3D q_chnk->qtail_reg_spacing;
> +				q_chnk->type =3D VIRTCHNL2_QUEUE_TYPE_CONFIG_TX;
> +				tx++;
> +			} else if (q_type =3D=3D VIRTCHNL2_QUEUE_TYPE_MBX_RX) {
> +				cfgq[1].qid =3D q_id;
> +				cfgq[1].qtail_reg_start =3D q_chnk->qtail_reg_start;
> +				cfgq[1].qtail_reg_spacing =3D q_chnk->qtail_reg_spacing;
> +				q_chnk->type =3D VIRTCHNL2_QUEUE_TYPE_CONFIG_RX;
> +				rx++;
> +			}
> +		}
> +	}
> +
<snip>
