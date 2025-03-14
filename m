Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD5DC28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 11:48:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55ACA40289;
	Fri, 14 Mar 2025 12:48:58 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by mails.dpdk.org (Postfix) with ESMTP id 94881400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 12:48:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6kG4hNZCshEADR/Y5zWIwxgLvfcjBrRdAQgw3fwu/obVCkG2ZlMdeBfdKFPnspTXdw5iczrqrLekSunt3ZC6SYH1ygnlttSQVeHRbEPzTkifUBYldpfjyKrefbx5qxKceu2l2+QGRC4KpsvtMbDMfAMCiyul6klRmhdszlHTX0RYtd4Lk51oSk5AYIaSLBDyxxPzl4Qh4ISFfFjubjfBHq9Hr1zt8OKyQoQTwqygIKXXEXGjz9koJ2gXhlMbH3/ZyGKnFGfxV/05T/DcqvElVkTpby0+RGL3yMdxC1/W+E6qUF8sx+hYgyRQbHu11lJlKOOtd8tADlINkwLw6G7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jEtwsW9iZoSDm/oMkeCp9DN5HC0Hfz6JueSC732ZkM=;
 b=oc9IupD/WtmI1V1t3HUKNI72J7qmRQV6xpvYPhoval2jGw5m/mCQLQBmtUapCXA6pw30gJy7A1vuy8WFm7wU4GVzJVKVweSgxsphhFY9R9ZRpNkumONIYS6i1/YCuAlVtTJM2X5p4AEBRLmzA0otwFFsLyd1E+WR7lFa5xNgjHACGutrLZbq5+AmDp6+cc9jYiVQeFJApWhyphSrMYtD7luFhd8tnqp4vj+aUivTQegRHTCypCQ7mNIBJ63F7UlsRTxeBt/ulWcSC2B30rSLM8hmPi777x6Ulanb3CDf9apOOlKXtLdc8vQ5VDmGdSJsdAGNDyYew62eWG9RIGKeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jEtwsW9iZoSDm/oMkeCp9DN5HC0Hfz6JueSC732ZkM=;
 b=N9lueqdciWw0kOjaMPJ+htFB/CN7ur06mMFWVw5LV2MCb1Wdd8R7YXIO3bVq4BJXHSSnaG6RJsMRSzrSbf2IMRKmwV1a8kVfUzudz9W+IXJiRVofLxbMjGjMORbRVSoW1jBFuKMmoeA5MG6XTQORTX2UMElPZaOJY6ffzbmi8ey4pThUCwiH+vvJboOuqBbQMOoRvkZhLHbxpTisWqytZb+QJmLglbcFafoljk9p5UmPj/egKxqtbXl7BGvIHqlUYHzjNNLz1OP3UHaeE/QsdGVT4jLa6yxmSRP2d05CdKzaOcsouoRSlqwfLsLCroWr/HV9yH+WBxjWauzIpM1LKg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 11:48:51 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:48:51 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] net/mlx5: improve socket file path
Thread-Topic: [PATCH 1/2] net/mlx5: improve socket file path
Thread-Index: AQHbTUDqq1gkCf0oJ0KFKrBSz4/VwrLkaeqAgAABC4CAIA9MAIBq38iAgADgurA=
Date: Fri, 14 Mar 2025 11:48:51 +0000
Message-ID: <CH3PR12MB8460C2AFAD3227CD704A617FA4D22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213091239.7934b8b4@hermes.local>
 <Z1xr5-FXBgEN4QM3@bricha3-mobl1.ger.corp.intel.com>
 <c941592f-f98d-42c7-9849-b48b6b8d8f5e@nokia-sbell.com>
 <47f4086f-b1eb-4d18-a433-e53593afceb4@nokia-sbell.com>
