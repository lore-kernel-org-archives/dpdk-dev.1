Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777FAC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 05:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6197140275;
	Thu, 27 Mar 2025 06:51:25 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
 by mails.dpdk.org (Postfix) with ESMTP id 81B1540261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 06:51:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ/ffITfntD3hHaAR4bk7uPxujdSLIr8SVcxhwDdhG0dDWbv/SpgWyAcnGh1YJBZYXPjJEZxX/FlQ/yy08QvecTTnQloe2xQHhYDE1YUxQe3bc5709ZFuFQkPQar6omKNkNNLu/RUZQQkyqDqQDgoOKqbjrOKOstgB1T9uQ6tlYcqkPWYsnNKJP0h3prgKge/LbrzBo3zFnUGPB9gV++Mv4bREzcw2x3qdUZXYL7L3LZGIG7LjkV6CSZOV+nr2w525ndI+CnQ/H13BwEiKcONArgDMtoToakGq4f6RpskG3mfjOIgFVJfABUfkdq6TJx3kTwSCTPB1l3Nxc0SDgZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GN6l3J/62JhvCcbrfRYH61xtNJAHzaqFkabL6zhOEY=;
 b=T+i4vrUsGKlLEglkKkDQMSK/jiuOnvxxdl4dDD+cwJi6pkVxhpArkLlcZ7/27DqQL7S9ed0Kjcyl53z+VWKlueau+b3pU1zDNAoOKWkm0U8+oQaOphvYaDctbZbluphuYmLT8UHT6Ld6P1t1T0ridYmgNsCVgc2eehSEiQ95FhXVAswBE3MMOrP4pQGklGBU0DSpGiGz87KsPFzQl4tODe6jhn/yHXdAz3r6zmf2BS20bjAje6hexqvNiTBLYiLIv/BVIYV85BP3/mEkbJSBNy84k3Tr83AerQvr/DTu+IckjZZca8KeZIcWViTTHdMu+uwMvxZolYEvVec3NaoZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GN6l3J/62JhvCcbrfRYH61xtNJAHzaqFkabL6zhOEY=;
 b=oI5epPH9FltSaMj3JiD1GZFxDFJKeOX2W9CqzuYiWU13moHVb/fc9gPcQlyWGqRjV8hN8VOmSiYFN9ScV7PD0IA4WM/Df3J/fq2DLUsyH842Ou4kqBuxG2VudKB3i1hGxVch9GDff03rZx8nNncMA4GM+Wo+dj1GqHzNBK2Gxf908cjJU9ji7/6OnbVjyk48RySB288KavvvHqm/YXsq6cNym22L3wpBcODueDawPW6QLfO166719szl2TUJJxMNz6q+HuPGYHanU+cAOTnjv3SuqJ8tmsIhL/msAJ4noCMs8z9G4WpiD60tRanMNgzzzn5q64DKr+4DInmBEcb3gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 05:51:19 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 05:51:19 +0000
Date: Thu, 27 Mar 2025 07:51:13 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: dev@dpdk.org, dsosnowski@nvidia.com, harry.van.haaren@intel.com, 
 igootorov@gmail.com, mkashani@nvidia.com, stephen@networkplumber.org, 
 thomas@monjalon.net
