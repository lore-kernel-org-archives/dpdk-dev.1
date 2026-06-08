Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06977CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C4C7402DD;
	Mon,  8 Jun 2026 17:29:39 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4CF8A40265;
 Mon,  8 Jun 2026 17:29:37 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658EbR522485516; Mon, 8 Jun 2026 08:29:36 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021085.outbound.protection.outlook.com [52.101.52.85])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8vbvw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 08:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpLVrn8VOytZJ9uLkoOiTs7hWl3DDl205aPYT6hXj/QhcbWwyYkz9CiT6/m91IVuhdwhjkkMygHYwu2vseR7ivY4ClXIAn/DCzauVafLAy2zfbtn1ISSQrocJbOWTLIUhDPl8ERruGTj6eJdDuf8vDYRM4uYGDtD+xZsbrFSFUAXd3adSgZGLvc0N5D2jIdWAbl2JN2geZ2nA/Iy4vpnBh032eIhou1o/0B3GCDAmiQdck7WQ3CFx0jiy3L+UuvfZwhomCVGeJi+iEwN7rvqS2xztun+JC6nfi22Kvjr4ca49dkGvTQsM0ztj/6Gj3KXAgES5eE2ap1gppqnajKpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKntH1qV6MDlf/T9d68IzaocDmrvMPy3jm7rbyjVUJo=;
 b=xoaw4WiQiBvKxGylR/xzlt+tdW2eSupA7JWyazWjKmgL7+3xihHGldwZWLPvgoopoGqNJo/dqUiGx2dFSJxfkWbCUT9W837l8DUUhQJ/hpk9Z0qB1sNq2df5TQG2wIbYEUh6MP9KgnFqI1OagvrFyGdqBrdFzdtbH6hMs+80TTrO612mvHF8mknAojJpHrVR4uhKCYuR+rIE/z6/iHvGqtMU7n4AVuXiib8MjeEIOlid259wWyX/s0v2hlHvYczJtA1PFOaDP43+C6jkAZhvRDlsmMdDqazcGhUwq5/CoCgIYY65PSFfw51WNU+DfBo27GASir2O4k8fOPJdncGxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKntH1qV6MDlf/T9d68IzaocDmrvMPy3jm7rbyjVUJo=;
 b=O+Z5lLAhpmw58efLfOUHkcRes4glr2py/5cMQdjsLJVJpTA7sLChx0yrfftk5PJ+Ij1QH3g4LW+XWluavXXtSLkSPW4CTVEIwo06ssHJehd1ti07uEb0tYnCWEZZjRCW8v8Mkc6tcgnbuzEZOeY633BjOqaazPK4fIa+zDkfcD4=
Received: from PH7PR18MB5078.namprd18.prod.outlook.com (2603:10b6:510:151::20)
 by PH0PR18MB927461.namprd18.prod.outlook.com (2603:10b6:510:383::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:29:33 +0000
Received: from PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424]) by PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:29:33 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Sergei Iashin <yashin.sergey@gmail.com>, Harman Kalra <hkalra@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "jerin.jacob@caviumnetworks.com" <jerin.jacob@caviumnetworks.com>
Subject: Re: [EXTERNAL] [PATCH] net/octeontx: fix buffer overflow in device
 name formatting
Thread-Topic: [EXTERNAL] [PATCH] net/octeontx: fix buffer overflow in device
 name formatting
