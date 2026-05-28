Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B286CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 14:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 245B24021F;
	Thu, 28 May 2026 16:45:23 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41]) by mails.dpdk.org (Postfix) with ESMTP id CC93B4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 16:45:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaUkbz7ou/20iw/D7myDe/iU8CFMsIazgWLrLqG753Jlyp9lTuLy0BRYYp9i6M6J4dEIUlI76SmkE9zv0PlmWCBYr538m8VgO+Gl2hvTAlG2/BRZZMonz27HXcK4OWhAcVTyRqiDeiPqsu8GHlmBAg9x1yVeGjRV7QuWWPuK6Ah9PBjiwV3UyjzjXtKzs1DQp8XyJ4SMTjC1ZVWihXaeIorzJwFLldy3EtaUh8ar8tHJXqMszR49tu6eoVDwRLe5V3giPN0qFPb0eYFlSLR07B0Y3mIJ+QdI73brrOL3+myeMxJEjd17ilimEpZ+9prTmKYHZEE1O2Ecf9hoMGsa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2lB/rX2aqcXkyooQOn4SEJQmcS240tFgEuHs+sdg+A=;
 b=PpPK74Ug3Y9a3mtEnKCQb7fh6gQJ0eN0icacfd+KIxcTUEp8fOvtBs2X2fOEhMn+VjFjO62Qc+f5/+l4ELMWgDhQSSlzfoHmbfy5/HwhDN5+XoABZ3w3whoi+KrZLhjDX3Yx+t39RedqlDCqM41VCkLGq8iiM29ldRI3SLO3S6/PIb+4G+vbF5cDtMAPSKnaHfxSI7dGcruWcS/ty+hsaYemGN7xZ6U28Be9G7g4W2cTgak/3QzN+V2sWJSb+Fhjq8bW4AHtm1oNKGst796TAcFpSWVDBdqDICq921bJHthdNTFirUuP8Aq0XvbENID2hutKkll+UH5k6jTaf6Qi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2lB/rX2aqcXkyooQOn4SEJQmcS240tFgEuHs+sdg+A=;
 b=We3fB/RDS0E39m1e0jQdXO2u6j3illagH+uRr7T2tNM1yYtdNaMAAFZkhXPzHemyX5dlXT+am30h8jHCzYGK8JauLgegaXpLkp7l7HCCE33y2nQo2dKIISTWN0N9QIJ9Kg0/hKsCbpXCxkxFjXNLY2dDUismAcW00TEgNuJa87s=
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 14:45:15 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::9441:ca06:5daf:ab56]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::9441:ca06:5daf:ab56%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:45:15 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <hofors@lysator.liu.se>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>, Yogaraj
 Baskaravel <yogaraj.baskaravel@ericsson.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [RFC v3 2/3] lib: add fastmem library
Thread-Topic: [RFC v3 2/3] lib: add fastmem library
Thread-Index: AQHc7f6g6z2rkNM78U2Gz4CwgnPilbYjJ/gAgABbP3A=
Date: Thu, 28 May 2026 14:45:15 +0000
Message-ID: <DS0PR12MB6608CB2B4897A5CB91D2D1C482092@DS0PR12MB6608.namprd12.prod.outlook.com>
References: <20260526085743.64396-4-hofors@lysator.liu.se>
 <20260527173042.93867-1-hofors@lysator.liu.se>
 <20260527173042.93867-3-hofors@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35F658AD@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658AD@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-28T14:42:50.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6608:EE_|CY5PR12MB6576:EE_
