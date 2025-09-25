Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54443CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 16:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BC8540663;
	Thu, 25 Sep 2025 18:05:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E7EA54065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 18:05:41 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8EE1692;
 Thu, 25 Sep 2025 09:05:33 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8AF3F694;
 Thu, 25 Sep 2025 09:05:40 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:05:28 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu, Jeremy Spewock <jspewock@iol.unh.edu>
Subject: Re: [PATCH v4 2/3]  dts: add TX offload capabilities to NIC
 capabilities
Message-ID: <175881619867.11927.5707525371318324652.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
 <20250924164725.168773-3-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924164725.168773-3-abailey@iol.unh.edu>
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

Hi Andrew,

Looks good! Just a small nit left.

On Wed, Sep 24, 2025 at 12:47:24PM +0000, Andrew Bailey wrote:
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ecbdd66edd..db7e33222a 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1278,7 +1279,99 @@ class TestPmdVerbosePacket(TextParser):
>      )
>  
>  
> -class RxOffloadCapability(Flag):
> +class OffloadCapability(Flag):
> +    """Flags generated from RxOffloadCapabilites and TxOffloadCapabilities classes."""
<snip>
> +    @classmethod
> +    def make_parser(
> +        cls, per_port: Literal["port", "queue"], /, find_multiple: bool = False
> +    ) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
> +                will return capabilities per queue.

just a small nit: this doc doesn't match what it is anymore. Similarly
the argument name is not entirely valid either.

> +            find_multiple: If :data:`True`, will use :func:`TextParser.find_all` to find all
> +                matches for the regex query and return a list of instances based on those matches.
> +                If :data:`False`, will return a single instance of the flag based off a single
> +                match.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
> +                parser function that makes an instance of this flag from text.
> +        """
> +        granularity = per_port.capitalize()
> +        regex = rf"{granularity}[\s\[\]\d]+:(.*)$"
> +        if find_multiple:
> +            return TextParser.wrap(TextParser.find_all(regex, re.MULTILINE), cls.from_list)
> +        return TextParser.wrap(TextParser.find(regex, re.MULTILINE), cls.from_string)
<snip>