Thread-Index: AQHcxmQ2GT7GRP0WwESHoiFe5dhsKLY1KdQH
Date: Mon, 8 Jun 2026 15:29:32 +0000
Message-ID: <PH7PR18MB5078D1EA93C4B8A764F11BA2C81C2@PH7PR18MB5078.namprd18.prod.outlook.com>
References: <20260407075732.1175609-1-yashin.sergey@gmail.com>
In-Reply-To: <20260407075732.1175609-1-yashin.sergey@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5078:EE_|PH0PR18MB927461:EE_
x-ms-office365-filtering-correlation-id: 1b0718fb-4a9a-4930-585a-08dec572bd80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|11063799006|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: JjBNXdEMhb3gPlw3RTLWQCb26xtT1A6OIg5vXWFHR+N6ywS5RI3DHyVqaVd13fTez2hZelu18OYvUyNfoVP3vCZPPjvs5lv+eln+mu9p7yjkllpCjA3sMUuH7fk5y8+zWR645EbfxMBKlvi/6Y/ZbfQVdsH/uH7OsLfLsITWewFaA2ZPhdtBUtJ92idxAHobzK5CrdGu+GQIi+GbzoBYr97ePaCMisy1ZDiFxtR8ewT+XOMJNbcSHwzz4iI2UAWJpa1E+s3eG3wFmqFPgqsB6ghq8ttUVICuwZchn6ipOfTRXYn+gbtXSAxSa60BWCfZblje13ATPjrkxflOGOBwV/SeTLpN/ZyrVmsQOO0+Gc03XI5/xoWPf81qVE5XaZJ+Ao8N/6kk892rPUuqF+UY6AhfMVy4rB2rZ+Cl7AlgDeGvD15nEG9TVcJvVynjtzEGroIkWFkQdppAJSw6eTNOaMijDdZXCUq9O0SF3OX4gdnhcoz9VeYD5CR3lTeXEVPGkKJD0aSkKKkbiMKFJJPUxldn0p/Pe1xmq0FQFpTcgPU3WnnQ8iqB50nfnwrdS/BlQejPwXha5M4aiC/6kQ0GEinHV3fIomxF6lBHnbG8SuQxTJStSi7s3FSIpvg+GcLfubXH+GL+Bos+ZACJ6H4b3aMbAaGxGCn0YI4DVwID4MBVKxky+xM9pU48qJQ17eWiKeUp7VchVZ3DFZR1UBMSpEtbtKZ0CzVY6/IrcNJSMxhcVfwKUWAdieruYt3AAcSd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(11063799006)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8pQlPgu768aJalm8KRPBJhFf8x/P3/BgJDbQKPyVBGox2HzrtqlXTetGd2?=
 =?iso-8859-1?Q?H7mwtOQni21EkGcGBo3qWI+1lvYmAPtKPzDy+PMDhyTOvhAlccDvqk/IcU?=
 =?iso-8859-1?Q?a6oYIzOXbt7lJ82dTQFWqLlbm5IdQN9hg+3f71f3/7Jjit9AjtkRkszvwA?=
 =?iso-8859-1?Q?12jejC7CVMoPRNUxZNDfWlU+jskH7dHtd4UYrGd3sKk34uAAlCDD3qOrRM?=
 =?iso-8859-1?Q?Sx1wlxn6bnKLjSUr4imSbXBuNM6QKR/ewXPVpTQoI8O8eRrsb+UuUnTrQU?=
 =?iso-8859-1?Q?Xk46uyaFhlCId1ybZ35eBSUpTxm+gYoWPTSpJ9cFTyuATLfWxoYCz5/9FC?=
 =?iso-8859-1?Q?tvXO0cj6e3yWpBZGNuS96PM7GgkXrUEu546Np/Rm46CnLeYE5B0rGZhkwl?=
 =?iso-8859-1?Q?GPs14bH18l5cD4fcDnc5nKGpG8aZGmuKKj6GguDSCqdtYIlPofRMWoAfwq?=
 =?iso-8859-1?Q?U2vx4YZ0c7TDiDeq/KnQoQ0F6QeWXJEWNyO/22E3Yn/u4+dttUOkP+E/Nv?=
 =?iso-8859-1?Q?jHE/e6HOI7m9jIvsrPVv/sgQ+1LgfUeIo8zgXqezYSa3R2F7ce6SpwE363?=
 =?iso-8859-1?Q?MSkk7RE+7dK5VYC7Gc8fi3vIeRok2GWiRoe5WB34SfSG/QpGAwp+IxXEHC?=
 =?iso-8859-1?Q?nVDvfCCgJWjxLXL58pIU2hDI6838WDllgGpSFY5+FrEWa58Beaa9jbZn5L?=
 =?iso-8859-1?Q?GgfZQP7FyDMpcWIGwVRyTtnDDYxT9S3hiJwoYPKzZfQZ+8KZhdlOnAzAZq?=
 =?iso-8859-1?Q?VVBaviINFgZUqqDow7GgJTys0d18s0eM48QWHsw2G4kJFUBgLhyKryIVX3?=
 =?iso-8859-1?Q?wwnF+/KctZe7BzhFx34RRl7emeTHIGW2x7AB9n/5YaQxDJuPa1d0SzZDpz?=
 =?iso-8859-1?Q?p1HDhjJXRQPYamTceAcqQtdx6cOm0fy8zpxh+MPHymISoo/i20FvVQFlTb?=
 =?iso-8859-1?Q?MRHne3LQdKsK4bWCqqk17D+1yNnq7pynktTP8Ng0xCRAwl3u5LMZHU/Z9r?=
 =?iso-8859-1?Q?AH7sArsm7mkKFi0w70er6GTGgMOkh572UsxlFE7ZTGLwh1n+XS1HGZ+Dsv?=
 =?iso-8859-1?Q?TBTKYSGsA+ufiTP+QfvrrN7ae5tU4zYf/DR99gQFOLEYSbaA1qkFrLqXyn?=
 =?iso-8859-1?Q?8HNv6d+K8rNeupYCvdeq6Ca95pkaELzVw+tFyb8vXTBF2OP6eTZPyKj7Bb?=
 =?iso-8859-1?Q?kDGA1aHNNXG8Mn8/FvkiM3wdM4h93V5GIAgRUkY09hhJoZTdjG6EunbzHo?=
 =?iso-8859-1?Q?0TJ2APP6a8w0abfoKuVQMIOoF50dIeLz9XuUKwjLNZeSB1Lbe5r2o0V+CO?=
 =?iso-8859-1?Q?CKrRSWjZSR3xvpaIv9HEqrt9k0qQQKzNE4YcXqPGD2dOlNZYBmu74IswyR?=
 =?iso-8859-1?Q?In0pXmZ9fEuFA8qk4p0adYbgq+YIrRYCEERaI4s0op2+8isI/1Ol5T/OJF?=
 =?iso-8859-1?Q?7ui5am6Etv7FlJqGagl3Jk8sBvR7a3ickT660+ydsT9Jl+WY9x0/x4OH8v?=
 =?iso-8859-1?Q?3D26D7ZhRYsk0bKkQRhp7xl+1c31P2Ul7WEPhIn3VPsYFvP0bT/+Z3AguA?=
 =?iso-8859-1?Q?ZCa2Ip+pUHzkG8UjCJp98qDLHerwLWHd14dcBTKYKa/adroVkUeAqm1G68?=
 =?iso-8859-1?Q?bc+yTP83CKYfrLaJYpx3amgXMjKztCZzpdeF7XLOf3OfizTs7izfzgD2iV?=
 =?iso-8859-1?Q?08bd5ioQyBFVHP52KyklYz2ZlGQzfu2xGBCi0ENcdP//A2yb0ymW5rqIa4?=
 =?iso-8859-1?Q?qqFG2amMGqi7oAyoLo0UdjDgapaqT4kmr9jfxOcY4mRqlq?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR18MB5078D1EA93C4B8A764F11BA2C81C2PH7PR18MB5078namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pniue6dtcC86TstM7i8k2u04DRDw3JSXOMKeRbLeu8A7KP8a/qO6vVNGSo6Z8cr38J0YP0IjTrPCu47tCURqELaLx6ncyf3ZVj0a1bhlgGbjPh8CHPMUWWkkyYGeoH95RLg/Dzv/1EicuIPjj9Xce8H2hLmohOVNBds19fe6BcFsiVxFgRjFxu5c+unI45srEH1y6vAvemme7oBjr8wF2em2LjcwQSe7RoA2N917wbMq9qD7kkxKzMIwks3/1ERfd+DEMhVEg4j9W/fw3fpLZHFbQqLTPc0wuKdmj1/ORf5+yO7f5cU5ZT/EB6z5wKKaOQCwor/bXGunQLBvNz35bQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0718fb-4a9a-4930-585a-08dec572bd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 15:29:32.9283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W6bBhW4ljoGJbdX+DapP0od259DWB7fLtQijMB/Z6N2sMriXc/CYZPrJZWTEY6HnILctLeyrPpZi8FQxcNIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB927461
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0NyBTYWx0ZWRfX2Qf5YwTtzuFH
 lKS18fGxAzqgqIrn11OeTnipCIK8l31UvwKsEO/F61RhksArbtYlCGt9FnmceWUtGHdrliHfZrf
 pQL6AJVldm+e9lqcIZrFFBGWQ/QK/ZfAhJTs3ld7rFwBAGKk85CYc18rI/RmN/Q8BJQ9PDd97B0
 LSSE75QZoQtdR+6Z+eHNllfPvVxQhTS14CrVhl8a8ksfLmYvD+0diavgzOCw+u44VhEEqQF1UXq
 vZY6zo+RZZZwxo0g69iQG4iPV3VbvA1Rc6NC7fSVboo9hb9W//zVl7VH2QB0Mh37IwMOnmhDqZo
 D5zKBE67VHeKNzk/vIlqc02DSp1wlrIny04bgSsJuifoXaZMjSkAweHh3GZS/f6rOxTIL8hkXuA
 iLMwWxaU+/OnH+2FM5a5zoBmEetVL7VsOlOSRRb7mR3pav2ZL+iZZJVNH0HvAfON1vu20wvvEJv
 b0XzzHL+xSKvHfMRFPQ==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a26dfe0 cx=c_pps
 a=GzbtWuAz25DTP0J0usuZ9g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=RpNjiQI2AAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=enOvQawGAAAA:8 a=8rWy6zfcAAAA:8 a=dtRhXEUe8RYxJtPwphMA:9 a=wPNLvfGTeEIA:10
 a=1-Qz0wgTHJMizFBWEw8A:9 a=tqdMzFhGG8mD8GCBlf4leDhY3gs=:19
 a=Qze210agfmFwVezx:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=OuzhcWw_GC9nAYdNdRwA:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: NiHJTbRQhVpQi533kOyB5zI4wvoHX_VG
