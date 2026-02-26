Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B300DFD45F9
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 01:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FE9F402AA;
	Thu, 26 Feb 2026 02:18:52 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11020117.outbound.protection.outlook.com
 [40.93.198.117])
 by mails.dpdk.org (Postfix) with ESMTP id DC5AE400D6;
 Thu, 26 Feb 2026 02:18:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8fSmGY9DRYEYc4KKE2KNWSL+8WEZv7rU/ZzQIXCf98gJy8EKIXIk79nQlUWurH9lTSgMUCgZPzDq8ogQq1+G2txCBduFtqX4aLWNT5NdVwD8FWcjQc1Kdyqo/ipx8W6GunryeA5JTcW+WyGh5Wrz0eKvlZME776Nh1NhzHzag8K43PaYcoPbdOaotwQRya8LHv7xaf3XHfgS/cJiOf/KNAttCATWcoDHOkjF2plJClflgeus7QIjs7NdUTr3P6E77ngaVEOwr79i0wghMB+lYF2BhZVhTV6ykmp5S5H1q72OGyLjz85bpFdxF1VY1VAoTkZ/eIRKANo0sY+MPtH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqK3W4+UTHdTzOqdZ8mAzahnhbLZMq6Gye2+SVu+vX4=;
 b=bF1ujxM5XuqONEoFHA0w0bxYfeFdWOO2LrlaROXE/QbblPUKWwbhITcmYuBA5a+dQ7bgIiFSDYu1X/2Uvj+QyDr3o0zfzgh2sD6lLliNSedBvvVtc2xkh3LGFI0DLVG+F3zyzVkRB1hLIWBVjamS8ZUwD2k1JD5L5jrzAWZyklnVX/NHUZQuf6H+elonccsZ2JPv+7aAlOaeI9xHULEIcJtvbSBj924wC2aUDWANp2/ZePjNjD8RS1DWE4YIuX5zmSCTC0O7P+Nnvr6wiiZ1P20+22QuV2CnVeFd/8j04Sx+0+uHnuXobwluzAYbJM8AFc/k+BMzub6PuMQX7fL7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqK3W4+UTHdTzOqdZ8mAzahnhbLZMq6Gye2+SVu+vX4=;
 b=hcj4dsQEZUKjVIm6YaqCWGuAtdXHwSDGarxaZCD259jFrSL2Utgftmeo18881aM/qO7dV7rhIMRvnDuBBzPbfZ2kBV5Yc7ig9ujyQKl3/bca0syIjMMCbUVmcUtkFi8Ujt+XQcnVNPKi3nhow+4vbi6uQVUh3notNEEcKZZbxeQ=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB6823.namprd21.prod.outlook.com (2603:10b6:8:2ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.7; Thu, 26 Feb
 2026 01:18:46 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 01:18:46 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 0/7] fix multi-process VF hotplug
Thread-Topic: [EXTERNAL] Re: [PATCH v3 0/7] fix multi-process VF hotplug
Thread-Index: AQHcpfrbcYIQWDruDk6+ESE/uOyIU7WUAlgAgAAtIdA=
Date: Thu, 26 Feb 2026 01:18:46 +0000
Message-ID: <DS3PR21MB5735A2A3C1C5BBA3FCCF0175CE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260225020246.890306-1-longli@linux.microsoft.com>
 <20260225143616.581a8aeb@phoenix.local>
