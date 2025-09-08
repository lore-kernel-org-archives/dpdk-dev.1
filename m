Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB846CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 12:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB0240156;
	Mon,  8 Sep 2025 14:13:02 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by mails.dpdk.org (Postfix) with ESMTP id 7A9A34003C;
 Mon,  8 Sep 2025 14:13:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkZf8VZ4QXyS489UKGiLtfAgr8DMkZiIPtGEwetFcBrUD1iEe7E7a/rqciQ1GX2XY2PsjEjHyE0rFVC+WtUD4Cr561oVNARebLU1fxYabcSKo6/L8vF+wMJKm7NZy+BLlBmdaw1YIAv7+P0Gl2WrJeGT/Ro67K2oN2J9a2pKkC0tfvo6cxJzyK+cnKjoeUg6/pPLJ17rfvrrnKigSWTp2gdgLwCnfMZhjXtEgvMyaPktAGf/LTidf7QoXUPM4zQq6MptoqUQkQGsjSF4sIOwsAvPbGG2ZJHcUL+U1bAfQ3H2enmyW0X3crgteCxHd5ppOrZlRbcyFuwC+ahYUiJw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh77hsoe+YDI7ywWzul1GxOi8s04ZD8uAFFeLg7eZIE=;
 b=eUx+ZBcqU7IySGfkWZ6DYeR/HM34k3qPRyCHNOsLO5DYlb6MQaRHO54FcCLz+DK2+ZxgTLnwvDKZ58nwuSem8QOfvRyEo8pLPDgAKto4NBM0uZqYLrzKuk6OVWUZaQD7v+V8LLdzp1cR0VOm9iL2YY5OvZiPckEWyg4d9g8vBTgTytEtoihCB1/7619IQ/OY3QdHA3UX6zMMXUSA6an7TlcOuvZkOdGkxkUbWL99LsRAGOTtLQgPERKV2XAh6gwbUeTxONB6E8OZB7NWKK+jFGnSX2KEoLObA1nr++AzjvnOVStwfFF03nPJyNnYPAQapnlz9ZmvEqmGp8UTEv7k1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh77hsoe+YDI7ywWzul1GxOi8s04ZD8uAFFeLg7eZIE=;
 b=uqUJ0dz/2EXU+UHrDoahBbjoI9eOKZBk7vsr5J0ABDQJ8/I7rF8DsPTdS6kzvsIAHKKC8Et+gxYNH1B39za2CMwbn9hKAKsR/B+JylGocofhHfhLU+tmx8S2AmEBs55DEgDZZ36LY36hszf7f+mOClTaxMcwkAlir7EBUw8zP2Znhy4YZtZcR2mJ8Sv5uqn/UdURQ8tbHpeVl/n5wUNIB22aCg9/YhZjSng0XiHFhaSUGT1D+xqA6tXYu5xfYc31C34Ok4G+7jhiV1YfniU3uX/BGf3uFB4h5ETBx6VhuXFJBPYjHMv0E4DM5KDPiHZQIrZhdD2xuKU7WJZkaQUolw==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 8 Sep
 2025 12:12:58 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11%6]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 12:12:58 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Raslan Darawsheh <rasland@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Matan Azrad <matan@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
Thread-Topic: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
Thread-Index: AQHcBP2D0r430y17b0+KTPID4dfAMrRoCgCAgCFflpA=
Date: Mon, 8 Sep 2025 12:12:58 +0000
Message-ID: <PH7PR12MB70187E047E4CEB99A96FBB2DB20CA@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
 <9769c8e7-3259-43c5-812e-c61fe3e3f1ca@nvidia.com>
