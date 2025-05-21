Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C625C54ED1
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 09:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AAF7410DC;
	Wed, 21 May 2025 11:18:21 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 33F9040151
 for <dev@dpdk.org>; Wed, 21 May 2025 11:18:19 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNcTTa031279;
 Wed, 21 May 2025 02:18:18 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc8vx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 02:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfKPPz+R8hl0uqBgnT5sBVEdEsU22rgmolnIu+bG1uOF+jwEa76UtixHC6oJQIpVM0cLeqAPQryweyo1JRp5e/E9iEVCOrlfZ4TgWmhHnpSPibyXcpCYHDJ4z18Rljx/V4HOy9PyHXYpMdB0LzlfsYHhduIwGNDKnQwHawfnWcXv1kUOTv35VukmRDQ0hsUfTN3HqJppBvYYS7iY0gbkwyC52jbW4vYno7Vy9gc/iTrfGza9Y/00J6NKduw+oduGDWxtOkDx7ghrOz/y9qFHzYTDy7qrZMJH3ogKHUnkgpZ1XYg9ZUm43/n5Asys6pYnO/ASSzolbbqR05TtPfKDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzsI1D0JFhnnr48QkvxMJ1i3liwbsF8u5Cu1QC+7am8=;
 b=IuD/5l7pd1GwmtAt2pmf8cNye0oZk/L5/fog6JZMGPz5HRxO+1aW8GMSWPZ/Az1Vph3rRQKLemagc+60irKMDjhjh68lYSQxLDG41ckN+wUxmr//RMxutKxOrXHyrS3BwiPnCU7+IPvjOdCyUavVTk0z3OCjK98WWz4q8XxhpVEhYILXQAFcwmJEXMiNl9sZ+FLY7jKeAJx1uHrYO+0G/6lBtvmH6KkWQdckov8ru9aapQIB0NM0A6NoVkOrjkF94qmt60c1R6fccDrsG5gged54pfrcXYzcWv9YMYCijyG9GycPYXx2jdUirQ4YBbeT1yzWH2H9wcTodF2ywXPRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsI1D0JFhnnr48QkvxMJ1i3liwbsF8u5Cu1QC+7am8=;
 b=v9YXUrI0NCUJyYFqw+5BkKF81tRBFkl4q3my3trfRlENIZdeVsLazhKPvxPQgkE2UiF4KFFg7KbS/pPzZ1YD5GOX9Jh5IkvF5zuUzZiQqzoPfaRaKD6jVjkRbh0Z+kJKaicc4giGtfEctQQjy9jE+syOZUZHC25/QUPuLLhbx6w=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4319.namprd18.prod.outlook.com (2603:10b6:5:39b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 09:18:08 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 09:18:08 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v2] test/crypto: increment dequeue timeout
Thread-Topic: [PATCH v2] test/crypto: increment dequeue timeout
Thread-Index: AQHbxLK/wkZQCyierUCStD2r1zEDO7Pc2PNw
Date: Wed, 21 May 2025 09:18:08 +0000
Message-ID: <CO6PR18MB4484AEF17E0077A0A43800CAD89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250421064708.1777-1-gmuthukrishn@marvell.com>
 <20250514092941.1558-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250514092941.1558-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4319:EE_
