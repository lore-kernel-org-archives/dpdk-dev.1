Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C57C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 10:35:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 075A4402BB;
	Wed,  5 Aug 2026 12:35:26 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by mails.dpdk.org (Postfix) with ESMTP id BEA2A40272;
 Wed,  5 Aug 2026 12:35:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoKdYvrGw/MsOnyTGT/1TCce3BYzjF4l8A27L9xqO/1SeOgO/Oyp4De47BuUAco76H53h57TF3FkIXzuXzmOqg1FWM2AaMHkfzxb6FYngrrys+NZVkj4F3Qw2vevaJistPmLEhdJQXAcHarSAm3n4o6wYx01ey8wceyYNrsJDfiMzIfEjEYnwGnq0IC04YdTbXsCbMezKHRIBixyjsQecuiPkBFhqP3oniJ86N16BcIkM9KcewmP11ZO/R+6+pgk0yHVOYRqYIGw4E5J/uQ70SYqsUibCnaAPAUPbuDRIh6QjYWvsYuTCQAEtcv4hHjJKUyLS5TeafOBqkxd8STiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmLYswYglfGEJI7biiGIsP5ws5ns0EBGOZvc4wqW+6U=;
 b=T10WxhIHD+HwBHESa/a/Mwut+/hW0noC4JUS+blF5BsEtgRdfdRFkyp+hile1TN7nRRNyCbPzQRFgTlV8ZDJdhESsuP3G+HyAOsBO18eiMGaeZCOZrFd028lxohDIHszpHT4q2iqSiJu9hO3qHvHlV4ScPmK3WIh4xn63Y0egGvHWqjlDbotCe9Sqbw3Hu+fVUMkYcRG49Pay8c6FqMMVJbW5GClFFjDT7nJWwI9+KzNWXJEnFcwHHXAC83EMTeN9dGD1TmIl16A3FN/6S8APjK81isITBoAtKjJGvAEmyB8nDkOT8zOP5jDKvbTgqNlQJIzpc82f52YWzWvaCe0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmLYswYglfGEJI7biiGIsP5ws5ns0EBGOZvc4wqW+6U=;
 b=sOvwXKbXXwaPdIL0pq4kYl89I+BMMRJ7bJAdFRxv7J6LTcmsMHZqc5x5jo4ObgDCb3gq8PFkw7OJFIMexlVUZiDRTHzcOwMx60BHb7k+JZvfaLww3ZEQJZGIrkVYhWxOhXioUbWtemj23ng9qKRxyXInlGpJq2grgqSrihaG4fMVC+4KWCTvbH5ZwmpvjLlu5beH2H3sJrXmPdOFog0KCjMPcvQ64cU3+y4ZPG3rbJVNL4QRz0DIi9+UWNjBh3eN48xLUhLC8P+w5mqd/UE+wuO5ohAE1HI2VGBagdWkyFBU2fj5CmRxmW6sMgJJikigUsTwO8V9JLFaZhkvsR0ryg==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 10:35:19 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 10:35:19 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ali Alnubani <alialnu@nvidia.com>, "luca.boccassi@gmail.com"
 <luca.boccassi@gmail.com>, "stable@dpdk.org" <stable@dpdk.org>,
 "maxime.peim@gmail.com" <maxime.peim@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 jerinj <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>, Salaheddin Badawi
 <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
Subject: RE: 24.11.7 patches review and test
Thread-Topic: 24.11.7 patches review and test
Thread-Index: AQHdHaxhiNT9ug91y0ixriw08GmD6raN8+IAgAFc1NA=
Date: Wed, 5 Aug 2026 10:35:19 +0000
Message-ID: <PH0PR12MB70778D3F0532D5201E071D59A4D32@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
 <c49e8480-5d4d-459d-bf8d-c73321c42abb@nvidia.com>
