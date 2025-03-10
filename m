Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F25C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 22:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03CC540268;
	Mon, 10 Mar 2025 23:40:06 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11023136.outbound.protection.outlook.com
 [40.93.201.136]) by mails.dpdk.org (Postfix) with ESMTP id ED215400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 23:40:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYgSLFO0ERbBp32/SlHhg0qcnA+La4jdiu3I0SfoVg6TVBmM3JAtsL2FAKQeNKr/+Cr/RNF/8jAfZ0exTN2/x03UnWLyxpOLGEg4UzmBWx13J/V6MQ7hbU6FwPcC798UKss7h8w/tsZRHiplr50xjRQf10PnwlfA8E/9kTRqumfRQWBAwiYMaL66D/ew4IM0ZSOcTOTDaLVss1NOmcoig2t/mE8TTRIetLvkdTC4P8EuB18pijkqhjF2iXlYLPsewcv3KG3+hmMxPDhjIHlvLhCNKSDjM/QaAr8Q3ixG8uIuWEfU9o1HaJ64dSQakpdz5l7+euDgZqM2Qu+VC3W0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig9x4MB6i8WMeVrQkHU2Wg8LL64SRBWht3YZaqul/O4=;
 b=tGhxYUyEIz147Eh+R8MquLMWvD5fGaEyL2CtIEKmNgd/8dFtR1h6OdIHLJDjnjWnUe5ll3i6Mgw3g9ijv8vwF8MUkRmPFTd19Xby853wU/I2j7f5HEXx1n38DQRL3b1f1ITaZ/CjH6bv3ZlYbD6lP+xUmyd2xDgTmViqaQ77nYcYW7kTGmy0lL/wTnsCeQMDTy0mKq8T3YJYXOQZ/CqoWx4KIC/a/zreCRqN6M7QGg3sSKcXiCXgnm5e3kuTjTQrdiGC75c9Qdw4KPpgAczobNlmxn39rsw2g8JmLBUmlcyeeUhvqTdlQck0yqQ5eO6WKr1XIPepNNeOD+CBQcdrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig9x4MB6i8WMeVrQkHU2Wg8LL64SRBWht3YZaqul/O4=;
 b=M01TSBcv336TyKicMNGRz0/km951QanN6b53ibqBd8SUQilNxZs9vdkScWSGJIpnKElJbsLuyKavzyWnusNRj2udaeCK/n+PGSdFdVxeTRX/VLQRtm53HEijF+DIzbNGmeL84z1IHsNgyyLggl0cUCjPr/YtU0QgANmvxS/u6j8=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by DS1PR21MB4403.namprd21.prod.outlook.com (2603:10b6:8:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.11; Mon, 10 Mar
 2025 22:40:02 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Mon, 10 Mar 2025
 22:40:02 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Topic: [EXTERNAL] Re: [PATCH 6/6] bus/vmbus: set event for channel
 without monitoring support
Thread-Index: AQHbkdOVTOIUM5k3iE+I3xZQmH7qd7Ns9vwg
Date: Mon, 10 Mar 2025 22:40:02 +0000
Message-ID: <SA6PR21MB4231B291B44112C5892C5B6BCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
 <1740704941-1631-7-git-send-email-longli@linuxonhyperv.com>
 <20250310084617.353a082b@hermes.local>
In-Reply-To: <20250310084617.353a082b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e8f77a3-0be3-44ae-b335-a97ba0d5641e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-10T22:39:44Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|DS1PR21MB4403:EE_
x-ms-office365-filtering-correlation-id: 44d8c4f6-2a8d-4170-624d-08dd60247f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZytGTTNTNzJDMUgyYVFHMk9nQ1VCSEh1RnRLS1htTVMyNzNYU2IrTldJRU5v?=
 =?utf-8?B?MDdpZEhKL1ZDNVpXYlAzUHVHaUJLV3h2VHNkMGNJZE9XTGhpN3pYWWI2bEF4?=
 =?utf-8?B?Rkl4VkdYRGY1eXlsTXV3NzVjbFhNaGxwM2FYb0F5NGc3NlMxU3hvRENjNzRs?=
 =?utf-8?B?UU8rTnBBZnNtQ1BHRDYwc00rcm5yaVNjK280bkw2N3NDZWlmR2lrb1luQVh1?=
 =?utf-8?B?TFNRdkZDNVd6Y0YyQmlEdGJWek01a0pEaFhaWFgyakxwNEh6MGFCYjlqQlA1?=
 =?utf-8?B?b2Job29XSU9lRkJTRUU0T1RVK2JNNEpJU2ptOGVxeS9RdnJsRVViRjVmeGlR?=
 =?utf-8?B?NFdaaDhOblBQRFI5OGoxbjNDdFRCYWV5NDQ3eVh1TXY1Y3dRVFpIWkE1RGpj?=
 =?utf-8?B?emhWSWVOSzZ3WXNZWmZ3aXM2Z2xTU1ZTbFRIei93cTFVUjQ1RGd4WlhvVk5x?=
 =?utf-8?B?RGZMTFBHYmZnd2R6OTR6bWtZYittN2NheUF0cEphUllhZ3ljTlhEVnZxR2tT?=
 =?utf-8?B?aktMMEtyRmNTbUhCeEpjaW9kT3dOZkNhZWttV3QxVTlaeUcvY0ZmUGZnUHFQ?=
 =?utf-8?B?b0p0TTc4d1JBN3NnbGhPaXJNa0JCRTlRQVFNSEhCejdtelVxdmcrR1ZHMit0?=
 =?utf-8?B?Q2E2R0NyMVkyRnM4VnozWWFlNWNCU1UzN1kzR1ZaRE1UdzNnN0ZQbis5SFpX?=
 =?utf-8?B?THdUU2lEanU2UHBjZ05CRmhFOWZrM1JZQS9nMFJkdm16QUVlUEtnam4zQ041?=
 =?utf-8?B?SEllZ2FDQURmUkR5WDU1aVVsMHl4aXlSc2RxWGh6NWxNaU1mS0ZaZ2tWd3RV?=
 =?utf-8?B?WXFLNVo0VE1WNEVRUStSTStpK2hkMm53dmY4RU5qZnoxTkJmNTg0czBoSUVk?=
 =?utf-8?B?UHVyb2RxMWlPbVk0SGJMVm5GaFliMXZXL0RabmtFRFdPN2REeWdoMFN5cFMx?=
 =?utf-8?B?MzVyUzZubXVNVUJNZTFKYlJHbWt1aDRoRnNiYzJwdERqMmtDWnByODNrd1RY?=
 =?utf-8?B?eGZubmhJeHJvRXZQRTBmTzYzUGJpU1gzaHVzdmphck9QWTZsRkNocGp2VXBx?=
 =?utf-8?B?R2N2eStZeFZiVmtNalBxeHFwVHNMTEhJT0NES2J6UlZNK2lSd29zWHlyVVMw?=
 =?utf-8?B?N0w1QXFickRQSEprdnlTNmRyLysyeDdXdjNYUDVRTElHc1BsQThLWGxURTFY?=
 =?utf-8?B?cEYvSiswNFJ1VkZpUU8raVV2R2FzOTZJRUJMMU5sOXJRZklUQk9PMWdYQlBH?=
 =?utf-8?B?TGNXSWVqNS9nKzlOOGM0aXV2ZWR0VGtXdFBMcExGTGhCM2ZVNW9ibHFUdmlI?=
 =?utf-8?B?cWt1YWdrOGlHSEY4R3VzSmN0aDZmL09NOXJXNHZ4L1BkOFNKNHVPSHp4YzA3?=
 =?utf-8?B?aEJyQ2dVT1p4SjBXdndmbGpLbVYreldPSjRiby9rVC9aK2NlV0RVekFZeCtX?=
 =?utf-8?B?d3FQRW5mek9VVGhqaE5OcTRTcHRVcFEvdnVsMmtKMHRqR3d6bDBiS21Wd2xn?=
 =?utf-8?B?TSs3bFNNWW1RNjhBS1Rud2c5WVFGcE9IdjZFdGdYRExzc2tYeG82eWZ2eVhJ?=
 =?utf-8?B?b0dEWE1FVkdqdjZCbDRQNHdjb05DWUZDVThqVmtkTjJCaVdaaEJvQkJpRzhl?=
 =?utf-8?B?OG1TbHlVak5PNERrNzAzV2FLdU56TmV6eHRidTlVcHlBRjFmVm5rOFBEV3VL?=
 =?utf-8?B?OEppc0MrRkZmWW5QSlVhVU1XU1A1TmlCOStYdkNtTWhyVWtrZUZJcGo4dngv?=
 =?utf-8?B?VFcrYWwvRjdZN3J4RjY2d0p4d2xPT0d1UHk3cEh1UXh6WEQ2Y21ZV01OaUVq?=
 =?utf-8?B?d3Y0Q2p0NHJzYjR3bnd2cnVFcC9jTEpxK1NheUpKb0dMSHVNNmVyYS9QMnNX?=
 =?utf-8?B?VWw0YTBBVDBJK3BhbzVsWkdqbDZSY2pCckRtZFpNdmphYk1wS3VWREpmZkJ5?=
 =?utf-8?Q?L9pJZrfG5jHaYZLkh3TDuB0gZtlDxJSY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjlRbE9UUnpkZXp5ejg2OG5oZVg0Yzhoc0k4blVydi9wZmhwZzc1RTRhZHM0?=
 =?utf-8?B?VTNFQW9XUGtNSVNhWXlyeW1oNHRxeC9XKytTQm5kSUpSbmI2bDdmdVFkZUp1?=
 =?utf-8?B?WXd1UHF0TktZWllaRlNBQzBGL3pmb0pPazl0K2sxdWNXdVdER0RPc05waHJm?=
 =?utf-8?B?OGM4a0IvaDBITzFNeEhPSTN0NGNLZkhraXpDQnB4OXpRT2lSL1grdEZXTi9P?=
 =?utf-8?B?TWJJU252K1BUaFZ5VUJ6WHRZdU8rT2pjNWkvQ0VDRFNVUVJTbWE4KzRwQ0JD?=
 =?utf-8?B?UFVQZmRPMU1GSGtwOFkyTDgrYWt6RlZDNTVqV0NkN3lhbHRWcUVNRUdiQi9C?=
 =?utf-8?B?ZWk1Nm85M3ZOVFFRUkE1S3RiYmE1aURsQURHRGZ5SW5SL0dpMlNGQ3gxcWlZ?=
 =?utf-8?B?alNldXlDa21Pb2J4SmZVblZuMVdaN2w3QXF3cFJzS1hHVTdWL2E3MzZOVW54?=
 =?utf-8?B?V3g5N0p6WC9HLzc0N1drK2NzZGEyamlaS0ZTNTdMdzhTMEttNTdjUllqYnI2?=
 =?utf-8?B?cmhzdXlTa0c1ekVERUtXUnBOMXgzSGluUE9vTW1ZRmo4WHhNTEJjVnAyRm04?=
 =?utf-8?B?dEgvUVV5LzZFSXo4WllYKzRjNE1DQzZPMkhFT0pJK212all2Sm5pVUxLL3pW?=
 =?utf-8?B?RGtQWElvSFdFOE5xSksweGt3YkN4ZXd4WWx5UTFvOEh2b29YL2FkaERhNmJL?=
 =?utf-8?B?OWFzNWRkQWVleDBkbXpCRTlKY0l4UlM1Nk0zNFlNa1FxMlNtbllrTDgrK0ZG?=
 =?utf-8?B?WTZDb2dxUC9tNVVBZ3F3TjZiVFdkVzNEWE9yVXJoVVhkUmtOS0IvQXNycFpy?=
 =?utf-8?B?YlU5VkZyT0JjZENVbFlEMUs5VmVQaVJQQTNiL2pxRm50d09qQnV4UG94R3Vw?=
 =?utf-8?B?clZnZ29lRFRCbmxXM25LeW1SeWlLSlQyUitMdzZEd0gyQVQ5SmZrUktWVmRE?=
 =?utf-8?B?VHJPZ2hBWHhPVmk3MnhxOEpKbXM5OElWaXRRWFlYYnQ2Uys2VjFoR1ZhRmJW?=
 =?utf-8?B?RUtTZlhnK1F0MHFnd002Y3J5WFpzTzEvTHNOdDI4WDFTM25xbFFBQkM5WTRX?=
 =?utf-8?B?b0tvWUYySThvTXhhTkI2REVJVzZMUS8ydE0xdExHNFk4RFpZRmo3MVhLOG9m?=
 =?utf-8?B?U2tYUUZPOWs3SDA2bkhMc1NWSnZab0RiR1lra3hKdXgvUGVrdzY4UFdMTWtU?=
 =?utf-8?B?TjBMM3c5WUZDZG5Qb0JxZ0RFRG5lWFBwTmJIYWpnWVZFc3JnK09VRlNSNmdx?=
 =?utf-8?B?TzN2UkU4ejF6NmV6cTZJYjFqSUV0alRkWUhCK0swWGRhR05id0ZEM1FhOXRR?=
 =?utf-8?B?V2NWYVlKR1R5a3ZPbTlVbTJLZjJ0TG9LM0UyWVlubHNRdExOS0VzUXZ0RGdD?=
 =?utf-8?B?eElmUVFGcmMwUitLM1RuNWZGZnZwMFRmbXBINWlLeE56TUVWdFNtYlpsdFRM?=
 =?utf-8?B?V1FCaDVqRDFIM0dPL0EzQ1NYK0lqQlpWcW0wbUQrRmlRcUQ2QWRWZGtNZ3V2?=
 =?utf-8?B?bmlBcFpPYldBa0lzODM4aFpKd3F1VXdlQVk1dXRDUlZLSUlyZ3k5VEZIWG5G?=
 =?utf-8?B?TkwzZXMwOFVzU2poMUFnMXF0S09mQ095T2xFZnVKQWFxcWNwZExIRVpGMDdG?=
 =?utf-8?B?RDJEM1RzTmZvaVVYWjF5Z1Nic2xoUDlLZEkzL0FkVUk1azBTdnZmVWNCNk1E?=
 =?utf-8?B?Rmttb21zRlVNYWVzc3pzMW5FZjFudklVOWs1VXJYT3dEMm9rSWQ0aUxVelZY?=
 =?utf-8?B?Y0NtSGtTa3ppalFpV2hzUGkyZExNNDJhQ2hURHJaMmxaSkJoNkpUY0VmV0ZL?=
 =?utf-8?B?Z2NSQ2VJQnNhL01halprNE5wcFRqMFJVMlQ3RDc1Q0FnUjU2eVBZYVVVZE91?=
 =?utf-8?B?alp6NGtteXVVU3hXZDFMQklNSTBWeUV6ZzluNFpGY0xyVkZIYnp3TnNWeFVC?=
 =?utf-8?B?VEI0a1FyL2FHK2pmcnhWK2hIWXltOXdpaDJ2bXM2K3ZpUnZxTVhLWDBFM2tY?=
 =?utf-8?B?NmVGTlB5UWlwWnVnbnlUMitFd0kxUWdZUjB2U1hiZmZaNGZWT2M1dy9HODZk?=
 =?utf-8?B?bG5CN3VmM2dUVlZaemQ4NHBRQXo0cmVtZDVxd2NveW90S1A0UkRrUnpXaks3?=
 =?utf-8?Q?7+e9lw13DgUwZegm4GcMdY/i2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8c4f6-2a8d-4170-624d-08dd60247f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:40:02.5690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROTHY7eWD958lSuCKy77e3BVExDRgWZ0dNCCGNB5gYS4TU6aTusbOmVAaBDiDa+qgggnovQHXV6ROfriM+uFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4403
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

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggNi82XSBidXMvdm1idXM6IHNldCBldmVu
dCBmb3IgY2hhbm5lbA0KPiB3aXRob3V0IG1vbml0b3Jpbmcgc3VwcG9ydA0KPiANCj4gT24gVGh1
LCAyNyBGZWIgMjAyNSAxNzowOTowMSAtMDgwMA0KPiBsb25nbGlAbGludXhvbmh5cGVydi5jb20g
d3JvdGU6DQo+IA0KPiA+IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+
DQo+ID4gRm9yIHZtYnVzIGNoYW5uZWxzIHdpdGhvdXQgbW9uaXRvcmluZyBzdXBwb3J0LCB1c2Ug
a2VybmVsIFVJTw0KPiA+IGludGVyZmFjZSB0byBpbmRpY2F0ZSBwYWNrZXQgdGhyb3VnaCBpbnRl
cnJ1cHQgcGFnZSBhbmQgVUlPIGZpbGUgaGFuZGxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+IA0KPiBXaWxsIGNvbnNpZGVyIGZvciAy
NS4wNyByZWxlYXNlLg0KPiBQbGVhc2UgZml4IHRoZSBidWlsZCBpc3N1ZQ0KDQogSSBoYXZlIHNl
bnQgdjIuIA0KDQpUaGFua3MsDQoNCkxvbmcNCg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLUJFR0lOIExPR1MtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMNCj4gIyMjIyMjIyMjIyMjIyMjIyMNCj4gIyMjIyBbQmVnaW4gam9iIGxvZ10gInVidW50
dS0yMi4wNC1nY2Mtc3RkYXRvbWljIiBhdCBzdGVwIEJ1aWxkIGFuZCB0ZXN0DQo+ICMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMNCj4gIyMjIyMjIyMjIyMjIyMjIyMNCj4gWzcwMy8zMjI3XSBHZW5lcmF0aW5nIHN5bWJvbCBm
aWxlDQo+IGRyaXZlcnMvbGlicnRlX2J1c19wY2kuc28uMjUuMS5wL2xpYnJ0ZV9idXNfcGNpLnNv
LjI1LjEuc3ltYm9scw0KPiBbNzA0LzMyMjddIExpbmtpbmcgdGFyZ2V0IGRyaXZlcnMvbGlicnRl
X2J1c192ZGV2LnNvLjI1LjEgWzcwNS8zMjI3XQ0KPiBDb21waWxpbmcgQyBvYmplY3QNCj4gZHJp
dmVycy9saWJ0bXBfcnRlX2J1c192bWJ1cy5hLnAvYnVzX3ZtYnVzX3ZtYnVzX2NvbW1vbi5jLm8N
Cj4gWzcwNi8zMjI3XSBDb21waWxpbmcgQyBvYmplY3QNCj4gZHJpdmVycy9saWJ0bXBfcnRlX2J1
c192bWJ1cy5hLnAvYnVzX3ZtYnVzX3ZtYnVzX2J1ZnJpbmcuYy5vDQo+IFs3MDcvMzIyN10gR2Vu
ZXJhdGluZyBzeW1ib2wgZmlsZQ0KPiBkcml2ZXJzL2xpYnJ0ZV9idXNfdmRldi5zby4yNS4xLnAv
bGlicnRlX2J1c192ZGV2LnNvLjI1LjEuc3ltYm9scw0KPiBbNzA4LzMyMjddIENvbXBpbGluZyBD
IG9iamVjdA0KPiBkcml2ZXJzL2xpYnRtcF9ydGVfYnVzX3ZtYnVzLmEucC9idXNfdm1idXNfdm1i
dXNfY2hhbm5lbC5jLm8NCj4gRkFJTEVEOiBkcml2ZXJzL2xpYnRtcF9ydGVfYnVzX3ZtYnVzLmEu
cC9idXNfdm1idXNfdm1idXNfY2hhbm5lbC5jLm8NCj4gY2NhY2hlIGdjYyAtSWRyaXZlcnMvbGli
dG1wX3J0ZV9idXNfdm1idXMuYS5wIC1JZHJpdmVycyAtSS4uL2RyaXZlcnMgLQ0KPiBJZHJpdmVy
cy9idXMvdm1idXMgLUkuLi9kcml2ZXJzL2J1cy92bWJ1cyAtSS4uL2RyaXZlcnMvYnVzL3ZtYnVz
L2xpbnV4IC1JLiAtDQo+IEkuLiAtSWNvbmZpZyAtSS4uL2NvbmZpZyAtSWxpYi9lYWwvaW5jbHVk
ZSAtSS4uL2xpYi9lYWwvaW5jbHVkZSAtSWxpYi9lYWwvbGludXgvaW5jbHVkZQ0KPiAtSS4uL2xp
Yi9lYWwvbGludXgvaW5jbHVkZSAtSWxpYi9lYWwveDg2L2luY2x1ZGUgLUkuLi9saWIvZWFsL3g4
Ni9pbmNsdWRlIC0NCj4gSS4uL2tlcm5lbC9saW51eCAtSWxpYi9lYWwvY29tbW9uIC1JLi4vbGli
L2VhbC9jb21tb24gLUlsaWIvZWFsIC1JLi4vbGliL2VhbCAtDQo+IElsaWIva3ZhcmdzIC1JLi4v
bGliL2t2YXJncyAtSWxpYi9sb2cgLUkuLi9saWIvbG9nIC1JbGliL21ldHJpY3MgLUkuLi9saWIv
bWV0cmljcyAtDQo+IElsaWIvdGVsZW1ldHJ5IC1JLi4vbGliL3RlbGVtZXRyeSAtZmRpYWdub3N0
aWNzLWNvbG9yPWFsd2F5cyAtcGlwZSAtDQo+IERfRklMRV9PRkZTRVRfQklUUz02NCAtV2FsbCAt
V2ludmFsaWQtcGNoIC1XZXh0cmEgLVdlcnJvciAtc3RkPWMxMSAtTzIgLWcNCj4gLWluY2x1ZGUg
cnRlX2NvbmZpZy5oIC1XdmxhIC1XY2FzdC1xdWFsIC1XZGVwcmVjYXRlZCAtV2Zvcm1hdCAtV2Zv
cm1hdC0NCj4gbm9ubGl0ZXJhbCAtV2Zvcm1hdC1zZWN1cml0eSAtV21pc3NpbmctZGVjbGFyYXRp
b25zIC1XbWlzc2luZy1wcm90b3R5cGVzIC0NCj4gV25lc3RlZC1leHRlcm5zIC1Xb2xkLXN0eWxl
LWRlZmluaXRpb24gLVdwb2ludGVyLWFyaXRoIC1Xc2lnbi1jb21wYXJlIC0NCj4gV3N0cmljdC1w
cm90b3R5cGVzIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1Xbm8tcGFja2VkLW5vdC1hbGlnbmVk
IC1Xbm8tDQo+IG1pc3NpbmctZmllbGQtaW5pdGlhbGl6ZXJzIC1EX0dOVV9TT1VSQ0UgLWZQSUMg
LW1hcmNoPWNvcmVpNyAtbXJ0bSAtDQo+IERBTExPV19FWFBFUklNRU5UQUxfQVBJIC1EQUxMT1df
SU5URVJOQUxfQVBJIC1Xbm8tZm9ybWF0LQ0KPiB0cnVuY2F0aW9uIC1Xbm8tYWRkcmVzcy1vZi1w
YWNrZWQtbWVtYmVyIC0NCj4gRFJURV9MT0dfREVGQVVMVF9MT0dUWVBFPWJ1cy52bWJ1cyAtTUQg
LU1RDQo+IGRyaXZlcnMvbGlidG1wX3J0ZV9idXNfdm1idXMuYS5wL2J1c192bWJ1c192bWJ1c19j
aGFubmVsLmMubyAtTUYNCj4gZHJpdmVycy9saWJ0bXBfcnRlX2J1c192bWJ1cy5hLnAvYnVzX3Zt
YnVzX3ZtYnVzX2NoYW5uZWwuYy5vLmQgLW8NCj4gZHJpdmVycy9saWJ0bXBfcnRlX2J1c192bWJ1
cy5hLnAvYnVzX3ZtYnVzX3ZtYnVzX2NoYW5uZWwuYy5vIC0NCj4gYyAuLi9kcml2ZXJzL2J1cy92
bWJ1cy92bWJ1c19jaGFubmVsLmMNCj4gLi4vZHJpdmVycy9idXMvdm1idXMvdm1idXNfY2hhbm5l
bC5jOiBJbiBmdW5jdGlvbiDigJh2bWJ1c19zZW5kX2ludGVycnVwdOKAmToNCj4gLi4vZHJpdmVy
cy9idXMvdm1idXMvdm1idXNfY2hhbm5lbC5jOjM1OjI4OiBlcnJvcjogcGFzc2luZyBhcmd1bWVu
dCAxIG9mDQo+IOKAmHZtYnVzX3N5bmNfc2V0X2JpdOKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2lu
dGVyIHR5cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLQ0KPiBwb2ludGVyLXR5cGVzXQ0KPiAgICAz
NSB8ICAgICAgICAgdm1idXNfc3luY19zZXRfYml0KGludF9hZGRyLCBpbnRfbWFzayk7DQo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn4NCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgKiB7YWthIHVuc2lnbmVkIGludCAqfQ0KPiAuLi9kcml2ZXJzL2J1cy92
bWJ1cy92bWJ1c19jaGFubmVsLmM6MjI6NTE6IG5vdGU6IGV4cGVjdGVkIOKAmF9BdG9taWMNCj4g
dm9sYXRpbGUgdWludDMyX3QgKuKAmSB7YWthIOKAmF9BdG9taWMgdm9sYXRpbGUgdW5zaWduZWQg
aW50ICrigJl9IGJ1dCBhcmd1bWVudCBpcyBvZg0KPiB0eXBlIOKAmHVpbnQzMl90ICrigJkge2Fr
YSDigJh1bnNpZ25lZCBpbnQgKuKAmX0NCj4gICAgMjIgfCB2bWJ1c19zeW5jX3NldF9iaXQodm9s
YXRpbGUgUlRFX0FUT01JQyh1aW50MzJfdCkgKmFkZHIsIHVpbnQzMl90DQo+IG1hc2spDQo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5e
fn5+DQo+IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzIFs3MDkvMzIy
N10gQ29tcGlsaW5nIEMgb2JqZWN0DQo+IGRyaXZlcnMvbGlidG1wX3J0ZV9idXNfdm1idXMuYS5w
L2J1c192bWJ1c19saW51eF92bWJ1c19idXMuYy5vDQo+IFs3MTAvMzIyN10gQ29tcGlsaW5nIEMg
b2JqZWN0DQo+IGRyaXZlcnMvbGlidG1wX3J0ZV9idXNfdm1idXMuYS5wL2J1c192bWJ1c192bWJ1
c19jb21tb25fdWlvLmMubw0KPiBbNzExLzMyMjddIENvbXBpbGluZyBDIG9iamVjdA0KPiBkcml2
ZXJzL2xpYnRtcF9ydGVfYnVzX3ZtYnVzLmEucC9idXNfdm1idXNfbGludXhfdm1idXNfdWlvLmMu
bw0KPiBbNzEyLzMyMjddIENvbXBpbGluZyBDIG9iamVjdA0KPiBkcml2ZXJzL2xpYnRtcF9ydGVf
Y29tbW9uX2NueGsuYS5wL2NvbW1vbl9jbnhrX3JvY19hZXMuYy5vDQo+IFs3MTMvMzIyN10gQ29t
cGlsaW5nIEMgb2JqZWN0DQo+IGxpYi9saWJydGVfcGlwZWxpbmUuYS5wL3BpcGVsaW5lX3J0ZV90
YWJsZV9hY3Rpb24uYy5vDQo+IG5pbmphOiBidWlsZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxl
ZC4NCj4gIyNbZXJyb3JdUHJvY2VzcyBjb21wbGV0ZWQgd2l0aCBleGl0IGNvZGUgMS4NCj4gIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIw0KPiAjIyMjIyMjIyMjIyMjIyMjIw0KPiAjIyMjIFtFbmQgam9iIGxvZ10gInVidW50
dS0yMi4wNC1nY2Mtc3RkYXRvbWljIiBhdCBzdGVwIEJ1aWxkIGFuZCB0ZXN0DQo+ICMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMNCj4gIyMjIyMjIyMjIyMjIyMjIyMNCg==
