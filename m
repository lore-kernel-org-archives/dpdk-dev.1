Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A9CC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65D4A4278B;
	Tue, 17 Jun 2025 23:17:31 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2F9D5400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:17:30 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCAT1Q001262
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:17:29 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2092.outbound.protection.outlook.com [40.107.243.92])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b84t99gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/xfUeoN58IJVGDLfN6vDo45qcTFdXr+81v7RFFwMjyFv5zbHIPbK2/mKnIrJ4IrtXEMGyFYYYDZ7AX2TkrxbsWk196SWSI6m4SsLtv+ToImO9cQeOP6dR1aIMfL/xtK88OTZnGhZVOryGXiTgyVxJlzgBgw1wj49rZJzVlQq39ezDNOGw/h+cug/w2ZWyhN3mVEklYZ2FTm/4s/OG0KCz68UAAJSZRuxWGy3Emgi891fEqv2F7YgfodhyeAre3T9pWqwVpSems5b4TQmZ7Py4z0DjkX68SpJkJY18IZceasSVg47WCXzFGQTyTURuSuNAcF8i8oa+ZX0ZTThvaHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzYDoRZzQVYS9TQIZkoHiyLi9g+ImmZ7ZW1KOGIRA4w=;
 b=goW68WUJTYrnyukZWpQ8IsJ8s4NJLPvGLZbPMRQKe/kjnpvwI7wxiJMss3xgEKViFJIYNRV1bg09KWa45AK/4OhTyU1sBf95Ve4K0WKuOLIaZoS3ezAxmCy3/rp6zYfPvQvqBlH/xkN/D8dDk4RoaIVs8djm1OQe1Hn1benv4Sp3DW4vGt3j3QtDdDNxjMOKxpb83A17cKNUaoF6l8wzSyS/XDd10QJVavMqSGRXpNwNgBOq965n2TukWlPX09/0ZeE0Df4wsxS335/Phr73iqaOPVb2UZ2hLu/ljy2g4WSaIxbyI9ycVfkjqzbGu/UQuPBGNmk20LqtiSC4ozhsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzYDoRZzQVYS9TQIZkoHiyLi9g+ImmZ7ZW1KOGIRA4w=;
 b=jbCNZMZQOKLLQwz1Tjx7CXwoVixvySDPgyjt+C+TUpA3LzEGTc6nhgQFpbYEq8GgN1g30fagxdS2hLn1x+x+4i0ybgHTIEGg4f7HvtCN9j4lFlsv4UpeWPQVt0OrrT7lc0E3/coR6AclplJp6Z8akcufGsrtxMWSz/sqjLtoA1I=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB3983.namprd18.prod.outlook.com (2603:10b6:806:f7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.19; Tue, 17 Jun 2025 21:17:27 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:17:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, Vidya
 Sagar Velumuri <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 0/7] fixes and new features to cnxk crypto PMD
