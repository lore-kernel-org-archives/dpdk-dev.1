Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C7CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 18:55:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2266402D8;
	Mon, 29 Sep 2025 20:55:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CBC4F4028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 20:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759172125; x=1790708125;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7PsPUTYkhTqRPGMVBtHUzVvA2jZJqFpXp4JFbk7ZjXM=;
 b=lD31gMQaaFS13156UfitcFfypzr0PkM2ce2LPeY2r7RzAEm3eDODX8ua
 dEboyliYcRthUwLA2A82FCYSInF3MZlyp+uOPV1dy2sWm/uVpOFvGDur3
 GemUk1mi8msYKQmSvyAe1gdY+ij6ifY/0ng/QykB9RQnWS+66lV0fo90G
 siKdprVKzWo4ra9UCNuiL73EOldWk+hF1pqDxgjAlkR/LHNgpkgyn0bgT
 N0uhqdF48+38PEG8DKxwZcANY5Ib7zXjSRdlCa0br4/LMETxssnS8HHnx
 k+bTmIbAs8//foc3KIqP5EHWEoIDDSeA4vo08U4YuFZ8gUo4WMgeoycXC Q==;
X-CSE-ConnectionGUID: xRJTR4dtSu2tkhH8ct4KVQ==
X-CSE-MsgGUID: tbRpIeBbTPiEWxlMdY9KUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="71669027"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="71669027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 11:55:23 -0700
X-CSE-ConnectionGUID: idZ1eB3zTWuPRE3UTpN+Rg==
X-CSE-MsgGUID: kmqB+w4uThKWN7rpXKXsYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; d="scan'208";a="178737259"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 11:55:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 11:55:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 11:55:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 11:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwifzDvNjvfz0gwt5uXdpN4Y/qZS3ars3oJXNac2G0a8QI/0+0khP+vqs8z2Qsdwdf7z5PkhQ2cEz3CfI/AIkce++DosJCZqfp/ZODt2EY3eOtXn1KJVgT6oGXDzcfYmvf5FACXcM2ukLpMuc3CGmj8RXCrNhLIu+3e+nKyYWt2TmrXk5ZWHmHeekVytr6ZAlC4Fcxjdg3vLtxSIwQtcWM5OGiBXd5F5+VBCy9pyfYZOs9LXrE0uaDmWPPsvKzW1PhyWUsfceg45f5ufTu+57r0Tud8TftNVFrJb9a519wXkazYWQnhsJ8zr603vkrtLmSBYeyou8uP4B3RMej5yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peo3cOo+sRNfs7X5ALk0szlRTux0Ly2DhTaHCZ2+XRY=;
 b=qS60QK5blopO5SvGlebONh5y+vMWiPjZQijaJGLrLAIl/J9Fq8zzJLsIb99F6yBkgq8Lp9U821Gm7GfPENcS0zIE+UvlHQcT8q5YYHT5lRbi6xC6K0g06gqhcFU7EU6nqajPoDD5979CwWuslK7AJnfSwF/zmrJ0w6RZqqbcxIxaZQqmTlzDznNMygXOuaFGWrMsS8uZCJA85xU5ohqsv+QBK/QtqF4455tHmmA8oZk4fWSg4824iASuwheF2xYsbrqEmz7/3fs3XJ783LVQEi9k+A0s/LNlT07hyG0/dyIpaPDwMy9DngTOt9EKao0XkYZepJQTITMtfRioSn97xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by PH8PR11MB6660.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 18:55:20 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Mon, 29 Sep 2025
 18:55:20 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Patel, Atul" <atul.patel@intel.com>, "Shukla, Dhananjay"
 <dhananjay.shukla@intel.com>
