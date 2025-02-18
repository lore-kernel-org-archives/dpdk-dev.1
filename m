Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B14C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406F6402C4;
	Tue, 18 Feb 2025 12:01:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 142D0402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739876483; x=1771412483;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yfui1e1r+xR6Qrc81nZVYYTz8Y8Nmpg3eEVKTY0xi6Q=;
 b=CagUiRL1Q9krJur2oAgySMaaaPMsdtOiU0MPn7YpYU4skRol7exEHmXK
 wNtShEMSWD6vuC0btXRrJOfsIA72cxdW68oZIO0nvK/EmorPsON1CIpWd
 CC4+AK2LCPLcKRL/GzjGpJOnWsDA8B2glovKmm+ucE8TYZR39wfrtBjgK
 rCw5abFwhXEXCWp397/GCGqUValkUmWx28xCZ7eMBSS/K4PUiDf9lN9te
 Oo7XvmXVpK6anB6sb/e1YdR8lKIxgZw7C0pqb92c9WMbo1QrizWYvr0JA
 iJ7rO0q3fhf3VZ+4UsF0KZ/cgs1n4LBV+UKvtoJMAsTa3iZnI/D9av6vh A==;
X-CSE-ConnectionGUID: c4z78yfpTgO/hNdr1Ln34g==
X-CSE-MsgGUID: xovvFw9ySOydJY57Pkbe7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51551124"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51551124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:01:22 -0800
X-CSE-ConnectionGUID: gOA2D25/Q6eEU/p6Hd5xWQ==
X-CSE-MsgGUID: onEsz99tS8ybD8UJclyoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118485432"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:01:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Feb 2025 03:01:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Feb 2025 03:01:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 03:01:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms/9F60iuqDYxi6UHRzAcLUP+zrKCeDKA0Omt4HsQgqmHasEssr9XXhrF4uqGdS38zvSr+pABWPNcjzs2WAA4ikA5ThGXxFPpsoYRlEuJIA1PFNTTVWl7ubopSlNBblxACXjXZ0yxAscPoC6OZvAYTH29CaMdJr89o57KhmPJTCwoVTIvRJCD+JjJAfVxVaAWAkEMz0Gwr/fio3KIrHoi2ShHGrQiVeMnqRLNVUzpvHbyneOi3I0UPinC6wlxZOyKd9oldNB+1zrN7TdPLe80KYjVJTo7RNhVBzZzBiKo3F67cD6HhYbJpO9VE9HR89JCg689q/UsengifHFhm5VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRMo4NQY8i2S3pnDIyU38U0MLZJxkKZxy+pxlrDXRAI=;
 b=rADJC5Jw25oFi2BlQe/J9rPrtxXm62mMbLGBPKvPA/NrcY80x0UXObjKwoq/jTN5qNjIFg+oF91r/zEwIt1ox4sQlausF/9y7WOv7aZnKk8msu4yv9kTS0yl7RC9Kpk3QWwFfg6r3s3mLjkqipy484oQVePW4vnUUD9IEigfnvCK38o8B2N2ACcFy2N/dLAxjgpUHf0mR0Q7mDgnlJcWPbV1juHt90D60IULVv27Sf9ghm7laSIcU28IZHRHuI4qMt5351HGhXhtca8NuBcAKoOBE+N1qV/744Zym0Ao85hXNV5ZRo2d2Tmu5oHCkqNCj7eCG+P+AJEj2S1J4gcYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13)
 by BY1PR11MB8029.namprd11.prod.outlook.com (2603:10b6:a03:526::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 11:01:04 +0000
Received: from CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::5204:ecdf:ea31:48db]) by CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::5204:ecdf:ea31:48db%5]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 11:01:04 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>, 
 "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v3 2/2] app/test: add SM4 GCM tests