In-Reply-To: <9769c8e7-3259-43c5-812e-c61fe3e3f1ca@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: 66945168-8e2b-4bfd-6b0f-08ddeed10c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RmxoRE5hZ2g0T0VlZ2xIdm1RdXF6VDg0L2Z1ajdMaWMxUnBURmNUb3dCNWFX?=
 =?utf-8?B?UnNuREJoa3dJN3F5aUVSQWZaUnhTYW05aExZWHV0WEt6WmJYdUs4enNINFBD?=
 =?utf-8?B?alJ5N1NRc3hlWVo4ejVDY0FubDFMQnlIb2NoNDlnc3duSkJKdDd1Z1dBRjE5?=
 =?utf-8?B?Z09LZ2I0d3ozM3MrOG9UUDV1a1F5Rk9BMUtBSFU4aWIrNWM3VzZEWlE1bk1Y?=
 =?utf-8?B?bHB2L2hMOTVlVnBOZVZiVjE0SkZzL2h4UDdCQ0RrNGJoWElFMmVsbEltS3ls?=
 =?utf-8?B?YnJoNGlWRkpwSGs1SDVrR3o4STdOeXcrZW5GalhrbHVGRWRNVzlGa3Q1eDVj?=
 =?utf-8?B?SXgyS0wrYkdJRHNLWnRoYWdVU2tJem1EaUVUZHZTNi9naGlLTGtLYlAwdWJN?=
 =?utf-8?B?YS9iNFZSK2tIcDIyQU1vUkdDUXk2OWpVYms0Zk0xQ2lJeDhOL25YSUZGeXFy?=
 =?utf-8?B?WW9IN3ZwNHk2MEo3N2JDMS9MbXBHSW1HY3NnZHpUbnhOZ3ZkbFBmaExqdktE?=
 =?utf-8?B?YlFIZjVEU3BxUmZYR1c3ZGs0bXlFUUQwcTF4aTN5ZFBHRmc4aENrVHYvYlpn?=
 =?utf-8?B?K2tVOWNCZHFiblV1VUErWlRIcHhUYXRNNktoM2plSEtTYnM2LzVXeHk4UVdG?=
 =?utf-8?B?OHVBMllwZUd3R01XR2dFeWxKcHFGUWcwbXNUV0lEU0E5ZEg1WVFndWQvL2xO?=
 =?utf-8?B?UTRpZjVvNHBoZHl0cFNJeWRMcmUxMnFlVGxzOXpwNnNKRFBmYTlHZE95eUJk?=
 =?utf-8?B?R2o3TkxFb1JWdXJlTVMrUVhIY1JRdWd4YmRyYTFYVVA3TUNNMXpQVldocHZo?=
 =?utf-8?B?WjlsY1JRNVgrK3Z4Z1BQZTBIYVhTSjc0NUhFZk52WHpDWlRuME4zWlRnQTFS?=
 =?utf-8?B?dEZ2VEVBR0QyY0tITVEwdEhha0FwZWVqTkJlZEdTb3FSMXpRd3lGbkszOHcv?=
 =?utf-8?B?akZNbjNFbGQ1Y0JhVmppUHZudElCNVpCQkx1a1daQWVNNEc4VUJkckVYQjhP?=
 =?utf-8?B?U1FKd3cyZkppUVBUQkhPS1hWMFNXakE3VGZ5aUo4YXQzK1puKytLaDdMNTBa?=
 =?utf-8?B?RFhZNUltWk5iYzVwL21CdXlDdGhvVWphZDk1VjZGeDQ0QnNwdWM2V013WnM4?=
 =?utf-8?B?b1kwNmRJN2FhV1pOZUJxeTNzeDREeGRjamMzODBOTk5JKzZNRzJmRktQSmdT?=
 =?utf-8?B?RVVpczh3OFlaWlRtTG1mWkwzT0xKQTRBbHZydGYrWlRDaXFQcGcvblBONXFN?=
 =?utf-8?B?VWhPOGdKSXhFNktRbmdFRUxGYlBYalpzUzRjdUx5REdwVHBFc3pnaXllUWkv?=
 =?utf-8?B?SjJ4S29na0R3SjlKVXUxRVFMM2k0ZklyK0J3emZFaUN2eisrUE5kVjZSMjIx?=
 =?utf-8?B?a0VqWFdqSlluYlVyRElwOUduWVAzaVZRSTVYaWVnUXhKODM0WXo4UFJYdUhG?=
 =?utf-8?B?TTNNanhaRGNtVks5Q1dVU296RmNiWC9HRDJUenJGcmkreVFnUWlzNTh0RHZh?=
 =?utf-8?B?ejBsTnFhK3E0SHUrY0lPdmJXaVlocDRiOFpQTlJITFdmVWVJZUowYVg4Wml4?=
 =?utf-8?B?Ky9FU0VPckMwYU9tUCt6ZGczU3ExMmw4bXNBQXZZcFZvVFA3VVpCQUdaMTVw?=
 =?utf-8?B?UUUwSVFaRGRRQ1NpOFVNK1IxanFHRnBmR3Q4dmhLSExnWUpIbE9oSlc0aFNP?=
 =?utf-8?B?YmxnaFpJZUtxclY2ckx2MmZ6RHhJb3d4WDVoK0FJVlZSVWlBSzJyeW5zSnJ1?=
 =?utf-8?B?aUFNSXBaUFFWRVRKSE9OWmMxQlhuOGdhcEpLNlBoNnRybnBRTVRlRHJwelFs?=
 =?utf-8?B?UVhqeWxmWUkvTjBPZnJRV2cwV2ZmcytCZjlCZENHKy9ESU5NV1M4S2prcStC?=
 =?utf-8?B?cnprbkF0MFppSi93MENYYWlVZTZyc3VJdGFVd1FHNTIzdlpZQnl5Q2JaRE9k?=
 =?utf-8?B?MjNLaW1MQnRlL2lWano2Ni9XVFBwa1A0SS9idWhjblF6N0dwS3FYQ2FhRyt2?=
 =?utf-8?Q?8ya6X5JwuivWlr1ZZ7+qzIm/IZF4MY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFRNY3VlampXUUhEOXRldVhrb3J3VStjcGpFaC9TeWJ6Nmo5eHhOa05yTjlt?=
 =?utf-8?B?V0pTeTlMeEtxU05CNk1LeWozUk41L1hGZEErbGRhelgwczFBRGJkZDBnWGFL?=
 =?utf-8?B?eUV2NU1lTitwNUUvQ1lHYUN2V1h4WUVCNzBSY2c5N29kWG9GeFJrTnZ2VjN4?=
 =?utf-8?B?NTRKZmFUeThJZjFsSlpYYUYzSUJYWFVFTzJBSm9kL2hqMWVkbm8weWFNNkVZ?=
 =?utf-8?B?d2RXQ0tMeWtodkt4TUJCZ0kvTjB0ZzlwM3hCb1AwZm9xV0dTWlpBYXVpSEN4?=
 =?utf-8?B?THBkTFV6UlloTXVIYXRWcFVpUW8vcUd0cTViYjJtL1c0OCtWLzV3QWUvUGs2?=
 =?utf-8?B?NzZuY3ZCVXZIMHMra1BMajZvclpzRGUzeGIvRm1kbXlBTFRvTlBBMmNuVnJy?=
 =?utf-8?B?UXo4NGNWUW5PTG9HWWFxdWhvNkhhVXFlU1JVOHJ0Sm03TXUzWnhPQWZBa3lO?=
 =?utf-8?B?b1BwMGlnZGdxdzgxdXpPZGw3UkFNNXp3VTNjRWE0R1lEbkVMVWowOWg2MDgv?=
 =?utf-8?B?WGl2ZGZ0TDU3OHFWR0loNTc3c3ZMNTBJWjFTVy9pSFVhMTMxcnZpYWFNcEox?=
 =?utf-8?B?SHMwWW8zZWZ2TWFFTmdWZDZRNVhhZGtTcUlzbnd5SUxHbko1cXIwUmJaSjUr?=
 =?utf-8?B?dFh5cmxER0lvbytjdGhtZHdjSGVJcFV3bmh2Mjd3VzcybytQMlFnQnBWdVlH?=
 =?utf-8?B?SmdreUNkWVZZVkI5SXBKVHFmYWVoM1NuaVdPTlluSUI1TWtmSmM5UTlJN1Bs?=
 =?utf-8?B?dU1LL3MwdE1TTXlvVlRhcnJqaE0rajRCYnVEVWVNWTUzejJ6allTemdZK1d3?=
 =?utf-8?B?czk3aXMyalNSbThaZkN6VlZQd1Nyb0RrOHR3RExYbTl3NzQwc2wydDJmUXoz?=
 =?utf-8?B?NjRZNUJHY3JDTUhiVENzRUQ4VEZxZW5US0ZmS1RMZ1dVMXcvaWFQVS9BTzZQ?=
 =?utf-8?B?MnFwdnp6M21WeTUvNHQ5OTB2NHRXUzVKV2Vpckh4UVp2cXU4QTRGMzZ6dDVH?=
 =?utf-8?B?TVFtREM5SHRtcjc1WE1YbzJ3RkRwQTY1OTNkVVJORmRkWlF2SzlBQ0JlcXdG?=
 =?utf-8?B?dFN0NzV2K2RMWjlBSjlpajMzK3ppN2FBNXRxbXBOV0RuMktQWmFTS1FyNHB0?=
 =?utf-8?B?d1JBRk1kbDJhbkNyNVhpMkxMSStwdmxpZFlRblpPeTlEdmRMcGh4dW5oVTd5?=
 =?utf-8?B?VitwNXk4OVQ2STlBbVdtVVplZW1CdHFYeWszMU8vTEc3d0t2TFc1S2hFaFNa?=
 =?utf-8?B?UmNyTEFjSTg0a21hRzJIeUpINzFackw2UlBLelRWdUxudi96Mndrem42NURi?=
 =?utf-8?B?dGN2R3RWRDBsanN4ak5yLzN2MVhHWXFRYUVLRVlqNE1oYnB1ZXBJTVFVYVQv?=
 =?utf-8?B?VVpmN05UakJCUVNQQTdwUUp4a3NrS1pnK1BWd3ExTWg2RWtLWG1iNEtvUUxn?=
 =?utf-8?B?V2o3VTd1eFl3aWd5UitvL0RYSnlPMk1XbDFEcnJuUFNNeGxrNWRDM08zcUdu?=
 =?utf-8?B?RGR2ekZwckY5bHpNbmhyUWlVdUk1cnpXa2V5Sm52blhBamtSYXI2dXBlV2lt?=
 =?utf-8?B?WkpOVmxIaTMvMk5id1JZaHdISkpMbDhMaEhFNGVQZytnL2h6eTRIMWo3cW1o?=
 =?utf-8?B?N0NKeGJBQmg0UWcxRkFhNVc5L3dqb3JyYjJLYXQwVyszSmh4ZHhnN1JuMXdz?=
 =?utf-8?B?MWpicDUvSEtYT3RqMUl0RU5kRmkzeHkyOU1odTRPZnlWd0g3MHBkakNoZDVI?=
 =?utf-8?B?U0IvOEtxMkM5TmppNmExRk5aMVNzRDNTZFZkelcxUDVESTBQaWZHQTBuWmtW?=
 =?utf-8?B?TUtGUmVySXhqbTR5ajZ0UnVZcGRxNXVEdjAwaFRTVVBWSlMwc0xGV1QvMzFD?=
 =?utf-8?B?YTY4TTFhN0h3ZzZ1c0prTEF1SktZNlVhOFZ1L2Q4V0ZWbkt4c0Y4b2NIVlRF?=
 =?utf-8?B?Y1FsMEhYKy9VVU5uSndNUzc4UjU4c3dzalNyOW9oVDZhNHZvOFhHQk0wT3Ir?=
 =?utf-8?B?dmhGR2VtbWp1RVhwVmZ1RE53RmFIRVlMSlNKSU9FQlhlRkdHSXZrY0dUUTQ5?=
 =?utf-8?B?eTRoN1RXeUN1eC9rYVpVNDdHcTdmczRnT0tYakUvUUZUUDVCTzFUZlNwakZC?=
 =?utf-8?Q?IrPe+8WSaClP1UwChPh9KbaRI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66945168-8e2b-4bfd-6b0f-08ddeed10c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 12:12:58.3732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Afxu1eEd5bdC9vmNKMnGHetS7Mo77CJaagjjyBsASKd8MWc0Q2iFJjOURYdy7YBepEEMzTLdk6TpclwRYMTQ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