X-Proofpoint-GUID: NiHJTbRQhVpQi533kOyB5zI4wvoHX_VG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
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

--_000_PH7PR18MB5078D1EA93C4B8A764F11BA2C81C2PH7PR18MB5078namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Applied to dpdk-next-net-mrvl/for-main. Thanks


________________________________
From: Sergei Iashin <yashin.sergey@gmail.com>
Sent: Tuesday, April 7, 2026 1:27 PM
To: Harman Kalra <hkalra@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Sa=
ntosh Shukla <santosh.shukla@caviumnetworks.com>
Cc: dev@dpdk.org <dev@dpdk.org>; stable@dpdk.org <stable@dpdk.org>; jerin.j=
acob@caviumnetworks.com <jerin.jacob@caviumnetworks.com>; Sergei Iashin <ya=
shin.sergey@gmail.com>
Subject: [EXTERNAL] [PATCH] net/octeontx: fix buffer overflow in device nam=
e formatting

Replace sprintf with snprintf when formatting into the fixed-size octtx_nam=
e buffer in octeontx_create and octeontx_remove. The device name can be up =
to 63 bytes (RTE_DEV_NAME_MAX_LEN) while the buffer is only 32 bytes (OCTEO=
NTX_MAX_NAME_LEN),
ZjQcmQRYFpfptBannerStart
Prioritize security for external emails:
Confirm sender and content safety before clicking links or opening attachme=
nts
Report Suspicious<https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!=
tm3Z1f8UYnVa9O-8WX26DsK-0LaBO_9qwE4pEx2cpcKfFql8RWpbr-t0B-4n0FjU7XSDAvlitsV=
3KK8Ua-2nw37gJz6mivFAuDI$>

