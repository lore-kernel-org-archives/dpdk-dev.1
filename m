Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A5FEC0F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 18:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ED7140647;
	Tue, 24 Mar 2026 19:57:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1099B402CC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:57:50 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OGjeqb3516896 for <dev@dpdk.org>; Tue, 24 Mar 2026 11:57:50 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022136.outbound.protection.outlook.com [52.101.48.136])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d3rp4hhn2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 24 Mar 2026 11:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBdJd7fKbOIGdGJuZ3MAYN4BdHPclQ3G3tsRWP+SggzrK5Vm7hzdeg/8eKUqzXnAe46BmIF+Vieqe0zLRGfjUTUP5fSKviZQw/rht+38PT0kBB1n0Lt8MSv31dtJh8c6vu1ESWvSs79eM8A0BuM6OqOC304sn4CUhskP1vPwPDt8tTjKqAwfGnYMoi4jWy0xogybJ506AP56xp8eVkWwwvAqw2P89j7ix74pBqHwii+I6L2W9CzWJe64aZ6sieeYjneJ41QnOvuQZqGcgwtzu50gy1tIvhys0MHUhTf89IVRL0jPy49er3xcKhbZa7SPbwlVgxxk284gWKWDse5mjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/j3cwwXpjJ+cyF7oSbC70SchuAVgfwHGk6jcRjs1tc=;
 b=eBhX76Z9lXDvotylNgATDBzLz3mbr1z84cV2Sk0JjRHsjUoEE6/IJ8amZjzpr7FiZuHdRlMl4PYaJ8KGWJHtQBOycSCYtxrKznAV0L0Ye3Q+lky2QvMMtwb395UUdo7TKvT9Cju3vRF/3emwkemfbjPZlvI3jMFeemOt8ouH4tEx4u0A8BbXMlPm5VIUKSplVQ8uqc5ioiDfiRcn+Swkl0wFUCUrd3HXmd5wN3O3FSwhTaEfEDSFI6RDcJgRlPvfyvbizIBMW8pCPx7ffWwA5zQPMxpScvzlaW0OISrs35IHGMa1qTjgNzIJC4XHdUv3Ck5D/s4gHv6m/I38Y5CG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/j3cwwXpjJ+cyF7oSbC70SchuAVgfwHGk6jcRjs1tc=;
 b=ck/VGn6PflekVN8wRxN5VzgWLdVBcABRQLBiMkoN9wh8+RgXqqWD+nRxlVeCpFS4S/e0Zqr1AnTuMZxkRU6UTNKkqkGJCACiiFEjDYdVRQUXZ6U9GQGtOB1stevUYVw+HWxRHBfxQwr7csk/ZxrDRZaQoF+K+91KKwf4OO4RuCo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA5PR18MB927601.namprd18.prod.outlook.com (2603:10b6:806:476::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 18:57:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:57:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>
Subject: RE: [PATCH v2 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Thread-Topic: [PATCH v2 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Thread-Index: AQHcu7hAU2M2nce3B0eriu9jS1ep1rW+CKyQ
Date: Tue, 24 Mar 2026 18:57:47 +0000
Message-ID: <CO6PR18MB4484963E55AAAF725A260BA5D848A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260324180121.1449787-1-nkaithakadan@marvell.com>
In-Reply-To: <20260324180121.1449787-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA5PR18MB927601:EE_
x-ms-office365-filtering-correlation-id: 26797488-d6f8-4472-14bd-08de89d73d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: vhLcDUb1zhDhj91JWMrCBeoxLKwBNk5Gl1cRQTSuUoUIeX/2LNrS1kC7/bHLsyrv8DY149sOfXMKjRHi18aRSa4LDWb/+DYIWp+S4QbGDxxLd7Kt3+TM52eLXA6H/19k7N+tFi42F5oxDzrF7/1uG3tShkpsUG2D+CZqpRy8PthCxI6/wTsO+L5svKr4PrxiGMg5icOK3pCFG6jbRn3+LlNmlj8rj/rRFVj7qgv4vW5gF3O4ihaap5HJaU7MvJnrKz4k0yc7KFDPFr3tY9prRcqeiOZgBeg247SgqzCGuXOd14cfJsemmlrNQEl6YTFBG2pGzBNYhC7CpFw/r15r5Ygwmd2PcNSrl5FlLweCZkge0jNzor1Q/kR7nFN5U3FHnMxgVP3+Eo/Hb5buUcsAFCGtQ7EuItLiK5/OlwLcpa8lf8y2pkf05A4f6K80P3UscSAOsJU63WSiZQEl7W2smmTkpO+XDzPeqZPnIHOVzWTRkj9xE12u4zrXjmt5vexns3Rm7bwlPmgK98OzjhEbH0yoraPtddgvo9nAX7EXMy/YCfqaWBNV9wy5+y0znERb6OMJTNRPz1ovfWqo1tB1vv9kJjbcwfWQyEvW1ke14aGPpkBS3+1VeueZByT+TS6x+P3S8vJ2mioMmULr2enTefKlq4sk+RAV751vRsipTYmB5QDkPb1HLLRMWBLfW4oussEJeqVnbAEvP3CNuI98hZIxBaYpigW3WhZ26C8BWk2T05ixMIyoGvU4lcSZsSHWx7cByQmlH3yd63xVPG8LY9qEhhVjO+TFN3hOJ9v0ovA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jvj4QVypx7pDe5muiuHzxg7BuZNoVru37eWtmGCjw/Ya4pDwwFBZSyINEqyd?=
 =?us-ascii?Q?bUNal/YA6bczWSVQyU8VM7IjBYYmQYd4c/d7DGki2pq2ZImxHtbjaPoUGBwo?=
 =?us-ascii?Q?zdlv9ycnMWu3+gXVdoSwJXM9x71mK9V2f6n8EBDAnjvM4DJTgnc7RE/8ZU1N?=
 =?us-ascii?Q?qhcrunw3mlpEKbSd/RrZiLRwtqxnrmOgPQsJOg7Ubt7dGEK/V+7XMilBkiSc?=
 =?us-ascii?Q?X+GsY631XNeOc3JKJCaX3Aj9As3TvC2SAcxgQbtu3hTOz2cTvQq6/qg/huDF?=
 =?us-ascii?Q?xdbBfwfQwuAnYyEphTsU1SK4ttv6uO1OdyBDIIF/cyzxGrozua2oT169uz+p?=
 =?us-ascii?Q?Oj9wnqPYXqpcjJS/nT770XGZcGrlGIgU3gFHCG1YQt67vZlEDo3bUJEpryOB?=
 =?us-ascii?Q?W6sBIZzq/hEgSNaG5BZEm7M1lD8EPJtTjTMB6lG7ydG8MWuzMs6tn1yIbiIl?=
 =?us-ascii?Q?iOFDAudh58axO6CHlKsDC6gA6i9IeTchRDWgA57UH6gFnIiCmqpEP3G5Ij0L?=
 =?us-ascii?Q?nI5RGoEytD3Bmw2dNR2JP99hnsgdyGvmrTrrI/1Awn+jIWrtwFudWyr0WUuz?=
 =?us-ascii?Q?cUZns2WDFXd2y127cxMPpPieK8t2WHtd+KgeWkwP/oMNhDE7/Iwgfxx2nuZ/?=
 =?us-ascii?Q?NPmAgUnO1vVq4khRrVRwu/pP81bBVIDxRyt0PrEP1aXRBqYU9ZJup3wP2BO6?=
 =?us-ascii?Q?KXVjvRSywrM899dBbLmWW5zgNJa8RPcTB1BmXK9DWcFJ0YS2YyoX6/DTaDlj?=
 =?us-ascii?Q?gQ5inBl7avdpPMTgMic1Qrsu2p/1KBefw4DTzsAm6zbfkJOmFNS+6WvwKOaO?=
 =?us-ascii?Q?oAgdWzym31prNfFLr6dzfAJSm5PYk0c/8gEEMkVsIvs2aAkpQ5g7Bci+ZKW/?=
 =?us-ascii?Q?f4wrHQELg0oPIC+hVJwhtgaPCnUeg2/CpqeDn0MuftJKuSx4AXpQEvbOhaww?=
 =?us-ascii?Q?kKRQhOZd8tJfoRfNB688qWale35q31+DOGYx1g/0xXVi8tHOLaVa5MFZQ9/n?=
 =?us-ascii?Q?xSfYW80ClaSbD6wpJi0FhYmqKX/rT+XvlCux0ytSgpa3yHdfCIvbGqN6byZr?=
 =?us-ascii?Q?xzYLaBs4nuEQOlzjtlCWIjtpjSbUKzvmoqIo6f9lktP24mx5R0r5oh07yMpK?=
 =?us-ascii?Q?iAeYLUzYisQv7VO7+o0MevcXnd4KnZqKEqlnLi9giM0O/CUrBBXOWRnQ8ic3?=
 =?us-ascii?Q?YtYmsCcYYMEgrygEsQPEzVrsEZDeBmfkNdT0UoyQ+GuH+bMsK+kqGWf2mWBC?=
 =?us-ascii?Q?6O4VC5JSNk/BV976DnEaVrkH40oU7yUigyiOg6SbReN717PLWUNmkZnx4LaC?=
 =?us-ascii?Q?bSjBCGYXSsGEHB9TGY1DpRj8ZWcupHXNbISo2eb/5Bjb8UvYcBnNoW78pIEl?=
 =?us-ascii?Q?vvLP9Rs3QYmyjskyqyNOBy5FuDUNStVuSMB8u9GHcTKcHvgUBfpyqsAfw2Ga?=
 =?us-ascii?Q?H8k3cmhQhPAotfRhAD9aN58ywRCcOLkpTgLpoNT4+3ToAWphgiynzdrucT/a?=
 =?us-ascii?Q?AV0ckYXyByMKGR9VY0cNseV8bXPN/Gz/8MI73Gl0aD94IKRSOaoBXADjwY9J?=
 =?us-ascii?Q?ouvpNy8Wglj40oEp9Nbpmgiwg0GiMUtUGFYpIcbsafR8qi/MaLPCWB0axsTV?=
 =?us-ascii?Q?amOPPv8hOaVuS/NbXMOPPNIMHIyOLG2rhPym3L9KpXTG2lmkXW5J76ozR36h?=
 =?us-ascii?Q?itX1roNsqw+10AtHzWvVcZBbFT1U6T+wI5W9dHv/+Ain5SUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NHV4dr/ndWDeU7eNfauysL36nNvkIVuX+RF+2WI7xe2SSOh3ymUUOfEcDFmofS9XFxKExVbuyokualP/JSWASrOW5bN3W3NiZZhxxRjcnmQ0eHb8gOLVJKVsmWXFJoexFwx3kDPcG03l7wykX4IBgJ+XSFkJdwuJtJ66gAQqxFHakOX9ixu/n+cf30dctv9tyhQYTyJ//wuN3sKmSBgjVXe0KEy3UaDkBbmbNf3Ogikzx+iqxrUXo6/g+mQSTX0liN3xqiHwCiFv1XYc7kmF68czoWV1tRi52kRD/0OIQqRpBoGWB/VexycDMUO/oASm43VTOj6oqH+Smqo69xwKIA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26797488-d6f8-4472-14bd-08de89d73d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 18:57:47.1628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deW7ZEGJ+43b8dFALGmPBzg+uhw6rvkTGD6djkfQL6Yic8HwHtb0qHom9su+o3Kl739QJUUgPcZnlzV7Cp+pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR18MB927601
X-Proofpoint-ORIG-GUID: HhrFVFgwrHrndf352ScUl5dBAUGE4dHf
X-Authority-Analysis: v=2.4 cv=EeDFgfmC c=1 sm=1 tr=0 ts=69c2deae cx=c_pps
 a=T6TUGF7bDFYKY0QFGZtSVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=Zc_DtpmQZw8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=jyoem3eMnmFP1CKk6E0A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: HhrFVFgwrHrndf352ScUl5dBAUGE4dHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE0NyBTYWx0ZWRfX0H+CgyBRnLMV
 F2d8pAgggFsmLiWpPiarzHFXtDVYbwmnk37jkNG85hySPyP255bc78gvnNI7BgyLTFxNa4Chxoa
 MOqra0SADC5F82kUyzNL6TAZafE8CTtcWu/MvQJ+0/2luyOMRG0vDlHcyrW/cuEcqK+bTeC4CN+
 4Yal8DTYhotA4LLUzydacMY6tbPsMuRvgHkJx+nvL7OkXa/f/VM3uqreApgFE+QK9f0ObHD8CZV
 mLkphU/r38jM8dsi6mUhLJnUe7RSmfBxSOk5fEdLHgurwW51nk27kExHjVtnECghCHs7lGNocFH
 sbUiK99vPdJZWKwFvzP1FAn+UZHGkUnF67NV8EB0ajGs7fG6S7t3v9KijFxl6md5/F4KPdPdSU4
 z3YR+Z2cZ9lkGkzm9jLamSE2hH2eFLKOHuvhraIM3M50n/TUy1mEn+NtfJHlVpTg3BlPOsIb06M
 BKFv8FiplyXinMZH62Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
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
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> Sent: Tuesday, March 24, 2026 11:31 PM
> To: dev@dpdk.org
> Cc: Ankur Dwivedi <adwivedi@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>; Akhil Goya=
l
> <gakhil@marvell.com>
> Subject: [PATCH v2 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
>=20
> This patch series extends the cnxk crypto PMD to support SNOW5G
> NEA4/NIA4 and ZUC256 NEA6/NIA6 confidentiality and integrity
> algorithms for CN20K SoC.
>=20
> v2:
> - Amended patch 2/2 to include release notes update
> - Updated cn20k.ini configuration for CN20K
>=20
> Nithinsen Kaithakadan (1):
>   crypto/cnxk: add SNOW5G and ZUC256 support
>=20
> Tejasree Kondoj (1):
>   crypto/cnxk: add ZUC256 v2 support for cn20k
>=20
>  doc/guides/cryptodevs/features/cn20k.ini      |   4 +
>  doc/guides/rel_notes/release_26_03.rst        |   4 +
>  drivers/common/cnxk/hw/cpt.h                  |   4 +-
>  drivers/common/cnxk/roc_se.c                  |  52 +++++++-
>  drivers/common/cnxk/roc_se.h                  |  18 ++-
>  drivers/crypto/cnxk/cnxk_cryptodev.h          |   2 +-
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c | 118 ++++++++++++++++--
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  13 +-
>  drivers/crypto/cnxk/cnxk_se.h                 |  32 ++++-
>  9 files changed, 219 insertions(+), 28 deletions(-)
>=20
Applied to dpdk-next-crypto
Thanks.
