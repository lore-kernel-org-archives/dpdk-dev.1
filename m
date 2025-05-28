Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E26C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 16:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E7F2406BC;
	Wed, 28 May 2025 18:14:17 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E1FE440156
 for <dev@dpdk.org>; Wed, 28 May 2025 18:14:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SDqeB8021093;
 Wed, 28 May 2025 09:14:14 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46x2rkrh02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 09:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsJa/ZguKYkAFZDHXgUftacJnve7bPABlhcMy5BWxeP3sJKOS83esS8+drYcjJugfSTt9tPLj2vxhNfoKZz6X/uvDMj3NBqMvxlxXK0Q80rkP4UQcWKiwLMr0WvcOvlk87v4ED+oZ3tSFL7w6LfiYoYLKpPeedhISp90E5A1CQxOPIyNnKPOXL9GtVF16qplISvDRZjsKBdyGD9AI12afQPk0p0WvZABoGRoDC8KF1EPrjbhE5ohFnnHNrfEgP0ihhogS8wKpv3ilvYatAlzPMU8VmcvaUlkTYv2bZ8e/YKEA+8p465rToGr8YgRCVUpOAhL2fiSe9fZEd59eVcPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2pI1J4/uLQmhD0ye2Ul99ckm80bbJ8/+wprggIqVpQ=;
 b=PNs7ynUQLK/W6fh7wTLG8CSCfRmCN6U3D8lzdaOsI+atlI6Prsp06JIXlksjOk12nby2+W5AD8I3rVm2q3tMtEWwWIPBsHaeGxfFUR1yxiGteoJ/xeKB3swFFQtG8Ed0SVhcJccA7uOrc+LNW8O9DsU4IBh8OYvhSJVmi4u/1R+N6vvwrlZb0N0QJrU4mO6zqV2EozDVsjMIqe9ZBxdEoHUIQMJ7QTB5YABDADSI2K4nETKfxoH8twSLiuJEce3UfrQf1tu7dmE1GFWy/WaXG35yE/t+0HiCJPlwYP2Y1qySYIVrkJ9pkmru0DXhboTVBUn9muZEGxKah1oUU6Dnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2pI1J4/uLQmhD0ye2Ul99ckm80bbJ8/+wprggIqVpQ=;
 b=P229vbMc5G7K9UyR29EvmTZzfJisMxowNXhXW+MRlbxzMKskgwRhsR0AApALk4axp1bcauwEE1kLi/FnRjjAXBafwvT7l0OPnPOD88ih8+Nb2q7XWIBmUNlw+8bzDDQT8UhVk5xbPJg50vd17blEtRaHKrtw+G9PhSHmAHk5CzA=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by BN9PR18MB4283.namprd18.prod.outlook.com (2603:10b6:408:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 16:14:12 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:14:12 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: "changqing.li@windriver.com" <changqing.li@windriver.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH V4] Add new tracepoint function for type time_t
Thread-Topic: [EXTERNAL] [PATCH V4] Add new tracepoint function for type time_t
Thread-Index: AQHbzv97FsqUMkBhkkK49XX2VM0obrPoOMkg
Date: Wed, 28 May 2025 16:14:11 +0000
Message-ID: <CO6PR18MB386076246E0C20B3EC4F7230B467A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250429030017.1126516-1-changqing.li@windriver.com>
 <20250527120404.2027529-1-changqing.li@windriver.com>
