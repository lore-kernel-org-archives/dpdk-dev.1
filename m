Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DD1C87FCE
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 08:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5BC4402DC;
	Mon, 28 Jul 2025 10:22:40 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by mails.dpdk.org (Postfix) with ESMTP id A7BFC400D5
 for <dev@dpdk.org>; Mon, 28 Jul 2025 10:22:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQyZa8RFOmHmn+ADFOC8vER0beIK48DixVQN7KeFSGIwtA0eIzDpK06ehLDCSEHhhAmg9xP2DGz66uHcadJE6xzXvrYa2l30ngph+YbXs1VusNjTPufrNDfzxVokYsCejG/UvQ7WaiZMujdI/Lbrv+BqNV53ZP14mAs1zyF8sR94L++92k85Dqff68eS/YABJsQ/kawbOaTGP+/phHsid5uktz9qqFRQJwAGsKaOj9HPUs1ax36o0zSn3r+GT3hSQ/YX+GH+GcwHkrri6tplQdM36b2kzEmpeLt8+L0cNAVxpQrRYPpdoXhKYlSw2NREHb53bSuxAYDu44M0jxk4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiVhZ2Igcjxkdj6TfEFopdokjLHnvKSmgCzVypJeM/E=;
 b=q7IlekNMIe73gsAbE+02E0sT4W8SBzIYxsSwHDoTQr2BVc60bjxbajlFjHuyqvsKp5+Unri4GhZBA+P6B/l6pSZVekegu509Auo72xDRnKAWGGIbeHGdXCh3EuE8qpS/eR/bbz5QNvHY//FScXogFqDrmb0t9ozmOLy7+RI5MGqjujwpjAG4p0HTUq4liJuIpsMtczZfIFgqSAKN4bNBT5CG0rDWVwKFdgziXnWvCqViyS2SyKNOGu5IHVTNXgXmSDt179gNk8a+C4Er/23RexGzmY00K52d10PayCevtOUZdSfa2ReZA6Ow8rGUQWKdyEaRQrGEPTpmrMYc1Chh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiVhZ2Igcjxkdj6TfEFopdokjLHnvKSmgCzVypJeM/E=;
 b=k/x8Mtwqg8uMJ5kcXIo650gMC2fVRlASwdilRWMdffeigYA4uFFCiFQJ9u2kubBrCLndt1CchDHHFXC4XfrtPZWkmLkwYnboPAkMfESFFeaHLzTmL6RIIRRNT38aMYEl3eZ5F7HOZctxk2P0z5W5ZIW3HuTXWv6cRGfWC5MNnQo=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:22:21 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.8943.029; Mon, 28 Jul 2025
 08:22:21 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>, "P, Thiyagarajan"
 <Thiyagarajan.P@amd.com>
CC: Tetsuya Mukawa <mtetsuyah@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/null: Add fast mbuf release TX offload
Thread-Topic: [PATCH] net/null: Add fast mbuf release TX offload
Thread-Index: AQHb5TPW2mAQt//tPke2C+LG9hhrtLQVfHiAgAAbZoCAAU7z8IAtGdkwgANmQtA=
Date: Mon, 28 Jul 2025 08:22:20 +0000
Message-ID: <PH7PR12MB859613225A268B04509339DC825AA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
 <20250626070557.33058157@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD49@smartserver.smartshare.dk>
 <PH7PR12MB8596D3BC8FA4C87CCA08FFE08245A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDC7@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDC7@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T08:21:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SJ2PR12MB7943:EE_
