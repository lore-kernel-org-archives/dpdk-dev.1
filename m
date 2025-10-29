Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD62CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 06:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10FE640288;
	Wed, 29 Oct 2025 07:25:39 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A5D3340281;
 Wed, 29 Oct 2025 07:25:37 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59T3tMVR2777904; Tue, 28 Oct 2025 23:25:36 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021098.outbound.protection.outlook.com [52.101.52.98])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a3audg9jp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 23:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubrggCqbULUXnpk/f65Qshr7q0wazTeA3wlBP0deq+gGNYz/8JtHa5rnlkA+gzyyN3H7SamXSnyiYqxpOKtrCfLGgkGPaggfVUrajYS29dhv2BdrMFoRAyg7Hky3NilWsscvbeECk02YvsujfONIcsAw7E7zeOn321nJUBWZHpcFEpODlybY8GSyGFoklIclhOezb1Dxz33PYw+9Z79hy9arVHx3ZB9W1opq2zAcbpU7VHxbID2EIhwvb9D6xIXurCy7E088qm9Cn5+e0MJkTdCVwtKeMt8wS9+iFDhvuWkhPA1wPpfr4yAfwQKdkMCNqGAdV0N+Y5RF8cmSK5GCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buxfXfAm/bwGdEAQ+znW76ldPdMh5tQYS/UmK6cbMsg=;
 b=Jb05h+IiHbYsS+CHkeV5a2SLoYfIzTkgCi+nJeaP0Y1w28D7jYJADnAO+0sOdta7CttQibLrtcI3qfrDsVnRhTo8J7bTzyplxgUq896nxjrAMj8dQQYiUJf96ywtgBJXS6IM2vFJnkWEtWb0dl5KbX5cBSV0i9UD+2XWZwD16quQc+5MP8G3EU6dt9CUY3k0gW1pQQSNNclZI9w+Tx9TFTVk9ULiqt9i1BUsvMXaKY5xtueGsqxg1wz2VNSzbBsuMy4JkSmnlBDbna+AwJH34HB1n+93l/Nj91CRbvqZzSjt40aMPd5WKBAIHQvGJgvMCugGcmzprRBWg7825XJx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buxfXfAm/bwGdEAQ+znW76ldPdMh5tQYS/UmK6cbMsg=;
 b=pnlHce8gWUX16BDgJe11YZIq9G5Lj7t2ymmyPnN8pK4oGp0qAVDni+K9iFWZC85T9X67qkDFsAFjUvZWjiai0/Zc8q7Andpou/J8xcFUUQdrdJGcHdkHVFqKPjQzP73sOgiDnNkaTJTkahTBBt0XwxB9885+eIAyxkXR9xIlTRA=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 IA0PPF41987529C.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 29 Oct
 2025 06:25:33 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9253.011; Wed, 29 Oct 2025
 06:25:33 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [dpdk-dev] [PATCH v1 1/3] app/test-eventdev: fix issues with
 clang 21.1.4
Thread-Topic: [dpdk-dev] [PATCH v1 1/3] app/test-eventdev: fix issues with
 clang 21.1.4
