Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4584CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 08:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A851427E5;
	Fri, 17 Oct 2025 10:59:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5EFF4427DA
 for <dev@dpdk.org>; Fri, 17 Oct 2025 10:59:46 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GNSbQs025546;
 Fri, 17 Oct 2025 01:59:45 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022094.outbound.protection.outlook.com
 [40.107.200.94])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49uadnh52y-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 01:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7JzCwS+5+MnrBxK+kBVfJKfTrWX86II/7yIZmpZxqE7PyIZihyxvR6GendE2jdravXmr4Ut7A3uDqZA1/hcQZJzTN3VgVyCNEJT6SAcLGYI4Wz++hvRzK8w9iyX0a4mIomcjX8bphN0eBAhAuHn7aPZqXA8Udd3nGWju5M8kWdqSKEYpGDhKeVuzXgp3H4YOwR4jNLPJa1r/vBRqwL4He5n+KBIZ98wyUelwOaPE85hOSXlDPbgE32MfKcmWG4GDB4jqT7e3sxsWcSLdDxrULBpgHIyQTl4tvxIlhZcsk/M9wSvf0ihqG8B54ygJJOn31zckUI7x83BiL5OoX9Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJRfDkIYLVTEC5i60KYn8oVw9sNKXj3z/LL3B+cc22g=;
 b=bn21V9GslDiv2QoGbiJ3KaukMLrU/igPCeHspFPav6dziz7Zsx7Wi4szyUrV2svH/KM4LroJPakBZfU6aWRh7HpWRCigNdqgiOpyQuUfjDypM3oyQA+YAmzP06dsxC+6cllN19urQZwdlvk3Rg/pWYL4AfE7FJOHEE9bn5VMXmAqfa+ZRCEV1kGO9Zg4k/ax7VO2fAlPgZ0BMxumFj3Ws/jlbu3XVgW91/m5cjoPtitlVIL9WVVQuL2YmqOTM0FwzA85PTW8e2CpwTariPNPxsc0vindJne4U7RvSzPOqFdfGTgIlxsUArbVq5osjJqSn1DgodM3+o0Zg8X+HGifvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJRfDkIYLVTEC5i60KYn8oVw9sNKXj3z/LL3B+cc22g=;
 b=lXpb14Lf2o4c1Zmax7e3/4xbqeZbZ5q8ZBZtLYmJgxPGOGZPeh+le8DogUOCK7v0C57ocRw9g9c6E8AOucqJ0U7cj0q6IAfWpj/L9969x4mTumsovSxwJfvxrvlx2h5CS5hwm9p3nDlwmfLMmlr174nfl/SjYcFypTvTsy/1kMU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA0PR18MB3471.namprd18.prod.outlook.com (2603:10b6:806:71::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 08:59:41 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:59:41 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] crypto/virtio: free memory used by op cookies
Thread-Topic: [PATCH v2] crypto/virtio: free memory used by op cookies
Thread-Index: AQHcOmi47Q8IX4VAoEyHDe1bc4gNFLTGE9MQ
Date: Fri, 17 Oct 2025 08:59:41 +0000
Message-ID: <CO6PR18MB448476CDAEC78F4AAB1A7936D8F6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251011043238.1508-1-gmuthukrishn@marvell.com>
 <20251011043706.1554-1-gmuthukrishn@marvell.com>
