Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA362C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 18:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0040840E36;
	Fri,  7 Mar 2025 19:00:59 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by mails.dpdk.org (Postfix) with ESMTP id 2598B40E34
 for <dev@dpdk.org>; Fri,  7 Mar 2025 19:00:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQEW7z4tFIDyzMYL0ZH6RNSTTGyodNmvELCiPzjadqqm538bctNQouUjIjF2ZUgap9IXgxN3Ngf1+yqjuwzlcS9szUz9DJroMPPoPBdgqgM6fl4Vtj/0luI1HZx8zM5sv9IU0DOm1s2fBqsSz+NLwnsuNLF8pHcWkt4V8D9+iUo7Rsi0kJhx2N1zbd+zaehM9eXb9jGVGFiJsrOqnC5X/BtN1s9hYGcpTkB2ZBrYyWBorLoZLN/1puxBHi7aj/B/DiUNudqZNLqMTFHkjf+5Sr7LNGaKhHIegpEjMnXEgPAnCNIaFJPwotYzN6QzCp8qeLyO2jkQZmqsUL145GdFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b9aIUO2oaY1QAIhAz6chL6WM75w8cnlgYURJBCDPaw=;
 b=Xk9+3giBvwv41QyRO7ZVyBGJmwD9QEjE61HU/6F4de57BEpVCKL8zkVqEF0MDPjtHhacbsyMN1VTILlP3pBID96PaOemplIcRigsiLcbPhzThreRI5jkqa1IDtnLv4S1ChdC/jFDA8egk1PGRvd+GZGzLJhmm8nw79T3e0GNfGOEGiK9hQP4xXWBmyr0NT5SVBL6xTyYPW+UzusMzSi1QdC1JWHCQlglrlaO2PqDyoV5QexKqUqgb3MI7hYEagSXfKBHeP8a6FqTtJ8/vqAFDo0ZdvgZqCeMu8zKWag4D368GC8Igoq/FqlO6r+7rnF3vLRhiGY2jZlZcCQR0XTVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b9aIUO2oaY1QAIhAz6chL6WM75w8cnlgYURJBCDPaw=;
 b=YEwvp9gtWOMQuk24yfUmhrmJwcj6epeZs9S7UBkmULCaSIYSzy27MdJpIpEts23Kq4bepWF9npYF0MDd/hmnqwRlPjGYrTQd+9lmP3xdGleypPvKw5EtbMIK0dBzAfEnAM0CdBqbej0QCQvpvYcwEn8s3r8agyjlHgP6mJhvr5Mn5I4FWTvirVSzUC15R2HDTmifsJDZxuvLMbLA2MllN4vTRpnQ76iDnZv5WhoobQjAy4Gg9txt3plT0Y5tuk6NclTJVVJj24rLF0+TEHCVneOBTUbnpsfk+GR/VmMfr0nnPnvD1cTCivhnX5wChUAxn9dNV8Mzi8RgckOMfmxvkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 18:00:53 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 18:00:53 +0000
