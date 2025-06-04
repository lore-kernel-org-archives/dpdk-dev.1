Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6AC5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48163427C3;
	Wed,  4 Jun 2025 12:43:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F234F4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:42:59 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KRwjZ021391;
 Wed, 4 Jun 2025 03:42:52 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47283r9fhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 03:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvB1xpXFQtN6pZ9MKIcC251b03mHXRy/9750MPhFeZc1OmaA0TfO/BoBjfpcbLcylH8QsBhRHaB5Fy80MGisQrjKFATkc/ViFAVTbuIV3PRAmYhZNRUE/SIVEIPdoCGMIuckTE0YCxefuUjt9ohNCwuUYn5tyHV64BtGsZwy7ZfQE0XOSqOBcpA1vqUweRRFtRZkBgIvAKcCe/rv6hUpy/NkLz2o08uLk0OLuARk5i7g41eyZ0p8oujmkllDTWqUCh3Lh3Wy06j9QEoqN0+/oWlS22VXq7RptARW4GUPWpJw1YOm24XhFZdECX7a4IvdSIRXioonHx1BERIaJg1k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvdtjDA8sli9A7DxVAqYxgatovxfwTsSXywkXGU7ZaQ=;
 b=UI1VlVvGY/TxfIRJi+q8D2M5fyxfyjvzjai7to17axoJ+2hlnfl7lCCVYkdP5eW0cdiBcowAcluqCtdXu8sB2LacAyHCXFIMPOQIYgPVT/QbiYfCOmZypZdw7aFm5iknOHS14JTVBlWrdoIJQ9EOECD1iLPFrb1I/fyLX4I9d6AOdWk4BXbOlLdb4Ohs6uQm6Ajwvqs7PhuRrgo2tYUHbUHTdL0ZyOfOMTXW8/wUMd4RWYOgoCDh/eNnt0hqP9H08NV18LnLae2hUQD3e5/tSevbDO0nXAHonjs/OZGwGemVJA0VFBMA7vwjfIpcT0htiI1KiR8ScMW22mTyJU4V/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvdtjDA8sli9A7DxVAqYxgatovxfwTsSXywkXGU7ZaQ=;
 b=gNf9EqRSzGv0eedm5S3skH3w16aHcwVGdeE4ceyUsTNxIr1OYafbiCPvttzgpjNDaR8WIvEuvfzbVduCBApXGB7O3uaxdyI8YBu3OR575+Or12Ui8puonoFZTyqfY3yvOMjXdn/HLv2vwXugikw2OafQeWVgUFByK+S5SG5Zvrw=
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::68d) by SJ4PPFDC846E1F6.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 4 Jun
 2025 10:42:48 +0000
