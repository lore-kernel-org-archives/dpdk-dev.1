Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD249C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E70244025D;
	Wed, 14 May 2025 09:40:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 38EE340041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:40:07 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNTM0m028665
 for <dev@dpdk.org>; Wed, 14 May 2025 00:40:05 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mfssrrd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:40:05 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E7amCY020134
 for <dev@dpdk.org>; Wed, 14 May 2025 00:40:05 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mfssrrcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZHFC5wEbVorGgm8LxRajbI8/C7L4fMZ0aypbtKuWuDNbZ6+fuQGnGDIK8W9omK6jMY5W6VmSPCaWcRlyoCkT5ZKsUlIzNUP6i1zX74lzd1/nW5mdqwpi4WI6BpDRyijsLSszHqqemvJz3ovjf9mTF0TPEmx4ZAVlzdA1e2vAx3qqF36gJXpTghtJpDtMT95I8oAbAhjHgNST4HnFp8nrhXcmR/QWbslU2EjTFqFwSOR36beyAH6rwUuBxtQIRKuUexRA4AwmgoNUK7GxMudztX+L4qSLcsvmW4vJ/GmLJidC1vHYUT9Q9rsFwYneU5sBR86Z+hmmiD4TA5wgPtc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P75F5MaYIknOfQHoPub3qErvc/GL4x1DmNUwcdf2ATc=;
 b=iL09GuxUvqXKkDo6Rhdr2+/bz5OXQN9XQbCKvau3pY4wOxSpIdv090XMObri3qdkUGF2tc2Xp/jTKTjlvmE8ucxt8+dGfvzjwGRrOW0ZZx3HSJB/S7p2X/NWtkyZL8/9wbao/VpP4+2yWiPgTVy2xZPHp8qAln+ns38d3IhiuP4pTi/dR8a8dI8uxs6PNvn845tn+Tk5R6M03MXMIOkSD9Gae/B1JVjNevg7l52yGsx2Ob9hQzUN6ZH3SF7wpc35Nl7BwjP5pg3H351S08w4HaYUygmoIT8cSoDJtzJ6YlEnAwvV4s0yK4JE86lyjLhxseJ/9VRl6QiQIyndclsCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P75F5MaYIknOfQHoPub3qErvc/GL4x1DmNUwcdf2ATc=;
 b=n0QDT9K9FSWu2/hX6Av2hgEm7LCdWjAABLdawVRcfJy7LezsaWufVSqJE9qJXzmvFxcHpeOwt+nAli6nfqJWzTgQ9xMi6eLOefKyMBKdUwYabbskytDeIeAAAoUYX+cJsoMTLlmxVW2L3bapk4TTdhXmrgdsjyGOal1fmbz5TW0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB5264.namprd18.prod.outlook.com (2603:10b6:806:2e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 07:39:54 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:39:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 5/9] crypto/zsda: add session configuration
