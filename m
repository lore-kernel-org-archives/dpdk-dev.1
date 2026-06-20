Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC4CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F7EB4025A;
	Sat, 20 Jun 2026 20:08:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6D59740151;
 Sat, 20 Jun 2026 20:08:24 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KI8N9K2288432; Sat, 20 Jun 2026 11:08:23 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023102.outbound.protection.outlook.com
 [40.93.201.102])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7h8u9k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFA/323WwD/llQI08sqgxnrZdcV+oKbwSnboZWA+Wr7VkCQ/Fh9NZN3PrQAoqqPCnl4aYN/OpQdXIG/d8k48xArIgSnNAsIyI/wqN5CBR5BTcsU1fkRoU41gypk6Q3xMEKPk9I04e0Cg4H2zq5MlXC8m4Vzw8g1S3sM8IOsLeiJadvBLDKvpjszrAtMUXDrPPkQOlIWxicMJhYYvPkUiD6sRApp4nJbeR3wfaYLN2YdT5LOjsHyDxccQBeRDvhKf79iiT8fJFajwsPXXl9RJrniX3ylgHwRN39Qq4jeJKPajVgrPvLdnYCDSQ13WNE99ctjIcHfDnZsR0EE24CIvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM4ptNVH4a4wsAvONUNh/opocfExzMtqPw3lvP4N9w8=;
 b=Gw/CIEbBGphL099miR+88/0rVhf+IevHDcCD8q9D0Swe4ldh9UL+6xYEoLeViuD+wwIq2fv1DrZ45moYl5egUEe1VWuzO4IbXZnanzYK2zxdnyeLr1f6tHMp0WZwrEaKmSCGZrepl80m9E0D3bgcUaKsBBQ/ROR5P3eZRlt3DazcLj67DJPkEoftk7d3J660W+VOkHTDJ/CDU3VTp3qusNg7IAJNMC34r8tvZBwnTjRwL+Wa/uEJN7bCF1MJ6rzCcTBCPc49snOrhIRxou6kiBwRyFanKfIbhKFi6fP3hE6F8rRL6OaIXR36yrphZpD9MZ7f+lzu4mZ9O55u7F6Vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM4ptNVH4a4wsAvONUNh/opocfExzMtqPw3lvP4N9w8=;
 b=bb7kSqS7HTv7+etd8/L35jgFRoaAnlXZhhXXuMAuP7VLrDN1x2rVJHc20p49YRKZZycDS9u7JH8JdQJ/gYGD0yazWrQgERZsotJ2zVwex1NjcdgxonXNq5Dd/yGfKyIZS0Xk8qHFfdF1cj9FBKdf7c+MhI3yJKI7ZlR6wDP8+ic=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS0PR18MB927519.namprd18.prod.outlook.com (2603:10b6:8:312::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Sat, 20 Jun 2026 18:08:20 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:08:20 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Aarnav JP <ajp@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Anoob Joseph
 <anoobj@marvell.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>,
 Rahul Bhansali <rbhansali@marvell.com>, Aarnav JP <ajp@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] test: sync soft expiry check in inline IPsec
