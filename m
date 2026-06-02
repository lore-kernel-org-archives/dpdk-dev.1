Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD7CD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15A640649;
	Tue,  2 Jun 2026 14:10:18 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013014.outbound.protection.outlook.com
 [52.101.83.14]) by mails.dpdk.org (Postfix) with ESMTP id 93C07402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 14:10:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecAFLbgYlpv8eNVReHx4C0KVKlVs6UiiWTHdKzsjpOl47YtEitLx3DBRUw/jhQrkLQB7kYbkdyPQKtCL930iakaO/TTi3vl5avPoeNAbhyYINFq0YuvoO8w8WtD/lPSyUtpca6dG84j6gC5t5P0J7mrgRzLbXE60WioWLqIQ1kQQGjo2dOZoF6YnlZ/65SnBORFjDYe4AmCV14RQLRKJAdZeoSud5vmToxCnn86/YKCeb7+UzEYgR5dcUuCQ2FUst6/4Tk4v7ZqseS54tSNOA6GWv1bFDmjd18AmqeoMHfYOGWAeOdUuT+BOUZat7LaYYVCKszjVEcFXiIu+05eapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+iNJLTS8L5CVURndZv+Hnr3qBjjrXljkTA5xjtuCZU=;
 b=Q3ieOKJat6+v3Vgl5NZ4Q1/vmq/fcmV1DfoxsXr/GJ804M+3OJjAS0n4isPfELmzdqEZKpMGECrR/Gs3pB8ejELkzmQWkX0fq3AcWkIdDuSdKRGsJnb6oAjLK0+blMoKWK8ETwANEQ10WpBACfIRHaeMHWyZ3WKfFAElueDy4CYojChPNyowTeT1Z0+LR1r/n5vKauikmh35oCgL7pfvm0uaCLr/y+onQHK5/qk3+Usa0PVOqRl+9lKzj/M3YE5Ht0ccsg4glvw8p3SZz9+lBC73hyPlTKJKKSapPrz3HZgcFhhbyi1DdjB+iEKBRezjiAm661jnA1LtDYgGzw7kPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+iNJLTS8L5CVURndZv+Hnr3qBjjrXljkTA5xjtuCZU=;
 b=VQWm0whLTrjgArhvVHhxp8sd1wFgSvFAio/wYNn3tuIntclqiofhOao/ZUrQjEVsQSt09F84rOaeFkcNYp9UL2fpyC3/ELHqm2cZa83Ak4bcW50FeBdqFMnoF53g4fMkLY4mYp2qcHKbm05yewYEvOfhrotr5/FYiIeBKPxrbtgXG4mXjcHRuWMfG77k3Ec5nRvvlxwovmfz85aBnWIGxDV39pjBoUrEa+RxQE4YrTWZbip5mFNMKpqM0spMNQlslFT2jJeiLHXag1pH4A4dVVf4/qCoeoqymq4HwkwcGk5iLx3C3aIt1xBZETDAC2cD82iLP+6ODMWqS8kyN3qAXQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU2PR04MB8949.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 2 Jun
 2026 12:10:15 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 12:10:15 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, Kai Ji
 <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "nd@arm.com" <nd@arm.com>,
 "paul.elliott@arm.com" <paul.elliott@arm.com>, "dhruv.tripathi@arm.com"
 <dhruv.tripathi@arm.com>, "shebu.vargheseKuriakose@arm.com"
 <shebu.vargheseKuriakose@arm.com>
Subject: RE: [PATCH 2/2] doc: update Arm IPsec-MB references for cryptodev PMDs
Thread-Topic: [PATCH 2/2] doc: update Arm IPsec-MB references for cryptodev
 PMDs
Thread-Index: AQHc7663TACGJGRG3ESQ+3vY4Jcq9bYrMhug
Date: Tue, 2 Jun 2026 12:10:15 +0000
Message-ID: <GV1PR04MB10750CE13488F24DFE283DBB589122@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
 <20260529210404.1986896-1-wathsala.vithanage@arm.com>