In-Reply-To: <20251011043706.1554-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA0PR18MB3471:EE_
x-ms-office365-filtering-correlation-id: 57cc2d2b-fe4b-4406-4ce6-08de0d5b8293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?03KIu20194R5g3Va1nBY/U1bxMacuaRiTqJR2LqeQ+2sIfpb+toHG4FNA9lT?=
 =?us-ascii?Q?RSnJpFb9XVbq5Wz1sbXhdfE20Lc97QxMdkbO+C07LQYGZlchwjDK+A8TCi2z?=
 =?us-ascii?Q?yPiN1JYE6a3Vssu1NNGPJ5cZObtMtCnyfmrK0HCubPwDA5vxZpivqNiRMsbE?=
 =?us-ascii?Q?K5CqxIXnAJJoy/wtuPetMel1/XCt//K462DpJxXyUkZ085WDYlVJ7cxXMV6G?=
 =?us-ascii?Q?9lk9vqthYJkyyn3BLhohhaKH5fLEd1897LxFueX62qT4Cjd+ya107s/iHaA/?=
 =?us-ascii?Q?tmoAPlL23lygx+ApBZBy1i6awMDK2fvxhhExrtvMutUUIik96Ej13KaK6wAG?=
 =?us-ascii?Q?pq2oB0rR8viRVj+NTmRFGS7nwjK//oAlohYpsniQ03s/+oEowr10BvIEoMOP?=
 =?us-ascii?Q?PhjYMXxPaS098hT/AEJPjZSV/iQBIfMwURlSHx1t5xIsmNJhNVSvP321KKjb?=
 =?us-ascii?Q?8Z8Juk0J6O01EOBHKf1Y6d87lSd+NTuX9eZ37RkTm8iQYJf+XLDaFhL8x1HO?=
 =?us-ascii?Q?uB8s97f+PhsTrHflfmCo/9qEFpsbNBgYwF1YZhkqfBtIeRWRRtWlGR3skUd1?=
 =?us-ascii?Q?O4t9OS4NesRAxVFEnMxJdGJRLtTj8eHaUS8kiFsf2wDvcxheDTWkHT7dJUaT?=
 =?us-ascii?Q?XUd0j6+w0205V548ewe95gUvPmrEqf9mCXfoRfWdV3ng0CXQ40pfvl5xPMWM?=
 =?us-ascii?Q?K21U+z3kjipNMr0GaR2gKspvtSTyeQ+u6x+wvLm2mhhNmiQNux1yy8g9sRNf?=
 =?us-ascii?Q?ghn41WNO4+D83aHfXuQHCi0gG0RhgUnCZVFtYZcBs6Tpb8aeZlacmBQjtx+D?=
 =?us-ascii?Q?WmIvCZZUJKl2+YzzoJLCteYxp7mlvMhytRtnBvUAp5eaDqS15+dkd/zAdVwM?=
 =?us-ascii?Q?S+xjfpDUi4gvE4ZVU8hSZPeUPREodOlKNtak68sFDuQtK32h/1vtOnmfyLVl?=
 =?us-ascii?Q?OhB2YbY1C+78YMHVWGG+0eQLl3ZAYm8GNLB84jKZzs6qyCz9ddSel6I31BKI?=
 =?us-ascii?Q?l/xx9wfN1NGOjZZMvRY3a8f5Vd2fehOjX4XoCR08uerwmz9ly40WqgjeZG0P?=
 =?us-ascii?Q?nUSKpXvBv65t9fvxwcdK6lfoV9cgYKQSHWJk9f+mpiQnrJFDb/y65oRVuW/8?=
 =?us-ascii?Q?O9COI1n4thhhEVfNGCP/fOjheOaFMjPzoDMep2EOetxgVG8iZChRrKuae8aK?=
 =?us-ascii?Q?UuDfN8X3H3LeE7f+FX6aV4rVACFIjyXjV+dF2TkJZn01oXddYBjAAWpOduQz?=
 =?us-ascii?Q?DDxwX2Rsv++S390RxdVXbjZNePUITiMojd6jF+D9rHdAVPAN91PtiXngN8jA?=
 =?us-ascii?Q?3UZfyS+WJY+xBbWD/tfPdpNAzFv8AYs7uqFqc/jy6TVSWKsFOLMVuBuE/V79?=
 =?us-ascii?Q?rjc+VnEOszHysBooMtuWZobLl/myQs9Z3ohtgIot7Q8X7DGHHdHCFflZoTRA?=
 =?us-ascii?Q?qEYv8tPdN5l3lfxy66A4fVYxoS4eaqBxEE772vTMxl6evne/DoePapzYfYdz?=
 =?us-ascii?Q?iomo5Mru+VlOH7OurpfVmkzPKzIbMB0Bcmij?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+I1mZq3cwGZdAUs6Rvv0w418oO3ERS9uatHSqKgn5Y5L/eslpcBFy8hXb1Gx?=
 =?us-ascii?Q?qDWMpNwp69itZAcKOx9GaCm0mRhOjHYUXge4yTxePB7CxrTA8GzGvEcUihSk?=
 =?us-ascii?Q?PaBzYPKJFkf3RFMm9PeX0CKSsllMLhElvetHHW3rqEOH7jFsP9HwurekKqZV?=
 =?us-ascii?Q?NR//mrbPVYvIj4uPLg1AcriZOH2OyuozJO14oQwREnC+FPlwOC/SE2Y9kqHv?=
 =?us-ascii?Q?SfjMNJL2pzIth9gMJghFDItOWl+xBAeime/ADhwFIleROettY+4kkBo3sL1r?=
 =?us-ascii?Q?kTcwZp13lCzYStgJ1P+SaIAw6ZP6ElpM6M9FtD2QpARp8Y9JuhxeMachFFh3?=
 =?us-ascii?Q?DKxiOFwSfAaMIR5aKWrTmwvF6zR48IjRJ20BgXgHCsxrEY728inm3zW5MV9z?=
 =?us-ascii?Q?XD/S8Mr/H1/ZIo/8V/bmUZUpaw6yOIU7XOrvwU87H3ydbHeNP57IXDCfy0ao?=
 =?us-ascii?Q?wiOY+e8jsSrNmkPbQgmlhzaOkrEd2aOD1/1EAcPTMtwJM1Pevq+uNz6sSGUo?=
 =?us-ascii?Q?4N9v2x60ccukSY6tC1TluKmESiGN8pnWVGZ9xZCTBinaBVgFLWNYcggvUQmW?=
 =?us-ascii?Q?SNROAHXzX5yvMT6Fj+oKfDD2OYxP9WGLe3tmzde+LV/n/5M7BOiO5umFcXaX?=
 =?us-ascii?Q?LofC+MUM4zDnywr8nPxfBL3PpVivibP+bNRMPU/oZYMrj5JoFGtqao/tuqkZ?=
 =?us-ascii?Q?AlJ/jHUDJEcyvV2ij7pWyZZYlfIRGKNfi/602PlarknNcvNp+Phv9Fu7P10Q?=
 =?us-ascii?Q?7k1Gucq/3Cz37djpJ1ML5htbxzfww/MdMyuQTtcAJx4TKft5ebvhXpBeNE+u?=
 =?us-ascii?Q?wRSov5Uu7KKDJ/BZxoICRL68FH9ZFVWoqYm+x/PMq1Y2YGNwvBjy1wTmmVkr?=
 =?us-ascii?Q?gSYfQGDHfuSqB2nKmDVyFz9EmICX64IHv0NSoUA8T9Nnn9qCjQjAAL8t65U4?=
 =?us-ascii?Q?DesxVB3bobp8+pG7b39rQRsUudeRs+FQT59VvYZnTBWaLGWmTXQTCkAlR47p?=
 =?us-ascii?Q?mkBJozuLiJVBnRxdrehiGxyl9FQbqSXp9tRKScjqVgD2oJhjyqKM5IreapLj?=
 =?us-ascii?Q?+iG3+R0Rns9B/IwUFjhSlcnNVNmibswMMqNNsKmhOwHqmECUW6rUjM9QlDoZ?=
 =?us-ascii?Q?Kg6VLmmJOniCITyapjPwAIubdmGjPub/WvFLLjFStX1x/JNxJwTYQ4SgquoB?=
 =?us-ascii?Q?V0B6y/0J3KMnBNBo7kM1nxArVcSfQNbEtmBKhbMx5SBQrs01ng2T7bfHYjKK?=
 =?us-ascii?Q?NN3BZPwjcOVqr6sglChxryBms33jarAE4S7KF0vPpj2dWt2SyJSPHG4YNlAU?=
 =?us-ascii?Q?Kqgzg6kO3v/3q6cgvIpaSI4XryRAlQvRW+ctq/tYy8BSCDrIPGSj+VvO967V?=
 =?us-ascii?Q?ZOfDQqnVYc2yVvJZ3RCSUBuJ6G3weEzA7xkPTpwHfVg7zOyij5lLteCo8WXG?=
 =?us-ascii?Q?ijTv5h0zOOjsuaQ9DLPvtLIkiulpgAWQPv9U387I+O70GbTZDsculUG+qAVM?=
 =?us-ascii?Q?/ZB0WIkPDIrnXp7FIZBRQmFg7oFi08+Sro9vgw59JVkKDcH87VgPnk0Nmzq4?=
 =?us-ascii?Q?SHOZcUKKWcLb5crTGyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cc2d2b-fe4b-4406-4ce6-08de0d5b8293
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 08:59:41.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2whb5Qujn25mGxZJl/707KVc8/hoiP6XnBem81GnQO0VBKBKzvZDDLGxeTRWYZ5djM3/PDUPiyAs6XNIsyXeSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3471
X-Authority-Analysis: v=2.4 cv=Yc2wJgRf c=1 sm=1 tr=0 ts=68f20581 cx=c_pps
 a=t88XDKUlDquqCT1Kmp1J9g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=pGLkceISAAAA:8
 a=41FOEo2km_KvhD3iu9YA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: y6a4M7Z82D2kaHzouv74bdQE2Vr5dFyL
