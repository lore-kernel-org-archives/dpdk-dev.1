Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA07606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=Xg7fxqj0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425B440151;
	Wed, 28 Oct 2026 06:52:55 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 45976400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 06:52:53 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4SRYB3773315; Tue, 27 Oct 2026 22:52:51 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023096.outbound.protection.outlook.com
 [40.93.196.96])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hk1a3tjc3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 22:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcLYi6bFMtZDIyrPzr3zx3YtsbkoPh/9ZmgFdQ4afvzHUzs2Qi/yYoiyzIFUmvYIjGyQT0EY6VYZT0xT2e0b95WU2q76A0qIx4oJe23gX+wmykQz3UQ6FvIhI4j0DPnmqFJ/xeWmUIM/cV/hL7LIbKwjZGUPybrfn2QmBjCw+1+8/vTqMBzaDROKMGlMj6kdg0DJ+emWblCHag1dj/9Lsal5GbHGEewluBFCU/+bLGowrE9MI0bvI0wPlEe8yEFniipBtNwHjaEs1rbD6W/19t1PaA4Ua/n/YDkkMGYIfN6gLHG0+rx7F9/txgw6nD95XHkLE6NCOu6gLeUpga10CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r18p8h2eA0xWiqw+HB5aIAvRkgAfk+L3BatlF8JRkAQ=;
 b=enn34PXDUbxa/AayyX3o6LYyh/ErEs0veW+zfeVPB8gwwqPvlVRJ8rWf7oFnCbT49q/QujIvUk0lKTHznwwOzH3P9zi+LUhOPefzD38zDXMsFB931VA+KNq1v78GUaAAplm0gnXC4qPmJ+cFHMwJvZVYcTmI9ceDvQ+mNLL4PDlmYlk+ZSM0+CSlpSPGYhzcyYCP4ZwP2NgVH6QIRCeP/c3sgLyo33DAV2hivSQpzETOyC037+SwIGETEL3C5DHYBK1tsLcVNsAiooJEYM2Syte6aF0uMs8Sq2eVyNBoYDQO0iYg9hgV3b2R9rcwIOAWDCaln7l4wj14HNRYDmeCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r18p8h2eA0xWiqw+HB5aIAvRkgAfk+L3BatlF8JRkAQ=;
 b=Xg7fxqj0wp3CFUY12ZXYoRHXZTbzadV6kbW7E0LUDtI9Rgp8AU4rjkXycLOsD2e2TI5/IVTvX/mBLTz1Xe2CksYC4dScCXMlPuuULa7JgClB4am7C1axccLTMLX2J3QNRL9/bn4vYMo6jAYC5lOiaCHL539C4BxAzrchoFxcgGk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB5945.namprd18.prod.outlook.com (2603:10b6:806:3dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:52:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 05:52:49 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Kai Ji <kai.ji@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v9] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v9] examples: add Wycheproof validation app
Thread-Index: AQHdWym4WqXwH4HdDE6NjdOvbAbueLcQNaaQgAJUoIA=
Date: Wed, 28 Oct 2026 05:52:48 +0000
Message-ID: <CO6PR18MB44841E09B136CE2AFDCFD3F7D86F2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261013152059.3255355-1-kai.ji@intel.com>
 <20261013154400.3273585-1-kai.ji@intel.com>
 <CO6PR18MB448470D91AEF1146E3EE6E5CD8612@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB448470D91AEF1146E3EE6E5CD8612@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB5945:EE_
