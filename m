Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7DC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 13:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57DD6427DC;
	Wed, 21 May 2025 15:56:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9184A427D5
 for <dev@dpdk.org>; Wed, 21 May 2025 15:56:31 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDqZxd027992;
 Wed, 21 May 2025 06:56:30 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkrg8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 06:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri4T5KL2NM24QL1267UAiVvAJPBbP6o5nEKXDV04pWRJpMGQcB5whSUCXLthigYLQrtej5Sx8HHVz5pdfC1pMjSKwoz4+n0+IUm/Ud4R8+mtIzWmZcPqGpCmceEMvUoF3ceNQVey9uejXs63chba3/QyVnzdO0PVXEBD+szW/76Gcccg6jWBC4uLtT5slxpjPg03HjE1jPEP5pQYy3S42+UWhBabnR1esWyaIW9UhK/G+BKc8fkHwEO0kUM+pR13JIlqFgVZGMl9rzHPDW+UkNMB68v9u6qf+T5fyYE0urchkF5tvAiz8oacqR3PEFbSym3xm2x+sCKuf3SWUomwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RG8FOdydPMumCKwww5RtvjMzKJTTm8oeSMJlSrNJmc=;
 b=C24j1X5h23pblMiYGKDKbSyqgtfdUIWZF8Sdsv40HrMIWI7NiaBnY6DK52fqML6kC1lT+U7EW8IJnGM1x2mJFb/Jft+MC47kj+Yi+vYmSFSwhAZPWuaRahbFNvBuMT5k73ftvMNlXhVigQHZILp2AaAP8foFbX0rxLNIaZGZRbwUGhUEXuhuwk3EWT8zKWbsE4abgtE7SuVrAz7n4Q/fgwzm0zQ19yW/wInL+Ni44gLSgHyx5PELG7zs8Lq7fVfnfAGmzPfXYoTKbp/sT+FTIEZvXtAgS6CXJj8Gp5sMnZ6hqUKerPXRF153wfEk0OZsPCSdE6QzedL/QLE/F5OrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RG8FOdydPMumCKwww5RtvjMzKJTTm8oeSMJlSrNJmc=;
 b=vp0CtirxHtS5nTkM8mkqgipwDwjf//ClYicFYZSIRwn4tzISInaTLqiu5H04pfBvGtw+tQFeJvbU3jEyGDO5PB1dheLVa8SQzidj89JIf1A7cUnTkQNR8vzE0KyALRZHGFfpUqifgd5yY9gFix7uX2hivLqJtmQvuk9bcRpwnDA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 13:56:25 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 13:56:24 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <mattias.ronnblom@ericsson.com>, "dev@dpdk.org" <dev@dpdk.org>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: "hofors@lysator.liu.se" <hofors@lysator.liu.se>, David Marchand
 <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH] cryptodev: allow use of global variables from
 C++
Thread-Topic: [EXTERNAL] [PATCH] cryptodev: allow use of global variables from
 C++
Thread-Index: AQHbUjW/WvGgHHNB1U2CtGMgq1dumrMMwY4wgNFJ/DA=
Date: Wed, 21 May 2025 13:56:24 +0000
Message-ID: <CO6PR18MB4484D9A981756C24CF41540CD89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241219163523.164992-1-mattias.ronnblom@ericsson.com>
 <CO6PR18MB448445B1358C95D3556FAD2BD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB448445B1358C95D3556FAD2BD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ2PR18MB5635:EE_
