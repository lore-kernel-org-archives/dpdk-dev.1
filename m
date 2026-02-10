Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D8EB26F5
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A55640A87;
	Tue, 10 Feb 2026 19:20:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7AAF640A82
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:20:48 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AHsWmT1274113; Tue, 10 Feb 2026 10:20:47 -0800
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022113.outbound.protection.outlook.com [52.101.43.113])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1g2d9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 10:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpQzyBGKvJsi6fwAaMizPVXvLkj+3JwFCg/xlQoHNzYZBW1zYlRKcPWsDScvrTIJLRHuHOf/QhN95EV4Zg+UCp2F6bXZFDSSWNmTWApuTy3iOrkf1EaFu4zlvRv4lQgyD9WjTM5TOJNFHiQ21xCqVv7cBDF0w1GRX9AmfT+Jnf2asSdFv7NhmdYGO6eSG1ZEkzkHzXFlLwSfYF+X+W6E+/XmhgngAM1xyihjWix9ZleaF3yf3cIKU1xoedrWxWU0nxRFGcCmiuMX2AkHCZV42sTgrhCPkgDtPCF06WvtaOvTrVi0asZISCX1pqqYoY1wVItJV1b7HX9zZCl1eKXHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8BQmlRpuDS/jHfHsaGCiAfjSbMEusQMZIDYAhbI7F0=;
 b=gYBNbEC4AczfBqFmoajk1CvMw5vPa+2JX3sz2Z3zXFoesTRmjbFG51foDvvgrHsIOVKnweoFtryVylvOqc4An55qEtoxPNQzuxzRF5RISIOsaN3ocpz3Ux/XvfYhW+8I76xfCvmkNdQRsyk21hb9vuwk5dUtPYU8hpNalITl0eoaOHgoaNWrM5OQihlXf0xcuBoOb8oUd52GkizVFrumtfWH3xzBu1PF7p8/ZKSEg+sy3CunqDZ35ICFCNlJL94hGbwNbOxlK72T1jzaSib3oMUkmW4oB7PRtT3xIsZxn8S2J8lZqTFtQZ9XKTsbsm4jAef0TSNxxfwpKtSt5PgEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8BQmlRpuDS/jHfHsaGCiAfjSbMEusQMZIDYAhbI7F0=;
 b=jDjHzwXNF6i3Oq7u4ceFc/7A1iyb+dnsPQN/Vmc3A1uPm38Yj40bDe2G6OGwzPSvC+mGPsiJqI8imiwwtFFlFGO2gje374Q/uUawcSMgaNWs5jktaz6alNfaJziT6ehfgQ/Yi8fMw1diki6juRf11Ar2K1ZrC2rDoaefsXNlRc8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6351.namprd18.prod.outlook.com (2603:10b6:408:274::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Tue, 10 Feb 2026 18:20:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 18:20:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Kai
 Ji <kai.ji@intel.com>, "pablo.de.lara.guarch@intel.com"
 <pablo.de.lara.guarch@intel.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: remove PMD specific asym
 testsuites
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: remove PMD specific asym
 testsuites
Thread-Index: AQHccCf52IRVx+pnVkKcwpvbtr/L+bU59gAAgEKdUMA=
Date: Tue, 10 Feb 2026 18:20:45 +0000
Message-ID: <CO6PR18MB4484FA2C0961B4104C1A438BD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251218140909.1816595-1-rchiluka@marvell.com>
 <20251230090326.3881821-1-rchiluka@marvell.com>
In-Reply-To: <20251230090326.3881821-1-rchiluka@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6351:EE_
x-ms-office365-filtering-correlation-id: 5cafc5a0-f7ae-4ab0-e3ce-08de68d11bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eExieUJzS1RMWWVMaHRNMnJOTTNkQVduYjZrVHR0M285bVB3QzZtdllPK28r?=
 =?utf-8?B?NTVrQjB0eDBhamE3ak9HcDhUTHBVUFZHMFBrdm5OdEVKUlQ0MzVSYTZoYXdX?=
 =?utf-8?B?ejNnZ1JzRDVlV2U3cmlCVHBJZWljNGVmTEZ4c2dyVkpxN28zbUcwZS9hdm9w?=
 =?utf-8?B?ekR6Vm9xOWNVRjVsMzRzdERNZ3l4TU5nMjJ5bjl1VXdGeDJTNVRub0JCazNi?=
 =?utf-8?B?ZXJRZTF2TTJnaTdOVlNxTUdYY3Q2Sk9zSDJiSVphSC83ZVFIU3p6by9RTkdM?=
 =?utf-8?B?QUhyb21iSDJzRTV3enpFZnlOK3gxajcxSU1EQUZ0MkFNZ1VOYlFLaGJ6Tnk0?=
 =?utf-8?B?MHM4R2FFZTgvanBEdzRGbzhUVTFnK1ZOVUp4M0w0MGJNUUVjRGJtdkRpeEJp?=
 =?utf-8?B?UVppYU1ZUVBTWlVyRlhuRjdxVlZBblN5K2krc25WTTkrRFZwc29oM1pwTWQr?=
 =?utf-8?B?djNsUTNmb1QzSEYydEVKdVF6azBhb3BmNit3eXluamlDTWprWVAwZFRZUjho?=
 =?utf-8?B?MFNSQmRLQlNoSnRxUXhQVmVSU3djRW13QXZTcFo4WitjTU5LVEVMZWIyQ09I?=
 =?utf-8?B?ZStBVXNzc3BSUVBGQTdSWk9vWGFMaTR1bndXMElxdDdVQW8xRWNCUmFWajlN?=
 =?utf-8?B?dzBhM2lPSENKVFl2N1B3RldJMzhWajRlQ0svTklFNEpiWjlkaUUzN053Qmll?=
 =?utf-8?B?aWVUMFBzWElBQ2tlNlpFSHJFNGdGSWUwbE5yUkJuSWJGQkJQOGZ3L1haQlJG?=
 =?utf-8?B?WE5NNGFxbDh5eUtwU3dDS1VINENvZG5PUERmOVdjT20xUUI2cW9PYTBFMUlS?=
 =?utf-8?B?NkMwQmQ1Zm1USjVxU3NBUU5QL1NRTzl6V2tTSGM3UjlrZlVSVlVOY0FHSFFI?=
 =?utf-8?B?eDh3UFg1cFI3T3hKOUFEcGhndkxuVkh3T3dMYVI5MG53Q1lVRE10cGM1dVI3?=
 =?utf-8?B?QjBlMjdpNkl4clNFc1A3Yy9DRkI4UXZ6OTY3MGFINkF0dTU4LzFGOUtVUFNS?=
 =?utf-8?B?VmtZQ1YxOEJlS3QrUWVLODh4L1ZJbUtLWjFUbUdJVjQyT1ZXQ3JtTE11Y053?=
 =?utf-8?B?M0hmclZFS0xDanhJbEgyRjNBZFZicFVJaS9CWGZjZjgvUVZBUkZ2Z0w2Y2hj?=
 =?utf-8?B?UEJVRVhNVmZNc0YydFgzOXFJN3hVT1BBVGhwalYyYlByd1I5RFVhQ1BBaUo5?=
 =?utf-8?B?RzhUWlhYVUhhOFhSMFFQQXJCSm5tU09UNElzMkFQWDVpVVgwWmxsOXBERDBp?=
 =?utf-8?B?cDdwZ0c5UDlJWkJlUk1OM2hhU0FEZGVVNjFiTlVLQkFUUXJEOTIxUEljc3h0?=
 =?utf-8?B?dlAyM3YyOFFJRDBsRzBvMzh1QzN1Y0xRTU15cnJUNW1lcm1KcnlQTDhxQ3NV?=
 =?utf-8?B?MUNwb0RHeHFLNStTMGhtYjFrNG9uY0xXMG9iNTBsalJueklaaGZ4TWFqazJ6?=
 =?utf-8?B?Tkk5RDVhWnhNMHZxZmlEVHJPMjUyZGFwMXRhRzZhdWVYQXFhRG1WUEtRZUxq?=
 =?utf-8?B?dkE2WnZXN3hSa3JQWHZxT3VKdzgrUWdsYWxheFVoTWZBdUhwTlNSVGhVVW96?=
 =?utf-8?B?NDZSZWt6UW82eHhWSEpsQ2loUGJQNFlLTnM3ajhsZ3ZXcDZzdkRBRmtQdTFy?=
 =?utf-8?B?VGttMHR2NEh5c0JQZGN6M25iRko2T1RES3VzWjY3RFNhVlQ1SWN6bHlNQUl1?=
 =?utf-8?B?NEJwc3p4ZUJnZ2YzV1kzSmNWWmQ2T3JrYnRFNm9qLzJpenN3SHEzWklJVkk4?=
 =?utf-8?B?UlBPbGdjNEI1Z0VMdmRFazV1SklNQ3B0NG5Od2lKWUllQXN1YUZsdzdHYXRV?=
 =?utf-8?B?ZklzcjV6SnF3SDZJNE5nMitFUGg1aTU4YlF1WkExMEJZQWhCT1RIbEtWZUI1?=
 =?utf-8?B?OFdhTk45QVlNNmNlYThELy9SRVRqVXpJMkhEeWhheG5wdm1lU3V3d29RQWFt?=
 =?utf-8?B?ZmhLMVRTYjh3ekhDVXM3VFZHSVFhUVJQRCsrZ3hvRGF4cXdYallFRWdSS2V6?=
 =?utf-8?B?WXlEK1J0ekxuZjhjUHd2azJ6V1BsdmhTeWRDV3NaY3pkektwbVhiV0ZzTi9t?=
 =?utf-8?B?SE5NaUwyZzVjL1E1ZTd5TnlXcnZXU3NnVHRNSVM1TkpRb1g3b1lFVlBYWVlx?=
 =?utf-8?B?MFZRdnpzOWZOUFVhUUVLQ2lYa1BveHUvUmtsV1ZKRDltN2lYb0RCQ2g5K0FT?=
 =?utf-8?Q?6nX0V6jFjpT5tavRtjVB8qY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnZ3QmpyWFpIblZyZXdyWFZaN2QySDRLKzRlUTArdFNheU5MWEFPa0ZwSGc3?=
 =?utf-8?B?bG9oZ2hIbERSQWRoUHB4NWFLUHJmVzlOU2RZc2YybmRiaDBPYzJxUE8xbEdp?=
 =?utf-8?B?Vm8zY3pGaU1SelZ2dEx1YytMZ3Rnc2VHTVpzbFdBT1pwTFlkSjFpdTB3ekRD?=
 =?utf-8?B?Q0t0cHNvOEJIV1N2WWlXbDhDdTFwaDNYbXFSYTBMZktUUG1RTHlrSnhTUm0v?=
 =?utf-8?B?THh1ZHE5UEdhU09QNzlIdDNNVjN4Q1Mycm1ISG9rNHVFeVVFVkM1TVlTMjdK?=
 =?utf-8?B?T1VwbjRoUlNjUForU3NSNFpBeHhjelUrZUJ4WUVLZEhuLzB6REJJNDJXQ21m?=
 =?utf-8?B?R21TVjVWaWNka256RllhbVBwRXFCUHc2Q0paSkp1bHBnQTIrZTg0Z0RGTkFP?=
 =?utf-8?B?WnpLSGlhQi85OEVJb3o2M3JwdkJReUZ5ZnQ5ZExXb05QUFpmanJQVXFBajNw?=
 =?utf-8?B?azhqQjJxTmppOUoyVnVpWVdoU09PWEZIeXY5dS8vd3JWODJXaHBKNWZjREFk?=
 =?utf-8?B?UWY1aFQ5aXRDMENheUI1dHd3czdRaEEyaEV6OXZZaWFodkxkNm4vNW90MHZD?=
 =?utf-8?B?SWZwWmlzdXI2Nk53eVRLcjVUeEtNbUF6NTM5N0FBdy85SjIzc2VDbDlCMkxq?=
 =?utf-8?B?MXVvMXhscUZydjNEWWpLNEhpZ1Z2Z1Axd0tVemtZSWtJRkFKRmc2SlJFM0pp?=
 =?utf-8?B?K0owa1l0ZDAvMzVYVjhKQ0pDa1NwYk9OSGk0RnRHRUtZa3pXMjN4WmRkcWZh?=
 =?utf-8?B?SlZBc0Q1THhNOTBoSFB3K1pQY2FiMmM1Z0hyUHdXZkd2UmdIWVJoSllHcWhi?=
 =?utf-8?B?YXF5WFVRKzU0V24rRVhIL0JNd0hUWDdLeC8zMHRCU09NZzBNWDlKUjc3Zks3?=
 =?utf-8?B?Nk4rYkhpaHppb1YrOFJPZTkvcEcxSEt0bkZmTFZ4TjBXVXJjMlpxRTd4ZE8y?=
 =?utf-8?B?b3ovZzBla2J3d2dwbndTaGNjeG1wY2d0dXcyV0JZNnhaZkZBbHl0eWw0WWli?=
 =?utf-8?B?dlc1WC9Gc0UrbldZYlpWRnB1ZlBjM1hHTWtqdGVjSU5oS2lVb2JNdndzblF1?=
 =?utf-8?B?Ny9PNXlpSXpOQk5jQ2UxMzhuNlBrQmRGb3QzK3MrbGczTkxlS3prS0FEM0M5?=
 =?utf-8?B?Y3B3eWtUNmF5T094S2lXcDZNNDBsa2tOWmJrWWtzdDNxVXUrYVlvRkJlYU8v?=
 =?utf-8?B?eHd5N2gvTFliaVVBaHVGbUcwaVNBbkpWclRiQzFMelBiTzcwMmNFSU5CT1Fn?=
 =?utf-8?B?MkdHWmFzWU94YUhiVUZ6a09EMHFlV1VIelFBTWFLZ1dxZXUzVG8xOEQ2Tnhk?=
 =?utf-8?B?MTI1WWZ6MUFvNC9Sa2VJTnpuZG1hNUU3Mk9WbWx3a0ZIbjR3MWNraXNveDAz?=
 =?utf-8?B?KzhpWG4vWGdDTGRoUnlWTHVjby9pOFJGUFY5N1hzSHE2Ly9zMkJGMGMybFND?=
 =?utf-8?B?Qnh4ekVMMWgySVJ5Q0lwZXp2WWlPZjd3Szk4WjhrQkNsN2RCc3FUSkxTeUpm?=
 =?utf-8?B?VnZoTzFlZFVqakJhblFvYitxaDh2ZEhYSFJsOFI5RHNHRVA0UTdheUlYRUJw?=
 =?utf-8?B?Q3dvckU3NFhKTmFpYXZmMDR6K1lyUjI2ZTY3WnBuQS9NUUVSMTdyMkJxTEx4?=
 =?utf-8?B?c084R0hiVGt4NjgzNWNEVnVzOG4vcUI5Nm9OMjFyYVBVc3k3OGZLU1F3RS9j?=
 =?utf-8?B?RERDSnBrZGxOTHF6NlhKbW5YUGtwczRhaDhXOFVxUGpZVGhHSWxhcStUOE1J?=
 =?utf-8?B?VlErVGpQallWeHF3LzhsVVZYZlg1VEJQUXNFVHlKVFVIUUZFdDV5ZDFFbjlQ?=
 =?utf-8?B?ZUc3L2dpZlpqN29rU1RhbHdlTEY3aEM5clpRL1pCSUJXMVhFUTFMWG9NNnZF?=
 =?utf-8?B?cS9YMXkrcDBvY3ptd0FnUjVweDdBd1JzMU5EeThxTkdqRnd4RWRudFlUTnFa?=
 =?utf-8?B?UFlYaE1BTGVhOFdqTHBYWUNNSmRVenpnRFRHUEVJcWsvMDFDYW95ZWVRVzRD?=
 =?utf-8?B?SGpVRUlnM1Z3NVBDUExJdXg0WXk2VGZJVUJMdWRtajkvM0dPTzU3aVFBVVVo?=
 =?utf-8?B?WCtkOE1JOTc0eDF0SG5zZ05zSDlQWWxLY1UwYVVkdGdtczVrV1cxcVZvYkJU?=
 =?utf-8?B?RjMyR1NpaDdVM1JlcWtSQkw4ZjdqWkROeXc1T01adEJBenZ0Q1p5OEVoNlps?=
 =?utf-8?B?MXRHQysyQk5VT3Y5ZnFidWdrakw4bXlYV3pEQ3B5cmxubEtsUHI4TVcyVUlq?=
 =?utf-8?B?NDZYVTMxZTBrL2xUaWg2WGVOVnhNa2pQb2Y2WWZFSnFiUHJhOGwxbWJEWUhH?=
 =?utf-8?Q?fOf16bR51iXQ0DAUQl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cafc5a0-f7ae-4ab0-e3ce-08de68d11bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:20:45.5768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nl6eTFAwxVzNgtyzwcUJI9s61ijW3+MhKSyP1E/VQwMDExH/wylaCU16fdp1l+h+LziPAp+XQ2Q7IU/L1EWsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6351
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698b76ff cx=c_pps
 a=6opEo9M2fWe+N/0KKLrvTA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8
 a=uAH1H1Hqf4_u3las6pwA:9 a=QEXdDO2ut3YA:10 a=xImrzNact8EA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE1MyBTYWx0ZWRfXzYamuZYChutC
 yCqlc+w9LPmmIYjysyA2Be/w1JyehvtTPzGVQGq8YaEPQj4UMNMIv4mfdpIoEpa9LrvW4+UIjAN
 vN362bFXysZF4ffTetsCeDIvpQwIxVxiHgA0A8x1jZMzK68UeOGPUjTiXgMxv97+OAzVBzGNcBC
 kxHaaWd3BimOCQa4gerjZz9ainGx8tnPTOX+MRIwBQvEBHe1GlbrObpo+rmurrAwFRKs6lmkpgc
 pQ9FrYh9Ne9yhDaqUofQVo65XYcLd+v26vHMfM6/hmVMuBIVwA/pCXeZm3epFDihELRFrDMpKMj
 Mw4RHURvDnPFzb10sPXRX5ihFS2NkDHYm3IDzmxup/AwWov56BRa0CnPl9+1WiAznDJvQ9V9Oj8
 lliXHEzK2uvqVBPFlXNeepb3qHDZ50YE7sAQ8D3YzCJO2wgfm3AG8q77bxMNkwZuhtCcj/5Mdo0
 jaKPOAbKJh579DFaG2Q==
X-Proofpoint-GUID: 28mjfo2MKPZX9wp8SkdATd6IuWL6aa3P
X-Proofpoint-ORIG-GUID: 28mjfo2MKPZX9wp8SkdATd6IuWL6aa3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
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

SGkgS2FpL1BhYmxvLA0KDQpBbnkgZmVlZGJhY2sgb24gdGhpcyBvciB3ZSBjYW4gbWVyZ2U/DQoN
Cj4gQ2hhbmdlIFBNRCBzcGVjaWZpYyBhc3ltbWV0cmljIHRlc3RzdWl0ZXMgdG8NCj4gY2FwYWJp
bGl0aWVzIGJhc2VkIHRlc3RzdWl0ZXMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJ1cGVzaCBDaGls
dWthIDxyY2hpbHVrYUBtYXJ2ZWxsLmNvbT4NCj4gLS0tDQpBY2tlZC1ieTogQWtoaWwgR295YWwg
PGdha2hpbEBtYXJ2ZWxsLmNvbT4NCg0K
