Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F95CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F5F2402B1;
	Tue,  4 Nov 2025 05:02:22 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD9C40299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:02:20 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3H2Can205402; Mon, 3 Nov 2025 20:02:19 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022072.outbound.protection.outlook.com [52.101.48.72])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a70ek1x3j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 20:02:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXScEBXnYLTUI6Rhri1GWWdlOvHhpMHXVTksmRtDlRkeenb7lpcbLOj43MoUWDbEWniaqgFvHVQLP99gs+2toqUmbQ9AjepzcIqOBfPY/sWry3SawxG5gLmHjyI5+/Uufl+/Ci+922UOjiQtFrYFnT6TQpFABPOG8sXy7r5pEtqDh8ZFWi6hqrBapSIS+lDZvA3gE8jDagHDwPUIeemMVrGYdaDM+L9emRY+rpNBJHLxd4+XP53UQ5EmaoDO2npqkvmSjImKT6H7PAtDYXnIvtUfReRtN6aDV5K8/z6fNLZUCy3YhNDGuGxJS5mmi3vDW9PCNdQ2AGsCxWvPlGTpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdek8duSCUgQgcDc6F54nH8QypTFX+aNSeMkwAy5uD8=;
 b=TAFV3VE183qHnw36GOAaUD+wjfEevaA4BzpqKKQvgYADQQkVrmJWToxsKNaGtmEdkXN35bdLI+to1Qt/JcgYFv27gkEArwkZSarreP6UWbuPmRw1GYYK1yEPyiXUDg1CSP9cZLJ/4XSjCdI+qfCRJeqBGf5ePfBM8Eve/ifPozvftT5w6PAZFg6ISsn7O/wA38AxcRahHG8UfdJHvsPWMeLsPcdFJFD4O3+p95DqrF3KElGnsT2aC+FjMygMy3dmobpsC/9+J5TUSujnpJhbTMdjmUxtUyQrmsNGaKMrijSipcV+qEYeihmhLXd4x9sIQzoPG6QgtbmCsssoFIoJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdek8duSCUgQgcDc6F54nH8QypTFX+aNSeMkwAy5uD8=;
 b=QFRojIBZ1MOUo6jVWSyYWJJHaSe6p5yQgCNJ+VZyhPS6JhoFHSN8E71CKzF+kIQX11Ds4VHu7GtUMhnVbFUPct5He1m6MPX2Ojgn80BQwVjUW6rq7R4DBSRgxjydWqseGqSMZXr5eQHm5is6lqdg1H6NbN/AFbZUNl8Bh0DpjPk=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SA1PR18MB5843.namprd18.prod.outlook.com
 (2603:10b6:806:3dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 4 Nov
 2025 04:02:16 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:02:15 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [EXTERNAL] Re: [PATCH v0 1/1] dmadev: add domain_id field to
 access group join API
Thread-Topic: [EXTERNAL] Re: [PATCH v0 1/1] dmadev: add domain_id field to
 access group join API
Thread-Index: AQHcTKzMZEgiSFfr8kqo/PXwSqiH0bThr0aAgAA2cVA=
Date: Tue, 4 Nov 2025 04:02:15 +0000
Message-ID: <SJ4PPFEA6F74CA2F6F2A54AB50CF7C80DCBA6C4A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
 <90a817be-147c-47e1-a570-194c8c96fc53@huawei.com>
In-Reply-To: <90a817be-147c-47e1-a570-194c8c96fc53@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SA1PR18MB5843:EE_
x-ms-office365-filtering-correlation-id: 41f35ce1-bac9-40f7-240f-08de1b56f0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TWlsbk52TVlXd0xqMGdodldMeDZFLzhzcW5FTHczdFJTdzBwbVIxWEhHSHBi?=
 =?utf-8?B?dFNVcVEyZFNxVGVrbHZqZEo4V1A2R2tHUWRzTkgzSStLWjhPMXo1Q21TRWpF?=
 =?utf-8?B?V1ZrTTdoTnNvVDRPVVlCRzdvelNtcWZKUWxBOFU4dnhUOXBacURzeFJNWGtK?=
 =?utf-8?B?Z2Q0a3lWaitEWDNrSnlqWHJhUlpDdFlCVUxuTTM3NjE2NGZPMFR5dUFEMEpr?=
 =?utf-8?B?V2R2MFpNSXlaZUtKekxSV01ZNmpzd0pSMUZvVy9YUGc1SVVkK0JZYU9ZbHVs?=
 =?utf-8?B?TlhOcHdUaDExcnJLNnY3bXBweUw1ek5tVko0enVEUTR1R1BzaDhyQ0pEMHg1?=
 =?utf-8?B?SUhmYWZFSEdwS1pJQmxNTnArd1JVQ29kcXNOR2dFNnNsZDFkZlZNY1puamw3?=
 =?utf-8?B?UnY3Y1c3TG1UVHB5M3FWRkp2NVN6aHljeEF0ZFNKMzVWbmVsWnV0WGxiZTk4?=
 =?utf-8?B?enErcVo5RkZzYlZtcFdBRWQ5M0lqR2NVZUw2Ty9iNmh1S09remxEQkJUMkxx?=
 =?utf-8?B?UERtY251dzg4SUMzNEw3dThwcFRtbDUwcE14bURvMkt6dCtEZ0xwUDBhVFJT?=
 =?utf-8?B?Qmp6SExiL2o1eHlGZlVsM3JucEcra3R3K2VLVjRBWWx1bGluTk1ueGljTnpZ?=
 =?utf-8?B?YzNMN3JPamZON0ZUOHoxeUEzdk91dUJTQXJuS1g1UGorL3F2eVloSlBYYTh6?=
 =?utf-8?B?QmhxRkRnOXJxOHhyYiszQVJGdy83TFZZSkh2bDdWSHFEamRTWEVaYi84UEZQ?=
 =?utf-8?B?QTUrUHE5c1JlQjNqa21DQnJ5WFVBUW5hcTgyMU9WQWZ3YzFXOHhzNjFBRGN1?=
 =?utf-8?B?Mmw0SzlwOUk4ZVhKaVhZMkVpejA4M3JyT05rSDlQc3RMRTZNU1NIMEJGdDhp?=
 =?utf-8?B?ZjhPREhXTERvRzk3aWdaOGl5cG44UGltb2NXeUE3ZHEzU1pjSThvQWh2U3Jp?=
 =?utf-8?B?QXl1aTRWZzd6aUo1dDdEdVRmYSs4cXYwWi9mSmlzdFZnSnRTMkM0QVMvQS9Y?=
 =?utf-8?B?TFNMd0V5OXhIaVR6MVlSazBmc3MrR1JzZzR2bHlLM0QrMC9WM0NXVjJGTFVw?=
 =?utf-8?B?UmIwZCtOUnRRVXZ0ZnBwMS9zYUlqTjdsck9vdm9QRHpwTzR0dERVZ08vQ20w?=
 =?utf-8?B?dmtKQlArRjEweUJEK1h1Q05iRm9YV3A5MXZVMWkzbG1rM3FaNnhHMmhqU0M1?=
 =?utf-8?B?bGxTdXVGSjg0QzNka3R0dVQzdWxnbmQ2YURmNitJZ29qNU1aaU9WNkkrNzVu?=
 =?utf-8?B?cTBTNit0MmdOYVJuNFJ2WERCclVlK0o0SGMyc3JFangza2tHejQ1aWl0Ujdn?=
 =?utf-8?B?Vm14UE1WdkVQQ3MvRE5TSW1BMmZ5UXdQM1dBMWllcGJuY01WUkVLd0dVT21h?=
 =?utf-8?B?SkxrSmk2MDhvcUQvY1pwS3BCN1FhMkh0bWdnc0F5ditMVmNlWERGTit6UUg1?=
 =?utf-8?B?VEZCbmRqRDZkQjhKR2JsSXh5aHlSTlFaUHd4ZkM3QWFmcUF4bXgxbnBCZ2Nj?=
 =?utf-8?B?ZS9qZENDVVdVbjRaa2k0QTZkUFhXUldpWExWNEZRSTlURkhqU1QwK3pQKy9D?=
 =?utf-8?B?RnN1cXRNcllIQVJRMWxnWFRyRCs0UEZDalNZMG5zYVl5dXorNFJtT0ovekJW?=
 =?utf-8?B?U1VkZWMzUlMrUlU3RlRMeUVPdWNhTk1reW5KU0t6Z0lsdUd6VzZNcXNETFZS?=
 =?utf-8?B?SWZKNFF0YmwwRkp5bGUzV3VGMDNMYVNodU45clkweWJ5ZVVBY0xoTU5Rd0Rz?=
 =?utf-8?B?VG9zbWhtMVYwRDRDcGlPcC9hY25VR1hMNHQwYlFhNVQzT1hQY3kvcjlVRHV5?=
 =?utf-8?B?ZWtvRFdWcEpVOFVGYWJEQlFmcTUvQWlDTGdENUtnRkc4TnlqYThzY3hMUWJw?=
 =?utf-8?B?Yk1mOEJ4QnM4U0xMTTlnMmVLZmxlK1hHWGF5K0lNcS9TSmZ5Y3BKZElNQ1dv?=
 =?utf-8?B?UzdoT3NzSDJxaHVhOHFiS2tndDVDdDM3aXVHcGNzR0QwdXpXempDeFI2enky?=
 =?utf-8?B?RTR3eHF2UndLZXFwNGZ1MjZCM0dQNENwK05laHJsNWdmZ3l3cUZWcWx1Y3lz?=
 =?utf-8?Q?cHYhKZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xBanlsZ21yck11SnJ4Sy9UVHJKL3Z0VE1QU1ZydGF3b3pianpXQk51Rm1i?=
 =?utf-8?B?dmV6TDB2eTZqczdURDBtTWZwaVh2YktCV3ZiQ3Uxbk9uUHNRcjFqTGkzdkVT?=
 =?utf-8?B?ckJuTzNzL1pVSkQ5QU55Qm1XWDd3akdSK3FWNG9BOExCbW91M1N4cGlXZkcv?=
 =?utf-8?B?cWV4bDQwWWZQZlBOTithR1ZqWFQ0cU1xTklMekk4elBodUhWeUdHcTE3cGg3?=
 =?utf-8?B?WEQvS1FWNDhubFhtSzJGbGorT1hNV1JTaklNQ2ppdGpCY2tmNFhScE1MWjJK?=
 =?utf-8?B?SE1wZlRLRU1DRXFTTXlCMVZuN3Izb1NTaHJsMjlWdlV6a0N4TzJ1WjB0STdO?=
 =?utf-8?B?aHMyUmxBK09kejV6cFlXeHhJZk9ROVh5V1JiZGxXWkR1OGRwVys2a3M1dkFF?=
 =?utf-8?B?RVF6TnRxekE3djBnRU9Sa0oyMHBSUmZrWFFNZWprRDdWYnFDbVhvRWRVTXFy?=
 =?utf-8?B?aGIyWlBSZ1ZibVZqc001dDFDN0tIbEZFTXA1bjlJLzBkU2o4d1VVbUxSWEFF?=
 =?utf-8?B?bjRrRytBdTNzTUFaR1RiT3ZsV3NQUEZsaGVlSDJzaC9lSnBsNmVIS2xPbnlW?=
 =?utf-8?B?VEQvSmw0bEtxa1JPdVpmaVdQaEJiU2JPZHRFN1NjYytVOXZxZ3gyek93dGxp?=
 =?utf-8?B?Y2l5cjhRK0I3ZXVxUlV5WEtKRkRwSGlhQXN0bXlMOFRHVG1nSEtDcllZMnc2?=
 =?utf-8?B?ellSYkd6YzBGTWJLeXIvSUlLTHVZTVA1UVBWVzlJZm1kVDUrUHJKSVM0cEJ1?=
 =?utf-8?B?Q2N1Ni9Jb1hwQS9tRkY3NFduem1kSlhwS2FJS1Q1ZUMxcnhJOTlLZVI5YkJk?=
 =?utf-8?B?YTFjcU9SWE85WmxpMnFQZm9GaFFpVTJSRGZ0RXAwbndsaU5qVHp5QlVhRmFi?=
 =?utf-8?B?L2FDT0RuUlRaalkxVlVwWHRDd2diZlUxWGlSTVVRclpOczc5NDdjY3BNZWNp?=
 =?utf-8?B?N3RlK0FBV1JmaFZ2RFhyNnc0cGs2YkJ5ZjVJUDJLZ2EyNExtWlRoV0JUaWxG?=
 =?utf-8?B?MGg4akVaK3VXRi9yUGhudWNueVB5NGhYMUwwT3lSb1FBODdzNE42WVBOMyth?=
 =?utf-8?B?eWcvR1k2cVJWNjBxR2JHdjJHcy9xNzdjSi8vNmxaYWt2U3B4bWpDMnBDRnNM?=
 =?utf-8?B?TCs4L1ZHWGwzeWpNdEEvekJiWTNmeDJEZXUwelM2TCtldllneVZ4UStUbDBT?=
 =?utf-8?B?THRsNVBndmh6WkxnbGxUanJNMUNzUURNOERqcVJRVzM0L0gyQXNpNUYzSEtN?=
 =?utf-8?B?U2F4ajhxTzFOenFxSVdwcHEyMm50ak5hWEJURm8vR1FjTEVCN2VDNnFnNnVl?=
 =?utf-8?B?MVpaMnoyYjA1WHNKSHdDQ25MR2dIaVlXdG1aazhHSktEckZMZEpxS0ZKYlNS?=
 =?utf-8?B?c0ovdEE1cllJWFdvRE5GV2FjYTM0NStvN05uRUczWFY2bnljOGFlSU5QczJY?=
 =?utf-8?B?YjJyTE54eXNUWnU2VGYybjMrOHRRZDNxRmg1ZEZFUk0reGxxSlhpZFFLc0x0?=
 =?utf-8?B?WWtnY1lycW90cEJoQkxjUHFKUWlOZVpoa3ZCSHBHM2Q0UFVVdHh0UStxeUhW?=
 =?utf-8?B?c3ZGaGlPdUl5ek1LQjhoSUtia3R5K1NRYzdxTS9rNGRmM3VPU1RYODlJYXdm?=
 =?utf-8?B?czZZTnh5RlJkZ1ZQNXF0WEZ5NzduVkt5Z2YrL2F2VGtLN2lVRTZSaUVKVEFL?=
 =?utf-8?B?RjlXS2djTGwvVmsrK0lORWRSWEpOa0d1dmxHMUt4cW1oc2pJRWJxbGg1TFRU?=
 =?utf-8?B?aDRxWlJyMDZ3eXJVaml1VWpKR1UyRGZSNFFXYzVKOVBIeDFiR0thZ1h0azFo?=
 =?utf-8?B?TXNDTjJ3MldNdllRckh5SVZyWktHR3NzV1ZpYXhRdzYrTHVnN1h3ZDU4cFRK?=
 =?utf-8?B?SHNGbjNlR2lxS2Eyd1BjbVlhbDBiVUNzbTNzYWw1Q2MvZFJpbnZUdDUxN1lJ?=
 =?utf-8?B?U3Jkam5QbVpUN2tiNi9IRnp0UmdsOEs5akVLcUFJTGdZVCsza0NZM0VUYzV3?=
 =?utf-8?B?RmFQdkFZZ3EwWWloYkhTZGpvK1hwU2cyZEpxVmpxaHZUdG92aFRnQW9XOUUz?=
 =?utf-8?B?L1pBVWM4V3FRMmYrQ01wYkhkUTl5UDFYSW54SXgrb3NzTnNjSWhYN1J3WERG?=
 =?utf-8?Q?VEqvtQPLnvfR3tu+RqrAI4juF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f35ce1-bac9-40f7-240f-08de1b56f0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:02:15.3681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmkS4Ii6n1QHTx5opkyf+coIZML2u/QHpxmD+imEh3jOQ3w5Ha6zYebN8O1oED6yDbfh3VWGMZOjsMBO/8rVRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5843
X-Proofpoint-ORIG-GUID: m4kxitmuVmGfKeA7pmQyqH48Qw6cYkMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAzMCBTYWx0ZWRfX+KxRVxPhp16U
 tYvEKmXpVs2CA9EZ5BvyOjyve4nRmbNIqKivtMT3McqaMz9E/+vzfF/uu9LmWFkIVpEG0g8xnFm
 b5EY96FwPUYzqkZmZymaum5xsHqVlhTEcZFKxucsJknwBj/NxS9xY9gUdx2Xt6Di+X+iVh6BT70
 P2Wt9odY9G8ead0hNwc9Lzs2EDNZmVxAlBphjgHObYNLwn8NDRhLjNaScw43Dp1Uo8khImru61l
 aJu8MjuBZF5/BTHoG8hJg0fOZfJBSskiCOi95p/OtFBzD5xvD7OxAbH3hW3eQ++vzWbNLfxNmKP
 i4PtqJlVA/IppssuFYfRqnUtv+Pqi+P85DeNaEM0n7G2ewdbhjHCAWyRoT/jhBisAt0IRJ/7D1Y
 3i7JqvLcZDok6IXy/iNgXiASszYRXQ==
X-Proofpoint-GUID: m4kxitmuVmGfKeA7pmQyqH48Qw6cYkMj
X-Authority-Analysis: v=2.4 cv=N8Yk1m9B c=1 sm=1 tr=0 ts=69097acb cx=c_pps
 a=hro4gVXncoUBxB/Amc69HA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=srhC7En7algzaxq7j7sA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
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

DQoNCj5aalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+T24gMTEvMy8yMDI1IDY6MjkgUE0sIFZhbXNp
IEtyaXNobmEgd3JvdGU6DQo+PiBGcm9tOiBWYW1zaSBBdHR1bnVydSA8dmF0dHVudXJ1QG1hcnZl
bGwuY29tPg0KPj4NCj4+IEFkZCBkb21haW5faWQgZmllbGQgdG8gYWNjZXNzIGdyb3VwIGpvaW4g
QVBJLCB3aGljaCBpcyByZXF1aXJlZCB0bw0KPj4gcmV0cmlldmUgaGFuZGxlciBpbmZvcm1hdGlv
biBhc3NvY2lhdGVkIHdpdGggdGhlIHNwZWNpZmllZCBkb21haW4uDQo+PiBUaGlzIGVuaGFuY2Vt
ZW50IGVuc3VyZXMgdGhhdCBkb21haW4tc3BlY2lmaWMgY29udGV4dCBpcyBhdmFpbGFibGUNCj4+
IGR1cmluZyBncm91cCBqb2luIG9wZXJhdGlvbnMsIGltcHJvdmluZyBmbGV4aWJpbGl0eSBhbmQg
dHJhY2VhYmlsaXR5DQo+PiBpbiBtdWx0aS1kb21haW4gZW52aXJvbm1lbnRzLg0KPj4NCj4+IEl0
IGFsc28gYWxpZ25zIHRoZSBwYXJhbWV0ZXJzIG9mIGFjY2VzcyBncm91cCBjcmVhdGUgYW5kIGpv
aW4gQVBJcyBmb3INCj4+IGNvbnNpc3RlbmN5IGFuZCBjbGFyaXR5Lg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFZhbXNpIEF0dHVudXJ1IDx2YXR0dW51cnVAbWFydmVsbC5jb20+DQo+PiAtLS0NCj4+
ICBsaWIvZG1hZGV2L3J0ZV9kbWFkZXYuYyAgICAgICB8ICA2ICsrKy0tLQ0KPj4gIGxpYi9kbWFk
ZXYvcnRlX2RtYWRldi5oICAgICAgIHwgMTAgKysrKysrLS0tLQ0KPj4gIGxpYi9kbWFkZXYvcnRl
X2RtYWRldl9wbWQuaCAgIHwgIDQgKystLQ0KPj4gIGxpYi9kbWFkZXYvcnRlX2RtYWRldl90cmFj
ZS5oIHwgIDYgKysrKy0tDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbGliL2RtYWRldi9ydGVfZG1hZGV2
LmMgYi9saWIvZG1hZGV2L3J0ZV9kbWFkZXYuYyBpbmRleA0KPj4gYzAwOGU4MjlkYi4uYjc1YjRm
OWJkMSAxMDA2NDQNCj4+IC0tLSBhL2xpYi9kbWFkZXYvcnRlX2RtYWRldi5jDQo+PiArKysgYi9s
aWIvZG1hZGV2L3J0ZV9kbWFkZXYuYw0KPj4gQEAgLTg3NSw4ICs4NzUsOCBAQCBydGVfZG1hX2Fj
Y2Vzc19wYWlyX2dyb3VwX2Rlc3Ryb3koaW50MTZfdA0KPmRldl9pZCwNCj4+IGludDE2X3QgZ3Jv
dXBfaWQpDQo+Pg0KPj4gIFJURV9FWFBPUlRfRVhQRVJJTUVOVEFMX1NZTUJPTChydGVfZG1hX2Fj
Y2Vzc19wYWlyX2dyb3VwX2pvaW4sDQo+MjUuMTEpDQo+PiBpbnQgLXJ0ZV9kbWFfYWNjZXNzX3Bh
aXJfZ3JvdXBfam9pbihpbnQxNl90IGRldl9pZCwgaW50MTZfdCBncm91cF9pZCwNCj4+IHJ0ZV91
dWlkX3QgdG9rZW4sDQo+PiAtCQkJICAgICAgIHJ0ZV9kbWFfYWNjZXNzX3BhaXJfZ3JvdXBfZXZl
bnRfY2JfdCBjYikNCj4+ICtydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2pvaW4oaW50MTZfdCBk
ZXZfaWQsIHJ0ZV91dWlkX3QgZG9tYWluX2lkLA0KPnJ0ZV91dWlkX3QgdG9rZW4sDQo+PiArCQkJ
ICAgICAgIGludDE2X3QgZ3JvdXBfaWQsDQo+cnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9ldmVu
dF9jYl90IGNiKQ0KPj4gIHsNCj4+ICAJc3RydWN0IHJ0ZV9kbWFfaW5mbyBkZXZfaW5mbzsNCj4+
ICAJc3RydWN0IHJ0ZV9kbWFfZGV2ICpkZXY7DQo+PiBAQCAtODk5LDcgKzg5OSw3IEBAIHJ0ZV9k
bWFfYWNjZXNzX3BhaXJfZ3JvdXBfam9pbihpbnQxNl90IGRldl9pZCwNCj4+IGludDE2X3QgZ3Jv
dXBfaWQsIHJ0ZV91dWlkX3QgdG9rZQ0KPj4NCj4+ICAJaWYgKCpkZXYtPmRldl9vcHMtPmFjY2Vz
c19wYWlyX2dyb3VwX2pvaW4gPT0gTlVMTCkNCj4+ICAJCXJldHVybiAtRU5PVFNVUDsNCj4+IC0J
cmV0dXJuICgqZGV2LT5kZXZfb3BzLT5hY2Nlc3NfcGFpcl9ncm91cF9qb2luKShkZXYsIGdyb3Vw
X2lkLA0KPnRva2VuLCBjYik7DQo+PiArCXJldHVybiAoKmRldi0+ZGV2X29wcy0+YWNjZXNzX3Bh
aXJfZ3JvdXBfam9pbikoZGV2LCBkb21haW5faWQsDQo+PiArdG9rZW4sIGdyb3VwX2lkLCBjYik7
DQo+PiAgfQ0KPj4NCj4+DQo+UlRFX0VYUE9SVF9FWFBFUklNRU5UQUxfU1lNQk9MKHJ0ZV9kbWFf
YWNjZXNzX3BhaXJfZ3JvdXBfbGVhdmUsDQo+PiAyNS4xMSkgZGlmZiAtLWdpdCBhL2xpYi9kbWFk
ZXYvcnRlX2RtYWRldi5oIGIvbGliL2RtYWRldi9ydGVfZG1hZGV2LmgNCj4+IGluZGV4IDBmNGYx
MGVjMTIuLjUyODdiMGYzMmQgMTAwNjQ0DQo+PiAtLS0gYS9saWIvZG1hZGV2L3J0ZV9kbWFkZXYu
aA0KPj4gKysrIGIvbGliL2RtYWRldi9ydGVfZG1hZGV2LmgNCj4+IEBAIC05MTIsMTAgKzkxMiwx
MiBAQCBpbnQgcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9kZXN0cm95KGludDE2X3QNCj5kZXZf
aWQsIGludDE2X3QgZ3JvdXBfaWQpOw0KPj4gICAqDQo+PiAgICogQHBhcmFtIGRldl9pZA0KPj4g
ICAqICAgSWRlbnRpZmllciBvZiB0aGUgRE1BIGRldmljZSBhdHRlbXB0aW5nIHRvIGpvaW4gdGhl
IGdyb3VwLg0KPj4gLSAqIEBwYXJhbSBncm91cF9pZA0KPj4gLSAqICAgSUQgb2YgdGhlIGFjY2Vz
cyBncm91cCB0byBqb2luLg0KPj4gKyAqIEBwYXJhbSBkb21haW5faWQNCj4+ICsgKiAgIFVuaXF1
ZSBpZGVudGlmaWVyIHJlcHJlc2VudGluZyB0aGUgcHJvY2VzcyBvciBPUyBkb21haW4uDQo+DQo+
VGhpcyBkb21haW5faWQgc2hvdWxkIGJlIGxvY2FsIHByb2Nlc3Mgb3IgT1MgZG9tYWluLCBzbyBo
b3cgYm91dDogVW5pcXVlDQo+aWRlbnRpZmllciByZXByZXNlbnRpbmcgbXkgcHJvY2VzcyBvciBP
UyBkb21haW4uDQo+DQo+QW5kIHBsZWFzZSBjaGFuZ2UgdGhlIHJ0ZV9kbWFfYWNjZXNzX3BhaXJf
Z3JvdXBfY3JlYXRlICdzIGNvbW1lbnQNCj5hYm91dCB0aGUgZG9tYWluX2lkLg0KPg0KQWNrLCB3
aWxsIHVwZGF0ZSBib3RoIHRoZSBjb21tZW50cy4NCg0KPj4gICAqIEBwYXJhbSB0b2tlbg0KPj4g
ICAqICAgQXV0aGVudGljYXRpb24gdG9rZW4gdXNlZCB0byB2YWxpZGF0ZSBncm91cCBtZW1iZXJz
aGlwLg0KPj4gKyAqIEBwYXJhbSBncm91cF9pZA0KPj4gKyAqICAgSUQgb2YgdGhlIGFjY2VzcyBn
cm91cCB0byBqb2luLg0KPj4gICAqIEBwYXJhbSBjYg0KPj4gICAqICAgQ2FsbGJhY2sgZnVuY3Rp
b24gdG8gYmUgaW52b2tlZCB3aGVuIHRoZSBkZXZpY2UgbGVhdmVzIHRoZSBncm91cA0KPj4gICAq
ICAgb3Igd2hlbiB0aGUgZ3JvdXAgaXMgZGVzdHJveWVkIGR1ZSB0byBzb21lIGV4Y2VwdGlvbiBv
ciBmYWlsdXJlLg0KPj4gQEAgLTkyNSw4ICs5MjcsOCBAQCBpbnQgcnRlX2RtYV9hY2Nlc3NfcGFp
cl9ncm91cF9kZXN0cm95KGludDE2X3QNCj5kZXZfaWQsIGludDE2X3QgZ3JvdXBfaWQpOw0KPj4g
ICAqICAgbmVnYXRpdmUgdmFsdWUgb24gZmFpbHVyZSBpbmRpY2F0aW5nIHRoZSBlcnJvciBjb2Rl
Lg0KPj4gICAqLw0KPj4gIF9fcnRlX2V4cGVyaW1lbnRhbA0KPj4gLWludCBydGVfZG1hX2FjY2Vz
c19wYWlyX2dyb3VwX2pvaW4oaW50MTZfdCBkZXZfaWQsIGludDE2X3QgZ3JvdXBfaWQsDQo+cnRl
X3V1aWRfdCB0b2tlbiwNCj4+IC0JCQkJICAgcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9ldmVu
dF9jYl90DQo+Y2IpOw0KPj4gK2ludCBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2pvaW4oaW50
MTZfdCBkZXZfaWQsIHJ0ZV91dWlkX3QNCj5kb21haW5faWQsIHJ0ZV91dWlkX3QgdG9rZW4sDQo+
PiArCQkJCSAgIGludDE2X3QgZ3JvdXBfaWQsDQo+cnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9l
dmVudF9jYl90IGNiKTsNCj4+DQo+PiAgLyoqDQo+PiAgICogTGVhdmUgYW4gYWNjZXNzIGdyb3Vw
LCByZW1vdmluZyB0aGUgZGV2aWNlJ3MgZW50cnkgZnJvbSB0aGUgZ3JvdXANCj4+IHRhYmxlIGRp
ZmYgLS1naXQgYS9saWIvZG1hZGV2L3J0ZV9kbWFkZXZfcG1kLmgNCj4+IGIvbGliL2RtYWRldi9y
dGVfZG1hZGV2X3BtZC5oIGluZGV4IDE2ZmQ2MjVjMmQuLjhhNmIwYTljOTggMTAwNjQ0DQo+PiAt
LS0gYS9saWIvZG1hZGV2L3J0ZV9kbWFkZXZfcG1kLmgNCj4+ICsrKyBiL2xpYi9kbWFkZXYvcnRl
X2RtYWRldl9wbWQuaA0KPj4gQEAgLTc1LDggKzc1LDggQEAgdHlwZWRlZiBpbnQNCj4oKnJ0ZV9k
bWFfYWNjZXNzX3BhaXJfZ3JvdXBfZGVzdHJveV90KShjb25zdCBzdHJ1Y3QgcnRlX2RtYV9kZXYg
KmRldg0KPj4gIAkJCQkJCSAgIGludDE2X3QgZ3JvdXBfaWQpOw0KPj4NCj4+ICAvKiogQGludGVy
bmFsIFVzZWQgdG8gam9pbiBhbiBhY2Nlc3MgcGFpciBncm91cCBmb3IgaW50ZXItcHJvY2VzcyBv
cg0KPj4gaW50ZXItT1MgRE1BIHRyYW5zZmVycy4gKi8gLXR5cGVkZWYgaW50DQo+KCpydGVfZG1h
X2FjY2Vzc19wYWlyX2dyb3VwX2pvaW5fdCkoY29uc3Qgc3RydWN0IHJ0ZV9kbWFfZGV2ICpkZXYs
DQo+aW50MTZfdCBncm91cF9pZCwNCj4+IC0JCQkJCQlydGVfdXVpZF90IHRva2VuLA0KPj4gK3R5
cGVkZWYgaW50ICgqcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9qb2luX3QpKGNvbnN0IHN0cnVj
dA0KPnJ0ZV9kbWFfZGV2ICpkZXYsIHJ0ZV91dWlkX3QgZG9tYWluX2lkLA0KPj4gKwkJCQkJCXJ0
ZV91dWlkX3QgdG9rZW4sIGludDE2X3QNCj5ncm91cF9pZCwNCj4+DQo+CXJ0ZV9kbWFfYWNjZXNz
X3BhaXJfZ3JvdXBfZXZlbnRfY2JfdCBjYik7DQo+Pg0KPj4gIC8qKiBAaW50ZXJuYWwgVXNlZCB0
byBsZWF2ZSBhbiBhY2Nlc3MgcGFpciBncm91cCwgcmVtb3ZpbmcgdGhlIGRldmljZQ0KPj4gZnJv
bSB0aGUgZ3JvdXAuICovIGRpZmYgLS1naXQgYS9saWIvZG1hZGV2L3J0ZV9kbWFkZXZfdHJhY2Uu
aA0KPj4gYi9saWIvZG1hZGV2L3J0ZV9kbWFkZXZfdHJhY2UuaCBpbmRleCBkYTgwYThjYjUwLi43
YWQwMGI1YmZhIDEwMDY0NA0KPj4gLS0tIGEvbGliL2RtYWRldi9ydGVfZG1hZGV2X3RyYWNlLmgN
Cj4+ICsrKyBiL2xpYi9kbWFkZXYvcnRlX2RtYWRldl90cmFjZS5oDQo+PiBAQCAtMTIwLDEwICsx
MjAsMTIgQEAgUlRFX1RSQUNFX1BPSU5UKA0KPj4NCj4+ICBSVEVfVFJBQ0VfUE9JTlQoDQo+PiAg
CXJ0ZV9kbWFfdHJhY2VfYWNjZXNzX3BhaXJfZ3JvdXBfam9pbiwNCj4+IC0JUlRFX1RSQUNFX1BP
SU5UX0FSR1MoaW50MTZfdCBkZXZfaWQsIGludDE2X3QgZ3JvdXBfaWQsDQo+cnRlX3V1aWRfdCB0
b2tlbiksDQo+PiArCVJURV9UUkFDRV9QT0lOVF9BUkdTKGludDE2X3QgZGV2X2lkLCBydGVfdXVp
ZF90IGRvbWFpbl9pZCwNCj5ydGVfdXVpZF90IHRva2VuLA0KPj4gKwkJCSAgICAgaW50MTZfdCBn
cm91cF9pZCksDQo+PiAgCXJ0ZV90cmFjZV9wb2ludF9lbWl0X2kxNihkZXZfaWQpOw0KPj4gLQly
dGVfdHJhY2VfcG9pbnRfZW1pdF9pMTYoZ3JvdXBfaWQpOw0KPj4gKwlydGVfdHJhY2VfcG9pbnRf
ZW1pdF91OF9wdHIoJmRvbWFpbl9pZFswXSk7DQo+PiAgCXJ0ZV90cmFjZV9wb2ludF9lbWl0X3U4
X3B0cigmdG9rZW5bMF0pOw0KPj4gKwlydGVfdHJhY2VfcG9pbnRfZW1pdF9pMTYoZ3JvdXBfaWQp
Ow0KPj4gICkNCj4NCj5UaGVyZSBhcmUgb25lIGRldGFpbCBtaXNzaW5nOg0KPjEuIGV2ZXJ5IHBy
b2Nlc3MgY291bGQgZ2VuZXJhdGUgb25lIHVuaXF1ZSBkb21haW5faWQgMi4gcHJvY2VzcyBBIGNy
ZWF0ZQ0KPnRoZSBhY2Nlc3MgZ3JvdXAsIGFuZCBzaGFyZSBpdCdzIGRvbWFpbl9pZCwgdGhlIGFj
Y2VzcyBncm91cCB0b2tlbiwgZ3JvdXBfaWQNCj50byBwcm9jZXNzIEIgMy4gcHJvY2VzcyBCIGpv
aW4gdGhlIGFjY2VzcyBncm91cCwgd2hpY2ggdmVyaWZ5IGJ5IHRva2VuIGFuZA0KPmdyb3VwIGlk
IG9idGFpbmVkIGluIHN0ZXAgMiA0LiBib3RoIHByb2Nlc3MgdXNlDQo+cnRlX2RtYV9hY2Nlc3Nf
cGFpcl9ncm91cF9oYW5kbGVyX2dldCgpIEFQSSB0byBnZXQgZWFjaCBvdGhlcidzIGRvbWFpbi4N
Cj4gICBUaGlzIGlzIHRoZSBkZXRhaWwgbWlzc2luZzogaG93IHByb2Nlc3MgQSBrbm93IHRoZSBw
cm9jZXNzIEIncyBkb21haW5faWQ/Pz8NCj4tLS1ieSBleHRyYSBjb21tdW5pY2F0aW9uIGNoYW5u
ZWw/Pz8NCj4NCj5QbGVhc2UgYWRkIHN1Y2ggZGV0YWlsIG9uIGRtYWRldi5yc3QNCg0KYWNrLCB3
aWxsIGFkZCBtb3JlIGRldGFpbHMgaW4gdjIuDQo+DQo+VGhhbmtzDQo+Pg0KPj4gIFJURV9UUkFD
RV9QT0lOVCgNCg0K