x-ms-office365-filtering-correlation-id: 3517dcbf-234f-459a-6dc8-08df34b7b2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026140227099003|38070700021|11063799006|5023799004|261022113327099003|4143699003|56012099006|261009223027099003|261022075727099003|261021123027099003|10067099003|261022105027099003|261021121427099003|261026121527099003|22082099003|18002099003;
x-microsoft-antispam-message-info: srJ8O84iZiMBE+ZGjPKXbjeZ/DGz+zevwkP2WSgTFvFFXnM13mYV9YsK0qJzwadkBMnnbETaBEKOTpa93J2ZQtLgKHJaUzjmgyV4MFevQyymmEJgpXdF2pRU3AvWj6PXhSfW453OucIAkU/wlk/DocVrBfJpVzIFbu0WLINZ/ypu+4zkN8YIOBmoHHhB1p20RmFY85fTiUdZ0WMZRNjoYHfuciwIPbwQzzupb7qN53oQk9qUhbJFrCdDmI8yOz2saGf/AdhtO+oLi8siuDj60GqXjkixtQR0XXvDrC2DDotUFjHc9XFmjjkrhIrBYviBTW78asv4cwTHkGYsoGu2e4JH6SbjPf2/eV8VG5Fv6ENPTIX1vU7gMK1Sd108gsAx9B4YgsZ9e52NZqyuwVW01dU24yDfk2kb8SCNAMF1Psh+lIadtq9rdaBb8DqEI4Ps3GPceeR++DxwY6x8zPZkOsY77AtiqbsMbodXqOrUIZ4cBqjJ7+7RBqvGbJ96gOJ3CsD41HN8jk3KeCImvg+rnvJ/nVII3H2dpxl0vzqShs9uvZFRPtj3tWtuZNUpYbK9BfGwpZ54rR2tzyLunM/S0WUMBa0VFKlRntpptl+SU1GACD5DeL//N7hN3Ahjih+C/YzM8KeMlHVIeZ8f1ACad58WTSeoP3uqAhUdnR8Yoys9hKAgnWOkFFmD6SIwMAerpZL+ctlQkN97kz664E4QHMKY2G3PIR5MrqeFmIswsL8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026140227099003)(38070700021)(11063799006)(5023799004)(261022113327099003)(4143699003)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jB6uVhy90UszFV+kA4EIpOJoTf4kOXhImj6QmqsVszBz5jUoxZ4D29ynl4XB?=
 =?us-ascii?Q?hP/hA/fCGvXbMWTcZPVnlM/zK1UhnpC5mLvdo6zRzGoPhGfFWZlG//FM2zm7?=
 =?us-ascii?Q?zbs5WZRliMGD2mCQ2Gel0BM2HMi6+LroIW7Yon4xiGAWd5qo0PRpF3l9Dsdy?=
 =?us-ascii?Q?UfilM/BlbXmqM0B/r6ngEJQL7BH3n3XPr/o9FLyrkO1IszBdkaor4e0d/N7I?=
 =?us-ascii?Q?ILYEawh0O2K7OTlG5Z8u3HtrMMosWZnKEXZeDcO7TXH1ksnwqA+r5WiA4z2l?=
 =?us-ascii?Q?h6rTJRiqaJOmjzseuWsHziTAQ8mK9fJNw/vJsobyGVJ53cM5gOW48iiJWXb9?=
 =?us-ascii?Q?tD+I+n2xS7zcuKWE8yr3RATGgWspEGpGd0ypQGKT3MxNjDgDGrVg6c7NBDAO?=
 =?us-ascii?Q?JhcR9+uSY69zKJ2FyvdVB9oDQ9z+6gWO2ARLloHK39XTVggtzCqwjeSEvBbY?=
 =?us-ascii?Q?7FwSS6qogB/qzmV/UlEOuI6OYEl1VZjOXEmXsIZVLoIL7aitUFdsFne8X3ft?=
 =?us-ascii?Q?/lRPyNsYTg9Kbttgk8ceJt0P3qv6YBvi8DSrydHCf4BHgPbnR8HqutMND6lO?=
 =?us-ascii?Q?PhIY6bhgNMdSn91MPmwflHxa+bPxO3njHHKyTDcP/JiGX5S1uJgrxYPvn5Yr?=
 =?us-ascii?Q?oCuekDzrVJgUesP3/vwt5Bzv7D8OTNl/H9H7fjb/MN/1Ho3Iyo5gRFUvBXs1?=
 =?us-ascii?Q?5AWszps4Spn9v9wOaLdZfTCF459BI2RSVAise44Eh9DuacCR/d4N7ndrV7zL?=
 =?us-ascii?Q?1jS38ERGl7F441vcHtphroG4ACVR9suKupZLNZBYF6sYW6QUT2WSET5ZaA9t?=
 =?us-ascii?Q?zucjy6cRWxNA7VSDKWDIVC6HZI3urlyZYTVYeCTcj+YIbOPjgRDl8Eod8sm1?=
 =?us-ascii?Q?6kIhq+q32L4fDL/zcnp08m7fJjBqMFqPlYVLJJccGbE0jZDD7i5QL9ekZeak?=
 =?us-ascii?Q?0H1tcC9lzfoyqftLzSkCuWDyNeWKNH3r3uz1VCQTgHdk7+MIIw33aGIqfJi9?=
 =?us-ascii?Q?UBEQWGZleHekFGjkaNteUNSIKZiiKL9Wz8iUp5O5M6NxoyxHxzSgLVOE2cbU?=
 =?us-ascii?Q?W7RQhmUd51L/L86hIwoxK6FwClLaIsVYPk3lDCe26saw+Qf7obV1aJkWeYBW?=
 =?us-ascii?Q?11bRmsl30a1ss6SnBg+Prgh+X/g1RiEgHwCIhxJxmpPxQaVLR8Zghoa/aIon?=
 =?us-ascii?Q?r/l8r17zanC2hhTiwQcGejX0AOS8OmVgiOtHykLteVkwg1l33hXtADRZItqY?=
 =?us-ascii?Q?sHL1vglhmQkWtewk9VexEQZi7F5I36QuX9JLAjWALIo9FhClaonQtHqg0Qde?=
 =?us-ascii?Q?vlDFGSHarw+WKx2buWWHN4J+0kSOh1W42a6fbQW772RVDea8yt2MWR3F/1Ki?=
 =?us-ascii?Q?PR84FtBElVRoVB8hLG9oHdyrk9SonXj/DU/mNQq2nlTc2Lx5B0LKL8nmqbox?=
 =?us-ascii?Q?Fr439cgRIHNFF6wldggp9f6rxn79wRQO9hDI8mG//HP/QeKClOt+oZqT7Agm?=
 =?us-ascii?Q?UxUICNZmIG6nMms2cBDaviYELRiscOu0J+noxB76D3J874b1m/NbO0JktxzI?=
 =?us-ascii?Q?ilFHVQmmAL+cd7I2Ek7dWVRcKXFz9yzP5YERuAxbAhAWTDmKH7i7LGQ5Q6PB?=
 =?us-ascii?Q?MEJctNpA69UeA37fgPYzjG5Bn3de7Cp6Awe2CnEbSMXQoGX8zlZluS1RDJZH?=
 =?us-ascii?Q?du804I/ianQgNZk2K+HBa0lKh5RzlLcEc3uqEs53gbhLMiWl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lT+J7tTLhRb8YCh950V/9jVnaFU/M4a8y6+8djZcMXatVYNcFQ2wAxI+J0rX7PG/Efg8pm3j6KGUzgO9B2xq2RRtiN5p+ejvoTGTuKHp/lFADiPy9+QaZUHcshWWow72bV6NJ4t4uoFxK3CO77vRDz1OLBQbuzsG7I21ljENZKrv3ChGVsqpkoqcUFSe3fjFQJ1RCUDELD8SbCJDbs4+HPrk+2ETLLR775pNty9gn+hLEULm8e3+19+SeSQvx6XjfnDYsuJI2ET9zOql8eFMHsVMCPdbSYMsYMCDz3nAWaI0CfLUHlhLeBxiuXJ1qz7nb0wawAS4nrQpJuAnB38Zfg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517dcbf-234f-459a-6dc8-08df34b7b2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 05:52:49.0485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oek9AdmyiQWVLCiztlI8Ya54j4p8Rwk1rYlpU57AKOZn8CPYnJbc3bLyB2aKPzhCHW9ULhMtcxjg3petKysf9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5945
