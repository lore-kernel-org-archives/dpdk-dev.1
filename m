Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6EAC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 18:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D08F3402D7;
	Thu, 27 Feb 2025 19:07:27 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9EE8E40287;
 Thu, 27 Feb 2025 19:07:25 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFjKLZ005358;
 Thu, 27 Feb 2025 10:07:24 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tyjrbur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euVpVGUguHiX98zE9HpU2ZQ/pBzzdaAlZX9jKviGAW51+G4NHveunlpr1m6JZtx6boa2p9+Ye/cOYAq+YID0pZzppNrvvYHdp+7SPL/O+9yt5FK05YwbzTEJ9V58+Ao0P216u1DfHsURmj2f3NU6CLmMkIUkCIsXfw44/JiW6RZYnaD9KHvb+GBVPtKJYDFRhgdyO3C7UO9utgBXtSPyfhlNkqSs8hef86aQ4Brg+k6SMScZX5Ucj+hg5yvBJq7PTGG2wLoHPKkR2DGZOah/xnbEzPYUBwKThvEeFObcdmEcJGRlRCKb94u2JA1zblm4L42B0kciiTVRIEOJij1KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjEjlqXBv/1M1JOsOKbus09VYt7y7w4YRFTEAXfG7TE=;
 b=kY7NojT0MWkETnot/FAUuJFhRAswkNljiD2o7HBSdG7ACqA8QJ6q71kt3flkJZJFCWNGtC9dkvf97Ctm6Uv5HcBTw5OYUL0S5lNUzSr+3hXCh6RC6F3GVd7MkumQpovweTUdfsDKjdrcdjyLT+5zB/7nTgjsUgfTr1zzd9q+WfD7+X8xCVV/1APZa3IZNBA71dQzy/sP0Z0YZ4VRBnnj+M66G3KBM7Ab2QmMQ61uvtqVfXWW/bTBslfmrzrIp5K+oiiJ52Gt4sUBxmmaTOuHId0oEijpoo/S6GKhfvtcLb/RLjU3AtSKXbl/jynXxYJAZs3sROQLJWI7wUZmkgztrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjEjlqXBv/1M1JOsOKbus09VYt7y7w4YRFTEAXfG7TE=;
 b=TdMHe8aXVEdbNqdCxw1OTg9LuATbw2B6AQ5FOqt2R7L5rb/xiACrGtqqxjKlE0WdhWnsnaLYuNw2bkKCp+F6q7EWJH1cozfODbJ9ClRHJKca852/6jiZRo5GgTxdB9IbJtnagd//XdsJ49HiBqmTl57W5LnIueOinccbopWiN1Q=
Received: from BY3PR18MB4705.namprd18.prod.outlook.com (2603:10b6:a03:3c8::12)
 by PH0PR18MB3861.namprd18.prod.outlook.com (2603:10b6:510:25::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 18:07:21 +0000
Received: from BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe]) by BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:07:21 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Jay Zhou <jianjay.zhou@huawei.com>
CC: Anoob Joseph <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Topic: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
Thread-Index: AQHbiH6FA1dexCVgyUmrLiQ9SxTU/LNa32UAgAAA7wCAAD+IoIAASj/g
Date: Thu, 27 Feb 2025 18:07:21 +0000
Message-ID: <BY3PR18MB470536F2A1329EE6732E332CCBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
 <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
 <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4705:EE_|PH0PR18MB3861:EE_
