Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AEFC982CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 10:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B47140299;
	Thu, 17 Sep 2026 12:51:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 47DD3400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 12:51:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9d9N32658064; Thu, 17 Sep 2026 03:51:36 -0700
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021093.outbound.protection.outlook.com [52.101.62.93])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr4602v2y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 03:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUj3GaVeIXRMl8hpO58fKVOSJZs0u2wu1A/2Lc1Yj+ioKTDIhYLBEonpxt36aEzoWQjVw7a5LXn7xlF6ikdXz482XAtQPmS315lu3UiLxk7Q3hf/fsKrtJQ4/0vowZLc0X1eQGGtr5NBCNfIOA8XzwOjlmK4Idx6l989CmGMO3Eehde04JAMwTTFdMGAhsrEJeipHl1CowGUDLaYwSmY+B5oMA7fpMTXocklqitdKVa0cVOysrrhANZoCXOHIN468ZjVH2SS+ZPi3+hlO04b9UpWHArMZWm6DCluQELoSJk4hLO4gxg4zqU+emTHjSt1W08OCY4MSm0FV5cd9weTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFo13jiOt6HAmtySqhUzcUP4aQWYy9lTHqUkSWytt50=;
 b=ETM3q9QSahocBPPQeZDqihxDBQ25nKOTN0Emvll7zX4H+uGBrHWIao5lnENU2U8u89Mau0opW7abSzsv2OMk8CIBPghX8n4WxrLwwtmK+PpWro9ulm3VNEnSzRajJhqk6yQANjFLq0l7GdSpXv108rj9r7l1BQZTsGQxIhyrGq59HjwKfvL2EqcQ1FAwp5KFu1ay/crNP0f6Oh6J6SwxHD0sMRzzQVtC5OMbsPtcQXGK/LgGYK7qThwlDpRfPKjN5olhLXoEGkuRl0PFX1CbbG3R1x6RVUdiNIr0b9WGcT5zWwxCaI4k86EWGKl72xMhoBxKsH5Jcg1a8NFbORFbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFo13jiOt6HAmtySqhUzcUP4aQWYy9lTHqUkSWytt50=;
 b=OYuZ5Lbm43y7lIjbqaka9A7y2vxc9h+I/Exp0ot5RGrhpcNbZIId3vn15zXzOa5qxh9M+eeMTlYOnU07mqdvxB0B/coBHPrHlW40JF+/hq4Pf2Vg7Po8+j6cgttURn0neqRLay0mXHsIvvRhHqc2l9++NqpRPmM3vjZ7dA1BbWw=
