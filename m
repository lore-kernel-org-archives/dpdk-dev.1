Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605AC71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 14:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53377402BC;
	Mon, 16 Jun 2025 16:29:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 86695402B5
 for <dev@dpdk.org>; Mon, 16 Jun 2025 16:29:29 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G973tB029163;
 Mon, 16 Jun 2025 14:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FQud2mv2E1doKSs+n277ufJ0
 C2+yL20otMMozTSJbjA=; b=jsEGAicqppoCTZgE6dQCwH1xk2+8pETep7TlzfoY
 7GrEQH5wNN8CPcWBeSoZUSMFNnVPqsg9TBqIVBO8Srs5a40XTADwt1Cs4pYJ1TSi
 3wixctYp+pdrBkFWt8eWhJsbg+V9EQ139LyHYSGCRtvKEZIUCx5cMmKq7JhSurBR
 l2o1DetYGdAYWZcdItjI3JdjgAiFNupLxdQaACkAdPup6RfzIGr6YzqClkjUTFeS
 HdHP4bJ6j4W+RoeEdqk4u4z9UbBguEDPbtcOP0zHYyEn3ZTyiE4r1IOu/6ix9i0x
 saTkolkNjdmKO0r2rKSB8q+nDTjmV6MEymZHbu22LOXvNw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mcsvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:29:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV84+A9QksGtVxwTraqz16yZK0VZaJ3ls4tWAXItscIyQH0SZ2EIOmjxL/YTZAHS+xv45PEMTyPAAcVi7Vc8FUA/ZT+t+3p6lwW/HO5OKZyc1y3Lz2BiXTYIj3ROFpklc73/4DFCgX/Y1UskYKU/ICm3lFFwQs/CbJsXpB+XOXZQKgGnC0dtuZhgUrL+AlfKiwuRAy44PHaAej3d4YfPPS2ahOFZh1lQpeg8k+gwv8PEnl4ujoN3L/2Fu90FzMsRJpUhewgw4qv9sFsG+V/ZGWkVQt5t4Kb9KGLjKr2YiAazGuefOVcI2hMSc4AfHVmgB/+BzxLou7WyL1K0xhVVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQud2mv2E1doKSs+n277ufJ0C2+yL20otMMozTSJbjA=;
 b=dLnW1BFRhd2qf40u+ikikwYH0ve7eBmZ4r/dMDfmP5+LrnT3HaVIT/MRljfYR6KBlvlzVgenADkZugwlQ8akg6rDhqwJ8zI0aFJQEs9G0wSO387Z80FA8BNKm/+mtkmcOFxXVnSk+hLi7AwR+C6W7mAEnEl3I8kxtxE+vc7fjW2+KcjNuuHrLEal23cMXC2MAEeRonTH+lpgadkdFl7reoZxauzZm+h4NAIy4+x5k9TpVqKzu4mINq9iH9/J+rcSwmxQRpnlYhxPOM/10IS8MGgVtu1Y6rcOs1aXTNfSHCoVhueJ++CFxcDQQxn6UB6KmGZ8w4g1oqimvLd5h8BMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8171.namprd02.prod.outlook.com (2603:10b6:8:1c::6) by
 BN0PR02MB8189.namprd02.prod.outlook.com (2603:10b6:408:150::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:29:17 +0000
Received: from DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830]) by DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830%2]) with mapi id 15.20.8769.025; Mon, 16 Jun 2025
 14:29:17 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHb1y1EXfgSn9oKJ0KB1C7sKMwlUbQF53E4
