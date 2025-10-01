Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB44BCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 390004025F;
	Wed,  1 Oct 2025 09:49:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 17945400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:49:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UNTnmv025657;
 Wed, 1 Oct 2025 00:49:50 -0700
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021080.outbound.protection.outlook.com
 [40.93.194.80])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0s6gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 00:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP95KBlURDNKsUsCt5PloXexpMWHrEwomvTmt4ZrQee/MUXr/5tqIeDg9yuyoHCp2nSe5lsybDw8UyvXMHG1MlOZTfS1UfeZgkpeskD9wrQDXq5WCS1lTmXOkGNULNptsNMOElTXwUsjp9a4hL2T7P7sYFNqdLcu7CNta5Xupt1X0MUJbxKhr1kPBCs5i07jThNsw41LJYqAKTPFlVZzYUrFuCP87Sq3GQhPZrS4VrOkQlgBPtfXGLz0wi98bZEGJYFcg+BEy8g/wCDNBQa0iQsVx/SYl5sFtBMJC9nQNgXx2CZ7Vn2Yhr5JrihkZpyOO56NgWKJEY9bx0Hmvmnddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPayPnZ1e/zAQ8/RbHeUJSiSeQc1wiFW22+EnXLjKTg=;
 b=YewGXPearhZeb0NBpeeArpSjddxKVGOxPzHclJ79JerhuXYXJkXOWg7fdgpEkO8XBEmWFTkscMwRs5s+hQK/gfG+C8UPrLAFKjwT0UMuluJ+ol5K4n1gwv1R/mEtDMVCq7ObUXfDqXGrS8b/+wiPAxWXYSpP6ERHhSsVXUz4/zd4WN9q/mDaRpmtYbFnanQaJYu8lxvDSJTmILI6U6BEjR2HHUJbNy4xxL2wesoa78MCgUNEfPIDPOcn1py/eiv2jPh0eMUifP9lV49g4COdrk2RLvm3HkshkDx8KeW6cvT9R6X+kHisKMDFxujPuZanrg+9zwjo7QJLNbVxTUGfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPayPnZ1e/zAQ8/RbHeUJSiSeQc1wiFW22+EnXLjKTg=;
 b=XFgsE9wpyc1DC5pQIK2yGvylqWSA8e5xWSDm2ZPpAhNpvGONe5xWNezKppoGZFsg4Vf8Y0FUgnjBfbEh+iD4VVjajsMgdRTuw4HBY7HZB7GaqMS/7Q78+ExjY0aDTSfMfXewzTYr6sFrI7kxTSE1DSzocPiJeRzpOa99WOT/0rA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF1E89B88DC.namprd18.prod.outlook.com (2603:10b6:518:1::c8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 07:49:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:49:47 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v2] app/crypto-perf: Only run AEAD decrypt with valid
 test vector file.
Thread-Topic: [EXTERNAL] [v2] app/crypto-perf: Only run AEAD decrypt with
 valid test vector file.
Thread-Index: AQHcAG5ICf/2AgztNUS6O7PAK+BHk7StTulA
Date: Wed, 1 Oct 2025 07:49:47 +0000
Message-ID: <CO6PR18MB448452C3681E1CC4507DEA80D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250728080621.1241228-1-emma.finn@intel.com>
 <20250729095045.1293981-1-emma.finn@intel.com>