Received: from DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052]) by DM3PPF17CE793AB.namprd18.prod.outlook.com
 ([fe80::3c32:7740:d3ba:3052%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 10:42:48 +0000
From: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v10 1/7] graph: add API to override node process function
Thread-Topic: [PATCH v10 1/7] graph: add API to override node process function
Thread-Index: AQHb1TlHlnK2Ry8ARE6+rVrIeV7ogbPy0BJw
Date: Wed, 4 Jun 2025 10:42:48 +0000
Message-ID: <DM3PPF17CE793ABD69FA2516D9BE5C7A211AC6CA@DM3PPF17CE793AB.namprd18.prod.outlook.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
 <20250604101259.4181992-2-nsaxena@marvell.com>
In-Reply-To: <20250604101259.4181992-2-nsaxena@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF17CE793AB:EE_|SJ4PPFDC846E1F6:EE_
x-ms-office365-filtering-correlation-id: 6e176cb4-8d12-41d0-2190-08dda3548c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2zRTw1JfoxoFNmbWvs7zMv+odopvCalWfqAYgbGF6B4Xz1gkRl+vLblwezdj?=
 =?us-ascii?Q?NZFgrhryby4Wr8XXmWi6JgIras+r/UCu4yGsJE0OCCahBQeoAON9/TThcKyD?=
 =?us-ascii?Q?g/LqYGpqQBF8lE8nMwgjYhi15dbS77ALQPzxwO77e34GJjCk9X5avscreHMF?=
 =?us-ascii?Q?QdYPsw0EV9IBoY8PpNwGQONSAXFboF0lJviEzXZsJkgzGH9GpXcfOewQ7UH2?=
 =?us-ascii?Q?O8lF86j/e6a+9gwfTcvHecu4gU3ShfCGdX1CotpT3eQyHDaNZ0QipHqzZFSj?=
 =?us-ascii?Q?vSmOS8jpL2FB3Xgdg/LOxRCretqpttS9EHKMs3TRao44s8vQrrnBZF66UgO/?=
 =?us-ascii?Q?hHEY2UixJQDnLOkA7mrlHN2v50XrM7GEw7kjxOnCpwA1ZDLgLhZ0TUnmwP/B?=
 =?us-ascii?Q?dpJfLVj3sVJ6Y+wZe3+dxAWBj3uWeeF+xM5fRgZn/t5VU8T98jIw9lO5leKz?=
 =?us-ascii?Q?l79DT6wdGNPThiLTButSZTij6XnJ2duD6/Q/LSLVuccBbitxBNYsDAnaEfFm?=
 =?us-ascii?Q?6b7C/9QzyE7+wC3hdiwmLDFDtorNDG00NHMeIC/nqBAgXvmChBynC1KhMsx0?=
 =?us-ascii?Q?Yi0r7rLq8FhVpDoLH8vf3Z89yYtc2SvvQCDzqbYGJw2J0eCz/KvVr+LLcq9R?=
 =?us-ascii?Q?tJWePRIzTR1Jt64jgqWoXGDEPAIi9V8HshEAzv+weOCKJjg79irB/YtCoA8F?=
 =?us-ascii?Q?UDkE+OtYjb1UZS+TgHJaqnHB/aFZJM8Y9xw7uWDRPKO4lH+IKTFnFYU/RQBQ?=
 =?us-ascii?Q?/pDzxjMiM/pR7X3lWsc5xsc5N3ER/7mkXw5tYk3XgBbWS/SJbngeX4+pCves?=
 =?us-ascii?Q?WGOEWi77SbnQZaHufy/TcpPD4syOOTVxaLvRRI8xkIGU/woQbeiyoXxGOxdl?=
 =?us-ascii?Q?/4SraS9449GbaOoVSXZ6LSg7dajavqHZCTx6S2ZGq8C3N2GViMTfts+uk+XY?=
 =?us-ascii?Q?j/IrFOF4VmYjVhFy3S6VG/wIBWU5yvvGwccoruvbRB8nHbKYC7PsLeD7VWM/?=
 =?us-ascii?Q?W0Rb423jA8XG/zLASdBuA8Hxyzkyg0cswV9hdx3YS0dSNG1xtwrkdL1o7BKn?=
 =?us-ascii?Q?HejuIslSvjJ9HosYwSa7Y4aue3Ndpls+/zgiu5g+Iv6CWr8xLheEJpjysZ8l?=
 =?us-ascii?Q?eVsKsvxWhijwLnzziEfsX+b9VyPe1SrXTeuFx6IFruityUZf/fP1QvpFqUBg?=
 =?us-ascii?Q?eKKfm0ktH13q+hQQedEke0abUN9evg1Ft6dBuGk77IyRMnuxCV6n9Wt5QtGn?=
 =?us-ascii?Q?8TUykFJy6Ume3kTuadZ2XCNieMa2C9MEAojO1JroGHKh3Bv1PYZtaly55m3z?=
 =?us-ascii?Q?IF8P53Y1BzBsztJYeqRKvkbGLjOJqYqpm6QDRmjRdthnk4Jvu32KgeYZJkHc?=
 =?us-ascii?Q?BozmMFJjGetU8N1/GLfTTI6zSYYX+iPOF4s2GKpF/ms0hJTV2XyVZn0Tk358?=
 =?us-ascii?Q?CTC48DnURe136dTrZcwoy93JyX5U7v6YVenDpVYJqlZo/XyuyzXiVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF17CE793AB.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hrvrmoYu+1ol4luxNvs/6jZeY62vnIhv7IIRODiyv+zKvHz7H8K4D2D5Fs7?=
 =?us-ascii?Q?c7RJYEJ1itOmHmG0k7aofRmgty4KoIQeT5UQy4hCa06OynaKwzdr3JBheezE?=
 =?us-ascii?Q?W5d74xZWnpYCgoqe/AAVbdOq4N+QfMe4vWF1SdykRRWF9J1iumCArwB7avih?=
 =?us-ascii?Q?HKqnYFvOCEAeu5Z4RytFcp+pXHkzb7sJK7AUmbrsVx+VgDnddFSYqdoVZPDb?=
 =?us-ascii?Q?h1Mu87XRkfNzrcVGqsaEbTdrdTVN9etQfELpH4gRwzA4jM64Sp/oQ5xhiBqO?=
 =?us-ascii?Q?VhITUYNOwbKXtvQL89y50b4wAa8NKnHqX+33YuUJ2zQQVT1mOfnB/yDyQArc?=
 =?us-ascii?Q?K2EBKR63Gm7eU0kPjhT9S0j0DphRrd7fwy+6OlAMHTTDFMDtXZl9VhcK7v5p?=
 =?us-ascii?Q?OZZfpdyxM5vBQPpJA5MlCBzTdHz+NEBaSChFCpVEGSHr0th8qMcfFsJSC1KO?=
 =?us-ascii?Q?TuPXa/J/fX9od4RoHWe4FBDTlRJ1qbDXav9seE22oaGA2tchpd5BEeefIXpM?=
 =?us-ascii?Q?QixSz3WkNVi0h3MErxHfZDKs66Ohd2kGm6UcbzDe3sdDrxVfvHzHayGPGqEs?=
 =?us-ascii?Q?v31QG1SkruHoT6r7aHdSVbiVlIpx5s9/4sWLXv7WrAvuqFoKoCEMUuwrOI5Q?=
 =?us-ascii?Q?ZBCqifhowIG8Frbtl14N2QB4wvHFaBjqoVY0WQngp1OIPByCcRPTXB+ut5EW?=
 =?us-ascii?Q?56TDaMW1AUFoDt6su38z2V5OmncMm4opGtBdysG8QTgjH2SNNMsBX0HCijfL?=
 =?us-ascii?Q?FhrKILZJDzBHR7mYazI/I/rOoR7opCj3BwMTlJaA9FbLlJZL3ozpq3oK5yTF?=
 =?us-ascii?Q?Uku4DEMxxG1PsoIGseUkGOyiXK6PtHwg+WrOBzu296udzghn2bC2czXQaJ4b?=
 =?us-ascii?Q?x32oXL9DMxYLPJyDK/uYwhL8oy2gpgcOmC7t2WN5zd67xKdJx6kFJdkpJ9NI?=
 =?us-ascii?Q?LXVFn3UZgeFJH5ZcLiPZzxkw9r7NIjASzH1EYg4gI3iEL693I5QGyp9FmZip?=
 =?us-ascii?Q?BtP3R6FDJgtm2MRy2HhuTfuZMVOMWZfDvxjuQxtsKtIVahmIHNr++gMorSxu?=
 =?us-ascii?Q?VpqYPDetQkkgLrVbvXkUnsnwPY7YOHMdFE1TpH0C5WyFA/RBuPq26GkViHy1?=
 =?us-ascii?Q?ynO3I2ZaiUJf/u3wzL1FZ1v3K1cokiyZja35pj62YXEY1BW15vBY0CSfaTHh?=
 =?us-ascii?Q?gZVVt0VX/0IPpwMrEPjdr3DKJUm1mqdPDnpzNajzhaGkLafjzPrqQgIp66ji?=
 =?us-ascii?Q?HWUHDI7DYzgQSLlClw05k/GgpI/Iv/Ctu6MCOYev1vvSAocIXIhqcPx6cAPe?=
 =?us-ascii?Q?QNNOIOco4XJt/2lb7l7r3K3Y1gQDcLepD4qp/VVEMLs+tT7UPqVcVkUsyUfJ?=
 =?us-ascii?Q?ySkbP6ZsOLUktTBX2A0ca8gHbUQfTxJ5Fww75GacxoDH01zuqSMRk4NmQ0qU?=
 =?us-ascii?Q?P3TrLUXlcXDHfqWOkrv+hE2Kv42Amf382wVcGLTYXThIsiCQbQGbqKjjaGcf?=
 =?us-ascii?Q?DbFkvTRpi4xx06wWSNobk60taO9HhLtPK2P5+/FjoRKFgs1HbWQgza6fMi+R?=
 =?us-ascii?Q?9RMGgTbi08d4Hgv+AG631bx8UxYFmR4XgJw7j56r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF17CE793AB.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e176cb4-8d12-41d0-2190-08dda3548c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 10:42:48.3694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAPO6WMRu+nmj1wNo9tI6F4U3f6SCaj0E+g6AB1KZKK+XzVtdllfWKBISM5kPPINztiKHWMi9Hu/n8dWelbpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFDC846E1F6
X-Proofpoint-ORIG-GUID: 0D2OLdFopUNNCbtcmdWkb1zsptqt5faI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA4MSBTYWx0ZWRfX/vPVZS8A32FV
 CVquC+mfiVjw1FBBdSTIEUB/w+ON+rWJoSGlDMiXPDaTfrjeMe7lXXcPL7tosXRIln0KnwIULFd
 oKPHkcxzWuRE38hoi2fjTXkYd/Eyv14rjIxapX1OYq3knlZ6JtC6A+0FxcEh/QzcmroLzD5sNyz
 aXMoDJ1g+Rm1EtP1yf8WtlUCwiVFH5/sXxcH5wuITFCWxm8Mq6Dv4K9EUUYU7MpN+w6a5m2PoAE
 4ngQcwXLHH/pX6SuB7YG6beerSUpJYaTXWBVaHHdI2TLMFfpL8ze5bmKOicTRN/QY6Z9weTVRQh
 TGbN8Bi04AUQATeFffrse3WnHr1A4bwcaVW6RumNYlv+ZO24sL4R80g77/Tvy3qHwkVWfDD49Lz
 82HXGdjOyxAh+RvXjzqfwRurNnzfp5fMfP5dC7Lr9bY3z6/72KmREmrXT9JagvMdUywJC4xg
X-Authority-Analysis: v=2.4 cv=E7HNpbdl c=1 sm=1 tr=0 ts=6840232c cx=c_pps
 a=/0XEFGVZND4Zu6lHqzgASQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=tZGdHMzQ0ngnd9z78z4A:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 0D2OLdFopUNNCbtcmdWkb1zsptqt5faI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Wednesday, June 4, 2025 3:42 PM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> Subject: [PATCH v10 1/7] graph: add API to override node process function
>=20
> New internal API used by feature arc library to override node's original
> process() func.
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  lib/graph/graph_private.h | 11 +++++++++++
>  lib/graph/node.c          | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h index
> 813dd78b9d..579546e658 100644
> --- a/lib/graph/graph_private.h
> +++ b/lib/graph/graph_private.h
> @@ -198,6 +198,17 @@ struct node_head *node_list_head_get(void);
>   */
>  struct node *node_from_name(const char *name);
>=20
> +/**
> + * @internal
> + *
> + * Override process func of a node.
> + *
> + * @return
> + *   - 0: Success.
> + *   - <0: Error
> + */
> +int node_override_process_func(rte_node_t id, rte_node_process_t
> +process);
> +
>  /* Graph list functions */
>  STAILQ_HEAD(graph_head, graph);
>=20
> diff --git a/lib/graph/node.c b/lib/graph/node.c index
> 101981ec24..c8a1cd5586 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -431,3 +431,26 @@ rte_node_max_count(void)  {
>  	return node_id;
>  }
> +
> +int
> +node_override_process_func(rte_node_t id, rte_node_process_t process) {
> +	struct node *node;
> +
> +	NODE_ID_CHECK(id);
> +	graph_spinlock_lock();
> +
> +	STAILQ_FOREACH(node, &node_list, next) {
> +		if (node->id =3D=3D id) {
> +			node->process =3D process;
> +			graph_spinlock_unlock();
> +			return 0;
> +		}
> +	}
> +

Reaching here means, node is not found. Should you return error here, inste=
ad of 0.


> +	graph_spinlock_unlock();
> +
> +	return 0;
> +fail:
> +	return -1;
> +}
> --
> 2.43.0

