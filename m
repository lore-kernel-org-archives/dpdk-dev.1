Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CBC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6ED402C4;
	Wed, 19 Mar 2025 16:03:15 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by mails.dpdk.org (Postfix) with ESMTP id 6F45D4026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 16:03:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpCDCJWyvrcAWpV3xUWVA2qZVxCEqP/hUj2jKuu1Fgkn1uYEWe6MZNDyM2gBShc4SuvUc7xS/5E+PDxeoIq3FWF3PttNaDfBJz37XDEsB9e0JYWxLghHblEErYwZAw2Cb4QgGl7c8WVFgiyak5sBaBwGLSUtYxVmTL4x9m3Mpy+/fFq4Y9UJV5yawc1penuLL59fCe1zJxFSYD0mPyWeHVMbl5fo3CO0Kqn3u/aRWAqCpQDd3VofGGaaPD2H/B6T3mdm+m+bkUWzjSjkVga0/If7HdYRdm4ZRqncRtt60y0LVsjpmUrjSR+kZkQc0BQgtCfXCOZ+Ni9XAItWMubsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO2FQoDucSnfwAKqsQgwByeGyTZVTc81oz8nyJv0vsI=;
 b=djc6jMgFnIHFLM9QV3sPSwZ1OQAodW/cs2dlMoPv6qh8nMDeyXnbOL31e2gfYXA1eMixa+OWEftzOCImA/k0ZinA3JlLFvVgY+vxm4ALoheOu5dfqHMqrF5RIE1SpCsFRMiaO/HiZOa0/EjF6h0Aj1K+Cl1b+DzdJmDk05y30OqfhLcFG8uOAdKc9Dl09cHBVm3dGNl6aKGDvH4XnSMRb8jw9fapqdhxRcOecCHzkHqEADFF61N1EmaixgZchS2xvcMhELRR8xO3dtgNlTAsVbx1r2DhFjnqtM1VsHaDg7qWjvf/fzb+/kqB0cGzJet6d+vP3kXuRg8fnyvpOzfatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO2FQoDucSnfwAKqsQgwByeGyTZVTc81oz8nyJv0vsI=;
 b=fcB6oo68RE4Kl6MVQuFMEWJ1FQTnkcuSdPnOlhh94AlqIfkE954cFcFybI9ldbFC94w4IfMhUBgCkh95Bd3vI88UAvUI7HexR4fPWZLvYhX28IXnbRrsIs9ffBzIBW7T501COmAdjRrxj1ZYBpT/NepKAaNYDJHDY+05ym2eLXE=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:03:12 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a7f9:7418:ac9e:203%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 15:03:12 +0000
From: "Boyer, Andrew" <Andrew.Boyer@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Boyer, Andrew" <Andrew.Boyer@amd.com>
Subject: Re: [PATCH 2/4] crypto/ionic: remove unnecessary deref of function
 pointer
Thread-Topic: [PATCH 2/4] crypto/ionic: remove unnecessary deref of function
 pointer
Thread-Index: AQHbkp208W/aVAbFAkeFMBg4P5kKa7N6msiA
Date: Wed, 19 Mar 2025 15:03:12 +0000
Message-ID: <46EDC3B9-7DAA-4FB7-946D-9728242E0F11@amd.com>
References: <20250311155300.13410-1-stephen@networkplumber.org>
 <20250311155300.13410-3-stephen@networkplumber.org>