Thread-Topic: [PATCH] test: sync soft expiry check in inline IPsec
Thread-Index: AQHc3HxHxRSqGhDqjUmIe/MHexZUo7ZIBhTA
Date: Sat, 20 Jun 2026 18:08:20 +0000
Message-ID: <CO6PR18MB44842240CF7D2F0DC6026BA0D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260505104351.2678817-1-ajp@marvell.com>
In-Reply-To: <20260505104351.2678817-1-ajp@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS0PR18MB927519:EE_
x-ms-office365-filtering-correlation-id: d407c579-8e03-46b0-adf4-08decef6e955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: BlF5zrvBPNWZV8v66btV02gya27+9hS/kn2OXJvNw1UjU2BUCAEMhL1w5X2SCiH9Rqa3xnArAhSMecPyxokpZdJA6eEQKWmJsBcFkQb31qU2qi5hP9XZOi9GPtUDU+GHSJC1KK8Spz5UEi2CGeFlpxMLvNsujVrvvha1kt9N+OK5opqUa4YDqjdF6G4Lds7SHJmE2eXHLp4FZjpeHSbn9qPZA6PFtBIDVsX2BdKPXOPfseSDULkuvYmOsiBAz6Q9CJt5jrFXkSg2xaHn2MxrlS5DpmKVWpAAhjut+x/F9e1CjutYWnLkRad3iUktTZW7U0lq0yDUHWnkHwZH4oZ2dLZO676ypiScnBZ9gYN5XCdmayN4J3M5LQH3riLIhiSfifhBB3XArT2VohXe2KN9GNJYZh6V8sGliAvPG2ZaKBeEOwrgBZIsR0g1q1g936N6r4+/QubVcGGml0h62p17ujv3i/KzcUWpbKTf2r9QnnZJpHJSFmuUVTbgN4aCaTUycHT1rRll5Cmdmb9iKaicyP/EbziSHm5Rp/kZ/inmwdKW2IA14XPe4N988BExjwPOzdxEGcI5QfXj2E+I8R0JuzM9zv0enJ9xh+Rxc/cL1yxwb5ibshLutxAVlMYWhKWuk6MHtmGBKRHxlaUS4Ngl4lQHe7R1PvD02UIWwGyJAcvQN0F3GRNiLxabOj/gaKMSkWP69NsQRcdCR5etIE7gZbH+af/SrL+VEhMtYhM2DKE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdvUjJSQVJQemYwN3pkTENSci9PM1luK3ZCbzVXdHRMQnRNdHZ5Lzc2K05G?=
 =?utf-8?B?bi9RYlZKZEF5QVcyaGZpUjlnaTBzblY2TVRVRnNxa29YRjZ1ak4zWU5wUk9l?=
 =?utf-8?B?dkJVTVU5dXE1ZndPNFdhVHJuYjArTitpL1ZJMVBJMHIvTzBiUFI0WlVQb0pI?=
 =?utf-8?B?MXFqeDZIbW5sVUhaU3RPT3ZyRHk0QUk1QmhObFpoSFV5cFdOZko3R0IrY1Bo?=
 =?utf-8?B?a2kwd09oa0F1NmMwMlJHNWUzTU9ZSGJuWEpEZUtiVTRrNTd4ZW1LdFZVbXNT?=
 =?utf-8?B?VDExTER0V2NtUGhQdk5VNWZlK2xlTk5zUW1wMDZ2VFRDeU1zSFdFdTdDYmlm?=
 =?utf-8?B?NDFma2JVTFVxOThLdHFBQmRHTXBCY3JHVGxkcEIrZEh2MDllZitEdnlTOU9M?=
 =?utf-8?B?dXl0aVlpOUZRcFZaSkVva2dCZ3gwanJEaE02SzVnc3VaSXdueVd3NGxCTnZp?=
 =?utf-8?B?UXY2dXpyd2tJMW9rMDF1K29lSitKMTdjTXhPNjJmaU1GV0kzR0ZnRUg3bGto?=
 =?utf-8?B?WGFLRjYybitoSFNvb2taamZFdG5wMXFQMlRrQ2ljYnNVSEdCY2NZRXMzNnRq?=
 =?utf-8?B?UllQSGYyMWgyYy9zdkFxZlVBdVJCNTVlZEdHNnZ3RFhKa2t4aE9Qd1ZxaDFX?=
 =?utf-8?B?WFRGZUVLb0tIZE5ENHZjTWJvUDVvTHhkbHpoaFhJOFV0YW1ncWNNbHpuTVox?=
 =?utf-8?B?Qk1NalIyWDZ6Wmc1c0NJRCs4dEtuL2xkVnNnNzVwTlkxMHJBVHBYTnhvSjBR?=
 =?utf-8?B?VHd4NTh1TUx0eEtkcW05dFZkUjBRbHU2QmE0NEUwbC9xdlVvRlhoNjl3czAv?=
 =?utf-8?B?bVJaUHdQbjN5ckpLTWV6N1FHTGszUkc5T2FCNFYxOWJiV0VXN2luSFovTlFV?=
 =?utf-8?B?RjJnbTcwSS9IMzhCN25QNlJSUnlXV0lsWFp5eGd3QlU5UStxbjVqYlBJTVVZ?=
 =?utf-8?B?T3duSmtkbXcvVFhLdGQ0UlBrNVBjUWNYUlAxc0xBSlhXczJkTGpkRUw5OWhH?=
 =?utf-8?B?cldha3M5YTRnd0pab2pocm55bVdmWDk2ZHZZdEprZGR6M3BNQjVsek9sbmhN?=
 =?utf-8?B?aTZJL0NMYUVFS2dqTnR2L3NhZkczVktIQWU4OXkxbTBXSStQT3JMQTZsRnZW?=
 =?utf-8?B?NU9NdzdPTlcwY1ZEQThBTkdIVmQzWDJ3SHhlM0Y0TWpXRGpLTTNMVFdldDVw?=
 =?utf-8?B?K1BsZ2hIelVOMFV6Q1I4VkVWUzIyUlpZMWUrb2pOVzZablQyYmxYQ3duZ2RL?=
 =?utf-8?B?M2dCSytQY0d2L2VlQzZDeXBGd29zMjhZdk0vekRxS1JETEl4MWRjZFN6VTVW?=
 =?utf-8?B?K3J0MVZhRGZVY0xsdDRhQTdMTnVSTGFXVjBGVkxTcGoveEpGMWYyMHIwL3Vp?=
 =?utf-8?B?RDFKYTJ6QUpXeVN3UW5tTmpHVGkxaFhZanpYbmIvRnF4T1Y5OS9udzNodER2?=
 =?utf-8?B?WUNuNU9qcVJXN3dYRGZMYWtneERLdm5oMDFobjZsMHZ0VlN6WUJ4clo5Qndx?=
 =?utf-8?B?QTVyVDZnQkhveVRBUmxsUzdkWFpHTXkvb3B4dS9na3B1eVdNR0NlSllvd2di?=
 =?utf-8?B?djFzVWxDUkZaRzRZTndQN0JUdDY3aDVpZlk3bkhaTkYxN09wRUx2eVdrNWph?=
 =?utf-8?B?NklReHBMSG1MamVnZEFodHFXR3Z2bis0MzFEMi96eEZkakE5cFVoMUtLS1pV?=
 =?utf-8?B?Y3BmU2hFcU9BZTFHQWNjUi9pTmE2eWxQdEdrUVZ3REZDUHZOQlNGenJweUpt?=
 =?utf-8?B?MStGZXpETWdla2kxWHhkN3BWWC82QklHZjRhQVYzS3ZlREx6RDlZOHhOSCtJ?=
 =?utf-8?B?ZjNMMmxHREFPMWEzdmczbnJJL09RR3FzTG51UHo2WGJDbC9EQTRHczExdXZv?=
 =?utf-8?B?cm1USEYyMWlwcmRWcldjMnpNWjBOOFpzenRZQnA4ZGNRdE9Ba0lFb1ZjZWYw?=
 =?utf-8?B?eWZWTE0xRnFGek1OYi9YVzZuV25iQklGc05vbG9UeEJqVTJmTGpiZnVySHFK?=
 =?utf-8?B?YTE5dlJROG1UbnRMcDFCcGRXcXpoSTlvR3VUcUcxUGlDUVRKZDArd25LWnM5?=
 =?utf-8?B?eWNmazg3TUdTNzBQT1lOZzVXd1Z3enVqZEV4bysvKzVvL09aY3pDT29CTDE0?=
 =?utf-8?B?TUx3TDlBYXlDY1R4QTNjS0RQY0R3SzNKcWh0dVlRUGdWUFRJOUdjUk8rMzRR?=
 =?utf-8?B?dlpBeEhKRVViRU1pT1czTjhITU9LWnFORndTakt1YWc5SzhjM0JjQUNtcGxj?=
 =?utf-8?B?OVo0MEtxTjdtRlVXZFdmdGttd3B2K0VwSnZiK1loNnRNVTZBeHUzQlE5c0ZW?=
 =?utf-8?Q?Z90qGG9sRI8uwvsM4U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eN2Zh4zxKDvDMyVUtacMra2lxRaggU5Ek6bM2ovpcIat3vmgCpIM+p7KqLCIFY4M91HsLxgZeH6pFQfPv7InIJ7AeFGjymYj+CHh/rGniCW/ivQEph3LpnPnP936uO43w19UD9CUGFSe7ue9RvKV4B6qi9pzK4tP/2lxxYVO3qqRwIwNdl0fvkEUIDRRhzmtxLDcxof1qjeEtSiwaVeXrYIgTOJJ8gCwySS/6jTgpRpjhYqgodikg5uq7+vo4SgGyIG/vwELz0b8yEBOP12ElPcyAvl7IsnSERye9f1ApEn46nJQPgZE5vCdKolsPwFFk/miEsOx36C65ITFTQ2pnQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d407c579-8e03-46b0-adf4-08decef6e955
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:08:20.5132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJO99GXPdwEU7NOaer1LPBzYGhFs9fSdx7gN+iMbDMr4jXbmVCLsMWYxYRtP1RpgcuSCVHtq06HZZ0u5o/BaEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB927519
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE4NCBTYWx0ZWRfX6Wga9M8a6DFO
 rgR5OMMgtjxQS36nTGHj0bsBVZ5OKnyMtSX+ZAqsM3XS71ByZdt2ONHgWN4T44UaGgrAe4fEORD
 IN7vrpv/2dHp11jhTjPVN0jvPDJ0rNnJ+yHfomi7C0zFKZ+Ujc8AIpez7eP7ONXCzORdjOmli3z
 klviCqR0Ou30H9TaGjeJdhm+6ryAOT5QHCbvw4QH9kLKC71KZ1mGbTMsRBo8oi4V5gHsFxxbz/4
 U+1zTdgG9d32kaIzYhehfkLB6fR6rIt7K1EHkIp8w/8wP2yPWm+QzxMc9zjWV4bO01xMrZWGpoE
 nWsv6df+JVurpX/t6hZKEXERYPCB0zdwM4rJfE0aBbXuwXd9qP5uR3hPV2t72fL9YzE4iKPm970
 QNOnFtVL9qoD3TKwim5XOqqETi1KBWV5FDbSOHg69HYDXMhf9hiLOHzE8nIE8wfkoMGoo9fa7TJ
 mdW1/xNSrHYFP/mnwhQ==
