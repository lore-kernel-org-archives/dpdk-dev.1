Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF6C83F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 04:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24EA24021F;
	Wed, 16 Jul 2025 06:29:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 463874013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 06:29:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FNSSAY018255;
 Tue, 15 Jul 2025 21:29:36 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2124.outbound.protection.outlook.com [40.107.236.124])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47x0pngg1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 21:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1kVLmO7mnfEvpuxLje2kDasL03wy/vUDffTLh6IXR1Xl9r6YF0n79RjHqTa52oAcjad1Sl9WR7E03tn9NIO0NIlViP8I8esGaM++h6Ihk38wkUP+Vms9DZYIuhossZS7MfeaxqfnNhHxJZwx30nB5Mf0jeJFRd28p8zwk3Lg3VkpS0femIDkb5PrlRqcz4sMKjluOZHc44WGJOBWpvVCl6AmpxYyi76O2O7whsjIsWydWi5t1KnKhvE1XWh1+tkpZenGXJSvpBgc+1558VYBalKzrH8TsXHQ6IQGU62lg2Sfe/BSKidRW9jkOTfGU1ez3ThVjCEU9hnyTocKROWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q658ET1q4Dn28eqa6QvkLRlQ6IkU7wjwTfZT6kz0Ro=;
 b=ekDx1Sv0t/jmZETmdBr+L86Q989r8FnMpTaYMpKSW7p+hqxx1U3WgPaaTTJjNiqkzgsl3Hm5gmsbzNLXmbQAqOFz/StbqFV6YwlkhiV1LMEGKNRoguMGaaa3J3676o8uNrKgcKzgbqefY6ASRYRxoq9oXy2zOhclC91MbL1IZdW7T0HOpVvhRQ9mCZiulnsTd9alB3I6Xb2N0e+Q5PtcZPZnWXbHAcISk7BnJxCgA5fQcFTpvcFXUCdgNGvNnQsbgue5zDzrG0KyipgbDyN35ntHpsPvd8d9icYeXZOBLDYHgfPNU5vmPo+OPdH5whWUq9ejI1nt+9ff/vKhfhhAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q658ET1q4Dn28eqa6QvkLRlQ6IkU7wjwTfZT6kz0Ro=;
 b=fBh8oetAs/C1KJvhRe6cqKKll849sOIO0iDVQCbBi8xj6RuN5u0eOXjwLsvAaoV1DaUSOC5cQzQ3DxP+Fj/xzx9SMYT0B2alGcwlCOCLVnqvZdTv7/7q8IMxEz+fVmARHA+nW3NGYckO3Ueg5tHHDbqFLA5pP7PPo6fDChFIbjs=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SJ2PR18MB5739.namprd18.prod.outlook.com
 (2603:10b6:a03:57a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 04:29:34 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a%7]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 04:29:33 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: Amit Prakash Shukla <amitprakashs@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>, "conor.walsh@intel.com"
 <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "g.singh@nxp.com" <g.singh@nxp.com>, "sachin.saxena@oss.nxp.com"
 <sachin.saxena@oss.nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>,
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4] doc: announce changes to dma device
 structures
Thread-Topic: [EXTERNAL] Re: [PATCH v4] doc: announce changes to dma device
 structures
Thread-Index: AQHa4o9FIWwsDcgJnUWO1cJIodzB2rIPhkaAgAEmrwCAAFUlgIIkXwsAgADqlHA=
Date: Wed, 16 Jul 2025 04:29:33 +0000
Message-ID: <SJ4PPFEA6F74CA2063FBA6C2C962FC8CC02A656A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20240730125302.2132377-1-amitprakashs@marvell.com>
 <CALBAE1NkQuJCj+qOsVy-cZ2baj1+UqNhgut6jEtQitapp6DW1w@mail.gmail.com>
 <3321231.G96rZvMJ2N@thomas> <8204600.JRmrKFJ9eK@thomas>
 <aHZi3mRo7UNbYbvD@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHZi3mRo7UNbYbvD@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SJ2PR18MB5739:EE_
