Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D70CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A5A4025A;
	Sat, 20 Jun 2026 20:02:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 965E440151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 20:02:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KGu6GQ1013249; Sat, 20 Jun 2026 11:02:55 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023115.outbound.protection.outlook.com
 [40.107.201.115])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4evtcb5qx6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkvF6qbZJ7wzM2ViHTy1q5IqwkCFA3+MSdQSERCBVLn3dmsAFGjqljC8JXfpp7gdGwvZGXP7n8Qlw7dXE3fjFfNKVKZjaaamoAjmRsgmXvDrBZwgrm+6sJFNZ+OQbIQrrRwh9BCuaL2kFiRkueoXrjRLARQTzX0EQPf+cS5+hAHxLH3A/nUQQ9G/k2T18g1Hx+V+4i6/9KCeevMR8ntt9ohOg67Y17w03VBQb4Y0HPg6rz2A/HzW/WKZKGrfjHHBkUNo/jc5Trh/PhBXOHjHADqWU9X/I8OP8/y7yqldS9PwhrYxKeYb9bAjGWabimIfO/4e/31WBFcwCD4mn6n7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI1Dyy9bfLNqsNCMFOm1afbmePzPtRH2GZR2rwC9vjQ=;
 b=JkmyVOAQW85n7ymmOuI7KnhEkIHoBkilpom07zBRXP2neqh1aCFCVIcKTfo4ggOFpWOweOXNFYmTQinUehkLk8ZBT7Y8IbGT3zuE4nMxEqrf/NB0uqU1+ufHNScluG0p9byLmPw8WxfOGrX+xuNk64vr+7NNBB6xOmQ+xmaMjUdLvOsMRtUXnLUKe1TSeu4kgJRUYMHKIIeYheFVR4CNDcHyrvQ7nl/+GMJbCniAx8W3QktRXJxQCKigAJtEptW+9Lig4a2QEU4V3zyTc1JJiyK64d0Wq65IWnhHrVBRnEpbOfupyMcPN+N3HPJj3QWjHaed4in9zn18So9vYFdV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI1Dyy9bfLNqsNCMFOm1afbmePzPtRH2GZR2rwC9vjQ=;
 b=NXVwQS/+4NF0W/kH4IaebvIVN/U95cHK1s0SxSq2/zUVKO08rRd8wL2GE3I+LwQqHvkTI0nO1qLS2rAUXYHol/3+y5h0vU9TJP9JiOjDcYZxqkO8dp43CbIg418b6RZmKPb7r6DIKxIRRv8oQAshhZF+UYu7W+6l+iisCAlTRFI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB4290.namprd18.prod.outlook.com (2603:10b6:610:ba::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 18:02:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:02:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] common/qat: add asym crypto disable option
Thread-Topic: [PATCH] common/qat: add asym crypto disable option
Thread-Index: AQHczapDjsnotEhzsEK9XWUE/3TeR7ZIIHkg
Date: Sat, 20 Jun 2026 18:02:51 +0000
Message-ID: <CO6PR18MB4484FDEA2418298DD19335C8D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260416102543.133175-1-radu.nicolau@intel.com>
 <DS0PR11MB745842CEBFACEDBA05C1CE6181232@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB745842CEBFACEDBA05C1CE6181232@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB4290:EE_
