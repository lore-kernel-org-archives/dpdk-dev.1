Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B63C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC2440299;
	Mon, 24 Feb 2025 08:17:31 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B577B4025E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:17:29 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O514Aw009504
 for <dev@dpdk.org>; Sun, 23 Feb 2025 23:17:28 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbse9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 23 Feb 2025 23:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXt7HFAS/x+mQJYkRV4lujFWx0KA6egj7b8OFUQmYdon0wFfB+kf4J8sTFui9mNcZMyFqs5fWO7Yvxy17cJDCYgTzsKxFzRVniernXJq/lRWv6+sKcOUlCFqZUf583oFE3SH/mNy2aWQcx4AnKtNPHQOhb1z5ddUwfSPb7dzu/aOQja/Oh8kWMDi5kR9JLT4fvdfBYKG1LITTT+UU5Ak7L3190RGamKRdhskj3eCJBO+HC0xADbYRz9p+mOk5nVhACL/mjQUlwjVbzYa6tiXsh1hmf7m81IRGrHIquyguNoLQ2xmiBCBjC7Gzbu4r4nc6W4L0WzOUbWpLK7tEW9ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a248R5+uFbYyKjTqpGLPBmNXQt8/XqGCNIyomc9K/Go=;
 b=qCeSEGGhUVVK4+skR+KQAxCgfM0oEhaihMqZp5BXGIgiNlo2dd0pmXVmW8DYp1zl5R9aEUVQCf1Ohxa0noUArePYOsHtN143vE7cSJwHAb7Y7ig7V1cLBrb2JaoBTrKagHvboAQR6FALZfVu7aeH6FuAXFlm4/t2j59bWkR6Bh3ijm6h4/SQNr1sp+1ySWwxVtPXUCwahlAkYKopVye4/C0cz1X0AzrM+wcknTLRpupEDqcKYI6P+w4logv5h1Ex3DNY3U7ilVGa9Oy9288H46nVjoy1gUpSHoinHOKaBCwf7XBwrxO8P3mjIenwzqQlg9TDnlgY/Z94Z2EY8MvNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a248R5+uFbYyKjTqpGLPBmNXQt8/XqGCNIyomc9K/Go=;
 b=YBqU5H+Ep8f4rlzy8QS8GqEYTJg+2DMP5HZN6TE97n2RlBpDsGaA/jLfU7bqxF/Dx3TDBqccugy9NLkrUd6ULcH/4TQI3aY2fO+VlPhDKDWRJtuxPlN98Mb/E+45yWyWOS5H5B4qVCPMtFPk055m17/BwZxvFQkEeMe3B50YoZs=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BY1PR18MB5989.namprd18.prod.outlook.com (2603:10b6:a03:4a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:17:20 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:17:19 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 34/34] common/cnxk: move interrupt handling to
 platform-specific
Thread-Topic: [PATCH 34/34] common/cnxk: move interrupt handling to
 platform-specific