Subject: Re: [PATCH v4] rust: support raw DPDK API
In-Reply-To: <Z9711_x0IBYetdZR@bricha3-mobl1.ger.corp.intel.com>
Message-ID: <f921f0c1-a27a-3294-69a9-829f2f916d@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250322105911.12378-1-getelson@nvidia.com>
 <Z9711_x0IBYetdZR@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: ca13036a-df45-41c5-d26d-08dd6cf3652d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J1UWmQwpR8e4GnAQ2q+a53JO3rWeQb5EENknOpmA9dDp7s9T0ZxgPOuzpbf5?=
 =?us-ascii?Q?slmphjsA7xfsiAG+7tGV3g3on4jNN/8o7ETIvy0LMTiUDP4fVdiNASPn0t48?=
 =?us-ascii?Q?URm6IWyP7/J0Y518qb11M4yUeBg9LucYIoOnX+ZdtBuTctN0ytGG/bUfcFGH?=
 =?us-ascii?Q?5SU1RNxCIROOJDOpMDfGonyw9/jZdkddlcxL/FFR3T0c62dsep4t1E6pRivM?=
 =?us-ascii?Q?XsGGHPt7DL6d8jlcMGeniG6zgctcpceppMZqUAmRrwL6ApQSbWM/p9a44OCW?=
 =?us-ascii?Q?u402GVvm4MoxnCH1zXzr3WPUEiHv17qG5i7Ibvk5lCrr5310xphHyrht0ppQ?=
 =?us-ascii?Q?X4qF4match0ru0WSVggRsJE49CLkb1GSAYQJygs8TDTHT7ODUWmuiPOB1y9c?=
 =?us-ascii?Q?se/verUDhEeHfhD93jdtickmsYAk42ifR2xvZmTQGMrmxdIdZKT/+blBS9W7?=
 =?us-ascii?Q?BR3OEmzPZ9vRGpGzM7WnJ3SlS8S8VNAmKduf3SgYfQS5oE1Y3qc2t6q0wjzw?=
 =?us-ascii?Q?R5AmrKs4uj0yOcqGl/KTitoljnRxa0pWthiCmbkpClUx15UB+5pYjW/pONoH?=
 =?us-ascii?Q?K37kkmd7/4xfD8eQKRDzM48VFWPR7fNBKkrSbekz5xW33davnWTXMdQvgDnD?=
 =?us-ascii?Q?N5o2oJrCUPom3vIbu9sT68IqR2fkDBbKk3tktPuyUKPI1UCKG8ffnwX4h1Z/?=
 =?us-ascii?Q?lhALjccxrCs3dAJWgC+yisMfqThgu3I4hd1BhKQqY9iCAAbCJVcORCcVIPZW?=
 =?us-ascii?Q?wFxrBQ0mkklJ+dl+CJMVHB/1GXuIosiNY9wOtspMECyHDlwWQykLkP1qvgSN?=
 =?us-ascii?Q?y5WzVvbSmDtcxE/rm0NSxtuALQqaG+rTzmowcGJEYXQg85qWEuuyM3xME37g?=
 =?us-ascii?Q?T/RuYD7vjqSSOAPWN1MUeqi1dqCzOLEOoky0uLuEPdc79NBW3bVkMHe9v4sB?=
 =?us-ascii?Q?CTo0l/ThrlATGsWIVW/B1ZquA3YpJqwmgT4PwRm/vki/+vIrDkXwEaTiaQAs?=
 =?us-ascii?Q?J5mX1dXlnEssMw0V0tS6NfLYVUZ4C1OkX5SCGiGDHwTmRj05aSbC56JEflmr?=
 =?us-ascii?Q?k44zMJmRHms5gZ63kiadI0lVNqZHMOurOElby7BVU4SG+C8RnGXgMa89i6Jc?=
 =?us-ascii?Q?pE4iIjTsMIy7nZLud1znoh5kjCFg1Joy0sjSqDrHvXKvWNTpEEzj4LrgykaX?=
 =?us-ascii?Q?V6UDv05+HOg4/N74TIJkDHHZPl4UJtuSYBQTYu0Cp80c+/2+XGXMnjb4xGTs?=
 =?us-ascii?Q?3iwyL+ybrsW4gaMs550emoODszL2Fr/O+ZA+IJwXo4Yu3XTI1Xbe2v5zwLa1?=
 =?us-ascii?Q?zi4u8N+N4ULLMy+xh8VDgSRKwxvPk7r25zai17cfgI1O1KrJ2ThAX1gJl15O?=
 =?us-ascii?Q?P0T4qSfX62TUfx3DDZ+Zh9wGFE5U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8r1S47QrlwRRHfOSjVm/ZPKhMfJ7uY0s2E/h0w9rK/1U3BG9nXZE2PUUyJex?=
 =?us-ascii?Q?slZlKbc3Qmho+yWuvYJ9SnW3XtHppO33dSoYHP1dgASqZfNj5vfS9Pr/jxnf?=
 =?us-ascii?Q?LsiLHU86PMOfyRGZwZnQq/xSBhMjIcz9ytWme3L5onJgRsckWf5BN3t9DrvW?=
 =?us-ascii?Q?6BppEQyL/hzruGOOBujaGHeJIWECbVv8HpcahaV5GhsR+MndJ3hZ+dtpKCQT?=
 =?us-ascii?Q?naIp+PLJI2GYaLIFJYmdrfVjQUIqi3X+VrkNGSiTVbfqJZ7jfStTcY6uv/RW?=
 =?us-ascii?Q?HTZqmk3D5tYcr24M/nUMynpRKm0uX5YXX8jWk5Icq01Z52gjQeNY+aKFts4o?=
 =?us-ascii?Q?AMVWCFgJbvT+JSZdI0d3Z/GquNmXHKAJusQ9bMWrnQx4osl94Csdi6vd9o/X?=
 =?us-ascii?Q?Y2SjNzUX7+HUKgBQtsAO0QdoTOAZc+iT4D2gVGOLzOVTCB6EDzH172kXvMHi?=
 =?us-ascii?Q?00TxvoM3E1KVzUbEKXyWuvZOi8b26uviMCUCXRnJkaBkE36Rj3ypBUDs6gEY?=
 =?us-ascii?Q?Wzmdw0GZ7Z/feRaj4W0zd8CbGHBK9c2HjeohRPy6EZTeeiR+gKaoMTLmR4Ey?=
 =?us-ascii?Q?/N8+PolxVP6cvSh+2ztisAkiTGNsyo+jBx+zk3d2xtdtTPthlpHpw3qTVQBB?=
 =?us-ascii?Q?Nhahcoo+prKD9wROHq4Hi9P0lz5RGokXYRLBP2EpLVd8lOQCqXmomQsOdu1k?=
 =?us-ascii?Q?jXn1VRkv8LhfYvYVzmE5U2J+IlmUkoloFEUZDnR2VJfCZsfz34S8PkZIo9t0?=
 =?us-ascii?Q?5VB32VAfocf11bvMMvkJj0fOkvcbFg/fRhzunW9lO9zSadDB20Pie63yYLZh?=
 =?us-ascii?Q?WDrEUHx6HQx17JM5TCI8QL4LshwThKc2bR3Ud+UAsVao1yt2mc4POG4VfqyQ?=
 =?us-ascii?Q?QggY+njQUvMWezYJJ6y+NnYVlb/gdgakJBULNFkynpnW29+qs0SdfLvsiIO2?=
 =?us-ascii?Q?xDqYN1fMFGyovWDCdoxNbN3Q22WZsruMGOoQc+l103CqHkm1q6CKac1BCeQG?=
 =?us-ascii?Q?maODQI9pJoEAx2s6QhUEQTFbSM53B6YJskGrOCM1CL87VLLVi1X+Q42eteAQ?=
 =?us-ascii?Q?15yiyPlsRl1Pvbrvo+LjlrUiAQ7j5GnXNwYqPAjaG3LRM+j6rhZn6dXGucwN?=
 =?us-ascii?Q?IHy4g6OUUT4RQkn3u/HgvRSnSLolhkK3fID4GRtD841OX+piuhZQ/f3wOI/J?=
 =?us-ascii?Q?vDfUNE92q6C8Rsv+WQdQPQMpQTZOzGQ/K77eJy4Ml19I8Ngqm+Bz5qlE7HiU?=
 =?us-ascii?Q?S8JSm/LHNjVBq3No0d7FxfTkF5U9XWIRcF73W63RRf9HH/BGG8Z4JTKx/XEy?=
 =?us-ascii?Q?51xcxUBtoADQbzYkSAdH3fvIskX+dJbSswCls8L3kenRruDE35526h5/1whj?=
 =?us-ascii?Q?oeS/DMIXr/5a9cTV4iWfaIw1iIIGYYv39rwMRH0qk2B/1cjGqq3byIgO6SmT?=
 =?us-ascii?Q?aks/pG1lA7yJtJdQhiRB1gsBKpQjbmZ6jXI4MmjCAjbA04Ftr2HJmeC4a32d?=
 =?us-ascii?Q?hbgAa/OKcR+sJP3u6eV5W+yKupbb/TA6tsWQr6Zz2yyoN0aL9Fk77mpXjs/M?=
 =?us-ascii?Q?6wKScZ+O5FUm9h492B2JVyfD5hSM9kq27n7VBVfk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca13036a-df45-41c5-d26d-08dd6cf3652d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 05:51:19.2441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKpQCg4bbrTHx6wVcbOfgSYDfX3bTGkDgmo0l1qcJVuTDdXuXs5KnwoH4aW9ghOzS9WUOQfj9bN0w7ItJM2IRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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

Hello Bruce,

> Hi Gregory, some high-level feedback:
>
> * I'd suggest for future revisions splitting this into two patches. The rust
> example should be separate from a patch adding the basic rust
> infrastructure.

In progress.

>
> * For the example, I'd suggest that the helloworld rust example should
> correspond to the regular "C" helloworld example, i.e just init DPDK and
> print helloworld. If we want a basic packet handling example, it should be
> an l2fwd one - again to align with the "C" examples.

The next patch update will not include that example.

>
> * However, in terms of the examples, if the idea is to provide higher level
> "rustic" APIs for DPDK, the examples should be written to use that. Any use
> of the low-level C APIs should be in a testing app only, rather than an example
> app. IMHO We want to encourage proper rust usage, not C-code just rewritten to
> use a different compiler.

This project, in its current stage, is a bit of an experiment.
I'm trying to figure out how much effort it will take to provide DPDK API for 
Rust application.
Rust API is the final goal.

Regards,
Gregory