Date: Mon, 16 Jun 2025 14:29:17 +0000
Message-ID: <DM8PR02MB8171B66D67908BBC34433C9FE970A@DM8PR02MB8171.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8171:EE_|BN0PR02MB8189:EE_
x-ms-office365-filtering-correlation-id: fb65260b-eac8-4d0c-c904-08ddace22cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PSuV1TFgc8ZhYo9C/y1aCi9VXjYTdRaIe+ij7x7EbI4MKZCcSGQLuPQr+BS+?=
 =?us-ascii?Q?qkNht6gJqaL/zxhe01z+rJTR2Ak3IUITG4dFtOLqqy7Hg5+PKK1EfjA99uHM?=
 =?us-ascii?Q?gsqLDT/6M42od0AmTfz46e9AOpakSIRBYJXShJdw5VEl8Ya03sczt3qKLNsc?=
 =?us-ascii?Q?d0hnbNKdEjH0m8VM7i1NpmnpXxi7IbI8vwFfVD5agjxaGp7whelUzYPwQhvb?=
 =?us-ascii?Q?ALlRj/HXl8YMV31J6wEAHp42awO2mw+gVkSZnYeBwk96SZrpwKEVknwI/URa?=
 =?us-ascii?Q?f/k1WBXzqLYPJdG++oncKj7WrKTGCpmYek85Ufsu463Yf8/+NRS+8U0sYx1+?=
 =?us-ascii?Q?3Kz7e+BrAvlm0RK77kpC387ynkNQlaQwN1tiAuo4la7IZSS6ehNk+150NKvS?=
 =?us-ascii?Q?mLwXQyGAPRVqjNS0SEPAIZ8ZAKYPEpKO/y7eIDbILBOpZeGNRi7TlF73zMNk?=
 =?us-ascii?Q?DIGxiBoLUkvxKEkR6k4h0cbqT4XMj0iSGX0lETv+LuH1rTvl4ehpaXAyJpm4?=
 =?us-ascii?Q?44CvosSPKmsHkplJLLp1UM5QxwtBOXtoRh3DaoVu9BLrsSmkgCdFr4BlxHaU?=
 =?us-ascii?Q?GFLBsGdxSoKYYk/pyR7rc4LDMFd/w774a1pVK9CGaf82TH5qFeyyPP2Z3Cm+?=
 =?us-ascii?Q?hAQofV9o5hDVPugvWELy5g7EOaxJuIgyc9GBHA1L0jDOalDqHrbGEcQnndAl?=
 =?us-ascii?Q?9oK/LIHMdj/4qDtSZP8j+SgmEGpstCEl68WgQBDpzWB26Iu6t8aQmIaeQwZg?=
 =?us-ascii?Q?/YJr+M11DX8PF+9FcJJvFGC3NC4ZctRQq1BfREpiF4ciZ4aecYhNxgPLnmpn?=
 =?us-ascii?Q?4TAk3r1xnb33AyQAvzFGPIZlWRhwARdhXbsLeTXdmv3+hXTRwj0GPeu7RL2N?=
 =?us-ascii?Q?fhuZJarRssNX63DdzEvyl7ik+DwW0hkN2fU/Adh41K5CjCc9ZK2uSUa6yQMM?=
 =?us-ascii?Q?HcAw29celA6O8/skEE0hWrK/mDkH62CUCDeH4RgoZPSe3Kb8Zj+ih6oiWQYr?=
 =?us-ascii?Q?FEB2DyxKkP12slS1kSibIN38m+RtfFkBZaxaYi4Enn1BAL0spiJ1F3ig+563?=
 =?us-ascii?Q?0izJHJlKvMWy2mo2+7quRvHqKpNE8XhehkKjmdpiJsIFYoekj3/qyg4GUlo+?=
 =?us-ascii?Q?dgwkyxFS5xo+Ngyh8k+kZEppE6yTieqP/khElMgX31YY7oGrX6gWAaVpS4Hc?=
 =?us-ascii?Q?chtJrKCMJITpliEQ8JHFKQxqR9WlYUUwHIZ8rN+4KEmGN46b0orvyQ438RzH?=
 =?us-ascii?Q?seIID+lvgWiBKJjALPUdFhgJ/gt4pJmuaAX6wJ3oFfNDw8zG2YGTXmn1jXYB?=
 =?us-ascii?Q?LOlCRH2E20uw+U9Gh/rieRfH6OOK7o8bonxpg4ygPwEjF0DwP+Oul4cpYaOi?=
 =?us-ascii?Q?ek+sSrXh/WCZTRNILDHu+pOQLZT8ZTZWU2J5nIT7WLduILvbFqluQvZz4Ejw?=
 =?us-ascii?Q?cW4J8Dc374TOEFfuZK8f9DDfrq+CCwLJ0x1nZYOvHlb7bquhvNQyeg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8171.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?10CqDpwPshnkHiQxdV/TwgPC7PIPBL/ZvF0BmOBWpZQ/g94ARovxHeyKd8u2?=
 =?us-ascii?Q?AllLN4D/Lj3cH/GCh0ZYvZcovIu7lDH2KEDuqKrdVHoLCkbZhevOzhSWZEiL?=
 =?us-ascii?Q?WNB/yHE6bwpAAQYhdL+IPNT7yBJgqvCeLu1e09TqMaIDUl+HnyAbo+YF6hBz?=
 =?us-ascii?Q?jvmACY/NTsTP0dhHE3nJclPSiuQKCcEjWMP3+rqekJAe6Dbco3cQ0FZQ9sMx?=
 =?us-ascii?Q?jYsMBb9hlfZ5sQv1jTcvTTVnHM08dq6QlEO09KqAfFI/KhVlgYOkj8B5V944?=
 =?us-ascii?Q?Z8jGuG1Cx7H7dezb2NEGB7jsTX5UflFlVWrbwHgUmIBrtD0Lhnt5DMjc1z8G?=
 =?us-ascii?Q?3+J8Z4Raas93s7I14lIkD2ZaJ8IUMysIdDz4nHQdwF7AUyI0wi4JlQJxqzt8?=
 =?us-ascii?Q?Zv9kpYrxL7tPMgQZ4Z8SFLqHQOIBemxJsAlzdQ7Y/l785AlCa/fTadRyI6Zk?=
 =?us-ascii?Q?COAHn/rc/u9IDwD3KKNmb/68O5i5y5jJMgR/8PWFZeSHPz85L29sS0EMMldH?=
 =?us-ascii?Q?Cd5e8yQF3jIySrwgE6K66NnPlvd7FbF1xAOwrNPFCHa0YJUqYRumzqCucIp5?=
 =?us-ascii?Q?9YYSNdUJcSQl3J/B5cOf4m5aJkFdr0tPjTYIF6yRgkiHTaRS85wrLlxYg3Pf?=
 =?us-ascii?Q?J3pl9c7HOa3dznv+Gp33cZ9tUyfbvmtu8TqxAVYsL1iJlhbJJYU7FMEsZELc?=
 =?us-ascii?Q?8S3ycDNKdFBozZR4wgUfJGtoFJdKol+XaDbLfdHK10DIj1uQtA+Iu+qVU0fP?=
 =?us-ascii?Q?AFg4s0g5uu74KwyL6JgvTkaMud4g1ET1ei4pYkSsRAwcBXIRHVYvjClIa/ZF?=
 =?us-ascii?Q?yTssKJMcPnkTSAgEMZS4YZ4+vKKgLWcOLDsiApYl606rvPKfHN8Na3cy4SSz?=
 =?us-ascii?Q?Cp7w0Leoj9KRjFCH+pEuLQlhOdfvqEcvvlHihjCnP+SyPtnJF+/OCRs+Fejk?=
 =?us-ascii?Q?Rnbwn+kGp0edoMYHcZselsknEsTvYJhp3F3KoI5QqA//WCupSV1Xlp+0Ipzw?=
 =?us-ascii?Q?9D3cx6PSQBOLrnjugTWmDAdLPEmMZJNEd/qFvywwkuBITzKdpY0N1CGsGVTI?=
 =?us-ascii?Q?IB0kmSRZ0K33ekU44WPG6WFbExTA87VAS3K0ACGfJxY6zNO7KVWQYChSg6I3?=
 =?us-ascii?Q?2/C3RsEVQXxRqNZPelK18RiA1pR5lEqD2ZIiNzATpfW8N+ypng1n3MsLAwQY?=
 =?us-ascii?Q?cyRZ7M1T0JKp8oynhJB0lrC2zxm77mFmAhmXLlnuPQof4mE6WW2WIHleEMAx?=
 =?us-ascii?Q?28GQHNBXBXazbCdbHi8dcj0dFEa58hFB8TphW8w7oEq6GxEtPPfD6yDrySqW?=
 =?us-ascii?Q?X9JIcQBs7c9jtQMZcscUM1fClj4vfKbYY75+9XNj9yLxEkHBNV2Q38lLGb1A?=
 =?us-ascii?Q?5MCApDkFO2Qy3XOf9dsNW/tUXyz2TeMBdTEROrQdRytQbFvjz6sNv35PVWmT?=
 =?us-ascii?Q?tzsTL+SHJ94ENX/WtdcmDj4tZse1/sGryul0HFnQt7G3Bja8d91ntFA7wUye?=
 =?us-ascii?Q?30vdDy1CiQJ3YWcoKLKv5GVj0S45b1kkeQYH7TUhBeellrOXu9gilvwuq/QX?=
 =?us-ascii?Q?dbQEJdS1oWHXeeb8U1QruNhBHQroIRkqIIRj/E+i?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8171B66D67908BBC34433C9FE970ADM8PR02MB8171namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UY7BVHpENoualrSS0DSTlc8jIU8D0qpUESSVLLENpd5y4oAiL381OfZNdx0tvMkPL6biwfxgVm/SY3CScd8nSSPbGISCxqzSnk6FDV1b5BlSHWPfqAS28BJ4r+b67fkg3cra5180REhJkvs9LvbqRwUXlmfx8lulzcQ5n/v9jWKvwrHf3oo+TNJTyUtuMJX+4xAhiDy5XLvEYtcThl+VYVwx49ZxlYxDTfUpJcEcGEL7KCcksinb4mEUmayPSwHdUVwcx/sx04zwCOKzy+MjCh0zjLRmfEy80E1LdEkE4A8cdjfj9W1/4MjMxAyPfH8fZwpwqbh93dg20TVTbZX6LFHcebbnHoUZViXJxTLgsrOuJBO+rKF2sSYBSJbSSu/Ez2sdYLYbsTB1qy5j7AxgaipxaFEhJqMiAYM06SdYMR6fmRiR/6UzrLHwPNvHRsCCx5dxv90AtbZEgNbg6Cg1Mc+V1qnlVS7uDZN0LS67KEmOX2wl46HuEbvJSmH795MqWsfKupxBPtLu7uFHVIPxeEOjTHWdTQ+D+HBRf+9eQgCKzYYz7hmpdPDJZe1rVHFZe5955aG7U+OrlMZl4zWTZkZUHscNXTxrpZHkMG4jfUnpV05OdDdsRx7qr12WR6Fi
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8171.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb65260b-eac8-4d0c-c904-08ddace22cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 14:29:17.0770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yd7aQfhsd6946+58C/PQBYflLx6b1RogNJqZDll8UeNEFYvnFbBPX7nT4mDErBa60cZ/A1+CYTOcL6XN7oioQe7ELHBKQZ1oil0l5gQWPGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA5MSBTYWx0ZWRfX2g/DQbogdhGa
 nQOajr4hrOBj1Cjh3wXESMd0NKLn+J9J6axH/TiWsZDL2pcW1HLJRCaABFaft6a7OhFRxYTP91D
 Roi/4/zUljLZJ0GXQGYPSisVXvhcFEDT0Xr66RbT15/+SD5L0X5sNXzjgXEpq0gULJfIm/qXWir
 KaEBLjMaVcwwCgOkRHyMFxETbK/uAJ/JOBsfFKjTLOvMzKVprqQmOUeldP/cZSR5KHSPy3UXGmI
 haZKuil1/c82TaQVSiDjgyaPTDbuu7ZBLzwelM5i18lS3yHmkOvB4sj2QVBhMdEhgcaif5s2Hnh
 LsX6uX/57Maqel5ZgyTMvDODCaPnPolyojhtWaVoyd+1xzAp3sAmndq4u0OlvwRv4JO0ARWTeeF
 mcGBYyVlAjMfBF/OulqHvuKxKX1RIi/om/N3y65F33gWL+VspL1GeatI6Z1q3owCtlqFy3eE
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=68502a41 cx=c_pps
 a=PK5aExQQjalka8oDlC/sVA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8
 a=VYDjIKVHAAAA:8 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=brwphhl1UAouKY6hFgUA:9
 a=CjuIK1q_8ugA:10 a=pjuITvj8c92dK65PHhoA:9 a=hci29UNDxxSkYSOJ:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-GUID: 0uoAsE6I336TZGQ9LI6gY5zi6ukynp5k
