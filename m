Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FA1C54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 06:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBCEA4027A;
	Thu, 22 May 2025 08:12:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5AAD640144
 for <dev@dpdk.org>; Thu, 22 May 2025 08:12:57 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LNWAFo010026;
 Wed, 21 May 2025 23:12:56 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46srka8kef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 23:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt+CRHqzoo0AlB9K87V0GtQ1256NVKaLLZAEUjZp49cr9giyPPxIExRFKxOX9erl3YaU1cP/IG/cD78byf7njSKch/Ksub+sUAZzygbYzf7bQbVk/MRDnUcVTmfEboWeKOjDJb7ZiFH77lJ/NlKsR7gvgcEMfpvu8NsjtPQ1rxy0mq58jGjUy/aJcbqlqcBLIZ2uMET2jjhC2Iahi0ydiDvMLyPMp3TUukBbrdAEhJwFL6eoyKBuBNHN0hxsc5MtihLCWZA9s5PxvNlo3GreBACkhE9tT/J0hxaNrijc64ovasi4FtOgjBbevSV+5H+pB/NAnJT7MLFIBZiCgkoLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kcYSrYHRS9X8EdHhbnRb5UN5ydcppdRTEHsCYBXVHg=;
 b=mEVjUMG+9c5mRwzD3Exg5QmFnmVxy+94woZFC8z8nLNLOs95o/nqVNIenYo/ReOdemc6XG0s35wla/hb702YRy6aWvGZc3AhqLaIoMXRDkVD2PcrkwKtpN9QvH1P4qUtKhcdku7x0zYeq8TEROc+u1LPpEdnA0dPZ62WByB+5bGcWaJegD10hFs8mM9Zr+CeTwoGpKSnHNbQOIkCECRfO/6Xms3V0kXpNcwGe8H0fhTC8h+gOJBnOl/3mmV2uPucqYhUMprB3IPF4g2eWBuSfxlSkno4DUsTTNQX3fCIYiQLwDhhiiBLtm15w4YCUkXuBY9QJPwokZd2rBH+NAvhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kcYSrYHRS9X8EdHhbnRb5UN5ydcppdRTEHsCYBXVHg=;
 b=Myn/vC2D5A8sIHcHzbn5cvcf+HR1Ze0vtFphEweOu4I1dR/wWeM3YTClZn9yKnENgR0R5uO8K4cAeL98EX6zSsnhTl/U8KjxaoyrtMAV6rh6JJKWdE4v8Ft/ayLW2uKoaPZiRfjQnRDLcwo5Qo6VVH1JsCENlEgzyVKmWF7L+IQ=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by DM3PPF09A669757.namprd18.prod.outlook.com (2603:10b6:f:fc00::687) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 22 May
 2025 06:12:53 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 06:12:53 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: huangdengdui <huangdengdui@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/2] net: fix offset calculation for
 GENEVE packet
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] net: fix offset calculation for
 GENEVE packet
Thread-Index: AQHbyg7k5Mpvp2znZ02ovduoUGepnLPc0tQAgAFYeLA=
Date: Thu, 22 May 2025 06:12:53 +0000
Message-ID: <CO6PR18MB3860D1A06FA62129E77B22A7B499A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250519160711.4024414-2-skori@marvell.com>
 <20250521051154.19595-1-skori@marvell.com>
 <c6f6d3fb-2ecd-422c-b803-aa0af0b9096b@huawei.com>
