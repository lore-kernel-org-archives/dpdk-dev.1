Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D9C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 07:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6AEE402E6;
	Fri,  9 May 2025 09:17:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 61C944026B
 for <dev@dpdk.org>; Fri,  9 May 2025 09:17:36 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548NIYMG003775;
 Fri, 9 May 2025 00:17:35 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46h65x0qyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 00:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH//sUC5G3aBqqYqSigIEeeK3zFHaIZKAuWsGVT7P3pbPciWE+wFQrvMFwadAnhNTg0KVuS0uP2nSs4GhVzUy4RI9qziwP+dXActqQha4nxHzDeo4xeES//TgdnwyTH1MR3EJJkSbIPjiVy9Cjk0q/sfW+ZS5Vp+OcoHZ43r0xZkYuNaLMv/dY2hKPi8CZLEatG788hBtlJmx1n8WR/hmRZc0cQKqMdI1m9f3pNXnmeKm1x92LXo9dO6QdBGabydox5CK/z9ClQw2IPBiRd7rQ9V8pFQ7B6eNQjottUUyFEtgVWCAdxddeex7HGTJpEFb4KWKsBGCbkAtu0TMTnCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpVos47EE9cAWLGrPX+68wX+uNtkmqeQHmIyYMjMelU=;
 b=UWnWLRfzCykSfYgQlnx8oNOhjfKvRapN00Lijyx9wxo98ftQYabRcnqXpyT+e65K9JPIZEcb3Wq5tKOWggJXCtEpRS7+CPR1ArdNV7BLlLpxvSw+/SA/jY6UrjRsCMyhLsvdODw1Zm+T1ksimbBgpAt+LIvFr2fFmy7Ff38hceRdMCMcB5bK+tPIfKwvYLbYVuPrva/1PjqJwTHNbYkUedZB8cLMd0r+JBOn5Dz3mqdjUUl2dkXzBMhJozEK78Nyr9dgIh32HWEq4RXT1MwxmrAgPL9ORF2v8lzSsTkk3H7DTxaFeJV9k2VUZp8kKkLX75pI6B8xaMbeCwOkkYpy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpVos47EE9cAWLGrPX+68wX+uNtkmqeQHmIyYMjMelU=;
 b=oDMZuB+B3ImWimTuoYWELlewJFLmSWhalQe/ccGCtNwUk96qWRTZXgNZBfWC2KK+uWSUx6c5sgIyfgReBgH0ksGCs8pWgnZ3Nv2q7xrHOhu8pMMM4+msnnPmh7eokkhvW/BgeoAWJzCu2txhIliz5cm6j9W4XPV+c4njpQ+ZC9U=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DM4PR18MB4365.namprd18.prod.outlook.com (2603:10b6:5:39a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Fri, 9 May 2025 07:17:33 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 07:17:33 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Robin Jarry <rjarry@redhat.com>, Christophe
 Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin
 Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v6 2/2] node: use node mbuf dynfield in ip4 nodes
Thread-Topic: [PATCH v6 2/2] node: use node mbuf dynfield in ip4 nodes
Thread-Index: AQHbuCmIu8evDewYqEqXTzVJ4HF4dbPJ9Hmg
Date: Fri, 9 May 2025 07:17:32 +0000
Message-ID: <PH0PR18MB40865BD7D541CF679E8899C7DE8AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
 <20250428103711.3317231-3-nsaxena@marvell.com>
In-Reply-To: <20250428103711.3317231-3-nsaxena@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DM4PR18MB4365:EE_
x-ms-office365-filtering-correlation-id: 769c01d0-6809-452b-a649-08dd8ec99110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oHSHJzUnmGonBnhIBaU6yCEM+L/7JdtLvvhP/LpgNVH6ATsESScBiF/+ehXq?=
 =?us-ascii?Q?Hg5NsZWDcuxlP0ciWA6rwsuw3Ps73un0rXC3LOZdj2vrLkC4B7phku17WIgy?=
 =?us-ascii?Q?5rxcqfEKZEZPYYtR1TZ5SBTw6jkqk1a8MfWB27FYp3667AmTcKQPuIZuWuvL?=
 =?us-ascii?Q?Z5Uxc8lM0v5mAQZiuw+0BW5aIntNlDGp7rrqiFSPYmrbP8Bz/99mdTd9XgII?=
 =?us-ascii?Q?Yv/7WdgkxW+APV1hpx8rdelCott5H8bqsnlgL9yvey8U1/ZGmleL39Oz4Va9?=
 =?us-ascii?Q?vS5WD1/T4VrjdZBES5CWdDBnITX8nxyGrt/xQmyO3Rrn06eCk0x1rFA7Z42o?=
 =?us-ascii?Q?rePGx4c9BviC600xtZ4dNoZvEIjNFNS72RCHSZ+0NtErZkWH1NMSRqng0IRB?=
 =?us-ascii?Q?axNsvbQbJHKxm+CluF8iwCUatxsFKP3ygzT2X8DEGYaeR2czZfeVRpIqu4Pw?=
 =?us-ascii?Q?R+2GmdmIPmqaqlt5+DOQejXjDzejibgdehHrf1/8DmteeGdAErj5EvuKX3XS?=
 =?us-ascii?Q?34WazK5vmEk1BTS26jBFKAsxmI0upX7d/r8xhCk98cy0D+440cSW4wq26Zmj?=
 =?us-ascii?Q?j/2SfLQwrkYJgldzY2nPq0OX0t4OvRv4Zt76psxrzj7gzxfKFk1bRHpm3djH?=
 =?us-ascii?Q?Q+SIO6iCV0BISklv0htQqGhXua197+av/HYPdr1FCi0JT5U3yrzlQZuN6yw4?=
 =?us-ascii?Q?C02LfNwfLRq+kh/whI8qRAph+1dlyJ+XruCjNltlBd6Xlf80nS/O3Yo/O/HM?=
 =?us-ascii?Q?Or+j6DW7D4hpC1HfY3pp/FHuisoMpuPHwehkqaaKy2MU+J2s31yKlqxE0rZ7?=
 =?us-ascii?Q?x+Q0UYfKNlJr4tIB5aGkRWt4JCZ/zcqtybA4hOjaIKYoKiT1p3EggCoIF4CY?=
 =?us-ascii?Q?Ui0Y4VrcMdM5D8g3pyzc170NUOdwQ8pmOubauAaVuSJCZAmXNtWyElKAFy/m?=
 =?us-ascii?Q?MQmedo2t1T21nbTZU7YOwEYLNiUYC8khPxxhzzf4vDCBi8GujmNxG7N1EY7e?=
 =?us-ascii?Q?nx/PzST0K3SrfMfVfllnszmA+LTBwfVs1Mewx9zTwL7d2FtryYP/KGajaPFF?=
 =?us-ascii?Q?QogNwpi8qbYFB50EnyXLWqT3P5gU8ftPq/P6Vwh+LanP2ybMo763KA95n6oo?=
 =?us-ascii?Q?1l/5PRmVayxqkHgBHvb6IpAugiAYwi6LdvjHU7aAWmhk+NRbVlSs0yreVRLg?=
 =?us-ascii?Q?Up6LrL657ecHY7WKH5tjT1UMJKXXmdDvA+XICEHMLZTzCxBMKtM7qPvcBuoD?=
 =?us-ascii?Q?nQ/7F6HuXmY7PpEDnCoJqrje6UtzpUVafk0TNKd6e45E4q9lFrIry7C7i4IA?=
 =?us-ascii?Q?jMEH+lYUJp5XhY2ZULJU2UffY022nbZZpjmjJ7UhWFGABsGTLB0fOv+ZFRuG?=
 =?us-ascii?Q?I5SSN/I9bqoHkF+5RY+gei1vqCUC6073Mb7TreQWnM5uUeuF4cli4ea3WiXw?=
 =?us-ascii?Q?5pofWsZQWxz1+LqDYL1iztayUHmkYzfp/dPjwY7Z62nxV5HARfmya4UrnjZP?=
 =?us-ascii?Q?/FpHbu42RZIYl/I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BXCuF9c8wkUtJ5I0RJNzdWvZiePtjyiQvOLTOud89TKE4OCnh9Z0bJK5ozVc?=
 =?us-ascii?Q?JxaAc273E8hReVvP0lUNrKVnXU5TdbJIjtD7DYVG464zT4b3ktaHq+4RhRPV?=
 =?us-ascii?Q?0Odb0mwkEyJzW4xYqM88rALFD0paJruGTYjTWFyzn2GY8g6M8JfEKOI4eiQG?=
 =?us-ascii?Q?8hTgBdlxSwuUlDdzkhpE4EjW5ynnQuZ0iscFvSjJGLNklnSmpp0vtTKFNSWV?=
 =?us-ascii?Q?IRMCDMleP8q/WOlke4erPTdWVDGKv1DSRZlRvGueE2aZLCJjrASDPpR1A9H6?=
 =?us-ascii?Q?63YjcXiO2/1hGtLhxHWZGNZ/yJ0y8wwY+b1wytMGzYeVbBst5ADTfQJOWwXK?=
 =?us-ascii?Q?xKlUZRW1/n0/1o3tNrW+3T2gabJJ2IphwPlP6/r3aPWIOE5Cyz2KcUoXT527?=
 =?us-ascii?Q?igo0MKm9PHoDczxki/2qxVC17Sef90yFC1uXgGH0hDWNt3i7ihKgHeMj2VKF?=
 =?us-ascii?Q?tyabnUfyu48CZ17N8eN0rLtjhwD2allOEQ6LAnBUAW6SCz7h00wLKrQ1jPmh?=
 =?us-ascii?Q?60wtG5C9aDOdBc9xhz2qoM979CPb7l61nA5GBKSKTkeR3QmUrfIEdKbCPK96?=
 =?us-ascii?Q?KmQyenPz+lNjZqJRDHelilKQI60RBTVgORP7u40/sjYihPwbYRcRkdL1URx3?=
 =?us-ascii?Q?td/bj8qoZaognwqegn6NBQsrPAZFgWeD3btfygG4YW1Zrz6AWlbuvAdbw9S2?=
 =?us-ascii?Q?mPxJzvq021htlvCVzP6/rKYWo2s7bHk49uG3tp0vz42uhTim28xBgB1Hg07o?=
 =?us-ascii?Q?mhAskiOLpBiGFCGB+FQX++GL7heXyLILHiboC/Swxocart9ivxJx/z4oNQqd?=
 =?us-ascii?Q?6Zc+ZZkzqOm7Gbif5NAwPYb8Zyz/Fc1LNDu6uxr2N7XMfi71/71kJ2seiL42?=
 =?us-ascii?Q?1zp9GABH6BwhHXr0o8DIZh/M1fiKQ39ifz7YDaWOYcxH725m+CJD2tBTsMug?=
 =?us-ascii?Q?tEQQfz+s6P1HPmBisvCcO2LwQIFvh8mnECpPWeuItF7zubIHS6S3J82OzS3J?=
 =?us-ascii?Q?zmFdXqNnPO5utWjl3HYSuWyoZGjZLSmgqXYHmWtcgi5VCvxFf4icycDlVsh6?=
 =?us-ascii?Q?g3qbbtnx0Smsx423r6NCwqEqvPnCYQ3uQcH99pteCkaV85VNCiYqiOeEs/Kr?=
 =?us-ascii?Q?gdN+uqxzsmX1v0s+Ir+39AE4Tiiv4ygcCl7zYBtWVFno9Qx7VKnSWeOrH1Zh?=
 =?us-ascii?Q?8YdxFdlnraWPRiDKZlcjbY+l/LwTcYGONK278zp2JDz5b6g+gLX9bBQ7Jowu?=
 =?us-ascii?Q?ssYDvJEgIhMoxBHZiTz36ytuUz/IvkoN6xFjuD2zTjaQZQO+BVTNY+kMZ/Oh?=
 =?us-ascii?Q?m/W2YPXXRLMMKdVlHr83uUVdTBW4j39gzjt1jAKfa6Fl8baspo82b0F2O/1c?=
 =?us-ascii?Q?5h8oPdFyW9tGIQFMQWPtZAsm76lhP+ouSVHQfCUxI3szOL5JluheGfEXNzsZ?=
 =?us-ascii?Q?cu4zM6HD9DpAzlZTXWQ2cC9TlHCzA9G36rtfAAvsQchuiHpW9XfwH9+GJYSb?=
 =?us-ascii?Q?3oDQUfbpq8vGFfGajHPnnTJAsepRyvk67OjZwZDq8aMsp5KazQcfdp3g+eNd?=
 =?us-ascii?Q?T4I6MAmBGPKhGhvY33Rtyzkjzvqv9fVvpY0VudmG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769c01d0-6809-452b-a649-08dd8ec99110
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 07:17:32.9372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF0n2FS5WwDP7N5Cp5sX/UtEowQbQCx0kiSpbOQtOoyeJE1NLYv+WuAc5rtaloaNisPrZmNc5vgd3r2B7nfLvy7i8tvmXpdb+AgwzvxdbDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4365
X-Authority-Analysis: v=2.4 cv=ZdsdNtVA c=1 sm=1 tr=0 ts=681dac0f cx=c_pps
 a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=m9Pp8p0MLiyia-yipyoA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2OSBTYWx0ZWRfX7iG2DX20MT6g
 DQiEM1QdphKgXfJpQhSk+j2EC5AWpRWXWfms+I5g1/4TGBLaefl2aABOV1at094HEyeGH+3gslX
 q34fQANAcNGCA0ZNhpEevvgGsHP6v71gm3xNn+OwuvqJzo+ceMw9liy6a4bcpM4GLanG26mlPlT
 TVljwdsYcX4DiNYUX1ELd4/1WMDZTY0oJFCpJO+7fsL6gVBPNv2yJXLRR3NdIFbxz5GtbTGiZDB
 NM7fxa5o5kcHRD2PS2mgnQzZthsPA5ebpj7jg+TfYcimm60ThDqbsDBj6NrF22bqTGyO39ytjoc
 noiSW4/tp6Oox/x+EylLYhKj4YSTrG2YwydYmMxfnOUUNa/W/X3z7ywC255+ESd1EkjdGLWl34z
 BQ+9dDQFJNg9Bs6Lg9aNCMsVBouJdJ98tpsn6ZLY3RztLRk+4E1Go0E8kpCbUT7pbPYmk9+c
