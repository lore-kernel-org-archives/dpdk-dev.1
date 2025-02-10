Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0199C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93FBE40659;
	Mon, 10 Feb 2025 22:32:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D494C402EF
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739223153; x=1770759153;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=545Th2JCpET1LqkJ0UK6rvMibK8oSiJL8Bqup/abAcQ=;
 b=lj/FraXidWgL/5FWB+C4edq+POFhzgbnllCmI2/ghp78+Ujm+guYyiUp
 /uEJngYpPkMfMDLxil7z8/oucrmYVUQPaVgKILEDxxj2jmVGKY+Dp7wqu
 yHxt4vNXUlooLlDAP52v89sOtX+lg1rHz61jpZeeWcwrtOXl10BRgQNWu
 JO0ZvoUHh0zQIEirGmE2CyG3Zg1otM8eHoTov833ys9aXBctV/sELkttt
 h9La1OwQWSgFD539DYCRU1FaP98DIPlx72LMmZhcEPc+whG9FLJacHHI4
 iIvdswpLhpufCTaxMQneJ1vlyR03CDh815YS0a4cBcgn8FQ8fNSaJ1cLc Q==;
X-CSE-ConnectionGUID: Cw6Zu34DR6aDF9GeNnOZvA==
X-CSE-MsgGUID: 9aHRx+tVQ5m+VGLWxIVo/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65179467"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="65179467"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 13:32:32 -0800
X-CSE-ConnectionGUID: yEXPBMI2Qk2jtm0RE9CgqQ==
X-CSE-MsgGUID: n4NxoYV7Rn6MNVmu7H4/AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="135577928"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 13:32:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 13:32:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 13:32:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 13:32:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyzauMTg+JdQ09WI4V+Bkk5sVY3eZITam6CJSyZXlfDFmPwVvPuIlxE2TIBRdLMM2xVp0wIe6RD5Qu/Iny36bY/DYQFi3GyDbXZatr2Gglg8f/vw4gOI/Z869L8G2SpRraVcOaITOMxvybWN+qEPgqm/Nh2ppFHPZEeLJBxEfC6C5bNQqZe2WAsrdaWhF2QDxDKUiIPH+kBIkiJdwznIXwFODc27+u91TqkSD5WJM4+bdIgxXKLinlRiGXGtJ5em6KKpiU0R6gVLgZVntEwlpxsiX2p1DaZHOQ6EdSmXuYqkEAwkWjnpAqYCShCc0uLwDuDyqrk53+mtITN5yK0ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bgjs+nb4HxZFRZuuZ+8o7KcL73ZlRBCuzm7bbA5Q2U=;
 b=FWq058olNgdLYMxje+PqE9B+qRJK4lg+OVd9vWTRK2OFn4afC6K6mhlW8GW2rj+8DVv1G8gmaZrOLL7PbkQtOW4CpnopC8sTIwu603SCToVvpnr7BPPWed7Z3PeWYqIkT5OYHawD3hrxdXFynKmWNu4gVRHhV2/htnFunGmTPZqtyqSWT0c6j+A5ZbpSVYUDY1iRS0OptBbcytmjWKBllLoszZO6N5iFOhgyPk9Cgpfw8s5G09ieh4O9HZMOIDEHF8wfT04qE/QaKoRUrIb5UeHZuKW5eUnd1l+PKz6vAOHFWsWckYzPUP+ynxHIihZHC4vx3MSDF+Pt9KwSOVIOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 21:32:27 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 21:32:27 +0000
From: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "ferruh.yigit@amd.com"
 <ferruh.yigit@amd.com>, "Ji, Kai" <kai.ji@intel.com>, "Dooley, Brian"
 <brian.dooley@intel.com>
Subject: RE: [PATCH v5] net: add thread-safe crc api
Thread-Topic: [PATCH v5] net: add thread-safe crc api
Thread-Index: AQHbeY2ZT0aWiV/FGUSc3uHBWUa1BrNA+OmAgAAZc3A=
Date: Mon, 10 Feb 2025 21:32:27 +0000
Message-ID: <PH0PR11MB5013F132847D3E2FA26F3D939FF22@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
 <20250207182443.9775-1-arkadiuszx.kusztal@intel.com>
 <20250210115727.4e2570dd@hermes.local>
