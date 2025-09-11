Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA60ACAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A170402D3;
	Thu, 11 Sep 2025 12:37:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6C5DA402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:37:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7LIsG000325;
 Thu, 11 Sep 2025 03:37:51 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2092.outbound.protection.outlook.com [40.107.237.92])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 493sxv8ccw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 03:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2IKAWO1akadiC29LBlgX29trZXRKOUtExEG0Sg9paIhuyHJRyD9JCzcmeY4JOkqfWtBN5X2TyNb3OS5/dObzt76CxlXEDBNnv9NZHmWGaFPABTHkI/EVb/I2l/udlxYi7fKrAD4qpSn+eWgxzdhCnVd8gd04WY5JshckeHfxx2uO/9LY6AWxvDpt3T2LaWSDHhET7zqy7hxaJN7JJODtw0ALMLRq6of4XN3FNfGFxHt8Bcr6lgrDLV20sjlzhHzhN8Z+kr+BtG3sT+voRWBdbs4jiTqYjsIhKS+62LNZIaJwsrqywSZJZ5s7QgOcl4BBuIBVTjMPuCbat4T8zaDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYJRI1pGM6uCGYUF8LMyhm1oLNwbhMQvuiHvnUZ5MDE=;
 b=mAeukHTxzjfHTFi1FPq8grDN06dX1Fm8c2r/RwFrudouxJ/+SfYdFbtjuUBdEv/xk0a9AszCWzB2GXFkWOyJlMxWlUnRCYW6e32sa5g2lrBU7yZNRFsdIexU+US71eR+eKqMPTh5Q5GK4b7bEmUY4ZKPyeHd3fovxTal4DeC0OHhuL2RsCFx8t+Z6+lNvL+fjP8RT5mzO5ZWGkQ4GVIRuka0CFQXbB3yIDkR58KxKNnIMvkr5E4A6CtukT9jA9S9GWRsZAm580oTXPkiTGqwEopm204ae65CAEleZjiKjfhEu5TsnRj3aea6jfhGe+qcxDkZLa3Wlzu4S6v97ePS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYJRI1pGM6uCGYUF8LMyhm1oLNwbhMQvuiHvnUZ5MDE=;
 b=f6s9WfOnXMZL7yKr9RI/j6tHvaJRWTuYQ59/5Yi3ntsmIRa4SA3bkYsWYOiL+vYaah80Fi3lMgvis3Pt3KPG5Jua5UOguG8K8cTD9uJb4Z+5d2sPMTrU64PxqMogNy2LmcKVsrgacicJVXu79mylTOZ6O3pnxXoGw4TJTz/Z57I=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by DM8PR18MB4424.namprd18.prod.outlook.com (2603:10b6:8:39::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 10:37:48 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::de98:ceac:f841:3fdc%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:37:48 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH v11 1/1] ethdev: add link connector type
Thread-Topic: [PATCH v11 1/1] ethdev: add link connector type
Thread-Index: AQHcIvkLb5ZnESuxU06y3QILeC+T97SNupwAgAAPjhA=
Date: Thu, 11 Sep 2025 10:37:48 +0000
Message-ID: <CO6PR18MB38604AC1B070F38CE8C752B6B409A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250908085256.1866407-1-skori@marvell.com>
 <20250911084943.2383151-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FEE0@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FEE0@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|DM8PR18MB4424:EE_
