Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94DC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 12:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D9AC4060B;
	Fri, 27 Jun 2025 14:07:13 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by mails.dpdk.org (Postfix) with ESMTP id C20784026B
 for <dev@dpdk.org>; Fri, 27 Jun 2025 14:07:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcU1AQvj/j7TwBhtrk2NA78XNwX3+GKC+ufYxzTfLKi53/VIvO8+SCxjNuRo5RWA6ZTpqfQB3mPyi1N1z4iL3CYYYhYFwz9SehPqoJrbsPBgLvH7Qy9N9rshpH4ZbYfTzIozKhHgZnP5wjQzyr6bE7JmstnUnwOmRsppmnhYf2LD02Qo/mEp9AUC9DJXTmJbF7Ukg8gmUV+GiFf+XQfRpePMk4h7z4b/LxC6crHKFiCgGqkFtfivsl6EbjGbuNBSXK2AqboDPExmeg9O1PY1M8KOpsULjv8j0Q17nM5KDffBkRMqiOqP5oKHY25PVKOgliJPwHAPn6ZHMAKuS9xvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqJA8X79xHoXSp7Tz2fQzaRAg/kKFyn0PX6Bm3iIP1c=;
 b=mOlSeYDg14pF7shSYV+fsJYsIObbdpjZhlLiTYiyZtZPaJQyL9zsXWinmlJvV9DfobvcqBihzmnpGWCVNXx3Mf+Vj5JwkNP2BHFlnp5fglH91pWEwlMKJO0+FlvK5rgjHbvQkQLPRpf2vAdT2gEC/nUZ1FXALi8LcLFJQsOqaSAeR45c6L0OlEdZMRWKcFhIzCGCkhZQ34Fx+329yych95Mz+xB5U8Hy6Rqq6XoY4DcyUrHolTpVvZ5fjVAuI9/0qT91ZNar5M2gBxMAsNvQqgFH6xZ1W1O4SrTaL1VsvVE+4jvWgDHfhKK8iMUGSu0qGBmggJN3qQVrYAN1nZ0M7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqJA8X79xHoXSp7Tz2fQzaRAg/kKFyn0PX6Bm3iIP1c=;
 b=W33DkFm/71qY4aHqxXzfYehum44nXepXrpu6mxGBOTTqXrffWpK7ch/HPlKK4EFpc7shlvcaWGEDYNHkhekQxRqbznx3jejVv5kU4ABFgiHKri5FeCDAIkb97CUz5II75P4q5lRJkEdpngRWIS4/IGO37Y77+jgzkbL/+l+bUVs=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 12:07:11 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.027; Fri, 27 Jun 2025
 12:07:10 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>
CC: Tetsuya Mukawa <mtetsuyah@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/null: Add fast mbuf release TX offload
Thread-Topic: [PATCH] net/null: Add fast mbuf release TX offload
Thread-Index: AQHb5TPW2mAQt//tPke2C+LG9hhrtLQVfHiAgAAbZoCAAU7z8A==
Date: Fri, 27 Jun 2025 12:07:10 +0000
Message-ID: <PH7PR12MB8596D3BC8FA4C87CCA08FFE08245A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
 <20250626070557.33058157@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD49@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD49@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-27T11:43:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DS2PR12MB9775:EE_