Subject: RE: [PATCH v3 1/4] net/intel: add vCPF PMD support
Thread-Topic: [PATCH v3 1/4] net/intel: add vCPF PMD support
Thread-Index: AQHcLG0bhUXvrECZMkG2+vmckak0sLSqHYEAgABp8KA=
Date: Mon, 29 Sep 2025 18:55:19 +0000
Message-ID: <DM3PPF291EF9BF1A28BD7092DCA7EB71DBB9D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-2-praveen.shetty@intel.com>
 <aNp5HMy-CqXfr6fX@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNp5HMy-CqXfr6fX@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: eb2d0bc6-c4a1-409a-2f5e-08ddff89bcd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?9hENBcxiqsRXKLxbfRRxNOksXpjWd53nh3FEcl6e9ZDEsNXxHNzCFQQUKPn2?=
 =?us-ascii?Q?ii0vTLAO2lScAOFOpbj/OHIcovQvFf+LKlnqrfge1r85SZUa8SwBFRyNNylF?=
 =?us-ascii?Q?7/qYFjar0vFPb15uoa18uj0wE8McV9+5NlxulykWE/1iN6J9iXmCsZWjvy1z?=
 =?us-ascii?Q?OlJfRR1NFXudpQo9gqX2LUtx2Fys4wy3EBbSUT0eVo1tNISDgumh4z42j0iL?=
 =?us-ascii?Q?zqreC89GJ5994xwrRJffM4DgCwVwE0GSf2Tdurq8jhQUkna+GZgQ1my9YGMW?=
 =?us-ascii?Q?QR/dVvoFlP0KARtewUAtBT8MW8hoGIcYz7TKab0xaEr6qR0Pvj5HD1ltSqW9?=
 =?us-ascii?Q?Xn7KgQstc1LDyvPubmY1nquMrbBXA6Ws9Lxxu1SXlC2Re3u24/xCum0vjsFq?=
 =?us-ascii?Q?YjQi3dZmW02yx7LEgk0L7NozBjIV7rsZ7i7UPXZe80yOK15+AuefSpPbFxyC?=
 =?us-ascii?Q?yWnC7uzfrd/z48XmlTxOGl9WUpY/7S5UAuNSJ8g6iFqnqMMhRidRAeiiFRAg?=
 =?us-ascii?Q?aq8js0ucxYkFzSGoMrQ1MrAqbAdb+nn+3Gv+Sl5zqYBEvGD5z6Arp3v+RobF?=
 =?us-ascii?Q?I53HVQyeBYdxU1+4h3h5rdJq8+QtEIuubDnqXUt6d/eDkaMw5dsQxaYn+0pU?=
 =?us-ascii?Q?J1q9FLftooSy9y3EWAiXmsEVLoO2zu7i+MLwiCFZ2KQiaICsKO6X4CUYIR0b?=
 =?us-ascii?Q?rr0ehmET4UhwuT5LNkIpZ83WMpNNhWSclnwfL1IJTfkOwUdUq29YuPgLfGMD?=
 =?us-ascii?Q?Uc+koOfRTB7FpFiAlj1mJbyPeGCofFVE+QU0lQ/5qOQ23WATni+JstxTzoZ1?=
 =?us-ascii?Q?Nq+9R4K/3vKeEroJyZFAXG6CLCUT4jbAYVIB39ELEW5cig8H1utNdp3UwSYc?=
 =?us-ascii?Q?i/wP/sh+3MYaQzwOzRf80Oq9CDzLPYDL2+kGlPNqHhKf1NuvZ0YlIXxclu0V?=
 =?us-ascii?Q?ZS3GgdP9xU3SFiJAfXkoUNpjO0Wmwmpk8vqR2yrKsf2mtbr4nJ4oqq0fkVZD?=
 =?us-ascii?Q?8e3HAzpEuTikUH+QwB3qMnUjvZih05Z2Pr6V+ab1s/ZoROgx12RD9KNIVeoN?=
 =?us-ascii?Q?dmFQWeTxKF9cREgIPvCkaNDZOZIRoyNn5xQapxuH5jigKY5aHynWYSMlbKgu?=
 =?us-ascii?Q?XvBJSoB+hE5qjigvkCVYg+9N14M2BO7MXliVce15+a1YaipoM98TYMTnkYqw?=
 =?us-ascii?Q?Cr2Y5bWLwfkGeomOCQdlpPjDbN4N/PCha2eMXXZxUX0fYrtCXxJHo3dc7gfc?=
 =?us-ascii?Q?PmiqzWPATcQedzEmRD7gRiPUwQ2R1y5aIc2ZAIBft+T1bSdPHxZ7EXS2g2oE?=
 =?us-ascii?Q?OJwMMTRDGmZKOdIxZ6ZOuRhjtNlpIg5Y4bLwYidYbc+VyKZHPa/WAqpA03ld?=
 =?us-ascii?Q?zQ4LZuX5/VxmSMvMGjFkfxoi61rb5XMU2jMz462E50kwVUtH3mEAwjdswLqx?=
 =?us-ascii?Q?3SzfyUxv1b+tI8gjQVEVs3NxpDRWvFiSXMo/2/y+ckygFsZvhSuCyOqJ5xZH?=
 =?us-ascii?Q?nAWOXc6OcXGc1JjKBplHOZ6w+0YDrhcgSBzO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKyIZcyTTZ+D1Bk4dx5TbpBXwvYo8N8aPX+rH2H2GZxW/2w2TJfuV/KKm2hb?=
 =?us-ascii?Q?0ZQ3egRC/kXc2gpoVnbULudnUUoVBy1kLA1pYJPDg9IB2s0BoHaIdouumlaI?=
 =?us-ascii?Q?xIBEaE3KGP+hbmB4sKKH7Lguv7hYCjkUIMnc7oz7Aws8m+ZoAuUXP2AkNEH/?=
 =?us-ascii?Q?x0A4KJ/cwfrwYFfQBvQFqDKdu/iY7r9UsGd7r4fFDu20wo2UeJya3kDyNT8p?=
 =?us-ascii?Q?gcWrE+b8zRTtGydLcD3zFmOKCr1cEOGvXYP6w2AewEkuem3Yrp8iY24Q/B98?=
 =?us-ascii?Q?FshfD+yhKG1W6sl1YGOKnBPRX39FbJD0s8+hTZbn5xDwqbMZg8SkcYMkT80E?=
 =?us-ascii?Q?04yQs3NOpHHjT3/w50HJ9nndXH1BExjghkQldoMmxMDmam7yKL9EPrFjcDvk?=
 =?us-ascii?Q?BKE+p8uU4hotgEU6Sflqrn/Jldx13VIZKccThzBXmSW6Oz4NH79ELU3QOrpO?=
 =?us-ascii?Q?9GrZLPsIPjgMVf2kQev59m+bsEnRmxV3RRCidsUj95yvKlfsQB2ht+2ip+yY?=
 =?us-ascii?Q?KKlGGF4uhqfOHJGzhQgpLluQRbAbY5miKA+hauwjg+XZIgqhgQEdWGIQoVlV?=
 =?us-ascii?Q?rnuPf9Vu81IabPk/i0zgTU7Yqu0E+Vcv47ZmwMsFVaaJ7juxhDLQGQ0Qfg9R?=
 =?us-ascii?Q?4FdezAW0C8Ne06BLinLxS59hs/yT4Maz4lnfKpgJKhf6UFKgbB0xifZ4/VVn?=
 =?us-ascii?Q?ZKaQu4Kmc0MP5pJtU1HjS9wz3PXFJ4p7mhg47lqs7LMEsdnM5h/00wvM4t9m?=
 =?us-ascii?Q?cHYekWfoIpe5f8aRg8yoNHm18yoejlzqQkMbgnU9lHJjmn+eaIQ7iP7jZcUJ?=
 =?us-ascii?Q?baXWeqGK6M91p5gJgQugjgEyoPypRcdkZqOKxFacW/8dZlo111vAhKjbz0c/?=
 =?us-ascii?Q?zut6MV+9EoAMeGBRsX5+r/SJL28rOJpHPKpCbNJU1yddGkU+Bua0TQXZCTYW?=
 =?us-ascii?Q?r0e5Mh73Y/pWTQnGxVxotL55G4SK0FgrlU7MUSfSCQWCq+IvKqAYCj/h6Tp5?=
 =?us-ascii?Q?iyAmCp/hDaOo4KUTgiIydMY9eD0bzNieUwuOEpVYm/Aehqe/jH1T1NJ+KQZ/?=
 =?us-ascii?Q?JqooUo3Xw0uurKWCo0q/S+owc+7RQaJZkqQOpcHX+jF9wszjsvQOu+q0LAcG?=
 =?us-ascii?Q?A4iBY8mvO2wcfyGMseOM42KGDPVS58T7qhOgxpnTvV5oZDLcWu/tivIJtfwZ?=
 =?us-ascii?Q?lXFv0E4OR73t02wpQkQHxKypE9fYsN+8SDIrAmGZ5ILpR44ObujHA6cqL7kX?=
 =?us-ascii?Q?Bsd09EvXBG60qjZE+TdJOx8KXO99OGihtKG/f++7M8fzoaPU9TolDwX4aD7V?=
 =?us-ascii?Q?rkOSi0o6FdXOktXB5CygkLZ176OWFBrI4LscgDppXRK5yXFvauDWREmLYuKE?=
 =?us-ascii?Q?Ift1UqDk97D9PKFR8uUxHRLmt2iA1sZRT5qFLEcS36pMNiay49aSCauY8oIl?=
 =?us-ascii?Q?B5qPrbcKF1MzSnP9bNXbmShq4ymjaBli3cBkXFKKLo0vg8aZAFN/aKDDFwcu?=
 =?us-ascii?Q?iz3joA63jYbY9DTJoR3GESGpG/7JoS9dlOuDhb/eWPb3udvoai+kV2rsXKEW?=
 =?us-ascii?Q?sqHb8Kert2FTspPG18uifmymUe8rqSOuDWWpDELW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2d0bc6-c4a1-409a-2f5e-08ddff89bcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 18:55:20.0126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5KOua1bRPEFwdSkS4Z5L8l/dNYMrL8uDXWy+TK8L3nWhh0WLRZbth3G1Lb9YVdtBjhwbMWau/HgH9hZbrxoYnr252Ek4BDkCjXyfZpA1J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
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