x-ms-office365-filtering-correlation-id: 18a8dc8b-0f37-4f85-3ad1-08debcc7bb0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: xCfTuTG1jridmEDoLWO3kJb+imfOms1j90mvn3jVGP5/uAt3Q4rdjccxocq180Y9dEiCdVXONZZTv+9wEznSx7LcOGADlKbqvjszmegbHR88QX23EmSPA+TZjnHIrZnCLEwjWO5OG9mgt1vvcSioKGRujQ9g7LbKhAum2GdJAKWTDVAvtfM+rDgDTeseCU0DviQlDMmX8TAhAsnq3kFQUbOf9/1rjn+5wqJmNgEpDGIpE9b/60tJmLndepeyo322djSyXPvnkvKF79nG9utcrzw6E7nPI8FL8vQ+qsqPVcC5Cc4/Qs9+TzzH2yB9/CYfXwMB79VR9PvA82q/RaG9tDaFkhZU5WRM14WRK6PQQb1kViAUBSJ65SMI5a1AsMYYXQczu10aS0Z2LdXKnAJEWXXcOqUH4uKxkjE5faIXH5C32B1laZ+WoVcLpOd0LRbeUetClQl7Bb8rzGnw1W6NcEXmv7NXd3cm6QaQM7mbISGcKrx2tjEEHNQOTua+ScNb/y+GvZd05bdEqUixoLsKzHXyrKfm04pfnDWQWUo4xbXxwVd6yk4Z0+U7bAcnixhPIY6odcr+8r4f3/fQ07tccjcpysqkckRl1AjcNRKxF7k/Ql21lDQEG2rpGxpM6IVhDYzSIIBFzOGq096BMqyYNRRgBkPH4JBbRttSSRGVYVOxoEt70f+JJeo8bUW0ta9Adm9cP9C5pu5unaZY8DfW4eGuEvwvPUedazA49slxO68pfoQnvnCH6Qa3Oww8Msj+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6608.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZENaSXlCUkQ2OW13OVFUSXlxS3BJdWNoUFZuQS9jUmJmRmR3UE11V3RGV0NM?=
 =?utf-8?B?UGVRTnptM3NuN3hmYmtkRmIwK1lXZ3lCckVkQ205VmJEK3VBSU5qdEt4cElL?=
 =?utf-8?B?dVBLZ2haV041cHRvVEdSZXA5RlJEZWhrc3VWRE9OZXBtenhYQVZ4bmJ6TSt6?=
 =?utf-8?B?dWFmWVZiQ3RWMi9Ibmo2NkNEZXQxWXZvbDBrYnVSb20zMC9UM1ZKaWNkWHh6?=
 =?utf-8?B?MU56Ymg4L3VMdGl2QXNMaW05T0NEcXN2Wk8zOStBQVJkOWVGcTFXMkdzK1Rr?=
 =?utf-8?B?T2JzcTBkektNT1d1cUltM1dlTGtBOXZDcmE1MXJHQzRiOUtOUTZ3UUFqWWds?=
 =?utf-8?B?czVrMjZ2dEltK2Z0QXdBVmVXNzg4MjdtSGNhTlRqVXRQUExsNzkvWEgzSzk0?=
 =?utf-8?B?aXFHSEN6NjFBSkFjRnB4eFB3djBDMVBBQjMzMnp4R1doVjVkVjlrOENXYTc0?=
 =?utf-8?B?ckpqRExPTVhQVFE1RjRVblM2ZTdEaFlla0l0OUNFUGxrY2RUeURWZ3krckEx?=
 =?utf-8?B?WUdaU1BkOVRvdHAwRzhMb2JGazQ0M1NlM3dza0RTSC91YTBUaWxRVW0zUzhw?=
 =?utf-8?B?Q1g3eWp2Vm9BY25aK2tPT1RDekNEQjA1cmJ1S3p4TmxsZnk5cVRncUVVRmU0?=
 =?utf-8?B?R1ZFRXJ3U3E3cExzWWs0d2duVUhMc2dzd00xTXBpRmJTTEFlUURMbDlMWUJX?=
 =?utf-8?B?OEZZNnE3UldpZzhzWDVOTHNlYStwQlZQblhxZGcvdWM5eTdySy9qTzVqbWpV?=
 =?utf-8?B?TUJPUGhkTHhGZGlpbm91RGxuOUFLQS84SC9HK04zQlY1WUFNZGRtZjA3VTZL?=
 =?utf-8?B?dmlLSUtWMWZiZ0t6UGxySXNVMVU4Z1RSNVJna3c5K1ZLdGxNUVJEcGJvbXF3?=
 =?utf-8?B?WGNYYmsydkdzM1RFY0VQN2FkMDJxenpIT0Nya2lJSnh4d3g2c2FWMDJQcnBH?=
 =?utf-8?B?VGZYV1R2QUpES2RyMFZZRm01bk1nSU13UVlkckU3ZEdLR0U0My9ScmpMaDQ3?=
 =?utf-8?B?Zm5PWFl1VHRYUTJpRHc5WnFpbzFoMTFlWHdlbWc3a2ZodUJnazgvTWFkUW5U?=
 =?utf-8?B?Nnd3K1JVTjVndENXdHpXSHVIak9pai9LMUE4NW1WMmdNM3huN1ZvSjFDZks0?=
 =?utf-8?B?bFY5S2c4K1JIMjF6ODRtb09adnZrd2hGOXpiaFR4Q1pBc3pBcDc2WjFOc08v?=
 =?utf-8?B?WW5XZll6c2NDQjhmN2hUZVNPZ3BnYlNCSzRPUEhlN1c1dFBPelBmQk1HK2tZ?=
 =?utf-8?B?VVo5TTNUOXBETUZJVTd6RnM4Mzhta3RTUVhrUlE2SWFGSWZ3SFV5RjVJWC95?=
 =?utf-8?B?SFJPR2NQTThDZWVqWUJtQ3RtL1hvbEhjVTY0V1YyNnBmN1NrS2FZbXErK3ZC?=
 =?utf-8?B?cXhIa296SXB4TXdNNDBPbDhGU3dQTjRuWGJpYjJUM1dLekpYeU5zYWNjRWxM?=
 =?utf-8?B?emlicWxWa25JWTNCREx4ZmtDaXV3YU5zTGFja2Q1UTVSeUhTZVFqQ2dmdHBy?=
 =?utf-8?B?WElSdmZuWDVVTnh0Q1BzdXZ0NFc2MjZQTlpPVFd2dDREem9kaFRNR1RicERm?=
 =?utf-8?B?MVVrTlZodmtua1FjSE1OY3ArSmI0K2I2L09ZZmFFZEJPZEFIZWJUUU1iOEsw?=
 =?utf-8?B?OGhUQnJKaGVWWFptKzZEa3FmUFh4eGhyUDVNTk54dmsvM2Y3ZEIydVhVWGJz?=
 =?utf-8?B?dUcvMzRnSzdXTkF1TElNY0hzWllVSnNNQUovZmg2OWZWOE40OW02Q0hRc3dV?=
 =?utf-8?B?UUtMY2VxTEhDbk1OcDJxMEZobkYvSFAybnY3aXViaEdBUWszdXl0Z2ozK1pQ?=
 =?utf-8?B?TXRTTHY5bUZ6bkZ6UVFzaU41ZDFSR0xnOFZEWFpLWHQ3MTYyL3VWckt3SE9i?=
 =?utf-8?B?N2Zoa1RVdVFLVlJxYStOTEFjS1J0Q2dzNDM2Z3MyZUN5a01jWGJUVVJpV2dp?=
 =?utf-8?B?alk1ZHRMNlJ4MnF2L21VU0RqVlhtTzhUNnBEQUJUSHVLWmRJS1FCbDNGY091?=
 =?utf-8?B?UmFjaXRiZ1dhTzUzMkkwTVUyV3FVWTQ2T3I5OHVmQm80REJ4MXFVL21nTTlx?=
 =?utf-8?B?YmVJcDZCK04xakF4bTh5bTlTSDN6dmE1Mm1MZkxhTGR2TXEzNEFlNVlSMVU5?=
 =?utf-8?B?OWkwTWVveDdCZEkrS1RiWEJzWkZCQ1ptR0V4ZnpzNjdublpDSFhGZjJOK2sr?=
 =?utf-8?B?Sm1RcVkyNUFlTU82enU0V1pwY3dTOEU5K2FRRHV4NzdNc0t0Mzh1QXREbUlB?=
 =?utf-8?B?V2hWVUJ0NHBOWWJjYVR6SDhrUmJ3T01WUE5BVWRSdUtBNVBtR3BOakswRkow?=
 =?utf-8?Q?jNQjnqJ4s22WJnIKq1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8dc8b-0f37-4f85-3ad1-08debcc7bb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 14:45:15.5265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGwjH8M7oeuKMYPldL9ywyQslYREJRdjXwUGarx7WlEpdGatBuVgm+OSLSbyC0vjy7nVV527hQwg8sEhYwtwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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

