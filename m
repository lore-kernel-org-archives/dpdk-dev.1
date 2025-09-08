Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627EECA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 06:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63BDC40264;
	Mon,  8 Sep 2025 08:21:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DC462400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 08:21:18 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NneUs022153;
 Sun, 7 Sep 2025 23:21:18 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 491kt3ghnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Sep 2025 23:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBkxf6QqT7XwUk5GbKcW1y8xRBq32H6BH/CASKlqtpICRCldyroBRv4PZ2H46k3PnSOVK8yGqHKss8jF5lp8lUjPptOC3ormxv1fMyd3PlZC8B/rRCCo9DxaWAI2muKQKWh2+nu/HJN3LsI2+95GjfLD9J2JneFxPeKPwy4cMY9y3tSoI0LN71FsIRLjno+Xj7XewHp80JrW+KWJ9CPhw/bQv/6TG5rSlg+nyz/Ygc1LdAtkMGGn+2mS5EFqcuQNRC8WOv/WZeGkOKEitZg0MlMOHrxo7iVBAmaVULWuUQN3E4yqouDpiAa5BL6nUlwVdRI5pOiLobWZJNUVrrjR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/NG5AH8j5RuZHa16eRSRu315Wm5S/Hu9bnkS/12fKI=;
 b=xNneJXapMwuD91jpZkkdGBbsfENWgYh80nFoyPH3iKUHlDMBzU+ELTP3HJjSQAub6VSpWtGR9MroAoUQpxZ3UHl0hzEMLHPEq6AmvPRRYc1BOtj0bvDwYauy6x0Y4zD1OKhA6P/3fqe0N0XIGtka16akI17VCCQgsrc+kde9gEC+W3y9o3Iw2vpbyPAfDdjXg7CX/GP5vkoMV7GD94lUS95NGk59T/OyCyYfaO+szo6Mk/FKZZcWYLvT/uRq9UtUIzKn4JvSNMzPIaOyfYkjPvGUfEhspyHg8bzZtnHg8VqYi7Yvd09BGp3FqnyLunqsmZPYWJaVMeXv8KrUGDlzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/NG5AH8j5RuZHa16eRSRu315Wm5S/Hu9bnkS/12fKI=;
 b=H74rXP1gT30Ssg+OpQi73EApX1TKhjeMVyux9F8J5HbCJzgZHw0V5qw+4zrFkQrMJIXG+XK4CriOrgcv9wRfgbHFlia233rGUquyeDdOFqFK/BLC4bUpCRx0SDAeWBRlcXoRClQodCIPvYGEjZtbJARJjWwmR9h/C+mn0Dip3Pw=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by MN6PR18MB5542.namprd18.prod.outlook.com (2603:10b6:208:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:21:15 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:21:15 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v9 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v9 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcGwO/FZOKTPgtzESKg+7BGsIq87SGd6cAgAJjn5A=
Date: Mon, 8 Sep 2025 06:21:15 +0000
Message-ID: <CO6PR18MB38603CA5F647B375807604B1B40CA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250901054552.813195-1-skori@marvell.com>
 <20250906105116.427529e9@hermes.local>
In-Reply-To: <20250906105116.427529e9@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|MN6PR18MB5542:EE_
x-ms-office365-filtering-correlation-id: 6c1c221a-d9ea-4764-c1e7-08ddee9fea39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2NrdHlqTTRwTjlkRHp5azFkb2hUdDBLS0J6NmRreVB6ZW1jYkR4SDNRTmo3?=
 =?utf-8?B?cEpFNFhQOFhZYTNCNTJ1RmRWRTMzamtnRkFsYkNMN3prdGdTdW1LdHRDcWNn?=
 =?utf-8?B?S1VQSDhYUEZGQXljcHdobjZTU01RbVBDa0tDaWd5d0FiNlZBMmw1T2R4Mkxz?=
 =?utf-8?B?dTlYUE5mTjdDRHVMc09DNWRKWW5TNk9nUTJ4U2V5eDVnWnlhLytkeWlFbUlo?=
 =?utf-8?B?VEtDcnhkMEZ5VHhMcVFzZi9zZHEvQi96d0ljQkNadmFBTWJGVXROd1FrZTRv?=
 =?utf-8?B?YkZ3RUs2SjBUbjh2am5DQ213enZWSitYR0tYV3N4L3VqWmlNcFpyTk51ZzEx?=
 =?utf-8?B?aWxIWStVbFBVTUYyZ25LallLcG5XdjdlL3BvOEhacUJaVVF2bDQvWTlHczFF?=
 =?utf-8?B?STh2L3BjN3NUM0hMVnNUQW1PV0tyUS8rRmE2QmJpdkxmenFRMTAwZVpuWkJs?=
 =?utf-8?B?ZmYrNUo0Tm9MVWphZDBlZHRLYlMxY0VjbTJHM0VhQnRNRW9sY3c4UnNjOEdU?=
 =?utf-8?B?bjkwaXFhWEZPM2lGeWZmRTRpSEpqd1FOZTVxbkhWSDFDSCtobmxRMmpyeTMz?=
 =?utf-8?B?eTlSNXZWUFdFWTRSaEtPczdnSVVUTFY4UjdrRjdkK1pQMWR1N0JUWWpGT0xm?=
 =?utf-8?B?WWJUUGgxd0JtNFdpN2p1UTM1RmhsaGxIRTNVaStIaStxVk9nQUhmTmxPK0hn?=
 =?utf-8?B?d1Z3bG80YitHMjE2dU54dnlnL0o5M3J1OWpjbzBjM3BPN3NkelFwdnUvaFJY?=
 =?utf-8?B?N1hhR2pVbTBHbFI4eVVBQTlzUGRjYkx2UzNNQzRUZDVCVm0vZ3RITmJzbkVZ?=
 =?utf-8?B?akNpWmNxU0kzcmc2cGxycjc3RnZBaXh3OXQ1SCtsMGRxSElxKy9uRzNPQnVX?=
 =?utf-8?B?L2lHeUIzdjB2RlhZWURVb1JtV1dIWDR6ZUV2eklCWFpZZk5LZjB6bE9YZEs5?=
 =?utf-8?B?VG8rQmFRYk9zc0ZqR0ZubFEyQmh6OHBxUkFOSFB1emNDSERDdExSZ1N4RkhB?=
 =?utf-8?B?VDhoaXVzdmJ6TXRmNlFOcjdEck1CMWJmTkdyWDZYT1VBVFQyOW1wbldjYkJQ?=
 =?utf-8?B?LzZGZW12VHZUMXQrdzRZa3UvcDM1Y3RKNDhzb0s1OGw1ZUxuanB3bGlraDJ4?=
 =?utf-8?B?VFdjWldoREtwU1ZkcjAwd0pFd0ZXL3VkUjU0a2pLUUZ2TjFLVDZHS3o3TnFG?=
 =?utf-8?B?OVhEaXdrTXFITGRDSVpqNk5PeGQxazdvMUt1YVNNWlBvSStYYzRrRTRPSHda?=
 =?utf-8?B?VmVTeVFXN1lYbjZieThhTHg0RHVZSnRRbjY4RlVpcEIvQ3M3eVFSaUs4bUQ0?=
 =?utf-8?B?K1BiTzRkZjR1R0dsaU02QnNjaWtHV3RXU1RiK0NjZTVLSWZWUFBJanJpbUZv?=
 =?utf-8?B?d3crNmtFSWhueURHbGFobWd2RGJqYTU5N3lJYkdERGQ1Q2lkT3Y2Q0ZJNDhE?=
 =?utf-8?B?cEllSy9EdkVVcW11WDg1Z3pjTk42eHh6VU04TktOQnZqNCtkQlYyL2h1RGFH?=
 =?utf-8?B?WTllb0NxS2U4U3hXUTRveXpQck4vTnZyOGEyREJjYXUxR2VCNVpSWk5Nb3NZ?=
 =?utf-8?B?TzlsVHlLdFlNaW9QQkdTamNPNGpPYUhJRTM2UUJsOVZxUjdsR2lvRmY1NXdU?=
 =?utf-8?B?Yi9HUjlTUmZTbk8vREJRVzIrYmU5OFdmZ2RQNUNBY1BFcWx5YkJ5a3dvY2ZD?=
 =?utf-8?B?ck5FM2ZHRXBVTW44eHYrSjNscWgveDRRblJLKy9yd1ovS2JUWmNhdFlnQlVl?=
 =?utf-8?B?VjBlc0ljQjVzdi9zTkpRcnNZS3MzQlR2bStUZGFuN1M4SXUwaU9mUlZYTDZ4?=
 =?utf-8?B?dk1YelRmY0t2T3dlYWJ4Z2FMcG1jZ2ZOTnhEbDFlTGUvTDdibW9naE5obHhS?=
 =?utf-8?B?YnI4b2kzL05QNUFSbmc2aWRFU00zTi96WGNDTEc5eXBnUERWN1AvMnZOcTEv?=
 =?utf-8?B?YW5VWGowL0RrdXRTY1N0aGZTaG96eVRqVEhncWFVOVN6R1dTdFljOW9vbE96?=
 =?utf-8?B?RjlsM3JPd3B3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC9QK0xWUGZNRWtscjhvL0p5aXgwQThhYkpqVlhvUnVnMEpROFBlMjlZVjk2?=
 =?utf-8?B?MkR1Z1JMRXBOTXpjMk41c3l2ejdCaWRKakNiaFhYcEZkT0VFRG9kK013SWkw?=
 =?utf-8?B?TENBWEIyMEp1YWR0aFZ6dlJWYjVzQVFoN28xczgrSlNsaVVQemViU3Z3S09i?=
 =?utf-8?B?MnlaWk1ONDdFT3dVUDhyMkFCYUQ2MEhqaFdRc0doQzhNbTBCK0JZN3k4d1JS?=
 =?utf-8?B?b09sZFQwcGFMR3drYnNyLzBEOU04RWczM3dkT2tWT2J2TG1WdXlNNU5VTUN0?=
 =?utf-8?B?ZnY5ejhSU2N2SlV0Y1Vsb1c4RmsxWFpIbDVuVFJXVlBIeit5bFowZG1oVWoy?=
 =?utf-8?B?ZHZMTVFYUlFMOVRIQzV5czBpQnNicEEzNzdWNlpIZ2lRSUpFa0pxeGpsa0ZT?=
 =?utf-8?B?cnorNWE0TXB1YmJpZ0VxMW5SOVpNa0NVbEFuL3Q1YVU2UHBrRDdjVllObFo5?=
 =?utf-8?B?NFNHaUh0Z2tDeVZkRm8rR3czSHg2WlQ5RlU0UlZFK2JLUi8vakt4dCtrNThC?=
 =?utf-8?B?UXhXUjNwVTYrWVArZzN1N3A5YitycnRod1pGTkROOFdnRllHMWRFM0dPd0Fn?=
 =?utf-8?B?UGk2UlBra1hDUjJUOThBZzZUSjUzZUQ2cVZ6cE9xTTN6ZFhrL0kxVDFSMWYy?=
 =?utf-8?B?L2FIUzNIVHcxZ3BWSVIxUmFmeVBCWmp5WjVmSE5Tam4xQmxLZ2J4RjY1emps?=
 =?utf-8?B?d0ZWY0d6bGhjN0VHYkJ1RWNmL3F4emE5Y1dZaXY2YkZmdnEvL0ZuenhBUTVY?=
 =?utf-8?B?Z01aWXlJUW1UN04vcFpWSy9JdlhKamZld1FSK1lQempsT2NSdGhhSm16NzRk?=
 =?utf-8?B?bWlkTktYWGx4dGlSNSs4OWdkU2FnR1ZSeG5MMHoweTh0N01IQTlJMjBsM1Iz?=
 =?utf-8?B?RTg1QkRuWEI3RGpsSG1OWXg0WU1jY2xkenpoRWVnYkdNQU1uZW1xSklBM1JJ?=
 =?utf-8?B?OWpLaHlwWHBZbGdjVzU0b1I0eFhNWmQzUGxZdTY1LzEyYURhR1RFTlRmbjd5?=
 =?utf-8?B?Z3l4eDJ0cVZlU1JMdzBwYWhsTzROVDFBdjZLY0Q1RXFwcnZoRlZyYm1IaS9h?=
 =?utf-8?B?cTQyQlVKNjg0QXRRalVaWEFJNmdOTTByU21PVTFPTWZGT2JJZXBqUzZPT2Vl?=
 =?utf-8?B?WVA0MTdGSTdrL2lvUkpuQm16Q3hkOEljeUtUUWNUazZ2OThCNlZjZmdyVVUz?=
 =?utf-8?B?SGZPZG9YK3QyOXZQeDlQcGNudmp5aXlkc0ZuMGFEMW8wRkVGTXhxclgyN3k1?=
 =?utf-8?B?bkNkRG4xVlAvQnFRdkhkRVhXK1hpQ0NxRUhuMk56NHdYcjJ1M3ptc3k2UHBO?=
 =?utf-8?B?YlFoRjFJbXVXaU5ZN3l5bU56cW50akhZK2JuNStFRkc1MnlWeEsxZkRNQnRx?=
 =?utf-8?B?WWRqUEtMdUF5ZjNleXVyR1NwL1ZoMDRrZnZ0Q0FpUXBCTUpFSzdCbHhkOTgr?=
 =?utf-8?B?eVpUTUhPSDByQ3RSNG90WTZyY093MDRYOHM3QmZrbWpwSlZlY05BOEFBMUMy?=
 =?utf-8?B?SE9oaGovYW9FcjVLc2NBd25RUHZZUElVSWhSTEF4NEwvbExiRWlyalNvNGhi?=
 =?utf-8?B?eS9xRzhEd0lQUEUybStDdnc5ZGNrWEJtcmd0YTNpQVdERHZZR0tlZmd6NFpk?=
 =?utf-8?B?a2pKdGJ5d0UxWnVnaUZXRDhUUnhPZFI0SGR4UXI0RXEvVzdDR0FxbDE5aTBv?=
 =?utf-8?B?VGdHNGg2VXp4dm4xaDZiekM5MWJsUi91aWZremtaekpaSDczaDRZc0tWR3Y2?=
 =?utf-8?B?dTRuaVNZSndtTDNNV2I4bkVObitwK0VtN3NuTHBNVWI2L2pwTFhFcWJPMkgv?=
 =?utf-8?B?am9hZDRsbjU0SjdNMmV4dWJXd1g3d1JHckxNTlVpeEZQL1U3ZUtEM0NxaUJM?=
 =?utf-8?B?eXppbndSSi9RSncvUjRwNi9WWk1RckpuamFBZVc4TVhVTVdKZUI2MEFSUm1t?=
 =?utf-8?B?OG5NamNBaEtvUE9VOW1KSllKWFlFbnJTbmZqOW5TME5vTzdVaDFTUEZ2V0lh?=
 =?utf-8?B?MEJNTGhvZzR5TGlQZzcxM0pHOWlUR1lqNEFNTE40OUNRWS9KTWVVMTNEOTFk?=
 =?utf-8?B?YkZpdFpRa2taU2pIK3ZmdUVOSHJRSHh2SVhCWFVIaHJGN0xiTkp5N3I0STRi?=
 =?utf-8?Q?oszI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c221a-d9ea-4764-c1e7-08ddee9fea39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:21:15.2865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twrUxZPSe8UK5Sgzy8tEQELwl5fXtbmTYJ9t0MfwsAdnwC6niwWBGsm1JYMcE1uv9bAV97m0JBtJA7PKkuSCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5542
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDI0NiBTYWx0ZWRfX9L4YFqFcWP5g
 7Y4pZ2D8xXiI3RvHLXayUFQ9R0Ms5wyZ+eKN3pCWUoCCdXx8juVzmCDU77ixmxU6c0QGB6gHTnP
 JZFTABz34ch3FT1QdTmi9rgyhOT3GyA+3g38yts0keVTyWQ0d7ygUvuacnSyyYwWWjtPLICPzVb
 SkHP+m4RxPOP14xOpC22XnYImwCA94pd4f0qiTq1V0OxWoMcVmo5kJvrE+EUOBxTU70vcOMin5j
 ZoUy4dOBlXJfpXlC29abQKGy275AUehB/4BTdwpUF7zr9sgDqXP8DVOtLtANDPC4SBruqPDrEBw
 k5GppmWGz5vwWXlgbE07JII3d2vfKk2QEk+w9LNyHA33sxGlBy24L0kK06zyrKkutCRWuCb9ewu
 wQA4u2sC
X-Proofpoint-GUID: GkzRErRll4SCoLTHJ-pi9dMtSI-_uC6_
X-Proofpoint-ORIG-GUID: GkzRErRll4SCoLTHJ-pi9dMtSI-_uC6_
X-Authority-Analysis: v=2.4 cv=H9Dbw/Yi c=1 sm=1 tr=0 ts=68be75dd cx=c_pps
 a=6wgRmHCTc6xn0E0miKewiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=ePXPjcMqR0n9aLrdoBIA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
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

PiBPbiBNb24sIDEgU2VwIDIwMjUgMTE6MTQ6MzQgKzA1MzANCj4gPHNrb3JpQG1hcnZlbGwuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogU3VuaWwgS3VtYXIgS29yaSA8c2tvcmlAbWFydmVsbC5j
b20+DQo+ID4NCj4gPiBBZGRpbmcgbGluayB0eXBlIHBhcmFtZXRlciB0byBwcm92aWRlIHRoZSB0
eXBlIG9mIHBvcnQgbGlrZSB0d2lzdGVkDQo+ID4gcGFpciwgZmlicmUgZXRjLg0KPiA+DQo+ID4g
QWxzbyBhZGRlZCBhbiBBUEkgdG8gY29udmVydCB0aGUgUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9Y
WFggdG8gYQ0KPiA+IHJlYWRhYmxlIHN0cmluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5p
dGhpbiBEYWJpbHB1cmFtIDxuZGFiaWxwdXJhbUBtYXJ2ZWxsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTdW5pbCBLdW1hciBLb3JpIDxza29yaUBtYXJ2ZWxsLmNvbT4NCj4gDQo+IFRoaXMgdmVy
c2lvbiBkb2VzIG5vdCBhcHBseSBjbGVhbmx5IHRvIG5leHQtbmV0IG9yIG1haW4gYnJhbmNoLg0K
PiBQbGVhc2UgcmViYXNlLg0KDQpJIHdpbGwgcmViYXNlIGl0IG9uIG5leHQtbmV0IGFuZCBzZW5k
IG5leHQgdmVyc2lvbi4NCg0K
