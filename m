Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5ADCCD183
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 09:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BE24427BF;
	Sun, 19 Oct 2025 11:41:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6330F4013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 11:40:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J9QM4i013834;
 Sun, 19 Oct 2025 02:40:57 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022098.outbound.protection.outlook.com [52.101.48.98])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49vwb5g0qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 02:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxKjPoDhJCoKJhupoGkrgJQAwkPhskv7Yzwx+YV26skBdyj49vX3Xa/h0lDR7/VmwL06iww8hFNTqk4l0WwWf9mmRFdUe7veqkcjIL5SpVmeBgaEYe9c0JKLRYqDY7aX6jeDlHAT6NidSx2Fgm+GepAI4MpftEm+ECweNH0RrKVEPD+xBhlXDoBXX7YKBR3m8+jgltB3jL4wZQBnzKXUaPQcUwX8qN+/niFrOESkTdYtRhkCWsqOn4bMVjdTDuDWC8zrA28GdvsVgYRZW7K7IeQu77qF3mluZUSIg/6q4FqNtKiKUaom210AUX8wwWhSCe0feI442EVJYg57P1WeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eQyRCTeAVdVCs5rrKDhAidKi0ZeGOwmzFPQd0G/rkM=;
 b=xK/arpWQAb3viin7CahSD+GIift4QocddoLd7UEOoKGryuyyjycvkntruFaprSMClMhqfw5Ok3gD9XFCeNUJhSWoTj1WvSLcrfJ1TkAGeJTOk5sifp1pqpvlYv5yauT37hbebM4HTVmmq6QSzHXd9UMeyGvnAm+Ly8e+D3M3O0eHzYVBi3Ow/Zb1CH8nFAK5tCXZTz4WZ0IAM+tBC1h/yUdHGnHyIRNfFgSg5/z9eQ4r0uTZkuHe2YNeQfz6rUxJ8dyt48B9Jw1tbH8rWgrObHB6ucW3sNg0/jHUTGYvoqSM74QbU4A07J5T7PS2BGY/ULPer28YQmuHv10KqV8Dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eQyRCTeAVdVCs5rrKDhAidKi0ZeGOwmzFPQd0G/rkM=;
 b=r0Fdzxu7JeD0CvOIZ3kFivIZF94tjyiSUh/OBnYiy9lUBe5GFamEg7l02Woucg0bs/JNpGW639QC/3lk+aj++0ib35lPjN44G8UZ4i0yT5e3ZOWsNmbUf3SAl0G0gkk9H6GYmEcPvQf8xo2vZLCi6ke/Bb5FpFRSCXRN6hc41k0=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by PH0PR18MB4637.namprd18.prod.outlook.com
 (2603:10b6:510:c4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 09:40:54 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 09:40:53 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs for
 inter-domain DMA transfers
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] lib/dma: add control-plane APIs
 for inter-domain DMA transfers
Thread-Index: AQHcP29T6oCwn4C/jEGZqX8lPtkz7rTJITwAgAAF1nCAAAd7AIAACoCA
Date: Sun, 19 Oct 2025 09:40:53 +0000
Message-ID: <SJ4PPFEA6F74CA2D94960610504A37EF3E1A6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251017122610.3126992-1-vattunuru@marvell.com>
 <3166338.vzjCzTo3RI@thomas>
 <SJ4PPFEA6F74CA2C8C8EAE365AE5505773DA6F4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <4681397.3daJWjYHZt@thomas>
