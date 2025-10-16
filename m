Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABDCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BFCB40B99;
	Thu, 16 Oct 2025 12:15:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2C52B40269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:15:46 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G4dmua023636;
 Thu, 16 Oct 2025 03:15:45 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022138.outbound.protection.outlook.com
 [40.93.195.138])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49t5pfbkm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 03:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD4jmm+skaex60lD2KurayOEEWV1yqI2ilO+xeDcLmXWB0tlRkJh8Gnc0x2xIknBlSoqyfpLOLxR/dp3kz56sbNyqEaz5ZB4Ek+BVMOXhobSTdWTW3/p9kC3/ZgsUnXNaMva+nBDZaHSMNl7G+IPJSx7qyzoAkCT8eeoreHbMv5ScHYHq3V4zNJ1IumVUnLiFm9/LVcA+QOg37zGPucuL3E1OhePnU1WmTt81BGIBEeulEBP54Q63p/W5KdoWoRMpVD36R8j0wxJSuczvOW5BQhqqaAjHA+Sn5taJiZI3tgKRZS1BXHOKWwM+7XZtgOe6ONYdoQRqgIsZMOKdjprGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AyrogY65BHLPjJOMecNsypOi1GtkIFknoMpp7NqAFo=;
 b=cVW8m96ghLEYtn6ylE1/+vJTi2UB9rMm9r6I3U+pwC8w6y666IzNTKPLsJbYNakU193xf5i3piK5za/0gir/ddbRXVVsSIkeDbhF5lT6BAP5n7Vdkg8xRXkQAr8DaychFAOB/lWypQF+qhsSrTqLSr4KWjbcVyH6zzs9RNHoF4X4CVUsdDClwxFis2WSUYjMB+gmMYAB49Y5TDdomHgJzftpYkI2W8eM2D5/2OLFUKP+G7O7TO+O37wWmdq2VSc8TEt7glNKY2O4UYo0MyRjMB5ZFkKgSFvP0DcSdmqIPniHyhjNCe/JX6PUb8oG180U8IzknNt16RH9dcjQBrWipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AyrogY65BHLPjJOMecNsypOi1GtkIFknoMpp7NqAFo=;
 b=pJDQFoyJgu/3a9d39+bEuGvmof2Ap3U4/uDb1JwK0QjAV+7uKcUpQuVVzvsrg2AD4qeYioMCFV6WVZ5Ktjy2ckXcFZdB3RbAlh3c/aBhDSgTmWH4GnGHhONh3MHB6KB1yP9ug4NJ/rnfEmVA9ZPXY5bFUVZ4LmyPcPUGYKKQ1c4=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SA1PR18MB4535.namprd18.prod.outlook.com
 (2603:10b6:806:1e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:15:38 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 10:15:38 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/1] lib/dma: introduce inter-process
 and inter-OS DMA
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/1] lib/dma: introduce inter-process
 and inter-OS DMA
Thread-Index: AQHcO/jqvlmQ/crgZEW7br3BZMn4k7TDecAAgAEZsBA=
Date: Thu, 16 Oct 2025 10:15:37 +0000
Message-ID: <SJ4PPFEA6F74CA2F27747D240779B493299A6E9A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <--in-reply-to=20251010144631.713063-1-vattunuru@marvell.com>
 <20251013042136.1727540-1-vattunuru@marvell.com>
 <20251015102622.4d519c2b@hermes.local>
