Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA9C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 09:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3DFB4064F;
	Fri, 14 Feb 2025 10:58:47 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
 by mails.dpdk.org (Postfix) with ESMTP id D36F34064A
 for <dev@dpdk.org>; Fri, 14 Feb 2025 10:58:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGaT0RB8bme9RjyJCTzsyH0NGv5mDexG2RYRZNTcuPNBLF7wK2qD4IXH/OnChJmJz5iZhZvOcvnjLPgY/5na3BPhbG2B3GdfG+zyUZ9ciCkyVwLBjlyZeW/EW2G2fvoMiV7rO6apaJksZPE1QXjZhlmx/q+jlnuD+BRmOUqqgtoK4wBfyr3/eU2CZ/u9Dj4tuiZNRbOAjXo9qaV/dkVZvC8jV4na33QNF0MCbxfaiyzF13OaIpd68LaXlw/MzfNX5ez75Y3W0mFXiaFlDGRzsU/Kkw1ft60SILEBFXKTb5teHHyCOoYtaNyMB3gtidi/d1cAYEr60Jx13DLVNGZ6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTqpsdx/hbRG0q7snTWKhlksr7EawgNR1gcuzFjakiM=;
 b=zK0ogBZGB5q/1P3urFbgY7AaPG9w2avz2hJwqqgwJ5Ujw0c/EkRXGQHr+TFkaP1sbkUMU2Od6XOLyOMkbXTmNfwJoJzKfTnRbfwxJcH0dDaij3k/qnk3ZcxWXiZ/sqG6fxAkpcQGrtVZG+vnYFgbf9k0CbtICqRRGrYSwjH13BZg2G/B0YZqiRZPzZvz1jKnQKx73uJbJssZkGaE8PB5Xa96carPk96Ww+DQtiY7D0Sh0EQzq1N8WQpfOuAmp2Gf3mRw2NdVKnEC1HqV6zXksSV+nQ/tJ+beJJwXKI6SIKS38JLNP4jUcEor6PBX0yjqBarFC6rSs4e7PQ44AajkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTqpsdx/hbRG0q7snTWKhlksr7EawgNR1gcuzFjakiM=;
 b=wEYjgB/6O9ExfzNom9o6aiJnMOD91Lyr0VvgNLNDf1teEfGLOk3lS+pr59Zg5Tlljo+cUlSbRl3grIxGEpkVS9W5fyucQL2unktUVJDaXbGKsu9Eu/IC20RYVo+Txpdx1DjfKxKIYNK7JHkz4AfVnE7pyj6S9qCp9UFkXi+xkTS70ZY1D6TRnCnpCfwA39C+0lvfzvLZflTAsVAKcCM77dK2WNt5qkHEr0rMcnZrFdM1tCJ9uPphfhHQzXw8cGuLy37x1Ggsi9buDPqxl3xabvs382/UxYlFGZ2FT0pJblBNsrTcXT5JzmqTPy6krqz67xQWD4O5WycDSzgp946lQQ==
