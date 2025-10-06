Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A895CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 13:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BF8C402E2;
	Mon,  6 Oct 2025 15:59:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 15F73402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 15:59:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596BV8ni029037;
 Mon, 6 Oct 2025 06:59:32 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020135.outbound.protection.outlook.com [52.101.61.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49m769grau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 06:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3fA4FLDW/cFYaritc06l+Qwdxso8ulOhhBbKwHIzdbQGeChUC/5GcH9n8EI41vLg0KSLA0Lhh8JkvVThA9n3lGq8tvjT/d6CEEWqAmb+CD5tlxqRhP8VJkgZ6snR9kDNgd3GcPCwzDkFCoSdS/hPVCvJRsWoVMpXozHvO9wAuph5+AXuMzc6GFeDoahBNBp6Gu3GgNOpIFXy4GRpPw0SyJQwdhx6ULnkFn7Zr8/AU7N5GdpPJofwQ1bz5bZW6XroRsOeArhv204tbnB2gDYj2NqvYPrYoEasehLuziNzpdi81VAQw9HbTKfG/uotY5Te/YqsVRfTr5SYzbqOmaVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXzCLS5omvuKFE2Mgukhlcoj8T+4rGstyRes4sHrKQQ=;
 b=JuxyGeVqXGCl+tDUwONFPnaunQgh8plvdbjE408ibmPT2Lc6EW4ZuoDvjykHQihYcKx0xCGRf4BhTnE+i/NJTbhVp3Zbc8tfuqc56BUTYzH+57WJqE1GlpROYLZzu+W2L9LkwLyouL0oVfpcJIBcGkco3Bvx5DZaXfo9E8B6awdE9eNZ2zA816rn9+9XIYaLhpW5nbUCGkD+KJqRP2oklxGES2S6uqkLePmF6LgwyaAYq2n9MMJB6Azbv7e8nmiNSO0uKIuq8SO+6C5KCMinpM7Z/d/khW53K8K1JtZ6OOyfgy554nPExlR+EWT4Y8LT2LrttvPnHD0Bq8Z/kW/7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXzCLS5omvuKFE2Mgukhlcoj8T+4rGstyRes4sHrKQQ=;
 b=C1igugJoevG2DyBdyPlBqrrKSfj2Mh8nWvgYgAbpSM01mDe4aZ6dJ8RKr7VE0lYkiCGkCofQ9Oir3zI3HEsNXI6lNFL1Pf71IY0xlNLwk54vT4E/MXEQhu4TZvC4eChSNMovBKWyS3+sZiw8oxpG2x0BXECtVN4EpNPICBStw+c=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by BY3PR18MB4691.namprd18.prod.outlook.com
 (2603:10b6:a03:3c6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:59:20 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 13:59:20 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, fengchengwen <fengchengwen@huawei.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "vladimir.medvedkin@intel.com"
 <vladimir.medvedkin@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>
Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Topic: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Index: AQHcGzy5YkOIwkQZ3keJnCVDiFvIxLSaUdWAgATUAxCAArb0kIALHS+AgAhhaaA=
Date: Mon, 6 Oct 2025 13:59:20 +0000
Message-ID: <SJ4PPFEA6F74CA2460870904712F25B550FA6E3A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
 <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA2DDB3385FB29756363375A61CA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <BY3PR18MB478537EA13F30E686068F557C8E6A@BY3PR18MB4785.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB478537EA13F30E686068F557C8E6A@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|BY3PR18MB4691:EE_
x-ms-office365-filtering-correlation-id: f7e15585-c405-45f5-21ae-08de04e08c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NVVwVE5kNlJpb0YyQ04veEpMTTZJOFV1QTlXd1JIWU8rejhFRFlHZVc5UFZi?=
 =?utf-8?B?L2piZG1hU1JCQ0pOQTVkNDNaRUtPS25tZGx6M1llUElqU1V1L1QwbVE2YW1v?=
 =?utf-8?B?ajhCb2dESWN2RTNibE5lREZEY0dBbHBoakQ1SUtjdTZWRzZXU3Y1b3ZrQWVS?=
 =?utf-8?B?NFdWYVVsOEF6Rk9MVDZ6Y25Bc3AxSm1KUklRY0FhQzN1c2tGR3ppSWZ0V3Zp?=
 =?utf-8?B?UEJWSmlYTUtyeDlkaGo2dTZUYWRuMnZMOWp6UWVDVzczUVVtYXJobjNyQ2JS?=
 =?utf-8?B?c214cURSanIwdXluSTRXTVF4bXhDZ1FFTkIzV1RwVHptNmhaWHMrWGt2aXJC?=
 =?utf-8?B?STJPMHN4MW9PN01sRlVPVitJWndWWDUvWkoySDBlaWttMkw1aUtCMEtnT1Vt?=
 =?utf-8?B?OXVtVC9pMFZoLzVMMWJ0TktMbkRqblFyWDZjdFI2S1VBRzVBTUlGWkdGNk1G?=
 =?utf-8?B?eTVqQm1kaGxPTmZSOEhEM3BzVFFLZ1RwUk1QWWZhQWJXSk5QUG5GMzFMMnRv?=
 =?utf-8?B?dE4rZ1ZMSmZ5N0RCcHpPK2dsTWtIajJSaENXaUF2cHdKM1E5TCtvV2xtS1hD?=
 =?utf-8?B?M2EyQmlaKy8xSktHQ1NJT1ZEZVpIa29HSFJJTVdnWWcxWXNWRjBXK1dweWRV?=
 =?utf-8?B?NzFSYUlTZEpnZ00xM1djMFZsd29kTHZndGxiQThZaWZucmlPRitHVm5BQ1Nn?=
 =?utf-8?B?dTAzWnZodm41ZHlXbEkrbmh5SXdHd3R1S0ZheFp1Vk9kZytnSnJEcTVIRkk2?=
 =?utf-8?B?WlBDU0VrN0pJYjJpQXMrQlZEY1BHVlM0RjhVUEcyckhGWXhXRDdJNWJ5SUdv?=
 =?utf-8?B?QU5jRElKWDB4NmtlUWt2bGE0bTg3MGIzWmNDYVVoZURlbGljbjREaENvbnpK?=
 =?utf-8?B?K0J6RlNoNEFLY2NTOEZSaGZBTGxMMHlYbFYzN1dtVEQxc1FFdzMrK25SOGpi?=
 =?utf-8?B?QUtmY1NvckdaSWlkditJVVZyaHBJOXRTcXFTZ1lmUDhuYmtGVXBxRGpFUUV6?=
 =?utf-8?B?UE16Vm5UcXJUUVByYmhhQ000RTEwcjVIbUtXUkc3c2xpVGhzd3pBNVJvallG?=
 =?utf-8?B?SHNDVXJHWndPSEt0Mk9XREhDUUU0VU9oaExxdlp3WFJhSUdya2tXVTBEcjJJ?=
 =?utf-8?B?SHpZb05xbVUxbVc4U0lJNEZVRFpjaHlhYVd0blg2eXNnTE9mV0FpeUNrTS9j?=
 =?utf-8?B?NzN6NGtpZmpwMmxNV2ZPVXZuTko0SUxtTlNHTW1MRUxIaUNIaCtEZVlFYVVh?=
 =?utf-8?B?US8zZ0NGOUlMK1VkdURyUldTbFJ3L2JEaDQ3VFViRkRDdVpxRXZaaTlMSk9k?=
 =?utf-8?B?Ni9WVFIzVkxUcGgxWm5UYjg2MWFhcGFJWEhzUWJSOVh0MDgvVENuQTdieU1w?=
 =?utf-8?B?VGdYM3NORGdZOVZKc1U2YXFLekVHcDdIV0lnLzlQcTkvNFdsS29vVlhTbS9t?=
 =?utf-8?B?VTFza1g1RUdNSnZDb2p6TmtPV0JRblNhWlZnUHVBY1lEZzhDVnR3Sk81RjRt?=
 =?utf-8?B?ZWR5bGFub2drNmZSWG5US0tINTF1VHd1QWNjdW5mUllnNG1GaDltVVdna2Ri?=
 =?utf-8?B?S2kyaUw1NDExMWdkMHJnMnVQSS9DQng5ays5aGNDVzJUTi9HMEN6TUJRRXRD?=
 =?utf-8?B?eTB1SHp0cTJ0R0lPcFM2ZG9YVzg1S0pVUkhIQlRPVzZUVGpBOFZSN1NSdGNX?=
 =?utf-8?B?S3VrR3pyR3NHRXZVRkFCZHRoTTlra0x1ZGFseFBzM2VQMis4Z0VnaFV3ZXRh?=
 =?utf-8?B?L3BWSjJiOTlrcy9ISmkxUGd5bHFDQkNnQmhGYkFadHlJMlFxZ2IvdVA0aXJv?=
 =?utf-8?B?bHd1Wno1aFBQSXZxYXluMGtnc1J2NW1mZ2dtdDh3N3BqaTg0VTZETnkxSi9y?=
 =?utf-8?B?SWRTVUpGVVMwZXNRMENPdnBDdWxFMmZobTZLQmxuQ05RdVl4WGUxVEZjNVlI?=
 =?utf-8?B?bjRSQjYwOGFxUm1lN1Vka1gzM0dKZ1FSZURYU01kcC9wTlhtSlpmN0tXZEJn?=
 =?utf-8?B?MmdNNGF0b04zY0N1bExBMUVqVy9QWGRqRWkvVVVuaXlGV3ZXSmtxSkZSL0Fn?=
 =?utf-8?Q?o6G9qY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M004ZXo5NHV4bFB3OGM2NmZISlI2RVgyQWs1WXVnL256VDlUSkRzNk1vTC9Q?=
 =?utf-8?B?YXZIMVdEaS9VU0VuUVN6dGwva0VYbEV2dyswSUtDNTNiZVplTWhrdXZ0dldF?=
 =?utf-8?B?amdGcXhXLzM2OTBmYW1TeDhDeE1pVlYxalJwb2NVK2hlZ0VpNmJCdUpaa1lM?=
 =?utf-8?B?bjlJVVZHOHdqRlRiN2tNWkZPKzVUYXo2ck9RN3R4Nmw5aFZWTGE5cm1hK1lq?=
 =?utf-8?B?Qis0SE4wOG03blVkNllFSjEyUUNUazZEQVhvRm9xRnZ6c25vVGRvaXpvMmlp?=
 =?utf-8?B?NytOTmVsMXVGN1BrUVVtUDFJSlNRbm1uYzg5ZEpINDljM2kxMUxiLzFacyty?=
 =?utf-8?B?cXNnZDdSUUtPNTJkV3U3RzdZQ3A1R2E3QlV2VFREQ2poRElMNlBIajlvS00r?=
 =?utf-8?B?c2tpN2dYSys5UlB3SDIrK0taZE9KcHJ5eVkraUpPeWxGemsyQkJQMVNBMW80?=
 =?utf-8?B?Vm5UOUtiN1NkcWE2RGFhSEFiM2hGVXN0NzRFY0trUmNSMXJGL09tZ3BvSDhk?=
 =?utf-8?B?ME13WlA3V1U0K0RnUGNDdHk5Um1pdHVsSDNEa2RuY09Wc2lxYVRqTXI3aXVm?=
 =?utf-8?B?SWtQKzlpdXptUlFYVk5ybUhnWmljbHJmWlF0ekhkWWZXN05lYUk0bW5zN2xJ?=
 =?utf-8?B?akVLVFBpenQ3NEFzaWhic012WXcrZHhnajhXWGl0SUVHaTBJTTFFanMrR3Mx?=
 =?utf-8?B?VU9GeUo0bW1uNXd6ZUhuMDVISE1GZ2VsVzlHY0ZicXFHcXl4cE91VGhqckZ1?=
 =?utf-8?B?b2Myd3JHTTVtTEZPMEovOGFTcTcwall3MUdFRy9WQ0UrdkorTDFJZ3VvMzBs?=
 =?utf-8?B?VHNacEJmK2xCM0RPd3AyYzdjL2RNc3E2YnJWekFWVEs3Zmd1MW1PbHBWZ3ZJ?=
 =?utf-8?B?RjBmYzBPRlkya1B2VkxTOWtwNG9xaEpmdkg2VUUvaGcvQjVoRjdYbjY3cEhx?=
 =?utf-8?B?SVlOOTdkb1BIOHpQY0FTbVBILzZoTFFtbjJsYlVUVFBieHp2V2lmVW9JMjZI?=
 =?utf-8?B?SkpiZGtwa1ErNHpzVFFCb2VCUjFSTTIzTlB0QWJaa21GeHYrVkRrczRKV3pR?=
 =?utf-8?B?WWREWElkNjhQd3ZRd2FoTm5Hd1lFeDNTWmoySFVLUWNhNG5iQityTlZJcjZz?=
 =?utf-8?B?NGtuVDhFOHYwYmZva2R5ekhicDdNZkpmaW9VN1F6REpZcVJ1dzZWR2ZSTjlz?=
 =?utf-8?B?dHdpbEhRb2g3YTdaS091MkhZcEo1aFF6R2dXVjNDVFZCTmN5WXh4ZHY5Wk9k?=
 =?utf-8?B?dGhjSmxwNk1EK0JzellHTG5nOVRuUzVmY1JTdWh6U2pydzVueWgvTTBHMHln?=
 =?utf-8?B?WnhtS0NuNEdqaEd5MDhnSkxxZjZIMU9rTS91NlRFeUZDWVFYcDNWL2o3Y2ZI?=
 =?utf-8?B?YVk4WHlPdE05cGROWmZsdjZNYjVMbVZiUFNGV3Zrd05zVnA0WWlZWlh0V2RV?=
 =?utf-8?B?aml5U2lxRjlVMisvbllZdTQ4eG9GUkNYY1BySm8zUThxOVc1R04xL0cwNSsx?=
 =?utf-8?B?RDV3YkVxWG01OENCM2puUmZ2VDlkSkFQcjQ2aWFua1ZnQnhubngxZG56MGNM?=
 =?utf-8?B?cis1WittSy9EemRFWWhUOVl5N3hCRTVGZzQ3dVY0YzRyYW1iMkFpaTdKZVZO?=
 =?utf-8?B?MGR3SzhLQUtZNlk3SmovY0RKREQweXVKQzZuZUN6UU82RTQ4d0dWZnpHNExi?=
 =?utf-8?B?NERMWm01NW1ZMWt2aDNWaU9KSEhreDB6d0U0ai9WZ1YrdDF3MnIxbUZadWs2?=
 =?utf-8?B?K1NkTEtybklWb2F3WlRJUWlkaWJMZUx3MzIwOFFkOHMxT2F3SDlYTWc1RVkw?=
 =?utf-8?B?cW43QlRGNkljdlR6b2I3cVRGWWd1TXp1QlhyODhpempQaHF3cWluaWlDTGJ4?=
 =?utf-8?B?aHhyUEU0TGVEWGZWV3FoN0kzYjZaN2FzeE1YNmZ4T2NOLzhmcDJRaUhRNVNI?=
 =?utf-8?B?YlJ1eWdXQWh6MkFnenpYMUFCQU1sb2gzWkZxZmVUaFNlQ0h6OG80bjA2d0pD?=
 =?utf-8?B?b3VQbm1oQm5xcnFNSER0bW0xNXgzVUc4WlpQYkQxRUxvYTJWOWFkRG9tS1pL?=
 =?utf-8?B?czBSTlhGZEs5cTZERDM2cGVjNzVJbTNmN1hNZ0VNK0ZEZGcwVnRKQm9xMlU1?=
 =?utf-8?Q?LZM9cLQ7QgEXGL/6NCh4oBt7a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e15585-c405-45f5-21ae-08de04e08c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 13:59:20.2016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8hJjSYU6dYrXp6y52FKlLsF1zrtp6lAFcJQ3ypwAe7NbYBZHI8jYOGB2YMt8sIejjA8AAJ8xXBOa0I/6ajZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4691
X-Proofpoint-GUID: LM4e5LRiazuAtdTkr67GBaoMI0AhiGmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDAzNyBTYWx0ZWRfX8dGX6PrlcCIn
 W8V8ySfwnbxcp6GG3IghhsHO67TtdgWb5qiQu55OCIUp35iR8v3dVGVYPdAM98N9vcb1IGgIci+
 TUNpQ/l/Od4ZqPOpv7244EPURr/4RH+G4D0QQ78eUjmU03PA5mTtALxQjiYjq8bnXHoZBKDy9mZ
 W38jbYNpUOhVQRdSNGqbarXFyqV0+wqfPxA13JoH03OEuAQNyDVw2C6LeeSqsfNI0RfB9Uflghs
 orwrhH3+yIX98jPwEYY1xxEXHe1ZmnN5fkEI3h4uIvi5jhlNhSW7rn8wXiFqr9r6bJPJJwNQjMh
 9v4RUlJIZXWGnY7fOuFF35V0D9KxVyjRA76/GRX5RPiD5lQqJBH6Y9xhNZ9X/FlpxHle51rYkBi
 tyGEnWNwQTcFq2o7LmW3lJZehV2FxQ==
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68e3cb44 cx=c_pps
 a=3NCrMMJo8uPYhFoENQJqcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=bt5KbKNvAAAA:8 a=RRWp4RTK12sWzKCEIu8A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: LM4e5LRiazuAtdTkr67GBaoMI0AhiGmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
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

SGkgRmVuZywgQW5hdG9seQ0KDQpDb3VsZCBwbGVhc2UgcmV2aWV3IGJlbG93IHByb3Bvc2FsIGFu
ZCBzaGFyZSB5b3VyIHRob3VnaHRzLg0KDQpSZWdhcmRzDQpWYW1zaQ0KDQo+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogVmFtc2kgS3Jpc2huYSBBdHR1bnVydSA8dmF0dHVu
dXJ1QG1hcnZlbGwuY29tPg0KPj4gPkZyb206IFZhbXNpIEtyaXNobmEgQXR0dW51cnUNCj4+ID5T
ZW50OiBNb25kYXksIFNlcHRlbWJlciAyMiwgMjAyNSA1OjE5IFBNDQo+PiA+VG86IGZlbmdjaGVu
Z3dlbiA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+OyBkZXZAZHBkay5vcmc7DQo+PiA+YW5hdG9s
eS5idXJha292QGludGVsLmNvbQ0KPj4gPkNjOiB0aG9tYXNAbW9uamFsb24ubmV0OyBicnVjZS5y
aWNoYXJkc29uQGludGVsLmNvbTsNCj4+ID52bGFkaW1pci5tZWR2ZWRraW5AaW50ZWwuY29tOyBh
bmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tOw0KPj4gPmtldmluLmxhYXR6QGludGVsLmNvbTsgSmVy
aW4gSmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT4NCj4+ID5TdWJqZWN0OiBSRTogW0VYVEVSTkFM
XSBSZTogW1JGQ10gbGliL2RtYTogaW50cm9kdWNlIGludGVyLXByb2Nlc3MNCj4+ID5hbmQNCj4+
ID5pbnRlci0gT1MgRE1BDQo+PiA+DQo+PiA+SGkgRmVuZywNCj4+ID4NCj4+ID4+SGkgVmFtc2ks
IFRoaXMgY29tbWl0IGNoYW5nZSBpcyBtb3JlIHRoYW4gZGlzY3Vzc2VkLCBpdCBhZGQgY29udHJv
bA0KPj4gPj5BUEkgd2hpY2ggZm9yIGdyb3VwIG1hbmFnZW1lbnQuIDEuIENvbnRyb2wgQVBJOiBJ
IGNoZWNrIHRoaXMgY29tbWl0DQo+PiA+PmFuZCBJbnRlbCBjb21taXQgWzFdLCBpdCBzZWVtIGhh
cyBhIHF1aXRlIGRpZmZlcmVuY2UuIEkgaG9wZSBJbnRlbA0KPj4gPj5ndXlzIGNhbiBleHByZXNz
IHZpZXdzIFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQgSGkgVmFtc2ksDQo+PiA+Pg0KPj4gPj5UaGlz
IGNvbW1pdCBjaGFuZ2UgaXMgbW9yZSB0aGFuIGRpc2N1c3NlZCwgaXQgYWRkIGNvbnRyb2wgQVBJ
IHdoaWNoDQo+PiA+PmZvciBncm91cCBtYW5hZ2VtZW50Lg0KPj4gPj4NCj4+ID4+MS4gQ29udHJv
bCBBUEk6IEkgY2hlY2sgdGhpcyBjb21taXQgYW5kIEludGVsIGNvbW1pdCBbMV0sIGl0IHNlZW0N
Cj4+ID4+aGFzIGEgcXVpdGUgZGlmZmVyZW5jZS4NCj4+ID4+ICAgSSBob3BlIEludGVsIGd1eXMg
Y2FuIGV4cHJlc3Mgdmlld3MuIEkgcHJlZmVyIG5vdCBhZGQgdGhpcyBwYXJ0DQo+PiA+PmlmIG5v
DQo+PiA+cmVzcG9uc2UuDQo+PiA+DQo+PiA+VGhpcyBuZXcgZmVhdHVyZSBuZWVkcyB0byBiZSBz
ZWN1cmVseSBtYW5hZ2VkIHRocm91Z2ggY29udHJvbCBBUElzLg0KPj4gPkl0IHdvdWxkIGJlIGV4
dHJlbWVseSBoZWxwZnVsIGlmIHRoZSBmb2xrcyBhdCBJbnRlbCBhbmQgeW91IGFzIHdlbGwNCj4+
ID5jb3VsZCBwcm92aWRlIHN1cHBvcnQgb3IgaW5wdXRzIG9uIHRoaXMuDQo+DQo+DQo+QmV5b25k
IGFkZGluZyBJbnRlbCBmb2xrcyB0byB0aGlzIHRocmVhZCwgSSBkb24ndCBzZWUgYW55IGZ1cnRo
ZXIgc3RlcHMgd2UgY2FuDQo+dGFrZSB0byBkcml2ZSByZXZpZXcgYXQgdGhpcyBzdGFnZS4NCj4N
Cj5UaGF0IHNhaWQsIHRoZSB0YWJsZS1iYXNlZCBjb25jZXB0IHVzZWQgaW4gdGhlIGN1cnJlbnQg
QVBJIG1heSBub3QgYmUNCj5wb3J0YWJsZSwgYW5kIHdlIG1heSBuZWVkIGltcHJvdmVtZW50cyBo
ZXJlLg0KPg0KPkJhc2VkIG9uIG15IHVuZGVyc3RhbmRpbmcsIERNQSBkZXZpY2VzIHVzZWQgZm9y
IGludGVyIHByb2Nlc3MgY29weSBjYW4gYmUNCj5jbGFzc2lmaWVkIGludG8gdGhyZWUgY2F0ZWdv
cmllczoNCj4NCj5DbGFzcyBBOiBSZXF1aXJlcyBhIHBhaXIgb2YgRE1BIGRldmljZXMgKG9uZSBv
biBlYWNoIGVuZCBvZiBwcm9jZXNzL2RvbWFpbikNCj5mb3IgZGF0YSB0cmFuc2Zlci4gTWFydmVs
bCBETUEgZGV2aWNlcyBmYWxsIGludG8gdGhpcyBjYXRlZ29yeS4NCj5DbGFzcyBCOiBSZXF1aXJl
cyBvbmx5IGEgc2luZ2xlIERNQSBkZXZpY2UgKG9uZSBwcm9jZXNzL2RvbWFpbiBoYXMgYSBETUEN
Cj5kZXZpY2UsIHRoZSBvdGhlciBwcm9jZXNzIGRvZXMgbm90KS4gSW50ZWwgRE1BIGRldmljZXMg
ZmFsbCBoZXJlLg0KPkNsYXNzIEM6IE90aGVyIHR5cGVzIG9mIGRldmljZXMgdGhhdCB3ZSBhcmUg
bm90IHlldCBhd2FyZSBvZi4NCj4NCj5BYnN0cmFjdGluZyBhbGwgb2YgdGhlc2UgdW5kZXIgYSBz
aW5nbGUgQVBJIHdpbGwgYmUgY2hhbGxlbmdpbmcuIExpbnV4IGFuZCBvdGhlcg0KPk9TZXMgZG8g
bm90IHByb3ZpZGUgY29udHJvbC1wbGFuZSBBUElzIGZvciB0aGlzLCBzbyBEUERLIG11c3QgcHJv
dmlkZSBjb250cm9sDQo+cGxhbmUgbWVjaGFuaXNtcyB0byBzdXBwb3J0IENsYXNzIEEsIENsYXNz
IEIsIGFuZCBDbGFzcyBDIGRldmljZXMuDQo+DQo+UHJvcG9zYWw6IFNwbGl0IGRldmVsb3BtZW50
IGludG8gc2VwYXJhdGUgc2V0czoNCj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPlNldCBBOiBGb2N1cyBvbmx5IG9uIHRoZSBkYXRhcGF0aC4gQXNzdW1l
IHVpbnQxNl90ICpzcmNfaGFuZGxlIGFuZCB1aW50MTZfdA0KPipkc3RfaGFuZGxlIGNvbWUgZnJv
bSBlbHNld2hlcmUgKENsYXNzIEMpLg0KPlNldCBCOiBJbnRyb2R1Y2UgY2FwYWJpbGl0aWVzIGZv
ciBDbGFzcyBBIGRldmljZXMgd2l0aCBwb3J0YWJsZSBBUElzIChwcm9wb3NhbA0KPmJlbG93LCB3
aXRob3V0IHRhYmxlIGNvbmNlcHQpLg0KPlNldCBDOiBJbnRyb2R1Y2UgY2FwYWJpbGl0aWVzIGZv
ciBDbGFzcyBCIGRldmljZXMgYW5kIHJlbGV2YW50IEFQSXMsIHRvIGJlIGFkZGVkDQo+d2hlbiBu
ZWVkZWQuDQo+DQo+V2UgY2FuIG1lcmdlIFNldCBBIGluIHRoZSBjdXJyZW50IHJlbGVhc2UgYW5k
IG1vdmUgU2V0IEIgdG8gYSBuZXh0IHJlbGVhc2UNCj5faWZfIHJldmlldyBvciBzdXBwb3J0IGZv
ciBDbGFzcyBBIGRldmljZXMgcmVxdWlyZXMgbW9yZSB0aW1lLg0KPg0KPkBmZW5nY2hlbmd3ZW4g
VGhvdWdodHM/DQo+DQo+Q2xhc3MgQSBBUEkgUHJvcG9zYWw6DQo+LS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+VGhlc2UgQVBJcyBhcmUgYmFzZWQgb24gYSBuZXcgY2FwYWJpbGl0eSBmbGFnIGZvciBp
bnRlci1wcm9jZXNzIG9yIGludGVyLU9TDQo+RE1BIHRyYW5zZmVycyBmb3IgQ2xhc3MgQSBkZXZp
Y2VzLg0KPg0KPg0KPi8qKiBDcmVhdGVzIGFuIGFjY2VzcyBncm91cCBmb3IgcGFpci10eXBlIGlu
dGVyLXByb2Nlc3Mgb3IgaW50ZXItT1MgRE1BDQo+dHJhbnNmZXJzLiAqLyBpbnQgcnRlX2RtYV9h
Y2Nlc3NfcGFpcl9ncm91cF9jcmVhdGUoY29uc3Qgc3RydWN0DQo+cnRlX2RtYV9kZXYgKmRldiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnRlX3V1aWRfdCBwcm9jZXNz
X2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydGVfdXVpZF90IHRv
a2VuLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCAqZ3Jv
dXBfaWQpOw0KPg0KPi8qKiBEZXN0cm95cyBhbiBhY2Nlc3MgZ3JvdXAgb25jZSBhbGwgcGFydGlj
aXBhdGluZyBkZXZpY2VzIGhhdmUgZXhpdGVkLiAqLyBpbnQNCj5ydGVfZG1hX2FjY2Vzc19wYWly
X2dyb3VwX2Rlc3Ryb3koY29uc3Qgc3RydWN0IHJ0ZV9kbWFfZGV2ICpkZXYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBncm91cF9pZCk7DQo+DQo+Lyoq
IEFsbG93cyBhIGRldmljZSB0byBqb2luIGFuIGV4aXN0aW5nIGFjY2VzcyBncm91cCB1c2luZyBh
IGRldmljZSBoYW5kbGUgYW5kDQo+dG9rZW4uICovIGludCBydGVfZG1hX2FjY2Vzc19wYWlyX2dy
b3VwX2pvaW4oY29uc3Qgc3RydWN0IHJ0ZV9kbWFfZGV2DQo+KmRldiwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGdyb3VwX2lkLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcnRlX3V1aWRfdCBwcm9jZXNzX2lkLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcnRlX3V1aWRfdCB0b2tlbiwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJ0ZV9kbWFfYWNjZXNzX3BhaXJfbGVhdmVfY2JfdCBsZWF2
ZV9jYik7DQo+DQo+LyoqIFJlbW92ZXMgYSBkZXZpY2UgZnJvbSBhbiBhY2Nlc3MgZ3JvdXAuICov
IGludA0KPnJ0ZV9kbWFfYWNjZXNzX3BhaXJfZ3JvdXBfbGVhdmUoY29uc3Qgc3RydWN0IHJ0ZV9k
bWFfZGV2ICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2
X3QgZ3JvdXBfaWQpOw0KPg0KPi8qKiBSZXRyaWV2ZXMgdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRp
b24gaGFuZGxlcyBmb3IgYSBnaXZlbiBkZXZpY2Ugd2l0aGluIHRoZQ0KPmdyb3VwLiAqLyBpbnQg
cnRlX2RtYV9hY2Nlc3NfcGFpcl9nb3J1cF9zcmNfZHN0X2hhbmRsZXNfZ2V0KGNvbnN0IHN0cnVj
dA0KPnJ0ZV9kbWFfZGV2ICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MTZfdCBncm91cF9pZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ0ZV91dWlkX3Qgc3JjX3Byb2Nlc3NfaWQsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydGVfdXVpZF90IGRzdF9wcm9jZXNz
X2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2
X3QgKnNyY19oYW5kbGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MTZfdCAqZHN0X2hhbmRsZSk7DQo+DQo+DQo+UGFyYW1ldGVycyB0aGF0IG5lZWQg
ZXhwbGFuYXRpb246DQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj5wcm9jZXNz
X2lkOiBVbmlxdWUgSUQgZm9yIHRoZSBwcm9jZXNzLCBnZW5lcmF0ZWQgdmlhIHJ0ZV91dWlkXyBB
UElzDQo+dG9rZW46IFByb3ZpZGVkIGJ5IGFuIGFkbWluaXN0cmF0aXZlIGFjdG9yIHRvIGdyYW50
IGFjY2Vzcywgc2ltaWxhciB0byBWRklPIFZGDQo+dG9rZW4gY3JlYXRpb24gdXNlZCBpbiBWRklP
IFBGIGRyaXZlci4NCj5sZWF2ZV9jYjogQ2FsbGJhY2sgdG8gbm90aWZ5IHdoZW4gYW5vdGhlciBz
aWRlIGxlYXZlcyB0aGUgZ3JvdXANCj4NCj4NCj5FeGFtcGxlIFdvcmtmbG93IGZvciBDbGFzcyBB
IEludGVyLURvbWFpbiBETUEgVHJhbnNmZXI6DQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0KPlRoaXMgZXhhbXBsZSBkZW1vbnN0cmF0
ZXMgaG93IHRocmVlIHByb2Nlc3NlcyDigJQgcDAsIHAxLCBhbmQgcDIg4oCUDQo+Y29vcmRpbmF0
ZSBpbnRlci1kb21haW4gRE1BIHRyYW5zZmVycyB1c2luZyBwYWlyLXR5cGUoQ2xhc3MgQSkgRE1B
IGRldmljZXMuDQo+DQo+U3RlcCAxOiBHcm91cCBDcmVhdGlvbiAocDApDQo+UHJvY2VzcyBwMCBj
YWxscyBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2NyZWF0ZSgpIHdpdGggYSB1bmlxdWUgcHJv
Y2Vzcw0KPmhhbmRsZSBhbmQgdG9rZW4uIEEgZ3JvdXBfaWQgaXMgcmV0dXJuZWQuDQo+DQo+U3Rl
cCAyOiBHcm91cCBTaGFyaW5nDQo+Z3JvdXBfaWQgYW5kIHRva2VuIGFyZSBzaGFyZWQgd2l0aCBw
MSBhbmQgcDIgdmlhIElQQyBvciBzaGFyZWQgbWVtb3J5Lg0KPg0KPlN0ZXAgMzogR3JvdXAgSm9p
bmluZyAocDEgJiBwMikNCj5Qcm9jZXNzZXMgcDEgYW5kIHAyIGNhbGwgcnRlX2RtYV9hY2Nlc3Nf
cGFpcl9ncm91cF9qb2luKCkgd2l0aCB0aGVpciBwcm9jZXNzDQo+aWQgIGFuZCB0aGUgc2hhcmVk
IHRva2VuIGZyb20gYWRtaW4NCj4NCj5TdGVwIDQ6IEhhbmRsZSBEaXNjb3ZlcnkNCj5FYWNoIHBy
b2Nlc3MgdXNlcyBydGVfZG1hX2FjY2Vzc19wYWlyX2dvcnVwX3NyY19kc3RfaGFuZGxlc19nZXQo
KSB0bw0KPnJldHJpZXZlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24gaGFuZGxlcyBmb3Igb3RoZXIg
cHJvY2Vzc2VzLg0KPg0KPlN0ZXAgNTogVHJhbnNmZXIgQ29vcmRpbmF0aW9uDQo+VXNpbmcgdGhl
IGhhbmRsZXMsIGVhY2ggcHJvY2VzcyBjb25maWd1cmVzIGEgdmlydHVhbCBjaGFubmVsICh2Y2hh
bikgYW5kDQo+aW5pdGlhdGVzIERNQSB0cmFuc2ZlcnMuDQo+DQo+U3RlcCA2OiBHcm91cCBUZWFy
ZG93bg0KPldoZW4gYSBwcm9jZXNzIG5vIGxvbmdlciBuZWVkcyB0byBwYXJ0aWNpcGF0ZSwgaXQg
Y2FsbHMNCj5ydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2xlYXZlKCkuIE90aGVyIHByb2Nlc3Nl
cyBhcmUgbm90aWZpZWQgdmlhIHRoZQ0KPnJlZ2lzdGVyZWQgY2FsbGJhY2sgd2l0aCBydGVfZG1h
X2FjY2Vzc19wYWlyX2dyb3VwX2pvaW4oKS4NCj5PbmNlIGFsbCBkZXZpY2VzIGhhdmUgZXhpdGVk
LCBwMCBjYWxscyBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2Rlc3Ryb3koKQ0KPnRvIGNsZWFu
IHVwLg0KPg0KPg0KPkZvciBDbGFzcyBCOiBXZSBjYW4gYWRkIG5ldyBjYXBhYmlsaXR5IGZsYWcg
YW5kIGhhdmUgbmV3IHNldCBvZiBBUElzDQo+cnRlX2RtYV9hY2Nlc3NfbWFzdGVyXyBvciBzby4g
V2hlbiBzdWNoIGRldmljZXMgY29tZXMgb3Igd2hlbiBpbnRlbA0KPndhbnRzIHRvIGFkZCBpdA0K
Pg0KPg0KPg0KPg0KDQo=
