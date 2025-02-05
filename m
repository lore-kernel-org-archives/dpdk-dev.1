Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41831C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 07:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9FD402E0;
	Wed,  5 Feb 2025 08:27:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by mails.dpdk.org (Postfix) with ESMTP id 7BA65402E0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 08:27:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw13yIT5Wvt6WgyyP6n1XSTuLCfx91oI+vDW2J0EQeDjIrrlKe0LOXBK3TtztxkZNAQ8bf1l2RFVjLr+WzbUCdcy1vz095LLzNI/I47/hY3OGLoXqRDbR+MiUGRCiGUrDu7JiK/0Dl4/EDFFIT3sY/HEFTTpYXSCQHX8SFSOkpXasnQsBE+c8ew61aF1kRKfVId47CIBDX9XjeaLv7H22c2BKp9Vg1cEJH6AlfClv7zSjLOQgY560wboVpWk3fzzq07jij/+9AxxOcLMw5kxrOVHDKtRLXiGQBOxa1ysPKPiDVsIOKrEXEhl5U9bXXfZr2i3FCOJk4vCjIVdn0t+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMWk/kOHCj5s+USdSaEAQ/UxX/pn+JwFUAFxiPZt5jA=;
 b=gmfBhfx473MmEzBxETDXa2L1AYso0zHd+/z/rPCgc4VjmFA+vHw72kqpfrIJw6h4QoYarXqpWsNsb+ZzxgztI0dWJkDAMAOgUWxAbKlvBtIgmwLuVjGAt04YjAlKTUO91QiRimg96gwO2Ny1Y5htbZ0i3pYz1AJ0PI56+2odGWhmUCPTPWIfRxlhxuv8H7P1L13ae0X507STtgMsEmCB/OvRLJx+K37nHvPIZ/NF+ng8Nc+8+w8pr+oMfPBQtxB0qhqDJPgMrQqlXgMcegWYKW54uu55mdqKxidk3KHr4MLB8n3OCQWqS9kTOvPKNWKQSMz71TU0cPZ6xGBZIvF4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMWk/kOHCj5s+USdSaEAQ/UxX/pn+JwFUAFxiPZt5jA=;
 b=cB6Sk794EdoR+gmf95hcA46oMh5ZH+XP9kehrKZI/GmUZwabYRPXxnfXxXkGVLmp3xjcIDBJWmGQDqIpbwkyYc7QE/YthMebRhGTmq4cH6IaZWOnwa5O55vNaS7ZD/BLnKixkvUQZeifqFrzqkZ4shuINQjO9DskgQJizOMnqbqqPqXXpC6Ehd6vnFDyDAMO9sNER/t15YKOsQXE4CESk5/R4Jf2dEjnR3k1iTAw+uJp6oma3Drx708dolqbBQHYs7Bt4IKly+tW3uYEcuLbhOT6BVNB/Mn22a1ktrOTkF+dMx5l8UFwAtiD2/5nWLiLuDty1ulPTAX2asrE2Ktbwg==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 07:27:29 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 07:27:29 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 0/3] Vhost: fix FD entries cleanup
Thread-Topic: [RFC 0/3] Vhost: fix FD entries cleanup
Thread-Index: AQHbVhuD2TmdjYHFl0+X3WzF5AObBbM3YlwAgAEwIIA=
Date: Wed, 5 Feb 2025 07:27:29 +0000
Message-ID: <3EE665CF-8BD9-4F3E-8CF4-30F0A285A7CC@nvidia.com>
References: <20241224154958.146852-1-maxime.coquelin@redhat.com>
 <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
