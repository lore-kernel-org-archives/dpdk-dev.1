Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B8C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 05:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0499240666;
	Mon,  9 Jun 2025 07:31:30 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by mails.dpdk.org (Postfix) with ESMTP id C190B40661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 07:31:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoCeWPK3BFmqkmOC9kyMKtWHpimddL88rEbZsMFFRGKcBqlQtle3lu/gqm09S86d8CY8+4TyzsN5z3VQUqq/nnzvGsnnVewU6P4gMosF/07pjPvgtQan9HDGXYJO2ImHAKB7h3kqnefxjWJNZz6fUUQvtzuM3tXGZ8iaxSLJJN6WzfD4hNcgyDHVXBdMcOpySsQ+NgVgXFUBpgrxu/zyaFU+7k2WaGvUAwTehf8+ZQ1fNbcTTQAbBXZPabm/wrKjD6MVWyOmJt/p1bFJAduMoFmjtU1BgC3mp1LbN3RRt8TsWYppMFI6i129dkpsRSAd8C1706RCHEr9diGKFOR/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RWQrlqS5ry9qRad5RvplrGARnL6aPeVXWvy2c1FzQU=;
 b=xoWHsy+hwYLfT5GxRyaZ0/Lugi/9ffKBdGU1XtokkTXe1dguHirwQupDJ5eEvuauepQVNf1Wtu/mbY6AsOWIUx6zAwSAYzo6rtjLl13K/JRt9KaeJqHzmwSD0/SXKJMo2kPjVGem5JODEoFVmhQrhuFDKAgqFeKIjmmRzwpSSCV8GnUQUmVXdnKHiteC5XAFt1xSsFHHbPbi6tEAJQ2DSnDJ05yH0FO9EKQ3oD9j227FpRETET6IGTJndgMZ2c3DreuUfPvLYnS1qyjx9qQK2rq0s07i7QLx76mauv1Tdv+CkKOMHmVM5zOcjJHEsZBfkBP5K0sBo3+eOeZwruMq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RWQrlqS5ry9qRad5RvplrGARnL6aPeVXWvy2c1FzQU=;
 b=VITbwo4Grul7b3gOkPi95hm7mTLgcjs2RzswtxL56y96imfL+9+HpV3aOn7X8AvK68oaRyyQGf7nlRsBeVLa38R0tcTIpsGLOry1p+WvBMSicBQq8PQdxadATlmRlfqSF9V+VJ/pnuwBjijX2BoxBLrR69QTJEu6iUEGN2Zk35A=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 05:31:25 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 05:31:25 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v5 00/11] remove component-specific logic for AVX builds
Thread-Topic: [PATCH v5 00/11] remove component-specific logic for AVX builds
Thread-Index: AQHbnZ9tcNdZ/15d/k64SuBdhLahrLOFNAuAgHWOUpA=
Date: Mon, 9 Jun 2025 05:31:25 +0000
Message-ID: <PH7PR12MB8596A2F5F6F979FF88D54C53826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
 <CAJFAV8zhNmSujARaW+UfFt2hn_szBqTZiCJoBqymOEGxvfWtwQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zhNmSujARaW+UfFt2hn_szBqTZiCJoBqymOEGxvfWtwQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3d7dc253-c2cf-4d4b-bb17-ea8b38321227;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T05:24:53Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CY8PR12MB8339:EE_
