Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB23CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC1440666;
	Tue, 28 Oct 2025 15:29:08 +0100 (CET)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020124.outbound.protection.outlook.com
 [52.101.191.124])
 by mails.dpdk.org (Postfix) with ESMTP id AC6524028D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:29:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hepD320VRIFx4wldOPpYCLouYwR+pYJcyObksYAGvn9xmeD8MvRXDHdrcE+2qngPIIGB1zEQ0CVXIprilRbWcVDgqggtY/pPPfBLE7U/32q6f753uDqx5wpEF+/8feIqmEiEFRkNImkTY4OeNtja92TLb5VrkJsTx0mxz65ltr72Rdq/im65JIV1tTKwS3YyXK4DJJaS7bp8jkAvqV4BzNbI43ZGLVbqyNAuCLq4XJpwPGhkIQyabt9+F0/KluPPnazeoUUM7SiL5hhBa1r8E2fJFoHBuhBDL4rZrEwjSFqnISwYxHb8d3/kHF08BvIedD1ifwpvdGBk/Xi8wr4TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRgpPBA7RGTQBPd2gWxzJcmXmHlHKOh1maRgX1TfA2w=;
 b=l0W+j+Bq4qUsgC45DzuKr3P0HkMlZ04XQkAdkkAphGLXzF/vFFkTafManHVBjZ5uyv6BicO2a/nQxXIaBN64mySqeDiD/hhpG/l8/HJWzt15bsgUQWtJ2w2QFxu0lyRbQJCTx1Gs6QO46lntpCWEN51R4YFbf36qLdv+P8aWYrht/p5NHvAQxuqeMWQ0C2GKiG1/8Pfx0/+H5YdrLW2TJ3Ab/jrGgMPUFnmV3qn8olGtP+g3vbuqKoSDIkn7HK7TTn+u0u4z0CZFjPMbUHK1/pDsU6nWKFo+22gl+qI8Uxlfu0dwPO5rnST4Zwm1n671+nGPt/uKsgl+21xxPfvQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polymtl.ca; dmarc=pass action=none header.from=polymtl.ca;
 dkim=pass header.d=polymtl.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polymtl.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRgpPBA7RGTQBPd2gWxzJcmXmHlHKOh1maRgX1TfA2w=;
 b=S1y4n0pnj1hWT4/MDrRc6qFmouPwSKKScxtywoqF2i4+megqsKEa3YCTjsm/n1UBE6EltcOL0hZ4z9OxB+AovyGyWQwHiyDhoby/4kZbE057/OYBDi9l1D7pZMKQbSCfMbp9IH7N9BcEKvfENpiMszVyIG+BsXqtDZhRv03BplR46CwXl1hg8J96RwO4D6yXOrMIHdsd3CG6K8AEAJKjHhd/OGOaoyFErcQmCLKR+39mRza21hKLwnLlH8C6yYAzPEYJzTpf8jOSySHj6ErNSE1zLUL9DEMXgJJI8pnj43tlQcQRKChH9nCRBI3cLiIdGz3Tnztx8Xq+Zdx2eYCDVg==
Received: from YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c9::20)
 by YT2PR01MB9906.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 14:29:03 +0000
