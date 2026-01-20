Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AECD2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 08:13:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E787E402C3;
	Tue, 20 Jan 2026 09:13:19 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by mails.dpdk.org (Postfix) with ESMTP id 6DAC140273;
 Tue, 20 Jan 2026 09:13:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0qrAQZWIWiCJxKYUHTdVwgD8jGOj6SA0/LEP9Ii0FporSNc41kjG1Ncf4ghfiwyh1gwXaG6OS9Z4bIQYdeIaJiJxzHx0etAXt1CYbpL/Lv3TSRvSORwRZIWctyQL+RGK+7U2XuS8G9Zv+opoXCg5dPw1CrjQuxgOvxoUFhvLwo3WfPIEbQpTVzaMiTsprLvVJQeJ8G0/CfJoagbTTEzCehedTpVV/qMk16ON2raRHFZyWp0WV/OPh9EnTY21hyO/BG8FEThQMATzROxCM93rvBsfrwfqOoJiU1l3Vc6F0ScJGu13ZjFqJ+RKRhC7FD+BWAHPcm3QLro0mpb+69FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irGpkKz0WwpoNOgyjYg7jJ6FnjFgLEQbiuUtkzsjMkc=;
 b=U5gP1BF8V2qKYdW1QX//WN4pIv5WWlDzb1F/S9ZVycLDxi1AIwLfapkctgvYDJ8NI83CW2X03L3bq1XFvhy0IMJBYR4x5GHn8fPrXZcTki2IyPTXIzMOZ7gtEt6HAHqRKBUJIIAQbpLRcjHq00PYJhDppaMgygMZMpEEgpJX5keUe2E2dbFkpx+yfVvR2mlR5sMO/Je451DeB2UEo4JUj7zIjnVKiIkkhSjCTRwG2sg1Qsp6C9QaU9U8nSAlBhWlbGNMlzL0vwFHn+6mV9FmYCoJpPubR7x60iUpfJyXkr8ibVEw1E7ZtKbf0zhLWTWGVECCKEH1uIw24VVISsCfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irGpkKz0WwpoNOgyjYg7jJ6FnjFgLEQbiuUtkzsjMkc=;
 b=pOjfE6dEHkgvhPvcJTAhGm85/JTsQDOzGOZrc7onxOmVuSH9Vq7EuElkx0FjooaJXXVn5YtuyqUUhf16JKV8AwQgJuzFciTE72a5rvxuEpTqncp5XQ0MpZC0foQS2tnOd/oDlCtQT5Z/dLolcJlIEG5jcm42DMS90xSgCYIV6gDfsDV6pk7c442kaovaBw42e1QiuY/KL78AUuvC2sp/qePDY6rDT28LtiRCoPqZ4N5/Lfmy3z43v/U9U0yZaPNj0gM4r34Kv95REYKtePW+36/0kkJmKNZ6jZA5xDgJ4lAg1BFqFGSo3Pcv0zHDejLPVAFFGJawZDS3R9t0cNp28g==
Received: from MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:13:14 +0000
Received: from MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e]) by MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::ac9f:a033:789b:d45e%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:13:14 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Ali Alnubani <alialnu@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, "benjamin.walker@intel.com"
 <benjamin.walker@intel.com>, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan Darawsheh
 <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.6 patches review and test
Thread-Topic: 23.11.6 patches review and test
Thread-Index: AQHcf7xqN9ktUqPFgkWmF92WSgQ86bVaxisAgAADg0A=
Date: Tue, 20 Jan 2026 08:13:14 +0000
Message-ID: <MW4PR12MB7484553EE2B347E82122A54ABF89A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20260107100017.158232-1-shperetz@nvidia.com>
 <e19c844b-122d-487c-9752-5c2faffc140b@nvidia.com>