X-Proofpoint-ORIG-GUID: 0uoAsE6I336TZGQ9LI6gY5zi6ukynp5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160091
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

--_000_DM8PR02MB8171B66D67908BBC34433C9FE970ADM8PR02MB8171namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Stephen and Thomas,
I uploaded this patch which says it has UT failures, but upon closer inspec=
tion, there aren't any signs of any tests failing. Can you please take a lo=
ok?
________________________________
From: Schneide <schneide@qti.qualcomm.com>
Sent: Friday, June 6, 2025 3:52 PM
To: dev@dpdk.org <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.net>; Res=
hma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplu=
mber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@mar=
vell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhir=
un_163@163.com>
Cc: Dylan Schneider <schneide@qti.qualcomm.com>
Subject: [PATCH v2] pcapng: allow any protocol link type for the interface =
block

From: Dylan Schneider <schneide@qti.qualcomm.com>

Allow the user to specify protocol link type when creating pcapng files.
This change is needed to specify the protocol type in the pcapng file,
DLT_EN10MB specifies ethernet packets only. This will allow dissectors
for other protocols to be used on files generated by pcapng.

Includes a breaking change to rte_pcapng_add_interface to add link_type
parameter. Existing calls to the function have been updated to pass
DLT_EN10MB for the link type argument.

Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: stephen@networkplumber.org
---
 .mailmap                               |  1 +
 app/dumpcap/main.c                     |  4 ++--
 app/test/test_pcapng.c                 |  8 ++++----
 doc/guides/rel_notes/release_25_07.rst |  5 ++++-
 lib/graph/graph_pcap.c                 |  4 +++-
 lib/pcapng/meson.build                 |  2 ++
 lib/pcapng/rte_pcapng.c                | 21 +++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  4 +++-
 8 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..a585124832 100644
