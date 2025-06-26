Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC57C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 858EE40287;
	Thu, 26 Jun 2025 16:12:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 06AA340156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:12:12 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QDF60e009966;
 Thu, 26 Jun 2025 07:12:12 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2106.outbound.protection.outlook.com [40.107.212.106])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47h6wyr42a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 07:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIFKSUb1CHDbhgWgJBG4RVYxZ4Ikng2AM5KxNXEN9FXDIsTiIofun8CgsTjk45F5t80qidpH+0yLmZnbYwLjuVTss3MnSe5Qmz/MboE4xcILm4ZvR//i9d0zhPzuhEu52q58bhPobEcCV/I95pStMx9b2guxqWqcw3lXlPDhz1Oqd/YgCLZ2bSDidHZOHE9lynt3K5LYHKt86O//xfy+ox+ReA8/dm7iCO53QF/KxRpF487RAB4IchyUNa1hY0B6Sl0nxqsEuQAde+XTNiCdn4YlKvKtLGzOKDCbjdZn/lewM4lY2kpSNvbzy5JyMI6LPildhHHOQpNCtxgHsskdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVGrMf60fp+ESxEHSIdyref6mndjH2dWXrbnQiSt7yk=;
 b=Sq5N07vQW1e6UH4lC5hPasWkdloqcKVgsuQZ7xqTlJO457KmdABNX+7sooR6045y7jCdwdLRE871ic+patRFLJXOBx9fJ+iBMU3Q0Z0wbBOh9u6qdiupyMy2odaqnOS4xP75OFENAzecNefoSczl1Rl8aZx3YszlfNIZKX08l4Gq6o/idPHZJaxp+D5Dljwrg9M7PUah09tlxGtpp7TgiT0i6plJMss0wKhavZi5Z9M80kkOCpe0XWAq3LokLertOWuOyHvRvLZhcA6udVT9IaIukhpUWIzgtDjyYeU6zG3GTNnBqFtanT3+JIOAHwCJYvzzeCrAsPvnCa0GcFCFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVGrMf60fp+ESxEHSIdyref6mndjH2dWXrbnQiSt7yk=;
 b=oLq8GyjbcY3pTUaGnw/1tLULG1muDtC9nT2+8FHrrCIs/atgo+JB+eadQ1JIBsEUdBnxmv9vrlkQM+xzr1Q1D1kHvPdl0oadDC6IdvAY1GzhhOmEEQAe5fGUMm5tEs/8469HS72jcq0jxKSGxJHP59UZBJIVxFkIfKyEsGwWb7o=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DM4PR18MB5172.namprd18.prod.outlook.com (2603:10b6:8:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 14:12:06 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%3]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 14:12:06 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <hofors@lysator.liu.se>
