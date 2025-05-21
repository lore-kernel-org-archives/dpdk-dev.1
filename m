Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752CDC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 04:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74CB340E35;
	Wed, 21 May 2025 06:43:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
 by mails.dpdk.org (Postfix) with ESMTP id 9717B40E34;
 Wed, 21 May 2025 06:43:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRaYDBN3OEsALaXp+GBqhVb07Vs4bdCkpGbTv5WVNNvGLDTJaTmKetWl0O7gqtD0nkmomWPC2XlJtXzAG5fNn1DE/PvYEieq6qQrn3DiKKiPy5uzHYceox12cQN41YUISlGopfDYAQfL8qehYPOGyFMU7gYirIsEfmWS8wJw5jkTsM75bOHjpjtUni7IIOwEnVslJ5fUbPyq4El7oLR4QJvsFpvohZ4m//xSrUn4b4azM1Cy0kP53Idw+moanHfXg2w2G7xl0DSXHHGOCsVMY8vIdyAsyrIDs1QvKzOxZpIeXCfJYiidV2XB6yOtdpxAZViTmk/L83exrAIZ1A15Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb/1hbJfjNyhmLyi1CXB7cOm59/nXzmJWc76YFrH56Q=;
 b=E/p5SnOD25M2y5TpxmYYFpSfo5cKvr1QbPvgX2kWWfactWP98SHLpZls/j5jZgVH853V1FF4ZdMmpvr3pmm/rwp8LK6P/omF6P+DWQi7RV6y8CII2GTJTUmWU+fjA91GuTbLFqClkKh7vTn5BYf/KPpdtXBFkvVlbhr4x6+wQgrUZGPpX/qa5EkXUS8ewNyfyHPRG5VdUDCpFEysjxZfJFdas4hzU1Q5Y0xiyHVs7h+GHGZIhl1jdbYUygD8YUFGu1AJdDEBa3j65yjMaG1RLu4JfcyFPPeE+ypNXZKNC6v29VX9rZsRIP4qHp+pfm/KYaboDOF/aoT6Fk+7PZR4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb/1hbJfjNyhmLyi1CXB7cOm59/nXzmJWc76YFrH56Q=;
 b=eHjQN7YYKxKwd+XVs3IhQg2Bz68x3XEcqNUPDPoL2iYYZ7zsKHt4PbRmr6bOciDUTH1ZgXL27Usuv1xn2Y9HZdq4zXsTCFoFqDqZKCJeW7zB5llL/LIWc/SQWc2UV4VpVU9niiwnu86RdnCFwJo5+kNUiZWNE1rG1p12aMUIPCn1jUf8MxSQrDCRS7GkjzBFGQ7nR72jifBIMXjzPlxMbZkN32nRoRfESwo0fvOpr3V7H0VYG207GsZ69/uxmfliRDe62xNSqPgw2cv/NRqIObT2YXHgpu7evF5sT/hXR3cIY78xur56C4ggBt8WFmHvF2VbC8Vlr/gvS+xoxrXiYA==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI2PR04MB10713.eurprd04.prod.outlook.com (2603:10a6:800:275::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 04:43:33 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 04:43:32 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: "Hemant Agrawal (OSS)" <hemant.agrawal@oss.nxp.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Franck Lenormand <franck.lenormand@nxp.com>, Akhil
 Goyal <gakhil@marvell.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 1/9] common/dpaax: fix invalid key command error
