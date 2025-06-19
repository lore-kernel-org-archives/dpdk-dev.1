Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EBC7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 09:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5756942E4C;
	Thu, 19 Jun 2025 11:43:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BF39440275
 for <dev@dpdk.org>; Thu, 19 Jun 2025 11:43:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8St0t014575;
 Thu, 19 Jun 2025 02:43:53 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2113.outbound.protection.outlook.com [40.107.236.113])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cf2u8680-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 02:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQCY6reeijNC5jFj6I+9YiRXqO//3nzsGYpBxI6ekmAMFGV1onofiF00cdK8kCNcLv8P+A0hr8pe4jx8nVzpYn5UZKQbHJdgMzUfB2Fn4DM7VxWH0pn7J+n78V6yEfZooes7Y9uYrhx1nqERTut6WBwSrlmeTak5wJDbMtdwo70Vq8fZwfxiNu8Q8kC4vKGlVFPKDZt9ECTcLyaV5ZAjsKyp5+/HJHKUczPR4/5g8VBwa8fx53KyNZBszOO932g+KcSNgS/qVLw+gvhIcXHnWiuzf1FxOcUYDit0X0SCpdDfBtW1LZCMpF2rCBF5lKwiqlWgmn/CxPtJjq39mEWv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxWpmsRiB2pNjp7lVrOd/fH12CtEX1Pupxdpf868dic=;
 b=v4teGfhZAAw0nEHWHFSMJrlEsYJkgRfb5P3VjOOL5QkCDnv2R6WHwI6qPLOVbHbvOvaSviauoscyqY4oGZZJK09wsNHbEHuaBeNjE9yUqbpsrsSglYOjS6Y4iEdHrchupaOPtia/NBrKSl7iTzwdv6gYTUqgHuQh2rPkTSNo70HXQhQcDB+i/VfloVHuK8Ts5AlQyYq+AdrBvhkX5MhJCJDdReG62Pra/hVdjWx3AmUjeAv07SXrGYYuZNnfoKk834YgZxEsi55I9lKFiNtVd6Qn+zFVtprsC1gqs+T2Gh7o9P0XTxGIOcQt3IvBPprCtEwdfr0emmgwR4e205vikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxWpmsRiB2pNjp7lVrOd/fH12CtEX1Pupxdpf868dic=;
 b=cQTtE8eFnX2aZS+e4JdsmtMciXWaMkstGXHn4j9MyesCbT2fMKMT2x23Qe4VNI2D5sHiQH0tpE8pSVAyfVVR46s/SkUUExp5W0FDQ0CghSAUOphe1VDSX1uNnZxmNDYBG9ArU0AFdtM19s2DNJo4vddeV0Z0f1mq7H4Km/f+U/Q=
Received: from BY3PR18MB4705.namprd18.prod.outlook.com (2603:10b6:a03:3c8::12)
 by SJ4PPFAED947E8E.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 19 Jun
 2025 09:43:49 +0000
Received: from BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::3c75:4e85:e83d:4ac]) by BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::3c75:4e85:e83d:4ac%3]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 09:43:49 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Akhil
 Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Shally Verma <shallyv@marvell.com>,
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>,
 Ayuj Verma <ayverma@marvell.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>
Subject: RE: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHbwZiacBxVlAhw+Ua/Z0S4WXpd/bP/gQsAgAaOmICAAzVMsIABFtPA
Date: Thu, 19 Jun 2025 09:43:49 +0000
Message-ID: <BY3PR18MB4705C949AE6479C7FC232E31CB7DA@BY3PR18MB4705.namprd18.prod.outlook.com>
References: <20250510104452.2186-1-gmuthukrishn@marvell.com>
 <CO1PR18MB471468B21DE770926E149839CB74A@CO1PR18MB4714.namprd18.prod.outlook.com>
 <DS0PR11MB7458F54FAE4573EEA5D30AEF8170A@DS0PR11MB7458.namprd11.prod.outlook.com>
 <CO1PR18MB47144653AC9A8DF6E8B1C697CB72A@CO1PR18MB4714.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB47144653AC9A8DF6E8B1C697CB72A@CO1PR18MB4714.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4705:EE_|SJ4PPFAED947E8E:EE_