In-Reply-To: <20250527120404.2027529-1-changqing.li@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|BN9PR18MB4283:EE_
x-ms-office365-filtering-correlation-id: 73063996-1c87-4935-98d8-08dd9e02af1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGNFTDBxanRGUGttNkdxSE4wUFFHV0RrZTZOWEtqV0hlbmJzVzVhNWpaWSth?=
 =?utf-8?B?NVlqamxuNm0wamI0TmdSLzVWdnVPVXpOeDh0cnVaaGltbEVKSW9VbllDY2Qy?=
 =?utf-8?B?QUt1ZlU4bUw3cjAxcGVQUWRZR0JoRlQxUHQ2dlJZdnNraTJEQjRlemNLbGQ4?=
 =?utf-8?B?Q0Q3V1dLeEtIYlozcTVpbVJTV2NETnNGdTZybzBQc2VwdnRUcXk2RE5pdjZ1?=
 =?utf-8?B?TXJZR3lFdGdJV1FYRFZHOEt3N2xXd2IyNzlXdTRndTNlcFE3a1kydC9xNkRs?=
 =?utf-8?B?T2FpUmdhc0l5NlZidDUrWllJNVhoclVlRmFtTm9lUXYzSGdIbVZFblJCOWdP?=
 =?utf-8?B?SThsMnhnTmg0dm0zSTg1ZEozdGd1R09VWGVqVVErZlZXbDU3WldQeGxTQU5Z?=
 =?utf-8?B?N2c3dzc0N1plWHVIRi9IcG1xcnlhNW44NlBiSUdlTFE1Y1NBVDJQSTlONm9D?=
 =?utf-8?B?cnZyUE9pSkdDU1RHSVVCQnBDUGxXQnV1eWlVcmpyZTVzdGYrV3RCZ0d1OEN5?=
 =?utf-8?B?L0c1MHNrOWsxeWZLWFRJa1JJUnF1QTNHd3p5QXczcDFsNXl6QUZmS2VnckZv?=
 =?utf-8?B?cWxWdEpvRDRyaytyWmJuQ0hlbTlROUIySGVSTHY3cmdQYUZ2RUVkUExZQnVT?=
 =?utf-8?B?VDF4WThodjhxV01BRklrMWFjdTBKN3NTSmRRUlFlVUp0SDlqdU1oUzgvT01V?=
 =?utf-8?B?LzlVR21UckFoV3JCbnhIRGJiR01uVXV4eDBaMkNBbEdhd2NNQWFrZElyT1dv?=
 =?utf-8?B?TWZUc1lCbjRMTllGUHZ4aXRzR0ZBdEg1RmlEZm1VVlFYZXY5M1EzOXBOV2N0?=
 =?utf-8?B?YUtJK3lrcG5wcFpMbjYrTXNEZmp1c29Zcm9RLzAya01XWmpmdzBRN01QcFl6?=
 =?utf-8?B?Z3BXcmE1cy90SGJjWHZnTzVkSHlPaGQvQVhzbjBnQnV0bkJjZDNxeTQwU3l5?=
 =?utf-8?B?SG9tSUtUd3g1U3FKVG5BZTBsaGY2MnNUYTEzSHFJbzR6NjdzalZFaEJLeHNQ?=
 =?utf-8?B?TVF2ZTBEWTRJVGFwS21NdW0vNzZNZGtRdUR5WnFBRHQwdGRvWm1YZXRVc0VH?=
 =?utf-8?B?QmNXSVQ0WDNhRUNaZHhRa1k4V21PTEJFcDZoRFNFM0dITDdLWHlSd2NvNE5t?=
 =?utf-8?B?SGU4TTJPU0hTSzJUOWRNeUduc1RHbm0vcS8rZ0d0czZtMnBCeTBzWVRqZVRw?=
 =?utf-8?B?L0dhYkhDbTR3NlllcDJ4bFBkazZWczB0U0EyRHNOYWo0UXRPYlhYcWl6bWZK?=
 =?utf-8?B?dkFHOFVCdVZTdG1JQXlvYzQyRzNySngvTmlDTUczdTdQbS9DTE9GTHU5c0V1?=
 =?utf-8?B?VmpHVitxdjRuVXcwQ3prODE3KzA3V2dQa3JjNU5oVG9aYk5mQ1BZVXp5Y0Ns?=
 =?utf-8?B?aVlNZmZlM3F3djBGWnZjS0FSeVphUHJkY1hPSTZhVHdQNGlOOUdWMzBSUGY4?=
 =?utf-8?B?dzFxTVQydEZzZ09GRlpucjA1OEI4T1lGdExKOFhyQlN6dE14a1Ayb3hEWDNL?=
 =?utf-8?B?dDcyRlpwN3JCdStjT3d5eGlQbE5rKytxZ0RHYXlqc1dxTEVEUlVZaGlMUHNk?=
 =?utf-8?B?QU9FRDhFYnVEcUhEcXdBSmRPRmhkUjdEckwremhMdm54R0IvWFh4aXBLcHNv?=
 =?utf-8?B?R05QeDZZc1A5alJlT3dVQU9zZHk1VHJDeVlSUjBwWTlRTndqZ0NWcG5HRWVa?=
 =?utf-8?B?WENPMDlITC9QdDVOMjJ6c3dCT0N4T1Iyck9IMXRPc2JBOVRzZDA1YWwraTFD?=
 =?utf-8?B?bC80WDhnalhoU3NtemhFRnl5eXJ1VnUrdUJFQW9HY3JmNVJnQUorOXpLdklt?=
 =?utf-8?B?MjZLdzI0TDAxZEJ4THI3YnhSaFdzekQvd21kaTk4bXN6c2hRVUZxT0lMUllr?=
 =?utf-8?B?d2g4V051WHgwZEFSWVlhbXJQNEs1LytWWWtZUFlJZUlvWnByclNyWm05ZVJo?=
 =?utf-8?B?NkdOUzF0WjI3bFU3MmVJdDY4WUlQZWVUQkw0Y0JZYTg2MjZldHkzaVlGK3FE?=
 =?utf-8?B?RDBYUUdoNXhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2RsT21seS9xUzZkeXBsTUo4U0ttZnZuMXBwMlVKK2IzYmdwMmlLZldPWERr?=
 =?utf-8?B?K25STnpaNGlBc000WHRJTHpBQU5RTno4ZHowVTVMeWRZbDl6My8yU0Qxbi9F?=
 =?utf-8?B?KzlEbytBY1BBOGF5K21ZTDhhaFNkbEhTUDdFUFdGK3hmNDJYMWNUNEQxSkJN?=
 =?utf-8?B?bmxldFh0YUhnYVZxcFAyT21CVnhNcm9tRzdUZUE2Sm8zaTRweTFJSllBQnI0?=
 =?utf-8?B?VTl1dEltTGk1K0NUbW91QUF2NkQrdUwva1ZERWxvellPZFl5K280SHZvQ0FS?=
 =?utf-8?B?TEZsWkFjVVV2bWgxQ3RxUjZaendocG9QQnVzT2hRTmQ4VVduTnY4b1lpUTk4?=
 =?utf-8?B?Y2dCOVhrMEpwS1p2d0IxSk1BZUg0a2tKMW5UU2wyM0dLN2llVTN3eDY0QzNr?=
 =?utf-8?B?Qkt5VG8xOHhMR3h4UzJoc2E2bXdpRmd1anpRUXN5TW5SN3dJZGp5NnNKdGIr?=
 =?utf-8?B?VTFYS1Jsb3ozRnZGRS93dWZaOWFnS3VSaVlKUjc1MHF2aWhhZXQ3U1ZXSnNM?=
 =?utf-8?B?bUkycy9KRkF0bnFJM2toYjBiSTZ3RUxQazhtaTh1UGZCYjFJMzdMbm5UTTVi?=
 =?utf-8?B?WUI1MmhFMnFQZjRrdmxUWWluUFZKM2FSVWM5RGNFb3ZWZytXdGxCbmxMWVlP?=
 =?utf-8?B?QlVMb2hQS1JHVVlyMmlSTkhsSEYyWmNWaEhNRkt6Y3VablJMR1p5Rk5FZVh2?=
 =?utf-8?B?Q2lyL29nN0lVbFJqTG5DVG5jMFJNUjFvWjB0bkUwcXhsck83M2xhVjFQQ2Z6?=
 =?utf-8?B?RjJTZkxJK0wxbG41eXBKNi9sUU5Xb2N5d3RTQklrU3c1UUpmQURPVkhVNEE3?=
 =?utf-8?B?Z3Z2Q3ljWDFZeUl2ZUdaUWJXN1pCMzZIblQzMnFGNHhGYUZFa2NhOTY4YzBN?=
 =?utf-8?B?dlIvT2crNnBXQTUvSi9CZ20xYXRjdHU1Ykh6eElpalZnbHYwWUhZdXRKVSt6?=
 =?utf-8?B?MVBweGJJTmV0QldZemUrMzVWVCt1K0Z4TERIU1JRUlE2UVI1WWlzaThTSEI1?=
 =?utf-8?B?M3ZVWXFrTU9uVFFZMzljZUx2VytDUXhEa1lqWTZsUXQ1YnpYa2V2S1RtM2lN?=
 =?utf-8?B?a2JsWko5NEZ5c3FlUHpLSGFELzVjOTdQd1RmcVZ0VGhpRWFQLzhZcHdOaERF?=
 =?utf-8?B?dlo3blJmNjhQWlRSamE4bzlSOGp5U3NXc084VGJPRXNiSXBKd0tBQldydzRj?=
 =?utf-8?B?VjhnOW15M2lIMjJlbE93YmV1NStGK2ZnbzVHUktxZTFlUHdGR24xd3ZnamlN?=
 =?utf-8?B?SWxXNDhJT056bEdkalJzdG9QNldqNTZxZ1VGYVVPdWp2cG40L3BGUUorNnl0?=
 =?utf-8?B?SU41TlVuMkIzSENuZWVGOVFHNmhhaUdHeVpRdmRsUE0wTTJhRnNJOFJ0WmFV?=
 =?utf-8?B?QnRLb0ovUnFjRU1BTHdsOTZTSnhNa3grNGZnNDY0ZGd0NHc1ZWNtVU9LaGds?=
 =?utf-8?B?YTNZY04rNGJrTG5LcC96VFlRc1pWemdwWTAyeHFmV1h4Mlc4L1p5ZHp5aHBr?=
 =?utf-8?B?SktEZkNzS2R6UVR2c2YxdWtDVDRCM3djMTBVSjFZYmluU09BOEREZ05Xb2ZN?=
 =?utf-8?B?V2hkbDAvcHkyakVFODJoUmN2aHc5ZVdJUG5HWGdmZ0dWdXNnME81bWhpRTNE?=
 =?utf-8?B?VXNPNm9iZk54c0psOUlUemNDZEFDZlJIVGY0YVh0WUU0Zzh1OFg0MXArbTVI?=
 =?utf-8?B?Qks3RmhDamxLNHBNVGhYOEFZS0hlWlc0L01tZG5GU0tabXJ6YmY0SVJiM0Z5?=
 =?utf-8?B?ZjJ1eHJ0elV0UVhFdmhaK1N3VGdoaWwzVHA3Y2V1WHF4R0ljbzk0N0hGR3hP?=
 =?utf-8?B?bUJzNDFsTmVCOFZ3MHYzTHl6c3dnK0k5aTFHeXZ6SGtQZUp3eUZQRjVFMXJU?=
 =?utf-8?B?WkpJWWxuS1Y3MUtKVkdxOCtmMFhBQjhLRDU0cUh2WUVlSElxM1ExOWQ1RXRo?=
 =?utf-8?B?N1FXdjRwK0JRa0VkMGMrWGhvUkt5MmVKMVNXK2lJTkY3WUpBSnRwZytaWFpT?=
 =?utf-8?B?YzQ2aTRPWnhFRXVldDAyUDhwLzllenA5TmlUU05sdUNvOEFEemR1UXFaOWNh?=
 =?utf-8?B?RW1oNkpNUWt4ak1RTFJ6dkZpeGtIV3JhcHNRTWkrYndLNHYvdkM2L2RQSkFZ?=
 =?utf-8?Q?Gvis=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73063996-1c87-4935-98d8-08dd9e02af1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:14:12.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeWqlriPV79O8ZOLsZCWIuin1s1aI6JgeH4WfqV4h7WhluSDrufT08pJ6z61iKex9+6GAadOjXQtYMNiAJrFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4283
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0MSBTYWx0ZWRfX2JJDW1kgy3QS
 ERSBy+MakktJ17GryQ/bUX47IaZfyUu21EtKktuTKzC5oTmfTJwH4HVEsBosQo1FYj7Ba0nGQ82
 Fjn0WWw2JN1FkxJ+cW3FaMCQxcu79JIixP6+DXJvmgDpCX90J8FE1rAfL8hznTaUwOZwAJ1paQa
 9xRsKvSWNnvLt6r5l/3iWLpDFv3qwxmpW1U2xq34PHEAx2Kf80hEmHs7FRr4AIiPuRGS0u3TYNc
 hKYzkJlm84NDF/sSZxctPfcuk2JwmoT8HjsdLEjkUSqXDYCvfoNxRbjnyRBJSp8epUgqSIINdWE
 H8bhgOFjPvzNZMSN5d9Zu7R2gf1wLMji0c/PxyHYY64rtHElF/PyuErPh4/dWZeAtdnuFyC6x73
 V7io4BZ28FDHnQXE98DPx6Pm3w4ictDDYKXrXwRKRiXd8+1J2Ltoe2xWq3RiQn/L3pftIl1D
