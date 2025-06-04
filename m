Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B476FC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 06:54:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE79E4065A;
	Wed,  4 Jun 2025 08:54:10 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by mails.dpdk.org (Postfix) with ESMTP id 9FDD9402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 08:54:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epV2lb0gNZnqKrbDTsZjyMX0hALqejS6d6E5YcqPcjTyz+jWGMU8MmKptFxzAJq2BV3Rx3G0uxBjkX/XarN09VDNZ3MZlHdv+eG2nwRP9s9etUzyxeP2ctvFQyLzQtVKjg1dqM8Ev0p0jbJ2XKV2SYhIPfVbWho6B2WdYbXPiB0PW654K1aadhPMThtByzcRVhlrQDlxZ20QOnBgu5FViOct7yBNAtnqGv8CslgbX2wK4jStdNKEtFABJh/Xgo0LaQ6alY3YlDxumWOt6Gw/XoKIQ564Nufo0Ko+rvwIJIRRKnjc9Nz2pmi9znSHA0/8VdPTP5YhEp9Z8z7mueh3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llmevWFwkDG8+Ipbq2ngcKpTgUj+eSBP2i6gTWPtfks=;
 b=lpGuhC/DQcbOho3AqTXoQcsKpMI4PrBXMEO5v3Lh+j2ZkZ4vGJ2fGJe4q18DHpJGROErY+VmhzzzvrasegzactS8kpCO6qBcOsrHZuOv9joHaqkvyw/QjhLpJF64jnVZaC+t1YDd+FvIIH9MVaYpmYUqnw7OyfMvMuTk7NoMJ9KuvpUpPxU9lX9TEoWLbMPSRQNA+9Nf7MzlxWhiq4CscMUP7fEEqQ9H/BSkkMTm3Pg8RXXD69xHKjLtq+2nD3a6/7eMQPmfH60xSAx7Uf4YQ6EabX8G1PZ18Ooxu2njR1AjhOy4MXSlz/1gEt2BRV7M1s68wgcYCHRQAYa6H9dUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llmevWFwkDG8+Ipbq2ngcKpTgUj+eSBP2i6gTWPtfks=;
 b=RaBj9Aj/yqM/FFwCEqfXfs9JQ4L2BWFxOGSHyC/7butXmG0bdCOrQfcOhY7fip46FfG5Oy+PbkRjZnvAe21qUsc12K8VoEhvFDleHK+lKGssdX+I+TRhDBJ0xUV2zQQFQMFJfOK7bVgAil/1KFZdqIOmjCrq6gC5Y4iJ9CK4bXjUARpgCnd3YeHVC6n1RPSSmA7PVl1Go7zpSJeb10zxt9WxQsKUl9+sFyIEt8XRp8+RQ5J2aHHp4/zdRc0D9Ra/ZXzTsKBlzyOU41hz6+XMcFnvo5sQXnYmg5WbAaXJmrorJ8ieXSlXU7ykYwUfRS4ZWVOfCXnISZB4vy6AS2qkgA==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 06:54:06 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 06:54:06 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Moses Young <mosesyyoung@gmail.com>, Yang Ming
 <ming.1.yang@nokia-sbell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "julien.meunier@nokia.com" <julien.meunier@nokia.com>
Subject: RE: [PATCH v2 2/2] net/mlx5: enhance log file path
Thread-Topic: [PATCH v2 2/2] net/mlx5: enhance log file path
Thread-Index: AQHbmmWfBdPx4ofaLkGePAw+/qv+MLOcpqOAgDJxYICAI+2uIA==
Date: Wed, 4 Jun 2025 06:54:05 +0000
Message-ID: <PH7PR12MB701812C6D5EBD32CCB17D1D0B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
 <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
 <0a6576b7-5981-4a7d-b33f-aae011b86a00@gmail.com>