In-Reply-To: <47f4086f-b1eb-4d18-a433-e53593afceb4@nokia-sbell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|BY5PR12MB4035:EE_
x-ms-office365-filtering-correlation-id: 3734096b-7eb9-428d-3d6d-08dd62ee30a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bjlvWUo2dW9Nd2hmQ1VnQW5hQ2w3czVQa015dHBXMkNsTUFFL2tucm00cVds?=
 =?utf-8?B?N1BvSEhIa0luczg5UnpES3pjSU1VbnYvZTNUam1PMWFhZWhxZGVNOEJrZFpI?=
 =?utf-8?B?cFIrWVliWjRIQ0NTZW4wclNLbUJVOG5sOUNaZmFLcEtUcW55NmdYdk9kUjZy?=
 =?utf-8?B?dTVUTmNjMGl6bjM4Lyt4ald5MXU5Zzltb0h0bFVWTnFqdExLdnpySGRYdk9y?=
 =?utf-8?B?QUsyMVZjTmIzK0ltNmVGNitJQ2Y5bXRUMEFsWlF6RUpMblZKbFpsYTlYVzNN?=
 =?utf-8?B?Ny82OTBzZzJYUTdmNHdaYXNlbGhDbWZyK1c5R2txME5KdW1wMjB0dDhMTnhy?=
 =?utf-8?B?MVlPTGxLMzZIaDkyYjdBMXhlOW9mYUEwbkNaUTFHY2dTaDRUV3pIWEZmMGZr?=
 =?utf-8?B?dHVrU2o3Y3FqcE5FVU82ckJiOE4yUW5WNFJUNkJvQmpvZjhpdGZEYTFtS2Uv?=
 =?utf-8?B?RGdIRUNlTW1lcmd4NkpmSUNXd2xvd2FCOE83bWNvVzNRSzRJRmVkWmtJNUJm?=
 =?utf-8?B?ekh3ckVVRkNySEI2OGM1NnUxYUtuU0dDRHQ0RUZGYlhtWGtwSHkyRmpkdytt?=
 =?utf-8?B?UGpKMTNPS21VeU0vVjNYUXpoWXNaZ0NjbTh3QktCVDJYTE5oV3FBTW8ybFhk?=
 =?utf-8?B?U1VLS1ZkN0xXbUxTQWlycE1aOFJrQWRUT3lmL3VqWmJVTWk3ejhuVWNwSWdX?=
 =?utf-8?B?dG1jZVVIaGJFSU1sODc5NlE0WkR0K3pnd0NIUkIxL3hpRXNZL0JBNVNsRzRW?=
 =?utf-8?B?eW42OUxucURvMDh6dVp5dTJScGVYYUVNZlJTNnVWWndyUXp0MTFxQmg4RW9t?=
 =?utf-8?B?K1ZSbkVUb3cxWGYwdkVLK1o1YUIzOWpLbTBoYmlPQkNINUcvR2U3ZEp2TGQ0?=
 =?utf-8?B?MUp0OHlwN3hWNEorZVFyRkJicFpXeGUvYjFwRSt0RVpncEJpK0tTWUJ6dzIv?=
 =?utf-8?B?TTlMTTZmUEV6ajBONnRGV1A3TzA3anZId1IwUXhnYWNhYzlJMmg5dW5FRGxY?=
 =?utf-8?B?SUN4YkFDZHdQVkRVdGJjcDZJNHRVS0hhOGlxRmtsN0RoL0dMK292bFFkN28z?=
 =?utf-8?B?WDluQmxvK0R3QUNkalFKTTJzRTN1bjBNL25LVCtObmtBU043TFJ3RHV0SFpF?=
 =?utf-8?B?ZXdBMnNsdUJHUUNJWDcxUXIzaG1Cc2JWRWJFMUIrUUVGUktOWmllSG5zaU5u?=
 =?utf-8?B?RG8wQVpTUytuLy9LeEhTMFA5eGFncGJQUEpzNDVWbWg0UURGaThjdGRNL0dO?=
 =?utf-8?B?bkZWaWtpVzhjQ2RhQmY3MDBEd2thSEthbUZ5UE5vMHRhSlNEUkN4Z2VUZHkw?=
 =?utf-8?B?WE11d2FJQURYRitIUFdSZGJPTURGd3lDd3JpVXBHTjJMVnErSG15enFVRnN3?=
 =?utf-8?B?WHdXTVptc3g1LzNrU01XenBvNFNrckpoN1dkMk1ha1NkZENkL1ZHUjduZU80?=
 =?utf-8?B?VXJuVWVSaVJoa2YwTVlhNDVqdmUxZFVoOEppaGtoOThsV3k5ZXdGMVNYQUZo?=
 =?utf-8?B?RGtZYitQQ1Fkd3pnY1VLUjRxeTVSRG5aWkpaK29BbkV3cHdzaUd1MzhteHBa?=
 =?utf-8?B?M2lzdUhCekFZdG9GbGNRTUNDbGZ3ZTRtelZCZTJHNEJDQ3lYaGdka1BMNjhs?=
 =?utf-8?B?dGFGdUZBYVA5RzFSK1krcXBEaCtGTVo0MzA0RUljRTdaWEEwRWkxT1lmZjQ0?=
 =?utf-8?B?bWcwdmFQR2oxUjFtSzMwVDhRSFhnMCtxNGlZS0k5S0duSlZHNllkR3BJMEFj?=
 =?utf-8?B?UE1ucFh1UlNTd2d6cnFLTXVPdmRFaXloUjlXWW93YzhJdkxpNDNvWmt3a21W?=
 =?utf-8?B?UmtTTTdPSzdXWVZ2YTBZZmoxVW9qZnhmZVVCY3pkbWNOK3MwaHVPYWtwK1cx?=
 =?utf-8?B?b2lkdS9sU09GcEZPKzZvbXdSYWNWVWNqMjBPSFBwSWZRZ3FDQ2RFdi9mT3Y2?=
 =?utf-8?Q?Z3T3TlnJVofmMzYAaQRs3uH+CYxHhOUq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sjc1UVJxbVNDSVhIdDRoOXpSK0JLVlU3dUhiZDdYQzlOWHdUOHR5RENwVEJH?=
 =?utf-8?B?Mk5xeGdkbUo1VGN0NWVJY0hTRTlNcWlCbXdyZktRaFpIcTNsbjJVbzFwSzVC?=
 =?utf-8?B?bjF1c0ViT3ZxaUZseHVyT1VlYXBPd25POWp6UEJEekU4RjZyN2c2bG02cXQz?=
 =?utf-8?B?TkFuYlBkUGlmcC8yT3V3YWwrQ1hvdlVWY3lyZDZQSlVPeFprVm8zeXFTOEVB?=
 =?utf-8?B?Q3pFMVovbW1Ydm1ZYkc2L1NHdXhleENLZGlHYzNQanAwQ1N3MmpUTnk0Ulpw?=
 =?utf-8?B?MHAxeGh2ZDRjL0MrUWw4V3F0aHhVcDdYRTVVSXpjU2tOdzByMkFvY0ViSER0?=
 =?utf-8?B?bEtrRmJQRHpobGRUUC94Z01UK3U1ckRTMUhMRzBMQUQwTkdUNXpZNzEwcWtz?=
 =?utf-8?B?R1pQUWQzZHAzVjN1MDBaOFhlR3YvVk9zTHVJZUZCWXFubWZjK0FHWTRXeVJ1?=
 =?utf-8?B?cHc1bFBkanVPbGJYM3p5UEozK1F0dnlvcWlvSm1RSnI5K1pWUlFIc0RhQklO?=
 =?utf-8?B?OWx1bWpyTGY4MXdDKzdqY1JiTlFkVnQ0Y1JPNFIvcTMyOWhLZGcvYlFEQk8r?=
 =?utf-8?B?Tm4yYkVPSGF0dnU5QnR1aFJtcXQvdmVYdmZOMWVwTm13eFRpcEpaTitLMHNx?=
 =?utf-8?B?WTFkVGxUU3NTeGJKdDFBdFdNQ3RLYjJ3dzlPTStQNnV4L2hsZEl5QWdlMWsr?=
 =?utf-8?B?ejF4WGc0c093WG14Rm9uRG5PZnRuek95THBMbk5zZDBoMTNTRU9rM0ZlLzRj?=
 =?utf-8?B?TklvYXZzLzNjRTVGcFNJaStXUzl5dVRpTE9UM0FwWkZDTHcwaEtDQmwxVmtk?=
 =?utf-8?B?OTFIVng0U0VYbUVFYkVMWExLeGhzRU12VVo1aWt4SGJheWlBeTk4VlVDemtH?=
 =?utf-8?B?RG1BcnMvUkVpTHAvbGdSWnY1cThQQXlCajA2eXl4RXhXN1p3b1FPRmM1bmYv?=
 =?utf-8?B?K3gzK3FaYzlTT0MvS0IyQjB1TkowSTAwOGNtSVVnTUtwZTV3SjhPVldNWTIy?=
 =?utf-8?B?NE9TOGRPbkJYRWZDdzgrdWxLU1ZsMUprYkM3U0RYdVFEZ00rSCtaM3NLc3hu?=
 =?utf-8?B?aE1CUUtKUFdCeGFtc3ByMmM1Nzl3dU9Dc1VRZ1FpaG9QVEdBcFFKS0xxbWU3?=
 =?utf-8?B?cExkTzhUL09aVzBTSEV0TFBKNWVRVHhYVzBxbm8rREV2WnUzNm1HTjlweWVr?=
 =?utf-8?B?eUNGaFFMMlg4NkNBRW9kK1QyeVo3UDh0VjFQM3BVOGZ3ZGFudFlyMitGSDZS?=
 =?utf-8?B?dlQvRE1KZmtGQ2dzY0U1NGZPSWZmRXRHdnZTc3ZJcFFMakJxOGpEQ3VvMU9X?=
 =?utf-8?B?SzlSaHp5Sy9kOHlrVEUvZWxqMTZWQXJWazJuL3ZsVFhqOE4rSWJ6bGVYaGVJ?=
 =?utf-8?B?MmJGcXc3Q0FpMjExUEVzY1JpTzl0dEg5WFExU2lNQXlpemVhbVg4bnp2VWdq?=
 =?utf-8?B?TXV0eHVFc0VqbnJqbTM3VFhCS1NoY2h5bkZqWmhOYTBYVkF1QUx2aWJQTTN2?=
 =?utf-8?B?STFZcUY1K3NleUV4cUQ4UTVnVUMrNGRLM1c0amJxazFlQ3ppei90bnhwZ2Yv?=
 =?utf-8?B?SlFqaVJGdTBXV1JROE56a2R2ZlNhV2xKaVJrbVFXYUJRL2kweFJMbFJrdkxo?=
 =?utf-8?B?Y2d3cVF3cXNtanNWK09CUWpub214R3lMRHZiMUNaTUQwRmh6Wm01VnhkWjRD?=
 =?utf-8?B?bDlld2RoOXRZa2Q2ZnhCY01Pa1ZodFhMMi9ySDFlV2loZWVNRlZFTHd6cVBS?=
 =?utf-8?B?VGxTcG83ZDFGWVcvY0N1cVl3a1BtSFlyOHNkN2xYb05zZDA4WVV3VVkvRVQ0?=
 =?utf-8?B?SkZrZDQ3QjUvNkFaMVNUMU5TelIwdmsvUjJtakYzVmU2OHhncVlQVlFnanhr?=
 =?utf-8?B?b3ZONURrU2hLMklNeGs2VUFSa2pORVFtK3h6TFlYNXFERjNTQzZCSUZJMEtB?=
 =?utf-8?B?Uk0yMHIyWVYwRWJaeUpIQS9Hd0RwRVFTQ015OXpQU0EzRTd3ZmdRZFZvakRT?=
 =?utf-8?B?cG9FaDEwdGFUOUh4Q1FLcXp1aUhwYlBkNExBSkZGNGV2ck8yRVdMMWFFTldi?=
 =?utf-8?B?MmhyOGdBbW1iWnBhQWhPYTlWVllnVDlwVE5QSXB2T2dPQkZhTkljM1JialNP?=
 =?utf-8?Q?1zRtYq6hLeluAo8nH7nBa1OOM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3734096b-7eb9-428d-3d6d-08dd62ee30a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 11:48:51.3756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiko+cE1iHY8fFcgroiIyA9ENrFkSwNPQtlneS06gSlDd2TOmx921XmY8EufkjcXvPBvRwNcI0fZ3zYBjuBEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

