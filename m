Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF1C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 17:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E582402E3;
	Wed, 26 Mar 2025 18:25:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 421D7402CD
 for <dev@dpdk.org>; Wed, 26 Mar 2025 18:25:36 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9SF08007938;
 Wed, 26 Mar 2025 10:25:35 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45meyk1479-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 10:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbR4Kwu0mKZ0mHtoIgIdJ55G+bTi4g2GY4M6BMh4DZs3k/smEnwtvVIjCSvDJtGSFHTeUbploXFK0cMip+Hd+fxxEs3ltX7dfgoKkHcjSaFVAuQr/CHVCvDUgGo2GzglB5M8mOZOqgoU5TiVbvk+2Ng09eKRXwptwLi+Wu5R+lic2i+Yg+Vw7SPcmpCw1g+4CY/kY0/aKpZfvqnjwqvgUeDBzYdBKYxeKo8Y8V8NN9bqmlLrwBolXQrDUMuCj9/N0+DQ93YR/TmlOZw0ybcNOw+MP7LRoo0arvd1VFiesi0uLTsPGux+ZwAgFDyffC8Ofr7D6dh64UyZuJYfZJ6asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J88/yUM4BxksydO4eF+O9TXjv/dpDPEMgJzgPRTVxpQ=;
 b=KGm1mp7SPdeFx6fwGzpibUM1wOwmx+i2xWpRs1ugGR9Dt98CMbwqmI4RzSgr4ptu0GaPHvi3b+sU0m6U3lLx4uTP1bcyktQ1kpRcdEIhKch7XopGdNsnZVsKiF+O0pNPmhVxCa7mjQXQcQqlxTaOuHpC3c+DCuVFs/r2qKela1ZzHo99poEuOUPLIooDfUEhySTMTQhDBoD/WEdXefJJ2zBh+qezLSHxLbCi+erAl1i96OgfRZrjsAedkrsx0O3svsIH7V614MnoRYAaaZCL6CamOtHA5lgndVgWN/mJ2psSDzwv9II/pdc+2hTcqGOSv7jfsbXHO+LACWws0NUj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J88/yUM4BxksydO4eF+O9TXjv/dpDPEMgJzgPRTVxpQ=;
 b=N5lsxW8RfpVOs7uaBpEcXpVwfdbd3wchF4IybccgVVD/SkJ0DqNVgweayPpM5/rvfc+B3vZX7HfwqGj04C1/Nwfh2Ill5sJtpxWP0SIyQvo187f3A6ZTP3Dkt9nSzOZySxUQ34+AggR6jIncV1RBXr0hz3qpm7Gg7m9nEwNfGuA=
Received: from CO6PR18MB4084.namprd18.prod.outlook.com (2603:10b6:5:349::18)
 by BL1PPF696CD3080.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d9f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 17:25:33 +0000
