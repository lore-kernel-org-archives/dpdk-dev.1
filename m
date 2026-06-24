Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F48CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 00:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37855402A2;
	Wed, 24 Jun 2026 02:07:04 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
 by mails.dpdk.org (Postfix) with ESMTP id A78F240299
 for <dev@dpdk.org>; Wed, 24 Jun 2026 02:07:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcIOh+tnxrnZx221WPClW9TxyxLnjtMSEO1wBC5mf/SFm51fJnFn1JqBrp7/zxGZYhBzrJYJ7S68sMkV3WWW4vapvldiLS6zoZYjy7wRlMplOz8vFs0iMTkNO4NJKx6yGU+HEZmljfG+Na8SVJsTrQiyJqziXkRY/8oChEQMZzoQ4R2Bz/oxIA39LU5/7PjFdCBPtf3hF1SEPlFqsZinR6VNPz+1K5x+TyURJMQ5RTuP9ig5vL1GYs1Dz30g1QG0Dvyyk8V788DEfc0kqehQxh0QMvhx0SKGNN9N1IUNHgd37OKnQXKmWD+rdYSi+LhGe9a9oncjOs+AngFJ2AiVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w9Qx9ffSC4JY/qWHRitMFzuyxfMEi5BkrC2KYQN+Lc=;
 b=GBRdPkrWyjmwGB6fgJAktFKat0azTLWxTLQ8HzK0/HwFX0p+AhsloFKTISeZMkMR8pEm55+ryBCU8OxQ7ygrNlkXqQ6vzqSu2z8/Cw3COKGiwInfmKZNyyiQmp1DVO2Ax9kJsAuo4d0cE4A9R8ky0GcCBywch4H0rGnZ362OyhlsLA0qKlOHdOxE4t8OEJ30cWPJRLyIe5AIQqqmEkTDfgHzLbG9SeWVM56uBba69cVLGwTSZWq+CnithHRwmZ3SPsfex+QrnGSlBsUIBqCAaOEX0lc1w6y29QlhvqM507/R4RGBaLe3DhwXKHOCGRuwvBrATBMFe9ark0hYeeiTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w9Qx9ffSC4JY/qWHRitMFzuyxfMEi5BkrC2KYQN+Lc=;
 b=VKcS12ldQEcm/xOZqXK2LUE41GxHh2t7wt3Jf709R18q0JeR/eVkJPdKwF6rMeXqV01iASlW7gAJsYawGdtcBT57Mtg8v/h6UCvTHWExd1NN7i8+LFv5wlHioIuLzXIKnTyWS/LVZ8SZ8Gz7RXwf1dyF3mH/EZr7VIcShgmp7vA=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA0PR21MB2011.namprd21.prod.outlook.com (2603:10b6:806:132::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.4; Wed, 24 Jun
 2026 00:06:59 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 00:06:59 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] eal: return error on devargs
 truncation in hotplug MP messages
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] eal: return error on devargs
 truncation in hotplug MP messages
Thread-Index: AQHcu/kG5IsGFjwmgEy6MCElXLA67LY2bUwAgBb1ZiA=
Date: Wed, 24 Jun 2026 00:06:59 +0000
Message-ID: <SA1PR21MB66835979985DEB60A2DFE4AACEED2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260325014506.1866374-1-longli@microsoft.com>
 <CAJFAV8ye5NG=-xkXjNX5+jBpJgV1S5oe02_+rAa9BYwNv_wmAA@mail.gmail.com>
