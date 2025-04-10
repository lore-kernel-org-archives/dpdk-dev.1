Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B0C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 05:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2B040609;
	Thu, 10 Apr 2025 07:28:41 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by mails.dpdk.org (Postfix) with ESMTP id 19EA0402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 07:28:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHOMCvJdzqKUh6auX1oWW2vDa77qI0cP0hKBWKvmpjP9KvpTXva6zsr8AqcCLzKzbSIurKHkQRWNg2FKGZFBeu24dlVzosI/E05Q7ywYhoaXL2ZHPx+XUYMqccwBiv8E48X8MKyUVv6RmbJ21V1SlFB4s4xsaChShgLg+WgfiGc8jZPw3Nl6Bk4nVaSi0gIn0zAJ5zFfAmgY6llP3SZxImdZWY+BzEt5wF5aYgg6eb5IdpMx4R7f5AUu9IMG00pgXa/d3ezKcWWZvj7Zpea6f6O+xDTjnKmzyt2skoRh8iL0VLa39qNOBA07ZrFc/8VVHv1TiDUqiBXhgjRJnjgRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvkKvcZSRmXS5ycKpHSFmwaf5pxW6JLOKq3ncqc6s+c=;
 b=mgO5N2yAIH22cIT2PgJevUFr1kItZq/UR88m0rApJ5WjH34JldeuEAxnLwz5U30mRBy95LHJNVophr2+guAn7TjZ6qBD5f3fLpvRF1dRYCLMoWhlFkVHw4PdA0vyIpWERFzRKVhA9aHJ1XcP0+XOX4eFVSj1NSpEsv+uTorCxZaYwRp6AChOYUxw83pos03++MxjB1fT7iHJrufFo9BB23tNAcGM6WxHiS8dOy423o5rIoz6vqgTHd0tfeVYdGpH0C92jicVeyg+ul0+jw0zXVvX9mdnBwrWoHNAQ9LKabeTnrAfowmUQLAuHQEF6nUpNleE/jFNldSky45qWOutPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvkKvcZSRmXS5ycKpHSFmwaf5pxW6JLOKq3ncqc6s+c=;
 b=AeKj0mzw9U3wXRIombl9FiPpxqbYQ2LhH0QDn6BAG0lhYryhoUe0TewCU2vPavr1mZx+wWLtwOLWWV7bh4RY/bf0siLtw+JYpM/Y0YgGuW7vaW2TnhRAazyF0+BtMeiM2Uzv6dVqaruyrbfPkPCqBldYJ+wkpuqD3Sin10ekHA3Y5RMAKJgwHQTUBZShPmj3j1owhP+cFIqoQUkzMYGjt8D6XWBPrK9MAKc1b1oPXmTHyiBnmMAqJZ33w6QozFGvqD2Cp20qxfsQpyBzYE28aO7Rv8/+YJNkUaJLsK8Fj60H9YxKKOvJii45VnVgeTY8eBXY6CtSBuwHYX+7iKIUZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 05:28:36 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%5]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 05:28:36 +0000
