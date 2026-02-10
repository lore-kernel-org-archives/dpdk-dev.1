Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F874EA811B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 841A240665;
	Tue, 10 Feb 2026 15:00:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4F17B400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:00:16 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61ACWSRq772291 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:00:15 -0800
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020090.outbound.protection.outlook.com [52.101.46.90])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c65snp937-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjSYtz4GRh2vAv98gvI+MH0gR5c82pbRz16HVgTX9enuuHPTCpG6cMDHbBnHHPBGXl85I8FGdN5/4LgWXFUA7uyFXhzFcJECSahKOTKSvJBssMShBx5zYQRdCFV8lCpE5+kGfSwcgIrvyiyBIlbOKNSkWA4Em4JKRDLnmBA4Ec0RLK9Eu3APfmWpbu4n5EC79LMTgW9en4rH8reX50L1ISrUYEHN2brHFq9XHjcKs9Ff0ybX6c0eKrTY0p+fixkmz3jCU1ebjKhzRzrP8hpUdzwmdW+ZSWAPdo1e/lQReDzDRQRZWtbFUg+RhkiyO5BWwa72tBuufvW5BgQKf0O6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36oS4srkxMaX7oIr9AhFm5yrixEAfqiR4z9UniMFLME=;
 b=yAtLMhU3zF76ckaPq8s5twS0cO1aZvddi2ii53cU72Pe9Xo97PWMgx3LctlT8P3UMulT56U5Dvq6dZ/sPNo9iSy+3mcN5Me+ByDeInW2sU0jlrlrT5yvZdMu6B1h6AlnldyNj0QJUv8lqFQeufKahWGw0djy8FRyyhUkNAF9mshx69mRk7ngFBIMBHUl5lj8kjSyWTyi+3ZFQ+4egg4Il//+LoF+scfmmlWWrurVwnP7u/SkApEr0U6+tYmDgiGPguJ7InyeyzyY1+cr07077XpIihlVzh4DoD23mdQvSxVSfSaAvndgKTc8OZpI2Vj3SBK+/whwa1zBzxp0a5atmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36oS4srkxMaX7oIr9AhFm5yrixEAfqiR4z9UniMFLME=;
 b=FlrkMwhJf88grSsVUaUnHNDuxaqvp9Q/oqKG2ElDwtD34j52lvYlX4HV0HZ27ecL2qmDxXqwzgZaPgi35YvRqGymrXGu2LcHd00t+gG2CBywnJUXwBMTP2K2NQjhQHrj/Ky5SrsXan327QkbSQunZvzyMw6O/mEg+9J0eshz0r4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4362.namprd18.prod.outlook.com (2603:10b6:408:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 14:00:06 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:00:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Garvit Varshney <gvarshney@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Garvit Varshney <gvarshney@marvell.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: return decrypted data for RSA verify
Thread-Topic: [PATCH] crypto/cnxk: return decrypted data for RSA verify
Thread-Index: AQHcj0ZUnjwZ3pEEj0KFrqL4AZtZl7V8DDog
Date: Tue, 10 Feb 2026 14:00:06 +0000
Message-ID: <CO6PR18MB44847F339F6C4F7DB85506F3D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260127043459.178859-1-gvarshney@marvell.com>
In-Reply-To: <20260127043459.178859-1-gvarshney@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4362:EE_
x-ms-office365-filtering-correlation-id: 44e171d4-0ae8-46ed-dd5c-08de68acb23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?I6vKH5vgZHi2grrR/3lY52TYKdpZCQgJ0EFVoPtRhx6GMx8/FN/zinlpyvre?=
 =?us-ascii?Q?5uoXEII1X0NvRwZEJmpi5wP7lQHQBenpAC6/BBPT57OF46AVxYIXxNz3TOur?=
 =?us-ascii?Q?fJ7wCiA1BQbknOe9z07Qvpg8y0YSbcBpyuMKXBkIvGSTpPP3L4WPYaUCJ4ee?=
 =?us-ascii?Q?Q1Agqwr+S2xQB7CjAyf7SrZ4XHzK2KUR0E41jvBHhDV3Kk7umm2RIl09W5rW?=
 =?us-ascii?Q?WIMDjGBe2GCgJ84EqwIw4aKRmXiEihjvT6Zs0XrOrxsCBibBxhxlPi4ajdBZ?=
 =?us-ascii?Q?EPWqsuKgZX7Rrp1HZ5SFE75Dyf4oIHrF3HxuT/YNgZDBmcDUZ1E7vE7yooYl?=
 =?us-ascii?Q?vqLsjKq/pNT3CFxVJN2G4scxdu17D/DzgGVZTcTeIYz4h+DcCDVSE0pDCRMv?=
 =?us-ascii?Q?bgaeT+1bNtBkv/krHRGoRN9BNemmuGFQaqK9zMRlpRFUmNztF1DjPCMjAM4e?=
 =?us-ascii?Q?UV+p8uwbhBsHv8E7K92AhpFXs0eA2deDE2I4Bz2Tjf5XxT1FsDpoOEiCMUuF?=
 =?us-ascii?Q?ZSQWyOqNK8bI4pc80TJgQe7QhcFTv7QrhBIWPzjIRQCijEA+MH+DKsArYbE5?=
 =?us-ascii?Q?25SjEx6/+GXDYn2qhiZoS1JtlyxzfJWcRX2pdvoVlAKlGLhCkBf5wnouPbcY?=
 =?us-ascii?Q?CH+fcLgdkfzUaccCQhLQ4i8xecol9FVG5Yh7cXiu6pzhQ4jVqOS9Z93c1zz0?=
 =?us-ascii?Q?hVOTkaFoYT7FPVFqp7IDQtcr1T7MUnVqeBbBjs3kRHg2sgswwLWWhNwGrRT9?=
 =?us-ascii?Q?PkKVHN+q8ct56ZTc+6OVOkQSqmPePay6KMb2NWNO1KTorWSwygZl5GPtso1K?=
 =?us-ascii?Q?PsHcHfaAj4qJawIRVm1q9Y5K9UzzbI2ZKNjzjqtasE/mGpf67g66e+awusBN?=
 =?us-ascii?Q?qoKnjQcLpL8s3o0J6DwewsEljKH49cRO/d7CA2XhvuZWKHyTKWqh5ZPr2GEe?=
 =?us-ascii?Q?cZk4NkNLwqzf1crJXpoT6/WERP9Xm5/lAwFAvMyJ6atH0L+N3ui1dzzmXgIf?=
 =?us-ascii?Q?DaIrewEFRnOt/httT1A+eYbWbCF28dl5g24XvdBa4kgRcKaUqE55Ii1Y2i7l?=
 =?us-ascii?Q?RRdpiJ8DZa1GEvSmGPTCksO+ox7nLhSriZ/cKwId3tpkkMMIWRIslKc3Mjrt?=
 =?us-ascii?Q?qTBWpXeBFUfdHXsUK41AQBVLONKZUeYmHtdzIADo+trBLMVSrqb8fEe78Goz?=
 =?us-ascii?Q?hERAAgiMVcjOujB1gX7EsfF1MQrEExRg4NK0pmBjmgAuXttF4JSzl5laJR3o?=
 =?us-ascii?Q?I7cEvZkdIVk7Z/4SF57C0Q5VQFborxoWBqHJnz1UdKdaxD5w64FWemk3fhcR?=
 =?us-ascii?Q?HdlJtlHgQcqV4I2Z6s4HLJJ7eRcOvhkU7va+TCviKR3wDAYd9dw/+tMdk+XP?=
 =?us-ascii?Q?8sMx6HdmlpmmZ2NOH4b7m0cYawfkgQvAmE0n7b9QWtSM1lgnjRgY8sHHrnns?=
 =?us-ascii?Q?+Xg7aQHNsFon1FCFXf3dOu4b0pf3qYF0xznvUSoiYYr18ULSivJX36+CfdX0?=
 =?us-ascii?Q?EMCgcT+iObGbELrIB7Ua2EzsHjXQjK5iKY+Oq86xZ79vReIKKL0spcT5u6EO?=
 =?us-ascii?Q?ZAzKzpQBAplfgTqJIfJR6RNj314dWYfA55wmbDgwBnF5EJ2wq4dit9MrRuNW?=
 =?us-ascii?Q?7AwdwuK5kQGwaU12EE3cgfo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F7h2oMQJoPjsZactJPFBJosAigvWc0B0Tk/qZbdhzwxsG3kg3FBkkfMaA4OY?=
 =?us-ascii?Q?iIxnIYgDXaElDzUWxLm08ygBH608ChdvXS1kHzWaxwLjBg0z1r81+wzKAXdC?=
 =?us-ascii?Q?CEwPD+vSspUUVFZj2utfvGnrID2P2f9InTQXYO1cVvStLPTr35oKelQ/wEPC?=
 =?us-ascii?Q?Tz7eYCE8l6uLSN3fANPKBTO/wl0PczjCZDWJz8eF8Xkb66oAnkrUM6m9Guxa?=
 =?us-ascii?Q?L+gYw1z5gbnse8tJszF5w+FAr66KWn1aVe+bUlZbxQiERcbPser9fyHTu1+p?=
 =?us-ascii?Q?ROeHWj/drYtMExJ6Avr78ve+TNlbwki/J4oF+joo0oVv9pPL/pNEiQvqw8xK?=
 =?us-ascii?Q?E8zI0cXmsuJ+Un1moEWn/lNCQj08RabnjKSK/O27E00dZHn/pxQIQIRnaega?=
 =?us-ascii?Q?oySG7lcu+P8WOMC4v5N89kLkcKEqsNw+ShkIEESOoz/qrJZWbLepI076kmta?=
 =?us-ascii?Q?vfaLA8+0ec1MNaB+eOgNscuXV2LUsmSEY/+m33H0HeX3Jj/AeRM6ThE8csE+?=
 =?us-ascii?Q?2oRDeCk4stHp7u9L4wbvI30op7odsDNqwxdy7t/bmeV/YUcYOR4NghlsmQ4F?=
 =?us-ascii?Q?U1yJiMrc5YwciCGs6fkg8PuorilZ/T5nmnYdryamhSwDS5XcZxfdrWRW4BoV?=
 =?us-ascii?Q?eydR5iURD53LeMSeoUx1qGOkLsKPf6bWWg2n0d8qKIidNfLQrz97/S3ZeX4V?=
 =?us-ascii?Q?uIi3EBuOxwzM7mOCjysoBJ8VXvbWiFcnH+GUkm31ylXqb1KOdUIftlb24E3R?=
 =?us-ascii?Q?bHIuVOuQurGVP3WHXPmesvFBh6bhG+7pFOfjOeL5UxIiMJ/PWYP2G+8RLI7h?=
 =?us-ascii?Q?N8hewbHgp5W8YbxqylB68+hRV2zPQH2vjtLWEeAwMEla7QKY50kT7as1krMp?=
 =?us-ascii?Q?oP7f3fG7oGaeVksJsTjNw7Eu9F8uavXcOT2M/dUL8jJtyVH1osxtVVvMd/m0?=
 =?us-ascii?Q?b/PfP4llqMQv/IAG/7te9TpBUZ4TpeVDoRUXnKi/BEA4Tn9ZKG15kAq0HvIa?=
 =?us-ascii?Q?S0+6rhhhNB2yqW7wi4ioW+GCOxwluP2xUZ5Gu2NGmM3nmaGcmlW5om26Hp9u?=
 =?us-ascii?Q?ppJG6M2isxhS1i9Gfofw+eCtCx5hFJLaYUKT+4N4uZzeMkvlXZs6wdL1PAds?=
 =?us-ascii?Q?fYZLU6aa9I6E2kVAkXHUMFsmH6y6K48kGvMJ1NsU+5e3PlM1Z9y1wca/E4db?=
 =?us-ascii?Q?WXinYRMM3grIGNIlyOI/iip6JlfQlm2DuCCQ9WmTnUpylSNFeP30yVWSYdlF?=
 =?us-ascii?Q?dESFQasEFZRK7Rzee4Zw+8EcT9CplGNdigHDNa15r0jkcQuip+0URJ9iExDS?=
 =?us-ascii?Q?dIIXSiHcGRaNUnSVTRAH3qtc5NhYQpR7qsGt6rSgHvdVrBvNJ+f/4NAW97E0?=
 =?us-ascii?Q?16uKSObTgGmbitH8TL/TpXC/oGAP2KOhbKcNBFdnwGet2zGhOg4BrOtxnbyX?=
 =?us-ascii?Q?ZrAkXr5BCX6ru/yFt5zh+V2kTZHQsTIUCApi4hslmiPq2i3sUGPWK/jbNDH+?=
 =?us-ascii?Q?kk9Xuv7XqWHhEet0XOXZqtAE22uFkPzy+rhUyAgFfh3UKZ1D0phwwGGQ6uYJ?=
 =?us-ascii?Q?E1nQDH5CzTQSZ/1A87ftkHyIjAHX6PBZN1qbcTqPylVQyBNADH7dYQO7gDih?=
 =?us-ascii?Q?4xJfogHZOE0idAmzT4IqRPARU2xaHgZZ6NIS07CuxOapkBIiT7cpjL0r+10d?=
 =?us-ascii?Q?08lk9POIteukFMhjbup2M0/elyvrAMhK1AeMJNcu4oQ8W9vz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e171d4-0ae8-46ed-dd5c-08de68acb23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:00:06.6528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GvUTXmiqk5xUfUWseUtrx/XVuogJjZ8SrnZ38WSiJtiyXXkCjrl75WhK17vwy5+XwjwPxzWw/O79DwIkBf6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4362
X-Proofpoint-ORIG-GUID: qRNQHtL1171N5Pi0HmKOI-bg0eaOCoF9
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=698b39ef cx=c_pps
 a=mKvPdnfujGBEPWwSy16I3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=2dF6P1MlOne9cAp1v8MA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExOCBTYWx0ZWRfX9pbo1G1kIwXH
 6gye7132ao0eOee0u6PfyhfRegCJeeyJ3QpdczI3WCrnFSujkzkfFzfTTssQpiUif4iF9IZO68s
 XEd/F3fxCHjBicveqdMKKoEyxNz8dMIV3AhCMVbexfZOHiLN4y1u+hC7F7PBzLDWUmKPxuLmNJx
 +V+rB8B6B0XZc0b494XjthsQfX4KSf3PVE67PmB9eW45UKIk6L4vTr3QIhrwviP0bFLqCUqtG3z
 sfmeSFcC6guAFfLz0JVyicqoeuLxVPbiMB8oLNTkVbe02yoxWJejL16PdQ4ba9vw4MJ13vyh8d9
 kN1E7skGWrHVtjO7hqJUpzcgOZEE4XK30CoI8PZhbYRqDxTyzMcwN/tWmf9jF20elxswZCLXdbu
 WWFaR+QRObo4GVe0M7Hb+xSEQJNb2c5KMbhRF+a2kX2rtIvX5JdWID+XPbXaCq70XGFg+jYI6R5
 1f51vqLF3Q77wQe13Jg==
X-Proofpoint-GUID: qRNQHtL1171N5Pi0HmKOI-bg0eaOCoF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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


> Subject: [PATCH] crypto/cnxk: return decrypted data for RSA verify
>=20
> For RSA verify operations with RTE_CRYPTO_RSA_PADDING_NONE, the driver
> cannot determine which padding algorithm the application is using.
> As per the API specification in rte_crypto_asym.h, when
> RTE_CRYPTO_RSA_PADDING_NONE and RTE_CRYPTO_ASYM_OP_VERIFY are
> selected,
> the decrypted signature should be returned to the application in the
> cipher output buffer.
>=20
> Fixes: dfd038b97ec3 ("crypto/cnxk: refactor RSA verification")
Cc: stable@dpdk.org
>=20
> Signed-off-by: Garvit Varshney <gvarshney@marvell.com>

Acked-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto
