Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8CC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5236640E0C;
	Wed, 25 Jun 2025 13:45:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A5B4C40677;
 Wed, 25 Jun 2025 13:45:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAWeoV002188;
 Wed, 25 Jun 2025 04:45:06 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2131.outbound.protection.outlook.com [40.107.223.131])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gfewg3rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcg25E/8wivgoRINqUh4KEYEfc94OO5izdwf9WFMY1abwE+vfceHvTktfX9CAW/PMk4tmqua34sS+VboJ7PIOyocL3YBd0M0o5PvERa8bE7/QD8WEIlCnYFVtmkJ8Nm0vkEv6rkCR0DfDtexXBmtSPTVZ22Y8KHz4c0rwm6ubL5IaWdR1uuNQxJJzDetUqAI0dblznG/P4Zb8kjrhkYLVTNUYFMjxXDzSunYlluSCblqj/vFwIok1d00hEJD5YlfskLyrZg0/st5DbqHgF26ckcnXD64jS9XRyq/epW3pOYtml9d10Xw1vPHOf8Chh9MsvmD7kYg6Eym/alApDSFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8fRUb51Kq9LwNQ/qVPyxvzPhhBZ3cNt73KDMz0VzIE=;
 b=qt9dbqXrrpbfu/6fiKJTcreW7iClYWmIqQQvEewzTVpvjBmod7z4dhnBWPhisVNvDHYTAWtj+QA4czasx5+osdcnAl5SfJ+FIJavSgX4b7P4FYNaJlbaMFGStJL+eXKEkbU39Gh/4iE2+aDbG0o2qP6+rCz41xwz1OTlqo9jXLmJqbQ44T0dMZNImLPhyKZHiSJRbzVDMhQBoD2t7CEM8huXh5bTAcbuc/vzvAuDqSYFPq5klH5nnEQmkw5pEeYd3XWk+ORwLEVN5n2zrLnnXXq+Vs/hZBm4OuXjZiXHK/zHvQjQbTg4xaL2u+99xYLUxcBNx8TK8+fwvFS2wCaLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8fRUb51Kq9LwNQ/qVPyxvzPhhBZ3cNt73KDMz0VzIE=;
 b=dsLGejtgzmCcAjQ9eZbnPb3UhCGQmzpcKfbFPY4XvYNbbOaj4p8eBVe15Ebqa2bft/Vb80tntLNdG63FUEYKO13z9aB1akDlSZLL7/gpT4q+IU6rzPyKEfio9JaQ4gM/8xJYAamB8o1JMq9Q0rl3WAqj7Ryf573hEAOY7ZAMTIE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5051.namprd18.prod.outlook.com (2603:10b6:8:43::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Wed, 25 Jun 2025 11:45:04 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:45:03 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>
Subject: RE: [PATCH 0/3] fixes and addition of aes ctr test vectors
Thread-Topic: [PATCH 0/3] fixes and addition of aes ctr test vectors
Thread-Index: AQHb4FAa1B3qzlaJP0Ky3GWhPrf8RrQTzHTA
Date: Wed, 25 Jun 2025 11:45:02 +0000
Message-ID: <CO6PR18MB44846E13310C118B9BB0D82DD87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250618125410.767919-1-nkaithakadan@marvell.com>
In-Reply-To: <20250618125410.767919-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5051:EE_
x-ms-office365-filtering-correlation-id: 8a4d2006-c9c3-4791-b961-08ddb3ddb914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XMqeT2JK0eMwzw5d7Sf8gCTlZfAXL55tjI/pVxgn7BQ47NmYfL70pzLLSzlZ?=
 =?us-ascii?Q?RmXukj5Cd7lEFgSDSFoCWjIh+iSqO4DzfhrTBp/crPFiquZ2eEiZgJmidEfW?=
 =?us-ascii?Q?BoasFFi/O4Q8pdfBezpPocWGs3XhtZnaL8bhdEuVpzQ+3/F5ewg1aQ4wj4L7?=
 =?us-ascii?Q?ItqGX29xxN2Ylrzip4sDyL0uHkUtKJsS8ypNzWjh/0qmriiTsXLoIlR5GnyL?=
 =?us-ascii?Q?8bzMIT/l/BJL1mPGJbXjpmfjZr/uTHW1KGm3WzKWiVJg2aSoiqp8xmoCUqBC?=
 =?us-ascii?Q?EtSUpNZWa+zd5/DFp7XSLje9ISCIPj0SSh0qW9GTv3rO6srs7gyWGYXlW03D?=
 =?us-ascii?Q?1shdhezlcyEeKywYf13xMtGlDoPCmadNbzvNUcV1dGs4fZ54lRQ30GfQIFxS?=
 =?us-ascii?Q?9rRTrqgKb5QQ3fv+jlkwUICXX842A8kmYHuP9W910pcYSdr5wxcxLU1Z1CB5?=
 =?us-ascii?Q?RZAVgzWyl0N+36YY3BX2/WrcJh30b5a0LN24rMUjhq9Q2KJYP6dgGBXzrGO+?=
 =?us-ascii?Q?atbh0YFd2n1+a0X5hRItrWTkJ41DLxBmZwsaOxL7ap6DeyfmCKbapKznfy3+?=
 =?us-ascii?Q?ck+8L1DpBl7Vpvkbz42opWiaH/Q1JUTaO8jfPDQeIvlBwNTW39uUQ2qOe2rO?=
 =?us-ascii?Q?i7okyyQLd15pQPzJizORKiWNZQWE+43d9JmCmsc1EyLZUyTjs9ZooTCutx4Q?=
 =?us-ascii?Q?oxLBAKwxJt0XFyM1ARfAAn7kIhZqZECc/sF6AoiPkf8i6Ae/BVDGmpnpVsSf?=
 =?us-ascii?Q?k0f8migL5aT9GU2JHxUPbI852gvjSoUkoYXqdWUjCyaM4hkLEAFHKtJNwpDO?=
 =?us-ascii?Q?944P+3hQxkB3FtCL94Dc2ZMxPTggLgN0+EEGPKTJ7gaW3wR/qRWAK7rjRgU0?=
 =?us-ascii?Q?T6NUbRIx0uLfCXB2CYVqgVN7gOvDdIwXb69hQNx+mR7Y4P2IEN3Cnn1yNzBX?=
 =?us-ascii?Q?zKU05SxBO+ogEhg10UqWaNZ/2UP4fcb5tNhC7D037E3vBdT1qMAe6gV44i8N?=
 =?us-ascii?Q?xoV6DvbJ6Te9NCmQbxRYLo/fmvv+qyJ/SLIGP2iqdjujqt+M9u739/uuYhf5?=
 =?us-ascii?Q?jdb7UCiU9CJkwoWsHTubg+SAE1XePH/3UpiuvmLsuZbm21YegsxOOnCTIWWD?=
 =?us-ascii?Q?oLwId6rwtGVxL2MUdlPeOpg4GfoT5P6iTLOJfBKPyPf0Q2v9kS58pktgaCYj?=
 =?us-ascii?Q?AQE4jlr9wI0ifbZN6BIoPRi3i1GqDsb1NMMsur0QC/jtQqoP4zjCZvr0HY3T?=
 =?us-ascii?Q?swhWnit+7ttljTov6+aUYaPQDwnDTOodtH/zovKNNstUe1iT1iI0fLXAeh3m?=
 =?us-ascii?Q?6OIrpzLS/35HobDm14UTKp7yUXfpFkDVNK+CRN8E/zmcRp+Ctidi5i8Q6weI?=
 =?us-ascii?Q?DL09LwmhFcJbjanh09QBua0qZKjxdk+9VfU8IhZF0j77kLfWhjt0xtPUhfy6?=
 =?us-ascii?Q?PDFMorZSiq38aFXOHQXuUB/8xxOLZOg4/XeYxFVJz4eRMl3QG+7PGPDAD0gK?=
 =?us-ascii?Q?EmLM6OUJKWHTal4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezkIHRYpFjdkYAlzfy8/LLAVc82aWoxihunzCVqxSBMvyAVtG+T/G7nsOK31?=
 =?us-ascii?Q?cgraQqaBm5R8XDL2quUxzepeF1KwH4CfdDw99ES2ZOcFNH1Ur/0hgrG4qMdq?=
 =?us-ascii?Q?1SX/3hISHFbShVe2Qv2lU1auBW4n33Jz5TRPpRa01pHwqCO1aT02HU3JjIww?=
 =?us-ascii?Q?n8Gub5DOO8kyN1VeVSc74II/5aSHKRULWkskRyJbpOeXcksBIyKdiO9+tNFS?=
 =?us-ascii?Q?1o/+1k55kD4ovV1biLJKqsTQTvqkNsjciglj2R2/Y2+P4kZKKyvfA64sFCe7?=
 =?us-ascii?Q?J7eKwqHwI3awB120tVEQi+gr4yZd2i9BLASGdw31NcflRYwyfD64GJLDRgaX?=
 =?us-ascii?Q?6IrGr8ZSifI0IuJqbR8TyEXIU1iL0Uzj2YY9dtLkCbARChHulfsXroffUU2v?=
 =?us-ascii?Q?fzmOE1owQOgITRCL1UeMnoZVR/96eSTAlU9YKWlHydhUTfWP4KUKQPo867A2?=
 =?us-ascii?Q?cm2JQs1RPdboTs6Jm6z4BbNYfYyD5E5+c8X6Y1hBx9nKjC0mdWjKjVYxMr4j?=
 =?us-ascii?Q?8m4/VjSG6Yc1PCpBixAhJ+d+4ji+J2YIVxTn0sshzJgouACrGmRrUFmG5t4V?=
 =?us-ascii?Q?HyBCOONvEMotDmBVUTEiWmRmi4SCBVnafUbVqxrmuYRvUqB5ZrqTRpu/IX4k?=
 =?us-ascii?Q?k9Q5E7X1erk8gBOnMISLCZTXzCxdJqTMX5CkFFkItOk33ss8LCvPWmENZNT9?=
 =?us-ascii?Q?v3uKEVDdF+6v8JWgwadr7a8JxwQjbjPw15SKjgHlRDai2qiz4bhWrZ0QAHIk?=
 =?us-ascii?Q?6xGNXTrRN+GHCv1noBR95f6EAiIrY8Km+bGxItlfXMbdfN63nBtkmzhyaQl9?=
 =?us-ascii?Q?NQaHtQUbYjHhP9Q7rU3YVIi/pSPR4PP3y8bMuvWqNu3aYabpapPZJZ4Rd23w?=
 =?us-ascii?Q?mAwPZSx+w71JhImACRvXVuOZDlNnhT8YBEc5AGPLp8CGc6SgSFeeIEPngRR9?=
 =?us-ascii?Q?upiGZBsmgcIgeYWFDDLNqtclxYgJknVXa3BRvnQpxQ3UVlytqz/9VYfaVerG?=
 =?us-ascii?Q?KEgXSQNDMYb91lpuBNkXB0tYf1x+r9drbWASFjhiWLg589vOZdDpsuKKL/8z?=
 =?us-ascii?Q?sH+tw2TLN95Kh4vb/ucbMlXXSU0xwzX8NqD8N0I4JI5i3uIxcN2j8HazlSA9?=
 =?us-ascii?Q?yqm1GE1QKDuZ6OgoYRdufmx/RlGgQQLEzRfv2klWT8Zo8VpjXaM8ok9QtIf2?=
 =?us-ascii?Q?NFLI9Njf8W151LkAbc2AgRhgO9rts24723tQ1zRPjcJxj4+aVPchzp87l3A1?=
 =?us-ascii?Q?nPsFVKxpIQWvIH+S4wZA6isYTQjQKtxtQFtp0iJyuOXY3SjrtN97U1ToJMqt?=
 =?us-ascii?Q?n8iopXg/LnqHCOjrXNZ09RQryLMlbcdASDAWPpJ/ah2s7SBCfxHvYqNiC5Fx?=
 =?us-ascii?Q?Ufcv+kjrI+OzA9iieudkvk6rSScB74pGrvZlQcFTaYX7sfuOp1kOw6OsRhLN?=
 =?us-ascii?Q?ycgZdOhrkXD5KNMhdaNk0NQ6sH/6hbkILBQAtUTsn3ZFQy52wDO4HX0VF2uF?=
 =?us-ascii?Q?lankQ+wJgdptVZkOwdgkP+9ArukVmLAeq5XA10ghvuwAsD8NzgidU2rbtrHd?=
 =?us-ascii?Q?Mqo+k1rzGNz4xbVYL+w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d2006-c9c3-4791-b961-08ddb3ddb914
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:45:03.0208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYfR7sKFDtDudySrACFRlSwesMeMHAkklHNMRsIEB4JbqpL/zYo18UtTkGfOfr2ugHwLSYNqU1I41ZYA0CQvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5051
X-Proofpoint-GUID: Jnqep-pWZjCAn_UpBcwR2pMADHIckOdv
X-Proofpoint-ORIG-GUID: Jnqep-pWZjCAn_UpBcwR2pMADHIckOdv
X-Authority-Analysis: v=2.4 cv=eozfzppX c=1 sm=1 tr=0 ts=685be142 cx=c_pps
 a=1MBqgszBUERISr+GSujF9A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=jdubWeEOfiufmxvQYZkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfX+OQ8UCLBxckd
 4pIRm0suzWR3AgJU3oSSrEw6rPVSZSp6d6reWbSFwAIm6L3jp2kfK78a/Aq3vdbp9R3L4gjBInG
 1GZzEE95G/hKRXOSBGS4/1Qfm6SRfyT/wkecT4Lv0hbSdQb3v4sMJrsfPy3OvjjppaRIwVnyc0I
 l9l2m/eqrL18n8AeeNJHOU3N9ntxQGL6jkxiU6I4HX1B8DPkMMKWnjybg4IpHYxVozl4ZLOkfSD
 dHlvhR0iTrPY39Pb12jXyjMhEljHZXMLXFp8D6hkGmjPwfMN1eVtLxgH+wOClwqGU0SPbbHk+wJ
 FPKgsdtMzsWTTKHxqgHKLjdM4RzB6U4yGpTyPXXKIj1/Whc0pler69MKAA64zgttcDAgwFMnj9V
 aXJpMK81Wv3Let7Zf5dCHKioW+Owit2sSCEfHjiVzTCT7x5PLEG5xBRj+VKnqUfkfhJEVwpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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

> Include AES CTR test cases and resolve test failures
>=20
> Nithinsen Kaithakadan (3):
>   test/crypto: add ctr test cases and vectors
>   test/crypto: set iv len to 32B for auth and cipher
>   test/crypto: set ptr to null post crypto op free
>=20
>  app/test/test_cryptodev.c                     |  36 +-
>  app/test/test_cryptodev.h                     |   6 +-
>  ...st_cryptodev_security_ipsec_test_vectors.h | 316 ++++++++++++++++++
>  3 files changed, 356 insertions(+), 2 deletions(-)
>=20
Series Applied to dpdk-next-crypto
Thanks.