In-Reply-To: <c49e8480-5d4d-459d-bf8d-c73321c42abb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|SJ1PR12MB6049:EE_
x-ms-office365-filtering-correlation-id: 7336d631-c59f-46cc-c87b-08def2dd3f07
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: iLJyVzH+XCC397zH/gHFWxti/Y+s62aishVIdTNjoLjrqR+WTLCQOUnwhhbSCwfH7iBAVhcRKg7JbhgzHy7+E8RtNMct+Ah3vTuD5SEcIAaVvmMLtsO0Vm/kedYacemDBbXTVQ2/VsKVwqRDT02cg4ruMq61W6mWexucYtJd5TUZix7DrBJAdTeAQSp27d1Uy3tz7kTSa0CzIAHI1GCou28WcvYczjDxOyF4MGmUpPgq2loa2/JgSK/IJve7yKBS4Z0XGB4hnXwscOOnv3sf+ZF1UjeIfc0O/BfXxPb+Kxe/TJzjAydYp2DtyhEGVy4/qsuYdGve2NB9Dbcld/7/eS8ULIVv8f3OEqgZ0pkWULfMwXc7jmYV2s158fMnhLt8l1klkQku2/DtRZCrMu3Fj3uWk7VB8g6dAFF9waE/QArwx1YG6Rjz1vBAqI0zVUDEDpYOeGZmXOUi+FWF8I2t7ydFx6eZishbeyhxG3ySb6SCZJEJg6dLKWlP8+YTEZrHqEJI/I9LsHhcm122oW6bRHC/cLPzydTcSuM+rECWJEX50xCN1Z8XWRVgomzLibEcIqN8YnDonZWvC4Iqq4S4hiRz1N+oVwtK0Zv/Rm6EsgbEKNO9ajfHE5lknAlQ1MZQO7I0jYIwvaVkPn8Qg4dVe5XL8/1xhX9PkpeDafN9vlCZ6/tjBZjI29veN2MkMn+hIV3mMjWSJr+9mqBSiS3A8egUwId4793Osvr9czDws10=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRrZkpOdjYyZE9vMFR3NEl1QWc0NWZsR0lXQ1FqVDR2VEhDb2NWUmY2WDFU?=
 =?utf-8?B?aE45aDJEemY4NEtpMnQzVDBVVnhyTGJxYXpYTmpyeXhhQjN2WEpQNlR3dmdL?=
 =?utf-8?B?VUh3VGJyOEhGZER6akxwZlVTeXVmQmJESkkvZEJmU1lxZGJMaFF5MnN6Uy9p?=
 =?utf-8?B?cmczbG5SSVhianUwOURKYmJJeitSMXF4UnRjc0pTQ3JGZkhnR1hnajRCU2RL?=
 =?utf-8?B?VzRVam9jWVBQVmRVaFdHMWdPYnNUSlc2L0lnRWFyMVRSWnVUM3JGOVhwcHFQ?=
 =?utf-8?B?MEh3Zzdod2lodlhkRFFEb3hkMUhMWUpFWEgvL0dSOFFsejlLS3puYWlYdmhn?=
 =?utf-8?B?clRjK1EvQXV3R1RhQU92WWNCRDBHK05uSDl2WmFIOXVBT2R4a2tFNEJFZktM?=
 =?utf-8?B?ZEZsaTVPc1JmeEhuZlpkMmVGb0l6R1JnRG9nZGJIYWJqaXJaN0lXaEVBMXJQ?=
 =?utf-8?B?Vmh0eDBSUVN1bFllZFVlR1J0ZXNmU1JWVHdLYjZmTVFFaml4bmZFQjZlNFVZ?=
 =?utf-8?B?bENIdmtFTGhaOTZ3eGJLWHVJZVVOYnE0VmdkSDh0dEFvKzJpU0lwQkxSYnpG?=
 =?utf-8?B?dmZFck9NbDlwTDBiTWlnWEFSQ3dyeUxsZEhBSm1SZVpCNzdOMWE4ZzNjejR6?=
 =?utf-8?B?bE1nY2lRTkNnVUVEZUlvYXRidU9CMnU5aVpFYVF3TmZVNm55WUNlTWpRK3py?=
 =?utf-8?B?bzBOdzQvMnlNV0J0VDdBTDF3OEFFdW9uemNnU0FuZXZlbEZLSldyZWxpY0Nx?=
 =?utf-8?B?ZE9TZnNJRUo4VUY3RjhINlIvRGpMTFF0S3VNdkFsV2NQTnJ2TXVwODBGdkF4?=
 =?utf-8?B?M2NlL0RnOENvOHhnbU9kRTNiNXFZWExENlJRYzdnTU1jUUZTd2U5bFNLdCtu?=
 =?utf-8?B?TmozR3ZsZ3dsTFgrcEcrS0tlMGlFckJSRWJQRW02UGIrS1NSa3NVR2h6azJv?=
 =?utf-8?B?R2NFSUdSTE5pR0QrTUpUZkxPZXhCNnAvb0l3SmIyV0RLQnN3M2M0YmtCMW5W?=
 =?utf-8?B?eEZ0U05GRXJtVEVQQmliWXlsSytYdHZkcktVQWlSVjQwcTdYcFdBYldtVVRp?=
 =?utf-8?B?ZGNQcGlYeENQeWZTaTRlRDN0L09IQ0psNUVtS2lsc2FvdjdzSWxlZTgvM0Rr?=
 =?utf-8?B?NEtnWlZsUmdVQ1NVa3RHYVh6UVRQMEdPbDIwaTRDZ3dMNUZhUW1zOTNlQWpS?=
 =?utf-8?B?dk50Yk1YaERnQU9pNXdWTGRoRCtneDZ1Z2dSQlZhcWdMQzd3S0JWeDZCVHBa?=
 =?utf-8?B?cmZMcU5ETzIyY2JhaXd0a0JqcmJRSXRNR09Fd3RsaVlhK2xTZjJNdUlvYlEx?=
 =?utf-8?B?UWZzOU9CWk1ENTRJUzl4UXpWQ0d4UmxlWVpoT1FvNDl1TVRENHhMKytiUW52?=
 =?utf-8?B?TTBPNm56N1lQTkdSVVAva1g4VU1PN29qaUJ2YTQ3c2RTZGpWclhrb1Q5c1Zp?=
 =?utf-8?B?dHJ2SW9uQld1WUdibGQ1dVhaL3c3cElKa0MxdHdCQmRWZ1hBbVJYRGZROEpN?=
 =?utf-8?B?OFZyeS9lVm1hOEdJTktGcyswUjBIWC9oS2hjeTNmejljUDlBaTM3QWFaY0xS?=
 =?utf-8?B?WXpLbEg2bEQxSHh6bm5CVFdBb2h1Vkt3WThhMTNDUXFkWFBOckdiSS9xbU1N?=
 =?utf-8?B?djZ6TzRZOUFMa1VpY2l2UUxrWHJ2K2RUUHFtdzdzb0l3ckZSRjViek9Vdm9L?=
 =?utf-8?B?Qjg4eUNIT2tiQlVrMGJheldJbVQvV0w2aDJ1UmFybGFldjNUOHpBandlbU9I?=
 =?utf-8?B?b1JvTFJZT2lBam9zTUo3OG1TM3dWNlN3OVoyKzdObzhSOHV5MEwrUUgvMnJV?=
 =?utf-8?B?VS9HQml0SXZYNU1xRlNqaWpnODdDanZ3NkpDWmRNaGNQWkdMU0wzWVVCZzNo?=
 =?utf-8?B?RTJvQ1RnNDRxNWlJL21IdDlTSUhwd25SN2lEWnBMSjRZL0hxWk84WG85L2x2?=
 =?utf-8?B?cEVUYU5vMDVLc3lUcnRIY1k1dndxOUdFYVlTc1JmUDJFaG5GeE5Gd3dOeDUv?=
 =?utf-8?B?VjNka09EcVE4S0p0RzNEclo2V2lBam5SZ1FTYVd6MldRYVoxOFVzZVg3SEp0?=
 =?utf-8?B?SVRFRXhWaDJHYW9oeTBJMnBsZndWeFVtNjVtclB6M05qYVFEWUNVM1JXSkpK?=
 =?utf-8?B?MHpzeGYvbGwyOTFtZTlubzlpbS92NkFjVVc3YktHOW04TVREQ08zK1U2aGdy?=
 =?utf-8?B?eVZQT2xQSGtEYWloS2s0QXF6THdZSjN4cVNaLzZGZDExTTdyTkdIcG4xU2tN?=
 =?utf-8?B?Yk9HZkc2TWtiYTdNM2dZOUt5bHZlUWVoUkp2d1ZZT0wzc1A0M2dxczBwSDZO?=
 =?utf-8?B?bHVPUzIxNGlRSUFodEcrMElWQjNqRDE0cG95QnJXWHgvU0hYMlA3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7336d631-c59f-46cc-c87b-08def2dd3f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 10:35:19.2285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXJ2g21qVg2wvMeV1cvgH3m85cujMyP8kj5dZYS5crWnwnw6Emt0QaNCitULZRSXRDsBHZECUhQhez38SYgnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsaSBBbG51
YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgNCwgMjAy
NiAzOjQ2IFBNDQo+IFRvOiBsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbTsgc3RhYmxlQGRwZGsub3Jn
OyBEYXJpdXN6IFNvc25vd3NraQ0KPiA8ZHNvc25vd3NraUBudmlkaWEuY29tPjsgbWF4aW1lLnBl
aW1AZ21haWwuY29tDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUgPEFiaGlz
aGVrLk1hcmF0aGVAbWljcm9zb2Z0LmNvbT47DQo+IERhdmlkIENocmlzdGVuc2VuIDxkcmNAbGlu
dXgudm5ldC5pYm0uY29tPjsgSGVtYW50IEFncmF3YWwNCj4gPGhlbWFudC5hZ3Jhd2FsQG54cC5j
b20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IGplcmluag0KPiA8amVyaW5q
QG1hcnZlbGwuY29tPjsgSm9obiBNY05hbWFyYSA8am9obi5tY25hbWFyYUBpbnRlbC5jb20+OyBK
dS0NCj4gSHlvdW5nIExlZSA8anVobGVlQG1pY3Jvc29mdC5jb20+OyBLZXZpbiBUcmF5bm9yDQo+
IDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYSBCb2NjYXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz47
IFBlaSBaaGFuZw0KPiA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgUmFzbGFuIERhcmF3c2hlaCA8cmFz
bGFuZEBudmlkaWEuY29tPjsgTkJVLQ0KPiBDb250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJO
QUwpIDx0aG9tYXNAbW9uamFsb24ubmV0PjsgWWFuZ2hhbmcNCj4gTGl1IDx5YW5naGxpdUByZWRo
YXQuY29tPjsgU2FsYWhlZGRpbiBCYWRhd2kgPHNiYWRhd2lAbnZpZGlhLmNvbT47DQo+IFdhZWwg
QWJ1YWxydWIgPHdhZWxhQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiAyNC4xMS43IHBhdGNo
ZXMgcmV2aWV3IGFuZCB0ZXN0DQo+IA0KPiBPbiA3LzI3LzI2IDEyOjQzIFBNLCBsdWNhLmJvY2Nh
c3NpQGdtYWlsLmNvbSB3cm90ZToNCj4gDQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gSGVyZSBpcyBh
IGxpc3Qgb2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Igc3RhYmxlIHJlbGVhc2UgMjQuMTEuNy5UaGUg
cGxhbm5lZCBkYXRlDQo+IGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyAyMDI2LzA4LzEwLg0KPiA+
DQo+ID4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlvdXIgdXNl
IGNhc2VzIGFuZCByZXBvcnQNCj4gPiBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwg
dG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJlbGVhc2UNCj4gPiB0aGUgZml4ZXMgYW5kIHJl
cG9ydGVkIHZhbGlkYXRpb25zIHdpbGwgYmUgYWRkZWQgdG8gdGhlIHJlbGVhc2Ugbm90ZXMuDQo+
ID4NCj4gPiBBIHJlbGVhc2UgY2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZvdW5kIGF0Og0KPiA+
DQo+ID4gICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYy
NC4xMS43LXJjMQ0KPiA+DQo+ID4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRlZCBhdCBicmFuY2gg
MjQuMTEgb2YgZHBkay1zdGFibGUgcmVwbzoNCj4gPiAgICAgIGh0dHBzOi8vZHBkay5vcmcvYnJv
d3NlL2RwZGstc3RhYmxlLw0KPiA+DQo+ID4gVGhhbmtzLg0KPiA+DQo+ID4gTHVjYSBCb2NjYXNz
aQ0KPiA+DQo+ID4gLS0tDQo+IFsuLl0NCj4gPiBNYXhpbWUgUGVpbSAoMSk6DQo+ID4gICAgICAg
IG5ldC9tbHg1OiBwcmVwZW5kIGltcGxpY2l0IGl0ZW1zIGluIHN5bmMgZmxvdyBjcmVhdGlvbg0K
PiBbLi5dDQo+IA0KPiBIZWxsbyBNYXhpbWUsIEx1Y2EsDQo+IA0KPiBDb21taXQgNDcxMzUwZjZj
ZCAoIm5ldC9tbHg1OiBwcmVwZW5kIGltcGxpY2l0IGl0ZW1zIGluIHN5bmMgZmxvdw0KPiBjcmVh
dGlvbiIpIG9uIDI0LjExIHJlZ3Jlc3NlcyBlU3dpdGNoIEhXUyB3aGVuIHJlcHJlc2VudG9yIG1h
dGNoaW5nIGlzDQo+IGRpc2FibGVkIChyZXByX21hdGNoaW5nX2VuPTApOiB0cmFmZmljIHRoYXQg
c2hvdWxkIGhpdCBQRiBOSUMgUnggcnVsZXMgYWZ0ZXINCj4gRkRCIHRyYW5zZmVyIGlzIG5vIGxv
bmdlciByZWNlaXZlZC4NCj4gDQo+IFRoZSBiYWNrcG9ydCBkcm9wcGVkIHRoZSBwcml2LT5zaC0+
Y29uZmlnLnJlcHJfbWF0Y2hpbmcgY2hlY2tzIHRoYXQNCj4gcHJldmlvdXNseSBnYXRlZCBpbXBs
aWNpdCBSRVBSRVNFTlRFRF9QT1JUIC8gUkVHX0NfMCBwcmVwZW5kaW5nLiBUaGF0IGlzDQo+IGNv
cnJlY3Qgb24gdXBzdHJlYW0gbWFpbiBhZnRlciByZXByX21hdGNoaW5nX2VuIHdhcyByZW1vdmVk
IChjNDFmNjIxNzg2KSwNCj4gYnV0IG9uIDI0LjExIHRoZSBvcHRpb24gc3RpbGwgZXhpc3RzIGFu
ZCwgd2hlbiBvZmYsIFRYIHJlcHJlc2VudG9yIHRhZ2dpbmcgaXMgbm90DQo+IHNldCB1cC4gVW5j
b25kaXRpb25hbGx5IHByZXBlbmRpbmcgdGhvc2UgbWF0Y2hlcyB0aGVuIHNjb3BlcyBOSUMgcnVs
ZXMNCj4gaW5jb3JyZWN0bHkuDQo+IA0KPiBEYXJpdXN6IHZvbHVudGVlcmVkIHRvIHNlbmQgYSBm
aXguDQoNCkkgc2VudCB0aGUgZml4IGZvciB0aGUgYWJvdmUgdG8gc3RhYmxlIG1haWxpbmcgbGlz
dDogaHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9zdGFibGUvMjAyNjA4MDUxMDMyMzIuMjI2ODM1LTEt
ZHNvc25vd3NraUBudmlkaWEuY29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpEYXJpdXN6IFNvc25vd3Nr
aQ0K
