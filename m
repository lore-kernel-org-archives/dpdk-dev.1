Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAA8C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3548D4025A;
	Thu, 13 Mar 2025 22:12:21 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020075.outbound.protection.outlook.com [52.101.85.75])
 by mails.dpdk.org (Postfix) with ESMTP id E491040144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:12:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5uueEw0/Ukixb52m/FgsRg+0Qq8XhhKcFT4Dt2xLUoB1RORbq4KGge089qW1hvgeMAhFqzfv42szbpPmnuJQPTEI8hrrlFp0qoNinou8NdY+7y4y5UVFSLyb5QtslDS3uLYUrg3SHNJmQ9Rp/3LlpcmeCjyOX7BXacxBI7uZloSLkGZ0V2IXqVweUgt8k5DSjathnRDnqGA3DRdq3p66DNfYMN3/6/tQcUvHyS8ae1nl2kxVf9PRcYC4vIu3jpFiMzbgVv8TGs2qTc6QiAyYVIDPUFoQ3PvOMeoDLttTc2Md7E4cKCKz9tlj0EoMXBnEHl+fX/XXNVOqmrRmm56/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rs4NAo84JHtI3MD9T9sdUNaV1MvNd/3Wc+8Og0gmr8=;
 b=neuYW6oVe1h2geSwpP7x+8ZiGRUjNpUnQIYtudbFgaWYvCeEbcg1E3pvDvCUY/E12a/z/6eKKZaXjmsi5WC0w7q3vwp5VP8HK36E+lRvTw5zhSIZeZ5w0xBz4dxbgf5LPswSqqCCUG55Dy0JDFJxvNK2bXmXip15j5HstUCBxeztTflPBETHCVMYBJVf+PxIVK75PoHxgYciyxczxUQVSVdc7x9JGXjiht36G2uH+R8/YVHMGYokaA+AuE82WjQQUC1cmMm0hiSdkq8J8cbEPzCuXsl2jQ7Q++x8w2fbFJwfc0+2yFpYj7rDZabquKt+IulXymdhJTvzD4n+x07rIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Rs4NAo84JHtI3MD9T9sdUNaV1MvNd/3Wc+8Og0gmr8=;
 b=W/z+5o0FLwce7QS+tQJsyZ0QDzx/Uniwd6/78HbyqmmciSzLrfL+pqLZiBRKYBI7mH7dCeYg4GCGNmaI1qhp1pIoKUla79Yr8JLHCwqEelEqsJzKFzktfAnbZtYsImwDujQGd69GRN9HRcfMQmugj0hLv5jEaWuHjVMbZfrFyrI=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by BL6PEPF00020EA4.namprd21.prod.outlook.com
 (2603:10b6:20f:fc04::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.4; Thu, 13 Mar
 2025 21:12:16 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Thu, 13 Mar 2025
 21:12:15 +0000
From: Long Li <longli@microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@microsoft.com>, David Marchand <david.marchand@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] doc: announce bus/vmbus API changes
Thread-Topic: [EXTERNAL] Re: [PATCH] doc: announce bus/vmbus API changes
Thread-Index: AQHblCV04k1DreuE/kOq4WEsXIjMCrNxkMxg
Date: Thu, 13 Mar 2025 21:12:15 +0000
Message-ID: <SA6PR21MB423106267CF64D0112D146ABCED32@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741815831-22977-1-git-send-email-longli@linuxonhyperv.com>
 <3519006.Zkmt1EvEu4@thomas>