In-Reply-To: <c6f6d3fb-2ecd-422c-b803-aa0af0b9096b@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|DM3PPF09A669757:EE_
x-ms-office365-filtering-correlation-id: 74cecf55-0de5-4b01-04f7-08dd98f7b026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHFsUGdmSEVlMkk1emd4bCtFWWpDOG4zbFZ0L1ZFdGdzRFJiVUV0dFBWcjZx?=
 =?utf-8?B?c1RJb2pZQVo5NlRKK01qK3ZabUF1ZC96ajFPaUMrcEZyUktjblgvZU50dU40?=
 =?utf-8?B?bnV1OThwbUZjQzZoSlRJdFcrT3M4eUVZd2FyR0t0MmhiZmxrb2JwZzAwUnJ0?=
 =?utf-8?B?eTFad0lIaGdGUG8ydGw0VE8rcHRnaUNXZTd0VVdteE83UmwxaHdHVnhJQzFr?=
 =?utf-8?B?ejRmL2RqdWJaK0FHbDhLd0dZTW9hRzJId0JDZVJkTkRkQ0llZkhnZVplTStU?=
 =?utf-8?B?TFM5NncxLzlHMHo2YU5uZ2U4WE9rZUdpck54dTBwMjdTZis4aHNLRDJ1cUJQ?=
 =?utf-8?B?UTFMeVNPcytsU1FNTUFISW40MC9rN3h1T212TUxWK1VZM2NtY2s1RGJ1eFFF?=
 =?utf-8?B?Q0lTeWdKODg0eUJGYThlUmtCMFNOU2c2NDRqaXN1c3VpUTFsV0pHcm1ib1Zz?=
 =?utf-8?B?T3JZR0cxdytLN1FJMEJoM3kwSnl2S1Z6NVNYVHhxNFd4QXFKb2xZNEpvcTA2?=
 =?utf-8?B?SFc1Ny9GclpHZVI4eStKdWsxSFJ2NG0xUHduK2VsU0RaS21KZDQ1L2JnNXlT?=
 =?utf-8?B?Y0Vpb2VpVk5ZUHhmb1pzT3BBLy9kUUtwSTVmMHZCWGFJTUNYeVdlSzd3L3dn?=
 =?utf-8?B?R1NhZmJZWW1xaWJMUld5aHc2RmNyUnNSR093U3FwSGxSQkszR3hIbFR2RjZG?=
 =?utf-8?B?ZHpqUjVjNFdFV1FvSUU4V3g2RS8yOGVNMFM2NGpEQzFOcFA3anluUUdRaDNL?=
 =?utf-8?B?ZXFhelpWMVZZbzNUdm9XdjNMSHNPNVBQU3RnYllKSmM2NXdqNDNhdzdqRDZs?=
 =?utf-8?B?eWRXMGhkRGVZczk4akhMUnZmVUU0bG5oL05xTnBRZzJlTDBWRXZWT3hyeVNv?=
 =?utf-8?B?dUNxNkl0Y2ZtbWk1YkJWWVg4Uzhta3Nla1V4UGlkTzV2NzFzK21hdWQ3YWpo?=
 =?utf-8?B?VExpbW1heWs2RDJ4NnRtNUJ0SWxkVDRzNnJvSlRXZ1YrZlFPOGlUMnBRV050?=
 =?utf-8?B?OWNubWViQThqUWhGZnUvdno5U3N1dUp6VnMwMTYvTnloNmwwbGRUekxxaDN2?=
 =?utf-8?B?OFc0WG52RW1GcGw4ZnR4MDVCcHdGSmhrVUZYNU5DMW4zeGlnVU5PbWpUbytE?=
 =?utf-8?B?dEsvTWt5R0c0TDVUZ2lnVU5xSFY5T2FUZVNjNXFVblAwMHU2dUVBUGFnUUI2?=
 =?utf-8?B?SEd1OHlzbk1lQUVZeDd4alVGd3BkYk9kc2pWKzVBazRzR3MxSWdCYXNMajUv?=
 =?utf-8?B?bzNSUVU5ZGNaZkxvd3cxOC9VREJvdHBmcCtCcmltbGcrUGFKTzFndzl1TmVF?=
 =?utf-8?B?WEdyM1BWZS9ia3pMOEo0dkdiaGFlcEozYlJWRW1MRTdXUmVMVGpyRWovNVo4?=
 =?utf-8?B?OW03NnZIbTJlT3ZSOEl3S284a3VtZ0Q0N2g4U2szOFRrRGM2Q045TFdnSDkx?=
 =?utf-8?B?aXFTQmJkRkppd1prT29CMk1vU3M0bnA2Q2E0RlhrdVByYTlNWHV1d2UrN3ZF?=
 =?utf-8?B?Rk1xc2JpcjMwU2lWYWhBdEVvKzhCcWg0QmdYRXFqUWhyR1c3VXMyZTJzb0Q4?=
 =?utf-8?B?MnRqQndpOFhYd01UZTZDTHkwUHJ2ZE1pYk9KempFVENWREJyMEVQRDA2OElF?=
 =?utf-8?B?UkV5bjY0bGxmaGFBc1JWaWV4M1dvS2xqRldUN1VuQnhLVUdRMjlnZnFrRXJj?=
 =?utf-8?B?YmhqTm9YdDZpa3lPeUN1NStURjFrUXliSkJwcTE1WFp3aVdkbCtVNTNwRG1u?=
 =?utf-8?B?dXFCT2hlQXFyNUMwUnVRVTBTMGo3MXNTa0Zwdy9pc3Vmc0dtU3NoVXdSNXVC?=
 =?utf-8?B?dnhETU03VkFMajFCTFZaOWNidE5lNmY4dWRMd3ZwS1FQaGlaTzh6bTNxdENs?=
 =?utf-8?B?bEpURm9YMTYvZzN5ZXlIbVZublNCZzFwUWt2QXJVYWh1TFZEbDhvM2RGRzR5?=
 =?utf-8?B?dGx3NExKWnB3M2pJM3RnUHVuS3o2NG56K3drbWgwS3lGdkMxSUhaUmRSZ1pp?=
 =?utf-8?B?UWVldk5naVJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3lZSFZKbW5pckJJNVBiTGhJUEF1d0IrbWFYSDhDK3BxS0dDb29qTHpORWE4?=
 =?utf-8?B?Slc5WXhIY2ZjdnFGZkN1c2F4NVQvM09pVExxL2VsUTU0UmxRcnpsWUJoZ2M0?=
 =?utf-8?B?WmFidCtLZEN2RlVVUmpUWC9hdTZHOWpOR2RtWDB6TmpLQTFjeFhiR1hHeXJ0?=
 =?utf-8?B?UmpEZENJd0hkc0RibnRPdnFSY3VqcXorZ1M0Sk9ja1QwNWtHSDQ0YkNFRVB3?=
 =?utf-8?B?NnVPNGh3eW03bnRVbkwrbjMwMXU4OEx1cjVlSkZ0NW5uY0xmRit3ZTdBaFFZ?=
 =?utf-8?B?ait6YXlwTnl3UG1Gb0c2dU1RbktEazhhL3prTVVzLzEwbysya1RlR2tWVTl0?=
 =?utf-8?B?SFQ3VGtzM2VvdEV2TndqeVhad1Z4dWc3aiszam9RK2Z4R1R2dGlMc3FaeUFt?=
 =?utf-8?B?V2tFWUJuNHlvbjFvMElsTnB5L1lScVh0dng2Y2NzRFBmbzQ5SUpEQTJOZHBE?=
 =?utf-8?B?em56SjJiNEgrczJEWVhJRGRYNkM2Vnp0eUdXTHNoSDVSUTdZckhyMTJkNkxo?=
 =?utf-8?B?K2JSWHlSb1h6dXYyaFJMNVBXckE2ZURKV0lnSzQ0b3pUdTJWaThTMzFVOXVq?=
 =?utf-8?B?ZFkwdzJ2K1ZyWGxPQUlNTmswUEIrdkVXTnBDcUpqR0VndVErZU4vYjBZOW8r?=
 =?utf-8?B?NDdlMXRGakhkanVlSHBQTWs2WGZKdFk0aEZmY3B3ODVOOEZmN04yM3hobGhR?=
 =?utf-8?B?RjVwWEFYRTllWkEyUG9BakNOVnpwVmJ6bHBiSHZWRmpOYjhFbFNtbU8yVWUy?=
 =?utf-8?B?OTNic0t6NWgxbTM4dEt1dnJGbC80bW42SXZMVkJ6MVNKcjl3L3FNcFJuNjJ6?=
 =?utf-8?B?TUduYVdpL3JmL3M0bkNaYlhYWE10T0NsTnBNSlVMbXh2MW04dS9KcGV0TGNJ?=
 =?utf-8?B?Q3dMckJ3bWIyRUVNeVZYeW93U0VKZ1g5MTNvQ3NxMmpDcTM1dDRNaktIN0Rt?=
 =?utf-8?B?UEllZ0JZaTh6YitUMHdLc1FYL0NKcTEreUtYK3ZVc3cwcm4zUnE4aUE3MW5h?=
 =?utf-8?B?cTVwYktHWG5GNU9zeXJlWFU2T3BYdm9uZ0p1UjVXUzNqbGV0Wnh6Yi80eDNa?=
 =?utf-8?B?cTN2VmpNV1d5TUdxR0plWWVPWHVXaDVkd3lSc3pyNTFoNnNMMkpDa2xSMHc4?=
 =?utf-8?B?RzdZbHlpL2xVQ012Ky82SWVVUW1LSmd3dXZoUklWMjgwWm5uU3VQR2pLOXY5?=
 =?utf-8?B?QWFoRGZERXI3amVPQnNKOFpjSXlWMk9YWnZvWDBrRGtaWXExS05RTHJ0QVN2?=
 =?utf-8?B?QmR3ZXpxQTV0R200bURqWHhhMC8zbFM4MzJmZHo4aW0vaGRYVUFjSE4rK1VF?=
 =?utf-8?B?RFExTWlVc1pVNlJkbjlaR3o4anc4VDJBL3k1VjZmdmoveW9USG1iWWYrRVhD?=
 =?utf-8?B?OVl0SjJFOEpUUGxEM2VIZE9MSFRXaG5leEtvVHRpaCs5T3FCYVNyV0FGYVdw?=
 =?utf-8?B?aDRSY3B3UVVOWDlnejUwVXZCckhzZk0zWmtmSFNWWmFRSUMzREdTRHVuM0li?=
 =?utf-8?B?UnpFc0lHYUl1amxabGVidHlkKytYYzkwTXduQlluSFFGSlRWclFnTmxtMGxk?=
 =?utf-8?B?WUlFakRlR3lxeEZkVmZTdldZY0w5UFBuNVhjenFZWFZtTytEcUk0NnZVZFdm?=
 =?utf-8?B?NVlEQW8zdW93bzFDdmNjZXZVeVRud3huVkt0WTFmMlhsYkh3Z3lqT0IrQ0JV?=
 =?utf-8?B?S1d4V2ZTQ2VkbDQvKzltNFFJUE9rOVB1ZHliaVBwajUyMm1aZTA3WHlubEdN?=
 =?utf-8?B?Tk43R2ZlZjAzV1U0ZzFIUEE2VWU3aWY2RnJSWDFPUWVMWjZTLzc4dmlXQ3NB?=
 =?utf-8?B?TkR5Mmg5ZWN4UkxaRXZhNlJkWVpsb3pqRm1BMmdCQ04wd0VyeS90bnFSTUwy?=
 =?utf-8?B?bmJFS1orY1RsMGNHUkRZdjVTWXNvMkZraDBpS3RrVmtNa1VWYVk3OXZqa1lx?=
 =?utf-8?B?Y1M5V2VTOXpFT3Ftb04zRW16cytoT2E1OTdJb1JOUmUyYndMcitteGtvdVJ6?=
 =?utf-8?B?L3kzSCtIWDBoVFJzcDJRMzlzaDZHY0QzWjNzd1BTNjhhOW9HMmpDOG0wVWR3?=
 =?utf-8?B?ZFNYZlhSM0ZlVUFxTXpZaGhPMVI3WWVobW83UWlReWRoSjhrVEhNVVl3Njdy?=
 =?utf-8?Q?yqbA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cecf55-0de5-4b01-04f7-08dd98f7b026
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 06:12:53.5581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vz2b/zoBvFE2TMNnQd0hS9PnYqXKiLd0JxX9RhIvO5/4XmgUUcZrcIz5DPBWA8frOdXV+dVEmio5jlbsAExQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF09A669757
X-Proofpoint-GUID: iVnUdKdKRrjdmcMAPSI5xZXRsPAbzS6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA2MCBTYWx0ZWRfXxqUixDMMyYlp
 i/DhXFPewkEz3wAVaBv0LO8ZLj0s0bQ6K2oGHi2ozrPSuM/xUx1/dNzhE5h46o4RfAzgrM35vr7
 kmLXtuvWATJaV1Y0SCwn/64a8YaFadSODVcq+kBnHL5bJqQejSgWaUWGEzs3Tmj6/tCryt5ZZ3c
 mwoY0XoS1FsekwMQ0X2V0gZrxqNonGioSbhC0IFFlBvEmnkSuWgdhr+qOFm3ipS9lyBW1Ndgq7S
 ZulyMP1sk6prwMC36lul3kHQTdyG0gmitDJbEFaZsM3TVs30wzqkfEMV/uws5Hrgv8pC91/iSOF
 brzhB8VwKclyG4ogtATZZhRLf7FPquwS8P94/cAWK3h0nV3rQE3KgHYPrxThHFiMx9URdruzqlu
 gWom4GJFdj1eTWKoPXKhjUx0b/D1MIjeJW3WTIl68KU+jQVB68RTLuJVAt+86LdMa5VWOAb2