Thread-Topic: [PATCH v3 2/2] app/test: add SM4 GCM tests
Thread-Index: AQHbZd4VIxWLz+ixdEaDmKFE6N+gt7NNG3SQ
Date: Tue, 18 Feb 2025 11:01:04 +0000
Message-ID: <CO6PR11MB5587C483401784584A2B999984FA2@CO6PR11MB5587.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250113171022.1649181-1-brian.dooley@intel.com>
 <20250113171022.1649181-2-brian.dooley@intel.com>
In-Reply-To: <20250113171022.1649181-2-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5587:EE_|BY1PR11MB8029:EE_
x-ms-office365-filtering-correlation-id: 1667176f-01c7-4359-4e50-08dd500b89c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+RFHnyA8MjmYbC5UYT0jiHA0Qkv44yGWWPA5LYzlVbNGEg5t8tfaVtCyQW44?=
 =?us-ascii?Q?OfWsSs6OM0aPw/+m+FLl1d85FfemwSKW2yvnh++Jr2aHPyzpo3MCJboSEHjO?=
 =?us-ascii?Q?H9dzCTy2QNl7jlUFQfa63j3It7UZzsn0isNCBzjUo/y2ir1UU0Sy1Us68a9C?=
 =?us-ascii?Q?kLK8/x6FXUBdlOSBmRXk8csABsx0Lm+FefcIp59SjbEz8oARQavtcKtDM4t+?=
 =?us-ascii?Q?WdJ4fsrskGodtHTPyy97TYT3fLTZoax2NJyqChWdQqTZvyf9B+7CxgIh5xbR?=
 =?us-ascii?Q?i672D3q5HBh6ReIWi+dqLjrdwbPpBII/ZtzlGWSGSK1E7TmXSkxY49CBVmqf?=
 =?us-ascii?Q?g9D60Lw/ShznIrqip4b/DMU7vPGu7Dda8hxWgEJfT0zLGAZPCsax832pJggj?=
 =?us-ascii?Q?1jiWLwiO3/iewXJvjXxZO1Qjm6er+FQ3AahMc2actNIrK+PxQmX61xZyHqeZ?=
 =?us-ascii?Q?yMkByHBkYiuvhzHWvs9PAhZRp7kKf1yBL0SbuLULx7Jy/NbjqBhEHdb2V77J?=
 =?us-ascii?Q?1zFoGZRvkl5NSH4xRFkbIyPZMPBb5qIWlxU7aX5B7yyolzLwBCG609REkQ1J?=
 =?us-ascii?Q?+mffH1K+c8/2qz5Kyuqugg4k5EtAkWL+fsQvBmQ9n8ju/usC9OF+c3i+E2gk?=
 =?us-ascii?Q?6MZkcCoErcF63A7x5ba2ViYhhHHmHA1MI/4LGKFJ0C+h5GstqwPN1DsfWpaE?=
 =?us-ascii?Q?tAt1JY67nDbZYEPL6dQI9bojrzlUILIJ6FEmg1ySSh/wmbWiBFIGvua0NJrh?=
 =?us-ascii?Q?TewIfkJB2Cb09sTCUbOy69AdjwhfrKy2ecznh/4nVtO+tLkPoSxbee9Y3eiK?=
 =?us-ascii?Q?SSM01mH96cT0O8j+el3AkAvHC9E4NLJV0lcA6YCtHm0Nx6LHOJQBduF5B0ni?=
 =?us-ascii?Q?TVqLJHkBaE5wvnRur9673sGtg+V1W8bKyzafgROUZ6jk+y8KtNPZ1ZuGefFk?=
 =?us-ascii?Q?4cDadVzZJaE6+QBdvOmeT3PE7FjaVej9TZdbRNXM420tQbOcHMZvaozNGStn?=
 =?us-ascii?Q?0AVH1EdpwjXq6aEIG7OX24qKId5NAfYUqJ0F8hNtPGu5B43ZWYvKYjh5z8IY?=
 =?us-ascii?Q?n5S7/atA4UlTU3eHG6zdR8P4PtsEiCOQ1aFikNjAL7LoqjvzKDBffbifAsoZ?=
 =?us-ascii?Q?HBtDp0ptOldV60UDxFJ12Wx6XvAAEst7dgaWTcM1h+GaLeFBopo0bTB3CiTs?=
 =?us-ascii?Q?3Bp+8qYHhEC/JjRNFR6ujNVX10iYRhbN4rs53sEGpkUH+OhNq+CyeJDC9Yu2?=
 =?us-ascii?Q?0bA60YnOx6xyPpiFUzOFMNel0AWWwUQlWafrnuJt57mGQDc1a+R+hhCmm/L5?=
 =?us-ascii?Q?KApdGfuLfECsN9UtMaF+2moau3ZFfbmITNnHojdcwUnmZMZtk0yPsVqMA822?=
 =?us-ascii?Q?ko/tNwzgsLa9jWHdBR732RdfJPjO+AAZxbaSl/FZhkqnFGZd+WKsI01hIaY+?=
 =?us-ascii?Q?1eKbmfkBvcKJjN8BIw7Gv3eM7eDts9jP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5587.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1wV8iuK2ZEYb41ySKLOxppcMiKBRa3RzcVJuDMNToCp94luan7bpf4zngSBb?=
 =?us-ascii?Q?gi+sRXOjCCYZ2IiwmMFP1R8v1CCl92dDiNKDMnx+qat47VBBSbfT9F6aqMga?=
 =?us-ascii?Q?pWMP8Npb+hb7oDb29BP4AQYQUpA0IOUOeTOrwUqcMh3OCtO0DpTO3S43nveW?=
 =?us-ascii?Q?MKoBmdq87TtubRFx/whgxev22L3fuTnTYJrF8pEqFkMVHHIWIUeVV1lv8ebq?=
 =?us-ascii?Q?KzWES8RShyhOF7Cxq26MUadxMkHKTGShiiMBF2LLlUzJAuKqarlbUJUO/Jq7?=
 =?us-ascii?Q?dlyv4Aj4d9xjEN53FmTLcKh58N1Yal3GBpFfc+FeBcb9Rt5faQaAnkDzBHWh?=
 =?us-ascii?Q?oNd3daI7f1s4wWOwAOcqT5lAZzvcztR9Vrvyp9uAvO8ZiX7H5Wm1MYesf2pX?=
 =?us-ascii?Q?Rv989Iqx7NfS4Vtw7XpSy3afPY2JU8ZGvBMdVj8fPkGBPl+ow9igukb4p6A1?=
 =?us-ascii?Q?QnuRbdt9nNNQo80GXgihi4iPNBATidzTxMd21/g6dOMHZlItk7zIfffe3Yzh?=
 =?us-ascii?Q?ixWGC4HbhFihp87g/YzsiYv/0ihJyC8CMEhmPYnEqf4WEBSYzOHrxzzNMuGW?=
 =?us-ascii?Q?/d8xTDQgGMAoNl0OjEip1ovFo3mvC42XhOBAHrpwlR6/3oGK6i0rqvjvMqJc?=
 =?us-ascii?Q?a5jQ8gkmWb1QCJQlVxzTPpMZ78pKS0/SmDemG1/v/jp0Ez0H+EElvH5cqsX/?=
 =?us-ascii?Q?KDQcEsZZXxfcDG1yMZFwu1N1wasIcNcux1xc6rCpE1WatZNcC50GTHPuGysa?=
 =?us-ascii?Q?38m423bg2mI0tv0+dw3mWCrcV54ai5G4Kn43+xddq6Dr5BUQRGprqGtnCZJa?=
 =?us-ascii?Q?5tK6wAfVqqP9NS5fwszFt5pPwj5f/oEvstVi5qitJnERnqcWykzUecBEdbzd?=
 =?us-ascii?Q?OtHOZzDPw+BnKp7iczPGzPGm318fZvj5vfvj4Z1vrhrGOvsijSygD60xR2ph?=
 =?us-ascii?Q?TUNmtpr8Esl/7dURDnI+sEo0pyQEWss0aybnsJg2P1WUGB4uDhsCePKHMsUE?=
 =?us-ascii?Q?9YHucIHwANkm/F9LIJLP3nMFOYnw1+3ZrouvPwZV6kxK9StcLObpuJha3x+o?=
 =?us-ascii?Q?+2gq3fest5mtUGwaxFZDFehYcwjzCO4QvA+j/Pp69BBbELe0h24nO4CbgGND?=
 =?us-ascii?Q?HdH70Lo4yDSgaCxgfPrpMSbyrrsOAtNVMgjMRyFMMYXi5dCnKmtbNj0yFpcf?=
 =?us-ascii?Q?9F+gTG5WLfyPtIHe3Brm4OcAOkZraT/eSyBieyIjG9DDJ6DliR+w2oBqmq6S?=
 =?us-ascii?Q?ToPECj/YOC1hRQkw09anLUBs7/8Zc6ZifP8wWFjU6xXzNI2ck48rf6LXXBwy?=
 =?us-ascii?Q?3lQk5bdQHDXoxSlqKrS+bFSp5zkUX8VxwXOgVd0cAQFeYZeTKEzuJEuq2ijW?=
 =?us-ascii?Q?zktlVEfPf3BwpoDOoo/zh26igNiHTOnSvFeIFMchWvjTlOcBDYQJu29qRKQR?=
 =?us-ascii?Q?AiLPEiYLcS2QvkbzuibYHcES+8KwCUbLMPWZy9aYxwOGTMkuuSEJUCJA0WWD?=
 =?us-ascii?Q?ZnprCvyuKBv2iLxWljI7fxlXiDEPaNj/D0pCWDRVuf+BSQ3Rysxd6mja4UWA?=
 =?us-ascii?Q?XEW4RKIgbuRdfFZQkRs+zbI6q8TOoJbM26L0kOZ4Lruw1RJregJU/fBGMt5m?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667176f-01c7-4359-4e50-08dd500b89c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 11:01:04.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfrqNEv3uLH6//WEA+likZKwTc5kAq+lW/h+WRQK4fZhYvRRVNlCdx0JgS3EfBwG0d/pwewBAuQz2aDhHzU1BLq9xOKrvsVz2IgfMoZf+Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
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

