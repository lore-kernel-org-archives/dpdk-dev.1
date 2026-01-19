Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84373CA6005
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 08:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9B14025D;
	Mon, 19 Jan 2026 09:12:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9A5434025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 09:12:17 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60IMnPgY362766; Mon, 19 Jan 2026 00:12:16 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020119.outbound.protection.outlook.com [52.101.201.119])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4brv299jjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 00:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR8rsqAtkFdGP7bd+p1xqeLpY7xhMtjp6OvtAZrELByZsxI8U60Yq+tqeb766vpwgeUCUjdFu/od5vT0Ot7vlRVypD7hDtaLEcmF6PWnCfAZSUjfdvne2LrKVpUXVLZmZZ5psYqXsiTfp7BlJZgoGNYpgntNMFa8/pgcj63pslzwrS9WIxhloNoCF8XrOOi9Hxw+RDzGluAWzVLHCFe9D2VJI3hoPGltyKLezhsdXwpdW91XUGI5hlwsiGv8cOyxpTxMycDF/flAFYkaguveqi3GeTHaj2jhSBid7oJiVj+G33LU50GWvSh4Ht8juhGU6Wtvc9wQD751bfwVDJ+pXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/PiFZ68jFHL9A4ZO4xY93wa/S0rjnTo6eo2EQAkMm0=;
 b=p7JAbd+VYgG4C6vok8E1PQ1zv/VeQUUHdDLfyMeCz4J029vzdj9qSZTjpQjWwi/m8d9D7VwAgqgsSgrPPc5QONxeYCsxIucTmsvbuozcnBxJT9IkP+Ok1e8aP2KF0oB623qtiVqh6GXaIv6iaZJyuUumi1UFDHl8JKEZx4KfjT/XX+dIDPbVIKjhYMVZIw6p7KluZyhF/gH+uv3Rc9rXYG9JUaF9vlYN2Cp2/ItO+Y43rhU5WyUQTlqzl+jRWecM3uE77arRnTcvXSyXyfcJfIukln44QRaMXTwFBTn4w0dZMPDQGrfxoGL706c8DYdSBsAqvHiz4RfVPNmDIEf/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/PiFZ68jFHL9A4ZO4xY93wa/S0rjnTo6eo2EQAkMm0=;
 b=Vbm7jdzC7ANzM1eVyTGUbrCM30RQWxX3HkIopZVFBucPg6p0PC8VbeaBiCu+8cOvvpbLMZsiSb/QLNJkgQJyf0fDbRPcYU51sn0IJG5bR01iYrg3N/+Tv9pRASTGfQd1tK7zR6oZ7avqtCpyouCmKhWng8nhizLBzwR2wl6AU4M=
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c09) by DM4PR18MB4208.namprd18.prod.outlook.com
 (2603:10b6:5:393::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.8; Mon, 19 Jan
 2026 08:12:13 +0000
Received: from IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f]) by IA0PPF0A466555A.namprd18.prod.outlook.com
 ([fe80::b876:8173:5121:dc8f%6]) with mapi id 15.20.9542.001; Mon, 19 Jan 2026
 08:12:13 +0000
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Anoob Joseph <anoobj@marvell.com>, 
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
Thread-Topic: [EXTERNAL] [PATCH 2/2] test/crypto: add tests for 256-NxA4/5/6
 algorithms
Thread-Index: AQHcf8RbeG3YqjAbW0uZI0q8MQkGnrVZNGRA
Date: Mon, 19 Jan 2026 08:12:13 +0000
Message-ID: <IA0PPF0A466555AE76A8FC397BB4858EE62C988A@IA0PPF0A466555A.namprd18.prod.outlook.com>
References: <20260107105649.1708347-1-radu.nicolau@intel.com>
 <20260107105649.1708347-2-radu.nicolau@intel.com>
