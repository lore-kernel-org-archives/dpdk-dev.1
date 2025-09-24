Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6ADCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97C454066A;
	Wed, 24 Sep 2025 16:30:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 31B4B40661
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:30:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODnmgK006646;
 Wed, 24 Sep 2025 07:30:07 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020098.outbound.protection.outlook.com [52.101.85.98])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49chva83m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 07:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMOGL5dMqZLn5cdz3L+TL4Sd/OMIyObJJ7Bupi0yKIgS0ixKAZOB9Z1JwnoM3+qMu9o6EgFvrYu3vBRe6s/6JY+rjM0BR3sdy3omoHqon6zk4Tpggb8zynwiBCtGAG34rTwwk9iP10tdqmVy2tEhopRY5qhBk3BNyR8ug1Jln+oYvATyxpuuC8Q3BgejrZH5dDl6SCTD0Y79kW5e/5RDrXvU43/3AEvxRDmDkYW+moAH08H+xRnCFYe6qtWb01DQfEXqVSUbCrQOcFS+WKO+mN+kpjC9d2+vAKr/gnbm9zBNfdJfWahsKGSYDn772io66r1pL6FdBrHzydjBSZhukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Io0L6sjMVAk/c5jSTkpzmYF0HTWJPwXBXFTosTIqE8=;
 b=zNxXSmB2S2vhgjfe3h88ZTCxnfHlCzXN7GDUZJeY9lxYGhrih2SaMw3GhWFq52mDsvDUbykJPLojrbiykJURQQ53V45PW/q8MMTDNxtEsMCZ4Vys5+L6CQlSZf9/pvjSiHfzuQjepdDU7gA/+viBBEs4wd1PQM4C4GOOK3KcHOQJRvZeNgqm0gMa2bx3cKEqL2VhsCuUGMOC2/qoOWsyfX/ZxlBwiTlgQw4kbv62Bw26Q7ko59UOidfpUql9n02et0EaFN0TPQ8ekgYZk/1NqXp+Xe5UfSdOzIvwT4TFS8GAFu56QmLAMI6iiKK9yTNuoOMb2nygvG1l5PDRO0QyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Io0L6sjMVAk/c5jSTkpzmYF0HTWJPwXBXFTosTIqE8=;
 b=r0BmuXrie7e9I7dDqL5GHwnceD9DFahdus2a7tlRxewm9ij9x+IYGl+02lNYarndlacfsDDGx4+5WM8xgT2szt1euoao2+oZ2adLvRMMgiqZwCY+qACOtY+DhtSlTrS5wRcBmvDNZMjny+GX7WlRtwgfyr1SOGTY9iszm8hSUfg=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by PH8PR18MB5268.namprd18.prod.outlook.com (2603:10b6:510:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:30:04 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:04 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Christophe Fontaine
 <cfontain@redhat.com>, Zhirun Yan <yanzhirun_163@163.com>
CC: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Guvenc
 Gulce <guvenc.gulce@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH 0/2] graph: dispatch mode improvements
Thread-Topic: [EXTERNAL] Re: [PATCH 0/2] graph: dispatch mode improvements
Thread-Index: AQHcLV4qSQak+WFdukeeaPq5NSLq1LSiZCmw
Date: Wed, 24 Sep 2025 14:30:04 +0000
Message-ID: <BY3PR18MB478556F4158B03FC20BB7A4BC81CA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250723165001.11162-1-cfontain@redhat.com>
 <2836217.eGJsNajkDb@thomas>
In-Reply-To: <2836217.eGJsNajkDb@thomas>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yanzhirun_163@163.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|PH8PR18MB5268:EE_
x-ms-office365-filtering-correlation-id: f23d26ed-ba2b-485d-70f8-08ddfb76da86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M2VIOFV2eXdYd1ErWE5aT2d5ZzVvUmdXcmovUTVKVytMbkpDZUlSaG1GaHlX?=
 =?utf-8?B?OVhQbm9RWGoydDRmbEo3aFpDdk1RajM1TVdIaC9idStCTWlubTJzb3lSVFZw?=
 =?utf-8?B?RGc2MXRTemU4WFNXcFBYeFJqYmZMbHJPRk1RTXNuVVNxZGtqUnl1UTNIcmdx?=
 =?utf-8?B?Tk56YWZjc3F2RzRkZGE0N2RrUHF2Q0JIcEkxUVBZRUJ3WjVxZFpIUHJpZk43?=
 =?utf-8?B?SDZKYTVlWGNZWUcxUkxtWE9heXdQZnIzcVRoVTR4a0hCdWRROW5DMlNEdFBJ?=
 =?utf-8?B?S3UyN3lPSXZ5YlBFS2ZPU25kU1BRbjVWbDBCTVc4WEt4TnpWVExOUkEweXNG?=
 =?utf-8?B?ZXZGb1ZaREhkN1A5NDlzbGZGVVNmYnZUbnNYWXd3SlBsNUpIY3NQVzAxL2hY?=
 =?utf-8?B?V1ZYaEJpRnJBeXo1ZE9vKzdvZ2lBbTdhOHdjc2RkOUtkSHBSSS9xTkhzM1B4?=
 =?utf-8?B?RFpsdm04K2JwbE5EcU5BcVVtU3h2LzJMVXlZWHc5TXc1S0UxbHg5UmE0eDRX?=
 =?utf-8?B?aHZPRlMzUnhZcXYxQU83RnQrUXlyTk9wbnU0WUNqTHlTRXhac2ZCOUZob0hQ?=
 =?utf-8?B?ejdDSHhaT0liaEJuZ0swSUpMZlh2T3B6cTRmYWFRdmhuckd0RVpKOHRGZSta?=
 =?utf-8?B?RGwxYytWcUp6TGVHMGZlUW0yQ0EyaVZUT0M3VThueXRPU1RDVGdyN2gvNGlR?=
 =?utf-8?B?WU5lNXlhaHdiaGd5R2ltNVJQQytpTjBNSGZvQno1Qy9BVmxKazV3VHhxcVov?=
 =?utf-8?B?TFlyRnF3ZzNFdjlyaGRWZEZIUW1aOXdmTHFSbnoxZjkvVFF5WXgreDFTRlA3?=
 =?utf-8?B?RGw0ZG4rOW90NWZKTmJFRFhBaG5EQTFScy9DanA4Q0hSVkNwdnl5VVVrRUd3?=
 =?utf-8?B?REVqTmxUY3RpZXI0clUxODdXNHZqV0lFR0FXSHdnMlB5aVBxT0diZnpyVTA5?=
 =?utf-8?B?MGxXNlBTUnpyYTMxSks3VEI1TnV1VGhtOE9DaVNPejFubURtd2Zqb3pkRm85?=
 =?utf-8?B?TE9lckhLSnBSbmNaZ2xqRFdvN2o2eFQxT1A5bmlqYWRzTSsvK2huNzEzOTlO?=
 =?utf-8?B?YUc2K3A1Tm1FNTlhTldDVnE2Si9oYStzMFlCRTBIdTNVWXBIVjF0NG5WaDdn?=
 =?utf-8?B?UnlpblpkcW1lVnBvTVptVTVtSEpVNXQxb2JNUFdUejZWV1JOQURRZFQvQXNM?=
 =?utf-8?B?bWoyM0UzVWVKVzhzbUlMVnU0UkEyNldveFQ2TVVSc2poeC9YQUIwcEd0Q3Q5?=
 =?utf-8?B?VVozWHRQclVEOFJZS0lPQUNWSWxZVTJpWlJpOGZxUFhjZGVYU2F2NUJ1aW90?=
 =?utf-8?B?R3dtOSsxa1BhVTdOVkNKOGRTK2h2bVJXbG15MDcyYWRhNnZYNzJTOVo1QW85?=
 =?utf-8?B?bTY0d0pkb2U4MHhDaUs1Y2lmOUEvc2dNMXdWUm9iZktyRDJGdGEzVnRkZFFG?=
 =?utf-8?B?bW1BK3NDdzJkaGV5dk1hY2h6bWZrMHlvM2VYTDYrTU16VTZhWWVRMGF2aTlw?=
 =?utf-8?B?eVV0dEszNFQ3ZVppaFR4RVJEV2dnZWo0QXpCbnBZL0hGQU1UOEhNNXFhdVAw?=
 =?utf-8?B?WVhMVnBFRGRtcUovUlJURzMvT252NnpzMk5kRzUyaHQ0TlJ5ckIwTnBreDZB?=
 =?utf-8?B?RzJrVmlxTEpJSGdOSE9KZ1VKSWVDMG4xY3VWWlhBWjJDTUdRZHEvYmo2YXRs?=
 =?utf-8?B?VkZIMWlLbElYRWxCVVMyZ1pwQnY3NjY0NGYzeDVCZG1JODlReThSbHIwbGRI?=
 =?utf-8?B?dlMzUVF3cEdyQmVsc1JJajhoUDZ1NHZqQUdQTlZKdlV3RXIxckRqTjJTQldx?=
 =?utf-8?B?VG9JVWJDbVBkaE02VzdIZThzaWloZDA2dkNYTFl5VmcxdXBZTmxtMHJRbjRv?=
 =?utf-8?B?Qy9PSDIvWURYWW4xblhkVlZoUFpQd1UvZ0pDUUJpQk5tanJUM3pnT2lObnZv?=
 =?utf-8?Q?5iCnsueDzSU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blkrT0VmdWpJcjF0Q3BnM3ZNUitvbWpXTWs4WWZWZFV1K0xGQ2I0SUhDLzBH?=
 =?utf-8?B?aHBvV2hTSlorMFRHaDBqVFV5QmZEcTkrc2llaGZkMTdQV3lnMzY0Wk1kRVZV?=
 =?utf-8?B?VHFVbTRhVGtnRDlwdXJkNkYxNGlLalFBWkNUMGMxMEhvVk8rakt5R1JkaGZO?=
 =?utf-8?B?L29nTnVYRUttcHlmeFJoSER3UG9NZDNFL0M4dmh4blhOZ1lLcWV6WnBRTHps?=
 =?utf-8?B?UHVLVVJIeVRPTmdwL1JXc25PTlROeGVIcUQ1ZGdxMk5ZVnBpWVIzNW5kY0pq?=
 =?utf-8?B?ZG5NZGRrMzdVZmZiZHpuN05jMHJIczhsd1dsSjdxa2pZN2htbzFsMVhWYktx?=
 =?utf-8?B?YnNoNHVIWndnZ0xFaWFkZU0wRUNadjh3NTN0Nkg4ZGhjaGUvSGtQT25oTDJl?=
 =?utf-8?B?VjhrMURtSzRuWE9qTkJCYWZoTUhWOTdZYUcwdzhKTUhPemorenBlWC9pSVR0?=
 =?utf-8?B?WkVLekZ0bjVxWDM4NUh3VjgzcG5mWmUrN1lvUjhVUFlJaUoyeFJpdmxXSzhJ?=
 =?utf-8?B?dER0b3pibXhPcVhITGlYQjkydTl5SUhCby9UbjVJOGMySDc5NUtkVlJtNEk4?=
 =?utf-8?B?RG5oS0k5N1hEQmlWRjJXY21BMkZIOS9mZitPUXltNVVoVHJ3TXNoTzZnZEta?=
 =?utf-8?B?NTRxR2syaXVmQllsNmdCajRHS0p1MmNpdm5NZFVJSHBtbzEwaDd6ckJtVG1H?=
 =?utf-8?B?YTRaWDY4anV1d0ROWHdReStEcGtGVkgyK2hHT3NaN3g1VDV4VDEvQ3ZScnhw?=
 =?utf-8?B?TTViMVNBZUw1OWxjNEVFMnRvV1lrcjk1R3FNTFAzaDB0Y25zYm1uUSs5elMz?=
 =?utf-8?B?OHdLZDRqQTVRSXMydWFtNmlaS1ZKZkNqMlhxdXNLdUFqQUN0dEVrbU1DQkVM?=
 =?utf-8?B?aFFNeUFZZVliaDhvYzM3emxFb1BsQThVZndyTHQ5cE5POGJFZ29rWk9sZlZl?=
 =?utf-8?B?U3BBTlBkY1VnbzRZdUtGdXcvVHBrdGlUU2R3SlJOdXBMM0tCSnlvekZZa1ZD?=
 =?utf-8?B?Ylc2RVJnZ2V5cHZvSGVPSzRLenNwQnVOZmxRajNSRTA3OEF3VkpUMHBuL0d1?=
 =?utf-8?B?UFVENmt2d1B6MW9yUWJWcU9vMk5FVmZZcDBENkE2OFBGRDEvd1JodWl1VzNH?=
 =?utf-8?B?L0x6Qy84dkhUenhuazRVb0h4SFFRNEwvRklIaU1FMVJsaXFKYjdhNVcvQ0wv?=
 =?utf-8?B?YmNobUl2QjA5VGxIck5ValNzbzF4R3R1WCtKUVVZTmZZMUQ3bW95RnIxYWFr?=
 =?utf-8?B?dmJjVldNY1V2cmZaR3ZjZ05LR0VLenBFZVZTcEUxcVlsSTNRTmtQMXlHUXlC?=
 =?utf-8?B?Yk5vZjc2UEUrbUNybisxWXFRdk9TS1hCYWxwSXlUb2ozR0FZWFRjQkZVYjRz?=
 =?utf-8?B?MEkzZEo3d0lCNlZSZzdDT2ZtbUdUOTBsN2Nic1pvcEM4SUlwNndjcFg2cmN2?=
 =?utf-8?B?WHR0TTZpMW5iY2U5Y0lzR2o0Vmd0YUM4Ty9HMERjUjRRTUhpSm5OdnJPdTY5?=
 =?utf-8?B?U0M2WG5sQzBkZTh4T2FDTUl1blRneTd5cVBObVBkZ3Axb2doaHdheUp6RG4v?=
 =?utf-8?B?eEMyWkJhWm9JNW1IdFI2RzRCRXJOUGNzUm1kbkxQRFR1WTROWjkydjkzWmhX?=
 =?utf-8?B?QWVmQ1JkWXdkTzdvRjlWdG1HRlAyeVV5SzYwUWplSitWMFltV0dTakZyMFhV?=
 =?utf-8?B?NW5jb1AzN0h1V1RqdnVmVDBkVkRMdVdJb25HSUkxeG5Ed3RaUXJJTEhyM1Yz?=
 =?utf-8?B?Q0xxcEp2YkdiMnVIVjBBMkplQjl3aUV0enJOb1hJWnNqZzB0YXhkNHFDeUZN?=
 =?utf-8?B?R0xTbE10NXhjVTVEb0I3QmRZZmpoUUlYYmVlbHJ2TXZxMW5GcmxVb2s0eVVB?=
 =?utf-8?B?SG5vRmpyUmlnVlRPOHN5NWFSa2dpbXh0VzErWjRoa0RRK256RE5ZMDhxKzMw?=
 =?utf-8?B?S01VSCthYUlzdld3cHU1VXhuNzB0a2lndUR5bFdreHVPOTFOZFdzclhzREw1?=
 =?utf-8?B?UEl0N05YYlR1blVyM0lrbXZwK1AzSHZraDVuYkhrdTJramwwZkF0cjZpdGRt?=
 =?utf-8?B?UmtoZnJtUUZldDhZek53RlYxRVRTZGYyZU45ZmN2YVc2SjBSamkvWUZDeXg0?=
 =?utf-8?Q?OuCEvBZpge8cLidPjmo/qhgki?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23d26ed-ba2b-485d-70f8-08ddfb76da86
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 14:30:04.7097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWO+2zgf3fU50vdR1U+qQpZqBCHBcM+1UYc9juPNQYCq2O+kYaMNKQBxbYEVknIlbMrlVGpO3xLkEklEN0ibww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5268
X-Authority-Analysis: v=2.4 cv=FO0bx/os c=1 sm=1 tr=0 ts=68d4006e cx=c_pps
 a=5ZmoExZQM1RqZyAr9AiZEw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=RpNjiQI2AAAA:8 a=1UkrGUahLw6cuq5SnhYA:9
 a=QEXdDO2ut3YA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: qa1AQTFBnLYNZpz6LHiUoSJmXlNtZzm4
X-Proofpoint-GUID: qa1AQTFBnLYNZpz6LHiUoSJmXlNtZzm4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDExOSBTYWx0ZWRfX0CsCpqJ48dil
 I5OeLVyaFj6kAtRE7aSKJHL4HrZ0MNQM6Q4A1EV7GLQ6KDWUMsBXA12pUlL0m/MsVvFkEJU/X9z
 fAXZlU/f9FwQ2hq5hZs8b1iAM74pGZnyyYjpRuqYPSVgYKD1mccm4gpWJk3+iKa15pBFc33ereW
 GJIXxUiJ/sLAJHy/KENfC8Z1O8dKtA2VZdBSQAvITUMV4aiJ2bYpgtzNgnT/0pp0Mo6vm+8QtjN
 bHW8/Nz1eYvS24ig3HbuCcZi0fxWDm6Iak8QKYJScGg2XIBvDEmPbSkoZ8gqDkcTlbK9Zne4Mdy
 RDosiA0acTsoBNavQUvdY83oKrPLsYtumoqjAMUlPBTxVBfHijwPpl2VlyyktIot5iPLpy/GgmR
 /gT5+CE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNCwg
MjAyNSA3OjQ5IFBNDQo+IFRvOiBDaHJpc3RvcGhlIEZvbnRhaW5lIDxjZm9udGFpbkByZWRoYXQu
Y29tPg0KPiBDYzogSmVyaW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IEtpcmFuIEt1bWFy
IEtva2tpbGFnYWRkYQ0KPiA8a2lyYW5rdW1hcmtAbWFydmVsbC5jb20+OyBOaXRoaW4gS3VtYXIg
RGFiaWxwdXJhbQ0KPiA8bmRhYmlscHVyYW1AbWFydmVsbC5jb20+OyBaaGlydW4gWWFuIDx5YW56
aGlydW5fMTYzQDE2My5jb20+Ow0KPiBkZXZAZHBkay5vcmc7IEd1dmVuYyBHdWxjZSA8Z3V2ZW5j
Lmd1bGNlQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIDAvMl0g
Z3JhcGg6IGRpc3BhdGNoIG1vZGUgaW1wcm92ZW1lbnRzDQo+IA0KPiAyMy8wNy8yMDI1IDE4OuKA
ijQ5LCBDaHJpc3RvcGhlIEZvbnRhaW5lOiA+IFNtYWxsIHNlcmllcyB0byBpbXByb3ZlIGRpc3Bh
dGNoDQo+IG1vZGUgZm9yIGxpYi9ncmFwaC4gPiBJbiBvcmRlciB0byBydW4gYW4gaW5zdGFuY2Ug
b2YgdGhlIGdyYXBoIGluIGEgY29udHJvbA0KPiB0aHJlYWQgKHNsb3cgcGF0aCA+IGRlZmluZWQg
YXMgbm9kZXMpIGluIGFkZGl0aW9uIHRvIHRoZSBkYXRhcGF0aCB0aHJlYWQsIHdlDQo+IG5lZWQ6
IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBQcmlvcml0aXplIHNlY3VyaXR5IGZvciBleHRlcm5h
bCBlbWFpbHM6DQo+IENvbmZpcm0gc2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eSBiZWZvcmUgY2xp
Y2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cw0KPiA8aHR0cHM6Ly91cy1waGlzaGFs
YXJtLQ0KPiBld3QucHJvb2Zwb2ludC5jb20vRVdUL3YxL0NSVm1Ya3FXIXMwM1oxUDgwWWpYNkY4
VVNWcFUxcEVQbkVMOWFCVg0KPiBDRG1aaFRVd01XclVGckRRRmVQTUZqenFRc21tRk92RThWNy1I
ayQ+DQo+IFJlcG9ydCBTdXNwaWNpb3VzDQo+IA0KPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+
IDIzLzA3LzIwMjUgMTg6NDksIENocmlzdG9waGUgRm9udGFpbmU6DQo+ID4gU21hbGwgc2VyaWVz
IHRvIGltcHJvdmUgZGlzcGF0Y2ggbW9kZSBmb3IgbGliL2dyYXBoLg0KPiA+IEluIG9yZGVyIHRv
IHJ1biBhbiBpbnN0YW5jZSBvZiB0aGUgZ3JhcGggaW4gYSBjb250cm9sIHRocmVhZCAoc2xvdw0K
PiA+IHBhdGggZGVmaW5lZCBhcyBub2RlcykgaW4gYWRkaXRpb24gdG8gdGhlIGRhdGFwYXRoIHRo
cmVhZCwgd2UgbmVlZDoNCj4gPiAgIC0gdGhlIGFiaWxpdHkgdG8gcnVuIGdyYXBoX3dhbGsgb24g
YW4gbm9uLWVhbCB0aHJlYWQNCj4gPiAgIC0gYSBzaWduYWxpbmcgbWVjaGFuaXNtIHRvIHdha2Ug
dXAgdGhlIGNvbnRyb2wgdGhyZWFkDQo+IA0KPiBTaG91bGQgSSBleHBlY3QgYSByZXZpZXcgYmVm
b3JlIG1lcmdpbmc/IFNvbWVvbmU/DQoNCkBaaGlydW4gWWFuIFRoZSBjaGFuZ2VzIGFyZSBmb3Ig
bWNvcmUgZGlzcGF0Y2gsIHBsZWFzZSByZXZpZXcuDQoNCkluIGdlbmVyYWwsIGNoYW5nZXMgbG9v
a3MgZ29vZCB0byBtZS4NCg0KPiANCg0K
