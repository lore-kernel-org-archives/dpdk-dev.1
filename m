Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C56C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C32A40661;
	Mon,  9 Jun 2025 12:03:38 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BE56740658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:03:36 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597oOL9022084;
 Mon, 9 Jun 2025 03:03:36 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2123.outbound.protection.outlook.com [40.107.95.123])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475ujxr7a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 03:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxDeOftPFzVvSH8o0AsJ8ysR5x0JmN8hAMgP0/sywuAoFFMl1jsu0jgo0a/JY2tBlyiGl2I/s3n+uWE44gCm91Ar+DczT2h+6H43m6YuESFLalc8zBhhikEeHB2JHnB02fuX4NZegW9ZnjWW6TVL0XZy5LWWnId0Tv9/xyQE/qzfGEHVq9HJQnTNToarZe0Pu0YcbyQcq6TSWYeuEhaQagte+rG781nh6amYCRZwlJjbhUPkMwJ6N5p4Mjnu1rUBqEPdcPtjwztMEbdnyEdpSz1jZ7vCEqpgbvP4Qcsc2FUfN2Aek1d378cjYdbNrotP22BHxIy6E7aHf3D1/3nYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Q8hRMlOcGW0vDtt/Ol54ixAc2Ua9vRZRnqXqgUtDk=;
 b=rjHx06Pt1XyfvvOdsfxeSJqByODFh9KwyOpU7G5rGwTUkLtnkLLBW6uf6+M7OI1ZhqEIz47NBXyVMFkQDKDs5QSo8hlCHtDZt+mlDjCDaxkPMlKP9+rHA2+g1N1wlRLST+7Dg1CpIRWQ30hM5yaqt8Qws1POw5JVi72FPkoVkks1c1rLliJfxPcDXRvlx4h0yYoHh854Uyi6R+W98s0f8VSwM/Px5tljjQ+UG7UJrp5npkAcsCyDgstmkXYgtAGfDi/emb0XDwxXYxBPV8DyZHticklTnaJYpwjFRJTm3J6dB2dgs40kxFFuVGD7KYPosmFJRmhKAdm3AKDLiClI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Q8hRMlOcGW0vDtt/Ol54ixAc2Ua9vRZRnqXqgUtDk=;
 b=HO2Qg9z2KpT11lZPzicKETah3KvW0UuVzAjc9WevZb43BOa7g4IJJQkaVqI62/2FAkrr3w2ntMa2iUhB8d/355TYjM/7fC5bUZaZ2TXwBdMwjtnNjR1wPlqksz6RQGejkeWjergiariNQmwScpPp6lCUPQ3SUzxLbSGl10ixaA0=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CO6PR18MB4481.namprd18.prod.outlook.com (2603:10b6:303:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 10:03:33 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%6]) with mapi id 15.20.8792.039; Mon, 9 Jun 2025
 10:03:33 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue
 operations
Thread-Topic: [EXTERNAL] Re: [25.11 PATCH v3 0/5] Introduce DMA
 enqueue/dequeue operations