Date: Fri, 7 Mar 2025 20:00:48 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "mkashani@nvidia.com" <mkashani@nvidia.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <733587d3-d391-5728-ff46-c365c3428618@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4ebb7d-d035-4192-930a-08dd5da2008b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITiPOLEaGkWT+xwzO/i1RrqWJI/7T/ErN45JU4tTi68e3QSjKRSg6gnT4k/0?=
 =?us-ascii?Q?VatcwqsKGOaw+Of1LFHLb/iVKcs0Ioo/0YSQ/2RFw/Z9pye7ntoDdFttrexL?=
 =?us-ascii?Q?Y6nvVpaNIuh2BgLLXQ5H1+m1CcaZ+tWQ8rY/pO63hDbm6StZOrNnYUyT+b9j?=
 =?us-ascii?Q?4WFCEV9MRN2QzAeJpF+TZmkrWPEGWUVCZ4D94zLPVhPCVcenlGveVxMyriSk?=
 =?us-ascii?Q?Z2ci7CrV5EZTtKi4LF4oIWoN3bcgg3+nT9h1XlBXiGW5JANZZtPO7l7mlsnJ?=
 =?us-ascii?Q?yA2ybtTnHpKPU2wqFRsP90B7l960HtPIf4xmJYLyjVjhN7z3O9dLoHZjUjGa?=
 =?us-ascii?Q?fJD8oed46gc5UnkBrc48fXtaoPogY/YrerIs0IqGkXVvdARtj/u45sy/cBIc?=
 =?us-ascii?Q?4lqLpklQHTmy5/FaSBiDl+fBGRGPbkk6dwUblwNh6WQULU0Wo1N8nCkQBieb?=
 =?us-ascii?Q?uD8ei/LtsOIV+df1olZKbL8DdWQBm24Y4enkkJpfASi9MzL3f1OVuUQr9CD0?=
 =?us-ascii?Q?D6OLWPj54+370Vz6JfVloZcl8Jke7EstDluKhQjFSoS2GeBCZLoAhb5UcDVW?=
 =?us-ascii?Q?K4E9oPvr/vabY0nTbgzdgSXOon2qiyc+ri3oAbU5OHvxHsCWGO0CyQc3K+PI?=
 =?us-ascii?Q?JQSGO5E/bxs6FUAxDzbqjhH9wU+j1C92MXqadggjpQwFsn82Vq/nzpfmnKSv?=
 =?us-ascii?Q?QeESumW7XwHaPZQgI0Dy17esp8n/l/xtGLvs5RYkrhHFG/iUVKEXqiU8EXEi?=
 =?us-ascii?Q?8DvrCF1v4QI0e1gjsvFe3UIxZwpJCWeRV34rN9mHjeEacWHYzUmYq60FudoM?=
 =?us-ascii?Q?zAVbCPVgMK5GtvaPGYfKt3dYQ/nTbriwpTcwJ7qK0obPFrHTNmdZ0kAE/jNl?=
 =?us-ascii?Q?l3uFDvqLQ6lNYJm4yqkJvPee+LulQ+yb9+aAxUKKeoG0D6yYyAzmbQb/iHYb?=
 =?us-ascii?Q?oo7ZPr9nSA48C3zW1SNhhd6HJpNCCZyGbVE7ws4rCu84E+CB8PFbJrGgA5rb?=
 =?us-ascii?Q?qm/3uG/8L7zJnMo61YIOWJhQrbofH5sloosK9sH4obSLzTY2oBgIfaIHC3hI?=
 =?us-ascii?Q?j3if/BIrAT5kVgK2+TFdWQg51KajWD+oUQtAv+m+ylvLcvdzNbBCyi9S/o9z?=
 =?us-ascii?Q?nRciSwUfJz75+K8Q05JaSEKs3sbkbcXD1+OIlJ8PKVibWfdetwFJrnRQilJj?=
 =?us-ascii?Q?7VvTfklRybyYF2WruxnPPzfpl8qXzoOvxr++5OPBxd2oIk69tAPppH5sG2En?=
 =?us-ascii?Q?UaSFdG209+kLTKLTSQ95Or1idRsM1R3dWzE0r7yFNm2WmikNuIqZfJ51FCfa?=
 =?us-ascii?Q?gxNoC+wZ8IexaNPcx0qFp4ieJyQlpWoOgpbIMTjMftfGO6hFdQBRD7STi/AM?=
 =?us-ascii?Q?Jyol+Zu/ueeq/VBHcHIkhL4cckh+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+wlai/QX1cuiAKRuTAaEttBjnjdQYo8AIKCkdQGjEY2g/I0r1XSCppuexlAf?=
 =?us-ascii?Q?J7YL0M1yDO9kh05Ei+EcuWDNiO1TTYEJiKM5s4nqZjKyl6LdHdsqVGgf4KB3?=
 =?us-ascii?Q?c7cJOEXjALColemVU1K68BqDpL1Mzc6TTvoAR6ILYZ3MTXjRUpE69iWZKUA3?=
 =?us-ascii?Q?IjoS3DwKdkhxRZR+gGNQyEUbattTE0UZ9fKHj+HnAJzX4np4BTo+gVCYNB2j?=
 =?us-ascii?Q?3jJ6bxufBuyhfZgIYtfzsIbWEzHxMk04WDnxs1Fp0QSObjZmL7NEdOmQOQmK?=
 =?us-ascii?Q?I6IgyrdevFMbh8Tlda8w5bSy18XSseR6hXTuPlNgXUR+oSbmUAq2f3AqLyaK?=
 =?us-ascii?Q?4rmE5iDV3SQkHBZxa3itsu2pkni41/6qDmfxznr2K1sw5Hypd+unhaPqMVos?=
 =?us-ascii?Q?8+yFTG5puUJg4/M9wWgG2/hgSIymGPCPy/zRGMWp6Y1IYndMRb2m9EyNYi0k?=
 =?us-ascii?Q?yTk5sthB2zyF6ebrB5nrCa9lRgF3G0cjq51P3FCMx5Z4w9BJ87vHn1IcpYX8?=
 =?us-ascii?Q?ABCYb7dbX5H8GeFh58E6n+7jX3/L+YGXLivR7RVjRoO44xuo5aq3G/Uuv8Zf?=
 =?us-ascii?Q?ycqSEiR3WAJeoGtc7qAIrn5xAoZdjXOXDV0zgH1VRioWlLVyLzZ4Ji+JtZBq?=
 =?us-ascii?Q?qO63eQ2+KNAGqlMBJxInQQrViqQmTzN8beZsQ0xYmBmT0UtcnH3RsRABTHyj?=
 =?us-ascii?Q?6heM31kzvEH8jexn1esAN4EThgbmcPpDVaZnBhoQFf8AnHQAiLEQdioV72rs?=
 =?us-ascii?Q?lVJb/EZOEjVzuuXUfuBuEwXTi0Ihx92T7cE06H0hrPEQji4zN4M2YgqiTbMU?=
 =?us-ascii?Q?rFYzq7QvsQb1jGrIjO3103M7zvtg0MNOjr4DQsiCekYjOufEuPENaJueyIm9?=
 =?us-ascii?Q?mcjwgNuP0T3Bzl2QVdqhie0oPSl+v2XQm11skK1ryRqdNv/9mrmUWmGAswoG?=
 =?us-ascii?Q?awULbohOk9Kp44AnoUNv1kMYC9t5KSKM+BiPun7I0JvVj8ae98q4HaTZ/6XQ?=
 =?us-ascii?Q?b0YvH6byqP9DtOxDroQDktYeqNFo761huuVt+V++fmQUYHNxEqoNdJ1H7MwI?=
 =?us-ascii?Q?2VVVNlTeUIuZZrgDFZlWFtaXqQnSdNmrIEQfdtDHxX+feluXWNdti4MyZdyK?=
 =?us-ascii?Q?v9HMz2kDvaBzj5yMz+v6cKIqrlJP9qsLjB0PKBQPtq8Ki8AadaY3PB1CwtXk?=
 =?us-ascii?Q?IF8JyPrHNxwO0hFjiwCHM5Cea/XikbNlinnmndJuTp+iSy/Rxpv19RgDK4vs?=
 =?us-ascii?Q?ESS31miwco/YdpvGT9Uvgxv+zlDyLRYjfyAYN0ysyHT628poc0Knt6cL35CA?=
 =?us-ascii?Q?cw3pF7Gea7H4uJHiXIz3zZsO0chwy8kw/KM+MROoOxMlXxvHuFbMxI1RaH/4?=
 =?us-ascii?Q?k876MRZHPuo0clt1Qqb9weYL/ZSzEJRNQcxCl2+Iq4USdBo0zxu+hnPiJzos?=
 =?us-ascii?Q?tjrnNBtiK0O+1MuPJY7P4fn6JqH8yts5PgKsBZ6CvOJM8z2pH3he7Uwj1meG?=
 =?us-ascii?Q?Ge6lnLxXXgmm9EEO6pnNKLJ60yavFqGMK3tVoVDLLpRzz2WfoH3sNlOLvJVB?=
 =?us-ascii?Q?pXky/NA1bYJzgytFzS84wY6IFu2yNuhmVNmNJjZW8XkTmXV6UGUG5XjchHM9?=
 =?us-ascii?Q?rbPJi0je8iEJWlGcyOhF/cW4pcXRtmbCiMXPt3HS2Qi+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ebb7d-d035-4192-930a-08dd5da2008b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:00:53.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac9W23vTEIdJ+Wt3pTI1g40U+mz8gJtfSWtkaDZQtznqfx4DQ55YrCadd/BQebmsB+NHLheZgSZ24gm+k7d/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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



