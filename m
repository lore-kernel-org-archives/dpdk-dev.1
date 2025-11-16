Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F1CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 08:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2490F40B9F;
	Sun, 16 Nov 2025 09:11:51 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by mails.dpdk.org (Postfix) with ESMTP id 635F54026C;
 Sun, 16 Nov 2025 09:11:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERJDLyspXuROFd9M1fJ3lJc2xQMZPfdsA5bhtktV5q5eXIr6WEbBYU++lQ8eky57OpPnRwr/8cAn5hYKVvwMWGkkgomvz9vE6zZ88Q7wvKtk9/EG9egg5EDNgdr+Jb8vFMxCzM/Kw3kVX+lhOHZx7n4SIQqCKsuCIBiPV1Uq0Q9y1U2USTcEG02Yzqa5PPFSeNW3l3nH03Moy6BxICqYbt+v3/WKwtTVCTM1hhGiEID3g0TzXiye4eB8mEhPVUHWXehddgbdQkQ7Inj4cUNyVV3rdQB56iwbJFzT/7+YOcqTEwlPpZbO60QouHzWjYfrGRMmS26o8TBoXKi/8LcH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZk2BmGpfUhS376WbYiGnk+sPvSEYQNcX5xUWSdcP2o=;
 b=C+Pd545IngHOgz4iRxWg+66y03hiJNdBa84bAXo+EFjjAmNMh5Zc+1bC7DNkv4u/kku76ehUw2qyJWA1ohtf2VOhMHNy3aJpRmuNfURSunCGx7Dz0WI/y/LLIfmcGmNilqlEO1aZbH2E2G4bwc9b5cAIV20YzeM4TiBkR6XF5XOVz/6/Dl7jdZtQ0PPHIYKaalmIjshC4NUfRDX5r3Un4fmVoPULfGMuDD8duC9X88CHIQDeLvVf7yueY6nWh8vXabwjYZfVVsAU8yQ9g61i5s8qAZT16YzdG6qfFVfT9+9ungDxIBRK4EacVAQqUAS8L7pK2SWS6bV2xqX5Gm2UDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZk2BmGpfUhS376WbYiGnk+sPvSEYQNcX5xUWSdcP2o=;
 b=emYc/N9Ko/b0+ho4sKy5pF3Fh7PJ1zXX6gWfnsyHikpDyVftKPgx2pCQkSKEXh2YT8x61axrOsVAcKIvRsdLakO/zAvUbX/5TSZkVYN4mY/VIPqjxvZ2XZ0eVBpoInGKCRTfzXO8479H6rKXEOCbvbkr337uxxjAsQyiPhkAn0LKNs5gbxAVbXIm3RJvrj8jbswOr0Cog19opsepZCwNJuhL/4L+upg/v7/iI+w49rON40NNdbu34ycqlcaWO+grNlZW+W2idG7JSHTrk8N7B/bhc3eBqHClpgaz9Apm91/RwNUOM1rza82WVUt+JLksU5GaKfwKZmqMxd2kKnezsA==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 08:11:46 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11%6]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 08:11:46 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: RE: [PATCH] app/testpmd: fix flex item link parsing
Thread-Topic: [PATCH] app/testpmd: fix flex item link parsing
Thread-Index: AQHcVNqYQn6NL5tVWUiIp+NWJGphRbTxMq6AgAPEqIA=
Date: Sun, 16 Nov 2025 08:11:45 +0000
Message-ID: <PH7PR12MB701806D57F27AEA27D623E49B2C8A@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <20251113201726.10597-1-mkashani@nvidia.com>
 <20251113143813.5276622d@phoenix>
