Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15729CCFA13
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 12:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 036DD4026D;
	Sun,  9 Nov 2025 13:25:22 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41]) by mails.dpdk.org (Postfix) with ESMTP id A6C5540268;
 Sun,  9 Nov 2025 13:25:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIIz4M8ydTuGbYZPRtDDE3PV6IMOUR1lsNhoRBw7btwSIJjVmwTpH5bwbATaiYfyL8vNKBGOHpvZEZri8PUmPrbupFED0ybFKbG53LDyzBXTxhir0WvbdZQDmfi+9Ezl/NSLj4d8k0conbivvjwQwJwyMxS0BDrjSqixvxozgdUbdWHfKtby0NPFzBZ67Bq28aIsEUPtogdQWnanOVWXLsdhrqTQSQt64Y77MNM+6lrpfDwNRvuz0ksKyMvdBSvJnEIp0G3xoAbvcMCIOdffStfK+eTA5S2G3cXrCvfQ0mb1bMkRCsJziMkW3ibJXIwTDH9m3icCPQu4QAW6g4DZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAxLDB6SiQ93HoGeLTkRkIVevyEd+3OqBFfSzP66bmw=;
 b=v4xGMuezPS+XhISu+uVVUanyfiqzZqVLZpMLoT5XG0PjwIf7cy0AT/1NKvMWQCjQDrf6B3fEPcxWNNAh9HrfzVXXTubiEuL7Pc4LLNbVQ26GVzkEby1c5b+2AvMHK5FOKUylPtEZVto6FCFtm1cMdeujBjMQcYXDyAQSKTFp76oj9ipRXGECU2QN1MMWS5UCAk/YZX3UKAqFn1ev8Iy14/tG3Tqvx8tP6V9GRa97ZyRRgC2Cmy/SdFx8cUSV9cS/iObYiQRZr+D0d9aT5hjGEZmWdntimkJk3a2jWh53Ydi9p6X3W+qCnteAts4XgeqxoukMejtgjBu33ejNmNsUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAxLDB6SiQ93HoGeLTkRkIVevyEd+3OqBFfSzP66bmw=;
 b=F5ccy20JuHZr75F+bgBq73vQcYC8SxTnzftwffZndgKRTPG/8L2GzXZPnLciXHGGBr3WeF81PuiejnBs8+gzApf+eYBCSvVZAB8sF9Nu/6/Itznwaj8L8Ghuky85Tyn+vU3qpAwjDdX6QUGkYyOBaU4h4quqlGUTTqzxgY6wF6bSuh5Gh48u5razoYI7oNMmJYW8DmqB7f30BT1isDk8YwDDo1sdbrV761z6Ys0LVaxVb4CHyOICp90fXQsee6rP3M4sP4dZt5wAU9XQJ8sH5PZoxuAG2O8jNJJ1A7dDP3BecuaoaM5ki67ElXZeDojgc3fzR88UtMT+K4gnVnUBzw==
Received: from MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sun, 9 Nov
 2025 12:25:12 +0000
Received: from MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::5a5:56d:2ea4:ee25]) by MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::5a5:56d:2ea4:ee25%7]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 12:25:12 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, David Marchand
 <david.marchand@redhat.com>