x-ms-office365-filtering-correlation-id: 46d3bfee-4078-41ef-00e6-08decef62595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: tBWung7eY61SpRu7AtWhYyLth26V1AAUn0Ht652J3o9RxJurhk0IGOly8SmyVmqWPoRe/e0nC2EpS6AY76u/ViBDZfPz8ShTNtqG8YZFJHW7j8sC0XcVqmxpdbyTnkZHsglGEcgoZSl5lHDFOVpx4X5twcU8Rwy0P9xyUCa+8mpH9dnEddSsh0eGo8YxZ0MOM3CFNxo+CxXEB5CcMG/S6NNYm8ydAIHx+HdsVLwXSmYfAkFVUDtO1dP4rTIIcB/aMwimfmhz/igWzH0moT55FvKcqBh/E6HZuZDjKoIxaEaD7vmy3uQy/SLVK/vS6reR+zd6dELrQW7KLNjcpDtdE9KQeiXdw4C2k47f/GQMGvhC52D53mZ5XLRZd/1hggDMQvIAEJEAsuuOBjM/zKpyJE7ZTNhF26YhhUd2myLyAijd8cvFOtRYpIJhFhmtrPLb/JaIPvYp3x+d9cOjzg/nA6ScVkBSie4TIBzGMq2wvZ9ifCQ+ukqo84/94At/mGuT4iR+LUVpXFN49ij4jCVEepgJ4K+WIN6BnSUhNaXySsUJQKbqYrl5ygTSwxYfUNEcpvTFGClWbqCjSL54fIQHJ9JhFE8IbuwY3DFYTM3Gee3rHrQ6jVswefCGYcJCWdZ31IVfTGit8GVddzlnO/EEbcSiY8ev/rBLahnLYbSitmIbxG68YGX1aCoemJpmf4EpohCLfrGgyVHub6wbyS/2bHhMtyv5xkpgg26su5s9MfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3Y2YjZzQzZMTFBXaGVJdnBBU2c4R0Qyd2cxcUgvd3RHaTBRWS96TzErN3dB?=
 =?utf-8?B?c1NZYkJkcXAzSWt1QlVFWFMrOUlEcCtacnNEcXBoSzFWZ2k2VUIrU3BtUHVp?=
 =?utf-8?B?UlBqczNpKzVFdExCMzVjR3Q4QVZsM1BZSzdnekJGMHVjSjVvb1JNSkV2WGZo?=
 =?utf-8?B?WDIzYkxRSGpSWE1nSmR1QS96MHZVVmhTTnBMSW9YNXVCSUFKNUh1eDNhZWwy?=
 =?utf-8?B?amFWN0o2Vkc4VzZ4L3IzK0RIVTFYVVAvODRlQStGVStueTBpUmtCSVZQMVFa?=
 =?utf-8?B?ektRRVByUGwyYkJmLytUcUtHd2JNbkthb1NUVTl5bFhTTXJoUmR0U2hXMVRr?=
 =?utf-8?B?U2xTRnFQMFpLbkNOR0d0eU1lekhsdDMvUTJuNDdTbkFCMzRmZ1BuaFpCdVRV?=
 =?utf-8?B?b1RYcDBDSjkyY0dIMlpwQUtCZktLeXpwRXNFamgwZE51U2pYZzUwTXhXK2JT?=
 =?utf-8?B?Zy91M2pzRVVVdHVRSzBreklQUUJHZWZmVjZyYU5xSndwM1FsU3ZIbE1CNFIy?=
 =?utf-8?B?VjlnaERLcllKbDdkcWNGT21USzk4OHQvbVBnaVhqVlBCdEZIRUk2S2ZoME1H?=
 =?utf-8?B?eXJZU2txT2JzR1hFVmZqWUs3UjI1bTE4SXZEUmo4YU53MkFKaXNwY0FRQUxs?=
 =?utf-8?B?R3IvczhhTEJmVjVqdjhIZFlsdkxNRk80R0V3QlZHNGVFbjc0UXdZeGlzMEky?=
 =?utf-8?B?aUM2VEdRUDJvdVNEaVk5SVAxbmFZT3dPS0JXYmZOSkFSRDd3ZzlUR0R1TjVl?=
 =?utf-8?B?R0c0NWVoVmV5VVdUZGJGZExCT0l3cXZpK3gwSjFHbmVYWmM4MzVLNUwzS2U4?=
 =?utf-8?B?VU5JZDB1OVVZTUlKRC8vb2FKeTkvNjVHUTF2L2psRFhWWE43aDdKaTZZbEFZ?=
 =?utf-8?B?U1J1WGFoNmFnNGNDQWFHMjJCNHlremJsb0RkSFBzTzMrV3kvUU9lY0EwdDIv?=
 =?utf-8?B?NGh0UVJuMDdtaUNFWnZJbmFaV0xuLzZuNzI2c3dlSTUxNGcrQ2tVT2tOVXJ1?=
 =?utf-8?B?cmdJRXpQdjBzWTVtWHNUK1ZEYWxDVGcxZ3RZcEVXUVIxbXh1VDlEWUhOWmZ3?=
 =?utf-8?B?UTlYWnp0N1JrZk5jV09ZS3VWbnZYcFBqczlMaUg2SldpbmlkNzF6eFFMMnBT?=
 =?utf-8?B?TTE3VEZFUFc3aWk5QnFCd2NwakFyU25adlpTVnVFTU4ySEJ0aFJIWUk2K3Y3?=
 =?utf-8?B?M2hibDJiSXlNUGVlNUFVMHo2dzNYMVh2cCs2S0dmVkZnTzI5OHloWjhCOGNl?=
 =?utf-8?B?ZkliMHB5MUJKK0pGZU5WbVJsdlJMemJQMnRzYjNUaHQ2K1pTOTRqYXRBMTJV?=
 =?utf-8?B?V1Zwb0pjd2s3UFBZOXQxNFlMUmhVQlFobEtwUFVVZ1pBeWVkRnAzYk01SXNy?=
 =?utf-8?B?bkZ0WDlORS9WNHNDY2xiRjB4YklsQmlJbm9za2hwZWIxZmNnUGpwMmhwWVg0?=
 =?utf-8?B?eXdmYjhKdGVPa2hmai9acDkwZDUySnh1Z1lGYzJJQ0NLN0lUdTRzQXpMTUJi?=
 =?utf-8?B?eFBCdVdrSnZUTDM2RVEzU0loQkQ4cDF5QkpjYlZEdW9Tc2xTdzhldGt5TmVp?=
 =?utf-8?B?ZDNjWU93R3Rra0tQTkVHWGF6OWU3RVNGdlZjelZmSHlNSVIxQXFZUHQ0WWJa?=
 =?utf-8?B?ZXNYZTJqUEx5UHZra2ZCVE1wcnNHVWRvS1hrMFBHTzVmR3MyOEhYUldyNTZR?=
 =?utf-8?B?NWtzUHZFYWY2OFdvajhGUTRzanZuZEN0Ty93anEzcitPR0lOT1djd2w0eCsx?=
 =?utf-8?B?d3JMU3lkcWQvMG9ZS0VRVkdkNjBFYUVYcG9FOFdQNW9ndXhYNlFoODdYUGJl?=
 =?utf-8?B?d2FBV2FOenBjUWc2SCtYckV3WjlmU2ZTd29lbWxpQnJiUkRhZmdIR2RCc2V6?=
 =?utf-8?B?WHBPKy9KNDNoOEdkejc1MFJqc0g2K3JKMlBSVUpmNmNhRDA5ZEt0NXVTQjBl?=
 =?utf-8?B?RzJsb1VDdUdhT08xUnlDS21kMVNlcGIySk41MkE1aWhYcmZiVE1NME9DdDJi?=
 =?utf-8?B?QjFBMnhyVUlRTXNoakJRa3hFaFFRbmVaTG1WTit5R0NyMFFxMXRwa3RRY2o4?=
 =?utf-8?B?SWtSYmE0Q3NLZ3N4YjQwVGJqeFlndEZ3Q2QvWG10aHR3YjZLQUVFc2oxUmtU?=
 =?utf-8?B?WXp0VnhEaDRHUHNXV2cvbHNnOVR2Z09TcFltOHlnS2ZKbjBPK3lBQ1lqZHJM?=
 =?utf-8?B?MmxCTUFGRW9LSjBDUWJ0V1RIY1pOYXdjb2M2TXlpZlh4RngrRmpwd21taFA2?=
 =?utf-8?B?c2dHeDRXZGpQTDFOZUE2T3g5a1BtbktLK3ZNY0ZkQ0J3dUdBSStVTXpWZ2hx?=
 =?utf-8?Q?+A7uTUKdmB+M5W5hvo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CmfvPkdAPQ9mKGT2BhvFg6dXEQpy1Sk9aYXsR5ZfJ2QUGnhsQaxov+8UXRB02YKmitdCQInkDxHyp8EAbwLv7kVbDPQ/KtiIE8Nlcn9Za6QiJhCmUUKRLFSMO0B88ouOjJmv6EDRdMNsbjg9SF2O0RredmwyFsnzQFrQJG2IGKpqP7gBHd1izQiSAE+Ec3A9jNpCUXn5LhlhlyCs/WJbV0Kz7n/o1/Juo2uiPLSJTV7hcbTIS/uE3lBREy7pXzpdJrM5pYvB29urmuBsex81U0gJLDn0vXj4duUqNCNtB3l9aBioJDG2bXcM/gvh6hdNwUIGAuGtzH/nJkXoGSdkAQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d3bfee-4078-41ef-00e6-08decef62595
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:02:52.0803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IajR+FZzX5bmDBzmQiHEN4VnT7e41N5WYr+jTvdumLoCuhp0HY4u8B2+fI7Zied3dl6BBRfRbjSr0dPIc2SXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4290
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE4MiBTYWx0ZWRfX0FG98tJ9IS8p
 Qq0I/lTk7gouYb8aL9tGawe9SJDfld/CCMFYFZRhQHxanyyCJZTTQNka7KT3WOleg4oYmm1A6Rt
 CyJ2mm9WsPYlSnZqh9OdL5KI2wBVafk=
