Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75039C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 14:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5156140E0C;
	Tue,  4 Feb 2025 15:51:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 84B4340265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 15:50:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514D0guJ019984
 for <dev@dpdk.org>; Tue, 4 Feb 2025 06:50:58 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44kkda06mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Feb 2025 06:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nru1W9KnXL/M8w2mstaeH9Lct3hcqFVahaDYuKJX+tWmbJeec/42qRIgYExd1GJYT82rOWCXjRfS7FmQ5sITqaYmKduxUBMCyAiYLNv9jh3FqdrhnE4n1k5AoFlKXMiVLyXtOx8Sk1VRY1iQxjUK+Mnwk1L//koj3rHCykFvtln5yntc62VKWfEF8m84ZnjSPYFPmIp4/o7S87ew8Gbp6N6oyujQIh6Mc0pA0ANJt2g7E7SU+m+BgZsLDxXlfC5xKPsbmXzAWjm4C/DK7WXYn0io9W2qNvzB1ccIcjs0GJ+l8gvzo/R20fUzah43pLKzbhC9HBROGA2wdIzJpgfDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCyD/HRe0R9T/DEh4w5vj1HcC3rYVx9F1PLG8NehBFs=;
 b=Xcha9Vx6A6wKviGEaw00s2kKvlLnT/P5TKZxjp6wBMspMzBvI8fpQsqtr70In+ghoPweeGoz9TsRoxNvLyUxFFZwWqpFvqWKyhSGIhL9gnRpE0sRu298VDUurN2QhZQJLaFLsjYL39g6TPnPRgXEpvTLfRohf/DHoUff509TfMGwd49hW0ycDO0DK8CrGQ87ygZlarE8S+q6Ki+q11BlfDibaxrPFk4coWVoM/UGxfUKkLk4Lk9/xEbMPumX/7VdkAZixxjPOWF6x7O860YBkBSXVlJhsyKnJ9VawYqZI16utd3r8aMazmSpDnbpzKBY2fGYI/N1oS/rXq6BWDWjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCyD/HRe0R9T/DEh4w5vj1HcC3rYVx9F1PLG8NehBFs=;
 b=s4nMoJ7VHcgf/2H/cGT+Bt7IHWOcUKrkyNiod7Hg8m8rDswIXTqYjZBs/m2sBW9ArdCxqlYqzGI92/t561M9jF4mLyJR986ZqiijEjtL2dhNRvxy2bc3cY4l9X8NIijP8yLMH49FqO99a3DSN5gLABOnmN95RH0bcy6tLvGDGvc=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by LV8PR18MB5958.namprd18.prod.outlook.com (2603:10b6:408:220::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 14:50:54 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 14:50:54 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>
Subject: RE: [PATCH] common/cnxk: check MACsec HW capability
Thread-Topic: [PATCH] common/cnxk: check MACsec HW capability
Thread-Index: AQHbbozcbRkGRlWoh0upm5aQuNj+aLM3SyqQ
Date: Tue, 4 Feb 2025 14:50:54 +0000
Message-ID: <BY3PR18MB478502BEACBE9000541064D1C8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250124182151.3587238-1-gakhil@marvell.com>
In-Reply-To: <20250124182151.3587238-1-gakhil@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|LV8PR18MB5958:EE_
x-ms-office365-filtering-correlation-id: 22a3ef05-c79b-45d1-e727-08dd452b539e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3sCJs0sljdE5987IRAAS6jJCc2+cX/cASkvQ7WJOh3H6jyKvrhA7+pz9rUmt?=
 =?us-ascii?Q?Al955fn29aDydD+9WqBHNXPMOoPV4iMVZD2PsZz9HCRPrWcVWiTUDrx/9XAY?=
 =?us-ascii?Q?mLtF845bgoMEKIP4bIp1qiGTOWDRep0ZX0NyAfoJ8On1PiNaHzYJ0Qdf/Hdu?=
 =?us-ascii?Q?n3gmTfJ51giYbya3+lXNzVP7RPxBN+4mJ1iGhCnv6C8KXo+6pM8VZTP54jA3?=
 =?us-ascii?Q?9E7hmLPCYz07hT8w9EH5JShxjRi/wxjSfE6Vf4Gyb+NU9NMb+jyVN2wCtZQE?=
 =?us-ascii?Q?LCz5tylaj2Wz3zSNvqJgForu7Lu43WwZndHZvT9zvBrbr6N4L+JRO0S+Ifbq?=
 =?us-ascii?Q?e3Zf1zuzQ+YMd3dEkjYWQagy9PqF885LJT/ZnQ/OwgFJNCApxmfzsA9RFxX0?=
 =?us-ascii?Q?0j4+4kYb+4LTrlw4wOnVSbrTuXvcZcxtHTuoVqUAJJJaxAtKfp68M62iOpbk?=
 =?us-ascii?Q?g5yFpplfBKHDQ37vLl/JOIVSqQTRlAYHm7v/JnDC1IixLYlM33Hk6WR5swyz?=
 =?us-ascii?Q?/aXrl65bAplnAcX/Y5Q0hr1WeIkvthsk3Z4y2kF2LJz9K4QGpo9jKzPPQjwJ?=
 =?us-ascii?Q?yoInDZ2HntgiQRMVnZJEdNAcc9Hfy4WqTxDB+nau5ljO4WooY2wZER0Jv2+0?=
 =?us-ascii?Q?cv7GwfLOHwWlnNNQpt4F9lI1mXpD5cviWRCAr1LCIHmis3yWo/kGaRiSV1Im?=
 =?us-ascii?Q?xgFSsBZ8DGeZxfj73qk6fh8YWcxS3fZqrmJJ7/eyW1iz7P+do1bZanWFumb0?=
 =?us-ascii?Q?k7bX1PpHYmdQahkURdg2Hn1waCz0Iay0R6KEWTE9ZDU0icYyOrJwUC2A8WPk?=
 =?us-ascii?Q?Np2PhOJm5N4OaxN5+dzeChtI+DlOA3IA39Yhpk4S+94BJmunqzKe/YD1EhOe?=
 =?us-ascii?Q?l/ZdRLw0dPS8/C96nSGaWYuf4NbV3IgUpd0/Xp6TeO34PBtJJYs9VP3saDDU?=
 =?us-ascii?Q?mm9WCcXLrqjBG9FUSnxpn2+TU0lLSHdJ6cJoLKcDorppcFWlkgprp7IMq50N?=
 =?us-ascii?Q?L6iVt80lpGFzcEcwFWoTRpVfsV7jx6KU5fuPQGLhyf09fh0K+EgU/ei4O9vm?=
 =?us-ascii?Q?WwgKyLI/87yPu/bV60Fq771IVwgVW9DB1y7Hh1NNz0Z8qzj4rSAsSKbiGE7t?=
 =?us-ascii?Q?dT36URRKV3qkivuINoT3sLiEJto5aH/zb26Y4mpQcEJCeTK8AVF2+iKluf5n?=
 =?us-ascii?Q?9zNwlGTwFWK+DJbo8V/6IW4l9DGNV9uYUQf61Exry/g4n0b1P5nO7wV251N4?=
 =?us-ascii?Q?dkKgZLXC0SWq0xnBezJAr044abbnxFg4Ku6PjY7eBfgNAy+VQf2WuOhcaiCu?=
 =?us-ascii?Q?Dl2G1KEXzGqabAr3NVAGJzwAEgR+Hlv/mR4A7peXZu6O6Am1KVaTLWXbbX5B?=
 =?us-ascii?Q?q+IGmdF4pLJyA/L0gbAfHtQQLRngnTawoU/PDjUjP0UGoc7DDPDn+cMjkiKZ?=
 =?us-ascii?Q?WFJzC1dqnDxcbG/w0PICpcFT/w9VFvs9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ir63UbHSFsohgZQO4qIwGkYoHqZkzKxDja80oqr1dKE7+pWP1gxHkXkpnVG?=
 =?us-ascii?Q?QxJGkREWBLroi+vgFvzYUinEnl4/at4znXguBg3RQ6Q8ORWP9YxNQWQrpMC7?=
 =?us-ascii?Q?C37alNzisugFBSgFyfcYhQAGk+6dYqN+61la2JOBV3nVvHIyW1lW7zbtHvr0?=
 =?us-ascii?Q?ylpw2d+MP3vbku+Mn8M2SqPXnxeyzC8j9isVhchT+XRjWu9P8YxQ8tEvvEB4?=
 =?us-ascii?Q?XVf6aaX6bTrzxyUHSQZy7ssGK/w2I6nkpX+coBAz1u3yUB7+O4+cBDsLUtqZ?=
 =?us-ascii?Q?ZdVdXZ3SsW/mTlnkxHkzAQB2xNpctWJ5h2adWtjs5kQrJdjVJskSgJl2EB4u?=
 =?us-ascii?Q?IhcdGLmxAgPBi3ojAHTCs6IZ6pRYRODCdcasAhhb17K+0no3ZdVmE2S91UTw?=
 =?us-ascii?Q?xtJwPcU7S6EhtSDt+HDT6hY4fxDETdjO5PLGuT8MAg0xec7rJMl/DG7vn/h1?=
 =?us-ascii?Q?FIOPr+lrVxS7qhwb5yZaRpq7gJE1Ir4CVPioeSEWcv+mtMRtMxRzPGRJGel2?=
 =?us-ascii?Q?k7OIsVEesjY1Ij3tRkWPwh0NYL5FjxT6laZrEs8uywZxoO49csKkeRC3Y5U8?=
 =?us-ascii?Q?1zb0RB25ou2AfTHFrLKEWMkb/Lu17k/lOcEpm1C0+eF7qYsbKC7dOmHqw8H3?=
 =?us-ascii?Q?SFTMunudUK4EI4S5cHVBTOeevdGhp7Ug/DhnksGGPlu/t//FcRZ5Sktg7D77?=
 =?us-ascii?Q?bMnSdynkj+tjitwBL7nY1sKQieZyMibSijmc5sb+YNaH6ahcD2aj7o/rcmq/?=
 =?us-ascii?Q?ZvXffmhoUzXek2y+iVZq+SI4nwkXu9RclMfHfsC15gAQOwCymUqwNMV3755R?=
 =?us-ascii?Q?GmVzUh2qyfdD+Q5/oOAmpmDCsBRHdsNisjhMPGdQNXnMXhIMDzGCwZ04zpjj?=
 =?us-ascii?Q?nzAVhqSrqv3mVNJRfbxl3llzEunFXYLhnKE0rmiKthTIipyKZOXp8eSRTWp0?=
 =?us-ascii?Q?fNWCYz8AVovs4DD0yxVEri68k7Fo9aHkb6Ov62SfH1AgqXEsauXUvgpj/E2u?=
 =?us-ascii?Q?4+uAUwgBHk2VWJfXNsA8xLG9qmNANsOLZAI234X20D9+Hg5QX+Uq6tJuI1KR?=
 =?us-ascii?Q?kTEJRxgggQd8ZMWjm3Y7J6ORDCnhwW2aAuARpyF9zJn/JejsEM8iTnanY+ND?=
 =?us-ascii?Q?E1RENXyGj7WzCBsiWxMDQtUDlTpdDYrTQ47f7OR4x3gXQiNwBQ4PVvzSs+pb?=
 =?us-ascii?Q?fQlWN4feRCbiCY90qQf7mWjPZbe9E32sWFi2RaB4JZvIAqfWBsGg4o3bZlr9?=
 =?us-ascii?Q?uvm6zj68Xwpl12KpGZfZn+mgpDWEiaGW+dJhLvYVgLiQP+vFuaFBFnstqO8a?=
 =?us-ascii?Q?gUzkjOydOOqc6J1UN83DxAtssfq8NJDHZzGVeWZWJ2zmhC2bsdb5vs5+ebdN?=
 =?us-ascii?Q?hLBN6AEdAynyOS3VSbOYoq0EK2q3p9IItLUpC2MLT9Ua9XhwCtcUgGNnqeJL?=
 =?us-ascii?Q?329a4zs6RZgD+nLxuRTcMmo81LYDvPT2SEeJk51EAJqXUQg9po5Z+n0E1yee?=
 =?us-ascii?Q?zjp7hCUJZifm7i/HyczjFz2frHyuAb1cMwcHh6V8mWqZM6eZMlml+6BUn7TN?=
 =?us-ascii?Q?elVMgfH/oan34N9bl4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a3ef05-c79b-45d1-e727-08dd452b539e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 14:50:54.5197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exgeQYGKUuhJJc98NbJgZyh6Ux8TGaqpdddzsOwbY3fd9t0DXew5tJQKuXRtBMoTNyVoxFFjEbDbXc5reHtieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5958
X-Proofpoint-GUID: U5jNj_pAVf2W3YOpyY_Q6lcWdirN3Gpz
X-Proofpoint-ORIG-GUID: U5jNj_pAVf2W3YOpyY_Q6lcWdirN3Gpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
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
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Friday, January 24, 2025 11:52 PM
> To: dev@dpdk.org
> Cc: Jerin Jacob <jerinj@marvell.com>; Akhil Goyal <gakhil@marvell.com>
> Subject: [PATCH] common/cnxk: check MACsec HW capability
>=20
> Added ROC API to check if hardware has capability to perform MACsec
> operations.
> Skipped MACsec initialization if not supported by hardware
>=20
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