On Fri, 7 Mar 2025, Van Haaren, Harry wrote:

> External email: Use caution opening links or attachments
>
>
>> From: Gregory Etelson <getelson@nvidia.com>
>> Sent: Thursday, March 6, 2025 1:37 PM
>> To: dev@dpdk.org <dev@dpdk.org>
>> Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bruce <bruce.richardson@intel.com>
>> Subject: [PATCH] rust: support DPDK API
>
> More in-depth review in this reply..
>
>> The patch converts include files with DPDK API to RUST and binds new
>> RUST API files info dpdklib package.
>>
>> The RUST dpdklib files and DPDK libraries build from C sources
>> allow creation of DPDK application in RUST.
>>
>> RUST DPDK application must specify the `dpdklib` package as
>> dependency in Cargo.toml file.
>>
>> RUST `dpdklib` package is installed into
>> MESON_INSTALL_DESTDIR_PREFIX/rust directory.
>>
>> Software requirements:
>> - clang
>> - RUST installation
>> - bindgen-cli crate
>>
>> RUST dpdklib installation instructions:
>> 1. Configure DPDK with `-Deanble_rust=true`
>> 2. Build and install DPDK. The installation procedure will create
>>    MESON_INSTALL_DESTDIR_PREFIX/rust directory.
>> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
>
> I've tested these instructions, using the default prefix = "/usr/local"
> This puts the rust files in "/usr/local/rust", so some tidy-up required.
> Debugging (or "searching for the files" was difficult - perhaps a log of
> the bindgen output from "rust-env.sh" would be helpful for 1st time setup?)