X-Proofpoint-GUID: wXms6JXhJ30ql5i4Q328ELxi6i4sSFeu
X-Proofpoint-ORIG-GUID: wXms6JXhJ30ql5i4Q328ELxi6i4sSFeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Monday, April 28, 2025 4:07 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>; Robin Jarry
> <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Nitin Saxena
> <nsaxena16@gmail.com>
> Subject: [PATCH v6 2/2] node: use node mbuf dynfield in ip4 nodes
>=20
> - Used global node mbuf in ip[4|6]_lookup/rewrite nodes
> - Redefine node_mbuf_priv1() to rte_node_mbuf_overload_fields_get()
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

> ---
>  lib/node/ip4_lookup.c             | 14 ++++-------
>  lib/node/ip4_rewrite.c            | 15 +++++-------
>  lib/node/ip6_lookup.c             | 15 +++++-------
>  lib/node/ip6_rewrite.c            | 14 ++++-------
>  lib/node/node_private.h           | 40 +++----------------------------
>  lib/node/rte_node_mbuf_dynfield.h |  9 +++++++
>  6 files changed, 34 insertions(+), 73 deletions(-)
>=20
> diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
> index 604fcb267a..f6db3219f0 100644
> --- a/lib/node/ip4_lookup.c
> +++ b/lib/node/ip4_lookup.c
> @@ -32,8 +32,6 @@ struct ip4_lookup_node_ctx {
>  	int mbuf_priv1_off;
>  };
>=20
> -int node_mbuf_priv1_dynfield_offset =3D -1;
> -
>  static struct ip4_lookup_node_main ip4_lookup_nm;
>=20
>  #define IP4_LOOKUP_NODE_LPM(ctx) \
> @@ -182,17 +180,15 @@ ip4_lookup_node_init(const struct rte_graph
> *graph, struct rte_node *node)
>  {
>  	uint16_t socket, lcore_id;
>  	static uint8_t init_once;
> -	int rc;
> +	int rc, dyn;
>=20
>  	RTE_SET_USED(graph);
>  	RTE_BUILD_BUG_ON(sizeof(struct ip4_lookup_node_ctx) >
> RTE_NODE_CTX_SZ);
>=20
> +	dyn =3D rte_node_mbuf_dynfield_register();
> +	if (dyn < 0)
> +		return -rte_errno;
>  	if (!init_once) {
> -		node_mbuf_priv1_dynfield_offset =3D
> rte_mbuf_dynfield_register(
> -				&node_mbuf_priv1_dynfield_desc);
> -		if (node_mbuf_priv1_dynfield_offset < 0)
> -			return -rte_errno;
> -
>  		/* Setup LPM tables for all sockets */
>  		RTE_LCORE_FOREACH(lcore_id)
>  		{
> @@ -210,7 +206,7 @@ ip4_lookup_node_init(const struct rte_graph *graph,
> struct rte_node *node)
>=20
>  	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
>  	IP4_LOOKUP_NODE_LPM(node->ctx) =3D
> ip4_lookup_nm.lpm_tbl[graph->socket];
> -	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) =3D
> node_mbuf_priv1_dynfield_offset;
> +	IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx) =3D dyn;
>=20
>  #if defined(__ARM_NEON) || defined(RTE_ARCH_X86)
>  	if (rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_128)
> diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
> index a9ab5eaa57..dfa4382350 100644
> --- a/lib/node/ip4_rewrite.c
> +++ b/lib/node/ip4_rewrite.c
> @@ -259,19 +259,16 @@ ip4_rewrite_node_process(struct rte_graph
> *graph, struct rte_node *node,
>  static int
>  ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *no=
de)
>  {
> -	static bool init_once;
> +	int dyn;
>=20
>  	RTE_SET_USED(graph);
>  	RTE_BUILD_BUG_ON(sizeof(struct ip4_rewrite_node_ctx) >
> RTE_NODE_CTX_SZ);
>=20
> -	if (!init_once) {
> -		node_mbuf_priv1_dynfield_offset =3D
> rte_mbuf_dynfield_register(
> -				&node_mbuf_priv1_dynfield_desc);
> -		if (node_mbuf_priv1_dynfield_offset < 0)
> -			return -rte_errno;
> -		init_once =3D true;
> -	}
> -	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) =3D
> node_mbuf_priv1_dynfield_offset;
> +	dyn =3D rte_node_mbuf_dynfield_register();
> +	if (dyn < 0)
> +		return -rte_errno;
> +
> +	IP4_REWRITE_NODE_PRIV1_OFF(node->ctx) =3D dyn;
>=20
>  	node_dbg("ip4_rewrite", "Initialized ip4_rewrite node initialized");
>=20
> diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
> index 827fc2f379..83c0500c76 100644
> --- a/lib/node/ip6_lookup.c
> +++ b/lib/node/ip6_lookup.c
> @@ -318,18 +318,16 @@ ip6_lookup_node_init(const struct rte_graph
> *graph, struct rte_node *node)
>  {
>  	uint16_t socket, lcore_id;
>  	static uint8_t init_once;
> -	int rc;
> +	int rc, dyn;
>=20
>  	RTE_SET_USED(graph);
>  	RTE_BUILD_BUG_ON(sizeof(struct ip6_lookup_node_ctx) >
> RTE_NODE_CTX_SZ);
>=20
> -	if (!init_once) {
> -		node_mbuf_priv1_dynfield_offset =3D
> -			rte_mbuf_dynfield_register(
> -				&node_mbuf_priv1_dynfield_desc);
> -		if (node_mbuf_priv1_dynfield_offset < 0)
> -			return -rte_errno;
> +	dyn =3D rte_node_mbuf_dynfield_register();
> +	if (dyn < 0)
> +		return -rte_errno;
>=20
> +	if (!init_once) {
>  		/* Setup LPM tables for all sockets */
>  		RTE_LCORE_FOREACH(lcore_id)
>  		{
> @@ -347,8 +345,7 @@ ip6_lookup_node_init(const struct rte_graph *graph,
> struct rte_node *node)
>=20
>  	/* Update socket's LPM and mbuf dyn priv1 offset in node ctx */
>  	IP6_LOOKUP_NODE_LPM(node->ctx) =3D
> ip6_lookup_nm.lpm_tbl[graph->socket];
> -	IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx) =3D
> -					node_mbuf_priv1_dynfield_offset;
> +	IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx) =3D dyn;
>=20
>  	node_dbg("ip6_lookup", "Initialized ip6_lookup node");
>=20
> diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
> index e157964c6a..d5488e7fa3 100644
> --- a/lib/node/ip6_rewrite.c
> +++ b/lib/node/ip6_rewrite.c
> @@ -243,19 +243,15 @@ ip6_rewrite_node_process(struct rte_graph
> *graph, struct rte_node *node,
>  static int
>  ip6_rewrite_node_init(const struct rte_graph *graph, struct rte_node *no=
de)
>  {
> -	static bool init_once;
> +	int dyn;
>=20
>  	RTE_SET_USED(graph);
>  	RTE_BUILD_BUG_ON(sizeof(struct ip6_rewrite_node_ctx) >
> RTE_NODE_CTX_SZ);
>=20
> -	if (!init_once) {
> -		node_mbuf_priv1_dynfield_offset =3D
> rte_mbuf_dynfield_register(
> -				&node_mbuf_priv1_dynfield_desc);
> -		if (node_mbuf_priv1_dynfield_offset < 0)
> -			return -rte_errno;
> -		init_once =3D true;
> -	}
> -	IP6_REWRITE_NODE_PRIV1_OFF(node->ctx) =3D
> node_mbuf_priv1_dynfield_offset;
> +	dyn =3D rte_node_mbuf_dynfield_register();
> +	if (dyn < 0)
> +		return -rte_errno;
> +	IP6_REWRITE_NODE_PRIV1_OFF(node->ctx) =3D dyn;
>=20
>  	node_dbg("ip6_rewrite", "Initialized ip6_rewrite node");
>=20
> diff --git a/lib/node/node_private.h b/lib/node/node_private.h
> index 4fafab19be..7fb2aff0b8 100644
> --- a/lib/node/node_private.h
> +++ b/lib/node/node_private.h
> @@ -13,6 +13,7 @@
>  #include <rte_mbuf_dyn.h>
>=20
>  #include <rte_graph_worker_common.h>
> +#include <rte_node_mbuf_dynfield.h>
>=20
>  extern int rte_node_logtype;
>  #define RTE_LOGTYPE_NODE rte_node_logtype
> @@ -26,28 +27,8 @@ extern int rte_node_logtype;
>  #define node_info(node_name, ...) NODE_LOG(INFO, node_name,
> __VA_ARGS__)
>  #define node_dbg(node_name, ...) NODE_LOG(DEBUG, node_name,
> __VA_ARGS__)
>=20
> -/**
> - * Node mbuf private data to store next hop, ttl and checksum.
> - */
> -struct node_mbuf_priv1 {
> -	union {
> -		/* IP4/IP6 rewrite */
> -		struct {
> -			uint16_t nh;
> -			uint16_t ttl;
> -			uint32_t cksum;
> -		};
> -
> -		uint64_t u;
> -	};
> -};
> -
> -static const struct rte_mbuf_dynfield node_mbuf_priv1_dynfield_desc =3D =
{
> -	.name =3D "rte_node_dynfield_priv1",
> -	.size =3D sizeof(struct node_mbuf_priv1),
> -	.align =3D alignof(struct node_mbuf_priv1),
> -};
> -extern int node_mbuf_priv1_dynfield_offset;
> +/* define internal function used by nodes */
> +#define node_mbuf_priv1 rte_node_mbuf_overload_fields_get
>=20
>  /**
>   * Node mbuf private area 2.
> @@ -60,21 +41,6 @@ struct __rte_cache_aligned node_mbuf_priv2 {
>=20
>  #define OBJS_PER_CLINE (RTE_CACHE_LINE_SIZE / sizeof(void *))
>=20
> -/**
> - * Get mbuf_priv1 pointer from rte_mbuf.
> - *
> - * @param
> - *   Pointer to the rte_mbuf.
> - *
> - * @return
> - *   Pointer to the mbuf_priv1.
> - */
> -static __rte_always_inline struct node_mbuf_priv1 *
> -node_mbuf_priv1(struct rte_mbuf *m, const int offset)
> -{
> -	return RTE_MBUF_DYNFIELD(m, offset, struct node_mbuf_priv1 *);
> -}
> -
>  /**
>   * Get mbuf_priv2 pointer from rte_mbuf.
>   *
> diff --git a/lib/node/rte_node_mbuf_dynfield.h
> b/lib/node/rte_node_mbuf_dynfield.h
> index 4db5382f91..0b22fbf718 100644
> --- a/lib/node/rte_node_mbuf_dynfield.h
> +++ b/lib/node/rte_node_mbuf_dynfield.h
> @@ -40,6 +40,15 @@ extern "C" {
>   */
>  typedef struct rte_node_mbuf_overload_fields {
>  	union {
> +		/* Following fields used by ip[4|6]-lookup -> ip[4|6]-rewrite
> nodes */
> +		union {
> +			struct {
> +				uint16_t nh;
> +				uint16_t ttl;
> +				uint32_t cksum;
> +			};
> +			uint64_t u;
> +		};
>  		uint8_t
> data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
>  	};
>  } rte_node_mbuf_overload_fields_t;
> --
> 2.43.0