x-ms-office365-filtering-correlation-id: 3d1599a7-ac7e-4bb1-7b59-08ddf11f40af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aXZXcW1uNmF5NGZMSGtqQTJSa05IMGpJMFV0bEg1T0RieHg5M1VsQWJyNGNJ?=
 =?utf-8?B?SWVjYkkvR1czMU5Tc0crdUVnVXY1REtTQ2JzaEtoT2IrclJVWUdWU2QwVDkx?=
 =?utf-8?B?NS91bGgrRmlRdjY4V2s0MFkxeFoyNnVyL3ljUGxQaEZ4WFB1QzV0T0NYcHEz?=
 =?utf-8?B?QXhpZUVaejlHZDNhYVc1bjdVV043WjdweUVBNUhHT3V6VjZJQlNFaTVtNmhL?=
 =?utf-8?B?WDUyUXI4Tld4ZU9qN05VT3VOa1Zsc011NTZMYWNUUTRwRUg0TjZ1a0VxRmg3?=
 =?utf-8?B?WE84Q0R5aDhWb2tOQzZiVFY3ejZWVTdnWWxTNUxWR1lTSDhYYjRZWXFjYVRP?=
 =?utf-8?B?dlZidFhMNVJzWEVHUVBkazZyaFdLdE05d0x0eEZwak9VdDFtMnNhSEZ6eHpj?=
 =?utf-8?B?eTc1cUFFZlBQOUJBR3VYZXRBc0pxS0ZGTHV0UW45OVdJeXcyZ0l4SVBsaTRs?=
 =?utf-8?B?ZHJIMzBIWDlSc1RCQld6TmRxQU5qdDV6SDE4LzR0N2w3a2V5L2p5OFBNV1R5?=
 =?utf-8?B?VXVjY0IyaFZTbGZGTG9kNFdac01DeU1SN01oMGRPTG1IZ2dUSU9jT0tYbXcw?=
 =?utf-8?B?c0NOZkxPSG9OeG81TmVmdWJlTmY5L2ZMc0U3L3NSMStrK3Y1a3FhM3I4bUcw?=
 =?utf-8?B?UmRmTmtIS21qTDQ1ZlM3UkwvcExxci9HUHNpcjlNbzZUTnEwL3Y0WW1KMjZD?=
 =?utf-8?B?RHpqN2t6bW80MUZpRFh0d1piRk83emE1ZjJmalNWZDdwczc5UzREQlQ2TkFv?=
 =?utf-8?B?Q3NKOWJYMy9YUHU4WmxGMU1nQzNaL1dtZzlaRFljY2VFZk9kczhhbitxdVBz?=
 =?utf-8?B?RjFYbVlYV01keUI4MnlnaDFtOEFuSEZwQk82WGt4dHMrNXllQ1gyeTgzdWxk?=
 =?utf-8?B?eGhLOHIvSjUvY2dKTko3Y29mL0R3a2dZYzFlbDVqSDRtcUM2T0R1NkNQRTJn?=
 =?utf-8?B?S3FTU0g3TmRpVUNiVEd6Y2RXNzloMnVCVWRZMnFleFh6VWgyT2piUkZ6Q0xT?=
 =?utf-8?B?Z1I5eWpSZWJZaXBYNDJjZ1RlaFdzZlJaYVgyR1hOYnpFVHYvaGl0dzk0eld5?=
 =?utf-8?B?T3E1ZDlUUUlUYmlhQkFjMWxyYUJRa3NvSkR4NmlpNDlXem4vTDBMZjlPenJJ?=
 =?utf-8?B?SVZiQmMwbjZRdWpOa3d4Wk5zcnhBcVA4TmhIRzNJalRFdTUzUVczS3hKU0pq?=
 =?utf-8?B?ay9FNWhtODhKOURSTFpRRDBwMzRjYXBGVkhDVUlCaWJpZGNnOXRRK2hTYVgz?=
 =?utf-8?B?K3ZESmF5VjBMZ0wwZ3duYnQ0R2Q0S1hiSzdBSzJ3OG1JcHorQnJNSHYvUy8w?=
 =?utf-8?B?cGszTVBPdm9jTk5LZDBjS1BoejJ4N1FSYmluWUNQSGVKMUZ2Vm1hcDYwS0FW?=
 =?utf-8?B?VDFsQm4weEFnUVMyeFNZRS85cmFVVnRLYkgwUHJpakR0ckIveXlWMmxPM0oy?=
 =?utf-8?B?eWhHczRPQ1BGMVdPQkUyN3dHbWlBaCtHbWREYXhPa3RiYUIrdGdRbkx0QnV4?=
 =?utf-8?B?OGlYMXFoSFB4UmZTZys2QXZxckJFUmtqa3UwS2xLUS9TTEpTYjMxVEhhNG56?=
 =?utf-8?B?NW04ejdlN3BhV3JKUU8yWUJibmlEYnptaEhZR0xLRUtPTTBYWjJZL0VadEJT?=
 =?utf-8?B?Nms3bjVFYUhYWXY3clM1dW5PSXVMNk9rbHpONGJSQVVHVVJITjl3WFZFalN3?=
 =?utf-8?B?MHUrcDRtWEl2Uk1OTnY3QXBVNUNZeTNuZ05ZTlJKOUN0dFlES0RyejFyeUlV?=
 =?utf-8?B?aEthRUdBdmdJRVVqUU5mQmJJZXFKUG5Vb3dXb01Cc0JqRFBhVmRwcnEyWmc3?=
 =?utf-8?B?VDA4VjFoOXFzSVk0bHNBVnpQUXUxdytRcEZQeUVOTGdjZm5oajBxb2lPemd4?=
 =?utf-8?B?WXZuaWhXUXZaR3ZQZElBVEVGQ3BHS05KUXQvSzgzaGdkQUYzTkVJdE03Qmp6?=
 =?utf-8?B?VzRzelk0T2k1TTNXcUV1RzZKbXMwUkkvRGhyMFc1eHZlWEY5VTVEK3Y4eVFH?=
 =?utf-8?Q?/aOOVYMZGopvoExFnt+vt4v4s0yMY4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi9UOWsxWmNNQzZ1MXM5MmNtbXVkTjFXdWxjQThBamFkZWdidlRlZXVweXRF?=
 =?utf-8?B?Z3VjYjhwelFyUVdEQS9BV2QvY0RIS2lMMmlGd21qMnB4QU9JS3hvTG5yWlNH?=
 =?utf-8?B?MkpJd1d3Tko0a3MzQ0YxbnJrZzNVRTFTVjNyTXdVbFJZMUxwTTNjaWpSWHRl?=
 =?utf-8?B?QXhqekw1bzNGQURnSG5iZ05uRUlkUkRkby96eGZRWTdYdml1RHZ2Z1l4aVA1?=
 =?utf-8?B?cXh3Qi9iaWlmVFRwdHlnMUp4RWNhbFc1Sk1TZVNMRm9yalVLNTFyUjVKOHNJ?=
 =?utf-8?B?TUluYW1xSEZZZzVYaDI5TnEyMDJWNDRqMGl1SklTV095d25hcWI4a2xIWmE4?=
 =?utf-8?B?OVFNYU02a0NjZ0ZyOXE1ck5qMVhyZEs5YjJaOGU1emdPUFBnSVAvUVNrbStQ?=
 =?utf-8?B?c0pQb1dEZzRQMEVCSmxjN1lCN3ZSVHpUSUdzc1FDZUw3UUl1TFc2M1NtVlpK?=
 =?utf-8?B?aURZMVIwWEZFbG81bHpQL0lyL3dhdmxXNWpRNVE5c2F1VVd2SEI3c1dCK3JP?=
 =?utf-8?B?bUVzOFg1WTZHajg5YUpxSmoybW45aktWaXlRaDQ0SjNqY24vY1pJWjNoVnlq?=
 =?utf-8?B?emdFQjRqNldMb1NXcXVOVU1mM21mYzFaQ0h3MVNOTkhWTlF2R2ZWMlhPc3VK?=
 =?utf-8?B?T3hKbUxsbHQ0RHY0dlREYWZvWXhJSVlXYk1nMStHTGxhVDhMbnZHSkdlQnFm?=
 =?utf-8?B?OHFYeXd0ZkJpcE96d2ppdzBVSXNFOHhUNVdwZnR0WjBnTXVOZEd5RTR2VXlX?=
 =?utf-8?B?WnhKc0tQK0F0OTVQR2xIOG5DeUlFUk1xOUVWdytyOUdMSVhBWTBmNm55Ym5E?=
 =?utf-8?B?REZnV2RWdXdIN3ZlcXVvYjUwNTZpU0x5NW1zZ3F2NXN3U1JMYjgvK0EyYnpi?=
 =?utf-8?B?S3Fpcm9pUzgvQUZaQ3lKOHlCWnp5bC9aVnhUNUdrUEI1T0lVNW40YmtISWZH?=
 =?utf-8?B?eldRWmZkM093bnBtdm9FQ1d4RDZlMXdqbmxCWXQzOFFPZHpvVmhMV1lKSGU0?=
 =?utf-8?B?eVFWdHdPb1pEZjJVNzRIeTRqY2E5WUZTY3g5VlF0TllMOUJXUGoxMUlMd1Vv?=
 =?utf-8?B?eFVCVkRKbkIrclZoSlFJNW9WS2VGdEVhNElVMG5nQ2o5SUIzOXN3bXBENEVG?=
 =?utf-8?B?WituZThpUHFZaXlLVlZWWjdvQUQ2UjV4MTEzcHdSdWltZ1RseVNYY2JYbHpV?=
 =?utf-8?B?LyszMFdnSGRZT0RzRno0ZEVZMGZPcEYzU0tuWElBSDFnelhiYUpXTFNxemJT?=
 =?utf-8?B?OXlPM2xZTXFDMkRnRnR6alY2eFZTMmVxNGd0ZHZDS09nYzBlYisxb0N6SkxE?=
 =?utf-8?B?QmRTYThOQURDNXBoTTNwc2RtVmNod3FRRXlxRkFtNENRRUUyZ29JMmFmZDRS?=
 =?utf-8?B?WHBFVUNmTi93aUxjL2pEeTdrY1pUS0tHa3JnTmpzUW13cG5UVzN0MkNaUGlF?=
 =?utf-8?B?Rk90L21ZQkYzUis3c1EzZDFOTFZZdzZBTmZWUTd1NXNEZEdBdUhOWTE3WGNM?=
 =?utf-8?B?YkM3MUpnbXdLV0d5T0FPcFRSTlhsaHpaUEhsUW9yWndyT1ZabUhlbEhoVXh6?=
 =?utf-8?B?cmtVSjIyUlBmK1hwOHB6ZnNRSFZCV01hVG85VEwwcGlRT1ZRM0Z4YVBJLzdV?=
 =?utf-8?B?YTh3amNQckJELy8zVzUyVjF4aVMvVWVTYTlYdzZvTlBEWGVRcEdhVlg5QUJP?=
 =?utf-8?B?VVcvYkV1R3F5ZGxXV2cxZ0J0aG1kN0hzUkRVdXBhSGtlRGF3M1hvRnhjMlNO?=
 =?utf-8?B?RU0xM1lUcmd2WFlxaW5YbTZlL21obE9qc3ZqejdSR1hsT2N1T1B3Ukk4WWtU?=
 =?utf-8?B?blRIN2wraTZFU3cwbnN4blFEcXFmTUhiS2d0ckgzZUJzZ2hMOFg5WjdsK0h6?=
 =?utf-8?B?UGxBcWxRb3J2RlN5Q3YxZWYxOUFZYVh0ajdDZldsTUg5MGgzd3NBdGxKVkNC?=
 =?utf-8?B?U2pScUxkQlM4NXdVeUZ3OFBoNi9pTjRLM0k2VTFTTXBhSytBN0VLWjgvYWhH?=
 =?utf-8?B?WjYrcXJvVjhjOU9OYTlpbDJybUU0alp4NXAyWHVlUUlPSGhRUDlhb0QzNWFw?=
 =?utf-8?B?UEpYU2xUZTJRYzd0YzZxcFBybXFVbDhhYWdsNHkzb1ZhNWw0ZXdsbnI2RW9w?=
 =?utf-8?Q?Vv4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1599a7-ac7e-4bb1-7b59-08ddf11f40af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 10:37:48.7813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O5liM5gRzqsFinBM1QAv4wMGgkJAfaDm23r6E6d23b3UmLNizn158fJHXpfRZJ550VEuJQ51/VmYHeLHC5N4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4424
