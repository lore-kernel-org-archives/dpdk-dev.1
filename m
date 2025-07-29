Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C262C83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 12:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52D944026C;
	Tue, 29 Jul 2025 14:45:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 21AB2400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:45:22 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9D11516;
 Tue, 29 Jul 2025 05:45:13 -0700 (PDT)
Received: from [10.57.3.118] (unknown [10.57.3.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CDE93F673;
 Tue, 29 Jul 2025 05:45:20 -0700 (PDT)
Message-ID: <1289ca02-399c-4a10-90ca-f6dd9502894b@arm.com>
Date: Tue, 29 Jul 2025 13:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] doc: add test case docstring example to dts rst
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250722171957.200698-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250722171957.200698-1-dmarx@iol.unh.edu>
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

Hi all,

I've noticed that this approach of writing Steps and Verify doesn't 
really render nicely in Sphinx. The sections are fine, those are 
rendered ok, but every line in the section is not rendered on a new 
line. But all inline. An rendered example of this example:

   Steps:
     Launch testpmd. Check port info.

Should we switch this to (un)ordered lists instead?

Discussion opener aside, just one comment on the changes.

Best,
Luca


On 22/07/2025 18:19, Dean Marx wrote:
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
> +         Launch testpmd.
> +         Check port info.
> +
> +      Verify:
> +         Port info shows link status is up.
> +      "

needs triple "