x-ms-office365-filtering-correlation-id: 41033025-b829-41e2-80bc-08ddcdafdf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c3duM0lURXphYlVZUUNVVG8rQkd3cXhvSEp3bXBCYkJtZSszWkJMY1Bta2hH?=
 =?utf-8?B?SEIxTUdYdjM3NlZLNk9KOG81Zmt4dDVLMFhKc3dzYmowdnk1dlIyc1huRlNE?=
 =?utf-8?B?TUlNTmlVa1o4YmlxMGtsbFFPOGR4bEdCRmVobjNYMm4zUlpKUGwzMXFoWElZ?=
 =?utf-8?B?bnVXbHdTRGVGcGRVUUhOakZkTWxsUThORE1rVll5cjR2cW42MER0WTRKQjJh?=
 =?utf-8?B?VmVrMnU4Z2QvVGdzUDN6ZzRiVktZTkNhWWNpdVBYSGJBeHBIU3lFQWNCc0Rt?=
 =?utf-8?B?TjkxeUZWeXFnVWpaa3ZRS2o5SGErNDQydmhtL01jWjZnejUzTE41bVZSZmV2?=
 =?utf-8?B?bVFjaldBOUdoWmFUd2xFSFpQQXBOVlNyVFBXRzVBeVVEekRnNDFkOWFvdzZy?=
 =?utf-8?B?Q0trazhlYTRyZUl3K1YrdUdXYVhBQzhFckJYWHFReXVyWHkrMWZWTU1lWGdO?=
 =?utf-8?B?ZkRSSUdnRmxUTHoxQS9QMHhWd0x6N0tBc1phcllsUExFeHppcjNZRDNxZlVw?=
 =?utf-8?B?YUQ1NzN0MitOVjIyMFIvOHhQVGJ3ckpIazF2ZW5UdHB6aTMva0xKSUttUU1Z?=
 =?utf-8?B?Q3VRR2tTVk1TbjdJYjhIVDQvaXZjdFk3SThsM3gvamdza3FwZGd0eStwSlhv?=
 =?utf-8?B?SmtFK012WUFCK0EyTkkzd2QrLzdPRkNKR0RKMjUyTHdhdVpML21DeUxlNVVv?=
 =?utf-8?B?aWRGVHo5TG5sUytQRXh3TVlaM1UxMkRCdEZRQVRiaTVoVERRdWsrOENnaDJN?=
 =?utf-8?B?RUY3ZmlOVjBscS9ZY1o2ZU9jSHBYSmI5UTlUdUpDaE41eGpocEd3akxxa29i?=
 =?utf-8?B?RHM1MmpXcGduQXVkUFY2UEIwMUQ1TFd2VWV6dXA0eUhxUCtTaHgzSk9Jekt3?=
 =?utf-8?B?bWt2cU1Zci9OT21qMUwxMWJNRkxERlFrT2I1Z2g2bHZMay9LbnF5WDdVQXU1?=
 =?utf-8?B?VXFHaHB5Mno4elVYM285QWxVQzVqVzdvWGxhMkxUbzVNWkhFMS9PUm84ZWNV?=
 =?utf-8?B?My9rMVhOdWhxb0pxNmpGNnVKK2w2dG93VEpITEp2WGpDemZqekp4cS9mNVhB?=
 =?utf-8?B?MFZ3R1Z6TEh2R2YzajlMb2VYQm5KYVhEQzBCTUpvbUJwdVRqYWNqZlBlajMx?=
 =?utf-8?B?TlhUWHRZKzlxU3hCY1QxSGQrVWwxWGlabGg3SzNOUTJUQklReG50elZncjhz?=
 =?utf-8?B?djBacWwwNWNTV2F3MTJSZUJXVnBwMVZOWmc3WjJ6V3FlNSttNW9zclNIcG9I?=
 =?utf-8?B?L0RZUmY1YlhXclBCSVJNMk1DTkVTcmQ4eWxCRXVFVks2c0ltd0MrUS9TOEtF?=
 =?utf-8?B?VnkyTUF1WmJmVml0bmpaU2Q3bk9xQ2VzdmtUWWtRaEpWbCtPS2djQzJFd01U?=
 =?utf-8?B?cjUrQTg4ZTRaMjRkMmVZUDdyNEZ2MzJBNGd0d1I5bjRvUEg1eWhZNWl2aXNp?=
 =?utf-8?B?ekFVUktzQit5VDVBaE9EY0xoVFlSZlZsU2dXNVdXaWJJN1BWTEhUNmtvaGxT?=
 =?utf-8?B?RGpWN0J4S2hGTmVDR3l0UTkraWorKzBDNnFxalc1RTAxK3FVT0lwRGlIeXdh?=
 =?utf-8?B?bEZNTFlqQnk5UlF6ZHIzNCsyKzNIMlhVVTNxa096T3RHaHFad0JGc1puZ0ty?=
 =?utf-8?B?SzluK3BFS3FiL1EvY25EMFN4bkRWZ1YxTFVSM2szajA5RGlRR0pQT2ZLSmZH?=
 =?utf-8?B?d1gvRFNVTnZMbTNMMCtTazRDQnk4cmEzNEVmNHlwU3p3Q0hlWGhhVVpOMzhY?=
 =?utf-8?B?MVBBTkU0VkJnL1ZHQlRzT2h6Y1FuUys5UVNOdVVDdWlIK2NSRzc2UVBOdkZv?=
 =?utf-8?B?ekpaMWhDU3VhcWI3aitjdVlZTDI1NzhFTloySGFFL2d1T281SkdYV2hVdFI2?=
 =?utf-8?B?c3RRSjZVcFdtMVJ6blovdmFrWWg5aFpTM2hHandIcjM2cVBRK0dvKytyYmgw?=
 =?utf-8?Q?Ywc+RbB+5uo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1Y0ZHRoR3k3aVJyT2tzMVE2WU9hV0ZQN0xLWURFY21BVmpRUXlXakFCSElh?=
 =?utf-8?B?bjM4aEJpWFlsYmlUYi9uWVRHa0RjY1o4a21sK2QzQi9NcGRVYnhPMDg4Nk9G?=
 =?utf-8?B?UC9WbVNLUnJrMVluTVRtQk5UMmJ0Smp6UjE3dEppWEJPYlhFTzhiWnlJWTYz?=
 =?utf-8?B?UE8rT0J6d2NzcG9RQUhwTkJmVzhybjJrNFJxWFRITVFUQXM0MzQ3V1haSnBR?=
 =?utf-8?B?b0JTa2hzSXZYZnM2TitlY090YTV2NWRSTVhQSWtUOVRoMEtTV2xqUXp2MUdV?=
 =?utf-8?B?WEhLc29qMEVkek9ESnhCazhEbUczWHNnZm5BbCtoVjV5azlFQ3RZWU9MRUtl?=
 =?utf-8?B?M25XUEEyODV3NUdvK0UwaGd6Vlo2T1BVemp2TnpQUkRWZ3NQT3JBOXFaSTJn?=
 =?utf-8?B?N0JWaktZUERVUXdMRVNZc2J5Q01Kdno2WDFYc1Yxa1pwbndzYWMwaEt6WmJM?=
 =?utf-8?B?R0crMWh1bHdmQlRLN1B3QTVoUE5DVk4zUHhmcW9MaXZDMDhRYUhnRCtIUWhi?=
 =?utf-8?B?N001S2NCQmtkamt5eTgrQlNRbXE2NG5uRFYyamEwYWxIaStvc0pMZWVPRFZu?=
 =?utf-8?B?NjJqY0JWM1ZkYUFTOWZINlFPYTUrbStTMFZFV1JNcWdqQWN6SUpiTjBWOVMv?=
 =?utf-8?B?RVNzWEJ2V2lkWWFOUnRJajNUVXVJUUJSbm9HaVgxdDVVUHpQRWZrT0RSL2xZ?=
 =?utf-8?B?VldzQ2VqTlBLRlFUVzJzOFQrSWI5RndHaFhrc3NEdjVhRzZaTEJKMm1zQ3RF?=
 =?utf-8?B?a0xoNm8yaUQzbDhvaXhnMDhaZHVYRUttZXdWaXFrRnZscElxSUlYdDRYL0Jy?=
 =?utf-8?B?K0ViY1Z3Z1h3bTMxbE1tRmhGaFFzYjVoUS9QY3oxNnE1NjQxTlVMOTBvbERZ?=
 =?utf-8?B?OUZrRTFUWDVWT1BUSUtjNEd1VzNWVFRxZ1NFN0d6c003enJobm5OK1RmNnBV?=
 =?utf-8?B?V25kanFuLzZFRjFxY09MdVIxbWE2T3gzdzVWV1VMZERpeTY2b2h0bnY2NllZ?=
 =?utf-8?B?d1JsMXV5SVhUbFV5WHBVb0JISWM1TUV2alVRSWY5V3ZyVFlBVU5yaXBKYnRD?=
 =?utf-8?B?N3RabmFhWUd4RUl0ZlFJUWQranFvcnNJZU1RVkx2K3E3Z2dOQU5KKzR4RjBi?=
 =?utf-8?B?RW5jME51NksxZzZyeDd1MDk4RUdBVWtkTExpS2R3cVdOUjQyaDMvWGxLeVVL?=
 =?utf-8?B?RjgyOG94TCtzSnl4bG4zUnZ3WlhWbGM1L0d1Tk9oYTRlelNkcm5nY1JCcGxX?=
 =?utf-8?B?dCtTSTNNM1pMREd2SzQyOVIxR2xiNXRFSHZqc25NSityanlZaFRTYlR1RUNJ?=
 =?utf-8?B?N3huSlFkaE1JeVN5b3RyeEVzZGJnMEh6VmdLTzNGV2I2WUF3TzZseGdQZW85?=
 =?utf-8?B?THRaRE83ZnFxdnk1MWR1T3IvQXhnWWFscURrdkFqQ242K1ZiK0NNRUt5TWVu?=
 =?utf-8?B?dVl2bmZtblFQNkUxejNPNXRDRWNLWngzYll4OUlBbkFUUHNMei9YekJoNE1L?=
 =?utf-8?B?NTUwOTBFWnArMEROb0hjVjRZR0VoSW1rL25MbXFkYTZjS2hSNHdPR3EwSS9H?=
 =?utf-8?B?Umd3ZkF6akRrWWxmSWM4Q2g0SXRrWWczQnR6ZVN6ekZnTHNHK1h1VFVYcW5t?=
 =?utf-8?B?MFMzdUtNTTI5ZUhma3RTRWd1Q0FLVWRtN3VCWDBIUzF0TUF1dTJDUE1JbzI0?=
 =?utf-8?B?RkI4TElBRHNTRHNCanN2Q2VnLzZRMXF6REpGVGxSazJ5UVQrMUxycnZzQ1dw?=
 =?utf-8?B?aDQ3dDh2Q2lCcHYyRFRRY05ubG9hUUtRWTdvUktCRFdzTGJrd3Q2QTBVdlpV?=
 =?utf-8?B?MlJnQjRDb1htYlZSb2pKS3Azanh2MnY2eGhuUGlCdHdLMnQ5Q3RVVDNlNVQy?=
 =?utf-8?B?bFpuZkVEelE0ZjJZN3pjNTE4TmpqZEpqV3pWOFBDek5xWVlRMTVpdG90M3lj?=
 =?utf-8?B?OFNIK3pzMkl3TXMxMTcxMHFGZ1hOd21PUGgyR21mSC83TXdPMHF6alJOV1A0?=
 =?utf-8?B?dGNmdjNZcWQrR0FrWGZINmZOMnZtWmNacWY0TEJ5MXBjejNCVllqcis0Q09z?=
 =?utf-8?B?NytxQVIvWnNYZGdxTkx4eUxCbWZSL21pM1hQZFc4RXlZT3NJUlVZclZOMEQ4?=
 =?utf-8?Q?8w7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41033025-b829-41e2-80bc-08ddcdafdf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:22:20.9905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP0f2H04JBhizgiD8vohQoKncLGkqAz9e6lqaefh7922k/bLPH7gDxhkMC1HaXJZfVREBcoLi3yeVNAki6uSjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KU25pcHBlZA0KDQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IEhpIE1vcnRlbiwNCj4gPg0KPiA+