RUST installation directory is kind of open issue.
The current patch installs RUST crate during DPDK installation.
RUST environment can be undefined at that time.
Maybe it's better to install the crate with a dedicated meson command.

>
>
>> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
>> ---
>>  buildtools/meson.build               |   4 +
>>  buildtools/rust-env.sh               |  78 +++++++++++
>>  examples/rust/helloworld/Cargo.lock  |  14 ++
>>  examples/rust/helloworld/Cargo.toml  |   7 +
>>  examples/rust/helloworld/build.rs    |  21 +++
>>  examples/rust/helloworld/src/main.rs | 197 +++++++++++++++++++++++++++
>>  meson_options.txt                    |   2 +
>>  7 files changed, 323 insertions(+)
>>  create mode 100755 buildtools/rust-env.sh
>>  create mode 100644 examples/rust/helloworld/Cargo.lock
>>  create mode 100644 examples/rust/helloworld/Cargo.toml
>>  create mode 100644 examples/rust/helloworld/build.rs
>>  create mode 100644 examples/rust/helloworld/src/main.rs
>>
>> diff --git a/buildtools/meson.build b/buildtools/meson.build
>> index 4e2c1217a2..dd16567f51 100644
>> --- a/buildtools/meson.build
>> +++ b/buildtools/meson.build
>> @@ -50,3 +50,7 @@ else
>>      pmdinfo += 'ar'
>>      pmdinfogen += 'elf'
>>  endif
>> +
>> +if get_option('enable_rust')
>> +    meson.add_install_script('rust-env.sh')
>> +endif
>> diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
>> new file mode 100755
>> index 0000000000..705bc0d95b
>> --- /dev/null
>> +++ b/buildtools/rust-env.sh
>> @@ -0,0 +1,78 @@
>> +#! /bin/sh
>> +
>> +# Convert DPDK API files into RUST.
>> +# DPDK files selection is on demand.
>> +#
>> +# The coversion is done in 4 stages:
>> +# 1. Preparation [Optional]
>> +#    Due to the bindgen conversion utility limitations source file may need
>> +#    manual adjustment.
>> +# 2. Preprocessing [Mandatory]
>> +#    Run preprocessor on a source file before conversion.
>> +# 3. Conversion [Mandatory]
>> +#    Convert preprocessed C file into RUST file
>> +# 4. Post translation [Optional]
>> +#    Manually fix translation.
>> +
>> +# DPDK files list
>> +files='
>> +rte_build_config.h
>> +rte_eal.h
>> +rte_ethdev.h
>> +rte_mbuf.h
>> +rte_mbuf_core.h
>> +rte_mempool.h
>> +'
>> +
>> +rust_dir="${MESON_INSTALL_DESTDIR_PREFIX}/rust"
>
> Here "rust_dir"="/usr/local/rust" if the default prefix is used.
> At least, a "dpdk" must be in there somewhere (we're not Rust itself after all!)
> but also different systems put files in e.g: "/usr/local/lib/x86_64-linux-gnu/dpdk"
>
> Appending a "/rust" to the end of that is probably what was intended?

Same as above.

>
>
>> +include_dir="${MESON_INSTALL_DESTDIR_PREFIX}/include"
>> +
>> +if test -d "$rust_dir"; then
>> +  rm -rf "$rust_dir"
>> +fi
>> +
>> +mkdir -p "$rust_dir/src"
>> +if ! test -d "$rust_dir"; then
>> +  echo "failed to create Rust library $rust_dir"
>> +  exit 255
>> +fi
>> +touch "$rust_dir/src/lib.rs"
>> +
>> +bindgen_opt='--no-layout-tests --no-derive-debug'
>> +bindgen_clang_opt='-Wno-unused-command-line-argument'
>> +
>> +create_rust_lib ()
>> +{
>> +  base=$1
>> +
>> +  cp $include_dir/${base}.h /tmp/${base}.h
>> +
>> +# bindgen cannot process complex macro definitions
>> +# manually simplify macros before conversion
>> +  sed -i -e 's/RTE_BIT64(\([0-9]*\))/(1UL << \1)/g' /tmp/${base}.h
>> +  sed -i -e 's/RTE_BIT32(\([0-9]*\))/(1U << \1)/g' /tmp/${base}.h
>> +  sed -i -e 's/UINT64_C(\([0-9]*\))/\1/g' /tmp/${base}.h
>> +
>> +  # clang output has better integration with bindgen than GCC
>> +  clang -E -dD -I$include_dir /tmp/${base}.h > /tmp/$base.i
>
> # Adding this helps debug the header conversion & output file locations
> echo "writing Rust converted header to ${rust_dir}/src/${base}.rs"

Meson add_install_script() dumps shell output.

>
>> +  bindgen $bindgen_opt --output $rust_dir/src/$base.rs /tmp/$base.i -- $bindgen_clang_opt
>> +  rm -f /tmp/$base.i /tmp/$base.h
>> +}
>> +
>> +for file in $files; do
>> +  base=$(basename $file | cut -d. -f 1)
>> +  create_rust_lib $base
>> +  echo "pub mod $base;" >> "$rust_dir/src/lib.rs"
>> +done
>> +
>> +
>> +cat > "$rust_dir/Cargo.toml" <<EOF
>> +[package]
>> +name = "dpdklib"
>> +version = "$(cat $MESON_SOURCE_ROOT/VERSION | sed 's/\.0\([1-9]\)/\.\1/')"
>
> Missing {} brackets around MESON_SOURCE_ROOT perhaps? Got an error on "/VERSION" not found.
>

I'll fix that.

>> +EOF
>> +
>> +# post conversion updates
>> +# RUST does not accept aligned structures into packed structure.
>> +# TODO: fix DPDK definitions.
>> +sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/rte_ethdev.rs"
>
> Hmm, interesting, lets keep a TODO here, but as this changes the "allowable" or valid binary layouts,
> it is potentially going to cause differences between C and Rust's interpretation of the memory backing the structs.
> TODO: investigate each struct individually, and determine if/what is really required/correct.
>

There was no actual violation in this case because network headers definitions 
were properly aligned.
C compiler ether ignored it or managed to figure it out.
RUST does not allow to mix align() and packed() in general.
Adjusting C file will not change structures layout and reduce post-bindgen 
corrections. Hence the TODO.

>
>> diff --git a/examples/rust/helloworld/Cargo.lock b/examples/rust/helloworld/Cargo.lock
>> new file mode 100644
>> index 0000000000..d18af80c66
>> --- /dev/null
>> +++ b/examples/rust/helloworld/Cargo.lock
>> @@ -0,0 +1,14 @@
>> +# This file is automatically @generated by Cargo.
>> +# It is not intended for manual editing.
>> +version = 4
>> +
>> +[[package]]
>> +name = "dpdklib"
>> +version = "25.3.0-rc1"
>> +
>> +[[package]]
>> +name = "helloworld"
>> +version = "0.1.0"
>> +dependencies = [
>> + "dpdklib",
>> +]
>> diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/helloworld/Cargo.toml
>> new file mode 100644
>> index 0000000000..7f9a77968a
>> --- /dev/null
>> +++ b/examples/rust/helloworld/Cargo.toml
>> @@ -0,0 +1,7 @@
>> +[package]
>> +name = "helloworld"
>> +version = "0.1.0"
>> +edition = "2024"
>> +
>> +[dependencies]
>> +dpdklib = {path = "MESON_INSTALL_DESTDIR_PREFIX/rust"}
>> \ No newline at end of file
>
> Above Cargo.toml looks normal. Perhaps we could suggest/provide a method where
> DPDK does not need to be "ninja install"-ed, but instead process a local directory?
> That would likely make it easier to locally build/test Rust bindings.
>

Agree. RUST crate should have a dedicated installation command.


>> diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld/build.rs
>> new file mode 100644
>> index 0000000000..5c76188e18
>> --- /dev/null
>> +++ b/examples/rust/helloworld/build.rs
>> @@ -0,0 +1,21 @@
>> +use std::process::Command;
>> +
>> +pub fn main() {
>> +    let mut pkgconfig = Command::new("pkg-config");
>> +
>> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {
>> +        Ok (output) => {
>> +            let stdout = String::from_utf8_lossy(&output.stdout).trim_end().to_string();
>> +            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
>> +                if token.starts_with("-L") {
>> +                    println!("cargo::rustc-link-search=native={}", &token[2..]);
>> +                } else if token.starts_with("-l") {
>> +                    println!("cargo::rustc-link-lib={}", &token[2..]);
>> +                }
>> +            }
>> +        }
>> +        Err(error) => {
>> +            panic!("failed to read libdpdk package: {:?}", error);
>> +        }
>> +    }
>> +}
>
> Could a simple "probe()" like below replace the more complex logic? I've linked DPDK in the
> past using this more boring method.. or is there a reason that the link-search-native and
> link-lib parts have to be handled manually? Doing a Command::new() is hacky, nice to remove it if possible!
>
> if let Err(e) = pkg_config::Config::new().probe("libdpdk") {
>    panic!("libdpdk probe failed: {e:?}");
> }
>
> The build.rs file itself also needs a "rebuild if self changed" line:
>  println!("cargo:rerun-if-changed=build.rs");
>

