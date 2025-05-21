Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BFC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:39:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BDD242799;
	Wed, 21 May 2025 12:39:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C3DE64065D;
 Wed, 21 May 2025 12:39:29 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnsu001550;
 Wed, 21 May 2025 03:39:29 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sbxkr4vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 03:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBewroM8U7sXZiaSYUOohTPWmHBCJJEqzRgoBuLyrDCaQVVpaSh/yACqTF7BqvywSWTfimtRRGWKhXWVOkjR41G5MHYKhSHT/P6Ck3g8wpETzwna+IZSQBCExFUoiIi6p5WzxiY4YM7eoI+IBEbrKME4ps0WLGvr2k3O2rejNz5SOYvZkFSjV02pLawSqtaXL3VRtKU5g+mbW0cEcVss/K5qmCbPXgXUu2mQW5s/nIDtNiuUXBcPE3NcPtcUbGCedHK89EWouCopV7gdAUnGDFjY6N2QLdqe4snlSB2YDXWQrRdXrcYuUqm06gkvper1DJ7HsRcK2Z1XvH4fCNHbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN+lEhQUmNYx3PTrmK7ittZBsNhofD3P14Z5ww27HaU=;
 b=U0f3KaxgsoGB8R7phesTBtVouX9/WLE9VxxVkVtfQJQWH0Rm0IcskA6c/olc2JSq5vIdsdARKX/PFcBfBMXolGpoJ3yAi6DKMWtIx9uSOac/hXFtJI7YyhnJgSBdcfyJuvDT2LWAjb33w3HYqvza0H6vf9EjwkwGm628ky9nKjApvZ8qxeGzzU6NdJH8V/1HdwrbCiKo4hUTyMRDwvr7dZEzAHPoyMKSlHpBtDz0ep11CIXFFWJ7Lewc0BvvChzvfFCcgkaaTaX4BONPVAfV5s9iKx4D8FOtWP4QNyBOkxho4yF6cgvF+6JA4Sb3qgsUx2NTb2fBueL2odMk/Axa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN+lEhQUmNYx3PTrmK7ittZBsNhofD3P14Z5ww27HaU=;
 b=LHVlW8mdoDMeqxkqBu5vPlJ0hDupvESuKx5sG7F9rmVQbqsyi4ZwsY8ht00TiWh0UGh87izBfkrEKdHeJXU8Hcml9ZJ+0T1TWwdjQfrWfjMLrIPZIEtMThRLWBZhs3D6Ajel8mXClNCqpORnSRlemtrXSCk/Ws9nnHg4gagpZtw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB5731.namprd18.prod.outlook.com (2603:10b6:408:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 10:39:26 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:39:26 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Ji, Kai" <kai.ji@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw api
Thread-Topic: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw api
Thread-Index: AQHbmkznfTvYPXexqUiOi+Bj/5011bPdRIJQ
Date: Wed, 21 May 2025 10:39:26 +0000
Message-ID: <CO6PR18MB4484D31524B704A51D36CCF9D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250320165702.1439228-1-arkadiuszx.kusztal@intel.com>
 <SJ0PR11MB50568CBA098F7CB0222CA6FC83DB2@SJ0PR11MB5056.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB50568CBA098F7CB0222CA6FC83DB2@SJ0PR11MB5056.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB5731:EE_
x-ms-office365-filtering-correlation-id: 06de6a36-e394-4214-0ec6-08dd9853c229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnllaG50VEFYSlM0Qm1TcG05NlNaWi9CeXRDdm13ZkZRY3A5U2Z2RWVNU1Vr?=
 =?utf-8?B?UTdKa0h0Sm1xN2Rpb3dBNzNwZGxqU1BmdW5JdlV6M0FDU2ZMb0VtUDI1eXBw?=
 =?utf-8?B?Y1NjMFVpaWxiV0pRWEpWMlJWRDNGclBnbzdPclBIRVN3bXRxejZNYlExRUN5?=
 =?utf-8?B?TnJJSmpnbFAzeWZiRlJ0cFFZWDh2VUFEb3NwM3J1NGNZcjdBNGxHU1FsS1pJ?=
 =?utf-8?B?UFVpd042Z2J2YnZxNzUra2szSmhtMXlQM2tvaC80dksrMzlKQjVjMDBBYTN4?=
 =?utf-8?B?ZmFCS2E2cWFZYTRuYzhUcjloRkd0K3VBQWtaUzVJYzdXUW9rTlIxTjFIN1lH?=
 =?utf-8?B?RS9sSjFSTlY0Ty9JN0VaSmg4T0lYb0p0bS9FWCtuN3NTcm82b29EVlNhYkVL?=
 =?utf-8?B?ZTJwSkd4MUtPeStJeFI2YVUvQkd2a1VSR0g0WjFla0dzdUlUUUZmd1l6Rlk3?=
 =?utf-8?B?VDZqcjlLNW9TbW4rSzBiWFNpTmlaSXVRcVhENE9wTTVrTlpqaVR1b1AvaVhP?=
 =?utf-8?B?ZzdHYmluQ1o4UldMbGhJUmVDdUtacU81TTZkd1hMYkxWTXltTEdNWTRBWm5r?=
 =?utf-8?B?cXZmSmNhSFlXRmVPRms0TUxGK0JyUDBKL1NMczB3VmdJdHUyNmdwUmxFKzl0?=
 =?utf-8?B?YTNlR3BSY1BRajZJa05YYk5ESzhKNEJ6cTM2eWp6eldxNm5mdFV6MVhVa25K?=
 =?utf-8?B?YWdJdWh3aE1QdlJJbU45bGpncnA1bldFaWRLWEk3Um1aYndkSWpNWkUvN1p6?=
 =?utf-8?B?NVp6VTgxKzE3c2thSExDUHYwOXRLdUp6SXFPZER4ejRiYitkZHNrUnlUaFVK?=
 =?utf-8?B?SmRKQXdaNDZDOTJCMFNwczBvazhxckdCUmxzUURYWStPdk5Lc2hEaU5YTXAy?=
 =?utf-8?B?d1BOV2UzZUF6TktsNzhwUUVVa0RYUlZ2QzY2NFIzbjc4UTFEMmNhY08yaTIx?=
 =?utf-8?B?eklGK045OGhVNm13R000R3Q5OEhyc0s2ano1UDM5TFJsZytSTnlLNkl6amUv?=
 =?utf-8?B?Kzd0bW9sRVFuejg5eVZGQ2lQUXdHZUR5RXdCWVRKMThjOTdQalowTVN3elBM?=
 =?utf-8?B?L25UL3NxR3hoSlVvUFp5QTJhNkc1VXFNQzkvYVk5N0JEZ3JpT1Z5L1ZDYnFl?=
 =?utf-8?B?Z3ZoMjlJb0pESXNWVCtRQzV5M0toVWNRZldmUzlqNmd3NS90TG45aVd6aTRC?=
 =?utf-8?B?L3hPc3cxQXJkbi9HNXFHQktNUTlaSXEweE8wdmsvb2FNZkpjYTZyeVNPUkRQ?=
 =?utf-8?B?R0p6MHBOVzIwSCtiMFhyTDk0aXg0T0ZJdGt5S1ZkZG5PejMzaVgzYnpxd3VW?=
 =?utf-8?B?em0rSGNrclova0U1dHBzZnVvNVZiV2NqNENSdm1NOXc4Vkg3cXRMU2ZIRDVS?=
 =?utf-8?B?Qjd5K3Y4c1VDTHUvYTBoVVkrOGEwS2xURkNMTlZrd2pXcldlTldvbXc0TVhQ?=
 =?utf-8?B?eU5RZW01OC9GdHplbWVpdzFHSE42N0RsaHY1em5sS255TlNlSDJFRkVla05h?=
 =?utf-8?B?TG8rMmVReGxXNVFwZDJ1V1Vod2NZODVCN0lxK1ZYOWZKZlRLQmFWRzhpMmVz?=
 =?utf-8?B?UGMyMzhsY3A2cFNaMmFmbDlZcEExbFQxVkwzeS8rVjloYUJlRVZ1ZFpZbEJs?=
 =?utf-8?B?Nk5qbjNQa2ZBeW5aSHBPRW9YSmg1Y0xmZUhnY0F6UWFMMjNjVzZXamdOeVU1?=
 =?utf-8?B?OWRDM091WlBkdjJxdlBEU0x0VXBzQ3kzMFNKbThNYThINktmMncyVmo4Yzdo?=
 =?utf-8?B?d055V3h4a3JzMUJKUzl2eEhLYmcyVjVha3dQRkZvZjJTWEgydDZONVlEYlRm?=
 =?utf-8?B?dHhxUjF1bTMxU2IwMGxSU05sM1NQZkNGUmg1NmJ6MGh4QTVjRzd4UzBoZk4v?=
 =?utf-8?B?Z01ZRzZuN1duMXI1NTRMLy9MQ0xZUlBPQ1FFZk5HeE9NY1g1ODd5bTVNTHFJ?=
 =?utf-8?B?cVBCaU5HcEVlNzVEeFBUUUNIQ2pCcUdKUE9YRE5WRlM3Y1M1c0Zha0oraEdD?=
 =?utf-8?Q?tf4eu7J5hEpdGDMNI5BofEovQmy4vU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2FsU282L2M5eXM2V1pZQlYwdUtJU0R3bGpHei9vOUtZU1AySGxDYjJGWGh3?=
 =?utf-8?B?RmFvSlhBdHdVWmk0eGNyVWpZSjBrYWhEcXVwNFQvVmRCTG1iSmRxU2hldGx6?=
 =?utf-8?B?cFVyTHBzd3dtdHdBczhEbHVld011NHhrQlVsVTJxQW1jOEl0RlR5SlRyV295?=
 =?utf-8?B?Q2RINERXMHhmUHFySytUakR5cmhETzdud1MxdHJ0d3NPQmRVYTd0eHJuTTFN?=
 =?utf-8?B?ejgzNXdnTjJTWnZYS3lPeHFDei9RZ05UK2FpSExZSnhEMlFkR20vOVBxanpX?=
 =?utf-8?B?aGIxYUpCdUVjdW5RU2Vna3BTMGowQk5CN2JFeW1WZnVaWDU1ZmhxWnZDRDJL?=
 =?utf-8?B?SFFtdE1BdngrYTUwbnZwdVFiVkxJWmZHNXRoTVNoY1VLOXcyNm9QM3VVUmZK?=
 =?utf-8?B?eGFuTEVnZ3BWWG1QeUJsUllQYnNEVHFuVm96TGJtK2dBUGQ3KzFkUitMNDgr?=
 =?utf-8?B?Kys1VWNSS0VKdEJ5VmNHak11RlUzL0srQUtaTVMzY3hkY3Bnd2xFMnJYNzIv?=
 =?utf-8?B?RUN5V2gvbU5iRmZLdWs2c2hjMmhwL2JQSGhJVCtTYzI5cEZPRjNReDZ1NExV?=
 =?utf-8?B?bVMrNkt1QmZRM2FvNFFRMXBZMGxXaWIzMHZtKzZ2WVhaQmNZazB1Q0RIYVBZ?=
 =?utf-8?B?Z0hCR0x6VXVlck9pUGRyM3NpTjFBMEFGRWd4blZKdkpiQVZuYjBKR3BYODhV?=
 =?utf-8?B?YmVIVkhHaHFLdVFVeVJ5b0VsS2Y3TnduZjlHSnI4NzFDVWNPcHBuNTF3OXpj?=
 =?utf-8?B?N3JXTGJPTE0rRXdBRW9TeFlvNkpEc0xlZ1prVzMyQjFzVWcvcWE2cmxNS2tq?=
 =?utf-8?B?RVI0SXlVbFViRUJQOWk1WnlsYks3VDVPZnVnc0prS3pVc1pwMHFBWDZoWjJB?=
 =?utf-8?B?L3B2WmZidFlIeUtzNTI5T2F5bmo4cFlRd2g3TStIMUlTS3p2U0hYMldVNUNk?=
 =?utf-8?B?RWFVdnlpdmthS0xEcGpsVGhNaXYxak1LcVBSQnAvSFcvNDU4NGVUVU9HMGlF?=
 =?utf-8?B?cGhheUl4TkVlbXJxSFViRFQ1QlhUQTZVZWIzQTdLb0lJU2trSE9WdSthZUZW?=
 =?utf-8?B?T0sybm1oazZFOWE4bWtmeFJ5MklkdUtGUWQxSWNGSm9lRlVySTF6UjcvZnBp?=
 =?utf-8?B?d1NTRFdOaGdmRWVnK3JpT1RDcitqSWM0QjhhN1FteTdvMzdLa1FLTkJaUzZz?=
 =?utf-8?B?MHJvVzh0eEU0ME1ONW1sQ3dvdXQ0eHlKNDNQM3RMZVE4VUV4bTA1NldHUWpw?=
 =?utf-8?B?Z21SRVNtR3BpQ2pxUVMwRUswVHVaUXZocGxHQWFpWWlyUSszbW9WQ1ArRmNt?=
 =?utf-8?B?RUNOOE9DZ2JRVlV2Z0NsOWM3M1FXMGZnZU1Xa0FFRzdDMFQvZ1BFdlZQVHRI?=
 =?utf-8?B?VElUeTdkRU5qMVNyemgwWFBleElBSmhnalc1M2cvT0oyTHNsa3pVUHlTS2li?=
 =?utf-8?B?bzRLSHpmck1SK0MrUE9zL1dIWGlnbWJkRkdnN0xlTnAzNDBQQ3NKWXI1ZWYz?=
 =?utf-8?B?ODhXZU80ZGl1RW5YSS84dmlzU1ZPVlJ0TE8rZzZ4UjVnaDRLZTY2cWRaVC9x?=
 =?utf-8?B?QW9Vb1V6eVozZG9TMWVMYmpub1hWcUxQVE5sekhzb0xtbTNFOFI4WlhnZXNP?=
 =?utf-8?B?WEt4NjJ1QS9sMmdkV0pPRmpJVVdvQ2ZwUG9WcXBoMVB6NG1RblZRWjJ6QWlK?=
 =?utf-8?B?enNvMjh3TzdFRHd3ZDFLUlNQaTV3c3dBLzF2a2lZVUJsRkMzK1lWUmZUNXQ0?=
 =?utf-8?B?RzFXWUV4eGIzcXlLL2xYR3hZTEdPaUJzUWp3b0xiVkNqZ3dYeXJldTdiY0hC?=
 =?utf-8?B?UGMxOCtEY2paT2VNN200MGkxOUxESURLaVFpS2VhU2xEdGw3aXhpUkdITkdy?=
 =?utf-8?B?Qk5CRUFxdW9zQjEybWoybTNJeFRuYnRaN3haME5jSnp0VnlKbnZRemNsWjRz?=
 =?utf-8?B?WjY3K2R4V0NrNjVGaXprNStvTktJK1JzR3JCNzd3enpGdVpiUXNleStMRVZp?=
 =?utf-8?B?RnJXbytNOFFpQnBiOWdWd3JGU0ZqbEZQYVlXb2VZcUE3Um1nNnZGZmJ5dUN3?=
 =?utf-8?B?bHJPaFVsZHc2R0NNbGVkVHJRZnJXSGovQWxWb1ZWQVlkUDFoSVcxS0NGVUFt?=
 =?utf-8?Q?4FlF/Ak2Ybj1oEhFt5IsU0zYR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06de6a36-e394-4214-0ec6-08dd9853c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:39:26.3356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAH4dSrqT29puD2UaeR9Nl/JwB5ML/hX35iUAVatYpLAib4/opOqA364+FK8Fqcw0MUKqoojEyQdtvm9H6VTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5731
X-Proofpoint-ORIG-GUID: S_ULWOEKWzHoXL6T1pQ7Ccpmx-FQROOb
X-Proofpoint-GUID: S_ULWOEKWzHoXL6T1pQ7Ccpmx-FQROOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNCBTYWx0ZWRfX/sKlYFNPN4v7
 TBoKM5FDlddUWlg95/udD8FVdXUPTzgu5XkYFIYcc3vTS3yvmddminbiGV5hN0+jxAcCl0ztD9E
 HzXsfECNZidsz9awOm7mhwfOg1rDZcaR6ysHcYHX6XKopZRMnVlqH6LcuR4OrKoRP8FZN8AJTZ+
 QdiYttdkn8PKJItESimZCaCRZEtFJ/Rxc8XMoRR2Iplg4UqUGgJdokjyk7cIz0xwvCseqPRHEJB
 shLIbfYg0vbIsgkqc6yz+en9UIC3DsnXFK7TLM84KxPzX3nZJGTrisDLF69tbQu9SoVxtz0eXmW
 KI5tVw44BSka6wNPCACavG8dVs4KprSsrHIyEWY1dNGQb3AjIzfqWoiJFdBpFNUfqlO6EJBhuir
 fmM9MwRTLsE+p22L6l4jvbPG976/QxbdgomtJ/B/ti77KhtXAf6KuwH2dIrSTz4+lIGxjMn8
X-Authority-Analysis: v=2.4 cv=U72SDfru c=1 sm=1 tr=0 ts=682dad60 cx=c_pps
 a=eKE3A02riAhCxcKrmNn0fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=W6IWJvOjMuFhcIXYS20A:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

PiBIZXkgQXJlaw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IEt1c3p0YWwsIEFya2FkaXVzelggPGFya2FkaXVzengua3VzenRhbEBpbnRlbC5jb20+DQo+ID4g
U2VudDogVGh1cnNkYXkgMjAgTWFyY2ggMjAyNSAxNjo1Nw0KPiA+IFRvOiBkZXZAZHBkay5vcmcN
Cj4gPiBDYzogZ2FraGlsQG1hcnZlbGwuY29tOyBKaSwgS2FpIDxrYWkuamlAaW50ZWwuY29tPjsg
RG9vbGV5LCBCcmlhbg0KPiA+IDxicmlhbi5kb29sZXlAaW50ZWwuY29tPjsgS3VzenRhbCwgQXJr
YWRpdXN6WA0KPiA+IDxhcmthZGl1c3p4Lmt1c3p0YWxAaW50ZWwuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+ID4gU3ViamVjdDogW1BBVENIXSBjcnlwdG8vcWF0OiBmaXggb3V0LW9mLXBsYWNlIGhl
YWRlciBieXRlcyBpbiBhZWFkIHJhdyBhcGkNCj4gPg0KPiA+IFRoaXMgY29tbWl0IGZpeGVzIGEg
cHJvYmxlbSB3aXRoIG92ZXJ3cml0aW5nIGRhdGEgaW4gdGhlIE9PUCBoZWFkZXIgaW4gUkFXDQo+
ID4gQVBJIGNyeXB0byBwcm9jZXNzaW5nIHdoZW4gdXNpbmcgQUVBRCBhbGdvcml0aG1zLg0KPiA+
DQo+ID4gRml4ZXM6IDg1ZmVjNmZkOTY3NCAoImNyeXB0by9xYXQ6IHVuaWZ5IHJhdyBkYXRhIHBh
dGggZnVuY3Rpb25zIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBcmthZGl1c3ogS3VzenRhbCA8YXJrYWRpdXN6eC5rdXN6dGFsQGludGVsLmNvbT4N
Cj4gDQo+IEFja2VkLWJ5OiBCcmlhbiBEb29sZXkgPGJyaWFuLmRvb2xleUBpbnRlbC5jb20+DQpB
cHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