X-Proofpoint-ORIG-GUID: y6a4M7Z82D2kaHzouv74bdQE2Vr5dFyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE3NyBTYWx0ZWRfXwNBubHgOVL19
 iMNphNG9mUQCGX6wbsl7GpL8ZpfPyaav7LRLm2815619yLgb4EQ/bNOhuYpFIP69tw4T4Lab3Lj
 u+5tuT4OGtrL+Ypa2P9v8d6n/pGMJ1yniA0SqRkduc9Ei4tNI3HnoIHKqgq7YUfmmcXylZ/hSSI
 CX8VIkj31zEL2qjewUzGQZVXayY3qKeLmQr0g2fWCw4Q0LaC65lx7jDV/naw5bSVU+kW1+qY0SO
 8ck7ubjouyW1mBf7KhJ1kV5yoEVUSl6lEIiqiHocK168BmjS1ycb5u62gRH2rr3+A2VlAti6l2X
 z1NOUF1Znkmwo3LQuZEeVpyYKPhJ0PrXeMvSo9fEYiHiag/9unH0C493ZI2dNh5DBuVd80SxlDt
 9Z0gfE6AyDLvKAzXB+VvzKDYXB1Q9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Saturday, October 11, 2025 10:07 AM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Jay Zhou
> <jianjay.zhou@huawei.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>; stable@dpdk.org
> Subject: [PATCH v2] crypto/virtio: free memory used by op cookies
>=20
> Free memory used by virt queue op cookies in dev close.
>=20
> Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
> V2:
>  - patch description updated.
Applied to dpdk-next-crypto