X-Proofpoint-ORIG-GUID: 7TvIyE3ENJge5u_vfA6h7N83FSyj1WNu
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a36d717 cx=c_pps
 a=V5lscarYawUrr6zEozVj7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=N1fdeQFv0UXAgfgkPfAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE4NCBTYWx0ZWRfX621lYgivES6H
 cPA6/9KmI9M7QW0uq6Z0LBfud82Kx7rRvOg1jts/+9FCaDDmvsgzlzie9gMU8MYPA1KCS9EKtVM
 bhIg8WB5Wi8TOU0Qu7bxMD0QstGs1L8=
X-Proofpoint-GUID: 7TvIyE3ENJge5u_vfA6h7N83FSyj1WNu
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

DQo+IFN1YmplY3Q6IFtQQVRDSF0gdGVzdDogc3luYyBzb2Z0IGV4cGlyeSBjaGVjayBpbiBpbmxp
bmUgSVBzZWMNCj4gDQo+IFNvZnQgZXhwaXJ5IGV2ZW50cyBhcmUgZGVsaXZlcmVkIGFzeW5jaHJv
bm91c2x5IHZpYQ0KPiB0aGUgZXJyLXJpbmcgcG9sbGluZyB0aHJlYWQuIFRoZSB0ZXN0IGNoZWNr
ZWQgbm90aWZ5X2V2ZW50DQo+IHJpZ2h0IGFmdGVyIHRoZSBSWCBsb29wLCBiZWZvcmUgdGhlIHBv
bGxpbmcgdGhyZWFkIGNvdWxkDQo+IHByb2Nlc3MgdGhlIGVyci1yaW5nIGVudHJ5IOKAlCBjYXVz
aW5nIGludGVybWl0dGVudCBmYWlsdXJlcw0KPiB3aXRoIGZhc3QgYWxnb3JpdGhtcyB3aGVyZSBU
WC9SWCBjb21wbGV0ZXMgZmFzdGVyIHRoYW4gdGhlDQo+IHBvbGxpbmcgdGhyZWFkJ3MgdXNsZWVw
KCkgd2FrZS11cC4NCj4gDQo+IEFkZCBhIGJvdW5kZWQgcG9sbCBsb29wIGFmdGVyIFJYIGZvciBz
b2Z0IGV4cGlyeSBjYXNlcywgdXNpbmcNCj4gcnRlX2lvX3JtYigpIHRvIGVuc3VyZSBjcm9zcy1j
b3JlIHZpc2liaWxpdHkuIEZpeCBzdG9yZSBvcmRlcmluZw0KPiBpbiB0aGUgY2FsbGJhY2sgd2l0
aCBydGVfaW9fd21iKCkgc28gdGhhdCB0aGUgZXZlbnQgc3VidHlwZSBpcw0KPiB2aXNpYmxlIGJl
Zm9yZSBub3RpZnlfZXZlbnQgaXMgc2V0Lg0KPiANCj4gRml4ZXM6IDM0ZThhOWQ5YjRmMiAoInRl
c3Qvc2VjdXJpdHk6IGFkZCBpbmxpbmUgSVBzZWMgU0Egc29mdCBleHBpcnkgY2FzZXMiKQ0KPiBD
Yzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBYXJuYXYgSlAgPGFqcEBt
YXJ2ZWxsLmNvbT4NCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPg0K
DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
