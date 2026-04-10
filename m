Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E24F45A0D
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 21:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA0174026C;
	Fri, 10 Apr 2026 23:13:40 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020128.outbound.protection.outlook.com
 [52.101.193.128])
 by mails.dpdk.org (Postfix) with ESMTP id 07006400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 23:13:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g62LqZR1eNNw+UvuC+P80NHxSiKmDg/eaZ9QMvxb0QDbFhFkaDYxCA1GXDUVGQUU+VQxMbSkSwA6mmyvtlz+gxOBhpli6UzrO3LX5mEELOsYrULxfhc1E0xX4kbpx0kzFr30d24A0HGbr7clCpyaJA2HTVvrgcIO4o0OZ7Zkj9LleBc9MukKWTVZJctg8leyFxETkWNNoxy0SHbJTg04gZvc+wTnCxO8bYTdsMfiip9iVIQ2D4tqVoGPhtSgdTKyWbDWwRoXvV7Lx78vWsYnDDz8akW6/KdaF4eAjyrnjDBKaTcTUWTc1FgZta3aW0f66GOd0rg0rgTzxhuflCrwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xngXa+SOJQAiWAmMCi92WS6iS8CsLbd7n2BErAZIdtM=;
 b=BIiLN79u0waXIelEgNOOjg9xX+9oJE8SMjP+ndIXegM/TMTSEdvhYiP9B7P12ybY5dJ6aOiTVinONFVww6yFV87qW9wte4mLx1cYdaRAGu8/eLkM9XCrljj/u0wQv04lAFY7tjbzancxFgKXmxLIZeXBz2R8xcdUuj6tOvlEywP4gilTJU7U4DJxiITfiKgUHxrQgDv6DwCZeT6k5Q3/WeD4L6STxeVUmnY0gy8IDr+VOu+ntqxwij/GsD3X9iQfNdfwlYQ5NdUj3aFUYrcXbE6TPoMpgV9H/NbfrsF3qcUjo88M8yFrAkUpGD1nKTGPmXOzWZQVIsdwDm2p9cnuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xngXa+SOJQAiWAmMCi92WS6iS8CsLbd7n2BErAZIdtM=;
 b=WlQeR1tlptpqrNBPH+mTzXaTNpIm88PKlJFlK7QrYeFFK81ZzgIamGKtVgpVTrg8OmOP078S+9JBtmvZHR6LkQ0V+r2s2N5LET/O1/M+sr0V3MwkLO43zr8Kl1zQZhQKq2ltViruZCloyyG66kaF2KAYNCV9orVVy8QX7IOxWus=
Received: from LV0PR21MB6670.namprd21.prod.outlook.com (2603:10b6:408:337::12)
 by LV2PR21MB6785.namprd21.prod.outlook.com (2603:10b6:408:34e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.9; Fri, 10 Apr
 2026 21:13:36 +0000
Received: from LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96]) by LV0PR21MB6670.namprd21.prod.outlook.com
 ([fe80::c354:baab:cb7e:3c96%6]) with mapi id 15.20.9818.006; Fri, 10 Apr 2026
 21:13:36 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, Kevin Traynor
 <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "matan@nvidia.com"
 <matan@nvidia.com>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 0/7] Rework device probing
Thread-Topic: [EXTERNAL] Re: [PATCH v3 0/7] Rework device probing
Thread-Index: AQHcyPc50Ql2KKjC90G84r6D56BGo7XYj2uAgAAT8cA=
Date: Fri, 10 Apr 2026 21:13:36 +0000
Message-ID: <LV0PR21MB6670C8CFBCD121494E58FEE2CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
 <20260410103717.5a52289a@phoenix.local>