Thread-Topic: [PATCH v2 0/7] fixes and new features to cnxk crypto PMD
Thread-Index: AQHb2Sr2KAtvoAE/9kiuLxf+5izlTLQH6AVQ
Date: Tue, 17 Jun 2025 21:17:26 +0000
Message-ID: <CO6PR18MB4484E418785B26D47734A0A6D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB3983:EE_
x-ms-office365-filtering-correlation-id: 4ed3e974-9897-4db7-4029-08ddade45c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NVxmZDbanjwUAqV6t7/QA9mX70eHMvFwtNSIjSqx2ImX8N2tYqOszLPW+NF/?=
 =?us-ascii?Q?0J8kyjuMvN3eFsoII9oHYu7Kb2opE78jOrvl4/Z7KJrDLpPuk1t9GO2DXyCI?=
 =?us-ascii?Q?Ro6JwvBZzdcqMCnOlb5xFJq0uRzHhhrGcDkLN8QgiwdO9M6jExWVJRDw9BsU?=
 =?us-ascii?Q?Tnh9arInC2sCTEf7umbR+qd9ZVPNNMlI4ZaD0AXcIEBBGEvmp4SRt7HOoE3J?=
 =?us-ascii?Q?arcJznSERfeEg2lxv2OhXUG1DxZ5gUR8+0nkMLtkzgKFDi7AIsAyYR/4ed9O?=
 =?us-ascii?Q?C7FtUtEsdRVTdjR5AXpTp+A2oRu4rLvq1LZOib1m16QORebViKBbsW638oQ/?=
 =?us-ascii?Q?Evf/l3wIAmCF+eGdubgIfKEz+zCUTMdeIXgB2X75rNcsf7S1+SvyPqhKx8fX?=
 =?us-ascii?Q?6kxbNSj8e7yQuydl+kwkEcRJPZoNnioBsVH2blJh1TgHbVEbkMXdU1yrY9KX?=
 =?us-ascii?Q?frch1TdV60RycodC/tD/s8pVGegd+oEljsCNRUqaAlSMNbBmhdkXdKVdWxPh?=
 =?us-ascii?Q?WBkNNf6NiWlWRip3DOb3MvRAWuh83Ij8tqnn7agMGdd1iA0aKkgoT0m0h6yR?=
 =?us-ascii?Q?yIp3NUyULiLv0XG03d4VlUJ0aAT67eVl4iXAUloQG8VSGeZ0/QKYRadYeYTX?=
 =?us-ascii?Q?hEnHTrbtC3EB43mu9UP59MAj55AQu2RZPM5XmC5unjwmdCuYZmLKH+AKYTv0?=
 =?us-ascii?Q?eMXfUN1qmqRa0qhfRVfGSF8+YWKwKwdKSvo/PXMVtCa9pEVS4kixKGH23tFU?=
 =?us-ascii?Q?O/EtVyyF08J1xutjByTjWzc4Hw0fRdfL23BydGXk4ee5Ovz0ZnLA7lidrFI7?=
 =?us-ascii?Q?fIuXxX2bJHXsMIJlBciqSM6JNvqaXxU/5lj2So1co58uEs6Ju18QuGBvosCN?=
 =?us-ascii?Q?4ktdNr+fszwYEPrWPOtUnwate9uX2vl4FCXRE3OT3QCs+hNFA9F4cnIKwWCX?=
 =?us-ascii?Q?M6oymxhZjJpg2EMWkKWYCF79g1lANoa656ceu1OnlLlOdOu6mgUlJu/lq4hY?=
 =?us-ascii?Q?hGmtXaOqheTmzs/RknmGIThZySUzlsrIAHd3JeW7R2DoqpQyq/9T0QKrpMAE?=
 =?us-ascii?Q?W8JQPXAlwllCecE/+1suqL7yaVc5OUdvhjO0Im7lQXroPSa8j2G6QAqSzRzG?=
 =?us-ascii?Q?E6MM2XQ8pSD+SB350qOt3oL8kaUZmorNfa8uuJcfuyPlklFNniWNpQjQnahK?=
 =?us-ascii?Q?TcHFHClY0q7xTvATXODF7hmyFRZq8TE/hmFW1URTbVymO8xLcfSyjFeGbOaD?=
 =?us-ascii?Q?X/T8W/nQMI3iML7obMtnmzzJ7t4J3xpRXlWfArrUO7KnCj+jpr4vnzaFuWrH?=
 =?us-ascii?Q?zBWZkpKcSS4AD5ioLSszFIhDlufZJ28SuXLU1tiwdI4ROhN1mSrNa7Fv76fT?=
 =?us-ascii?Q?rsRoNNrJdxMLvnz+n2wKpd44qhEDLAkOIDdNTpQ1SrntCQ1p13aw7l97BHrm?=
 =?us-ascii?Q?mxotw+qFnQ8yns7VGMUNNg51hCtjy8fScUQz6D/1XIvaNlx8vZ3a+E7cdMit?=
 =?us-ascii?Q?A43wXFpKnI9Pe3o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lix5z4lAkMPkg3sL0epShTkTxNczgFaWnuQ49ZpFXmtSscWWOh2C/7KQTuzu?=
 =?us-ascii?Q?AOUOzWQcHkzD3BLyr5DGnEZ/+DMmJKmfkpVJETHportSiURlzV33itApd1WW?=
 =?us-ascii?Q?9JFIgfTqVsXHhLFZlrY2IZksFlnPmzSe7jlAoVB7c77cbVP1BG65wbyumz8N?=
 =?us-ascii?Q?wa/WhoQ5RDhSTJmd7TOz77d+FY8jhbRDVURdRwZKV7XVSGonBVBuHRsHtFl9?=
 =?us-ascii?Q?fObBmLOErpcOncLNuLSldZLniYpAKe0m8pUg1t3lG5lE9Ko3kPDVUUQn7bvT?=
 =?us-ascii?Q?Nuicrx7i9K1Zid6c0IOzjUdtbvNNWc/NF6/Fq80Qp3BX4120+w/G6tNeVhiZ?=
 =?us-ascii?Q?q4Kgvd5LZlKNkEBcRfCSr7zZ/fV0gmmz/B/YrNYjDaSR5vA7Vkha7qF/dMBa?=
 =?us-ascii?Q?fOPxH9fRLhU7y7xHxbOFjEUX4FiSWLuwjpOg8tYF0Hw/Xz9kHl6gfvpJ+Er9?=
 =?us-ascii?Q?fushKey8KC02MZ4xFvCnJKhLfCMWC5Q4eIxEFxOswgUTCZKsPPPgwMUnrZCL?=
 =?us-ascii?Q?P2Qsn/ixN8iz4chxoKI8w1igxy7o4YD9kGWvTw9GNV4MKy+VZW1gSSzaYOhJ?=
 =?us-ascii?Q?PWUxwYoXjfuGZdXRg9cbWjT0VlPxdWzHioF7j+kzp28yMAmL3FbdbJ22kpFK?=
 =?us-ascii?Q?iElh3thA5i6HODo9zlpXhi1o2Rn6XJqgONgIxnSbKVeSkx9phdPFHnIIQtv8?=
 =?us-ascii?Q?E6lK7oUvZhlv8dyyIeFfvpp6f/fykW4/JYPm0fUsKs6QCFaEZqPJMlxkkPYv?=
 =?us-ascii?Q?91fDtFQ1/BywEgPPPOLP5p2qXHibL5aoq6VsksXyslpPoEhAH3Hp/wqcMyU6?=
 =?us-ascii?Q?A3QjFI4gl6d7F3tbI0QF07o4Is9g8GDvEPoYW1+ESA6JbUe4dCBPSN/N0D3Z?=
 =?us-ascii?Q?369+7batwYG85Kpg7e+CKNeRDSlvpRiei5OqXeApERAtjYHWvswtkqw0h8w8?=
 =?us-ascii?Q?Bo4Fzt+uQlz2zsSrhvBJGM60XTxpxFX2SFO+UgPMNIfYCYjo50kflW1Q0MWR?=
 =?us-ascii?Q?2fD54J5axBYa4xEPJsBqY78j+FzlFaBoWgSIeILK3TffdHlY2YFUjwhH0j/5?=
 =?us-ascii?Q?Zgjb1Q8NNFDZH0a0qFQ7GN6Y+ycNRE4SwI0Z9Otl1SQN0OjmdL7V6tkL66OI?=
 =?us-ascii?Q?yJbzivrJtLi66bRkqh5/mA+8X95rf1hOU4tsQoQ0TkrSzVyEPRn4fKMuIVDZ?=
 =?us-ascii?Q?8D3jOhsoMvLGkNslmwKFujsweB2sdxceoVIEEjDNIiBaZKUG8tI3pDY0SV9P?=
 =?us-ascii?Q?epYerF6UieyvthZ75W3toJb1WJ2VYdKxkOI79K/32IFcM725IrwbH/gwM8La?=
 =?us-ascii?Q?77grZRCWIMXgaWmQGMtb2NuLgsQKeal2XdKDqxAeVBhzYL7ti9ZzrY8ijr2i?=
 =?us-ascii?Q?XiFaauzQgd6ZBTL66163Vs0EYZLy9bTG8ImF6q4gZwvr726i1gVwx+ID4NdO?=
 =?us-ascii?Q?XUwysd9XxARzMyppK1pKGqVo/wJ2te+ho0cMsX8iHDDZ6k7gz6atlOzt62wG?=
 =?us-ascii?Q?qSTNRjSHy9Hq4K03ryEHB2QrUlPpMZDWowGg7cQ721d2jIzK9vnRItSU5vYe?=
 =?us-ascii?Q?RaMPGR9CluJ/J4EQmyg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3e974-9897-4db7-4029-08ddade45c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:17:26.7078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Re5gYKm/b3wqKkP70xZFhcZgis7ULZhQaoczc3LbPbXqFzNfkMgHyTZH8F8MBfW5B15z912Nr0DShzuYt5IRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3983