ZjQcmQRYFpfptBannerEnd

Replace sprintf with snprintf when formatting into the fixed-size
octtx_name buffer in octeontx_create and octeontx_remove. The device
name can be up to 63 bytes (RTE_DEV_NAME_MAX_LEN) while the buffer
is only 32 bytes (OCTEONTX_MAX_NAME_LEN), which may cause a stack
buffer overflow with a long user-provided --vdev name.

Fixes: f18b146c498d ("net/octeontx: create ethdev ports")
Cc: stable@dpdk.org

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 drivers/net/octeontx/octeontx_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/=
octeontx_ethdev.c
index 21e3e56901..e4dca30d9d 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1555,7 +1555,7 @@ octeontx_create(struct rte_vdev_device *dev, int port=
, uint8_t evdev,

        PMD_INIT_FUNC_TRACE();

-       sprintf(octtx_name, "%s_%d", name, port);
+       snprintf(octtx_name, sizeof(octtx_name), "%s_%d", name, port);
        if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY) {
                eth_dev =3D rte_eth_dev_attach_secondary(octtx_name);
                if (eth_dev =3D=3D NULL)
@@ -1711,7 +1711,7 @@ octeontx_remove(struct rte_vdev_device *dev)
                return -EINVAL;

        for (i =3D 0; i < OCTEONTX_VDEV_DEFAULT_MAX_NR_PORT; i++) {
-               sprintf(octtx_name, "eth_octeontx_%d", i);
+               snprintf(octtx_name, sizeof(octtx_name), "eth_octeontx_%d",=
 i);

                eth_dev =3D rte_eth_dev_allocated(octtx_name);
                if (eth_dev =3D=3D NULL)
--
2.39.5



--_000_PH7PR18MB5078D1EA93C4B8A764F11BA2C81C2PH7PR18MB5078namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<pre class=3D"elementToProof"><div class=3D"elementToProof" style=3D"font-f=
amily: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><code>Applied to dpdk-ne=
xt-net-mrvl/for-main. Thanks=0A=
</code></div></pre>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Sergei Iashin &lt;yashin.sergey@gmail.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, April 7, 2026 1:27 PM<br>
<b>To:</b>&nbsp;Harman Kalra &lt;hkalra@marvell.com&gt;; Jerin Jacob &lt;je=
rinj@marvell.com&gt;; Santosh Shukla &lt;santosh.shukla@caviumnetworks.com&=
gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; stable@dpdk.org &lt;stab=
le@dpdk.org&gt;; jerin.jacob@caviumnetworks.com &lt;jerin.jacob@caviumnetwo=
rks.com&gt;; Sergei Iashin &lt;yashin.sergey@gmail.com&gt;<br>
<b>Subject:</b>&nbsp;[EXTERNAL] [PATCH] net/octeontx: fix buffer overflow i=
n device name formatting</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"line-height: 1px; max-height: 0px; display: none; font-size: =
1px; color: rgb(255, 255, 255);">
Replace sprintf with snprintf when formatting into the fixed-size octtx_nam=
e buffer in octeontx_create and octeontx_remove. The device name can be up =
to 63 bytes (RTE_DEV_NAME_MAX_LEN) while the buffer is only 32 bytes (OCTEO=
NTX_MAX_NAME_LEN),</div>
<div style=3D"line-height: 1px; max-height: 0px; display: none; font-size: =
1px; color: rgb(255, 255, 255);">
ZjQcmQRYFpfptBannerStart</div>
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); margin: 0px 0px 10px; padding: 7px 16px 8px; border-top: 4px solid rgb(=
141, 140, 140); border-radius: 4px; max-width: none; max-height: none; min-=
width: 200px; display: block;">
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); margin: 1px 0px; max-width: 600px; max-height: none; display: block;">
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); max-width: none; max-height: none; display: block;">
<div style=3D"direction: ltr; text-align: left; line-height: 1.29; font-fam=
ily: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0);">
<b>Prioritize security for external emails:</b></div>
</div>
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); margin-top: 2px; max-width: none; max-height: none; display: block;">
<div style=3D"direction: ltr; text-align: left; line-height: 1.5; font-fami=
ly: Arial, sans-serif; font-size: 12px; color: rgb(0, 0, 0);">
Confirm sender and content safety before clicking links or opening attachme=
nts</div>
</div>
</div>
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); margin-top: 1px; margin-left: 16px; max-width: none; max-height: none; =
display: block;">
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); max-width: none; max-height: none; display: inline-block;">
<div style=3D"margin-top: 3px; margin-bottom: 3px; margin-left: 16px; paddi=
ng: 7.5px 16px; border-width: 1px; border-style: solid; border-color: rgb(1=
02, 102, 102); border-radius: 2px; display: inline-block;">
<div id=3D"x_pfptBanners6g61cl" style=3D"background-color: rgb(210, 208, 20=
8); max-width: none; max-height: none; display: inline-block;">
<div id=3D"OWAa705abc5-9e78-8802-f5d2-c52fac0b9466" style=3D"background-col=
or: rgb(210, 208, 208); max-width: none; max-height: none; display: inline-=
block;">
<div style=3D"direction: ltr; text-align: right; white-space: nowrap; font-=
family: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0);">
<a href=3D"https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!tm3Z1f8=
UYnVa9O-8WX26DsK-0LaBO_9qwE4pEx2cpcKfFql8RWpbr-t0B-4n0FjU7XSDAvlitsV3KK8Ua-=
2nw37gJz6mivFAuDI$" id=3D"OWAa705abc5-9e78-8802-f5d2-c52fac0b9466" class=3D=
"OWAAutoLink" data-auth=3D"NotApplicable" style=3D"text-decoration: none; d=
isplay: inline-block; background-color: rgb(210, 208, 208); max-width: none=
; max-height: none;">Report&nbsp;Suspicious</a></div>
</div>
</div>
</div>
</div>
</div>
<div style=3D"direction: ltr; text-align: left; line-height: 0; display: bl=
ock; font-size: 0.01px;">
&nbsp;</div>
</div>
<div style=3D"line-height: 1px; max-height: 0px; display: none; font-size: =
1px; color: rgb(255, 255, 255);">
ZjQcmQRYFpfptBannerEnd</div>
<pre><div style=3D"white-space: pre-wrap; font-family: sans-serif;">Replace=
 sprintf with snprintf when formatting into the fixed-size=0A=