Thread-Index: AQHcSC+bEaQL336V2ESSbBgJH+pU6bTYqQJb
Date: Wed, 29 Oct 2025 06:25:33 +0000
Message-ID: <PH0PR18MB40862DA7652261115B88195EDEFAA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251028172324.3149379-1-jerinj@marvell.com>
In-Reply-To: <20251028172324.3149379-1-jerinj@marvell.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|IA0PPF41987529C:EE_
x-ms-office365-filtering-correlation-id: 75e0ff52-64ce-4db3-234f-08de16b3f740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SrasiHh3zQGZqNYOi/FnRa1G5KDiHSUp6fGGTq7uhHSz7G0tzSixakqdUV?=
 =?iso-8859-1?Q?kW7qa0Z02SnuMATthGuIuVjJR/vLTo7Kb40iLDUkxFolEfQoQj42AKmZf/?=
 =?iso-8859-1?Q?eYo7whQZAXYQAsYAI6kl7Wz8uOipPvVPO4ScjphU0dGwKgW0AM8IEAduTM?=
 =?iso-8859-1?Q?E9iFit8eATqWINFBCkc6iEPqfO2CRk4anzG9a6mCJ+IU6e86cSgYCgx7LC?=
 =?iso-8859-1?Q?da0FHMmdc/vhXQYm2Li/S8Lhk/R35UcFDufa1EgXiMgsdHkVYfgk/VbMpH?=
 =?iso-8859-1?Q?zSyCBDH2uktD2cTqbYsh3v/uUWGEMc6uwh2VUftxolUT8pzBa8o6eILonw?=
 =?iso-8859-1?Q?UK8ZMAM//SmopAcVDmBJjPzskES5gFXELuLnqJJ0CzG1k8pnGAd4Y0a6Y4?=
 =?iso-8859-1?Q?LMe1wItW7xJLRe7PLRK5gO8bbn+t6XX8S/6rwWaFq2X5fcoxyNdIfLFGxI?=
 =?iso-8859-1?Q?m5EvDJihpd5qMlZ08P6YuXVWJ0qEnmg/KRa5ms+UqDSWtn1nWWH0MrvpRZ?=
 =?iso-8859-1?Q?mKHXSgg7o0CXkQOCDbQqa/5JcS2PxS9MZlvaVs94UrBYgbOoMODgU+2eWB?=
 =?iso-8859-1?Q?0cQPWWFsJQFZ6s7Qyn0U0k2JReNIjQwbEeleysaSGdOgageRlxN/d2eTAF?=
 =?iso-8859-1?Q?d2Y21aYWWufCerexCBxPHzXkt0PILp+KKl5nvzazaFtCi4GnEsaVVaqZ75?=
 =?iso-8859-1?Q?qKi5r5YACc7p5sXc3CoQ+NjrSdbZ5hYf+55VvMlfuFg5hmJp7zEs8HDoGW?=
 =?iso-8859-1?Q?fxg6T6sVm5ktVFeAbwj3thwWuuaHl38KYUltOXxHh4Ph6QoOZw4J1x8P9I?=
 =?iso-8859-1?Q?D8S9qiLqsM9pUt68Ml8gVrSg5N1KmY5ryVpX25QtBIEfOK3iEBuUpuAHS5?=
 =?iso-8859-1?Q?sT1eMkcJ8QfYgNyvUKOzZaiANyg6T4BaC63HdHlqWK4AEOR1JgWkRrFd/G?=
 =?iso-8859-1?Q?8kjnHYUfoJjWZFtGfmozvDtcPwhusWB3Jv2at6i67D1H8bLq0TPU2QCiSF?=
 =?iso-8859-1?Q?/0J6r0TOOLzrPb4OmCCeMNfvKVyblLPM1zzYsHI65Pp00zObgqe97AXhEP?=
 =?iso-8859-1?Q?MrmM+AiSTpXxEE6I8/Gqn8FncPqAnssllVqtsD0NnOfTntoH0NxVQpRVzs?=
 =?iso-8859-1?Q?XB/xa9Vu9sDev2l91Do3QFMaKxDyR3Y0Lowo0+8h3VALK/7nqbGqS63eOR?=
 =?iso-8859-1?Q?+JOFVsEQzUQL56ah55g8ifMqNd9zWDDDUPXj6JheQWcMUi2UjqIJN9tOCm?=
 =?iso-8859-1?Q?OWjn8ZddlhlZRaY805L7M0U4Lq0dz202Q4AvD07k1Mtj3r9zE/QMF+UhPw?=
 =?iso-8859-1?Q?9YMeFKelv33e69ieEcD3tnFMBFttP+iUeWmeWg4Rz0DjDb5QR9J5HZ7bwE?=
 =?iso-8859-1?Q?M8hpewR4DC3Caui3DyyrnJbssXCEfDb2yacfnZ8HygA5fv3aOsbkxDwPsP?=
 =?iso-8859-1?Q?PIXkYHZ0Y/V5y2sz6I8JEIUogs590wiVWSIZMD5+MqsVEXoMsDN4QQUR0Q?=
 =?iso-8859-1?Q?W5wytYstjcvI64GNx0XrUTufeuTVjn3cntd2O8YwwRJDKS1wCUfQkI2t+K?=
 =?iso-8859-1?Q?D5lyxW65ZorxCtPTdpezJ5NUi3AL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LD6g2ewt2L1BmObxnUcfaQ2+JmXmHSMMRooIgsw2cvgQSSd7a/UBNLJkVa?=
 =?iso-8859-1?Q?TypXZTMJWuOJfjbNKtfq4t5sKzsXOgtXmkzP3SrI70CyHj8dV73zpPsDBq?=
 =?iso-8859-1?Q?n+NgEKYYra5WJbbnhnN0Ga0MoqVuXVi81XzqCOpMLkL8wUj86e9H3gSeWM?=
 =?iso-8859-1?Q?ADYcjFoSwbl5GmCSyrGx0EZvGcgSASyhUxMDw2+1pc4NxEQZLjlE6t55Qe?=
 =?iso-8859-1?Q?xClOirOHUvBerm3WHLTVMa0j/p4kpgPE3RzUTzLTCjJx0U7mTIZt5/wwGM?=
 =?iso-8859-1?Q?0IULjn6/p6fP/L+v/HAhq3D0bHruxY0EuCZLl8MYyprd39VywGQCMdHjY3?=
 =?iso-8859-1?Q?iCUCy5NOaq+IuEUUt62AfxK+UUAPCduXhAEnR0tWUqf23zXVKf3XGhq416?=
 =?iso-8859-1?Q?snv+pz5hG6plk5ePSwAyTHhIfpaSy0aTTb6gkym+eB/p5Qdc2df+AFr/nj?=
 =?iso-8859-1?Q?b2Zoj9BTBqH+jzKiXQPu0S7bP4ypVMrHzaegu2Oa3loWKW9yU5enWG24Ve?=
 =?iso-8859-1?Q?pQQ5wiZT9gP2NkhMgBZSKg5zqyrh19mUNUzHzkZ/taeJ+9pui5bqce6d1N?=
 =?iso-8859-1?Q?prupnls48w9rVdIz1xY1a9fEEFNGPRtwxyEc2LSGF3B0MOrFoyTBLNy22v?=
 =?iso-8859-1?Q?INypVRy+YSSvp5WJZnaiBsO4MJl6DGhSmOqPcqq3m1WfpS6gyiw1vWM+s/?=
 =?iso-8859-1?Q?wgQePU7vojtRYhgA58Z8kbHb1kGNO7BOzdUf1dsV6Jb/zNUM5Ku95l59zS?=
 =?iso-8859-1?Q?02kielPlCetQDKN3pHLzbjrbyjKyq3/0FU6N1Tyyj+BrGrqTuuSP3bwde7?=
 =?iso-8859-1?Q?DG0pPL5qy9irPWn2Okqki7gq1Ae0dwm5ATqJq0zhTBTIqIqzxn6rlxrLCd?=
 =?iso-8859-1?Q?Qu43jtjM9VRdRSuMAIpNDDh6XYzh8sajnN7SKrvZtGXVRpARgL/+/VGz0o?=
 =?iso-8859-1?Q?8MnODa2KX1GW52oj1MZXZc+78eeAsgFodwfc0n+T9jTp2uydfzOrJloifa?=
 =?iso-8859-1?Q?bi8tYtknbnYBn1g9gs4YUiJ9336+/zIDv2Jt1BK9aUHILxAqSnT1Jutaq9?=
 =?iso-8859-1?Q?KwVjRkFtny1hcxG8BtRZzHl6u3ZhUklwH+RRyK25s4XVEAV72qUPfIHaON?=
 =?iso-8859-1?Q?BfLI7AkBhEwdgnqHp0I/oFYKRUWfPlxP2v0iy7SjO9laSwShAg4j9gMwNx?=
 =?iso-8859-1?Q?FYEyP1A18sIAbmJ6riHeM4JgTBQWgHxu7ZpQrV/E2HQM4N/XdKG8H78sGF?=
 =?iso-8859-1?Q?4dlDGLOHJYJVgGmF0YQQh16D450Qp/I297xLttTyooHl9+/rP594nE5D0i?=
 =?iso-8859-1?Q?HEJgBqMvcQV0F1wGG1bQLhQSPcCRuAS2l+zkOcILbJxfB1oNFTyRPtLBS/?=
 =?iso-8859-1?Q?tc7PhR25Zet8Af/St2ryMu0sQ+GMTktyF116JOV+GPseZXcuRqJjOZtt+3?=
 =?iso-8859-1?Q?R+rF5Q0hDJtPjG5OA4qQ6HO4Rp04k2KSfl1Or1Yi5c4/J71tLvo0VvaDbl?=
 =?iso-8859-1?Q?de8dRVM68eTUlo6h0r+jjLUDcEUFeJkqqbUa860/jgPWXv4cpOxhDq9zun?=
 =?iso-8859-1?Q?r7Z1UNISh+/awjyqGr06cZHMUy45bKZRA33kzrtgLaKdVNCF1UMtr7nUEz?=
 =?iso-8859-1?Q?gwSLnOhN/ACz3sZ349YbEUDy4j6I1dp5N2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e0ff52-64ce-4db3-234f-08de16b3f740
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:25:33.5938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RskvovGYFuI5ryhY+Tyoj0tArOmTg6t3SbqKUP0Ayq0jtZkxPEhvdIBuuyZGL/eZVSIjrIds1aV932yi54Zck74cC5LUODL3XTVgweLVbFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF41987529C
X-Authority-Analysis: v=2.4 cv=fuLRpV4f c=1 sm=1 tr=0 ts=6901b360 cx=c_pps
 a=1GsU8nEb0rXVac2zXnn+jQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=53QY4wb67aCZFD22mFgA:9 a=wPNLvfGTeEIA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: GLxnoyMGGEv1TBbBM9q5PlUUUFsor_aq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0NCBTYWx0ZWRfXzTbVCpAhcgea
 DIkqSS2tS6un3mOTxMatjggolYvC7FNFu9wS6o7YBaazsRylhJ3hUDhXLLHZ1QLemdQPI1Xs5vv
 PmpmLL6DwHBNLY38DulGOoU1GjTru9ldJarI+atzfipOY+fJaIAI5mWvJdcpo20Fnpqvq0Kaxth
 tSOeWXFh36ETZGncNTX95cgVg5wY+ZK0u0ysigFv8ALIaIznIVaaHr/rPOxmIzPbuyfqRNKplpC
 G2w+dVMlFMU7w//6a0f4FkDnUswoC6DWUEFGZD+Lpd657i4M36hdWS6mpan5PzzLiKw4472XdsI
 EcKMds9PrFBdymgGp8Aj2kDHxJpxVXdoDt3aHVMr3ScsZow2pbfzhZvn+hoR7AiOj0aINBWwu62
 gsapPTpb8pTP3gm69bdn64O/BmV99A==
