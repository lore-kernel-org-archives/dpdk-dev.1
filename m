Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB2C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 09:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2BC340268;
	Mon, 10 Feb 2025 10:02:39 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E23CF40150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:02:37 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A0BZoL004420;
 Mon, 10 Feb 2025 01:02:37 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44pyg797rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 01:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQj2SsHsZDyw/yp/JSpNSEm9ZZ9FynNsHmpRXb9xIlAj6r94wx/hTf6PO3E0i4an/PZOqJnhWMEfCOuMwvA1F+abYPwHIf0ChIzG2Sav0Xc/5N24xcWDO+19oGlrnBqj9UbkfPIZRCpxba7Eqz5GhR466QHjAP674I7VydRou81YsN1HQz7RC6BW1pvsmOr90aDxZ+ZJXOeDhD1t21ivpClU3mpiAjYl7KrM/7ChZnXS2uPNPFGOJUCf3jkMHA9ivu1naXZxWJQJzi+JPPK/WhU8JkTauPovZ9PHVAT7ekkTr+A7hHpTFlbMG9a9Ne3oM6G82Bl7l5CimBvB71lVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpE8IuBK4+bfpQDgsQ1H9XluTbVYhECKfn7tydYrCLE=;
 b=LC7BrHbkbgbvIE4jEof9CY5PhNsGz0onfFU+MoqpPD5HSqXPkKqf9DRGvAVirxvr2vxRAvB4not0vgDmB2DSkokdkBUGD2iX1IXSAZpcss0Xw8TOS4izXGOT/qieJ70ZcTU4N1Q5GvWSBcQR29FNLSLM4DnYcBBluD/s73WJyvc/Zgl8DUKATWxlMbCWyXZ4ywNLGSFvnmdOOVzhqZNiinaSzxsBLMaEVHX8nDbGvWoHG3vBi6OQjnoW/WG52T/AmDXwxugBQkXgEgs4DpVc7yNkvJHLrlNJffPUW7W4kht/8SjaDV3F6LTp/Yy9m7yrLehTicid+f9G5n0dM+p67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpE8IuBK4+bfpQDgsQ1H9XluTbVYhECKfn7tydYrCLE=;
 b=EH+VJFvlqnnZanY/6QZUlNaOSK/hD0QreYigFrGwisxF6swnLELQfMkdL8xx0h5aiERLmJxnvidHBYBkdaUPdSeLu/MAGW+TVxq5mhyEy5Qhdel0F0Z7+jirG3fFPQWvs5fCF6PC4APOGBkWiw6s31Ga7Hy39bPk4Ens/1f/70Q=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by CH3PR18MB5600.namprd18.prod.outlook.com (2603:10b6:610:199::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 09:02:34 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:02:33 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Andre Muezerie <andremue@linux.microsoft.com>, Thomas Monjalon
 <thomas@monjalon.net>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in
 register
Thread-Index: AQHbeT1Dho/CKfquMEm+i570TykqybM7tx9AgASKcyA=
Date: Mon, 10 Feb 2025 09:02:33 +0000
Message-ID: <CO6PR18MB3860F074B0C173655429323BB4F22@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
 <20250130145849.82003-3-david.marchand@redhat.com>
 <CAJFAV8yvVXqnK0mwngjroV-HgtnBpfG50co-3cMgq3AsPLnzgQ@mail.gmail.com>
 <CO6PR18MB386009DC96D52BF64C1FFFE6B4F12@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB386009DC96D52BF64C1FFFE6B4F12@CO6PR18MB3860.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|CH3PR18MB5600:EE_
x-ms-office365-filtering-correlation-id: cd5ec4ac-35c2-4f77-97d1-08dd49b1a7fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?QlMvemlsaUxTZE5pSXFocFdZMmVKMGtyWEVLeTVyRGV2WEJld0NwS2FyRCsw?=
 =?utf-8?B?S0hxZW5TNURzRFpsR3hTRmFQTXNTU1paQi9DdjN2dWdlZUtUNFJ0VXdJQ01T?=
 =?utf-8?B?S2hzTzMwVFJ0cGo0Q1QwOWZYZDJWbEl1cG5pT3dNdzJFK0ZJZ0tKMGlGUGdK?=
 =?utf-8?B?SmlWdUtxamRPRzVMR3FTbWZqWDFCZjhhQzJDNkpCOVBXWEZybCtka21ZN29N?=
 =?utf-8?B?R3Y4RERtbXBlMXphYVYxT0lGczdhd2U2cHFTRmZiL3VMSUQ0dFZBQjJYaGMw?=
 =?utf-8?B?QXBOUmRYbCt6K2dTWDR6cDRFVG5TK1hXUzJWV2tVUnlSZ3orcWhKVlpzZ3Qv?=
 =?utf-8?B?TVc3b1QrVG1iRmFpU1hyUnV1WnBnSTdicVdlUnFpZW9FbW5PbExBNFhWekJB?=
 =?utf-8?B?Z1hmQ2JlMzl3WUFLOSt3TTJoZlVTOGJ5blpJUkR5SGd3WmhGOGxTdUZycnNv?=
 =?utf-8?B?eHBTRUphVWJWQzZpbFczTG5PZzB2cjdoK2krQ1VsSHFKTlQ2QUZ3cFBlU05j?=
 =?utf-8?B?ank4N2ZkcmFwQ3dBa1J2bGlXVXQ2SWN5UGpxL2IrSWNWRi9CUUNrc3ovVVZG?=
 =?utf-8?B?Q0w0eUZiQXJwVGhSejJMcGVXM3ZVQU03S1hKcHhIeS8rRVppOC9ZTnI3ckZi?=
 =?utf-8?B?NFF2akwvL3lCRXdZTnhPc3M2dVlmWEJXcUR6UTQvNEo3bnQwY0RjUlhzSUFW?=
 =?utf-8?B?ZkxYOE1mSGJvMW1DaHp0Q3QzM0JoRkxxZFYyekpJajBmUThmRXdZWmY4THFW?=
 =?utf-8?B?bW9QUjY2RVlpcVBFM2JFQUdReFV0K1Y0Y1UvN29UcExxZGlpSER6TzlYczE1?=
 =?utf-8?B?YWhTMlIwU01qMDVYZXFveXZpYWNhODlYUkNzQ2xuT1NMWWhmNVZZVWwwM0Fv?=
 =?utf-8?B?YjZBQVcvU2FjNG1KRzNGdzE3RnNod25SbDVGSlBzcWpvb2wxRDJnYUxiMFJL?=
 =?utf-8?B?NGtjSDJDSE5sQ1VRcVdxWElCNlN1YnBnM1BYQVRqd0QrMVdSMEZjNGFVRkU3?=
 =?utf-8?B?TEtNM0tiVWNsbmhwN1VONXBmRDd3VnlJeVlYcHorYUdGT3dlYmlhWmZSR2dv?=
 =?utf-8?B?cWlBUHpSSk8rVDFUbWdsTExrSWtLaFBqTHJjNENRYXMySGJYaUhPUm5KUWRz?=
 =?utf-8?B?Vys2UVQ0WThyQ2JRaW9tTFZjVVRVK01zemlGcXYzYzVhWUE5OXBiTDJJVkV1?=
 =?utf-8?B?dXVab2d1VVduQ01TQlFqOXFMVTJLeGtwK2hPd2lDbVRtRkFvQU5oR0lXakVs?=
 =?utf-8?B?cDgzTTBlNGR5TTF4akJlVTV3ZkJ3dGswb0FkdHFpekhrc0hSSnVCR0J4Wmxy?=
 =?utf-8?B?ZVdyRml0cy9YSmlxaENmejA4Q3Y1MkFoUTZRZzkxUEtoTlNyT0tMeUdWWVRw?=
 =?utf-8?B?N1dobEdMOTBnaytlcjZIL2FJRDdzR0tPNjZ3VUxrOWs2YlhRNkhHM2U1c25I?=
 =?utf-8?B?N3R2cXM2UXE0dy9PMTZoU3hpZzdYSGM3Nm02N1BEbGhnVkgwbDQrOVlzaG15?=
 =?utf-8?B?NEN6cTliYUlVSXBSaFhuV1hXNnZJWnEvY2p2QmZHbC95ejJocnJCdEJwVndn?=
 =?utf-8?B?VWRVa1dWUEJuLzZKNTJRaUtCeUlLVlRsWUtLVEpCTzkzak55TkdNSjZFUnBj?=
 =?utf-8?B?UmxhY2NjMWhlald1UkVkU0pPVGlqL0lJRWNOMHFoNThuSUVxNXUrbm5yVm5X?=
 =?utf-8?B?aGs5dFcyVTRsU29ydnhBVng0RktmNTVZNTBMYXZXWURKc2F0Z1k0MXliNHM5?=
 =?utf-8?B?YkdSRThub0M3Tlp5OUJ1RzFqTmZuMEJxQ1Y3MDYwbnZIU0VSSTV3RzZXSkU1?=
 =?utf-8?B?Qm95NTI1SkxsRi9SSlhaa3l4WnV0Uk1paUhpYjVKcnVzTERNV3J4WmtNNFJL?=
 =?utf-8?B?K0M5VFc2a2syWkNjUmlFa3pvRjdNUGg3K21JS2Joci9NK3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aSszOVdCNlR4VHJYQ1F4ak9nRVU0M05IVVpEaEJEN2RtOCsxN0lha0poMVRZ?=
 =?utf-8?B?ZVZtZ3RoeFhJV2VPWWtsZVl2NFV0TXl0M1Z1L1BtZVVDaFVYQjhvNkR6SHJV?=
 =?utf-8?B?OFAyb25Na1lzTkU1eXlGZklYa1NDbEtGZmlhTlVHTWJHbk9FY2orVmdGUzYw?=
 =?utf-8?B?YzZXUzdYNmJuWmhpSlpnTVgvNHkzWHRReW5naGJwMStNUTdPOWlTQVluMWNN?=
 =?utf-8?B?MWtaaHVHUnVHZG0vVUZOOVRFY3VoSVMwMmppSkFqMFd2SFpOUTFtd3FZelQ1?=
 =?utf-8?B?OFMwZVo4d2k3OE4rcUV3b0hhazFwYkkrMGdMVm1ybk1qRkcwaUpQY1pWcHBz?=
 =?utf-8?B?a3hiV1pDc2owanA5Z1JpRXNzWlVVdlRseW1JK2VVcGFHWU5pMWRDSmIzS2Zt?=
 =?utf-8?B?aFpTZHdHandkNHJHMUxtZ2NEL3RVeFJXQXpwYmdJOFROaVM0dzVZSDIyUFdq?=
 =?utf-8?B?M2JhU0lTMUtSM2FNa1crSzArZHpIRk1CS0ExVitsckhnamZtek5XcTNHMFJj?=
 =?utf-8?B?WFJUNUJkc25rRjFmMXZ0Y2hKMEpHZ2FiaXcwbUttTXhUeklPUVg4Y1g4WXhC?=
 =?utf-8?B?bzBsbEt2dUhKVGNOeVFBS3BtYi9wWTdqNFZPSEh2NCtHRE05ZkFqc1Jjdm5a?=
 =?utf-8?B?MnZ3d2dJYVBCeFFOZ1MzcWVYUlJGQkU3cVBueGJNUHlac1RnZ0lTdGdiOHcy?=
 =?utf-8?B?S21rekVDckJ6NjFqZ0FJcUdiSHNid1IxdjUxSmNDTDVJLzk5SEFhRmRtQjUz?=
 =?utf-8?B?UkNoV283SGtFQUpJcUlYWW9aMWluRXJ1Q1JCTHNCSkI4bkttdEdKNGJSb3Rv?=
 =?utf-8?B?Rmc3RVFyaW9Za21Ia0ZHdXkvaWk1Ujh2bGtjemN1UWNIS2lWRTRjK25HakNr?=
 =?utf-8?B?NlgwV3JjUU5EN2U0bzA5YXJsSkU5d2RZZklZUHNtQ0hUc2pQbG9hTk9vWlVS?=
 =?utf-8?B?SU1TM29vY2ppcjRvVVpxLzRkOGU5K0VLYVJvdmRJbkplanR6UmkxaVFydHhY?=
 =?utf-8?B?YlE1eFROT2djbUJkMkZocnNHcEh2WHNkbXozR3JYTTh1dU12eENmdFZ2RHlZ?=
 =?utf-8?B?K2ZlWSt2Z2pBbzBnUU0renJYcHlCQzAvYzRlNERyaHdQcVdXMmhDRi9oYVFY?=
 =?utf-8?B?N2NpQWFuMGwrdS96aVoveWZ0ZmpzVWt4MnBOc2lUUlR5aktLSUEvU21zYnNm?=
 =?utf-8?B?OVlaTXRUTlg0Zlk0dXFrT3hsRlVzLzhtVWV0YVBuSlM1Y29QUXZjVlRSd1Az?=
 =?utf-8?B?M2t6TTArTit0MnFqU00xZGFsQWZqTUpiNlVtWmttWGhNVG1zNjllVzRFWkFV?=
 =?utf-8?B?Lzc2KzVHd245eDI2L2NNZWVaaXB4Yk51NUlKUnFKM2pmUlVXTXp4dXBXSktM?=
 =?utf-8?B?VCtrdU5vL2IwV3UzcGhSemdaRjFvTXdwTUtrRFMvUnVJT0JSaFh3YWdCRkda?=
 =?utf-8?B?UGlxSTZid0hwMHlKNHRxUkpRSE9Xa05vTVJ0aTJwQjEvL1k0a2NmSVZWZ1Bq?=
 =?utf-8?B?ZjdSZWxnMVBpMDN1aWNZZWFBdDFkYThpVVBKSGIzd1hDYTkwTERPRlpKbkxn?=
 =?utf-8?B?YnVNTmtpdlJOak1jMUpUNTlFL0JPSXdEcVh2K0IzQ2tYRkw2eTdDdldERlNr?=
 =?utf-8?B?ZG5ZSjBPdkRKN1FOR2VwY0kvTFJGblZTSEFQb2VlS25ITHFWdDBMTnJpMEZu?=
 =?utf-8?B?ejhnMnN5ZkQyeXhIRVdOaytUTmFDNFpPN3Q0aTNFQmdWTEN5ejJrM0tpaG4z?=
 =?utf-8?B?a053RkZJWWZ4eUNTVGRObmVJZk5PY3ZHY0w5VHRaenNvYmFsMzRrU1lMTU1N?=
 =?utf-8?B?aElsWUpTclRHT0QxWnhvZEZJUzUvRUpyMW9OdFRjaGNBMHBud2o3UUY3TTEw?=
 =?utf-8?B?SzNRR1NyR2o5SEh0dTRtS3drL0UvbVgySWtLbEdxbHRkd3JWcE44ZnV1L2hv?=
 =?utf-8?B?N21nck9NRmRSamJ1aE50SEdsSVZsWHJ5V2FNS25qRHpEalMyNkhLTkpUU1FJ?=
 =?utf-8?B?MnZNWDE0OWZEQWVseFdVclRPWGo0YUdQcjVPNFN0L1RPVmdUWEQzNFkyYXlz?=
 =?utf-8?B?cVRDM20yNjdjYUE3bUpiZXJ5SnNVNVlDM01EcCtmUHVkNGFDMnI1dEIvakZI?=
 =?utf-8?Q?Unyo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR18MB3860F074B0C173655429323BB4F22CO6PR18MB3860namp_"
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5ec4ac-35c2-4f77-97d1-08dd49b1a7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 09:02:33.2796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MztnlmUmC2ptA6p6SDlvh2tywVBYtLu6YEsTJP+v1b6t4LVXxJ6q31JoQejlTsRjv6QfKpDepoJzjFa31WcwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5600
X-Proofpoint-GUID: kMgYE3roHZRXvDwpBZdKG5GsGivoKuDV
X-Proofpoint-ORIG-GUID: kMgYE3roHZRXvDwpBZdKG5GsGivoKuDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
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

--_000_CO6PR18MB3860F074B0C173655429323BB4F22CO6PR18MB3860namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

I tried validating series to see the trace results but babeltrace throws er=
ror while reading metadata file and traces can=E2=80=99t be generated.
Can you please have a look into this ?

Thanks.

From: Sunil Kumar Kori
Sent: Friday, February 7, 2025 5:09 PM
To: David Marchand <david.marchand@redhat.com>; Jerin Jacob <jerinj@marvell=
.com>
Cc: dev@dpdk.org; Chengwen Feng <fengchengwen@huawei.com>; Kevin Laatz <kev=
in.laatz@intel.com>; Bruce Richardson <bruce.richardson@intel.com>; Tyler R=
etzlaff <roretzla@linux.microsoft.com>; Andre Muezerie <andremue@linux.micr=
osoft.com>; Thomas Monjalon <thomas@monjalon.net>; Stephen Hemminger <steph=
en@networkplumber.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in=
 register

Hi David,

I will look into this at earliest and provide feedback.

Thanks

From: David Marchand <david.marchand@redhat.com<mailto:david.marchand@redha=
t.com>>
Sent: Friday, February 7, 2025 2:20 PM
To: Jerin Jacob <jerinj@marvell.com<mailto:jerinj@marvell.com>>; Sunil Kuma=
r Kori <skori@marvell.com<mailto:skori@marvell.com>>
Cc: dev@dpdk.org<mailto:dev@dpdk.org>; Chengwen Feng <fengchengwen@huawei.c=
om<mailto:fengchengwen@huawei.com>>; Kevin Laatz <kevin.laatz@intel.com<mai=
lto:kevin.laatz@intel.com>>; Bruce Richardson <bruce.richardson@intel.com<m=
ailto:bruce.richardson@intel.com>>; Tyler Retzlaff <roretzla@linux.microsof=
t.com<mailto:roretzla@linux.microsoft.com>>; Andre Muezerie <andremue@linux=
.microsoft.com<mailto:andremue@linux.microsoft.com>>; Thomas Monjalon <thom=
as@monjalon.net<mailto:thomas@monjalon.net>>; Stephen Hemminger <stephen@ne=
tworkplumber.org<mailto:stephen@networkplumber.org>>
Subject: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior in reg=
ister

Hello Jerin, Sunil, On Thu, Jan 30, 2025 at 3:=E2=80=8A59 PM David Marchand=
 <david.=E2=80=8Amarchand@=E2=80=8Aredhat.=E2=80=8Acom> wrote: > > Register=
ing a tracepoint handler was resulting so far in undefined > behavior at ru=
ntime. > > The RTE_TRACE_POINT_REGISTER()


Hello Jerin, Sunil,



On Thu, Jan 30, 2025 at 3:59=E2=80=AFPM David Marchand

<david.marchand@redhat.com<mailto:david.marchand@redhat.com>> wrote:

>

> Registering a tracepoint handler was resulting so far in undefined

> behavior at runtime.

>

> The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler

> (which expects arguments) to a void (*)(void).

> At runtime, calling this handler while registering resulted in

> reading the current stack with no relation to this function prototype.

>

> Instead, declare an additional inline _register() handler for each

> tracepoint and make sure that the emitting macros in

> rte_trace_point_register.h only work on arguments name and type.

>

> The original tracepoint handler prototype is adjusted by adding a

> __rte_unused for each argument (since emitting macros do nothing

> with them).

> This last part introduces an implementation limit of 15 arguments.

>

> With this change in place, the workaround in dmadev tracepoints can be

> removed.

>

> Signed-off-by: David Marchand <david.marchand@redhat.com<mailto:david.mar=
chand@redhat.com>>



Can I have your opinion and review on this patch?



Thanks.





--

David Marchand



--_000_CO6PR18MB3860F074B0C173655429323BB4F22CO6PR18MB3860namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Mangal;
	panose-1:0 0 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi David,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I tried validating =
series to see the trace results but babeltrace throws error while reading m=
etadata file and traces can=E2=80=99t be generated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Can you please have=
 a look into this ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Sunil Kumar Kori
<br>
<b>Sent:</b> Friday, February 7, 2025 5:09 PM<br>
<b>To:</b> David Marchand &lt;david.marchand@redhat.com&gt;; Jerin Jacob &l=
t;jerinj@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org; Chengwen Feng &lt;fengchengwen@huawei.com&gt;; Kev=
in Laatz &lt;kevin.laatz@intel.com&gt;; Bruce Richardson &lt;bruce.richards=
on@intel.com&gt;; Tyler Retzlaff &lt;roretzla@linux.microsoft.com&gt;; Andr=
e Muezerie &lt;andremue@linux.microsoft.com&gt;; Thomas Monjalon
 &lt;thomas@monjalon.net&gt;; Stephen Hemminger &lt;stephen@networkplumber.=
org&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined beha=
vior in register<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi David,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I will look into th=
is at earliest and provide feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> David Marchand &lt;<a href=3D"=
mailto:david.marchand@redhat.com">david.marchand@redhat.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 2:20 PM<br>
<b>To:</b> Jerin Jacob &lt;<a href=3D"mailto:jerinj@marvell.com">jerinj@mar=
vell.com</a>&gt;; Sunil Kumar Kori &lt;<a href=3D"mailto:skori@marvell.com"=
>skori@marvell.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>; Chengwen Feng =
&lt;<a href=3D"mailto:fengchengwen@huawei.com">fengchengwen@huawei.com</a>&=
gt;; Kevin Laatz &lt;<a href=3D"mailto:kevin.laatz@intel.com">kevin.laatz@i=
ntel.com</a>&gt;; Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@i=
ntel.com">bruce.richardson@intel.com</a>&gt;;
 Tyler Retzlaff &lt;<a href=3D"mailto:roretzla@linux.microsoft.com">roretzl=
a@linux.microsoft.com</a>&gt;; Andre Muezerie &lt;<a href=3D"mailto:andremu=
e@linux.microsoft.com">andremue@linux.microsoft.com</a>&gt;; Thomas Monjalo=
n &lt;<a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt;;
 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephe=
n@networkplumber.org</a>&gt;<br>
<b>Subject:</b> [EXTERNAL] Re: [PATCH v2 3/3] trace: fix undefined behavior=
 in register<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white">Hello Jerin, Sunil, On Thu, Jan 30, 2025 at 3:<=
/span><span style=3D"font-size:1.0pt;font-family:&quot;Arial&quot;,sans-ser=
if;color:white">=E2=80=8A</span><span style=3D"font-size:1.0pt;color:white"=
>59
 PM David Marchand &lt;david.</span><span style=3D"font-size:1.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span><span style=
=3D"font-size:1.0pt;color:white">marchand@</span><span style=3D"font-size:1=
.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=8A</span>=
<span style=3D"font-size:1.0pt;color:white">redhat.</span><span style=3D"fo=
nt-size:1.0pt;font-family:&quot;Arial&quot;,sans-serif;color:white">=E2=80=
=8A</span><span style=3D"font-size:1.0pt;color:white">com&gt;
 wrote: &gt; &gt; Registering a tracepoint handler was resulting so far in =
undefined &gt; behavior at runtime. &gt; &gt; The RTE_TRACE_POINT_REGISTER(=
)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-line-height-alt:.75pt"><span style=3D"f=
ont-size:1.0pt;color:white"><o:p></o:p></span></p>
</div>
<div>
<pre style=3D"white-space:pre-wrap"><span style=3D"font-size:12.0pt;font-fa=
mily:&quot;Arial&quot;,sans-serif">Hello Jerin, Sunil,<o:p></o:p></span></p=
re>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">On Thu, Jan 30, 2025 at 3:59=E2=80=AFPM David Marchand<o:p></o:p></span=
></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&lt;<a href=3D"mailto:david.marchand@redhat.com">david.marchand@redhat.=
com</a>&gt; wrote:<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Registering a tracepoint handler was resulting so far in undefined=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; behavior at runtime.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint ha=
ndler<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; (which expects arguments) to a void (*)(void).<o:p></o:p></span></=
pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; At runtime, calling this handler while registering resulted in<o:p=
></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; reading the current stack with no relation to this function protot=
ype.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Instead, declare an additional inline _register() handler for each=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; tracepoint and make sure that the emitting macros in<o:p></o:p></s=
pan></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; rte_trace_point_register.h only work on arguments name and type.<o=
:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; The original tracepoint handler prototype is adjusted by adding a<=
o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; __rte_unused for each argument (since emitting macros do nothing<o=
:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; with them).<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; This last part introduces an implementation limit of 15 arguments.=
<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; With this change in place, the workaround in dmadev tracepoints ca=
n be<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; removed.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt;<o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">&gt; Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand=
@redhat.com">david.marchand@redhat.com</a>&gt;<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Can I have your opinion and review on this patch?<o:p></o:p></span></pr=
e>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">Thanks.<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">-- <o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if">David Marchand<o:p></o:p></span></pre>
<pre><span style=3D"font-size:12.0pt;font-family:&quot;Arial&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR18MB3860F074B0C173655429323BB4F22CO6PR18MB3860namp_--