In-Reply-To: <20260225143616.581a8aeb@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=80baaff9-718f-45bf-9938-3ea5bc42012d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T01:17:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB6823:EE_
x-ms-office365-filtering-correlation-id: d280c538-9c37-4382-fc97-08de74d4fd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: wBPYqiJvTTpEkPrzWM36eaCfUGruWSvgmyCRIj2o1/TAGvHcvKTRExxpRijlWS3WLjsAosgIqZGZe99iFARq+HSBfdoN51QZ+bnA0z/3XlfO2e0BpXDWd55OBGuQNPDQ7kS/cCpLT0C/eribcnl3bkbKSdCuuwEplxF2uoenpq8CEGjnTAgN85bv5PNLPieLWXUg+UXno6ZjD/Jlk4/LUJOv94cemTksLwwoElW0JvVXlhvqNWln9Hui0br5jUjcubB5juHYD/yU0PYb2MQ0c5IsW32VHnnwSSVKPOd195B2lV8sN5t2EMWvA/rqEXJGbbHcbgnrVgPpGr4+EaIkuR4WwoWf+nO/BukF35wiLzsF7rbXqKneM4ozzUOczt181HGSP+/T7kk/HGvMcTDRlxJGtmpeynqvBJX4LKi7uf6dwWlYZDhyTZmNoYbcORXq77xt5i9D9QvmP3KR+DF8UWtc49sj2dc3RYvQqtjBW46svPuiz7rJHwmNMRLsjCphDVsgMitp/ldlBYiKgXdjtNP1MlwoC8CQl8V0+qlZRDAyXnE7QEgT7Lm5iVsao8RGoRjlXJTwitSp0ufPGkGmAskiPoB/XDnJsG61mFYUQnDIFLcTvGAuv1z0XnIDO3o6bskj8KhJc2IQOcN9P10+9rjHE4eQHfBgSK0IOX3NMWX1g1fdkTGjhPw8MOXHM4xezKLjzVLy6N6PoMBARjXYVzifyW+mNRjLtyFaqnqQhteBus3clUXHwKxz7sipnqP9/p5BwRIIQ6ajClozQ0WJEaRBLw8p75STMJddUyKmD3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjlkWlRkRDhmM3NsM0g0MTUvS1RJTTRwZTltc0lhOFBwRkczampKRjZraGFw?=
 =?utf-8?B?WEJzTFpIRUVGbjRVNGorK0xpeTYxMVc2cTlrWGNGenZTYUVMOExtang4VVVE?=
 =?utf-8?B?T21ubGdmU3lQU0JhN2ltZDhtTmFQMVpncXEzVFQ3TG51eGEzdiszRjI5MmY1?=
 =?utf-8?B?b2dLSXdiQlNZNW9ibkpFOThsclZyc2NXK2h6ZENFaDVVODI0d1FzQmtoejBX?=
 =?utf-8?B?YSs4N0RQdHZDN3h4Tkxlc09sNWV4aTgybFdkdlgyL3dNWVBKQ0FkTW4rN3BH?=
 =?utf-8?B?SVhZTVpnempPYmhKOFZubjBvNE54OThnemNjSGhzNkZqTkpBOUtJV3YxM1BJ?=
 =?utf-8?B?UmxYd25TamRLZGFGaXlDOHdaV2Y1MTVzakZYUmU5aXB1R29ZWFpPbFplMTRt?=
 =?utf-8?B?N3M0MTdrVzQ2M0owVFlCUUJiZWlGSThEdGZVakNiTUlRQ2dlek5NcEQ1M01s?=
 =?utf-8?B?YXZBVTZQS0NHeE9PRXE3Wi9xWlRQY2hmSk5MdkltMmVrN0YzKy9pQzV1d0FM?=
 =?utf-8?B?MEFkQ3JDaEFBOEVKU3ZjcXZpbmdCSllUYXkxQzMwSmduRGJ2NDc4K2t5LzNT?=
 =?utf-8?B?aE1KRWZjM3YzYTRMVmRIUllMcnJtSVVtUVE1OWNtNlNhVHBoaHFXQ1pGWEt4?=
 =?utf-8?B?YnoxZHJiRzZtZGpUR2hpV0xyZlpsK2FxaEVjZlU5blBZWTI5cHpwMFU5alkv?=
 =?utf-8?B?RWZpeEhuaHA1ZkNaRitkTGZoN2I1RjV2a0hyM0xvc0dOQnZaNlMzbmw2K3NG?=
 =?utf-8?B?cm1iRlg1Y0tzdWJhOS92Ky9ScGxTRm1LK2RiOExQaWdMQlBKblRhUWdvMDNu?=
 =?utf-8?B?VWlscmpiL01LQXlIK1dTVUY1OVRHK2pJWFJiT2ZPcVZTUDNvaFdMQnQzVTN2?=
 =?utf-8?B?V3JRckNSaU1BK0pxNlFFYjRXMk5IekZweGtFTmJBcXBpNExMVWR0OUVZckVK?=
 =?utf-8?B?bFBraEdDUmhKMWdoalk3WG9EQm52NTErUm4zSWtMcmkrRzJoeDRaeXJWTXlw?=
 =?utf-8?B?R2paM0Vkb203VDBxRG9wcGJCYm96ZmVQQVNJQWU2bFlPODZGQkkrZkpCeXlm?=
 =?utf-8?B?N2hYL0xnVmZVZ3VTNys5UCtPZWN2aUhZOUplRkNOa3hhWGdPOGNLTFdoVWNy?=
 =?utf-8?B?dzZXalJ5SFJjWURpK214L3dQK1hPcFdnWk5udDRSQ0lEUkFyVTcxLzMrUU1T?=
 =?utf-8?B?ZEVzTHp2Z1hGVHZETm00anRndEUwQ0w4WDl0U3FjWlRDWTh6RkovUXlGbU5H?=
 =?utf-8?B?OHppRGI0UjJLSEZ0UFhxRkZpUjBHOWNFbWovOGsyeXJ1Q3pGREJYY0dIOG9Z?=
 =?utf-8?B?WU44S3NaMzFQVTU3M08wN0U2OWREMFpHR3ZEaXpENGxGZGdUVy8rbGd1dnVi?=
 =?utf-8?B?WTNtOGppQW9iakVTb3RzTy9NNWQ5WDV2a0RTZ01nNFNmdXJXSVBnWHI4azJV?=
 =?utf-8?B?b3J0U21YYzNYRHBOY25KS0p6QW81V0RQK1A3VGZXRU5UcHFodHY1TkdJUXN3?=
 =?utf-8?B?bWF0bWwxWjczNTlCNFpTVTNQMkhGa0J1M09rdHVuVTVHMGxBTFdUMWhRSkl2?=
 =?utf-8?B?ZDRoM1hBZmJwU3ZOTlpjN3Z0RERxT25oTzdkNkdZM2o1Q3d4bWVqNXp6alFR?=
 =?utf-8?B?Y1l1ckxUWkkvSkxmcTZBUzl5S1hNYXJHbzhJcXI2ZTVuYlFFbEhxYW1jOSti?=
 =?utf-8?B?ZllZZU9Ed0wwYitESDBWZXZobzZGLzVBN2ZRUHFCTTlxNjQ3QUNSeHZadlQr?=
 =?utf-8?B?eStaUG5mYnRqME13dzJqTmtNc0lqOUlKcWpTWElBOGJGL3Z5dXlMUlBucVdu?=
 =?utf-8?B?VmhyWW9rZnFjSDc3eWZtMk1mN21lN0FnL212M01yNVpRbXc1bXlWYzdpSjJW?=
 =?utf-8?B?b0RGbXppMXhtNnBNeWppQzZSdkNpR1F0dFA4eVZ0alRRWTdJcTY1eTJUdlFj?=
 =?utf-8?B?UFpUZVNUOU52ZkFPUDBHVXRKS1dpL0ZNTndTWDdIQVBUc3VaWStzenA0eVZ1?=
 =?utf-8?B?c2VMd090d3VYNUMzeVFPWk45d0QvdmRSODU2NDNLUXJUTHBWQTRsNlc0NStS?=
 =?utf-8?B?YW0rQmVocHZOV0xKTDJEb2ZJYnlZMVdnYTgxUUdLanFvYWRLaks2NXc3Ty84?=
 =?utf-8?B?dC82bFVEeWJHUzVBbERMNDZPN2VmUjBHeG1pYk91UHBpOWRrVXZiMk12STRE?=
 =?utf-8?B?VlBoVU1NS01VbUJ0M0l6TFhhaEVRdk9oYnZvMUY4Yll0TVhYaTIvSTV4T3ow?=
 =?utf-8?B?UEgrMTJ1UXBIck5UR0VXOWdxcnVZUkk0QktUUm8wT0Q2SmI1SVBNbnU5S1Fn?=
 =?utf-8?Q?SzL8CNLvb+ds0kcXxg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d280c538-9c37-4382-fc97-08de74d4fd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 01:18:46.3643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1IU7+xdGe/xyg9GxgpkWBUgp0ufTRvva4dLmD0qWY3CGfXFNbcgUPjGbbhWvK4fBMdp/B+vc1Hu1nizMiMoUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6823
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

