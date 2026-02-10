Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3896EA8108
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFD45400D7;
	Tue, 10 Feb 2026 13:39:08 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7DE94400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:39:06 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTSDI2972122; Tue, 10 Feb 2026 04:39:05 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021105.outbound.protection.outlook.com [40.107.208.105])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9der-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 04:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK5N/YV0CXTlWBKQ7VcAk17+8H2uymuq9ZGsKG6I3FsjMPIb9GDMSZWNdePvg6McbHqDBNzLQNkg6qOskuaQ4lizHRn1lbyK0xbXNBtW8PLD3uRaJwydmMpXV7a2kdbJS823DSGS0gNUyAnRvjHeP/CQIWtJnJ6BKP3fCBiU//zuS37E+fjbNdYHf8raVgJn7rQuxqgXdmHnz1kFbBYvAhvsRxWj5DmFGZL+NCHYAWRbGxvclYRonf1zjuESv6uyf8q7zRws7aO70J6pAklyoE+6S+14JYZW+pgTFa95VB2hbuzuO86ot65M5mwT4Fwre7Pcd9i5qVJ2T+mPdSW00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3itXN8YY7waoW6Z7td77fcToh32usb1i1p76D9zAnsw=;
 b=Xu1F+q+LWEWnoPaII4q8f77nhWcfYYsVMzpj1Aymut9gM2wnsqtjz9qgE/pMGsMMdZhc01Rbii1jtNp2vks6KQ8GlDzB1YmznQCiWc6FHl22sLvTSfb4OyXtSJnoDM3OzjZ4iX1QjDgK/zRqX/bnOWdztGyidh1/54Z/W1VTcIAro9uIQk1JXw3GSiEHLJjWhm5slKZxrYh5m1l1lW9p1kFvEteQFPJ48lJW7Bi08mtDjiNj3EIkGXAOgECvmBPPKwgLLytDBdJID07QKCo5ScK6aEtqS09ugJvsFex9qNnjD7F5xkbkI+CrrzzX7Y2tSrdtobr0AV8rgFupDIceYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3itXN8YY7waoW6Z7td77fcToh32usb1i1p76D9zAnsw=;
 b=Wq+nQYN1MgtOhJkMuBxqyxZoB7ElUkTsqHt3Lipm88ql+p5KnDHRfdBJ3/DD/lOu5ZDGLKrxpaz5WnXm+bdP12e6RfxCPccpAHtn8ur2IAX9Fbmx8ydy7iRK2M0fel/E9GCF04gMIppMkm2NRq8niOrN3KkWLdypubdH28CGVxw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH7PR18MB5667.namprd18.prod.outlook.com (2603:10b6:510:2e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 12:39:03 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:39:03 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime@leroys.fr" <maxime@leroys.fr>, Gagandeep Singh <g.singh@nxp.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/dpaa2_sec: use bus device name
Thread-Topic: [EXTERNAL] [PATCH] crypto/dpaa2_sec: use bus device name
Thread-Index: AQHcWSt6k+h2riylqkiHcrgxA30eA7V8Yhpw
Date: Tue, 10 Feb 2026 12:39:02 +0000
Message-ID: <CO6PR18MB448483F4D063CDF42DCE58ADD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251119080633.25507-1-david.marchand@redhat.com>
In-Reply-To: <20251119080633.25507-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH7PR18MB5667:EE_
x-ms-office365-filtering-correlation-id: cb06c614-4d08-4667-fbfb-08de68a15f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?634O+NgoPnamB1pXOgLooEZoxsCQRNR6KgdXTSPzMMjVyWk3kOFDD2vBxaTI?=
 =?us-ascii?Q?eNZKhC1i9seHxliUICpT+fhsv5HDEeF0O6kN+vBxKPo+Lknqoa+oo4jOqV8V?=
 =?us-ascii?Q?8X24kQ+EgFyQrnAsFWDZrvDWGkx3P88RMLNYq+fa6qYtVdH4ydTw3tYd6azL?=
 =?us-ascii?Q?lcZmvCsxRpPe1VbAzALbtHYr5YwH9ftMoqEcTcRmMK8WOTMbnKLoXSARTNGd?=
 =?us-ascii?Q?LFX83oSjXEbATHAlS9sabghZu6yotmMdBOtuark/FzahZeZfYnBIlrNBI0d4?=
 =?us-ascii?Q?bnLK7JNi4Kwqq7NuhUrD2cX11/KYJTjDGKbpfo5XcjfjLh42BoJWJc8UJm2o?=
 =?us-ascii?Q?KAFJDCrQE+I5GIoYJhvc0CuSGcF6llk/tog68ILpx5q9A8kwgHgddV46HYxY?=
 =?us-ascii?Q?HV1/wB/dZxHYwqIJbu8UFDEArPIlDYhlitp4NaBPiyWaLsb+MjvG/eTTVV/1?=
 =?us-ascii?Q?m4Pzx8TyHHE5wZTvcIhQ5CoQJneOtW+KJx2OuVXttDGSOq4Q8Wd10pxkpl26?=
 =?us-ascii?Q?ucDIuFn8mMdlLqp4U5+8tlaLHxe9Ep3MV2w1yCKS2YBf47SgGrabV8HESTCO?=
 =?us-ascii?Q?l90PFqYJ5b6rFIDipWpWOrLZWhyuKThrONtPesdMl2r0eAxzS8+IYSM6M1li?=
 =?us-ascii?Q?6e2faIZEBXFCJvr++8Kouuuws9I1REPRsqe5En0IIVv2ZslgNLvjajRUoCE1?=
 =?us-ascii?Q?CHer84TGh3GiLvSIP4lRdeZlBdnQVqPP52/RUfP6QencVN5oNlBpCcloedQm?=
 =?us-ascii?Q?35sTzgcAAGzhUW2wJyZj2iY3o2P/5KMgv2BEQwg3PNXs802I2SorO3bASxw8?=
 =?us-ascii?Q?xMQc7Mp6ipw5Tl4phrZCXUTxwct/j9XFvElNYCOIYytXd8PZHUYLy4+OYr6T?=
 =?us-ascii?Q?mkM8RGdH0L9nmTGZC7YW1n8XCjD+yT7tAbbDKXIUt8L6jzppg1Ok1enbRmeQ?=
 =?us-ascii?Q?B2CWoVx/62r3/cKipXTngKpdXU6rc7+FC+QY3pfCAQ0hMQo7/ozFmVjI7jU9?=
 =?us-ascii?Q?wyfDfih8XXA/Jiwj5pBJ7QGFX6+le5TazFSf7ekaiMtBfU9fjP3g2BFl2E/s?=
 =?us-ascii?Q?N3gRaUCo+6xHgO6FGULJbjLhFLF6my+v90hlA2R1yw9UMQYFEo00byF1s9w+?=
 =?us-ascii?Q?YqbyjZZYveTLTcOkhStA/USCqM4abcvbfeQ13Tw3r6nK9pOrwOwZ6b+kLow0?=
 =?us-ascii?Q?VQPRfA1sWmdg5k3pUwbq66YVPGhuUUfnjqrpN4XUc6yoRZgKKsdwrCwrnN8J?=
 =?us-ascii?Q?D2PzBq6Ztctdqqg/8KAva1/HzJxdwpMySD4f3kZUoyH4O/7dVfThw2J9xv+u?=
 =?us-ascii?Q?Yuc9/zfU+LR7+8HINVJMpW12xDgDe4ScuBmzNtDj57LOoKtPplPh/Frz4Ine?=
 =?us-ascii?Q?aAQQR6I9QdTl//Y7Os+ZmCkBah0sHqxeESeCIkAqtiNMdiI1HD7Ne8Y9JcqR?=
 =?us-ascii?Q?0fWvI09v1OrVjqDyMOf2AXomM/jijIAw22kzxAR4oNCB5NGh2pi09TeqfVvJ?=
 =?us-ascii?Q?1G9XFJ+siUbQSpaDhoGYMrPxgRLo5W/2i+eJ03FDE9uhYQmsNH93mHMeQvdJ?=
 =?us-ascii?Q?d4087JvLDxBD50TsIT6wXl4DNSDbUhyiSa+vFcdBxcFDbm/00qWkBa+oeT+J?=
 =?us-ascii?Q?JpfQwA+vBr+UsJdACHFArNk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvotS9uRF6UhkmNnUkLHpCI3LrBjgbgWPcPTQfTD6OcW5ycfKCeXAgCfyFx9?=
 =?us-ascii?Q?2l6jsmyUUqASTPhTuZ58GXSEMNnfYQPtFakTiE9I0uP1RFzQeqM7HLJ0yUgD?=
 =?us-ascii?Q?3AM21AMvJV/0sXVGzpB5hsxFSTkL0QunlDRHhI8uhDpm2KlzbtwzxD7uNFBT?=
 =?us-ascii?Q?rUD085yf9BwJ/cPDxTooZ7ZM7qFR3GKqMobMYw2IPVuZ93vMAhJxxDX/oSlT?=
 =?us-ascii?Q?TyEJ+1Xo+9fzNGdNaMov+FFjgOPuBH2lPLMKZeFv6kkXwTluv1nNjvEsUBTl?=
 =?us-ascii?Q?2N+R8oRFbUrgRreg5d8HMj4J2/JrTSGwOg81Mg0NzZXgXjpmXPO54rbmNBNg?=
 =?us-ascii?Q?cQr1RX00VsKKgPgRbFoxw3X3+zlQELJc9IBvZd8nUguYAWqlNXypT4QbM6Mn?=
 =?us-ascii?Q?WpiknPEv5aQZSvZf4TuOM7nu6ecS1iLfyK+61Foauh+ri+blw3cXQI3yIvtV?=
 =?us-ascii?Q?eWxGa6CCQ8FAsEXD+qxzVwMlzgQttWvH4Cj+RqIzWriah0JoqZVeYD/dEPk0?=
 =?us-ascii?Q?G/m8VL/x6RtZ9sLiwPfGryWTb0FzuKlYkTVnTr/wG2IpHlAGZh3mytfbzZ7U?=
 =?us-ascii?Q?GHSoWHkndJ+XBqMqsPLYK/NeviCFW004+x/nVy22MpkehN/J9FDdwdJmQEka?=
 =?us-ascii?Q?OhW8cqsM2Ncc4jGji8KXrbhBJJNvCdroG6HSqbwoKCySNm8fUFIWtWg6s/5p?=
 =?us-ascii?Q?49lYSkTVqGdSemj5ygilxv9JkMCSJIdMgHE++GhKxGqKUtwONl4hoxvUi53B?=
 =?us-ascii?Q?2Jy1JEqg+rGpwjdD3ugeLydFK6y0XaDxIIWSQYlioQ4mMkgiK+nGfxiqs2H3?=
 =?us-ascii?Q?/ucMdD9V3HAQwIF4VseDN9B4jByFmAL8Sw0scg1NQL/eOoP8fXr9loSJXuuj?=
 =?us-ascii?Q?s2YGO85Qzfam2HWathFPPNZ7bU3fDovFdj5Uua3qMofjEPFl/FiuuVZojdYb?=
 =?us-ascii?Q?5yxYjXLbMuyKCbpohFWdNNjoDhHsXGFd6bThyJ+IcB6lfVJWBGtXiTJkWEXS?=
 =?us-ascii?Q?eUMUCye+MUQbfD3KW3LCpFPPyoMVJZ6VpD5b3Skoi/SqV0X7r0S7MGfZA6n/?=
 =?us-ascii?Q?AQ/gk9DjUPk2JuEUAlkdomAJXPJ5pR1GYFrv08CXX1MdUIkpnIFdHxugHlGu?=
 =?us-ascii?Q?RXBbiW3puTgmzC4l4UHEX0me+JOF/FszTnwXhfihSEKlDQa3pzOnuEUS0sOB?=
 =?us-ascii?Q?K9n/uVYOplzFuG6L19NEMMjIIxRVhSZizQaebJFA5BrbfiBVraBlctG5XVTj?=
 =?us-ascii?Q?oc9YSoRUdL9W0MpgUXayMPj8H7zGDNh9QcNVU6k+MipDZv4B5+cBOiXTT7Fu?=
 =?us-ascii?Q?5B79A+iGHAqu/f0wMx3XhcVv3WeqZ88aHLhXb8r93YMmblP7AeWrIcI3qRsg?=
 =?us-ascii?Q?F7Xsr/kFGhyJnAuOeoMqbDFkYcqlnuw+iLKd4zyepYDUmd6pjzRcGt16AeBi?=
 =?us-ascii?Q?glOY+1GY+om338EG13MgevrEdgCKtAgZTk6LjO20oVtXEoMPurDvdN25uEJC?=
 =?us-ascii?Q?UWBEdjpslqzNoQRSyyZK8ok6W6CNBoUIZvytsA/TfBYjXu3pB3SO0f9AplzD?=
 =?us-ascii?Q?RcODrFEJuQ5ZaSLkThKao/Z2E8cwKNud/r2fPHayMshX5t4DEdyz0QDOPeoi?=
 =?us-ascii?Q?AIrknBQnc7SdTJOhGeTFiU0TNfKbI0T8Yukvc5+5nMEicotfmua/rOQ3SdTT?=
 =?us-ascii?Q?hwwY4a9tUL607ppa1vgbORk2uSvJNz145ZG5nE9tsR7Nywwd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06c614-4d08-4667-fbfb-08de68a15f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 12:39:03.0243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQdgBu9wvi0X2MB7rLIJOir2ZRKtya765VcX+2Gz+CCHJ6HJqJqDOiiVjr84409rnyr4NmMgrNoIKWS9E4vMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5667
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b26e9 cx=c_pps
 a=vSqOpBkPjxmweuu5fCWECg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=TQ6IN2Z0q5K1qYaDsKYA:9 a=CjuIK1q_8ugA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwNSBTYWx0ZWRfX33EMbEy/s6bo
 DfbdD9QUdXEyq0E1Xppynyjcs/BumFEtxU/lNs3hN6OqnHxp9trlsLQNhfM8LkaN3rqmbvB1GA6
 Ael0knGKkFT4BjQ5pNKESgZ4XBQKoqklTciKI56Ejujysmmr8p+8epR893TsFLpWlkHySxrrWZ7
 Gdo/paR2E/p/43qi/qH8vkEknGuRWjd67YYNB9K0HsJeP9xbvUiA69wys2jdTdhtCqIMki2rVTY
 yvTeZI/ieGAqUa0j7p+Sxf4xGVLi/w/CpMf8l845i6+HJRh3cDvbXgY133io7StairZYsLE+p8P
 d3IkHxifnmY+IE3QNqOxpB5cJ6fDwvmyqz3pt+PYUWsEYhKcQVihaQk/MTClLuLZQKxoBVBpC5C
 VRvoP8VOrHHvadCK1AFbWNk5qQm+lrgj8WsH/N4c6FUh661KmaVh/KkP/1Mtdku/UzU0tQL3BgD
 y7Lvj/sPAMXdTPz9pDg==
X-Proofpoint-GUID: FbUobbHugZjSj6evp8STcawFQxp33moM
X-Proofpoint-ORIG-GUID: FbUobbHugZjSj6evp8STcawFQxp33moM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
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

> dpaa2_sec_dev_init() sets the crypto device name again after
> it has been set by rte_cryptodev_pmd_create/allocate().
> Overwritting its value could end up as a bug if the cryptodev
> library changes the way it calls cryptodev objects.
>=20
> Besides, there is no need to generate a name for the crypto device
> different than the bus device, as there is a 1:1 relation between
> those objects.
>=20
> Reuse the bus device name directly, iow: dpseci.XXX instead of dpsec-XXX.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Applied to dpdk-next-crypto
Thanks.