octtx_name buffer in octeontx_create and octeontx_remove. The device=0A=
name can be up to 63 bytes (RTE_DEV_NAME_MAX_LEN) while the buffer=0A=
is only 32 bytes (OCTEONTX_MAX_NAME_LEN), which may cause a stack=0A=
buffer overflow with a long user-provided --vdev name.=0A=
=0A=
Fixes: f18b146c498d (&quot;net/octeontx: create ethdev ports&quot;)=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Sergei Iashin &lt;yashin.sergey@gmail.com&gt;=0A=
---=0A=
 drivers/net/octeontx/octeontx_ethdev.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/=
octeontx_ethdev.c=0A=
index 21e3e56901..e4dca30d9d 100644=0A=
--- a/drivers/net/octeontx/octeontx_ethdev.c=0A=
+++ b/drivers/net/octeontx/octeontx_ethdev.c=0A=
@@ -1555,7 +1555,7 @@ octeontx_create(struct rte_vdev_device *dev, int port=
, uint8_t evdev,=0A=
 =0A=
 	PMD_INIT_FUNC_TRACE();=0A=
 =0A=
-	sprintf(octtx_name, &quot;%s_%d&quot;, name, port);=0A=
+	snprintf(octtx_name, sizeof(octtx_name), &quot;%s_%d&quot;, name, port);=
=0A=
 	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY) {=0A=
 		eth_dev =3D rte_eth_dev_attach_secondary(octtx_name);=0A=
 		if (eth_dev =3D=3D NULL)=0A=
@@ -1711,7 +1711,7 @@ octeontx_remove(struct rte_vdev_device *dev)=0A=
 		return -EINVAL;=0A=
 =0A=
 	for (i =3D 0; i &lt; OCTEONTX_VDEV_DEFAULT_MAX_NR_PORT; i++) {=0A=
-		sprintf(octtx_name, &quot;eth_octeontx_%d&quot;, i);=0A=
+		snprintf(octtx_name, sizeof(octtx_name), &quot;eth_octeontx_%d&quot;, i)=
;=0A=
 =0A=
 		eth_dev =3D rte_eth_dev_allocated(octtx_name);=0A=
 		if (eth_dev =3D=3D NULL)=0A=
-- =0A=
2.39.5=0A=
=0A=
</div></pre>
</body>
</html>

--_000_PH7PR18MB5078D1EA93C4B8A764F11BA2C81C2PH7PR18MB5078namp_--
