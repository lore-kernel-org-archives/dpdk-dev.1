Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E05CFCC9CA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C63C402B8;
	Tue, 10 Mar 2026 07:03:58 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B4F1E4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:03:56 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A2W0GH2564066; Mon, 9 Mar 2026 23:03:56 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022136.outbound.protection.outlook.com
 [40.93.195.136])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cs898v879-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 23:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+BY3tFJ7LY96mkm6NPQT10EtsPmtREbXk9O8OQlAX79U0MF4rT5oOM2QyzAGoNQntGtiy2Ndbp132PjI4dxHR/OBr6xQPzbtRdGiAi9+5L8FKpVOZokjqvokpw9CDMvKE6k7wI0j7YiLeHLBfjZ1ZjYVcvI3vO+Gb/uUZRb8VY+NkCaaVjLunhDK4IeozVisvkK7lDOWwnrO+y0F4jjjFh/abaqj2dmHAG4PEbBM1ucstBDhm2u5Ou1BNXOZZRPcwnJRS/1MqbGp3J5uTyBdzqgSxXnbjiioTLIBHjYaXexV54AGD3VnVtTNipyhoCjPRarbOA8FQKRCYke2isbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB2/AcIfytH70hE1p6QGraLMbG5c2szQZWCUxPZaGWk=;
 b=vW1SGc9eQSbudLYdVBsgMoLEJo1SI+XV0+WhO/GCYHwndVvtVLKJy8ekcouzr8OFlMwEYehjkZ9GOMQHeDQruwIUxKRNC9VixiWqkc2A7rDoqyhE3wDYN2WMD3g3opWEYXGOuH3kSG82JdeynXwwF0TyA8p9FeSt4RpmOGwDyzTjlzYq2yUWUecctIxH1gnAXFH5W5cNUCfAdkP99zt25UbKhhZtjHqCX/7CK/JyOnmwJSPPTzRA9AMKoQt+7MgjmIQSSDwDETQ7dI5z9SSkThH4a2ZeUY82dVe6KjS1rg1A5qiAzm3IKYz+g7m6rU1VhlQWdFF/mZa+cbqsBpQk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB2/AcIfytH70hE1p6QGraLMbG5c2szQZWCUxPZaGWk=;
 b=gyyfS1i9E4lf40e2NzDcZz0LFAfWl7R56IY2V/q1rOatFk/eVw9HR4UleFaf0uMWNlGP9K4hen615gVOs9v7impTv38XYnnwwKGx8khgJdupS6/ddgQKZ1UsI0+LbyeZ34cw3swydFlaQNMzoEle1Dtkg7We8Jk+oe3q1V0Ix7Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB4126.namprd18.prod.outlook.com (2603:10b6:5:39a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.16; Tue, 10 Mar 2026 06:03:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:03:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3] crypto/openssl: Add support for SHA3 algorithms
Thread-Topic: [EXTERNAL] [v3] crypto/openssl: Add support for SHA3 algorithms
Thread-Index: AQHcm0xMxg96TX+YMEeggpp3+obWDbWncF/A
Date: Tue, 10 Mar 2026 06:03:52 +0000
Message-ID: <CO6PR18MB448409DC73D075F8D3C30167D846A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260204100538.346006-1-emma.finn@intel.com>
 <20260211114735.2594969-1-emma.finn@intel.com>