In-Reply-To: <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|MN0PR12MB6056:EE_
x-ms-office365-filtering-correlation-id: f4696170-8a24-4777-c24d-08dd45b68c2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXBuVngranNPN1N1NGRnMWdoT1RwNUsyWEpzcWRweUkySnVDRE9HRktpT29Y?=
 =?utf-8?B?emM3dTJ2djloRGdaTUhFU1NWcVgrZ3IxNFpQRHZodkIyRG5kSzQ1SllRVUps?=
 =?utf-8?B?dmw5YlMzMGdkRURwdXBTSW05UlZTS3RnZ2FuYzBLYkI5dEVDU1lrMHJhMklw?=
 =?utf-8?B?cUMxbkloMUJCTmp1cUJ2OE9FcnhFZjZEOEpGVDk0c1dySkFVYThOckdwdFZL?=
 =?utf-8?B?WlpWZGwzUUducDhBbjBjc2pWRE1CcForZ0ovdXg5TnpvQ3BQanpKZXFSOWEx?=
 =?utf-8?B?UWZmSUVuN3VoU2RWZXZhcFZ6eWxMN2JBZTVEaTkram9XWnRvN3pqSUNmZ1RC?=
 =?utf-8?B?MlB1b3F0OWVDMXdKQ1NWOHo5d3ZOMXNQTTY5TDFqMVRZUDRkUi9FaWI3NnN3?=
 =?utf-8?B?amFHS2doRmM0cHNTZ2gra2tkYjdzaGR5cjdWanhiVXBKUjJzRWRKUVNXT0t3?=
 =?utf-8?B?Snc0QzRzVXdsTHZaeklaUzV5SHdzVG9tdGp1MU9sQlk0V29VSjBjMWVDa2tB?=
 =?utf-8?B?TGJYRlBBMkswQ1c1RXBTaiswNDM2cTV6aWZzVGFrM0JrdTFLL2YyMzMrTWlx?=
 =?utf-8?B?RDBpL0dyNWNQTUJPOUU5UGhRc1lEeEhtQUlOeThqWVZYUjIxUysxdlRyVEt5?=
 =?utf-8?B?dUl3UGpVRk5YSzZnV1dEa2FYTkRkQTdhYmlGMUZycGZIL3U0TTA5c0pjTGtO?=
 =?utf-8?B?a05XOWUxVWZOaFd1Tk4zZGZPWlA1NlVaTHVUWXJRQndYWEhxMDhlR3BOMndv?=
 =?utf-8?B?aU9DaU5mUTg0aDFDcFJ1bnFQcEFNYWxwdmlWTkpVcGNGbStUdzlnVTBPb1pO?=
 =?utf-8?B?enQ3cnQ2RE9FYWxrWlV6eXlTS3IzUnB0Wm9OUU1UaTU0cFBnVDBjdkpQb1l4?=
 =?utf-8?B?RVU0U3hydkRKOUg3N29GUTRVVHFHeGJuYmVIQ0JRSFpKTENJd0tQbERJdVJF?=
 =?utf-8?B?bW1ENE0xR3FqTUlKS3Z6SXdYVVJ0WEJJWUp0Y3d6UTd1NEZ1VzlxU3kzTEwv?=
 =?utf-8?B?c3l1SmU4bEk4Lzg4MzBCWVJvWWNTZ09RZEhVSTAxL0R6NzNuTkJHa0I3c3dj?=
 =?utf-8?B?RzRMekZUM3UzeC9rb29CaFhCekxPdDNLc0V0RXpFTitnNjlJNkg1TGM0bGYv?=
 =?utf-8?B?QUR3bTFjVE4xZ3lGSmJhRVVsNjg4ckE2SWZRMlV1KzNEWW9LWk5rdGk5M2V2?=
 =?utf-8?B?M2tYK3pvQ3VqeUJlZFRvd3VLVE4xdHhqdEpxaEN0Vmt5cmovS29ibGw1eEtG?=
 =?utf-8?B?aG8vUytkQUFCZTRQU2pOcE9JQkt6R2FNcTh0RThNcFFycmRNYmRPRDNMMTh4?=
 =?utf-8?B?NGFQTVJUUExFWENoZ1pKMnB3YWM4bnlqb2twQVQ3MFMvazFQUkYwcWgybzEx?=
 =?utf-8?B?WmN6SUg5M2JVSENTR0RIZUFxazVIeXVyUDg5enNiZDFwODU1NlF5STh0K0dY?=
 =?utf-8?B?eExJeEZjMFA1Y2NIM0pSNUhubTlYNGZCTGM0T2hXak14N2ZqWFdGWFR2cEdj?=
 =?utf-8?B?ZmJNVGFxTjNXN21KanE4WHQvcDJ2bFpRYmdqT3RQeXhsT0FGa0NKMkROM3Zk?=
 =?utf-8?B?dnZjdmQ2ZUgvb3VtMytJMHhHcSsxbzNJbjh5Q1N2N2xpZTE0R3NYNis2dVhM?=
 =?utf-8?B?QUVYM01XcHFLQXZFaWkrYlVnVmtqdndPVlY5TXN0NFlxcnVia3VwMTl3bkhu?=
 =?utf-8?B?QS9VYXNFeHJjT3RtZTQrdWxCS0Rxb0x2dSt2cWVPRjF2S3NsakxkUjdJTS9S?=
 =?utf-8?B?ZFd5M1dLeE5HRE1tVU52eDRVQlZyYWNRekN6LzQxUUpWZ3ZtakFKNkpaSjdH?=
 =?utf-8?B?akE0VVE2S1c5T3dyM1BIMUZXNm5QOWduN0ZjRlFxZmovaHU4ei8vN3BuUGF3?=
 =?utf-8?B?ZXVyUlZySlo1ZEM1dUxPNGtQUWRnU1o5SHdIeUNaaVJHZ0pGUXRuaXFOdktz?=
 =?utf-8?Q?ndWmwU9jAl9ekcmeHO19IkTbGkPb3Ja2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1Ixekl2NjQ0VUJXRmI1N1FDL2Z2aFBheUd1M2s1UHVLa2FkRmFtSEZlSUIy?=
 =?utf-8?B?KytoT1dYSU03TGJsbjhSekZiK1RKbTFVMEw0dzFxa1FDYjh5OHFIQjVkZ3BG?=
 =?utf-8?B?SitzanpVT0dLZHIxTlVFeFVFcUU1MTZBSGdGRVJNa2tYSFZGNW5VYU5ZN1d1?=
 =?utf-8?B?SkFid2NITDRkc1pjWEhNR1BBek5ZUnl3RkIxZXlxT21vTXp3dlJuV05Tb3Ba?=
 =?utf-8?B?VXdIcmZGYXV2dCtETElENzJDMCtkT3FkREF0VTQrUjFBSlkyc3d6UHBEaEJl?=
 =?utf-8?B?dVFEU28vY1RXeGZoRGViMVh3K2FQckhkNWVQOFIxTUhLY1BmZXI5N2I0cnJj?=
 =?utf-8?B?OTJ0ZlFraU1CSzRvenEzUFlpWi9mb2JFOUtoT2V4akJqV0k4ZU9ibDY3bTBD?=
 =?utf-8?B?RjVrWVpCU2p6WDJnUEIyWE9BYmNXU0NpYmQyajF0Znh2TFRyRE5hMW5tOFdK?=
 =?utf-8?B?SXh5dmhaRXBLL2xOL0RHQmVqaDJoRmhpcDREbTNaTkNYMWtBMXpzNjh6UVlB?=
 =?utf-8?B?aENoZFBLbFhPeFFrbHY3TnplbHFiK3FobUpGVEl2NXZ3aDlGRnl5ZHJwL091?=
 =?utf-8?B?cDlBdlJnMWYzMzJsdURyeTVGR2VKTHIwczE5bjZDbUZtWGpHS1EyQStmaUhk?=
 =?utf-8?B?REtTM3lJM0V2SExBTGV4NHdLMjBTNTJGMjEydEJybWlHV21WbjdEZUI1dlZ4?=
 =?utf-8?B?Mlk4cjlRaUlac3NGNDdYMW1iMnlzWDZGcSsyYmZPQk9qa2NhbmRXbk9EYXdl?=
 =?utf-8?B?ejRoOG5CYng4a0N3VkYxSXovM05qVUFFTUhPVXhGVUVwOUZuY0tnQUxUVktT?=
 =?utf-8?B?Y0l4SHplOEhoQitUdTVBOWlQQzRxcERaTTk5NHpvclF6Y0hHU095M1RrZHlC?=
 =?utf-8?B?VFNodExuV1BzNWZTRUNYdEFPLzNSNCtVY1FoUkxPT3lSZGdpNkg3WE5kUHZJ?=
 =?utf-8?B?WDkxUktRY0YxajlTdmVWaHFCdXhvTVYrcGN2VGcxYUZncmR2VTRKdGFqWmtp?=
 =?utf-8?B?N1NtNW9acnI1SWxlNDZUL3NFUEF5aVovajBJYlZoVjZkeDN1eitHeXkxSThV?=
 =?utf-8?B?bmdieWdQZU4wTnN0SWlUS1o5S2M2MXVaa0NGMDZmNEZYa0FUYVRkQlF1b1lR?=
 =?utf-8?B?TEVvU2JaQmFCdHJ1d2FhRGZOUW45MlIrMy9Cc3Mwc0J2ZDJGbW1wSE5HUkUx?=
 =?utf-8?B?cm0wUms1VWtMeS9HS0lvcGdwTlVMYlM4Qzh0U0xNRHZxa1E2dTR2VFUrOXdx?=
 =?utf-8?B?UGczU0dOQU16ZTY1RzROZ2NSTVVDenMvM0VsNHlaUWVsc281aGxmZnQwZC8v?=
 =?utf-8?B?eE1kR1g1aGIwaWxqQWNydlFWVy9vV0ptL3NWUXdJR29GQmxQK1owNGk5K0VK?=
 =?utf-8?B?ODRyblBPbUYzTTZldGxmd2JvanNndWNFcFFFVFdFWkU1QkNhKzdiSmQ2MGVR?=
 =?utf-8?B?YnJ5UFNaOHBnOEpwZk9YMmMwSjA5YlUxV0lHUTAwT3h0Z2hKa3Z4c2RWbzZX?=
 =?utf-8?B?QWFiaisybWFoTW9JMzZEaDJNckRmSnhUSm0wVGUzOXB0aDN2NC9MWXNFMU5i?=
 =?utf-8?B?RGtBdmNDUG4zQkJ5NkxxZjR6ODY4UERDc2VyZVRsSGl5T1pEbVdSei8rQkJE?=
 =?utf-8?B?ZGRPczltR1grNEpWc2dQZ1RhYWNtWnIvcWsvU25hU0dnUk5BUHN4Y2tBcHgx?=
 =?utf-8?B?RlJoZkJyZ2I3Z29iNmF3UzBHTTZMcjJ2MHpnMVJIampnMXVLNm8xTkwxdDJ6?=
 =?utf-8?B?eFZnTld6V1RMdGFjeU5IT3FpZ2N1TUZldnZhb1hqU1dycUNWazY3K0xnVW43?=
 =?utf-8?B?SWdRa0w3dlBIZFlqL2Z3MkEyRm9zQmxaM2dJVk5qY05EVGJwLzFPTkRlTkFX?=
 =?utf-8?B?ZXlWU0REOTZteGpiY1BDeXJIaGNhZUxwNVFLTzJ0OVgwMW9CS09VQXJPbXpY?=
 =?utf-8?B?REdxRUsxSXFYNDBDNFAraE5pUFpiK05qcEg2VE15NWtHMFdENDBUZURtdWlI?=
 =?utf-8?B?aGMvZTh5SEU5VGhRd0lyRjYvYzBFbjBDMld4Zis0cEZjVTBhZDluSE5zVVFT?=
 =?utf-8?B?REIwWnNHUEZTN2VueCtUZXZoT0NnUzJHZXhJbVhwVjg5VVVUZGo2dm9mRU1Z?=
 =?utf-8?B?Nm9taDZsOXFTeGJoZ0trU05PaTFwRFZCSHBjRW5KTTZ2dmU1TnRRZ25SM3dF?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0EB77E56051E42B5780F564A253F02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4696170-8a24-4777-c24d-08dd45b68c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 07:27:29.4230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rIB7HwF7QITdUsPc0eCrjAoSK5yBko7Okdb9yu15b05DEp/ZiybCFzmb9AG7rRF1kYeZJlyoi2Stp4NGktETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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
