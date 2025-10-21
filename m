Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D4FCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278754066D;
	Tue, 21 Oct 2025 17:19:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1883C402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:19:18 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A253A1007;
 Tue, 21 Oct 2025 08:19:09 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7153F63F;
 Tue, 21 Oct 2025 08:19:16 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:19:12 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, 
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: Re: [PATCH v8 2/3] dts: add TX offload capabilities to NIC
 capabilities
Message-ID: <176105979856.91861.6887355146091321986.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251021144528.39748-1-abailey@iol.unh.edu>
 <20251021144528.39748-3-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144528.39748-3-abailey@iol.unh.edu>
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

Looks good now, just one nit, which can be fixed upon merging as well.

On Tue, Oct 21, 2025 at 10:45:27AM +0000, Andrew Bailey wrote:
> diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
> index d1ebf6f2d1..46ae034cec 100644
> --- a/dts/api/testpmd/types.py
> +++ b/dts/api/testpmd/types.py
> @@ -1246,7 +1248,99 @@ class TestPmdVerbosePacket(TextParser):
>      )
>  
>  
> -class RxOffloadCapability(Flag):
> +class OffloadCapability(Flag):
<snip>
> +    @classmethod
> +    def make_parser(
> +        cls, per_port: Literal["port", "queue"], /, find_multiple: bool = False
I thought this was tackled but I guess it wasn't, this should be
port_or_queue.
> +    ) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
> +                will return capabilities per queue.
And this should be updated appropriately.
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
> +
> +