X-Authority-Analysis: v=2.4 cv=cLh1IVeN c=1 sm=1 tr=0 ts=6ae18db3 cx=c_pps
 a=cck1Y2tAR+80KxojUOV8qg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=xbAY7EYUdzIf_tcvUjEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nBHw5xS4Csz8VWV3rIdENio0jA5SzA10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMiBTYWx0ZWRfX4t/O1ashZbdP
 sMgnjKB8Z0P8tyRNp704lbdUBr/J6b4/WeQR4pZ4NqyqVUmbUCse7kL7OwaN4oP7TB5W/AnTPY0
 2GVjcoSgWWlTxSPsypuLrs797kR+HIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMiBTYWx0ZWRfX05iR2veEoYIM
 nfB/FrR6n6rh+2kR7JpymNTUcN43vCrCxgAd3nghK8OTEQRYxdCQnWPFkZXbYZDjAoQ3xTvz+z7
 EzNcIw+KgiH/nxH/OcEz99xE61wOPlkolFWFn+q1IJBCXGTgo7gggcqRocenrZ9yEpicZVPCTUh
 s6m9Y1m2sLWAuW1RelwbbYuhdHkaSJkEprO/gKsPXjE92mUgDdDvX6/T3Y/fMIw8iEJZmjs4eMR
 v2Vy8OLMt89DZyC2FhgC2eTQxKkPoRJNRPRoXktafeanJf5EBq7GWNz6mNnin/V44huzhSCxAxt
 5XOSEKo2Pw3EXjDqVaV1nlhV/+TP2V1ZVPdsoxiEy2aKg6qK2tUMeNfCTRSoMYylHFTZvlIg67p
 +QM8fn38J/5J2ye7ovKP8JzQy2yDMLwkyd8OIHeJo6zvP0wdOL9Whf15wdopgAPD/pqyMIA5B7p
 qxQq9QcxloNcdL5VpNw==