x-ms-office365-filtering-correlation-id: b166d3b3-4685-4a28-dcb1-08dd5759948d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEo1SlZZOERPNkNVbzhJWWRycjlyMGtGNzJqTHZWV1VXS0d6dDQ1RDE1aG4r?=
 =?utf-8?B?aHdOME84ZEJhZjZBb29IK3RSY3d4YWt5ZUo0bUh1d3ZCRjRVb09lYXpUMDly?=
 =?utf-8?B?WHpiUWZpcVR5Nkw5blVrclh5VGx3OWlVZUVQTzdBWHU0NEV0dFRMb0JqcUQ5?=
 =?utf-8?B?SGlnS0cvcFBEcEVodmVBbEo1Z00xeDlJNzJjWi9ra291aERhSTJCb3ZGQmZ3?=
 =?utf-8?B?bzYrVEFHaTRJREd2Z3BrVHFsSnd4Vzk3Y0lmUVBpQkViMHplUG9TTkF6dXJi?=
 =?utf-8?B?OVNrU1ExVEJGcUh3QXZNY0JTeFVTTDB5aUMrazVMeUhDRjRzUmtNYSs1Znd2?=
 =?utf-8?B?QURzdi9CQVdNSGlVS1k0eFZNRFhWUHRLbTVHM1ROSldEcDdRRHVOQU91dDFB?=
 =?utf-8?B?dXMzK2FiYVdUMUYvdWVUanJRbGRaVHJrK1UyYTRySjRUYkRKdTcrMldCVllB?=
 =?utf-8?B?TGVzbU12QWtDWnhpNTFET21hdkVMWlYyMkpVakcxWGU2RjZGZnc2cTk1Nmhx?=
 =?utf-8?B?dE9GaE1mRWRBSWlkcjhEUEJ5bTJHei9iQmRQQ3ZLcHJjT0hMb0s1bzI0d0E0?=
 =?utf-8?B?SjNoczl2UUF4elM0WFpuaERpdmNMVFk3TjRHK296WXU4aFhYNTZicm9FNWdY?=
 =?utf-8?B?ZFBlZzhweTR2Vm5IMlFlakxoYWozN29Va1kzOC9wMXdIcGVCTEFEWHVCSnl3?=
 =?utf-8?B?cXE1NUw5ZVZkSUlTdjNlVFU1QUp1ckg3NGhZSGJERWYyYURPSkVtSUQ3dVJM?=
 =?utf-8?B?Z0QxNSsvYVh6Mmx0SFliVVVIdWhqSzlpYmJBMFgwUy9JcFBmb1U2NFhVT3k3?=
 =?utf-8?B?eVJVbzhodlA4NTdwMHdQMFVITXdCcXE5ZzBtbExFc2hkaDEyQTRyYm4wdk5X?=
 =?utf-8?B?WThuV1RJL2xkSkRBR25aamZrekNSMUZsRUhqOW1VbkltZ081b3J4azhpNlVL?=
 =?utf-8?B?RkRjbnUyTmRKeVJvOWFmT0wxOXhiMmxYMnlaT2ZiSUJOVWs0d0xGMDhXVFE4?=
 =?utf-8?B?UG5DQ2o2ZVNCQ2JPNXdYbDkzWXZmN3gyUlNvcDZzV0pzalZSd1dBblRadlZs?=
 =?utf-8?B?TmZ5eHN1VzlJc3VVcnRyakdzRWVpcmZ1dTdDVFJKQWZzTTJsdGxzTzc5N2Ev?=
 =?utf-8?B?UmR5STc1aG0zSjdnVklINUpQOTZtKzV1M2UwclYxakl0MmxlR0hIankzNytV?=
 =?utf-8?B?N3N2bXJFaEpnbXNzZU1ZUlBVYnJUbFBZY1BKK1kwVHZmMDJyMUJJMmpaR2JW?=
 =?utf-8?B?TlpFUTRrL29UREUzdHh4cnM4bVVFNTBpR1Z0SmFjd2VhYnRUSW0ySUtqSElO?=
 =?utf-8?B?VWhNc0VLMzByWW5zWnd2VTV3aTRTSE9tdUswMG5CS2U0MmtQM0N2WUhaZXZ0?=
 =?utf-8?B?d1A5TmJQVkhzcG8ydlVEbTJRLzBENjRrZTJxdmNpcFdNQ0FRVzhzMUFDTWRq?=
 =?utf-8?B?dFNqZXoyZkZRdHVJOFRaZXF2ZE0ySDNvL0JuVTViRnJaaU44NHlRaVo3YWxj?=
 =?utf-8?B?MHJsNGZkUW8zaEJkMzhDeS9lc2R3TlhYL2R2SGxJSXZvZlpTOVVhVUdiTVF2?=
 =?utf-8?B?d0l4ajFwWTJRd2Z4TGFHV1p6ZmFETnB1YlUwRkE3VjdOR0lMV3Jhdy81R3ha?=
 =?utf-8?B?OG5Md0FuTXFSVTl1NGtzVllhZTBhbXhjVmxoVHhjenBrdWJ5clhJd1ZCdFBy?=
 =?utf-8?B?R01HWmorZllqSDE2WUc5UU9GQ0QvV1ZvN2M2U09WTE1jL0pjT2xIWloxNER0?=
 =?utf-8?B?bDZPK2FibngyRUxhb25qV0ZuT0FRRmZVVFNOZ2trZHlsdm5LTDY1SzhRbVpy?=
 =?utf-8?B?VTNkemdYV0ZwOGg2UFMwWlJJQmJFWTM1b2hCRDZZekRzWFd2L3QyTk12Ri96?=
 =?utf-8?B?MFdrS2h4SHlVUzVlMllJNmRqZkkxMmlOZWduK2lHMDZ5Wmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4705.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGZHS3dKVlRoellhNTJ5L3NkOVVSbW9wa0JsQ1V6YzFZeGp0U3p5ZWVocDU1?=
 =?utf-8?B?cGpUWDlCMVVEVmwwWHllMzBYano2cnhtMXhTZFZjNEJLWWdsSFlFbWxaajBO?=
 =?utf-8?B?N09OOGF0c3lQZS9RUGdZbk42NWM3eDN3MUJnVXJUNVlMTm45czNMY3Z4OTJN?=
 =?utf-8?B?VzhpMU5MSklWLzV5MjBQTmk5SHphZmVaaXl2a0FXdnZSNUt5RHZ1STRXaVFn?=
 =?utf-8?B?bU9NUnJBblkwbmdtL3A1SkxzR1FmOXNFRzVoLzBRVU9XUVVYR2VQR0FCM29Z?=
 =?utf-8?B?WFlidERSMHdXem51N1NJbi9JN1Z6MWVxNVVvbGtRT1dSM25oNmVXYTdOYzdC?=
 =?utf-8?B?Yy92bUxrRStQVWR6REFXVzZneDJwYUh0WU9rYVQ0RVlIUjhpM3RNU1JzaEVR?=
 =?utf-8?B?Ly9TYUdOTUZxbG14MlNuRjVFazVlUDYwdGNQZnRCZnZoWGJnVmFpTzRJUmlE?=
 =?utf-8?B?b0ZJZmRHTGcyNHROOXI2THNVb1ZOeTZBekRZRnRzcWYvc21Cb0hwTGkvUjkv?=
 =?utf-8?B?TXpEcVFEdEFDVEpwc3I4bjdBT0JtbUtUTFR2QnBPYVE2a0dYRXhuR2Fxd2tv?=
 =?utf-8?B?aE9KU2pucjVJazdKUFJxOEVScTd0M0NPdmJkYXJpenA2N0tGN0ZTQUxpR2FW?=
 =?utf-8?B?Tk5GR21wU1BZRU9ZNDVrVm5Dd2s2TStkTGdTTjNEby84M2FFcUFtUDUyRG1D?=
 =?utf-8?B?Nzd0djRPOHpjdkZXcTJyd2FkZDZQaXluWDNjN1A1T1RpVmZZTHh3RjM2YUtF?=
 =?utf-8?B?RENsUnhNVy9LeDd4VjVuS3FsYkl1S1ZUUHhZTytleXRlSWdaa3NCQVk4amwz?=
 =?utf-8?B?Wkd2eitkYk9rQ2l3K3phZU5JRjNQbEU5bTJ3MXVkdjlob3RsUWg4cExCWE9P?=
 =?utf-8?B?dExqSlJtMFl1TmVic0RqWWlTcjJnUm5PWHRVdWdwc1cxakY5aUxwTjBlbWNz?=
 =?utf-8?B?NkhUTmQ3WEUyUS9pWHNoVHhvYmY4bEVDTkVHRVNCLy85cTJ3MDlhTUJNUjNR?=
 =?utf-8?B?QUEybjU1K2o0dm4xMjdscjR5dFlvWXhENXdYeURYZ1ZncTBFeVlTdlUwMCtu?=
 =?utf-8?B?N0Q2YlUyTE5OZHZyeXQ4ZlA0MjFtQko4SXFkMTNwbkxad01kN1VxVml5S3po?=
 =?utf-8?B?UEcyVWk2Q3h6bDErT1pNK3M2MmE0QmhLNEQyQURYOE5XWnBnbU9QcnJqWEZC?=
 =?utf-8?B?Ylo5bTdKZ3ArekVvKys2UGNyRFNWTG15Z29ka0JtWW9mOG9iK0IxQWljV2xO?=
 =?utf-8?B?ZWhoZ0lKQmN1cDE3MUpQeHh5YXRyREQvWmJpU01zdEdsUmRDNWh1RHBwdEtY?=
 =?utf-8?B?TE85RnBOMnVoN1pJM1l3SHpDQXpHZmU3ejk3NU1HdFBWeGV2MjRDQzVmNEZF?=
 =?utf-8?B?VXJzYUFWaUM3MTFUOHZ0SzFXd2p6TkNidlpDTkhPSE1hVmdqNkJzNkVEMk9Q?=
 =?utf-8?B?eFd4TE05OGVCVXYyZ3d1ak14enNodUdwaDZhbEUyVkVUWU1HaHZOemtDRG13?=
 =?utf-8?B?UDV6WTN2MEtzZzR6UktyN0wzK1Fqd3V4cFd2bkNIQVM3aTNmcW9sUVZ5YzNY?=
 =?utf-8?B?aXNLU3pMUFNJeHNsZ2VBM09vcmtwOHpjckRTVHlIanNJdVNPbVJ1ZFlnYUZN?=
 =?utf-8?B?QmFEd1MxRndYM3h1dWZrNlhQNm9qTGQ4NDl0TzZWczJrZTJ5S0JXNWRCbFVl?=
 =?utf-8?B?WGZEQVE1ZTlSSTVpQ1Q1VEpSZGdJc1ZIUU9ScldnaW9xZmFmZkpBMU5oWW4v?=
 =?utf-8?B?M2RIcnNhTk96aWMzTWhINUNFeFMrb2Irbm5DWmtpQXlIWjZjT3MzNEM4Vkx1?=
 =?utf-8?B?akF6MU8vc2RHMTBLcFg2RHlSSktuaXZoMFU2RXlLWGhHZmJzTWlwTmxxaEhI?=
 =?utf-8?B?Z3NCMnlvR0F3ZFErUnMzY0Z0V0JTUUNqa3BzczIzQlAwM2YvcjZNSGZ2NXI3?=
 =?utf-8?B?SW5GbXZzY1dpNERodVZUQllSMXptd0E4MHZiYW5Zb0NwR3BWLzhTZXp6RkQv?=
 =?utf-8?B?QlA1YUM0NEJHM2QrNjBOSVNsekxrZGo5dmRRYXUzazZ4V2NxazlLYWpHanBC?=
 =?utf-8?B?aVFtWEladlY2TkNGR05rZUdleGRqMUtLTGtJQkdnckRRd2IvZjlpQ1hteUNv?=
 =?utf-8?Q?oR79uau/yi7282TB8Yj6WqdLX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4705.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b166d3b3-4685-4a28-dcb1-08dd5759948d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 18:07:21.2259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gv1+FPMnhhLU4fn9wALomCDxfnwFiHRXYv68DD8xOUmexIglKmvwexBXk88J8cTptk0McNvjdSzBkknnyvdvp3UyY+3GiZLr8kXNvX2tLno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3861