x-ms-office365-filtering-correlation-id: b6523ebc-8197-4721-14ab-08ddb5732540
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amVHLy80LzlaMHZ6bnMxS0ZRU2R4WWMvQXltOExhelN1UHZGRFY0SUVMakhD?=
 =?utf-8?B?N0dwSzZWUXNXSzE5ZnAxa2NRdVdRT1BtWjJNWDdVQXNoeEdnZzhjRWhTZzZF?=
 =?utf-8?B?ZWpBVFY1ZDhlbS82UFM3bHl2RFZKeXZGSFdQdk5kcm9vZWNKaGMyYnp5QUdi?=
 =?utf-8?B?bkZ1eGNlNzloRytsMGNiQlJQV0k5UCtPQnVSTG9zVDJhQUZ5T2g2dlVhd0tn?=
 =?utf-8?B?aUExaEFTRHUzWmlheGd0OURVZjQrNkE2NkZDZlpxNGxrY2lvRmJiTTg2NlB2?=
 =?utf-8?B?UXBxK3RZWW1weEhUUWpGZkRRS1N4RTNocXdhTzJveFovL0Jkd2JRbHhSL2pS?=
 =?utf-8?B?ZlhhL0JyMG5IN2JJUEp4NXhrOWgxSXlkZ3RUZ1lVb2xyZ3Y4MlhqdjdJWXUv?=
 =?utf-8?B?UTg2aXlUcFAyVGdHWDRWNGZXSGdkZFZWY0F2YXN3VitvYmNRMHRUVjNUQTVp?=
 =?utf-8?B?bEZRU3ZIYldxdndSUHRXRmNrc3VkRlZEOWRjZEloRDZyK1Rna1Q5cHVWdFBH?=
 =?utf-8?B?VnR5elBZU29FTjVUOFYxZlMycUs4ZWsvUkV2UGhlTjBFZ2xIVFQ0RndwbUN6?=
 =?utf-8?B?UWwrV1JXQlREUDFPekNGNU5QMWZnd1h5NmpscUlhek81SjlKZUhMTm10ZVdZ?=
 =?utf-8?B?eEJGenQwcC9YcGdBaVErQ3V2VzRVR1ZGbkp3bWRmT1k5YVkvdjR0eVlDTWk3?=
 =?utf-8?B?MHg0YWRwajY5dng1dzUwVWFWTjhnbjkvb2hwNzBncFZFaHhwZUZiQ2Q3blJ4?=
 =?utf-8?B?SjhTekQ5b3BvTTNpQlVrRlcwQ0xaYWt6R1daVTVDOGxMeW92NzlNeWg4UkRI?=
 =?utf-8?B?UmMwQjBqUjNkL2F6Wm0vMmpaMHRrVXlYS0xNOVZrWGdHcTN2djM5MURUaUNv?=
 =?utf-8?B?Z1BERDdGeWxtR2JSYTRjUWhXZE00ZFhoMGF1VEcwcjhtWXZqWlhOUStVOEJj?=
 =?utf-8?B?bmxXeDZWNEZVT1o4UWk3MUp5R3IyMC9PL09mVHo1bUZCSVM3b0dueGdleWd4?=
 =?utf-8?B?SFBsUjRvYnkyRW5YL2g0UWl3cUVtV3pkMUZadVh3OXdZQVplSm44SnFtYlV2?=
 =?utf-8?B?WDd6bUtmUkYxY3FPSlUwWk82ZzlXMGpPcG1nbWVmK2IyZEhKM1hZK09GTEt6?=
 =?utf-8?B?bTU0NEcyU1VEcDJxRHlTSnpJMmdYZTVjangvVTEvSEhhcEozMXZ3NDZoZ0hW?=
 =?utf-8?B?T1cyZ09LNEJDdEd3TWhCR3dyQ0xra3BoOFRxdUdGQXI2RFhlN1d1WGcyYS9U?=
 =?utf-8?B?K3Z3bklIZHpNMjVVQ3pjT2VFUzFaY09vWG9ZaVlQQVg4bndzZCtWNDRJdE9j?=
 =?utf-8?B?V0N4dUJ2cE1vOWZ2Z0lTVlJQWjJoNFJCN3BHck16Q0dzS1pmQWh2anBTdHI3?=
 =?utf-8?B?L09YY01sSUY1YlFCZENHNjZZUjh0TFhCMnhjdG5TUG15K0JnWEJSN1hJSzVx?=
 =?utf-8?B?NmxzRGw1dFAxUmwyczJ2dkpFQmI1MThxYmNwbXBwQ2IrMVlySUMzNUlJM09Q?=
 =?utf-8?B?N2s4cExJNWhLK3Nnd3NWNld3ZmgzVWpGK3c5eXhYSTBDYnRudDVST3JrNkR1?=
 =?utf-8?B?NCtwVTh2T0laOVhlVUdDNytZSFBCU0FRVWRNVis4TnhCL2p3SGtTWWszWjBH?=
 =?utf-8?B?TEszN1RiR1RBc0FJMit6cEZyWk5YZzgzaUhRU3FGWm1PMzRXZllWUGd0NkE1?=
 =?utf-8?B?Zk5wVUJId0xvak9peGR6VXYwQnozUDQyaDEzWEF5ZWpodG1hTVF1YTdyeDBh?=
 =?utf-8?B?SFppTkJjMUpBMTJ0SHlSMTNibjZsRjczcUVCcG5YaHhUSkdscmZXRC96aDZt?=
 =?utf-8?B?dUowSC9wWHhGRXpKOWFTZkMzemJDK25rMzZ1a1lOVUpkb2JKQmNaK3JXTFFE?=
 =?utf-8?B?QXVkeGtWQ3E2NkhzVFRXbU1JV2dRN1NLQzNMYWM5TWhBcE12eWtsekloKzFQ?=
 =?utf-8?B?RHZ1MCtSdWJydXRzeGtwRjdsb0tqOTFRWUMrbTVrSm5oS0hBL2RaZjJDeDdT?=
 =?utf-8?Q?Eoa5wWeJ8ZVzfDD2rR/bU7zwZJx2fg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHkxdUozVDdOdUtxSFVSUEkwWUZlMGJGY2hWUXlEY0JFQTVMeURBYXJqZEI3?=
 =?utf-8?B?N1FzK1U2YkRiUDZSMlo2clNjUk5iRlAyQkpuRGRyKytwV1JOZmQ5V2tvbmpt?=
 =?utf-8?B?ZjU5UnpjV3VZL1dWNEdSd3RlZlBnMnd1ZUx3L3hDczdhblcvK09ZekxNaEZh?=
 =?utf-8?B?Mkw5bEhaQWFTcW0wa011bGdLbVBXZGJYWUZ4bENnM3dzUGZWQ1RaSk1yM3dC?=
 =?utf-8?B?Um1UY0crdmtwNU8yeEpyTW0wd2ZXVURBeU9HTlFycFJwRjNWMmQ3MnJBOElJ?=
 =?utf-8?B?dk9kdDRya1hXZ2pRdFhmdW0ySXhOV2NCbTNDRDdTVUhJalQ1djFnSFlTUHZN?=
 =?utf-8?B?dVU2b0hTOHBvZVRQZVRHQXByMFF0N25ieHJ3ZE9CQ2JxVG1GTUVpWEl0NDZx?=
 =?utf-8?B?QkpKM1RzZU9IMm1OclV6SGZaVzBkcVBKQXkwYUhqQkpnVytnamFEUjQvTUwx?=
 =?utf-8?B?N011bG9MakpnQjNpOUEya0JTdStaUGRKaUc3YWlKNGZlQ2wwUGJUWURkYlVj?=
 =?utf-8?B?OHdyWFhGaVROVjBZV0g4cDRsYlZsTURQd1ZqUVRNdXRmUllPOVU4TW5naG5y?=
 =?utf-8?B?cEFyYzI2WFRjZElPQ1lrZDl1Zm5mTFNRMUl1QkRSMVVCUVVxTGJIMnBuZmNS?=
 =?utf-8?B?TWwydmhSZWsvYVNtTDJkUWxFNktUcGQzV3VmaGxQeCtIeDVVR00zMlpDeFU1?=
 =?utf-8?B?dTBvS1FSSHJSTHU2QW8xdStYRHhySzFFM0JPbE9CK3ZXZisxeFlRRFRzeDJy?=
 =?utf-8?B?djIrQ1o5RGdnazVQVHFWdCtpaDBjVmgwUktyenN6ZFIvd0NmaEl4SEQ3SHVW?=
 =?utf-8?B?QXZUV1lTaGtiT1dMd0dpL3V1N0lJbS9kU3NxRCt3L3hjVTN0SHozeWVoVHlj?=
 =?utf-8?B?WFpEc3JlZDFqRG9ZcXVKeWcyTWVxWUhKNUdwbnZ2L0VNQTYrU216alRvNjFG?=
 =?utf-8?B?WUVkcTFES0hhOE9qQ2FlWWxXUFY0Mkl6MXRibmVlSnNYdGk0cDRRU0pBbWp1?=
 =?utf-8?B?dURDaGpwbzlCUjh2UmJpd3pNVmtvS1d3eUdqSTIyeXh5RGEwR3hxSkxjZDY1?=
 =?utf-8?B?alRlSEpXdmZhZCtwZHBPM3RoUnM1bXgzVUtCRTc3blJjSFJ1ZEZPcHJ0N0Vk?=
 =?utf-8?B?TlRZajQwdjloalRZV3hwYWRQb3hjcGU3YVYvT2x0VGMwOU9hUUlHdHl0L1NO?=
 =?utf-8?B?d3BjUk13VjhYU2hHcWFHUi9XR20yYVB1NFQ2T2ZiUXlyMmNySFRiTFF3REU1?=
 =?utf-8?B?WHprVElWYUhQMTRGT3hISWRBNXVTTUgyMUtSVTN4TWE5QVZPM3FYZGljclV4?=
 =?utf-8?B?aHdkYmN6bzdaOEFLOXNGNGptYXdlaFlNZjQwNzV6VTJoSWxSMDg1VFU5djl6?=
 =?utf-8?B?NDNHOVNkYjNtakZkcERtK0xHa0RKQ0M2bG1XLzdOMkNlOElWbFJ3TEJTeWR3?=
 =?utf-8?B?QVhrUHl4eEpMb00rSlY1aHZabHBIS04yOC9DWldkSFB3OXYwM1VFQUFYZS9n?=
 =?utf-8?B?SWNrcDYwMW5GaHZwV2JqOER0SHJremRMKzNMWUNYeHlRTU00bDdBZ2crR2to?=
 =?utf-8?B?Sy90RUJraVVwVGlheUt2cUlyN3NJLzdWK1FBRno4S0d2SzJvZ3l6VHF6cWxW?=
 =?utf-8?B?TDRMcXdWSVFmNVlMLzRIeTJvSXc3REZDTkh1Vi8wYUlYOXNNSWFKNy9zY0o4?=
 =?utf-8?B?dW1kOEhJV0pyUGZLQ0dza0dwQVZkd0RZSnllMzR3U2t1SzllbHI1TUtqTHZv?=
 =?utf-8?B?elFiSUhISlVscnlNTElKak05Uy9YTk9Pd0toN2RCRkErMmgwTnRodk1FV2RY?=
 =?utf-8?B?RUVKVFg5MDhsR1JWMTI0YzdKeWtLSUdwbTI3R0cxWEN4elRHSm5hK3RwVitW?=
 =?utf-8?B?VUJ0YXJQQ2JZQ3dMSUpoVUVwUzVBYWd2TGQ5dGZwU0doQUh4UmpJbVJiaXFI?=
 =?utf-8?B?NjdWMmlNb0wwbDF5TVhBby9qS2lLamRqUG1OaHI0UkVYTGhlQmpJUktST0x3?=
 =?utf-8?B?N2x5c0FKWUZDUnZUWlV5OE5ZbS8waUdUdzJyNm5nbVVqZy9LTFlTMC9VcHov?=
 =?utf-8?B?aXA4K0ZzdXVLNTJQekRESnMrQmNPZTZ3TVM2elVhSXQ2YzArZllpYlBKelVB?=
 =?utf-8?Q?KN5wX14wV7OZTRRvr4drtY3xd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6523ebc-8197-4721-14ab-08ddb5732540
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 12:07:10.6911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftE5+tOoPH9Effkf/l7pbk5KdeqreQCgd0+mRKmC2cKrORh99QucOvO9kA8mL2xa/iSjN3At4JlmnZuJYIYRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775
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

