Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF28C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 04:40:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D12FB40265;
	Wed, 16 Sep 2026 06:40:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 332A74025A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:40:51 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G1bdTR3154633; Tue, 15 Sep 2026 21:40:50 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020118.outbound.protection.outlook.com [52.101.61.118])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gq9c8m6cw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 21:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSPot8++fFW+1WpFVv7Dee6wJIOkYczp1OV6ddrbiMG/pBY1OsP0znaiie6P9j67AkFI50hNiVSs4d8Aw4OR/Gqp1t4qfEUSOBF7yWuoCM6aq6E4CI8846mRxqWJG0ynmKecUj1XDe6v0gh4FZwLxJFQqVAXMKiwhhyqEgJafejLjxSsDqlR7jFHSAeT1gRXoPBhMlJni/wjjnBIFMHjyCiRPZ1KC5ZwPxReD28bPV8C4j49rYsAOoXJ4cZy8V0EzwASjiIMmUWda2Nnr7z7rGcOv8yXqY/eOfkW/GHIwGxWNDh4SRljfSWXQuIPNyB7GeL8PJCLXE1tPxo1/lmqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZV/xqgJ/4KtqAeyLpi4Tcm2zTFNfOq0MR/BdrirUFU=;
 b=lp/n3Je0XeitV2yQyaZP1HG7NgMKxjkrYw3jQS3cV6+pQ3bXWSJWR2VqM53go0IZJ96zp63HjFm1MPrbkckKu11CyXPHJzRy6GmBEWQiC8RWqbUfER9FgFjK/KHNG+e7VDW2xYo/Hz3Zlhd1QBaOccY2fcDOhxo+3zWVjJqNgDWPjR9/dZ5uVOLvqwIUb8XzFJdo3BUHifWEi9tPMEWysk8N4phFoougqiyEwJR1wHUfkrJJzjsGy7G32IGrM+TSN6rvLB1Mz0ebJ9l0dwD0+7Csjrf/pSMTJYaa7tOkhOguJy1JT3coy7HwlCqXXL5aNSvSB/gI5hcYyMib26mEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZV/xqgJ/4KtqAeyLpi4Tcm2zTFNfOq0MR/BdrirUFU=;
 b=YPc9yHqfwIxo/sZOdKiWy4MYWC33i+AifFHEd3GqXY680bNzfJ8GdcKjgLkcG0pfM0w8eLA0xz+wrjE5182ciUu4ahNHvHyD0nRA4Be1elUy8PmZN+qWQseo7pM8Z74cZjlPocV9sPsAkQ47JuUD4ySDsSi45d/HOzbeBKwhJbQ=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by DSVPR18MB988638.namprd18.prod.outlook.com (2603:10b6:8:41a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 04:40:46 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0382.012; Wed, 16 Sep 2026
 04:40:46 +0000
From: Ashwin Sekhar T K <asekhar@marvell.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Topic: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Index: AQHdQ04sGXQ4kNNvFky3nezGJBPtwbbPMj/ggADS4oCAAJvdYA==
Date: Wed, 16 Sep 2026 04:40:46 +0000
Message-ID: <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
In-Reply-To: <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|DSVPR18MB988638:EE_
x-ms-office365-filtering-correlation-id: da829c79-ab04-4a41-a496-08df13acaccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: DF+3BPIImNFFhOYnCqiP/dShX8AfLiT0JTQJhtB82O5PVdym4ddtQSgBX9iGhcu80ml/TaUpd0JKpLL/rfdCfrhMMaKfd+8L6k9tgq6x/bp9QB69+2phnl97o6u3eNAtQosNIfpOZAJ9+1dKByzHsW9I0cEVv3YPyVgBUo1YNApkHd/Ir8Va40VTfl5aN1G+Vdg7f66R5mwWY3l7JlYnxNEpJ6fbJqj3d7PelA4TZQXJ3PhcL6bFT3Dpn+ga8DCZr1EPgd+FOgg/C3aCC4iM76fa7Qle5SlQ0Ll37aaLU4dC4J7kHWVbkMR0kd64gzaP6wLXakV6uw/PLN0N3nH9l0aRiDnkNpN3vv/KgRlSTntewVrM/l9GEq0t+qgEFphk3ey8K5K78WZbAHDYAxpu227hwWgkGFMKw/LESmLO/8QJr/cwBXHTKAxFHkatt+1FABBkKN+i8mXmhY4fQwtNtG126P/BV3BQ/5byDymC4BjqxGRr4nMsAxnEzZDPXQWiL0bGa8oOjoTHFzjPN7ThtxEesOzJZZLViVX4JuacAsWFtiuWlp5f68j4OM3mJFCnnjZNckZS2fQFxb3IBqZiyMohN/Qb5ShcokbyK4WG9u0oUGNgh2wcUKEAHpdbcZOaO6Sy3W9nEW/VGJjNGj8mVs88D10GqqBRNJwrs8kOeDpj6OKeIfM/OKNIAk8Wqa/JIioKAgENhbAWgMHtuxAp+wqkQBb745ammzW3oQOfJBw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9uZWJJdVB4LzhoZnZkY285WGZjaHBoNktrZ0JxUXZnV1NFUERlcm5iQ1BM?=
 =?utf-8?B?dU91c0dTRjFPbCszQ0FrSnAycU5zTll6Zi9NVzgvc1NxT2ZGQXRWOGsxSjdv?=
 =?utf-8?B?MDZhbWFwYW0vdnBub2dsYXdvZ2FvVTZOUjIxYzlCMDlsUEF0dGU2VUwreUhy?=
 =?utf-8?B?enR6MkdGbFBpait3WGZVTzh2dm5rV2ttaW9Vakk5Y1hlbFFsVENOUmdjT2FI?=
 =?utf-8?B?QWluVjIvY1hSTGx4ZU1UUk10Tk9KU0NmZDFER0JFOU1meXhSZWlUSTFnQ2Vz?=
 =?utf-8?B?Nm1RUGtIZUdpaEdZbCtFRkJHUHk2TzlVNkMvMGRRYW5NSGF1Umo1dWFWbnhZ?=
 =?utf-8?B?SnBTZjA4eG9FZ0hTclIvSzNZaWdsczE3eUtFRkFTRlhKcFNrdkJOZVBaazI4?=
 =?utf-8?B?TzhZZTVwbDgrUVhwWWcwOTg1S0NjbU5EU3Fqc1NpVVBUREE2UXZONGMvYXc2?=
 =?utf-8?B?QWF2angrandMTGVKcGVacEY1UHFtMkJHYUsxZjFHeFNnQmhjL2xFMy80Sk53?=
 =?utf-8?B?WDV0V1A4blJXRkU0UUVDeUtBUTVYd3lKS1lXOVhPMjFTemhLRkFMZEpGSlJZ?=
 =?utf-8?B?Rkx1bjRpS3g5Uk5hZEJIc2Exc1VhbCsxZ0pFS0dMcnhWSWt5WVJQTnhOaThO?=
 =?utf-8?B?dkZtQWpZYlg5My9TSTAvbXhnN3hGUC9JM2Q2d1RoSHV2ZklVQnNyWnRXYlY4?=
 =?utf-8?B?ajlJb0hOWGRjLy9JazhPMERqdllpRyszZHB5VXlvbjRxVlNhd05FdnpPV2Ri?=
 =?utf-8?B?cGJTdTRYU2grU1FFRE1qcFF2WG1sMnk0cFZRS2RBSUZCYXpqZGJ3WVVGUlJD?=
 =?utf-8?B?cElaOVdyQURmYjRkMmoydFZrMnlmZWIvMS83QmMzUlpOZ2UxWm5wUlVKemNq?=
 =?utf-8?B?TTZrRVRtZ200TFhhNXZ5QmdISjF6ZlRXT0VKTncvcTdDaWhCcTMycFY2RHJh?=
 =?utf-8?B?NjNXcU5LSEowQ0ZlWWVOMHY3Z2tMM1Q2cE90aXVSM29heDYrbkJmRlZaNmdo?=
 =?utf-8?B?ZHVBT08wQkloNWk4SFdiOThnckZkZHJtU0tBT0xEK0lJRFNDMTVQME1FOS9X?=
 =?utf-8?B?YU9yUko5OHIxYW9TdXN4b3FuV3FoeG9FV1E1dXBEQU1OdC9CR0N4SC9aTmlp?=
 =?utf-8?B?VnVXQUpyMjRtZEpyeTlYRWlvbW0yaFNOQVg2RlZ2K2hFSXN1REl5dGVmRi9E?=
 =?utf-8?B?MUdnclBMSEdDeG1vYWNseEFabW5IckUzZ0h5dDlwVTlQcVhQajA4UDBpQkJH?=
 =?utf-8?B?OWZudCsvRWJFT05XbDdtN0k1NDhnKyt6WVpmZElDc1V3TWhNcld5ZC80aEdp?=
 =?utf-8?B?Y0xOTXlFekUxblpRSVF0UnJqclJIS2xSZ1hjTG1YcE1CMlZEblNIb2x3RFg5?=
 =?utf-8?B?Q1E5ZUowVEp6UUhYWDJIRjdCRTJIN0tHTnV1VWhSbyt2UHJjRmtUUFZnTVBk?=
 =?utf-8?B?MjUvQVd4WFp0V0tZRStjcDdOdU5QWkZRdGhjMGtoa1VTVlBRblExOHZWN25R?=
 =?utf-8?B?cGl0ek9JTm5mSmxXSUhBOCtvQ1ZpdkpoZ0pQQ1M4YjBVNUFPWEMrQjhlcnZX?=
 =?utf-8?B?Sm55OWpoTWp5cjA4c3RkM09WaGpHVHZuZEc3V2thT1U1MUtkM203RjQ0VlBl?=
 =?utf-8?B?SUVPcFVBV2FFVjFtSE1yNTlJWURnbzRsaE5wKzA2Z0J4cWlPbXh1RzhNQTNT?=
 =?utf-8?B?VDVPTmo5dFBhQnhrb0IwTkREMHVTNjlMK3QzZXZuOWkxUUo4RjAzSzE3WWhy?=
 =?utf-8?B?UEdVbnNuSFJtSlFMbWhUQld5WjB4cWkvdXVMM1JWZ3UweXE3a1psTXZnTmUv?=
 =?utf-8?B?RG52bkpkSGZuU3c0bHcxVEQrUm1lR0E3U2JzU09IYmJvbGhhRG9yMW1HbnNi?=
 =?utf-8?B?aHlzQmcrRWhIcDl5RFRqbDBnN01wRStjeS9Tb0xNa3kxSlFLZUJLeUhSSWxB?=
 =?utf-8?B?a2JFMk9aZmc0WCtPYzIxOUVYeG0vSWZFUHlFYXpTMkZrUlNrREl1YUpaVDBh?=
 =?utf-8?B?a0dkNEdWR3dmUmRBK0NoaGozYTNESU9mM1Mvenh4TEdOZXV1TFZMd2g3OWls?=
 =?utf-8?B?ZWxqNHBrb2l0UXdOY2FKdTVsM1VKOFhFTzRac0NUVXowR2FBMHVRcGhXYTRE?=
 =?utf-8?B?QS82cVJSWVVxWGNINmFKNjIwMGxUSng2cUNpRDNMeU1DWlgvcDVpajhuTGIx?=
 =?utf-8?B?VDlGbTVQa3A0T3Q0dHlmVlNkQWNldjdYQ2FMMG5DTWpkWmxhOXhsOHN0Unpz?=
 =?utf-8?B?VC9rdUI4eGNSdG5tTVpvZmJDNWlFZWExUzA5c2tyUEloeWtYdFRZbkJVMnJ5?=
 =?utf-8?Q?wNheChtt/rL1IAP5YS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1msBtDyTFGTHPmU7kNP51kp1gQwDDokmRQaavslt3zB6qPE1hpLz8c07t/yCKz73P38dOZXrbVZiBGOCPEQzL8LFCzxUHEvrljoE6DUQuaRKPCIa0rzzLjd5iEINvaA4LIOvjb/3vx/cQafFY01TtflPzUKVaZieDnRvzrCgZehWcXbuChE9Lev48QAfaQTOX4N89Pt9J3/lWsIC2HIEXLkgj8ZR0wKSex558gfFfeEyODEoSzwKvrf905TQAUuj+x09lpbD1RJJJd0vasVg/rDNctROicUn9KoNg0wB7id87uPFFbNJbBm1RWlWWJwE/RpKil6Wrjikbv6MTlKc0g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da829c79-ab04-4a41-a496-08df13acaccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 04:40:46.4130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoSNv/qeOOYbmQ0kceETqFQmyuR2vEhMwEQhg8H0UuBrxbvGP9vwhER/R7LUH5K2RH3axoSh76/TNTWm4W4l9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR18MB988638
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA1NyBTYWx0ZWRfX8QUxEcdBd1tS
 4TwMbSYRliUcv+6MsiiXr/3+8ba4bEm9Jn6afPBtUFqFXeBTEFqb9ajqINFC4tPujT7d65wUGqw
 UVrKuDSFsI9mbFQu+siWrJIPBIB6v+hiaSixc6BrM0qWPnByZ1Y/sPM8N2HnKOq3cHYFmI+s67z
 uFa5sfoXuvlS1/mELljVDuvvsXXYcE1CosT4IcsPoA64iXim1l21YZZUixAjMxyOrPZwrq7XO9b
 +LjFmA2MNletI5xjZllGfU15TlsbYdOPCfaIw4utkgFLoSYdGml6+N41mheirvh6kFq8ncv6l27
 5WTW5j9MzICU/5BQzY6ZQ5N3mPbJWSD/I7TH0Vq02yy9Lyar1ZWc1/afKYlJihyQfTd64A/n2V7
 zFbGEMoEBRCzUiw+BQorqHWEB+MavN8h/TnPURuTW8kSRLRni4sR2HMBGtgpoIt1W+6OnrsgMwA
 9YSc3WfkcHPwPaq6lEQ==
X-Authority-Analysis: v=2.4 cv=R/2WitRX c=1 sm=1 tr=0 ts=6aaa1dd1 cx=c_pps
 a=fMm6ob6OrxBSxP8bamoiPg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=GxfWA-Yw2mYyfGzjGRAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _xyRVGgysYhyH1NGo93iBHWCBwhIGXAV
X-Proofpoint-ORIG-GUID: _xyRVGgysYhyH1NGo93iBHWCBwhIGXAV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA1NyBTYWx0ZWRfXzNA+fgndhOEH
 DcBKiofAb555NFB6RV/qhy/ynphneMKi5MbydMvNfYHofmi9QtLR18OIFTQkcq9Hoqw6ydaDOIv
 QM3azhXrnUvLD0AiVpIZl6xzbp/YNB4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

SGkgQW1peWEsDQo+IFllcyDigJQgdGhlIHJvb3QgY2F1c2UgaXMgTkRDIHN0YWxlbmVzcy4gVGhl
IEFRIElOSVQgd3JpdGVzIHBvb2wgY29udGV4dCAoaW5jbHVkaW5nIHB0cl9zdGFydD0wLCBwdHJf
ZW5kPX4wKSBkaXJlY3RseSB0byBSQU0sIGJ5cGFzc2luZyBOREMuDQpUaGUgQVEgSU5JVCBkb2Vz
IG5vdCBieXBhc3MgTkRDLiBNYXkgSSBrbm93IGhvdyB5b3UgYXJyaXZlZCBhdCB0aGlzIGNvbmNs
dXNpb24/DQpFdmVuIHlvdXIgb3RoZXIgTkRDIHN5bmMgcGF0Y2ggaXMgbm90IHJlcXVpcmVkLiBU
aGUgb25seSB0aW1lIE5EQyBzeW5jIGlzIHJlcXVpcmVkIGlzIGF0IHRlYXJkb3duIHRpbWUgYmVj
YXVzZSBhdCB0aGlzIHBvaW50LCB3ZSBmcmVlIHRoZSBzdGFjayBtZW1vcnkuIFNvLCBhZnRlciB0
aGlzLCBOUEEgc2hvdWxkIG5vdCBldmljdCBhbnkgc3RhbGUgc3RhY2sgcGFnZXMgYmFjayB0byBt
ZW1vcnkgKHdoaWNoIGlzIGFscmVhZHkgZnJlZWQpLg0KDQo+IFNvcnJ5IGZvciBteSBwb29yIHdv
cmRpbmdzLiBvbiBteSBwYXJ0LiBUaGUgcG9vbCBzdGFjayBkb2VzIG5vdCBnZXQgZHJhaW5lZCDi
gJQgaXQgbmV2ZXIgZ2V0cyBwb3B1bGF0ZWQuRHVyaW5nIGNueGtfbWVtcG9vbF9wb3B1bGF0ZSgp
LCBlYWNoIHJvY19ucGFfYXVyYV9vcF9mcmVlKCkgY2FsbCBzaWxlbnRseSBkcm9wcyB0aGUgYnVm
ZmVyIChOUEEgc2VlcyBzdGFsZSBjb250ZXh0IHdpdGggZW5hPTAgb3IgcHRyX2VuZD0wIHZpYSBO
REMpLiBBZnRlciBwb3B1bGF0ZSBjb21wbGV0ZXMsIHRoZSBwb29sIGhhcyAwIA0KPiBhdmFpbGFi
bGUgYnVmZmVycyBkZXNwaXRlIG5vIGVycm9yIGJlaW5nIHJldHVybmVkLiBTdWJzZXF1ZW50IHJv
Y19ucGFfYXVyYV9vcF9hbGxvYygpIHJldHVybnMgTlVMTCwgY2F1c2luZyBwb3J0IHN0YXJ0IGZh
aWx1cmVzLg0KSXQgd2lsbCBub3Qgc2lsZW50bHkgZHJvcC4gWW91IHNob3VsZCBiZSBnZXR0aW5n
IEFVUkEgRElTQUJMRUQgaW50ZXJydXB0cy4NCg0KQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHRo
ZSBleGFjdCB1c2UgY2FzZSBhbmQgaXNzdWUgdGhhdCB5b3UgYXJlIGZhY2luZz8NCg0KVGhhbmtz
DQpBc2h3aW4NCg0K
