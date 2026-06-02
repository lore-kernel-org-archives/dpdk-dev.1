Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36CCD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 19:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC4F4064A;
	Tue,  2 Jun 2026 21:27:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0161E402A9;
 Tue,  2 Jun 2026 21:27:31 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652FoK4M1231225; Tue, 2 Jun 2026 12:27:28 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022084.outbound.protection.outlook.com
 [40.107.200.84])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3ba341-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 12:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXkstoY/Apzlqpyl9WxL+IUI/HxeLC7pGz4+AzeHc6bdztS34IlK07zBlOsNJL7e0TGGivIMLF9Njq8NjbeRarc9niVy6CueXVfP+tqfzenibGLNLJf8KZt4E9rJkL0340afx25FBc2+t+OovYmOwz057eeooHh4xt0dJnRpkNO1jENx0ckt7rLv7xFKSqInsTo6eo+EjQLO5DB8PDlsZAQO4CcG7Xn8Vil7I4zpWMld/o/mWmj0wqX1NBuhphcIGKxOC5UhscUArOMMGC8X6zFftJXguB6wge/Np8q5AZBMi+xiHKn4uWRCV9V09v0+OyzXc6M/XVT34XvBvpgDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+ec3QyYN5O2XZgQuYFASvoQeTvnPzSdQD19zm2upH8=;
 b=SxuNEchwIeqjOrr45gf6Fltz0zoLbtb75x8rA0UE95pnt3bXjHewiaDvLtR7t60FISkIQe8zFPnL1dlKL7MqTOPx5NvBVw6W30+HXkj2kmS2A88+chNZoxwAw5nlgJzhaCrc19wArNuUPaUyFkv9FMT5F7YHjiDI1lHIpkASVWvWZ6xKCIQnDiuAJsSce9zBlUvp3FCCiC8YhWbttaV765VvyGVesArKLUMBxme21lE6V911zGuESUnCIXfA/Xm+Qd61nOACNW+qkRWwCRHR+vVB4SZsqX3I4Y7yx72MxhLigmPdjaxGABMhhIzy55AeebfJGc8uAtWMaahUqj6Mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+ec3QyYN5O2XZgQuYFASvoQeTvnPzSdQD19zm2upH8=;
 b=FYyNccBldTtZutJIIJWbIx1OJ1O3oeeQPrSINrMwcfpSyvZlQcEwn36jltKG5rJNdFs3FN66CA5Co3nGyRZmOKzJyBGW5nfKaVaegGJhmqpLsf8rBCP5P+9xmtzepTR1RXahtAbSp+1lBU8G2KKbov6NN94rq1TXnePD60Iwfb0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5661.namprd18.prod.outlook.com (2603:10b6:408:1a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 19:27:22 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:27:20 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Daniil Iskhakov <dish@amicon.ru>, Fan Zhang <fanzhang.oss@gmail.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Daniil
 Agalakov <ade@amicon.ru>, "sdl.dpdk@linuxtesting.org"
 <sdl.dpdk@linuxtesting.org>, "rrv@amicon.ru" <rrv@amicon.ru>
Subject: RE: [EXTERNAL] [PATCH] cryptodev: reset resource pointers in init
 error path
Thread-Topic: [EXTERNAL] [PATCH] cryptodev: reset resource pointers in init
 error path
Thread-Index: AQHczYSAqYLYOAaLZkyYDjVnfGptw7Yr8Aiw
Date: Tue, 2 Jun 2026 19:27:20 +0000
Message-ID: <CO6PR18MB448469769846132BEE9B0EDFD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260416093437.711435-1-dish@amicon.ru>
In-Reply-To: <20260416093437.711435-1-dish@amicon.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5661:EE_
x-ms-office365-filtering-correlation-id: 6c11c22c-1c44-496a-760f-08dec0dcf6f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: bQpcZ5K5rMEvM1ZKxkpenMBa/h38pnnp8B9fvFYErPMzaXsU2atCL+38OOiOtKPuPF83LTGVOUxRHHoCeGNl00iryw4Go+cQ1/J/ULV8AcZXbreufdviW/HwwK/GF+5I+CkvLm2zzv90rkc5tsVGLSwVDS09ZedFAxX3cODdWS9ZOH88R+c4k9FOP92hczM84ElkhukbVhEBh+6EjnHhJ93NnM+kWVI8nLyceMMhLzOPm/RojlyhsyiJQRvvfC2SAAJ9iy/uHcIola7iIl1h/CzAPdwcq3j7OslXSUPZ/BhtJpaNEpigkOEuPR4Fa9hLR/yzNCW5bjOTtLB4DuTv/szY6hIDzw+VaqqgxjH2/22CLkTDt+pExuAIMrrWALXl9KA3lAkG3nzgGmSVQii0Ybe85YDMDUYra9alhg2WjnvxCm15DNU787p1PAeq+WJudm373cnpLhCfN9orXdfwAqNpOxUeI7JSLIFB72efLI9Bs/Eq2Q2Kjk1WdKyrRw4lF/tPjimxZAnSYJ17c9xyNUGZ5CYIneUMIlWzUb6AIR6am12ahMFnbf0QALOiaKJ/uBfZAUGkG93IsmPBEslOnxS1OYYodxp6zexVdlHhv/++7chb89iV32A15NeXF7SqiXxZoACvXYOWG0i7UoiA2S9bvCLWC6v2xIHbhFBe+kh9uQ95PZXoqoLF6a3rLeidrvWn9tt+D18mbL62uT+2M1fDyOBzNz+as9zsmpB9B3Qd/gQ618TrC3I3ldv0nu3+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YwHRx7tV+gdUl/KnH60zRHDsZ9VyLcFTjwLsvL8pE48jadZlBbHR/2VAHPlx?=
 =?us-ascii?Q?9Ae9Oui0rAVwskiisYHQbwJj/AwhqvFU9mszpdAO0Na2lgaN3gZ1WOq9KPnE?=
 =?us-ascii?Q?Uw/GqHHIcpafkW8dT0cILfVr9GaBVhmOALZ/bBiBCdM5FeD797vhhuNCKJCs?=
 =?us-ascii?Q?jhJdvyUuBwQwINADiwsoVZIelx4Zt6pbYDqs1wdo5TFLx49xVPzSlIGEfHpk?=
 =?us-ascii?Q?v6zdf7V7Y54fSQpsyPbFcAiUa1qtj+/jUHBGX+pEsOaeuUj1TbMl3X8KKV2p?=
 =?us-ascii?Q?dp+xj++mCtpPc2qpJ/TLKdkTGaeMmB8F5Iwgg/Gy35ae/eskiYBTJbeTYEXD?=
 =?us-ascii?Q?JQcARazYpueeYkHiP6Z6AWeNPhfdOi/mQjqajeEpR1ao8ELo8LrcQKsr/g1h?=
 =?us-ascii?Q?5IL8d7SIRnELpImexi7sAhh8EbxdQDOSPuh923GUu13qaG1kkO52eb/eIiRn?=
 =?us-ascii?Q?q2UiULlzeZFLbf0fCnSa2ihW2rreLRbnvOa7VbgiPteYKeZ22yUMd0TLv4jz?=
 =?us-ascii?Q?+NAiE467g6pStFTLZHK3PxlKo3ob/40hzfe4r4nzvgAh6abBgJbNpiDpqhq3?=
 =?us-ascii?Q?GKGAal2F93D07/Eb06F9oA+95rrcTvrrFJaK+OAXUVuItgYRiAEDOmb05MSn?=
 =?us-ascii?Q?lLeNRga33eu7PdNY+7/izx97vIIYGgc0gciXbeTniILWPKZIHYliP2/az5RI?=
 =?us-ascii?Q?pFXvaKa26ENDize/SwB3EB2uWFKfNjWayJGQ4f4mz9LLatfYgmPz/sGt2e54?=
 =?us-ascii?Q?ErmP9OoPMkOvcYQkr51WfjK2sgwAzj/IjG0sFn2VYMj3kJb7Y+EQJXxmgkaa?=
 =?us-ascii?Q?u6cdLUcI3XEtUL1W/mY78UG8BiVXiZRyJ80unzoviBHUMP7ecYdQnqTHAGRp?=
 =?us-ascii?Q?Bk/jNuYmoKzNorb6eZpmhrvsXxq2+3hV+c1tqQUj5H0/ihuxVysHSXNMgxot?=
 =?us-ascii?Q?XnFmNdQe6+1x1hpeguGFwPk2oFodI1Gnnu0nyZHJ3Ckb4+fcXa5buXyjEQZv?=
 =?us-ascii?Q?TnrSjZrhvtMpQC7hqTXfU9rk7g/7RCfwLHQi/nU5cW59sLIw9a90FJkX7hP0?=
 =?us-ascii?Q?YQrBC9TeMH9RM0PfwriJABeFJkNYUtHd8RsM+loXc3zmiVOLz/5I1oZCUO1h?=
 =?us-ascii?Q?3Cn4yxMHqUgG1sTxY3n7vXtkeIcSls+xkGZRf8YuMq0wVvpX59CBfLO1WV0V?=
 =?us-ascii?Q?QWfoz4+kWKvWUKvQfa7LjRMvc5iPhCtBhJ1NOFgUE39PsfPMewuG5ftux9jW?=
 =?us-ascii?Q?U7+JkUryy1oGSkmLXN33ymXiEEIzU0GH07srIMNt8i9h3JywadFgorRaVRhH?=
 =?us-ascii?Q?8mMzhMf0HCxEWDr2d53MkHdgHamzxVOdW3Hw9yOZZFXrs4kP3lVRybROlziE?=
 =?us-ascii?Q?AlcUyM2FYnVj7jN1lUFPjogjopi2ZXNh3YPtwn0pASLuSpGtqOyAwPu2hGgv?=
 =?us-ascii?Q?+p3ajWZE+LfqUkNpXktj4Qp7rvEb+fi3Ql+mZAO4T1pIV0+nNgda6DwWfjVv?=
 =?us-ascii?Q?+m8htxIaqkZiYUdWtHWuquMNebyTqibNL4zrfFeklQlYy0yd4qAB1tn6NKwS?=
 =?us-ascii?Q?TVuYftVWxQgAgSYHBrnj0VJSX4esYj9fEY29ZC0C4l7aoiUsl4MtCDb2koPt?=
 =?us-ascii?Q?CzcfLFaaO+8D2trclLVdZluRflFKoFoiBL6tNtYSAqXzk2/RK1ZK/O6UK4HZ?=
 =?us-ascii?Q?Wnl3la9KxTz66cLVuk2SVArVUuTgjL840yfbZl6+8luKjITz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IO2XQj4M6fp7AwcqzazxT+dGqn+V32E/w5F4fVQr+2Jb6tQ9h6tqOnSbDNUM4LzBsBeljFZ4O6NqRBd7biTW7Fx93VPdUNphXLeImjTsuq2A/fMyYR5/GntpIz59XbA7paCeHMLp2sBHeNUA4f7HyQVveHb2N5YuO1zF2LBjRZ0mcVGSIpim6mMReD2PQAyWZOE9zMNTNLXIfgP4FX/6GA0H/SiXESs7/F69vV4qX/KEIl1pPqOMjLoNGYu9yDF/4imvVvpawF0ejWjvX3lv0ODP2MIoR6I1hjvfZoSgykzxuMki6ZuL64ESV8RFI//VkCCL7k3VwJY23dgIYOd1SA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c11c22c-1c44-496a-760f-08dec0dcf6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 19:27:20.1152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9cei4raI0TYL2xne3dq6NVa2LIXXsnjLSzpkYnuknlb02uF8YWRlBebRHO6j5nhHoJcvoMkvcNW2KTHjhUZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5661
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4OCBTYWx0ZWRfX9/mWemfT4Cu8
 PHiwsxXk8bDYPymmkskWehwkSzwVV0kl5y6/EGFl3aOuzVoSfkReBS93SjfBeAA7iKurer52lOk
 cghYHEaKdbXwYmBbsQ5yN/6o/qFqdHZTvlDTxxKYGFnw7xBZYr2MGkO/ZPgc9Mcu4RiFaS9QQAZ
 O2dpzSZYnRAtlX8x29eZvaaK9BV43tn2b4WLyBie1O+V1JavuFXrZUXKwY3UR7Y4ojQ46ZdgdYt
 1jer2uZ0Z3v2dXq77yQucQcpwekOTRR/r+la2lSFo7k1KIYM6NIstXOyYX8sVIlp5fgo0udiGds
 QtstWjtdiiunMEPQEHUzik4R17zy7aKNzfMA5R2MpHyzDuatO+KzFkXjtxz8aq8h3w/MU7XCBJ1
 M8JH2RmoKhzUCmVz/JlBsDCgUVpwBArZ+ZxeML4yPrqVf4bL6riZHuT9pu7IfLCcvLysFxY6EBf
 qW1J9tiEVHGvJosqGug==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1f2ea0 cx=c_pps
 a=rTfqarZ8i8SbNC6eR9Rc3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=HH5vDtPzAAAA:8
 a=8rWy6zfcAAAA:8 a=sNLM_7-wAAAA:8 a=R_geKBZ_htUyJYklh7MA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=bXa6LdoDeu3ueUUL6mey:22
X-Proofpoint-ORIG-GUID: JsdXpYxjicEZgbajsCDuBSAEeLwcT8mG
X-Proofpoint-GUID: JsdXpYxjicEZgbajsCDuBSAEeLwcT8mG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
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

> cryptodev_cb_init() may free partially allocated resources on failure,
> but does not reset their pointers afterwards.
>=20
> A later call to cryptodev_cb_cleanup() may then attempt to release both
> resources even when one of them has already been freed, because the
> cleanup logic does not rely on both pointers being valid independently.
>=20
> Set freed pointers to NULL in the cryptodev_cb_init() error path to
> make subsequent cleanup safe.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1c3ffb95595e ("cryptodev: add enqueue and dequeue callbacks")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Daniil Agalakov <ade@amicon.ru>
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
Applied to dpdk-next-crypto
Thanks.