UGxlYXNlIGRyb3AgdGhpcyBwYXRjaCwgDQp0aGUgbWVyZ2Ugd2FzIGluY29ycmVjdCBhbmQgdGhl
IGNvZGUgaXMgaW5jb3JyZWN0Lg0KDQpSZWdhcmRzLA0KTWFheWFuIEthc2hhbmkNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXNsYW4gRGFyYXdzaGVoIDxyYXNsYW5k
QG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMTggQXVndXN0IDIwMjUgOTozMw0KPiBUbzog
U2xhdmEgT3ZzaWllbmtvIDx2aWFjaGVzbGF2b0BudmlkaWEuY29tPjsgZGV2QGRwZGsub3JnDQo+
IENjOiBNYXRhbiBBenJhZCA8bWF0YW5AbnZpZGlhLmNvbT47IFN1YW5taW5nIE1vdQ0KPiA8c3Vh
bm1pbmdtQG52aWRpYS5jb20+OyBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEu
Y29tPjsNCj4gc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC9tbHg1
L2h3czogZml4IEVTUCBoZWFkZXIgbWF0Y2ggaW4gc3RyaWN0IG1vZGUNCj4gDQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gSGksDQo+IA0KPiANCj4gT24gMDQvMDgvMjAyNSA4OjA1IEFNLCBWaWFjaGVzbGF2IE92c2lp
ZW5rbyB3cm90ZToNCj4gPiBUaGUgcGF0dGVybiBsaWtlICJldGggLyBpcHY2IC8gZXNwIC8gZW5k
IiBtYXRjaGVkIG9uIGFueSBJUHY2IHBhY2tldA0KPiA+IGluIHN0cmljdCBtb2RlLCBiZWNhdXNl
IHRoZXJlIHdhcyBubyBpbXBpY2l0IG1hdGNoIG9uIHRoZSBJUC5wcm90bw0KPiA+IGZvcmNlZC4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgaW1wbGljaXQgbWF0Y2ggb24gSVAucHJvdG8g
d2l0aCB2YWx1ZSA1MCAoRVNQKSBhbmQNCj4gPiBhZGRzIGltcGxpY2l0IG1hdGNoIG9uIFVEUC5k
cG9ydCB3aXRoIHZhbHVlIDQ1MDAgZm9yIHRoZSBjYXNlIEVTUCBvdmVyDQo+ID4gVURQLg0KPiA+
DQo+ID4gRml4ZXM6IDE4Y2E0YTRlYzczYSAoIm5ldC9tbHg1OiBzdXBwb3J0IEVTUCBTUEkgbWF0
Y2ggYW5kIFJTUyBoYXNoIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBWaWFjaGVzbGF2IE92c2lpZW5rbyA8dmlhY2hlc2xhdm9AbnZpZGlhLmNvbT4N
Cj4gDQo+IFBhdGNoIGFwcGxpZWQgdG8gbmV4dC1uZXQtbWx4LA0KPiANCj4gS2luZGVzdCByZWdh
cmRzDQo+IFJhc2xhbiBEYXJhd3NoZWgNCg0K
