Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D18CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A864279E;
	Thu,  4 Sep 2025 16:47:50 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 04CB14275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:47:49 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D172B1596;
 Thu,  4 Sep 2025 07:47:39 -0700 (PDT)
Received: from arm.com (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EFCE3F63F;
 Thu,  4 Sep 2025 07:47:47 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:47:44 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu
Subject: Re: [PATCH v2 2/3] dts: add TX offload capabilities to NIC
 capabilities
Message-ID: <175699721629.86089.8162277951767695455.luca.vizzarro@arm.com>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
 <20250903180414.83001-3-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903180414.83001-3-abailey@iol.unh.edu>
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

Copying reply from v1.

On Wed, Sep 03, 2025 at 02:04:13PM +0000, Andrew Bailey wrote:
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index 4d9caceb37..dfd83ebdb3 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1285,6 +1285,99 @@ class TestPmdVerbosePacket(TextParser):
>      )
>  
>  
> +class TxOffloadCapability(Flag):
> +    """TX offload capabilities of a device.
> +
> +    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> +    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
> +    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix to.
> +    The values are not contiguous, so the correspondence is preserved
> +    by specifying concrete values interspersed between auto() values.
> +
> +    The ``TX_OFFLOAD`` prefix has been preserved so that the same flag names can be used
> +    in :class:`NicCapability`. The prefix is needed in :class:`NicCapability` since there's
> +    no other qualifier which would sufficiently distinguish it from other capabilities.
> +
> +    References:
> +        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> +        testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
> +    """
> +
> +    TX_OFFLOAD_VLAN_INSERT = auto()
> +    TX_OFFLOAD_IPV4_CKSUM = auto()
> +    TX_OFFLOAD_UDP_CKSUM = auto()
> +    TX_OFFLOAD_TCP_CKSUM = auto()
> +    TX_OFFLOAD_SCTP_CKSUM = auto()
> +    TX_OFFLOAD_TCP_TSO = auto()
> +    TX_OFFLOAD_UDP_TSO = auto()
> +    TX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
> +    TX_OFFLOAD_QINQ_INSERT = auto()
> +    TX_OFFLOAD_VXLAN_TNL_TSO = auto()
> +    TX_OFFLOAD_GRE_TNL_TSO = auto()
> +    TX_OFFLOAD_IPIP_TNL_TSO = auto()
> +    TX_OFFLOAD_GENEVE_TNL_TSO = auto()
> +    TX_OFFLOAD_MACSEC_INSERT = auto()
> +    TX_OFFLOAD_MT_LOCKFREE = auto()
> +    TX_OFFLOAD_MULTI_SEGS = auto()
> +    TX_OFFLOAD_MBUF_FAST_FREE = auto()
> +    TX_OFFLOAD_SECURITY = auto()
> +    TX_OFFLOAD_UDP_TNL_TSO = auto()
> +    TX_OFFLOAD_IP_TNL_TSO = auto()
> +    TX_OFFLOAD_OUTER_UDP_CKSUM = auto()
> +    TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
> +
> +    @classmethod
> +    def from_string(cls, line: str) -> Self:
> +        """Make an instance from a string containing the flag names separated with a space.
> +
> +        Args:
> +            line: The line to parse.
> +
> +        Returns:
> +            A new instance containing all found flags.
> +        """
> +        flag = cls(0)
> +        for flag_name in line.split():
> +            flag |= cls[f"TX_OFFLOAD_{flag_name}"]
> +        return flag
> +
> +    @classmethod
> +    def make_parser(cls, per_port: bool) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
> +                will return capabilities per queue.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
> +                parser function that makes an instance of this flag from text.
> +        """
> +        granularity = "Port" if per_port else "Queue"
> +        return TextParser.wrap(
> +            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
> +            cls.from_string,
> +        )

The above is creating a lot of duplication. I'd personally implement the
functions in a class that the flags RxOffload and TxOffload can inherit
from. You can deal with `cls[f"TX_OFFLOAD_{flag_name}"]` by introducing
a "PREFIX" ClassVar for all the classes where you can specify it:

    PREFIX: ClassVar[str] = "TX_OFFLOAD_"

    ...

    cls[f"{cls.PREFIX}{flag_name}"]
