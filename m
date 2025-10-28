Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14596CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 22:33:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2812340612;
	Tue, 28 Oct 2025 23:33:59 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 51203402E5
 for <dev@dpdk.org>; Tue, 28 Oct 2025 23:33:58 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso6267376b3a.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761690837; x=1762295637; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fI7OaQqsFRha3V1dCb32jgPseuq45ehTanmwja7OO4c=;
 b=NcOc4MwHkOOLggWnl2PGIvbD6c+YbEzIMuge7iN+Kq+m8NGNTw6plVVAZLABMqaCqp
 AqLTHtvPvPFIZX4eL/BA+6z9/R3Ic0WZ8nlui/QPVtlA6v+fPKo0nQOgkrlrijEHb8U5
 lyAzq5GCLWBJ56qRNVl3unKcy16vVxCrVE6fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761690837; x=1762295637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI7OaQqsFRha3V1dCb32jgPseuq45ehTanmwja7OO4c=;
 b=VPI7oZ0WjpIqrQkD7HUW0vurL8WNT9x5rCrukLrfSlqo5Ts1qmUtEFlz483750JrAE
 zi9dcN9ieHu87kd2DprjdQjhqUhdzFtrhVMtU0FL2xEuJ1uvYOjVOPEQ80GPLgNhVu+t
 lTbVQuS2eaBw7/tzDBK3eYeO0/TUjhctgaCcIGF5IIvCIAhRh4oZaXyoxQopowiHFKzx
 gC3U9HO/HxIx70Y17Hjx4pD5eoS6QE9MOz51/7ltFPP7CERlxbfcxTseyLFsqUOjYnNV
 PdA848KuzhIsXV5ZBtlUvZJ086Cpt59/DRh1HiQw5yAxrqpAZzueS2hasU4xjfZAHWEA
 3NOQ==
X-Gm-Message-State: AOJu0YyMC/5IPY5TLZMgdcUNN8JC91gXS1424r+lU0+Nmzg+XO96Fp5y
 Lx6/dknCAgItk6Hcd5be/I40XBLTPJpka7tBsomBTeEQRQgsD/3A4/4mMjFJWtRN558OK4ktZ4G
 jBI7tgbilUyUeC3MxXyPRqM+TZ+MAJJhb35061gt92Q==
X-Gm-Gg: ASbGnctrtZxHZpDu4BGq+Ftub/CwN02406swfZfQvKUp5DfepSNOwLWYOk6oCQzpmVW
 mEOnPXjizaEN06MiVqst3zb+QcC7jO1/8xVrJjvY7vgVHJnTYOa+ZMlB9c44VWIP3tYGSVTWuWv
 vrYP5da0QFRI8EbTiJw+9Wjn29Ln9A2DtbJpXZD4MnHv+COS/tHomuMsyAlSxAAQ5RlLjePIMRe
 CxxNbSz2KhpAKQjLnCTPfn+/Z+9MtfowLR/xsi+6ZNQBQtqKxvla/Hq+Tl+5jzXs9TMHvXEzo9W
 rgT7uNGtVCm9gzI360ub+vjbrMjf
X-Google-Smtp-Source: AGHT+IHM9cSC6Zje9bw001HnKT6ZleG9lAdMDKfHEkqKsTnm8ZGssWT6QU7pROF8l5AJ6e6mk5+m43dDgf5BtOnds9c=
X-Received: by 2002:a17:902:d4d0:b0:250:6d0e:1e40 with SMTP id
 d9443c01a7336-294dedf4314mr8441735ad.7.1761690837190; Tue, 28 Oct 2025
 15:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251028122240.112773-1-abailey@iol.unh.edu>
 <20251028122240.112773-3-abailey@iol.unh.edu>
In-Reply-To: <20251028122240.112773-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 28 Oct 2025 18:32:58 -0400
X-Gm-Features: AWmQ_bk12L9oAUzNvk2QBSKCQ4AUPGgZSz1swjzOap6vgCc6vb2VVmf3BDpqhTs
Message-ID: <CAJvnSUCQRtvRFq8-2fnNED0mOpuGpkgZ9krhQZi3eK94hKvzCQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] dts: add Tx offload capabilities to NIC
 capabilities
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, 
 Jeremy Spewock <jspewock@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000008e1b7306423f9c2a"
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

