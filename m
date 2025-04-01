Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0034C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 11:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0DE4067E;
	Tue,  1 Apr 2025 13:09:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F2A9F40275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 13:09:22 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531A3XRE022595
 for <dev@dpdk.org>; Tue, 1 Apr 2025 04:09:21 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45re2705xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 01 Apr 2025 04:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shhpgODst8P9tK2bQ5MPlhQ/rK4KD5Oo/i3ZJFg0H1nkiU6254xGSZ7dXyrUh+/jrL4wRdnk8fy7d8lwSlPi7tbYMkX7JH/wuILSkfHxwr65MeDv73Jqn1bCqC2ciKnBtcHv1cs9Q5t4LJqwFx4QV+4VJJjw3HEUOJxqii46WaX9hKpYDYFjs5eVImZCagjJwHbpYmoHKHeNVqeC2xOyxtCkEkgbg+lyIxQQMLWrLA4Z7HZaDmfGivwuFgHSbYm3n4UmpTSdi+HrqmrFwuZ06y76lvHvisfsyYgn75u8sI8oKA4C8q2cnSMQbUwcdVcdKVlA3gsUpa8VyRTQQVBMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nj5rdxnXjyPPcN/EznCzXQb7z5SSzjCpZYnWG6Z+qM=;
 b=j1ROFdxHZ27Svc9mAcXr88yAtPmhWWeRy5EF1M2DbyFQsxzl4J40rFyIBUjIk/bmL2kmhA8cGKQnYh5+Hw/U5gU2hr8TZPrwFKUkQazMfEVUu60rq7v2QY6kJO3gxDMwg1+Mui/wRu57snyXSv4e0sJZtloxfrBgA7UFx/XC+9ZiSGusRIIZFy+5UAvi3xFNQP+/LUUMtDV5EQ6el/D+m4Ve0ekOIXq8osjbusr0Ed71JB7NojmCK0zz6P7ArayvE+4lUjXiGfBn6Zjt4+a6AWfIShP9jmwacTx85mHnCvgb2Q7mQTJ0T1CoSR1t1oOADjuTBPvHFH/OOV5+ks4aLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nj5rdxnXjyPPcN/EznCzXQb7z5SSzjCpZYnWG6Z+qM=;
 b=MVJ5XRO+y0/2h9We7SFFQBusvCqwTei5/LrFVIfz7CUnFnhAyX059Tb6GdN1BhQ2SE6TW57wkNFKSQMf4Fin9ILOIM4qASc2SA+GFBl82OyN5EvXMRExZYFzhmk9jc+s6apYL3r0bgGc9JMpXfhpB4o4+I0v9gqWY23KZzz9KNI=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CO6PR18MB3937.namprd18.prod.outlook.com (2603:10b6:5:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 11:09:18 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 11:09:18 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 Jakub Palider <jpalider@marvell.com>, Tomasz Duszynski
 <tduszynski@marvell.com>
Subject: RE: [PATCH v4] raw/cnxk_gpio: switch to character based GPIO interface
Thread-Topic: [PATCH v4] raw/cnxk_gpio: switch to character based GPIO
 interface
Thread-Index: AQHbnvhmIz0G+z3wU0GPXnTxrjqDmbOOrvfg
Date: Tue, 1 Apr 2025 11:09:18 +0000
Message-ID: <BY3PR18MB47855962B0DDF25508E26214C8AC2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250325041420.1669366-1-tduszynski@marvell.com>
 <20250327091222.2472797-1-tduszynski@marvell.com>
In-Reply-To: <20250327091222.2472797-1-tduszynski@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CO6PR18MB3937:EE_
x-ms-office365-filtering-correlation-id: ce6b4b4d-c6de-4cfe-a68d-08dd710da5a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ROCv3A2uYtLS2/P/mcLzFE8JPef7W/i+zFiY6UqXUSiCWMoED4oXBezburob?=
 =?us-ascii?Q?t8OobIixNs8ScDURK50dxvS4Tmie49lfFvIl+/acgaTrDbNOOKIynThblVkW?=
 =?us-ascii?Q?/n04kuoWIWbb2ldEkzfdYy4H8jFUF16ywpmOQD0NZh15exh6Ee5uXXQxyxY9?=
 =?us-ascii?Q?uQ6gUFTm6EqezTFRmE3vQprnUEUSFkWGrDH/4BdRAD8gQdlD8EQxzkz7Ah22?=
 =?us-ascii?Q?iJIktedr+xqHvUiejj1qJhJSSsVvqJCHYYWNagn/QUWpwy8uAuLQiNwumucn?=
 =?us-ascii?Q?ylg3utc/cXs4apjSaSKc/pX7FPgJeDvXLI9PIwyrP9lhfKNPgnUOWPWuZeDZ?=
 =?us-ascii?Q?evuJrb5n4PvlGny9Dvyy8iiagULWlvbE2nq4z8BhE6bD9nkluELVTXrVy0S9?=
 =?us-ascii?Q?HBwE5QEw99nry7ODNVZsAD+HqNe0wlM5oCAKOXCQqU4TAxM9xN9OgOfviNTK?=
 =?us-ascii?Q?Qf7KEk7O8umE1AH6DFnFUyAh8hW7DcmbZ4xZq4Fmvry4dZza2NIJhfHAKhAj?=
 =?us-ascii?Q?QEY9aoAios7smfOioX7YY0nDkjs4nut0Yu4UwVeqaK0mDfjuFj08RlNl938V?=
 =?us-ascii?Q?oLKYt3Vt/wXXArpj/+VlL9DOeI4CeTOHEChZ0kcE4v8ha0cBzCFBnQmRr2+B?=
 =?us-ascii?Q?aTuICOirdLvh7QvlQETwNOxZPQyZKFtptHGwl/zc2mrjxQTNlVY2DxPU9Sb3?=
 =?us-ascii?Q?dJmdGHJFERt0J1BhhON+P6ekJpyI1D0iIiLd6iFEKayNERkbtREGvk08CPhp?=
 =?us-ascii?Q?3y9mrQ+Hz6HkOc8CgkYbefrWB6rXbyUhe3y7WbTrY6s+9k2bGbmJbNXwZB0E?=
 =?us-ascii?Q?bqt3OGXAX9P2wc+6DF37j7YtRZCMajYCe5fCjo4TI00H0znA7rIvAuU8syNO?=
 =?us-ascii?Q?jFlGDcj935nxSXGgHXZKvrF32k9CUqW5+g5i3qdUobH+Y0ON936NAn1scWTh?=
 =?us-ascii?Q?inli8CT7tAqF9IG8vvBHk1QG/n7sFH1gjnfdwRvAS6YIu9kYghKzDtNa5iDz?=
 =?us-ascii?Q?neb/aEBqj1CUHWMV6Okc7walQUWbsri88tbi7GbKk82T6M7d/uUiDzaaOYZt?=
 =?us-ascii?Q?RtDolagP8WPWn7Fpv3tAb6T/PIhW7ZZITa6SKKCDI+myESCk2ZpogSX2Q7R7?=
 =?us-ascii?Q?fJQRvW1Muc0RNMZCvAfkrksMd90dsmqN6gtHdI/F1hPMHtNE2DWLqRTGP13e?=
 =?us-ascii?Q?9DaZik9rHScEPru1bQlZLspgyj50VkE1W6gJFKwX+92+K6h1yUuVM8wV+bN0?=
 =?us-ascii?Q?UUdb1tq3YhpvEDQc3HmO4o4D//cXgY78fIuxZgaEirTg7p024Ot3kGJrvtYY?=
 =?us-ascii?Q?FYdrZ8L11aQzhcFGIP3s9ZNUW90aepDL9EbyOlMHZL9S8d9nf801HnFoN9aD?=
 =?us-ascii?Q?tdEZzCghoyV7d9i9a72+rBtfwElNbOHchdwfG80D9Yji6UdGPf92r0gGJq/C?=
 =?us-ascii?Q?bvoG/5MUltM9bvtlN9Y83EbuHoOnpu3X?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CAxIcqVg8qt0cwmsU0/TclZWzcFcFifEfuUFYoYLfCFw57dkcA9bp+frWLOY?=
 =?us-ascii?Q?M0PcNZCrG1P0Wz98AhK3EU76Aw/9SoUvy3BxjFzk7q2awowigq5vIF5UfhT7?=
 =?us-ascii?Q?a2cMuO/BEvLSh9Cb+nPnNquY60G5kivLtSvbSUyJPh+CH3vgbRUw3RbTGd5T?=
 =?us-ascii?Q?7flowH1iT8MkO8XhvhZv2SSXgXmnGnF5srqmpJTDFbkTlZDa8LPEnt6WVwV9?=
 =?us-ascii?Q?KZJhqL5rMYrM2RlYBHi8gKK/CVXZBtWXk/aXu9skdPFLr2mNcaV8lLHdlF48?=
 =?us-ascii?Q?5gxhRdbs1DclFYX9tBaJ0OzoBY6WG1Q9IbrJItdOcvdvuBmHcBbFfOc5dgzX?=
 =?us-ascii?Q?5VEgjwc1IbYKGGB6JdtOLuAjZF+fVgLEIiD7gAOGutCdNoz6DOIfb24f/dQc?=
 =?us-ascii?Q?i7Nemo517JhBV6laHhy0cm03DKJfA5+vi0ByxC5fohahswRW+5hDbaj7fLed?=
 =?us-ascii?Q?TaloNXCyuu6s9FtejbIBVBDZEUyhuu1VwP111P2hp/lJBUN7222BcxMS+xcL?=
 =?us-ascii?Q?JBaACGzG+H7rLo45gRxUO1yVzCjIfvFIFPIGVjFJsrr9yjdjte7dIQv0kpLM?=
 =?us-ascii?Q?7aJdh65cO5nofjXHgovfwnzMgj9DYC8yiG+j9QQ5vJoBeQukhtwSqzyYsR//?=
 =?us-ascii?Q?ZIDUBWIjYOf1XscSISpl2MuwMZgJQaDHmCMCcqrHo4HZZ8P1yLFIbPX9zRig?=
 =?us-ascii?Q?FWJDdm3D3KVDnA0aZXyasskcY7nS4qrHfg2V5SV4+dWKblelsRww067SClP7?=
 =?us-ascii?Q?xZCAJL9msH0dKggZgfwOpLHQvk+SKOR9diNhw2jcxIWtW7KTK79LRf/amDav?=
 =?us-ascii?Q?ZlaYdAd1skeiyIZXTt/uyKdtGmzVbWn+E8aasGi4iBPcIlAOiROgcl4al8E7?=
 =?us-ascii?Q?gzqCMR/dzC0rJ/3PVeqb7KEKKQY5d7eMXO/JJpBe1uhDEBY60BcYl8RBV5ep?=
 =?us-ascii?Q?sZiAVM+BVWztW//eZOBu4DqsMSwSi375keG7Vjz8Wz5EExjVgL9CBqOGcsyL?=
 =?us-ascii?Q?VhCquIUZxJQ4tqOK/21ImbQztwOw9WS8BUvkbHcKHqB8bAkDO0phQXt42Ty0?=
 =?us-ascii?Q?IFEtAtzDzsLRxYQ+BfU3SiWMmwNRrW8nfsfel8aaYU3ePyOKPwqHR357RBIh?=
 =?us-ascii?Q?91IMgIJO7v7XRNBmN1IGd+Gof58thhJwL8NW7Mvz/BlxeDf8C7XDN0kH5uDL?=
 =?us-ascii?Q?bugPqfHI/TjyYFOjfgr3ggageRGRBZjhDtdn4pA4ZF617JhT9YW8UaXCQJ1X?=
 =?us-ascii?Q?9fG2fuyV1jW6pU6Jcyz9EMzyhjvfyhPT/ORpjlzI1J+a8GcIC8xUFUmAUQl+?=
 =?us-ascii?Q?mGaluKSDAmSBJq2qCuZUJDS2B8mIWAdCM7+bl00gIdQnHy1kBKUGAfSr6EMa?=
 =?us-ascii?Q?lgOQA9m9SLNdsr8361Qmk5bkz0tha4VOlG0Mvi2ruec2QO+Q3tBoAiedKwzV?=
 =?us-ascii?Q?3cGP6U9+6a8m4GHt38EXqzgo5dh1Ss7opjGG9UELHEi7wuSOvXmtRDspLZeR?=
 =?us-ascii?Q?Ul+SAP668EX+zcifwtq0pkObVUySt7XS0zw1bR13OBabihEKKwG8iKMVjgq0?=
 =?us-ascii?Q?sfgOaq0CJn3jDczr+ZlCPqX/I45PpCIMIB9Qp34H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6b4b4d-c6de-4cfe-a68d-08dd710da5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 11:09:18.3875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TN8oGvnh2RUcmZsDDbUbdFYEmC5Lw5zyZ0NHla3y/q0sBYddpIM+J53sKwd9sW2BS7uL0SDqUceY92XSUbHrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3937
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=67ebc961 cx=c_pps
 a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pRNwaKQ8F4B8Ry5IMGkA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: EDRR99XJF07d3tBx0ElBP0nsI0rs6ojn
X-Proofpoint-ORIG-GUID: EDRR99XJF07d3tBx0ElBP0nsI0rs6ojn
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
> From: Tomasz Duszynski <tduszynski@marvell.com>
> Sent: Thursday, March 27, 2025 2:42 PM
> To: dev@dpdk.org; Jakub Palider <jpalider@marvell.com>; Tomasz Duszynski
> <tduszynski@marvell.com>
> Cc: Jerin Jacob <jerinj@marvell.com>
> Subject: [PATCH v4] raw/cnxk_gpio: switch to character based GPIO interfa=
ce
>=20
> The direct passthrough interrupt mechanism, which allowed bypassing the
> kernel, was obscure and is no longer supported. So this driver won't work=
 with
> latest SDK kernels. Additionally, the sysfs GPIO control interface has be=
en
> deprecated by Linux kernel itself.
>=20
> That said, this change updates the PMD to use the current GPIO interface
> ensuring compatibility with current kernel standards while improving
> maintainability and security.
>=20
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> ---
> v2:
> - compile conditionally based on GPIO_V2_PRESENT
> v3:
> - fix compilation issues due to missing structure member
> - quiesce compiler warnings about maybe unused parameters
> v4:
> - rename GPIO_V2_PRESENT to CNXK_GPIO_V2_PRESENT to indicate
>   it's PMD specific


Applied to dpdk-next-net-mrvl/for-main. Thanks