In-Reply-To: <20260107105649.1708347-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF0A466555A:EE_|DM4PR18MB4208:EE_
x-ms-office365-filtering-correlation-id: 4b3e1bb8-aab1-495a-3bd2-08de573273c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UmF4ZEVZTUxEcW5HL05YU2JWMVg4ZlZKYVY3RGl0aW5FejV3MEFOOUtTdjV4?=
 =?utf-8?B?d3lvaVkrK3V2RUs2My9IeXhDV1FNV1RoVWUwMFJkeHFQMkZlOGl5bHVFRU5n?=
 =?utf-8?B?ejNXaUdqTFlhd1VscG92NDJieVBLOEZsVlhKcEN4UWN3NUxISnVJYThaZGNS?=
 =?utf-8?B?TXlLeldJaXFCdDB4Wkk5bXJwQkZDUG1uU1laTzBQVURjSnZzUEh0NVJzckdl?=
 =?utf-8?B?YTFHUFRxVVZ1Sy9yVUJSalkyVHh4ZjVGL0hXWmVBbTZUd2NkNVlTdFM3NURF?=
 =?utf-8?B?ODdsTDFlTEE0c2IyR3hGZ1JYdk9lQWJOdy9tbTBqSGJyR0FHajM5cmlVd3RO?=
 =?utf-8?B?QjJsaVQwenRKeFJETk43eDcxREFkbFo5Y0NjTlcrdFBzTWxYc3d1SkFEZm1U?=
 =?utf-8?B?eUpFY2JqWnNVYjNQR0hNS3RueEkzdkR5MFYzUUJYYkdmc01QSW5mbGhwSlVX?=
 =?utf-8?B?c3piSmV6MEh4cHFUUnZhM2FTQjhEZ29tSU9sMGJpZTFTekVrL3F5WDlTTTBH?=
 =?utf-8?B?VHRFeGM0a3Bkdm56ZG9xZEhOS2dzOU0wemxxRXU0ai8zQ2VNakFvcDB3Ni9U?=
 =?utf-8?B?T0t6alNrdkVucG40bXpCZ05VblJ4SHlHcXNxYWw0TjNBc3lxREZFVmpOSy82?=
 =?utf-8?B?QlpTWjMrOTNRVDZKNlVXWlM1S2ViYnlaaHFUeGZld0ptVmFmc2lDUVdaSmRZ?=
 =?utf-8?B?SlpxU0NTSHJBUGZtMFR4OEVQZjVmTHdaSWdLdGMvWm1CRExCOGpSTWhsVjVX?=
 =?utf-8?B?UWMvNWJraHZFR3hIcGlkQ0JjQVM5UU4yZFlyeHBUU1REdCt5N3E0Q0toTnQ4?=
 =?utf-8?B?SDQyUnkyVGMwRFQwT1NRcGhGZklMc085QnIzdW9yQTZqZVVXTXpWdEpXNXNI?=
 =?utf-8?B?a3Fqb1l6NjB0eXVPNUhOVXBtNlplTnNnd1Q5bTlYNGtzYk9oUDNBcDFycUcw?=
 =?utf-8?B?ak9jSmhWYWJUY1pST1JaRy9UQjZ0bXB1Sk1xK3huQytvaFNsMjFoSk05d3dn?=
 =?utf-8?B?UURkUzB3U2xCNE11SGJTalgwUmpJek95TlVIempFdC9sU2YyWVdzQ2J0OTJD?=
 =?utf-8?B?Q3cvTStMRU1GN2JuVTZ3TFNRM2JlVS9XeXFRYkYyR1Z2WVdIVzVUT3ZlVy9s?=
 =?utf-8?B?ZS9SY0lWWFZZRXBjODNzSWcwVDBObVNYU3FZNFpIR1BPdy9lZTVENTBkdUtQ?=
 =?utf-8?B?dktRTEROc0xLOE5iTllZdkNCbVdvOTZLUEFZSmJ3TXZtNVJSMW4razhYM1F0?=
 =?utf-8?B?OHV2WDh3RlRNYlFZYW03elBaRC9VOW5TS0ovdG1JZmh3ZndUbnVKWWpmaUd4?=
 =?utf-8?B?dzYyMjFDelhPc1RGdi9zU2pFQWIwNGxocXFnUVZRekJhSHEzc0dMVHNaT282?=
 =?utf-8?B?U0Z2UW1OSFdOTDcwTVdXZXdIVk1ZbUlmREczeGcweXZ6RW1tbDhaVFMwaWYz?=
 =?utf-8?B?MWJna0E3VjYvRGxXd3BITThBRWxyZC9abXBvTklETHlmYVkrZG1zVEdLVnpQ?=
 =?utf-8?B?SzRXTHVBT2tqeTJhOVVlc2pTcFc5OGRBV3VFcm5RZUUvSThlQVpGNGpQNU9o?=
 =?utf-8?B?UnJvamkrUlBFQzZxMSs2cUpBd2RKTnNwMGRwbUd2eVRZOFRLMjlvZGROMWtU?=
 =?utf-8?B?dDlPWnZmMmpqL09zV3RGMmdSRlF1djJMemtDOXFndG5UTHdDM1lzNzh0b0Fh?=
 =?utf-8?B?VE9iVWMwa0JFNGMwajV3aHNZLzdFMWlmSEprNWl6SmJtUytyNFVLb0JwMGw5?=
 =?utf-8?B?VzJUK1UzVmdyN2F6MU5CL0F1WWg5SytJUWFiQmFMSE1sYlNjYWtmRVJnbmJr?=
 =?utf-8?B?K21COE4ybEx3SlEzUFZmV2FFa2MzWi9DVktKK3E2a2lxaVRrRzRyNzh2Njlo?=
 =?utf-8?B?eUpyK25XZVp6V2E2a3BOMEhVVTRvSWc2N1VkTFBZcGV3cGJTWTdVYk5nTmxo?=
 =?utf-8?B?TWNnQll5VXpBVnRPbnRseVNGajR6amhPMkM4ejZWaWxremduZCsvSDFWSktS?=
 =?utf-8?B?MkxtdHV0eG16OEN5OXo1ZlQ0VUdzV0N6b1pCQXRSYmhIS0k1Ukg2WFBDcEN4?=
 =?utf-8?B?U1FSQmh4MEt5VjdOMWgvY1FaMHdiWUpkcmVKSkNmM2s3QlJ1STNtc25hNFNo?=
 =?utf-8?B?RFZtMG05bW9DVEFYU1R3UEJRc1QrU1lsbjhLdGJnYzhaRlFnbFR6NlNkVkhk?=
 =?utf-8?Q?kLOfZtHMXXgVKHS7uCcMOIc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF0A466555A.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVNCRzZvNC9Sa1AxNjZTSndhSjNxYmY3dnFkTVZvZk5QZjZyRWFHYkQ0cXBQ?=
 =?utf-8?B?d1o0ckxtVGd4d0ZBalUvSGxmaUh5a1lyYnFwdDduTFcrVmNzbUVUSEMyK2V6?=
 =?utf-8?B?WGQ3alF6T0szOEhqbmtHekwrcFZuZGVPVFp5Q3ZxN0RoR2xLYW1DRmIzN2la?=
 =?utf-8?B?RlQwVXhQb2ZsR1NVVnJsbE96TTd5c0VBNWdjWkxRN0MrSkdSbzRmM0xKNGhK?=
 =?utf-8?B?NnV5cVlCWFlBQmoyTjdtL0pyNzVCYnI4cDlabFRha1hURnEzQ2p1Um1ydktC?=
 =?utf-8?B?SVNWTURrR2ROUjltcHdoeEJrSEkrTlY1ZXRkY0xkSVhBSGMzV3BBMDdvamJZ?=
 =?utf-8?B?SGpSSnVsd1lVTUUwSk42NHNwSC9EdWNMS3huRVFNeHBHVE1Na1k0MzV0Kyty?=
 =?utf-8?B?OHRveEYrYXJRN1ppV3dWU3VXdXV2SzhCYk5zMGphTXhBb1YrNDNqMUUwb1lI?=
 =?utf-8?B?VjAwem81ZHNQb1JRWDUySXZnTHpBd091RExQSnQ1TmhGWG5WeEJBWisrdlgv?=
 =?utf-8?B?QWxPOFAzc29QQXN3M3VKVGhxQy9hN1M5VlppZTNBbVRjR0RFMTZMUEdPVjcz?=
 =?utf-8?B?SkpYU1hPano1NGdoWHBjeVduNkhtQVBKUVJPOEx3WWZFZ25tVVBQTVJHTkEv?=
 =?utf-8?B?WnN1Vm5xRFpia2V0NzNmVE0renVEazBYRjVvb0UvNXdVNmtDWnRDOCt3STdn?=
 =?utf-8?B?ZWxOYmhFeGRzTk0weVhISm1QTjE2RUU2cm83a3o4Rmx5ZldIT2c5Wkw5Tzdj?=
 =?utf-8?B?b3pZWVp5blAyK2lDZDlrZ0ozVEdwZnR2amdybkVsbUNtRlBIMU1vdnFpZEVP?=
 =?utf-8?B?Q3hnckhsdHBpcFY4eEFBU0IxRW5uVXpyaDZMdUpPL3Y4WGdNTmR3Qll2K0tm?=
 =?utf-8?B?Rk1ZZ2hDb1NSdzdqRUM0REtSL3lJWnFSMjlqOFFrdkNMTjZHMktkT3dWMkk5?=
 =?utf-8?B?REVlUHJOMWNZYmpTeVhaakJsRzBMVW1NZVhFenFRNWV0cENvTXZzM3lLZ2xq?=
 =?utf-8?B?ak1hWjhEbmVOQWF5ODhrSDJPcFcvOTErQ21Nc0QrUzVQTEpPcFFmQytuMUYr?=
 =?utf-8?B?WUtKUTc1NkxSV1lIR1ZJREZmdWorT1hEOTNGRjBuSFVVbXhPZU1rd0l1TWd5?=
 =?utf-8?B?bUlLSFhNVkVJVDY1d3ZTelBWZHcrZFlTTzBic2FzbE1nUjZ0STRUeWsxaG5S?=
 =?utf-8?B?VnU1K2t5SS8xYjBBOEJiQXBXbXVBT3dBclNKOVY3ZEtRQlBGSW5SM044NzR0?=
 =?utf-8?B?K0RYMWZzYUtRN04yNSt5NTY0and3NHNvSTZwYU9XTjlXcnVKd0dyelE1TTZo?=
 =?utf-8?B?dEU2UjFuay9QdVQvUzYvTno3THEvZDlGVzVQWXFYNE95ZXVCVFU2VTVCSkg4?=
 =?utf-8?B?TlptV1J2RFIzb0grUXJXekJMNnFmUlhJcHc1VnE3NFA0QWp3NWwxbW9GRE92?=
 =?utf-8?B?RkdrcCtOa3UyWUR0Y1FQaVhhNTRudWt1TUFRWDAyWnFIWWJZUEIrekFrUm5h?=
 =?utf-8?B?dHAvbEtvczVmNnU5Z2g0VlRFU251L1FMT3k0b096bjFkK2dRdFVDV05Cc0s1?=
 =?utf-8?B?cDQ0eWhvSGk4Y29PTUd6d29iM0ZFQnpabTdqdWVGTnRNbGlMbG9RZGEzc2dx?=
 =?utf-8?B?WCtDZE5FMHY3aUUwRmFKbi91c2xlMmVkUlQwT0V6aWYwa2hjaHFlZWVRcCsy?=
 =?utf-8?B?eDhwRUtvaG9tb2xBOEpBbzIxV1VhcWU3MmlyQ3E1VTR2b25wTEZsTStGYlFG?=
 =?utf-8?B?UDFqMHBuNXpXK1ZMR2dJbldZUmt4S2lzVGt0bFdiVUZXc0h5WTc0eDNHYzZC?=
 =?utf-8?B?dDQvS0Zxb2VwNm9HM2JkMCtNY09rNGZtTDVEaGUrQlBiWFlRNWRraHdHQmdw?=
 =?utf-8?B?VytqbGJOZWFmMHBNQXhocmhtYmJrNGp1aHJycnprbHZHaEtJWVBSV2srWnY3?=
 =?utf-8?B?Q0IrYU1PanZJRFZRZHVobVlGYlNpbXI2bVg5aTNCT1RGLzJMd2NsTVl5azRw?=
 =?utf-8?B?U2U2cmJxVHhpQVVpSzZXUjYzd21DTGVKK2V0OThqSXhxUHZ6d3hZUEFHYlha?=
 =?utf-8?B?cUJKUGk0cFdXdUFlZy8wSm1CY01NOHVGY1JIakFhQkZtbC8zckVpelJ1c2hM?=
 =?utf-8?B?dmY2M2k5Q2VxRzU4UzBET0xPa1hFNHBhcTdqUW5JUGZpZGJoYzNDT3ZJeUly?=
 =?utf-8?B?KzVnUytsY2Y0ajNVVXJNT3hwSUJhVGFYMFljdkNUWkZxTHBhOC9iZ3NQeVhC?=
 =?utf-8?B?MXZNeXhFelVmcjVwbkREWGNqNEFZSXkxd2lHcUdkKzdZTC9RcGszUGNrNm5u?=
 =?utf-8?B?NHRUQ2Z3SDBGQ0xrZm5iOVFKKzF0a1pIRWExMlV0WUpDNXMxYWpUUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF0A466555A.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3e1bb8-aab1-495a-3bd2-08de573273c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 08:12:13.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+YHzVIBa67j78PcS4STKyDhVg1fCWbuucuFgR21YhvBNjTA2t5Jgv9KT0w8Vfaq1f6qXqlrSEwSccGYFZ21zC7fSZ1l8CF6QZ6bXLDM0hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4208
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2NiBTYWx0ZWRfX3bchXNNUeBhN
 rTZFIiUVSdGA/Lhy/Kk/4BeviWFEM1BF99jJxLkcXi8wifmJpv9ZBvOF9jgphSxXKAKDg3+Bj+J
 XENh+WuyYNbf9dKROQ33iPKQT9mLbYP7IoZRzt8G+SXQW6Agvh5H4eHUgYMT7nwQOhh1iC9Q64Q
 IEACFBpOv/jqK0p+MHkqRkiaHLaJVtbXuyTlHdz5yvmIZxZcCUbGGaONy5jQPz3/DRQeNZlRAWg
 RBF6NTsXLWZ8CDzcXsJzmQh5xM8aFs84UJCRTjl04ovHqhztSyQbaEy0nVgrRRwrlR/PVehv3Ow
 1k65qArbezloHKRIN75cB96YgZGeQiLOqVA0GUmsFNoYjon8esqtz0ns2BSUsVckNcmBMz/MY2x
 qtjHTaIicqTPdO3LwFJN3Qk0xhCC5MxVPzI4LCIwvV89xmEIC/OwLEiPfNy+T1ngAUY+KAPEbuv
 tWNHZ+RRwwuP8FhCWFA==