In-Reply-To: <0a6576b7-5981-4a7d-b33f-aae011b86a00@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|DM4PR12MB5939:EE_
x-ms-office365-filtering-correlation-id: cf04a42f-5459-4622-ac11-08dda334992f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?empYb0FQOUQ1MmJLU3E0VGFBa2ViQzN2c0pMTy9zdFBJbEQySGhLek9GdVFn?=
 =?utf-8?B?cEdyOTlab1M3WngyRW50RFVkM1JPQjVybHZKSHl6Y05sWHdtZFJZaUlidHZE?=
 =?utf-8?B?NU1sTE1CVzRiY0lIK3pwRGdlQWJiQU5McGVEMkZEWWFiZU1IaEpLQzdiOVM4?=
 =?utf-8?B?NlJ6eHkwR3FnQXh5QzBEUDhNbjMyLytueVBaU05FdUMxZVFNTE4zOUJCTUVt?=
 =?utf-8?B?ZXZXeHlLR0JibXp1UDdxSjlkNlNHRkswR2tyVndhUVdOZGNBbjhOVzlyVEUw?=
 =?utf-8?B?MFE1c29ycGhPdkdzMnAxWmZUS1BieXIzR3BHbUZEQTNpRG9oSUQzbzhQdUd4?=
 =?utf-8?B?YzYrMUZXVGxPVE8xWDIvSGZ3SGpmY2QzMUtJZTRvTnVVcEQ5eHg2OG8zVFh4?=
 =?utf-8?B?TXlWUEdUVEZWWEQ3Qkt6ZUdKKzcwOFFXK3IraHkxOVlOWTh1cktiUzRsSE5I?=
 =?utf-8?B?c1o0ZDJWS2svbzExVmhzSERyWjE1NHFCVTN6bGt5MVdOT2hDS3V0enA2YkVH?=
 =?utf-8?B?VlFRaEZZQ0lFMkVVbmdtNVNKUVZRUElVand2ODlwa3VUM2pVY2pnajJ4dGxr?=
 =?utf-8?B?VTJ6SjFzZENQdW40V1VWWmlCa0VtTVBtM1Evc2Y3aHluVlRoS1E1eWsrR3ZV?=
 =?utf-8?B?WXE0NGpYZVdEbVh2Nkg3blJHREUrcmVHdWZWNkRLRmQrbWxCRkt6bnNWb3V4?=
 =?utf-8?B?MFNuZmZZcW1UdzR0NE4xVUNoZVFSU3ZPM1J5aDBKRndxaWNiNlREYk5YZk13?=
 =?utf-8?B?OERUTTBoS2ovMTFGYzUvMEE5bU8xQzFiNVJqWEFoSEczaFdxL2VKdEJNZElM?=
 =?utf-8?B?YWw3UElFQ0tObUJFME8xZWhvZVFYOFRPS0pvcmVzSXIvSWZ5K2ZYa0pVSnRP?=
 =?utf-8?B?dmZRZkdKY1BrUDRndmp2LzJlNGdDMG4wOVBzbzFiVDltSlNXR2NlL2lHK2FF?=
 =?utf-8?B?Z0ZsaEplcnJDbFJqV0VhZGJtRG5qZmxvSHRzRHZKL2FLbzRXRkN3VnpVL3R5?=
 =?utf-8?B?UWJ2TTZkKzV2em5MK0dyK0gra0h1S0FRR2NhSWZmeGRoSXE2R2t0Z1NUbGU3?=
 =?utf-8?B?K3dtYjFFQWorUnlZbWJEUDI2UTg0MEhMVEVwR3RFcUhHYmVxTGRrN0RUSHRH?=
 =?utf-8?B?YWlkRnJndmxpYW00RFdmaUIzWmhIN2RBamRDNHNtVEw1RXdaSm0zRUtNUzEw?=
 =?utf-8?B?RGhZVm8zbzRsUHRtMnhpZlJ0WWJKTS9nbFZNYmt2Nll5Z0FpUTVHb241WHFK?=
 =?utf-8?B?QmNNcG9kR3B4UU1hZUVndjRZV0VubWVRZ0JFZWZKZEZWeGpoeVVGWGV6QnJh?=
 =?utf-8?B?bjBxTjJqN2Rpelc5RzV2MVpzWTluWFQ1L0xPRnBrejBXL3BGNE5xWmRwY1pX?=
 =?utf-8?B?aU9kZDNxU0RUMmpSNW5OdGxabFAvSXVFd3d0ckEvdWcxSnpDampzb2tTYVhl?=
 =?utf-8?B?TTVjbXh6NWRNSVliOXNZYTIrVDkwSkp2YzB4bEhuOTk2UytUQktwOEVkSDZy?=
 =?utf-8?B?cTltWGxORHE4c2pRYmEvNUZZb2lOL0djWW5qb1NaUnBzSGNndklNUmtkd3RW?=
 =?utf-8?B?d2t4ajVhNldXSnZBdmlHaU5xVnlaZ3cxenZvWldkS2tXQmI4UEZOTzB1aUxY?=
 =?utf-8?B?NEJVNnRSYXdQQUZKSUJjbkZVNGFlSmQ4dTJZM1kvMEhsR3pBbG4xNTNkYkcv?=
 =?utf-8?B?dDNZNzlOcXZXNUErSnVkazQrNmloR0xxMWZQbFdJaXRzVTgvZVFmK3BEY21n?=
 =?utf-8?B?Qk1FWStHbUwvQXM5M3VFaUdCd3NSZWk1VVhWQTczcXJGc28zS3hvVzBIRXZI?=
 =?utf-8?B?d0dRVzd4Uk8vT0FMOFZjekFNUlBVd1hSeVQ2cm42eUNINnU4THFVOXY3L2hP?=
 =?utf-8?B?a1ZwWjVCdGo5S3NtWWIwNHZYRlBLbTAwQmNlbGNFLzhka1BsTnlpNWdVUVds?=
 =?utf-8?B?Ym1hT0NWVzd1MWlVcGoyUlRLZUhmUmdQZHhma3ZPUG1Gd3BKY0g0UzhHWTVo?=
 =?utf-8?Q?mL3krTQluxsPQaRfP7BcEZoeP/E/eM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGx3SERjSm5sMzFtRGxEdzFyQzR1TWNnc2s5Qnduclg1d3gwcXlrMWVJMzlq?=
 =?utf-8?B?Q0NhU0hsUXJ1UXZKL3RRbkppZ1VXa0RWZ0w4N2RXZzVBTkNEZUIxd3I4UDR2?=
 =?utf-8?B?WTh3R0JjRlBWTHFDYm1keWcxTjg3MjFHV0txZ3dTZTBkcVhZVDdFTXNDa3hP?=
 =?utf-8?B?YW5sWWJMREFxUEYxVEU0MzRYSjR4VXFBS2R6eCtSM0Noa2labnNBWU02N2xX?=
 =?utf-8?B?aWtySDB3SVdPeHlUcU9lK2xMaXA0UFdMZTZVZytQR2prMjdnL3Bta3JPNXhv?=
 =?utf-8?B?aEdoWHVsSHdveDR1b3Z5bEh3VEZmaHU3b2llYTdvbWpyYk5td3pZV3kxOTFM?=
 =?utf-8?B?eFVwVlpoLzd2eUZBTVVpamt5YUw5VWNqYnArVldKUHI1ZDlEblZtSEVkUUx3?=
 =?utf-8?B?bG9vM3ovQ0xtaHBkd3VoQXhNK2lrSnk1eEIzT1czeWFDdXd2cTN2N3AyVXJv?=
 =?utf-8?B?c2ZmSTVZSVJ2d0VnbkUxSEZYUDlDemxvZlpTTVBxZGRPK3l2cjNIVk9OUzhr?=
 =?utf-8?B?aTFKcHB4UnV6ZmtFSTFPNWpPVXZVR2V5UGhZeTFPTFNodEEzYjY3ZGp4K0h6?=
 =?utf-8?B?ZDYzY3hJT205eWNPWmZkSVhBcXF1S25WOTRCc1BVb1NkUG1pNEh2M0lqVVA2?=
 =?utf-8?B?Y2NMWjdsVmE1em5qcEExcm5kZjdRYXo0UHJOYkUyZnlVOFZOVGl5cnU2Q2Fl?=
 =?utf-8?B?akk0VlRHSHVUKytOLzBUeTVLb29oaXRwcldBbURXaGtjRFVTVDl4WEluTGNu?=
 =?utf-8?B?Nkp4QVVSaGlybDUyb1AxMjl3V0lwNGphMTlmWjJ1WlVWWHIxaXVzNUNCbkRB?=
 =?utf-8?B?N3BtT09Eb2VZY1YrZU5pY1VRQ0tFQVpVVUxrbitnRkxwYyswTU13MlJLYktH?=
 =?utf-8?B?TGJqT0txeStyZHp2WjFheGJnTG9GS1dOSjliNnZGNk9OZm9aNk1GQndXNFpI?=
 =?utf-8?B?TXhHdlkrL1N3SUtwZ1hqSEQreCtzckFSbVlmV21OSGJOVVpheHFRRmhDN2Jv?=
 =?utf-8?B?MFZmdEJaN1hLMVJyYkNHcUhiK0R1WkM4bWZEVnQzUm5Ja0dKcXl1Q1NpWElI?=
 =?utf-8?B?clJiMnFPUFl2SC93VzdsdnhPd0U3Y2J1eGF4RitrNjhjZlNBMUdOTWdEa2xO?=
 =?utf-8?B?K3Y5MGl2eEpON2Q4MENtNnU4SjBPbWlrOENCeWtYNVdIeVF2OFFwZm9iZnVl?=
 =?utf-8?B?SHNteEVaL0cwYjVHMkpPb0lZNWRCS3VQNStmd3lvR0pLNC9NbGZnakJINlAz?=
 =?utf-8?B?cW9ZZWlPMlpnZTBzNUNGajlGU202OGMrZWFvM1ZIeFMrT3VmdnFRV3ArRnJT?=
 =?utf-8?B?clFMdmx5ZVFtWENrNjNYalFMTVhtckt2dm05MXFUYlE3aS9LNVhXT0VxenUr?=
 =?utf-8?B?bnJHaUNuMUF4RDZwVGpOcHk0NWdVeTN4cWF2b1R2QnZ5TWlMY2JOTm0wdGtr?=
 =?utf-8?B?eHN6aTR1ejhoU0JoQjVUSlVWVmJnOTNyakVCYXh6d1YwYytPS3VRelFIWHJK?=
 =?utf-8?B?aUVPMUxBZ2M1YzNYamZiTnkzNWY3QVNQd1dpaHNJTHFlQk1jM29jbnRFcVpH?=
 =?utf-8?B?TldlZ21GOHQ4bndTM0l1K21TRHpEWWlEOWtZdktDaHV6TElXZlRFb0dtallp?=
 =?utf-8?B?YnN2STNweUcvWGs3TlY0c0s5Y3VMTmJrQW5oOWw2UCszRXZuamgyWG1UUktz?=
 =?utf-8?B?Z1Q1Q1JGRjdKUXdWRjNWNkgrMjBNR3dTZi9LRkhIUU5manNUY0hYNlR2Q0RI?=
 =?utf-8?B?QzV4a2htblhjTFN4Y3JYYmFNOVVPOGxibWFlUHZQa09EaWt5VVcrR0kvRVRS?=
 =?utf-8?B?d0dHRStzNWpINUZla3h3NFhrdmt5Nms5YVliRjNYVk91aXgvUzhkZWVTSTFt?=
 =?utf-8?B?c01QK29hWGtodUpXVWwvMkI3NmZiRTZFTVlGbmg2OE4zUEprSDhYQ0pac2NP?=
 =?utf-8?B?N2pRZTN1L1lQTURjbk5OMVRSQnl4ZTNNOTB3TkFoa3ZXdUlYTjlXQk5hM08x?=
 =?utf-8?B?RGlZejZzcFZnVGF6ZzZPekM0R1ZPZVFSVGtVQWY2ZnBYQ00zK3FsR3lLbm5j?=
 =?utf-8?B?T0Q1NTJVQzUrNk5sUi9MT2t3WGxBZjdjazI1NjV3MGFRK0hmcVEzamtNUHlB?=
 =?utf-8?Q?T1WPXuRZb6frXuqIffRu3sLjt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf04a42f-5459-4622-ac11-08dda334992f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:54:05.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwFev/G1U7i+VRDJXm8GStWi6iW2lMoRPhv3d+wQj8gTsCqOddta68d2HJ2klRYUt4n0rVATtZzmqBsxHGbbKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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

