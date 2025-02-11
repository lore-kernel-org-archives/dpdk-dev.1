Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E9C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 14:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B93E9402C9;
	Tue, 11 Feb 2025 15:46:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8FB6A402C2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 15:46:22 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BDihBJ013705
 for <dev@dpdk.org>; Tue, 11 Feb 2025 06:46:21 -0800
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qf8sk02b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Feb 2025 06:46:21 -0800 (PST)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51BEkLwA014538;
 Tue, 11 Feb 2025 06:46:21 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qf8sk027-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 06:46:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opU1VRpylNrZr/ZEk4AGjzbNVix6QQQXTM5PC0KBj0clYJ7sg47Zu6iwQZBEPHECvU9Cbie//enEznh+rmQZg8uh6W9NTjxfREdkHyyVauEUBhifI3ao5MoSuHQ/K4I3uONlQ5IT0OFGWqibV5ew12MNDVbnPY6x8/RwctLon6RlHSrSy2U1oMd1kuldiJknckDH/jPWVUJZzLmwz1P68btN+5VGqZVVsClsSdjMhIGaBQ9UU7LryoL7f5R9ZAfiPaeb/2mJtyF2nZN03L79f87sIrtX/lnQ+fGn+/5xhU53nTmOOwwC3/IVGiJS4hjQkUEMBtjskQyuhuMKx0c5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcKR1O3QtIMfz5pcRwYbPLvwe9bmD7Og84oAoi3o1JY=;
 b=YclDH1sFdb55xwe+IeAPjyAZUS+QVdi+0vcLiB83G8NWrDCz38U601J+HCAFAIIig5kobdBowP5UlcA93niPLTqCs0FtIDcjPyVGmXQ34cwf0Nc3j3DVl9KwnfU+JezoPv6szCOuhaFNS/sYlNWeILCs+zDDeQqtHeH04EKP4Je0bUdhGgW1u0RbL2fwoQZrc49kxCRXJkBlT+5xCasxfO8I0oQquMTZh5XIs0xPeWJu4ugPFAIad1beWhhXzekZiX7Yv/p/XL7ZGOKroxd1bOCcSREIUfgNNMzDgJroxenh6v7nKipZrKblRdA9ZCSOewe4kq8q36FhS6pK1e079Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcKR1O3QtIMfz5pcRwYbPLvwe9bmD7Og84oAoi3o1JY=;
 b=r9dkCluOhLJoKNFmVjZwLqkfqwsknwHYgLvXQoq1jpIKvA8Cm0LcLU85PNejqKbd7divDj3KfhhpI8Gsg2NpmCgkQj/qc86j+Dw6Mdv5ow0ylnA5YQuMB1tVrukbortmnd9YRcHf9YEH+Wsxd2ASEvI1Hi7/9oq4UOZ4oa79q0Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM6PR18MB3570.namprd18.prod.outlook.com (2603:10b6:5:2ab::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Tue, 11 Feb 2025 14:46:16 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 14:46:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v26 00/13] drivers/zsda: introduce zsda drivers
Thread-Topic: [EXTERNAL] [PATCH v26 00/13] drivers/zsda: introduce zsda drivers
Thread-Index: AQHbefy3gOKiW1Z200ybBDBwa0Rph7NCMx9w
Date: Tue, 11 Feb 2025 14:46:14 +0000
Message-ID: <CO6PR18MB4484D2CFFDC08C6503B1284AD8FD2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250122093325.3099070-2-li.hanxiao@zte.com.cn>
 <20250208072732.4008334-1-li.hanxiao@zte.com.cn>