Received: from SAWPR18MB988310.namprd18.prod.outlook.com
 (2603:10b6:806:4e3::19) by CO6PR18MB4018.namprd18.prod.outlook.com
 (2603:10b6:5:341::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:50:26 +0000
Received: from SAWPR18MB988310.namprd18.prod.outlook.com
 ([fe80::90aa:c1d3:b188:105f]) by SAWPR18MB988310.namprd18.prod.outlook.com
 ([fe80::90aa:c1d3:b188:105f%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:50:26 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Kai Ji <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>, Pratik
 Senapati <psenapati@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] app/test-crypto-perf: add test vectors for
 more ML-KEM and ML-DSA variants
Thread-Topic: [EXTERNAL] [PATCH] app/test-crypto-perf: add test vectors for
 more ML-KEM and ML-DSA variants
Thread-Index: AQHdRo3JSkYpHoCZbkGj2HrD+TyvarbSlsPA
Date: Thu, 17 Sep 2026 10:50:26 +0000
Message-ID: <SAWPR18MB9883104447BE26789FD6A4E419CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
References: <20260917101725.336000-1-radu.nicolau@intel.com>
In-Reply-To: <20260917101725.336000-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR18MB988310:EE_|CO6PR18MB4018:EE_
x-ms-office365-filtering-correlation-id: 10c3b824-9774-4e67-1b61-08df14a97bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|22082099003|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: VhHfBlulsaZ9sitv+zaXr+sd/xkeAopz9pCzCUcwWqB/Km/Cx3IjDscyEgJcZQSX7DDvLPy8yLp33zCq40JmHyS0djt0koES6PUtLRJOLZxz3NFi+Jkenyjtp593kcWXacfJiuICp5KD0+qKiCGJ6AaDM+VSxIJdjc+5yb7y0zmQStWdGUHtukeyiBY4zDejfgH58+oalrLKKkFkbHL9c0PG1Fmgj09mmDlLHuwT4AausIYdcXpY6fD3HEcKSpjWABNP7uArNY9OudzNo/wRAlsgmUISpHA+RFrEnUC1J7a6TEAPvoTj5t4ZJ2FwlxMD7Ldhh/w5nMFGxedRZ4+iiurZFnlkfV9Qspa/C6aSBf6FAfJP134atGOAhl3C1HQBulM+IL7ZqsKizDqraYAJwV+gEFDnJG0rJZCip2MoeuN1bgHP29VR5LbMqcWmpWtfpIqYIFuA6jVwvNIAuNquWFcjBGK/RKpCEezPlTagEVvzwc6hKLh4RPuRK5RAPh0+kopeX13eu3tnhwlGnH+yhhWRBPTBwoYYH/TmoyYgKMy3vmM+MDqyai599fXR7tzEjAlO8nPU6AxqKHmuKU4eQ0A3WCt92F/YHgs2H/g5PtY61OHySykw2pLkbva1JXkP8fnpczMkctSkETdWueK9OIxZ3OyNb8LyIr9Sk8NDQ9yyU0jz8qMDePBQV0oSgL8nhjjgf053s3PWQr70jSDPTKVvINBdk08sO5aXYR59aGk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SAWPR18MB988310.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRsODFObS9TK2dmcjIza25BU1ZSek5Wa1MwODdtam9HTnlBV3R0bXY1cytR?=
 =?utf-8?B?RWZUaTB6ekdLU0IwZ2hMU0ZpbHdhWU9JbXJTZDlnSHdwWjRXU2FNc3drTmxC?=
 =?utf-8?B?dFMrcnFqdlFZdy9IOXRpMDExZU9CRy9GV0RyNjI3QXFUT1FLOFlwTC9HRVZT?=
 =?utf-8?B?R1NNSllteE9uSW92WG52dXBmeXBuc0xBSkVtWE9Ic3FZZGFnYVpZNmFSVWdt?=
 =?utf-8?B?VmkzWEJxeFB0TGdkemJGUWtOcVkyR3M0YlFVVXN2elNxanBGejY0aXUyejRG?=
 =?utf-8?B?dE1GQ1NwT1lDSmg1TlRQL0lXKzh0RkZ6aTBvWUo5VVdsUW1ocmdrNVBCL3pu?=
 =?utf-8?B?Y0I5Y1U3TjVuL3lIQU9KcGxTUXpoWWdFeDJ2em9oZzR1a0tIcXJWWDNTdWgr?=
 =?utf-8?B?QWl3T1FpRjluSlB5MDNFTnJNbUZZWVlveW5haHlRa254bHdVVm91a29xZXJK?=
 =?utf-8?B?c2E2WUJDM20rVnRJVDQvVTFsSjc4Wks3MERHNzJoYkhRYXdFek00WHhhaEl4?=
 =?utf-8?B?ZDZIeW9DZXZZOUtWOU5FUjBxMU1JSlJOWDdHeEVNSUNzVlRLUm1jR2NVOGxs?=
 =?utf-8?B?U28zZ09ITEt2UUpPYi80c1F6UzhjWkN5T0lJeHV0aU1VRkpZNUJweFlCQzdi?=
 =?utf-8?B?TTdrVm5VSko1RWQ2dGpKeGcwcW5IeUYyVVpzWDVxK0w2UU0zRG5rYi91dm1J?=
 =?utf-8?B?b0FOQzExVmVGL1pYZG5CS2xRVWNiYW9oNUxMcFdsS1pwQkJZUDB6RkFXTjln?=
 =?utf-8?B?OHc5Wk1JMFhiSEw1WUYvRHVlUVEwMWZUa1JBN0ZKSXZmdnBVT2R5Sk15Nm16?=
 =?utf-8?B?U3dELzYwR1VlTXFIcFl0NWg2Y0FmSUp1cFJBaGVIdXk4ZW5SdjlYTDZLOEJV?=
 =?utf-8?B?MDhKSG1CdmdBdWhPeU44eld3d3JKWndOc2haZTRwUk8xMitlRThRdCtORXFN?=
 =?utf-8?B?TzRCUVp1c2I2Nk1UaG1zdVJkbnhLbi9yajRxeEtkTlRmWFE0Q0pUM2FrN2Ft?=
 =?utf-8?B?ZCs2eE5aQ2VQazVGU1ZZbnZmdHFCNGJnMzZnY3ZIVEVsL0lmVHZVd3lPZnQz?=
 =?utf-8?B?a0dpclZlYjIvS3VZYzl6czJ0T2ZxS0RSM3pDdzVzZEQ2WkJYNDJxT2ZZbGk1?=
 =?utf-8?B?aC83ZW45RmthelNjdW9Uby9JTFB6OEtRTFROUGRBUXlPUTRsNEFJM0FZSFBi?=
 =?utf-8?B?QlBaRzVIdnhyL0hkV1NLejIwbVNqdXZjSitEQUFyOXFySjJ5c3NQUVNuNUhP?=
 =?utf-8?B?RExoVWh0Zm5MN2E5S3MwQW83NU9aVkxyYy9nQkFyK1hKWDM2aWptZ1EvWWJW?=
 =?utf-8?B?Y044Q2VyQ2l5SUZ3M3IrT1NLYkxUYjR6cDZxb05pTWRaZWxOcVFzV0dndFBt?=
 =?utf-8?B?Q0hTdUVJLzVDK2UyRTVSRUNSZDZmUjdzSXJTcnBOYS9Jc1pucVZxZDljNUFa?=
 =?utf-8?B?R1FtZ2VyWFhJUWtYNDlocVVhRVVnL2RHRkhZbE01TGxEOGc3d3dhVndNMENn?=
 =?utf-8?B?M2tKcGdNRXIyaHhmVldKNTAvamlnOXNodGROZ3NDcVh1am1OVWYzV0JITWNM?=
 =?utf-8?B?Q1RQNTBJUWh1UlRYUktwTWwwK3IvNjJKa1RMSzJPclQ2Mmh0MzRHVXpCeTNP?=
 =?utf-8?B?elZpempSQm9FelN5Q2NBY0lITWxRUysvWmI2bVp5ZDhUYXVDaHRNQXJQemdS?=
 =?utf-8?B?VWVMQlFiVWxTNXhTUXl2bS9RQXN4MFVlOEJZMHBZN0crazdwNUsxZnJBUi9N?=
 =?utf-8?B?aFpyNndyTjVjbUM2V1VhYy9zNktZeFpPaTlQZG1HM09pNUlTaVlrTVF4Vm1G?=
 =?utf-8?B?VndsZ1U1NE1XRWwyZTMvUURaNTBXajMzNC90YVQwWlRzL2dCYkowOUlvSm9X?=
 =?utf-8?B?NEt1QXRqbG9udU14OUdmTDY0ODdDaHpqWEd1V1ZHZHBQdExuVnJSdndoL2RX?=
 =?utf-8?B?aDZ2OE5vdFQ0QUlLNE5ucVlTN3daWW52ZjNUbGtNa1ZsVlhKUE1sMCtZOGFp?=
 =?utf-8?B?TDJVVUNNUWMwaW5zRXVZck1jWVYzVGUwbWJxSzJIYVlId2l3cExnTUZmVmJQ?=
 =?utf-8?B?Y201dzVialdTUzVwSVNzUks5QlVvdDhDSWNIVU9PZ0VTNndjemdVdGFUSkwz?=
 =?utf-8?B?ckRTQUppOXRaU0Z2NHEwNjV6Z0tXWnlvd2Zqam9oTzhNZjFGcGp0WEFaWDc3?=
 =?utf-8?B?d1VqZ002OERQMUdHc01WcUR2WWp0aDdqSW9Dekhha1J0b0cweTM1eS9KMDAx?=
 =?utf-8?B?ZFpIUUxYNjNTR0tOVDUvQ2xzNVgvYXdIaVdTeHRiWU8rZjEyejhaREtHbkVt?=
 =?utf-8?B?clI0cGpVY2ZReWdsNFZiTWpqRGhTMXJTWVVXUHhROFhFRWdQQUlXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fcFxtRm1yl6VUfJh8aEh31GV3kIigRkdiotjmkPG1bbP8t8UrzhjLWM3XMref6k5JsRg9zBdi0DPd2xP+s8FdHgg9DZ8SkdO7FXPWGxYh80ld3BWR9g8TibcFilw3NOD3YjzbU+JkDwUzbVN+9OzizvQwe4DLOFb8y9XRvYey9JjKgiKorbzp/ZXqWPI0bhTX0evbhio3Js/1+JpR6PtbXcwpzKw5TN4OQG9xOPZT71N50xzkWSWqkTtDSxVa7+rout/zBcBZDsX70z/YD/3VOZQO/RM01fFVPs9mkkBMblAXA/YJU1uOXvcwI/bxixwvBtinL4RG/Zxt+LDk3R37A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR18MB988310.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c3b824-9774-4e67-1b61-08df14a97bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 10:50:26.6911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fw5I7AVXOCmuIAmNIVgH+R2IA+iPD+7POfdHTxeYMCDIQwpOUAnSAci9MAdKmFr9j+Q18qFA0yy/uQD9l3V8GWyl9h4ylpR+15Oe1V0tHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4018
X-Proofpoint-ORIG-GUID: G8-lAb6TUneKNiEl6Aqs0Xpk16Y5AnlN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE1MCBTYWx0ZWRfXzdnjjESGjFE+
 z7htY07lReQwEZq/uCi4lFebHiHuqqnfXr4ClSejZNXpOHuXjUQVRaHIG0DhHqFVQIF6q4BGYYo
 1XlzeBRa1vJCCSUNLU4wvTGGRmWgj4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE1MCBTYWx0ZWRfX1n11KKSuSjUR
 Amq4XkvqUftNIRXkzZqe0EbYC7ZTtTl7bfyya95DZtInX2Zrojj50ak8Ddr2XCf6EbYgWeFtKN4
 i2GK3Am1bQufBSPpIj3id6FyETZNBqwf+2vkEfnqyFcjezjtuHBKRZxlNQE2I6AfeDRkDBa0aio
 dQe3EtlFI2w9iG/CgtlpxFrqxLQb1ZDj7trs4DZ2xYcsZl+1tviVXswKWy3ErOIp/cM2tFHXxTV
 fZnaHGcHt5KZJyMGMwtqfPpZwmIRqlzbXclQPz3JOVefCrxboUJFIk5MAgXhpry9O3Nh8+abTIb
 BzA1oLr3/hoszU5E9siGa/zpdXsoFETobNETNqLrjzi5Veyy3Vk9aOy3haEQ8ik7f3UGnza1jCO
 1ILS6lXRSR2UjhXxYpLhairKzdTaHpEvh2ThOXxRVNGoHlHmIXwFrdowQ6vmQ1dzEU6OrDCe30Q
 wMzWemYyav46P9OjcAg==
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6aabc638 cx=c_pps
 a=y4zkFa5omBjxxVHSBTJAWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8
 a=HX60jXDTYrw7-ktGKFcA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: G8-lAb6TUneKNiEl6Aqs0Xpk16Y5AnlN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
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

SGksDQpUaGVyZSBpcyBhIHNlcmllcyBhbHJlYWR5IHByb3Bvc2VkIGZvciBleHRlbmRpbmcgdGhl
IHBlcmYgdGVzdCA6DQpodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRrL2xpc3Qv
P3Nlcmllcz0zOTEzNg0KDQpDYW4geW91IHBsZWFzZSBjaGVjayBpZiB0aGF0IGhlbHBzID8uDQoN
ClJlZ2FyZHMsDQpHb3dyaXNoYW5rYXIgTQ0KDQo=
