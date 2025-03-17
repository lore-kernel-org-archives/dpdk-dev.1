Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8312BC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 07:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 494A7402E1;
	Mon, 17 Mar 2025 08:54:33 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 217A340291;
 Mon, 17 Mar 2025 08:54:31 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H0rQTV026903;
 Mon, 17 Mar 2025 00:54:31 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45e8c30r0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 00:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM4NaBp3gObNLBzQQ/H8zNptj7PPlkC1wBZUimT1yx/h9kYF9fAUI0kYvNi/ddqasvVZMx+Srh9tTxUpsui3ST5OWgnoTRkDfET6ITqfQu/SGOvQh4fZ5RmGhXNabRV512RSAXVNO8zjhbJeLa5OSb5P+HEvaf7o8GC92mJH1TmRkYJF5xUMTdI6waAdMDXZtDPA5ctQhYhUoVB6h+ro0tLXCCo2ntmZ0c4L7RObKmVragQIPzLtlO4HZTqLr4a4IYQu9ipzmA+cakfe6F3W41jc03/RP4F2OO1lnBU4/5lTlP5BFRyUiuLj97yWw56LGoxul66K7bQfziiU3HYByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6K9Own35QSK7PyIugzB4BMWJ17MuRIHLgQRDXNHNhc=;
 b=G+AMLVQ2ByGwtiYTFdpr9fW/SQ7fcDDtVBDQ6f0vIaqc+qD6ZIINLN0Da1ol3+f6mhVFD6xhlGm90MKHsNCvEXYfJ6XbmijfQpoYjMlLQribCpgLaddhLQN4DwQvarP12Y/X9gU/4CYxw3x7EdnVmTNjVU2el9zYzy/Lop7BPiyUlAmb4oa5z5YQLLDBIzXb/UYCK+qKjUM6eSRfkUhpjQR9DxABe/t93QDiSzM2ioNGC9FX7+50xcPCxr0H1DglZ2k0LLBdZaCbWgKYGnLpbOlrHfd4mDwsUbSHgs+IERWaUc08JEfPFvWVsK7i76Q7jiSNrmi/uyGPnSu3bgnYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6K9Own35QSK7PyIugzB4BMWJ17MuRIHLgQRDXNHNhc=;
 b=ueYAhkYz3IZI6L54oE+fBn2Us5miTkskN9N2Q3zXTZXq60p5tJ4w9i/RKyQVvogWjPjuf40tTN62Fdp/j6pEfoxHCyJLt62KufD/AvgUbP49B2puYSaTk3T/C3EBTD+ufmJlhMGsx0di6swPly1CjjR1lvu8AjaJDtJ4OB3RrSo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPFE5D90BB53.namprd18.prod.outlook.com (2603:10b6:20f:fc04::dcb)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:54:28 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:54:28 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "brian.dooley@intel.com" <brian.dooley@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2] common/qat: fix incorrect size in the parser
Thread-Topic: [EXTERNAL] [PATCH v2] common/qat: fix incorrect size in the
 parser
