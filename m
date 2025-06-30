Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342AC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 10:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 478BB40264;
	Mon, 30 Jun 2025 12:15:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 99BA14025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:15:31 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U9NHN6022351;
 Mon, 30 Jun 2025 03:15:30 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47kf8uh2bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 03:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcjdD2hStbZc1+IZgOUkb9Hf+Xs5L4HV8+6MMWjYXPGcQ0sj14LYtO1u7JIjb/eV26xiJsYtezeKT7PRE7WDWn9oHSWy8PIrkS3Iaq+yaPgFboXWVLX616t1UO9TqlwcSVRhFKySy3jLrGbf1nqDcjfLdVu+meNTWKYz1l9Q+rd50GvES/7OCCQLWhvJE0rLWumpYucWhVV3GUpyRcBpQjj6+rth6YTP7nV1DpTEqTqZvtC4yfzvza02KY0j7H7K4fs4CggUbia/4p92Xnpl33CXV/fLfvG7t8hBttiW0ntboumime5d3wgCEoSeGIc+qqmZrxPH3pm9c1oeXLbsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3mouacZiNzHi9UCJO5k8+TupE6MLDWMm/wKlL38amk=;
 b=eBKOOkoiWaGWmvuK7n/WmGQLA4p+ABjmSkshuADfgBESOin5HTl7I4kw9ALnHoZFsUTtGu2fW7qZHLIJC6igCwn4hL3fRx3qmW+P1ZlCRGbEQlMGUzjQrbtf8aekuEfHQjIyVAobylcLZl/BuaFnBEerx48qqd3EmtCTffFPCxuAMb7SVMSs4nGlNa5zCc2hQ6oIaspb7i2Fcf7lOpHOtt9WG9Sz/Y+iBV6Ak3sggZgE5OgCpElV4UqilpNzbygZywyc1PRqu1UnHo7U5mS3vhbaf+F0Ml2kWNQjfwNs3fgMh957wGnanVLuo9qbbJ2dYrevBR4qEtaKASE2K9bQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3mouacZiNzHi9UCJO5k8+TupE6MLDWMm/wKlL38amk=;
 b=sel2FZsqQ6XkXy+SNBkzvZ3Crx0yPN4mHCaKDBH7oQCx7x/V6AXTefZRYsm2oyXK4CXHmo9CW5JPIz7CAXb4dte6fHlWICRJDLw43n3Wtgn/paY+DQBRIupwpnKKqgXDP5MHZqjnuNa6Kk3/9Mv2Pj2dsAidBm2GmKl7IAWKjzY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA1PR18MB5996.namprd18.prod.outlook.com (2603:10b6:806:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 30 Jun
 2025 10:15:27 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 10:15:27 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Topic: [EXTERNAL] [PATCH v3 0/2] uadk: realize async mode
Thread-Index: AQHb4ZRhfJRKGMn3Lku3CJTsGmr9zrQT0b3AgANe+ICAAWI8AIAC5TLggAASYgCAAACf8A==
Date: Mon, 30 Jun 2025 10:15:27 +0000
Message-ID: <CO6PR18MB448406CE61F820DE93117452D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484B2A6744F73A9196EB034D87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9Gg_dxLYg4FJi_J90NJw1F3ky3JwpnHMq-hhNdNfhPR7g@mail.gmail.com>
 <CABQgh9HRAq8ZFfacB3XZoA5QdyfOV-2NUW0Y=rpyxHuivktQEg@mail.gmail.com>
 <CO6PR18MB44841A3176C958FCD75E3AB3D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HRhMK02y8eCNMhmWYq0MqUbZxNgp=bCHzUmwYU8jUjZQ@mail.gmail.com>
In-Reply-To: <CABQgh9HRhMK02y8eCNMhmWYq0MqUbZxNgp=bCHzUmwYU8jUjZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA1PR18MB5996:EE_
x-ms-office365-filtering-correlation-id: e193baea-d3b5-4154-64b3-08ddb7bf08d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEVFTitQMjhJVkdpYWxKZ0JDYllpV0FVc2NJWDdPVzZ5NWdweC9NL0NndGN0?=
 =?utf-8?B?OVN4RUt2eXhCVHFndGxoTC9ERGxXc0VhRU4zVnF3c0Z4NytjeGFUMFFZUkNl?=
 =?utf-8?B?c3VINEV3blFJcGxpQno0cUM3N3V0YXNwa1FWTmQ0MFBQcW1jNjNJOHhjMGFO?=
 =?utf-8?B?MXJjbnZkRHpyWHRTNUwwM0liNEZBYUZuYXBZbE42UlVnZDMxWUhpc1d1TnVM?=
 =?utf-8?B?OTk5Y1ZoOWNPR2g1dXlnVllPbnNqN2VtcExLWkVHVm91UzAwSGpySGNUS1ZD?=
 =?utf-8?B?elBlSXRYODU5aUgvcjJXSjFQKzV4Rzl0OHFKQ3lOR0g4ZFdJVjRnMmJaWVdz?=
 =?utf-8?B?NE1vRjFHcE5ieWhhZ3o0dXZBOVRjY0xkYjEzYXkzQnFNMnRXNFViNFFiYU84?=
 =?utf-8?B?UGhwa0xpZ1JYanVPeGt5Q0ltMXZhTjNVZWtuRDhmblU2R2N0c3l1VUpJVUhO?=
 =?utf-8?B?SkU3S2hXV2M1ejlJd28ySEFzYkgzSU1laG5nUGNOM3NzT3RjeWtOY1F3SWxh?=
 =?utf-8?B?MkthOGt2YTRGTnFQMTJqaW1Qa1RGUzQ1UU5qUFFBamlkN3VtVTNVL2JBd1Fy?=
 =?utf-8?B?b3FiNVFTYkwyOXdGY1JGVDVweWdyQlBQNGJmR3FqV1dXTTJrM3Z3Y1ZvVkEr?=
 =?utf-8?B?b0E5Z0g1SG00Tk1PRlN2UTRabWJkeXhEZ2pVUVc0WWJlVlZJTkJkYnRMTEM2?=
 =?utf-8?B?WG5TMHZIM010dkNOTDlPL08wRnB1b3J5aHN0NlR3N0ZCelgxc1FCaCtkMHdZ?=
 =?utf-8?B?V1FqUW9uMy9rdXNXWmY2aTR3ekpsQjl0NTlmSzJ2U1RzcGc3M1A0cURqdjBk?=
 =?utf-8?B?K2FVUWwrYXdzU1pDZ2kvWkFiclNhUFNVVUhkOTNGbU1HN2tmYitCN0lWckhJ?=
 =?utf-8?B?VGNhR2JqUitQZE91OG0yOUowb29QRi9zQ3ZRcjJybW91T0d5S3lnTG1DWDUw?=
 =?utf-8?B?M0NqdURpNjliSEVWNno3T25QY3FMMTJmTFh0K2FEVFFJNHA0LzgrYjBURVFJ?=
 =?utf-8?B?WFBOVEdVYnJxakxwRytTMnRucUJ1dng5MHBZb0hZUVZEN2lHNFhsVEFCWXhY?=
 =?utf-8?B?QlpyU3pmZExPTlRFbTBNeWUySDFmUEptOUVQazlYckY0UWJSRGR2aWNiakg5?=
 =?utf-8?B?VHJWNnV1VmZVMS9PdDJJVEpmMjZPQUp5WnFPM0thSk1VM3BGQjA3RXZjY3Fi?=
 =?utf-8?B?Zm5RVHpCRjU3clBQVG9IVTNZY3ZKTi9Ub2xOTG1lS1hoL1JCK1hyWGFVelVG?=
 =?utf-8?B?Z1FkenM2RzJDODM2ZTFPaWQ1NEltdWtxSkRCM3llTXBlTEJzUkV4UFVCanJt?=
 =?utf-8?B?WUZ3R0xZZ2ozMUloSlVhQnYwSVk2QkNNekU1MDlFU1dlMlFuT2xUOHd0OU0v?=
 =?utf-8?B?RXZyT0lmbHdFc2FuQVV6VkJDcmRxVy8ySVdDRzR3ZjF2UzRzSDFZK2JsK1Rm?=
 =?utf-8?B?Rk9nTGJGNkM4aTJMQ2FCVnc5bGwyVXk0VURlejN0WFBydWdpcld2aWJzTExk?=
 =?utf-8?B?bzllTlcvUzhEL3dQNTkvdFdFYWlrWVovTWJjZEQ5ckI1dVpKVmJBcnU2d3VV?=
 =?utf-8?B?ZW5Ha2FJeWtLYkVhWG1NRGQ0RzRJQUFxbHJyOFpxMEh2a3BObmFTRko2K0hm?=
 =?utf-8?B?VHJ4aDR3allmRXlPZFNTWDloZndxRlBNVERvYjlRcUYzNXdqYWRGTFV0T2ZX?=
 =?utf-8?B?RUZGbUZYYnZIVUVraHRjVGV0amNlR1RMWStLUjRabEtFMXBMSDViS2ZFTFZE?=
 =?utf-8?B?RzU4WmdiTVZBSytFdTAxMGNhRFYyODJnUVNFSDRPcVltVTlMeXJNc2J2Rkdl?=
 =?utf-8?B?OVdrRWRjU2FGWVVMYXR6bUZXMFlKbXAzZzZ1cEhMTkxvR2hMazV4TnNhK3ZP?=
 =?utf-8?B?T0ZralZReUFVblFBNTRISUpQNlB3S3FXckJhRkQxZjBYMy9kV1o3eEZJeUFO?=
 =?utf-8?B?bC9SNlpSMmNVVlNEa29qYWFZdjVRUWVYc2lMTnRQZEI1am5uRURROXNzSWtk?=
 =?utf-8?Q?OCAPKWyQNW+4hZUjBWTawtj/idpz+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXJOdzl6c2FudytOZk5vVzk2L1Q0aFphWGpBRDh3Y01VYWZqeXl0OFdqOHVv?=
 =?utf-8?B?aTM4U3NidEdxVTIvRVdiVTliUnBDREVhNG1tVUIzMk9UZUFGenFFNXl0bWZK?=
 =?utf-8?B?MkRHWVFPcFhOa0FjemtQc21rdEJxamFhQXF6cWJQd3pZWDlXSnFHSlI5WGZz?=
 =?utf-8?B?RWFHNkF4b3hMdWhVV3dGS3g3N1pLMFY3MGpuSnF5NTE2Z2lzT21VVEZtZFRS?=
 =?utf-8?B?ZmpCSE91ekNlWlBGbVRjazVRNUNmK3oyd0JjcFA3eTZJY3VxR3BCcDVsWE1O?=
 =?utf-8?B?bVJ6Sk12dnBLZUZLaVF2aTZtS0taU2graU1rREd5Nmo5ZWszbElGTldLdGN0?=
 =?utf-8?B?anZoY1FSc1pkcUQ5TFFyU01FODRQK1hHNjI0WDVqNGdUdEcrdUNHSkJkU3JO?=
 =?utf-8?B?b1JTTkxmR0lhaUZQNXJJSUQzZENyU01DY1NEb3lMUXEwWlM0czBGYUR0YUEz?=
 =?utf-8?B?OHlhS1JhczhZaTlicnUwZGhuUmkrYzhUWmlXTDhFcm1OSCtreFpuclJMOXFU?=
 =?utf-8?B?SFR0TzFvd0I2RHhXZzBjeWpiekxqMkxCV2FUelh0dVlTR2RXQVV5MHJWKzdq?=
 =?utf-8?B?WGlvZzZkYlMrcmtJQkVSRHo2MFNyNzJ4QmFiQzYrbDQvb2JCd2hUcGFRY2g5?=
 =?utf-8?B?YXg2R1Z0UFg1VWRhdkRmMytxRG9KUW54cnNveHBnYTJNOTJSajlmTlpsNm9j?=
 =?utf-8?B?S0MwbGZ3TWJrMFJhaFBOSGZaN1Y0ekt5WmExeVhxMWgyaDNPQlJ6QU9Ga0Vq?=
 =?utf-8?B?ajFMYlJ0djRTY1JLR3UySTMwWG1HNzFGWS8vSHhLUlpPcEt5R0FGeEd4c3BV?=
 =?utf-8?B?dzd4WGx1SmFaSDdWRVlWN29NamRRd3F5d2Vyc1FlajdvcGVxS3FxcG5rMnBp?=
 =?utf-8?B?TTRvOXpwLzdNR2ZNUll3TlFNSSszRU8yUkEvR21yZjFUSFpERTFONUlnKzdp?=
 =?utf-8?B?L1BoR0MrcjJiUnNxODdFSnhjRXdKVi9iR3puZnRNWXhaWU5iMmgrVnArcmJP?=
 =?utf-8?B?eGIyTFBYNGFMeStxczJibEhHTTRQWXlWRWlCbDB4bFNKNVlyc1BoazU4Wkw2?=
 =?utf-8?B?cC8wdWJ3QTM2R0ZBYm9QWWNBMmF1bUZjR1U0MUNDSGRoZHhWeWowUCtSRmFk?=
 =?utf-8?B?bWJLL0F1QXdBVFA5cVVXN2tlakNvUTRFaEEwN0lhcEJnS3VPbE93bzhtS2E3?=
 =?utf-8?B?SWt6KzJGNkZJdXhHQjdnSm9vaHo4YWM0a0RXZDRMeVFSOWFwU0l2am1OMmVn?=
 =?utf-8?B?ck4zOHFESGVpUlhUK25KUjh5WmwzblRhWmJhd3FXSlAwVis2ZFFkK1lpa09X?=
 =?utf-8?B?ZnVQc1hvUU5VUCsvVWQ1T3QrMlM0SzkxQ1VCZ2czdUJZQ1ZCdC9Qc25VZ3Er?=
 =?utf-8?B?aHA5NTg2YldvWjkxVGh1V3JjbURGUHpRZmY5RDZQUjQwNkZRYXIwNWRSWmRj?=
 =?utf-8?B?d2o4THl3VGlYNEdZVWZ6SWJraGd6a29qRUtCRUxFSTkwdHBzYzdWSzA4WXA0?=
 =?utf-8?B?a2paaHVtV3U5MW1iUlI5K2ZwcmVBQmk1WE5OQ2g0K2JrYlBiVVJYNS9qRkF3?=
 =?utf-8?B?NFV4dWZpbnpCN0I5Z3RLd1ZDNkk4bmwrbXVWMk1yNlNBamdIM3pBM1B4Z3Uv?=
 =?utf-8?B?eHdRSWhYTVlrVko4dG5oQTlPSjRJcTlDYWxEaHFhR2J6MDhCRC94bWQzREZF?=
 =?utf-8?B?SEhnc290Z2Z3dGN4dldpR0JkZmErQk5ncS95VVE4TWJUSXBlOWpETlVQWkgz?=
 =?utf-8?B?M3QxVnk5MG0zRnhvRlVHTkZ1U2JycFpEQlYzZXlZTTVqbEtiQWtzWU0zVUFC?=
 =?utf-8?B?OWV1VTllbERCZW0yU01ZZkc2ekdwK0JsL2ZzT2U3Y1pDd2FZQTJDUUdpQVRX?=
 =?utf-8?B?NFU2VDZRYkttUGczRGZQV01hNUpjNnlZQjJXWHFsRk5qT3F6eVdCQ0YvU2hB?=
 =?utf-8?B?dUxNUkhnbFZJeDR4WjczbGF3aHdWdDRneWpSVGJENkZyOG9OTnF4aHdyeXdh?=
 =?utf-8?B?cmxzd1k2aWNwQVpubGJWdGVpUkRRcXZtRXRUS2RBK05Ya3A0WHdLRjZiTzll?=
 =?utf-8?B?cU9GbE9IYlJoSnJCVWFCWHM0dXpsQW1aSkxxTzlaV3UwQVBTemF4VDg0d081?=
 =?utf-8?Q?NBZM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e193baea-d3b5-4154-64b3-08ddb7bf08d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 10:15:27.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPWmzQXI8ilqMb+UM5aA/G3TpngKcRYU+iuhhghVjf65E8eLztFgBq+ym4waydBcZ4BKwIo5nw6uoZF21ffNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5996
X-Authority-Analysis: v=2.4 cv=N6wpF39B c=1 sm=1 tr=0 ts=686263c2 cx=c_pps
 a=KF8f92PZeEH78vqSuT/2EA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8
 a=Ifr-Sfzwdm7ujL06-M0A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NSBTYWx0ZWRfXzhfCpjCgi1Ex
 6B/oT8B40KX9EJMD0MWe0sXfkDOb79XDYfLB6KPAZCtxNs87Q+1rTE+jR7Rsmq3cN4Iv8Gmjc5j
 D5aXmLM/Y1VaQzwQZx4FwfT8ACGlfiC/P9i6gObrxe9yZqzUtykWx2IilBY/AS3C/beqsdXAcxx
 0Dz+UXfI5SvJINRjljlHqEJkIyQlSZuWcm61Q2aAekk5mQU5isVHCI/lFwm3EB7zjfcFMF8QyKS
 8sq3S7C3vM6WP6YwyJwP+hlc6Hs5eBhS1hqoqV967dFTcY3m9btNkCqxO3bC8Pbry8SPmmTs+JE
 JIsx8ZwdWRXw5ShgwT6bmvMOEiTbzkfHuovb7EnRjWRGA2AjeIqYMF5/1+YWmonu+GlQdXjzDjl
 iIU14+u3fPFlMaTafudPNZS/US7vvsZGQUln4+gkwibY9/frxpaInHV5dmY0l9SYAvJtaRHM
X-Proofpoint-GUID: Y0VjedGgh6jJ2Y1vaefD3pu9F_CoKpef
X-Proofpoint-ORIG-GUID: Y0VjedGgh6jJ2Y1vaefD3pu9F_CoKpef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
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

PiBIaSwgQWtoaWwNCj4gDQo+IE9uIE1vbiwgMzAgSnVuIDIwMjUgYXQgMTc6MDQsIEFraGlsIEdv
eWFsIDxnYWtoaWxAbWFydmVsbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiA+ID4gbWFrZVsyXTog
RW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS9nYWtoaWwvdXAvdWFkaycNCj4gPiA+ID4gPiBkZXBi
YXNlPWBlY2hvIHdkX2FsZy5sbyB8IHNlZCAnc3xbXi9dKiR8LmRlcHMvJnw7c3xcLmxvJHx8J2A7
XA0KPiA+ID4gPiA+IC9iaW4vYmFzaCAuL2xpYnRvb2wgIC0tdGFnPUNDICAgLS1tb2RlPWNvbXBp
bGUgZ2NjIC1ESEFWRV9DT05GSUdfSCAtSS4NCj4gLQ0KPiA+ID4gV2FsbCAtV2Vycm9yIC1mbm8t
c3RyaWN0LWFsaWFzaW5nIC1JLi9pbmNsdWRlIC1mUElDIC1mUElFIC1waWUgLWZzdGFjay1wcm90
ZWN0b3ItDQo+ID4gPiBzdHJvbmcgLURfRk9SVElGWV9TT1VSQ0U9MiAtTzIgLWZ0cmFwdiAtV2ws
LXoscmVscm8sLXosbm93IC1XbCwtcyAgLQ0KPiA+ID4gRFVBREtfVkVSU0lPTl9OVU1CRVI9Ilwi
VUFESyB2ZXJzaW9uOiAyLjkuMFwiIiAtDQo+ID4gPiBEVUFES19SRUxFQVNFRF9USU1FPSJcIlJl
bGVhc2VkIEp1bmUgNiwgMjAyNVwiIiAgLWcgLU8yIC1NVCB3ZF9hbGcubG8NCj4gLQ0KPiA+ID4g
TUQgLU1QIC1NRiAkZGVwYmFzZS5UcG8gLWMgLW8gd2RfYWxnLmxvIHdkX2FsZy5jICYmXA0KPiA+
ID4gPiA+IG12IC1mICRkZXBiYXNlLlRwbyAkZGVwYmFzZS5QbG8NCj4gPiA+ID4gPiBsaWJ0b29s
OiBjb21waWxlOiAgZ2NjIC1ESEFWRV9DT05GSUdfSCAtSS4gLVdhbGwgLVdlcnJvciAtZm5vLXN0
cmljdC0NCj4gYWxpYXNpbmcNCj4gPiA+IC1JLi9pbmNsdWRlIC1mUElDIC1mc3RhY2stcHJvdGVj
dG9yLXN0cm9uZyAtRF9GT1JUSUZZX1NPVVJDRT0yIC1PMiAtZnRyYXB2DQo+IC0NCj4gPiA+IFds
LC16LHJlbHJvLC16LG5vdyAtV2wsLXMgIi1EVUFES19WRVJTSU9OX05VTUJFUj1cIlVBREsgdmVy
c2lvbjoNCj4gMi45LjBcIiINCj4gPiA+ICItRFVBREtfUkVMRUFTRURfVElNRT1cIlJlbGVhc2Vk
IEp1bmUgNiwgMjAyNVwiIiAtZyAtTzIgLU1UIHdkX2FsZy5sbw0KPiAtDQo+ID4gPiBNRCAtTVAg
LU1GIC5kZXBzL3dkX2FsZy5UcG8gLWMgd2RfYWxnLmMgIC1mUElDIC1EUElDIC1vIC5saWJzL3dk
X2FsZy5vDQo+ID4gPiA+ID4gd2RfYWxnLmM6IEluIGZ1bmN0aW9uIOKAmHdkX2NoZWNrX2NlX3N1
cHBvcnTigJk6DQo+ID4gPiA+ID4gd2RfYWxnLmM6MTA2OjQ0OiBlcnJvcjog4oCYSFdDQVBfQ0Vf
U00z4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzDQo+ID4gPiBmdW5jdGlvbikNCj4g
PiA+ID4gPiAgIDEwNiB8ICBpZiAoIXN0cmNtcCgic20zIiwgYWxnX25hbWUpICYmIChod2NhcHMg
JiBIV0NBUF9DRV9TTTMpKQ0KPiA+ID4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+ID4gPiA+IHdkX2FsZy5jOjEw
Njo0NDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBv
bmNlDQo+IGZvcg0KPiA+ID4gZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQo+ID4gPiA+ID4g
d2RfYWxnLmM6MTE1OjQ2OiBlcnJvcjog4oCYSFdDQVBfQ0VfU0004oCZIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzDQo+ID4gPiBmdW5jdGlvbikNCj4gPiA+ID4gPiAgIDExNSB8ICBpZiAo
IXN0cmNtcCgiKHNtNCkiLCBhbGdfdGFpbCkgJiYgKGh3Y2FwcyAmIEhXQ0FQX0NFX1NNNCkpDQo+
ID4gPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn4NCj4gPiA+ID4gPiB3ZF9hbGcuYzogSW4gZnVuY3Rpb24g4oCYd2Rf
Y2hlY2tfc3ZlX3N1cHBvcnTigJk6DQo+ID4gPiA+ID4gd2RfYWxnLmM6MTI4OjE1OiBlcnJvcjog
4oCYSFdDQVBfU1ZF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzDQo+IGZ1bmN0aW9u
KQ0KPiA+ID4gPiA+ICAgMTI4IHwgIGlmIChod2NhcHMgJiBIV0NBUF9TVkUpDQo+ID4gPiA+ID4g
ICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fg0KPiA+ID4gPiA+IG1ha2VbMl06ICoqKiBb
TWFrZWZpbGU6MTA1NTogd2RfYWxnLmxvXSBFcnJvciAxDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBz
b2x2ZWQgYnkgaHR0cHM6Ly9naXRodWIuY29tL0xpbmFyby91YWRrL3B1bGwvNjc5DQo+ID4gPiBX
aWxsIGJlIG1lcmdlZCBuZXh0IHdlZWsuDQo+ID4NCj4gPiBTbyBhcmUgeW91IGdvaW5nIHRvIHVw
ZGF0ZSB0aGlzIHBhdGNoc2V0IHdpdGggbmV3ZXIgdmVyc2lvbiBvZiB1YWRrPw0KPiANCj4gSG93
IGJvdXQganVzdCBhZGRpbmcgYnVnIGZpeCBwYXRjaGVzIG9uIG1hc3RlciBicmFuY2guDQo+IG9y
IGhhdmUgdG8gZW5zdXJlIHRoZSBkZXBlbmRlbnQgdWFkayByZWxlYXNlIHZlcnNpb24gYnVpbGQg
bm8gcHJvYmxlbQ0KPiBvbiBib3RoIHg4NiBhbmQgQXJtPw0KDQpIb3cgaXMgdGhlIERQREsgdXNl
ciBzdXBwb3NlZCB0byBidWlsZCB5b3VyIGRyaXZlciB3aXRob3V0IHByb3BlciB0YWcgb2YgdWFk
az8NCk1heSBiZSBhcHBseSBhIGhvdCBmaXggdGFnKDIuOS4xIG9yIHNvbWV0aGluZykgb24gVUFE
SyBhbmQgbWVudGlvbiB0aGF0IGluIHlvdXIgZHJpdmVyIGRvYy4NCllvdSBuZWVkIHRvIGVuc3Vy
ZSB3aGVuIHNvbWVvbmUgcGlja3MgYSBwYXJ0aWN1bGFyIERQREsgcmVsZWFzZSwNCnlvdXIgZHJp
dmVyIGNhbiBiZSBidWlsdCB3aXRoIHRoZSB2ZXJzaW9uIG1lbnRpb25lZCBpbiB5b3VyIFBNRCBk
b2MuIA0KDQoNCj4gDQo+IEl0J3Mgb3VyIG1pc3Rha2UgdGhhdCB3ZSBpZ25vcmVkIHg4NiBwbGF0
Zm9ybS4NCg0K
