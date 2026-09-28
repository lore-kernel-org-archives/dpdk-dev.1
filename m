Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC16C9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54BAD4028C;
	Mon, 28 Sep 2026 11:22:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8151640041;
 Mon, 28 Sep 2026 11:22:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9JjAT2339426; Mon, 28 Sep 2026 02:21:59 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022087.outbound.protection.outlook.com [52.101.53.87])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gy2a6jmjn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 02:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKA+4CczdEPyF9kv11KYP6L8UHwTbAmt4wuTqoaAnS5T7BcybkVVxtsyxy3maGJXRvacBiHbs4vPxsOoGsbCkv8mjpnbZroEg+5wkD0PVq3p/4fbDOO9jA+jYb1oNNigdKpVZsYRTmke12H7sc9GpwFk3eRkmBOsaoRK1q0/9GeZBaO2E95m2QDQiEpd8ZZwuTOwMwKrvDCXNOAPm8nlM0D7lY6qYrsvECyWBBsjGd9KTm/dxv2FApW/CXeJCEjNgNoqwkJaROILqWkwYNNGAvEXRiqNTHGnQA00ixP4f8Of1zA6yImMWDks78OvENQlfhg4+X2hleurdmnSNkdJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UAtuQ4O9Cnh+yKBLoqzfz/VtAShU1tge4JkSBTqOjo=;
 b=QLLrG+oOEX/HKB8MXwjFTTk1lyqyW7fyIqSc3j6hGvEgRD8cVNgnTWNGItGVYfRzW9ZOl5FaaiyZKVbWjTZL6oZdNRaABI0uKOPVpN/HlVdxkA9giXIxSSy6a489I3HDqdN8YAUlUxyrh+XNEJY0QyDqYd/ajNjCwYfdJ1zeYcMhVnKXdfchV680Rbd7AYWKz+Bmv28jz/P67HCzYlJ5L8Aj5UHsVQzMmTRkXVx+dwr5AQQCtdG7O/iZKXiHbUpt2KaGP1CaJ493QH3M4sP3BQTl/Pm3Wr4AagXXqv1/iXjuAiQl1BeeicccatLdEiTncwGf9IGd5v+gzU4p7XYRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UAtuQ4O9Cnh+yKBLoqzfz/VtAShU1tge4JkSBTqOjo=;
 b=jLV7qdHe/9TB+r6PeuGDb9h1k64rNa2CJMgKBWxu3XzRYJ+E60srAJXir+k87JHnrLFHbLeyFf2BNCPlDB/iCwvZ7tmY45teBLYlEAJ3FUOPwhpdjNgB7f31y7Sxshl3Bxzrluj8fd2C5ZXVx/1dLzqgyP6pec5kxox7mJhhO2U=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB4574.namprd18.prod.outlook.com (2603:10b6:510:ac::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 09:21:25 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:21:25 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding support
Thread-Topic: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding
 support
Thread-Index: AQHdTwbf5QPqz1VSiUi2vVGYg9bGZbbjtl8Q
Date: Mon, 28 Sep 2026 09:21:25 +0000
Message-ID: <CO6PR18MB4484629FDC6B984AFC24D7F8D88D2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
In-Reply-To: <20260928050412.276760-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: techboard@dpdk.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB4574:EE_
x-ms-office365-filtering-correlation-id: 5e7466e7-e782-44cc-2f4a-08df1d41deca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|38070700021|3023799007|4143699003|10067099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: HQ84NmmlhI0xSYUl0y2phEznAgNWW+dofM3xkOcR1ebvPbawgONFD1iPq78cYCmMfEa1mnGuWs5KUSnEdnnuROxalkQlUbE4Gjo913sbThn9388wiMMJbYbjCnS/cTx8bsOGkixGZaQlYPRYtwH3ScM878bblFLBP7X5J6X6r1I5f5a+dvWA6vnA1bcGZnYua/txjSW0yI0inaw1xMV4nfl5FFOWR4krFNnqdtjBuUAqN/kvpstRoXtGTxU9RlHcI8BePCOphp+Pm9seiLwb16XzQxxntE+Yk7H81W0DGLXLZ+inhjLTR+T+QkVNuugCfTHZxcr7PuChxkL6tCVyHDiGT40Y3wKC+znKA9xr18ET0JimLG5yUQpwACSPR1Pj5X9MxzKNJglXVWxgynqq3JcT5rNrEaCT36YFCuebnM/kcNK1FGlp1MaJPDr0OQ3lAmgohLt0V/aZgLPz3qWjLKUgyFZwrhhWfBJAsShxApcvmuPN5o8k/rXdUZSt63DbRpSzgh9hp8hHKqDcL44Swnp8quaEnIdwS5antnT7srSW8OLeRZOjq+84OvmyATRnmqS3jU6c4vjxHUfKRXyRj9DbQBsoZy19oI/v52uvZ/3qOAs7HNeHz+GIbJ8ooK4kkbr68A3zXF8Ton6FCipBZmYfAncr9OrMLMkH7yliEFk5sH7f2UevOHG1BMO22uNRtz5de77JstO5yKmS3beqv0FTpJpuhLcORyi+YAxH4Js=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(38070700021)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3YjQZGFf/M1y3L7orLn+2HfTZDATvtp9QGr5P0fHM2VVe+YVQ1rBvaiNm0qj?=
 =?us-ascii?Q?uYrkAqaGyAW8SW97aXe/Np8iIs7qnWHgbpmvb+NBaYFlE5EZCEOuGy7n7hKZ?=
 =?us-ascii?Q?7jokOTFXT2Qc/SwDgITzKBITsXF6YH7Uqg3awt6CR3uw22XQmE3vOXUEO9fK?=
 =?us-ascii?Q?AZzKAzwUjQK80dSRuep+yKZYfAUBTTG6WMaHUG3yEihT5r18XSqhbTsWAeHH?=
 =?us-ascii?Q?AojQsWPr9fHAh7tGEurrlnCg742rJIqTxNnwy0NNMmVoS9CjFCC5G/uoTjl4?=
 =?us-ascii?Q?A1BCmvNftEHrK+7JipN0UbysySfyanOU9/7EzmiH0AflEAOnB0KYqDMtM6wh?=
 =?us-ascii?Q?6VjnkA4A2wBdAg7tkNNwfBxdggmlnTTQmihNNumwrMdWIfK/JZk6wSkVo+z+?=
 =?us-ascii?Q?l7WhVZREkz1tERaS5np8UaPwyuJr2vyBQTkRY4xG8rXcqIVP3KvbRtvTpYin?=
 =?us-ascii?Q?bhjxXk7ySOhUjyMi0ghLaPVxADGJl6QZ+ulShmm+zdi278HEdUQ9UyLQQgD+?=
 =?us-ascii?Q?8zm4+IgBR1mpTVgSBrQ7EoAfgbb7DEHQRujDqPnVU9axJnu/KLFdDVkOSq//?=
 =?us-ascii?Q?ftee9id2uqpHCadqP5Ve87Boio2ZnQH1bVyoB4DeeQTKy4ya9CxhC6zcqPvg?=
 =?us-ascii?Q?PKAQjzhwKGwex+RJGrCncT3JohLEuta+M68ZKyVPQTGG3E9mIO7wjRnc+sUo?=
 =?us-ascii?Q?smTCHBvNsZqP5eXqqAoxRRJ2K6Sj0B4TSDKXrXP2ggDminyC6Ad1i+bQ09u1?=
 =?us-ascii?Q?rJn4shXnZvte34lriAb7VbdAsDfY9+7zu4n5wxdtb5mtugaHSGglDCEeCDz/?=
 =?us-ascii?Q?t6foOps7Yj/Mj/BW6eBG6WrM1Of1H81IeK8AzV3eP1lC6eMWVhhF0X00NHHf?=
 =?us-ascii?Q?B6qPgo1wM1jTrobzF/v3y8nZSMZNWVYNnhq8y6DH/PXgWCZi/D2Ssch1BSIp?=
 =?us-ascii?Q?jc6Y6541A/dTptNi3JtjGkGOrADh6dQ3XWZY/B6FR8wVYVkNkN5C3bSrn2kb?=
 =?us-ascii?Q?AahLk/S9fAGTEGoHbKDjPM70gQ6L4dXtJceXwzMpxgPqxWnt5u5qVieCRFFz?=
 =?us-ascii?Q?jiJj09+MYyTnUulRwf6VbotpkEo+Fn1CB36Cf3wgabkUQtCIxT6Xws5VZz/2?=
 =?us-ascii?Q?zZw6JUvIPfIsyvEqPCN4tZ0o/w+yIb2pnI+jyauXag4dCpmRubDf2NbQufpZ?=
 =?us-ascii?Q?/yJXwewxmC9LJJ2QNkSf3A9kNgiU9471WLJIFTAzFEN9c2joRmRKo86r7sjf?=
 =?us-ascii?Q?x0p2IMcBZivMOZr1728FMLtAOz0f6VruQDKzHlGMzQfFsTtoXGWnZTS1YgdO?=
 =?us-ascii?Q?ThSw/7URuXYCGOFR6c9kNP9Yne2LFiHqxrxt9Mk9Pb7FFMiGLQcGUQgqTd7X?=
 =?us-ascii?Q?UL/Q74/5jugVNM1ZzI4J1HwwyHcAKmIGKJJPZsCy85KUjcUD6V6qgHvpYXpG?=
 =?us-ascii?Q?j0K1558R9cEgnswU8/QatwJnoWnOhZADc7HdupFnko8vBTcK4PMslTwfuPn5?=
 =?us-ascii?Q?1vc4yoXbH/q0F63YiYyMKceD4mYebqgLKlDjs+o4sCH2ARtIukR8dLib11EQ?=
 =?us-ascii?Q?ZTU0sHPC2yg4KDhaEZVsdhKLGJxyllxbEblJbj04YZCuW31FJs0IOTQKbjWF?=
 =?us-ascii?Q?ZMrufZfENrGvg/BQ3D1k2rax7P2g1yH9NzMW4dG4m82rwwdZA2ORCqravQ97?=
 =?us-ascii?Q?vrUK1hfbQQ0EPglrd1Ngmgup2chXupobFy5wwhXb3LtLgL2a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DEiOoVCLVkcpTFF3emywCrL+3BjRD1ohPoMWItwq2P2yg0p8yZgMs5vUg3F2ZyeL3VV5pE1+pKe/Uwk4NZMi43hwI9fAUgEAXdjZKkMMcXxb/cj1zGk2q+SVWwIvlGrTa8mIBXmMBDSpjXIYPMDuvMYVEvN1n2Ll4+roTQh0qCoYmfDK2RvERGLbU0WOsWi7IqA1pjj8pftY9tPQ7ql8wlzDO6oxDgzB78XMQ8Es5GwvqhlThNuFqNHZ4fDNs1+Zs7gNAkCmPNxgE9YKg7B9HdBS/xkkTtGska0PbDzN6WtCC2FbmEPJwNpvI3Y9KekNl+G6y3E/1+nuba6+zKl4mg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7466e7-e782-44cc-2f4a-08df1d41deca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:21:25.7445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1/crvxqBPn7Nx5evzqxAffEMrUlvzHUAM10add8+uNmMUggvJIygSDu2UbwYEBvCP6KFpIyhm//vu9j16V98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4574
X-Proofpoint-GUID: uiuYmK0b_G4E7htGZGqaN0EyppkmPb3r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfX5nbzDnwkhz7q
 a//maWF9wWHYdg0xo9pDai08VXuQYy3g3pA05Piqr8CS/nXGPSdrzODhJUgB/Lo3KQUT5asJyFV
 0mppTT7uSjUS1IBw8KRmynSC2l+piM4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNiBTYWx0ZWRfX/Pw2IGdkgpSz
 XY+uPo2aIsCzImXg+44JWt/5iIm5kzGrltbR1wZkJZegrNnCBcThFndwlBisbQV826t+D6x46Uj
 Seiuk+eHj7YA6N9vbSAceCYpryb5M/VaD5/CYL28IPW85ObpM/e/q0x8p6RuSngWSCkxYBNt6wd
 gnrxYdd2/cILcP31V9X6bU66GSKhy/uEqFy8LfPgyYOIJfIzubd5guBbRaYmdglNYmsvpSVRuCx
 JeAm2YJ10GHGwZ2YeovcI4DsJKOLNjerYR/OZOUIs2f1dSx9jhghgpbp6gaYEaK3D5L+jQA68qu
 a+xbQawXe2mvuZXSLcuc7GzZV8mutKbjiLgt1dIKlQm6ZwRzMTlcSlPI2+JuToV8iRm3iM8E9ho
 usEE3092mBCqAprpUX2xb/84+Nv7skQEhTf2F5XnxtiSd24si6fPHOJYMWv7PBi1gOK35AJPacX
 z352X/dztnaxNZQzAWA==
X-Proofpoint-ORIG-GUID: uiuYmK0b_G4E7htGZGqaN0EyppkmPb3r
X-Authority-Analysis: v=2.4 cv=DJIacCNb c=1 sm=1 tr=0 ts=6aba31b7 cx=c_pps
 a=w/xsMB98MdRKPpKwYm4Ziw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pyeFwUqU_ggsqV3MqM0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
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

> Subject: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS padding suppo=
rt
>=20
> The asymmetric crypto capability structure currently reports only a
> generic modulus length and primary hash algorithm for RSA, with no
> way for a PMD to advertise which padding schemes (NONE, PKCS#1 v1.5,
> OAEP, PSS) or MGF1 hash algorithms it supports. Applications have no
> standard way to discover this, and the OpenSSL PMD itself only
> implements NONE and PKCS#1 v1.5 padding.
>=20
> This series first extends the capability API with a dedicated
> rte_crypto_rsa_capa (modulus length, pad_types, mgf1_hash_algos, and
> an explicit-PSS-salt flag), then updates the capability reporting in
> the octeontx, cnxk, and openssl PMDs to use it.
>=20
> On top of that, it adds actual RSA-OAEP and RSA-PSS support to the
> OpenSSL PMD:
>  - RSA-OAEP encrypt/decrypt, with configurable OAEP hash, MGF1 hash,
>    and an optional label, defaulting MGF1 to the OAEP hash when
>    unset.
>  - RSA-PSS sign/verify, with configurable hash, MGF1 hash, and salt
>    length (rte_crypto_rsa_padding::pss_saltlen), using a dedicated
>    EVP_PKEY_verify()-based verification path since PSS does not
>    support verify-recover. The PSS salt itself is always generated
>    internally by the PMD; an application-supplied salt
>    (rte_crypto_rsa_op_param::pss_salt, gated by the new
>    pss_explicit_salt capability bit) is introduced by this series
>    for future PMD support but is not yet implemented here, so it is
>    rejected with RTE_CRYPTO_OP_STATUS_INVALID_ARGS.
>=20
> Test coverage for both OAEP (encrypt/decrypt, default and custom
> MGF1, with and without a label) and PSS (digest-length, maximum, and
> zero-length salt) is added to the cryptodev asymmetric test suite.
>=20
> v2:
>  - Dropped the virtio and qat capability-advertisement patches from
>    this series; they will be sent separately.
>  - Documented the new rsa_capa/pss_salt fields in release_26_11.rst
>    (this series' target release) instead of the already-released
>    26.07 notes.
>=20
> v3:
>  - Renamed rsa_oaep_supported()/rsa_pss_supported() test helpers to
>    is_rsa_oaep_supported()/is_rsa_pss_supported() and switched them
>    to bool.
>  - Minor OpenSSL PMD cleanups: hoisted the mgf1 variable declaration
>    and used memcpy() instead of rte_memcpy() for the OAEP label.
>  - Reworded a few patch subjects for consistency (app/test ->
>    test/crypto; shortened the OAEP/PSS OpenSSL commit titles).
>=20
> v4:
>  - Fixed a build error in the test suite by making rsa_pss_digest_sha256
>    a const struct.
>=20
> Sucharitha Sarananaga (8):
>   crypto: add RSA-specific capability parameters
>   crypto/octeontx: advertise RSA PKCS#1 v1.5 padding support
>   crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
>   crypto/openssl: advertise RSA padding and hash capabilities
>   crypto/openssl: support RSA-OAEP
>   test/crypto: add RSA OAEP asymmetric test cases
>   crypto/openssl: support RSA-PSS
>   test/crypto: add RSA-PSS sign and verify test cases
>=20
>  app/test/test_cryptodev_asym.c                | 663 ++++++++++++++++++
>  app/test/test_cryptodev_rsa_test_vectors.h    | 317 +++++++++
>  doc/guides/rel_notes/release_26_11.rst        |  16 +
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   8 +-
>  .../octeontx/otx_cryptodev_capabilities.c     |   8 +-
>  drivers/crypto/openssl/openssl_pmd_private.h  |  10 +
>  drivers/crypto/openssl/rte_openssl_pmd.c      | 367 ++++++++--
>  drivers/crypto/openssl/rte_openssl_pmd_ops.c  | 140 +++-
>  lib/cryptodev/rte_crypto_asym.h               |  18 +
>  lib/cryptodev/rte_cryptodev.h                 |  50 +-
>  10 files changed, 1535 insertions(+), 62 deletions(-)
>=20
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Taken Ack from Radu on v2.
Applied to dpdk-next-crypto

@techboard@dpdk.org: This patchset has a ABI break which was highlighted in=
 deprecation notice in last release. Since this is an ABI break Cycle, I th=
ink we can merge this set if no objections.
