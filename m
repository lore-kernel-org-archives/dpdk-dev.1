Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CBD2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4429C40268;
	Tue, 20 Jan 2026 12:00:54 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18]) by mails.dpdk.org (Postfix) with ESMTP id 594914013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:00:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksTme+kjndcF47tEyiVZwt6jra2N5hppCZxDERkqP1l1S3JoENJspZ7UMUI7MHqg2wdOdlCbz0k9AyR4H6xwBxmM6X+TwpDvjYp1KJuGdevtjYGRCEqQ9dk/ja6JUwxwEnLlXqFQBGlKV20eiOkitrO+wJ7mrDrc2PyANLG76LWi2sBvH6pjPm9N1vJYmp0p9YtDHshD5sLVr95rrX0T8XDqAlePe0omaFmhMs5hRT23+1FGnupSMmIGd6KU5BRQfKsNMf6xeOAHWSf1LQ/ONEgDsB0o0HqBuONWHcEvsE2+eufyXhtOVqkwpHzru93RBGr85ysy7BqGwHWdixhARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL4qICP612KXdsQ5Cx9oheYTzDz5WMPC+OS/7KUvjjg=;
 b=FEimnG7T3dNaUL992rRanJewInmZ/kK789vbrKjJjj6tm9sRpuwryGg2k2TxPJgXkWCMwF8XY+2Nqa6WHyPiVYW5LNRjdIgN8kjo5aAC16WP5895pFCM8xClZfJieYO8IKEcs7rXzG46V3Jh1zijZmSCxdYVL7qlWMr/YGT9V6FpD9BW1V7wz4TMKKIRKcmkoH2T748LBrw7gb/cx1YLRziOZMv9T+AkHCX1mKfPmjzajM/P1eUW7Pqagy7wFRUl5Ajm0k9XEEN4xQZKhRRUdsiLVPYnTpmoiCaLJMB9dPZkzn/H1aF1WzxpbfWZo8uHEaF0AhilgOBPlBzgRAL+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL4qICP612KXdsQ5Cx9oheYTzDz5WMPC+OS/7KUvjjg=;
 b=vC4u942Ji4noZtEG2p8Y58wyjmFw60a8J6nrtz7XF3UQrDiqzHJRrKpR0raGVHZFbW4M0iNJDR5k3TYg23WCVF/EO2J2iNM1vo4l9gZYjnN4rri9TPnDZ+8r6VZ12q16ooy30yDbCWnU0pb2mXHBYXO5nLnT62oallgwUlbU00o=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 11:00:48 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:00:48 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgA=
