Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA4EC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E0A14064A;
	Mon, 24 Feb 2025 08:15:09 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 98EAF4064A
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:15:05 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51AV0003303;
 Sun, 23 Feb 2025 23:15:04 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyku03j-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDHQGDk+gcY2oFf7VbRmlxxyL7HQoWgcjEgBmwReQQyvMSx/ebr70qKLGQUZDwFXxDvZLSMfsThCsv94PD9TqgrCesc+cdU+pqUJJj86aqPhN4rm5exPKSQaqEoD9Bv74BCNZiCkP1ufhHpLs12W+NV46gsZclqhWQU6AdJI5WhSccUIQI3KS2EUrW1H5PD0W82uGlLBcQjbDq+Ai80/NxFACoifvd/0IcfIIARPW9HTqptqCf2MRUVhULvnycef8X3yPPfjPfMR28w6Kd/iKrIHmfWpLs/wbclBozxu7dy+z1LKtIxTNASXTASom1pab5OlWZV1NwnXa5lqlo3cnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD8QkDco9/50pMtXEIPSXHB8oeu66QENeawPQY+0wco=;
 b=ICsOdEf90YApYiM2nKzSvJ2DHcz1JtwmJqjlhM/NAj1yc6V07QPCDm3rIVUVC4ivKGfnz2Dl2xxzM7ARzwfUyJQK1PWaXiakiUBv+97F3NRm3gQR/epmYlpU/YvAyZJ4Ypz8n9ZkEMQ9TDh1X2UjC37I3LiMsMKzh+Ae4ck4gRa9jeck4eYXr6oyTAs6O0dFdAYbAeH8mvZdDspwpLaMORl9tET9tzqXaoDuHJxvW3/N20Gw8JjOs4Y2CdQwf/KGaqNKgF1NADTWxZJB4ZYq5gBfFculaqGD0iJjHqzW3BTw3nPocm4jajWyY2Cu5KIM4qCXekaBtffd22nRGalicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD8QkDco9/50pMtXEIPSXHB8oeu66QENeawPQY+0wco=;
 b=csnPFvMhvfBD/I7u9JCX0eMvZllycnS0KDVLK5ItR2ml1+LlE7hf+0mzVY1XSUqijFUlZCI7qN5n3w4pkagDZSuLQRGX/UIqcPvXuGl0Ue4it00OoOQIuImZMe9pC//kDQ76+nlSZy3RKOEJlyW4Rni0L5RwMPAIeBOlZIvOxNo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:15:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:15:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Jay Zhou <jianjay.zhou@huawei.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [v4 3/5] examples/vhost_crypto: fix user callbacks
Thread-Topic: [v4 3/5] examples/vhost_crypto: fix user callbacks
Thread-Index: AQHbhQUtvB2Dloxe7EOtiUxgKak6wLNWDYpQ
Date: Mon, 24 Feb 2025 07:15:01 +0000
Message-ID: <CO6PR18MB4484ABF93DFE64DBA3421CE7D8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
 <cd9c3a5f248ee8b6c0ad174a003993875bb3ee97.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <cd9c3a5f248ee8b6c0ad174a003993875bb3ee97.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB6379:EE_