In-Reply-To: <20251113143813.5276622d@phoenix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|LV3PR12MB9186:EE_
x-ms-office365-filtering-correlation-id: d79e993b-aea5-494d-e969-08de24e7c8d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eTNLcHpRSUFhcGRrT0FzZXJoQVRiU1NiWDBZVFFkVjI2cDFHeGRNVEdtSnp0?=
 =?utf-8?B?L1lnMTZIMkE3UXdXRVFqTy9lMmFIRGJqanBWUm5Demk0K25JMVVoTXV5eE5l?=
 =?utf-8?B?dnJnelhtRDFSUVdmOTNFZE0xbEVna2t4L0ZOa1lOMTl5QlpHSHQ4U1BWTVU5?=
 =?utf-8?B?dlVrdmx3YWx2MlVyeXhTeWlzY2QyUHQ4WlFQZjNldmo2V2lmRDNQbWVuaE02?=
 =?utf-8?B?YTJHZkVGQ1M1WEtKZVJBc1NyckQ1cWRBSGhQbVBEVXpsTHJEdExMWHdqeFpK?=
 =?utf-8?B?cCtVbXVkWTJrTktkTmtOVGh1RDEvb2hPak1vcWhGZ3FCSlZ3NEllZkxmb0Ra?=
 =?utf-8?B?SDJ3YlFQaFFjUlFTYTFvaVArZjdkd240V2hHZHlQL2V2YVpjaGtzUUIrbVAv?=
 =?utf-8?B?c2hJcmNEZEVTay9PcXBhbFQxejhDYTB2aHN2UEI4amJ6SmpEckZoaFF4QWlC?=
 =?utf-8?B?MGJxYmM3cW00RzJ4WHBmV295bUtBRWlyeVlHaTlMVXMzS1lMcnNmTzUwbmtz?=
 =?utf-8?B?YkorTXl2YmJpNkFEbGM0d0x3T2NKVnNMc2lCejJCc2psVlpXaklYT0dia3BG?=
 =?utf-8?B?Z2tsZUZMR1kvS3Y1ckkyZExlbXBpaGlnU3V1N1B6YUJQNUQzNXFnRkRkMTNO?=
 =?utf-8?B?aHlXMUJ4UE1PbHg5UUtZYVN5dUs4eVdiVDh5OEIzcnRhc3dzNW40eGgrZkcy?=
 =?utf-8?B?RkphVm1aV2Fta0VTNmtzWnFkWEJ2dEc1NERrTHlpck5mM3VaemZNcUtSYWh2?=
 =?utf-8?B?RWc0b3dBaHB0NUwraWMydWdJN3BwZ0dzQnZpVTNvcHh1eEJ4REFFTEROYk0w?=
 =?utf-8?B?YlBuWTdyaHl5REVVRStMM0lJNFZPd0p5ZnNDa29sM3V5djAvRFZyYTVTZ0ds?=
 =?utf-8?B?SzdBek5xVFlzUGo4LzM1ZnNkY0hvRXltN0RaZkFFdjNRSjhwenV0RG5kc1kv?=
 =?utf-8?B?SXIvS004bU9oVWVWSVl4TzF3dDhvKzZBYm9EczFKZWszbm1TUXBFdnpGZHp4?=
 =?utf-8?B?RmF4Y0JBR29tb0RTK2REU2V0QjloR29yWWF6c2VibzU3N1lsTHNSZzU3Nmdk?=
 =?utf-8?B?bzNMZVNBNjFISGtFOHFMbFBDUlFVRC9hZjZoSnhtNGhSSVc2OU5uSGRnei9j?=
 =?utf-8?B?Y2lqSnlDZjlGeWZLZlgxT3VIRTZqZFpQS25NakpHNUVOenUveDNCRHU5N2c2?=
 =?utf-8?B?YytIM2VJalUvQ1VGaXAyaFdPYThEZ3NqdnpDbHlKaW9PTXJtTGV5UnBJd3ZE?=
 =?utf-8?B?OVVrcEpHUXBuekhoWXZxVkdMTVBJWGhzMWQ2ejdxSjlzeUtJaFRPQlBZemZ1?=
 =?utf-8?B?dkpjanpDRk9iZTJwMG5yQkdWT3M1VWJYcDlOdFNOQ0xWanZNb2xBbzIwS1lP?=
 =?utf-8?B?NGVadm9EZUx0SndkVlZvSkhqVEsxandXQjV5Z0VLTzhNbUxiWC9xTTlLWUY0?=
 =?utf-8?B?Vi9yY1llOXlPdDJuemhhSkN0akZvSWkzUU5QMVIyeS9TeStlY0ovWVBFQk1K?=
 =?utf-8?B?UVZvc0pGdytpYzBYazhpRHhXWnozYmU1NnN4c1Q0bFp6UTNudnArMDVYaE9h?=
 =?utf-8?B?TnJaT0Y2M3lvVSsyTWlUTjQySmpRYVRBNmdOd1VQQ0UydDFzbituSlBwQkxH?=
 =?utf-8?B?aDVUOGRFMS92Sjl2R0JOMGoyRFdsZjdIeVB6aW1zT2p4QW44M3RJNnpYUElG?=
 =?utf-8?B?YkJZQmExOWhqU1NpUWgzcWYvVmN4UElxeUhyb3Q5bmpWQ0lRMVpPcHRHbmFn?=
 =?utf-8?B?Zm1IRFg5SzNCMFN4MDZCb01oczNYWmRmU0tZcWJxTEJFMUM4VWZBWEFVRG52?=
 =?utf-8?B?ZXZleDFsUTIvUnRjWVZpQktDMnd0MmkyQkhXU09ZUEZUVGxNQ2VwQjZLNXB5?=
 =?utf-8?B?MEhRcG5tc0NLRExIRUQ3blZTejRwckRENUc3YnUyZ2lITmZUUXE5VkZVeGRD?=
 =?utf-8?B?bllrVUIvKzJ3bk8rNFpsdDh6bmR6NVRrTHZSbkM2cUhBdVBjV0FxU3JscUpN?=
 =?utf-8?B?SkNVNndVaXVtZXRGazlDVlhrWjNMUTljVWF6THNqN3BXeFZLQkgyRWhsbGhu?=
 =?utf-8?Q?j9Ek6p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFOREt6Y1k5V3VFSXJaYkY5MVNwOG43angxMkg1NEM2TGJGdzJOU2FWaHQ0?=
 =?utf-8?B?UzJEeklmVGpKcTlGbjZUUkZyVG9tL05nZ3dnTElsWFA5N3VnQVROajhtSkIz?=
 =?utf-8?B?YkhzaGw4TlB5QXFORXNrekYrS2NhdzAyenpwY3lZdGVFdEJWZmJCUjNocmpO?=
 =?utf-8?B?SXNjRHhuais4MXd4cDFLSkN5L0JqblozSmJIQzFEcFJESllHbFYrcnFITXkv?=
 =?utf-8?B?ekhuUTVhakZSdjcvTlBVNFpjRkM1dGZNRmI4UWdyOU1PaDlMeFZ0NzdPOTJE?=
 =?utf-8?B?bjI2Rm9adHNSaWdmU3NZOGN6Y3pCaTBPV0VJWnpGMzlLZGsxZEtPWFpMaXNu?=
 =?utf-8?B?UkNsRlRZeml2ejhscHFDYVlwOU1aRDA3TzVFYVlSa0hwSkp3azdSRnA0WmVW?=
 =?utf-8?B?SzJmdzBhRmxXRVNnS05DbEIrbm9JNmViTDVqRjVpL010RkMrWmFjMllUZXhW?=
 =?utf-8?B?K3psaFdFUVNHMm5RL3RJTDJWaTZzVHBBKzRURklOSExPZHY0K0daUDF6L3BP?=
 =?utf-8?B?UkwxWFQ0QU1XME8ybFcvVHJPV0tGNC9qMWxwL3pXaS9QeTFBbmd1OXl0Y3hr?=
 =?utf-8?B?aERnYnp2TjlJZ1hxaDIrM2xUbGQ5K2plMUZ4azN4OVZ6RU82WWFyd0Raem1I?=
 =?utf-8?B?WFJLNXFRem4wcFpDMHduajUwUkY4WW9CUTE2RDhJZjFHQTUwWFRRdWZZcnNV?=
 =?utf-8?B?ZndYZ3FVK3BwWFJnbTJ0TWxFK1B0UUZ4Z0ZxL1A1c3ZhVFJKeEpEUWVGbjRZ?=
 =?utf-8?B?SjJMaVdld2VSWkpKWGZxMjZTaHQ0c2tHOUxUTldKZTJMR3h4YnNrcGxvY1da?=
 =?utf-8?B?TDRzcUdaQXVCYlIzZW54VjVGRWtGbFE4RU1HQkhKa2lDTHZnaFFzR0dZQkQr?=
 =?utf-8?B?K3BVY2NSNWtpWFpLQnVOc1hDZnB1emx2YmNmVUxVT0liM3ptQVU3SEQvei9B?=
 =?utf-8?B?MnpwaCtLOXpCaG5UdGUvWnhJeXY5VXpCQkx5ejRHYkp3eDJKelY1b1paY3dF?=
 =?utf-8?B?UTE0VnNSdCtueTdLS3BtYVhUOE1YM0hpQW4wQWpqNWhPZ2xyUXpXbkhVTXZp?=
 =?utf-8?B?ZmZ5S0pYRkFnMHg2ZkVhZnNkbzVGcGlmaDREY3VZVDUrK3hPcDFIa3lGbzFI?=
 =?utf-8?B?a3RrN3NlaUl1cFZwU0U3WUxQQlI3Z0pvdEFXS3lZVm5JRjc2bi8rbkRiaGxU?=
 =?utf-8?B?SmZsdXlVaitWSlBxZGREbmNvRzY5bnRGOXBVOXBvT3BWcTRjcnU2YXZlaW5V?=
 =?utf-8?B?QzVNSzhyRmVMclFEVFc5RmRmWmF5Z0RmUTRBRjZLdFZsM2N4ck1TdWRGQjNv?=
 =?utf-8?B?cHptdHFPVEJjeHBkMGlnYldDREVlL0NYMkFOVTlrTHlSaXpCZXJ2UUFvdUJR?=
 =?utf-8?B?Mk9Hb3BUQnpGZ3FwT2k3Zmk4a21DSnVJMjNhUk9vaXhMTDlsN1VnUGFkU2lW?=
 =?utf-8?B?RTVvNlVFdkNEdFVHZWlFRzVzOWFnZlRQeUNVSWh5eU5oWXZwYUt0Q2xYOWsx?=
 =?utf-8?B?c0pFSHphV0d4SWFRNFpOQ25WWHptOUhTWlBjSWg0Z2RqdjdKeW9Sa1F0Ujcv?=
 =?utf-8?B?T3VpRnBnSmNSNUVTKzEzSXFvWWhRcXFNbkE3aHJZTzhQN05IcEFUTENoMlpv?=
 =?utf-8?B?U05JTk82RS9ZendpZEpwZkl4eUZkNjB1ckdKR05XOEJNNHV4c1FuRm9PUUpO?=
 =?utf-8?B?d2M2eGZwMk5PVzhQcUthMWZTaHJublRSNnljQkhqTjlTajZFams5QzFJRitY?=
 =?utf-8?B?MTJvS3FCOThCVEFoVlFkS2xaYTkyNXBNbndDSHluRzg1MHFnZVB6VW1rWGNX?=
 =?utf-8?B?eHdFcUhGbTFpak02UFlQdXdCV1BBQnBLcEZUSTRMdXVpdjBETlpwbnZQQkJ0?=
 =?utf-8?B?emRnaDVzallqZExwK2Y2dVdBUUhIZnNabWVpY3dWTWozT2RDQ1dmU1RVNDFK?=
 =?utf-8?B?SXExU3RxdXg2TEZCcXhWQkdHY05xOVVGWVIzS3JqRHhmRFRqckVZME8xTURp?=
 =?utf-8?B?K2xHTDhOUUxOR0ttYVcvYkIvRE5vQTI3Zkx4N1RHQXMwbEtobGx2OGRzMXRR?=
 =?utf-8?B?ak9TQmF5U2l6cW9HMk9JSjY5a25vSTE2QThXM1JOc2ZDTWN4UDNUWVJSQkZP?=
 =?utf-8?Q?XhuGNVMoRcRJDf7d5f9l6KqOK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79e993b-aea5-494d-e969-08de24e7c8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 08:11:45.8726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRiLZ5ZwGT6yp8oVY5qTG2nWWYAeRWgQk2UAbiGp/ulzw1KDGo4hKIUp33p0A9DzfCyMQzeZx5vfZ24ZkHyjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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