X-Proofpoint-ORIG-GUID: bUV0dI3Te-TDnKZuh-kb_6YapYU6lOVc
X-Authority-Analysis: v=2.4 cv=UIYnHDfy c=1 sm=1 tr=0 ts=67c0a9dc cx=c_pps
 a=OxY2RB2sa7x8oI2LU21LDQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=TAw2ZXUSRuuk4DcHb60A:9 a=QEXdDO2ut3YA:10 a=n7t-bZHm_Z4A:10
 a=ZXulRonScM0A:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: bUV0dI3Te-TDnKZuh-kb_6YapYU6lOVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
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

PiA+DQo+ID4gSGEsIGFuZCBhbHNvIHlvdSBzaG91bGQgYmUgYWJsZSB0byByZW1vdmU6DQo+ID4g
X19ydGVfbm9fdGhyZWFkX3NhZmV0eV9hbmFseXNpcyAvKiBGSVhNRTogcmVxdWlyZXMgaW90bGJf
bG9jaz8gKi8gaW4NCj4gPiB2aG9zdF9jcnlwdG9fcHJvY2Vzc19vbmVfcmVxKCkgb25jZSBpbXBs
ZW1lbnRlZC4NCj4gPg0KPiANClJlbW92aW5nIGl0IHdvdWxkIGJyZWFrIGNvbXBpbGF0aW9uIGZv
ciB0aHJlYWQgc2FmZXR5IGZsYWcuDQpodHRwOi8vbWFpbHMuZHBkay5vcmcvYXJjaGl2ZXMvdGVz
dC1yZXBvcnQvMjAyNS1GZWJydWFyeS84NTc1MTUuaHRtbA0KDQpJdCBpcyBkdWUgdG8gbG9jYWwg
dmNfcmVxIHRoYXQgaXMgcGFzc2VkIHRvIGZ1bmMgdGhhdCByZXF1aXJlcyBpb3RsYiBsb2NrDQpJ
biB2Y19yZXEtPnZxLiBFdmVuIHRob3VnaCB2Y19yZXEtPnZxIGlzIGxvY2tlZCB2cSwgR0NDIGRv
ZXMgbm90IGFsbG93IGl0LCBhcyBJIHVuZGVyc3RhbmQuDQoNCgl2Y19yZXEgPSAmZGF0YV9yZXE7
DQoJdmNfcmVxLT5kZXNjX2lkeCA9IGRlc2NfaWR4Ow0KCXZjX3JlcS0+ZGV2ID0gdmNyeXB0by0+
ZGV2Ow0KCXZjX3JlcS0+dnEgPSB2cTsNCg0KVGhhbmtzLA0KR293cmlzaGFua2FyDQo=