X-Proofpoint-ORIG-GUID: nBHw5xS4Csz8VWV3rIdENio0jA5SzA10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > Add a Wycheproof JSON vector validation example for cryptodev PMDs.
> >
> > Create examples/crypto_validation for the validation applications.
> > Move the existing examples/fips_validation application into that
> > directory alongside Wycheproof.
> >
> > Support these algorithms when advertised by the selected PMD:
> > - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305
> > - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3
> > - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),
> >   ECDH (ecpoint shared-secret compute)
> >
> > Validate valid vectors against generated ciphertexts, tags, plaintexts,
> > digests, shared secrets, or signature verification, and require the
> > expected rejection for invalid vectors. Digest inputs for DSA and ECDSA
> > use the symmetric auth path, selecting a separate symmetric-capable
> > device when the target device is asymmetric-only.
> >
> > Skip parameter combinations outside PMD capability ranges and identify
> > recognized vector families without a compatible DPDK transform. A
> > --debug option lists every failed or skipped vector.
> >
> > Add Meson and standalone build integration, with usage documentation.
> >
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > ---
> >  MAINTAINERS                                   |    7 +-
> >  doc/guides/rel_notes/release_26_11.rst        |    6 +
> >  doc/guides/sample_app_ug/index.rst            |    1 +
> >  .../sample_app_ug/wycheproof_validation.rst   |   51 +
> >  .../fips_validation/Makefile                  |    0
> >  .../fips_validation/fips_dev_self_test.c      |    0
> >  .../fips_validation/fips_dev_self_test.h      |    0
> >  .../fips_validation/fips_validation.c         |    0
> >  .../fips_validation/fips_validation.h         |    0
> >  .../fips_validation/fips_validation_aes.c     |    0
> >  .../fips_validation/fips_validation_ccm.c     |    0
> >  .../fips_validation/fips_validation_cmac.c    |    0
> >  .../fips_validation/fips_validation_ecdsa.c   |    0
> >  .../fips_validation/fips_validation_eddsa.c   |    0
> >  .../fips_validation/fips_validation_gcm.c     |    0
> >  .../fips_validation/fips_validation_hmac.c    |    0
> >  .../fips_validation/fips_validation_rsa.c     |    0
> >  .../fips_validation/fips_validation_sha.c     |    0
> >  .../fips_validation/fips_validation_tdes.c    |    0
> >  .../fips_validation/fips_validation_xts.c     |    0
> >  .../fips_validation/main.c                    |    0
> >  .../fips_validation/meson.build               |    0
> >  .../wycheproof_validation/Makefile            |   40 +
> >  .../wycheproof_validation/main.c              | 2097 +++++++++++++++++
> >  .../wycheproof_validation/meson.build         |   18 +
> >  examples/meson.build                          |    3 +-
> >  26 files changed, 2221 insertions(+), 2 deletions(-)
> >  create mode 100644 doc/guides/sample_app_ug/wycheproof_validation.rst
> >  rename examples/{ =3D> crypto_validation}/fips_validation/Makefile (10=
0%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_dev_sel=
f_test.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_dev_sel=
f_test.h
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion.h
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion_aes.c
> > (100%)
> >  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_ccm.c
> > (100%)
> >  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_cmac.c
> > (100%)
> >  rename examples/{ =3D>
> > crypto_validation}/fips_validation/fips_validation_ecdsa.c (100%)
> >  rename examples/{ =3D>
> > crypto_validation}/fips_validation/fips_validation_eddsa.c (100%)
> >  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_gcm.c
> > (100%)
> >  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_hmac.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion_rsa.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion_sha.c
> > (100%)
> >  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_tdes.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validat=
ion_xts.c
> > (100%)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/main.c (100%=
)
> >  rename examples/{ =3D> crypto_validation}/fips_validation/meson.build =
(100%)
> >  create mode 100644
> > examples/crypto_validation/wycheproof_validation/Makefile
> >  create mode 100644
> examples/crypto_validation/wycheproof_validation/main.c
> >  create mode 100644
> > examples/crypto_validation/wycheproof_validation/meson.build
>=20
> Can we split this patch into 2 patches or more patches.
> - one to move fips. Rename fips_validation.rst to crypto_validation.rst a=
nd update
> it to have fips as one section
> - others to add new app(logical split if possible). Add another section i=
n
> crypto_validation.rst for Wycheproof.
>=20
> Check multi_process.rst for reference.
>=20
Hi Kai,
As per the last DPDK call, Thomas suggested to move this app and the fips a=
lso to apps/ folder
And update documentation accordingly.
