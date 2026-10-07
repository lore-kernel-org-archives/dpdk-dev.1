Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D65CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 09:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE1140698;
	Wed,  7 Oct 2026 11:51:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 605934027E
 for <dev@dpdk.org>; Wed,  7 Oct 2026 11:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791366702; x=1822902702;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=KrATuF51AlnIbeU/YCDpTRJ5lqwzoNSHDxSTsaWie/4=;
 b=OzEHVo5M6iKX6l7YUj7d9QREp/Be3LfaM+pHC+l97e3PnpFnO3i2QYtV
 JiNVydKWDtQK/ZKWh+gwF5HW6+ykJaxK8OFgGeQ3MOEU+idyI3fZT+YYL
 raoOXqRvXGZOahSg1QmJLuTPB2lEUtL8r+zOBVt9oc0sbevX5S6r3Uyot
 1OCO7Fxv8VDXu84+7Jf8R/9trXvmk5ZPqxxNRFgkj2TLikjKPXVvfjadE
 8QGuyHRt+iZebcYPUFwA1NdGjVMK2/LViR1CiPz/a7qMqpvhzl+XYLQw9
 gkP7lZ+NaB9+RIwx8IpxTBkNXYachk/CjUtbnQ6lY4i9UgoKwGJDAdsXg A==;
X-CSE-ConnectionGUID: VIsxdM3uROGlQ6ZFi4cqNQ==
X-CSE-MsgGUID: Zj9c6y9RS6CfK/BE78lfmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="7418"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208,217";a="7418"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:51:40 -0700
X-CSE-ConnectionGUID: YvhFbBa4RhqCR+VY/ohSZg==
X-CSE-MsgGUID: LxHhK2xySFikIdMVN/d+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
 d="scan'208,217";a="277524502"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:51:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:51:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 02:51:39 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrwY07Kx2TMkXENdirhpBx3vGhaHAF9GJLYgNTeP4uVGqS69Oet3dmsw3eX+NuMrPno6vMgnR35IOjiVzg1J1jev04bKlV5XpupEwGNFcQnQJZS2n9r+hht2RAzLM5rT+s7EeOEafWmyXPYKE95A6iv/s673d97t4A3m2/By0ph3oEkmtxqaWE5PLUfx+1Qq16+JUskwOD6M6wZDWTjCq2uag9HwgBqOMy3m31ZRs+a4dG8lDYytQEWnaYS7OBR0B9ZSfOE/IiXWJbemkZoQLjrxiWUnrKekld5z6b24KkgcvDKVPi4fd6CSKceeQ65J7EnmnVx3N99VwRoDFZUTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXctdOCs1TjeVlB87cRd0J/TEYObnd+Y/gH1w8yfz9I=;
 b=EvCcxfdPV6aDun11Q2zvHEDCk2PaGtwVRqPnwrRxZc4KuMK8sImAVhH/IUaTn8gteEmpI2RB/uUeRkZAwZKI6IAW+XdW0+vvbNYHrz2g+8jgxcQuWUxqUkQgoobGc3jQwlVVZUwnDy0XpAEWFHuZO7Skp5vjDBnvLVV2qAXA/O+mr6CT3d5OdRmvymMwRdLco+QqLm2u3g7KR/sTktt1S/s+7susBwyoNM2rehWNwCq30d59ZWZF/pLfYgyC9TRLSxYlb/Z6rKQWWETErYp6Lisj+2XgBJwB9HRPbXDITRsdeXQrUcLUyGfIcUOcsGLrCNNcrzbx2HvwQY2/5PHsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 7 Oct
 2026 09:51:35 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 09:51:34 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: Re: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases
