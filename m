Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D53CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A75F402A4;
	Wed, 14 Oct 2026 18:48:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7FFE04013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:48:27 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEaOUr174368; Wed, 14 Oct 2026 09:48:26 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020108.outbound.protection.outlook.com [52.101.85.108])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h9r9xnxnm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 09:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjhLmd4iohvLz/iRF48vWNoW3q3xxhpD8QGa4+RHG/tvCFDbyXNFmO5ltUbHbtorin591dSqPhgfLwR3ZkMwcw58yCoz5GIWf6R1mdFQ0Zv+HlqJgqIahhGXHkqcjc4c/aIPLpylP1M192qsufT3/nplSQI7T8T4OTMQCnRNN2iDIHCOl6pagkuaGcp+bcRK15ieHHmzOhXnf8USbg7TAVkbSihwGjKONvLTa46Gmif69pc5cC+/TBZvmtGD1jfcUq8Vwk4P7iuP5nnbR9KU4sB1cJK19sAX4OW406qoG4LBVwHCrgkiBtiw2mUCMFpegeXSJUaZy3yCbvUUpMfeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM/DtAJ/aiLNFmhkaC2iX57znhL/+qmnMpzKqNLhRns=;
 b=wB/7YPbmIPiDVsT8egToMwjFKDu4owSdflh1hIxv2jbR1/6BpQ+b9sYKm3vu02VDouA014rrcMzsoqcyv8Wj+qn2M5eitRSHv2/0GGLXe1yor/MUHm+4n8tlLDP6MUgzCZfMfBDLOwZZ9N5ln2hO0zIzjpZrP9gxf4ri1b/3EreiKC7gDGTwy/hD0a7BkGwq7D7IFxB+IImQJORkLvyeH8LbyqwCu2wJF8fD143wceOkcaxelHxH8RcopN5ShY5H7//Sb1qb3fOlq6q+ksrh1NBEuJvuUtfuloIFhBR5DieATZ9diRjhGKVYB+An5rmx3JljcJ7hHPmwxnqL9Z8dKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM/DtAJ/aiLNFmhkaC2iX57znhL/+qmnMpzKqNLhRns=;
 b=uJLDQYT17Daax72KjhwkLG2aYX4q2c/0rtzXZHabidqBIUDeHSGVs8y7FUClISQ2IWbUUei7bEvslPMphNKD4z5Bpzi/rYFjH2AWkW22aO8B1o5UOjOA0UgTUSEQeu/NUW1/yUB620/sXWR9niPI8aMSgoHvT/pH9TwFPJcu5Ik=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPF3F9C553CB.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d92)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 14 Oct
 2026 16:47:23 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 16:47:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: RE: [EXTERNAL] [PATCH] vhost: make cryptodev support optional
Thread-Topic: [EXTERNAL] [PATCH] vhost: make cryptodev support optional
Thread-Index: AQHdW/mGGLDhBGPwPE+0rMyzcJMaCrb9PwJw
Date: Wed, 14 Oct 2026 16:47:23 +0000
Message-ID: <CO6PR18MB4484DD9111F1AE20CBCB701BD89D2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261014163138.1639970-1-david.marchand@redhat.com>
In-Reply-To: <20261014163138.1639970-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPF3F9C553CB:EE_
x-ms-office365-filtering-correlation-id: 69f555ff-297f-4a86-2996-08df2a12d24f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|38070700021|22082099003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: SCImSz123LcPxBdxg8X7H1ASxgY/cNhx25k7bLwY8K2ETpcWJmfxZXxZwPYHEfc8JZ2HY1ahxK8//xFCmYabO191yckwhL049/wnEyk8N7eU5cJDDKq6QOMhTchJaXXQ8YVZBQL5wohmdVzE8V8t7AATkeu6bqUNdgBYBz6Gj0mewS9FYw6lxyzX5iZI3DK2mTVDYnsoFf6hLk2+D2L4je8vDcHmexQjpklg6Y3UyF9sZOrnQ4KJBPanvHahqOQqvnqf4x0K0I6hya39SZFiJgI+Nxt7/ztOXu13iVEqGF46GvwMBaf5t/09modafE1FGwzlRvfd7parRnZYK/RwudCDVH5FW3W/p1SWwJ5X/c/Rv8SWwOteARcfxVsTEn2v8J+ZZ5c37EoQ93GMWH2YWFmXTH/o7cnM0x1Jdp9UQssvn5M/BA/Xy+vwPzrqPlH4LqoMjlh1VEMLfnKK3RRPK+lD/sbz/Jw7BCKY6MU0Pv9ODNQZG9l726Sguj5QsKpgCsEBE8NaKGvtO8a3P62z8uAzS65VfujVWQUIq+EW7HkUF29VaXNnNbvffBX7ao+ybTTaHTZH51XWihDBPE3ylLsS9y7N3vk2p1Vk1Qo/zQaGPrYP7v11j48N6ZMp1G93toCLxRzNtS2pXI98corLU66vhv5L8QtybfPnvORBbgmzVrI/JIhjuH+llNWFvt7MLWqUtsGPr9xMxcG53+IzxDtI5mhRtQtlMlfqOyCUQl4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(38070700021)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hXHFKxMM6A2IX17WvophQbrFmDqzk+r0aqwT/M46q/bzj1JorVqlSuV3qxnS?=
 =?us-ascii?Q?0lJcelYSQm4z7OaDh44cWL7TOw29CI2fr5ZUN/zrpdIf04e9fBOJhirexMYp?=
 =?us-ascii?Q?W3q8JIhFJ409Yn58mAcPnyam6dnphpjm5+H7gNPkNV/7jHLGW7UTBFK3ZIrb?=
 =?us-ascii?Q?L44pVHbY4+fIzEW/otBt6b66BtRY/5cde08do3CcXtJ1UgnTC3VtTfZWoiNi?=
 =?us-ascii?Q?J13xI4yi8AyuFW9mFVkU9ZjQ7Q9BMd/k9tcUBNixnDu/rjrouR5jIcaoCQ4W?=
 =?us-ascii?Q?h6sOwMdL3Mww8YEDRDO/CeLjb1lFEAFTwPiKhIRbl9h6RDqdULd3dK1u3Yny?=
 =?us-ascii?Q?uVEESK2Kc1PFLCWIBFshSyF3t/Q0LZtCZxgq95gAtnIXtwATiSOx/ZyvsgKv?=
 =?us-ascii?Q?X0MKTQo8UfYDAl4aasuk5nVqLrYKTyjP0WNHAP5417wI4BDdDo0deJLecixk?=
 =?us-ascii?Q?+8b6c0sOP0ncNdWUR9FET0Mq0tKzV0zyI+6gscEwoMG24w1l+X7/4weCD0L5?=
 =?us-ascii?Q?lMMXv452yBc8Q+P2JlHq5plLxTVnBFmDbYexswwQKfYl2HDc1ZGWjR/9Scrt?=
 =?us-ascii?Q?6g1ORsdzTyX2hAzU+aHGnu8WJEYhUMPIybZ74dNY3GjP6uGyyhPRvjrE6clW?=
 =?us-ascii?Q?eE5nfZe6Q2u8rd88HHi8uIaqw0rL1EujMmCTh8yZv1kCdrX+9zMiyieRaDtr?=
 =?us-ascii?Q?OvYLHF0fbfzmOb/T0MXLB5aXOWpAD7ea1dyTEpUzTqgWWkRzEgllpf+y72Qh?=
 =?us-ascii?Q?djACDRrzqCeu842o3AshFq7PbODp0wNbL4gDhQP7LTgfGeTjhuboFvCHr4lr?=
 =?us-ascii?Q?+e8RczZHkN+VIr87pQCkZsEwAunaVKk+fI81Z+QBkItTTb5Ydv3BQ557fLQP?=
 =?us-ascii?Q?i4B/H7uPygiREOaqMDCggXJekzR76zTiYq4k8PnLYozkEvgqecVg7aDCEWIh?=
 =?us-ascii?Q?0372XsS0WcZDchw7i4GKTk3o93CUb/7Bm9zWtUsdloAYweO2bPY2KO6BW//Y?=
 =?us-ascii?Q?7GhhVGOIS8iTWTq0EWU4ra2hDcAUX5rjhQGkhBn70Qou85jxyvU0aPoRqFSG?=
 =?us-ascii?Q?ZitwtDq/87IDzvXNK0H8pF0CDpS+lieKYm7fuLOTy+OoYD3BuvAx3naMg9Pf?=
 =?us-ascii?Q?WYR1KNLnC1eEetmc5m4L3akqdTXMALS0K7bbj5zsTFmF/qCIIxiazqapdmGZ?=
 =?us-ascii?Q?E/yatsli9SH+GkbVEgUbi+SOCt0T4Ax1/m+Pa5sOF9hFSMxnxpuPoVqnmqkf?=
 =?us-ascii?Q?nruBI+0/WnQxB6bPW4MeZe4qrSC+ozvsjnQT/ThhUWNtma7lII+9XqrDeNOC?=
 =?us-ascii?Q?jcyJweCyrLRlHnUIccLYNlliabtiZrLshJu7pcx+cSun/Uho2Ph4GqB/x8ux?=
 =?us-ascii?Q?LAocCXfeOELe4w/IM9kCpA9ZM0tst95igB/fZ/ScdfU2y2WbPmeJkcJk/Zwh?=
 =?us-ascii?Q?HRwwIbBezVnO1ebEMau8sqa20xQCbBfUdd1DJD162MtfFoZUx65X46AXlohA?=
 =?us-ascii?Q?cxMpDSkMphPpjFjx5Vvg7zr9WAbIUBM6ck+CyBbFaPT6YAMdu4PBSAGBOtJl?=
 =?us-ascii?Q?pFhzhBufz/+C5WWq3R7nC/Wzsg4jJknvp/29cs+HGTY7kADS5ht4RuoD7hI1?=
 =?us-ascii?Q?1cQ6qUkyq5FuEMrlQN83uzq92Jq1c6mrF801lOJaBKIhCzTgy3oLRKpZ/i2B?=
 =?us-ascii?Q?0o/0Z9SLAiZPqzWTXRYkDVERbfvRJfBKf0VQKb+WaKCyEOS0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V8670yKWAlHEfFRY2GNSDFHZ+c2J+XDTQIgOS6vF3s3b3L7G0dXc4d5IUuvfDGegPp4eeqQ2tjla55uxnvd/csywQKjqg2VEcJocUDdaAMc7aQOR6NSgottO2Ga9VMvMMebFWiqw87Yf5rCNLrSPH1TekOdA8pBhYHUZ1Vqpw73REBJ/gl8UbwDRwXUMLuxEvJalF+Kx31TRATKDQpZFAoqotfncaQ4ruC5fE7x9XiZsBXHVx8zMMcHvjP5fs+2MKUo2J8gJ1HdyMvqGbT7uAHJGKekiq5oRvebe11z3N5DH2sYsCs6aBATe+gAggouc7twSIE/M2k6+0gAYGTyhbA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f555ff-297f-4a86-2996-08df2a12d24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 16:47:23.5787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ymd6E6WlZdGCKYwAFfXPid6wCSJy+tXji1zS4OANYrkNHsOQf/5pPRu7pBuUSnnu6lZ2uJK/mDp+2FS/wFPi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF3F9C553CB
X-Authority-Analysis: v=2.4 cv=DvDDa2/+ c=1 sm=1 tr=0 ts=6acfb25a cx=c_pps
 a=l6WPzq2nfbAxniYbonYZnA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=20KFwNOVAAAA:8
 a=M5GUcnROAAAA:8 a=jYAYpwmviFdS7lZrJM8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: kVRgWm2MPb0XS5jXIj-FM-m79Lulbw5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfXxRuFgE0HU9qu
 GMoRx1uqEv0D+UyaIBNzcLNNYjxcRP/tflkftGXn+8mkhpdoHmffAiR8LeGj2FPBrpM+amAmq+A
 u2dviuhUHHSnEyvhE85DjDnSRPNUYYrQyECxQNSNuZ5ZM4AFPQo1CMAqarDagsEr9Dd4f7LMO1i
 +HOu9xt8Gq4ogu+Gg7YDXiSD534wx7SEE28ZEw7epUlgXMP6tB+iXnSz7cNb4HBYbvIHkziaQoW
 t+ynjarbfRxILLWVm6zpkoxhaBDPKChUi5ziEmfra0bk/WZL+eUByh5e3FWPmlzzQ/ugTQVJURS
 MVGpN73xI965vaqp5bQSQ+HvNjylviGvg9llpsdfAMlDMPHviIn2Db8hl/wy2zy1YdNoCj7AtZz
 Ii4qYSJRlzmz7JpBy+HladcI7UCqIUOqdMSyemvSueb1n5R2E6MS33KxUx/1CXuPKgctrMooJ6c
 wlB5lVdFjde6n8cMEmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfX3+/5qtrwte2N
 2FThxYI1ccW/v8JT0pjdKsx07rItwoojLnN/Dy2qqZsRigYBfCX83bp3gHy1VeEg1GVyVBgPHrx
 UCyumRf/Q9z6vMKOAoSbzFHmragd2wQ=
X-Proofpoint-GUID: kVRgWm2MPb0XS5jXIj-FM-m79Lulbw5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
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

> The vhost crypto part has seen CVEs in the past and is getting a lot of
> eyes those days.
>=20
> Contrary to the vhost async datapath code, the cryptodev code seems to
> have active contributors, so dropping this code does not seem a good
> thing.
>=20
> This change here allows to keep this support, yet disable it for
> uninterested parties.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