In-Reply-To: <20260211114735.2594969-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB4126:EE_
x-ms-office365-filtering-correlation-id: 17afdf7e-2fde-4e0f-0ab4-08de7e6ace2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: kBXbGUng9DbKU+eXLsiV4CyL3s97azMnkqOswgmSIHKHZp5uJ+NEnBYLZdHY5R+zThaUIUJGbPg/PhMhUO3qphDYthrz0HLGZW0BCkKcRFXc19x1CJKpbHtyv/DrOqRiWJB6+y0FQfTLsmpBxpW28tApQvqi+//BccR6p++k7EUsikylWYPt0CrICbCVoc+exoe4iY/3QZL17cNlqSV7QKQoZq+UMeIPyguneJzJ9pa5waquBWeGJX/5v4vvfnm2+EAMSAKgGrw5SAAnIEdeUnuiVBPDfAOWx5EIHvEFX5WRoGdgMpB7QXsPoMSsghhAzc2H4KeCiAFHb69TI38uKW0EjJrRDwdReq23Q7nEjwZYm0jNOOONhC6eU5jw1mRzeGl+AXljo9XjI1GFV+yrd7KMty5v1IAzMv28COBqv9cNGyyXhe1pB1fCyr2Wz5/SYw2AzB5kKBWXh12ZQ4otr2CqMnwPTGx1GyTp7p5HwWRqdEsjByzvwgpN+ZecJx7bw+6ObxYH/dsMm3gYzGxx8V3NsQH1NPHyQJ9/YGNOcAt8vVzynWu3iZ2QVFM3aChTDjbbZ6Uxrxu0qaTcrgJeR9Sv4px5Nn7oYGJWIuVsSbgzwx4gCHqDQ1wh6xj6xS1Y1gI8o4bVJdWVHMd9vKF2wHkAeH3PlrL9Tv3aN38949gN4RAcj57JHpphvDmLbpVwd7ytRlK9qHB6/pN/+1qpGSjMPqsrZv8YGC09Sb6U03LFW84V8/407Bx6NO/rF4qpnmn3dnGknKiYewLYnt+JobMiYYxk2BaZsjFXC0J3a4I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dURaVWNCaXRIcngxVDFIWk5nSUJ1SzgzTEF6SXpSdVdzZWk1SkFBOUJ1NVN2?=
 =?utf-8?B?RlhKRFRrdDhRZTBUSjQ1eGVvSi9LbUo2QzdNMStTSWZGM1d2Q1d4bW8vOUhX?=
 =?utf-8?B?a0xrNGFQRHZFRDZBdWw0S1hGMk95d0MyU21QemZFZDhzc0xmTm9IVVdGTzN6?=
 =?utf-8?B?WHhwZ2hyMk5oVVB3K281bmUramF3L2pVVE9CMXpvTnZXajBLNnV6UkZzMEFq?=
 =?utf-8?B?Q3M4L2puRk41c0FUSHRPbDdYMy9EaTdLUWpyT2Q2UFg4dUZJWVFGbDUxY1B6?=
 =?utf-8?B?TUxFekMrcVZDdmdhS0szSnVLU2xFVFdHZDRaUmVVZUp2d3RmaXVmblA4NVVH?=
 =?utf-8?B?WloxeXNtY2NsOEVWVWNZd2tHTEd1NldPNXhQSFJTZkUwTTRlMnltQVRJSU85?=
 =?utf-8?B?eDlDa0RURUlHOE0xMUxjdzg1bmVYTUxFdmFYbVlsRng1Z1E0VG83VHNGcWRi?=
 =?utf-8?B?UE9BczJYNm9CSVRGZEZtTnRxWDdDeGNubGkvUUpoNm9ISTZPVkovMnlIYXU0?=
 =?utf-8?B?RXdMdzNHeVYrbEJHdStyK1FBRFNpVnRsbmNONVF1eEpkZGRvWm5GM0lYcGR3?=
 =?utf-8?B?NjN4Smd2VHRkUGlubHl1V0VnS0pFNVRuOEdqTzdUbVo5K0VIQktWcGN1WStW?=
 =?utf-8?B?U2Q4SldxM2pvYlpzazVxR1FtTlgwNUxHUUZvdGY4YkpJWEpmUzhiN2plYzI3?=
 =?utf-8?B?VXlaK0Uxbm1kcXhaMHpCMCtPZU45eW1MVlg2T09XLzJ0a2RBZ2FkdGNZeEFM?=
 =?utf-8?B?LzUwMGFUY0tNRktJdndUTWFmeXB6Qk05aHpLbUVqQWJhYzBqTzJVY2cva05V?=
 =?utf-8?B?dU95UHFoa0w1U0hiWlZUdXlqM1dLT3I3Q3BPclB0c1l6bDRxcDhKQ05ZWFdF?=
 =?utf-8?B?Q0Q0SnJzQ1RiY1diVXNtdk4rczRBTTNQcFVmc1oxdXU5ZWNYbUhEbjllRXFR?=
 =?utf-8?B?aGZYVXBhc29SMXVqVTdrcDBaRjlVaGxFckRBS2RPYWZ5T1EycFNTQzFieXFa?=
 =?utf-8?B?bEpKYUREVXk1dXByR1dzaTlnclVESU9nNmNiakhyVFd2bkZxM1FQV3RFVHBa?=
 =?utf-8?B?SUdjckxLazhHUkJLYzVRZDE1M0U5SHFERE5Cb2lJZ2VRek9QL2NYRGtoUjFG?=
 =?utf-8?B?dytmUXZ2TktEd1VZQjdXNmt5UVJidEdoUnRzL05rUmRtVHBqQ1c1YXNqVEJm?=
 =?utf-8?B?a1FCVWJaeS9DMm40QzliY2NGV1NHZHRrb09rWUhVbTdHQVdybFE3ODJxUzk0?=
 =?utf-8?B?TlR6ZzFoY2ZUbVY1V3ZCcEpleHduMG5HdkIxMlF3b0NtOHhmajRYMHk1amN4?=
 =?utf-8?B?TXBFRmJ1M0FIQUo2V2swVEFYZml5T0xYYWdrTnowYzRGaW13dWkwcDR2RFBG?=
 =?utf-8?B?a1RLd1RkQTJDOHRhTmJMcDdMQ3ZZTDFyZmR2eWVReTFhbEozbFZ3L1Irem1m?=
 =?utf-8?B?a2FSeUFmM1lQU2xqcG14eVN5YVpTL0hEdW5nVFFBQ0UyWUN6QVpIV054MGpj?=
 =?utf-8?B?OG1BZzRzSEJ3RXhaTkFRNXVQOHUvWWoyMXZlMkpJcGlZbytIUlp4cVNlYXdv?=
 =?utf-8?B?NjNxR1pONktXTDgyVk4zcjZJc3c2T0gwY3ZrRGg5SXhQb3ZmYmR5QjZDb3J3?=
 =?utf-8?B?c0I3V21BQnFwcjQ2aGxFblh2dWtpMDd4SzF2OTd5Lyt0ZXY3ZTBxVThjOGJQ?=
 =?utf-8?B?SW05bGlxL3lrOWEwb3M5TGJvSi9ZRkZEZGdMZ0FMZEtSSVVmcy9lRGk0T0VS?=
 =?utf-8?B?a3d3M1FnaE1jcEFWRmFUOVBSWDZvbHB5bk1EQlVkbU9TajVqWWdMeDJqbjJV?=
 =?utf-8?B?ZW1xMTBrV3hxNDZaTE9uWFdlcW93WTgxcDUwR3BDalp4NW54ZGJ5OTdKVmdG?=
 =?utf-8?B?WVJsVi9RL1dnM3p1dVdaTmZWbmRMVXZWWHVYb1dmL0orcEhjNU9iRE9TYjhM?=
 =?utf-8?B?ZjFFQjhwdThVeFJhMEJQL202eS9teWpFNVNrZGdTTWtzWnlkSkd6KzRjb1lG?=
 =?utf-8?B?VmNraE1CYU1kMHp6UStwcUdDZW52aWQ4TGVKRmVLUmJ6MG95NzlJYW5QY3Jr?=
 =?utf-8?B?Z3R3ZEI4VE5maktnOUlweWk3Y1NmSWpteHhjcEQ0Q1hrMFhrQTNpYWVwSjBn?=
 =?utf-8?B?SkQwMWtKTGU2QURIckpDM3hEdkdQQ3ZJTjBBZCs5TG5RaWRKMlV1VW1EcjBK?=
 =?utf-8?B?d0VkMGp2UkpDRnoza1d3WUNiUEY1eUZCdCs3d2xiTDFJbTd0R3ZTOVNrN3Bj?=
 =?utf-8?B?RFFHRlNXWXJrc1I3Sm1wb0lCRjRYWWVvbHB4cllydCt6Q3V5UE9qRzhFSWgz?=
 =?utf-8?Q?p3oXMeYbeIyToUvoEY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17afdf7e-2fde-4e0f-0ab4-08de7e6ace2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:03:52.3491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sf+LuBsfmkkS0q4eFB0Rrk5EJ1X7PUPQrWWfXXL0620ryHTCGIht2gwoscn4zwAgQcjOo1D9EwkkRMdAH2v5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4126