W1B1YmxpY10NCg0KSGkgTW9ydGVuLA0KDQpXZSBoYXZlIHRlc3RlZCB0aGUgZWZmZWN0IG9mIHRo
ZSBwYXRjaCB1c2luZyBmdW5jLWxhdGVuY3kgYW5kIFBQcyB2aWEgIHRlc3RwbWQuDQpQbGVhc2Ug
ZmluZCBvdXIgb2JzZXJ2YXRpb25zIGJlbG93DQoNCiAtIERQREsgdGFnOiAyNS4wNy1yYzENCiAt
IGNvbXBpbGVyOiBnY2MgMTQuMg0KIC0gcGxhdGZvcm06IEFNRCBFUFlDIDg1MzRQIDY0Y29yZSAy
LjNHSHoNCiAtIGFwcCBjbWQ6DQogLS0gT25lIHBvcnQ6IGAgc3VkbyBidWlsZC9hcHAvZHBkay10
ZXN0cG1kIC1sIDE1LDE2ICAtLXZkZXY9bmV0X251bGwxIC0tbm8tcGNpICAtLSAtLW5iLWNvcmVz
PTEgLS1uYi1wb3J0cz0xIC0tdHhxPTEgLS1yeHE9MSAtLXR4ZD0yMDQ4IC0tcnhkPTIwNDggIC1h
IC0tZm9yd2FyZC1tb2RlPWlvIC0tc3RhdHMtcGVyaW9kPTFgDQogLS0gVHdvIHBvcnQ6IGAgc3Vk
byBidWlsZC9hcHAvZHBkay10ZXN0cG1kIC1sIDE1LDE2LDE3ICAtLXZkZXY9bmV0X251bGwxIC0t
dmRldj1uZXRfbnVsbDIgLS1uby1wY2kgIC0tIC0tbmItY29yZXM9MiAtLW5iLXBvcnRzPTIgLS10
eHE9MSAtLXJ4cT0xIC0tdHhkPTIwNDggLS1yeGQ9MjA0OCAgLWEgLS1mb3J3YXJkLW1vZGU9aW8g
LS1zdGF0cy1wZXJpb2Q9MWANCg0KUmVzdWx0IDEgcG9ydDoNCiAtIEJlZm9yZSBwYXRjaDogVFgg
TVBQcyAxMTcuNjEsIFJYLVBQcyAxMTcuNjcsIEZ1bmMtbGF0ZW5jeSBUWDogMTkxOG5zLCBGdW5j
LWxhdGVuY3kgZnJlZS1idWxrOiAyNjY3bnMNCiAtIEFmdGVyIHBhdGNoOiBUWCBNUFBzIDExNy41
NSwgUlgtUFBzIDExNy41NCwgRnVuYy1sYXRlbmN5IFRYOiAxOTIxbnMsIEZ1bmMtbGF0ZW5jeSBm
cmVlLWJ1bGs6IDI2NjBucw0KDQpSZXN1bHQgMiBwb3J0Og0KIC0gQmVmb3JlIHBhdGNoOiBUWCBN
UFBzIDExNy42MSwgUlgtUFBzIDExNy42NywgRnVuYy1sYXRlbmN5IFRYOiAxOTQybnMsIEZ1bmMt
bGF0ZW5jeSBmcmVlLWJ1bGs6IDI1NTducw0KIC0gQWZ0ZXIgcGF0Y2g6IFRYIE1QUHMgMTE3LjU0
LCBSWC1QUHMgMTE3LjU0LCBGdW5jLWxhdGVuY3kgVFg6IDE5NDZucywgRnVuYy1sYXRlbmN5IGZy
ZWUtYnVsazogMjc0MG5zDQoNClBlcmYgVG9wOiBkaWZmIGJlZm9yZSB2cyBhZnRlciBzaG93cyAx
My44NCUgdnMgMTMuNzklDQoNClJldmlld2VkLWJ5OiBUaGl5YWdhcmphbiBQIDxUaGl5YWdhcmFq
YW4uUEBhbWQuY29tPg0KVGVzdGVkLWJ5OiBWaXBpbiBWYXJnaGVzZSA8VmlwaW4uVmFyZ2hlc2VA
YW1kLmNvbT4NCg0KQ2xhcmlmaWNhdGlvbiByZXF1ZXN0OiBgd2l0aCBmYXN0LW1idWYtZnJlZSBv
biBzaW5nbGUgcG9ydCB3ZSBzZWUgZnJlZS1idWxrIHJlZHVjdGlvbiBieSAtN25zLiBCdXQgbnVs
bF90eCBpbmNyZWFzZSBieSArM25zLiBUWCBQUHMgcmVkdWN0aW9uIGJ5IDAuMDcgTXBwcy4gSXMg
dGhpcyBhbm9tYWx5IG9mIG51bGxfbmV0IFBNRD9gDQoNCj4gPg0KPiA+IE9uIFR1ZSwgMjQgSnVu
IDIwMjUgMTg6MTQ6MTYgKzAwMDANCj4gPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5
c3RlbXMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gQWRkZWQgZmFzdCBtYnVmIHJlbGVhc2UsIHJl
LXVzaW5nIHRoZSBleGlzdGluZyBtYnVmIHBvb2wgcG9pbnRlciBpbg0KPiA+ID4gdGhlIHF1ZXVl
IHN0cnVjdHVyZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNb3J0ZW4gQnLDuHJ1cCA8
bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+DQo+ID4gTWFrZXMgc2Vuc2UuDQo+ID4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMgfCAzMCArKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvbnVsbC9ydGVfZXRoX251bGwuYw0KPiA+IGIvZHJpdmVycy9uZXQvbnVsbC9ydGVf
ZXRoX251bGwuYw0KPiA+ID4gaW5kZXggOGE5Yjc0YTAzYi4uMTJjMGQ4ZDFmZiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L251bGwvcnRlX2V0aF9udWxsLmMNCj4gPiA+IEBAIC0zNCw2ICszNCwxNyBAQCBz
dHJ1Y3QgcG1kX2ludGVybmFsczsgIHN0cnVjdCBudWxsX3F1ZXVlIHsNCj4gPiA+ICAgICBzdHJ1
Y3QgcG1kX2ludGVybmFscyAqaW50ZXJuYWxzOw0KPiA+ID4NCj4gPiA+ICsgICAvKioNCj4gPiA+
ICsgICAgKiBGb3IgUlggcXVldWU6DQo+ID4gPiArICAgICogIE1lbXBvb2wgdG8gYWxsb2NhdGUg
bWJ1ZnMgZnJvbS4NCj4gPiA+ICsgICAgKg0KPiA+ID4gKyAgICAqIEZvciBUWCBxdWV1ZToNCj4g
PiA+ICsgICAgKiAgTWVtcG9vbCB0byBmcmVlIG1idWZzIHRvLCBpZiBmYXN0IHJlbGVhc2Ugb2Yg
bWJ1ZnMgaXMgZW5hYmxlZC4NCj4gPiA+ICsgICAgKiAgVUlOVFBUUl9NQVggaWYgdGhlIG1lbXBv
b2wgZm9yIGZhc3QgcmVsZWFzZSBvZiBtYnVmcyBoYXMgbm90DQo+ID4geWV0IGJlZW4gZGV0ZWN0
ZWQuDQo+ID4gPiArICAgICogIE5VTEwgaWYgZmFzdCByZWxlYXNlIG9mIG1idWZzIGlzIG5vdCBl
bmFibGVkLg0KPiA+ID4gKyAgICAqDQo+ID4gPiArICAgICogIEBzZWUgUlRFX0VUSF9UWF9PRkZM
T0FEX01CVUZfRkFTVF9GUkVFDQo+ID4gPiArICAgICovDQo+ID4gPiAgICAgc3RydWN0IHJ0ZV9t
ZW1wb29sICptYl9wb29sOw0KPiA+DQo+ID4gRG8gYWxsIGRyaXZlcnMgdG8gaXQgdGhpcyB3YXk/
DQo+DQo+IE5vLCBJIHRoaW5rIG1vc3QgZHJpdmVycyBoYXZlIHNlcGFyYXRlIHN0cnVjdHVyZXMg
Zm9yIHJ4IGFuZCB0eCBxdWV1ZXMuIFRoaXMgZHJpdmVyDQo+IGRvZXNuJ3Qgc28gSSdtIHJldXNp
bmcgdGhlIGV4aXN0aW5nIG1lbXBvb2wgcG9pbnRlci4NCj4gQWxzbywgdGhleSBkb24ndCBjYWNo
ZSB0aGUgbWVtcG9vbCBwb2ludGVyLCBidXQgbG9vayBhdCBtYnVmWzBdLnBvb2wgYXQgZXZlcnkg
YnVyc3Q7DQo+IHNvIHRoZWlyIHR4IHF1ZXVlIHN0cnVjdHVyZSBkb2Vzbid0IGhhdmUgYSBtZW1w
b29sIHBvaW50ZXIgZmllbGQuDQo+IEFuZCB0aGV5IGNoZWNrIGFuIG9mZmxvYWQgZmxhZyAoZWl0
aGVyIHRoZSBiaXQgaW4gdGhlIHJhdyBvZmZsb2FkIGZpZWxkLCBvciBhIHNoYWRvdw0KPiB2YXJp
YWJsZSBmb3IgdGhlIHJlbGV2YW50IG9mZmxvYWQgZmxhZyksIGluc3RlYWQgb2YgY2hlY2tpbmcg
dGhlIG1lbXBvb2wgcG9pbnRlci4NCj4NCj4gT3RoZXIgZHJpdmVycyBjYW4gYmUgaW1wcm92ZWQs
IGFuZCBJIGhhdmUgc3VibWl0dGVkIGFuIG9wdGltaXphdGlvbiBwYXRjaCBmb3IgdGhlDQo+IGk0
MGUgZHJpdmVyIHdpdGggc29tZSBvZiB0aGUgdGhpbmdzIEkgZG8gaW4gdGhpcyBwYXRjaDoNCj4g
aHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9kZXYvMjAyNTA2MjQwNjEyMzguODkyNTktMS0NCj4gbWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tLw0KPg0KPiA+IElzIGl0IGRvY3VtZW50ZWQgaW4gZXRoZGV2
Pw0KPg0KPiBUaGUgUlRFX0VUSF9UWF9PRkZMT0FEX01CVUZfRkFTVF9GUkVFIGZsYWcgaXMgZG9j
dW1lbnRlZC4NCj4gSG93IHRvIGltcGxlbWVudCBpdCBpbiB0aGUgZHJpdmVycyBpcyBub3QuDQo+
DQo+IC1Nb3J0ZW4NCg0K