In-Reply-To: <20250311155300.13410-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: 0b0f7016-84f5-4c0a-e982-08dd66f72b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0NBMFlnbGg0alVUb1haRG5CbjQ2OTRZaElERjBRRlZNazBpTHRCekpXMVBs?=
 =?utf-8?B?U3Z1TUFEb2VzTXArVE1pYVJMakVVakVMSmg0YUFQaXBab0NhZCtuRXdVNHpt?=
 =?utf-8?B?bnkxWWhQVENidVAwc2Z5UWxPMFd1cjZ1SGNuZkdjM04xb3dpc09LN2ZwT3pV?=
 =?utf-8?B?Ukx4ak9XZWNsbFhOVXhkZzRjV1QvQ1JUaEFrcmxLczBLZVhLOGRNczFlTGov?=
 =?utf-8?B?NGgwUE4zZ3hNUEZ1N3B2dFBHdjNTL1pBejg3RGo5SjZzT2wvTkxQemxONUhX?=
 =?utf-8?B?aVNMNkVpdFFjVUZ1MFNIN3ZRaWVad0krUnpUc1hxTFRidDV2TzVaM3ZkMGEw?=
 =?utf-8?B?bDBUbkJXc2o2Qm1sWlU5dStkc3kyL2dTT0VOT29FRlZBeDdWZGl1cVp5YSt5?=
 =?utf-8?B?UzhMc1loMUZqVG1wd3pFcXJDTUhJR2FIZERLcVRkTTFEY1JOQVZ0a0V5b21l?=
 =?utf-8?B?Z3A5Q21wdjEyNldKOUlVQTRWQ2VMcWprd3BGc25Xek5MSW1iOHRuYW80TDJC?=
 =?utf-8?B?NVBRbWhiMDJpT3dmR09kem5GajdqZ1VuV1NxNmM3N0RZdEtHZ1cxRmlXZGIz?=
 =?utf-8?B?QzV5UXViT3hpRjQxZkNpaWFleGZ0SzBuMXJQZWRidHRaUzVPSG5UbkhyWFMx?=
 =?utf-8?B?Z3JmTWs0MjVmVDBrcWt5QURnWXBqeWlzV3FVdGZFT2hWMDFXNVl4ZC9hV1h6?=
 =?utf-8?B?QWpHNG5SZnZ3eEdMRGtoRlJLME8xSmZHNzZtbWVHYk1vd2kyN1dVZWEwRkNP?=
 =?utf-8?B?VVp6cERLUHlDSEt0M2hiWTRJYVlzYW4zc0ltMVM5NWh4MDcyNnFnUVZ1MUFr?=
 =?utf-8?B?NFg1R3RiVDhoaEJHNkxvU3N4dEsyWi9wYlZ0RzMyRi9DYU5BSVJ0OXkvaDNy?=
 =?utf-8?B?Qk1XYkVONmFpdzFwb1pGUFUxWWw5MURlMDV6NVNDakxncmFiZjhtNmloSFZv?=
 =?utf-8?B?RDlab0dzQWtoeXowa25FU0FGR3FEQXZqZm1NaWpXd29ma3AwekJVSkxNcFc2?=
 =?utf-8?B?NGNXQVgzY3kwdFZxai8zSEgrWnovdXZ1QStSaExocUJQVGdlOXozNzZDNHFE?=
 =?utf-8?B?bnA2RmQ5ckZDMjIyS1lGeVU2TWttbWNFM0I4UEpFc3ZOSE43ei85VUp4NVB2?=
 =?utf-8?B?VGFYb0xzb1hOVGNhQVZvd05VMnBuLzdvUW5kR0VpRTdPbHFxZ05vN1BNR0RJ?=
 =?utf-8?B?M3ZySDBtSWkycXhKclJiblY4STFSc3IyendVTzhLTGVHdmQ5OExtRDF5eXov?=
 =?utf-8?B?ZW5aaUpYSEdZays5R1B4T0w5bFpMY0t3bWZFOHk0Sk4rZjdyQ2FEVnZCeUJz?=
 =?utf-8?B?RWZidlppR2xkSHFJMlA4Mk8wQ2tDMm1FdFNNY3A2RkVkUW1tVXl1amZ5Mk8w?=
 =?utf-8?B?NnUwNUpyZjljbnpONWxzL3licWVLcmZDaTZJZHd2TmRLTG1vRUZkYklPNUpW?=
 =?utf-8?B?WkxSaEU4ekx3WVZDN2lId0RtaGR0VnhNZVNPRmdhdXNCMjRkTzhOYVFWZ0Yz?=
 =?utf-8?B?Snk3aXRxZWFHRlFzeDYzQUNCNS9jYndVQTJSUTJjdzRpSjJGNmxvM2MzdUx3?=
 =?utf-8?B?bTExTDluTXZ5b0hDUXNlYkNpcEZTNklHdWM1eU1Ld1RDTC9CSVI2TkdqUlEx?=
 =?utf-8?B?WmRtTC9qQy9kTnJvbHE5RnFGdjFkbkF5QUFtSWthWityTSs3V3puVzNTYTVC?=
 =?utf-8?B?UW1KM1BoS1B6dGVaODBUYXo0d05TVnkySkNsQ3NaL1RKcnQ3ZGsrZWpYR09E?=
 =?utf-8?B?dXdXbGQwN0lnTFFZVm9zSTkxeXdrZFVPSXNHUVBBWHo1TExtc3d1a3hzWWhM?=
 =?utf-8?B?dEl4VkMwVkt6aVdtMGtXakVWVmF6Sk8vUGMrZUQ2QVhjSXRMVFNUM2xYcUZi?=
 =?utf-8?B?RnpnaFdyYThOMnpnQzIwamMzcVUyOUJiNktDSTdhZEo0QTkyM3RZd0M1cmFq?=
 =?utf-8?Q?lSM/z+/QZds/RPs0KBhBxX304dTOXm/R?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXZYZnd1RlJwY0lBa0ZHQjdPUXJjWm1DY2NOZ1diWWZYaUQ0MStNTTJXSW9n?=
 =?utf-8?B?V2pmcFZ5VVJpWUk2dWxFRTM0RERYbjVacWVhY1RVcTU4UFZ4bCtCb2x5aUx2?=
 =?utf-8?B?MFo2WWZrelV2T2MxUXQwTEJnRWdYeS9XTkMwaFhVK29KNVRZN3NrOGU1Q2x1?=
 =?utf-8?B?L1FKVTNjb2N5QjhNOW0ycTdncHFrckdCRzNVbEt5bzMxcWhQQUw5Z09oR1Iv?=
 =?utf-8?B?MWZncXZpK2Y2WnppZ2RMcXhROVNxNHBIWXN3MmtJZ2tRS1NoS252aHQvZTNH?=
 =?utf-8?B?V2FUOUpCekEzZkVPUWxidTJOSXpJZUxKUnlWWUFzVUpRbklqYkxLS0VGb3RG?=
 =?utf-8?B?L0ZxWnJRL3FMR3IrL1BtQzZZcnpSeHU1MDBlQnhBSVROVVlXRjN3cERqN0l4?=
 =?utf-8?B?WUlmUjNDU2EzRU5qTGtwWTFhY1p6M2dyaU8zOENxTW1qeEI1dFNiMGdTdEpU?=
 =?utf-8?B?SFVramxrd3V1MVFLTlk4KzNEeUlkWEpSaU1RcXJnOTdxeldOUUFULzloTklX?=
 =?utf-8?B?aHM2OStjakVySFhtQ2J4UzZCbjNNMlJ6YWJGaURjTmZRYms3K2JOa3JBL2lw?=
 =?utf-8?B?cmZuelJPaXp6YXI5N2tqSC9TV0g4SlR6Ykk3NFJ1RXRZWDI0ekxpakRyVG51?=
 =?utf-8?B?OHZmOFg4dXlMUnR1aHpWOW8waUorWVlFU21EWDZhc0FTQzFkNTRlNjFNSVhu?=
 =?utf-8?B?T2JreEkrVVRTNWNuRXNOYmdobzE0cHViMTJlM0NjTVN6VUFFci8zcVoxM3NJ?=
 =?utf-8?B?MUYrSGRlSWxmcHljWW1UblJibW1paEVNYmlRUDhYS2lGN0tUSUZ4eThlVEhI?=
 =?utf-8?B?b0M2cVZiLzhubmpmN2FGeHBCdG8xdVZzVVNleWIrQmNONkczQmRuV1VoczZ4?=
 =?utf-8?B?L1h3a2JLYmpkeDVTa0VUQ05LcTZlekEvT2ErQkd3TVN3c25jV0FiVzZDclNm?=
 =?utf-8?B?VFZSVUVPWHNuTGZFbXk2cEpzTEwrNTNwWS9OYzRlUWNRTHA0eTBnbUk1MlhF?=
 =?utf-8?B?YWwvTDAxR0NDVGZ2QzJ2eC9KMzY3cmVET0ZVdGdhejZzS2JBZ0NwSzNQbDMx?=
 =?utf-8?B?R3YzcStBMUdENmtHNDUwVlQwZHF3SWhkSmg5Q3Mwa0ZBTWdUaWVRenJjQVM0?=
 =?utf-8?B?RGN6THFqRzI3YzVMMU5Yd2NYcTdNb1F3LzN2Z1ZpZ1Y4anJkN084SUIwMnRW?=
 =?utf-8?B?Y290WVhxK0tFSko5L0JualZicTc0L3hGVlJaa3JwZm1DbWt4c3lhSzg2cUJR?=
 =?utf-8?B?YWFqcVZzVEduY0c5bHpZbTdUSlZqRTZlOVZKQ2hKUktoY05NUXNSOXoyYzM1?=
 =?utf-8?B?RHVLRmU3UzlUNTlYeEgxRW1ZWUJZV1plclVoT1VMUDRNQVJUVUVLQlBTQ1JU?=
 =?utf-8?B?cktacTNBSjFOYXl3dFc1T1g0a3k1cVYzdm1acU1TeDByWXl0S1J1TWVwL28w?=
 =?utf-8?B?WTkyQzJhcmtnYjY1SE9wWm1tVnBINnJBUGVtYXVJZk5EcDFIV3Nhb0tYZVVE?=
 =?utf-8?B?MUYyU3FiSGJENFQ5by9HZDJWelBzbWlWbWtTUWRWRDJXVlAwR0Zja2hJellm?=
 =?utf-8?B?WnFTQjNiU083aDZpNXp1ejJ4SWR2enFiRHRJOVR0cnA1SEhMVm5kb3puNWJF?=
 =?utf-8?B?ZWw0TkJJYzJTS3BRL2VFQzJ4VWlraGJnZEd4cy94VFp3QnlqMDloV3BhRVBX?=
 =?utf-8?B?V1JHZmFPOUtqUnBsU2xqMWNrZHZXeEp4a0JkT0JKblBFSE9ZRHhLUXZpcHAy?=
 =?utf-8?B?K1dmQ1d2MGdLYXpsd2gyQXRwUW1uUUxPNEY5RitxZ2EraTFaSFNNYUdZdGNT?=
 =?utf-8?B?S3psbHZQL0F1QmVQem0rRk5lTnFVSVF4TVA0d2JpL1NNYkx4aVVIRStLVUIx?=
 =?utf-8?B?TmkrRFVOVlJkR3paMFEvSWNzNUNGc3pXSkxyVHFWeUhURHAxcytEZ3l5Z2JP?=
 =?utf-8?B?dFJwbUNzNlltUmc1eVBWeHF5TlhnVnBXUDIwbkNIZUNRbDRnUDQwTi9mL000?=
 =?utf-8?B?aU03ZlF2ZUIyUHZzMXMrcG1PNngxVEtaaGpNQ1VZOE94UzBGWUhaUlJUTkh6?=
 =?utf-8?B?OGZJazQ5alQ4SjZDdE1vT3NQeFZXU1NQUWg5dFc1a1krY3J0cXE5dTdJNjFP?=
 =?utf-8?Q?BsVZgJtNTTbPnDO3l1K1NApRw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA1C355675C164CACA1C3F2C18DE404@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0f7016-84f5-4c0a-e982-08dd66f72b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 15:03:12.0890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRR93i0MvkK2GUGdXWH6b/ZbT2GgWYF+PqgqjnWwMtFcugNzBd3Vz+lhBpiqUq0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