x-ms-office365-filtering-correlation-id: 931a7331-6539-4d66-d3c2-08dd9848667c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fUahzRK5nMltndlJnUbYOAm0uI+JUXX+7l8oS9HuiSA6XOl6hthY4yK9hH+d?=
 =?us-ascii?Q?5evaN3IJhV4MCf5nb8Pcfk7zuRwN75djXgYfBJDifMLvwjIGlnEbzH9KJLLx?=
 =?us-ascii?Q?yTRB4RxUdzJU4IjCuOW22UTc73na8apLx0rirLl6db1R16Ke+y2hoxpxZ3QG?=
 =?us-ascii?Q?fZxS3zPBmRIKiMRNZE1zLAJBWgA+8M4H9OtzkeqrdOj7VLcFzDBwXWJyaVAp?=
 =?us-ascii?Q?jyLsIc3LG9gk+ziFfER8ecv769hoxuk8HQlokr1IRSKo2/oTPdNBeK+9HhXN?=
 =?us-ascii?Q?iCLWxQagu26ijA6l0e5aQ16HQ+mvQwqh2zug6VlcUteYSmZN2gyNtwIFeiqi?=
 =?us-ascii?Q?uZtN6Onla4lt7zN3Gmau03YwxPWNB/9sLm6EhleeJCqxcpXiUCazsPbhQKzc?=
 =?us-ascii?Q?t5Z3GHN/3pQ3KIBqS3rdINhcfjpyZNcf/a+2AnYT6KiaAQVkx81eQpJUGjlx?=
 =?us-ascii?Q?EYQ/yIsC3rwZmHVnw/2se/gUW3o0iXPfw3013qb/QZb4RgGcNYVi+81a+bBs?=
 =?us-ascii?Q?ZxxEeMUVDfwDMSbLrtEyts6dYvuntYAQo0qZfD5XlVyf0FyvRsphDvZvH7lJ?=
 =?us-ascii?Q?kauNSlRS3hqGfDn/+oBH1VNGV9hFuDcjBodhllVArLUwouYM+DrnOMypbCPn?=
 =?us-ascii?Q?wktocfEi0B+qDLCEyBA8/RqLE1ZnupksWS+CE3dF+5M2VUmYz7n1B7dVnb/4?=
 =?us-ascii?Q?4ePQbUGXLshuIvDqnWtbjforZAxJq8jLl079Ozeeg8pafzkwV+LnWnqRMlkn?=
 =?us-ascii?Q?PStVEUupa7UB2PIApGmfUVckPUoMtg879SoiN7hnFF2MjwqrFvTvfzXrBqQP?=
 =?us-ascii?Q?g8fp44cTyewfs41GI2/8307+0f1DSNcQufUnfAY7zZIRPMcl8huOjszUynmK?=
 =?us-ascii?Q?jV+UjUvKbmWpjuFiAN7w5an5fWFUeblP8+L1OJK033r5t/nszejVil0nVlsI?=
 =?us-ascii?Q?b4X9ailODn73lmijwlZTwNdvNy238xd++kNs9ZxWv9k0aDPbza9ZE628uxLJ?=
 =?us-ascii?Q?0xLV5ii9LB8nd1Dze+JZ1mmMEbUwfZJBGUx4QEPhjuVa04cUSJNol5l90xaz?=
 =?us-ascii?Q?2zTrXLfZwrgMMod21IRBUr/0HI0S1msTE1xXQpOW45R7XzaE1g8Lpgt4WFhO?=
 =?us-ascii?Q?fUCUOvsbsjaC3rvQghjyfSbUhNWJyJBx626Dvv7RBukU+BgLxJtTCbzDleoA?=
 =?us-ascii?Q?zEM5zjujF2ebE7g1rHZd/DMHKaY4x2FtKDFy11V97O2H/6Ql2laRSOqpPS9x?=
 =?us-ascii?Q?4Z6QvSoxsW5xADwxGx9wpLD5JN4KNiuPamlWGQx4Dh+Iia0BjAkgsXIZiu6+?=
 =?us-ascii?Q?bK6WA1CLSziaaZw9jq8bHflW4+6ULbj5f+eT7sZ+pJk5a4JfLSGvuksdbNQC?=
 =?us-ascii?Q?cVE7Y69H1+IL5zMCpvROwGe4BuFM62qDcyhPbCO+R/pvLfebhN8K65ogSHtk?=
 =?us-ascii?Q?oI+KkkQhNrypwG4GMpTSq8sno6o1qIQm1o3smIDt16sLVztkiUL5fw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0+D90X9mKAuBgku8BTC3qp88LxIvDu4B6154YqClBjI/neZvn1tdZjTFYFU?=
 =?us-ascii?Q?n4bCoxVfsDJtovO9ygQmVdNUVhXRtMdyypRUMPwcDGSaxr+CJiCbV0Duthx8?=
 =?us-ascii?Q?7Qfy4XGnHxQN5ZIkL6d3b/28CfO8pd/7bZ7fNqrnnrzqOUma9HHua81DGox5?=
 =?us-ascii?Q?U0+Yw7qbZXGOw2fTb/TangLcioF4/OEpLar0KKcRpeDo6QZPLN+Jme2PjDF5?=
 =?us-ascii?Q?CeEVhjHMq6x//ZW04iGZ3ZPfajxJnHEjFvlPfhNH38pdKl6QNQ4LBIaiNS1u?=
 =?us-ascii?Q?Oc59Co3Jl+eaTUgNF05FY5ogqWSlW0kzp1Jsnl8Sak4NGQ3OU/5lwLiV4P7O?=
 =?us-ascii?Q?JvlfGCwv75YrzV4iDKrTwfhUf5xDtPtYHP71nE+vGYGvv3+hjZpf0LjeZVsD?=
 =?us-ascii?Q?mi2cPxh9PQjfcjD9/qQprVWwV+9ndA1JtRp28gWR6D9NPpMt4OE2bxBRo90W?=
 =?us-ascii?Q?RQFk/4uOFixKHBzb0ettICLSt34XM3SdFG9BXI5hMKnJcXXgi5RsbPpqcTA0?=
 =?us-ascii?Q?eAWZBKihyKJECYthFhq0AEfZx6vy7epnxjwcnu5AIIzGMPRVTVKFdQHn4v+8?=
 =?us-ascii?Q?NpFOFp5Rv9liWvWScylg8fY3rjPXchFcqGLgVAantb54I4X2z02KfABRTKGu?=
 =?us-ascii?Q?bq7w4G33IS1uyb5xSbLqY7OKbCvKhcgwDB3zHb14FEVbEhFH/qHIOGACgOGa?=
 =?us-ascii?Q?V6A9gc2kFk67clGjqKfPNQu57blWyOZlm1n2HNENgan0qhUSLa/tTkQtuCHS?=
 =?us-ascii?Q?yLoTE5AKAamLYf/4jWGyGgf+vPb9zoo3lWS2b7nkHGvq+guAzouI+bnRwmUw?=
 =?us-ascii?Q?FdMKokOqpbYkmBkkS6F5IC6b8ETIdYeAtm+UhjVxWi3iTVhgo6amW4jqgeOM?=
 =?us-ascii?Q?GFu2Pg3Ivu8YII8/H0tdOP/Zs4ssvdWZaduvdZIRP9LI63dJ5tNwv7SsST+8?=
 =?us-ascii?Q?PF4NDDHrmOMpAK+fA/u27hBDmbKKwKvTBUGoOve6hK279eUM6wzMFP/rIXnx?=
 =?us-ascii?Q?04T5d5U8hos4w5YtVmew/QI8ZCs+a4lkqgIie4+8efukm/mHRPZ5JYPHG3TT?=
 =?us-ascii?Q?YIVPMarsxZFhIv8jUWtvRSdVMEW9pFAOx7acHwE4aC1IsAzh30zYs6SY9a32?=
 =?us-ascii?Q?xeDVggWp9JDubQ/YAx+Buo7kWDz+tLXG0fAoK4L1peq2jGBa2OO+4cr24+8w?=
 =?us-ascii?Q?d1akeS9pYjPgXV1e52tyPZAGBogsJf7H7nnuAQcqILDTLxk4RTVip0o9vgsn?=
 =?us-ascii?Q?Wpo+ev/IeJHFh3Vpj3u92cO8FZIDhMEX5CT5tlKb8PMba8opUVB5PbVPn045?=
 =?us-ascii?Q?Cvq5nEE4ccnueniyHdWgcSzV9ABTObdL/MtBERugk4FpptvbCGUBtR4b8tIM?=
 =?us-ascii?Q?kqVBIq9XMN9493woM6V6GeUr29SI+nsUQ4zA4Rv/OmZZDyryuGwOv/Tfv1IC?=
 =?us-ascii?Q?BfHxqd1iZY+eMo1i20ODxoqtBPRUvvRHQYpvzHV2uiocFfIM9PiTVb5AmI0D?=
 =?us-ascii?Q?vwV7fKwrjIp3kcQ2vVkgPGMpDobKtzc3XJhw1DRRIMs2xlhv0B/tvKW67j0T?=
 =?us-ascii?Q?fSjti3EFwU+zSK5PfjazvhBuZ63PW5GEc9J6ElwL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931a7331-6539-4d66-d3c2-08dd9848667c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:18:08.0815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVXCYo2oLY8VLBTzdW6mmOZDV8bKTvGiaqK0TYhTMx2FjYsn3ScG1lfYplvHdk4YioxAQCO1wp7yHeI6n6D9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4319