In-Reply-To: <20260529210404.1986896-1-wathsala.vithanage@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DU2PR04MB8949:EE_
x-ms-office365-filtering-correlation-id: ee367474-1cb1-440e-bbac-08dec09fe7c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|10070799003|38070700021|4143699003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: ZkkGOpDlRymi0L8Qc/sI5dkashsGzmgWtIkqlMqHs+JkAEJOGcquSyWVpfsuTqO+4t1SPzA0tPb9nxrL0WrXh5isqipaC7+ZAJtQybt9IdXmh19HZnEOdbZJghtgOUNICZQkYGr7p/FLq4Zd3KewvvPsrqjXgOpE6/dnGRdpgZ/hezI5ltIr7hj8EpWJjsrCTvS1OCLTj5uAWV6dea6c12+15BUswMaIs3TggGisGm4vLEyeglmEitWZpYPvSIme5WVs/gkEnSFfQyIDiSij7p0+IK/EDzj/qs7Zahqu5W1UR+B7reJml5mVKlWNEXgVHAk93a/S+eHAAusbASKGvHmDnpOyoWZIJEryqngcqaFQCbfgjEhPUKpvhvZM2NbF9K9lWVigjFj/XT0o229fuhYUw7fboPcwdTeQ3lKzjYrTevOaQu+u330HjqIbaXu7MMiL1uWTa4tLTo59kFLW87TgV1ni5WSNeMOBovRQESgGpjiEbelaQO5yAlyu1xtrrmfFUDqtaODwCY61TQHc95S8yUExxGkcuHOjBxuVQCjtUrMUgO0bxvO91goak93woeYRGgM3DK5a2uQs7uI6bG3rDBQhjQ4VCy9dljeKxT4rhDQecJWH75PMFTLlQbq/eO/+ny8w28OAHy1FFfN+8WKfOXj/VPkhwcKB/3gdCchLx2zaMD960HtUw878Kn4ce+tQ5VejPhW9d9IEuS5G/Pf2GYJCu4Z3/7OTlRrRSXgTnTxaDoVah5v+sJCBBytu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(10070799003)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fj8o3p8MDFiIU2GjsVypIIHXRZ+lnVJC4GEqLJRkiwmMKi+5y8cLbPqfbs61?=
 =?us-ascii?Q?Pup7lYzLUR47FfkJq1c5NlyLEBNTB6mddJy1mMgOJqHK5TVR71UNROqHjh/F?=
 =?us-ascii?Q?8A4tkKylB1fcY/2aamZSO7zvsk17H6YswQyfikqoji7o6bymHnvag/869oy4?=
 =?us-ascii?Q?RfxCRjH39QO3Ad6mPcDfHKPS7GBI4ocoWSyNpSh45ECw4R1Nj+BlDkVbhnfx?=
 =?us-ascii?Q?X4ebngSbwzBdvhGJcCaS2pkUGCeY6z4tbmAcp/Td2F4nqSUhtbOYoy83JG6Z?=
 =?us-ascii?Q?9qc6+RzYZ48KDLUxdVxsBQ5R/vmUDxODXFVpfcQDzdT1I0Um2yaT+OpSMVy0?=
 =?us-ascii?Q?HjPkE7zUUTEXkwd7JH1AGkUm7MUXj6n6LnUYqCrfqs25hTIBd4UcvXNWnYTS?=
 =?us-ascii?Q?PHDoawkLJ1EhbIHuCYBmcYzEkoNQJ0sF5kK/JNEbskhC8xyT0FY+5/30ohhS?=
 =?us-ascii?Q?Pw80Q/UwIWbszHspPBYeF0Q801fvyKZPjvHXeWOkWW7RiNspeLRWYyWvFpVU?=
 =?us-ascii?Q?BLxoEUYrGai/tZqq9745eDpsOkHWRX2i/PT6e/KxCGi/Ff23LSZmoEt13UTn?=
 =?us-ascii?Q?i9N395p5nzRKfsPSpwpez8pU/PCqqi4+GmCDp0acffFyOlmi3FRkvgvwpVW+?=
 =?us-ascii?Q?P1NQ1ezRzcLzrhXYp2bkHoyWBYHrcAYAYrAA22Pv/eHi5uPAHPGwIUFAVGMi?=
 =?us-ascii?Q?4hq98KNMZZt6jSnutgy/qZwqJs3VQMZFf8ESW5yS8DsIlDiAHPKGvRgZq6+p?=
 =?us-ascii?Q?JpquL2PUV29w8+avLCpk4LCWcLtsb9ih/z66WSMP3XfOAy5vaaq1vhDnmFAP?=
 =?us-ascii?Q?Fmz+8jZbODQ/3bPVCBYSKoc9I986+OMPzuI67H/InWykfUG+Oiz+cRxS6Utc?=
 =?us-ascii?Q?C032FySQ5XOJMIPe7b3wIAEZRPOmuHY1tkb8fxvbc74a9qK9j4KYQbHk7323?=
 =?us-ascii?Q?ogVSOgMHTe7Y5Ft0SRsLprg5xOT2oLrABJNXKgonm/8h5w30Npf0UYOepFZh?=
 =?us-ascii?Q?nLgFOHs6JhOcrroi/TIh3mQNAQO4g8FmtWhwV30wXHbddDUNRKb5leCIyMCi?=
 =?us-ascii?Q?At64FwsGRd/Jn8M2VRY/hxhZyLZHh8g98gfTZLV9cjyvRP/EZpg3H4ujl1/O?=
 =?us-ascii?Q?GWmxA8MlcopwJLk2s6mPfbHRo17fvzbT+Bib2jRoMGfenqik7OtaWOhi5gww?=
 =?us-ascii?Q?lQyOorYTEzKRQBiVASpf2nbjBSBurZBrohk7UGNPEGDtNHEyQZJbZusVbolN?=
 =?us-ascii?Q?1GelyFF+AaYq4ZPp2tjIOyXLOFAs75v0eEhKSPWUUlU50u5QnV/LOUmCW+gp?=
 =?us-ascii?Q?T9LKE8SkTm/+nnDrDVxl5ycKoMsLTenFx3MrZYT+0DXdwOjUX1COuZbX4Beb?=
 =?us-ascii?Q?FDsi4/vwPU/EWBQhPXNXad/R1zfQPGiao/vGRMd0wCDJU2RlOTks47b3Anh3?=
 =?us-ascii?Q?z0EKXU8ESA/ZTXJSOIt0Cj0ub5F/HGSLAvo+lZ5b5ddOICqGOeWMvDS+NtyM?=
 =?us-ascii?Q?JBJcumHOTBjSOVbBA9metCChyRVIuVxSF62Of9rmUnzQTXxpoVPec2aV74vW?=
 =?us-ascii?Q?mcBZ9gwh0FzCNTXieT2gxXX942gxxt46IGNpWKhOK4d2gNbsfnZIctsTQZvK?=
 =?us-ascii?Q?ExRXTaakIZcxYV9af21adhcA69LFdtyIxjiPa25PSodN00+3mHHzZ/ZBOTlG?=
 =?us-ascii?Q?q4+ACN6+luOQZaq0M7EbQxToy8lUZJzPTUHWqjoSSAqR016uwbKw+wdF72pK?=
 =?us-ascii?Q?GVHhkm0eGEfNvRL5t8UgmjGNRTgtkCy7MLgtQQCrSBrdfSWQhlPpQVK9GpwL?=
