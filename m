Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D849606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SiGv9UfN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96DFB40299;
	Fri, 23 Oct 2026 09:53:53 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by mails.dpdk.org (Postfix) with ESMTP id BE47140268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:53:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aza7y1dySHdlRt5CNKWN0iAiyGDm9sul/czknoBxlOst9lbI0YmAI99toOXb6Yi2b6vtey6IxJ10aUDG4BFXrmm0Rhdn9W07NtV96aqlS1niWfPIppiJhFiXPXT5XW5GatJLkprrCPMHsNw8WxvSHdkKkNWASiTyhGNHiWw4befLDUIsybkzoMAtk5ob6PBygWcAy+lSHZZJiSorE/EvwGqQqlUmsOninAxo9/7jDGSeJDXm3yEVswnpPH4U55ESMl+YcT8VtaQCpiSBNgkrxCIx9M+sf/p1pDcNXsQC5R8JrBesn38C+5j2hHApLlZiVoTS7ld1wx9nWkKHmEqecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjLLhjpLlnEnCkrNx3D/TXIfVQt8Nv0ArJtCsVaE36k=;
 b=XB52qRepxjwpOnqO/QdEu0PynWVUH4rY8SnyaNmo/UtS0qObSpFIv0kQ1CxTBWlR4AK0/9xefeGHpll/ivuCwGmEy8o7TG8nag8VLx78Dx5bT+cBz8QviAWQ7rUu7Ez2uryM+c8yt3uNHSh8pFIlRGvtEdzdnmlwOKPfcV4K7WD4sAGDmFEMlGbmNBjV7lVBh7koePAB2o8cJkdqywQKlq+1uof7SI5emVlv0KUXZ8a4eqoeqNlKbLhV8vl2f6YtwqS5vuYwnwPHTTM/YciS7+2C90tqYfW453xp7gRs3C4Mz2QKOGDQCOnqwol1pbDgG1abevDECpAp1cFwJTXzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjLLhjpLlnEnCkrNx3D/TXIfVQt8Nv0ArJtCsVaE36k=;
 b=SiGv9UfNfgWi2Ij20UU9QpwcE+rIzqmTAliEKqHMeNdojv1X8Da6ohJSbb+mfSqt7i2T/LZHnJrEfzqP+wVJNDViaVVqNKBrix3RsK27ni/8S6poa5RHThnYRVhjImBn87c/w+tiHvafrbtRJ+y3WROsKRs92MMAaBTpGZVHC+zppOTxizdhkAYr6y1j5CZGW1X5rLDMN6E2pI21krABt5bnhvtSuJaQNEF3NYCNme9Y73x9h6KQdlrSqzjuo28NFd2hd6kMvWnVWpwuN2WX+m/dlTBAAzz7xtayA/K4/WpT6kcc54Z/hLHJlafrPVIRc0h2BLTqDQuPdZap97q8NA==
Received: from PH0SPRMB0062.namprd12.prod.outlook.com (2603:10b6:510:21c::9)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 23 Oct
 2026 07:53:47 +0000
