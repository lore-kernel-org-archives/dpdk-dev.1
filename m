Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7D2940696;
	Wed,  8 Jul 2026 17:05:09 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by mails.dpdk.org (Postfix) with ESMTP id 93AF54068A
 for <dev@dpdk.org>; Wed,  8 Jul 2026 17:05:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ+Gr/ybFgbr2WWqaPVcPDSXnQwgiHUAkgL9aSwbOfeW6FBHH0zmOj13qlgbfoDBpkhDMEqoCjRupeR3fyBkouAZBB6kOwKjky6yzqtEdKcXsB9qdrMO8+Y8Bu7crmK0B/bkQ+ag63VyD9UFjEQAAI8m5WhhnyJX0JD0V+iD2qz4Nuptgx+mFdNgfiiR/G5pOEMisDkIsX7Vj7d9ZLQwpDB+HT20R6ZWjBD6TIcZnL6GgURa+/WczwJt1lGlBYdyugMRbrgG5Sotu/9NItjx2NwMQM0jSPNnSvG5r9HgcfTu+AG4Z13m98C+HyAPmqEESfwKdznKAJJBGXj05LywXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW5yYTh2WQnXVN/4Uv9Q9dE8SwJi3QtMOyuOb1wLT/Y=;
 b=NvuoLgUwT2FvBUGgIl6y9pIZKjHZu7sTwCJP4fozvmkq2mFmgO/cUMsCj3annkSOaCS290KKY10ivu02BbR3xx24Nc/oH2oHZWCZzbkwk4EuIgmAZdxuGhCbprPMwk1MD1p6MJDeFsOj+RNVogNtyoHal22tAj6aGfhwYEm0a2vMYqC8gsm+RoBb4voTh6zbzgMwfS7w7H7rgGPWc9hb1BAR7L0arZFN4UdY2ER2Md5mvgLtz2CzXswFFub3z8KZQM78eQ/vjyinPMjhONgqSh5i6m77qH96WPWJq9ULuLbYSw23Qq0sUaoIrOp5FBUxNuv3LnmMfi0pmqEjBvfNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW5yYTh2WQnXVN/4Uv9Q9dE8SwJi3QtMOyuOb1wLT/Y=;
 b=jUZQwpfjTVoWHHorZ34cA7v4YWzLW8m9Yn7Zev5xPU19WnRxZ4gUEXqAQZta55LZFwfLeShuIGpTSJ+wnGaTYxaNzcl+wMDBPv4KtVuLWYAqhQmPgcyXb7cItSY8a/VGaLMXFyDRJQxoBGl/6C5C7g5hBtE0/SBKEtLL6LqSyUIzJHRHwmZ5UpjEbUxJnUZB0QWPWpHcinFTZWPj1yNhaG2RtcwGcC1b5/KQrxfQsYhBswQvv1UHv+WjiYgP6/6c1qCLw/MBO5vRUtFK38cIPTSDvThjfbnvB/6Lh52NMbL1OvKcepjOqM5K8F1vVfclh6XZmZdTMhBEt7U46E6XmA==
Received: from LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 8 Jul
 2026 15:05:01 +0000
Received: from LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4]) by LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 15:05:00 +0000
From: Wisam Jaddo <wisamm@nvidia.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Raslan Darawsheh <rasland@nvidia.com>,
 Maayan Kashani <mkashani@nvidia.com>
Subject: RE: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Topic: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Index: AQHc9BgqU5MXD4EJbU6GnkYjz7nN67Y3qjmAgCwI/3CAACj5IIAAEDUw
Date: Wed, 8 Jul 2026 15:05:00 +0000
Message-ID: <LV2PR12MB5893086C50C6C4752CBA46BEA4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260604114851.12586-1-mb@smartsharesystems.com>
 <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
 <LV2PR12MB589331A1E8F78B5C9F3DC9C6A4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65962@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65962@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5893:EE_|LV8PR12MB9184:EE_
