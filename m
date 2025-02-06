Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC7C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 12:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2957A402CE;
	Thu,  6 Feb 2025 13:08:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0F2604026C;
 Thu,  6 Feb 2025 13:08:41 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516A9DOw030262;
 Thu, 6 Feb 2025 04:08:41 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44mu2tr5ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 04:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISZPsRcrIKCWm5X/WXTxyPidZITBvRbWcDfDkhVNrz2uOkmQ8EaLN4s6KSpOVlQiQo/5CxrS4Q7jMe4CvD7iATa0johwETGgl7Q3bSpUu9sy4DXo09PoEleV2quf/ai1i3klQDlUqhJyUM2hRSDoM+Iw+aGK5UARSHdu2ajuCEI4Ndi+GTYL8VqaCGb2xjdsU8JBm/oXaVKFUgQ7vDzdGZi7+vuzJKoJNFcvASg1jDMFFOL9m8dldVEo6VUJfNO2okmZ5hM6U15p5sjHHGF3N7Q7Tet6YRC2ux0hTWGzFrrmpP61PBzGiu3mIaTIZbYH9ayIwrbdgD/UGEJKgKDJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWkxMlVAoEQ3eUCm3+aOsxzQS8AHcg7NZdsU2gtETdY=;
 b=UQlYMFFHJNpCBLeEk4F2uPUSGuGY+envIONTDGKbx+dmFXUehwqwOoDRCHHZMhuc/RZrRlyxTPdza32Zp52motBNDj6yBAnhCmH3B8EVGIokpbtC0jO5x/tsT9rpuBfrnA/NuZD+7f3ZR80RgV7+Kf0J0/76z0Z09qF1lR5RARIKDkTNDMoy00mXjyVrluGl84UazPxfxZNyvT84F/8X8c8rQjywhWfRdSq6iBy4Ro+80h8AacITF3lk375njH07MdNM/yBJnWWkcJ+CQhQIAoPBNYjTEXtPGogqTlrZ7UTEBXrDX3Jy0aDaAR+aVeJsFYU//fUNvVr+1MfRNZN87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWkxMlVAoEQ3eUCm3+aOsxzQS8AHcg7NZdsU2gtETdY=;
 b=nABYeJ9cXpNQWdSAzjt90vydfwm5Zjp0SV1VBZ/g36TvlRInnWm5H7MWjJLEpbH7gmJnTT9CtXEmbnmPFShJX7MaHwe0NXRuKWgEk1vMZggiWhWfGqwiCNYossewOL9aoKxxBBpRD5w32RMN+AAucybRuzK/yW72KLUW+0nqbUM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB3802.namprd18.prod.outlook.com (2603:10b6:a03:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 12:08:38 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:08:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 1/3] lib/cryptodev: avoid implicit
 conversion to 64 bit number
Thread-Topic: [EXTERNAL] [PATCH v3 1/3] lib/cryptodev: avoid implicit
 conversion to 64 bit number
Thread-Index: AQHbcPJURDQj2YIjMEaLJzfH9r+QP7M6PY+g
Date: Thu, 6 Feb 2025 12:08:38 +0000
Message-ID: <CO6PR18MB4484B42B259445B151F41804D8F62@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <1732758837-6350-1-git-send-email-andremue@linux.microsoft.com>
 <1738006389-17193-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738006389-17193-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB3802:EE_