In-Reply-To: <20250210115727.4e2570dd@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH8PR11MB7069:EE_
x-ms-office365-filtering-correlation-id: 66a9d12b-1858-4f0a-f71d-08dd4a1a6a8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OE0Z/XpXfMPbweQpSxGnI6aHwFuEYRIUNaX830Uud21dm2V4FnTVq7Z9hMhI?=
 =?us-ascii?Q?3/RQFSOCPrtK1QMAjkdKGu6N1RDncP1JylzoOZ9ykZvMKc5gOn/KrqOU0O9+?=
 =?us-ascii?Q?LGyshtxCGZcRyZiMAX0GoC0EFKn1Nti/3JGGiQFMWIQtXtUY3k+RMS6UtSD7?=
 =?us-ascii?Q?t8PdQZXDxMa9SptqNrke8Xfqn/NycBNcaukcD1cLLZvcMgtlDZAmnkXC36MO?=
 =?us-ascii?Q?D3B8fzV0i8bPbMpWLcb1KmyBm4yY26StSs+H9oeCQ5dg2PR5N3G5hTHfDutg?=
 =?us-ascii?Q?eb0REb6gXp3hPBvuVlOFKCuuvK49E8lwWiQdfWfI3USdBJb7pu86vCVV+sJn?=
 =?us-ascii?Q?xtbUPN1G+L6RQbdAlwckEJmj0V1xkHEsd1SLT/9UKSp30IbRxvr6N2sZTgFE?=
 =?us-ascii?Q?HS1n2etBYKWOxaaVQusiZwJVDRVGYyrp1Tz9Nxkpo2tjRK3TpVQATl3kiKTZ?=
 =?us-ascii?Q?AedJuLafkBZ0ghQlBGhcjTtABucKrWonuqTs/h02c8md8I1fw+iINbUea+YC?=
 =?us-ascii?Q?MYIst7GSf+1TZDcSknOlWFzVg1c/as4GcLHqHgNhARHRnhatK8maT0AGWwR5?=
 =?us-ascii?Q?HUVdPGbgfJevzCxmuBj9XWM3jrfMEH23S2mJ3KZhjUMyg1hMipAJcgTeNXtb?=
 =?us-ascii?Q?S9SSKasAD96D1RrTWIMi6Isl+g1H7HzLnpFBaQp7WEXIx1pxlLZy9gAb3+4m?=
 =?us-ascii?Q?Fslfl+FLRMTnfLC2oTagBaTpUSvAh2PHUwcezaywu0s/X7txb0FbXGFuFfp5?=
 =?us-ascii?Q?/yh8ngyiud2PZbAhjGgj5r9zmS1KCKPx7DSuoCePXAxpW2iUgA7cjXt90eKe?=
 =?us-ascii?Q?EsUBgWpRzFOsAGNLUQ9db5i33+YppKD4aKN1eCKH7RconQXx7woN5Kc6ZumF?=
 =?us-ascii?Q?CNvtV3uizbyv9YOn3eYfrNYh4mtPf/dQt/yzBRV6zyXZ2hTb2V9OxMxPI2HW?=
 =?us-ascii?Q?j1I+SQTxjaBx9wyftUqmSJIDOdm+OacVGgaYarXM25foIMeQG5eYvfmDF2MU?=
 =?us-ascii?Q?/rvhyS8Qo5H59jgvUfRV3le6Ub4Bad4dgATmPBFBzCPa9rBEfPT2DupRWeBR?=
 =?us-ascii?Q?lI9pphyWvPoKgJElRm59TQuIBFLXJZ+CMFb3q32GAeJsapgonuLMfVc/pH7n?=
 =?us-ascii?Q?Q6yCvF9SNyg50aLlQa3Kr7N5nf0w8ojcTXj/Cjhe5FQXrKV26SzS8esDp57F?=
 =?us-ascii?Q?lIe/v35LWy5VeZnSJsq/cSnsa+W8oVAqnicpb4i0Zhpe8GTek8wQxSIWz0sd?=
 =?us-ascii?Q?AHyRZ+VvZ9hsfpfC8rhjt28RRbONJNqcrcNzeg7GATZjiG3cbz9u5tk7Syx3?=
 =?us-ascii?Q?nxvq/vmJIJEMUEYdDyvLh3zHPYQyvT9f2/7xpm/xQraCNn+DakxD3Uo3m9fO?=
 =?us-ascii?Q?4Tdc6jfgxZMK7dTJLA5vniZd+TekHpbHh/6kH0Bs7WLT5b9qYgp7MIachEPz?=
 =?us-ascii?Q?YklYgvAWj8AJ1AxlpvyEA/7Dy2IvlRhp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5013.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Un3pBiYBGZZSyf4OIdYiud/EEv6LC10U/XgcPyinhOaiPibWrbinH/x/l5Hd?=
 =?us-ascii?Q?xFmj9v60rFY6nkw0XIuF0n2rmYmlwvtHBtya3ZrcIDYPGm08B1Rj42Q1f4k/?=
 =?us-ascii?Q?ezSu8JnYRu5nW0W6CKE4CxKY/0hGt612uRqUi9acQYVFPFGv3ZPoor8q/lHy?=
 =?us-ascii?Q?m4AguzpH7hqSDPAjqIAPIb5WoNlljTe9alxLB9WJG0hvrDN8PSMA8aueSRtT?=
 =?us-ascii?Q?zPXYMFz1nlE/YLc7NVW9b3yxM6ziwYZ4QrZGsNdDt66Jd3n7G8zk2vd1PTTb?=
 =?us-ascii?Q?3LztdhCZboZXRLDud9IuSN8Pl3hF5X1l8WVI8okbziRWDhpETAOeSyf3fzAo?=
 =?us-ascii?Q?5Yg+/xRMFjWC0sVAFlL9RI4sxW2kfVzieCKA71g7NueRwfQ8ZegKgKkxJyr0?=
 =?us-ascii?Q?KoXdqHtace/HC5MCeGwGIZtE6KlMf3+dez3AmAGPse3hB/EdpRvWiG6JWisa?=
 =?us-ascii?Q?4j1xFKbrHGwylTpovx9K0Ts69GFug6MYP74Wsnyw2qMFvwc9U6JFNEACHxZO?=
 =?us-ascii?Q?xnolmGKcNOq8wIpvJQAwgpwx3MfzBAWl4WaQF8q64AbLLEJnOos0C9w9yd3X?=
 =?us-ascii?Q?l6Y8xLfN2LxT5xLNrJnc9FlnK/leSnP3Mw4XiVlgJD6qZmFCNLrJEPXCZYvK?=
 =?us-ascii?Q?UeOZRcmy+QOC5lCzgv64c5nQTNNS4rSmTSaXFPTlaB+0hAuFaFeOkyzmrlsM?=
 =?us-ascii?Q?/NPIbQ9GqhbU6V7NeiWkMbZnVRiJC2cDukm3fqniYhAop1QrnlV7gyPxtEk8?=
 =?us-ascii?Q?GVrM5OJjecvg/5FKObGxSvR5w0ACasVIkBSzbOwnsrD/l2pOTSqi9gyyWxhI?=
 =?us-ascii?Q?Uqkz7I6FOqOMnSKxIzHP0kRRUxYRGdBFDbl+luQP4TU5JiemGEG/yVWpB/wR?=
 =?us-ascii?Q?XRcLkPcGegLXKHNCnx2x4+GUDIfuQGJVqztd5D9I7UW5awbo0m/JXXySN01i?=
 =?us-ascii?Q?lm1qsJFqCX/SxuSoKcP0ZCYK6p8dW41+/e6YSX7nabWFCwdCkNL20BZ/fyrP?=
 =?us-ascii?Q?3/0gP3gIDBlPhNoiJ5iR6NEA7qX4X8yn0PHWuo1X6/l3NIR8E2PeBBEDvvoT?=
 =?us-ascii?Q?iWkjulsXDklNzBElTskDmo/yUApo6eNO9jJJEhxZxV6WdgS2PfBKofVe5N6w?=
 =?us-ascii?Q?OaZ1dyhyGngXq7X562zTFs7Q1VoeQq39U/6e5m7fSxNolEP/LnEzAQFR8nUm?=
 =?us-ascii?Q?bPMhAxCFSq3mGIAi8T55c67zhkFkwgnjLKkGsmO8DtkxeYcozAiyb+LjHzLT?=
 =?us-ascii?Q?3XEWrtR2WJrHz/B6IOvyKxFTQzRZtY2EKOH468cdJZ/e33xQ2Wy1b7AgJ8DT?=
 =?us-ascii?Q?PWu3s66q5nSEHMQSyFEMpzF/Ue/J179L/45phmQ+AyfIj0k6BbVxghuE57BC?=
 =?us-ascii?Q?qWyacuPDpxpxY+nlAl+djJSK3b5M4Ud/y8DBaUfg667EofZx0TCTzjpZ8XtA?=
 =?us-ascii?Q?3bM9diWQ6Yr4aOeH/iopDf7OJf7mxNZWHfSBg3gzjJTiKjBHDFZuStN8qup3?=
 =?us-ascii?Q?n6vM3Z8NpPGX72+CeRIFm457Ih6k0+zVlG6rRlcKa1nA7zHninl9kKP7OzKq?=
 =?us-ascii?Q?8f0KgNQ0Ky3d5dnWw3wXHOsAgSdtVuBGAfJ7sIbts0RO8igAOrIj8k5skrZ6?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a9d12b-1858-4f0a-f71d-08dd4a1a6a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 21:32:27.3560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/ciFwZRdKGrO1tJbQ6geTdprX1DGSsANECjbd251SNYiHYOropFuDFnbiEOmK7LPgt1/yZEP5FBLdVOrYyY1pq8BUtzMUmGXE75Rcyewcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, February 10, 2025 8:57 PM