In-Reply-To: <20250729095045.1293981-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF1E89B88DC:EE_
x-ms-office365-filtering-correlation-id: 73a87748-8f62-45b6-38b4-08de00bf17df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L2V3RnpVT1hyL2tZUURBSEJXOHNBdHBkSGxJNG01ekVrandaZGg3ZHZsVlJP?=
 =?utf-8?B?QXBOM2VoUXdXeWxUeFVQT2tmekNFZmhIa21sQVRuNXJYcVlqbHc1MC8rWW1i?=
 =?utf-8?B?cHEwdTdNTlJRV05OQ0ZYSjE1eHBUUEdncmlhcG9Yak16Qy9EemhVcG1IL1ZI?=
 =?utf-8?B?ZFpoWGFtMmVXbWRjYjBTbWI5QjlmS2FrdnRHaWRlMjl4RUFNQ3JobWdzc1hN?=
 =?utf-8?B?QlAwUGlyZXpGaWdpQXp2TmNiTk5nK1JEaERBcGRkcHoyNjJEaU4yeFh4T0FM?=
 =?utf-8?B?RnNlNFNxdTZTRzljaUJId3gyaG9WaEttYzlnZ3FiOFlaM1ZxelRzMnFxK3hV?=
 =?utf-8?B?OHhzQ005ZDQ4RUFmRE1ObEhwbGd6MEdiMkdEVDFLL25PZXNNS3VlTGt2anlz?=
 =?utf-8?B?MFlkWWhYZVNkSWl4eHQ3Mm02Z00rRzBNMVVSZUN2YkFMajNzMnZEQ0Y2YUg0?=
 =?utf-8?B?WG5Ydll0enFlWHc2bWVad2luV0FiankrMldlLzh1U21oWnVLdnVZSmI5RXNX?=
 =?utf-8?B?Ukc1Y2krdjJubWFXYXJNUHI1Z1FoSW5yK3R0THBsR0lobW9leWROWWVqb2Vp?=
 =?utf-8?B?M1lROWg3a2ZMS1VVb1Z0UlZOaXBZK0F2N290ME1TdnBxd2ZrSW5FdWpWRG1q?=
 =?utf-8?B?ZFUrQzE0NC9HejNWdFcvSnpOWEZ4TGRJZGtlMEJJYTRpNzlGUnNEZzFTc0Jj?=
 =?utf-8?B?VXdmQ3pMdGZSZmtDTEFDVzFMWkVWeXJHK0ROQkFLZ0p6Y0xzMEZsbURVQ00w?=
 =?utf-8?B?dklyZVJoTmZ4K093WE1TdmVIUjU4dEszemgweGZhZnZ3azFKb2tuMDdhOEcw?=
 =?utf-8?B?am1jRjhxYUJmVGl6NzVJdHBGR1Z4RXNmSEN6ZnhtNS9WdDNrQytHTTgvbTE0?=
 =?utf-8?B?blJ0TVJ4ZitWUDZWcVB5aHNLMXpWY3BJTVc0eXR5a2RZU3JaQVVydWhLQVRQ?=
 =?utf-8?B?VHowb1lpY2VyTktNTUtEeGtFQVNLbGJZaDZLNFB1Tlk5YVU2cld5N2RuT2F3?=
 =?utf-8?B?OU13N2ZwOHVIVkdFd2lWNktOTWloWG0rd1dvSHhBQW02dkFMRFIvRjgwdXkz?=
 =?utf-8?B?UlJMRUVycnJERW5WbmUvR0EzaUdnak9TTEpneE9HRUNtQ3pFS3VlYkhNSzg1?=
 =?utf-8?B?RytibncwOHRvNExQOVV6MlVyRWtNN0lDNzVJZDFaZ1pyQkNVVDY4LzNKVDFV?=
 =?utf-8?B?TkF0SndZVDNWSjA4djd4UUNhcHl5bC9temMvcTY2MlZKYWJENnMyeXdqUjU4?=
 =?utf-8?B?ekgvUW9PdzByeXhzZHRFb2wwSHRLWU5acUtNbXU2OWZqZlBaVFJuWlAxVkZJ?=
 =?utf-8?B?Zm5Cc0ZKTVZMRjZjREtXUHFsSHVUb0xQdktxQUF5ZmVwWjlxbzV1ek9ZV25q?=
 =?utf-8?B?OW4vSmRMQjJaZzhDaFJac0E5blZnaWh0T2FtKy9GWGNmSlBpajc1bGk4WmJ5?=
 =?utf-8?B?Z2RPMmFUQmt1WFA4NWpkalh3SVZpRkYzb2J2TEpPbjR0akdhQkJjeVdTMUdL?=
 =?utf-8?B?OVp5aTcwQWN3WUtaRXBmb3RBVitJVytsSmpVSWVWcUs0VEJOOEQ0akRDa2VE?=
 =?utf-8?B?RTBLRjJIRVFvZGIzaS9yM2w2WnpMbXdmTko2bGY2NGpHZDIxcDJCSzczV0E4?=
 =?utf-8?B?aGxjeERraFNaUURlWFMvMFVKZFpYbGgwNlphM1NSLytZZ1Uxd0NFc1RmRWN6?=
 =?utf-8?B?SDZCM0dWMzBYcFlZdEdCUWpMUkVCUnI0RlgweHlZd0ZUVjkxL0VUOG10cyt3?=
 =?utf-8?B?VnVEKzlkWmltb01rV0ROZk8yT01JR041NGF5K3IzdFJ0ZzJCQms1bDBNNG9C?=
 =?utf-8?B?SnQydlpQQ1FWQmc5VnpTZ3VScm5BZUdBT2NEVVN3MUxpN2JkSUVCdjF2RjAx?=
 =?utf-8?B?TGFiSkQ2enQ1WitBN3RDa2o5eW5QeitwS0VwWGdVMmxmd3ZCclcxQzNIYUVL?=
 =?utf-8?B?c1lzTlA0QVJXRkxTVXRsRENPazNKMFlJL29BWlBONTFIb205VjZ2Q2lTY3gv?=
 =?utf-8?B?S1ZLcVlBOTRVV3Fha3RWcmo3b0gzVndRRldjV3BuTGZMSVpjTy9ZQWZRK1hF?=
 =?utf-8?Q?tTNf25?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnFzRXBFYTdkRXRTWHk5WEVtSVBjVjZyeEcvK1dHd0dFclBKMGxZUnJoMUVn?=
 =?utf-8?B?NEEwcXN5VzRrRXo2QmNUcmM3NGd3UVBTaDhxU01hbEo3eWdRSmhLcTFVL0lM?=
 =?utf-8?B?UnBvdTRnUjJVQmx6R0ZZMGtzdW90cEhpU1NUVllXQ0tsQ20xaDhBYUM5TWhR?=
 =?utf-8?B?cEFkQjFBcmdnaHk2V2YzalB2MTZzRE1aczdvVVZ0Q1Z0Q2x0SEV5ZGNSWlUw?=
 =?utf-8?B?RTU4MnZaY0FhdHNQdWFSeHVHbnI5YXo1UGQyMGo5dnFFUTl5dE81STk3VGFa?=
 =?utf-8?B?QjRMOW54L2V5YnZxaG44elBKa0E1SWtBbmtBRUZ3ZFJxeU44NVNaWnRlVm1r?=
 =?utf-8?B?VTNHVVZaeUdRd0k3R1R0Yzg2ampldTNheFZYbUFXdmx3OTZFOU1SMVFrQXpy?=
 =?utf-8?B?NEVaYkNnczEvOE82WEh2elN1S2xZdnhPaFZqVWlFZmlKSXdISHNVL2JDYzAx?=
 =?utf-8?B?WnQ4Zk4rczdGVHBwZUNCNXFtdUZFbmxBaHNBRFZndFNqSGpOMU80ZG9rWTBZ?=
 =?utf-8?B?VTE1Uk5FS0JRRko5aTZYRm52dHpKOEtTNCtxWHc1dEk3M3F3ejFwU0x3WXlv?=
 =?utf-8?B?VjZtcVBINlVjRk5HVzdiQUx6SVh3Wi90L1VscTlzbVVZZXovdGM0WWFLa0w4?=
 =?utf-8?B?eDhQSUJWTHRybVdELzlTYXNUU1hQcE1mQUsxL1gwYkR3bFlqRHdWMW9wSzFF?=
 =?utf-8?B?eTZpUGdtVDR6L2dnaTNCSzAwYTcyTXRxSVNWemRhZVFiWjlTTXZNcVFXUnpR?=
 =?utf-8?B?bWhwaTdYZmY1TVcralg4eitualJieW8yTXpCMWRudEs4NGphYzlyenFJSXFT?=
 =?utf-8?B?aWhBUVNkd0ZVVitsUEltdllDRVlpNTl6dmFZeXo1UTRmUE5yU0tuaERkemty?=
 =?utf-8?B?OHd0c3NuY1dScUJ1TzI1c2I2T043Wk1BTVJ6eTM4UCt4ekRESldXS0dDRWsy?=
 =?utf-8?B?VEtxK1BnQzAxOGh6MzVNbVBrSEpZdnIwWGRSL1JDMXUwa1VwVFd1c0tXd04y?=
 =?utf-8?B?ZldtQlExVHo0eGtoOEZ1QThPY3NlRW9jSHl3eG9NblFhQ1k3UGowVWYxbUph?=
 =?utf-8?B?WE1RN1UrTkppbkhPSHdsd0J3VlY2dml4K3ZxRkc2bFN3Y3ZYYWdleHljK1RY?=
 =?utf-8?B?Yys0RHVDL0RKYjhrNUQyc1ZBY2wwUzYrc1k3N2YxelJacHNOcFlYaWhGS2Jv?=
 =?utf-8?B?bGhzWnhXVFloT3JhQUp5ZWc3VTRRamVzeFJ5UDRBUmZPN2J4bG9mc1ZwTDlq?=
 =?utf-8?B?cm1wcStSRFlVL2xLMTZ4OEpkazVSWG5tWk9DQTBlMGxhaVJpWU5kQ0tocVRP?=
 =?utf-8?B?WnlqSFp5VXEyekhSYjQrU2o3SFJ4dTJnVjZJNVd4eEErU1BYNmo4NkhCSTBH?=
 =?utf-8?B?TGRVYkhFQjVmdG50SzFMWVZQaUFHZnNObFpYbmpxQ1NOOVFDclIrUFRPVFYw?=
 =?utf-8?B?QU5DOTBiL2lxUmlzV1ZHNzkzalo4enNmaldrZXVkeE9oN0kxc3FwN1lYdHY5?=
 =?utf-8?B?M2Vkdk9KUjYzMEFscW9XQTJzSVBqZVhCVXh6MWVwYjNuQ1NySGFpOFpiOHUv?=
 =?utf-8?B?RlB0bTNLSmF4clJUVDB5bFRxeHB3UVdrQ1R4NVN5R3RJbFU5ZHd0emZncTUx?=
 =?utf-8?B?Y25aNmV0b0R6S0ZidFJLMXdENHV0c2ZsS1lrZm5RWGEyMFV4bCtFUE1sQ3RT?=
 =?utf-8?B?Z0gzbyt5K1U3NGltQmZ3dWJ6SU1jTERoZC9valNrcVo4c3pWVzl4TFdJS3VB?=
 =?utf-8?B?NG1SUFpJL2NyUGkwWkNHTXpCM3VHUFA1a3N4cEdaNDk1VVpEaEdncWVKVVNW?=
 =?utf-8?B?RmF3M3lINk54blVaRG9iajNRV2lRQTIzSFMreVFwY3poUjVlWEZuVHFoM0tQ?=
 =?utf-8?B?ZDl0MDhIdVF4UGZ0UHZUelRLK2pjMHJZdWNmVTY5aDVQdzRIY2IzdDhMUGl3?=
 =?utf-8?B?a0IzakVzRlBEN1ZFeVZpN202ZklwaXhXRG4rZ2l3YldteFB5Mm9lMTh6RFpq?=
 =?utf-8?B?VEhDcWVEcnNFRFlkRVlwdCthQUFPcWNPdi91YzBFZHdmOWxKTmxsUmdMeEl2?=
 =?utf-8?B?QjBmTFVWeDFKdm02dHBSd2VndStHcnNibXdMa29TME1uRGFpTEttaUwxRjgy?=
 =?utf-8?Q?5egPnNUSZKV94fAoHWSiCvekJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a87748-8f62-45b6-38b4-08de00bf17df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:49:47.1383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BidDneuvXkToB4NDvhvnmaxDk3DjLUq0Ch/f/7z+hCkEnyWuF/hZDOHkqtcZFsEOhp2VmKrfRZ7zuHn3+CoNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1E89B88DC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfX6bhWsw7OvXGD
 wHoO4CjNzZsILdEFLNugtrPpOOS1holCseJjO3A35SSpDjpTa1U/pkoMI0otPDL8wpRkEhzbE3F
 5wn4joaeKAUj8KQW4tEMEXfpAIvhOGESJUwcxYChHNCb7g1NZWXxMF0zNT/BG8YKDxJSiKL11uf
 0+W7XoQMqN94fBEg/viOid40C0C8hE8B8/91Hf4mOOv4mlvNzDCy4i9UFY1feNvWtvf79hEDOjc
 RcckUgzRMqt/ffZ8zRQPaueCaYnebiiSCwAu6WkoefJexQ92CG10dqAqkX9QTKhkyfwSqNNpFtN
 WfeFSeRcOKgDcbNy2ZBZ50usLABahrDpMO7bYHopvKC3Mv2diY+fgUcCgMEPeDk8z72SlkJQl9M
 Lpy9CYnsu+mR3eo09tO13CRY+C98qA==
X-Proofpoint-GUID: PXgo8zui1AeByjw2k_B2jBeDFoK2U0xP
X-Proofpoint-ORIG-GUID: PXgo8zui1AeByjw2k_B2jBeDFoK2U0xP
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dcdd1e cx=c_pps
 a=zCB0p5dOVkmUH+c4GheF5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=YU1GYy_ma0D6fngZOpsA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

PiBUaGUgdGVzdCBkdW1teSB2ZWN0b3IgZGF0YSBpcyBpbmNvcnJlY3QgZm9yIEFFQUQgZGVjcnlw
dGlvbiwgc28gd2Ugc2hvdWxkDQo+IG9ubHkgcnVuIHdoZW4gcGFzc2VkIGEgdmFsaWQgdGVzdCB2
ZWN0b3IgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVtbWEgRmlubiA8ZW1tYS5maW5uQGlu
dGVsLmNvbT4NCj4gLS0tDQo+ICBhcHAvdGVzdC1jcnlwdG8tcGVyZi9jcGVyZl9vcHRpb25zX3Bh
cnNpbmcuYyB8IDE5ICsrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpBY2tlZC1ieTogQWtoaWwgR295YWwgPGdh
a2hpbEBtYXJ2ZWxsLmNvbT4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQo=