Hi Pablo,

> -----Original Message-----
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Monday, January 13, 2025 6:10 PM
> Cc: dev@dpdk.org; gakhil@marvell.com; Ji, Kai <kai.ji@intel.com>; De Lara
> Guarch, Pablo <pablo.de.lara.guarch@intel.com>; Dooley, Brian
> <brian.dooley@intel.com>
> Subject: [PATCH v3 2/2] app/test: add SM4 GCM tests
>=20
> Added SM4-GCM tests for the AESNI MB PMD.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>
> ---
>  app/test/test_cryptodev.c                   | 158 +++++
>  app/test/test_cryptodev_aead_test_vectors.h | 708
> ++++++++++++++++++++
>  2 files changed, 866 insertions(+)
>=20

Just one comment below.

Thanks,
Pablo
...

> b/app/test/test_cryptodev_aead_test_vectors.h
> index 73bfb8dad4..aacefe5ea4 100644
> --- a/app/test/test_cryptodev_aead_test_vectors.h
> +++ b/app/test/test_cryptodev_aead_test_vectors.h
> @@ -50,6 +50,54 @@ static uint8_t ccm_aad_test_2[22] =3D {
>  		0xA5, 0xB8, 0xFC, 0xBA, 0x00, 0x00
>  };
>=20
> +static uint8_t sm4_gcm_aad_test_2[MAX_AAD_LENGTH] =3D {
> +		0x3f, 0x89, 0x42, 0x20
> +};

MAX_AAD_LENGTH is pretty much 64KB. This is allocating too much memory unne=
cessarily, so I would limit to the actual size .
You could use [] with no defined size, and that should work.
> +

...