X-Proofpoint-ORIG-GUID: GLxnoyMGGEv1TBbBM9q5PlUUUFsor_aq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
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

>Fix the following error seen with clang 21.1.4=0A=
>=0A=
>app/test-eventdev/test_perf_common.c:1340:30: error: variable=0A=
>'event' is uninitialized when passed as a const pointer argument=0A=
>here [-Werror,-Wuninitialized-const-pointer]=0A=
>=0A=
>Fixes: b25a66c49e8d ("app/eventdev: add DMA adapter performance test")=0A=
>Cc: stable@dpdk.org=0A=
>=0A=
>Signed-off-by: Jerin Jacob <jerinj@marvell.com>=0A=
=0A=
Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
=0A=
>---=0A=
> app/test-eventdev/test_perf_common.c | 7 ++++---=0A=
> 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
>=0A=
>diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test=
_perf_common.c=0A=
>index 2ad451e457..2bbc17ae96 100644=0A=
>--- a/app/test-eventdev/test_perf_common.c=0A=
>+++ b/app/test-eventdev/test_perf_common.c=0A=
>@@ -1335,13 +1335,14 @@ perf_event_dma_adapter_setup(struct test_perf *t, =
struct prod_data *p)=0A=
>                return -ENOTSUP;=0A=
>        }=0A=
>=0A=
>-       if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND)=
=0A=
>+       if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {=
=0A=
>+               event.queue_id =3D p->queue_id;=0A=
>                ret =3D rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p=
->da.dma_dev_id,=0A=
>                                                      p->da.vchan_id, &eve=
nt);=0A=
>-       else=0A=
>+       } else {=0A=
>                ret =3D rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p=
->da.dma_dev_id,=0A=
>                                                      p->da.vchan_id, NULL=
);=0A=
>-=0A=
>+       }=0A=
>        return ret;=0A=
> }=0A=
>=0A=
>--=0A=
>2.51.2=0A=
=0A=