In-Reply-To: <4681397.3daJWjYHZt@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|PH0PR18MB4637:EE_
x-ms-office365-filtering-correlation-id: 0de221d6-f6a2-423f-2add-08de0ef398f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEFWU3MxdjBqdVhIYWVuczBINHRrRFVya1lFbStrOHZYTkpQZExUNTVXcnla?=
 =?utf-8?B?eWpxZHFlSzljOXpBV1U0c3FVUU9aWmdiTTFQdk9HSzROVFZrNWtqc1MwVUxQ?=
 =?utf-8?B?KzI2bFRsNFJTWVJIdUswYTM5MnlBZUdNUmxkMWdRRUo1MkhIZVlVQW9WL3hr?=
 =?utf-8?B?RUx6dmpUbXVwclBMd1VFVVBYSHNNUThwcEJoUEZmdDVQYVgrY1Y4d3RsaTN4?=
 =?utf-8?B?aGhLSFJpczdBandEdHNGWmh4R2g0Rm9vTk9qWG1ZVmcwbG5kRENsUU5YZ3J4?=
 =?utf-8?B?a05uNldZeXpXb0lWKy95RGFmQmRmd3NudkFWaU03amZoYW1vWGJGcnI4dG9C?=
 =?utf-8?B?Z29ablBPM3dOam5RTVl6cWJZUFo5WitvanlVSnJmQnI1SDNCK0syWCt5VENU?=
 =?utf-8?B?cVVVMlJrV1lwSDJsZC9lVElHNXdaYUJ6RWw0QlArMVR2Y1NIZHgrNXpDTFVI?=
 =?utf-8?B?cmUwcEZoSUlzaVppeHNUNzZlbG1tTVQycVl5VnYxanRGU2ZSU3NEY0pBeWsz?=
 =?utf-8?B?UU5Ncmd5SUdMa1R5UlpqOEhYNmdWaURsQ05NUUlLVzk0WEVuWkZiNjR5QStj?=
 =?utf-8?B?YTVYWUJ5TjRuQmtRWGZjclJyYVZySUE0MGVvUXdlWXFuUDAwb2s5cmIrcDgy?=
 =?utf-8?B?WHpaN2dOWmZHYmIxK1B1T2pjb284T1A4a3cvWDdVSXI5b1NRcDhIVEZCQkhN?=
 =?utf-8?B?djB0Q2VqeW8zSk1wR000Z1FJMHRXMUwwbHRJT2JaSERKK0dvTnlGMzhvKy9z?=
 =?utf-8?B?ckJUSml5c09ETjdJOUcrYTd4VDhOTG5mN3lmN3B4Z3doRHdjaWdoUU1OY0lH?=
 =?utf-8?B?U1cyem50QXREOTF1NWNtU1UrQUZ5am5BMnZwL2VRa2F0L3hKaGtHTlN1WVE1?=
 =?utf-8?B?YnYwN21tNUZ5cURRTXdYMXVpZ2hiL2lNcFBaYWJBRUsyZllzcWJlczEyL1FN?=
 =?utf-8?B?dUZaYnh4N3V4c1hGSjJQV3Q3eHA1T1E4a1lOYnI3QllMcDFxczBXc1JrR21h?=
 =?utf-8?B?NnFjejlUdm1aR1o0S2tLbURTSktJVUNrbTJnUDBsaXlCVFZkQWpJZVVOOWpR?=
 =?utf-8?B?UGYxUXowVEJpZ096WnZISVJrQkJ6M04vTHUyeEdBTTVnUkZnbzlERzJKWXN0?=
 =?utf-8?B?TVArc0s3eXdSVTRlYzFwUzVGTm5OUDU0cVFtdC9nWUdyRlNtZkxjcGIweE16?=
 =?utf-8?B?UHovOUZTdFhic3drSEcybk9zQU43aURkTzNBMXhhRGtrT0xGVGVlcmxRVnNa?=
 =?utf-8?B?ZWNKVWl5MXF4VHM4MDBnamxkeFpDam56dVIwK2cxMStVL1d1cWVhcFc0S3BY?=
 =?utf-8?B?WTQzSmY1eFR0bkRxNHlLN3Jic1UvUG9SZTZtOXlZcUNOelRJZGlJdXllVlJu?=
 =?utf-8?B?bkV4STRSUmRjZHhTWGt0SWw2WHEyNVpibUhqaEZDNXIvbWd6OVJMc0RDenRY?=
 =?utf-8?B?MWVIUzFvcFU3T0NYQlVlcWpuSWJ2ZnBESk9waEU4bW5OOGVPRExKc2JMeTl4?=
 =?utf-8?B?U2JYcm5JRThjeFZJMzJWaWhBN3pFVVh1SWNZTEpZbEV6RHNTVnpVa1ZXUnpZ?=
 =?utf-8?B?S1JUWkNQR2dPaTVJeTNNWUE4WTB1c3NVL2NwQndZQlo2aktGOGM2a0E1M0tk?=
 =?utf-8?B?MjNqaHFVSFhHb1VMei9hODJVUnk1SHdKSlg5YmlCTzk5SEZ1NnI2SmYrbWZX?=
 =?utf-8?B?dlhkWnpwMkdZRnBLdHgrS2xReis5RmNWK3ZWS2JrdUhxWmZCTmZIbi9lV2lJ?=
 =?utf-8?B?QWo5dGZic2taaXh4ZXdlTlVIV3UxT3NZV2t3MGw5dlpvL21vbWtKTFZBVEl5?=
 =?utf-8?B?L3hyZi9HeVR6Z0tCSk9heTdjWUc0RVpRVkhtQU41R2RUS09UTlhSVzhlMEFF?=
 =?utf-8?B?YUlvb1A0ODk5eFhqbWIwallyaGxDTnRjQjdKREJ3czV0YXIzcmZCZnpOQnJX?=
 =?utf-8?B?NGFlamV2OUxvNmE5UHJ0THdySUdzV1NaeW42Sk9WM1dKRzRxUElnZXZuZ0xQ?=
 =?utf-8?B?LzdvUmc1Qk9BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVrOVltQktUL1d3ZkcyMmh4SEtNWDZXSkRpQnNUZ3FSOEpLQ0RWY3MrenEv?=
 =?utf-8?B?T3YzVkpWR1pReWZyZ09TTTlYbStocFo4bDROWi9JWm5PUmErK0hRZXQzUTh0?=
 =?utf-8?B?NENDNHdoT1NyVGlBNUt4dVoySGdGWUNnSU9icmp4N2NkZ0xSeGVYUnN5WU1m?=
 =?utf-8?B?Vms2MktnbW5JV3lkaDhnazV1bkpLbjU3RmlaWXd4UFJNMDh6UjR4dmtxSFJM?=
 =?utf-8?B?RXl3aEh1d3gzNDNBRkZETmpYN0ZnT3BmQjMyQkd4aHg5Z1NLSWxBRnF4MXJs?=
 =?utf-8?B?REF6NlZoY2hwY2poU0p6bVJrSXU2cC93MkUwUmJGSmhqQTEwMksrcXZtV1dz?=
 =?utf-8?B?TDZudno4c3hsZTNETTVTbERVK0xRcnZmai8vakdrMWd0VlFUZjlzTjN3ZXI3?=
 =?utf-8?B?RGRpYkt6NHBNMDljNGJRR1lkSjhZZ2N6Y1VicWNPN1BDaVBReFpzd3VjL0VC?=
 =?utf-8?B?Y3ZxSExlYUR5OHoxZzNsY2dqWnNveUEvckFwallmdmxjTzFhOFd6eFF4YmZS?=
 =?utf-8?B?RFdUbUVZeUhNMjFNdXpCV0JITzhLYkU5a0laSWh3eFdyeStXUWRJNEZ5WnVT?=
 =?utf-8?B?UkxBTXAyeHVaWXFaelBJUHFkY2xjQ1c5d2ZaL1hjVC9GV3NLVFJRYmNlMzZj?=
 =?utf-8?B?ZXJFU2taWmloRENTYk9KdE9mNzBXMzFoMGZ2N29oczZhYlA0OWNjbklRQXg3?=
 =?utf-8?B?UkwyOGMxRkpsUGhLWlM5bC9CRk5QeHJ3NUxrWnR5QmFkNVBOcnRKSU41NURl?=
 =?utf-8?B?UGdmZElmQ1A5SkozSGI4ZEc2REdvUlBWL1BkMGdkcHNJWlFlUkxUNFA1M3Y4?=
 =?utf-8?B?VHlZM2RpNDRWbENnSmE5UjRUay9UTHA1ajBqWjRwbmhuejlJQUVKM2xaV0xG?=
 =?utf-8?B?Y1luYmlMUUVlN3hKcHFiSGQwMWRFem0ya1lHVnlKUG5rRmRjRW93UzlBSzF6?=
 =?utf-8?B?b2Y2U01lZ3hzNUIzVnZ6bGRvZ29CMWtmTzB6bEJSWmljQjVVemwwdnlwRWtv?=
 =?utf-8?B?QVFDQ3pjekVPVzl6N08zNE5lTm43ckxMNjNNSkpudWZmdmpSUzBkVUV3S2sz?=
 =?utf-8?B?V3Zteksyd2RWdUU4Y0ZmVUlJZzZPdVQvcnV2OS93ZnBoNnJmVWNqWEU0TFUr?=
 =?utf-8?B?L0xxdHgrNkdnaUxsUE5acm9wTHJGWFlrbUZKM2VjRWZqV3crMzhJQ01pTXRT?=
 =?utf-8?B?RzUwVzZoN2YzUDIvNGYxM0EyYXFEa1RKK1haWUZPeFozMDk5TmVzczhYSysz?=
 =?utf-8?B?RlRpTnBOY3JuRmdGNFB4NUJPQmFrdmhCay95Z1lnSnpBQWlVRmRtRGpiSkVI?=
 =?utf-8?B?V3FXQlJGczZQdlRFcExRYU5MbVBtMExvUTcydGJycHBweDNxOC9KQjlkbm1R?=
 =?utf-8?B?TldiR0hBWUNkb0VjanJJOXMwSndBWkxrNzg4eld6UVExQmNiNzA1cDlRakVU?=
 =?utf-8?B?dkVabi9WMTdxcWNaNWdrbmlrNnk1ZTZKWlY4Y05QTHBmWUpYUHlWSXRoVDdU?=
 =?utf-8?B?SkMwU1FpL2lyK1RMMEp6UDIxQnZXMGJXVExaWG1oQXpBQ1RXVTU5SUVRdjNW?=
 =?utf-8?B?SUZSSWl5RSsxaU5WRW9ocXFGa1FoVE9nOXBpelh3RmhBMVd0ZUE3WTFETEhJ?=
 =?utf-8?B?ZCtXZk5Tc1cxKzAyUzQ4M3N5aVpCTUZmU2N0WDQ5S3pjemhkbXhYS1g0dmJ1?=
 =?utf-8?B?SHRuWDFheWNOODZvb2V3Y2w5SzcyRklGckdoWGZqbDlZSEhJSHVDamlWN2Vt?=
 =?utf-8?B?bmt6RzFVdEtIVVNFQ0FJTXNPVDc5VFcrR3R4aFhYOTYzOUFva2xzZ1JNWXQ2?=
 =?utf-8?B?RVRNR1NnNjZNYlp3OTFRSGZQYjI3YWRLUHAxazVFZ0VmaHBOSkNBTndhMTYr?=
 =?utf-8?B?SDdFSjN5bjhyZjJ6aXlRV3JzZ29OajFDeEc5TitOUUlueHMyamptQ2NMcHNZ?=
 =?utf-8?B?S0hyMndXdDlKNjhSM0x5QXpEemwvOTBRME1uTEV5U2U5MjdBRWdxU2JtSXov?=
 =?utf-8?B?MUxUM3pBM3E1VldtZjlqSlpmYWVRVExoNURRWmtmU3dPNm1lbUJLYndCaVpY?=
 =?utf-8?B?cU91V20zcHBkd1FGQlNsTitUeFJUc2NLMFE2SkFJM09GN0plNU1OOUt5cjI5?=
 =?utf-8?Q?gWh7OwJRE901AEtGyKAPgdrkz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de221d6-f6a2-423f-2add-08de0ef398f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2025 09:40:53.9057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XWmfnOhVkW4TQTGs9D5RmB+G8r5DM2xlABjMM0J1axULbrmZvsSIJQrLmaFg3WbvE11IkPKKuQ3wuUo0yr9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4637
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA2NSBTYWx0ZWRfXwMDD6f06Wa8h
 HmIyc6k5sH76JWQLITTCLmOYq04wDTNAlFWzzh0FpxsEoYvTvDTmdBpEkvKzZmqUR1X+LMDRj+s
 NqcwHMUxEUkX3qYhAJXQd1Z17NqVe/KY3YU3hw4KnnzGvQYCaMb/6sS+auqj+dzr+oD2tH2w0Z0
 OSpiTnfCXi+jn4vAjtVuhPpvwHMXODFrh17Vj6DKS7f+VL5FNVp9CX8UuihMyvaN177iLeVts1h
 ZCqvGsLMUbrMSZ8OfGAxpT5RixzAABXG5aOCybuzacGKjtFpgX/J4B9zXH5WXFmAP6Ry238qmdo
 sWRIVhEliZkLj5mXSPqjtonofvBAh6uVZVxTaIO/kipaAH6JJcWybsvjfSv7fCgUmPFgxNrrToX
 GMvKYWlaHb1Ljp1m7g6qxBojDB8EAw==