--- a/.mailmap
+++ b/.mailmap
@@ -390,6 +390,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
 Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
 Duncan Bellamy <dunk@denkimushi.com>
 Dustin Lundquist <dustin@null-ptr.net>
+Dylan Schneider <schneide@qti.qualcomm.com>
 Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
 Ed Czeck <ed.czeck@atomicrules.com>
 Eduard Serra <eserra@vmware.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..e0e2b26269 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
                 free(os);

                 TAILQ_FOREACH(intf, &interfaces, next) {
-                       if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, intf->ifname,
-                                                    intf->ifdescr, intf->o=
pts.filter) < 0)
+                       if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, DLT_EN10MB,
+                               intf->ifname, intf->ifdescr, intf->opts.fil=
ter) < 0)
                                 rte_exit(EXIT_FAILURE, "rte_pcapng_add_int=
erface %u failed\n",
                                         intf->port);
                 }
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 8f2cff36c3..bcf99724fa 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -345,7 +345,7 @@ test_add_interface(void)
         }

         /* Add interface to the file */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, NULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u\n", port_id);
@@ -353,7 +353,7 @@ test_add_interface(void)
         }

         /* Add interface with ifname and ifdescr */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        "myeth", "Some long description", N=
ULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u with ifname\n", port_=
id);
@@ -361,7 +361,7 @@ test_add_interface(void)
         }

         /* Add interface with filter */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, "tcp port 8080");
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u with filter\n", port_=
id);
@@ -406,7 +406,7 @@ test_write_packets(void)
         }

         /* Add interface to the file */
