Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997CCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 18:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E533340281;
	Wed,  3 Sep 2025 20:43:18 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8F8D04025A
 for <dev@dpdk.org>; Wed,  3 Sep 2025 20:43:16 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24b2de2e427so2078005ad.2
 for <dev@dpdk.org>; Wed, 03 Sep 2025 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756924996; x=1757529796; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g5X4r5Eh4WP9cysJQejmgHjriwbsx8eAvRG9Ox27+ws=;
 b=eveiOlWaXLvAiLDSup/8H8P3XT+VBkQHfV6KNdxkcDPng+lIWUOtP/cFEb8U3vKKgw
 W6oJB40WGX1H0BzF4knPMv0i12FlcJ02ZjmKblvzMbl/S3mXVEYi2f5vmm4oFohHOOyv
 smFJR09A8edQki4NGBIx/X/UrmQiDmCivQF3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756924996; x=1757529796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5X4r5Eh4WP9cysJQejmgHjriwbsx8eAvRG9Ox27+ws=;
 b=YCIpJIgmTcTBfPp+4jvYylVucgxa9j/wtlw+ue+yS+6KlBkJdk1u6Dq9XjVXHCDvsf
 6PeVezT3/fjm0NAozsrUDLBdl8prcBhFoOrWuXMlAvasVKsqCwysOyE+X1pwPZevR66m
 RnGHue3XwM7hjN9regz/iGQzxUSM+VkEVqUcbX9YeUzJGYvewUn20yc6ULkiou84gDy3
 pwRhn1s/7Wb2ef8rqbN4AejhvvQKJzGX+V+OImnpzu/X4MIAczkB2NpE6BvEQgoSGhjY
 qFtXvzr/8KKS1/zWR9rInXXtLwzHUvK5a4oboq6/h0kl2FY1rCUg5ERzUOMjtTP88y0/
 dhog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMPdfIG4beEZCFghJf5ZlWY1bgDHqAxnfIcUa3eTbMXami9J6quSW9Wtl1ypFd8hIxos=@dpdk.org
X-Gm-Message-State: AOJu0Yy7tCbyIE4g8Mw1NySGQKzdbRz8S/vIBduVON3T6jkIEyH5dtNh
 7VILuwFFqtm2QFjpu9jSyr9UFGlcNurhWDzYE2b1rA94t+uN+9XPTeGRaMN1fSIVm4UCbruSHPy
 Jr+mwGZp7ergf7avfnGYZFLi0sFvAFNTzQcv6V5ZQhg==
X-Gm-Gg: ASbGncsOi0YvVIGglIkEEckUz5RWT3v/WQKY95S0zpdQZ5+Ne1ftbmt1S5Hl5BZ9STd
 q2fWUfo9p1kbsGO6tGxd9/pRlULXbDZM3g249q8a3M7TTHd6/4/oIp6UGdvjdK7CzgDIyT3GbLx
 HL+UOM/qUx7IVme3JVnt4JpHeCpgk0b7pFzao3AC6j3Qef8t6nwGFiMT3c179NATiEVm/bIOn91
 nE8QTGzUV1sBjwbgyysPQ==
X-Google-Smtp-Source: AGHT+IEHlAtqug9j5Qrz5lbmybZ1Q8nGcXdOX8aVlGtGwc643P56VjfTcr7uc/YalCtJmdvuntOJVFOirnqnUzCBzqA=
X-Received: by 2002:a17:903:2308:b0:249:33da:b3a with SMTP id
 d9443c01a7336-249448ad928mr200193105ad.14.1756924995623; Wed, 03 Sep 2025
 11:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
 <20250903180414.83001-3-abailey@iol.unh.edu>
In-Reply-To: <20250903180414.83001-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 3 Sep 2025 14:36:28 -0400
X-Gm-Features: Ac12FXx7-JoDuoMvryj_x_alELz1aNHVFWx-_Fuh9DP8DMNhV0vMQv3D0PHfR2U
Message-ID: <CAJvnSUDQTy7QbLe6GrPSc40mfKnYqQr06A=KPSUxvx9cvxgS1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dts: add TX offload capabilities to NIC
 capabilities
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am
Content-Type: multipart/alternative; boundary="00000000000042fbd5063de9fad9"
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

--00000000000042fbd5063de9fad9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:04=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

> Currently, there is support for tracking the Rx offload capabilities of
> a NIC, but not for Tx offload capabilities. This is an issue if a test
> suite is written requiring one of these capabilities, since there is no
> way currently to verify that the NIC in use meets the requirements. Add
> Tx capabilities to the NIC capabilities at beginning of dts so
> requirements can be verified.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 203 ++++++++++++++++++
>  1 file changed, 203 insertions(+)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
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
> +    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in
> ``lib/ethdev/rte_ethdev.h``
> +    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix
> to.
> +    The values are not contiguous, so the correspondence is preserved
> +    by specifying concrete values interspersed between auto() values.
>

