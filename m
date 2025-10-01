Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04317CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B12740A6B;
	Wed,  1 Oct 2025 09:46:48 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2737C4025F
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:46:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917fOxl004250
 for <dev@dpdk.org>; Wed, 1 Oct 2025 00:46:45 -0700
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021142.outbound.protection.outlook.com [52.101.62.142])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49h04fr0c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 01 Oct 2025 00:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv5TbxiNmJJlvj2HwzsYc167c2NFhsGELTWxjoblNWppu4B6TMhTUf42UCfs/zaRjf3gvl/RW2rGi4l5C/UMuh6U7xLkyUpCjaoj56JPfFSGtrvlu4Dv6+h0HJZnAbCVHW2MVTE7E+b54NlVhMiaZYqNA4Uz3QC1BdTQSw8o+AIRVGsrq27QaQ1b8/2lcX0oWFYq+FncL+pHpTevoqOzuUqopD4RWwAWAJOHPbwAsOIGnP5JKwpC3Iw6X6v47WL2tiI2d53uPNe+QmWlRl3VVypV2Jq3JjgeV27mpgIgR8EVzu2yS0mk/BWjUUG1BeYwX78mCiHS2i0V2WHUpaQGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oBSs6lAw2SKNG5IuF/JtYEXa7rl8Iv+9gvTm9ZDJ6w=;
 b=dr4UfR2nzsIapp+F3B1+eYiSrc0C/1kMf46HBAtlO+WM7lT8bff2XaN7tswiwxvRrsKhZG8nzjCiqtZJVNoIfcV94QpXXQrrxI5ZTfXrBUeuQLBlAKXS3MUvcXsTTjOTqykcry3dJfp+164GdP3Ls939uuFM1dg5yUsbx7/ANulJZdLyF0SBb7X7aE3u05MjhLc5Bab5NdkJnI5VsAXMapTWuNSZcJeW07u6g5mZNtdI5eZWl8xRIOEiPK5MU7u4kMm3Lz6EWKQGp+4ypIcPNgo/hnbFudcCOztWCRRREYatJcAZXXgE3sga7gXBkdK6FfNAtW391LhMjfCMvUTC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oBSs6lAw2SKNG5IuF/JtYEXa7rl8Iv+9gvTm9ZDJ6w=;
 b=K2s6Wl67rkITaHZr9wu080ZNTj9Rk+eYtU/XzWtr7uPTYNpoygRwMd8mf0g1TS1ar8tkMRk5CEU8j/lz6DoEKUoq3/mOpHUCbomOk0niBxQ8rCUdpsNiUC9U7jL4GFyjcYHR40ddmQhMoCF+f9ACo3Sg1csSTkBfXoiZ1s3l7PM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF1E89B88DC.namprd18.prod.outlook.com (2603:10b6:518:1::c8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 07:46:42 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:46:42 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rupesh Chiluka <rchiluka@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Rupesh Chiluka <rchiluka@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: add ECDSA P384 support
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: add ECDSA P384 support
Thread-Index: AQHcEL/l9cd88g8L+0KVJOO9iuTZE7RpbTMAgEPANpA=
Date: Wed, 1 Oct 2025 07:46:42 +0000
Message-ID: <CO6PR18MB4484B67F0A3763D0F822C156D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250819041517.1638717-1-rchiluka@marvell.com>
 <20250819050850.1650503-1-rchiluka@marvell.com>
In-Reply-To: <20250819050850.1650503-1-rchiluka@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF1E89B88DC:EE_
x-ms-office365-filtering-correlation-id: 5bd0b9f9-5384-46d8-4a5f-08de00bea9d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aXFJOFI1N0daanVYZk5uOUwvVExicS9Ib1ZEek82Y1lmWSt0RUpQNTBGdUc4?=
 =?utf-8?B?NXZneWQyMTNXOEtZR05QK1ZHT1ZKSWtyTjBtekw0NWlNT2Q1bEhnMUUrZEN6?=
 =?utf-8?B?SFgvMUJiNnNuRjh0d2pkeGlOUDkvMkRpdFFsYnNZWlQwbmhNNmZxK1VaQWJM?=
 =?utf-8?B?RU40bjJRSmw1V21iL3NUTkpWTHhXSVVuRnhuY2RjUFN0eHJOeG9OMmcyc0hu?=
 =?utf-8?B?QzhFaVlCMmMvbHMveXZJY2QrN3dUeU9IR212M25LMzF0Tzd3ZTErVDZMdHI3?=
 =?utf-8?B?MjdiRzl6MSs2QVhIOWIweFlHcWwvZXY1eFkveTFmY3RhcnRwQmhZZG5YK1M2?=
 =?utf-8?B?ZVVHeUlXVVZ0ZTl4MGJ6SGhhaFRiaEZRYkwwNEFqYk42RE9FQXdNNnhHUXdq?=
 =?utf-8?B?V0Uzd3NKWUpuR1VWejJqK0lkTmVPWWR6MWU0eHVsMTVmWWd4YWNnb05pazJP?=
 =?utf-8?B?U1FWdk5MQncxS1pqT0RVc2pKVS9xcmRjb09FbE1rMGpWWXY1SzdDSnpxNWZ4?=
 =?utf-8?B?MWZMODg3dFI1YTNUcFRXTnBSaWEreUEzVXI1bzJLNFkwVnV4UURBWXZ1MFVQ?=
 =?utf-8?B?QjdzZkR6ZnRCejR4YktjRVBCdW54dlYvZ254NFVHdUE3aDV3NVJEckRBaVc4?=
 =?utf-8?B?bVNRNHp3S1V4Y1hnU1JZbXRCQWFqbmxCcC84TkpJSDdhc21XZGo1STBKc2p5?=
 =?utf-8?B?VFYzeWtHSEFZUUx4TE85cEhLaGRmQkl4aC9qNys5N3VsaTl0L0VBajFaUXNF?=
 =?utf-8?B?bThrMXhORDJNUDVzTmlXMy9XL084SkpPNUlUOElLSEpES05zNUxmdHhHRFEx?=
 =?utf-8?B?QTA5Y0tWejVXMEhQeDVFOTErZ3FXUmNQdTJUUE1QSC92RE9WWTZ5alZZc1Jn?=
 =?utf-8?B?T0hKTm1YOHFIM2JSalZFRGlBb3pyN2RUWW11Y2s4M003QjIrd0lXc2pwdndH?=
 =?utf-8?B?RUVhZDM0SXd1NlI2WUEwd3dwZ0YzeWcxY21abnUwWkg4Z2NYLzBLQWhaeVky?=
 =?utf-8?B?ZkU3aFgraW01MkdEUXdSNGVTZ1JWMmNUbWFyYll4QXl3R0pKQTNKK0JCRjhm?=
 =?utf-8?B?ajNMOEpqK2x4R1hqOG1HQ3hZcnNqS2dPclExdWNVSkIzSm1rZ0pubEF0MkJs?=
 =?utf-8?B?ZktzWGRlMWZtZjkyZGdwSUFQYmMwNS9ITTdvT3h2dHZGR2JxdWtVd3c0aXd0?=
 =?utf-8?B?N1hlQW9FbTl4eE92MzFjbC95VnFBOTFML3E4dDBTeXVGN1JQSU9iVU1EdGMr?=
 =?utf-8?B?a09EaDNxUjN6V0UwTXdTRVpMWWhXZTBycDlHZ2lTb015Mk51cmpCZjFoVmlF?=
 =?utf-8?B?cU9TYW9lYzdRbnBhS2FRNkR6dFMwQmd4Y3FVOWZrNHcwbjljR0Jra2hnMXFQ?=
 =?utf-8?B?c0NDSzZBYm5LbUgrMmhXQTRHaDBjcEN0MzlEaTUzWTFFMEpXOTQ0UXFTSmhR?=
 =?utf-8?B?VURmMnloUkNlSHdqOFJPZmcwOVpJK2lCRllabjFjczJPQTFTa1pkalN0N1l2?=
 =?utf-8?B?WjZySHZHQXI4ZUoyNlU0aTBZSyt0WUs4bWdZRlNubHRsZlpSN3ZrSkRTTzlt?=
 =?utf-8?B?akFXbEZ6YkYvL3RTbTJneU1RL2RrbWZlTGd3YytDbG55K0p3czhLd2k3TEE2?=
 =?utf-8?B?YUM1T0YzLzZqYkhkZmRSai84c0d4WVE5SndBUURpTnExS0x5QjNiYjR4QTll?=
 =?utf-8?B?RUc0RUk5TzNHMjhYR1hMK2dIZjRSVkdvOE93YmYyVDlJelZ0OG9QZmhNdkxW?=
 =?utf-8?B?dTVLbHQ4K2VCVWhMMnl4bVUxR2JOby9kN2ZkYVJ2ZkFVZjB6MW9BY3N2Tys5?=
 =?utf-8?B?WUk0K2RSWUVhQ3kxTnhaVFBzQWN0UG02T0pieW40cEUzL09yMjUwZktNa3N6?=
 =?utf-8?B?WFlpTlcwbjB3TjNHN2Y4U1pWdDljTGxzSXB0WDRZVUt1Qkp4UUw5UXNSZlBD?=
 =?utf-8?B?QXljeDVleGN2a0lBeGM2L0NFWGNsQS95cGdFWWJRemdveHNPa2hseTR0MVhT?=
 =?utf-8?B?ZHpCdHVPejIwV2l3dnVFd2cvNEhJY0R3N0pzcmxGSUhtaWNic25Qc28xRXNY?=
 =?utf-8?Q?V2Nr4l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1p4Z2ExRTB4QnBqS1F4dUhsUy9rclVKVnBDNjNXRmxvQkg0WFFxa0RnRzE3?=
 =?utf-8?B?K1ZDcGxvaE5PdU5GVnVFVDkyTWZkL1QzamV4TXpnN1ZaUHk4T1VVVXdWcDVD?=
 =?utf-8?B?MEZjbzcwdVZZY1pORlNKMnoySXY3OG9Lc0l1dUNpQmtUVnFXWGhqNnk4QmlE?=
 =?utf-8?B?dlZaSnFVclNrQTg2TzFMdzY4VTRYdXRhcGFyelBoQzhOTit3SGFmNW04WmNT?=
 =?utf-8?B?OTY4SENPQ0F0UXdqZXc1ZWg2US9Jdk8xTDJiclUvekY5R0wvVlhhalFUamNx?=
 =?utf-8?B?MHhycmVSOWhTTG9vcmw1bVlHcTdDRi9HRytwbnNncEJucUN5dXZ2S2RNM1dV?=
 =?utf-8?B?MVh1MkgrQkwwYThjSnNFdGNqNkxPTkZYbWZ3VUxXMWZBQnBxY0lHZG9EZjRE?=
 =?utf-8?B?Ums5UC9mKzlmeEJwMkFaMjJRUGZaNTJuMi9mVHRCM1RRaEhrVllvRU54YWNU?=
 =?utf-8?B?N3RmOUNSTXJpWkZ1ZXNkb0xnSWxQd0RiN1BnYm5Sc20rWDd4d3pPd09STWRx?=
 =?utf-8?B?WkdiR0dTREtrZlg4Q0cxRlUyOU1OdmVHZUtQdkd3SXQvVXQwbGc4MThFL0Rt?=
 =?utf-8?B?YlpuSFpESW1NWWxQbXVGZlNwcWViZ2ExbFdObFlkTXRsWThFaHlvUktFY2dt?=
 =?utf-8?B?bGoralNFR0hMWUZiSytXb0kxbzRrWGpUWnN3dm1KTGJpTDIzSWgwMU9XaHJG?=
 =?utf-8?B?WUwzKzZxWDZiNXcrUXdwSUw4OEFSY3IxanRlbGVFSG5jaEJjMlo5azVIbno3?=
 =?utf-8?B?ditkM0xMOFFtY0VTZEYxMXdsY0MzSUo0NHUzdjluSE5nN1VOSkRsczhsYmx6?=
 =?utf-8?B?NzdMYldnenEva04zRTI4cnlMUFpMaEordGJkUUd6VEV4SnNZZ21ZRjJHYkZ1?=
 =?utf-8?B?VklUNTNTNEdNQXM3ZHpBRDZEYTNQWGRIcUh6NVloS3NtcGJCY0VxR0o5RG5l?=
 =?utf-8?B?YXhnSlFJeU53bW93eUpEc3BvckpHMXRSTkdSeFUzVEp1RnZBbnM5OTFOWGZt?=
 =?utf-8?B?S3g4dXdlZC9sUFFEa3Q1Zk0zZE9iUWxBTkRSSTlaemxjbmxHem9JeFhrbUpF?=
 =?utf-8?B?bVcrQWp4T1RRS0FUUXVZTE5hcW4rMlZuMWE1dWVocjJtVWc2d056TXlEbVo1?=
 =?utf-8?B?bWx6dDN5RjhOeitlVkhta2djTGtIVVY3OG90YVhQTnNudjlkTzB5NEdzWFl6?=
 =?utf-8?B?ejdRYnpzYTNab0UzMlNhM09CUFVPSlB4NXVCVHdoUUp4QStHeU11NDhjcWxH?=
 =?utf-8?B?QjNtdjZjdldJZHNwcnRLNVphNFVTYmNTSDVmaXBuQlBJMUdqYU51T0NXS01L?=
 =?utf-8?B?MGRIa1hPb3ZDR25wU1RJVkdYSk5EbVlIRHlyVzJvNzUyMWZjQ1lJM2R6OTQ5?=
 =?utf-8?B?Wm1Rc3RyWFFiemhFcnUyRVNTWnpCS2I4SHFoZWExeFI2Z0JnU0M0MENPb3ZO?=
 =?utf-8?B?SWc1Nkg5WEFWQm5NVDJqanlQN0ZkUHhPME8xUGtJTGZJR3RHM0xzZi8zSWlx?=
 =?utf-8?B?ZDJvNDh5TG5rbjI1bm50ek5LUUFadktiTWF4eXJkVkw3QjlJV3IwSkd2TkpY?=
 =?utf-8?B?b1VqanY4TkdPZm9Yc2lqNGpSWU9WTFdxb1BrV2grYXFLVml6OFF4TU9LdGtH?=
 =?utf-8?B?OE1YQm9WR0tGMjZCWTR6d2NRT1JlZERGWHB3OElsdUNRVjl3S0U2TUNWbWda?=
 =?utf-8?B?OE1ybjluYU9QNi9GaTJRSDRIS3pjOVdHV0VrSkRCL0cwWitkaWxqRDBJZGRj?=
 =?utf-8?B?RGszdnkwK21jVkdCVkRFcEQ0QVhKc1d1aEEyellJS3dNRDZlRExPekh6dGJz?=
 =?utf-8?B?dkhmc0tUOHlvNmZ3TTdFNGxyUW8yeTBDZW5oYStmWlpoRXArOVBJelhWNUg3?=
 =?utf-8?B?c25TckRIR1VTckR4dXBuWXBpQXFZL1cxeHZMOEJ1aXF4NnJzZkhHaFdmZXpu?=
 =?utf-8?B?V1oxdy82VjhEMGMvMUZrUnZkeE0zTUtsM24waVFjTGVraGUwYldNaFMwM01r?=
 =?utf-8?B?SUg3MStwdG5WUmNjNGlOUlRmTEhkM2Vzck10OHoyQ1RreXR4STUrMXdTazJF?=
 =?utf-8?B?YythQXd2L3JkYTR3STdkQWtaUjFrT01IN3YvNHU1eFdYNklVSC9xYnZqTXpy?=
 =?utf-8?Q?dOtqRrAvM8UM9KyKFg2wmGDAC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd0b9f9-5384-46d8-4a5f-08de00bea9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:46:42.6459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvjAMsIrOTG2Q5crnjXzH9XM/dia/JL3BUvtNBvo469cVfGq+duIa4/rv016O2+Twxi0tLCkIse8TGkfJra7iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1E89B88DC
X-Authority-Analysis: v=2.4 cv=OeqVzxTY c=1 sm=1 tr=0 ts=68dcdc65 cx=c_pps
 a=A3wBdPz/itNY2Bh/0u/a6g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=Ru7htLIpFPUtDhLFz9YA:9 a=QEXdDO2ut3YA:10 a=xImrzNact8EA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 25b_pruOU-7567DUhK_HQ3cTMsykdCeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA2MSBTYWx0ZWRfX1lWZLBLpLrAI
 EM9jsJUSOFXEqDa/JRNylVBHbWNHbf9t8+31Z7q+zgItp5+05km+JL6iB0ZlBLJDrFsQXmpOtWZ
 BoRSHoF38FC9znw1q87cQI54L11OGIkDO/lhkI1Gqa3lF982emLzn33MSqGc8bXQ7l86OzZZs0P
 adnSeV2LbOQGtoJOGVLq7ZwmGu7eHDD6yiDTQqpGpq3JDHzPmmUcyNQeYvl+bNsyToU23/I8ONf
 /hQOoGg1UNBJfc1OvgnIb478QZWv+fCilpthkFln0bxJ1+Y9LiJNIcmBCzJ3oJFAhNZ6A9y6YAT
 34q/aiFh5FjaiUFLulPNEkfyWJEOn44YRxqeEiyVcnOpP0OsZtUHn2QFHImv5fp2MjqX6qZINvg
 gCuWCWn6yTqH5qYfoag55YhSab3PYQ==
X-Proofpoint-GUID: 25b_pruOU-7567DUhK_HQ3cTMsykdCeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

PiBBZGQgc3VwcG9ydCBmb3IgRUNEU0EgU0VDUDM4NFIxIGN1cnZlIFNJR04gYW5kIFZFUklGWSBv
cGVyYXRpb25zDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSdXBlc2ggQ2hpbHVrYSA8cmNoaWx1a2FA
bWFydmVsbC5jb20+DQo+IC0tLQ0KQWNrZWQtYnk6IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVs
bC5jb20+DQoNCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
