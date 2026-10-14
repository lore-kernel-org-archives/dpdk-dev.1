Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC8CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 14:05:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC84B4042E;
	Wed, 14 Oct 2026 16:05:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7EE3740272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:05:33 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EDYnAT3146609; Wed, 14 Oct 2026 07:05:27 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023081.outbound.protection.outlook.com
 [40.93.196.81])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h9r79nbf9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 07:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCn88eJlFz3Y8gfowos7+WPkYRK6dMe3iYHMzns4oOL47wec+/LXzSPTbyth2HBb7Q56i7jv7RG11COYRbHecWM9H/oev2JKj8PQv5NFCFquoGqboDco/1QIF6V2jOXf182UnZLxRH472lkpSEeGcy8W7G+eQC31v6xw5U1Nsz6jWwaGLXjL3PHvFgLhZmcbFkJpFqJYbYX4f/6vZaQGHdwnkRTzeK6Gh3EDZ5/dTvkYSMpjPGjPA53QkzuCpndPG1zw460nVAOXflaiNDhWq2lHsEAkmr3ANhMP97ghFdTakj8wG6vvCibzUQmPLLlaUpXXXkYy4SdZhpNMWS6X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiVTinU6kD5x0Iyyr1ibdhIAC8TOOLNKdv2NEo9yuoc=;
 b=mO7SmA2cT21pAK8rwHZrsQOXOf7DBkmSFM2xwYHzOU+SCSI4EBfTtqIh6TZ2zJsal1Sl9QmH5dPQ2drQDTjcKBB4IhdxOVMFpdK6/KjuyRq6K6HCOQC22H6zXTG39pwLgZ3g+SLu+hC2n0NJFLpzitd4aneCp/blsFm0b9hiEPa3d9N1bWyFBNnZQmpPc6AinIQGKJp/3CHCGX/QC/cdeb3oU/vNGN2IbLS4wpp0igYCIG/UWYGHv7yEdV33hNlME37PCCbMowUd/ancIn07TT2w+Mcc9L9TviqwhqfZPcRR+SROTs9eRlLz4kVuI0XyuqGk3G5zJSPhSXd7Dtf/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiVTinU6kD5x0Iyyr1ibdhIAC8TOOLNKdv2NEo9yuoc=;
 b=aB9Sd2X+ZInDMhLssFLug9w5WDa4ODdAHBn+3I7lrUCWc9t/4F7NawWx3mF3gSaftojaLHYw5hvYhKMGcDHdGWf9P1JHEU46m5Shk3sNhB6JE0VC0yDXP8V4bVS70AGwkwa5LZeN+nSjOO3yv+HEysL+4dHwC4ewOsn/2ufcUUc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA5PR18MB988776.namprd18.prod.outlook.com (2603:10b6:208:603::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:05:24 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 14:05:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Luca Vizzarro
 <luca.vizzarro@arm.com>, Thomas Monjalon <thomas@monjalon.net>, Jack
 Bond-Preston <jack.bond-preston@foss.arm.com>
CC: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] crypto/ipsec_mb: require minimum
 version 2.0 for IPsec MB
Thread-Topic: [EXTERNAL] Re: [PATCH v2] crypto/ipsec_mb: require minimum
 version 2.0 for IPsec MB
Thread-Index: AQHdLkDmJuObjuz+fUWawj6a2klmnbbd0B2AgB5r54CAAOaigIAALI6AgAAH0wCAABXzEA==
Date: Wed, 14 Oct 2026 14:05:21 +0000
Message-ID: <CO6PR18MB4484814C114038D6DC458539D89D2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
 <9a235219-aa8c-4372-8a61-d2ca9d731604@intel.com>
 <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
 <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