X-Proofpoint-ORIG-GUID: iVnUdKdKRrjdmcMAPSI5xZXRsPAbzS6q
X-Authority-Analysis: v=2.4 cv=Bp+dwZX5 c=1 sm=1 tr=0 ts=682ec068 cx=c_pps
 a=G0EMd8eUBd5ElxF49Cdl+w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=Vdw0wKo8Fkkd0OHGMPUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
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

PiA+IGRpZmYgLS1naXQgYS9saWIvbmV0L3J0ZV9uZXQuYyBiL2xpYi9uZXQvcnRlX25ldC5jIGlu
ZGV4DQo+ID4gYmUyNDY5MGZkZi4uMTI2NGYzM2Q2MSAxMDA2NDQNCj4gPiAtLS0gYS9saWIvbmV0
L3J0ZV9uZXQuYw0KPiA+ICsrKyBiL2xpYi9uZXQvcnRlX25ldC5jDQo+ID4gQEAgLTI1MSw3ICsy
NTEsOCBAQCBwdHlwZV90dW5uZWxfd2l0aF91ZHAodWludDE2X3QgKnByb3RvLCBjb25zdCBzdHJ1
Y3QNCj4gcnRlX21idWYgKm0sDQo+ID4gIAkJaWYgKHVubGlrZWx5KGduaCA9PSBOVUxMKSkNCj4g
PiAgCQkJcmV0dXJuIDA7DQo+ID4gIAkJZ2VuZXZlX2xlbiA9IHNpemVvZigqZ25oKSArIGduaC0+
b3B0X2xlbiAqIDQ7DQo+ID4gLQkJKm9mZiA9IGdlbmV2ZV9sZW47DQo+ID4gKwkJKm9mZiArPSBn
ZW5ldmVfbGVuOw0KPiA+ICsJCWhkcl9sZW5zLT5pbm5lcl9sMl9sZW4gPSBzaXplb2Yoc3RydWN0
IHJ0ZV91ZHBfaGRyKSArIGdlbmV2ZV9sZW47DQo+IA0KPiBUaGUgbDJfbGVuIGluIG1idWYgaXMg
YWxzbyBjYWxjdWxhdGVkIGZyb20gdGhlIG91dGVyIEw0IGhlYWRlciwgc28gaXQgaXMgY2FsY3Vs
YXRlZA0KPiBpbiB0aGUgc2FtZSB3YXkgaGVyZS4NCj4gSG93ZXZlciwgdGhpcyBpcyBlYXN5IHRv
IGJlIG1pc3VuZGVyc3Rvb2QsIGNhbiB3ZSBhZGQgYSBub3RlIHRvIGlubmVyX2wyX2xlbiBhcw0K
PiBmb2xsb3dzPw0KPiANCj4gc3RydWN0IHJ0ZV9uZXRfaGRyX2xlbnMgew0KPiAJdWludDhfdCBs
Ml9sZW47DQo+IAkvKiBPdXRlcl9MNF9sZW4gKyAuLi4gKyBpbm5lciBMMl9sZW4gZm9yIHR1bm5l
bGluZyBwa3QuICovDQo+IAl1aW50OF90IGlubmVyX2wyX2xlbjsNCj4gCXVpbnQxNl90IGwzX2xl
bjsNCj4gCXVpbnQxNl90IGlubmVyX2wzX2xlbjsNCj4gCXVpbnQxNl90IHR1bm5lbF9sZW47DQo+
IAl1aW50OF90IGw0X2xlbjsNCj4gCXVpbnQ4X3QgaW5uZXJfbDRfbGVuOw0KPiB9Ow0KPiANCklN
TywgYWRkaW5nIGRvY3VtZW50YXRpb24gc2hvdWxkIG5vdCBiZSBhbiBpc3N1ZSBhbmQgaWYgeW91
IGZlZWwgdGhlbiBwbGVhc2UgYWRkIGludG8geW91ciBtZW50aW9uZWQgc2VyaWVzLg0KT3RoZXIg
dGhhbiB0aGlzLCBpZiB5b3UgZmluZCB0aGlzIHBhdGNoIG9rYXkgdGhlbiBwbGVhc2UgYWNrLg0K