Received: from PH0SPRMB0062.namprd12.prod.outlook.com
 ([fe80::978a:392b:3403:8690]) by PH0SPRMB0062.namprd12.prod.outlook.com
 ([fe80::978a:392b:3403:8690%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 07:53:40 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] doc: remove cache flush threshold deprecation notice
Thread-Topic: [PATCH] doc: remove cache flush threshold deprecation notice
Thread-Index: AQHdYkVbSS8aIpcNsUarxt6SOoldSLcJ0iEAgADwZjA=
Date: Fri, 23 Oct 2026 07:53:40 +0000
Message-ID: <PH0SPRMB0062B876A2FB0763A41CA036A4642@PH0SPRMB0062.namprd12.prod.outlook.com>
References: <20261022164844.34845-1-dsosnowski@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65AD8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65AD8@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0SPRMB0062:EE_|CY8PR12MB7196:EE_
x-ms-office365-filtering-correlation-id: c6a49949-5516-4055-7578-08df30dac0bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|261021123027099003|261022105027099003|4143699003|261022075727099003|56012099006|261009223027099003|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: Fkv1gGMyH3PqkN3MkuU+PNBry8r9LMChmi6NO3RvYAJtVgVctoyk4t22FFTtApxSgjic7iBkyAGoxb1LwSVljRgwcO1qYMox+hptKPEU5UVoURX33XkOnuXIyQMMIQWUiSHMYM7jT91AJl4JYQmJQhv4HOpEWa7LoG9fahsaN0BSL3T4eLGnJCzswFI15ArcbAyuhCFwvsHZA12lA+IUYqcuCdGxhj7VU2DZYRRt+Rs2s8BDadTnOWGo/9njy0zHRXbBr0SngC3Q88MbTrFepcv+n/Rww+NjNLLRI7uNZQ4P3xgLLGDIcVVwlF1KLCENb1BWO9cRRo8tbib4+h9urmp9N5t4T+vOQ1Dy8L1Z9Hsa/prF3Za0KPrgug2I+ZtFQueb0hg+RvU1TmBYvqjUMkIYJyuKw/U8WION7B3WZUsjaA0hZv9MjScYduJ4xjeGM60JsF7uJ7EVj1VzHSO2dbc615xP3bE98p+Y/hbKR4BTMIp5Ju1okX9RhpWqhJ3aClPIIUeGT4pkyIwQqq/gNavMaF+97pCWP65cVG7N+T5kMr9MJNBgAWcmpNuCSzHiPxK1C9aPcvYe2+/OAZDz0vpxJNW/8KI1SXsJ+zVgrdRPNd+HukJfcAJnCgmRYp4IyoCHATP5HHGgyxVzhi6yQ3r+TgalXsWH+i3CbXsi2vfHH1ZAy6ztEmEOHVzL9qR01VN4wMcbJOgujEiuax5bGAThwirTdo4DWB+FYw0WqUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0SPRMB0062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(261021123027099003)(261022105027099003)(4143699003)(261022075727099003)(56012099006)(261009223027099003)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHN4NWNacm5jNXFYTXN4RktudW5MQStNQ2lHMHZUT0U1bU0yb1dWNEtVTDlE?=
 =?utf-8?B?SG1kZnUralYrWlpiWEpHS0J4UFFmdjVpS3k1RlVSZzd3QVp4bFl5anllcmRj?=
 =?utf-8?B?Z1pNOXNGNlJaN2trNEZGSWhFRVJLWTBKMXVZQ0FsUHhuZERFZVE5cHJrdjNM?=
 =?utf-8?B?L25uUURHTE1TbWloMHk5RjlnZGt4VTRRdXdEaU04OTdnU2krUFlxWElrMEFK?=
 =?utf-8?B?UmlJc2hhaGlwanFOamx3STc3dUZ1VktoVkt0cWZiMmlpeFhObm5FWC9MYzBS?=
 =?utf-8?B?azloaDlGUTVwQzFQSS9HanVmckxpZFo5SFhBV2VCVHdWSlRoanV6dUtiRDNP?=
 =?utf-8?B?QnJJb21MdzVlZ1RnR25SK3VFTW5Pb1RiQ1E5NzRLQWtiMldzWHFPa3JwTjc4?=
 =?utf-8?B?UFdxMXJzMWRYbEEybVlsaGs3dmwwaENvdDJWb2dBRG55dGxFUk1PQ2dGbDZP?=
 =?utf-8?B?cHUzZnQ1Ri9IZWxzdUozbHUyZFBPMU5HeDQvYThsQXZLanRYMHNGTnYzMVdI?=
 =?utf-8?B?T3JVa3dPRHpsNjNyWlVaeVpPWnkwTi9HT0o2TjgwVjA4T3pwVWpoaUxTZU1N?=
 =?utf-8?B?b2xJamtsSHgxek41T1I2dWtDNHJRMUsrM0REUThaOGsyVzlESTFEdEVYU0pG?=
 =?utf-8?B?OFNnV3hyRkF2RnFES3dtdzdGc0tpeGVRc1FzbkdtcG45MzdMK2tIWnllNjJM?=
 =?utf-8?B?a2RXWFFwdGg4Ump3Tjkrc1hzSjYrMjBOMCsrcjBIRSsvRXBsTldNc2srVTMw?=
 =?utf-8?B?U0FIRklvcmFQYk1oRWJ2MTEzWXBrbXlGMHBSTHp1Ymk1TkhXUzNaZnNvdlpk?=
 =?utf-8?B?ZVBkMzdjcVNmTlpaaDV4VldLU0p4eUdBUGJCQStGL3h1REtMNFZUK0UvcXpM?=
 =?utf-8?B?bXVVQ3BKNHdpT0ZZdTFhL1VDcDJYc3VUVXRmcVg1T2oxdEo4NVgzV25WWTdI?=
 =?utf-8?B?em1hZURia1QrUmVFalJnZGFUSkdnSnQ1M0tXUzVYblpKUEdTYU5jWmQzNlcv?=
 =?utf-8?B?NDh4endFcDNvY0lQaFhTRFlTYS90UHplaG9INExYNnBjTnRySEZaUGl4RW01?=
 =?utf-8?B?L0ZmNGJNSkNSSmNXUXlnc3RhbHAvQUhwN3RKMnJvQ3JvdVdRelJzMTRPMXB3?=
 =?utf-8?B?WHVLUVlPYi9VelBxUTM0bGJSQmlncXQxdFpmakNIWTlGQXpLYmhtVGlwd2R3?=
 =?utf-8?B?VTJldzNDcW9PM1p6TGhQR3k3cjlHOExUQ1BwNlU1eS83WUp5VHlkNlhlNUt0?=
 =?utf-8?B?UU5YNWpOUm5HOVR3YW9xT0lZVUlwVVdtOWVhemxDdGRWRGFIZ1V0UjdjSlZX?=
 =?utf-8?B?YTBxMGxaL0J1dS9pUFhHZGhPcms1S1YrQ3haWnlVaDRxZ3I2a1ZvV0cwYnFk?=
 =?utf-8?B?eEQ1UXNzbTJXYUpEWnMzTzE1dFlUb1Y1bHllQzlKTTltSmhQdTMzRlI1eU45?=
 =?utf-8?B?MzBuYS9qR0R1ZmJBRk0zRnprUGhRVTEveUtCTEM3TTJoSG5QL25oc1BhWXVY?=
 =?utf-8?B?ZkVvMjBHNnNualY2SWRmdXVWb1RIQ0Q5bC9BeTZhTkVYeFc0TFYwNys0L3VR?=
 =?utf-8?B?S3llWDdhYngwenlKeGxPd2V3RzUvMThTL211d0hjMEt1blBRSjVySmEveTZv?=
 =?utf-8?B?djBBQVZQMVBLTGxwcEtHQ3dJemZvSXFBK0FaNjhZa3kxamIySkI4VzdNZXRT?=
 =?utf-8?B?ZGlEc0JqOE5mdWRZRkplZVJFMW8vTWFEWGVwN0pGWmRRekhWZnVERjRrL3dL?=
 =?utf-8?B?c2k3NEwrczBhT3o0clNFTGdMZkEvTkdiMzVlRVF6VklEMm5wSVRCMWw0b0VW?=
 =?utf-8?B?ZWtkOWMvdVhKdWFndStoTjU1ZHpMU3VwbjFWbGRJNENEOTJnSnMrWmR0ZW1u?=
 =?utf-8?B?Vmt3SnJkMm5DenJIUmMwZnUvd3lIdmN1VkZqbU9QdDhubFcxeGxOaWttMWZ4?=
 =?utf-8?B?anJlTVRkRXd3emtXUnNnVlBQQlYwTUEzNVpxSmNLMm9idVNNZ2d6aHYrN3Yw?=
 =?utf-8?B?VWR1cWZkQnBaVDJuMEllZ1NNZ2tsUzQwZnFPMEk4Wmx3OVlFbFNsVlBCd3Ju?=
 =?utf-8?B?WVBZS3lQenByaS9CbloybTRXV3dEZ01Db1J5RzhIYmR4N2ttVktpS2RIdGll?=
 =?utf-8?B?QkNJVHpDcUVQYldYMUxIYzc5eGZYeTB3dnJWU1FyRFJHREZlUURFbnRGalMv?=
 =?utf-8?B?ZEg2bHJKOXlpRjlhYnJVQ1FldG1pRkRXMXVTUG00SmFHTTduZ3ZKalViYXMx?=
 =?utf-8?B?TUZMTDhKQWNmVUxKN1l3KzR0KzlXTDFmY25XM1g5M1BzaHF0amk1S3BaQ1pU?=
 =?utf-8?B?dTViOWZyTmF5TVlIWVdlR0NXM2l3MWRHOS9BeXdlVmRnZEVTalZLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0SPRMB0062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a49949-5516-4055-7578-08df30dac0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 07:53:40.4417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnpQg5X99WBYdysEm6kfh2OafsJlaiiQTZGcGXTZCvmrtYVOpAr/0liWkpkZraoHltGkYnvxDlSY6/roZY6aXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJyw7hydXAg
PG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjIs
IDIwMjYgNzozMyBQTQ0KPiBUbzogRGFyaXVzeiBTb3Nub3dza2kgPGRzb3Nub3dza2lAbnZpZGlh
LmNvbT47IEFuZHJldyBSeWJjaGVua28NCj4gPGFuZHJldy5yeWJjaGVua29Ab2t0ZXRsYWJzLnJ1
PjsgS29uc3RhbnRpbiBBbmFueWV2DQo+IDxrb25zdGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbT4N
Cj4gQ2M6IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkb2M6IHJlbW92ZSBj
YWNoZSBmbHVzaCB0aHJlc2hvbGQgZGVwcmVjYXRpb24gbm90aWNlDQo+IA0KPiA+IEZyb206IERh
cml1c3ogU29zbm93c2tpIFttYWlsdG86ZHNvc25vd3NraUBudmlkaWEuY29tXQ0KPiA+IFNlbnQ6
IFRodXJzZGF5LCAyMiBPY3RvYmVyIDIwMjYgMTguNDkNCj4gPg0KPiA+IFJlbW92ZSB0aGUgZGVw
cmVjYXRpb24gbm90aWNlIGZvciBmbHVzaHRocmVzaCBmaWVsZCBpbiBzdHJ1Y3QNCj4gPiBydGVf
bWVtcG9vbF9jYWNoZSwgd2hpY2ggd2FzIHJlbW92ZWQgaW4gdGhlIG9mZmVuZGluZyBjb21taXQu
DQo+ID4NCj4gPiBGaXhlczogN2RiZWM5ZTY5YzM2ICgibWVtcG9vbDogcmVtb3ZlIGRlcHJlY2F0
ZWQgY2FjaGUgZmx1c2gNCj4gPiB0aHJlc2hvbGQiKQ0KPiA+IENjOiBtYkBzbWFydHNoYXJlc3lz
dGVtcy5jb20NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhcml1c3ogU29zbm93c2tpIDxkc29z
bm93c2tpQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRvYy9ndWlkZXMvcmVsX25vdGVzL2Rl
cHJlY2F0aW9uLnJzdCB8IDMgLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RvYy9ndWlkZXMvcmVsX25vdGVzL2RlcHJlY2F0aW9u
LnJzdA0KPiA+IGIvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+ID4gaW5k
ZXggMjlmYjdkNTZkNi4uNDQ4MjZhMGNmMiAxMDA2NDQNCj4gPiAtLS0gYS9kb2MvZ3VpZGVzL3Jl
bF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCj4gPiArKysgYi9kb2MvZ3VpZGVzL3JlbF9ub3Rlcy9k
ZXByZWNhdGlvbi5yc3QNCj4gPiBAQCAtMjksOSArMjksNiBAQCBEZXByZWNhdGlvbiBOb3RpY2Vz
DQo+ID4gICAgVXNlIHRoZSBgYC1TIDxzZXJ2aWNlLWNvcmVsaXN0PmBgIHBhcmFtZXRlciBpbnN0
ZWFkDQo+ID4gICAgdG8gc3BlY2lmeSB0aGUgY29yZXMgdG8gYmUgdXNlZCBmb3IgYmFja2dyb3Vu
ZCBzZXJ2aWNlcyBpbiBEUERLLg0KPiA+DQo+ID4gLSogbWVtcG9vbDogVGhlIGBgZmx1c2h0aHJl
c2hgYCBmaWVsZCBpbiBgYHN0cnVjdCBydGVfbWVtcG9vbF9jYWNoZWBgDQo+ID4gaXMgb2Jzb2xl
dGUsDQo+ID4gLSAgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbiBEUERLIDI2LjExLg0KPiA+IC0NCj4g
PiAgKiBtZW1wb29sOiBUaGUgb2JqZWN0IGFycmF5IGluIGBgc3RydWN0IHJ0ZV9tZW1wb29sX2Nh
Y2hlYGAgaXMNCj4gPiBvdmVyc2l6ZSBieSBmYWN0b3IgdHdvLA0KPiA+ICAgIGFuZCB3aWxsIGJl
IHJlZHVjZWQgdG8gYGBSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRWBgIGluIERQREsNCj4gMjYu
MTEuDQo+IA0KPiBZb3UgY2FuIHJlbW92ZSB0aGlzIGJ1bGxldCB0b28uDQo+IFRoZSBvYmplY3Qg
YXJyYXkgaXMgbm93IHJpZ2h0c2l6ZWQsIGFuZCBub3QgZml4ZWQgc2l6ZS4NCj4gDQo+IEFja2Vk
LWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KDQpUaGFuayB5
b3UgZm9yIHJldmlld2luZy4gSSBzZW50IHRoZSB2Mi4NCmh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9y
Zy9wcm9qZWN0L2RwZGsvcGF0Y2gvMjAyNjEwMjMwNzUxMTQuMzU5OTEtMS1kc29zbm93c2tpQG52
aWRpYS5jb20vDQoNCg==