x-ms-office365-filtering-correlation-id: 7342ef5c-b79b-44c6-6614-08dda716e0b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWFFM0lVcGp3Nk9PaWI5L1lUTUUyWERIa3NVdHQ1WkZUYlZqL2RnVHYvdjVq?=
 =?utf-8?B?bkxMUEVIOVE3MkxTSElXWVNZRXVaMzd3cDNZb2RmSGRMSmdXdnVDY05JbjVP?=
 =?utf-8?B?MnU3bzkreTA4TmVVV0pkamptclBhZjRWN2lCWmNoUUtYU0FrTWxGc3F3Y0tM?=
 =?utf-8?B?SE5UNCtHd3V5eGdCZXk1ZElsWDVXVFQrREtISlBhWmVZVHhCLzVpQ2FMWmVC?=
 =?utf-8?B?QzVrbnpDUVk0RUFGQzcxUCtBZFlyVGVWY3U1THllbDVHbllqeU5sVHE2dzlr?=
 =?utf-8?B?ZU43dmRZVGQ4S2ZrUE55MUJ3MFR2TGUyMU1BbEdGMlJBY3VHYmd2T0FDL0Y2?=
 =?utf-8?B?eTFhZHNvanFFMDNvUTk2dkNCL0xhYnlWVzl6SS9zK3JqRlB6VWlXS2VrUUFt?=
 =?utf-8?B?WjlRME5HOTR1bVZsV0xrOUF2Nm5TY24zcXM0K0VsalhwdnJ5Q1VSM09YVG91?=
 =?utf-8?B?eHhnd2lva3BqbGtpUWd0bUZhVHBBbGR5R2hjN1A4aUR1ZnlDZExlb2wwVFRX?=
 =?utf-8?B?K3JaUmlmbHdOT2d1UWQ0TDZJYnIwM3NQM0NDSm1JcG50OWhQUFRJaVpsT0J1?=
 =?utf-8?B?UFk5RVg2UUtwYU00SnVCTkNzWFA3aDB1a0dHeFZEYzZGWDRtZENTRmFWWUR2?=
 =?utf-8?B?RENNK0JWbjFWaFNoTTQzbG1XQm9KRlloa0RBUGcyT3RQckl5c21Rcmt4KzUz?=
 =?utf-8?B?TGt5bWZSeTVWN09GQWF0NzU5U1Bnd0VVNnRuRkJSdng5RncvdHlYQmxJMlZM?=
 =?utf-8?B?eWdRYzJrV1hSWDJrbk53UGZvazY1ZjFzaXBaZFBUTTRENXVZTDRabWM3UFcw?=
 =?utf-8?B?MXpRYXF6L3FpdmpGcmtubW5qYlZMcTF2T2gycHNKUk0zSGVxdklFMENkRE9K?=
 =?utf-8?B?VzZmSks2elROWTQ0cWVTN3R0cHE2dEFqUGlRcSttM2FHS05CZmFvWWJOak4x?=
 =?utf-8?B?c3p2VzBQWlRLNUZtSnl6Zy9COUI2TWRlelJYSjcwYXNjblJuSmNRSU1nSlov?=
 =?utf-8?B?UXB0TXRMakZqcUJrcy9lSytvYVowei80OE1CL0RpZVpHcTZGSk9vZ2U4ZVc4?=
 =?utf-8?B?UnNYZHQyTSsvY2RnczMwcTRSdHpuUkxoSGVJcUVoQm9WWmJXZGpaSGVwZzN0?=
 =?utf-8?B?M2NlNExraXVONlBNK0pnY1liaHBiRUZWU2Fxa0IwOHhnK25RNzA4YjNJSVd5?=
 =?utf-8?B?WjJXU3NOYjNEb0puWGtYU0VOUWNxMFVGUDl1L3hwYkpJenZEMzJMSXhIb1Ur?=
 =?utf-8?B?VGl4WEJtYStrT0pFQmhnWWdibEpiQXIrMVFQdjJpZmMwYThObklTQ2lQTmpU?=
 =?utf-8?B?dTh3UlZOcXFuaGNCQ1ZpQk82TGhJQ3Jac2djbXA3eUxZSUd5UzJoT1N2THpm?=
 =?utf-8?B?VldwUTFkN3FkS1JUaXg3WnBMUm5Sbkl2TXgvZElqYlBFZ2dYQWRYTFlQZyt0?=
 =?utf-8?B?d3E0TkhDbG14WU9KckdaZ21HYzFwZjZPVDJhUXdEVXlldGtzamgyQ1h6dnhD?=
 =?utf-8?B?YUNCZWZ4Nmdrd2NVZC92dllqcUlJQjQzVDdKbitmQ05ubTF1Titkb0ZQbFVP?=
 =?utf-8?B?STkvZDh1U3Y1UzVudndwZ0ZHdlhGNnRzREZZWnlWRkpqU2JGSXNOdVhyTEIv?=
 =?utf-8?B?enI0WC9pSVZvQWNnT0hENnpOQzRpQnZaWEpxV295bUtwR1RDeFNPUXpIR2ZO?=
 =?utf-8?B?UXk1by9xK0pSdXlBWUVKMzc3Sm9lTXB2TE5JUnR1L0RXdUZ6QmdYTlVXSGFB?=
 =?utf-8?B?dE5UTUZ0cjBROFNUdkNXakovTFowamxxNHFBUHlCRlJCV2RENC9paTZaNGg0?=
 =?utf-8?B?Uy9hcnEyUTVObDVvOUkxRzNuODlpYWc0ckFJWHVVYkR2NVpLUDVWTjZpenU2?=
 =?utf-8?B?VjlkSXlXT2xFZ1F6R2hHSmovZVMwZWhlSkNmVktOMlpRTHg3c3ZoemRtclYv?=
 =?utf-8?B?RCtVakZKRHZpWm5BQXpIOHJ0NlJTUFVUUStTOUhIVlFVWmlxakZyNTNEcDZW?=
 =?utf-8?Q?HnXs3KNS/7xw+xMTwsBDNtyZa8n6gc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE5UaXRCRVUxZGJ6cUR2eVgrVDAxMlNlQW1rZ0FlN3hxL2FFakpxd0J5bTc1?=
 =?utf-8?B?ZDNkLzNVaTZ5T0JmL241RkI5RFA3TVBlK2NvY2lYU0VKb0FzVkxLclp0d2dm?=
 =?utf-8?B?Zk5GRW8rVGR4Q2kvdThTTFRBeVM3TGsrUVU3SWhEcGYzUE9aMUpQUFJvdnVK?=
 =?utf-8?B?Rm1BclhhRzNpMVNNampoaVhPY0VtU2RrWm1hbGpvbTR1bTRqRExOMHhORFZJ?=
 =?utf-8?B?S3RBVXB5dU1qRlgwY3YrSFNKQjh3MUZrUCtXVmtTdFZ4dWM3TVB3dUdweGdL?=
 =?utf-8?B?VjdZNEQ1MElZUW1hZmJTckl4bE1lZkhpZFVBbm02aFB0L0ppMFcrNCtFV0hB?=
 =?utf-8?B?YlFjWVdISWFmOFE3czBGYno4cHpYcm5zTnVFMWZ4ZytkeGZNeHlqY1U5TjJa?=
 =?utf-8?B?clEvZnp2R3NrcFRGWElLdHNLNDk3ZkRZVG1adHJtcnVzL3JMTkFwbkZ2MXc0?=
 =?utf-8?B?NEZ1K05kTkpSd2JyOTZyOEswQndhMy9mcHVMbzFTWndLblEvK0lxVGd2dGRE?=
 =?utf-8?B?d0NLN1F0VVhDK29DR01oUlYydWo3OTg1Z3B0OHd0b1JCVjlONGVNYjN3cVRL?=
 =?utf-8?B?T2x2Ky9aZVYzUXFXYXVVZnUrMmJuOVE0UGtxNlE0VE5xZU96NGZxMGhBbEho?=
 =?utf-8?B?N0VtSGRjbGVaVkxvYytkSnpQT2YxVmNyemttSG5CS21QM0ZaWURoNDYyV2lT?=
 =?utf-8?B?QmFOMzBYdHMzZTZQcG5DZHJ1NnBkbTUrd0VYbkQwVE8zT0dYSmFSeEQ2dWhy?=
 =?utf-8?B?WmIzZjF4Z2ZRVzFUaFhKYkU2elBPTjF2WWlPYkRCUm5DMGYwbjN3cFQ5ZGJ4?=
 =?utf-8?B?NHZoNVBGSFlyZ2d2SjZhdWJmVjZSR1dzTlNyR01ETmY3d1VLMU5YRk42MS80?=
 =?utf-8?B?enFMQjhzUHMwRHVtUHJNNlNtL2t6OEdvUXhtSjhrODh3TkZsUjhhWm01SFJu?=
 =?utf-8?B?VW5rWVlGOXZCRExEZzJxSHJYamsxNzhWdktZMFVpNjMybkJoSG0wcTZSMnFp?=
 =?utf-8?B?OFdQdlRsUG93Z2RhYld0R2o4MGRlL2JFLzYvS282QisrR0VydHg2bUJuTUZy?=
 =?utf-8?B?d0x1c1pQMFppa0xLYkh4S0tCU1lsZHFOSngzQkppVWZyYXd1SFZyZXVmTlFj?=
 =?utf-8?B?K1VNRnpGZGF4VWtKSUtpYzNvVzJKUkFpeSt5Z2ZXcFYxb09CQ2JCWWlZUE55?=
 =?utf-8?B?L1EvbVBFV1BGd0hOV3A0dHlUOUc4Vk96SjlOcGhuNUZIclJOTzJsUTNIOFo4?=
 =?utf-8?B?S2N6Qm14Z1FNT3RlZWtzQUQraGluQnRVdFdiS29HSHlRN2JTdU4zMFVsaTBJ?=
 =?utf-8?B?MENxOHNrOUlxS082R3h5SWU0dGsvSEJEU3dvdklXR09MQ3lvTnFiOHBoMEkx?=
 =?utf-8?B?NTQwSlBNak9hTng5QjgyUlpNYTh4eUlqamp3QXJ6d1dFQkxOcVE5QmlJZXZv?=
 =?utf-8?B?Rzg3TVBCczFKdW90K3lTUUh3WDA3MjRaNm1hZjFWVEdjTkJTWWx4UU9lZDJ6?=
 =?utf-8?B?QUdkdStKUVpBZEZkSWREai80OEZiWHNkL0R6eG1ZNzBQZDJxNEV1d05CNjVO?=
 =?utf-8?B?OUtoLzEvWjVGMHNmMktTSzFqSkxYZDNZdDFGODhRaElTRVVXMTNWTk00S01V?=
 =?utf-8?B?KzF6RmtqMGQ1SjFhbUhUNnBTenQyRHh5QVNneGduZCtIbmZnNFgwV2tJdlMw?=
 =?utf-8?B?RSttaGloS09SamlQa29yWElrM1ViMnVyRW12aWhVY2dtcThSZzgySWFJS21o?=
 =?utf-8?B?UHluZGh1VkxKWStQYlRUMzg5WEVvUjYvMDVqa1o1NFNkM2FwM0VabmYydzdM?=
 =?utf-8?B?TGNXYkdSYkV0U0NMY0lOeDlXT3FlZ2RFZWhVYllHTkVFZkFqVFNMaElqaWpL?=
 =?utf-8?B?NlZNc3VWWUpWUG4vUTIxajRyYm5yTXo5K3pnOW5meGsxZmlvb1lpQyt5WlFs?=
 =?utf-8?B?RnlZRCtLb2Y3SDVyazBINS80VjRXZS9PeGNXU1VMYWowTzZQNlRhNHVQUlZn?=
 =?utf-8?B?UTBtTlBxYWcrUzZKSUxLd0gxSUFhSmJXN0wwSU0yd2dIUmZJL2Zic2lwa2Rx?=
 =?utf-8?B?Ync3VXdHc3Q1L21iMUE0OHhkamtqM3lWdEw1ckZZRk1OSGpQVWlXalJMaVVW?=
 =?utf-8?Q?OGnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342ef5c-b79b-44c6-6614-08dda716e0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 05:31:25.7210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVLX7byNuRsGnd86Gx3i2oMWfgNZPo5S5qbxXcnLdZ+Yg7PoHjKpcRHviS2xxe5gyhUThqXrwxvrOxRlO1SFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