In-Reply-To: <20250208072732.4008334-1-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM6PR18MB3570:EE_
x-ms-office365-filtering-correlation-id: b2d62514-2169-4d8a-9028-08dd4aaad5d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHNLNEVaWGFPc2wvek84eVo3TjVEZ3B5RlNDbjRZRXZxMStXbnh0Vm9iRzNC?=
 =?utf-8?B?bUc5dUh6OEM2UTZjdFJlV05xRkpzSjEwT3FKRjllWG1JSGFCcXllclB0dFFR?=
 =?utf-8?B?OHhhelphY3NYazYvU2hWVkhhZkl6MkRySUlMdHd4S2I2WVN4TFdBU3ZNTy91?=
 =?utf-8?B?cDNaaE9NQlVZVzVsOHVpZ2UraklIb2w3UHZ4czdNT0dGNVJRQm5lUEZMV1ZU?=
 =?utf-8?B?UzgxMmFYdUx3VzltUWthU216Zk84WkFZT0dQc3I1Qm5wV1ROTWc2SFg3Vkhi?=
 =?utf-8?B?SzQ3Q0xLNXVEdUVuRWVseFZkcXpLZjFkeUg3U1RRWmF4NU4zN2N2UFNjNXl5?=
 =?utf-8?B?ak51bzVJbHpaK2ZhMk8raHhYQmxSeGk5WTMyVlBSYWk4d1RqWi9oNFRZUXAx?=
 =?utf-8?B?Tjc5MDZUYlZ4bnZ1TDBBS0xsUEU1UzBQcVkrV2o3U1B2L25oVC8reEZFRzBy?=
 =?utf-8?B?YTU3QkMrbU93OGJyRlJxb0xUUzhWRHZFNzlUaXhzWjZKU2ZsVmdYWDBPZFZQ?=
 =?utf-8?B?SFdwWHg5bUlFU2piRGljdGxodHA4U25ueldiUGhiWFJKaDZoeHpTeUlJbmxX?=
 =?utf-8?B?WjQ2SGNoZXRsalV6Z3ZqYW5BS2ZSYUZYTENlUHpIVW5NWTBKb3UxQWwvNTZP?=
 =?utf-8?B?N1NheTNYSElST3lnd3Rpd082aVlLZUxZbnBCdnZ2WDB1Rk9XNm9rOXYrMWFL?=
 =?utf-8?B?L1M1N0JYZll4TnNETytpeWk1dm5BZUxnQmJTNnVjTDRTUXRrb1kyOUZvbGpx?=
 =?utf-8?B?SVFtSm5iV05wbE1TNVhlZDJ0V3hWcFRtRkxQUlVQWHlyKzdwb2k0RHN5RUo4?=
 =?utf-8?B?V1RrWmNFRFdwOGJITURmcHQxMHljQUdBbm54L2lNS1VUYTNXdWxOTTJtSVdO?=
 =?utf-8?B?UE9hN2JPNjB5aUYrVm0zQTRzSDcrZHllb1ZjU2duVDNnOGxQZlVqYllTdlNx?=
 =?utf-8?B?QmpTdEZFSVFud2Z1SkdDZnhHazlRQkRUQzFpWmhmaThjVmp6Wm1BSmFWWFF0?=
 =?utf-8?B?ckxvQTZ1VjlLQjZhVHlHYVJJM3l5U0VPdENDOFduOStKeHg4QndlVWpWS1lN?=
 =?utf-8?B?L05VM0ZFR1hPTVd4OHd6MFdOcFN2SlRxT2NaUmFqaG13c1IxQkRqR085RXo2?=
 =?utf-8?B?cGNoeGVzT2YxVVNiV3puYjFTSXhLbDZlSmFYbE5JQmYyRS9vUUtSc1loNmhi?=
 =?utf-8?B?YlpGT1NMaEJSbDg5RGZnWWNHdVZUK25DUXcrYjJ6aURmOFVqRTBaN0NIeUpC?=
 =?utf-8?B?Zk9RQk9lcTFIaGREdERmRVZSTi84RjI5Q2x6Y0RzTjhEaVh6cEU5Qk44NEFG?=
 =?utf-8?B?S3RXdk5IKy9wbk1UYjRSKytyS3dDSlRzczJweGZicU15VGFDUy8xOFhLK2o5?=
 =?utf-8?B?eHQ5WlpLRjh2UVBVSzE1N2RleU1BY1FpZncrMlo0MU41bnJleitIMHlDYzlw?=
 =?utf-8?B?RzhQc1FjdEIwOG4rNjRpKzZFejg0UGtOQkNTb2x6QnR2YUZwc1lIMzc1RVBm?=
 =?utf-8?B?RDBkb0podzBEd2JEV1djRDBhNFVUTTRENEZsQnlTSFd6WnhvZXBUa0wzZ3Rx?=
 =?utf-8?B?cms5T3Rjb3FPRnZ2cFhsSjNQK0c2WU1yd0VlVzFNdmdEc20zbkVrY210MjJr?=
 =?utf-8?B?WUd6RkFZVDVFM29DdGl1MEtaRjR3OW56ZGdFNndjekRuN3pzSTgwdnJaVkI4?=
 =?utf-8?B?OUlXeW9ocHZ6RGMyMVRGSXVCQkZ1SWlYUmFsc1hobzFSQk1SQU5qbkNpMzZ5?=
 =?utf-8?B?RFBEWlpKYnMvaDBCRk4ycVU1QUhGd1Y5c09haU5TaUtEU2Zidi9LRTlxcFh6?=
 =?utf-8?B?ZFhscVB1dU1CQ3d3ME8zOHdJcVFtbGNIUG5XWUVFenJyaFM0enQ2ajlJdDBX?=
 =?utf-8?B?YnJHdUZ0dEdkdENrLzNQRmJuYmpHYXlSYXZucHR2cE9LTXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VndDbnlET3JjRzlObWRSSXZoS3FlNEtpand0STlqQWZkUENPaGtucXVuNGZi?=
 =?utf-8?B?NjRzcTVUa0JBWGtFb1Z5b1k1N3VhdWVBUXErQ1pKV3kwRXF2K2NnOUlkRU5I?=
 =?utf-8?B?NjNUVWo3cGZkUEF3MGFhUk8vUlJ1WDMvZlJVTjh0TlZ1QnNyZW5CQkE1Y0Nw?=
 =?utf-8?B?NGxiL0w3M2pjNkwzZy9iR3hXTHNvalltcGk5OHVmTi9tZm90MFdmZFF4eXpQ?=
 =?utf-8?B?a2dJbnVXNTNwdWF3TzdTSTB2Yy9xYU5pZUFTM2xBM0s5cTRiT2poajRPeVkv?=
 =?utf-8?B?eEF1VGUxRTNLWFlmZmhITjVVcGpqb2pqeE5VRDBWWlgwQTV3dHk2QzJDckIr?=
 =?utf-8?B?SVNrcEw5MWtHNE5pbmNLZzRVVEJrS1ZKbjdGV0VUV0dmQWVLdCtQajZrVG5U?=
 =?utf-8?B?aWg3dnpnbUdxNmNWVU5HNDdxSVAyYnFVT2Y1MVMyUGdPcWJyL1cxc1ZUVERi?=
 =?utf-8?B?WGtLTkF6bWlWRFZFVEhtM3owZmFSRU1HM3ZzaVcramU0enBTWjBjRHRxSFo5?=
 =?utf-8?B?MFlINjcvbWEvOWRnbTE2R0V0RmliK2thYlZtelUyV0p1T0RZWGJ1eVRscVJL?=
 =?utf-8?B?czAzZDJKNGtPTXU2QTR6cnhhWU1XSzN0RWZlRzFDMlNWOHIvbDg3S2o0UUR1?=
 =?utf-8?B?Z3ExeStmVmVhY3dxbVZYb1dRUVlCNWhwTW9tTUwwbG53cm0zeXhZRHRuSVlU?=
 =?utf-8?B?Ymo4UlhvbWtGNjBjR29VS0NGaXFtZmdkTDJWNGducFhFa1NheDhsc1hadzhE?=
 =?utf-8?B?ckx1bExyUTRPSzNVNHdscnMwN2FSWWhwdWV4UDU1MTZoU1JYektBeU8xU2Jq?=
 =?utf-8?B?NnhsMno2SkFMWnpWWEVFaUJkdkJQYTk5YTVTUHh5OEVuTzlhcjdES3B0cDU4?=
 =?utf-8?B?bmIybmpzeDBialBWZkR5RDlVdkl5eUxtUU5KTmp5Rm5iQXpSM3JwSTNmdEsr?=
 =?utf-8?B?Y21MQWZUNUN6ZkN2TDNmUkJ3Ykw1Sm1ETmc0UGFXeGJXZHV4ekZ6aFdYeHUx?=
 =?utf-8?B?YTJ0aVpIcmI4dEFyWjh3Uk1wVkgwL2ZLWXl4c1ZZK3B6dFgzZCtPaklncGhQ?=
 =?utf-8?B?SzV3TnErWEN6N2hpd2R1VXJ6Qkc0S202ai9QRklQL0hTQnRYVzVpdTQwUWxZ?=
 =?utf-8?B?b2JmczNFeThwMERZcFljVms4QkEzN3NnNEVEM0t6U1FUWFVsSzRqaThvS1Bx?=
 =?utf-8?B?VFVKdjk2TFZqU0Q3MTB6cklQdVEzRm9WdDI0Q0FkWDJ4cGN0NHliK3hXT0Na?=
 =?utf-8?B?alVoVHJMeDVVQ3cyT2xOUWc0WnMvcldHb3ZxSm5pR3g3ZktpT0JHVG1ncnQw?=
 =?utf-8?B?d3EzMnM4QUdyODJxSWlseUJzeFNQTkFZM2srMVJZY2pQaEJzb2I4eVowT3I2?=
 =?utf-8?B?UWpQQzUya01zQU9EemNFNVNOUjBRejJJWlhSZXBuMTJvMDhnZW4ycmthMXJy?=
 =?utf-8?B?eng1MG92OU50ZWZYaWFHbkl2cVVrUWpVNU5sYWM4MDBpay8yWGNBV1lrRmdp?=
 =?utf-8?B?VE5tMEo1NVEvZWxrZnVFSjhsbCtqYTEvL2F1aksvOFBHRWxUamVCOWpCbEU3?=
 =?utf-8?B?UWdsZ1pUdlFCcjljanBNemVnNUI3R1BhNWtDN2JWaGFxcSt5a3lGR0F6Wmoy?=
 =?utf-8?B?eHJ5dmdmMFV1ekRWL3FLZGNIYms3bHNvVEd4U2tQeVZ1QVFxOEhVRFVGUmVG?=
 =?utf-8?B?R0dNdFJxSjBuMHR0MjFDa3MyclEwcEp6VkFIZDNXblNVcU5GNE9MMytQRDc2?=
 =?utf-8?B?S3NDZjM5RzZJWVdSbnQwR0ljOHdSOTdIcHY2Znh0bmxSUktISThQaW5SUmJY?=
 =?utf-8?B?eGR4TCtrMVloQ3E3TkFFZGR2VCtYQUdXNEdiUTBhcFJhTmFWQ2lIRDlWL0NF?=
 =?utf-8?B?UmllMG9pY2tyM3VTdjNCOE1ybmNyazl6REFZd3hNbWZpR1lHU2FnR3pxKzA2?=
 =?utf-8?B?U3RuTkR6TWhrQW5yaFk2eDJBcytwS0ZpVWZBbml5M2xpa3cwM3RaZWFnbldJ?=
 =?utf-8?B?VGVpdEY1bEtsaXhjZVl1ZDJNS0VMd25vb1lFV2JsRk9UVWdpWFhuaytmYVEx?=
 =?utf-8?B?WUFvdzU4ZDN5eWg3dTEzUXE0UC9INXZQSTFEU0VTUjFYVmF0K3J6U3kvc1No?=
 =?utf-8?Q?ZcBAtfVuWJGOxEu1kfOyZoJHZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d62514-2169-4d8a-9028-08dd4aaad5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 14:46:14.8832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZgtwnH3/QmQ34GP4HTGai4n/rgiKPGJTThuWTu2FA4JsC+OIRyOPW2hHBDPYkfRA5TIEaaFThYWPsZyFjK/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3570