Thread-Topic: [EXTERNAL] [PATCH v2 5/9] crypto/zsda: add session configuration
Thread-Index: AQHbjBhOO3Kkkpd6E0KY0KJqr8hCUbPSJr1w
Date: Wed, 14 May 2025 07:39:54 +0000
Message-ID: <CO6PR18MB448495DF7F67455EDD226D04D891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-6-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-6-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB5264:EE_
x-ms-office365-filtering-correlation-id: 8589abbf-c27f-4de5-bc27-08dd92ba84a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M3hKblBxNXVleXRWVW5UQ2RvKzh3V1Z1Zy9wMUpFY3RLWFAyRllpZ01HU2JR?=
 =?utf-8?B?TlpYd3NNN0hraEJzMy8vZ3NwWG1FVHpLM0hnZ0l4eVNzcUJhWmNLYmFrUFZy?=
 =?utf-8?B?VzB6U2QxL1ZrVHdTSytYYlBjZzRYVkZrOGZwd2wwZG41eldOK25LQWEvMHV0?=
 =?utf-8?B?K2xsczdDRGl0K2E1ZHVhVGNGeWhqZ3QxYk9sM1A1VEN1dVIyZFNDNWVpdjNs?=
 =?utf-8?B?RkFGRzQwN3lwZDFXdkUvNWtnYkFyYWVoQTl1QXJuTXBtdUdzdnFSN0xQVThv?=
 =?utf-8?B?WWl3ZE04SzlTbzB1Q0FhZ2xGTjFhVUE2YUNDMnV6RVh4TXdOMnd6S1N1VFp0?=
 =?utf-8?B?VWV6UXY3SWl4UllXY1Bxd0h6NlVhaGVBMXpFTWhKVE15ZnFVQnNPYkFEUXdJ?=
 =?utf-8?B?Uk5zMU5aWW5tQ212dTBwbHg0RTJReUtrRkdEYkNVbHlNZ3I1eGdtMEZtWjkv?=
 =?utf-8?B?ODNCTjNkTXZaRkhPeUViUzlOVEcvbFduRHN6SmZUaTNDZjVQbE44YnNBVjlH?=
 =?utf-8?B?MW5nUi9XRWJEektCcXk5aGFKTGU0dVB5dVF1ZG4wYVN3Y1JFWW1zVmQrelNW?=
 =?utf-8?B?L3l1NXowNUh1OTAwYW5Fd0wxV3p5OFg2dC9MN3diSHJUZDZkaHpGM0ZYTGQ3?=
 =?utf-8?B?OFlEc0xGc1YzT3JsNURESzFyTURsZFNFNWdZR3RnNDFrVUU0cCtLU1RGdEJ0?=
 =?utf-8?B?NnU1VHlLVGM4UW5hY1Rmak8xd3NrcU9wSmNQWDJzQlBaUWxMazQ2TGtoMS9L?=
 =?utf-8?B?ODRqWEZCTkVaSS9RTjEwQ3RZc09DSTZHaGp3aHB4Wjd4OXVNUVRUakM5Tmow?=
 =?utf-8?B?cWxKTUtPdnRpOGhvNVBCeGpyRDY2elk1ZXJjMmlxa0dPcHJmK0tjRGthdlY0?=
 =?utf-8?B?NURDdDJJTXNZeE1lQk1qdE1CZnV5VnFjY212NklLWFpGc2s3NldUdTZVdVd0?=
 =?utf-8?B?ODh2eWplY1MvckdLZjYzM25lNTRkbVJESXZNa1JEUU11K0lLNGpEZUUyOVln?=
 =?utf-8?B?WmZ3U1RGeUhaZDJ3M2V6MEJzd2hVbnNkaDZkdmdFT241KzMwYTN6eWtmOXo5?=
 =?utf-8?B?M29HWHlGMXdxVlNzQVAyL3owck1meU9EYWZGdjJzUno0N2pJTzN1aU9BNjhQ?=
 =?utf-8?B?U2xKcjJNODEzMVFiOEZzRDZCMkZXSTFuTU95ZStrd1dORCsxOFFRU1BHNnJm?=
 =?utf-8?B?cEtzN21mS1AzdnR4d0p3ZDVwZlFJc3hHajBOY3hycStrMi9KZkNOVDFnam56?=
 =?utf-8?B?NktrVHdIS28veHNqb3lUVmo4ZjVFbGUxTXp3Z0I2SHZiTHc1OS9wN001b2Yv?=
 =?utf-8?B?WDdCczlEZHdERzJFelBtblVLbUdsdFFZQVlwa1pjZWNnWlRMTlE1RTR1VE9x?=
 =?utf-8?B?UVhXdGVXVFVEVTU1Z3pwc25TWDYyMHJndHVCL3V4WkNyRUlOQzE2dC9BWG1w?=
 =?utf-8?B?QVRYY3RqRnExMG51UGphZm02ZkRaNWVLWTMvaGczTHlJU0RxcWxBTkNpeVVD?=
 =?utf-8?B?OURYTmlzcm00bDdmR2k5NmZCd3dTOThFRkx3dC9tRURxcVByNmYvRHpGZ3V0?=
 =?utf-8?B?aU00VnNrM3BUR2tXZy94dzMxYzVuYWNHQTNOeEpjTGZ2Q0o2b1hKZ2l3TnV3?=
 =?utf-8?B?WXo1T29wQ3I4VGQwZTB0S3p4TS9TNE9zOFdTV1hHazBOYjEyanI1a01ydUtp?=
 =?utf-8?B?dTlrOTNDdDFmWHNaVE5xaHJJSFRNaitzd3Frdk1ZUGtVbXZERi9oVjNhT3Fo?=
 =?utf-8?B?ZHR0Q21NWE9aTTdkR2FOR2V6bUlNZU9sYTVaVHFrM05yZ1A2MmYrOG1ZZ2lU?=
 =?utf-8?B?eDFuZ1U0TVpPdjRwdk5OUGhGQ2pkNDBvY3lRcEVjVFlYN1ErTDg0eTNEa1U3?=
 =?utf-8?B?VXBqVzRyRTRTUXNTNE9odVFVb3dxVytLczkvWW9NQ2VRSUY1OGNrcWdUd0lZ?=
 =?utf-8?B?RWY1ekJQWnVzUWdXRmZ4Nnd0Ymh1bE5EdHpyOXAvbXIxR0lPQUxXc244Y2Fr?=
 =?utf-8?B?SDY1Mmhuc2VBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVYyVFpVZVM2aUp3NlpYeHRWdlZySDlXbnJrL2M2SDhXVWgwUjB4eFdvM0dH?=
 =?utf-8?B?MnN6UzEvblpST2tMbVVlN3AvWk93MGVpMGZjcXZDb3FKOG1HTnAwbENsSEUv?=
 =?utf-8?B?STd5K21PbnhFbi9iRVVqTmdCUkxRR3BGcWxUZldjVTJ5T0R0OTV5K08rZ2c5?=
 =?utf-8?B?Uldqc3lIa2k5UHFXYWVXYTdobnY4NW5NbEZ5TjhpSm9PKy95dWVuUW5LcGVH?=
 =?utf-8?B?NTFqeFRuaDl2OXVyNml4RUFFdUZxeHFBZFk5Q2M0ZUhHTUNKQmxURXBMSzhS?=
 =?utf-8?B?ZUtvOEkrZ3Nxd2ZsQ0RpUExrSGtwVVJQWnRGTGh0Z2JyditqNkx3eFcvcUJs?=
 =?utf-8?B?V1JSdmhJZ3cvbHpBVytGbHhSTlpXNFVhczBoNkhSOVJkZW9zU0xzRVd1R09t?=
 =?utf-8?B?QWpsK2pnVWJlTUdnSjlVVFltZnIxTWN0b3o4UDRDcmNTZTRESGM4OExBejdH?=
 =?utf-8?B?dUUva1pqenphR1g2bHRNUFJwdlJiYVJkbnJsQWgwa083aExxUlVWaTNDa3hP?=
 =?utf-8?B?czRucUIzNmpIQU5tRnFGWmxYMURka1BqOVJNc2Nrei9rdU9TZk5sMkRZNmx2?=
 =?utf-8?B?SWdOdjhuMXU3Znd4dFhERkdDdWV4d1VjdzliMzlCOFpyTXhNT2w3SVFHYTZX?=
 =?utf-8?B?ekhrQ2VicHVoT0lqWnJRS1JSME1Ebm1yNUkvQ2oxYkZtVmlvbGpTckorUGYx?=
 =?utf-8?B?T0t0eEJ2NGhqUFh5VkNJNVVXd0FlTkM0eXhicW1YUWVYcjZXMjlJNitXc0xN?=
 =?utf-8?B?U1M0QmU3cnplSERXN0dZQis0b1k4VFFRWm9QMFZsQUF5QUpONTE1MEdIcmRQ?=
 =?utf-8?B?cU5TNEU1NE1EejUzRTl3cy9nNXhWVmtJZGh3K2ZLZi9ZYXJsZUNSTk90U1ZK?=
 =?utf-8?B?Z01hdFd4UTdRbzdhbU1PSzRHaUVWZjZnMlZvK013SWh1aEJmcmY2RStNZEhi?=
 =?utf-8?B?N0pkY2hlU3BXRDk5cXc0Vkx6R1dDeFBvTnRJSi81Mkl6VGhmaElrTEt2YzJP?=
 =?utf-8?B?SjFaY1RXWS9LQXVWR0R4WlZGYzZXcGw5ZmFMdHJqdURxM3grVE10cDkySTRZ?=
 =?utf-8?B?Umg4R3BTM0FZMHh2a0xWWWx6NUdic2dQd04vaGptenluNWJxVFpmUmJaVkk2?=
 =?utf-8?B?ZWxSeFVFWFJIOGZCaHljamxEYmhUaGNVRHdUTGZqbTF5ZlJObnNGK3pibTZ1?=
 =?utf-8?B?eldaMUZvSzhaNHVOR3JJQ3puWXd5SERWOW9ENDFnREl2UHFHWUNtdENsR1lS?=
 =?utf-8?B?TlpPbSs5dStiMFRHMmZSTTFxU1ZSQXZqS0QvVlNBa1E2RXFLZDZvdmtHajQy?=
 =?utf-8?B?ZlQ0QmdLK2w3T0p0dDlUTFp3L2l1SG9mU29ETHJ1cFRFQ05oK09TMXFoUm9z?=
 =?utf-8?B?dnpocm9iOFF3aVpqbHRVSWNabFE2Nmh4NElVWkZ1L09lR3dXZEZxYm82SEJN?=
 =?utf-8?B?NTNaV09PN2kzMkkwbmlMUThCSnZ2ZklydmVFendEKzVvNXEwTytqdSswNkl1?=
 =?utf-8?B?ZTRGZjgwWGI0dUMycDlyY3I2T3ZIRU14REJ4cjEzTHBscEIxdUgrRlo5T0Z6?=
 =?utf-8?B?STQ5RklJcjR1YnpLc3hhTXFTMkpIaHE2MCsxMVFQWkd1U2o4R2NUNml1VmxQ?=
 =?utf-8?B?dWxlejhUTWo4a1hBanl2UVhIN3BHTGN0VFYwQlI1V0dJb0s4T0w5YmUxZkt5?=
 =?utf-8?B?YnJSOGY3ZnVSTDNoYmRjWG9WREZFTTRhYktNZEsvTHdUOUtUeE8xWXF3bXVi?=
 =?utf-8?B?bWorOHBHN3oyVzJDeHpjbmtXMWNYZk85M2Q2UXJHUWNETUhqMDdjTTdicWdO?=
 =?utf-8?B?azY3VWpEME44SkZ5WFlScGswOEZlOFhuRER3d0Y4b3UyMFBjYnd3MXNqNVg0?=
 =?utf-8?B?dFJvRmtCWHc1Y29iWjBkemF2NlJFY2JHRmp4L0hiQTlCSGtPZTF6cnhRNG1T?=
 =?utf-8?B?anpvd1dqTGYrS2Y5c1BOeVlWUTk3WHAzSFRxdzVPL2dsT2JLQXQ3Wi84Ump0?=
 =?utf-8?B?OVMyd0tpOC8wNGlUbWxvMFN1S0I3NVZYUHFvVW5UQUtoM3N6bHJPZjJ4TFR5?=
 =?utf-8?B?QU8rTjJaN0hFeW83VDRoeVAxdHFxSzlseElpanl0NWRaMXM1amhuWDFtK2h6?=
 =?utf-8?Q?xyqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8589abbf-c27f-4de5-bc27-08dd92ba84a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:39:54.3466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVZw4D6AFjKv1ja67kDLZD0d45v/G1PrnOh7dnj/1TWdTn3XJ7yqzMCA1iXyMCSTHhhp7Pbe/1HlC9DaP2Y4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5264