VGhhbmtzIFN0ZXBoZW4sIA0KSSdsbCBzZW5kIHYyIHdpdGggcmVxdWlyZWQgY2hhbmdlLg0KDQpS
ZWdhcmRzLA0KTWFheWFuIEthc2hhbmkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+
IFNlbnQ6IEZyaWRheSwgMTQgTm92ZW1iZXIgMjAyNSAwOjM4DQo+IFRvOiBNYWF5YW4gS2FzaGFu
aSA8bWthc2hhbmlAbnZpZGlhLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgUmFzbGFuIERhcmF3
c2hlaCA8cmFzbGFuZEBudmlkaWEuY29tPjsNCj4gc3RhYmxlQGRwZGsub3JnOyBBbWFuIFNpbmdo
IDxhbWFuLmRlZXAuc2luZ2hAaW50ZWwuY29tPjsgU2xhdmENCj4gT3ZzaWllbmtvIDx2aWFjaGVz
bGF2b0BudmlkaWEuY29tPjsgR3JlZ29yeSBFdGVsc29uDQo+IDxnZXRlbHNvbkBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcHAvdGVzdHBtZDogZml4IGZsZXggaXRlbSBsaW5r
IHBhcnNpbmcNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gVGh1LCAxMyBOb3YgMjAyNSAyMjoxNzoyNSAr
MDIwMA0KPiBNYWF5YW4gS2FzaGFuaSA8bWthc2hhbmlAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IFRoZSBmbGV4X2xpbmtfaXRlbV9wYXJzZSBmdW5jdGlvbiB3YXMgdXNpbmcNCj4gPiBGTEVY
X01BWF9GTE9XX1BBVFRFUk5fTEVOR1RIIGZvciBhbGwgbWVtY3B5IG9wZXJhdGlvbnMgcmVnYXJk
bGVzcw0KPiBvZg0KPiA+IHRoZSBhY3R1YWwgZmxvdyBpdGVtIHR5cGUuIFRoaXMgY291bGQgbGVh
ZCB0byBjb3B5aW5nIGluY29ycmVjdCBhbW91bnRzIG9mDQo+IGRhdGEuDQo+ID4NCj4gPiBUaGlz
IHBhdGNoIGFkZHMgYSBzd2l0Y2ggc3RhdGVtZW50IHRvIGRldGVybWluZSB0aGUgY29ycmVjdCBz
aXplIGJhc2VkDQo+ID4gb24gdGhlIGFjdHVhbCBmbG93IGl0ZW0gdHlwZSAoSVB2NCwgSVB2Niwg
VURQLCBUQ1ApIGFuZCB1c2VzIHRoYXQgc2l6ZQ0KPiA+IGZvciB0aGUgbWVtY3B5IG9wZXJhdGlv
bnMgb24gc3BlYywgbWFzaywgYW5kIGxhc3QgZmllbGRzLg0KPiA+DQo+ID4gQWxzbyBhZGRzIHZh
bGlkYXRpb24gdG8gcmVqZWN0IHVuc3VwcG9ydGVkIGl0ZW0gdHlwZXMuDQo+ID4NCj4gPiBGaXhl
czogNTlmM2E4YWNiY2RiICgiYXBwL3Rlc3RwbWQ6IGFkZCBmbGV4IGl0ZW0gY29tbWFuZHMiKQ0K
PiA+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hYXlhbiBL
YXNoYW5pIDxta2FzaGFuaUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcHAvdGVzdC1wbWQv
Y21kX2ZsZXhfaXRlbS5jIHwgMTAgKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FwcC90
ZXN0LXBtZC9jbWRfZmxleF9pdGVtLmMNCj4gPiBiL2FwcC90ZXN0LXBtZC9jbWRfZmxleF9pdGVt
LmMgaW5kZXggZTZlMWNlZmViM2QuLmVjMTlhYjYzZTc1IDEwMDY0NA0KPiA+IC0tLSBhL2FwcC90
ZXN0LXBtZC9jbWRfZmxleF9pdGVtLmMNCj4gPiArKysgYi9hcHAvdGVzdC1wbWQvY21kX2ZsZXhf
aXRlbS5jDQo+ID4gQEAgLTEzNCw2ICsxMzQsNyBAQCBmbGV4X2xpbmtfaXRlbV9wYXJzZShjb25z
dCBjaGFyICpzcmMsIHN0cnVjdA0KPiBydGVfZmxvd19pdGVtICppdGVtKQ0KPiA+ICAgICAgIHN0
cnVjdCBydGVfZmxvd19hdHRyICphdHRyOw0KPiA+ICAgICAgIHN0cnVjdCBydGVfZmxvd19pdGVt
ICpwYXR0ZXJuOw0KPiA+ICAgICAgIHN0cnVjdCBydGVfZmxvd19hY3Rpb24gKmFjdGlvbnM7DQo+
ID4gKyAgICAgc2l6ZV90IHN6ID0gMDsNCj4gPg0KPiA+ICAgICAgIHNwcmludGYoZmxvd19ydWxl
LA0KPiA+ICAgICAgICAgICAgICAgImZsb3cgY3JlYXRlIDAgcGF0dGVybiAlcyAvIGVuZCBhY3Rp
b25zIGRyb3AgLyBlbmQiLA0KPiA+IHNyYyk7IEBAIC0xNDMsMjEgKzE0NCwyNCBAQCBmbGV4X2xp
bmtfaXRlbV9wYXJzZShjb25zdCBjaGFyICpzcmMsIHN0cnVjdA0KPiBydGVfZmxvd19pdGVtICpp
dGVtKQ0KPiA+ICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+ICAgICAgIGl0ZW0tPnR5cGUgPSBwYXR0ZXJuLT50eXBlOw0KPiA+ICsgICAgIHJldCA9IHJ0
ZV9mbG93X2NvbnYoUlRFX0ZMT1dfQ09OVl9PUF9JVEVNX01BU0ssIE5VTEwsIDAsIGl0ZW0sDQo+
IE5VTEwpOw0KPiA+ICsgICAgIGlmIChyZXQgPiAwKQ0KPiA+ICsgICAgICAgICAgICAgc3ogPSBy
ZXQ7DQo+IA0KPiBZb3UgZG9uJ3QgcmVhbGx5IG5lZWQgYSB0ZW1wb3JhcnkgdmFyaWFibGUgc3os
IGNhbid0IHlvdSBqdXN0IHVzZSB0aGUgcmV0dXJuDQo+IHZhbHVlIGRpcmVjdGx5IG9yIGFyZSB5
b3UgY29uY2VybmVkIGFib3V0IHNpZ25lZC91bnNpZ25lZCBtaXNtYXRjaC4NCj4gSWYgY29uY2Vy
bmVkIGFib3V0IHNpZ25lZC91bnNpZ25lZCBtaXNtYXRjaCB3YXJuaW5ncyB0aGVuIHdvdWxkIG5l
ZWQNCj4gY2FzdCBvbiB0aGUgYXNzaWdubWVudCB0byBzei4NCg==
