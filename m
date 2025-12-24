Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D7E75448
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 10:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 230CF40262;
	Wed, 24 Dec 2025 11:12:49 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6DB184025A;
 Wed, 24 Dec 2025 11:12:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwX3YLrbWhYB+VFkzk7PRqmmflBSS3eSKxJZKGMUl0r2+qnHTSkQAk7ignuFFJzuhgtK+fI6o7EtSjTdu4/StcHmNzXpA7XiR1d88F49avbRrIc8KsKqv8iBid2vqKtc9TX1cYbOTEZtBqjw60T3YcwD2vqWuepq5HrHI28xN5chJJtpVkUx8yvU3icYg+0Hm1EkJIrlKy7f3S9ncBNERwndJX3y/4fmak3flqs6VWCjeTw/sF9WV9d0yqxngwiuCI13hS6EBzI+vX6zNbcttK05fIebJj+gpTWa8T2pnVj1uJc6X7nRpiv1YuZUhi1t3jXlNv7XV+c6+5qyKov7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAl09WE5tiVuyMJ0jJV5oh9TSL/uZylg/uol71uM6jQ=;
 b=hjIH7aXjMZVgauCnQEp/eEbT2fHVrzxb94oAGEFLYtyYTQw6Jp9OQitR+lfXlb5tnXWdxI487cKuOz/PsGWLrv3Lk9L+BCfHgMA9AXZ47Loo/9abySqtLRArW4YWjJcVRjF24r69QxDAqG1ka8POfz3yEmR76W+MmOS6B/FXXt5MHhghJWgFc8+KNZxvl+qqx/NgkJnY+HfRWkxApnHYG2s9BTm4d253Tn0XgOr1QFrNznaxhKo0i2SU+FoW28NVEW+ICAnqkM8CR9WXz+eAoz/4s8VUuRXRq1bdlUNnIXxdmaHwhFP6PUbnTyfksSNeHDnUeJ1kTupyLRuz1pkJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAl09WE5tiVuyMJ0jJV5oh9TSL/uZylg/uol71uM6jQ=;
 b=acL4GMIWnv+TecWYVRoujEOw46Fl9PFUxWngRAVSS8swnbwF9vcsRj7/SH+j1gcbJG/yAYgQAyDeKRnmITSMSn6WZ+FUdwhiEED9nvzyVaYeS3Y34w/d8tmBvs05GD/4NiB327tV6RCbpt4vsiv7MJ7/mXCUht+Pp9FDywiv8WG0+jaUcb1DpYP5bCVXBQC8m7WBtT3hjIi20mDmYeom5PJwDmkFluDLqPY2rc0FXN56R0uvmGnv8tgi6GXmVkwuMBI2YmtC/Jw/6cGg+rY2AiB0shJfh2FXXGE+r47MDoSrejp7mih+QhWQZPmVgNvSDLXhv5nOJdCW6vhgQUWP2g==