> To: Kusztal, ArkadiuszX <arkadiuszx.kusztal@intel.com>
> Cc: dev@dpdk.org; ferruh.yigit@amd.com; Ji, Kai <kai.ji@intel.com>; Doole=
y,
> Brian <brian.dooley@intel.com>
> Subject: Re: [PATCH v5] net: add thread-safe crc api
>=20
> On Fri,  7 Feb 2025 18:24:43 +0000
> Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:
>=20
> > +static struct
> > +{
> > +	rte_net_crc_handler f[RTE_NET_CRC_REQS]; }
> > +handlers_dpdk26[RTE_NET_CRC_AVX512 + 1];
> > +
>=20
> Should have { after the struct
+1
>=20
> +void rte_net_crc_free(struct rte_net_crc *crc) {
> +	rte_free(crc);
> +}
>=20
> Add rte_net_crc_free to the coccinelle script that checks for null free.
Added in v6.
> Also add function attributes please.
Not sure about this one, other `free` functions are not declared with any a=
ttributes.
>=20
> > diff --git a/lib/net/rte_net_crc.h b/lib/net/rte_net_crc.h index
> > 72d3e10ff6..ffac8c2f1f 100644
> > --- a/lib/net/rte_net_crc.h
> > +++ b/lib/net/rte_net_crc.h
> > @@ -1,5 +1,5 @@
> >  /* SPDX-License-Identifier: BSD-3-Clause
> > - * Copyright(c) 2017-2020 Intel Corporation
> > + * Copyright(c) 2017-2025 Intel Corporation
> >   */
>=20
> Not sure what DPDK policy is around copyright date updates.
> The Linux kernel has said no to this (excess churn).
I reverted those changes in v6.
>=20
> > +struct rte_net_crc *rte_net_crc_set_alg_v26(enum rte_net_crc_alg alg,
> > +	enum rte_net_crc_type type)
>=20
> Since this now an allocator should add function attributes __rte_malloc a=
nd
> __rte_dealloc(rte_crc_free, 1).
Added in v6.
>=20
>=20
> > +{
> > +	uint16_t max_simd_bitwidth;
> > +	struct rte_net_crc *crc;
> > +
> > +	crc =3D rte_zmalloc(NULL, sizeof(struct rte_net_crc), 0);
> > +	if (crc =3D=3D NULL)
> > +		return NULL;
>=20
> Are you using rte_malloc here because it can be shared between
> primary/secondary?
Yes, this pointer may be referenced by another process, so memory it points=
 to must be available to other processes.
> Otherwise regular malloc has more checks.
