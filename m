Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ECC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 10:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2973B402AE;
	Wed,  9 Jul 2025 12:44:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 622AA4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 12:44:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56983eTX018284;
 Wed, 9 Jul 2025 03:44:02 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47smjf8c7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 03:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKOQ2LMAlBILcjTrUWafCcMidAV8t4Hh8qZBYnGl9C1K0Otrl6aSpShFvNQCMQaXcPVblu19FO9P8U6iCzQQQ9ICJU1Aj3kO7a4GRfIuxlyjPS9tFElWsWMbpsyroMnsETGbp49Tmpk7vYsVCTvQ25K3VPIE+Koxeq5xZG40brkvZ8UMPLHdUxCqVwdaFg4cCy4SrNh5zQPz4K+876CXZwzMcRJGH9scFdvWcDa9Vuz9Yqw4dMQF1nFnYpl88qCzXAoCpwQQzrUF1Qy8Jo0rIrkPC2FCpO2T+dU1yGwn8z3kzd1UBjLd4FRHvdX7vX8BkLA+CHV/4K/MbhSAY7MfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q6rp4U8KMZ6vcOBqlWDgPnOPI0NaLkV0shVn/Rp7F8=;
 b=y+Yamms9US+ka7whEMEShbg7XUspz3SMavNmBAD8r6LncwbviNRKbMIC3DcVaYf2E0DHhbzFHnLZaiadFmkpcNIPTpnTIiHlJcC46hgmZHtyemDbE1PCCHyi1gxhEjN9U6fJW+HCi5FuwL8lg+egGO0PxNUhRCGZnmNz2AghLfZVcXBPG0lqzab0y43jnZ9GO6X+zHwio+8e0JPJJGPDVCycjObCT/o24ocSVYIqgIC/4EIeu3qylJ7yTO6WLdbTHoWuy9/5p+RLOozj7UaM7H3FRjhRfH0yqxa5PdurICOCObiCh8Goxil6lVaERN6Q2hkMAAzpqKj1QdcyqcVgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q6rp4U8KMZ6vcOBqlWDgPnOPI0NaLkV0shVn/Rp7F8=;
 b=Kv+8mVutGfNpdD/aoMQl6eNnCDAhJQywqDiPHtWGRy29kniANroVcBhrw/ffULBgbBF8ByuCyNXi4ydemSFaHtXDLhvwWdkkfiDIwvmiYSeoNL/WJwjZudeo3PxyCXaaya1Z6N2NKbBANEH1raZDdAKTiFY6zPCRhJ+52lQu6Jg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB3906.namprd18.prod.outlook.com (2603:10b6:5:34c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 10:43:58 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:43:58 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Topic: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Index: AQHb8J1P4jFxhOyRyEG73mK90XdgSrQpYhVQgAAmAYCAAAgMAIAABhQAgAAFIWA=
Date: Wed, 9 Jul 2025 10:43:58 +0000
Message-ID: <CO6PR18MB44843A3421C48F6DC67D4A09D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250709064701.100676-1-zhangfei.gao@linaro.org>
 <20250709064701.100676-2-zhangfei.gao@linaro.org>
 <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9H7+WTpMbU_xQXKAzrNV4yucxe=rswdpXEapY4bsnfXLQ@mail.gmail.com>
 <CO6PR18MB44843776C190BA6E914BF5C8D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9E3aGaFCtUGvLH0R1qf3yuM6VWvxQ7KDG+n+D=H+iPrBA@mail.gmail.com>
In-Reply-To: <CABQgh9E3aGaFCtUGvLH0R1qf3yuM6VWvxQ7KDG+n+D=H+iPrBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB3906:EE_
x-ms-office365-filtering-correlation-id: 4481bfe7-9dfe-42c8-bed4-08ddbed582bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?clRldjBkbkhjeTRWK1oxdExnWnc3YkdHZVNPaDVseWp3cnZBWExoZDExM3V0?=
 =?utf-8?B?MTZXRDg4aGZwVW9pckUzS1FXV2FYRngwLytXN3VNQ3A3ZmZFeTFtdExObUUr?=
 =?utf-8?B?L2o4MWp4UkNvNTVzVzRmcXJRY0sxYzN2MjMvakZHT25vdStLaitmTEgxL2pv?=
 =?utf-8?B?S3lud3Q2QzNTa016azlidEJpNzBuUEVvT1RYcEF6MDhzWVRpQkl4ajVvQjlS?=
 =?utf-8?B?aWRPc1pDeFJVNXZVQ0w0aEI4TmhiNlY1U3JQS01LZHdELzhpUDNiaHVKZU1z?=
 =?utf-8?B?NkFjaW9EZXd3R2xNV2U3aWY0SzA3aVVUT2tDUzVNeDZrQi9QdnZFRWlKUUpJ?=
 =?utf-8?B?WFBTTTJITExueVFMTHRFYUtVY1dKOElvNVZxclNpNjkvTUZ5d3JJT0JpWG9i?=
 =?utf-8?B?TW5QV3dyZlUxb1dHbmhWRlJkOUpDTXI0eFdhRmxCM3dhblRvaXNJZnVNWXlk?=
 =?utf-8?B?aTNlUEF0ODBiMnQvYnhINGhmMHduRWYxa2s1OUorRDMwNUdLbEIzcGY3SU8z?=
 =?utf-8?B?dnh3NXBNTjFoN0FzKzVzeFNsZmZqN2pMZXM2WUlMMUxhVVBBNEYxV0phNEdW?=
 =?utf-8?B?a2M3emxsbVA0VTBsblFZNC9sN2FienlZWXpsN21Bak1uOTFjR092WHNnUzc1?=
 =?utf-8?B?bzhJZ3R6V2hDYlZkSnY1ekdDbmRDMTd1VGRaaWlRY2NKcVFUVTlpaEhYZG1M?=
 =?utf-8?B?bVNpKzI4c1U1RFlZa0JldDhvMU44YnUvc2xkaThjSkNYT3FtSDcxUFlaMVZz?=
 =?utf-8?B?VUZ4bndXbXBZQjFvNk51Rk85RHhWWndMWGw2aHYvc3l3enRjT0hWVGlzTm1C?=
 =?utf-8?B?ZHBMQ25Za1ZGVU1aSE9EWUhmY0FPUmw2N3oxb05qck4zR09TUGUvU29yNDFT?=
 =?utf-8?B?Q0Y5b1BydTZEWm8xQ0tZSzkyRjRzdk44U251SUdYL3FJSUgwaC9pQzNhcnBM?=
 =?utf-8?B?WFQ3WVhhczBzVEJrVEVuMWp2cUVETzJNVkJjaHRQWWY3dGx2cjVXWjl1R0NH?=
 =?utf-8?B?ZTFab1JMdjJrWTdXTU5JeW9lSDdXcHk2MEgzU1pZemZXSzhCWXR2M0l4eFFn?=
 =?utf-8?B?S2dYYzVWL2t3N0xWUG1VRUFsOGxwV016QTdLZHIyMi9JbzY3OS9kbHAxZDUy?=
 =?utf-8?B?MUZZcTBsckdHNFIyRXVCSkJTVFo1Vm9GbEVQZnJVNFc5VnhYMFd1amNYRnZZ?=
 =?utf-8?B?OTVyTlZSMmpQNUw2T2tEa0E4QlJreUFQNG1mbG1mWkpZVzFoKzRLNS95OEFt?=
 =?utf-8?B?Ky8wa1BhLzNBQTFOVVBic0ZpQnJDb2kvOW9tQTNlNkFRa3Y4S3RSUzdCejRt?=
 =?utf-8?B?dUt2VXBkK3NDVzZ4THhOZXFJdlMxQWFPajFtRFllN3didmxlRUx6RmNPcnA3?=
 =?utf-8?B?OFQzTWE1b0tQZW40NEhuczg2OHFxeUJjOCswZzFWTTMyb0t6T2ZaV2tCR1NM?=
 =?utf-8?B?VC82MlIzRElIYnJINXBFWGo5cjF5ZmRyUHJqcS9XNWxDdzRSUFVjMENyZFl2?=
 =?utf-8?B?SzZZczVoYW9ZeXF3bjBtcDBsRC8rby80WU9UakNrOWNZOFVzaWFxd3ZUeUJJ?=
 =?utf-8?B?UlhEekdiVXdBTTZtTlJ1Q1dqNytMb01IdjBFMHZQVEMxejBLUVg5OEdRT1RH?=
 =?utf-8?B?S2c2YUdaQklYR1Y3a1ZuNGtJenpEQVBGekZqUXBwcG9ZWmFZa0pWWUg1U0sw?=
 =?utf-8?B?Z1RIdmtSWk5Pa3ZJR3dZUmpMUWFYZjAyN0k4U2pRcS9mNGRJVUp2RCsxSkpP?=
 =?utf-8?B?RkYvZGVHNGZHT3UrNExKYlVCZ0E3Vm5JTTZLU1pyNEhDZ04veVVrSC9kcTVD?=
 =?utf-8?B?M2hYT0Qrcmc0SjNnNVFRWVl1NVBUZC9FVDNMV3lSMi90Z2JWRkJHMjlBdVpp?=
 =?utf-8?B?MXZFVmRnSmZmcnpCUGQyQmFybFZ1YUF0ZE5YaWgybmJQZW5lb3crYUhWTENK?=
 =?utf-8?Q?OMSnThx33zA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFkvNThhbzZnTmdFOTRZcktkUnBtTXpIQ2E1clZpV2c5YW1KMUxFYXRQdjRk?=
 =?utf-8?B?aFprbXd6aGRqcnVFbi84Zm9udjhwNUV2dE9KOEFWV1NwaS9Yd3QxTFpRL1dE?=
 =?utf-8?B?SkVHeG41bWhnM2ZjU3pneTNEbHRPTXd0bzhWTGpqVXdjS3d5TGh2ZGlrYjBQ?=
 =?utf-8?B?djNNZWl5WjlBMmhkcVUyeUJ3RkVoSEQybXk1RDJzcGF3N3lmdlhPR0c4eGs4?=
 =?utf-8?B?WFFQZndGNjJ0R3pHTVRYWHRRbklKbXEzSU9kWmRBOHdPTExXZHdYNTdsSTFD?=
 =?utf-8?B?VEFkYmFET2NXdzU0SEMvSjZkUVgzK1ZDN29GWldPbnpZelRINDlNR0JwWWo5?=
 =?utf-8?B?NjQ5WWd0L2FLODBPTDBYeUlvTnh6Y3YxTCtpMmRzMDNpV0NaZjBxTmVNMU85?=
 =?utf-8?B?WitPWTlGRnprYSt1S01nMHMwODJCdzY3d3lGR080UDNGZXBKenc2dzlpV0Rw?=
 =?utf-8?B?VWNFdHdEUmxaNXh1STJOTWpxOW85RE9sbnhSYVdYS2FWMnlhNWZYbG1RK1dM?=
 =?utf-8?B?Q3g3VkRVVHlPYWRRdVU0c2RJWGhRT2MwSEIwTXpaakJXMDBtckpUZjNtRnl2?=
 =?utf-8?B?NVViVm11OUJKRkhaTld3dW1YR1V5d054WkdmRXkweU80TUo4SmhBeHBNWWll?=
 =?utf-8?B?TkNkMW9uTlNvWlA1aDkxWjQ2RUJJWkFMUk9CSHpMdW02dGYxeFlPamxBSkVj?=
 =?utf-8?B?YXJDTmsyelVzZFZaM3RJT09CWG9rblRKTUI1aWNmaWdPQ1VtTXE4ckRIcmdl?=
 =?utf-8?B?NUlmcFNTbTRYUEpUaHlqd0Q1UWM0MEJzWlZTTnVIYm4xcXdwM0lDcHRxTDZG?=
 =?utf-8?B?bUd5TXpScThBMDZYR3ZxWWhHbWJTL3ZqMTByWGRiblU3ZmY4bTM2QUZ6NC9j?=
 =?utf-8?B?TnVZZ3g1L2x4eXhGbUxva3FQdEdnQU1aQlFFOEJVQVRTNndyY3F5anA1aUNG?=
 =?utf-8?B?cWRXSitwRXd1VTZFR1ZkMjA2aHF2WUllNndCZGtrOU1HOGR0TVE0VXQ4ZFFn?=
 =?utf-8?B?QVRGcHlPRmkyNlJjZmQ3TjNPS1FvRTEvaWFpbnpDV2dtTHdQTDQzN3gwclhL?=
 =?utf-8?B?dU1FSSs0bTU1VVlId3A1cmRKaVF3bnZ4SkdzTlZxdTJQTDFqa2dwa0pSU0Zv?=
 =?utf-8?B?eU5VSndaS2x0MEdveGh0ZFlGejBjczRTY1ZhVFFhb3JoWVRmUVRNS1IvVXZj?=
 =?utf-8?B?MC8zOFV2VEtYM1pHNUFueHBqZmxieXJFeStpQSsrNTRNZWsrTmppWGZwaTYr?=
 =?utf-8?B?TllickVmWTZwUnVyN2d5VkZoZ1pRYnNWT3ZhbzZJRlFYajBxL1VGbCt2U1g0?=
 =?utf-8?B?ZmN0cVBIY01BOUdNNFNjbFlVVFJOTDVPTU5GcUgzSDNLRXF3KzJjRzN6UW0w?=
 =?utf-8?B?eC9ua1ZxYVdMVDdpd2tjR29SY25DSU9ZcVdEemNwZGs0ZW1PdU0rOGZUZUJ3?=
 =?utf-8?B?QjJTUitqbGltS0cycDdESnlIOEdmNUwwM1pvRjNwdVdlcmJudE51QjJXWTRn?=
 =?utf-8?B?SjgyRFFLMUNwNm1meXlSalBNbm1pY2x5OFcxMkFLV0haeExsZEpjR0xUTy9H?=
 =?utf-8?B?RjJFcWNTUTRrSER4VE9tUHIxb2lPL2FUTlNucEJPMEtqWFhHR2s2aTZDOEZH?=
 =?utf-8?B?QllXaHoyS3ZwTFByTEcwb3AxelVUMlEzWUQ3eFdHZEw1bkI4WUEyVkZjSTZ6?=
 =?utf-8?B?K1JZUkUrcEs5ZVdObERMVXhJZUZ0V0tJMmpwYVhPNnUwQUVoc1RybDdkUklP?=
 =?utf-8?B?UjVkaHQwZkFRZnN3VFBwKyt2MUZlVjRuRHZuenM2cXo1eEZ0YzFYRHNwMG42?=
 =?utf-8?B?NWtDSUIyTWp5NkM2eVFkbmpGNkFxSWxvSlpZM2xtdU1yQlZSNmVTcjY3Z21W?=
 =?utf-8?B?WDg0eDNGdW92WTV3MVBFT0pUYi9vcXllVjlTd04rWlN3KzVQMlBlSVJjbHB2?=
 =?utf-8?B?UjdhZnlNNkc4Z0FsS294bUhCdklONVUzTmZLL1JVdFJ6RUFqSmJQemltYXJx?=
 =?utf-8?B?T2V1UXF2dlp2eTZGdThsYm9zQS9BMTIzM0d4b09qaU12cCtNT3hQSlBFbnU0?=
 =?utf-8?B?dmlLVjFQWEt6QVpMR29iMmtMRjczT3VCQXdYRU1KRWJ5bXM1WDVjanR0SGoz?=
 =?utf-8?Q?6kpwpi98pHUeZA/FMd7ZGf/b1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4481bfe7-9dfe-42c8-bed4-08ddbed582bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 10:43:58.7198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+VDeUP/b3bj9JIQ4KzEXl7l/op4bhws5W4rP42nWpxE50nsDVcT3IpBMT+qNnYSjPNvyEtw6jFDDp9ECPZjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3906
X-Proofpoint-ORIG-GUID: acrUAGPMIhLIkqpIl4D8TnCMwSj5uVSm
X-Proofpoint-GUID: acrUAGPMIhLIkqpIl4D8TnCMwSj5uVSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA5NiBTYWx0ZWRfX8+ueGlrSACeb
 LnwX4iK4yy1beIaLlaXoafq0fcaybsWuMj+H+NjIP4rgKtRu6xhyIRa2UC3emRHADfDneo2nGjp
 bcQ5M1nipYxZXV/gAPS4PUgneJRV4prhAvelCpf8WPkeol5Ecamzsu0D/2h8MEaa+CvQ5tWcpc8
 +4p1X7+kP+NdExzwDNF0QuhyENWiYaXCBipochDeYaBrcxoLNVSD1mHlQltfSgyZkIkvV89BHGf
 lBwIAq2A0yn/uVyBMvPtbSksSnHWYRvZIoVgxRUEBFF8iXDBQYG/s/YS8plkkz4Ss6Nrboccj3B
 UTyEbpFgUOizyDAfEOdhncx1y8GJDpjdzU2uPss9hMwUgt02xwRMCBhWAjwJVKY937SVjKjUqId
 i3nSTjlJYDa9RafddVDo8aRh3WOe/VvD8hvoZdCdNFYuc3dH6hP6yW93ZgQsgvj+/x1NMxf4
X-Authority-Analysis: v=2.4 cv=TsnmhCXh c=1 sm=1 tr=0 ts=686e47f2 cx=c_pps
 a=3+xmILRzgUfFm8gMNKQ0sw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8
 a=KKAkSRfTAAAA:8 a=PZrs-IVHSxQQXZaPY_4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
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

PiBPbiBXZWQsIDkgSnVsIDIwMjUgYXQgMTg6MDMsIEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVs
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBXZWQsIDkgSnVsIDIwMjUgYXQgMTU6MTksIEFr
aGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+
IFRvIGdldCBiZXR0ZXIgcGVyZm9ybWFuY2UsIHVzaW5nIGFzeW5jIG1vZGUgdG8gcmVwbGFjZSBz
eW5jIG1vZGUNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdh
byA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRv
Yy9ndWlkZXMvY29tcHJlc3NkZXZzL3VhZGsucnN0ICAgICAgICAgICAgICB8IDE1ICsrKw0KPiA+
ID4gPiA+ICBkcml2ZXJzL2NvbXByZXNzL3VhZGsvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAg
NCArLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2NvbXByZXNzL3VhZGsvdWFka19jb21wcmVzc19wbWQu
YyAgICAgfCA5NCArKysrKysrKysrKysrKy0tDQo+IC0tLQ0KPiA+ID4gPiA+ICAuLi4vY29tcHJl
c3MvdWFkay91YWRrX2NvbXByZXNzX3BtZF9wcml2YXRlLmggfCAgMiArLQ0KPiA+ID4gPiA+ICA0
IGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3VhZGsu
cnN0DQo+ID4gPiA+ID4gYi9kb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy91YWRrLnJzdA0KPiA+ID4g
PiA+IGluZGV4IGEyOTA0M2UwYzAuLjg4MTJmZDE4MGEgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEv
ZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gPiA+ID4gPiArKysgYi9kb2MvZ3Vp
ZGVzL2NvbXByZXNzZGV2cy91YWRrLnJzdA0KPiA+ID4gPiA+IEBAIC05NiwzICs5NiwxOCBAQCBU
ZXN0IHN0ZXBzDQo+ID4gPiA+ID4gICAgICAgc3VkbyBkcGRrLXRlc3QgLS12ZGV2PWNvbXByZXNz
X3VhZGsNCj4gPiA+ID4gPiAgICAgICBSVEU+PmNvbXByZXNzZGV2X2F1dG90ZXN0DQo+ID4gPiA+
ID4gICAgICAgUlRFPj5xdWl0DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
QXMgYSByZWZlcmVuY2UsIHRoZSBmb2xsb3dpbmcgdGFibGUgc2hvd3MgYSBtYXBwaW5nIGJldHdl
ZW4gdGhlIHBhc3QNCj4gRFBESw0KPiA+ID4gPiA+IHZlcnNpb25zDQo+ID4gPiA+ID4gK2FuZCB0
aGUgVUFESyBsaWJyYXJ5IHZlcnNpb24gc3VwcG9ydGVkIGJ5IHRoZW06DQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsuLiBfdGFibGVfdWFka19jb21wcmVzc19wbWRfdmVyc2lvbnM6DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsuLiB0YWJsZTo6IERQREsgYW5kIGV4dGVybmFsIFVBREsgbGlicmFy
eSB2ZXJzaW9uIGNvbXBhdGliaWxpdHkNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgID09PT09
PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiA+ID4gKyAgIERQ
REsgdmVyc2lvbiAgICBVQURLIGxpYnJhcnkgdmVyc2lvbg0KPiA+ID4gPiA+ICsgICA9PT09PT09
PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID4gPiA+ICsgICAyNC4w
NyAtIDI1LjAzICAgMi40ICAtIDIuOA0KPiA+ID4gPiA+ICsgICAyNS4wNysgICAgICAgICAgMi45
LjENCj4gPiA+ID4gPiArICAgPT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb21wcmVzcy91YWRrL21lc29u
LmJ1aWxkDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2NvbXByZXNzL3VhZGsvbWVzb24uYnVpbGQNCj4g
PiA+ID4gPiBpbmRleCAzNDExM2NkMDhjLi4zMmNhZGQwMmVhIDEwMDY0NA0KPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZA0KPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZA0KPiA+ID4gPiA+IEBAIC0xMyw3ICsxMyw3
IEBAIHNvdXJjZXMgPSBmaWxlcygNCj4gPiA+ID4gPiAgKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
IGRlcHMgKz0gJ2J1c192ZGV2Jw0KPiA+ID4gPiA+IC1kZXAgPSBkZXBlbmRlbmN5KCdsaWJ3ZF9j
b21wJywgcmVxdWlyZWQ6IGZhbHNlLCBtZXRob2Q6ICdwa2ctY29uZmlnJykNCj4gPiA+ID4gPiAr
ZGVwID0gZGVwZW5kZW5jeSgnbGlid2RfY29tcCcsIHZlcnNpb246ICc+PTIuOS4xJywgcmVxdWly
ZWQ6IGZhbHNlLA0KPiBtZXRob2Q6DQo+ID4gPiA+ID4gJ3BrZy1jb25maWcnKQ0KPiA+ID4gPiA+
ICBpZiBub3QgZGVwLmZvdW5kKCkNCj4gPiA+ID4gPiAgICAgIGJ1aWxkID0gZmFsc2UNCj4gPiA+
ID4gPiAgICAgIHJlYXNvbiA9ICdtaXNzaW5nIGRlcGVuZGVuY3ksICJsaWJ3ZF9jb21wIicNCj4g
PiA+ID4gPiBAQCAtMjEsNyArMjEsNyBAQCBlbHNlDQo+ID4gPiA+ID4gICAgICBleHRfZGVwcyAr
PSBkZXANCj4gPiA+ID4gPiAgZW5kaWYNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC1kZXAgPSBkZXBl
bmRlbmN5KCdsaWJ3ZCcsIHJlcXVpcmVkOiBmYWxzZSwgbWV0aG9kOiAncGtnLWNvbmZpZycpDQo+
ID4gPiA+ID4gK2RlcCA9IGRlcGVuZGVuY3koJ2xpYndkJywgdmVyc2lvbjogJz49Mi45LjEnLCBy
ZXF1aXJlZDogZmFsc2UsIG1ldGhvZDoNCj4gJ3BrZy0NCj4gPiA+ID4gPiBjb25maWcnKQ0KPiA+
ID4gPiA+ICBpZiBub3QgZGVwLmZvdW5kKCkNCj4gPiA+ID4gPiAgICAgIGJ1aWxkID0gZmFsc2UN
Cj4gPiA+ID4gPiAgICAgIHJlYXNvbiA9ICdtaXNzaW5nIGRlcGVuZGVuY3ksICJsaWJ3ZCInDQo+
ID4gPiA+DQo+ID4gPiA+IEkgYW0gc2VlaW5nIHRoaXMgbm93DQo+ID4gPiA+IERlcGVuZGVuY3kg
bGlid2RfY29tcCBmb3VuZDogTk8uIEZvdW5kIDIuOSBidXQgbmVlZDogJz49Mi45LjEnDQo+ID4g
Pg0KPiA+ID4gSGksIEFraGlsDQo+ID4gPg0KPiA+ID4gVGhlIG1hc3RlciBoYXMgbWVyZ2VkIGEg
cmVsZWFzZSBwYXRjaCA4MGFkZWZhIHRoaXMgYWZ0ZXJub29uDQo+ID4gPiBodHRwczovL3VybGRl
ZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+ID4gPGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0gID4+ID4NCj4gM0FfX2dpdGh1Yi5j
b21fTGluYXJvX3VhZGtfY29tbWl0c19tYXN0ZXJfJmQ9RHdJQmFRJmM9bktqV2VjMmI2UjBtDQo+
ID4gPg0KPiBPeVBhejd4dGZRJnI9RG5MN1NpMndsX1BSd3BaOVRXZXkzZXU2OGdCem43RGtQd3Vx
aGQ2V055byZtPXp1X2xDDQo+ID4gPg0KPiAyV0lWNktxQmhTYTE1U093NHNZdkk2VzNTcm9tQ3lf
Wl9BMTltbGlGbWZieDZmUXNpOFNWbWRZN09WdiZzPW9Zcw0KPiA+ID4gU1ZEYm9wY3I1YVJOVzZf
WjM2SnVwNmNjYktUdmUzVjFHcDZqVXRQbyZlPQ0KPiA+ID4gQW5kIHRoZSBodHRwczovL3VybGRl
ZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+ID4gPGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0gID4+ID4NCj4gM0FfX2dpdGh1Yi5j
b21fTGluYXJvX3VhZGtfdHJlZV92Mi45LjEmZD1Ed0lCYVEmYz1uS2pXZWMyYjZSMG1PeVBheg0K
PiA+ID4NCj4gN3h0ZlEmcj1Ebkw3U2kyd2xfUFJ3cFo5VFdleTNldTY4Z0J6bjdEa1B3dXFoZDZX
TnlvJm09enVfbEMyV0lWDQo+ID4gPg0KPiA2S3FCaFNhMTVTT3c0c1l2STZXM1Nyb21DeV9aX0Ex
OW1saUZtZmJ4NmZRc2k4U1ZtZFk3T1Z2JnM9WXQwQThGOA0KPiA+ID4gbzk2cGxFQXN5NFZmbUVM
dkRrakdQd2gzWWtjcGNYeld0YmFZJmU9IGhhcyB1cGRhdGVkIHRvIHRoZQ0KPiA+ID4gcmVsZWFz
ZSAyLjkuMQ0KPiA+ID4NCj4gPiA+IFdvdWxkIHlvdSBtaW5kIHJlLWNoZWNrLg0KPiA+ID4NCj4g
PiBTdGlsbCBnZXR0aW5nIHRoaXMNCj4gPg0KPiA+IERlcGVuZGVuY3kgbGlid2RfY29tcCBmb3Vu
ZDogWUVTIDIuOS4xIChjYWNoZWQpDQo+ID4gRGVwZW5kZW5jeSBsaWJ3ZCBmb3VuZDogTk8gZm91
bmQgMi45IGJ1dCBuZWVkOiAnPj0yLjkuMScgKGNhY2hlZCkNCj4gDQo+IGl0IG1heSBiZSBiZWNh
dXNlIHdlIHJldC10YWcgdjIuOS4xIHRvIHRoZSA4MGFkZWZhLCByZW1vdmluZyB0aGUgb2xkDQo+
IHRhZyBtYXkgYmUgcmVxdWlyZWQuDQo+IA0KPiBnaXQgdGFnIC1kIHYyLjkuMQ0KPiBEZWxldGVk
IHRhZyAndjIuOS4xJyAod2FzIDk5OWY3OWIpDQo+IA0KPiBnaXQgZmV0Y2ggb3JpZ2luDQo+IEZy
b20gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAz
QV9fZ2l0aHViLmNvbV9MaW5hcm9fdWFkayZkPUR3SUJhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0
ZlEmcj1EbkwNCj4gN1NpMndsX1BSd3BaOVRXZXkzZXU2OGdCem43RGtQd3VxaGQ2V055byZtPUd4
NTN0dWZ3SHZaN2RCaFp1ak9qDQo+IFV2LUZpd2ZPTURYNWVibEhIc0ljS0ZDSzBzckpKQTFJYlBx
aS0NCj4gTnZDMGhEUCZzPU1Xdlh0SWFiUloyVzdNb2t4WjlkRnpNY2dXMVpKdm44SG5xQlJwb3Fr
ZlkmZT0NCj4gICogW25ldyB0YWddICAgICAgICAgdjIuOS4xICAgICAtPiB2Mi45LjENCj4gDQo+
IA0KPiBnaXQgZmV0Y2ggb3JpZ2luDQo+IGdpdCBjaGVja291dCAtYiAyLjkuMSB2Mi45LjENCj4g
Z2l0IGxvZyAtLW9uZWxpbmUNCj4gODBhZGVmYSBNZXJnZSBwdWxsIHJlcXVlc3QgIzY4MSBmcm9t
IGdhb3poYW5nZmVpL3JlbC0yLjkuMQ0KPiAwZjc1ZDBmIHVhZGs6IHJlbGVhc2UgMi45LjENCj4g
NTE5MTVmZiBNZXJnZSBwdWxsIHJlcXVlc3QgIzY4MCBmcm9tIGdhb3poYW5nZmVpL2NoZWNrX3g4
Ng0KPiAzNGRmOGNmIHVhZGs6IGNoZWNrIHdoZXRoZXIgaG9zdCBjcHUgaXMgYWFyY2g2NA0KPiBk
NTkzNTU0IHVhZGs6IGZpeCB0aGUgY29tcGlsYXRpb24gZXJyb3Igb24geDg2DQo+IA0KPiBzdWRv
IHJtIC91c3IvbG9jYWwvbGliL2xpYndkKg0KPiANCj4gLi9jbGVhbnVwLnNoOw0KPiAuL2F1dG9n
ZW4uc2g7DQo+IC4vY29uZmlndXJlDQo+IG1ha2UgLWoxMjgNCj4gc3VkbyBtYWtlIGluc3RhbGwN
Cj4gDQo+ICBscyAubGlicy8NCg0KQ2xlYW4gYnVpbGQgd29ya2VkLg0KVGhhbmtzLg0KU2VyaWVz
IEFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQo=
