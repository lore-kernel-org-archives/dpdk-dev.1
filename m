Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3668EA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A6304066D;
	Tue, 10 Feb 2026 14:14:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8C448400D6;
 Tue, 10 Feb 2026 14:14:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTNYl2972072; Tue, 10 Feb 2026 05:14:50 -0800
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020138.outbound.protection.outlook.com [52.101.46.138])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9fe5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 05:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si/WZm6PEfVBVOkVH3+K89Fglqa4KnL8U2Flk+wSqS5JeySf0/WPKcR6HjjOlXCE0YGYI93WddtUNJWARbRiA2rvu7sxX9x99NVtYVlqKg3TDYq2O9n1kxt4VC6RBpcQwmVQ7GlfpkCB05YIB6o1hpxs5UEl8fVtV7PFd0dhEVHcWk48/RGFwOy4/Is0ZejSLtBLqxdtV4oqTdFPNw5mYCbU/0cytrRLuw1yipGN35ugMMtnlXmEHxbh9xJDQA+itT2GlvEO+fHqHTiOjc3A8b1XAAMBXTnp5u+Tb6utaCrdajuPHDggXTcqrltDNHhrCXfHgb1md4GlTy86ZlLO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrISbmkQKHPbdt7ymaTw2znuJzivrNn/rJ5YAz8f64I=;
 b=LG3awQu2uEcaRAzvlRk3K1bRUK1ijFDaXOcKIlb0zfIe17HwPMnz5kzDKGFp6SXYRy4z9W3ePhw2diPASSThteLys7D2DgTUn5Er32M6+GQhr6QqL0hwHKYTaMfNpo7A/9JGhBAkVWNVhpEkkEhF3BzuQwnpOjV+vUuM0hfnuHe8rDxDz4kxwj4mCviB/P2nHBnvN9dP5KqUy26MJdsoT3lhfEjP9ksnOITyxS9gumaKngk2TB7zkakTOANR2TWTr+BFZTYESJMLNSFVVaJhzREszBGjtDlsblk7n2KUZ9jIuYLLRturCC3VqLydXmOkT4DqdsCkFtKbK38Cqm4/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrISbmkQKHPbdt7ymaTw2znuJzivrNn/rJ5YAz8f64I=;
 b=jF6Mh0rXDMydO6zDc5DeqBabmVYyfS7u44e0y/qQdSOTLmjAs2PA+y7mbs4OQQ+fYCjEJKatDRBiECDuJkKEG/Qe/Zk5P/KVR+cNvPFQeZmGEnxLdw2ds97cQv96mlUS1VNjlComDwSCTLiS60+pskFAEMp0YDSwBnv3tuAmaE8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5617.namprd18.prod.outlook.com (2603:10b6:610:1a0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 13:14:48 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:14:48 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/qat: align the the vector address
Thread-Topic: [PATCH] crypto/qat: align the the vector address
Thread-Index: AQHcZRgnxxUctqiYaUaiC8bVEhvL+7V8VC7A
Date: Tue, 10 Feb 2026 13:14:48 +0000
Message-ID: <CO6PR18MB448493F8E7F57745E2E15924D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251202105731.851124-1-radu.nicolau@intel.com>
 <DS0PR11MB7458A283A8B07A869A7C1FAF81A6A@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7458A283A8B07A869A7C1FAF81A6A@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5617:EE_
x-ms-office365-filtering-correlation-id: 7f94ae94-db23-40d2-299b-08de68a65df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVQwY3hleU1td2lWSmdTMlFaYkU4YXgyV25jMjRuYjAvVnZ5aTh5d2hvZFAv?=
 =?utf-8?B?U2MzelFaanBxZEhpQ2xYaUhuODBCYUlUWVNiR3h4SEt6Zm9uNFpkNHNRWTZi?=
 =?utf-8?B?Y2VnMVNrRG8xMEZJVTJJa3hDYWhwc2F0ZkptUVROU3JIS2crN1llcXhuSHgv?=
 =?utf-8?B?M1ZockJya1k2bDNGNGx4aTBoTVNtdVFJZnVTMndLQ1JiMXlCTjdiQ3JFMG5a?=
 =?utf-8?B?MTdtTnk0M1phcWt1dGlPY2poOXRmWTZjY2huS1l0MXJ1T1VPa2JEN0YrNjFS?=
 =?utf-8?B?NkNUYldtd3JaS2JpemMzRVlQVnp2YTVVcms0NW0rbGUzNHQ1VEZuU3hLcXZY?=
 =?utf-8?B?T2MxK1V0TzNwdW9QVzc5OXBNa2ZoTXA5TURXRFY0a2F2dkhHZzVWMWRPMHJV?=
 =?utf-8?B?N0pBVE92N1RZN1Uvc1ltZlJndlZDekdKR1dqTUxxOTg0Ym5waEY4OHN3ZWJO?=
 =?utf-8?B?SVFVemREOWtKN1FXdklScG1iUWRLZEJjdkplaU5Ca0srQU5SeWdYNUdOUng5?=
 =?utf-8?B?YU4ybDAwVlNldWRKMUZkQUF3bDZLMlBPZENET0thbEhXR0w4OTV4M3VwQ3Vh?=
 =?utf-8?B?OFFORzI3S3Q3SStqSVd5SXFGQ0NHS1dHQjdJd3lBYVg3czhFVXQ1NHlreWE0?=
 =?utf-8?B?NURpaForSHBIMzRJUSt6RmoxNmlCVTZpQzV0akJzTlQ3d094RWppRmg3dGRE?=
 =?utf-8?B?K2paNHRGWWw4Sm5PQ3k1VHhRWUs1bG9ER3c5dWdJaGhCV3Bob1EzNGZvdzZs?=
 =?utf-8?B?bWZNVzlLVWVvYTBvbncrUUVVendQY2dxZi9sOHc1RXljMU5IUWlvTUg0TmdL?=
 =?utf-8?B?VU1sQlE3RkpKUldGVzY3NitDTlNOZW9FK2VMUFg2Q3JkbW1mTnRjS1NPakZB?=
 =?utf-8?B?SGF0Zm1kSzcwUHlWVmd6VlBIT0pnODM1N1RnVFRhVDJJcW85cWc0OUttVTJ3?=
 =?utf-8?B?MkM1S2ZwK0lEdXVNUHBYMHpkVFExV2VkcWxxTW43UDR3ZkNRTXpHQU54RDhq?=
 =?utf-8?B?NXNmU3dqOFhib0F2Smc1Wk1kcElQT29zaUpiU1o0VjlWK1pkcHJDcWtacXNo?=
 =?utf-8?B?NXA2em9SVVpnMzk2VUlrb2ZDZitITnRyMWtQelhKODB1YVdBcERseG5OS21a?=
 =?utf-8?B?eFZCNjExbWVURlQ1Rk1ZTDdvaGRrRldodkF4ajRqWU5JZzJKR29UbVBkeVpK?=
 =?utf-8?B?RmRVZ2I5VEtYYXRrLzF4OXFUV2lmRGtOUkxlVHF1M08rWmxWa0tzaW5sL2dv?=
 =?utf-8?B?RFgrMzNmam9TYW8zVFVDN1NRQmV2Y0tSNy80ekJDZzVwVmlaZkFvUTh2aEtW?=
 =?utf-8?B?L2NPWnI4YzhQdGl2OHFYMkh4UXRWVE9BRm05T3BWZXRueUN3SnVEcTlqY3NK?=
 =?utf-8?B?NmpqekhIdUttVGRrNHkvSDJBYkV5RG5YRFZjQzZYUS9RbnBWNElXVm1zdmx4?=
 =?utf-8?B?bkFQRUJ4QkdoTjJQRnZBNEt6NDhzWG10QWZoRFNvNHRRdzVpV0IxZ2JPY2tF?=
 =?utf-8?B?WmlGNXMwWHNIL1l4WEdXV2ErREtUSVExOC92aEliTXN4K24zZ2Y0c0xEOTRY?=
 =?utf-8?B?NU1qSDlhYjdHRDJtNE5ubXFyVlVaenhJTm56SHcwVlFrN0NzSklpSTdTWlp5?=
 =?utf-8?B?VzR4dFVtSlVYLzFhSHl6UTVLRmx2RXFqQmxIUTdqblgyenh4U2I0QXFzSDVa?=
 =?utf-8?B?a1RJdmNLQS9JdXBjbzVSb3pNejNwU3J1bi9QZmJtMmVSc2l0MGNJeTJYeVVD?=
 =?utf-8?B?MDBNVzZmOVd5ZkNPaGlpUXl6UjBZcW5TQTdJNFAzOVordlp2SUtkMzF4V3BV?=
 =?utf-8?B?TjFQZ0lleFpSOFpuczU0Z0R1bmhqNVNkeEwwTmdRNEliNWVzbmduM2p0UTVN?=
 =?utf-8?B?ZkZBVW9RRzFTeWJQQWNOZldUSk4vaXdvVEdCSUJOSnRadmk3cGt2Z3lmd0lM?=
 =?utf-8?B?S1dNYW1yQ1c3MjgyQy8rNlhBU2puUFRlYzcrZER6L2p1dnc0dEljekgydkt1?=
 =?utf-8?B?clBBclBCblh5cnI2SWJmU3ppamlidXFQVk5JbTh6QVpteFF5VnVoOUZQcG8v?=
 =?utf-8?B?RUY1cHZ3MGdGQUFkeXdIUVZtM3VCZ1JsckZvQThRNTRNU2QwZVhqem5Uemx6?=
 =?utf-8?B?K1N3RE9SNTl0TlVjMkxVRGk1ZVZFb3Vtbmx1OHBpcWZEcjBYTmJuZEhLSVVu?=
 =?utf-8?Q?hiCbWO5mJ2qOG8q5XE1u+m4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDM4OStveXgyNngybEpjR3VRWW5taU9IOHVTNjVrM2dwTzZMcytsWHFMS2V2?=
 =?utf-8?B?R3d1L2J3ak1ySlZtamFGTnk1TjhkaU91WTV3RCtsalhJR0hIdnROVUxUV1Fq?=
 =?utf-8?B?RWlpZ1cxVC9TV0swSEVxcXBhbmROY0dvMGxMTGJka2hMdnpuS3RQSkNQald5?=
 =?utf-8?B?TTFoSnNQblVscXJPMkJSempoUTBuOXFWRnYyNUIwcVhFeGkzc2d5cTB4TG42?=
 =?utf-8?B?ZFZZK3ZWN2pwNGJidTVZVmV3d2tWUE1FN25OV3VRSUxSOHZVRkNCTjA5anRT?=
 =?utf-8?B?akhTaGltaEJramdmUjhyTXc5VUdyTWRicTduSzduclVOU2l6dmFoL1VpMEdv?=
 =?utf-8?B?aW54bkxtVGZndjlQSGZzL0h4YTZOVzVDYlFqSkU1NmtsNlNmdGRRTVdUTGpK?=
 =?utf-8?B?N01zZEIzOWRKcCtCMnhDRUtuakloeTBXazBUUGE2a3hSWDZXc2swWXhZenRp?=
 =?utf-8?B?WmE1NG5TL3BrWms3V2xJWlJ5U0lnc1UrOEZjc3d5SDR5RjZFYUJ1ZGFhQkhY?=
 =?utf-8?B?RkRra0QyNmFhbDhMZXVRM3JzVzkvbEh2Uzk4MGZua29XaXRNRGVYdFpPUEpB?=
 =?utf-8?B?YWowTFJjVkdlVUtocUJVT2cvMXR6R3ZUem9QeTc0OXNFRThYaUxaYjdaQko2?=
 =?utf-8?B?SW45SXFucVZ0R2ljZzJ4K0FoNEJiaHlERnBkR1dEK0dsYjF0U0lib2NaWTFN?=
 =?utf-8?B?d3NiTTBYQlAwcmUvOXBvWXZaemtFY3JPaUtHdnBpcmx3MDBuaVVpdWVkRk5E?=
 =?utf-8?B?OG50TzhnY1BVY3FuSGR1bDI3UCtpc05JM3Z1SFpIakgwa3FIeGEwenNKNE82?=
 =?utf-8?B?ejlya2dnbDRpaUNQMHlVeUZXMVUxeG5ycm1IK281N0JFYTRuR2VvUit4SjBv?=
 =?utf-8?B?aWI4MXowZ3JTbmxtYWVrU0RYRGdBQUZLcHpZMVNMaTFGcGFjbFRhVmFLdUQ1?=
 =?utf-8?B?Z3NicWJXOUFOMGdxcTZ1WXhvT1Jpc1E0eEpuN05raTdnSkhyMFJsc2drNVAx?=
 =?utf-8?B?R0JQUFFxQ2FvY0dTRnJNV2wvYWNUMm9hUlIycVI4UVFxVWJEQXVzOUpzbzB2?=
 =?utf-8?B?SUdkVGlCc2ZLRWU0UHcrQWNZclYxNXVnTEJWOWhaQzJzdEptTStpcEZhLy9p?=
 =?utf-8?B?akpLVDdqNWU2Rld1bW9QanRScGIwc1AySHlWdUUrWTJFRUZZOGVzRlNyTEtR?=
 =?utf-8?B?d1VpQTJmM0RvYllGMGdnZ3FpOXZHZWIyR2FleG9NNUtxb1pwdUVzWG5aZ1N3?=
 =?utf-8?B?cTFqOEQ4TVBuN2p4SkFCejMxQWExaCtsVE92VVZlRlZHWnV1YWdjSUhTV0Jt?=
 =?utf-8?B?SE9yT1hTaG5HTktoTkdFTjZEZi9EOFNoRUcwYTlFV05WTWdZVkNYNzk3SVZk?=
 =?utf-8?B?Syt3cExveGRzRm4yNkJ5aG1lakxpOWpEamFsa1hTSUViOFQ4UWdkU2dhU0lM?=
 =?utf-8?B?UVFEejVwM2FjRjFiVkpXU21Sc0RIOXN2aHNPS0pIZFNtSkNVeHFJQW1VckZT?=
 =?utf-8?B?N3BIcUhxcDVZYXc0UHo3MmM2c1hxUnZNemY4eGQ0LzFHY1hJMEJJVVBCUFNr?=
 =?utf-8?B?bkYzY0haUTV6U0tZUGNucll6cFI2MlZiaFhoRWFUdTc2ZlJQVm53djl4ZmNK?=
 =?utf-8?B?MWs3ZHVRYjJsZ1dYZldiN2lvbXdyRGV0V0M2VjYyOWVremlLWVY4YktXR3RK?=
 =?utf-8?B?SjZsejNWTFlNczlWL3A0YUFoTUNyaFRGZS81OHhVZDE5MDJFb3VTQ3dLQ3Bj?=
 =?utf-8?B?dHVuVWF4dXZ1ZzZwT0tITXRieFpBQjFoQi9wdjYwMlRPL0JrYTRpcmFjenl2?=
 =?utf-8?B?RndqNzA2ZE9oOHFBUzltSEk5SENDam0zM3BZaytFRzMvOEpBZVNDM0g1ZWpN?=
 =?utf-8?B?a3RrQTArZ3AyeEs2dm51Tms4SXcvQ3NaVlZNbnFVSW9HNmNNOTV0cTJucDE5?=
 =?utf-8?B?R2J4aVRjai9WQWh2MzczMDNzS0I0dzhvTWFTZUxyZ2dTNFFZSnZzeUFCNnRi?=
 =?utf-8?B?MlU4WmRMN3pzSXZteXBTN1NIZE43OXRJNU81Mm5XdUtTZVcyd3BXWHlBQzFi?=
 =?utf-8?B?a21mV1VvODQ5YzczRm52Nms1cDBtOG5ReTlMNGlvNXN5cmxWZjRTSTdjQzJJ?=
 =?utf-8?B?VzNQc2tzc29xNWVnU1VJRncwSnJmd0tkUXhGeGtUVUVTQVJvNFl5QlRtOE9F?=
 =?utf-8?B?bWl1ZlM4VXdseFAyT2tkME5adXFtUFFPNHYxcG1hNDdQWGJFQjViZDdDeVZ3?=
 =?utf-8?B?RUlwWlJwZUFBa3FvL2RZOGpCTWhMRXA2Q1dnakkvOThWMzg5My8zVVVMQnQv?=
 =?utf-8?Q?ge2/BQ3REq7vCfAoI5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f94ae94-db23-40d2-299b-08de68a65df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:14:48.2887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMR8FASbklh5kzOvkEr8/WKGzHjwZIw1ttTjT2EYdjhhO4wZaD2Q9qbr9caYfpEm1Brv2e0lMTwM7ycE3h4a+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5617
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b2f4a cx=c_pps
 a=FoMG50TuxTqJTEtiCMANQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=qqt3BSDvgcyfP7IvoC4A:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMSBTYWx0ZWRfXwyrvXbwiOoK/
 8wdI9qSjbfJQgIxJVdoA1kpte5QEgzIKRt4NfD5CJX0eUKlYrXJf9h3WvF6M/8kvw21YItmQm4e
 yzRCAl0LM4kZ4haRPm7DFZSwcRrJqOiSW1eoubWV+coqrgCpoEv9s8cKRflUL53YWzQ2aE1m1XF
 b9b1S2hhz9xBzDAr2Zb4GKKE1/CqZv4ocySS+cvnEzNTDxUIo9mqdu3FrRkMky82P0XDSm6rbxE
 Py7JIEVVMnd/lYo9ORnMp1xkxSR+BY8mxsLx/adSq5eSNIwKJflIdEIbiVG/8m8HFlMuG/ee/0P
 r4ZLrzRbk4jaK7goNb7FubblLIJ6MQRIJv5LTgTjj724bVNMNco2izHZH8v5Esdt9aj+62+9cWG
 uzI4P7ckp2QiILUIHYbXKfFb84QtxsgKJOSI337+0xzxe12KyRZO5qL2BxSDOKP/UPhl4qXdC1Q
 SY+TgTQNDIa1pJMaebQ==
X-Proofpoint-GUID: JIbTxMJ24sK66K-JAhdJtbnGIkN5zEry
X-Proofpoint-ORIG-GUID: JIbTxMJ24sK66K-JAhdJtbnGIkN5zEry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

PiBGcm9tOiBOaWNvbGF1LCBSYWR1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBEZWNlbWJlciAwMiwgMjAyNSAxMDo1Nw0KPiBUbzogZGV2QGRwZGsub3JnIDxkZXZA
ZHBkay5vcmc+DQo+IENjOiBOaWNvbGF1LCBSYWR1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPjsg
c3RhYmxlQGRwZGsub3JnDQo+IDxzdGFibGVAZHBkay5vcmc+OyBKaSwgS2FpIDxrYWkuamlAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNyeXB0by9xYXQ6IGFsaWduIHRoZSB0aGUgdmVj
dG9yIGFkZHJlc3MNCj4gDQo+IEFsaWduIHRoZSB2ZWN0b3IgYWRkcmVzcyByYXRoZXIgdGhhbiBj
b21wdXRlZCBzb3VyY2UgYWRkcmVzcyB0bw0KPiBtYWtlIHN1cmUgdGhlIGFsaWdubWVudCBpcyBw
cm9wZXJseSBwcm9wYWdhdGVkLg0KPiANCj4gRml4ZXM6IDI1MzE3NDMwOWZmNyAoImNyeXB0by9x
YXQ6IGZpeCBzb3VyY2UgYnVmZmVyIGFsaWdubWVudCIpDQo+IENjOiBzdGFibGVAZHBkay5vcmcN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgTmljb2xhdSA8cmFkdS5uaWNvbGF1QGludGVsLmNv
bT4NCj4gQWNrZWQtYnk6IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT4NCj4NCkFwcGxpZWQgdG8g
ZHBkay1uZXh0LWNyeXB0bw0K
