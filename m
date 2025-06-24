Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062FC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B9E140BA2;
	Tue, 24 Jun 2025 15:59:48 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6E0FB4026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:59:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCJr43012221
 for <dev@dpdk.org>; Tue, 24 Jun 2025 06:59:45 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47fux5g6e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 24 Jun 2025 06:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpoUdwDf8fDIL4IxdeJXVlhBLJrSwNzV8Kip2M8r19DGdiCOY78VxiT5sPjmclQMT+tVzQZpF0DHVjcIjsppBe/Ym70aywA9Vlspr46WOrtKN8SYbZgKx7WDQ9e67rpCDNcYl+I/izkm9odad5O5QViXH6rrZIQ1hdj7QsuUMnH3NQ27WCc8mjkdtg1xENMpw+1dW2l5qrLsrBjGf80Oo3UH0Rverd7WzJgw9YuYqoS800YVSJy6Ym+2enahEQDUSm6BJLDyLkdfG1VSkavcKyoIC9rroUNXSeOZ0Cprd83jttSnAFgxayxBDIYEfjq1iBT+MtUV4qEPtWpcNTOJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKYxMqY/Nnh7/D3x+GtznBrgK8ydLXpngqMjIcCcFbg=;
 b=vWV8A/tlLXWAyD6ZvYpBb0s84ipDrcOarkSKMikdXbHs5wjL4cPEskf5jfPoKJL9Gu2beM6YN+wOqTsun9kce96bdbQn28GvUlx7FONcch6aefVPmgUMEsZ+0FGDONjEWqjI+JSVHHuuTEX8Mj35tViUQ1lZJP8KaPeXK+3uYLwj2zyspuz5xSCWshGE6LvVhgWW6yF6u6vNPy5TjzQ6cM8BuD7RH7VsFuJoWrn0suVbnLAWh7l2rugQdju3KS9szfRdbFpuRW/wvGnleIHp+0tfvLVhEEG0o8TNCCAb3fu5o1A7ZDInvOjAsUW8wwkw9/8JcrA+pOha3JU3SDQPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKYxMqY/Nnh7/D3x+GtznBrgK8ydLXpngqMjIcCcFbg=;
 b=ru9PGcXEwE1mw1a69Sw8LoryyMFGOKgHkldd4cNlDHBstkrbne1Z1/ia9eVw4EYJHvK+55ob71Gb/b76wjkKFi+lEWbhDHKWDCmCjHhsANjloQc5WK8eYqYRmYsxLhtomwF71T6EvDaLUnrCIsqWoAeXcztbG8uEHzfUGaYasPU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6129.namprd18.prod.outlook.com (2603:10b6:408:27b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.23; Tue, 24 Jun 2025 13:59:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:59:40 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>
Subject: RE: [PATCH v3 2/2] crypto/cnxk: add sessionless asym cn20k support
Thread-Topic: [PATCH v3 2/2] crypto/cnxk: add sessionless asym cn20k support
Thread-Index: AQHb4Cwqu0ZnZbutZEuCuJpmxC73wLQSYACQ
Date: Tue, 24 Jun 2025 13:59:40 +0000
Message-ID: <CO6PR18MB44841558D65C7F0D8FDF65DED878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250618083651.637234-1-nkaithakadan@marvell.com>
 <20250618083651.637234-3-nkaithakadan@marvell.com>
In-Reply-To: <20250618083651.637234-3-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6129:EE_
x-ms-office365-filtering-correlation-id: 2c636412-4ef3-4940-e0aa-08ddb3275cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KgOBgLqp7cizB5Ab3F7KaaHlSKsLL1AJTau8Bz225XQsrePYjsSjOpUj149i?=
 =?us-ascii?Q?nsWjD4lbeCdnURiEn8V2vPaae5ah+Q0th3OnXtP0Um39gXOzy8XE6ZzfAemn?=
 =?us-ascii?Q?39TcMaPpj4qhxmOZnaFjehtmErXeC6H11S//1seJQN5NbgfeRF7xemnULPyM?=
 =?us-ascii?Q?u27LeZ+i4gQX5EMUCuybYeMLyIQIMxFyIlnQoK3WZ5nl+686Cev5UrXhb5A/?=
 =?us-ascii?Q?EGxBXzTs4B5EJkpYGNfn++Vnh0TgwQFxCLvvFY4SS4fcRNzWnlhi44R31Uic?=
 =?us-ascii?Q?fdbh7N6IfYLmyExhcprPkDb1gMDyVS07NdHq5Oxe9F1UoWN/Oy01gGV5p4Oe?=
 =?us-ascii?Q?fuNKO7upZ+xLt24KzwdjEPTsPzjKIYwZbJ3lBV/EH7DwgVQhq7vvJnqxSGgv?=
 =?us-ascii?Q?EOO90dU7MNrYYWzzQrw6bNClwYV3+WsqkhLKxyY7QQLb8HNXCZYk1hqLSksd?=
 =?us-ascii?Q?ou4USG576OoXWSUK7JvjSWDCZjWjyh0RTL3hF5mIT4VdMsv3kkhJDMBIZ94Z?=
 =?us-ascii?Q?x0GGaJaFG6yh5XdeiU5IfeAqpzEKsnhHPd5EfSUSrtlZo3FMNE+MkNUXcqXB?=
 =?us-ascii?Q?qBcJYNeSaMyWF8mM3veVqlRr7SoUAS6pJSmarwu9rNlSM/GQuAPquGU9Pt6u?=
 =?us-ascii?Q?3AZKDDENxCSAbUFkaK1kROE0R8WEVucOt28I3qiImWR7qKsI5vzae6t9PFuf?=
 =?us-ascii?Q?VLuangpy27Ivif/LecDMT8XfmIG0EaydYa1XvoAFqeXPIKVLPIUBCa01b1pf?=
 =?us-ascii?Q?s9lbgbO0t3NsyDvJJFeizY9Go7OxPWf7z5aZJwVlJqcGPbQ8irN1hnZBZm8k?=
 =?us-ascii?Q?YDvnhJCSqVTWjaP3rbJt9S6QTEuDXGy3e3Vq5e1R3OLv4duuyNOAu3569fL/?=
 =?us-ascii?Q?2f1qBk86Lmz3EDNLVrZ0sVGlkUBeEIhImNX/Exani7iqOh5meXs5vNdQe7+4?=
 =?us-ascii?Q?dqMpV3AMkzZzpAdXTkxhcWkKtvx4pAyU2gu3h0oe0jwpR/xK5b6BZPZp2QBw?=
 =?us-ascii?Q?vtuMU0QNiR6+KPYlZoGyRSAwW/QjFQNVYmLadCzN0hcXHV7qojeHej1gqkGH?=
 =?us-ascii?Q?RyH/FJK5AC6gIRSCTukk4FMEhtWPxIuS3ypMkfPOhZl2nrDpbir+inZSKAaS?=
 =?us-ascii?Q?Dy1vxP2EBdmbTpg9+yg/Mim/9XYlbN6vCg7x201b3Z/wWB9JPjjtp6C7BmaI?=
 =?us-ascii?Q?Lv5tk2AZ146l3siEvyDfYrvtAhIIyYsdRWhdgNFsLNILSp5l6YgUjfUxEzSM?=
 =?us-ascii?Q?tzVoZ9zECvL/Io9UAI6amsLoLYFSXyyINpW5+BULqhbf70X3y8wDq4NxspTg?=
 =?us-ascii?Q?Sam4x+x0Vblj6Zwe3Z+WG6c8n9XXNma3B7fguvb1qjYXhQT613kKONfuvLGN?=
 =?us-ascii?Q?LMpFLUaB/d4VYbQvm1M7fil0tM3HEAx51DJWtFHkj8FLVdOUrCowIISAZPNf?=
 =?us-ascii?Q?wpxU/0Af96K2QC8K0AxSs1ERF9wTxqLGRoQQSU1Tu9UDJlRjsTI9LGkqn6sF?=
 =?us-ascii?Q?dieXFzlYgL3mYWU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZZ3dzpe9iEW14ItRY4lw5nuvY4f5zI7UsEGB7bslrhBXJhErLeUhqT8x2fpT?=
 =?us-ascii?Q?yapuG1fpK1voMs/Fivyos/DFTOwcqCIgdzvgvXD/Tb6YY6C0ej6KtWh5sKVB?=
 =?us-ascii?Q?0qS70f6d7ZK669V4H7mHLE9ZV/0p+XFM6VikgwMvtBv6d0EThIR42m9sMcRC?=
 =?us-ascii?Q?//qWrMLL4zIPWv2LrunUwQuKJ2V+dZJWYs+qs5YD+StruS39+Yja8PglHdkn?=
 =?us-ascii?Q?OFkiTPWSSlet2QE+PalHvI8rkZkI3X0i7SjMdhQak/il+5a3ipUf1tzzoX+D?=
 =?us-ascii?Q?35ImIlZZQGoNXjml6lcpQKGGkWRjK3f+cjamXRtwnyNBuO2GmQj5yWU8EjFx?=
 =?us-ascii?Q?vlozVsfuQHME1vBqWSovDAOofodWJFxFSFrPj0zZSr5vX+453mo3U/az/u19?=
 =?us-ascii?Q?9ruDXZzFNMhWNtZYfkgjUbUWF3Epbi1h8q2yvsqYlactfdRx41U/4tdhjTSX?=
 =?us-ascii?Q?gTUgu4nvN6ygyU1h7HQ5ViI1QTcXrXqA3+UhfN9oxaMkggwyA9YDw/vjqWCg?=
 =?us-ascii?Q?eDRkz/+8TqsxPl8uH1crChbOpa3GiL6ZZIijOPdfNxYNY1muHmhckhQ0CMXs?=
 =?us-ascii?Q?CqbwUDRm8pugs8azLzod1o66kyDrqi8XXSRqqikWLXfQK1CpLSTZruaMBxor?=
 =?us-ascii?Q?Ygn0NKKlAwyvqCwJ7g9K+OmMwPySFf2sHq7YNwqT5pRu/Gg+gf3KNRrlWDUM?=
 =?us-ascii?Q?vDxXYcibkH4BwaIPrz++xVNPNEHsra03UnybD+KLKE0FThOBnS+wxq3NvMGq?=
 =?us-ascii?Q?07KjdF1A98xapYwJ+8hwLlfY80X6nHig+f5oskcd4YnjFbph7I8xA0jY5g3y?=
 =?us-ascii?Q?E4G7SJy+2LWsqKmv1p61ZdYXUsjCu2yja4Q1DzG5x1QUf9ZWYKh6DD6Vjz4z?=
 =?us-ascii?Q?CG1JQcJ2snBJbTfgLAOTWqjfgYa6meq6HyJreMov+VNLwwdWnZMJb/ud/nHK?=
 =?us-ascii?Q?djdMl+tsJhsfdCh24qkq7bF/k0H1CcM1GePxVf+pxatMePjNZEd0XHSH0ZKy?=
 =?us-ascii?Q?x3ZzkdF/OJ70nQ7rgbPg8UUcDMmo0mm8C8U5LL2xFDOm2KyO8Lp8xwKIYW35?=
 =?us-ascii?Q?hXMkzNKQBIntAED9E8mfBbgUkvSS3c9Z7ugQCsQHgjGtDkfiwY3t+OhK6VuM?=
 =?us-ascii?Q?ggxGch5tLE4vYqezPpKj1yufT3HH1fbLSh+GAarWG2dfQZhAY9PCD3TSm9D7?=
 =?us-ascii?Q?rRXuqDeTF8oXTYanku6kEMzVHnp6yxjSXfej0wTy8nrVFSfEMfYzoeth/ijf?=
 =?us-ascii?Q?XDtihxXPLaGlmHwxFSBgVBlLZoawAhxke1BA4tJAonSqF7EcJjaPyNwZ0XDD?=
 =?us-ascii?Q?Yi/k+D0AZCC8YperNKyLtswqtwR56lDlPjHYvCbb/dk1J+wu+TahQBG2H94x?=
 =?us-ascii?Q?j9RC2hEzB1EQZYHBFayZxMc2jW/cBSLSKxhWKqn+gqsQKipon1cXjux9dP3R?=
 =?us-ascii?Q?0Iez163sI2920luzcmXhR07ZUxXSP8Nq00kAnMceuZn8vaUI2g3V2fvwbowd?=
 =?us-ascii?Q?e9sGtJ1iYDqSbAW2J6z8E9SM57OowOyRqMpmER1hJPPQGhaRLo85vl8d/nA2?=
 =?us-ascii?Q?2eup6DibzTJair25BJjq0tJPLmhcZCGk93wMxKLv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c636412-4ef3-4940-e0aa-08ddb3275cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:59:40.1591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ebf9wbZ/xC0yZIrd/abD/ZGPJ2Kpn5Q88sdJvqTMmcm3uG/Jo6y2JJosSO/235oI/SEOnaU+c9qKi1xmrrXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6129
X-Proofpoint-ORIG-GUID: i7mkR59Mc-kP2cpNsbDYcPATRSsfdEWY
X-Authority-Analysis: v=2.4 cv=JeK8rVKV c=1 sm=1 tr=0 ts=685aaf51 cx=c_pps
 a=ebN8701QPLce9M4up3U7jw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=splow5q_QrrxThd6VEcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: i7mkR59Mc-kP2cpNsbDYcPATRSsfdEWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExOCBTYWx0ZWRfXzLcVNCcbVqZe
 CHTcbme5gWILE3Q4Jbp+/qZD3R/J1du0CH8qjmMaCcTk8FcAzbNPhBJsyT2cNMM46vQLvkT+Z1c
 INAed0Yu9+sIuhgVqQWvv8E8NQaxYC2FepE6h3QUjxIKru8KAT0lc/U9+w8w2o0dgCG8qjKHRJp
 EeB9zYRAsD8FtG96Yuk+IaoZdd3O9qvSk92u1NArNElgz2bCHDeUcrECjT/OcjA9xWWBwaBI1BQ
 H8ZSNJxOnG64mnyNJNR29l7is04nDZhfaHmnjAERIQXYcURLFmMzSHk81rjogw2Tapja7FnddYa
 qH2aQeDEJ2Z115dtbwRy1sER416wXMKt0HORE0k4IgBVAFybXVvhBFMf/0M/oi64T83QXzptbEs
 NFH7t9dSYdyXT7RB48nQKLi7xkl/8z4DqtJyqdfRD1i/jxsZdc0Dyzz1iyi6eoz3mmMi3YxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
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

Recheck-request: rebase=3Dmain, iol-compile-amd64-testing