x-ms-office365-filtering-correlation-id: 9110aeba-da7e-46e1-a885-08ddaf15cb2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WTRDRWJNcnJ5UVFQbG83VUJ5UGpTNkd3a1VHVzFKeE9vNWh1VnJGNVdRelRW?=
 =?utf-8?B?OEVwZlVzQlhsWjcxQlhUQ1VVTFFHdTE2ZFBHMUxQR1IybGxHTjBmL25HTE1S?=
 =?utf-8?B?REh2KzI5WHcyMEQ0Ti81REsrN09ObEZOdnRzMzdmdmc0NWZocVNLa1ZDSVEw?=
 =?utf-8?B?ZTFYaDMxV3BMbWUrRDI0SCs3ZTlvTjl1Y3RlTFpMdDBNcmVORWZ3cDY5T0pi?=
 =?utf-8?B?M3A2Nmw2SzRhVU53TXFDTzBvWEZyUUZvN05zczFYdmFqVWhaMkI2eUFKd2tY?=
 =?utf-8?B?WmxoMitxNUF2K3JGOGJsRnBybENLc0IyMWhTUTNFTXFjai8rMnptMnhiZEU5?=
 =?utf-8?B?V0Rvd3VOWjAzYlhmTStkMVZEMXJ3c1FnRTFqV2NlR1o2SUttQXcxNDdOWUxC?=
 =?utf-8?B?RkgzeWx0bHdHSFdVY2VFMWh4MGtjQnV1MHJ3MTVOazdXRmlENmkzaGtab0w3?=
 =?utf-8?B?T21Id1dPR1ptMXZoVjhKTE1CUnZIbGgvdFRPMmQ5bDMzaExLdGQxNFFVNXBm?=
 =?utf-8?B?VDFVanhhUmNLODNid2lJdFB2M0cxWG50S2cyY3NsQmFHdFU1ZFFxK29lY1dz?=
 =?utf-8?B?NGVkOTFURmpOV21hZExXYnJNeW0zVk5POWh6bTBpdTkwT0UrWTdFRmRiRGtC?=
 =?utf-8?B?b1c0NHRnQUdtL0c4TUpZY2NGNWQzR01tdzhKUHZ0V0J2Y3JGZnlLOGxFU3Ix?=
 =?utf-8?B?eU01ajFrTXJ1RS8xSVVqWU1ZdjZnRmRtSm51MTQvMSszNDdlTHBIRi96d2Rl?=
 =?utf-8?B?YVBNYlB6MlYzMTF3Smc4cWczaEZiSWFzQnZ3VE4xZXdUc01JVmVGTlZMUmhz?=
 =?utf-8?B?cVJ3cXE1RmE5RnRHZEdOSjM5SW5taDlCVi93NDh3U1Y1NzVMNWxnMUdiM2lD?=
 =?utf-8?B?b3hyanl5MHZMSFZtTGpiaUFndTVoNTVMV3hlSEUvdGRHNW1pUUd1VnVQemdP?=
 =?utf-8?B?Q2RzTkF1SDJIWmtMUlNiNzc3OGNIWGdidlpKZGN0ZVlGNXpndXk3OGp5TXpZ?=
 =?utf-8?B?M2JEUEV0VC9QN25tR2pML2RIeXM1R1RVaGRMSmtHRy81bEdTbDd2ZWI3ZWt4?=
 =?utf-8?B?NWZYTGZ0eGZhUHBnY09wdllHclI5WFJQaTdwdkxSNUpjbWVtWmIyangwbFMr?=
 =?utf-8?B?L3BJbktnR0tJcWM5ZE1uT0RWMVNVdnIvQWRlN2dSTEE5SGNDbFpBNTRoenZD?=
 =?utf-8?B?TzJQcFVhc0lhVGxpSzFYWm1nUmhSNEI3YTJwL3EwdXVTMlM0TzkxclRuRzA3?=
 =?utf-8?B?T1JydnBCaVcvaEY2cGIzSUVySk5MUmZRNXN0SUV1VUFZNzExWHYxRzJUSWFv?=
 =?utf-8?B?MnZVeTZkMWNMOEZwM0Y2cGRhbmVqb21MajBJamQ1MTRLb0RDTnRFUlg4Y1lh?=
 =?utf-8?B?SDNFZDlnYmUvcGVabDlleTNqakU1cncxZWNmNjVmalhiRCt1RkJKd3JjR0ha?=
 =?utf-8?B?cG5GUGYxS1Bpdi9xc0t4alVyWG9pem1yZlFIcy9MaVBWeTk3ZmhiVHAwNHdN?=
 =?utf-8?B?d0J4c3h0WHdMcW5JaGNZcWVOZWNPZlErUGZ2OVJmdlIwL0t4Sy9RaDZjK3p1?=
 =?utf-8?B?cWtXUWZVTjNsR2ZIeE1HMHZJOUFqMEYrQURNSDZZWERrbisvZHp1TUQrUy82?=
 =?utf-8?B?c3RCN21zQURwQVhtSEQ4SzZ5eVAweXFRSjRsRkpuSFVRTWcvUzRDdkZtZmFl?=
 =?utf-8?B?QkhkTmpWL0RYYWEvWlNpZ21RVjNERGNWSUdYQ3JtQ2hXa0QzZytoTkVIaGk4?=
 =?utf-8?B?NTMvU0xPWDNXYVFuNFNVZ3FOZVpRSittWDJsbDZBMGd1c3BRMGpYRTRnRnJw?=
 =?utf-8?B?ZXYyQkJaTk5ob3FybHlpQjRxMWFxYjVKOUpDUDF5MXN5dVdRU0FaTU81cmZB?=
 =?utf-8?B?THhsV3VtbzlWQUxqZ05tb2dmdVZEU1RsSjllamxVK2l3bXZzdjFXUW9TczQ0?=
 =?utf-8?B?dWtZV0wzaXRxTGwvSVRkTnUwNzZhUGt4aXIrTnFNcC91Q0ZsM2NiODI0elVS?=
 =?utf-8?Q?biTHlv5DKJW3PASJhxlN9Z6dQXnb2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4705.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFZJQkV3UjdNa1pYbTBVQUQya1luQ0VIcG1ZbjlNS3hyYkl1aDd1czU2K1NP?=
 =?utf-8?B?Rmcra0c3MGNIQjRPbG5wWElqOFBaZEIyRUoraU1rN0lrWEErNzA4b2twaVFu?=
 =?utf-8?B?T29iQVcxOVBUVUlkVUVGYzFqdFlKMlNnM1czM2F2NlJPTU9YaVpFSjVxK2Na?=
 =?utf-8?B?dlVyNUNmYXNQTlBSTDJka0Yzck1LYWZoQ1gwTjNBOWVORzUwRWdhV1lWLzRD?=
 =?utf-8?B?UW0wcFM4amtsQlh4ejdxNVg0UXRyaXgyNkt0dW9NNzJyeVF2ajhvSG9IbWdU?=
 =?utf-8?B?TXZQTDJQNk5Db1VTc3RlbWpBbHgrMElPNkZhZVYvbGVodTF4Q2JBNi9OSWlj?=
 =?utf-8?B?d2pqdzlhRFJCbWVwTHlNMCtJRi91TkhxQklWVnNYTllFQjJKSFk0dHR0RHM3?=
 =?utf-8?B?Kyt2ZDBGcHk4VFoydUN3NnpsZnZmaWorREZtaDUzSkRnWENUTFM5VE9DVGcz?=
 =?utf-8?B?Vit1ejBTUkwxZDllRmFZV2VsbXRUQzlZMHlrajNoYTZUVmM2NjNIakk0OVY0?=
 =?utf-8?B?VUZsS0JZVE5hQU4rc0RnQWdudy9BNlB5bmt1cXhwYlF0L1NNTlh1RzJiemtQ?=
 =?utf-8?B?V2xMSzBRT1lCR201eG1UK1hOWVBheDVCbjNqbGRSSHNyb2RjKzA2R21WRjFJ?=
 =?utf-8?B?Rm81SGptc2NOREswM0M3cnV2SHcwN1FkTDZtaG9rdVJScXBGUHNjZjYzRGFt?=
 =?utf-8?B?YXhSTlNtcExPWmdoWWwxUkljYS9JRzhGUm5mWjRTRlQ5Tm9UQWRDY2Jmb2hB?=
 =?utf-8?B?L3d3WFhqZDgwRmdSZGRudWNxelpkZHJYRmNSL3FrZmNJdVM3RTM4S3A5aEhz?=
 =?utf-8?B?SGVMZWR0V0V6SlI0VmY2b29oVmtONml5cVRDTmNOdnN1alM1ekQyN2szYWJO?=
 =?utf-8?B?RFcwWkFlZk5kcEsxeEVxakh4WkZYSWE5cWZNdjRtMlUyR29VQklDbGtObHNE?=
 =?utf-8?B?ZnJtTlZZdTF3Yll3MEN0b3czSURvL2dpTWJKUWdQclJlSFRuYjZibmdzQ3Q4?=
 =?utf-8?B?ZHAzd0FWMmJPcmNTSE1JaXZVRHdqQUloby9nQUNBSnltYm1ocmR4dWYwSkZn?=
 =?utf-8?B?eDh5ckIzMmtKd25oTDk2U0Urb3FpME0wK2JlSVdOOXR2aFpxR2dIWW9odUw1?=
 =?utf-8?B?YmF0cXVNVkVQUW9xTjNFbTl1UUMwWGhIaGc3Y3MwbXZjTmFqaVJ0cjB1M3dS?=
 =?utf-8?B?bGpCcVRFYVBRT25Md1Q4RWNONE1CVnMxSUxOUUIxR2d2TUNMVll6bFViZnlO?=
 =?utf-8?B?bm13SzF4eXc5UjFuS0kyMkVtTkNxVlJkejNUTEk3YmxUamlzaTRHRm41YThZ?=
 =?utf-8?B?QmM2Tll3cGMxejBBanFCOUxWWDgzV3lJZllxOU5zQU1uV0l3eFAvcEhndHk3?=
 =?utf-8?B?blpxZTRHUUk4bXhBRzVJUnZiQkFMNWFBSDluTENPaWdRakdkaE8zNlViMk0v?=
 =?utf-8?B?N1BsaFJCQkhWb05oT1RNWW9oSkoxYzhNZHR1UjRCUTUyQzFwOENzKy82OGkv?=
 =?utf-8?B?R0dJMGZZa2hFcTd1WlJyMEtNc2E5TG1TdS9XVnVnTmNNYUtET2xXQThLemZp?=
 =?utf-8?B?MEpHOEdOVGU2ajArT3hvU0R3MHZLa3FRWm43NE1oK1lOVDdkYmt0RFg4T3RH?=
 =?utf-8?B?SkJ0Nmt5L09KMHV1Q2hrTFNqTzNNOEJRMFdub1huZFNNcTBsbjNXd1VLSm10?=
 =?utf-8?B?czQ0MGhLTm1panp1TTIwdmxQb2d1Z1dJbTNDekFIVSs5b0thNXFGS1lleGFX?=
 =?utf-8?B?bjN2S2lqRVRxbVlzeVlNUWt3ZEFaYTJkTFN6QkYrcFBLOEFyTTlhTlBBM0lm?=
 =?utf-8?B?d1JUN1NLeWVxQjFod2VtR0d1ZjMyc0lXUUpJeXhjbFk4dG54WnhTK2VEM3Y3?=
 =?utf-8?B?K2U1WkVJeEZjY2E4UFoyMGpiL1Q0dU13NmU4K0VrRENWbUx3RitkUVNrRE56?=
 =?utf-8?B?bnBGSlJFVlM5cDdQQnZDN1BZTE9FdVhvbkM0UkFXYllnZ3E2M3Y1NU5abWdh?=
 =?utf-8?B?UFN6YUFUYWdXUVFFWXIwL0F4Rjl6MDlISXhoOEIzcjJHUnBWdFVYOVNEZXpS?=
 =?utf-8?B?OWxKYUZ4bWFZT2ZQaklySC9wYk9UcGt0UkVlcVpYVzhNWGFFMmZHaXZvUEdS?=
 =?utf-8?Q?kVBi19L80nHD8njymemeigBJm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4705.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9110aeba-da7e-46e1-a885-08ddaf15cb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 09:43:49.3842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3nowFcScR1qIDYsrq6xEz/ziNAvcg68it1dWmgmkdTnOlohKG5m7VF728MUxvBG87BMezK/3i8Q6R/N7q53JWQ0t1mJQlKpidZob1+f9QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFAED947E8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA4MSBTYWx0ZWRfX7bOJ74XXNA3D
 ynxl8IfFZt6V2itQ0Na9rdwHIUSpPCccgocNMyks/C9tisvBiN8W5OAU7g1mf+5pXHhwIGGTLDj
 yMuUkKp/56OsTXHmvVI06Rzu5wwE+LSD9wFUkzLLfM4GnisIgn1iEIIVE+Cj4OXlshlBcVeAT1g
 v8ONF5IK+PKg1igAvso/dA9f3invDk5v9K9kveDceeGtnE1ZpbpxGZfIoKsYxmf/jxVgyOxSoBZ
 A5XtSBdOj9wLn0a7bkc4DRWvA5UDzJmQWxEuOXlNbHZ59mDUc6b2FpLj1FdsIqZy10yq51MKfZN
 Oc6nhycFrd4PuKhEoFnTHbs7nGqPANMxQCe52RXu7Pvz6/Nazd1aR7KKifA7s4VEhnL/bleJnNX
 EnuRvWKnbkycUrLD4IRDDLWLZSvf72XhwSUFHTzZnMDBmKPinhRzHIKpVZlLYQNQePY7jvWe
