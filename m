Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94052CD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 19:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AC7E4025A;
	Sat, 20 Jun 2026 21:19:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C5F2B40151;
 Sat, 20 Jun 2026 21:19:45 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KIUUN02327353; Sat, 20 Jun 2026 12:19:44 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023116.outbound.protection.outlook.com
 [40.107.201.116])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7h8ytq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 12:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgilkIjMJiqvpJtwvq0OE4O8OhebSg9hWWB+QWYuXML/LUbVoT70+MdONfGATQWxO4fpektAzAgRa1rD9DAcFnkIQKBuJ/euorl/r+vSbYBDOmj8gHSjtZ629awvgYfRhysVcIZoo2czpF0nHJFQkhyd05yiHnq0XFBQxTSa3gkuRBUakZPuo+hrKPcyPx8PnN6BL7MZP4PBm+exjSrXMYRPRf7LNkbgxLSAjiu6j7Cea1fT00WLjKVn7FQ1LJyiQgNNSKYZBRzx9RsXHYVO3uyZ6xfpxFpudWaFQnFpVBTJcnakzxfnCPBWg8OpLDQ1P6TDHcdunIB6EfR9bdtE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMocqyI5lOmhsY7q5RTcc3TEIeQCvzKssCTdDJyzXL4=;
 b=QXLil25hrfaPXwmp8k2emkLcAJql8kd+ibKBZx4ygdD1sJX5u76v0srd4mSr9/urjDgoenzItFuwbD0Ekx8e92ZHrz6VINqFUffy5uKB+kjBoQkh21yZwARR4ZAg/kNLfhlunZkUP5gSHnJcfnMZn/UaPakdv/0/aeBVPAlEBjugIFmlMGYskA4vhva23UgkrIrVVL/5Yi5CODhM411N8MARm128rnxN1EGhOt54UNo8Mpl8ZEjVTFFGJzPM3kyCMAg012TdIsFdBg48Gj0VuxOehczs27+20cm8HSh8x0IA0cmqWzSuHxJY6Zf/XcO+/7TsvDEIk9NkyCjl84Ux3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMocqyI5lOmhsY7q5RTcc3TEIeQCvzKssCTdDJyzXL4=;
 b=eojF2WOetHNanDjjzKcJvT08ORRZvOmsMgtAOD0PnG8o9da42gxSIwSmdmZlP5uBgTVyFaH34X2+Fv8KNArkBaKSGsS4Z+u2NAZ5ux12qJXy29PwuM6PNl6wDLm6zMVC2kHp9KCLt5G1ZHGL4gOxscUUcvPwBXN5MSUEF9KSuGw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3641.namprd18.prod.outlook.com (2603:10b6:303:2e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 19:19:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 19:19:40 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anoob Joseph <anoobj@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] security: harden telemetry parameter parsing
