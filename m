Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E7DC83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 05:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E89402D1;
	Mon, 28 Jul 2025 07:11:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E149F400D5;
 Mon, 28 Jul 2025 07:11:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RNvZqT000875;
 Sun, 27 Jul 2025 22:11:04 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 485wwq0g2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Jul 2025 22:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKd66G9z6d42hNT97jpdmf5XrYYnfW9YCjr3w/ZaVcBcCI+PMdrpU7em7qiTVfUWDonPjAPILP/FSKLqXrSYgJDHXto9dpf2FZh4T7q+sZvUz2e2EFgSYAat1nZyv2vrMiSkkzek5Z619wj5v2KLo3cxs78vhYfBTgRuwQw0hrlGWQmQNcnX51+h2p8gSVcHzOk2g3vbT+MoCvrzAWpvFKtCaUGrLGFkRWNi68Z8aIS3uB1RaCqEiOv26TKABeLTbxk6SNI61eaDgtr/bnovt4pK1SUpTJaXDf/Grg2s0qk3G6xVp4u951eN8VRldtRkIVdpp9ofDqb0dNlcZAXZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKJ2HquIbkTueLz2HpR2hMKTx15b0cz5Tbn+Piwt0NM=;
 b=XJJ0J2wBJst3NXsve3KCPTh7++y/2fHM6hqEAtTjv+uj3ZCMorWM8gj7QbQCH8f1Yj8KzPEcBd5/Zu46HVe9/WBQx2TgH84+2GZrHOkFGPquYvaNYI8xGbnOZoYYu3BXsZU9Bb6mCUvhf4dHtKZHH7Bsk/E5phTb0XebpWNdG3Klgvpg+ZTRqlZqwYcljfVndVfOAzWCd8gzOEIg0UGN4wISgMPYfnueVF7VC40kMdg11vFkxTB4ROWdyU0aAfk9xlhfl6EdbvCBq9rNhNgCvixPoFAovhpesX2fPyLQUKUDji8Zw20sb7kqs1tBzgjTcDFgoddtmgWVahNcRdEUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKJ2HquIbkTueLz2HpR2hMKTx15b0cz5Tbn+Piwt0NM=;
 b=hm1aGsmLJLxgl67LcCSsmcq/liGWvR2iszqewAzWnh0BIfurWOiscXJQp4MOh3KcN0EtsnihDd0Sfk8bug6ofvqwZeSLwAwhVtZZnmN6WEhtfNU27cd9XI7gGRz0OmiDQfprbG824qyKdQfgShyLDhIXZKJ7iO+a9wTWoVZo/fs=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 IA3PR18MB6334.namprd18.prod.outlook.com (2603:10b6:208:529::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 05:11:01 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 05:11:01 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: fengchengwen <fengchengwen@huawei.com>, "techboard@dpdk.org"
 <techboard@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Amit Prakash
 Shukla <amitprakashs@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Vamsi
 Krishna Attunuru <vattunuru@marvell.com>, "g.singh@nxp.com"
 <g.singh@nxp.com>, "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>, "conor.walsh@intel.com"
 <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>
Subject: Re: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Topic: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Index: AQHb+mfjg+2JwiV92EKoEHKCVDW9E7RCXj/UgAE82gCAA2mRfw==
Date: Mon, 28 Jul 2025 05:11:01 +0000
Message-ID: <PH0PR18MB4086088F7E9E8A4D257B658BDE5AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
 <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
 <3307880.vfdyTQepKt@thomas>
 <PH0PR18MB40865EFFF34A38C49079F979DE59A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <315e032d-c022-4ea2-b734-3d3a07f5ebc2@huawei.com>
In-Reply-To: <315e032d-c022-4ea2-b734-3d3a07f5ebc2@huawei.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|IA3PR18MB6334:EE_
x-ms-office365-filtering-correlation-id: f0496e94-aa66-44be-beae-08ddcd9524f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tA02/7m/6VAAm2Rdb0F/YHym8uww2aRoAri2mtkcc5AeHfR0AnKDdNis0J?=
 =?iso-8859-1?Q?73ihJZ2hmQBlXjzQDEHU6tcZLw2Sh3M0/oeEEObMkz5jLFlddXI49IS2ny?=
 =?iso-8859-1?Q?ex+EFXuHHwpkeviDFucKv6+Ax4O/1fx4d9Xg8XFNk0DWtilYtPXL5mQWhY?=
 =?iso-8859-1?Q?7iFaQUCC5CmUM7KDy5jj9ful32jWvw5i6mggEVjOav3CsRbyreZXxsaGpc?=
 =?iso-8859-1?Q?r5+ZIUDR2szH7Gm7uCqpQUE9BPpABIt/yPlsregP0FwAPGoi9QqcXunijz?=
 =?iso-8859-1?Q?8orpT9v+Klf4DJtH6jY/quc/Hji2JiELLabQtJPfp7x2wic29SFlaCcdHI?=
 =?iso-8859-1?Q?BqleqrtK3QRK7dPjMk9dcwRFAYHFzb2eb6+LLgFMn6/fkYiPvqQQ6kNGJ9?=
 =?iso-8859-1?Q?aksvrrAxYAF07Zb5lIidRR2kcfOEHg+v2vGYSobOiHlf/JDvET0M5igUNz?=
 =?iso-8859-1?Q?FWFnY535EzTuHinvFgz1Y2Gh9Ebfwe207+sb5kHyoJi0BtR6qT/HXoTkrK?=
 =?iso-8859-1?Q?L47/a1xvnUK8a4g872t9YAqhfBC6t7CMCoMgzZDBJlY2CNOmVXT892CDun?=
 =?iso-8859-1?Q?B6WhWcULSGDBpOxgokqMtHxGZ/yp+6ckeutWcL/MyIjxcen8zHmPK2FCti?=
 =?iso-8859-1?Q?W9SR5FwtPyl/KNHltB1CnHfWX/DDly0al7qfr/LSHFPXEPhPOCQJjq66pb?=
 =?iso-8859-1?Q?xgQkVz0tH6L/nxt8yCXwgS8ogtYQVanf93wRBkpwZ/gh8XtbFITs3JYvOX?=
 =?iso-8859-1?Q?enCBY/nCOZ/HHGRElh7409CnGPxvk6EAUNyq1jMNye6ifyCVlXwtrRmX1S?=
 =?iso-8859-1?Q?xSMZ8r906BaoAQj9jWYZ2EwnrrAUaqANQUjIqBzzbvfGMfTP9XSZFCbuI/?=
 =?iso-8859-1?Q?nwurjnmBwlgNCp2enbF/g/nVYWwuQ+BZzpTuKN/5ue3dwLK0PuBQibHRkx?=
 =?iso-8859-1?Q?V0xpC5G594lxqo15OhPYCkzSkgQAg4gIgaunoPJ/IekJE+BF0SMSRYsw1v?=
 =?iso-8859-1?Q?mkezgKtNDves3COtaRijzDO8FsaV5gabeWa/a/EPU6db/6CU19NqytKOHD?=
 =?iso-8859-1?Q?NT2y057YqyzbVE8P2QRvLOiPXGOexQbeT1Y+a6gHlZB2SnRbk07u+UmskS?=
 =?iso-8859-1?Q?GrOdVQBPEYCl5z70bUWCWqN7pJ6ukO216mYcc1yvHnQ/uveCSba0YASuYo?=
 =?iso-8859-1?Q?1ZfV06KNrPGbp4J+oCLl+vATrY2DXvy/X1X/fQEWrDMnb+cWdtuL2t578h?=
 =?iso-8859-1?Q?wDtpm+vwytzhhykAnpDRBbcXNFV8PZcHVut/Om65TyFWnLVCIWu4h0SspR?=
 =?iso-8859-1?Q?qyienSG4bplqLLOFNvRhE0BVQdlQY67C5dxxLGA90prHekXdY1tzSLtuZD?=
 =?iso-8859-1?Q?X31bNvThkf3hhBW+PfZr/2I0cYStzVL8yX6W1Gq9RNQz7Jm0+npU01nXOc?=
 =?iso-8859-1?Q?Ew2z8OGJ0345VeJtPBrGoxXVrzwVndiQfQmMyzhdjOqNWHHii93GpXpK/W?=
 =?iso-8859-1?Q?uz5/FSBah3EjLY3/PLiMuHYo2qVUWpGkEmdGwlE+4p9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yNefm7i4Iq4iZBRz8ALVgzgmyjMC6nqbsyC4zU0fH0IRVAt3n1zmfoFARG?=
 =?iso-8859-1?Q?zK4e6YsIP3cpdtpe3qiJwkEz9uSTopJWzWpsfSELyZXLyF0m6BdBVzpBF7?=
 =?iso-8859-1?Q?YC2NlNMmgBum7K56piy+DrKad0euAhy8Wf28MHNkt42v9n/yysMV7EJo1p?=
 =?iso-8859-1?Q?wUZwG055yoI80D3Q80yvXxfh98B/5ASfiyi8h6nohX+RFe2VYpYqc8bf3C?=
 =?iso-8859-1?Q?fberlmYZ2L/g8TaeruoFutHsZnBvLEowNf2S90tyaFHXSvRPVIyJ3WqP9S?=
 =?iso-8859-1?Q?jOSPaVYRMdKXqkqwZbHsgUmZlYd00r9Fc636JWqh68PdKPjEdvqacUhsM+?=
 =?iso-8859-1?Q?1BBjfx8ZPskrz9za8Ujwnp3TFKX2NA/Hii/8bVgpn2IP68oy43RepeiRrT?=
 =?iso-8859-1?Q?mKIHxPBlG0Y+g+jwd4BRs58q847jW4z30KbBU3f+JwqwX+Ymf5xgIvICum?=
 =?iso-8859-1?Q?GZme+J2nBHqnR0J6IuT2/+U7rQQ3VaZreLFcZ4+C3U1Y0IWA0sPSWTsCyK?=
 =?iso-8859-1?Q?x2MSzJWkmhbc9muFjHsohJpVjqA0TlTbe1v5UWjimEtTVXsx+3dZ43jv4I?=
 =?iso-8859-1?Q?rTBxE94Kb1ppz2UZLEBaNShOhYS13h4xBJw6otj+BnPeXBJEPAqlg6QVY2?=
 =?iso-8859-1?Q?MxdjCsxFQ8Wl91HNgB26r3t7SvvHpYDewWZuLEebrJVRhSLh2PqW2m+xMB?=
 =?iso-8859-1?Q?2ZNPDoBHEh2AeViGWS0shO0UVovOdurfOB8PHHt938dFyalBUfPxNnhjs/?=
 =?iso-8859-1?Q?RDwjWfmy1sIDoWcsxcFunkr92vOKi9e2GZ0KYZS0adqmjfmPYKhqgD7hFC?=
 =?iso-8859-1?Q?phQSZPzI/9suBMQ0UMnbmMIeYHctMIoJDtlX7nmilfeA/9vG5kSuVCcpSS?=
 =?iso-8859-1?Q?WH9fuk+bBJcLvD5MRRcaoKH4RcY2F/+Cu0QJ6BH/8kicrXjT+ALA1W7gIX?=
 =?iso-8859-1?Q?drE9nYwy3w1GF5sCFAgt9hCrHkd6H+15D5T+9AMAfj0tmz+ywnCsG+OSGx?=
 =?iso-8859-1?Q?muEAHnOlaiNG01n3G+ycKpa76pxSYhdkifcIy7UqDXOJB864m/YqLw1XC5?=
 =?iso-8859-1?Q?6qH6wz2lNz9+wJx0REgfjCul58GLC710rF+BsWUgJ49//t24nfaFT58CXZ?=
 =?iso-8859-1?Q?K7PQ4nbMaQx0oDnwVBsNk7+0njf1oRIfKCEtSeMVIPzkGEYk3sgYqLvLxi?=
 =?iso-8859-1?Q?NCft8QgwKD2Ecq7kWTm3YCz2URm9Dd0JHdfYu1hC+Uwbdfo3mKQfjITeJG?=
 =?iso-8859-1?Q?QVHSng06e9RXatjRnZYieTFE+gdC3EDqjlTCDPXO5lmTJDxAq48wyeNMn0?=
 =?iso-8859-1?Q?7q5gSefccoAQYoBvXFBOXo5k7wZGjUxb5CjrhlQ/m+ynIqoUN9GpEv3/Ha?=
 =?iso-8859-1?Q?ZLudFkscmorzVFAlPT+wDOz1kGRE50WQ58FxNlIhaD9A1OMxTFw6HjvqL/?=
 =?iso-8859-1?Q?ze6XIeYKkW1Jct99r0AymehJbOWywoou6yefmwfYO+yW3C8UpIOStYn8Nc?=
 =?iso-8859-1?Q?BvuTpCvqPuRpqjV4jwH/0HFrsSGpCVmI8q9+0qf98vRtlsaQs8qDbzCdiV?=
 =?iso-8859-1?Q?OdfPA63Q1I+SMGqH7E7GwClScHUsC81yPBS9DzNOZionumbnx52pi7hn5B?=
 =?iso-8859-1?Q?865MV6CietwPHuNgUDgttVncCYHDEieWpg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0496e94-aa66-44be-beae-08ddcd9524f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 05:11:01.0444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ROsmaaTTdLGt7nRl4G01ro7I1NGlbxU2Gcwxc/sdpLo2YKu/GvJLQZYHAlWx2QyQSjuq9b5UGCpL3uknBNhdfadxlXhc1IIiVdIIqom5UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6334
X-Proofpoint-GUID: vLMOLlHqkw69cxkZ7GvzfXwuaoImKSQO
X-Proofpoint-ORIG-GUID: vLMOLlHqkw69cxkZ7GvzfXwuaoImKSQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzNyBTYWx0ZWRfXxgBhAl9siznh
 AInXW23VHcc0kGLm+ng299fzuqd2g7HXlMaJPs7RzGZP4Cf8uKRUA7zvioRY3fs6gdJjhzkQIaN
 GrxbxE3VqLC4eRsvE9qzQOgO5QrsuFj2BgKmn4TrEpsL9YmfP5LmB4Sj0et/t+cXNnQBDmaDa8U
 oRk48JeD5VNGTPilC5vAsoFlKrALY1xAEx6Dhol4BSzxPoe2VhqsBXdM7Jed6IFNjCqwd0to9KT
 4v3KNgNKCAxsTnLzgOUG/M0IQcIEj5xl12ypesXjbi/GwKHGMmKq5FYJJJyc+d5kYb0BgCCM53E
 FMRipxf1yuqlrSp6fvMgcw9RYrlEqaoZXV09lTUZl8njfUJFWqnILeM4SYyuyIgcFK1Hbkz/Aa3
 gnC3CNBAG9/zsIalJ1RvTORfTWmOORol+FgvWj/1xUSbMsUjFTg8jjRxLUw8KSE5dBLVRzFr
X-Authority-Analysis: v=2.4 cv=Hvh2G1TS c=1 sm=1 tr=0 ts=68870668 cx=c_pps
 a=yjLXpF3nzAGyQzzFVx12ag==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=i0EeH86SAAAA:8 a=M5GUcnROAAAA:8
 a=wJu6GMKDqp8hiOnDIC8A:9 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
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

>Acked-by: Chengwen Feng <fengchengwen@huawei.com>=0A=
>=0A=
=0A=
Thomas,=0A=
=0A=
Now that Feng Chengwen is ok with this change, can this be merged=0A=
along with the ABI breaking changes in 25.11?=0A=
Given that techboard approves the change.=0A=
This change helps reduce ABI breakage when a new feature is added.=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
=0A=
>On 2025/7/25 14:04, Pavan Nikhilesh Bhagavatula wrote:=0A=
>>>> Deprecate rte_dma_conf structure to allow for a more flexible=0A=
>>>> configuration of DMA devices.=0A=
>>>> The new structure will have a flags field instead of multiple=0A=
>>>> boolean fields for each feature.=0A=
>>>>=0A=
>>>> Signed-off-by: Pavan Nikhilesh <mailto:pbhagavatula@marvell.com>=0A=
>>>> ---=0A=
>>>> +* dmadev: The ``rte_dma_conf`` structure is updated to include a new =
field=0A=
>>>> +  ``rte_dma_conf::flags`` that should be used to configure dmadev fea=
tures.=0A=
>>>> +  The existing field ``rte_dma_conf::enable_silent`` is removed and r=
eplaced=0A=
>>>> +  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent =
mode=0A=
>>>> +  the flag should be set in ``rte_dma_conf::flags`` during device con=
figuration.=0A=
>>>>=0A=
>>>> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>=0A=
>>>=0A=
>>> There is only 1 ack.=0A=
>>> Per our policy, it will miss the release 25.07.=0A=
>>>=0A=
>>> You can probably do this change anyway,=0A=
>>> and keep ABI compatibility by versioning the function.=0A=
>>=0A=
>> Hi Fengchengwen,=0A=
>>=0A=
>> Are you ok with this change? If so please ack it so that I can work on g=
etting=0A=
>> an exception from techboard to merge this without deprecation notice in =
25.11.=0A=
>>=0A=
>> Thanks,=0A=
>> Pavan.=0A=
>>=0A=
=0A=
=0A=