In-Reply-To: <20251015102622.4d519c2b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SA1PR18MB4535:EE_
x-ms-office365-filtering-correlation-id: abb4b62b-c7e3-4b0e-a61a-08de0c9cf3f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UWdoZUE4akVZZUE5bzZHbHJhN0dpbW9Uc21yZ2VsK0dMbVZxRmdqUGhWeGY4?=
 =?utf-8?B?eUFRMHdQN3BBSnBDd1VyU0F2ai8zNGcrWnFUckRYeDZXZmR4d2xLZTFHUmhi?=
 =?utf-8?B?Z1pvNjZmWTZMa2pvRTNtb0NRWjc4by9ZemZKYWlUc2Q3LzdKbG5rL0VZWXpC?=
 =?utf-8?B?Rm9IRmtoZm8vaEMrUUZtamRHTXhacE9kTkxUTlUwUUE4d2FyNFM1a1dCZ1l3?=
 =?utf-8?B?TURQSHFFdC91TWxlNFBaTGhFc2EyMHZxaVZ2UU1DNlJmZVM1RHhzM1FjbEFj?=
 =?utf-8?B?N2pMb2tublM4YWJFYTN2cG1MaTUwVmpzeDcwc1RCMXd2a0drU0hPOFFWQ3pG?=
 =?utf-8?B?YlExZWNFQ1VSL1g0NXhCM2dObHVjZXJ3bEcwa2JQS0lycHRSL1IwVmx1dk1J?=
 =?utf-8?B?bkowRHUxTjl2Nld4RUFtSGtvdGxFNFNnSUxwWVJkVjdCZ0RiMENUYTEyYldW?=
 =?utf-8?B?MmgvWmtmampzYmtJeE8ybVE1UWRIYThhNk9tUU9ab1cvWi9JY2YzYWUybVpj?=
 =?utf-8?B?dHZmZUxjUXlVSEcvZ1d0Tk9OVVpRT1laTnlud1pJWVVkd2RGdXZtcEF0ajUv?=
 =?utf-8?B?c1FzZDN0c3g5OTJnNFVBQ2hRN1FISE1QZWIwMyswZmRzVTIzVHdPakZ3cHZP?=
 =?utf-8?B?WW8zdVBFNkJmNXd1elQ4bGVKeWhyRk1VV01OWlJjK2ZCcndaNFRhNE5EZHJO?=
 =?utf-8?B?OXkzbUFnNS9OcC9mRitxRjFybmg0bVJZaVgyK0ZyNTY4RldIaVRuR3dEc0xH?=
 =?utf-8?B?TmptK21EOUI5MHFXNTZ4VE8yOW1JWlJzanFrR084cEFOMko3V01ES0pmV3dO?=
 =?utf-8?B?Q29wNGRQdm8vZmE5NDQ3bFRoQktVWjVtS3RIaUIybzZ0Rm4vWTNWb3RqZ0RM?=
 =?utf-8?B?RXAwY0FFRk9oMkhjRmJrdTBxb1BuMVNQZnEwUGptREpVYnRCVUJlbEZQVEpL?=
 =?utf-8?B?YUZxTU05Yk5QbEYzMXlaNWhndWdLdlEwanVYMGFlRkFjQk1mS043czltbzky?=
 =?utf-8?B?RCtGaVpEOVNOUHBEZGNYaWdBQ2JmbXV3TlRka3dpcEp6b0M2U2ZDSUZ0dWVl?=
 =?utf-8?B?OTlKRG44aWN2OVB5Yi9FeEZhVndtZnZJVkJUOE5qcWMwYzAwWDZ2a2I2WnNI?=
 =?utf-8?B?THYzcGJsSnVveG5kWmZCZGRBa3d2ZGYzanZFMGVZdEt3emtyaDBBMUVjTm1D?=
 =?utf-8?B?SFIvditpNHp0S0JIZC8wNDM4QXZvQXMvWGkvRFRqL1NqNVBHVzlGS2MwZW1N?=
 =?utf-8?B?SUY1dTdndkFINkR3YU53U00wcmxjQlpZd3FRZlNrdXhIMjRuNjI5V2x4dU0r?=
 =?utf-8?B?VzZ4MG5sWnVZbWMxbGYwZjFsdmRqWXNKM0FiRjVQNXVVUWMxdnUxWmpob0Nz?=
 =?utf-8?B?SlVmL0JEbVE5bTFvZFBEVUhpdU11a0pWTzNNRlU5NEZPNHNIUWcxcERGTlU4?=
 =?utf-8?B?NWtmTVdBNkoyK2phd1k0dGhxbm9VdW41bXVId3F4Zk9zTzJnT1JnOXZMcVpL?=
 =?utf-8?B?ZkhkdzZXOXdNL1VFOUhrd0RuYWxEbTIyTlo1L0NSWThRd2tRYmlRMGZsK0FD?=
 =?utf-8?B?c0dtbmxFTHRDc1JTbVdCK0VtZnJYb0thTTdhNytLYkk3YjFCZDYxQWlNYlc0?=
 =?utf-8?B?MVFFYThWSnRZVkdMR1lqMllWT284MmF4NWJLbVZpN2NMK2xPUkcxQ3lWMjJM?=
 =?utf-8?B?SXZsUCs0bkFwODdEd005SnIyZ0hBY0hQb0VWcFRLa2ttVUxYUVQvbm1UNUc3?=
 =?utf-8?B?V3ozbllVMktBQks3dHZGdS95QXVPT3BDZUJ2clVEUDJvcUJmejVCZ0d2VFox?=
 =?utf-8?B?WVI3VWpYNWxBeDJ3MS9EdDltUkJta2RXcHRCMmNUV3VPZUJqMkNBbHJYS0h0?=
 =?utf-8?B?OVJXQnlDM0N1d1pKaDdzeGJjanU0WDlEWjA0TUFIZVdiYnloTkZ6S3NYZlpO?=
 =?utf-8?B?UzB3ek1nMDBZWURhME00MlJQaTVKN1drM2R5Q2JZRlU3VmtWOFh5MzlYRk1H?=
 =?utf-8?B?T1hXNmgzZVBFeEM2a1ZIK0FybG5XUDlqTDZPcGhWUkVKUW96UFkwcEY3bHdi?=
 =?utf-8?Q?mS+lwo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZFVFFWT0lzYTQrTUpJK3hndGFBU1Zlb3NjT1pSWndvY3BCMzZMdUZCSWdv?=
 =?utf-8?B?d2UvYzd2SWx6R0tMazd1dDJFZEZnWXFmK2dTOXdSdFlMaGd6TGpzVDBBNUFT?=
 =?utf-8?B?eTI5bjM1TmhUd2dLRzVSUVNQVGlMclZyOXlvZkM0bjdGakNUaUx0aEdmQWpP?=
 =?utf-8?B?RFVZbkZaSHJOb09yU3lkYjZBN2FsUXE4cDNyRUhpaGE2Q3M0TDhvMit2UTIx?=
 =?utf-8?B?eng3WUhpa2FtQUhOaHNoYlllenpqT3QwOW5venBQaGRCMVZpRXNnbTk2WFpZ?=
 =?utf-8?B?bmdCUjVaUU84bmJ3aTY4ckpEMlozLzQ4ZlA3RFhhYkRsYUJVOU9Hb25UUjNy?=
 =?utf-8?B?QjJrS3J4b2M3cWlZS09MRlJ5ZHVZNlExbU5GWWRPeGp5M0dpZ1IwcFBYV3N1?=
 =?utf-8?B?eUNFR0pWT09DRjhrN0JESnFFRjlwTXZzYWxPbUpJZTlCUnI3d3dYRFV5Qnoz?=
 =?utf-8?B?eEtOSGtoVysxeUoxK3RkS2tZYWdHNy9OVlYrcDdCdHk1Q1JrQWhObHg5ck5S?=
 =?utf-8?B?NTh4T2JWeTF2djkrM21aMExkUXBXdzBHbmtQcFdsazVRSkhxMXpteVd6eEpM?=
 =?utf-8?B?anN4VHBpOWU3RCsveThzTHRZR1YxSkdIckZPT2d1ZlNCdHpLVGJhZXd0VHRN?=
 =?utf-8?B?bUp4UUdQMHhwdi9UTkEwY0hkRzQ0N3VqU3NqbGtrU3dYd01kM2NXWUJJUmZE?=
 =?utf-8?B?Y0IvaFZRM2RiRG0yVnZvVFBFWmlLVm5aajJwOU1PRDFqSURnOWNDMDVvbDdV?=
 =?utf-8?B?TmxhdzFoVlRWakk0RlhNSTZzS1UzUnFzV3NVMmlITG9EQlY0SUZGTk0zWnVS?=
 =?utf-8?B?bC9MZFFCQTgvSkxGbUh1NDY0Qzdua0pGRElGUThwWFd6Zk9pQ1ZCV1BSVnBk?=
 =?utf-8?B?eTdlczl1bEM1YzdNV2l4Z251b2VkNzl3am5kWEsza2dQMVV2dk1XalFMWnBR?=
 =?utf-8?B?VjJ2ejd1ZURZOWNBbjIxNk5nM1MrMnZ0OFU1REx4bzl3Y296OHBPdlBDNDFP?=
 =?utf-8?B?NEdKWERzbFVwN3I3Z2thVXJuNWlmN3RxMVd5WnZQK0VOb3hJNVVPWVp3dnhz?=
 =?utf-8?B?ampVQ3NPUXlmYzBhZ0RTcktPNk1jZWZVbHNBVnNRNFZCVUw5NjQ2anU3cHNT?=
 =?utf-8?B?Q0VrYVZuby9YWjBFVnQ2cFpRNjNRWXlTWFAwNm1NdTk5TkV4RXRXSEdIK3R6?=
 =?utf-8?B?UkFkSXQ4ZWRtMk40VStNcno5THpqTE1QRGZ0Q0lqdm1sSlpFRHRGdFpCekxa?=
 =?utf-8?B?ZGU5dFNNdld6KzJZckxLRTZmQWZlOUlTczlmbFkzcGVaQ3JZZ3ZXM0toaWJR?=
 =?utf-8?B?akhMaTFlb3VXZytaU2VRTVE5K25WT2RmMUNXbmR4M3RVQnE2RWxEU3pBN0RR?=
 =?utf-8?B?MmszTzJTa1NtZXNuMTNFcm81dFBhRmoyNDFPWjRKTjdQMTBWdHR5bXdBc25i?=
 =?utf-8?B?WHZUdnlyZW5vc3BDZjUxd3hVUkhFcjZNWHRwb01TY3NObFN0bXVTU0lpVkVX?=
 =?utf-8?B?OGxPTDFka21hMUdEZkFUdHc2akVSbEdYeHJmcGlmS25laWtSMko5ZVlLQTlF?=
 =?utf-8?B?ZlVLSEYrMVp4c1ovWEc4b2hTS2tOa25XWThvK0JDR1FML200UFJmNGQ1dWFR?=
 =?utf-8?B?dkNtelB6YVZsZWpBZE84STdZR1E2d3lIeWNOMHhHWnlKUXNPaFBYYkpGUWJy?=
 =?utf-8?B?U2Y2ZVRNTXA4WktqZEE0UXFXWEpYclBlOTFUKyswNW5Fb2JaVHhWMXFQaEtt?=
 =?utf-8?B?WlgwdFJzVU5zTUx1c00yc1VXc0dRckxEWVJCZU05YVliZzRIQkFJL2tZTUtm?=
 =?utf-8?B?SFhlaVkvU0VnY1hyTitYelZpcDBPU0ZmUHVFeTEzOStWNHllYTkvQnlQRm10?=
 =?utf-8?B?bFhxcXU0SmdvTzlaalV2WGk3cHgrQ1UwMG5RYzh3Qk5vMzBiSWtWUjBPZmlp?=
 =?utf-8?B?NGhtc01ydjcrSDFTaW9OUUJ6aVFTRUtPWEd1djhONGRrS3RpT3I1dGxVN1RN?=
 =?utf-8?B?RkMxMC9vWnhQNTJjT21wY3p0Q25heDJVUFkvYURGcUpSZU01ZVNIQTAyWmkr?=
 =?utf-8?B?NjYwbUZlZFpIbFlGaGQ4VU9SRG5HTWNUVGtQUE9ieE90MUJWMlFqYlNqOGwr?=
 =?utf-8?Q?w6G+ZUEHIiaG1U5Gt7es+1R7I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb4b62b-c7e3-4b0e-a61a-08de0c9cf3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 10:15:38.0457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GumwTQYZKBjbuLdB44yB7aRIBTv5nmAbWve/Nk2kxYZM+oWh4gwb5cFQUK2youeT0kjUzCrXs+fSWPsA5TWCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4535