PiBUaGlzIHBhdGNoIGlzIGdlbmVyYWxseSBpbiBnb29kIHNoYXBlLiBVc2luZyB0aGUgQUdFTlRT
Lm1kIGFuZCBBSSByZXZpZXcgZGlkIHNlZQ0KPiBzb21lIHRoaW5ncyB0aGF0IHNob3VsZCBiZSBh
ZGRyZXNzZWQuIEFzIGFsd2F5cyB0YWtlIGxvb2sgYXQgQUkgcmV2aWV3IHdpdGggYQ0KPiBza2Vw
dGljYWwgbWluZDsgc29tZSBvZiB0aGlzIGl0IGJlaW5nIG92ZXJseSBwaWNreS4uLg0KPiANCj4g
IEEgZmV3IGZpbmRpbmdzIGZyb20gcmV2aWV3Og0KPiANCj4gUGF0Y2ggMS83IChuZXR2c2MgcmFj
ZSBjb25kaXRpb25zKToNCj4gDQo+ICAgICBuZXR2c2NfaG90cGx1Z19yZXRyeTogaG5fdmZfYWRk
KCkgcmV0dXJuIHZhbHVlIGlnbm9yZWQuIFRoZSBuZXdseSBhZGRlZCBjYWxsDQo+IGF0IGxpbmUg
Njc1IGRvZXNuJ3QgY2hlY2sgdGhlIHJldHVybi4gQSBmYWlsZWQgVkYgYXR0YWNoIGR1cmluZyBo
b3RwbHVnIHJldHJ5IHdvdWxkDQo+IGJlIGNvbXBsZXRlbHkgc2lsZW50IOKAlCBhdCBtaW5pbXVt
IGxvZyB0aGUgZXJyb3IuIGhuX3ZmX2FkZF91bmxvY2tlZDogZ290bw0KPiBkZXRhY2ggYWZ0ZXIg
LUVFWElTVCB0ZWFycyBkb3duIHRoZSBvcmlnaW5hbCBhdHRhY2htZW50LiBXaGVuIGhuX3ZmX2F0
dGFjaCgpDQo+IHJldHVybnMgLUVFWElTVCAoYWxyZWFkeQ0KPiBhdHRhY2hlZCkgYW5kIGEgc3Vi
c2VxdWVudCBjb25maWd1cmUvc3RhcnQgc3RlcCBmYWlscywgaG5fdmZfZGV0YWNoKCkgdW5yZWdp
c3RlcnMNCj4gdGhlIGNhbGxiYWNrIGFuZCBjbGVhcnMgdmZfYXR0YWNoZWQvdmZfcG9ydCBmcm9t
IHRoZSBvcmlnaW5hbCBzdWNjZXNzZnVsDQo+IGF0dGFjaG1lbnQuIFRoaXMgbGVhdmVzIHRoZSBW
RiBwb3J0IHdpdGggYW4gb3duZXIgYnV0IG5ldHZzYyB0aGlua2luZyBpdCdzDQo+IGRldGFjaGVk
LiBDb25zaWRlciBza2lwcGluZyBobl92Zl9kZXRhY2goKSB3aGVuIHRoZSBhdHRhY2ggd2FzIGFu
IC1FRVhJU1QNCj4gcmF0aGVyIHRoYW4gYSBmcmVzaCBhdHRhY2guIFZlcnNpb24gbm90ZXMgKHYy
L3YzIGNoYW5nZWxvZykgYXJlIGFib3ZlIHRoZSAtLS0gbGluZQ0KPiBhbmQgd2lsbCBiZSBpbmNs
dWRlZCBpbiB0aGUgcGVybWFuZW50IGNvbW1pdCBtZXNzYWdlLiBNb3ZlIHRoZW0gYmVsb3cgLS0t
Lg0KPiANCj4gUGF0Y2ggMi83IChtdWx0aS1wcm9jZXNzIFZGIHJlbW92YWwpOg0KPiANCj4gICAg
IGV0aF9obl9yZW1vdmU6IE1QIGluZnJhc3RydWN0dXJlIHRvcm4gZG93biBiZWZvcmUgZGV2aWNl
IGNsZWFudXAuDQo+IFRoZSBjb3VudGVyIGRlY3JlbWVudCBhbmQgbmV0dnNjX3VuaW5pdF9vbmNl
KCkgKHdoaWNoIGZyZWVzIHRoZSBzaGFyZWQNCj4gbWVtem9uZSBhbmQgdW5yZWdpc3RlcnMgTVAg
aGFuZGxlcnMpIGhhcHBlbiBiZWZvcmUgdGhlIGRldmljZSBpcyBjbG9zZWQuIElmIGENCj4gcGVu
ZGluZyBobl9yZW1vdmVfZGVsYXllZCBhbGFybSBmaXJlcyBhZnRlciB0aGUgbWVtem9uZSBpcyBm
cmVlZCwNCj4gbmV0dnNjX21wX3JlcV92ZigpIGRlcmVmZXJlbmNlcyBuZXR2c2Nfc2hhcmVkX2Rh
dGEgKGZyZWVkDQo+IG1lbW9yeSkgd2hlbiBjaGVja2luZyBzZWNvbmRhcnlfY250LiBTdWdnZXN0
IG1vdmluZyB0aGUgY291bnRlciBkZWNyZW1lbnQNCj4gYW5kIHVuaW5pdCB0byBhZnRlciBkZXZp
Y2UgY2xvc2UvcmVsZWFzZS4gU2Vjb25kYXJ5IGluaXQgZmFpbHVyZSBsZWF2ZXMNCj4gbmV0dnNj
X3NoYXJlZF9kYXRhIGRhbmdsaW5nLiBJZg0KPiBuZXR2c2NfbXBfaW5pdF9zZWNvbmRhcnkoKSBm
YWlscywgbmV0dnNjX3NoYXJlZF9kYXRhIHN0aWxsIHBvaW50cyB0byB0aGUNCj4gbWVtem9uZSBi
dXQgaW5pdF9kb25lIGlzIGZhbHNlLiBDb25zaWRlciBjbGVhcmluZyBpdCBvbiBmYWlsdXJlLg0K
PiBTYW1lIHZlcnNpb24tbm90ZXMtYWJvdmUtLS0tIGlzc3VlIGFzIHBhdGNoIDEuDQo+IA0KPiBQ
YXRjaCAzLzcgKG1hbmEgUEQgbGVhayk6DQo+IA0KPiAgICAgUEQgZGVhbGxvY2F0aW9uIG9yZGVy
LiBpYl9wYXJlbnRfcGQgaXMgZnJlZWQgYmVmb3JlIGliX3BkLiBJZiB0aGVyZSdzIGENCj4gcGFy
ZW50L2NoaWxkIGRlcGVuZGVuY3kgKGFzIHRoZSBuYW1pbmcgc3VnZ2VzdHMpLCBkZWFsbG9jYXRp
bmcgdGhlIHBhcmVudCBmaXJzdA0KPiB3aWxsIGZhaWwgd2l0aCBFQlVTWS4gQ29uc2lkZXIgcmV2
ZXJzaW5nIHRoZSBvcmRlcjogZGVhbGxvYyBpYl9wZCBmaXJzdCwgdGhlbg0KPiBpYl9wYXJlbnRf
cGQuIFNhbWUgdmVyc2lvbi1ub3RlcyBpc3N1ZS4NCg0KVGhpcyBpcyBhIGZhbHNlIGFsYXJtLiBp
Yl9wYXJlbnRfcGQgbmVlZHMgdG8gYmUgZnJlZWQgZmlyc3QuDQoNClRoZSBvdGhlciBjb21tZW50
cyBtYWtlIHNlbnNlLiBJJ20gbWFraW5nIGZpeGVzIGFuZCBzZW5kaW5nIHY0Lg0KDQpMb25nDQoN
Cj4gDQo+IA0KPiBQYXRjaGVzIDUtNy83IChmcF9vcHMgaW4gc2Vjb25kYXJ5KToNCj4gDQo+IFRo
ZXNlIGxvb2sgY29ycmVjdCBhbmQgd2VsbC1wbGFjZWQgKGJlZm9yZSB0aGUgZXhpc3RpbmcgcnRl
X21iKCkpLg0KPiANCj4gTWlub3Igbm90ZTogdGhlIHBsYWluIChub24tYXRvbWljKSBwb2ludGVy
IHN0b3JlcyB0byBydGVfZXRoX2ZwX29wcyBmaWVsZHMgY291bGQNCj4gdGhlb3JldGljYWxseSB0
ZWFyIG9uIEFSTSBpZiBhIHBvbGxpbmcgdGhyZWFkIHJlYWRzIHNpbXVsdGFuZW91c2x5LiBUaGlz
IGlzDQo+IGNvbnNpc3RlbnQgd2l0aCB0aGUgZXhpc3RpbmcgYnVyc3QgZnVuY3Rpb24gcG9pbnRl
ciBwYXR0ZXJuIHNvIG5vdCBhIHJlZ3Jlc3Npb24sIGJ1dA0KPiB3b3J0aCBrZWVwaW5nIGluIG1p
bmQuDQo+IA0KPiBPdmVyYWxsIHRoZSBzZXJpZXMgaXMgaW4gZ29vZCBzaGFwZS4gSXRlbXMgMiBh
bmQgNCBhcmUgdGhlIG1vc3QgaW1wb3J0YW50IHRvDQo+IGFkZHJlc3MuDQo=