-       ret =3D rte_pcapng_add_interface(pcapng, port_id,
+       ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
                                        NULL, NULL, NULL);
         if (ret < 0) {
                 fprintf(stderr, "can not add port %u\n", port_id);
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst
index 6b070801de..2396c7b014 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -108,7 +108,10 @@ API Changes
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-
+* pcapng: Changed the API for adding interfaces to include a link type arg=
ument.
+  The link type was previously hardcoded to the ethernet link type in the =
API.
+  This argument is added to ``rte_pcapng_add_interface``.
+  These functions are versioned to retain binary compatibility until the n=
ext LTS release.

 ABI Changes
 -----------
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 89525f1220..13d86b7a18 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -11,6 +11,8 @@
 #include <rte_mbuf.h>
 #include <rte_pcapng.h>

+#include <pcap/pcap.h>
+
 #include "rte_graph_worker.h"

 #include "graph_pcap_private.h"
@@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)

         /* Add the configured interfaces as possible capture ports */
         RTE_ETH_FOREACH_DEV(portid) {
-               ret =3D rte_pcapng_add_interface(pcapng_fd, portid,
+               ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN1=
0MB,
                                                NULL, NULL, NULL);
                 if (ret < 0) {
                         graph_err("Graph rte_pcapng_add_interface port %u =
failed: %d",
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
index 4549925d41..3aa7ba5155 100644
--- a/lib/pcapng/meson.build
+++ b/lib/pcapng/meson.build
@@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')
 headers =3D files('rte_pcapng.h')

 deps +=3D ['ethdev']
+
+use_function_versioning =3D true
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index cacbefdc50..f18af25983 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
 }

 /* Write an interface block for a DPDK port */
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
-int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
-                        const char *ifname, const char *ifdescr,
-                        const char *filter)
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
+                       (rte_pcapng_t *self, uint16_t port, uint16_t link_t=
ype,
+                       const char *ifname, const char *ifdescr,
+                       const char *filter))
 {
         struct pcapng_interface_block *hdr;
         struct rte_eth_dev_info dev_info;
@@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t p=
ort,
         hdr =3D (struct pcapng_interface_block *)buf;
         *hdr =3D (struct pcapng_interface_block) {
                 .block_type =3D PCAPNG_INTERFACE_BLOCK,
-               .link_type =3D 1,         /* DLT_EN10MB - Ethernet */
+               .link_type =3D link_type,
                 .block_length =3D len,
         };

@@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t =
port,
         return write(self->outfd, buf, len);
 }

