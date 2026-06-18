Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899ACD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 10:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CCF040296;
	Thu, 18 Jun 2026 12:14:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC3A40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 12:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781777646; x=1813313646;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2Om3KsQnqdrJDdbMOa9rbYFDSoXdI0J2/ojkBtxdodg=;
 b=DHCZy2oxGLTZmm9TFHzzSYhSPiLQw4cQHu8Plu5wvFKc94J3F1roaaKJ
 Yuc+y0I291qSXpvu3nk6Ma4HhFAfZ/P9kHoIWVV7y06d6cedkN1NAkF9l
 n93cjTbtEYotrBjcekBPsUC047vwRpZUk80A5wMOF5WEYa65QDwsMWCNK
 N2dni8Qfs7dKBnFcitLCtxgJdLl/wel+o3QWvGvpBdp6fRtsqBALyzT4S
 tfsaIuRDPA5EPpv8TxRGRq70hs20z1vurZtrMnliQKG9ri0DAbsmc8RSw
 +Zmlds6vMQ4gr9vPxVi1jllede7oIKc8QwzxHjQgjZtXXcNx1jnwGIH6I Q==;
X-CSE-ConnectionGUID: k64/xBq2R/qgagXz0qhYww==
X-CSE-MsgGUID: U8m+2UO4SduVipGU4aQAxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="108153784"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="108153784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:13:47 -0700
X-CSE-ConnectionGUID: AQN+g3m/QuSy5Ps82NkgTg==
X-CSE-MsgGUID: +u0hBtWpT5COXxQDD5h7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="243968178"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 03:13:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:13:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 03:13:46 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k38MhLeRK7qqqdvXZXPAXLVjQKIbAd+XSXcYQbOA0HQzuBk8uX1orn3Ss8PJ3m/Nt9cJvbIdVK2nWThrTqmxK8VFyK+fNI9o28XuKoNVj3MFzbcNsBDXWjVxo5eCkFWhPJV2Ap9eWjh/mP/jhsIeHMC7gIvBIX04AWAEtKyisYgy01WFJ/lhtonz5C5gaWD4PBZhNxV1JM8ek9vhu7vZE3kPT2b7kY6U+Zyh+trcjfiJXXUV5gMsSVUJ8nNFjIzb8wrZpp0vcLUsrIwBGhdCGQMCmGDNHAbeeUWat1nXNQtf/E09osCz3mxVt5YW8BULcKVQ4dzuQVaGZCXL43wKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Om3KsQnqdrJDdbMOa9rbYFDSoXdI0J2/ojkBtxdodg=;
 b=VA2fWXFuyQYfWxp7LD1q1/ue6oe1nZPDxpndCWf62FF5CL6yjq77BHLty+OloknPj9jjyEll02z6HxoM8rB965jkVOWgK3L73LFsNzh7h3OvP5a1DU0P1tn1wGslMuU48wq7liyGL6dPTiyhXmlkUdHdO8M24lXZGhUEENH5GFi9kk3hlEksVCkaV13JNJ2fOlUkB9EeznvXyhrB5uurx7+jvzVb5iPGoLoI7OYw/eoIAlrJcjtgpczoPc0my7mzpgEwguc8aZXVS2FSn+xr8I9u26E5Sf/eUi9hDj5VIBKbNIB/BQOvrvYlDaHdnECj7cYKQbLPtAi55xcR9LUPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10)
 by CHAPR11MB9656.namprd11.prod.outlook.com (2603:10b6:610:2fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:13:39 +0000
Received: from BL1PR11MB5527.namprd11.prod.outlook.com
 ([fe80::a41b:abbc:18a1:fb78]) by BL1PR11MB5527.namprd11.prod.outlook.com
 ([fe80::a41b:abbc:18a1:fb78%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 10:13:39 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "paul.elliott@arm.com" <paul.elliott@arm.com>,
 "Shebu.VargheseKuriakose@arm.com" <Shebu.VargheseKuriakose@arm.com>,
 "Kantecki, Tomasz" <tomasz.kantecki@intel.com>, "Islam.Ragimov@arm.com"
 <Islam.Ragimov@arm.com>, "Gowtham.SureshKumar@arm.com"
 <Gowtham.SureshKumar@arm.com>, "Finn, Emma" <emma.finn@intel.com>, "Cornu,
 Marcel D" <marcel.d.cornu@intel.com>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>,
 "Jonathan.Wright@arm.com" <Jonathan.Wright@arm.com>, "Dhruv.Tripathi@arm.com"
 <Dhruv.Tripathi@arm.com>, "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, Thomas Monjalon <thomas@monjalon.net>, "Fan
 Zhang" <fanzhang.oss@gmail.com>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi drivers
Thread-Topic: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi
 drivers
Thread-Index: AQHc8ztClDbfRj4tlkW8qJnfB2w7hbZEL5sw
Date: Thu, 18 Jun 2026 10:13:39 +0000
Message-ID: <BL1PR11MB552766F74EA3CD53AA04AFBF84E32@BL1PR11MB5527.namprd11.prod.outlook.com>
References: <20260603092736.664428-1-radu.nicolau@intel.com>
In-Reply-To: <20260603092736.664428-1-radu.nicolau@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5527:EE_|CHAPR11MB9656:EE_
x-ms-office365-filtering-correlation-id: 991de646-b55f-437b-16a1-08decd22447a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Yp3bEcByu2qeV0FCkb79zA+9v8FUoatSXswHq/wq8iR5fGAihBJgg1FLyEzw9aZA0rOuuAGZz9+Sstj7w2QPVVaXknrXi2F9UUG+ySYGFyXUunZCjREoxDcbbBM+ITqjTCe5Wrhk1JG4i8hl4LOeaYKjwkSJQFCv6vsmirDJd5yRbrE/mwzIdQCsy9AiH7VtrOSuumGrD0JgLYzyz5nfu58E2V6ylJiENDFWBdGLXq7qB0DXXt0wgUQgPerP2WXrRLNL31dA+fs/I8hGkOBeVnucrtSqygzFaI3F/Sbx5TjUwio+Cxo2CduxR+vmXMiLvrL5y0OhLtSH5mV6+n5TDVoBhqIQNo8eHPvPeAZT3YndM2pd3a2ObSgezNXfGn6TjG09JREX4NWrBfQWsAO9qdGqpUZKH62p/mG1tsR4TGXE5b/gKbZQkoks92JRaOLClAU4bToGToKscwOXu7pWBZFEn8uLkOITJ8IqZwJsaEIH7JBtn6DFNmN2Ttsh6u2HUCGDjuQRwSujk8PM3tF2alWASyNQln8Mof39N4VxhXwtVDJtiDqrghMPhnTR5q+bplYJuUgbQ6jSCu8XKj2kPqQjIQV5fWx7oo2JABieBfioRiX3UYO1fHw1a6Zh6Dn0ckDq/AMClF//m4jPNQe55NqKj+PFACV99/T37+mlAf80YAN51we2JzTAkEQmJdVbhSp2qka4Ffmiz/qN118njdvJzfZMVFTKc0S4DqVxhIVbagqQuBKNTpdrI1/cOES5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2JB8BJVNLC0pHCq/5cDnSBS6jhlUYd3xuDk4uAwF2o2D0OA/d8Z29VD0yL2?=
 =?us-ascii?Q?A86lIhLjfJqYnLWUV3UV9K0+sj4mw4s2rL6QV7KP2v3L/N/uLdRDybtS7hTV?=
 =?us-ascii?Q?eNbXfTFFzqTXB5Wg/DUK00A0HO/9OgP1HFlNFaIQCyKsg/ShCz5+Wvt2ZYQP?=
 =?us-ascii?Q?QMoZxKoZGvU7PN3Rur4GZlXb9UnTMtRsjGayx0zQuyfgsypHIhnFHJFOjDOF?=
 =?us-ascii?Q?BBdm7J3ozVGpgrzMqZxp84uWm/oJkm35T3+6YD7m+kyzDlC7vF4oiMGcvAIR?=
 =?us-ascii?Q?pjjOKEfv/R5usAebrvyRYZYdfdXN8lb7O0iLyYhz+B3UTJa4GYREwJW/zVdT?=
 =?us-ascii?Q?z28S5CWef3u91oZoSmvARBpxoomaImC+fZqOPw8h0t5DV6No1ZPeShGRv3tp?=
 =?us-ascii?Q?pVOY0cxgovx0zwoYCvgMEDNFqFKKz/6u+14PwQjv0Z6ozAEc+qYPMAj4iYXX?=
 =?us-ascii?Q?QSjXKsprqzoKHssS86W/i+ui8R7N8eIWd6E9/Q7pCFXXivxpXDlEWr+qqFZA?=
 =?us-ascii?Q?NpMnywi+1s0KwDwNXqehiDe4pZFjMZYuaxH3GVFuZO80J54M1hfrcTZM+HT7?=
 =?us-ascii?Q?PoxvWfcR/Xk7iVoZP00v3nmkVZFU2RTKTXviBfyK/GnzgPlCibHDaqmDDXsZ?=
 =?us-ascii?Q?eQfWR7KbG3ZCqhNju8WncwUioNfM+jWXxHjmcicw3rQpafXmkA+Bdi3yGge7?=
 =?us-ascii?Q?ttDOSkyqLhHWAkS4OcdQwRNRCSxABdyvKCv+7nkKGwuqzEJmBMt66VL1CJ5z?=
 =?us-ascii?Q?X8drXYNPawM5mLLruj1Xh8iviQ8mZW58IIdg9uDPCg9mBytytVX2r3rnCY+B?=
 =?us-ascii?Q?NXL7WyZXCXBpQ2sWr+JSbTu36iRwcqkvRPK1PdG3yXmTrBFI4zVK1saAy5j5?=
 =?us-ascii?Q?ToWCkqWgiGQXoeAw2dITpq1lXcv0uazvDGCXrVnCDVXncn7G0T1/sVLFo4J3?=
 =?us-ascii?Q?0pi+G44jk2bKL0/knOIEKY8MWlj+eWdjIJlF9ry4CVOM0vfrsTG4dZrl+3b7?=
 =?us-ascii?Q?/66F52q0867Yrf0vOaMiuO4GDV8LwI1VyUfgmeGaZNSx6V5SaNkcmhCFjoRh?=
 =?us-ascii?Q?w+vDUs/ZmyQ47O5C4jYh2Lbkz8KDiHmUrfj3DdH3kzCaXeBtbP3OuzVh16Ct?=
 =?us-ascii?Q?ncriir6S7J8DO2za+WUPW+IfbVfXLW6bzPOmuBufgOzba2XeF7FC/eYRNURx?=
 =?us-ascii?Q?QDHOgS/VBOwMBZDpe5+lA4aM+rpyAbyQ8JK/VOP+5jlHhg3D3sj6oYOiUhgg?=
 =?us-ascii?Q?vt7JmVmzEmA8ANAlhZUZszmtnMyzCyIwoDd+ToskINpHf7XyL9joOoBbgYMf?=
 =?us-ascii?Q?sb6Wa8W6v9ou9coDEnmD75dPdsunYQ9xxkfjdkfxkXlXEbWtaWbsmd2Fszcn?=
 =?us-ascii?Q?2Z3oY71kR567sNSU4jvbxlTGDeJ2/QO1JmBzfVtTmBRggKBseFqpgnPu/A18?=
 =?us-ascii?Q?9uqNfmTchfzgJcF2VsOaqxJayUm2CzUcEZ9c3GDlsrf9UOTVdwSTqfII10sS?=
 =?us-ascii?Q?t7qD5bOqaJVWJmCLYMMh13UJ/caQuYmYlft6BnUyeawEtT5Gb+NHXRFK6aW6?=
 =?us-ascii?Q?aExxJB4pCRIIuHxoOCZgQmoohmyiWaAe6UGf2j3GDAgpEKp2MFYxpImPmvSy?=
 =?us-ascii?Q?1JTy5vpbex39X8pMBceQo5Njl0+T3YZrNjJ7/KuCoHWDKkZfgEhty/ODwCbu?=
 =?us-ascii?Q?4FWtZfQNVlGuDakrNSR0KaEbh+Q0PdmeuodofoL4j4HDoQCAXFufIRk1eGzr?=
 =?us-ascii?Q?kNsnYXO+nDj65YDREjtRj9dk6SfSuhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bhtDCMNQeRyjQPvddrndiUMidh2+Q2JoqLEPt8up7Tqe1wLHVZGSFfQAloWGLeIuo3ZkE0W60Dsr7CRk0hEIXl+ITbSdfC1rwdWFnEh8/I337baIamlE0Av27H3lcRgRXrzUoL8PPIcXTxDnqGsfocomrYIg8vI1YUOo9NgKX95NI1BmOie0Fg8cwUsnkFM7vU1FVAjXDScyMCdPfBvG3UuA4LUil5IdxfXmuetoBMMID2nJduUo8552xOx5/PUIPARMpI74eJaykfCIBR+mbCsDvvcB5h1HoFS+PIOcscJiFia5QrUPIQbWsihf/Qn0HD/TnAYjhZpVh9mL2UEaVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991de646-b55f-437b-16a1-08decd22447a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 10:13:39.4015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcnzclpq514Uvaz1ONgGUYuTnQOB/3BElM2/l/dHgxzvXmqxNAwmcODGX8CotcdtRF1lUG9X8qqxbow86oejO9iJn8jpoKlP6QZkUsfViog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9656
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
> From: Nicolau, Radu <radu.nicolau@intel.com>
> Sent: Wednesday, June 3, 2026 10:28 AM
> To: dev@dpdk.org
> Cc: paul.elliott@arm.com; Shebu.VargheseKuriakose@arm.com; Kantecki,
> Tomasz <tomasz.kantecki@intel.com>; Islam.Ragimov@arm.com;
> Gowtham.SureshKumar@arm.com; Finn, Emma <emma.finn@intel.com>;
> Cornu, Marcel D <marcel.d.cornu@intel.com>; gakhil@marvell.com;
> Mcnamara, John <john.mcnamara@intel.com>; Jonathan.Wright@arm.com;
> Dhruv.Tripathi@arm.com; wathsala.vithanage@arm.com; Nicolau, Radu
> <radu.nicolau@intel.com>; Thomas Monjalon <thomas@monjalon.net>;
> Fan Zhang <fanzhang.oss@gmail.com>; Ji, Kai <kai.ji@intel.com>; De Lara
> Guarch, Pablo <pablo.de.lara.guarch@intel.com>
> Subject: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi
> drivers
>=20
> The Chacha20-poly1305 and KASUMI drivers were just wrappers around
> the main AESNI_MB driver, hence redundant and removed.
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