In-Reply-To: <CAJFAV8ye5NG=-xkXjNX5+jBpJgV1S5oe02_+rAa9BYwNv_wmAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37ee7b3b-2947-4571-a700-0739413f54ce;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-24T00:06:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA0PR21MB2011:EE_
x-ms-office365-filtering-correlation-id: af89d5a9-3258-4750-705e-08ded18482a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003|38070700021;
x-microsoft-antispam-message-info: nyxCWoZoVScmoN7IO1Eu7DNiBr4u5P6+jN72W9vb05Wu1yfLkZkpwQd3U81N1QMhgt9bUb6SvgNjcyGdHSF07fDga/JVQwABcYJkqBo7Z3whuz9Vu8sbmxX9KGHGCwrghkDsloPe55L8ErNdOARCKJPsQ7ukadXwMuelaR4jshzR6IFnI3eSr8AYlrkhW12tkloMDHaFBLVB/k3LLRQIc6I6CO3wPOUclAnNcCSMQyfxR2tcDJir2yXQpy4xKngHGjZvP9JzNcUdDVpoFV2dxWvUq7GVK9r39RduYi5uLpVSr1pEmWL5+NAcYOGtqR6F1o5w1p1WSf0maT16VcN/BRoqLopsk/otjfiFJWVrztV8H6IQnUhUqjW3g6OIbkU1XP0EZDyEsBlhtdGT0mCznvpKDZipfbu6WeYWm8hQm8EjkY+yOQkOw54PGTmKB6JvoYBCEs6G5UdjVV/nCdPa2tinmtZ8WKMqAJKzr52CaqM8ThZfUz0BWX8OC1ypR1n1F1GOGc9NgK+JAq2EVB3e4PVgLH31bZV/+7cj9T8nsYOoZ2miZGzgR8FWmHqbCUYjUnxj0c+AxsfcASpGtd9EC+avAIBjOrPaiwr6CabRKYMBjcFbWzsaZyNjt5YwYCe0Ark6W2tSEunnWwnwKEVT1OmqhXzuHH6KfP5tiPWL11Y4zSCYwcEO/alQyqfBQvodz1VsfoiiUEpIvDyMVmSxkXdFTR7KCv4UE+7u+eFgsdY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHdPaEY1YWhZUm0wZ3RqTEtmWnVEUWF3ci9Ob2d4elNSSFpxNEpqdjVvUU1W?=
 =?utf-8?B?ZHB2VWFUWjViYW52Y2R6WkxFVnl5OVhzM2E4dEh4aDVzSHZrMUFKelNPYnJR?=
 =?utf-8?B?ZDJPY1NJWVRIdzZlZ2tFY1FlS2hxRUZhQlE3T1EybDFOS3QyR0o4c05EQ2xu?=
 =?utf-8?B?RmRpR0VURk9WZjI3VlM0VkFvT05yTEJkRzlBeFV6dWQ0YWx2M0Q2ZGlTYmo0?=
 =?utf-8?B?VHg3cnpYRzZiZDUzaFh2L0sza0VXRmlEQzBUVmlSTzFjUjVIaGxqU3V1REIr?=
 =?utf-8?B?YjQya1IrK1JJTnFqWjh5YklpSStxaG9rbzRPT0wxK243cUFEOVBXNndQNmkx?=
 =?utf-8?B?am1YLzFaemJjcHdoSkVZR08zajJES2hhcVYvRFkrZnlSa2NEbEZpdEkvMWQ1?=
 =?utf-8?B?Rzh4bkZ3cnBJdkJsNlBGazFMRUp2YXYwQ1dwMUpIZ0t4YU9Jbm1aaTlWQ0Ji?=
 =?utf-8?B?ejlTR0FYbERqdjR3QnZlMy9JWG1uMUc5clRPUTcrYlhEWGI0QnhwZlFrcngz?=
 =?utf-8?B?bzVrYnlsMU1wdnpyeVV2alB3YWszVDRoUy9iS2ZEdlNjRXlWR1llWHV6QllB?=
 =?utf-8?B?Z0pzYWlTckgwTGZyUncwT3lIcWRHRzFROTNnbWJ1QVJHRzdPUUlCMk1OSW56?=
 =?utf-8?B?L1lXdUxoNWZYNVd2QjVWdUxQT1pjL1lLdFlESnRMc2VHVGY0akdCV1NtaDZo?=
 =?utf-8?B?UFZPenJaMlJiQWNtNlJTYjdRWGpVL0o2RGVqZzlNQjdaQnhPbE5iSmp0MW9v?=
 =?utf-8?B?MEU1VW0rYVJMNkVsMldpTlRSS2VwRm56c2cwc3hTTWJiM0JIUFFGamRIYWtY?=
 =?utf-8?B?UnN6VW5yQkJwT25CODF0d2NCamlTd0VibUNvd2dLK3pSd3hvRExHckVkbEpM?=
 =?utf-8?B?S0I5MkhrYWc4SFpReVlyWUNDYm5NSWQ0YlptODNEWnBkOEFQM1Q5NjYzZnh5?=
 =?utf-8?B?SmN3c3RKRVRLVUtGN05wMHM3NXh0emFHNkQ2RzdQcWRSMnNZb1NKZGNEVStX?=
 =?utf-8?B?M2RQcjNpUk10MkJ6Nzd2ZWhmZEdENUVTcmhvbW9iWlM1aHhCcFhoOXd3MWZz?=
 =?utf-8?B?cEVGa3pibVQ4NklqUE9taXg3V1M1NENMc0RUaGJkSklyNnBKTnFJTzU5QU5v?=
 =?utf-8?B?ck1mSGdIZUNZQ2U0eUpIUTFkVXZoNFhxb2l1RUtDcmpkWnpnRktPL2YzKzQy?=
 =?utf-8?B?L2lyYVF1anJMOUJvdVpWM1ZhTjRMT21hdndtVXkzVUl3c1pFeTA1bWV4OWxY?=
 =?utf-8?B?Ny9KTnp3RHd0Wm40SXBTOE81ZzFBSGZOU21qZWxnbmY2aEtNaEJPVE9tUVFs?=
 =?utf-8?B?aE13V3ZYc1ptTDRCckV0MkRBZWg3Y0tLcFJLb1hsVlkwSHcvNDJzZEpobzJG?=
 =?utf-8?B?cUdYaVpkWFQvajhDQVA0SlpwcEs1RXh1UkNqQzNVaFQ0RnJEaHhmQ3dQRjJP?=
 =?utf-8?B?Z29wNWErL3JPWHFaVUdsbi9LRGlmQlEwVUp5dXp2OVIyVE1RVkRFa1FlQWcw?=
 =?utf-8?B?YWJuV0dqc2FvRnh1QXdWb2xoaEliekN3dmpTeEd6SDBETGRrMkYyZ1NMUGQw?=
 =?utf-8?B?Sk1NTmN3UndiZXp4bk81VCs5QTZoajZXbkkxTXhJaTR6THVzOTBlU2lXSksw?=
 =?utf-8?B?RWFpcDRGZ3J4Z2ZXTXI1U01WMFVTN2pYamR5cGV2MTJMRFllQmpWVnZTVmhF?=
 =?utf-8?B?VFpnd1QrVnBnT1VkNnZ4bXRxbmhzcFJ5UmpscTVERE9VUFF5VDg3ZitCSEg4?=
 =?utf-8?B?VExScTZWelRidzVIWmdQTUFrVGhvTmQwOVRHM0E1aDlrYkhNMFNDbzFLY00x?=
 =?utf-8?B?Kys1YUp6U2tyK3hJMHhFRUt3N1ZKVmhEQlBZUGlvZldwTE9BUG9Lc1ZURjIx?=
 =?utf-8?B?WVBIWnp6aGVvOHMvUy9YOVZ4cEhjalhZQkJIb0xVNFIxaTZtQzBxQ2w1a3FI?=
 =?utf-8?B?V3lkTGhteGl0eGpmTTJzWWdOMm5QUWZoak1SRjgwZ05NY1Q3VVoreHhqeUZz?=
 =?utf-8?B?bWErcWlyWDJYdkNURlVLTWsyOG00dlpyTk96SzdvaldRR3JLSUxmd0tMTFBv?=
 =?utf-8?B?YTdma2dsZDgxeDdQaDdFMllsRDVqU2NGY1dkUXFyMGIvQktnckFpNGlZcVBu?=
 =?utf-8?B?bkQzWTJOSzZiaGtWTFg2TSs3dHlvdzdZOFZWeVg0bnZwczdMbmN4QWNudktU?=
 =?utf-8?B?Qm4rQVdjSXRWL3UwN25RY1FXMk12TkxvSVdjUDg1NzE1c0RhdkVDdGRTT2x3?=
 =?utf-8?B?aW9tVTk0K1QyLzdBVmZKSE02QXVIU1ZvVXJCMXdCK2w0eUlRVSs0eGdTZktH?=
 =?utf-8?Q?aA0xnLzfObtFlu51JW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af89d5a9-3258-4750-705e-08ded18482a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 00:06:59.0571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AI9H0m0VkW2H4Rwk76cG76wWL/+Jl4DQAZ9ffGR90m7gdn46Vfw8c41M981+G7jLdyftkrU/b/mGxpAl7gqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB2011
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

