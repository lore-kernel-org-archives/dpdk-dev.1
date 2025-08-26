Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ADCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36B32402E4;
	Tue, 26 Aug 2025 16:15:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2F988402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:15:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B3051F91;
 Tue, 26 Aug 2025 07:14:56 -0700 (PDT)
Received: from [10.1.194.29] (unknown [10.1.194.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B273F694;
 Tue, 26 Aug 2025 07:15:03 -0700 (PDT)
Message-ID: <babd6b69-c205-4451-b72f-7a2c9525386f@arm.com>
Date: Tue, 26 Aug 2025 15:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] doc: add test case docstring example to dts rst
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250807145002.297452-1-dmarx@iol.unh.edu>
 <20250820143922.42596-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250820143922.42596-1-dmarx@iol.unh.edu>
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

Looks good, just one minor problem.

On 20/08/2025 15:39, Dean Marx wrote:
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index 3837b398cf..31eceb6c43 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -414,6 +414,22 @@ Test Cases
>      A test suite may include any number of functional and/or performance test cases.
>      Each suite should focus on testing a single feature (one feature = one test suite).
>   
> +   Test case docstrings must include a Steps and Verify section. For example:
> +
> +   Example::
> +
> +      @func_test
> +      def test_basic_link(self):
> +      """Tests basic link status.
> +
> +      Steps:
> +         * Launch testpmd.
> +         * Check port info.
> +
> +      Verify:
> +         * Port info shows link status is up.
> +      """
the docstring should be indented further.> +
>   Setup and Teardown Hooks
>   
>      Setup and teardown methods can be defined at both the suite and test case levels.