X-Authority-Analysis: v=2.4 cv=OvpPyz/t c=1 sm=1 tr=0 ts=682448d5 cx=c_pps
 a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=SPnPJLiAttmE5gJrrxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DAfnAvonQ82q_eIAkUG3Ai7E3Y6O8Sx7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2NiBTYWx0ZWRfXyRSyWP8GyGMu
 eQfSQ5Oq0IsvTBhhqZLYh0xfbY3OiuAtmZ247VXIwRRvT77Al7yiGB82Lvd9MY9sDHYQ1uaj5qu
 A9TD5pgGW5YqnIrXrqzq0FvQANTb0JcieR0PKAAcwjq2Hq+tpebd4ZGAofSva5lmkrD9Khyjbdr
 jGTQEXU14vmZFANBFU9k2wh2L3v0oNRFvYOEOV43faXdY3/tZz/I+ydewj5kDTzqHej5jte2jQJ
 pxbB/plVn3DCm7JyPccJd31f/KHjjSEWoMI0b4nG44zCwUgSetj+StlQYOv1+W93YlxvBi93pD2
 /pZczQ9RjsL1ctadTLdZyj7/NwwSHoE/FUMnfB3voIbgVC20Vrtsn6xBhZeLZ07whgkTnRI2RNn
 vOyf3k3+dNuZtQbFXkZgPkFhWVT2OrDnSYxzvPLRb80yWWGJdnp1FH/CsxyJ4IBY967xfQlB
X-Proofpoint-GUID: O7gvZc6I-uhq2NBOuOCOLt31SELYy3lZ
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

PiArc3RhdGljIHZvaWQNCj4gK3pzZGFfc3ltX3Nlc3Npb25fY2xlYXIoc3RydWN0IHJ0ZV9jcnlw
dG9kZXYgKmRldiBfX3J0ZV91bnVzZWQsDQo+ICsgICAgICAgICAgICBzdHJ1Y3QgcnRlX2NyeXB0
b2Rldl9zeW1fc2Vzc2lvbiAgKnNlc3MgX19ydGVfdW51c2VkKQ0KPiAre30NCg0KSSBiZWxpZXZl
IHlvdSBuZWVkIHRvIGNsZWFyIHNlc3Npb24gcHJpdmF0ZSBkYXRhIGluIHNlc3Npb24gY2xlYXIu
DQoNCg==
