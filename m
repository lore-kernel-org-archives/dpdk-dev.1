Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE8C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4476340B92;
	Wed, 25 Jun 2025 13:40:16 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 571FB40677
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:40:14 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PArZDK031606;
 Wed, 25 Jun 2025 04:40:10 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gfrf82jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh+PGlCqolD27QmcuueZruMrmDuPe+EJswDaXDLR7knlVRZlST8qTKFF4lG/GMqO91ay/2O3QxQBPtk5rBBOj+SrrTwksenAnMMFsOumpRJkjsNsxK/v6sxVFKqlMOEqv2NZELFoJz7URXGcov98AFkekSDOnXfTP00kYTNjIkRcLmWSQW5oAwD0UEFjqifF+pAGmzLfExcHZl3RQ2Hm9iETtBHM1M0RlB+OkX8+DtlQZ3+fvRhgVW8kcRYlopMsG4Nd+oYa3D//oUsfWcrd1O+pedzMEsx9rdtVT8W9UGcbKhwb0wWbg7mMdG2YhroLavGtw2I27iH9kDd9JkpRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+/7NpbNZmpTZ57txkuYI46V0HgMmoH9nshVP++LsOU=;
 b=foatoE6lUw5SUR0Nu7q/UFacCJWdzS2h/GB2fNs2/PbquzbyS3VslqPa5xK05b7cUyqn9D0Z8ODvYGZZdLZaXDKAAHoN5xWpw82WEgE3M3ALCNSDZGag+uITNLTvT+OWM9T7hxw8uO4lbL2f5Ndv1HsmVX6QR2rcKN2ARfQNDibOUb00MfQJag5JmR7sO9S2ZOMM6jqd5+UqmYzfEQ+O7f4YJmnySEDQa7PvaObvAph7cj20CIQKdWglBPAP3HYeYOo+uyrsfg6SJVTMAt5OeIAD8dzZ76JsylVxY1eWt8vEgYHYPfObUS7sY2dM7rAGu85ZXf+YDzcQHO6oxZ1zBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+/7NpbNZmpTZ57txkuYI46V0HgMmoH9nshVP++LsOU=;
 b=sglTW2F8Pu7Icvqm7Uk4wwLTBl1kPITi6vYruGlLVgGRN1RYaxDLAg+OzqqqnsFb5PBYBGvz3iDIctfUsjZG51bvQ6F7eZKjk3MrRu+v4BkB/+fXK0gnTPvhKCCqmHhxY7WijWcKZKfWLJDX4i8PIq1V2vN1I0Gz9pDwBH7tg/0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5223.namprd18.prod.outlook.com (2603:10b6:510:165::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 11:40:07 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:40:07 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Radu Nicolau <radu.nicolau@intel.com>, Rahul
 Bhansali <rbhansali@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: RE: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPv6
 packets
Thread-Topic: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPv6
 packets
Thread-Index: AQHbnuZQl+1KVG2kNUOIpI4zymGayLQUTc2g
Date: Wed, 25 Jun 2025 11:40:07 +0000
Message-ID: <CO6PR18MB4484B88256D3E4E77E1000EDD87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250327070300.2839933-1-rkudurumalla@marvell.com>
In-Reply-To: <20250327070300.2839933-1-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5223:EE_
x-ms-office365-filtering-correlation-id: 08998a42-4eaf-4a6a-ffce-08ddb3dd08ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zCW9hvL5a6Fq6ORHOYdcRDdOJo1e44FEzYG7xzXUfS5gd/2+fc4d0nq0o38J?=
 =?us-ascii?Q?CVMURDyWugeGbu4Q17hVCeL+Gf3qEXfCLFvkeapLmn3xKhU5vp6ka1kteSWh?=
 =?us-ascii?Q?cFfAe8iAtjr04Q6nLr0e8IZBvM4m+aZJmwmA5U32CA+xg/Vu/zPV6Wht6WPn?=
 =?us-ascii?Q?V9ULuYl3ljH49Z8T5qPghp32Ces0o/cTvxXwAm6jq0Zltez9j5TnENBsPrai?=
 =?us-ascii?Q?cpRpsQ2fD0woXOc1aXzgtqMA7j5gk5yIPIHMo3/QQAbIbsuVFOlHCSYthLFt?=
 =?us-ascii?Q?IcGaPapzLdNiX68a5NlQr4zG2AhKXBNGith5ouaqB214o+sKvsFTJAr2YOjq?=
 =?us-ascii?Q?J1NqQjB92xOH5Nd4W5GUz1zHAK8wt9DLchu2ELcNkcFUMbH/E6JepHDSMl55?=
 =?us-ascii?Q?iZ42SMofhdbV+CbokEUPmbNGwFbiw+uZQAFhqLWsByhvXo4U2V/0dIFa2Bb2?=
 =?us-ascii?Q?dfRVgQRdFI1VD6XsST0zmi4necRNqKEbtu02haEs3i3++jsgS6bwbDQFWWia?=
 =?us-ascii?Q?+RTOvqX+A/NHAizgz/b8SrlLbKZnq3xeu2Dc3QHEkGSGxKzGxClmDsUgXdTQ?=
 =?us-ascii?Q?yz2SyS0mQl704R/I5NSmFhq2/W5NarJAGlNu1dTsAFitgQeEH498GSbI57xh?=
 =?us-ascii?Q?s/Zedynu3F118HZsTLdmwAjkxrBIqYfvGP1vOomR+ehnNz8zUSNXCIBJFMY0?=
 =?us-ascii?Q?pj3VLxXFQFpTaliOeVqfV5LylOYXdygsXkJNnIChqQkIRieBNWPDhoPvNzao?=
 =?us-ascii?Q?+kMTPd16nBTGqb+hqwj6yTL9m9q2BjqqMJSoqq33+PTfAzzPMAFcSoSDbrtE?=
 =?us-ascii?Q?iEkhafoYvqMIht4q4Hv1gZO53Oqdd/Uhf9UMUt2Q6pYY95y93Afz6uXfyr0G?=
 =?us-ascii?Q?8evBlU8ZFQyTkLht4rh9tRes45kLv3Q0aGFCIlJvRzLZeSnCV610lhehf7L5?=
 =?us-ascii?Q?x0jXy+owlcxTpDUfLdukpPw3u1bKcTUUFH6BgNDCA0EvPB/d/2Cpbix9AMXr?=
 =?us-ascii?Q?tL8nauModN/DCzWEaCOSL1daSsY0y9joUEiBpnrt+2fwh+gifyDZR5gKBUw0?=
 =?us-ascii?Q?YrkZSXgnu7+tg52tYyfr/eLoDJ6TKc2lnqB7ZGYpBoUs4cm0wLwLyqfT/eog?=
 =?us-ascii?Q?Y8yQ7SZwdmA9DJXxn3hk0u3H25ri6AzZ/ELyehsVVjP/FvnGDKroAt5eDtcc?=
 =?us-ascii?Q?nuYFgESM1g/nZvx9VD3idEYSKzkwldJFmIpwqjsAPU6rdxxQd3LpJEBdrFHM?=
 =?us-ascii?Q?8V+D1Q0Nd0vqVSZXrW3VJEkjseS2wGjXDZ4NNN7prIlPpyHb6tcgCbGwu+EY?=
 =?us-ascii?Q?6j92GKvKcalIy0iFsHumj5HYXhMq3z5w9kv3kHhw5jZZYBpxxgaBBSa0nNY9?=
 =?us-ascii?Q?7dosLq98IaDcYV70+82O6PNOqUNri+XghJxAJPZ0Zli62P77zqvhb+r6P34T?=
 =?us-ascii?Q?zSrzPf88+6gnURHDCNTF/q+/QoJKqybgIFsWw1jQGp9Sl9lUfr6LYhuMXLEJ?=
 =?us-ascii?Q?ScAUU/9SBKoQsrs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5lmKlQEkCdlg7TeOLxI6St+WXP/X/EZcmJbdPu0zU+dpXZnVEoVjORhTj7al?=
 =?us-ascii?Q?oyC0JxlrSUsbLwSt0S/oebhWzyrkaCeU/FNerHCgIzEyVSIlnUpIxxdsxBCO?=
 =?us-ascii?Q?JE9RMjom8A5HDCaNtfQ+e1fy9VnKJ+8ZZqGR5qGw+x4XfV2Qy9EdD3X20CZM?=
 =?us-ascii?Q?ZuIVXTRE6qsiwLph4XvKkf/QZxvuOcCWe6cQHi5S1nSPQq9WJstmyN9VgoE9?=
 =?us-ascii?Q?jxZRSldYeTDRhGSN0JNUzPgvlCIDMJzVjNJJCHtnOXbYOuYb/WVBk4+YHLv4?=
 =?us-ascii?Q?6l6q5055Js7DDJ4/E9rlN8xHy/+w4/c8xKfAnYkrG4D/ooKv0Bq40KbYUj7+?=
 =?us-ascii?Q?wNbB3V/dOCXOWwcmTzFHpKJg1oMKP9x6TcZN+iqFxt3Q1Drg0cpfw7sybtew?=
 =?us-ascii?Q?jpE9OuVg+PwQ/+1/Vkje/Lm/CiZpUZuY6RAu32sMoeclMtIe4UMQxb0SOWnw?=
 =?us-ascii?Q?k2hx26McTG2UAoTf7X8sZfKv3wM4AVaxemvAnpnyJUGpDtEAFhIC60AfWClW?=
 =?us-ascii?Q?H2wuLZXTGExrBUesbu9Bc+vrWv7vZeG8OdJq1mCnf69Ba24nV7i/Cdxe1RIl?=
 =?us-ascii?Q?9AbhWSIHvXcHrQ668Cg8Dhe3oNHchzCegfTRyorkM9bXcwE2yQXjtgEKKUzE?=
 =?us-ascii?Q?b5yFkNDTdDWtTejxfQjLX0ShXlyyvY1l2ZTLLwLvsbbbZ4ydJT6pTHq5xJkR?=
 =?us-ascii?Q?zk+hhcaMP8z+ypqwGmD+twdbtjDPwcHwfWbbKoNq+lSuidmsbtuyReg0JRKN?=
 =?us-ascii?Q?RZn73RdA9gnAXKov32y7WDy1q3P3MKJ1tqFc6HRv8WXrXfi6qUyyP27XOhtG?=
 =?us-ascii?Q?F3qJ5aZWUUq9nT8tvyYAqdNuzjE4fXtCa4zPANxfn53zDQqQ1ZX12gU0X6Lx?=
 =?us-ascii?Q?zt3tsp8qwojgbtZj3uxqh/ZZ64NQwTat6NPFNIaJhfeDbWWNug9kNh65E3Z9?=
 =?us-ascii?Q?ECb4wla5VnkqctHWzM5HL4FA3D7MsA5KTNFnlXp38r6hAE/Yxu6K546GivyF?=
 =?us-ascii?Q?mn7WVZLEKw6pCiwJHnUIR/kKYtVu6R3pCkGDCO+uHEOPlkGiQqdIanKlM6kl?=
 =?us-ascii?Q?0b1KSMYVXlC+v6WdjkgoM4D5jE/yw4XQAlCR5gmiYQb03yErs3j/T2Sz/yQr?=
 =?us-ascii?Q?cdGhdB005xY00oSr4i2mE4BvY/hp/Tqig8xJcvhSfz+oEYI9sHE5QXiuXI5E?=
 =?us-ascii?Q?HBV8vzWXCOyaCuVEh5rwPLyQRqaOcKPqoyQaHjZz1ebaTk8OGtYt7Gxk6TSl?=
 =?us-ascii?Q?Bzyou6bEGw6MohIQhmwY9bxABgZ8PLRksKaK50pz85hIHXluZWU/AVS87BO1?=
 =?us-ascii?Q?GYhvVdI3YUC0r5GYHHibBj/7uf7r00KXSmwvXjaT6qU14DXJfwhdh81x5wFE?=
 =?us-ascii?Q?AQgwO1bHQufMCPd9c4HTz6bzgqWUt8CTR5Pkfw0/0+BH6AxK868CA2xO3XGp?=
 =?us-ascii?Q?JyWBz0f2XP2JsVi5W3gfY7CLqWLnB4A9MnGzpHj8mPcNDnVdKWF8L3VY+mxL?=
 =?us-ascii?Q?JiV9EShCH1Czs9CLW4ESwpcY5aAUwgYRZY3JRyRD/i1Uh1RUXKljR9SKbRNG?=
 =?us-ascii?Q?Sf8HZVrHz3NUYMkLX0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08998a42-4eaf-4a6a-ffce-08ddb3dd08ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:07.5159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tB2VXqaOe3d4wKEYmjEg/joxAkdFXWtolCqDpC6bWfFLvo1WrW5VTVfj8Pjg0atuF1E00tl9pwUST9f5ZbQPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5223
X-Authority-Analysis: v=2.4 cv=avGyCTZV c=1 sm=1 tr=0 ts=685be01a cx=c_pps
 a=u/9spOtAi4HSv8o1DqNPtw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=hU10Auqsiins3TZOkjcA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ebskCIcMjqD7IopJPgjSyfoK1TpubE_X
X-Proofpoint-GUID: ebskCIcMjqD7IopJPgjSyfoK1TpubE_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfXw5eNZGeMRkND
 CUJFDMRcpJ0wqi7YrmGhdQoSpBXD15YL8FcNZS1fdnqcDC12+iit3ibmJt33rCOM71kilSsEiSD
 m7PzF5vGFdPCHZMFoxJdr2dwoFJzPil+SVO8eufYB0GUgOldIBuL7YQxlFvjYhFgDuWQ+yeNmF/
 fRu607wBhRFv/xlctd5ayzZnHHUJ7Zb/pjRqw9R+ubOtMEVlxc1Ok1T45lSgYyq0J/F9HOB/wgn
 4IXOp4KX2fFcCVbtb0YyWNPFZpiAwd1EIa9pdTU2gY5EeuPHswyJEKLD7EiWI58Zn/mCCXT5s+L
 JnivcjG0x8oJ/VbDRrgdMIInXCjf826A2EKYzUDrZCY9ux51J/j5f+Vp+uhzG+HS7JUd3bflOgz
 6hnqzPzCotX1eegpXC+yhgLgF3mRZ9nM//4Mrir4C29MN0sx17IfkLRSzc8aU1sPYfpCdQl1
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

> Subject: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPv6 pack=
ets
>=20
> While running ipsec-secgw application if IPV6 rules are not
> configured in ipsec configuration lpm look up fails and
> destination port is updated as BAD_PORT.During process_packet
> ethernet_hdr is updated resulting in crash due out of bound.
> This patch fixes the same.
> Fixes: 6eb3ba03995c ("examples/ipsec-secgw: support poll mode NEON LPM
> lookup")
Cc: stable@dpdk.org

>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Applied to dpdk-next-crypto
Thanks.