--0000000000008e1b7306423f9c2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Tue, Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, there is no support for tracking tx_offload capabilities and
> there is no separation between port capabilities and queue
> capabilities. This is an issue if a test case requires a tx_offload
> capability or if a test case requires that a card supports a capability
> on a queue. This causes test cases with said requirements to not be
> skipped when appropriate. Add tx_offload capabilities and distinguish
> capabilities between ports and queues.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
> ---
>  dts/api/capabilities.py                   | 126 ++++++++++--
>  dts/api/testpmd/__init__.py               |  97 ++++++++-
>  dts/api/testpmd/types.py                  | 227 +++++++++++++++-------
>  dts/framework/parser.py                   |  30 +++
>  dts/framework/testbed_model/capability.py | 109 +++++++++--
>  dts/tests/TestSuite_checksum_offload.py   |  10 +-
>  dts/tests/TestSuite_pmd_buffer_scatter.py |   4 +-
>  dts/tests/TestSuite_vlan.py               |   4 +-
>  8 files changed, 489 insertions(+), 118 deletions(-)
>
> diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
> index 1a79413f6f..243759668f 100644
> --- a/dts/api/capabilities.py
> +++ b/dts/api/capabilities.py
> @@ -77,45 +77,65 @@ class NicCapability(IntEnum):
>      #: Scattered packets Rx enabled.
>      SCATTERED_RX_ENABLED =3D 0
>      #: Device supports VLAN stripping.
> -    RX_OFFLOAD_VLAN_STRIP =3D auto()
> +    PORT_RX_OFFLOAD_VLAN_STRIP =3D auto()
> +    QUEUE_RX_OFFLOAD_VLAN_STRIP =3D auto()
>      #: Device supports L3 checksum offload.
> -    RX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_IPV4_CKSUM =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_UDP_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_UDP_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_UDP_CKSUM =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_TCP_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_TCP_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_TCP_CKSUM =3D auto()
>      #: Device supports Large Receive Offload.
> -    RX_OFFLOAD_TCP_LRO =3D auto()
> +    PORT_RX_OFFLOAD_TCP_LRO =3D auto()
> +    QUEUE_RX_OFFLOAD_TCP_LRO =3D auto()
>      #: Device supports QinQ (queue in queue) offload.
> -    RX_OFFLOAD_QINQ_STRIP =3D auto()
> +    PORT_RX_OFFLOAD_QINQ_STRIP =3D auto()
> +    QUEUE_RX_OFFLOAD_QINQ_STRIP =3D auto()
>      #: Device supports inner packet L3 checksum.
> -    RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
>      #: Device supports MACsec.
> -    RX_OFFLOAD_MACSEC_STRIP =3D auto()
> +    PORT_RX_OFFLOAD_MACSEC_STRIP =3D auto()
> +    QUEUE_RX_OFFLOAD_MACSEC_STRIP =3D auto()
>      #: Device supports filtering of a VLAN Tag identifier.
> -    RX_OFFLOAD_VLAN_FILTER =3D auto()
> +    PORT_RX_OFFLOAD_VLAN_FILTER =3D auto()
> +    QUEUE_RX_OFFLOAD_VLAN_FILTER =3D auto()
>      #: Device supports VLAN offload.
> -    RX_OFFLOAD_VLAN_EXTEND =3D auto()
> +    PORT_RX_OFFLOAD_VLAN_EXTEND =3D auto()
> +    QUEUE_RX_OFFLOAD_VLAN_EXTEND =3D auto()
>      #: Device supports receiving segmented mbufs.
> -    RX_OFFLOAD_SCATTER =3D auto()
> +    PORT_RX_OFFLOAD_SCATTER =3D auto()
> +    QUEUE_RX_OFFLOAD_SCATTER =3D auto()
>      #: Device supports Timestamp.
> -    RX_OFFLOAD_TIMESTAMP =3D auto()
> +    PORT_RX_OFFLOAD_TIMESTAMP =3D auto()
> +    QUEUE_RX_OFFLOAD_TIMESTAMP =3D auto()
>      #: Device supports crypto processing while packet is received in NIC=
.
> -    RX_OFFLOAD_SECURITY =3D auto()
> +    PORT_RX_OFFLOAD_SECURITY =3D auto()
> +    QUEUE_RX_OFFLOAD_SECURITY =3D auto()
>      #: Device supports CRC stripping.
> -    RX_OFFLOAD_KEEP_CRC =3D auto()
> +    PORT_RX_OFFLOAD_KEEP_CRC =3D auto()
> +    QUEUE_RX_OFFLOAD_KEEP_CRC =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_SCTP_CKSUM =3D auto()
>      #: Device supports inner packet L4 checksum.
> -    RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    PORT_RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
>      #: Device supports RSS hashing.
> -    RX_OFFLOAD_RSS_HASH =3D auto()
> +    PORT_RX_OFFLOAD_RSS_HASH =3D auto()
> +    QUEUE_RX_OFFLOAD_RSS_HASH =3D auto()
>      #: Device supports scatter Rx packets to segmented mbufs.
> -    RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> +    PORT_RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> +    QUEUE_RX_OFFLOAD_BUFFER_SPLIT =3D auto()
>      #: Device supports all checksum capabilities.
> -    RX_OFFLOAD_CHECKSUM =3D auto()
> +    PORT_RX_OFFLOAD_CHECKSUM =3D auto()
> +    QUEUE_RX_OFFLOAD_CHECKSUM =3D auto()
>      #: Device supports all VLAN capabilities.
> -    RX_OFFLOAD_VLAN =3D auto()
> +    PORT_RX_OFFLOAD_VLAN =3D auto()
> +    QUEUE_RX_OFFLOAD_VLAN =3D auto()
>      #: Device supports Rx queue setup after device started.
>      RUNTIME_RX_QUEUE_SETUP =3D auto()
>      #: Device supports Tx queue setup after device started.
> @@ -132,6 +152,72 @@ class NicCapability(IntEnum):
>      FLOW_CTRL =3D auto()
>      #: Device is running on a physical function.
>      PHYSICAL_FUNCTION =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_VLAN_INSERT =3D auto()
> +    QUEUE_TX_OFFLOAD_VLAN_INSERT =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_UDP_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_UDP_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_TCP_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_TCP_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_TCP_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_TCP_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_UDP_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_UDP_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_QINQ_INSERT =3D auto()
> +    QUEUE_TX_OFFLOAD_QINQ_INSERT =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_GRE_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_GRE_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_IPIP_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_IPIP_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_MACSEC_INSERT =3D auto()
> +    QUEUE_TX_OFFLOAD_MACSEC_INSERT =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_MT_LOCKFREE =3D auto()
> +    QUEUE_TX_OFFLOAD_MT_LOCKFREE =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_MULTI_SEGS =3D auto()
> +    QUEUE_TX_OFFLOAD_MULTI_SEGS =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_MBUF_FAST_FREE =3D auto()
> +    QUEUE_TX_OFFLOAD_MBUF_FAST_FREE =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_SECURITY =3D auto()
> +    QUEUE_TX_OFFLOAD_SECURITY =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_UDP_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_UDP_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_IP_TNL_TSO =3D auto()
> +    QUEUE_TX_OFFLOAD_IP_TNL_TSO =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    #:
> +    PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()
> +    QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()
>
>
>  def requires_link_topology(
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index 9e9cbaf495..aadb7f4e70 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -39,6 +39,8 @@
>      FlowRule,
>      RxOffloadCapabilities,
>      RxOffloadCapability,
> +    RxOffloadConfiguration,
> +    RxTxLiteralSwitch,
>      TestPmdDevice,
>      TestPmdPort,
>      TestPmdPortFlowCtrl,
> @@ -46,6 +48,9 @@
>      TestPmdQueueInfo,
>      TestPmdRxqInfo,
>      TestPmdVerbosePacket,
> +    TxOffloadCapabilities,
> +    TxOffloadCapability,
> +    TxOffloadConfiguration,
>      VLANOffloadFlag,
>  )
>  from framework.context import get_ctx
> @@ -1190,13 +1195,14 @@ def _update_capabilities_from_flag(
>          unsupported_capabilities: MutableSet["NicCapability"],
>          flag_class: type[Flag],
>          supported_flags: Flag,
> +        prefix: str =3D "",
>      ) -> None:
>          """Divide all flags from `flag_class` into supported and
> unsupported."""
>          for flag in flag_class:
>              if flag in supported_flags:
> -                supported_capabilities.add(NicCapability[str(flag.name)]=
)
> +                supported_capabilities.add(NicCapability[f"{prefix}{
> flag.name}"])
>              else:
> -                unsupported_capabilities.add(NicCapability[str(flag.name
> )])
> +                unsupported_capabilities.add(NicCapability[f"{prefix}{
> flag.name}"])
>
>      @_requires_started_ports
>      def get_capabilities_rxq_info(
> @@ -1293,6 +1299,55 @@ def get_capabilities_physical_function(
>          else:
>              unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
>
> +    @staticmethod
> +    def get_offload_capabilities_func(
> +        rxtx: RxTxLiteralSwitch,
> +    ) -> Callable[["TestPmd", MutableSet["NicCapability"],
> MutableSet["NicCapability"]], None]:
> +        """High-order function that returns a method for gathering Rx/Tx
> offload capabilities.
> +
> +        Args:
> +            rxtx: whether to gather the rx or tx capabilities in the
> returned method.
> +
> +        Returns:
> +            A method for gathering Rx/Tx offload capabilities that meets
> the required structure.
> +        """
> +
> +        def get_capabilities(
> +            self: "TestPmd",
> +            supported_capabilities: MutableSet["NicCapability"],
> +            unsupported_capabilities: MutableSet["NicCapability"],
> +        ) -> None:
> +            """Get all rx/tx offload capabilities and divide them into
> supported and unsupported.
> +
> +            Args:
> +                self: The shell instance to get the capabilities from.
> +                supported_capabilities: Supported capabilities will be
> added to this set.
> +                unsupported_capabilities: Unsupported capabilities will
> be added to this set.
> +            """
> +            self._logger.info(f"Getting {rxtx} offload capabilities.")
> +            command =3D f"show port {self.ports[0].id} {rxtx}_offload
> capabilities"
> +            offload_capabilities_out =3D self.send_command(command)
> +
> +            capabilities =3D TxOffloadCapabilities if rxtx =3D=3D "tx" e=
lse
> RxOffloadCapabilities
> +            offload_capabilities =3D
> capabilities.parse(offload_capabilities_out)
> +
> +            self._update_capabilities_from_flag(
> +                supported_capabilities,
> +                unsupported_capabilities,
> +                TxOffloadCapability if rxtx =3D=3D "tx" else
> RxOffloadCapability,
> +                offload_capabilities.per_port |
> offload_capabilities.per_queue,
> +                prefix=3Df"PORT_{rxtx.upper()}_OFFLOAD_",
> +            )
> +            self._update_capabilities_from_flag(
> +                supported_capabilities,
> +                unsupported_capabilities,
> +                TxOffloadCapability if rxtx =3D=3D "tx" else
> RxOffloadCapability,
> +                offload_capabilities.per_queue,
> +                prefix=3Df"QUEUE_{rxtx.upper()}_OFFLOAD_",
> +            )
> +
> +        return get_capabilities
> +
>      @_requires_stopped_ports
>      def set_port_mbuf_fast_free(
>          self,
> @@ -1352,3 +1407,41 @@ def set_queue_mbuf_fast_free(
>              raise InteractiveCommandExecutionError(
>                  f"Failed to get offload config on port {port_id}, queue
> {queue_id}:\n{output}"
>              )
> +
> +    @_requires_started_ports
> +    def get_offload_config(
> +        self,
> +        port_id: int,
> +        rxtx: RxTxLiteralSwitch,
> +        /,
> +        verify: bool =3D True,
> +    ) -> RxOffloadConfiguration | TxOffloadConfiguration:
> +        """Get the Rx or Tx offload configuration of the queues from the
> given port.
> +
> +        Args:
> +            port_id: The port ID that contains the desired queues.
> +            rxtx: Whether to get the Rx or Tx configuration of the given
> queues.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that the offload configuration was retrieved
> successfully on all queues.
> +
> +        Returns:
> +            An offload configuration containing the capabilities of the
> port and queues.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queue offload
> configurations could not be
> +                retrieved.
> +        """
> +        config_output =3D self.send_command(f"show port {port_id}
> {rxtx}_offload configuration")
> +        if verify:
> +            if (
> +                f"Rx Offloading Configuration of port {port_id}" not in
> config_output
> +                and f"Tx Offloading Configuration of port {port_id}" not
> in config_output
> +            ):
> +                self._logger.debug(f"Get port offload config
> error\n{config_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to get offload config on port
> {port_id}:\n{config_output}"
> +                )
> +        if rxtx =3D=3D "rx":
> +            return RxOffloadConfiguration.parse(config_output)
> +        else:
> +            return TxOffloadConfiguration.parse(config_output)
> diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
> index d1ebf6f2d1..01fe34307d 100644
> --- a/dts/api/testpmd/types.py
> +++ b/dts/api/testpmd/types.py
> @@ -18,6 +18,8 @@
>  from framework.parser import ParserFn, TextParser
>  from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
>
> +RxTxLiteralSwitch =3D Literal["rx", "tx"]
> +
>
>  class TestPmdDevice:
>      """The data of a device that testpmd can recognize.
> @@ -1246,7 +1248,99 @@ class TestPmdVerbosePacket(TextParser):
>      )
>
>
> -class RxOffloadCapability(Flag):
> +class OffloadCapability(Flag):
> +    """Flags generated from RxOffloadCapabilites and
> TxOffloadCapabilities classes."""
> +
> +    @classmethod
> +    def from_string(cls, line: str) -> Self:
> +        """Make an instance from a string containing the flag names
> separated with a space.
> +
> +        Args:
> +            line: The line to parse.
> +
> +        Returns:
> +            A new instance containing all found flags.
> +        """
> +        flag =3D cls(0)
> +        for flag_name in line.split():
> +            flag |=3D cls[flag_name]
> +        return flag
> +
> +    @classmethod
> +    def from_list(cls, lines: list[str]) -> list[Self]:
> +        """Gather capabilities from a list of strings.
> +
> +        Args:
> +            lines: The list of capabilities to make flags from.
> +        """
> +        return [cls.from_string(line) for line in lines]
> +
> +    @classmethod
> +    def make_parser(
> +        cls, port_or_queue: Literal["port", "queue"], /, find_multiple:
> bool =3D False
> +    ) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            port_or_queue: If :data:`True`, will return capabilities per
> port. If :data:`False`,
> +                will return capabilities per queue.
> +            find_multiple: If :data:`True`, will use
> :func:`TextParser.find_all` to find all
> +                matches for the regex query and return a list of
> instances based on those matches.
> +                If :data:`False`, will return a single instance of the
> flag based off a single
> +                match.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        granularity =3D port_or_queue.capitalize()
> +        regex =3D rf"{granularity}[\s\[\]\d]+:(.*)$"
> +        if find_multiple:
> +            return TextParser.wrap(TextParser.find_all(regex,
> re.MULTILINE), cls.from_list)
> +        return TextParser.wrap(TextParser.find(regex, re.MULTILINE),
> cls.from_string)
> +
> +
> +class TxOffloadCapability(OffloadCapability):
> +    """Tx offload capabilities of a device.
> +
> +    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> +    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in
> ``lib/ethdev/rte_ethdev.h``
> +    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix
> to.
> +
> +    The ``TX_OFFLOAD`` prefix has been preserved so that the same flag
> names can be used
> +    in :class:`NicCapability`. The prefix is needed in
> :class:`NicCapability` since there's
> +    no other qualifier which would sufficiently distinguish it from othe=
r
> capabilities.
> +
> +    References:
> +        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> +        testpmd display function:
> ``app/test-pmd/cmdline.c:print_rx_offloads()``
> +    """
> +
> +    VLAN_INSERT =3D auto()
> +    IPV4_CKSUM =3D auto()
> +    UDP_CKSUM =3D auto()
> +    TCP_CKSUM =3D auto()
> +    SCTP_CKSUM =3D auto()
> +    TCP_TSO =3D auto()
> +    UDP_TSO =3D auto()
> +    OUTER_IPV4_CKSUM =3D auto()
> +    QINQ_INSERT =3D auto()
> +    VXLAN_TNL_TSO =3D auto()
> +    GRE_TNL_TSO =3D auto()
> +    IPIP_TNL_TSO =3D auto()
> +    GENEVE_TNL_TSO =3D auto()
> +    MACSEC_INSERT =3D auto()
> +    MT_LOCKFREE =3D auto()
> +    MULTI_SEGS =3D auto()
> +    MBUF_FAST_FREE =3D auto()
> +    SECURITY =3D auto()
> +    UDP_TNL_TSO =3D auto()
> +    IP_TNL_TSO =3D auto()
> +    OUTER_UDP_CKSUM =3D auto()
> +    SEND_ON_TIMESTAMP =3D auto()
> +
> +
> +class RxOffloadCapability(OffloadCapability):
>      """Rx offload capabilities of a device.
>
>      The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> @@ -1265,102 +1359,103 @@ class RxOffloadCapability(Flag):
>      """
>
>      #:
> -    RX_OFFLOAD_VLAN_STRIP =3D auto()
> +    VLAN_STRIP =3D auto()
>      #: Device supports L3 checksum offload.
> -    RX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    IPV4_CKSUM =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_UDP_CKSUM =3D auto()
> +    UDP_CKSUM =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_TCP_CKSUM =3D auto()
> +    TCP_CKSUM =3D auto()
>      #: Device supports Large Receive Offload.
> -    RX_OFFLOAD_TCP_LRO =3D auto()
> +    TCP_LRO =3D auto()
>      #: Device supports QinQ (queue in queue) offload.
> -    RX_OFFLOAD_QINQ_STRIP =3D auto()
> +    QINQ_STRIP =3D auto()
>      #: Device supports inner packet L3 checksum.
> -    RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    OUTER_IPV4_CKSUM =3D auto()
>      #: Device supports MACsec.
> -    RX_OFFLOAD_MACSEC_STRIP =3D auto()
> +    MACSEC_STRIP =3D auto()
>      #: Device supports filtering of a VLAN Tag identifier.
> -    RX_OFFLOAD_VLAN_FILTER =3D 1 << 9
> +    VLAN_FILTER =3D 1 << 9
>      #: Device supports VLAN offload.
> -    RX_OFFLOAD_VLAN_EXTEND =3D auto()
> +    VLAN_EXTEND =3D auto()
>      #: Device supports receiving segmented mbufs.
> -    RX_OFFLOAD_SCATTER =3D 1 << 13
> +    SCATTER =3D 1 << 13
>      #: Device supports Timestamp.
> -    RX_OFFLOAD_TIMESTAMP =3D auto()
> +    TIMESTAMP =3D auto()
>      #: Device supports crypto processing while packet is received in NIC=
.
> -    RX_OFFLOAD_SECURITY =3D auto()
> +    SECURITY =3D auto()
>      #: Device supports CRC stripping.
> -    RX_OFFLOAD_KEEP_CRC =3D auto()
> +    KEEP_CRC =3D auto()
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    SCTP_CKSUM =3D auto()
>      #: Device supports inner packet L4 checksum.
> -    RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    OUTER_UDP_CKSUM =3D auto()
>      #: Device supports RSS hashing.
> -    RX_OFFLOAD_RSS_HASH =3D auto()
> +    RSS_HASH =3D auto()
>      #: Device supports
> -    RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> +    BUFFER_SPLIT =3D auto()
>      #: Device supports all checksum capabilities.
> -    RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM=
 |
> RX_OFFLOAD_TCP_CKSUM
> +    CHECKSUM =3D IPV4_CKSUM | UDP_CKSUM | TCP_CKSUM
>      #: Device supports all VLAN capabilities.
> -    RX_OFFLOAD_VLAN =3D (
> -        RX_OFFLOAD_VLAN_STRIP
> -        | RX_OFFLOAD_VLAN_FILTER
> -        | RX_OFFLOAD_VLAN_EXTEND
> -        | RX_OFFLOAD_QINQ_STRIP
> -    )
> +    VLAN =3D VLAN_STRIP | VLAN_FILTER | VLAN_EXTEND | QINQ_STRIP
>
> -    @classmethod
> -    def from_string(cls, line: str) -> Self:
> -        """Make an instance from a string containing the flag names
> separated with a space.
>
> -        Args:
> -            line: The line to parse.
> +@dataclass
> +class OffloadCapabilities(TextParser):
> +    """The result of testpmd's ``show port <port_id> rx/tx_offload
> capabilities`` command."""
>
> -        Returns:
> -            A new instance containing all found flags.
> -        """
> -        flag =3D cls(0)
> -        for flag_name in line.split():
> -            flag |=3D cls[f"RX_OFFLOAD_{flag_name}"]
> -        return flag
> +    port_id: int =3D field(metadata=3DTextParser.find_int(r"Offloading
> Capabilities of port (\d+) :"))
> +    #: Per-queue offload capabilities.
> +    per_queue: OffloadCapability
> +    #: Capabilities other than per-queue offload capabilities.
> +    per_port: OffloadCapability
>
> -    @classmethod
> -    def make_parser(cls, per_port: bool) -> ParserFn:
> -        """Make a parser function.
>
> -        Args:
> -            per_port: If :data:`True`, will return capabilities per port=
.
> If :data:`False`,
> -                will return capabilities per queue.
> +@dataclass
> +class RxOffloadCapabilities(OffloadCapabilities):
> +    """Extends :class:`OffloadCapabilities` with Rx specific
> functionality."""
>
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        granularity =3D "Port" if per_port else "Queue"
> -        return TextParser.wrap(
> -            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE=
),
> -            cls.from_string,
> -        )
> +    per_queue: OffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser("queue"))
> +    per_port: OffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser("port"))
>
>
>  @dataclass
> -class RxOffloadCapabilities(TextParser):
> -    """The result of testpmd's ``show port <port_id> rx_offload
> capabilities`` command.
> +class TxOffloadCapabilities(OffloadCapabilities):
> +    """Extends :class:`OffloadCapabilities` with Tx specific
> functionality."""
>
> -    References:
> -        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
> -        testpmd display function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
> -    """
> +    per_queue: OffloadCapability =3D
> field(metadata=3DTxOffloadCapability.make_parser("queue"))
> +    per_port: OffloadCapability =3D
> field(metadata=3DTxOffloadCapability.make_parser("port"))
>
> -    #:
> -    port_id: int =3D field(
> -        metadata=3DTextParser.find_int(r"Rx Offloading Capabilities of p=
ort
> (\d+) :")
> +
> +@dataclass
> +class OffloadConfiguration(TextParser):
> +    """The result of testpmd's ``show port <port_id> rx/tx_offload
> configuration`` command."""
> +
> +    port_id: int =3D field(metadata=3DTextParser.find_int(r"Offloading
> Configuration of port (\d+) :"))
> +    #: Queue offload configurations.
> +    queue_configs: list[OffloadCapability]
> +    #: Port offload configuration.
> +    port_config: OffloadCapability
> +
> +
> +@dataclass
> +class RxOffloadConfiguration(OffloadConfiguration):
> +    """Extends :class:`OffloadingConfiguration` with Rx specific
> functionality."""
> +
> +    queue_configs: list[OffloadCapability] =3D field(
> +        metadata=3DRxOffloadCapability.make_parser("queue",
> find_multiple=3DTrue)
> +    )
> +    port_config: OffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser("port"))
> +
> +
> +@dataclass
> +class TxOffloadConfiguration(OffloadConfiguration):
> +    """Extends :class:`OffloadingConfiguration` with Tx specific
> functionality."""
> +
> +    queue_configs: list[OffloadCapability] =3D field(
> +        metadata=3DTxOffloadCapability.make_parser("queue",
> find_multiple=3DTrue)
>      )
> -    #: Per-queue Rx offload capabilities.
> -    per_queue: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(False))
> -    #: Capabilities other than per-queue Rx offload capabilities.
> -    per_port: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(True))
> +    port_config: OffloadCapability =3D
> field(metadata=3DTxOffloadCapability.make_parser("port"))
>
>
>  @dataclass
> diff --git a/dts/framework/parser.py b/dts/framework/parser.py
> index 7254c75b71..4170cdb1dd 100644
> --- a/dts/framework/parser.py
> +++ b/dts/framework/parser.py
> @@ -116,6 +116,36 @@ def _composite_parser_fn(text: str) -> Any:
>
>          return ParserFn(TextParser_fn=3D_composite_parser_fn)
>
> +    @staticmethod
> +    def find_all(
> +        pattern: str | re.Pattern[str],
> +        flags: re.RegexFlag =3D re.RegexFlag(0),
> +    ) -> ParserFn:
> +        """Makes a parser function that finds all of the regular
> expression matches in the text.
> +
> +        If there are no matches found in the text than None will be
> returned, otherwise a list
> +        containing all matches will be returned. Patterns that contain
> multiple groups will pack
> +        the matches for each group into a tuple.
> +
> +        Args:
> +            pattern: The regular expression pattern.
> +            flags: The regular expression flags. Ignored if the given
> pattern is already compiled.
> +
> +        Returns:
> +            A :class:`ParserFn` that can be used as metadata for a
> dataclass field.
> +        """
> +        if isinstance(pattern, str):
> +            pattern =3D re.compile(pattern, flags)
> +
> +        def _find_all(text: str) -> list[str] | None:
> +            m =3D pattern.findall(text)
> +            if len(m) =3D=3D 0:
> +                return None
> +
> +            return m
> +
> +        return ParserFn(TextParser_fn=3D_find_all)
> +
>      @staticmethod
>      def find(
>          pattern: str | re.Pattern[str],
> diff --git a/dts/framework/testbed_model/capability.py
> b/dts/framework/testbed_model/capability.py
> index f67cff94dc..b166014e0c 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py
> @@ -227,28 +227,95 @@ def mapping(cap: NicCapability) ->
> TestPmdNicCapability:
>                  case NicCapability.SCATTERED_RX_ENABLED:
>                      return (TestPmd.get_capabilities_rxq_info,
> _add_remove_mtu(9000))
>                  case (
> -                    NicCapability.RX_OFFLOAD_VLAN_STRIP
> -                    | NicCapability.RX_OFFLOAD_IPV4_CKSUM
> -                    | NicCapability.RX_OFFLOAD_UDP_CKSUM
> -                    | NicCapability.RX_OFFLOAD_TCP_CKSUM
> -                    | NicCapability.RX_OFFLOAD_TCP_LRO
> -                    | NicCapability.RX_OFFLOAD_QINQ_STRIP
> -                    | NicCapability.RX_OFFLOAD_OUTER_IPV4_CKSUM
> -                    | NicCapability.RX_OFFLOAD_MACSEC_STRIP
> -                    | NicCapability.RX_OFFLOAD_VLAN_FILTER
> -                    | NicCapability.RX_OFFLOAD_VLAN_EXTEND
> -                    | NicCapability.RX_OFFLOAD_SCATTER
> -                    | NicCapability.RX_OFFLOAD_TIMESTAMP
> -                    | NicCapability.RX_OFFLOAD_SECURITY
> -                    | NicCapability.RX_OFFLOAD_KEEP_CRC
> -                    | NicCapability.RX_OFFLOAD_SCTP_CKSUM
> -                    | NicCapability.RX_OFFLOAD_OUTER_UDP_CKSUM
> -                    | NicCapability.RX_OFFLOAD_RSS_HASH
> -                    | NicCapability.RX_OFFLOAD_BUFFER_SPLIT
> -                    | NicCapability.RX_OFFLOAD_CHECKSUM
> -                    | NicCapability.RX_OFFLOAD_VLAN
> +                    NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP
> +                    | NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_TCP_LRO
> +                    | NicCapability.PORT_RX_OFFLOAD_QINQ_STRIP
> +                    | NicCapability.PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_MACSEC_STRIP
> +                    | NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER
> +                    | NicCapability.PORT_RX_OFFLOAD_VLAN_EXTEND
> +                    | NicCapability.PORT_RX_OFFLOAD_SCATTER
> +                    | NicCapability.PORT_RX_OFFLOAD_TIMESTAMP
> +                    | NicCapability.PORT_RX_OFFLOAD_SECURITY
> +                    | NicCapability.PORT_RX_OFFLOAD_KEEP_CRC
> +                    | NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_OUTER_UDP_CKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_RSS_HASH
> +                    | NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT
> +                    | NicCapability.PORT_RX_OFFLOAD_CHECKSUM
> +                    | NicCapability.PORT_RX_OFFLOAD_VLAN
> +                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_STRIP
> +                    | NicCapability.QUEUE_RX_OFFLOAD_IPV4_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_UDP_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_TCP_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_TCP_LRO
> +                    | NicCapability.QUEUE_RX_OFFLOAD_QINQ_STRIP
> +                    | NicCapability.QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_MACSEC_STRIP
> +                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_FILTER
> +                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN_EXTEND
> +                    | NicCapability.QUEUE_RX_OFFLOAD_SCATTER
> +                    | NicCapability.QUEUE_RX_OFFLOAD_TIMESTAMP
> +                    | NicCapability.QUEUE_RX_OFFLOAD_SECURITY
> +                    | NicCapability.QUEUE_RX_OFFLOAD_KEEP_CRC
> +                    | NicCapability.QUEUE_RX_OFFLOAD_SCTP_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_RSS_HASH
> +                    | NicCapability.QUEUE_RX_OFFLOAD_BUFFER_SPLIT
> +                    | NicCapability.QUEUE_RX_OFFLOAD_CHECKSUM
> +                    | NicCapability.QUEUE_RX_OFFLOAD_VLAN
>                  ):
> -                    return (TestPmd.get_capabilities_rx_offload, None)
> +                    return (TestPmd.get_offload_capabilities_func("rx"),
> None)
> +                case (
> +                    NicCapability.PORT_TX_OFFLOAD_VLAN_INSERT
> +                    | NicCapability.PORT_TX_OFFLOAD_IPV4_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_UDP_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_TCP_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_SCTP_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_TCP_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_UDP_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_QINQ_INSERT
> +                    | NicCapability.PORT_TX_OFFLOAD_VXLAN_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_IPIP_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_GENEVE_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_MACSEC_INSERT
> +                    | NicCapability.PORT_TX_OFFLOAD_MT_LOCKFREE
> +                    | NicCapability.PORT_TX_OFFLOAD_MULTI_SEGS
> +                    | NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE
> +                    | NicCapability.PORT_TX_OFFLOAD_SECURITY
> +                    | NicCapability.PORT_TX_OFFLOAD_UDP_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_IP_TNL_TSO
> +                    | NicCapability.PORT_TX_OFFLOAD_OUTER_UDP_CKSUM
> +                    | NicCapability.PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP
> +                    | NicCapability.QUEUE_TX_OFFLOAD_VLAN_INSERT
> +                    | NicCapability.QUEUE_TX_OFFLOAD_IPV4_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_TCP_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_SCTP_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_TCP_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_QINQ_INSERT
> +                    | NicCapability.QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_GRE_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_IPIP_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_MACSEC_INSERT
> +                    | NicCapability.QUEUE_TX_OFFLOAD_MT_LOCKFREE
> +                    | NicCapability.QUEUE_TX_OFFLOAD_MULTI_SEGS
> +                    | NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE
> +                    | NicCapability.QUEUE_TX_OFFLOAD_SECURITY
> +                    | NicCapability.QUEUE_TX_OFFLOAD_UDP_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_IP_TNL_TSO
> +                    | NicCapability.QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM
> +                    | NicCapability.QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP
> +                ):
> +                    return (TestPmd.get_offload_capabilities_func("tx"),
> None)
>                  case (
>                      NicCapability.RUNTIME_RX_QUEUE_SETUP
>                      | NicCapability.RUNTIME_TX_QUEUE_SETUP
> diff --git a/dts/tests/TestSuite_checksum_offload.py
> b/dts/tests/TestSuite_checksum_offload.py
> index 8e1ec0f142..394a73c31d 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -34,9 +34,9 @@
>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> -@requires_nic_capability(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
> -@requires_nic_capability(NicCapability.RX_OFFLOAD_UDP_CKSUM)
> -@requires_nic_capability(NicCapability.RX_OFFLOAD_TCP_CKSUM)
> +@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
> +@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
> +@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
>  class TestChecksumOffload(TestSuite):
>      """Checksum offload test suite.
>
> @@ -293,7 +293,7 @@ def validate_rx_checksum(self) -> None:
>                      packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True,
> testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
> -    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN)
> +    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN)
>      @func_test
>      def vlan_checksum(self) -> None:
>          """Test VLAN Rx checksum hardware offload and verify packet
> reception.
> @@ -352,7 +352,7 @@ def vlan_checksum(self) -> None:
>                      packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True,
> testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
> -    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
> +    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM)
>      @func_test
>      def validate_sctp_checksum(self) -> None:
>          """Test SCTP Rx checksum hardware offload and verify packet
> reception.
> diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py
> b/dts/tests/TestSuite_pmd_buffer_scatter.py
> index b49fba4cfc..96da67ee7d 100644
> --- a/dts/tests/TestSuite_pmd_buffer_scatter.py
> +++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
> @@ -34,7 +34,7 @@
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> -@requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
> +@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
>  class TestPmdBufferScatter(TestSuite):
>      """DPDK PMD packet scattering test suite.
>
> @@ -148,7 +148,7 @@ def scatter_mbuf_2048(self) -> None:
>          """
>          self._pmd_scatter(mb_size=3D2048)
>
> -    @requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)
> +    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
>      @func_test
>      def scatter_mbuf_2048_with_offload(self) -> None:
>          """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048
> and rx_scatter offload.
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index 0ef63562b6..2c5abd68bf 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -28,7 +28,7 @@
>  from framework.test_suite import TestSuite, func_test
>
>
> -@requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_FILTER)
> +@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestVlan(TestSuite):
>      """DPDK VLAN test suite.
> @@ -142,7 +142,7 @@ def vlan_receipt_no_stripping(self) -> None:
>              testpmd.start()
>              self._send_vlan_packet_and_verify(should_receive=3DTrue,
> strip=3DFalse, vlan_id=3D1)
>
> -    @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_STRIP)
> +    @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP)
>      @func_test
>      def vlan_receipt_stripping(self) -> None:
>          """Ensure VLAN packet received with no tag when receipts and
> header stripping are enabled.
> --
> 2.50.1
>
>

--0000000000008e1b7306423f9c2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey=
@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Currently, there is no support for trackin=
g tx_offload capabilities and<br>
there is no separation between port capabilities and queue<br>
capabilities. This is an issue if a test case requires a tx_offload<br>
capability or if a test case requires that a card supports a capability<br>
on a queue. This causes test cases with said requirements to not be<br>
skipped when appropriate. Add tx_offload capabilities and distinguish<br>
capabilities between ports and queues.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
Signed-off-by: Jeremy Spewock &lt;<a href=3D"mailto:jspewock@iol.unh.edu" t=
arget=3D"_blank">jspewock@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/capabilities.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 126 ++++++++++--<br>
=C2=A0dts/api/testpmd/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 97 ++++++++-<br>
=C2=A0dts/api/testpmd/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 227 +++++++++++++++-------<br>
=C2=A0dts/framework/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 30 +++<br>
=C2=A0dts/framework/testbed_model/capability.py | 109 +++++++++--<br>
=C2=A0dts/tests/TestSuite_checksum_offload.py=C2=A0 =C2=A0|=C2=A0 10 +-<br>
=C2=A0dts/tests/TestSuite_pmd_buffer_scatter.py |=C2=A0 =C2=A04 +-<br>
=C2=A0dts/tests/TestSuite_vlan.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A08 files changed, 489 insertions(+), 118 deletions(-)<br>
<br>
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py<br>
index 1a79413f6f..243759668f 100644<br>
--- a/dts/api/capabilities.py<br>
+++ b/dts/api/capabilities.py<br>
@@ -77,45 +77,65 @@ class NicCapability(IntEnum):<br>
=C2=A0 =C2=A0 =C2=A0#: Scattered packets Rx enabled.<br>
=C2=A0 =C2=A0 =C2=A0SCATTERED_RX_ENABLED =3D 0<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports VLAN stripping.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L3 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Large Receive Offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_TCP_LRO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_TCP_LRO =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports QinQ (queue in queue) offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports inner packet L3 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports MACsec.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports filtering of a VLAN Tag identifier.<=
br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_VLAN_FILTER =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_VLAN_FILTER =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports VLAN offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports receiving segmented mbufs.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_SCATTER =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_SCATTER =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Timestamp.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_TIMESTAMP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports crypto processing while packet is re=
ceived in NIC.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_SECURITY =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports CRC stripping.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_KEEP_CRC =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_KEEP_CRC =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports inner packet L4 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports RSS hashing.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_RSS_HASH =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_RSS_HASH =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports scatter Rx packets to segmented mbuf=
s.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports all checksum capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_CHECKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_CHECKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports all VLAN capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN =3D auto()<br>
+=C2=A0 =C2=A0 PORT_RX_OFFLOAD_VLAN =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_RX_OFFLOAD_VLAN =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Rx queue setup after device started.=
<br>
=C2=A0 =C2=A0 =C2=A0RUNTIME_RX_QUEUE_SETUP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Tx queue setup after device started.=
<br>
@@ -132,6 +152,72 @@ class NicCapability(IntEnum):<br>
=C2=A0 =C2=A0 =C2=A0FLOW_CTRL =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device is running on a physical function.<br>
=C2=A0 =C2=A0 =C2=A0PHYSICAL_FUNCTION =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_VLAN_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_VLAN_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_TCP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_TCP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_UDP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_UDP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_QINQ_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_QINQ_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_GRE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_GRE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_IPIP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_IPIP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_MACSEC_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_MACSEC_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_MT_LOCKFREE =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_MT_LOCKFREE =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_MULTI_SEGS =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_MULTI_SEGS =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_MBUF_FAST_FREE =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_MBUF_FAST_FREE =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_UDP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_UDP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_IP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_IP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()<br>
<br>
<br>
=C2=A0def requires_link_topology(<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index 9e9cbaf495..aadb7f4e70 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -39,6 +39,8 @@<br>
=C2=A0 =C2=A0 =C2=A0FlowRule,<br>
=C2=A0 =C2=A0 =C2=A0RxOffloadCapabilities,<br>
=C2=A0 =C2=A0 =C2=A0RxOffloadCapability,<br>
+=C2=A0 =C2=A0 RxOffloadConfiguration,<br>
+=C2=A0 =C2=A0 RxTxLiteralSwitch,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdDevice,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdPort,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdPortFlowCtrl,<br>
@@ -46,6 +48,9 @@<br>
=C2=A0 =C2=A0 =C2=A0TestPmdQueueInfo,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdRxqInfo,<br>
=C2=A0 =C2=A0 =C2=A0TestPmdVerbosePacket,<br>
+=C2=A0 =C2=A0 TxOffloadCapabilities,<br>
+=C2=A0 =C2=A0 TxOffloadCapability,<br>
+=C2=A0 =C2=A0 TxOffloadConfiguration,<br>
=C2=A0 =C2=A0 =C2=A0VLANOffloadFlag,<br>
=C2=A0)<br>
=C2=A0from framework.context import get_ctx<br>
@@ -1190,13 +1195,14 @@ def _update_capabilities_from_flag(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities: MutableSet[&quo=
t;NicCapability&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag_class: type[Flag],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_flags: Flag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix: str =3D &quot;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Divide all flags from `=
flag_class` into supported and unsupported.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for flag in flag_class:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if flag in supported_flags:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer" =
target=3D"_blank">flag.name</a>)])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties.add(NicCapability[f&quot;{prefix}{<a href=3D"http://flag.name" rel=3D"=
noreferrer" target=3D"_blank">flag.name</a>}&quot;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer=
" target=3D"_blank">flag.name</a>)])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities.add(NicCapability[f&quot;{prefix}{<a href=3D"http://flag.name" rel=
=3D"noreferrer" target=3D"_blank">flag.name</a>}&quot;])<br>
<br>
=C2=A0 =C2=A0 =C2=A0@_requires_started_ports<br>
=C2=A0 =C2=A0 =C2=A0def get_capabilities_rxq_info(<br>
@@ -1293,6 +1299,55 @@ def get_capabilities_physical_function(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities.ad=
d(NicCapability.PHYSICAL_FUNCTION)<br>
<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def get_offload_capabilities_func(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: RxTxLiteralSwitch,<br>
+=C2=A0 =C2=A0 ) -&gt; Callable[[&quot;TestPmd&quot;, MutableSet[&quot;NicC=
apability&quot;], MutableSet[&quot;NicCapability&quot;]], None]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;High-order function that ret=
urns a method for gathering Rx/Tx offload capabilities.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: whether to gather the rx o=
r tx capabilities in the returned method.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A method for gathering Rx/Tx off=
load capabilities that meets the required structure.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def get_capabilities(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self: &quot;TestPmd&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableS=
et[&quot;NicCapability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Mutabl=
eSet[&quot;NicCapability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all rx/tx =
offload capabilities and divide them into supported and unsupported.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self: The shell in=
stance to get the capabilities from.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties: Supported capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities: Unsupported capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(f&quot;Getting {r=
xtx} offload capabilities.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {se=
lf.ports[0].id} {rxtx}_offload capabilities&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_capabilities_out =3D sel=
f.send_command(command)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capabilities =3D TxOffloadCapabi=
lities if rxtx =3D=3D &quot;tx&quot; else RxOffloadCapabilities<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_capabilities =3D capabil=
ities.parse(offload_capabilities_out)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_f=
lag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TxOffloadCapabilit=
y if rxtx =3D=3D &quot;tx&quot; else RxOffloadCapability,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_capabiliti=
es.per_port | offload_capabilities.per_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3Df&quot;PO=
RT_{rxtx.upper()}_OFFLOAD_&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_f=
lag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TxOffloadCapabilit=
y if rxtx =3D=3D &quot;tx&quot; else RxOffloadCapability,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_capabiliti=
es.per_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3Df&quot;QU=
EUE_{rxtx.upper()}_OFFLOAD_&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_capabilities<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@_requires_stopped_ports<br>
=C2=A0 =C2=A0 =C2=A0def set_port_mbuf_fast_free(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
@@ -1352,3 +1407,41 @@ def set_queue_mbuf_fast_free(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise InteractiveCommandExe=
cutionError(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f&quot;Failed=
 to get offload config on port {port_id}, queue {queue_id}:\n{output}&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+<br>
+=C2=A0 =C2=A0 @_requires_started_ports<br>
+=C2=A0 =C2=A0 def get_offload_config(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: RxTxLiteralSwitch,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; RxOffloadConfiguration | TxOffloadConfiguration:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get the Rx or Tx offload con=
figuration of the queues from the given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID that contai=
ns the desired queues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: Whether to get the Rx or T=
x configuration of the given queues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the of=
fload configuration was retrieved successfully on all queues.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An offload configuration contain=
ing the capabilities of the port and queues.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If all queue offload configurations could not be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retrieved.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_output =3D self.send_command(f&quot;sho=
w port {port_id} {rxtx}_offload configuration&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Rx Offloadi=
ng Configuration of port {port_id}&quot; not in config_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and f&quot;Tx Offl=
oading Configuration of port {port_id}&quot; not in config_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Get port offload config error\n{config_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to get offload config on port {port_id}:\n{config_output}&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if rxtx =3D=3D &quot;rx&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RxOffloadConfiguration.pa=
rse(config_output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TxOffloadConfiguration.pa=
rse(config_output)<br>
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py<br>
index d1ebf6f2d1..01fe34307d 100644<br>
--- a/dts/api/testpmd/types.py<br>
+++ b/dts/api/testpmd/types.py<br>
@@ -18,6 +18,8 @@<br>
=C2=A0from framework.parser import ParserFn, TextParser<br>
=C2=A0from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum<br>
<br>
+RxTxLiteralSwitch =3D Literal[&quot;rx&quot;, &quot;tx&quot;]<br>
+<br>
<br>
=C2=A0class TestPmdDevice:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The data of a device that testpmd can=
 recognize.<br>
@@ -1246,7 +1248,99 @@ class TestPmdVerbosePacket(TextParser):<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
<br>
-class RxOffloadCapability(Flag):<br>
+class OffloadCapability(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flags generated from RxOffloadCapabilites =
and TxOffloadCapabilities classes.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_string(cls, line: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make an instance from a stri=
ng containing the flag names separated with a space.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line: The line to parse.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A new instance containing all fo=
und flags.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flag_name in line.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[flag_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_list(cls, lines: list[str]) -&gt; list[Self]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Gather capabilities from a l=
ist of strings.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lines: The list of capabilities =
to make flags from.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return [cls.from_string(line) for line in line=
s]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cls, port_or_queue: Literal[&quot;port&quot;, =
&quot;queue&quot;], /, find_multiple: bool =3D False<br>
+=C2=A0 =C2=A0 ) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_or_queue: If :data:`True`, =
will return capabilities per port. If :data:`False`,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will return capabi=
lities per queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find_multiple: If :data:`True`, =
will use :func:`TextParser.find_all` to find all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matches for the re=
gex query and return a list of instances based on those matches.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If :data:`False`, =
will return a single instance of the flag based off a single<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 granularity =3D port_or_queue.capitalize()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 regex =3D rf&quot;{granularity}[\s\[\]\d]+:(.*=
)$&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if find_multiple:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParse=
r.find_all(regex, re.MULTILINE), cls.from_list)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(regex, =
re.MULTILINE), cls.from_string)<br>
+<br>
+<br>
+class TxOffloadCapability(OffloadCapability):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Tx offload capabilities of a device.<br>
+<br>
+=C2=A0 =C2=A0 The flags are taken from ``lib/ethdev/rte_ethdev.h``.<br>
+=C2=A0 =C2=A0 They&#39;re prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/et=
hdev/rte_ethdev.h``<br>
+=C2=A0 =C2=A0 instead of ``TX_OFFLOAD``, which is what testpmd changes the=
 prefix to.<br>
+<br>
+=C2=A0 =C2=A0 The ``TX_OFFLOAD`` prefix has been preserved so that the sam=
e flag names can be used<br>
+=C2=A0 =C2=A0 in :class:`NicCapability`. The prefix is needed in :class:`N=
icCapability` since there&#39;s<br>
+=C2=A0 =C2=A0 no other qualifier which would sufficiently distinguish it f=
rom other capabilities.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/ethdev/rte_ethdev.h``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:print_rx_offloads()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 VLAN_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TCP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 UDP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 QINQ_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 VXLAN_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 GRE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 IPIP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 GENEVE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 MACSEC_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 MT_LOCKFREE =3D auto()<br>
+=C2=A0 =C2=A0 MULTI_SEGS =3D auto()<br>
+=C2=A0 =C2=A0 MBUF_FAST_FREE =3D auto()<br>
+=C2=A0 =C2=A0 SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 UDP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 IP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 SEND_ON_TIMESTAMP =3D auto()<br>
+<br>
+<br>
+class RxOffloadCapability(OffloadCapability):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Rx offload capabilities of a device.<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0The flags are taken from ``lib/ethdev/rte_ethdev.h``.<b=
r>
@@ -1265,102 +1359,103 @@ class RxOffloadCapability(Flag):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 VLAN_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L3 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 IPV4_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 UDP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TCP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Large Receive Offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO =3D auto()<br>
+=C2=A0 =C2=A0 TCP_LRO =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports QinQ (queue in queue) offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 QINQ_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports inner packet L3 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 OUTER_IPV4_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports MACsec.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 MACSEC_STRIP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports filtering of a VLAN Tag identifier.<=
br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER =3D 1 &lt;&lt; 9<br>
+=C2=A0 =C2=A0 VLAN_FILTER =3D 1 &lt;&lt; 9<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports VLAN offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 VLAN_EXTEND =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports receiving segmented mbufs.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER =3D 1 &lt;&lt; 13<br>
+=C2=A0 =C2=A0 SCATTER =3D 1 &lt;&lt; 13<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports Timestamp.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 TIMESTAMP =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports crypto processing while packet is re=
ceived in NIC.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 SECURITY =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports CRC stripping.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC =3D auto()<br>
+=C2=A0 =C2=A0 KEEP_CRC =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 SCTP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports inner packet L4 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 OUTER_UDP_CKSUM =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports RSS hashing.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH =3D auto()<br>
+=C2=A0 =C2=A0 RSS_HASH =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
+=C2=A0 =C2=A0 BUFFER_SPLIT =3D auto()<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports all checksum capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_U=
DP_CKSUM | RX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 CHECKSUM =3D IPV4_CKSUM | UDP_CKSUM | TCP_CKSUM<br>
=C2=A0 =C2=A0 =C2=A0#: Device supports all VLAN capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_FILTER<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_EXTEND<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_QINQ_STRIP<br>
-=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 VLAN =3D VLAN_STRIP | VLAN_FILTER | VLAN_EXTEND | QINQ_STRIP=
<br>
<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_string(cls, line: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make an instance from a stri=
ng containing the flag names separated with a space.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line: The line to parse.<br>
+@dataclass<br>
+class OffloadCapabilities(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; rx/tx_offload capabilities`` command.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A new instance containing all fo=
und flags.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flag_name in line.split():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[f&quot;RX_OFFLOAD_=
{flag_name}&quot;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;Offloading Capabilities of port (\d+) :&quot;))<br>
+=C2=A0 =C2=A0 #: Per-queue offload capabilities.<br>
+=C2=A0 =C2=A0 per_queue: OffloadCapability<br>
+=C2=A0 =C2=A0 #: Capabilities other than per-queue offload capabilities.<b=
r>
+=C2=A0 =C2=A0 per_port: OffloadCapability<br>
<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls, per_port: bool) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make a parser function.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_port: If :data:`True`, will =
return capabilities per port. If :data:`False`,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will return capabi=
lities per queue.<br>
+@dataclass<br>
+class RxOffloadCapabilities(OffloadCapabilities):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Extends :class:`OffloadCapabilities` with =
Rx specific functionality.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 granularity =3D &quot;Port&quot; if per_port e=
lse &quot;Queue&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(rf&quot;Per {gra=
nularity}\s+:(.*)$&quot;, re.MULTILINE),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_string,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 per_queue: OffloadCapability =3D field(metadata=3DRxOffloadC=
apability.make_parser(&quot;queue&quot;))<br>
+=C2=A0 =C2=A0 per_port: OffloadCapability =3D field(metadata=3DRxOffloadCa=
pability.make_parser(&quot;port&quot;))<br>
<br>
<br>
=C2=A0@dataclass<br>
-class RxOffloadCapabilities(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; rx_offload capabilities`` command.<br>
+class TxOffloadCapabilities(OffloadCapabilities):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Extends :class:`OffloadCapabilities` with =
Tx specific functionality.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa()``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa_parsed()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 per_queue: OffloadCapability =3D field(metadata=3DTxOffloadC=
apability.make_parser(&quot;queue&quot;))<br>
+=C2=A0 =C2=A0 per_port: OffloadCapability =3D field(metadata=3DTxOffloadCa=
pability.make_parser(&quot;port&quot;))<br>
<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 port_id: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Rx Offlo=
ading Capabilities of port (\d+) :&quot;)<br>
+<br>
+@dataclass<br>
+class OffloadConfiguration(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; rx/tx_offload configuration`` command.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;Offloading Configuration of port (\d+) :&quot;))<br>
+=C2=A0 =C2=A0 #: Queue offload configurations.<br>
+=C2=A0 =C2=A0 queue_configs: list[OffloadCapability]<br>
+=C2=A0 =C2=A0 #: Port offload configuration.<br>
+=C2=A0 =C2=A0 port_config: OffloadCapability<br>
+<br>
+<br>
+@dataclass<br>
+class RxOffloadConfiguration(OffloadConfiguration):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Extends :class:`OffloadingConfiguration` w=
ith Rx specific functionality.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 queue_configs: list[OffloadCapability] =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DRxOffloadCapability.make_parser(&qu=
ot;queue&quot;, find_multiple=3DTrue)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 port_config: OffloadCapability =3D field(metadata=3DRxOffloa=
dCapability.make_parser(&quot;port&quot;))<br>
+<br>
+<br>
+@dataclass<br>
+class TxOffloadConfiguration(OffloadConfiguration):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Extends :class:`OffloadingConfiguration` w=
ith Tx specific functionality.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 queue_configs: list[OffloadCapability] =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTxOffloadCapability.make_parser(&qu=
ot;queue&quot;, find_multiple=3DTrue)<br>
=C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 #: Per-queue Rx offload capabilities.<br>
-=C2=A0 =C2=A0 per_queue: RxOffloadCapability =3D field(metadata=3DRxOffloa=
dCapability.make_parser(False))<br>
-=C2=A0 =C2=A0 #: Capabilities other than per-queue Rx offload capabilities=
.<br>
-=C2=A0 =C2=A0 per_port: RxOffloadCapability =3D field(metadata=3DRxOffload=
Capability.make_parser(True))<br>
+=C2=A0 =C2=A0 port_config: OffloadCapability =3D field(metadata=3DTxOffloa=
dCapability.make_parser(&quot;port&quot;))<br>
<br>
<br>
=C2=A0@dataclass<br>
diff --git a/dts/framework/parser.py b/dts/framework/parser.py<br>
index 7254c75b71..4170cdb1dd 100644<br>
--- a/dts/framework/parser.py<br>
+++ b/dts/framework/parser.py<br>
@@ -116,6 +116,36 @@ def _composite_parser_fn(text: str) -&gt; Any:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ParserFn(TextParser_fn=3D_composit=
e_parser_fn)<br>
<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def find_all(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern: str | re.Pattern[str],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags: re.RegexFlag =3D re.RegexFlag(0),<br>
+=C2=A0 =C2=A0 ) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function that=
 finds all of the regular expression matches in the text.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 If there are no matches found in the text than=
 None will be returned, otherwise a list<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 containing all matches will be returned. Patte=
rns that contain multiple groups will pack<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 the matches for each group into a tuple.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern: The regular expression =
pattern.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags: The regular expression fl=
ags. Ignored if the given pattern is already compiled.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A :class:`ParserFn` that can be =
used as metadata for a dataclass field.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(pattern, str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D re.compile(pattern, =
flags)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _find_all(text: str) -&gt; list[str] | Non=
e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D pattern.findall(text)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(m) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return m<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ParserFn(TextParser_fn=3D_find_all)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@staticmethod<br>
=C2=A0 =C2=A0 =C2=A0def find(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pattern: str | re.Pattern[str],<br>
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/test=
bed_model/capability.py<br>
index f67cff94dc..b166014e0c 100644<br>
--- a/dts/framework/testbed_model/capability.py<br>
+++ b/dts/framework/testbed_model/capability.py<br>
@@ -227,28 +227,95 @@ def mapping(cap: NicCapability) -&gt; TestPmdNicCapab=
ility:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case NicCapab=
ility.SCATTERED_RX_ENABLED:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return (TestPmd.get_capabilities_rxq_info, _add_remove_mtu(9000))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NicC=
apability.RX_OFFLOAD_VLAN_STRIP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_IPV4_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_UDP_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_TCP_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_TCP_LRO<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_QINQ_STRIP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_OUTER_IPV4_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_MACSEC_STRIP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_VLAN_FILTER<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_VLAN_EXTEND<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_SCATTER<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_TIMESTAMP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_SECURITY<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_KEEP_CRC<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_SCTP_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_OUTER_UDP_CKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_RSS_HASH<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_BUFFER_SPLIT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_CHECKSUM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.RX_OFFLOAD_VLAN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NicC=
apability.PORT_RX_OFFLOAD_VLAN_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_TCP_LRO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_QINQ_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_MACSEC_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_VLAN_FILTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_VLAN_EXTEND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_SCATTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_TIMESTAMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_SECURITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_KEEP_CRC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_SCTP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_OUTER_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_RSS_HASH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_CHECKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_RX_OFFLOAD_VLAN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_VLAN_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_TCP_LRO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_QINQ_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_MACSEC_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_VLAN_FILTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_VLAN_EXTEND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_SCATTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_TIMESTAMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_SECURITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_KEEP_CRC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_SCTP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_RSS_HASH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_BUFFER_SPLIT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_CHECKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_RX_OFFLOAD_VLAN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn (TestPmd.get_capabilities_rx_offload, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn (TestPmd.get_offload_capabilities_func(&quot;rx&quot;), None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NicC=
apability.PORT_TX_OFFLOAD_VLAN_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_SCTP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_TCP_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_UDP_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_QINQ_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_VXLAN_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_GRE_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_IPIP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_GENEVE_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_MACSEC_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_MT_LOCKFREE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_MULTI_SEGS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_SECURITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_UDP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_IP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_OUTER_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_VLAN_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_SCTP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_TCP_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_UDP_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_QINQ_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_GRE_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_IPIP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_MACSEC_INSERT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_MT_LOCKFREE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_MULTI_SEGS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_SECURITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_UDP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_IP_TNL_TSO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Ni=
cCapability.QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn (TestPmd.get_offload_capabilities_func(&quot;tx&quot;), None)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NicCapability.RUNTIME_RX_QUEUE_SETUP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| NicCapability.RUNTIME_TX_QUEUE_SETUP<br>
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_=
checksum_offload.py<br>
index 8e1ec0f142..394a73c31d 100644<br>
--- a/dts/tests/TestSuite_checksum_offload.py<br>
+++ b/dts/tests/TestSuite_checksum_offload.py<br>
@@ -34,9 +34,9 @@<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
-@requires_nic_capability(NicCapability.RX_OFFLOAD_IPV4_CKSUM)<br>
-@requires_nic_capability(NicCapability.RX_OFFLOAD_UDP_CKSUM)<br>
-@requires_nic_capability(NicCapability.RX_OFFLOAD_TCP_CKSUM)<br>
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)<br>
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)<br>
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)<br>
=C2=A0class TestChecksumOffload(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Checksum offload test suite.<br>
<br>
@@ -293,7 +293,7 @@ def validate_rx_checksum(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3DTrue, testpmd=3Dtest=
pmd, id=3Ddport_id<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN)<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN)=
<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def vlan_checksum(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test VLAN Rx checksum h=
ardware offload and verify packet reception.<br>
@@ -352,7 +352,7 @@ def vlan_checksum(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3DTrue, testpmd=3Dtest=
pmd, id=3Ddport_id<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.RX_OFFLOAD_SCTP_CKSUM=
)<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCTP_=
CKSUM)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def validate_sctp_checksum(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test SCTP Rx checksum h=
ardware offload and verify packet reception.<br>
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuit=
e_pmd_buffer_scatter.py<br>
index b49fba4cfc..96da67ee7d 100644<br>
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py<br>
+++ b/dts/tests/TestSuite_pmd_buffer_scatter.py<br>
@@ -34,7 +34,7 @@<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
-@requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)<br>
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)<br>
=C2=A0class TestPmdBufferScatter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK PMD packet scattering test suite=
.<br>
<br>
@@ -148,7 +148,7 @@ def scatter_mbuf_2048(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._pmd_scatter(mb_size=3D2048)<br>
<br>
-=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.RX_OFFLOAD_SCATTER)<b=
r>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATT=
ER)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def scatter_mbuf_2048_with_offload(self) -&gt; None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run the :meth:`pmd_scat=
ter` test with `mb_size` set to 2048 and rx_scatter offload.<br>
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py<br>
index 0ef63562b6..2c5abd68bf 100644<br>
--- a/dts/tests/TestSuite_vlan.py<br>
+++ b/dts/tests/TestSuite_vlan.py<br>
@@ -28,7 +28,7 @@<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
<br>
<br>
-@requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_FILTER)<br>
+@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
=C2=A0class TestVlan(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK VLAN test suite.<br>
@@ -142,7 +142,7 @@ def vlan_receipt_no_stripping(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testpmd.start()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._send_vlan_packet_and_=
verify(should_receive=3DTrue, strip=3DFalse, vlan_id=3D1)<br>
<br>
-=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.RX_OFFLOAD_VLAN_STRIP=
)<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_=
STRIP)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0def vlan_receipt_stripping(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Ensure VLAN packet rece=
ived with no tag when receipts and header stripping are enabled.<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--0000000000008e1b7306423f9c2a--