X-Proofpoint-ORIG-GUID: 3CW9Isb-qvXcI8kuqDvprwuQjSzGjuZ8
X-Proofpoint-GUID: jgFvszjH9kwbuW4Qwlrii693OQy2dwpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
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

PiB2MjY6DQo+IC0gdHJ5IHRvIGVuc3VyZSBhbGwgcGF0Y2hlcyBnZXRzIGNvbXBpbGVkIGluY3Jl
bWVudGFsbHkuDQoNClNlcmllcyBBY2tlZC1ieTogQWtoaWwgR295YWwgPGdha2hpbEBtYXJ2ZWxs
LmNvbT4NCg0KVXBkYXRlZCB0aGUgcGF0Y2ggdGl0bGUgd2hpbGUgbWVyZ2luZyBhbmQgZml4IHJl
bGVhc2Ugbm90ZXMuDQoNCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0KDQo+
IA0KPiB2MjU6DQo+IC0gcmVwbGFjZSB0aGUgYGBfX3J0ZV9wYWNrZWRgYCBtYWNyby4NCj4gLSBm
aXggYW4gZXh0cmEgbGluZSBhdCBlbmQgb2YgZmlsZSBpbiBwYXRjaCAxMS4NCj4gDQo+IHYyNDoN
Cj4gLSBUcnkgdG8gcmVzb2x2ZSB0aGUgaXNzdWUgaW4gdjIzIGJ5IHNlbmRpbmcgYWxsIHBhdGNo
ZXMgYXQgb25jZQ0KPiANCj4gdjIzOg0KPiAtIG1vZGlmeSBmdW5jaXRvbnMgbmFtZSB0byBtb3Zl
IHRoZSB2ZXJiIHRvIHRoZSBlbmQNCj4gLSBtb3ZlIHRoZSBxcF9zZXR1cCBhbmQgcXBfcmVsZWFz
ZSBjYWxscyBpbiBzYW1lIHBhdGNoDQo+IC0gbWFrZSB0aGUgcXVldWUgc2V0dXAgQVBJcyBjb21t
b24gd2l0aCBvbmUgZnVuY3Rpb24uDQo+IC0gRml4IHNvbWUgY29kZSBpbiBvcmlnaW5hbCBwYXRj
aC4NCj4gDQo+IHYyMjoNCj4gLSBtb2RpZnkgbWlzc3BlbGxlZCBlcnJvcnMuDQo+IA0KPiB2MjE6
DQo+IC0gbW9kaWZ5IHNvbWUgZXJyb3JzLg0KPiANCj4gdjIwDQo+IC0gYWRkIHJlbGVhc2Ugbm90
ZSB3aGljaCB3YXMgZm9yZ290IGluIGxhc3QgdmVyc2lvbg0KPiANCj4gdjE5Og0KPiAtIGRlbGV0
ZSBjcnlwdG9kZXYgZHJpdmVycyBhbmQgcHJlcGFyZSB0byBzdWJtaXQgaXQgbmV4dCB0aW1lLg0K
PiAtIG9ubHkgc3VibWl0IGNvbXByZXNzZGV2IGRyaXZlciB0aGlzIHRpbWUuDQo+IC0gcmVzcGxp
dCB0aGUgcGF0Y2hlcy4NCj4gDQo+IHYxODoNCj4gLSBhZGQgY29kZSBpbiBkcml2ZXJzL21lc29u
LmJ1aWxkIHRvIGNvbXBpbGUgenNkYSBkcml2ZXJzLg0KPiAtIG1ha2UgZXZlcnkgcGF0Y2ggY29t
cGlsZSB3aXRob3V0IGFueSB3YXJuaW5ncyBvciBlcnJvcnMuDQo+IA0KPiB2MTc6DQo+IC0gZml4
IHNvbWUgc3BlbGxpbmcgZXJyb3JzDQo+IA0KPiB2MTY6DQo+IC0gcmVzcGxpdCBwYXRjaGVzLg0K
PiAtIGNvbXBsZXRlIGRvY3VtZW50YXRpb24gd2hpY2ggaXMgeWV0IHRoZXJlIGluIHRoYXQgcGF0
Y2guDQo+IC0gZXZlcnkgcGF0Y2ggc2hvdWxkIGNvbXBpbGUgd2l0aG91dCBhbnkgd2FybmluZ3Mg
b3IgZXJyb3JzLg0KPiAtIGRlbGV0ZSB1bnVzZWQgY29tbWVudHMuDQo+IA0KPiB2MTU6DQo+IC0g
c3BsaXQgdG8gbW9yZSBwYXRjaGVzLg0KPiANCj4gdjE0Og0KPiAtIFVuaWZvcm0gQnl0ZSBBbGln
bm1lbnQuDQo+IA0KPiB2MTM6DQo+IC0gcmVzb2x2ZSBzb21lIGNvbWlsZXIgd2FybmluZ3MgdGhh
dCBhcmUgYmVpbmcgc3VwcHJlc3NlZC4NCj4gDQo+IHYxMjoNCj4gLSB1c2UgUlRFX0xPR19MSU5F
X1BSRUZJWCBpbiBsb2dnaW5nIG1hY3JvLg0KPiAtIGRlbGV0ZSB0aGUgY2hlY2sgZm9yIG51bGwg
d2l0aCBydGVfbWVtcG9vbF9mcmVlLg0KPiAtIGRlbGV0ZSBzb21lIHVudXNlZCBpbml0aWFsIHZh
bHVlcy4NCj4gDQo+IHYxMToNCj4gLSB1c2UgUlRFX0xPR19MSU5FIGluIGxvZ2dpbmcgbWFjcm8u
DQo+IC0gZml4IHNvbWUga25vd24gYnVncy4NCj4gDQo+IHYxMDoNCj4gLSBkZWxldGUgbmV3IGJs
YW5rIGxpbmUgYXQgRU9GDQo+IC0gQ2xlYW5pbmcgdXAgc29tZSBjb2RlIGluIHpzZGFfbG9nLmgN
Cj4gDQo+IHY5Og0KPiAtIGFkZCBhIG5ldyBmZWF0dXJlICBpbiBkZWZhdWx0LmluaS4NCj4gLSBS
ZS1zcGxpdCB0aGUgcGF0Y2ggYWNjb3JkaW5nIHRvIHRoZSBuZXcgUE1EIGd1aWRlbGluZXMNCj4g
aHR0cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI0MTAwNjE4NA0K
PiA8aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAz
QV9fcGF0Y2hlcy5kcGRrLm9yZ19wcm9qZWN0X2RwZGtfcGF0Y2hfMjAyNDEwMDYxODQmZD1Ed1FH
YVEmYz1uS2pXDQo+IGVjMmI2UjBtT3lQYXo3eHRmUSZyPURuTDdTaTJ3bF9QUndwWjlUV2V5M2V1
NjhnQnpuN0RrUHd1cWhkNldOeQ0KPiBvJm09R0p6eXMzb1RSZWpEV2swV1YtYjlDMTMtDQo+IFRJ
czFsdzE5WGlZUlU0eU1McWpYTXlveGJGRlhNT0lEekxteFlteDEmcz1tdlZyQmVNekZGNFFfOXI0
ajlNQw0KPiBVdERXQndRdk9nV3cxNHpjeFRydFF5WSZlPT4NCj4gMjU0LjUzNDk5LTEtbmFuZGlu
aXBlcnNhZDM2MUBnbWFpbC5jb20vDQo+IC0gU3BsaXQgU000LVhUUyB0ZXN0cyBpbnRvIGEgbmV3
IHNlcmllcyB0byByZWxlYXNlcy4NCj4gLSBTZXBhcmF0ZSBvdXQgZGF0YXBhdGgoZW5xdWV1ZS9k
ZXF1ZXVlKSBhcyBhIHNlcGFyYXRlIHBhdGNoLg0KPiANCj4gdjg6DQo+IC0gZml4IHNvbWUgZXJy
b3JzIGluIGNyeXB0b2RldnMvZmVhdHVyZXMvenNkYS5pbmkuDQo+IA0KPiB2NzoNCj4gLSBhZGQg
cmVsZWFzZSBub3RlcyBhbmQgc29tZSBkb2N1bWVudGF0aW9ucy4NCj4gLSBhZGQgTUFJTlRBSU5F
UlMgY29udGV4dCBpbiB0aGUgcGF0Y2ggd2hlcmUgdGhlIGZpbGUvZm9sZGVyIGlzIGFkZGVkLg0K
PiAtIGFkZCBmaWxlcyBpbiBtZWFzb24uYnVpbGQgd2hpY2ggYXJlIGluY2x1ZGVkIGluIHRoZSBw
YXRjaCBvbmx5Lg0KPiAtIGFkZCBhIGNoZWNrIGZvciB1bnN1cHBvcnRlZCBvbiBXaW5kb3dzLg0K
PiAtIG5vdGljZSB0aGUgaW1wbGljaXQgY2FzdCBpbiBDLg0KPiAtIGFkZCBjb3ZlciBsZXR0ZXIu
DQo+IC0gY29tcGlsZSBlYWNoIG9mIHRoZSBwYXRjaGVzIGluZGl2aWR1YWxseS4NCj4gDQo+IA0K
PiBIYW54aWFvIExpICgxMyk6DQo+ICAgY29uZmlnOiBhZGQgenNkYSBkZXZpY2UgbnVtYmVyDQo+
ICAgY29tbW9uL3pzZGE6IGFkZCB6c2RhZGV2IGRyaXZlcg0KPiAgIGNvbW1vbi96c2RhOiBhZGQg
bG9nZ2luZyBtYWNyb3MNCj4gICBjb21tb24venNkYTogYWRkIGZ1bmN0aW9ucyB0byBvcGVyYXRl
IGhhcmR3YXJlIHF1ZXVlDQo+ICAgY29tbW9uL3pzZGE6IGFkZCBkZWZpbml0aW9uIGFuZCB1c2Ug
b2YgbXNnIGNoYW4uDQo+ICAgY29tcHJlc3MvenNkYTogYWRkIHpzZGEgY29tcHJlc3NkZXYgZHJp
dmVyIHNrZWxldG9uDQo+ICAgY29tcHJlc3MvenNkYTogYWRkIHpzZGEgY29tcHJlc3NkZXYgZGV2
IG9wcw0KPiAgIGNvbXByZXNzL3pzZGE6IGFkZCB6c2RhIGNvbXByZXNzZGV2IHN0YXRzIG9wcw0K
PiAgIGNvbXByZXNzL3pzZGE6IGFkZCB6c2RhIGNvbXByZXNzZGV2IHhmb3JtIG9wcw0KPiAgIGNv
bXByZXNzL3pzZGE6IGFkZCB6c2RhIGNvbXByZXNzZGV2IHFwIG9wcw0KPiAgIGNvbXByZXNzL3pz
ZGE6IGFkZCB6c2RhIGNvbXByZXNzZGV2IGVucXVldWUgZGF0YXBhdGgNCj4gICBjb21wcmVzcy96
c2RhOiBhZGQgenNkYSBjb21wcmVzc2RldiBkZXF1ZXVlIGRhdGFwYXRoDQo+ICAgY29tcHJlc3Mv
enNkYTogYWRkIHpzZGEgY29tcHJlc3NkZXYgY2FwYWJpbGl0aWVzDQo+IA0KPiAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPiAgY29uZmlnL3J0ZV9j
b25maWcuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiAgZG9jL2d1aWRlcy9jb21w
cmVzc2RldnMvZmVhdHVyZXMvenNkYS5pbmkgfCAgMTUgKw0KPiAgZG9jL2d1aWRlcy9jb21wcmVz
c2RldnMvaW5kZXgucnN0ICAgICAgICAgfCAgIDEgKw0KPiAgZG9jL2d1aWRlcy9jb21wcmVzc2Rl
dnMvenNkYS5yc3QgICAgICAgICAgfCAxOTQgKysrKysNCj4gIGRvYy9ndWlkZXMvcmVsX25vdGVz
L3JlbGVhc2VfMjVfMDMucnN0ICAgIHwgICA3ICsNCj4gIGRyaXZlcnMvY29tbW9uL3pzZGEvbWVz
b24uYnVpbGQgICAgICAgICAgIHwgIDI2ICsNCj4gIGRyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9k
ZXZpY2UuYyAgICAgICAgIHwgMjA5ICsrKysrDQo+ICBkcml2ZXJzL2NvbW1vbi96c2RhL3pzZGFf
ZGV2aWNlLmggICAgICAgICB8ICA1OSArKw0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX2xv
Z3MuYyAgICAgICAgICAgfCAgMTkgKw0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX2xvZ3Mu
aCAgICAgICAgICAgfCAgMjcgKw0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX3FwLmMgICAg
ICAgICAgICAgfCA5NDYgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9jb21tb24v
enNkYS96c2RhX3FwLmggICAgICAgICAgICAgfCAxODYgKysrKysNCj4gIGRyaXZlcnMvY29tbW9u
L3pzZGEvenNkYV9xcF9jb21tb24uYyAgICAgIHwgMTkyICsrKysrDQo+ICBkcml2ZXJzL2NvbW1v
bi96c2RhL3pzZGFfcXBfY29tbW9uLmggICAgICB8IDE4OSArKysrKw0KPiAgZHJpdmVycy9jb21w
cmVzcy96c2RhL3pzZGFfY29tcC5jICAgICAgICAgfCAzODggKysrKysrKysrDQo+ICBkcml2ZXJz
L2NvbXByZXNzL3pzZGEvenNkYV9jb21wLmggICAgICAgICB8ICA0NSArDQo+ICBkcml2ZXJzL2Nv
bXByZXNzL3pzZGEvenNkYV9jb21wX3BtZC5jICAgICB8IDQxOCArKysrKysrKysrDQo+ICBkcml2
ZXJzL2NvbXByZXNzL3pzZGEvenNkYV9jb21wX3BtZC5oICAgICB8ICA0MSArDQo+ICBkcml2ZXJz
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAyMCBmaWxlcyBj
aGFuZ2VkLCAyOTczIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2MvZ3Vp
ZGVzL2NvbXByZXNzZGV2cy9mZWF0dXJlcy96c2RhLmluaQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3pzZGEucnN0DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9jb21tb24venNkYS9tZXNvbi5idWlsZA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvY29tbW9uL3pzZGEvenNkYV9kZXZpY2UuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvY29tbW9uL3pzZGEvenNkYV9kZXZpY2UuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvY29tbW9uL3pzZGEvenNkYV9sb2dzLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2NvbW1vbi96c2RhL3pzZGFfbG9ncy5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jb21tb24venNkYS96c2RhX3FwLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nv
bW1vbi96c2RhL3pzZGFfcXAuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY29tbW9u
L3pzZGEvenNkYV9xcF9jb21tb24uYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY29t
bW9uL3pzZGEvenNkYV9xcF9jb21tb24uaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Y29tcHJlc3MvenNkYS96c2RhX2NvbXAuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Y29tcHJlc3MvenNkYS96c2RhX2NvbXAuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Y29tcHJlc3MvenNkYS96c2RhX2NvbXBfcG1kLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2NvbXByZXNzL3pzZGEvenNkYV9jb21wX3BtZC5oDQo+IA0KPiAtLQ0KPiAyLjI3LjANCg0K
