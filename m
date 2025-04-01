Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80292C36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 10:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579C340DC9;
	Tue,  1 Apr 2025 12:24:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BA5EF4067E
 for <dev@dpdk.org>; Tue,  1 Apr 2025 12:24:46 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5311n0DT005476
 for <dev@dpdk.org>; Tue, 1 Apr 2025 03:24:44 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45r6t88uap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 01 Apr 2025 03:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8RFkX+ktg05TXDAOBUdJXZAAtxij5AVUjHgs29WFYSzr2WpUwKzI4pd5vK4IugOUQyHUhKZcskyXzxK6Gvrcg9NSNWcZj028nDVRXN5DUG01VhV/8t30EgYpGIIPaIcczcgg1vZeS9G/xAZgymIUqdGTW74dbWtKtjyY8S/HuvrfTdnrOzqLsWBYVRAsljfJWvdFc2BHL+f0Wwe92KHN/W2E9X/qEIQA/F5hRqq6p8dCOD7u/T1WV1c/xH+WYzI/fBF6G8yIiN0cWO6QB6BRyPjTpBjGmsCpv5k2ygOwPjNqw5gi0G4U3H+2QwvF00AlaEUtjkFPXOQAQSCanwl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOEcFs2l+4hNBxQvseKaHJPbKly33nkbSU5RVvF9po0=;
 b=OaTGghUP7F4YA32VAvkA7dNfkFbnUEyKqlnhYT/Vt14aTGXl+niT+A3hM6ITCXjD5khLe0S0FRao+cKUEoSrrgObAOguJgXpUjs2ldikA2CeeG43zSxGnbyEsjOBOuTd/gFf+4XjJp1zr0QoYq5UWjZfZz4s9Q2JKQReWPcOvhS4crI8ebi5hrEc/yV5sFimD1pKD0/ove+2XE0VkaBJe23T05inNeNKonGTmkyS0QWL3OW6kcua6QzTMzjihuUXoVRyUyAEoX72Sns1ph/qmnkfUP2U3mLirdJY7XxBs+lzPVJleO1GoorcFAkviiIUBb+pJNPcHnP48QQq5EhYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOEcFs2l+4hNBxQvseKaHJPbKly33nkbSU5RVvF9po0=;
 b=O4XOMvjlTAizahLGZV3ExQzP+vHzMtEHZ5g0MJRjORo9Sr8etC6Jb1pBWqgr5JAg9stUe9FkDRKP7x1PLGiTDy+JVSwnnCK+3eRtmzlEHe/7BpzM2IPXWAqEMKB11zWejlw/ORHqBRHunJqoIeq7/ioyD59DkfczdbqXd76ylBk=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by LV8PR18MB6231.namprd18.prod.outlook.com (2603:10b6:408:258::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:24:28 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 10:24:28 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Rahul Bhansali <rbhansali@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: RE: [PATCH 3/3] net/cnxk: update IP header of reassembled packets
Thread-Topic: [PATCH 3/3] net/cnxk: update IP header of reassembled packets
Thread-Index: AQHbmkikJUnk0v2A9EuYHcT2jD32RbOOq8CQ
Date: Tue, 1 Apr 2025 10:24:28 +0000
Message-ID: <BY3PR18MB4785C6DBA5799DC34B3CD3B4C8AC2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250321100343.1081664-1-rbhansali@marvell.com>
 <20250321100343.1081664-3-rbhansali@marvell.com>
In-Reply-To: <20250321100343.1081664-3-rbhansali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|LV8PR18MB6231:EE_
x-ms-office365-filtering-correlation-id: 0152b646-eb40-4a0c-009f-08dd7107623b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TBU8AJR/wECezmkuU+kT79VpS4lt68GpHwE3bwbyGKKylXtif/tKbm6Udl0J?=
 =?us-ascii?Q?gQLTN4lDikzBTQ/nEVlCViAshApOt24Nn3dDBtPpYo+M2s3Oyr+855BZtiCI?=
 =?us-ascii?Q?BIyefhpL+1sAs7zSOY4kc876Rvcek9jdmXv9EFOWn8/67GkDohQOFA4ok0EC?=
 =?us-ascii?Q?hgu9GkOaFp6gnZb//B+Nfdj0Tf4v+bUGAcUGpUrdLKazxXgtDw8uIaYMo5ad?=
 =?us-ascii?Q?HgGJnZHZsUvjZVUqaG5o/vNq7S72LkbtaN3X7dI6alcoyuVy3X9IhRpKaR+2?=
 =?us-ascii?Q?D5/xiWzbk2aMNGWRw3ZKuIqyRIMDbkQsmINdUACpetAzx/m/MaazOHmHr4b2?=
 =?us-ascii?Q?icwSTUlEsgKfA4sc2SdewIG6qAVUQbAvCdpmB49P1MsNqbnvW3I0zKytOP1Y?=
 =?us-ascii?Q?YkZGymneMYJX5b0fYIay26Kdq2gWhVPEyZM6lsbBVBl8goENko6ax2x14BVI?=
 =?us-ascii?Q?uBryl9GTAqv5J4NWTjuUq4CwBVn9azubufOlR8XU0JwPyqaz8g+EOuaitngw?=
 =?us-ascii?Q?PgAjLWmaYMzHFejSnfUIMFLd2mcQHjSKAq9UymsJuGS+yBLY9n/0pfbvAehy?=
 =?us-ascii?Q?jIn7Y189IIhQ5rYPk2K+Sa02ZLg7Xox7lW7M/sYzbQQuEyfzP+R2DTi3a0ka?=
 =?us-ascii?Q?9TYoP7gsKaWmz1+xvU8m7qOwAgSkgf82Ns2nXAerE4JGRld7oplmEh9TMU6L?=
 =?us-ascii?Q?QE4SOTSq9fFZr3fKdzKAe7R0L2UoX869nRYV5T5ZYUz5ypezZ9aaMrLF+CYx?=
 =?us-ascii?Q?mkui+L0GZdYwzO0nUSPwnqUhv6BhLoUJA6pr18VWSXqmwLIBNe2B29u1D+YK?=
 =?us-ascii?Q?bDpwGL6WUNJ8BmkUtGSfaXIGupL+bcfCZ6zMcSLaLpB4vrDrJPyRYXMtX62E?=
 =?us-ascii?Q?Bum0PY12HpZFK6QdIzMyzDMgUYkukOVDU30kjsBNGwpaC5OfcDnCtYMlgZnf?=
 =?us-ascii?Q?bYXlfw7MsNlX3Vnl9/8pe8sIF0K8Zn6D64LrvAVRiAnaWoSsuFJe+ZYnXBeB?=
 =?us-ascii?Q?TbOusrBa2Ku/waLC2YayQaWSDVm7wUdcRxkjYJ2T55jkecWvu9n08b/w3lL0?=
 =?us-ascii?Q?rPfqyf02vMK86eukx7BSBYv7itm0WMogYC3wDczhtiRFe1SwPTsfDEDO3Yuk?=
 =?us-ascii?Q?p0KpMwNN3AIIWn6lT+jQtChl9yq8pSf8nv3vLFvu+OWaVDgaGo/ud7RWSIFH?=
 =?us-ascii?Q?wp5VIKP5pnKJR8KT9V6vj8BSWdJoyIMJO7vgfo90azL5nFmOvU3DlTE32riB?=
 =?us-ascii?Q?nCroZetMJ/yGLxDsT5hhkE7/MFlul3F9HeUdB+trDspR0F5NgUnH4CNCwCrp?=
 =?us-ascii?Q?ypJDurq/WDuNI/EWb8cb+/aqlrd1vvnp0BeCK4n369i5TI1nFMD1AoMpBuKG?=
 =?us-ascii?Q?PgCShFwWXyaTIjI+5c3S2tU+0ln347uAX3HdLX9MJWkAurM5gao6JhP+wo6j?=
 =?us-ascii?Q?V9uJ8xNfdgWMYWOM6gf0EP6F+KwaZLn0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/sonjBSBF35r/8Wl/peK6YbAb3wfjYhcPrAwAPOPKN7ao5MPOZ1gWv8R0W3?=
 =?us-ascii?Q?H+VwpTK/Z3bFzkWQqgnSyTbStNWZUmlWitjraFlOH53Q4C2Frt3nrl99qpmS?=
 =?us-ascii?Q?nPbhXQLCresyzGERSCW7co7Y3nZUlOLITYHnB7JT73q0veAqsy7xb0Vh8vx6?=
 =?us-ascii?Q?FFnxbLfCDmDuIOIXgCwmPwLgdj246bK9oYlcxMrN/NLgVTgrom3leBNBVZOd?=
 =?us-ascii?Q?OqzTHy6z8fzLTQMY0WzhKm2Q8smLT32mQ36DzcCzZXeK7yWczdB62R5SxEXp?=
 =?us-ascii?Q?Lb//qFBWJBi4Vwc8Qa41o4vKM1EvlDgRjClrEvh+nUZAlfYmTZCbQK86dkiM?=
 =?us-ascii?Q?P49miKsIOyrlv0GmdzL9H59P3moWnIRQeNWPR2RFyJL8QTv7gTe2vqmWtzUR?=
 =?us-ascii?Q?4oDPwrLP84sX5P0QJf2cfN8XPzMI4BACCf5sWZeAuBK57DNVPW+95Si7CnIN?=
 =?us-ascii?Q?NAF6bdPIyV5zOcOCeQC5ci5qK1cIQTbWtFW3iCZTaSbp4Q+V58ogLnucabzV?=
 =?us-ascii?Q?9drCcIUAQd2cykNXqr2nqzif41CvylD9OXG0+SwicjpiJVT+0wwDqT0ZZFY3?=
 =?us-ascii?Q?pXUZSHvFdXgrI3OUcf01cuQnJha7l/vYo1lG9QU4fN5qywk7dBeQ+mZonfoF?=
 =?us-ascii?Q?rXXONT6rvNthYR3EdNqyIgDd1Faxlj17NaaAWLkvay+jAGS6d29XddjifcQ0?=
 =?us-ascii?Q?q4y5Em1+SjXU7IvX2gK9kvmtWY2QSyqrwv8ZJAXxB7xrrNE/+aUjlaQYc+9k?=
 =?us-ascii?Q?x9wiZ5P+GYAKE/IjUmSwQbq14+ncaQwGQoDqPX83JvwB2ApSNjOzq4gm6rIT?=
 =?us-ascii?Q?cf8sXqivOM81Y/4vO36S494UFGuZ61pKEHn+FEZ4LpL54xikOkBmJJmt0IiV?=
 =?us-ascii?Q?z5ventXeQYBWKKZ+qofNROYx7ZTxX+KhsijIUOpls1b02YpX7iDBEjkTrvzB?=
 =?us-ascii?Q?SYWc5eXgEdpwAlYLQZmQUPqtbe/a7go+Gw3nEt6vdxHMp8OGrJ1T4RUMHACS?=
 =?us-ascii?Q?1RP2lJbeJII5VwWQPx9wh4oi9p34Y3qOGPBK+lpjJX4Acol246LYCwayMeyL?=
 =?us-ascii?Q?kWnxq8hq2rkwly+vhSRAWjdqZB83Ok2dF3C7F/oqntfyT1IPrVy3v8AEiaC+?=
 =?us-ascii?Q?ABEOrcWStCqJP4P9pZYuSElb72O36sZ+exQZZXLGvsIHDgEfK2u0/NF+Ou0+?=
 =?us-ascii?Q?q6rbUoFBQvOK21ok1Y6L2LHAIY5AJHtlLFrztawA5OCwEvc8EC2PY3vDmvsA?=
 =?us-ascii?Q?Ibv/eabWXPqBdAWUrb79d6X8S6cl6sRUg4Ss95a0SBL7ANa475j65A2xhc+j?=
 =?us-ascii?Q?Wx1/KHg8/1860kC0uTTxGHdY3u690KoSDQV0N2wX8m/F7NM5ddStkGVM7D6H?=
 =?us-ascii?Q?0g138mYH3PNrcGCoui+miN0dYYsfHyXFwt+VTy169cOxqbGZe21BYVl3tFnQ?=
 =?us-ascii?Q?g+i6DMvXewewkXK+G+ktfMS77OCvwxnJYSW3uo+6vLvbo1SVp7t3qFUeDuDz?=
 =?us-ascii?Q?dsb5MS9I32R8COAH2ab1Z4ITUYPgczYX+/RcRzgwj23rmv+bLYKuvj8w8hFo?=
 =?us-ascii?Q?mAY91JLHLEGm8tiE9Fbq0qwkU59MRTyijyU8BMM3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0152b646-eb40-4a0c-009f-08dd7107623b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 10:24:28.3126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9t313kWUnkeXKxsOc0p0o5kSCia2Jg4ohS0/oI2A/dPBmZY1IG+qG91L8Gw6rlmStMCm+NqUZi38QJXI0Qimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6231
X-Proofpoint-ORIG-GUID: 1ZLRLdCilUX6iBx_041lFm_ggYy7qaCC
X-Authority-Analysis: v=2.4 cv=QZRmvtbv c=1 sm=1 tr=0 ts=67ebbeec cx=c_pps
 a=AVVanhwSUc+LQPSikfBlbg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=bw50tJGaitPCrv-071kA:9 a=CjuIK1q_8ugA:10 a=HUgA6oNdoRUA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 1ZLRLdCilUX6iBx_041lFm_ggYy7qaCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
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
> From: Rahul Bhansali <rbhansali@marvell.com>
> Sent: Friday, March 21, 2025 3:34 PM
> To: dev@dpdk.org; Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>;
> Kiran Kumar Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Rahul Bhansali <rbhansali@marvell.c=
om>
> Subject: [PATCH 3/3] net/cnxk: update IP header of reassembled packets
>=20
> Updates IP header data of reassembled packets,
> 1) IPv4 length, MF bit and checksum correction
> 2) IPv6 length update and fragment extension header remove Also, corrects
> data length of multisegment decrypted packets.
>=20
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>


https://mails.dpdk.org/archives/test-report/2025-March/863905.html - fix th=
is issue without performance impact.