Thread-Topic: [EXTERNAL] [PATCH] security: harden telemetry parameter parsing
Thread-Index: AQHc9RNIhZuFm+3bvUeq5Ybj7/aovrZH6SPA
Date: Sat, 20 Jun 2026 19:19:39 +0000
Message-ID: <CO6PR18MB4484F41E56C91B9600F90B27D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260605174636.218232-1-stephen@networkplumber.org>
In-Reply-To: <20260605174636.218232-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3641:EE_
x-ms-office365-filtering-correlation-id: 24c9d200-8b8a-44bc-e0bf-08decf00e01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 3jfwfYTG7a/jOXXVBXOkanuKgDwfmbaTj0UpZ7nRuu/+AOd9tLfivViwAcneRtKZvFeOj5JNpzF+pCxOunuBopEXjL1x3JrY19KD4H89yrVTPaYeZvjY33dAGBW/0FLT3H32EOIyMGMo48DoYRzpffUQJGNVsJujQJEsbLImk8CI538D+UpGD0/87C4D8ln/HiaRLru9FcvgdgJTc12zQ5vMCAlL0RaKc7Ui4bJc/dBJV2tOH4oP6lr7LoZ/19YAsFl91qdvS3/NZ8bgKs4JZ28nBoZFDAjYfd96mYA6t5aodRkXg5AUXgqdzJRqIOUCzxOEbgEMhrDg1eINS7/Z/OFgxm+Se760GjUR3roN2lL6Pya8kajuAHZRf7RnnOe1khH85PBN4Cf8XXKmUwSUUXUoxd2hwGIEOR7x55Re5nCWZmCIO/Jdnl0zM7MDEAadQZ2VIEYpnYc0uj8kEKhoxHv1aPuNmc90fBxs+Xfcb6A3PFH17rLL5/GIxPBEoBMX4L3VrlIvMQoZ6P7FBu9DdlTqmNUa1W/XFitIQjSLCeYBzrGEF6Q2NoNlUdubyPxBnzN0jnXDjXGNr7O4VwSSizabe4ntPR51eyqrORE4vwE0TvdRE5WwriD6ASuA5RYSAM3Ium0+PXN2jCU4DNCGaH4aVVcgv1oS+vVxnx2sZj29sF4hqHp3d5mUKM44/ACFui6lNTOYQKPRwnKgIPTRrTmnq6aieKDZGjmaEpfQpYo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0JSMit5Ymc2RkFRUHV1RnJlb2Q2Y3JUUWl3d3laRzJJZGpTMEdMQ29haFdx?=
 =?utf-8?B?MFlJQmZIWFRaTUNiaXU3RWZGMmNZNFI2TGp6NzlVUDJkRC9Rcm1ud0NZL0lN?=
 =?utf-8?B?YVJKaUFYakpWRTJnclE4dktNUVVRbjhqNHlYaHVCRzQyajRXUFNCbU9IbDYz?=
 =?utf-8?B?Qy9mV0cwWkZSYkplMkI3VUdOSHYzWVNiT0o0UUl5b251MGVUSjBkOThMT3I1?=
 =?utf-8?B?SndZYzJFTEJaMk9IQitRQXkzV2pwUVNFcU5pTERXV1dTOTRqWDFhRHdsajJZ?=
 =?utf-8?B?TFU2aC9XODNnZmQzK3dhcWJpWEVEdUg0a2JZVWZQcVg1bmpRZGVZL2xvVlhR?=
 =?utf-8?B?bGFXREdDWmtmN2N3SUlxM3NjZTF3KzJrU1E0OGgxTnFJMEVJNm5iZysxaXF4?=
 =?utf-8?B?TnRWcUhVOFZ1cnF2UmtGeGJRSy9obWNUTmFIbjN0Yk0vbnJTSzZESzJVODN3?=
 =?utf-8?B?Si9LNUl3eTc1UlZVZmJhZEpjRkwyK3BZSEdqVVM3MncyYXZBTVBRRStPODhJ?=
 =?utf-8?B?bVIxb3l1WVBBVFk2d2RiS1pjM3lCelJWU3lnZmQwZGhnbVRLcmZUcklxTVJO?=
 =?utf-8?B?TGhoSFFRYmRSUEMzMWZCSDJHN0p1VURNZ2ZEWlEwQjk1ZHAvZVEwdUtzdUdm?=
 =?utf-8?B?aWlhMnFEME95VWNhRHJUcTRkSTgvUFVYSENwM2VYNHgvcUJ3S2g1UUZsTG1s?=
 =?utf-8?B?S0luazdwdEFqOWpJaXduMHJUWGxocXozZUw4VTdzS0tlZnp6TThZVVd2R1ZT?=
 =?utf-8?B?SkMwMW9LQkFrVDdhQVZWQW9HdTFkaEFxSmFiK2Y2Q0dTNXprWXllR3Y4UEF3?=
 =?utf-8?B?RmJJN0NRVDFUbk9XeXBaVEZZZDhoQVMrZHgxYk9zMzNVT2hWanpZVGk0Qitl?=
 =?utf-8?B?ZFlZL3ZGZ2kzY082MGZRbG5qTmpKcEVwbDdYVFgrVm5nSC9VOVM0WEFROUxO?=
 =?utf-8?B?YW5Ja0N0eDRWR2NZUWlxb1EvRXltSU82MXVyMjJuQW80TXJsVlBjUU5yUm4v?=
 =?utf-8?B?SEl6MTc5L3NmUGJwbDU5dUxzRzJPaytYRThGOTFtN0RkODM5OFBNNVNRZCsx?=
 =?utf-8?B?a3phKzZtTGFkQVZQUlpSUGpBUnU3ci9YN2l1SkhScHoyWUpmdGRVTUhSeHFW?=
 =?utf-8?B?b1ArOFRUdjJ6VFV4WGs3RjdsRWMwdk1lRUx1Rlc4Ukc1LzZ3ZHEvSkJJc1Jt?=
 =?utf-8?B?Z3NET2JFSnZqR0QraDVyME1IdHlSVmlBRlRBRkdNcUd0ZjNPR05FMGtPQjhZ?=
 =?utf-8?B?VzFNVENCL0VJckdCOVFhSzJKUzF5Y2tmZVFxcUwxYmluN3o3bjlyTVR6emgw?=
 =?utf-8?B?ekRCNHUxRCsvOUoyZmZqcVNnbzQ5VnNDTHNhQjN4S2tGSVZWTUNVb3l3VXdP?=
 =?utf-8?B?MXFjNStsaXNjcnhFek9VOTBhK0ZuNVVIVXBUOVZ2YS8zQ1JnT1Z5MFZIcnp6?=
 =?utf-8?B?R2xOd1paVkpXQWpIUzIzZFg0d3J2RGdnSjFTbUtORk9wZ2hXS0NWNnU5eUJ1?=
 =?utf-8?B?MThLcHJkT3UxTVlaS1BIcnVhVTNiUE1qcnk4bGZNK0c1K2JaVnBCbzdzTXdh?=
 =?utf-8?B?b0lZdURSTkZock4yWm9SNXdQUGd3QUh4QktzNFlRblN3b1BiMTB3NEdBSlpG?=
 =?utf-8?B?ekpOK3RiRzRlRSsyR09zeGpuaXpOem4zRmpjdjJKZ2NVVU92b0lNZytDSmYr?=
 =?utf-8?B?aUZXYjk5ckUwaDBYaWkvaVlGYWRYREhIM0JGaGNNRVVKYWYyMjJIbm04TGpO?=
 =?utf-8?B?dStPdjBBWUdMck5PTTRvQTBJK1NOT1hWYTJwVTk3MExPSzhURlhPemY4b0Fl?=
 =?utf-8?B?NlRJaDU5Nnl2TjJER1dhTEF5a01xOEROYk9XaFNETjlpT0hjS2NnR2orWVcv?=
 =?utf-8?B?TzlBMGtobmNNcVBaUG9zL2sveTJQZC9ZU2NoUiszT3hPc1lwNGJYK2hBdDQx?=
 =?utf-8?B?N3FHZHJOQ2l1UGUyNjhVWDFaVnBPOXhyT2JCYkFDOXAyRDFSU3NIck9PQmhY?=
 =?utf-8?B?OC9DS2lrSVBMNXFzdTlRT1NjVDhKalg1NXFuTThlOSs5Y2ZvQkx6dDh6TzVF?=
 =?utf-8?B?ME1vMW4vSyt6dGJtV1JnbUJCL21KWERDRVFhREx2bzJCUkZySFlWMHFHOXg1?=
 =?utf-8?B?M3VxaURrOHE0dXNld2tEdUhORm8rTDg0RmsyT1ZnRytPOWNrQ0tZOTZVeGRs?=
 =?utf-8?B?TDlhelM1dnh0MDdVcU1DSEhLbHVMT0hDK2JkZWI4WWQvZytweGMxelh4OEo3?=
 =?utf-8?B?UjBsQ2kxMkZRR0pucU1FaDVxQTFEdVVtTmtjeS9ydlRzVDlrUlBuQkpMZ1FG?=
 =?utf-8?Q?1zb+lOU79FSE532vwz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lba6f2kwjreq86F9wiJj/K8R7pKJiVqIZHmIxkiugZbzmAPqXyGt9THLDNgtTG5b0asI/MN4DaQBm1SYMJxS+LXjWOiQSX4rpiarjJOpz1l7Xh3bb5Uv1a+NxJMmZ5eSLm7u5q8tc1vah53OVHNuEB9FvGhes2qnJ+F3uxm0ZFnZWJQkE7Wjgb/w0wWbPAoXWg9Sk9CIuA5Kek5UptXyw0HEO5A5RySu7LJMDqp2A2/ZRkKU/dHcCG35C1DSkWCTnOBSoXugQRsDteAGkDpRx8JJVf6wffgQGpEI6pqWopdepb2lkqW4yMda5zRs8rvnjtTYkV8LFK1+H0bGVHl1Yg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c9d200-8b8a-44bc-e0bf-08decf00e01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 19:19:39.9946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OeStM9j3n0ps68KXk7oq1Oj2gv6TDn1MkG00R7ZF83Du5NCOGblJTh3Plzej8j4Vld3FMIpQVhzVPe/zNs4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3641
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfX1p+wtD1R0kKO
 wWuhwDJWAhQS+AjHVvFiOWqDkvArqL3W645z7Mjje+1lCh6Rz95aFr60bo+UBES+1GsvgfFefHh
 DbQ8mCWTxN+jvBHUdL0TvLdzfLaiBRWYCDXI6V8mGFoFyIYoNoK7QPoNWj0FQO92DW99mhOPn04
 xk8CQ+w/ruwtgvHA2O9RTDHHWoYPIaS6EUwwtV8lS3SL4CKNDkjpj8wWIr9yX03C+tA01v7f6KA
 mj/9K+7HnDyxGWqyv/gTPQo0bX9oeChwArBcZHHAh0SYf8uJaM4xoXLyMxWC9VtvUcym8Ag/Crr
 B+EbrCAvI2zPg9GkRI+OszGaqDkCsDX/VtMLzlZTY8J3ZGT8Ox8oQk+0xCls2PUkArh+LHakqGK
 OBYbWm+BBOl+gVr50mNRd+0pP94FT6+yLXoCr1XY98KzCcMSeciWfsGgwPbSJX02IcB08VJFO5F
 cGbrowgT29VlKyCHFlg==