Thread-Topic: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases
Thread-Index: AQHdVYEnEOojwpZuoEOkV0NTJA5bQbbx17r5
Date: Wed, 7 Oct 2026 09:51:34 +0000
Message-ID: <LV2PR11MB60456B879250E8B44296FFD281942@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261006105424.1630315-1-radu.nicolau@intel.com>
In-Reply-To: <20261006105424.1630315-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|MW4PR11MB6569:EE_
x-ms-office365-filtering-correlation-id: 5c2c2aba-b4a7-4559-b33d-08df245892d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|366016|1800799024|376014|56012099006|11063799006|10067099003|8096899003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: JCTz8ckI2PUv3hoPCjQHMp1m+qutVAPYxIhzJqf45jNlgS468Si7yCuj5Kzi9wMfgMqPG2yWSIH4VUuLLU4qolKG80wFByjdWLx1fc2itnPjc6+0RQ08v2gkfCwu4zTKv/RrxBGAeN4QxFZQg3x0PFEwFeBJr0eFDp+U6HpHnCS4GaLGIvoTajkpJvTQDeBk7ynEx+ubnRv8+4dn6txtagaHakxX6ZJuikaWscDzfWNN29VRcPPPiLbVAsyqpXJx3/2IlSaMAM/WPki6cSjAIHfsrnFHaZEyPN+dhUE7IcmUtZYEuUKaZwXprD0EUr1cVozj7b0jFWNKuN2vAzCblK73GU8fh8kIivaltnFVOTzopH1K5qwLMQdTd936pDLzmikez1JThpkodpZrNGgM+9AjVZGtuWdqjyOJxraBobPFfWmsW9fh8tOarztU6+hVtrel+9gGYYAhqzGByPP76UpaKBJsyzEYnBHlfZpBYem5VWT66mUJbNcw3U+u/RdxNDrp6skSUJw+T4VpVeh0ntGT8GqqjliZ80/x3W53MFSkulwfNJKdb0casfoh5iWQQ30FDwyB1+CGttfnXQcV3keCLtbsKW4hbGppNiiYtsX8B2Ho+OiSQ1uh26XONtgTltEUc9nB55fj94LxHlaccI35FFeXwOk8ZPvEPuv64m03bpms81TlpGrnYazJ65NGX7dCo+D3cWyd+RzQVst8V8HsKY5ePTb5KYRErJZgdVE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(366016)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(8096899003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FN9Qp2xaRPpADgeHdedBBhRvTojY6RMKLae6C4sHaRMz8OcXt0npMcSBaj?=
 =?iso-8859-1?Q?dXq7A25491veNPqT4onhjP4dQmIgix7sujRn5cCNWLLJ5Vel6VjL49++SU?=
 =?iso-8859-1?Q?ogOyrGU/oHihcFX666sUJ09xbQ1IhkuJzmIijg3ADdSNpiGl4nledpohbB?=
 =?iso-8859-1?Q?qqpEryA9PzJ6zxN1j2/+vyEkbmzOrPJfJo0ejP5mPFzttpyVfVsyYRjN/5?=
 =?iso-8859-1?Q?l5oEtp7KcvXqj4mBfdFmzUCxana/6tLccZmPZZRoyEy8t8ZxkfO3adROzj?=
 =?iso-8859-1?Q?OcZBXa6XOHz5T3EVDDz53JIQnLl0LmoTS30DvULf3yE9RyYkAaAy7CZ+d0?=
 =?iso-8859-1?Q?N1X4bwsCZqwJYnbY00/CYp/dl1m4j7wy1OHO63uk6IdOTvzKS/gwQO2C52?=
 =?iso-8859-1?Q?uyZ92BLiZZo2w50QzrAcMibUHfVLrXJIhHfI/ZKC82DFw1c5LNyHSsQ1Hn?=
 =?iso-8859-1?Q?5Z9PP3XVOPOw3Bwzqd2cx3jV7oLYULwN2783x1s2RCljh/K8Ntxe6Hd9R3?=
 =?iso-8859-1?Q?PiYLSRDQmhgo7Df3Lh3gmmLt5c1VvPWfukF5JPpEZqe1UU1wUiBICQm2j7?=
 =?iso-8859-1?Q?wXPVbofhRHPUwsAPBmuk15viAcURUhyIfCzCDO7yyPSLmFXbMup1ZDXL/h?=
 =?iso-8859-1?Q?nELJaTFu1iSVkgqJ5ptqF7bStOyPIzkcJg8IZIVR+je8BhV+/DRHQg3KPp?=
 =?iso-8859-1?Q?AlOeNpShxWZStLoouXhczjLvZrpCE1uJu78BQUfW/Ne9Azq9vri5Kbevbk?=
 =?iso-8859-1?Q?InWyoePedGkZVpCJ/OkNqSk3dDVyztazdDx/bFwRNkHpoyP/+8FBFZ5dX8?=
 =?iso-8859-1?Q?e1OJsLpIGHBGxB00NNhQ1A//OyzPyIitedYn45jC4fL0QmcI7jwFrdvLBR?=
 =?iso-8859-1?Q?dsT3RK0gDPTqPRsH7ABxveMTYYkLRbGXqCjHorKVYOukUcZAnqAMMfp421?=
 =?iso-8859-1?Q?ZH+T6+Z8ATw/vF/lbOYVF/AZRCgIq59M0WRUsIoZcikPDkkeiAuHCtIjBL?=
 =?iso-8859-1?Q?o3vTOSSZB1zBivP4d7OvD4yr8etarfLuVbYdcaZ95WTsDzC9H6fqYZ/m4b?=
 =?iso-8859-1?Q?YD4n2wzOiG+xgCxdOKrlYHH78ZMVElAQtTeTzJvpSCE5GixKWwcZ+Q/qwF?=
 =?iso-8859-1?Q?9jZSqESvDVCxL1EEPM5xGC2B+CDic73Z+0BzQ1zPJ1AWoc5/83DM0UIm1Q?=
 =?iso-8859-1?Q?HIHiZXryrCtiz9Gf5V3BisRMpZCZZQAYrRLGUlKfZwYIcPZ+8A5Kc/WDHu?=
 =?iso-8859-1?Q?ZL4I7dcaGEWMJNAr/kdjbxtcLAaeeUKmiypSTfFtVjmN1tM8lZsKoPGLgQ?=
 =?iso-8859-1?Q?xXAVExiV6ddPg7QqzU4rNz3RQlU73TpMUUPulxZbj0ouKWWd7syOAqC557?=
 =?iso-8859-1?Q?4VId37zinDWejljyARTYGlDGFRNI3/94ehAUJp6Jf6uWwtqtuBDHlhNTvM?=
 =?iso-8859-1?Q?oWXU2oNlebl94yMtDNircOENTOCdIxTdBYf7ovZuqEB+EpQa+xtjq7PvNa?=
 =?iso-8859-1?Q?5KPg9ZjvZmatgKXcKpbbWhTmlZyG0LmCrj9RzkkLu6F2dY4RCWmPQkSPtp?=
 =?iso-8859-1?Q?gOZ6wYYGuVsEUTLZOBWUh6T3RcuAmDC5+vMWmt8fv2U5Lhuf9e0UoGGtxs?=
 =?iso-8859-1?Q?Kdf9SR8jbDgb2ikU+/5KmXT651WOnyGFzBxL8z+1jThK8hVksXl0R2DV3c?=
 =?iso-8859-1?Q?Rrlwm0z0k83EQne2qjCa4yWrOchlYuHDedPqHXtgxPS87PNVSRCSs8/9gd?=
 =?iso-8859-1?Q?CtdZN8gniBnT1/1Fhv2DoWjIz7MD9r+1jEBhb6iycEAbFw?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB60456B879250E8B44296FFD281942LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o7xe+IvuCRYteWDp9tLSh4RrIXXpAnMX7Q+Ey5mHjDSIqKEuVjrz1Dfby09geb6KiORQOLvqJkA3iNqz1A7plD6D4aPdwog/BbN1dn/i4z4RrtzpTrs2r/GAx7KdGfExJX7IYVFGUKCDKhUN66Iz/+i9TcD9ncr+j/ozLsQ+UYCtmhp0/L6210YA2F5OKGs1j2Fpv+jPGGciObULAcD4EJjh4oywaqJ9eSW5n5Vrfec9GElxUW+jfEGJad1Dtsskhf+jxb08red2qK1MqCE/58E+Ptx3Gqit4eIHF1kda5lm2z5AQWOPiltgfi816pnGofcun31ZVx4oFLgEl1NHag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c2aba-b4a7-4559-b33d-08df245892d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 09:51:34.8510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZnWpo23XWwqnXXWzgDvFSlrHDBr6TSPociW64nAEr7kOwE5lzd6KkI3ZvSR3o9E19SZ0QwDhQddv/H35YuHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
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

--_000_LV2PR11MB60456B879250E8B44296FFD281942LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Radu Nicolau <radu.nicolau@intel.com>
Sent: Tuesday, October 06, 2026 11:54
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Akhil Goyal <gakhil@marvell.com=
>; Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases

Extend the blockchiper test suite with
NULL cipher and NULL auth OOP SGL test cases.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev_aes_test_vectors.h | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/app/test/test_cryptodev_aes_test_vectors.h b/app/test/test_cry=
ptodev_aes_test_vectors.h
index 505e603b7e..60a270a3ce 100644
--- a/app/test/test_cryptodev_aes_test_vectors.h
+++ b/app/test/test_cryptodev_aes_test_vectors.h
@@ -4598,6 +4598,24 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {
                 .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
                 .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,
         },
+       {
+               .test_descr =3D "NULL-CIPHER-NULL-AUTH encrypt & gen x8byte=
 - OOP SGL",
+               .test_data =3D &null_test_data_chain_x8_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+       },
+       {
+               .test_descr =3D "NULL-AUTH-NULL-CIPHER verify & decrypt x8b=
yte - OOP SGL",
+               .test_data =3D &null_test_data_chain_x8_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+       },
         {
                 .test_descr =3D "NULL-CIPHER-NULL-AUTH encrypt & gen x4byt=
e",
                 .test_data =3D &null_test_data_chain_x4_multiple,
@@ -4620,6 +4638,24 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {
                 .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
                 .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,
         },
+       {
+               .test_descr =3D "NULL-CIPHER-NULL-AUTH encrypt & gen x4byte=
 - OOP SGL",
+               .test_data =3D &null_test_data_chain_x4_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+       },
+       {
+               .test_descr =3D "NULL-AUTH-NULL-CIPHER verify & decrypt x4b=
yte - OOP SGL",
+               .test_data =3D &null_test_data_chain_x4_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+       },
         {
                 .test_descr =3D "NULL-CIPHER-NULL-AUTH encrypt & gen x1byt=
e",
                 .test_data =3D &null_test_data_chain_x1_multiple,
@@ -4642,6 +4678,25 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {
                 .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
                 .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,
         },
+       {
+               .test_descr =3D "NULL-CIPHER-NULL-AUTH encrypt & gen x1byte=
 - OOP SGL",
+               .test_data =3D &null_test_data_chain_x1_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+       },
+       {
+               .test_descr =3D "NULL-AUTH-NULL-CIPHER verify & decrypt x1b=
yte - OOP SGL",
+               .test_data =3D &null_test_data_chain_x1_multiple,
+               .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,
+               .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |
+                               BLOCKCIPHER_TEST_FEATURE_SG,
+               .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,
+               .sgl_segs =3D 3,
+
+       },
 };

 static const struct blockcipher_test_case aes_cipheronly_test_cases[] =3D =
{
--
2.52.0


--_000_LV2PR11MB60456B879250E8B44296FFD281942LV2PR11MB6045namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b> Tuesday, October 06, 2026 11:54<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Akhil Goyal &lt;ga=
khil@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] test/crypto: Add NULL OOP SGL test cases </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Extend the blockchiper test suite with<br>
NULL cipher and NULL auth OOP SGL test cases.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;app/test/test_cryptodev_aes_test_vectors.h | 55 +++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 55 insertions(+)<br>
<br>
diff --git a/app/test/test_cryptodev_aes_test_vectors.h b/app/test/test_cry=
ptodev_aes_test_vectors.h<br>
index 505e603b7e..60a270a3ce 100644<br>
--- a/app/test/test_cryptodev_aes_test_vectors.h<br>
+++ b/app/test/test_cryptodev_aes_test_vectors.h<br>
@@ -4598,6 +4598,24 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-CIPHER-NULL-AUTH encrypt &amp; gen x8=
byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x8_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-AUTH-NULL-CIPHER verify &amp; decrypt=
 x8byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x8_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .test_descr =3D &quot;NULL-CIPHER-NULL-AUTH encrypt &=
amp; gen x4byte&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x4_multiple,=
<br>
@@ -4620,6 +4638,24 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-CIPHER-NULL-AUTH encrypt &amp; gen x4=
byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x4_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-AUTH-NULL-CIPHER verify &amp; decrypt=
 x4byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x4_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .test_descr =3D &quot;NULL-CIPHER-NULL-AUTH encrypt &=
amp; gen x1byte&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x1_multiple,=
<br>
@@ -4642,6 +4678,25 @@ static const struct blockcipher_test_case aes_chain_=
test_cases[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-CIPHER-NULL-AUTH encrypt &amp; gen x1=
byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x1_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_ENC_AUTH_GEN,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_descr =3D &quot;NULL-AUTH-NULL-CIPHER verify &amp; decrypt=
 x1byte - OOP SGL&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .test_data =3D &amp;null_test_data_chain_x1_multiple,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op_mask =3D BLOCKCIPHER_TEST_OP_AUTH_VERIFY_DEC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .feature_mask =3D BLOCKCIPHER_TEST_FEATURE_OOP |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCKCIPHER_TEST_FEATURE_SG,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_flag =3D RTE_CRYPTODEV_FF_OOP_SGL_IN_SGL_OUT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sgl_segs =3D 3,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct blockcipher_test_case aes_cipheronly_test_cases[]=
 =3D {<br>
--<br>
2.52.0<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB60456B879250E8B44296FFD281942LV2PR11MB6045namp_--