X-Proofpoint-ORIG-GUID: 85QcXJo16ijrWej2irbmfrkrcZJlYmJG
X-Authority-Analysis: v=2.4 cv=H6Lbw/Yi c=1 sm=1 tr=0 ts=6851db69 cx=c_pps
 a=HGjasvFHzMdR1ocvxAZgcg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=KU6agz3Ma7LEzviDyzYA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfXyyoX4TQr1UQU
 VuhY32byR8ZkrcvQEY49hftSSWVdnsne1J2Y9FCsWaJ5P4LfLpC+LmSlG96JkOD+BXaQtKDA3Sa
 sg6n9/qJfVU2mejpWGiU/ggYPrjRLJIRbPsK7dwRFAKWYmJiyhedRyyq8LMiAN0jK4I0E6qqeEj
 jbK/xkuj9luIPXqF+G2G050fnAhB0CWKzXZw9K9Al5jalK3qFn0yjy/UkAg47U4sl/2up2qq5rO
 7FMlBisTTxeMjj8vt7bLVEVeSqUnY882u7Ko4O+f1Jt/KMWP4ygtwbI9p/hATSaqwY726kHKfVk
 +5UFNGd+P4VVjtlRthGFoEA/ovOgqkqPkLaXKVQ8696O+kfC7DD2WKiJCWMxb7idgg0GLQDzFir
 e25WzDVii4AFblTJ/pjf4RUqZO8fJ1fEKI/dujN3b6YISUEur0RRhyoj4Ka1JS5edM7ctqSh