Subject: RE: [EXTERNAL] [PATCH] eventdev: make flag types consistent with API
Thread-Topic: [EXTERNAL] [PATCH] eventdev: make flag types consistent with API
Thread-Index: AQHb5qOkSJBwcADXwkK+ZL34qDLrprQVerPA
Date: Thu, 26 Jun 2025 14:12:06 +0000
Message-ID: <BY3PR18MB478506E493537E8C47F2B21FC87AA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
In-Reply-To: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DM4PR18MB5172:EE_
x-ms-office365-filtering-correlation-id: e5bb875c-0dc1-4df8-62b8-08ddb4bb6e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejUzTm5zZGpuWlJjZXVESUhGdmxlblB0ZVNLQ2twbWlaSFJ3MWVzUzRUZXI3?=
 =?utf-8?B?UXpZQmR6dFovMTlKajlROSs2aWdUQVl4VzQ4R2dkKzZHa29OUlllMG9YeTg0?=
 =?utf-8?B?UHNSYzlvV3B5SS82cVRMbU5HNkxsb0ZxakhKTmcvRFdmbG1aTVo1cHVHODhU?=
 =?utf-8?B?YjltVmR4djZmeWNXQ1JXbnZiUDdLTjh0ektzd09XUVJSbklQbHhuVFNodzRo?=
 =?utf-8?B?L0FwUjhyeWxIamVPRVdhZjZmWFdFVnAwYzY5dlZNMndTZEJVQ1NoeS9oYS9M?=
 =?utf-8?B?ZnkxZGdYdWtiR3RuaTF3ZHYyY20zN25FMjA3VjhjdDQzMXBnMzgyanlabHY2?=
 =?utf-8?B?OFlHR0VIVCtZTm1IZVFpa1oyNGwySGl4ekFydHFTRFI1NUJtZEhETk5tMWE1?=
 =?utf-8?B?dDN0Nyt6YmhPME04TGppclM0b3NuMC80clNKemVQM3pKcy9TMG1VbkFRQ0ZS?=
 =?utf-8?B?VEpXM1dxWG9lN0tGSERUME5teVpWa0hnaWo2SCt3NDRSSFY3OTVhVytZOW5h?=
 =?utf-8?B?MXJvZkhRcUlLdnlURVBTYXREa05FdEw0RHBFd3FnVEx1djlZbDhkc3FxTldZ?=
 =?utf-8?B?KzRFY2M3a2YvSVNYOWQ5RWdMMDJlbDE3SGpkR2phaHdGL24vVHExYlV4UEhP?=
 =?utf-8?B?bGpSMmFCWi82V2hEOTg0dzcrSzNnUVZkaFBIcFBUTjhBNU5CQUtSMzFsaHFB?=
 =?utf-8?B?cUpoRWtyY2ZQeG83RGROdnJCZFQ2azNGdGRCeGpCaE1EdllLYjJKYUdTZnJI?=
 =?utf-8?B?RWxNUEF5RVFDYmpsMzdHVGsxb3RYMGQreUFNbXE2enUrQXNJbmhpMnJ1dity?=
 =?utf-8?B?SWJWdkdYVnZtUXM1bWdNRW4xOThKUTVrRFVwOW56enZBN0s4V1ZZSG9rcXJn?=
 =?utf-8?B?cjNKR3l6M2Q5MmRoWHp1MFVuM2s0NjNYc2Z1WVk5b09sbVdmNCtoNlNVVlhJ?=
 =?utf-8?B?bENUUVRWY0c1dlJ3Zy9RY3RlaE05V3JZeEZwVnBibFArWGV0eU1kZ244NGtC?=
 =?utf-8?B?U0VxNEdndmNrK2lvakxiNjBrL2V5U0lnQ1g4WnJrRFJoRmh6bmNKWWpVNTk2?=
 =?utf-8?B?Y0tYRGg0K1JwTEI2R2lDVjY3SnlkenA2ZEhBUk5zY3VrRFBMQ1E1b0pVR1Ay?=
 =?utf-8?B?K3praXFHUlJHK3hNbHppM2h5RTREZnBrMzR5TVpFZnk2Zm5EZ01EYmZKYllr?=
 =?utf-8?B?TndSdnpJWkFUWDZiSFFZdzdrN3FvR1lGYWFhWnNwa2F3YXJDVkZyVWI4U05i?=
 =?utf-8?B?bEE1eWZ0aEMzQ1lUTTk5TldGd1lIUjUrSy9BaTV3aUNmUTJuTlhCbEk2UUZV?=
 =?utf-8?B?NE90UTNrc1dZZUpuS3IzVFFGTE9SZHN6aE9MSnYrejFkcHhsVEM5OGJCckJv?=
 =?utf-8?B?ZHdtR0VoMnBEeXRzYjBORTRqR0dHbUJFdVJYSlVTYnJaNEg1bWZnb0V2Mm1I?=
 =?utf-8?B?STRGaWVWMGEyWWVUT05ZbzRYMWoxV3N2MVA0ZktlMEc0bTlsRElGMldZYWh1?=
 =?utf-8?B?YTUvejN3SUdjeFRvUjZtNVRhOGJ5eUNjdlhXZzdxQnJKcFBDRzd5QnNMODRU?=
 =?utf-8?B?NGN4M2lLOTU4b05QMjgzcFNWZFZZcStsU3lraWh1eHdHRHRhRGdkdG8vREl1?=
 =?utf-8?B?cEo0THl2RlBUcGFVMldKY0xpeU9SQ1E5UzhiZ1QrUC9yTXg4MEc0N3RjSEF1?=
 =?utf-8?B?TEdIWCszY1F6KzFlUXA5cGZsZHZ1bzA3UTNLWVF2cm5SeURDMVRKbUZMaVBs?=
 =?utf-8?B?alFMZ1I1WUttcVQ2WjBmdnNpWExIK1NpVTJHM1JodWZyU2NGWDVBY293Yk9Z?=
 =?utf-8?B?NzRWbEdwbjF1VmhJZmdnRkk1TXlNRitxenFDZWZpcFhDTkhXQjNmTG9vWGxp?=
 =?utf-8?B?OWtKUHJmNzVqQlgwbXNPdUJNcG8rc3ZudWZFTFgxTnI2OUtRVWk2dXYzSmR3?=
 =?utf-8?Q?N870Q4aUqrY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGliV1E5aVBCMEJEcERHcjBITWY2QkVWYVd6M3hrQjArNlhuSnJwcnRPR3lx?=
 =?utf-8?B?Y1BiTENyNWdKV2RnRHhTNmxrQ1RlNHM0djk1aS9OUm85Ni84emxFMWdJZzhP?=
 =?utf-8?B?SStjRTZEaDRIRFplVHhWNk10VXE2V3BNbEJ1MEhCSllxS1B5MURqa0xtUjdD?=
 =?utf-8?B?K01EelE4eWlRdE5STURKSFBVWksxaW1EdVpaWFhhYTNkL21tZW1hK0c2QTNQ?=
 =?utf-8?B?MWl5VndqN1BsaUlSSk84aW4yRTYwdWp2YWVJRDJuS1ZWNXBFK09heXgxMWFT?=
 =?utf-8?B?ZjhreFRCb0NTSjEzRnVZbk9zQXZpYWdxaXY3SHdTWGhjK2pSNmxTVVlUV0FF?=
 =?utf-8?B?ZVh3OUQ0VEJYTzRkUVUyUXEydnhXZFZLQnRSeWdVOFMzVFIza29mY3BZUE9x?=
 =?utf-8?B?aCtycHFzeEJZWktOQjBaT25IUWNEZ0dxOHlQdjB5MjNaenEyTVB1dVhNMksz?=
 =?utf-8?B?enQ4TGRweEQ2VGtLQnF0dnNxUW1qU29uL1A4a3dmRTVmaHZJYjlWUG83d2sr?=
 =?utf-8?B?VTRrWEtyU045Z0Jra0Q1cWFZcnZDY0M4bUh6Rm8vNjVVOVJjbStoYXdyeCsr?=
 =?utf-8?B?ajY3b2FhQXh3WHJ6QklraHR3OXNYZmZDOXpVSEZUMnFjOVBwdEoxWWRSNjR1?=
 =?utf-8?B?TmdSRHgzb1JraTFUcGd4Y2VNSjhObmhLZmt3TzAxR1lyS3I2SkFIa0Q0QU1W?=
 =?utf-8?B?R292QzFtNGNnb1JDeHQrem4rV09uMWQ0WTFwTFF6Yy9wS3pKM1poVjlrSC9o?=
 =?utf-8?B?WTl4VGJSVGd4TTBsWmpJZjY1b3hFSDJRcTJiVGIxdUViWk1tQi9OT25WU0Jt?=
 =?utf-8?B?cEZ6NU1zSDVKSzN3MEI2OGZsbzRyZEN5R3Nvb3hDSWlaT1NxUXpJQnk0dGUx?=
 =?utf-8?B?SGViVWs5Qk1wWEp5NEEweHZiczFqVEVLQjFtTUh6K3l4MzJyYkFNcXUwcncv?=
 =?utf-8?B?Z2hWN20wVDZ3UDVhWSs2NmxhSWhYdXUzZGRGQnpnREJlWXBBUDhhak1GN0hk?=
 =?utf-8?B?TE5pdEl6RTBjUDBPT0dtaXp5S1pPLzlGV3RXSWJNcHBFTnFlUGVJVXZvaUoy?=
 =?utf-8?B?czQwVGpqMkJsUHBLMS9VYnVBTStTYm5UMnA4LzV0VUkvemgycWtZVi9uYXYr?=
 =?utf-8?B?eitBVUtuS3luNVRtU3M0RmVGZEdoNmNLSHM1dm02LzNwMU9yYVJMYjMrUmM0?=
 =?utf-8?B?TTV4c2V0K0l3eldHd2VScWI1QUVZYUtWek4vanc5bEtHdGxjZGxRazNIdGRG?=
 =?utf-8?B?RzByc3pZNTU2bHd3VnY1YjVWU2VjRTRnRnZZVnJkYjBLK0Y4QUdSV2N6Rkc5?=
 =?utf-8?B?YUJQKzhnNWsranhFVFM0UmVZTmw5djNhT1FldnBVYlJPejBxSG9SWXE5NDJ2?=
 =?utf-8?B?WUsvU1BpaXFrcjdvUnl6V0tzK3Y5Zk1Pc1lGc0wybFlaMkl3OUhDc1UwRjNJ?=
 =?utf-8?B?NU0zUVduazNVcWt1NU5lK0ppZ0FPTmNPL1BYdi9xaTZhNDhXZG9xVExDRmJZ?=
 =?utf-8?B?a2hudnFucm01bjBQUDVMUnhPOUh6aUtYSmx6TkxXNzM2YVhPbjIyS1U2VXp5?=
 =?utf-8?B?ek1jcCt3MzhGNnExc1ZBWTNTbCt4ZXdzMjFwd0hMY2tmRmJFRHBjZzJtRk5x?=
 =?utf-8?B?ZDM2NVU1bTJjaVhnNi9GYlBaOGNqeGNvdnhhbEVJaTNXUXd4VXBMNkZqUTI5?=
 =?utf-8?B?WUliVDhrb1FOSm14VThrc1NWZ1FIa3N2YzFTaGVBL0Q0ZjNlck1IRnJNeGhF?=
 =?utf-8?B?RVVUWXF6c0FyVlhaK25hT1J6ZFhUbVZQZHNMQ25ncFBaUFNkdUJTczd3U3ow?=
 =?utf-8?B?TmJrN1RYbmEzbkpIa2FWUFMwcXFsTFVvai9MTEpiTm5GZDBKZFIwS0RsSWU1?=
 =?utf-8?B?akdyNS8xY3djOXhONHNYTm92ZytmdnV4US9TbzRUK2VZdVk4QnRROWI3Qmw4?=
 =?utf-8?B?R3hSaDB1TzI1anRJNDRDTXVoOEdnWmYxcTRrUGxFQmV3c3BuZWx3aU10TzhP?=
 =?utf-8?B?d3RWQTRJM2JiUjlJeU9LUmJOdVR1L3lhWGh6K3ZNL1U5Qm5DdjhMOCtEUE1s?=
 =?utf-8?B?QlhXOGRqODN6M21rMnZwSXNnNzJtditnQnNnSTlpTm5YZVM3Y2ErUUMwS2Zn?=
 =?utf-8?Q?KaT1o/+qWy+t2pf7MdZ/Zfyic?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bb875c-0dc1-4df8-62b8-08ddb4bb6e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 14:12:06.2517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P10jjttVfDIXoHN5NgnwJttAlQCnz1QJwdS8g0v+cw57HKNjvLG4l1m5U0wAGb2zxvq6B5zrtAO/R3SF/uiqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyMCBTYWx0ZWRfX18mTFb4V626U
 jhR+Hk0YRFkDq7ZR4UY5NNt5SsX9pFVCRnTeEaDe0fGqlEDz+CwGzMidsQDqY8sOYpRhZaH8pnf
 FZ6tGDZg4YQxNkjzzGyZRS/axHZ0GbJSdxHYrJwUyDBdQJJlzudJNla3qBEnk5qY4F42u2U1yyz
 E6UL5NP6Nrk9EjJUeD7Enpob6gO/WA8as83t2gadMecv63Y3SZlGwPiJpWHO2MNgrNCw9Qvg2OG
 G1ZW3FBZ+eDZxrdFK9gmL8HZXvnzDZ6Awt8w1gqZcgWdQp09ZK0ZaRC/5pYV189LJWsgyOxMGa/
 YN7Gb45/LHlr8JtaJ1UNuFX6YVjJjxhGe78bxijdTHJD2hvdX3MbS0yxy1zoR8doZ0LBxqBd3V3
 Ydkfhnf9s4UHaRnFcPl7ZERw7ZTQM84U4XkPdSD9z5AmeKECRs1ByNDXLSdi+AVo68KNGGkQ