Date: Tue, 20 Jan 2026 11:00:48 +0000
Message-ID: <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
In-Reply-To: <20260113151943.31c58217@phoenix.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: mb@smartsharesystems.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-20T10:49:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: 8b4ed93e-dadf-4e48-4e68-08de58132b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SWNlczQ1MGxzOGI3SUY3cGZIQTRrOW9ScWRRdlpwRy90Y0ZnZzMzUDRVVzRI?=
 =?utf-8?B?WlFaSGlVNlVwUUoxVGxJNUhRYzU0SFowK3ZITkFIaDhjOU53Y1dDaTVwTTk3?=
 =?utf-8?B?TDNJR1ZiWmxYT0RycEtoSTlER1N1Z2FCM0w4SnV5Ry9RYTRjMlpuNWFpSkVC?=
 =?utf-8?B?cDlUSEpDVjJWSjgzdFRpMUJIYkJ2VFhlWVY1Y1AzR05lN1dLc0RqalN6U21J?=
 =?utf-8?B?aHVuc1RQUGI3MEJlRHErT1hDOFNxZUJnYWxZVldpMVVLNDIwZHVzSXJYaDJR?=
 =?utf-8?B?S0dQNXZKMVlVMEs1Y0RtZkw2c2JxNkF0dHVpUXJOVnBkSlFaaFhCUEJ3ZWc4?=
 =?utf-8?B?SG5PcjV2RVF4c0p1MFMyWEpINWdjVVd6ZkE4NTc2OHdOUnlpTXdEZUc4UDMx?=
 =?utf-8?B?cDNTNGV0WktsNmkwdFF3ZjlHckZWaGpnc0V2OTJDcnRZZ2RBKzhKVnpOK2Fi?=
 =?utf-8?B?VXNtTEJUOTJJTjV2V3k3emZGK25lMElOWUNlWENOK2lrNmM2Tis5eFNtVnVB?=
 =?utf-8?B?MkNITnhDL01NajBZaGExVU9EVmtjMEQ4ZDhWUmpqRHU4bzlKeUJuSjAxMmo4?=
 =?utf-8?B?UGlza3U5cTZyT2wwYWtqSXZCNXRodHVKLzdBZzVjdmVXMFRTMXRyQXRvSExX?=
 =?utf-8?B?Mlp3dGZHK0tDNXhST0NaV2NQWTY4cENZUTFJTW9ra0Y5aHlhNEE1bVEranhX?=
 =?utf-8?B?bVozaEZMSG11bXdIT040ZWp0ZXVrRjZSNUNIMzBPdDNEWnQ1QkE3R1Y4OHV0?=
 =?utf-8?B?UTlEbnZmbUdxR2dPQnRmb2xLaTU0Ymt1OU5tRGJ3QU14TnZkcmFIZHRGVldV?=
 =?utf-8?B?S2FrVm5tajZMZTNILzdPd3dOckNJbXdyaDJKVTdvdWM5akhaREN3cE1zMlpq?=
 =?utf-8?B?ZDNYK2xRMGxYYURjTXpWbmN0QU42Z0JPNWd1SXR5R2J6SHZVeG1heFJ5UnFk?=
 =?utf-8?B?aGIzYVVGN0RQWmNJaHp6SS9oUEVsVkorM000aUFYRytJamNac3U1b3R3dWlZ?=
 =?utf-8?B?TEZ6ZldNTGZ1elBnQ2N1cGRFZnFjTzZkaVRUYkNlRk5rRGdVMExPS2RVTk9y?=
 =?utf-8?B?UXh4dlRsdmpaMytGSTJ4cXc4VzZXSnIyWmhDY0xrMktFc3F0aGR1UE9aTVJN?=
 =?utf-8?B?aGNoa2tiSmx0R3BMUFhyVGhvbG8xaWVqS0VtQWxjZDYzOGVvbTNscmJPOEMy?=
 =?utf-8?B?VExzN09DVVEwYXdlekhzb3gwcXFEa0s0QWtENXprb29mTzF3R2dsMkxRblRU?=
 =?utf-8?B?U1V6clFrNnZ4RWZnTDN5ZW45djdYa25YWWFrVG5pUnZTSVNPdEliTktiT2Fn?=
 =?utf-8?B?bmY1NWd6S082Qkd3Qm9VOHd5UFl3NE9NazZMVUZwNVdSR2NCQU84MlIvT2Ex?=
 =?utf-8?B?Q2d3cmRKQ3lkdUFTUXpOeTBIcjFoOUJDdjRTTm5pNnFLQVpYL05DVERKMm9t?=
 =?utf-8?B?Z2gvL2FBUUd6OFNvaGwyaGdId2l1M3RGRUpjdk13TlFubjBaazBqeUJUL2NZ?=
 =?utf-8?B?T1lvOGdwdmlxVzlrekN6T2RKZmFaQ3MvVUFZZ0VVd0VvWG9XZVVYSWxuajJ6?=
 =?utf-8?B?Zm5NZEFhTnBmYXFtNFVZemdDRHM5b3N4Yk1ObG5aNkNZU3dDaCs1bFJjOXFU?=
 =?utf-8?B?TUdzd001TklsWk51Y1puNjBUT3lwaTd3N01SeGZmcDZ4b285T2trNElRMGdy?=
 =?utf-8?B?TGVscEV3ZXZzRVFLRnFBdEhuT3BXd01lMFMwbzZINEpQOW5yYit2aUlxcm05?=
 =?utf-8?B?S0RvaXlRZitwbjNLbElHZHBOSktnSFFCaURRaTQ3QjNvcnVaVFVFSURzaGVD?=
 =?utf-8?B?dlIwMFRvVmFSM1cvNzV3OVBmcGs5dHRpWGU0YWJERFNTQ09ScFRJa2pMQ0ln?=
 =?utf-8?B?emF1bHJaSmlzK2V2NGE4QTlBVjNIRjQrd0JvNEs4T1dhZ0tKTk4yNjBFdjVZ?=
 =?utf-8?B?TW1QRWFsNU4zRTBvV0d5cEhtd0FwUFVWU0crcE80ckVOb2NnU1QzVEVUWlRO?=
 =?utf-8?B?K2ZER2kydHpIV1BKWVpBVTUxUFJ2emoySGk2aGNSeHpaWkhZWXVXM0Zpam5F?=
 =?utf-8?B?ZzhySEFsY1pUTktFb1YvakdESzliQlVJMm9SNDNJaUo2Vkc5V1BwWkNlQkx3?=
 =?utf-8?B?QnlDblE5dnJsY1YzT3FTZ0ZNNUk5bTN5T2JhSWl4RW5HQnprVHVRWDQzUXlO?=
 =?utf-8?Q?vOUweQCBy+B3120GwSK1lEU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXh2bFZsS3Z2VjBMdXJjNlVnMXVPdmR5Vk1walBqODJQV0hDT1pTdDkzaVNS?=
 =?utf-8?B?VGowYzg0WS9qQVhLS0NzeW1ZaTBFYzNoK3FQbEdkTFZvV3BNYXYxZXpMYlF1?=
 =?utf-8?B?ZnRHaExOQk0vTkk0aHRxeVhSWEkwcVRack15WWdnbWViK3AyNTF1cXVzQmlz?=
 =?utf-8?B?bkRveUQxVXlucXJqRGd2Q2VvU0lLUm91NkxJeVZ5RytQS1FmVERYcTNqZ24r?=
 =?utf-8?B?bnNiWTdKQmFsK1BVSTZPcEtLR20zTXpINktycHFNUGVvTjVXQU9MQlpkMUJk?=
 =?utf-8?B?ZitCK2VNaDNUMDIxM1lQZkVZV0l1Sm83Q2lYd0NEa1phdGswckRMMGk5Nk9w?=
 =?utf-8?B?VkZOL3JkZ2xOVDJ4SjhZZmRSOFpMZ3haVkRtdXFVVzl2UWFjV1lPYlgxUEpz?=
 =?utf-8?B?NXRNWHZDT0JQOGdRR2w2dm9TRnVJK1BJcGlNZjVyem14NUpHeVZJcW1vV3ph?=
 =?utf-8?B?NExXS1JMWE9uMGo5aGF0Z3loYWJ2VHpFdG1Gdit1eUV5dTRveHhSV3VCYU9Q?=
 =?utf-8?B?SnNpcGdlbVZ4a0FyNnVtM1J0YVBSdUErSStuSEJnTDJiUkVZSGQvYVlFNDN5?=
 =?utf-8?B?a2dreHFlaytOMGR5bS9yYWhxMVY0RU81QjVVWVY0eUZYRXVOVUdveWE4MFdn?=
 =?utf-8?B?OHV0cHFURi8wa0VmdU00Ly9zZUZsempnb2wvS0lyZ0pHNk9iL01JaTIzS0tV?=
 =?utf-8?B?K0xBZzFpbzdNR0Exb2FhdXBYTVJQM25NVUlBU2JhZ0o4VnI4RnBZVmdYeGIv?=
 =?utf-8?B?QVMxNVdwVFVuQTJ0WjlzdzM1VjA5YUl3bVp0WHpNanJhVnhBS1pCSVYrelI3?=
 =?utf-8?B?WG56RTZLZHd4aHBMd1RabHJjOVJ2T3kzL0ZsbHZoa1BwUUFidlI2QnJEam83?=
 =?utf-8?B?SU5RbGdTSUszSmZjVkFUOUVYRkc3T29YemdISDEySk9CVjBZM3pTdzB0a2JO?=
 =?utf-8?B?WjdCRjJHTkw0dEVUWGtmbnRuNU8xSmRlSnU3UDZETUxCd1hXT1pldDRGSjFV?=
 =?utf-8?B?T25XYlF0V0lFU3JnS2hBQkxhNzlITEJSaXI0VFNFZGR3QWtGUzYybEYwMEN2?=
 =?utf-8?B?Q0xMQ01DMnhiMFJPekhUakJ0V0M1T204aWNHT1dERDZkSEtYSGNYRCsyRVJR?=
 =?utf-8?B?WWhSS2Vha1VLemZweXZrK1Y5bWtxU2tMRXBsTmtpbFprdXRzZGEyZktud0Fz?=
 =?utf-8?B?UEdDZnp3MVI0WXZkNTlONkdnbEJzSnJNY0dHR1l4djA3a1FYd21BUDV2QnZZ?=
 =?utf-8?B?R29vK0JxZkhKN1Y0OG1makNvWkE2bzZXcWxtTFVvM1VDS21rVlgxL2FhNGdn?=
 =?utf-8?B?M2Vlanc4eG9HQjZ2VnlWTlNINzhOUGY3YS9PVDVTNkQ0QUIzN1p0c01rOThP?=
 =?utf-8?B?L29mQlhrYnFwdGIvb21yOHQ0V0YwWWR3eDJ4T0pTYlNyRzQ1K09ISG5mZHpz?=
 =?utf-8?B?ejB1TlZFK0ZHODlGN3dMWTR1QTdya0E1VXlSZXA3L2xJcGF2YTdQWXZveWFL?=
 =?utf-8?B?WHB3Z1lUdERpUzJPU0VHU2l0YXZaNXZQQ05qTkg4MTE3RE85WkJ2bFdmVkh1?=
 =?utf-8?B?dHBsRWhCazBjVXJ4OGpEUExWQVFCR1FIRE9WTEZpOG50YVF1bVJSajNUaDFL?=
 =?utf-8?B?akJYaHlSWGhFZk9PbFpkZWZ3V2t0U1NQY2hWdlJNUisyY2ZML0wxbENkODYx?=
 =?utf-8?B?cjBrRDFnMEliRy90Y3BZRHJZeksrRkhKekFSZm1Db2k2TnJHRUNER0FWS1lT?=
 =?utf-8?B?WkI5ZUtiVXBXOFdReWRGTVd4M0h1RkFhbEU5dGFNZ3NsSWV6MzluMlpvMDF4?=
 =?utf-8?B?U3BVaDBRSzRpbHl2L3hkczhva2k4ODM0S1lGdGFQN2paZDdhc2l1UU1SOVZz?=
 =?utf-8?B?NVNwN1hES0xBeTVVeFEzZTA4SGd2YWJDUmdFNktld1hJZFV0dkxQSlhrdXpZ?=
 =?utf-8?B?NTBadEdhZkdCZzhIWUZORDNXZWU0R3h5MVhhbkpybi84OWhFVitpMTNkSzE5?=
 =?utf-8?B?bUJYbVZzWmxGa1lIemJ6SWVYTnI1Zm4yY01RSTlhQUFVaGFKQ2tjRTJ4Nk1V?=
 =?utf-8?B?NDdHUCsxeWZ1TGRPZ0RjZzdUMGU2d29jeG5Jd0R4V2F0bVpjckJCL0hmK0Ez?=
 =?utf-8?B?R0NEZjFsWjc0ampCcGl1ZW5sZWlYcngyS0k5V0psRkZ6eGFjck5mSVNJallT?=
 =?utf-8?B?SkZna1JQMlhCZlA5SCtsUHdXL3FjQ3R4SDF3SHo1cFdrQ0RtanRZZFpKdHFD?=
 =?utf-8?B?TWV0bWZhN09XRzdhdVdMQWtrYVVJNW0zYURrRkk3UVcyQ05zMklPcVF4K3Bx?=
 =?utf-8?Q?63OfOAIOD8yAEehBtp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ed93e-dadf-4e48-4e68-08de58132b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:00:48.5628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhlVfua+14yVHv6l0FTWM5M+R/5lv4I62sFVjdeNs43W9NWvEU8z+92djMMZ2+sygCRD2SZXYAB5yKnhF/wCYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
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