x-ms-exchange-antispam-messagedata-1: fnT+YV0eOG08SA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee367474-1cb1-440e-bbac-08dec09fe7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:10:15.4010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUQJPRbRBRdajbV5+DWoaRjpilzPgHO/aRy6gH4QiJTEG5JH0G3jWYQu7tFqe/GGNPzsAamzFNjjEasRnPYOxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8949
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
> From: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Sent: 30 May 2026 02:34
> To: Kai Ji <kai.ji@intel.com>; Pablo de Lara <pablo.de.lara.guarch@intel.=
com>
> Cc: dev@dpdk.org; nd@arm.com; paul.elliott@arm.com;
> dhruv.tripathi@arm.com; shebu.vargheseKuriakose@arm.com; Wathsala
> Vithanage <wathsala.vithanage@arm.com>
> Subject: [PATCH 2/2] doc: update Arm IPsec-MB references for cryptodev
> PMDs
>=20
> Document Arm/ARM64 IPsec-MB source and supported tag level for
> aesni_mb, aesni_gcm, snow3g, and zuc cryptodev guides.
>=20
> - Add Arm library reference to aesni_mb and aesni_gcm docs.
> - Update snow3g and zuc IPsec-MB library tag to SECLIB-IPSEC-2026.05.30.
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> ---
>  doc/guides/cryptodevs/aesni_gcm.rst | 4 ++++
> doc/guides/cryptodevs/aesni_mb.rst  | 4 ++++
>  doc/guides/cryptodevs/snow3g.rst    | 2 +-
>  doc/guides/cryptodevs/zuc.rst       | 2 +-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>=20
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
