Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FE4C83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 15:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C87402A0;
	Wed,  2 Jul 2025 17:09:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EF3D940285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 17:09:27 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7845822C7;
 Wed,  2 Jul 2025 08:09:12 -0700 (PDT)
Received: from [10.1.35.68] (JR4XG4HTQC-2.cambridge.arm.com [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3C283F6A8;
 Wed,  2 Jul 2025 08:09:25 -0700 (PDT)
Message-ID: <b3cd8792-9673-4227-9c6c-ac9b6c152efd@arm.com>
Date: Wed, 2 Jul 2025 16:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dts: rework config module to support perf TGs
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>, Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, thomas.wilks@arm.com,
 Nicholas Pratte <npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250702052154.381690-1-probb@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Patrick and Nick,

I am unsure what happened with this commit. The commit subject doesn't 
match what's happening here. Mentions a rework of the config module, 
which is not. Description seems ok.

Another issue I see is that some changes don't make a lot logical sense 
as they stand here. The changes in test_run.yaml, don't really belong 
here, and could be considered breaking. I am assuming they were 
improperly re-ordered between commits. Similarly I don't see appropriate 
doc changes to reflect the change in the configuration examples path.

On 02/07/2025 06:21, Patrick Robb wrote:
> --- a/dts/test_run.example.yaml
> +++ b/dts/configurations/test_run.example.yaml
> @@ -1,8 +1,3 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright 2022-2023 The DPDK contributors
> -# Copyright 2023 Arm Limited
> -
> -# Define the test run environment

And removing this line above, would cause in sphinx to complain as the 
example rendering relies on this line.

>   dpdk:
>     lcores: "" # use all available logical cores (Skips first core)
>     memory_channels: 4 # tells DPDK to use 4 memory channels
> @@ -23,8 +18,14 @@ dpdk:
>       # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
>       # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
>       # defined, but not both.