Thread-Index: AQHbc7c05Jyhb5+twEqILGHe4r5rkbNWMJBw
Date: Mon, 24 Feb 2025 07:17:19 +0000
Message-ID: <BY3PR18MB4785F5DA0E98A9A3673CB166C8C02@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250131080530.3224977-34-ndabilpuram@marvell.com>
In-Reply-To: <20250131080530.3224977-34-ndabilpuram@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BY1PR18MB5989:EE_
x-ms-office365-filtering-correlation-id: 46c2685f-3a4a-4295-ac05-08dd54a34688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?g9dYf6rkCVWgCgLkR7zpqWKTrSABlaP/ES1+r5QJjFMPfVkj2dL3wpPaHww0?=
 =?us-ascii?Q?/gNJOWWnxPgPoGTJA62vNoxLQWPIv6KMCLlB5q+QLdqJey/93jfYuhtR2kfv?=
 =?us-ascii?Q?nVM1lTcd3og6cZ+5Px7OhwBHxv+pmxUuGxDttWieg8qd6MJTmgrlPZZ5LBdc?=
 =?us-ascii?Q?qm9yr5QYRga5+haB/Ly+JQ0/BVHQ7XNy5hIbXQoTeLD7BzElx5BQgFAWKziO?=
 =?us-ascii?Q?1N+VXwAFXVXPQwO2NNkAZE2cEY2MRz4vdJIGmKf45P82dEBZf6NTOJC5VlrA?=
 =?us-ascii?Q?cq8LnlApkBrLeGkrsAC1mVNa3pOyNCzHiU7m3Z4n0S230JjAbuvTMiXVJ3wF?=
 =?us-ascii?Q?8ymE6exujgANkRGD4hTAxZXAK48h7wg+RJKXYUXk5TK29J9UvpW9DqahZJh/?=
 =?us-ascii?Q?nGTHGIrp7Npn4l6vXIOhlgPfr6373hMKHLVAUY8DnpJqmPs6Vqnl/3Jgp5Gn?=
 =?us-ascii?Q?mci8SUwsYLMqj+R7llC43U26NF/RyepjBhjlT9WJa29Zzm0ar24IJpjFWmVJ?=
 =?us-ascii?Q?f2WSryGFFL2//RzXxdnFKo2f0RQAO1EluEN1fotc+beIYO4zh814djQ2S9/g?=
 =?us-ascii?Q?UpU4jYP8fHMV6+9FLJGfb83KQ2WabLbK1JtzphiO1L3hy7pyNUqfm5fZFCu8?=
 =?us-ascii?Q?0UDKNNh7eXf7icI/PV/GBKE8r7maXpT0w+evJhAmgLsbUCeb5y0y69mB/NCa?=
 =?us-ascii?Q?gqy8WtGrpOaP8Mn/Wr35KmLdLaUHgl1nOXjCV+n8OSN7A1LWqLvH49Kl5Sqg?=
 =?us-ascii?Q?E9xPFVBffGnQb/dDT8ymmD+QSLfKKoK2GWQb65huy2tH6+W9WOvPlj2d9ut7?=
 =?us-ascii?Q?58ffqXIGHrDuhGYtpnTzdYnWsYd5LnvzmHy3zRZ8wcVOIXJzt1WBErNY0dxo?=
 =?us-ascii?Q?8SThAsMAzP5RtXVrACmYpFe7qYuD6NMLuD9eTKXTcF2XrFRYm3wBsBRgSqth?=
 =?us-ascii?Q?DEzNMusYfiYfgULM0G6oZf8o9+eYdAL/7OdprXyquL8BgavOfBpyQXxGf9N4?=
 =?us-ascii?Q?agRL0NWrIlaSbLS7dbbgrolEq5b5yfGr7GesjaKbnpC1l6tEVNQO5G4HfrIw?=
 =?us-ascii?Q?njig+sPAfmp5GqzBsjGlzPTHUld67iS4iG+z2bdBT/CzaTE93fFdYRu1C16x?=
 =?us-ascii?Q?xRxSCVitRzkZIJL71PoN951VpC8yTicIXTKQf7uGCKiOMJy0jlEUSfOevUOQ?=
 =?us-ascii?Q?F6kaCLqfsJ+ODuSRvjrscXpjhGgWtuC6Tw1E7eL8d+Sbzlj4usY2BjNcbVbM?=
 =?us-ascii?Q?qrT2d1AJZ2k55VHNxU8KGgO+d3Yxp3DDhGiZWFjkevFCqzGoEczZJk3hnEno?=
 =?us-ascii?Q?Ra9uK5m5bnJBtMpsvYgNr2aTqYvjgQDXQ40isVeWaz8XHPyGMsU9pliCLVuO?=
 =?us-ascii?Q?u8FawUGxO021uyVpbOxtPYETRNLTVATMXs/gAr4mcsiXIVzChfpWW6vuTBfV?=
 =?us-ascii?Q?HU3Le8+Ht+r5Djp1qWa8vIW2zoTIlMLm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fXv3seMmRVnhrrMTvtn3RItjaRqCVZJO4pViJVIzKoYoPc1qX+pswH68i2jI?=
 =?us-ascii?Q?4r9ZrSMCcUvI3NCKJDSzA/HRDegYgxX2MMT5l/swDhGMJWA+tgWeHaSWqlbH?=
 =?us-ascii?Q?6A/Qtfu9p1untVhGHvQG0z1e0vFsAwt2Hf9L83eyCjwTsZHRETXbiu+AZ0sR?=
 =?us-ascii?Q?JnT754djoDNWioPOzXRO/evvZW6BZSSFM5SVcsMccb1fnipfvgfd8mzRoNba?=
 =?us-ascii?Q?u07gOyqSNm2IU3zQuLgBmukR/f17fU9WCoapZBYxDohsQa8JDkyRh32iB0m4?=
 =?us-ascii?Q?kEfhJmB65qTIjw88lFz72344voIHG2PAVXw5u+Z4U4NYPjnbUnqQ3IxUDhU4?=
 =?us-ascii?Q?oZv1j9F72g/SuLKF76yFWIBP3O+n0EL0mzbUt0W+g0HGnxqZnlLcvWhv3Xcm?=
 =?us-ascii?Q?RyGmAwQLsklvLHtTIwBUUznUMiFrrC03Kyan0i2S9Ylt1INjnGQdWZFwXfAd?=
 =?us-ascii?Q?2ISo67EvXRVHSqdjpewDnqsrTcpUt20d/5MibwMq31gQV8kk0ZqNE6W5M/Jq?=
 =?us-ascii?Q?1Kaf/g1mYl3hy9r73J8xmY0f1An2oYSadUQRZom6acLWhMGqXoxjwZLaVkG0?=
 =?us-ascii?Q?+/yJOoz7G1Gc6nko4/9pX8qyuVe9S7/gMQcwEoeZbjN4/BDK0pxKwS+rwkcs?=
 =?us-ascii?Q?whEfUOSe51yrxxRE0bUaBVVJIaaOS5FIdvypekLfHSG6F2Dr885FR9GonxYQ?=
 =?us-ascii?Q?7yZGoWlOusfs2lgz7hBBoFtJPA/3A92TnQ/OLzgmqeFiptRZUGTI8uRxAKSg?=
 =?us-ascii?Q?hTRRZFbcnXL0tqybp7ogf914oJR1iumyguvc9g+SOlhrKZJnQpbFZOEpqBRo?=
 =?us-ascii?Q?tf64YnsE1COzWNBGL3R8XD7n97qSrZtoIEyL1vI+jjowr2mlOy+a0IHOLk6p?=
 =?us-ascii?Q?VLxLqv5RKprkC912fzzPY03iKp7VMzzu6n4Je+VFB2eHS9YSRYuUUgoqgkMq?=
 =?us-ascii?Q?ff/0E+NB57IqeJe7Yqrq0Qzeb38b36wZkSs4nxqhNxMA68/JWRJc3UBK4u+z?=
 =?us-ascii?Q?SwBH9sAAVWdZp4esutICp25J5DmnsoFjsG0fUOdkWwfIXE9O9rI7rwS69bzh?=
 =?us-ascii?Q?Y0a7oANZvQ1BXVqjZqb0H85BxohWCK+5zB7/Q+QopP9W000cTexrq/6aH1un?=
 =?us-ascii?Q?yl0u3UVUXtnuNLAWrf017EUrBmKTpagUfiaDuZwv4eaqHn8tmSCuT2fxSxkI?=
 =?us-ascii?Q?PIQ919h0PSTACgst5pM2wSvpkD2PhzMBLhDkt/nQ2qob7goNTKF11YNL6vxd?=
 =?us-ascii?Q?hMKBPZ2UzT7/P7lB8G4aJLtesCTWhQWUBk/3jbubQfeSl6dBMmVXefw4B2Gr?=
 =?us-ascii?Q?mMDabb8fT5znBMOdbNQ+A91w6rb96O3WyhGdVacBKWh8UaW0yop0e/aor0IF?=
 =?us-ascii?Q?BGA+m1F2TRYgtxfqNRxSfnxup+X3mFW9n1FwedVtEW6/iUcifEDzKm35hLYO?=
 =?us-ascii?Q?ApIMX3DXnA5/QxGt32lnNc8tg0MmqJiH33+mSBvJ56TFoHCXJhc3hCUEPWrL?=
 =?us-ascii?Q?8T2k05rPTUltOxp4K8IgsYTxXzf2zrfWHcear7PDSDPhJC3sELhMHV+3IdLw?=
 =?us-ascii?Q?5945guoEFFqf4gEDRuSdeTYs/FplehuSvGu/6fWr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c2685f-3a4a-4295-ac05-08dd54a34688
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:17:19.5688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crxG3S8uy5XYwQVxM3TegdKU/yffIIMH/o8mHzNspSsaVjZPOCF+3Qpg6pw2+adcEo6HgSqZkrh8Ue2mh4nIHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5989
X-Proofpoint-GUID: th2midpfq6jU2ZrWqJnwPJv-VWYU097I
X-Proofpoint-ORIG-GUID: th2midpfq6jU2ZrWqJnwPJv-VWYU097I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
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
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Sent: Friday, January 31, 2025 1:35 PM
> To: Jerin Jacob <jerinj@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Sunil Kumar Kori <skori@marvell.com>; Satha
> Koteswara Rao Kottidi <skoteshwar@marvell.com>; Harman Kalra
> <hkalra@marvell.com>
> Cc: dev@dpdk.org
> Subject: [PATCH 34/34] common/cnxk: move interrupt handling to platform-
> specific
>=20
> From: Satha Rao <skoteshwar@marvell.com>
>=20
> This change refactors the interrupt handling to be platform-specific.
> Some platforms directly call ioctls, while others provide a library API f=
or the
> same functionality. Moving the interrupt handling to platform-specific
> implementations enhances clarity and maintainability.
>=20
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>