X-Proofpoint-GUID: J8uAAv8FpvXqahf_J4tAJfffeTz3WDS7
X-Proofpoint-ORIG-GUID: J8uAAv8FpvXqahf_J4tAJfffeTz3WDS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE4MiBTYWx0ZWRfX8TCwv/1NzZe3
 quD59YiaOrwZxaecd24ZxapPE4aTP/HLKpciPyvrlQLMz6/exOgBTDV6mbyZBrC5e6GHv5LsUxg
 CxZIYaoCBCkhKHo8TtqHDSDNHASMHgRvRwsCwSoaag1BHeEODgNfY+hKmKA1sumnW4J+w5aPFnl
 hQAnpjqwP01JhuMyuwicQ/NwAvRBJrXZRDhp1Fx20ly3SBOl+aow6Wvw8iKZ2GSethZWaAYZvtm
 H3fgC3Igjor24y9wmgnfdct9bL8TCUcL/BBzigRnFBvZkXp9Hrr5voQaLoCZADvLolYMV5Stvcd
 NiQXOVu+1qycHndh7laz4TKQUQaHqQgEP3UfrCbrzwoWVUUfde74djeLK+pbJHJFFiUAoLeZdPt
 jTWPNRcWi3JolRDJXht+0IiHuPC+oq4kn9WwBz3oV5Xm4m1ggKaxzshD9nwZLqhAj9+gGEdFmxE
 9xgbm4Qfzkvg7U7aM/w==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=6a36d5ce cx=c_pps
 a=8YD3JtO18OBpAIphJ6JiAg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=jILgV7x5WoZSwjIC4YkA:9 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_02,2026-06-18_03,2025-10-01_01
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

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRrLW5l
eHQtY3J5cHRvDQo=