X-Proofpoint-ORIG-GUID: a0ARj6KM-0ZV5GTuJUa_L0BgCN2b8qcR
X-Proofpoint-GUID: a0ARj6KM-0ZV5GTuJUa_L0BgCN2b8qcR
X-Authority-Analysis: v=2.4 cv=KdTSsRYD c=1 sm=1 tr=0 ts=685d553c cx=c_pps
 a=b1Xu4tulDBGmpFzVk7b7Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=0FD05c-RAAAA:8 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=QqwUylPediNKu58C2-kA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0aWFzIFLDtm5uYmxvbSA8
bWF0dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI2
LCAyMDI1IDc6MjMgUE0NCj4gVG86IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+DQo+
IENjOiBkZXZAZHBkay5vcmc7IE1hdHRpYXMgUsO2bm5ibG9tIDxob2ZvcnNAbHlzYXRvci5saXUu
c2U+OyBNYXR0aWFzDQo+IFLDtm5uYmxvbSA8bWF0dGlhcy5yb25uYmxvbUBlcmljc3Nvbi5jb20+
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIXSBldmVudGRldjogbWFrZSBmbGFnIHR5cGVz
IGNvbnNpc3RlbnQgd2l0aCBBUEkNCj4gDQo+IE1ha2UgUlRFX0VWRU5UX0RFVl9DQVBfKiBmbGFn
cycgdHlwZSBjb25zaXN0ZW50IHdpdGggdGhlDQo+IHJ0ZV9ldmVudF9kZXZfaW5mby7igIpldmVu
dF9kZXZfY2FwJ3MgdHlwZS4gTWFrZQ0KPiBSVEVfRVZFTlRfREVWX0NGR19QRVJfREVRVUVVRV9U
SU1FT1VUIGNvbnNpc3RlbnQgd2l0aA0KPiBydGVfZXZlbnRfZGV2X2NvbmZpZy7igIpldmVudF9k
ZXZfY2ZnLiBNYWtlIFJURV9FVkVOVF9RVUVVRV9DRkdfKg0KPiBjb25zaXN0ZW50IHdpdGggcnRl
X2V2ZW50X3F1ZXVlX2NvbmYu4oCKZXZlbnRfcXVldWVfY2ZnLg0KPiBaalFjbVFSWUZwZnB0QmFu
bmVyU3RhcnQgUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1haWxzOg0KPiBDb25m
aXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5nIGxpbmtzIG9yIG9w
ZW5pbmcgYXR0YWNobWVudHMNCj4gPGh0dHBzOi8vdXMtcGhpc2hhbGFybS0NCj4gZXd0LnByb29m
cG9pbnQuY29tL0VXVC92MS9DUlZtWGtxVyF0czNaMWY4VUFuVWF0TS0NCj4gYzJYMGFEN0g0X3Fx
empyeVNHMWpVdll4ZjFlUkJaODg2ME5rSW13c2k1dURVZ2hEbDlBS1htbXJDdEgzR2xSZ2YNCj4g
Z0NxVC00U2pSZFhPRzhfVFlFQS1LSk5hYkEkPg0KPiBSZXBvcnQgU3VzcGljaW91cw0KPiANCj4g
WmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiBNYWtlIFJURV9FVkVOVF9ERVZfQ0FQXyogZmxhZ3Mn
IHR5cGUgY29uc2lzdGVudCB3aXRoIHRoZQ0KPiBydGVfZXZlbnRfZGV2X2luZm8uZXZlbnRfZGV2
X2NhcCdzIHR5cGUuDQo+IA0KPiBNYWtlIFJURV9FVkVOVF9ERVZfQ0ZHX1BFUl9ERVFVRVVFX1RJ
TUVPVVQgY29uc2lzdGVudCB3aXRoDQo+IHJ0ZV9ldmVudF9kZXZfY29uZmlnLmV2ZW50X2Rldl9j
ZmcuDQo+IA0KPiBNYWtlIFJURV9FVkVOVF9RVUVVRV9DRkdfKiBjb25zaXN0ZW50IHdpdGgNCj4g
cnRlX2V2ZW50X3F1ZXVlX2NvbmYuZXZlbnRfcXVldWVfY2ZnLg0KPiANCj4gTWFrZSBSVEVfRVZF
TlRfUE9SVF9DRkdfKiBjb25zaXN0ZW50IHdpdGgNCj4gcnRlX2V2ZW50X3BvcnRfY29uZi5ldmVu
dF9wb3J0X2NmZy4NCj4gDQo+IE1ha2UgUlRFX0VWRU5UX1RJTUVSX0FEQVBURVJfQ0FQXyogY29u
c2lzdGVudCB3aXRoIHRoZSBjYXBzIHBhcmFtZXRlcg0KPiBpbiBydGVfZXZlbnRfZXRoX3J4X2Fk
YXB0ZXJfY2Fwc19nZXQoKS4NCj4gDQo+IFRoZSBmbGFncyB3ZXJlIGFsbCB1bnNpZ25lZCBsb25n
IGxvbmdzICg2NCBiaXRzKSwgYnV0IHRoZSBldmVudF9kZXZfY2FwLA0KPiBldmVudF9kZXZfY2Zn
LCBldmVudF9xdWV1ZV9jZmcsIGFuZCBldmVudF9wb3J0X2NmZyBmaWVsZHMgYW5kIHRoZSBjYXBz
DQo+IHBhcmFtZXRlciBhcmUgYWxsIHVpbnQzMl90LiBUaGlzIGNoYW5nZSBtYWtlcyB0aGUgZmxh
Z3MgdWludDMyX3RzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGlhcyBSw7ZubmJsb20gPG1h
dHRpYXMucm9ubmJsb21AZXJpY3Nzb24uY29tPg0KPiAtLS0NCj4gIGxpYi9ldmVudGRldi9ydGVf
ZXZlbnRkZXYuaCB8IDY0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9saWIvZXZlbnRkZXYvcnRlX2V2ZW50ZGV2LmggYi9saWIvZXZlbnRkZXYv
cnRlX2V2ZW50ZGV2LmggaW5kZXgNCj4gM2M3ZmNiZjBiZS4uOWI0NGMyNGYwZSAxMDA2NDQNCj4g
LS0tIGEvbGliL2V2ZW50ZGV2L3J0ZV9ldmVudGRldi5oDQo+ICsrKyBiL2xpYi9ldmVudGRldi9y
dGVfZXZlbnRkZXYuaA0KPiBAQCAtMjQ5LDcgKzI0OSw3IEBAIHN0cnVjdCBydGVfbWJ1ZjsgLyog
d2UganVzdCB1c2UgbWJ1ZiBwb2ludGVyczsgbm8gbmVlZA0KPiB0byBpbmNsdWRlIHJ0ZV9tYnVm
LmggKi8gIHN0cnVjdCBydGVfZXZlbnQ7DQo+IA0KPiAgLyogRXZlbnQgZGV2aWNlIGNhcGFiaWxp
dHkgYml0bWFwIGZsYWdzICovDQo+IC0jZGVmaW5lIFJURV9FVkVOVF9ERVZfQ0FQX1FVRVVFX1FP
UyAgICAgICAgICAgKDFVTEwgPDwgMCkNCj4gKyNkZWZpbmUgUlRFX0VWRU5UX0RFVl9DQVBfUVVF
VUVfUU9TICAgICAgICAgICAoVUlOVDMyX0MoMSkgPDwgMCkNCg0KVXNlIFJURV9CSVQqDQoNCg0K