X-Authority-Analysis: v=2.4 cv=d9n4CBjE c=1 sm=1 tr=0 ts=696de760 cx=c_pps
 a=j7k210cWVAfXhyiYu0S74w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=y9BmsuEFTBYbIY6GczAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mEbU0mpvGAPPHKJ-KSpWFx17uoXo_p89
X-Proofpoint-GUID: mEbU0mpvGAPPHKJ-KSpWFx17uoXo_p89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
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

SGkgUmFkdSwNCg0KUGxlYXNlIHNlZSBteSBjb21tZW50cyBpbmxpbmUuDQoNClJlZ2FyZHMsDQpO
aXRoaW4gU2VuDQoNCj4gK3N0YXRpYyBpbnQNCj4gK3Rlc3RfTkVBX2hlbHBlcigNCj4gKwlzdHJ1
Y3QgbnhhXzI1Nl90ZXN0X2RhdGEgKnRkYXRhLA0KPiArCWVudW0gcnRlX2NyeXB0b19jaXBoZXJf
b3BlcmF0aW9uIG9wKQ0KPiArew0KPiArCXN0cnVjdCBjcnlwdG9fdGVzdHN1aXRlX3BhcmFtcyAq
dHNfcGFyYW1zID0gJnRlc3RzdWl0ZV9wYXJhbXM7DQo+ICsJc3RydWN0IGNyeXB0b191bml0dGVz
dF9wYXJhbXMgKnV0X3BhcmFtcyA9ICZ1bml0dGVzdF9wYXJhbXM7DQo+ICsNCj4gKwlpbnQgcmV0
dmFsOw0KPiArCXVpbnQ4X3QgKmlucHV0LCAqb3V0cHV0Ow0KPiArCXVpbnQzMl90IHBhZF9sZW47
DQo+ICsJdWludDMyX3QgbGVuOw0KPiArCWJvb2wgaXNfZW5jID0gKG9wID09IFJURV9DUllQVE9f
Q0lQSEVSX09QX0VOQ1JZUFQpOw0KPiArDQo+ICsJaWYgKGdibF9hY3Rpb25fdHlwZSA9PSBSVEVf
U0VDVVJJVFlfQUNUSU9OX1RZUEVfQ1BVX0NSWVBUTykNCj4gKwkJcmV0dXJuIFRFU1RfU0tJUFBF
RDsNCj4gKw0KPiArCS8qIENyZWF0ZSBzZXNzaW9uICovDQo+ICsJcmV0dmFsID0gY3JlYXRlX3dp
cmVsZXNzX2FsZ29fY2lwaGVyX3Nlc3Npb24odHNfcGFyYW1zLQ0KPiA+dmFsaWRfZGV2c1swXSwN
Cj4gKwkJCQkJUlRFX0NSWVBUT19DSVBIRVJfT1BfRU5DUllQVCwNCj4gKwkJCQkJdGRhdGEtPmNp
cGhlcl9hbGdvLCB0ZGF0YS0+a2V5LCAzMiwNCj4gMTYpOw0KPiArCWlmIChyZXR2YWwgPCAwKQ0K
DQpbTml0aGluc2VuXSBDb3VsZCB0aGlzIGJlIHJldHZhbCAhPSAwLCBzaW5jZSB0aGUgVEVTVF9T
S0lQUEVEIG1hY3JvIHZhbHVlIGlzIHBvc2l0aXZlID8NCg0KPiArCQlyZXR1cm4gcmV0dmFsOw0K
PiArDQo+ICsJdXRfcGFyYW1zLT5pYnVmID0gcnRlX3BrdG1idWZfYWxsb2ModHNfcGFyYW1zLT5t
YnVmX3Bvb2wpOw0KPiArDQoNCg0KPiArc3RhdGljIGludA0KPiArdGVzdF9OSUFfaGVscGVyKHN0
cnVjdCBueGFfMjU2X3Rlc3RfZGF0YSAqdGRhdGEpDQo+ICt7DQo+ICsJc3RydWN0IGNyeXB0b190
ZXN0c3VpdGVfcGFyYW1zICp0c19wYXJhbXMgPSAmdGVzdHN1aXRlX3BhcmFtczsNCj4gKwlzdHJ1
Y3QgY3J5cHRvX3VuaXR0ZXN0X3BhcmFtcyAqdXRfcGFyYW1zID0gJnVuaXR0ZXN0X3BhcmFtczsN
Cj4gKw0KPiArCWludCByZXR2YWw7DQo+ICsJdWludDMyX3QgcGxhaW50ZXh0X3BhZF9sZW47DQo+
ICsJdWludDMyX3QgcGxhaW50ZXh0X2xlbjsNCj4gKwl1aW50OF90ICpwbGFpbnRleHQ7DQo+ICsN
Cj4gKwlpZiAoZ2JsX2FjdGlvbl90eXBlID09IFJURV9TRUNVUklUWV9BQ1RJT05fVFlQRV9DUFVf
Q1JZUFRPKQ0KPiArCQlyZXR1cm4gVEVTVF9TS0lQUEVEOw0KPiArDQo+ICsJLyogQ3JlYXRlIGF1
dGggc2Vzc2lvbiAqLw0KPiArCXJldHZhbCA9IGNyZWF0ZV93aXJlbGVzc19hbGdvX2hhc2hfc2Vz
c2lvbih0c19wYXJhbXMtDQo+ID52YWxpZF9kZXZzWzBdLA0KPiArCQkJCXRkYXRhLT5rZXksIDMy
LA0KPiArCQkJCTE2LCB0ZGF0YS0+dGFnX3NpemUgPj4gMywNCj4gKwkJCQlSVEVfQ1JZUFRPX0FV
VEhfT1BfVkVSSUZZLA0KPiArCQkJCXRkYXRhLT5hdXRoX2FsZ28pOw0KPiArCWlmIChyZXR2YWwg
PCAwKQ0KDQpbTml0aGluc2VuXSBDb3VsZCB0aGlzIGJlIHJldHZhbCAhPSAwLCBzaW5jZSB0aGUg
VEVTVF9TS0lQUEVEIG1hY3JvIHZhbHVlIGlzIHBvc2l0aXZlID8NCg0KPiArCQlyZXR1cm4gcmV0
dmFsOw0KPiArCS8qIGFsbG9jIG1idWYgYW5kIHNldCBwYXlsb2FkICovDQo+ICsJdXRfcGFyYW1z
LT5pYnVmID0gcnRlX3BrdG1idWZfYWxsb2ModHNfcGFyYW1zLT5tYnVmX3Bvb2wpOw0KPiArDQo+
ICsJbWVtc2V0KHJ0ZV9wa3RtYnVmX210b2QodXRfcGFyYW1zLT5pYnVmLCB1aW50OF90ICopLCAw
LA0KPiArCXJ0ZV9wa3RtYnVmX3RhaWxyb29tKHV0X3BhcmFtcy0+aWJ1ZikpOw0KPiArDQo+ICsJ
cGxhaW50ZXh0X2xlbiA9IGNlaWxfYnl0ZV9sZW5ndGgodGRhdGEtPm1zZ19zaXplKTsNCj4gKwkv
KiBBcHBlbmQgZGF0YSB3aGljaCBpcyBwYWRkZWQgdG8gYSBtdWx0aXBsZSAqLw0KPiArCS8qIG9m
IHRoZSBhbGdvcml0aG1zIGJsb2NrIHNpemUgKi8NCj4gKwlwbGFpbnRleHRfcGFkX2xlbiA9IFJU
RV9BTElHTl9DRUlMKHBsYWludGV4dF9sZW4sIDgpOw0KPiArCXBsYWludGV4dCA9ICh1aW50OF90
ICopcnRlX3BrdG1idWZfYXBwZW5kKHV0X3BhcmFtcy0+aWJ1ZiwNCj4gKwkJCQlwbGFpbnRleHRf
cGFkX2xlbik7DQo+ICsJbWVtY3B5KHBsYWludGV4dCwgdGRhdGEtPnBsYWludGV4dCwgcGxhaW50
ZXh0X2xlbik7DQo+ICsNCj4gKwkvKiBDcmVhdGUgYXV0aCBvcGVyYXRpb24gKi8NCj4gKwlyZXR2
YWwgPSBjcmVhdGVfd2lyZWxlc3NfYWxnb19oYXNoX29wZXJhdGlvbih0ZGF0YS0+dGFnLA0KPiAr
CQkJdGRhdGEtPnRhZ19zaXplID4+IDMsDQo+ICsJCQl0ZGF0YS0+aXYsIDE2LA0KPiArCQkJcGxh
aW50ZXh0X3BhZF9sZW4sDQo+ICsJCQlSVEVfQ1JZUFRPX0FVVEhfT1BfVkVSSUZZLA0KPiArCQkJ
dGRhdGEtPm1zZ19zaXplID4+IDMsDQoNCltOaXRoaW5zZW5dIElzbid0IHRoaXMgYXBpIGV4cGVj
dGluZyBsZW5ndGggaW4gYml0cyA/IEFzIGluIG90aGVyIHBkY3AgY2FzZXMuDQoNCj4gKwkJCTAp
Ow0KPiArCWlmIChyZXR2YWwgPCAwKQ0KPiArCQlyZXR1cm4gcmV0dmFsOw0KPiArDQo+ICsJaWYg
KGdsb2JhbF9hcGlfdGVzdF90eXBlID09IENSWVBUT0RFVl9SQVdfQVBJX1RFU1QpIHsNCj4gKwkJ
cmV0dmFsID0gcHJvY2Vzc19zeW1fcmF3X2RwX29wKHRzX3BhcmFtcy0+dmFsaWRfZGV2c1swXSwN
Cj4gMCwgdXRfcGFyYW1zLT5vcCwgMCwgMSwgMSwNCj4gKwkJCQkJICAgICAgIDApOw0KPiArCQlp
ZiAocmV0dmFsICE9IFRFU1RfU1VDQ0VTUykNCj4gKwkJCXJldHVybiByZXR2YWw7DQo+ICsJfSBl
bHNlDQo+ICsJCXV0X3BhcmFtcy0+b3AgPSBwcm9jZXNzX2NyeXB0b19yZXF1ZXN0KHRzX3BhcmFt
cy0NCj4gPnZhbGlkX2RldnNbMF0sDQo+ICsJCQkJdXRfcGFyYW1zLT5vcCk7DQo+ICsJVEVTVF9B
U1NFUlRfTk9UX05VTEwodXRfcGFyYW1zLT5vcCwgIkNyeXB0byByZXF1ZXN0IGZhaWxlZCIpOw0K
PiArCXV0X3BhcmFtcy0+b2J1ZiA9IHV0X3BhcmFtcy0+b3AtPnN5bS0+bV9zcmM7DQo+ICsJdXRf
cGFyYW1zLT5kaWdlc3QgPSBydGVfcGt0bWJ1Zl9tdG9kX29mZnNldCh1dF9wYXJhbXMtPm9idWYs
DQo+ICsJCQkJCQkgICAgdWludDhfdCAqLA0KPiArCQkJCQkJICAgIHBsYWludGV4dF9wYWRfbGVu
KTsNCj4gKw0KPiArCS8qIFZhbGlkYXRlIG9idWYgKi8NCj4gKwlpZiAodXRfcGFyYW1zLT5vcC0+
c3RhdHVzID09IFJURV9DUllQVE9fT1BfU1RBVFVTX1NVQ0NFU1MpDQo+ICsJCXJldHVybiAwOw0K
PiArCWVsc2UNCj4gKwkJcmV0dXJuIC0xOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cg0KDQo=
