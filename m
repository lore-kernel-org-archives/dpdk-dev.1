Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC42CCCA474
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C9E4409FA;
	Wed,  1 Oct 2025 09:43:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D2C09400EF;
 Wed,  1 Oct 2025 09:43:06 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916L1oi020004;
 Wed, 1 Oct 2025 00:43:06 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022121.outbound.protection.outlook.com
 [40.107.200.121])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefhctj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 00:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e06jgr+g8vcwHRhKIq3hklJaxRFp9Is751rPE+vG2yJ7qeNk1vp0ZNobvuZcFIM06fFjiUoW1udkMQYriz4bS1G/cU2mBE9HdOBn+1p1ijns63uuapJATqAyT8HrTaZghK0ef1JR530xKTDoXCgxVv1oWZ9aPQoTz1k15VUVBBFDBYerdM8vgrh6yoXg4Yl9amAK6c0PrwJm/JVybrYfX8VHusbb9T3OWQC9+Uk5TfByg0yXQ486KSE03U9LsCv/sPGlvnhPcwZxasJl5HTjUvtjHKd+7WhFftV2SHP6DaZVgIm9SS4m+K0cZfFjVyrs/HyZgLeuK742wWHilGQxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5dbTBGROPNG2chwJAuGyaZ1bFuRQT6rpq10TCO8RiA=;
 b=fXl0BEx5qWO5ED7hexNXkMU5GX08ANNWToVoYoaeEm54JCkYTB4Fkd6M/APmN+OHB4lMMBbcLx0K9uxIVv4Q6yiUh401JLaoP2ohUt+0ukMQHShdxQ8JELtU4NL/HjyoeHTxJO0I8WqtC09AKp4ecFSLV4QmJ0y4Ttih1EKYWXcnlZof/9rButC+RYZ3ytKa50gFhUC2cRBErt7BbgwcxC3oUS11kgfeEIzOGcCTy37BHfBbR6sdlN7fbva7M7Wgsok/+l9ohSCWXO3eLeg5HKEPrqqMuDgYUsHhCgsIwwF/7c18hhognlmJ9nJdIZ6jpz5lunGjgaLnAiuLN1sPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5dbTBGROPNG2chwJAuGyaZ1bFuRQT6rpq10TCO8RiA=;
 b=li2uLCSknrnaeHeFZIZW+CBkW/Bw/kT5DlOvwfpD6KJBHCdIDnwsET/fjzwClsA5WXXVLAOW2OECIQqXPfZDtjy2O42x5fMoxFrft5NBsc1d/iY5k0KaHccNUhLVG2GTt5z7WNB678AOAXyg1e0793cl0IJKq3g7zGO089fIg0E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM6PR18MB3538.namprd18.prod.outlook.com (2603:10b6:5:2a3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 07:43:04 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:43:03 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 "kai.ji@intel.com" <kai.ji@intel.com>,
 "ciara.power@intel.com" <ciara.power@intel.com>,
 "pablo.de.lara.guarch@intel.com" <pablo.de.lara.guarch@intel.com>,
 "arkadiuszx.kusztal@intel.com" <arkadiuszx.kusztal@intel.com>, dpdk stable
 <stable@dpdk.org>
Subject: RE: [PATCH] test/crypto: fix for mbuf sanity check failure
Thread-Topic: [PATCH] test/crypto: fix for mbuf sanity check failure
Thread-Index: AQHcLJWSYJ9IpTGxGEK3vlofnvUyyLSs9KDQ
Date: Wed, 1 Oct 2025 07:43:03 +0000
Message-ID: <CO6PR18MB4484031CA962CCEE5D416EE7D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250923142254.1904208-1-nkaithakadan@marvell.com>
In-Reply-To: <20250923142254.1904208-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM6PR18MB3538:EE_
x-ms-office365-filtering-correlation-id: 889759f1-a7b6-4bb2-cbe2-08de00be2774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RFXqdpDyxJMqNnBGRYH+gRZGWJa0OAWUUMLN0Rw9EZQ5t2e4fUKImkBXcha6?=
 =?us-ascii?Q?kHbfAGYSoQZ9+/xHWwCAfZlOOWr8FyZLtRcWkvBpXjAK49eewH8OCq6+ZzOv?=
 =?us-ascii?Q?v8gQWt69zfFTdXrYXPBgB9dNqtk3h/WvGEeRA5BLDXztw9FhOw8F8TJ/Ve7m?=
 =?us-ascii?Q?GqpF2hKQ98k6ZJiBis/syaAP8Xg8dYzRbt8r6Jgnan1IiIwND+vfKiGREi45?=
 =?us-ascii?Q?TO2bOXQDIW3DP05XRSMjZj5g/BPRHdb4c2kNWxmqzzc37gWs3ClVxR4iz7lo?=
 =?us-ascii?Q?lHKbzU2C7p6oNbe4aCMiQru+lO5CVZb6zjCdtnkL2X+B5LLQVWyYn1LAKqr+?=
 =?us-ascii?Q?0aqYNfw9EC27CCxGeRZrTN08jBIxpOiRVlOjnYEviixQ49zbE9um45lYsFiP?=
 =?us-ascii?Q?7VDP6iyJVkBx0VLsXA2umgKhi2TfgN41P8RyCbF5byW9E9AThLbynM8scjtz?=
 =?us-ascii?Q?sRASR0Y7XuAAV9SEC37X2igaeogEuSWSp/LQ4ZKo0/Zld5UFa/lZtMNLKzqI?=
 =?us-ascii?Q?aCCAC1b70SCEtmXLRbg3jgG2nec6/mZr6GRRv1nGSS7+zdVYgD47ng9z202I?=
 =?us-ascii?Q?5nMCT6advcmApIjcE43XAzyxtrPmfsBYdkafGgCWMXwYulDxH2KJuLJeZmy6?=
 =?us-ascii?Q?Y6QnglVu2VWJhUjcdhd/2gLwcljt08UZT2Jb/NWZbBDLqkhG/Rs6U0Fo7ffm?=
 =?us-ascii?Q?s2+EgBECjf09L7IwywLQP138vLCT0VGgCd6jUuy48aNIsleKYrKeq/1veo16?=
 =?us-ascii?Q?+lvcla8t1Ff4Db4yLLrJ9lbWZjQHFTBpbYuiYTOm7C4q5N8SZg18vMPaRF4i?=
 =?us-ascii?Q?luVrC4TJ4BZJeHXAHKQAchoOPueQCao11xokxDrE6ZO8uZnPO0lB499XGPFG?=
 =?us-ascii?Q?YsqHzfoXjWSstiIGAZx+hGitRs3naXD5MNRCgdc1rLxEM2blRJa/wmZBA/+N?=
 =?us-ascii?Q?H06nvrz2zTWoTXHVRn2T4sMMRuap5GgscjWITUE3pmq/7hiLNc7Op2CMcp+z?=
 =?us-ascii?Q?tV8LRwwANt8tMr7bXj2UvNvuWvqCm71VJmn0JVKGvoMkqVGAiIhICdtS68El?=
 =?us-ascii?Q?xLO5BNitajTz1DvHEme/2COGVRy5mzeJu2crFSESCf74Hpbs1eJIXjViWwje?=
 =?us-ascii?Q?49OdhW0WhyZo+3ne/y+VpaEX604b4DjZbmiK1OJobRWzJzrBTqKUP8apN5vW?=
 =?us-ascii?Q?4JAYEcV/6TyrC85DFmn9xpA9rN8jip3z9wvtsDhxrTG+wfwjMfqKmtFOeUSd?=
 =?us-ascii?Q?OmtBWpaWdOkaPEfNjCjHFY6LUmVqtwDAucEc3vCFcmtpJYLXQsCOMmR36nyn?=
 =?us-ascii?Q?BQ6nc7DVFCZNrzPqkGDZyCpN6Odig2W2qE5K88pkxxq5aLkUdNTMmPHMfjLT?=
 =?us-ascii?Q?GOiuXByclswXDH/kaElWg34kMOVFQwAHOdMqNglxrOiNaO7Cb0PQ+K4BzIPY?=
 =?us-ascii?Q?2Hc0h1ovitaJYNl/lfmMVp5MYUQTSoCZQrD1NB5rzSaLzvJExivb1SG1MOv4?=
 =?us-ascii?Q?4fIyEojMDULqdNEPQlLjB1eWqYT2sLpNAK5W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WDlvhbQY43MSiGgMq3KfumQ1uOzjXcOmMF/2jWEQxcf1vC8RMmR5fuWFjosf?=
 =?us-ascii?Q?v0FobmVQ7rY+afKip/9H90jRd+W4Ycp2GS9BHxJJm4DStCEclSA5peOlA8m5?=
 =?us-ascii?Q?OZI2we+7nklD4sHfC6LIF0roc1nXaFUcxGWdhNySJS5+qGAPkErfG1o2sdj4?=
 =?us-ascii?Q?sCyXZhBgu/tpeovfqv0AV8uMDtes1ThfkxJkKI5iSYedGvcAhSYLekm56LnE?=
 =?us-ascii?Q?04CdbtB1HPku67De53fVCxpMEJxS7C9mMdVoQPChjbn1yEjx7TTKVtksXu9e?=
 =?us-ascii?Q?4yC50RTYm3hcFYNExCM7sqJdHltqkAqNGIauFN9esyxF5mKXL+7NrAvn03Mr?=
 =?us-ascii?Q?0afxHmBVvYQDtUtLel372H32XJOwN1YjH1XurScE5HL0a5UzL2fk0j8mR2UW?=
 =?us-ascii?Q?YsBGkBIWaXkcP3RYp71jNxoNst7rFg1LuKmaXlGI9Vtb3lHBjziC4k8Zh+S4?=
 =?us-ascii?Q?5vqFjbWy500o/fQhu4Qo/9y/TKFf+DOjrP8vyJgGAqTSBB5xmlC/b7zBC6QI?=
 =?us-ascii?Q?Epa9oAE2EnFCyNkJlP1IMrYL2fHPrK49947iAeoMbGo33B4E9yCoZYjR+tdj?=
 =?us-ascii?Q?2z1BLV2AGoFjHsPMPhfslK2sb8N/IXp1J1BY1J+/qfeGwNJNlC/5W3sghDB4?=
 =?us-ascii?Q?6TilsoOJc1dpAgE4B2r6TLObN9mG31qxclXMzPjPyKn1VsivGhnDPHnCj34A?=
 =?us-ascii?Q?ZN/N/mgNAIHMUR3quvNeWaksTJc1HA/uC5QTM0D/g12xMhVAR78mMFCwxSBR?=
 =?us-ascii?Q?1qtr9f5u5Uzvyc5D9Pal61cGvx9/u0fs0fnFG2IJAYjF3xpzE0zMIJImgwBw?=
 =?us-ascii?Q?OjkOGdzjacIiLaztsExNDpYgXDPOb091yQh3TWlaOYPsfXf2SYyrNwfllwkn?=
 =?us-ascii?Q?idtpYctIlWUPUqqLMqTFQEDmhAvpr/tO5lKoOfzXo53IwVQtUWUCpXwmOJyz?=
 =?us-ascii?Q?aOfol9TIetTZ8VlVoFe9eKmKoQu0kBUaMJs1I82CP05ovCdcDci68/NVqDQG?=
 =?us-ascii?Q?NCkcAT1jMTiyTa7GKUP2EJk7u8QSJSseOoBWz03DzXOKZxP+IDVskSY+iBM+?=
 =?us-ascii?Q?pTM6srqnKeG4yEdtkYkv5I4oJubgiBvCQzynEK+TebL7NY8ddER+71Xxtd8S?=
 =?us-ascii?Q?K+hh7y8wDMKiU47O6KRu3OFVoXDNdnf96KqjCQvVBOY+kQOINHSFhhv5R68r?=
 =?us-ascii?Q?La8GauHmL+Q+OGIs783XNp+0uXmyWYCuckKGjb6buxB/98zlSC1A9ZS3vYg8?=
 =?us-ascii?Q?Pm7ZNA+VkIZ5nOJAMdoS/tDceKE+phJI5Lwg8OJPOqJr4kqaksiyHkqbikMw?=
 =?us-ascii?Q?+m4d7H1U9yo1nMJ5QgHj5bj95beh2wm0POarLqtHE7JEKtQd2bQPlz5+5ajC?=
 =?us-ascii?Q?zWytdtrszQTKSgcnojsKpIGb/Xg+4v/WJ/exDMQYLKyNCkeuhnwmz7hENap5?=
 =?us-ascii?Q?y5MmHjqLoogEvHNaY9m4Qms7HHhWoNrTAmfHOxNEO2hHS8FLKMEHPTWtER0j?=
 =?us-ascii?Q?CalHIBtPZnaLaRC1y/zQWvuIBze0Jp+IlgFGsMvM0KUuedYFWNOTV13FyB7I?=
 =?us-ascii?Q?Ku1I3t9M2NpgeT6LdDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889759f1-a7b6-4bb2-cbe2-08de00be2774
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:43:03.8661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTCYQAxayoSTe1meQJdyKUwvrJCuhObfcE2DA/u5jgCyUu4E0u8dzI646ArvWXQfAHhBUAMq1SdcK5GXbP0NCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3538
X-Proofpoint-GUID: TQSFwa68Asw2nmUm1lPzymS-fueDXXeO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfXwsyzg1TrBT2e
 4OAbVmOlWPI8LsxE0mz/mwArNA9tkXo9M/wgBdYpz4/2g8fPClW5SsxFHalowFf5ieqsLMRUgsF
 2dhcfJjQt+wxvAx+XK6RCuF+MFAfP1wclMYUiJ+YtOM/VpmQpaH3r8inOYmKDULUskIwdgFCLUS
 PBAsvanMmBT+NlWCzPgdaMp0nFtV2TVjot1Y3pGQ6JkBzdWma+fOA9LpusaB9LhfDild4rm1KBp
 s8VZzof37GV6uR4ILbFn09i4IVQ+A/CJvGARhxniqrcB6AOjfHOKKQsRC5SRih7PgoSi9obcz2b
 T8HDNVOnZngkhqahNHqVPMnqS4sCqIX44M3sorQPI+Qq3zWSJaC4TepYJp6jVL/22lRUcI0pWv2
 yEQtse9iqf7Juqzjb8ugtR2ccA1asg==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dcdb8a cx=c_pps
 a=PlzX2GN61/O3EU/AUs1JWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=4twkm_Juo2pv0kCg99gA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TQSFwa68Asw2nmUm1lPzymS-fueDXXeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

> Subject: [PATCH] test/crypto: fix for mbuf sanity check failure
>=20
> This patch resolves the following mbuf sanity check errors.
>   - updating nb_segs and pkt_len in the head mbuf after
>     freeing intermediate nodes in the chain.
>   - fix incorrect usage of rte_pktmbuf_append by ensuring
>     the head mbuf is passed instead of an intermediate
>     node, allowing proper tail detection and metadata
>     update.
>=20
> Fixes: dc3f6c5347b2 ("test/crypto: fix wireless auth digest segment")
> Fixes: 43220096d66a ("test/crypto: add PDCP cases for scatter gather")
> Fixes: dcdd01691f39 ("test/crypto: add GMAC SGL")
> Fixes: f3dbf94be60c ("app/test: check SGL on QAT")
Cc: stable@dpdk.org

>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
