Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 160BD402C8;
	Tue,  3 Jun 2025 16:38:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 84BEB4028E;
 Tue,  3 Jun 2025 16:38:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKnuZ010622;
 Tue, 3 Jun 2025 07:38:39 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2126.outbound.protection.outlook.com [40.107.96.126])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98j85t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 07:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dp+ocV3a9o5JGI0p3fxCOagdpBGr9+nGSKjDf6xA/76+HikGqa7ahYFCDtNWJkVCEq0n0mnuu9eQZ2ROZTiWFJZHOX782l375XNo6PgWQFlySbNDiXhjbW/lu3/FAQjOeAgMzGx1AmYgzACHJg6BsoNnm5ogKU/PYONvQmy4HTk4L+Lqk5P7EiLDV1hopIUzRglEyhSLM6qAXa73MIEj45luQpiHSPSjEQbsnVq4a3avjbp10pB+BCit8RD6zfuXQe206cFa+qyG4ckSfCcfalDQZK4nHBNQMgMBWav0HzWuMjbtb4y38w9EJi6ou340Z7AE51ggiFHts5ve/nev3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4+CBQaSWmdHaryvmrom/G1gfLZStyZQdcaGoRm67OU=;
 b=DKKC603n2+gua4rwJc19yIEdvYTsZ4VSBsLQDCJko8SzECyrsRamVkuje/IVTP/gGqkP8MU81yu5ITMYrQkxryKgRPSZkpkUyDUEBkhmZv+D253Va6wUUOOsB2L2FxWBWepXAW0Y/aXvdbQKZWOoVYCX4QJvwfQXKD/DFZeZlZAZAPd0B5LvRj7744XeEBD9lBj1lR71iXwIT2e3Ch1UA16TLrrgPMJdMPaRzjaePccfE64U71l2YkEODLQ8xBDgoNP4jL97lgL9htYMwIDx9JSZlrrYucZGrFqjHC7tIJMXMAhyC2E37ZR5l80uccYn/WLB6qF7UeogVKYjh0rmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4+CBQaSWmdHaryvmrom/G1gfLZStyZQdcaGoRm67OU=;
 b=rrUgbdXPW194lG/ZUHTW2T+jikY8JcbYeICAzgaAHccno0RjqXqFunF8CFcckcfrwgRPavw1WgPhjpSAJHSM0lhrc9pOlZ40/ZXCLKA+0XTFuxbkLa1ls8YDnuWKnz6QzIcgZSlcNmKDP4t+cE2YyzegzGryof5hcD4GiZ7J0Zc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6077.namprd18.prod.outlook.com (2603:10b6:408:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 3 Jun
 2025 14:38:37 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:38:36 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Jay Zhou <jianjay.zhou@huawei.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] crypto/virtio: fix PMD cleanup