x-ms-office365-filtering-correlation-id: 7b344e02-1560-4b15-cf33-08dd46a6fd0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmpWeElnWnRna2dSYUNmMmp4NWd6ODF6SzVCaEtVeUZ5dlhXY3dvMnBjeWlD?=
 =?utf-8?B?aC96bTJ0bXJmT2FhR0duVVZaV3RmTzVSWlAyQm9aU05GcWFiZzRPZXllM1Qr?=
 =?utf-8?B?bjdwdEVzZmlVMmo2THJFR0o3Y0Q5S3g2VG9tODQxVEdFRUFOSk5GR0diU2NJ?=
 =?utf-8?B?RHRqT1VsMDB5VUM3a0lBMENBMVJydWtXSzU2OFk2TTZsaFNpMDhHUWkrNDJx?=
 =?utf-8?B?VSt2R01XQlI4ZHRwUEN3WllnWUgxcjVibEp0MUxVNkZNMTUvZlFoeDdnZFRz?=
 =?utf-8?B?Tk8rRjQ0bFdJY0cwVWRVZFlGQ0twN0dXY2NRMGc2S1ZKbTliUlBBcHVDNWZR?=
 =?utf-8?B?VXVlNVRxNGtEMm5XRE5tbWRBbnpMQ2tGZ0RteG1IR1I4MWpidWZiakwxdlJD?=
 =?utf-8?B?bERNTngxRlB5VHlIa3lhV1NzV3NOMVFjeElrWE5qMlJjS2hMQ25tYjJyMHZ6?=
 =?utf-8?B?SWU1bm5Id3JvS044UGRhaDZFQ2dBZWp4dzlDOGw0TkQ1SmwvbFUzVHhSeDFp?=
 =?utf-8?B?ZXhVcnNkWTNYVE40NEx2c1BYN01CLzhmN2swTXo0bkdTTWZ4TUYwd0djaWl4?=
 =?utf-8?B?bDVVeGluL2ZFOG1PNDBWcXRMcU5DTXcxYitvT3BTdmEvejVJMDR6OU9DSzZm?=
 =?utf-8?B?VFBkOUpacVJzTHR1cFVoby9tZUtwQlNLK0ZwVU5PbEZic3ZYQU4xN3hWZGZv?=
 =?utf-8?B?bW1pWFhjQnFkOE9xYWlONk9xQnZEMVZBZWNDV0RHNEdqZno4OVNmbkpqT2Nj?=
 =?utf-8?B?VS9jOGkvanpCUWd1SmF6bldGc3RuVHA4N0tJQVRiTUxiZ2NRSVByNnAyYkhG?=
 =?utf-8?B?cGRmdllRMTNUcDlXcGc5dklyK0lEdk8xTDhqWnYwL2drR3djL016WkRzUjU1?=
 =?utf-8?B?eXRuYk5jV3dPemdkNEg2bTFnM1dlQ3V3SWZuYmVTaHc5eUJtZ0lHSnZGcU5P?=
 =?utf-8?B?TXF5K3JGZmFHSGhNOXhzeVQ0TytCNUptR0ZraWYyTWdqMEZJM2Q1S1dhdkhj?=
 =?utf-8?B?U2gxSmR4ZDdiRHB0RUdFOFlGTktjYjRpWjVjWHkxUHBXbm1HZUZZazYzQWJ3?=
 =?utf-8?B?NXlPQm4vVGw5ak42RWgydC9mcnpHQXhkbkx1SEU1dTRIeWtLMXljN3VhYmd5?=
 =?utf-8?B?R052RVFlWHVKME9JSUJHQ052RlJtV3lFTXh2K1ZENWh4eVA1NVh6dy82MVVo?=
 =?utf-8?B?aWRsb0IwbFlKNkluM2ZaKzBZTmVvS3hFU2ZnKzUwSlRRV0F6L1N3V0MvTDZG?=
 =?utf-8?B?L3hpUVM4eEZQNmZXMUl2YWgxZkkzU3VMNzNSdnhQR2RIN0ltV2MvRFlSdHFE?=
 =?utf-8?B?dkdscTdrcFJHdm1hcTAvSE02NWJtKzRrSXhGTGNmKzRqOHR6aENrK2Q1RXB4?=
 =?utf-8?B?NWJ4U28rLzJYOHpzc0M3YjZYcDVFQmdPSFpVTnpZZndFaEZBVDBqK1F4YUpv?=
 =?utf-8?B?MWN3RFN0SWUrY0luL1lZMjd2aEl1MTh3WGhNeTZBbFFMdU8zdWFPQTZEWTZC?=
 =?utf-8?B?bGQ4RnlQY0F0N2ZncFRPYWtBVjRZZWhsQkMvUXFiL1liS2RwS20wT2ZLTDUv?=
 =?utf-8?B?Y3ZZSEE4Tlk4djJ4ZVZNMXVBZnJhUW50OTh6RzVSWGVxMHBZcFFSZVRLTEt2?=
 =?utf-8?B?emJFYnQrNys0RHRpa1JNM2VaMGY0SGI4NGxvM0hvaVBWNjREZkxMU3Z4clVy?=
 =?utf-8?B?SHpBc1hYcVZIeUZvNURuTjZXUGhVbjlCZ3VzTjBBTEFHcXFQMHJSTElEZzJj?=
 =?utf-8?B?MXl4MkRCWnExY1J5UWUzeDBIMWpUWU5DZ1VXYk9BbzgzY0FGeVcrS2tDTGhM?=
 =?utf-8?B?a3lsbDM0T0t1UUh4UnBqNllQd1ZXN3J5d0oveXlOREdsRGNlWVBia3MwRXpp?=
 =?utf-8?B?Q2ZjRGxjVGtzek00MVM0c1IyK0d3cW1PNjY2cDl6b3pDdmM4MHhNWTI4UjZS?=
 =?utf-8?Q?jfLxN6ES4bKRyiAAs3BiMmmGIxNNDfJs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXJ3TmM2MmJkQ2x1aHVwbS9XNHhLaU5pRjJKai9PZSs3YzJNV2MrcHBKdFJI?=
 =?utf-8?B?WDdJODM2TWxpYzlBZC9wUGZnYlBkZ0ZzLzJlNEY5aHpMcEJIUE14T1h0ck5u?=
 =?utf-8?B?RzZRSFhEL1NsL2tsQkptL1NOMGgxUmNuMkpFN2lwTXhRa3hpdXlHT1dtelEv?=
 =?utf-8?B?VEdDbG94d1FUZitHMGJ6VFp3S1NzM2pNM25ZZGQ2Z2M3T3A4Q0JHN3g1WTAy?=
 =?utf-8?B?K052M25mN3I0ZnFEWVk0UVBiWTZVMFJNekppMUtCcUFGVy85bS9jdjZmTWl1?=
 =?utf-8?B?UE9BQXcweFJ0Z3dYeG83RndpZjhCeXRtdGVwVWVOSUVQb3kxVEIxbUdHdjdM?=
 =?utf-8?B?dk03UFdib0U4cXMrcWo3Q0Njckd5OWdBM05RL2NCQ3VFQlZrajZaZndMWkE4?=
 =?utf-8?B?S1draSt3VlBackw2bVhzS0VoYnc0YnpzQStPOE4yZE5wWWdGdmlMSzhScXUv?=
 =?utf-8?B?UXlhNmpJQktsSXpmRkJvSlJaY2pKUk02WnFpcXdSbDB1bTE4YlJQUHZjQU10?=
 =?utf-8?B?YkVYdVVZUHJrNDI3K2tsSGViWEpTT0FtY2NFWk1WNHpuMzI3NmZPODVGQXRW?=
 =?utf-8?B?MWdEK2lRWm9ENVVSR1NGU0RLbWo2MWJrSmFXbTVOdkhkMWl0aVhEa0Q2UjNE?=
 =?utf-8?B?S09sN2t3RElQVDVqMEU2UzBOWUxyZ0xMaWJ6amxxSDYxZWgrODUrOCtzR3Vi?=
 =?utf-8?B?Z0xkSHM1UFo4ZUhoOTJpS0kySzhNYXExOXhWTjFLSHpuQVdFSy92R1dCTVcx?=
 =?utf-8?B?U3pjMC9KcGdKbmxxdndSL09XUEtkMWFjRlBZalVIQVYrRjR4cVMxRjI1cmln?=
 =?utf-8?B?dXVQVmp2eTFsLzIzK3ZRUlBBekEwRjNzWlM5aXRTVVdFa3Y0dmVZckdNelVj?=
 =?utf-8?B?S3ByZm1hazFMaGh3dlM5WlZ1bWkrTTdRRlBrak9aSk1CeXMwU0FMd2RmMlpY?=
 =?utf-8?B?emV0OWRWemNsa1pTcm5RZmRONmRkRTl3UzYvMnp5YVhXV1FBbUw5TjdNRmdH?=
 =?utf-8?B?R0hPcCtjUjVTMGlqUmpieTFsZXcrSGRkbWVrdjQzNU0waE81M1Yyb2NrcEdu?=
 =?utf-8?B?aU90a2QzdTNLKzllWkFrRmg2YURSNXJ5YlJXdW9OS2xwTGNlcW1MaDRTc0Yw?=
 =?utf-8?B?dDJiYTlsWit5eVhQb3ljemlBT2hBQlZhWElkSEhEQ1NZamt3djhjditmeUJI?=
 =?utf-8?B?N3doRER6SjJ6RjFzUUNUenpMMkFmQXUwVWhJODV0czZ2UDNiemEvbU43VXg2?=
 =?utf-8?B?UlVzMHVjV2J4eUJaa3RvV0tjLzR0WjNNUmJLRyt5TjBxazhNM3RWQzZRbEYz?=
 =?utf-8?B?dm1EdEZzQ3dJaVVieEpyUnBmRHRJcHBFSlJxQ2xoZTlOUjVUQ2poL3ZaTWlR?=
 =?utf-8?B?ZEhiZ2o0enh3UllIcExwOU1PV3hxMTZhQXpKK0dxcHNIdGxEVEcvakNiSHd6?=
 =?utf-8?B?aGtPTC9MZDRqSm1MT0s0MDJzOGl3VnhLM2JLMDRpMjJZSFF4dE1VNzN1UHAr?=
 =?utf-8?B?VTdjdExicGltQWFEOG5vSEI3c1VWekxYOHVuOWRZNGdhQ0o2SVpjVW44NmMy?=
 =?utf-8?B?NVptNlNFdEtVRFNDdXhBSlk5N01UYlRwMGhZVk9kYm5xdE1FeDlBTzlUTW92?=
 =?utf-8?B?N0hwSHh4Y0NuRjBvMzBDdm9udThoeTZ3YW1xaDBaMjBoVXlWejJya0R4Q2V1?=
 =?utf-8?B?bnR6Mzc1dTFBYi9DUWtWYWNKbTcvVHVyRmpUL3lHQ2VwU3FzSEtXUW8rL3pQ?=
 =?utf-8?B?YlpzUW1nYk5oQ3VOMXVrOTlWTFVyaFNVVlErZTdTSVdIZ0U2ZG1GSm1sUitN?=
 =?utf-8?B?QVJDZHo2RjYrWDVxZWNTT25MRWZMWXNvNmExc3J6MmgwK1lJeCtYVTJvUDdD?=
 =?utf-8?B?ZUo4UVk1RXV4TmpuT0RhblFrUC9aZWVCaUMvNmptTnFPVXBDQis5K3A0ZEg1?=
 =?utf-8?B?SWlGM2w4NnVZUytRbmR4aVhMLzRBaGcvd1QvQ3p3UStwVStxcVNTa3Q2Z1Ew?=
 =?utf-8?B?VEJTVXVtcjFxOFZTTHJNU2dYTk9vbnRkNHJLUzlGaDB0Z0ZBYjlGVXpXRTZN?=
 =?utf-8?B?SDZQYWlJTXROL0puRDl4OFMwbWkrbE82aTdnNVBDZzlLczlqKzVrc2NsUjZY?=
 =?utf-8?Q?Pw3tR9apS1Selosob/AqP3trd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b344e02-1560-4b15-cf33-08dd46a6fd0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 12:08:38.0251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5Y7G4JfaYMO4ECMjr0EKz2F4ugfsipDFrO1rl6gzhmfc4iuo1+EaROYo5zvdpQRLgZvootdfXqDqGYyh1QDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3802