+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
+                                 (rte_pcapng_t *self, uint16_t port,
+                                  const char *ifname, const char *ifdescr,
+                                  const char *filter))
+{
+       /* Call the new version with a default link_type (Ethernet) */
+       return rte_pcapng_add_interface(self, port, DLT_EN10MB,
+                                                                       ifn=
ame, ifdescr, filter);
+}
+
 /*
  * Write an Interface statistics block at the end of capture.
  */
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b57564..9880d415c4 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
+ * @param link_type
+ *   The link type (e.g., DLT_EN10MB).
  * @param ifname (optional)
  *  Interface name to record in the file.
  *  If not specified, name will be constructed from port
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
  * must be added.
  */
 int
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,
                          const char *ifname, const char *ifdescr,
                          const char *filter);

--
2.27.0


--_000_DM8PR02MB8171B66D67908BBC34433C9FE970ADM8PR02MB8171namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Stephen and Thomas,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I uploaded this patch which says it has UT failures, but upon closer inspec=
tion, there aren't any signs of any tests failing. Can you please take a lo=
ok?&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Schneide &lt;schneide=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, June 6, 2025 3:52 PM<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Thomas Monjalon &lt;thomas@mo=
njalon.net&gt;; Reshma Pattan &lt;reshma.pattan@intel.com&gt;; Stephen Hemm=
inger &lt;stephen@networkplumber.org&gt;; Jerin Jacob &lt;jerinj@marvell.co=
m&gt;; Kiran Kumar K &lt;kirankumark@marvell.com&gt;; Nithin Dabilpuram
 &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;yanzhirun_163@163.com&gt;<=