Thread-Topic: [PATCH 1/9] common/dpaax: fix invalid key command error
Thread-Index: AQHbyUtN+0BN7vDRoUa0b8i6mr9KgLPbCs2AgAF0tqA=
Date: Wed, 21 May 2025 04:43:32 +0000
Message-ID: <AS8PR04MB8198F46218698044184463A1E19EA@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <ae4e769e-80fd-a4fc-7f80-ae71815a9d9a@oss.nxp.com>
In-Reply-To: <ae4e769e-80fd-a4fc-7f80-ae71815a9d9a@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|VI2PR04MB10713:EE_
x-ms-office365-filtering-correlation-id: d50564cc-e58a-43ed-b3a6-08dd98220a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ZDZxa3NwajFERmtaWmJkOFpFMDBsMXdjWjJOSXJraHlZb1EvcVd1MW5PSFNk?=
 =?utf-8?B?M3lldzFRNUNtQkxadHhLMkEyOTc4alA4bXkvTzI5NGxPSUx3MngxN1JtaXdF?=
 =?utf-8?B?OEdMYy9lMko5TzYwVFBxWGlGMGVYNWxINHNkS2tFdGdPTzljbkkzRTlaMkpa?=
 =?utf-8?B?c0dRZERCbnpxTjBVTnR4ZStvK1hKK1hlbWlhaHVMVzdndzg5MGtDKzFvQllF?=
 =?utf-8?B?UkpZbnJ6ZzZIMEhGN2tZdlY3aUc4alo4dGcyVjB3S0NVd2MzNUptdzZFNFBJ?=
 =?utf-8?B?MFJwM1NsbDhLOXFaVVNyWUIzTlUrb3dkazJld3lkWjdOaTJLVFA0RmN6T2Jk?=
 =?utf-8?B?MFhZV3VQS1BMS0d5TVh5U1c3WSsxTStnVU9mOVFQcTEzNUUzc1RXbEtURFEz?=
 =?utf-8?B?NHc5bzF4UnFJUDdzaG1WdWdnWGlPREpEMmhmYXkxczNCaG1JVXlmdUMyaFFC?=
 =?utf-8?B?cHo2MDRSMTBRTGlJYTZXQVRyclNCaDMvb2VnQmhEcUJqUWYwSmZ2dWQzdjhz?=
 =?utf-8?B?ZndWOUtRRG5wVzhTVTNwZ0JuanArU0dab2xNOGtKMFgwempPUjQzdVVzb1lT?=
 =?utf-8?B?bTVJdGlnVTl1Yjdma1ZMa0tweWVFWngvRVFPZS9OVys4Z25MNVlLS1pOa01t?=
 =?utf-8?B?ZXZ6YTBXekZmTWpidkZ2TUNNVldxbks5bG82WXVGbytTZmMrd3NZUDlxUEk4?=
 =?utf-8?B?dXY5NGRiaTZVZ0FvdGEyM2lEZFk5dXlPUWEyZkFxYjhKUzFnTk1XdUdkQ2V3?=
 =?utf-8?B?R2tNaHo1UWdLRFQvQWtuR1UxVkpCK0ZqTGRxU3gvNU16ejUrKzU4QWEvS0F4?=
 =?utf-8?B?clpUSmlEYWZKZ2JhbUgzTCtIWFhRKzBDQ2hhYVJEUDZLTkhDOUNlOFFObjdN?=
 =?utf-8?B?MlhBN2p3UlNHMUVUaXN0WTAxZW1oVXdVUklxeFpOV2VnT3RlS2F0aEQ5Z0R3?=
 =?utf-8?B?WlR5YXZrc2dUc0txRGRkL0RVclE3WjhHQjZvcCtkeEFmc3ppNi8xcys4N1VT?=
 =?utf-8?B?WmRKOXpabmk5OEFXbi8yY1pnMmgxMUxlYW8ySU9yeUxNN1RQU2RDOVFCeVVS?=
 =?utf-8?B?bjRtSGhrU1BHNVNZRmE5QXg2ZG9BNmQ3aU1BeUJOOGxudDNXY3MvbkE4Rjda?=
 =?utf-8?B?bGdPQkNub1IzcDhkNEE2d0E0NHFBazZWYXY5UFNPcDBvTkt4RUFGek1zZk9O?=
 =?utf-8?B?NC80MVZoYTYzWUxqZFNWQnpLRnNkWkhCZ3BDRU9aeDl2U1Qxczd1azliU1Fi?=
 =?utf-8?B?MVc0SzE5citGUU5uMm1QTS9FcU9KOGYrb2hOUnVNRlRNRnRHcTBYVThlT2Na?=
 =?utf-8?B?Yjh0YVlDOGlwdkplMWplQ1pRWnU3Z0MzVHJxcW54eEFvQnllbmJyYWduQlFw?=
 =?utf-8?B?bk45TWorN2pseCtEYWJEcWVJV3diR0c0akRsWGhsTk1nanJCS3RBbEdmMzNM?=
 =?utf-8?B?enFDS3pzaExOcWtmYXYvK2VaMHBWQk5TTStBVCt6RzRZY25UNEMwd3gvOFU1?=
 =?utf-8?B?ZkE5OUVxQkdWaFZQZEszY3RXL2NCVzY5SHY1ajcrOHBMc2FqNWtnNHRlaUsv?=
 =?utf-8?B?a2Vqb2QzczIwbmlNU29GakRzSVNOZjdrTGx6WUVjenlmQm9kNWk3cFVkQThX?=
 =?utf-8?B?VzdNcnRpVnI3bUMyWmJ0VTNHWUI1TEEyQUlNZXd3TDJPb1NsVFp6WDRHS01x?=
 =?utf-8?B?Y050alVrTmROdkJiaExZcDhCRmRBYUowSHdxaGlDYXMwUXJhSmZTRWwvWjY5?=
 =?utf-8?B?Y09keHM0NUNzOVJOM3drSVNsMmNuZ0I0ODhiYzYweG15K0J5V2Q5V3BCaGRv?=
 =?utf-8?B?V2lUMDRBb1dnbFZyUVhMTW92OE1QaVRMcXZtZ2x6Y3UxY1BSOUhSa0JRYWVT?=
 =?utf-8?B?WVQyMEhaL2U0UUVEN01KUkwrNURrOWlxckI0ME9vdXhPVlM0U3MrbmpFOERM?=
 =?utf-8?B?V3VYV2NmUnloZFJ4VWViaC95d1BRZTRCSEE5SGZueE1jVXQ5NEZRQmFjd3li?=
 =?utf-8?B?WWY3WlJ3WEJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEp4OVpjUHJQSU81Z2xsNUxxREtBUXppNXNEVmVaQ283dGlCR1pRTHFMQUEv?=
 =?utf-8?B?aEU1bG80VlBiZzY2a0puZGF6WEFsZm5TWWMvWFB0N3YweE8zajcxdVJtczJW?=
 =?utf-8?B?eFhOQlRsTEZWeTdVNDdpRGRlTHV5Z3AxSWswL3YvV1FXcE5XUlMvT1RtV09Q?=
 =?utf-8?B?UE9wa0pzRG9iSGZ1WEZBQXpudVNPZjlweUlkQ1JWb1RKenBJc2NpSEhqdits?=
 =?utf-8?B?VFRBcGc5UlVMWEtvUU5tMW9BcWF5amU2YlR5eklPUDRXbVVBbE5FV1lIRHps?=
 =?utf-8?B?U1Z1UlFjNW84ODlpSjF5TTdhLzRJbFppYkhaMnA4NEtza0dHbUdqRlkvSldq?=
 =?utf-8?B?Ry9CQkE4Qm9IcFVnRm8yeXVnKzA1MmZ2VWJRM29ERGl0WnI5Tml0cEdBYUZL?=
 =?utf-8?B?T1Q4NWFUWEROcWhIVVNHek9pV3F5WHFETUlIZGFaekloWVRjTmVURU5oN1RK?=
 =?utf-8?B?N294bVhybnlIVmRVV2hJbEEvK1Bmak1kYVF0WTduZGx4MHF3RjZJeTBMM1Ju?=
 =?utf-8?B?REZsVmNIZjExVnF6Mm1DcjVhMTZyVGd5eHRlMGlMMTNsdE93V09XbnNCL3lB?=
 =?utf-8?B?ZHJWblYzUmVEUGRCS0xHaU9WNGhPSnQ4bTZweFI3YlBmbThzejBvU3N3YkpZ?=
 =?utf-8?B?dGprbEE2ZUlCcThiZTZKY3FMRUtNMDBmTEFyWmlzQisyLzMvN0dPdDlFOWNM?=
 =?utf-8?B?c2Q1b01FUHFTVm1GSTU2VjM5NzlXb2dxZXRvTlkxSlpreWE0RUVCRkJKYUF6?=
 =?utf-8?B?M285enlxbkozSTNmWkt0S1ZGVzJ0TUpUQmhhVUFDSkFCSktCSUoxNlZJOTdN?=
 =?utf-8?B?aWJmaW5ac2RZSEpoc3cwOGg1SS82cEhIeWRwbWpxb3hnWDBxZldGbXFJaklm?=
 =?utf-8?B?YXgwZkJEYXg4Z3RzZSttRkduMTVJZ2JvZE1ISlRHR2JGbjF1ZXZ4QU9BTktM?=
 =?utf-8?B?UnRZNlZ3L2NWWCt3bUlCY1FSazU3eHlBakQ5VnJpSkd3Q3h1bUVMcGNpa3dv?=
 =?utf-8?B?Tjh3WUkzRUVZTG11YytDTXh2ZCtYais2TEdabHpOZ0NqUnZFcnladkR2Ylo2?=
 =?utf-8?B?b21FWjNWNDFKN05kajNpejNuQlNtaWNWZGFnOWxXMCt6cm1sR09TSlRkT01K?=
 =?utf-8?B?cDBmeUp5b1d1MzdkRmYxd25pUFZyM0J6U3FUN3cyZWxqNGJTY0p4RXBhUmIz?=
 =?utf-8?B?SG1oMkd1M1hYQ1RBVzZNcHRJNmFaU3JDN0dRMThiZDVqVm8rZTl4WEE4d1l0?=
 =?utf-8?B?cEsrKzduZS9pZmsrbTljRUE4amRjT2xwZTUvd0dhVkV5eEpFc1M1Qkp4MnZ5?=
 =?utf-8?B?V1dXOW5NV2FIWC90SVc0cVJ3ajl1VXR3YVNJL3A3VjFHeEUydUFyQWFhRjlM?=
 =?utf-8?B?dmxhQjJaMWVtL29ER1J6WDN6UlJxWjhmWTlkSlpENFRsQWZ3ODBaYkJFTlJX?=
 =?utf-8?B?VjFqMDIvUnQzNHQrMjdDSmtIenlvendQVXFUUERGNTIwTXg4WnExZVlWTDNZ?=
 =?utf-8?B?L1dxYW02a3RxWGM3bzBwUkhXMm5seHpxNDNmMzZnbGY0dkZmcHgzNnd6cFlG?=
 =?utf-8?B?bFN6ZnB1QWlHTHc2OXRvSmVSZ2dqb0tWcEZjNTRmWHVWOGZ2U3VMWU9GcG4y?=
 =?utf-8?B?ZWhEdkdKVEZYSmg1ZXBCN1B4TExLazFnbkJkRWRLQUhncEdNQytCb05LeEhF?=
 =?utf-8?B?VzgrWi8rVUNkcG9hK29COWRWekltODdNQWRENW51UGlnMUJmMm1wemV5UHNQ?=
 =?utf-8?B?Zms3WjhDZkJDanBlL2VjcW5HckZYc0VNTEVwSHRtc1pGbjQweElSL203V0JS?=
 =?utf-8?B?WWo5eUhqd3NJV0lLejd0TnJVc00zSTBRTlR6eGtBYjZSOWFNa2Z3SVJnUEhH?=
 =?utf-8?B?UEF1eVpRNGpWc2VDRWxEMzVSMnNCZjQ1N3dVaWhNMmtVdFpEUm9zZ3I1VkJr?=
 =?utf-8?B?YTFKd0NYeHBhaW9mNUVVL09zc213SEROQWZLSmFTWGxWL3h3dUMzNUh1QnR6?=
 =?utf-8?B?Skl2R0dPcEdrRHUyUE43YmdXdW5WdU5Ed1BCVjE3L2RITDBBdHkxMllVVzFH?=
 =?utf-8?B?dGplM3FBczFYV1Q2bGs5dm1LaHRMOXNTcjcxam5PUFpKS01DakljVG54MzEy?=
 =?utf-8?Q?9mc0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50564cc-e58a-43ed-b3a6-08dd98220a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 04:43:32.5968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGL4IgT5Z/4E7BoHGVer4CwAM3WzwAXBDhUivclhfcKxwK4ljVdBDqSMEALV9X76
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10713
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVtYW50IEFncmF3
YWwgKE9TUykgPGhlbWFudC5hZ3Jhd2FsQG9zcy5ueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXkgMjAsIDIwMjUgMTE6NDYgQU0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8Ry5TaW5naEBueHAu
Y29tPjsgZGV2QGRwZGsub3JnOyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhw
LmNvbT47IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhlbmFAbnhwLmNvbT47IEZyYW5jaw0KPiBM
ZW5vcm1hbmQgPGZyYW5jay5sZW5vcm1hbmRAbnhwLmNvbT47IEFraGlsIEdveWFsIDxnYWtoaWxA
bWFydmVsbC5jb20+DQo+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzldIGNvbW1vbi9kcGFheDogZml4IGludmFsaWQga2V5IGNvbW1hbmQgZXJyb3INCj4gDQo+
IA0KPiBPbiAyMC0wNS0yMDI1IDExOjIxLCBHYWdhbmRlZXAgU2luZ2ggd3JvdGU6DQo+ID4gRHVl
IHRvIHJhY2UgYmV0d2VlbiBLRVkgbG9hZGluZyB0byBDQUFN4oCZcyBpbnRlcm5hbCBtZW1vcnkg
YW5kDQo+ID4gaW5pdGlhdGluZyBjcnlwdG8gb3BlcmF0aW9ucyBjYW4gU0VDIGVycm9ycyBpbiBQ
RENQIEFFUyBhbGdvDQo+ID4gY29tYmluYXRpb25zLg0KPiBQbGVhc2UgZml4IGdyYW1tYXIuDQpP
ay4NCg0KPiA+IFRvIG1pdGlnYXRlIHRoaXMsIGFkZGluZyBDQUxNIGluc3RydWN0aW9uIGluIFNO
IDEyYml0IGNhc2UgYW5kIHVzaW5nDQo+ID4gb2xkZXIgdmVyc2lvbiBvZiBkZXNjcmlwdG9yIGZv
ciBTTiAxOGJpdCBjYXNlLg0KPiA+DQo+ID4gRml4ZXM6IDYxMjdmZmY4NDJhNyAoImNvbW1vbi9k
cGFheDogcmVtb3ZlIG91dGRhdGVkIGNhYW1mbGliIGNvZGUiKQ0KPiA+IENjOiBmcmFuY2subGVu
b3JtYW5kQG54cC5jb20NCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBHYWdhbmRlZXAgU2luZ2ggPGcuc2luZ2hAbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+
IFBsZWFzZSBzZW5kIGNvdmVyLWxldHRlciBmb3IgbXVsdGkgcGF0Y2ggc2VyaWVzLg0KU3VyZSwg
SSB3aWxsIHNlbmQgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICAgZHJpdmVycy9jb21t
b24vZHBhYXgvY2FhbWZsaWIvZGVzYy9wZGNwLmggfCA2ICsrKy0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NvbW1vbi9kcGFheC9jYWFtZmxpYi9kZXNjL3BkY3AuaA0KPiA+IGIvZHJp
dmVycy9jb21tb24vZHBhYXgvY2FhbWZsaWIvZGVzYy9wZGNwLmgNCj4gPiBpbmRleCA5YWRhMzkw
NWM1Li5mNDM3OWVkZTJjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY29tbW9uL2RwYWF4L2Nh
YW1mbGliL2Rlc2MvcGRjcC5oDQo+ID4gKysrIGIvZHJpdmVycy9jb21tb24vZHBhYXgvY2FhbWZs
aWIvZGVzYy9wZGNwLmgNCj4gPiBAQCAtMSw2ICsxLDYgQEANCj4gPiAgIC8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBCU0QtMy1DbGF1c2Ugb3IgR1BMLTIuMCsNCj4gPiAgICAqIENvcHlyaWdo
dCAyMDA4LTIwMTMgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4NCj4gPiAtICogQ29weXJp
Z2h0IDIwMTktMjAyMyBOWFANCj4gPiArICogQ29weXJpZ2h0IDIwMTktMjAyNSBOWFANCj4gPiAg
ICAqLw0KPiA+DQo+ID4gICAjaWZuZGVmIF9fREVTQ19QRENQX0hfXw0KPiA+IEBAIC0xOTgxLDgg
KzE5ODEsNyBAQCBwZGNwX2luc2VydF91cGxhbmVfbm9faW50X29wKHN0cnVjdCBwcm9ncmFtICpw
LA0KPiA+ICAgCUtFWShwLCBLRVkxLCBjaXBoZXJkYXRhLT5rZXlfZW5jX2ZsYWdzLCBjaXBoZXJk
YXRhLT5rZXksDQo+ID4gICAJICAgIGNpcGhlcmRhdGEtPmtleWxlbiwgSU5MSU5FX0tFWShjaXBo
ZXJkYXRhKSk7DQo+ID4NCj4gPiAtCWlmICgoc25fc2l6ZSA9PSBQRENQX1NOX1NJWkVfMTUpIHx8
DQo+ID4gLQkJCShydGFfc2VjX2VyYSA+PSBSVEFfU0VDX0VSQV8xMCkpIHsNCj4gPiArCWlmIChz
bl9zaXplID09IFBEQ1BfU05fU0laRV8xNSkgew0KPiANCj4gSW4gZGVzY3JpcHRpb24sIHlvdSBt
ZW50aW9uZWQgMTggYml0IFNOIGNhc2UsIGhvd2V2ZXIgaGVyZSB5b3UgYXJlIG1vZGlmeWluZ8Kg
IDE1DQo+IGJpdCBjb2RlPw0KPiANCj4gYW0gSSBtaXNzaW5nIHRoZSBjaGFuZ2VzIGZvciAxOCBi
aXQgPw0KVGhlcmUgYXJlIHR3byB2YXJpYW50cyBvZiB0aGUgMTgtYml0IFNOIGRlc2NyaXB0b3Iu
IE9uZSB1c2VzIHRoZSBQUk9UT0NPTCBpbnN0cnVjdGlvbiwgd2hpY2ggaXMgYXZhaWxhYmxlIG9u
bHkgaW4gU2VjdXJpdHkgVmVyc2lvbiAxMCBhbmQgYWJvdmUuIA0KVGhlIG90aGVyIHVzZXMgdGhl
IE9QRVJBVElPTiBpbnN0cnVjdGlvbiwgd2hpY2ggaXMgc3VwcG9ydGVkIGluIGFsbCBzZWN1cml0
eSB2ZXJzaW9ucy4NCkhvd2V2ZXIsIHRoZSBQUk9UT0NPTCBpbnN0cnVjdGlvbiBoYXMgc29tZSBp
c3N1ZXM6IGl0IG1heSB0cmlnZ2VyIGFuICdJbnZhbGlkIGtleSBjb21tYW5kJyBlcnJvciBkdWUg
dG8gYSByYWNlIGNvbmRpdGlvbi4NClRvIGFkZHJlc3MgdGhpcywgSSByZW1vdmVkIHRoZSBjaGVj
ayAocnRhX3NlY19lcmEgPj0gUlRBX1NFQ19FUkFfMTApLCANCmFsbG93aW5nIHRoZSAxOC1iaXQg
U04gY2FzZSBvbiBoaWdoZXIgc2VjdXJpdHkgdmVyc2lvbnMgdG8gZmFsbCBiYWNrIHRvIHRoZSBv
bGRlciBPUEVSQVRJT04tYmFzZWQgZGVzY3JpcHRvci4NCj4gDQo+ID4gICAJCVBST1RPQ09MKHAs
IGRpciwgT1BfUENMSURfTFRFX1BEQ1BfVVNFUiwNCj4gPiAgIAkJCSAodWludDE2X3QpY2lwaGVy
ZGF0YS0+YWxndHlwZSk7DQo+ID4gICAJCXJldHVybiAwOw0KPiA+IEBAIC0yNzQ3LDYgKzI3NDYs
NyBAQCBjbnN0cl9zaGRzY19wZGNwX3VfcGxhbmVfZW5jYXAodWludDMyX3QNCj4gKmRlc2NidWYs
DQo+ID4gICAJCQkgICAgKHVpbnQ2NF90KWNpcGhlcmRhdGEtPmtleSwgY2lwaGVyZGF0YS0+a2V5
bGVuLA0KPiA+ICAgCQkJICAgIElOTElORV9LRVkoY2lwaGVyZGF0YSkpOw0KPiA+DQo+ID4gKwkJ
CUpVTVAocCwgMSwgTE9DQUxfSlVNUCwgQUxMX1RSVUUsIENBTE0pOw0KPiA+ICAgCQkJaWYgKGF1
dGhkYXRhKQ0KPiA+ICAgCQkJCVBST1RPQ09MKHAsIE9QX1RZUEVfRU5DQVBfUFJPVE9DT0wsDQo+
ID4gICAJCQkJCSBPUF9QQ0xJRF9MVEVfUERDUF9VU0VSX1JOLA0K