Thread-Index: AQHbzIwhodN7tlHv5kuB45f0KOx3p7Pkk36AgBX/ob8=
Date: Mon, 9 Jun 2025 10:03:33 +0000
Message-ID: <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CO6PR18MB4481:EE_
x-ms-office365-filtering-correlation-id: 5fd18495-eeb0-4440-282d-08dda73ce499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iEQTwLxN9Gb+5foxtI8i1qI1z/6vMd7h7aKVW+c5YjX5onSRp5e4aLgKAJ?=
 =?iso-8859-1?Q?Xsnx+8y4km0y+BlGbNXOW4bhpZIHOo5tz7i+BD/wXvnGU6La6SO1CM0g1L?=
 =?iso-8859-1?Q?w0JFaI/Ke+1P6Akxjemd1gsohVQmkxM4y9SMZgokdLfhwk4902L6S0Dm3W?=
 =?iso-8859-1?Q?euSMxh4km+Mt6neCPGQlexmg6c2wJ1AMzBSfDyiKjUMSaXqwFSz6yzCAgZ?=
 =?iso-8859-1?Q?gon9LfBzDQysHWtFRZm0y+l8Xqt6NJB29rMKjo1DyexLC/5N30d/HWqbYL?=
 =?iso-8859-1?Q?LSwldXJ4szS/SHyxWkxsk2DaPwYWEzKrc0h6h3ss2joY8AWz7GDihhqgBG?=
 =?iso-8859-1?Q?PWPqIRDQWDEvO0Lq7tyxUxgA7DmV/D94DfAoMji9dUAjStCl08+VWZow+G?=
 =?iso-8859-1?Q?ylxNn1qdAkEA9o8BbhRzEE8ankVFokSOD7oI2GQ6kP+ktAAhSJqbYELiHi?=
 =?iso-8859-1?Q?646c9juJhMslHvOlnPCfxtZ4/iZl963sgpVRl0JNsXTS/isPnHmx57zF8n?=
 =?iso-8859-1?Q?Z9ceAXN/9JsYsOfV7bPCvgZ3kZ6OwMPWs4oU2fXlQd7ghh9vwEYiEukpAQ?=
 =?iso-8859-1?Q?lXOU6xEG6BWK0P0t8vkBHww1mWxgkozzbs0rYE447AVUswoKpqXffsbDbg?=
 =?iso-8859-1?Q?ALyIpqy0jGONtTXnuWu/qlQTmOy/NZZz7JG5hQktLXzduluL9zX4MvhUpv?=
 =?iso-8859-1?Q?6Jfzk8OsZWkC+Z4WJ2dh7yfJQiSLGrausidFX8XL7UNkswxohRoNbmzrLv?=
 =?iso-8859-1?Q?pct5kNtZ9XSujotnjclX12t1BvTflx/a+zJzr/5WUZdaMKvVLsCQKNJlUA?=
 =?iso-8859-1?Q?y9br8QagGPvAPBXPOo5INTTUPZE1d88pSjfIWFszECVER6BujbZHO6Cynf?=
 =?iso-8859-1?Q?rMKyAPGRpUZtN1G+bviOgugiY3J3i8FdkXTvoqq3PKc7plSolsmk3eUe9Q?=
 =?iso-8859-1?Q?hICRDfooxVcKA72QDj7KtJ2rLP4+Kxr3TsVMkgV34dNBzR61oX5xCBvCjz?=
 =?iso-8859-1?Q?GqDqygw8puMdMM1UZGNqTuAbDAO2Acfuygmu9jo6IxMHorjx8SxQOMdbDe?=
 =?iso-8859-1?Q?VZspeLE8qm/zegGFKECa6/243hZqXbllDK3F8rcmN3/7ZTWUvUPtOf1oNu?=
 =?iso-8859-1?Q?KEeccseHY0LR2tGDLBHI6Q/FgF+/AQjbHs6tw0yZ1y3CJj8iYdXjcibw4+?=
 =?iso-8859-1?Q?TAVdxy/hUA7fttf/gG2jAubs2kTmQwAZYckId56b/ht0/KEghKhTINwP/I?=
 =?iso-8859-1?Q?/GjnXtksYvdl6cIjwP9vW4CWJxscThpRkN3rBHzxJI29HX48ztn0QiLKSN?=
 =?iso-8859-1?Q?AqwTuFYA3Jcosc/2R3QSuCuGpUUi0k4b/G9K95tunTK1qsfU73xAYQqTOf?=
 =?iso-8859-1?Q?34GD0sqacez9EcMzX2BgSsfPG4MyL2kupW2zdpEb/glx94HoR27Pr/lOlv?=
 =?iso-8859-1?Q?bI9RYAHcco2zwToVfzG+j4gObHyikm1ABgpyXfdmiRT1sWXu4BkoL5a9Pb?=
 =?iso-8859-1?Q?qx4XHsmeMvDlIXieLUbgwP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w9tzAxGJafHdfvXDyXO+SkSBGVAFvA6oET+FNXVhNiuist7tfOdFj9GWF2?=
 =?iso-8859-1?Q?wkqrQIF+BNLpYSIaKVT7ZcVCQVUuyYTu4BO+CVOqole8EbtwresO5T0Lv3?=
 =?iso-8859-1?Q?Dgp8X/EnIPzrbAL9cnKKh2BrcAdBDG8AJcAkV2F+oFQYUQbQ9PPgzxNGuM?=
 =?iso-8859-1?Q?8gpy3whrGPcfMl0sT7YigLu0JIVYZUMMLt6z2xG2xw9ZYXJcC2I3YCBmT9?=
 =?iso-8859-1?Q?3TS3OWqs8fYnfBQWKATZLuxozk2ocsIyJ4ABGm2zkM/4hj3E9SucNLEfbm?=
 =?iso-8859-1?Q?/yJFSZZQV6MS08msD3Lf0+AwBBi2p5Yt6h8crSHjhkBkDUcCOllO+mKVzH?=
 =?iso-8859-1?Q?pHx9eyaDhu03KDLJhdHtd3EeqiDRVZKG37JCRnHNLKJJyIDZiRwgjztoEd?=
 =?iso-8859-1?Q?8uCN+5AWZcHy/SAtSCgs2nzTtbmlRQT+EzZOIWzm+hvjy2P1pAeRZoGRHn?=
 =?iso-8859-1?Q?rjWFELCYM9FnmCk7BGHK7fooENoaC1wJzkquI0n8p029sbeZU+ZAVpWnam?=
 =?iso-8859-1?Q?XXpKm1ujhN29bDrogGDE8YSyd6l52fFykwGTMbQZO91gK+4K1xgK4X/0KH?=
 =?iso-8859-1?Q?qWKHamsquxLtV/F0YCNPm3rp0ZmSZPXKSRMs0tHVrFBOA6EywhQzp7vH5h?=
 =?iso-8859-1?Q?eNetIx7Ckmtk7KtQUrCJpv3ZcXGITe0H7snRv38S7VNDZOOzeHnOpUpZ5y?=
 =?iso-8859-1?Q?ltIg9jvtF17bO82AO0EASfk4opY5uVEckNunP6gvIvZ3KBFzYkHrEStwLe?=
 =?iso-8859-1?Q?nuuG8qZzmBtqXIJ2IOKtbF5XDt8MBiiCu+EuWvZtH1Watsu26ejmDUGBIx?=
 =?iso-8859-1?Q?SX7h1EiY0wnBZMqyxCBlsO8cJnR0E0z/DXpCNcc5WqW4kbDdpDoYfZ7+Qp?=
 =?iso-8859-1?Q?5B3DRUAnygYiOVKGXgKzW5Mq6SnomVGoPi8y1Po2UgGA5UW3BOqNtAM6Jx?=
 =?iso-8859-1?Q?3F5vjhtxE2Bb3sVLI7cmIsWUBD0TTROAq2Z8+PnGKmr29/ZSu7jwXxD7bC?=
 =?iso-8859-1?Q?ruNuDNtl+GYEeZm1Z6YihfPk3wOHUpCApIqG47UfxGsTvlMzHgE+Atw+Bc?=
 =?iso-8859-1?Q?VCTVD7iKcq1vdgLeDmY6HPU08Y69hGUoChPUoJu8y38CsIAqdtEYtO4dq4?=
 =?iso-8859-1?Q?SYJlqa9w9A3M5YEXhpa2bjlfR/pGOHgL69P6I6WM4e4pj38ahlFsdzZdKu?=
 =?iso-8859-1?Q?aqXoE4Gi6Ik/9dZIA1qlX9yWM7jCKzWrjHjsdxPNvniyOGJcFieT/Me02Y?=
 =?iso-8859-1?Q?DOhMdpd0KILdXYk0byNqwHFN/2KqNdmVn/u6sgnfy/ALMPdjBRND3co1qE?=
 =?iso-8859-1?Q?7MaNJG73GJ3OBXVFrz9QP+DCcoHs+SIsKxPZdQyT6282jsTmiArb52SacM?=
 =?iso-8859-1?Q?UUDb7Hs3EOb5f/7xx1SL8Rq1mhXvvNlNrztOfQRXu/uxgJ082CLY+8Bsvs?=
 =?iso-8859-1?Q?bTL9mdbrjrDBpyGu8Og9JTtyqOgig+6BhzpI/qFFzxlgBELS1n4fAJmXNU?=
 =?iso-8859-1?Q?lqGll14pi0Pys/gy8rhnHf6FalKwuhz/YJcXgUNu+C3Q8MydiABAJvzKaT?=
 =?iso-8859-1?Q?yk6YI9RqBNMKNZj8pWMBhptVv4M7n2O6A+j4tqo6f++0y6veOm9E9ryegD?=
 =?iso-8859-1?Q?ymE8Q1fjfckV3daUVLhSjfixEdrcLUQQNR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd18495-eeb0-4440-282d-08dda73ce499
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 10:03:33.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhhA8sTINCSCqcFFfdtmC0vg7l2vp+D3jh4vBHOSUF/gFi26a5+TgK23LG8uWiACvouvulSe0LZ1wrr06JTUtepM4COYr0SYWBowSHvdIAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4481
X-Proofpoint-GUID: P3wZy5aIED1cPhMxAvavN9lqbc-2zqm1
X-Proofpoint-ORIG-GUID: P3wZy5aIED1cPhMxAvavN9lqbc-2zqm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA3NiBTYWx0ZWRfX/Boj/j7Wkbtm
 1iIqw6BxRn/lKdm6y4nBhlmtul1XZcleqyO8h+ZdIj4HvkX9QVbbZOXwEswYhDmnbQViv1QqN3I
 l6jLZvVaTKDf+ixJ7s9mfdPzpkSGHI/OiFSx9O46wbkKN61vPXZrG2W1xsFNfjm1jBHyhBVaPwR
 a1+Jioo9DrxXAysuBct6kDWTx/x5iMeUcr1b+3Flp6BAe/t8TF8CqX8QCZ8tohKnGzJlgN2VXU0
 5eLJuDkFGjIDamCM5D4oNLihWHWdwN1pslL/ke2OAW2+2K73S1oU8aI5CJ4Oz+j1isk+XHp3yaT
 x24j4aOMVogLVugVhzqvbtJ11EzRLJGQdivumPxYpDBpwmMVGgFp5lDvkimrFUYaqivoqm8/cSV
 +dvYCc1nEsWl8FJdMl6uZRePiNyw3W3XXNHEixxdSPbqB+ltoOW31YFSVLUKRg0lWbZhUOi7
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=6846b177 cx=c_pps
 a=G6LdU6/ch32BE/ZEG49BIA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8
 a=j1ZIONBRK9pXcQU6LHEA:9 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