afaik only rx_offloads specify concrete values. It looks like these flags
are all auto().


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
> +    TX_OFFLOAD_VLAN_INSERT =3D auto()
> +    TX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    TX_OFFLOAD_UDP_CKSUM =3D auto()
> +    TX_OFFLOAD_TCP_CKSUM =3D auto()
> +    TX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    TX_OFFLOAD_TCP_TSO =3D auto()
> +    TX_OFFLOAD_UDP_TSO =3D auto()
> +    TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    TX_OFFLOAD_QINQ_INSERT =3D auto()
> +    TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()
> +    TX_OFFLOAD_GRE_TNL_TSO =3D auto()
> +    TX_OFFLOAD_IPIP_TNL_TSO =3D auto()
> +    TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()
> +    TX_OFFLOAD_MACSEC_INSERT =3D auto()
> +    TX_OFFLOAD_MT_LOCKFREE =3D auto()
> +    TX_OFFLOAD_MULTI_SEGS =3D auto()
> +    TX_OFFLOAD_MBUF_FAST_FREE =3D auto()
> +    TX_OFFLOAD_SECURITY =3D auto()
> +    TX_OFFLOAD_UDP_TNL_TSO =3D auto()
> +    TX_OFFLOAD_IP_TNL_TSO =3D auto()
> +    TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()
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
> +            flag |=3D cls[f"TX_OFFLOAD_{flag_name}"]
> +        return flag
> +
> +    @classmethod
> +    def make_parser(cls, per_port: bool) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            per_port: If :data:`True`, will return capabilities per port=
.
> If :data:`False`,
> +                will return capabilities per queue.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        granularity =3D "Port" if per_port else "Queue"
> +        return TextParser.wrap(
> +            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE=
),
> +            cls.from_string,
> +        )
> +
> +
> +@dataclass
> +class TxOffloadCapabilities(TextParser):
> +    """The result of testpmd's ``show port <port_id> tx_offload
> capabilities`` command.
> +
> +    References:
> +        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa()``
> +        testpmd display function:
> ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa_parsed()``
> +    """
> +
> +    port_id: int =3D field(
> +        metadata=3DTextParser.find_int(r"Tx Offloading Capabilities of p=
ort
> (\d+) :")
> +    )
> +    #: Per-queue Tx offload capabilities.
> +    per_queue: TxOffloadCapability =3D
> field(metadata=3DTxOffloadCapability.make_parser(False))
> +    #: Capabilities other than per-queue Tx offload capabilities.
> +    per_port: TxOffloadCapability =3D
> field(metadata=3DTxOffloadCapability.make_parser(True))
> +
> +
>  class RxOffloadCapability(Flag):
>      """Rx offload capabilities of a device.
>
> @@ -2397,6 +2490,28 @@ def close(self) -> None:
>      =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=3D=3D
>      """
>
> +    def get_capabilities_tx_offload(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get all TX offload capabilities and divide them into supporte=
d
> and unsupported.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._logger.debug("Getting TX offload capabilities.")
> +        command =3D f"show port {self.ports[0].id} tx_offload capabiliti=
es"
> +        tx_offload_capabilities_out =3D self.send_command(command)
> +        tx_offload_capabilities =3D
> TxOffloadCapabilities.parse(tx_offload_capabilities_out)
> +        self._update_capabilities_from_flag(
> +            supported_capabilities,
> +            unsupported_capabilities,
> +            TxOffloadCapability,
> +            tx_offload_capabilities.per_port |
> tx_offload_capabilities.per_queue,
> +        )
> +
>      def get_capabilities_rx_offload(
>          self,
>          supported_capabilities: MutableSet["NicCapability"],
> @@ -2824,6 +2939,94 @@ class NicCapability(NoAliasEnum):
>      we don't go looking for it again if a different test case also needs
> it.
>      """
>
> +    TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_SECURITY: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
> +    TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability =3D (
> +        TestPmdShell.get_capabilities_tx_offload,
> +        None,
> +    )
>      #: Scattered packets Rx enabled
>      SCATTERED_RX_ENABLED: TestPmdShellNicCapability =3D (
>          TestPmdShell.get_capabilities_rxq_info,
> --
> 2.50.1
>
>
Looks good. Have you verified the docs will build from this patch? If you
haven't done this yet it's

meson setup my_build
ninja -C my_build doc

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000042fbd5063de9fad9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 3, 2025 =
at 2:04=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu"=
 target=3D"_blank">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Currently, there is support for track=
ing the Rx offload capabilities of<br>
a NIC, but not for Tx offload capabilities. This is an issue if a test<br>
suite is written requiring one of these capabilities, since there is no<br>
way currently to verify that the NIC in use meets the requirements. Add<br>
Tx capabilities to the NIC capabilities at beginning of dts so<br>
requirements can be verified.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 203 +++++++++++++++++=
+<br>
=C2=A01 file changed, 203 insertions(+)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index 4d9caceb37..dfd83ebdb3 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -1285,6 +1285,99 @@ class TestPmdVerbosePacket(TextParser):<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
<br>
+class TxOffloadCapability(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;TX offload capabilities of a device.<br>
+<br>
+=C2=A0 =C2=A0 The flags are taken from ``lib/ethdev/rte_ethdev.h``.<br>
+=C2=A0 =C2=A0 They&#39;re prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/et=
hdev/rte_ethdev.h``<br>
+=C2=A0 =C2=A0 instead of ``TX_OFFLOAD``, which is what testpmd changes the=
 prefix to.<br>
+=C2=A0 =C2=A0 The values are not contiguous, so the correspondence is pres=
erved<br>
+=C2=A0 =C2=A0 by specifying concrete values interspersed between auto() va=
lues.<br></blockquote><div><br></div><div>afaik only rx_offloads specify co=
ncrete values. It looks like these flags are all auto().</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 TX_OFFLOAD_VLAN_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_TCP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_QINQ_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_VXLAN_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_GRE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IPIP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_GENEVE_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MACSEC_INSERT =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MT_LOCKFREE =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MULTI_SEGS =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MBUF_FAST_FREE =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IP_TNL_TSO =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SEND_ON_TIMESTAMP =3D auto()<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[f&quot;TX_OFFLOAD_=
{flag_name}&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls, per_port: bool) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_port: If :data:`True`, will =
return capabilities per port. If :data:`False`,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will return capabi=
lities per queue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 granularity =3D &quot;Port&quot; if per_port e=
lse &quot;Queue&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(rf&quot;Per {gra=
nularity}\s+:(.*)$&quot;, re.MULTILINE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_string,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+@dataclass<br>
+class TxOffloadCapabilities(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; tx_offload capabilities`` command.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_tx_offload_get_capa()``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:cmd_tx_offload_get_capa_parsed()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 port_id: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Tx Offlo=
ading Capabilities of port (\d+) :&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Per-queue Tx offload capabilities.<br>
+=C2=A0 =C2=A0 per_queue: TxOffloadCapability =3D field(metadata=3DTxOffloa=
dCapability.make_parser(False))<br>
+=C2=A0 =C2=A0 #: Capabilities other than per-queue Tx offload capabilities=
.<br>
+=C2=A0 =C2=A0 per_port: TxOffloadCapability =3D field(metadata=3DTxOffload=
Capability.make_parser(True))<br>
+<br>
+<br>
=C2=A0class RxOffloadCapability(Flag):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Rx offload capabilities of a device.<=
br>
<br>
@@ -2397,6 +2490,28 @@ def close(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=
=3D=3D=3D=3D<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
+=C2=A0 =C2=A0 def get_capabilities_tx_offload(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all TX offload capabilit=
ies and divide them into supported and unsupported.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting TX offload ca=
pabilities.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {self.ports[0].id=
} tx_offload capabilities&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_offload_capabilities_out =3D self.send_comm=
and(command)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_offload_capabilities =3D TxOffloadCapabilit=
ies.parse(tx_offload_capabilities_out)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_flag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TxOffloadCapability,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_offload_capabilities.per_port=
 | tx_offload_capabilities.per_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def get_capabilities_rx_offload(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_capabilities: MutableSet[&quot;=
NicCapability&quot;],<br>
@@ -2824,6 +2939,94 @@ class NicCapability(NoAliasEnum):<br>
=C2=A0 =C2=A0 =C2=A0we don&#39;t go looking for it again if a different tes=
t case also needs it.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability =3D (=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability =3D (<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability =3D (<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability =3D (<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability =3D (<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SECURITY: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability =3D (<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability =3D =
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_tx_offload,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
+=C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0#: Scattered packets Rx enabled<br>
=C2=A0 =C2=A0 =C2=A0SCATTERED_RX_ENABLED: TestPmdShellNicCapability =3D (<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TestPmdShell.get_capabilities_rxq_info,<b=
r>
-- <br>
2.50.1<br>
<br></blockquote><div><br></div><div>Looks good. Have you verified the docs=
 will build from this patch? If you haven&#39;t done this yet it&#39;s</div=
><div><br></div><div>meson setup my_build</div><div>ninja -C my_build doc</=
div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:pro=
bb@iol.unh.edu" target=3D"_blank">probb@iol.unh.edu</a>&gt;=C2=A0=C2=A0</di=
v></div></div>
</div>

--00000000000042fbd5063de9fad9--
