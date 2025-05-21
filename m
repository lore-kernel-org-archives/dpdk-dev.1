Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9BC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFB94279C;
	Wed, 21 May 2025 12:43:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 453F34065D
 for <dev@dpdk.org>; Wed, 21 May 2025 12:43:11 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnmE001566;
 Wed, 21 May 2025 03:43:10 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr51b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 03:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+JGYLdEm1y2n1L9DIeQqrCP38GocOEIBMJJzhKmEgwnf9m21LbSkVK7Db/WI2x/6LgZ+DgBGdkMlbZS0kN8UYZL0fVgctQxcD1MBDw3jL7qLIchJKEjqggvM69Dss0X8AgG6L734WkhJkzKAEwr4Rg8iM6k7yGtM3f/t4p3SaqBuSYSVsLjTF8Tav0u8oxx/YxtudmISFf/+ug990eRXg7FLj/r9JcLoFtTQ3mDxiLCMHWR9Q5l3AhMMa7UNGunzh+vxSfnIBPI8tMoIPzlgx8x8fzkCBdM2Z7FdnkcIcJGZMcspQmZFRvWiE4kM6Wil1loS2Cy6tcpI6lSr0dyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuflxJlfUavTHGlHCFkGSOpRGGZLlpcLbJHN6DGoJgo=;
 b=iOtQuRCGGOSZVoG6SdlOkHFKn04mI5yta7/sE2OgmMvUEriAPhhxwNoAXWCNblrFNFYdmzCNscS0ZTTyAiAl2SseXdujAAC2aFIqfajmDLsvPpVD/Dug3kolGQnhnyrhQlwWZkaRs66zEzI2DNCMbmPdwinrZSFnpRJAda0Q3u0ztS7IeYHv+85COIP/otCgUTB7GqOXjqzWgKb+fUNBJ4ibD9lfEc7XM59pF0+V6ICGECBJjfHixhznnBvfFTnj2bkYygeD+w8jg0WPIUVMaiDT+xDdSJ7hyTlWDNj6Mb1zv+KWjh7sKPBYY1oDLjlTrpv9f9ThvFDoIUiwIN9WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuflxJlfUavTHGlHCFkGSOpRGGZLlpcLbJHN6DGoJgo=;
 b=iPePLhNKVxMLTZr/tpOL+HPvtEDhjH0odqEExZcoFAVXcEarBYO4WMAQaxT4P1RgLb8cJ2hEHqOXZg3z/zNsI6lNwCOT8eZJVsQ+7YePSEmaoCyBl69YtUq1OF1VSRBphgMRxWHnfGAvyw6nc+NksSvjqyfx3QYspc8Ufw6AImo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA0PPFC4D2A1900.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c3e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 21 May
 2025 10:43:06 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:43:05 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: RE: [PATCH] test/crypto: add test case for modex group 24
Thread-Topic: [PATCH] test/crypto: add test case for modex group 24
Thread-Index: AQHbsokhjeD2zdsG7Ey3uuej58glDbOvILWAgC30ZnA=
Date: Wed, 21 May 2025 10:43:05 +0000
Message-ID: <CO6PR18MB4484E564EF141BCF252F8847D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250421064629.1743-1-gmuthukrishn@marvell.com>
 <PH0PR18MB46725A21348C76EAE90D6C6DDFBB2@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB46725A21348C76EAE90D6C6DDFBB2@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA0PPFC4D2A1900:EE_
x-ms-office365-filtering-correlation-id: 64ef0afc-7dce-4794-b26b-08dd985444b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xqgH3Ve0Qihf6v5d18rM7aDviAiutP5Y4L7DT5K0/YgHCm4tVMC7pOD07+sI?=
 =?us-ascii?Q?BSoDAAqQVZGtf+7MfEwgPZDzo2JtxYXpDyjKBTD8ZzHCME1GFjyOcH0+i3nR?=
 =?us-ascii?Q?cxf0NJOugvfiTUod0gZnpvjZdDmsCB5C4gFHrXJI9qBqgRUylrb9RZe5qkzh?=
 =?us-ascii?Q?rgfI4J72Z534l/kjjWRC7hCuF9XEmAVXX5WOBP8M9TAwzAdzvXCV+o8VuyzE?=
 =?us-ascii?Q?tF52Xz2NWPuzGn1Mm8Dad+XW9UJsbTLNHi/SXEvfVCF+Zr6RNbZb4UwDHiH5?=
 =?us-ascii?Q?P03msPI8UOqc9bsBMLwsqTxzORE/2s6hI+ZpADs4UTbt+eX0KWYpqWLQAu5U?=
 =?us-ascii?Q?aHVcxt7bCJBM05jNbeNA5+1aNpUaMMA/xX6A5KAVNbZBTs8zojVGUd0ebBd4?=
 =?us-ascii?Q?c6s0JHg46yNClSl028f3KjkgcBMeDZW7+KSrwxKM827AQUI5kivlKzOS6zVJ?=
 =?us-ascii?Q?FbPmKPG69IFcCQh72j6TVF7gQv0vhofVLY53BooQrEiWq3CcBVmYorSVffQB?=
 =?us-ascii?Q?GFquLTuYdq7NSoElWRqi8LUDLdmvbZOTWozkJRLW3Yj5YAXeu9rPaV07nEb2?=
 =?us-ascii?Q?HbgJycNfH2j7ZKY5oCkjjOHUFCiwbrG3Z4BtBZjcOKSAWRuWzidP8e+ze5Ue?=
 =?us-ascii?Q?LKhsfHp+B1oGs2KxzTCo+Bum0n5gu0GWkULMBcvRvsWi5ZvzzufQXXo6pj8w?=
 =?us-ascii?Q?rl6o9FYNXrR6H7KOGx0yCJSizI5q9XA1r4UjmLfBuCniS80x+VuA8q/FGBc6?=
 =?us-ascii?Q?iRaFLItoB/pTy+g2M60/DU2nAdtWRN31Qz63Sf8ZjsBFnnm2Kc5aPhQRnUIg?=
 =?us-ascii?Q?DYGPM8ceveKe6mz78CuJq1ncSstOBa3DDUeAnTGKR7vkHWcb46nbvS/n7E/U?=
 =?us-ascii?Q?Do7GkEW80tCMh+Qhsv6vl9H2efsZ48wffYgm9RaKXVPMfl592yJXoBxeAF/m?=
 =?us-ascii?Q?nTi2NkjqkpG/Q2pB235m2U9VwlJ9L7zbSNPMfrlW4KbGPqF9ggrq4T/XeV4n?=
 =?us-ascii?Q?54xUL9L0M9Sh8YK7XRyz7Xx01Eb0F416V+rEfG2CKtIIk/vMr4ZwdWva+DUu?=
 =?us-ascii?Q?M8wgnWFR+dK004u1svHPL6nPzIEoLJ/3owmX6F7Sqk6ezHXmImlv9mFUSbxr?=
 =?us-ascii?Q?Ci4DW3H/xiuOwybs7DnGy00My8cswkfnRS28L1r1NwJnAEARTwsTEYP0/OVY?=
 =?us-ascii?Q?v1lewchblfkYdZm8YkJBnzcbOy3b0V66MEz3tAEYUvxPswHGO3gR6qYVXSI2?=
 =?us-ascii?Q?9lFwSmZpKrfK64CDAvrpFtY8Oz2toF/wJKw/vXWDclfirIS9Ca3LoTup13FU?=
 =?us-ascii?Q?Dcn/ybBRfr6YRvutau1J81DD3c8gT+tq7WcdIFVpOZc9YQ/iki24oNG6CE5a?=
 =?us-ascii?Q?p+ZgHFyrdzAyyAOhcq//GnqqNkYLJfn+nQqQW8+yPTcRtjUTqlVMlpbJQ3YD?=
 =?us-ascii?Q?/Y6E36Y0U56nW0A63ur4mjz3FFWy/MN8WhpEQR7vZYbF3H102829ebUJx2tu?=
 =?us-ascii?Q?6V6+C4X2RtSRhxI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yKWfOWsPKZtZi6/wwj5eWySurUMge6548fNRumak8V5gT77HQIZMxt3FQQIU?=
 =?us-ascii?Q?pIGFWTSTU8lFKP/3BCd+hpCwPZUo6RdDw5bgcAxa+qWUBgilIfbXJfYG5eEj?=
 =?us-ascii?Q?FRlOzL+YM8NOnBAxYWlTA4PioyoCsFWoS7NJT5uMy/faFQqMnIaOqDQgzi/w?=
 =?us-ascii?Q?SsJJmNonOq9dYJPLDgLSI0Up0SMW/Ffxi61b7iTXuwhU6Vi3SLOYMorNduQM?=
 =?us-ascii?Q?ds/fU6rlO2at24zVjHG2pt3kllk7jfpvByRWP+ysmskQ3U5AIqJKaRza3c7S?=
 =?us-ascii?Q?d+jDL3ICxCEJKVmBuKE8XTHxal3PNgqdZ2StHsT/lRarDebDOhCI7BoIJmGh?=
 =?us-ascii?Q?IhLOwPoUlyFlX2dmB+k8A32IVMLGJYZkoDHTVGgq549XNClZFN1rEX6yM24U?=
 =?us-ascii?Q?pr/Dh1jHrHUUHzVMIgVHqpVkcqEvw7+PHlEOAB1BPEGV6tuGYb/+CSNVMOqZ?=
 =?us-ascii?Q?vhWa0Pz1Ik5QKIgu6yww5wNy1qF0MsnAo8MWTrj5mVa/kLBFYclB2fU0qxQS?=
 =?us-ascii?Q?44LAvxO+azc5gS9lxooToP3k95PxvoXRmN1gDHrGYmHHuyiFWurzfRemfWAl?=
 =?us-ascii?Q?+q8cnidP1hMKeyg4cT8HlaHpzQl8quMExIZCrspIRtQigQ7y2N5tQ13Q5GDI?=
 =?us-ascii?Q?reqglSSdmCbfUo1SrwLadcuji5ExHQMI8uzWILQ5hga9t8HkqW8uPDoW+QKH?=
 =?us-ascii?Q?8XwK8qds4DJPFmiRQeM/XQP+Ae9RfmY0LkggEPef2mtGZJ2r0RHzmgv1cn9+?=
 =?us-ascii?Q?HyJ4IWpqkUMr+Ffe5s8AFnwzInDlnuNEW69dpkUzUSF6bdGaAOWhOo7r27nz?=
 =?us-ascii?Q?d7zMzzxrdf7gRKKccYk+Io6q3w1tHNQL9VZjSFeUn74SP2/ioG6pPxikTbds?=
 =?us-ascii?Q?4gpog12FzpNgyHPQtpm9lGp+61tkolq/8zBY3Ud7iac75tMon2AzmeCXbGY6?=
 =?us-ascii?Q?YC8COzD08iOnnL5EagUyw72SiiEOIStwo+EmomrnfJkFAd2o7S/eX/vU4V0/?=
 =?us-ascii?Q?8300YJO5zOrtaakSGmhIUvafv4SacXU+7cazDwmgHDpOBEwGlD4Uyb6tDOwf?=
 =?us-ascii?Q?dFAMLkTugCGhWhfFk2uoMSKXR2MOcknanV/6QDIJ3B+TqwyOUYbh0+oq2G0f?=
 =?us-ascii?Q?stUmaYztsuNK7MZuNzYh5CDbfJc7Vp034fcRkfhKk8HzoeC3QFMeaGWhL+zJ?=
 =?us-ascii?Q?mLs9rYF1ERZLprCjuH0YEnE89yv50MQkYPmA9kFCxA81U2ZlY3FQzm72FN3b?=
 =?us-ascii?Q?bZ4gGjXR2AUPguJVs4EVGynTbMap2EvS8KiPyAnjYu196Ov8LMl91z3J9Dx8?=
 =?us-ascii?Q?jEkJUnQLMDhxZzflXjatxXKyg/szcKllNqlYkJCwh38sV9ISiT4AOiLkVoAL?=
 =?us-ascii?Q?ILEIWpo2fgqUnsPDNalcb8hC+iHDDDSbKNFvc5QtUrQAJ+12d6hHeKbt3+zN?=
 =?us-ascii?Q?KlBwXjAIkWpvcbj3sgO1V7cMT4Gn5wmQkROY5toyDpYIa4XAbrQMobE1QMuS?=
 =?us-ascii?Q?SQ/1LCFjfIZGcRR66lrWZTy69pGHApX+q5/oSI5k/WSvou1RaI1+BGTxMdhA?=
 =?us-ascii?Q?CRff9HtwqkI0H3OUuns/SAuDqD7Iigk5rLTRR1eR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef0afc-7dce-4794-b26b-08dd985444b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:43:05.3983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYwCgzXRyouHDIkqlEnGC37m4MlMMC36WXv+3YSU33eXLj+2CipdKS2e0c9uFmgFuFEECfi90pIDIQAlXnWLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC4D2A1900
