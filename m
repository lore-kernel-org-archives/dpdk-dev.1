Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE5606A326
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DOmMqXZ8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E5A40297;
	Wed, 11 Nov 2026 17:30:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8B34B4026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 17:30:19 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08151576;
 Wed, 11 Nov 2026 08:30:15 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE933F632;
 Wed, 11 Nov 2026 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794414618; bh=8cdi5re4GLk2LT+U7w7Bs5pjjfQITCIQcwqTU23RIC4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DOmMqXZ8N6tKYYbGnoCsMyX+gfhNT/5q4YF1Vvv35OpCSHxVeTb0ijkLpF+n/Zy1d
 AwHgwnE2e0LvNuWzhFY0tSsUtej3ziN4VQl+hHhFyOnL6Mqb0+Ke+H5Kyp1JKBvhfQ
 EXwdYq8yFmUESBWMpVLzbl2I3SOdXWj2HlynEf/4=
Message-ID: <b6282340-43f0-4b3e-8c54-c6a73ac07fe0@arm.com>
Date: Wed, 11 Nov 2026 16:30:16 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dts: add pvp multi paths vhost performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261110201011.1374679-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261110201011.1374679-1-knimoji@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Koushik,

It looks like not all of my comments were addressed, e.g. Artifact.

On 10/11/2026 20:10, Koushik Bhargav Nimoji wrote:
> diff --git a/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
> new file mode 100644
> index 0000000000..4fcc6b6c91
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +pvp_multi_paths_vhost_single_core_perf Test Suite
> +=================================================
> +
> +.. automodule:: tests.TestSuite_pvp_multi_paths_vhost_single_core_perf
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
> index c72c1b2c90..9459cd83bb 100644
> --- a/dts/api/testpmd/config.py
> +++ b/dts/api/testpmd/config.py
> @@ -13,6 +13,8 @@
>   from pathlib import PurePath
>   from typing import Literal, NamedTuple
>   
> +from pydantic import BaseModel, ConfigDict
> +
>   from api.params import (
>       Params,
>       Switch,
> @@ -618,3 +620,15 @@ class TestPmdParams(EalParams):
>       )
>       record_core_cycles: Switch = None
>       record_burst_status: Switch = None
> +
> +
> +class PerfSuiteConfig(BaseModel):

I wouldn't call the TestParameter a PerfSuiteConfig. Also I am not sure 
this is the right place for this? I think it should just live next to 
BaseConfig in api.test_suite. The idea is that PerfSuiteConfig would 
just be the test suite config model, as the name suggests. Instead of 
replicating the model across test suites just to set defaults. These can 
be a constant and then set during test suite setup as it's already done 
with other test suites. We only extend the config if we have extra 
special fields which are unique for said test suite. anything that is 
common across all of them should be kept in a common config.

These changes can be their own commit before the test suites. Updating 
other test suites using the same pattern would also be a welcome change.

> +    """Generic performance test suite parameters."""
> +
> +    model_config = ConfigDict(strict=True, extra="forbid", frozen=False, from_attributes=True)
> +    frame_size: int
> +    num_descriptors: int
> +    expected_mpps: float
> +    performance_delta: float | None = None
> +    measured_mpps: float | None = None
> +    passing: float | None = None

Still lacking documentation for the fields.
