Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F96C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 10:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E40A402A0;
	Fri,  2 May 2025 12:38:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF9774029E
 for <dev@dpdk.org>; Fri,  2 May 2025 12:38:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541NU8GT008573;
 Fri, 2 May 2025 03:38:30 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46cjpb90p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 03:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9XCVy9k6XnUrsOxvvzQEzRJt0dp0gjYGyO6lfFfeeGHMxFJxA5mqeTstRm9Eto/1Lpvgatn3AgpsruBwoAb6Bnf2AtYmH+flvCqcAr1I7aMywYQb2ddCsfFZ5vj4rJdcx3X2w+2UEG36WW6XDY8pmHj4laueiO6QX6na3T2xczSCKtH5yePbFhtUo8TPnRPydAIMT63G2AW/5KV2sUFo6oShImKrfIgkAwgUE4Pu9z5iq7YQIulrAn/11ZKitze+ycatzFbvtAHN0Z/MSHZw8bY8/H2qQfPp3oiwVkzrWR+zrDOpRlYbJosv23Rpd2d31W+ebxkV33n5xd4w1omGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBDPDSDLfFYFE9kptvl/yhPo5lA4auZy/OaucT5N9jU=;
 b=tToK7c7BkxeJ0YLgIfzROupjAMYUdN0IrqDjoU27O1kGT4bIQC6I5reOE4P+CZ5zFMEDfCAahpXKFs8hgcUKflFhq6thhCg0s3nW19PQa5fZ2q9UfXBeb2JmQTy0GyNwN9HRox7puXdjBY5H9T8tcWH4KGyOS69nxCFx/rpyz9Y1En3ZPDeRPmvhFISWSygF3uu/OHFhteKQTNmvIFrpoImu1kw9tmSlML9+59gvN0VTuvcS042q+1AOy9ze4fbnSBTwRdQCkRpPllp195cmqds/KREqG3E+WI1Uy7wMPb8XC3EKTXJax3m9zocYe53AAlsaESCqJX3BZWU5obrlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBDPDSDLfFYFE9kptvl/yhPo5lA4auZy/OaucT5N9jU=;
 b=Iojw4V7ncdgQMRatC+P1YtFFlFl3wjb/hO35ncfMsXDaogc5irhTIJYMnUzsqsRdPVMADueJf28elNOvUgUEyk+I+spbQk8PBsP5sDYgf9W8Ul2+Rf0QANDofXDoYYisJKCsnrYm71x+heGl9P9HIGTWA8qV9k0lqi7CeSAktKY=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CH3PR18MB5892.namprd18.prod.outlook.com (2603:10b6:610:1d8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Fri, 2 May 2025 10:38:25 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 10:38:25 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: fengchengwen <fengchengwen@huawei.com>, Jerin Jacob <jerinj@marvell.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Gagandeep Singh <g.singh@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
CC: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "conor.walsh@intel.com"
 <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [25.11 PATCH 1/3] dmadev: add enqueue dequeue
 operations
Thread-Topic: [EXTERNAL] Re: [25.11 PATCH 1/3] dmadev: add enqueue dequeue
 operations
Thread-Index: AQHbrreyz5miFhWK0km02tBi3lYff7Oyb/QAgAzKnuA=
Date: Fri, 2 May 2025 10:38:24 +0000
Message-ID: <PH0PR18MB408689F0B8A3A2C2DBE801C8DE8D2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
 <20250416100931.6544-2-pbhagavatula@marvell.com>
 <b296e45a-131e-4956-a9dd-260d7a120996@huawei.com>
In-Reply-To: <b296e45a-131e-4956-a9dd-260d7a120996@huawei.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CH3PR18MB5892:EE_
x-ms-office365-filtering-correlation-id: 0e849e0b-fc59-457f-e197-08dd896577bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1d3KythK2ticVBGandNYU5WMlJ0b3RDZ2IzcW1GdG1qYjBxT3RhcGlBbHA2?=
 =?utf-8?B?SERmbDZrcEo4QVJOK0pNQTJkZUgyZEVrMW5DeDl4RUlnZUd4b05peVRGQjFh?=
 =?utf-8?B?Nnk3dVVHYk1GRVZUSVpMSHlIMGcwaTR2YU12Qm0yd3B2ekxLeGowbHRMV01a?=
 =?utf-8?B?UHU1TVcyUS9scnhqNzFWRE5ORHpxWjJ3RWl0T0pQSmNKMjJCbVVpbEppRkJB?=
 =?utf-8?B?ajE4d3BYRk5IQU4wSm9jM0JDT1Rwck5nR0hUek9ORXJaM05sR0t6MkV4M2FX?=
 =?utf-8?B?U3o5Vnp0b2kwZ25FZURVaTB0Yzh4OUtwcmhJc0J1djFKTkVZYVlmYUFMYnMx?=
 =?utf-8?B?OEp1QUFFVnNZR3YzOVNCWWh5dTRDTlVPc2hoRXBabHYxK3dWWEdYcHlRSWVo?=
 =?utf-8?B?ZGFGeWNBSFNCRkxzSWZhVDhrbmRsbTRrZFgxdnk3R3FLOXIvem10T3kwUzJl?=
 =?utf-8?B?YjB1NDA4SzFLMy9mSVZ1U1lPOGJ0YS9pWGY2TUhuUUNiMDZCaGwrbEovY2pX?=
 =?utf-8?B?OWNEQzREMlFIbFcvb3pTVjZuMmpORzNRaUQ3R0xleXFQOHViVmJUdDdtb3Q2?=
 =?utf-8?B?OXl1OHRORk1VVFJYMXI2cStITEptb0VMUEJicU1TMUpZWkRlZFdHRUhSbUVr?=
 =?utf-8?B?VDE2Znhuc0xTc204MWFhc3lVSlpoQ09BTnpoSmxDNWRYWlpiV1IrLzZuL1Nl?=
 =?utf-8?B?MGJNbiszK0lveGRMTXN6aG5TU0dTL2lzbVVRTk1yS05oRXErL0l1a3FCbUUz?=
 =?utf-8?B?ZTJwRVZHU25pdlp5bkxGZm5UZU8zM2c5NnBici9tSThBSE1hWjZCRDhOZXBF?=
 =?utf-8?B?bTh0MUZPT1V6NGdSLzhlR3huOGpHVEY2bmExU0VoWTBSMUVXOXo2YnN3Z1k2?=
 =?utf-8?B?dXFVQ1ExZXlSWFhBS1BhL2hMWVc5OGVrempFZ0ZpZFZENFA5MkJCcUJFRmlQ?=
 =?utf-8?B?MWQyTnQxTzFVTThHWklpaDFvOG1rS2o3QS9BR0NnYVlsays2YmQxZXVtQWt5?=
 =?utf-8?B?eTJSTXJBeXFjY2xsSElRNWtwYitSWWtpRkE4b0ozUkg4dkk3cDlPM05MQWVG?=
 =?utf-8?B?SHBNb0ZXNUNxYWNrVkc4UW9POXVVK2dLcGdDMjBOVUxqQng5L1BXZ3lEZWY5?=
 =?utf-8?B?dVAxdVZzbE5jNFZVVm1nc2ZaYXNnRE9ld25DRkVKeFdwNWliakNlaHlWZUE3?=
 =?utf-8?B?Vlp3UE9xeGQ3NXFpakVweFpVQ3VtNEJpL0E3UmtmUEErTlZXSFFGZkZ3YUNB?=
 =?utf-8?B?MkVpa25kNVFpaUxLVmN6SWNJdk1VTXdaeVg3ZFhnMXJsUXJwb0hzZ0tkZnpl?=
 =?utf-8?B?QWJKR1dadFN2TVlCZlIxekJ2c3FrTUt1bGxlTGswYXdhMzJYdEoxQXFkMmxt?=
 =?utf-8?B?UndvRlFlMzA4VktQdzJjM0g0dVlnKzZSR3lLT0d5WENJeXVYVGFvcmFqUVhr?=
 =?utf-8?B?RTQ1blpody9tcGNraXl0SVJYSDc0ai9hTjByeU5JbFdrSDEwNGdQQUoza2Mw?=
 =?utf-8?B?cDBRZk5rV0FQSlB1UmNlSER4dzNqNVU5YmVEckVrR3ZINWxpRzFuNFpCaUp0?=
 =?utf-8?B?Z0JoMkVudFdVby9mVVp2aTRrWTU2bWRaSjNXSkRpRVdjNVBLSUlSWXR3TE9Q?=
 =?utf-8?B?NXdvamd3QzVGek9HVmh4TVNyRk1WYmUzbElobEZWVzk4TDJjOFJ1clNyS1kv?=
 =?utf-8?B?RUF3WmlSVzlDT0VWb2p0OERKV2RYVmgzY0NaY215d0JoeFkzMHNYVUdkdDhB?=
 =?utf-8?B?MWQxdnBOQVNhejVJS1dTb09yR01jNjdwSHQ4YU1LYkdCTnB1OVV6eXZPd1Vj?=
 =?utf-8?B?WndnQzNpbnhWRmRVY3NnUnFrUkNrdjAxZ0JWcHdQakdVUExVencrbXNxNVMx?=
 =?utf-8?B?MVFlZlBSWmRnRVlRejZuMXh0S2FpYkhSR2syZmRpUnFsVzVmdW9IeEp0dFpp?=
 =?utf-8?B?WGxKZzJjYnhFVzhNZlRHMnJ0dk1lczVPMDRTYk10eGNGRzRXRnFQcTh1ME1S?=
 =?utf-8?Q?Y3g171G3awAfcFG9oRVvn+c6zcU9lM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2pmd013TmQrVzZaYWVhbDRGa0tRWlFlQ0pTL3liQ3hkcytWM1ZyREZOY1JK?=
 =?utf-8?B?eXg2RGowTW1hemZjbkFLekZMaXFwRDk5b1RKV3BxZWF6VWJEdm40Mi9ubGFV?=
 =?utf-8?B?bG5lYUhQbnFJdnVERTlPa1V0RmVpRmFaQlRVcHg1eUp4M2huOTdVN1ZyVkk0?=
 =?utf-8?B?UUFTQ3pwamRpYys5QUJEak1nQzVydVA3MnQwc2U1QWVWaHpHV0dIak9VdmZZ?=
 =?utf-8?B?WFBDU1N0clpkUkVuZVp3dENmcng3NHljVFJEQytJOUQ1MENxamZENG8xQVpl?=
 =?utf-8?B?WDN0aVpYUXBBcHpWTDhmWXdmenBJWVA2YmkxT2d6ZHBLZ2NIcjl6ZE44ZTVM?=
 =?utf-8?B?bkh3U1hhN2VqUm0vay82U0M1dTV3ZGNWcFpmc3BscWlCV3dpcWY5cWZyajVP?=
 =?utf-8?B?TFN2RllQenkyT3hvMmdlc2FzanM0bmFONHdjTVZFcEVFcUg4OEgvd3FLOWNj?=
 =?utf-8?B?ZU1zMGlsSVc0L2p6dVY3ckgyN25KNWthSXBRN01ENng4UE5KRm9aUHBKU0p6?=
 =?utf-8?B?OEhHaGdSK0JxRlpETkdrUkFRYlJiclprQUtRY01QZzNGY1J0LzBHOGd3WVhp?=
 =?utf-8?B?SDVoRWZ1eWc5SCtZeG01NUZPRmZKK3FKdUlrYlpPT1JxRWMvbTFVNmxkb09m?=
 =?utf-8?B?T0lMWmlrZGM4ZFBydS90VmFHMGZLelRWNFJmWllzOVJsZW1aNHkvYUR5OUFH?=
 =?utf-8?B?VmV1SzkrQi82OHJiV2lYeFlWaDBPMTRnMGdhZTBxY3dkakVqRXdhWE5FNnBa?=
 =?utf-8?B?OCttWUxuSVlqMnpXZjdYZGFjUE1QdjVmOHJLSUs4aG9PZDJBVEh5NUwwY1J2?=
 =?utf-8?B?QzRFZFQwYTZPVFBpb1NUcEhZM1oyZXZTUjdJSkRkNmxqRWhrWEhuM2oybUlx?=
 =?utf-8?B?amwwWm5VNjVOazcyUEpoM3dWK0o5NXBvUklvQ1JZRUN4S1BJQkRyMGF5SytC?=
 =?utf-8?B?NkVYV241dU9INkxpdHpjNzZ2T0JDYmR2VEpRQjRxdE5RTm0yNWNqaFovYm40?=
 =?utf-8?B?eFB0QlNELzhmRTF0blpEMnluVjMvejEyZitMeVYwSDl2a2xFcFg5b245MHpP?=
 =?utf-8?B?SFpKWWZ4cnBVMk41MU1SSXQ2Tmt0SHFiU3dGYlcwQ2xzcDR0Qy9CMG05blRy?=
 =?utf-8?B?a0ZRL1I2aTZKcXUxQjI3TDZFRVJSUXR6bHVYN09yM2piVlpzWGRIbGJLTm8w?=
 =?utf-8?B?NFpsSE90c28wWEZBVHJCdVpSakVrTFdHaURwc3JoK2J2MEVLblZkVlRaaWxx?=
 =?utf-8?B?T1Y3S2s0NmRnRTZVb2h2eFdaK3EraDJpaU5OT3pOQ3dkVnZKNW44V01KdGpX?=
 =?utf-8?B?cjNmeURUUGFmTXRMYk02VC8vQ2UwbEovWURkZERocWxUWElzUUxzeHVCTk9M?=
 =?utf-8?B?UlF6VUdrK2Z2MlBERDJVUzNjbisxbXVZWG1ZMlVOcDY5aWtUNDBaM0xEbm0r?=
 =?utf-8?B?SUxvVjlJZ09oUVhyRCsyVlM2aTJWZEJYUHY3UCtDSW1aZVlydnBXeDZobjh6?=
 =?utf-8?B?ZTRaUHNJRGZFeHdhUGJaZEZNaDk2c2k4bUV0Y0lnR0w5czJqSThKb01Zb2hl?=
 =?utf-8?B?M09ueTQ3NjRxL0o1V2hOSEVjVXZpTlh3NkNGTXNJdUovWmxlT05qTUQzbEFi?=
 =?utf-8?B?alFzN2dVaEhsMytvSTQzckcvNUxFaEdkMkg4V3VVN2YrNVZabDE0R3pEdW1L?=
 =?utf-8?B?ZHl3dW5yaitrVWdNLzE0dzJtbDNMY2dhbUtlQlVKa1dsQmJHdnBGNWhJYmx4?=
 =?utf-8?B?UDNDRHpCU0JjNElkNVN4KzBSUlJXMGtsUVRXM2JjSlhlaUdmak9abis0OTh1?=
 =?utf-8?B?MTJaVGNmdnIwUGZoLzhRQk5Gb3lMSDdKYllJc1o4OTlvQUpZTWJGcUtQeDlU?=
 =?utf-8?B?b2hUeGxvbnNkVEtGSWFacHZaZ2RZUW4wKzBBWHNoSWg4M1lnZ2dpYzBlWmli?=
 =?utf-8?B?MzNwc2xTS0FGUVdPMEtaYlRISGI5eFI1QW9GdEprbDB0amdSRTYvbCtHM0dq?=
 =?utf-8?B?WGF4aUROS1ZDcmRDMXJJTExDR0tIMU45Y3I2N1JHM0oyRFJLbTVGdjdBMWlH?=
 =?utf-8?B?TSt6UWlDazhkbXNUR05VOU5kZVNVL041dmY3YjBMcDF1eGJxWVNCY09mejRy?=
 =?utf-8?Q?P7n3bzX93RnZ884ZLfEIXDmAj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e849e0b-fc59-457f-e197-08dd896577bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 10:38:24.9518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a93PNkJzpjL24h59o3EQMzTCK1yT0pTADcnxVDsRYw8NxRULbh4b/gnUXG5eFm/6SmFB5+oCa9T5jVnHohEpoQp68vUdHtb4NxtkXZXAEic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5892
X-Proofpoint-GUID: ZbQnVbrMDndb73VvCFWXohtsyQdXU718
X-Proofpoint-ORIG-GUID: ZbQnVbrMDndb73VvCFWXohtsyQdXU718
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=6814a0a5 cx=c_pps
 a=mbHLYBybxRkByWxHAZWYkg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=agsaKc6x9Aqx-Jkwk2MA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA4MyBTYWx0ZWRfX9KG28fG2iayS
 OgJtOCvmGstiEWGOOr9zxN6F/p7qN7HjqYogQLGwdSMu0ymAc35uHaCmLgqv/g5rGBKfHpVqMEv
 ZY/kq8YtksOsJ8+Tna100m5UwwPQFVOcXkUAZbFnNlQA7GkBDhiOvtLz/oWK0haEaggGMnWDjhY
 u9CuWfubM1nsPn06C0fUbYOuwDEL1l0O9mAD4lKcNkBIMnN3/69NoBTjylSsnskrtSmXML5X6f1
 JJvLrDlFknMwdvOzSX0JDynyHlljiLWp7aAZe/nB/YkdJqEZtFJFVr1ubtYRTtM904jxFV5PXRW
 UycT9f1IdDNREKVoMykzVQKj9P/aqTJsUhRwzy2TuxbTYR4LEKveiUZoHjmnitAWu1+LJEzDyFM
 TbIeK6OrRCfejpsKNf5eIfjzuHFOL0fmx9J/ve8G/0REdgxLiSUE9ApFCVDyK547xypMT0ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_01,2025-04-30_01,2025-02-21_01
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

SGkgRmVuZ2NoZW5nd2VuLCANCg0KPiBIaSBQYXZhbiwNCj4gDQo+IE9uIDIwMjUvNC8xNiAxODow
OSwgcGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tIHdyb3RlOg0KPiA+IEZyb206IFBhdmFuIE5pa2hp
bGVzaCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KPiA+DQo+ID4gQWRkIGVucXVldWUvZGVx
dWV1ZSBvcGVyYXRpb25zIHRoYXQgdXNlIHN0cnVjdCBydGVfZG1hX29wDQo+ID4gdG8gY29tbXVu
aWNhdGUgd2l0aCB0aGUgZG1hIGRldmljZS4NCj4gPiBUaGVzZSBvcGVyYXRpb25zIG5lZWQgdG8g
YmUgZW5hYmxlZCBhdCBkbWEgZGV2aWNlIGNvbmZpZ3VyYXRpb24NCj4gPiB0aW1lIGJ5IHNldHRp
bmcgdGhlIGZsYWcgcnRlX2RtYV9jb25mOjplbmFibGVfZW5xX2RlcSBpZiB0aGUNCj4gPiBkZXZp
Y2Ugc3VwcG9ydHMgUlRFX0RNQV9DQVBBX09QU19FTlFfREVRIGNhcGFiaWxpdHkuDQo+ID4gVGhl
IGVucXVldWUgZGVxdWV1ZSBvcGVyYXRpb25zIGFyZSBub3QgY29tcGF0aWJsZSB3aXRoDQo+ID4g
cnRlX2RtYV9jb3B5LCBydGVfZG1hX2NvcHlfc2csIHJ0ZV9kbWFfZmlsbCwgcnRlX2RtYV9zdWJt
aXQsDQo+ID4gcnRlX2RtYV9jb21wbGV0ZWQsIHJ0ZV9kbWFfY29tcGxldGVkX3N0YXR1cyByYW5n
ZSBvZiBBUElzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGF2YW4gTmlraGlsZXNoIDxwYmhh
Z2F2YXR1bGFAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gIGFwcC90ZXN0L3Rlc3RfZG1hZGV2
LmMgICAgICAgICAgICAgICB8IDE2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
YXBwL3Rlc3QvdGVzdF9kbWFkZXZfYXBpLmMgICAgICAgICAgIHwgIDc4ICsrKysrKysrKysrLS0N
Cj4gPiAgZG9jL2d1aWRlcy9wcm9nX2d1aWRlL2RtYWRldi5yc3QgICAgIHwgIDM0ICsrKysrKw0K
PiA+ICBkcml2ZXJzL2RtYS9kcGFhL2RwYWFfcWRtYS5jICAgICAgICAgfCAgIDIgKy0NCj4gPiAg
ZHJpdmVycy9kbWEvZHBhYTIvZHBhYTJfcWRtYS5jICAgICAgIHwgICAyICstDQo+ID4gIGxpYi9k
bWFkZXYvcnRlX2RtYWRldi5jICAgICAgICAgICAgICB8ICAzMCArKysrLQ0KPiA+ICBsaWIvZG1h
ZGV2L3J0ZV9kbWFkZXYuaCAgICAgICAgICAgICAgfCAxNTUgKysrKysrKysrKysrKysrKysrKysr
KysrLS0NCj4gPiAgbGliL2RtYWRldi9ydGVfZG1hZGV2X2NvcmUuaCAgICAgICAgIHwgIDEwICsr
DQo+ID4gIGxpYi9kbWFkZXYvcnRlX2RtYWRldl90cmFjZS5oICAgICAgICB8ICAgMiArLQ0KPiA+
ICBsaWIvZG1hZGV2L3J0ZV9kbWFkZXZfdHJhY2VfZnAuaCAgICAgfCAgMjAgKysrKw0KPiA+ICBs
aWIvZG1hZGV2L3J0ZV9kbWFkZXZfdHJhY2VfcG9pbnRzLmMgfCAgIDYgKw0KPiA+ICAxMSBmaWxl
cyBjaGFuZ2VkLCA0NzcgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBJdCBz
ZWVtZWQgdGhpcyBBUEkgY291bGRuJ3QgdXNlIGF0IHRoZSBzYW1lIHRpbWUgd2l0aCBvcmlnaW5h
bCBBUEkuIENvdWxkIHlvdQ0KPiBkZXNjcmliZSB0aGlzIGV4cGxpY2l0bHk/DQoNCkFjaywgSSB3
aWxsIGFkZCBtb3JlIGRvY3VtZW50YXRpb24gaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiBJJ20g
aW5mZXJyaW5nIHRoYXQgdGhpcyBmZWF0dXJlIGlzIGFkZGVkIG1haW5seSBmb3IgcGVyZm9ybWFu
Y2UuIGFuZCB3ZSB0cmFkZWQNCj4gaXQgb2ZmIHdoZW4gZGVzaWduIHRoZSBBUEkuDQo+IFNvIGNv
dWxkIHlvdSBzaGFyZSB0aGUgcGVyZm9ybWFuY2UgZ2FpbiB3aGVuIHVzZSB0aGlzIEFQSSBjb21w
YXJlZCB3aXRoDQo+IG9yaWdpbmFsIEFQST8NCg0KU3VyZSwgSW4gdGhlIG5leHQgdmVyc2lvbiBJ
IHdpbGwgdXBkYXRlIGRtYS1wZXJmIHRvIGhhdmUgYW4gb3B0aW9uIHRvIHRlc3QgdGhpcyBhbmQg
DQphbHNvIHNoYXJlIHRoZSBwZXJmb3JtYW5jZSB1cGxpZnQgb24gb3VyIHBsYXRmb3JtLg0KDQpO
b3RlIHRoYXQgd2UgZm91bmQgdGhpcyBzdHlsZSBvZiBBUEkgdG8gYmUgZXh0cmVtZWx5IGhlbHBm
dWwgaW4gb25lIG9mIG91ciB2aXJ0aW8NCnVzZSBjYXNlIHRvIHJlZHVjZSBsYXRlbmN5Lg0KDQo+
IA0KPiBZb3UgaGF2ZSBzaG93IHRoZSBwcm9ncmFtbWluZyBtb2RlbCBmb3IgdGhlIGVucXVldWUv
ZGVxdWV1ZSBvcGVyYXRpb25zDQo+IGF0IGNvdmVyIGxldHRlciwgdGhhdCdzIG5pY2UsDQo+IGJ1
dCBJIHdhbnQgdG8ga25vdyB0aGUgaGlnaGVyIGxldmVsOiBob3cgdGhlIGxpYnJhcnkgQVBJIGlu
dGVyYWN0IHdpdGgNCj4gQXBwbGljYXRpb24uIHNvIHRoYXQgSSBjYW4NCj4gdW5kZXJzdGFuZCB3
aHkgdGhlIHJ0ZV9kbWFfb3AgY29udGFpbiBzbyBzdWNoIGZpZWxkcy4NCg0KcnRlX2RtYV9vcCBp
cyBhbHNvIHVzZWQgaW4gZXZlbnRfZG1hX2FkYXB0ZXIgYW5kIGxvdCBvZiBmaWVsZHMgYXJlIHVz
ZWQgaW4gDQp0aGUgZXZlbnQgQVBJLiBJIHRoaW5rIHdlIGNhbiBmdXJ0aGVyIGltcHJvdmUgdGhl
IGVucXVldWUvZGVxdWV1ZSBBUEkgYnkNCnJlYWRpbmcgdGhlIHZjaGFuIGZyb20gcnRlX2RtYV9v
cCBpbnN0ZWFkIG9mIHBhc3NpbmcgaXQgYXMgYSBwYXJhbWV0ZXIuDQoNCj4gDQo+IEFuZCBhbHNv
LCBwbGVhc2Ugc3BsaXQgdGhpcyBjb21taXQgdG8gYXQgbGVhc3QgdHdvOiBvbmUgZm9yIGxpYnJh
cnksIG9uZSBmb3IgVVQuDQoNClN1cmUsIEkgd2lsbCBzcGxpdCBpdCBpbiB2Mi4NCg0KPiANCj4g
VGhhbmtzDQoNClRoYW5rcywNClBhdmFuLg0K
