Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ABCDE014
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:39:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C2FC40262;
	Fri, 14 Nov 2025 07:39:07 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
 by mails.dpdk.org (Postfix) with ESMTP id 2F3E540151;
 Fri, 14 Nov 2025 07:39:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLlFcFrMPglVVUzIjqpd77M0U0AD87kt4h0ChQARPkaZwuh8NcpfWGwiw72V5P8gNn6/g9jvSP5qAGTc5vynwIsAtyXdKOecEgwyR/dJ+tOKhmHTMLYlOH19vNEvTIT1gcjSalpOWnywW5gz1iaZxhp4P9+tAxdzR+ZKqWCyJ/HLqaZP4fDRpEUhzS/4vhZcwqY4kVU3BirrbhvN6aki7zfMrl3K6pewAWS75ICJXBryfNSI7nAqZlbZ3cVxCjXwEOry0gqf695QmLli4F2x7XA13pTu6b639V0r4vP0q/a8mpaG27pTNFnlLC4GOVNGJcEh/tJZsM4Aoa9ggQRxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgKjQJKwhtrw3N+pB73zXu3A+bqwF00nTvDL9ApENeg=;
 b=ZpvX6+ht7uLRCSchyT+EsA97n65OXtMzQZ6/XnM14pCwm0HVjA7LGxjhtrM1mjcYi8pLRoTwW205GmHNNnCxpnd/m1H30X1ETVtK7ICBVzqGL2Vou8Sjii8AnVNjMCkG0HOUjIYZLwBCbOGSeUyygu2wopmuNHCvY972bHkE4SKI2POfFTZkbiULGHOi6EXZuyccZHYsw28u2Ga7vYczMTP8OXALloDjb9Jwo1jfmhtgvHSnu9oDOV7IJ2vmpCE58lQ9pydytwM7NemlcMwlJMONFF4LjRMQG5/HLQ/vSgcbB/vLauCVnRxC0wcnfSj6HdAr27/aCY3zMhvpNV+Aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgKjQJKwhtrw3N+pB73zXu3A+bqwF00nTvDL9ApENeg=;
 b=aZo/Bzcqo+BmtWjisqg6qHYtSctW16B56d0rtt9h/nbAa+TH2ZnQnKuWyEekabJ+jKt1LnODG2DKS5laDrs2Z+gi3je6mqm+BwXIf4q3I+hV0zIaRp+3o6R2bvixXkkcpYzugQIrQtb9EkwLugfCU4Ksz4yOwv0zCapLrlYt5j12bAgePcPsmr4lZiumS+490JWumTWItkvEA252IX6gbb5cUn/u8+yo57Dj9+8e98sJasgs7dTNf7kmwY2vM/cwv8A4pcs4FUI4Wl7AdTckyRH2/E4hdjnhe2pnAb53TZSLPpo9T5DVZQUi8I9mxofcVoMjpN2ai4d/pIfqruZe3Q==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PAWPR04MB9805.eurprd04.prod.outlook.com (2603:10a6:102:37e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:39:00 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:39:00 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Maxime Leroy <maxime@leroys.fr>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v4 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
Thread-Topic: [PATCH v4 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev
 close
Thread-Index: AQHcVJLULkv2/lib+0+rrUj2de7zJ7TwtlgAgAD9tRA=
Date: Fri, 14 Nov 2025 06:39:00 +0000
Message-ID: <PAXPR04MB93282E3134036441D54558D889CAA@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <CAHHRULUuCi6cm=9QEW_m=ZMKJQ2bGPGH50f3YzjeL2p3KQ1Thw@mail.gmail.com>
In-Reply-To: <CAHHRULUuCi6cm=9QEW_m=ZMKJQ2bGPGH50f3YzjeL2p3KQ1Thw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|PAWPR04MB9805:EE_
x-ms-office365-filtering-correlation-id: 12b01d3a-e292-4be3-ab7d-08de23487efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SHpZaGV0VUc2N0paSGR4SG1xVWZaMHkxVGVCdmI0d1BOZEcyZmgvZ0xzY3R3?=
 =?utf-8?B?THRBZDhucEVKYy91V1BBT293RmZJY2ZENS9Wc3U0cEErRkZDNnFtSGk3bHh3?=
 =?utf-8?B?VjRCZ1YwNVZJMkJQMkloRjg4UWlBdXQxb3N3WUQrNWFsMkQrM01zM1Boa2Fs?=
 =?utf-8?B?eVBvMWRucFpTSEFkajZqVzRycEFQY3FubVBScWZUd21ySjRPNTVKNkhFVGJz?=
 =?utf-8?B?MnhCNzZ0QWpVM25hZlhaS3hjbmZwLzNSWmJLVHZLekMwM3RDMXF3Zm44QW9y?=
 =?utf-8?B?eFNBOU1wUllzTHBaTmxUK3NWMXdHVUxqdzJnOFByZjNYOXJFajhNbmJNaXpl?=
 =?utf-8?B?VGovM3p0dktsN0JtNmJGcnpkUDFPTC9zRVBtb2dMTE1PRVM0UVJTd0F5Ni9B?=
 =?utf-8?B?Z0ZGSU0zRVpUTjVqNkVWTjV5SklGV1I2RHh3czFLT2lxMnJmN2pkaEJRRDhq?=
 =?utf-8?B?L24rc08vcnU4Qkkwc3cxT0VaSWNoN1RaTTY5aUdnSTVkVm5UbHJ5djV2bHRM?=
 =?utf-8?B?dXkvOWsxellXMDBzMHg1OGRPbWtNcHBqZExMME5hTDhwUG5OcGFZTTNGbEtF?=
 =?utf-8?B?RG45U0VtWmowczlFdDIvbVMyRXZEaitCdXZkQ1dRTVJ6VkMwUFd3amVHay9r?=
 =?utf-8?B?bUNMejduYU9GcTRXZG4wT3RZS3VFZFRNZWJ1b0cwQjRxalJhVU5wK2NVdjc4?=
 =?utf-8?B?QlJvSDd2ZS9xYzJVTTNSY1BOMHd5UUxxR3o1VXRVUU45L1dpN0pBdlIwR2sw?=
 =?utf-8?B?QlovNVlDSmZteXdCNCs2NDdBeGxsN2tOSGRVckNadmdjTDJ0NGlSZFVseThj?=
 =?utf-8?B?WEJuUENQTCs4cjZCQlZkL1J3WDlLeWhxUTh2dHRoZFRwZmZKWWRRYVAzRmhl?=
 =?utf-8?B?RGR3TFRiWmhlSldMbjMwVG40MjZWWDNVVzkrN3R5Y0Qrd3B0eGluclF2N1pq?=
 =?utf-8?B?WjNzUExIUk9ObTVnaGtJQlFNS2RJTWxXc3VYa2pxYzgzLzVHOWNHMjJsSXV1?=
 =?utf-8?B?MmQ0SEZ1VjFBa2thUnI3NlV4QWxzRWtIc0hvSkpsV0ZlVUsrby9oQ0xtR3V2?=
 =?utf-8?B?Yk94RDRUUHkwNnhYSHVLRVNPRTRXODBDNUNISlZBWHB5SGluaWdwdFdnU0Qy?=
 =?utf-8?B?MTJuKzBxRDd3M3lxdTZBdjhld0VPWFd1T1lQOVl6cXN0Ym5mN3pOUng3REtP?=
 =?utf-8?B?WVlLUExnaUJaWU1zd0lRT1lOS2VndHdZVGxUdGwwT2orUXNIMmZQa3RkMjJF?=
 =?utf-8?B?ejNudDdFbjJDS1RrcW92b0xuWm5sNC82TG1MQkR1THZqZzhFTFYyOEJwdTc5?=
 =?utf-8?B?Zk1Bd29ITEhxek9kdTBkcGRGcjFMcnloVzlKQ0hYNEJKaWlyUmdwektuN2wz?=
 =?utf-8?B?UkxINDYzc2pmL1Y2d2lpM1lvRHBkQXZxK2ZyRCt0MWhzaitpNnJsR1N5dCt3?=
 =?utf-8?B?Tzd1eDdCTXhnYXlTMFd6SzRZc1NNajhTNHpDeDQwUXVaSGhFaEh2Z1k1cG43?=
 =?utf-8?B?Umh0Sm9lSlFLYXdOZjE3eXkzRlFUVmM5QStyNmxuTzM4cmVQbktUc2VyU1Zy?=
 =?utf-8?B?T2JHNHozemh2UVVUTmRjOFlaTE9MVGdnd20xRWNrSTVnUDM2RkhSQ1R1TmU0?=
 =?utf-8?B?NUZrNlpZTGNMY3dyeEY1TVBBZmhnN1NZeEY4WS9Ya3NqZlV2R21UdmhZRENU?=
 =?utf-8?B?WXJReXZBRzhkRnJueEo0OFZvVHdJUUdVbzJVQnBuNzRMTmFWTGcwZnhqUVhC?=
 =?utf-8?B?d3JNVmd4VGo0cnBMeFd1Mmdpc0RTdVNKQ0RYL2YwUkVXeE9CMXphM1kwbXp1?=
 =?utf-8?B?M2RndWtwSzhobDNRL1F2SEtyM1Z2VGc1R1FVaTI2bFZTSkRSc0hHelFDbC9S?=
 =?utf-8?B?dFBwNWtUQllSVEplYkhPcDJrMlcwcVRURER0TDVxaStEb3E3aDFQMTZZeGxq?=
 =?utf-8?B?OE1zUzg1b1JnVW15VzU3UmNqdStFMTBJZ3MzNWgvL1JEVElxVjBmaHNnLzBn?=
 =?utf-8?B?bW52ZXZxUm03eUh6WTExZW5IR3BKVlNFbE5lR2VUSTdNeWFDQnVoQWJBS2dK?=
 =?utf-8?Q?OlBBeD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVM0cllnY0JJK3ZXVS83dTIwL1diNzlLb3QySmtNWFJYb3IzQVY1OU1BL0li?=
 =?utf-8?B?YnVNakdYU2hUaEMyeXpVOFpFUFl6UUhaUXR0Sjd3aWpjdVRaVUZjMDFzazFu?=
 =?utf-8?B?WTNPYSsxaURXekFuM2tYZkhmNnAwd0tWYy9BOVl3TXd3aU5RRnVTZ0RqRHBZ?=
 =?utf-8?B?c0lIa2ZQZmZlNFJFQ2dLdjZWWVprT1haV3luNmRjSmJkQjNzQjM0NDdOalR2?=
 =?utf-8?B?UmRraTlBUmZURWUzR2Q4MmgreXNtMGM5SmFLMXlodGE2dHJ5d2VPQmR4VVRM?=
 =?utf-8?B?ZldMeWlZeVY3a2E2VlA1Tlg5TlhkZVBYUkVDWksrNnpXeUwrVGtMa1ozM0Fv?=
 =?utf-8?B?Rmdyczk3aWdGSlpkZjc2U3ZwWWFidlJXL2xMYjNpUVh3ZWJsZUhwVkNzTXJm?=
 =?utf-8?B?MjdnWGx5eE4wRmd0V3haYXA3RzJVcVJaeXlnbTBEanhIaUdZTFlvbzM3Smli?=
 =?utf-8?B?N04yeXZMWGdvY29mOWxCSy9RVHF6SjgrVmVvWVNMTm0zVk1rUURBcndaU0Jq?=
 =?utf-8?B?NzdsWjVnOEpMaHhsNHpySCtPL2ZzMjRQTDFVSTZMNitqSXhDemFZL0NEZ2V0?=
 =?utf-8?B?K3dRWXloM3N2V1FaamN3TFpBaDdOZTVuZ0hkMjNxaERPK2NlTWZNNTVIUk1T?=
 =?utf-8?B?VGRBOE1QUDFZODFpMFNIQlJ1NFdWMGYzS3lKVXh6UWZETnFVWmtCdDFPTXZ5?=
 =?utf-8?B?YzFyK0g4aXBDZGh4TVZQRDVBN1dVVFJIWktXOUdUQXkvQXlGYVhXelU3UFpX?=
 =?utf-8?B?cEhQVmVYUWVGaVhFT3VUNTBMSW5GUzUwdWZwMERZQ1JiWWJOWFE4b1VUWjd1?=
 =?utf-8?B?K3BDaitqQitqYnBuYXhSMUl2YXZpdnI0aXVZb09sbjdWbjZVYzZmK0FYZkpY?=
 =?utf-8?B?dklOa1BTY0xJa0svbnBLNnR1bGkyalR4REprdkZ4ZmI3eTBaU1hDTWRQcDZN?=
 =?utf-8?B?ZmNqdHF4U1FBKzZNU0JVQVduS2RQSjNBM2tnaUJmZWVENDhFZ1JqYXN3WnIv?=
 =?utf-8?B?NXlLbGhSam1oU2tVdlhlcThOdFQ2TXlnUVYxcUxRTnVHaHFEa1ZtQnJaN3lm?=
 =?utf-8?B?QXIyUDNDekh5OGFUK2QwNk5lYkdlTk5XajNIVjE3ZEtnZ0toUldBbHcwNEVZ?=
 =?utf-8?B?WVJ6V2hVRVkxUHI4Vlp4YVpJc1NvVHZ2MWxWamZtb0hMSXZvTnVPMVhGVjkx?=
 =?utf-8?B?L2V1bGRnUEVJNzVrbUNqdFZtWE5lUEtnYTArdFRPR3pKNmVvRW9GV3R3a0o5?=
 =?utf-8?B?SDUzUEF2clNIUHlGSkthSldmVWYwQ2p0c08yRWVCVTFRRTRBZWw5UHNiS3lr?=
 =?utf-8?B?OWtFYUtLeG5OUkwwWjVRMDZzazhHeGFHTjVWbW1nb1lZZ0Y2dEtHaE9XZVlN?=
 =?utf-8?B?dWtPTEMwSVdQMnFPUloyZGdLSEl1OW92R0tCdXpKWWJPeTQ5Mnp6OFI0YkN2?=
 =?utf-8?B?bmpVZUsySm94RlRuT3RVL090ZW5kNXVxSExYZnQ3WXRRWHovSGhZU2Z3ZkVT?=
 =?utf-8?B?ZEhYUFUxYlRrSjNPZmVoZ3p0WVhRejQxSGRYZS8zZU1FM2I1bmVyM3d5SHdC?=
 =?utf-8?B?Q0J0Y1pQZlZGYmJpMW9aWFhpUXp5ZEJ2RUNVbmRCeHppdnFzWHNHNXU4bWY0?=
 =?utf-8?B?ZXRJSWpGV0tlMjN2UTkzTytsdUFndGNVdFo0dGJvTVdEYWVlL0NJQWU5ZWtO?=
 =?utf-8?B?OGhUeFJESVlYcGpYb083cElycGw4ZG5jZHhuV2pSVVhJMW9TdXZlRUlRSWxU?=
 =?utf-8?B?eWRQbzA5UXN0My9hVlRudzZ4WUI0NDRPdDUrZU0xYjZUN2ZNSXJyV2Nxd00w?=
 =?utf-8?B?SE9rZzU4Z1R6U0w3MVFOV2hyVEQxczJUMUZ5TFJCaVZyQmJuOWhqYXZQODF4?=
 =?utf-8?B?QU5UL0IvVXQyS1BOMnBYbUs4eDBvYVUyVHZncnlTK09CYk9SZGp2b2U2Mm1m?=
 =?utf-8?B?cXIzTWRkT0ZQSTJob1BQUDR1disvd2pHOUx3aUtSM3AyRmk0NkRPeVBsREVR?=
 =?utf-8?B?ZXZpOUc3YjVXY25aZlJlWWtIMHp5TW56UytnbEFwU2h2cldDZW1RUFY0MjJr?=
 =?utf-8?B?WXBCMms5MXhEbGR6S1FWY0g0dVNuUTJUbGhvRytnMUNIMDFzZGpUYzlhZnR0?=
 =?utf-8?Q?R0hS8eodmGvyPqeBjn9IOLdeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b01d3a-e292-4be3-ab7d-08de23487efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 06:39:00.7518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoDXdxAzVbSi9pNtAjnADfow9luw8JjKBHC9NL4vTCBkbgzrl6XgGjBv/wjzUGxrmPO1zqXoLf/gRLgtpWeP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9805
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

SGkgTWF4aW1lLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1heGlt
ZSBMZXJveSA8bWF4aW1lQGxlcm95cy5mcj4NCj4gSGkgSGVtYW50LA0KPiANCj4gTGUgamV1LiAx
MyBub3YuIDIwMjUgw6AgMTI6NDQsIEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAu
Y29tPiBhDQo+IMOpY3JpdCA6DQo+ID4NCj4gPiBXaGVuIHJ0ZV9ldGhfZGV2X2Nsb3NlKCkgaXMg
Y2FsbGVkLCBpdCBwZXJmb3JtcyB0aGUgZm9sbG93aW5nIGFjdGlvbnM6DQo+ID4NCj4gPiBDYWxs
cyBkZXYtPmRldl9vcHMtPmRldl9jbG9zZSgpLCB3aGljaCBpbiB0aGlzIGNhc2UgaXMgZHBhYTJf
ZGV2X2Nsb3NlKCkuDQo+ID4gVGhlbiBjYWxscyBydGVfZXRoX2Rldl9yZWxlYXNlX3BvcnQoKSwg
d2hpY2ggcmVsZWFzZXMgYWxsIGRldmljZSBkYXRhDQo+ID4gYW5kIHNldHMgZGV2LT5kYXRhIHRv
IE5VTEwuDQo+ID4NCj4gPiBMYXRlciwgd2hlbiBydGVfZGV2X3JlbW92ZSgpIGlzIGNhbGxlZCwg
dGhlIEZTTE1DIGJ1cyBpbnZva2VzDQo+ID4gZGV2LT5yZW1vdmUoKSDigJQgdGhhdCBpcywgcnRl
X2RwYWEyX3JlbW92ZSgpLg0KPiA+IEhvd2V2ZXIsIHJ0ZV9kcGFhMl9yZW1vdmUoKSBjYWxscyBk
cGFhMl9kZXZfY2xvc2UoKSBhZ2Fpbi4gU2luY2UNCj4gPiBkZXYtPmRhdGEgd2FzIGFscmVhZHkg
c2V0IHRvIE5VTEwgYnkgdGhlIHByZXZpb3VzIGNhbGwsIHRoaXMgc2Vjb25kDQo+ID4gaW52b2Nh
dGlvbiBjYXVzZXMgYSBjcmFzaC4NCj4gPg0KPiA+IEZpeGVzOiA1OTY0ZDM2YTI5MDQgKCJuZXQv
ZHBhYTI6IHJlbGVhc2UgcG9ydCB1cG9uIGNsb3NlIikNCj4gPiBDYzogc2FjaGluLnNheGVuYUBu
eHAuY29tDQo+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvbmV0L2RwYWEyL2RwYWEyX2V0aGRldi5jIHwgMTUgKysrKysrKysrKy0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RwYWEyL2RwYWEyX2V0aGRldi5jDQo+ID4gYi9k
cml2ZXJzL25ldC9kcGFhMi9kcGFhMl9ldGhkZXYuYw0KPiA+IGluZGV4IDdkYTMyY2U4NTYuLmZj
NjNjZjRmMDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZHBhYTIvZHBhYTJfZXRoZGV2
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9kcGFhMi9kcGFhMl9ldGhkZXYuYw0KPiA+IEBAIC0z
MzQ3LDE0ICszMzQ3LDE5IEBAIHN0YXRpYyBpbnQNCj4gPiAgcnRlX2RwYWEyX3JlbW92ZShzdHJ1
Y3QgcnRlX2RwYWEyX2RldmljZSAqZHBhYTJfZGV2KSAgew0KPiA+ICAgICAgICAgc3RydWN0IHJ0
ZV9ldGhfZGV2ICpldGhfZGV2Ow0KPiA+IC0gICAgICAgaW50IHJldDsNCj4gPiArICAgICAgIGlu
dCByZXQgPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIGV0aF9kZXYgPSBydGVfZXRoX2Rldl9hbGxv
Y2F0ZWQoZHBhYTJfZGV2LT5kZXZpY2UubmFtZSk7DQo+ID4gKyAgICAgICBpZiAoZXRoX2Rldikg
ew0KPiA+ICsgICAgICAgICAgICAgICBkcGFhMl9kZXZfY2xvc2UoZXRoX2Rldik7DQo+ID4gKyAg
ICAgICAgICAgICAgIHJldCA9IHJ0ZV9ldGhfZGV2X3JlbGVhc2VfcG9ydChldGhfZGV2KTsNCj4g
PiArICAgICAgIH0NCj4gDQo+IGRwYWEyX2Rldl9jbG9zZSgpIHJldHVybnMgYSBzdGF0dXMgY29k
ZSwgYnV0IGl0IGlzbuKAmXQgYmVpbmcgY2hlY2tlZCBoZXJlLg0KPiANCj4gRm9yIGNvbXBhcmlz
b24sIGluIHJ0ZV9ldGhfZGV2X3BjaV9nZW5lcmljX3JlbW92ZSgpLCBpZiBkZXZfdW5pbml0IChp
LmUuIHRoZQ0KPiBkZXZpY2UgY2xvc2UgY2FsbGJhY2spIGZhaWxzLCBydGVfZXRoX2Rldl9yZWxl
YXNlX3BvcnQoKSBpcyBub3QgY2FsbGVkLg0KPiBIb3cgc2hvdWxkIHRoZSBkcGFhMiBkcml2ZXIg
aGFuZGxlIHRoaXMga2luZCBvZiBlcnJvciBjYXNlPw0KPiANCltIZW1hbnRdIFRoZSBjdXJyZW50
IGZyYW1ld29yayBjYW4gb25seSByZWNvcmQgdGhlIGVycm9yLiANCg0KPiBCeSB0aGUgd2F5LCBp
ZiBpdCBtYWtlcyBzZW5zZSBmb3IgeW91LCBmZWVsIGZyZWUgdG8gYWRkIGEgVGVzdGVkLWJ5IHRh
ZyBmcm9tIG1lLA0KPiBzaW5jZSBJ4oCZdmUgdmFsaWRhdGVkIHRoZSBzZXJpZXMgb24gbXkgc2lk
ZSB3aXRoIEdyb3V0Lg0KW0hlbWFudF0gc3VyZQ0KPiANCj4gUmVnYXJkcywNCj4gDQo+IE1heGlt
ZSBMZXJveQ0K