br>
<b>Cc:</b> Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Subject:</b> [PATCH v2] pcapng: allow any protocol link type for the int=
erface block</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Dylan Schneider &lt;schneide@qti.qualcomm.co=
m&gt;<br>
<br>
Allow the user to specify protocol link type when creating pcapng files.<br=
>
This change is needed to specify the protocol type in the pcapng file,<br>
DLT_EN10MB specifies ethernet packets only. This will allow dissectors<br>
for other protocols to be used on files generated by pcapng.<br>
<br>
Includes a breaking change to rte_pcapng_add_interface to add link_type<br>
parameter. Existing calls to the function have been updated to pass<br>
DLT_EN10MB for the link type argument.<br>
<br>
Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface information&quot;)=
<br>
Signed-off-by: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
Cc: stephen@networkplumber.org<br>
---<br>
&nbsp;.mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;app/dumpcap/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 ++--<br>
&nbsp;app/test/test_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++----<br>
&nbsp;doc/guides/rel_notes/release_25_07.rst |&nbsp; 5 ++++-<br>
&nbsp;lib/graph/graph_pcap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;lib/pcapng/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&nbsp;lib/pcapng/rte_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 21 +++++++++++++++------<br>
&nbsp;lib/pcapng/rte_pcapng.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&nbsp;8 files changed, 34 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 91e08f4a1f..a585124832 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -390,6 +390,7 @@ Dukai Yuan &lt;dukaix.yuan@intel.com&gt;<br>
&nbsp;Dumitru Ceara &lt;dceara@redhat.com&gt; &lt;dumitru.ceara@gmail.com&g=
t;<br>
&nbsp;Duncan Bellamy &lt;dunk@denkimushi.com&gt;<br>
&nbsp;Dustin Lundquist &lt;dustin@null-ptr.net&gt;<br>
+Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&nbsp;Dzmitry Sautsa &lt;dzmitryx.sautsa@intel.com&gt;<br>
&nbsp;Ed Czeck &lt;ed.czeck@atomicrules.com&gt;<br>
&nbsp;Eduard Serra &lt;eserra@vmware.com&gt;<br>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c<br>
index 3d3c0dbc66..e0e2b26269 100644<br>
--- a/app/dumpcap/main.c<br>
+++ b/app/dumpcap/main.c<br>
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free(os);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TAILQ_FOREACH(intf, &amp;interfaces, next) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_a=
dd_interface(ret.pcapng, intf-&gt;port, intf-&gt;ifname,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; intf-&gt;ifdescr, intf-&gt;opts.filter) &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_a=
dd_interface(ret.pcapng, intf-&gt;port, DLT_EN10MB,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intf-&gt;ifname, intf-&gt;ifdescr, intf-&gt=
;opts.filter) &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_exit(EXIT_FAILURE, &quot;rte=
_pcapng_add_interface %u failed\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; intf-&gt;port);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c<br>
index 8f2cff36c3..bcf99724fa 100644<br>
--- a/app/test/test_pcapng.c<br>
+++ b/app/test/test_pcapng.c<br>
@@ -345,7 +345,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the fi=
le */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, po=
rt_id);<br>
@@ -353,7 +353,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with ifna=
me and ifdescr */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;myeth&quot;, &quot;Some long description&quot;, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with ifname=
\n&quot;, port_id);<br>
@@ -361,7 +361,7 @@ test_add_interface(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with filt=
er */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, &quot;tcp port 8080&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with filter=
\n&quot;, port_id);<br>
@@ -406,7 +406,7 @@ test_write_packets(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the fi=
le */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcap=
ng, port_id, DLT_EN10MB,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; NULL, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, po=
rt_id);<br>
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst<br>
index 6b070801de..2396c7b014 100644<br>
--- a/doc/guides/rel_notes/release_25_07.rst<br>
+++ b/doc/guides/rel_notes/release_25_07.rst<br>
@@ -108,7 +108,10 @@ API Changes<br>
&nbsp;&nbsp;&nbsp; This section is a comment. Do not overwrite or remove it=
.<br>
&nbsp;&nbsp;&nbsp; Also, make sure to start the actual text at the margin.<=
br>
&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
+* pcapng: Changed the API for adding interfaces to include a link type arg=
ument.<br>
+&nbsp; The link type was previously hardcoded to the ethernet link type in=
 the API.<br>