X-Proofpoint-ORIG-GUID: Vuwmfd5dn3ZspgnI2dqouaSOv6SS2l3F
X-Proofpoint-GUID: Vuwmfd5dn3ZspgnI2dqouaSOv6SS2l3F
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682d9a59 cx=c_pps
 a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=eqo-v25brgpHSQM9K20A:9
 a=CjuIK1q_8ugA:10 a=OXoeHldmKWcA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfXyx9oONz5frlN
 4r2vcWw9CcDOlxgHeFbdvvFU6Wl3gNBnTGKL97UClIoJxg0Pn52QBb3VLYSqMKJbQEQCBi/z5cu
 9MBfmmwAC/SYV1ID0vKqPTRU3pkMG+OxTJqwiurVsf8vp7+YvCAFyF6Hz8q0/TJcFlhliE4IvXI
 a53qepnOVPcjsYnyRI+D7vDXYNYrWssbIaA9VRWPtqCrpw2bqSKmx0SFctLzpYbVF5JaC1wEag5
 qn3pLT2PgbceEa+2f5xpfU30ZFLsVOO1FYTVSQvEB0fClYkAxFI/5rqRFC9YgcMRKDVxNtlgUX3
 BlE9JfxXdeyfYyad9htjM94KvdFtYv8/ROkywLjpZvPGooVkrZ7aVwY46YdOVuMt+fQae8YKpYK
 gBz3vnhvNju8PlijC3pyrK5gz3fHFl4bCe6EBkKHpSddGtg4hbHZGnMMWldHUJOkgZtajPZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
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

> Increment dequeue timeout to allow implementations taking
> longer cycles.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks
