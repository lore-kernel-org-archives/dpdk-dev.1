Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206BCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 13:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E88534065E;
	Fri, 12 Sep 2025 15:05:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 715814065A
 for <dev@dpdk.org>; Fri, 12 Sep 2025 15:05:48 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9exXO003961;
 Fri, 12 Sep 2025 06:05:47 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49484m9bsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 06:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNUJHSf4psIC1orvWMJQS7adWjQCJthoowWFjOF3AslOOsg8iQAPSOqUznY6yH9Au+H44zLEEkRQUmvy7d/RWYNdTma1aW5i4RMXjw3KLWdmNGjHrXchrlXJ7CcDpd0JFNuu6YmrrRszeE6aPP+UzpwWt10YKspv4ECSrHRhTwo92z/dUXMflScCgxLXHbqJnBNepHeN4e1B6OZrw5HYqFv6jsls7sOOUFH9wBjdBMi1VZnYFHr0KLiz/+dlNpvMVbEtJoKj0ZANvG6ae3SaaTkpLn6zBRJh4yQ0uWKdauRUggoWFuursyKdVfaOoavWISDchFdpPCm1IeOwchK56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFB8PeHvSJmkoqzpvJVVFT57mUHD6wW9aIEP2c37Kkw=;
 b=gPQ3eAUp4H4pwOExsBHgTXG7pzGSOAjn0+G0tufKRytALv5NgmG1hdezpW4oQ3NWXyZghmQmZWrD3BNrqAwjUXNeWtuNwL1SxXWu+j0CPmM1GQ/eOADy4X8GUN83Mc4jQGNiUsIJ3ONfs+NGm1f4sLxT6MvZ+TKF2S1Le3SeF+jGKsDxfXeRzYSvNvqapfQH6399cPFSo325GxuMN3NsCs3H9BcLaTnjlIRwqXiQqrT7QFFoRDikoq3ZNuGzLGT5FxBWz9mOyPJTiokefS5ZqQJVGLmCTf7Z5wMMxVreMqmx3PUjiMtYYDE4oWYGZxs5ePYrcfMSaI9ATLh+GFS5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFB8PeHvSJmkoqzpvJVVFT57mUHD6wW9aIEP2c37Kkw=;
 b=LX6vaAy9FwJ/NeBJmVOLQs/CkrXs3zmT6ZkOsLy2j77pOrMiGL0+QQbgDZG+Wbv1TRHCS6pb9ydsOz8vgf92sNsnd1MZpI7DUvfKIBOj1dYPJCeP8ew7nfowA165bd2JrDkVEtkV+hIYr6nNDAc0YbQaCoEDaGVpN/c5N5QElsQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB4702.namprd18.prod.outlook.com (2603:10b6:510:c9::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Fri, 12 Sep 2025 13:05:43 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:05:43 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Topic: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
Thread-Index: AQHcFzcWJ7TeuTx1VUGp1mFxffzG27SPnK5g
Date: Fri, 12 Sep 2025 13:05:43 +0000
Message-ID: <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
In-Reply-To: <20250827094338.767062-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB4702:EE_
x-ms-office365-filtering-correlation-id: 93b2315d-3711-4b7f-3fe8-08ddf1fd14f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zy9XL2FFaDlEOWNqQlVBRkZzVDRxTDJTc3hjYTVSeXVkRU9UK2lwcFk2QlU0?=
 =?utf-8?B?VVpNTnMvNnNKdzd4UWNFVFNTMDZVSmlRYzRNdE9uZS8yQi9Dd084SlpCQ1hD?=
 =?utf-8?B?ak1pVjZoMGtPaXNjaWRWRGlEcDU3ZktjUytOaHZJblVUV25HQ1Bhc0ppQ3BT?=
 =?utf-8?B?L1kwQnAyaWlURnRNZ2xZdm9yYmFodmdGRTNVM1N6aXBDZ0tiOFg2bHZjSUtn?=
 =?utf-8?B?K3pjbW9LeTZOUTI0bkdTbEJuZys1cUpRT0ZYbzVlMWhnaVNJRGtFYlRyczRH?=
 =?utf-8?B?SDdUZGs5cG1ER01ycVkzTlY0RHBSN0t4Z1UwWkRCbEU5TXdzQ1hBOUd1VC95?=
 =?utf-8?B?UmtWbWFlM3hUVXgwRHpYallkbE5oMG9DbEprakM5YVpiaXhQZkk4cjdIb3c1?=
 =?utf-8?B?M2cxcU1DUXUrMGIrdFhidGp0K1NocVJZYlhOMzUxS1F0b3BKV1VNNnhEaEZH?=
 =?utf-8?B?ZHNWNjZYWmI0K0hhSGtOa3NTUXRnWVJaVW5YOUwvcnh3VFhxNGIwK2xDQUhN?=
 =?utf-8?B?dnhiMVBjUUNXV28wOFZqMFR4NXFwZDViUnNXdVphbW1mV3N1UUF4Rm9id05i?=
 =?utf-8?B?Q3pNSU5uNWF3NklmVGxTRkNrRTJEaVJ0UTVhQ0F3a0Z0aWswZ2orNmRmSzBY?=
 =?utf-8?B?eHA5T3NEcVBCYXpGNllnUlQ0S1VvU1FFWEtBeXVOYmF6V0o3bjRFcVNRbzcx?=
 =?utf-8?B?WVlnSWZWRFJtTFhmVXNBbEE3VitJSytBQVM5KzFHMnRnc2dWdndyR0hPbzNt?=
 =?utf-8?B?R3BVMTlCLzM2NGM1WXdEYnB5eXVZM0szaU5OalIyVk92L3FqZXYwamhwU2t3?=
 =?utf-8?B?MlR4eXVVcXI2QjgxUzBJVDhCRUFEV1pSMmd6TU1oNkdyeG9lUFM4aWJ3SUN5?=
 =?utf-8?B?b05HRGJDNzJzQ0pwZEhHemtLOU9INXMrUlNmTmtyMzlEZTEwN3RGOVV5TlEy?=
 =?utf-8?B?SFpueFdBZTJlcFVWMXdvWlI5ZEtudkdWZ3FycHoxcFdFVkdLUW54RU4yTUxW?=
 =?utf-8?B?Qll3QkxsVGxJNlVFbi9EYjV5WjFaTk5lNnZrc2NTZ3pXK25YLzVqN3dncVlQ?=
 =?utf-8?B?QXYxc1BmU001MStwYjgxTmlDRUkzWUU0WnRoSkVEWlNOZm9RWHlraGw0UC9Q?=
 =?utf-8?B?Q2dXYW85R3hUVXI0UExRQ1FTZWlYanFGTkJ4cm5MeVFURWdIc0ZrMWVDR0Z2?=
 =?utf-8?B?WjExOXFhNHh5MExNbHNsdUtIdk56K2RHbnYrWEhGWVN3ekhNRFFHMlFsc2dl?=
 =?utf-8?B?WTREcUhwUS9nRXgxdnVpQU5Sdk02V2x6RU90NmxLTmlNT3hobW11YWNDL3lN?=
 =?utf-8?B?SG9oNjM1U2JOcDZDTFhYVXlyQUR5V2JkSTB6bnZKblpoNnNBZDQxTjgrMkVF?=
 =?utf-8?B?dVdDZzZicUNXV3hka283RnNOdzRpUDhjOUJIYTBBNFY3dExJMzJoeXlUVnpv?=
 =?utf-8?B?eWZhYnBQclFHWGFYM1RMTDl3L3pEK1dJWFlzNDNHT3ZuUnN5SWF2M3VyNjJo?=
 =?utf-8?B?clh1RHFXSW1sUFcrMTlPZHYvTFpIQVRiZ0l6cjBkZEF5MEQxRHh3MjBreVZL?=
 =?utf-8?B?RW96aGVpMitKN29sbm9rT1hvNXA3K3EyTE1rOW1hOUhKZGh6bEhmdlcyVmJq?=
 =?utf-8?B?MGNLakFmaGdUL2l6YmtUbnZPMG1iTktXOHpaYjJRNTN5OUk2OG9WSFFCYS9r?=
 =?utf-8?B?ZEQ0RTZCRGlnR0RQRklzb09pdnEwdUR2RFQ3RDEzblBQbXFBTGx6bUE3ZzBF?=
 =?utf-8?B?ZFlZMUR4andhSFJoNUM4M3Z0MnBMQkRMUVF4bEw5QWNZSWtpVnZDbE1Lb1NW?=
 =?utf-8?B?QnhEU0NMNXF1K2x0dkQ4M09ieTEvTE9NM1NlRzREcFZrSldhM2UvVXF6Wm8y?=
 =?utf-8?B?NlZKdWpiMXNIRzhUTWF2bElqN3pUb3R0dmIyemtZRXFudWxNdzEwd0ZWb2ND?=
 =?utf-8?B?d1FEc0lVQW5GWjhpbTlkREhJbG9HY1BSdFBkd29Xc1lnUFFXUUx2Z0JWZ2s5?=
 =?utf-8?Q?nn6BunFh0QGKsgS4SPh5yOfTomDLdg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVBCUXZBYTQvdDJ0MVJQQkxEM3VKaGcvUXB1Mzk5bW1Jc3MzbWxNRDFBZjZq?=
 =?utf-8?B?ZjN2enZPQTBNdUx0dHBWWEcwUUdtQ3RZUkx0dWRLMFdTT205ME9IN1BEMDZ4?=
 =?utf-8?B?ZmI3Q2ZtR0hsbjIzc3gvTGpCS3JNT2ZPaVhDVkhlL1RSajFVenpjdTYrYm15?=
 =?utf-8?B?ZExXQnBuUEN5a2dYRHhKMHJ4dDFtbHNYb1p5OFkxL2NKaEdUWlUvdW9FUjFR?=
 =?utf-8?B?cW5sd08yeUFwNTRCbUFYc3F1S3N2Qi9UWEJUQ3BKWGdkWEtlMkRNK1VQWmQw?=
 =?utf-8?B?VFc2WWZNSksrMG1LWVl3cTd6ZWpjVFRRVzZCK3NJVEpoZHZtcjdGQ0hEbDVs?=
 =?utf-8?B?MGRWU0pUV0pTekRnQi9WanA4R2lPdG11V2s0QlVnMlBGNTFCQmhFaWlOYzVG?=
 =?utf-8?B?bVl6NFJuV1NYNkRNUXh0OEJ1V2ZFK0tXTHpsUnNjcFZjNGdRUWlpaE1wR2FJ?=
 =?utf-8?B?am40MU42amVtd2tvTElaNHRGbDJpVW5HMWRzMFV4VmtjbG1yOEcxNUkweVJa?=
 =?utf-8?B?aCtnYmFUMERJOVRXc2FJdEtLTHI5VENsWWRIRGtHSnQwVmluR2tuMGpGVGhB?=
 =?utf-8?B?OUhoSGxyQkIwS2Z0andvUEp2N1B0TEw4VFZtYmJGUS9kSmM3dlFTNHFDVTlH?=
 =?utf-8?B?VGZSWUdBWHpSYkFVWFdZKzlBS1VGTDRMZS9nRUh0NjhJc2w0d3l6a0I0UHU2?=
 =?utf-8?B?TThNM2E4U3dEcm5IcC9pUkppL0l0T2wrbUU2VWE4TDlyZVliSlhTVjlrMWw4?=
 =?utf-8?B?amMrNnNzaWhvUjBMZkFYNnY5d0J5WVRQSlJqYkpuVzNFOWNqRndNaWd0Rlhp?=
 =?utf-8?B?YWU0YUJucXlEZytSeUd0eTBPSGxUSEpyTjB6SlZwK3ZieGFYQ0hheG12MkxC?=
 =?utf-8?B?MVdVMmhkMjg0WFJrYndjMldxTFYyKzRJTDBuTDlpbllDeHk4cGVWYlJHUHJL?=
 =?utf-8?B?L3dEWjNiL0pmdjRFSDBaZ1BKUkNtVEtZV1p5Ykp1QTlkVXdEaEE5S2w5bWpB?=
 =?utf-8?B?ZEpMWGRUdlRGV003dEpLdnk0cmV1RnMvVXcxazlMbjAxNnJUUUhPY2pDV3J6?=
 =?utf-8?B?d3ZBdHVzZmMvNUdmMlRxdWNDVlZpS2IrNXJWN3U5Q3RxcHNnWkw5VVk2K3lh?=
 =?utf-8?B?OU84VWg5WEZEdTg1MkJOSklpYkxtcUtVNTVabzNDY0NSclRSTmlCbWtzYVVu?=
 =?utf-8?B?WTBSYytIc0s1K1lzcG85SHJxdDRpTVlsWDRabUZ2RjlmU2VUdkp0QUNEdURW?=
 =?utf-8?B?NkZ2enBsbFpjbjYvK1Jha21RZVYvNTRLajdGbFI2OXFxUEc1WHE2bDZraUxl?=
 =?utf-8?B?WGY0SEFHUGtycmJCVnJTRWtvM2FJcWd2QnNWZEdSd0EvanBnaVUxcVIxV2pF?=
 =?utf-8?B?Z0pndHIxQm0reVI4bmFWaGxESXV2c3hLT3FRalBGUnUzTVFMUnA1OE5UZzFt?=
 =?utf-8?B?SVBqWWdJekUzekU3UTBDYzZwZzlxekJuR3grdDN0TTFad21QdkRIQWxDbmU3?=
 =?utf-8?B?WDNVQ3k4OUlCa0FVYXNtVEE2MktCVkRUWURXY0xlcDlna1ArSnYva2pSU0NE?=
 =?utf-8?B?UWdJcTdGQTZUYlF3Y3BHV2tBMy9YZm4yTnVjWXQ2SjlEeW1CKzU1YUJET1Q1?=
 =?utf-8?B?Vk5JeGUycmd2VmZ4aWdBbk5oNmhGMFBsSU8rOThQSFFFckZKTjZvZFYwUlp6?=
 =?utf-8?B?ODgwT04vWFg2RTBVaVFZSDlHUkJHNk83QjlKeHU3U1BYdWJGVWV4blE2QktI?=
 =?utf-8?B?amgxblpQRGlCWlh5aE16Mk1hWTAyd1VtVk9BUXRLLytxZDVkMTZNWDVEeWJz?=
 =?utf-8?B?V2NMT1A2bE1GRTltZEwwZnQ4UlZwNzI4UmhPM2pKSEJmZ1BQMUNXVXoyQU94?=
 =?utf-8?B?YUZ2bGhteDhvQzlhamswSDV1VEZ4ak5PbkdCODFzamF2VThmY09tcU55Mmpx?=
 =?utf-8?B?ZVBiT1dwdmdhQXkwb2ZwQ0taUzRpakFwVEhRc0JnaUtDMnI1QmQyV1FMK3p0?=
 =?utf-8?B?eU1rQkFJTFVCbEs1Tjd1aEhJY3ArK2hMc2tvdHJEUzZZOGJuNGZNekY5L0E4?=
 =?utf-8?B?REgrT0RYWkx0cGdVUzdOM2J4VXlpYWhKWmJsRkFRbnRzTThBUnlHbkV4ZWVN?=
 =?utf-8?Q?G5lE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b2315d-3711-4b7f-3fe8-08ddf1fd14f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 13:05:43.6699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9zqZaI7gWiVhY7ArpGKYvnkpWU/i2fkkiQ5FAT5m26kxf45qc5D9gz8emd+Hc/pWUrwmarFGCls5gadlt4/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4702
X-Proofpoint-ORIG-GUID: _n50gPaLKhvadUQy76xLhOBejWlPLUCQ
X-Proofpoint-GUID: _n50gPaLKhvadUQy76xLhOBejWlPLUCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDIxMSBTYWx0ZWRfX0O0uZDgSJ3i6
 h7HSL8NJ1QleluP1fIbrVRppuspgpXbhThidAXWOPTCTkaiFCv+8jSzDc7x00IrAa8x/JDzbEEx
 Oy+AjDyeDq/PdUAqwL49Es1u/hwkrbHL7L1qJdZC3gJVy7PXSKuFoIzaqytYbeS0XouAi13mLbL
 OA8aw7IA1KpMiPUDPfT6hHckxRJ7KkE9vw0ErAti0urwxqsUB4FvQqth1pfOqi/WzNqXDKVWecJ
 7h0xbuHAgjo0lsO1GI5B+1CCSwNrS211QWS+cibX9eJWwFO0CQ+OapSdw8lchtK0XVJNkuc1W12
 2RxwbIl45ZenqhSncVOqBQWcQunxZFmUa9sbybBAApOB2/PSBn+AcamlTRvgi+yTVkYBPg+GGhB
 dG6835vR
X-Authority-Analysis: v=2.4 cv=FL8bx/os c=1 sm=1 tr=0 ts=68c41aab cx=c_pps
 a=QKEJDp8YRlFul3h//pGKrg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=QyXUC8HyAAAA:8 a=bga3hB8dg0eg3nX7KTwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
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

SGkgUmFkdSwNCg0KPiBVcGRhdGUgdGhlIEFQSSBkb2N1bWVudGF0aW9uIGRlc2NyaXB0aW9uIG9m
IHJ0ZV9jcnlwdG9fb3AgZmllbGQNCj4gYXV4X2ZsYWdzIGFzIHRvIGFsbG93IFBNRHMgdG8gZGVm
aW5lIGRyaXZlci1zcGVjaWZpYyBmbGFncy4NCg0KQ2FuIHlvdSBnaXZlIGV4YW1wbGVzIG9mIHRo
ZSBmbGFncyB0aGF0IHlvdSB3YW50IHRvIGFkZCBmb3IgZHJpdmVyIHNwZWNpZmljIHdvcms/DQpJ
IGJlbGlldmUgYWRkaW5nIGRyaXZlciBzcGVjaWZpYyB0aGluZ3MgaGVyZSBtYXkgbm90IGJlIGdv
b2QuDQpNYXkgYmUgd2UgY2FuIGRpc2N1c3MgdGhlIHNwZWNpZmljIGZsYWdzIGFuZCBkZWZpbmUg
dGhlbSBhcyBjb21tb24gZm9yIGFsbCBQTURzLg0KDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJh
ZHUgTmljb2xhdSA8cmFkdS5uaWNvbGF1QGludGVsLmNvbT4NCj4gLS0tDQo+ICBsaWIvY3J5cHRv
ZGV2L3J0ZV9jcnlwdG8uaCB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9jcnlwdG9kZXYvcnRlX2NyeXB0by5oIGIvbGli
L2NyeXB0b2Rldi9ydGVfY3J5cHRvLmgNCj4gaW5kZXggZGNmNGEzNmZiMi4uMzhjOGFjYmY0YyAx
MDA2NDQNCj4gLS0tIGEvbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvLmgNCj4gKysrIGIvbGliL2Ny
eXB0b2Rldi9ydGVfY3J5cHRvLmgNCj4gQEAgLTExNiw2ICsxMTYsMTAgQEAgc3RydWN0IHJ0ZV9j
cnlwdG9fb3Agew0KPiAgCQkJICogdGhlIHN0YXR1cyBpcyBSVEVfQ1JZUFRPX09QX1NUQVRVU19T
VUNDRVNTLg0KPiAgCQkJICogSW4gY2FzZSBvZiBlcnJvcnMsIHRoZSB2YWx1ZSBvZiB0aGlzIGZp
ZWxkIGlzIHVuZGVmaW5lZC4NCj4gIAkJCSAqDQo+ICsJCQkgKiBJbiBhZGRpdGlvbiB0byBSVEVf
Q1JZUFRPX09QX0FVWF9GTEFHU18qIHRoZQ0KPiBQTURzIGNhbiBkZWZpbmUNCj4gKwkJCSAqIHRo
ZWlyIG93biBvcHRpb25hbCBhdXhpbGlhcnkgZmxhZ3MgYXMgbmVlZGVkLCBzZXQgYnkNCj4gdGhl
DQo+ICsJCQkgKiBhcHBsaWNhdGlvbiBhbmQgdG8gYmUgdXNlZCBmb3IgZHJpdmVyLXNwZWNpZmlj
DQo+IHB1cnBvc2VzLg0KPiArCQkJICoNCj4gIAkJCSAqIFdpdGggVExTIHJlY29yZCBvZmZsb2Fk
DQo+IChSVEVfU0VDVVJJVFlfUFJPVE9DT0xfVExTX1JFQ09SRCksDQo+ICAJCQkgKiBhcHBsaWNh
dGlvbiBtYXkgcHJvdmlkZSB0aGUgZXh0cmEgcGFkZGluZyByZXF1aXJlZCBmb3INCj4gdGhlIHBs
YWludGV4dA0KPiAgCQkJICogcHJvdmlkZWQuIFRoaXMgZmllbGQgY2FuIGJlIHVzZWQgZm9yIHBh
c3NpbmcgdGhlIHNhbWUNCj4gaW4gdW5pdHMgb2YgOEIuDQo+IC0tDQo+IDIuNTAuMQ0KDQo=