In-Reply-To: <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA5PR18MB988776:EE_
x-ms-office365-filtering-correlation-id: 8a3ed96b-8581-4673-25bc-08df29fc2fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: NPRYNxi7dmBHB6BmlAWVlYWh+hul3CkUmUkgW2DBBAv5RtuG0eDSG2DOu+O94fnHrQn0StlIaBJ7OfqsMOuSav2bfodRLszlH+ELuBTuCNBCCL028DJqOnSJ8KioQTZHQBH8eAK3zk4DPJK5tns+eBdiRo4jH8LTtG0u+YshuRlQujSRQKx8abmvCqLfFQRKvjGZiukV6i+nQYg92MkKHqa/tYTgGj7ILrcgAUGtHiL7HCk68oiIc8hA2CI5vNSPtwnxvVKHuQkXtQll2lwBstyQAZLviRDLEqu6OvAvZYQbPZFndXHz6upd3+zJV7gdwwNpEHoPtXcsfIngmv8T5rW9Yhf3MPut+7N/txdIgJasuLmk7no7uEgmumwHWQsPE9JFcLAkfzIXh2CAlLU84u1VYbwRh+qpj7Nt+SXB8KogVcLEuNEx+uubs8GrVcC9XHSXOtBX0JK899OEshhoB29jmnyMHbSvVY8dWx4l9GoovXuhpx04LHZdhpcMfWuVgeiky5aPoQtALFbzLrwpp30bBvN9sGWt8yn+lN7ZMky/irrY7o1w+nzHQAJT8VDfW5+u2WaCuBCq+YEqmh/u/nn7cwrWdL1dtn6vbBDvm2EwpqKY/snumNgpkV9gce77n1wtUDzAjfDT43s3T3gfW7Lk5sNfh2bviesVHda4lQUim398JyJOK7HOwK5VMyxag9iBnUP1IIdU+2idndvThDc83IWqennLuVbs7/UMsjM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGVFUnpLNlRyZm1VT1pvanpUVEVjd0RCaDZNU0ExeEJoWUV5NFVsS3Q5SGcr?=
 =?utf-8?B?S3crOThMS0wwakpGd3NPL1V3UjhNS1BzbVc2SWE2SGk5bXZ0THVsRC9pZWdM?=
 =?utf-8?B?ZWthYTZkamJiM2lnZWhjVUdIRld0L1ZKeVJlaFE3SXFBSFhONXhuUnhNUDc0?=
 =?utf-8?B?OW1PVTE1YVlnazBvRUVDUGR4ZHU1UE0yeGhJajBMdXJWbVN4ZVRaRW9idXE2?=
 =?utf-8?B?OVhhL3ZOUHJvS1pabHc0aEY1MHFmb2c0eGtNRHh5NVVEdEh4QVVPOEJOWlIw?=
 =?utf-8?B?MzNUYWI0dVBIazVZcnc2aVpWcnNpb0pBV0ZET0JTVTBoWEdyQ0tHeGJqS3c4?=
 =?utf-8?B?QkVhcmpIVTNvS2pzUFdNb1NXUXpRMUxOODYycEtLWjhkZW1lODRHcUg2M0ZF?=
 =?utf-8?B?WXZMTGNxQzdzWGJJWHl2b0U4WDhWUVg1TDZQaGFHQ2MrejZXaHorZVJraHQy?=
 =?utf-8?B?SkRNbzBxRWVyL2RQbHlvclRqRnVqZ0puc01iNmtRMFFVbTlySmVXRUgySlpS?=
 =?utf-8?B?bTc0eHdlNzVYOWJWbXd5VmptNHhsU1hqV3FnWjN0MVVRc09IWVFNcngrT0lF?=
 =?utf-8?B?OHY2QmpocmhrVlNONkx1dCtXTGN6TGF2VTFrNTBreFllckhiWXRrNXJNdjg1?=
 =?utf-8?B?V3p6M3lDK2FyQlBLQUVuV2QxdGNjWkpiSnhaNzNBN2tIZmJKd2tIdVV2a0Jj?=
 =?utf-8?B?VWVBaXEyM2c0NExWNUdySTgraWN1ZGxpR2FSN1BQUWRLVmlsak16dGxqdjMz?=
 =?utf-8?B?cjlCS1dVZGVsN3owak14a3ZMOGxiZWRXV0pibW1RakkzZWY2SWhWWEZqOFU0?=
 =?utf-8?B?UlFJZ2lTa09MV1l0ZTg3ZFpyL1VscmF1MEl6K0l6THhpVy9CM0F4RitsSk53?=
 =?utf-8?B?SUZzSS8yZEdKMHBrNTBiRHZCRUg4b1JCUG1qSnZneVZFSWlINUdtY242Tk5Y?=
 =?utf-8?B?eDRqdEpuOWlsQXAxVW9vWDdybEhOeXg3YWhOc0tCQjNhRWxnK09hQmdKeTZT?=
 =?utf-8?B?L2taRGk1N012RzBkRHVQbXhaWmtjR2xTT2hPVDIyODVwNW5EdWxHcHBCb29l?=
 =?utf-8?B?cW5pakVPc1lFbUlraUc4UVVyYkV5K1dpSkFjazBMNWlZMXZ1eEtwMjk4czVk?=
 =?utf-8?B?K3JwUVc4dnhmQU5lOFVUVHY4WnUzSytNbW1mcFg4LzE3b3pVSldFVE9KVzh5?=
 =?utf-8?B?aE5EN0NjNEc3dzBYc3hSbGcrVk83UWV3Rzdoby9aT25MbU13TlhNYzBtb1FZ?=
 =?utf-8?B?SUhuSEFzU1JOb25CSm5lajZzcjdDZmtDMXprU1V6SVllMkFha3llQzJqeGxL?=
 =?utf-8?B?OGxERUVpOFFnOWRTM3NhUGpnb3NUVmFnUVJRZ0tvd2xhSEVpZGo2SEN2NVIr?=
 =?utf-8?B?UEhva3BIOGlyRklMeFozQmNVWFBKSGZGQ0E0Y1Y2WkhPN2lCNEpsSTBqRUNo?=
 =?utf-8?B?b1ZvQjR5RzNwNEwyWmg3aC8xdUZ6aHhRaEtEdzQwNTU4UUMwa2hEdEgvelM0?=
 =?utf-8?B?cGYweENQRUczNFFhNVcvL3pTcXVYYXphaEI3SGdFc0x6NUJDRURBcDFRRHJ5?=
 =?utf-8?B?VnYvcGk2eXZvS2JKcFdncEpONjlMbEVvZ2I3anFYWmo0Y0hITFF5WllqOFM4?=
 =?utf-8?B?YS9iNDc2VmVUUStDRldsVzY5WVFuWTloaldwN1BtZ3JGcG5ibzI5K0VNQmdm?=
 =?utf-8?B?YXdoSjhzNFpmQTg5Tm8xMGl5S0N4MDFCeVhzVnlPL1lFblhOek9OOHM2akJC?=
 =?utf-8?B?eld4djN4YnRNUWRrekhVNzZmcFBsdkczMXpyT2tzanBGeFJ4TkJLb0FIQ0tU?=
 =?utf-8?B?REdwd1lzVFVJVjVBMGRiNUNRdjlxc1k2bVdBNjFnMDJNQW15Sld2MS9oeC9E?=
 =?utf-8?B?eTRHN1hqWGJUUitIKzJaWDhBTzBoNkRZVnpEbGxkWHNzZ3BpTE9qekNZTWtw?=
 =?utf-8?B?WC9rN0ova0Mvb0xZbWFuSFNvclZwWHBnSDNmV0ZVNnQ1NzhJWERDbmJlWmw5?=
 =?utf-8?B?YnNtejNaYlNmN2NYTVBVV1JoeHNJWkh4bDJEWWtYdDY2SVBMRmQwSjhDdHZx?=
 =?utf-8?B?Vng2dzRZY0d0cHhQK2tOSUFUY0oxa0hrTTRKRXZNd0ZBUFhOTjU5YUYxKzI5?=
 =?utf-8?B?OENyVWY5K25lVzlmaHVBSlh3YTN6UU5vZ256aG55ODVyTS9Od0srUzE0YjJY?=
 =?utf-8?B?K2xoOTRuL2dLTmVEV3pvcmhseGlEY0YzWnRnRXZvZWhVMkV3Z2dSTVBGQjlZ?=
 =?utf-8?B?T0Y5a1QwRkVBZVJPZEVCZlNUU08xeVUrU040Z3B5UkR6NXpralVwc3Y5b0FY?=
 =?utf-8?Q?FiZL8BagwaaxnP54Bn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f7Tf4ZUT5VluJcAlU3JM3J8BnrjLVf5MuwIMnmUJPn5ZTpF6K8Cb3uHEl81mFBpdLdSdOeXMQbFQQCwKP4YUc34Dd6QIB6L1GLQYED+PBVrRP3JU5Yn6mDzQcL7zAmQJ5+DJuusxj7VkjNigtKbzru5e+EvR8kPh48cI3UqWFT5bZl8AjKikBdBOSat+GxP6RkkawPJGEy6VW495FEyzAG5H9yW4xupxPldKwFrh8+UkPPKHJENiWOy9FUKhfgstEMuugBv7sKsWWiWkXs3lTydYkxU9AkLleYgJ93yAiJTcIDo7+7rRHQC8CkEh1PyK9w4Hh2r8hatRzN1FWBLvSQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3ed96b-8581-4673-25bc-08df29fc2fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 14:05:21.8435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jC4Ruv5KghKIkJF5j1ecFIqgw+LZtOJQZaXn39PbdDxJiFBz89AJOg+Uy4wQSuAjDYmCRikx0gqFm3Fn4HhH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR18MB988776
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfXyPSqqAp5ox1g
 0leltByRASdkf5qJpfgNq0jcyAWRPx6dH5DvTaazRoHu4OEPHO/igiSFM57gK1grWSLFB24/kwb
 k/nxh71S0lS/wZkzuS9b3uqOQ6inukE=