I'll fix that.

>> diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/helloworld/src/main.rs
>> new file mode 100644
>> index 0000000000..cf666aece6
>> --- /dev/null
>> +++ b/examples/rust/helloworld/src/main.rs
>> @@ -0,0 +1,197 @@
>> +/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...
>> +
>> +use std::env;
>> +use std::ffi::{CString};
>> +use std::os::raw::{c_int, c_char};
>> +use std::ffi::CStr;
>> +
>> +use dpdklib::rte_eal::{
>> +    // Functions
>> +    rte_eal_init,
>> +    rte_eal_cleanup,
>> +};
>> +
>> +use dpdklib::rte_ethdev::{
>
> As per first reply, I'd like to see the end-result safe-Rust namespacing be shortened.
>
> This can be easily done by renaming the name= in Cargo.toml, and
> removing the "rte_" prefix at bindgen output stage for each file.
> dpdk::ethdev:: { RTE_ETH_NAME_MAX_LEN, ... };
>
> Perhaps its a good method to put the generated (unsafe, raw-C-bindings) in this
> namespace, and build a safe crate (with the dpdk::ethdev::* namespacing) over it.
> Thoughts?
>

The idea was to provide generic DPDK API and let application to resolve unsafe 
interfaces.

>
>> +    RTE_ETH_NAME_MAX_LEN,
>> +    RTE_ETH_DEV_NO_OWNER,
>> +    RTE_ETH_RSS_IP,
>> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,
>> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,
>> +
>> +    // Structures
>> +    rte_eth_dev_info,
>> +    rte_eth_conf,
>> +    rte_eth_txconf,
>> +    rte_eth_rxconf,
>> +
>> +    // Functions
>> +    rte_eth_dev_get_name_by_port,
>> +    rte_eth_find_next_owned_by,
>> +    rte_eth_dev_info_get,
>> +    rte_eth_dev_configure,
>> +    rte_eth_tx_queue_setup,
>> +    rte_eth_rx_queue_setup,
>> +    rte_eth_dev_start,
>> +};
>> +
>> +use dpdklib::rte_build_config::{
>> +    RTE_MAX_ETHPORTS,
>> +};
>> +
>> +use dpdklib::rte_mbuf::{
>> +    rte_pktmbuf_pool_create,
>> +};
>> +
>> +use dpdklib::rte_mbuf_core::{
>> +    RTE_MBUF_DEFAULT_BUF_SIZE
>> +};
>> +
>> +pub type DpdkPort = u16;
>> +pub struct Port {
>> +    pub port_id:DpdkPort,
>> +    pub dev_info:rte_eth_dev_info,
>> +    pub dev_conf:rte_eth_conf,
>> +    pub rxq_num:u16,
>> +    pub txq_num:u16,
>> +}
>> +
>> +impl Port {
>> +    unsafe fn new(id:DpdkPort) -> Self {
>
> This is where the first manual code is wrapping C concepts into Rust.
> And the approach taken here is quite "C thinking", where it is possible
> to misuse an API, and hence "unsafe" is used for many functions (more below)
> and also for the C FFI function calls.
>
> I believe this part can be improved, and that there is big value in those improvements:
> Today the code is "C but compiled by the Rust compiler", the programmer has to use the APIs correctly.
>
> I'll send a patch in reply to this one for review, suggesting ways to improve.
> Future code goal: "Rust checks code: invalid code will not compile, or provide a clean error at runtime."
>
>

Agree. The RUST part is pretty dull here.
The idea was to show how DPDK API can be used from RUST application.

>
>> +        Port {
>> +            port_id:id,
>> +            dev_info: unsafe {
>> +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> = ::std::mem::MaybeUninit::zeroed().assume_init();
>> +                *uninit.as_ptr()
>> +            },
>> +            dev_conf: unsafe {
>> +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> = ::std::mem::MaybeUninit::zeroed().assume_init();
>> +                *uninit.as_ptr()
>> +            },
>> +            rxq_num:1,
>> +            txq_num:1,
>> +        }
>> +    }
>> +}
>> +
>> +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<Item=DpdkPort> {
>> +    let mut port_id:DpdkPort = 0 as DpdkPort;
>> +    std::iter::from_fn(move || {
>> +        let cur = port_id;
>> +        port_id = unsafe {
>> +            rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort
>> +        };
>> +        if port_id == RTE_MAX_ETHPORTS as DpdkPort {
>> +            return None
>> +        }
>> +        if cur == port_id { port_id += 1 }
>> +        Some(cur)
>> +    })
>> +}
>> +
>> +pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item=DpdkPort> {
>> +    unsafe {
>> +      iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64)
>> +    }
>> +}
>
> Cool - I like the egonomics idea of providing Iterator<DpdkPort>.
> The implementation here is unsafe, which is unfortunate, we'd like to
> ensure that all "end-user visible" Rust code is "safe Rust".
>
>
>> +pub unsafe fn init_port_config(port: &mut Port) {
>> +    let ret = unsafe {
>> +        rte_eth_dev_info_get(port.port_id, &mut port.dev_info as *mut rte_eth_dev_info)
>> +    };
>> +    if ret != 0 {
>> +        panic!("port-{}: failed to get dev info {ret}", port.port_id);
>> +    }
>> +
>> +    port.dev_conf.rx_adv_conf.rss_conf.rss_key = std::ptr::null_mut();
>> +    port.dev_conf.rx_adv_conf.rss_conf.rss_hf = if port.rxq_num > 1 {
>> +        RTE_ETH_RSS_IP as u64 & port.dev_info.flow_type_rss_offloads
>> +    } else {0};
>> +
>> +    if port.dev_conf.rx_adv_conf.rss_conf.rss_hf != 0 {
>> +        port.dev_conf.rxmode.mq_mode =
>> +            rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS & rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS;
>> +    }
>> +}
>> +
>> +pub unsafe fn show_ports_summary(ports: &Vec<Port>) {
>> +    let mut name_buf:[c_char;RTE_ETH_NAME_MAX_LEN as usize]= [0 as c_char;RTE_ETH_NAME_MAX_LEN as usize];
>> +    let title = format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Driver");
>> +    println!("{title}");
>> +    ports.iter().for_each(|p| unsafe {
>> +        let _rc = rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_mut_ptr());
>> +        let name = CStr::from_ptr(name_buf.as_ptr());
>> +        let drv = CStr::from_ptr(p.dev_info.driver_name);
>> +        let summary = format!("{:<4}    {:<32} {:<14}",
>> +                              p.port_id, name.to_str().unwrap(), drv.to_str().unwrap());
>> +        println!("{summary}");
>> +    });
>> +
>> +}
>
> There are some interesting changes of thoughts in Rust vs C, in how applications actually
> allocate or "own" data. The above show_ports_summary() function requires a &Vec<Port>.
> That demands that the backing storage for Port is a Vec<Port>, and a (immutable) reference
> is passed into this function. Hence the type is:
>    summary(ports: &Vec<Port>)
>
> There is no reason to "demand" that the application stores Ports in a Vec. While common to store things
> in Vec<T>, we have now demanded "more than required" from the application. In some situations
> (perhaps not 100% relevant here, but..) like embedded systems, where dynamic allocation isn't available
> there IS no Vec<T> available. In other application scenarios, perhaps a HashMap is better.
>
> The best way to do this in Rust is to use the Iterator trait, which doesn't require any specific
> "backing storage" (e.g. linear-data for 'slice' or Vec, or HashMap per-item allocated data, or ...).
> Instead the Iterator trait allows the function itself to iterate of the "Item". Example:
>
> pub fn show_ports_summary_iterator<'a>(ports: impl Iterator<Item = &'a Port>) {
>    ports.for_each(|p| { /* p is a &Port */);
> }
>
> There should be no unsafe required for the above debug print, and no statically sized C-string allocations.
> Instead of fetching the port name via C function at print-time, the Port::new() function can cache the value
> and convert it to a Rust String type - avoids unsafe {}, reduces scope of unsafe variables in the program.
>
>
>> +unsafe fn start_port(port:&mut Port) {
>> +    let mut rc = unsafe {
>> +      rte_eth_dev_configure(port.port_id, port.rxq_num, port.txq_num,
>> +                            &port.dev_conf as *const rte_eth_conf)
>> +    };
>> +    if rc != 0 { panic!("failed to configure port-{}: {rc}", port.port_id)}
>> +    println!("port-{} configured", port.port_id);
>> +
>> +    rc = unsafe {
>> +      rte_eth_tx_queue_setup(port.port_id, 0, 64, 0, 0 as *const rte_eth_txconf)
>> +    };
>> +    if rc != 0 { panic!("port-{}: failed to configure TX queue 0 {rc}", port.port_id)}
>> +    println!("port-{} configured TX queue 0", port.port_id);
>> +
>> +    let mbuf_pool_name = CString::new(format!("mbuf pool port-{}", port.port_id)).unwrap();
>> +    let mbuf_pool : *mut dpdklib::rte_mbuf::rte_mempool = unsafe {
>> +        rte_pktmbuf_pool_create(mbuf_pool_name.as_ptr(), 1024, 0, 0,
>> +                                RTE_MBUF_DEFAULT_BUF_SIZE as u16, 0)
>> +    };
>> +    if mbuf_pool  == 0 as *mut dpdklib::rte_mbuf::rte_mempool {
>> +        panic!("port-{}: failed to allocate mempool {rc}", port.port_id)
>> +    }
>> +    println!("port-{} mempool ready", port.port_id);
>> +
>> +    let mut rxq_conf:rte_eth_rxconf = port.dev_info.default_rxconf.clone();
>> +    rxq_conf.offloads = 0;
>> +    rc = unsafe {
>> +        rte_eth_rx_queue_setup(port.port_id, 0, 64, 0,
>> +                               &mut rxq_conf as *mut rte_eth_rxconf,
>> +                               mbuf_pool as *mut dpdklib::rte_ethdev::rte_mempool)
>> +    };
>> +    if rc != 0 { panic!("port-{}: failed to configure RX queue 0 {rc}", port.port_id)}
>> +    println!("port-{} configured RX queue 0", port.port_id);
>> +    rc = unsafe {
>> +        rte_eth_dev_start(port.port_id)
>> +    };
>> +    if rc != 0 { panic!("failed to start port-{}: {rc}", port.port_id)}
>> +    println!("port-{} started", port.port_id);
>> +}
>
> Similar concepts around reworking "unsafe" away as above, future discussion.
>
>> +fn main() {
>> +
>> +    let mut argv: Vec<*mut c_char> = env::args()
>> +        .map(|arg| CString::new(arg).unwrap().into_raw()).collect();
>> +
>> +    let rc = unsafe {
>> +        rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr())
>> +    };
>> +    if rc == -1 {
>> +        unsafe { rte_eal_cleanup(); }
>> +    }
>> +
>> +    let mut ports:Vec<Port> = vec![];
>> +    unsafe {
>> +        for port_id in iter_rte_eth_dev()
>> +            .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize) {
>> +            let mut port = Port::new(port_id);
>> +            init_port_config(&mut port);
>> +            println!("init port {port_id}");
>> +            start_port(&mut port);
>> +            ports.push(port);
>> +        }
>> +    }
>> +
>> +    unsafe { show_ports_summary(&ports); }
>> +
>> +    println!("Hello, world!");
>> +}
>
> Overall, I'm very happy to see this patch, I want to ensure folks on list hear that!
> The unsafe {} around each block of "do something" is not idiomatic Rust - we can improve that.
> The summary_iterator() function above can be called like a normal function:
>
> show_ports_summary_iterator(ports.iter());
>
>
>> diff --git a/meson_options.txt b/meson_options.txt
>> index e49b2fc089..d37b9ba1dc 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -60,3 +60,5 @@ option('tests', type: 'boolean', value: true, description:
>>         'build unit tests')
>>  option('use_hpet', type: 'boolean', value: false, description:
>>         'use HPET timer in EAL')
>> +option('enable_rust', type: 'boolean', value: false, description:
>> +       'enable RUST')
>> --
>> 2.45.2
>
> Great work, and looking forward to hearing about next-steps, and discussion on the above feedback.
>
> Regards! (& thanks for reading till the end.. this turned into a long response :) -Harry

:thumbs up:

