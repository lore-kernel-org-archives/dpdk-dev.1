Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B02C43602
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 12:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A34240268;
	Wed,  8 Jul 2026 14:28:13 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by mails.dpdk.org (Postfix) with ESMTP id 6A4C840265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 14:28:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaDBZKOd12k20AtZHRftSjJKfc+xK7t4i5diuF2bWGfpcIJTAOMrg0m4zgbCgbijvOhjKQVUdUkeGNdflr8+WMjncnD7xF+rgLbRMfGwh654+muR5pAMs3mNNlp5HtYxeP/292xRVmBuXxA81t9M0xDZ/EozdLNVlHNxseyi+YMTuluaiAQUxB5myREG1Z8noiaviI7/vGpDulm7OOfowvYYJJeQYr4sv+BXJiEIQXh4sFJoPQqAz3y+zTtEb5uR1M6dHju4UTU7ELgtf5undaFAdusJGyhDgBqeoYJ6l39+L1STtwRjlYwBCbrA3hOIjAQf0VtIvpr5LIQe77dBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HPQ1+7f89MrjRpvxgtcgIhoKjtmpL87QZSI9M3Dyx4=;
 b=aYb5LVJJbt1+EVTzAwK6mg0O5xmVFDGvylemy5TGIHkiNr56dN2ieDC1LVxH1t1WXdXh2TepnHSEelbyYCT5Ozvv4aoVXZOXuBnffWCB9ueSBd3f/7LrP921LoEn85NQEkBxB0BmOrK+x4v78rB+tphGYq3TEGuGmGK2KLZ5IR0LZdinQxy+HAduyaeaKYKQW5wS3dXsZdC6akBLztY7ighkvZp/LpfecEAkyE6Yk05XP11kMPDKH/XiPD/kIXgTRiUL2hxbM1eD9IY02DAUW5Pk5hAZCVmkuEPqVa4S/MTJngYK8JyPfQxCDG7mVp8IrQfWc37Fx4wBcwAw6+ckNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HPQ1+7f89MrjRpvxgtcgIhoKjtmpL87QZSI9M3Dyx4=;
 b=MNCuikgJQXiOw9wU203ZpMODMUox+MprGMLH4W7bD9nRarM2iwOFYAnUnBGJFJuWromdPklWWEM77nwk2wGjKwO+d7PySmrpnkpdiwxZJ/FNHYITBEKGSubaAVZeD/x4UudUthigLXyq6iw0TmuBeBrK7Xe85yiCkU3Qih7Uk9a1mbWqFm+Z2UrtTZniP7I+g4emvyPKwDSCcK1xjZeDO14PJaav69d/O6S1HHXtLUUhNd9o/bh54Oh9sLFQZV4VIc8UB1eq6XQpfVgO/xyezW7fGUNOprkwcn97smTL7BnxCzhoQhV2TbzGY5smreJ+y8bsNVJQjDqKlbGm0LyP5Q==
Received: from LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 12:28:04 +0000
Received: from LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4]) by LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 12:28:03 +0000
From: Wisam Jaddo <wisamm@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Raslan Darawsheh <rasland@nvidia.com>,
 Maayan Kashani <mkashani@nvidia.com>
Subject: RE: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Topic: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Index: AQHc9BgqU5MXD4EJbU6GnkYjz7nN67Y3qjmAgCwI/3A=
Date: Wed, 8 Jul 2026 12:28:03 +0000
Message-ID: <LV2PR12MB589331A1E8F78B5C9F3DC9C6A4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260604114851.12586-1-mb@smartsharesystems.com>
 <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
