Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348FC021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 09:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6304402D3;
	Fri, 21 Feb 2025 10:12:28 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
 by mails.dpdk.org (Postfix) with ESMTP id BFB284029A
 for <dev@dpdk.org>; Fri, 21 Feb 2025 10:12:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4g5bEoN4gmulkxst46gmunulzblnMCnlsQOJbCYAvcsxylDngAflbywff9toir4yozXLxkpsCaDwSZAd6A6rVLWU6qRl4tm62nKByym45jMgoPC1nV6LZ9gBHwVmuVPmwSxZPTpOY4UiKcqUVgvLQ6UddPAA+51y8Zu4DdzYtJNjooO8GNLrdFqJUKHqSj1C5wZRmUbuAudbOhzPDSo/C0Xu+jQ68v22KLBksQvGg7c7tkCbtjZV+0LLVX1vd2U34QBm0z3K2s+TZ0LlN/UAcv3VnD+70QeeNFFoMhBsI5y54fAiMkT48RnWeJgeOPGNaWL4PIotl/eLZ58b84tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFpnvN8aXU6d3hId1oDt37+39A16iwWUaxRd6TjhlKg=;
 b=FpvrCz/Swt0SCVeDT8wEWf8wZeO7LozNGoIEkaURQeSRIxsUI0iqcB7jLF4MycH7v8in3eXaKtzAJ2oEnupPNN2OaTm8aElEmp0nQlV6P0gAY+Ug3sfOJI+tudySrfVFkNhopff3vioTxZZJKr6wFGeVuWclvvhqS7NrywIxQwFzNseXY/TAijMBDd+L0kHg63Ym4p85A0Ih6BMJvn8yLvhNay8o0ZUevNNn6qa83BVapyGv8FAuSe8eKQw3QWSePthNsvaS29WLPR0BADl2kQFdqrP3SMpUi3p/Oho4Jl+ZKIdKnPsg4Pp/ak5qr98vSME1JEk87S6JJWqlM/hfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFpnvN8aXU6d3hId1oDt37+39A16iwWUaxRd6TjhlKg=;
 b=LI8owqKvLdtKVO9OsmyW2r9es381h+yXanyOnI4on+ssmHiKxj0+L2y8HE1Xnaetba9Dix75QnLEQ45aUcii4n41CG9JESngmko5HmhVPIE1dWHrimMnAZZMaW/EsMp7PzfsYDbuc53UigLFQLdelODsXPT2Irn21I0sgL6lj3mGYtweI4HDzJaku6T/wQMEw3r2wdo5bnTwJR15NWY7mq0KvTIqqh5JBmI6oBQ0ULo9jPqfzOt2RtZNMHgQmCcb4ZSHL4tOScQ76re/QP8JHbvSWHvxcw31HwzhgnAbfGno2/3hFmcZV1eX+mWho1mEkw5xjSKzMQFXI+cojy7+QQ==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by VI0PR04MB10232.eurprd04.prod.outlook.com (2603:10a6:800:241::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:12:26 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%4]) with mapi id 15.20.8422.015; Fri, 21 Feb 2025
 09:12:26 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: RE: [PATCH v3 11/14] rawdev: remove unnecessary deref of function
 pointers
Thread-Topic: [PATCH v3 11/14] rawdev: remove unnecessary deref of function
 pointers
Thread-Index: AQHbg7h/wzxmP2VPJUSXn1h41WULALNRee0A
Date: Fri, 21 Feb 2025 09:12:26 +0000
Message-ID: <PAXPR04MB932899DFFBBEF800B191490E89C72@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
 <20250220165644.16421-12-stephen@networkplumber.org>