x-ms-office365-filtering-correlation-id: ed1e533c-9d6f-4a08-bddf-08dedd02484c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|18002099003|56012099006|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info: cSz1hWlsJ+7MdIWvlwLk3tXexixXPkDhxpRgvL/GjYsugrzvZYK+ZFUy4oJqvMkPAG9GycKwn/EJpF7sNtx4M19Y+4CnLYrqu4+n8gfUG38V7Q6kcTEz6xBiHosqcHQehNsCG9aE+gcIh9S4Cpjd3ToFEdBaCifZbhD+6SSQZYsceAEH9CX5cyP957x9pd0On/vCMXEqNjnWt/9NocbRB+VFoKqMK+ZUIJ6JA3iO7dl7ExmwiIxfeKLtO54zEtACaYI1VZEL8KeJmsP2VuQzeVxlkR0hEjfGfcAMXxFmjJbdd7wrlxC9p+NOkO+xc9gv28C7xATyKnsayBHUgOjICx+DhbAqbY2TatENCZziimOG89s9/2CkWQmh2M9E48mHDAqu8RA3dy9mIFt2qxj/rLOAM26i26oFn6GIKRG4uXV++33YFagZTpCLTO0mlJ9bFt9Gg9b/LSDFRcKIRaWGDcSJ1JrEWfXlOR392ZQS026Z7iBdPKG1MbJhGbTx+AJEoc1H8Pwa2k7il7RF+zCXNHYKsDoeW6MoW/5AZnFOOJzGdsbQF/KFGH1W3CeB6+wZyIsZ8pfuEW8TGN94hBueODMXbydxGkYQiDcGR4siB+AHap1dMOnKQG7RG8AcZVJQgAxX+sxnq9FUKGvujBE6239/wfJPjDTlSW1JmCQfOC0oZbAbCtANDYoacNLzQhFQKsKNdfLDcSy36HYG6YbGepxIHbVmxKovjXR1FXV7rXU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5893.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Titxc2YycFhYa0cvcDJYQXJ0aTJIdjRqMjJZNVZOVTcxazA3UUgxTVE4eW5Q?=
 =?utf-8?B?eU5uQnArdE03cDBJcWJWL1dwY3F1aEIrNHdyZmwvd1NYcHZvaytDa2pLYmRy?=
 =?utf-8?B?V3M5bDNmV2dnc05LWWo5ZGtvRlN1Wk5lbVZNQU9jb2wvV285Mnh2YnJZNEg1?=
 =?utf-8?B?MFJVNVd2QW13U2NvWHozcWdsVkwwV01SMVE2U2V5L0JsMUhSdUFqSzF5MVhM?=
 =?utf-8?B?V2lZT1VTSndFcnNVY0JZdWthMkdmdllsU3JyMGJjR1EvSi9pT1p1Njl0ZVpV?=
 =?utf-8?B?aGZBeWpTaWo2d2FxalZtMldHSGtXbkNudXhWMXBrVkU2enpIdkFheXh1OEdr?=
 =?utf-8?B?clYxYURock8wU2NtWDBDTURKR2J1SWdjbnJBWkUzUU53QW1EREMyQTBPaG9y?=
 =?utf-8?B?SEx3YTN2MUs0Z2t5ZTdnN0pRdGdpOG5jWWs1RnVWeGI0TWJmaGlDZVdnTnJO?=
 =?utf-8?B?bkN0MjdTVGM0ZVdTWjFFcTBYT1RMR3M4eER5dEFETkpEdmZUdll6V2FhSWlv?=
 =?utf-8?B?OU1Fcy9scGdqZkxVQ3pTSHVYcGw4QmpoZXZxbkY4TkpvSmxkTU5DSy8zaFVa?=
 =?utf-8?B?cUVjekpxUlBiUXJKQkYrUDhOak9aN0h6SUVoZUc1em1odjA1V0lKMnJwT2E1?=
 =?utf-8?B?b2ZERFAwRXc4Zi95aWlPT2FHY2hOcEl1N0pKU0ZuYnpjT1FjZU01VUpMN2dY?=
 =?utf-8?B?OEhmVlg3c2c1T2d2TE5oWUZyTW0zeHJWRHRnbGxNNUVHYzZNNzYva3pWeUI1?=
 =?utf-8?B?VEIwbFhYRFprNTZrSER1U2xLSW41Zi9jR3EyZlZvOTlLd3p0RitRb290VTJC?=
 =?utf-8?B?OUJJS3U5dldmM2YvZ01tT1hCZEp0Q2FWQmZRdkVwbktyZ1JXbG9RV01qTlZX?=
 =?utf-8?B?M3ZMMEk4MllOTTkvTDlxYTFJMzJBSWVqN0FTZVBmNnA0WWlUcU1ReWJlano3?=
 =?utf-8?B?TVUvN2pneDNvL0ZlYVRJMXZmZmdmRGlpbmRuNDBmZXU4M1NaM1lBN1ZiUUp1?=
 =?utf-8?B?RnJ6cUNMZURsdmtYaEJtMUVsanVxcW9VQXgxRmJib0hZTlRGZmd1N3k0aHYz?=
 =?utf-8?B?bCtlT0dPdnpIS3lsZlVrMnBwRHB6WXFvczk5UmdWOGttd3k5bXU1dmVQVHNM?=
 =?utf-8?B?NmJDWWx1cWFtcUg0WVNaVzBDUXVKM2RYaDlJam85bENyMVlrTzJsaFpEYVEx?=
 =?utf-8?B?QkNwTnY4cTZXeno4ZE5KS0NjdGhDdlJaakZSbnR6bEhOZlI0c0NybVVNWGV0?=
 =?utf-8?B?OE4xUHVFYVhYRTByQjhlbklKSEtaMmpycm83RENtZGNkNWJIekhXalJKdVpL?=
 =?utf-8?B?QmQ5cERXZHRoQ2VnZWxJQWdvNVhDUEpKTTBYdHlTcUczSHQ4cjgrdG1ORjly?=
 =?utf-8?B?NHNWczZBcFNHN2hFNk5iZTdTUXlKSG02U2FSM3l4aTZnbE5jb1E0NUVoYVcx?=
 =?utf-8?B?S3hYZXRBcWs3MGRjOVZoQkpVWFFaV0pQWDFkNWdYYkExY0Q5L1F6UVc5UlJw?=
 =?utf-8?B?UmpqUWRxdUJKWklTay9tSW9sTmhqMG5MT1R2QVNXRjBZL3dHWEdDWFY0bGhB?=
 =?utf-8?B?Tys3d0VJU2U1dzJ0bnRHYWtlbTVjaUpyTGttb3ZTNCtWbm5LaDdWc2JvNHk0?=
 =?utf-8?B?YWxYL0tpQjZnOTJWZ285N2hEMDVncU5YSkt4RkFreDJtbVFmOVV5OTE3MTVR?=
 =?utf-8?B?bEZUR1JPZGhnY2xkYmg1VENYMUpkRUhuY0F6cFd0T3lCUHRjWHlYekt5RzRS?=
 =?utf-8?B?RlBSbkxnTDVwSXY3YkdPK0NrZkNJUXd2VFljYkZYS1NPOU10VEdhVVJpMzFr?=
 =?utf-8?B?QWRESTFIRVBlSk5TYUtKNE14UWQ0dlU1Ymt4RTQrWFV2ZjZBdGg4cXdLT3RB?=
 =?utf-8?B?ajNyTDc4eHZkV05TcE9IeGlNNllVMVEzeUN4ZVZlWDNPU05kdlFlT0dIQkpw?=
 =?utf-8?B?SEJkTER6M2ZyK0xEMWFFREN0N3p6ZXYwaUU0NUZJU3VVNlh1RkkxSHVBTFJ2?=
 =?utf-8?B?M0NlRVVBYXpWZHFGaXVBUDJNUUZ4WkQ3MW5OZC9DZ2Vtdi9CbG1CYUtMV1JP?=
 =?utf-8?B?S3A2N3Z4bUlBd1VGaHdnSzlLczBLM3A3YVIzc3VRYjdPYTg3TmdCQmhsVDE1?=
 =?utf-8?B?UmV2ZXBXSEZsSWh1UkQyZWdPSFF6THBSVkJFdzVYdjE2TUg5K1htN3Nndjc4?=
 =?utf-8?B?VmhWNmpLWU5mdW91QmM0bnltT0Y0MkVZUHJialBadEN1ejNxWi9pMjZlT0tL?=
 =?utf-8?B?QW50Z2NGa1AxY1lYSTRUMytydGs3L0FtZnp3MUw2RkZtOXkvenptSVMxd24w?=
 =?utf-8?Q?0h1GEs85QuWOol9TWF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5893.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1e533c-9d6f-4a08-bddf-08dedd02484c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 15:05:00.5458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CCX1tDvarQ2Cn8tA+RSJvn1b/ffGRp6uXAs4IwmmNpnz2ZKp7QEq7e280riJmwFIjCaouorBSYZUSOqlmJF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
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