In-Reply-To: <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5893:EE_|PH7PR12MB7356:EE_
x-ms-office365-filtering-correlation-id: 43b87960-4dae-48b3-6057-08dedcec5b49
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: DdA8s1HOxkP9EX5ztSf/e1Mn0GDVK/tmam3YdYZsfnn0V5u2ugViT9qR5fHWhMwAkqY1YMvtT8DNJQM2Si1jVqc8k2e2hY3djqmf37tzqdH/s8KcnQ+Zn7zKI4fmF/qN8ZlN855rCY6ATexdxc8wp/W7gYJKRw/kxwWvoWdYy6DlkvqIwxHociU7BMdPPO5DvY0HmiQtHSCFpl6auGJF4FcLgOJMpVejV+Qr3RRURuvIg0w3KCDTgkyp2PhWeJrgea+/Hz2du1kgJCYmfD7A0cXY65ZR2lUNTyaGGuTdUT5t6FONaNPvwHmjVFHACrCLIycq5UFubKhV4V4mPSVviOxx5iLggllrGQhtV5TEMzW5IZYVNHBBFpWfetay6BfW4mVSeQqO0WZrTMoYOovo/Pu+yN0SHz2XnGCA1D0W4J3ETbSSnzXYLmE49pVYzHodjK2r3rsAPshmv7/f+H1sK+tXR7o4mTR7X6UGyKIKyjWruvgYGxh/eWiJ3VDL6HH6zYbysun1LUFbCIr5SBJzYOkizXFxF8v49zzX53zEufVncMb/CHMaX7ZTn1+Z+sUSnA3v14AHOq+yP0YaO3FATtwLAFiGtJUx6mtfBGIbJiGsPm3wwfDAeC1e7cl1fi+JrqU5vFEivPuK9YQFPzCZbV2qe1Y5G8uGjJY0GMQNXVvKJRyKndLPwOMgb3UAakUStiwL7/8tbSQ6aac27agc/t0L5Sj3gEejFt0a+mHwREE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5893.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1xcXR5cHhndnJ4MGhNamUzeC8yQ0tvN0FtUWlEbnVTOWRXVEt3TnErdjh1?=
 =?utf-8?B?Y29ZNnZmMmE3TnY5Y0xCSXRzaytrQkRSd1p1L1pSbmRob0dnMXR1bHVFMlVO?=
 =?utf-8?B?SUgxRGhMNE9ZWnBNbVRLNlBTVEhoN3JLdDN6Um1oMWU2b1ZHMGtvN1RHN29J?=
 =?utf-8?B?VEFPb0pRQXFZMndTMVlaZ3F1OFRIOFczdVZ5Wm1CR2RqRTdvcGpqZVFUb0gz?=
 =?utf-8?B?elJZR2xHM3JVaHNoOFo4b2F1blkxSDFFZHdOTzVpOGZxQlo3ZEJtQnBiU1F4?=
 =?utf-8?B?MHdwQVZRdGJtMUFUTHRjNkZvT2ZKbUZiTzlFUTFROUNrbDVSMzNCektHN3Yy?=
 =?utf-8?B?ZkQ4L0dmYXA2WmxaUm95MEZjQXczNWppWWdrUks2ak90U3I4d2Z1bURzZDhT?=
 =?utf-8?B?ZzhKZ3VJVTlSTDkwc1lFa2docnlyODFlTDJVdVBFY1dFS3htK3NEWjR4Ylg2?=
 =?utf-8?B?Y2ZvcE1QM3paMVNYRE9OMG00TWR0VGpBeGpCNmpsM3B2MXQyck8zTHBHaVJm?=
 =?utf-8?B?eFBDV0NsU093dlpmSzQweTlVaVl4WDZySCtndUVFUUxwQURRTXJ1SkFEa1dL?=
 =?utf-8?B?SGxhOC9MOEZWUmJtczc3ZW80ZmNMT2VDYnQwZUxxTGhMSlMzUFdUeGNwajZF?=
 =?utf-8?B?QkhwQ2tMaWMxc2VpZzRydmNGL0xrZVNudFRGOFkvQjZXWUNlMjE3M3BRYkVa?=
 =?utf-8?B?aVR5STQwZGsvVEVVdjFvSmtFaXBhZHFpUUNmcHFTYXd4cDRiSE5vQkxMTDBx?=
 =?utf-8?B?SnNzK3RpbjhMTHBsVWxuR3dHQ3RLekJlR3VsNzJ1UGp1ci9WcnNlQTRaeksx?=
 =?utf-8?B?a0ZJSjYwVDBhYnFmTzBlWk5KSitocWwwVXVva3dUNUFQbDVoa1RpMnp2WWI0?=
 =?utf-8?B?Qk96dHkyQkw4dmdjT0NhdlR3eXF6bDhGM3VVaU1nRzJ0YXhpcU5oRXdZTDlH?=
 =?utf-8?B?N3ZGVlNmYlpDSEtITGpjQmcrNUxKSUtYY3hheTEvTE14ZVVxMHFLbEJSN0Ns?=
 =?utf-8?B?QitxRS9GNm5CeVJaTTFhV0tMM004a2syTTZjMDU4T1VXTVNqYmhIZ3FEaC9S?=
 =?utf-8?B?bXJ4RE1JRDc0dURRQjkzZGZsZEY4SWwrREZpYUZINyt5ZkhSWm1ieUJEbHRu?=
 =?utf-8?B?WXNRaVhIdmNzbXBubXJWaGQwVldBdERmZFc3M3dSc2hVTXl2cWxERGpMMkhI?=
 =?utf-8?B?VTNkMVdoMWo5UGVFM2o0UmxYT3RmSldZVDJIdGw3R0luckJCWGFJWXZkeUJS?=
 =?utf-8?B?ejRsRW9TWnU1cU9JTURDQUxNU28wd1YybFdHMVpYSVY0aWtpckErV0laZk9j?=
 =?utf-8?B?M0RraDhnT2p0eUYxakJ3TEhoNEhQa3pMYzlCSUNaRUFJWnJGQ1ZLRG91UlNR?=
 =?utf-8?B?RHNoWFFtZnR4UXBYeUd1MmoxRTdub0xsYTBuU3kxdXI3bW5UNlNCYUljWDhl?=
 =?utf-8?B?ajU0aktLOUNGbjZPakQ1ak4xSjBTaUwwOTI1NzNkSzBFdENrZUZSck9HQ1I1?=
 =?utf-8?B?MWhzeFNjeWlwU0JmNHlSU2VCRkJJaFMzYmN5YXVoQWZOVHlGYU9DRUZRRTFt?=
 =?utf-8?B?blBNbVRWZFNSNGxCQVpGMm1yVjkyWFRGeEFiNXJndTZOTEI1QmNwR1dMWkNk?=
 =?utf-8?B?a0FPdkc0ZWRjVmMxNGtTUkRyK25iNmZ0aFNZWXNXZ0E5NU4rY2hKS25xNE1B?=
 =?utf-8?B?bGdhNm5CUThuNzZIRkx2ZVNWbkUwaCtGeVZkcXc0YWl5bzZqOUNkWVc3VTA0?=
 =?utf-8?B?MktSNjkvZWlhUStOdmdwZGF2dUFxOVNLTU5wUzNKaE5XQm1zemtZb3FCZjEv?=
 =?utf-8?B?K1RoanEwYlNOSmlld2ZINU8zcU95dENtVXlBR0ViMmo4SnFtTXVzOVV3NEFa?=
 =?utf-8?B?bmc2WTRuMGdYc0xlTElGSVE1OWlkSXJMa2d0SmNmOFdCL1k5WG5yWGt6SCtK?=
 =?utf-8?B?TkRvc0hXcExlR0xTdzVCbDl5SnNoYUhIYXh1SS9GKzBQdzV1L3YzUmJCTkVF?=
 =?utf-8?B?K0NWUGE3NGNNZTAzUEt2ZjV3Mi9KYy8yN2QwNkM3aTJURnBwWjliT2U5czB2?=
 =?utf-8?B?SG45YTk0WnU0enhrV1NLSFJsR0pJbWN0V2NYYnFab08vY3hvMml5WlZRYXlZ?=
 =?utf-8?B?VjNacFZveVJkRC9WczJMYWpCYng5ZEdvZ0YzTGFiOWtEcWtLNkZKOXpoUmhT?=
 =?utf-8?B?cnowbUNlaHVQaWwzc3g0SnN5RHZVdWxqZ3dqV1RaUFNKdXlxZ0NpQzFvMU1P?=
 =?utf-8?B?MGxheGltSXdXQTZrQlh3Vjdhd1VTTFEzdkxqc3hxUjZzbnh0OTZmQi9rZTJS?=
 =?utf-8?Q?E1uSjmV5N1F2i1R8pR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5893.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b87960-4dae-48b3-6057-08dedcec5b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 12:28:03.4609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3jGPRLCKKDlLZdE9KebF7DT9W07Bq98vn1oCJWJj1nYlzmFux7mVtLFR04ZZJgKLkkTqBFczpBjNwdS2jZ2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