IFdlIGhhdmUgdGVzdGVkIHRoZSBlZmZlY3Qgb2YgdGhlIHBhdGNoIHVzaW5nIGZ1bmMtbGF0ZW5j
eSBhbmQgUFBzIHZpYQ0KPiA+IHRlc3RwbWQuDQo+ID4gUGxlYXNlIGZpbmQgb3VyIG9ic2VydmF0
aW9ucyBiZWxvdw0KPiA+DQo+ID4gIC0gRFBESyB0YWc6IDI1LjA3LXJjMQ0KPiA+ICAtIGNvbXBp
bGVyOiBnY2MgMTQuMg0KPiA+ICAtIHBsYXRmb3JtOiBBTUQgRVBZQyA4NTM0UCA2NGNvcmUgMi4z
R0h6DQo+ID4gIC0gYXBwIGNtZDoNCj4gPiAgLS0gT25lIHBvcnQ6IGAgc3VkbyBidWlsZC9hcHAv
ZHBkay10ZXN0cG1kIC1sIDE1LDE2ICAtLXZkZXY9bmV0X251bGwxDQo+ID4gLSAtbm8tcGNpICAt
LSAtLW5iLWNvcmVzPTEgLS1uYi1wb3J0cz0xIC0tdHhxPTEgLS1yeHE9MSAtLXR4ZD0yMDQ4IC0t
DQo+ID4gcnhkPTIwNDggIC1hIC0tZm9yd2FyZC1tb2RlPWlvIC0tc3RhdHMtcGVyaW9kPTFgDQo+
ID4gIC0tIFR3byBwb3J0OiBgIHN1ZG8gYnVpbGQvYXBwL2RwZGstdGVzdHBtZCAtbCAxNSwxNiwx
NyAgLS0NCj4gPiB2ZGV2PW5ldF9udWxsMSAtLXZkZXY9bmV0X251bGwyIC0tbm8tcGNpICAtLSAt
LW5iLWNvcmVzPTIgLS1uYi1wb3J0cz0yDQo+ID4gLQ0KPiA+IC10eHE9MSAtLXJ4cT0xIC0tdHhk
PTIwNDggLS1yeGQ9MjA0OCAgLWEgLS1mb3J3YXJkLW1vZGU9aW8gLS1zdGF0cy0NCj4gPiBwZXJp
b2Q9MWANCj4gPg0KPiA+IFJlc3VsdCAxIHBvcnQ6DQo+ID4gIC0gQmVmb3JlIHBhdGNoOiBUWCBN
UFBzIDExNy42MSwgUlgtUFBzIDExNy42NywgRnVuYy1sYXRlbmN5IFRYOg0KPiA+IDE5MThucywg
RnVuYy1sYXRlbmN5IGZyZWUtYnVsazogMjY2N25zDQo+ID4gIC0gQWZ0ZXIgcGF0Y2g6IFRYIE1Q
UHMgMTE3LjU1LCBSWC1QUHMgMTE3LjU0LCBGdW5jLWxhdGVuY3kgVFg6DQo+ID4gMTkyMW5zLCBG
dW5jLWxhdGVuY3kgZnJlZS1idWxrOiAyNjYwbnMNCj4gPg0KPiA+IFJlc3VsdCAyIHBvcnQ6DQo+
ID4gIC0gQmVmb3JlIHBhdGNoOiBUWCBNUFBzIDExNy42MSwgUlgtUFBzIDExNy42NywgRnVuYy1s
YXRlbmN5IFRYOg0KPiA+IDE5NDJucywgRnVuYy1sYXRlbmN5IGZyZWUtYnVsazogMjU1N25zDQo+
ID4gIC0gQWZ0ZXIgcGF0Y2g6IFRYIE1QUHMgMTE3LjU0LCBSWC1QUHMgMTE3LjU0LCBGdW5jLWxh
dGVuY3kgVFg6DQo+ID4gMTk0Nm5zLCBGdW5jLWxhdGVuY3kgZnJlZS1idWxrOiAyNzQwbnMNCj4g
Pg0KPiA+IFBlcmYgVG9wOiBkaWZmIGJlZm9yZSB2cyBhZnRlciBzaG93cyAxMy44NCUgdnMgMTMu
NzklDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogVGhpeWFnYXJqYW4gUCA8VGhpeWFnYXJhamFuLlBA
YW1kLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IFZpcGluIFZhcmdoZXNlIDxWaXBpbi5WYXJnaGVzZUBh
bWQuY29tPg0KPg0KPiBUaGFuayB5b3UgZm9yIHJldmlld2luZyBhbmQgdGVzdGluZy4NCj4NCj4g
Pg0KPiA+IENsYXJpZmljYXRpb24gcmVxdWVzdDogYHdpdGggZmFzdC1tYnVmLWZyZWUgb24gc2lu
Z2xlIHBvcnQgd2Ugc2VlDQo+ID4gZnJlZS0gYnVsayByZWR1Y3Rpb24gYnkgLTducy4gQnV0IG51
bGxfdHggaW5jcmVhc2UgYnkgKzNucy4gVFggUFBzDQo+ID4gcmVkdWN0aW9uIGJ5IDAuMDcgTXBw
cy4gSXMgdGhpcyBhbm9tYWx5IG9mIG51bGxfbmV0IFBNRD9gDQo+DQo+IEkgaGF2ZSBmaW5hbGx5
IGZvdW5kIHRoZSBidWcgaW4gbXkgcGF0Y2g6DQo+IEl0IGFubm91bmNlcyBkZXZpY2UtbGV2ZWwg
Y2FwYWJpbGl0eSBmb3IgRkFTVF9GUkVFLCBidXQgaWdub3JlcyBkZXZpY2UtbGV2ZWwNCj4gRkFT
VF9GUkVFIGNvbmZpZ3VyYXRpb24sIGFuZCB1c2VzIHF1ZXVlLWxldmVsIEZBU1RfRlJFRSBjb25m
aWd1cmF0aW9uDQo+IGluc3RlYWQuDQo+DQo+IER1ZSB0byB0aGlzIGJ1ZywgeW91ciB0ZXN0aW5n
IHByb2JhYmx5IHNob3dzIHRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgbm9uLQ0KPiBGQVNUX0ZSRUUg
Y29kZSBwYXRoLg0KPiBUaGUgYWRkZWQgY29tcGFyaXNvbiBmb3IgRkFTVF9GUkVFIChjb2RlIHBh
dGggbm90IHRha2VuKSBtaWdodCBleHBsYWluIHRoZQ0KPiBudWxsX3R4ICszbnMgaW5jcmVhc2Uu
DQo+DQo+IEkgd2lsbCBzZW5kIGEgdjIgcGF0Y2guDQoNCldpbGwgY2hlY2sNCg0KPg0KPiA+DQo+
ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgMjQgSnVuIDIwMjUgMTg6MTQ6MTYgKzAwMDAgTW9ydGVu
IEJyw7hydXANCj4gPiA+ID4gPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+ID4gQWRkZWQgZmFzdCBtYnVmIHJlbGVhc2UsIHJlLXVzaW5nIHRoZSBleGlz
dGluZyBtYnVmIHBvb2wgcG9pbnRlcg0KPiA+IGluDQo+ID4gPiA+ID4gdGhlIHF1ZXVlIHN0cnVj
dHVyZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1vcnRlbiBCcsO4cnVw
IDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IE1ha2VzIHNlbnNl
Lg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC9udWxsL3J0
ZV9ldGhfbnVsbC5jIHwgMzANCj4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvbnVsbC9ydGVfZXRoX251bGwuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L251bGwvcnRlX2V0
aF9udWxsLmMNCj4gPiA+ID4gPiBpbmRleCA4YTliNzRhMDNiLi4xMmMwZDhkMWZmIDEwMDY0NA0K
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMNCj4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL25ldC9udWxsL3J0ZV9ldGhfbnVsbC5jDQo+ID4gPiA+ID4gQEAgLTM0
LDYgKzM0LDE3IEBAIHN0cnVjdCBwbWRfaW50ZXJuYWxzOyAgc3RydWN0IG51bGxfcXVldWUgew0K
PiA+ID4gPiA+ICAgICBzdHJ1Y3QgcG1kX2ludGVybmFscyAqaW50ZXJuYWxzOw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gKyAgIC8qKg0KPiA+ID4gPiA+ICsgICAgKiBGb3IgUlggcXVldWU6DQo+ID4g
PiA+ID4gKyAgICAqICBNZW1wb29sIHRvIGFsbG9jYXRlIG1idWZzIGZyb20uDQo+ID4gPiA+ID4g
KyAgICAqDQo+ID4gPiA+ID4gKyAgICAqIEZvciBUWCBxdWV1ZToNCj4gPiA+ID4gPiArICAgICog
IE1lbXBvb2wgdG8gZnJlZSBtYnVmcyB0bywgaWYgZmFzdCByZWxlYXNlIG9mIG1idWZzIGlzDQo+
ID4gZW5hYmxlZC4NCj4gPiA+ID4gPiArICAgICogIFVJTlRQVFJfTUFYIGlmIHRoZSBtZW1wb29s
IGZvciBmYXN0IHJlbGVhc2Ugb2YgbWJ1ZnMgaGFzDQo+ID4gbm90DQo+ID4gPiA+IHlldCBiZWVu
IGRldGVjdGVkLg0KPiA+ID4gPiA+ICsgICAgKiAgTlVMTCBpZiBmYXN0IHJlbGVhc2Ugb2YgbWJ1
ZnMgaXMgbm90IGVuYWJsZWQuDQo+ID4gPiA+ID4gKyAgICAqDQo+ID4gPiA+ID4gKyAgICAqICBA
c2VlIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRQ0KPiA+ID4gPiA+ICsgICAgKi8N
Cj4gPiA+ID4gPiAgICAgc3RydWN0IHJ0ZV9tZW1wb29sICptYl9wb29sOw0KPiA+ID4gPg0KPiA+
ID4gPiBEbyBhbGwgZHJpdmVycyB0byBpdCB0aGlzIHdheT8NCj4gPiA+DQo+ID4gPiBObywgSSB0
aGluayBtb3N0IGRyaXZlcnMgaGF2ZSBzZXBhcmF0ZSBzdHJ1Y3R1cmVzIGZvciByeCBhbmQgdHgN
Cj4gPiBxdWV1ZXMuIFRoaXMgZHJpdmVyDQo+ID4gPiBkb2Vzbid0IHNvIEknbSByZXVzaW5nIHRo
ZSBleGlzdGluZyBtZW1wb29sIHBvaW50ZXIuDQo+ID4gPiBBbHNvLCB0aGV5IGRvbid0IGNhY2hl
IHRoZSBtZW1wb29sIHBvaW50ZXIsIGJ1dCBsb29rIGF0IG1idWZbMF0ucG9vbA0KPiA+IGF0IGV2
ZXJ5IGJ1cnN0Ow0KPiA+ID4gc28gdGhlaXIgdHggcXVldWUgc3RydWN0dXJlIGRvZXNuJ3QgaGF2
ZSBhIG1lbXBvb2wgcG9pbnRlciBmaWVsZC4NCj4gPiA+IEFuZCB0aGV5IGNoZWNrIGFuIG9mZmxv
YWQgZmxhZyAoZWl0aGVyIHRoZSBiaXQgaW4gdGhlIHJhdyBvZmZsb2FkDQo+ID4gZmllbGQsIG9y
IGEgc2hhZG93DQo+ID4gPiB2YXJpYWJsZSBmb3IgdGhlIHJlbGV2YW50IG9mZmxvYWQgZmxhZyks
IGluc3RlYWQgb2YgY2hlY2tpbmcgdGhlDQo+ID4gbWVtcG9vbCBwb2ludGVyLg0KPiA+ID4NCj4g
PiA+IE90aGVyIGRyaXZlcnMgY2FuIGJlIGltcHJvdmVkLCBhbmQgSSBoYXZlIHN1Ym1pdHRlZCBh
biBvcHRpbWl6YXRpb24NCj4gPiBwYXRjaCBmb3IgdGhlDQo+ID4gPiBpNDBlIGRyaXZlciB3aXRo
IHNvbWUgb2YgdGhlIHRoaW5ncyBJIGRvIGluIHRoaXMgcGF0Y2g6DQo+ID4gPiBodHRwczovL2lu
Ym94LmRwZGsub3JnL2Rldi8yMDI1MDYyNDA2MTIzOC44OTI1OS0xLQ0KPiA+ID4gbWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tLw0KPiA+ID4NCj4gPiA+ID4gSXMgaXQgZG9jdW1lbnRlZCBpbiBldGhk
ZXY/DQo+ID4gPg0KPiA+ID4gVGhlIFJURV9FVEhfVFhfT0ZGTE9BRF9NQlVGX0ZBU1RfRlJFRSBm
bGFnIGlzIGRvY3VtZW50ZWQuDQo+ID4gPiBIb3cgdG8gaW1wbGVtZW50IGl0IGluIHRoZSBkcml2
ZXJzIGlzIG5vdC4NCj4gPiA+DQo+ID4gPiAtTW9ydGVuDQoNCg==