SGksDQoNCj4gRnJvbTogWWFuZyBNaW5nIDxtaW5nLjEueWFuZ0Bub2tpYS1zYmVsbC5jb20+IA0K
PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEyLCAyMDI1IDM6NTYgQU0NCj4gVG86IEJydWNlIFJp
Y2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPjsgU3RlcGhlbiBIZW1taW5nZXIg
PHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBDYzogRGFyaXVzeiBTb3Nub3dza2kgPGRz
b3Nub3dza2lAbnZpZGlhLmNvbT47IFNsYXZhIE92c2lpZW5rbyA8dmlhY2hlc2xhdm9AbnZpZGlh
LmNvbT47IEJpbmcgWmhhbyA8YmluZ3pAbnZpZGlhLmNvbT47IE9yaSBLYW0gPG9yaWthQG52aWRp
YS5jb20+OyA+IFN1YW5taW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBNYXRhbiBBenJh
ZCA8bWF0YW5AbnZpZGlhLmNvbT47IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvMl0gbmV0L21seDU6IGltcHJvdmUgc29ja2V0IGZpbGUgcGF0aA0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMgDQo+IA0KPiAN
Cj4gT24gMjAyNS8xLzMgMTA6NTEsIE1pbmcgMS4gWWFuZyAoTlNCKSB3cm90ZToNCj4gDQo+IE9u
IDIwMjQvMTIvMTQgMDE6MTYsIEJydWNlIFJpY2hhcmRzb24gd3JvdGU6IA0KPiBPbiBGcmksIERl
YyAxMywgMjAyNCBhdCAwOToxMjozOUFNIC0wODAwLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90ZToN
Cj4gT24gRnJpLCAxMyBEZWMgMjAyNCAxNzoyNDo0MiArMDgwMA0KPiBZYW5nIE1pbmcgbWFpbHRv
Om1pbmcuMS55YW5nQG5va2lhLXNiZWxsLmNvbSB3cm90ZToNCj4gDQo+IDEuIC92YXIvdG1wIGlz
IGhhcmQgY29kZSB3aGljaCBpcyBub3QgYSBnb29kIHN0eWxlDQo+IDIuIC92YXIvdG1wIG1heSBi
ZSBub3QgYWxsb3dlZCB0byBiZSB3cml0dGVuIHZpYSBjb250YWluZXIncw0KPiByZWFkIG9ubHkg
bW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgTWluZyBtYWlsdG86bWluZy4xLnlhbmdA
bm9raWEtc2JlbGwuY29tDQo+IFNpbmNlIHRoaXMgaXMgYSB1bml4IGRvbWFpbiBzb2NrZXQsIHdo
eSBub3QgdXNlIGFic3RyYWN0IHNvY2tldA0KPiB0aGF0IGRvZXNuJ3QgaGF2ZSB0byBiZSBhc3Nv
Y2lhdGVkIHdpdGggZmlsZXN5c3RlbT8NCj4gSW4gZ2VuZXJhbCwgSSB0aGluayB3ZSBzaG91bGQg
YXZvaWQgYWJzdHJhY3Qgc29ja2V0cyBpbiBEUERLLiBQcmltYXJ5DQo+IHJlYXNvbiBpcyB0aGF0
IHRoZXkgYXJlIGxpbnV4LXNwZWNpZmljLiBMYXN0IHRpbWUgSSBjaGVja2VkIG90aGVyIHVuaXhl
cywNCj4gbGlrZSBCU0QsIGRvbid0IHN1cHBvcnQgdGhlbS4gQSBzZWNvbmRhcnkgY29uY2VybiBp
cyB0aGF0IGhhdmluZyBhDQo+IGZpbGVzeXN0ZW0gcGF0aCBhbGxvd3MgcGVybWlzc2lvbiBjaGVj
a3MsIHNvIGZvciBlLmcuIHRlbGVtZXRyeSBzb2NrZXRzLA0KPiBvbmx5IHVzZXJzIHdpdGggYXBw
cm9wcmlhdGUgcGVybWlzc2lvbnMgY2FuIGNvbm5lY3QuIFdpdGggYW4gYWJzdHJhY3Qgc29ja2V0
DQo+IHdlJ2QgaGF2ZSB0byBvcGVuIHVwIHRoZSBhcmVhIG9mIHVzZXIgYXV0aGVudGljYXRpb24u
DQo+IA0KPiAvQnJ1Y2UNCj4gDQo+IEhpIFN0ZXBoZW4gJiBCcnVjZSwNCj4gSSdtIG5vdCBzdXJl
IHdoZXRoZXIgYWJzdHJhY3Qgc29ja2V0IGlzIGEgZ29vZCBpZGVhLiBNYXliZSBpdCBjYW4gYmUg
aW1wcm92ZWQgZnVydGhlciBvciBzdGVwIGJ5IHN0ZXAuIEJ1dCB3ZSBkb24ndCBuZWVkIHRvIGRp
c2N1c3MgaXQgZm9yIHRoaXMgY29tbWl0LiANCj4gV2UgZG8gdGhpcyBpbXByb3ZlbWVudCBiZWNh
dXNlICIvdmFyL3RtcCIgYW5kICIvdmFyL2xvZyIgY2FuJ3QgYmUgd3JpdGUgaW4gUmVhZG9ubHkg
bW9kZSBvZiBjb250YWluZXIgZXhjZXB0IHRoYXQgd2UgYWRkIC92YXIvIHNwZWNmaWMgZm9yIERQ
REsgPiBhcHBsaWNhdGlvbiBpbiBjb250YWluZXIncyBzZXR0aW5nLiBCdXQgbmVhcmx5IGFsbCBE
UERLIG1vZHVsZXMgaGF2ZSBhbHJlYWR5IHVzZWQgY29tbW9uIHJ1bnRpbWUgcGF0aCByZXR1cm5l
ZCBmcm9tIGBydGVfZWFsX2dldF9ydW50aW1lX2RpcigpYC4gV2h5ID4gbm90IHdlIGFwcGx5IHRo
aXMgY29tbW9uIHBhdGggZm9yIE1lbGxhbm94IE5JQz8NCj4gDQo+IA0KPiANCj4gSGkgU3RlcGhl
biwNCj4gDQo+IEknbSBub3QgZW50aXJlbHkgc3VyZSB3aGV0aGVyIHVzaW5nIGFuIGFic3RyYWN0
IHNvY2tldCBpcyB0aGUgYmVzdCBhcHByb2FjaC4gSXQgbWlnaHQgYmUgcG9zc2libGUgdG8gaW1w
cm92ZSBpdCBmdXJ0aGVyIG9yIGluY3JlbWVudGFsbHkuIEhvd2V2ZXIsIHdlID4gZG9uJ3QgbmVl
ZCB0byBkaXNjdXNzIHRoaXMgZm9yIHRoZSBjdXJyZW50IGNvbW1pdC4NCj4gV2UgbWFkZSB0aGlz
IGltcHJvdmVtZW50IGJlY2F1c2UgdGhlIGRpcmVjdG9yaWVzICIvdmFyL3RtcCIgYW5kICIvdmFy
L2xvZyIgY2Fubm90IGJlIHdyaXR0ZW4gdG8gaW4gYSBjb250YWluZXIgd2l0aCByZWFkLW9ubHkg
bW9kZSwgdW5sZXNzIHdlID4gc3BlY2lmaWNhbGx5IGNvbmZpZ3VyZSB0aGUgL3Zhci8gZGlyZWN0
b3J5IGZvciB0aGUgRFBESyBhcHBsaWNhdGlvbiBpbiB0aGUgY29udGFpbmVyJ3Mgc2V0dGluZ3Mu
IE5lYXJseSBhbGwgRFBESyBtb2R1bGVzIGFscmVhZHkgdXNlIHRoZSBjb21tb24gcnVudGltZSA+
IHBhdGggcmV0dXJuZWQgYnkgcnRlX2VhbF9nZXRfcnVudGltZV9kaXIoKS4gVGhlcmVmb3JlLCBp
dCBtYWtlcyBzZW5zZSB0byBhcHBseSB0aGlzIGNvbW1vbiBwYXRoIGZvciB0aGUgTWVsbGFub3gg
TklDIGFzIHdlbGwuDQo+IEFjdHVhbGx5LCB0aGUgb2JqZWN0aXZlIG9mIHRoaXMgcGF0Y2ggc2Vy
aWVzIGlzIHRvIHByZXZlbnQgdGhlIERQREsgTWVsbGFub3ggZHJpdmVyIGZyb20gY3Jhc2hpbmcg
d2hlbiBhdHRlbXB0aW5nIHRvIGFjY2VzcyB0aGUgcmVhZC1vbmx5IGRpcmVjdG9yaWVzICIvPiB2
YXIvIiBpbiBhIGNvbnRhaW5lci4NCj4gDQo+IEJycywNCj4gWWFuZyBNaW5nDQoNCkxldCBtZSBw
cm92aWRlIHRoZSBjb250ZXh0IGZvciB0aGUgZnVuY3Rpb25hbGl0eSBpbiBxdWVzdGlvbiBoZXJl
Lg0KDQptbHg1IFBNRCBoYXMgYW4gYWJpbGl0eSB0byBkdW1wIEhXIGZsb3cgcnVsZXMgdXNpbmcg
bWx4X3N0ZWVyaW5nX2R1bXAgdG9vbA0KKGRvY3VtZW50ZWQgaW4gaHR0cHM6Ly9kb2MuZHBkay5v
cmcvZ3VpZGVzL25pY3MvbWx4NS5odG1sI2hvdy10by1kdW1wLWZsb3dzIGFuZCBpbiBodHRwczov
L2dpdGh1Yi5jb20vTWVsbGFub3gvbWx4X3N0ZWVyaW5nX2R1bXAvdHJlZS9tYXN0ZXIvaHdzKS4N
CkR1bXBpbmcgaXRzZWxmIGlzIHN1cHBvcnRlZCBvbmx5IG9uIExpbnV4Lg0KVGhlcmUgYXJlIDIg
d2F5cyB0byB1c2UgdGhhdCB0b29sOg0KDQoxLiBBcHBsaWNhdGlvbiBjYWxscyBydGVfZmxvd19k
ZXZfZHVtcCgpLCBwcm92aWRpbmcgRklMRSogaGFuZGxlLg0KICBUaGlzIHNhdmVzIHRoZSBmbG93
IHJ1bGVzIG1ldGFkYXRhIChlLmcuLCBJRHMgb2YgSFcgb2JqZWN0cykgaW4gdGhlIGZpbGUuDQog
IG1seF9zdGVlcmluZ19kdW1wIHRvb2wgaXMgdGhlbiB1c2VkIHRvIHBhcnNlIGl0IGFuZCBkdW1w
IEhXIHJ1bGVzLg0KMi4gbWx4X3N0ZWVyaW5nX2R1bXAgY29tbXVuaWNhdGVzIHRocm91Z2ggdGhl
IFVuaXggc29ja2V0IHdpdGggbWx4NSBQTUQsIHNoYXJpbmcgZGVzdGluYXRpb24gZmlsZSBkZXNj
cmlwdG9yIG9mIG91dHB1dCBtZXRhZGF0YSBmaWxlIHdpdGggRFBESyBwcm9jZXNzIHRocm91Z2gg
U0NNX1JJR0hUUyBtZWNoYW5pc20uDQogIG1seDUgUE1EIGludGVybmFsbHkgY2FsbHMgcnRlX2Zs
b3dfZGV2X2R1bXAoKSwgcGFzc2luZyB0aGUgcHJvdmlkZWQgZmlsZS4NCiAgQWZ0ZXIgZHVtcGlu
ZyBpcyBkb25lLCB0aGUgdG9vbCBwYXJzZXMgdGhlIG1ldGFkYXRhIGZpbGUgYW5kIGV4dHJhY3Rz
IHJ1bGVzIGZyb20gdGhlIEhXLg0KDQpJbiBwcmFjdGljZSwgMm5kIG9wdGlvbiBpcyB0aGUgbW9y
ZSBmcmVxdWVudGx5IHVzZWQgb25lLCBiZWNhdXNlIG9mIGl0cyBjb252ZW5pZW5jZSBzaW5jZSBp
dCBkb2VzIG5vdCByZXF1aXJlIG1vZGlmaWNhdGlvbiBvZiBhcHBsaWNhdGlvbiBjb2RlLg0KSXQg
aGFzIGFsc28gdGhlIGJlbmVmaXQgdGhhdCB0aGUgdG9vbCBpdHNlbGYgb3ducyB0aGUgb3V0cHV0
IGR1bXAgZmlsZSBlLmcuLCB0b29sIGNvdWxkIGJlIGNhbGxlZCBmcm9tIG91dHNpZGUgb2YgdGhl
IGNvbnRhaW5lciBhbmQgZGVidWcgZHVtcCB3aWxsIGJlIGdlbmVyYXRlZCBpbiBob3N0J3MgY29u
dGV4dCwgbm90IGNvbnRhaW5lciBjb250ZXh0IChhc3N1bWluZyBzb2NrZXQgcGF0aCBpcyBtb3Vu
dGVkIG9uIHRoZSBob3N0KS4NClRoaXMgaXMgdGhlIGNhc2UgZm9yIGV4YW1wbGUgd2hlbiBjb250
YWluZXJzIHVzZSBWRnMgb2YgbWx4NSBOSUNzLg0KDQpDaGFuZ2luZyB0aGUgZmlsZXN5c3RlbSBw
YXRoIG9mIHRoZSBVbml4IHNvY2tldCB3b3VsZCByZXF1aXJlIHRoZSB1cGRhdGUgb2YgYWxsIHRo
ZSB0b29saW5nIC0gdGhlcmUgd291bGQgYmUgYSBuZWVkIHRvIGNvcHkgdGhlIGxvZ2ljIG9mIHJ1
bnRpbWUgZGlyZWN0b3J5IGRpc2NvdmVyeSAobGlrZSBpdCBpcyBkb25lIGluIGRwZGstdGVsZW1l
dHJ5LnB5KS4NClVudGlsIGl0IGlzIGRvbmUsIHRoaXMgY2hhbmdlIHdvdWxkIGludHJvZHVjZSBh
IGJyZWFrYWdlIGZvciBleGlzdGluZyB1c2Vycy4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQg
ZmFsbGJhY2sgbWVjaGFuaXNtIGhlcmU/IElmICIvdmFyL3RtcCIgaXMgcmVhZC1vbmx5IG9yIGNy
ZWF0aW9uIG9mIHRoZSBzb2NrZXQgb24gdGhpcyBwYXRoIGZhaWxzLCB0aGVuIHNvY2tldCB3aWxs
IGJlIGNyZWF0ZWQgaW4gRUFMIHJ1bnRpbWUgZGlyZWN0b3J5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpE
YXJpdXN6IFNvc25vd3NraQ0KDQoNCg==
