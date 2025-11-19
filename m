Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8845FCF256B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 09:26:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585F64029D;
	Wed, 19 Nov 2025 10:26:03 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1C29B40265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 10:26:01 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AIHmatH2149481; Wed, 19 Nov 2025 01:26:01 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4agwh8hs0m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 01:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN2Grja4BAVp29p2A1Ps7G863Lmdf9Zfuo1WypCbKaUFf07BXPXWErPyQJjZ3RBXSm2sXH8IcIYApT/c4Y7Y8ZtpSOan55CZ+zWX9UxDAv44jMdpqVqR1CbRBe+HOoHO1xRDh+2iRsvK8aXzeFDB3FzUpARayPQKuSQkU4AdOuUFg2KdwMWjuC3chZ9piRSAeElp/9P5sOyYZKPhWxjj/EPrughLwmdKVcBlvOk7w9pPhw0c/9iTukcdatNrLTHDmfmudRExZxIImBRiN7FgkpQjdp9rfw7+D/RjHCz4bMuK7g2zG7LAriUoXjOPRaangCTbIFbREfvdZ/a3L1wpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ/4rDEWymfeyJAZ6l+uJAE7SuXveLQmeSkt7m0A+LY=;
 b=f/88zJlOOiCsd8OqiDRDFZWHfzcYnkjpFTEiohr2WLp16XJBQhefNUcaboiyhUJFczPuEWPIWUtbsU25OKkwwHFETH3iahheFYXZxrvudWjL8bZBXxLiQHj+zFB8qxKf2F7T4qKT5kaQk8x9a48rn0aMKenvztjhSrkIt2REwwVST7YC2Nm4hqZTsMBOeHOUs9249AcO4pr2HUqh729ojemEQPrtjNA0usjiUr+y+VY8bMPxK164mST0TQO4SnpVcBV24SlHj5ZPQnx61/jBQI97F+ZDg9kAuIMgG4OMiI52Aav7NqlobOe3NyWS8oHXZAezwTxpqs1GODihQXH2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ/4rDEWymfeyJAZ6l+uJAE7SuXveLQmeSkt7m0A+LY=;
 b=XLz1/hnDSlqzACkuVLU7ONKBOy5skNJX9lVwrfzFRBgxrbTE8J4wKlypbageQJG59I95KavKs0y6ClQcQsyvUVRTLvUWaXBhC0NhN2k2VNadNeLms2etjfwaY+ZGzLC0bR0g2iZ2NmC/LbhXfpipzeotjTAKQXNAkvQQa1njVEU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB3800.namprd18.prod.outlook.com (2603:10b6:510:29::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 09:25:59 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:25:58 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support for
 SM4-CBC cipher and SM3-HMAC auth
Thread-Topic: [EXTERNAL] [PATCH v2] examples/ipsec-secgw: add support for
 SM4-CBC cipher and SM3-HMAC auth
Thread-Index: AQHcV6HbOf6o2WM/dU2LnTPCiko2aLT5vYmw
Date: Wed, 19 Nov 2025 09:25:58 +0000
Message-ID: <CO6PR18MB4484E389F6067410878BA405D8D7A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
 <20251117090851.54748-1-sunyang.wu@jaguarmicro.com>
In-Reply-To: <20251117090851.54748-1-sunyang.wu@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB3800:EE_
x-ms-office365-filtering-correlation-id: fe10fb6d-98ab-4534-d3e9-08de274da643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6MqqSE4h2udLHfozKw4XP3LYxVFBmymFrhGU3yTXD8n8PrklhyPhR7KZKzVd?=
 =?us-ascii?Q?HCjQMjTsb4Tz7L3EQC7sJWtajbz60aTxs/5T3P6z6IGhKy9csnMnKXlo3h29?=
 =?us-ascii?Q?T+/WCTrEIkQVlnK+Wfjg2YSNQicogsWHbJ7FFebpiofsxLhHtpCQTraVHR0M?=
 =?us-ascii?Q?vMtucNVjO5T2P4Kcl1RAACj/d8giP5Y6QjRQP4o/NTQYhdN8tqjfjKHugcpA?=
 =?us-ascii?Q?5U4fmWY/8cYDMAQwLwxYHAqosPgbbZOjyxLgYawFhsr3uYPJxSoXiH3Ayzwy?=
 =?us-ascii?Q?DCOsY3d/dn7xjcdCX5+ITFCiVg8c+WpR1Fh0IGGz1vqaNYhJJFIZCF301tFu?=
 =?us-ascii?Q?aLjEAR1qj9MgjvdLLEq9CU1gkp9FpLlOndrtpP2pOaIg4+bhu4/OdnZxH5dY?=
 =?us-ascii?Q?ZmPZAh9tvNo6GSyAvjUdmCb8qh8z7bZ3LdxuVPKJhTGjuGFqaUzy6N07rj0y?=
 =?us-ascii?Q?FAAlB5fbF0qd8kW/SVnU9CEfXoYyejU1C5bpb1Rm3pmaZ/AEdxTrEYhRrfR8?=
 =?us-ascii?Q?UdlnTakZyi4xdaQNdlsH6oOq2l91k9fs070gda4rZOzsSiBLjvptTeHL61Rc?=
 =?us-ascii?Q?Xg1JrgnDtkn1iAoBxv8VXl6fJv27ZlVUOcdPKY2GMF8Fc+EJtmLe13l0Sz85?=
 =?us-ascii?Q?+Pf/WFvzyTSub5j2uZRpxQaWduUWopmXIBzeUHn72TlkX65/NnVAQrLsnpiH?=
 =?us-ascii?Q?BroN7HLtEOLwYRX4GTbgiItbDRMpkfrsTfw0MLcXc3+8cQGCr0PmFeCTDBwv?=
 =?us-ascii?Q?fGtXdhGzzeogEsXri6Qf3ZTabP63IIg4eYkZ2WmEEqvWdPwIinVFcGzMadn+?=
 =?us-ascii?Q?EIPjE0wpWt0l9ZvW24+GNbUhttQ+E6lj4/VYETof1qcBaDoVOVKx3qY+KYf5?=
 =?us-ascii?Q?8S9vruurZAgK4wCueDeEmaXssQHtWrrHJVXBqRmDTfC+um18R6fZ6SyITGnz?=
 =?us-ascii?Q?44dv9ZhLGrRUKQ+avuFSy2axBWp+2/k97IwbiyvATfSbRfPXDoTVADvZYz6/?=
 =?us-ascii?Q?VslUBiUHYUoRpTgqNkz0aSpudNLnj8JScSjm+ROI/nKfD6Y7G9I8OVBNQXYn?=
 =?us-ascii?Q?MozOoMEmzmk6RVawt/pAx2VUF565ABTanzsO5rvMGvqvW+lR8DDEnJYYBMt7?=
 =?us-ascii?Q?wu13nMwnXUrLADufuSvsge2xu3IrW9TkQ7hTB4eiJteam9CCigU9vnDxSgjs?=
 =?us-ascii?Q?88zHaEEV3NkcbK4l99/N9cJtFfiwUqPnT+2vT9j3xutw6uXYir+XyaoC7uSM?=
 =?us-ascii?Q?v2d857T0tMwaC06EbNPzz54K68VUOj1QY2alTxCeqilmrPvbwOc7V/HwYYZi?=
 =?us-ascii?Q?lXnqo84FTBPTKQSYAd1khru8VMm485YTUErc2PgLFvzT3KWjagjSlXJagx5P?=
 =?us-ascii?Q?+y0zqBRA23J/qGqOWHLGmXmDWqmpNq7xIBd7G0iL5GDro+V6Mpo/OOxTwqTe?=
 =?us-ascii?Q?JOz7bkKkX99lcYEIBklpX4y7RrVCnWuptTcSvDp2K9w5PnohfHwyexXHdDDM?=
 =?us-ascii?Q?g/WJBZJsiPpmI3e4oNhV/CLmIA7x5lJpCXWf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AXo7lepvmOA8huqgL20R9rzQf33ZhbKz5+f8+ACOHP7Od0nGhTRfnW9eWc+G?=
 =?us-ascii?Q?osdDQMPOsLA0jcy41YzfgzsrlwFrxTldKUYz9zqOSkhoHY16gHtxX+QzECuG?=
 =?us-ascii?Q?Buac7dIlMXWOBmUpL1U6w50sxd/mbdbMmNHYInysrWkBrjm7PVS2fWu9ujhq?=
 =?us-ascii?Q?cFmrEEgPDuo1PaHg4MWTNWq+eH59GXogY1q/JRxqnq/98vlhzkEntCBHvWIr?=
 =?us-ascii?Q?QQwtkg1Sjf1GIqnXG3AawTTvprTx7BN3c5eOYASGm7VSOy+2AbNgZQisSll4?=
 =?us-ascii?Q?MGv0ccxP89gF4oCCAfoyPOFYi0CtuugyexaGB7EwJt4R/w/pikKK2tltgd5M?=
 =?us-ascii?Q?bF+ZWi0Z5a5R+CcJnh3B8laaHomnBNuHG3E8YKzA+8tSQAU0c3EyYDNDyekB?=
 =?us-ascii?Q?jlQAE0Az4zWdl8NOkRY0KHmk7weM6VZTllNXXSQQq+rV+jUPjjp30x5KyOVv?=
 =?us-ascii?Q?50QZMGC4e3hG5ZmvyJHkLixaF1z7gxfS9gWpGGe8oCqtGky16JppNl1MNNFY?=
 =?us-ascii?Q?N+3Kr7SRIIoVJ8+WKcnoYpJczAdxfdMjPl6rTollFCBPoYRZOW/cIUCAc3jt?=
 =?us-ascii?Q?C3Ijza4IBKq3j7DJxOp+lXpWKVYfubTTdybJLzNhKyeQX/z3U1c3d6CBgSYD?=
 =?us-ascii?Q?z8xsjjzndYc/wQdwsywJuUAY77C15aOIHoQe6FYkAGB2TOIJi2oglUVTeJ5r?=
 =?us-ascii?Q?h1435klnaw2IM8L/fvGLXiEXV9bFeeUN8iOlA0xq+/pq+Uc9wLniuzvDry42?=
 =?us-ascii?Q?VRGvbr1jQc6yPeGLpy7heK156PYrGQECWD2AfJ87M56W5wK4znA1JEb1yd9B?=
 =?us-ascii?Q?2Wun8XQLNBvvVMvTIauM8raAPoz1x8NEQ1zzJgLQu/kpfQj6ZILBe8t+FgE2?=
 =?us-ascii?Q?IbM8wY8VthE1cz0GaK/I1aqbAAY4VjTYBO6esykAuqNKiHS/qM4IocRkbwy9?=
 =?us-ascii?Q?VjRNQNClO2kFTwFRnU6br1BPcO6xRTzKnrUmtdmkIlps9kbfOOowO6vG0r/m?=
 =?us-ascii?Q?fAgZimuBLVK7LP8PIMyPvjmTo1gsorSnSt8OfKWcp+vNAapU2wBEPwqjq3ib?=
 =?us-ascii?Q?Rjvwomh0TWsFJgF1akB5YfrBq3naGowdQTtxAq23PaPGEpRkun/r+RcrDe+Q?=
 =?us-ascii?Q?RgyegaglFat2BC9fzcyT+FNoOWBcsrRg3m8VhZX7oQSI7Q1KOh8T+vaYKI3i?=
 =?us-ascii?Q?oYAYLZaSwGnBwLWN5HWwXW9LI7MuIJV+vUPgErboPj9UB5Vtx2kI7UoYtbau?=
 =?us-ascii?Q?RAZfdc1F2wtCPL2Hf1Mv4yFSvLCgeDWsGnc9PMQTvFOjWxhZYVsxyjrY30nA?=
 =?us-ascii?Q?AR7w6ytjCjB4r7jvEa+ahqeHd9AkWjwOWFtr+gyqiR6J0GjGT6a93VHtcs5R?=
 =?us-ascii?Q?hzh8z/Pg5q8uEzZN3lnbxGpcg6bQ7SAqyIUAi/kJrga4G94d+PiaGQbJgVui?=
 =?us-ascii?Q?u35ZxaZT/NRY8HyJ9v2kLw9EMZbEJqDD/BfeRDNoDpjk4o1B2/kgj96BCHM6?=
 =?us-ascii?Q?Z5RtdTSiJ3IGgi2YuZV/FttF4xJo351iCjxDxzOL3OUq9qqu9QPwokyl9+K3?=
 =?us-ascii?Q?QfSEweAe5k6FRhQmWV4AEZrUBD3qeren7n90Ak2c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe10fb6d-98ab-4534-d3e9-08de274da643
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 09:25:58.8433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzWRj02hvFtFeBWO9SN8HaP8bbT0+xAwvylPOTZPVgsB0kHz51l8vMrM8D2Vg9G+DWY9MqxJmHl2XSO0bmzPEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3800
X-Proofpoint-GUID: L-5esFcYYwikuWSrIDHjEjpEFHnEKAvB
X-Authority-Analysis: v=2.4 cv=Wpkm8Nfv c=1 sm=1 tr=0 ts=691d8d29 cx=c_pps
 a=XQ5R8ZYH27Ke1DXIRfoPQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yacp4PbrAAAA:8 a=PJHDSaTb7tSat0YodRcA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=V3FWeFeR7HlZ9tVNOp1k:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MyBTYWx0ZWRfX4PPYrxn4lPLq
 wrox07ihwjLKA8rSadb5odJF5hKaP5mJJgdr+3D/7cskD1YlZHlJsBLAPYyZkftVmdtHhCTx/nN
 NOfFX6vXbRqnOVxax/rzP58kup4MWCcxGjga2eYmuePypTlqQsQuEU6YbueVHkg/QxXiA+u3C7I
 dTUVB79hG3dY/74MqCw1eyO59sKe4DQ9EDBHc+6xyYwGo1GnaebYklKOlDbmMsOQTdhPqN1L4XY
 XDiFt8bOE0Red32hCNvNEUJswdvRwgDBJ80XR9V2xP/0KDCDEU5bPIv6egrnxgLp4Ba/g1Ieldy
 C74Rg2galuT7Cn/ScBdTCHOgoocxwveCxRqUTfKSxW9FEypDfMotUicAX66CWu6pGeF2qRzXQzs
 l/zdcanFnG01wsieJXwfp+QPza8laA==
X-Proofpoint-ORIG-GUID: L-5esFcYYwikuWSrIDHjEjpEFHnEKAvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
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

> This patch adds support for Chinese cryptographic algorithms in the
> IPsec security gateway example application:
>=20
> 1 Add SM4-CBC cipher algorithm support with 16-byte IV and key;
> 2 Add SM3-HMAC authentication algorithm support with 20-byte key;
> 3 Update SA configuration parsing to recognize "sm4-cbc" and "sm3-hmac"
> keywords;
> 4 Implement proper IV handling and authentication offset/length
> configuration.
>=20
> These additions enable the IPsec security gateway to use Chinese
> national cryptographic standards for secure communications.
>=20
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>

Which PMD is used to support this combination for IPsec?