Received: from YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1416:213a:12eb:93ec]) by YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1416:213a:12eb:93ec%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:29:03 +0000
From: Adel Belkhiri <adel-2.belkhiri@polymtl.ca>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: [Survey] Debugging and Observability Challenges in DPDK
Thread-Topic: [Survey] Debugging and Observability Challenges in DPDK
Thread-Index: AQHcSBbVbfngrPmk7E6OfTNkzKA5Fg==
Date: Tue, 28 Oct 2025 14:29:03 +0000
Message-ID: <YT1PR01MB882655C97B77B9EF71CB482D8EFDA@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polymtl.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT1PR01MB8826:EE_|YT2PR01MB9906:EE_
x-ms-office365-filtering-correlation-id: 08519687-394b-4f00-a673-08de162e581e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021|8096899003|13003099007;
x-microsoft-antispam-message-info: =?gb2312?B?RkVpYnUxNGYxaXBIQ1k0R1R0TW13TUpmVG9RNEc1NE1pSUJOOVg3S3Y4YUx5?=
 =?gb2312?B?eC9GYytCcCsvYjRMa3ZmQVY1NXRBQXVycWd5RHJaQUFJS0FQRnJ6RXMxYkVE?=
 =?gb2312?B?TkJmdjRYVVhEU3A2ZmZhTTB1ZjN0cUJXK0Q2cjB1cnJGeUpOT0kybkQ2OWJF?=
 =?gb2312?B?am5rRFlld3RLeTRmNnJTaGN4TTd4dEJLR0lOa3QzTDk0UzByNUYxL0FaZTgw?=
 =?gb2312?B?dTVVOGJBSnJOWnFIeVFWNWdyVWZwSDVCY05Ld0d6emVlejN6MU1vaFpaY090?=
 =?gb2312?B?QVhMV0lhZWJtUFRVeW9EY1lCbFZlVXMxUkdhUzNsZTY3UmdKMitBaTlYTTV1?=
 =?gb2312?B?WkVsQTFGWWtBeXBWdjhnMU42dCsyS3FQblh1dndvaUNkMGhpems1MktLQ09H?=
 =?gb2312?B?MGpVbDIrejdHVFo3OEQwcU01NEE1OEUydzNTSm5sTmFGTjNoVCtlUDRuNzdp?=
 =?gb2312?B?N0c4VUx6dGhMenExSEY3ZzFjRHMzdXdmaTNPSHUvVER3WXFxaG5ZMW03MnVx?=
 =?gb2312?B?TkNOWkxoVmxLVmsrdHVTUlkxOHNtSndlVnBKY2hKTnBSRWpIbFVPNGVZWTBL?=
 =?gb2312?B?Q1hMSEtrK20zMEVhSjA0bVBoQldLcS9Td1NaTEdabkFJMmRzaVlmUTV0eDlh?=
 =?gb2312?B?TkxZVk54UUxBNnNTNk9rQTlBRjRXcnJzcy9lY3dBVi9PTWs5ZHNEOWNPRWVH?=
 =?gb2312?B?bGFYci9WMGpOK3RSZGErOE1TaTJCWkt4a2tiSGFkRUQxdG03OEk1a0RGUmRV?=
 =?gb2312?B?dVpjcGlLQThwbzdpbTlnL3FIaUJrR3d6elpvQUYvSWc2T0JQajNiRnhaMXBO?=
 =?gb2312?B?dUNtQ2pmbVRtK1h4anUyVHZyVGpOQytpc2Uyc3c4Q3ZweW5LSEhVU25qcmZi?=
 =?gb2312?B?MGVvZlBDbG9JK0UyR1E5YWx5RjlwZnpMbDVlTEpXQjlJOXFoREp5UkZ4bUcr?=
 =?gb2312?B?ZmpaZGJUdytpVDJwd2lsME5yTDVmRWVCK3hhOVlZNVZYMHczK3ZFTnFOUWY5?=
 =?gb2312?B?UGxYN25BYzl2VmR1dldPc3BpODF6cURwZlFKRVpYc00rYnFqemtvbG42MzJV?=
 =?gb2312?B?aFdoNXZLNkU1QjAyNDByclBGR2xLM0xHTHVxZExVYjRzMDYvc2trNjVRYk02?=
 =?gb2312?B?UVdudmdGZEpKbElpWDBjSzBGNmo3bGx1dnFEWkJPZnlrYkRRMTZ1VDZ0N0VH?=
 =?gb2312?B?M25BaHFXZUNTOUZub2dFYnZUNzFvYVg4dmJmUWV2c2Z1T2RKMmpWNEZlaGZ3?=
 =?gb2312?B?cmxKSnJxNFJsaXRRNEJaSEtvYXZybU4vVnAxWnJDVzZsTGJPZkNRcjFOUXht?=
 =?gb2312?B?dW1SMDZvUnFoY0tXSWk5bkZaaDJ5YWczU1RmLzVOdVlhNXBleHNBSmFjaGNa?=
 =?gb2312?B?TEFtWFphN1B4OExOOXRNWExZTjhYSkVyUG9YekpacVkreE1aOXJZeXVDVXhD?=
 =?gb2312?B?VVhqalRvbWQ5ZWJyOTJneFByclloc2dCdmVuYXNKR0ZEOGVzck54QkNxS08x?=
 =?gb2312?B?OXM0dk9QaUdtTjBSZUEwZjI1TFdNK25keHo3c2QrMGhOMlZQV2pSTGdmOFhh?=
 =?gb2312?B?RGdGaGJDMFJCeUZMbHZPdnQwSUFzaWs0YnVCZzFjaU9YUkhWOHl3NGFNQW5i?=
 =?gb2312?B?ZExjem96YmxqYXNaSUlaTkNla1BZaVJuclI3OGtXL2ZyUW9BNHNhRGFnWUxv?=
 =?gb2312?B?bXlkbUxYWFNya2NMN1FFelRGRHlYbUwrSkYrMUpzYXFlNGJncFlqNHZabjVU?=
 =?gb2312?B?WGpxcHRBZSswUXlBaCtmNlNPbG5Uem9vcHdoYUR5ZTc3UEZBRGlJb2kxMC9L?=
 =?gb2312?B?NThJaElob1N2cjhKU3NYUWZoNHoxMzV3V1BPRndJeE9lM1VDenVqc2ZUSUpI?=
 =?gb2312?B?M1ZZamh4WW45N1JBcmRQT3Z5a3FwVjJmNTRnRzJ3bmtiT3h1Qy9LSm9oNFBr?=
 =?gb2312?B?T1JyM2dVUXJLUFk1dENtVjZTVlJFanltblU5cTNLWE5lVWpqUkxTR0NnNnJC?=
 =?gb2312?B?U0RGT0JOcTlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(8096899003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0FvcjFVcElBRkpMcThrRXZLK3RUWlRaWllJWVloZ1dRUkgvSTkzb2NkUmxI?=
 =?gb2312?B?U1pTOFNpMmx5M2J6VThYYVBOMm1NNDdMdlR1d1ZZdm5Bb2k4eGVlTWpiYlla?=
 =?gb2312?B?QWtnMldOZVJjUjAvSjRJTUZvdzNuUTJuMnJ4eWlGSElhSnR1bjQrNHFpekhw?=
 =?gb2312?B?MTE0MWYzYUZ4eHIzejRLcm9IbUJXK1BacERKYVhGdWxabzdYNnBpUkVnUjZT?=
 =?gb2312?B?dElyK1ZVaVlwa2I2YVlsOVlWL3RiVFpIZFJKZ2IxMWJiZlZ5T1p5Z0w5OXp2?=
 =?gb2312?B?YVNsaUlvRWtCSEprS3dnOXgyU0JJRGJkWmYzMkl2R3Jxdit2bDdFWXRwc3Mw?=
 =?gb2312?B?MVZCVGVHb3I3VkdNYWxKVmZJYXVWeVR5VjhwNkhOdUpCb0RQdTZrb2FuZ1Bx?=
 =?gb2312?B?b3B5M2lZQmdzR1RWYkxJYjJGMmlJRWw2RFMxekJIRmJVZ1hTVC9rd0lJNjJN?=
 =?gb2312?B?Z2lTaDQ2VzU2dFhSMEt0dmdQS29xaitybWxFSlJlN3d6bVdhdjBkc2J5d0U4?=
 =?gb2312?B?YjIvbnN0R3dsK3ZMcjJBM2h5KzYzblpCcm5EN0ZBZmZhUXZtbWx3b1RZd1Zj?=
 =?gb2312?B?Vk13VDZIRFAxcDlQajlRQytPVHpJaldMd3NORldtT3ZreVJ0YUJjRGhxQm1r?=
 =?gb2312?B?QjJMZWZrMVRMZEx4R3E0ZnVmUFpuMWt0YTBKMzVGZW9kUUcvbXZVcXpTdnc0?=
 =?gb2312?B?cy9WNmdjUUM0MVlpRmdmbjJqOS9hSDNJeFZSK0J0TDZ4RnczdUFpQnA0VTB3?=
 =?gb2312?B?ZWUzaFJqVWFubkVWQWRtOEthSnpSdkg5aU5ZWEl3alRLYVhCVkNJT25XS21l?=
 =?gb2312?B?U1J3S3d4T1JUbmFNaWhCV1k2bjNXb2R3eE9YRjVPeThtbURQdzhMWWxpbnpx?=
 =?gb2312?B?dU5McWdESTYzY0tZYzczdW1ZZkVOV3hLYjh4cUtIa2dlckxNWUxkaE9PQTNk?=
 =?gb2312?B?clE0ZE5zK0haWGVLWThhSTNvQlg2RjdMNmVoenNxUmEyc25QTERSQVV0bXpo?=
 =?gb2312?B?VEZrcDFPT1lXK2N1S210cUxaYkdRemx5Z1ZseW12d2xzK0s1Vm1vTTY3bGVr?=
 =?gb2312?B?V01NUjVUOG11Z3gzTFluU3lKK3IwekFzVzB4c3duWXZ4MStjQzRCeUFsRW9B?=
 =?gb2312?B?S3RGMXV3SDF5T2E1SWRuamV6QmlEc2l0dVdUMUJ5U29mUEFhQm1RR2dkOVhI?=
 =?gb2312?B?VkJLWWcxMU9BSjJobjlHS0FVVmNQWnZaQjhIT0R2cld0K1RBeFlvMDk3ZllS?=
 =?gb2312?B?SlJMck1odmoxL2d4RkRwQlg3TDlsNm56dmgxR1NkUjZzV2t6WFhJUVZZd0lJ?=
 =?gb2312?B?UmFQR3FWYzI4UHN5cTA2RVU1Vm0wdElkUGtMWitQL0tLVFJWaThtL0tVbS9M?=
 =?gb2312?B?RGlxNEo4eUdxWE5hUytLZm5Nd0xaOEMxeHhlWkNWZzl3ejNVVXJ1MzRITUdR?=
 =?gb2312?B?SFluaVQ1RkgyWHZLWU5MaThZN01PZk1kL2VHaWRqT0lTc0NuZVFKcHExemt1?=
 =?gb2312?B?MVFNQ0hPUU45Tmg4b3pNT3h2Z1d5a1AxcFNXT05wT0pLbE4vTXY1dGhhOTVB?=
 =?gb2312?B?Q2FLbUpBR2RSK1ZPNHMxT2VOOGJBWDBjTEVwVmF4ZERFMUNjVEpGQkk5em1I?=
 =?gb2312?B?L05zOUxMbkV3a2ZvaTZhTXlwU1psVWdBbForZVhDYmVZRzlqTUNMSlZHRkIv?=
 =?gb2312?B?dHIwRHBway9Nd2tVUFcyM0diVWlybGR5RzdnVUdOcHNYQmVXdVhxazZDUmFx?=
 =?gb2312?B?ckZQM2EvVzJPL0lackRCUUVCWW85VENVQm12cnU3WWhEU3FyZlQ2Q2x1dUVE?=
 =?gb2312?B?QVFzdnY4Y2o3Yk5JUG1tNW5hMG81bVN3S2ZJc3pPOWR3cGhFdW5YOEVJbmRN?=
 =?gb2312?B?Wk0yeFVQL1V6cmd2d3RUNno3Q3lGOVJzUitnZDJETGppVXgyVFBVUkdIOGUv?=
 =?gb2312?B?ZEtwQjNqWDFmSFRGT0QwQXpnVFpmZlcvWVcxL1BzZFlaWEVNMks3ZStkeEY0?=
 =?gb2312?B?UDBFYytEWjFSS3M4RHpNVXEyZmRuNHdLdUdGSjREU1JHS2l0eXhhVGhtbm9B?=
 =?gb2312?B?TytMMzhZSGlIRUNPdVFQVHNYSUFjQVdWeVBYd00vdWRWalE3cTgrY1E3MkxI?=
 =?gb2312?B?R2R0cVo0ZWlxR2VZYVN0elhyRExFZGtBbjVXT3Rna1JrVE1obkdIRTc5V3VX?=
 =?gb2312?Q?wh+kOCp+7CacLK137ilFj4kcXqkD1lOhsiOn0SnCm5qY?=
Content-Type: multipart/alternative;
 boundary="_000_YT1PR01MB882655C97B77B9EF71CB482D8EFDAYT1PR01MB8826CANP_"
MIME-Version: 1.0
X-OriginatorOrg: polymtl.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08519687-394b-4f00-a673-08de162e581e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:29:03.5620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 253209e9-7731-40eb-96e1-6444a6823237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DUXA6SQ5d0iaJnyARvTJeA/7VkR4qT0l74zgZh0q4hajlY0lV+Za7EOFlT/CpOdNq7IsitbFkW+4WgaQEEn3gaJ53ftujP4/qpXI14U0r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9906
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

--_000_YT1PR01MB882655C97B77B9EF71CB482D8EFDAYT1PR01MB8826CANP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgZXZlcnlvbmUsDQpXZaGvcmUgcnVubmluZyBhIHNob3J0ICih1jcgbWluKSBzdXJ2ZXkgdG8g
bGVhcm4gaG93IGRldmVsb3BlcnMgYW5kIG9wZXJhdG9ycyBkZWJ1ZyBhbmQgb2JzZXJ2ZSBEUERL
LWJhc2VkIGFwcGxpY2F0aW9ucyBpbiByZWFsIGVudmlyb25tZW50cy4NClRoZSBzdHVkeSBpcyBh
IGpvaW50IGVmZm9ydCBiZXR3ZWVuIFBvbHl0ZWNobmlxdWUgTW9udHKopmFsLCBFcmljc3NvbiBD
YW5hZGEsIGFuZCBDaWVuYSwgZm9jdXNpbmcgb24gYWR2YW5jaW5nIG9wZW4tc291cmNlIG9ic2Vy
dmFiaWxpdHkgdG9vbGluZyBmb3IgRFBESyChqiBwYXJ0aWN1bGFybHkgdGhyb3VnaCBUcmFjZSBD
b21wYXNzIGFuYWx5c2VzLg0KU3VydmV5IGxpbms6IGh0dHBzOi8vZm9ybXMub2ZmaWNlLmNvbS9y
LzZ6UkFxeFdZS2oNClJlc3BvbnNlcyBhcmUgYW5vbnltb3VzLCBhbmQgc3VtbWFyaXplZCBpbnNp
Z2h0cyB3aWxsIGJlIHNoYXJlZCB3aXRoIHRoZSBjb21tdW5pdHkgYXQgdGhlIG5leHQgRFBESyBT
dW1taXQuDQpUaGFua3MgZm9yIHlvdXIgcGFydGljaXBhdGlvbiBhbmQgc3VwcG9ydCENCkJlc3Qs
DQpBZGVsIEJlbGtoaXJpDQpQb2x5dGVjaG5pcXVlIE1vbnRyqKZhbA0KYWRlbC0yLmJlbGtoaXJp
QHBvbHltdGwuY2ENCg0K

--_000_YT1PR01MB882655C97B77B9EF71CB482D8EFDAYT1PR01MB8826CANP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi everyone,</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
We=A1=AFre running a short (=A1=D67 min) survey to learn how developers and=
 operators debug and observe DPDK-based applications in real environments.<=
/div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The study is a joint effort between <b>Polytechnique Montr=A8=A6al, Ericsso=
n Canada, and Ciena</b>, focusing on advancing open-source observability to=
oling for DPDK =A1=AA particularly through
<b>Trace Compass</b>&nbsp;analyses.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>Survey link:</b>&nbsp;<a style=3D"margin: 0px;" data-linkindex=3D"0" dat=
a-auth=3D"NotApplicable" data-end=3D"1708" data-start=3D"1630" rel=3D"noope=
ner noreferrer" title=3D"https://forms.office.com/r/6zRAqxWYKj" class=3D"x_=
decorated-link x_OWAAutoLink" id=3D"OWA049e71b5-4b00-3792-219e-8bb652229485=
" target=3D"_blank" href=3D"https://forms.office.com/r/6zRAqxWYKj">https://=
forms.office.com/r/6zRAqxWYKj</a></div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Responses are anonymous, and summarized insights will be shared with the co=
mmunity at the next DPDK Summit.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks for your participation and support!</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif, serif, EmojiFont; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best,<br>
<b>Adel Belkhiri</b><br>
Polytechnique Montr=A8=A6al<br>
adel-2.belkhiri@polymtl.ca</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_YT1PR01MB882655C97B77B9EF71CB482D8EFDAYT1PR01MB8826CANP_--