X-Proofpoint-GUID: VJtoNvJXE6fu25X__ECdHkygI1NDhp5A
X-Proofpoint-ORIG-GUID: VJtoNvJXE6fu25X__ECdHkygI1NDhp5A
X-Authority-Analysis: v=2.4 cv=dsXbC0g4 c=1 sm=1 tr=0 ts=6853dbd9 cx=c_pps
 a=0xUoO+0uXwFs3PMPUfxnog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=vNdqKQXloGzOGoXB5KYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
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

SGkgS2FpIEppLA0KRGVidWdnZWQgaXQgdXNpbmcgb3BlbnNzbCBzb3VyY2UgY29kZSB1c2VkIGlu
IHRoZXNlIGRpc3Ryb3MgYW5kIHRoZSBmYWlsdXJlIGZvdW5kIGR1ZSB0byBiZWxvdw0KSW1wbGlj
aXQgcmVqZWN0aW9uIGFkZGVkIGluIFBLQ1MgcGFkZGluZy4NCg0KaHR0cHM6Ly9naXRodWIuY29t
L29wZW5zc2wvb3BlbnNzbC9wdWxsLzEzODE3L2NvbW1pdHMvM2I5OWRjYjFhNmRmNjg1MzU4MWQz
MDM1YzZkOWEyM2E4MzE3MTZiYg0KDQpBcyBwYXJ0IG9mIHRoZSBhYm92ZSBmaXgsIHJzYV9vc3Ns
X3ByaXZhdGVfZGVjcnlwdCgpIHdvdWxkIGFkZGl0aW9uYWxseSBuZWVkIHByaXZhdGUgZXhwb25l
bnQNCnJzYS0+ZCwgYXNzdW1pbmcgdGhhdCBkIGlzIGFscmVhZHkgcGFydCBvZiBSU0Egc2Vzc2lv
biwgdG8gZGVyaXZlIGtkayB1c2VkIGluIGltcGxpY2l0IHJlamVjdGlvbi4NCldlIGRpZCBub3Qg
aGF2ZSBpdCBpbiBDUlQgdGVzdCB2ZWN0b3JzIHRvZGF5LiBJJ2xsIHNlbmQgcGF0Y2ggdG8gZml4
IHRoZXNlLg0KDQpUaGFua3MsDQpHb3dyaXNoYW5rYXINCj4gDQo+IEhpIEthaSBKaSwNCj4gPg0K
PiA+IEhpIEdvd3Jpc2hhbmthciwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgcmVhY2ggb3V0LCBJIGRv
bid0IGhhdmUgdGhvc2UgZW52aXJvbm1lbnRzIHNldHVwIG9uIG15IGVuZCwNCj4gPiBidXQgVWJ1
bnR1IDIwLjA0IGFuZCBSSEVMOCAgYXJlIG9sZCBidXQgc3RpbGwgY29tbW9uIExUUyBwYWNrYWdl
cy4NCj4gPiBBcmUgeW91IGFibGUgdG8gZHVtcCB0aGUgYWN0dWFsIG1zZyBidWZmZXIgPw0KPiA+
DQo+IA0KPiBSU0FfcHJpdmF0ZV9kZWNyeXB0IGZhaWxzIGFuZCByZXR1cm4gY29kZSBpcyAtMS4g
T3V0cHV0IGJ1ZmZlciBpcyB1bnRvdWNoZWQuDQo+IA0KPiBJIGR1bXBlZCBlcnJvciBjb2RlIG9m
IGl0Og0KPiBlcnJvcjowNDA2NzA4NDpyc2Egcm91dGluZXM6cnNhX29zc2xfcHVibGljX2RlY3J5
cHQ6ZGF0YSB0b28gbGFyZ2UgZm9yDQo+IG1vZHVsdXMNCj4gDQo+IFdoZW4gSSB1c2VkIHNhbWUg
b3BlbnNzbCBsaWJyYXJ5IHRoYXQgSSBjb21waWxlZCwgbm8gZXJyb3IgaXMgc2Vlbi4gQWxzbywg
cHVibGljDQo+IGRlY3J5cHQgZnVuY3Rpb24gaXMgY2FsbGVkLCBidXQgaXQgc2hvdWxkIGJlIHBy
aXZhdGUgZGVjcnlwdCB0byBiZSBjYWxsZWQuDQo+IA0KPiBKRllJIGVuZCBvZiBsaWZlIGZvciBm
dWxsIHN1cHBvcnQgYWxyZWFkeSBvdmVyIGZvciB0aGUgYWJvdmUgZGlzdHJvcy4gTm90IHN1cmUg
aWYNCj4gdGhlIE9wZW5zc2wgMS4xLjEgaW4gdGhlbSBuZWVkIHNvbWUgZml4IGZvciBhYm92ZS4N
Cj4gDQo+IFRoYW5rcywNCj4gR293cmlzaGFua2FyDQo+IA0KDQo=