Hi Bruce, =0A=
=0A=
>On Sat, May 24, 2025 at 02:43:10PM +0530, pbhagavatula@marvell.com wrote:=
=0A=
>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>=0A=
>> Introduce DMA enqueue/dequeue operations to the DMA device library.=0A=
>>=0A=
>> Add configuration flags to rte_dma_config instead of boolean for=0A=
>> individual features.=0A=
>>=0A=
>> The enqueue/dequeue operations allow applications to communicate with th=
e=0A=
>> DMA device using the rte_dma_op structure, providing a more flexible and=
=0A=
>> efficient way to manage DMA operations.=0A=
>>=0A=
>=0A=
>While I have no really strong objections to this addition to the dmadev=0A=
>API, I'd appreciate if you could explain WHY or how this method of working=
=0A=
>is more efficient in your usecase? When designing the dmadev APIs=0A=
>originally, we looked at using both an enqueue-type API as well as the=0A=
>implemented individual-op-based APIs. IIRC at that time testing showed tha=
t=0A=
>using the single ops directly was faster than using the enqueue APIs, so=
=0A=
>I'm wondering what exactly has changed, or is different about your usecase=
?=0A=
>=0A=
=0A=
Here is an example where we see enqueue/dequeue ops to be useful especially=
 when =0A=
integrating with Graph library.=0A=
=0A=
We had to write an entire wrapper[1] for tracking sges with the current imp=
lementation =0A=
making our nodes[2] very complex.=0A=
=0A=
[1]https://github.com/MarvellEmbeddedProcessors/dao/blob/dao-devel/lib/comm=
on/dao_dma.h=0A=
[2]https://github.com/MarvellEmbeddedProcessors/dao/blob/3f364261de91e35569=
9bd9af20d60ea6459f7d67/lib/virtio_net/virtio_net_deq_ext.c#L51=0A=
=0A=
>/Bruce=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
=0A=