X-Proofpoint-GUID: 13s6GPvF1JvIZ2H-z08gT9aby7iykM1a
X-Proofpoint-ORIG-GUID: 13s6GPvF1JvIZ2H-z08gT9aby7iykM1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

PiBNU1ZDIGlzc3VlcyB0aGUgd2FybmluZyBiZWxvdzoNCj4gDQo+IC4uL2xpYi9jcnlwdG9kZXYv
cnRlX2NyeXB0b2Rldi5jKDYyMyk6IHdhcm5pbmcgQzQzMzQ6ICc8PCc6DQo+ICAgICByZXN1bHQg
b2YgMzItYml0IHNoaWZ0IGltcGxpY2l0bHkgY29udmVydGVkIHRvIDY0IGJpdHMNCj4gICAgICh3
YXMgNjQtYml0IHNoaWZ0IGludGVuZGVkPykNCj4gDQo+IFRoZSBjb2RlIHdvdWxkIGJlIGJldHRl
ciBvZmYgYnkgdXNpbmcgNjQgYml0IG51bWJlcnMgdG8gYmVnaW4gd2l0aC4NCj4gVGhhdCBlbGlt
aW5hdGVzIHRoZSBuZWVkIGZvciBhIGNvbnZlcnNpb24gdG8gNjQgYml0cyBsYXRlci4NCj4gDQo+
IFRoaXMgcGF0Y2ggYWN0dWFsbHkgZml4ZXMgYSBidWcgcHJlc2VudCBpbiBwcmV2aW91cyBEUERL
IHZlcnNpb25zDQo+IGJlY2F1c2UgdGhlIGxhc3Qgb2YgdGhlIGhhc2ggZW51bXMgUlRFX0NSWVBU
T19BVVRIX1NNM19ITUFDIGluDQo+IHJ0ZV9jcnlwdG9fYXV0aF9hbGdvcml0aG0gaGFzIHZhbHVl
IDMyLg0KPiANCj4gRml4ZXM6IDZmOGVmOGI2OGVkYiAoImNyeXB0b2RldjogYWRkIGhhc2ggYWxn
b3JpdGhtcyBpbiBhc3ltbWV0cmljIGNhcGFiaWxpdHkiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3Jn
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZSBNdWV6ZXJpZSA8YW5kcmVtdWVAbGludXgubWlj
cm9zb2Z0LmNvbT4NCj4gQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29t
Pg0KDQpWMiBvZiB0aGlzIHBhdGNoIHdhcyBhbHJlYWR5IGFwcGxpZWQgdG8gZHBkay1uZXh0LWNy
eXB0by4NCg0KTm93IHRoZSBvdGhlciBwYXRjaGVzIG9mIHRoZSBzZXJpZXMgYXJlIGFsc28gYXBw
bGllZC4NClRoYW5rcy4NCg==
