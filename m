Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B70CAC587
	for <dpdk-dev@archiver.kernel.org>; Sun, 14 Sep 2025 15:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA0F04013F;
	Sun, 14 Sep 2025 17:34:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8705D4003C
 for <dev@dpdk.org>; Sun, 14 Sep 2025 17:34:35 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EEj9H7010745;
 Sun, 14 Sep 2025 08:34:34 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2111.outbound.protection.outlook.com [40.107.237.111])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49584k9fx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Sep 2025 08:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA75T0FwUrCUVEy2N7kzI50f8+sdV2Mk6OQIR/4gdQy8ojhhAPqVKRj5s329Bntos/z0Fnl1RoxEY317KWVBQ6ydqRJCeJtPlO9e4hkjDBVk/C1sM7NtfzKXzOzact4ORNRP2cRDxGCMRpfROTFtcgkgQMdAAR7AxgXBHXYZxV4LoAjEp89UhuKJBgsL09zq+DNmlUIdMegJWRBbF+AoHLpuMPRL4YQmdPJJIYFIs7xkIjcCIy8QvpvQRsQJU88Y0vYgoFEe3m2zNvtZg9KhwNOehOtRppthvI579s/GcGuCGMWw/6iJ5G6zWWWeb6NEMGcAz8F4qntY+xUX2eJYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLqWx+tfl8qwCRhQKfIEAnlE5JJDoDQM7ZWCVkTYSP0=;
 b=f6uXCiPHG2yLs2MUt1CCo4aD9dRXIknVR+m6M4MKNglZ8kudCsu7/wZu2FkMu7aUS0QQuUpfWggYWMCG70XagPFBlAVDZdrVK/6CPD/h9c/E3Epwhx9/euXPman7bE8XuHJg8h1Gvu4jE5Urw1flkCZOtHbTaOIc73zQ59zLJV6I8sNE5KB4ZCf1AZrpq+B/tNLunjkQApN8BNoKKzVasqjaa2V4Bv+5+u87w3M2cQwZ+nbjCrv5yW1OS+p81yaW0twxniC/jAuakJ+uD7ZleOgyENCz0vEiqXw8eu3MvfV0lr2bf5YFMKXYkpDX+0kSxqH89vQfAttCPHcLej6Hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLqWx+tfl8qwCRhQKfIEAnlE5JJDoDQM7ZWCVkTYSP0=;
 b=Z3UHIXUTCSG3TPm4Tsfkt+Xuo3m6HPamiSIjBE6XjQU7cyTQwp/oC6o3a4vhwKs7UH+QCiRUJcCNiO9GUSMg7XNg1u+M+BRPG3fF3HU2A9OG2Nwzq9ok4YBqjA/jN/ZrQzNQv47fPk/SC5duQIYNQ2t3Hu0kqHPIsu2hrWKtpB0=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CH4PR18MB6212.namprd18.prod.outlook.com (2603:10b6:610:233::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 15:34:31 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9115.018; Sun, 14 Sep 2025
 15:34:30 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, fengchengwen
 <fengchengwen@huawei.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Topic: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Index: AQHcJY0Ql0OU8ZwQvUa55jGKlVvicQ==
Date: Sun, 14 Sep 2025 15:34:30 +0000
Message-ID: <PH0PR18MB4086AB67CD19C038A19472EBDE0AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CH4PR18MB6212:EE_
x-ms-office365-filtering-correlation-id: bea4a9ba-3317-4757-2f9a-08ddf3a432c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fZSAkLrU6lRZyg8iqjPVi/f0rh2XnROpkiScyyUgiCqncil1pKrXj4vxHE?=
 =?iso-8859-1?Q?x1AgRA3fOl5otuz3pJx6ud0H2ruGoV4XiUb2Dzv2hBOevSuBidATJvhjfx?=
 =?iso-8859-1?Q?7FQvhAzWdEo7OOtLcCR9dtRr+EpdF79VP0oXUelgEFGwiwoIcT9nAFuVBW?=
 =?iso-8859-1?Q?SUKuH0EcpkU00VqlPnfbknGCydKJQGUynbEydGACrsVIgr3HG8VBMPPWRr?=
 =?iso-8859-1?Q?SNLyHyf8JJaGBYFQdx9pFoFGN+3mZvbHiuUAliM7E9bEpnu7gM04CaJNbW?=
 =?iso-8859-1?Q?4ZDjmCnlkW+aILSiSyeoWtTvLjj7PE4dR5BAZZg68DnW4fZzW87ht/ycmJ?=
 =?iso-8859-1?Q?gS+I8iaiI5kshe/PC47roZ5uouBr7X0SAGZxaBYW75UiQzzIQrB4rM5X2O?=
 =?iso-8859-1?Q?CCidOYjwHjlNHUyrbtsj1A7/ciHKo/53eAPxncTie565F9D4rfT0eb/LyZ?=
 =?iso-8859-1?Q?bywP/9DBSewsNkjFp8PJOQ54QIEO/h7KnjHQXvcy6XT6nkJcxICr9RNlAv?=
 =?iso-8859-1?Q?BMf5GXuEQrSMmNbidZAQ7ZLTRoCeidvnsMAXPaj4xVhLVrj6NXNv/V95oY?=
 =?iso-8859-1?Q?x2idNBUKWJ/VJR+oO3AGlxsmkjBhUDN0p2vdFVBCa9HAwiZ3U2HBwZHthU?=
 =?iso-8859-1?Q?2S3QEU/+wVe1YsogLUz3KyKKkIr+asWlSHSlxBljLtfO3R2D6TAfkwAhno?=
 =?iso-8859-1?Q?y7qrROSXMwp/hTgCJQrqdP3Bq7SLpbFu/4VFmwv63FIX5crrm2AgRdGKaT?=
 =?iso-8859-1?Q?joFg7dtd+0al8OhH81N0tn/aFOMlnpemDbq5Kl4/NP1in9DDFSr8xZWWrE?=
 =?iso-8859-1?Q?X4Epeu45ITn1XGI9zFMI7LWaA1wHgIugZ2dnEcS4Qsm61REjKUNusr4ngC?=
 =?iso-8859-1?Q?DfDX5iMYqA3UeF+cdwDhaPYuoJqfhDHupkc9aE81ZB8t7KJ2h+MUDt7iYa?=
 =?iso-8859-1?Q?AwvME2vBeaErdbS+fv0e6ggJTVPsOF7q9mKtPw3UZZoA/waauSsmo5BFdo?=
 =?iso-8859-1?Q?r21oO1EVRYy+s4YhodfilMQFtCWwcOVznF7M4Kb15tVqLwpbEkDQE4izZj?=
 =?iso-8859-1?Q?Q09Jc/gLAGJPjSZScjvZNyZ5EXue75zg7T27MJIefCLbvq3nL+yB7s+tn+?=
 =?iso-8859-1?Q?ra7Ok9hOGGk9GK9ZpeT31p/e5g9T7szs30KRmAU9r/K2j4Z+pZLbOZ/lV+?=
 =?iso-8859-1?Q?m0f+3A6YRuhQZIwRa5Y2mzgHwtk8xqL/nPY5g2oJ//+cGs6MUiUfyIMzhL?=
 =?iso-8859-1?Q?au79Kbh78J5dAfSHgGZj2JlvkqY5BkGca9YogV2F30ky/lLfugsxFqUM2U?=
 =?iso-8859-1?Q?fupbRD6yT6ptkos9qWvceFU2nzT6gz6JMBErv/qwZz9D+Kz+/tUtr+Gxj6?=
 =?iso-8859-1?Q?ZXkDeo0ptg9QsNg9Bvtk1KKHn4dMcztbXR6EDArdMe/N+8X3ENMzlw6dC4?=
 =?iso-8859-1?Q?4279mETr718Oc+vXmssvTChOSvZtRMT7f4McTyNEnHcRHd0BofLiRzkyrc?=
 =?iso-8859-1?Q?A6IzYd0SruiCtIFfV4uNlw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pmHgFcxIn8i8rinO010DN2cySPH7bBeEZmc3qlZOvXL5flPw1t7N7MGPAT?=
 =?iso-8859-1?Q?Sxd01KkbZSBzrAUd+Xfq1+W+Jc2UZEAF9GFF0edPFFLN5IteXh151DwxYr?=
 =?iso-8859-1?Q?HNWqgqkQpY0Qv9NGfKyrSN4dcil9rc+tEyLbS1ghqJU8BkZdnArbv2E8AE?=
 =?iso-8859-1?Q?wB6Zjc6ceUPO2YpVjV0EMPFXxsvjGO/mlkswUJM9gGu+qaoopXVKRU2I3d?=
 =?iso-8859-1?Q?UuwbbnVk8Q0i3zCVGXVyXr9MDaeS6TX73tFgou+DDICPvQyh7aZ8/qMkqU?=
 =?iso-8859-1?Q?3SwM3fR5HnLPqCS4iq4DiNTzbPIR+OupiHNYTibsG1d5vJA7tvHSPKdP73?=
 =?iso-8859-1?Q?Ty4MyJWNaSipFumWhRbJdBY0+uyxd7G1rQZvTv1uE33DxMfJ3IZvwdMLz/?=
 =?iso-8859-1?Q?QIgu1yUB2vb44a5YlC8vuGkeCva/N+FzDekBs9SOh2ZuZ+S69wF0Q3NWK2?=
 =?iso-8859-1?Q?STaAUu0gL+IE29+dKp5sy1RCCRPJrzU2HFH82oXNeMdt4+pjnu6pKXHSKm?=
 =?iso-8859-1?Q?XmFIZckqSurxo1cE6ONHdHnhk0GIQhNe+Z4M8AoNWFWc8ITgvwlcGe6PON?=
 =?iso-8859-1?Q?dzW1bG2B5bapLYDFliUqOM5OHjX/rdJRmB6jqEdqsJpc/87HGc2ttNcZ98?=
 =?iso-8859-1?Q?5qdHxd0EVAFoQd+4tKR/UoHzU9dfrqBIcg43lxNcYwXgVwVeUX3AqgYoW8?=
 =?iso-8859-1?Q?OE/3bWIqYoDymxxBOD/zwP4cy+cVfucld7D1lV1xGDHE5t86FC2TofYmaU?=
 =?iso-8859-1?Q?bhrA8BW3DtEsQeb8XA3TvGs3EUa8NkyEk8slsOTxJux0HGnOQKJVJww+8o?=
 =?iso-8859-1?Q?5Mxj0ZyEM3nNPWSTXBqoXh4oXDU3LqEbXjzC2Qy3J06whfoI6cDpekeNzc?=
 =?iso-8859-1?Q?E0J1pIgDPu00gdzVxYb0SZ5S7qOpCxR3yudKAx2uuXMloOzb46wm6L/3Zo?=
 =?iso-8859-1?Q?NlVydw/CUw9AtWB2zTc46C/r+QIo+oE+EwmqBZlP1CN/tFT6ABBDyF2op3?=
 =?iso-8859-1?Q?1SJ/SrYulfu9dOHqJtCTM+/PjPOi6pTSt8CVhfsVk3ffAwJN0rLal1Wddy?=
 =?iso-8859-1?Q?00IS6cM6k6hU4YGztQS/MScxJjohCSe+vaWT1br9OhrdeMjtQmF6p/VVx1?=
 =?iso-8859-1?Q?YdP3zAyGgq/xhhDaFRCGICVX4GVBO/uvR/AjJnGdsu0xNQEBSw03E8OQC8?=
 =?iso-8859-1?Q?ME3F6JGzfw9/2Move917mzuBGBMh2/+VarWqNOddpfQg+i/CQJrsvAN4bV?=
 =?iso-8859-1?Q?tH9i8XNzatwanbGlLVf654Q0qt6VBw3kZkCfcbp+YJBDPD3DXPRLh8oAiz?=
 =?iso-8859-1?Q?SccNuo+JtSVFIu1s8nyT5EzGm/TmZHw1nP5W1WMWq3T4cTZ/ZbrKQzdT1F?=
 =?iso-8859-1?Q?1QJe+ULfH56akSx/WE5k4KkyUmcPa85vYt6L8NZDiuPue2AizyoHuDPm1W?=
 =?iso-8859-1?Q?FxDlMGDRCQAvogyHqNUNgriCb7OBsif+/IX9S/mSfi4Vs7nD4VJ2Nhepw5?=
 =?iso-8859-1?Q?UTkrS4pFuSZScBsB5fNfdgG2XPXV7f/g9vfmbDtUFcVv+6KTnQSDZD5cqu?=
 =?iso-8859-1?Q?IcZABWhrCwJ0Yi4Dxmgdng1PIhbSTgf6bHGK1fr/wEYD+j3Zil43eQ6KFb?=
 =?iso-8859-1?Q?aUnRqgE1M5eqyaAhUP62GIZF7h/JZia/O6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea4a9ba-3317-4757-2f9a-08ddf3a432c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2025 15:34:30.7691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn9GErF6l6GHQGtrcP7QE7qsCSBG4KAbTqYQoSN8gO91gX3Di+KIsQMKMTxe1qHlq3AryNuOhDRG0/tQFmpGAuUiUP+CEVe/6qzqnLhrqj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6212
X-Proofpoint-ORIG-GUID: 11DQYa_hN0dx1GTxdKxkEdjSgR2TltpY
X-Authority-Analysis: v=2.4 cv=PpmTbxM3 c=1 sm=1 tr=0 ts=68c6e08a cx=c_pps
 a=K57nmjWjm4f0a2EZjUQdmg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8 a=iEltamYccPJle2axIx4A:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 11DQYa_hN0dx1GTxdKxkEdjSgR2TltpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDExMiBTYWx0ZWRfX4GkFQUm3XPvg
 JAAhL4uBMs8g/lfLzFiUaIfjybsrlsWNv1fHpXpKT63ZAXx9K5+8ViqnIviu78agY9SBNQVt66t
 nJTk1fGGP4iIsicADAz5OOr7bp4igC1Q8Hh88jX+YH60F/rspGgVclE9uZV66oCRPX4PbtXlFGp
 jn6fvOD4OLV1pLtO9c3Rv42DUQdgNc2KGoNT5RGAra7uKIZKLpkoIXI4hG2Rw7ASHch09IFTsjN
 0fidBqJwzqgijrvdPNDG7UGw2IQRqqBPxKZVyPBras6TSHjfaqUvvkBTqNCQkmaqbv84QkeGJ8E
 TkZugHYjKAii3i/bkIehoXGHBLQZ40h1oykOUWsxiWXINsdhgKkZRzrEOdDbXfNCbv8XtbJhhqo
 ZpVLa/oW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_06,2025-09-12_01,2025-03-28_01
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

=0A=
Ping for review.=0A=
=0A=
>Hi Bruce,=0A=
>=0A=
>>On Sat, May 24, 2025 at 02:43:10PM +0530, pbhagavatula@marvell.com wrote:=
=0A=
>>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>>=0A=
>>> Introduce DMA enqueue/dequeue operations to the DMA device library.=0A=
>>>=0A=
>>> Add configuration flags to rte_dma_config instead of boolean for=0A=
>>> individual features.=0A=
>>>=0A=
>>> The enqueue/dequeue operations allow applications to communicate with t=
he=0A=
>>> DMA device using the rte_dma_op structure, providing a more flexible an=
d=0A=
>>> efficient way to manage DMA operations.=0A=
>>>=0A=
>>=0A=
>>While I have no really strong objections to this addition to the dmadev=
=0A=
>>API, I'd appreciate if you could explain WHY or how this method of workin=
g=0A=
>>is more efficient in your usecase? When designing the dmadev APIs=0A=
>>originally, we looked at using both an enqueue-type API as well as the=0A=
>>implemented individual-op-based APIs. IIRC at that time testing showed th=
at=0A=
>>using the single ops directly was faster than using the enqueue APIs, so=
=0A=
>>I'm wondering what exactly has changed, or is different about your usecas=
e?=0A=
>>=0A=
>=0A=
>Here is an example where we see enqueue/dequeue ops to be useful especiall=
y when=0A=
>integrating with Graph library.=0A=
>=0A=
>We had to write an entire wrapper[1] for tracking sges with the current im=
plementation=0A=
>making our nodes[2] very complex.=0A=
>=0A=
>[1]https://github.com/MarvellEmbeddedProcessors/dao/blob/dao-devel/lib/com=
mon/dao_dma.h=0A=
>[2]https://github.com/MarvellEmbeddedProcessors/dao/blob/3f364261de91e3556=
99bd9af20d60ea6459f7d67/lib/virtio_net/virtio_net_deq_ext.c#L51=0A=
>=0A=
>>/Bruce=0A=
>=0A=
>Thanks,=0A=
>Pavan.=0A=
=0A=