In-Reply-To: <20260410103717.5a52289a@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fde8935c-3e0b-46a5-b70d-d698ca525cfd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-10T18:48:39Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6670:EE_|LV2PR21MB6785:EE_
x-ms-office365-filtering-correlation-id: 5abda28e-f8f6-49ae-8bb9-08de974607c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Hb1toAbc7HPe8mf3kUb7AH7aCobnDSZHcHtCF2xklPaPSxAnZg/0ipDM5Os800yI3hpk4b5VWfexdlLnU1AsoCqa7Ew6rUHg6zRz1BIP2/4Q8iECOQF2B2tP6E4oJLQlxhkJ84TpB8oaOhnl1dOopj2BnhICu6zt939VI+elF3fpof7yV8ZwNoir4EGH8cQ5Dm9mRe/DDN2SPRhmIDY2cNN84kP+3obH52Xb+VTAOV3JQ3e1Sc7IfXQfq02TnPTyK9BHcyLJ/VtEnCcn0GM3nA6F/WdRmpaqItbS/fIBQH0pau2M/oOA2Yo0tVZfvZNY4P0ynYNi2r3Pf/HS9TtILy8Xpg/6JYaW2wFE2DmTFyRMFRiSgLlYOxvvVLI0G0ZdSASjokjiH+Csd4pSxf5OrLAqhjY/1cH72aWh0SrlphM0VdcOGWJ7o4WnTjVrhSh4rT3ovJ5FpqJnRj7Dg72+jd04a36ypvV9o+NO/D0jyJGwsQPuHYuuLbi7aWDf3kAyWfXMoWZl7pauYcBROwl1mOlQpR9+JcedfACYaRsrPbh+kL9oPzlC0qObZsXKR298g5ARAL1m3oi97zasH10o1f6aO/FBUvPxwz4afMwbZITEDcVT8eWiFMXFIsCyF/zFxRNvnOPONykkrCXLOsbyZSHwuQDvmpppH3RncbN3xh60DQ4cN0yElBLdgoGzml5RfnCR+HZN0ZHa2dhRnx4QkhjTf/TwE8xFomapKqwxld0mzSMCLXLnRbdpSeOgIVgVnVF42mfPekCy3mcLB22LQkQbHkSc0tWuRFcEiJ/x7rM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR21MB6670.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVXNkVDZGpTTGFiRys2YUpLSkdGR2I5b0pmSURMQXk3ZFBYU0RYMU5NUk1l?=
 =?utf-8?B?R3JES1A5RzQ4R2Vmdno2WkljMCtkSElESU9GS1R5U2t4elp1cmNWeXFkeUpm?=
 =?utf-8?B?YTRFRDRsdm93Qm9aTHVhOU4xbGVYK0RidkptSkJsclB4QTNqMlMrODdOdmhU?=
 =?utf-8?B?dnNTZHUyQjdOY2gwTHdBZFRmUHlqbjRYejhmNmIyMHlIRlBoMjRqdGdjRmFM?=
 =?utf-8?B?UjQ5TmVFS0lENnptMFRqWHJqcDNtelhrZ0NPRTdTNFovelE4NVRxbVQzTW9F?=
 =?utf-8?B?WDhsV29YaERaVkl6dFl0RVoxelhmcHY3cXIvUlZoSTBOVzZUa1hOUzlFWWFS?=
 =?utf-8?B?cVdNL1hXekg5VmtxMVU0dzdYYWRDR0xTMjRLb0dOeTdDVG90SUJOMHdiZFpD?=
 =?utf-8?B?bXJVQlBjYnFIVUpIbWZBbnBEQ2NLUHV4R0JiMzFFNUhMMkpIMFlTSDlHU2ty?=
 =?utf-8?B?RVovNHdaRnV4aHYycExBQVZEZHpnYUhQRStsbFBoejdYam5MNThqbGdLZnht?=
 =?utf-8?B?cVRXdHZoaEVIOHpSYkQ4ZmQvbGVYNDZwMnVpMFpIZTgyelV3YWxld0NNbkV6?=
 =?utf-8?B?MHhEb0dURGJFL3h5K1UwbldWaVJvQXRXMms5eFlyTmw4ZTVTOVRmTlhzZ3RC?=
 =?utf-8?B?MWVVTndHTE12bGp0RzJTSkp6bDM5eHNlMTc0K2V5MDgrUEpJSDVidlhkWXpG?=
 =?utf-8?B?dkJUTjFLV0R3UWRjUmF5U0tFbzRLb2E0bEZoakNsZGRHM09JTmt1eEtnM2lw?=
 =?utf-8?B?RE5DTHllaXI1SHpDcmhyalJjaWFkekkwbnY0bnZMeUtoZTdZRERYdFB1NG42?=
 =?utf-8?B?N1Jpc0t4WFlWVFVydWF3L2lwNzA3RFN4Z3NHbjA3MytjMFpXRDB5OUZvVmlQ?=
 =?utf-8?B?V3gzNEpPSHNKSStWSkVFQjBvbEttc3JtSjk0bzJoV0lnQmZHTmxTc29mdVBN?=
 =?utf-8?B?eDg0UlR3V3IxVFNLSkVyTWNQZEIxaCtpaUZRWnBRR1Q5VzRITHlHS3FKN1J0?=
 =?utf-8?B?ZW9QZU1EbCtXaTFianVUZDNMeVd6MmoxSDlKL3FZOVNRK25kaVdtTjB2TmFC?=
 =?utf-8?B?REp6Mi81MWdnZDlCRmY5RUVSVkUxTUNISXEzRjExWVNJSDNDWHF4eG52bzdH?=
 =?utf-8?B?dTlwMkNPd3hLVVQ5S21laFJaWnpGWUlsT2czcnA4WENLUENPY3ZkVHB5Zi9C?=
 =?utf-8?B?UFlSWUR3dWlMSktjRFVSTVdQTWFxcG1STzdzL2pYaVhNR25Ic1dtdVJ5SWE1?=
 =?utf-8?B?RnpVWFZXS3Q2OFVmbDBuWnMrUWlQZTFIaFZ6eTF1UzA3OTBrWW9GeldoeHNw?=
 =?utf-8?B?T2laNTNuUHptM2dxTzlQbXlXUVYzMW1HQW9CZzc3L2JzSzJoZ1pYVzdiSGRy?=
 =?utf-8?B?c2dwd0FlaG84cUVpTksrOXFTelpCTDMvOU5jSENSTjBlTnZFTm1sNFRVK2Fp?=
 =?utf-8?B?dXVDSlpIbEpwMmtTd0xrUlJUek0vMzBvUFJTb1EwNm5xKzExdFFXWWpwY1lZ?=
 =?utf-8?B?dVpXUFFLZEtDNzNESGhtSWZ1cU5iZVJKc3pEeTAvdkMzR1BwRWQrdThuWUdX?=
 =?utf-8?B?c3NUVDJKaURDSHJSajd0TTZFNCtnUVMxSE5jeDg4Ykl4aGhqQzJoV2VUam1S?=
 =?utf-8?B?RVVwZjI4ckdjdFJlRGRCb3AwMXpnTEtYSDk3SEtBeGlsbXVwVXZsT3d0bjc1?=
 =?utf-8?B?WHpzMVZrVnJZdnI5TzJteXA2TEV6SUloYkV5bEZwR0Y0akRTa1NWdmhCRk11?=
 =?utf-8?B?KzRBbmI2SGpBcFRtTU5IdjRnQVhFQVU2Uk5rQmhEeWtaVFo1dmJQRFAwK002?=
 =?utf-8?B?YVRzOWJ6OFovNUI4QkRWVDVqeTRFaG02Y3p6dGcza3R4L1JieHh4Smd0cWE0?=
 =?utf-8?B?UStYYjMvVVVlTm4yenFRUmFBRDVDKzlkZTRZSW5yK2MxTjVQNHgxUC9wa25x?=
 =?utf-8?B?WEY1NTZwVTVhYlVNM3RQZC9ZL2RMYmg4QXpvVWhvYkZWcU5PMjNObnBQMitO?=
 =?utf-8?B?dldFZUNSeWNuZ3Y5Z1hpZHRUaXU0TXpBeDlwYlp5Tk83YWZUbUVmazdrem9l?=
 =?utf-8?B?cHllK2kyQWhhODF0dm9xVVZBMVo1NVlBSGl4SVZnUG5NMWZrelNEL2pvL0Rt?=
 =?utf-8?B?dVc4cVViN3dCZ2JZSmZ6Z3hPdGd1WlVrQ3B3V25HREQvWHBEWDhOd2IzTGl0?=
 =?utf-8?B?RGVLd01uakVGaG5yMVRiSnR6VG4xM1NYYVdBZUsxWnZ2dHVtaUxyV1A5UEJ6?=
 =?utf-8?B?MTY0eXdZWlJBR1ZuaENyaURySVhWVDlKWXJiNnVzTElCT1VxUStKRHVUd2xz?=
 =?utf-8?Q?QdKAykYDYSxIlhl5NR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6670.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abda28e-f8f6-49ae-8bb9-08de974607c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 21:13:36.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KbjFD3Bnnf51f5DpvpLCccQhtUuOrXwlrMRK6D1KGW8PXXfblaXGV7HI0im5nlIyhDoTD0ypSiPytN+F1FANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB6785
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