Date: Thu, 10 Apr 2025 08:28:32 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: dev@dpdk.org
Subject: Re: [RFC PATCH] add rust binding support to DPDK
In-Reply-To: <20250408145838.2501034-1-bruce.richardson@intel.com>
Message-ID: <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f63575-451f-4c57-62a7-08dd77f08aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V6quPMs+K9LCa3C/Yu9P1NIicWa/LVdqODhC4eBScyqfOmDUKd+knUPalx0k?=
 =?us-ascii?Q?l0q0J2fK1O0p4kQileJ1+ipHSQ9MUN947ZGj1fmRZxPjmma/fkrnF7xLCrbW?=
 =?us-ascii?Q?XsEzGeBDuk908G/z3C+1Ird/pb4X2jkuqE/W7CyRZicwTI46HvGZvkv+Yx/F?=
 =?us-ascii?Q?AGdwdgw7SqNTVudqGxT4vqvYzbfKt7juV66M4hv8ss+8jw74W+h+gTvTHT/l?=
 =?us-ascii?Q?PSOoG7hXCbvty9AzrXBXvYpN3jB1oGr8TzQFMSTQNor9benBWE2laDHqicS0?=
 =?us-ascii?Q?TDuiv/LyPryesYjyzxOZh6SDr5ud+Q7tr7sePNHqf7LMMSqJUjKzRDapF3mO?=
 =?us-ascii?Q?Zb2+vktpch1w8VOAwHC6fifF5wYaalH2mE+2ThE2su2NUHU1pwhpE0VHIIhM?=
 =?us-ascii?Q?/7gIvnRhe5mQVAskR+Hfh1oMidPUJ4sz1rrk7CjoraLJafPE6rm0ZxkzSXCj?=
 =?us-ascii?Q?gSygCK6j1y8c6cPFp1HDzvL+dLcyv727aAFU7clyP/1yeynTiHCKvSf190Fv?=
 =?us-ascii?Q?+3t2rp/QDpoZHYgh/1abEzl448AA32AXATLNhaFSGMgfHu5m1BxeyMVet2Ap?=
 =?us-ascii?Q?W694EqNzWot8T8WVAPTJyaWoxqHAaXy9l8/62YdT2JiYzsUq30itDLu2Ah4Z?=
 =?us-ascii?Q?ynuAp0wwLfURUqM4bSozpKhJUjVpX9bhUCrkhsbiXNvuplc5Zb22cI8JEV0j?=
 =?us-ascii?Q?1A8jKU+bJ/jGzgV9IzOGwJ16edQQDQLjTChTg53E56B7LDL64ObEHPgII7UU?=
 =?us-ascii?Q?TaJDLkdNV49YAVfTPSayAlZF/KJ4kpFrXGjYh+pTqvhFUeyT/ksO+EqI0rGB?=
 =?us-ascii?Q?hqTI72/IMhIqfSDk286TwRmzCGzuI5tl2KUYTrVNk+xdQpXUZBDe4dFaapN8?=
 =?us-ascii?Q?0iAjztPvSyPL9NNoT+xh+2Olg7DfibNkC4VcfPZjNBUiVUfEtmTeRFtTDDAT?=
 =?us-ascii?Q?dLegslunC9sFjRTvGIE2s2xOPhW0HmWg+UZD7polKBi8HKCOmZI080ljn/4F?=
 =?us-ascii?Q?/aY3o4l19QFc2ic3JtzqyzJLASVwOYaNLg1c3pkDpbcG0Ad92obQXpqGnfw6?=
 =?us-ascii?Q?wVRSC1NUe7Lx6I0y8oXGdWZogNyl8VCs/0IngysemymgYmb/7w/btQtFyq9u?=
 =?us-ascii?Q?JY+SJDL/5d6JgOhuKVpz7c+LccH9KrOQuwPAiqRPUg+eYqVBYD9S1RuuC4Yl?=
 =?us-ascii?Q?9Hu8fU1hOYbfxJyShNrUQtelWYNTmeb0ee7QhoUZapt2VzfYdGmPOIdW5UyF?=
 =?us-ascii?Q?veVH4BF4ZG4jA/lYnBiG2e+LAtZYrfjHVUg1IgjZEqdiBNVz/qGKn8qtu2vK?=
 =?us-ascii?Q?dLUjjdzMnT+YBs906OyNhvkd5O3ruQ9x8p1Uw1W+p6HkaHyJR9eI7VLLk2f3?=
 =?us-ascii?Q?S/Ygbu/YLwZRufrl8lvHW5J99el/bpDwOsBUbROvxsfv16GmYGbPR9tP0W+V?=
 =?us-ascii?Q?X+wBojLor7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WBywDx/6faGoeSMXKBjubUoBPD5khMktqvMLDzgLC96Fws5HrjSfDO2wp2q?=
 =?us-ascii?Q?RKccQcGT9pzF2H6DBNL30lrNhR6sAU2F8z5Tty7Lk/mpBSf/a4LVETDIg4Xs?=
 =?us-ascii?Q?MS9/44m9kMcuskUdls1UwcZyNOsg9KRDqYVzxM2AfzppY90QmoYps6GYPA8S?=
 =?us-ascii?Q?Ie1a8gLuhROgRlPKNEMvyzeu5kdi3dj3vb4RoqKZQTms6GFGKX1sP2udWk76?=
 =?us-ascii?Q?6FaeQ/4YW1ROWrS1aJyDfCwsSgl+fqzqdyY3mgM40pJ+1xt9dx9Hbf9Toojw?=
 =?us-ascii?Q?wRrcKlSIM4oQ0fqbHm8bSAq0y4YiIVySkNu1umLaQj02N17eMtwuZMRRO4jz?=
 =?us-ascii?Q?2yvP4F4Hg5bnquk8NQa1YDpFrzQDG+e/rHdWcp15bnqzrOkMT0j3M5qaxfrB?=
 =?us-ascii?Q?UrPHSeYh2Amc8sMaREy11Jmax2uE/Qw3d7WsfL8FcRgS8Gx8fSPHXHfzvPKB?=
 =?us-ascii?Q?ejmOEbS5Vd+bp18OSfgAMSCMJ6DEAqZHqx8nx4AL0z5JC/tPAzYPztvt+w/j?=
 =?us-ascii?Q?JG/S9+6H3H7zwexkfO/2C3U1aVHx8kkJJ8Yb8y4n31pUZ5B4YSQHlejGplgJ?=
 =?us-ascii?Q?9/FWNAIo6SsZJVeSR0oMmzJUlS0qWuFVfezacHtpW+kSFrVl+NZfnQNvPvFB?=
 =?us-ascii?Q?d84s/ENBoTfQD1HdSY4+3z6nf4DvYGGZqmBYcUF8vkULsDr4bCSP8EV9CrbA?=
 =?us-ascii?Q?lPhZPVTT8Etu5go4Go2i/w+QUV8ENt7aY6VmiHeBWJtgV961N34Ix8k9xFC5?=
 =?us-ascii?Q?66a/g4nQOJf1mxPo2Gs1eA41FE0grAanD7cN20RZOyDEgJlPVZZ+zrAMzbKd?=
 =?us-ascii?Q?wBb22FoDinpuJhShEesR5GMKztyWDUbhsoK8beXQv7eR2UEpU/1fJCGnIYea?=
 =?us-ascii?Q?QyQTI6u/QjMLnOaQn0+LZbD5XxBFrIbOcPivBKMMC2/3TovzbGyYho3q1z6S?=
 =?us-ascii?Q?iChFY87llkzBrrW5asg0wDwANiwaJYN3PEh98qlkYPMWmsZGQlS9NbgkPKgS?=
 =?us-ascii?Q?CzDtjPRI1PwxpUHuYR2pE6w9q9qf7CJNjd/w0zZjm0SGJOJN5nmvjV12DL6r?=
 =?us-ascii?Q?hSry3UpMwp4mc88vviUZ2zgWJK3/SnUJNq3UVQ9cc6hi7ZXlB8B/dSU7K+Xp?=
 =?us-ascii?Q?jquAhs2dOD0+SyYUg3eu8ADLXjWRweQn5MIfboBHWVQknBk4hTOYdmS8LHkW?=
 =?us-ascii?Q?n9E0n6RRpIgdi7zh89v+sJWX2tWFJbrsj3RRyekbBzTbD42Q5/MlqHOej87p?=
 =?us-ascii?Q?E7FiFl0LITEEJYGcz6/Ih8MDVjKJuSUsmEQFAMmqrM4W9Gl5Trq6HDWnmOKf?=
 =?us-ascii?Q?B5HbOSdx0LM0Su3ZvQvQxg9Brt0B6JEbxO0OZb0E8XXp+K8wor3W4KcQB9dZ?=
 =?us-ascii?Q?4u+APMoGWUSSRJO9O1BbmmVkCdeXHG0/Cy4SeERuh8O7wqzUC6Xnh0x+baET?=
 =?us-ascii?Q?9AmVQl/x0rAkqiLQHpKUSuTmGZWJPsD0ANs2zKww7NjMqxNL4dEJngyIPHDr?=
 =?us-ascii?Q?4wlcrrM2GRoYmH1BWrjX7fdla5BoRLo1I2rHnvBnapeyJGyXSeLCLXTmiOoH?=
 =?us-ascii?Q?HkgmuQnhymwgNt7LpCYNNTv1V27v7haD9UnpVXg2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f63575-451f-4c57-62a7-08dd77f08aba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 05:28:36.1603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+4/la6DU8MkU/9Lj7Kd4bKm6oI5dL9bly6VHO5gtgTzkM1hWK+90EIC+vnVWLeG8BXbb8/NpkjHRdYc2sEpDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