X-Proofpoint-GUID: 4tifD9Dwfhi8q5kHBM7yYX8kvuP73Ufk
X-Proofpoint-ORIG-GUID: 4tifD9Dwfhi8q5kHBM7yYX8kvuP73Ufk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA0MCBTYWx0ZWRfXwnPC4BzMdIbO
 Anxe9oRRvpjQViXK+ZlXOwrxu4n777YKXI6+mTK7nto1Y2PeR9lUZAjg8Q/u22fJxPvcMR62Ggo
 GtzlI6aEcVdgBp6CDrzxFnSMAkCs0l7IA3JBPH3U8WIO7elp6ZRHmI4vfNGbiMoqt1DFhTUZkVU
 KLtuEYbKD9dW63PtzhqCA+gCMmX0VOGXw4fxhN5pKfP8PJxrkZhrxrtM4LxxekPJkVs3rdYI134
 qD12c3Df9i4vlGQATPEdhS4zZIa7MIYeuV10vrpWRS80GZ9UMsFZn7kfJcnvV6gevsd05zzu+6K
 c0CzygGdW6HQoIb9RCbU8nL+9rgq3xJtmX1WmzuxZuEXhlkQZC9s9060ylqmJUBLx4FnpNjhTBP
 +usjefwx56sJ/9AXiMDQJn+XC7eeQQ==
