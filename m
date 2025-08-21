Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C86CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21E6740292;
	Thu, 21 Aug 2025 06:51:53 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8C1704026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:51:51 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L4d9CQ007874;
 Wed, 20 Aug 2025 21:51:50 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nvm5r0kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 21:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoMWiEnjtvrSknV3LWRAucSnQeCPm1Eeregi2zqg/XuzJNyLazjOJSVF8TEJ2CAYMFr2bXONDpFDoW4/Z2Fy2dh69ZNeqC+Ibt8K10GU379FYfx4oPiN80Xcf2jGKtH7eG3I7NRASUaer/sedG6p4w6hVFuLsxEy7TbECtt7/3bW/GdeV4WShSZGvuRE1hNA+G807aW18YgPhGB4BduA5PV048yUY+8A8cokDtjipXbjyUmM+x27v3KlUn87OEfgt3xJfpj85xVmaa8VnouAM2NaOzr8DdRMi1i1K6IO7NlvHI96Rq7b6Jef3WnBF+5t7E1A1MiaHNCfAp5SfdhQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVeOOX1ujCOFfAWWYN3tjAVkbEmSECzIAFWUVhadsLM=;
 b=jDKrR+RioRhjk2+oigXKgaSpi13tDhixNjtaNj63hrkz+o/kS4jIKULOflFJ1JqyYxcnX6JtAxWvPGRRxqrrtznOP6epqxPEM78fJ03Mf5l9AHK/XVMW15b4S/xX8WNgYcFtYT5xFmGO/2SJ48jz1juusvnem5e/79zqSBAO8eLYP8H7C19Dso4i2jFmNzvtQNuUlE3WbZog7qCtwaCreQ8ym2+R75AMil6Lyb5FNE4D+xgriDADdyYCyPbSgCyqaUM9X/ywu1d9Xn1D2sA3ncKS2kLSRMTDCtImQqOfegW7rPHu27eLdASpefzwcPorN1l8levC/DQS9Fg0owqzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVeOOX1ujCOFfAWWYN3tjAVkbEmSECzIAFWUVhadsLM=;
 b=ovQ3VwW3nj0wbroxJY5AM9ot4RJput1XiDCJr4EI+3Y4Lzzd87tjEevJoLScXEq+04w0VemTMFiTkZ4mhH9H/8eF5ioBMNTlghtxeKwpnYOIM/cYH24XHCwpzaTN+4KeZYtEYTS9LolxtxnNmf+HoGWrvep5AI/1VFlCrSBlNNc=