PiBPbiBGcmksIDEwIEFwciAyMDI2IDE2OjM0OjU2ICswMjAwDQo+IE1vcnRlbiBCcsO4cnVwIDxt
YkBzbWFydHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiBJcyB0aGVyZSBhIHdvcmth
cm91bmQgdW50aWwgdGhpcyBwYXRjaCBpcyBhZGRlZCwgaWYgSSBkb24ndCB3YW50IHJ0ZV9lYWxf
aW5pdCgpIHRvDQo+IHByb2JlIGFueSBkZXZpY2VzLCBidXQgSSB3YW50IG15IGFwcGxpY2F0aW9u
IHRvIHByb2JlIGRldmljZXMgbGF0ZXIgYnkgY2FsbGluZw0KPiBydGVfYnVzX3NjYW4oKSBmb2xs
b3dlZCBieSBydGVfYnVzX3Byb2JlKCk/DQo+ID4NCj4gPiBJdCdzIG5vdCBzb21ldGhpbmcgd2Ug
cmVhbGx5IG5lZWQsIHNvIGlmIHlvdSBkb24ndCBrbm93IGl0IG9mZiB0aGUgdG9wIG9mIHlvdXIN
Cj4gaGVhZCwgZG9uJ3Qgc3BlbmQgdGltZSB0cnlpbmcgdG8gZmlndXJlIGl0IG91dC4NCj4gPg0K
PiA+DQo+ID4gVmVubGlnIGhpbHNlbiAvIEtpbmQgcmVnYXJkcywNCj4gPiAtTW9ydGVuIEJyw7hy
dXANCj4gDQo+IFdlIGRvIG5lZWQgaXQgYmVjYXVzZSBvZiB0aGUgcHJvYmxlbXMgd2l0aCB2ZGV2
X25ldHZzYy4NCj4gVGhlIGlzc3VlIGlzIHRoYXQgdmRldl9uZXR2c2MgdHJpZXMgdG8gc2V0dXAg
ZmFpbHNhZmUgb24gYWxsIG5ldHZzYyBkZXZpY2VzIGl0IHNlZXMsDQo+IGFuZCBpdCBkZXRlcm1p
bmVzIHdoaWNoIG9uZXMgYXJlIHVzZWQgYnkgT1MgYmFzZWQgb24gc29tZXdoYXQgZnJhZ2lsZSBP
Uw0KPiBwcm9iZXMgd2l0aCBuZXRsaW5rLg0KPiANCj4gSSB3b3VsZCByZWNvbW1lbmQgZ2V0dGlu
ZyByaWQgb2YgdmRldl9uZXR2c2MsIG9yIG1ha2UgdGhlIHRoZSBhdXRvIHNjYW5uaW5nDQo+IHRo
ZXJlIHNvbWV0aGluZyB0aGF0IGhhcyB0byBiZSBmb3JjZWQgYnkgZGV2YXJncy4NCj4gQnV0IHRo
YXQgcmVhbGx5IGlzIHVwIHRvIHRoZSBuZXR2c2MgbWFpbnRhaW5lcnMuDQoNCkhpIE1vcnRlbiwN
Cg0KQ2FuIHlvdSB1c2UgLS12ZGV2PW5ldF92ZGV2X25ldHZzYyxpZ25vcmU9MT8gVGhlIGlnbm9y
ZSBkZXZhcmcgaXMgYWxyZWFkeSBzdXBwb3J0ZWQgYnkgdGhlIHZkZXZfbmV0dnNjIFBNRCDigJQg
d2hlbiBzZXQsIHRoZSBwcm9iZSBmdW5jdGlvbiBza2lwcyBhbGwgbmV0dnNjIGludGVyZmFjZSBk
aXNjb3ZlcnkgYW5kIHJldHVybnMgZWFybHkuDQoNCkxvbmcNCg==