Thread-Index: AQHbknCeQk28Db77lEu9aY5/TGACbrN2/qAQ
Date: Mon, 17 Mar 2025 07:54:27 +0000
Message-ID: <CO6PR18MB44849FB89B07502A42A6E30AD8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250311103024.1186285-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250311103024.1186285-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPFE5D90BB53:EE_
x-ms-office365-filtering-correlation-id: c55601b0-8e9b-42a6-f738-08dd6528f16a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qbVONfFYgXmoM7xSpDYKT0Vq+uXdk43G8/bfKTuJO9iszFt/TVMfzNAkS9gM?=
 =?us-ascii?Q?YP4dXZJK9Ejd7JMMXYc2/CcFQkiTgO8sUEFDl7/9HidQDqwzIoWIOgnVs8TA?=
 =?us-ascii?Q?7LThI+trqQCvRIzLHz7/QnYXn9R0DWexJOQUhB8Q9BCyzle5PWMJZhoG9YTY?=
 =?us-ascii?Q?sls37tmEV4K6bvRLtRl6BJE3AfRtbOuIXA03557EmP+a91qtke0skByz+y2I?=
 =?us-ascii?Q?n1cDrUu+y6woRY/vIOXslngs6HRNSq3lBso0fTRML8dprWlqeP9aW/fYZ14K?=
 =?us-ascii?Q?WIsiyYTbaKAiNFTi6HI9UL+Bme2Wl6tZgwg2pnXsnpivTwzgvFYtRPQrATKR?=
 =?us-ascii?Q?wzTcZyR5ICC6Ko/3cgOw6xtDXWT0e/bNXmIuFQ0KkFVBaTjXthTFLSkGygHN?=
 =?us-ascii?Q?CW27GkH6b3+1ZTL+K4IIXNckqOfsw3AF0zTeZ6kXpxfPrnXWs/6M+Ze0llaz?=
 =?us-ascii?Q?+Itg1hR/1x2JyHmBLloeHeFURWFisNdlATx4EjRI5Q1n69WM4NC0wduBAl0z?=
 =?us-ascii?Q?gWsossw3GqvMb5+3zN6YbLZGxN5PJWaQkrrdEosrJcjNNtjlv1tytMyMysb6?=
 =?us-ascii?Q?M6JNiAs5V/AqtFnL/Rrvgn7ZPDrbypm46PKaZn0QyB08eznfOrYUX6e5MeQr?=
 =?us-ascii?Q?Xmn2UiwvF5DQek99vku0imKuRu+PpCqVD7DvBgwixOSZM9lSox5X5QBwLOu9?=
 =?us-ascii?Q?Kac61zrVY84gDCFYcfnmU962IMr0Ov9CLgmdjPMc/X9KalWHEI70UtJ3dvms?=
 =?us-ascii?Q?+KXwqyTwtTM7uilGpMakXtQD2MQEQsYVrYnTmMkCdwQNFrt6lg+2P2XsaUDs?=
 =?us-ascii?Q?vjsD3NO5jVrgeiVFXVfBwOujw8ZgZO7Q0NhLwjmBF6jrgZvLZ5DxjNzlkZ/t?=
 =?us-ascii?Q?2IlbpWCnsoGxydlPVzyaiCSDYRD8BJlSE+EoNpYa2sZ+VKkf3NKakXuvweER?=
 =?us-ascii?Q?wHwfzTRZyXrMKyEZg+UdpDxBPz1PIIlYIET92rw6j0hmchOO0K3xAjD3OgT8?=
 =?us-ascii?Q?aYL1udh72BgQHzf4AFheqhC2HVWfQ1X++iAvDu21aF/RTEoA5H6hJ5PC8Wsy?=
 =?us-ascii?Q?tLLYtlP7/lJdmY0HfJS/BrY7l4ZSQ6pqpH907ESogdeXktkeIv4u/RxDgx74?=
 =?us-ascii?Q?q//MHKYj71EgaynViKx+N4jC/TZ9Dc3ov9+j9Kd5VMRBdisElZReYv3qUGa9?=
 =?us-ascii?Q?rH4pYGchD97AsJU4QoNtsjYjb0T2ovEs+vLEhz+fwOX8KLxXq+5RzBLtujDq?=
 =?us-ascii?Q?4xgBn8lfPiId/3o9tubXOPLO6bj6IIifylEoxRiWs0O+SlV6RZ3xB8vnGMOL?=
 =?us-ascii?Q?siXW+ktzG1kiXm1QWTW9RV4br7Wlz/CuqOPqw6tGMD6FpQUccRSQbquDymmi?=
 =?us-ascii?Q?EIZRMGA5YINLMFOuaUJKU3C8Nf9j1ky2Faxnmy4heWnXkdhld1F1voY9VpOB?=
 =?us-ascii?Q?lo3dfmMR3uVUAV/cCgm4OhqMfQFIdLMB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?esUTigrnI+oBV3b2AvyEOKt14etbIjiKF+quNv7DvIwqvUb2pDscf/VMXdvG?=
 =?us-ascii?Q?ZFKNJHomoDjVTCl9Kgd70d6wgpU9A7EgR9xWp4Z97ZYprF1P84d2z1ctvzNs?=
 =?us-ascii?Q?U7DP/FbM8j1MtuTpxUCXomZJDuuj1PInQXRmgJdD919LdEw3qZp4w9oCkO3y?=
 =?us-ascii?Q?HGRevUgStXKn+ZRK4k5XzspDKkMpO8hsNlcA3SLncvUMeomCZcz/m4n8H2Ff?=
 =?us-ascii?Q?2BU1lC8AP42IJNN9JBT7UBCjB67DOD5qel+Ap31oFUY6SmR873y56GydQvY6?=
 =?us-ascii?Q?LFIlmMyAOxEazLadEQvcujMOk/6YP0tdZy8/qr2GMyAe0gO4CtfGvna1KhoS?=
 =?us-ascii?Q?xmHMSNfAzGZVQgstscT9HiOT7ROyQA/mtqau7lmm7FYDwpxDp+GEpDpDxC6N?=
 =?us-ascii?Q?Pg3scsae9Pp3pECoW3MvaDlogmdn8Nygr3XMpvnBNICFEnllDGp7bStdR1UE?=
 =?us-ascii?Q?pq8r2jxYMkrZVPG9ntDPtomMLRPAr9tdsvhs4XoSt9mITV6J/eusnkt1LtRd?=
 =?us-ascii?Q?ZEm2y0r/0gfjAVc73mQrK7tvwqbFG+PEebyj91r81ppb948iulrZZpt+iQp9?=
 =?us-ascii?Q?caDafgB5iv37Bsm2FVJJMRRkwbPAMofRrNyTHM6yFI+S+0t0YAE04/Mr8LKF?=
 =?us-ascii?Q?guLo7/6RRuJAniHnd02R/rZRm25DZbq80fnAIBYAmWcRDFJC0IOF5BYosyC9?=
 =?us-ascii?Q?rg5YNm18/xumv4dsYmG2AVvmBcOSwNNquk+O8ULaQgczewFjkAYQJ6YEInrj?=
 =?us-ascii?Q?Q6fogpaJEcAR7+P1fi9wDBh02Y4KMGtlFm2Ywf/WNJY3T5zxNi/i4ER91kr2?=
 =?us-ascii?Q?aMK6/eOhR8olRvDqUE5+bfwGivRwjIabOR7yzHDEdgjQoMnrxtnRw/rElJrh?=
 =?us-ascii?Q?gLHz4roZUkMZI2mmOLw+DaXOugwLG8wkk52Tju4tce7w7Iy6O+8r7zRWK8RJ?=
 =?us-ascii?Q?zOQDp6nNGGRhH+/5d+cUT22f17oXmp1S5AmJlPUhda12GzxTUxAMhprE/rtZ?=
 =?us-ascii?Q?IhNBcwKHto4VF+qRzcefARrPsNBH+YfPWlXVGEXg+SJY+yl33LNE8qTZCJgy?=
 =?us-ascii?Q?+IihUnpw3XnV2qSySdB1oeJ4NDeFzcyHN9TBskBjKHU7o7FYjfvkJCeX75+B?=
 =?us-ascii?Q?x+CrUjc7CO0q2ZFrUoyDCySF6hz+caEPtJEQ/p4mdjykD7WEd9mzrb77sX+I?=
 =?us-ascii?Q?4gwuymGVhTpesDzF74STEclYvLdeAOvkBiRO5l+ODZsWRi6vVDrkfxGgL8p4?=
 =?us-ascii?Q?GMTCzNKY2ehB0gM1gwOaD9F7AcCi07rrByTONImwu5+nvNOz93XHVrD2rmjg?=
 =?us-ascii?Q?O9vooxCcqOHmQs11LcMSjfqu314nsxZLkpgdnqt419L9OD8GpyQcIQf34T5Z?=
 =?us-ascii?Q?bW1oIvRUwIvg9hXDwP7HItJhgNbmK0NXmIOkdF2o1zg9fjfZn93sMbymuayM?=
 =?us-ascii?Q?nGNAQnaNlKqMyXdTb9DIvLrTPRtuRFFbpMeuhZpdS70pQDPyzQrY7Jo2ooHW?=
 =?us-ascii?Q?Xy6UYk2wT8HnXRefOiScp/FpG6AEmhiKsgNhxoB+cxoC6vsThq5ngkv0ETKE?=
 =?us-ascii?Q?ohKs1uPUiDuszQLwC9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55601b0-8e9b-42a6-f738-08dd6528f16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:54:27.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8G7saXvItBtX/adI9U7Q5v6kzHKtfcCT4L4VWd8nUVYYmmovTie2DNkkvD4qXmn50n7lqhco5T2IUiYpA9LzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFE5D90BB53
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=67d7d537 cx=c_pps
 a=G0EMd8eUBd5ElxF49Cdl+w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=KmwYMbaT4vMG251RfFcA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: YheoSgngAYQxWrlSorP9Je-vTZYh_bdy
X-Proofpoint-ORIG-GUID: YheoSgngAYQxWrlSorP9Je-vTZYh_bdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
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

> The function `strlen` returns the size of the string without a terminatin=
g
> null-character, therefore a request to allocate memory space for a parsed
> argument is too small by 1.
>=20
> Fixes: 99ab2806687b ("common/qat: isolate parser arguments configuration"=
)
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
> ---
> v2:
> - changed the placement of `len` incrementation
Applied to dpdk-next-crypto
Thanks.