x-ms-office365-filtering-correlation-id: 1c9d719c-e25d-4af6-0573-08dd54a2f408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?269sIsklSRlhOZHN2CIhPavYmwdNAGj3E69eQerZNI8zfQXPtTYegqHhgaIn?=
 =?us-ascii?Q?5Pf/XOFg+jZunRgXVUMAg++tmJfUp9O04azFcrcEW0i0jV/EBf6ATLuU+kZP?=
 =?us-ascii?Q?nR9Ydlgx+r603uJPnQ2KXXsSlX0Aya3t1NZUetqmbnjnR8Bf8u3TLHI1m8mg?=
 =?us-ascii?Q?SplUt6MWdAlO3RqLGv9Mk4iBUN5Fo6AhKrEk3SSPb/Mh3tFxLyoeWfO/niB2?=
 =?us-ascii?Q?JUYCsh3Zu1aYaRd0RFVbx4392CfWxcGVfgY11/0ODD/t3Kv9FoWFJ6+rzmBY?=
 =?us-ascii?Q?HU8blIrWZQajwobSpfUfsPGK5ECas2Yy3aIQMq0Kmw6DfsntxTV0dgxfNSu9?=
 =?us-ascii?Q?xXXUCzuAkRThSgPU2l5x9s9yjgVeFqSeSbPO9cHpjb+worUvSBvNGB8+4+sl?=
 =?us-ascii?Q?IBqZgR7ZOX2D2ivy3l0giKvk/jZl9/08b8WxovhWy7LgSgu0eTDOCj8xAao3?=
 =?us-ascii?Q?EU1UnGffIlyRy3NwTfiFk8RdhOUPyX88vEnABvy6lw8W14vyIXGiHpKoNxjW?=
 =?us-ascii?Q?sQWCC4ooL3a0858I0lGhRYE3YsSdSOqErd2ElV2HZ1ZJ49SuyEICOH2RlAsB?=
 =?us-ascii?Q?z0llmEUn64ZiCIYZvnO4qnx/PLFKFJ0ENYJ3FOd+9dbQynnDVjocPqhdZkHj?=
 =?us-ascii?Q?Q35bjxAruCPjs5CDICuxfIi8V8u29UR1ct1MVd5xwslZUK9AEXkmhmPQ5i67?=
 =?us-ascii?Q?dPk0UiBERkt0F6q6kQUK3tfVTMIwHZEWzDtlYegwSCVuTsaKl4tZkF1WV0tj?=
 =?us-ascii?Q?hBmGYCRHRToNeDi1rJJZgaASmq0dmEZLXejQxJn+Cw6NV6v/4AuMN/LfcfX3?=
 =?us-ascii?Q?5D4YxDWoqbPp8M0HGOLpdHxlHydFf5NBxrfdPWiYcjF/2trk1zn/yk+isx+O?=
 =?us-ascii?Q?MfTLvM7GClRysaq4sOcF7TL/MIdC7s+6mKRbMYbpsE9zeSN7N49wu0O3veUS?=
 =?us-ascii?Q?w6exydpJQBop720Go26AfQ4CJsaJ//9tu0Pn3XFyY6/VhO5BYI6B2XR+DbiI?=
 =?us-ascii?Q?mMmG+KFVm3mQc5xCq7W9nN2pKYNxX4PDhjBMfMoK/75zTyQsqvdUIbwDAaM7?=
 =?us-ascii?Q?xCZuj+ILSsTiKBJMIE+lAm3omMx2TIxFLjk4NLR+XqV165ubxfnz6MksZsAj?=
 =?us-ascii?Q?Tfn+bB1Iyyk9IqEiTKCOoLX0QSJ3bXUAFpxfUbuytqUhGSSwUwvGEFgdR1ZZ?=
 =?us-ascii?Q?gbOukjWbSC8SWjFkO4fMcbK6dL6++RMhgX3xa1JSGevKyk0Smz+gpjqjQvXq?=
 =?us-ascii?Q?bkp0iWKltBoPIU7+AZb2tn3rPVRK9w4G2XfhWnIE8ggfB+x/dgh0ZsZWZabU?=
 =?us-ascii?Q?dfQb3WEnKQBDTVdQ/MhQdPtRWOm5g+t5cDWkqhT3IotVvzANBoi1imCzIzrf?=
 =?us-ascii?Q?hUGspZ4DKBTsYEu8R5nOU1rG6jfZ7mgpMEk0Wo/RXYI1L8y+wltaR9rfto9d?=
 =?us-ascii?Q?5STyEsOERraOW36dza0A24dGXiIGlfPN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k92zuk1SeJtooVOJlehBGPWXRE58C0p9MypZB767v04T4VEjchR42Qkl+qve?=
 =?us-ascii?Q?dn84bVB/L7k4Ir0fWZ6llHtsaxZJXOThdmZRpeOB5R/Jsu5TLi36hERjVQBf?=
 =?us-ascii?Q?0b/a6Mvidvqb2DPbyou6gHGrGlpoTkuA+CnZRjR3zQu2RjPYjjoHFVgvVKFx?=
 =?us-ascii?Q?B9jXWnjJsah99svHispOSPFSrDVw0n4e9Y+ZP0sTS1wFcgYdyzflI/ycXTZ1?=
 =?us-ascii?Q?PVOmHhMMTSKxvZ5zG99tsyjyE5FSK+Yl0NpJvAiU67umQcUtxnTbfz0DiJqB?=
 =?us-ascii?Q?TdzHXFGmudXBTZG9RRZ+K7JHuOGxZSWERStlK4xPjDgvTbJ3QjAGa6Dqj9j7?=
 =?us-ascii?Q?bJEo+sg9YqMOTPW30y61q1l8Da8FzK0L2DXgs5a8y77nggnAuC+hcyiQfQGZ?=
 =?us-ascii?Q?3XH2YApYfvu+LiwyEAj1+zqXFD40QX1+V8AILFJhep3B8RBPnRTGl8w8dAt5?=
 =?us-ascii?Q?Gmlzu1GE5IhnuzhOK/dHr9UQzabCMBPPV4P9TOHIlEwMIK3UqV5UE67z19Ao?=
 =?us-ascii?Q?aimf0M0DcPeU+U9xMugDArVpXlVRVqvEFFBJKC0oekLIbBRXqHzgt0wRKtDH?=
 =?us-ascii?Q?n3JRkEx7QtogvA4yKlhNrPyhzad7ttmJcI+PCCsR1NJuLg4VbLlszybMAbNe?=
 =?us-ascii?Q?wTM5rDUEOFPpjd71H+2h5+gpsmSPvuQ3KQ+R9tYQaoPr+jk5Fx+f8cDJooqf?=
 =?us-ascii?Q?OdpimfV9w6g90fVqtFOx3zr5Bf5fkNMKnQYMJiN6EqP9gDwbzCy7UHYKOxTU?=
 =?us-ascii?Q?ibKVzQzwfAZFfJz5QKgC4a90qR1LpVcix355g3EV+4/XgB563FWWwh+ORQfj?=
 =?us-ascii?Q?ka7RqbkrpUWANhQd/L1G2cUFmwsolzSj737FdQ3OqwoPWJMWVPZ1HXOxlX/P?=
 =?us-ascii?Q?KtiL6kxtwIvGEHWwsvnQnFUgE1rtqLC1qNpGQYAq/WL4JDZfPvoAtCWF8R3j?=
 =?us-ascii?Q?CE1nO1HHLWdnsTQFy+u4HAKyoHIwCSPYkyL+Jgcob09e0qfHkIgkZJarNfTG?=
 =?us-ascii?Q?4KtBMEuASt8d7ALDplKuKkPuDen5sckaUk1y2kbeQiI23LT+yKhvKqZXbNED?=
 =?us-ascii?Q?tOwZxNCBk9nVeHSGLd86RBi7EPBacVpkZZDAn7PnGS1xuEEhoPaddJFi2kF3?=
 =?us-ascii?Q?QuRPmIjAgalLq5lLtsjGN8Hbk18tigA3T5tx/5C2jkmYAyyfQHUXpqGZR1HF?=
 =?us-ascii?Q?PmVpZbodKprYM/iGvAxf/tQmXOJSQjCl8Abql2oU+W70IzWnCyVi+OKXxhq4?=
 =?us-ascii?Q?9neMMzxksUQtXDqXdl8h8iRkvN8G2E3basLY71DTI1KJZxAwN/qItntOJ93h?=
 =?us-ascii?Q?dWu+BjZ8FglLKqSexfXwfZ/hkJx32ppD8Jcxh2ZLj7vZ6Ch7ferjvsEuON1C?=
 =?us-ascii?Q?iZ3gLIyRpKC2StOOLtdt8AKwQiKGZCTm4n3SOo+vu/jLP02t3R61pGwhKsr3?=
 =?us-ascii?Q?5gkak2nPaI4NHm+Q1N3wAWgWR3aMrsRFAjU0Ty3kdB8jThDCbqjNK9luPUOg?=
 =?us-ascii?Q?pLox8HvebIj4G3ravJ5O4WPiGWAB5xSFodbv71Mct5eldeAY3K9zrZK3jExG?=
 =?us-ascii?Q?H4dEMXIyvtrizvCOiE7VgAKl7R3IzgjynN6I1jRh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9d719c-e25d-4af6-0573-08dd54a2f408
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:15:01.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZd/oMMlh6KspnZz74IdOkmvrfEHaALeYQxaYJal5ED6oZO605K7eVH5UzcxMEgTYowk6CyodCiiSlvv1WRItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6379
X-Proofpoint-ORIG-GUID: Cnw7jT2L1nELTPX_6_ZbOwzT3Hrf_pL3
X-Proofpoint-GUID: Cnw7jT2L1nELTPX_6_ZbOwzT3Hrf_pL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
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

> Subject: [v4 3/5] examples/vhost_crypto: fix user callbacks
>=20
> In order to handle new vhost user connection, use new_connection
> and destroy_connection callbacks.
>=20
> Fixes: f5188211c721 ("examples/vhost_crypto: add sample application")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