SGksDQoNClRlc3RlZCBvbiBBUk0gQkYzOg0KY29tbWFuZDoNCi4gL2RwZGstdGVzdHBtZCAtbiA0
ICAtYSAwMDAwOjAzOjAwLjAsZHZfZmxvd19lbj0yICAtYSAwMDAwOjAzOjAwLjEsZHZfZmxvd19l
bj0yICAtYSBhdXhpbGlhcnk6ICAtYSAwMDowMC4wIC1jIDB4MzAgIC0tIC0tbWJjYWNoZT01MTIg
LWkgIC0tbmItY29yZXM9MSAgLS1idXJzdD02NCAtLXR4ZD0yNTYgLS1yeGQ9MjU2ICAtLXJlY29y
ZC1idXJzdC1zdGF0cyAtLXJlY29yZC1jb3JlLWN5Y2xlcyAtLWF1dG8tc3RhcnQNCg0KTm8gb2Zm
bG9hZHMsIHBsYWluIHRlc3RwbWQgd2l0aCBhdXRvLXN0YXJ0Lg0KT24gdGhlIG90aGVyIGVuZCBJ
IGhhdmUgaXhpYSBnZW5lcmF0aW5nIHRoZSBpcHY0X3VkcCB0cmFmZmljLCB3aXRoIGRlc3QgdWRw
IHJhbmdlIGZyb20gNjUwMjQgdG8gNjUyODAgIlRvIHNlbmQgZGlmZmVyZW50IHBhY2tldHMgd2l0
aCBtc2cgc2l6ZSA2NEJ5dGVzLg0KDQpXZSBzZW5kIDEwMCUgb24gVFggc2lkZSwgYW5kIHdlIHJl
YWQgd2hhdCB3ZSByZWFjdGl2ZSBiYWNrIG9uIFJYIHNpZGUgaW4gaXhpYSAidXNpbmcgdHdvIHBv
cnRzIGFnZy4iDQpUaGUgcmVzdWx0cyB0aGF0IHdlIHN0YXJ0IHRvIHNlZSBhZnRlciB0aGlzIGNv
bW1pdCBpcyBhIGRlZ3JhZGF0aW9uIG9mIDEuOCUgLSAyJQ0KDQpCUnMsDQpXaXNhbSBKYWRkbw0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1vcnRlbiBCcsO4cnVwIDxt
YkBzbWFydHNoYXJlc3lzdGVtcy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA4LCAyMDI2
IDU6MDkgUE0NCj4gVG86IFdpc2FtIEphZGRvIDx3aXNhbW1AbnZpZGlhLmNvbT47IE5CVS1Db250
YWN0LVRob21hcyBNb25qYWxvbg0KPiAoRVhURVJOQUwpIDx0aG9tYXNAbW9uamFsb24ubmV0Pg0K
PiBDYzogZGV2QGRwZGsub3JnOyBBbmRyZXcgUnliY2hlbmtvIDxhbmRyZXcucnliY2hlbmtvQG9r
dGV0bGFicy5ydT47DQo+IFJhc2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47IE1h
YXlhbiBLYXNoYW5pDQo+IDxta2FzaGFuaUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIHY4XSBtZW1wb29sOiBpbXByb3ZlIGNhY2hlIGJlaGF2aW91ciBhbmQgcGVyZm9ybWFuY2UN
Cj4gDQo+ID4gRnJvbTogV2lzYW0gSmFkZG8gW21haWx0bzp3aXNhbW1AbnZpZGlhLmNvbV0NCj4g
PiBTZW50OiBXZWRuZXNkYXksIDggSnVseSAyMDI2IDE0LjI4DQo+ID4NCj4gPiBIaSwNCj4gPg0K
PiA+IE91ciBpbnRlcm5hbCBwZXJmb3JtYW5jZSB0ZXN0aW5nIGFyZSBzaG93aW5nIGRlZ3JhZGF0
aW9uIHN0YXJ0aW5nIGZyb20NCj4gPiB0aGlzIGNvbW1pdC4NCj4gPiBUaGUgZGVncmFkYXRpb24g
aXMgYWJvdXQgMS44JSAtIDIlIG9uIHNtYWxsIG1zZyBzemllcy4NCj4gDQo+IFdoYXQgZG8geW91
IG1lYW4gInNtYWxsIG1lc3NhZ2Ugc2l6ZXMiPw0KPiANCj4gQWxzbywgcGxlYXNlIHNoYXJlIG1v
cmUgZGV0YWlscyBhYm91dCB0aGUgdGVzdCBjYXNlOg0KPiBBY2Nlc3MgcGF0dGVybiwgZS5nLiBw
aXBlbGluZWQgYWNyb3NzIG11bHRpcGxlIHRocmVhZHMgb3IgcnVuLXRvLWNvbXBsZXRpb24/IElm
DQo+IHBvc3NpYmxlLCBsaW5rIHRvIHRlc3QgY2FzZSBzb3VyY2UgY29kZT8NCj4gR2V0IGFuZCBw
dXQgYnVyc3Qgc2l6ZXM/DQo+IE1lbXBvb2wgY2FjaGUgc2l6ZT8NCj4gTWVtcG9vbCBkcml2ZXI/
DQo+IA0KPiBQUzogSSBhc3N1bWUgaXQgaXMgYWJvdXQgbWJ1ZiBtZW1wb29sLiBPciBpcyBpdCBz
b21lIG90aGVyIG9iamVjdCB0eXBlIGluIHRoZQ0KPiBtZW1wb29sPw0KPiANCj4gPg0KPiA+IEJS
cywNCj4gPiBXaXNhbSBKYWRkbw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiA+
ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEwLCAyMDI2IDI6MDcgUE0NCj4gPiA+IFRvOiBNb3J0
ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gQ2M6IGRldkBkcGRr
Lm9yZzsgQW5kcmV3IFJ5YmNoZW5rbyA8YW5kcmV3LnJ5YmNoZW5rb0Bva3RldGxhYnMucnU+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4XSBtZW1wb29sOiBpbXByb3ZlIGNhY2hlIGJlaGF2
aW91ciBhbmQNCj4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4NCj4gPiA+IDA0LzA2LzIwMjYgMTM6NDgs
IE1vcnRlbiBCcsO4cnVwOg0KPiA+ID4gPiBUaGlzIHBhdGNoIHJlZmFjdG9ycyB0aGUgbWVtcG9v
bCBjYWNoZSB0byBlbGltaW5hdGUgc29tZQ0KPiA+ID4gPiB1bmV4cGVjdGVkIGJlaGF2aW91ciBh
bmQgcmVkdWNlIHRoZSBtZW1wb29sIGNhY2hlIG1pc3MgcmF0ZS4NCj4gPiA+DQo+ID4gPiBBcHBs
aWVkLCB0aGFua3MuDQo+ID4gPg0KPiA+ID4NCg0K