Received: from IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 10:12:44 +0000
Received: from IA1PR12MB6628.namprd12.prod.outlook.com
 ([fe80::ca04:6b1f:7abf:3409]) by IA1PR12MB6628.namprd12.prod.outlook.com
 ([fe80::ca04:6b1f:7abf:3409%4]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 10:12:43 +0000
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, Luca Boccassi
 <luca.boccassi@gmail.com>, Ali Alnubani <alialnu@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, Kevin Traynor <ktraynor@redhat.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, John
 McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Salaheddin
 Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
Subject: RE: 22.11.11 patches review and test
Thread-Topic: 22.11.11 patches review and test
Thread-Index: AQHcZLjPdWp6Eq8EF06PevT7dufUdbUnzUgAgAABGQCAAAiiAIAAAnMAgAXI1QCAAb+3AIAA1X6QgABOOYCAACrmMA==
Date: Wed, 24 Dec 2025 10:12:43 +0000
Message-ID: <IA1PR12MB6628D5EE5A1CBDF44D9F1408B3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
 <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
 <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
 <IA1PR12MB8077E548000554C0B770779EB2B2A@IA1PR12MB8077.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB8077E548000554C0B770779EB2B2A@IA1PR12MB8077.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: luca.boccassi@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6628:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: e5e34fa3-bd7d-40ba-a8a9-08de42d4fa97
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MmNKYWVUbFIvdnJ1RGViZThNdTJucVNkVTluY3lMc0FpVkRJa1YrV21meUcy?=
 =?utf-8?B?QTdjRWdDQTlDUFllalhaaWRjSDBub0lDVi9mODVDeFlnRlpEM0Z3Z2gyeVNK?=
 =?utf-8?B?ZDB0MkpLa0FWRkNTUmhVT2x0V3RVbitUOE9CM3VmSXUwNjlQTmZ3bStCU2RB?=
 =?utf-8?B?NlQ2aG9lY1VFdEZXZ0JiNW0zTWZXSFh6UUxrUDFFa3RCa3hJQkgxZWN6aG42?=
 =?utf-8?B?NFpNMXhJa3pZd2E0Y0svRjkvS01WUk5YdnlOV2hHM1VBM3JsNjhVNzBrS1Vz?=
 =?utf-8?B?YUhTS1N0U0YyUXBwS01jd1RjN3pXczh6SW5idjVHY0E1U0U0bjc3dEdkcmdh?=
 =?utf-8?B?WndLSlBvYVByWHVBclAvWmQ2Q29DSlBTck1JSkw1UTdZSFRFTnJsckk4Y0Fz?=
 =?utf-8?B?TlhIWUhuekM2Y3Rmb1Axd1ExampuTFl4dG9oZ3p4UURmTkpmblZYYTFlNXVo?=
 =?utf-8?B?NjVvVy9yR2h5V3V2M0wzRFgySlYxbjN4MG54eTJFaDZzcjdMU0J3STgwNElS?=
 =?utf-8?B?YndqbENoVk5aVy85VmR5YXh0Y0w5SWhFMy82algzMDJrZ3NYNGRUOHB3dWZq?=
 =?utf-8?B?NVM3UTIrYkF3R3I0SDUwSTMzdWdVUlJNWGFNYW95Qy9zMllabW9HakUrUENh?=
 =?utf-8?B?K3JWdUZmSUsxNTFGeXdQZEorQldUdmhtVGc2V0lTWmhkV3lvei8ydjB1NkV3?=
 =?utf-8?B?Skl1QytoeVlCYTZjSnFwb1dDcDVkSk5nSERMSkRNblluWXdLSkIyeXEyNzRh?=
 =?utf-8?B?VG03NHBBR1BxdlJ4SytuYWsyejR3eWVQTVlxQlhaT3RhaE5ZWlAvN1hreXlH?=
 =?utf-8?B?YUhWSGFyRmRvQjJJeDRKRFQ5dE5mUE5STVVLMEM5T3M2UUpFak9naFhNVWpr?=
 =?utf-8?B?bUtIay83K1JCWjA4K2pURlZJcVY4aDhiWGJXN0NPa2J3aXVucDN1YzlXMHRL?=
 =?utf-8?B?UVJhYksxUCtoYUhWMnZmclA4Umlia3FYRmVGRnBDSkdrMG84NkNYY0xONDIx?=
 =?utf-8?B?ZHRNaGFIVHRXRlFOdWVpNTYvY1IzZ1pTTnByMVYyamF6ejRGcGtsTkhaSi9Q?=
 =?utf-8?B?UXJoaVRYQW5NYm5FMVdHR25NWEljaDhxK3V4TVJMZnFDdWhGcG1JZXRSY1di?=
 =?utf-8?B?d3hraEh6UFhFOHdCbm8rV2ZCZkx2dGhOQXVlRG5mWWROaXZTbU5GV0J4QVVl?=
 =?utf-8?B?REoxc2didUYydEdjby9Gd2l2cjA4ZVo2aXBob2ZEM0NEbDlNWmpsNi80REor?=
 =?utf-8?B?VjRqOXd3MnRKUmkwWUFDUzR0UW5Ed0grZVZIS3d1TGsyS1BKTFV4emVFL044?=
 =?utf-8?B?OUZxTndFVTRsYVpaZzFQSitmR3pWdkRXcmZCN2hnb0htTzRsc0JsMjFpaUtQ?=
 =?utf-8?B?Z0dsZDJ2US9NNzRZalJuNXRTOHdVVjlBcFRKdW5LOTQ0S21mMTNSaEplWloz?=
 =?utf-8?B?ZlhERFMvOFRveXJXTEIrcW9oZHZwWWdvQUpHK1J4bmdqeVQzV0xOWXJZWkRt?=
 =?utf-8?B?aVF0eDR3KzJXS0FGUVo3emtWOXQvOTczbHoxQlZVVDg5OThsY2x4WTVocy93?=
 =?utf-8?B?dWN2c0FvbGR5TExoMmZNcnRheStUZlFYR3FyZE9QRWJFNlo5Yy9oSzRJeU5y?=
 =?utf-8?B?NmpjdlRocmk5cFBGTlAvS21zVCtxM0g0anJGV3lUK0lvWmR4ZmdiQjVDNlJ3?=
 =?utf-8?B?aW1JVGtXaHdmVVdZUk5aZnB6N3lGRk92UGFzQ3E2eWIwTzFsdkxlMkRkK2Rv?=
 =?utf-8?B?WjZ4cnlqQnJDazFZb0V4aExKUzYrT0NjRjUxMmlYWXVNejVMUjRjcFZRRTRx?=
 =?utf-8?B?WDl1N241WkdnalIwam9nS2tzQlZETW1MR1dVN25vTnVCMnU0UEhXUTQ2bW5L?=
 =?utf-8?B?cXlhYXhZMHhOSHhCQ1UxTCtuVGpGdVFtdm1kV3g5bUNIdCtJUGtDSU51K05Z?=
 =?utf-8?B?ai9uUU5SVFoza090Z3U3cWYzMHRoUjd6NEZ1bnNsTm9jL2cwcE1lZVRSb3dJ?=
 =?utf-8?B?eDFRYit3ZjRrT2FKbmQwZ1lkUUlwbnlnVDIyclpWR0FkOXAvcy8vYVZzVVI1?=
 =?utf-8?Q?rv2TLp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6628.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFyM1Fuam1WWFNjWXl5MWFkZXdUN0lRWGVQaFJwQVZlV0ovZmdYMUhRN1Vy?=
 =?utf-8?B?VXdWTW9WekFtNDF2dm5ZMFlUZFhwM0R5eTRvV3BwZDFUQlZsQjQrb3BIRjU1?=
 =?utf-8?B?SjRaTzFwQXczWFlSM29GSEd3QVJRUEUrbGl4WmVXYWdYZlptSXI5RlV2MlhT?=
 =?utf-8?B?c1pheDJjQXBSQmhQT3I4dG5mTVNaYzBXN2thTnRSUlVURUthMDR4TkEwTzgr?=
 =?utf-8?B?V3JvUmpDWmZNWnVoOWpybUh0Q2FZRlhJNVNpd2RmU05ycFNnMkVEMk1FTkVt?=
 =?utf-8?B?ZDZPOHR1bXZwOEJEOHRMZnpPbWROSHAvWGczMjd3Mm50M1hwYUdKVVR6T0xz?=
 =?utf-8?B?T0YrbnRFNy82QU9zeWhDWUg0MXh2eS9KWGFtTi9EYUk2bFN3NUhrSVZGdUFl?=
 =?utf-8?B?ekNqOGd4bVdPOXpQSTczY1h3NGZraDNkMnE2Y1g3NDUrRkVrbW14NEljdVZv?=
 =?utf-8?B?WkdSRTVoNS83L3NWOXhzeXYxOEpqQ056MXMvNFRYOGd1TTR2S1hHeTFpUUdj?=
 =?utf-8?B?VVNwOGc5RlhIVXM1cXJNMHR6YTJWYi85TFV0TXo0S1h1Q2M2QjhsaGRNUDVG?=
 =?utf-8?B?SitoRk9RaS9SRmRLZjRPSzB3T21kT0tzQjhFN1NJVVoyMGtrdjNLUytuTHYv?=
 =?utf-8?B?WWJhbmZhSUJ4S0E0NlVqQ1BpMFJBbk9kZVNxWFdLOGRJeUIyWnpFQVU0eEpy?=
 =?utf-8?B?Wm56SjhCSit5a2Z3eTFaY1QwYlllbm9PU1RzYjcvZ0pybGVxQzBmVHdCamth?=
 =?utf-8?B?dTZGcU1kQlBCblRiOHRodEVSbFpoZkp5RmROYTc1V1h0UHEzZnlSZ2xwVk1E?=
 =?utf-8?B?R1FCRTVLNDFUOENRa3Rpc0R5dWtnMmpuaDBhQkU0WnVjNWVHZEVtaDk5dHk1?=
 =?utf-8?B?ZDVhclgzNnNpb0V3WWpTdXppTjVmTGlrek5CYzB1WCt4cVc5ekFrZEF1Y09y?=
 =?utf-8?B?UzhYR21lYnVEOTBRN3pCMnl1bllteUpoazA5eERTVllWTFhIaFlRSXBMZFNO?=
 =?utf-8?B?Y3krT2wzOThla3F1UHNiRENHL2FmalRqZXN1VFMzdEJiRmJlQ09TRk9HNlJ0?=
 =?utf-8?B?SGtjVG5kM0ZqL2NpMnZSQ0E0cGhEaG1ZQnpFOCsybGw0emw5Y3Bsd0puRkFH?=
 =?utf-8?B?OW5PYmplZXhVcHllWDN2OXJDVmR0bUNXMDRRWUZhc2RML3FjeVJ4TE5BNjJC?=
 =?utf-8?B?QkxKaEdybmVxaFFnQWFaYVNtVEdCUkwvSTljaDgrWjI4Kzc4SXRFbUJyZDE1?=
 =?utf-8?B?aitsSjc3TGhOZHk1Yk1vbVBvTUwzazFDVW1qakFCMkdZaTN5NXJmU1p5NFBK?=
 =?utf-8?B?V2FyNXpsc2JkQ1FrS3o0eXBTZnJOTENieVFnZENGQWdJWkRkblFwQTlnTDZt?=
 =?utf-8?B?aXUvRjFNWGdHVmN4Q0NYYXYzdk1uRjZLaEFFWjF2NjNvcjY4UGFYdldLOEdV?=
 =?utf-8?B?QTNXYjJ5WDMvakFScnBCY1dnMlY2S0Y0Z1QvT0pML2xac3BtYWVVWWV5U3BV?=
 =?utf-8?B?V0ZaMGVqaE5CeUE2SGdJK0Y0a0U0bnZMVjh3c3NkcDllQ3BldmNiaUNqRHhX?=
 =?utf-8?B?LzdFSXZvWDBqbTJodjhabENJczBqNjBPL0tHUmxoWjlaS2pRdXlueEtRQ0Jo?=
 =?utf-8?B?RTRzWXYrNGYyR1pORHpWWGNpQTgxSjg1Sms5d2NtK0ZxMTcyWUQ0RjAyUiti?=
 =?utf-8?B?MkhManRyUFAveEZRK3QxYTk5a21FQ0hDZ3Q2RFl5VSs4cDNja3hxaHBuYUpa?=
 =?utf-8?B?N3JQL1ZOQ3h1SGw5bFl5M1Axbjl5OWFMUEsvUUtlSVhDYXZwOW5xUUx0TW5Q?=
 =?utf-8?B?UlFYcGtGRUNUTWh6VTVBWkFtb2xCZDZyQTEwN0JvS2VWRmEzcnFESEZkZ2hZ?=
 =?utf-8?B?aFZTYk8wZWY2NzBYb2hsSk1yWGZxSC9qMTAvdHBNb1dkSmpvT0F2TXdXcldy?=
 =?utf-8?B?Y21FTVpWbFRjUGRpM2J5K2JuaVNZMUlZOGJCaHF3cVVnaERobTF6MmlqR0Nw?=
 =?utf-8?B?ZHZTMC91VWdBZkgzMVpLZE5NL3BSaEY5clZKQlh1NmQ5YjVUblBrZ2s3cXV6?=
 =?utf-8?B?TW83ZTlVdFoyWFJUWG1FUW03Nk5FeUtReU81SE1sd21qVS80cWxIUzFpSkhq?=
 =?utf-8?B?RVJYL1o5aUo2TzEwSFZyYnZRNSttQ2EyL1lSY09DMEoyTlVTYmtXbUh2VFp2?=
 =?utf-8?B?d0h6SEVSTHFvYUNUTEsySm9EZlQwMEZOdGwwMVRLVFAraFE4RURzaE8rMjgz?=
 =?utf-8?B?dHVjcWdWTVEwK2thN3hKMTkzeDRvSGluZ3h4ZlRCTW1ic3hRVnBmZDJ2enJU?=
 =?utf-8?Q?0IINpwg8j4/37yBxBC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e34fa3-bd7d-40ba-a8a9-08de42d4fa97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 10:12:43.7615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMvuxL3u0WNoicbAufw+kNuV24YHb0d2TXtIUB5T6wy0XTYqRD6X7Trk6CI6Wqu+qiGGlKyx6scb7VhOEN7ruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

U29ycnkgQEx1Y2EgQm9jY2Fzc2ksIEBTaGFuaSBQZXJldHogYW5kIEBLZXZpbiBUcmF5bm9yLA0K
SSBkb3VibGUgY2hlY2tlZCB0aGUgZmlyc3QgY29tbWl0IG9mIHRoZSB0aHJlZSBhbmQgZm91bmQg
dGhhdCBJIGRpZCB0YWcgaXQgd2l0aCBDQyBzdGFibGUgYnV0IG1pc3NlZCB0aGUgZm9sbG93aW5n
IGNvbW1pdHMgdG8gZml4IGEgYnVnIGludHJvZHVjZSBieSBpdC4gVGhpcyBpcyB0aGUgcm9vdCBj
YXVzZSBvZiB0aGUgbWVzcyBtYWRlIGJ5IG1lLiBUaGUgZmlyc3QgY29tbWl0IGludHJvZHVjZWQg
YmVoYXZpb3IgY2hhbmdlIHRoYXQgc2hvdWxkIG5vdCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZSBi
cmFuY2hlcy4NClBsZWFzZSByZXZlcnQgdGhlIGNvbW1pdHMgbWVudGlvbmVkLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hYXlhbiBLYXNoYW5pIDxta2FzaGFuaUBu
dmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDI0LCAyMDI1IDM6MzMgUE0N
Cj4gVG86IE1pbmdnYW5nKEdhdmluKSBMaSA8Z2F2aW5sQG52aWRpYS5jb20+OyBMdWNhIEJvY2Nh
c3NpDQo+IDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT47IEFsaSBBbG51YmFuaSA8YWxpYWxudUBu
dmlkaWEuY29tPjsgU2hhbmkgUGVyZXR6DQo+IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgS2V2aW4g
VHJheW5vciA8a3RyYXlub3JAcmVkaGF0LmNvbT4NCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZzsgZGV2
QGRwZGsub3JnOyBKb2huIE1jTmFtYXJhDQo+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47IFJh
c2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47IE5CVS0NCj4gQ29udGFjdC1UaG9t
YXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFNhbGFoZWRkaW4N
Cj4gQmFkYXdpIDxzYmFkYXdpQG52aWRpYS5jb20+OyBXYWVsIEFidWFscnViIDx3YWVsYUBudmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSRTogMjIuMTEuMTEgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QN
Cj4gDQo+ICsrQFNoYW5pIFBlcmV0eg0KPiArK0BLZXZpbiBUcmF5bm9yDQo+IA0KPiBQbGVhc2Ug
c2VlIGJlbG93LA0KPiANCj4gUmVnYXJkcywNCj4gTWFheWFuIEthc2hhbmkNCj4gDQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBNaW5nZ2FuZyhHYXZpbikgTGkgPGdh
dmlubEBudmlkaWEuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgMjQgRGVjZW1iZXIgMjAyNSA1
OjA5DQo+ID4gVG86IE1hYXlhbiBLYXNoYW5pIDxta2FzaGFuaUBudmlkaWEuY29tPjsgTHVjYSBC
b2NjYXNzaQ0KPiA+IDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT47IEFsaSBBbG51YmFuaSA8YWxp
YWxudUBudmlkaWEuY29tPg0KPiA+IENjOiBzdGFibGVAZHBkay5vcmc7IGRldkBkcGRrLm9yZzsg
Sm9obiBNY05hbWFyYQ0KPiA+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47IFJhc2xhbiBEYXJh
d3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47DQo+ID4gTkJVLUNvbnRhY3QtVGhvbWFzIE1vbmph
bG9uIChFWFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5uZXQ+Ow0KPiA+IFNhbGFoZWRkaW4gQmFk
YXdpIDxzYmFkYXdpQG52aWRpYS5jb20+OyBXYWVsIEFidWFscnViDQo+ID4gPHdhZWxhQG52aWRp
YS5jb20+DQo+ID4gU3ViamVjdDogUkU6IDIyLjExLjExIHBhdGNoZXMgcmV2aWV3IGFuZCB0ZXN0
DQo+ID4NCj4gPiBIaSBMdWNhLA0KPiA+DQo+ID4gVGhlIGlzc3VlKGh0dHBzOi8vYnVncy5kcGRr
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTg1MSkgd2FzIGludHJvZHVjZWQNCj4gPiBieSBjaGVycnkt
cGlja2luZyBzb21lIG9mIHRoZSAzIHJlbGF0ZWQgY29tbWl0cyBvZiByZWZhY3RvcmluZw0KPiA+
IG11bHRpY2FzdCBoYW5kbGluZyBvZiBQRiBpbiBOViBwbWQuIEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgaXQvdGhleQ0KPiA+IHdlcmUgY2hvc2VuIGJlY2F1c2UgdGhleSBpbmNsdWRlZCBiZWhhdmlv
ciBjaGFuZ2UgaW4gUEYuIFRoZXkgc2hvdWxkDQo+ID4gbm90IGJlIGJhY2twb3J0ZWQgdG8gc3Rh
YmxlIG9uZXMgZnJvbSBteSBwb2ludCBvZiB2aWV3Lg0KPiA+DQo+ID4gVGhlIGNvbW1pdChzKSBw
b2xsdXRlZCAyMi4xMSwgMjMuMTEgYW5kIDI0LjExIHNvIGZhci4gUGxlYXNlIHJldmVydA0KPiA+
IGJlbG93IGNvbW1pdHMgdG8gZml4IHRoZSBpc3N1ZS4NCj4gPg0KPiA+IDI0LjExDQo+ID4gZGRj
YWExNjcxZiBuZXQvbWx4NTogZml4IG11bHRpY2FzdA0KPiA+IGFkY2U2ZDEzMGIgbmV0L21seDU6
IGFsaWduIFBGIGFuZCBWRi9TRiBNQUMgYWRkcmVzcyBoYW5kbGluZw0KPiA+DQo+ID4gMjMuMTEN
Cj4gPiBjMDcwNDU1ZThiIG5ldC9tbHg1OiBhbGlnbiBQRiBhbmQgVkYvU0YgTUFDIGFkZHJlc3Mg
aGFuZGxpbmcNCj4gPg0KPiA+IDIyLjExDQo+ID4gNThhNjQyMWJjMyBuZXQvbWx4NTogZml4IG11
bHRpY2FzdA0KPiA+IGVkMzQxMTIxN2IgbmV0L21seDU6IGFsaWduIFBGIGFuZCBWRi9TRiBNQUMg
YWRkcmVzcyBoYW5kbGluZw0KPiA+DQo+ID4gUmVnYXJkcy4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hYXlhbiBLYXNoYW5pIDxta2FzaGFuaUBu
dmlkaWEuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjMsIDIwMjUgMTA6MDkg
UE0NCj4gPiA+IFRvOiBMdWNhIEJvY2Nhc3NpIDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT47IEFs
aSBBbG51YmFuaQ0KPiA+ID4gPGFsaWFsbnVAbnZpZGlhLmNvbT47IE1pbmdnYW5nKEdhdmluKSBM
aSA8Z2F2aW5sQG52aWRpYS5jb20+DQo+ID4gPiBDYzogc3RhYmxlQGRwZGsub3JnOyBkZXZAZHBk
ay5vcmc7IEpvaG4gTWNOYW1hcmENCj4gPiA+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47IFJh
c2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47DQo+ID4gTkJVLQ0KPiA+ID4gQ29u
dGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47DQo+
ID4gU2FsYWhlZGRpbg0KPiA+ID4gQmFkYXdpIDxzYmFkYXdpQG52aWRpYS5jb20+OyBXYWVsIEFi
dWFscnViIDx3YWVsYUBudmlkaWEuY29tPg0KPiA+ID4gU3ViamVjdDogUkU6IDIyLjExLjExIHBh
dGNoZXMgcmV2aWV3IGFuZCB0ZXN0DQo+ID4gPg0KPiA+ID4gKytATWluZ2dhbmcoR2F2aW4pIExp
DQo+ID4gPg0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IE1hYXlhbiBLYXNoYW5pDQo+ID4gPg0KPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBMdWNhIEJvY2Nh
c3NpIDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT4NCj4gPiA+ID4gU2VudDogTW9uZGF5LCAyMiBE
ZWNlbWJlciAyMDI1IDEzOjI3DQo+ID4gPiA+IFRvOiBBbGkgQWxudWJhbmkgPGFsaWFsbnVAbnZp
ZGlhLmNvbT4NCj4gPiA+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZzsgZGV2QGRwZGsub3JnOyBKb2hu
IE1jTmFtYXJhDQo+ID4gPiA+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47IFJhc2xhbiBEYXJh
d3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47DQo+ID4gPiA+IE5CVS1Db250YWN0LVRob21hcyBN
b25qYWxvbiAoRVhURVJOQUwpIDx0aG9tYXNAbW9uamFsb24ubmV0PjsNCj4gPiA+ID4gU2FsYWhl
ZGRpbiBCYWRhd2kgPHNiYWRhd2lAbnZpZGlhLmNvbT47IFdhZWwgQWJ1YWxydWINCj4gPiA+ID4g
PHdhZWxhQG52aWRpYS5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiAyMi4xMS4xMSBwYXRjaGVz
IHJldmlldyBhbmQgdGVzdA0KPiA+ID4gPg0KPiA+ID4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+
ID4gPiBPbiBUaHUsIDE4IERlYyAyMDI1IGF0IDE5OjA2LCBMdWNhIEJvY2Nhc3NpDQo+ID4gPiA+
IDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBPbiBUaHUsIDE4IERlYyAyMDI1IGF0IDE4OjU4LCBBbGkgQWxudWJhbmkgPGFsaWFs
bnVAbnZpZGlhLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gT24gMTIvMTgvMjUgODoyNyBQTSwgTHVjYSBCb2NjYXNzaSB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gT24gVGh1LCAxOCBEZWMgMjAyNSBhdCAxODoyNCwgQWxpIEFsbnViYW5pDQo+ID4g
PiA+ID4gPiA+IDxhbGlhbG51QG52aWRpYS5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+
ID4gPj4gT24gMTIvNC8yNSAyOjU2IEFNLCBsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbSB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiA+Pj4gSGkgYWxsLA0KPiA+ID4gPiA+ID4gPj4+
DQo+ID4gPiA+ID4gPiA+Pj4gSGVyZSBpcyBhIGxpc3Qgb2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Ig
c3RhYmxlIHJlbGVhc2UgMjIuMTEuMTEuDQo+ID4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+ID4+
PiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyBEZWNlbWJlciAxOHRo
Lg0KPiA+ID4gPiA+ID4gPj4+DQo+ID4gPiA+ID4gPiA+Pj4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0
aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlvdXIgdXNlIGNhc2VzDQo+ID4gPiA+ID4gPiA+Pj4gYW5k
IHJlcG9ydCBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhpcyBtYWlsLg0K
PiA+ID4gPiA+ID4gPj4+IEZvciB0aGUgZmluYWwgcmVsZWFzZSB0aGUgZml4ZXMgYW5kIHJlcG9y
dGVkIHZhbGlkYXRpb25zDQo+ID4gPiA+ID4gPiA+Pj4gd2lsbCBiZSBhZGRlZCB0byB0aGUNCj4g
PiA+ID4gcmVsZWFzZSBub3Rlcy4NCj4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+IEEg
cmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91bmQgYXQ6DQo+ID4gPiA+ID4gPiA+
Pj4NCj4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+IGh0dHBzOi8vZHBkay5vcmcvYnJv
d3NlL2RwZGstc3RhYmxlL3RhZy8/aWQ9djIyLjExLjExLXJjMQ0KPiA+ID4gPiA+ID4gPj4+DQo+
ID4gPiA+ID4gPiA+Pj4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRlZCBhdCBicmFuY2ggMjIuMTEg
b2YgZHBkay1zdGFibGUgcmVwbzoNCj4gPiA+ID4gPiA+ID4+PiAgICAgICBodHRwczovL2RwZGsu
b3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS8NCj4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+
IFRoYW5rcy4NCj4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+IEx1Y2EgQm9jY2Fzc2kN
Cj4gPiA+ID4gPiA+ID4+IEhlbGxvLA0KPiA+ID4gPiA+ID4gPj4NCj4gPiA+ID4gPiA+ID4+IFdl
IHJhbiB0aGUgZm9sbG93aW5nIGZ1bmN0aW9uYWwgdGVzdHMgd2l0aCBOdmlkaWEgaGFyZHdhcmUN
Cj4gPiA+ID4gPiA+ID4+IG9uDQo+ID4gPiA+IHYyMi4xMS4xMS1yYzE6DQo+ID4gPiA+ID4gPiA+
PiAtIEJhc2ljIGZ1bmN0aW9uYWxpdHk6DQo+ID4gPiA+ID4gPiA+PiAgICAgU2VuZCBhbmQgcmVj
ZWl2ZSBtdWx0aXBsZSB0eXBlcyBvZiB0cmFmZmljLg0KPiA+ID4gPiA+ID4gPj4gLSB0ZXN0cG1k
IHhzdGF0cyBjb3VudGVyIHRlc3QuDQo+ID4gPiA+ID4gPiA+PiAtIHRlc3RwbWQgdGltZXN0YW1w
IHRlc3QuDQo+ID4gPiA+ID4gPiA+PiAtIENoYW5naW5nL2NoZWNraW5nIGxpbmsgc3RhdHVzIHRo
cm91Z2ggdGVzdHBtZC4NCj4gPiA+ID4gPiA+ID4+IC0gcnRlX2Zsb3cgdGVzdHMNCj4gPiA+ID4g
PiA+ID4+IChodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvbmljcy9tbHg1Lmh0bWwjc3VwcG9y
dGVkLWhhcmR3DQo+ID4gPiA+ID4gPiA+PiBhcg0KPiA+ID4gPiA+ID4gPj4gZS0NCj4gPiA+ID4g
PiA+ID4+IG9mDQo+ID4gPiA+ID4gPiA+PiBmbG9hZHMpDQo+ID4gPiA+ID4gPiA+PiAtIFJTUyB0
ZXN0cy4NCj4gPiA+ID4gPiA+ID4+IC0gVkxBTiBmaWx0ZXJpbmcsIHN0cmlwcGluZywgYW5kIGlu
c2VydGlvbiB0ZXN0cy4NCj4gPiA+ID4gPiA+ID4+IC0gQ2hlY2tzdW0gYW5kIFRTTyB0ZXN0cy4N
Cj4gPiA+ID4gPiA+ID4+IC0gcHR5cGUgdGVzdHMuDQo+ID4gPiA+ID4gPiA+PiAtIGxpbmtfc3Rh
dHVzX2ludGVycnVwdCBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KPiA+ID4gPiA+ID4gPj4g
LSBsM2Z3ZC1wb3dlciBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KPiA+ID4gPiA+ID4gPj4g
LSBNdWx0aS1wcm9jZXNzIGV4YW1wbGUgYXBwbGljYXRpb25zIHRlc3RzLg0KPiA+ID4gPiA+ID4g
Pj4gLSBIYXJkd2FyZSBMUk8gdGVzdHMuDQo+ID4gPiA+ID4gPiA+PiAtIEJ1ZmZlciBTcGxpdCB0
ZXN0cy4NCj4gPiA+ID4gPiA+ID4+IC0gVHggc2NoZWR1bGluZyB0ZXN0cy4NCj4gPiA+ID4gPiA+
ID4+DQo+ID4gPiA+ID4gPiA+PiBGdW5jdGlvbmFsIHRlc3RzIHJhbiBvbiBDb25uZWN0WC02IER4
IChPUzogVWJ1bnR1IDIyLjA0IHwgRHJpdmVyOg0KPiA+ID4gPiA+ID4gPj4gTUxOWF9PRkVEX0xJ
TlVYLTUuOC03LjAuNi4xIHwgRmlybXdhcmU6IDIyLjM1LjgwMDIpLg0KPiA+ID4gPiA+ID4gPj4N
Cj4gPiA+ID4gPiA+ID4+IEFuIGVuZ2luZWVyIGZyb20gbXkgdGVhbSByZXBvcnRlZCAyIGlzc3Vl
czoNCj4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiA+PiBodHRwczovL2J1Z3MuZHBkay5vcmcv
c2hvd19idWcuY2dpP2lkPTE4NTENCj4gPiA+ID4gPiA+ID4+IERpZCBub3QgcmVwcm9kdWNlIGlu
IDIyLjExLjEwLCBnaXQtYmlzZWN0IHBvaW50cyB0bw0KPiA+ID4gPiA+ID4gPj4gNThhNjQyMWJj
Mzk2DQo+ID4gPiA+ID4gPiA+PiAoIm5ldC9tbHg1OiBmaXggbXVsdGljYXN0IikuLg0KPiA+ID4g
PiA+ID4gPiBUaGFua3MsIGFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIGZpeCwgb3Igc2hvdWxk
IEkganVzdA0KPiA+ID4gPiA+ID4gPiByZXZlcnQgdGhhdA0KPiA+ID4gPiBjb21taXQ/DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gSSByZWFjaGVkIG91dCB0byB0aGUgZW5naW5lZXIgd2hvIGF1
dGhvcmVkIHRoZSBwYXRjaCBhbmQgYW0NCj4gPiA+ID4gPiA+IHdhaXRpbmcgZm9yIHRoZWlyIHJl
c3BvbnNlLiBJIG1heSBub3QgYmUgYWJsZSB0byBnZXQgYmFjayB0bw0KPiA+ID4gPiA+ID4geW91
IHdpdGggYW4gYW5zd2VyIHRvZGF5LCB0aG91Z2guDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFu
ayB5b3UsIG5vIHByb2JsZW0gaXQgY2FuIHdhaXQgYSB3aGlsZQ0KPiA+ID4gPg0KPiA+ID4gPiBI
aSwNCj4gPiA+ID4NCj4gPiA+ID4gQW55IHVwZGF0ZT8NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtz
DQo=