In-Reply-To: <20250220165644.16421-12-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|VI0PR04MB10232:EE_
x-ms-office365-filtering-correlation-id: 3147e232-2a2f-43cc-581b-08dd5257dc05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2MzVTJMZVFWdHB2Si9wam9nSUZ3b2tKRnlaUnorUG4zUmdvVUs1YS9GQmIr?=
 =?utf-8?B?a1ZQQThMdjk2aUlDM2dGdFFjRWcxY3NiSFZmM1lHS1V6NDBtZU5CQXFYeUYw?=
 =?utf-8?B?bEg3ZjRYZWRnUldLbDEyVXdHbHZjWnRKcFA0aTZ6cDR4T20rWkovdE5jOE9v?=
 =?utf-8?B?ZWFwS1RpRjNoRnNjR1kwNzBoMVNkS29hVTM5RFh1UUpGUXVDRXRORTFqd09n?=
 =?utf-8?B?V3JvU25GUzF2WnlSTTEzSGtzYmI4eC8zY1AwZXFIbjZRUm5KU3RtcmdzMXhz?=
 =?utf-8?B?WWU5TThvV05nTHhqODNmdGxRM0NTS25ZN3NYRkowMmd1WlBzdkZtUVowczBH?=
 =?utf-8?B?ajlibEw2RlFpMDdhV2gvR3JibDFlOVQxM3hTUmlIU0pWc09yeE4zdEdhUUxR?=
 =?utf-8?B?Q1FSeEN0d2Z5M1lITjhlcldqSkMrS2xnZjV6bmREamdBMlhyTmpobFd3anRR?=
 =?utf-8?B?UVpoRkhJUWIzTTQ5YmJ6Z3M0cmNOTE5hUGh1cmNRb0pZZDhjdkU0MDFlZ3Fl?=
 =?utf-8?B?bmRvRkMxMTlRZW1NZmsrL092QUhUNDQ1WHJOSXlvVWxuaytlcnp0Zi9VYVVk?=
 =?utf-8?B?OWY2N2VBd1JMdXNhRk9OKzltYnUyL0dlcW1IZXo1dDQ4TzRDWkVOM0ZwKzc5?=
 =?utf-8?B?Q2pGRjAwYXNDTGIzblFTN3AveUVEcXpWWGtYUlp4NW5lSzRvdTJpY2VoOEtn?=
 =?utf-8?B?TFV6LzEwQ1FlR3k4dDJLSXZXREhjU1B2TjhMRlg3OE9wdU5zcUNDdXhRMjRO?=
 =?utf-8?B?clBPN1dsRHpUZFMyVDJaTjZzT0V3WEVqK2xnNElWMXJVVmVYR2VQa3A1WVV3?=
 =?utf-8?B?OGxJa0NBWXk1dXdZNDRKME56bXBOeUsvc3ltT29jMXF0SUh0NVRFZ3NubzZ1?=
 =?utf-8?B?S1BzMzBSTmpxbTQ1Nm56Z2wrZ0tpME9CQVliWEJ0U3ZaNFZOZzYvM29HaVFp?=
 =?utf-8?B?L0swTENGaHNoYTRycEdHWkwrZ09FaW9KMHMwWUVlek9FcXB4WUV4MVVEOHhU?=
 =?utf-8?B?RHlvVnJXTHRQaUhTTVV5T2g1NFVMZnFpS1lyRFYzUHpMNDBYcVYzanZ6NU4x?=
 =?utf-8?B?Zkw3T2pwMHBiSXRHOUtHTkRZcUZ1Y2Fianh2VUdpenF5R05kSXJLRy9GNnp2?=
 =?utf-8?B?V1JYODd1TDhvYytFYjhpalAwVS9rNlI5QmJFN0N3VGhBLytHUXJHWlJlOU12?=
 =?utf-8?B?OXNaQ3MxOTFPeGR5dHc2TnJLbkV4SVhFRjNSekxqSmpCZlZtTS83YWxwWHVr?=
 =?utf-8?B?ZXdDRlVyU2h6dFBqcGFDaDlvanV1aExsY0dkcjJRZjB6bjRCL3ZHOWR5ZXVn?=
 =?utf-8?B?NWg5eitOUjNqZU5UQXgvTEYxVjJZZ0s0b3Ntcm9zR0VXcTNPdmhVT1FFVVNm?=
 =?utf-8?B?YnJYdENWM0pVNlQyOE83emJ1MjlIdTVCNmxKYm1GVlZUUS9xS2J2MWI2SUxS?=
 =?utf-8?B?L0lEbFBVV3NiV0E2L0xXeUliaHducUY2NWZWa2ltR1oxWWpzUkplN3NtRzVs?=
 =?utf-8?B?UWw2SmkyYkNFZHExNjkwMXdITk0rd3JZamp6dkVtc1FRc3VJeTZaMUpYcmVG?=
 =?utf-8?B?ZkxIejFsa0YxMEJJcVk5NU5FamZDSHJsaDJxRDNpOUVDdFphQ3BsWFdIcmI0?=
 =?utf-8?B?K3k2YzVyTTBBV0pJTWwzN3JrV2xxemZoS1NYdjFFcnJ6TDlXa0pKM0lRYU15?=
 =?utf-8?B?OG1meUZxbFpFMklGV3kvMlJvck1YRlpQbWVMclQ4djlXQit1OFRYNGN6RzZP?=
 =?utf-8?B?QndjWERwVjJBR3lIKzBnTitYeC9FYUFIeklsMDd4SFYwQllzeitaVWViY1Y5?=
 =?utf-8?B?dkU1QWg4aCtEOVZxeXFwVXJvb21HeVpNVElOOW1abVBueWo1UE8wNG1KOWVz?=
 =?utf-8?B?NWEwRDd2RVhmaVpPRUZtRnU3UktzZDVRYW1BbVpERjJOcjYwVWlvaGJuYkN5?=
 =?utf-8?Q?b21FXharvcq8onK/DeVu9+R1XBaaSVz8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1kQjRnS2hPRkgvWmF3MnlJOEJDdUI1Wk5XRVZ2cDkxTWdMalQxQUdQYjNa?=
 =?utf-8?B?bXN0VUIwY3g4VE1zeGtndFRpdnp3MDdYSmloWnV0Y0l2aVI1YW5Tekt6d1J4?=
 =?utf-8?B?TlBWWDkvWGpiL0VzbVllSHBtSjB5RFh2WlVrV1diTE83VSszRE1qdDFpamlB?=
 =?utf-8?B?WWpKQjlZZVdzNVQyZ1FURmgxRmhpQXdYZWhmMlJscitDamltcDdEeEhrdWgw?=
 =?utf-8?B?b1U1ZEttVjhUSXZMMnA4cU1GUjdBTHBHWTdEZGV3OEt5aFFEcWU0OUdpaUJJ?=
 =?utf-8?B?VWxGV29aWmFIaHhWa2VDYmx6aW4xME1mNHkzTEtMK3ZPZlJob0lhdjVOeE4y?=
 =?utf-8?B?ZTFJVXdiWVFzRVVzSThGdjd5RnBFU2NIbmlEcVNGN0lFbmowZXErc08yQUtH?=
 =?utf-8?B?aHdYREYxSld4QmNYRktUc3ZEeTJ3S01jejFFdlpUV3hpNEUyTStXelFyUnhU?=
 =?utf-8?B?U3JiN3BMQWh1Y1A1M2dQcEE3Y3A4RHNkdjVwRm5ud2t3Yjlpd0twTHl0U2kv?=
 =?utf-8?B?NjRjNVhxM3RGcGpHZURyZ2RvOENnWUNXc0M2WDRSdmNTVWRzenpIdHNQSmVW?=
 =?utf-8?B?MGRDSHU2NkRZNjcyRlhGaWFrRnZXU3ZvZUZhdXpyTnRzeXczcGxNMW0wWjEx?=
 =?utf-8?B?MWxYL0dERERZMlNzb1dDbnlXcHpGc2VlWXJHQmdVNXdLQUczUTRSMEhHcU9F?=
 =?utf-8?B?TnBuRnJHTnBrL3gzVjBaQ2t1NmNybWhCOTJ1Nk5vZUVIRUtxNnd4ZmVLR3JP?=
 =?utf-8?B?SU1tc2VnYVpDdVRtS2VsTmtadWRxNVl6NGUyUXVScUxOL2tpWVRpZ0JuUFM1?=
 =?utf-8?B?eFI3eTJjb0NpeU5XUVlURUpuSHdDQTRPRlhJNE5tcnhlMVJVRzlsRjNvTGl6?=
 =?utf-8?B?dTB3bXBCT3lwY3dhMVVhWHAyakVEQll3QzRCbTVHMFNpZjcrVjBITzdMYzJY?=
 =?utf-8?B?MFVFWVN0QlpnS1RZZ0l1QmFiU3RCUVpCeXdIcVBmZHlCYjBUYXdxMkNlSDBY?=
 =?utf-8?B?RWp0VXhOSlMyRzhxUEhDZmlQdFBPVG44YmtMaHZZNWRLSXgyVHlLZFJLczl1?=
 =?utf-8?B?c2R3K2sxRFk5UFNQMGIzaHdmODE3QmZkSytFWk1YY3ovMnZGYTAwZFVGWnFo?=
 =?utf-8?B?dEpMNjRkMkxXWTVGMUhXQWNDbGkxM3lOZmpyTlhpRHZ6UnpsKzBmRUhyYm13?=
 =?utf-8?B?THF1UHdDNnZEeHV5TnZQN0ppdDRJam9tRmlqLzU0ZDd3Z2lmbm5pWHNEaFZx?=
 =?utf-8?B?TlVhb1g2Z3RkQTVHSjBaWWxFZ0k5RVdoOXpXTGNvN1g2TlFGOGs4TTVDeXMw?=
 =?utf-8?B?OEZ3VnRtUnFNdDZKYW10ZmlMMFhVSEx3Z05mdGRJb2NsN2ZpN0M1MHovaUhF?=
 =?utf-8?B?a3pic3dtbEJZTnpKdWpEaDRDeFJNNnFJS1lnVDJNVzJiQ0tld0Y5V0I3NWd5?=
 =?utf-8?B?TkpZNmlvUjkwU0t0cnRUZVZRRzJYeW9qMDkyUFFobFk5TE81K1YreXhJM1Nk?=
 =?utf-8?B?bEJPaHhUTGRMWXFkL2x6UGhVQ3BOby9DUCs4OVNKNnZHejhLSjV4MWovOWVD?=
 =?utf-8?B?cTJWL0NGNmQzU1VBVERWOGtIZ1JjRHF5dG9NV3RCcFMzeVo5TGFPSlJHKzBD?=
 =?utf-8?B?Qyt4VW9lTi9xSVZGaGtCU1A3bGlURW53K3pKUHVxakE3eExiMmV0TUdDRUdh?=
 =?utf-8?B?bTZ4eUlRZXNxOUU4SVk1SWV2ZStXbGFVSk5iOHBlbFlBMGM4aWxqNHVBNFFT?=
 =?utf-8?B?SnNmSEZrb0FZdnpDQ3p0Uk5OYTdQbzdrMFQ1QUozbi96eWJDeG1iejJpcFJV?=
 =?utf-8?B?N05MbHRnQ2plOG1qYVRrc3BhcCthUzlHOGZoZkM3ZUVMVnprUnFGK2FGendR?=
 =?utf-8?B?MWROak0vYURxN2Z2Y201S2h3S2dyV3hYV3FjdUFndjJBZGhlTXJlcCt3RnRK?=
 =?utf-8?B?bkNGRGpOczVuKzVubElLc2Y5SWUrcVFVaFIvMlJndERIZmduRWw1aWpuUzdS?=
 =?utf-8?B?MmZyUlNNcDFnZC92b2xSN3FoNjVpR25HWDFiTEZqanlwc1JpWU1sY3M5U1VS?=
 =?utf-8?B?emZJMEttSlgxV2V1clB6bHQ5SHJjaWo3ZGdaUWNxUUpmOHQzUDROU0V4Q2U2?=
 =?utf-8?Q?MzIoyaujhxbvbD2rC1THofJGH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3147e232-2a2f-43cc-581b-08dd5257dc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 09:12:26.2923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHmIGKDSX1lmkyB9eNIzjmG2DcFt7Ne3IbWZq3MuuPk3H6C7Ms+L+1erY1lZ6VFd8DMP2ikwogyE0XdrPoSC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10232
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

QWNrZWQtYnk6IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0K
