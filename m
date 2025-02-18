Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E65C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 08:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D765402C4;
	Tue, 18 Feb 2025 09:47:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 090BA402A0;
 Tue, 18 Feb 2025 09:47:26 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I0PfYj026430;
 Tue, 18 Feb 2025 00:47:26 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44u5rdm70u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 00:47:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKgwbc8ET50oHJxmO37rq26YNGKGR+3ftUN5OzDEb29EZWKe2Ngs1S6VmTLihpfLCgAw2gJmtSvq1xt/13HJuvIS3s835U8CmflTA8NM0I+DndGvqvncTysLrgFWJjopSHEgM6g/KU6VQ3pYY2iR3Zx+r8N+g2fUO32+qYuH/eCKoHuvzE8u1+uYe/xeVxlA6j+2JbJuc/d4tRvDQ4rD4V87n/t1nZCB4MgrV6ERN+9Af9JLTjV+ng0fdAOErzbJAMU4uDakw11G22vJmLF5YARNLVkaEyQpVfBe1JJTyGRwU1KaJ+ukblPCcAO8NucIytTz2Uwk1ze7S3XU7jzrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5YDv8OEhP1qcOACoSfW37uF/x8JNoKeffFIn57VaPg=;
 b=tOtBp6kGfWIclOIcHAvU82UEte3/swECjozVUVVbs4m7e+uMwHD1HjceW+BA1/AU03+us1xhKMLWbEqLXJ5VNW1yG8KFTvLrjVDoRfoPd/EPIddI6FG3MLLayREOUPwVD21PPCaE9XOSr0xNch4JBZjeQxSoDwZtPFOqDO/X6F7WVolw6jQZED59baTRmbDBHdCtAR5m+KpEL7pbv04Kzbez0NnMMo9bVmVkRMl2CKPrflI49pw6X+n3xb5lxcPazViS63RiyqzsYUmLNdB/MS/Axar/u7qYypjCCLfwPYu8y0/sJd+Yu0+ZluTdXmt/2F47bzoVT1qxYFORaicPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5YDv8OEhP1qcOACoSfW37uF/x8JNoKeffFIn57VaPg=;
 b=a/DgRZpp7u2+ouxbrTG9wYpALzdNmRvajbFMqy/XyCMfTUdRRsTMhrjd/Ony03LoAj2Z2hld/iMBQRgP2Cb8fJD/eKK2GQwI3O0PfQs3ZFeQPLpu4fDG7pPFTiwqyT+lluTA7lBneVB9LTsTcPslTEaKWQyw/+LToW/gQV1SHnM=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by MW3PR18MB3657.namprd18.prod.outlook.com (2603:10b6:303:52::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 08:47:22 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 08:47:22 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: "Pathak, Pravin" <pravin.pathak@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] event/dlb2: fix event weight handling in SSE code path
Thread-Topic: [PATCH] event/dlb2: fix event weight handling in SSE code path
Thread-Index: AQHbeKZihw00low4gEm6snaaZia47LNM0fkA
Date: Tue, 18 Feb 2025 08:47:22 +0000
Message-ID: <BY3PR18MB4785035471DD73CA8089D04BC8FA2@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250121171135.2705818-1-bruce.richardson@intel.com>
 <BL1PR11MB5461221901E20DCF1892CBBFF4F62@BL1PR11MB5461.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5461221901E20DCF1892CBBFF4F62@BL1PR11MB5461.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|MW3PR18MB3657:EE_