Subject: RE: [PATCH] vhost: fix use-after-free race during cleanup
Thread-Topic: [PATCH] vhost: fix use-after-free race during cleanup
Thread-Index: AQHcTWJq9dsEhk4p2UGzpjhWU32K/LTiQTiAgAgLp6A=
Date: Sun, 9 Nov 2025 12:25:12 +0000
Message-ID: <MW4PR12MB7484A3BD3FB9DBC93CE962EFBFC1A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <d1f2634a-7c8c-4d3f-9578-dfc80ce504aa@huawei.com>
In-Reply-To: <d1f2634a-7c8c-4d3f-9578-dfc80ce504aa@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7484:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: 11bb2653-40cd-45b1-e736-08de1f8b07ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UTZFRXZUTzI2RkIrV1dNSXEwQXd5aWx3dXA0SFpYVnJlZjRHZ1BuK25GNy8v?=
 =?utf-8?B?SmRGdTdWemYyZDUrZGJKdDlTcWs4S1ZtUmVLOHBtWU0xa1YwYkxEdmtCSTlN?=
 =?utf-8?B?TVpFbkdoR0l3bFFxbHIwOVkrRGNnU0hLQ0lSUy9LUDdlU2paR2tuUkhYRE44?=
 =?utf-8?B?ekpaOTRGRDV6ZzQ1bXpyNUxiU1IwNHlzL3kyOGJxN2FUS1V1Q0tmaEhsV2wy?=
 =?utf-8?B?UW1xbnlSVTYxUDFuMWh6TmprTHVDR1NLVGpYYTc2NHYvSlZVRSs4Z2tEaFhC?=
 =?utf-8?B?Rjd5ZE56SmUrRjdpdFU4QlNyZUZyeWZMeFRObjJkSFFTRm8zbkxRbGhkbkww?=
 =?utf-8?B?TFBQd2lwRi9URVBUbXJkOUNsLy9ud1IxZ1FVNU1OWTlrZnZaNjg5MTVIV1I4?=
 =?utf-8?B?elJLZzhrb2JlWWN4dmJBQkFZT0MvQ2xwcmEzek5jNmhLRGlYQzJaWkhzdGp1?=
 =?utf-8?B?dStVWjczK05HM3JTWHBhdjR0aWNGSnZkRWY0cHpUYjFBRXZGam1WYlVyQjl0?=
 =?utf-8?B?S3ErVWZvNDcvQ0hEbjFiaUd3NW5mOWxTcXdQK2VNVmFhTDhxOVNnZ3hScE4x?=
 =?utf-8?B?UVpHM2ErZ1VpZGFwcFhzSkxiTE1ncmw3Vmk1Nit5ZmNQY0sveWpqVXJXQ1VZ?=
 =?utf-8?B?dVFLRDk5WDRIamxiRUFMblBVaDR6MnRhU3JycmZkN2VIeVdYNDJWYUd5ME5Y?=
 =?utf-8?B?NnA3bEZDOFk5U1g2Q0paYWI0ZlpTWlpNcWRmSUJXUjlReERLajdSQS8zaERh?=
 =?utf-8?B?blpyS2VhZnd5ZmN5MnNuVGNQRUhmR1Z6dTBwZklzL1l0RVgvUlBiWG92eXAv?=
 =?utf-8?B?Qng3d01lM1oxYmVCb3k2dmZSaVFVNS9obkVCYnQwbTdEQU1GWmI5Qjl3YW5D?=
 =?utf-8?B?Qk1JU2QvRUFmRC9kbVhUTFZDQzcvdWZvUVE1ZHA0SlBjQmlBeVRRVEYyYitY?=
 =?utf-8?B?Mk5DaU1qaDRQNVlrb3hiUHRKSzh4VnB2QVd5RVZhN01RVFNsZXd6OUlQNEQr?=
 =?utf-8?B?QlBsNDhSdlZ3L3c2NUwzd2djWXcvZTNNRjNxdTRhNkRpZ2R6VVVlc0FmNS9v?=
 =?utf-8?B?a3JuMHluYUlTUjJBZ1U0cXNnVGRKaGJQTGx1WXZLZ091QkZjRXR6d21RVlRK?=
 =?utf-8?B?N0J6eE1rOEtMYmNQVlN3RkRjaVJiRHZmblpJdW1NQm42Z2xEejJ1ZC9xU0RZ?=
 =?utf-8?B?a2srWktGeDBZQm1ySUNMUk5NTk5UWFJJQSsrdHZyZTBVQVVoTE5kc1h1UGFB?=
 =?utf-8?B?V1hnVHpiMnFPT2UwZkViMzRBK2VVYmpnMEV0VlpibS9adFdzd1FLekRJZmNK?=
 =?utf-8?B?Z1JqSnc2Rzc5R25WVk9lV0d0ck96SFZ1dGRLMUNTdjZ5Z3k4dXNCL3VUeVZa?=
 =?utf-8?B?Q0VueHlpNnNYTW5WMWRZaXhKVHMvS3ZsaFozQWViOTAxdGRLQ1pOWi91ZW1w?=
 =?utf-8?B?UldMWFJiVHNlTDFSMDdZRmJmQ2F0M0RrcEg0QXVUSnV3VWVLRlBiNXV3SkJ6?=
 =?utf-8?B?Ujkxd0phN2lRWW9BV0J4T3pDaHM2cGJiWWJzenU0VFpyR3k1d01KOUV5dVN4?=
 =?utf-8?B?a3lxSHA5MlZFSnNtcWNpWTUyM2lEMFJhbTdWbVIrYlp3cGFwYlJKNWFkUC85?=
 =?utf-8?B?Y3VnM0Q3Y3lNZzVrbkhNemxCc1FaRlR6SHFNeVhNaVg1U2ZYbjBnK2hlczlO?=
 =?utf-8?B?b2ZoZzFTcWxYMTVwZWF0ZjNTS2JnUzEyMis4eE1SRHpTeWNGRndEc1p6MmJx?=
 =?utf-8?B?U3FSTGNUVWl3ZHR5RnF3clNuY1hXVTdpUVlQd0xIaWo5WmEvQlN3VXBvNEQy?=
 =?utf-8?B?cDJSSE9CaEtUVTVIWXRXbjlXUFZ0SVZmU1E2VERGQ2FFTzVRbzdmaXhWb1Vh?=
 =?utf-8?B?OVlFRmpZQzBRTWdwUG5SRFRYS2VWN2EvNlVVOHY5NGZiRnpUb2lhWmsraDV5?=
 =?utf-8?B?VEFac3o2U2xqVzhLZUdyVUwyclZaUG13RHdqdVM3NWJIUXBRWWhrUnQxYWhw?=
 =?utf-8?B?Nm5xUTdpT2k4VnN1ZHVpTDZHdlVZdDFONHNnWk5PL1VLcytwYkUvci9hS1ln?=
 =?utf-8?Q?2bREOT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU8yNnRyLzRlcnNWc1FUdWw0M3ozTE1pNGVRMitoelQvRGtpOFhQdW4xZG1C?=
 =?utf-8?B?Uy81SFpGN2Y5VXNKUWJEeUZwNWNGNFhKWTBmNDBZeTUvaTZwSEczeVYyTHZi?=
 =?utf-8?B?YjVJNzY4Smp2MDFMU3o0TmhXbFJTR21LdlAxTEJxeit1MUVxNmVHWnZEK2xG?=
 =?utf-8?B?V1YzcEQvRTcvRXZoUFN6WXRsUTJVQjlIWmJIZWJuaUZiY1hNaDZYYkNVL3Zv?=
 =?utf-8?B?UEtqZGJpOEJFTmFxY29Hazl3Vk5KQUdsWlB2OFNNNFdkMkdaOE9MT3hUbXJt?=
 =?utf-8?B?QVc2VlhtV2lCSHlhbkM4SUQ3V05SUUFrSXRvSVpyUzhhT1EwVEl3ZkNCZWZj?=
 =?utf-8?B?OFBIVkEvdURvcWduWDR6VnNxdCt3NnhXZ3ZEcWxvRitQODVLVEhrc1dicjIv?=
 =?utf-8?B?TXI0ZHdSWWlrbVhhVmRtTFlWbm5vbGJTWDdGekpjcyt5N3k0UFh1YitINEJS?=
 =?utf-8?B?ZloybGtPeitOVVJheE8ycklwb1h1R2NSYWlFOCtKTkxsd2l6U3NTVC9kVXl4?=
 =?utf-8?B?NGlJZS9YSmFDMjZsZTMxS2ROTlJDNXpnMERiQ2NMeXZSOHVSNDh6WkxVemZ0?=
 =?utf-8?B?a3RtZVAxQU5JTVRGK0drSlZZajREcFVnSEJzdjdlSEw4RnBobEh4SGNPNlNs?=
 =?utf-8?B?UzZzcDNOUW1qTWE5N1A5Zk9QQUpkTHdaMENwNE5UbXpNbWE0SEc3QitqWnRS?=
 =?utf-8?B?dE56YWlCbFY1eU9DelhxNjVxQ1Nrc3ZPcXhxVC9IQzRPWGZZVnh4enlCMkk0?=
 =?utf-8?B?bVF0YnZqbWxLNGxDa2dqVlNrMU1VRmFhWHBUSXE4VDg0Mk1KTytzcDUyZHpS?=
 =?utf-8?B?K3RsUmFXK25aZHpmR3N3THI3RHdoWVRIUjFJSk11TWM2M1EzeGtYRWo5LzdB?=
 =?utf-8?B?Ynd4UHluN1pPVHloeERXb0N3eFFYY29NeGE5eG16SklKNUk5bG9XYWoxenhW?=
 =?utf-8?B?ZFBhdHUvOHljUjdNOWkwVlJaUW1wZ2pJVnhOMFdOcUVBNWl1U3lYZ3BSOTlC?=
 =?utf-8?B?cy9BVnpjQk45M0ZEZlVjSk52Q1piSXAvaHBTeE0yeFBpaXZhUU9QTUVtazNO?=
 =?utf-8?B?Ynd5b09zdVB4enNVQW5tNGlGVjlLZ0dYS3hEV0dtd2xnU0VpRmNiWWZhVFhr?=
 =?utf-8?B?QVJsVE45d3lBeFNJVUVqbWV2dVhIMDdLVUxxVDdxNE9wbTZYT2JoSW9MbERV?=
 =?utf-8?B?WGsxd0RWQnlENUFnWUtBNER5WnRaajdaemVjRzU2cm02dlNmc2ZqMEhHZVlr?=
 =?utf-8?B?ZkI4by9qcytSYmpmcXFHYk1uOERrR3dKVFNnY2N4R05QTjVOaFdQUkFselZ0?=
 =?utf-8?B?ZnZCVEh0VTY5ckttZ3h6dkFBeEQ2aVA5bUF6ODM1VjAwQnRqc0lmQkVQOUtT?=
 =?utf-8?B?TTA5OURWbFBDekZQNmlGcDk4YVVrMFp0OGhtck1HTlN0Z0kxWW9zSjYvclA5?=
 =?utf-8?B?VkJkZm1UOVZYWWFGa1A3WDFyY1NuUzJoODBkSkEyZnU3c2lBRDMwYkxDUjcz?=
 =?utf-8?B?Q3BSN2gvYlJuSlpBd1R0aXF1MW5jRWVja0hxckovRDZ1QXlCdEJJbEJHSVc1?=
 =?utf-8?B?SDRzanYraGg2UnZGWlppNGhGWExsWGMrbFhWQUNPNWpDbVZkdnRGNDQrRFk3?=
 =?utf-8?B?S3M3em8venczS0FEN3Q1YnY2dGJtRzhEUjE0QnlaNXdYVkdXaGxaaTNyOUdC?=
 =?utf-8?B?ZnF6VVV1aU5kR2k4N2tmOUtMcFloTmlzNTlzVTN5SlFnQTUrSVo0ZnEyYldl?=
 =?utf-8?B?MUhEVytzYnovRmtSbFdoWTd2b3VhS3RFaklxb3F0WUYweFRpUkVBbnhTQkZy?=
 =?utf-8?B?L3NOWlJJOWZIbkhCaXZ3MkZNL3JONGNBMkV4dzlLUFF5TDR3b0ZWNnVYRmJ0?=
 =?utf-8?B?c29pUmhXNDNvenNvV3RrZ1FHQTlHSElUcmZPV1E2VzRvNW5GWUxjNWxMTFFB?=
 =?utf-8?B?SEFYL0VyOVZBOThaL1E5TVJCMGU2ci9rdURhRkNRdnlhc3JiWUxuRWptT2Fr?=
 =?utf-8?B?Z0J1TDVxZXNSL2pTOFdEczd5RVAzS1hPNkh0QVhQc2tWWXlBYm1xWUNsZEdt?=
 =?utf-8?B?STNITlh0Y0l0STh6TFBvSEJya2l3ZzhXZHBJeTR4TFE0MjF2elRtM0VPalRO?=
 =?utf-8?Q?fyOlHHuK6CqrEdFW8gVp+u8IZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bb2653-40cd-45b1-e736-08de1f8b07ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2025 12:25:12.2388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raL+tdX/UjrQmTrTGhTcrzglUjHtuv/eGZGEEGbiFSKLZt8qPg4cPI+mn76mRjMhBgUlcmvIuxRYUr9V2/B6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZmVuZ2NoZW5nd2VuIDxm
ZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT4NCj4gU2VudDogVHVlc2RheSwgNCBOb3ZlbWJlciAyMDI1
IDExOjMzDQo+IFRvOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+OyBkZXZAZHBk
ay5vcmcNCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZzsgTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29x
dWVsaW5AcmVkaGF0LmNvbT47DQo+IENoZW5ibyBYaWEgPGNoZW5ib3hAbnZpZGlhLmNvbT47IERh
dmlkIE1hcmNoYW5kDQo+IDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSB2aG9zdDogZml4IHVzZS1hZnRlci1mcmVlIHJhY2UgZHVyaW5nIGNsZWFudXAN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gT24gMTEvNC8yMDI1IDQ6MDkgUE0sIFNoYW5pIFBlcmV0eiB3cm90
ZToNCj4gPiBUaGlzIGNvbW1pdCBmaXhlcyBhIHVzZS1hZnRlci1mcmVlIHRoYXQgY2F1c2VzIHRo
ZSBhcHBsaWNhdGlvbiB0bw0KPiA+IGNyYXNoIG9uIHNodXRkb3duIChkZXRlY3RlZCBieSBBU0FO
KS4NCj4gPg0KPiA+IFRoZSB2aG9zdCBsaWJyYXJ5IHVzZXMgYSBiYWNrZ3JvdW5kIGV2ZW50IGRp
c3BhdGNoIHRocmVhZCB0aGF0DQo+ID4gbW9uaXRvcnMgZmRzIHdpdGggZXBvbGwuIEl0IHJ1bnMg
aW4gYW4gaW5maW5pdGUgbG9vcCwgd2FpdGluZyBmb3IgSS9PDQo+ID4gZXZlbnRzIGFuZCBjYWxs
aW5nIGNhbGxiYWNrcyB3aGVuIHRoZXkgb2NjdXIuDQo+ID4NCj4gPiBEdXJpbmcgY2xlYW51cCwg
YSByYWNlIGNvbmRpdGlvbiBleGlzdGVkOg0KPiA+DQo+ID4gICBNYWluIFRocmVhZDogICAgICAg
ICAgICAgICAgICAgIEV2ZW50IERpc3BhdGNoIFRocmVhZDoNCj4gPiAgIDEuIFJlbW92ZSBmZHMg
ZnJvbSBmZHNldCAgICAgICAgd2hpbGUgKDEpIHsNCj4gPiAgIDIuIENsb3NlIGZpbGUgZGVzY3Jp
cHRvcnMgICAgICAgICAgIGVwb2xsX3dhaXQoKSBbZ2V0cyBpbnRlcnJ1cHRlZF0NCj4gPiAgIDMu
IEZyZWUgZmRzZXQgbWVtb3J5ICAgICAgICAgICAgICAgIFtjb250aW51ZXMgbG9vcF0NCj4gPiAg
IDQuIENvbnRpbnVlLi4uICAgICAgICAgICAgICAgICAgICAgIEFjY2Vzc2VzIGZkc2V0Li4uICAg
Q1JBU0gNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4g
VGhlIG1haW4gdGhyZWFkIHdvdWxkIGZyZWUgdGhlIGZkc2V0IG1lbW9yeSB3aGlsZSB0aGUgYmFj
a2dyb3VuZA0KPiA+IHRocmVhZCB3YXMgc3RpbGwgcnVubmluZyBhbmQgdXNpbmcgaXQuDQo+IA0K
PiBXaG8gd2lsbCBmcmVlIGZkc2V0IG1lbW9yeSA/IEkgY2hlY2sgdGhlIGxpYi92aG9zdC9zb2Nr
ZXQuYyBhbmQgZm91bmQgdGhlcmUNCj4gYXJlIG5vIGV4cGxpY2l0IGZyZWUuDQo+IA0KPiBJIHRo
aW5rIGl0IG1heWJlIHRoZSBodWdlcGFnZSBmcmVlIGJlY2F1c2UgdGhlIGZkc2V0IHVzZSBydGVf
em1hbGxvYygpLiBJZiBpdCdzLA0KPiBwbGVhc2UgZXhwbGljaXQgYWRkIGl0IGludG8gdGhlIGNv
bW1pdCBsb2cuDQoNClllcyB5b3UncmUgcmlnaHQgSSBkb3VibGUgY2hlY2tlZCB3aXRoIGEgZGVi
dWdnZXIgYW5kIGluZGVlZCB0aGUgZmRzZXQgbWVtb3J5IGlzIGZyZWVkIHdoZW4gaHVnZXBhZ2Ug
ZnJlZSwgSSdsbCB1cGRhdGUgdGhlIGNvbW1pdCBsb2cuDQoNCj4gDQo+ID4NCj4gPiBUaGUgY29k
ZSBoYWQgYSBgZGVzdHJveWAgZmxhZyB0aGF0IHRoZSBldmVudCBkaXNwYXRjaCB0aHJlYWQgY2hl
Y2tlZCwNCj4gPiBidXQgaXQgd2FzIG5ldmVyIHNldCBkdXJpbmcgY2xlYW51cCwgYW5kIHRoZSBj
b2RlIG5ldmVyIHdhaXRlZCBmb3IgdGhlDQo+ID4gdGhyZWFkIHRvIGFjdHVhbGx5IGV4aXQgYmVm
b3JlIGZyZWVpbmcgbWVtb3J5Lg0KPiA+DQo+ID4gVGhpcyBjb21taXQgaW1wbGVtZW50cyBgZmRz
ZXRfZGVzdHJveSgpYCB0aGF0IHdpbGwgc2V0IHRoZSBkZXN0cm95DQo+ID4gZmxhZywgd2FpdCBm
b3IgdGhyZWFkIHRlcm1pbmF0aW9uLCBhbmQgY2xlYW4gdXAgYWxsIHJlc291cmNlcy4NCj4gPiBU
aGUgc29ja2V0LmMgaXMgdXBkYXRlZCB0byBjYWxsIGZkc2V0X2Rlc3Ryb3koKSB3aGVuIHRoZSBs
YXN0DQo+ID4gdmhvc3QtdXNlciBzb2NrZXQgaXMgdW5yZWdpc3RlcmVkLg0KPiA+DQo+ID4gRml4
ZXM6IDBlMzhiNDJiZjYxYyAoInZob3N0OiBtYW5hZ2UgRkQgd2l0aCBlcG9sbCIpDQo+ID4gQ2M6
IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbmkgUGVyZXR6IDxz
aHBlcmV0ekBudmlkaWEuY29tPg0KPiANCg0K