x-ms-office365-filtering-correlation-id: da7b2343-3557-4ca7-738f-08ddc4215d4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MDErYmtGTFo0VlBLb2ZHQ1ROaTA1bXdsRWpNV3VCZ0hLZGkrbkcweWNCU3dV?=
 =?utf-8?B?UEc1NmxWZUlaZWlId2c3dDR6L0VhRlFhR1prYmJ0THpvN0lvMXZVZlEzaEM3?=
 =?utf-8?B?OWhqK0RXRWNLYW1reTJwdzlGaXhmU3lXUVBBOWRuV0g1a0JZRkIzd29zUzRI?=
 =?utf-8?B?aHhuVVZxMWExZ25qUVRaSERTcTA2L0E0MzhtUmI5MURNcEM0dm9XUDJmNkg4?=
 =?utf-8?B?UnJkWlhxa04rNDBsdEtXeFM0bDJRbUU2L0dBM2s1bkxsUy9Ea1FzNndhd0w3?=
 =?utf-8?B?M3ZaNlE0aHZUNzYyRXdsTm5iN3F1c1duTGhFUys5YjJkU0pjdXZKb0hxempt?=
 =?utf-8?B?bXhiRlhOVzB6bHJRWFlPREJlL3NkVDFyTFR2TEw1eFRsOVEyZlRDcjlxSGZT?=
 =?utf-8?B?ZExZUnFWek5WaDNnTi90UFMzd3JuNFVhejd6ZkRpVEhPUHVhMlREVWlycnpU?=
 =?utf-8?B?MmQyMWVpczcrWUV0Si9HdlF5V2JaaDJYUUY2NlNIZFI2cGlKQy9TbnRWWmVX?=
 =?utf-8?B?RTAwaldHeTR6RkhiTTl3SVRKNlVuVUxOc3pWSzJmcVpuY3VSa2V2TTBjNHVK?=
 =?utf-8?B?WnZDNER1U3pyMTN5R1o2Z255dmxpdGRKQXIxMVp3c0ttVEFJT2pIM1NqN1NI?=
 =?utf-8?B?dmNWS1lTRmV1eTBMYjh3bWJiQm12VTlvTkRHYnlHNDhsOUxHcEtLM3V1bDlq?=
 =?utf-8?B?Qk5aNXZXQkdSZS9pRWRUeWpKWG5tZEQveWV6dHNsQ1JsMGQ0OEd5M29BWnhD?=
 =?utf-8?B?YmozTE1rUytES29OaHBiaUJBRTUzN1E0bDFsUzRrZ3dBejRzS1NHcFByVGZP?=
 =?utf-8?B?UmRPajVSNEthcFdQb2ZoM2hvS1licFZjOTZ0THpvUDVYbWd6bDZsK2xOUUUx?=
 =?utf-8?B?Um1GWXJ1Mm96S2V4RVFaalVVNGRsaHlaT0gxeGlmcnB1MHNsSzUwVVhCNTIz?=
 =?utf-8?B?M3d6SFhJbERzQmwzd012NjRZbHhRT0p3ZHdPaHMxbVdTUlRUWlQydTRGUzQy?=
 =?utf-8?B?NDRiTk1tbnNOb1BJcXB4QVRpS1BqOGwwdkxVaXRJa3ZnZVc3Y2ErcFpzeVZK?=
 =?utf-8?B?UHNtZGNwRk90d1pkMmR2ZkpKbzdkdHFsQm5GbHNtZENNa3Zwcmh3QkZhWUtW?=
 =?utf-8?B?RlNLZmVSQ3FMSjBsajlRYmdYaUc3aHhDTmhXS1B2eGs4d2JLTGxEMGFkSU50?=
 =?utf-8?B?cHY5bnZ1T0dNM2NuQ2hJdVc3ZzQ2UDFsMzI4ZWRjVlU3WEpZMzhiTnZoKzh6?=
 =?utf-8?B?Y2JpWjBCSjdteHRUVUxBSHljcEVqVHV1eDA0Y3pzR0dXdjkwVktyeHVRK0dP?=
 =?utf-8?B?di9IYmNpM1JLZnMxOExlTndGMG9KOGtTYWdMMXIzalpFamhzc2JvRTVlMzA3?=
 =?utf-8?B?Y1NDN1UyU0h2b3FoUDRvOVA4RzByY3NCeWVHcnkySlJ4MUp6YjBFWlc5T1E1?=
 =?utf-8?B?Vnk3cHZVcXJVQjVxblpzUjdVMExKaTJNM1c1TW96Y092OGxycXMyWVFuYzBW?=
 =?utf-8?B?YVlPQ2tTVytkWUlEc2JPVjExM25zU0RJL2Rub3AzSGJUZHhmUnBNWjFXTVc2?=
 =?utf-8?B?VFBnWnowQnppdm9ZQ09uSXc3NitRZm93YnVMQUlqOFEvTGJrcGdsM3FvRjRV?=
 =?utf-8?B?Nk9QUHMxQ3V0OVRmUlFIZ0JUK2NFVGU1VXFETU1sYmREb3FRMFlGRENCeTZj?=
 =?utf-8?B?R1N0aU94VVFjZFNmc3FjY1ZlREZTb0lkK2ZtaWR3ZmlwdnBUQTBYZll6cldM?=
 =?utf-8?B?ZWhtcTFwZVRDUmtXQ05IVFpkUW5OeEE4bWt0OVMrZHh4Q1p6c2VqRFU2WXRW?=
 =?utf-8?B?L1M5Uk9LSU5NY2ZJZ2hpaTVlaEhJTStlMXFzaFlROTFNcThHUk9iRUQrMkxF?=
 =?utf-8?B?Q0hEeUtHWitQV09UMmN4aVQ5MzBRNll2NkJwdE1WNWtYM053ZzFkeVVuNkNR?=
 =?utf-8?B?V0R6bE9HUU9nNDgvT1lDcENHdHc2elVlUlZFS1B2Q3JvcjNWWEpVd0doWkg2?=
 =?utf-8?Q?n7yVVpDmhbgi3HYJa9LgOt0Y15GxDU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlRMaWdSV1dqRHFrcEFqWXhjeHR4STc2MnVZc0MwTVNIUElralJjQ2k0ckxn?=
 =?utf-8?B?clNudTl4elE4V3VlRjRqdTVPNXFlQVlNSjB0MjZjcmR5ZC9hQy9xRVl6WG1i?=
 =?utf-8?B?M2tzVzM2bU9UYktlVlRZYWJLOGR5eURVMlBmejdRbDlvQmVEWjVxOExUTVcv?=
 =?utf-8?B?QUJDUzBKV2M1ZlF2aXZRMFMycW5TQWhhSll1U0xud085bS92Rnl6eVZZejdP?=
 =?utf-8?B?eFk2cVlMMnFrN08wdFR4QVp4V1gvcytDa1RrRlFTQkFmZk02eGNyOGdXbVlJ?=
 =?utf-8?B?aTVNRFVXTkFpajh3TlFqRDg0bnJBK3lmUVROY1ZsM3N1aUR0Z1lNUGRXT3Zt?=
 =?utf-8?B?Wi95a1BYZm5KY24xS3BlTXJQRkNVUGRqaHQ3VXpXWDdMSXpUMnh0S0VJVDB5?=
 =?utf-8?B?T1lpY0taL09YLzkvYjVwSmdIdGU5NkFEMlRubDgxeXNhREk1OUxObHJtWU8y?=
 =?utf-8?B?N3lsSVB4cWVKdXk4SHFZdDBsbHNRckpWVGZZQmpQa3BLU2FtMVMrd054OUk1?=
 =?utf-8?B?SGNCejVCamhaakZ6Z3dwSWJnZ0tuRTN3cVFzcnoxZXpOWDUyNnhrY3RLa3dy?=
 =?utf-8?B?RHFpYnUxTkdtMDQzZGZRaWliRGVYMndSeGJHSlRod3dDY2ZZdVVpUFc2L1J3?=
 =?utf-8?B?VHNteDJjT1NBN2MrUmEvaEk4WGtRMnJrOGNlU2ZMTTN6U2hDS2xPVVJsdzV3?=
 =?utf-8?B?WG5MeHZMSU4xM25WOU5uUy92NW9xc2VHSDV1VkNvaEhFT1V6YTJCYVA4cGo4?=
 =?utf-8?B?a3RDdm81VlNSSnQ3eHEya1RhZmxXZ3NFVlpLRXBsRDFlMk9KbEZDZWZ6MmtK?=
 =?utf-8?B?TmZSSStwaUVXMUY1eVBEZ0pTN3NLaGhGa3Y4aVVQeDUrNXMzR1JsWjVERHY2?=
 =?utf-8?B?NWx5cWJadWpzUmFZdS9OdXBNSkljcTNCNjhzV1cxTnNCR21NMmxtMXJON2VI?=
 =?utf-8?B?YXZuR3pJd0RZTExWY2grVUZJZDR0Wk51KzBYeUd1K0hUeHFoTkxYZ2FRWjlw?=
 =?utf-8?B?WEFnb05ZR01iNXM4UkpYRjFoSlhHV0xVSjB6RGxIYUk5aDQwQmRkZEkzNVRx?=
 =?utf-8?B?WnQ5dm1qNXBjb3Q0MVFIRW5SZER6UTU3Y1VkTXdocjB6RXVFYnFySkk0dis4?=
 =?utf-8?B?ODRxTTdwQ3p3b2txNENZZVl0WllpR3o0OTRiaE10Y0FwL01vYWMxSXdGZ1Jo?=
 =?utf-8?B?NXlLTEdTMXNaZmN6WlZaRWs1aTRzWDNZS0pBWitmeTJTbVRid21DbVA5OGwy?=
 =?utf-8?B?eXhHYmxpcU9BZUlISWVzaEtLU3ZEYk1LQnZHR1VTR3FTd1hMeXhuMVQxVFNw?=
 =?utf-8?B?L1NMcjh2UURhWGRpSm54N3dSRjJ2ZnhnZUM5YXpTR0JHQjJKTU5rUnRQNmdJ?=
 =?utf-8?B?L2tkd2NFRmtNZ3k4b0lKMHFiV3lGcmhKek8wa0N6VUluOVI5M0xJVXIwMUNX?=
 =?utf-8?B?TitMb2J4cDlMcXozV0xDVVMwSSsxZWJyZHBJREJRZlRMRTlNQjRNM2hNSzdX?=
 =?utf-8?B?QzJyYUNzWjdYd0NPdlZXaEExQXZqWDF6QU9sWDRyOHZjb0lvalYxTzc0TlFV?=
 =?utf-8?B?ZXJOaytneHBSTW5tSXpRL1hnTWRTYWFodGMxMnJVc0FCcVZYTmJ2bnFPZFMx?=
 =?utf-8?B?aUJVK3c5VVNIR0t4RmZodlZhL25DV3N5REV3eEhzcUdlOFBLSlluR1dHSXYz?=
 =?utf-8?B?RHcrM1Jpa0hTUjhsSlZ3QXFNYTBtQmRCRjVJUjVCMlVkdFUweFJEQStRQWJp?=
 =?utf-8?B?Sm5JMjBhelY0bkdIaFFXbXNuNWJYRDRJQnI5TWl2YmtJSVloYXh6WUprMXZE?=
 =?utf-8?B?YjhKNWlZaGF4a1NnS0k1YTRPckd4NDJxWG04MzRxbjBVRmVQc2h0djdYZHNH?=
 =?utf-8?B?dllySTl1WjhVSDExS25HMmRWMVR4OXA5OTVOTEd4bkNkUVBJTGlqa3dIK1BZ?=
 =?utf-8?B?OWlOVGJCSDRtSnorMndaakJLaFhuL0UvalRKZzVqYXdzalJ5MzBHWldUTmgy?=
 =?utf-8?B?c2w3ZDBFaldEMmtobGxBdWVubVNNaVBFNVdYUG0zNXlwTlRYRUZNUzZlaU0w?=
 =?utf-8?B?YWNLRGRkd3UyV2JzMVVCQVVGbkh3VHF2a2oyem94eVVmaFU2aDZaYTBrSzNj?=
 =?utf-8?Q?olWWbv7Q8CS3s3vH23VOhxcZK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7b2343-3557-4ca7-738f-08ddc4215d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 04:29:33.4078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1UeMoJrbcFvSVpx+km4BTF4Gl3Xatt+4CPk2PySaxtOoXEIIrGMwg6/avs3jtAa1of5WSXD3qlu4rsS/dySLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5739