+&nbsp; This argument is added to ``rte_pcapng_add_interface``.<br>
+&nbsp; These functions are versioned to retain binary compatibility until =
the next LTS release.<br>
&nbsp;<br>
&nbsp;ABI Changes<br>
&nbsp;-----------<br>
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c<br>
index 89525f1220..13d86b7a18 100644<br>
--- a/lib/graph/graph_pcap.c<br>
+++ b/lib/graph/graph_pcap.c<br>
@@ -11,6 +11,8 @@<br>
&nbsp;#include &lt;rte_mbuf.h&gt;<br>
&nbsp;#include &lt;rte_pcapng.h&gt;<br>
&nbsp;<br>
+#include &lt;pcap/pcap.h&gt;<br>
+<br>
&nbsp;#include &quot;rte_graph_worker.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;graph_pcap_private.h&quot;<br>
@@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add the configured inte=
rfaces as possible capture ports */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_FOREACH_DEV(portid=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; graph=
_err(&quot;Graph rte_pcapng_add_interface port %u failed: %d&quot;,<br>
diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build<br>
index 4549925d41..3aa7ba5155 100644<br>
--- a/lib/pcapng/meson.build<br>
+++ b/lib/pcapng/meson.build<br>
@@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')<br>
&nbsp;headers =3D files('rte_pcapng.h')<br>
&nbsp;<br>
&nbsp;deps +=3D ['ethdev']<br>
+<br>
+use_function_versioning =3D true<br>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c<br>
index cacbefdc50..f18af25983 100644<br>
--- a/lib/pcapng/rte_pcapng.c<br>
+++ b/lib/pcapng/rte_pcapng.c<br>
@@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Write an interface block for a DPDK port */<br>
-RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)<br>
-int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char=
 *ifname, const char *ifdescr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char=
 *filter)<br>
+RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *s=
elf, uint16_t port, uint16_t link_type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifna=
me, const char *ifdescr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filt=
er))<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pcapng_interface_bl=
ock *hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_info de=
v_info;<br>
@@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t p=
ort,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (struct pcapng_int=
erface_block *)buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hdr =3D (struct pcapng_in=
terface_block) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .block_type =3D PCAPNG_INTERFACE_BLOCK,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .link_type =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* DLT_EN10MB - Ethernet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .link_type =3D link_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .block_length =3D len,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
@@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t =
port,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return write(self-&gt;outf=
d, buf, len);<br>
&nbsp;}<br>
&nbsp;<br>
+RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *self, uint16_t p=
ort,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifname, const=
 char *ifdescr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filter))<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Call the new version with a defaul=
t link_type (Ethernet) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rte_pcapng_add_interface(self,=
 port, DLT_EN10MB,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifname, ifdescr, filter);<br=
>
+}<br>
+<br>
&nbsp;/*<br>
&nbsp; * Write an Interface statistics block at the end of capture.<br>
&nbsp; */<br>
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h<br>
index 48f2b57564..9880d415c4 100644<br>
--- a/lib/pcapng/rte_pcapng.h<br>
+++ b/lib/pcapng/rte_pcapng.h<br>
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&nbsp; *&nbsp; The handle to the packet capture file<br>
&nbsp; * @param port<br>
&nbsp; *&nbsp; The Ethernet port to report stats on.<br>
+ * @param link_type<br>
+ *&nbsp;&nbsp; The link type (e.g., DLT_EN10MB).<br>
&nbsp; * @param ifname (optional)<br>
&nbsp; *&nbsp; Interface name to record in the file.<br>
&nbsp; *&nbsp; If not specified, name will be constructed from port<br>
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&nbsp; * must be added.<br>
&nbsp; */<br>
&nbsp;int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 const char *ifname, const char *ifdescr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 const char *filter);<br>
&nbsp;<br>
-- <br>
2.27.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR02MB8171B66D67908BBC34433C9FE970ADM8PR02MB8171namp_--