Thread-Topic: [EXTERNAL] [PATCH] crypto/virtio: fix PMD cleanup
Thread-Index: AQHb0I9Nb429gBGsbkOOSYboChEZJLPxiSFg
Date: Tue, 3 Jun 2025 14:38:36 +0000
Message-ID: <CO6PR18MB4484CB2AF36881731AA6037DD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250529114554.35750-1-radu.nicolau@intel.com>
In-Reply-To: <20250529114554.35750-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6077:EE_
x-ms-office365-filtering-correlation-id: a6b2a3e4-0154-46ed-9a37-08dda2ac5323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N01ZcitScWo1ckVWNzRaYitCOTJPRHJGYTYrMHk4WVd0djBPUWhuRjFsZ2d6?=
 =?utf-8?B?WExVZ0ZxMWdqZWZHdXZQZUplUEhienZwR1BqMU14S3Q3dlo0dENQLzhEbnN4?=
 =?utf-8?B?eEtBc1pxOFhiRlRQblRWNUlQTXYzRUxNL1NmWTB4QUJWOWtvSUxtMVBEWi8v?=
 =?utf-8?B?UkoyZWl5czQyMVpTazVpaGM3L2NlWUQ1ZzJYZGk1Y1hjTWN5bmpyVmpNTEs3?=
 =?utf-8?B?Y0QwQmIrSDlJYy94Q0swc1A4TVJCSGtlOUJBdHpGYUx6WE56SXArTTlFenJa?=
 =?utf-8?B?ZkxreWNZZVYvYWp1ZE9PM2M4TEp0WFppWWt6L1JnZXdoL1BFMTd0QVVUaWtR?=
 =?utf-8?B?VGJMclZlSnJtWnpxU2JhbUhpYVFMZTQxeUwrMW53S1F1SVpuWklwQkxXeXpi?=
 =?utf-8?B?ei82VmYyU0lJSnVHaDNGV1BYdU1LZ2l1U3BSTFE2UVNyRlZzd0p6UmRoR0x4?=
 =?utf-8?B?clg2d2x2NFZiOWxTWDA1NWJNb3FkcGF0enVGUitiQXdvekViTFRWczhuOFBH?=
 =?utf-8?B?NjNsQU1ZbFZ6QzkyMDJTcGhweVQ2MlBQWmx3WmpYNjVvK3l1MjRnQmg5TjQ5?=
 =?utf-8?B?cWxybjRMSGNnUCtremkzV0Jtd284UGRvMHd5M0tNcnJHY0MzaWFXR1F3aGNV?=
 =?utf-8?B?eFV4VE1qZDdJcmxodU54dGFoVWYyKzBodGFuMUVBZG51NDNFOFdNVWh4WFZP?=
 =?utf-8?B?TjZjRnFiSzE3L0h2dW1HWHBBMytuaEdmRDN5OVpYa0xBMjdNemdjOGlybURa?=
 =?utf-8?B?R09VWEpncDMyYnVGNnhpelRhTThlSUJGUWlmZHIzU2FCdlNpQVE4cytubGVv?=
 =?utf-8?B?VVRnQmN1N0hUekw4RXpFa2dSbDdKbGZBeFZTcjhLTVFGREdaZXF4dW0vSi9Y?=
 =?utf-8?B?aDZBejJRNy9mM0daWHdzS3p6QmdkQ3RUWG1NNnQ1TC9KdENRMFlha0ozZkJi?=
 =?utf-8?B?dFJQUU1DTGkvK2QyNFNEbHVTOU80aVRsNnF0c0k5WlI4WG5UaFpvQkdsMlI4?=
 =?utf-8?B?SUJScWhLaEFvWFNyNHAvTDBGVjBOVTFKU0JZYXI1WkVwZGVRWXFYZjQxRWJP?=
 =?utf-8?B?Z3dobUN1anJOalp2ajl1WUFvTldRMjdCajJkYTNyWmZiWmx2MktYb05lc1Rk?=
 =?utf-8?B?VEd0cjhpOVNydnhGNjFSdEtmOWV5T254d1pycUxIdkp0R0NCNjcyR1VWZDd5?=
 =?utf-8?B?WWZ3L0ROSGIwVkhJZDJGcU51TjMwNGhGckRaM2ZxSkZLTGtnOXJrOVprSFlr?=
 =?utf-8?B?OFFMeGhkSUZzdURjOEZtVVNnUXdiU3orUm9wWFc4L0JQVzE5ZVNQOVpUT2pJ?=
 =?utf-8?B?VGs0YmswQTA1N2haRkdZKzU0Y2tYUUxNdythN0VyYzhmQy9OZDUvTVVhOGNC?=
 =?utf-8?B?MXR0UmJ2Zmxjdkp6UkxENXo3dVJOSVBFZ0xnMXBLRlNWY3JDRmZsdG1LVExq?=
 =?utf-8?B?UGRkOFFnVHQ4NWZYWHk0MTE1YmZoYUZ3M3BYYUYzbXpvR2EzMUdTODNWN050?=
 =?utf-8?B?RWRuYS83WE9sUXplV2JuUlVVbkw3SkdPN1hoY3pSLzk4MnhzTldnSDcyVFg2?=
 =?utf-8?B?T08zMHlKMGlkeXNrT0NELzFRVWxUeDdHcmx1WjJ2b1FZMmdjNTM5Ujl0Z2l4?=
 =?utf-8?B?VlgxVnM0Q3d2RVhDUmVlbTBMcGxaM3pHZCt6REJDSmhuK21NN0RDcW5JWjh5?=
 =?utf-8?B?Vmd2bzlWSFpnSHVSQm1ncCsxRjA4YVhZSEdLRWZ2cmV4S1YyNXpGNjF1WllI?=
 =?utf-8?B?anNiSzRwOVBmUnJNd0dHUEEveFpyWTc1L2tIbW5SRWdvQ3pIRnRSM0lEeElt?=
 =?utf-8?B?TjNQMUV3b1JIcG82ZHAyVlFtMGlFQmF2UEl3TENjVGticHc3RnFKNFZnWnZ6?=
 =?utf-8?B?cU0weE0xTi9VZGU4M3VyZFE0cGtMMDRONktUb1hOUWxQY0FIM1IxNlhnT0JV?=
 =?utf-8?B?OTBxbFdSMVk3L1l2ajcwblp6bFpCeVlES0p1YnhTdlJKanNTSnI5Nk5rVFdU?=
 =?utf-8?Q?tquEqDVAOpazw41Tfgng2/eXyCw1XU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm4yZCtnYmluOC9uKy9qNlJCRm5qR1Q5TDFZZGwzd1lPa1F0Qkd6VTRIOWRp?=
 =?utf-8?B?eldORGJidktQUVNPdWl1U0NDR1A2RXNCUUpUdGRWdnVCU2ZtZEZTTGFTQ1BQ?=
 =?utf-8?B?UDhPdVlZL0RJV1lWa1lQZGFSOFNSWjVub0FkVkdQeDRzckRDV2JXZWJHcTR0?=
 =?utf-8?B?MXdqVVluR2EzUUdnaG1wWmUzU2xwNVlERWZRcTdSYng2UHZVZzEvT2dxZ2M2?=
 =?utf-8?B?T1RFN3prOVA3TnBmWWErd21wTHpuQmFldTYwRHNZQWQ3cHVZV2U2UTUvb1NF?=
 =?utf-8?B?Rks1YTJJa0tBSkdSWXpLdlV4NzRyMThCNDhFWmpud1RSSGxWdDdwNE9tUFBp?=
 =?utf-8?B?VWZndi9MRSswaXVYRTQ4eWtFRzVIYzF4V1R3Um82cW5Ed1htcUhJR0lEUDNr?=
 =?utf-8?B?VVI0RGdZbTVVY05VS1lnSXlZUTBpQUlNK1dzaWV1SWxJd2txSmNSZGVucGJY?=
 =?utf-8?B?TW1xUGp3VEdYY2NGcEgvcEdwMGhTa3d6RVAydlo0WFMwN1NJRjRqNFlncm8z?=
 =?utf-8?B?REdUdjliQVcwdUU5NVVLRzZwZkQxbHJMQktoNTJyQUt5amRCck1qUHBTMHhh?=
 =?utf-8?B?Z3JLaUp0cDJJYytIZVRDaFZvN0JrYzA3S294THpUbzlCMTJxOUdXSkpnQmVH?=
 =?utf-8?B?K0ZIc3J3enl5REVWdll5RitkQUtvZ2lMN3NNVmdqVW9JaktsWi94TmRTenpl?=
 =?utf-8?B?S2c4U1FsbVpSNDRkT0x2WnF3anVJUDVlZGdZQnE4bUMrRmJjR3l2WGpNZ0l5?=
 =?utf-8?B?K3FQSHE3RW43Y242VFE3SGRSSXB3THY5Nnc0TXNRTzJORERaMEtsbHBhMXZE?=
 =?utf-8?B?WFBaVHA0NzVuekRPWEVLODlvTVJkZzBrSnRjQWpQY1JEWkNYMndsd3JOZXBP?=
 =?utf-8?B?Z1BaSXFyVFhhUFpNRVRoMzNrallRTmlBWGRqYkV5MFJINmlxZUNPODYvNHhX?=
 =?utf-8?B?dXFob0l5ZkQ0V29RSFFmcEhqQkFYNmhmd2paMjRaYUswNE5pUkk4ZnFPTnk3?=
 =?utf-8?B?QUt1VHowMDRHeTN3NzJMcjRVUTFTZ1QycHdPNkRvWDByTGowRitWTWpyelZU?=
 =?utf-8?B?dWQ1MWtvcFN2TnZpMUZib0FOaEpKNjhQYUszNFBLZGk4OG9EVGNtZkN3UWtG?=
 =?utf-8?B?NmlDaHhiSGQ5SVEzQTBuNWpWWURQVlZEcTVUSlVpUHc5VkwwN3ZKSkRqb0xY?=
 =?utf-8?B?QzFSOFh3NnRSdzlJWlpUNVJWYTluZXZDOWoxbjR3akdDYTJuM2N5KzBDbmJj?=
 =?utf-8?B?REZmMld3WXNkZHYyVEdyak5VRXRrNVNma2YrV1pmcDYyZGJ6SW8zZVphK2Ix?=
 =?utf-8?B?b3hjL21TV0N5M1YrLzgvQVVTTVV3RktXWHJEcFc3NExKVjhMdUJlL2Vxbnlm?=
 =?utf-8?B?N2xiSW1kM2JlamllcjhjaGd5U0hqTExNM2Zlc2hxTDYySUFTaTh5MW5BUHdX?=
 =?utf-8?B?bTF0cGVkQ0FpRTgxb1hOM2IvT2VmWFFRYnczN3pwUER6RzA1WlVYM1praUdu?=
 =?utf-8?B?RmtFekhlMFZoc1FVMFd3UnZ6emNjVXJ4bUpGMW1adWVGTlVSN1dMdzBockx1?=
 =?utf-8?B?YWJSUDRUMVVsRE1VVFFpUy95cUdDODZxSnpXb0NNQW45WW1GUnpEZDc1TkJE?=
 =?utf-8?B?V0RBWjF0MURFRXZjMDlpK2ZKbStwdHNGeDQxUnRCLzFPV0dQb05mZFVHcTJH?=
 =?utf-8?B?dTEvdHFKOURDdVBxbDIwdEpMRE9qQUI4T3pjSWROQXMxVFkxc0ZyZ3AwUDNx?=
 =?utf-8?B?RjVNb1l1MzFFQTVrRW9RR0tJb1pmUjE2b0hmQU45c1hidGVGOEFUSHB5Ukxq?=
 =?utf-8?B?NUdYSlB4NHJ0Ry8wcEIwU2lOM0lkdXBBcDJWRUVXMHRuVVRqM0kxS3Z5NDg5?=
 =?utf-8?B?RVdBRzM4bDJGaFdDTFJSZHdsZExnSUwrMTFEQ20rMDE5WVFyWmRpcTJsRVd6?=
 =?utf-8?B?ckVhZFluZ0tKUUhMd3VyYXRFd3QvREhjVDYybjQraDVLTEEwN0ZLNXN3eDVp?=
 =?utf-8?B?bzJVZENlTWlJdXZteXFOSDVKOElwYUlLZTRhR1IxV3A4bU1MMm00RGdmZkZh?=
 =?utf-8?B?VnV0M3AvT2ZBQW1mUXBMUWVkN1pkbW5kLzJ1Q0c5clRkdXppZlhMUVRpcUdE?=
 =?utf-8?Q?tyIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b2a3e4-0154-46ed-9a37-08dda2ac5323
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 14:38:36.9101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7K+rHgjrdjMRysmi1vl3NkRjGY0a4qT0uV4dmlBHQMfCyM6An7jblw2FWmyLD+IcgPftgXDENX6q61dau9rpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEyNyBTYWx0ZWRfX8bPY/Wfe7gkS
 Z1FXO/OKn47iZksW/b7iGyuuhNbtuVCpnS/fa9CCkxVha6O1f2fvr6DhgTtGnGaDVOFj0XJtD3G
 wDwC5AEzo8QtfyQjBOIf9OtgrYuYcVWJCTmZj+nT7g4FmlBLQNsoafhHUbs1/X0fsYno8uOl84n
 2Qumrijm1oE/CDK3uGtwKavbK7YjN/fPCGeAkRIapH8LiLRwrGYI94ohHcICfp83oBSMe1EK16B
 ZWbpZmEznc/d5rFKdiyDlPrNaHRgWdJP+95wwpG1Mu2DDpQ4tWER6EuFQEnXyUz7VBOZb/Z0BCQ
 yd18yj6sjb64k+SJ5VYWruE04FWI90pd+iAVJhHxvvqyomv9NP0tQQPJ8YP5/RE4nVj7UvPXPjV
 tpydH/mZfeVblxYELhDIpmRaFEvi1sfBdL3+zG9hbtL2wUowEqtdnG5qvaLLylfCxlwlmOfT
X-Proofpoint-ORIG-GUID: Vy4b75WD1IvN_lu5q-OkLWr0uR66sLSO
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683f08ef cx=c_pps
 a=9jVNGVDmQ9PPsbrCN3PTDw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=MXWY8X1HRndmJHXb2voA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Vy4b75WD1IvN_lu5q-OkLWr0uR66sLSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

PiBJbXByb3BlciBjbGVhbnVwIHJlc3VsdGVkIGluIGEgc2VnZmF1bHQgd2hlbiBtb3JlDQo+IHRo
YW4gMSBkZXZpY2Ugd2FzIHVzZWQNCj4gDQo+IEZpeGVzOiA2ZjAxNzVmZjUzZTAgKCJjcnlwdG8v
dmlydGlvOiBzdXBwb3J0IGJhc2ljIFBNRCBvcHMiKQ0KPiBDYzogamlhbmpheS56aG91QGh1YXdl
aS5jb20NCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBO
aWNvbGF1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KQWNrZWQtYnk6IEFraGlsIEdveWFsIDxn
YWtoaWxAbWFydmVsbC5jb20+DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4N
Cg==
