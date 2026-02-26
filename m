Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F6FD461C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 04:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522144021F;
	Thu, 26 Feb 2026 05:50:06 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9BEE5400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:50:04 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PGXf2q3056985; Wed, 25 Feb 2026 20:50:03 -0800
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020082.outbound.protection.outlook.com [52.101.85.82])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chnp8upq4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 20:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWXtlmGpFNRhDItVnX9WGOFWBO2EMhuBobazE6DhPtxeYNx3S3i/A1REnW7ILY1tkbBQaGDPMqjW7XyZCBnVEToOuroRJ57ioyiruIBx75z8UpZWbKZd5HzNFrGCLPIsSmC3hdj+BevnhH9KhIH6OFlAQZDry5vny/Lcwe5moZ2vrpzqlQzHFlufDpkVramfU7FjHiWn0206SFGCZd4sdHceqVe4Ro4CV5bMtouJyI+gnv74EWSYE+iLkYNPrf4A61PWGGL4Tjr5/BD7a1kMNQKu4SPbL/DGDzZ4Jj0BeJCMdG+kUCsXvw/0tviZtuTSE3Corh4seMeolAVhjzWWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9NKeh9WqwyyVCdD71KFEJ5De9FqN4REoAAmd/E9BNw=;
 b=J7LFj8URb9AwzIHKDYgLBnLDnAZFQrGfZJVha9WJZ3bJKk9RTMGh0vNLU6tGPy3KS68Nz5E/+bX1O3HnBfSbSzGiuwYA5klbkZIf78AsD4VKScmXc4RUC5H6g7+xXwMO4jLub6aCHENvkDsA7sm4xh7iqDp2U6ObxoF0W+ApN0c6t6oEnbyu/XOM8uYZo5V1IBlGtoky/ETXj7GIUixviUObUW/l3N5i7J0I6pAgLqg8+1ZUaBdyfXRBFTuf03RcZJZnyGwLW/mfkq/ir4C5T2dEZuOpHxAFOVMkyQWayBX2/Br3rnCy3NSR/Y0E+7dxvA30RSFgo5U+drHX2Fwzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9NKeh9WqwyyVCdD71KFEJ5De9FqN4REoAAmd/E9BNw=;
 b=YbOg7TMCE0YiNrblcCiRIYf/GC5SdItkGpjR4yQ1kC+N3JCwR34d2P0XSTfcQrHOmMEM82ZtdkZi6PkXGfIwcbUKLLz2fnN5C0+CjGrjrnuT2dzzMBu28zCcBw0hg9otOKAchqL2sV1BODqANXpg/7k268UR1G8SINn6F9StJRU=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 BL1PR18MB4199.namprd18.prod.outlook.com (2603:10b6:208:31b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Thu, 26 Feb 2026 04:50:01 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9632.015; Thu, 26 Feb 2026
 04:50:01 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Topic: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Index: AQHcpc1jpvvtk8CaqEm1+ZmUQ/c2TrWTDb6zgACjMgCAAB042oAAMAQAgABroEo=
Date: Thu, 26 Feb 2026 04:50:01 +0000
Message-ID: <PH0PR18MB40866F9E996747CAF9CA5443DE72A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225094338.5f0641a5@phoenix.local>
 <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225142004.07954fd2@phoenix.local>
In-Reply-To: <20260225142004.07954fd2@phoenix.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|BL1PR18MB4199:EE_
x-ms-office365-filtering-correlation-id: 6e8258ed-4979-4b07-87ce-08de74f28033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: hDvhlGg2R2FqWfK5hw8pc1k9w1eRJy0BbfOXOO4bOry44h6TWw0tHg0/5hNAPDzddPU3Eu/nFCbUJeVmUIUhEodtgIVTYWEXEb/zx+46Yi4gfg1308g/lk19SQs13rslATQRxtedDCSZtdYo4IjE+wlKgBxQNNm6SrnT+lGHH6E0mXE/PML2pw0SR8cCXhnlMqIdQG2TYKG2AjUADCN7/IUGnERnnEkrjV11kmbDzGH2cWUcTjHHLdNkUiyMbx3e8fItueuJZD/kMkAhpHJj3y+fe6Bzys6oy2UpTc4TuQ8HyfmFIW2p4eWtKsYd6YaogzGp7DFeMbdVej3g3n/shxIlYVcCcEm5ZFnIXLLYywIGfJy9lxgFBTYsyCI3TLAGs7thnMLsLjG/bSHelmdwPWhYNA8/Pred1jK2jJtQcYQ3svguecmZax3itXAJ9/EDLrDJktvY1mHUYO2z0t6FP/uwdATe0pYbtEWd/5UDG4BP0T0SDagbqX0ck3MDdoBd9Py9E7VrgePX6FpsLeuB41cO+rU/5tEwmUQL5vfIaMviuPkOni/Q992fVVEKOD7BYL0t98fGbUYn/BK3yh7p/x/Im0my7wrWuNtNdnRxrEpWwgqoUoo9TVZIvIP1aBPriOXDz3eaOXAYsXaIVsZGXM6b7HPgxbTrxs+ndP1Enp6Pq+e0StHDqxrDwZ3z01GD6Ie16UdMEUeMl+TehzPBjt8a53xDTp4lpEaJpFwNSgAuXFHTADxwwRhyfLtyeFu0lvXZmWAj3zAcrfHQRcFJ7uCarH1HKcT9P9id9ridLSU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?R1QfKQIuOE1F+V2QEcX0HO0CEBVvHOsNd2+2vzOifxDCIM/O2vni+Z6u?=
 =?Windows-1252?Q?jFhnspBZIPaUop0Xz7zoBY8kiywk7gH22Itq2q7uq3V4GHXr8TbF69uX?=
 =?Windows-1252?Q?bxoHKVQ1tddIGqZtQJCDkL9QExZXBVlI+ZVgHByh5Z+HaLWrJCcSWbWQ?=
 =?Windows-1252?Q?fp6Tu526y5NDSA1SRI+K7sf/dL9p/DG9ay+JZiglHbtUDfo2Yuf1Ul32?=
 =?Windows-1252?Q?4pbDkrIyejrpi3yWbXRMJLT5AQh543fFEme+5dtQUPAxDrWUygK8vjly?=
 =?Windows-1252?Q?Fs+XFZEQHjQ4zwlSKzzwNSufiZAkez857HjlPK8wqXyKmZijdzaELB2Z?=
 =?Windows-1252?Q?U7/f968v/m++WbTnmX1mMBJ7uC0dXsb9N46aedEy1ggVxD5rajqp0uaG?=
 =?Windows-1252?Q?6JwYzFOkzC8qepoIqpDBzbSz2CHnjzT0457ZTeYkjj3BBJ2P4vSyHKJ7?=
 =?Windows-1252?Q?z/iDtHcRmx995W/La05WShLuOtegmo7gXMsSR2ldqyl29CFop1nriPzm?=
 =?Windows-1252?Q?gP6bbAzWiVS7mLFdAGHPluwFJcypOHdw8/2vwaLH/o+nStMEiuozki5f?=
 =?Windows-1252?Q?OP7PsDjUGSxXMMJJ6MluZDBVP2jVTS7EwHx/anqGqa4hGfSTrFx00PrH?=
 =?Windows-1252?Q?iK/rwPfZUnnhUdt77lv5bHIrMz7fJf8h4Ad6lbTbBWekossp8btV8sCW?=
 =?Windows-1252?Q?cZy+hY8p2IfNyvOXtkGxn0/JymD64SFaOaZPU8Il6sBJmDDfTmEB7ZZ2?=
 =?Windows-1252?Q?rtt6vLVsnNppbOV06o7N6Lcr7UiFYWyjcqiI8rJXSv4kWkuHHghmwHXw?=
 =?Windows-1252?Q?d7r0kSo1xtTpQVr87jFtt6q8dTs913Dt4sV43XEj4gWNAZKsvC+MUmxR?=
 =?Windows-1252?Q?YqP0CRneckevsB8LACWtP+dcfWWQL++eP9KJ0KZbwiBOnRd5tq5RIj82?=
 =?Windows-1252?Q?5YTthA2SEbZw3vVsB12ogZE8sisNABuujqRA9qre1tG7oPoMPwVkxaZT?=
 =?Windows-1252?Q?5D+7ZjnfZZcCjXmWuLiLDuH+BoGEzAAe8FZSlp4cpvZ6Y0bc/dIDp5CL?=
 =?Windows-1252?Q?Soj3Tgci5HyPW5jT/7OFUOAkg/0LYKpP35x4Tx8StyyP9TMVKICHG9zS?=
 =?Windows-1252?Q?1CVnzAMxVBZ+JHuL35e+AC5K3FydkDAbz5sFnL5b8lkrc3uWFNlD9fHG?=
 =?Windows-1252?Q?TgDmM0JLfyCVL6rMeGjVBsp7/EIJwHdMD0yRmTLjQNtIT0AwK+PIwoXH?=
 =?Windows-1252?Q?u7altArDwU49jPlHVr8pXrcwjj4JruzeRd2v1TrjSwzT+6dh1R6sa17Q?=
 =?Windows-1252?Q?9cMDCXAH+1KYyFpLrz2Su+jN1E8hDWvoQyHtBigQK9ADMdWr+2+mfvXh?=
 =?Windows-1252?Q?PQOEDfAyCQ98n9/crPBRWSwXrh3C75qI52EWaLDXcY/vyTyU5ejOd/e8?=
 =?Windows-1252?Q?dDSXXCTJQMsdlbffA61ltY2K63Ku4N6dIi6B3KBA4YUBoMvt6EjZmuRi?=
 =?Windows-1252?Q?i1EMIKqNUbW4lxfy/UPnc+3VGqtFXmWYyrO4Kl+jxkkc4YBAz4QyWjys?=
 =?Windows-1252?Q?85TFAXkriu7nfNLUmBV4clXVnoBjFpRPyEbKgdYKvyMbdzWDpz3wkV82?=
 =?Windows-1252?Q?Ug9JjT+mZYa7InUk3I7eaNX0RjpXld6s0eTUPh7ItqW9jJiOqR1FS0o9?=
 =?Windows-1252?Q?MiCdPNiY2TOEJVN/QTHsAJpMnAMIzgquRaobzVJVICUlV5S3Lw3PcKB3?=
 =?Windows-1252?Q?C4Si1IgmnRsQh9eyJpnbRcnRr9rwPeQWSy4n8egkd+XV6+4+K0u5ZLft?=
 =?Windows-1252?Q?eSPncO100W/sfo/bQtR3xU3/F71k3zSyieKArHgO9rrbDeE+08nNaevL?=
 =?Windows-1252?Q?LbHtx0rRd7E84w=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8258ed-4979-4b07-87ce-08de74f28033
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 04:50:01.4365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6qd+AmsGm/s31d7Ongf/HmL1Lb0dmfh70n8k6haZAqIM6Ztt3Ej/kgkQTcPrhVTFMTFCFIdVb7gSfWMpv/41ZM8TFerjIFdmhtEguWvOuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4199
X-Proofpoint-ORIG-GUID: NbgTrodcFqWFfFuRgkoHwUJt7citZhni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA0MCBTYWx0ZWRfX/m/OvvnZNFcV
 4PAz4gWUafjdzizn5iB6iWPXW45paZbnvwTazFxiKTK/QHJBtexJO66YSqBDg15XZnS9Ce0hSvw
 2YI+cUMB8Bvv958TEG8XYY/R5XLF9P13kTcKj7up8jt/iAGJfNyRx1XXRDmyiZzSJ8O6IA3vIfY
 +KBmj4ugnXuch0/0y6Nz9CUrhr+q09WcEyZl7lgTKFln3/MtTFXFgaESIQfcFCG2MUBimAnCy2G
 0oqVXBYT9/WLqc4eNWjw5SvY2E9Jcz7CFaWxvY60iXQrSAP+yJ0MT+QXlpMUnnK2U5+Skpgs3PK
 CIsT4fw+G2KcU7/SSepL+0T1EXbUIK7DaDXxHRwO1YbUylHPYz9kweCzIu8PA1ZDbX1WHI7wm4d
 XJ0KgEYK3A1Y3W8r/ibpCPJCs3twvks7WXkI14H/6XJAbM+RvQSc6YOr46gq/k/6yLDSaKkRZYp
 3wITnIzcBaqZ3sZVLzA==
X-Authority-Analysis: v=2.4 cv=bNYb4f+Z c=1 sm=1 tr=0 ts=699fd0fb cx=c_pps
 a=NnP4WoPY/9ItU/dr56klNw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=5DstUhjOC2_pQHQen3cA:9
 a=pILNOxqGKmIA:10
X-Proofpoint-GUID: NbgTrodcFqWFfFuRgkoHwUJt7citZhni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
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

>> >Good idea, but fails miserably.=0A=
>>=0A=
>> My bad, here is the full fix, verified on our arm64 machine with=0A=
>> meson setup build -Dplatform=3Dgeneric=0A=
>=0A=
>=0A=
>Ok but other than getting more build coverage, is there any point in=0A=
>building this code on a generic platform?=0A=
=0A=
The driver can be used with distro packages, though it won=92t be optimized=
 for performance.=0A=