PiBPbiBXZWQsIDI1IE1hciAyMDI2IGF0IDAyOjQ1LCBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgRUFMIGhvdHBsdWcgbXVsdGktcHJvY2VzcyBtZXNz
YWdpbmcgdXNlcyBhIGZpeGVkLXNpemUgYnVmZmVyDQo+ID4gKEVBTF9ERVZfTVBfREVWX0FSR1Nf
TUFYX0xFTiwgMTI4IGJ5dGVzKSBmb3IgZGV2aWNlIGFyZ3VtZW50cy4NCj4gPiBXaGVuIGRldmFy
Z3MgZXhjZWVkcyB0aGlzIGxpbWl0LCBzdHJsY3B5IHNpbGVudGx5IHRydW5jYXRlcyB0aGUNCj4g
PiBzdHJpbmcuIFRoaXMgY2F1c2VzIHNlY29uZGFyeSBwcm9jZXNzZXMgdG8gcmVjZWl2ZSBpbmNv
bXBsZXRlIGRldmFyZ3MNCj4gPiBkdXJpbmcgaG90cGx1ZyByZS1hZGQsIGxlYWRpbmcgdG8gZmFp
bGVkIHBvcnQgcmUtaW5pdGlhbGl6YXRpb24uDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSwgYSBNQU5B
IFBDSSBkZXZpY2Ugd2l0aCA2IG1hYz0gYXJndW1lbnRzOg0KPiA+DQo+ID4gICBtYWM9QUE6QkI6
Q0M6REQ6RUU6MDEsbWFjPUFBOkJCOkNDOkREOkVFOjAyLA0KPiA+ICAgbWFjPUFBOkJCOkNDOkRE
OkVFOjAzLG1hYz1BQTpCQjpDQzpERDpFRTowNCwNCj4gPiAgIG1hYz1BQTpCQjpDQzpERDpFRTow
NSxtYWM9QUE6QkI6Q0M6REQ6RUU6MDYNCj4gPg0KPiA+IHByb2R1Y2VzIGEgMTMxLWJ5dGUgZGV2
YXJncyBzdHJpbmcgdGhhdCBnZXRzIHNpbGVudGx5IHRydW5jYXRlZCB0byAxMjcNCj4gPiBieXRl
cywgbG9zaW5nIHRoZSBsYXN0IE1BQyBhZGRyZXNzLg0KPiA+DQo+ID4gUmV0dXJuIC1FMkJJRyBm
cm9tIHJ0ZV9kZXZfcHJvYmUoKSBhbmQgcnRlX2Rldl9yZW1vdmUoKSB3aGVuIGRldmFyZ3MNCj4g
PiB3b3VsZCBiZSB0cnVuY2F0ZWQsIGluc3RlYWQgb2Ygc2lsZW50bHkgY29ycnVwdGluZyBkYXRh
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+
DQo+IA0KPiBXb3J0aCBhIEZpeGVzOiB0YWcgYW5kIENjOiBzdGFibGUuDQo+IA0KPiA+IC0tLQ0K
PiA+ICBsaWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX2Rldi5jIHwgMTEgKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9saWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX2Rldi5jDQo+ID4gYi9saWIvZWFsL2NvbW1vbi9l
YWxfY29tbW9uX2Rldi5jIGluZGV4IDcxODVkZTBjYjkuLmRlMjRkMTRkMjgNCj4gMTAwNjQ0DQo+
ID4gLS0tIGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl9kZXYuYw0KPiA+ICsrKyBiL2xpYi9l
YWwvY29tbW9uL2VhbF9jb21tb25fZGV2LmMNCj4gPiBAQCAtMjUwLDYgKzI1MCwxMSBAQCBydGVf
ZGV2X3Byb2JlKGNvbnN0IGNoYXIgKmRldmFyZ3MpDQo+ID4NCj4gPiAgICAgICAgIG1lbXNldCgm
cmVxLCAwLCBzaXplb2YocmVxKSk7DQo+ID4gICAgICAgICByZXEudCA9IEVBTF9ERVZfUkVRX1RZ
UEVfQVRUQUNIOw0KPiA+ICsgICAgICAgaWYgKHN0cmxlbihkZXZhcmdzKSA+PSBFQUxfREVWX01Q
X0RFVl9BUkdTX01BWF9MRU4pIHsNCj4gPiArICAgICAgICAgICAgICAgRUFMX0xPRyhFUlIsICJk
ZXZhcmdzIHRydW5jYXRlZCAobGVuICV6dSwgbWF4ICVkKSIsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgc3RybGVuKGRldmFyZ3MpLCBFQUxfREVWX01QX0RFVl9BUkdTX01BWF9MRU4pOw0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUUyQklHOw0KPiA+ICsgICAgICAgfQ0KPiA+ICAg
ICAgICAgc3RybGNweShyZXEuZGV2YXJncywgZGV2YXJncywgRUFMX0RFVl9NUF9ERVZfQVJHU19N
QVhfTEVOKTsNCj4gDQo+IFBsZWFzZSBtb3ZlIHRoZSBjaGVjayBiZWZvcmUgdGhlIG1lbXNldCgp
Lg0KPiANCj4gPg0KPiA+ICAgICAgICAgaWYgKHJ0ZV9lYWxfcHJvY2Vzc190eXBlKCkgIT0gUlRF
X1BST0NfUFJJTUFSWSkgeyBAQCAtMzk3LDYNCj4gPiArNDAyLDEyIEBAIHJ0ZV9kZXZfcmVtb3Zl
KHN0cnVjdCBydGVfZGV2aWNlICpkZXYpDQo+ID4NCj4gPiAgICAgICAgIG1lbXNldCgmcmVxLCAw
LCBzaXplb2YocmVxKSk7DQo+ID4gICAgICAgICByZXEudCA9IEVBTF9ERVZfUkVRX1RZUEVfREVU
QUNIOw0KPiA+ICsgICAgICAgaWYgKHN0cmxlbihkZXZhcmdzKSA+PSBFQUxfREVWX01QX0RFVl9B
UkdTX01BWF9MRU4pIHsNCj4gPiArICAgICAgICAgICAgICAgRUFMX0xPRyhFUlIsICJkZXZhcmdz
IHRydW5jYXRlZCAobGVuICV6dSwgbWF4ICVkKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3RybGVuKGRldmFyZ3MpLCBFQUxfREVWX01QX0RFVl9BUkdTX01BWF9MRU4pOw0KPiA+ICsg
ICAgICAgICAgICAgICBmcmVlKGRldmFyZ3MpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUUyQklHOw0KPiA+ICsgICAgICAgfQ0KPiA+ICAgICAgICAgc3RybGNweShyZXEuZGV2YXJncywg
ZGV2YXJncywgRUFMX0RFVl9NUF9ERVZfQVJHU19NQVhfTEVOKTsNCj4gPiAgICAgICAgIGZyZWUo
ZGV2YXJncyk7DQo+ID4NCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHRvIHZhbGlkYXRlIGRldmFyZ3Mg
b24gY2xlYW51cD8NCj4gSXRzIGxlbmd0aCBzaG91bGQgaGF2ZSBiZWVuIHZhbGlkYXRlZCBkdXJp
bmcgcHJvYmUuDQo+IA0KPiANCj4gLS0NCj4gRGF2aWQgTWFyY2hhbmQNCg0KSSBoYXZlIHNlbnQg
djIgd2l0aCBhbGwgdGhlIGNvbW1lbnRzIGFkZHJlc3NlZC4NCg0KVGhhbmtzLA0KDQpMb25nDQoN
Cg==