X-Proofpoint-ORIG-GUID: -eW-rUgG9EWVOBVyRlTVkNVQReuMN1a8
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68c2a67f cx=c_pps
 a=Q0MAeiTfLGPhsXU2vnsVPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=6n3xnvXpOduZ8ko6YqUA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -eW-rUgG9EWVOBVyRlTVkNVQReuMN1a8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA2NCBTYWx0ZWRfXz9NfuKQtf6Id
 LvY63RxYJAhXSDwvj/rM6G++FP7/lwlpgTIiCmeyl5DeXXq+z218zCSuH+Odcwq/AHyQ84yR03G
 aLUFGJECYheea8UNnP+TwabAv4wH8aEMMkKT6SgxoR4wxEvbBr0D3ilAaOHLi7TMM3QhI3Zf6tj
 sHe0tDbgvFxs34HhxqoMGl7xgFO31tn+qNpi3CJm4sf5ITzHhlFHyLnpwKn4GpDWxiianPCnMd9
 alHGMmZzFujiNLYP/wLU/WtQ2+hEBb/wQfwjN0wvb98w9GBStsvu6+ZgrlR6FbqPWUxTbceznr5
 FWp3mLiNf27mk1tPeHT/JETcZpT1A/CuI3rbPWN9vEysVsT5xXLQWr6GmnwOM0GpfQp90THnep7
 R8X7MiDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
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

PiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KPiA+DQo+ID4g
QWRkaW5nIGxpbmsgY29ubmVjdG9yIHBhcmFtZXRlciB0byBwcm92aWRlIHRoZSB0eXBlIG9mIGNv
bm5lY3Rpb24gZm9yDQo+ID4gYSBwb3J0IGxpa2UgdHdpc3RlZCBwYWlyLCBmaWJlciBldGMuDQo+
ID4NCj4gPiBBbHNvIGFkZGVkIGFuIEFQSSB0byBjb252ZXJ0IHRoZSBSVEVfRVRIX0xJTktfQ09O
TkVDVE9SX1hYWCB0byBhDQo+ID4gcmVhZGFibGUgc3RyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTml0aGluIERhYmlscHVyYW0gPG5kYWJpbHB1cmFtQG1hcnZlbGwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KPiA+IC0t
LQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyogKipBZGRlZCBldGhkZXYgQVBJIHRvIGdldCBsaW5r
IGNvbm5lY3Rvci4qKg0KPiA+ICsNCj4gPiArICAqIEFkZGVkIEFQSSB0byByZXBvcnQgdHlwZSBv
ZiBsaW5rIGNvbm5lY3Rpb24gZm9yIGEgcG9ydC4NCj4gPiArICAgIFRoZSBmb2xsb3dpbmcgY29u
bmVjdG9ycyBhcmUgZW51bWVyYXRlZDoNCj4gPiArDQo+ID4gKyAgICogTk9ORQ0KPiA+ICsgICAq
IFRQDQo+ID4gKyAgICogRklCRVINCj4gPiArICAgKiBCTkMNCj4gPiArICAgKiBEQUMNCj4gPiAr
ICAgKiBYRkksIFNGSQ0KPiA+ICsgICAqIE1JSSwgU0dNSUksIFFTR01JSQ0KPiA+ICsgICAqIEFV
SSwgWExBVUksIEdBVUksIEFVSSwgQ0FVSSwgTEFVSQ0KPiA+ICsgICAqIFNGUCwgU0ZQX1BMVVMs
IFNGUDI4LCBTRlBfREQNCj4gPiArICAgKiBRU0ZQLCBRU0ZQX1BMVVMsIFFTRlAyOCwgUVNGUDU2
LCBRU0ZQX0REDQo+ID4gKyAgICogT1RIRVINCj4gDQo+IFBsZWFzZSB1c2UgdGhlIHN0cmluZyBu
YW1lcywgbm90IHRoZSBlbnVtIG5hbWUsIGhlcmUuDQo+IEUuZy4gVHdpc3RlZCBQYWlyIGluc3Rl
YWQgb2YgVFAsIGFuZCBTRlArIGluc3RlYWQgb2YgU0ZQX1BMVVMuDQo+IA0KPiA+ICsNCj4gPiAr
ICAgIEJ5IGRlZmF1bHQsIGl0IHJlcG9ydHMgYGBSVEVfRVRIX0xJTktfQ09OTkVDVE9SX05PTkVg
YA0KPiA+ICsgICAgdW5sZXNzIGRyaXZlciBzcGVjaWZpZXMgaXQuDQo+ID4gKw0KPiA+ICAqICoq
QWRkZWQgc3BlZWQgODAwRy4qKg0KPiA+DQo+ID4gICAgQWRkZWQgRXRoZXJuZXQgbGluayBzcGVl
ZCBmb3IgODAwIEdiL3MgYXMgaXQgaXMgd2VsbCBzdGFuZGFyZGl6ZWQNCj4gPiBpbiBJRUVFLCBA
QCAtMTI0LDYgKzE0NCw5IEBAIEFCSSBDaGFuZ2VzDQo+ID4gICogZWFsOiBUaGUgc3RydWN0dXJl
IGBgcnRlX21wX21zZ2BgIGFsaWdubWVudCBoYXMgYmVlbiB1cGRhdGVkIHRvIDgNCj4gPiBieXRl
cyB0byBsaW1pdCB1bmFsaWduZWQNCj4gPiAgICBhY2Nlc3NlcyBpbiBtZXNzYWdlcyBwYXlsb2Fk
Lg0KPiA+DQo+ID4gKyogZXRoZGV2OiBBZGRlZCBgYGxpbmtfY29ubmVjdG9yYGAgZmllbGQgdG8g
YGBydGVfZXRoX2xpbmtgYA0KPiA+ICtzdHJ1Y3R1cmUNCj4gPiArICB0byByZXBvcnQgdHlwZSBv
ZiBsaW5rIGNvbm5lY3Rpb24gZm9yIGEgcG9ydC4NCj4gDQo+IGNvbm5lY3Rpb24gLT4gY29ubmVj
dG9yDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiAgLyoqDQo+ID4gICAqIEEgc3RydWN0dXJlIHVzZWQg
dG8gcmV0cmlldmUgbGluay1sZXZlbCBpbmZvcm1hdGlvbiBvZiBhbiBFdGhlcm5ldA0KPiA+IHBv
cnQuDQo+ID4gICAqLw0KPiA+IEBAIC0zNDMsNiArMzgyLDcgQEAgc3RydWN0IHJ0ZV9ldGhfbGlu
ayB7DQo+ID4gIAkJCXVpbnQxNl90IGxpbmtfZHVwbGV4ICA6IDE7ICAvKio8DQo+ID4gUlRFX0VU
SF9MSU5LX1tIQUxGL0ZVTExdX0RVUExFWCAqLw0KPiA+ICAJCQl1aW50MTZfdCBsaW5rX2F1dG9u
ZWcgOiAxOyAgLyoqPA0KPiA+IFJURV9FVEhfTElOS19bQVVUT05FRy9GSVhFRF0gKi8NCj4gPiAg
CQkJdWludDE2X3QgbGlua19zdGF0dXMgIDogMTsgIC8qKjwNCj4gPiBSVEVfRVRIX0xJTktfW0RP
V04vVVBdICovDQo+ID4gKwkJCXVpbnQxNl90IGxpbmtfY29ubmVjdG9yIDogNTsgIC8qKjwNCj4g
PiBSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1hYWCAqLw0KPiANCj4gUGxlYXNlIHVzZSA2IGJpdHMg
aW5zdGVhZCBvZiA1LCBzbyBpdCBpcyBtb3JlIGZ1dHVyZSBwcm9vZi4NCj4gV2l0aCB0aGUgY29u
bmVjdG9yIHR5cGVzIGFscmVhZHkgZGVmaW5lZCwgNSBiaXRzIG9ubHkgbGVhdmVzIHJvb20gZm9y
IHNpeCBtb3JlDQo+IGNvbm5lY3RvciB0eXBlcy4NCj4gDQo+IFJlbWVtYmVyIHRvIHVwZGF0ZSB0
aGUgdmFsdWUgb2YgUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9PVEhFUiBmcm9tIDMxIHRvDQo+IDYz
Lg0KPiANCj4gLU1vcnRlbg0KDQpBY2suIFNlbnQgbmV4dCB2ZXJzaW9uLg0K