SGksIFlhbmcsDQpUaGFua3MgZm9yIGNvbnRyaWJ1dGluZywNClRoZXJlIGFyZSBzb21lIGZhaWxp
bmcgQ0kgdGVzdHMuDQpDYW4geW91IGZpeCBpdD8NCiBodHRwczovL3BhdGNoZXMuZHBkay5vcmcv
cHJvamVjdC9kcGRrL3BhdGNoLzIwMjUwMzIxMTMyNzUwLjQyMzctMi1taW5nLjEueWFuZ0Bub2tp
YS1zYmVsbC5jb20vDQoNClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1vc2VzIFlvdW5nIDxtb3Nlc3l5b3VuZ0BnbWFpbC5j
b20+DQo+IFNlbnQ6IE1vbmRheSwgMTIgTWF5IDIwMjUgMTM6MTMNCj4gVG86IFlhbmcgTWluZyA8
bWluZy4xLnlhbmdAbm9raWEtc2JlbGwuY29tPjsgZGV2QGRwZGsub3JnDQo+IENjOiBCaW5nIFpo
YW8gPGJpbmd6QG52aWRpYS5jb20+OyBEYXJpdXN6IFNvc25vd3NraQ0KPiA8ZHNvc25vd3NraUBu
dmlkaWEuY29tPjsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7DQo+IGp1bGllbi5tZXVuaWVy
QG5va2lhLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gbmV0L21seDU6IGVuaGFu
Y2UgbG9nIGZpbGUgcGF0aA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiA+IEhpIEV4cGVydHMsDQo+ID4NCj4g
PiBpcyB0aGVyZSBhbnkgY2hhbmNlIHRvIHJldmlldyBhbmQgYWNjZXB0IHRoaXMgcGF0Y2g/DQo+
ID4NCj4gPiBCcnMsDQo+ID4NCj4gPiBZYW5nIE1pbmcNCj4gPg0K
