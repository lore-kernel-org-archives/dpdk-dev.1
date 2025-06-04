Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A76C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD1742E61;
	Wed,  4 Jun 2025 17:30:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 74414402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:29:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549S8ao007599;
 Wed, 4 Jun 2025 08:29:57 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2130.outbound.protection.outlook.com [40.107.236.130])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 472as41v2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 08:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSg/gtDq5BTQruTVKj5ARmm7NWbATLUzYd6xVST2d3q1v4w/1bJhILG+MmnYVT2jOWRRJzehd3ZDqMSm0vJQ/hbiyBNbsZDuBjQEcBNU5uaAnAw1kHCp5yoARcd8phXOn0dpzCf7EAw5k1mIbBv2chCIR9eq6HDCEHULTJeqhKBFutsXz5dUboewJ6nWUmaYsUx5+EhZV+FQEMiYfy/30eI/tMPynP1D/QnwgocyeSw2I849KU9j9dfz5N42Ciu2T5mgR0qjbgZoNKcv1UI1UtthjuTCYHxiuRlq32t+QBjeH9tvpBvwcUjkijs+fSxdTYaeVkhH+I4+NUVejVOMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNMMgYHAZ+fXX37bmdUipBAGDJj7VvXktJd7cpK95ss=;
 b=b/7PuwV8IpmfLuB40qomGadaXeLT40FADHCoQb1jjuYaVVCN8qEaDt5z0kczoyTiMiPC7sChK4XcDSUTr3bKtYAgSsu+KUeUoI81uYxiKTh9roVgTP1+w0KgCAWMZ5nCpzHDInN3+VVJ4Qq5BjidvFSmzqRDYTLzYBA3sSmlb0NV73kFVPGW4KgoSNyaz3smZv8tk5wTxIVXZUgPQTrCTkoncNYRj5lbv6BckbosTIaVVf1qvEjkpnfrhRbw28GgbFDjVpspC6FV5giC55OkI747BlFQUsyB5ObT0/vWiFv1QIOiwj05BieUa9Qy9131MEebmhkLZotLcpul5TGjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNMMgYHAZ+fXX37bmdUipBAGDJj7VvXktJd7cpK95ss=;
 b=iAwLaXytddroD6k4yKFYb8BZon4JiwJXWJyhhlEZZflNyaJlXRAopQ+MYn2CKx/uirIjFUEhUChfHo+zD8u3C3RJBAOY7+47JRI+Ea8jr1hTvViN9KaJNQgOgARvVeZxPR9otJVerW4XfhB2bUoXp+Gb8sc5I8PiaLSGsosbplM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY3PR18MB4770.namprd18.prod.outlook.com (2603:10b6:a03:3cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 15:29:54 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:29:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "Marchand, David" <david.marchand@redhat.com>, Aaron Conole
 <aconole@redhat.com>, Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta
 <ashishg@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas
 Monjalon (EXTERNAL)" <thomas@monjalon.net>
Subject: RE: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
Thread-Topic: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
Thread-Index: AQHbv+yjUxUSDnkyH06ivUY3sMxEvbPdGp3ggAFmt4CAABjocIAFxuoAgAAnksCADokigIAAN8LQ
Date: Wed, 4 Jun 2025 15:29:54 +0000
Message-ID: <CO6PR18MB4484BB354A2EE063C647F89CD86CA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9E0Kh115U4YbkVPOCR-65cbFb__V-+pRGFdRGoqLVYMtg@mail.gmail.com>
 <CO6PR18MB448446151350E98857F883FFD899A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HYQo7FNPggY1-m4-SMga4Sf5G3RV1AU-izZunNJzgqcQ@mail.gmail.com>
 <CO6PR18MB44849D14A16B1B5729F69746D865A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HxKgiMgo4s9r1-PfA8+2Bp8ENduJEP+h6zOgaPKNPozA@mail.gmail.com>
In-Reply-To: <CABQgh9HxKgiMgo4s9r1-PfA8+2Bp8ENduJEP+h6zOgaPKNPozA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY3PR18MB4770:EE_
x-ms-office365-filtering-correlation-id: 0dd0ed0d-a75d-4880-ff8d-08dda37ca7b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXRnRzRmSEVZdTdkM3RkTG1zUnRxejRFZnQrVVZDZDhqeFFhRUEvUDErSVoy?=
 =?utf-8?B?dXMrMSt4VXZEbEhvNzYvcVVUWU0xSHVrMTM0Q1lzbDY5ZFRNbzF3TkdWRjRS?=
 =?utf-8?B?bmpJendwOUVKSWlPMnFiem5lRHhKUWhaeFVmM05lOEhmUjY1Um5oZGIzQmFi?=
 =?utf-8?B?cldDcjN5ZXNxWWQwcndOTmtJeTk1ME9abitrOTNiaXdzU1lFNm0rRjcyV2JZ?=
 =?utf-8?B?VzdyVi9USUxTRGtOeEYyZUYwMHp0ZVJ4OW5id2VrUVllSXJpcFdkb3Z4djUx?=
 =?utf-8?B?SS9Uc3BENmZQYlhYM20rTTUyQjRjZVJFR3hmVm51N0xjelRQcWNPYXpFQmlY?=
 =?utf-8?B?WjgzNlZuVmtYWlVaTkZjelFnTktvK3dMSi8yZDNScnlFbDQ3V2N3YzZJOHRa?=
 =?utf-8?B?dExESEZXNnhSSW13ZkNNaXpnenFHQ0MzaEJMcnY0WW5JSUNWS3kwaitpR0Vi?=
 =?utf-8?B?VDRCcXVXSWpnNWwybkVGR3pSa2t3alpyVml0UTJ1andEWGgvZ3ZZeHdZeitx?=
 =?utf-8?B?SzVFRVpvNFhXU1JjQ2p3OHJXendFdnBoQ0duSGt3K3pNMDVITGxlTW96Q25t?=
 =?utf-8?B?MTdOazZNZTdJL08xSEY5K05sMkRZV2cyWHJUczdtWE5GZlZaTElGK0E0QWdP?=
 =?utf-8?B?Tmo4SnhDRWhtbHVtbk1US2taZGxTRzdFV29Qdjc0dWdWeUR2VXlwaWRyQ3Yw?=
 =?utf-8?B?bE9VbDQ4UWdab3JkRUhWWGNydXdoZ1FxYUVRMkxKd0NjY29XUFpSeDZ5OE8v?=
 =?utf-8?B?R0NIVXd5UmhVYlg0N2hCekZ5WmZ1Q2F2c0gxRFJUWi81N2ZQVm9mVWtiWEll?=
 =?utf-8?B?bkFZVXZHV1d0U1dxUUVoVTZlVjA0UFVjaUQ1WEgzMVpETGIyQUxXSDJiY2R2?=
 =?utf-8?B?Q0xxUmRUditnRklWalljT20wdkpscnN4R2pNczRCWEJueXFxK3VMOEd2RzNw?=
 =?utf-8?B?cnVkL1VVLysxN1JlOENiNGxJRVhJT3YxMml3Y0xYTlo2Zmx2b1JLdFlnT2Nt?=
 =?utf-8?B?RXAzTjFtUkZLTHRtdEN3VTBINERXSk5vM2w5ZkxkeTA2bmY0enNFTUFjNWtL?=
 =?utf-8?B?YTJMTHc0RmhEZXJoMmZxTm96RzhDZ2k2dDJRYTRmZXdCeDZzUlJIMmNHY0tj?=
 =?utf-8?B?Y2t5RzUxZU4wS1QydFgyUzNKVGlweStuT1c2c3I1Ym54Y0RBalNsWVgzQmp3?=
 =?utf-8?B?ZlJVS053THNJTGRnem1QUjNXSFRiVU1BTEU2RnMzUmRPYmNNUmNBU0szY3N1?=
 =?utf-8?B?NlhWQ0VQZVVuaTIzaU5PTTJmNjludkhlNmlZRjE3ZU9XL2ZVMEJkT0pJbFpV?=
 =?utf-8?B?QnVna0tidGtSMDcyeXQyQ3JSUzZ0N043RW5mT3lXMFkwa0szTDdWRzhUd2ZV?=
 =?utf-8?B?OFcwa2tOT2V1VXdzSlg5WHIyR2o2MVludzQ0VTFpaC8zWldpelcrWWRxd3Yr?=
 =?utf-8?B?RjJJcHhISUJ5aDZlQnNwUisrOVlqK0N4K3VzMStQRmprSTRNazlxSGVHaHlQ?=
 =?utf-8?B?NnFWdHJhMEVISnVTVlpMcmx4amtheFdLS3ZodHRMdXI2c1dFZDZuc0gwV3hY?=
 =?utf-8?B?a0hEUDU4azJ6ZlFBS3dZbmhNUTltZmNEVVgyMXlRM2hCMUM5VkJuSzFNSXZl?=
 =?utf-8?B?VDU3Y2RMdGU0NjVNSEVLRWxEN3U5MTdPZFZia0FUMi9lTWVWT0VTZm1udm96?=
 =?utf-8?B?NS8wTm52TUhObGNwOCtVNW8vSzFPSllRRUR5NWNoY0tscDR6T0EwOEVNUGp6?=
 =?utf-8?B?YmFpbUlkMVRJUHRHS3FqdWpYR2d0K25QVmNLeHQvRzZTQ3M3QiszaWlzNjRF?=
 =?utf-8?B?RGRGakRJaUxNUEkrSzFBRWRpSElscldYOXV2bXZLUUhnMXJDejhnNGo5dnk4?=
 =?utf-8?B?YzV3cDQxRVVUSld4UXZDQ0w3dHJKYi8zMFVBY2wzcmN6VHdVOWFBTWFnT0dn?=
 =?utf-8?B?c0VrMlRBdmEzZnBqU2RGM05ySTJ1RC9yUUZ2eG9ndmg0K0hOcmtWS3grY29F?=
 =?utf-8?Q?m5WS2HgCbHwnqoVQPUC2GdtjbXq4R4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWtpL3FCS1JTR2lLL281d0dMcFJjeHdOb1E3U0JibDZ0ODlnSWpHWkxBT1d6?=
 =?utf-8?B?aTRaWVdRMmZXUmZ5aHZiemo5Q2ZzcjU0RW1xK0NNK2IrMDczbVdTbHEzT0V4?=
 =?utf-8?B?b294MnRrSGJPb0dQcEJLUmY4REsrazVNV2IrSVNtcFRiVWszd0UrSjlrM21x?=
 =?utf-8?B?ZVVkaGN0YTBnWWdyUFZDN3k1ampnS3E4ZVFRQlAxL2pOV0c1UmZQUDc2SllH?=
 =?utf-8?B?cU54V05LZUlNR082VFJRbGlSUmRmTlMxTDZTMjJwWTV0TStBK3FiSUpKSkJQ?=
 =?utf-8?B?NkVUSUtHRVBiY3hjTUV1REd0d0VINlhzWmJPVVZjeEFDUGxoVHduZ1BMK0pp?=
 =?utf-8?B?UDBudlkzTDM3aUNncWtOOW1zT240RlM5M3prYUpDUUtlRGtRRndudmJIWjR1?=
 =?utf-8?B?dTVlRjB0YWZ2Q0U3THRXR0tRcmtYazE0RExEbWQ4cWNuOHBxbnBkS05vUlV2?=
 =?utf-8?B?TzhYMmxPWWNlaitzd1JnZFRFWVZVQTJmbCtwQmh5aWMxL3ZKRXJQU1A5OUxB?=
 =?utf-8?B?azErM0NpaWRWNEJvRktjeERPK0RSUjh0bW1RL2p0SW53RThUSGV0c2lxVXZ0?=
 =?utf-8?B?VUVxc1gxNXRhQjRPejc5eGEzb01lai9FaDZNSlJZcWt6SFY5VWhXaGJOS2lR?=
 =?utf-8?B?UmpVRXlVTjRjYmdDS1lQVWg2MCtHYVVSZnZ4MzZrbUt6bEVLR0ZhOFgyYlpu?=
 =?utf-8?B?cmJnZEJmY3Uwd0JTQ0dNdXFERk5sV04yeGVSbjNWZ0NKbW1VSU0wWkxWazRq?=
 =?utf-8?B?SE0rTmsreEludDNkSytLQzhiNXp3R0xCd3U1Q082R3V2VFRxalpUVThmK1cx?=
 =?utf-8?B?aERSZ1R1OFVydzVRSjhMaHlPWnVLdGZPUzJSRGNtRzRvV1BsVHB3M3RPRkhz?=
 =?utf-8?B?ZEpjZ0RPRVRlOWlPQTBBSUx0TjcxQ3JmbS9OWnhmQ0NLYWRHRXRjUTlaQ2cy?=
 =?utf-8?B?WlphTnk2b2xGbEFBZTQxTytvNEZtN1IxbE5XbDdEVHFmSnpGT3RnZ3Fjb3BT?=
 =?utf-8?B?c0ZLOUJna2xvdStYRnlSVDgveFY2TkRYR1RNTUR2dkgvNkdvNDR5R3JmV0xG?=
 =?utf-8?B?QXpBTzJkeWNQWmpiN1pVb0ZVYTVUOHdoUEhkY1hMSWJBVlY2aG1jcThwbW5y?=
 =?utf-8?B?dWxVZnMydWEyT1BMSytCZm0zUERtUzliR0V4NStvZ09BQjJYMjB3NTY5UWE3?=
 =?utf-8?B?alZOYnpvY0NUaXRvSEtZc003SHUvc3J4QWJhdlZpbFh5T1FNQStzS1ZDc1pU?=
 =?utf-8?B?RU5LeXBiZVoxRzVzcWI1N3g5RHdCdGVtYWZBV2JHK1FhdXpsUTJpcklIUUZx?=
 =?utf-8?B?QlR4UXdqYTRhWktUc0Y0QVFKRjdsU0VXNHlHMkNxV3NwcGpuWmFFclpjYk9B?=
 =?utf-8?B?c0YzcVFDNmtwQUFaZ1R6REJLLytySnI3L3hicE4wMWhjdWxEVWNwMk1ieDRB?=
 =?utf-8?B?ODByWlZVOENGb3l5aWU3S1JkY3FIVzd5UHkvcjhLV2wraTlJaTdrQStJYVJR?=
 =?utf-8?B?WDFmb0VCNVNJRGJkYk42V3hMQ1Rsa3pmbnAxN3Z3dS9WQWlvcDgrdml4NElD?=
 =?utf-8?B?ajhRbDZPOVBqQ2M3dWZaNXlBK0pTL2U1ZEhuRVpCb2RqdTNscUlPcUZ4dHRk?=
 =?utf-8?B?K2xCV0ZZa0dQM3lOeVB3MVFoWHVxNmRLQTc3Rm9KZkZoSm1zN0lqREp3SGFQ?=
 =?utf-8?B?SlNqSW43dWxLYkRQMW9BaXZMbmJqT1RqaE56dzE1ZSttcVJLRk9HR3lzVEY5?=
 =?utf-8?B?UWd1eDNucExha0dXNGNlWWFqYi9Qa3dlN1FZMDRmVXJFVHZPVHpqY1J6NXFr?=
 =?utf-8?B?bzlDVlhnWjM5WE5kUWFuREtqdlg3Slo3cmh1YjhoYTVMM2diSG5VZlFOeERi?=
 =?utf-8?B?eFcyODQxNE5MclZ5bll4TER2aGhoY0NzVlEwRmNTYzhobzdYeTR5ZmFKWDNq?=
 =?utf-8?B?aEdIc0lrM1ppOGVHeXhVTzR3U01jK0dXQkhYOVFZc1RIbXJVWjh4NnIvVWNu?=
 =?utf-8?B?bnRBWlVrb09QaXROS3pnWnoxQitOeVJ6YWk5eFNOa1NzOXVjNzU2TWVhQnpu?=
 =?utf-8?B?K3hzemV1NENJZHFCa0tnTHJuKzJyTFpyL1dLOEVFcFJyVmZMMUVKMmpoa01r?=
 =?utf-8?Q?rnTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd0ed0d-a75d-4880-ff8d-08dda37ca7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 15:29:54.1250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86aQXY5QbxjK/SHBeduqISCXtiJCjHMlG8ovl2Ds4RYDy0BOa19Y6up2om04oW42hksFI+3+L0G+JkVf8M6wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4770
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDExNyBTYWx0ZWRfX2CO1uGLa+Y+S
 kIi4nGGI1W2ssnUjusGGXL7NChJ9r+soKZ+giIuW0PTQIKngUGKgtEj1AiqcN2sr+X0lKAmY+3v
 qUWwSypD3XQDENRQNNt8YoxgoC9hIPWuBjWod4MuptOfgx3nN/R3B1UEpSgx5Ddsfy1oKU0uTvo
 euP11619kboFsybX9CnV3GQbWjhb3B4NeCTwKaDINJGkJJzm4St9Rz4MmgSNJmaSd3j0QTv/bVO
 aC1eu/KuZvP8KKQFY5UQY1/Opht0oyAMgc3c4n/WMgkprp17JCAX8Oe5A8ATlEW1O45ksNkl6Oc
 mmCkQ8MigqGVKORHXOD9dM1ljzjKNmZ6TWWh4mCtPiUJJiUkceVgs677IzYIgJIw1uWneRVX70m
 jPlSm6dCeLAShjz4qs1C0KNx2yDPVZCxrzV3CrVtZlmTUK3MZhVbTBsDDNtrT4vpMMSSCmFR
X-Proofpoint-GUID: GG7J-oH4cJvM6eCTHDgKSKJ6kFC1r2AJ
X-Proofpoint-ORIG-GUID: GG7J-oH4cJvM6eCTHDgKSKJ6kFC1r2AJ
X-Authority-Analysis: v=2.4 cv=It4ecK/g c=1 sm=1 tr=0 ts=68406675 cx=c_pps
 a=IDQsPmfeHq8xcWKaRoNL0w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=JYCNfdoq1Hx4_q_OVvgA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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

DQo+IE9uIE1vbiwgMjYgTWF5IDIwMjUgYXQgMTQ6MTUsIEFraGlsIEdveWFsIDxnYWtoaWxAbWFy
dmVsbC5jb20+IHdyb3RlOg0KPiANCj4gPg0KPiA+IERQREsgZGVwcmVjYXRpb24gbm90aWNlIG5l
ZWQgbm90IGluY2x1ZGUgQVBJIGNoYW5nZXMgaW4gZXh0ZXJuYWwgbGlicmFyaWVzLg0KPiA+IFdl
IGp1c3QgbmVlZCB0byBub3RpZnkgdGhlIHVzZXJzIGFib3V0IHRoZSB2ZXJzaW9uIG9mIFpTREEg
ZXh0ZXJuYWwgbGliIGlzIGdvaW5nDQo+IHRvIGNoYW5nZSBpbiBuZXh0IHJlbGVhc2Ugb3Igc28u
DQo+ID4gQW5kIHRoZW4gd2UgY2FuIGNoYW5nZSB0aGUgY29kZS4NCj4gPg0KPiA+IFlvdSBjYW4g
cmVmZXIgdG8gaW50ZWwtaXBzZWMtbWIuIEl0IG1hbmFnZXMgY29tcGF0aWJsZSBleHRlcm5hbCBs
aWJyYXJ5IHZlcnNpb24NCj4gaW4gZHBkayBkb2NzLg0KPiA+DQo+IA0KPiBUaGFua3MgQWtoaWwN
Cj4gDQo+IFdpbGwgYWRkIHRoaXMuDQo+IEkgYW0gd2FpdGluZyBmb3IgdGhlIDIuOSByZWxlYXNl
LCB3aGljaCBtYXkgaGFwcGVuIHRoaXMgd2Vla2VuZC4NCj4gDQo+IGRpZmYgLS1naXQgYS9kb2Mv
Z3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI1XzA3LnJzdA0KPiBiL2RvYy9ndWlkZXMvcmVsX25v
dGVzL3JlbGVhc2VfMjVfMDcucnN0DQo+IGluZGV4IDBjOWVjNzYzNTUuLjEzOGJmZWNkNjEgMTAw
NjQ0DQo+IC0tLSBhL2RvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjVfMDcucnN0DQo+ICsr
KyBiL2RvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjVfMDcucnN0DQo+IEBAIC03Miw2ICs3
MiwxMSBAQCBOZXcgRmVhdHVyZXMNCj4gDQo+ICAgICogU3VwcG9ydCBtYXRjaGluZyBvbiBJUHY2
IGZyYWcgZXh0ZW5zaW9uIGhlYWRlciB3aXRoIGFzeW5jIGZsb3cNCj4gdGVtcGxhdGUgQVBJLg0K
PiANCj4gKyogKipVcGRhdGVkIFVBREsgY3J5cHRvICYgY29tcHJlc3MgZHJpdmVyLioqDQo+ICsN
Cj4gKyAgKiBVcGRhdGUgdG8gaW5pdDIgaW50ZXJmYWNlIHdoaWNoIHJlcXVpcmVzIHYyLjkgb2Yg
dGhlIFVBREsgbGlicmFyeS4NCj4gKyAgKiBVcGRhdGUgdG8gYXN5bmNocm9ub3VzIG1vZGUgZm9y
IGJldHRlciBwZXJmb3JtYW5jZS4NCj4gKw0KPiAgKiAqKlVwZGF0ZWQgdmlydGlvIGRyaXZlci4q
Kg0KPiANCj4gSXMgdGhpcyBzdWl0YWJsZSB0byBzcXVhc2ggaW50byB0aGUgbGFzdCBwYXRjaCB0
b2dldGhlcj8NCj4gDQpZZXMsIGJ1dCB5b3UgbmVlZCB0byB1cGRhdGUgeW91ciBkcml2ZXIgZG9j
dW1lbnRhdGlvbiBhbHNvLg0KWW91IG1heSBtYWludGFpbiBhIHRhYmxlIHRvIHNwZWNpZnkgd2hp
Y2ggZHBkayB2ZXJzaW9uIGlzIGNvbXBhdGlibGUgd2l0aCB3aGljaCB1YWRrIGxpYg0KDQpDaGVj
ayBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvYWVzbmlfbWIucnN0IGZvciByZWZlcmVuY2UuDQo=