X-Authority-Analysis: v=2.4 cv=L+cQguT8 c=1 sm=1 tr=0 ts=69afb44b cx=c_pps
 a=2hJN3FG5vRdYsizhUtvj5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=MoFuUD_KoKBdGbnUSGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YYtjJVaoAS170yXkAZ-uLr4zEiphN-9H
X-Proofpoint-ORIG-GUID: YYtjJVaoAS170yXkAZ-uLr4zEiphN-9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0OCBTYWx0ZWRfX7icC1q8sa307
 tOjzuObGsa5kYblDW3MBjMrDQTK4pjHO7R1TljTvIWAtPAhFbWh5Yj/HelD2GefMLrWXXK46w4+
 OvqxKCzi0egrNWcXQLwoyDYWuYdTQ9nuIE7XMOeSy/Yrlob6rQYPpr+nKa4MEv45/08uIV+9dVn
 VsSD0QFZLdAhiBkiLCiXN3p/CTLDXlay4VVpmoZkKtk1k5gXbHfRL87lxYbAf9kxv6UXsvED8BP
 SuFVee8AE7sGRO01S4Wzghll1ASZiqbBlANjz8+a0ES7vJNf/BwzffzAPTNU+ko8/1mpM3lZIBu
 R40zFlWfWC+k+ZQEPzxl/jmBgok7jwMeFX96vIFKpeT9eETpYhwG0l9+dQnWUkBB0G44hkricdP
 e3RJKNX7Z2sNVRKPw6qFi1yWfTZKCgbnXOtOifV8SfcTXdqtPrUIh9NaBs2bY6JCjoUefgr9h+e
 QhF6dZMHIO4xuY03NvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

