Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD272C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64944025D;
	Wed, 14 May 2025 09:11:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 48BAE40041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:11:42 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNU2ld018705
 for <dev@dpdk.org>; Wed, 14 May 2025 00:11:41 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mft50pr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:11:41 -0700 (PDT)
Received: from m0431383.ppops.net (m0431383.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E7Beca009172;
 Wed, 14 May 2025 00:11:40 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mft50pr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYwaJfw2uDiKeUoJfBX2CIoQbbrpqnyTIZYAYW85ZVKn8TTkW4ywrjdeX9Zg1vj6IKG5oXfhaD1fSeZq4sj0Ji9ZTkyvWrk4ut3iKmo9BTlefQnWyBBkpbgyAxs6i498WQbwA74/wlOPySfIbnn9uDX8zHkX7KSQPLyjQzoPvfydrEXHoPMF3Bc7/ecekApmBe4dgtNhyXnet6j3efpXurLI5yv800Oqq2CSH0Q5lxDfgEh8OpWWPhnlBIeO4WueODr4uBAK5HJoEYuQFyyY6QYC09d/cwBhYh6JEe7DEFdLtU92lzYEQ68Ag1zSPW2I/Cr/laEIopn54bjCAacpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY5lavIIBEoZHD755OZCDEgCtsnNffyNlZQi6AUPbaU=;
 b=bB5WyyO/RtdfJ5MCGh4dW3fiDPi96tNEwx4b+gVPc45Br/Zk3rbKq5sQN69NMlKtGcIDlHpWGxIPBH3enpbH9q6sV42cIAGq/NL1RHlwk4AtzFNu0NOB0G0MSircQ6cy8KWcYU2RXIVuvUc6mrhL/YhsQ/Jlhcfb4GkVL36ZICHGhP3mPXwfZV91TBShN+JznAcKbJoQhMrmSExX378b92+jim9uA0ymQ6oYT8FEzkc2No+n0dTiNlXD1FHqIg5WlMVzikj3Prso5t5d08/TKjiYi8nH92Nx8yn7MbOp0k3FlqSWaAt+ye/chNzzeNMk4JZ7CKpRHr47DVJMxQivcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY5lavIIBEoZHD755OZCDEgCtsnNffyNlZQi6AUPbaU=;
 b=S4mvkTlQIFSus9uNW4wb4PnMFkUwCQgW7wLlu3HQR0z7bx9YdzmsePpkfv5kD7rmXMqJS87YWZ5CUKi/lNjCtGS9OuXcz80km+a/PrwF2TSwxT8/2R0ukU/A6P1CGgjiq/y2zF0Y9HpvPoa5OrGHbHdPkIvc5jNxh05kBrtZLYY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA2PR18MB5851.namprd18.prod.outlook.com (2603:10b6:208:4b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 14 May
 2025 07:11:38 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:11:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 4/9] crypto/zsda: add queue pair
 configuration
Thread-Topic: [EXTERNAL] [PATCH v2 4/9] crypto/zsda: add queue pair
 configuration
Thread-Index: AQHbjBgwm6P4yt7dZku71zuWvx5aQrPSJiLg
Date: Wed, 14 May 2025 07:11:37 +0000
Message-ID: <CO6PR18MB44840E1AE8CB42F9841D0263D891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-5-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-5-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA2PR18MB5851:EE_
x-ms-office365-filtering-correlation-id: 6cbac397-b996-4d6f-4d6e-08dd92b69189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cDhpMENXWVhyTmFrWVJESDZ6MTZjMmQxR2NoclEwQ2JpancrN0tNNnhaZ1Ax?=
 =?utf-8?B?TmVuaEdZQ3hFdEYxVHMxL2dyTGI5K1owYTBUaG5Fa3BObDFqbmFxdkhIbkNK?=
 =?utf-8?B?WDAyS09QQ3Jaekh0aFJhQWFJUm5aQ0ZjZTUwbXVwTm9OSkZoY1JLSUE2Ylkv?=
 =?utf-8?B?eUN6eXJpZW9NbU9PZVY3c0hzZnErNnk0WWJFU1FhZkNTQU5LYmdickVsM3hn?=
 =?utf-8?B?dUxwZUtLNE9zbmJ2TWRjRGo2cjNCR2lwRlNBbW5DMmtTaXhaUXFKckdwSy9K?=
 =?utf-8?B?NmJMWXVEZXlGYmtwbGtXTVFUY2NBUXNqbXc4dGsyMEMrMHV6Umc2U1g0OVE1?=
 =?utf-8?B?SktMMDErNGJIY0xDRk5nVmRIV3VwSVJJUGhReFcySGpCR3NFa0xaaG01NTc2?=
 =?utf-8?B?UkdackM5UFlmOUZkbXpjdUtPbmQzdnI3UnRIK0t3WHlzbTh2NWEzLzA5Sm1E?=
 =?utf-8?B?b3RWaGYwODZGNGxPL2hKUkJZd3E1RXB2L2U4bXF6OGJBM2ZEYzJRd1lQUFpy?=
 =?utf-8?B?QmRsS25VTzBFdXV5TXpXaFpmampVeTVTNkM5MmgxMHJET0NEWlFoZXZhOElC?=
 =?utf-8?B?S0xPaFJXTXBlUDdUajliOFlKaWZHVzFQOWVhNFMvSkJTTnMzamt4Qzl4RTFG?=
 =?utf-8?B?dE1yMHQwd2R1OUVKRWQxT0hxNWUxMkFUbWw5bGhuUFhTNFlQVSsrNjlreDlr?=
 =?utf-8?B?RDc1SEhOcUs2R2lDWjdyTCsvWlpPaDY4U3VWVFVET3dqS1FWSVoybHVOOXNw?=
 =?utf-8?B?d3lNZHg5WjVQcFRibUUvUjlJNlVwc3ZVendXdVVMY2x6cWJwZ2Fib0R0blEz?=
 =?utf-8?B?QkJYNW1rbGptTkcvUVlIaGRnSVNscm9rZGR4TCtMMEp6dlJDVDRPcWR5Snhn?=
 =?utf-8?B?TSt5azJqY0NJZkJaR01pUVZmMXZReEhLRTRXMzdzL1NYbDJ6RjQzdm9HYmVu?=
 =?utf-8?B?RFM4WnluRktUZTJkVnVwQ2lzZ3IxYmYyakcwQmVmVTBrRndPTnBOUmVMNHYw?=
 =?utf-8?B?TGZrZ3ZxR0NQMzJ3NHFwM2wraHJOcVJGMU5xTXpzanJpMGdaYXE2aW1YTlg5?=
 =?utf-8?B?ZmR6QnhCWVR4OFQ0bjk1R0RwOHJKTVZIdTR4bVp6NFo3U0JiWHRyN0RaVEhk?=
 =?utf-8?B?bTgrQ05NRmExcVU2cVFFZ0kvMWFvOE9sdHh2Wm1EeGhJSXhubFZUZXl3MGNp?=
 =?utf-8?B?dkdiS1hkUS91bWNGSVpHVWVqMWZtRm5oZUJCWmRIK3ZWeVJ1UVo5WXVKaDdV?=
 =?utf-8?B?ak83VG1NS0wrUnJKaHhmeVhtTHEvazNtdlFQbUhiOVhpaUtsNjIxMzJ1c3lK?=
 =?utf-8?B?eFRzMlJNZkgwcWc2QTd0UXM2QWFvOEROblVKU2tDOFo2SWh6SWN2V0cxK2xM?=
 =?utf-8?B?Ly9LZDh2RVVDTFErUTRVWGNTT2hoZW50V0F1Z3FReHRHMi9ET0VtWU5wNmtI?=
 =?utf-8?B?ZG54Ri9uUXFsblM4QlQ1cHN6OFhDRzRKTTFBTFp0MGJRS1RDV2ppZ2VWRFpW?=
 =?utf-8?B?TU52eEd6Y3hxc3hCck1NVk9kWkkxUmFGZWV4RUdHL1JDVFVsUFUvdHBIVC9i?=
 =?utf-8?B?QVVaZG4rbVZIb3pFQ3k4dUlqMXZHQnFvWTlyNHJiSUVLZlJ5M2cvWTl0Q0dG?=
 =?utf-8?B?ZXBlQjIxc2thQmQxajNxN0dKclZENUdFL01YM3ZPMFMrV0IrRy9MelFZUGlm?=
 =?utf-8?B?NUIxam5mNjNUb1Q5Tm9pekp6L1hjRXVic2dXdHhLb3BiNHhORG5kT3gzZUFm?=
 =?utf-8?B?OE5kQlVHUE1jQWZuWkx5VElLQlE1ai9Fei9qR0JHQUxoUkROVlg0bm5OTWJM?=
 =?utf-8?B?Q1pqVHhtRTkrV3JCWDlmc0d5dVplY2JodmZ1RTRITDBCQ2UwaWN3YlJtZjIr?=
 =?utf-8?B?VFVCM00yZkFYY2Z2NkJMMUd0cHdxd1RxSXdsNzRxNWtJaFBJVlY0VXIrNHor?=
 =?utf-8?B?TC9DQ05yR2pXcUYyVHBaSmRxd1ZMd2JIU2VMRk11REMrNEpSKzNwQ0Ivc2Iv?=
 =?utf-8?B?dzREMmhoR25nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emh1aEhqQ0dXdFB6dE40Y3M4TGFNckw5czd3MU9DVUZ1M1ZMYnlFUE5maXVQ?=
 =?utf-8?B?OGRBcHBYRGs4emhuUVZtNitLVWc4c21kR1NEaWRyR2hUOHgrc0ZlZktleVoy?=
 =?utf-8?B?MHdDVW5QNGtGOThYdjZYUW9tL0hUcjlsa05WaHFMZ0hTak1PMHVETGRPeWJ2?=
 =?utf-8?B?dmtsLzIzMjF4UDU4N3p3ZUkzM1pCQU1VcVJ3elFvTzViTVIzU1FveHQzVDJy?=
 =?utf-8?B?eE45ellYaGlLdkloVU9hdFA3WEVGWThCRHRDTHZVTkJMcXIzWHFkVno4Y2VU?=
 =?utf-8?B?QnNhOHpGZkNQcUNSbTE1ekR3RTVoTDRFT240TGtBYmJsaXdIaGxmNExwdTN5?=
 =?utf-8?B?WG8xVGNSZjlpNjY1UHI3b1Uwb2lQZms3eHlDTWRkL3FSbHlwZCt4NzZXWHNk?=
 =?utf-8?B?T1R1NkxITHZtSm91SmczMjZKU1I0OERoK2w0VVVsOFdVcUFQZlBHRzMwcWpE?=
 =?utf-8?B?Y2ZwNnV0bXpjTzUrVk5YMmhIMHVuYkhpRFJYRHRzaEU4YWxveFZLV0N5VUV4?=
 =?utf-8?B?ZWM3TVpVTDZOK1JaMENaUVRBTzB6SEY3bGttejZVRzBnWHJlT0RZeVFYcjFI?=
 =?utf-8?B?bnIzUFFpcGZPb25MVElSSENIbUNGZC9QOUJXNklSS0o0WWQrV2FRTUw0RUpm?=
 =?utf-8?B?cjY0R1ZISjdyTm5uZnJpQktUZTBNajZRSnNwc3FEbkl5KzBjcWNZczNleTgz?=
 =?utf-8?B?UklDcGtDVThYLzFhcVFlUVpic0ZpbjZjN1BFVXFNMDRua2JNMFRYUkYrNkwv?=
 =?utf-8?B?VXp6RlRhTFJKZkZ4bmtGWDRDNUFpaEU3R0pDZUtHR2d3dXNvUTZKUlFmL0cy?=
 =?utf-8?B?YStuK2VXeHJmTWRDL2VXc3d2Y1dNQ0NwS0xqbXNPYzdkczFIY1plRFhUL20w?=
 =?utf-8?B?aEYrNTZTR3dCa2dXRGlPYWVFNkJGcjVmWnIwaGFvUGVKSGV5dEQyUnZMaG9S?=
 =?utf-8?B?VWNtUzI0dFQ0UWhmU0QvSXRUNnhVNGpET1FNSFphMEdZRUVVeGlLcVN3clo2?=
 =?utf-8?B?UlFzc25mRUVuUWNDSFdzSjVtUzRIenBydElkWEt5Ti9wNGVkYzNGNXZpR0c0?=
 =?utf-8?B?VWpxMzcyeGlKU21RNmhKNERNOHUyVElJNC9CUlVqSStnVlVHYnEycWhjRTlI?=
 =?utf-8?B?Wit3T0YxNGZNREZscFoxWDhBdUFtREtsdXB1UVdYdDB4MWJlR2V1M0tucllR?=
 =?utf-8?B?cStGNHhycUsxS1hCM1UwWVgzbjQ5YVhWYjIzOVVEdU1XWG1uMHJveWJiRkgx?=
 =?utf-8?B?bEtVNDdjOHYydkZrTWRHUjNWcWNXWC9MdGJSODJ4azFDcUVDaEIyckx4NUZq?=
 =?utf-8?B?bHlWZmdLN2Z3dzNDeThtSU40ZW92aG1WR21PbUpKKzZ0QmlFS1U5dVZKUXBy?=
 =?utf-8?B?OUVjKzlQM09GZ0liaTJZNmF3Mno0OEhOQ1lsbVNEazdhd2x6bi82dW5iU0Vs?=
 =?utf-8?B?dWRSUGNzT0tSblU1emJwNDlwQXpHV0twSXVGWnlJbHl4QzJEeTBYNm9MdFhI?=
 =?utf-8?B?TlBMaTY1c3ppRTAwZDBYZ3U2dDUxempCVW45UmZJVzUzdFI1VUwvT0l3TkFV?=
 =?utf-8?B?YjlqUXpOcmtVWVI2VXhyZnl3My9aaVZ4RFh4LzJlV3d3WEx1MmRMZW1BUXRz?=
 =?utf-8?B?eDlhL1dmakppUHN3SWlXS0RTK1JXSm9lT3NjeU9Mc1AwMFNkUXRqc3lQYUhm?=
 =?utf-8?B?MHNFbW9VOG5md0pndzVsaXdLMnJ6VkFaS0xzOTcvalhWN2RHRk96M004WlIr?=
 =?utf-8?B?SHlxVlJML1lCblQrNUI1c1NjWFhMYnVvVVNTblh4SUhmNDVPalhlUzFtVGpt?=
 =?utf-8?B?STdIZjE3Yjlqd3d2R2VyYnhqeEsvL25WMVE5eVVXeTlKck1KUEJiNXZxWk1O?=
 =?utf-8?B?c09WUk9ERGp5UnBSaXJvcDFtM2l3STlnbjU5dGtKOHJqSTVBNVFscHZXenR1?=
 =?utf-8?B?akxPbkFvZDVHNzRxRHlUL0FhZGZ6QjZwcDJTWmtYejdWTXA0cWhJOVNxNzNL?=
 =?utf-8?B?aU8zZGx3b0dLWVpyK3hpakV3UVFsYkFHMDQ2VDE4MDZxdnRmY2dRQUY2V0ZB?=
 =?utf-8?B?VFZnY0hXSERkd3Y0QVdTTzMyN0pvUk5CQTEzWnVWeXJja0RmQ2FZOG0ydzJO?=
 =?utf-8?Q?jXUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbac397-b996-4d6f-4d6e-08dd92b69189
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:11:37.9558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbFUBmlew3pOlCdrtVei9AELAhbjyxJN9+lCYBvn7FgszRc84MJXDwQdgb26HtbNZ/9zU92pXw2Mz0VSbI34/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5851
X-Proofpoint-ORIG-GUID: 9DtKRebV6BBbOQkuNDHkgWLx988Pld7H
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=6824422d cx=c_pps
 a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=1RTuLK3dAAAA:8 a=HioEYCjVJYh9ptQyf9QA:9
 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: QQp98sW-RfvsShmh2xbyFj90jdgBeK2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2MSBTYWx0ZWRfX/C9f5tAPz0AG
 FIYrv2rzVUZg4FpWl7abvPSqQeRoiyQCsSC5uepNgw7uFItALERfS+iR8KAqnHVfQVNOuqM4dt1
 nBwv9zhG/DY1YYDyOxuVFqHxw/1Y70VyPEZKQa6rdU+qiZwELOzxP9iMeW8eTgbNEvyBGjH7V35
 CCah48wxSUL9QpqESuK2sXqaeZKg8ui5gim5T1qkVZ/AD9FJqOTSFc11FFTc2Y6U1tcTZzCB7Vo
 WGWCnADa2SNpBeYUkCtVaIidhmpuzfrMHSV4mIFGR4CQ2gmg4qs0xuu4eX5hJF9a9IMDbpfaqoD
 Hi4LrLzS2HPNrK6oADObvBqhCSyA0L5LP7rTLbyF+uSBhikO4ZVEz/K98TZCxk2q0+e1k8Kr1Bd
 GZpFE3SlwczJO57mOLgMx5bt5eyG/RuB5Nfop85U6IqU+CbRc6aZzAApSrYyI41AgN7ZCRyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
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

PiBBZGQgY3J5cHRvIHF1ZXVlIHBhaXIgY29uZmlndXJhdGlvbiBvcGVyYXRpb25zIGZvciB6c2Rh
IGRldmljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhbnhpYW8gTGkgPGxpLmhhbnhpYW9AenRl
LmNvbS5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jIHwg
NjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jDQo+IGIvZHJpdmVycy9jcnlwdG8venNkYS96c2Rh
X3N5bV9wbWQuYw0KPiBpbmRleCAzMWJhNTgyYjY4Li5kYWY0ZTljNTlmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3BtZC5jDQo+ICsrKyBiL2RyaXZlcnMvY3J5
cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCj4gQEAgLTEwOSw2ICsxMDksNzAgQEAgenNkYV9zeW1f
c3RhdHNfcmVzZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldikNCj4gICAgICB6c2RhX3N0YXRz
X3Jlc2V0KGRldi0+ZGF0YS0+cXVldWVfcGFpcnMsIGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnMp
Ow0KPiAgfQ0KPiANCj4gKw0KPiArc3RhdGljIGludA0KPiArenNkYV9zeW1fcXBfc2V0dXAoc3Ry
dWN0IHJ0ZV9jcnlwdG9kZXYgKmRldiwgdWludDE2X3QgcXBfaWQsDQo+ICsgICAgICAgICAgY29u
c3Qgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfcXBfY29uZiAqcXBfY29uZiwNCj4gKyAgICAgICAgICBp
bnQgc29ja2V0X2lkKQ0KPiArew0KPiArICAgIGludCByZXQgPSBaU0RBX1NVQ0NFU1M7DQo+ICsg
ICAgc3RydWN0IHpzZGFfcXAgKnFwX25ldzsNCj4gKyAgICBzdHJ1Y3QgenNkYV9xcCAqKnFwX2Fk
ZHIgPQ0KPiArICAgICAgICAoc3RydWN0IHpzZGFfcXAgKiopJihkZXYtPmRhdGEtPnF1ZXVlX3Bh
aXJzW3FwX2lkXSk7DQo+ICsgICAgc3RydWN0IHpzZGFfc3ltX2Rldl9wcml2YXRlICpzeW1fZGV2
X3ByaXYgPSBkZXYtPmRhdGEtPmRldl9wcml2YXRlOw0KPiArICAgIHN0cnVjdCB6c2RhX3BjaV9k
ZXZpY2UgKnpzZGFfcGNpX2RldiA9IHN5bV9kZXZfcHJpdi0+enNkYV9wY2lfZGV2Ow0KPiArICAg
IHVpbnQzMl90IG5iX2RlcyA9IHFwX2NvbmYtPm5iX2Rlc2NyaXB0b3JzOw0KPiArICAgIHN0cnVj
dCB0YXNrX3F1ZXVlX2luZm8gdGFza19xX2luZm87DQo+ICsNCj4gKyAgICBuYl9kZXMgPSAobmJf
ZGVzID09IE5CX0RFUykgPyBuYl9kZXMgOiBOQl9ERVM7DQo+ICsNCj4gKyAgICBpZiAoKnFwX2Fk
ZHIgIT0gTlVMTCkgew0KPiArICAgICAgICByZXQgPSB6c2RhX3N5bV9xcF9yZWxlYXNlKGRldiwg
cXBfaWQpOw0KPiArICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gKyAgICB9DQo+ICsNCj4gKyAgICBxcF9uZXcgPSBydGVfem1hbGxvY19zb2NrZXQoInpzZGEg
UE1EIHFwIG1ldGFkYXRhIiwgc2l6ZW9mKCpxcF9uZXcpLA0KPiArICAgICAgICAgICAgICAgICAg
ICBSVEVfQ0FDSEVfTElORV9TSVpFLCBzb2NrZXRfaWQpOw0KPiArICAgIGlmIChxcF9uZXcgPT0g
TlVMTCkgew0KPiArICAgICAgICBaU0RBX0xPRyhFUlIsICJGYWlsZWQgdG8gYWxsb2MgbWVtIGZv
ciBxcCBzdHJ1Y3QiKTsNCj4gKyAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsgICAgfQ0KPiAr
DQo+ICsgICAgdGFza19xX2luZm8ubmJfZGVzID0gbmJfZGVzOw0KPiArICAgIHRhc2tfcV9pbmZv
LnNvY2tldF9pZCA9IHNvY2tldF9pZDsNCj4gKyAgICB0YXNrX3FfaW5mby5xcF9pZCA9IHFwX2lk
Ow0KPiArICAgIHRhc2tfcV9pbmZvLnJ4X2NiID0gTlVMTDsNCj4gKw0KPiArICAgIHRhc2tfcV9p
bmZvLnR5cGUgPSBaU0RBX1NFUlZJQ0VfU1lNTUVUUklDX0VOQ1JZUFQ7DQo+ICsgICAgdGFza19x
X2luZm8uc2VydmljZV9zdHIgPSAic3ltX2VuY3J5cHQiOw0KPiArICAgIHRhc2tfcV9pbmZvLnR4
X2NiID0gTlVMTDsNCj4gKyAgICB0YXNrX3FfaW5mby5tYXRjaCA9IE5VTEw7DQo+ICsgICAgcmV0
ID0genNkYV90YXNrX3F1ZXVlX3NldHVwKHpzZGFfcGNpX2RldiwgcXBfbmV3LCAmdGFza19xX2lu
Zm8pOw0KPiArDQo+ICsgICAgdGFza19xX2luZm8udHlwZSA9IFpTREFfU0VSVklDRV9TWU1NRVRS
SUNfREVDUllQVDsNCj4gKyAgICB0YXNrX3FfaW5mby5zZXJ2aWNlX3N0ciA9ICJzeW1fZGVjcnlw
dCI7DQo+ICsgICAgdGFza19xX2luZm8udHhfY2IgPSBOVUxMOw0KPiArICAgIHRhc2tfcV9pbmZv
Lm1hdGNoID0gTlVMTDsNCj4gKyAgICByZXQgfD0genNkYV90YXNrX3F1ZXVlX3NldHVwKHpzZGFf
cGNpX2RldiwgcXBfbmV3LCAmdGFza19xX2luZm8pOw0KPiArDQo+ICsgICAgdGFza19xX2luZm8u
dHlwZSA9IFpTREFfU0VSVklDRV9IQVNIX0VOQ09ERTsNCj4gKyAgICB0YXNrX3FfaW5mby5zZXJ2
aWNlX3N0ciA9ICJzeW1faGFzaCI7DQo+ICsgICAgdGFza19xX2luZm8udHhfY2IgPSBOVUxMOw0K
PiArICAgIHRhc2tfcV9pbmZvLm1hdGNoID0gTlVMTDsNCj4gKyAgICByZXQgfD0genNkYV90YXNr
X3F1ZXVlX3NldHVwKHpzZGFfcGNpX2RldiwgcXBfbmV3LCAmdGFza19xX2luZm8pOw0KPiArDQo+
ICsgICAgaWYgKHJldCkgew0KPiArICAgICAgICBaU0RBX0xPRyhFUlIsICIgc3ltX3pzZGFfdGFz
a19xdWV1ZV9zZXR1cCBpcyBmYWlsZWQhIik7DQo+ICsgICAgICAgIHJ0ZV9mcmVlKHFwX25ldyk7
DQo+ICsgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgKnFwX2FkZHIg
PSBxcF9uZXc7DQo+ICsNCj4gKyAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
c3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29wcyA9IHsNCj4gDQo+ICAgICAg
LmRldl9jb25maWd1cmUgPSB6c2RhX3N5bV9kZXZfY29uZmlnLA0KPiBAQCAtMTE5LDggKzE4Myw4
IEBAIHN0YXRpYyBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9vcHMgY3J5cHRvX3pzZGFfb3BzID0gew0K
PiANCj4gICAgICAuc3RhdHNfZ2V0ID0genNkYV9zeW1fc3RhdHNfZ2V0LA0KPiAgICAgIC5zdGF0
c19yZXNldCA9IHpzZGFfc3ltX3N0YXRzX3Jlc2V0LA0KPiAtICAgIC5xdWV1ZV9wYWlyX3NldHVw
ID0gTlVMTCwNCj4gLSAgICAucXVldWVfcGFpcl9yZWxlYXNlID0gTlVMTCwNCj4gKyAgICAucXVl
dWVfcGFpcl9zZXR1cCA9IHpzZGFfc3ltX3FwX3NldHVwLA0KPiArICAgIC5xdWV1ZV9wYWlyX3Jl
bGVhc2UgPSB6c2RhX3N5bV9xcF9yZWxlYXNlLA0KPg0KSSBvbmx5IHNlZSBzZXR1cCBmdW5jdGlv
biBpbiB0aGlzIHBhdGNoLg0KUGxlYXNlIGVuc3VyZSBjb21waWxhdGlvbiBpcyBub3QgYnJva2Vu
IGZvciBlYWNoIHBhdGNoIG9mIHRoZSBwYXRjaCBzZXQuDQoNCkFsc28gZHJvcCBzeW0gZnJvbSBB
UEkgbmFtZS4NCiANCj4gICAgICAuc3ltX3Nlc3Npb25fZ2V0X3NpemUgPSBOVUxMLA0KPiAgICAg
IC5zeW1fc2Vzc2lvbl9jb25maWd1cmUgPSBOVUxMLA0KPiAtLQ0KPiAyLjI3LjANCg0K