X-Proofpoint-ORIG-GUID: jClSWGTtMvI0vmOd6_z9avirwC_k0bSu
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a36e7d0 cx=c_pps
 a=hnKMlhE5OLNSgTrTPmU3Mg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8
 a=jZVsG21pAAAA:8 a=9DvVARVEMNu_U-eEZwoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfX8fKoeUCLy2Rm
 gTh+oV1pXYXT4ByvO69JYUcTOps0BTY26wQAFkopS07IR+v58ut9HmZ5wiyYPUoCNbsLh45kWLc
 7anzUYlVpQwRLqH556b9yXKQ2wn1UOY=
X-Proofpoint-GUID: jClSWGTtMvI0vmOd6_z9avirwC_k0bSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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

PiBUaGUgY3J5cHRvZGV2IHNlY3VyaXR5IHRlbGVtZXRyeSBoYW5kbGVycyBwYXJzZWQgZGV2X2lk
L2NhcGFfaWQgd2l0aA0KPiBzdHJ0b3VsKCkgYW5kIG5vIG92ZXJmbG93IG9yIHJhbmdlIGNoZWNr
LCBzbyBhbiBvdXQtb2YtcmFuZ2UgZGV2X2lkDQo+IChlLmcuIDI1Nikgc2lsZW50bHkgdHJ1bmNh
dGVkIHRvIGEgdmFsaWQgZGV2aWNlIGluDQo+IHJ0ZV9jcnlwdG9kZXZfaXNfdmFsaWRfZGV2KCku
IGlzZGlnaXQoKSB3YXMgYWxzbyBjYWxsZWQgb24gYSBwbGFpbg0KPiAoc2lnbmVkKSBjaGFyLCB3
aGljaCBpcyB1bmRlZmluZWQgZm9yIGhpZ2gtYml0IGlucHV0Lg0KPiBUaGUgcGFyc2VyIHdhcyBh
bHNvIHVzaW5nIHN0cnRvaygpIHdoaWNoIGlzIG5vdCB0aHJlYWQgc2FmZS4NCj4gDQo+IFVzZSBh
IHZhbGlkYXRlZCBwYXJzZSBoZWxwZXIgYW5kIHJlamVjdCBtYWxmb3JtZWQgaW5wdXQgcmF0aGVy
IHRoYW4NCj4gbG9nZ2luZyBhbmQgY29udGludWluZy4gVGhpcyBhbHNvIGRyb3BzIHRoZSB0aHJl
YWQtdW5zYWZlIHN0cnRvaygpIGluDQo+IHRoZSBjcnlwdG9fY2FwcyBoYW5kbGVyLg0KPiANCj4g
Rml4ZXM6IDI1OWNhNmQxNjE3ZiAoInNlY3VyaXR5OiBhZGQgdGVsZW1ldHJ5IGVuZHBvaW50IGZv
ciBjYXBhYmlsaXRpZXMiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQpUaGlz
IHBhdGNoIHNlZW1zIHRvIGJlIGFscmVhZHkgbWVyZ2VkIGluIG1haW4gdHJlZSBhcyBwYXJ0IG9m
IG90aGVyIHNlcmllcy4NCk1hcmtpbmcgaXQgYXMgc3VwZXJzZWRlZC4NCg0K