X-Proofpoint-GUID: 85QcXJo16ijrWej2irbmfrkrcZJlYmJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Monday, June 9, 2025 4:11 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Nithinsen Kaithakadan
> <nkaithakadan@marvell.com>; Rupesh Chiluka <rchiluka@marvell.com>; Vidya
> Sagar Velumuri <vvelumuri@marvell.com>; dev@dpdk.org
> Subject: [PATCH v2 0/7] fixes and new features to cnxk crypto PMD
>=20
> This series adds fixes and new features to cnxk crypto PMD.
>=20
> v2:
> * Combined few patches into one.
> * Updated patch titles and description.
> * Updated doc and release notes.
>=20
> Nithinsen Kaithakadan (3):
>   common/cnxk: fix salt handling with aes-ctr
>   common/cnxk: update qsize in CPT iq enable
>   crypto/cnxk: copy 8B iv into sess in aes ctr
>=20
> Rupesh Chiluka (2):
>   crypto/cnxk: extend check for max supported gather entries
>   crypto/cnxk: support asymmetric sessionless mode
>=20
> Tejasree Kondoj (2):
>   crypto/cnxk: fix compilation error
>   crypto/cnxk: add meta variable in CPT structure
>=20
>  doc/guides/cryptodevs/features/cn10k.ini  |  1 +
>  doc/guides/cryptodevs/features/cn9k.ini   |  1 +
>  doc/guides/rel_notes/release_25_07.rst    |  1 +
>  drivers/common/cnxk/cnxk_security.c       |  8 ++
>  drivers/common/cnxk/roc_cpt.c             |  5 ++
>  drivers/common/cnxk/roc_cpt_sg.h          |  1 +
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 91 +++++++++++++++++++++--
>  drivers/crypto/cnxk/cn10k_ipsec_la_ops.h  | 17 ++++-
>  drivers/crypto/cnxk/cn10k_tls_ops.h       | 10 +++
>  drivers/crypto/cnxk/cn20k_ipsec_la_ops.h  | 17 ++++-
>  drivers/crypto/cnxk/cn20k_tls_ops.h       | 10 +++
>  drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 77 ++++++++++++++++++-
>  drivers/crypto/cnxk/cn9k_ipsec_la_ops.h   | 10 +++
>  drivers/crypto/cnxk/cnxk_cryptodev.c      |  3 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |  5 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |  4 +
>  drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h |  3 +
>  17 files changed, 247 insertions(+), 17 deletions(-)
>=20
Series Applied to dpdk-next-crypto
Thanks.