X-Proofpoint-GUID: jnTmOeDDntpYU1lYofXt9BG2GkcBUyQx
X-Authority-Analysis: v=2.4 cv=fvzcZE4f c=1 sm=1 tr=0 ts=68373656 cx=c_pps
 a=f3W5XOz7tIKFJfa9Mwj+Sw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=t7CeM3EgAAAA:8 a=M5GUcnROAAAA:8
 a=L3mhinLd_5uxwKPFEr8A:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jnTmOeDDntpYU1lYofXt9BG2GkcBUyQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
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

PiBGcm9tOiBDaGFuZ3FpbmcgTGkgPGNoYW5ncWluZy5saUB3aW5kcml2ZXIuY29tPg0KPiANCj4g
VG8gc3VwcG9ydCBZMjAzOCBpc3N1ZSwgZm9yIDMyYml0IHN5c3RlbSwgLURfVElNRV9CSVRTPTY0
IGlzIHBhc3NlZCB0byBnY2MsIHN0cnVjdA0KPiB0aW1lc3BlYyB0aW1lLT50dl9zZWMgaXMgNjRi
aXQsIGJ1dCBzaXplX3QgaXMgMzJiaXRzLCBzbyBkcGRrIHdpbGwgY29tcGlsZSBmYWlsZWQNCj4g
d2l0aCBlcnJvcjoNCj4gIi4uL2dpdC9saWIvZXRoZGV2L2V0aGRldl90cmFjZS5oOiBJbiBmdW5j
dGlvbg0KPiAncnRlX2V0aF90cmFjZV90aW1lc3luY193cml0ZV90aW1lJzoNCj4gLi4vZ2l0L2xp
Yi9lYWwvaW5jbHVkZS9ydGVfY29tbW9uLmg6NDk4OjU1OiBlcnJvcjogc2l6ZSBvZiB1bm5hbWVk
IGFycmF5IGlzDQo+IG5lZ2F0aXZlDQo+ICAgNDk4IHwgI2RlZmluZSBSVEVfQlVJTERfQlVHX09O
KGNvbmRpdGlvbikgKCh2b2lkKXNpemVvZihjaGFyWzEgLQ0KPiAgICAgICAyKiEhKGNvbmRpdGlv
bildKSkiDQo+IA0KPiBBZGQgYSBuZXcgdHJhY2Vwb2ludCBmdW5jdGlvbiBmb3IgdHlwZSB0aW1l
X3QgdG8gZml4IHRoaXMgaXNzdWUNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW5ncWluZyBMaSA8
Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgbGliL2VhbC9jb21tb24vZWFs
X2NvbW1vbl90cmFjZV9jdGYuYyB8IDUgKysrKysNCj4gIGxpYi9lYWwvaW5jbHVkZS9ydGVfdHJh
Y2VfcG9pbnQuaCAgICAgfCA1ICsrKysrDQo+ICBsaWIvZXRoZGV2L2V0aGRldl90cmFjZS5oICAg
ICAgICAgICAgIHwgOCArKysrLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg0KQWNrZWQtYnk6IFN1bmlsIEt1bWFyIEtvcmkgPHNr
b3JpQG1hcnZlbGwuY29tPg0KDQo=