x-ms-office365-filtering-correlation-id: 4c23bb82-a48e-4514-91fb-08dd4ff8dc7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ek9KeW1ONGdZelA2Mm1xWklqL2hzV1V0eVc4MnVJbzZsUnIvT3NuRVVTbnFu?=
 =?utf-8?B?Y0k1RGpjTFNTVm5CVGJtT1U2Unh4K1dHL3Ezak04NE5WUmxXTmkya1FxajBa?=
 =?utf-8?B?NDVBZW8rb0pIaVhQN0dpeENDSFJmU3FEa09GTjVsbnRRMGJKUkF0dzl6NzlH?=
 =?utf-8?B?MjJTbmlySXN0RXpmY0RKWENuSEhPQklaUDZwNEZyVlFXczJRY0JtaUFhV1pt?=
 =?utf-8?B?OVp2aU9UbHBNM1daVklUT0tUY0JySTM0UTNkcWg1WFBVQlkxSGhwUGZKL0Z5?=
 =?utf-8?B?elk4WWRwd3dFaGdlaTkrOVNsQlo0NU1iaXB6emx3U0FVc1ZIaEZZaXgwMWY3?=
 =?utf-8?B?eWdEV0Z3YkNPc1B6Slk0VExuaGJqMk5VQS96TERpNVczbnRjcDAvdW4xdS9C?=
 =?utf-8?B?ajhtQURpQ09iWGFmM3ZwSzBpQjN4aFdRNUw5Z0NCZHVIbHgxeGtNR3o0eGI0?=
 =?utf-8?B?SzM5Rk5Ob3NQU2JhRnRxbzBIVmhNVEpITmtkRkQyY3c3RG5TbnNMMVJMMzJk?=
 =?utf-8?B?dlNSNklydXNoUXVub3o4UnVaVmRKV1hUYmhNOXRsNE5IY29uSTlPYjY4TXY5?=
 =?utf-8?B?MWJmSHNpZHA2K3FzWjZQS0Z1dVIrVlFBaVRkQUdLQjZ4aUhzWkxBR09qS21a?=
 =?utf-8?B?V2FiTjdodWJHMjNIZ3VEVnExaDJaVlA3YUNPQ0V3bCtXQzRlbmVoVWk3VDZm?=
 =?utf-8?B?WjdiSGVtV00vOStrUU5oanVmNkxUYXdmbUJ0U1Q4LzJuck1nOWpET2hBTk1x?=
 =?utf-8?B?TlJEUm9oL1h0TVg5NDZ0NVBJek91b1pFSkhIeFk5NTNFQk51dVZqdE5tSnE2?=
 =?utf-8?B?cEd1RkF6eFBRNHpWeFFJREZreU95d3hhbkxPSVZ1eEFNZFlkOHROZWlvbUQ3?=
 =?utf-8?B?R0piWFI2VXljNUhyT1huQnd4UWFObTBreE11enNDRHY1ZkpNaTN0MmVhQXpS?=
 =?utf-8?B?YlB5TUVhOUhTZzJYd2NUNFg1RHZMUVA5TXNWV1lXemFpeHhhSWt6TG45a281?=
 =?utf-8?B?QUZsd3Q5REVPRWREWGQxeGZlZVJLZVZpZ21hR2ZwL2xlZlFLeHpUUDYzeDVw?=
 =?utf-8?B?K3dXTFpFYTdwdVFGYUFvV2hkL0wxU0ZVd3NEZmlJcU5nQVFKQTMyK2NJdzZO?=
 =?utf-8?B?YjFFMGZVNGVBUlpwRUNYWG5NQmZjVGViYmFzVTIvdG44RGVrTWZLOVlieUd4?=
 =?utf-8?B?QXJWY0k1ZTRMd0JHa0FNTzkvcDBGdll4N2RuR3ZySWNtYXdYdmVqYzlKZXZz?=
 =?utf-8?B?ZDBzcGF5aEtrTFVya1ljNmJhZXRiemROVTIwdWFCUG9jbEh0S2VtRUJZUVR6?=
 =?utf-8?B?bFU0VUlqNWkrdGFydWJqOFZERzZ3VU1UWmdpd2NWVjNSL280R0hvdURGUlVG?=
 =?utf-8?B?NUFCaVJUV09OM05Da3l3b3A3RVM0eUpJZWtMQVo4YVR2bUFTdlUwbC8vSXVR?=
 =?utf-8?B?RENUQ0pleEdsWG5yQ1AvZFRReWRnMk5KMzBBbDFhTUdTMDdJOTVNUzhaZDZS?=
 =?utf-8?B?NGlOUWxHalRPcmVBd2NNTERmbEZ0TWgvNGcvWkorNWJxNkM5ZVpnUDZudTdY?=
 =?utf-8?B?ZDFsWitJOFdzT2N2UlViUlk3U3J3MGNSbE1jeWk3TWNFQXJXTXAwSGJwcnV0?=
 =?utf-8?B?L1hqZTZEMXpLQSszaGEzU1RJYzI1aExkSGtvWWpNekd6L25WTWxZaTV0QzRS?=
 =?utf-8?B?Sk9xNC9FMEdDMlNGWVJOSmdJdDZWdzdmVVh6dksrQXNYWUNSVmhmbUx4R3Zh?=
 =?utf-8?B?WE1Rb2RraVUveEUrcHoxR3pNdXZkUVZpTVo5V2ZONDUwZmtCY0lrMWdZczNW?=
 =?utf-8?B?WWpRZXlvVWJNNlF6d0I4c1hEQk1YVW45b1JoMjlDTlBjaGh5UHFqbVQrMFY4?=
 =?utf-8?B?d0h6NTBCQzR6NUEvS0lPcFpQT2RmWkpWNlV5K3NMWVhkZ2IzUC9INGZBc0hT?=
 =?utf-8?Q?DI0048FLIX2f+FFbLJq7zwUJN7kzgRg4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDF1RnJ3ZW1US0ltU3ltTSs4VVFoaUFWQ2kxVHZzYzNPaE43czBjUXhsbkRM?=
 =?utf-8?B?UnVkTVdGZHF4R0JYby9taUJhSXpVR2xlb0E1RjhMTFQ3WVJBc0JMNnl0S1hh?=
 =?utf-8?B?ZnNndWxLRFhKTjh1aWsydFhiZjBSOFFpV1RBQ3haUHdZbWlhcjJmMXJyNDhJ?=
 =?utf-8?B?Q1BtZFBVMHAzNzI2YlFlTmdHdjh5Tys0djBTUjNycHQrbGVJVDZSWXdYM0pT?=
 =?utf-8?B?ajdqMHR2UmlpU0hmR0JpNkJLaW94SkhleXVSbml0Zjc1cUh2bnRRMnByVk5C?=
 =?utf-8?B?cXNJWEhadW9oUFdmRTI1c1BpSnlKd3Y0SVFtNlpVd0Zjc1VTdUtoSzF5QmVj?=
 =?utf-8?B?TzFXcGwxeTI2blpsT2YxUGVQZzhncGVuMFNpNTdHMjl1NzdVTWx5UlY0TDZN?=
 =?utf-8?B?TVZRV25kclhOMWxUUG5pN0o1YXZ4cEZYTnRSZzhhZXpMcE8xdDF4VWZzcHRZ?=
 =?utf-8?B?dUI4ZVpXM2Vqd3Y2QWZMQm02UUtuZzRrR0RqSDZRamF3VWZaVFBnU0hvcnVP?=
 =?utf-8?B?MzkrZ1R5MlR5WHpobEM0ZHIyYnB4akdlczM3WDAvb0U2MUFYUVFQd1pRN21W?=
 =?utf-8?B?SnhXengzZ3Z3K2VleFlIZlFEK3VzM1ZKRUtEdU5YRVNpeDBCdnpsSlhjYmx0?=
 =?utf-8?B?TFJXV1pQa0ZhV0k1K0FYbTJvVVQwazVRNm1WN00xN2txNmM1aHVweFB0ckZ3?=
 =?utf-8?B?SGZNRzJrVHAvQnc1dFE2YU03RDR4UDJsWStJMUcxTFBvWGZMeEpCVlNYME1J?=
 =?utf-8?B?cmI2Q1dLbUJFOEtIeVphQzhwbDVTZkRMNmpmaXVUTmdFV214SmFrayt1Vy8v?=
 =?utf-8?B?TGJwSThqWjZQTVlGZDl6cFNNRjE4KzhWaC9VT2Zyb21KcXNQeUQ5Q3hvZnFQ?=
 =?utf-8?B?eUJRNGZHSlhDTHF1K3NUaWhmQUZ4cjd0R29pZ21qaXpKTmcyVUttekd1djhk?=
 =?utf-8?B?SXpWYlhaRUNHZHRQL1p2SnA1ejRxNU92K3FyOE9EUnZHbnpISlIyTFA1MDdD?=
 =?utf-8?B?OEZCbi9xOFAxVE1qZ0xGRTI5bU5SV3BOellOMWFZL2thd2ZMOTlONEFOaDB2?=
 =?utf-8?B?M2ZLdU9NdmxqM2FnMFFQVnhRQlJBY2NNNUZXQ2p3L2lzbnhNcTBldnRySTNq?=
 =?utf-8?B?cnpTN3FtWG9YWEtxa05UR0NCRjBnNTUyZEpBN1pweDkrNFdrN3RQQXJYb1dH?=
 =?utf-8?B?VUo4bHNndENYTGZvM1ZteTd5UnI1OGZmcTBxZ2NDT2UvK0w5cEkvaStsbng1?=
 =?utf-8?B?ZDRDRzl6eXNFeVc2RHBVUVpsVHZsNUZ1RFU3ZnFPQm9BY3MydVQwb2I1VC8v?=
 =?utf-8?B?dGNJd0JMcU8yRE81MzFXclBWdS9kekdpU2pLVlRTdFAzY0ZLcG1QYVRtcy84?=
 =?utf-8?B?WVl4Wlh2V0ozYUEvSE5DN3JFeG5ZUmNnajhpWXJndWIvTkMvZE5FQ1ljTUFh?=
 =?utf-8?B?UWhYT1pUTWlKRTdHaW0rWEI2OFlhNG5LRFVVeml1YXJuTGgwenowejdEWERU?=
 =?utf-8?B?bC9rZnp2Q3lURjZqSHlBSkZLdE80ek03YnU3VHFGUFlpaVlNNVVoblQ1eWdu?=
 =?utf-8?B?TmRxS2VjZWpJc3BLN1ozYnVHbi9QaFVzQndOUVZ2YS83UGdVa1BFMVBRSXRS?=
 =?utf-8?B?aFh0L1l3R0lHcm9jcTMvUGtaSGRueXFXSUtJM0pCYUNvTDgvL2hkejVwTHNZ?=
 =?utf-8?B?dVlXVFE5YTZyTk0xeElNVUUrQlhLcDM1MXloMDRhK3cyNHBzY1JFa1FBVjhh?=
 =?utf-8?B?dHo4QjFCanFOZ1NNc21ZSENHUGtYSW05SEpySmJWWVBjbUFFSzJVK3E3TUwv?=
 =?utf-8?B?cTFEOUxDU1Yrb1JHTTNYR2NQZVJac2xqMVpKZWExRHBwNG1KWStVa1Zlei9F?=
 =?utf-8?B?a091TEgxSTJiNTRjSUNxbU54c2p0eGtPSGdvRU0yR2g0VWhleXMvTGJ4cWRG?=
 =?utf-8?B?NkZFSExaL1dhdHFsTm1qMW1kS0tvWXBRRTRlYnhsa0tRZVZpNGlaT0NEODNM?=
 =?utf-8?B?SkEvdzR1dHUyUWJwQ2Y3eWRBcGI4ZVRja3I4TU5FVmM0TFFnQWZtM3M3b280?=
 =?utf-8?B?STBtcXV4SHFUeE1LUEtsU0h5UUpzY0JLRmhxLzY3cVMvbHI3bUFGSDNVaHNF?=
 =?utf-8?Q?vEv7sv7dtbilyWmR1njzXWdMB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c23bb82-a48e-4514-91fb-08dd4ff8dc7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 08:47:22.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cMLjoaKRvteQvSoIQHEFFmdFKSysLKlaJatQA9+Mgc9GY7FR/3lUjvynMPxog/9XzWe9I/vhP2++g57mvlxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3657
X-Proofpoint-ORIG-GUID: -YathU8pRr2yJaET8FdBRAWdg3X5Vpuf
X-Proofpoint-GUID: -YathU8pRr2yJaET8FdBRAWdg3X5Vpuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF0aGFrLCBQcmF2aW4g
PHByYXZpbi5wYXRoYWtAaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNiwg
MjAyNSA4OjIwIFBNDQo+IFRvOiBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2UucmljaGFyZHNvbkBp
bnRlbC5jb20+OyBkZXZAZHBkay5vcmcNCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiBTdWJqZWN0
OiBbRVhURVJOQUxdIFJFOiBbUEFUQ0hdIGV2ZW50L2RsYjI6IGZpeCBldmVudCB3ZWlnaHQgaGFu
ZGxpbmcgaW4gU1NFDQo+IGNvZGUgcGF0aA0KPiANCj4gUmV2aWV3ZWQtYnk6IFByYXZpbiBQYXRo
YWsgPHByYXZpbi7igIpwYXRoYWtA4oCKaW50ZWwu4oCKY29tPiA+IC0tLS0tT3JpZ2luYWwNCj4g
TWVzc2FnZS0tLS0tID4gRnJvbTogUmljaGFyZHNvbiwgQnJ1Y2UgPGJydWNlLuKAinJpY2hhcmRz
b25A4oCKaW50ZWwu4oCKY29tPiA+IFNlbnQ6DQo+IFR1ZXNkYXksIEphbnVhcnkgMjEsIDIwMjUg
MTI64oCKMTIgUE0gPiBUbzogZGV2QOKAimRwZGsu4oCKb3JnID4gQ2M6IFBhdGhhaywgUHJhdmlu
DQoNCj4gUmV2aWV3ZWQtYnk6IFByYXZpbiBQYXRoYWsgPHByYXZpbi5wYXRoYWtAaW50ZWwuY29t
Pg0KDQoNCg0KQXBwbGllZCB0byBkcGRrLW5leHQtZXZlbnRkZXYvZm9yLW1haW4uIFRoYW5rcw0K
DQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUmljaGFyZHNv
biwgQnJ1Y2UgPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXks
IEphbnVhcnkgMjEsIDIwMjUgMTI6MTIgUE0NCj4gPiBUbzogZGV2QGRwZGsub3JnDQo+ID4gQ2M6
IFBhdGhhaywgUHJhdmluIDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT47IFJpY2hhcmRzb24sIEJy
dWNlDQo+ID4gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPjsgc3RhYmxlQGRwZGsub3JnDQo+
ID4gU3ViamVjdDogW1BBVENIXSBldmVudC9kbGIyOiBmaXggZXZlbnQgd2VpZ2h0IGhhbmRsaW5n
IGluIFNTRSBjb2RlDQo+ID4gcGF0aA0KPiA+DQo+ID4gQ29tbWl0IDZlMmU5OGQ2Nzc1YiAoImV2
ZW50L2RsYjI6IHN1cHBvcnQgaW5kZXBlbmRlbnQgZW5xdWV1ZSIpDQo+ID4gdXBkYXRlZCB0aGUg
YXZ4NTEyIGNvZGUgcGF0aCB3aXRoIHN1cHBvcnQgZm9yIHRoZSBldmVudCwgb3IgInFlIiB3ZWln
aHRzLg0KPiA+IEhvd2V2ZXIsIHRoZSBTU0UgY29kZSBwYXRoIGxvb2tzIHRvIGhhdmUgYmVlbiBt
aXNzZWQgaW4gdGhlIHVwZGF0ZS4NCj4gPiBVcGRhdGUgdGhlIFNTRSAiYnVpbGRfaGN3cyIgZnVu
Y3Rpb24gdG8gbWF0Y2ggdGhlIGNoYW5nZXMgbWFkZSB0byB0aGUNCj4gPiBBVlgtNTEyIHZlcnNp
b24uDQo+ID4NCj4gPiBCdWd6aWxsYSBJRDogMTYxNg0KPiA+IEZpeGVzOiA2ZTJlOThkNjc3NWIg
KCJldmVudC9kbGIyOiBzdXBwb3J0IGluZGVwZW5kZW50IGVucXVldWUiKQ0KPiA+IENjOiBzdGFi
bGVAZHBkay5vcmcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJy
dWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2V2ZW50L2Rs
YjIvZGxiMl9zc2UuYyB8IDExICsrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ldmVudC9kbGIyL2RsYjJfc3NlLmMNCj4gPiBiL2RyaXZlcnMvZXZlbnQvZGxiMi9kbGIyX3Nz
ZS5jIGluZGV4IDI0OGQ3NTE5ZDUuLmYyZTFmOWZiN2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ldmVudC9kbGIyL2RsYjJfc3NlLmMNCj4gPiArKysgYi9kcml2ZXJzL2V2ZW50L2RsYjIvZGxi
Ml9zc2UuYw0KPiA+IEBAIC0xOTAsMTEgKzE5MCwxMSBAQCBkbGIyX2V2ZW50X2J1aWxkX2hjd3Mo
c3RydWN0IGRsYjJfcG9ydA0KPiAqcW1fcG9ydCwNCj4gPiAgCQlxZVszXS5kYXRhID0gZXZbM10u
dTY0Ow0KPiA+DQo+ID4gIAkJLyogd2lsbCBvbmx5IGJlIHNldCBmb3IgRExCIDIuNSArICovDQo+
ID4gLQkJaWYgKHFtX3BvcnQtPmNxX3dlaWdodCkgew0KPiA+IC0JCQlxZVswXS53ZWlnaHQgPSBl
dlswXS5pbXBsX29wYXF1ZSAmIDM7DQo+ID4gLQkJCXFlWzFdLndlaWdodCA9IGV2WzFdLmltcGxf
b3BhcXVlICYgMzsNCj4gPiAtCQkJcWVbMl0ud2VpZ2h0ID0gZXZbMl0uaW1wbF9vcGFxdWUgJiAz
Ow0KPiA+IC0JCQlxZVszXS53ZWlnaHQgPSBldlszXS5pbXBsX29wYXF1ZSAmIDM7DQo+ID4gKwkJ
aWYgKHFtX3BvcnQtPmRsYjItPmVuYWJsZV9jcV93ZWlnaHQpIHsNCj4gPiArCQkJcWVbMF0ud2Vp
Z2h0ID0NCj4gPiBSVEVfUE1EX0RMQjJfR0VUX1FFX1dFSUdIVCgmZXZbMF0pOw0KPiA+ICsJCQlx
ZVsxXS53ZWlnaHQgPQ0KPiA+IFJURV9QTURfRExCMl9HRVRfUUVfV0VJR0hUKCZldlsxXSk7DQo+
ID4gKwkJCXFlWzJdLndlaWdodCA9DQo+ID4gUlRFX1BNRF9ETEIyX0dFVF9RRV9XRUlHSFQoJmV2
WzJdKTsNCj4gPiArCQkJcWVbM10ud2VpZ2h0ID0NCj4gPiBSVEVfUE1EX0RMQjJfR0VUX1FFX1dF
SUdIVCgmZXZbM10pOw0KPiA+ICAJCX0NCj4gPg0KPiA+ICAJCWJyZWFrOw0KPiA+IEBAIC0yMDUs
NiArMjA1LDcgQEAgZGxiMl9ldmVudF9idWlsZF9oY3dzKHN0cnVjdCBkbGIyX3BvcnQgKnFtX3Bv
cnQsDQo+ID4gIAkJCXFlW2ldLmNtZF9ieXRlID0NCj4gPiAgCQkJCWNtZF9ieXRlX21hcFtxbV9w
b3J0LQ0KPiA+ID5pc19kaXJlY3RlZF1bZXZbaV0ub3BdOw0KPiA+ICAJCQlxZVtpXS5zY2hlZF90
eXBlID0gc2NoZWRfdHlwZVtpXTsNCj4gPiArCQkJcWVbaV0ud2VpZ2h0ID0NCj4gPiBSVEVfUE1E
X0RMQjJfR0VUX1FFX1dFSUdIVCgmZXZbaV0pOw0KPiA+ICAJCQlxZVtpXS5kYXRhID0gZXZbaV0u
dTY0Ow0KPiA+ICAJCQlxZVtpXS5xaWQgPSBxdWV1ZV9pZFtpXTsNCj4gPiAgCQkJcWVbaV0ucHJp
b3JpdHkgPSBFVl9UT19ETEIyX1BSSU8oZXZbaV0ucHJpb3JpdHkpOw0KPiA+IC0tDQo+ID4gMi40
My4wDQoNCg==
