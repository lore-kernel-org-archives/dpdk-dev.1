Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99936C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 15:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E948440A70;
	Fri, 11 Jul 2025 17:05:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3775C40A4B
 for <dev@dpdk.org>; Fri, 11 Jul 2025 17:05:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDJITL014440;
 Fri, 11 Jul 2025 08:05:03 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2093.outbound.protection.outlook.com [40.107.212.93])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47u3d2r6m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 08:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHvH46H0y2QvxarWSUxoQ+RPSZ3Zsx0iaSY6ZNx2fczbC7QHYp+3HLoHGZSN9zzb8EjKYnvDv7Q2Zs2LG2hYorOnC1EcykuvynljuzXZIYWtnPtI1JHxIl3tINoEoZCq/Yy1dfuDZ3jdIT3YjPzyDdZCi0Iy0EWYEuT7vLag5Nh/qV7SWvhndZqYMsxUwO4Td9j7kE1r5NbO7WQiXyiAf88IbDxVqh+0VoVmvAlQd/ctLr0xh57gUJcTOlpqBP88uEUAQEYO6QP02AVZbwvhqO/Z5J9jyz92H9pEcqqZ7JoqtNo45zcGj/eosCtZOuOpBCDCeiLLyiDoPBlSqmMxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVMrpdt41zbVeFp1gsXriUJAbuiHy3PRyabH/oBz20g=;
 b=oEw1XJNvxTRK/bWhb6w+hbx6R4ZgJb9uzrngUlH9QgysszWVRHxhBd92MweL285okMuD8KLdqzUIZrlsNCl5gAE1+2tdKWcKvaa7DySr+ZFHfEtQAToCkNV2jU0eFVrihXsWf+UdxcdrZRnabTxlvNxz4C8+2jO1obUG9tqDAry5BEadMMWeLln5l//Oz4S+d2ge40koiuDrgSv667Jg2mtfI/1b2dThMEKeGDHh864dcCZIERG+qSOofhK2XR2mxtUIPv7Ghov2fMTWXiSv5wNdigEp8HmazsnICuP/oR8JORELSjq8+c+wNDckwTiEXozFt3j90jiJQDreQGKuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVMrpdt41zbVeFp1gsXriUJAbuiHy3PRyabH/oBz20g=;
 b=ZmtYRVMlO+mNnn9plxLfZwPnZFGEy4Sdj0siZXhG4ytT+O5h/SaSqiR0X22Ml5YqclSfIWRMluh4X1QYgk0QyoFSdYBDAB/ItQAGBU7OJo0js9n2UDVEpRnMX96cFxnky3SHUk8af2iSnHfu/uxkcvwo66AUOS/LdPlEnKT8qq8=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by MW4PR18MB5229.namprd18.prod.outlook.com
 (2603:10b6:303:1a5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 15:05:00 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 15:05:00 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "fengchengwen@huawei.com" <fengchengwen@huawei.com>, Pavan
 Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "kevin.laatz@intel.com"
 <kevin.laatz@intel.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
CC: Jerin Jacob <jerinj@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
Subject: RE: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
Thread-Topic: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
Thread-Index: AQHb8XfRKNMasGVa5k2gdx02sHfpIbQtB0KA
Date: Fri, 11 Jul 2025 15:05:00 +0000
Message-ID: <SJ4PPFEA6F74CA26994FC5A642907B4680AA64BA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
In-Reply-To: <20250710085101.1678775-1-vattunuru@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|MW4PR18MB5229:EE_
x-ms-office365-filtering-correlation-id: a49fa157-3420-463e-c5ac-08ddc08c4e7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9bIi3+h/4VY93FpDurXzbDdSx5IbZUuQppkzEGgFYwpBkDCtTeab12IDYvpp?=
 =?us-ascii?Q?ztHc32cRhA7NbLOne49Hbv+/Qm0B+XUpfUY9Z/nnT5qdogw5IDDaeG2Z0KUW?=
 =?us-ascii?Q?F9E/Ebj9OPjhuEiPyvhv+O7Wwv5UgkHGJdbJytu5rAEafY8wruKUtZgdQLD1?=
 =?us-ascii?Q?iNZORLg0zzp7Ots98VYgWhICaPWEODdxvSWo75fH8TZGTCpY3sAUdlK6K+ax?=
 =?us-ascii?Q?iPVLqBC5pbS/9Wd0p1T3uS6unuPR11G9ysKQeeQfR3WCZptyKz55wzKsKt9G?=
 =?us-ascii?Q?c3EpviDYEYE76KbCWd9unKq+OXmdT0Nat5WMRYcP+wqIOCWvBgKG9Sa7iwQp?=
 =?us-ascii?Q?G1Ddc7WmJpUEEwHSuM1DKlSyB5Gc3T1V6tXbQrVjm8HUqdtG8qk5GT11hxK1?=
 =?us-ascii?Q?i/nbJE+vhuTkpdMOxcS8tXk0tEVsakCj+D5aNqNLROACIETpfUC3+HoNruoz?=
 =?us-ascii?Q?tuCMj4p6R8+yJ6umPNP+6IzrOr8sKNVhSMoQcH0PGBG4sNX1gYgwdiS1BJ41?=
 =?us-ascii?Q?DBnc1X6WTsrblh+NaKCYhWOyHY9xoZHLG5mFjSQahxpcSGuDdfBrMJvfjd1K?=
 =?us-ascii?Q?NzOfcihsnxWNqiJhH4bgU/+PcfIOrxVbDD52sKRHZAMi9tWU+Y9xoGi0Jbb7?=
 =?us-ascii?Q?JnwJT24DWhBS4c+E5G8mFivsQ3d0PeQc3BvqW4gHl33lpEz9wAKNij/HhfE2?=
 =?us-ascii?Q?B9PMsSsee+8pUv3riHYOv3njdMx10McC3TmTOdIQOUwKXc01ePtPhSU55Qzs?=
 =?us-ascii?Q?lYsWRazqvrouDyzEAX+a1lpT8RM3yEZTlw+KQrlqUT91ZzItHz3iLkK3MpaD?=
 =?us-ascii?Q?SJymXZZw7NVdcxyoD+glmyjLnT7ztXHZvxFpVC1ueSgXkjNz9Zb3/5ouYRRe?=
 =?us-ascii?Q?PBl0Nvs2rWKzJA1O9EjArtkoPtR5Ie1ltiy3Sz1oW1n9dhOABENhA3TcHjgj?=
 =?us-ascii?Q?1o6LJCHMe61SqweqtkzkAx8sW0UnKqiZOs/Ncf89ICOswPGI52svBfE9Zf8U?=
 =?us-ascii?Q?J7D5kF3eqK8GKwl+JR++FiJ6EI+n5kR52i8bbdmllmJ2kJ4AaEixLcveIE8n?=
 =?us-ascii?Q?8M8K5Q8U6EyMhyOuXvqpp78vhjAnjAc+FXDZBugt0e3EHivCG18QGGtd41M2?=
 =?us-ascii?Q?NnTtC3CzsdWSdOVi0NHXC7kCIcBze/cCNGYx8DwAxQosEOFc0mi7s3rFuw0G?=
 =?us-ascii?Q?havoj5UoLJlUuKBSQNKx4az9BBN4OA+88B8N8PApbC8NZc7w/i9PAlmLoFD8?=
 =?us-ascii?Q?zoFQswZuq5d+YpA+GPPWiOmItbC39bg24n6aljt0O/EmRIT7gsMhT+hrl2Dm?=
 =?us-ascii?Q?nZOminUZMX/XI828fIzAjsa5mgC1ZhS9DaN4QpDvoQuLljE5zUMPUr/tQHZb?=
 =?us-ascii?Q?HF+UZK6NNrg3HaW8ovJzmFxHRmSc5c1wUUKDQSdyG2NRxVFEyOcPRkjEXzW6?=
 =?us-ascii?Q?06qbIHoZZqmENSwjHbwt45KOLFiqiBUJOC70dsLE24uYNquUN8xpZs/pXgkT?=
 =?us-ascii?Q?F/dt/lVIawqMbI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VtS8UoExnrKtrcf+YOUFMZB9TnX++odl5GFXAIpN2yzeHbJMEL63ryQ7KyE8?=
 =?us-ascii?Q?iLOkiKztudBwZuojsfnJtdLr9G5MGjBsZ31zLaUePn3sQn+OLtn/ukcOJEPj?=
 =?us-ascii?Q?as9JRysrEr9vCz8FOwLcY/b8yV35dE1fngaHb1C8xSKxpxakAZ+oiJODyuqO?=
 =?us-ascii?Q?bxlxnwAH7/vakmV2lRHPI4p+kc4F6ISm/MHf5f4cBMQdZNP9GB8MlyhVSbVk?=
 =?us-ascii?Q?vRGRWA7Dtp/X7VFutMPhBLuMx1DG5rmBxHKHX1G6vMWkggFiqU4Ddo3pRH10?=
 =?us-ascii?Q?jiABBekUg8s71umddvVWq2qOZXA3Z2GnvkP+muKhhzda54XUpZj9mVDc8YV2?=
 =?us-ascii?Q?8HNvNgiz5OBgg0adEs7y3xFLyCqw87CHhdaVO0yiyo06sm4/UTpqxs6eg0cG?=
 =?us-ascii?Q?TxIt806rUJMQ2zo2Zamm8rjcpbhR8dJCd++WLiPbA7UhDngkJT+et6WeqMRB?=
 =?us-ascii?Q?H6NI+ZXNZl1+iGo63NvvZLEVPH4zikBGqY/DKuQxbc2g1gC7BV0ulhkm9UzV?=
 =?us-ascii?Q?OpvQLaOZfuCatVfEuZ5b2DBb96PDLI9HOrygtKK+qVlBphVkakZ1b9h1vEnq?=
 =?us-ascii?Q?lWgYedrcjrJsbPi7fi6fB2Sy9zduv5s6bT5Wc3OR3651uxt+6/sHXrquZe2/?=
 =?us-ascii?Q?mUSeH9jjJPVQ944LZDnhxbHtg9Dp4DCaDDnvUeBELPFROFcDHfxFWdxTE+Ml?=
 =?us-ascii?Q?yx/VsbKNpn3jIa3fJRO5gVJG3SQsl4aR8t3/+EWlJBsLKJCX+I5EbaeP9oy5?=
 =?us-ascii?Q?LdD1XS7DO4QIPlYcGi3rGkDXcTEiEagQ4TH/4R4KpnatKySA6hc0vPS3aYFS?=
 =?us-ascii?Q?UgDZN0NQeHXsBESTMAPhvge3URuQ5Ia1MIyCggum3pQFKesPyMtd89wKu/Xk?=
 =?us-ascii?Q?BL57aaRyZVw1H6TUnsT1orzBKlXBhpg6LE/vLhOZZk962xdJ3Ve8KrTv7Jt+?=
 =?us-ascii?Q?6Byif+0y7LzoP1j7dN2Wc1VrzSl+3w60xQASkdhrrbWHWGsoisq7SMOAFDHo?=
 =?us-ascii?Q?rkrR/LsGw3LJnVO2eTBr0K66bhKiK8UBD5MyAWM/ywt7X2ubTXepCDHfC7DX?=
 =?us-ascii?Q?y3HRuBWAIjZHNf0sY4nI5SiB9BphK+G3K21HOdY7zrzNNpGVsCd6aUPdeN5e?=
 =?us-ascii?Q?gj7vLdI41EHfGJzzLGDbRRualskO4OOm6ML/c5wlntFDYmvJGhFpmk9ijq8t?=
 =?us-ascii?Q?7dB60/X+4/7Is+NPE0M4M2ctD3wYzQOYcmSXW4u7u2BvBnM1m9g79Pzqp1cu?=
 =?us-ascii?Q?iPBQaqHCGJf0gCQWg35i5Iq9q84mrmuGSGnbZNCgqARQD7urbvVmrlN9MQbi?=
 =?us-ascii?Q?W7isvorpIGwbcwD8PtiULZpkWTdTysm9Ty+SJlmKgYAXtP1VCQCDEMMOMhuS?=
 =?us-ascii?Q?/HDZhMGnqi5Pko4uFk4NVxmGVQcP29AHxemcjPDKAezkUR82dnqz0ZOW5Zza?=
 =?us-ascii?Q?u9r0+eiqQ99zYFElqXpAVJhedhrhaEVtOnzsaNRsDiFGwfDRbhCc2C4asykg?=
 =?us-ascii?Q?kWr+u/gfosOjOgmz/5s45ds7YixmScMPoCsxb39kHdMDOW/1V2W2Yr+dDgfm?=
 =?us-ascii?Q?sVNY/EQR4cfnhWaL9Y8f2TvbdkA2Qt6wPNI5w8fj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49fa157-3420-463e-c5ac-08ddc08c4e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 15:05:00.0982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WmOkuVNmPNdXf1JRvi5ZsMvaNYkpAfSV1DYLLmw+YmYzNon/OCjDmp4OOn1oPhYr9HmE8rxLZpMkVYmVoa21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5229
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=6871281f cx=c_pps
 a=3m1OMBc6IzFwloPSslRGSg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=n02bokGJAAAA:8 a=bt5KbKNvAAAA:8
 a=XPMsIyPJAxqLADsJhmgA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
 a=rszdq1ld3peujIA30KyE:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-GUID: 9ZPVSLMc6BK4kdJglgAiYooGVydarMVH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwOCBTYWx0ZWRfXzmNWYvglojDb
 +TSy2tWbuadGGkdGZS0aSEyej/UwkZdGU2x3za+FIJzb7FBf3a64wZJTw38XUMJvAEx540RPwge
 AkytaWavGZNAKKyf3m5tnBK/evx+oxnI6BD5dfpazS8r2FAl35Om3nxR9Lgk0Zi7+j3LIeoGFkq
 R66ecnu8pg/gYkFDuH3i8ZZYOC74Unha5VBGk5Yk5w7Jh4Uj9zB5PAbYTU2aiTqxRcPAQzwiD84
 DKHgqHHB2h3of+R2Kx1w9fi4L55WBT+fpPt2blGhGWlLKsqzAhVyKdZYBACnFWeduGGRMAoi2Tv
 Cd/ObJ0fMVCRLE3rk7yK6HbBoGrGtaaKzZoZZM2QbDB0+atqAsPUCVqf0qMoKP0m3sqhb8J3JR5
 CpsZ/YiNgpwsmJGU7iF0JAZ939KQgzkKhb//qyzQl4AOAzeuK4G/2hhxKu1Q8z3B34ZZp0V7
X-Proofpoint-ORIG-GUID: 9ZPVSLMc6BK4kdJglgAiYooGVydarMVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
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

Hi,

Gentle ping for reviews.

>-----Original Message-----
>From: Vamsi Krishna <vattunuru@marvell.com>
>Sent: Thursday, July 10, 2025 2:21 PM
>To: dev@dpdk.org; fengchengwen@huawei.com; Pavan Nikhilesh
>Bhagavatula <pbhagavatula@marvell.com>; kevin.laatz@intel.com;
>bruce.richardson@intel.com; mb@smartsharesystems.com
>Cc: Jerin Jacob <jerinj@marvell.com>; thomas@monjalon.net; Vamsi Krishna
>Attunuru <vattunuru@marvell.com>
>Subject: [PATCH v0 1/1] doc: announce inter-device DMA capability support =
in
>dmadev
>
>From: Vamsi Attunuru <vattunuru@marvell.com>
>
>Modern DMA hardware supports data transfer between multiple DMA
>devices, enabling data communication across isolated domains or containers=
.
>To facilitate this, the ``dmadev`` library requires changes to allow devic=
es to
>register with or unregisters from DMA groups for inter-device communicatio=
n.
>This feature is planned for inclusion in DPDK 25.11.
>
>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>---
> doc/guides/rel_notes/deprecation.rst | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/doc/guides/rel_notes/deprecation.rst
>b/doc/guides/rel_notes/deprecation.rst
>index e2d4125308..46836244dd 100644
>--- a/doc/guides/rel_notes/deprecation.rst
>+++ b/doc/guides/rel_notes/deprecation.rst
>@@ -152,3 +152,10 @@ Deprecation Notices
> * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
>   Those API functions are used internally by DPDK core and netvsc PMD.
>+
>+* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be
>+added
>+  to advertise DMA device's inter-device DMA copy capability. To enable
>+  this functionality, a few dmadev APIs will be added to configure the
>+DMA
>+  access groups, facilitating coordinated data communication between
>devices.
>+  A new ``dev_idx`` field will be added to the ``struct
>+rte_dma_vchan_conf``
>+  structure to configure a vchan for data transfers between any two DMA
>devices.
>--
>2.34.1

