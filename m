Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A69C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 05:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 279CB41109;
	Tue, 10 Jun 2025 07:02:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 67B1240276
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:02:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559NUvAf005971;
 Mon, 9 Jun 2025 22:02:08 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4769bn0jy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 22:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqrxqOsNUpwtWTvqSou7TKQmwnG8DK5XBwWyMbeLsPnpxOuSMfJeRq6XsjBPmYPBpbHNydakb/ndKYBFwMGtlkxg4hao277TQxdoak2qoJmUe6pZAft8OSaV9SujbOoZxU7RG4V8x5P1gVKc1hLGb1JdJh4mVd5coeUlOS9uumSPlI061MU41BiPPvF63ZaPLO0M5LcpT0NJqEdr3v7tz/wjnyrhSEan6e3SBjvUZldgeVWunjrZ6CfoCVJ2UvvEbVLToXzA6AQnWlyqdkTMXy70sfJVAh2jY0UzNbuXcQSiusOIwyF37zcKqyihme7vjkGZbij7a+o2LtwRKuUkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HThqyYXxPoK0q3SanchT8xgPxtZJEEnvn7lIo57bmBA=;
 b=oLVAjZx+xREAurQm6gHq6YiwG1rjTTiv9hBTf2qpCpIoG4kaZq/Dk/RSPM5vSOEp3ofYl1lFt656v8h5Ty+fq9UUpFn2h2ewDmkOlA+JbTzPF+b204OYTvfjQ48Rv+i3yfQhXrFodZNO6HqKqffziyZjiC1Rb/awhYBexxghBVKpK7oi6LtvzxFxUH8U5dOFiODmstuP/s5O+TKHllsqg3lT9DPkqeiP4kjnKmpWLJoXNpxzZbFqOvIE2MbyPyl9l4gljfSPDCmWf6Xos+MH+0zyVNXZ5r86Zp6eZlq+HR81aUH/5yyzg4eOLdhumj9u7IPN2ExtD6t15TsiWewDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HThqyYXxPoK0q3SanchT8xgPxtZJEEnvn7lIo57bmBA=;
 b=k2A9IiMwOtO62qVhYS2tRWQpSmsyVflBe+ho3usyzUFY9BLOVasVaGMISH738vtJsT7wEDDgXOBX+pqb0evc3EPXVtVy02CR75CGo4pA90b1ZgaLLQZiOtMhJT03o1t+ub2AEqhJsgLJy3ay/qlh/DMdfBof4ZvBJuskS05XWS0=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by BY3PR18MB4593.namprd18.prod.outlook.com (2603:10b6:a03:3c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 05:02:04 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8792.036; Tue, 10 Jun 2025
 05:02:04 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHb1sV4glZQDx84DkubxQo6XdgHSLP15I0AgABbtoCABZrpAA==
Date: Tue, 10 Jun 2025 05:02:04 +0000
Message-ID: <CO6PR18MB3860A0F5A75F34D2C76F1B58B46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250605113159.3035480-1-skori@marvell.com>
 <20250606092904.3145608-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
 <20250606082307.152616f3@hermes.local>
In-Reply-To: <20250606082307.152616f3@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|BY3PR18MB4593:EE_
x-ms-office365-filtering-correlation-id: 025cd626-820e-4098-2674-08dda7dbf125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWZEUEJiMzFzK1ZGN2lJQ01YRUJieUFuVkZDTVc3TXdnQUxrK3lKajJNdzhp?=
 =?utf-8?B?bzlqc1Fabm12RkpzUi83SHhuMVFQWGM4VDZ6OGwyaXdyMUdMb3NyNi9MNmkr?=
 =?utf-8?B?dU5MVk1ISTYzWXo2TU5kSWxDNjFKUUdqM1YyQnhtT3VhTmU2R0l2cTdJZ1Bh?=
 =?utf-8?B?ektWUnNwZVJiM2U4TXRXZERKZ0Q3a2VVQ0xGWkxGbjBETWNmS20zdzU5a01y?=
 =?utf-8?B?WDZqejNHSm02L1pjRTJWT0xnZXF3MVJycThoRnhkTkx3N2tqa25WOGRBQ1Yv?=
 =?utf-8?B?TWJIWEhTNUoxUEh0b3dtQmtCVUlDS04rdFpBVVAvMmRuMndyYmFEcUE4M2Ry?=
 =?utf-8?B?VnV6ZVA0SEJIODFjR0Jka2xqOFAwbmpwR0pOaGlUUW1McGdEeXVnZGd1dit3?=
 =?utf-8?B?VU1OOTlaMEJ3TXQyVEJITE5NNHpjUC9zWTd6Z3hVTW5JZ2lNMDV5a2JlcHgz?=
 =?utf-8?B?UW5HR0pYTkJEb0dFeVJZS2JYVzJ6N0wzamt0eWFTbWpSU2MxZTA4ZXN5cHRo?=
 =?utf-8?B?RWViYmFxSWhXNEplazN2TE1aYnFySVJwR2w2bkJ4OGxaMXBIbGNjUkRIVHZ6?=
 =?utf-8?B?bFZhVUhXWkZ3alljMEFSdzVjVnFsVFloSDBIdlJ5L0ltR0NlRnVvR0dGbmVB?=
 =?utf-8?B?UHdIc21Dd2QvV282aXdKbkJKeU9yZVBGRWt2V1d1c0UzSGpnYitkM1RwMWxL?=
 =?utf-8?B?OWV4Sm15UFQ3WDNNZ1dZZVF5aVY3bDBDNHVYMitvYzFNQVZrbWhsZkNEZEgz?=
 =?utf-8?B?TnlKOEIwMkszOTgxMFc2RWJvTjhjY0JkMW5tdHdyU24ySkJ2eW5tSzdMTklj?=
 =?utf-8?B?ZitMSTBhaGc1U2s0QUdLc0xkM1pQb0tTUFJFQk5LK20rLzVROEVZbWE1U0t4?=
 =?utf-8?B?aFdnejBEM1ZlRCtud3Y3MWtqMGhwQ2J3QUk5WEhWT202c0Z4WlJiWERNVWFr?=
 =?utf-8?B?cXJ1Z0JQMDdKVmNDTnMxamZIMDRLZnRzYThNbzN6d25IWlVkbXBJQnM1ZDQv?=
 =?utf-8?B?c1RTM0UzcWFCUFVyWHVRNDk2cVFWRWdEcnpkVlpRNmM2UTU5UG0walVRVmxS?=
 =?utf-8?B?YXg0eTNlbW9zM3ZGMEtORllLRERvdVFQQWdjM0UySndDd0dJTHdyZXlNemp1?=
 =?utf-8?B?VmlqeEcrSDJobmZSK0h1MXBOdy95M1pXbnJQZW0xVzdoWkdETmN1cE1wVXpr?=
 =?utf-8?B?RkJTMkJYSm43NnFCSEdWNTMrSEZkNm1EdWpaNzEzSEFDTlNFNlBqVTZCbzRD?=
 =?utf-8?B?VHJubDRLS2ZhaGM5Y3FMSFhJUnIxdEd0Rk10OGpqSXJSY3JabXMwTTNZMXRC?=
 =?utf-8?B?K21NOStGOVZFWm1MYzlsYm8ramFVYWlibkJQcXlxMHJZWjlITS9kNkpkcm5S?=
 =?utf-8?B?OFBUR0I2d1MwK1pKWXdrMHhxZm84NHd3VWpsWGwzOHMvSUZveWplc0EraTVD?=
 =?utf-8?B?Rkh5TFpyUGxtRGFuaG14WkVUdUFDVVdjVFpwZHYwVkFxSDFkbjQ4NUZDNmI5?=
 =?utf-8?B?MWF6QVJhUmtFaTU2amZlcDRFdXU4a21DeHpZQk9MYzFRbkdNY0REb3Q2bFlP?=
 =?utf-8?B?TW1xcGgveXk3dzZ0RitDTXNQWk9GUGdQSnh4cVJhRWlwRVRIUStGSVZuQnFo?=
 =?utf-8?B?dzFhWFpVTGxiM3pueEtaRi9wS3ZUZnhVYS91UlNLbUlISmQ4RnRQbVMyVHMx?=
 =?utf-8?B?U2g0YlFDZlpoc3pmcXVPSXFrWmR1a1FNZC9GbGVjQ0lpbWJaSnJ6d0k1cHlo?=
 =?utf-8?B?aldoVUhUZ3QzMGFnakExOG43NjRKV2JtbVVjaXR3Q2R5Vndnc2ZBOFZybG1k?=
 =?utf-8?B?bk4rMFdyOHFBa3dEeGl1NjJSSFpGelNMVmIrTTZ1cVVzenpuTTI1M0FLOXBN?=
 =?utf-8?B?eGYrN0xrbG15SHpONjVxVUl1N0dSbU9jczRta25XcS9yT0ZmOUlWNklZa3BO?=
 =?utf-8?B?Nmd2cng5WS9EVC9pVXJpc0FFYzQvVzNjUTZIT1Q5bkVld0NnaDJja3FYVFlB?=
 =?utf-8?Q?PmGZlIE+F+J06S7a4BFF6U0899XO48=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhpa2JQOVBLMlU4RmlkOXliS2JNMVk0MER0Slh4Y2Z4OTQxSTFwb2lXelVY?=
 =?utf-8?B?c1U4WVlSdTJiUE9YMit5WEhWQ1crYVdVWlA0V1UrMkhGTzQyVUE5eTFNR0cw?=
 =?utf-8?B?R0FGbjNvZGhrT3N0K0FRZFhxdkxRcjZMbHNndERrTVlqQ2Y2MEZUSTNZMWs0?=
 =?utf-8?B?akJYZ2w2RGhneEphb001RU1tekJMQ1lUTHh3bGNSTU12VHNmQUtyc21aeXZO?=
 =?utf-8?B?cHRaazE0dk9IUysyc01nUEpiYmU5WjM4eEhWeDQwQXhiMFV1K1hrQ0NaN2ZY?=
 =?utf-8?B?aXl2ZTZUMVU4K1Nuc3c5aWFtaUlrZkF2U0hwZU5UeHlGN0RjbW05R2FycVhO?=
 =?utf-8?B?SFJRS1l0NkdMNlRzcnp6S3AzaVBDMVBXTU54ZCtNVG95SHNxVytzNktjREYy?=
 =?utf-8?B?VFBpeXV2K2VNNXhxT095WmY3Vm9JYnlkakJxVWIrcVRhNk5XK2p6em1QQWxP?=
 =?utf-8?B?L29QTlV3ZVNoSHBvR0JGd1NFWVk0Tkh4YmF0NjBYZlNNVTd6R0VPbGRGSzBo?=
 =?utf-8?B?UlhoT0l1ak1wb1BmR0JweWtpYmFBVnhXZGhoVEk3SjJpclVYT3I0TGZJTmM4?=
 =?utf-8?B?eitGaTAwWmx0ZWZDUHQ3WjM4c3o4aFJYd2cvNHh0OGx1cmNuanh3dmVxOXlQ?=
 =?utf-8?B?RVNPUC81ZDhYcEY4VU5MUWZtQ2dzdDRWMnhmVUdCR3REeXgxY3J1T3hnRlJE?=
 =?utf-8?B?cXB5VmFyTENDQStvQjFQdyt4SlBqaFRERHVxMnlSeTFnTEZVL1dvbVJsb0E1?=
 =?utf-8?B?WC9hMDA5OVJzaDRaN2krNm1MYkxabjhQczhlc09IMjN5ayttdXhvNDliL2Vy?=
 =?utf-8?B?R1FrOHNlaXE0RWhSeEZRSHprME9BTVAxTnhMNzV0SjRMT0ZZb2FmN2xsMHAv?=
 =?utf-8?B?NGJQYnFPOE9XRklQZjdnY29xenRNUWJ5aXFyeFJweGlQN2ZkWGZQdFlKZUlU?=
 =?utf-8?B?dENGUk5kMjQzbzg1TmJVaWJ6QlpSRjBKZk0vYmoyWTRhZjZiSEc0VUp1T0Fz?=
 =?utf-8?B?UndQSEpIc3Q0RVlueXRzV1A3SmM4WXZlSnc0RFJacDIzMGM1WGJrNFZIbWpF?=
 =?utf-8?B?U1IrTVdzRENwcWZaNHFDcUdRZ2U2aXA0UjFEOGxZWUJCV2MyOHBpYlRtZDJ3?=
 =?utf-8?B?TFU2QzZyN0FxRTJ6NFlkVGU0RVRkQW5WTGhzWEU1RThUbitySVN0RU9sbTdC?=
 =?utf-8?B?M3VCdWVza1N1NVl1NFBUbjFKSmpaOHhIVjBPNEFFdjY1NVdBVWNkekhvbHBD?=
 =?utf-8?B?RVRuU0NzVlpJSmxnZW85K2x2MlFOT25PUExUeThqNEdaVWp3dVU2TFByeng1?=
 =?utf-8?B?T3FjSVBSVzl3OTlGY1BSTmVHeGljVFdsTVZDOGZPNW9zU0hoWFFSL3FTVVpF?=
 =?utf-8?B?L1JyWk1DRThXWVQ1bHVrblZJb2VGTjd2c3NpT21OUkxoZHprWEI2SEJFNDNH?=
 =?utf-8?B?bndWR1ppeS9TZktYOGZQY3AyTUo2S0hZdUt5QzMvdWJ0RGkrL2M3bU0vVEw3?=
 =?utf-8?B?aXFnQzZhQWxyaTZkV3lOdGpYcThnMzJETGVHWkZXODVMcE5maTE1WkVMRFhF?=
 =?utf-8?B?aGE1WXFseDN3WmdDUXlrVWRxMVMyVk8wOEo5aW5PTVlCNUZxc0xzdlRiTXFv?=
 =?utf-8?B?cnNndlRZam10N0ZaVFY1K2g3U1Vrd3hvZTlaNURzRXZHSHd6TFFrOUlkOEov?=
 =?utf-8?B?OGhUMnpkSzhqTldSVksrSmtFSk14YXV1bDFsbFRPME9idTVFeW9WT3FldVQ0?=
 =?utf-8?B?VE5Kcy81a1gzVzNGM1RraXdVYStsUG5rRVU5TXNWZlFIdDBmSEpCYWhxalZB?=
 =?utf-8?B?VHBicExBbm01WkNGcVhoOXpYb012VUd0VkVMcjJXVnVJTTFHcTFKazNSc1NP?=
 =?utf-8?B?SnYvM3VUaGNNeGROdFZpalh3UGtqNU92WlhRbzMzRlJTRjRwS1NEYWhUclN5?=
 =?utf-8?B?dzJ1VmZVRHozN3FPd0hPY294Y2dHdDB3ZUhiRDc0VXY2aW9QeXoyWU9NTEY1?=
 =?utf-8?B?OGJNZjVkeGJTRlNocmhuRnY4VGxvajhveCtZRCtiRkpEZkZ2YWlQTVAxVjBT?=
 =?utf-8?B?WCthOFNuTzF1eC82clhEMTduaHpYeTdWNXVRcTdITmIyRWZDVU1YNmRRaDFx?=
 =?utf-8?Q?pZCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025cd626-820e-4098-2674-08dda7dbf125
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 05:02:04.1802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l8NBQtkcEMmQQQC4hoXqXshcEKzcQYcHknDWwWGLU0DzSkpJEp2gMfFFS3wvBn42i0Bd+dz+lp9tfwRhMGjOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4593
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAzNiBTYWx0ZWRfX9U6KnpgFmrzc
 uEIslM5n2lXOCC+U7fW1EQiY9w5o1SuhDF5p6J690onjAW106FId9MceHmFv/sjrgokm+S/IHq9
 /r7eYmRAkk7wcY+Q4kH4k+qDG8nGOto+/rRGGg64n/SAPDytJ0IF/W3ZU57/y8We7Q9OO6Wxo3+
 Kevh792E2BQGnlItUreqd+DKpP8yIMUXqdwA0VJoD+5dap/P7lqD4oATZsvRC3n1E8FkL2mvIWb
 2vcbxH1+YrUf+lDbrrH8rA7sZxmgnTevpop2kZ8TmqUiuNQB9ZRph6MbKK0UY73dhI1BuKWkuUS
 ry7x1YR+ciHizum5rzhgegUA38DgOMef6T4B0Jc+JRjro3ky6IUVTsLRpFr8KwRtnKSJjW5i+8N
 E9r4BxRK9R6/+J+MYfGptq2hauxgF6wqsgchvgJh/kJvjaYkEpuzd88kqHQans7O4/dvChKf
X-Proofpoint-ORIG-GUID: SXzyy6ax_23Ir84CCc_q9wqOVWtEOq9b
X-Proofpoint-GUID: SXzyy6ax_23Ir84CCc_q9wqOVWtEOq9b
X-Authority-Analysis: v=2.4 cv=ZuDtK87G c=1 sm=1 tr=0 ts=6847bc50 cx=c_pps
 a=SfKpAED18FmY9QLmYdbp3w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=n02bokGJAAAA:8 a=M5GUcnROAAAA:8
 a=23m69Xs0v2KOryieblMA:9 a=QEXdDO2ut3YA:10 a=rszdq1ld3peujIA30KyE:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_01,2025-06-09_02,2025-03-28_01
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

PiBPbiBGcmksIDYgSnVuIDIwMjUgMTE6NTQ6NTIgKzAyMDANCj4gTW9ydGVuIEJyw7hydXAgPG1i
QHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gRnJvbTogc2tvcmlAbWFy
dmVsbC5jb20gW21haWx0bzpza29yaUBtYXJ2ZWxsLmNvbV0NCj4gPiA+IFNlbnQ6IEZyaWRheSwg
NiBKdW5lIDIwMjUgMTEuMjgNCj4gPiA+DQo+ID4gPiBGcm9tOiBTdW5pbCBLdW1hciBLb3JpIDxz
a29yaUBtYXJ2ZWxsLmNvbT4NCj4gPiA+DQo+ID4gPiBBZGRpbmcgbGluayB0eXBlIHBhcmFtZXRl
ciB0byBwcm92aWRlIHRoZSB0eXBlIG9mIHBvcnQgbGlrZSB0d2lzdGVkDQo+ID4gPiBwYWlyLCBm
aWJyZSBldGMuDQo+ID4gPg0KPiA+ID4gQWxzbyBhZGRlZCBhbiBBUEkgdG8gY29udmVydCB0aGUg
UlRFX0VUSF9MSU5LX1RZUEVfWFhYIHRvIGEgcmVhZGFibGUNCj4gPiA+IHN0cmluZy4NCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRoaW4gRGFiaWxwdXJhbSA8bmRhYmlscHVyYW1AbWFy
dmVsbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdW5pbCBLdW1hciBLb3JpIDxza29yaUBt
YXJ2ZWxsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gKy8qKkB7QG5hbWUgUE9SVCB0eXBlDQo+ID4g
PiArICogRXRoZXJuZXQgcG9ydCB0eXBlDQo+ID4gPiArICovDQo+ID4gPiArI2RlZmluZSBSVEVf
RVRIX0xJTktfVFlQRV9OT05FICAweDAwIC8qKjwgTm90IGRlZmluZWQgKi8NCj4gPiA+ICsjZGVm
aW5lIFJURV9FVEhfTElOS19UWVBFX1RQICAgIDB4MDEgLyoqPCBUd2lzdGVkIFBhaXIgKi8NCj4g
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX0FVSSAgIDB4MDIgLyoqPCBBdHRhY2htZW50
IFVuaXQgSW50ZXJmYWNlICovDQo+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9NSUkg
ICAweDAzIC8qKjwgTWVkaWEgSW5kZXBlbmRlbnQgSW50ZXJmYWNlDQo+ID4gPiAqLw0KPiA+ID4g
KyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfRklCUkUgMHgwNCAvKio8IEZpYnJlICovDQo+ID4g
PiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9CTkMgICAweDA1IC8qKjwgQk5DICovDQo+ID4g
PiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9EQSAgICAweDA2IC8qKjwgRGlyZWN0IEF0dGFj
aCBjb3BwZXIgKi8NCj4gPiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX09USEVSIDB4MUYg
LyoqPCBPdGhlciB0eXBlICovIC8qKkB9Ki8NCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIHRoZSB1c2Ug
Y2FzZSBmb3IgdGhpcyBwYXRjaCwgd2hlbiBvbmx5IGFuY2llbnQgaW50ZXJmYWNlIHR5cGVzIGFy
ZQ0KPiBkZWZpbmVkLg0KPiA+IEhvdyBhYm91dCBSTUlJLCBHTUlJLCBSR01JSSwgWEdNSUksIFhB
VUksIFhBVUk0LCBDQVVJNCwgU0ZQLCBTRlArLCBTRlAyOCwgZXRjLg0KPiA+DQo+ID4gUGxlYXNl
IGRvbid0IGJsaW5kbHkgcG9ydCBzdHVmZiBmcm9tIExpbnV4IHRvIERQREsuDQo+ID4NCj4gPg0K
PiANCj4gQWdyZWUgd2l0aCBNb3J0ZW4gaGVyZS4NCj4gUGx1cywgaXQgaXNuJ3QgcmVhbGx5IG11
Y2ggdXNlIHRvIHVzZXIgdW5sZXNzIGFsbCBkcml2ZXJzIHJlcG9ydCBpdC4NCj4gQWxzbywgaXQg
YnJlYWtzIEFCSSAoc2VlIGJ1aWxkIGZhaWx1cmVzKS4NCg0KQWdyZWVkLiBJIHdpbGwgdHJ5IHRv
IG1ha2UgdGhpcyBpbXBsZW1lbnRhdGlvbiBtb3JlIHVzZWZ1bCBhbmQgd2lsbCBzaGFyZSBuZXh0
IHZlcnNpb24gYWZ0ZXIgaGFuZGxpbmcgdGhlIHN1Z2dlc3Rpb25zLg0KVGhhbmtzLg0K