Received: from VI1PR07MB5248.eurprd07.prod.outlook.com (2603:10a6:803:a4::30)
 by AS8PR07MB9186.eurprd07.prod.outlook.com (2603:10a6:20b:5ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 09:58:44 +0000
Received: from VI1PR07MB5248.eurprd07.prod.outlook.com
 ([fe80::2dee:d246:de3b:42f2]) by VI1PR07MB5248.eurprd07.prod.outlook.com
 ([fe80::2dee:d246:de3b:42f2%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 09:58:43 +0000
From: Luka Jankovic <luka.jankovic@ericsson.com>
To: "pbhagavatula@marvell.com" <pbhagavatula@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: Re: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Topic: [EXTERNAL] [RFC PATCH v6 1/2] eventdev: add atomic queue to
 test-eventdev app
Thread-Index: AQHbbkayfmkE5ecvy0+B0HfWyXXI0rM3YmUAgA9PHIA=
Date: Fri, 14 Feb 2025 09:58:43 +0000
Message-ID: <8c8c0d1f2a82ff5097cd6dd0d8395c4a2741df66.camel@ericsson.com>
References: <20250115133844.1403623-1-luka.jankovic@ericsson.com>
 <20250124095937.1436673-1-luka.jankovic@ericsson.com>
 <PH0PR18MB40860FA2D8B571B3F0FB0818DEF42@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40860FA2D8B571B3F0FB0818DEF42@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB5248:EE_|AS8PR07MB9186:EE_
x-ms-office365-filtering-correlation-id: 80124544-d353-4cad-c9ca-08dd4cde2a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ly9sT3NjR0lTTVBORWpFOGttUWlVcE45Mm5wRlRnRk5lcWtSRysvR0pFbmV2?=
 =?utf-8?B?REZyYnNpT09tUkVPam1rUmNtTVN6S2Yzd1BDSWVQelJybGVQSUhWM0dkK09j?=
 =?utf-8?B?cGxwcDd5R0VWZ2hkRmQrRWo1Z0M3RSt0dWdFM1Z6Y0NpTmx6ZzJqUmxpSUVT?=
 =?utf-8?B?RWxWa3VmWXorUEJaRzVPR05LdFM2OEhJL3MxbTZmcVVpLzVDZm5zVGhqWTEy?=
 =?utf-8?B?VGxzSjNIOUNQZ0dXbW8zUGFMTjhQeFMvSFdJajJhZ1p2MjF3b0xNUHptczJa?=
 =?utf-8?B?ak81WnRtRkYzbURLcmVuQkE4WTBtblc4UmFZaWk0d21MYkU5RXJJYjN0VUJn?=
 =?utf-8?B?bzk1NXRnQktoUkVDbTlVdGl4NVNQdmY0YVRvTjlpRkoyS0I1N1M0RVZQZC9h?=
 =?utf-8?B?S3pXbGwrazhPS2pBRHNGMjdrN1RiaGl3c1pQR2RtRmZkKzkxcmNpZ0JpZDdW?=
 =?utf-8?B?SDJMa0FlY0pTUmJlZStuMXBOelc1akRKQkZIZGtMQTBZdGRIY3pOdVhjQWpU?=
 =?utf-8?B?QUgyNFhjZFJaZmozZFdmUmQvRU1EL2tXdTBtQ294N1NzZHhPVHRxaGN2TmF0?=
 =?utf-8?B?MUFrYXcxNndhdk5rL0VlcFovdi9maURGU3hEb2ZtNllZa2dxTmhOYkRDc2s4?=
 =?utf-8?B?aURHM1prRnVtQjNJdTBCdFZGQTBlNXFiZjZENVR2VjUxdTF2L1laTFA0L0hw?=
 =?utf-8?B?SXBsZ3hESFhHNi9NSmdRdzVIMmI5ME9DRjRjajhjZEx6U0RvdVIvQ1lUT2tt?=
 =?utf-8?B?a1ZiTndoREdxRVUrRGNKY0E1bkEwaGVhaWhaUGlldThFd0dzK2MyRjNtWmFI?=
 =?utf-8?B?QVhEdlBYRmhiQWQ2aUwyb1lueG1rMHlleS9hUFB5bklzUU1tdFhRK1g3bThR?=
 =?utf-8?B?QUdTSyt6TGFMcGIwNGFkeElTT0grUk5zWm9XOEVPNFBqQy9kaEtCN2lpNitn?=
 =?utf-8?B?cGxsSUNUYnFJenUwRm51NldnMGFTZ2ZYMDVzc3d1d1U3OVIzRXM1bmFBbkp4?=
 =?utf-8?B?U0dmK0xNeWhVd3M5ak1vaDM5UWN1cGVMN2c1YWdBNVhOS0NLSEtRYk9xdzRN?=
 =?utf-8?B?aWxXc1Y4d1FFWWFnU3hOcUIrN2NWdGJPSjFqY2RwOXllZldCZ3FRR2RKSC9o?=
 =?utf-8?B?YnVwbmYzVlBLQ3ZBcU1Va2JKRS84R1JVMHl0eTAySENGMi9GMUJqT3o4cTVM?=
 =?utf-8?B?NmdSV0ttNEQxaWZVa3J3djZvTW5hVWdFSytIZmc4OVc5V2IweVdybVpsODJV?=
 =?utf-8?B?SEc0MGFPOGgrUzZHUEtqMy8xWEFHTkZvT0RPYVpCa1orb0oxaXVqOEt5ZFBF?=
 =?utf-8?B?ZEdVOXVNOUVlQzUxanFZem1zaTVUOHk3RVlQczJuQmd5SzNNWjRkWjQrc0sy?=
 =?utf-8?B?YXBvM0NuODZwNStWQ0NldzFRK1h0U3VBeVRTMFRFcXo5WWhvNGhaK3UxZ2Jv?=
 =?utf-8?B?M0p2QzA4SU9TdVZyOXZQR2Eyd1RlMHRRZVByblNlcDBCQXJiMUt3aTk0MklM?=
 =?utf-8?B?cjRpelJ3VEFEZTZvM2hCZWtjUFdtdFpxdG1OSmF6Q29vYVQzbTJ4WXBwQjJo?=
 =?utf-8?B?aWZqQ0NhdHNpb1V4K0pOdjVtV0NUeUxmd0ZCbk5LNVlialh5N3pmUzl0UWpY?=
 =?utf-8?B?NmpCTVVjV2NLN1ErVlF6Z3gzVHdsT2lSOWZjb0tYWU1Ram82WkhhZHNzL1JX?=
 =?utf-8?B?UkZTWGZJNlRubmxUN21DR3VkZWJwcUgwWlNLRmNQSEYrRVY0ZUxNcUJpUENo?=
 =?utf-8?B?QkcwT0V1YU5BMEs1cmR6bGpLdUF0aTJ3Mk1PWk5KUk9QUEYwUFhZMENOMXE4?=
 =?utf-8?B?NUE2L01pZTBSSFJDM3doOURvRmRycnlXclpFcUFrM1VlbXRDOXZYZjVWOVlh?=
 =?utf-8?B?Y2IxbFdYMUhQRHNLZUFaM3p6Tm0wZ3l0YUVROHZDRCtDbDlYQ1hvVk15OHdm?=
 =?utf-8?Q?AtNNRhIbVWXjh9IK9P8sf/RtrmqBLZT5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB5248.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enN2NENubTR6K2NqajZKQmRyRmEyQ1ZBSktkQkNSMVJ2Y1NmVnFmeURyM2tW?=
 =?utf-8?B?SlYzRi9lY2Voa3pBUVY3T2huRk1kRzkxdFRJWm9ONUJhTmdSSnI3V0x0QlJU?=
 =?utf-8?B?TFJoMTJPVXBjWGE0LzVPK3FYNzAyVTFCZWpNbmpPenhLTi9tbzBNMkZhd2Nv?=
 =?utf-8?B?dmQ3bitldGNPOWNoWjVaTm1kRFE1ZUtMZkxCWUdVU0dDSmsxZU5ocURySUp6?=
 =?utf-8?B?VmZ6WkFXQ3NrR3pIZlROakttQ1dCakozdnJaUEtYUGFVN1pnYy91L3JjSkF1?=
 =?utf-8?B?UHdYQU5LT01KbmR5NzhNNHg5UEcvRVMvekpwUEJYZDZMUHN3YnRVb0dsY2o3?=
 =?utf-8?B?NlNuaTJTQnpkVEJVZWJXcGFkb2xOaVBVemlDcmZuWSs0WE1tL1packZadDhh?=
 =?utf-8?B?SkhBeG9ZV3V5M3BCeTBWcVc3Y2V5S3VWdm95MFZJNGl4dWdXQ09sRDljcEo5?=
 =?utf-8?B?ekNFcE5HS2V6NzJaREhJYS9DZlYyUFdObUV3QS9TNmJMT01Sd3I1V096OStN?=
 =?utf-8?B?cVk5NERsTk1kRk53MGF6NlBmeHhGRWMvcVJqQXV3RlZWbEdvS0RJbldna01o?=
 =?utf-8?B?TTA4YVRIRUljTUZsaHphZXhLaHptOEdWNEJCN000WlpkVkY2dEozdFBiNjZs?=
 =?utf-8?B?T21KN1hOTUVBc1lWSCtJUFFQenh3NmladTVIS0d2VlIzdk53SWwraDlGZU5C?=
 =?utf-8?B?eVI5YlhnMmFYVVYzSThUTllmQjJNOEVPUjJNcjRtNWFSeWdKV3VLQUk5dTdD?=
 =?utf-8?B?NDc3L3JNclhFdmhFT1Nqayt3QytqSFozVWdqK1F2STBJZmhNZVJkVG4yNm80?=
 =?utf-8?B?eWFaSWEvQzFPaERVTEJpdXNVbUh0NUhhWmlxQTRnSEJRRFBudGcwZXRZOGIw?=
 =?utf-8?B?Z0ZwUEJSQUt1WWo4SFNXZVRMQWNFcUpPd2dpMmRrRmgxNm9CM3EvTmxKdU5i?=
 =?utf-8?B?NEVOZHlQR05wZkl3OW80MitWdlQ5RkhzbVFaWFViYURYYmdKang1MXc0MUsw?=
 =?utf-8?B?NFpSTmFYVlNRQXdtdEJTelBvUEh4RVlCcFVoNlIwRThNamU5ZGt1SlpxRjU5?=
 =?utf-8?B?R25TQmZQSjNJYjZTOG1nUUtuN2VaTHB2anBsS0pTZmFCem9URFRFWld6aStJ?=
 =?utf-8?B?aEoya3BxMFZ4cUdmTzJIV0J4enFrN0RBV3phV1pvUWJrUXdROUt2WVpndytF?=
 =?utf-8?B?Q1Fna1dhVE5SQmkxK09Ha0JTUFkwY283bExoUGptTTEzdDF6QVdFaU1JK3RE?=
 =?utf-8?B?blk5ZWwzSzBLaURodjZQZDdjazMyN0RHM0NoVTlzZFdnZXNvak9xNkpjMzZx?=
 =?utf-8?B?d1VGUDQ5RitQMnY4Q3FKbEVtbFJWampvcnhWb29xTVBUN1pPMWNvQmR3bllH?=
 =?utf-8?B?c0NYN3dQSUJXdDRGby9SSFlhb3MrWHB1MjFGUHcwYndsWjJZeTBYanlQejRO?=
 =?utf-8?B?OE0wajdzVnJnU0o2Z3loaEVjK3lQbXYyeVJDeHcvU3Z1NTBGOXpQbUZJMmZa?=
 =?utf-8?B?WjhwOGIzUzd3NzhQS2dyUVY2eThPMDRLSzhmdUxzcVJnNEcyd3JtNW1tSk5w?=
 =?utf-8?B?NWg3amhQaG9TMEJkbjVzUjhtOXQvR0tIRXBZK2lGV0llZ2JXbUg3NVhnTDZP?=
 =?utf-8?B?c3ovNUFFWC9TeWg3YmhOSDU1T0xnSGxkMUxXL0tFeGFvTzMyTStTTTcxZkxX?=
 =?utf-8?B?OFY4Q1UreHc0enNMWXVlQ3l5QXRiRHM4ZXRKcjN1V0t2ZFl4R2tuaFRLQ3JF?=
 =?utf-8?B?dHJ5V0Y1SU9NYVRPK2o5a0R6MXJxU09JVytaSVdmakUrMFg2S0pTWUFqYUgx?=
 =?utf-8?B?aFhNNVdLcTFMaWltd1dRT3p3Q2ZsM1MrUVJEUGtHSDJRK1dhVEdpU3hiQ2lH?=
 =?utf-8?B?amw0WjNVWVdVUUd5VzUrQ3A3aHA4MVZGZmlTSGVwNTlsN0QwVjFnVWhLUFVK?=
 =?utf-8?B?WGVjSHhYUEhwOGZCdEIrU1YwanRFWmVpcU9SNlRIZUpmWmZFdmNuaUdaTHZL?=
 =?utf-8?B?clIxcUl6RkRjdi9QWlNGZngzRGQranJFMFdEZXVjcExsalJ4SzQ2RWxVTFd1?=
 =?utf-8?B?dFlHbjY5U05YZUlISWhmZFNSaWc3M3VsbW1mNFNkOG9MUUxJM21ibkhpN2J3?=
 =?utf-8?B?NjhsQm9UdlkzRHJmUXFJOWF2SXJoMEk3RWRqTFhRMnpOaEhZWVI5S0lrakRH?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68C98FD4F1743C4A99FB7E6C90664D1B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB5248.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80124544-d353-4cad-c9ca-08dd4cde2a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 09:58:43.7251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsTJL6GGQW5x5IAafScoPwUYyXd9Avvu4SGBVAupG3TltUZZr6Ug/K76eAtFa8fYqCxYgwmQeCDAvF/F9LKMj//euB7EQA8/wC0sMvKkYR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9186
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

DQoNCk9uIFR1ZSwgMjAyNS0wMi0wNCBhdCAxNjoxMSArMDAwMCwgUGF2YW4gTmlraGlsZXNoIEJo
YWdhdmF0dWxhIHdyb3RlOg0KPiA+IEFkZCBhbiBhdG9taWMgcXVldWUgdGVzdCB0byB0aGUgdGVz
dC1ldmVudGRldiBhcHAsIHdoaWNoIGlzIGJhc2VkIG9uIHRoZQ0KPiA+IG9yZGVyIHF1ZXVlIHRl
c3QgdGhhdCBleGNsdXNpdmVseSB1c2VzIGF0b21pYyBxdWV1ZXMuDQo+ID4gDQo+ID4gVGhpcyBt
YWtlcyBpdCBjb21wYXRpYmxlIHdpdGggZXZlbnQgZGV2aWNlcyBzdWNoIGFzIHRoZQ0KPiA+IGRp
c3RyaWJ1dGVkIHNvZnR3YXJlIGV2ZW50ZGV2Lg0KPiA+IA0KPiA+IFRoZSB0ZXN0IGRldGVjdHMg
aWYgcG9ydCBtYWludGVuYW5jZSBpcyByZXF1aXJlZC4NCj4gPiANCj4gPiBUbyB2ZXJpZnkgYXRv
bWljaXR5LCBhIHNwaW5sb2NrIGlzIHVzZWQgZm9yIGVhY2ggY29tYmluYXRpb24gb2YgcXVldWUg
YW5kDQo+ID4gZmxvdy4NCj4gPiBJdCBpcyBhY3F1aXJlZCB3aGVuZXZlciBhbiBldmVudCBpcyBk
ZXF1ZXVlZCBmb3IgcHJvY2Vzc2luZyBhbmQNCj4gPiByZWxlYXNlZCB3aGVuIHByb2Nlc3Npbmcg
aXMgZmluaXNoZWQuDQo+ID4gDQo+ID4gVGhlIHRlc3Qgd2lsbCBmYWlsIGlmIGEgcG9ydCBhdHRl
bXB0cyB0byBhY3F1aXJlIGEgbG9jayB3aGljaCBpcyBhbHJlYWR5DQo+ID4gaGVsZC4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMdWthIEphbmtvdmljIDxsdWthLmphbmtvdmljQGVyaWNzc29u
LmNvbT4NCj4gDQo+IEl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBhZGQgYXRvbWljLWF0
cSB0ZXN0IHRvby4NCg0KSSB3aWxsIGFkZCBhdG9taWMtYXRxLCBidXQgSSBvbmx5IGhhdmUgYWNj
ZXNzIHRvIHN3IGFuZCBkc3csIHNvIEkgYW0gdW5hYmxlIHRvDQp0ZXN0IGl0IGxvY2FsbHkuDQo=