In-Reply-To: <3519006.Zkmt1EvEu4@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=554dae2d-1b03-4e82-9dc2-c9ab60cd4951;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-13T21:11:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|BL6PEPF00020EA4:EE_
x-ms-office365-filtering-correlation-id: 048e8eeb-bc2b-4753-b882-08dd6273baf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZnVwQ2ZOdFB6Y1dYZWs5aFJHYTIvclFST2hKOHdVTHN4R2RrNlRIM0ZPMmdr?=
 =?utf-8?B?UldNODFYNnVMV0hnR0d5dmI3WWpsYmN3dnErVThQejFWZ0F5MXV3UVpDMkZw?=
 =?utf-8?B?cncyeFo1bm5SYkhDUzJWUXJhc1RUWWs4MVRmQ3RRUjIrVldLbjdKV2dWd0F4?=
 =?utf-8?B?RVd4YndLMEJZTitLaThoMUJ5UENiSFdGcnd4NXV5V2lyelFLRURYKzJZaWs3?=
 =?utf-8?B?MDBqS0ZvZ2JRakZSM1krUFNQY1dKVUFFTGJ0VllkTkJSWXo2K3l1RUgrN2F5?=
 =?utf-8?B?bHovb2RFaFVVQnpTY0lTSFF3RG1LeHBHM3BRdHVZVXZCM1krS3I2dFRQcTRU?=
 =?utf-8?B?UGYwL2VJNWMvV1F5ZndOVFhYOWlZQ0U5WlhmMmpxOFJ4UlE3czhtbnp0a1ZN?=
 =?utf-8?B?OHMrdm1ud1k2cmZiZHJKcGpVSzBodGVraXY4UXFBS2hleHdVRTNzQkEvcnM5?=
 =?utf-8?B?S3hSN2l3WGFxcmY0U1R6VnRicGowVUNTUWp0RkNIa3IwVllzL0d0bXlXR3lj?=
 =?utf-8?B?eitJdHZjODJ5MHNhcUxNalgxMWM5akE0MjBhUDJCTTJuY2tTdWw4dGdEc1pL?=
 =?utf-8?B?UEVlZHVXNWp3UUhadzh4NlZyclJIVU9FWWxKWkNzcjBvejZUWlpTSDdaanpk?=
 =?utf-8?B?ajNhTk5KbHZpTlE4Qlh6cWFyV3BSb1dCL3AyWEZGZmZlR2pia2NndFVhREgx?=
 =?utf-8?B?VTlrdlRHcGJyZ3JPUG05YzFlSkdjb0JxN3hXUHRxTUZCMlRpS0JkNlN2NHpX?=
 =?utf-8?B?UjBVa1BaUVJRU1dKaHk2L1BRTHdWMlNqU2RGaU43TFBBYWRpMkxsT1pBMnVV?=
 =?utf-8?B?U1dFWXpESzQxVW9FWmlCczRNN0k4M3pFQlR5L2ZveHhaNksrUjVoR3BDQVBC?=
 =?utf-8?B?S0JxS1VPZFhHQ01Ua29YU3BuWlV2Uzhsc1NFL0ZQS1d0N1JzVUlPaDN6S2w5?=
 =?utf-8?B?UzNSeUhCT3F3VjEvZUk0RzJEUjdjWFBXVHpXdCtmSVF3WWV2bXIxcXdPVXpn?=
 =?utf-8?B?azh2cFhjQ0I0NmpmN1dGNFk5NXFEd0lqcTdRRmRZWTlkWjd4TWNMYS90VllU?=
 =?utf-8?B?R0pBQUd1UStxK2UzZ0toczVGVkc3UUVVR0IyUDBYWUFHc080Y09HZnhWZ2cz?=
 =?utf-8?B?MDdNSEVQSVRJaXZCRnBuY1BZOEtxMEw2MDFKeWFPZW1jUzdveHVDWEMwckdi?=
 =?utf-8?B?V1hMS1BPR2tyR3U0eHgwbE9LUk05RVpadE8xTXJvSVdNZ2dacjNFcmlqMWUw?=
 =?utf-8?B?TGJhYlNSMGdzUzhzTFZGR2d6RWlGNElRYmJMamdTayttNUpJYW1iYUtBM1pV?=
 =?utf-8?B?blJ6SGlDVlZDTkswNDlBelVUV3ltSDYvZ1lYcDRURVBlNk9leGhkaWVVM0Iv?=
 =?utf-8?B?czhpVHVQaEx6emc2ZlhlU3MwMU51RisvT2crOXB0ZERvaVVJWkIwc2lJZE9i?=
 =?utf-8?B?b1FyR0V6QUEwa0JqVXo0MXp6SFpZTEhNMEp1eHc0bFcyY1ZNQVA3VmNqb2pI?=
 =?utf-8?B?TmNEbnJXSjMwbE5yaFFzZmRrZVJuMlprVURPbzdraEhSNU5QZHRJM0hkb29r?=
 =?utf-8?B?WTlvYzk1UyswTU8zZzFyUGV1OXNoWGNwNmJwampGRG5PRmFjS2VNdjVDQXQv?=
 =?utf-8?B?T216MHZLd3dzV002ZVg0R1ROVGdqeVkwYlJLbDhNMGgvMncvenVPb2huc3Jp?=
 =?utf-8?B?UnphZnRIUnMwdkFWTDE0MEsrSitucjZTcmVna0U3VU5hYWlLRTBhekRpbzI0?=
 =?utf-8?B?Zk1aaGZTUTVZb0F5WFZadmRvb2owa0dyYnBWc0gwWENLRHplZ2pBMitKQ2pp?=
 =?utf-8?B?V1pQdVUxOUsrWE5FV2t1cW5MMmhNRDBMN1FweEY2Sm9YNEtZYU9kVkplVmNh?=
 =?utf-8?B?MGpzLzNWNFdCSHl3cVVhbldpd2ZKQzJBNFhaeDFCWko0TkpEam9Ga2JHRmJy?=
 =?utf-8?Q?poF1X1X1pxXSo4r3pDorVCXLwtsbB3On?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZzMHd3dE1wS3VMYWkyVDVlTmlJSURqUFZIblhtMkllZ3BJVTZQK05vM0ph?=
 =?utf-8?B?OXJpeTM4eGF5TWx6U0lnQitzbHN2MFQ5RUNzWk45UmhFOFU1OXdnTTYrdlBq?=
 =?utf-8?B?K0hiWklHN1ZxRk1BbjhmZ0h6TXM1S0xRaHNQZE8xcmpjWWhWUzVBcUhSKytw?=
 =?utf-8?B?QitLOCtHdUtnb3FOK2U0WW5pTlo2ZEdmS0NacFB6Q0ZUc3VSMG1SZktiaTVz?=
 =?utf-8?B?emMwekk2OWZVd2lDVURWYmh2YW5ubFo0QmVuTU55Qzhtc05ESFdPSm5zVFdm?=
 =?utf-8?B?bTltRlRycklvUDltNW9CankycHd1UzBsZXlGWEpOODFjeWx6UW5sTy9Cdktj?=
 =?utf-8?B?SXZOeEtYUnl5TEJHV211d01PZ05BVGFtMG9YQXI0TmdPRTBYZVc0YldBM3Fy?=
 =?utf-8?B?OFlMa1hlanVTb0hETWUwUGQvZ1ZLcDNoVUZHYWhJVTBXMFZHSmxPMWxMZUVV?=
 =?utf-8?B?UkU3cTBVeTBTLzdhV3dOczJhZDZMUldRc1hPZGd6Qmcya2V2bUd3VnBXcnNi?=
 =?utf-8?B?TlZZREhpRFVOR2pFb0lRS21ESnVoM2J2TmYvU3ZpWVJLaldsMkdDUWppUElJ?=
 =?utf-8?B?Y3VrNEh3WElkYzgyNXREb3pPNlgvaFBnVms5dVJMSk1tL0dYOTNRd1NNLzB1?=
 =?utf-8?B?dENwdHhSdFNzLzZnWnQ1d1hVWi93RzFlRCt5dE1RUHpiYUtjUTdLSmRoVGdY?=
 =?utf-8?B?VmdCOEFESHp3QmVVbmp1VUdtbXJ5dmdBdm9IWlN2a2dDMFZncWExaHdmNnh4?=
 =?utf-8?B?ZWVub2tiV2gvZXBVNit1N3VIRHhhOTlsczhjTlhPSmxMRUZmeXVqT2JQaHlW?=
 =?utf-8?B?b3k2ZTJxZmxVS0dwbGlML1BkRnFZTjZXb2k1Y1lXN1M1RldJWEZhMzZqV3Js?=
 =?utf-8?B?amw5blNYNmhWNEIyMWZnZnpXbDlOZ21hUEFsRFY4TDl6a2ZvWWFMRlEyWjlO?=
 =?utf-8?B?L1lId0RxeDYvbzNMZVd3MGVDWnNlTUNXQjZpWWNYRzVCT2d1NmNySFNYT0FK?=
 =?utf-8?B?bmxXU09KS2d6bzlCQktRWmt2SXdtMWhKNnJTR3RvR2NhbS9vcGFnR1BGWEht?=
 =?utf-8?B?T01ucWNPSUFmYm9rZ0ZjZlg0WDZOYVp3TVU1UTBXajIrem12aVBGeEtuNW9X?=
 =?utf-8?B?SmhDSEI3em1MczRHUkdpVWppRjVlNEVJQ2pWY1o5Zk9EZWNhaDB3UlJuYVpP?=
 =?utf-8?B?amZxa1dxR0dJU01tblRUblFUMGxsR2xac1lTQmY0dFNpQVFCVEhMZWNkZDZ1?=
 =?utf-8?B?WGI2bjVOZWIzeHlOeDVKZzRPMTRsNi85ZjZmMDZKbXNxYUNiYWt5cnZ1MEsx?=
 =?utf-8?B?bGZEaWhnbHpTZEQ4NGJaZ2ptaGJYT2lTelQvbGlUUzJ1Ylgwbm96N0RTd3dC?=
 =?utf-8?B?NEZFZmkwOWttYjZqZnFUTExYdER3N0xlRWZCcWc5RXhDSkxaejB5UXgzMUtW?=
 =?utf-8?B?MVJMWlhsWVhtNHBrbmtjbkF5blh5NXFxQ0wraWxocmFSdG5jRnBuOFkrQ0lE?=
 =?utf-8?B?b0RiU2FqbUloOEZWekkzemRNQmpsODdzT3FGckRNaXlZc05CcCtUdk1GRHc2?=
 =?utf-8?B?MUdOc2kxSFBLdmpKVFpXakNKRU9pWERHTGhLWm9aUlozcnk3ZEFJdWZabWs1?=
 =?utf-8?B?ZHdRZUViUURQVG1QVmkrZkhNeEhHQVg5bWtkUzRLQnh5QmM2TVpXUmZaNnEx?=
 =?utf-8?B?UGJjazNCT2liMWkxTXpCY2JuZG1VWWhlRXVYVytIRTN2cVlBenZEMEc2V3ZS?=
 =?utf-8?B?dDdyYXlCckxPemZUbEZGSElTMU1kUCtRTktLUzR0U3A2Zno5UGZtRVkwOFF1?=
 =?utf-8?B?WUZlMXhrUXlkbldZR2ZlQTB5MUxhTVh1SWhvdHhjT1ZVYk90SzhMOWFzZGhy?=
 =?utf-8?B?SjN3MnVCZTV2ZFdQc21tN2JQM0kwbm8zenJjK0U0Q3duQkxjWUJUcnRRbnpy?=
 =?utf-8?B?c29PdE9TUGZxWU1ZNk56MWtvTlUyOWw2OWRHZ1E4d0NDa3lVdTVkSHcwVWZZ?=
 =?utf-8?B?d1B2OHVrVU1BamNza2lsZCtnODY4eFhKR2d1alJHWmdrb3JwcFh0R3lWZUNX?=
 =?utf-8?B?MW90TCtDRVlZT1BuL3Y3emRaQURYS2l1WGErZ1luaGd6dGRUc0tqcjkzSTMx?=
 =?utf-8?Q?2TUlyjolizzy0lPnPziFA1NGo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048e8eeb-bc2b-4753-b882-08dd6273baf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 21:12:15.3686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNLuYgEexd5YMO7h2GZN0aD8qFAxAj5ODeS4LfqPksEoig6Cva4wVIwQLO+09K/+XEjmDCjQOXz8Hl4Dzjk66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL6PEPF00020EA4
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

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIGRvYzogYW5ub3VuY2UgYnVzL3ZtYnVz
IEFQSSBjaGFuZ2VzDQo+IA0KPiAxMi8wMy8yMDI1IDIyOjQzLCBsb25nbGlAbGludXhvbmh5cGVy
di5jb206DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4g
PiBBbGwgdm1idXMgQVBJcyBhcmUgdXNlZCBpbnRlcm5hbGx5IGJ5IERQREsgY29yZSBhbmQgbmV0
L25ldHZzYyBQTUQuDQo+ID4gSXQncyBub3QgZmVhc2libGUgb3IgcHJhY3RpY2FsIHRvIHVzZSB0
aG9zZSBBUElzIGJ5IHRoZSBhcHBsaWNhdGlvbi4NCj4gPiBUaG9zZSBBUElzIHdpbGwgYmUgbW92
ZWQgZnJvbSAiRFBESyIgdG8gIkludGVybmFsIiBpbiBEUERLIDI1LjExLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4g
KyogYnVzL3ZtYnVzOiBTdGFydGluZyBEUERLIDI1LjExLCBhbGwgdGhlIHZtYnVzIEFQSXMgd2ls
bCBiZSBtb3ZlZA0KPiA+ICsgIGZyb20gIkRQREsiIHRvICJJbnRlcm5hbCIuIFRob3NlIEFQSXMg
YXJlIHVzZWQgb25seSBieSBEUERLIGNvcmUNCj4gPiArICBhbmQgbmV0L25ldHZzYyBQTUQuDQo+
IA0KPiBZb3Ugc2hvdWxkIG1lbnRpb24gdGhhdCB5b3UgbWVhbiB0aGUgZnVuY3Rpb25zIGluIHJ0
ZV9idXNfdm1idXMuaA0KPiANCg0KV2lsbCBzZW5kIHYyLiBUaGFuayB5b3UuDQoNCkxvbmcNCg==