Received: from SN7PR18MB3869.namprd18.prod.outlook.com (2603:10b6:806:101::9)
 by DM6PR18MB3602.namprd18.prod.outlook.com (2603:10b6:5:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 04:51:48 +0000
Received: from SN7PR18MB3869.namprd18.prod.outlook.com
 ([fe80::d55a:768f:3d17:7cfa]) by SN7PR18MB3869.namprd18.prod.outlook.com
 ([fe80::d55a:768f:3d17:7cfa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 04:51:47 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcEftTdTR+/QHyaEK5+gbvzWTV97Rr5NEAgAClI8A=
Date: Thu, 21 Aug 2025 04:51:47 +0000
Message-ID: <SN7PR18MB386917862951DD1A6ABE715FB432A@SN7PR18MB3869.namprd18.prod.outlook.com>
References: <20250820111350.2992591-1-skori@marvell.com>
 <20250820175317.3063659-1-skori@marvell.com>
 <20250820115818.0a3628ee@hermes.local>
In-Reply-To: <20250820115818.0a3628ee@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB3869:EE_|DM6PR18MB3602:EE_
x-ms-office365-filtering-correlation-id: e996e617-2600-4967-dfe9-08dde06e6f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RHJVdXhZbVVvYWRtSVM3MmpRYnJaV2xyOUpPdlVIekRIVEsyQlR4R0d0MG1R?=
 =?utf-8?B?S3ViRzdvSm0wdjJVUzQ4bkJlMlVhbGlSS1A2VEtPVDFybWhOdWlWb0ZXeFFK?=
 =?utf-8?B?TXljL0N6SXVkZGxaSU5QbEhPdzlWVTY4TTFZOUJ4Rzl5cEZQOWpVdXFzZFJh?=
 =?utf-8?B?SnNENjh5ZnJldCtBZW5DVEVYWW5meEc0b0I3OGNJeXlDYmJ0ZHZRazZ3cEsz?=
 =?utf-8?B?dldyb21mbnplMThoTUx4cjZiS2E2TzB2RWVENmVPekEwQzA5WW8zN0NsN0Vu?=
 =?utf-8?B?M2tyRnJUaTdmYUoyU3BOdmQzejcrVWJ5b1Y5bVZ2WFQwS3NGZVlhcG0vVENu?=
 =?utf-8?B?OGpnaVNGUDlLYmtNVEN0OXF5Wm9Ia1d5K0RvSGhiczBxNDhhNUxJSkhNdEFO?=
 =?utf-8?B?U1VWdjhyR0tMWUhSNHBkRk9XYlB1M2E4Y0E2ZFVBNWNXajBIRDlmNnhYRmdJ?=
 =?utf-8?B?RkVPb0xrWGxCR2w5ekFVSDBxY2VmbkVCQWxOOFRZKzNjUG4xU1ZOTEQ3RjdT?=
 =?utf-8?B?Mm10VWNxL0lNMWdGcno5TGJCTE1kWDVBTTJqUldUbFVqOEJvbmlHN0FkTU02?=
 =?utf-8?B?cVdhS3Y4cHpsT3RCUWRwdjF0QzNOaVJTNWJDY01PNmtNTXloQmI1TG9uMW5Q?=
 =?utf-8?B?MTB3OEpRcnhtbW9hTnJKeEsvaTQrb0NIQ0FiU01nMUNVQzFodTZCYnFKM3JL?=
 =?utf-8?B?TXAyQ1E2ci8wNEdMdjBMWndkdFZtVnBlS0FjRjZnaW96cDdxVGxrOFBwT1M5?=
 =?utf-8?B?UC9FRWliTTNyWDh5NGQ1MGhyVkUwT0F0VWRlU0VoZ21GL1FOOUMwbFZHbUIw?=
 =?utf-8?B?bHdNSnN5dGVoQnFPN0R2cXRabm82ejZiV1dzSDYyTzlHcEJrV3NTdHZ6VUxY?=
 =?utf-8?B?TzQ0cDFCUGhPUnR6UTdTeDl5MkgyZWIvQXdvbU5iQjgyc1RnN1JJVXRsZ0Na?=
 =?utf-8?B?dDBISEpUa1JjaWI0ZW5vemhDUVdvbkJ2RG1iTjBxV2NXSDFzZWxsc1JLOTFX?=
 =?utf-8?B?OHB4UzMwRkR3TG1ad0RMQUxZWmlDRzBCWVlESElDWWthUXBickEycWpXeHp5?=
 =?utf-8?B?SWZQdWFvRUhoQkd1cUVwQklpNGpxb0RsQkRqUkxrT3lxQTBTWXNUQ0MvanRu?=
 =?utf-8?B?SkN0ekg2TmdoNE9zV2pYMDVzMjRnTEZOcDF2dzI5NXhSdTAxZER1dVIyd2VU?=
 =?utf-8?B?NUtvVnF4TWpTbWZtYU1yOTg3SUsvQ2R4Sm82eVZjNUtVTzNqc0R5cjlEa3cw?=
 =?utf-8?B?aHFFZEFpYmhvU2hsVGx0NW9HWjRLUzN3L0R0QmZmMXR2Y0FCVGxaRDNiVDFL?=
 =?utf-8?B?L0VGeTZaZzQ3d00vMkFVTlZ4emxjdmM5OE9BZitBNHNLRCtncG9PelZEWk51?=
 =?utf-8?B?MkVyd0JNbVVDSjBGcXVKWkc5T29WUnNONi9pRVVBcFVyaXhBQkM0STI4MVgr?=
 =?utf-8?B?WEdYa0VrZjltSFk1T3UySmVab3I1Ui9iMG52K1dKbEhMVEw3NzJxa0FQcXRQ?=
 =?utf-8?B?SThrbnBZOUJLNThyTE81cm1nOXNJbTlYaTYySUZOZzVNOGVuSzdSWlhNOXRQ?=
 =?utf-8?B?bE81eXRzRTVxeFFsTTFXSkdITzBhaDhkRm9WQVhNZUdhcDZNa3FtN2NJZ2Qr?=
 =?utf-8?B?bHJucWlzcUJxTlBBSzJIanU4UVF0eFMrZTc5NEtOalh0amcyVjgrK0ZBemtm?=
 =?utf-8?B?YXRMb2NZRWZyUGdlRlBrbWhSclRJTkhjeXVJUUI3NUxQN2VySTVqcnhHT2dQ?=
 =?utf-8?B?eWgySkoyV1JBaTRoMi9nN2pMMHVRUG5FM2ZNWjVXcTRMemp5WjUzUVc2MXhF?=
 =?utf-8?B?TUIvT3lEM0hPODVMV1prdGFMZFI5VzRKbHZPcVJ4MlpNUVJldmRoL09maW1B?=
 =?utf-8?B?U3hNdVVlSjdDZXEvbG5TZ0hxUXR5VDBIcmFOWDVwSGp6WWo5NzNaVmlEbEtl?=
 =?utf-8?B?akdsWTRBYkttdUg1T3FmVTJGd1NjRCtWOFhzbmtlRURHVUVFem44Nm8zK1k0?=
 =?utf-8?Q?/YgAXZesavzKzDOAMzVclMc/TwXGvo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR18MB3869.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDRxamZ5TzZrTTdTeEpXMWxBQko2TmY3aUR2cDg2NGt2T0sxZGJwTmptMTVC?=
 =?utf-8?B?ZFR5cDZKSllWK3ZWRUIyUE1UNTFER3VxZTJUdWZEazllQThYUHF5bmg2Q3R5?=
 =?utf-8?B?UWo2QmFrRGVQU3BKQVdidEV2LzNVdFI1L2JYSDZpa2UvMDdiT0dLZE53T1l5?=
 =?utf-8?B?Y2tXYTdMbHB4SWc5Y1RCRmdtcDBodXh0d1BEQWRoendpaWJEOXZ3WjhYdC84?=
 =?utf-8?B?WktUbzZhaE4vMzNsWWcvMXRoa2tzYzF1ZjBEL3ZEZlM4UGpOcDF4TUtGd0l1?=
 =?utf-8?B?VE1iVlZhbnJXOEY4UVM3VFRQd0ZPYmk4MDVRd3UvMGlab3dCU3JaVllRRE1S?=
 =?utf-8?B?M3d1b2xLeUNhZnhFQ3gvb3VmSHRCaXVrMDI3SjJwQTBkVFJCeWNXN1FvQzFx?=
 =?utf-8?B?OEZ5UFFITDBLNkxkQi9OZ01XbEZ4bWx5Z3Q5cXNjUExERUtwRjlLUFFhc0px?=
 =?utf-8?B?d2tRS0MvcEppSG4vNzVIZDNQZngyK3FRb1hvYjNha3dqOElQMnJzYjVudm9y?=
 =?utf-8?B?MXJqa05pRENzTzB2S3loeGZmbFNpNXpZK1NmbDZWRWZCVXZIZ0V1aFdHVUs3?=
 =?utf-8?B?WVFqdHd1NDZTaWM0MlorN1daSHRNVExIeDRuTmtMZFpsZm1XbXYrUnBMWFBW?=
 =?utf-8?B?Rk9iZDRjMkZsYnAxOXd3R1JlRjkwT0l6eUYzUmU1ZXFjNGFVYkc1bXdiSDNX?=
 =?utf-8?B?S1JtbzdIY1RBQjRxdHV5TEErUzNHSlQvNy8rVWpiM1FBZjlETyswL2ROK01q?=
 =?utf-8?B?TjZBa2Q5VkptVzNiRlFsVEhwVkZiU0VyS3BQNzhmQUdldXgwNzFsRG5QdjJ3?=
 =?utf-8?B?aVA4dVBLVkVPSWMzb0ZTZ05rMEZPbmVjOVBqSEFLOHd6U0VWdnBvL05RZXg5?=
 =?utf-8?B?RmZJUkg5Qmk4Vy9PdWZCZnQzR25mV1FKbXNKTDJydzdlakwvdWNVWVNwYzFC?=
 =?utf-8?B?Sktjd0YwSUdreFVCUGk5aG50aU9iWEFIcGtwU1JvM09lK01wVFBrSnlBWTc1?=
 =?utf-8?B?Y2dNZ21SRDloMzA5aWZESitacFQ2ejJkdXBZbnlmeUh3Mlo1MFE2Ly9ZdVZX?=
 =?utf-8?B?SFpxUmlzV0IrcVpLSG5PV0R1VXJSUzJ3WVlmTk5yeXR2SXhIOXFlTEJTbDlB?=
 =?utf-8?B?MjY2eGtuRWxBYTFacmxrb2JVU2JMSnpibnVCNWkyaXFiVEpvMTRsUXRiUUxJ?=
 =?utf-8?B?TThiaUVKV1ZhbXFYcVJlNHlsTEx6U0tQRjN4bW56TGVCbzVQUEh0ZUR3TFlp?=
 =?utf-8?B?VVVpUElUTWVwVkhLNTE2OEpuUW9sVmxIMk5uTWRhS09LczhHRHA5c1E4aGNM?=
 =?utf-8?B?OHZod0tEdXp6ZEVZSWhaTGxBcEcvY3BxNkR2QlBZcUZyS0M3Y2NPSkhkbDA3?=
 =?utf-8?B?b3N4SEVXampDeEhiZG5zUFllSlpsMXRabjVFWmlNRVQvb0NFaE1XWVlvQjlv?=
 =?utf-8?B?dUxWQWIzdUl2VW1Pa0F0aHZ2Zk1SZmMwTnJVUHpJb2szYVIvZ0YwV2VzZkhx?=
 =?utf-8?B?UWxWY2ZjL0x4MnNTQkF1eTMyZERseVA5K1JXNTdPOEdld3lTOHFjdkpOdk5V?=
 =?utf-8?B?YlpMaEE5VEJlNktQeEpBSmlxZ05Zcm9CQnh4a1pKVDVLdVRhTVNFWkFJQjJo?=
 =?utf-8?B?aHN1Ym1Ec0V3aGFGRXZFcFlVOTM2cmY0TnBtRHQ3NWVZY3Vic1o4cUUybS92?=
 =?utf-8?B?RERZcW1DNUNSMW01WkNaRjlEdHNwbllQQ29jYUxJOUV3NVM1eFJPbmZWU1JZ?=
 =?utf-8?B?dVJ4WkFETEd0aXZEZkhEdk9KYWFadlRldTg1UVhjSytUKzJNeWwzZE16MkpK?=
 =?utf-8?B?b2wrWmswUldOcUtISGo4alA2RlMrUXl2QU5KOVRYQU9GSCtpYUlIenl4Mnk4?=
 =?utf-8?B?cm0wQkFGSXZNL0J2cm84WnhpOG1wK2xnd3Zrb0wyTTdSUlZYL3p0TlpnaERI?=
 =?utf-8?B?VEoySE5yQkw2bVRuYUE0TUxrcm9scHJSZWpVL0hndkVyb3RFUmQ1RzZSWlIv?=
 =?utf-8?B?bFFVTi9qd1dzTmtkc1lNbXIvNGNUU3dqOVgveFZoTktkaWlHUkNwYzBoU3pW?=
 =?utf-8?B?NDRMZjR5TjZRS1h0bnl6QjdlWnpmVzE5MmZTK1d3UTJ0VnMxZmhaS0RzVHNs?=
 =?utf-8?Q?cerA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB3869.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e996e617-2600-4967-dfe9-08dde06e6f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 04:51:47.8275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRy10nGxYLfw92FetiKD6fbJE0T+71qt+JX28QwuBdklSLUGVr4+CndThT2aBaQEVQeZdWCMvS+CmeItyYv0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3602
X-Proofpoint-ORIG-GUID: a7z2ix_RyeKgc04c4utnmLs8ZixsSYkE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX+oBwbLOZEKqT
 6JirWhED2MIyInkA9SPmglCfpzz6oei+DJ1q3u4frDSzAYvyr+zPxHRyD98yZ5Qgq5Cze5D7eDA
 O6wiHlPSjf/o0ujD8GGMxmoEfXzhtVmkxfOFmECrMHGYRR3zl5H3YV+nQtP7+d9LAHCyB/A9Mw0
 uF25Q8lODlEnc07eLbNN83DL25enzHKPvH5tYmCK4dZDFvGSclKw/9v2eJFm9v7dm6N5I2NH/7/
 je8xuhVNqTixcElPFtaLdlgcm93x1wjmPgt0rPO3ha7T3bB3g8yfKkS3wQVRpq4qbolM2HA3HI3
 1mqIi4cA1ItvlYpDfLU71LEvDgXKKyeH7xUqk20G8uo711I4reH0yIqSjZeVqwxKTXQKXZmwge8
 RuSGZqZ+TV0E/jljX7JoX6Xt0KFExHIchgw+Z9mRwiYXAOT1tStsHPGMeFYrY+twomta0WSV
X-Authority-Analysis: v=2.4 cv=UMCE3Cfy c=1 sm=1 tr=0 ts=68a6a5e6 cx=c_pps
 a=GgypNCAcwMqkIBBZWUxeDg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=vbm1h1_45zV7ii8As3UA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: a7z2ix_RyeKgc04c4utnmLs8ZixsSYkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

PiBPbiBXZWQsIDIwIEF1ZyAyMDI1IDIzOjIyOjMxICswNTMwDQo+IDxza29yaUBtYXJ2ZWxsLmNv
bT4gd3JvdGU6DQo+IA0KPiBQYXRjaCBkb2VzIG5vdCBhcHBseSBjbGVhbmx5IHRvIG5leHQtbmV0
LCB0aGVyZSBpcyBmdXp6Lg0KPiANCg0KQWNrLCBJIHdpbGwgcmViYXNlIGl0IG9uIG5leHQtbmV0
Lg0KDQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9ldGhkZXYvZXRoZGV2X3RyYWNlLmggYi9saWIvZXRo
ZGV2L2V0aGRldl90cmFjZS5oDQo+ID4gaW5kZXggNDgyYmVmYzIwOS4uYmM2YzNhNGEwMiAxMDA2
NDQNCj4gPiAtLS0gYS9saWIvZXRoZGV2L2V0aGRldl90cmFjZS5oDQo+ID4gKysrIGIvbGliL2V0
aGRldi9ldGhkZXZfdHJhY2UuaA0KPiA+IEBAIC0yMTEwLDYgKzIxMTAsMTMgQEAgUlRFX1RSQUNF
X1BPSU5UX0ZQKA0KPiA+ICAJcnRlX3RyYWNlX3BvaW50X2VtaXRfc3RyaW5nKHJldCk7DQo+ID4g
ICkNCj4gPg0KPiA+ICtSVEVfVFJBQ0VfUE9JTlRfRlAoDQo+ID4gKwlydGVfZXRoX3RyYWNlX2xp
bmtfY29ubmVjdG9yX3RvX3N0ciwNCj4gPiArCVJURV9UUkFDRV9QT0lOVF9BUkdTKHVpbnQ4X3Qg
bGlua19jb25uZWN0b3IsIGNvbnN0IGNoYXIgKnJldCksDQo+ID4gKwlydGVfdHJhY2VfcG9pbnRf
ZW1pdF91OChsaW5rX2Nvbm5lY3Rvcik7DQo+ID4gKwlydGVfdHJhY2VfcG9pbnRfZW1pdF9zdHJp
bmcocmV0KTsNCj4gPiArKTsNCj4gPiArDQo+IA0KPiBJTUhPIGFkZGluZyBhIHRyYWNlIHBvaW50
IHRvIGEgaGVscGVyIGZ1bmN0aW9uIGxpa2UgdGhpcyBpcyBqdXN0IGV4dHJhIGNsdXR0ZXIsDQo+
IHJlbW92ZSBpdC4NCj4gDQpBY2ssIEkgd2lsbCBzaGFyZSBhIHNlcGFyYXRlIHBhdGNoIHRvIGFk
ZCB0cmFjZSBpbiB0aGlzIEFQSS4NCg0KPiA+ICtSVEVfRVhQT1JUX0VYUEVSSU1FTlRBTF9TWU1C
T0wocnRlX2V0aF9saW5rX2Nvbm5lY3Rvcl90b19zdHIsIDI1LjExKQ0KPiA+ICtjb25zdCBjaGFy
ICogcnRlX2V0aF9saW5rX2Nvbm5lY3Rvcl90b19zdHIoZW51bQ0KPiA+ICtydGVfZXRoX2xpbmtf
Y29ubmVjdG9yIGxpbmtfY29ubmVjdG9yKSB7DQo+ID4gKwlzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IGxpbmtfY29ubmVjdG9yX3N0cltdID0gew0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVD
VE9SX05PTkVdID0gIk5vbmUiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1RQXSA9
ICJUd2lzdGVkIFBhaXIiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVDVE9SX0FVSV0gPSAi
QXR0YWNobWVudCBVbml0IEludGVyZmFjZSIsDQo+ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNU
T1JfTUlJXSA9ICJNZWRpYSBJbmRlcGVuZGVudA0KPiBJbnRlcmZhY2UiLA0KPiA+ICsJCVtSVEVf
RVRIX0xJTktfQ09OTkVDVE9SX0ZJQkVSXSA9ICJGaWJlciIsDQo+ID4gKwkJW1JURV9FVEhfTElO
S19DT05ORUNUT1JfQk5DXSA9ICJCTkMiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVDVE9S
X0RBQ10gPSAiRGlyZWN0IEF0dGFjaCBDb3BwZXIiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09O
TkVDVE9SX1NHTUlJXSA9ICJTR01JSSIsDQo+ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNUT1Jf
UVNHTUlJXSA9ICJRU0dNSUkiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1hGSV0g
PSAiWEZJIiwNCj4gPiArCQlbUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9TRkldID0gIlNGSSIsDQo+
ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNUT1JfWExBVUldID0gIlhMQVVJIiwNCj4gPiArCQlb
UlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9HQVVJXSA9ICJHQVVJIiwNCj4gPiArCQlbUlRFX0VUSF9M
SU5LX0NPTk5FQ1RPUl9YQVVJXSA9ICJYQVVJIiwNCj4gPiArCQlbUlRFX0VUSF9MSU5LX0NPTk5F
Q1RPUl9DQVVJXSA9ICJDQVVJIiwNCj4gPiArCQlbUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9MQVVJ
XSA9ICJMQVVJIiwNCj4gPiArCQlbUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9TRlBdID0gIlNGUCIs
DQo+ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNUT1JfU0ZQX0REXSA9ICJTRlAtREQiLA0KPiA+
ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1NGUF9QTFVTXSA9ICJTRlArIiwNCj4gPiArCQlb
UlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9TRlAyOF0gPSAiU0ZQMjgiLA0KPiA+ICsJCVtSVEVfRVRI
X0xJTktfQ09OTkVDVE9SX1FTRlBdID0gIlFTRlAiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09O
TkVDVE9SX1FTRlBfUExVU10gPSAiUVNGUCsiLA0KPiA+ICsJCVtSVEVfRVRIX0xJTktfQ09OTkVD
VE9SX1FTRlAyOF0gPSAiUVNGUDI4IiwNCj4gPiArCQlbUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9R
U0ZQNTZdID0gIlFTRlA1NiIsDQo+ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNUT1JfUVNGUF9E
RF0gPSAiUVNGUC1ERCIsDQo+ID4gKwkJW1JURV9FVEhfTElOS19DT05ORUNUT1JfT1RIRVJdID0g
Ik90aGVyIiwNCj4gPiArCX07DQo+ID4gKwljb25zdCBjaGFyICpzdHIgPSBOVUxMOw0KPiA+ICsN
Cj4gPiArCWlmICgobGlua19jb25uZWN0b3IgPCAoKGVudW0NCj4gcnRlX2V0aF9saW5rX2Nvbm5l
Y3RvcilSVEVfRElNKGxpbmtfY29ubmVjdG9yX3N0cikpKSAmJg0KPiA+ICsJCWxpbmtfY29ubmVj
dG9yX3N0cltsaW5rX2Nvbm5lY3Rvcl0pDQo+ID4gKwkJc3RyID0gbGlua19jb25uZWN0b3Jfc3Ry
W2xpbmtfY29ubmVjdG9yXTsNCj4gDQo+IFRoaXMgY2FuIGJlIHNpbXBsaWZpZWQgdG86DQo+IAlp
ZiAobGlua19jb25uZWN0b3IgPCBSVEVfRElNKGxpbmtfY29ubmVjdG9yX3N0cikpDQo+IAkJc3Ry
ID0gbGlua19jb25uZWN0b3Jfc3RyW2xpbmtfY29ubmVjdG9yXTsNCj4gDQo+IFNpbmNlIGVudW0n
cyBhY3QgbGlrZSBpbnQgaW4gQywgbm8gbmVlZCBmb3IgYWxsIHRoYXQgY2FzdGluZy4NCj4gDQpD
b3JyZWN0IGFuZCBJbiBwcmV2aW91cyB2ZXJzaW9uIGl0IHdhcyBsaWtlIHRoaXMgb25seSBidXQg
b24gV2luZG93cyBtYWNoaW5lLCBpdCB3YXMgdGhyb3dpbmcgZXJyb3IuIEhlbmNlIGFkZGVkIHR5
cGVjYXN0aW5nLg0KDQo+ID4gKy8qKg0KPiA+ICsgKiBAd2FybmluZw0KPiA+ICsgKiBAYiBFWFBF
UklNRU5UQUw6IHRoaXMgQVBJIG1heSBjaGFuZ2Ugd2l0aG91dCBwcmlvciBub3RpY2UuDQo+ID4g
KyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gY29udmVydHMgYW4gRXRoZXJuZXQgbGluayB0eXBl
IHRvIGEgc3RyaW5nLg0KPiA+ICsgKg0KPiA+ICsgKiBAcGFyYW0gbGlua19jb25uZWN0b3INCj4g
PiArICogICBUaGUgbGluayB0eXBlIHRvIGNvbnZlcnQuDQo+ID4gKyAqIEByZXR1cm4NCj4gPiAr
ICogICBUaGUgc3RyaW5nIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBsaW5rIHR5cGUuDQo+ID4gKyAq
Lw0KPiA+ICtfX3J0ZV9leHBlcmltZW50YWwNCj4gPiArY29uc3QgY2hhciAqcnRlX2V0aF9saW5r
X2Nvbm5lY3Rvcl90b19zdHIoZW51bSBydGVfZXRoX2xpbmtfY29ubmVjdG9yDQo+ID4gK2xpbmtf
Y29ubmVjdG9yKTsNCj4gDQo+IE5lZWQgdG8gZG9jdW1lbnQgdGhhdCBpdCByZXR1cm5zIE5VTEwg
Zm9yIGludmFsaWQgbGlua19jb25uZWN0b3IgdmFsdWVzLg0KQWNrLg0KDQo=
