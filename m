Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2746CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 05:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB34F40262;
	Mon, 27 Oct 2025 06:22:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 534594003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 06:22:09 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59QMtbnT507059; Sun, 26 Oct 2025 22:22:08 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a1fa5sg25-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 26 Oct 2025 22:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtE78rq1YnYLCUnS5pj7bZVYi5nsL4/qUAOwYRXFulOdAIoY1b10YlIod/3QBqm8UC3xj84s38a9CSUXOgSmSFk+FqS7scoNqgojSyuvOdCevZiuoAIXn2h45D4FdXWdt8b9y2D5QTW8PvtTMALWsq415+0D2ktyrPZwivVDbTNOLsA/vMjCQlHgkHhVolPb4oNK0ZTrvyEa9qq1o8hf+gMiFRQIVid3WFwO+W2nNyLPju2bNsEvawJJzvuF+G+bNoq5jEfdFAdgmicv8Uv5P+rgBPHN+XINdkmTbdTGTOJP5plx7cq3hJQmkckz+8jdm+Se2WdqLCLncK3k6SaGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U52xSd3bFyTX8FjzO0Nlb/H9ZOW6iMTN0Jn0drormA=;
 b=fzoMqpNsJHDnmGaN6KJOzE4VrKiDN6ne6GZy7/Gtn/MqWq4KDNjNkUAQRU62FO13csk/NcU0LrAbE/6/BnxbP1mNGzJhuxqN32yNZbYt8MGC70jvFd+XgX3F/tJO3GqenhxLnIv+KVmXtX0QzURSdyuvyVIffAKJs7GcqTqG98QbREAuW6zvvSPWw8wxE7Edh7S19oa5xwUv3GzPjcKW0c8dSj9Ln/8xTOdgsRM5U+dStoVEIzc39kMFHgItv4DsKfn5VGKHwz43K7UFN5eK+c9BVL/GXzpE3cs3StNYHn8gz2apvyLRqmlXPF7HPzwtFcmmV87vjtdQn7Oq5uhxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U52xSd3bFyTX8FjzO0Nlb/H9ZOW6iMTN0Jn0drormA=;
 b=ZbZPpHTacnZA/oyI9NpJii7o78bZgciJrq151fAT9ZwnF0fVAl63aBqpdqE0UoqmxEpOI4EM6wPtG6ZOg85r9xA84JXRwknhF/KbCMyi3JXBXOtrrXC0a1zvFhTrxyCx2OXVUlI7pi3sjdqewAW/Eqle+btDlVAVYHT4oXjx5ms=
Received: from IA1PR18MB5470.namprd18.prod.outlook.com (2603:10b6:208:447::14)
 by IA2PR18MB6031.namprd18.prod.outlook.com (2603:10b6:208:4aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 05:22:05 +0000
Received: from IA1PR18MB5470.namprd18.prod.outlook.com
 ([fe80::59f:865a:aca2:1831]) by IA1PR18MB5470.namprd18.prod.outlook.com
 ([fe80::59f:865a:aca2:1831%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 05:22:05 +0000
From: Harman Kalra <hkalra@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>
Subject: Re: [EXTERNAL] [RFC 2/3] common/cnxk: replace variable length array
Thread-Topic: [EXTERNAL] [RFC 2/3] common/cnxk: replace variable length array
Thread-Index: AQHcRFU475bm4G8VqUuiDNS6Iq7He7TVd3Xn
Date: Mon, 27 Oct 2025 05:22:05 +0000
Message-ID: <IA1PR18MB5470E4E3CF00DDA23D06AE54C5FCA@IA1PR18MB5470.namprd18.prod.outlook.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20251023194237.197681-3-stephen@networkplumber.org>
In-Reply-To: <20251023194237.197681-3-stephen@networkplumber.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR18MB5470:EE_|IA2PR18MB6031:EE_
x-ms-office365-filtering-correlation-id: 98bfa40b-5026-448b-a614-08de1518c4b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NlZYRHJFbkgwVUtQeTF2L0VIWW9Gc2tPNWVlSmVGMm9nU1Q2Y0E2NTNJZi9N?=
 =?utf-8?B?dHNGcFBVQlRtSmpxK1JTU2RianhWRGVhYkc5OFd5SjVJMVU0SDE2NnNGK0FX?=
 =?utf-8?B?UzZEMmhaa212Q3RtbDNnTlBLNVlySkx5S3ZKZ1FicFM1YWxQSXZpMW1Hd0VV?=
 =?utf-8?B?TGRCd3YxUlVEeEJ6cGRBSnlVcFRJMHdPNEo4ZWRZQTduT0NvQ2l3WVFKY3lt?=
 =?utf-8?B?MWo3amt3ZjNuQWx0Wml2bjNTMXp3TGd1SHhaTURNOUpRYVpDWTV2K0xYZGp3?=
 =?utf-8?B?bVZSTUlGbVBlazhuQUVvQmd3UlRob3hWVC9jcHJrMlJIbXBRNi9lNUJhSlY0?=
 =?utf-8?B?bmZab1hGZXp1WUJVaTNxcmw0NStKUmVoNlB4Ly95ZnNMT2d6enk1eTgyYmdJ?=
 =?utf-8?B?Q2ozN01SWnl4MTY0UnkybHFRb0ptMmV0cmgrTGxTZ0ozZDFNQm1paXBaWlVN?=
 =?utf-8?B?UkdacysvVnowV1UzZk1WckFCY0ZZdHltWE1aNVBhY3hmRklQeWQrR2U3ZitJ?=
 =?utf-8?B?aEhBVDNBS2VqMldrT21rbVNIZjZwK3BYZ1poUElFcDExSHk5cFRXbXRXUFpZ?=
 =?utf-8?B?Rk16Nm5YWDdZUk55UlA1dCtpdXdDelFqK1ZWTUVHZkxLT0wxUE1HenVLUlM5?=
 =?utf-8?B?QUxrQm5wTzFBbGp6MngxeTNPNkN4cTR1NUVPQU5LOUJOenlvWEsvSlVCTWJi?=
 =?utf-8?B?cmZDQWVMRzVpN05JUlc3Q2FUcUdtdGRTS044TmJUOVZYQWVXTFBHa21tYzIw?=
 =?utf-8?B?ME5UaHkvZXNyV2gwSERLcnphT3ltcXljRXhiaVJ6T21kWXI2K1NnaTdVRVlE?=
 =?utf-8?B?YmNETXk4bG1LdDlyODFLWEcybWhZWi90NktkaEZaeExySUg5KzRMK0ovbS9G?=
 =?utf-8?B?SU90c2hTSUxUYjN5L09lem90ekJaUTRsM1hibFZBMmtYeUZBNDhJNkNhU2R2?=
 =?utf-8?B?bHFCK2RJZ0ZiTXg1UFdJVjNaR1EyMzNKWWFFMnk1UWJ0cjRxSzJzbkpTcXBL?=
 =?utf-8?B?MlN1RVRTdVd0S2lhWHBGKzdFZGZ2cVJtK1hyREQ0dFJNZmVEd2lSbFhVSmN4?=
 =?utf-8?B?Z0xDdDB2OTNjNUozcG9jMlJDbHhXRmVyMThhb2VOQTJqUUsyWS93T21UMk5R?=
 =?utf-8?B?ZXdWeDRXRjVUcTMybEd5RnRyckFWWjZtS0gxT0FHa1VoNHpScWhsWWxYU2dI?=
 =?utf-8?B?TWgyQ2NJNVNMUXpNa0xsTGpkNnpXNlNTMEdDa0o3WE40QUY4dDh6U3ZMekt4?=
 =?utf-8?B?UHlxaUVyWTJ0Zy9BSDdJNjVjd1MvVHFpZmxJNXVNamZndDNIZ1llTUxiYTV1?=
 =?utf-8?B?MGhDeUYzUHk1RFlnMkdnRWMwU1BIbTBOK3l1Q0hnR2tjMld6NzdoTGxLQ1pN?=
 =?utf-8?B?d1NKQ1FZU0lMRXhodFo4NHExQTd2OXlsZUdFU3ZpQzdqL2dhTjBPRHl0aVA0?=
 =?utf-8?B?bVN5bFlsWmRlbUpTWkUxYW9vMVdEeEdGeVYxbnU3eFpIMEFteTdNdlFhdnQw?=
 =?utf-8?B?UFE5dXpQUFY3dkxJeGY1dXhSZjJrRHFrelVXdC9Qd2NzamlNRTFya1hHaTFP?=
 =?utf-8?B?dGp1UGpNZ3lSZ2ZiQ0x1cHVyMHVpanIyRE5teEEvNXUrNUZ0Vm55OVRxY2dm?=
 =?utf-8?B?UUlGVURUVGpkNEoyYXdnZnlMMWdad3hPVkdhZC9jUEY3Z3Naeml5M2gyUCsz?=
 =?utf-8?B?VEJhQzgvODBoS05HcEFNK3NubmlLQldnZjUwckw4bU5ESitHWithTFN2eGs3?=
 =?utf-8?B?U05Rd2pyNnRPQk94MFZJbHB4WGkrR0dvM0dRVW9xQ3JETHFLVjJZcW1tTGpr?=
 =?utf-8?B?T0dHNUZvcGhiejgxb2NpUjlNUXB4Z24wY1hTeVBad24reW03NnpNUlJHQmxz?=
 =?utf-8?B?Vk0rZzUyblJneDA5MXdHL0FKWHplSHlqczc5SCtPOUpYdDJpYjEyY3hMWXI3?=
 =?utf-8?B?T3l2Snhnc1UwTEdlZys0NVNJOXFoY1lvOCtRaFQ0YmduSURKamdxYTFvTW81?=
 =?utf-8?B?T2VtVHorUEs3NmMwUEdnN2orVUFxY2NyajFDeXhBTXJHaXcyZUNsWXdkU1I3?=
 =?utf-8?Q?Bdeg/y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR18MB5470.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRJL1Z4ZGd5RjZRRkRKMzRFRjkzTDBTYy90a0cydDhQN2NuSFJ0OUxreUk2?=
 =?utf-8?B?ZXBQRFArNnVLK1k4aGVRMVh0L1dEMGlvRy9VM01QZUxIbzZGSVYvaHpCS0dQ?=
 =?utf-8?B?MWUyYStPeWZXVXRYS24reHBJbExyRUNRd2xrRG1xK0lxSkUyMkhickR5eTl4?=
 =?utf-8?B?MEhRR1B1L050bG1jUjFYYVkwRU1WY3c0NnU1VnJIVlJpdlBkdVA3MkwwQUNH?=
 =?utf-8?B?TlNMQktSb1dKWGltY3ZkWWJZK2JSd2h3amNxUzZjRlhqWGY3dUoyOHlEbDZ0?=
 =?utf-8?B?OE5iNWJBMTk1VE1RZXdLMHo5WFFOSWQ2YXdSQk1UY1BvMC9vTXdZV0NCc0Jh?=
 =?utf-8?B?aHdMTHJSQUFSTWIwcjlMNk95c2lUNUd5ZlRjUmRIa0pjaEg4M2plRzJSK0lN?=
 =?utf-8?B?NWVnM3dnWWlkaktycHRkUHR4SUJWdHRxMDMwOS9OSmlxZ1hjQkNyT0VTNXFS?=
 =?utf-8?B?K01KTWkzRkJQa29FU2Yrb3htMFRpK1ZRdEY1azJoR2lSQnQvZVNiaGQrNXZC?=
 =?utf-8?B?K3BNM3FLbjFkcGYwa1Y5N2J3OXVZL1RYRno3cFp5bmpLWHdSbHNoakEybks4?=
 =?utf-8?B?aW5vc0hwZ21OT1VqeEpZeTE5N25BaXV0aTJWdk9oUnhiNEZCZFRCdEhQMXNI?=
 =?utf-8?B?SGp6cVUxSDJmRFYzSElhcE5OU212VkZFU1lqVmJZVSs0RHdrSUh0enBnK1JZ?=
 =?utf-8?B?NmtEbkwzN0dEdHZPTGFwTUJXMVVqMDhrWWtWU0hUTlNBNEQ0ekxkMktkekJP?=
 =?utf-8?B?SjM5djBjL2JPaWVYWUxoUlFUa0ZidkdoMUdBZmNZY3ZoWkVlM204bmNobmdw?=
 =?utf-8?B?VnV4elM1bFN5V2dmQUZhZTRLWU12UTI2cEpJbm5YMFpFV252b2k3bFNLMXZR?=
 =?utf-8?B?cEFxU0dibXQ4L0czWk5LMCtXemFWTm9DMEg0VzFnUGZjUHhkUk5PZW4vdU5S?=
 =?utf-8?B?RE5VNWlWTnN5Q1Z6RjFSbkV0N1lMMkU0MFhsK2NrRzNOWmNpRHFsY3dLbFVK?=
 =?utf-8?B?aWw1R1FDNUJkSS80Q0tVYVgzLzg0RWRLN2ZTby8zZlFLQnpULzFubGwwMVd3?=
 =?utf-8?B?ZElyazczWDhZamM2RFZwVXNrd1c2KzdXcENrZVRTOWRJOEZBcEdGVXc5WnJo?=
 =?utf-8?B?UkpZaVFSQkE0OE1hczhUb252V3ZGNVo5bUFFbVRxZVBpek44UnBNZHRRa1lB?=
 =?utf-8?B?eFZjZjdrOUVyeVBuZEZnVXVtTks2UzNWNXczQWNGQTNxM1J4OVdaWUJ5WmZ5?=
 =?utf-8?B?cWpwVE1CQjdlWlljVmVVSVp5OHBDc1c0OEE4YnM5Vi9rME41bDIybkphaHh6?=
 =?utf-8?B?K2puVXNOaTJ0YklvbXpwQlZXYVBlTGIzbURZeTFiRXpMQ01WVFFZeWZEQWJs?=
 =?utf-8?B?YWRxM3ErOGdQMWhrdnh5c2VmR1R0b2R1Y2tUVkdqUi9QRHUrdlQ0OGI5czBJ?=
 =?utf-8?B?d2Zha01xSVFvSlcxTHBKRDZ2ZHNaRkJvSFFDTTRoTWNxTWRuM0s4Tm5ieGJ5?=
 =?utf-8?B?a25pUWxwQTRnM2VsaWttOWV3czQyQktpN3ZEUmhkbGtYSlh5dEpra0tYa0NX?=
 =?utf-8?B?WW50bG1PWk5OOXFPUmtnODg3ckY5U3MxQWRTT3FtL1NEbWlxeUk4Y1JoNTdX?=
 =?utf-8?B?RXp2S3FjZllNMVUxT2xQZ1pLSnNrek81Q3ZOMUEvUzA0a0VnUkFubTBueFVp?=
 =?utf-8?B?a0N3Wk5ZUWkwenpiUzhxS3I0VWlUVFVCdzBBa2ZvSHIxY0NLek5LZjFyait1?=
 =?utf-8?B?YVZBSG1iVjV5S3M0TmNYU3pTSG1HeEtUbFRCSmRkVW1uRmVsb0VJK2hnNkJH?=
 =?utf-8?B?SmhuZG4rY0Y0OWtWUFljSEhCZ3l0Yk4vcklrMUhtNVdFeDlxOTM1eDhGWnU4?=
 =?utf-8?B?M3c2QmpyeE1BK2p4dWlvVFpvMkg4dkZpME5LWVVYdnJreTZkNmxmb1R4NENP?=
 =?utf-8?B?MjhtSitnd1haU0RVbUFGSGJMWHd2dWgrNXBqZHI2MDhra0I2V21UdkUraGZB?=
 =?utf-8?B?RXhUVUlIaHFWRzNGVlgxVHNOUUJhRHoxbjR2SG9pbm1IdzNKVjJFN25CUnRL?=
 =?utf-8?B?d0ZrY01BeXRtZWJPMi91eVU4VGd5cE1PM3pzazhYMjNCQ2hlT0hGU0dMQXdO?=
 =?utf-8?Q?0PjE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR18MB5470.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bfa40b-5026-448b-a614-08de1518c4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 05:22:05.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wStWZ4QWGqO5oAzWQF9MxfaBq0Wx9kzbtFDea8/ISFRSvIkFSKdqXdGN447/Iir8/tpnMH8gPQnF15bagFoICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6031
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA0NyBTYWx0ZWRfXxMFxqgi+tZq+
 AYbGGwrWrabm5NLMN6QR9W5XEAWVuKoFSqZ+c2SISVDQpVq4PkyMZ5V8cC9rIFGoNRNN3KeQPoP
 msWpI0eUTQW+AmUaLraKKeAM/hkogJpJJmssrKDsnSphGzaAEDNyB5JXnOl1AGVAeP261xCrt99
 grCX75B+wQ4KR3xrvwi1Zs9287yUHL10shefUtecXVQXUvb5qjkfcWPKaV+kpPj/b7uyPoF+sUG
 Od2xSSuAlaMStSc3oZVQp7VHXA624IN8Qow/E1z6RqaO1LmooyESjjUZ5Z+y3kO7mEkFHgz5/VV
 +BZjD9+dhaIaW2qW/fLZIxs6gkySKUObW/NKe7iffdTmUEyPpeSD3NVlSsaikSanmIie/iTxkYt
 6Bu5XbarUVMMF5qLs02jOmQNcU1GFQ==
X-Authority-Analysis: v=2.4 cv=VOnQXtPX c=1 sm=1 tr=0 ts=68ff0180 cx=c_pps
 a=dV5UnTNaioTBtvBhj0ZdMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=dtRhXEUe8RYxJtPwphMA:9
 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: IOXoVk0fJegXj5Q9M3QadaC9GXvjCxzB
X-Proofpoint-ORIG-GUID: IOXoVk0fJegXj5Q9M3QadaC9GXvjCxzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
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

SGkgU3RlcGhlbiwKClBsZWFzZSBmaW5kIHJlc3BvbnNlIGlubGluZS4KClRoYW5rcwpIYXJtYW4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4KU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDI0LCAyMDI1IDAxOjExClRvOiBkZXZAZHBkay5vcmcKQ2M6IFN0ZXBoZW4gSGVtbWluZ2Vy
OyBOaXRoaW4gS3VtYXIgRGFiaWxwdXJhbTsgS2lyYW4gS3VtYXIgS29ra2lsYWdhZGRhOyBTdW5p
bCBLdW1hciBLb3JpOyBTYXRoYSBLb3Rlc3dhcmEgUmFvIEtvdHRpZGk7IEhhcm1hbiBLYWxyYQpT
dWJqZWN0OiBbRVhURVJOQUxdIFtSRkMgMi8zXSBjb21tb24vY254azogcmVwbGFjZSB2YXJpYWJs
ZSBsZW5ndGggYXJyYXkKClRoaXMgZml4ZXMgZXJyb3JzIHdoZW4gY29tcGlsZWQgd2l0aCBMVE8g
YWJvdXQgbGFyZ2UgVkxBLiAuLuKAii9kcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19wbGF0Zm9ybS7i
gIpjOiBJbiBmdW5jdGlvbiDigJhpcnFfaW5pdOKAmTogLi7igIovZHJpdmVycy9jb21tb24vY254
ay9yb2NfcGxhdGZvcm0u4oCKYzrigIo5MjrigIoxNDogd2FybmluZzogYXJndW1lbnQgdG8gdmFy
aWFibGUtbGVuZ3RoIGFycmF5IGlzIHRvbyBsYXJnZSBbLVd2bGEtbGFyZ2VyLXRoYW49XQpaalFj
bVFSWUZwZnB0QmFubmVyU3RhcnQKUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1h
aWxzOgpDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5nIGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMKPGh0dHBzOi8vdXMtcGhpc2hhbGFybS1ld3QucHJv
b2Zwb2ludC5jb20vRVdUL3YxL0NSVm1Ya3FXIXRxM1oxZjhVQWxYYXRHLWRtVjBhRGdVaU1YM2st
VG5GVE1VTk5Ed0JpVHFzaUR0UE5IdUdLYlRaaUNOWUJqQlNGSzhDLURLZGw2ZHZVdUEwck02aFoy
OW1aWmxfWmN0YjVKSEokPgpSZXBvcnQgU3VzcGljaW91cwoKWmpRY21RUllGcGZwdEJhbm5lckVu
ZAoKVGhpcyBmaXhlcyBlcnJvcnMgd2hlbiBjb21waWxlZCB3aXRoIExUTyBhYm91dCBsYXJnZSBW
TEEuCi4uL2RyaXZlcnMvY29tbW9uL2NueGsvcm9jX3BsYXRmb3JtLmM6IEluIGZ1bmN0aW9uIOKA
mGlycV9pbml04oCZOgouLi9kcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19wbGF0Zm9ybS5jOjkyOjE0
OiB3YXJuaW5nOiBhcmd1bWVudCB0byB2YXJpYWJsZS1sZW5ndGggYXJyYXkgaXMgdG9vIGxhcmdl
IFstV3ZsYS1sYXJnZXItdGhhbj1dCiAgIDkyIHwgICAgICAgICBjaGFyIGlycV9zZXRfYnVmW01T
SVhfSVJRX1NFVF9CVUZfTEVOXTsKICAgICAgfCAgICAgICAgICAgICAgXgoKU2luY2UgdGhlIG51
bWJlciBvZiBJUlEgaXMgbGltaXRlZCBieSBFQUwgbWF4IGludGVycnVwdCB2ZWN0b3JzCnVzZSB0
aGF0IGRlZmluZSB0aGF0IGFscmVhZHkgZXhpc3RzIHJhdGhlciB0aGFuIGEgZnVuY3Rpb24gY2Fs
bApoaWRkZW4gaW4gYSBtYWNyby4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxz
dGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4KLS0tCiBkcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19w
bGF0Zm9ybS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY29tbW9uL2NueGsvcm9jX3BsYXRmb3Jt
LmMgYi9kcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19wbGF0Zm9ybS5jCmluZGV4IGUxM2NiNDIyODUu
LjFmZGJmOGYwNTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY29tbW9uL2NueGsvcm9jX3BsYXRmb3Jt
LmMKKysrIGIvZHJpdmVycy9jb21tb24vY254ay9yb2NfcGxhdGZvcm0uYwpAQCAtMTcsOCArMTcs
OCBAQAogI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgoKLSNkZWZp
bmUgTVNJWF9JUlFfU0VUX0JVRl9MRU4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLSAgICAgICAoc2l6ZW9mKHN0
cnVjdCB2ZmlvX2lycV9zZXQpICsgc2l6ZW9mKGludCkgKiAocGx0X2ludHJfbWF4X2ludHJfZ2V0
KGludHJfaGFuZGxlKSkpCisjZGVmaW5lIE1TSVhfSVJRX1NFVF9CVUZfTEVOICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgIChzaXplb2Yo
c3RydWN0IHZmaW9faXJxX3NldCkgKyBzaXplb2YoaW50KSAqIFBMVF9NQVhfUlhUWF9JTlRSX1ZF
Q19JRCkKCgpbSEtdIFRoZSB2YWx1ZSBvZiBNU0lYX0lSUV9TRVRfQlVGX0xFTiBzaG91bGQgYmUg
ZGVyaXZlZCBmcm9tIHRoZSBtYXhpbXVtIG51bWJlciBvZiBpbnRlcnJ1cHRzIGNvbmZpZ3VyZWQg
Zm9yIGEgUENJIGRldmljZSwKYXMgb2J0YWluZWQgdmlhIHBsdF9pbnRyX21heF9pbnRyX2dldChp
bnRyX2hhbmRsZSksIHdoaWNoIGludGVybmFsbHkgdXNlcyB0aGUgVkZJT19ERVZJQ0VfR0VUX0lS
UV9JTkZPIGlvY3RsLgpJbiBjb250cmFzdCwgUExUX01BWF9SWFRYX0lOVFJfVkVDX0lEIGlzIGEg
Zml4ZWQgZGVmYXVsdCB2YWx1ZSByZXByZXNlbnRpbmcgdGhlIG1heGltdW0gbnVtYmVyIG9mIGlu
dGVycnVwdCB2ZWN0b3JzLgpUaGlzIG1pc21hdGNoIG1heSBsZWFkIHRvIHVuZXhwZWN0ZWQgYmVo
YXZpb3VyIGFzIG9uIGNlcnRhaW4gcGxhdGZvcm1zIChsaWtlIGNueGspIHdoZXJlIHRoZSBQQ0kg
ZGV2aWNlJ3MgTVNJWCBjYXBhYmlsaXR5Cm1heSBleGNlZWQgUExUX01BWF9SWFRYX0lOVFJfVkVD
X0lELgoKIHN0YXRpYyBpbnQKIGlycV9nZXRfaW5mbyhzdHJ1Y3QgcGx0X2ludHJfaGFuZGxlICpp
bnRyX2hhbmRsZSkKLS0KMi41MS4wCgoK