Received: from CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d]) by CO6PR18MB4084.namprd18.prod.outlook.com
 ([fe80::c296:9e34:99f6:944d%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 17:25:32 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [RFC 2/2] eventdev: add default software vector
 adapter
Thread-Topic: [EXTERNAL] Re: [RFC 2/2] eventdev: add default software vector
 adapter
Thread-Index: AQHbnlEY5sPCYY1EUUqljsflkGR70bOFd2OAgAAvKwA=
Date: Wed, 26 Mar 2025 17:25:32 +0000
Message-ID: <CO6PR18MB40846EBB54A664C6202851C7DEA62@CO6PR18MB4084.namprd18.prod.outlook.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
 <20250326131441.5965-3-pbhagavatula@marvell.com>
 <20250326071857.7ef4a050@hermes.local>
In-Reply-To: <20250326071857.7ef4a050@hermes.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4084:EE_|BL1PPF696CD3080:EE_
x-ms-office365-filtering-correlation-id: b41f55b9-f0f6-47bf-1ca9-08dd6c8b3694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REc0ZzZ4aDlOSHNidUMwMlBoY05hMUVzUzN5bXN0ZnpxUWozeUpmOXlTZksy?=
 =?utf-8?B?MEFwMXUya29ONENtZ3FVcXo3RzFUb0o3bkxYV0NZQmgyRWp5WVJoWGE0bE90?=
 =?utf-8?B?NkxnRW1SM1NscCt0aFVneHhTaE9mWmpWbzRnWlFEc0JpRlMrRC9jaTJSSTJY?=
 =?utf-8?B?Y3JYTzhzOERWaThiRzdSS25ySnRqbHdDVVY5cDhPMFVXZGZxT2x0UDJVcExP?=
 =?utf-8?B?OFFqN0JrWkxyQ1cyZHNselpSQU5weENjMXRtbW5FUWFwZnA1MkJweVdVbkZi?=
 =?utf-8?B?RjRxL01tZmlpcUpQRUxvQlFtNE5JcFpRdmdhcDBSQXN2QUNmYUtyTitIRUEw?=
 =?utf-8?B?dXVHK3prOE5uUUlRMGJRVUUrZkMxYmFVYWk3VnFPaHgvVXNqYy92d2duM1FB?=
 =?utf-8?B?N3FKeUk3SmFkcFRPRG1pZGJNWks0Y25JUnVJS0k5aTZ2TzdwMXZCblg0dk5I?=
 =?utf-8?B?QUczbVFScit2WXBkaFBHS3JlRXd5SWNxeU9uNjRPR0EycTJyMEJvSjZ1OUtV?=
 =?utf-8?B?dXcwREtpZllYSk1SazRvdFYyWVhncDRGYkp1OHkzME9uaUxyd0hZTkhjdm13?=
 =?utf-8?B?NjVBVnpaUnpyQlhta0NBQ01qcC9ZeHk4SFY3S2RQeVJydGw4RjlHR1A5YVJ2?=
 =?utf-8?B?K0VWR2c2KzQ2VlJHdFZCU09EZ25FUGtxUWZTcDQxWjdNaTloRjBlY0Zldjd5?=
 =?utf-8?B?ZG01cE13RTF5elhlUVd0d2FGR3hTd0k2M0xXbEZWbDU4emg1bFhucWFzNGZV?=
 =?utf-8?B?QzFrWWExZldLc2FsVXREYm14Q3V4YmhLRzBGcUh1bGNFYWJ5dDZ4UDlQVVdS?=
 =?utf-8?B?M1NmdmdONTBKRGdFNHU3VGhiOFQvWlpFalJ6U3JUOVg1bFQxMkdLQkN3ZWNk?=
 =?utf-8?B?L1lOaUY5Z1gzVE15aXBvMW5PNWtsR2RVTmF2UGUrbUdtZmQrV3AySEU3VFhJ?=
 =?utf-8?B?aXdHZk00cXNjOVp4VklsUkFCcVByMVVSa2RwUWxMY2VzYXgraHpaNE93RGgv?=
 =?utf-8?B?RUc1QW11WjVyS2NSMStJdVFCWnBBR05sTVdrMHFMQ3RscjZtcFZUK2dZdEVQ?=
 =?utf-8?B?ZUlhVFAwMFNKNTBkWWJ4aW5mOGw1SGRLR083S1dWR0lUdjcwRlNHSEFESEha?=
 =?utf-8?B?MkxUc2xhMitzbm8xbHRuT01DQXdmeGoraFZuVXRxckE5bm93TDVjUDF3VE43?=
 =?utf-8?B?S2YxQzVKSDIwalE3QXZXUjRuQlFheXJuVENCemVnOXFvaXpWRE96QlBzSjFt?=
 =?utf-8?B?NGx4Nmk2aGlGdHhYUE53ZEprLytFMERyd1RtK2R2S3F0RVY2aFJyeHV5NjVl?=
 =?utf-8?B?cDk2VGYraXQrZTlPM0JKSXZpTkJBNDFQa1pEN0ZQSjdGQmVkWktPY1RkYTQr?=
 =?utf-8?B?bGhYVTI5cmxHd1dpSEZvYVBZVlFVNFE3cUtpV29DeVhJdi9WME9DWWcrOWVo?=
 =?utf-8?B?dW5pVm90QmpzdnVvVUMwekpiQ3phT0szdTVSZ3BEazYrL3pKaGRZd3E1YWtI?=
 =?utf-8?B?SmVvNGs5eHlwNGRTT3FKQUtlR3JUaDM1T2wyNnByYjdLTFAvTWNFVUxIS3hH?=
 =?utf-8?B?OHVtSG9UTjl1M0F3VCtjQWNDdGRTYlBmU1dTeGFZSGZJVFRGS1U2aVpaZFZX?=
 =?utf-8?B?ekN5cUMyVVJ6MkdPU3JreGZTNFRtZVJFbUdaREZlUEwyUUZPKzBsYXU4VFRF?=
 =?utf-8?B?RFlML3RiZUdEYkw1R01sajY4eVRMMllLckdHNlErTTdDVjQwZ29OdjJNVjlG?=
 =?utf-8?B?UmtBR2xHMktOT0FmVXZLMFk2RXFIZFZPK2lhQkk1eHBnNFJGQzliV2EyRS9N?=
 =?utf-8?B?VUJCamdyckhQYmlWdVI0RlQxeEZZQlVSQkQwaUJZQ0JxMTRkYUNGMFFWTnF0?=
 =?utf-8?B?RmRNOEFVSlNBSS8zZGhkS3hYVlRockxrYU56di9GY3ZwUjZmZmFJaGNzbzh1?=
 =?utf-8?B?WldEOFlZV3BuQnpZYkZGampOUEZxdE9heDVLQktQOVlpMXJrb3JXZExkM2hi?=
 =?utf-8?Q?8whOobFmhopR3WsY6maDJJcZVv7wLg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4084.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWJZK25TNDhUUDZnR2hpT3RLak40S3dacmY3QUQ0WjhGVDcyR2RuSmh0RHRP?=
 =?utf-8?B?aTVMOXBScDZ3NFg2WFIyWjQ4THM1MFhjdmJtN0MxQllmMUV4Wk1DL21YWVI1?=
 =?utf-8?B?Q0J3bWd3eXpIdGwzbml4WWJwUWxUcXZhTGFHTnlyWFJHZmY2Y2NteFB3VlFv?=
 =?utf-8?B?OFY1Q2N0QVFmVHE3SFQwZktyYzNZaFlUNWVWSVlUTzNzUnlnUGwzaCtzSTcw?=
 =?utf-8?B?eXI2REc1bHd3R29zOGNrK3dGZGdhVWpMRVpBQjdaTFhjajlLU2x1UW04Y2F5?=
 =?utf-8?B?R3lPWkRnYkQwY2FBY0Q1QlpJMkhQY09zTkFoUE50Q0lXT2t5M3hkUkhHQWZW?=
 =?utf-8?B?NWFtREZUZG85MGI5NGhwTTl5a21DYzh3SjJ3by9DaUVEV3d6U1QrdEJtaStJ?=
 =?utf-8?B?cHFmZ0FtUzdTNzdZc0YwTnVjWU1pV1k4QVhQNjdseGk3NVM1NjhwTXBUS1Bz?=
 =?utf-8?B?UlR1c3BQNGU0RU4wa3ZId2UwZ1RIeTJEREV4V0llNFM4L2xtbWlnNVB3Y2F5?=
 =?utf-8?B?L2FRSFJ3MjVlR29wb0trdHQxT3IrV0FwaEg0cGVISCtDeVZlYzJ2ZUdSOUV3?=
 =?utf-8?B?TDVWZnRFUWdSbWtiNExlQzJYUmVHdzg0ZkNsdENiMDE5amFpdERDcHhaVGdU?=
 =?utf-8?B?VThyTWUwMnFhcGRVaHd5d2ZESWtkbUJxdmdjQUt4eWxyaFk5WG0xVTNHUFk2?=
 =?utf-8?B?UDRuWlNpamZ3SkxDTWFLakNmb3ZHME5INlo5Z2IyTE0wZHJjbkZ5VzBPVUVM?=
 =?utf-8?B?aUZjZGtXOHVqb2h0bGtwUVRHZGNSVCsvbStsdmVRbDd0QkZUUzRhOHpRN24r?=
 =?utf-8?B?VTZNZjZKV3gvbmxKbXAzR3VKbGIrN1FvYXUxVkhtUDZPRWswUnNwRXBGbTE5?=
 =?utf-8?B?U0lLOEdHQnVIMkJlOUprcW9WZGErUm9KZExNMFF6ZWZ1OTR2bHc4b042VStK?=
 =?utf-8?B?N3VrdjRWTlRJRStCUFY4VHBHcHlYZkl1QUVFRmV4aDR3QWQ5UlFSQTlTWlRn?=
 =?utf-8?B?Nm5qdThoUG96UkNmZG9OSGxjZVducUYwdEFCalVrL1RqZFNRUnpIMTNyNXN3?=
 =?utf-8?B?MGxIYVViOTBuVDhhNnJoYVB0MmRBU2h3NFB4ekY3YXJMQ2hmUG9FQTY0QnZN?=
 =?utf-8?B?T2VLMWlwOThHYk0yOEJaMjE5TUNXUGoyU2QzVE9aTHFGa0s3dDM5anJRNlhC?=
 =?utf-8?B?cktaQVNOY2ZDc1RhSGdwSzAxOHhqeHpVZE8rQmk3TTVobWRDWEYwd2hrOHJa?=
 =?utf-8?B?WUkxa0IrbVhJRm8rcGN2S2tUbUp6RHNpWWkzSkxzNm9IZS9hZWYxejRlKzlp?=
 =?utf-8?B?dHVJQUhtY0IwalljQkdGMmpQQlVLa25XZGl0dHI5dEFtblQ0bEZnUGs2WTBL?=
 =?utf-8?B?bmVWelJmeTZxVkQrcXA5YnNoTk9vVERoTTNoWk9LTnlXb0NlQXdGOEtYQ1c3?=
 =?utf-8?B?UnVuNXdSa09NVURRd0NUV092WnBzdWRicXF6ZUxYM3dISXhMYlFacWUxaUZl?=
 =?utf-8?B?T0ZIY2hhQi8za1pKaGRSVHlJVVB6bXVhQXVEWUxDS094VlV3MnAvS3FrYVVY?=
 =?utf-8?B?c0k2TmhQcG5YSXFSQnAvKzFyb2UyWmFBU1N0cXFWVEdzSjdoNFpuNWNUNXBN?=
 =?utf-8?B?STd6WThsUTRWVzM2K2FEdzMrb1pGd1Y3UlBEMkQrdVJVMWF4Y0h0WXdGelBG?=
 =?utf-8?B?aVcyb1pxRGJjaW1ETUNzWWZkOXMwb1o0blhEQnlIREVhUVJrMU9vTGVHSndX?=
 =?utf-8?B?Ujg4V0NYUlJRV0pTMVJmdVkzWTdZVTh3dXpCRG9DVE8zOS9XQnFrK3oyNFd5?=
 =?utf-8?B?V1pmSGxMdUh1VDB0MjIrNjRGczZYc3ArS3I5REtNelM0T1UrR2J1d2xOYXFw?=
 =?utf-8?B?d1NhRmxHWGN3US96NVZPbnZqY2ZrbFBqU3dWV0xycVBpQjljbGhONDl4QkQy?=
 =?utf-8?B?T1lHYmtSWUduek40aldzc2xjQ2x2NFdyMDVBZ1R6WWZDenpyak10SU5Xdzhh?=
 =?utf-8?B?MGFoaUR4N3FENkYvSk1sRS9XOGpubG1YLzBtdDNEQk10RnErSm1iVTlrazhX?=
 =?utf-8?B?K09qYUVETUZ2VzVadllsQjF5Ryt5YTVLR0JQaVN5dXJEL3BZTkJMc2oyekZF?=
 =?utf-8?Q?/LXcDChV+iywqxshvAoNdT8ma?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41f55b9-f0f6-47bf-1ca9-08dd6c8b3694
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 17:25:32.8275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htOtK3bAFnuyp8LOj9UKebbkVAXMYx5CS/S0TzQWCRzz09EtU3bGYF1Q0L8DlsULmG3juOciRDiYvBz6pToZu2D4SO4YwGMwPWFJDjM1kUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF696CD3080
X-Authority-Analysis: v=2.4 cv=G+wcE8k5 c=1 sm=1 tr=0 ts=67e4388f cx=c_pps
 a=joO5rFOndlhnht97C4Lqsw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8
 a=u9a_7x8DkM9ISFP1v_IA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4-HR3XljELoj3EoABFX-JU0bgmReUZ8_
X-Proofpoint-GUID: 4-HR3XljELoj3EoABFX-JU0bgmReUZ8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
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

PiBPbiBXZWQsIDI2IE1hciAyMDI1IDE4OjQ0OjM2ICswNTMwDQo+IDxwYmhhZ2F2YXR1bGFAbWFy
dmVsbC5jb20+IHdyb3RlOg0KPiANCj4gPiArc3RydWN0IHN3X3ZlY3Rvcl9hZGFwdGVyX3NlcnZp
Y2VfZGF0YSB7DQo+ID4gKwl1aW50MzJfdCBzZXJ2aWNlX2lkOw0KPiA+ICsJUlRFX0FUT01JQyhy
dGVfbWNzbG9ja190ICopIGxvY2s7DQo+ID4gKwlSVEVfVEFJTFFfSEVBRCgsIHN3X3ZlY3Rvcl9h
ZGFwdGVyX2RhdGEpIGFkYXB0ZXJfbGlzdDsNCj4gPiArfTsNCj4gDQo+IFdoeSB0aGUgaW5kaXJl
Y3QgcG9pbnRlciB0byB0aGUgbG9jaz8gcmF0aGVyIHRoYW4gZW1iZWRkaW5nIGl0IGluDQo+IHRo
ZSBzdHJ1Y3R1cmU/DQoNCklJVUMsIHRoZSBsb2NrIGl0c2VsZiBpcyBkZWNsYXJlZCBhbmQgdXNl
ZCBhcyBhIHBvaW50ZXIgcmlnaHQ/DQpJIGxvb2tlZCBhdCBleGFtcGxlcyBmcm9tIHRlc3RfbWNz
bG9jay5jLCBhbmQgdGhpcyBzZWVtZWQgY29ycmVjdC4NCg0K