X-Authority-Analysis: v=2.4 cv=Juj8bc4C c=1 sm=1 tr=0 ts=68f0c5cc cx=c_pps
 a=ZVJWEtTsqHd5Y1/ROadkLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=EjgFOKtqESmxg3CQ1l4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
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

DQo+WmpRY21RUllGcGZwdEJhbm5lckVuZA0KPk9uIE1vbiwgMTMgT2N0IDIwMjUgMDk6NTE6MzYg
KzA1MzANCj5WYW1zaSBLcmlzaG5hIDx2YXR0dW51cnVAbWFydmVsbC5jb20+IHdyb3RlOg0KPg0K
Pj4gK3N0cnVjdCBydGVfZG1hX2ludGVyX2RvbWFpbl9wYXJhbSB7DQo+PiArCWVudW0gcnRlX2Rt
YV9pbnRlcl9kb21haW5fdHlwZSB0eXBlOyAvKio8IFR5cGUgb2YgaW50ZXItZG9tYWluLg0KPiov
DQo+PiArCXVpbnQxNl90IHNyY19oYW5kbGVyOyAvKio8IFNvdXJjZSBkb21haW4gaGFuZGxlciBp
ZGVudGlmaWVyLiAqLw0KPj4gKwl1aW50MTZfdCBkc3RfaGFuZGxlcjsgLyoqPCBEZXN0aW5hdGlv
biBkb21haW4gaGFuZGxlciBpZGVudGlmaWVyLiAqLw0KPj4gKwl1aW50NjRfdCByZXNlcnZlZFsy
XTsgLyoqPCBSZXNlcnZlZCBmb3IgZnV0dXJlIGZpZWxkcy4gKi8gfTsNCj4NCj5JZiB5b3UgaGF2
ZSByZXNlcnZlZCBmaWVsZHMgaW4gQVBJLCBuZWVkIHRvIHZhbGlkYXRlIHRoZXkgYXJlIHplcm8g
Zm9yIGZ1dHVyZQ0KPmNvbXBhdGliaWxpdHkuDQoJDQpBY2ssIHdpbGwgYWRkIGl0IGluIG5leHQg
dmVyc2lvbi4gVGhhbmtzLg0K