DQo+IE9uIE1hciAxMSwgMjAyNSwgYXQgMTE6NTHigK9BTSwgU3RlcGhlbiBIZW1taW5nZXIgPHN0
ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPiB3cm90ZToNCj4gDQo+IENhdXRpb246IFRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRp
b24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4gDQo+IA0KPiBUaGUgZXhwcmVzc2lvbiAqZGV2LT5pbnRmLT5zZXR1cF9iYXJzIGFuZCBk
ZXYtPmludGYtPnNldHVwX2JhcnMNCj4gYXJlIGVxdWl2YWxlbnQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IC0t
LQ0KPiBkcml2ZXJzL2NyeXB0by9pb25pYy9pb25pY19jcnlwdG8uaCB8IDIgKy0NCj4gMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jcnlwdG8vaW9uaWMvaW9uaWNfY3J5cHRvLmggYi9kcml2ZXJzL2NyeXB0by9p
b25pYy9pb25pY19jcnlwdG8uaA0KPiBpbmRleCBkYjg3ZWEwNDkwLi41YTAzMjYwNDg2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9pb25pYy9pb25pY19jcnlwdG8uaA0KPiArKysgYi9k
cml2ZXJzL2NyeXB0by9pb25pYy9pb25pY19jcnlwdG8uaA0KPiBAQCAtMjY5LDcgKzI2OSw3IEBA
IGlvY3B0X3NldHVwX2JhcnMoc3RydWN0IGlvY3B0X2RldiAqZGV2KQ0KPiAgICAgICAgaWYgKGRl
di0+aW50Zi0+c2V0dXBfYmFycyA9PSBOVUxMKQ0KPiAgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gDQo+IC0gICAgICAgcmV0dXJuICgqZGV2LT5pbnRmLT5zZXR1cF9iYXJzKShkZXYp
Ow0KPiArICAgICAgIHJldHVybiBkZXYtPmludGYtPnNldHVwX2JhcnMoZGV2KTsNCj4gfQ0KPiAN
Cj4gLyoqIGlvY3B0X2FkbWluX2N0eCAtIEFkbWluIGNvbW1hbmQgY29udGV4dC4NCj4gLS0NCj4g
Mi40Ny4yDQo+IA0KDQpUaGFuayB5b3UhDQoNCg==