X-Authority-Analysis: v=2.4 cv=LY6peTfi c=1 sm=1 tr=0 ts=6acf8c27 cx=c_pps
 a=EI6zmuMIMY+nXR31EdRrtw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=ujXjNfSw3qKX9a4B_MkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y3rJF4vhHUcQq6yRYh_rg2XrEoC8H-rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX8TNyYrAx/h7Z
 UFwoHgeUeAgciOY+X2ZxLw4Ivvm+rZrfOBUIaFFf7iEENICkflKbcWqM0HFgHpHAQAkWDv1uu6u
 eT0oefD9V/yfVvcbfzQZmQu7F43E+eZOEh3ub6LDOIVUALgAkI+V2NL88fbLzqpB83VOo+7gaEj
 vUThbt15zrllNjyqlCP3MYw5pUOOBX+BDb3hLK5GBBaiXFQcqzrwp+H1lYUMSa3AejkI4cszrvH
 nooeP7Kkb2vb1PHjQSCRu6nOzSPO63x2Cdj8fjcqNV1sVJYC46Q3QToBBQlKC1G+skLd1tW29Vp
 qDKv1UJB+C4BqK6jaRSSWhsQWvpa3kjVluT4caegQvKzN0pJxS78Rs8fY3TZqLA9+i/SubnZoNL
 85DBKFXc3OirJnd5Gaxd7hvdsP4ZWWn+5aoyQ4/JNICtlR5g8HB5uYB6XurNGIRmYznWYQSQzni
 erOgy0tf1emWqaOyp+w==
