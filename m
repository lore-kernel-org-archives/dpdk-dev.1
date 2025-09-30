Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226ACCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 20:03:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7FED40151;
	Tue, 30 Sep 2025 22:03:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5BCEE400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 22:03:11 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UGNUB6024470;
 Tue, 30 Sep 2025 13:03:10 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020074.outbound.protection.outlook.com [52.101.201.74])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efeffsfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 13:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGTFUFmEK2zTtowFrxopQfMXP6Ff+KGlKj80JQKwOKnn+nl1NbPtNAcC1Q5BzMTKIYssb50PhefmqSHk8p8hFgnndHFrK9hQnOn+CBv+NN/4GajizZY1B2LLQmA6KYckILK29vhJWKKvH7YDlmA3bpJOR1IDue2SosXiL881hMTrlv+RRfplnzSecCmlVh9QkxqkXv/GwHfaL+f9ovv297vZuxrWnTduecfCLfd1XpllUk1DApbQXC3Jc4EJ98gT4MyquUozwybw4NzbWlnu5Fv2qTXiHFLgmTltxPYic1MA6eqRDIO1OAlDxbnu6e1KEc0KO6g4+2YUxzm/HmXwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsfMaR70qToWGdJ09X0x7FNJNxqQbCOVg1h+vT0FaJA=;
 b=dZasQgucfVPd0LTeT/LAAfqSjRsTDCp3QzKnc/GQ+aF/W63uQKhxas6I8UurfvD4be/ytTJBwdzhh0H5pAR8KBPE7SAD4VSXFtLTSLNlMhigHjQq44eUlWl28guIklo8MklotbW2oHBd4tv8t5FpcvY4wiy78+8S+Qz4stlrMGh4B8t6EFkjBD8oa+9yiO+J1bTI+GEvvRwdtIvoUNYbr7sEEZIwuQ2t9+4Fzi/mI+TAwn51pe2jpP9o77LbU4ZuCx8DvAF4ujLfcFH0x/ULZqLoPz7KxTebUNDsyWYC02Mwo3qULYp9FtpIzjnx4LdNbbxYwTlIchnWZjJOr6P1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsfMaR70qToWGdJ09X0x7FNJNxqQbCOVg1h+vT0FaJA=;
 b=kd0FJSQiemMxWMDd9Kefp/6TIlwyO6KJDGdgAT1mWD+i1jmVIVr3n6DUnLSedh2FF7InUdhuK7jZHv2rr6gqH7Lpkju+mUoDhjFSpXDyNVDBblbVZXbSH9Zl8I8YCIBLL+MUxkC4PyhzAr1EtIshEJR9U6mYJUOK2suGhd8zeO0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH4PR18MB6210.namprd18.prod.outlook.com (2603:10b6:610:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 20:03:06 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:03:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Index: AQHcLW8JfD0SxlFEYU+4aNhxCrmYZ7SsJZ6g
Date: Tue, 30 Sep 2025 20:03:06 +0000
Message-ID: <CO6PR18MB4484EEAC621E731A4E5E64C8D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
In-Reply-To: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH4PR18MB6210:EE_
x-ms-office365-filtering-correlation-id: b576988c-d081-4525-32bc-08de005c5ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Uy9Ick44emFkNVRxZkQ1MC85U0VGaUo2MXNMSHpmM1RTOHUvOEhKdU9vK01o?=
 =?utf-8?B?VTZSR01SL082aDlPQ1FwZXVLaUl2b0E1UFkrb1NRRmZxSzh1QVhxVnJqNG5o?=
 =?utf-8?B?WnoyS0JJWCtNSHI1Qy9oSmM1RGdTUjBvYkVVNk94WVJRd1NHeDEwaFBGT0NW?=
 =?utf-8?B?MzVhbWowdkhFemkwMXVoZ1k0UFRiVE5aTCtGZzBjcXVuN3BmLy8rU3RUWGRo?=
 =?utf-8?B?UnczbmVYM1FjdE16SjdrRjRUajg3MFZRZ2xGMHp3VzI3R3VXNDlJVWg2dmY3?=
 =?utf-8?B?dVA5TFgrQ2FUWlFURktxeVFwNFgwOG95SlozK0tpQVRXV1FyQ2drMStiYkZp?=
 =?utf-8?B?TkNIdVc0YktuNGl3cStGcG5jTWdNb2R6UmhxV3RHUEtqNXludU56a00wdVJZ?=
 =?utf-8?B?b3A0Tk8xeEtzaDB2RXJWTndBdzI3dFhjVVVZaXJibUo2OVJDckh2YlV0SEgx?=
 =?utf-8?B?VERGRUZPeExTRWEvU3lhUFE3bWR0V2FxWGVNUXBJSHUzb1RQVGIxV0Vqa0JF?=
 =?utf-8?B?NEpiVHBMY2dkMGd3OCtoNzEweHJ1Vk1pd1dWUHJLK0pZRVJJL2dobkJ3ekdu?=
 =?utf-8?B?cy90UGVuRVNnWFRuYVZPbkdBK0pxVThKYm5DN284b1dtaXZldEtCZzBKblNm?=
 =?utf-8?B?OHdidmpocmphK0l6RngxV21EazUxRnNSQUsrZkg2RFhFK0txSUNteE1oK2hz?=
 =?utf-8?B?ZWxTYlFzS3lXR1RUZFk2cXgzVWorbmJHRGV0Vmw4V3dRQnlISzh5bVZ4bEJB?=
 =?utf-8?B?NEhzOWdWR3ZrTXQ3REtDdTlac1hLSGd2UHNWeDJGbUdWMHd4WUFlT3RzZnV6?=
 =?utf-8?B?STZ1OUdXaGphYnVyVUJ6ZWV3VFhYTWlyWVJzOGpYczNIdFEvdisxbzBzS2pZ?=
 =?utf-8?B?RVN5UER1TFRRdUN5S3ZQM1o0RWFBMnBLMUI3dWFxMjhPcWdvV3FYT2QyM2xx?=
 =?utf-8?B?eGl2L1hWemQxb1lYRWVEbENKN0Y2SURPTzlvVGNNTWsyaVprTm1YSmFHY21G?=
 =?utf-8?B?YUhqdTNZd0wxcWhrR1JjMVV0SkQ4UXhsaE9pa1pjNit6Qk9kWTdVRkZheTlH?=
 =?utf-8?B?SHZuZWxxVVVtWGtOV1RCZWRkM1k1SnNDUTZYdzdXRzBIQjZhejk3WmtJYUxj?=
 =?utf-8?B?d0wvYnpYVGxCb3hlc2VadzNxY21mWkZDWkFDbXZBWW5IdW11SVFBc2p2TFJm?=
 =?utf-8?B?M01JR1EvTXF2ang4eVhEeWlaWWo5TitFUmpSL0dOSUxCaGxKL3NvcWFlcHJa?=
 =?utf-8?B?WXJSMG1BS3JudHJ1d29mUmxLZXBTYkc3emVQVGtyYVNQSFdJaEJZZE9Kb0ZW?=
 =?utf-8?B?TG9ublBlQlkrU1BTZmtLemc5d2ZUVnJYczQzT0JhdXZuemtpbTVscms0VjR1?=
 =?utf-8?B?cVRIUWlLbFA2K2hQNVZjaGF0S0xOZWlMQkFIcnBjelBTVHltWFl3RjFnalFJ?=
 =?utf-8?B?NVkwTk1rN0VkaDNYY2Mwd29hYzdobFlxSTJGbStXLzErd2dnUFYrOXFEbmpw?=
 =?utf-8?B?bDBwZ0ZNNUlUMEV3OHltQ2NEOVNEM3JlMnV2WGR5eXFpQWtnNzNWdEtOY0VG?=
 =?utf-8?B?dS9CMGlxQlNCbHhNakhRT25wSllGQ3EvcVhFakpvcWhiYUtnVGc3MlRnZEFO?=
 =?utf-8?B?dDY3d3pZaFZNVTFnR1FWY3hzU05JRk5JZHZZZlUyWDlidTQzOWJLTXlCVjJH?=
 =?utf-8?B?eWJsc1Q4OXhZc2FWeENKYVpZeFVodWNIZkNwOHZsV0RWS3RyUzBuaS9LWlNT?=
 =?utf-8?B?M2dMZ1hHMWR4Z0RhMzFQZUFzTXBTU0c3REJaSDRvM0hwNlMwOHRuTEhzRjMz?=
 =?utf-8?B?VjJSbUJUZ1JkbmZaZi84bjA2aXVOSEJ6MVp6RHhYcGpadU5rZ3pkeWkyUzlP?=
 =?utf-8?B?VTUzbzNueVNaRzdiM3VEVXBOU3UzbU03T3YxSFBsSGZDOGpFY244akpwT2Nx?=
 =?utf-8?B?cC9ZWEZmR2EzelNNd01lWFdIR2FmZTI5b25rOTl0WS9Fd3VSNnA1MjRJN2Ez?=
 =?utf-8?B?bGdOQnp4cWdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXIvMVVmWlYxNnFRUTVTVWk0S1hWV3BSZmJtVHdML0FLZFpwNzNTbVEzcERH?=
 =?utf-8?B?WVhFVCtYWjd3d2VCM2dRcVJ3Skdsdys3ajFTOXRyZHZOVms1MVRNNUkyMkJn?=
 =?utf-8?B?YzNubEFjcTRYb09OY0tnS2xMUWpIc2FWQ213MXpvVU9RcGxEUW0wUW9lL3RO?=
 =?utf-8?B?cyt0QWJmWjU2Tzk3TnZ3cGlQdkNtd2dCdllCbnVrUUVGV3J6cVhMUmZkaGpU?=
 =?utf-8?B?QkhER09RSXQwVGVmVngwRmM4RU9uOVpXTVcraXRndnFmMDRnMXI5WW40K1hL?=
 =?utf-8?B?cTVLRXJBeDdVdEpwdE1wQTE4L0RaUWozcXlYc0JZWHJpbnJIQ2N1TEJ2Uml4?=
 =?utf-8?B?bDBVem1xWUtpb3Rzc1l1OXlxVm9SMnpsYzJ0VmdKY0had0VSOUxuZDFnRFJp?=
 =?utf-8?B?YlpQVUhBQkwxVGFXRDg0Mm5CWTR4TWFXTjVuMmM4T3BNSGJNSjBaeHR2dUcv?=
 =?utf-8?B?ekxhWFNxNCtya096TVVUNlhaVGNMN3k2eHV6djJ1TzFwREZBaEpGd0dtYytY?=
 =?utf-8?B?M1MzbUlmTnBmY05Rc0QvcmhBSmFlVHlGOGtmdTRQTWw2c0FYSGNXVlNkNisw?=
 =?utf-8?B?Uy9mY0VtMURpYW5GR0tLUDkvYnpJQjllZTVybjZUc04zSGlPczN2VTV0dmx1?=
 =?utf-8?B?dlBoU1BlZmw2Vk12ZmlPSVlnSGZoQks5V1ZOODZlUmVPVDVUVU5zSTU3Nk9P?=
 =?utf-8?B?bDcvaWNMUDZyQng0dFV4cytmM0lzTUZGbi90dTlmeHBDRmZFSVdoVXp6eFhR?=
 =?utf-8?B?cVg0Qm9YVit3MU1YVzVhbVNPVWU2cXN1RC8ydTNSTDIrTFZnbGZlSnpxU3Fy?=
 =?utf-8?B?dXVWb2VOYmRkek83ZjFSaU1Gb1NhVWdqb2NpNzIzNmdlcCtmU1h6N3BLdUwy?=
 =?utf-8?B?NUtnZlp1SExqUjdYU2JIWktHbXlwckpxL0R6b2I5S2RIeUU5NVY2LzZtRnc2?=
 =?utf-8?B?UHpSMUl4ZExLQmxTZWZYdGEwS3F6VndhUUtxWXB2YW0xMHJBMEY3bm1QcExC?=
 =?utf-8?B?N0VjT3M0R0IwTWptMUdOSlNaR01KdlZtbVhpVEdoSTJzajJndG1xczZQWHVU?=
 =?utf-8?B?ZHBaVm5TUGR6RUs3aUMweXE4bk1KMURCbGxtLzNDV2U1SDVYTlh4d2NtdTZi?=
 =?utf-8?B?TUx5cXRScHd2TkNQM3VoMXA1L1pROTZPYnJPR0wybTBDVGlxK0xHOEFSK1N0?=
 =?utf-8?B?dSt6Ty9zTEUzUTJQSEtiSHFNeEdSMDEzSHN6ZlY1c0ZURE00QWk5Q083YTdY?=
 =?utf-8?B?NHNOZ3lqYUI0TEdyeVRpUkZLMHZ4T1YybXZMbTd3T24yS25iajg5ZUVNLzd3?=
 =?utf-8?B?ZVJ4cUhGeWM3MTQ1c24zdWNiSjE0aTFHNG93dmwrcjFaSGY1WUhmaWlrQkgx?=
 =?utf-8?B?dEpiWlJRUk9DelMxWkdTR2piTmsvTnBRYnJOZW1vemhIZ2RlYzNIMXRtNTNs?=
 =?utf-8?B?WU9GUmZZejJDR0NzREd0Mkc2Q2RvMU9sWE81cGtzOUVGK2hxUGdKZkRkeHJ4?=
 =?utf-8?B?VmJsODloRWpSOGo5NHhScnltTURzZCtWbWpRamlsWVZhSExFOGR5RG9GN293?=
 =?utf-8?B?L2ZjSjlYY1JIV040SkFTZ1ljWE8zdUFwTFFOVVVmRXhWOGFZSjJJZ1IzVUJh?=
 =?utf-8?B?a3FEOGdCQmd0Mm1mVHJUMExGZWdqOXNqYUZMODBTTmRpV3hMbzU4S2NJRDZ2?=
 =?utf-8?B?K1JwK1lGM1MveWE4U0ErTzdubWlLSWx6WTlWOVE2dWYrd3lQaEhpclY4dWV0?=
 =?utf-8?B?UDRuOEhCOVV0Q202SGs0ZjdON1Q3TzNJZGlkSzVIV2JwS2NCSVBXZ3ZROGg3?=
 =?utf-8?B?OHFncm9QaG5ORTBGcXhSMUcyNGx3SmgyNVhzcmQrNUprMnF0dGpHVGt3SEdu?=
 =?utf-8?B?VUUyNk5RWThqOEQ4RkVJSVlJK01SaTJsa2MxZTN2bFJxMDdQQTNkSS83Z1pv?=
 =?utf-8?B?L0tOMFRhUjBCbTBRWkwwNDN4LzZjRC9weTFxRVB6bUR2MDAzWTUwWGQrUWk5?=
 =?utf-8?B?UUM4RXhCSjc4RStxSFFGZUNOM0R4emZDZ1dlSTRrWm5OcGdDMEFLRmhCYWw4?=
 =?utf-8?B?YWNQaWNwUUZOWnFvd1BtOE5kQ0l3NDFxd2M3UGxtYVdzNllBd21lRUFYZ2F3?=
 =?utf-8?Q?1UBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b576988c-d081-4525-32bc-08de005c5ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 20:03:06.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gtrq9QIRCuTW2la16/7s3yWTcPdMYLLAo7ZQCDBVx/AYlHQigHttPy6ULwoDRDA56A7we/6txHlHOtwhY0KO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6210
X-Proofpoint-GUID: rI0m8FG69Pyt3bvrvz2k2csv614M10CK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfXxmZPD6gmioYk
 bwtGz2M42LDLVtpHB7namcfHHQeVxZ22T7Vu+r3o5L1Ct9ZQgJestin8+lLfRwSxYNkECn+zOvX
 5XJ3eWZF+GdTc3/TY5RnwlctHaZFTmlPSmvPWDWN+k1iApUI5oa5wjFHbz1xLHb1ePDYMC8F6QP
 AxuWMQWseu3LJSFG+50FVw2XobTngwL2vu+qfdiUi8PYrqTklQYrjVIOTFCjXxPziphnDnwO46T
 jfz6NX0/XJXbd97kT7IbGATpGyGPlqdJ1U3nT1HZQxsOdIOaN3F7bhcZYKP+g5kb7y4Zxu9qeoD
 6AskrBiDOVWznH9QJFdZyrm8udzUTo5pIjKYLIlQoUlC4lFRpxVXBOX7EhuHUXkGIupb9mYkvIt
 Jqew7KHHSKMuiSNYbMepJ1Qjv9djLA==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dc377e cx=c_pps
 a=9mF5moCRh3baUhQ7ZsOuTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=EUspDBNiAAAA:8 a=dwDKAd5FWdfznJKc8KEA:9
 a=QEXdDO2ut3YA:10 a=k13SdgfryrkA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: rI0m8FG69Pyt3bvrvz2k2csv614M10CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
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

SGkgU2FtZWVyLA0KPiBBZGRzIGRlZmluaXRpb25zIGZvciBQRENQIGNoZWNrc3VtcyBhbmQgYXBp
cyB0byBwYXNzIGluDQo+IGRpY3Rpb25hcmllcw0KSSB0aGluayB5b3UgbmVlZCB0byBkZWZpbmUg
bmV3IGFsZ28gVURDIGFzIHdlbGwuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhbWVlciBWYXpl
IDxzdmF6ZUBxdGkucXVhbGNvbW0uY29tPg0KDQpQbGVhc2UgdXBkYXRlIHZlcnNpb24gaW4gdGhl
IHBhdGNoIHRpdGxlIHdoaWxlIHNlbmRpbmcgdGhlIG5ldyB2ZXJzaW9uLg0KSXQgdG9vayBtZSBh
IGxvdCBvZiB0aW1lIHRvIGZpZ3VyZSBvdXQgd2hpY2ggdmVyc2lvbiBJIHNob3VsZCByZXZpZXcg
YW5kIHJlcGx5IHRvLg0KSSBjYW4gc2VlIHRoZXJlIGFyZSAxMHMgb2Ygc2VyaWVzIHNwYW1tZWQg
d2l0aG91dCB1cGRhdGluZyB0aGUgdmVyc2lvbi4NClBsZWFzZSB0YWtlIGNhcmUgb2YgdGhpcyB3
aGlsZSBzZW5kaW5nIHRoZSBuZXh0IHZlcnNpb24uDQpBbHNvIGFkZCBpbi1yZXBseS10byB0YWcg
b2YgcHJldmlvdXMgdmVyc2lvbiB3aGlsZSBzZW5kaW5nIG5leHQgdmVyc2lvbi4NClBsZWFzZSBj
aGVjayBodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvY29udHJpYnV0aW5nL3BhdGNoZXMuaHRt
bCNzZW5kaW5nLXBhdGNoZXMNCmh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRlcy9jb250cmlidXRp
bmcvcGF0Y2hlcy5odG1sI3RoZS1yZXZpZXctcHJvY2Vzcw0KDQo+IC0tLQ0KQW5kIHlvdSBzaG91
bGQgYWxzbyBzcGVjaWZ5IGNoYW5nZSBsb2cgaGVyZSBhZnRlciAtLS0NCg0KPiAgbGliL2NvbXBy
ZXNzZGV2L3J0ZV9jb21wLmggfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xp
Yi9jb21wcmVzc2Rldi9ydGVfY29tcC5oIGIvbGliL2NvbXByZXNzZGV2L3J0ZV9jb21wLmgNCj4g
aW5kZXggOTZkOWIyNzZkZC4uMTY5ZDNkOTYwZSAxMDA2NDQNCj4gLS0tIGEvbGliL2NvbXByZXNz
ZGV2L3J0ZV9jb21wLmgNCj4gKysrIGIvbGliL2NvbXByZXNzZGV2L3J0ZV9jb21wLmgNCj4gQEAg
LTEwMSw2ICsxMDEsMTAgQEAgZW51bSBydGVfY29tcF9vcF9zdGF0dXMgew0KPiAgCSAqIGlzIG5v
dCBhbiBlcnJvciBjYXNlLiBPdXRwdXQgZGF0YSB1cCB0byBvcC5wcm9kdWNlZCBjYW4gYmUgdXNl
ZCBhbmQNCj4gIAkgKiBuZXh0IG9wIGluIHRoZSBzdHJlYW0gc2hvdWxkIGNvbnRpbnVlIG9uIGZy
b20gb3AuY29uc3VtZWQrMS4NCj4gIAkgKi8NCj4gKwlSVEVfQ09NUF9PUF9TVEFUVVNfQ0hFQ0tf
U1VNX1ZBTElEQVRJT05fRkFJTEVELA0KPiArCS8qKjwgQ2hlY2tzdW0gdmFsaWRhdGlvbiBmYWls
ZWQuIEVpdGhlciBjYWxjdWxhdGVkIGRvZXMgY2hlY2tzdW0gbm90DQo+IG1hdGNoDQo+ICsJICog
dGhlIG9uZSBwcm92aWRlZCBvciB0aGVyZSB3YXMgYW4gZXJyb3IgY2FsY3VsYXRpbmcgdGhlIGNo
ZWNrc3VtDQo+ICsJICovDQo+ICB9Ow0KPiANCj4gIC8qKiBDb21wcmVzc2lvbiBBbGdvcml0aG1z
ICovDQo+IEBAIC0xNjYsNiArMTcwLDEwIEBAIGVudW0gcnRlX2NvbXBfY2hlY2tzdW1fdHlwZSB7
DQo+ICAJLyoqPCBHZW5lcmF0ZXMgYSB4eEhhc2gtMzIgY2hlY2tzdW0sIGFzIHVzZWQgYnkgTFo0
Lg0KPiAgCSAqIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRw
cy0NCj4gM0FfX2dpdGh1Yi5jb21fQ3lhbjQ5NzNfeHhIYXNoX2Jsb2JfZGV2X2RvY194eGhhc2gt
DQo+IDVGc3BlYy5tZCZkPUR3SURBZyZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1Ebkw3U2ky
d2xfUFJ3cFo5VFcNCj4gZXkzZXU2OGdCem43RGtQd3VxaGQ2V055byZtPVlMV2ZmU0h1X0hlRWk2
M1pUcE1JUzd1Q3NiVEdsdTFnWkREZQ0KPiBQeHY4bkw3djNKQXZJZEtjTnJyVXEzQlI1WTIyJnM9
YjViQ0xyUGJVamp4eTFJdHhmWVFPVW9IQW5EanFqVndWZmg2aWwNCj4gVERDSXcmZT0NCj4gIAkg
Ki8NCj4gKwlSVEVfQ09NUF9DSEVDS1NVTV8zR1BQX1BEQ1BfVURDLA0KPiArCS8qKjwgR2VuZXJh
dGVzIGNoZWNrc3VtIGFzIGRlZmluZWQgdW5kZXIgVXBsaW5rIERhdGEgQ29tcHJlc3Npb24NCj4g
KwkgKiBjaGVja3N1bSBhcyBkZWZpbmVkIGluIHRoZSAzR1BQIFBEQ1Agc3BlY2lmaWNhdGlvbg0K
PiArCSAqLw0KPiAgfTsNCj4gDQo+ICAvKiogQ29tcHJlc3Npb24gSHVmZm1hbiBUeXBlIC0gdXNl
ZCBieSBERUZMQVRFIGFsZ29yaXRobSAqLw0KPiBAQCAtMjAxLDYgKzIwOSwxMSBAQCBlbnVtIHJ0
ZV9jb21wX2ZsdXNoX2ZsYWcgew0KPiAgCSAqLw0KPiAgfTsNCj4gDQo+ICsjZGVmaW5lCURFRkxB
VEVfTUFYX1dJTkRPV19TSVpFCSgxVUxMIDw8IDE1KQ0KV3JvbmcgbmFtZXNwYWNlIHVzZWQuDQpB
cmUgdGhlc2UgcmVhbGx5IHJlcXVpcmVkIHRvIGJlIGRlZmluZWQgaGVyZS4NCkkgZG8gc2VlIGFu
eSBjb21tZW50cyB3aGVyZSB0aGVzZSBtYWNyb3Mgd2lsbCBiZSB1c2VkIGFuZCB3aGF0IGlzIHRo
ZSB1c2UgY2FzZS4NCg0KPiArDQpSZW1vdmUgZXh0cmEgbGluZSBoZXJlDQoNCj4gKyNkZWZpbmUJ
REVGTEFURV9NSU5fV0lORE9XX1NJWkUJCSgxVUxMIDw8IDgpDQo+ICsNClJlbW92ZSBleHRyYSBs
aW5lIGhlcmUNCj4gKw0KPiAgLyoqIENvbXByZXNzaW9uIHRyYW5zZm9ybSB0eXBlcyAqLw0KPiAg
ZW51bSBydGVfY29tcF94Zm9ybV90eXBlIHsNCj4gIAlSVEVfQ09NUF9DT01QUkVTUywNCj4gQEAg
LTMwNSw2ICszMTgsMTUgQEAgc3RydWN0IHJ0ZV9jb21wX2NvbXByZXNzX3hmb3JtIHsNCj4gIAkv
Kio8IEhhc2ggYWxnb3JpdGhtIHRvIGJlIHVzZWQgd2l0aCBjb21wcmVzcyBvcGVyYXRpb24uIEhh
c2ggaXMgYWx3YXlzDQo+ICAJICogZG9uZSBvbiBwbGFpbnRleHQuDQo+ICAJICovDQo+ICsJdWlu
dDhfdCAqZGljdGlvbmFyeTsNCj4gKwkvKio8DQo+ICsJICogUG9pbnRlciB0byBtZW1vcnkgY29u
dGFpbmluZyBkaWN0aW9uYXJ5IHRvIGJlIHVzZWQgZm9yIGluZmxhdGUNCj4gKwkgKiBhbmQgZGVm
bGF0ZSBvcGVyYXRpb25zDQo+ICsJICovDQo+ICsJdWludDE2X3QgZGljdGlvbmFyeV9sZW47DQo+
ICsJLyoqPA0KPiArCSAqIExlbmd0aCBvZiBkaWN0aW9uYXJ5IHRvIGJlIHVzZWQNCj4gKwkgKi8N
Cg0KRG9u4oCZdCB5b3UgbmVlZCB0byBkZWZpbmUgVURDIGluIHJ0ZV9jb21wX2FsZ29yaXRobT8N
CkFuZCBtb3ZlIHRoZXNlIGFsZ29yaXRobSBzcGVjaWZpYyBmaWVsZHMgaW50byBhIHNlcGFyYXRl
IHN0cnVjdCBhbmQgYWRkIHRoYXQgaW50byB0aGUgdW5pb24gZGVmaW5lZCBhYm92ZSBpbiB0aGlz
IHN0cnVjdD8NClNlZW1zIHBhdGNoIGlzIGluY29tcGxldGUuDQoNClRoZXJlIGlzIG5vIHVwZGF0
ZSB0byBkb2N1bWVudGF0aW9uIGFzIHdlbGwuDQpkb2MvZ3VpZGVzL3Byb2dfZ3VpZGUvY29tcHJl
c3NkZXYucnN0DQpkb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy9mZWF0dXJlcy9kZWZhdWx0LmluaQ0K
DQo+ICB9Ow0KPiANCj4gIC8qKg0KPiBAQCAtMzI4LDYgKzM1MCwxNSBAQCBzdHJ1Y3QgcnRlX2Nv
bXBfZGVjb21wcmVzc194Zm9ybSB7DQo+ICAJLyoqPCBIYXNoIGFsZ29yaXRobSB0byBiZSB1c2Vk
IHdpdGggZGVjb21wcmVzcyBvcGVyYXRpb24uIEhhc2ggaXMNCj4gYWx3YXlzDQo+ICAJICogZG9u
ZSBvbiBwbGFpbnRleHQuDQo+ICAJICovDQo+ICsJdWludDhfdCAqZGljdGlvbmFyeTsNCj4gKwkv
Kio8DQo+ICsJICogUG9pbnRlciB0byBtZW1vcnkgY29udGFpbmluZyBkaWN0aW9uYXJ5IHRvIGJl
IHVzZWQgZm9yIGluZmxhdGUNCj4gKwkgKiBhbmQgZGVmbGF0ZSBvcGVyYXRpb25zDQo+ICsJICov
DQpQbGVhc2UgbWFrZSB0aGlzIGluIGEgc2luZ2xlIGxpbmUgaWYgaXQgaXMgdW5kZXIgMTAwIGNo
YXJhY3RlcnMuDQoNCj4gKwl1aW50MTZfdCBkaWN0aW9uYXJ5X2xlbjsNCj4gKwkvKio8DQo+ICsJ
ICogTGVuZ3RoIG9mIGRpY3Rpb25hcnkgdG8gYmUgdXNlZA0KPiArCSAqLw0KTWFrZSB0aGlzIGFs
c28gaW4gYSBzaW5nbGUgbGluZSBpbnN0ZWFkIG9mIDMgbGluZXMgYXMgYmVpbmcgZm9sbG93ZWQg
Zm9yIG90aGVyIGZpZWxkcy4NCg0KDQo+ICB9Ow0KPiANCj4gIC8qKg0KPiAtLQ0KPiAyLjMxLjEN
Cg0K