> Add a Cargo.toml file in the root folder and a number of other scripts
> and rust-related files into buildtools/rust, which then enables DPDK to
> be cloned and built as a rust crate - all-be-it one with only two
> functions: rte_eal_init and rte_eal_cleanup.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>
> This RFC is proposed as an alternative approach to enabling rust support
> in DPDK. The key difference vs previous is that we are taking the whole
> DPDK project here as a rust "crate", which can then be used by other
> higher-level crates as a dependency. Building the crate does a
> (minimal) build of DPDK and statically links it in, so there is no
> "install" step or anything needed - the Rust app just adds DPDK to their
> Cargo.toml file and then should have everything they need.
>

Having a shared source directory for both for C and Rust DPDK infrastructure is 
the correct approach.
My concern is how to properly maintain Rust crate once DPDK starts to implement
it's own API.
Rust files may need a separate directories to host libraries, applications 
and PMD.

> diff --git a/Cargo.toml b/Cargo.toml
> new file mode 100644
> index 0000000000..fe0843975a
> --- /dev/null
> +++ b/Cargo.toml
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Intel Corporation
> +
> +[package]
> +name = "dpdk-c"
> +version = "25.0.7"
> +build = "buildtools/rust/build.rs"
> +edition = "2021"
> +
> +[lib]
> +path = "buildtools/rust/lib.rs"
> +doctest = false
> +
> +[build-dependencies]
> +bindgen = "0.71"
> +meson-next = "1"
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 4e2c1217a2..a13b5189c1 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -26,6 +26,7 @@ header_gen_cmd = py3 + files('gen-header.py')
> has_hugepages_cmd = py3 + files('has-hugepages.py')
> cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
> check_dts_requirements = py3 + files('check-dts-requirements.py')
> +gen_cargo_bindgen_info = py3 + files('rust/gen-cargo-bindgen-info.py')
>
> # install any build tools that end-users might want also
> install_data([
> diff --git a/buildtools/rust/build.rs b/buildtools/rust/build.rs
> new file mode 100644
> index 0000000000..1ffdf03d2f
> --- /dev/null
> +++ b/buildtools/rust/build.rs
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +extern crate meson_next as meson;
> +use std::collections::HashMap;
> +use std::env;
> +use std::path::PathBuf;
> +
> +fn main() {
> +    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
> +    let build_dir = out_path.join("build");
> +
> +    let meson_cfg = meson::Config::new().options(HashMap::from([
> +        ("enable_libs", "eal"),
> +        ("enable_drivers", "net/*,net/intel/*"),
> +        ("enable_apps", "test")
> +    ]));
> +    meson::build(".", build_dir.to_str().unwrap(), meson_cfg);
> +
> +    /* open and print file 'cargo_rules.txt' from build_dir */
> +    let cargo_ldflags_file = build_dir.join("cargo_ldflags.txt");
> +    println!("cargo:rerun-if-changed={}", cargo_ldflags_file.display());
> +    print!("{}", std::fs::read_to_string(cargo_ldflags_file).unwrap());
> +
> +    let bindgen_include_file = build_dir.join("bindgen_cflags.txt");
> +    let mut bindings = bindgen::Builder::default();
> +    for line in std::fs::read_to_string(bindgen_include_file).unwrap().lines() {
> +            bindings = bindings.clang_arg(line);
> +    }
> +
> +    let bindings = bindings.header("buildtools/rust/wrapper.h")
> +        .derive_default(true)
> +        .allowlist_function("rte_eal_init")
> +        .allowlist_function("rte_eal_cleanup")

Calling the `allowlist_function()` method generates well-maintained target 
bindings.
That approach requires to specify each DPDK symbol for Rust 
library API explicitly. There are way too many symbols to bind even for 
a simple network application.

> +        // Tell cargo to invalidate the built crate whenever any of the
> +        // included header files changed.
> +        .parse_callbacks(Box::new(bindgen::CargoCallbacks::new()))
> +        .generate()
> +        .expect("Unable to generate bindings");
> +
> +    bindings
> +        .write_to_file(out_path.join("bindings.rs"))
> +        .expect("Couldn't write bindings!");
> +}

Bindings file or directory for RTE library API is not enough.
Each PMD has it's own symbols set and will need a separate bindings library.

> diff --git a/buildtools/rust/gen-cargo-bindgen-info.py b/buildtools/rust/gen-cargo-bindgen-info.py
> new file mode 100644
> index 0000000000..bea432ead3
> --- /dev/null
> +++ b/buildtools/rust/gen-cargo-bindgen-info.py
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Intel Corporation
> +
> +# Script to generate cargo rules for static linking in rust builds
> +# outputs one line per library, for drivers and libraries
> +
> +import os
> +import os.path
> +import sys
> +import subprocess
> +
> +if 'MESON_BUILD_ROOT' not in os.environ:
> +    print('This script must be called from a meson build environment')
> +    sys.exit(1)
> +
> +pkgconf = sys.argv[1]
> +os.environ['PKG_CONFIG_PATH'] = os.path.join(os.environ['MESON_BUILD_ROOT'], 'meson-uninstalled')
> +linker_flags = subprocess.check_output([pkgconf, '--libs', '--static', 'libdpdk']).decode('utf-8')
> +cflags = subprocess.check_output([pkgconf, '--cflags', 'libdpdk']).decode('utf-8')
> +
> +whole_archive = False
> +with open(os.path.join(os.environ['MESON_BUILD_ROOT'], 'cargo_ldflags.txt'), 'w') as dst:
> +    for flag in linker_flags.split():
> +        if flag == '-pthread':
> +            continue
> +        elif flag == '-Wl,--whole-archive':
> +            whole_archive = True
> +        elif flag == '-Wl,--no-whole-archive':
> +            whole_archive = False
> +        elif flag.startswith('-L'):
> +            dst.write(f'cargo:rustc-link-search=native={flag[2:]}\n')
> +        elif flag.startswith('-l:'):
> +            libname = flag[3:]
> +            if libname.startswith('lib'):
> +                libname = libname[3:]
> +            if libname.endswith('.a'):
> +                libname = libname[:-2]
> +            if whole_archive:
> +                dst.write(f'cargo:rustc-link-lib=static:+whole-archive={libname}\n')
> +            else:
> +                dst.write(f'cargo:rustc-link-lib=static={libname}\n')
> +        elif flag.startswith('-lrte_'):
> +            # skip any other DPDK lib flags, we already have them above
> +            continue
> +        elif flag.startswith('-l'):
> +            dst.write(f'cargo:rustc-link-lib={flag[2:]}\n')
> +        else:
> +            print(f'Warning: Unknown flag: {flag}', file=sys.stderr)
> +
> +with open(os.path.join(os.environ['MESON_BUILD_ROOT'], 'bindgen_cflags.txt'), 'w') as dst:
> +    for flag in cflags.split():
> +        dst.write(f'{flag}\n')
> diff --git a/buildtools/rust/lib.rs b/buildtools/rust/lib.rs
> new file mode 100644
> index 0000000000..f99c54ac42
> --- /dev/null
> +++ b/buildtools/rust/lib.rs
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#![allow(non_upper_case_globals)]
> +#![allow(non_camel_case_types)]
> +#![allow(non_snake_case)]
> +
> +include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
> +
> +#[cfg(test)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn test_helloworld() {
> +       let appname = std::ffi::CString::new("test-rs").unwrap();
> +       let mut argv = [appname.into_raw()];
> +       let ret = unsafe {
> +               rte_eal_init(argv.len().try_into().unwrap(), argv.as_mut_ptr())

Activating rte_eal_init() proves that Rust crate has properly linked with DPDK 
libraries.
That is more like infrastructure test.
An active network port with IO capabilities is a real Rust-DPDK POC.

> +       };
> +       assert!(ret >= 0, "rte_eal_init failed");
> +        unsafe { rte_eal_cleanup() };
> +    }
> +}
> diff --git a/buildtools/rust/wrapper.h b/buildtools/rust/wrapper.h
> new file mode 100644
> index 0000000000..25f5bf94e2
> --- /dev/null
> +++ b/buildtools/rust/wrapper.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#include <rte_eal.h>
> diff --git a/meson.build b/meson.build
> index 8436d1dff8..72c82178e1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,6 +114,9 @@ configure_file(output: build_cfg,
> # build pkg-config files for dpdk
> subdir('buildtools/pkg-config')
>
> +# output a list of cargo parameters if DPDK is being built for rust use
> +run_command([gen_cargo_bindgen_info, pkgconf], check: true)
> +
> if meson.is_subproject()
>     subdir('buildtools/subproject')
> endif
> --
> 2.45.2
>
>

Regards,
Gregory
