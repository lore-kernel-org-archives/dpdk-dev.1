Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76FC7115A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83EEE42796;
	Tue, 17 Jun 2025 23:20:36 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DD0C3400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:20:34 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCAT8j001401;
 Tue, 17 Jun 2025 14:20:34 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b84t99qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yma9MfPpOTEc5Xh6EtO3fsvUw3VvvHz7NdhaDMkntssFklDwn9Qsp72wYhM/lDysSvXHiXTJ4CmYEkUSeacbF8u+QPfdmmUujdo7W9HwsYjdLi0i+NV549MBQiK0gOU4XyYkekXqBW2M7sr3u4a2ifLmLFmmix/nFGMVD3GUp8qOw/4Z4sJrvzatt5SJhSkplsgQuccZ4n90i/AKD3ztxfxppumjJ2EiObqJnNd+zpaesCo6c33mKdqN1lXABAvzNMCMGA3oLoTh/7RNgWWHHsrYiTd3ysK7NdQkDkBIIgk/HIQcj/qZaTaPLBa0AlmHik4z4Elpj2iy6Fk1u4jwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDzCN40iC9FAmBVq5mCzwPsrPi7dTXG640lmvRjwjhE=;
 b=Nw3wOZu9kwtayiw7ryTtI685NKyoENF6LuCEAR6wjrnMGYwdFs/6VBbqdXg6k5oe0RsX9xbmYO/44lJMH6JRm6j3CS8pzmVjlJgJHXv+9ipHGopaBHS88Vgw1CBPeajoROOUe9A61ow4f3hwrLD/QoqP9Efo1DGN5Ok4rPeDpqPGNviuftEjhk5JgefiKebRgAGqPQhSrQjHYf3WlvDpEPzZ9fN5rmQbm5LaJVYI9OT6i/Yh+5NJYudHYb4ykk+j/OUTedYjAlGraa1NVrQh3sB5+O1FaNUJ6De5DmFy1EGFjXJFmLm5GWgeURJvnAJ57tw9UhwUQA2DQBj076MQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDzCN40iC9FAmBVq5mCzwPsrPi7dTXG640lmvRjwjhE=;
 b=OXRbtgmm2LmTV/XO+JHTp4ZSacaSytFYv6N8lLSy3YK/4fEwgXJEr74mU+FO+rjwCzrzqeYOY7jFS0Ds+8FmXVa1Mp0dAVFKPir7b+POPL8RE3qC/8GpPm8/5vHis95KHAeRH7Io1NHSL0GxjWN+VFh0bLlvTSR4RTneYBeeoVQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB5086.namprd18.prod.outlook.com (2603:10b6:a03:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 21:20:31 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:20:31 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [dpdk-dev v1] app/test-crypto-perf: remove unsupported
 test cases from perf json
Thread-Topic: [EXTERNAL] [dpdk-dev v1] app/test-crypto-perf: remove
 unsupported test cases from perf json
Thread-Index: AQHb3FJV598AAy//PE+sMhxf7e1VILQH4ojA
Date: Tue, 17 Jun 2025 21:20:31 +0000
Message-ID: <CO6PR18MB4484F0EBC0DD7A18F53368D6D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250613110001.350767-1-kai.ji@intel.com>
In-Reply-To: <20250613110001.350767-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB5086:EE_
x-ms-office365-filtering-correlation-id: 15cefb54-9831-4c0f-461e-08ddade4ca85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzBCQzQ0UlJ5WnRNc2lBSHcyL3pDME5kRktaYTI4aE5GbFUzeDdMRDB6dHo1?=
 =?utf-8?B?ZEw0TmIxSUd0L092d1poRzNJN0RrNW1OV2d1VDlzT0k5YUFRVVRma0VqdWhs?=
 =?utf-8?B?b1U5WGlZV3ZxSVlaR2M4cjd4Z2Y5WVlhRkZhNE1ZSUhENGMzQ1V2T1ZjTmQ2?=
 =?utf-8?B?WUtsRFQzSzhSQTFMNTc5d1lpUTRGbzgyRDA3ak5FVkgreVpnRzhCQkw1YjJK?=
 =?utf-8?B?TVZENThzQkFZR21kdHdZSHE2QlJ2V1FmYW9pcERMU2haTlA0YmtOWXNodDdD?=
 =?utf-8?B?WktBSUFURHhvUjJjenJDdEhkOFdJM0F5VEhuYnI1NGhyMXZFdzY1SnFSTDRF?=
 =?utf-8?B?S0p4bjJiQkZwNlByNW90dy8xTkdncVdCZExpQ0NqL1JrMGVSRHduNGp6S1Bh?=
 =?utf-8?B?OTZPSGtaSWFqUzFSRlJVY2pXZ24zRWJicWhSdmFxa0hqbUNvaU9BWVFxWEJt?=
 =?utf-8?B?cVBZcFJiT2JHNWFYbHJVcnhCV0wzWGlmYkxOYTNGNUMxSW5FdHQ1L3BObUw3?=
 =?utf-8?B?WFI1TzNWM1JTbjZJUDZ6c1lFSzg0YlJoNE5kU2x1WWptVkF4T3hOZXRkVmZG?=
 =?utf-8?B?Wk1FN1RtclJzWVpWYzlBTWJhKzJFTmJaVllhQURaMlRUM1h5Z05obFE0Q1Zj?=
 =?utf-8?B?S3QySWp1WVNERldmQzY0SFY2bThRakJvemIzalNTOWdTWnJIZXNiaWp4SHkv?=
 =?utf-8?B?blZJUndTYkVBb1poaWdjZGNsV0VrQlY5dG9rQmp5SHJ5RDhyczBnR3MyM1ZL?=
 =?utf-8?B?dit2bk5oOGVOcGNCSFJicXZoTy91T2xtSENheFZ3QllpQ3BJWWZGTm9QZHR3?=
 =?utf-8?B?Q1kvdEc4WkhxVTUrTFlSZWJxL0tSbVdMYTRuYUprWWRnU3NJd1M1dmR5VWtE?=
 =?utf-8?B?TTMzOXJHQU9yN2VaRnhlY0hqMFJyMCtpZTgvelBPTWRwZWNqYXgxTk9keUFl?=
 =?utf-8?B?bUszWTdsQ0YzeHFjdWRYa3dBTVRoZTRRN24xeWlDYmovbVFaYk1OUjdPZmhB?=
 =?utf-8?B?T1g0V21rSTFIL0NWT1FTZHV2b2lGbSs5dG5zYnhJRXJzR2MvZkw3YW1qK3ow?=
 =?utf-8?B?c0xiSkordFhFeTR4bWJPL2QyMzRueTlmTFpaOVNUazBubmdzUWJocGdKMHln?=
 =?utf-8?B?NFFuTE0zN3NJcTRtZU9rWWViOXF5bExScytvOUwxaDVPOWNEYnUvZnRzbTBp?=
 =?utf-8?B?Sm1GRmR5Uy9MVlpyVTVka2pETUVOZ2kweDlOUzZSM1hPT3dzSk1ZV01CVW00?=
 =?utf-8?B?VjVZOUpSUjd1WFUxc1dsR0ExQTJUNDNNVUp6MFpoOTh0cWEzRHMweXBqeTVw?=
 =?utf-8?B?ZU1yYmlLUExENUhubDBBSnV3bXhwQWcvN0FvK21UZ0QvK25vbC8xcjdBTTFa?=
 =?utf-8?B?aHE2Z1BzQTdUNlBEMnE2d1NCSWw5VWN4cm5nL2FnS3BPMnh4OVR0ZVlLbXRZ?=
 =?utf-8?B?UnZQS0Y4Z2xRdzd1cVA4a0htZ1JET1NjeUhiSDVrZFdWZG1xUm9MTmFLa1JN?=
 =?utf-8?B?amd6Q3J4SGpNQXFHTmdyMWpER0hYaXpHaU5WK01GS29STzUyNmRScUlYWXdH?=
 =?utf-8?B?eFpKK2hRcUJGQ0M3ZWxROVZ4VGNqQUhBUzJlM0pIZWNBSVUydjQ4UDlQdW1D?=
 =?utf-8?B?bTd1QmI5OFVuNDZOYmRyM2xKejcrenRubzBIclRxR3M0RG1oeUJKT1FiMEdo?=
 =?utf-8?B?aHJkN3NYWTZuZmMyTk9aOXhUTVJReUpobG1nSjR0Tnl1RUU4ZC9vcU04UlZE?=
 =?utf-8?B?dkpZTDkxY2tIa05JNDU0UmRwMkJJRHBJdmtqNHlpenM2V3dxT1AwLzA2WWdS?=
 =?utf-8?B?RmRWcHVaUVl2bFlHa055WXBsLzExUFd1Q0gvVisvRGVtNHd1RStZTUEvcVU0?=
 =?utf-8?B?SDREbnlwRmJNQ0JXOHh0SWw4UldVZGZXMndRZ2pPZ2tsaXJWeXNxVitZS1cz?=
 =?utf-8?B?WUxxekNlY2RZSGYvZFlxK0dRVHVUbGJYb2psUkxlcW8zc2x2TXFKd3JDVUZu?=
 =?utf-8?B?cWpzSDJSdGNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akxZUnRObUJ1WFFiSGxpMllURWdXaHpJdVd6S1B4Z2txWWhRbWRFcjBtN1Qz?=
 =?utf-8?B?dkVnclU3RXFnMnBlMUNVRGJKT1pqdEZDTUQvd013WEJ6M29ud29aSCtlVndm?=
 =?utf-8?B?UnBqV0FxY0Z5dGhINGJtT0xsSDIxRVlDbXVId29KL2RiWlpzZ1R3Yy9OWUp0?=
 =?utf-8?B?eDAyejBucmg5MnlWMHRZR2prMDZuWlpKWVB3NGM5YjJtR2pHdzlFdFJEY3kr?=
 =?utf-8?B?bkhmRGQycDUveFE1QmpTVWlzTjQ3eWw2TFNmTWJ1YVdQZWt2Y3hEemd5cnQ2?=
 =?utf-8?B?Mmg3REZCbHBnV0RRM0hCSWRkS1hHdFF2aHk0NkdWbWZ5dk1kUDlLNXNPdmE4?=
 =?utf-8?B?ZWk1R0prU3ZydVNYT3gwVDVmWFRjakFWdDVMQVAzMXQvMGloOFpNR0FIZzlk?=
 =?utf-8?B?ZWNQMGNmYTlwNDlPRlViRjBCN3RzeExoeU0zWVdlbVVZL0xTU0p1aC9XazM4?=
 =?utf-8?B?b3U0Qmd5YTRGajFyV2VNd1hKTEgzempzSHNTZTIzSGU5WXlzQXNXU3R1VlJi?=
 =?utf-8?B?VkdzbE4vQVZSK3ozdzRUejdxUzB4dnRXNElmQitWSWVWVU1YVGFjbmJ4Vldw?=
 =?utf-8?B?VEpzWCt2c0VqZy82ckMwVGxqVG9Uem9XVHdLa1VQTlFDREh4RWVQbUM3RSs1?=
 =?utf-8?B?ZHozcWN2enZWSkxBWW9qUFBoZkJIRUp1bmVDaWRydnRVQklKbkYrVlFISmJ0?=
 =?utf-8?B?azBFZ2VFUVBSMU9NZ25MU3NwUGhwOEpBRmRINEljQ0crWkthUktrNGMraVRO?=
 =?utf-8?B?U2YvdWJQZHQzcXQ5R28xTjkvT0JDd0V3ajFVSHd5WGFURGNOamREQmY3MzFV?=
 =?utf-8?B?Mlh3bnpxUU1sQ3UxbHI3djVaVzk1azhWUzN5dlQvRE9uOU1BSE40eUgrbVpm?=
 =?utf-8?B?MzcxZUVhSmpKMkxXQjVDak83c1M0dWtXeDMxWEtxRlVFeElaZXJHbXZMRGxI?=
 =?utf-8?B?UEh5dFVCM0V5K0RHcDQwcU8rN0srUWljNHp0RngwdmZFUXZRMmdXUWR0SjZQ?=
 =?utf-8?B?NkovSFJoOG80VS91VGxEc2dDRjRtOWw2b2s3Ym9tNWVZeWVMWDNyNHBJd09F?=
 =?utf-8?B?akJvc3l4TjVPY2MycWRWREpVbzZsVWxHMFlPeWtOZEUrRXhxeEZ0d0x0VGJW?=
 =?utf-8?B?UFN3N2ovZjVXUVlFSnZ4WGxURDR6UW5BVWE0U3d5dWhBUzhyeG5ERmZ2NGpn?=
 =?utf-8?B?YnQrcFlpUUxJWGpCZUl4Q1RSQ1BoN1VtUXBsSkltUFh5TTlObDQ0Zm41OG02?=
 =?utf-8?B?UnZkUWJxdm5oby9zdkViZFVudWUzOG1iOVZpclQwdUpSUC9jVUNRMFgrN1pz?=
 =?utf-8?B?RGdHeCtFKzI4ZVd0c20wNEVybmNGRWtyWWo3b0syMjk4Sk9FVFZhbnFHK1dq?=
 =?utf-8?B?T2R5d2dyNkkrb2ZxdDZQK0lsQW4vQk5UQmE1RWpjbEtnYzM0NkUxajBLV01Z?=
 =?utf-8?B?c1RtVk1SUHZETHhINHlPZXFGRXVDVGNnd1dyZUx6aTdiZE02ajh3emZNOUw4?=
 =?utf-8?B?U0czYUZyOU5HbE5JamYvcWY4dHZvb0RnNDB4NHpxMXZaNFBkRUpBZjZLaEp6?=
 =?utf-8?B?UjFaOUVHRnkyV0tuSXdSN0lQUytuQmVwd2Y2NVV0UlZBaDY4WG1RbUtXTm1y?=
 =?utf-8?B?WnBpQ2hJWkR2N21uSE9rOWgxTkpEa2ZmLzBHUkVJTkhCUU5mb0Vrc2J6L2hn?=
 =?utf-8?B?dUhPUU5CWjQzbzFiVG1KOTQyNVU3WXl5TWU5Z2hHaEtyWFRXdUVLUzJLc3VF?=
 =?utf-8?B?MmVtOHZZdlJLNjZCSUorNWNiMitMK205K2wrSEFqWVF4QnJFMXZmMi9ybmh2?=
 =?utf-8?B?OTRDeWdoUFk2clArSkc5Q3ZUV0JEdWh5S3dVdm5yd2t4RlQ4aUNDOWZUVFhM?=
 =?utf-8?B?YjJOdzdxTkR6amF6UUJKUmRwSHN5aWdqZGtkek9rOWlyWmpzNmdNcnV5YVIz?=
 =?utf-8?B?MUpVd3RueXFoclFHcUp4OXQrcVVTdXJSc1JjS1ZIVHhGaUFTRGkzOTVWaHZK?=
 =?utf-8?B?N1hINzZHU3lReWxSZ3dOazJqdHUvTmNuUXRVZ3FYR3RpcC9mWmZ6b2U3ekNz?=
 =?utf-8?B?Nm5LdmN4ckIyTXQ5RzZseFVUN2lUV0NabTBjL3dxYXhVbmZEQWlmY2puWENx?=
 =?utf-8?Q?BoIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cefb54-9831-4c0f-461e-08ddade4ca85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:20:31.8137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoLjYkbXhSZJT2CtzPHN2dv+F8bj7M4We31nUDt69IHS6MQ6iGXCxe4ZeSpmB7sHq94HYptv/taIU5GY/AnOtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5086
X-Proofpoint-ORIG-GUID: 3siUfpHnnG7L7ZvekKjGTxAncJDH6IGJ
X-Authority-Analysis: v=2.4 cv=H6Lbw/Yi c=1 sm=1 tr=0 ts=6851dc21 cx=c_pps
 a=7UXMxuOBat4+6yczhndhEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=jILgV7x5WoZSwjIC4YkA:9
 a=QEXdDO2ut3YA:10 a=XqwKkIuMdFcA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MSBTYWx0ZWRfX7lwetI/kHLHj
 HKRkeSMfYUPeOVkWfWHm0fNnpcsZDXNmSCPPnNJce3q2ntABbJA9EUIznYJ6CCbBB9bMULjEcIu
 JEA8jdLNbcAu4g6pUlUhSwZIC8EGaLGvWn8SCuzZl4kxsXXG1U3GpP89I0vrj8IEMIdf+62sjWw
 u1pgxwq5Sb+UALhTMHTf+qCppeGBq/N48mb7SNWpcPKdcEKWIquZZFI/XNeEceYz4yo1WjJ8wTB
 Gpw2njRV2/MHyV6K/tVD0xiePh4Wkzu4V1bomiF+Xf/RdCQBTdJ0p78eJvVxtwiXDbp+gJfaM/w
 XA7t8gwJ+foAP4v0HdY/tk7nFqcFGVRE8bwABW517GGw8QZLASTATSOlZkomcVDJwcOYUYcFsxM
 DQ4FJraItTEH+WWVdx8Lkb0sMLFqudsaDIE+bFlt9tTOUaGjwx2HKZ6ZlZ0PYE4RnMh+qAYW
X-Proofpoint-GUID: 3siUfpHnnG7L7ZvekKjGTxAncJDH6IGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

PiBSZW1vdmUgYWxsIHVuc3VwcG9ydGVkIHRlc3QgY2FzZXMgaW4ganNvbiBmaWxlcw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRr
LW5leHQtY3J5cHRvDQo=
