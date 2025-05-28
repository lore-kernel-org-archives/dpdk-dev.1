Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA96C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 08:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE691402A8;
	Wed, 28 May 2025 10:38:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C7F3140279;
 Wed, 28 May 2025 10:38:33 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qdLf024200;
 Wed, 28 May 2025 01:38:33 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2108.outbound.protection.outlook.com [40.107.101.108])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46wux8gbkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 01:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJIZDEo8Aza4EagOWUxLXMqV92yKShaVzulD5usYDeHD9O/uJBLKzGeCP9fmAPGPoBdH0sDAto/eGAWFmpO5+WOJJt5q7YTCM2u7+9dQfmYRspHYC3d+bl2cIhDGaRcX8Q88EyEEOgPKaKcQGLuTSL5F37DNQa6F5ZRyAwt0WRLEghGBNJiv7T3tuaN6vTPWGMI4MYs526vBLT+DsuKJPY5EKgR+jSgBD/pFpMIy5yEZrPoX9NQfeLifPxBivng31Yuhty8BfOhYWbYvGiXXH5g3fSPrbOjHQmQqQdUXlpKzAqPLa30Bc3SrnVjTY/c3whcQ4NmrB5R9PUqAPulkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVcGKhE3hOIuYpsYlDZZ3W+QugzPHjsYlUKUTSVPCqA=;
 b=QDSNpo/630RGwTDlZ7D1fI0cwY8EbH4FwV8cCEkJsoSL/DkpYXd75HlkZq2Ajym4qHbjJgtyBznrPVcyc1Z3AwMEfBjiwWgAV5a143reD3KNhzxVWwKvyafxkeYnsv3eiOoFPluCb3KaHkV+7dnXLnAjyN7imNfr/KJceLjmA58UBQAxupOxv/jGZzS4ByomxRfKwarNlSlo3ULUWcbbrlb8IRGGFc+XDFi+DCFOVTlrniowR8ehZI2l+lXGwkWyDtfP7ZNIGQ2uFp1p24PBF20RQZa4aJvxgHG3CmV7O/xoVJbAVkg9KcShq1Yu9jKP+ycJdK4K4W0jHVG3RYUjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVcGKhE3hOIuYpsYlDZZ3W+QugzPHjsYlUKUTSVPCqA=;
 b=W+lxWO4WUN82OYRHeXk3iWGe9ttrHd9ER0nPSeSrUv4uyARS/V7N2zB3vLKJUU8ysqIM2OUOx09pT3UGHWTKKpve+omJ3vcOSDO5YJdFzoM8XcJy7E6/CT+aNKcUGuEczRQfghMTn35TAzO4FcQtqCCf+LcbPo7cIU4ECfvQFdw=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by DS4PPF7C08BBC8F.namprd18.prod.outlook.com (2603:10b6:f:fc00::aa7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 08:38:29 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 08:38:29 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Shally Verma <shallyv@marvell.com>, Kanaka Durga Kotamarthy
 <kkotamarthy@marvell.com>, Ayuj Verma <ayverma@marvell.com>, Arkadiusz
 Kusztal <arkadiuszx.kusztal@intel.com>
Subject: RE: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHbwZiacBxVlAhw+Ua/Z0S4WXpd/bPn0GCA
Date: Wed, 28 May 2025 08:38:28 +0000
Message-ID: <CO1PR18MB47142C3AF47817BAF4210241CB67A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250510104452.2186-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250510104452.2186-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|DS4PPF7C08BBC8F:EE_
x-ms-office365-filtering-correlation-id: aad51b52-09e5-4bef-d326-08dd9dc3055d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wxodwtRoshytyhPoaYRatpw+3H08z9a6hbnxJe+YaqqbXvJxACJpOCeNiuRp?=
 =?us-ascii?Q?tvxcuU7wRv0W+HN7OAGu5Dv93xWNYx3sz2aERQBFLOBKCykvDIfIBSaaVT2V?=
 =?us-ascii?Q?/5aZLyMc76LSjb8Jdt+lRYUhaM+S+0mJ4N577lRTj04qHZB3F4z8rcMQuzP3?=
 =?us-ascii?Q?03NqobAQgTYxhRtSCoEUKvjXe2qoIhUhqKqUY6TOaD5Ijs/WbOqLlT5BgPeS?=
 =?us-ascii?Q?D8/uhzcP1XAG5fbYUFrV3MlUAsur9apB2D82A/cWHigvuIv8i2UvMRrccmDV?=
 =?us-ascii?Q?QUNerkumNgQUS7+IiAXbe/gX99/om3b8eGNIEkh/cOSXjae1l5syZXwizlln?=
 =?us-ascii?Q?+BPZSKgfB0DgmActMOossm/LxX7sBnCDZZEXBcufZLiMUzRSEknJHwmAjSFF?=
 =?us-ascii?Q?VOWzz4X1BW4NrAW5SDhtwnej/irK8QbaCSgB2quaBtSGqvCOZ43z3EdPD7vk?=
 =?us-ascii?Q?35Nv8bZ8Z0SjF4E4FZcuzKMXgQDmsAoKiVuAg4NsXPXJntIqwiVsto21pVwT?=
 =?us-ascii?Q?n2hIdaCVIMj/qC6C7ENXSev52hduHRP3rKaabynSzMRrkhJeE4NjMN5eerf0?=
 =?us-ascii?Q?/vlKst7QeS0m4okDDPQFQoWod8r7WyeN+EMzcYLDh8q/ugWmiCwOju05AFnF?=
 =?us-ascii?Q?xwn8ceOxJVE5U10m9Yk1ZKgZeGEebGADqpj08kyGNEIEOdm+4sxoPM4Su1gD?=
 =?us-ascii?Q?AKchpoQzM7GZM5K01pPT5h4R68bKdB0YG8eUUU3ESrxJ4PBQsZoEZSLZPmmr?=
 =?us-ascii?Q?H7cC33MeEj877v01u1+OC5+jQl8w0JFaNWkUlryj6rW4Lfp0lB/ato8S1Ve1?=
 =?us-ascii?Q?U9sv44JwsRCDMoYRXO8Weqd/Jv4j9FhU12IbzwUr60ftTgL81n4b1D1oujGy?=
 =?us-ascii?Q?xxlEMIcu1DLDBijfzO0t+oZ+DHC8oGoBXPHgyIwSDtg5qUOjjbMEEgoHNqt4?=
 =?us-ascii?Q?CwjSqxy499p46qE7vepwdN7e5UHoa7nLAF1rEAT5wqY/sz+U7r0+CRbf8CzL?=
 =?us-ascii?Q?EZqc1F0MEKqPKzbY0hg5qX+SeOeIKaK1Wn8ALeCVRd+IQHlNB3KtS3yKtr8z?=
 =?us-ascii?Q?rRUExJkdB1hfNx5HApixsDRgRwrQAlKBzfD6m/CwzfBLwU78VBSk3mL9Ogxw?=
 =?us-ascii?Q?AksNTC7bus9VlsvUPZE206biOHXjT7VgijO5vuqaP0Ybe15JFUe4oTA1j9ME?=
 =?us-ascii?Q?0KmfuZlWFkBu6H1MF+liXsgsuGYCcEHTCpcsESZRFC4UbOERi3eZe5F8bYP6?=
 =?us-ascii?Q?Sf12jHQEMIeX3HRnpcyxc4s+dRTvz+E+a20F4wP2SX9/e9ano7RNMaE0L792?=
 =?us-ascii?Q?CXgq0jfT797e29vTzcPcI96cFysRv1Hph6OqMPuz64GKK8f3yVPF9Iw0MGo7?=
 =?us-ascii?Q?5157NZTsZ+TJIXXp9arq9hrR0pIaCRORh/mQIIQhCT0VW3+F0W9ZOqm7dItk?=
 =?us-ascii?Q?wCz6oy33rd2KgMiSNLOuO5V9nlcualg+bX3piqcQ3VA8HTmZyUQcaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t2zR5qdmc48C1qPeD7cLq6T0A5C0VWAyo3qtEmLB/4MMmGPNGNUXZCNlqaj9?=
 =?us-ascii?Q?m/DuuYqQPv71wgOl5QnYFQZ5XQAbv/9W6s/czfYny0fcRUtbOXsbThr9k2TO?=
 =?us-ascii?Q?IY6BbfKMvDRB3GAiOVszJUp+aMuEKbFFXOOJpkFA3iKoyKQLq2l9tVgxZw24?=
 =?us-ascii?Q?5c93F3ZAT2VjiZWe2K8G6phxCvHeQe0lzThkLhoHFW9z+5DohhqU7oNqNJ22?=
 =?us-ascii?Q?kvHzdeB9bsIZLhKORDQRfPYFJvT+uiVpKXShWnOyRvuXXQWkbNpExEEiQjhG?=
 =?us-ascii?Q?YwgORUFuZjBVvuNxYo0TtMHcZt4/05oo0iqY/I5Njly28DeaRIVtE4/MmQAq?=
 =?us-ascii?Q?t475I08L6M0PC6mJDTIqrYHNCIQqdPRZ0RLOeFK9gF8ihpyIovX7mR3O2oZD?=
 =?us-ascii?Q?L5N1ZOW0/Q/dzdP14juykOUqrYMFMBAgwZUqfuJWs806e7ofc3Dy0mkKcHMz?=
 =?us-ascii?Q?CCEIPuh1eQOS5vuXLblmAPMWOZVY4925vO7OtdyrnfPpTzpMbtQdXJ9zUysw?=
 =?us-ascii?Q?hWT34Yd0+1IVXw8lBN1uqvLA0qEfT/lzH/pRAVBLmhOPFm47wXwBoozzzr/r?=
 =?us-ascii?Q?PmbvLFMsWTdAszR4kq2otBBUmVm+RE9sPEwhlgCFE2nZ76oy9WAsumYLNQJY?=
 =?us-ascii?Q?xzuu4niKf+vh8Vcq4jKS6QtYvJhKxmeVDpFasIiyd8EYlC3wBUjv1ckMUNia?=
 =?us-ascii?Q?B/w+uKnOQlAmFGnQwxsonpKrv9si44DOMedw767q9B4eG1SYY7vhfElcqxnR?=
 =?us-ascii?Q?WLgwBi4i7tgyEXFzSXhuqtqElMQd2NuxSZkxtnMhlha3quDkBG0euAenfqDz?=
 =?us-ascii?Q?hYZ2VBdiFLyP2oaZsC3xlsneP0jOUE1ERmFnLxzul5PV51WWYXBtiOx1xenc?=
 =?us-ascii?Q?LAuyeHV89zU4bcuAY0p9X3SrUHi9hTwo/wb7vpYCt5Jqr+AXBlVF1GE/USrF?=
 =?us-ascii?Q?a0zIHZzf8VTnGqxuwaOrvv0Fn5dmOrAF3gPwmbT/v9aHK+20/pVgUUEGKPw4?=
 =?us-ascii?Q?9II97DQGy7rpYXyLht+0GQxVKhLy0JvyWcdZN+iOa4ED5EnURzpFS3cVGNrZ?=
 =?us-ascii?Q?qBHFxo/PPVLltO/8/3YI6brGaxi7+WxsMW1VpdwgIVH9G2lhsPOr6zqzvodt?=
 =?us-ascii?Q?A091VSMjmG+QWzAZXM3Tk/e4kwmcpRpeqjzRnwllwS2vbF/t0Ucnm3CqYVK8?=
 =?us-ascii?Q?664F1PA2Auw2oO8AjCgtOn17jyrnemTuwk8mJj6/j27wcTmFnEd+m8usRluK?=
 =?us-ascii?Q?LOQlovLtIN69/UJlueknHEP/Vn/2b5BgxYP46RNWXaH87zaEP4WTvK3EGrNu?=
 =?us-ascii?Q?dpRtyAFmNLviKvg+4isOswBHf+glFcXV5w/m4nQNwfl+G8nslQ6sRHjDcd8m?=
 =?us-ascii?Q?PwveVHAMxL2e5TbIY4rAmxg6F8a9G+6NKF4Z4qLJgc0GQczGENG0/62FwxLa?=
 =?us-ascii?Q?FEiHurpKotPYN1l+ZCYqgqmTLcqRhULXJWXNk5n+3wwoN4HPtWFOdRHU3sQw?=
 =?us-ascii?Q?TTZNkmvY5PaTCjE/WN0EU3fOsgBMJCi13rcIuwIIkbzj4fSPjwV//BMbEkmu?=
 =?us-ascii?Q?mfP/1ZzTfDE/4ryjXGiYG/36ic1c+jYIVXy4QSOt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad51b52-09e5-4bef-d326-08dd9dc3055d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 08:38:29.0425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0woCjy0zD+oFp3eADJapSAT6WciaR5svkgC8RBdOKtqTcjNyRo4i46OQhQgxD7AkeKB/OzjeUXcYaLDNM2JRfeavKqVoUchuyJ0+oFsPgH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7C08BBC8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA3NCBTYWx0ZWRfX9R4sa+yZ2a+y
 THj5Um/8kDzSMiJApF24J3HOQajV9QsA9Izq0LXpjj7JblTxJ9Na9srhXWdQe5CBbnwlb5uyIlM
 g0NDHzEoX6aVSxV0HMMZYL+6jfkTmFXDvmnkJDXzVuxT2Bc/JeGFaObHup9mTAQB/+BXmSb1NQt
 LHg/4wba86Yhh9mEwNYodwwZQ5LHKnsizbp+aD3j+Ihiu/GUWtPS2hi+frsOMdSYuElpBRVjF9z
 b9MA1nv4aAOTgN/rQi79IZUade4lFVrwzULe3gOHcpTh5088o9Vp6nMRuM8wcGtETJLKhms3Pz+
 affs/6ZBhcJflsSY0Ntmi+HOxaSj1hHGPB5Pw57xzTil0t115qrZAmB81z7QbbEOim3CRfF7rSk
 B9gwf6R244FMDae5wwEa1OEQH5VaK7yX/4QqhySkCJ3eOSnD0p980yqkwB68s3DeK6nz7dUD
X-Authority-Analysis: v=2.4 cv=CcII5Krl c=1 sm=1 tr=0 ts=6836cb88 cx=c_pps
 a=kgs1+cFi3nCijIuPNNfxoA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=egkFwnCBW5gKzyc_zp8A:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Y5yIXaMxXe6MzqtUayIzMkiY6s1G5-wX
X-Proofpoint-GUID: Y5yIXaMxXe6MzqtUayIzMkiY6s1G5-wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_04,2025-05-27_01,2025-03-28_01
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

Recheck unit test failure for openssl 1.1.1 in some distros.

Recheck-request: iol-unit-amd64-testing
--
Gowrishankar

>=20
> Following RSA encrypt op, same plaintext buffer is used as output buffer =
for
> decrypt op, hence comparing plaintext buffer against same buffer pointer =
in
> crypto op always succeed irrespective of whether decrypt op succeeds or n=
ot.
> This patch fixes this issue with a local buffer for crypto op.
>=20
> Fixes: 5ae36995f10 ("test/crypto: move RSA enqueue/dequeue into
> functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