X-Proofpoint-GUID: Y3rJF4vhHUcQq6yRYh_rg2XrEoC8H-rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
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

PiANCj4gT24gMTQtT2N0LTI2IDE6MTYgUE0sIFRob21hcyBNb25qYWxvbiB3cm90ZToNCj4gPiAx
NC8xMC8yMDI2IDExOjM3LCBSYWR1IE5pY29sYXU6DQo+ID4+IE9uIDEzLU9jdC0yNiA4OjUxIFBN
LCBUaG9tYXMgTW9uamFsb24gd3JvdGU6DQo+ID4+PiAyNC8wOS8yMDI2IDEzOjE4LCBBa2hpbCBH
b3lhbDoNCj4gPj4+Pj4gRnJvbTogTmljb2xhdSwgUmFkdSA8cmFkdS5uaWNvbGF1QGludGVsLmNv
bT4NCj4gPj4+Pj4+IEluY3JlYXNlIHRoZSBtaW5pbXVtIHJlcXVpcmVkIElQc2VjIE1CIGxpYnJh
cnkgdmVyc2lvbiB0byAyLjAgQXMgYQ0KPiA+Pj4+Pj4gY29uc2VxdWVuY2UsIGNsZWFuIHVwIHRo
ZSBhZXNuaV9tYiBQTUQgY29kZS4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBS
YWR1IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQo+ID4+Pj4+IEFja2VkLWJ5OiBQ
YWJsbyBkZSBMYXJhIDxwYWJsby5kZS5sYXJhLmd1YXJjaEBpbnRlbC5jb20+DQo+ID4+Pj4gQXBw
bGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQo+ID4+PiBBcyB1c3VhbCB3aXRoIEludGVsIElQc2Vj
IE1CLCBpdCB0cmlnZ2VycyBhIGNvbXBpbGF0aW9uIGZhaWx1cmUgb24gQXJtOg0KPiA+Pj4NCj4g
Pj4+IGRyaXZlcnMvY3J5cHRvL2lwc2VjX21iL3BtZF9hZXNuaV9tYi5jOjI0OjMyOg0KPiA+Pj4g
ZXJyb3I6ICdJTUJfQ0lQSEVSX1NNNF9HQ00nIHVuZGVjbGFyZWQNCj4gPj4+DQo+ID4+PiBJIGhh
dmUgdG8gZHJvcCB0aGlzIGNvbW1pdCB3aGlsZSBwdWxsaW5nIG5leHQtY3J5cHRvIGluIG1haW4u
DQo+ID4+Pg0KPiA+Pj4gUGxlYXNlIGZpbmQgYSBzb2x1dGlvbi4NCj4gPj4+IEknbSBzdGlsbCBh
ZHZvY2F0aW5nIHRvIG1lcmdlIHRoZSBBcm0gZm9yay4NCj4gPj4gSGkgVGhvbWFzLCB0aGUgcm9v
dCBjYXVzZSBvZiB0aGUgYnVpbGQgZmFpbHVyZSBvbiBBcm0gaXMgdGhlaXIgbGlicmFyeQ0KPiA+
PiBmb3JrIHdoaWNoIGxhZ3MgYmVoaW5kLCBiZWluZyBhdCAxLjUgcmVsZWFzZSB3aGljaCBpcyBh
dCB0aGlzIHBvaW50DQo+ID4+IGFsbW9zdCAzIHllYXJzIG9sZC4NCj4gPj4NCj4gPj4gVGhlIG9u
bHkgc29sdXRpb24gaW4gdGhpcyByZWxlYXNlIGN5Y2xlIGlzIHRvIGRyb3AgdGhpcyBwYXRjaCBh
bmQgcmViYXNlDQo+ID4+IHRoZSBvbmVzIGFkZGluZyBzdXBwb3J0IGZvciAzLjAuDQo+ID4+DQo+
ID4+IENvbnNpZGVyaW5nIEFybSBsYWNrIG9mIHN1cHBvcnQgYW5kIGNvbnRyaWJ1dGlvbnMgZm9y
IHRoZXNlIFBNRCBvdmVyIHRoZQ0KPiA+PiBsYXN0IGNvdXBsZSBvZiB5ZWFycywgdGhlIG9ubHkg
bG9uZyB0ZXJtIHNvbHV0aW9uIEkgc2VlIHRvIGF2b2lkIFBNRA0KPiA+PiBjb2RlIGxpdHRlcmVk
IHdpdGggaWZkZWZzIGFuZCBzdXBwb3J0aW5nIHZlcnkgb2xkIHJlbGVhc2VzIG9mIHRoZQ0KPiA+
PiBsaWJyYXJ5IGlzIHRvIGRyb3AgdGhlIEFybSB2ZXJzaW9uIGFsdG9nZXRoZXIuDQo+ID4gTm8u
DQo+ID4gVGhlIG9ubHkgc29sdXRpb24gaXMgdG8gd29yayB3aXRoIEFybS4NCj4gDQo+IEluZGVl
ZCB0aGF0IHdvdWxkIGJlIHRoZSBpZGVhbCBzb2x1dGlvbi4NCj4gDQo+IElmIGFueW9uZSBAQXJt
IGlzIHN0aWxsIHdhdGNoaW5nIHRoaXMgc3BhY2UsIHBsZWFzZSBjaGlwIGluLg0KKytBcm0gZm9s
a3MuDQo=