x-ms-office365-filtering-correlation-id: d1fb9818-d9af-4737-9263-08dd986f4693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nm1nanJzazRNRzdySWhXUVlPWmZjdGtmd0hUY1RGZktoMGpkMk9JNE4ybmFV?=
 =?utf-8?B?dW1ndHZEZGhCT1BTYXA4NS9lcGIrdkF1ZHYxQ3lDMjV2Wm83ZTRLc0VPRkFw?=
 =?utf-8?B?TTVNUk1ZMGFCalI1RlFKRWh6emxNWk1nSzlJTWlPODV4WUFwUzFlWVhNWFhC?=
 =?utf-8?B?MllFSG1nMFhVQlNxSVNGelI5NEk2Ulp3bHpUanRQZ204VW96ZU1BWXZRdXJt?=
 =?utf-8?B?K3lnVUZ5THp4RDRGL0RJUTMxUGxadHZIbUpFZjJhbHJmQk44VTIycjNhVUlj?=
 =?utf-8?B?cmVTVi9DU1Z5WHNMdmpqbjl3d1pXL2dTbkFaM1VMKzRLVU5QWUVBSVR4cDlS?=
 =?utf-8?B?a0tzMEl2dVJ3ei83SU1aVkppOXBVQysxTHB4eXgweWdhaXh4VHRsMU8xMExQ?=
 =?utf-8?B?blBIUEpuODIzMTBVd2cwY2FoMUdpL1IzcUdNZUZtdkFweFBhUUx2Ky9zYXFt?=
 =?utf-8?B?S3NzTGE5ZFdlZHdvbEJuQit2U0kxQ2pES1YrU2ttTE0zZ3VXNTNKUnVSVFJa?=
 =?utf-8?B?MzFpZW9mNlNZd0d3UzI0UDRIOFB3TFl0MFR6L2FNUHJSTmpBcmZIMTh5dFk5?=
 =?utf-8?B?cFNWcE8wNTJFR25TSk95TE1kcWFheXdyUWZmWVcraHZzb0VPYzBLMzBXd1A4?=
 =?utf-8?B?Z2R0d2x2ZE9leVEvRXI1dzN2OUxDL2krbUhqKzZER0M4RVZHZnA4KzJtR09B?=
 =?utf-8?B?NHh6MkdIRzVPc3pERWRZdytGS090SnVuYkE3bEZyUVNYNS8xd0c2bzErNzhZ?=
 =?utf-8?B?cFBSUk9RZGhrUmg5N0JzZkxGYkZNTExIN1V5TmlXZFArV2wwZ0VudXRkQ0I4?=
 =?utf-8?B?dGFHUi96d0FCVjlPQXIwT0NRY1padEd3SW8zSUZVRHp2Rk5PWUNEdkZDRmd5?=
 =?utf-8?B?aWFXNWNwYjlpcHZlYkdzRkFkVmpkTWlUcG0rbXdCZFNnTlozY1FnLzBwUjE1?=
 =?utf-8?B?c1lxNFJyM3dadEdjZThIZHR2dEt0c3Vjc2RLcEJZRnF1Q3RLWjBRa0Q5cmR2?=
 =?utf-8?B?dEwxUTJLY3RhR1ZHTjNMNjFxS3ErWnZ0ODVUREpoM2pTYXZ6bEc3MkFIckZM?=
 =?utf-8?B?bEsxNW96UG1KNDBXWUNzV0MrVGFwK1VGYW1hMXFBOExNRFZYWkJvQU5BeWov?=
 =?utf-8?B?ZWRpaFl3NzdOUkdiMlYweFhJQ2hLVktyVlVVenhvaGtVN3kzMTR3TzNPZXZ4?=
 =?utf-8?B?S2g2VWlUSlZ1cVZDVkdlUno4SDU0OHZsVU8rYTBwMDM0bmJyU3d4ZmdTeVlk?=
 =?utf-8?B?YnFZdXE5SzBaYXdtYmYwcHhwT3FLWFlsdlBVUVNFTXRSMkdKcmIwSnl1Snpr?=
 =?utf-8?B?cXZWSHl4WC9kamYwUHVyK2MrWVdkK2JRUFVsUUJrb0VUcVROOUxHbWxzUkVN?=
 =?utf-8?B?WGs4eHIwSnUyUHE0NHVmSHpkano4YnNJZm43NkpvT0tJZWNxVDhRVk5qT05Q?=
 =?utf-8?B?TTRzbVdCVWhoc3BvQkxUa2tKV1o1VXJWenFTdHJMdDAxcDczcjdkdWc1WmZ5?=
 =?utf-8?B?ZUl6aVM0YTYwNVRaejR0L1pBUW1NOWwwQm91Z1F1NDhESTA2dkd4enA1Z1BJ?=
 =?utf-8?B?K0NIOCtnbU9OTnp4amcwLzYrQkpMTG9mb0FlbFZmQ3M1RVpqdGxxY3dQYklU?=
 =?utf-8?B?a2UycWlUczZEdThjZTdJczJMMU5BTHJnamMzTy9MY2ZIemkwN0Nhd1NZdHJn?=
 =?utf-8?B?UG9xcUxBM3pKTysrTzVQK2t6LzVBaTlENFd2OFJBNExhN3ZIRmgxaFB6d3dR?=
 =?utf-8?B?UTZFQ2s1ekNnKzhjQXI1NlpWMGowVFpKSU1hMU90KzBGMVFnajFMeW42b1NX?=
 =?utf-8?B?cis4cXlhUVdiNTIrS09jQkh3eVNZM1ZkODNIM2FmUkFBR1FPb3FLZDJSaXRj?=
 =?utf-8?B?cXNKZk81Z2RCNUVKRzdXMWtKbWFwM1hmSmJEVXA4RjNYK0lKc1lBeDZBSzYw?=
 =?utf-8?B?dkNjU1NkSitwMW91K3lKbys0dkJoRUpzNitvL2hvam5mYVFLUTlkank5MDlr?=
 =?utf-8?B?WjRBUWM0U3V3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3paUzhJNGJTTWw3LzlySnBrUmdWVUU3cE5hUW1lYUVuYlRaQ0xoYnI5Y01X?=
 =?utf-8?B?RnpxNVZPS2xFT0txVllUbjhRMUoyOHJSSVVLQ3NwN0xMd0h0YXVkb3VjS3RI?=
 =?utf-8?B?TFJqUzExNndGTGsxVFFFTXZLSy9PQ1VMbFVNOW94cEJJb1lHZzNCZkQxbXY2?=
 =?utf-8?B?WnAzcUdhK3FLREdsak5GaW9UWUprSk5HYWtCckhBNTlLOHcwbnpieHlRblIw?=
 =?utf-8?B?em9FZWZlSXcvR3Vsc0hQWU5FZWNZZnRLaUF3M0UvTFR2WkpabXhjUzJyYVRz?=
 =?utf-8?B?VzJYNHJzai94Y2lsZzYwTWRKcmpFRUl5bEdiREdYSWxmWDNvKzVtNDBUNmNL?=
 =?utf-8?B?ZmVVVmR0RXRsNko1bStpN0dwVnZ5TElHZXNHSExwUlpPbU80SDlvMGFyajNK?=
 =?utf-8?B?N2gxbEU0UUs1ekRkQ1EvS1Q0UFpkNUwwQ1NGTjYwU21iZUxXOThSSGprd3VW?=
 =?utf-8?B?d041L041QWpCTEpsQlBSdmxjM2xiZERYQkdzSnJBMVlIVVRGQS9jdUxXa2gv?=
 =?utf-8?B?Yks3ZmxjbmtDTWh5Q0M0SFh4OEZsMlFBL1BIZTQ2RzlGM3RGNXZhSnR3UXVW?=
 =?utf-8?B?ZS80UTRKdW00STA0TFRsWkl3ckZ3dzdzWjJ5ZmtiejF2QmxrYXhyUTZUdlRZ?=
 =?utf-8?B?d0VQQlRoY29IUlB6ZVpYQ0RpdzJ2M2d0TElXVjduV3g5WXRqNDdvZngyVmRF?=
 =?utf-8?B?N3pmeUt1RU9JZVByWUt1cHlML295eW03emk5MHUyUktIaVZrNjlvN1lSZkhT?=
 =?utf-8?B?RWlJWUErWXZuS2poUHdmNDVheGVVWFlvem5HMG9zUWlzdmFhNmhyQVBxdkcx?=
 =?utf-8?B?Vlk4QVVkdHVSVnV0YjhZd2pNZVpZS3BnUDJzZGc1d204dWc5dDJYUXdmYmwz?=
 =?utf-8?B?YW4xU0dlV3J3VnhYa1dHUFBvWEpOWTZlVWtzdU0zeW8xY05RQ1lWeVBtN3BY?=
 =?utf-8?B?UGJaRks3U2hrMEZpZE5pL3podUZlWXBObkJnQjgrNlRsUjhabjdzV3pla1NZ?=
 =?utf-8?B?cjZBeTFJdzNxZG5Qb1BRRWFyRzRDV2pDSGhCZEtzaWhsdjcwMjhjSFA4ZFJL?=
 =?utf-8?B?TDdxTXZoczBmWWR1a1JBT3p6ZE1aL1ZJNXZQcEc5UmNuMDRVdTNNOHhYcDJl?=
 =?utf-8?B?Mmc2Qm5iaGVrWkJNOHNUdWlBV2txTTlJelAva3BNZEhtcGF0L3VKcE80b3ND?=
 =?utf-8?B?V1M1cjl1UXhEclhlWmE4VTVZdU5Nb1VrYm1YVm04QlRWbjVaVlpxTWRzMUF5?=
 =?utf-8?B?K0EzVmJyUm4yOXhNQjdabWRYd09nTDJWOWp1bjViSGN2Y1J5UGxIb25kOUtu?=
 =?utf-8?B?Uk5nWlVwelUvRUlTYlVQVytBYjUvZERqMndyRTZ0YnRTSlRwd1V3MWh1MVkr?=
 =?utf-8?B?MFZFYk9Sb3dIM1Q3WEVmZG9qWWJXcHBxRW9GQXlkMGRtaTRiK2VVQjZrYVNL?=
 =?utf-8?B?a2NyOUFrL0kxSnlvQzBSSCt0SVRjSmFkNkNoTTFXTjhzcU9XWVdlMmsyNlQy?=
 =?utf-8?B?aTlpQmMxcDJjSmU3TnIvQ3pDbjRCTXROdkcraUR2WE1zQ1FvZHRrUWFHcGNk?=
 =?utf-8?B?Y2R6ZGpzSERLWUpkRklPM2laa1RIN0IwaHY0RmFXWVBLR0VoSkYwZnYzV0hS?=
 =?utf-8?B?TTd4dWtEVE5KbnhLUGRsOUNpZWtXZ09lT0xERzJ5ZEZEMDZUUEk0Z2swWWxV?=
 =?utf-8?B?dmFsbHdENk1YRUsrUHprSmFQSmdqNndGNjVRZ25aZDJVSzVZUFJIdFAyU3dP?=
 =?utf-8?B?WmdMWENyZUsramVzMkRGM3RRL0VPUXhXaExheFhUSHFxeWtDQW5xTVhoeldy?=
 =?utf-8?B?KzZocXVrSzVpVzhQVDAvakY0VmlUNEk1Z1ZvMDkvZEkyV29YNGUrNGRSYmNN?=
 =?utf-8?B?aytPOEMwWWc5OG9JeVk2SjViL3dEdEdyT0VGMG5yM3doZVNCWWcyM3RrQ1lw?=
 =?utf-8?B?d3hsUSt4TU5VUWVLQk1IdmhXWm1keURBSklmNmJiamhyZVdBMzk1TU5UdzVy?=
 =?utf-8?B?OXZ5T09BUEpYTjlPZGxSajUyaU5RcGRoNnNtZGszTHhXQVE1K2NWQ084TXFU?=
 =?utf-8?B?UjduQ05hVDlEQTdZMXBoR2h3THkyb1owcXlEVWpFOWhjblBVaDZDU2JTVG5L?=
 =?utf-8?Q?HuY1p+MLa1m++UAs53YfdVR4N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb9818-d9af-4737-9263-08dd986f4693
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 13:56:24.9299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 908F59ZY1oANpujV6Z1zAy1w+UFjV5ytIxmvvqJaB3DBpUBK5zmvSVf0j28DhX09Va6faem4cB/fUxYBJYVURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5635
X-Proofpoint-ORIG-GUID: 4FzJbQPOjdfsNWTLokBaexusW4yFZtjn
X-Proofpoint-GUID: 4FzJbQPOjdfsNWTLokBaexusW4yFZtjn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzNSBTYWx0ZWRfXzRkbUSxiqM7y
 7hjsKfEcL/3zdw3PWZicfq4M7n3LD0Z2dCN+P0rR1spMp2W33T/O4UR95g5uqINmPwS+XSYRTGi
 F+IpQcf5NO/ap31xyT/YwbIEzUOHQ4/ci/VWsi9z5CejyxsNzFiWsYxVLiu57ONxIsIGqZvAbXH
 kgK9v3nmmE9tbhZi1dBth8pmdC+cPOL7xJZjOnjNbwDMwxBvyyknUZ3TyOLr4uYLVUxrlfG1YFF
 OyYzsZIoUbJ3yNX+tSyuoQHfESQa8wn5W5Q+NHjkwIOLqbyyZ6tcBxUReINdU890S3nVNSAykv9
 LK69nIzlBg2EhQsOFY8w/FdzvfZJ+mXN2bqC3HtmhQ4hwYAtPLkrA4bl6PVcv3QJyQhpP2kSwCd
 xfebj0HqqIquOJ5gEpl1bKneldvqOKdRhtj+1YL3c8/Rwb/zponwgTn6c/66MqQFvwT3OW0V
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682ddb8e cx=c_pps
 a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=miE8BliPBBtOm77D:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8
 a=0FD05c-RAAAA:8 a=M5GUcnROAAAA:8 a=pn9NDFP74hWx1VWahpIA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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