W1B1YmxpY10NCg0KSGkgQE1vcnRlbiBCcsO4cnVwLCB3ZSB0cmllZCB0aGUgY2hhbmdlcyBvbiB6
ZW40IGBBTUQgRVBZQyA4NTM0UCA2NC1Db3JlIFByb2Nlc3NvcmAgdXNpbmcgYGRwZGstdGVzdGAg
d2l0aCBvcHRpb24gYG1lbWNweV9wZXJmX2F1dG90ZXN0YC4gRm9sbG93aW5nIGFyZSB0aGUgb2Jz
ZXJ2YXRpb25zDQoNCjEuIHRoZXJlIGFyZSAxIG9yIDIgY3ljbGVzIHJlZHVjdGlvbiBlc3BlY2lh
bGx5IHRvIGxvd2VyIGJ5dGUgc2l6ZSBmb3IgYm90aCBhbGlnbmVkIGFuZCB1bmFsaWduZWQgY2Fz
ZXMuDQoyLiBvdmVyYWxsIHRlc3QgcnVuIGZvciBhbGlnbmVkIGFuZCB1bmFsaWduZWQgY2FzZXMg
ZGlkIG5vdCBjaGFuZ2UuDQozLiBpbXByb3ZlbWVudCBhcmUgc2VlbiBtb3JlIG9uIGFsaWduZWQg
dGhhbiB1bmFsaWduZWQuDQoNClNvbWUgY2F2ZWF0czoNCjEuIFplbjQgY29tcGFyZWQgdG8gemVu
NSBib3RoIHN1cHBvcnQgYXZ4NTEyLCBidXQgdGhlIGxvYWQtc3RvcmUgaXMgMzJCIGF0IHRoZSBi
YWNrZW5kIG9mIHRoZSB1YXJjaC4gVGhpcyBtaWdodCBleHBsYWluIHRoZSBubyBjaGFuZ2UgPiA2
NEIgb2RkIHNpemVzLg0KMi4gbmVlZCB0byB0ZXN0IHdpdGggdmlydG8gb3IgbWVtaWYgaW4gY29w
eSBtb2RlIHRvIHNlZSBhY3R1YWwgcmVzdWx0cy4gKHdpbGwgdGVzdCBhbmQgc2hhcmUgcmVzdWx0
cyBzZXBhcmF0ZWx5KQ0KMy4gaW4gZnVuY3Rpb24gcnRlX21vdjQ4LCBzaW5jZSB6ZW40IHVzZSAz
MkIgbG9hZHxzdG9yZSBuZWVkIHRvIHJlY2hlY2sgaWYgd3JpdGUtY29tYmluZyBpcyBjYXVzaW5n
IHN0YWxsaW5nICh3aGljaCB3ZSBjYW4gc3BlZWQgdXAgYnkgZm9yY2luZyBoaWdoZXIgdGhlbiBs
b3dlciBhZGRyZXNzKS4NCg0KTm90ZTogbmVlZCBzb21lIG1vcmUgdGltZSB0byBjcm9zcyBjaGVj
ayBhYm92ZSAyIGFuZCAzLg0KDQo=