In-Reply-To: <e19c844b-122d-487c-9752-5c2faffc140b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7484:EE_|PH7PR12MB5805:EE_
x-ms-office365-filtering-correlation-id: ed3c2d5f-9de5-4ed1-19cd-08de57fbc255
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dXRhT3BMeWlxN1hTRGgrWnRuaVpLdGJENVJBSDBrbXBUUUVKdmRKeXp0U2g3?=
 =?utf-8?B?RHdPVDBzSW44ZFJIY0p6ck0wbkZMNk1MdFpCdVlTdFJzM0tLNEtVaGhuK3Vo?=
 =?utf-8?B?Mm9ubFpDYXhaMktSR0Z3U3ROOUorSVRyV2hTbUpickFIRVlLOGYxWHc0VFEy?=
 =?utf-8?B?cWRPeG1keTJ2c2Vpc3lqWWtGZ2ZIUWJZOUdIR0xMd3JrQUx0MDcwV3dKOWNS?=
 =?utf-8?B?WllUS3RzSVUxZ3paR2tCL0xIa2t4QVNWeW8rWWpVSEV0YjkxRjlKZ3g5YThw?=
 =?utf-8?B?QVZYYUYyc3pQUWQ5SnBWWVRqYWV6QnJrZkdjSmRMbkVxVlVqYWlPZVFDb2Fw?=
 =?utf-8?B?WmJsZHFiMExnNVNyYlNEeUp2NkxnSUtUSk1PVUpsdStGVE1mZGM2K2hnWk5B?=
 =?utf-8?B?ZVJXS3RWTnA5akU0R0VpVC9RWmtoMFBpTUYvUnNHZlMrNEZJejgydDI2TE90?=
 =?utf-8?B?VEhMcFRkbi81Y2xXc2JTd250UTFaUmMrUGllakc0RW5HZ3l4bjR0S0xxQ3FL?=
 =?utf-8?B?WUd3ai93ZW9UY01VaVRJYWZLVzhzNjFVaUtuMWthNkxPeStFa1ZWQUhLRE00?=
 =?utf-8?B?SFZHbEk2MFdKTE9yNW93S0ZoOCt6TDBTMFVsVUFJOGdRb250V3E3dUY1d0dy?=
 =?utf-8?B?M1lDcitBUURVMjJ3TGp2TmtkcDRER2dTeXB3Q0k0ekZ3RUFOd3VSemRlN0Zy?=
 =?utf-8?B?ZDRkcVRXRmVGYVBwR2taZlBPcVlZUjFQa1dxTGxvWlplQitJb3ZjelZ2UjV4?=
 =?utf-8?B?M2pmckFESzFNMHNodDlRQ0hPQUJQaEt5amxCSmtQNStBRERrcUtwQitXVVZw?=
 =?utf-8?B?QWY4NTdWQ0ErMFBUSUZSNkJkZlVrUDFNM2V0NVpQZGo5cW8wOTdtOU1ibzZi?=
 =?utf-8?B?MjAyRWt2TjJFU0lESUpYUkdOSHkzRmJ6UVVJODZBd1kvV25aNXI0c29TWTBq?=
 =?utf-8?B?R2U4ZWhqYUlPUlZRRUtpVXJIbTRDVGRDcWVkaGVRUWp1QUUzR0VvVXNWL0VE?=
 =?utf-8?B?czdxKzlxUzNwLzJDK0NoMENEMzFXSzZiK2VvbjcyNmhWRlJTNENDZlBjdDRo?=
 =?utf-8?B?RkZ0bnpkZlk3NGlMeHNyeUcySEh0Y0pUNllzcHNOTVppTkorTWNCWTFPcHhP?=
 =?utf-8?B?b0VsSmdvUGtFK1E0cVdmL0VtNlMxek55SUk0V2ZVWXc5SnAybVRMU2k4bDVG?=
 =?utf-8?B?R0c5RUtKclpCcjZ4Ym1BRDRtc24rQnU0bGVGYW5nSzFTbTJtZmRUa0Z0eUFh?=
 =?utf-8?B?TS9zS28vRGtSc2tqYXVrRW5USWtTOSt5R01SeVpEUHBTYlhaSHVRZmliZkg2?=
 =?utf-8?B?MVBoWnZhSUF4WnJQaHQrRmRGYWg0QUJBR040Y0ZabEkrYXFSTFd6czJaa0l3?=
 =?utf-8?B?Y0JJU2NpR0FlY3NlRG8vOCsrWU8wcnRqUHRPRFJiMXZyWUVQU0JTR25rdVBK?=
 =?utf-8?B?dVdsR0VIS1ltWTRZTkF6aW0vS3RCUDRJUE9weXB4UjBNMHQzei9xRGduRXE0?=
 =?utf-8?B?RkZ4VlZMMkVPRlRoUDBWbXEvbk16R0FPczRqOGIveGRQWGcxVUpkK3ZZUjZ2?=
 =?utf-8?B?dlZ1OUgrOUM4ckI3VkdOL1VTN1lNK0dlQ1dQMFJlcWgydldzbVZ6V3c0cTlV?=
 =?utf-8?B?VUtudDNvYjlBK1pqYzg0QXNMK2drdGJsZmkyNEx2NTlkNVNPSjdXalZwQy95?=
 =?utf-8?B?MXdIcGRpRXYvUDIwTTc5VUc3c0tlaEpmVWdma1lXaTdqOW1HYnpNNDhBUURv?=
 =?utf-8?B?bHdESlpVSWtKZzBnUkMrSzd4cEw5WE9qUEphNU1sVDhpeWRmb0svSGRrQXdv?=
 =?utf-8?B?LzYyOGpyUkpQdTlNNXhYOXNVRTl5VXdEeXRUYkVxVVpQSGpSZHpYL013dmd5?=
 =?utf-8?B?VlJ3YUhtRmh4TDU0RVlTMFJ1Q2V3MitKbG0xWjdYTVg5ZEJvM1Q2bFQxcjVM?=
 =?utf-8?B?RGgrL1JEWVFDcFFkQXF5TWNWRTJYb3YwYlBHMVliQ0RjdWZBMlhEME83Q0h3?=
 =?utf-8?B?OXI1VVZFbWR2WnZFYjJsdVZhTGltZDFob3V5bjFWbGp0NWk0RHBiZW5nZzlC?=
 =?utf-8?B?Qkd5dkRNRnlwckxFUmpTZ25xNDJnaVFMT2ozL0pLdVRWR2R3emNzcFN0eWlO?=
 =?utf-8?B?dHc5UHlSdXdXS3RpK3FwWk5ya3dQYmdYV0F1SkV0TEdFc2xuMjF2OXdiKzJZ?=
 =?utf-8?Q?/+zi/IDWnEeeEbVUIZ1DBZ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1NISFYzSHlYc3Y1a0VaalA1QlRYQVVodFRTVWVTalB5aXlhRDkvSFljYUZS?=
 =?utf-8?B?eUpQVkJ2VktkdFo4NEMzV1ZyMkI3OUlXeTIvK3VidkxSV29TSloyek05OVJs?=
 =?utf-8?B?dlFId1NZSGh4ZU9EbkkyZGhNUkl4d1Nsejk4NnZlT0dHdFp1Wk8ybHFhclVB?=
 =?utf-8?B?WngxeWV6OUNKdFo1bEZhQ2FwMFJCWmZUVWw4OHVpQXE3RExxZFcwUG9IT0Rx?=
 =?utf-8?B?eEJESUFGMXd4M2F5QUQvb0ZWRmRGZ0YxZjRVVVpRd3JOZElYclJiR2VEZUNJ?=
 =?utf-8?B?bHUrc2xlQ1paQjFsSTdzS3NkL3V5SS9SZXJ2TkRBdlVkc1JjcVFYeHdKcThR?=
 =?utf-8?B?eGkwQjZzbllaY0tjaE92VUo1QnNuZ0ZJdWw0Rlpydi9xMFptbEFRMEZyTjgr?=
 =?utf-8?B?c0dlUWduWHA0cXQ2UkpTb0lyTDRsQy9rT2llOXJ3VjN0K1JicUdEdldhSTdD?=
 =?utf-8?B?UDBsWUlGMmJvR1paMzcybjBsTGVUK1ZGS0VJTmhPdDk3b2hyYU4xTVUvQTJz?=
 =?utf-8?B?cjRibnBuMGtPM0lIYW8yY1pOVHU1SllzZTVweUFDNnNPakxXRmxodUFDM2FD?=
 =?utf-8?B?VUNtSXEwSGU4WlhHN1lLd1pGOUVhUzJaUy84VWRjODBKcGlLa0kzRHhJUWRo?=
 =?utf-8?B?S2dNcnBwUkNYdTMrQXdvcVl2ZVlPZXdhT2t6NnJ2TFlUbGRZY3dQMm5WbmhJ?=
 =?utf-8?B?aCtWVHhSc2pHd2F3OWprU1FnNkZOQ1pOeGh0MkxRcHJwR09aQndibUNVVTU3?=
 =?utf-8?B?dmc0L0pIYkJnOE9FVkowcVNIT0U5cVZ1Y3NtR2N1ZjJmSkxSY1UzeHFhUEJk?=
 =?utf-8?B?c1R4bzBkeVN5KzhtajJYQXYzanhJbStSYWhGNTY5RkV1V1BVWDdsUVBTTW1W?=
 =?utf-8?B?d3VXYVZwVjNYblhwaDBkdmV6bHNMTWpYd3cyb0xBODMvaGxFRCs2ZW5MVjhI?=
 =?utf-8?B?WkxoSXdUNU5MMkRtT3E3UjJ5RmJRbTg5NktGNVZkc1Vpbmp0QUQvdmpaa3BB?=
 =?utf-8?B?ZTFDNmFTRnk3NUtCQitDV3hJVmIzOC9KcmY1RDdrYW44R3FsYlRmM1pxR1hz?=
 =?utf-8?B?alI1UWlFeURnY1BBMys1MStpOFlNbjZTVEN0R0hjbzVxSERKam41OGZ4ZXlD?=
 =?utf-8?B?SUcxUDI0TmQvS3ZGY0hDZ3pWam1kK1hEWlorbXI1Nk9qak8zaUJVajZrc2Nk?=
 =?utf-8?B?aXpzWDI4TTJUNXQyUWxxWFJIRkZJRDNxSEh3d1JaMkdJT2xuQ3oxcWFaY1h3?=
 =?utf-8?B?U21ITTBZSlFIUjFWZUVENEwzZk83ZHNuNEhsSmRLM2cvbTVObmhnbWg2dFJU?=
 =?utf-8?B?U2o5R2FhaG91elBpSUZRcWVGTzB1Wm1IVTdkOEFYaEpwMlBST2FiaVFNRjgv?=
 =?utf-8?B?eEdPcHVjUjBkelY0ZnNmM1c1MERyYTV0cVpOZTdVdEh5bmJqNEZJZm1BVlVT?=
 =?utf-8?B?SnBJM0hMQW5udlZ2ME9RYXVJR2JNdU41WnY3a0V3SmcxcjJWVzd0ZUlHeW15?=
 =?utf-8?B?YmZHRmpFS21ncnJHemV4ekpVS2VCb1hKbDlMN0tMUVh6NmU0bTlkMVpjQW5v?=
 =?utf-8?B?cU03VVBpZCtvbjliNGlIQ3ViNmE1dDRhVmVLaDJhanErVmxvTFZqYnNBVXNL?=
 =?utf-8?B?dkMrWW9XelJyWHZoYzFQc24wR2NEVTV3K1FpZDNUdVhUYzkwQjBoYjVCR2M0?=
 =?utf-8?B?M3QrcXJEa1BxMDRXMVRRaGlqSFE3MnN4ZnYxVVdkZWM1dmM2N2JKNXFqcUFy?=
 =?utf-8?B?MEZKWW5USzROWnQ2U04waVJXNXRpeWc2ak92NUZhSVovczR4Q1BEOGtsc2ps?=
 =?utf-8?B?YnV3UmY1a1BhamlrcHNsUEQvRENETlNPVXEzZE1WeWhCWUdEYzFoQ3E5Zzc0?=
 =?utf-8?B?cmpucXJoN0RqS3FaQWlXenZ4MjlvTUdzTndaWDNpRXV4R0lhVGdiTm0zM0d2?=
 =?utf-8?B?S3U1dDBOQXlXVW4vMlNod01zZXZTZUorZlNWMGtYaisrZ0RrL0hGMjBHT0ZE?=
 =?utf-8?B?WlRPY05Wa3djdThMYVNTQmc3aEsyMmNVL0RJOU5sdXUvSGFLZ0JQN1NhemlJ?=
 =?utf-8?B?NVBHTU1TUFNnMHFucmNtcy9XRTU1Q1RrRHVnWHNUSnhTcjV3d2k4VHJHaTlM?=
 =?utf-8?B?TFR0cVhyM0tQdzhyNUcrZS91M0prMnBqQmR0a1pLWVprdytOS1BpNFFRcEcy?=
 =?utf-8?B?TXJsN0YrajZ1azZZZk1UT3ludzEvZWpvSEJvMjZld0xXRkhXajlFMG01Vzky?=
 =?utf-8?B?NDZzR2VjNFhCU3N0bkx4cEdTOWZEbUt6SS9hVGdXemk2aUdWeW41N0NxWFNz?=
 =?utf-8?Q?MH7ZBGxFk8234iaGha?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c2d5f-9de5-4ed1-19cd-08de57fbc255
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 08:13:14.1455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I++bHsfUD/Q8E45KtMmUIbnSzycQyqFgs4c6/yunQMgyYPmMEskcAJ5pNA9DXoJniKK66vyXpPfjHzENf/AcWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEFsbnViYW5pIDxh
bGlhbG51QG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDIwIEphbnVhcnkgMjAyNiAxMDow
MA0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgc3RhYmxlQGRwZGsu
b3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1hcmF0aGUgPEFiaGlzaGVrLk1hcmF0
aGVAbWljcm9zb2Z0LmNvbT47DQo+IGJlbmphbWluLndhbGtlckBpbnRlbC5jb207IERhdmlkIENo
cmlzdGVuc2VuIDxkcmNAbGludXgudm5ldC5pYm0uY29tPjsNCj4gSGVtYW50IEFncmF3YWwgPGhl
bWFudC5hZ3Jhd2FsQG54cC5jb20+OyBJYW4gU3Rva2VzDQo+IDxpYW4uc3Rva2VzQGludGVsLmNv
bT47IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+OyBKb2huIE1jTmFtYXJhDQo+IDxq
b2huLm1jbmFtYXJhQGludGVsLmNvbT47IEp1LUh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQu
Y29tPjsgS2V2aW4NCj4gVHJheW5vciA8a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1Y2EgQm9jY2Fz
c2kgPGJsdWNhQGRlYmlhbi5vcmc+OyBQZWkNCj4gWmhhbmcgPHBlemhhbmdAcmVkaGF0LmNvbT47
IHFpYW4ucS54dUBpbnRlbC5jb207IFJhc2xhbiBEYXJhd3NoZWgNCj4gPHJhc2xhbmRAbnZpZGlh
LmNvbT47IE5CVS1Db250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpDQo+IDx0aG9tYXNA
bW9uamFsb24ubmV0PjsgWWFuZ2hhbmcgTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsNCj4geXVh
bi5wZW5nQGludGVsLmNvbTsgemhhb3lhbi5jaGVuQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTog
MjMuMTEuNiBwYXRjaGVzIHJldmlldyBhbmQgdGVzdA0KPiANCj4gT24gMS83LzI2IDEyOjAwIFBN
LCBTaGFuaSBQZXJldHogd3JvdGU6DQo+IA0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEhlcmUgaXMg
YSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDIzLjExLjYuDQo+
ID4NCj4gPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyBKYW51YXJ5
IDIydGguDQo+ID4NCj4gPiBQbGVhc2UgaGVscCB3aXRoIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24g
b2YgeW91ciB1c2UgY2FzZXMgYW5kIHJlcG9ydA0KPiA+IGFueSBpc3N1ZXMvcmVzdWx0cyB3aXRo
IHJlcGx5LWFsbCB0byB0aGlzIG1haWwuIEZvciB0aGUgZmluYWwgcmVsZWFzZQ0KPiA+IHRoZSBm
aXhlcyBhbmQgcmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZCB0byB0aGUgcmVsZWFz
ZSBub3Rlcy4NCj4gPg0KPiA+IEEgcmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91
bmQgYXQ6DQo+ID4NCj4gPiAgICAgIGh0dHBzOi8vZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxl
L3RhZy8/aWQ9djIzLjExLjYtcmMxDQo+ID4NCj4gPiBUaGVzZSBwYXRjaGVzIGFyZSBsb2NhdGVk
IGF0IGJyYW5jaCAyMy4xMSBvZiBkcGRrLXN0YWJsZSByZXBvOg0KPiA+ICAgICAgaHR0cHM6Ly9k
cGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+ID4NCj4gPiBUaGFua3MuDQo+ID4NCj4gPiBT
aGFuaQ0KPiA+DQo+ID4gLS0tDQo+IA0KPiANCj4gSGVsbG8sDQo+IA0KPiBXZSByYW4gdGhlIGZv
bGxvd2luZyBmdW5jdGlvbmFsIHRlc3RzIHdpdGggTnZpZGlhIGhhcmR3YXJlIG9uIHYyMy4xMS42
LXJjMToNCj4gLSBCYXNpYyBmdW5jdGlvbmFsaXR5Og0KPiAgwqAgU2VuZCBhbmQgcmVjZWl2ZSBt
dWx0aXBsZSB0eXBlcyBvZiB0cmFmZmljLg0KPiAtIHRlc3RwbWQgeHN0YXRzIGNvdW50ZXIgdGVz
dC4NCj4gLSB0ZXN0cG1kIHRpbWVzdGFtcCB0ZXN0Lg0KPiAtIENoYW5naW5nL2NoZWNraW5nIGxp
bmsgc3RhdHVzIHRocm91Z2ggdGVzdHBtZC4NCj4gLSBydGVfZmxvdyB0ZXN0cw0KPiAoaHR0cHM6
Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL25pY3MvbWx4NS5odG1sI3N1cHBvcnRlZC1oYXJkd2FyZS1v
ZmZsb2FkcykNCj4gLSBSU1MgdGVzdHMuDQo+IC0gVkxBTiBmaWx0ZXJpbmcsIHN0cmlwcGluZywg
YW5kIGluc2VydGlvbiB0ZXN0cy4NCj4gLSBDaGVja3N1bSBhbmQgVFNPIHRlc3RzLg0KPiAtIHB0
eXBlIHRlc3RzLg0KPiAtIGxpbmtfc3RhdHVzX2ludGVycnVwdCBleGFtcGxlIGFwcGxpY2F0aW9u
IHRlc3RzLg0KPiAtIGwzZndkLXBvd2VyIGV4YW1wbGUgYXBwbGljYXRpb24gdGVzdHMuDQo+IC0g
TXVsdGktcHJvY2VzcyBleGFtcGxlIGFwcGxpY2F0aW9ucyB0ZXN0cy4NCj4gLSBIYXJkd2FyZSBM
Uk8gdGVzdHMuDQo+IC0gQnVmZmVyIFNwbGl0IHRlc3RzLg0KPiAtIFR4IHNjaGVkdWxpbmcgdGVz
dHMuDQo+IA0KPiBGdW5jdGlvbmFsIHRlc3RzIHJhbiBvbjoNCj4gLSBOSUM6IENvbm5lY3RYLTYg
RHggLyBPUzogVWJ1bnR1IDIyLjA0IC8gRHJpdmVyOg0KPiBNTE5YX09GRURfTElOVVgtMjMuMTAt
Ni4xLjYuMSAvIEZpcm13YXJlOiAyMi4zOS41MTI0DQo+IC0gTklDOiBDb25uZWN0WC03IC8gT1M6
IFVidW50dSAyMi4wNCAvIERyaXZlcjoNCj4gTUxOWF9PRkVEX0xJTlVYLTIzLjEwLTYuMS42LjEg
LyBGaXJtd2FyZTogMjguMzkuNTEyNA0KPiAtIERQVTogQmx1ZUZpZWxkLTIgLyBET0NBIFNXIHZl
cnNpb246IDIuNS41IC8gRmlybXdhcmU6IDI0LjM5LjUxMjQNCj4gDQo+IEFkZGl0aW9uYWxseSwg
b3VyIGJ1aWxkIHRlc3RzIHBhc3NlZCBvbiBMaW51eCBhbmQgV2luZG93cy4NCj4gDQo+IFdlIGRv
bid0IHNlZSBuZXcgaXNzdWVzIGNhdXNlZCBieSB0aGUgY2hhbmdlcyBpbiB0aGlzIHJlbGVhc2Uu
DQo+IA0KPiBUaGFua3MsDQo+IEFsaQ0KDQpUaGF04oCZcyBncmVhdCwgdGhhbmtzIEFsaSENCg==