Message-ID: <20250205072729.PIlAG4vmItzmw10I-EVt9f1649z2PDCnQQ2n6ha1tqg@z>

SGkgRGF2aWQsDQoNCj4gT24gRmViIDQsIDIwMjUsIGF0IDIxOjE4LCBEYXZpZCBNYXJjaGFuZCA8
ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhlbGxv
IHZob3N0IG1haW50YWluZXJzLA0KPiANCj4gT24gVHVlLCBEZWMgMjQsIDIwMjQgYXQgNDo1MOKA
r1BNIE1heGltZSBDb3F1ZWxpbg0KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPj4gDQo+PiBUaGUgdmhvc3QgRkQgbWFuYWdlciBwcm92aWRlcyBhIHdheSBmb3IgdGhlIHJl
YWQvd3JpdGUNCj4+IGNhbGxiYWNrcyB0byByZXF1ZXN0IHJlbW92YWwgb2YgdGhlaXIgYXNzb2Np
YXRlZCBGRCBmcm9tDQo+PiB0aGUgZXBvbGwgRkQgc2V0LiBQcm9ibGVtIGlzIHRoYXQgaXQgaXMg
bWlzc2luZyBhIGNsZWFudXANCj4+IGNhbGxiYWNrLCBzbyB0aGUgcmVhZC93cml0ZSBjYWxsYmFj
ayByZXF1ZXN0aW5nIHRoZSByZW1vdmFsDQo+PiBoYXZlIHRvIHBlcmZvcm0gY2xlYW51cHMgYmVm
b3JlIHRoZSBGRCBpcyByZW1vdmVkIGZyb20gdGhlDQo+PiBGRCBzZXQuIEl0IGluY2x1ZGVzIGNs
b3NpbmcgdGhlIEZEIGJlZm9yZSBpdCBpcyByZW1vdmVkDQo+PiBmcm9tIHRoZSBlcG9sbCBGRCBz
ZXQuDQo+PiANCj4+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgYSBuZXcgY2xlYW51cCBjYWxsYmFj
ayB3aGljaCwgaWYNCj4+IGltcGxlbWVudGVkLCBpcyBjbG9zZWQgcmlnaHQgYWZ0ZXIgdGhlIEZE
IGlzIHJlbW92ZWQgZnJvbQ0KPj4gRkQgc2V0Lg0KPj4gDQo+PiBNYXhpbWUgQ29xdWVsaW4gKDMp
Og0KPj4gIHZob3N0OiBhZGQgY2xlYW51cCBjYWxsYmFjayB0byBGRCBlbnRyaWVzDQo+PiAgdmhv
c3Q6IGZpeCB2aG9zdC11c2VyIHNvY2tldCBjbGVhbnVwIG9yZGVyDQo+PiAgdmhvc3Q6IGltcHJv
dmUgVkRVU0UgcmVjb25uZWN0IGhhbmRsZXIgY2xlYW51cA0KPj4gDQo+PiBsaWIvdmhvc3QvZmRf
bWFuLmMgfCAxNiArKysrKysrKysrKystLS0tDQo+PiBsaWIvdmhvc3QvZmRfbWFuLmggfCAgMyAr
Ky0NCj4+IGxpYi92aG9zdC9zb2NrZXQuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IGxpYi92aG9zdC92ZHVzZS5jICB8IDE2ICsrKysrKysr
KysrLS0tLS0NCj4+IDQgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRp
b25zKC0pDQo+IA0KPiBJIHRyaWVkIHRoaXMgc2VyaWVzLCBhbmQgaXQgZml4ZXMgdGhlIGVycm9y
IGxvZyBJIHJlcG9ydGVkLg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsIEkgd29uZGVyIGlmIHdl
IGNvdWxkIGRvIHNvbWV0aGluZyBzaW1wbGVyLg0KPiANCj4gVGhlIGZkIGlzIG9ubHkgdXNlZCBi
eSB0aGUgcmVnaXN0ZXJlZCBoYW5kbGVycy4NCj4gSWYgYSBoYW5kbGVyIHJlcG9ydHMgdGhhdCBp
dCBkb2VzIG5vdCB3YW50IHRvIHdhdGNoIHRoaXMgZmQgYW55bW9yZSwNCj4gdGhlbiB0aGVyZSBp
cyBubyByZW1haW5pbmcgdXNlciBpbiB0aGUgdmhvc3QgbGlicmFyeSBmb3IgdGhpcyBmZC4NCj4g
DQo+IFNvIG15IHByb3Bvc2FsIHdvdWxkIGJlIHRvIHJlbmFtZSB0aGUgInJlbW92ZSIgZmxhZyBh
cyBhICJjbG9zZSIgZmxhZzoNCj4gDQo+IEBAIC0xMiw3ICsxMiw3IEBAIHN0cnVjdCBmZHNldDsN
Cj4gDQo+ICNkZWZpbmUgTUFYX0ZEUyAxMDI0DQo+IA0KPiAtdHlwZWRlZiB2b2lkICgqZmRfY2Ip
KGludCBmZCwgdm9pZCAqZGF0LCBpbnQgKnJlbW92ZSk7DQo+ICt0eXBlZGVmIHZvaWQgKCpmZF9j
YikoaW50IGZkLCB2b2lkICpkYXQsIGludCAqY2xvc2UpOw0KPiANCj4gc3RydWN0IGZkc2V0ICpm
ZHNldF9pbml0KGNvbnN0IGNoYXIgKm5hbWUpOw0KPiANCj4gQW5kIGRlZmVyIGNsb3NpbmcgdG8g
ZmRfbWFuLg0KPiBTb21ldGhpbmcgbGlrZToNCj4gDQo+IEBAIC0zNjcsOSArMzY3LDkgQEAgZmRz
ZXRfZXZlbnRfZGlzcGF0Y2godm9pZCAqYXJnKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIHB0
aHJlYWRfbXV0ZXhfdW5sb2NrKCZwZmRzZXQtPmZkX211dGV4KTsNCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJjYiAmJiBldmVudHNbaV0uZXZlbnRzICYgKEVQT0xMSU4gfA0KPiBF
UE9MTEVSUiB8IEVQT0xMSFVQKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
Y2IoZmQsIGRhdCwgJnJlbW92ZTEpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJjYihmZCwgZGF0LCAmY2xvc2UxKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAod2Ni
ICYmIGV2ZW50c1tpXS5ldmVudHMgJiAoRVBPTExPVVQgfA0KPiBFUE9MTEVSUiB8IEVQT0xMSFVQ
KSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3Y2IoZmQsIGRhdCwgJnJlbW92
ZTIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdjYihmZCwgZGF0LCAmY2xv
c2UyKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICBwZmRlbnRyeS0+YnVzeSA9IDA7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKiBmZHNl
dF9kZWwgbmVlZHMgdG8gY2hlY2sgYnVzeSBmbGFnLg0KPiBAQCAtMzgxLDggKzM4MSwxMCBAQCBm
ZHNldF9ldmVudF9kaXNwYXRjaCh2b2lkICphcmcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICogZmRlbnRyeSBub3QgdG8gYmUgYnVzeSwgc28gd2UgY2FuJ3QgY2FsbA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGZkc2V0X2RlbF9sb2NrZWQoKS4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlbW92ZTEgfHwgcmVtb3Zl
MikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNsb3NlMSB8fCBjbG9zZTIpIHsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZkc2V0X2RlbChwZmRzZXQsIGZkKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9zZShmZCk7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAg
aWYgKHBmZHNldC0+ZGVzdHJveSkNCj4gDQo+IA0KPiBBbmQgdGhlIG9ubHkgdGhpbmcgdG8gbW92
ZSBvdXQgb2YgdGhlIHNvY2tldCBhbmQgdmR1c2UgaGFuZGxlcnMgaXMgdGhlDQo+IGNsb3NlKGZk
KSBjYWxsLg0KPiANCj4gTGlrZToNCj4gDQo+IEBAIC0zMDMsNyArMzAzLDcgQEAgdmhvc3RfdXNl
cl9zZXJ2ZXJfbmV3X2Nvbm5lY3Rpb24oaW50IGZkLCB2b2lkDQo+ICpkYXQsIGludCAqcmVtb3Zl
IF9fcnRlX3VudXNlZCkNCj4gfQ0KPiANCj4gc3RhdGljIHZvaWQNCj4gLXZob3N0X3VzZXJfcmVh
ZF9jYihpbnQgY29ubmZkLCB2b2lkICpkYXQsIGludCAqcmVtb3ZlKQ0KPiArdmhvc3RfdXNlcl9y
ZWFkX2NiKGludCBjb25uZmQsIHZvaWQgKmRhdCwgaW50ICpjbG9zZSkNCj4gew0KPiAgICAgICAg
c3RydWN0IHZob3N0X3VzZXJfY29ubmVjdGlvbiAqY29ubiA9IGRhdDsNCj4gICAgICAgIHN0cnVj
dCB2aG9zdF91c2VyX3NvY2tldCAqdnNvY2tldCA9IGNvbm4tPnZzb2NrZXQ7DQo+IEBAIC0zMTMs
OCArMzEzLDcgQEAgdmhvc3RfdXNlcl9yZWFkX2NiKGludCBjb25uZmQsIHZvaWQgKmRhdCwgaW50
ICpyZW1vdmUpDQo+ICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgICAgICAgICBzdHJ1
Y3QgdmlydGlvX25ldCAqZGV2ID0gZ2V0X2RldmljZShjb25uLT52aWQpOw0KPiANCj4gLSAgICAg
ICAgICAgICAgIGNsb3NlKGNvbm5mZCk7DQo+IC0gICAgICAgICAgICAgICAqcmVtb3ZlID0gMTsN
Cj4gKyAgICAgICAgICAgICAgICpjbG9zZSA9IDE7DQoNCkkgaGF2ZSBvbmUgY29uY2VybiBoZXJl
IGlzIGNvbXBhcmVkIHdpdGggdGhpcyBSRkMsIHRoZSBwcm9wb3NhbCBjaGFuZ2VkIHRoZSB0aW1p
bmcNCm9mIGNsb3NlIGNvbm5mZO+8jHdoaWNoIG1lYW5zIG9uIFFFTVUgc2lkZSwgY2xlYW5pbmcg
dXAgcmVzb3VyY2VzIHdpbGwgaGFwcGVuIGxhdGVyLg0KDQpDdXJyZW50bHkgSSBjYW7igJl0IHRo
aW5rIG9mIGlzc3VlcyBjb3VsZCBiZSBpbnRyb2R1Y2VkIGJ5IHRoaXMgY2hhbmdlIChtYXliZSB5
b3UgYW5kDQpNYXhpbWUgY291bGQgcmVtaW5kIG1lIG9mIHNvbWV0aGluZyA6KQ0KDQpCZXNpZGVz
IHRoaXMsIGRlZmluaXRlbHkgdGhpcyBwcm9wb3NhbCBpcyBjbGVhbmVyLg0KDQpUaGFua3MsDQpD
aGVuYm8gDQoNCj4gDQo+ICAgICAgICAgICAgICAgIGlmIChkZXYpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgdmhvc3RfZGVzdHJveV9kZXZpY2Vfbm90aWZ5KGRldik7DQo+IA0KPiANCj4gTWF4
aW1lLCBDaGVuYm8sIG9waW5pb25zPw0KPiANCj4gDQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQo+
IA0KDQo=