W1B1YmxpY10NCg0KU25pcHBlZA0KDQo+ID4NCj4gPiBBIG51bWJlciBvZiBsaWJzIGFuZCBkcml2
ZXJzIGhhZCBzcGVjaWFsIG9wdGltaXplZCBBVlgyIGFuZCBBVlg1MTINCj4gPiBjb2RlIHBhdGhz
IGZvciBwZXJmb3JtYW5jZSByZWFzb25zLCBhbmQgdGhlc2UgdGVuZGVkIHRvIGhhdmUNCj4gPiBj
b3B5LXBhc3RlZCBsb2dpYyB0byBidWlsZCB0aG9zZSBmaWxlcy4gQ2VudHJhbGlzZSB0aGF0IGxv
Z2ljIGluIHRoZQ0KPiA+IG1haW4gZHJpdmVycy8gYW5kIGxpYi8gbWVzb24uYnVpbGQgZmlsZXMg
dG8gYXZvaWQgZHVwbGljYXRpb24uDQo+ID4NCj4gPiB2NTogZml4IFJURV9BUkNIX1g4NiBtYWNy
bywgd2hpY2ggYnJva2UgY3JjIGxpYnJhcnkNCj4gPiB2NDogcmViYXNlIG9uIGxhdGVzdCBtYWlu
IGJyYW5jaA0KPiA+ICAgICBtaW5vciBmaXhlcyBmb2xsb3dpbmcgZmVlZGJhY2sNCj4gPiAgICAg
bGltaXQgdXNlIG9mIC1tYXJjaD1za3lsYWtlLWF2eDUxMiB0byB3aGVuIHdlIGRvbid0IGFscmVh
ZHkgaGF2ZSBhDQo+ID4gICAgICAgLW1hcmNoIGZsYWcgc3VwcG9ydGluZyBBVlg1MTIuDQo+ID4g
djM6IGFkZCBwYXRjaCBmb3IgZXZlbnQvZGxiMiBBVlg1MTIgaGFuZGxpbmcuDQo+ID4gICAgIGFk
ZCBjb21tb24gY29kZSBmb3IgbGlicmFyaWVzIGFzIHdlbGwgYXMgZHJpdmVycy4NCj4gPiB2Mjog
YWRkIHBhdGNoIDQgdG8gcmVtb3ZlIHVzZSBvZiB1bm5lY2Vzc2FyeSBDQ19BVlgyX1NVUFBPUlQg
ZmxhZw0KPiA+DQo+ID4NCj4gPiBCcnVjZSBSaWNoYXJkc29uICgxMSk6DQo+ID4gICBkcml2ZXJz
OiBhZGQgZ2VuZXJhbGl6ZWQgQVZYIGJ1aWxkIGhhbmRsaW5nDQo+ID4gICBuZXQvaW50ZWw6IHVz
ZSBjb21tb24gQVZYIGJ1aWxkIGNvZGUNCj4gPiAgIGRyaXZlcnMvbmV0OiBidWlsZCB1c2UgY29t
bW9uIEFWWCBoYW5kbGluZw0KPiA+ICAgZHJpdmVycy9uZXQ6IHJlbW92ZSBBVlgyIGJ1aWxkLXRp
bWUgZGVmaW5lDQo+ID4gICBldmVudC9kbGIyOiBidWlsZCB1c2luZyBjb21tb24gQVZYIGhhbmRs
aW5nDQo+ID4gICBsaWI6IGFkZCBnZW5lcmFsaXplZCBBVlggYnVpbGQgaGFuZGxpbmcNCj4gPiAg
IGFjbDogdXNlIGNvbW1vbiBBVlggYnVpbGQgaGFuZGxpbmcNCj4gPiAgIGZpYjogdXNlIGNvbW1v
biBBVlggYnVpbGQgaGFuZGxpbmcNCj4gPiAgIG5ldDogc2ltcGxpZnkgYnVpbGQtdGltZSBsb2dp
YyBmb3IgeDg2DQo+ID4gICBuZXQ6IHVzZSBjb21tb24gQVZYNTEyIGJ1aWxkIGNvZGUNCj4gPiAg
IG1lbWJlcjogdXNlIGNvbW1vbiBBVlg1MTIgYnVpbGQgc3VwcG9ydA0KPiA+DQo+ID4gIGRyaXZl
cnMvZXZlbnQvZGxiMi9kbGIyX3NzZS5jICAgICAgICAgfCAgNCArKw0KPiA+ICBkcml2ZXJzL2V2
ZW50L2RsYjIvbWVzb24uYnVpbGQgICAgICAgIHwgMTYgKy0tLS0tLS0NCj4gPiAgZHJpdmVycy9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrDQo+ID4gIGRy
aXZlcnMvbmV0L2JueHQvYm54dF9ldGhkZXYuYyAgICAgICAgfCAgMiAtDQo+ID4gIGRyaXZlcnMv
bmV0L2JueHQvbWVzb24uYnVpbGQgICAgICAgICAgfCAxMCArLS0tLQ0KPiA+ICBkcml2ZXJzL25l
dC9lbmljL21lc29uLmJ1aWxkICAgICAgICAgIHwgMTAgKy0tLS0NCj4gPiAgZHJpdmVycy9uZXQv
aW50ZWwvaTQwZS9tZXNvbi5idWlsZCAgICB8IDI2ICstLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJz
L25ldC9pbnRlbC9pYXZmL21lc29uLmJ1aWxkICAgIHwgMjUgKy0tLS0tLS0tLS0tDQo+ID4gIGRy
aXZlcnMvbmV0L2ludGVsL2ljZS9tZXNvbi5idWlsZCAgICAgfCAyNSArLS0tLS0tLS0tLS0NCj4g
PiAgZHJpdmVycy9uZXQvaW50ZWwvaWRwZi9tZXNvbi5idWlsZCAgICB8IDI1ICstLS0tLS0tLS0t
LQ0KPiA+ICBkcml2ZXJzL25ldC9uZnAvbWVzb24uYnVpbGQgICAgICAgICAgIHwgMTAgKy0tLS0N
Cj4gPiAgZHJpdmVycy9uZXQvb2N0ZW9uX2VwL21lc29uLmJ1aWxkICAgICB8IDEzICstLS0tLQ0K
PiA+ICBkcml2ZXJzL25ldC9vY3Rlb25fZXAvb3R4X2VwX2V0aGRldi5jIHwgIDQgLS0NCj4gPiAg
ZHJpdmVycy9uZXQvdmlydGlvL21lc29uLmJ1aWxkICAgICAgICB8ICA5ICstLS0tDQo+ID4gIGxp
Yi9hY2wvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCA1NCArKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gIGxpYi9maWIvZGlyMjRfOC5jICAgICAgICAgICAgICAgICAgICAgfCAg
NiArLS0NCj4gPiAgbGliL2ZpYi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8IDE4ICst
LS0tLS0tLQ0KPiA+ICBsaWIvZmliL3RyaWUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYg
Ky0tDQo+ID4gIGxpYi9tZW1iZXIvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCA0NiArKysr
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgbGliL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAg
ICAgICB8IDM0ICsrKysrKysrKysrKysrKy0NCj4gPiAgbGliL25ldC9tZXNvbi5idWlsZCAgICAg
ICAgICAgICAgICAgICB8IDU4ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBsaWIv
bmV0L3J0ZV9uZXRfY3JjLmMgICAgICAgICAgICAgICAgIHwgMTYgKysrKy0tLS0NCj4gPiAgMjIg
ZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKyksIDMzMyBkZWxldGlvbnMoLSkNCj4NCj4g
VGhhbmsgeW91IEJydWNlLCB0aGlzIHNlcmllcyBsZ3RtLg0KDQpTZXJpZXMtUmV2aWV3ZWQtYnk6
IHZpcGluLnZhcmdoZXNlQGFtZC5jb20NClNlcmllcy1UZXN0ZWQtYnk6IFRoaXlhZ2FyYWphbi5Q
QGFtZC5jb20NCg0KVGVzdGVkIG9uOg0KU1VUIDEgJiAyOiBBTUQgRVBZQyA4NTM0UCA2NC1Db3Jl
IFByb2Nlc3Nvcg0KQ1BVIDogQVZYLTUxMiBFbmFibGVkLCBUdXJibyBCb29zdCBkaXNhYmxlZCBh
bmQgTlBTLTENCk5JQzogSW50ZWwgRTgxMC1DUURBMg0KRFBESyB2ZXJzaW9uOiB2MjUuMDMNClRy
YWZmaWMgZ2VuZXJhdG9yOiBQa3RnZW4tMjMuMDYuMS4NCk51bWJlciBvZiBQb3J0czogMg0KVG90
YWwgU3BlZWQ6IDIwMEcuDQpQYXRjaCBhcHBseTogMTEgcGF0Y2hlcy4NCg0KVGVzdGNhc2U6IHRl
c3RwbWQgaW8gJiBsM2Z3ZA0KVGVzdCBzY2VuYXJpbzogMkMyVOKAkzIgUG9ydHPigJMxUngxVHgg
c2NlbmFyaW8oNjRCIGFuZCAxMjhCIGJ1ZmZlciBzaXplcykuDQpTdW1hbXJ5OiBPbiBjb21wYXJp
bmcgdGhlIHJlc3VsdHMgd2l0aCBhbmQgd2l0aG91dCBwYXRjaCBhcHBseSBmb3IgYm90aCB0ZXN0
cG1kLWlvIGFuZCBsM2Z3ZCwgdGhlIGRlbHRhIHdhcyBsZXNzIHRoYW4gMSUuDQoNCg0KDQoNCj4N
Cj4NCj4gLS0NCj4gRGF2aWQgTWFyY2hhbmQNCg0K