DQo+IEFkZCBTSEEzLTIyNCwgU0hBMy0yNTYsIFNIQTMtMzg0LCBhbmQgU0hBMy01MTINCj4gc3Vw
cG9ydCB0byB0aGUgT3BlblNTTCBQTUQsIGluY2x1ZGluZyBib3RoIGhhc2gNCj4gYW5kIEhNQUMg
dmFyaWFudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbW1hIEZpbm4gPGVtbWEuZmlubkBpbnRl
bC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gKiBVcGRhdGVkIGRvY3VtZW50YXRpb24NCj4gdjM6DQo+
ICogcmViYXNlDQoNClNlZW1zIGl0IGlzIHN0aWxsIG5vdCByZWJhc2VkIG9uIG5leHQtY3J5cHRv
DQoNCmRwZGstbmV4dC1jcnlwdG8kIGdpdCBhbSBpbmRleC5odG1sDQpBcHBseWluZzogY3J5cHRv
L29wZW5zc2w6IEFkZCBzdXBwb3J0IGZvciBTSEEzIGFsZ29yaXRobXMNCmVycm9yOiBwYXRjaCBm
YWlsZWQ6IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9mZWF0dXJlcy9vcGVuc3NsLmluaTo0Mw0KZXJy
b3I6IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9mZWF0dXJlcy9vcGVuc3NsLmluaTogcGF0Y2ggZG9l
cyBub3QgYXBwbHkNCmVycm9yOiBwYXRjaCBmYWlsZWQ6IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9v
cGVuc3NsLnJzdDozNA0KZXJyb3I6IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9vcGVuc3NsLnJzdDog
cGF0Y2ggZG9lcyBub3QgYXBwbHkNCmVycm9yOiBwYXRjaCBmYWlsZWQ6IGRvYy9ndWlkZXMvcmVs
X25vdGVzL3JlbGVhc2VfMjZfMDMucnN0OjgyDQplcnJvcjogZG9jL2d1aWRlcy9yZWxfbm90ZXMv
cmVsZWFzZV8yNl8wMy5yc3Q6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQplcnJvcjogcGF0Y2ggZmFp
bGVkOiBkcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9vcGVuc3NsX3BtZC5jOjI3MA0KZXJyb3I6
IGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1kLmM6IHBhdGNoIGRvZXMgbm90
IGFwcGx5DQplcnJvcjogcGF0Y2ggZmFpbGVkOiBkcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9v
cGVuc3NsX3BtZF9vcHMuYzoyNjkNCmVycm9yOiBkcml2ZXJzL2NyeXB0by9vcGVuc3NsL3J0ZV9v
cGVuc3NsX3BtZF9vcHMuYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNClBhdGNoIGZhaWxlZCBhdCAw
MDAxIGNyeXB0by9vcGVuc3NsOiBBZGQgc3VwcG9ydCBmb3IgU0hBMyBhbGdvcml0aG1zDQo=