X-Proofpoint-ORIG-GUID: pPrd_Ff00XRgSTwSeAyNlNf48V-IunEG
X-Proofpoint-GUID: pPrd_Ff00XRgSTwSeAyNlNf48V-IunEG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNSBTYWx0ZWRfX88X0iqfmksOv
 /UaJ0VuXW1f6TDQ1ia/Tu2mcvonWFj7/ZjC9KiijUC1X0E8bQIZkuwbR7Mplzh2pBS9aJ0QjoW2
 3MVts44mfDlV3z0yzNLDnRVQnlQO6kfx7SOfLNUQVMefLNbmj4rs/MnqaaOzK8I0MM+72UnQgXx
 y2FeeNo/1wOAADr0R43ONfO0x0YBhx3pTXZ8g/HjfSpV0i3YWmNF9xlznaUcWAar3/oL/SkB3K5
 t7nC8M7nFpymOGA57Geu7efubTYmEC31fmtnFrmi0Nu8JrMJ3Akz1x4AGEuljFXXJHg/PJGRSkC
 fcwxi3xxxWZfdHHSP8AQTNrlthaYj7StXLMh9EHotx7mnAHsgslAnzTerOxqo9chflG0LT6JmZA
 xkDCxNBGVlLP/Ld7KvFV0RLKoqkht63E8wEisYBUhszmW86jEZyiMXKVTs0ZeWKwdniOpTFO
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682dae3e cx=c_pps
 a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=IVattZtrAx8PLrS-H4MA:9
 a=CjuIK1q_8ugA:10 a=OXoeHldmKWcA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

> > Subject: [PATCH] test/crypto: add test case for modex group 24
> >
> > Add test case for modex group 24.
> >
> > Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
>=20
> Acked-by: Anoob Joseph <anoobj@marvell.com>
>=20
Applied to dpdk-next-crypto
Thanks.