PiA+IEF2b2lkIEMrKyBuYW1lIG1hbmdsaW5nIG9mIHRoZSB0d28gZ2xvYmFsIHZhcmlhYmxlcyBi
ZWluZyBleHBvcnRlZA0KPiA+IGZyb20gPHJ0ZV9jcnlwdG9fYXN5bS5oPi4NCj4gPg0KPiA+IFN1
Z2dlc3RlZC1ieTogRGF2aWQgTWFyY2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWF0dGlhcyBSw7ZubmJsb20gPG1hdHRpYXMucm9ubmJsb21AZXJp
Y3Nzb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBsaWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9fYXN5bS5o
IHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvX2FzeW0uaA0KPiBiL2xp
Yi9jcnlwdG9kZXYvcnRlX2NyeXB0b19hc3ltLmgNCj4gPiBpbmRleCBhZWI0NmU2ODhlLi45Nzg3
YjcxMGU3IDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9jcnlwdG9kZXYvcnRlX2NyeXB0b19hc3ltLmgN
Cj4gPiArKysgYi9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9fYXN5bS5oDQo+ID4gQEAgLTI1LDYg
KzI1LDEwIEBADQo+ID4NCj4gPiAgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfYXN5bV9zZXNzaW9uOw0K
PiA+DQo+ID4gKyNpZmRlZiBfX2NwbHVzcGx1cw0KPiA+ICtleHRlcm4gIkMiIHsNCj4gPiArI2Vu
ZGlmDQo+ID4gKw0KPiA+ICAvKiogYXN5bSBrZXkgZXhjaGFuZ2Ugb3BlcmF0aW9uIHR5cGUgbmFt
ZSBzdHJpbmdzICovDQo+ID4gIGV4dGVybiBjb25zdCBjaGFyICoNCj4gPiAgcnRlX2NyeXB0b19h
c3ltX2tlX3N0cmluZ3NbXTsNCj4gPiBAQCAtMzMsNiArMzcsMTAgQEAgcnRlX2NyeXB0b19hc3lt
X2tlX3N0cmluZ3NbXTsNCj4gPiAgZXh0ZXJuIGNvbnN0IGNoYXIgKg0KPiA+ICBydGVfY3J5cHRv
X2FzeW1fb3Bfc3RyaW5nc1tdOw0KPiA+DQo+ID4gKyNpZmRlZiBfX2NwbHVzcGx1cw0KPiA+ICt9
DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgI2RlZmluZSBSVEVfQ1JZUFRPX0FTWU1fRkxBR19Q
VUJfS0VZX05PX1BBRERJTkcNCj4gPiAJUlRFX0JJVDMyKDApDQo+IA0KPiBJdCBzZWVtcyBvbmx5
IHRoZXNlIHR3byB2YXJpYWJsZXMgYXJlIGNhdXNpbmcgcHJvYmxlbSwNCj4gYnV0IHNob3VsZG4n
dCBpdCBiZSBiZXR0ZXIgdG8gaGF2ZSB0aGlzIGNoYW5nZSBmb3IgdGhlIGNvbXBsZXRlIGZpbGUN
Cj4gbGlrZSBydGVfY3J5cHRvX3N5bS5oLg0KPiBUaGlzIHdpbGwgYXZvaWQgaXNzdWVzIHdpdGgg
YW55IGZ1dHVyZSBhZGRpdGlvbnMuDQoNCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1h
cnZlbGwuY29tPg0KQXBwbHlpbmcgdGhlIHBhdGNoIGZvciBub3cuDQpXaWxsIHVwZGF0ZSB3aGVu
IGl0IGlzIHJlcXVpcmVkLg0KDQpUaGFua3MuDQoNCg==