1) Build issue
build-arm64-generic-gcc

Project name: DPDK
Project version: 25.03.0-rc1
C compiler for the host machine: ccache aarch64-linux-gnu-gcc (gcc 14.2.0 "=
aarch64-linux-gnu-gcc (GCC) 14.2.0")
C linker for the host machine: aarch64-linux-gnu-gcc ld.bfd 2.43
C compiler for the build machine: ccache cc (gcc 14.2.1 "cc (GCC) 14.2.1 20=
250207")



FAILED: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_rx_cn20k_rx_64_79.c.o
ccache aarch64-linux-gnu-gcc -Idrivers/libtmp_rte_net_cnxk.a.p -Idrivers -I=
../drivers -Idrivers/net/cnxk -I../drivers/net/cnxk -Ilib/ethdev -I../lib/e=
thdev -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include =
-Ilib/eal/li
nux/include -I../lib/eal/linux/include -Ilib/eal/arm/include -I../lib/eal/a=
rm/include -I../kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal=
 -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/met=
rics -I../li
b/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/m=
buf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -=
Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drive=
rs/bus/pci/l
inux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/=
cryptodev -I../lib/cryptodev -Ilib/rcu -I../lib/rcu -Ilib/eventdev -I../lib=
/eventdev -Ilib/hash -I../lib/hash -Ilib/timer -I../lib/timer -Ilib/dmadev =
-I../lib/dma
dev -Ilib/security -I../lib/security -Idrivers/common/cnxk -I../drivers/com=
mon/cnxk -Idrivers/mempool/cnxk -I../drivers/mempool/cnxk -I/export/cross_p=
refix/prefix/include -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 =
-Wall -Winvalid-
pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qu=
al -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-de=
clarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wp=
ointer-arith -
Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-a=
ligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Darmv8-a=
+crc -moutline-atomics -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-f=
ormat-truncati
on -Wno-address-of-packed-member -Wno-vla -flax-vector-conversions -Wno-str=
ict-aliasing -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.cnxk -MD -MQ drivers/libtm=
p_rte_net_cnxk.a.p/net_cnxk_rx_cn20k_rx_64_79.c.o -MF drivers/libtmp_rte_ne=
t_cnxk.a.p/net
_cnxk_rx_cn20k_rx_64_79.c.o.d -o drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_r=
x_cn20k_rx_64_79.c.o -c ../drivers/net/cnxk/rx/cn20k/rx_64_79.c
In file included from ../drivers/net/cnxk/cn20k_rxtx.h:18,
                 from ../drivers/net/cnxk/cn20k_rx.h:7,
                 from ../drivers/net/cnxk/rx/cn20k/rx_64_79.c:5:
../drivers/net/cnxk/cn20k_rx.h: In function 'cn20k_nix_flush_recv_pkts':
../drivers/net/cnxk/cn20k_rx.h:619:37: error: 'lbase' undeclared (first use=
 in this function)
  619 |                 ROC_LMT_BASE_ID_GET(lbase, lmt_id);
      |                                     ^~~~~
../drivers/common/cnxk/roc_io.h:16:18: note: in definition of macro 'ROC_LM=
T_BASE_ID_GET'
   16 |                 (lmt_addr) +=3D ((uint64_t)lmt_id << ROC_LMT_LINE_S=
IZE_LOG2);    \
      |                  ^~~~~~~~
../drivers/net/cnxk/cn20k_rx.h:619:37: note: each undeclared identifier is =
reported only once for each function it appears in
  619 |                 ROC_LMT_BASE_ID_GET(lbase, lmt_id);
      |                                     ^~~~~
../drivers/common/cnxk/roc_io.h:16:18: note: in definition of macro 'ROC_LM=
T_BASE_ID_GET'
   16 |                 (lmt_addr) +=3D ((uint64_t)lmt_id << ROC_LMT_LINE_S=
IZE_LOG2);    \
      |                  ^~~~~~~~
[977/3457] Compiling C object drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_rx_c=
n20k_rx_32_47.c.o
FAILED: drivers/libtmp_rte_net_cnxk.a.p/net_cnxk_rx_cn20k_rx_32_47.c.o


2)
Is it candidate for Cc: stable@dpdk.org backport?
        common/cnxk: fix inbound IPsec sa setup

3)
### [PATCH] common/cnxk: support for inline IPsec for cn20k

Warning in drivers/common/cnxk/roc_nix_inl.c:
Using __atomic_xxx/__ATOMIC_XXX built-ins, prefer rte_atomic_xxx/rte_memory=
_order_xxx

### [PATCH] common/cnxk: support for inline inbound queue

CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
#1231: FILE: drivers/net/cnxk/cnxk_ethdev.h:506:
+cnxk_nix_inl_fc_check(uint64_t __rte_atomic *fc, int32_t *fc_sw, uint32_t =
nb_desc, uint16_t nb_inst)
                                             ^

total: 0 errors, 0 warnings, 1 checks, 1174 lines checked
Warning in drivers/common/cnxk/roc_platform.h:
Use plt_ symbols instead of rte_ API in cnxk base driver


4)Please update the release note for new feature such   cn20k inline IPsec =
support