X-Authority-Analysis: v=2.4 cv=WKByn3sR c=1 sm=1 tr=0 ts=68f4b229 cx=c_pps
 a=JnPQUT+nmGgr9A6OKrSlWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bt5KbKNvAAAA:8 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8
 a=QyXUC8HyAAAA:8 a=RpNjiQI2AAAA:8 a=Y3MThTQWeS2AKb7hA7QA:9 a=QEXdDO2ut3YA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 7B9mnnAA1TVPPfhKgNECzVeA2XY7vxFR
X-Proofpoint-GUID: 7B9mnnAA1TVPPfhKgNECzVeA2XY7vxFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_04,2025-10-13_01,2025-03-28_01
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRob21hcyBNb25qYWxvbiA8
dGhvbWFzQG1vbmphbG9uLm5ldD4NCj5TZW50OiBTdW5kYXksIE9jdG9iZXIgMTksIDIwMjUgMjoz
MCBQTQ0KPlRvOiBWYW1zaSBLcmlzaG5hIEF0dHVudXJ1IDx2YXR0dW51cnVAbWFydmVsbC5jb20+
DQo+Q2M6IGRldkBkcGRrLm9yZzsgZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb207DQo+YnJ1Y2Uucmlj
aGFyZHNvbkBpbnRlbC5jb207IGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb207DQo+a2V2aW4ubGFh
dHpAaW50ZWwuY29tOyBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPg0KPlN1YmplY3Q6
IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjQgMS8xXSBsaWIvZG1hOiBhZGQgY29udHJvbC1w
bGFuZSBBUElzDQo+Zm9yIGludGVyLWRvbWFpbiBETUEgdHJhbnNmZXJzDQo+DQo+MTkvMTAvMjAy
NSAxMDrigIozNywgVmFtc2kgS3Jpc2huYSBBdHR1bnVydTogPiA+SSdtIG5vdCBzdXJlIGFib3V0
IGhhdmluZw0KPmRpZmZlcmVudCBBUEkgZnVuY3Rpb25zIGZvciBsZWF2ZSBhbmQgZGVzdHJveS4g
PiA+SSB0aGluayB0aGUgbGFzdCBsZWF2aW5nIHNob3VsZA0KPmF1dG9tYXRpY2FsbHkgY2FsbCB0
aGUgZGVzdHJveSBkcml2ZXIgZnVuY3Rpb24uID4gPiBUaGFua3MgVGhvbWFzLiBUaGUNCj5aalFj
bVFSWUZwZnB0QmFubmVyU3RhcnQgUHJpb3JpdGl6ZSBzZWN1cml0eSBmb3IgZXh0ZXJuYWwgZW1h
aWxzOg0KPkNvbmZpcm0gc2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eSBiZWZvcmUgY2xpY2tpbmcg
bGlua3Mgb3Igb3BlbmluZw0KPmF0dGFjaG1lbnRzIDxodHRwczovL3VzLXBoaXNoYWxhcm0tDQo+
ZXd0LnByb29mcG9pbnQuY29tL0VXVC92MS9DUlZtWGtxVyFzMDNaRlQ1VWdoVDZGOF9XTV9JV2hh
d28tDQo+ME5ZRkp2bXNWUXZUYTIyUnZXbm1PYzlzamdHc3JQQVZYcFVXeXh5YTM3akx3JD4NCj5S
ZXBvcnQgU3VzcGljaW91cw0KPg0KPlpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4xOS8xMC8yMDI1
IDEwOjM3LCBWYW1zaSBLcmlzaG5hIEF0dHVudXJ1Og0KPj4gPkknbSBub3Qgc3VyZSBhYm91dCBo
YXZpbmcgZGlmZmVyZW50IEFQSSBmdW5jdGlvbnMgZm9yIGxlYXZlIGFuZCBkZXN0cm95Lg0KPj4g
PkkgdGhpbmsgdGhlIGxhc3QgbGVhdmluZyBzaG91bGQgYXV0b21hdGljYWxseSBjYWxsIHRoZSBk
ZXN0cm95IGRyaXZlciBmdW5jdGlvbi4NCj4+DQo+PiBUaGFua3MgVGhvbWFzLiBUaGUgbGVhdmUg
YW5kIGRlc3Ryb3kgb3BlcmF0aW9ucyBhcmUgaW52b2tlZCBmcm9tDQo+ZGlmZmVyZW50IGNvbnRl
eHRzLg0KPj4gR3JvdXAgam9pbmVycyBjYWxsIGxlYXZlIHRvIGV4aXQgdGhlIGdyb3VwLCB3aGVy
ZWFzIGdyb3VwIGNyZWF0b3INCj4+IGNhbGxzIGRlc3Ryb3kgdG8gdGVybWluYXRlIHRoZSBncm91
cCBhZnRlciBhbGwgbWVtYmVycyBoYXZlIGxlZnQuDQo+DQo+SSB1bmRlcnN0YW5kIHRoYXQsIGJ1
dCB3aHkgaGF2aW5nIGEgZGlmZmVyZW50IGZ1bmN0aW9uPw0KPllvdSBjb3VsZCBkZXN0cm95IGF1
dG9tYXRpY2FsbHkgd2hlbiBhbGwgaGF2ZSBsZWZ0Lg0KPg0KDQpZZXMsIGJ1dCBJIHRoaW5rIHRo
ZSBncm91cCBjcmVhdG9yICYgam9pbmVyJ3MgY29udGV4dHMgYW5kIHRoZWlyIGxpZmVjeWNsZXMg
bWF5IG5vdA0KYmUgdGlnaHRseSBjb3VwbGVkIGhlcmUuIElmIHRoZSBjcmVhdG9yIGludGVuZHMg
dG8gbWFpbnRhaW4gdGhlIGdyb3VwIGZvciBmdXR1cmUgam9pbmVycw0Kb3IgZGVsYXllZCBjbGVh
bnVwLCBpdCBtaWdodCBsZWFkIHRvIHByZW1hdHVyZSB0ZXJtaW5hdGlvbi4NCg0KV2l0aCBkZXN0
cm95IEFQSSwgZ3JvdXAgY3JlYXRvciB3aWxsIGhhdmUgZXhwbGljaXQgY29udHJvbCBvdmVyIGdy
b3VwIHRlcm1pbmF0aW9uLA0KYW5kIG5vdCBpbmZlcnJlZCBmcm9tIHVzYWdlLg0KDQoNCg0K