SGksDQoNCk91ciBpbnRlcm5hbCBwZXJmb3JtYW5jZSB0ZXN0aW5nIGFyZSBzaG93aW5nIGRlZ3Jh
ZGF0aW9uIHN0YXJ0aW5nIGZyb20gdGhpcyBjb21taXQuDQpUaGUgZGVncmFkYXRpb24gaXMgYWJv
dXQgMS44JSAtIDIlIG9uIHNtYWxsIG1zZyBzemllcy4NCg0KQlJzLA0KV2lzYW0gSmFkZG8NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxMCwgMjAyNiAyOjA3
IFBNDQo+IFRvOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiBD
YzogZGV2QGRwZGsub3JnOyBBbmRyZXcgUnliY2hlbmtvIDxhbmRyZXcucnliY2hlbmtvQG9rdGV0
bGFicy5ydT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OF0gbWVtcG9vbDogaW1wcm92ZSBjYWNo
ZSBiZWhhdmlvdXIgYW5kIHBlcmZvcm1hbmNlDQo+IA0KPiAwNC8wNi8yMDI2IDEzOjQ4LCBNb3J0
ZW4gQnLDuHJ1cDoNCj4gPiBUaGlzIHBhdGNoIHJlZmFjdG9ycyB0aGUgbWVtcG9vbCBjYWNoZSB0
byBlbGltaW5hdGUgc29tZSB1bmV4cGVjdGVkDQo+ID4gYmVoYXZpb3VyIGFuZCByZWR1Y2UgdGhl
IG1lbXBvb2wgY2FjaGUgbWlzcyByYXRlLg0KPiANCj4gQXBwbGllZCwgdGhhbmtzLg0KPiANCj4g
DQoNCg==