On Tue, Sep 23, 2025 at 02:54:52PM +0200, Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
>=20
> This patch adds the registration support for a new vCPF PMD.
> vCPF PMD is responsible for enabling control and data path=20
> functionality for the CPF VF devices.
>=20
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Tested-by: Atul Patel  <atul.patel@intel.com>
> Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---

A few minor comments inline below.

/Bruce

>  drivers/net/intel/cpfl/cpfl_ethdev.c        | 17 +++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.h        |  1 +
>  drivers/net/intel/idpf/idpf_common_device.c |  4 ++-- =20
> drivers/net/intel/idpf/idpf_common_device.h |  1 +
>  4 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 6d7b23ad7a..d6227c99b5 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -1854,6 +1854,7 @@ cpfl_handle_virtchnl_msg(struct cpfl_adapter_ext=20
> *adapter)
> =20
>  		switch (mbx_op) {
>  		case idpf_mbq_opc_send_msg_to_peer_pf:
> +		case idpf_mbq_opc_send_msg_to_peer_drv:
>  			if (vc_op =3D=3D VIRTCHNL2_OP_EVENT) {
>  				cpfl_handle_vchnl_event_msg(adapter, adapter->base.mbx_resp,
>  							    ctlq_msg.data_len);
> @@ -2610,6 +2611,11 @@ static const struct rte_pci_id pci_id_cpfl_map[] =
=3D {
>  	{ .vendor_id =3D 0, /* sentinel */ },
>  };
> =20
> +static const struct rte_pci_id pci_id_vcpf_map[] =3D {
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IXD_DEV_ID_VCPF) },
> +	{ .vendor_id =3D 0, /* sentinel */ },
> +};
> +
>  static struct cpfl_adapter_ext *
>  cpfl_find_adapter_ext(struct rte_pci_device *pci_dev)  { @@ -2866,6=20
> +2872,14 @@ static struct rte_pci_driver rte_cpfl_pmd =3D {
>  	.remove		=3D cpfl_pci_remove,
>  };
> =20
> +static struct rte_pci_driver rte_vcpf_pmd =3D {
> +	.id_table	=3D pci_id_vcpf_map,
> +	.drv_flags	=3D RTE_PCI_DRV_NEED_MAPPING |
> +			  RTE_PCI_DRV_PROBE_AGAIN,
> +	.probe		=3D cpfl_pci_probe,
> +	.remove		=3D cpfl_pci_remove,
> +};
> +
>  /**
>   * Driver initialization routine.
>   * Invoked once at EAL init time.
> @@ -2874,6 +2888,9 @@ static struct rte_pci_driver rte_cpfl_pmd =3D { =20
> RTE_PMD_REGISTER_PCI(net_cpfl, rte_cpfl_pmd); =20
> RTE_PMD_REGISTER_PCI_TABLE(net_cpfl, pci_id_cpfl_map); =20
> RTE_PMD_REGISTER_KMOD_DEP(net_cpfl, "* igb_uio | vfio-pci");
> +RTE_PMD_REGISTER_PCI(net_vcpf, rte_vcpf_pmd);=20
> +RTE_PMD_REGISTER_PCI_TABLE(net_vcpf, pci_id_vcpf_map);=20
> +RTE_PMD_REGISTER_KMOD_DEP(net_vcpf, "* igb_uio | vfio-pci");

Minor question - do you know if this works with uio_pci_generic, or has it =
been tested? With igb_uio largely unmaintained right now, the in-tree uio w=
ould be good to be able to recommend if vfio is not an option.
>> No, it doesn't work with uio_pci_generic, I was getting DMA transaction =
failure when I try to use it. Will update the macro to have only vfio-pci a=
s a KMOD_DEP.=20

>  RTE_PMD_REGISTER_PARAM_STRING(net_cpfl,
>  	CPFL_TX_SINGLE_Q "=3D<0|1> "
>  	CPFL_RX_SINGLE_Q "=3D<0|1> "
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h=20
> b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d4e1176ab1..2cfcdd6206 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -60,6 +60,7 @@
> =20
>  /* Device IDs */
>  #define IDPF_DEV_ID_CPF			0x1453
> +#define IXD_DEV_ID_VCPF			0x1203
>  #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
> =20

I see the same device id added twice, once in cpfl and once in idpf drivers=
. Can the cpfl driver re-use the definition from idpf_common_device and sav=
e duplication?
> Sure, will address this in v4.

>  #define CPFL_HOST_ID_NUM	2
> diff --git a/drivers/net/intel/idpf/idpf_common_device.c=20
> b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..8c637a2fb6 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
>  	struct idpf_ctlq_info *ctlq;
>  	int ret =3D 0;
> =20
> -	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV)
> +	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV || hw->device_id =3D=3D=20
> +IXD_DEV_ID_VCPF)
>  		ret =3D idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
>  	else
>  		ret =3D idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info); @@ -389,7=20
> +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  	struct idpf_hw *hw =3D &adapter->hw;
>  	int ret;
> =20
> -	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV) {
> +	if (hw->device_id =3D=3D IDPF_DEV_ID_SRIOV || hw->device_id =3D=3D=20
> +IXD_DEV_ID_VCPF) {
>  		ret =3D idpf_check_vf_reset_done(hw);
>  	} else {
>  		idpf_reset_pf(hw);
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h=20
> b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..d536ce7e15 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -11,6 +11,7 @@
>  #include "idpf_common_logs.h"
> =20
>  #define IDPF_DEV_ID_SRIOV	0x145C
> +#define IXD_DEV_ID_VCPF         0x1203
> =20
>  #define IDPF_RSS_KEY_LEN	52
> =20
> --
> 2.37.3
>=20
