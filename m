Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159BC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 037514278C;
	Tue, 17 Jun 2025 23:19:05 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6748E400D6;
 Tue, 17 Jun 2025 23:19:03 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCAkut001670;
 Tue, 17 Jun 2025 14:19:02 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2138.outbound.protection.outlook.com [40.107.244.138])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b84t99m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHDMXrbt6grMr9N5ZK1AHgyn08tsBeYwKLqQQUTkfpj1KXLeZQn4w90qlj5KanzcSAAuDavHZCPXbjYZsifaPuCIg0+32hn/PEU62/HO7thYTzd4Z5y1DgAKtgg6roHi+Go+ljUrYk/ABeO3h+AesciSeKQdLamrVUQxdQ53mtQLDgAd+Xj1dzTFWn7szVW63jI+4pFJJWpAqW8JSqSogPutdEosDH4UHQsBTAr/d+doUgaRYs6PV5SuUudLThLJuDkxkPcfg/L8N3eD1JgouW0wz04+RLEwzZRa9BqblnMKSJDdnXkACpzYorC0NzGN2ybSUqSRlg7a/1bjkWXDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AolX7DsDQjGv6NlLMEXEm2m1OzBwD2KvF7qFqm2qDvE=;
 b=YR0cvtqltX+7zOFzyWC3+LqzcJO9flQammZH4ILLAJSLPQ/6Z2CFEZyH8jFhn9g1bzz4gVoeHpq/x9puFbSwZmD3aO1wC6+KQdzpXNK8Fxg7gN2/H4wmbEmOMQKny3L6Qza9UqiQgruZ/qrYOwPrLnd3U9/Em93s2wnoCNRCQB4h1EVPwGXTpERpax4w2852Wb0mUWbAAX16MlEu+0rJu8R+tdBqchm55vyz7sSjS9Yc0KBA5jyG5zM1T8V4QLRg/fmfCFC8C78MdsFNZwtHopsX846U7TKkEdcGILhP42pBTdU8wMOKGbFwFTsUVpb++H0S9mj6aKAyM0x01ev8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AolX7DsDQjGv6NlLMEXEm2m1OzBwD2KvF7qFqm2qDvE=;
 b=Jz4Hr1Dg1S7GKrhnPwsgnzHciyjNIzeiClFIL39tPT+fd6Hp92vtyEoaBjhk6fErvOxGcfT5uO8eFTuMMl0SrLPg2DBuyilUe4+7jJ/AgRN6pVheUjwlspnmNilUXi8OOz8COu1gprdfrfRHt5j7UAOAvV9hp+al5j+VTnuH17w=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB5086.namprd18.prod.outlook.com (2603:10b6:a03:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 21:18:59 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:18:58 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers
Thread-Topic: [PATCH] crypto/qat: fix out-of-place chain/cipher/auth headers
Thread-Index: AQHb324Jb7YXQbpmWUWZmnukTvTVhLQH26xg
Date: Tue, 17 Jun 2025 21:18:58 +0000
Message-ID: <CO6PR18MB4484E682D1B7060C02DC3319D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250612101414.240641-1-radu.nicolau@intel.com>
 <DS0PR11MB74583A17750C4A6AAF023CA88173A@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB74583A17750C4A6AAF023CA88173A@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB5086:EE_
x-ms-office365-filtering-correlation-id: a6212823-6f86-4743-97d2-08ddade49321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3BwZEIvMFRzTWhKK2RqTmVhLzJyN1hEVW4xRld0TzU3Sm5reHpQbFZUdU9o?=
 =?utf-8?B?VUlOYVlIWDZaSllXaXRGejQ0Q2JKaDlMR2lIbGozMmc4VnFYT0w0NkRoQzRa?=
 =?utf-8?B?aDZQUGhSRXlDZUpseklabGtYem9tdVNvL0VOTGZObWgwQ2N1OE9yYTAwR2xQ?=
 =?utf-8?B?T1JBMlEyRHliUkx3b2lRSkNGYlhNSTBWblF1cXkzSHl0cVcrakhQeXo3byt0?=
 =?utf-8?B?Y2s2TmptaEJYN0FVZE85bUVXUE5pMGFvM1JnZTA3QU5ldXJkMVBnc0ZVQXQw?=
 =?utf-8?B?VmVSRm5xSWx5S3Zad2NFU2N3MEg2c0FrS1F4L0VjVWthRWowQmZTS0d4YzlM?=
 =?utf-8?B?Q3dDSW1OSUs4Vit5QzZxUXdLdGJvbU4wN3BhZ1VBMHZpcEhSVUhFNi96UEVK?=
 =?utf-8?B?L2tHVzMveDJuUDFtZ3VNTG9xN2FENHg2WmdqRlQ5ZEp0aUt2ZmlEVHJGYkhh?=
 =?utf-8?B?eTVNaG9GVTBRMm4yYjVSZnovR3ZpZmptcnhRKzhUOFVBaWMyYnR5RHZjci9V?=
 =?utf-8?B?U2duQXoxUWFzWCtvS2hyNm5semVJTjBjV2xhdE12Wk9Zc09SeHNYTWMrdUtu?=
 =?utf-8?B?aWRHTHJvZ0lRVDFmeWFkYUIvU2lFdS9YQ3dwaGlzc0xjOTJRYldUTEw5WjJy?=
 =?utf-8?B?YnF2TXREcGtHb1dUbUcrZXlDZnk0TE1RVWxsVFBLbmFpYjc1aUVvcTduaDJR?=
 =?utf-8?B?VTFqUlZSYitFKzlDcXEyS25HK1dGUFEyMnZIMGkwOCsrZGRvMm9XRGFpRjBI?=
 =?utf-8?B?UG5oM1ZLL0h3c3ZNK2U4M05EQXRjZ1Z3YUYxOW8yWHBoeXFNNURkbTR5VElB?=
 =?utf-8?B?MmxMOGhOOTY5RG5LQnl5UnEwbFdUWVBrUkFkWWU1aGt2RGF5U2xvaElXckw4?=
 =?utf-8?B?MFNQY2hYR0xDcHU3VFZxanR0SGpOdXdNSWNoK1VHaWtaOFExWStsK2hHZS9s?=
 =?utf-8?B?YW1DMUQ2d3kya3ZGakxJK09xWk9NTnVGTUVKazdRZ2F5OVNNenlqOFJXaHJ1?=
 =?utf-8?B?TmJIWVFXQ1JtM0pYV2lPcmFLRGlHMHRzOFpoM3dGczl3NnE3azlzLzMydE1L?=
 =?utf-8?B?YU5EQ0lZMEs3QjVkRFIyS0dJdktIZEZxS2tpeVN6QTVLTlJ1ZEhoQVlTSno3?=
 =?utf-8?B?WG9DdFV0Wi9WbjRLdjZKVDNCZUtmbHpyeGxtejZnTmZ5RGpiTEVWcEpRcFQw?=
 =?utf-8?B?aExFNzhiQ2J1MlozNkpqbWtJRFhwMXJrVjhvdWprV21JdlJ2dkhZOGRuTEN4?=
 =?utf-8?B?b0RyV2I2QUhMd2JZZW9Jbkw3SGNhNzZqZzlvU1dhaU80ZTA5R2ZDOGQwWWhI?=
 =?utf-8?B?UG1oZWVaNnVFaE1LVkN4ZjJJblE4RmdUTVE1WlJMd1luZVlwdnE0b092dlhR?=
 =?utf-8?B?bE91aEQ5Z2x0bTV0VVZrMEtmbyt0UHJjbDZHdWtGR0VsNlBUbmlUeGpBdWlU?=
 =?utf-8?B?UDhtZFFwVFZDVUg5cmtFaCtDa3M5alNNaEhhajg5ZitNUTVOa2U2TmtJcTBr?=
 =?utf-8?B?d0pvK2ZZM2tNeXJrR214dWRuU1pXd0xRRzdZR0FUNFZ5VTlSMXduM3BHaXVs?=
 =?utf-8?B?UmZpQS9EYmlqSTE3d2xOU3owVHNDYjh4MVRmUTFVcWlOMmxXR2J4b2pleUJm?=
 =?utf-8?B?MC9LZVE1RUlkcXRhYWJYUVF3UXA3YXh3YkU1b3ZuMllQb1lGcXRNa2drQ3VX?=
 =?utf-8?B?aDBSQVNZcStNVHE4T0oyREQ0VGlpWUpXdHdaa3dOQVc2SmM5eGk3UU1xM3B2?=
 =?utf-8?B?dDBDNjZHSkttTk9Od1Nhai9kR1d1aUx5RzhyT1I5NkVKbTJHMnZ6amJjejJp?=
 =?utf-8?B?UHM4UnRsZ1lNV3h6NEM1REcwRzQzWmJHVGRHMzNBcGJJcmpXVkpxMzJBNmgy?=
 =?utf-8?B?M3BpS0szcWNvcis1RXhaRC9UeWg3eEtSUE5SVFZxNU9HSjRGd29Hc2lsSjc2?=
 =?utf-8?B?cjFJbHJ2dFVhR2RVRGRJRVNLRVV4VlpMbTNrRUpjYy9SQlhBVzZlOURMVEFz?=
 =?utf-8?B?SXF6c1EwSmhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZPL0x4dVoybXRQWVE0Z2RXUjJ1aGUzeG83Z3dCSitzZlNvWlBBSHhkeEdV?=
 =?utf-8?B?YlVQWkNRcVc2NlJkN2dENkVoVWd3UFY4YzM2eUt0a29iank3OE1wL3Uvd2l0?=
 =?utf-8?B?RGhTbDMxQ1p2Tm55ZHBkMTNmeEs0RWdYc3BCQzBzNGhPRlFGb24rd2x6Nm1Q?=
 =?utf-8?B?M2FONWZ1NkNwZFpSMDBhLzZvVVdyd1pnUmR5WlJPZFF3Y3hrSFZzcE5YYTJV?=
 =?utf-8?B?UXBsKzZtaWdCVllYb2JFU2txS1JMd0prcjh0eElEWGJqZTNhUnhwVDdDYUk1?=
 =?utf-8?B?OXNkaUp1MEhQMkNXOCtUKzVzMjBVZ0swZ0lib05HK3JDM1lodlk0VVBrcm9h?=
 =?utf-8?B?SWNzSml6M2VHZVBtYVE1aU5MU2VDVytJc0FIRkhuQlY3SXl0SklmL1VXeCs0?=
 =?utf-8?B?TjNaZjFhcmtsSXovOEpBaG1XblJkZndNclJYS0tQdURDTXpCQ0NoMU1ORlhy?=
 =?utf-8?B?YWdhWkZmajZXZDlNYk43QnRtY0dMalZia2VmV1dvbjAxOEVKUU5qSDlmR1FM?=
 =?utf-8?B?UGZkWkI3Vi8rby9TMUY4Mjd2YTFzS1hnN0x1MXJzYjZaVHRIOWZxalhIMGdn?=
 =?utf-8?B?YnNUU2ZyQ2Q0cTM1cm1wc0t0bkhoM1VSREZWR2dzMnhORkZrbURMdmhVTUgx?=
 =?utf-8?B?aHllZ2JGeUI3Y1VTNndNd3hJYnQ4bjZZRXlEVGtDeCtMQ2hlQVU1QTRLTFlQ?=
 =?utf-8?B?TGc2aUFNY0kzR3ZId205VkNlcTBoTStQV1E4KzR2WkVzbEo0ai95UEpxZE9N?=
 =?utf-8?B?RElQVFZWSlJLWUZITll5TmNrSGp4QUtxTnBEOUc2OVA5Qk9zL1pnOEN6SEVS?=
 =?utf-8?B?NzR5c1BCYnBpbytDWnZuM0tUZWh3aUFiVTl1Rld3eXNnMlp0d2FITi9nNUd6?=
 =?utf-8?B?NWwwdjdqcVhkc0ozdHhpaGtraVh4OHRyM2NNSzVGQU9HK29mdjZGVmhnS3Ez?=
 =?utf-8?B?NTZWUkxscmtLMTBNZkFkUFFqRVJoVUFpVm5qY0xvZFlKNUMrUFRoZ1NJRHlY?=
 =?utf-8?B?TlZhZXQ4NmhrOWlrb1F2dHhXQVA3T0ZmRi8zVmdCUWtzV2hFWWltZC9jOG1Q?=
 =?utf-8?B?dWJIOXhBMm1qckdGZnpZTnNFRlYrWVFRN0Erb0dOdTA4eWRIaDdQRHhlMDZU?=
 =?utf-8?B?OHcwd0pMU3NMZ2R6cVNYYXlTWFovM0dRV0xLK2RWUk1hb1Jsc2tZTGprZldW?=
 =?utf-8?B?U1Vkamgrak02WTRWcFg1cWlvNHNpVzdITHlOQ1QzaXJtL2lxZUJ1UEUwQWtZ?=
 =?utf-8?B?eG5DdFQyOURCekkzRkk0ZGhZVkJNYnJLMlpHR0krOTFSWU5OY2xFQkNBbWl6?=
 =?utf-8?B?WlJKcXFwVm1iK2pzbmFOMkR1dldpSDkyanlIK3UrSDFiN0NISlcrTmdGeFZL?=
 =?utf-8?B?YnUvSjBieFMzT2VZUkFRN0NqTWZBVU94ME5NQ254cGZHU2l4YU9VaWZDMmJy?=
 =?utf-8?B?dExjUEl3SVRuNXNKOHlSaUllN0s3NkFEMEVtOUdZMXdYZWZwR0Rhb1E0OWdz?=
 =?utf-8?B?ZXVEdkk5OVBKanpidEI4eUE1dXBxd2s4dG5YNTJRSE5nS205RDdIWkduaVIw?=
 =?utf-8?B?bzRGbW9ZWUxFRjhEV3NyMzZRT2pBakhkT1hVSC85YTJYRERNN29nSEREa0xq?=
 =?utf-8?B?c0lObnZYc05JNzhRZkpTVkZ2T3J6SWpWNnk4eFJSUDJmTWNUc2RjQTNaS3dH?=
 =?utf-8?B?Nmk3S1lndFoza0F6cUNuMTFwN0piZG4yeVlacW02b1pZOUEyeHRvRnI2Sm9r?=
 =?utf-8?B?ZGpIbEV6dXJMUlYvV045V3lYM3ErcDRVK0JFSzV4MU9XbWNqbWFROW1WYWVr?=
 =?utf-8?B?ZDZJUkpnZlBIUnl3QzE2REo5TTIrYXAzcDVDZFZYZzBuRC9YU2IyK2FQVUNV?=
 =?utf-8?B?bXZ0cVJoSUVZWFNxaVlKS2JpVnJhOXVxOGJRNjNidThYTTdiS2U5RnJ1V3Ir?=
 =?utf-8?B?OGpWaTlwMFFsbmszVStHSUVQbHZvQ3RoejlBcW9IS01yanpjQmtjV0xYYlhi?=
 =?utf-8?B?K1ZjdjhaSmpOT3hmTnZhVnJWc0k2eEhzcmRDbzdZeDJ6OXZ4VEQ3c09EOEJi?=
 =?utf-8?B?SDlaTzVrWi9uWnlsalRqZVVFZ3pjS1kweDltRjBSM1NqajlaeExMOW5CNkFP?=
 =?utf-8?Q?5ly8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6212823-6f86-4743-97d2-08ddade49321
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:18:58.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cy5SP7bPJxDBUSUvRgqsIX8Z1t6thQHzvFOfWHSZcX0swFZaqYe2v0ZntluUbLS/OElcNec7wtaufQRn88Cvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5086
X-Proofpoint-ORIG-GUID: G6GKmtuk0hTK9k27eE48aalrkkoDBxuo
X-Authority-Analysis: v=2.4 cv=H6Lbw/Yi c=1 sm=1 tr=0 ts=6851dbc6 cx=c_pps
 a=8zEn50EW7sokACXIljcC9Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=rwi0KhHAr8iyUkDIzB4A:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfX1bKIgd7gMx+P
 QCUn3iCWHHEHrNhs9xkWLDAMaeBjVTRXjAPRAhltQjF2CAh2UQzI4KXagnG3yoGxTYh+n8pRXbm
 3lN/F+Qrx/UnrzY/DxuH756rkMhsrolLhkVJsnnDuwCyi/KSuslWv5yRp9Xzo0DE1yyak8QjdKT
 Ods1hY2AGGWotyPrnnyHWfRcxSg8z9hbv7T+b2MFfS/KPvy8EDWQqpsmKmmk63QFa3LbELVRt+c
 pEOvWKBitGrYzhnyBmv4JV/xluxPd6FzBfcmTB7KUmYIT3b1aN+T2bYbssJ1xdpWU2bWFUu2LsR
 yKqbhhbwGwxMqfPCtZ/miSma9YPq87FA4Te7JcUBLu8oOEhLz4wo0qNnF9sxvhuUAPesP77fZ/v
 675jP452qK3ZEOL8JlRuSm6s74qDoCX/ppSWcaZnyvHfGXmw1ROghOE4yKPIKGjIwWFMOIwI
X-Proofpoint-GUID: G6GKmtuk0hTK9k27eE48aalrkkoDBxuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KPiANCj4gRnJvbTogUmFkdSBO
aWNvbGF1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBTZW50OiAxMiBKdW5lIDIwMjUgMTE6
MTQNCj4gVG86IEppLCBLYWkgPGthaS5qaUBpbnRlbC5jb20+OyBLdXN6dGFsLCBBcmthZGl1c3pY
IDxhcmthZGl1c3p4Lmt1c3p0YWxAaW50ZWwuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnIDxkZXZA
ZHBkay5vcmc+OyBOaWNvbGF1LCBSYWR1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPjsNCj4gc3Rh
YmxlQGRwZGsub3JnIDxzdGFibGVAZHBkay5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSF0gY3J5cHRv
L3FhdDogZml4IG91dC1vZi1wbGFjZSBjaGFpbi9jaXBoZXIvYXV0aCBoZWFkZXJzDQo+IA0KPiBF
eHRlbmQgdGhlIG9yaWdpbmFsIGZpeCB0byBnZW4zIGFuZCBnZW40IGNvZGUuDQo+IA0KPiBGaXhl
czogMzE3ZDA1ZjM3MjFjICgiY3J5cHRvL3FhdDogZml4IG91dC1vZi1wbGFjZSBjaGFpbi9jaXBo
ZXIvYXV0aCBoZWFkZXJzIikNCj4gQ2M6IGFya2FkaXVzengua3VzenRhbEBpbnRlbC5jb20NCj4g
Q2M6IHN0YWJsZUBkcGRrLm9yZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1IDxy
YWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQoNClBs
ZWFzZSBpbXByb3ZlIGludGVybmFsIHJldmlldyBjeWNsZS4NClRoaXMgcGF0Y2ggaXMgYSBmaXgg
dG8gYSBmaXguDQoNClRoYW5rcy4NCg==