UHVibGljDQoNCkhpIEBNb3J0ZW4gQnLDuHJ1cA0KDQo8c25pcHBlZD4NCg0KPg0KPiA+ICsvKioN
Cj4gPiArICogUHJlLXJlc2VydmUgYmFja2luZyBtZW1vcnkuDQo+ID4gKyAqDQo+ID4gKyAqIEVu
c3VyZXMgdGhhdCBhdCBsZWFzdCBAcCBzaXplIGJ5dGVzIG9mIG1lbXpvbmUtYmFja2VkIG1lbW9y
eSBhcmUNCj4gPiArICogYXZhaWxhYmxlIHRvIHRoZSBhbGxvY2F0b3Igb24gQHAgc29ja2V0X2lk
LCByZXNlcnZpbmcgYWRkaXRpb25hbA0KPiA+ICsgKiBtZW16b25lcyBmcm9tIEVBTCBhcyBuZWVk
ZWQgdG8gcmVhY2ggdGhhdCB0b3RhbC4gU3Vic2VxdWVudA0KPiA+ICsgKiBhbGxvY2F0aW9ucyBz
ZXJ2ZWQgZnJvbSB0aGUgcHJlLXJlc2VydmVkIG1lbW9yeSBkbyBub3QgaW5jdXINCj4gPiArICog
bWVtem9uZS1yZXNlcnZhdGlvbiBjb3N0Lg0KPiA+ICsgKg0KPiA+ICsgKiBUaGUgcmVzZXJ2YXRp
b24gaXMgY3VtdWxhdGl2ZTogcmVwZWF0ZWQgY2FsbHMgdG8NCj4gPiArICogcnRlX2Zhc3RtZW1f
cmVzZXJ2ZSgpIHdpdGggdGhlIHNhbWUgQHAgc29ja2V0X2lkIGdyb3cgdGhlDQo+ID4gKyAqIHJl
c2VydmF0aW9uIG1vbm90b25pY2FsbHkuIFJlc2VydmVkIG1lbW9yeSBpcyBuZXZlciByZXR1cm5l
ZCB0bw0KPiA+ICsgKiB0aGUgc3lzdGVtIGR1cmluZyB0aGUgYWxsb2NhdG9yJ3MgbGlmZXRpbWUu
DQo+ID4gKyAqDQo+ID4gKyAqIEEgdHlwaWNhbCB1c2UgaXMgdG8gY2FsbCBydGVfZmFzdG1lbV9y
ZXNlcnZlKCkgb25jZSBhdA0KPiA+ICsgKiBhcHBsaWNhdGlvbiBzdGFydHVwLCB3aXRoIGEgc2l6
ZSBjaG9zZW4gdG8gY292ZXIgdGhlIGV4cGVjdGVkDQo+ID4gKyAqIHN0ZWFkeS1zdGF0ZSB3b3Jr
aW5nIHNldC4gQWxsb2NhdGlvbnMgYW5kIGZyZWVzIGR1cmluZw0KPiA+ICsgKiBzdGVhZHktc3Rh
dGUgb3BlcmF0aW9uIHRoZW4gYXZvaWQgbWVtem9uZSByZXNlcnZhdGlvbnMgZW50aXJlbHkuDQo+
ID4gKyAqDQo+ID4gKyAqIEBwYXJhbSBzaXplDQo+ID4gKyAqICBUaGUgbWluaW11bSBhbW91bnQg
b2YgYmFja2luZyBtZW1vcnksIGluIGJ5dGVzLCB0byBtYWtlDQo+ID4gKyAqICBhdmFpbGFibGUg
b24gQHAgc29ja2V0X2lkLiBUaGUgYWxsb2NhdG9yIG1heSByZXNlcnZlIG1vcmUgdGhhbg0KPiA+
ICsgKiAgdGhlIHJlcXVlc3RlZCBhbW91bnQgZHVlIHRvIGludGVybmFsIHJvdW5kaW5nIChlLmcu
LCB0byBtZW16b25lDQo+ID4gKyAqICBvciBibG9jayBncmFudWxhcml0eSkuDQo+ID4gKyAqDQo+
ID4gKyAqIEBwYXJhbSBzb2NrZXRfaWQNCj4gPiArICogIFRoZSBOVU1BIHNvY2tldCBvbiB3aGlj
aCB0byByZXNlcnZlIG1lbW9yeSwgb3IgU09DS0VUX0lEX0FOWQ0KPiA+ICsgKiAgdG8gbGVhdmUg
dGhlIGNob2ljZSB0byB0aGUgYWxsb2NhdG9yLiBXaXRoIFNPQ0tFVF9JRF9BTlksIHRoZQ0KPiA+
ICsgKiAgYWxsb2NhdG9yIHN0YXJ0cyBvbiB0aGUgY2FsbGluZyBsY29yZSdzIHNvY2tldCAob3Ig
dGhlIGZpcnN0DQo+ID4gKyAqICBjb25maWd1cmVkIHNvY2tldCBpZiB0aGUgY2FsbGVyIGlzIG5v
dCBib3VuZCB0byBvbmUpIGFuZCBmYWxscw0KPiA+ICsgKiAgYmFjayB0byBvdGhlciBzb2NrZXRz
IGlmIHRoZSBwcmVmZXJyZWQgc29ja2V0IGNhbm5vdCBzYXRpc2Z5DQo+ID4gKyAqICB0aGUgcmVz
ZXJ2YXRpb24uDQo+ID4gKyAqDQo+ID4gKyAqIEByZXR1cm4NCj4gPiArICogIC0gMDogU3VjY2Vz
cy4NCj4gPiArICogIC0gLUVOT01FTTogSW5zdWZmaWNpZW50IGh1Z2UtcGFnZSBtZW1vcnkgdG8g
c2F0aXNmeSB0aGUgcmVxdWVzdC4NCj4gPiArICogIC0gLUVJTlZBTDogSW52YWxpZCBAcCBzb2Nr
ZXRfaWQuDQo+ID4gKyAqLw0KPiA+ICtfX3J0ZV9leHBlcmltZW50YWwNCj4gPiAraW50DQo+ID4g
K3J0ZV9mYXN0bWVtX3Jlc2VydmUoc2l6ZV90IHNpemUsIGludCBzb2NrZXRfaWQpOw0KPg0KPiBA
QnJ1Y2UsDQo+IEkgdmFndWVseSByZWNhbGwgdGhhdCB3ZSBkaXNjdXNzZWQgc29tZXRoaW5nIGFi
b3V0IGJ1c3NlcyBhbmQgc29ja2V0cyBhIGxvbmcgdGltZQ0KPiBhZ28sIGJ1dCBJIGNhbm5vdCBy
ZW1lbWJlciB0aGUgZGV0YWlscy4NCj4gSXMgc29ja2V0X2lkIHRoZSByaWdodCB0eXBlIChhbmQg
cGFyYW1ldGVyIG5hbWUpIHRvIGlkZW50aWZ5IGEgbWVtb3J5IGJ1cz8NCj4NCj4gQFZpcGluLA0K
PiBZb3UgaGF2ZSBiZWVuIHdvcmtpbmcgb24gdG9wb2xvZ3kgYXdhcmVuZXNzLiBTYW1lIHF1ZXN0
aW9uIHRvIHlvdToNCj4gSXMgc29ja2V0X2lkIHRoZSByaWdodCB0eXBlIChhbmQgcGFyYW1ldGVy
IG5hbWUpIHRvIGlkZW50aWZ5IGEgbWVtb3J5IGJ1cz8NCg0KU2hvcnQgYW5zd2VyOiBzb2NrZXRf
aWQgaXMgbm8gbG9uZ2VyIGEgcHJlY2lzZSBvciBzdWZmaWNpZW50IGFic3RyYWN0aW9uIHRvIHJl
cHJlc2VudCBhIG1lbW9yeSBidXMuDQpCYXNlZCBvbiB0aGUgdG9wb2xvZ3kgd29yayB3aXRoIGxp
Ymh3bG9jLCB3ZeKAmXZlIG9ic2VydmVkIHRoZSBmb2xsb3dpbmcgYWNyb3NzIEFtcGVyZSwgSW50
ZWwsIGFuZCBBTUQgcGxhdGZvcm1zOg0KDQpGZWF0dXJlcyBsaWtlIFNOQyAoU3ViLU5VTUEgQ2x1
c3RlcmluZykgb24gSW50ZWwgYW5kIE5QUyAoTlVNQSBQZXIgU29ja2V0KSBvbiBBTUQgY2hhbmdl
IGhvdyBzb2NrZXRfaWQgbWFwcyB0byBoYXJkd2FyZS4NCkluIHRoZXNlIG1vZGVzOg0KDQoxKSBB
IHNpbmdsZSBwaHlzaWNhbCBzb2NrZXQgY2FuIGV4cG9zZSBtdWx0aXBsZSBOVU1BIGRvbWFpbnMu
DQoyKVRoZXNlIE5VTUEgZG9tYWlucyBhbGlnbiBtb3JlIGNsb3NlbHkgd2l0aCBtZW1vcnkgY29u
dHJvbGxlciBncm91cGluZ3MgKGkuZS4sIG1lbW9yeSBidXNlcykgcmF0aGVyIHRoYW4gdGhlIGZ1
bGwgc29ja2V0Lg0KDQoNCkRlcGVuZGluZyBvbiB0aGUgYXJjaGl0ZWN0dXJlOg0KYSkgTWVtb3J5
IGNvbnRyb2xsZXJzIG1heSBiZSBjb2xsb2NhdGVkIHdpdGggY29tcHV0ZSBjb3JlcyBvciBwbGFj
ZWQgb24gc2VwYXJhdGUgdGlsZXMuDQpiKSBBcyBhIHJlc3VsdCwgc29ja2V0X2lkIGNhbiByZXBy
ZXNlbnQgZGlmZmVyZW50IHNjb3BlcyAoZnVsbCBzb2NrZXQgdnMuIHN1Yi1zb2NrZXQgZG9tYWlu
cyksIG1ha2luZyBpdCBpbmNvbnNpc3RlbnQuDQoNCg0KDQpIZW5jZSBwcmFjdGljYWxseTogSW4g
c29tZSBjb25maWd1cmF0aW9ucywgc29ja2V0X2lkIOKJiCBtZW1vcnkgZG9tYWluLiBJbiBvdGhl
cnMsIGl0IGlzIGNvYXJzZXIgdGhhbiB0aGUgYWN0dWFsIG1lbW9yeSBidXMgdG9wb2xvZ3kuDQoN
ClRvIGFkZHJlc3MgdGhpcyBhbWJpZ3VpdHksIGluIHRoZSB0b3BvbG9neSBwYXRjaGVzICh2NS92
NiksIHdlIGFyZSBtb3ZpbmcgdG93YXJkIGNsZWFyZXIgc2VwYXJhdGlvbjoNCg0KYS4gQ2FjaGUg
ZG9tYWlucyAoTDEvTDIvTDMvTDQpIGZvciBjb21wdXRlIGxvY2FsaXR5DQpiLiBOVU1BIGRvbWFp
bnMgKG1lbW9yeSArIElPKSBhcyB0aGUgdW5pdCBmb3IgYWxsb2NhdGlvbiBsb2NhbGl0eQ0KDQpU
aGlzIGRpcmVjdGlvbiBiZXR0ZXIgcmVmbGVjdHMgcmVhbCBoYXJkd2FyZSBhbmQgYXZvaWRzIG92
ZXJsb2FkaW5nIHNvY2tldF9pZCB3aXRoIG11bHRpcGxlIG1lYW5pbmdzLg0KDQpIYXBweSB0byBh
bGlnbiB0aGlzIHdpdGggdGhlIHRvcG9sb2d5IG1vZGVsIHdl4oCZcmUgaW50cm9kdWNpbmcgc28g
dGhlIGFic3RyYWN0aW9uIHJlbWFpbnMgY29uc2lzdGVudCBnb2luZyBmb3J3YXJkLg0KVGhhbmtz
LA0KVmlwaW4NCg==