X-Proofpoint-GUID: leoi1InRooC4Rro79sM7y5lBzBp1rAZG
X-Authority-Analysis: v=2.4 cv=M8VNKzws c=1 sm=1 tr=0 ts=68772ab0 cx=c_pps
 a=Bb9UCmFgZkwU76rQyEsQHg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=bt5KbKNvAAAA:8 a=QyXUC8HyAAAA:8 a=IWL5B44YXfBfU-dQR_IA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-ORIG-GUID: leoi1InRooC4Rro79sM7y5lBzBp1rAZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAzNiBTYWx0ZWRfX15B72zExczUM
 kARCNlazGrEFhkAlw55pqRZS0+6g/GQXuUVsrcw2bC2O+5qNI1nka0EnFbwqv7V5QjLoRRRTcz7
 eZWgU4Aul0V3BuFyU55DrtLVOdNF7MJZTxSWni5goEpNVsCvMeiVd5yMFHbh7iHu+e301ZxcbX4
 uF6j7XgOys12WpKbZ2+uXjO1r6NagY5pV1oTCa8OixOoHNPxWw75wmCpFL97iRfdLZNY+1Uxxhe
 NSg+JWzpvxYoJVALMAEoIYKVZM4btml78tsxLOo0IKRf/93Qim2ELd6ZKIiRA9cBxbMT0FTD7nN
 Md7x8zpHfC+Igou4ljPKDoRibp5a4WB/6wh2/804GnvlJ9bkAKYZCrmCXiUNmVwztqNa0ATHz8m
 K2PR5X5K37FklfwNeMUabN0JUZQFJ2IgK3ntjsMp44STf7D7O4IfSdxPwxcIEArBbEGqtVWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
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

PlpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj5PbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAwNjowNjoz
M1BNICswMjAwLCBUaG9tYXMgTW9uamFsb24gd3JvdGU6DQo+PiAzMS8wNy8yMDI0IDEzOjAxLCBU
aG9tYXMgTW9uamFsb246DQo+PiA+IDMwLzA3LzIwMjQgMTk6MjcsIEplcmluIEphY29iOg0KPj4g
PiA+IE9uIFR1ZSwgSnVsIDMwLCAyMDI0IGF0IDg6MjXigK9QTSBBbWl0IFByYWthc2ggU2h1a2xh
DQo+PiA+ID4gPGFtaXRwcmFrYXNoc0BtYXJ2ZWxsLmNvbT4gd3JvdGU6DQo+PiA+ID4gPg0KPj4g
PiA+ID4gQSBuZXcgZmxhZyBSVEVfRE1BX0NBUEFfUU9TIHdpbGwgYmUgaW50cm9kdWNlZCB0byBh
ZHZlcnRpc2UgZG1hDQo+PiA+ID4gPiBkZXZpY2UncyBRb1MgY2FwYWJpbGl0eS4gSW4gb3JkZXIg
dG8gc3VwcG9ydCB0aGUgcGFyYW1ldGVycyBmb3INCj4+ID4gPiA+IHRoaXMgZmxhZywgbmV3IGZp
ZWxkcyB3aWxsIGJlIGFkZGVkIGluIHJ0ZV9kbWFfaW5mbyBhbmQNCj4+ID4gPiA+IHJ0ZV9kbWFf
Y29uZiBzdHJ1Y3R1cmVzIHRvIGdldCBkZXZpY2Ugc3VwcG9ydGVkIHByaW9yaXR5IGxldmVscw0K
Pj4gPiA+ID4gYW5kIHRvIGNvbmZpZ3VyZSB0aGUgcmVxdWlyZWQgcHJpb3JpdHkgbGV2ZWwuDQo+
PiA+ID4gPg0KPj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVmFtc2kgQXR0dW51cnUgPHZhdHR1bnVy
dUBtYXJ2ZWxsLmNvbT4NCj4+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXQgUHJha2FzaCBTaHVr
bGEgPGFtaXRwcmFrYXNoc0BtYXJ2ZWxsLmNvbT4NCj4+ID4gPg0KPj4gPiA+DQo+PiA+ID4gQWNr
ZWQtYnk6IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+DQo+PiA+DQo+PiA+IEFja2Vk
LWJ5OiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQo+Pg0KPj4gVGhlIFJG
QyBhbmQgdGhlIGRlcHJlY2F0aW9uIG5vdGljZXMgYXJlIHNlbnQgYSBiaXQgbGF0ZS4NCj4+IFdl
IGNhbm5vdCBjb25jbHVkZSB0aGVyZSBpcyBjb25zZW5zdXMuDQo+Pg0KPj4gSSBwcm9wb3NlIHRv
IHJhaXNlIGl0IHRvIHRoZSB0ZWNoYm9hcmQgaWYgYW4gQUJJIGJyZWFrYWdlIGlzIHN0aWxsIHJl
cXVpcmVkIGZvcg0KPjI0LjExLg0KPj4gQXMgZG1hZGV2IGlzIHF1aXRlIG5ldywgSSBkb24ndCB0
aGluayBpdCBpcyBiaWcgaXNzdWUuDQo+Pg0KPk5vIG9iamVjdGlvbiB0byBjaGFuZ2luZyB0aGUg
c3RydWN0dXJlcy4gSG93ZXZlciwgZm9yIHRoZSBhY3R1YWwNCj5pbXBsZW1lbnRhdGlvbiB3ZSds
bCBoYXZlIHRvIHJldmlldyB0aGUgY2hhbmdlcyB0byBlbnN1cmUgdGhleSBhcmUgY2xlYXINCj5l
bm91Z2ggdG8gYWxsb3cgcG90ZW50aWFsIGFsdGVybmF0aXZlIGltcGxlbWVudGF0aW9ucy4gRm9y
IGV4YW1wbGUsIEkgd29ycnkNCj5hYm91dCBqdXN0IGhhdmluZyBvbmUgIlFvUyIgZmxhZyBkZWZp
bmVkIC0gaG93IHdvdWxkIHdlIG1hbmFnZSBpZiBkaWZmZXJlbnQNCj5Rb1Mgc2NoZW1lcyBhcmUg
aW1wbGVtZW50ZWQgYnkgdmFyaW91cyBodyB2ZW5kb3JzIGluIGRpZmZlcmVudCB3YXlzPw0KPg0K
PkZvciB0aGUgbm90aWNlIGFib3V0IHN0cnVjdHVyZSBjaGFuZ2VzIHRob3VnaDoNCj5BY2tlZC1i
eTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQoNClRoaXMg
ZmVhdHVyZSB3YXMgcmVuYW1lZCBiZWNhdXNlIGl0IHJlcXVpcmVkIGNvbnNpZGVyYXRpb24gb2Yg
YWR2YW5jZWQgc2NoZWR1bGluZyBzY2hlbWVzLA0KU3RyaWN0IHByaW9yaXR5IHN1cHBvcnQgd2Fz
IGFkZGVkIGF0IGEgbGF0ZXIgc3RhZ2UuDQpodHRwczovL2luYm94LmRwZGsub3JnL2Rldi8yMDI0
MTAxMTEwMTIzNi4xNDY3NzgzLTEtdmF0dHVudXJ1QG1hcnZlbGwuY29tLw0K
