Return-Path: <dev-bounces@dpdk.org>
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3120CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 19:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A2D840647;
	Fri, 19 Sep 2025 21:51:35 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 835534042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 21:51:32 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7761a8a1dbcso2360000b3a.1
 for <dev@dpdk.org>; Fri, 19 Sep 2025 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758311491; x=1758916291; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BUjWOtf4WVodMfjCe/dkjihOvSkMKDSl9LzGMQtHnYU=;
 b=c+vWog+pGVFwv0mXHqXuWQTrHL+4Bos0EjjKHlPxHDoHArRIxqscHNGcr2f9pzAZXK
 jyTrVBsX+OdnOOe9nmdbVQR6We8gWUhW0Eq7m0JqjvbpkhVAT0vmWRRdONKLL5GZ9kSz
 YkZJ26NdLzgMtftqyakfQA0tQ+6krtf1cawFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758311491; x=1758916291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUjWOtf4WVodMfjCe/dkjihOvSkMKDSl9LzGMQtHnYU=;
 b=TAyfwpPinwj0/nuPXH2RH/ntvswFhrYar/8SyLMd6fsj3p/FGduAzeB75e4dnNKj2e
 PLt4T1EanoMxLgS7WvIU1u4cCdR75cpMmv33V7DqgJ4h5KrGOv7KiLh4P4v7HNikl15M
 y7oY1FhSnyeVWLMUuRBygJu2FOHDQ4dlHEmvru/Y6f+6NdUMNgaa5sSxMEYa9/w11Q7r
 L13023vqCtIcvPcOBU54+yf3gZJ7zAARQfACFRSyw1ySMkBd0M4P/pcPS0mulLPhW09W
 c3/hUx3t0CGWAyeYKEMQ10FCIMchAkQ+I3xEkPs45TR4HU4j3oDp23y7soVksCsTBLOW
 u6XQ==
X-Gm-Message-State: AOJu0YxPKBRkKTLF6V+7yd8nmWi57TNybaAyg6c6wcSiRWlvzsGtSGcV
 tJwOLTYks34Lj8jonq5vkTN2H9MbzdT7XObDGm1H1raq7jymvdl6f9ng/QZ2ZwC6R1MQdRB8UaB
 3pL67S8xaU65OgS6+1jxG0eOmWedY+5KPLiHawm0rXg==
X-Gm-Gg: ASbGncu7u+m3LTcAYxNZF5LL8R49DnAL8T2JIr/LFM4W70IwZl33MFPGZkc+o2wDirX
 jnQkBHmF0GFVgpnIIk87p28YoajwZKz82Oxm9qgQEaI92UMh7HSoKyMdCbz6wxLThuvUW3ykRra
 ja96k9eWvZ/Dq8UNWa0hAauhJDB5Vryzy+ZAUqrr3kLkQRufBAp1515b/HYqVDnT8KusXdI3Eic
 e2gI2AiCo8ZZFF/xJ898A==
X-Google-Smtp-Source: AGHT+IF9k26XSCd31aUMsDVs5+GwNn91dXX+83ShE8ypBYc7bSanqNrS8WTuMdiqW2OX6nIjn72HE2pLM6t3EjPWvMY=
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a50b with SMTP id
 adf61e73a8af0-292762e1e5emr6549970637.59.1758311490921; Fri, 19 Sep 2025
 12:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250829174312.2855311-1-paul.szczepanek@arm.com>
 <20250829174312.2855311-2-paul.szczepanek@arm.com>
In-Reply-To: <20250829174312.2855311-2-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Sep 2025 15:51:11 -0400
X-Gm-Features: AS18NWC4tSEUMdB5o2gocISbmb6Lp4fXD46RRy69FnXwo5pLel3PgEYi1YVjzlA
Message-ID: <CAJvnSUA7Ngaxb1Z09r-fA5W6fcRRJcr73barY70uOv+6k80U8A@mail.gmail.com>
Subject: Re: [RFC 1/2] dts: move testpmd into API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000d23d9c063f2ccb36"
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

--000000000000d23d9c063f2ccb36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series has been applied to next-dts.

I am noting here that patchwork CI results shows a checkpatches warning.
However, I have run checkpatches on this patch and it's reporting no
issues. My DPDK_CHECKPATCH_PATH and codespell dictionary seem fine. So, I
am confident enough that there is no issue to apply to next-dts. Ali please
let me know if you are concerned.

On Fri, Aug 29, 2025 at 1:43=E2=80=AFPM Paul Szczepanek <paul.szczepanek@ar=
m.com>
wrote:

> Testpmd moved into new API directory.
> Capabilities converted into vanilla enum and moved to API.
> Removed some ciruclar dependencies and incorrect imports.
>
> Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  doc/api/dts/api.capabilities.rst              |    8 +
>  doc/api/dts/api.rst                           |   20 +
>  ...stpmd_shell.rst =3D> api.testpmd.config.rst} |    4 +-
>  doc/api/dts/api.testpmd.rst                   |   15 +
>  doc/api/dts/api.testpmd.types.rst             |    8 +
>  doc/api/dts/framework.params.rst              |    1 -
>  doc/api/dts/framework.params.testpmd.rst      |    8 -
>  doc/api/dts/framework.remote_session.rst      |    1 -
>  doc/api/dts/index.rst                         |    1 +
>  dts/api/__init__.py                           |   14 +
>  dts/api/capabilities.py                       |  180 ++
>  dts/api/testpmd/__init__.py                   | 1294 ++++++++
>  .../testpmd.py =3D> api/testpmd/config.py}      |    9 +-
>  dts/api/testpmd/types.py                      | 1406 ++++++++
>  dts/framework/config/__init__.py              |    3 +-
>  dts/framework/params/eal.py                   |   12 +-
>  dts/framework/params/types.py                 |    4 +-
>  dts/framework/remote_session/__init__.py      |   44 -
>  dts/framework/remote_session/testpmd_shell.py | 2844 -----------------
>  dts/framework/testbed_model/capability.py     |  144 +-
>  dts/framework/testbed_model/linux_session.py  |    2 +-
>  dts/framework/testbed_model/os_session.py     |   14 +-
>  dts/framework/testbed_model/topology.py       |   30 +-
>  23 files changed, 3086 insertions(+), 2980 deletions(-)
>  create mode 100644 doc/api/dts/api.capabilities.rst
>  create mode 100644 doc/api/dts/api.rst
>  rename doc/api/dts/{framework.remote_session.testpmd_shell.rst =3D>
> api.testpmd.config.rst} (54%)
>  create mode 100644 doc/api/dts/api.testpmd.rst
>  create mode 100644 doc/api/dts/api.testpmd.types.rst
>  delete mode 100644 doc/api/dts/framework.params.testpmd.rst
>  create mode 100644 dts/api/__init__.py
>  create mode 100644 dts/api/capabilities.py
>  create mode 100644 dts/api/testpmd/__init__.py
>  rename dts/{framework/params/testpmd.py =3D> api/testpmd/config.py} (98%=
)
>  create mode 100644 dts/api/testpmd/types.py
>  delete mode 100644 dts/framework/remote_session/testpmd_shell.py
>
> diff --git a/doc/api/dts/api.capabilities.rst
> b/doc/api/dts/api.capabilities.rst
> new file mode 100644
> index 0000000000..311872f61d
> --- /dev/null
> +++ b/doc/api/dts/api.capabilities.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +capabilities - SUT Capabilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: api.capabilities
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/api.rst b/doc/api/dts/api.rst
> new file mode 100644
> index 0000000000..d3cf1226eb
> --- /dev/null
> +++ b/doc/api/dts/api.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +api - DTS API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: api
> +   :members:
> +   :show-inheritance:
> +
> +.. toctree::
> +   :hidden:
> +   :maxdepth: 2
> +
> +   api.testpmd
> +
> +.. toctree::
> +   :hidden:
> +   :maxdepth: 1
> +
> +   api.capabilities
> \ No newline at end of file
> diff --git a/doc/api/dts/framework.remote_session.testpmd_shell.rst
> b/doc/api/dts/api.testpmd.config.rst
> similarity index 54%
> rename from doc/api/dts/framework.remote_session.testpmd_shell.rst
> rename to doc/api/dts/api.testpmd.config.rst
> index 81ca23337f..d338c07a36 100644
> --- a/doc/api/dts/framework.remote_session.testpmd_shell.rst
> +++ b/doc/api/dts/api.testpmd.config.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: BSD-3-Clause
>
> -testpmd\_shell - Testpmd Interactive Remote Shell
> +config - Testpmd configuration
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -.. automodule:: framework.remote_session.testpmd_shell
> +.. automodule:: api.testpmd.config
>     :members:
>     :show-inheritance:
> diff --git a/doc/api/dts/api.testpmd.rst b/doc/api/dts/api.testpmd.rst
> new file mode 100644
> index 0000000000..75a92823f8
> --- /dev/null
> +++ b/doc/api/dts/api.testpmd.rst
> @@ -0,0 +1,15 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +testpmd - Testpmd Interactive Remote Shell
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: api.testpmd
> +   :members:
> +   :show-inheritance:
> +
> +.. toctree::
> +   :hidden:
> +   :maxdepth: 1
> +
> +   api.testpmd.types
> +   api.testpmd.config
> \ No newline at end of file
> diff --git a/doc/api/dts/api.testpmd.types.rst
> b/doc/api/dts/api.testpmd.types.rst
> new file mode 100644
> index 0000000000..75b197aa73
> --- /dev/null
> +++ b/doc/api/dts/api.testpmd.types.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +types - Testpmd types
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: api.testpmd.types
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/framework.params.rst
> b/doc/api/dts/framework.params.rst
> index 4e263e2e5c..d8c6af9667 100644
> --- a/doc/api/dts/framework.params.rst
> +++ b/doc/api/dts/framework.params.rst
> @@ -12,5 +12,4 @@ params - Command Line Parameters Modelling
>     :maxdepth: 1
>
>     framework.params.eal
> -   framework.params.testpmd
>     framework.params.types
> diff --git a/doc/api/dts/framework.params.testpmd.rst
> b/doc/api/dts/framework.params.testpmd.rst
> deleted file mode 100644
> index 19583b01de..0000000000
> --- a/doc/api/dts/framework.params.testpmd.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -testpmd - TestPMD Parameters Modelling
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -.. automodule:: framework.params.testpmd
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/framework.remote_session.rst
> b/doc/api/dts/framework.remote_session.rst
> index 27c9153e64..b7dbe71412 100644
> --- a/doc/api/dts/framework.remote_session.rst
> +++ b/doc/api/dts/framework.remote_session.rst
> @@ -18,5 +18,4 @@ remote\_session - Node Connections Package
>     framework.remote_session.shell_pool
>     framework.remote_session.dpdk
>     framework.remote_session.dpdk_shell
> -   framework.remote_session.testpmd_shell
>     framework.remote_session.python_shell
> diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
> index a11f395e11..c719297c11 100644
> --- a/doc/api/dts/index.rst
> +++ b/doc/api/dts/index.rst
> @@ -15,6 +15,7 @@ Packages
>     :maxdepth: 1
>
>     tests
> +   api
>     framework.testbed_model
>     framework.remote_session
>     framework.params
> diff --git a/dts/api/__init__.py b/dts/api/__init__.py
> new file mode 100644
> index 0000000000..26b773bfbb
> --- /dev/null
> +++ b/dts/api/__init__.py
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""DTS API.
> +
> +This package exposes public API modules for test writers.
> +
> +All modules in this package are considered stable. Do not use framework
> +internal modules in your tests. Any missing functionality should be adde=
d
> +to the public API.
> +
> +Private methods and members are prefixed with an underscore and should
> not be
> +used outside of the framework.
> +"""
> diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
> new file mode 100644
> index 0000000000..1a79413f6f
> --- /dev/null
> +++ b/dts/api/capabilities.py
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2024 PANTHEON.tech s.r.o.
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Testbed capabilities.
> +
> +This module provides a protocol that defines the common attributes of
> test cases and suites
> +and support for test environment capabilities.
> +
> +Many test cases are testing features not available on all hardware.
> +On the other hand, some test cases or suites may not need the most
> complex topology available.
> +
> +The module allows developers to mark test cases or suites to require
> certain hardware capabilities
> +or a particular topology.
> +
> +There are differences between hardware and topology capabilities:
> +
> +    * Hardware capabilities are assumed to not be required when not
> specified.
> +    * However, some topology is always available, so each test case or
> suite is assigned
> +      a default topology if no topology is specified in the decorator.
> +
> +Examples:
> +    .. code:: python
> +
> +        from framework.test_suite import TestSuite, func_test
> +        from framework.testbed_model.capability import LinkTopology,
> requires_link_topology
> +        # The whole test suite (each test case within) doesn't require
> any links.
> +        @requires_link_topology(LinkTopology.NO_LINK)
> +        @func_test
> +        class TestHelloWorld(TestSuite):
> +            def hello_world_single_core(self):
> +            ...
> +
> +    .. code:: python
> +
> +        from framework.test_suite import TestSuite, func_test
> +        from framework.testbed_model.capability import NicCapability,
> requires_nic_capability
> +        class TestPmdBufferScatter(TestSuite):
> +            # only the test case requires the SCATTERED_RX_ENABLED
> capability
> +            # other test cases may not require it
> +            @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
> +            @func_test
> +            def test_scatter_mbuf_2048(self):
> +"""
> +
> +from enum import IntEnum, auto
> +from typing import TYPE_CHECKING, Callable
> +
> +if TYPE_CHECKING:
> +    from framework.test_suite import TestProtocol
> +
> +
> +class LinkTopology(IntEnum):
> +    """Supported topology types."""
> +
> +    #: A topology with no Traffic Generator.
> +    NO_LINK =3D 0
> +    #: A topology with one physical link between the SUT node and the TG
> node.
> +    ONE_LINK =3D auto()
> +    #: A topology with two physical links between the Sut node and the T=
G
> node.
> +    TWO_LINKS =3D auto()
> +
> +    @classmethod
> +    def default(cls) -> "LinkTopology":
> +        """The default topology required by test cases if not specified
> otherwise."""
> +        return cls.TWO_LINKS
> +
> +
> +class NicCapability(IntEnum):
> +    """DPDK NIC capabilities.
> +
> +    The capabilities are used to mark test cases or suites that require =
a
> specific
> +    DPDK NIC capability to run. The capabilities are used by the test
> framework to
> +    determine whether a test case or suite can be run on the current
> testbed.
> +    """
> +
> +    #: Scattered packets Rx enabled.
> +    SCATTERED_RX_ENABLED =3D 0
> +    #: Device supports VLAN stripping.
> +    RX_OFFLOAD_VLAN_STRIP =3D auto()
> +    #: Device supports L3 checksum offload.
> +    RX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_UDP_CKSUM =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_TCP_CKSUM =3D auto()
> +    #: Device supports Large Receive Offload.
> +    RX_OFFLOAD_TCP_LRO =3D auto()
> +    #: Device supports QinQ (queue in queue) offload.
> +    RX_OFFLOAD_QINQ_STRIP =3D auto()
> +    #: Device supports inner packet L3 checksum.
> +    RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    #: Device supports MACsec.
> +    RX_OFFLOAD_MACSEC_STRIP =3D auto()
> +    #: Device supports filtering of a VLAN Tag identifier.
> +    RX_OFFLOAD_VLAN_FILTER =3D auto()
> +    #: Device supports VLAN offload.
> +    RX_OFFLOAD_VLAN_EXTEND =3D auto()
> +    #: Device supports receiving segmented mbufs.
> +    RX_OFFLOAD_SCATTER =3D auto()
> +    #: Device supports Timestamp.
> +    RX_OFFLOAD_TIMESTAMP =3D auto()
> +    #: Device supports crypto processing while packet is received in NIC=
.
> +    RX_OFFLOAD_SECURITY =3D auto()
> +    #: Device supports CRC stripping.
> +    RX_OFFLOAD_KEEP_CRC =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    #: Device supports inner packet L4 checksum.
> +    RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    #: Device supports RSS hashing.
> +    RX_OFFLOAD_RSS_HASH =3D auto()
> +    #: Device supports scatter Rx packets to segmented mbufs.
> +    RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> +    #: Device supports all checksum capabilities.
> +    RX_OFFLOAD_CHECKSUM =3D auto()
> +    #: Device supports all VLAN capabilities.
> +    RX_OFFLOAD_VLAN =3D auto()
> +    #: Device supports Rx queue setup after device started.
> +    RUNTIME_RX_QUEUE_SETUP =3D auto()
> +    #: Device supports Tx queue setup after device started.
> +    RUNTIME_TX_QUEUE_SETUP =3D auto()
> +    #: Device supports shared Rx queue among ports within Rx domain and
> switch domain.
> +    RXQ_SHARE =3D auto()
> +    #: Device supports keeping flow rules across restart.
> +    FLOW_RULE_KEEP =3D auto()
> +    #: Device supports keeping shared flow objects across restart.
> +    FLOW_SHARED_OBJECT_KEEP =3D auto()
> +    #: Device supports multicast address filtering.
> +    MCAST_FILTERING =3D auto()
> +    #: Device supports flow ctrl.
> +    FLOW_CTRL =3D auto()
> +    #: Device is running on a physical function.
> +    PHYSICAL_FUNCTION =3D auto()
> +
> +
> +def requires_link_topology(
> +    link_topology: LinkTopology,
> +) -> Callable[[type["TestProtocol"]], type["TestProtocol"]]:
> +    """Decorator to set required topology type for a test case or test
> suite.
> +
> +    Args:
> +        link_topology: The topology type the test suite or case requires=
.
> +
> +    Returns:
> +        The decorated test case or test suite.
> +    """
> +    from framework.testbed_model.capability import TopologyCapability
> +
> +    def add_required_topology(
> +        test_case_or_suite: type["TestProtocol"],
> +    ) -> type["TestProtocol"]:
> +        topology_capability =3D TopologyCapability.get_unique(link_topol=
ogy)
> +        topology_capability.set_required(test_case_or_suite)
> +        return test_case_or_suite
> +
> +    return add_required_topology
> +
> +
> +def requires_nic_capability(
> +    nic_capability: NicCapability,
> +) -> Callable[[type["TestProtocol"]], type["TestProtocol"]]:
> +    """Decorator to add a single required NIC capability to a test case
> or test suite.
> +
> +    Args:
> +        nic_capability: The NIC capability that is required by the test
> case or test suite.
> +
> +    Returns:
> +        The decorated test case or test suite.
> +    """
> +    from framework.testbed_model.capability import DecoratedNicCapabilit=
y
> +
> +    def add_required_capability(
> +        test_case_or_suite: type["TestProtocol"],
> +    ) -> type["TestProtocol"]:
> +        decorated =3D DecoratedNicCapability.get_unique(nic_capability)
> +        decorated.add_to_required(test_case_or_suite)
> +        return test_case_or_suite
> +
> +    return add_required_capability
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> new file mode 100644
> index 0000000000..49cf3742dd
> --- /dev/null
> +++ b/dts/api/testpmd/__init__.py
> @@ -0,0 +1,1294 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2023 University of New Hampshire
> +# Copyright(c) 2023 PANTHEON.tech s.r.o.
> +# Copyright(c) 2024 Arm Limited
> +
> +"""Testpmd interactive shell.
> +
> +Typical usage example in a TestSuite::
> +
> +    testpmd =3D TestPmd(self.sut_node)
> +    devices =3D testpmd.get_devices()
> +    for device in devices:
> +        print(device)
> +    testpmd.close()
> +"""
> +
> +import functools
> +import re
> +import time
> +from collections.abc import MutableSet
> +from enum import Flag
> +from pathlib import PurePath
> +from typing import (
> +    Any,
> +    Callable,
> +    ClassVar,
> +    Concatenate,
> +    ParamSpec,
> +    Tuple,
> +)
> +
> +from typing_extensions import Unpack
> +
> +from api.capabilities import LinkTopology, NicCapability
> +from api.testpmd.config import PortTopology, SimpleForwardingModes,
> TestPmdParams
> +from api.testpmd.types import (
> +    ChecksumOffloadOptions,
> +    DeviceCapabilitiesFlag,
> +    FlowRule,
> +    RxOffloadCapabilities,
> +    RxOffloadCapability,
> +    TestPmdDevice,
> +    TestPmdPort,
> +    TestPmdPortFlowCtrl,
> +    TestPmdPortStats,
> +    TestPmdQueueInfo,
> +    TestPmdRxqInfo,
> +    TestPmdVerbosePacket,
> +    VLANOffloadFlag,
> +)
> +from framework.context import get_ctx
> +from framework.exception import InteractiveCommandExecutionError,
> InternalError
> +from framework.params.types import TestPmdParamsDict
> +from framework.remote_session.dpdk_shell import DPDKShell
> +from framework.remote_session.interactive_shell import only_active
> +from framework.settings import SETTINGS
> +
> +P =3D ParamSpec("P")
> +TestPmdMethod =3D Callable[Concatenate["TestPmd", P], Any]
> +
> +
> +def _requires_stopped_ports(func: TestPmdMethod) -> TestPmdMethod:
> +    """Decorator for :class:`TestPmd` commands methods that require
> stopped ports.
> +
> +    If the decorated method is called while the ports are started, then
> these are stopped before
> +    continuing.
> +
> +    Args:
> +        func: The :class:`TestPmd` method to decorate.
> +    """
> +
> +    @functools.wraps(func)
> +    def _wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs):
> +        if self.ports_started:
> +            self._logger.debug("Ports need to be stopped to continue.")
> +            self.stop_all_ports()
> +
> +        return func(self, *args, **kwargs)
> +
> +    return _wrapper
> +
> +
> +def _requires_started_ports(func: TestPmdMethod) -> TestPmdMethod:
> +    """Decorator for :class:`TestPmd` commands methods that require
> started ports.
> +
> +    If the decorated method is called while the ports are stopped, then
> these are started before
> +    continuing.
> +
> +    Args:
> +        func: The :class:`TestPmd` method to decorate.
> +    """
> +
> +    @functools.wraps(func)
> +    def _wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs):
> +        if not self.ports_started:
> +            self._logger.debug("Ports need to be started to continue.")
> +            self.start_all_ports()
> +
> +        return func(self, *args, **kwargs)
> +
> +    return _wrapper
> +
> +
> +def _add_remove_mtu(mtu: int =3D 1500) -> Callable[[TestPmdMethod],
> TestPmdMethod]:
> +    """Configure MTU to `mtu` on all ports, run the decorated function,
> then revert.
> +
> +    Args:
> +        mtu: The MTU to configure all ports on.
> +
> +    Returns:
> +        The method decorated with setting and reverting MTU.
> +    """
> +
> +    def decorator(func: TestPmdMethod) -> TestPmdMethod:
> +        @functools.wraps(func)
> +        def wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs):
> +            original_mtu =3D self.ports[0].mtu
> +            self.set_port_mtu_all(mtu=3Dmtu, verify=3DFalse)
> +            retval =3D func(self, *args, **kwargs)
> +            self.set_port_mtu_all(original_mtu if original_mtu else 1500=
,
> verify=3DFalse)
> +            return retval
> +
> +        return wrapper
> +
> +    return decorator
> +
> +
> +class TestPmd(DPDKShell):
> +    """Testpmd interactive shell.
> +
> +    The testpmd shell users should never use
> +    the :meth:`~.interactive_shell.InteractiveShell.send_command` method
> directly, but rather
> +    call specialized methods. If there isn't one that satisfies a need,
> it should be added.
> +
> +    Attributes:
> +        ports_started: Indicates whether the ports are started.
> +    """
> +
> +    _app_params: TestPmdParams
> +    _ports: list[TestPmdPort] | None
> +
> +    #: The testpmd's prompt.
> +    _default_prompt: ClassVar[str] =3D "testpmd>"
> +
> +    #: This forces the prompt to appear after sending a command.
> +    _command_extra_chars: ClassVar[str] =3D "\n"
> +
> +    ports_started: bool
> +
> +    def __init__(
> +        self,
> +        name: str | None =3D None,
> +        privileged: bool =3D True,
> +        **app_params: Unpack[TestPmdParamsDict],
> +    ) -> None:
> +        """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes
> app_params to kwargs."""
> +        if "port_topology" not in app_params and get_ctx().topology.type
> is LinkTopology.ONE_LINK:
> +            app_params["port_topology"] =3D PortTopology.loop
> +        super().__init__(name, privileged,
> app_params=3DTestPmdParams(**app_params))
> +        self.ports_started =3D not self._app_params.disable_device_start
> +        self._ports =3D None
> +
> +    @property
> +    def path(self) -> PurePath:
> +        """The path to the testpmd executable."""
> +        return PurePath("app/dpdk-testpmd")
> +
> +    @property
> +    def ports(self) -> list[TestPmdPort]:
> +        """The ports of the instance.
> +
> +        This caches the ports returned by :meth:`show_port_info_all`.
> +        To force an update of port information, execute
> :meth:`show_port_info_all` or
> +        :meth:`show_port_info`.
> +
> +        Returns: The list of known testpmd ports.
> +        """
> +        if self._ports is None:
> +            return self.show_port_info_all()
> +        return self._ports
> +
> +    @_requires_started_ports
> +    def start(self, verify: bool =3D True) -> None:
> +        """Start packet forwarding with the current configuration.
> +
> +        Args:
> +            verify: If :data:`True` , a second start command will be sen=
t
> in an attempt to verify
> +                packet forwarding started as expected.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and forwarding fails to
> +                start or ports fail to come up.
> +        """
> +        self.send_command("start")
> +        if verify:
> +            # If forwarding was already started, sending "start" again
> should tell us
> +            start_cmd_output =3D self.send_command("start")
> +            if "Packet forwarding already started" not in
> start_cmd_output:
> +                self._logger.debug(f"Failed to start packet forwarding:
> \n{start_cmd_output}")
> +                raise InteractiveCommandExecutionError("Testpmd failed t=
o
> start packet forwarding.")
> +
> +    def stop(self, verify: bool =3D True) -> str:
> +        """Stop packet forwarding.
> +
> +        Args:
> +            verify: If :data:`True` , the output of the stop command is
> scanned to verify that
> +                forwarding was stopped successfully or not started. If
> neither is found, it is
> +                considered an error.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command to stop
> +                forwarding results in an error.
> +
> +        Returns:
> +            Output gathered from the stop command and all other precedin=
g
> logs in the buffer. This
> +            output is most often used to view forwarding statistics that
> are displayed when this
> +            command is sent as well as any verbose packet information
> that hasn't been consumed
> +            prior to calling this method.
> +        """
> +        stop_cmd_output =3D self.send_command("stop")
> +        if verify:
> +            if (
> +                "Done." not in stop_cmd_output
> +                and "Packet forwarding not started" not in stop_cmd_outp=
ut
> +            ):
> +                self._logger.debug(f"Failed to stop packet forwarding:
> \n{stop_cmd_output}")
> +                raise InteractiveCommandExecutionError("Testpmd failed t=
o
> stop packet forwarding.")
> +        return stop_cmd_output
> +
> +    def get_devices(self) -> list[TestPmdDevice]:
> +        """Get a list of device names that are known to testpmd.
> +
> +        Uses the device info listed in testpmd and then parses the outpu=
t.
> +
> +        Returns:
> +            A list of devices.
> +        """
> +        dev_info: str =3D self.send_command("show device info all")
> +        dev_list: list[TestPmdDevice] =3D []
> +        for line in dev_info.split("\n"):
> +            if "device name:" in line.lower():
> +                dev_list.append(TestPmdDevice(line))
> +        return dev_list
> +
> +    def wait_link_status_up(self, port_id: int, timeout=3DSETTINGS.timeo=
ut)
> -> bool:
> +        """Wait until the link status on the given port is "up".
> +
> +        Arguments:
> +            port_id: Port to check the link status on.
> +            timeout: Time to wait for the link to come up. The default
> value for this
> +                argument may be modified using the :option:`--timeout`
> command-line argument
> +                or the :envvar:`DTS_TIMEOUT` environment variable.
> +
> +        Returns:
> +            Whether the link came up in time or not.
> +        """
> +        time_to_stop =3D time.time() + timeout
> +        port_info: str =3D ""
> +        while time.time() < time_to_stop:
> +            port_info =3D self.send_command(f"show port info {port_id}")
> +            if "Link status: up" in port_info:
> +                break
> +            time.sleep(0.5)
> +        else:
> +            self._logger.error(f"The link for port {port_id} did not com=
e
> up in the given timeout.")
> +        return "Link status: up" in port_info
> +
> +    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool
> =3D True):
> +        """Set packet forwarding mode.
> +
> +        Args:
> +            mode: The forwarding mode to use.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that the forwarding mode was set to `mode`
> properly.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the forwarding mode
> +                fails to update.
> +        """
> +        set_fwd_output =3D self.send_command(f"set fwd {mode.value}")
> +        if verify:
> +            if f"Set {mode.value} packet forwarding mode" not in
> set_fwd_output:
> +                self._logger.debug(f"Failed to set fwd mode to
> {mode.value}:\n{set_fwd_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Test pmd failed to set fwd mode to {mode.value}"
> +                )
> +
> +    def stop_all_ports(self, verify: bool =3D True) -> None:
> +        """Stops all the ports.
> +
> +        Args:
> +            verify: If :data:`True`, the output of the command will be
> checked for a successful
> +                execution.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the ports were not
> +                stopped successfully.
> +        """
> +        self._logger.debug("Stopping all the ports...")
> +        output =3D self.send_command("port stop all")
> +        if verify and not output.strip().endswith("Done"):
> +            raise InteractiveCommandExecutionError("Ports were not
> stopped successfully.")
> +
> +        self.ports_started =3D False
> +
> +    def start_all_ports(self, verify: bool =3D True) -> None:
> +        """Starts all the ports.
> +
> +        Args:
> +            verify: If :data:`True`, the output of the command will be
> checked for a successful
> +                execution.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the ports were not
> +                started successfully.
> +        """
> +        self._logger.debug("Starting all the ports...")
> +        output =3D self.send_command("port start all")
> +        if verify and not output.strip().endswith("Done"):
> +            raise InteractiveCommandExecutionError("Ports were not
> started successfully.")
> +
> +        self.ports_started =3D True
> +
> +    @_requires_stopped_ports
> +    def set_ports_queues(self, number_of: int) -> None:
> +        """Sets the number of queues per port.
> +
> +        Args:
> +            number_of: The number of RX/TX queues to create per port.
> +
> +        Raises:
> +            InternalError: If `number_of` is invalid.
> +        """
> +        if number_of < 1:
> +            raise InternalError("The number of queues must be positive
> and non-zero.")
> +
> +        self.send_command(f"port config all rxq {number_of}")
> +        self.send_command(f"port config all txq {number_of}")
> +
> +    @_requires_stopped_ports
> +    def close_all_ports(self, verify: bool =3D True) -> None:
> +        """Close all ports.
> +
> +        Args:
> +            verify: If :data:`True` the output of the close command will
> be scanned in an attempt
> +                to verify that all ports were stopped successfully.
> Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and at lease one port
> +                failed to close.
> +        """
> +        port_close_output =3D self.send_command("port close all")
> +        if verify:
> +            num_ports =3D len(self.ports)
> +            if not all(f"Port {p_id} is closed" in port_close_output for
> p_id in range(num_ports)):
> +                raise InteractiveCommandExecutionError("Ports were not
> closed successfully.")
> +
> +    def show_port_info_all(self) -> list[TestPmdPort]:
> +        """Returns the information of all the ports.
> +
> +        Returns:
> +            list[TestPmdPort]: A list containing all the ports
> information as `TestPmdPort`.
> +        """
> +        output =3D self.send_command("show port info all")
> +
> +        # Sample output of the "all" command looks like:
> +        #
> +        # <start>
> +        #
> +        #   ********************* Infos for port 0 *********************
> +        #   Key: value
> +        #
> +        #   ********************* Infos for port 1 *********************
> +        #   Key: value
> +        # <end>
> +        #
> +        # Takes advantage of the double new line in between ports as end
> delimiter. But we need to
> +        # artificially add a new line at the end to pick up the last
> port. Because commands are
> +        # executed on a pseudo-terminal created by paramiko on the remot=
e
> node, lines end with CRLF.
> +        # Therefore we also need to take the carriage return into accoun=
t.
> +        iter =3D re.finditer(r"\*{21}.*?[\r\n]{4}", output + "\r\n", re.=
S)
> +        self._ports =3D [TestPmdPort.parse(block.group(0)) for block in
> iter]
> +        return self._ports
> +
> +    def show_port_info(self, port_id: int) -> TestPmdPort:
> +        """Returns the given port information.
> +
> +        Args:
> +            port_id: The port ID to gather information for.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `port_id` is invalid.
> +
> +        Returns:
> +            TestPmdPort: An instance of `TestPmdPort` containing the
> given port's information.
> +        """
> +        output =3D self.send_command(f"show port info {port_id}",
> skip_first_line=3DTrue)
> +        if output.startswith("Invalid port"):
> +            raise InteractiveCommandExecutionError("invalid port given")
> +
> +        port =3D TestPmdPort.parse(output)
> +        self._update_port(port)
> +        return port
> +
> +    def _update_port(self, port: TestPmdPort) -> None:
> +        if self._ports:
> +            self._ports =3D [
> +                existing_port if port.id !=3D existing_port.id else port
> +                for existing_port in self._ports
> +            ]
> +
> +    def set_mac_addr(self, port_id: int, mac_address: str, add: bool,
> verify: bool =3D True) -> None:
> +        """Add or remove a mac address on a given port's Allowlist.
> +
> +        Args:
> +            port_id: The port ID the mac address is set on.
> +            mac_address: The mac address to be added to or removed from
> the specified port.
> +            add: If :data:`True`, add the specified mac address. If
> :data:`False`, remove specified
> +                mac address.
> +            verify: If :data:'True', assert that the 'mac_addr' operatio=
n
> was successful. If
> +                :data:'False', run the command and skip this assertion.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If the set mac address
> operation fails.
> +        """
> +        mac_cmd =3D "add" if add else "remove"
> +        output =3D self.send_command(f"mac_addr {mac_cmd} {port_id}
> {mac_address}")
> +        if "Bad arguments" in output:
> +            self._logger.debug("Invalid argument provided to mac_addr")
> +            raise InteractiveCommandExecutionError("Invalid argument
> provided")
> +
> +        if verify:
> +            if "mac_addr_cmd error:" in output:
> +                self._logger.debug(f"Failed to {mac_cmd} {mac_address} o=
n
> port {port_id}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to {mac_cmd} {mac_address} on port {port_id=
}
> \n{output}"
> +                )
> +
> +    def set_multicast_mac_addr(
> +        self, port_id: int, multi_addr: str, add: bool, verify: bool =3D
> True
> +    ) -> None:
> +        """Add or remove multicast mac address to a specified port's
> allow list.
> +
> +        Args:
> +            port_id: The port ID the multicast address is set on.
> +            multi_addr: The multicast address to be added or removed fro=
m
> the filter.
> +            add: If :data:'True', add the specified multicast address to
> the port filter.
> +                If :data:'False', remove the specified multicast address
> from the port filter.
> +            verify: If :data:'True', assert that the 'mcast_addr'
> operations was successful.
> +                If :data:'False', execute the 'mcast_addr' operation and
> skip the assertion.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If either the 'add' or
> 'remove' operations fails.
> +        """
> +        mcast_cmd =3D "add" if add else "remove"
> +        output =3D self.send_command(f"mcast_addr {mcast_cmd} {port_id}
> {multi_addr}")
> +        if "Bad arguments" in output:
> +            self._logger.debug("Invalid arguments provided to mcast_addr=
")
> +            raise InteractiveCommandExecutionError("Invalid argument
> provided")
> +
> +        if verify:
> +            if (
> +                "Invalid multicast_addr" in output
> +                or f"multicast address {'already' if add else 'not'}
> filtered by port" in output
> +            ):
> +                self._logger.debug(f"Failed to {mcast_cmd} {multi_addr}
> on port {port_id}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to {mcast_cmd} {multi_addr} on port
> {port_id} \n{output}"
> +                )
> +
> +    def show_port_stats_all(self) -> Tuple[list[TestPmdPortStats], str]:
> +        """Returns the statistics of all the ports.
> +
> +        Returns:
> +            Tuple[str, list[TestPmdPortStats]]: A tuple where the first
> element is the stats of all
> +            ports as `TestPmdPortStats` and second is the raw testpmd
> output that was collected
> +            from the sent command.
> +        """
> +        output =3D self.send_command("show port stats all")
> +
> +        # Sample output of the "all" command looks like:
> +        #
> +        #   ########### NIC statistics for port 0 ###########
> +        #   values...
> +        #   #################################################
> +        #
> +        #   ########### NIC statistics for port 1 ###########
> +        #   values...
> +        #   #################################################
> +        #
> +        iter =3D re.finditer(r"(^  #*.+#*$[^#]+)^  #*\r$", output,
> re.MULTILINE)
> +        return ([TestPmdPortStats.parse(block.group(1)) for block in
> iter], output)
> +
> +    def show_port_stats(self, port_id: int) -> TestPmdPortStats:
> +        """Returns the given port statistics.
> +
> +        Args:
> +            port_id: The port ID to gather information for.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `port_id` is invalid.
> +
> +        Returns:
> +            TestPmdPortStats: An instance of `TestPmdPortStats`
> containing the given port's stats.
> +        """
> +        output =3D self.send_command(f"show port stats {port_id}",
> skip_first_line=3DTrue)
> +        if output.startswith("Invalid port"):
> +            raise InteractiveCommandExecutionError("invalid port given")
> +
> +        return TestPmdPortStats.parse(output)
> +
> +    def set_multicast_all(self, on: bool, verify: bool =3D True) -> None=
:
> +        """Turns multicast mode on/off for the specified port.
> +
> +        Args:
> +            on: If :data:`True`, turns multicast mode on, otherwise turn=
s
> off.
> +            verify: If :data:`True` an additional command will be sent t=
o
> verify
> +                that multicast mode is properly set. Defaults to
> :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and multicast
> +                mode is not properly set.
> +        """
> +        multicast_cmd_output =3D self.send_command(f"set allmulti all {'=
on'
> if on else 'off'}")
> +        if verify:
> +            port_stats =3D self.show_port_info_all()
> +            if on ^ all(stats.is_allmulticast_mode_enabled for stats in
> port_stats):
> +                self._logger.debug(
> +                    f"Failed to set multicast mode on all ports.:
> \n{multicast_cmd_output}"
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    "Testpmd failed to set multicast mode on all ports."
> +                )
> +
> +    @_requires_stopped_ports
> +    def csum_set_hw(
> +        self, layers: ChecksumOffloadOptions, port_id: int, verify: bool
> =3D True
> +    ) -> None:
> +        """Enables hardware checksum offloading on the specified layer.
> +
> +        Args:
> +            layers: The layer/layers that checksum offloading should be
> enabled on.
> +            port_id: The port number to enable checksum offloading on,
> should be within 0-32.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that checksum offloading was enabled on the port.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If checksum offload is not
> enabled successfully.
> +        """
> +        for name, offload in ChecksumOffloadOptions.__members__.items():
> +            if offload in layers:
> +                name =3D name.replace("_", "-")
> +                csum_output =3D self.send_command(f"csum set {name} hw
> {port_id}")
> +                if verify:
> +                    if (
> +                        "Bad arguments" in csum_output
> +                        or f"Please stop port {port_id} first" in
> csum_output
> +                        or f"checksum offload is not supported by port
> {port_id}" in csum_output
> +                    ):
> +                        self._logger.debug(f"Csum set hw
> error:\n{csum_output}")
> +                        raise InteractiveCommandExecutionError(
> +                            f"Failed to set csum hw {name} mode on port
> {port_id}"
> +                        )
> +                success =3D False
> +                if f"{name} checksum offload is hw" in
> csum_output.lower():
> +                    success =3D True
> +                if not success and verify:
> +                    self._logger.debug(
> +                        f"Failed to set csum hw mode on port
> {port_id}:\n{csum_output}"
> +                    )
> +                    raise InteractiveCommandExecutionError(
> +                        f"""Failed to set csum hw mode on port
> +
>  {port_id}:\n{csum_output}"""
> +                    )
> +
> +    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
> +        """Creates a flow rule in the testpmd session.
> +
> +        This command is implicitly verified as needed to return the
> created flow rule id.
> +
> +        Args:
> +            flow_rule: :class:`FlowRule` object used for creating testpm=
d
> flow rule.
> +            port_id: Integer representing the port to use.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If flow rule is invalid.
> +
> +        Returns:
> +            Id of created flow rule.
> +        """
> +        flow_output =3D self.send_command(f"flow create {port_id}
> {flow_rule}")
> +        match =3D re.search(r"#(\d+)", flow_output)
> +        if match is not None:
> +            match_str =3D match.group(1)
> +            flow_id =3D int(match_str)
> +            return flow_id
> +        else:
> +            self._logger.debug(f"Failed to create flow
> rule:\n{flow_output}")
> +            raise InteractiveCommandExecutionError(f"Failed to create
> flow rule:\n{flow_output}")
> +
> +    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
> +        """Validates a flow rule in the testpmd session.
> +
> +        Args:
> +            flow_rule: :class:`FlowRule` object used for validating
> testpmd flow rule.
> +            port_id: Integer representing the port to use.
> +
> +        Returns:
> +            Boolean representing whether rule is valid or not.
> +        """
> +        flow_output =3D self.send_command(f"flow validate {port_id}
> {flow_rule}")
> +        if "Flow rule validated" in flow_output:
> +            return True
> +        return False
> +
> +    def flow_delete(self, flow_id: int, port_id: int, verify: bool =3D
> True) -> None:
> +        """Deletes the specified flow rule from the testpmd session.
> +
> +        Args:
> +            flow_id: ID of the flow to remove.
> +            port_id: Integer representing the port to use.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> +                to ensure the flow rule was deleted successfully.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If flow rule is invalid.
> +        """
> +        flow_output =3D self.send_command(f"flow destroy {port_id} rule
> {flow_id}")
> +        if verify:
> +            if "destroyed" not in flow_output:
> +                self._logger.debug(f"Failed to delete flow
> rule:\n{flow_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to delete flow rule:\n{flow_output}"
> +                )
> +
> +    @_requires_started_ports
> +    @_requires_stopped_ports
> +    def set_port_mtu(self, port_id: int, mtu: int, verify: bool =3D True=
)
> -> None:
> +        """Change the MTU of a port using testpmd.
> +
> +        Some PMDs require that the port be stopped before changing the
> MTU, and it does no harm to
> +        stop the port before configuring in cases where it isn't
> required, so ports are stopped
> +        prior to changing their MTU. On the other hand, some PMDs requir=
e
> that the port had already
> +        been started once since testpmd startup. Therefore, ports are
> also started before stopping
> +        them to ensure this has happened.
> +
> +        Args:
> +            port_id: ID of the port to adjust the MTU on.
> +            mtu: Desired value for the MTU to be set to.
> +            verify: If `verify` is :data:`True` then the output will be
> scanned in an attempt to
> +                verify that the mtu was properly set on the port.
> Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the MTU was not
> +                properly updated on the port matching `port_id`.
> +        """
> +        set_mtu_output =3D self.send_command(f"port config mtu {port_id}
> {mtu}")
> +        if verify and (f"MTU: {mtu}" not in self.send_command(f"show por=
t
> info {port_id}")):
> +            self._logger.debug(
> +                f"Failed to set mtu to {mtu} on port {port_id}. Output
> was:\n{set_mtu_output}"
> +            )
> +            raise InteractiveCommandExecutionError(
> +                f"Test pmd failed to update mtu of port {port_id} to
> {mtu}"
> +            )
> +
> +    def set_port_mtu_all(self, mtu: int, verify: bool =3D True) -> None:
> +        """Change the MTU of all ports using testpmd.
> +
> +        Runs :meth:`set_port_mtu` for every port that testpmd is aware o=
f.
> +
> +        Args:
> +            mtu: Desired value for the MTU to be set to.
> +            verify: Whether to verify that setting the MTU on each port
> was successful or not.
> +                Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the MTU was not
> +                properly updated on at least one port.
> +        """
> +        for port in self.ports:
> +            self.set_port_mtu(port.id, mtu, verify)
> +
> +    @staticmethod
> +    def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket=
]:
> +        """Extract the verbose information present in given testpmd
> output.
> +
> +        This method extracts sections of verbose output that begin with
> the line
> +        "port X/queue Y: sent/received Z packets" and end with the
> ol_flags of a packet.
> +
> +        Args:
> +            output: Testpmd output that contains verbose information
> +
> +        Returns:
> +            List of parsed packet information gathered from verbose
> information in `output`.
> +        """
> +        out: list[TestPmdVerbosePacket] =3D []
> +        prev_header: str =3D ""
> +        iter =3D re.finditer(
> +            r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+
> packets)?)\s*"
> +            r"(?P<PACKET>src=3D[\w\s=3D:-]+?ol_flags: [\w ]+)",
> +            output,
> +        )
> +        for match in iter:
> +            if match.group("HEADER"):
> +                prev_header =3D match.group("HEADER")
> +
> out.append(TestPmdVerbosePacket.parse(f"{prev_header}\n{match.group('PACK=
ET')}"))
> +        return out
> +
> +    @_requires_stopped_ports
> +    def set_vlan_filter(self, port: int, enable: bool, verify: bool =3D
> True) -> None:
> +        """Set vlan filter on.
> +
> +        Args:
> +            port: The port number to enable VLAN filter on.
> +            enable: Enable the filter on `port` if :data:`True`,
> otherwise disable it.
> +            verify: If :data:`True`, the output of the command and show
> port info
> +                is scanned to verify that vlan filtering was set
> successfully.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the filter
> +                fails to update.
> +        """
> +        filter_cmd_output =3D self.send_command(f"vlan set filter {'on' =
if
> enable else 'off'} {port}")
> +        if verify:
> +            vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
> +            if enable ^ (vlan_settings is not None and
> VLANOffloadFlag.FILTER in vlan_settings):
> +                self._logger.debug(
> +                    f"""Failed to {"enable" if enable else "disable"}
> +                                   filter on port {port}:
> \n{filter_cmd_output}"""
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"""Failed to {"enable" if enable else "disable"}
> +                    filter on port {port}"""
> +                )
> +
> +    def set_mac_address(self, port: int, mac_address: str, verify: bool =
=3D
> True) -> None:
> +        """Set port's MAC address.
> +
> +        Args:
> +            port: The number of the requested port.
> +            mac_address: The MAC address to set.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> +                the mac address is set in the specified port.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command
> +                fails to execute.
> +        """
> +        output =3D self.send_command(f"mac_addr set {port} {mac_address}=
",
> skip_first_line=3DTrue)
> +        if verify:
> +            if output.strip():
> +                self._logger.debug(
> +                    f"Testpmd failed to set MAC address {mac_address} on
> port {port}."
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set MAC address {mac_address} on
> port {port}."
> +                )
> +
> +    def set_flow_control(
> +        self, port: int, flow_ctrl: TestPmdPortFlowCtrl, verify: bool =
=3D
> True
> +    ) -> None:
> +        """Set the given `port`'s flow control.
> +
> +        Args:
> +            port: The number of the requested port.
> +            flow_ctrl: The requested flow control parameters.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> +                the flow control in the specified port is set.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command
> +                fails to execute.
> +        """
> +        output =3D self.send_command(f"set flow_ctrl {flow_ctrl} {port}"=
,
> skip_first_line=3DTrue)
> +        if verify:
> +            if output.strip():
> +                self._logger.debug(f"Testpmd failed to set the
> {flow_ctrl} in port {port}.")
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set the {flow_ctrl} in port
> {port}."
> +                )
> +
> +    def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl |
> None:
> +        """Show port info flow.
> +
> +        Args:
> +            port: The number of the requested port.
> +
> +        Returns:
> +            The current port flow control parameters if supported,
> otherwise :data:`None`.
> +        """
> +        output =3D self.send_command(f"show port {port} flow_ctrl")
> +        if "Flow control infos" in output:
> +            return TestPmdPortFlowCtrl.parse(output)
> +        return None
> +
> +    @_requires_stopped_ports
> +    def rx_vlan(self, vlan: int, port: int, add: bool, verify: bool =3D
> True) -> None:
> +        """Add specified vlan tag to the filter list on a port. Requires
> vlan filter to be on.
> +
> +        Args:
> +            vlan: The vlan tag to add, should be within 1-1005.
> +            port: The port number to add the tag on.
> +            add: Adds the tag if :data:`True`, otherwise removes the tag=
.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> +                the vlan tag was added to the filter list on the
> specified port.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the tag
> +                is not added.
> +        """
> +        rx_cmd_output =3D self.send_command(f"rx_vlan {'add' if add else
> 'rm'} {vlan} {port}")
> +        if verify:
> +            if (
> +                "VLAN-filtering disabled" in rx_cmd_output
> +                or "Invalid vlan_id" in rx_cmd_output
> +                or "Bad arguments" in rx_cmd_output
> +            ):
> +                self._logger.debug(
> +                    f"""Failed to {"add" if add else "remove"} tag {vlan=
}
> +                    port {port}: \n{rx_cmd_output}"""
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to {'add' if add else 'remove'} tag
> {vlan} on port {port}."
> +                )
> +
> +    @_requires_stopped_ports
> +    def set_vlan_strip(self, port: int, enable: bool, verify: bool =3D
> True) -> None:
> +        """Enable or disable vlan stripping on the specified port.
> +
> +        Args:
> +            port: The port number to use.
> +            enable: If :data:`True`, will turn vlan stripping on,
> otherwise will turn off.
> +            verify: If :data:`True`, the output of the command and show
> port info
> +                is scanned to verify that vlan stripping was enabled on
> the specified port.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and stripping
> +                fails to update.
> +        """
> +        strip_cmd_output =3D self.send_command(f"vlan set strip {'on' if
> enable else 'off'} {port}")
> +        if verify:
> +            vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
> +            if enable ^ (vlan_settings is not None and
> VLANOffloadFlag.STRIP in vlan_settings):
> +                self._logger.debug(
> +                    f"""Failed to set strip {"on" if enable else "off"}
> +                    port {port}: \n{strip_cmd_output}"""
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set strip {'on' if enable else
> 'off'} port {port}."
> +                )
> +
> +    @_requires_stopped_ports
> +    def tx_vlan_set(
> +        self, port: int, enable: bool, vlan: int | None =3D None, verify=
:
> bool =3D True
> +    ) -> None:
> +        """Set hardware insertion of vlan tags in packets sent on a port=
.
> +
> +        Args:
> +            port: The port number to use.
> +            enable: Sets vlan tag insertion if :data:`True`, and resets
> if :data:`False`.
> +            vlan: The vlan tag to insert if enable is :data:`True`.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> +                vlan insertion was enabled on the specified port.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the insertion
> +                tag is not set.
> +        """
> +        if enable:
> +            tx_vlan_cmd_output =3D self.send_command(f"tx_vlan set {port=
}
> {vlan}")
> +            if verify:
> +                if (
> +                    "Please stop port" in tx_vlan_cmd_output
> +                    or "Invalid vlan_id" in tx_vlan_cmd_output
> +                    or "Invalid port" in tx_vlan_cmd_output
> +                ):
> +                    self._logger.debug(
> +                        f"Failed to set vlan tag {vlan} on port
> {port}:\n{tx_vlan_cmd_output}"
> +                    )
> +                    raise InteractiveCommandExecutionError(
> +                        f"Testpmd failed to set vlan insertion tag {vlan=
}
> on port {port}."
> +                    )
> +        else:
> +            tx_vlan_cmd_output =3D self.send_command(f"tx_vlan reset
> {port}")
> +            if verify:
> +                if "Please stop port" in tx_vlan_cmd_output or "Invalid
> port" in tx_vlan_cmd_output:
> +                    self._logger.debug(
> +                        f"Failed to reset vlan insertion on port {port}:
> \n{tx_vlan_cmd_output}"
> +                    )
> +                    raise InteractiveCommandExecutionError(
> +                        f"Testpmd failed to reset vlan insertion on port
> {port}."
> +                    )
> +
> +    def set_promisc(self, port: int, enable: bool, verify: bool =3D True=
)
> -> None:
> +        """Enable or disable promiscuous mode for the specified port.
> +
> +        Args:
> +            port: Port number to use.
> +            enable: If :data:`True`, turn promiscuous mode on, otherwise
> turn off.
> +            verify: If :data:`True` an additional command will be sent t=
o
> verify that
> +                promiscuous mode is properly set. Defaults to
> :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and promiscuous mode
> +                is not correctly set.
> +        """
> +        promisc_cmd_output =3D self.send_command(f"set promisc {port} {'=
on'
> if enable else 'off'}")
> +        if verify:
> +            stats =3D self.show_port_info(port_id=3Dport)
> +            if enable ^ stats.is_promiscuous_mode_enabled:
> +                self._logger.debug(
> +                    f"Failed to set promiscuous mode on port {port}:
> \n{promisc_cmd_output}"
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set promiscuous mode on port
> {port}."
> +                )
> +
> +    def set_verbose(self, level: int, verify: bool =3D True) -> None:
> +        """Set debug verbosity level.
> +
> +        Args:
> +            level: 0 - silent except for error
> +                1 - fully verbose except for Tx packets
> +                2 - fully verbose except for Rx packets
> +                >2 - fully verbose
> +            verify: If :data:`True` the command output will be scanned t=
o
> verify that verbose level
> +                is properly set. Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and verbose level
> +            is not correctly set.
> +        """
> +        verbose_cmd_output =3D self.send_command(f"set verbose {level}")
> +        if verify:
> +            if "Change verbose level" not in verbose_cmd_output:
> +                self._logger.debug(
> +                    f"Failed to set verbose level to {level}:
> \n{verbose_cmd_output}"
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set verbose level to {level}."
> +                )
> +
> +    def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify=
:
> bool =3D True) -> None:
> +        """Add or remove vxlan id to/from filter list.
> +
> +        Args:
> +            vxlan_id: VXLAN ID to add to port filter list.
> +            port_id: ID of the port to modify VXLAN filter of.
> +            enable: If :data:`True`, adds specified VXLAN ID, otherwise
> removes it.
> +            verify: If :data:`True`, the output of the command is checke=
d
> to verify
> +                the VXLAN ID was successfully added/removed from the por=
t.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and VXLAN ID
> +                is not successfully added or removed.
> +        """
> +        action =3D "add" if enable else "rm"
> +        vxlan_output =3D self.send_command(f"rx_vxlan_port {action}
> {vxlan_id} {port_id}")
> +        if verify:
> +            if "udp tunneling add error" in vxlan_output:
> +                self._logger.debug(f"Failed to set
> VXLAN:\n{vxlan_output}")
> +                raise InteractiveCommandExecutionError(f"Failed to set
> VXLAN:\n{vxlan_output}")
> +
> +    def clear_port_stats(self, port_id: int, verify: bool =3D True) -> N=
one:
> +        """Clear statistics of a given port.
> +
> +        Args:
> +            port_id: ID of the port to clear the statistics on.
> +            verify: If :data:`True` the output of the command will be
> scanned to verify that it was
> +                successful, otherwise failures will be ignored. Defaults
> to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and testpmd fails to
> +                clear the statistics of the given port.
> +        """
> +        clear_output =3D self.send_command(f"clear port stats {port_id}"=
)
> +        if verify and f"NIC statistics for port {port_id} cleared" not i=
n
> clear_output:
> +            raise InteractiveCommandExecutionError(
> +                f"Test pmd failed to set clear forwarding stats on port
> {port_id}"
> +            )
> +
> +    def clear_port_stats_all(self, verify: bool =3D True) -> None:
> +        """Clear the statistics of all ports that testpmd is aware of.
> +
> +        Args:
> +            verify: If :data:`True` the output of the command will be
> scanned to verify that all
> +                ports had their statistics cleared, otherwise failures
> will be ignored. Defaults to
> +                :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and testpmd fails to
> +                clear the statistics of any of its ports.
> +        """
> +        clear_output =3D self.send_command("clear port stats all")
> +        if verify:
> +            if type(self._app_params.port_numa_config) is list:
> +                for port_id in
> range(len(self._app_params.port_numa_config)):
> +                    if f"NIC statistics for port {port_id} cleared" not
> in clear_output:
> +                        raise InteractiveCommandExecutionError(
> +                            f"Test pmd failed to set clear forwarding
> stats on port {port_id}"
> +                        )
> +
> +    @only_active
> +    def close(self) -> None:
> +        """Overrides :meth:`~.interactive_shell.close`."""
> +        self.stop()
> +        self.send_command("quit", "Bye...")
> +        return super().close()
> +
> +    """
> +    =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=3D=3D
> +    """
> +
> +    def get_capabilities_rx_offload(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get all rx offload capabilities and divide them into supporte=
d
> and unsupported.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._logger.debug("Getting rx offload capabilities.")
> +        command =3D f"show port {self.ports[0].id} rx_offload capabiliti=
es"
> +        rx_offload_capabilities_out =3D self.send_command(command)
> +        rx_offload_capabilities =3D
> RxOffloadCapabilities.parse(rx_offload_capabilities_out)
> +        self._update_capabilities_from_flag(
> +            supported_capabilities,
> +            unsupported_capabilities,
> +            RxOffloadCapability,
> +            rx_offload_capabilities.per_port |
> rx_offload_capabilities.per_queue,
> +        )
> +
> +    def get_port_queue_info(
> +        self, port_id: int, queue_id: int, is_rx_queue: bool
> +    ) -> TestPmdQueueInfo:
> +        """Returns the current state of the specified queue."""
> +        command =3D f"show {'rxq' if is_rx_queue else 'txq'} info {port_=
id}
> {queue_id}"
> +        queue_info =3D TestPmdQueueInfo.parse(self.send_command(command)=
)
> +        return queue_info
> +
> +    def setup_port_queue(self, port_id: int, queue_id: int, is_rx_queue:
> bool) -> None:
> +        """Setup a given queue on a port.
> +
> +        This functionality cannot be verified because the setup action
> only takes effect when the
> +        queue is started.
> +
> +        Args:
> +            port_id: ID of the port where the queue resides.
> +            queue_id: ID of the queue to setup.
> +            is_rx_queue: Type of queue to setup. If :data:`True` an RX
> queue will be setup,
> +                otherwise a TX queue will be setup.
> +        """
> +        self.send_command(f"port {port_id} {'rxq' if is_rx_queue else
> 'txq'} {queue_id} setup")
> +
> +    def stop_port_queue(
> +        self, port_id: int, queue_id: int, is_rx_queue: bool, verify:
> bool =3D True
> +    ) -> None:
> +        """Stops a given queue on a port.
> +
> +        Args:
> +            port_id: ID of the port that the queue belongs to.
> +            queue_id: ID of the queue to stop.
> +            is_rx_queue: Type of queue to stop. If :data:`True` an RX
> queue will be stopped,
> +                otherwise a TX queue will be stopped.
> +            verify: If :data:`True` an additional command will be sent t=
o
> verify the queue stopped.
> +                Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the queue fails to
> +                stop.
> +        """
> +        port_type =3D "rxq" if is_rx_queue else "txq"
> +        stop_cmd_output =3D self.send_command(f"port {port_id} {port_typ=
e}
> {queue_id} stop")
> +        if verify:
> +            queue_started =3D self.get_port_queue_info(
> +                port_id, queue_id, is_rx_queue
> +            ).is_queue_started
> +            if queue_started:
> +                self._logger.debug(
> +                    f"Failed to stop {port_type} {queue_id} on port
> {port_id}:\n{stop_cmd_output}"
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Test pmd failed to stop {port_type} {queue_id} on
> port {port_id}"
> +                )
> +
> +    def start_port_queue(
> +        self, port_id: int, queue_id: int, is_rx_queue: bool, verify:
> bool =3D True
> +    ) -> None:
> +        """Starts a given queue on a port.
> +
> +        First sets up the port queue, then starts it.
> +
> +        Args:
> +            port_id: ID of the port that the queue belongs to.
> +            queue_id: ID of the queue to start.
> +            is_rx_queue: Type of queue to start. If :data:`True` an RX
> queue will be started,
> +                otherwise a TX queue will be started.
> +            verify: if :data:`True` an additional command will be sent t=
o
> verify that the queue was
> +                started. Defaults to :data:`True`.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the queue fails to
> +                start.
> +        """
> +        port_type =3D "rxq" if is_rx_queue else "txq"
> +        self.setup_port_queue(port_id, queue_id, is_rx_queue)
> +        start_cmd_output =3D self.send_command(f"port {port_id} {port_ty=
pe}
> {queue_id} start")
> +        if verify:
> +            queue_started =3D self.get_port_queue_info(
> +                port_id, queue_id, is_rx_queue
> +            ).is_queue_started
> +            if not queue_started:
> +                self._logger.debug(
> +                    f"Failed to start {port_type} {queue_id} on port
> {port_id}:\n{start_cmd_output}"
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Test pmd failed to start {port_type} {queue_id} on
> port {port_id}"
> +                )
> +
> +    def get_queue_ring_size(self, port_id: int, queue_id: int,
> is_rx_queue: bool) -> int:
> +        """Returns the current size of the ring on the specified queue."=
""
> +        command =3D f"show {'rxq' if is_rx_queue else 'txq'} info {port_=
id}
> {queue_id}"
> +        queue_info =3D TestPmdQueueInfo.parse(self.send_command(command)=
)
> +        return queue_info.ring_size
> +
> +    def set_queue_ring_size(
> +        self,
> +        port_id: int,
> +        queue_id: int,
> +        size: int,
> +        is_rx_queue: bool,
> +        verify: bool =3D True,
> +    ) -> None:
> +        """Update the ring size of an Rx/Tx queue on a given port.
> +
> +        Queue is setup after setting the ring size so that the queue inf=
o
> reflects this change and
> +        it can be verified.
> +
> +        Args:
> +            port_id: The port that the queue resides on.
> +            queue_id: The ID of the queue on the port.
> +            size: The size to update the ring size to.
> +            is_rx_queue: Whether to modify an RX or TX queue. If
> :data:`True` an RX queue will be
> +                updated, otherwise a TX queue will be updated.
> +            verify: If :data:`True` an additional command will be sent t=
o
> check the ring size of
> +                the queue in an attempt to validate that the size was
> changes properly.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and there is a failure
> +                when updating ring size.
> +        """
> +        queue_type =3D "rxq" if is_rx_queue else "txq"
> +        self.send_command(f"port config {port_id} {queue_type} {queue_id=
}
> ring_size {size}")
> +        self.setup_port_queue(port_id, queue_id, is_rx_queue)
> +        if verify:
> +            curr_ring_size =3D self.get_queue_ring_size(port_id, queue_i=
d,
> is_rx_queue)
> +            if curr_ring_size !=3D size:
> +                self._logger.debug(
> +                    f"Failed up update ring size of queue {queue_id} on
> port {port_id}. Current"
> +                    f" ring size is {curr_ring_size}."
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to update ring size of queue {queue_id} on
> port {port_id}"
> +                )
> +
> +    @_requires_stopped_ports
> +    def set_queue_deferred_start(
> +        self, port_id: int, queue_id: int, is_rx_queue: bool, on: bool
> +    ) -> None:
> +        """Set the deferred start attribute of the specified queue on/of=
f.
> +
> +        Args:
> +            port_id: The port that the queue resides on.
> +            queue_id: The ID of the queue on the port.
> +            is_rx_queue: Whether to modify an RX or TX queue. If
> :data:`True` an RX queue will be
> +                updated, otherwise a TX queue will be updated.
> +            on: Whether to set deferred start mode on or off. If
> :data:`True` deferred start will
> +                be turned on, otherwise it will be turned off.
> +        """
> +        queue_type =3D "rxq" if is_rx_queue else "txq"
> +        action =3D "on" if on else "off"
> +        self.send_command(f"port {port_id} {queue_type} {queue_id}
> deferred_start {action}")
> +
> +    def _update_capabilities_from_flag(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +        flag_class: type[Flag],
> +        supported_flags: Flag,
> +    ) -> None:
> +        """Divide all flags from `flag_class` into supported and
> unsupported."""
> +        for flag in flag_class:
> +            if flag in supported_flags:
> +                supported_capabilities.add(NicCapability[str(flag.name)]=
)
> +            else:
> +                unsupported_capabilities.add(NicCapability[str(flag.name
> )])
> +
> +    @_requires_started_ports
> +    def get_capabilities_rxq_info(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get all rxq capabilities and divide them into supported and
> unsupported.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._logger.debug("Getting rxq capabilities.")
> +        command =3D f"show rxq info {self.ports[0].id} 0"
> +        rxq_info =3D TestPmdRxqInfo.parse(self.send_command(command))
> +        if rxq_info.scattered_packets:
> +            supported_capabilities.add(NicCapability.SCATTERED_RX_ENABLE=
D)
> +        else:
> +
> unsupported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
> +
> +    def get_capabilities_show_port_info(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get all capabilities from show port info and divide them into
> supported and unsupported.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._update_capabilities_from_flag(
> +            supported_capabilities,
> +            unsupported_capabilities,
> +            DeviceCapabilitiesFlag,
> +            self.ports[0].device_capabilities,
> +        )
> +
> +    def get_capabilities_mcast_filtering(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get multicast filtering capability from mcast_addr add and
> check for testpmd error code.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._logger.debug("Getting mcast filter capabilities.")
> +        command =3D f"mcast_addr add {self.ports[0].id} 01:00:5E:00:00:0=
0"
> +        output =3D self.send_command(command)
> +        if "diag=3D-95" in output:
> +            unsupported_capabilities.add(NicCapability.MCAST_FILTERING)
> +        else:
> +            supported_capabilities.add(NicCapability.MCAST_FILTERING)
> +            command =3D str.replace(command, "add", "remove", 1)
> +            self.send_command(command)
> +
> +    def get_capabilities_flow_ctrl(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Get flow control capability and check for testpmd failure.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        self._logger.debug("Getting flow ctrl capabilities.")
> +        command =3D f"show port {self.ports[0].id} flow_ctrl"
> +        output =3D self.send_command(command)
> +        if "Flow control infos" in output:
> +            supported_capabilities.add(NicCapability.FLOW_CTRL)
> +        else:
> +            unsupported_capabilities.add(NicCapability.FLOW_CTRL)
> +
> +    def get_capabilities_physical_function(
> +        self,
> +        supported_capabilities: MutableSet["NicCapability"],
> +        unsupported_capabilities: MutableSet["NicCapability"],
> +    ) -> None:
> +        """Store capability representing a physical function test run.
> +
> +        Args:
> +            supported_capabilities: Supported capabilities will be added
> to this set.
> +            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> +        """
> +        ctx =3D get_ctx()
> +        if ctx.topology.vf_ports =3D=3D []:
> +            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
> +        else:
> +            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
> diff --git a/dts/framework/params/testpmd.py b/dts/api/testpmd/config.py
> similarity index 98%
> rename from dts/framework/params/testpmd.py
> rename to dts/api/testpmd/config.py
> index 1913bd0fa2..e71a3e1ef0 100644
> --- a/dts/framework/params/testpmd.py
> +++ b/dts/api/testpmd/config.py
> @@ -1,7 +1,12 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2024 Arm Limited
>
> -"""Module containing all the TestPmd-related parameter classes."""
> +"""Module containing all classes needed to configure :class:`TestPmd`.
> +
> +This module defines the :class:`TestPmdParams` class which is used to
> configure the
> +TestPmd shell. It also includes various data classes and enums that are
> used
> +to represent different configurations and settings.
> +"""
>
>  from dataclasses import dataclass, field
>  from enum import EnumMeta, Flag, auto, unique
> @@ -146,7 +151,7 @@ class RSSSetting(EnumMeta):
>
>
>  class SimpleForwardingModes(StrEnum):
> -    r"""The supported packet forwarding modes for
> :class:`~TestPmdShell`\s."""
> +    r"""The supported packet forwarding modes for :class:`~TestPmd`\s.""=
"
>
>      #:
>      io =3D auto()
> diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
> new file mode 100644
> index 0000000000..553438c904
> --- /dev/null
> +++ b/dts/api/testpmd/types.py
> @@ -0,0 +1,1406 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2023 University of New Hampshire
> +# Copyright(c) 2023 PANTHEON.tech s.r.o.
> +# Copyright(c) 2024 Arm Limited
> +
> +"""TestPmd types module.
> +
> +Exposes types used in the TestPmd API.
> +"""
> +
> +import re
> +from dataclasses import dataclass, field
> +from enum import Flag, auto
> +from typing import Literal
> +
> +from typing_extensions import Self
> +
> +from framework.parser import ParserFn, TextParser
> +from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
> +
> +
> +class TestPmdDevice:
> +    """The data of a device that testpmd can recognize.
> +
> +    Attributes:
> +        pci_address: The PCI address of the device.
> +    """
> +
> +    pci_address: str
> +
> +    def __init__(self, pci_address_line: str):
> +        """Initialize the device from the testpmd output line string.
> +
> +        Args:
> +            pci_address_line: A line of testpmd output that contains a
> device.
> +        """
> +        self.pci_address =3D pci_address_line.strip().split(": ")[1].str=
ip()
> +
> +    def __str__(self) -> str:
> +        """The PCI address captures what the device is."""
> +        return self.pci_address
> +
> +
> +class VLANOffloadFlag(Flag):
> +    """Flag representing the VLAN offload settings of a NIC port."""
> +
> +    #:
> +    STRIP =3D auto()
> +    #:
> +    FILTER =3D auto()
> +    #:
> +    EXTEND =3D auto()
> +    #:
> +    QINQ_STRIP =3D auto()
> +
> +    @classmethod
> +    def from_str_dict(cls, d):
> +        """Makes an instance from a dict containing the flag member name=
s
> with an "on" value.
> +
> +        Args:
> +            d: A dictionary containing the flag members as keys and any
> string value.
> +
> +        Returns:
> +            A new instance of the flag.
> +        """
> +        flag =3D cls(0)
> +        for name in cls.__members__:
> +            if d.get(name) =3D=3D "on":
> +                flag |=3D cls[name]
> +        return flag
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        return TextParser.wrap(
> +            TextParser.find(
> +                r"VLAN offload:\s+"
> +                r"strip (?P<STRIP>on|off), "
> +                r"filter (?P<FILTER>on|off), "
> +                r"extend (?P<EXTEND>on|off), "
> +                r"qinq strip (?P<QINQ_STRIP>on|off)",
> +                re.MULTILINE,
> +                named=3DTrue,
> +            ),
> +            cls.from_str_dict,
> +        )
> +
> +
> +class ChecksumOffloadOptions(Flag):
> +    """Flag representing checksum hardware offload layer options."""
> +
> +    #:
> +    ip =3D auto()
> +    #:
> +    udp =3D auto()
> +    #:
> +    tcp =3D auto()
> +    #:
> +    sctp =3D auto()
> +    #:
> +    outer_ip =3D auto()
> +    #:
> +    outer_udp =3D auto()
> +
> +
> +class RSSOffloadTypesFlag(Flag):
> +    """Flag representing the RSS offload flow types supported by the NIC
> port."""
> +
> +    #:
> +    ipv4 =3D auto()
> +    #:
> +    ipv4_frag =3D auto()
> +    #:
> +    ipv4_tcp =3D auto()
> +    #:
> +    ipv4_udp =3D auto()
> +    #:
> +    ipv4_sctp =3D auto()
> +    #:
> +    ipv4_other =3D auto()
> +    #:
> +    ipv6 =3D auto()
> +    #:
> +    ipv6_frag =3D auto()
> +    #:
> +    ipv6_tcp =3D auto()
> +    #:
> +    ipv6_udp =3D auto()
> +    #:
> +    ipv6_sctp =3D auto()
> +    #:
> +    ipv6_other =3D auto()
> +    #:
> +    l2_payload =3D auto()
> +    #:
> +    ipv6_ex =3D auto()
> +    #:
> +    ipv6_tcp_ex =3D auto()
> +    #:
> +    ipv6_udp_ex =3D auto()
> +    #:
> +    port =3D auto()
> +    #:
> +    vxlan =3D auto()
> +    #:
> +    geneve =3D auto()
> +    #:
> +    nvgre =3D auto()
> +    #:
> +    user_defined_22 =3D auto()
> +    #:
> +    gtpu =3D auto()
> +    #:
> +    eth =3D auto()
> +    #:
> +    s_vlan =3D auto()
> +    #:
> +    c_vlan =3D auto()
> +    #:
> +    esp =3D auto()
> +    #:
> +    ah =3D auto()
> +    #:
> +    l2tpv3 =3D auto()
> +    #:
> +    pfcp =3D auto()
> +    #:
> +    pppoe =3D auto()
> +    #:
> +    ecpri =3D auto()
> +    #:
> +    mpls =3D auto()
> +    #:
> +    ipv4_chksum =3D auto()
> +    #:
> +    l4_chksum =3D auto()
> +    #:
> +    l2tpv2 =3D auto()
> +    #:
> +    ipv6_flow_label =3D auto()
> +    #:
> +    user_defined_38 =3D auto()
> +    #:
> +    user_defined_39 =3D auto()
> +    #:
> +    user_defined_40 =3D auto()
> +    #:
> +    user_defined_41 =3D auto()
> +    #:
> +    user_defined_42 =3D auto()
> +    #:
> +    user_defined_43 =3D auto()
> +    #:
> +    user_defined_44 =3D auto()
> +    #:
> +    user_defined_45 =3D auto()
> +    #:
> +    user_defined_46 =3D auto()
> +    #:
> +    user_defined_47 =3D auto()
> +    #:
> +    user_defined_48 =3D auto()
> +    #:
> +    user_defined_49 =3D auto()
> +    #:
> +    user_defined_50 =3D auto()
> +    #:
> +    user_defined_51 =3D auto()
> +    #:
> +    l3_pre96 =3D auto()
> +    #:
> +    l3_pre64 =3D auto()
> +    #:
> +    l3_pre56 =3D auto()
> +    #:
> +    l3_pre48 =3D auto()
> +    #:
> +    l3_pre40 =3D auto()
> +    #:
> +    l3_pre32 =3D auto()
> +    #:
> +    l2_dst_only =3D auto()
> +    #:
> +    l2_src_only =3D auto()
> +    #:
> +    l4_dst_only =3D auto()
> +    #:
> +    l4_src_only =3D auto()
> +    #:
> +    l3_dst_only =3D auto()
> +    #:
> +    l3_src_only =3D auto()
> +
> +    #:
> +    ip =3D ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ipv6_other=
 |
> ipv6_ex
> +    #:
> +    udp =3D ipv4_udp | ipv6_udp | ipv6_udp_ex
> +    #:
> +    tcp =3D ipv4_tcp | ipv6_tcp | ipv6_tcp_ex
> +    #:
> +    sctp =3D ipv4_sctp | ipv6_sctp
> +    #:
> +    tunnel =3D vxlan | geneve | nvgre
> +    #:
> +    vlan =3D s_vlan | c_vlan
> +    #:
> +    all =3D (
> +        eth
> +        | vlan
> +        | ip
> +        | tcp
> +        | udp
> +        | sctp
> +        | l2_payload
> +        | l2tpv3
> +        | esp
> +        | ah
> +        | pfcp
> +        | gtpu
> +        | ecpri
> +        | mpls
> +        | l2tpv2
> +    )
> +
> +    @classmethod
> +    def from_list_string(cls, names: str) -> Self:
> +        """Makes a flag from a whitespace-separated list of names.
> +
> +        Args:
> +            names: a whitespace-separated list containing the members of
> this flag.
> +
> +        Returns:
> +            An instance of this flag.
> +        """
> +        flag =3D cls(0)
> +        for name in names.split():
> +            flag |=3D cls.from_str(name)
> +        return flag
> +
> +    @classmethod
> +    def from_str(cls, name: str) -> Self:
> +        """Makes a flag matching the supplied name.
> +
> +        Args:
> +            name: a valid member of this flag in text
> +        Returns:
> +            An instance of this flag.
> +        """
> +        member_name =3D name.strip().replace("-", "_")
> +        return cls[member_name]
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        return TextParser.wrap(
> +            TextParser.find(r"Supported RSS offload flow
> types:((?:\r?\n?  \S+)+)", re.MULTILINE),
> +            RSSOffloadTypesFlag.from_list_string,
> +        )
> +
> +
> +class DeviceCapabilitiesFlag(Flag):
> +    """Flag representing the device capabilities."""
> +
> +    #: Device supports Rx queue setup after device started.
> +    RUNTIME_RX_QUEUE_SETUP =3D auto()
> +    #: Device supports Tx queue setup after device started.
> +    RUNTIME_TX_QUEUE_SETUP =3D auto()
> +    #: Device supports shared Rx queue among ports within Rx domain and
> switch domain.
> +    RXQ_SHARE =3D auto()
> +    #: Device supports keeping flow rules across restart.
> +    FLOW_RULE_KEEP =3D auto()
> +    #: Device supports keeping shared flow objects across restart.
> +    FLOW_SHARED_OBJECT_KEEP =3D auto()
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        return TextParser.wrap(
> +            TextParser.find_int(r"Device capabilities: (0x[A-Fa-f\d]+)")=
,
> +            cls,
> +        )
> +
> +
> +class DeviceErrorHandlingMode(StrEnum):
> +    """Enum representing the device error handling mode."""
> +
> +    #:
> +    none =3D auto()
> +    #:
> +    passive =3D auto()
> +    #:
> +    proactive =3D auto()
> +    #:
> +    unknown =3D auto()
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this enum from
> text.
> +        """
> +        return TextParser.wrap(TextParser.find(r"Device error handling
> mode: (\w+)"), cls)
> +
> +
> +class RxQueueState(StrEnum):
> +    """RX queue states.
> +
> +    References:
> +        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> +        testpmd display function:
> ``app/test-pmd/config.c:get_queue_state_name()``
> +    """
> +
> +    #:
> +    stopped =3D auto()
> +    #:
> +    started =3D auto()
> +    #:
> +    hairpin =3D auto()
> +    #:
> +    unknown =3D auto()
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this enum from
> text.
> +        """
> +        return TextParser.wrap(TextParser.find(r"Rx queue state:
> ([^\r\n]+)"), cls)
> +
> +
> +@dataclass
> +class TestPmdQueueInfo(TextParser):
> +    """Dataclass representation of the common parts of the testpmd `show
> rxq/txq info` commands."""
> +
> +    #:
> +    prefetch_threshold: int =3D
> field(metadata=3DTextParser.find_int(r"prefetch threshold: (\d+)"))
> +    #:
> +    host_threshold: int =3D field(metadata=3DTextParser.find_int(r"host
> threshold: (\d+)"))
> +    #:
> +    writeback_threshold: int =3D
> field(metadata=3DTextParser.find_int(r"writeback threshold: (\d+)"))
> +    #:
> +    free_threshold: int =3D field(metadata=3DTextParser.find_int(r"free
> threshold: (\d+)"))
> +    #:
> +    deferred_start: bool =3D field(metadata=3DTextParser.find("deferred
> start: on"))
> +    #: The number of RXD/TXDs is just the ring size of the queue.
> +    ring_size: int =3D field(metadata=3DTextParser.find_int(r"Number of
> (?:RXDs|TXDs): (\d+)"))
> +    #:
> +    is_queue_started: bool =3D field(metadata=3DTextParser.find("queue s=
tate:
> started"))
> +    #:
> +    burst_mode: str | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"Burst mode: ([^\r\n=
]+)")
> +    )
> +
> +
> +@dataclass
> +class TestPmdTxqInfo(TestPmdQueueInfo):
> +    """Representation of testpmd's ``show txq info <port_id> <queue_id>`=
`
> command.
> +
> +    References:
> +        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_showqueue()``
> +        testpmd display function:
> ``app/test-pmd/config.c:rx_queue_infos_display()``
> +    """
> +
> +    #: Ring size threshold
> +    rs_threshold: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"TX RS threshold=
:
> (\d+)\b")
> +    )
> +
> +
> +@dataclass
> +class TestPmdRxqInfo(TestPmdQueueInfo):
> +    """Representation of testpmd's ``show rxq info <port_id> <queue_id>`=
`
> command.
> +
> +    References:
> +        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_showqueue()``
> +        testpmd display function:
> ``app/test-pmd/config.c:rx_queue_infos_display()``
> +    """
> +
> +    #: Mempool used by that queue
> +    mempool: str | None =3D field(default=3DNone,
> metadata=3DTextParser.find(r"Mempool: ([^\r\n]+)"))
> +    #: Drop packets if no descriptors are available
> +    drop_packets: bool | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"RX drop packets: on=
")
> +    )
> +    #: Scattered packets Rx enabled
> +    scattered_packets: bool | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"RX scattered packet=
s:
> on")
> +    )
> +    #: The state of the queue
> +    queue_state: str | None =3D field(default=3DNone,
> metadata=3DRxQueueState.make_parser())
> +
> +
> +@dataclass
> +class TestPmdPort(TextParser):
> +    """Dataclass representing the result of testpmd's ``show port info``
> command."""
> +
> +    @staticmethod
> +    def _make_device_private_info_parser() -> ParserFn:
> +        """Device private information parser.
> +
> +        Ensures that we are not parsing invalid device private info
> output.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a parser
> +                function that parses the device private info from the
> TestPmd port info output.
> +        """
> +
> +        def _validate(info: str):
> +            info =3D info.strip()
> +            if (
> +                info =3D=3D "none"
> +                or info.startswith("Invalid file")
> +                or info.startswith("Failed to dump")
> +            ):
> +                return None
> +            return info
> +
> +        return TextParser.wrap(TextParser.find(r"Device private
> info:\s+([\s\S]+)"), _validate)
> +
> +    #:
> +    id: int =3D field(metadata=3DTextParser.find_int(r"Infos for port
> (\d+)\b"))
> +    #:
> +    device_name: str =3D field(metadata=3DTextParser.find(r"Device name:
> ([^\r\n]+)"))
> +    #:
> +    driver_name: str =3D field(metadata=3DTextParser.find(r"Driver name:
> ([^\r\n]+)"))
> +    #:
> +    socket_id: int =3D field(metadata=3DTextParser.find_int(r"Connect to
> socket: (\d+)"))
> +    #:
> +    is_link_up: bool =3D field(metadata=3DTextParser.find("Link status: =
up"))
> +    #:
> +    link_speed: str =3D field(metadata=3DTextParser.find(r"Link speed:
> ([^\r\n]+)"))
> +    #:
> +    is_link_full_duplex: bool =3D field(metadata=3DTextParser.find("Link
> duplex: full-duplex"))
> +    #:
> +    is_link_autonegotiated: bool =3D
> field(metadata=3DTextParser.find("Autoneg status: On"))
> +    #:
> +    is_promiscuous_mode_enabled: bool =3D
> field(metadata=3DTextParser.find("Promiscuous mode: enabled"))
> +    #:
> +    is_allmulticast_mode_enabled: bool =3D field(
> +        metadata=3DTextParser.find("Allmulticast mode: enabled")
> +    )
> +    #: Maximum number of MAC addresses
> +    max_mac_addresses_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Maximum number of MAC addresses=
:
> (\d+)")
> +    )
> +    #: Maximum configurable length of RX packet
> +    max_hash_mac_addresses_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Maximum number of MAC addresses=
 of
> hash filtering: (\d+)")
> +    )
> +    #: Minimum size of RX buffer
> +    min_rx_bufsize: int =3D field(metadata=3DTextParser.find_int(r"Minim=
um
> size of RX buffer: (\d+)"))
> +    #: Maximum configurable length of RX packet
> +    max_rx_packet_length: int =3D field(
> +        metadata=3DTextParser.find_int(r"Maximum configurable length of =
RX
> packet: (\d+)")
> +    )
> +    #: Maximum configurable size of LRO aggregated packet
> +    max_lro_packet_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Maximum configurable size of LR=
O
> aggregated packet: (\d+)")
> +    )
> +
> +    #: Current number of RX queues
> +    rx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Curren=
t
> number of RX queues: (\d+)"))
> +    #: Max possible RX queues
> +    max_rx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Ma=
x
> possible RX queues: (\d+)"))
> +    #: Max possible number of RXDs per queue
> +    max_queue_rxd_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Max possible number of RXDs per
> queue: (\d+)")
> +    )
> +    #: Min possible number of RXDs per queue
> +    min_queue_rxd_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Min possible number of RXDs per
> queue: (\d+)")
> +    )
> +    #: RXDs number alignment
> +    rxd_alignment_num: int =3D field(metadata=3DTextParser.find_int(r"RX=
Ds
> number alignment: (\d+)"))
> +
> +    #: Current number of TX queues
> +    tx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Curren=
t
> number of TX queues: (\d+)"))
> +    #: Max possible TX queues
> +    max_tx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Ma=
x
> possible TX queues: (\d+)"))
> +    #: Max possible number of TXDs per queue
> +    max_queue_txd_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Max possible number of TXDs per
> queue: (\d+)")
> +    )
> +    #: Min possible number of TXDs per queue
> +    min_queue_txd_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Min possible number of TXDs per
> queue: (\d+)")
> +    )
> +    #: TXDs number alignment
> +    txd_alignment_num: int =3D field(metadata=3DTextParser.find_int(r"TX=
Ds
> number alignment: (\d+)"))
> +    #: Max segment number per packet
> +    max_packet_segment_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Max segment number per packet:
> (\d+)")
> +    )
> +    #: Max segment number per MTU/TSO
> +    max_mtu_segment_num: int =3D field(
> +        metadata=3DTextParser.find_int(r"Max segment number per MTU\/TSO=
:
> (\d+)")
> +    )
> +
> +    #:
> +    device_capabilities: DeviceCapabilitiesFlag =3D field(
> +        metadata=3DDeviceCapabilitiesFlag.make_parser(),
> +    )
> +    #:
> +    device_error_handling_mode: DeviceErrorHandlingMode | None =3D field=
(
> +        default=3DNone, metadata=3DDeviceErrorHandlingMode.make_parser()
> +    )
> +    #:
> +    device_private_info: str | None =3D field(
> +        default=3DNone,
> +        metadata=3D_make_device_private_info_parser(),
> +    )
> +
> +    #:
> +    hash_key_size: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Hash key size i=
n
> bytes: (\d+)")
> +    )
> +    #:
> +    redirection_table_size: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Redirection tab=
le
> size: (\d+)")
> +    )
> +    #:
> +    supported_rss_offload_flow_types: RSSOffloadTypesFlag =3D field(
> +        default=3DRSSOffloadTypesFlag(0),
> metadata=3DRSSOffloadTypesFlag.make_parser()
> +    )
> +
> +    #:
> +    mac_address: str | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"MAC address:
> ([A-Fa-f0-9:]+)")
> +    )
> +    #:
> +    fw_version: str | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"Firmware-version:
> ([^\r\n]+)")
> +    )
> +    #:
> +    dev_args: str | None =3D field(default=3DNone,
> metadata=3DTextParser.find(r"Devargs: ([^\r\n]+)"))
> +    #: Socket id of the memory allocation
> +    mem_alloc_socket_id: int | None =3D field(
> +        default=3DNone,
> +        metadata=3DTextParser.find_int(r"memory allocation on the socket=
:
> (\d+)"),
> +    )
> +    #:
> +    mtu: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"MTU: (\d+)"))
> +
> +    #:
> +    vlan_offload: VLANOffloadFlag | None =3D field(
> +        default=3DNone,
> +        metadata=3DVLANOffloadFlag.make_parser(),
> +    )
> +
> +    #: Maximum size of RX buffer
> +    max_rx_bufsize: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Maximum size of=
 RX
> buffer: (\d+)")
> +    )
> +    #: Maximum number of VFs
> +    max_vfs_num: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VFs: (\d+)")
> +    )
> +    #: Maximum number of VMDq pools
> +    max_vmdq_pools_num: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VMDq pools: (\d+)")
> +    )
> +
> +    #:
> +    switch_name: str | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find(r"Switch name: ([\r\n=
]+)")
> +    )
> +    #:
> +    switch_domain_id: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Switch domain I=
d:
> (\d+)")
> +    )
> +    #:
> +    switch_port_id: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Switch Port Id:
> (\d+)")
> +    )
> +    #:
> +    switch_rx_domain: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"Switch Rx domai=
n:
> (\d+)")
> +    )
> +
> +
> +@dataclass
> +class TestPmdPortStats(TextParser):
> +    """Port statistics."""
> +
> +    #:
> +    port_id: int =3D field(metadata=3DTextParser.find_int(r"NIC statisti=
cs
> for port (\d+)"))
> +
> +    #:
> +    rx_packets: int =3D
> field(metadata=3DTextParser.find_int(r"RX-packets:\s+(\d+)"))
> +    #:
> +    rx_missed: int =3D
> field(metadata=3DTextParser.find_int(r"RX-missed:\s+(\d+)"))
> +    #:
> +    rx_bytes: int =3D
> field(metadata=3DTextParser.find_int(r"RX-bytes:\s+(\d+)"))
> +    #:
> +    rx_errors: int =3D
> field(metadata=3DTextParser.find_int(r"RX-errors:\s+(\d+)"))
> +    #:
> +    rx_nombuf: int =3D
> field(metadata=3DTextParser.find_int(r"RX-nombuf:\s+(\d+)"))
> +
> +    #:
> +    tx_packets: int =3D
> field(metadata=3DTextParser.find_int(r"TX-packets:\s+(\d+)"))
> +    #:
> +    tx_errors: int =3D
> field(metadata=3DTextParser.find_int(r"TX-errors:\s+(\d+)"))
> +    #:
> +    tx_bytes: int =3D
> field(metadata=3DTextParser.find_int(r"TX-bytes:\s+(\d+)"))
> +
> +    #:
> +    rx_pps: int =3D field(metadata=3DTextParser.find_int(r"Rx-pps:\s+(\d=
+)"))
> +    #:
> +    rx_bps: int =3D field(metadata=3DTextParser.find_int(r"Rx-bps:\s+(\d=
+)"))
> +
> +    #:
> +    tx_pps: int =3D field(metadata=3DTextParser.find_int(r"Tx-pps:\s+(\d=
+)"))
> +    #:
> +    tx_bps: int =3D field(metadata=3DTextParser.find_int(r"Tx-bps:\s+(\d=
+)"))
> +
> +
> +@dataclass(kw_only=3DTrue)
> +class FlowRule:
> +    """Class representation of flow rule parameters.
> +
> +    This class represents the parameters of any flow rule as per the
> +    following pattern:
> +
> +    [group {group_id}] [priority {level}] [ingress] [egress]
> +    [user_id {user_id}] pattern {item} [/ {item} [...]] / end
> +    actions {action} [/ {action} [...]] / end
> +    """
> +
> +    #:
> +    group_id: int | None =3D None
> +    #:
> +    priority_level: int | None =3D None
> +    #:
> +    direction: Literal["ingress", "egress"]
> +    #:
> +    user_id: int | None =3D None
> +    #:
> +    pattern: list[str]
> +    #:
> +    actions: list[str]
> +
> +    def __str__(self) -> str:
> +        """Returns the string representation of this instance."""
> +        ret =3D ""
> +        pattern =3D " / ".join(self.pattern)
> +        action =3D " / ".join(self.actions)
> +        if self.group_id is not None:
> +            ret +=3D f"group {self.group_id} "
> +        if self.priority_level is not None:
> +            ret +=3D f"priority {self.priority_level} "
> +        ret +=3D f"{self.direction} "
> +        if self.user_id is not None:
> +            ret +=3D f"user_id {self.user_id} "
> +        ret +=3D f"pattern {pattern} / end "
> +        ret +=3D f"actions {action} / end"
> +        return ret
> +
> +
> +class PacketOffloadFlag(Flag):
> +    """Flag representing the Packet Offload Features Flags in DPDK.
> +
> +    Values in this class are taken from the definitions in the RTE MBUF
> core library in DPDK
> +    located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that flag
> values in this class will
> +    match the values they are set to in said DPDK library with one
> exception; all values must be
> +    unique. For example, the definitions for unknown checksum flags in
> ``rte_mbuf_core.h`` are all
> +    set to :data:`0`, but it is valuable to distinguish between them in
> this framework. For this
> +    reason flags that are not unique in the DPDK library are set either
> to values within the
> +    RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or shifted
> 61+ bits for Tx.
> +
> +    References:
> +        DPDK lib: ``lib/mbuf/rte_mbuf_core.h``
> +    """
> +
> +    # RX flags
> +
> +    #: The RX packet is a 802.1q VLAN packet, and the tci has been saved
> in mbuf->vlan_tci. If the
> +    #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN header
> has been stripped from
> +    #: mbuf data, else it is still present.
> +    RTE_MBUF_F_RX_VLAN =3D auto()
> +
> +    #: RX packet with RSS hash result.
> +    RTE_MBUF_F_RX_RSS_HASH =3D auto()
> +
> +    #: RX packet with FDIR match indicate.
> +    RTE_MBUF_F_RX_FDIR =3D auto()
> +
> +    #: This flag is set when the outermost IP header checksum is detecte=
d
> as wrong by the hardware.
> +    RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD =3D 1 << 5
> +
> +    #: A vlan has been stripped by the hardware and its tci is saved in
> mbuf->vlan_tci. This can
> +    #: only happen if vlan stripping is enabled in the RX configuration
> of the PMD. When
> +    #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also
> be set.
> +    RTE_MBUF_F_RX_VLAN_STRIPPED =3D auto()
> +
> +    #: No information about the RX IP checksum. Value is 0 in the DPDK
> library.
> +    RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN =3D 1 << 23
> +    #: The IP checksum in the packet is wrong.
> +    RTE_MBUF_F_RX_IP_CKSUM_BAD =3D 1 << 4
> +    #: The IP checksum in the packet is valid.
> +    RTE_MBUF_F_RX_IP_CKSUM_GOOD =3D 1 << 7
> +    #: The IP checksum is not correct in the packet data, but the
> integrity of the IP header is
> +    #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD |
> RTE_MBUF_F_RX_IP_CKSUM_GOOD in the DPDK
> +    #: library.
> +    RTE_MBUF_F_RX_IP_CKSUM_NONE =3D 1 << 24
> +
> +    #: No information about the RX L4 checksum. Value is 0 in the DPDK
> library.
> +    RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN =3D 1 << 25
> +    #: The L4 checksum in the packet is wrong.
> +    RTE_MBUF_F_RX_L4_CKSUM_BAD =3D 1 << 3
> +    #: The L4 checksum in the packet is valid.
> +    RTE_MBUF_F_RX_L4_CKSUM_GOOD =3D 1 << 8
> +    #: The L4 checksum is not correct in the packet data, but the
> integrity of the L4 data is
> +    #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD |
> RTE_MBUF_F_RX_L4_CKSUM_GOOD in the DPDK
> +    #: library.
> +    RTE_MBUF_F_RX_L4_CKSUM_NONE =3D 1 << 26
> +
> +    #: RX IEEE1588 L2 Ethernet PT Packet.
> +    RTE_MBUF_F_RX_IEEE1588_PTP =3D 1 << 9
> +    #: RX IEEE1588 L2/L4 timestamped packet.
> +    RTE_MBUF_F_RX_IEEE1588_TMST =3D 1 << 10
> +
> +    #: FD id reported if FDIR match.
> +    RTE_MBUF_F_RX_FDIR_ID =3D 1 << 13
> +    #: Flexible bytes reported if FDIR match.
> +    RTE_MBUF_F_RX_FDIR_FLX =3D 1 << 14
> +
> +    #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and
> RTE_MBUF_F_RX_VLAN_STRIPPED are set, the 2 VLANs
> +    #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ_STRIPPE=
D
> is set and
> +    #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN is
> removed from packet data.
> +    RTE_MBUF_F_RX_QINQ_STRIPPED =3D auto()
> +
> +    #: When packets are coalesced by a hardware or virtual driver, this
> flag can be set in the RX
> +    #: mbuf, meaning that the m->tso_segsz field is valid and is set to
> the segment size of
> +    #: original packets.
> +    RTE_MBUF_F_RX_LRO =3D auto()
> +
> +    #: Indicate that security offload processing was applied on the RX
> packet.
> +    RTE_MBUF_F_RX_SEC_OFFLOAD =3D 1 << 18
> +    #: Indicate that security offload processing failed on the RX packet=
.
> +    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED =3D auto()
> +
> +    #: The RX packet is a double VLAN. If this flag is set,
> RTE_MBUF_F_RX_VLAN must also be set. If
> +    #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> headers have been stripped
> +    #: from mbuf data, else they are still present.
> +    RTE_MBUF_F_RX_QINQ =3D auto()
> +
> +    #: No info about the outer RX L4 checksum. Value is 0 in the DPDK
> library.
> +    RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN =3D 1 << 27
> +    #: The outer L4 checksum in the packet is wrong
> +    RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD =3D 1 << 21
> +    #: The outer L4 checksum in the packet is valid
> +    RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD =3D 1 << 22
> +    #: Invalid outer L4 checksum state. Value is
> +    #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD |
> RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD in the DPDK library.
> +    RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID =3D 1 << 28
> +
> +    # TX flags
> +
> +    #: Outer UDP checksum offload flag. This flag is used for enabling
> outer UDP checksum in PMD.
> +    #: To use outer UDP checksum, the user either needs to enable the
> following in mbuf:
> +    #:
> +    #:  a) Fill outer_l2_len and outer_l3_len in mbuf.
> +    #:  b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.
> +    #:  c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_TX_OUTER_IPV6
> flag.
> +    #:
> +    #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload flag.
> +    RTE_MBUF_F_TX_OUTER_UDP_CKSUM =3D 1 << 41
> +
> +    #: UDP Fragmentation Offload flag. This flag is used for enabling UD=
P
> fragmentation in SW or in
> +    #: HW.
> +    RTE_MBUF_F_TX_UDP_SEG =3D auto()
> +
> +    #: Request security offload processing on the TX packet. To use Tx
> security offload, the user
> +    #: needs to fill l2_len in mbuf indicating L2 header size and where
> L3 header starts.
> +    #: Similarly, l3_len should also be filled along with ol_flags
> reflecting current L3 type.
> +    RTE_MBUF_F_TX_SEC_OFFLOAD =3D auto()
> +
> +    #: Offload the MACsec. This flag must be set by the application to
> enable this offload feature
> +    #: for a packet to be transmitted.
> +    RTE_MBUF_F_TX_MACSEC =3D auto()
> +
> +    # Bits 45:48 are used for the tunnel type in
> ``lib/mbuf/rte_mbuf_core.h``, but some are modified
> +    # in this Flag to maintain uniqueness. The tunnel type must be
> specified for TSO or checksum on
> +    # the inner part of tunnel packets. These flags can be used with
> RTE_MBUF_F_TX_TCP_SEG for TSO,
> +    # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and outer
> header lengths are required:
> +    # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso_segsz
> for TSO.
> +
> +    #:
> +    RTE_MBUF_F_TX_TUNNEL_VXLAN =3D 1 << 45
> +    #:
> +    RTE_MBUF_F_TX_TUNNEL_GRE =3D 1 << 46
> +    #: Value is 3 << 45 in the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_IPIP =3D 1 << 61
> +    #:
> +    RTE_MBUF_F_TX_TUNNEL_GENEVE =3D 1 << 47
> +    #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 << 45 in
> the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_MPLSINUDP =3D 1 << 62
> +    #: Value is 6 << 45 in the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE =3D 1 << 63
> +    #: Value is 7 << 45 in the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_GTP =3D 1 << 64
> +    #:
> +    RTE_MBUF_F_TX_TUNNEL_ESP =3D 1 << 48
> +    #: Generic IP encapsulated tunnel type, used for TSO and checksum
> offload. This can be used for
> +    #: tunnels which are not standards or listed above. It is preferred
> to use specific tunnel
> +    #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNNEL_IPIP
> if possible. The ethdev
> +    #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.  Outer and
> inner checksums are done
> +    #: according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM.
> Specific tunnel headers that
> +    #: contain payload length, sequence id or checksum are not expected
> to be updated. Value is
> +    #: 0xD << 45 in the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_IP =3D 1 << 65
> +    #: Generic UDP encapsulated tunnel type, used for TSO and checksum
> offload. UDP tunnel type
> +    #: implies outer IP layer. It can be used for tunnels which are not
> standards or listed above.
> +    #: It is preferred to use specific tunnel flags like
> RTE_MBUF_F_TX_TUNNEL_VXLAN if possible.
> +    #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO=
.
> Outer and inner checksums
> +    #: are done according to the existing flags like
> RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel
> +    #: headers that contain payload length, sequence id or checksum are
> not expected to be updated.
> +    #: value is 0xE << 45 in the DPDK library.
> +    RTE_MBUF_F_TX_TUNNEL_UDP =3D 1 << 66
> +
> +    #: Double VLAN insertion (QinQ) request to driver, driver may offloa=
d
> the insertion based on
> +    #: device capability. Mbuf 'vlan_tci' & 'vlan_tci_outer' must be
> valid when this flag is set.
> +    RTE_MBUF_F_TX_QINQ =3D 1 << 49
> +
> +    #: TCP segmentation offload. To enable this offload feature for a
> packet to be transmitted on
> +    #: hardware supporting TSO:
> +    #:
> +    #:  - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf->ol_flags (this fla=
g
> implies
> +    #:      RTE_MBUF_F_TX_TCP_CKSUM)
> +    #:  - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
> +    #:      * if it's IPv4, set the RTE_MBUF_F_TX_IP_CKSUM flag
> +    #:  - fill the mbuf offload information: l2_len, l3_len, l4_len,
> tso_segsz
> +    RTE_MBUF_F_TX_TCP_SEG =3D auto()
> +
> +    #: TX IEEE1588 packet to timestamp.
> +    RTE_MBUF_F_TX_IEEE1588_TMST =3D auto()
> +
> +    # Bits 52+53 used for L4 packet type with checksum enabled in
> ``lib/mbuf/rte_mbuf_core.h`` but
> +    # some values must be modified in this framework to maintain
> uniqueness. To use hardware
> +    # L4 checksum offload, the user needs to:
> +    #
> +    # - fill l2_len and l3_len in mbuf
> +    # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCTP_CKSUM =
or
> +    #   RTE_MBUF_F_TX_UDP_CKSUM
> +    # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
> +
> +    #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK library.
> +    RTE_MBUF_F_TX_L4_NO_CKSUM =3D 1 << 67
> +    #: TCP cksum of TX pkt. Computed by NIC.
> +    RTE_MBUF_F_TX_TCP_CKSUM =3D 1 << 52
> +    #: SCTP cksum of TX pkt. Computed by NIC.
> +    RTE_MBUF_F_TX_SCTP_CKSUM =3D 1 << 53
> +    #: UDP cksum of TX pkt. Computed by NIC. Value is 3 << 52 in the DPD=
K
> library.
> +    RTE_MBUF_F_TX_UDP_CKSUM =3D 1 << 68
> +
> +    #: Offload the IP checksum in the hardware. The flag
> RTE_MBUF_F_TX_IPV4 should also be set by
> +    #: the application, although a PMD will only check
> RTE_MBUF_F_TX_IP_CKSUM.
> +    RTE_MBUF_F_TX_IP_CKSUM =3D 1 << 54
> +
> +    #: Packet is IPv4. This flag must be set when using any offload
> feature (TSO, L3 or L4
> +    #: checksum) to tell the NIC that the packet is an IPv4 packet. If
> the packet is a tunneled
> +    #: packet, this flag is related to the inner headers.
> +    RTE_MBUF_F_TX_IPV4 =3D auto()
> +    #: Packet is IPv6. This flag must be set when using an offload
> feature (TSO or L4 checksum) to
> +    #: tell the NIC that the packet is an IPv6 packet. If the packet is =
a
> tunneled packet, this
> +    #: flag is related to the inner headers.
> +    RTE_MBUF_F_TX_IPV6 =3D auto()
> +    #: VLAN tag insertion request to driver, driver may offload the
> insertion based on the device
> +    #: capability. mbuf 'vlan_tci' field must be valid when this flag is
> set.
> +    RTE_MBUF_F_TX_VLAN =3D auto()
> +
> +    #: Offload the IP checksum of an external header in the hardware. Th=
e
> flag
> +    #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the application,
> although a PMD will only
> +    #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.
> +    RTE_MBUF_F_TX_OUTER_IP_CKSUM =3D auto()
> +    #: Packet outer header is IPv4. This flag must be set when using any
> outer offload feature (L3
> +    #: or L4 checksum) to tell the NIC that the outer header of the
> tunneled packet is an IPv4
> +    #: packet.
> +    RTE_MBUF_F_TX_OUTER_IPV4 =3D auto()
> +    #: Packet outer header is IPv6. This flag must be set when using any
> outer offload feature (L4
> +    #: checksum) to tell the NIC that the outer header of the tunneled
> packet is an IPv6 packet.
> +    RTE_MBUF_F_TX_OUTER_IPV6 =3D auto()
> +
> +    @classmethod
> +    def from_list_string(cls, names: str) -> Self:
> +        """Makes a flag from a whitespace-separated list of names.
> +
> +        Args:
> +            names: a whitespace-separated list containing the members of
> this flag.
> +
> +        Returns:
> +            An instance of this flag.
> +        """
> +        flag =3D cls(0)
> +        for name in names.split():
> +            flag |=3D cls.from_str(name)
> +        return flag
> +
> +    @classmethod
> +    def from_str(cls, name: str) -> Self:
> +        """Makes a flag matching the supplied name.
> +
> +        Args:
> +            name: a valid member of this flag in text
> +        Returns:
> +            An instance of this flag.
> +        """
> +        member_name =3D name.strip().replace("-", "_")
> +        return cls[member_name]
> +
> +    @classmethod
> +    def make_parser(cls) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        return TextParser.wrap(
> +            TextParser.find(r"ol_flags: ([^\n]+)"),
> +            cls.from_list_string,
> +        )
> +
> +
> +class RtePTypes(Flag):
> +    """Flag representing possible packet types in DPDK verbose output.
> +
> +    Values in this class are derived from definitions in the RTE MBUF
> ptype library in DPDK located
> +    in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of values
> in this class should match
> +    the possible return options from the functions
> ``rte_get_ptype_*_name`` in ``rte_mbuf_ptype.c``.
> +
> +    References:
> +        DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``
> +        DPDK ptype name formatting functions:
> ``lib/mbuf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``
> +    """
> +
> +    # L2
> +    #: Ethernet packet type. This is used for outer packet for tunneling
> cases.
> +    L2_ETHER =3D auto()
> +    #: Ethernet packet type for time sync.
> +    L2_ETHER_TIMESYNC =3D auto()
> +    #: ARP (Address Resolution Protocol) packet type.
> +    L2_ETHER_ARP =3D auto()
> +    #: LLDP (Link Layer Discovery Protocol) packet type.
> +    L2_ETHER_LLDP =3D auto()
> +    #: NSH (Network Service Header) packet type.
> +    L2_ETHER_NSH =3D auto()
> +    #: VLAN packet type.
> +    L2_ETHER_VLAN =3D auto()
> +    #: QinQ packet type.
> +    L2_ETHER_QINQ =3D auto()
> +    #: PPPOE packet type.
> +    L2_ETHER_PPPOE =3D auto()
> +    #: FCoE packet type..
> +    L2_ETHER_FCOE =3D auto()
> +    #: MPLS packet type.
> +    L2_ETHER_MPLS =3D auto()
> +    #: No L2 packet information.
> +    L2_UNKNOWN =3D auto()
> +
> +    # L3
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and does not contain any header option.
> +    L3_IPV4 =3D auto()
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and contains header options.
> +    L3_IPV4_EXT =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and does not contain any extension header.
> +    L3_IPV6 =3D auto()
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and may or maynot contain header options.
> +    L3_IPV4_EXT_UNKNOWN =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and contains extension headers.
> +    L3_IPV6_EXT =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> +    #: cases, and may or maynot contain extension headers.
> +    L3_IPV6_EXT_UNKNOWN =3D auto()
> +    #: No L3 packet information.
> +    L3_UNKNOWN =3D auto()
> +
> +    # L4
> +    #: TCP (Transmission Control Protocol) packet type. This is used for
> outer packet for tunneling
> +    #: cases.
> +    L4_TCP =3D auto()
> +    #: UDP (User Datagram Protocol) packet type. This is used for outer
> packet for tunneling cases.
> +    L4_UDP =3D auto()
> +    #: Fragmented IP (Internet Protocol) packet type. This is used for
> outer packet for tunneling
> +    #: cases and refers to those packets of any IP types which can be
> recognized as fragmented. A
> +    #: fragmented packet cannot be recognized as any other L4 types
> (RTE_PTYPE_L4_TCP,
> +    #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP,
> RTE_PTYPE_L4_NONFRAG).
> +    L4_FRAG =3D auto()
> +    #: SCTP (Stream Control Transmission Protocol) packet type. This is
> used for outer packet for
> +    #: tunneling cases.
> +    L4_SCTP =3D auto()
> +    #: ICMP (Internet Control Message Protocol) packet type. This is use=
d
> for outer packet for
> +    #: tunneling cases.
> +    L4_ICMP =3D auto()
> +    #: Non-fragmented IP (Internet Protocol) packet type. This is used
> for outer packet for
> +    #: tunneling cases and refers to those packets of any IP types, that
> cannot be recognized as
> +    #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4_UDP,
> RTE_PTYPE_L4_FRAG,
> +    #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).
> +    L4_NONFRAG =3D auto()
> +    #: IGMP (Internet Group Management Protocol) packet type.
> +    L4_IGMP =3D auto()
> +    #: No L4 packet information.
> +    L4_UNKNOWN =3D auto()
> +
> +    # Tunnel
> +    #: IP (Internet Protocol) in IP (Internet Protocol) tunneling packet
> type.
> +    TUNNEL_IP =3D auto()
> +    #: GRE (Generic Routing Encapsulation) tunneling packet type.
> +    TUNNEL_GRE =3D auto()
> +    #: VXLAN (Virtual eXtensible Local Area Network) tunneling packet
> type.
> +    TUNNEL_VXLAN =3D auto()
> +    #: NVGRE (Network Virtualization using Generic Routing Encapsulation=
)
> tunneling packet type.
> +    TUNNEL_NVGRE =3D auto()
> +    #: GENEVE (Generic Network Virtualization Encapsulation) tunneling
> packet type.
> +    TUNNEL_GENEVE =3D auto()
> +    #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensible Local
> Area Network) or GRE
> +    #: (Generic Routing Encapsulation) could be recognized as this packe=
t
> type, if they can not be
> +    #: recognized independently as of hardware capability.
> +    TUNNEL_GRENAT =3D auto()
> +    #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet type.
> +    TUNNEL_GTPC =3D auto()
> +    #: GTP-U (GPRS Tunnelling Protocol) user data tunneling packet type.
> +    TUNNEL_GTPU =3D auto()
> +    #: ESP (IP Encapsulating Security Payload) tunneling packet type.
> +    TUNNEL_ESP =3D auto()
> +    #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.
> +    TUNNEL_L2TP =3D auto()
> +    #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling packet typ=
e.
> +    TUNNEL_VXLAN_GPE =3D auto()
> +    #: MPLS-in-UDP tunneling packet type (RFC 7510).
> +    TUNNEL_MPLS_IN_UDP =3D auto()
> +    #: MPLS-in-GRE tunneling packet type (RFC 4023).
> +    TUNNEL_MPLS_IN_GRE =3D auto()
> +    #: No tunnel information found on the packet.
> +    TUNNEL_UNKNOWN =3D auto()
> +
> +    # Inner L2
> +    #: Ethernet packet type. This is used for inner packet type only.
> +    INNER_L2_ETHER =3D auto()
> +    #: Ethernet packet type with VLAN (Virtual Local Area Network) tag.
> +    INNER_L2_ETHER_VLAN =3D auto()
> +    #: QinQ packet type.
> +    INNER_L2_ETHER_QINQ =3D auto()
> +    #: No inner L2 information found on the packet.
> +    INNER_L2_UNKNOWN =3D auto()
> +
> +    # Inner L3
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and does
> +    #: not contain any header option.
> +    INNER_L3_IPV4 =3D auto()
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and
> +    #: contains header options.
> +    INNER_L3_IPV4_EXT =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and does
> +    #: not contain any extension header.
> +    INNER_L3_IPV6 =3D auto()
> +    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and may or
> +    #: may not contain header options.
> +    INNER_L3_IPV4_EXT_UNKNOWN =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and
> +    #: contains extension headers.
> +    INNER_L3_IPV6_EXT =3D auto()
> +    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and may or
> +    #: may not contain extension headers.
> +    INNER_L3_IPV6_EXT_UNKNOWN =3D auto()
> +    #: No inner L3 information found on the packet.
> +    INNER_L3_UNKNOWN =3D auto()
> +
> +    # Inner L4
> +    #: TCP (Transmission Control Protocol) packet type. This is used for
> inner packet only.
> +    INNER_L4_TCP =3D auto()
> +    #: UDP (User Datagram Protocol) packet type. This is used for inner
> packet only.
> +    INNER_L4_UDP =3D auto()
> +    #: Fragmented IP (Internet Protocol) packet type. This is used for
> inner packet only, and may
> +    #: or maynot have a layer 4 packet.
> +    INNER_L4_FRAG =3D auto()
> +    #: SCTP (Stream Control Transmission Protocol) packet type. This is
> used for inner packet only.
> +    INNER_L4_SCTP =3D auto()
> +    #: ICMP (Internet Control Message Protocol) packet type. This is use=
d
> for inner packet only.
> +    INNER_L4_ICMP =3D auto()
> +    #: Non-fragmented IP (Internet Protocol) packet type. It is used for
> inner packet only, and may
> +    #: or may not have other unknown layer 4 packet types.
> +    INNER_L4_NONFRAG =3D auto()
> +    #: No inner L4 information found on the packet.
> +    INNER_L4_UNKNOWN =3D auto()
> +
> +    @classmethod
> +    def from_list_string(cls, names: str) -> Self:
> +        """Makes a flag from a whitespace-separated list of names.
> +
> +        Args:
> +            names: a whitespace-separated list containing the members of
> this flag.
> +
> +        Returns:
> +            An instance of this flag.
> +        """
> +        flag =3D cls(0)
> +        for name in names.split():
> +            flag |=3D cls.from_str(name)
> +        return flag
> +
> +    @classmethod
> +    def from_str(cls, name: str) -> Self:
> +        """Makes a flag matching the supplied name.
> +
> +        Args:
> +            name: a valid member of this flag in text
> +        Returns:
> +            An instance of this flag.
> +        """
> +        member_name =3D name.strip().replace("-", "_")
> +        return cls[member_name]
> +
> +    @classmethod
> +    def make_parser(cls, hw: bool) -> ParserFn:
> +        """Makes a parser function.
> +
> +        Args:
> +            hw: Whether to make a parser for hardware ptypes or software
> ptypes. If :data:`True`,
> +                hardware ptypes will be collected, otherwise software
> pytpes will.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> +                parser function that makes an instance of this flag from
> text.
> +        """
> +        return TextParser.wrap(
> +            TextParser.find(f"{'hw' if hw else 'sw'} ptype: ([^-]+)"),
> +            cls.from_list_string,
> +        )
> +
> +
> +@dataclass
> +class TestPmdVerbosePacket(TextParser):
> +    """Packet information provided by verbose output in Testpmd.
> +
> +    This dataclass expects that packet information be prepended with the
> starting line of packet
> +    bursts. Specifically, the line that reads "port X/queue Y:
> sent/received Z packets".
> +    """
> +
> +    #: ID of the port that handled the packet.
> +    port_id: int =3D field(metadata=3DTextParser.find_int(r"port (\d+)/q=
ueue
> \d+"))
> +    #: ID of the queue that handled the packet.
> +    queue_id: int =3D field(metadata=3DTextParser.find_int(r"port \d+/qu=
eue
> (\d+)"))
> +    #: Whether the packet was received or sent by the queue/port.
> +    was_received: bool =3D field(metadata=3DTextParser.find(r"received \=
d+
> packets"))
> +    #:
> +    src_mac: str =3D
> field(metadata=3DTextParser.find(f"src=3D({REGEX_FOR_MAC_ADDRESS})"))
> +    #:
> +    dst_mac: str =3D
> field(metadata=3DTextParser.find(f"dst=3D({REGEX_FOR_MAC_ADDRESS})"))
> +    #: Memory pool the packet was handled on.
> +    pool: str =3D field(metadata=3DTextParser.find(r"pool=3D(\S+)"))
> +    #: Packet type in hex.
> +    p_type: int =3D
> field(metadata=3DTextParser.find_int(r"type=3D(0x[a-fA-F\d]+)"))
> +    #:
> +    length: int =3D field(metadata=3DTextParser.find_int(r"length=3D(\d+=
)"))
> +    #: Number of segments in the packet.
> +    nb_segs: int =3D field(metadata=3DTextParser.find_int(r"nb_segs=3D(\=
d+)"))
> +    #: Hardware packet type.
> +    hw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_parser(hw=3D=
True))
> +    #: Software packet type.
> +    sw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_parser(hw=3D=
False))
> +    #:
> +    l2_len: int =3D field(metadata=3DTextParser.find_int(r"l2_len=3D(\d+=
)"))
> +    #:
> +    ol_flags: PacketOffloadFlag =3D
> field(metadata=3DPacketOffloadFlag.make_parser())
> +    #: RSS hash of the packet in hex.
> +    rss_hash: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"RSS
> hash=3D(0x[a-fA-F\d]+)")
> +    )
> +    #: RSS queue that handled the packet in hex.
> +    rss_queue: int | None =3D field(
> +        default=3DNone, metadata=3DTextParser.find_int(r"RSS
> queue=3D(0x[a-fA-F\d]+)")
> +    )
> +    #:
> +    l3_len: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"l3_len=3D(\d+)"))
> +    #:
> +    l4_len: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"l4_len=3D(\d+)"))
> +    #:
> +    l4_dport: int | None =3D field(
> +        default=3DNone,
> +        metadata=3DTextParser.find_int(r"Destination (?:TCP|UDP)
> port=3D(\d+)"),
> +    )
> +
> +
> +class RxOffloadCapability(Flag):
> +    """Rx offload capabilities of a device.
> +
> +    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> +    They're prefixed with ``RTE_ETH_RX_OFFLOAD`` in
> ``lib/ethdev/rte_ethdev.h``
> +    instead of ``RX_OFFLOAD``, which is what testpmd changes the prefix
> to.
> +    The values are not contiguous, so the correspondence is preserved
> +    by specifying concrete values interspersed between auto() values.
> +
> +    The ``RX_OFFLOAD`` prefix has been preserved so that the same flag
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
> +    #:
> +    RX_OFFLOAD_VLAN_STRIP =3D auto()
> +    #: Device supports L3 checksum offload.
> +    RX_OFFLOAD_IPV4_CKSUM =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_UDP_CKSUM =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_TCP_CKSUM =3D auto()
> +    #: Device supports Large Receive Offload.
> +    RX_OFFLOAD_TCP_LRO =3D auto()
> +    #: Device supports QinQ (queue in queue) offload.
> +    RX_OFFLOAD_QINQ_STRIP =3D auto()
> +    #: Device supports inner packet L3 checksum.
> +    RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> +    #: Device supports MACsec.
> +    RX_OFFLOAD_MACSEC_STRIP =3D auto()
> +    #: Device supports filtering of a VLAN Tag identifier.
> +    RX_OFFLOAD_VLAN_FILTER =3D 1 << 9
> +    #: Device supports VLAN offload.
> +    RX_OFFLOAD_VLAN_EXTEND =3D auto()
> +    #: Device supports receiving segmented mbufs.
> +    RX_OFFLOAD_SCATTER =3D 1 << 13
> +    #: Device supports Timestamp.
> +    RX_OFFLOAD_TIMESTAMP =3D auto()
> +    #: Device supports crypto processing while packet is received in NIC=
.
> +    RX_OFFLOAD_SECURITY =3D auto()
> +    #: Device supports CRC stripping.
> +    RX_OFFLOAD_KEEP_CRC =3D auto()
> +    #: Device supports L4 checksum offload.
> +    RX_OFFLOAD_SCTP_CKSUM =3D auto()
> +    #: Device supports inner packet L4 checksum.
> +    RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> +    #: Device supports RSS hashing.
> +    RX_OFFLOAD_RSS_HASH =3D auto()
> +    #: Device supports
> +    RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> +    #: Device supports all checksum capabilities.
> +    RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM=
 |
> RX_OFFLOAD_TCP_CKSUM
> +    #: Device supports all VLAN capabilities.
> +    RX_OFFLOAD_VLAN =3D (
> +        RX_OFFLOAD_VLAN_STRIP
> +        | RX_OFFLOAD_VLAN_FILTER
> +        | RX_OFFLOAD_VLAN_EXTEND
> +        | RX_OFFLOAD_QINQ_STRIP
> +    )
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
> +            flag |=3D cls[f"RX_OFFLOAD_{flag_name}"]
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
> +class RxOffloadCapabilities(TextParser):
> +    """The result of testpmd's ``show port <port_id> rx_offload
> capabilities`` command.
> +
> +    References:
> +        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
> +        testpmd display function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
> +    """
> +
> +    #:
> +    port_id: int =3D field(
> +        metadata=3DTextParser.find_int(r"Rx Offloading Capabilities of p=
ort
> (\d+) :")
> +    )
> +    #: Per-queue Rx offload capabilities.
> +    per_queue: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(False))
> +    #: Capabilities other than per-queue Rx offload capabilities.
> +    per_port: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(True))
> +
> +
> +@dataclass
> +class TestPmdPortFlowCtrl(TextParser):
> +    """Class representing a port's flow control parameters.
> +
> +    The parameters can also be parsed from the output of ``show port
> <port_id> flow_ctrl``.
> +    """
> +
> +    #: Enable Reactive Extensions.
> +    rx: bool =3D field(default=3DFalse, metadata=3DTextParser.find(r"Rx =
pause:
> on"))
> +    #: Enable Transmit.
> +    tx: bool =3D field(default=3DFalse, metadata=3DTextParser.find(r"Tx =
pause:
> on"))
> +    #: High threshold value to trigger XOFF.
> +    high_water: int =3D field(
> +        default=3D0, metadata=3DTextParser.find_int(r"High waterline:
> (0x[a-fA-F\d]+)")
> +    )
> +    #: Low threshold value to trigger XON.
> +    low_water: int =3D field(
> +        default=3D0, metadata=3DTextParser.find_int(r"Low waterline:
> (0x[a-fA-F\d]+)")
> +    )
> +    #: Pause quota in the Pause frame.
> +    pause_time: int =3D field(default=3D0,
> metadata=3DTextParser.find_int(r"Pause time: (0x[a-fA-F\d]+)"))
> +    #: Send XON frame.
> +    send_xon: bool =3D field(default=3DFalse, metadata=3DTextParser.find=
(r"Tx
> pause: on"))
> +    #: Enable receiving MAC control frames.
> +    mac_ctrl_frame_fwd: bool =3D field(default=3DFalse,
> metadata=3DTextParser.find(r"Tx pause: on"))
> +    #: Change the auto-negotiation parameter.
> +    autoneg: bool =3D field(default=3DFalse,
> metadata=3DTextParser.find(r"Autoneg: on"))
> +
> +    def __str__(self) -> str:
> +        """Returns the string representation of this instance."""
> +        ret =3D (
> +            f"rx {'on' if self.rx else 'off'} "
> +            f"tx {'on' if self.tx else 'off'} "
> +            f"{self.high_water} "
> +            f"{self.low_water} "
> +            f"{self.pause_time} "
> +            f"{1 if self.send_xon else 0} "
> +            f"mac_ctrl_frame_fwd {'on' if self.mac_ctrl_frame_fwd else
> 'off'} "
> +            f"autoneg {'on' if self.autoneg else 'off'}"
> +        )
> +        return ret
> diff --git a/dts/framework/config/__init__.py
> b/dts/framework/config/__init__.py
> index 1ec744d1d4..d2f0138e4a 100644
> --- a/dts/framework/config/__init__.py
> +++ b/dts/framework/config/__init__.py
> @@ -28,7 +28,6 @@
>        and makes it thread safe should we ever want to move in that
> direction.
>  """
>
> -import os
>  from pathlib import Path
>  from typing import TYPE_CHECKING, Annotated, Any, Literal, TypeVar, cast
>
> @@ -43,7 +42,7 @@
>  from .test_run import TestRunConfiguration,
> create_test_suites_config_model
>
>  # Import only if type checking or building docs, to prevent circular
> imports.
> -if TYPE_CHECKING or os.environ.get("DTS_DOC_BUILD"):
> +if TYPE_CHECKING:
>      from framework.test_suite import BaseConfig
>
>  NodesConfig =3D Annotated[list[NodeConfiguration], Field(min_length=3D1)=
]
> diff --git a/dts/framework/params/eal.py b/dts/framework/params/eal.py
> index b90ff33dcf..e84a20f02f 100644
> --- a/dts/framework/params/eal.py
> +++ b/dts/framework/params/eal.py
> @@ -4,15 +4,17 @@
>  """Module representing the DPDK EAL-related parameters."""
>
>  from dataclasses import dataclass, field
> -from typing import Literal
> +from typing import TYPE_CHECKING, Literal
>
>  from framework.params import Params, Switch
>  from framework.testbed_model.cpu import LogicalCoreList
> -from framework.testbed_model.port import Port
>  from framework.testbed_model.virtual_device import VirtualDevice
>
> +if TYPE_CHECKING:
> +    from framework.testbed_model.port import Port
>
> -def _port_to_pci(port: Port) -> str:
> +
> +def _port_to_pci(port: "Port") -> str:
>      return port.pci
>
>
> @@ -42,11 +44,11 @@ class EalParams(Params):
>      vdevs: list[VirtualDevice] | None =3D field(
>          default=3DNone, metadata=3DParams.multiple() | Params.long("vdev=
")
>      )
> -    allowed_ports: list[Port] | None =3D field(
> +    allowed_ports: list["Port"] | None =3D field(
>          default=3DNone,
>          metadata=3DParams.convert_value(_port_to_pci) | Params.multiple(=
) |
> Params.short("a"),
>      )
> -    blocked_ports: list[Port] | None =3D field(
> +    blocked_ports: list["Port"] | None =3D field(
>          default=3DNone,
>          metadata=3DParams.convert_value(_port_to_pci) | Params.multiple(=
) |
> Params.short("b"),
>      )
> diff --git a/dts/framework/params/types.py b/dts/framework/params/types.p=
y
> index 87d11502e8..5bc4bd37d9 100644
> --- a/dts/framework/params/types.py
> +++ b/dts/framework/params/types.py
> @@ -15,8 +15,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict])=
:
>  from pathlib import PurePath
>  from typing import TypedDict
>
> -from framework.params import Switch, YesNoSwitch
> -from framework.params.testpmd import (
> +from api.testpmd.config import (
>      AnonMempoolAllocationMode,
>      EthPeer,
>      Event,
> @@ -37,6 +36,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict])=
:
>      TXRingParams,
>      TxUDPPortPair,
>  )
> +from framework.params import Switch, YesNoSwitch
>  from framework.testbed_model.cpu import LogicalCoreList
>  from framework.testbed_model.port import Port
>  from framework.testbed_model.virtual_device import VirtualDevice
> diff --git a/dts/framework/remote_session/__init__.py
> b/dts/framework/remote_session/__init__.py
> index 1a5cf6abd3..394c88b25e 100644
> --- a/dts/framework/remote_session/__init__.py
> +++ b/dts/framework/remote_session/__init__.py
> @@ -11,47 +11,3 @@
>  The interactive sessions open an interactive shell which is continuously
> open,
>  allowing it to send and receive data within that particular shell.
>  """
> -
> -from framework.config.node import NodeConfiguration
> -from framework.logger import DTSLogger
> -
> -from .interactive_remote_session import InteractiveRemoteSession
> -from .remote_session import RemoteSession
> -from .ssh_session import SSHSession
> -
> -
> -def create_remote_session(
> -    node_config: NodeConfiguration, name: str, logger: DTSLogger
> -) -> RemoteSession:
> -    """Factory for non-interactive remote sessions.
> -
> -    The function returns an SSH session, but will be extended if support
> -    for other protocols is added.
> -
> -    Args:
> -        node_config: The test run configuration of the node to connect t=
o.
> -        name: The name of the session.
> -        logger: The logger instance this session will use.
> -
> -    Returns:
> -        The SSH remote session.
> -    """
> -    return SSHSession(node_config, name, logger)
> -
> -
> -def create_interactive_session(
> -    node_config: NodeConfiguration, logger: DTSLogger
> -) -> InteractiveRemoteSession:
> -    """Factory for interactive remote sessions.
> -
> -    The function returns an interactive SSH session, but will be extende=
d
> if support
> -    for other protocols is added.
> -
> -    Args:
> -        node_config: The test run configuration of the node to connect t=
o.
> -        logger: The logger instance this session will use.
> -
> -    Returns:
> -        The interactive SSH remote session.
> -    """
> -    return InteractiveRemoteSession(node_config, logger)
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> deleted file mode 100644
> index ad8cb273dc..0000000000
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ /dev/null
> @@ -1,2844 +0,0 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2023 University of New Hampshire
> -# Copyright(c) 2023 PANTHEON.tech s.r.o.
> -# Copyright(c) 2024 Arm Limited
> -
> -"""Testpmd interactive shell.
> -
> -Typical usage example in a TestSuite::
> -
> -    testpmd_shell =3D TestPmdShell(self.sut_node)
> -    devices =3D testpmd_shell.get_devices()
> -    for device in devices:
> -        print(device)
> -    testpmd_shell.close()
> -"""
> -
> -import functools
> -import re
> -import time
> -from collections.abc import Callable, MutableSet
> -from dataclasses import dataclass, field
> -from enum import Flag, auto
> -from os import environ
> -from pathlib import PurePath
> -from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal,
> ParamSpec, Tuple, TypeAlias
> -
> -from framework.context import get_ctx
> -from framework.remote_session.interactive_shell import only_active
> -from framework.testbed_model.topology import TopologyType
> -
> -if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
> -    from enum import Enum as NoAliasEnum
> -else:
> -    from aenum import NoAliasEnum
> -
> -from typing_extensions import Self, Unpack
> -
> -from framework.exception import InteractiveCommandExecutionError,
> InternalError
> -from framework.params.testpmd import PortTopology, SimpleForwardingModes=
,
> TestPmdParams
> -from framework.params.types import TestPmdParamsDict
> -from framework.parser import ParserFn, TextParser
> -from framework.remote_session.dpdk_shell import DPDKShell
> -from framework.settings import SETTINGS
> -from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
> -
> -P =3D ParamSpec("P")
> -TestPmdShellMethod =3D Callable[Concatenate["TestPmdShell", P], Any]
> -
> -TestPmdShellCapabilityMethod: TypeAlias =3D Callable[
> -    ["TestPmdShell", MutableSet["NicCapability"],
> MutableSet["NicCapability"]], None
> -]
> -
> -TestPmdShellDecorator: TypeAlias =3D Callable[[TestPmdShellMethod],
> TestPmdShellMethod]
> -
> -TestPmdShellNicCapability =3D tuple[TestPmdShellCapabilityMethod,
> TestPmdShellDecorator | None]
> -
> -
> -class TestPmdDevice:
> -    """The data of a device that testpmd can recognize.
> -
> -    Attributes:
> -        pci_address: The PCI address of the device.
> -    """
> -
> -    pci_address: str
> -
> -    def __init__(self, pci_address_line: str):
> -        """Initialize the device from the testpmd output line string.
> -
> -        Args:
> -            pci_address_line: A line of testpmd output that contains a
> device.
> -        """
> -        self.pci_address =3D pci_address_line.strip().split(": ")[1].str=
ip()
> -
> -    def __str__(self) -> str:
> -        """The PCI address captures what the device is."""
> -        return self.pci_address
> -
> -
> -class VLANOffloadFlag(Flag):
> -    """Flag representing the VLAN offload settings of a NIC port."""
> -
> -    #:
> -    STRIP =3D auto()
> -    #:
> -    FILTER =3D auto()
> -    #:
> -    EXTEND =3D auto()
> -    #:
> -    QINQ_STRIP =3D auto()
> -
> -    @classmethod
> -    def from_str_dict(cls, d):
> -        """Makes an instance from a dict containing the flag member name=
s
> with an "on" value.
> -
> -        Args:
> -            d: A dictionary containing the flag members as keys and any
> string value.
> -
> -        Returns:
> -            A new instance of the flag.
> -        """
> -        flag =3D cls(0)
> -        for name in cls.__members__:
> -            if d.get(name) =3D=3D "on":
> -                flag |=3D cls[name]
> -        return flag
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        return TextParser.wrap(
> -            TextParser.find(
> -                r"VLAN offload:\s+"
> -                r"strip (?P<STRIP>on|off), "
> -                r"filter (?P<FILTER>on|off), "
> -                r"extend (?P<EXTEND>on|off), "
> -                r"qinq strip (?P<QINQ_STRIP>on|off)",
> -                re.MULTILINE,
> -                named=3DTrue,
> -            ),
> -            cls.from_str_dict,
> -        )
> -
> -
> -class ChecksumOffloadOptions(Flag):
> -    """Flag representing checksum hardware offload layer options."""
> -
> -    #:
> -    ip =3D auto()
> -    #:
> -    udp =3D auto()
> -    #:
> -    tcp =3D auto()
> -    #:
> -    sctp =3D auto()
> -    #:
> -    outer_ip =3D auto()
> -    #:
> -    outer_udp =3D auto()
> -
> -
> -class RSSOffloadTypesFlag(Flag):
> -    """Flag representing the RSS offload flow types supported by the NIC
> port."""
> -
> -    #:
> -    ipv4 =3D auto()
> -    #:
> -    ipv4_frag =3D auto()
> -    #:
> -    ipv4_tcp =3D auto()
> -    #:
> -    ipv4_udp =3D auto()
> -    #:
> -    ipv4_sctp =3D auto()
> -    #:
> -    ipv4_other =3D auto()
> -    #:
> -    ipv6 =3D auto()
> -    #:
> -    ipv6_frag =3D auto()
> -    #:
> -    ipv6_tcp =3D auto()
> -    #:
> -    ipv6_udp =3D auto()
> -    #:
> -    ipv6_sctp =3D auto()
> -    #:
> -    ipv6_other =3D auto()
> -    #:
> -    l2_payload =3D auto()
> -    #:
> -    ipv6_ex =3D auto()
> -    #:
> -    ipv6_tcp_ex =3D auto()
> -    #:
> -    ipv6_udp_ex =3D auto()
> -    #:
> -    port =3D auto()
> -    #:
> -    vxlan =3D auto()
> -    #:
> -    geneve =3D auto()
> -    #:
> -    nvgre =3D auto()
> -    #:
> -    user_defined_22 =3D auto()
> -    #:
> -    gtpu =3D auto()
> -    #:
> -    eth =3D auto()
> -    #:
> -    s_vlan =3D auto()
> -    #:
> -    c_vlan =3D auto()
> -    #:
> -    esp =3D auto()
> -    #:
> -    ah =3D auto()
> -    #:
> -    l2tpv3 =3D auto()
> -    #:
> -    pfcp =3D auto()
> -    #:
> -    pppoe =3D auto()
> -    #:
> -    ecpri =3D auto()
> -    #:
> -    mpls =3D auto()
> -    #:
> -    ipv4_chksum =3D auto()
> -    #:
> -    l4_chksum =3D auto()
> -    #:
> -    l2tpv2 =3D auto()
> -    #:
> -    ipv6_flow_label =3D auto()
> -    #:
> -    user_defined_38 =3D auto()
> -    #:
> -    user_defined_39 =3D auto()
> -    #:
> -    user_defined_40 =3D auto()
> -    #:
> -    user_defined_41 =3D auto()
> -    #:
> -    user_defined_42 =3D auto()
> -    #:
> -    user_defined_43 =3D auto()
> -    #:
> -    user_defined_44 =3D auto()
> -    #:
> -    user_defined_45 =3D auto()
> -    #:
> -    user_defined_46 =3D auto()
> -    #:
> -    user_defined_47 =3D auto()
> -    #:
> -    user_defined_48 =3D auto()
> -    #:
> -    user_defined_49 =3D auto()
> -    #:
> -    user_defined_50 =3D auto()
> -    #:
> -    user_defined_51 =3D auto()
> -    #:
> -    l3_pre96 =3D auto()
> -    #:
> -    l3_pre64 =3D auto()
> -    #:
> -    l3_pre56 =3D auto()
> -    #:
> -    l3_pre48 =3D auto()
> -    #:
> -    l3_pre40 =3D auto()
> -    #:
> -    l3_pre32 =3D auto()
> -    #:
> -    l2_dst_only =3D auto()
> -    #:
> -    l2_src_only =3D auto()
> -    #:
> -    l4_dst_only =3D auto()
> -    #:
> -    l4_src_only =3D auto()
> -    #:
> -    l3_dst_only =3D auto()
> -    #:
> -    l3_src_only =3D auto()
> -
> -    #:
> -    ip =3D ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ipv6_other=
 |
> ipv6_ex
> -    #:
> -    udp =3D ipv4_udp | ipv6_udp | ipv6_udp_ex
> -    #:
> -    tcp =3D ipv4_tcp | ipv6_tcp | ipv6_tcp_ex
> -    #:
> -    sctp =3D ipv4_sctp | ipv6_sctp
> -    #:
> -    tunnel =3D vxlan | geneve | nvgre
> -    #:
> -    vlan =3D s_vlan | c_vlan
> -    #:
> -    all =3D (
> -        eth
> -        | vlan
> -        | ip
> -        | tcp
> -        | udp
> -        | sctp
> -        | l2_payload
> -        | l2tpv3
> -        | esp
> -        | ah
> -        | pfcp
> -        | gtpu
> -        | ecpri
> -        | mpls
> -        | l2tpv2
> -    )
> -
> -    @classmethod
> -    def from_list_string(cls, names: str) -> Self:
> -        """Makes a flag from a whitespace-separated list of names.
> -
> -        Args:
> -            names: a whitespace-separated list containing the members of
> this flag.
> -
> -        Returns:
> -            An instance of this flag.
> -        """
> -        flag =3D cls(0)
> -        for name in names.split():
> -            flag |=3D cls.from_str(name)
> -        return flag
> -
> -    @classmethod
> -    def from_str(cls, name: str) -> Self:
> -        """Makes a flag matching the supplied name.
> -
> -        Args:
> -            name: a valid member of this flag in text
> -        Returns:
> -            An instance of this flag.
> -        """
> -        member_name =3D name.strip().replace("-", "_")
> -        return cls[member_name]
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        return TextParser.wrap(
> -            TextParser.find(r"Supported RSS offload flow
> types:((?:\r?\n?  \S+)+)", re.MULTILINE),
> -            RSSOffloadTypesFlag.from_list_string,
> -        )
> -
> -
> -class DeviceCapabilitiesFlag(Flag):
> -    """Flag representing the device capabilities."""
> -
> -    #: Device supports Rx queue setup after device started.
> -    RUNTIME_RX_QUEUE_SETUP =3D auto()
> -    #: Device supports Tx queue setup after device started.
> -    RUNTIME_TX_QUEUE_SETUP =3D auto()
> -    #: Device supports shared Rx queue among ports within Rx domain and
> switch domain.
> -    RXQ_SHARE =3D auto()
> -    #: Device supports keeping flow rules across restart.
> -    FLOW_RULE_KEEP =3D auto()
> -    #: Device supports keeping shared flow objects across restart.
> -    FLOW_SHARED_OBJECT_KEEP =3D auto()
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        return TextParser.wrap(
> -            TextParser.find_int(r"Device capabilities: (0x[A-Fa-f\d]+)")=
,
> -            cls,
> -        )
> -
> -
> -class DeviceErrorHandlingMode(StrEnum):
> -    """Enum representing the device error handling mode."""
> -
> -    #:
> -    none =3D auto()
> -    #:
> -    passive =3D auto()
> -    #:
> -    proactive =3D auto()
> -    #:
> -    unknown =3D auto()
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this enum from
> text.
> -        """
> -        return TextParser.wrap(TextParser.find(r"Device error handling
> mode: (\w+)"), cls)
> -
> -
> -def make_device_private_info_parser() -> ParserFn:
> -    """Device private information parser.
> -
> -    Ensures that we are not parsing invalid device private info output.
> -
> -    Returns:
> -        ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a parser
> -            function that parses the device private info from the TestPm=
d
> port info output.
> -    """
> -
> -    def _validate(info: str):
> -        info =3D info.strip()
> -        if info =3D=3D "none" or info.startswith("Invalid file") or
> info.startswith("Failed to dump"):
> -            return None
> -        return info
> -
> -    return TextParser.wrap(TextParser.find(r"Device private
> info:\s+([\s\S]+)"), _validate)
> -
> -
> -class RxQueueState(StrEnum):
> -    """RX queue states.
> -
> -    References:
> -        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> -        testpmd display function:
> ``app/test-pmd/config.c:get_queue_state_name()``
> -    """
> -
> -    #:
> -    stopped =3D auto()
> -    #:
> -    started =3D auto()
> -    #:
> -    hairpin =3D auto()
> -    #:
> -    unknown =3D auto()
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this enum from
> text.
> -        """
> -        return TextParser.wrap(TextParser.find(r"Rx queue state:
> ([^\r\n]+)"), cls)
> -
> -
> -@dataclass
> -class TestPmdQueueInfo(TextParser):
> -    """Dataclass representation of the common parts of the testpmd `show
> rxq/txq info` commands."""
> -
> -    #:
> -    prefetch_threshold: int =3D
> field(metadata=3DTextParser.find_int(r"prefetch threshold: (\d+)"))
> -    #:
> -    host_threshold: int =3D field(metadata=3DTextParser.find_int(r"host
> threshold: (\d+)"))
> -    #:
> -    writeback_threshold: int =3D
> field(metadata=3DTextParser.find_int(r"writeback threshold: (\d+)"))
> -    #:
> -    free_threshold: int =3D field(metadata=3DTextParser.find_int(r"free
> threshold: (\d+)"))
> -    #:
> -    deferred_start: bool =3D field(metadata=3DTextParser.find("deferred
> start: on"))
> -    #: The number of RXD/TXDs is just the ring size of the queue.
> -    ring_size: int =3D field(metadata=3DTextParser.find_int(r"Number of
> (?:RXDs|TXDs): (\d+)"))
> -    #:
> -    is_queue_started: bool =3D field(metadata=3DTextParser.find("queue s=
tate:
> started"))
> -    #:
> -    burst_mode: str | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"Burst mode: ([^\r\n=
]+)")
> -    )
> -
> -
> -@dataclass
> -class TestPmdTxqInfo(TestPmdQueueInfo):
> -    """Representation of testpmd's ``show txq info <port_id> <queue_id>`=
`
> command.
> -
> -    References:
> -        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_showqueue()``
> -        testpmd display function:
> ``app/test-pmd/config.c:rx_queue_infos_display()``
> -    """
> -
> -    #: Ring size threshold
> -    rs_threshold: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"TX RS threshold=
:
> (\d+)\b")
> -    )
> -
> -
> -@dataclass
> -class TestPmdRxqInfo(TestPmdQueueInfo):
> -    """Representation of testpmd's ``show rxq info <port_id> <queue_id>`=
`
> command.
> -
> -    References:
> -        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_showqueue()``
> -        testpmd display function:
> ``app/test-pmd/config.c:rx_queue_infos_display()``
> -    """
> -
> -    #: Mempool used by that queue
> -    mempool: str | None =3D field(default=3DNone,
> metadata=3DTextParser.find(r"Mempool: ([^\r\n]+)"))
> -    #: Drop packets if no descriptors are available
> -    drop_packets: bool | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"RX drop packets: on=
")
> -    )
> -    #: Scattered packets Rx enabled
> -    scattered_packets: bool | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"RX scattered packet=
s:
> on")
> -    )
> -    #: The state of the queue
> -    queue_state: str | None =3D field(default=3DNone,
> metadata=3DRxQueueState.make_parser())
> -
> -
> -@dataclass
> -class TestPmdPort(TextParser):
> -    """Dataclass representing the result of testpmd's ``show port info``
> command."""
> -
> -    #:
> -    id: int =3D field(metadata=3DTextParser.find_int(r"Infos for port
> (\d+)\b"))
> -    #:
> -    device_name: str =3D field(metadata=3DTextParser.find(r"Device name:
> ([^\r\n]+)"))
> -    #:
> -    driver_name: str =3D field(metadata=3DTextParser.find(r"Driver name:
> ([^\r\n]+)"))
> -    #:
> -    socket_id: int =3D field(metadata=3DTextParser.find_int(r"Connect to
> socket: (\d+)"))
> -    #:
> -    is_link_up: bool =3D field(metadata=3DTextParser.find("Link status: =
up"))
> -    #:
> -    link_speed: str =3D field(metadata=3DTextParser.find(r"Link speed:
> ([^\r\n]+)"))
> -    #:
> -    is_link_full_duplex: bool =3D field(metadata=3DTextParser.find("Link
> duplex: full-duplex"))
> -    #:
> -    is_link_autonegotiated: bool =3D
> field(metadata=3DTextParser.find("Autoneg status: On"))
> -    #:
> -    is_promiscuous_mode_enabled: bool =3D
> field(metadata=3DTextParser.find("Promiscuous mode: enabled"))
> -    #:
> -    is_allmulticast_mode_enabled: bool =3D field(
> -        metadata=3DTextParser.find("Allmulticast mode: enabled")
> -    )
> -    #: Maximum number of MAC addresses
> -    max_mac_addresses_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Maximum number of MAC addresses=
:
> (\d+)")
> -    )
> -    #: Maximum configurable length of RX packet
> -    max_hash_mac_addresses_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Maximum number of MAC addresses=
 of
> hash filtering: (\d+)")
> -    )
> -    #: Minimum size of RX buffer
> -    min_rx_bufsize: int =3D field(metadata=3DTextParser.find_int(r"Minim=
um
> size of RX buffer: (\d+)"))
> -    #: Maximum configurable length of RX packet
> -    max_rx_packet_length: int =3D field(
> -        metadata=3DTextParser.find_int(r"Maximum configurable length of =
RX
> packet: (\d+)")
> -    )
> -    #: Maximum configurable size of LRO aggregated packet
> -    max_lro_packet_size: int =3D field(
> -        metadata=3DTextParser.find_int(r"Maximum configurable size of LR=
O
> aggregated packet: (\d+)")
> -    )
> -
> -    #: Current number of RX queues
> -    rx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Curren=
t
> number of RX queues: (\d+)"))
> -    #: Max possible RX queues
> -    max_rx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Ma=
x
> possible RX queues: (\d+)"))
> -    #: Max possible number of RXDs per queue
> -    max_queue_rxd_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Max possible number of RXDs per
> queue: (\d+)")
> -    )
> -    #: Min possible number of RXDs per queue
> -    min_queue_rxd_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Min possible number of RXDs per
> queue: (\d+)")
> -    )
> -    #: RXDs number alignment
> -    rxd_alignment_num: int =3D field(metadata=3DTextParser.find_int(r"RX=
Ds
> number alignment: (\d+)"))
> -
> -    #: Current number of TX queues
> -    tx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Curren=
t
> number of TX queues: (\d+)"))
> -    #: Max possible TX queues
> -    max_tx_queues_num: int =3D field(metadata=3DTextParser.find_int(r"Ma=
x
> possible TX queues: (\d+)"))
> -    #: Max possible number of TXDs per queue
> -    max_queue_txd_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Max possible number of TXDs per
> queue: (\d+)")
> -    )
> -    #: Min possible number of TXDs per queue
> -    min_queue_txd_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Min possible number of TXDs per
> queue: (\d+)")
> -    )
> -    #: TXDs number alignment
> -    txd_alignment_num: int =3D field(metadata=3DTextParser.find_int(r"TX=
Ds
> number alignment: (\d+)"))
> -    #: Max segment number per packet
> -    max_packet_segment_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Max segment number per packet:
> (\d+)")
> -    )
> -    #: Max segment number per MTU/TSO
> -    max_mtu_segment_num: int =3D field(
> -        metadata=3DTextParser.find_int(r"Max segment number per MTU\/TSO=
:
> (\d+)")
> -    )
> -
> -    #:
> -    device_capabilities: DeviceCapabilitiesFlag =3D field(
> -        metadata=3DDeviceCapabilitiesFlag.make_parser(),
> -    )
> -    #:
> -    device_error_handling_mode: DeviceErrorHandlingMode | None =3D field=
(
> -        default=3DNone, metadata=3DDeviceErrorHandlingMode.make_parser()
> -    )
> -    #:
> -    device_private_info: str | None =3D field(
> -        default=3DNone,
> -        metadata=3Dmake_device_private_info_parser(),
> -    )
> -
> -    #:
> -    hash_key_size: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Hash key size i=
n
> bytes: (\d+)")
> -    )
> -    #:
> -    redirection_table_size: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Redirection tab=
le
> size: (\d+)")
> -    )
> -    #:
> -    supported_rss_offload_flow_types: RSSOffloadTypesFlag =3D field(
> -        default=3DRSSOffloadTypesFlag(0),
> metadata=3DRSSOffloadTypesFlag.make_parser()
> -    )
> -
> -    #:
> -    mac_address: str | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"MAC address:
> ([A-Fa-f0-9:]+)")
> -    )
> -    #:
> -    fw_version: str | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"Firmware-version:
> ([^\r\n]+)")
> -    )
> -    #:
> -    dev_args: str | None =3D field(default=3DNone,
> metadata=3DTextParser.find(r"Devargs: ([^\r\n]+)"))
> -    #: Socket id of the memory allocation
> -    mem_alloc_socket_id: int | None =3D field(
> -        default=3DNone,
> -        metadata=3DTextParser.find_int(r"memory allocation on the socket=
:
> (\d+)"),
> -    )
> -    #:
> -    mtu: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"MTU: (\d+)"))
> -
> -    #:
> -    vlan_offload: VLANOffloadFlag | None =3D field(
> -        default=3DNone,
> -        metadata=3DVLANOffloadFlag.make_parser(),
> -    )
> -
> -    #: Maximum size of RX buffer
> -    max_rx_bufsize: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Maximum size of=
 RX
> buffer: (\d+)")
> -    )
> -    #: Maximum number of VFs
> -    max_vfs_num: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VFs: (\d+)")
> -    )
> -    #: Maximum number of VMDq pools
> -    max_vmdq_pools_num: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VMDq pools: (\d+)")
> -    )
> -
> -    #:
> -    switch_name: str | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find(r"Switch name: ([\r\n=
]+)")
> -    )
> -    #:
> -    switch_domain_id: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Switch domain I=
d:
> (\d+)")
> -    )
> -    #:
> -    switch_port_id: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Switch Port Id:
> (\d+)")
> -    )
> -    #:
> -    switch_rx_domain: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Switch Rx domai=
n:
> (\d+)")
> -    )
> -
> -
> -@dataclass
> -class TestPmdPortStats(TextParser):
> -    """Port statistics."""
> -
> -    #:
> -    port_id: int =3D field(metadata=3DTextParser.find_int(r"NIC statisti=
cs
> for port (\d+)"))
> -
> -    #:
> -    rx_packets: int =3D
> field(metadata=3DTextParser.find_int(r"RX-packets:\s+(\d+)"))
> -    #:
> -    rx_missed: int =3D
> field(metadata=3DTextParser.find_int(r"RX-missed:\s+(\d+)"))
> -    #:
> -    rx_bytes: int =3D
> field(metadata=3DTextParser.find_int(r"RX-bytes:\s+(\d+)"))
> -    #:
> -    rx_errors: int =3D
> field(metadata=3DTextParser.find_int(r"RX-errors:\s+(\d+)"))
> -    #:
> -    rx_nombuf: int =3D
> field(metadata=3DTextParser.find_int(r"RX-nombuf:\s+(\d+)"))
> -
> -    #:
> -    tx_packets: int =3D
> field(metadata=3DTextParser.find_int(r"TX-packets:\s+(\d+)"))
> -    #:
> -    tx_errors: int =3D
> field(metadata=3DTextParser.find_int(r"TX-errors:\s+(\d+)"))
> -    #:
> -    tx_bytes: int =3D
> field(metadata=3DTextParser.find_int(r"TX-bytes:\s+(\d+)"))
> -
> -    #:
> -    rx_pps: int =3D field(metadata=3DTextParser.find_int(r"Rx-pps:\s+(\d=
+)"))
> -    #:
> -    rx_bps: int =3D field(metadata=3DTextParser.find_int(r"Rx-bps:\s+(\d=
+)"))
> -
> -    #:
> -    tx_pps: int =3D field(metadata=3DTextParser.find_int(r"Tx-pps:\s+(\d=
+)"))
> -    #:
> -    tx_bps: int =3D field(metadata=3DTextParser.find_int(r"Tx-bps:\s+(\d=
+)"))
> -
> -
> -@dataclass(kw_only=3DTrue)
> -class FlowRule:
> -    """Class representation of flow rule parameters.
> -
> -    This class represents the parameters of any flow rule as per the
> -    following pattern:
> -
> -    [group {group_id}] [priority {level}] [ingress] [egress]
> -    [user_id {user_id}] pattern {item} [/ {item} [...]] / end
> -    actions {action} [/ {action} [...]] / end
> -    """
> -
> -    #:
> -    group_id: int | None =3D None
> -    #:
> -    priority_level: int | None =3D None
> -    #:
> -    direction: Literal["ingress", "egress"]
> -    #:
> -    user_id: int | None =3D None
> -    #:
> -    pattern: list[str]
> -    #:
> -    actions: list[str]
> -
> -    def __str__(self) -> str:
> -        """Returns the string representation of this instance."""
> -        ret =3D ""
> -        pattern =3D " / ".join(self.pattern)
> -        action =3D " / ".join(self.actions)
> -        if self.group_id is not None:
> -            ret +=3D f"group {self.group_id} "
> -        if self.priority_level is not None:
> -            ret +=3D f"priority {self.priority_level} "
> -        ret +=3D f"{self.direction} "
> -        if self.user_id is not None:
> -            ret +=3D f"user_id {self.user_id} "
> -        ret +=3D f"pattern {pattern} / end "
> -        ret +=3D f"actions {action} / end"
> -        return ret
> -
> -
> -class PacketOffloadFlag(Flag):
> -    """Flag representing the Packet Offload Features Flags in DPDK.
> -
> -    Values in this class are taken from the definitions in the RTE MBUF
> core library in DPDK
> -    located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that flag
> values in this class will
> -    match the values they are set to in said DPDK library with one
> exception; all values must be
> -    unique. For example, the definitions for unknown checksum flags in
> ``rte_mbuf_core.h`` are all
> -    set to :data:`0`, but it is valuable to distinguish between them in
> this framework. For this
> -    reason flags that are not unique in the DPDK library are set either
> to values within the
> -    RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or shifted
> 61+ bits for Tx.
> -
> -    References:
> -        DPDK lib: ``lib/mbuf/rte_mbuf_core.h``
> -    """
> -
> -    # RX flags
> -
> -    #: The RX packet is a 802.1q VLAN packet, and the tci has been saved
> in mbuf->vlan_tci. If the
> -    #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN header
> has been stripped from
> -    #: mbuf data, else it is still present.
> -    RTE_MBUF_F_RX_VLAN =3D auto()
> -
> -    #: RX packet with RSS hash result.
> -    RTE_MBUF_F_RX_RSS_HASH =3D auto()
> -
> -    #: RX packet with FDIR match indicate.
> -    RTE_MBUF_F_RX_FDIR =3D auto()
> -
> -    #: This flag is set when the outermost IP header checksum is detecte=
d
> as wrong by the hardware.
> -    RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD =3D 1 << 5
> -
> -    #: A vlan has been stripped by the hardware and its tci is saved in
> mbuf->vlan_tci. This can
> -    #: only happen if vlan stripping is enabled in the RX configuration
> of the PMD. When
> -    #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also
> be set.
> -    RTE_MBUF_F_RX_VLAN_STRIPPED =3D auto()
> -
> -    #: No information about the RX IP checksum. Value is 0 in the DPDK
> library.
> -    RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN =3D 1 << 23
> -    #: The IP checksum in the packet is wrong.
> -    RTE_MBUF_F_RX_IP_CKSUM_BAD =3D 1 << 4
> -    #: The IP checksum in the packet is valid.
> -    RTE_MBUF_F_RX_IP_CKSUM_GOOD =3D 1 << 7
> -    #: The IP checksum is not correct in the packet data, but the
> integrity of the IP header is
> -    #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD |
> RTE_MBUF_F_RX_IP_CKSUM_GOOD in the DPDK
> -    #: library.
> -    RTE_MBUF_F_RX_IP_CKSUM_NONE =3D 1 << 24
> -
> -    #: No information about the RX L4 checksum. Value is 0 in the DPDK
> library.
> -    RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN =3D 1 << 25
> -    #: The L4 checksum in the packet is wrong.
> -    RTE_MBUF_F_RX_L4_CKSUM_BAD =3D 1 << 3
> -    #: The L4 checksum in the packet is valid.
> -    RTE_MBUF_F_RX_L4_CKSUM_GOOD =3D 1 << 8
> -    #: The L4 checksum is not correct in the packet data, but the
> integrity of the L4 data is
> -    #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD |
> RTE_MBUF_F_RX_L4_CKSUM_GOOD in the DPDK
> -    #: library.
> -    RTE_MBUF_F_RX_L4_CKSUM_NONE =3D 1 << 26
> -
> -    #: RX IEEE1588 L2 Ethernet PT Packet.
> -    RTE_MBUF_F_RX_IEEE1588_PTP =3D 1 << 9
> -    #: RX IEEE1588 L2/L4 timestamped packet.
> -    RTE_MBUF_F_RX_IEEE1588_TMST =3D 1 << 10
> -
> -    #: FD id reported if FDIR match.
> -    RTE_MBUF_F_RX_FDIR_ID =3D 1 << 13
> -    #: Flexible bytes reported if FDIR match.
> -    RTE_MBUF_F_RX_FDIR_FLX =3D 1 << 14
> -
> -    #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and
> RTE_MBUF_F_RX_VLAN_STRIPPED are set, the 2 VLANs
> -    #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ_STRIPPE=
D
> is set and
> -    #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN is
> removed from packet data.
> -    RTE_MBUF_F_RX_QINQ_STRIPPED =3D auto()
> -
> -    #: When packets are coalesced by a hardware or virtual driver, this
> flag can be set in the RX
> -    #: mbuf, meaning that the m->tso_segsz field is valid and is set to
> the segment size of
> -    #: original packets.
> -    RTE_MBUF_F_RX_LRO =3D auto()
> -
> -    #: Indicate that security offload processing was applied on the RX
> packet.
> -    RTE_MBUF_F_RX_SEC_OFFLOAD =3D 1 << 18
> -    #: Indicate that security offload processing failed on the RX packet=
.
> -    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED =3D auto()
> -
> -    #: The RX packet is a double VLAN. If this flag is set,
> RTE_MBUF_F_RX_VLAN must also be set. If
> -    #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> headers have been stripped
> -    #: from mbuf data, else they are still present.
> -    RTE_MBUF_F_RX_QINQ =3D auto()
> -
> -    #: No info about the outer RX L4 checksum. Value is 0 in the DPDK
> library.
> -    RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN =3D 1 << 27
> -    #: The outer L4 checksum in the packet is wrong
> -    RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD =3D 1 << 21
> -    #: The outer L4 checksum in the packet is valid
> -    RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD =3D 1 << 22
> -    #: Invalid outer L4 checksum state. Value is
> -    #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD |
> RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD in the DPDK library.
> -    RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID =3D 1 << 28
> -
> -    # TX flags
> -
> -    #: Outer UDP checksum offload flag. This flag is used for enabling
> outer UDP checksum in PMD.
> -    #: To use outer UDP checksum, the user either needs to enable the
> following in mbuf:
> -    #:
> -    #:  a) Fill outer_l2_len and outer_l3_len in mbuf.
> -    #:  b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.
> -    #:  c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_TX_OUTER_IPV6
> flag.
> -    #:
> -    #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload flag.
> -    RTE_MBUF_F_TX_OUTER_UDP_CKSUM =3D 1 << 41
> -
> -    #: UDP Fragmentation Offload flag. This flag is used for enabling UD=
P
> fragmentation in SW or in
> -    #: HW.
> -    RTE_MBUF_F_TX_UDP_SEG =3D auto()
> -
> -    #: Request security offload processing on the TX packet. To use Tx
> security offload, the user
> -    #: needs to fill l2_len in mbuf indicating L2 header size and where
> L3 header starts.
> -    #: Similarly, l3_len should also be filled along with ol_flags
> reflecting current L3 type.
> -    RTE_MBUF_F_TX_SEC_OFFLOAD =3D auto()
> -
> -    #: Offload the MACsec. This flag must be set by the application to
> enable this offload feature
> -    #: for a packet to be transmitted.
> -    RTE_MBUF_F_TX_MACSEC =3D auto()
> -
> -    # Bits 45:48 are used for the tunnel type in
> ``lib/mbuf/rte_mbuf_core.h``, but some are modified
> -    # in this Flag to maintain uniqueness. The tunnel type must be
> specified for TSO or checksum on
> -    # the inner part of tunnel packets. These flags can be used with
> RTE_MBUF_F_TX_TCP_SEG for TSO,
> -    # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and outer
> header lengths are required:
> -    # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso_segsz
> for TSO.
> -
> -    #:
> -    RTE_MBUF_F_TX_TUNNEL_VXLAN =3D 1 << 45
> -    #:
> -    RTE_MBUF_F_TX_TUNNEL_GRE =3D 1 << 46
> -    #: Value is 3 << 45 in the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_IPIP =3D 1 << 61
> -    #:
> -    RTE_MBUF_F_TX_TUNNEL_GENEVE =3D 1 << 47
> -    #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 << 45 in
> the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_MPLSINUDP =3D 1 << 62
> -    #: Value is 6 << 45 in the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE =3D 1 << 63
> -    #: Value is 7 << 45 in the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_GTP =3D 1 << 64
> -    #:
> -    RTE_MBUF_F_TX_TUNNEL_ESP =3D 1 << 48
> -    #: Generic IP encapsulated tunnel type, used for TSO and checksum
> offload. This can be used for
> -    #: tunnels which are not standards or listed above. It is preferred
> to use specific tunnel
> -    #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNNEL_IPIP
> if possible. The ethdev
> -    #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.  Outer and
> inner checksums are done
> -    #: according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM.
> Specific tunnel headers that
> -    #: contain payload length, sequence id or checksum are not expected
> to be updated. Value is
> -    #: 0xD << 45 in the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_IP =3D 1 << 65
> -    #: Generic UDP encapsulated tunnel type, used for TSO and checksum
> offload. UDP tunnel type
> -    #: implies outer IP layer. It can be used for tunnels which are not
> standards or listed above.
> -    #: It is preferred to use specific tunnel flags like
> RTE_MBUF_F_TX_TUNNEL_VXLAN if possible.
> -    #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO=
.
> Outer and inner checksums
> -    #: are done according to the existing flags like
> RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel
> -    #: headers that contain payload length, sequence id or checksum are
> not expected to be updated.
> -    #: value is 0xE << 45 in the DPDK library.
> -    RTE_MBUF_F_TX_TUNNEL_UDP =3D 1 << 66
> -
> -    #: Double VLAN insertion (QinQ) request to driver, driver may offloa=
d
> the insertion based on
> -    #: device capability. Mbuf 'vlan_tci' & 'vlan_tci_outer' must be
> valid when this flag is set.
> -    RTE_MBUF_F_TX_QINQ =3D 1 << 49
> -
> -    #: TCP segmentation offload. To enable this offload feature for a
> packet to be transmitted on
> -    #: hardware supporting TSO:
> -    #:
> -    #:  - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf->ol_flags (this fla=
g
> implies
> -    #:      RTE_MBUF_F_TX_TCP_CKSUM)
> -    #:  - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
> -    #:      * if it's IPv4, set the RTE_MBUF_F_TX_IP_CKSUM flag
> -    #:  - fill the mbuf offload information: l2_len, l3_len, l4_len,
> tso_segsz
> -    RTE_MBUF_F_TX_TCP_SEG =3D auto()
> -
> -    #: TX IEEE1588 packet to timestamp.
> -    RTE_MBUF_F_TX_IEEE1588_TMST =3D auto()
> -
> -    # Bits 52+53 used for L4 packet type with checksum enabled in
> ``lib/mbuf/rte_mbuf_core.h`` but
> -    # some values must be modified in this framework to maintain
> uniqueness. To use hardware
> -    # L4 checksum offload, the user needs to:
> -    #
> -    # - fill l2_len and l3_len in mbuf
> -    # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCTP_CKSUM =
or
> -    #   RTE_MBUF_F_TX_UDP_CKSUM
> -    # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
> -
> -    #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK library.
> -    RTE_MBUF_F_TX_L4_NO_CKSUM =3D 1 << 67
> -    #: TCP cksum of TX pkt. Computed by NIC.
> -    RTE_MBUF_F_TX_TCP_CKSUM =3D 1 << 52
> -    #: SCTP cksum of TX pkt. Computed by NIC.
> -    RTE_MBUF_F_TX_SCTP_CKSUM =3D 1 << 53
> -    #: UDP cksum of TX pkt. Computed by NIC. Value is 3 << 52 in the DPD=
K
> library.
> -    RTE_MBUF_F_TX_UDP_CKSUM =3D 1 << 68
> -
> -    #: Offload the IP checksum in the hardware. The flag
> RTE_MBUF_F_TX_IPV4 should also be set by
> -    #: the application, although a PMD will only check
> RTE_MBUF_F_TX_IP_CKSUM.
> -    RTE_MBUF_F_TX_IP_CKSUM =3D 1 << 54
> -
> -    #: Packet is IPv4. This flag must be set when using any offload
> feature (TSO, L3 or L4
> -    #: checksum) to tell the NIC that the packet is an IPv4 packet. If
> the packet is a tunneled
> -    #: packet, this flag is related to the inner headers.
> -    RTE_MBUF_F_TX_IPV4 =3D auto()
> -    #: Packet is IPv6. This flag must be set when using an offload
> feature (TSO or L4 checksum) to
> -    #: tell the NIC that the packet is an IPv6 packet. If the packet is =
a
> tunneled packet, this
> -    #: flag is related to the inner headers.
> -    RTE_MBUF_F_TX_IPV6 =3D auto()
> -    #: VLAN tag insertion request to driver, driver may offload the
> insertion based on the device
> -    #: capability. mbuf 'vlan_tci' field must be valid when this flag is
> set.
> -    RTE_MBUF_F_TX_VLAN =3D auto()
> -
> -    #: Offload the IP checksum of an external header in the hardware. Th=
e
> flag
> -    #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the application,
> although a PMD will only
> -    #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.
> -    RTE_MBUF_F_TX_OUTER_IP_CKSUM =3D auto()
> -    #: Packet outer header is IPv4. This flag must be set when using any
> outer offload feature (L3
> -    #: or L4 checksum) to tell the NIC that the outer header of the
> tunneled packet is an IPv4
> -    #: packet.
> -    RTE_MBUF_F_TX_OUTER_IPV4 =3D auto()
> -    #: Packet outer header is IPv6. This flag must be set when using any
> outer offload feature (L4
> -    #: checksum) to tell the NIC that the outer header of the tunneled
> packet is an IPv6 packet.
> -    RTE_MBUF_F_TX_OUTER_IPV6 =3D auto()
> -
> -    @classmethod
> -    def from_list_string(cls, names: str) -> Self:
> -        """Makes a flag from a whitespace-separated list of names.
> -
> -        Args:
> -            names: a whitespace-separated list containing the members of
> this flag.
> -
> -        Returns:
> -            An instance of this flag.
> -        """
> -        flag =3D cls(0)
> -        for name in names.split():
> -            flag |=3D cls.from_str(name)
> -        return flag
> -
> -    @classmethod
> -    def from_str(cls, name: str) -> Self:
> -        """Makes a flag matching the supplied name.
> -
> -        Args:
> -            name: a valid member of this flag in text
> -        Returns:
> -            An instance of this flag.
> -        """
> -        member_name =3D name.strip().replace("-", "_")
> -        return cls[member_name]
> -
> -    @classmethod
> -    def make_parser(cls) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        return TextParser.wrap(
> -            TextParser.find(r"ol_flags: ([^\n]+)"),
> -            cls.from_list_string,
> -        )
> -
> -
> -class RtePTypes(Flag):
> -    """Flag representing possible packet types in DPDK verbose output.
> -
> -    Values in this class are derived from definitions in the RTE MBUF
> ptype library in DPDK located
> -    in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of values
> in this class should match
> -    the possible return options from the functions
> ``rte_get_ptype_*_name`` in ``rte_mbuf_ptype.c``.
> -
> -    References:
> -        DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``
> -        DPDK ptype name formatting functions:
> ``lib/mbuf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``
> -    """
> -
> -    # L2
> -    #: Ethernet packet type. This is used for outer packet for tunneling
> cases.
> -    L2_ETHER =3D auto()
> -    #: Ethernet packet type for time sync.
> -    L2_ETHER_TIMESYNC =3D auto()
> -    #: ARP (Address Resolution Protocol) packet type.
> -    L2_ETHER_ARP =3D auto()
> -    #: LLDP (Link Layer Discovery Protocol) packet type.
> -    L2_ETHER_LLDP =3D auto()
> -    #: NSH (Network Service Header) packet type.
> -    L2_ETHER_NSH =3D auto()
> -    #: VLAN packet type.
> -    L2_ETHER_VLAN =3D auto()
> -    #: QinQ packet type.
> -    L2_ETHER_QINQ =3D auto()
> -    #: PPPOE packet type.
> -    L2_ETHER_PPPOE =3D auto()
> -    #: FCoE packet type..
> -    L2_ETHER_FCOE =3D auto()
> -    #: MPLS packet type.
> -    L2_ETHER_MPLS =3D auto()
> -    #: No L2 packet information.
> -    L2_UNKNOWN =3D auto()
> -
> -    # L3
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and does not contain any header option.
> -    L3_IPV4 =3D auto()
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and contains header options.
> -    L3_IPV4_EXT =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and does not contain any extension header.
> -    L3_IPV6 =3D auto()
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and may or maynot contain header options.
> -    L3_IPV4_EXT_UNKNOWN =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and contains extension headers.
> -    L3_IPV6_EXT =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> outer packet for tunneling
> -    #: cases, and may or maynot contain extension headers.
> -    L3_IPV6_EXT_UNKNOWN =3D auto()
> -    #: No L3 packet information.
> -    L3_UNKNOWN =3D auto()
> -
> -    # L4
> -    #: TCP (Transmission Control Protocol) packet type. This is used for
> outer packet for tunneling
> -    #: cases.
> -    L4_TCP =3D auto()
> -    #: UDP (User Datagram Protocol) packet type. This is used for outer
> packet for tunneling cases.
> -    L4_UDP =3D auto()
> -    #: Fragmented IP (Internet Protocol) packet type. This is used for
> outer packet for tunneling
> -    #: cases and refers to those packets of any IP types which can be
> recognized as fragmented. A
> -    #: fragmented packet cannot be recognized as any other L4 types
> (RTE_PTYPE_L4_TCP,
> -    #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP,
> RTE_PTYPE_L4_NONFRAG).
> -    L4_FRAG =3D auto()
> -    #: SCTP (Stream Control Transmission Protocol) packet type. This is
> used for outer packet for
> -    #: tunneling cases.
> -    L4_SCTP =3D auto()
> -    #: ICMP (Internet Control Message Protocol) packet type. This is use=
d
> for outer packet for
> -    #: tunneling cases.
> -    L4_ICMP =3D auto()
> -    #: Non-fragmented IP (Internet Protocol) packet type. This is used
> for outer packet for
> -    #: tunneling cases and refers to those packets of any IP types, that
> cannot be recognized as
> -    #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4_UDP,
> RTE_PTYPE_L4_FRAG,
> -    #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).
> -    L4_NONFRAG =3D auto()
> -    #: IGMP (Internet Group Management Protocol) packet type.
> -    L4_IGMP =3D auto()
> -    #: No L4 packet information.
> -    L4_UNKNOWN =3D auto()
> -
> -    # Tunnel
> -    #: IP (Internet Protocol) in IP (Internet Protocol) tunneling packet
> type.
> -    TUNNEL_IP =3D auto()
> -    #: GRE (Generic Routing Encapsulation) tunneling packet type.
> -    TUNNEL_GRE =3D auto()
> -    #: VXLAN (Virtual eXtensible Local Area Network) tunneling packet
> type.
> -    TUNNEL_VXLAN =3D auto()
> -    #: NVGRE (Network Virtualization using Generic Routing Encapsulation=
)
> tunneling packet type.
> -    TUNNEL_NVGRE =3D auto()
> -    #: GENEVE (Generic Network Virtualization Encapsulation) tunneling
> packet type.
> -    TUNNEL_GENEVE =3D auto()
> -    #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensible Local
> Area Network) or GRE
> -    #: (Generic Routing Encapsulation) could be recognized as this packe=
t
> type, if they can not be
> -    #: recognized independently as of hardware capability.
> -    TUNNEL_GRENAT =3D auto()
> -    #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet type.
> -    TUNNEL_GTPC =3D auto()
> -    #: GTP-U (GPRS Tunnelling Protocol) user data tunneling packet type.
> -    TUNNEL_GTPU =3D auto()
> -    #: ESP (IP Encapsulating Security Payload) tunneling packet type.
> -    TUNNEL_ESP =3D auto()
> -    #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.
> -    TUNNEL_L2TP =3D auto()
> -    #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling packet typ=
e.
> -    TUNNEL_VXLAN_GPE =3D auto()
> -    #: MPLS-in-UDP tunneling packet type (RFC 7510).
> -    TUNNEL_MPLS_IN_UDP =3D auto()
> -    #: MPLS-in-GRE tunneling packet type (RFC 4023).
> -    TUNNEL_MPLS_IN_GRE =3D auto()
> -    #: No tunnel information found on the packet.
> -    TUNNEL_UNKNOWN =3D auto()
> -
> -    # Inner L2
> -    #: Ethernet packet type. This is used for inner packet type only.
> -    INNER_L2_ETHER =3D auto()
> -    #: Ethernet packet type with VLAN (Virtual Local Area Network) tag.
> -    INNER_L2_ETHER_VLAN =3D auto()
> -    #: QinQ packet type.
> -    INNER_L2_ETHER_QINQ =3D auto()
> -    #: No inner L2 information found on the packet.
> -    INNER_L2_UNKNOWN =3D auto()
> -
> -    # Inner L3
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and does
> -    #: not contain any header option.
> -    INNER_L3_IPV4 =3D auto()
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and
> -    #: contains header options.
> -    INNER_L3_IPV4_EXT =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and does
> -    #: not contain any extension header.
> -    INNER_L3_IPV6 =3D auto()
> -    #: IP (Internet Protocol) version 4 packet type. This is used for
> inner packet only, and may or
> -    #: may not contain header options.
> -    INNER_L3_IPV4_EXT_UNKNOWN =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and
> -    #: contains extension headers.
> -    INNER_L3_IPV6_EXT =3D auto()
> -    #: IP (Internet Protocol) version 6 packet type. This is used for
> inner packet only, and may or
> -    #: may not contain extension headers.
> -    INNER_L3_IPV6_EXT_UNKNOWN =3D auto()
> -    #: No inner L3 information found on the packet.
> -    INNER_L3_UNKNOWN =3D auto()
> -
> -    # Inner L4
> -    #: TCP (Transmission Control Protocol) packet type. This is used for
> inner packet only.
> -    INNER_L4_TCP =3D auto()
> -    #: UDP (User Datagram Protocol) packet type. This is used for inner
> packet only.
> -    INNER_L4_UDP =3D auto()
> -    #: Fragmented IP (Internet Protocol) packet type. This is used for
> inner packet only, and may
> -    #: or maynot have a layer 4 packet.
> -    INNER_L4_FRAG =3D auto()
> -    #: SCTP (Stream Control Transmission Protocol) packet type. This is
> used for inner packet only.
> -    INNER_L4_SCTP =3D auto()
> -    #: ICMP (Internet Control Message Protocol) packet type. This is use=
d
> for inner packet only.
> -    INNER_L4_ICMP =3D auto()
> -    #: Non-fragmented IP (Internet Protocol) packet type. It is used for
> inner packet only, and may
> -    #: or may not have other unknown layer 4 packet types.
> -    INNER_L4_NONFRAG =3D auto()
> -    #: No inner L4 information found on the packet.
> -    INNER_L4_UNKNOWN =3D auto()
> -
> -    @classmethod
> -    def from_list_string(cls, names: str) -> Self:
> -        """Makes a flag from a whitespace-separated list of names.
> -
> -        Args:
> -            names: a whitespace-separated list containing the members of
> this flag.
> -
> -        Returns:
> -            An instance of this flag.
> -        """
> -        flag =3D cls(0)
> -        for name in names.split():
> -            flag |=3D cls.from_str(name)
> -        return flag
> -
> -    @classmethod
> -    def from_str(cls, name: str) -> Self:
> -        """Makes a flag matching the supplied name.
> -
> -        Args:
> -            name: a valid member of this flag in text
> -        Returns:
> -            An instance of this flag.
> -        """
> -        member_name =3D name.strip().replace("-", "_")
> -        return cls[member_name]
> -
> -    @classmethod
> -    def make_parser(cls, hw: bool) -> ParserFn:
> -        """Makes a parser function.
> -
> -        Args:
> -            hw: Whether to make a parser for hardware ptypes or software
> ptypes. If :data:`True`,
> -                hardware ptypes will be collected, otherwise software
> pytpes will.
> -
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata
> argument containing a
> -                parser function that makes an instance of this flag from
> text.
> -        """
> -        return TextParser.wrap(
> -            TextParser.find(f"{'hw' if hw else 'sw'} ptype: ([^-]+)"),
> -            cls.from_list_string,
> -        )
> -
> -
> -@dataclass
> -class TestPmdVerbosePacket(TextParser):
> -    """Packet information provided by verbose output in Testpmd.
> -
> -    This dataclass expects that packet information be prepended with the
> starting line of packet
> -    bursts. Specifically, the line that reads "port X/queue Y:
> sent/received Z packets".
> -    """
> -
> -    #: ID of the port that handled the packet.
> -    port_id: int =3D field(metadata=3DTextParser.find_int(r"port (\d+)/q=
ueue
> \d+"))
> -    #: ID of the queue that handled the packet.
> -    queue_id: int =3D field(metadata=3DTextParser.find_int(r"port \d+/qu=
eue
> (\d+)"))
> -    #: Whether the packet was received or sent by the queue/port.
> -    was_received: bool =3D field(metadata=3DTextParser.find(r"received \=
d+
> packets"))
> -    #:
> -    src_mac: str =3D
> field(metadata=3DTextParser.find(f"src=3D({REGEX_FOR_MAC_ADDRESS})"))
> -    #:
> -    dst_mac: str =3D
> field(metadata=3DTextParser.find(f"dst=3D({REGEX_FOR_MAC_ADDRESS})"))
> -    #: Memory pool the packet was handled on.
> -    pool: str =3D field(metadata=3DTextParser.find(r"pool=3D(\S+)"))
> -    #: Packet type in hex.
> -    p_type: int =3D
> field(metadata=3DTextParser.find_int(r"type=3D(0x[a-fA-F\d]+)"))
> -    #:
> -    length: int =3D field(metadata=3DTextParser.find_int(r"length=3D(\d+=
)"))
> -    #: Number of segments in the packet.
> -    nb_segs: int =3D field(metadata=3DTextParser.find_int(r"nb_segs=3D(\=
d+)"))
> -    #: Hardware packet type.
> -    hw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_parser(hw=3D=
True))
> -    #: Software packet type.
> -    sw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_parser(hw=3D=
False))
> -    #:
> -    l2_len: int =3D field(metadata=3DTextParser.find_int(r"l2_len=3D(\d+=
)"))
> -    #:
> -    ol_flags: PacketOffloadFlag =3D
> field(metadata=3DPacketOffloadFlag.make_parser())
> -    #: RSS hash of the packet in hex.
> -    rss_hash: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"RSS
> hash=3D(0x[a-fA-F\d]+)")
> -    )
> -    #: RSS queue that handled the packet in hex.
> -    rss_queue: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"RSS
> queue=3D(0x[a-fA-F\d]+)")
> -    )
> -    #:
> -    l3_len: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"l3_len=3D(\d+)"))
> -    #:
> -    l4_len: int | None =3D field(default=3DNone,
> metadata=3DTextParser.find_int(r"l4_len=3D(\d+)"))
> -    #:
> -    l4_dport: int | None =3D field(
> -        default=3DNone,
> -        metadata=3DTextParser.find_int(r"Destination (?:TCP|UDP)
> port=3D(\d+)"),
> -    )
> -
> -
> -class RxOffloadCapability(Flag):
> -    """Rx offload capabilities of a device.
> -
> -    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> -    They're prefixed with ``RTE_ETH_RX_OFFLOAD`` in
> ``lib/ethdev/rte_ethdev.h``
> -    instead of ``RX_OFFLOAD``, which is what testpmd changes the prefix
> to.
> -    The values are not contiguous, so the correspondence is preserved
> -    by specifying concrete values interspersed between auto() values.
> -
> -    The ``RX_OFFLOAD`` prefix has been preserved so that the same flag
> names can be used
> -    in :class:`NicCapability`. The prefix is needed in
> :class:`NicCapability` since there's
> -    no other qualifier which would sufficiently distinguish it from othe=
r
> capabilities.
> -
> -    References:
> -        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> -        testpmd display function:
> ``app/test-pmd/cmdline.c:print_rx_offloads()``
> -    """
> -
> -    #:
> -    RX_OFFLOAD_VLAN_STRIP =3D auto()
> -    #: Device supports L3 checksum offload.
> -    RX_OFFLOAD_IPV4_CKSUM =3D auto()
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_UDP_CKSUM =3D auto()
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_TCP_CKSUM =3D auto()
> -    #: Device supports Large Receive Offload.
> -    RX_OFFLOAD_TCP_LRO =3D auto()
> -    #: Device supports QinQ (queue in queue) offload.
> -    RX_OFFLOAD_QINQ_STRIP =3D auto()
> -    #: Device supports inner packet L3 checksum.
> -    RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()
> -    #: Device supports MACsec.
> -    RX_OFFLOAD_MACSEC_STRIP =3D auto()
> -    #: Device supports filtering of a VLAN Tag identifier.
> -    RX_OFFLOAD_VLAN_FILTER =3D 1 << 9
> -    #: Device supports VLAN offload.
> -    RX_OFFLOAD_VLAN_EXTEND =3D auto()
> -    #: Device supports receiving segmented mbufs.
> -    RX_OFFLOAD_SCATTER =3D 1 << 13
> -    #: Device supports Timestamp.
> -    RX_OFFLOAD_TIMESTAMP =3D auto()
> -    #: Device supports crypto processing while packet is received in NIC=
.
> -    RX_OFFLOAD_SECURITY =3D auto()
> -    #: Device supports CRC stripping.
> -    RX_OFFLOAD_KEEP_CRC =3D auto()
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_SCTP_CKSUM =3D auto()
> -    #: Device supports inner packet L4 checksum.
> -    RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()
> -    #: Device supports RSS hashing.
> -    RX_OFFLOAD_RSS_HASH =3D auto()
> -    #: Device supports
> -    RX_OFFLOAD_BUFFER_SPLIT =3D auto()
> -    #: Device supports all checksum capabilities.
> -    RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM=
 |
> RX_OFFLOAD_TCP_CKSUM
> -    #: Device supports all VLAN capabilities.
> -    RX_OFFLOAD_VLAN =3D (
> -        RX_OFFLOAD_VLAN_STRIP
> -        | RX_OFFLOAD_VLAN_FILTER
> -        | RX_OFFLOAD_VLAN_EXTEND
> -        | RX_OFFLOAD_QINQ_STRIP
> -    )
> -
> -    @classmethod
> -    def from_string(cls, line: str) -> Self:
> -        """Make an instance from a string containing the flag names
> separated with a space.
> -
> -        Args:
> -            line: The line to parse.
> -
> -        Returns:
> -            A new instance containing all found flags.
> -        """
> -        flag =3D cls(0)
> -        for flag_name in line.split():
> -            flag |=3D cls[f"RX_OFFLOAD_{flag_name}"]
> -        return flag
> -
> -    @classmethod
> -    def make_parser(cls, per_port: bool) -> ParserFn:
> -        """Make a parser function.
> -
> -        Args:
> -            per_port: If :data:`True`, will return capabilities per port=
.
> If :data:`False`,
> -                will return capabilities per queue.
> -
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
> -
> -
> -@dataclass
> -class RxOffloadCapabilities(TextParser):
> -    """The result of testpmd's ``show port <port_id> rx_offload
> capabilities`` command.
> -
> -    References:
> -        testpmd command function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
> -        testpmd display function:
> ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
> -    """
> -
> -    #:
> -    port_id: int =3D field(
> -        metadata=3DTextParser.find_int(r"Rx Offloading Capabilities of p=
ort
> (\d+) :")
> -    )
> -    #: Per-queue Rx offload capabilities.
> -    per_queue: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(False))
> -    #: Capabilities other than per-queue Rx offload capabilities.
> -    per_port: RxOffloadCapability =3D
> field(metadata=3DRxOffloadCapability.make_parser(True))
> -
> -
> -@dataclass
> -class TestPmdPortFlowCtrl(TextParser):
> -    """Class representing a port's flow control parameters.
> -
> -    The parameters can also be parsed from the output of ``show port
> <port_id> flow_ctrl``.
> -    """
> -
> -    #: Enable Reactive Extensions.
> -    rx: bool =3D field(default=3DFalse, metadata=3DTextParser.find(r"Rx =
pause:
> on"))
> -    #: Enable Transmit.
> -    tx: bool =3D field(default=3DFalse, metadata=3DTextParser.find(r"Tx =
pause:
> on"))
> -    #: High threshold value to trigger XOFF.
> -    high_water: int =3D field(
> -        default=3D0, metadata=3DTextParser.find_int(r"High waterline:
> (0x[a-fA-F\d]+)")
> -    )
> -    #: Low threshold value to trigger XON.
> -    low_water: int =3D field(
> -        default=3D0, metadata=3DTextParser.find_int(r"Low waterline:
> (0x[a-fA-F\d]+)")
> -    )
> -    #: Pause quota in the Pause frame.
> -    pause_time: int =3D field(default=3D0,
> metadata=3DTextParser.find_int(r"Pause time: (0x[a-fA-F\d]+)"))
> -    #: Send XON frame.
> -    send_xon: bool =3D field(default=3DFalse, metadata=3DTextParser.find=
(r"Tx
> pause: on"))
> -    #: Enable receiving MAC control frames.
> -    mac_ctrl_frame_fwd: bool =3D field(default=3DFalse,
> metadata=3DTextParser.find(r"Tx pause: on"))
> -    #: Change the auto-negotiation parameter.
> -    autoneg: bool =3D field(default=3DFalse,
> metadata=3DTextParser.find(r"Autoneg: on"))
> -
> -    def __str__(self) -> str:
> -        """Returns the string representation of this instance."""
> -        ret =3D (
> -            f"rx {'on' if self.rx else 'off'} "
> -            f"tx {'on' if self.tx else 'off'} "
> -            f"{self.high_water} "
> -            f"{self.low_water} "
> -            f"{self.pause_time} "
> -            f"{1 if self.send_xon else 0} "
> -            f"mac_ctrl_frame_fwd {'on' if self.mac_ctrl_frame_fwd else
> 'off'} "
> -            f"autoneg {'on' if self.autoneg else 'off'}"
> -        )
> -        return ret
> -
> -
> -def requires_stopped_ports(func: TestPmdShellMethod) ->
> TestPmdShellMethod:
> -    """Decorator for :class:`TestPmdShell` commands methods that require
> stopped ports.
> -
> -    If the decorated method is called while the ports are started, then
> these are stopped before
> -    continuing.
> -
> -    Args:
> -        func: The :class:`TestPmdShell` method to decorate.
> -    """
> -
> -    @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
):
> -        if self.ports_started:
> -            self._logger.debug("Ports need to be stopped to continue.")
> -            self.stop_all_ports()
> -
> -        return func(self, *args, **kwargs)
> -
> -    return _wrapper
> -
> -
> -def requires_started_ports(func: TestPmdShellMethod) ->
> TestPmdShellMethod:
> -    """Decorator for :class:`TestPmdShell` commands methods that require
> started ports.
> -
> -    If the decorated method is called while the ports are stopped, then
> these are started before
> -    continuing.
> -
> -    Args:
> -        func: The :class:`TestPmdShell` method to decorate.
> -    """
> -
> -    @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
):
> -        if not self.ports_started:
> -            self._logger.debug("Ports need to be started to continue.")
> -            self.start_all_ports()
> -
> -        return func(self, *args, **kwargs)
> -
> -    return _wrapper
> -
> -
> -def add_remove_mtu(mtu: int =3D 1500) -> Callable[[TestPmdShellMethod],
> TestPmdShellMethod]:
> -    """Configure MTU to `mtu` on all ports, run the decorated function,
> then revert.
> -
> -    Args:
> -        mtu: The MTU to configure all ports on.
> -
> -    Returns:
> -        The method decorated with setting and reverting MTU.
> -    """
> -
> -    def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
> -        @functools.wraps(func)
> -        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs):
> -            original_mtu =3D self.ports[0].mtu
> -            self.set_port_mtu_all(mtu=3Dmtu, verify=3DFalse)
> -            retval =3D func(self, *args, **kwargs)
> -            self.set_port_mtu_all(original_mtu if original_mtu else 1500=
,
> verify=3DFalse)
> -            return retval
> -
> -        return wrapper
> -
> -    return decorator
> -
> -
> -class TestPmdShell(DPDKShell):
> -    """Testpmd interactive shell.
> -
> -    The testpmd shell users should never use
> -    the :meth:`~.interactive_shell.InteractiveShell.send_command` method
> directly, but rather
> -    call specialized methods. If there isn't one that satisfies a need,
> it should be added.
> -
> -    Attributes:
> -        ports_started: Indicates whether the ports are started.
> -    """
> -
> -    _app_params: TestPmdParams
> -    _ports: list[TestPmdPort] | None
> -
> -    #: The testpmd's prompt.
> -    _default_prompt: ClassVar[str] =3D "testpmd>"
> -
> -    #: This forces the prompt to appear after sending a command.
> -    _command_extra_chars: ClassVar[str] =3D "\n"
> -
> -    ports_started: bool
> -
> -    def __init__(
> -        self,
> -        name: str | None =3D None,
> -        privileged: bool =3D True,
> -        **app_params: Unpack[TestPmdParamsDict],
> -    ) -> None:
> -        """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes
> app_params to kwargs."""
> -        if "port_topology" not in app_params and get_ctx().topology.type
> is TopologyType.one_link:
> -            app_params["port_topology"] =3D PortTopology.loop
> -        super().__init__(name, privileged,
> app_params=3DTestPmdParams(**app_params))
> -        self.ports_started =3D not self._app_params.disable_device_start
> -        self._ports =3D None
> -
> -    @property
> -    def path(self) -> PurePath:
> -        """The path to the testpmd executable."""
> -        return PurePath("app/dpdk-testpmd")
> -
> -    @property
> -    def ports(self) -> list[TestPmdPort]:
> -        """The ports of the instance.
> -
> -        This caches the ports returned by :meth:`show_port_info_all`.
> -        To force an update of port information, execute
> :meth:`show_port_info_all` or
> -        :meth:`show_port_info`.
> -
> -        Returns: The list of known testpmd ports.
> -        """
> -        if self._ports is None:
> -            return self.show_port_info_all()
> -        return self._ports
> -
> -    @requires_started_ports
> -    def start(self, verify: bool =3D True) -> None:
> -        """Start packet forwarding with the current configuration.
> -
> -        Args:
> -            verify: If :data:`True` , a second start command will be sen=
t
> in an attempt to verify
> -                packet forwarding started as expected.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and forwarding fails to
> -                start or ports fail to come up.
> -        """
> -        self.send_command("start")
> -        if verify:
> -            # If forwarding was already started, sending "start" again
> should tell us
> -            start_cmd_output =3D self.send_command("start")
> -            if "Packet forwarding already started" not in
> start_cmd_output:
> -                self._logger.debug(f"Failed to start packet forwarding:
> \n{start_cmd_output}")
> -                raise InteractiveCommandExecutionError("Testpmd failed t=
o
> start packet forwarding.")
> -
> -    def stop(self, verify: bool =3D True) -> str:
> -        """Stop packet forwarding.
> -
> -        Args:
> -            verify: If :data:`True` , the output of the stop command is
> scanned to verify that
> -                forwarding was stopped successfully or not started. If
> neither is found, it is
> -                considered an error.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command to stop
> -                forwarding results in an error.
> -
> -        Returns:
> -            Output gathered from the stop command and all other precedin=
g
> logs in the buffer. This
> -            output is most often used to view forwarding statistics that
> are displayed when this
> -            command is sent as well as any verbose packet information
> that hasn't been consumed
> -            prior to calling this method.
> -        """
> -        stop_cmd_output =3D self.send_command("stop")
> -        if verify:
> -            if (
> -                "Done." not in stop_cmd_output
> -                and "Packet forwarding not started" not in stop_cmd_outp=
ut
> -            ):
> -                self._logger.debug(f"Failed to stop packet forwarding:
> \n{stop_cmd_output}")
> -                raise InteractiveCommandExecutionError("Testpmd failed t=
o
> stop packet forwarding.")
> -        return stop_cmd_output
> -
> -    def get_devices(self) -> list[TestPmdDevice]:
> -        """Get a list of device names that are known to testpmd.
> -
> -        Uses the device info listed in testpmd and then parses the outpu=
t.
> -
> -        Returns:
> -            A list of devices.
> -        """
> -        dev_info: str =3D self.send_command("show device info all")
> -        dev_list: list[TestPmdDevice] =3D []
> -        for line in dev_info.split("\n"):
> -            if "device name:" in line.lower():
> -                dev_list.append(TestPmdDevice(line))
> -        return dev_list
> -
> -    def wait_link_status_up(self, port_id: int, timeout=3DSETTINGS.timeo=
ut)
> -> bool:
> -        """Wait until the link status on the given port is "up".
> -
> -        Arguments:
> -            port_id: Port to check the link status on.
> -            timeout: Time to wait for the link to come up. The default
> value for this
> -                argument may be modified using the :option:`--timeout`
> command-line argument
> -                or the :envvar:`DTS_TIMEOUT` environment variable.
> -
> -        Returns:
> -            Whether the link came up in time or not.
> -        """
> -        time_to_stop =3D time.time() + timeout
> -        port_info: str =3D ""
> -        while time.time() < time_to_stop:
> -            port_info =3D self.send_command(f"show port info {port_id}")
> -            if "Link status: up" in port_info:
> -                break
> -            time.sleep(0.5)
> -        else:
> -            self._logger.error(f"The link for port {port_id} did not com=
e
> up in the given timeout.")
> -        return "Link status: up" in port_info
> -
> -    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool
> =3D True):
> -        """Set packet forwarding mode.
> -
> -        Args:
> -            mode: The forwarding mode to use.
> -            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> -                verify that the forwarding mode was set to `mode`
> properly.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the forwarding mode
> -                fails to update.
> -        """
> -        set_fwd_output =3D self.send_command(f"set fwd {mode.value}")
> -        if verify:
> -            if f"Set {mode.value} packet forwarding mode" not in
> set_fwd_output:
> -                self._logger.debug(f"Failed to set fwd mode to
> {mode.value}:\n{set_fwd_output}")
> -                raise InteractiveCommandExecutionError(
> -                    f"Test pmd failed to set fwd mode to {mode.value}"
> -                )
> -
> -    def stop_all_ports(self, verify: bool =3D True) -> None:
> -        """Stops all the ports.
> -
> -        Args:
> -            verify: If :data:`True`, the output of the command will be
> checked for a successful
> -                execution.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the ports were not
> -                stopped successfully.
> -        """
> -        self._logger.debug("Stopping all the ports...")
> -        output =3D self.send_command("port stop all")
> -        if verify and not output.strip().endswith("Done"):
> -            raise InteractiveCommandExecutionError("Ports were not
> stopped successfully.")
> -
> -        self.ports_started =3D False
> -
> -    def start_all_ports(self, verify: bool =3D True) -> None:
> -        """Starts all the ports.
> -
> -        Args:
> -            verify: If :data:`True`, the output of the command will be
> checked for a successful
> -                execution.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the ports were not
> -                started successfully.
> -        """
> -        self._logger.debug("Starting all the ports...")
> -        output =3D self.send_command("port start all")
> -        if verify and not output.strip().endswith("Done"):
> -            raise InteractiveCommandExecutionError("Ports were not
> started successfully.")
> -
> -        self.ports_started =3D True
> -
> -    @requires_stopped_ports
> -    def set_ports_queues(self, number_of: int) -> None:
> -        """Sets the number of queues per port.
> -
> -        Args:
> -            number_of: The number of RX/TX queues to create per port.
> -
> -        Raises:
> -            InternalError: If `number_of` is invalid.
> -        """
> -        if number_of < 1:
> -            raise InternalError("The number of queues must be positive
> and non-zero.")
> -
> -        self.send_command(f"port config all rxq {number_of}")
> -        self.send_command(f"port config all txq {number_of}")
> -
> -    @requires_stopped_ports
> -    def close_all_ports(self, verify: bool =3D True) -> None:
> -        """Close all ports.
> -
> -        Args:
> -            verify: If :data:`True` the output of the close command will
> be scanned in an attempt
> -                to verify that all ports were stopped successfully.
> Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and at lease one port
> -                failed to close.
> -        """
> -        port_close_output =3D self.send_command("port close all")
> -        if verify:
> -            num_ports =3D len(self.ports)
> -            if not all(f"Port {p_id} is closed" in port_close_output for
> p_id in range(num_ports)):
> -                raise InteractiveCommandExecutionError("Ports were not
> closed successfully.")
> -
> -    def show_port_info_all(self) -> list[TestPmdPort]:
> -        """Returns the information of all the ports.
> -
> -        Returns:
> -            list[TestPmdPort]: A list containing all the ports
> information as `TestPmdPort`.
> -        """
> -        output =3D self.send_command("show port info all")
> -
> -        # Sample output of the "all" command looks like:
> -        #
> -        # <start>
> -        #
> -        #   ********************* Infos for port 0 *********************
> -        #   Key: value
> -        #
> -        #   ********************* Infos for port 1 *********************
> -        #   Key: value
> -        # <end>
> -        #
> -        # Takes advantage of the double new line in between ports as end
> delimiter. But we need to
> -        # artificially add a new line at the end to pick up the last
> port. Because commands are
> -        # executed on a pseudo-terminal created by paramiko on the remot=
e
> node, lines end with CRLF.
> -        # Therefore we also need to take the carriage return into accoun=
t.
> -        iter =3D re.finditer(r"\*{21}.*?[\r\n]{4}", output + "\r\n", re.=
S)
> -        self._ports =3D [TestPmdPort.parse(block.group(0)) for block in
> iter]
> -        return self._ports
> -
> -    def show_port_info(self, port_id: int) -> TestPmdPort:
> -        """Returns the given port information.
> -
> -        Args:
> -            port_id: The port ID to gather information for.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `port_id` is invalid.
> -
> -        Returns:
> -            TestPmdPort: An instance of `TestPmdPort` containing the
> given port's information.
> -        """
> -        output =3D self.send_command(f"show port info {port_id}",
> skip_first_line=3DTrue)
> -        if output.startswith("Invalid port"):
> -            raise InteractiveCommandExecutionError("invalid port given")
> -
> -        port =3D TestPmdPort.parse(output)
> -        self._update_port(port)
> -        return port
> -
> -    def _update_port(self, port: TestPmdPort) -> None:
> -        if self._ports:
> -            self._ports =3D [
> -                existing_port if port.id !=3D existing_port.id else port
> -                for existing_port in self._ports
> -            ]
> -
> -    def set_mac_addr(self, port_id: int, mac_address: str, add: bool,
> verify: bool =3D True) -> None:
> -        """Add or remove a mac address on a given port's Allowlist.
> -
> -        Args:
> -            port_id: The port ID the mac address is set on.
> -            mac_address: The mac address to be added to or removed from
> the specified port.
> -            add: If :data:`True`, add the specified mac address. If
> :data:`False`, remove specified
> -                mac address.
> -            verify: If :data:'True', assert that the 'mac_addr' operatio=
n
> was successful. If
> -                :data:'False', run the command and skip this assertion.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If the set mac address
> operation fails.
> -        """
> -        mac_cmd =3D "add" if add else "remove"
> -        output =3D self.send_command(f"mac_addr {mac_cmd} {port_id}
> {mac_address}")
> -        if "Bad arguments" in output:
> -            self._logger.debug("Invalid argument provided to mac_addr")
> -            raise InteractiveCommandExecutionError("Invalid argument
> provided")
> -
> -        if verify:
> -            if "mac_addr_cmd error:" in output:
> -                self._logger.debug(f"Failed to {mac_cmd} {mac_address} o=
n
> port {port_id}")
> -                raise InteractiveCommandExecutionError(
> -                    f"Failed to {mac_cmd} {mac_address} on port {port_id=
}
> \n{output}"
> -                )
> -
> -    def set_multicast_mac_addr(
> -        self, port_id: int, multi_addr: str, add: bool, verify: bool =3D
> True
> -    ) -> None:
> -        """Add or remove multicast mac address to a specified port's
> allow list.
> -
> -        Args:
> -            port_id: The port ID the multicast address is set on.
> -            multi_addr: The multicast address to be added or removed fro=
m
> the filter.
> -            add: If :data:'True', add the specified multicast address to
> the port filter.
> -                If :data:'False', remove the specified multicast address
> from the port filter.
> -            verify: If :data:'True', assert that the 'mcast_addr'
> operations was successful.
> -                If :data:'False', execute the 'mcast_addr' operation and
> skip the assertion.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If either the 'add' or
> 'remove' operations fails.
> -        """
> -        mcast_cmd =3D "add" if add else "remove"
> -        output =3D self.send_command(f"mcast_addr {mcast_cmd} {port_id}
> {multi_addr}")
> -        if "Bad arguments" in output:
> -            self._logger.debug("Invalid arguments provided to mcast_addr=
")
> -            raise InteractiveCommandExecutionError("Invalid argument
> provided")
> -
> -        if verify:
> -            if (
> -                "Invalid multicast_addr" in output
> -                or f"multicast address {'already' if add else 'not'}
> filtered by port" in output
> -            ):
> -                self._logger.debug(f"Failed to {mcast_cmd} {multi_addr}
> on port {port_id}")
> -                raise InteractiveCommandExecutionError(
> -                    f"Failed to {mcast_cmd} {multi_addr} on port
> {port_id} \n{output}"
> -                )
> -
> -    def show_port_stats_all(self) -> Tuple[list[TestPmdPortStats], str]:
> -        """Returns the statistics of all the ports.
> -
> -        Returns:
> -            Tuple[str, list[TestPmdPortStats]]: A tuple where the first
> element is the stats of all
> -            ports as `TestPmdPortStats` and second is the raw testpmd
> output that was collected
> -            from the sent command.
> -        """
> -        output =3D self.send_command("show port stats all")
> -
> -        # Sample output of the "all" command looks like:
> -        #
> -        #   ########### NIC statistics for port 0 ###########
> -        #   values...
> -        #   #################################################
> -        #
> -        #   ########### NIC statistics for port 1 ###########
> -        #   values...
> -        #   #################################################
> -        #
> -        iter =3D re.finditer(r"(^  #*.+#*$[^#]+)^  #*\r$", output,
> re.MULTILINE)
> -        return ([TestPmdPortStats.parse(block.group(1)) for block in
> iter], output)
> -
> -    def show_port_stats(self, port_id: int) -> TestPmdPortStats:
> -        """Returns the given port statistics.
> -
> -        Args:
> -            port_id: The port ID to gather information for.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `port_id` is invalid.
> -
> -        Returns:
> -            TestPmdPortStats: An instance of `TestPmdPortStats`
> containing the given port's stats.
> -        """
> -        output =3D self.send_command(f"show port stats {port_id}",
> skip_first_line=3DTrue)
> -        if output.startswith("Invalid port"):
> -            raise InteractiveCommandExecutionError("invalid port given")
> -
> -        return TestPmdPortStats.parse(output)
> -
> -    def set_multicast_all(self, on: bool, verify: bool =3D True) -> None=
:
> -        """Turns multicast mode on/off for the specified port.
> -
> -        Args:
> -            on: If :data:`True`, turns multicast mode on, otherwise turn=
s
> off.
> -            verify: If :data:`True` an additional command will be sent t=
o
> verify
> -                that multicast mode is properly set. Defaults to
> :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and multicast
> -                mode is not properly set.
> -        """
> -        multicast_cmd_output =3D self.send_command(f"set allmulti all {'=
on'
> if on else 'off'}")
> -        if verify:
> -            port_stats =3D self.show_port_info_all()
> -            if on ^ all(stats.is_allmulticast_mode_enabled for stats in
> port_stats):
> -                self._logger.debug(
> -                    f"Failed to set multicast mode on all ports.:
> \n{multicast_cmd_output}"
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    "Testpmd failed to set multicast mode on all ports."
> -                )
> -
> -    @requires_stopped_ports
> -    def csum_set_hw(
> -        self, layers: ChecksumOffloadOptions, port_id: int, verify: bool
> =3D True
> -    ) -> None:
> -        """Enables hardware checksum offloading on the specified layer.
> -
> -        Args:
> -            layers: The layer/layers that checksum offloading should be
> enabled on.
> -            port_id: The port number to enable checksum offloading on,
> should be within 0-32.
> -            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> -                verify that checksum offloading was enabled on the port.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If checksum offload is not
> enabled successfully.
> -        """
> -        for name, offload in ChecksumOffloadOptions.__members__.items():
> -            if offload in layers:
> -                name =3D name.replace("_", "-")
> -                csum_output =3D self.send_command(f"csum set {name} hw
> {port_id}")
> -                if verify:
> -                    if (
> -                        "Bad arguments" in csum_output
> -                        or f"Please stop port {port_id} first" in
> csum_output
> -                        or f"checksum offload is not supported by port
> {port_id}" in csum_output
> -                    ):
> -                        self._logger.debug(f"Csum set hw
> error:\n{csum_output}")
> -                        raise InteractiveCommandExecutionError(
> -                            f"Failed to set csum hw {name} mode on port
> {port_id}"
> -                        )
> -                success =3D False
> -                if f"{name} checksum offload is hw" in
> csum_output.lower():
> -                    success =3D True
> -                if not success and verify:
> -                    self._logger.debug(
> -                        f"Failed to set csum hw mode on port
> {port_id}:\n{csum_output}"
> -                    )
> -                    raise InteractiveCommandExecutionError(
> -                        f"""Failed to set csum hw mode on port
> -
>  {port_id}:\n{csum_output}"""
> -                    )
> -
> -    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
> -        """Creates a flow rule in the testpmd session.
> -
> -        This command is implicitly verified as needed to return the
> created flow rule id.
> -
> -        Args:
> -            flow_rule: :class:`FlowRule` object used for creating testpm=
d
> flow rule.
> -            port_id: Integer representing the port to use.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If flow rule is invalid.
> -
> -        Returns:
> -            Id of created flow rule.
> -        """
> -        flow_output =3D self.send_command(f"flow create {port_id}
> {flow_rule}")
> -        match =3D re.search(r"#(\d+)", flow_output)
> -        if match is not None:
> -            match_str =3D match.group(1)
> -            flow_id =3D int(match_str)
> -            return flow_id
> -        else:
> -            self._logger.debug(f"Failed to create flow
> rule:\n{flow_output}")
> -            raise InteractiveCommandExecutionError(f"Failed to create
> flow rule:\n{flow_output}")
> -
> -    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
> -        """Validates a flow rule in the testpmd session.
> -
> -        Args:
> -            flow_rule: :class:`FlowRule` object used for validating
> testpmd flow rule.
> -            port_id: Integer representing the port to use.
> -
> -        Returns:
> -            Boolean representing whether rule is valid or not.
> -        """
> -        flow_output =3D self.send_command(f"flow validate {port_id}
> {flow_rule}")
> -        if "Flow rule validated" in flow_output:
> -            return True
> -        return False
> -
> -    def flow_delete(self, flow_id: int, port_id: int, verify: bool =3D
> True) -> None:
> -        """Deletes the specified flow rule from the testpmd session.
> -
> -        Args:
> -            flow_id: ID of the flow to remove.
> -            port_id: Integer representing the port to use.
> -            verify: If :data:`True`, the output of the command is scanne=
d
> -                to ensure the flow rule was deleted successfully.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If flow rule is invalid.
> -        """
> -        flow_output =3D self.send_command(f"flow destroy {port_id} rule
> {flow_id}")
> -        if verify:
> -            if "destroyed" not in flow_output:
> -                self._logger.debug(f"Failed to delete flow
> rule:\n{flow_output}")
> -                raise InteractiveCommandExecutionError(
> -                    f"Failed to delete flow rule:\n{flow_output}"
> -                )
> -
> -    @requires_started_ports
> -    @requires_stopped_ports
> -    def set_port_mtu(self, port_id: int, mtu: int, verify: bool =3D True=
)
> -> None:
> -        """Change the MTU of a port using testpmd.
> -
> -        Some PMDs require that the port be stopped before changing the
> MTU, and it does no harm to
> -        stop the port before configuring in cases where it isn't
> required, so ports are stopped
> -        prior to changing their MTU. On the other hand, some PMDs requir=
e
> that the port had already
> -        been started once since testpmd startup. Therefore, ports are
> also started before stopping
> -        them to ensure this has happened.
> -
> -        Args:
> -            port_id: ID of the port to adjust the MTU on.
> -            mtu: Desired value for the MTU to be set to.
> -            verify: If `verify` is :data:`True` then the output will be
> scanned in an attempt to
> -                verify that the mtu was properly set on the port.
> Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the MTU was not
> -                properly updated on the port matching `port_id`.
> -        """
> -        set_mtu_output =3D self.send_command(f"port config mtu {port_id}
> {mtu}")
> -        if verify and (f"MTU: {mtu}" not in self.send_command(f"show por=
t
> info {port_id}")):
> -            self._logger.debug(
> -                f"Failed to set mtu to {mtu} on port {port_id}. Output
> was:\n{set_mtu_output}"
> -            )
> -            raise InteractiveCommandExecutionError(
> -                f"Test pmd failed to update mtu of port {port_id} to
> {mtu}"
> -            )
> -
> -    def set_port_mtu_all(self, mtu: int, verify: bool =3D True) -> None:
> -        """Change the MTU of all ports using testpmd.
> -
> -        Runs :meth:`set_port_mtu` for every port that testpmd is aware o=
f.
> -
> -        Args:
> -            mtu: Desired value for the MTU to be set to.
> -            verify: Whether to verify that setting the MTU on each port
> was successful or not.
> -                Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the MTU was not
> -                properly updated on at least one port.
> -        """
> -        for port in self.ports:
> -            self.set_port_mtu(port.id, mtu, verify)
> -
> -    @staticmethod
> -    def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket=
]:
> -        """Extract the verbose information present in given testpmd
> output.
> -
> -        This method extracts sections of verbose output that begin with
> the line
> -        "port X/queue Y: sent/received Z packets" and end with the
> ol_flags of a packet.
> -
> -        Args:
> -            output: Testpmd output that contains verbose information
> -
> -        Returns:
> -            List of parsed packet information gathered from verbose
> information in `output`.
> -        """
> -        out: list[TestPmdVerbosePacket] =3D []
> -        prev_header: str =3D ""
> -        iter =3D re.finditer(
> -            r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+
> packets)?)\s*"
> -            r"(?P<PACKET>src=3D[\w\s=3D:-]+?ol_flags: [\w ]+)",
> -            output,
> -        )
> -        for match in iter:
> -            if match.group("HEADER"):
> -                prev_header =3D match.group("HEADER")
> -
> out.append(TestPmdVerbosePacket.parse(f"{prev_header}\n{match.group('PACK=
ET')}"))
> -        return out
> -
> -    @requires_stopped_ports
> -    def set_vlan_filter(self, port: int, enable: bool, verify: bool =3D
> True) -> None:
> -        """Set vlan filter on.
> -
> -        Args:
> -            port: The port number to enable VLAN filter on.
> -            enable: Enable the filter on `port` if :data:`True`,
> otherwise disable it.
> -            verify: If :data:`True`, the output of the command and show
> port info
> -                is scanned to verify that vlan filtering was set
> successfully.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the filter
> -                fails to update.
> -        """
> -        filter_cmd_output =3D self.send_command(f"vlan set filter {'on' =
if
> enable else 'off'} {port}")
> -        if verify:
> -            vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
> -            if enable ^ (vlan_settings is not None and
> VLANOffloadFlag.FILTER in vlan_settings):
> -                self._logger.debug(
> -                    f"""Failed to {"enable" if enable else "disable"}
> -                                   filter on port {port}:
> \n{filter_cmd_output}"""
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"""Failed to {"enable" if enable else "disable"}
> -                    filter on port {port}"""
> -                )
> -
> -    def set_mac_address(self, port: int, mac_address: str, verify: bool =
=3D
> True) -> None:
> -        """Set port's MAC address.
> -
> -        Args:
> -            port: The number of the requested port.
> -            mac_address: The MAC address to set.
> -            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> -                the mac address is set in the specified port.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command
> -                fails to execute.
> -        """
> -        output =3D self.send_command(f"mac_addr set {port} {mac_address}=
",
> skip_first_line=3DTrue)
> -        if verify:
> -            if output.strip():
> -                self._logger.debug(
> -                    f"Testpmd failed to set MAC address {mac_address} on
> port {port}."
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to set MAC address {mac_address} on
> port {port}."
> -                )
> -
> -    def set_flow_control(
> -        self, port: int, flow_ctrl: TestPmdPortFlowCtrl, verify: bool =
=3D
> True
> -    ) -> None:
> -        """Set the given `port`'s flow control.
> -
> -        Args:
> -            port: The number of the requested port.
> -            flow_ctrl: The requested flow control parameters.
> -            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> -                the flow control in the specified port is set.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the command
> -                fails to execute.
> -        """
> -        output =3D self.send_command(f"set flow_ctrl {flow_ctrl} {port}"=
,
> skip_first_line=3DTrue)
> -        if verify:
> -            if output.strip():
> -                self._logger.debug(f"Testpmd failed to set the
> {flow_ctrl} in port {port}.")
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to set the {flow_ctrl} in port
> {port}."
> -                )
> -
> -    def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl |
> None:
> -        """Show port info flow.
> -
> -        Args:
> -            port: The number of the requested port.
> -
> -        Returns:
> -            The current port flow control parameters if supported,
> otherwise :data:`None`.
> -        """
> -        output =3D self.send_command(f"show port {port} flow_ctrl")
> -        if "Flow control infos" in output:
> -            return TestPmdPortFlowCtrl.parse(output)
> -        return None
> -
> -    @requires_stopped_ports
> -    def rx_vlan(self, vlan: int, port: int, add: bool, verify: bool =3D
> True) -> None:
> -        """Add specified vlan tag to the filter list on a port. Requires
> vlan filter to be on.
> -
> -        Args:
> -            vlan: The vlan tag to add, should be within 1-1005.
> -            port: The port number to add the tag on.
> -            add: Adds the tag if :data:`True`, otherwise removes the tag=
.
> -            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> -                the vlan tag was added to the filter list on the
> specified port.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the tag
> -                is not added.
> -        """
> -        rx_cmd_output =3D self.send_command(f"rx_vlan {'add' if add else
> 'rm'} {vlan} {port}")
> -        if verify:
> -            if (
> -                "VLAN-filtering disabled" in rx_cmd_output
> -                or "Invalid vlan_id" in rx_cmd_output
> -                or "Bad arguments" in rx_cmd_output
> -            ):
> -                self._logger.debug(
> -                    f"""Failed to {"add" if add else "remove"} tag {vlan=
}
> -                    port {port}: \n{rx_cmd_output}"""
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to {'add' if add else 'remove'} tag
> {vlan} on port {port}."
> -                )
> -
> -    @requires_stopped_ports
> -    def set_vlan_strip(self, port: int, enable: bool, verify: bool =3D
> True) -> None:
> -        """Enable or disable vlan stripping on the specified port.
> -
> -        Args:
> -            port: The port number to use.
> -            enable: If :data:`True`, will turn vlan stripping on,
> otherwise will turn off.
> -            verify: If :data:`True`, the output of the command and show
> port info
> -                is scanned to verify that vlan stripping was enabled on
> the specified port.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and stripping
> -                fails to update.
> -        """
> -        strip_cmd_output =3D self.send_command(f"vlan set strip {'on' if
> enable else 'off'} {port}")
> -        if verify:
> -            vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
> -            if enable ^ (vlan_settings is not None and
> VLANOffloadFlag.STRIP in vlan_settings):
> -                self._logger.debug(
> -                    f"""Failed to set strip {"on" if enable else "off"}
> -                    port {port}: \n{strip_cmd_output}"""
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to set strip {'on' if enable else
> 'off'} port {port}."
> -                )
> -
> -    @requires_stopped_ports
> -    def tx_vlan_set(
> -        self, port: int, enable: bool, vlan: int | None =3D None, verify=
:
> bool =3D True
> -    ) -> None:
> -        """Set hardware insertion of vlan tags in packets sent on a port=
.
> -
> -        Args:
> -            port: The port number to use.
> -            enable: Sets vlan tag insertion if :data:`True`, and resets
> if :data:`False`.
> -            vlan: The vlan tag to insert if enable is :data:`True`.
> -            verify: If :data:`True`, the output of the command is scanne=
d
> to verify that
> -                vlan insertion was enabled on the specified port.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the insertion
> -                tag is not set.
> -        """
> -        if enable:
> -            tx_vlan_cmd_output =3D self.send_command(f"tx_vlan set {port=
}
> {vlan}")
> -            if verify:
> -                if (
> -                    "Please stop port" in tx_vlan_cmd_output
> -                    or "Invalid vlan_id" in tx_vlan_cmd_output
> -                    or "Invalid port" in tx_vlan_cmd_output
> -                ):
> -                    self._logger.debug(
> -                        f"Failed to set vlan tag {vlan} on port
> {port}:\n{tx_vlan_cmd_output}"
> -                    )
> -                    raise InteractiveCommandExecutionError(
> -                        f"Testpmd failed to set vlan insertion tag {vlan=
}
> on port {port}."
> -                    )
> -        else:
> -            tx_vlan_cmd_output =3D self.send_command(f"tx_vlan reset
> {port}")
> -            if verify:
> -                if "Please stop port" in tx_vlan_cmd_output or "Invalid
> port" in tx_vlan_cmd_output:
> -                    self._logger.debug(
> -                        f"Failed to reset vlan insertion on port {port}:
> \n{tx_vlan_cmd_output}"
> -                    )
> -                    raise InteractiveCommandExecutionError(
> -                        f"Testpmd failed to reset vlan insertion on port
> {port}."
> -                    )
> -
> -    def set_promisc(self, port: int, enable: bool, verify: bool =3D True=
)
> -> None:
> -        """Enable or disable promiscuous mode for the specified port.
> -
> -        Args:
> -            port: Port number to use.
> -            enable: If :data:`True`, turn promiscuous mode on, otherwise
> turn off.
> -            verify: If :data:`True` an additional command will be sent t=
o
> verify that
> -                promiscuous mode is properly set. Defaults to
> :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and promiscuous mode
> -                is not correctly set.
> -        """
> -        promisc_cmd_output =3D self.send_command(f"set promisc {port} {'=
on'
> if enable else 'off'}")
> -        if verify:
> -            stats =3D self.show_port_info(port_id=3Dport)
> -            if enable ^ stats.is_promiscuous_mode_enabled:
> -                self._logger.debug(
> -                    f"Failed to set promiscuous mode on port {port}:
> \n{promisc_cmd_output}"
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to set promiscuous mode on port
> {port}."
> -                )
> -
> -    def set_verbose(self, level: int, verify: bool =3D True) -> None:
> -        """Set debug verbosity level.
> -
> -        Args:
> -            level: 0 - silent except for error
> -                1 - fully verbose except for Tx packets
> -                2 - fully verbose except for Rx packets
> -                >2 - fully verbose
> -            verify: If :data:`True` the command output will be scanned t=
o
> verify that verbose level
> -                is properly set. Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and verbose level
> -            is not correctly set.
> -        """
> -        verbose_cmd_output =3D self.send_command(f"set verbose {level}")
> -        if verify:
> -            if "Change verbose level" not in verbose_cmd_output:
> -                self._logger.debug(
> -                    f"Failed to set verbose level to {level}:
> \n{verbose_cmd_output}"
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Testpmd failed to set verbose level to {level}."
> -                )
> -
> -    def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify=
:
> bool =3D True) -> None:
> -        """Add or remove vxlan id to/from filter list.
> -
> -        Args:
> -            vxlan_id: VXLAN ID to add to port filter list.
> -            port_id: ID of the port to modify VXLAN filter of.
> -            enable: If :data:`True`, adds specified VXLAN ID, otherwise
> removes it.
> -            verify: If :data:`True`, the output of the command is checke=
d
> to verify
> -                the VXLAN ID was successfully added/removed from the por=
t.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and VXLAN ID
> -                is not successfully added or removed.
> -        """
> -        action =3D "add" if enable else "rm"
> -        vxlan_output =3D self.send_command(f"rx_vxlan_port {action}
> {vxlan_id} {port_id}")
> -        if verify:
> -            if "udp tunneling add error" in vxlan_output:
> -                self._logger.debug(f"Failed to set
> VXLAN:\n{vxlan_output}")
> -                raise InteractiveCommandExecutionError(f"Failed to set
> VXLAN:\n{vxlan_output}")
> -
> -    def clear_port_stats(self, port_id: int, verify: bool =3D True) -> N=
one:
> -        """Clear statistics of a given port.
> -
> -        Args:
> -            port_id: ID of the port to clear the statistics on.
> -            verify: If :data:`True` the output of the command will be
> scanned to verify that it was
> -                successful, otherwise failures will be ignored. Defaults
> to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and testpmd fails to
> -                clear the statistics of the given port.
> -        """
> -        clear_output =3D self.send_command(f"clear port stats {port_id}"=
)
> -        if verify and f"NIC statistics for port {port_id} cleared" not i=
n
> clear_output:
> -            raise InteractiveCommandExecutionError(
> -                f"Test pmd failed to set clear forwarding stats on port
> {port_id}"
> -            )
> -
> -    def clear_port_stats_all(self, verify: bool =3D True) -> None:
> -        """Clear the statistics of all ports that testpmd is aware of.
> -
> -        Args:
> -            verify: If :data:`True` the output of the command will be
> scanned to verify that all
> -                ports had their statistics cleared, otherwise failures
> will be ignored. Defaults to
> -                :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and testpmd fails to
> -                clear the statistics of any of its ports.
> -        """
> -        clear_output =3D self.send_command("clear port stats all")
> -        if verify:
> -            if type(self._app_params.port_numa_config) is list:
> -                for port_id in
> range(len(self._app_params.port_numa_config)):
> -                    if f"NIC statistics for port {port_id} cleared" not
> in clear_output:
> -                        raise InteractiveCommandExecutionError(
> -                            f"Test pmd failed to set clear forwarding
> stats on port {port_id}"
> -                        )
> -
> -    @only_active
> -    def close(self) -> None:
> -        """Overrides :meth:`~.interactive_shell.close`."""
> -        self.stop()
> -        self.send_command("quit", "Bye...")
> -        return super().close()
> -
> -    """
> -    =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=3D=3D
> -    """
> -
> -    def get_capabilities_rx_offload(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get all rx offload capabilities and divide them into supporte=
d
> and unsupported.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        self._logger.debug("Getting rx offload capabilities.")
> -        command =3D f"show port {self.ports[0].id} rx_offload capabiliti=
es"
> -        rx_offload_capabilities_out =3D self.send_command(command)
> -        rx_offload_capabilities =3D
> RxOffloadCapabilities.parse(rx_offload_capabilities_out)
> -        self._update_capabilities_from_flag(
> -            supported_capabilities,
> -            unsupported_capabilities,
> -            RxOffloadCapability,
> -            rx_offload_capabilities.per_port |
> rx_offload_capabilities.per_queue,
> -        )
> -
> -    def get_port_queue_info(
> -        self, port_id: int, queue_id: int, is_rx_queue: bool
> -    ) -> TestPmdQueueInfo:
> -        """Returns the current state of the specified queue."""
> -        command =3D f"show {'rxq' if is_rx_queue else 'txq'} info {port_=
id}
> {queue_id}"
> -        queue_info =3D TestPmdQueueInfo.parse(self.send_command(command)=
)
> -        return queue_info
> -
> -    def setup_port_queue(self, port_id: int, queue_id: int, is_rx_queue:
> bool) -> None:
> -        """Setup a given queue on a port.
> -
> -        This functionality cannot be verified because the setup action
> only takes effect when the
> -        queue is started.
> -
> -        Args:
> -            port_id: ID of the port where the queue resides.
> -            queue_id: ID of the queue to setup.
> -            is_rx_queue: Type of queue to setup. If :data:`True` an RX
> queue will be setup,
> -                otherwise a TX queue will be setup.
> -        """
> -        self.send_command(f"port {port_id} {'rxq' if is_rx_queue else
> 'txq'} {queue_id} setup")
> -
> -    def stop_port_queue(
> -        self, port_id: int, queue_id: int, is_rx_queue: bool, verify:
> bool =3D True
> -    ) -> None:
> -        """Stops a given queue on a port.
> -
> -        Args:
> -            port_id: ID of the port that the queue belongs to.
> -            queue_id: ID of the queue to stop.
> -            is_rx_queue: Type of queue to stop. If :data:`True` an RX
> queue will be stopped,
> -                otherwise a TX queue will be stopped.
> -            verify: If :data:`True` an additional command will be sent t=
o
> verify the queue stopped.
> -                Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the queue fails to
> -                stop.
> -        """
> -        port_type =3D "rxq" if is_rx_queue else "txq"
> -        stop_cmd_output =3D self.send_command(f"port {port_id} {port_typ=
e}
> {queue_id} stop")
> -        if verify:
> -            queue_started =3D self.get_port_queue_info(
> -                port_id, queue_id, is_rx_queue
> -            ).is_queue_started
> -            if queue_started:
> -                self._logger.debug(
> -                    f"Failed to stop {port_type} {queue_id} on port
> {port_id}:\n{stop_cmd_output}"
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Test pmd failed to stop {port_type} {queue_id} on
> port {port_id}"
> -                )
> -
> -    def start_port_queue(
> -        self, port_id: int, queue_id: int, is_rx_queue: bool, verify:
> bool =3D True
> -    ) -> None:
> -        """Starts a given queue on a port.
> -
> -        First sets up the port queue, then starts it.
> -
> -        Args:
> -            port_id: ID of the port that the queue belongs to.
> -            queue_id: ID of the queue to start.
> -            is_rx_queue: Type of queue to start. If :data:`True` an RX
> queue will be started,
> -                otherwise a TX queue will be started.
> -            verify: if :data:`True` an additional command will be sent t=
o
> verify that the queue was
> -                started. Defaults to :data:`True`.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and the queue fails to
> -                start.
> -        """
> -        port_type =3D "rxq" if is_rx_queue else "txq"
> -        self.setup_port_queue(port_id, queue_id, is_rx_queue)
> -        start_cmd_output =3D self.send_command(f"port {port_id} {port_ty=
pe}
> {queue_id} start")
> -        if verify:
> -            queue_started =3D self.get_port_queue_info(
> -                port_id, queue_id, is_rx_queue
> -            ).is_queue_started
> -            if not queue_started:
> -                self._logger.debug(
> -                    f"Failed to start {port_type} {queue_id} on port
> {port_id}:\n{start_cmd_output}"
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Test pmd failed to start {port_type} {queue_id} on
> port {port_id}"
> -                )
> -
> -    def get_queue_ring_size(self, port_id: int, queue_id: int,
> is_rx_queue: bool) -> int:
> -        """Returns the current size of the ring on the specified queue."=
""
> -        command =3D f"show {'rxq' if is_rx_queue else 'txq'} info {port_=
id}
> {queue_id}"
> -        queue_info =3D TestPmdQueueInfo.parse(self.send_command(command)=
)
> -        return queue_info.ring_size
> -
> -    def set_queue_ring_size(
> -        self,
> -        port_id: int,
> -        queue_id: int,
> -        size: int,
> -        is_rx_queue: bool,
> -        verify: bool =3D True,
> -    ) -> None:
> -        """Update the ring size of an Rx/Tx queue on a given port.
> -
> -        Queue is setup after setting the ring size so that the queue inf=
o
> reflects this change and
> -        it can be verified.
> -
> -        Args:
> -            port_id: The port that the queue resides on.
> -            queue_id: The ID of the queue on the port.
> -            size: The size to update the ring size to.
> -            is_rx_queue: Whether to modify an RX or TX queue. If
> :data:`True` an RX queue will be
> -                updated, otherwise a TX queue will be updated.
> -            verify: If :data:`True` an additional command will be sent t=
o
> check the ring size of
> -                the queue in an attempt to validate that the size was
> changes properly.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> and there is a failure
> -                when updating ring size.
> -        """
> -        queue_type =3D "rxq" if is_rx_queue else "txq"
> -        self.send_command(f"port config {port_id} {queue_type} {queue_id=
}
> ring_size {size}")
> -        self.setup_port_queue(port_id, queue_id, is_rx_queue)
> -        if verify:
> -            curr_ring_size =3D self.get_queue_ring_size(port_id, queue_i=
d,
> is_rx_queue)
> -            if curr_ring_size !=3D size:
> -                self._logger.debug(
> -                    f"Failed up update ring size of queue {queue_id} on
> port {port_id}. Current"
> -                    f" ring size is {curr_ring_size}."
> -                )
> -                raise InteractiveCommandExecutionError(
> -                    f"Failed to update ring size of queue {queue_id} on
> port {port_id}"
> -                )
> -
> -    @requires_stopped_ports
> -    def set_queue_deferred_start(
> -        self, port_id: int, queue_id: int, is_rx_queue: bool, on: bool
> -    ) -> None:
> -        """Set the deferred start attribute of the specified queue on/of=
f.
> -
> -        Args:
> -            port_id: The port that the queue resides on.
> -            queue_id: The ID of the queue on the port.
> -            is_rx_queue: Whether to modify an RX or TX queue. If
> :data:`True` an RX queue will be
> -                updated, otherwise a TX queue will be updated.
> -            on: Whether to set deferred start mode on or off. If
> :data:`True` deferred start will
> -                be turned on, otherwise it will be turned off.
> -        """
> -        queue_type =3D "rxq" if is_rx_queue else "txq"
> -        action =3D "on" if on else "off"
> -        self.send_command(f"port {port_id} {queue_type} {queue_id}
> deferred_start {action}")
> -
> -    def _update_capabilities_from_flag(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -        flag_class: type[Flag],
> -        supported_flags: Flag,
> -    ) -> None:
> -        """Divide all flags from `flag_class` into supported and
> unsupported."""
> -        for flag in flag_class:
> -            if flag in supported_flags:
> -                supported_capabilities.add(NicCapability[str(flag.name)]=
)
> -            else:
> -                unsupported_capabilities.add(NicCapability[str(flag.name
> )])
> -
> -    @requires_started_ports
> -    def get_capabilities_rxq_info(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get all rxq capabilities and divide them into supported and
> unsupported.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        self._logger.debug("Getting rxq capabilities.")
> -        command =3D f"show rxq info {self.ports[0].id} 0"
> -        rxq_info =3D TestPmdRxqInfo.parse(self.send_command(command))
> -        if rxq_info.scattered_packets:
> -            supported_capabilities.add(NicCapability.SCATTERED_RX_ENABLE=
D)
> -        else:
> -
> unsupported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
> -
> -    def get_capabilities_show_port_info(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get all capabilities from show port info and divide them into
> supported and unsupported.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        self._update_capabilities_from_flag(
> -            supported_capabilities,
> -            unsupported_capabilities,
> -            DeviceCapabilitiesFlag,
> -            self.ports[0].device_capabilities,
> -        )
> -
> -    def get_capabilities_mcast_filtering(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get multicast filtering capability from mcast_addr add and
> check for testpmd error code.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        self._logger.debug("Getting mcast filter capabilities.")
> -        command =3D f"mcast_addr add {self.ports[0].id} 01:00:5E:00:00:0=
0"
> -        output =3D self.send_command(command)
> -        if "diag=3D-95" in output:
> -            unsupported_capabilities.add(NicCapability.MCAST_FILTERING)
> -        else:
> -            supported_capabilities.add(NicCapability.MCAST_FILTERING)
> -            command =3D str.replace(command, "add", "remove", 1)
> -            self.send_command(command)
> -
> -    def get_capabilities_flow_ctrl(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get flow control capability and check for testpmd failure.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        self._logger.debug("Getting flow ctrl capabilities.")
> -        command =3D f"show port {self.ports[0].id} flow_ctrl"
> -        output =3D self.send_command(command)
> -        if "Flow control infos" in output:
> -            supported_capabilities.add(NicCapability.FLOW_CTRL)
> -        else:
> -            unsupported_capabilities.add(NicCapability.FLOW_CTRL)
> -
> -    def get_capabilities_physical_function(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Store capability representing a physical function test run.
> -
> -        Args:
> -            supported_capabilities: Supported capabilities will be added
> to this set.
> -            unsupported_capabilities: Unsupported capabilities will be
> added to this set.
> -        """
> -        ctx =3D get_ctx()
> -        if ctx.topology.vf_ports =3D=3D []:
> -            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
> -        else:
> -            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
> -
> -
> -class NicCapability(NoAliasEnum):
> -    """A mapping between capability names and the associated
> :class:`TestPmdShell` methods.
> -
> -    The :class:`TestPmdShell` capability checking method executes the
> command that checks
> -    whether the capability is supported.
> -    A decorator may optionally be added to the method that will add and
> remove configuration
> -    that's necessary to retrieve the capability support status.
> -    The Enum members may be assigned the method itself or a tuple of
> -    (capability_checking_method, decorator_function).
> -
> -    The signature of each :class:`TestPmdShell` capability checking
> method must be::
> -
> -        fn(self, supported_capabilities: MutableSet,
> unsupported_capabilities: MutableSet) -> None
> -
> -    The capability checking method must get whether a capability is
> supported or not
> -    from a testpmd command. If multiple capabilities can be obtained fro=
m
> a testpmd command,
> -    each should be obtained in the method. These capabilities should the=
n
> -    be added to `supported_capabilities` or `unsupported_capabilities`
> based on their support.
> -
> -    The two dictionaries are shared across all capability discovery
> function calls in a given
> -    test run so that we don't call the same function multiple times. For
> example, when we find
> -    :attr:`SCATTERED_RX_ENABLED` in
> :meth:`TestPmdShell.get_capabilities_rxq_info`,
> -    we don't go looking for it again if a different test case also needs
> it.
> -    """
> -
> -    #: Scattered packets Rx enabled
> -    SCATTERED_RX_ENABLED: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rxq_info,
> -        add_remove_mtu(9000),
> -    )
> -    #:
> -    RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports L3 checksum offload.
> -    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports Large Receive Offload.
> -    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_rx_offload, None)
> -    #: Device supports QinQ (queue in queue) offload.
> -    RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports inner packet L3 checksum.
> -    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports MACsec.
> -    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports filtering of a VLAN Tag identifier.
> -    RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports VLAN offload.
> -    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports receiving segmented mbufs.
> -    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_rx_offload, None)
> -    #: Device supports Timestamp.
> -    RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports crypto processing while packet is received in NIC=
.
> -    RX_OFFLOAD_SECURITY: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports CRC stripping.
> -    RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports inner packet L4 checksum.
> -    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports RSS hashing.
> -    RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports scatter Rx packets to segmented mbufs.
> -    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports all checksum capabilities.
> -    RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_rx_offload,
> -        None,
> -    )
> -    #: Device supports all VLAN capabilities.
> -    RX_OFFLOAD_VLAN: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_rx_offload, None)
> -    #: Device supports Rx queue setup after device started.
> -    RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_show_port_info,
> -        None,
> -    )
> -    #: Device supports Tx queue setup after device started.
> -    RUNTIME_TX_QUEUE_SETUP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_show_port_info,
> -        None,
> -    )
> -    #: Device supports shared Rx queue among ports within Rx domain and
> switch domain.
> -    RXQ_SHARE: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_show_port_info, None)
> -    #: Device supports keeping flow rules across restart.
> -    FLOW_RULE_KEEP: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_show_port_info, None)
> -    #: Device supports keeping shared flow objects across restart.
> -    FLOW_SHARED_OBJECT_KEEP: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_show_port_info,
> -        None,
> -    )
> -    #: Device supports multicast address filtering.
> -    MCAST_FILTERING: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_mcast_filtering,
> -        None,
> -    )
> -    #: Device supports flow ctrl.
> -    FLOW_CTRL: TestPmdShellNicCapability =3D
> (TestPmdShell.get_capabilities_flow_ctrl, None)
> -    #: Device is running on a physical function.
> -    PHYSICAL_FUNCTION: TestPmdShellNicCapability =3D (
> -        TestPmdShell.get_capabilities_physical_function,
> -        None,
> -    )
> -
> -    def __call__(
> -        self,
> -        testpmd_shell: TestPmdShell,
> -        supported_capabilities: MutableSet[Self],
> -        unsupported_capabilities: MutableSet[Self],
> -    ) -> None:
> -        """Execute the associated capability retrieval function.
> -
> -        Args:
> -            testpmd_shell: :class:`TestPmdShell` object to which the
> function will be bound to.
> -            supported_capabilities: The dictionary storing the supported
> capabilities
> -                of a given test run.
> -            unsupported_capabilities: The dictionary storing the
> unsupported capabilities
> -                of a given test run.
> -        """
> -        self.value(testpmd_shell, supported_capabilities,
> unsupported_capabilities)
> diff --git a/dts/framework/testbed_model/capability.py
> b/dts/framework/testbed_model/capability.py
> index f895b22bb3..a4a8d9b7b4 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py
> @@ -26,9 +26,9 @@
>      .. code:: python
>
>          from framework.test_suite import TestSuite, func_test
> -        from framework.testbed_model.capability import TopologyType,
> requires
> +        from framework.testbed_model.capability import LinkTopology,
> requires
>          # The whole test suite (each test case within) doesn't require
> any links.
> -        @requires(topology_type=3DTopologyType.no_link)
> +        @requires_link_topology(LinkTopology.NO_LINK)
>          @func_test
>          class TestHelloWorld(TestSuite):
>              def hello_world_single_core(self):
> @@ -41,7 +41,7 @@ def hello_world_single_core(self):
>          class TestPmdBufferScatter(TestSuite):
>              # only the test case requires the SCATTERED_RX_ENABLED
> capability
>              # other test cases may not require it
> -            @requires(NicCapability.SCATTERED_RX_ENABLED)
> +            @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
>              @func_test
>              def test_scatter_mbuf_2048(self):
>  """
> @@ -50,27 +50,38 @@ def test_scatter_mbuf_2048(self):
>  from abc import ABC, abstractmethod
>  from collections.abc import MutableSet
>  from dataclasses import dataclass
> -from typing import TYPE_CHECKING, Callable, ClassVar, Protocol
> +from typing import (
> +    TYPE_CHECKING,
> +    Any,
> +    Callable,
> +    ClassVar,
> +    Concatenate,
> +    ParamSpec,
> +    Protocol,
> +    TypeAlias,
> +)
>
>  from typing_extensions import Self
>
> +from api.capabilities import LinkTopology, NicCapability
>  from framework.exception import ConfigurationError, InternalError,
> SkippedTestException
>  from framework.logger import get_dts_logger
> -from framework.remote_session.testpmd_shell import (
> -    NicCapability,
> -    TestPmdShell,
> -    TestPmdShellCapabilityMethod,
> -    TestPmdShellDecorator,
> -    TestPmdShellMethod,
> -)
>  from framework.testbed_model.node import Node
>  from framework.testbed_model.port import DriverKind
> -
> -from .topology import Topology, TopologyType
> +from framework.testbed_model.topology import Topology
>
>  if TYPE_CHECKING:
> +    from api.testpmd import TestPmd
>      from framework.test_suite import TestCase
>
> +P =3D ParamSpec("P")
> +TestPmdMethod =3D Callable[Concatenate["TestPmd", P], Any]
> +TestPmdCapabilityMethod: TypeAlias =3D Callable[
> +    ["TestPmd", MutableSet["NicCapability"],
> MutableSet["NicCapability"]], None
> +]
> +TestPmdDecorator: TypeAlias =3D Callable[[TestPmdMethod], TestPmdMethod]
> +TestPmdNicCapability =3D tuple[TestPmdCapabilityMethod, TestPmdDecorator=
 |
> None]
> +
>
>  class Capability(ABC):
>      """The base class for various capabilities.
> @@ -153,7 +164,7 @@ def __hash__(self) -> int:
>
>  @dataclass
>  class DecoratedNicCapability(Capability):
> -    """A wrapper around
> :class:`~framework.remote_session.testpmd_shell.NicCapability`.
> +    """A wrapper around :class:`~api.testpmd.NicCapability`.
>
>      New instances should be created with the :meth:`create_unique` class
> method to ensure
>      there are no duplicate instances.
> @@ -166,10 +177,69 @@ class DecoratedNicCapability(Capability):
>      """
>
>      nic_capability: NicCapability
> -    capability_fn: TestPmdShellCapabilityMethod
> -    capability_decorator: TestPmdShellDecorator | None
> +    capability_fn: TestPmdCapabilityMethod
> +    capability_decorator: TestPmdDecorator | None
>      _unique_capabilities: ClassVar[dict[NicCapability, Self]] =3D {}
>
> +    @classmethod
> +    def _get_nic_capability_check(cls) -> list[TestPmdNicCapability]:
> +        """A mapping between capability names and the associated
> :class:`TestPmd` methods.
> +
> +        The :class:`TestPmd` capability checking method executes the
> command that checks
> +        whether the capability is supported.
> +        A decorator may optionally be added to the method that will add
> and remove configuration
> +        that's necessary to retrieve the capability support status.
> +        The Enum members may be assigned the method itself or a tuple of
> +        (capability_checking_method, decorator_function).
> +
> +        The signature of each :class:`TestPmd` capability checking metho=
d
> must be::
> +
> +            fn(self, supported_capabilities: MutableSet,
> unsupported_capabilities: MutableSet)
> +
> +        The capability checking method must get whether a capability is
> supported or not
> +        from a testpmd command. If multiple capabilities can be obtained
> from a testpmd command,
> +        each should be obtained in the method. These capabilities should
> then
> +        be added to `supported_capabilities` or
> `unsupported_capabilities` based on their support.
> +
> +        The two dictionaries are shared across all capability discovery
> function calls in a given
> +        test run so that we don't call the same function multiple times.
> For example, when we find
> +        :attr:`SCATTERED_RX_ENABLED` in
> :meth:`TestPmd.get_capabilities_rxq_info`,
> +        we don't go looking for it again if a different test case also
> needs it.
> +        """
> +        from api.testpmd import TestPmd, _add_remove_mtu
> +
> +        return [
> +            (TestPmd.get_capabilities_rxq_info, _add_remove_mtu(9000)),
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_VLAN_STRIP
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_IPV4_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_UDP_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_TCP_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_TCP_LRO
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_QINQ_STRIP
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_OUTER_IPV4_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_MACSEC_STRIP
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_VLAN_FILTER
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_VLAN_EXTEND
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_SCATTER
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_TIMESTAMP
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_SECURITY
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_KEEP_CRC
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_SCTP_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_OUTER_UDP_CKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_RSS_HASH
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_BUFFER_SPLIT
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_CHECKSUM
> +            (TestPmd.get_capabilities_rx_offload, None),  #
> RX_OFFLOAD_VLAN
> +            (TestPmd.get_capabilities_show_port_info, None),  #
> RUNTIME_RX_QUEUE_SETUP
> +            (TestPmd.get_capabilities_show_port_info, None),  #
> RUNTIME_TX_QUEUE_SETUP
> +            (TestPmd.get_capabilities_show_port_info, None),  # RXQ_SHAR=
E
> +            (TestPmd.get_capabilities_show_port_info, None),  #
> FLOW_RULE_KEEP
> +            (TestPmd.get_capabilities_show_port_info, None),  #
> FLOW_SHARED_OBJECT_KEEP
> +            (TestPmd.get_capabilities_mcast_filtering, None),  #
> MCAST_FILTERING
> +            (TestPmd.get_capabilities_flow_ctrl, None),  # FLOW_CTRL
> +            (TestPmd.get_capabilities_physical_function, None),  #
> PHYSICAL_FUNCTION
> +        ]
> +
>      @classmethod
>      def get_unique(cls, nic_capability: NicCapability) -> Self:
>          """Get the capability uniquely identified by `nic_capability`.
> @@ -188,7 +258,7 @@ def get_unique(cls, nic_capability: NicCapability) ->
> Self:
>          Returns:
>              The capability uniquely identified by `nic_capability`.
>          """
> -        capability_fn, decorator_fn =3D nic_capability.value
> +        capability_fn, decorator_fn =3D
> cls._get_nic_capability_check()[nic_capability.value]
>
>          if nic_capability not in cls._unique_capabilities:
>              cls._unique_capabilities[nic_capability] =3D cls(
> @@ -207,9 +277,11 @@ def get_supported_capabilities(
>          Each capability is first checked whether it's
> supported/unsupported
>          before executing its `capability_fn` so that each capability is
> retrieved only once.
>          """
> +        from api.testpmd import TestPmd
> +
>          supported_conditional_capabilities: set["DecoratedNicCapability"=
]
> =3D set()
>          logger =3D get_dts_logger(f"{node.name}.{cls.__name__}")
> -        if topology.type is topology.type.no_link:
> +        if topology.type is topology.type.NO_LINK:
>              logger.debug(
>                  "No links available in the current topology, not getting
> NIC capabilities."
>              )
> @@ -219,7 +291,7 @@ def get_supported_capabilities(
>          )
>          if cls.capabilities_to_check:
>              capabilities_to_check_map =3D
> cls._get_decorated_capabilities_map()
> -            with TestPmdShell() as testpmd_shell:
> +            with TestPmd() as testpmd:
>                  for (
>                      conditional_capability_fn,
>                      capabilities,
> @@ -231,7 +303,7 @@ def get_supported_capabilities(
>                      )
>                      if conditional_capability_fn:
>                          capability_fn =3D
> conditional_capability_fn(capability_fn)
> -                    capability_fn(testpmd_shell)
> +                    capability_fn(testpmd)
>                      for capability in capabilities:
>                          if capability.nic_capability in
> supported_capabilities:
>
>  supported_conditional_capabilities.add(capability)
> @@ -242,8 +314,8 @@ def get_supported_capabilities(
>      @classmethod
>      def _get_decorated_capabilities_map(
>          cls,
> -    ) -> dict[TestPmdShellDecorator | None,
> set["DecoratedNicCapability"]]:
> -        capabilities_map: dict[TestPmdShellDecorator | None,
> set["DecoratedNicCapability"]] =3D {}
> +    ) -> dict[TestPmdDecorator | None, set["DecoratedNicCapability"]]:
> +        capabilities_map: dict[TestPmdDecorator | None,
> set["DecoratedNicCapability"]] =3D {}
>          for capability in cls.capabilities_to_check:
>              if capability.capability_decorator not in capabilities_map:
>                  capabilities_map[capability.capability_decorator] =3D se=
t()
> @@ -257,12 +329,12 @@ def _reduce_capabilities(
>          capabilities: set["DecoratedNicCapability"],
>          supported_capabilities: MutableSet,
>          unsupported_capabilities: MutableSet,
> -    ) -> TestPmdShellMethod:
> -        def reduced_fn(testpmd_shell: TestPmdShell) -> None:
> +    ) -> TestPmdMethod:
> +        def reduced_fn(testpmd: "TestPmd") -> None:
>              for capability in capabilities:
>                  if capability not in supported_capabilities |
> unsupported_capabilities:
>                      capability.capability_fn(
> -                        testpmd_shell, supported_capabilities,
> unsupported_capabilities
> +                        testpmd, supported_capabilities,
> unsupported_capabilities
>                      )
>
>          return reduced_fn
> @@ -278,11 +350,11 @@ def __repr__(self) -> str:
>
>  @dataclass
>  class TopologyCapability(Capability):
> -    """A wrapper around :class:`~.topology.TopologyType`.
> +    """A wrapper around :class:`~.topology.LinkTopology`.
>
>      Each test case must be assigned a topology. It could be done
> explicitly;
> -    the implicit default is given by
> :meth:`~.topology.TopologyType.default`, which this class
> -    returns :attr:`~.topology.TopologyType.two_links`.
> +    the implicit default is given by
> :meth:`~.topology.LinkTopology.default`, which this class
> +    returns :attr:`~.topology.LinkTopology.TWO_LINKS`.
>
>      Test case topology may be set by setting the topology for the whole
> suite.
>      The priority in which topology is set is as follows:
> @@ -301,7 +373,7 @@ class TopologyCapability(Capability):
>          topology_type: The topology type that defines each instance.
>      """
>
> -    topology_type: TopologyType
> +    topology_type: LinkTopology
>
>      _unique_capabilities: ClassVar[dict[str, Self]] =3D {}
>
> @@ -310,7 +382,7 @@ def _preprocess_required(self, test_case_or_suite:
> type["TestProtocol"]) -> None
>          test_case_or_suite.topology_type =3D self
>
>      @classmethod
> -    def get_unique(cls, topology_type: TopologyType) -> Self:
> +    def get_unique(cls, topology_type: LinkTopology) -> Self:
>          """Get the capability uniquely identified by `topology_type`.
>
>          This is a factory method that implements a quasi-enum pattern.
> @@ -338,7 +410,7 @@ def get_supported_capabilities(
>          """Overrides :meth:`~Capability.get_supported_capabilities`."""
>          supported_capabilities =3D set()
>          topology_capability =3D cls.get_unique(topology.type)
> -        for topology_type in TopologyType:
> +        for topology_type in LinkTopology:
>              candidate_topology_type =3D cls.get_unique(topology_type)
>              if candidate_topology_type <=3D topology_capability:
>                  supported_capabilities.add(candidate_topology_type)
> @@ -351,17 +423,17 @@ def set_required(self, test_case_or_suite:
> type["TestProtocol"]) -> None:
>          This means we have to modify test case topologies when processin=
g
> the test suite topologies.
>          At that point, the test case topologies have been set by the
> :func:`requires` decorator.
>          The test suite topology only affects the test case topologies
> -        if not :attr:`~.topology.TopologyType.default`.
> +        if not :attr:`~.topology.LinkTopology.default`.
>
>          Raises:
>              ConfigurationError: If the topology type requested by the
> test case is more complex than
>                  the test suite's.
>          """
>          if inspect.isclass(test_case_or_suite):
> -            if self.topology_type is not TopologyType.default():
> +            if self.topology_type is not LinkTopology.default():
>                  self.add_to_required(test_case_or_suite)
>                  for test_case in test_case_or_suite.get_test_cases():
> -                    if test_case.topology_type.topology_type is
> TopologyType.default():
> +                    if test_case.topology_type.topology_type is
> LinkTopology.default():
>                          # test case topology has not been set, use the
> one set by the test suite
>                          self.add_to_required(test_case)
>                      elif test_case.topology_type >
> test_case_or_suite.topology_type:
> @@ -440,7 +512,7 @@ class TestProtocol(Protocol):
>      #: The reason for skipping the test case or suite.
>      skip_reason: ClassVar[str] =3D ""
>      #: The topology type of the test case or suite.
> -    topology_type: ClassVar[TopologyCapability] =3D
> TopologyCapability(TopologyType.default())
> +    topology_type: ClassVar[TopologyCapability] =3D
> TopologyCapability(LinkTopology.default())
>      #: The capabilities the test case or suite requires in order to be
> executed.
>      required_capabilities: ClassVar[set[Capability]] =3D set()
>      #: The SUT ports topology configuration of the test case or suite.
> @@ -481,7 +553,7 @@ def _decorator(func: type[TestProtocol]) ->
> type[TestProtocol]:
>
>  def requires(
>      *nic_capabilities: NicCapability,
> -    topology_type: TopologyType =3D TopologyType.default(),
> +    topology_type: LinkTopology =3D LinkTopology.default(),
>  ) -> Callable[[type[TestProtocol]], type[TestProtocol]]:
>      """A decorator that adds the required capabilities to a test case or
> test suite.
>
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index 604245d855..1f11c3e740 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -22,7 +22,7 @@
>      InternalError,
>      RemoteCommandExecutionError,
>  )
> -from framework.testbed_model.os_session import PortInfo
> +from framework.testbed_model.port import PortInfo
>  from framework.utils import expand_range
>
>  from .cpu import LogicalCore
> diff --git a/dts/framework/testbed_model/os_session.py
> b/dts/framework/testbed_model/os_session.py
> index b6e03aa83d..c1872880da 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -31,13 +31,9 @@
>
>  from framework.config.node import NodeConfiguration
>  from framework.logger import DTSLogger
> -from framework.remote_session import (
> -    InteractiveRemoteSession,
> -    RemoteSession,
> -    create_interactive_session,
> -    create_remote_session,
> -)
> -from framework.remote_session.remote_session import CommandResult
> +from framework.remote_session.interactive_remote_session import
> InteractiveRemoteSession
> +from framework.remote_session.remote_session import CommandResult,
> RemoteSession
> +from framework.remote_session.ssh_session import SSHSession
>  from framework.settings import SETTINGS
>  from framework.utils import MesonArgs, TarCompressionFormat
>
> @@ -129,8 +125,8 @@ def __init__(
>          self._config =3D node_config
>          self.name =3D name
>          self._logger =3D logger
> -        self.remote_session =3D create_remote_session(node_config, name,
> logger)
> -        self.interactive_session =3D
> create_interactive_session(node_config, logger)
> +        self.remote_session =3D SSHSession(node_config, name, logger)
> +        self.interactive_session =3D InteractiveRemoteSession(node_confi=
g,
> logger)
>
>      def is_alive(self) -> bool:
>          """Check whether the underlying remote session is still
> responding."""
> diff --git a/dts/framework/testbed_model/topology.py
> b/dts/framework/testbed_model/topology.py
> index 899ea0ad3a..09303a1f08 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -11,33 +11,17 @@
>  from collections import defaultdict
>  from collections.abc import Iterator
>  from dataclasses import dataclass
> -from enum import Enum
>  from typing import Literal, NamedTuple
>
>  from typing_extensions import Self
>
> +from api.capabilities import LinkTopology
>  from framework.exception import ConfigurationError, InternalError
>  from framework.testbed_model.node import Node
>
>  from .port import DriverKind, Port, PortConfig
>
>
> -class TopologyType(int, Enum):
> -    """Supported topology types."""
> -
> -    #: A topology with no Traffic Generator.
> -    no_link =3D 0
> -    #: A topology with one physical link between the SUT node and the TG
> node.
> -    one_link =3D 1
> -    #: A topology with two physical links between the Sut node and the T=
G
> node.
> -    two_links =3D 2
> -
> -    @classmethod
> -    def default(cls) -> "TopologyType":
> -        """The default topology required by test cases if not specified
> otherwise."""
> -        return cls.two_links
> -
> -
>  class PortLink(NamedTuple):
>      """The physical, cabled connection between the ports."""
>
> @@ -71,7 +55,7 @@ class Topology:
>          tg_ports: The TG ports.
>      """
>
> -    type: TopologyType
> +    type: LinkTopology
>      sut_ports: list[Port]
>      tg_ports: list[Port]
>      pf_ports: list[Port]
> @@ -87,15 +71,15 @@ def from_port_links(cls, port_links:
> Iterator[PortLink]) -> Self:
>          Raises:
>              ConfigurationError: If an unsupported link topology is
> supplied.
>          """
> -        type =3D TopologyType.no_link
> +        type =3D LinkTopology.NO_LINK
>
>          if port_link :=3D next(port_links, None):
> -            type =3D TopologyType.one_link
> +            type =3D LinkTopology.ONE_LINK
>              sut_ports =3D [port_link.sut_port]
>              tg_ports =3D [port_link.tg_port]
>
>              if port_link :=3D next(port_links, None):
> -                type =3D TopologyType.two_links
> +                type =3D LinkTopology.TWO_LINKS
>                  sut_ports.append(port_link.sut_port)
>                  tg_ports.append(port_link.tg_port)
>
> @@ -268,9 +252,9 @@ def sut_port_ingress(self) -> Port:
>      @property
>      def sut_port_egress(self) -> Port:
>          """The egress port of the SUT node."""
> -        return self.sut_ports[1 if self.type is TopologyType.two_links
> else 0]
> +        return self.sut_ports[1 if self.type is LinkTopology.TWO_LINKS
> else 0]
>
>      @property
>      def tg_port_ingress(self) -> Port:
>          """The ingress port of the TG node."""
> -        return self.tg_ports[1 if self.type is TopologyType.two_links
> else 0]
> +        return self.tg_ports[1 if self.type is LinkTopology.TWO_LINKS
> else 0]
> --
> 2.39.5
>
>

--000000000000d23d9c063f2ccb36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This series has been=C2=A0applied to next-dts.=C2=A0<div><=
br></div><div>I am noting here that patchwork CI results shows a checkpatch=
es=C2=A0warning. However, I have run checkpatches=C2=A0on this patch and it=
&#39;s reporting no issues. My=C2=A0DPDK_CHECKPATCH_PATH and codespell dict=
ionary seem fine. So, I am confident enough that there is no issue to apply=
 to next-dts. Ali please let me know if you are concerned.</div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Aug 29, 2025 at 1:43=E2=80=AFPM Paul Szczepanek &lt;<a h=
ref=3D"mailto:paul.szczepanek@arm.com">paul.szczepanek@arm.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Testpmd moved=
 into new API directory.<br>
Capabilities converted into vanilla enum and moved to API.<br>
Removed some ciruclar dependencies and incorrect imports.<br>
<br>
Signed-off-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.co=
m" target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/api.capabilities.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 +<br>
=C2=A0doc/api/dts/api.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A020 +<br>
=C2=A0...stpmd_shell.rst =3D&gt; api.testpmd.config.rst} |=C2=A0 =C2=A0 4 +=
-<br>
=C2=A0doc/api/dts/api.testpmd.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A015 +<br>
=C2=A0doc/api/dts/api.testpmd.types.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +<br>
=C2=A0doc/api/dts/framework.params.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<br>
=C2=A0doc/api/dts/framework.params.testpmd.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 8 -<br>
=C2=A0doc/api/dts/framework.remote_session.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 -<br>
=C2=A0doc/api/dts/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0dts/api/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A014 +<br>
=C2=A0dts/api/capabilities.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 180 ++<br>
=C2=A0dts/api/testpmd/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1294 ++++++++<br>
=C2=A0.../testpmd.py =3D&gt; api/testpmd/config.py}=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 9 +-<br>
=C2=A0dts/api/testpmd/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1406 ++++++++<br>
=C2=A0dts/framework/config/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
=C2=A0dts/framework/params/eal.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A012 +-<br>
=C2=A0dts/framework/params/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +-<br>
=C2=A0dts/framework/remote_session/__init__.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A044 -<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 2844 ----------------=
-<br>
=C2=A0dts/framework/testbed_model/capability.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
144 +-<br>
=C2=A0dts/framework/testbed_model/linux_session.py=C2=A0 |=C2=A0 =C2=A0 2 +=
-<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A014 +-<br>
=C2=A0dts/framework/testbed_model/topology.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A030 +-<br>
=C2=A023 files changed, 3086 insertions(+), 2980 deletions(-)<br>
=C2=A0create mode 100644 doc/api/dts/api.capabilities.rst<br>
=C2=A0create mode 100644 doc/api/dts/api.rst<br>
=C2=A0rename doc/api/dts/{framework.remote_session.testpmd_shell.rst =3D&gt=
; api.testpmd.config.rst} (54%)<br>
=C2=A0create mode 100644 doc/api/dts/api.testpmd.rst<br>
=C2=A0create mode 100644 doc/api/dts/api.testpmd.types.rst<br>
=C2=A0delete mode 100644 doc/api/dts/framework.params.testpmd.rst<br>
=C2=A0create mode 100644 dts/api/__init__.py<br>
=C2=A0create mode 100644 dts/api/capabilities.py<br>
=C2=A0create mode 100644 dts/api/testpmd/__init__.py<br>
=C2=A0rename dts/{framework/params/testpmd.py =3D&gt; api/testpmd/config.py=
} (98%)<br>
=C2=A0create mode 100644 dts/api/testpmd/types.py<br>
=C2=A0delete mode 100644 dts/framework/remote_session/testpmd_shell.py<br>
<br>
diff --git a/doc/api/dts/api.capabilities.rst b/doc/api/dts/api.capabilitie=
s.rst<br>
new file mode 100644<br>
index 0000000000..311872f61d<br>
--- /dev/null<br>
+++ b/doc/api/dts/api.capabilities.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+capabilities - SUT Capabilities<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. automodule:: api.capabilities<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/doc/api/dts/api.rst b/doc/api/dts/api.rst<br>
new file mode 100644<br>
index 0000000000..d3cf1226eb<br>
--- /dev/null<br>
+++ b/doc/api/dts/api.rst<br>
@@ -0,0 +1,20 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+api - DTS API<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. automodule:: api<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
+<br>
+.. toctree::<br>
+=C2=A0 =C2=A0:hidden:<br>
+=C2=A0 =C2=A0:maxdepth: 2<br>
+<br>
+=C2=A0 =C2=A0api.testpmd<br>
+<br>
+.. toctree::<br>
+=C2=A0 =C2=A0:hidden:<br>
+=C2=A0 =C2=A0:maxdepth: 1<br>
+<br>
+=C2=A0 =C2=A0api.capabilities<br>
\ No newline at end of file<br>
diff --git a/doc/api/dts/framework.remote_session.testpmd_shell.rst b/doc/a=
pi/dts/api.testpmd.config.rst<br>
similarity index 54%<br>
rename from doc/api/dts/framework.remote_session.testpmd_shell.rst<br>
rename to doc/api/dts/api.testpmd.config.rst<br>
index 81ca23337f..d338c07a36 100644<br>
--- a/doc/api/dts/framework.remote_session.testpmd_shell.rst<br>
+++ b/doc/api/dts/api.testpmd.config.rst<br>
@@ -1,8 +1,8 @@<br>
=C2=A0.. SPDX-License-Identifier: BSD-3-Clause<br>
<br>
-testpmd\_shell - Testpmd Interactive Remote Shell<br>
+config - Testpmd configuration<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
<br>
-.. automodule:: framework.remote_session.testpmd_shell<br>
+.. automodule:: api.testpmd.config<br>
=C2=A0 =C2=A0 :members:<br>
=C2=A0 =C2=A0 :show-inheritance:<br>
diff --git a/doc/api/dts/api.testpmd.rst b/doc/api/dts/api.testpmd.rst<br>
new file mode 100644<br>
index 0000000000..75a92823f8<br>
--- /dev/null<br>
+++ b/doc/api/dts/api.testpmd.rst<br>
@@ -0,0 +1,15 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+testpmd - Testpmd Interactive Remote Shell<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
+<br>
+.. automodule:: api.testpmd<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
+<br>
+.. toctree::<br>
+=C2=A0 =C2=A0:hidden:<br>
+=C2=A0 =C2=A0:maxdepth: 1<br>
+<br>
+=C2=A0 =C2=A0api.testpmd.types<br>
+=C2=A0 =C2=A0api.testpmd.config<br>
\ No newline at end of file<br>
diff --git a/doc/api/dts/api.testpmd.types.rst b/doc/api/dts/api.testpmd.ty=
pes.rst<br>
new file mode 100644<br>
index 0000000000..75b197aa73<br>
--- /dev/null<br>
+++ b/doc/api/dts/api.testpmd.types.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+types - Testpmd types<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
+<br>
+.. automodule:: api.testpmd.types<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/doc/api/dts/framework.params.rst b/doc/api/dts/framework.param=
s.rst<br>
index 4e263e2e5c..d8c6af9667 100644<br>
--- a/doc/api/dts/framework.params.rst<br>
+++ b/doc/api/dts/framework.params.rst<br>
@@ -12,5 +12,4 @@ params - Command Line Parameters Modelling<br>
=C2=A0 =C2=A0 :maxdepth: 1<br>
<br>
=C2=A0 =C2=A0 framework.params.eal<br>
-=C2=A0 =C2=A0framework.params.testpmd<br>
=C2=A0 =C2=A0 framework.params.types<br>
diff --git a/doc/api/dts/framework.params.testpmd.rst b/doc/api/dts/framewo=
rk.params.testpmd.rst<br>
deleted file mode 100644<br>
index 19583b01de..0000000000<br>
--- a/doc/api/dts/framework.params.testpmd.rst<br>
+++ /dev/null<br>
@@ -1,8 +0,0 @@<br>
-.. SPDX-License-Identifier: BSD-3-Clause<br>
-<br>
-testpmd - TestPMD Parameters Modelling<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-.. automodule:: framework.params.testpmd<br>
-=C2=A0 =C2=A0:members:<br>
-=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/framewo=
rk.remote_session.rst<br>
index 27c9153e64..b7dbe71412 100644<br>
--- a/doc/api/dts/framework.remote_session.rst<br>
+++ b/doc/api/dts/framework.remote_session.rst<br>
@@ -18,5 +18,4 @@ remote\_session - Node Connections Package<br>
=C2=A0 =C2=A0 framework.remote_session.shell_pool<br>
=C2=A0 =C2=A0 framework.remote_session.dpdk<br>
=C2=A0 =C2=A0 framework.remote_session.dpdk_shell<br>
-=C2=A0 =C2=A0framework.remote_session.testpmd_shell<br>
=C2=A0 =C2=A0 framework.remote_session.python_shell<br>
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst<br>
index a11f395e11..c719297c11 100644<br>
--- a/doc/api/dts/index.rst<br>
+++ b/doc/api/dts/index.rst<br>
@@ -15,6 +15,7 @@ Packages<br>
=C2=A0 =C2=A0 :maxdepth: 1<br>
<br>
=C2=A0 =C2=A0 tests<br>
+=C2=A0 =C2=A0api<br>
=C2=A0 =C2=A0 framework.testbed_model<br>
=C2=A0 =C2=A0 framework.remote_session<br>
=C2=A0 =C2=A0 framework.params<br>
diff --git a/dts/api/__init__.py b/dts/api/__init__.py<br>
new file mode 100644<br>
index 0000000000..26b773bfbb<br>
--- /dev/null<br>
+++ b/dts/api/__init__.py<br>
@@ -0,0 +1,14 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;DTS API.<br>
+<br>
+This package exposes public API modules for test writers.<br>
+<br>
+All modules in this package are considered stable. Do not use framework<br=
>
+internal modules in your tests. Any missing functionality should be added<=
br>
+to the public API.<br>
+<br>
+Private methods and members are prefixed with an underscore and should not=
 be<br>
+used outside of the framework.<br>
+&quot;&quot;&quot;<br>
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py<br>
new file mode 100644<br>
index 0000000000..1a79413f6f<br>
--- /dev/null<br>
+++ b/dts/api/capabilities.py<br>
@@ -0,0 +1,180 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2024 PANTHEON.tech s.r.o.<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;Testbed capabilities.<br>
+<br>
+This module provides a protocol that defines the common attributes of test=
 cases and suites<br>
+and support for test environment capabilities.<br>
+<br>
+Many test cases are testing features not available on all hardware.<br>
+On the other hand, some test cases or suites may not need the most complex=
 topology available.<br>
+<br>
+The module allows developers to mark test cases or suites to require certa=
in hardware capabilities<br>
+or a particular topology.<br>
+<br>
+There are differences between hardware and topology capabilities:<br>
+<br>
+=C2=A0 =C2=A0 * Hardware capabilities are assumed to not be required when =
not specified.<br>
+=C2=A0 =C2=A0 * However, some topology is always available, so each test c=
ase or suite is assigned<br>
+=C2=A0 =C2=A0 =C2=A0 a default topology if no topology is specified in the=
 decorator.<br>
+<br>
+Examples:<br>
+=C2=A0 =C2=A0 .. code:: python<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.test_suite import TestSuite, fu=
nc_test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.testbed_model.capability import=
 LinkTopology, requires_link_topology<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The whole test suite (each test case within)=
 doesn&#39;t require any links.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires_link_topology(LinkTopology.NO_LINK)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 class TestHelloWorld(TestSuite):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def hello_world_single_core(self=
):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
+<br>
+=C2=A0 =C2=A0 .. code:: python<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.test_suite import TestSuite, fu=
nc_test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.testbed_model.capability import=
 NicCapability, requires_nic_capability<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 class TestPmdBufferScatter(TestSuite):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # only the test case requires th=
e SCATTERED_RX_ENABLED capability<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # other test cases may not requi=
re it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires_nic_capability(NicCapa=
bility.SCATTERED_RX_ENABLED)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def test_scatter_mbuf_2048(self)=
:<br>
+&quot;&quot;&quot;<br>
+<br>
+from enum import IntEnum, auto<br>
+from typing import TYPE_CHECKING, Callable<br>
+<br>
+if TYPE_CHECKING:<br>
+=C2=A0 =C2=A0 from framework.test_suite import TestProtocol<br>
+<br>
+<br>
+class LinkTopology(IntEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Supported topology types.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 #: A topology with no Traffic Generator.<br>
+=C2=A0 =C2=A0 NO_LINK =3D 0<br>
+=C2=A0 =C2=A0 #: A topology with one physical link between the SUT node an=
d the TG node.<br>
+=C2=A0 =C2=A0 ONE_LINK =3D auto()<br>
+=C2=A0 =C2=A0 #: A topology with two physical links between the Sut node a=
nd the TG node.<br>
+=C2=A0 =C2=A0 TWO_LINKS =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def default(cls) -&gt; &quot;LinkTopology&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The default topology require=
d by test cases if not specified otherwise.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls.TWO_LINKS<br>
+<br>
+<br>
+class NicCapability(IntEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;DPDK NIC capabilities.<br>
+<br>
+=C2=A0 =C2=A0 The capabilities are used to mark test cases or suites that =
require a specific<br>
+=C2=A0 =C2=A0 DPDK NIC capability to run. The capabilities are used by the=
 test framework to<br>
+=C2=A0 =C2=A0 determine whether a test case or suite can be run on the cur=
rent testbed.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Scattered packets Rx enabled.<br>
+=C2=A0 =C2=A0 SCATTERED_RX_ENABLED =3D 0<br>
+=C2=A0 =C2=A0 #: Device supports VLAN stripping.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L3 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Large Receive Offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports QinQ (queue in queue) offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports inner packet L3 checksum.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports MACsec.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports filtering of a VLAN Tag identifier.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports VLAN offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports receiving segmented mbufs.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Timestamp.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports crypto processing while packet is receive=
d in NIC.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports CRC stripping.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports inner packet L4 checksum.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports RSS hashing.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports scatter Rx packets to segmented mbufs.<br=
>
+=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports all checksum capabilities.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports all VLAN capabilities.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Rx queue setup after device started.<br>
+=C2=A0 =C2=A0 RUNTIME_RX_QUEUE_SETUP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Tx queue setup after device started.<br>
+=C2=A0 =C2=A0 RUNTIME_TX_QUEUE_SETUP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports shared Rx queue among ports within Rx dom=
ain and switch domain.<br>
+=C2=A0 =C2=A0 RXQ_SHARE =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports keeping flow rules across restart.<br>
+=C2=A0 =C2=A0 FLOW_RULE_KEEP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports keeping shared flow objects across restar=
t.<br>
+=C2=A0 =C2=A0 FLOW_SHARED_OBJECT_KEEP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports multicast address filtering.<br>
+=C2=A0 =C2=A0 MCAST_FILTERING =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports flow ctrl.<br>
+=C2=A0 =C2=A0 FLOW_CTRL =3D auto()<br>
+=C2=A0 =C2=A0 #: Device is running on a physical function.<br>
+=C2=A0 =C2=A0 PHYSICAL_FUNCTION =3D auto()<br>
+<br>
+<br>
+def requires_link_topology(<br>
+=C2=A0 =C2=A0 link_topology: LinkTopology,<br>
+) -&gt; Callable[[type[&quot;TestProtocol&quot;]], type[&quot;TestProtocol=
&quot;]]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator to set required topology type fo=
r a test case or test suite.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 link_topology: The topology type the test suit=
e or case requires.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The decorated test case or test suite.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 from framework.testbed_model.capability import TopologyCapab=
ility<br>
+<br>
+=C2=A0 =C2=A0 def add_required_topology(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_case_or_suite: type[&quot;TestProtocol&qu=
ot;],<br>
+=C2=A0 =C2=A0 ) -&gt; type[&quot;TestProtocol&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 topology_capability =3D TopologyCapability.get=
_unique(link_topology)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 topology_capability.set_required(test_case_or_=
suite)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return test_case_or_suite<br>
+<br>
+=C2=A0 =C2=A0 return add_required_topology<br>
+<br>
+<br>
+def requires_nic_capability(<br>
+=C2=A0 =C2=A0 nic_capability: NicCapability,<br>
+) -&gt; Callable[[type[&quot;TestProtocol&quot;]], type[&quot;TestProtocol=
&quot;]]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator to add a single required NIC cap=
ability to a test case or test suite.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nic_capability: The NIC capability that is req=
uired by the test case or test suite.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The decorated test case or test suite.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 from framework.testbed_model.capability import DecoratedNicC=
apability<br>
+<br>
+=C2=A0 =C2=A0 def add_required_capability(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_case_or_suite: type[&quot;TestProtocol&qu=
ot;],<br>
+=C2=A0 =C2=A0 ) -&gt; type[&quot;TestProtocol&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 decorated =3D DecoratedNicCapability.get_uniqu=
e(nic_capability)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 decorated.add_to_required(test_case_or_suite)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return test_case_or_suite<br>
+<br>
+=C2=A0 =C2=A0 return add_required_capability<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
new file mode 100644<br>
index 0000000000..49cf3742dd<br>
--- /dev/null<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -0,0 +1,1294 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2023 University of New Hampshire<br>
+# Copyright(c) 2023 PANTHEON.tech s.r.o.<br>
+# Copyright(c) 2024 Arm Limited<br>
+<br>
+&quot;&quot;&quot;Testpmd interactive shell.<br>
+<br>
+Typical usage example in a TestSuite::<br>
+<br>
+=C2=A0 =C2=A0 testpmd =3D TestPmd(self.sut_node)<br>
+=C2=A0 =C2=A0 devices =3D testpmd.get_devices()<br>
+=C2=A0 =C2=A0 for device in devices:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(device)<br>
+=C2=A0 =C2=A0 testpmd.close()<br>
+&quot;&quot;&quot;<br>
+<br>
+import functools<br>
+import re<br>
+import time<br>
+from collections.abc import MutableSet<br>
+from enum import Flag<br>
+from pathlib import PurePath<br>
+from typing import (<br>
+=C2=A0 =C2=A0 Any,<br>
+=C2=A0 =C2=A0 Callable,<br>
+=C2=A0 =C2=A0 ClassVar,<br>
+=C2=A0 =C2=A0 Concatenate,<br>
+=C2=A0 =C2=A0 ParamSpec,<br>
+=C2=A0 =C2=A0 Tuple,<br>
+)<br>
+<br>
+from typing_extensions import Unpack<br>
+<br>
+from api.capabilities import LinkTopology, NicCapability<br>
+from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPm=
dParams<br>
+from api.testpmd.types import (<br>
+=C2=A0 =C2=A0 ChecksumOffloadOptions,<br>
+=C2=A0 =C2=A0 DeviceCapabilitiesFlag,<br>
+=C2=A0 =C2=A0 FlowRule,<br>
+=C2=A0 =C2=A0 RxOffloadCapabilities,<br>
+=C2=A0 =C2=A0 RxOffloadCapability,<br>
+=C2=A0 =C2=A0 TestPmdDevice,<br>
+=C2=A0 =C2=A0 TestPmdPort,<br>
+=C2=A0 =C2=A0 TestPmdPortFlowCtrl,<br>
+=C2=A0 =C2=A0 TestPmdPortStats,<br>
+=C2=A0 =C2=A0 TestPmdQueueInfo,<br>
+=C2=A0 =C2=A0 TestPmdRxqInfo,<br>
+=C2=A0 =C2=A0 TestPmdVerbosePacket,<br>
+=C2=A0 =C2=A0 VLANOffloadFlag,<br>
+)<br>
+from framework.context import get_ctx<br>
+from framework.exception import InteractiveCommandExecutionError, Internal=
Error<br>
+from framework.params.types import TestPmdParamsDict<br>
+from framework.remote_session.dpdk_shell import DPDKShell<br>
+from framework.remote_session.interactive_shell import only_active<br>
+from framework.settings import SETTINGS<br>
+<br>
+P =3D ParamSpec(&quot;P&quot;)<br>
+TestPmdMethod =3D Callable[Concatenate[&quot;TestPmd&quot;, P], Any]<br>
+<br>
+<br>
+def _requires_stopped_ports(func: TestPmdMethod) -&gt; TestPmdMethod:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator for :class:`TestPmd` commands me=
thods that require stopped ports.<br>
+<br>
+=C2=A0 =C2=A0 If the decorated method is called while the ports are starte=
d, then these are stopped before<br>
+=C2=A0 =C2=A0 continuing.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 func: The :class:`TestPmd` method to decorate.=
<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @functools.wraps(func)<br>
+=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmd&quot;, *args: P.args, **kwa=
rgs: P.kwargs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.ports_started:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Ports n=
eed to be stopped to continue.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stop_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(self, *args, **kwargs)<br>
+<br>
+=C2=A0 =C2=A0 return _wrapper<br>
+<br>
+<br>
+def _requires_started_ports(func: TestPmdMethod) -&gt; TestPmdMethod:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator for :class:`TestPmd` commands me=
thods that require started ports.<br>
+<br>
+=C2=A0 =C2=A0 If the decorated method is called while the ports are stoppe=
d, then these are started before<br>
+=C2=A0 =C2=A0 continuing.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 func: The :class:`TestPmd` method to decorate.=
<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @functools.wraps(func)<br>
+=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmd&quot;, *args: P.args, **kwa=
rgs: P.kwargs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.ports_started:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Ports n=
eed to be started to continue.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(self, *args, **kwargs)<br>
+<br>
+=C2=A0 =C2=A0 return _wrapper<br>
+<br>
+<br>
+def _add_remove_mtu(mtu: int =3D 1500) -&gt; Callable[[TestPmdMethod], Tes=
tPmdMethod]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Configure MTU to `mtu` on all ports, run t=
he decorated function, then revert.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: The MTU to configure all ports on.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The method decorated with setting and revertin=
g MTU.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def decorator(func: TestPmdMethod) -&gt; TestPmdMethod:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @functools.wraps(func)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmd&quot;, *args: =
P.args, **kwargs: P.kwargs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 original_mtu =3D self.ports[0].m=
tu<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu_all(mtu=3Dmtu,=
 verify=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D func(self, *args, **k=
wargs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu_all(original_m=
tu if original_mtu else 1500, verify=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return wrapper<br>
+<br>
+=C2=A0 =C2=A0 return decorator<br>
+<br>
+<br>
+class TestPmd(DPDKShell):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Testpmd interactive shell.<br>
+<br>
+=C2=A0 =C2=A0 The testpmd shell users should never use<br>
+=C2=A0 =C2=A0 the :meth:`~.interactive_shell.InteractiveShell.send_command=
` method directly, but rather<br>
+=C2=A0 =C2=A0 call specialized methods. If there isn&#39;t one that satisf=
ies a need, it should be added.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ports_started: Indicates whether the ports are=
 started.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 _app_params: TestPmdParams<br>
+=C2=A0 =C2=A0 _ports: list[TestPmdPort] | None<br>
+<br>
+=C2=A0 =C2=A0 #: The testpmd&#39;s prompt.<br>
+=C2=A0 =C2=A0 _default_prompt: ClassVar[str] =3D &quot;testpmd&gt;&quot;<b=
r>
+<br>
+=C2=A0 =C2=A0 #: This forces the prompt to appear after sending a command.=
<br>
+=C2=A0 =C2=A0 _command_extra_chars: ClassVar[str] =3D &quot;\n&quot;<br>
+<br>
+=C2=A0 =C2=A0 ports_started: bool<br>
+<br>
+=C2=A0 =C2=A0 def __init__(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str | None =3D None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: bool =3D True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 **app_params: Unpack[TestPmdParamsDict],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.dpdk_shel=
l.DPDKShell.__init__`. Changes app_params to kwargs.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;port_topology&quot; not in app_params=
 and get_ctx().topology.type is LinkTopology.ONE_LINK:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params[&quot;port_topology&q=
uot;] =3D PortTopology.loop<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, privileged, app_params=
=3DTestPmdParams(**app_params))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D not self._app_params.di=
sable_device_start<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D None<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The path to the testpmd exec=
utable.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return PurePath(&quot;app/dpdk-testpmd&quot;)<=
br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def ports(self) -&gt; list[TestPmdPort]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The ports of the instance.<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This caches the ports returned by :meth:`show_=
port_info_all`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 To force an update of port information, execut=
e :meth:`show_port_info_all` or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :meth:`show_port_info`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns: The list of known testpmd ports.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._ports is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.show_port_info_all()=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._ports<br>
+<br>
+=C2=A0 =C2=A0 @_requires_started_ports<br>
+=C2=A0 =C2=A0 def start(self, verify: bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start packet forwarding with=
 the current configuration.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` , a seco=
nd start command will be sent in an attempt to verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet forwarding =
started as expected.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and forwarding fails to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start or ports fai=
l to come up.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;start&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If forwarding was already star=
ted, sending &quot;start&quot; again should tell us<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start_cmd_output =3D self.send_c=
ommand(&quot;start&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Packet forwarding alrea=
dy started&quot; not in start_cmd_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to start packet forwarding: \n{start_cmd_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Testpmd failed to start packet forwarding.&quot;=
)<br>
+<br>
+=C2=A0 =C2=A0 def stop(self, verify: bool =3D True) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stop packet forwarding.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` , the ou=
tput of the stop command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding was sto=
pped successfully or not started. If neither is found, it is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 considered an erro=
r.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command to stop<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding results=
 in an error.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Output gathered from the stop co=
mmand and all other preceding logs in the buffer. This<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output is most often used to vie=
w forwarding statistics that are displayed when this<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command is sent as well as any v=
erbose packet information that hasn&#39;t been consumed<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prior to calling this method.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_cmd_output =3D self.send_command(&quot;st=
op&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Done.&quot; =
not in stop_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and &quot;Packet f=
orwarding not started&quot; not in stop_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to stop packet forwarding: \n{stop_cmd_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Testpmd failed to stop packet forwarding.&quot;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stop_cmd_output<br>
+<br>
+=C2=A0 =C2=A0 def get_devices(self) -&gt; list[TestPmdDevice]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get a list of device names t=
hat are known to testpmd.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Uses the device info listed in testpmd and the=
n parses the output.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A list of devices.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info: str =3D self.send_command(&quot;show=
 device info all&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_list: list[TestPmdDevice] =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in dev_info.split(&quot;\n&quot;):<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;device name:&quot; in l=
ine.lower():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_list.append(Te=
stPmdDevice(line))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return dev_list<br>
+<br>
+=C2=A0 =C2=A0 def wait_link_status_up(self, port_id: int, timeout=3DSETTIN=
GS.timeout) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Wait until the link status o=
n the given port is &quot;up&quot;.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arguments:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Port to check the link =
status on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout: Time to wait for the li=
nk to come up. The default value for this<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argument may be mo=
dified using the :option:`--timeout` command-line argument<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or the :envvar:`DT=
S_TIMEOUT` environment variable.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Whether the link came up in time=
 or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_to_stop =3D time.time() + timeout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_info: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while time.time() &lt; time_to_stop:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_info =3D self.send_command(=
f&quot;show port info {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Link status: up&quot; i=
n port_info:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.5)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error(f&quot;The li=
nk for port {port_id} did not come up in the given timeout.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Link status: up&quot; in port_inf=
o<br>
+<br>
+=C2=A0 =C2=A0 def set_forward_mode(self, mode: SimpleForwardingModes, veri=
fy: bool =3D True):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set packet forwarding mode.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode: The forwarding mode to use=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the fo=
rwarding mode was set to `mode` properly.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the forwarding mode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_fwd_output =3D self.send_command(f&quot;se=
t fwd {mode.value}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f&quot;Set {mode.value} packe=
t forwarding mode&quot; not in set_fwd_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to set fwd mode to {mode.value}:\n{set_fwd_output}&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to set fwd mode to {mode.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def stop_all_ports(self, verify: bool =3D True) -&gt; None:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stops all the ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command will be checked for a successful<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execution.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the ports were not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stopped successful=
ly.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Stopping all the port=
s...&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;port stop a=
ll&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and not output.strip().endswith(&quo=
t;Done&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Ports were not stopped successfully.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D False<br>
+<br>
+=C2=A0 =C2=A0 def start_all_ports(self, verify: bool =3D True) -&gt; None:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Starts all the ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command will be checked for a successful<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execution.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the ports were not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 started successful=
ly.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Starting all the port=
s...&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;port start =
all&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and not output.strip().endswith(&quo=
t;Done&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Ports were not started successfully.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D True<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_ports_queues(self, number_of: int) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the number of queues pe=
r port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of: The number of RX/TX q=
ueues to create per port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If `number_of` is=
 invalid.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if number_of &lt; 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalError(&quot;The nu=
mber of queues must be positive and non-zero.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config all rxq {=
number_of}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config all txq {=
number_of}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def close_all_ports(self, verify: bool =3D True) -&gt; None:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Close all ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the close command will be scanned in an attempt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to verify that all=
 ports were stopped successfully. Defaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and at lease one port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 failed to close.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_close_output =3D self.send_command(&quot;=
port close all&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_ports =3D len(self.ports)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not all(f&quot;Port {p_id} is=
 closed&quot; in port_close_output for p_id in range(num_ports)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Ports were not closed successfully.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def show_port_info_all(self) -&gt; list[TestPmdPort]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the information of a=
ll the ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[TestPmdPort]: A list contai=
ning all the ports information as `TestPmdPort`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;show port i=
nfo all&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sample output of the &quot;all&quot; command=
 looks like:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;start&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0********************* Infos for =
port 0 *********************<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0Key: value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0********************* Infos for =
port 1 *********************<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0Key: value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;end&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Takes advantage of the double new line in be=
tween ports as end delimiter. But we need to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # artificially add a new line at the end to pi=
ck up the last port. Because commands are<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # executed on a pseudo-terminal created by par=
amiko on the remote node, lines end with CRLF.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Therefore we also need to take the carriage =
return into account.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(r&quot;\*{21}.*?[\r\n]{4}=
&quot;, output + &quot;\r\n&quot;, re.S)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D [TestPmdPort.parse(block.group=
(0)) for block in iter]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._ports<br>
+<br>
+=C2=A0 =C2=A0 def show_port_info(self, port_id: int) -&gt; TestPmdPort:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the given port infor=
mation.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID to gather i=
nformation for.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `port_id` is invalid.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdPort: An instance of `Tes=
tPmdPort` containing the given port&#39;s information.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
info {port_id}&quot;, skip_first_line=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.startswith(&quot;Invalid port&quot;)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;invalid port given&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port =3D TestPmdPort.parse(output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_port(port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return port<br>
+<br>
+=C2=A0 =C2=A0 def _update_port(self, port: TestPmdPort) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 existing_port if <=
a href=3D"http://port.id" rel=3D"noreferrer" target=3D"_blank">port.id</a> =
!=3D <a href=3D"http://existing_port.id" rel=3D"noreferrer" target=3D"_blan=
k">existing_port.id</a> else port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for existing_port =
in self._ports<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+<br>
+=C2=A0 =C2=A0 def set_mac_addr(self, port_id: int, mac_address: str, add: =
bool, verify: bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove a mac address =
on a given port&#39;s Allowlist.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID the mac add=
ress is set on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_address: The mac address to =
be added to or removed from the specified port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: If :data:`True`, add the sp=
ecified mac address. If :data:`False`, remove specified<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac address.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:&#39;True&#39;,=
 assert that the &#39;mac_addr&#39; operation was successful. If<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :data:&#39;False&#=
39;, run the command and skip this assertion.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If the set mac address operation fails.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_cmd =3D &quot;add&quot; if add else &quot;=
remove&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mac_addr {=
mac_cmd} {port_id} {mac_address}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Bad arguments&quot; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Invalid=
 argument provided to mac_addr&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Invalid argument provided&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;mac_addr_cmd error:&quo=
t; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to {mac_cmd} {mac_address} on port {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {mac_cmd} {mac_address} on port {port_id} \n{output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def set_multicast_mac_addr(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, multi_addr: str, add: bool=
, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove multicast mac =
address to a specified port&#39;s allow list.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID the multica=
st address is set on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multi_addr: The multicast addres=
s to be added or removed from the filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: If :data:&#39;True&#39;, ad=
d the specified multicast address to the port filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If :data:&#39;Fals=
e&#39;, remove the specified multicast address from the port filter.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:&#39;True&#39;,=
 assert that the &#39;mcast_addr&#39; operations was successful.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If :data:&#39;Fals=
e&#39;, execute the &#39;mcast_addr&#39; operation and skip the assertion.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If either the &#39;add&#39; or &#39;remove&#39; operations fails.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcast_cmd =3D &quot;add&quot; if add else &quo=
t;remove&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mcast_addr=
 {mcast_cmd} {port_id} {multi_addr}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Bad arguments&quot; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Invalid=
 arguments provided to mcast_addr&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Invalid argument provided&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Invalid mult=
icast_addr&quot; in output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or f&quot;multicas=
t address {&#39;already&#39; if add else &#39;not&#39;} filtered by port&qu=
ot; in output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to {mcast_cmd} {multi_addr} on port {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {mcast_cmd} {multi_addr} on port {port_id} \n{output}&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def show_port_stats_all(self) -&gt; Tuple[list[TestPmdPortSt=
ats], str]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the statistics of al=
l the ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuple[str, list[TestPmdPortStats=
]]: A tuple where the first element is the stats of all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ports as `TestPmdPortStats` and =
second is the raw testpmd output that was collected<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from the sent command.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;show port s=
tats all&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sample output of the &quot;all&quot; command=
 looks like:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0########### NIC statistics for p=
ort 0 ###########<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0values...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0################################=
#################<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0########### NIC statistics for p=
ort 1 ###########<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0values...<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0################################=
#################<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(r&quot;(^=C2=A0 #*.+#*$[^=
#]+)^=C2=A0 #*\r$&quot;, output, re.MULTILINE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ([TestPmdPortStats.parse(block.group(1)=
) for block in iter], output)<br>
+<br>
+=C2=A0 =C2=A0 def show_port_stats(self, port_id: int) -&gt; TestPmdPortSta=
ts:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the given port stati=
stics.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID to gather i=
nformation for.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `port_id` is invalid.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdPortStats: An instance of=
 `TestPmdPortStats` containing the given port&#39;s stats.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
stats {port_id}&quot;, skip_first_line=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.startswith(&quot;Invalid port&quot;)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;invalid port given&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TestPmdPortStats.parse(output)<br>
+<br>
+=C2=A0 =C2=A0 def set_multicast_all(self, on: bool, verify: bool =3D True)=
 -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Turns multicast mode on/off =
for the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True`, turns multi=
cast mode on, otherwise turns off.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that multicast mod=
e is properly set. Defaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and multicast<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode is not proper=
ly set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 multicast_cmd_output =3D self.send_command(f&q=
uot;set allmulti all {&#39;on&#39; if on else &#39;off&#39;}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_stats =3D self.show_port_in=
fo_all()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if on ^ all(stats.is_allmulticas=
t_mode_enabled for stats in port_stats):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set multicast mode on all ports.: \n{multicast_cmd_output}&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Testpmd failed to set multicast mode on all ports.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def csum_set_hw(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, layers: ChecksumOffloadOptions, port_id:=
 int, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enables hardware checksum of=
floading on the specified layer.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layers: The layer/layers that ch=
ecksum offloading should be enabled on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port number to enab=
le checksum offloading on, should be within 0-32.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that checks=
um offloading was enabled on the port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If checksum offload is not enabled successfully.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name, offload in ChecksumOffloadOptions.__=
members__.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if offload in layers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D name.repl=
ace(&quot;_&quot;, &quot;-&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csum_output =3D se=
lf.send_command(f&quot;csum set {name} hw {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Bad arguments&quot; in csum_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or f&quot;Please stop port {port_id} first&quot; in csum_output<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or f&quot;checksum offload is not supported by port {port_id}&qu=
ot; in csum_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self._logger.debug(f&quot;Csum set hw error:\n{csum_output}&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 raise InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to set csum hw {name} mode on port {=
port_id}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D False<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f&quot;{name} c=
hecksum offload is hw&quot; in csum_output.lower():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 succ=
ess =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not success and=
 verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to set csum hw mode on port {port_id}:\n{csum_outp=
ut}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;&quot;&quot;Failed to set csum hw mode on port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{port_id}:\n{=
csum_output}&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+<br>
+=C2=A0 =C2=A0 def flow_create(self, flow_rule: FlowRule, port_id: int) -&g=
t; int:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Creates a flow rule in the t=
estpmd session.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This command is implicitly verified as needed =
to return the created flow rule id.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: :class:`FlowRule` obj=
ect used for creating testpmd flow rule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If flow rule is invalid.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Id of created flow rule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
create {port_id} {flow_rule}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D re.search(r&quot;#(\d+)&quot;, flow_=
output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if match is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match_str =3D match.group(1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id =3D int(match_str)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return flow_id<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;Failed=
 to create flow rule:\n{flow_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(f&quot;Failed to create flow rule:\n{flow_output}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def flow_validate(self, flow_rule: FlowRule, port_id: int) -=
&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validates a flow rule in the=
 testpmd session.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: :class:`FlowRule` obj=
ect used for validating testpmd flow rule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Boolean representing whether rul=
e is valid or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
validate {port_id} {flow_rule}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow rule validated&quot; in flow_out=
put:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 def flow_delete(self, flow_id: int, port_id: int, verify: bo=
ol =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Deletes the specified flow r=
ule from the testpmd session.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id: ID of the flow to remov=
e.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to ensure the flow=
 rule was deleted successfully.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If flow rule is invalid.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
destroy {port_id} rule {flow_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;destroyed&quot; not in =
flow_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to delete flow rule:\n{flow_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to delete flow rule:\n{flow_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_started_ports<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_port_mtu(self, port_id: int, mtu: int, verify: bool =
=3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Change the MTU of a port usi=
ng testpmd.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Some PMDs require that the port be stopped bef=
ore changing the MTU, and it does no harm to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop the port before configuring in cases wher=
e it isn&#39;t required, so ports are stopped<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prior to changing their MTU. On the other hand=
, some PMDs require that the port had already<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 been started once since testpmd startup. There=
fore, ports are also started before stopping<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 them to ensure this has happened.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to adjus=
t the MTU on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: Desired value for the MTU t=
o be set to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If `verify` is :data:`Tr=
ue` then the output will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the mt=
u was properly set on the port. Defaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the MTU was not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 properly updated o=
n the port matching `port_id`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mtu_output =3D self.send_command(f&quot;po=
rt config mtu {port_id} {mtu}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and (f&quot;MTU: {mtu}&quot; not in =
self.send_command(f&quot;show port info {port_id}&quot;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to s=
et mtu to {mtu} on port {port_id}. Output was:\n{set_mtu_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd fa=
iled to update mtu of port {port_id} to {mtu}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def set_port_mtu_all(self, mtu: int, verify: bool =3D True) =
-&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Change the MTU of all ports =
using testpmd.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Runs :meth:`set_port_mtu` for every port that =
testpmd is aware of.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: Desired value for the MTU t=
o be set to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: Whether to verify that s=
etting the MTU on each port was successful or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Defaults to :data:=
`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the MTU was not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 properly updated o=
n at least one port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu(<a href=3D"htt=
p://port.id" rel=3D"noreferrer" target=3D"_blank">port.id</a>, mtu, verify)=
<br>
+<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def extract_verbose_output(output: str) -&gt; list[TestPmdVe=
rbosePacket]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Extract the verbose informat=
ion present in given testpmd output.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This method extracts sections of verbose outpu=
t that begin with the line<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;port X/queue Y: sent/received Z packets&=
quot; and end with the ol_flags of a packet.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: Testpmd output that cont=
ains verbose information<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 List of parsed packet informatio=
n gathered from verbose information in `output`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out: list[TestPmdVerbosePacket] =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_header: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;(?P&lt;HEADER&gt;(?:port =
\d+/queue \d+: (?:received|sent) \d+ packets)?)\s*&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;(?P&lt;PACKET&gt;src=3D[\=
w\s=3D:-]+?ol_flags: [\w ]+)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for match in iter:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if match.group(&quot;HEADER&quot=
;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_header =3D ma=
tch.group(&quot;HEADER&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out.append(TestPmdVerbosePacket.=
parse(f&quot;{prev_header}\n{match.group(&#39;PACKET&#39;)}&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return out<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_vlan_filter(self, port: int, enable: bool, verify: b=
ool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set vlan filter on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to enable =
VLAN filter on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: Enable the filter on `po=
rt` if :data:`True`, otherwise disable it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command and show port info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is scanned to veri=
fy that vlan filtering was set successfully.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the filter<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filter_cmd_output =3D self.send_command(f&quot=
;vlan set filter {&#39;on&#39; if enable else &#39;off&#39;} {port}&quot;)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan_settings =3D self.show_port=
_info(port_id=3Dport).vlan_offload<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ (vlan_settings is no=
t None and VLANOffloadFlag.FILTER in vlan_settings):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;enable&quot; if enable else &quot;disable&q=
uot;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filter on port {port}: =
\n{filter_cmd_output}&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;enable&quot; if enable else &quot;disable&q=
uot;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filt=
er on port {port}&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def set_mac_address(self, port: int, mac_address: str, verif=
y: bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set port&#39;s MAC address.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_address: The MAC address to =
set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the mac address is=
 set in the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to execute.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mac_addr s=
et {port} {mac_address}&quot;, skip_first_line=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.strip():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set MAC address {mac_address} on port {port}.&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set MAC address {mac_address} on port {port}.&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def set_flow_control(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port: int, flow_ctrl: TestPmdPortFlowCtr=
l, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the given `port`&#39;s f=
low control.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_ctrl: The requested flow co=
ntrol parameters.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the flow control i=
n the specified port is set.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to execute.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;set flow_c=
trl {flow_ctrl} {port}&quot;, skip_first_line=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.strip():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Testpmd failed to set the {flow_ctrl} in port {port}.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set the {flow_ctrl} in port {port}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def show_port_flow_info(self, port: int) -&gt; TestPmdPortFl=
owCtrl | None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Show port info flow.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The current port flow control pa=
rameters if supported, otherwise :data:`None`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
{port} flow_ctrl&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow control infos&quot; in output:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TestPmdPortFlowCtrl.parse=
(output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def rx_vlan(self, vlan: int, port: int, add: bool, verify: b=
ool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add specified vlan tag to th=
e filter list on a port. Requires vlan filter to be on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan: The vlan tag to add, shoul=
d be within 1-1005.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to add the=
 tag on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: Adds the tag if :data:`True=
`, otherwise removes the tag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the vlan tag was a=
dded to the filter list on the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the tag<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not added.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmd_output =3D self.send_command(f&quot;rx_=
vlan {&#39;add&#39; if add else &#39;rm&#39;} {vlan} {port}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VLAN-filteri=
ng disabled&quot; in rx_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;Invalid v=
lan_id&quot; in rx_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;Bad argum=
ents&quot; in rx_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;add&quot; if add else &quot;remove&quot;} t=
ag {vlan}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
 {port}: \n{rx_cmd_output}&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to {&#39;add&#39; if add else &#39;remove&#39;} tag {vlan=
} on port {port}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_vlan_strip(self, port: int, enable: bool, verify: bo=
ol =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enable or disable vlan strip=
ping on the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to use.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, will tu=
rn vlan stripping on, otherwise will turn off.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command and show port info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is scanned to veri=
fy that vlan stripping was enabled on the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and stripping<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strip_cmd_output =3D self.send_command(f&quot;=
vlan set strip {&#39;on&#39; if enable else &#39;off&#39;} {port}&quot;)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan_settings =3D self.show_port=
_info(port_id=3Dport).vlan_offload<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ (vlan_settings is no=
t None and VLANOffloadFlag.STRIP in vlan_settings):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to set strip {&quot;on&quot; if enable else &quot;off=
&quot;}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
 {port}: \n{strip_cmd_output}&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set strip {&#39;on&#39; if enable else &#39;off&#39;} =
port {port}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def tx_vlan_set(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port: int, enable: bool, vlan: int | Non=
e =3D None, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set hardware insertion of vl=
an tags in packets sent on a port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to use.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: Sets vlan tag insertion =
if :data:`True`, and resets if :data:`False`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan: The vlan tag to insert if =
enable is :data:`True`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan insertion was=
 enabled on the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the insertion<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag is not set.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_vlan_cmd_output =3D self.send=
_command(f&quot;tx_vlan set {port} {vlan}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Please stop port&quot; in tx_vlan_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &=
quot;Invalid vlan_id&quot; in tx_vlan_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &=
quot;Invalid port&quot; in tx_vlan_cmd_output<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to set vlan tag {vlan} on port {port}:\n{tx_vlan_c=
md_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Testpmd failed to set vlan insertion tag {vlan} on port {=
port}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_vlan_cmd_output =3D self.send=
_command(f&quot;tx_vlan reset {port}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Please st=
op port&quot; in tx_vlan_cmd_output or &quot;Invalid port&quot; in tx_vlan_=
cmd_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to reset vlan insertion on port {port}: \n{tx_vlan=
_cmd_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Testpmd failed to reset vlan insertion on port {port}.&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
+<br>
+=C2=A0 =C2=A0 def set_promisc(self, port: int, enable: bool, verify: bool =
=3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enable or disable promiscuou=
s mode for the specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: Port number to use.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, turn pr=
omiscuous mode on, otherwise turn off.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 promiscuous mode i=
s properly set. Defaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and promiscuous mode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not correctly s=
et.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 promisc_cmd_output =3D self.send_command(f&quo=
t;set promisc {port} {&#39;on&#39; if enable else &#39;off&#39;}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D self.show_port_info(po=
rt_id=3Dport)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ stats.is_promiscuous=
_mode_enabled:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set promiscuous mode on port {port}: \n{promisc_cmd_output}&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set promiscuous mode on port {port}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def set_verbose(self, level: int, verify: bool =3D True) -&g=
t; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set debug verbosity level.<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 level: 0 - silent except for err=
or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 - fully verbose =
except for Tx packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 - fully verbose =
except for Rx packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;2 - fully verb=
ose<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the comm=
and output will be scanned to verify that verbose level<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is properly set. D=
efaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and verbose level<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not correctly set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_cmd_output =3D self.send_command(f&quo=
t;set verbose {level}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Change verbose level&qu=
ot; not in verbose_cmd_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set verbose level to {level}: \n{verbose_cmd_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set verbose level to {level}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool=
, verify: bool =3D True) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove vxlan id to/fr=
om filter list.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_id: VXLAN ID to add to por=
t filter list.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to modif=
y VXLAN filter of.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, adds sp=
ecified VXLAN ID, otherwise removes it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is checked to verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the VXLAN ID was s=
uccessfully added/removed from the port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and VXLAN ID<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not successfull=
y added or removed.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot;add&quot; if enable else &quo=
t;rm&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_output =3D self.send_command(f&quot;rx_v=
xlan_port {action} {vxlan_id} {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;udp tunneling add error=
&quot; in vxlan_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to set VXLAN:\n{vxlan_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(f&quot;Failed to set VXLAN:\n{vxlan_output}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def clear_port_stats(self, port_id: int, verify: bool =3D Tr=
ue) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Clear statistics of a given =
port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to clear=
 the statistics on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned to verify that it was<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 successful, otherw=
ise failures will be ignored. Defaults to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and testpmd fails to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear the statisti=
cs of the given port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_output =3D self.send_command(f&quot;clea=
r port stats {port_id}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and f&quot;NIC statistics for port {=
port_id} cleared&quot; not in clear_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd fa=
iled to set clear forwarding stats on port {port_id}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def clear_port_stats_all(self, verify: bool =3D True) -&gt; =
None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Clear the statistics of all =
ports that testpmd is aware of.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned to verify that all<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ports had their st=
atistics cleared, otherwise failures will be ignored. Defaults to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and testpmd fails to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear the statisti=
cs of any of its ports.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_output =3D self.send_command(&quot;clear=
 port stats all&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if type(self._app_params.port_nu=
ma_config) is list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port_id in ran=
ge(len(self._app_params.port_numa_config)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f=
&quot;NIC statistics for port {port_id} cleared&quot; not in clear_output:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 raise InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd failed to set clear forwarding sta=
ts on port {port_id}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @only_active<br>
+=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.interacti=
ve_shell.close`.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stop()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;quit&quot;, &quot;Bye.=
..&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return super().close()<br>
+<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=
=3D=3D<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def get_capabilities_rx_offload(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all rx offload capabilit=
ies and divide them into supported and unsupported.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting rx offload ca=
pabilities.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {self.ports[0].id=
} rx_offload capabilities&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities_out =3D self.send_comm=
and(command)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities =3D RxOffloadCapabilit=
ies.parse(rx_offload_capabilities_out)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_flag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RxOffloadCapability,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities.per_port=
 | rx_offload_capabilities.per_queue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def get_port_queue_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool<br>
+=C2=A0 =C2=A0 ) -&gt; TestPmdQueueInfo:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the current state of=
 the specified queue.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show {&#39;rxq&#39; if is_r=
x_queue else &#39;txq&#39;} info {port_id} {queue_id}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_info =3D TestPmdQueueInfo.parse(self.sen=
d_command(command))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return queue_info<br>
+<br>
+=C2=A0 =C2=A0 def setup_port_queue(self, port_id: int, queue_id: int, is_r=
x_queue: bool) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Setup a given queue on a por=
t.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This functionality cannot be verified because =
the setup action only takes effect when the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue is started.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port where th=
e queue resides.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to set=
up.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to se=
tup. If :data:`True` an RX queue will be setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be setup.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port {port_id} {&#39;=
rxq&#39; if is_rx_queue else &#39;txq&#39;} {queue_id} setup&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def stop_port_queue(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stops a given queue on a por=
t.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port that the=
 queue belongs to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to sto=
p.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to st=
op. If :data:`True` an RX queue will be stopped,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be stopped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify the queue stopped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Defaults to :data:=
`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the queue fails to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_type =3D &quot;rxq&quot; if is_rx_queue e=
lse &quot;txq&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_cmd_output =3D self.send_command(f&quot;p=
ort {port_id} {port_type} {queue_id} stop&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_started =3D self.get_port_=
queue_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id, queue_id,=
 is_rx_queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ).is_queue_started<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if queue_started:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to stop {port_type} {queue_id} on port {port_id}:\n{stop_cmd_outp=
ut}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to stop {port_type} {queue_id} on port {port_id}&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def start_port_queue(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Starts a given queue on a po=
rt.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 First sets up the port queue, then starts it.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port that the=
 queue belongs to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to sta=
rt.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to st=
art. If :data:`True` an RX queue will be started,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be started.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: if :data:`True` an addit=
ional command will be sent to verify that the queue was<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 started. Defaults =
to :data:`True`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the queue fails to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_type =3D &quot;rxq&quot; if is_rx_queue e=
lse &quot;txq&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_port_queue(port_id, queue_id, is_rx=
_queue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_cmd_output =3D self.send_command(f&quot;=
port {port_id} {port_type} {queue_id} start&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_started =3D self.get_port_=
queue_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id, queue_id,=
 is_rx_queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ).is_queue_started<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not queue_started:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to start {port_type} {queue_id} on port {port_id}:\n{start_cmd_ou=
tput}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to start {port_type} {queue_id} on port {port_id}&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def get_queue_ring_size(self, port_id: int, queue_id: int, i=
s_rx_queue: bool) -&gt; int:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the current size of =
the ring on the specified queue.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show {&#39;rxq&#39; if is_r=
x_queue else &#39;txq&#39;} info {port_id} {queue_id}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_info =3D TestPmdQueueInfo.parse(self.sen=
d_command(command))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return queue_info.ring_size<br>
+<br>
+=C2=A0 =C2=A0 def set_queue_ring_size(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Update the ring size of an R=
x/Tx queue on a given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Queue is setup after setting the ring size so =
that the queue info reflects this change and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 it can be verified.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port that the queue=
 resides on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue on=
 the port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size: The size to update the rin=
g size to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Whether to modify a=
n RX or TX queue. If :data:`True` an RX queue will be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updated, otherwise=
 a TX queue will be updated.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to check the ring size of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the queue in an at=
tempt to validate that the size was changes properly.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and there is a failure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 when updating ring=
 size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_type =3D &quot;rxq&quot; if is_rx_queue =
else &quot;txq&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config {port_id}=
 {queue_type} {queue_id} ring_size {size}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_port_queue(port_id, queue_id, is_rx=
_queue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_ring_size =3D self.get_queu=
e_ring_size(port_id, queue_id, is_rx_queue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if curr_ring_size !=3D size:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed up update ring size of queue {queue_id} on port {port_id}. Curren=
t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot; ring size is {curr_ring_size}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to update ring size of queue {queue_id} on port {port_id}&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_queue_deferred_start(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, on: bool<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the deferred start attri=
bute of the specified queue on/off.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port that the queue=
 resides on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue on=
 the port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Whether to modify a=
n RX or TX queue. If :data:`True` an RX queue will be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updated, otherwise=
 a TX queue will be updated.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: Whether to set deferred star=
t mode on or off. If :data:`True` deferred start will<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be turned on, othe=
rwise it will be turned off.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_type =3D &quot;rxq&quot; if is_rx_queue =
else &quot;txq&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot;on&quot; if on else &quot;off=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port {port_id} {queue=
_type} {queue_id} deferred_start {action}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def _update_capabilities_from_flag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag_class: type[Flag],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_flags: Flag,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Divide all flags from `flag_=
class` into supported and unsupported.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flag in flag_class:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if flag in supported_flags:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer" =
target=3D"_blank">flag.name</a>)])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer=
" target=3D"_blank">flag.name</a>)])<br>
+<br>
+=C2=A0 =C2=A0 @_requires_started_ports<br>
+=C2=A0 =C2=A0 def get_capabilities_rxq_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all rxq capabilities and=
 divide them into supported and unsupported.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting rxq capabilit=
ies.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show rxq info {self.ports[0=
].id} 0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq_info =3D TestPmdRxqInfo.parse(self.send_co=
mmand(command))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if rxq_info.scattered_packets:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.SCATTERED_RX_ENABLED)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.SCATTERED_RX_ENABLED)<br>
+<br>
+=C2=A0 =C2=A0 def get_capabilities_show_port_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all capabilities from sh=
ow port info and divide them into supported and unsupported.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_flag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceCapabilitiesFlag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports[0].device_capabilitie=
s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def get_capabilities_mcast_filtering(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get multicast filtering capa=
bility from mcast_addr add and check for testpmd error code.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting mcast filter =
capabilities.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;mcast_addr add {self.ports[=
0].id} 01:00:5E:00:00:00&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(command)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;diag=3D-95&quot; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.MCAST_FILTERING)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.MCAST_FILTERING)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D str.replace(command,=
 &quot;add&quot;, &quot;remove&quot;, 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(command)<br>
+<br>
+=C2=A0 =C2=A0 def get_capabilities_flow_ctrl(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get flow control capability =
and check for testpmd failure.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting flow ctrl cap=
abilities.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {self.ports[0].id=
} flow_ctrl&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(command)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow control infos&quot; in output:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.FLOW_CTRL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.FLOW_CTRL)<br>
+<br>
+=C2=A0 =C2=A0 def get_capabilities_physical_function(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Store capability representin=
g a physical function test run.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.topology.vf_ports =3D=3D []:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.PHYSICAL_FUNCTION)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.PHYSICAL_FUNCTION)<br>
diff --git a/dts/framework/params/testpmd.py b/dts/api/testpmd/config.py<br=
>
similarity index 98%<br>
rename from dts/framework/params/testpmd.py<br>
rename to dts/api/testpmd/config.py<br>
index 1913bd0fa2..e71a3e1ef0 100644<br>
--- a/dts/framework/params/testpmd.py<br>
+++ b/dts/api/testpmd/config.py<br>
@@ -1,7 +1,12 @@<br>
=C2=A0# SPDX-License-Identifier: BSD-3-Clause<br>
=C2=A0# Copyright(c) 2024 Arm Limited<br>
<br>
-&quot;&quot;&quot;Module containing all the TestPmd-related parameter clas=
ses.&quot;&quot;&quot;<br>
+&quot;&quot;&quot;Module containing all classes needed to configure :class=
:`TestPmd`.<br>
+<br>
+This module defines the :class:`TestPmdParams` class which is used to conf=
igure the<br>
+TestPmd shell. It also includes various data classes and enums that are us=
ed<br>
+to represent different configurations and settings.<br>
+&quot;&quot;&quot;<br>
<br>
=C2=A0from dataclasses import dataclass, field<br>
=C2=A0from enum import EnumMeta, Flag, auto, unique<br>
@@ -146,7 +151,7 @@ class RSSSetting(EnumMeta):<br>
<br>
<br>
=C2=A0class SimpleForwardingModes(StrEnum):<br>
-=C2=A0 =C2=A0 r&quot;&quot;&quot;The supported packet forwarding modes for=
 :class:`~TestPmdShell`\s.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 r&quot;&quot;&quot;The supported packet forwarding modes for=
 :class:`~TestPmd`\s.&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
=C2=A0 =C2=A0 =C2=A0io =3D auto()<br>
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py<br>
new file mode 100644<br>
index 0000000000..553438c904<br>
--- /dev/null<br>
+++ b/dts/api/testpmd/types.py<br>
@@ -0,0 +1,1406 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2023 University of New Hampshire<br>
+# Copyright(c) 2023 PANTHEON.tech s.r.o.<br>
+# Copyright(c) 2024 Arm Limited<br>
+<br>
+&quot;&quot;&quot;TestPmd types module.<br>
+<br>
+Exposes types used in the TestPmd API.<br>
+&quot;&quot;&quot;<br>
+<br>
+import re<br>
+from dataclasses import dataclass, field<br>
+from enum import Flag, auto<br>
+from typing import Literal<br>
+<br>
+from typing_extensions import Self<br>
+<br>
+from framework.parser import ParserFn, TextParser<br>
+from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum<br>
+<br>
+<br>
+class TestPmdDevice:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The data of a device that testpmd can reco=
gnize.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_address: The PCI address of the device.<br=
>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 pci_address: str<br>
+<br>
+=C2=A0 =C2=A0 def __init__(self, pci_address_line: str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the device from t=
he testpmd output line string.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_address_line: A line of test=
pmd output that contains a device.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pci_address =3D pci_address_line.strip().=
split(&quot;: &quot;)[1].strip()<br>
+<br>
+=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The PCI address captures wha=
t the device is.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.pci_address<br>
+<br>
+<br>
+class VLANOffloadFlag(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the VLAN offload setting=
s of a NIC port.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 FILTER =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 QINQ_STRIP =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_str_dict(cls, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes an instance from a dic=
t containing the flag member names with an &quot;on&quot; value.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d: A dictionary containing the f=
lag members as keys and any string value.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A new instance of the flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in cls.__members__:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.get(name) =3D=3D &quot;on&q=
uot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[name=
]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;VLAN offloa=
d:\s+&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;strip (?P&l=
t;STRIP&gt;on|off), &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;filter (?P&=
lt;FILTER&gt;on|off), &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;extend (?P&=
lt;EXTEND&gt;on|off), &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;qinq strip =
(?P&lt;QINQ_STRIP&gt;on|off)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re.MULTILINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 named=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_str_dict,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+class ChecksumOffloadOptions(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing checksum hardware offloa=
d layer options.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ip =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 udp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tcp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 sctp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 outer_ip =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 outer_udp =3D auto()<br>
+<br>
+<br>
+class RSSOffloadTypesFlag(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the RSS offload flow typ=
es supported by the NIC port.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_frag =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_tcp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_udp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_sctp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_other =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_frag =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_tcp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_udp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_sctp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_other =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2_payload =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_ex =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_tcp_ex =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_udp_ex =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 port =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 vxlan =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 geneve =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 nvgre =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_22 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 gtpu =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 eth =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 s_vlan =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 c_vlan =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 esp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ah =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2tpv3 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 pfcp =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 pppoe =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ecpri =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 mpls =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv4_chksum =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l4_chksum =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2tpv2 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ipv6_flow_label =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_38 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_39 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_40 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_41 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_42 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_43 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_44 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_45 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_46 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_47 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_48 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_49 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_50 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_defined_51 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre96 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre64 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre56 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre48 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre40 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_pre32 =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2_dst_only =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2_src_only =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l4_dst_only =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l4_src_only =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_dst_only =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_src_only =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ip =3D ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ip=
v6_other | ipv6_ex<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 udp =3D ipv4_udp | ipv6_udp | ipv6_udp_ex<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tcp =3D ipv4_tcp | ipv6_tcp | ipv6_tcp_ex<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 sctp =3D ipv4_sctp | ipv6_sctp<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tunnel =3D vxlan | geneve | nvgre<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 vlan =3D s_vlan | c_vlan<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 all =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | vlan<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | tcp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | udp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | sctp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2_payload<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2tpv3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | esp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ah<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | pfcp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | gtpu<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ecpri<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | mpls<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2tpv2<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(r&quot;Supported=
 RSS offload flow types:((?:\r?\n?=C2=A0 \S+)+)&quot;, re.MULTILINE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSSOffloadTypesFlag.from_list_st=
ring,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+class DeviceCapabilitiesFlag(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the device capabilities.=
&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Device supports Rx queue setup after device started.<br>
+=C2=A0 =C2=A0 RUNTIME_RX_QUEUE_SETUP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Tx queue setup after device started.<br>
+=C2=A0 =C2=A0 RUNTIME_TX_QUEUE_SETUP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports shared Rx queue among ports within Rx dom=
ain and switch domain.<br>
+=C2=A0 =C2=A0 RXQ_SHARE =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports keeping flow rules across restart.<br>
+=C2=A0 =C2=A0 FLOW_RULE_KEEP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports keeping shared flow objects across restar=
t.<br>
+=C2=A0 =C2=A0 FLOW_SHARED_OBJECT_KEEP =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find_int(r&quot;Devic=
e capabilities: (0x[A-Fa-f\d]+)&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+class DeviceErrorHandlingMode(StrEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Enum representing the device error handlin=
g mode.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 none =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 passive =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 proactive =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 unknown =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this enum from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;=
Device error handling mode: (\w+)&quot;), cls)<br>
+<br>
+<br>
+class RxQueueState(StrEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RX queue states.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/ethdev/rte_ethdev.h``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:get_queue_state_name()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 stopped =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 started =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 hairpin =3D auto()<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 unknown =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this enum from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;=
Rx queue state: ([^\r\n]+)&quot;), cls)<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdQueueInfo(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Dataclass representation of the common par=
ts of the testpmd `show rxq/txq info` commands.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 prefetch_threshold: int =3D field(metadata=3DTextParser.find=
_int(r&quot;prefetch threshold: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 host_threshold: int =3D field(metadata=3DTextParser.find_int=
(r&quot;host threshold: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 writeback_threshold: int =3D field(metadata=3DTextParser.fin=
d_int(r&quot;writeback threshold: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 free_threshold: int =3D field(metadata=3DTextParser.find_int=
(r&quot;free threshold: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 deferred_start: bool =3D field(metadata=3DTextParser.find(&q=
uot;deferred start: on&quot;))<br>
+=C2=A0 =C2=A0 #: The number of RXD/TXDs is just the ring size of the queue=
.<br>
+=C2=A0 =C2=A0 ring_size: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;Number of (?:RXDs|TXDs): (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_queue_started: bool =3D field(metadata=3DTextParser.find(=
&quot;queue state: started&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 burst_mode: str | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Burst mode: ([^\r\n]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdTxqInfo(TestPmdQueueInfo):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Representation of testpmd&#39;s ``show txq=
 info &lt;port_id&gt; &lt;queue_id&gt;`` command.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_showqueue()``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:rx_queue_infos_display()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Ring size threshold<br>
+=C2=A0 =C2=A0 rs_threshold: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;TX RS threshold: (\d+)\b&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdRxqInfo(TestPmdQueueInfo):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Representation of testpmd&#39;s ``show rxq=
 info &lt;port_id&gt; &lt;queue_id&gt;`` command.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_showqueue()``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:rx_queue_infos_display()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Mempool used by that queue<br>
+=C2=A0 =C2=A0 mempool: str | None =3D field(default=3DNone, metadata=3DTex=
tParser.find(r&quot;Mempool: ([^\r\n]+)&quot;))<br>
+=C2=A0 =C2=A0 #: Drop packets if no descriptors are available<br>
+=C2=A0 =C2=A0 drop_packets: bool | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;RX drop packets: on&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Scattered packets Rx enabled<br>
+=C2=A0 =C2=A0 scattered_packets: bool | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;RX scattered packets: on&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: The state of the queue<br>
+=C2=A0 =C2=A0 queue_state: str | None =3D field(default=3DNone, metadata=
=3DRxQueueState.make_parser())<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdPort(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Dataclass representing the result of testp=
md&#39;s ``show port info`` command.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @staticmethod<br>
+=C2=A0 =C2=A0 def _make_device_private_info_parser() -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Device private information p=
arser.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Ensures that we are not parsing invalid device=
 private info output.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a parser<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 function that pars=
es the device private info from the TestPmd port info output.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _validate(info: str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D info.strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D=3D &quot;=
none&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or info.startswith=
(&quot;Invalid file&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or info.startswith=
(&quot;Failed to dump&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return info<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;=
Device private info:\s+([\s\S]+)&quot;), _validate)<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 id: int =3D field(metadata=3DTextParser.find_int(r&quot;Info=
s for port (\d+)\b&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 device_name: str =3D field(metadata=3DTextParser.find(r&quot=
;Device name: ([^\r\n]+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 driver_name: str =3D field(metadata=3DTextParser.find(r&quot=
;Driver name: ([^\r\n]+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 socket_id: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;Connect to socket: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_link_up: bool =3D field(metadata=3DTextParser.find(&quot;=
Link status: up&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 link_speed: str =3D field(metadata=3DTextParser.find(r&quot;=
Link speed: ([^\r\n]+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_link_full_duplex: bool =3D field(metadata=3DTextParser.fi=
nd(&quot;Link duplex: full-duplex&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_link_autonegotiated: bool =3D field(metadata=3DTextParser=
.find(&quot;Autoneg status: On&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_promiscuous_mode_enabled: bool =3D field(metadata=3DTextP=
arser.find(&quot;Promiscuous mode: enabled&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 is_allmulticast_mode_enabled: bool =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find(&quot;Allmulticast =
mode: enabled&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Maximum number of MAC addresses<br>
+=C2=A0 =C2=A0 max_mac_addresses_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of MAC addresses: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Maximum configurable length of RX packet<br>
+=C2=A0 =C2=A0 max_hash_mac_addresses_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of MAC addresses of hash filtering: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Minimum size of RX buffer<br>
+=C2=A0 =C2=A0 min_rx_bufsize: int =3D field(metadata=3DTextParser.find_int=
(r&quot;Minimum size of RX buffer: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Maximum configurable length of RX packet<br>
+=C2=A0 =C2=A0 max_rx_packet_length: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
configurable length of RX packet: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Maximum configurable size of LRO aggregated packet<br>
+=C2=A0 =C2=A0 max_lro_packet_size: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
configurable size of LRO aggregated packet: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #: Current number of RX queues<br>
+=C2=A0 =C2=A0 rx_queues_num: int =3D field(metadata=3DTextParser.find_int(=
r&quot;Current number of RX queues: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Max possible RX queues<br>
+=C2=A0 =C2=A0 max_rx_queues_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;Max possible RX queues: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Max possible number of RXDs per queue<br>
+=C2=A0 =C2=A0 max_queue_rxd_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max poss=
ible number of RXDs per queue: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Min possible number of RXDs per queue<br>
+=C2=A0 =C2=A0 min_queue_rxd_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Min poss=
ible number of RXDs per queue: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: RXDs number alignment<br>
+=C2=A0 =C2=A0 rxd_alignment_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;RXDs number alignment: (\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #: Current number of TX queues<br>
+=C2=A0 =C2=A0 tx_queues_num: int =3D field(metadata=3DTextParser.find_int(=
r&quot;Current number of TX queues: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Max possible TX queues<br>
+=C2=A0 =C2=A0 max_tx_queues_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;Max possible TX queues: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Max possible number of TXDs per queue<br>
+=C2=A0 =C2=A0 max_queue_txd_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max poss=
ible number of TXDs per queue: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Min possible number of TXDs per queue<br>
+=C2=A0 =C2=A0 min_queue_txd_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Min poss=
ible number of TXDs per queue: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: TXDs number alignment<br>
+=C2=A0 =C2=A0 txd_alignment_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;TXDs number alignment: (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Max segment number per packet<br>
+=C2=A0 =C2=A0 max_packet_segment_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max segm=
ent number per packet: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Max segment number per MTU/TSO<br>
+=C2=A0 =C2=A0 max_mtu_segment_num: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max segm=
ent number per MTU\/TSO: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 device_capabilities: DeviceCapabilitiesFlag =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DDeviceCapabilitiesFlag.make_parser(=
),<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 device_error_handling_mode: DeviceErrorHandlingMode | None =
=3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DDeviceErrorHandling=
Mode.make_parser()<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 device_private_info: str | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3D_make_device_private_info_parser(),=
<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 hash_key_size: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Hash key size in bytes: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 redirection_table_size: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Redirection table size: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 supported_rss_offload_flow_types: RSSOffloadTypesFlag =3D fi=
eld(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DRSSOffloadTypesFlag(0), metadata=3DR=
SSOffloadTypesFlag.make_parser()<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 mac_address: str | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;MAC address: ([A-Fa-f0-9:]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 fw_version: str | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Firmware-version: ([^\r\n]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 dev_args: str | None =3D field(default=3DNone, metadata=3DTe=
xtParser.find(r&quot;Devargs: ([^\r\n]+)&quot;))<br>
+=C2=A0 =C2=A0 #: Socket id of the memory allocation<br>
+=C2=A0 =C2=A0 mem_alloc_socket_id: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;memory a=
llocation on the socket: (\d+)&quot;),<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 mtu: int | None =3D field(default=3DNone, metadata=3DTextPar=
ser.find_int(r&quot;MTU: (\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 vlan_offload: VLANOffloadFlag | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DVLANOffloadFlag.make_parser(),<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #: Maximum size of RX buffer<br>
+=C2=A0 =C2=A0 max_rx_bufsize: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum size of RX buffer: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Maximum number of VFs<br>
+=C2=A0 =C2=A0 max_vfs_num: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VFs: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Maximum number of VMDq pools<br>
+=C2=A0 =C2=A0 max_vmdq_pools_num: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VMDq pools: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 switch_name: str | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Switch name: ([\r\n]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 switch_domain_id: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch domain Id: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 switch_port_id: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch Port Id: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 switch_rx_domain: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch Rx domain: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdPortStats(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Port statistics.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;NIC statistics for port (\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_packets: int =3D field(metadata=3DTextParser.find_int(r&q=
uot;RX-packets:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_missed: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-missed:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_bytes: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;RX-bytes:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_errors: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-errors:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_nombuf: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-nombuf:\s+(\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tx_packets: int =3D field(metadata=3DTextParser.find_int(r&q=
uot;TX-packets:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tx_errors: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;TX-errors:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tx_bytes: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;TX-bytes:\s+(\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Rx-pps:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 rx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Rx-bps:\s+(\d+)&quot;))<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Tx-pps:\s+(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 tx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Tx-bps:\s+(\d+)&quot;))<br>
+<br>
+<br>
+@dataclass(kw_only=3DTrue)<br>
+class FlowRule:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class representation of flow rule paramete=
rs.<br>
+<br>
+=C2=A0 =C2=A0 This class represents the parameters of any flow rule as per=
 the<br>
+=C2=A0 =C2=A0 following pattern:<br>
+<br>
+=C2=A0 =C2=A0 [group {group_id}] [priority {level}] [ingress] [egress]<br>
+=C2=A0 =C2=A0 [user_id {user_id}] pattern {item} [/ {item} [...]] / end<br=
>
+=C2=A0 =C2=A0 actions {action} [/ {action} [...]] / end<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 group_id: int | None =3D None<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 priority_level: int | None =3D None<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 direction: Literal[&quot;ingress&quot;, &quot;egress&quot;]<=
br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 user_id: int | None =3D None<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 pattern: list[str]<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 actions: list[str]<br>
+<br>
+=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the string represent=
ation of this instance.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D &quot; / &quot;.join(self.pattern)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot; / &quot;.join(self.actions)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.group_id is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;group {self.grou=
p_id} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.priority_level is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;priority {self.p=
riority_level} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;{self.direction} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.user_id is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;user_id {self.us=
er_id} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;pattern {pattern} / end &quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;actions {action} / end&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret<br>
+<br>
+<br>
+class PacketOffloadFlag(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the Packet Offload Featu=
res Flags in DPDK.<br>
+<br>
+=C2=A0 =C2=A0 Values in this class are taken from the definitions in the R=
TE MBUF core library in DPDK<br>
+=C2=A0 =C2=A0 located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that=
 flag values in this class will<br>
+=C2=A0 =C2=A0 match the values they are set to in said DPDK library with o=
ne exception; all values must be<br>
+=C2=A0 =C2=A0 unique. For example, the definitions for unknown checksum fl=
ags in ``rte_mbuf_core.h`` are all<br>
+=C2=A0 =C2=A0 set to :data:`0`, but it is valuable to distinguish between =
them in this framework. For this<br>
+=C2=A0 =C2=A0 reason flags that are not unique in the DPDK library are set=
 either to values within the<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or s=
hifted 61+ bits for Tx.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/mbuf/rte_mbuf_core.h``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 # RX flags<br>
+<br>
+=C2=A0 =C2=A0 #: The RX packet is a 802.1q VLAN packet, and the tci has be=
en saved in mbuf-&gt;vlan_tci. If the<br>
+=C2=A0 =C2=A0 #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLA=
N header has been stripped from<br>
+=C2=A0 =C2=A0 #: mbuf data, else it is still present.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_VLAN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: RX packet with RSS hash result.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_RSS_HASH =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: RX packet with FDIR match indicate.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: This flag is set when the outermost IP header checksum is=
 detected as wrong by the hardware.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD =3D 1 &lt;&lt; 5<br>
+<br>
+=C2=A0 =C2=A0 #: A vlan has been stripped by the hardware and its tci is s=
aved in mbuf-&gt;vlan_tci. This can<br>
+=C2=A0 =C2=A0 #: only happen if vlan stripping is enabled in the RX config=
uration of the PMD. When<br>
+=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN mu=
st also be set.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_VLAN_STRIPPED =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: No information about the RX IP checksum. Value is 0 in th=
e DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN =3D 1 &lt;&lt; 23<br>
+=C2=A0 =C2=A0 #: The IP checksum in the packet is wrong.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_BAD =3D 1 &lt;&lt; 4<br>
+=C2=A0 =C2=A0 #: The IP checksum in the packet is valid.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_GOOD =3D 1 &lt;&lt; 7<br>
+=C2=A0 =C2=A0 #: The IP checksum is not correct in the packet data, but th=
e integrity of the IP header is<br>
+=C2=A0 =C2=A0 #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_=
F_RX_IP_CKSUM_GOOD in the DPDK<br>
+=C2=A0 =C2=A0 #: library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_NONE =3D 1 &lt;&lt; 24<br>
+<br>
+=C2=A0 =C2=A0 #: No information about the RX L4 checksum. Value is 0 in th=
e DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN =3D 1 &lt;&lt; 25<br>
+=C2=A0 =C2=A0 #: The L4 checksum in the packet is wrong.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_BAD =3D 1 &lt;&lt; 3<br>
+=C2=A0 =C2=A0 #: The L4 checksum in the packet is valid.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_GOOD =3D 1 &lt;&lt; 8<br>
+=C2=A0 =C2=A0 #: The L4 checksum is not correct in the packet data, but th=
e integrity of the L4 data is<br>
+=C2=A0 =C2=A0 #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_=
F_RX_L4_CKSUM_GOOD in the DPDK<br>
+=C2=A0 =C2=A0 #: library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_NONE =3D 1 &lt;&lt; 26<br>
+<br>
+=C2=A0 =C2=A0 #: RX IEEE1588 L2 Ethernet PT Packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IEEE1588_PTP =3D 1 &lt;&lt; 9<br>
+=C2=A0 =C2=A0 #: RX IEEE1588 L2/L4 timestamped packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_IEEE1588_TMST =3D 1 &lt;&lt; 10<br>
+<br>
+=C2=A0 =C2=A0 #: FD id reported if FDIR match.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR_ID =3D 1 &lt;&lt; 13<br>
+=C2=A0 =C2=A0 #: Flexible bytes reported if FDIR match.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR_FLX =3D 1 &lt;&lt; 14<br>
+<br>
+=C2=A0 =C2=A0 #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLA=
N_STRIPPED are set, the 2 VLANs<br>
+=C2=A0 =C2=A0 #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ=
_STRIPPED is set and<br>
+=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN=
 is removed from packet data.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_QINQ_STRIPPED =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: When packets are coalesced by a hardware or virtual drive=
r, this flag can be set in the RX<br>
+=C2=A0 =C2=A0 #: mbuf, meaning that the m-&gt;tso_segsz field is valid and=
 is set to the segment size of<br>
+=C2=A0 =C2=A0 #: original packets.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_LRO =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: Indicate that security offload processing was applied on =
the RX packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_SEC_OFFLOAD =3D 1 &lt;&lt; 18<br>
+=C2=A0 =C2=A0 #: Indicate that security offload processing failed on the R=
X packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: The RX packet is a double VLAN. If this flag is set, RTE_=
MBUF_F_RX_VLAN must also be set. If<br>
+=C2=A0 =C2=A0 #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, bot=
h VLANs headers have been stripped<br>
+=C2=A0 =C2=A0 #: from mbuf data, else they are still present.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_QINQ =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: No info about the outer RX L4 checksum. Value is 0 in the=
 DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN =3D 1 &lt;&lt; 27<br>
+=C2=A0 =C2=A0 #: The outer L4 checksum in the packet is wrong<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD =3D 1 &lt;&lt; 21<br>
+=C2=A0 =C2=A0 #: The outer L4 checksum in the packet is valid<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD =3D 1 &lt;&lt; 22<br>
+=C2=A0 =C2=A0 #: Invalid outer L4 checksum state. Value is<br>
+=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4=
_CKSUM_GOOD in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID =3D 1 &lt;&lt; 28<br>
+<br>
+=C2=A0 =C2=A0 # TX flags<br>
+<br>
+=C2=A0 =C2=A0 #: Outer UDP checksum offload flag. This flag is used for en=
abling outer UDP checksum in PMD.<br>
+=C2=A0 =C2=A0 #: To use outer UDP checksum, the user either needs to enabl=
e the following in mbuf:<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 #:=C2=A0 a) Fill outer_l2_len and outer_l3_len in mbuf.<br>
+=C2=A0 =C2=A0 #:=C2=A0 b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.<br>
+=C2=A0 =C2=A0 #:=C2=A0 c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_T=
X_OUTER_IPV6 flag.<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload f=
lag.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_UDP_CKSUM =3D 1 &lt;&lt; 41<br>
+<br>
+=C2=A0 =C2=A0 #: UDP Fragmentation Offload flag. This flag is used for ena=
bling UDP fragmentation in SW or in<br>
+=C2=A0 =C2=A0 #: HW.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_UDP_SEG =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: Request security offload processing on the TX packet. To =
use Tx security offload, the user<br>
+=C2=A0 =C2=A0 #: needs to fill l2_len in mbuf indicating L2 header size an=
d where L3 header starts.<br>
+=C2=A0 =C2=A0 #: Similarly, l3_len should also be filled along with ol_fla=
gs reflecting current L3 type.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_SEC_OFFLOAD =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: Offload the MACsec. This flag must be set by the applicat=
ion to enable this offload feature<br>
+=C2=A0 =C2=A0 #: for a packet to be transmitted.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_MACSEC =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Bits 45:48 are used for the tunnel type in ``lib/mbuf/rte_=
mbuf_core.h``, but some are modified<br>
+=C2=A0 =C2=A0 # in this Flag to maintain uniqueness. The tunnel type must =
be specified for TSO or checksum on<br>
+=C2=A0 =C2=A0 # the inner part of tunnel packets. These flags can be used =
with RTE_MBUF_F_TX_TCP_SEG for TSO,<br>
+=C2=A0 =C2=A0 # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and =
outer header lengths are required:<br>
+=C2=A0 =C2=A0 # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso=
_segsz for TSO.<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_VXLAN =3D 1 &lt;&lt; 45<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GRE =3D 1 &lt;&lt; 46<br>
+=C2=A0 =C2=A0 #: Value is 3 &lt;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_IPIP =3D 1 &lt;&lt; 61<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GENEVE =3D 1 &lt;&lt; 47<br>
+=C2=A0 =C2=A0 #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 &l=
t;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_MPLSINUDP =3D 1 &lt;&lt; 62<br>
+=C2=A0 =C2=A0 #: Value is 6 &lt;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE =3D 1 &lt;&lt; 63<br>
+=C2=A0 =C2=A0 #: Value is 7 &lt;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GTP =3D 1 &lt;&lt; 64<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_ESP =3D 1 &lt;&lt; 48<br>
+=C2=A0 =C2=A0 #: Generic IP encapsulated tunnel type, used for TSO and che=
cksum offload. This can be used for<br>
+=C2=A0 =C2=A0 #: tunnels which are not standards or listed above. It is pr=
eferred to use specific tunnel<br>
+=C2=A0 =C2=A0 #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNN=
EL_IPIP if possible. The ethdev<br>
+=C2=A0 =C2=A0 #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.=C2=
=A0 Outer and inner checksums are done<br>
+=C2=A0 =C2=A0 #: according to the existing flags like RTE_MBUF_F_TX_xxx_CK=
SUM. Specific tunnel headers that<br>
+=C2=A0 =C2=A0 #: contain payload length, sequence id or checksum are not e=
xpected to be updated. Value is<br>
+=C2=A0 =C2=A0 #: 0xD &lt;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_IP =3D 1 &lt;&lt; 65<br>
+=C2=A0 =C2=A0 #: Generic UDP encapsulated tunnel type, used for TSO and ch=
ecksum offload. UDP tunnel type<br>
+=C2=A0 =C2=A0 #: implies outer IP layer. It can be used for tunnels which =
are not standards or listed above.<br>
+=C2=A0 =C2=A0 #: It is preferred to use specific tunnel flags like RTE_MBU=
F_F_TX_TUNNEL_VXLAN if possible.<br>
+=C2=A0 =C2=A0 #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP=
_TNL_TSO. Outer and inner checksums<br>
+=C2=A0 =C2=A0 #: are done according to the existing flags like RTE_MBUF_F_=
TX_xxx_CKSUM. Specific tunnel<br>
+=C2=A0 =C2=A0 #: headers that contain payload length, sequence id or check=
sum are not expected to be updated.<br>
+=C2=A0 =C2=A0 #: value is 0xE &lt;&lt; 45 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_UDP =3D 1 &lt;&lt; 66<br>
+<br>
+=C2=A0 =C2=A0 #: Double VLAN insertion (QinQ) request to driver, driver ma=
y offload the insertion based on<br>
+=C2=A0 =C2=A0 #: device capability. Mbuf &#39;vlan_tci&#39; &amp; &#39;vla=
n_tci_outer&#39; must be valid when this flag is set.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_QINQ =3D 1 &lt;&lt; 49<br>
+<br>
+=C2=A0 =C2=A0 #: TCP segmentation offload. To enable this offload feature =
for a packet to be transmitted on<br>
+=C2=A0 =C2=A0 #: hardware supporting TSO:<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 #:=C2=A0 - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf-&gt;ol=
_flags (this flag implies<br>
+=C2=A0 =C2=A0 #:=C2=A0 =C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_CKSUM)<br>
+=C2=A0 =C2=A0 #:=C2=A0 - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_=
IPV6<br>
+=C2=A0 =C2=A0 #:=C2=A0 =C2=A0 =C2=A0 * if it&#39;s IPv4, set the RTE_MBUF_=
F_TX_IP_CKSUM flag<br>
+=C2=A0 =C2=A0 #:=C2=A0 - fill the mbuf offload information: l2_len, l3_len=
, l4_len, tso_segsz<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_SEG =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: TX IEEE1588 packet to timestamp.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_IEEE1588_TMST =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Bits 52+53 used for L4 packet type with checksum enabled i=
n ``lib/mbuf/rte_mbuf_core.h`` but<br>
+=C2=A0 =C2=A0 # some values must be modified in this framework to maintain=
 uniqueness. To use hardware<br>
+=C2=A0 =C2=A0 # L4 checksum offload, the user needs to:<br>
+=C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 # - fill l2_len and l3_len in mbuf<br>
+=C2=A0 =C2=A0 # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCT=
P_CKSUM or<br>
+=C2=A0 =C2=A0 #=C2=A0 =C2=A0RTE_MBUF_F_TX_UDP_CKSUM<br>
+=C2=A0 =C2=A0 # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6<br=
>
+<br>
+=C2=A0 =C2=A0 #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK librar=
y.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_L4_NO_CKSUM =3D 1 &lt;&lt; 67<br>
+=C2=A0 =C2=A0 #: TCP cksum of TX pkt. Computed by NIC.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_CKSUM =3D 1 &lt;&lt; 52<br>
+=C2=A0 =C2=A0 #: SCTP cksum of TX pkt. Computed by NIC.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_SCTP_CKSUM =3D 1 &lt;&lt; 53<br>
+=C2=A0 =C2=A0 #: UDP cksum of TX pkt. Computed by NIC. Value is 3 &lt;&lt;=
 52 in the DPDK library.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_UDP_CKSUM =3D 1 &lt;&lt; 68<br>
+<br>
+=C2=A0 =C2=A0 #: Offload the IP checksum in the hardware. The flag RTE_MBU=
F_F_TX_IPV4 should also be set by<br>
+=C2=A0 =C2=A0 #: the application, although a PMD will only check RTE_MBUF_=
F_TX_IP_CKSUM.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_IP_CKSUM =3D 1 &lt;&lt; 54<br>
+<br>
+=C2=A0 =C2=A0 #: Packet is IPv4. This flag must be set when using any offl=
oad feature (TSO, L3 or L4<br>
+=C2=A0 =C2=A0 #: checksum) to tell the NIC that the packet is an IPv4 pack=
et. If the packet is a tunneled<br>
+=C2=A0 =C2=A0 #: packet, this flag is related to the inner headers.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_IPV4 =3D auto()<br>
+=C2=A0 =C2=A0 #: Packet is IPv6. This flag must be set when using an offlo=
ad feature (TSO or L4 checksum) to<br>
+=C2=A0 =C2=A0 #: tell the NIC that the packet is an IPv6 packet. If the pa=
cket is a tunneled packet, this<br>
+=C2=A0 =C2=A0 #: flag is related to the inner headers.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_IPV6 =3D auto()<br>
+=C2=A0 =C2=A0 #: VLAN tag insertion request to driver, driver may offload =
the insertion based on the device<br>
+=C2=A0 =C2=A0 #: capability. mbuf &#39;vlan_tci&#39; field must be valid w=
hen this flag is set.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_VLAN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 #: Offload the IP checksum of an external header in the hard=
ware. The flag<br>
+=C2=A0 =C2=A0 #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the applic=
ation, although a PMD will only<br>
+=C2=A0 =C2=A0 #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Packet outer header is IPv4. This flag must be set when u=
sing any outer offload feature (L3<br>
+=C2=A0 =C2=A0 #: or L4 checksum) to tell the NIC that the outer header of =
the tunneled packet is an IPv4<br>
+=C2=A0 =C2=A0 #: packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IPV4 =3D auto()<br>
+=C2=A0 =C2=A0 #: Packet outer header is IPv6. This flag must be set when u=
sing any outer offload feature (L4<br>
+=C2=A0 =C2=A0 #: checksum) to tell the NIC that the outer header of the tu=
nneled packet is an IPv6 packet.<br>
+=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IPV6 =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(r&quot;ol_flags:=
 ([^\n]+)&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_list_string,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+class RtePTypes(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing possible packet types in=
 DPDK verbose output.<br>
+<br>
+=C2=A0 =C2=A0 Values in this class are derived from definitions in the RTE=
 MBUF ptype library in DPDK located<br>
+=C2=A0 =C2=A0 in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of=
 values in this class should match<br>
+=C2=A0 =C2=A0 the possible return options from the functions ``rte_get_pty=
pe_*_name`` in ``rte_mbuf_ptype.c``.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK ptype name formatting functions: ``lib/mb=
uf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 # L2<br>
+=C2=A0 =C2=A0 #: Ethernet packet type. This is used for outer packet for t=
unneling cases.<br>
+=C2=A0 =C2=A0 L2_ETHER =3D auto()<br>
+=C2=A0 =C2=A0 #: Ethernet packet type for time sync.<br>
+=C2=A0 =C2=A0 L2_ETHER_TIMESYNC =3D auto()<br>
+=C2=A0 =C2=A0 #: ARP (Address Resolution Protocol) packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_ARP =3D auto()<br>
+=C2=A0 =C2=A0 #: LLDP (Link Layer Discovery Protocol) packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_LLDP =3D auto()<br>
+=C2=A0 =C2=A0 #: NSH (Network Service Header) packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_NSH =3D auto()<br>
+=C2=A0 =C2=A0 #: VLAN packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_VLAN =3D auto()<br>
+=C2=A0 =C2=A0 #: QinQ packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_QINQ =3D auto()<br>
+=C2=A0 =C2=A0 #: PPPOE packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_PPPOE =3D auto()<br>
+=C2=A0 =C2=A0 #: FCoE packet type..<br>
+=C2=A0 =C2=A0 L2_ETHER_FCOE =3D auto()<br>
+=C2=A0 =C2=A0 #: MPLS packet type.<br>
+=C2=A0 =C2=A0 L2_ETHER_MPLS =3D auto()<br>
+=C2=A0 =C2=A0 #: No L2 packet information.<br>
+=C2=A0 =C2=A0 L2_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # L3<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and does not contain any header option.<br>
+=C2=A0 =C2=A0 L3_IPV4 =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and contains header options.<br>
+=C2=A0 =C2=A0 L3_IPV4_EXT =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and does not contain any extension header.<br>
+=C2=A0 =C2=A0 L3_IPV6 =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and may or maynot contain header options.<br>
+=C2=A0 =C2=A0 L3_IPV4_EXT_UNKNOWN =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and contains extension headers.<br>
+=C2=A0 =C2=A0 L3_IPV6_EXT =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases, and may or maynot contain extension headers.<br>
+=C2=A0 =C2=A0 L3_IPV6_EXT_UNKNOWN =3D auto()<br>
+=C2=A0 =C2=A0 #: No L3 packet information.<br>
+=C2=A0 =C2=A0 L3_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # L4<br>
+=C2=A0 =C2=A0 #: TCP (Transmission Control Protocol) packet type. This is =
used for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases.<br>
+=C2=A0 =C2=A0 L4_TCP =3D auto()<br>
+=C2=A0 =C2=A0 #: UDP (User Datagram Protocol) packet type. This is used fo=
r outer packet for tunneling cases.<br>
+=C2=A0 =C2=A0 L4_UDP =3D auto()<br>
+=C2=A0 =C2=A0 #: Fragmented IP (Internet Protocol) packet type. This is us=
ed for outer packet for tunneling<br>
+=C2=A0 =C2=A0 #: cases and refers to those packets of any IP types which c=
an be recognized as fragmented. A<br>
+=C2=A0 =C2=A0 #: fragmented packet cannot be recognized as any other L4 ty=
pes (RTE_PTYPE_L4_TCP,<br>
+=C2=A0 =C2=A0 #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP, R=
TE_PTYPE_L4_NONFRAG).<br>
+=C2=A0 =C2=A0 L4_FRAG =3D auto()<br>
+=C2=A0 =C2=A0 #: SCTP (Stream Control Transmission Protocol) packet type. =
This is used for outer packet for<br>
+=C2=A0 =C2=A0 #: tunneling cases.<br>
+=C2=A0 =C2=A0 L4_SCTP =3D auto()<br>
+=C2=A0 =C2=A0 #: ICMP (Internet Control Message Protocol) packet type. Thi=
s is used for outer packet for<br>
+=C2=A0 =C2=A0 #: tunneling cases.<br>
+=C2=A0 =C2=A0 L4_ICMP =3D auto()<br>
+=C2=A0 =C2=A0 #: Non-fragmented IP (Internet Protocol) packet type. This i=
s used for outer packet for<br>
+=C2=A0 =C2=A0 #: tunneling cases and refers to those packets of any IP typ=
es, that cannot be recognized as<br>
+=C2=A0 =C2=A0 #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4=
_UDP, RTE_PTYPE_L4_FRAG,<br>
+=C2=A0 =C2=A0 #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).<br>
+=C2=A0 =C2=A0 L4_NONFRAG =3D auto()<br>
+=C2=A0 =C2=A0 #: IGMP (Internet Group Management Protocol) packet type.<br=
>
+=C2=A0 =C2=A0 L4_IGMP =3D auto()<br>
+=C2=A0 =C2=A0 #: No L4 packet information.<br>
+=C2=A0 =C2=A0 L4_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Tunnel<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) in IP (Internet Protocol) tunnelin=
g packet type.<br>
+=C2=A0 =C2=A0 TUNNEL_IP =3D auto()<br>
+=C2=A0 =C2=A0 #: GRE (Generic Routing Encapsulation) tunneling packet type=
.<br>
+=C2=A0 =C2=A0 TUNNEL_GRE =3D auto()<br>
+=C2=A0 =C2=A0 #: VXLAN (Virtual eXtensible Local Area Network) tunneling p=
acket type.<br>
+=C2=A0 =C2=A0 TUNNEL_VXLAN =3D auto()<br>
+=C2=A0 =C2=A0 #: NVGRE (Network Virtualization using Generic Routing Encap=
sulation) tunneling packet type.<br>
+=C2=A0 =C2=A0 TUNNEL_NVGRE =3D auto()<br>
+=C2=A0 =C2=A0 #: GENEVE (Generic Network Virtualization Encapsulation) tun=
neling packet type.<br>
+=C2=A0 =C2=A0 TUNNEL_GENEVE =3D auto()<br>
+=C2=A0 =C2=A0 #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensibl=
e Local Area Network) or GRE<br>
+=C2=A0 =C2=A0 #: (Generic Routing Encapsulation) could be recognized as th=
is packet type, if they can not be<br>
+=C2=A0 =C2=A0 #: recognized independently as of hardware capability.<br>
+=C2=A0 =C2=A0 TUNNEL_GRENAT =3D auto()<br>
+=C2=A0 =C2=A0 #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet=
 type.<br>
+=C2=A0 =C2=A0 TUNNEL_GTPC =3D auto()<br>
+=C2=A0 =C2=A0 #: GTP-U (GPRS Tunnelling Protocol) user data tunneling pack=
et type.<br>
+=C2=A0 =C2=A0 TUNNEL_GTPU =3D auto()<br>
+=C2=A0 =C2=A0 #: ESP (IP Encapsulating Security Payload) tunneling packet =
type.<br>
+=C2=A0 =C2=A0 TUNNEL_ESP =3D auto()<br>
+=C2=A0 =C2=A0 #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.<=
br>
+=C2=A0 =C2=A0 TUNNEL_L2TP =3D auto()<br>
+=C2=A0 =C2=A0 #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling pa=
cket type.<br>
+=C2=A0 =C2=A0 TUNNEL_VXLAN_GPE =3D auto()<br>
+=C2=A0 =C2=A0 #: MPLS-in-UDP tunneling packet type (RFC 7510).<br>
+=C2=A0 =C2=A0 TUNNEL_MPLS_IN_UDP =3D auto()<br>
+=C2=A0 =C2=A0 #: MPLS-in-GRE tunneling packet type (RFC 4023).<br>
+=C2=A0 =C2=A0 TUNNEL_MPLS_IN_GRE =3D auto()<br>
+=C2=A0 =C2=A0 #: No tunnel information found on the packet.<br>
+=C2=A0 =C2=A0 TUNNEL_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Inner L2<br>
+=C2=A0 =C2=A0 #: Ethernet packet type. This is used for inner packet type =
only.<br>
+=C2=A0 =C2=A0 INNER_L2_ETHER =3D auto()<br>
+=C2=A0 =C2=A0 #: Ethernet packet type with VLAN (Virtual Local Area Networ=
k) tag.<br>
+=C2=A0 =C2=A0 INNER_L2_ETHER_VLAN =3D auto()<br>
+=C2=A0 =C2=A0 #: QinQ packet type.<br>
+=C2=A0 =C2=A0 INNER_L2_ETHER_QINQ =3D auto()<br>
+=C2=A0 =C2=A0 #: No inner L2 information found on the packet.<br>
+=C2=A0 =C2=A0 INNER_L2_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Inner L3<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and does<br>
+=C2=A0 =C2=A0 #: not contain any header option.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV4 =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and<br>
+=C2=A0 =C2=A0 #: contains header options.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV4_EXT =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and does<br>
+=C2=A0 =C2=A0 #: not contain any extension header.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV6 =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and may or<br>
+=C2=A0 =C2=A0 #: may not contain header options.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV4_EXT_UNKNOWN =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and<br>
+=C2=A0 =C2=A0 #: contains extension headers.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV6_EXT =3D auto()<br>
+=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and may or<br>
+=C2=A0 =C2=A0 #: may not contain extension headers.<br>
+=C2=A0 =C2=A0 INNER_L3_IPV6_EXT_UNKNOWN =3D auto()<br>
+=C2=A0 =C2=A0 #: No inner L3 information found on the packet.<br>
+=C2=A0 =C2=A0 INNER_L3_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 # Inner L4<br>
+=C2=A0 =C2=A0 #: TCP (Transmission Control Protocol) packet type. This is =
used for inner packet only.<br>
+=C2=A0 =C2=A0 INNER_L4_TCP =3D auto()<br>
+=C2=A0 =C2=A0 #: UDP (User Datagram Protocol) packet type. This is used fo=
r inner packet only.<br>
+=C2=A0 =C2=A0 INNER_L4_UDP =3D auto()<br>
+=C2=A0 =C2=A0 #: Fragmented IP (Internet Protocol) packet type. This is us=
ed for inner packet only, and may<br>
+=C2=A0 =C2=A0 #: or maynot have a layer 4 packet.<br>
+=C2=A0 =C2=A0 INNER_L4_FRAG =3D auto()<br>
+=C2=A0 =C2=A0 #: SCTP (Stream Control Transmission Protocol) packet type. =
This is used for inner packet only.<br>
+=C2=A0 =C2=A0 INNER_L4_SCTP =3D auto()<br>
+=C2=A0 =C2=A0 #: ICMP (Internet Control Message Protocol) packet type. Thi=
s is used for inner packet only.<br>
+=C2=A0 =C2=A0 INNER_L4_ICMP =3D auto()<br>
+=C2=A0 =C2=A0 #: Non-fragmented IP (Internet Protocol) packet type. It is =
used for inner packet only, and may<br>
+=C2=A0 =C2=A0 #: or may not have other unknown layer 4 packet types.<br>
+=C2=A0 =C2=A0 INNER_L4_NONFRAG =3D auto()<br>
+=C2=A0 =C2=A0 #: No inner L4 information found on the packet.<br>
+=C2=A0 =C2=A0 INNER_L4_UNKNOWN =3D auto()<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_parser(cls, hw: bool) -&gt; ParserFn:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw: Whether to make a parser for=
 hardware ptypes or software ptypes. If :data:`True`,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hardware ptypes wi=
ll be collected, otherwise software pytpes will.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(f&quot;{&#39;hw&=
#39; if hw else &#39;sw&#39;} ptype: ([^-]+)&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_list_string,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdVerbosePacket(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Packet information provided by verbose out=
put in Testpmd.<br>
+<br>
+=C2=A0 =C2=A0 This dataclass expects that packet information be prepended =
with the starting line of packet<br>
+=C2=A0 =C2=A0 bursts. Specifically, the line that reads &quot;port X/queue=
 Y: sent/received Z packets&quot;.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: ID of the port that handled the packet.<br>
+=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;port (\d+)/queue \d+&quot;))<br>
+=C2=A0 =C2=A0 #: ID of the queue that handled the packet.<br>
+=C2=A0 =C2=A0 queue_id: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;port \d+/queue (\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Whether the packet was received or sent by the queue/port=
.<br>
+=C2=A0 =C2=A0 was_received: bool =3D field(metadata=3DTextParser.find(r&qu=
ot;received \d+ packets&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 src_mac: str =3D field(metadata=3DTextParser.find(f&quot;src=
=3D({REGEX_FOR_MAC_ADDRESS})&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 dst_mac: str =3D field(metadata=3DTextParser.find(f&quot;dst=
=3D({REGEX_FOR_MAC_ADDRESS})&quot;))<br>
+=C2=A0 =C2=A0 #: Memory pool the packet was handled on.<br>
+=C2=A0 =C2=A0 pool: str =3D field(metadata=3DTextParser.find(r&quot;pool=
=3D(\S+)&quot;))<br>
+=C2=A0 =C2=A0 #: Packet type in hex.<br>
+=C2=A0 =C2=A0 p_type: int =3D field(metadata=3DTextParser.find_int(r&quot;=
type=3D(0x[a-fA-F\d]+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 length: int =3D field(metadata=3DTextParser.find_int(r&quot;=
length=3D(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Number of segments in the packet.<br>
+=C2=A0 =C2=A0 nb_segs: int =3D field(metadata=3DTextParser.find_int(r&quot=
;nb_segs=3D(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #: Hardware packet type.<br>
+=C2=A0 =C2=A0 hw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_pars=
er(hw=3DTrue))<br>
+=C2=A0 =C2=A0 #: Software packet type.<br>
+=C2=A0 =C2=A0 sw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_pars=
er(hw=3DFalse))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l2_len: int =3D field(metadata=3DTextParser.find_int(r&quot;=
l2_len=3D(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 ol_flags: PacketOffloadFlag =3D field(metadata=3DPacketOfflo=
adFlag.make_parser())<br>
+=C2=A0 =C2=A0 #: RSS hash of the packet in hex.<br>
+=C2=A0 =C2=A0 rss_hash: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;RSS hash=3D(0x[a-fA-F\d]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: RSS queue that handled the packet in hex.<br>
+=C2=A0 =C2=A0 rss_queue: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;RSS queue=3D(0x[a-fA-F\d]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l3_len: int | None =3D field(default=3DNone, metadata=3DText=
Parser.find_int(r&quot;l3_len=3D(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l4_len: int | None =3D field(default=3DNone, metadata=3DText=
Parser.find_int(r&quot;l4_len=3D(\d+)&quot;))<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 l4_dport: int | None =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Destinat=
ion (?:TCP|UDP) port=3D(\d+)&quot;),<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+<br>
+class RxOffloadCapability(Flag):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Rx offload capabilities of a device.<br>
+<br>
+=C2=A0 =C2=A0 The flags are taken from ``lib/ethdev/rte_ethdev.h``.<br>
+=C2=A0 =C2=A0 They&#39;re prefixed with ``RTE_ETH_RX_OFFLOAD`` in ``lib/et=
hdev/rte_ethdev.h``<br>
+=C2=A0 =C2=A0 instead of ``RX_OFFLOAD``, which is what testpmd changes the=
 prefix to.<br>
+=C2=A0 =C2=A0 The values are not contiguous, so the correspondence is pres=
erved<br>
+=C2=A0 =C2=A0 by specifying concrete values interspersed between auto() va=
lues.<br>
+<br>
+=C2=A0 =C2=A0 The ``RX_OFFLOAD`` prefix has been preserved so that the sam=
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
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L3 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports Large Receive Offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports QinQ (queue in queue) offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports inner packet L3 checksum.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports MACsec.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports filtering of a VLAN Tag identifier.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER =3D 1 &lt;&lt; 9<br>
+=C2=A0 =C2=A0 #: Device supports VLAN offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports receiving segmented mbufs.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER =3D 1 &lt;&lt; 13<br>
+=C2=A0 =C2=A0 #: Device supports Timestamp.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports crypto processing while packet is receive=
d in NIC.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports CRC stripping.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports inner packet L4 checksum.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports RSS hashing.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
+=C2=A0 =C2=A0 #: Device supports all checksum capabilities.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_U=
DP_CKSUM | RX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 #: Device supports all VLAN capabilities.<br>
+=C2=A0 =C2=A0 RX_OFFLOAD_VLAN =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_FILTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_EXTEND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_QINQ_STRIP<br>
+=C2=A0 =C2=A0 )<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[f&quot;RX_OFFLOAD_=
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
+class RxOffloadCapabilities(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; rx_offload capabilities`` command.<br>
+<br>
+=C2=A0 =C2=A0 References:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa()``<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa_parsed()``<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #:<br>
+=C2=A0 =C2=A0 port_id: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Rx Offlo=
ading Capabilities of port (\d+) :&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Per-queue Rx offload capabilities.<br>
+=C2=A0 =C2=A0 per_queue: RxOffloadCapability =3D field(metadata=3DRxOffloa=
dCapability.make_parser(False))<br>
+=C2=A0 =C2=A0 #: Capabilities other than per-queue Rx offload capabilities=
.<br>
+=C2=A0 =C2=A0 per_port: RxOffloadCapability =3D field(metadata=3DRxOffload=
Capability.make_parser(True))<br>
+<br>
+<br>
+@dataclass<br>
+class TestPmdPortFlowCtrl(TextParser):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class representing a port&#39;s flow contr=
ol parameters.<br>
+<br>
+=C2=A0 =C2=A0 The parameters can also be parsed from the output of ``show =
port &lt;port_id&gt; flow_ctrl``.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 #: Enable Reactive Extensions.<br>
+=C2=A0 =C2=A0 rx: bool =3D field(default=3DFalse, metadata=3DTextParser.fi=
nd(r&quot;Rx pause: on&quot;))<br>
+=C2=A0 =C2=A0 #: Enable Transmit.<br>
+=C2=A0 =C2=A0 tx: bool =3D field(default=3DFalse, metadata=3DTextParser.fi=
nd(r&quot;Tx pause: on&quot;))<br>
+=C2=A0 =C2=A0 #: High threshold value to trigger XOFF.<br>
+=C2=A0 =C2=A0 high_water: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D0, metadata=3DTextParser.find_int(r&=
quot;High waterline: (0x[a-fA-F\d]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Low threshold value to trigger XON.<br>
+=C2=A0 =C2=A0 low_water: int =3D field(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D0, metadata=3DTextParser.find_int(r&=
quot;Low waterline: (0x[a-fA-F\d]+)&quot;)<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 #: Pause quota in the Pause frame.<br>
+=C2=A0 =C2=A0 pause_time: int =3D field(default=3D0, metadata=3DTextParser=
.find_int(r&quot;Pause time: (0x[a-fA-F\d]+)&quot;))<br>
+=C2=A0 =C2=A0 #: Send XON frame.<br>
+=C2=A0 =C2=A0 send_xon: bool =3D field(default=3DFalse, metadata=3DTextPar=
ser.find(r&quot;Tx pause: on&quot;))<br>
+=C2=A0 =C2=A0 #: Enable receiving MAC control frames.<br>
+=C2=A0 =C2=A0 mac_ctrl_frame_fwd: bool =3D field(default=3DFalse, metadata=
=3DTextParser.find(r&quot;Tx pause: on&quot;))<br>
+=C2=A0 =C2=A0 #: Change the auto-negotiation parameter.<br>
+=C2=A0 =C2=A0 autoneg: bool =3D field(default=3DFalse, metadata=3DTextPars=
er.find(r&quot;Autoneg: on&quot;))<br>
+<br>
+=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the string represent=
ation of this instance.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;rx {&#39;on&#39; if self.=
rx else &#39;off&#39;} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;tx {&#39;on&#39; if self.=
tx else &#39;off&#39;} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.high_water} &quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.low_water} &quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.pause_time} &quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{1 if self.send_xon else =
0} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;mac_ctrl_frame_fwd {&#39;=
on&#39; if self.mac_ctrl_frame_fwd else &#39;off&#39;} &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;autoneg {&#39;on&#39; if =
self.autoneg else &#39;off&#39;}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret<br>
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init=
__.py<br>
index 1ec744d1d4..d2f0138e4a 100644<br>
--- a/dts/framework/config/__init__.py<br>
+++ b/dts/framework/config/__init__.py<br>
@@ -28,7 +28,6 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0and makes it thread safe should we ever want to =
move in that direction.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
-import os<br>
=C2=A0from pathlib import Path<br>
=C2=A0from typing import TYPE_CHECKING, Annotated, Any, Literal, TypeVar, c=
ast<br>
<br>
@@ -43,7 +42,7 @@<br>
=C2=A0from .test_run import TestRunConfiguration, create_test_suites_config=
_model<br>
<br>
=C2=A0# Import only if type checking or building docs, to prevent circular =
imports.<br>
-if TYPE_CHECKING or os.environ.get(&quot;DTS_DOC_BUILD&quot;):<br>
+if TYPE_CHECKING:<br>
=C2=A0 =C2=A0 =C2=A0from framework.test_suite import BaseConfig<br>
<br>
=C2=A0NodesConfig =3D Annotated[list[NodeConfiguration], Field(min_length=
=3D1)]<br>
diff --git a/dts/framework/params/eal.py b/dts/framework/params/eal.py<br>
index b90ff33dcf..e84a20f02f 100644<br>
--- a/dts/framework/params/eal.py<br>
+++ b/dts/framework/params/eal.py<br>
@@ -4,15 +4,17 @@<br>
=C2=A0&quot;&quot;&quot;Module representing the DPDK EAL-related parameters=
.&quot;&quot;&quot;<br>
<br>
=C2=A0from dataclasses import dataclass, field<br>
-from typing import Literal<br>
+from typing import TYPE_CHECKING, Literal<br>
<br>
=C2=A0from framework.params import Params, Switch<br>
=C2=A0from framework.testbed_model.cpu import LogicalCoreList<br>
-from framework.testbed_model.port import Port<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
<br>
+if TYPE_CHECKING:<br>
+=C2=A0 =C2=A0 from framework.testbed_model.port import Port<br>
<br>
-def _port_to_pci(port: Port) -&gt; str:<br>
+<br>
+def _port_to_pci(port: &quot;Port&quot;) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0return port.pci<br>
<br>
<br>
@@ -42,11 +44,11 @@ class EalParams(Params):<br>
=C2=A0 =C2=A0 =C2=A0vdevs: list[VirtualDevice] | None =3D field(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default=3DNone, metadata=3DParams.multipl=
e() | Params.long(&quot;vdev&quot;)<br>
=C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 allowed_ports: list[Port] | None =3D field(<br>
+=C2=A0 =C2=A0 allowed_ports: list[&quot;Port&quot;] | None =3D field(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metadata=3DParams.convert_value(_port_to_=
pci) | Params.multiple() | Params.short(&quot;a&quot;),<br>
=C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 blocked_ports: list[Port] | None =3D field(<br>
+=C2=A0 =C2=A0 blocked_ports: list[&quot;Port&quot;] | None =3D field(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0metadata=3DParams.convert_value(_port_to_=
pci) | Params.multiple() | Params.short(&quot;b&quot;),<br>
=C2=A0 =C2=A0 =C2=A0)<br>
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py<=
br>
index 87d11502e8..5bc4bd37d9 100644<br>
--- a/dts/framework/params/types.py<br>
+++ b/dts/framework/params/types.py<br>
@@ -15,8 +15,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):<=
br>
=C2=A0from pathlib import PurePath<br>
=C2=A0from typing import TypedDict<br>
<br>
-from framework.params import Switch, YesNoSwitch<br>
-from framework.params.testpmd import (<br>
+from api.testpmd.config import (<br>
=C2=A0 =C2=A0 =C2=A0AnonMempoolAllocationMode,<br>
=C2=A0 =C2=A0 =C2=A0EthPeer,<br>
=C2=A0 =C2=A0 =C2=A0Event,<br>
@@ -37,6 +36,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):<=
br>
=C2=A0 =C2=A0 =C2=A0TXRingParams,<br>
=C2=A0 =C2=A0 =C2=A0TxUDPPortPair,<br>
=C2=A0)<br>
+from framework.params import Switch, YesNoSwitch<br>
=C2=A0from framework.testbed_model.cpu import LogicalCoreList<br>
=C2=A0from framework.testbed_model.port import Port<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
diff --git a/dts/framework/remote_session/__init__.py b/dts/framework/remot=
e_session/__init__.py<br>
index 1a5cf6abd3..394c88b25e 100644<br>
--- a/dts/framework/remote_session/__init__.py<br>
+++ b/dts/framework/remote_session/__init__.py<br>
@@ -11,47 +11,3 @@<br>
=C2=A0The interactive sessions open an interactive shell which is continuou=
sly open,<br>
=C2=A0allowing it to send and receive data within that particular shell.<br=
>
=C2=A0&quot;&quot;&quot;<br>
-<br>
-from framework.config.node import NodeConfiguration<br>
-from framework.logger import DTSLogger<br>
-<br>
-from .interactive_remote_session import InteractiveRemoteSession<br>
-from .remote_session import RemoteSession<br>
-from .ssh_session import SSHSession<br>
-<br>
-<br>
-def create_remote_session(<br>
-=C2=A0 =C2=A0 node_config: NodeConfiguration, name: str, logger: DTSLogger=
<br>
-) -&gt; RemoteSession:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Factory for non-interactive remote session=
s.<br>
-<br>
-=C2=A0 =C2=A0 The function returns an SSH session, but will be extended if=
 support<br>
-=C2=A0 =C2=A0 for other protocols is added.<br>
-<br>
-=C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_config: The test run configuration of the=
 node to connect to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: The name of the session.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger: The logger instance this session will =
use.<br>
-<br>
-=C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The SSH remote session.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 return SSHSession(node_config, name, logger)<br>
-<br>
-<br>
-def create_interactive_session(<br>
-=C2=A0 =C2=A0 node_config: NodeConfiguration, logger: DTSLogger<br>
-) -&gt; InteractiveRemoteSession:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Factory for interactive remote sessions.<b=
r>
-<br>
-=C2=A0 =C2=A0 The function returns an interactive SSH session, but will be=
 extended if support<br>
-=C2=A0 =C2=A0 for other protocols is added.<br>
-<br>
-=C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_config: The test run configuration of the=
 node to connect to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger: The logger instance this session will =
use.<br>
-<br>
-=C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The interactive SSH remote session.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 return InteractiveRemoteSession(node_config, logger)<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
deleted file mode 100644<br>
index ad8cb273dc..0000000000<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ /dev/null<br>
@@ -1,2844 +0,0 @@<br>
-# SPDX-License-Identifier: BSD-3-Clause<br>
-# Copyright(c) 2023 University of New Hampshire<br>
-# Copyright(c) 2023 PANTHEON.tech s.r.o.<br>
-# Copyright(c) 2024 Arm Limited<br>
-<br>
-&quot;&quot;&quot;Testpmd interactive shell.<br>
-<br>
-Typical usage example in a TestSuite::<br>
-<br>
-=C2=A0 =C2=A0 testpmd_shell =3D TestPmdShell(self.sut_node)<br>
-=C2=A0 =C2=A0 devices =3D testpmd_shell.get_devices()<br>
-=C2=A0 =C2=A0 for device in devices:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(device)<br>
-=C2=A0 =C2=A0 testpmd_shell.close()<br>
-&quot;&quot;&quot;<br>
-<br>
-import functools<br>
-import re<br>
-import time<br>
-from collections.abc import Callable, MutableSet<br>
-from dataclasses import dataclass, field<br>
-from enum import Flag, auto<br>
-from os import environ<br>
-from pathlib import PurePath<br>
-from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, Par=
amSpec, Tuple, TypeAlias<br>
-<br>
-from framework.context import get_ctx<br>
-from framework.remote_session.interactive_shell import only_active<br>
-from framework.testbed_model.topology import TopologyType<br>
-<br>
-if TYPE_CHECKING or environ.get(&quot;DTS_DOC_BUILD&quot;):<br>
-=C2=A0 =C2=A0 from enum import Enum as NoAliasEnum<br>
-else:<br>
-=C2=A0 =C2=A0 from aenum import NoAliasEnum<br>
-<br>
-from typing_extensions import Self, Unpack<br>
-<br>
-from framework.exception import InteractiveCommandExecutionError, Internal=
Error<br>
-from framework.params.testpmd import PortTopology, SimpleForwardingModes, =
TestPmdParams<br>
-from framework.params.types import TestPmdParamsDict<br>
-from framework.parser import ParserFn, TextParser<br>
-from framework.remote_session.dpdk_shell import DPDKShell<br>
-from framework.settings import SETTINGS<br>
-from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum<br>
-<br>
-P =3D ParamSpec(&quot;P&quot;)<br>
-TestPmdShellMethod =3D Callable[Concatenate[&quot;TestPmdShell&quot;, P], =
Any]<br>
-<br>
-TestPmdShellCapabilityMethod: TypeAlias =3D Callable[<br>
-=C2=A0 =C2=A0 [&quot;TestPmdShell&quot;, MutableSet[&quot;NicCapability&qu=
ot;], MutableSet[&quot;NicCapability&quot;]], None<br>
-]<br>
-<br>
-TestPmdShellDecorator: TypeAlias =3D Callable[[TestPmdShellMethod], TestPm=
dShellMethod]<br>
-<br>
-TestPmdShellNicCapability =3D tuple[TestPmdShellCapabilityMethod, TestPmdS=
hellDecorator | None]<br>
-<br>
-<br>
-class TestPmdDevice:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;The data of a device that testpmd can reco=
gnize.<br>
-<br>
-=C2=A0 =C2=A0 Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_address: The PCI address of the device.<br=
>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 pci_address: str<br>
-<br>
-=C2=A0 =C2=A0 def __init__(self, pci_address_line: str):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Initialize the device from t=
he testpmd output line string.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_address_line: A line of test=
pmd output that contains a device.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.pci_address =3D pci_address_line.strip().=
split(&quot;: &quot;)[1].strip()<br>
-<br>
-=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The PCI address captures wha=
t the device is.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.pci_address<br>
-<br>
-<br>
-class VLANOffloadFlag(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the VLAN offload setting=
s of a NIC port.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 STRIP =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 FILTER =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 EXTEND =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 QINQ_STRIP =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_str_dict(cls, d):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes an instance from a dic=
t containing the flag member names with an &quot;on&quot; value.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d: A dictionary containing the f=
lag members as keys and any string value.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A new instance of the flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in cls.__members__:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if d.get(name) =3D=3D &quot;on&q=
uot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[name=
]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;VLAN offloa=
d:\s+&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;strip (?P&l=
t;STRIP&gt;on|off), &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;filter (?P&=
lt;FILTER&gt;on|off), &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;extend (?P&=
lt;EXTEND&gt;on|off), &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;qinq strip =
(?P&lt;QINQ_STRIP&gt;on|off)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re.MULTILINE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 named=3DTrue,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_str_dict,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-<br>
-class ChecksumOffloadOptions(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing checksum hardware offloa=
d layer options.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ip =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 udp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tcp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 sctp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 outer_ip =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 outer_udp =3D auto()<br>
-<br>
-<br>
-class RSSOffloadTypesFlag(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the RSS offload flow typ=
es supported by the NIC port.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_frag =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_tcp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_udp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_sctp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_other =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_frag =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_tcp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_udp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_sctp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_other =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2_payload =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_ex =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_tcp_ex =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_udp_ex =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 port =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 vxlan =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 geneve =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 nvgre =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_22 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 gtpu =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 eth =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 s_vlan =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 c_vlan =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 esp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ah =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2tpv3 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 pfcp =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 pppoe =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ecpri =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 mpls =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv4_chksum =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l4_chksum =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2tpv2 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ipv6_flow_label =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_38 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_39 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_40 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_41 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_42 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_43 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_44 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_45 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_46 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_47 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_48 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_49 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_50 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_defined_51 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre96 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre64 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre56 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre48 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre40 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_pre32 =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2_dst_only =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2_src_only =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l4_dst_only =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l4_src_only =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_dst_only =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_src_only =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ip =3D ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ip=
v6_other | ipv6_ex<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 udp =3D ipv4_udp | ipv6_udp | ipv6_udp_ex<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tcp =3D ipv4_tcp | ipv6_tcp | ipv6_tcp_ex<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 sctp =3D ipv4_sctp | ipv6_sctp<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tunnel =3D vxlan | geneve | nvgre<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 vlan =3D s_vlan | c_vlan<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 all =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 eth<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | vlan<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ip<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | tcp<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | udp<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | sctp<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2_payload<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2tpv3<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | esp<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ah<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | pfcp<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | gtpu<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | ecpri<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | mpls<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | l2tpv2<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(r&quot;Supported=
 RSS offload flow types:((?:\r?\n?=C2=A0 \S+)+)&quot;, re.MULTILINE),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RSSOffloadTypesFlag.from_list_st=
ring,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-<br>
-class DeviceCapabilitiesFlag(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the device capabilities.=
&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: Device supports Rx queue setup after device started.<br>
-=C2=A0 =C2=A0 RUNTIME_RX_QUEUE_SETUP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports Tx queue setup after device started.<br>
-=C2=A0 =C2=A0 RUNTIME_TX_QUEUE_SETUP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports shared Rx queue among ports within Rx dom=
ain and switch domain.<br>
-=C2=A0 =C2=A0 RXQ_SHARE =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports keeping flow rules across restart.<br>
-=C2=A0 =C2=A0 FLOW_RULE_KEEP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports keeping shared flow objects across restar=
t.<br>
-=C2=A0 =C2=A0 FLOW_SHARED_OBJECT_KEEP =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find_int(r&quot;Devic=
e capabilities: (0x[A-Fa-f\d]+)&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-<br>
-class DeviceErrorHandlingMode(StrEnum):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Enum representing the device error handlin=
g mode.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 none =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 passive =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 proactive =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 unknown =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this enum from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;=
Device error handling mode: (\w+)&quot;), cls)<br>
-<br>
-<br>
-def make_device_private_info_parser() -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Device private information parser.<br>
-<br>
-=C2=A0 =C2=A0 Ensures that we are not parsing invalid device private info =
output.<br>
-<br>
-=C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `dataclasses.fi=
eld` metadata argument containing a parser<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 function that parses the device =
private info from the TestPmd port info output.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 def _validate(info: str):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D info.strip()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if info =3D=3D &quot;none&quot; or info.starts=
with(&quot;Invalid file&quot;) or info.startswith(&quot;Failed to dump&quot=
;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return info<br>
-<br>
-=C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;Device private=
 info:\s+([\s\S]+)&quot;), _validate)<br>
-<br>
-<br>
-class RxQueueState(StrEnum):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;RX queue states.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/ethdev/rte_ethdev.h``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:get_queue_state_name()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 stopped =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 started =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 hairpin =3D auto()<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 unknown =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this enum from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(TextParser.find(r&quot;=
Rx queue state: ([^\r\n]+)&quot;), cls)<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdQueueInfo(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Dataclass representation of the common par=
ts of the testpmd `show rxq/txq info` commands.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 prefetch_threshold: int =3D field(metadata=3DTextParser.find=
_int(r&quot;prefetch threshold: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 host_threshold: int =3D field(metadata=3DTextParser.find_int=
(r&quot;host threshold: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 writeback_threshold: int =3D field(metadata=3DTextParser.fin=
d_int(r&quot;writeback threshold: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 free_threshold: int =3D field(metadata=3DTextParser.find_int=
(r&quot;free threshold: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 deferred_start: bool =3D field(metadata=3DTextParser.find(&q=
uot;deferred start: on&quot;))<br>
-=C2=A0 =C2=A0 #: The number of RXD/TXDs is just the ring size of the queue=
.<br>
-=C2=A0 =C2=A0 ring_size: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;Number of (?:RXDs|TXDs): (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_queue_started: bool =3D field(metadata=3DTextParser.find(=
&quot;queue state: started&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 burst_mode: str | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Burst mode: ([^\r\n]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdTxqInfo(TestPmdQueueInfo):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Representation of testpmd&#39;s ``show txq=
 info &lt;port_id&gt; &lt;queue_id&gt;`` command.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_showqueue()``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:rx_queue_infos_display()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: Ring size threshold<br>
-=C2=A0 =C2=A0 rs_threshold: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;TX RS threshold: (\d+)\b&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdRxqInfo(TestPmdQueueInfo):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Representation of testpmd&#39;s ``show rxq=
 info &lt;port_id&gt; &lt;queue_id&gt;`` command.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_showqueue()``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/confi=
g.c:rx_queue_infos_display()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: Mempool used by that queue<br>
-=C2=A0 =C2=A0 mempool: str | None =3D field(default=3DNone, metadata=3DTex=
tParser.find(r&quot;Mempool: ([^\r\n]+)&quot;))<br>
-=C2=A0 =C2=A0 #: Drop packets if no descriptors are available<br>
-=C2=A0 =C2=A0 drop_packets: bool | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;RX drop packets: on&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Scattered packets Rx enabled<br>
-=C2=A0 =C2=A0 scattered_packets: bool | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;RX scattered packets: on&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: The state of the queue<br>
-=C2=A0 =C2=A0 queue_state: str | None =3D field(default=3DNone, metadata=
=3DRxQueueState.make_parser())<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdPort(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Dataclass representing the result of testp=
md&#39;s ``show port info`` command.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 id: int =3D field(metadata=3DTextParser.find_int(r&quot;Info=
s for port (\d+)\b&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 device_name: str =3D field(metadata=3DTextParser.find(r&quot=
;Device name: ([^\r\n]+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 driver_name: str =3D field(metadata=3DTextParser.find(r&quot=
;Driver name: ([^\r\n]+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 socket_id: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;Connect to socket: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_link_up: bool =3D field(metadata=3DTextParser.find(&quot;=
Link status: up&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 link_speed: str =3D field(metadata=3DTextParser.find(r&quot;=
Link speed: ([^\r\n]+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_link_full_duplex: bool =3D field(metadata=3DTextParser.fi=
nd(&quot;Link duplex: full-duplex&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_link_autonegotiated: bool =3D field(metadata=3DTextParser=
.find(&quot;Autoneg status: On&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_promiscuous_mode_enabled: bool =3D field(metadata=3DTextP=
arser.find(&quot;Promiscuous mode: enabled&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 is_allmulticast_mode_enabled: bool =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find(&quot;Allmulticast =
mode: enabled&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Maximum number of MAC addresses<br>
-=C2=A0 =C2=A0 max_mac_addresses_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of MAC addresses: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Maximum configurable length of RX packet<br>
-=C2=A0 =C2=A0 max_hash_mac_addresses_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of MAC addresses of hash filtering: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Minimum size of RX buffer<br>
-=C2=A0 =C2=A0 min_rx_bufsize: int =3D field(metadata=3DTextParser.find_int=
(r&quot;Minimum size of RX buffer: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Maximum configurable length of RX packet<br>
-=C2=A0 =C2=A0 max_rx_packet_length: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
configurable length of RX packet: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Maximum configurable size of LRO aggregated packet<br>
-=C2=A0 =C2=A0 max_lro_packet_size: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
configurable size of LRO aggregated packet: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #: Current number of RX queues<br>
-=C2=A0 =C2=A0 rx_queues_num: int =3D field(metadata=3DTextParser.find_int(=
r&quot;Current number of RX queues: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Max possible RX queues<br>
-=C2=A0 =C2=A0 max_rx_queues_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;Max possible RX queues: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Max possible number of RXDs per queue<br>
-=C2=A0 =C2=A0 max_queue_rxd_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max poss=
ible number of RXDs per queue: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Min possible number of RXDs per queue<br>
-=C2=A0 =C2=A0 min_queue_rxd_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Min poss=
ible number of RXDs per queue: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: RXDs number alignment<br>
-=C2=A0 =C2=A0 rxd_alignment_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;RXDs number alignment: (\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #: Current number of TX queues<br>
-=C2=A0 =C2=A0 tx_queues_num: int =3D field(metadata=3DTextParser.find_int(=
r&quot;Current number of TX queues: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Max possible TX queues<br>
-=C2=A0 =C2=A0 max_tx_queues_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;Max possible TX queues: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Max possible number of TXDs per queue<br>
-=C2=A0 =C2=A0 max_queue_txd_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max poss=
ible number of TXDs per queue: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Min possible number of TXDs per queue<br>
-=C2=A0 =C2=A0 min_queue_txd_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Min poss=
ible number of TXDs per queue: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: TXDs number alignment<br>
-=C2=A0 =C2=A0 txd_alignment_num: int =3D field(metadata=3DTextParser.find_=
int(r&quot;TXDs number alignment: (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Max segment number per packet<br>
-=C2=A0 =C2=A0 max_packet_segment_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max segm=
ent number per packet: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Max segment number per MTU/TSO<br>
-=C2=A0 =C2=A0 max_mtu_segment_num: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Max segm=
ent number per MTU\/TSO: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 device_capabilities: DeviceCapabilitiesFlag =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DDeviceCapabilitiesFlag.make_parser(=
),<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 device_error_handling_mode: DeviceErrorHandlingMode | None =
=3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DDeviceErrorHandling=
Mode.make_parser()<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 device_private_info: str | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3Dmake_device_private_info_parser(),<=
br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 hash_key_size: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Hash key size in bytes: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 redirection_table_size: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Redirection table size: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 supported_rss_offload_flow_types: RSSOffloadTypesFlag =3D fi=
eld(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DRSSOffloadTypesFlag(0), metadata=3DR=
SSOffloadTypesFlag.make_parser()<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 mac_address: str | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;MAC address: ([A-Fa-f0-9:]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 fw_version: str | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Firmware-version: ([^\r\n]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 dev_args: str | None =3D field(default=3DNone, metadata=3DTe=
xtParser.find(r&quot;Devargs: ([^\r\n]+)&quot;))<br>
-=C2=A0 =C2=A0 #: Socket id of the memory allocation<br>
-=C2=A0 =C2=A0 mem_alloc_socket_id: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;memory a=
llocation on the socket: (\d+)&quot;),<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 mtu: int | None =3D field(default=3DNone, metadata=3DTextPar=
ser.find_int(r&quot;MTU: (\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 vlan_offload: VLANOffloadFlag | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DVLANOffloadFlag.make_parser(),<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #: Maximum size of RX buffer<br>
-=C2=A0 =C2=A0 max_rx_bufsize: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum size of RX buffer: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Maximum number of VFs<br>
-=C2=A0 =C2=A0 max_vfs_num: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VFs: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Maximum number of VMDq pools<br>
-=C2=A0 =C2=A0 max_vmdq_pools_num: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VMDq pools: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 switch_name: str | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find(r&q=
uot;Switch name: ([\r\n]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 switch_domain_id: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch domain Id: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 switch_port_id: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch Port Id: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 switch_rx_domain: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Switch Rx domain: (\d+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdPortStats(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Port statistics.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;NIC statistics for port (\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_packets: int =3D field(metadata=3DTextParser.find_int(r&q=
uot;RX-packets:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_missed: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-missed:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_bytes: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;RX-bytes:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_errors: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-errors:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_nombuf: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;RX-nombuf:\s+(\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tx_packets: int =3D field(metadata=3DTextParser.find_int(r&q=
uot;TX-packets:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tx_errors: int =3D field(metadata=3DTextParser.find_int(r&qu=
ot;TX-errors:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tx_bytes: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;TX-bytes:\s+(\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Rx-pps:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 rx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Rx-bps:\s+(\d+)&quot;))<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tx_pps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Tx-pps:\s+(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 tx_bps: int =3D field(metadata=3DTextParser.find_int(r&quot;=
Tx-bps:\s+(\d+)&quot;))<br>
-<br>
-<br>
-@dataclass(kw_only=3DTrue)<br>
-class FlowRule:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Class representation of flow rule paramete=
rs.<br>
-<br>
-=C2=A0 =C2=A0 This class represents the parameters of any flow rule as per=
 the<br>
-=C2=A0 =C2=A0 following pattern:<br>
-<br>
-=C2=A0 =C2=A0 [group {group_id}] [priority {level}] [ingress] [egress]<br>
-=C2=A0 =C2=A0 [user_id {user_id}] pattern {item} [/ {item} [...]] / end<br=
>
-=C2=A0 =C2=A0 actions {action} [/ {action} [...]] / end<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 group_id: int | None =3D None<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 priority_level: int | None =3D None<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 direction: Literal[&quot;ingress&quot;, &quot;egress&quot;]<=
br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 user_id: int | None =3D None<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 pattern: list[str]<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 actions: list[str]<br>
-<br>
-=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the string represent=
ation of this instance.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern =3D &quot; / &quot;.join(self.pattern)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot; / &quot;.join(self.actions)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.group_id is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;group {self.grou=
p_id} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.priority_level is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;priority {self.p=
riority_level} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;{self.direction} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.user_id is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;user_id {self.us=
er_id} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;pattern {pattern} / end &quot;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D f&quot;actions {action} / end&quot;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret<br>
-<br>
-<br>
-class PacketOffloadFlag(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing the Packet Offload Featu=
res Flags in DPDK.<br>
-<br>
-=C2=A0 =C2=A0 Values in this class are taken from the definitions in the R=
TE MBUF core library in DPDK<br>
-=C2=A0 =C2=A0 located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that=
 flag values in this class will<br>
-=C2=A0 =C2=A0 match the values they are set to in said DPDK library with o=
ne exception; all values must be<br>
-=C2=A0 =C2=A0 unique. For example, the definitions for unknown checksum fl=
ags in ``rte_mbuf_core.h`` are all<br>
-=C2=A0 =C2=A0 set to :data:`0`, but it is valuable to distinguish between =
them in this framework. For this<br>
-=C2=A0 =C2=A0 reason flags that are not unique in the DPDK library are set=
 either to values within the<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or s=
hifted 61+ bits for Tx.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/mbuf/rte_mbuf_core.h``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 # RX flags<br>
-<br>
-=C2=A0 =C2=A0 #: The RX packet is a 802.1q VLAN packet, and the tci has be=
en saved in mbuf-&gt;vlan_tci. If the<br>
-=C2=A0 =C2=A0 #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLA=
N header has been stripped from<br>
-=C2=A0 =C2=A0 #: mbuf data, else it is still present.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_VLAN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: RX packet with RSS hash result.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_RSS_HASH =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: RX packet with FDIR match indicate.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: This flag is set when the outermost IP header checksum is=
 detected as wrong by the hardware.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD =3D 1 &lt;&lt; 5<br>
-<br>
-=C2=A0 =C2=A0 #: A vlan has been stripped by the hardware and its tci is s=
aved in mbuf-&gt;vlan_tci. This can<br>
-=C2=A0 =C2=A0 #: only happen if vlan stripping is enabled in the RX config=
uration of the PMD. When<br>
-=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN mu=
st also be set.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_VLAN_STRIPPED =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: No information about the RX IP checksum. Value is 0 in th=
e DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN =3D 1 &lt;&lt; 23<br>
-=C2=A0 =C2=A0 #: The IP checksum in the packet is wrong.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_BAD =3D 1 &lt;&lt; 4<br>
-=C2=A0 =C2=A0 #: The IP checksum in the packet is valid.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_GOOD =3D 1 &lt;&lt; 7<br>
-=C2=A0 =C2=A0 #: The IP checksum is not correct in the packet data, but th=
e integrity of the IP header is<br>
-=C2=A0 =C2=A0 #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_=
F_RX_IP_CKSUM_GOOD in the DPDK<br>
-=C2=A0 =C2=A0 #: library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IP_CKSUM_NONE =3D 1 &lt;&lt; 24<br>
-<br>
-=C2=A0 =C2=A0 #: No information about the RX L4 checksum. Value is 0 in th=
e DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN =3D 1 &lt;&lt; 25<br>
-=C2=A0 =C2=A0 #: The L4 checksum in the packet is wrong.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_BAD =3D 1 &lt;&lt; 3<br>
-=C2=A0 =C2=A0 #: The L4 checksum in the packet is valid.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_GOOD =3D 1 &lt;&lt; 8<br>
-=C2=A0 =C2=A0 #: The L4 checksum is not correct in the packet data, but th=
e integrity of the L4 data is<br>
-=C2=A0 =C2=A0 #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_=
F_RX_L4_CKSUM_GOOD in the DPDK<br>
-=C2=A0 =C2=A0 #: library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_L4_CKSUM_NONE =3D 1 &lt;&lt; 26<br>
-<br>
-=C2=A0 =C2=A0 #: RX IEEE1588 L2 Ethernet PT Packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IEEE1588_PTP =3D 1 &lt;&lt; 9<br>
-=C2=A0 =C2=A0 #: RX IEEE1588 L2/L4 timestamped packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_IEEE1588_TMST =3D 1 &lt;&lt; 10<br>
-<br>
-=C2=A0 =C2=A0 #: FD id reported if FDIR match.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR_ID =3D 1 &lt;&lt; 13<br>
-=C2=A0 =C2=A0 #: Flexible bytes reported if FDIR match.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_FDIR_FLX =3D 1 &lt;&lt; 14<br>
-<br>
-=C2=A0 =C2=A0 #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLA=
N_STRIPPED are set, the 2 VLANs<br>
-=C2=A0 =C2=A0 #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ=
_STRIPPED is set and<br>
-=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN=
 is removed from packet data.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_QINQ_STRIPPED =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: When packets are coalesced by a hardware or virtual drive=
r, this flag can be set in the RX<br>
-=C2=A0 =C2=A0 #: mbuf, meaning that the m-&gt;tso_segsz field is valid and=
 is set to the segment size of<br>
-=C2=A0 =C2=A0 #: original packets.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_LRO =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: Indicate that security offload processing was applied on =
the RX packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_SEC_OFFLOAD =3D 1 &lt;&lt; 18<br>
-=C2=A0 =C2=A0 #: Indicate that security offload processing failed on the R=
X packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: The RX packet is a double VLAN. If this flag is set, RTE_=
MBUF_F_RX_VLAN must also be set. If<br>
-=C2=A0 =C2=A0 #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, bot=
h VLANs headers have been stripped<br>
-=C2=A0 =C2=A0 #: from mbuf data, else they are still present.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_QINQ =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: No info about the outer RX L4 checksum. Value is 0 in the=
 DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN =3D 1 &lt;&lt; 27<br>
-=C2=A0 =C2=A0 #: The outer L4 checksum in the packet is wrong<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD =3D 1 &lt;&lt; 21<br>
-=C2=A0 =C2=A0 #: The outer L4 checksum in the packet is valid<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD =3D 1 &lt;&lt; 22<br>
-=C2=A0 =C2=A0 #: Invalid outer L4 checksum state. Value is<br>
-=C2=A0 =C2=A0 #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4=
_CKSUM_GOOD in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID =3D 1 &lt;&lt; 28<br>
-<br>
-=C2=A0 =C2=A0 # TX flags<br>
-<br>
-=C2=A0 =C2=A0 #: Outer UDP checksum offload flag. This flag is used for en=
abling outer UDP checksum in PMD.<br>
-=C2=A0 =C2=A0 #: To use outer UDP checksum, the user either needs to enabl=
e the following in mbuf:<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 #:=C2=A0 a) Fill outer_l2_len and outer_l3_len in mbuf.<br>
-=C2=A0 =C2=A0 #:=C2=A0 b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.<br>
-=C2=A0 =C2=A0 #:=C2=A0 c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_T=
X_OUTER_IPV6 flag.<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload f=
lag.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_UDP_CKSUM =3D 1 &lt;&lt; 41<br>
-<br>
-=C2=A0 =C2=A0 #: UDP Fragmentation Offload flag. This flag is used for ena=
bling UDP fragmentation in SW or in<br>
-=C2=A0 =C2=A0 #: HW.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_UDP_SEG =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: Request security offload processing on the TX packet. To =
use Tx security offload, the user<br>
-=C2=A0 =C2=A0 #: needs to fill l2_len in mbuf indicating L2 header size an=
d where L3 header starts.<br>
-=C2=A0 =C2=A0 #: Similarly, l3_len should also be filled along with ol_fla=
gs reflecting current L3 type.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_SEC_OFFLOAD =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: Offload the MACsec. This flag must be set by the applicat=
ion to enable this offload feature<br>
-=C2=A0 =C2=A0 #: for a packet to be transmitted.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_MACSEC =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Bits 45:48 are used for the tunnel type in ``lib/mbuf/rte_=
mbuf_core.h``, but some are modified<br>
-=C2=A0 =C2=A0 # in this Flag to maintain uniqueness. The tunnel type must =
be specified for TSO or checksum on<br>
-=C2=A0 =C2=A0 # the inner part of tunnel packets. These flags can be used =
with RTE_MBUF_F_TX_TCP_SEG for TSO,<br>
-=C2=A0 =C2=A0 # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and =
outer header lengths are required:<br>
-=C2=A0 =C2=A0 # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso=
_segsz for TSO.<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_VXLAN =3D 1 &lt;&lt; 45<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GRE =3D 1 &lt;&lt; 46<br>
-=C2=A0 =C2=A0 #: Value is 3 &lt;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_IPIP =3D 1 &lt;&lt; 61<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GENEVE =3D 1 &lt;&lt; 47<br>
-=C2=A0 =C2=A0 #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 &l=
t;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_MPLSINUDP =3D 1 &lt;&lt; 62<br>
-=C2=A0 =C2=A0 #: Value is 6 &lt;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE =3D 1 &lt;&lt; 63<br>
-=C2=A0 =C2=A0 #: Value is 7 &lt;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GTP =3D 1 &lt;&lt; 64<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_ESP =3D 1 &lt;&lt; 48<br>
-=C2=A0 =C2=A0 #: Generic IP encapsulated tunnel type, used for TSO and che=
cksum offload. This can be used for<br>
-=C2=A0 =C2=A0 #: tunnels which are not standards or listed above. It is pr=
eferred to use specific tunnel<br>
-=C2=A0 =C2=A0 #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNN=
EL_IPIP if possible. The ethdev<br>
-=C2=A0 =C2=A0 #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.=C2=
=A0 Outer and inner checksums are done<br>
-=C2=A0 =C2=A0 #: according to the existing flags like RTE_MBUF_F_TX_xxx_CK=
SUM. Specific tunnel headers that<br>
-=C2=A0 =C2=A0 #: contain payload length, sequence id or checksum are not e=
xpected to be updated. Value is<br>
-=C2=A0 =C2=A0 #: 0xD &lt;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_IP =3D 1 &lt;&lt; 65<br>
-=C2=A0 =C2=A0 #: Generic UDP encapsulated tunnel type, used for TSO and ch=
ecksum offload. UDP tunnel type<br>
-=C2=A0 =C2=A0 #: implies outer IP layer. It can be used for tunnels which =
are not standards or listed above.<br>
-=C2=A0 =C2=A0 #: It is preferred to use specific tunnel flags like RTE_MBU=
F_F_TX_TUNNEL_VXLAN if possible.<br>
-=C2=A0 =C2=A0 #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP=
_TNL_TSO. Outer and inner checksums<br>
-=C2=A0 =C2=A0 #: are done according to the existing flags like RTE_MBUF_F_=
TX_xxx_CKSUM. Specific tunnel<br>
-=C2=A0 =C2=A0 #: headers that contain payload length, sequence id or check=
sum are not expected to be updated.<br>
-=C2=A0 =C2=A0 #: value is 0xE &lt;&lt; 45 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_UDP =3D 1 &lt;&lt; 66<br>
-<br>
-=C2=A0 =C2=A0 #: Double VLAN insertion (QinQ) request to driver, driver ma=
y offload the insertion based on<br>
-=C2=A0 =C2=A0 #: device capability. Mbuf &#39;vlan_tci&#39; &amp; &#39;vla=
n_tci_outer&#39; must be valid when this flag is set.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_QINQ =3D 1 &lt;&lt; 49<br>
-<br>
-=C2=A0 =C2=A0 #: TCP segmentation offload. To enable this offload feature =
for a packet to be transmitted on<br>
-=C2=A0 =C2=A0 #: hardware supporting TSO:<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 #:=C2=A0 - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf-&gt;ol=
_flags (this flag implies<br>
-=C2=A0 =C2=A0 #:=C2=A0 =C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_CKSUM)<br>
-=C2=A0 =C2=A0 #:=C2=A0 - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_=
IPV6<br>
-=C2=A0 =C2=A0 #:=C2=A0 =C2=A0 =C2=A0 * if it&#39;s IPv4, set the RTE_MBUF_=
F_TX_IP_CKSUM flag<br>
-=C2=A0 =C2=A0 #:=C2=A0 - fill the mbuf offload information: l2_len, l3_len=
, l4_len, tso_segsz<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_SEG =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: TX IEEE1588 packet to timestamp.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_IEEE1588_TMST =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Bits 52+53 used for L4 packet type with checksum enabled i=
n ``lib/mbuf/rte_mbuf_core.h`` but<br>
-=C2=A0 =C2=A0 # some values must be modified in this framework to maintain=
 uniqueness. To use hardware<br>
-=C2=A0 =C2=A0 # L4 checksum offload, the user needs to:<br>
-=C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 # - fill l2_len and l3_len in mbuf<br>
-=C2=A0 =C2=A0 # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCT=
P_CKSUM or<br>
-=C2=A0 =C2=A0 #=C2=A0 =C2=A0RTE_MBUF_F_TX_UDP_CKSUM<br>
-=C2=A0 =C2=A0 # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6<br=
>
-<br>
-=C2=A0 =C2=A0 #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK librar=
y.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_L4_NO_CKSUM =3D 1 &lt;&lt; 67<br>
-=C2=A0 =C2=A0 #: TCP cksum of TX pkt. Computed by NIC.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_TCP_CKSUM =3D 1 &lt;&lt; 52<br>
-=C2=A0 =C2=A0 #: SCTP cksum of TX pkt. Computed by NIC.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_SCTP_CKSUM =3D 1 &lt;&lt; 53<br>
-=C2=A0 =C2=A0 #: UDP cksum of TX pkt. Computed by NIC. Value is 3 &lt;&lt;=
 52 in the DPDK library.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_UDP_CKSUM =3D 1 &lt;&lt; 68<br>
-<br>
-=C2=A0 =C2=A0 #: Offload the IP checksum in the hardware. The flag RTE_MBU=
F_F_TX_IPV4 should also be set by<br>
-=C2=A0 =C2=A0 #: the application, although a PMD will only check RTE_MBUF_=
F_TX_IP_CKSUM.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_IP_CKSUM =3D 1 &lt;&lt; 54<br>
-<br>
-=C2=A0 =C2=A0 #: Packet is IPv4. This flag must be set when using any offl=
oad feature (TSO, L3 or L4<br>
-=C2=A0 =C2=A0 #: checksum) to tell the NIC that the packet is an IPv4 pack=
et. If the packet is a tunneled<br>
-=C2=A0 =C2=A0 #: packet, this flag is related to the inner headers.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_IPV4 =3D auto()<br>
-=C2=A0 =C2=A0 #: Packet is IPv6. This flag must be set when using an offlo=
ad feature (TSO or L4 checksum) to<br>
-=C2=A0 =C2=A0 #: tell the NIC that the packet is an IPv6 packet. If the pa=
cket is a tunneled packet, this<br>
-=C2=A0 =C2=A0 #: flag is related to the inner headers.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_IPV6 =3D auto()<br>
-=C2=A0 =C2=A0 #: VLAN tag insertion request to driver, driver may offload =
the insertion based on the device<br>
-=C2=A0 =C2=A0 #: capability. mbuf &#39;vlan_tci&#39; field must be valid w=
hen this flag is set.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_VLAN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 #: Offload the IP checksum of an external header in the hard=
ware. The flag<br>
-=C2=A0 =C2=A0 #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the applic=
ation, although a PMD will only<br>
-=C2=A0 =C2=A0 #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IP_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Packet outer header is IPv4. This flag must be set when u=
sing any outer offload feature (L3<br>
-=C2=A0 =C2=A0 #: or L4 checksum) to tell the NIC that the outer header of =
the tunneled packet is an IPv4<br>
-=C2=A0 =C2=A0 #: packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IPV4 =3D auto()<br>
-=C2=A0 =C2=A0 #: Packet outer header is IPv6. This flag must be set when u=
sing any outer offload feature (L4<br>
-=C2=A0 =C2=A0 #: checksum) to tell the NIC that the outer header of the tu=
nneled packet is an IPv6 packet.<br>
-=C2=A0 =C2=A0 RTE_MBUF_F_TX_OUTER_IPV6 =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(r&quot;ol_flags:=
 ([^\n]+)&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_list_string,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-<br>
-class RtePTypes(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Flag representing possible packet types in=
 DPDK verbose output.<br>
-<br>
-=C2=A0 =C2=A0 Values in this class are derived from definitions in the RTE=
 MBUF ptype library in DPDK located<br>
-=C2=A0 =C2=A0 in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of=
 values in this class should match<br>
-=C2=A0 =C2=A0 the possible return options from the functions ``rte_get_pty=
pe_*_name`` in ``rte_mbuf_ptype.c``.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK ptype name formatting functions: ``lib/mb=
uf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 # L2<br>
-=C2=A0 =C2=A0 #: Ethernet packet type. This is used for outer packet for t=
unneling cases.<br>
-=C2=A0 =C2=A0 L2_ETHER =3D auto()<br>
-=C2=A0 =C2=A0 #: Ethernet packet type for time sync.<br>
-=C2=A0 =C2=A0 L2_ETHER_TIMESYNC =3D auto()<br>
-=C2=A0 =C2=A0 #: ARP (Address Resolution Protocol) packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_ARP =3D auto()<br>
-=C2=A0 =C2=A0 #: LLDP (Link Layer Discovery Protocol) packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_LLDP =3D auto()<br>
-=C2=A0 =C2=A0 #: NSH (Network Service Header) packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_NSH =3D auto()<br>
-=C2=A0 =C2=A0 #: VLAN packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_VLAN =3D auto()<br>
-=C2=A0 =C2=A0 #: QinQ packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_QINQ =3D auto()<br>
-=C2=A0 =C2=A0 #: PPPOE packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_PPPOE =3D auto()<br>
-=C2=A0 =C2=A0 #: FCoE packet type..<br>
-=C2=A0 =C2=A0 L2_ETHER_FCOE =3D auto()<br>
-=C2=A0 =C2=A0 #: MPLS packet type.<br>
-=C2=A0 =C2=A0 L2_ETHER_MPLS =3D auto()<br>
-=C2=A0 =C2=A0 #: No L2 packet information.<br>
-=C2=A0 =C2=A0 L2_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # L3<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and does not contain any header option.<br>
-=C2=A0 =C2=A0 L3_IPV4 =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and contains header options.<br>
-=C2=A0 =C2=A0 L3_IPV4_EXT =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and does not contain any extension header.<br>
-=C2=A0 =C2=A0 L3_IPV6 =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and may or maynot contain header options.<br>
-=C2=A0 =C2=A0 L3_IPV4_EXT_UNKNOWN =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and contains extension headers.<br>
-=C2=A0 =C2=A0 L3_IPV6_EXT =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases, and may or maynot contain extension headers.<br>
-=C2=A0 =C2=A0 L3_IPV6_EXT_UNKNOWN =3D auto()<br>
-=C2=A0 =C2=A0 #: No L3 packet information.<br>
-=C2=A0 =C2=A0 L3_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # L4<br>
-=C2=A0 =C2=A0 #: TCP (Transmission Control Protocol) packet type. This is =
used for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases.<br>
-=C2=A0 =C2=A0 L4_TCP =3D auto()<br>
-=C2=A0 =C2=A0 #: UDP (User Datagram Protocol) packet type. This is used fo=
r outer packet for tunneling cases.<br>
-=C2=A0 =C2=A0 L4_UDP =3D auto()<br>
-=C2=A0 =C2=A0 #: Fragmented IP (Internet Protocol) packet type. This is us=
ed for outer packet for tunneling<br>
-=C2=A0 =C2=A0 #: cases and refers to those packets of any IP types which c=
an be recognized as fragmented. A<br>
-=C2=A0 =C2=A0 #: fragmented packet cannot be recognized as any other L4 ty=
pes (RTE_PTYPE_L4_TCP,<br>
-=C2=A0 =C2=A0 #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP, R=
TE_PTYPE_L4_NONFRAG).<br>
-=C2=A0 =C2=A0 L4_FRAG =3D auto()<br>
-=C2=A0 =C2=A0 #: SCTP (Stream Control Transmission Protocol) packet type. =
This is used for outer packet for<br>
-=C2=A0 =C2=A0 #: tunneling cases.<br>
-=C2=A0 =C2=A0 L4_SCTP =3D auto()<br>
-=C2=A0 =C2=A0 #: ICMP (Internet Control Message Protocol) packet type. Thi=
s is used for outer packet for<br>
-=C2=A0 =C2=A0 #: tunneling cases.<br>
-=C2=A0 =C2=A0 L4_ICMP =3D auto()<br>
-=C2=A0 =C2=A0 #: Non-fragmented IP (Internet Protocol) packet type. This i=
s used for outer packet for<br>
-=C2=A0 =C2=A0 #: tunneling cases and refers to those packets of any IP typ=
es, that cannot be recognized as<br>
-=C2=A0 =C2=A0 #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4=
_UDP, RTE_PTYPE_L4_FRAG,<br>
-=C2=A0 =C2=A0 #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).<br>
-=C2=A0 =C2=A0 L4_NONFRAG =3D auto()<br>
-=C2=A0 =C2=A0 #: IGMP (Internet Group Management Protocol) packet type.<br=
>
-=C2=A0 =C2=A0 L4_IGMP =3D auto()<br>
-=C2=A0 =C2=A0 #: No L4 packet information.<br>
-=C2=A0 =C2=A0 L4_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Tunnel<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) in IP (Internet Protocol) tunnelin=
g packet type.<br>
-=C2=A0 =C2=A0 TUNNEL_IP =3D auto()<br>
-=C2=A0 =C2=A0 #: GRE (Generic Routing Encapsulation) tunneling packet type=
.<br>
-=C2=A0 =C2=A0 TUNNEL_GRE =3D auto()<br>
-=C2=A0 =C2=A0 #: VXLAN (Virtual eXtensible Local Area Network) tunneling p=
acket type.<br>
-=C2=A0 =C2=A0 TUNNEL_VXLAN =3D auto()<br>
-=C2=A0 =C2=A0 #: NVGRE (Network Virtualization using Generic Routing Encap=
sulation) tunneling packet type.<br>
-=C2=A0 =C2=A0 TUNNEL_NVGRE =3D auto()<br>
-=C2=A0 =C2=A0 #: GENEVE (Generic Network Virtualization Encapsulation) tun=
neling packet type.<br>
-=C2=A0 =C2=A0 TUNNEL_GENEVE =3D auto()<br>
-=C2=A0 =C2=A0 #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensibl=
e Local Area Network) or GRE<br>
-=C2=A0 =C2=A0 #: (Generic Routing Encapsulation) could be recognized as th=
is packet type, if they can not be<br>
-=C2=A0 =C2=A0 #: recognized independently as of hardware capability.<br>
-=C2=A0 =C2=A0 TUNNEL_GRENAT =3D auto()<br>
-=C2=A0 =C2=A0 #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet=
 type.<br>
-=C2=A0 =C2=A0 TUNNEL_GTPC =3D auto()<br>
-=C2=A0 =C2=A0 #: GTP-U (GPRS Tunnelling Protocol) user data tunneling pack=
et type.<br>
-=C2=A0 =C2=A0 TUNNEL_GTPU =3D auto()<br>
-=C2=A0 =C2=A0 #: ESP (IP Encapsulating Security Payload) tunneling packet =
type.<br>
-=C2=A0 =C2=A0 TUNNEL_ESP =3D auto()<br>
-=C2=A0 =C2=A0 #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.<=
br>
-=C2=A0 =C2=A0 TUNNEL_L2TP =3D auto()<br>
-=C2=A0 =C2=A0 #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling pa=
cket type.<br>
-=C2=A0 =C2=A0 TUNNEL_VXLAN_GPE =3D auto()<br>
-=C2=A0 =C2=A0 #: MPLS-in-UDP tunneling packet type (RFC 7510).<br>
-=C2=A0 =C2=A0 TUNNEL_MPLS_IN_UDP =3D auto()<br>
-=C2=A0 =C2=A0 #: MPLS-in-GRE tunneling packet type (RFC 4023).<br>
-=C2=A0 =C2=A0 TUNNEL_MPLS_IN_GRE =3D auto()<br>
-=C2=A0 =C2=A0 #: No tunnel information found on the packet.<br>
-=C2=A0 =C2=A0 TUNNEL_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Inner L2<br>
-=C2=A0 =C2=A0 #: Ethernet packet type. This is used for inner packet type =
only.<br>
-=C2=A0 =C2=A0 INNER_L2_ETHER =3D auto()<br>
-=C2=A0 =C2=A0 #: Ethernet packet type with VLAN (Virtual Local Area Networ=
k) tag.<br>
-=C2=A0 =C2=A0 INNER_L2_ETHER_VLAN =3D auto()<br>
-=C2=A0 =C2=A0 #: QinQ packet type.<br>
-=C2=A0 =C2=A0 INNER_L2_ETHER_QINQ =3D auto()<br>
-=C2=A0 =C2=A0 #: No inner L2 information found on the packet.<br>
-=C2=A0 =C2=A0 INNER_L2_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Inner L3<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and does<br>
-=C2=A0 =C2=A0 #: not contain any header option.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV4 =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and<br>
-=C2=A0 =C2=A0 #: contains header options.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV4_EXT =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and does<br>
-=C2=A0 =C2=A0 #: not contain any extension header.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV6 =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 4 packet type. This is use=
d for inner packet only, and may or<br>
-=C2=A0 =C2=A0 #: may not contain header options.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV4_EXT_UNKNOWN =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and<br>
-=C2=A0 =C2=A0 #: contains extension headers.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV6_EXT =3D auto()<br>
-=C2=A0 =C2=A0 #: IP (Internet Protocol) version 6 packet type. This is use=
d for inner packet only, and may or<br>
-=C2=A0 =C2=A0 #: may not contain extension headers.<br>
-=C2=A0 =C2=A0 INNER_L3_IPV6_EXT_UNKNOWN =3D auto()<br>
-=C2=A0 =C2=A0 #: No inner L3 information found on the packet.<br>
-=C2=A0 =C2=A0 INNER_L3_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 # Inner L4<br>
-=C2=A0 =C2=A0 #: TCP (Transmission Control Protocol) packet type. This is =
used for inner packet only.<br>
-=C2=A0 =C2=A0 INNER_L4_TCP =3D auto()<br>
-=C2=A0 =C2=A0 #: UDP (User Datagram Protocol) packet type. This is used fo=
r inner packet only.<br>
-=C2=A0 =C2=A0 INNER_L4_UDP =3D auto()<br>
-=C2=A0 =C2=A0 #: Fragmented IP (Internet Protocol) packet type. This is us=
ed for inner packet only, and may<br>
-=C2=A0 =C2=A0 #: or maynot have a layer 4 packet.<br>
-=C2=A0 =C2=A0 INNER_L4_FRAG =3D auto()<br>
-=C2=A0 =C2=A0 #: SCTP (Stream Control Transmission Protocol) packet type. =
This is used for inner packet only.<br>
-=C2=A0 =C2=A0 INNER_L4_SCTP =3D auto()<br>
-=C2=A0 =C2=A0 #: ICMP (Internet Control Message Protocol) packet type. Thi=
s is used for inner packet only.<br>
-=C2=A0 =C2=A0 INNER_L4_ICMP =3D auto()<br>
-=C2=A0 =C2=A0 #: Non-fragmented IP (Internet Protocol) packet type. It is =
used for inner packet only, and may<br>
-=C2=A0 =C2=A0 #: or may not have other unknown layer 4 packet types.<br>
-=C2=A0 =C2=A0 INNER_L4_NONFRAG =3D auto()<br>
-=C2=A0 =C2=A0 #: No inner L4 information found on the packet.<br>
-=C2=A0 =C2=A0 INNER_L4_UNKNOWN =3D auto()<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_list_string(cls, names: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag from a whitespa=
ce-separated list of names.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names: a whitespace-separated li=
st containing the members of this flag.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name in names.split():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls.from_str(name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_str(cls, name: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a flag matching the su=
pplied name.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: a valid member of this fla=
g in text<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 An instance of this flag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 member_name =3D name.strip().replace(&quot;-&q=
uot;, &quot;_&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls[member_name]<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls, hw: bool) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Makes a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw: Whether to make a parser for=
 hardware ptypes or software ptypes. If :data:`True`,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hardware ptypes wi=
ll be collected, otherwise software pytpes will.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ParserFn: A dictionary for the `=
dataclasses.field` metadata argument containing a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser function th=
at makes an instance of this flag from text.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TextParser.wrap(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TextParser.find(f&quot;{&#39;hw&=
#39; if hw else &#39;sw&#39;} ptype: ([^-]+)&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cls.from_list_string,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdVerbosePacket(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Packet information provided by verbose out=
put in Testpmd.<br>
-<br>
-=C2=A0 =C2=A0 This dataclass expects that packet information be prepended =
with the starting line of packet<br>
-=C2=A0 =C2=A0 bursts. Specifically, the line that reads &quot;port X/queue=
 Y: sent/received Z packets&quot;.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: ID of the port that handled the packet.<br>
-=C2=A0 =C2=A0 port_id: int =3D field(metadata=3DTextParser.find_int(r&quot=
;port (\d+)/queue \d+&quot;))<br>
-=C2=A0 =C2=A0 #: ID of the queue that handled the packet.<br>
-=C2=A0 =C2=A0 queue_id: int =3D field(metadata=3DTextParser.find_int(r&quo=
t;port \d+/queue (\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Whether the packet was received or sent by the queue/port=
.<br>
-=C2=A0 =C2=A0 was_received: bool =3D field(metadata=3DTextParser.find(r&qu=
ot;received \d+ packets&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 src_mac: str =3D field(metadata=3DTextParser.find(f&quot;src=
=3D({REGEX_FOR_MAC_ADDRESS})&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 dst_mac: str =3D field(metadata=3DTextParser.find(f&quot;dst=
=3D({REGEX_FOR_MAC_ADDRESS})&quot;))<br>
-=C2=A0 =C2=A0 #: Memory pool the packet was handled on.<br>
-=C2=A0 =C2=A0 pool: str =3D field(metadata=3DTextParser.find(r&quot;pool=
=3D(\S+)&quot;))<br>
-=C2=A0 =C2=A0 #: Packet type in hex.<br>
-=C2=A0 =C2=A0 p_type: int =3D field(metadata=3DTextParser.find_int(r&quot;=
type=3D(0x[a-fA-F\d]+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 length: int =3D field(metadata=3DTextParser.find_int(r&quot;=
length=3D(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Number of segments in the packet.<br>
-=C2=A0 =C2=A0 nb_segs: int =3D field(metadata=3DTextParser.find_int(r&quot=
;nb_segs=3D(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #: Hardware packet type.<br>
-=C2=A0 =C2=A0 hw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_pars=
er(hw=3DTrue))<br>
-=C2=A0 =C2=A0 #: Software packet type.<br>
-=C2=A0 =C2=A0 sw_ptype: RtePTypes =3D field(metadata=3DRtePTypes.make_pars=
er(hw=3DFalse))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l2_len: int =3D field(metadata=3DTextParser.find_int(r&quot;=
l2_len=3D(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 ol_flags: PacketOffloadFlag =3D field(metadata=3DPacketOfflo=
adFlag.make_parser())<br>
-=C2=A0 =C2=A0 #: RSS hash of the packet in hex.<br>
-=C2=A0 =C2=A0 rss_hash: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;RSS hash=3D(0x[a-fA-F\d]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: RSS queue that handled the packet in hex.<br>
-=C2=A0 =C2=A0 rss_queue: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;RSS queue=3D(0x[a-fA-F\d]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l3_len: int | None =3D field(default=3DNone, metadata=3DText=
Parser.find_int(r&quot;l3_len=3D(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l4_len: int | None =3D field(default=3DNone, metadata=3DText=
Parser.find_int(r&quot;l4_len=3D(\d+)&quot;))<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 l4_dport: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Destinat=
ion (?:TCP|UDP) port=3D(\d+)&quot;),<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-<br>
-class RxOffloadCapability(Flag):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Rx offload capabilities of a device.<br>
-<br>
-=C2=A0 =C2=A0 The flags are taken from ``lib/ethdev/rte_ethdev.h``.<br>
-=C2=A0 =C2=A0 They&#39;re prefixed with ``RTE_ETH_RX_OFFLOAD`` in ``lib/et=
hdev/rte_ethdev.h``<br>
-=C2=A0 =C2=A0 instead of ``RX_OFFLOAD``, which is what testpmd changes the=
 prefix to.<br>
-=C2=A0 =C2=A0 The values are not contiguous, so the correspondence is pres=
erved<br>
-=C2=A0 =C2=A0 by specifying concrete values interspersed between auto() va=
lues.<br>
-<br>
-=C2=A0 =C2=A0 The ``RX_OFFLOAD`` prefix has been preserved so that the sam=
e flag names can be used<br>
-=C2=A0 =C2=A0 in :class:`NicCapability`. The prefix is needed in :class:`N=
icCapability` since there&#39;s<br>
-=C2=A0 =C2=A0 no other qualifier which would sufficiently distinguish it f=
rom other capabilities.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPDK lib: ``lib/ethdev/rte_ethdev.h``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:print_rx_offloads()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports L3 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports Large Receive Offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports QinQ (queue in queue) offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports inner packet L3 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports MACsec.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports filtering of a VLAN Tag identifier.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER =3D 1 &lt;&lt; 9<br>
-=C2=A0 =C2=A0 #: Device supports VLAN offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports receiving segmented mbufs.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER =3D 1 &lt;&lt; 13<br>
-=C2=A0 =C2=A0 #: Device supports Timestamp.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports crypto processing while packet is receive=
d in NIC.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports CRC stripping.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports inner packet L4 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports RSS hashing.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT =3D auto()<br>
-=C2=A0 =C2=A0 #: Device supports all checksum capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM =3D RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_U=
DP_CKSUM | RX_OFFLOAD_TCP_CKSUM<br>
-=C2=A0 =C2=A0 #: Device supports all VLAN capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_FILTER<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_VLAN_EXTEND<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 | RX_OFFLOAD_QINQ_STRIP<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def from_string(cls, line: str) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make an instance from a stri=
ng containing the flag names separated with a space.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line: The line to parse.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A new instance containing all fo=
und flags.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag =3D cls(0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flag_name in line.split():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag |=3D cls[f&quot;RX_OFFLOAD_=
{flag_name}&quot;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return flag<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def make_parser(cls, per_port: bool) -&gt; ParserFn:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Make a parser function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_port: If :data:`True`, will =
return capabilities per port. If :data:`False`,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will return capabi=
lities per queue.<br>
-<br>
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
-<br>
-<br>
-@dataclass<br>
-class RxOffloadCapabilities(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;The result of testpmd&#39;s ``show port &l=
t;port_id&gt; rx_offload capabilities`` command.<br>
-<br>
-=C2=A0 =C2=A0 References:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd command function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa()``<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd display function: ``app/test-pmd/cmdli=
ne.c:cmd_rx_offload_get_capa_parsed()``<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 port_id: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Rx Offlo=
ading Capabilities of port (\d+) :&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Per-queue Rx offload capabilities.<br>
-=C2=A0 =C2=A0 per_queue: RxOffloadCapability =3D field(metadata=3DRxOffloa=
dCapability.make_parser(False))<br>
-=C2=A0 =C2=A0 #: Capabilities other than per-queue Rx offload capabilities=
.<br>
-=C2=A0 =C2=A0 per_port: RxOffloadCapability =3D field(metadata=3DRxOffload=
Capability.make_parser(True))<br>
-<br>
-<br>
-@dataclass<br>
-class TestPmdPortFlowCtrl(TextParser):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Class representing a port&#39;s flow contr=
ol parameters.<br>
-<br>
-=C2=A0 =C2=A0 The parameters can also be parsed from the output of ``show =
port &lt;port_id&gt; flow_ctrl``.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: Enable Reactive Extensions.<br>
-=C2=A0 =C2=A0 rx: bool =3D field(default=3DFalse, metadata=3DTextParser.fi=
nd(r&quot;Rx pause: on&quot;))<br>
-=C2=A0 =C2=A0 #: Enable Transmit.<br>
-=C2=A0 =C2=A0 tx: bool =3D field(default=3DFalse, metadata=3DTextParser.fi=
nd(r&quot;Tx pause: on&quot;))<br>
-=C2=A0 =C2=A0 #: High threshold value to trigger XOFF.<br>
-=C2=A0 =C2=A0 high_water: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D0, metadata=3DTextParser.find_int(r&=
quot;High waterline: (0x[a-fA-F\d]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Low threshold value to trigger XON.<br>
-=C2=A0 =C2=A0 low_water: int =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3D0, metadata=3DTextParser.find_int(r&=
quot;Low waterline: (0x[a-fA-F\d]+)&quot;)<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Pause quota in the Pause frame.<br>
-=C2=A0 =C2=A0 pause_time: int =3D field(default=3D0, metadata=3DTextParser=
.find_int(r&quot;Pause time: (0x[a-fA-F\d]+)&quot;))<br>
-=C2=A0 =C2=A0 #: Send XON frame.<br>
-=C2=A0 =C2=A0 send_xon: bool =3D field(default=3DFalse, metadata=3DTextPar=
ser.find(r&quot;Tx pause: on&quot;))<br>
-=C2=A0 =C2=A0 #: Enable receiving MAC control frames.<br>
-=C2=A0 =C2=A0 mac_ctrl_frame_fwd: bool =3D field(default=3DFalse, metadata=
=3DTextParser.find(r&quot;Tx pause: on&quot;))<br>
-=C2=A0 =C2=A0 #: Change the auto-negotiation parameter.<br>
-=C2=A0 =C2=A0 autoneg: bool =3D field(default=3DFalse, metadata=3DTextPars=
er.find(r&quot;Autoneg: on&quot;))<br>
-<br>
-=C2=A0 =C2=A0 def __str__(self) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the string represent=
ation of this instance.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;rx {&#39;on&#39; if self.=
rx else &#39;off&#39;} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;tx {&#39;on&#39; if self.=
tx else &#39;off&#39;} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.high_water} &quot;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.low_water} &quot;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.pause_time} &quot;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{1 if self.send_xon else =
0} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;mac_ctrl_frame_fwd {&#39;=
on&#39; if self.mac_ctrl_frame_fwd else &#39;off&#39;} &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;autoneg {&#39;on&#39; if =
self.autoneg else &#39;off&#39;}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret<br>
-<br>
-<br>
-def requires_stopped_ports(func: TestPmdShellMethod) -&gt; TestPmdShellMet=
hod:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator for :class:`TestPmdShell` comman=
ds methods that require stopped ports.<br>
-<br>
-=C2=A0 =C2=A0 If the decorated method is called while the ports are starte=
d, then these are stopped before<br>
-=C2=A0 =C2=A0 continuing.<br>
-<br>
-=C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 func: The :class:`TestPmdShell` method to deco=
rate.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 @functools.wraps(func)<br>
-=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.ports_started:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Ports n=
eed to be stopped to continue.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stop_all_ports()<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(self, *args, **kwargs)<br>
-<br>
-=C2=A0 =C2=A0 return _wrapper<br>
-<br>
-<br>
-def requires_started_ports(func: TestPmdShellMethod) -&gt; TestPmdShellMet=
hod:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Decorator for :class:`TestPmdShell` comman=
ds methods that require started ports.<br>
-<br>
-=C2=A0 =C2=A0 If the decorated method is called while the ports are stoppe=
d, then these are started before<br>
-=C2=A0 =C2=A0 continuing.<br>
-<br>
-=C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 func: The :class:`TestPmdShell` method to deco=
rate.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 @functools.wraps(func)<br>
-=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.ports_started:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Ports n=
eed to be started to continue.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_all_ports()<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return func(self, *args, **kwargs)<br>
-<br>
-=C2=A0 =C2=A0 return _wrapper<br>
-<br>
-<br>
-def add_remove_mtu(mtu: int =3D 1500) -&gt; Callable[[TestPmdShellMethod],=
 TestPmdShellMethod]:<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Configure MTU to `mtu` on all ports, run t=
he decorated function, then revert.<br>
-<br>
-=C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: The MTU to configure all ports on.<br>
-<br>
-=C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The method decorated with setting and revertin=
g MTU.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 def decorator(func: TestPmdShellMethod) -&gt; TestPmdShellMe=
thod:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 @functools.wraps(func)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmdShell&quot;, *a=
rgs: P.args, **kwargs: P.kwargs):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 original_mtu =3D self.ports[0].m=
tu<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu_all(mtu=3Dmtu,=
 verify=3DFalse)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D func(self, *args, **k=
wargs)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu_all(original_m=
tu if original_mtu else 1500, verify=3DFalse)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return wrapper<br>
-<br>
-=C2=A0 =C2=A0 return decorator<br>
-<br>
-<br>
-class TestPmdShell(DPDKShell):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Testpmd interactive shell.<br>
-<br>
-=C2=A0 =C2=A0 The testpmd shell users should never use<br>
-=C2=A0 =C2=A0 the :meth:`~.interactive_shell.InteractiveShell.send_command=
` method directly, but rather<br>
-=C2=A0 =C2=A0 call specialized methods. If there isn&#39;t one that satisf=
ies a need, it should be added.<br>
-<br>
-=C2=A0 =C2=A0 Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ports_started: Indicates whether the ports are=
 started.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 _app_params: TestPmdParams<br>
-=C2=A0 =C2=A0 _ports: list[TestPmdPort] | None<br>
-<br>
-=C2=A0 =C2=A0 #: The testpmd&#39;s prompt.<br>
-=C2=A0 =C2=A0 _default_prompt: ClassVar[str] =3D &quot;testpmd&gt;&quot;<b=
r>
-<br>
-=C2=A0 =C2=A0 #: This forces the prompt to appear after sending a command.=
<br>
-=C2=A0 =C2=A0 _command_extra_chars: ClassVar[str] =3D &quot;\n&quot;<br>
-<br>
-=C2=A0 =C2=A0 ports_started: bool<br>
-<br>
-=C2=A0 =C2=A0 def __init__(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str | None =3D None,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: bool =3D True,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 **app_params: Unpack[TestPmdParamsDict],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.dpdk_shel=
l.DPDKShell.__init__`. Changes app_params to kwargs.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;port_topology&quot; not in app_params=
 and get_ctx().topology.type is TopologyType.one_link:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params[&quot;port_topology&q=
uot;] =3D PortTopology.loop<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, privileged, app_params=
=3DTestPmdParams(**app_params))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D not self._app_params.di=
sable_device_start<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D None<br>
-<br>
-=C2=A0 =C2=A0 @property<br>
-=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The path to the testpmd exec=
utable.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return PurePath(&quot;app/dpdk-testpmd&quot;)<=
br>
-<br>
-=C2=A0 =C2=A0 @property<br>
-=C2=A0 =C2=A0 def ports(self) -&gt; list[TestPmdPort]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The ports of the instance.<b=
r>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 This caches the ports returned by :meth:`show_=
port_info_all`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 To force an update of port information, execut=
e :meth:`show_port_info_all` or<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :meth:`show_port_info`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns: The list of known testpmd ports.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._ports is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.show_port_info_all()=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._ports<br>
-<br>
-=C2=A0 =C2=A0 @requires_started_ports<br>
-=C2=A0 =C2=A0 def start(self, verify: bool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start packet forwarding with=
 the current configuration.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` , a seco=
nd start command will be sent in an attempt to verify<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet forwarding =
started as expected.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and forwarding fails to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start or ports fai=
l to come up.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;start&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If forwarding was already star=
ted, sending &quot;start&quot; again should tell us<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start_cmd_output =3D self.send_c=
ommand(&quot;start&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Packet forwarding alrea=
dy started&quot; not in start_cmd_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to start packet forwarding: \n{start_cmd_output}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Testpmd failed to start packet forwarding.&quot;=
)<br>
-<br>
-=C2=A0 =C2=A0 def stop(self, verify: bool =3D True) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stop packet forwarding.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` , the ou=
tput of the stop command is scanned to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding was sto=
pped successfully or not started. If neither is found, it is<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 considered an erro=
r.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command to stop<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forwarding results=
 in an error.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Output gathered from the stop co=
mmand and all other preceding logs in the buffer. This<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output is most often used to vie=
w forwarding statistics that are displayed when this<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command is sent as well as any v=
erbose packet information that hasn&#39;t been consumed<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prior to calling this method.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_cmd_output =3D self.send_command(&quot;st=
op&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Done.&quot; =
not in stop_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and &quot;Packet f=
orwarding not started&quot; not in stop_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to stop packet forwarding: \n{stop_cmd_output}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Testpmd failed to stop packet forwarding.&quot;)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return stop_cmd_output<br>
-<br>
-=C2=A0 =C2=A0 def get_devices(self) -&gt; list[TestPmdDevice]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get a list of device names t=
hat are known to testpmd.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Uses the device info listed in testpmd and the=
n parses the output.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A list of devices.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info: str =3D self.send_command(&quot;show=
 device info all&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_list: list[TestPmdDevice] =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in dev_info.split(&quot;\n&quot;):<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;device name:&quot; in l=
ine.lower():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_list.append(Te=
stPmdDevice(line))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return dev_list<br>
-<br>
-=C2=A0 =C2=A0 def wait_link_status_up(self, port_id: int, timeout=3DSETTIN=
GS.timeout) -&gt; bool:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Wait until the link status o=
n the given port is &quot;up&quot;.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arguments:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Port to check the link =
status on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout: Time to wait for the li=
nk to come up. The default value for this<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argument may be mo=
dified using the :option:`--timeout` command-line argument<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or the :envvar:`DT=
S_TIMEOUT` environment variable.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Whether the link came up in time=
 or not.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_to_stop =3D time.time() + timeout<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_info: str =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while time.time() &lt; time_to_stop:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_info =3D self.send_command(=
f&quot;show port info {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Link status: up&quot; i=
n port_info:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error(f&quot;The li=
nk for port {port_id} did not come up in the given timeout.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;Link status: up&quot; in port_inf=
o<br>
-<br>
-=C2=A0 =C2=A0 def set_forward_mode(self, mode: SimpleForwardingModes, veri=
fy: bool =3D True):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set packet forwarding mode.<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode: The forwarding mode to use=
.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the fo=
rwarding mode was set to `mode` properly.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the forwarding mode<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_fwd_output =3D self.send_command(f&quot;se=
t fwd {mode.value}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f&quot;Set {mode.value} packe=
t forwarding mode&quot; not in set_fwd_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to set fwd mode to {mode.value}:\n{set_fwd_output}&quot;)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to set fwd mode to {mode.value}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def stop_all_ports(self, verify: bool =3D True) -&gt; None:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stops all the ports.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command will be checked for a successful<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execution.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the ports were not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stopped successful=
ly.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Stopping all the port=
s...&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;port stop a=
ll&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and not output.strip().endswith(&quo=
t;Done&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Ports were not stopped successfully.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D False<br>
-<br>
-=C2=A0 =C2=A0 def start_all_ports(self, verify: bool =3D True) -&gt; None:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Starts all the ports.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command will be checked for a successful<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 execution.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the ports were not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 started successful=
ly.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Starting all the port=
s...&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;port start =
all&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and not output.strip().endswith(&quo=
t;Done&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Ports were not started successfully.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports_started =3D True<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def set_ports_queues(self, number_of: int) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the number of queues pe=
r port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of: The number of RX/TX q=
ueues to create per port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If `number_of` is=
 invalid.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if number_of &lt; 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalError(&quot;The nu=
mber of queues must be positive and non-zero.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config all rxq {=
number_of}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config all txq {=
number_of}&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def close_all_ports(self, verify: bool =3D True) -&gt; None:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Close all ports.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the close command will be scanned in an attempt<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to verify that all=
 ports were stopped successfully. Defaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and at lease one port<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 failed to close.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_close_output =3D self.send_command(&quot;=
port close all&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_ports =3D len(self.ports)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not all(f&quot;Port {p_id} is=
 closed&quot; in port_close_output for p_id in range(num_ports)):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Ports were not closed successfully.&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def show_port_info_all(self) -&gt; list[TestPmdPort]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the information of a=
ll the ports.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[TestPmdPort]: A list contai=
ning all the ports information as `TestPmdPort`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;show port i=
nfo all&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sample output of the &quot;all&quot; command=
 looks like:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;start&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0********************* Infos for =
port 0 *********************<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0Key: value<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0********************* Infos for =
port 1 *********************<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0Key: value<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;end&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Takes advantage of the double new line in be=
tween ports as end delimiter. But we need to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # artificially add a new line at the end to pi=
ck up the last port. Because commands are<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # executed on a pseudo-terminal created by par=
amiko on the remote node, lines end with CRLF.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Therefore we also need to take the carriage =
return into account.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(r&quot;\*{21}.*?[\r\n]{4}=
&quot;, output + &quot;\r\n&quot;, re.S)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D [TestPmdPort.parse(block.group=
(0)) for block in iter]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._ports<br>
-<br>
-=C2=A0 =C2=A0 def show_port_info(self, port_id: int) -&gt; TestPmdPort:<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the given port infor=
mation.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID to gather i=
nformation for.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `port_id` is invalid.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdPort: An instance of `Tes=
tPmdPort` containing the given port&#39;s information.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
info {port_id}&quot;, skip_first_line=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.startswith(&quot;Invalid port&quot;)=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;invalid port given&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port =3D TestPmdPort.parse(output)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_port(port)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return port<br>
-<br>
-=C2=A0 =C2=A0 def _update_port(self, port: TestPmdPort) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._ports:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ports =3D [<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 existing_port if <=
a href=3D"http://port.id" rel=3D"noreferrer" target=3D"_blank">port.id</a> =
!=3D <a href=3D"http://existing_port.id" rel=3D"noreferrer" target=3D"_blan=
k">existing_port.id</a> else port<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for existing_port =
in self._ports<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
-<br>
-=C2=A0 =C2=A0 def set_mac_addr(self, port_id: int, mac_address: str, add: =
bool, verify: bool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove a mac address =
on a given port&#39;s Allowlist.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID the mac add=
ress is set on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_address: The mac address to =
be added to or removed from the specified port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: If :data:`True`, add the sp=
ecified mac address. If :data:`False`, remove specified<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac address.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:&#39;True&#39;,=
 assert that the &#39;mac_addr&#39; operation was successful. If<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :data:&#39;False&#=
39;, run the command and skip this assertion.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If the set mac address operation fails.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_cmd =3D &quot;add&quot; if add else &quot;=
remove&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mac_addr {=
mac_cmd} {port_id} {mac_address}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Bad arguments&quot; in output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Invalid=
 argument provided to mac_addr&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Invalid argument provided&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;mac_addr_cmd error:&quo=
t; in output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to {mac_cmd} {mac_address} on port {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {mac_cmd} {mac_address} on port {port_id} \n{output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def set_multicast_mac_addr(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, multi_addr: str, add: bool=
, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove multicast mac =
address to a specified port&#39;s allow list.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID the multica=
st address is set on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multi_addr: The multicast addres=
s to be added or removed from the filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: If :data:&#39;True&#39;, ad=
d the specified multicast address to the port filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If :data:&#39;Fals=
e&#39;, remove the specified multicast address from the port filter.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:&#39;True&#39;,=
 assert that the &#39;mcast_addr&#39; operations was successful.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 If :data:&#39;Fals=
e&#39;, execute the &#39;mcast_addr&#39; operation and skip the assertion.<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If either the &#39;add&#39; or &#39;remove&#39; operations fails.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcast_cmd =3D &quot;add&quot; if add else &quo=
t;remove&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mcast_addr=
 {mcast_cmd} {port_id} {multi_addr}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Bad arguments&quot; in output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Invalid=
 arguments provided to mcast_addr&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Invalid argument provided&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Invalid mult=
icast_addr&quot; in output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or f&quot;multicas=
t address {&#39;already&#39; if add else &#39;not&#39;} filtered by port&qu=
ot; in output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to {mcast_cmd} {multi_addr} on port {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to {mcast_cmd} {multi_addr} on port {port_id} \n{output}&quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def show_port_stats_all(self) -&gt; Tuple[list[TestPmdPortSt=
ats], str]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the statistics of al=
l the ports.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuple[str, list[TestPmdPortStats=
]]: A tuple where the first element is the stats of all<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ports as `TestPmdPortStats` and =
second is the raw testpmd output that was collected<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from the sent command.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(&quot;show port s=
tats all&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Sample output of the &quot;all&quot; command=
 looks like:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0########### NIC statistics for p=
ort 0 ###########<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0values...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0################################=
#################<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0########### NIC statistics for p=
ort 1 ###########<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0values...<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0################################=
#################<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(r&quot;(^=C2=A0 #*.+#*$[^=
#]+)^=C2=A0 #*\r$&quot;, output, re.MULTILINE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ([TestPmdPortStats.parse(block.group(1)=
) for block in iter], output)<br>
-<br>
-=C2=A0 =C2=A0 def show_port_stats(self, port_id: int) -&gt; TestPmdPortSta=
ts:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the given port stati=
stics.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port ID to gather i=
nformation for.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `port_id` is invalid.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdPortStats: An instance of=
 `TestPmdPortStats` containing the given port&#39;s stats.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
stats {port_id}&quot;, skip_first_line=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.startswith(&quot;Invalid port&quot;)=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;invalid port given&quot;)<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TestPmdPortStats.parse(output)<br>
-<br>
-=C2=A0 =C2=A0 def set_multicast_all(self, on: bool, verify: bool =3D True)=
 -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Turns multicast mode on/off =
for the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True`, turns multi=
cast mode on, otherwise turns off.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that multicast mod=
e is properly set. Defaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and multicast<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode is not proper=
ly set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 multicast_cmd_output =3D self.send_command(f&q=
uot;set allmulti all {&#39;on&#39; if on else &#39;off&#39;}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_stats =3D self.show_port_in=
fo_all()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if on ^ all(stats.is_allmulticas=
t_mode_enabled for stats in port_stats):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set multicast mode on all ports.: \n{multicast_cmd_output}&quo=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Testpmd failed to set multicast mode on all ports.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def csum_set_hw(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, layers: ChecksumOffloadOptions, port_id:=
 int, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enables hardware checksum of=
floading on the specified layer.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layers: The layer/layers that ch=
ecksum offloading should be enabled on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port number to enab=
le checksum offloading on, should be within 0-32.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that checks=
um offloading was enabled on the port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If checksum offload is not enabled successfully.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for name, offload in ChecksumOffloadOptions.__=
members__.items():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if offload in layers:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D name.repl=
ace(&quot;_&quot;, &quot;-&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csum_output =3D se=
lf.send_command(f&quot;csum set {name} hw {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Bad arguments&quot; in csum_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or f&quot;Please stop port {port_id} first&quot; in csum_output<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or f&quot;checksum offload is not supported by port {port_id}&qu=
ot; in csum_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 self._logger.debug(f&quot;Csum set hw error:\n{csum_output}&quot=
;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 raise InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to set csum hw {name} mode on port {=
port_id}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 success =3D False<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f&quot;{name} c=
hecksum offload is hw&quot; in csum_output.lower():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 succ=
ess =3D True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not success and=
 verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to set csum hw mode on port {port_id}:\n{csum_outp=
ut}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;&quot;&quot;Failed to set csum hw mode on port<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{port_id}:\n{=
csum_output}&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-<br>
-=C2=A0 =C2=A0 def flow_create(self, flow_rule: FlowRule, port_id: int) -&g=
t; int:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Creates a flow rule in the t=
estpmd session.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 This command is implicitly verified as needed =
to return the created flow rule id.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: :class:`FlowRule` obj=
ect used for creating testpmd flow rule.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If flow rule is invalid.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Id of created flow rule.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
create {port_id} {flow_rule}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D re.search(r&quot;#(\d+)&quot;, flow_=
output)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if match is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match_str =3D match.group(1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id =3D int(match_str)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return flow_id<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;Failed=
 to create flow rule:\n{flow_output}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(f&quot;Failed to create flow rule:\n{flow_output}&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def flow_validate(self, flow_rule: FlowRule, port_id: int) -=
&gt; bool:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Validates a flow rule in the=
 testpmd session.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: :class:`FlowRule` obj=
ect used for validating testpmd flow rule.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Boolean representing whether rul=
e is valid or not.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
validate {port_id} {flow_rule}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow rule validated&quot; in flow_out=
put:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
-<br>
-=C2=A0 =C2=A0 def flow_delete(self, flow_id: int, port_id: int, verify: bo=
ol =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Deletes the specified flow r=
ule from the testpmd session.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id: ID of the flow to remov=
e.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: Integer representing th=
e port to use.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to ensure the flow=
 rule was deleted successfully.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If flow rule is invalid.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_output =3D self.send_command(f&quot;flow =
destroy {port_id} rule {flow_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;destroyed&quot; not in =
flow_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to delete flow rule:\n{flow_output}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to delete flow rule:\n{flow_output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @requires_started_ports<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def set_port_mtu(self, port_id: int, mtu: int, verify: bool =
=3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Change the MTU of a port usi=
ng testpmd.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Some PMDs require that the port be stopped bef=
ore changing the MTU, and it does no harm to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop the port before configuring in cases wher=
e it isn&#39;t required, so ports are stopped<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prior to changing their MTU. On the other hand=
, some PMDs require that the port had already<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 been started once since testpmd startup. There=
fore, ports are also started before stopping<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 them to ensure this has happened.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to adjus=
t the MTU on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: Desired value for the MTU t=
o be set to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If `verify` is :data:`Tr=
ue` then the output will be scanned in an attempt to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the mt=
u was properly set on the port. Defaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the MTU was not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 properly updated o=
n the port matching `port_id`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mtu_output =3D self.send_command(f&quot;po=
rt config mtu {port_id} {mtu}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and (f&quot;MTU: {mtu}&quot; not in =
self.send_command(f&quot;show port info {port_id}&quot;)):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to s=
et mtu to {mtu} on port {port_id}. Output was:\n{set_mtu_output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd fa=
iled to update mtu of port {port_id} to {mtu}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def set_port_mtu_all(self, mtu: int, verify: bool =3D True) =
-&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Change the MTU of all ports =
using testpmd.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Runs :meth:`set_port_mtu` for every port that =
testpmd is aware of.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtu: Desired value for the MTU t=
o be set to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: Whether to verify that s=
etting the MTU on each port was successful or not.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Defaults to :data:=
`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the MTU was not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 properly updated o=
n at least one port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.ports:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_port_mtu(<a href=3D"htt=
p://port.id" rel=3D"noreferrer" target=3D"_blank">port.id</a>, mtu, verify)=
<br>
-<br>
-=C2=A0 =C2=A0 @staticmethod<br>
-=C2=A0 =C2=A0 def extract_verbose_output(output: str) -&gt; list[TestPmdVe=
rbosePacket]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Extract the verbose informat=
ion present in given testpmd output.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 This method extracts sections of verbose outpu=
t that begin with the line<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;port X/queue Y: sent/received Z packets&=
quot; and end with the ol_flags of a packet.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: Testpmd output that cont=
ains verbose information<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 List of parsed packet informatio=
n gathered from verbose information in `output`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out: list[TestPmdVerbosePacket] =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_header: str =3D &quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 iter =3D re.finditer(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;(?P&lt;HEADER&gt;(?:port =
\d+/queue \d+: (?:received|sent) \d+ packets)?)\s*&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r&quot;(?P&lt;PACKET&gt;src=3D[\=
w\s=3D:-]+?ol_flags: [\w ]+)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for match in iter:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if match.group(&quot;HEADER&quot=
;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_header =3D ma=
tch.group(&quot;HEADER&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out.append(TestPmdVerbosePacket.=
parse(f&quot;{prev_header}\n{match.group(&#39;PACKET&#39;)}&quot;))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return out<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def set_vlan_filter(self, port: int, enable: bool, verify: b=
ool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set vlan filter on.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to enable =
VLAN filter on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: Enable the filter on `po=
rt` if :data:`True`, otherwise disable it.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command and show port info<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is scanned to veri=
fy that vlan filtering was set successfully.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the filter<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 filter_cmd_output =3D self.send_command(f&quot=
;vlan set filter {&#39;on&#39; if enable else &#39;off&#39;} {port}&quot;)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan_settings =3D self.show_port=
_info(port_id=3Dport).vlan_offload<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ (vlan_settings is no=
t None and VLANOffloadFlag.FILTER in vlan_settings):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;enable&quot; if enable else &quot;disable&q=
uot;}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filter on port {port}: =
\n{filter_cmd_output}&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;enable&quot; if enable else &quot;disable&q=
uot;}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filt=
er on port {port}&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def set_mac_address(self, port: int, mac_address: str, verif=
y: bool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set port&#39;s MAC address.<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mac_address: The MAC address to =
set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the mac address is=
 set in the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to execute.<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;mac_addr s=
et {port} {mac_address}&quot;, skip_first_line=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.strip():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set MAC address {mac_address} on port {port}.&quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set MAC address {mac_address} on port {port}.&quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def set_flow_control(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port: int, flow_ctrl: TestPmdPortFlowCtr=
l, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the given `port`&#39;s f=
low control.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_ctrl: The requested flow co=
ntrol parameters.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the flow control i=
n the specified port is set.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the command<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to execute.<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;set flow_c=
trl {flow_ctrl} {port}&quot;, skip_first_line=3DTrue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.strip():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Testpmd failed to set the {flow_ctrl} in port {port}.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set the {flow_ctrl} in port {port}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def show_port_flow_info(self, port: int) -&gt; TestPmdPortFl=
owCtrl | None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Show port info flow.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The number of the requeste=
d port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The current port flow control pa=
rameters if supported, otherwise :data:`None`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(f&quot;show port =
{port} flow_ctrl&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow control infos&quot; in output:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TestPmdPortFlowCtrl.parse=
(output)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def rx_vlan(self, vlan: int, port: int, add: bool, verify: b=
ool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add specified vlan tag to th=
e filter list on a port. Requires vlan filter to be on.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan: The vlan tag to add, shoul=
d be within 1-1005.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to add the=
 tag on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add: Adds the tag if :data:`True=
`, otherwise removes the tag.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the vlan tag was a=
dded to the filter list on the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the tag<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not added.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmd_output =3D self.send_command(f&quot;rx_=
vlan {&#39;add&#39; if add else &#39;rm&#39;} {vlan} {port}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;VLAN-filteri=
ng disabled&quot; in rx_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;Invalid v=
lan_id&quot; in rx_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;Bad argum=
ents&quot; in rx_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to {&quot;add&quot; if add else &quot;remove&quot;} t=
ag {vlan}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
 {port}: \n{rx_cmd_output}&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to {&#39;add&#39; if add else &#39;remove&#39;} tag {vlan=
} on port {port}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def set_vlan_strip(self, port: int, enable: bool, verify: bo=
ol =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enable or disable vlan strip=
ping on the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to use.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, will tu=
rn vlan stripping on, otherwise will turn off.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command and show port info<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is scanned to veri=
fy that vlan stripping was enabled on the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and stripping<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fails to update.<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 strip_cmd_output =3D self.send_command(f&quot;=
vlan set strip {&#39;on&#39; if enable else &#39;off&#39;} {port}&quot;)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan_settings =3D self.show_port=
_info(port_id=3Dport).vlan_offload<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ (vlan_settings is no=
t None and VLANOffloadFlag.STRIP in vlan_settings):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;&quot;&quot;Failed to set strip {&quot;on&quot; if enable else &quot;off=
&quot;}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
 {port}: \n{strip_cmd_output}&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set strip {&#39;on&#39; if enable else &#39;off&#39;} =
port {port}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def tx_vlan_set(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port: int, enable: bool, vlan: int | Non=
e =3D None, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set hardware insertion of vl=
an tags in packets sent on a port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The port number to use.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: Sets vlan tag insertion =
if :data:`True`, and resets if :data:`False`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan: The vlan tag to insert if =
enable is :data:`True`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vlan insertion was=
 enabled on the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the insertion<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag is not set.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_vlan_cmd_output =3D self.send=
_command(f&quot;tx_vlan set {port} {vlan}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Please stop port&quot; in tx_vlan_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &=
quot;Invalid vlan_id&quot; in tx_vlan_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &=
quot;Invalid port&quot; in tx_vlan_cmd_output<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to set vlan tag {vlan} on port {port}:\n{tx_vlan_c=
md_output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Testpmd failed to set vlan insertion tag {vlan} on port {=
port}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_vlan_cmd_output =3D self.send=
_command(f&quot;tx_vlan reset {port}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Please st=
op port&quot; in tx_vlan_cmd_output or &quot;Invalid port&quot; in tx_vlan_=
cmd_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._logger.debug(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Failed to reset vlan insertion on port {port}: \n{tx_vlan=
_cmd_output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Testpmd failed to reset vlan insertion on port {port}.&qu=
ot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-<br>
-=C2=A0 =C2=A0 def set_promisc(self, port: int, enable: bool, verify: bool =
=3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Enable or disable promiscuou=
s mode for the specified port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: Port number to use.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, turn pr=
omiscuous mode on, otherwise turn off.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify that<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 promiscuous mode i=
s properly set. Defaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and promiscuous mode<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not correctly s=
et.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 promisc_cmd_output =3D self.send_command(f&quo=
t;set promisc {port} {&#39;on&#39; if enable else &#39;off&#39;}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D self.show_port_info(po=
rt_id=3Dport)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if enable ^ stats.is_promiscuous=
_mode_enabled:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set promiscuous mode on port {port}: \n{promisc_cmd_output}&qu=
ot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set promiscuous mode on port {port}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def set_verbose(self, level: int, verify: bool =3D True) -&g=
t; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set debug verbosity level.<b=
r>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 level: 0 - silent except for err=
or<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 - fully verbose =
except for Tx packets<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 - fully verbose =
except for Rx packets<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;2 - fully verb=
ose<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the comm=
and output will be scanned to verify that verbose level<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is properly set. D=
efaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and verbose level<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not correctly set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verbose_cmd_output =3D self.send_command(f&quo=
t;set verbose {level}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Change verbose level&qu=
ot; not in verbose_cmd_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to set verbose level to {level}: \n{verbose_cmd_output}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set verbose level to {level}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool=
, verify: bool =3D True) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Add or remove vxlan id to/fr=
om filter list.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_id: VXLAN ID to add to por=
t filter list.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to modif=
y VXLAN filter of.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable: If :data:`True`, adds sp=
ecified VXLAN ID, otherwise removes it.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is checked to verify<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the VXLAN ID was s=
uccessfully added/removed from the port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and VXLAN ID<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is not successfull=
y added or removed.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot;add&quot; if enable else &quo=
t;rm&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vxlan_output =3D self.send_command(f&quot;rx_v=
xlan_port {action} {vxlan_id} {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;udp tunneling add error=
&quot; in vxlan_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to set VXLAN:\n{vxlan_output}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(f&quot;Failed to set VXLAN:\n{vxlan_output}&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def clear_port_stats(self, port_id: int, verify: bool =3D Tr=
ue) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Clear statistics of a given =
port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port to clear=
 the statistics on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned to verify that it was<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 successful, otherw=
ise failures will be ignored. Defaults to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and testpmd fails to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear the statisti=
cs of the given port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_output =3D self.send_command(f&quot;clea=
r port stats {port_id}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and f&quot;NIC statistics for port {=
port_id} cleared&quot; not in clear_output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd fa=
iled to set clear forwarding stats on port {port_id}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def clear_port_stats_all(self, verify: bool =3D True) -&gt; =
None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Clear the statistics of all =
ports that testpmd is aware of.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned to verify that all<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ports had their st=
atistics cleared, otherwise failures will be ignored. Defaults to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and testpmd fails to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear the statisti=
cs of any of its ports.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_output =3D self.send_command(&quot;clear=
 port stats all&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if type(self._app_params.port_nu=
ma_config) is list:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port_id in ran=
ge(len(self._app_params.port_numa_config)):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f=
&quot;NIC statistics for port {port_id} cleared&quot; not in clear_output:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 raise InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Test pmd failed to set clear forwarding sta=
ts on port {port_id}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @only_active<br>
-=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.interacti=
ve_shell.close`.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.stop()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;quit&quot;, &quot;Bye.=
..&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return super().close()<br>
-<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=
=3D=3D<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 def get_capabilities_rx_offload(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all rx offload capabilit=
ies and divide them into supported and unsupported.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting rx offload ca=
pabilities.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {self.ports[0].id=
} rx_offload capabilities&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities_out =3D self.send_comm=
and(command)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities =3D RxOffloadCapabilit=
ies.parse(rx_offload_capabilities_out)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_flag(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RxOffloadCapability,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_offload_capabilities.per_port=
 | rx_offload_capabilities.per_queue,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def get_port_queue_info(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool<br>
-=C2=A0 =C2=A0 ) -&gt; TestPmdQueueInfo:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the current state of=
 the specified queue.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show {&#39;rxq&#39; if is_r=
x_queue else &#39;txq&#39;} info {port_id} {queue_id}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_info =3D TestPmdQueueInfo.parse(self.sen=
d_command(command))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return queue_info<br>
-<br>
-=C2=A0 =C2=A0 def setup_port_queue(self, port_id: int, queue_id: int, is_r=
x_queue: bool) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Setup a given queue on a por=
t.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 This functionality cannot be verified because =
the setup action only takes effect when the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue is started.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port where th=
e queue resides.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to set=
up.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to se=
tup. If :data:`True` an RX queue will be setup,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be setup.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port {port_id} {&#39;=
rxq&#39; if is_rx_queue else &#39;txq&#39;} {queue_id} setup&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def stop_port_queue(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Stops a given queue on a por=
t.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port that the=
 queue belongs to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to sto=
p.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to st=
op. If :data:`True` an RX queue will be stopped,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be stopped.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to verify the queue stopped.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Defaults to :data:=
`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the queue fails to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_type =3D &quot;rxq&quot; if is_rx_queue e=
lse &quot;txq&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_cmd_output =3D self.send_command(f&quot;p=
ort {port_id} {port_type} {queue_id} stop&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_started =3D self.get_port_=
queue_info(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id, queue_id,=
 is_rx_queue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ).is_queue_started<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if queue_started:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to stop {port_type} {queue_id} on port {port_id}:\n{stop_cmd_outp=
ut}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to stop {port_type} {queue_id} on port {port_id}&quot;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def start_port_queue(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, verify: bool =3D True<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Starts a given queue on a po=
rt.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 First sets up the port queue, then starts it.<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: ID of the port that the=
 queue belongs to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: ID of the queue to sta=
rt.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Type of queue to st=
art. If :data:`True` an RX queue will be started,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 otherwise a TX que=
ue will be started.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: if :data:`True` an addit=
ional command will be sent to verify that the queue was<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 started. Defaults =
to :data:`True`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and the queue fails to<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_type =3D &quot;rxq&quot; if is_rx_queue e=
lse &quot;txq&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_port_queue(port_id, queue_id, is_rx=
_queue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 start_cmd_output =3D self.send_command(f&quot;=
port {port_id} {port_type} {queue_id} start&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_started =3D self.get_port_=
queue_info(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id, queue_id,=
 is_rx_queue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ).is_queue_started<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not queue_started:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to start {port_type} {queue_id} on port {port_id}:\n{start_cmd_ou=
tput}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Test pmd failed to start {port_type} {queue_id} on port {port_id}&quot;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def get_queue_ring_size(self, port_id: int, queue_id: int, i=
s_rx_queue: bool) -&gt; int:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Returns the current size of =
the ring on the specified queue.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show {&#39;rxq&#39; if is_r=
x_queue else &#39;txq&#39;} info {port_id} {queue_id}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_info =3D TestPmdQueueInfo.parse(self.sen=
d_command(command))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return queue_info.ring_size<br>
-<br>
-=C2=A0 =C2=A0 def set_queue_ring_size(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: int,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 size: int,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: bool,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Update the ring size of an R=
x/Tx queue on a given port.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Queue is setup after setting the ring size so =
that the queue info reflects this change and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 it can be verified.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port that the queue=
 resides on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue on=
 the port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size: The size to update the rin=
g size to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Whether to modify a=
n RX or TX queue. If :data:`True` an RX queue will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updated, otherwise=
 a TX queue will be updated.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` an addit=
ional command will be sent to check the ring size of<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the queue in an at=
tempt to validate that the size was changes properly.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True` and there is a failure<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 when updating ring=
 size.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_type =3D &quot;rxq&quot; if is_rx_queue =
else &quot;txq&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port config {port_id}=
 {queue_type} {queue_id} ring_size {size}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_port_queue(port_id, queue_id, is_rx=
_queue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_ring_size =3D self.get_queu=
e_ring_size(port_id, queue_id, is_rx_queue)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if curr_ring_size !=3D size:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed up update ring size of queue {queue_id} on port {port_id}. Curren=
t&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot; ring size is {curr_ring_size}.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to update ring size of queue {queue_id} on port {port_id}&quot;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 @requires_stopped_ports<br>
-=C2=A0 =C2=A0 def set_queue_deferred_start(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, queue_id: int, is_rx_queue=
: bool, on: bool<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the deferred start attri=
bute of the specified queue on/off.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port that the queue=
 resides on.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue on=
 the port.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_rx_queue: Whether to modify a=
n RX or TX queue. If :data:`True` an RX queue will be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updated, otherwise=
 a TX queue will be updated.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: Whether to set deferred star=
t mode on or off. If :data:`True` deferred start will<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be turned on, othe=
rwise it will be turned off.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_type =3D &quot;rxq&quot; if is_rx_queue =
else &quot;txq&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D &quot;on&quot; if on else &quot;off=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;port {port_id} {queue=
_type} {queue_id} deferred_start {action}&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def _update_capabilities_from_flag(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 flag_class: type[Flag],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_flags: Flag,<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Divide all flags from `flag_=
class` into supported and unsupported.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for flag in flag_class:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if flag in supported_flags:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabili=
ties.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer" =
target=3D"_blank">flag.name</a>)])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabi=
lities.add(NicCapability[str(<a href=3D"http://flag.name" rel=3D"noreferrer=
" target=3D"_blank">flag.name</a>)])<br>
-<br>
-=C2=A0 =C2=A0 @requires_started_ports<br>
-=C2=A0 =C2=A0 def get_capabilities_rxq_info(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all rxq capabilities and=
 divide them into supported and unsupported.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting rxq capabilit=
ies.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show rxq info {self.ports[0=
].id} 0&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq_info =3D TestPmdRxqInfo.parse(self.send_co=
mmand(command))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if rxq_info.scattered_packets:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.SCATTERED_RX_ENABLED)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.SCATTERED_RX_ENABLED)<br>
-<br>
-=C2=A0 =C2=A0 def get_capabilities_show_port_info(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get all capabilities from sh=
ow port info and divide them into supported and unsupported.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._update_capabilities_from_flag(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceCapabilitiesFlag,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ports[0].device_capabilitie=
s,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def get_capabilities_mcast_filtering(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get multicast filtering capa=
bility from mcast_addr add and check for testpmd error code.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting mcast filter =
capabilities.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;mcast_addr add {self.ports[=
0].id} 01:00:5E:00:00:00&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(command)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;diag=3D-95&quot; in output:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.MCAST_FILTERING)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.MCAST_FILTERING)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D str.replace(command,=
 &quot;add&quot;, &quot;remove&quot;, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(command)<br>
-<br>
-=C2=A0 =C2=A0 def get_capabilities_flow_ctrl(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get flow control capability =
and check for testpmd failure.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(&quot;Getting flow ctrl cap=
abilities.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 command =3D f&quot;show port {self.ports[0].id=
} flow_ctrl&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(command)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;Flow control infos&quot; in output:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.FLOW_CTRL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.FLOW_CTRL)<br>
-<br>
-=C2=A0 =C2=A0 def get_capabilities_physical_function(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[&quot;NicCa=
pability&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[&quot;Nic=
Capability&quot;],<br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Store capability representin=
g a physical function test run.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: Supporte=
d capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: Unsupp=
orted capabilities will be added to this set.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.topology.vf_ports =3D=3D []:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities.add(NicCa=
pability.PHYSICAL_FUNCTION)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities.add(Nic=
Capability.PHYSICAL_FUNCTION)<br>
-<br>
-<br>
-class NicCapability(NoAliasEnum):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;A mapping between capability names and the=
 associated :class:`TestPmdShell` methods.<br>
-<br>
-=C2=A0 =C2=A0 The :class:`TestPmdShell` capability checking method execute=
s the command that checks<br>
-=C2=A0 =C2=A0 whether the capability is supported.<br>
-=C2=A0 =C2=A0 A decorator may optionally be added to the method that will =
add and remove configuration<br>
-=C2=A0 =C2=A0 that&#39;s necessary to retrieve the capability support stat=
us.<br>
-=C2=A0 =C2=A0 The Enum members may be assigned the method itself or a tupl=
e of<br>
-=C2=A0 =C2=A0 (capability_checking_method, decorator_function).<br>
-<br>
-=C2=A0 =C2=A0 The signature of each :class:`TestPmdShell` capability check=
ing method must be::<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn(self, supported_capabilities: MutableSet, u=
nsupported_capabilities: MutableSet) -&gt; None<br>
-<br>
-=C2=A0 =C2=A0 The capability checking method must get whether a capability=
 is supported or not<br>
-=C2=A0 =C2=A0 from a testpmd command. If multiple capabilities can be obta=
ined from a testpmd command,<br>
-=C2=A0 =C2=A0 each should be obtained in the method. These capabilities sh=
ould then<br>
-=C2=A0 =C2=A0 be added to `supported_capabilities` or `unsupported_capabil=
ities` based on their support.<br>
-<br>
-=C2=A0 =C2=A0 The two dictionaries are shared across all capability discov=
ery function calls in a given<br>
-=C2=A0 =C2=A0 test run so that we don&#39;t call the same function multipl=
e times. For example, when we find<br>
-=C2=A0 =C2=A0 :attr:`SCATTERED_RX_ENABLED` in :meth:`TestPmdShell.get_capa=
bilities_rxq_info`,<br>
-=C2=A0 =C2=A0 we don&#39;t go looking for it again if a different test cas=
e also needs it.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 #: Scattered packets Rx enabled<br>
-=C2=A0 =C2=A0 SCATTERED_RX_ENABLED: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rxq_info,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_remove_mtu(9000),<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #:<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports L3 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports Large Receive Offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability =3D (TestPmdSh=
ell.get_capabilities_rx_offload, None)<br>
-=C2=A0 =C2=A0 #: Device supports QinQ (queue in queue) offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports inner packet L3 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability =3D (=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports MACsec.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports filtering of a VLAN Tag identifier.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports VLAN offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports receiving segmented mbufs.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCATTER: TestPmdShellNicCapability =3D (TestPmdSh=
ell.get_capabilities_rx_offload, None)<br>
-=C2=A0 =C2=A0 #: Device supports Timestamp.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports crypto processing while packet is receive=
d in NIC.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SECURITY: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports CRC stripping.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports L4 checksum offload.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports inner packet L4 checksum.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability =3D (<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports RSS hashing.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports scatter Rx packets to segmented mbufs.<br=
>
-=C2=A0 =C2=A0 RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports all checksum capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_rx_offload,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports all VLAN capabilities.<br>
-=C2=A0 =C2=A0 RX_OFFLOAD_VLAN: TestPmdShellNicCapability =3D (TestPmdShell=
.get_capabilities_rx_offload, None)<br>
-=C2=A0 =C2=A0 #: Device supports Rx queue setup after device started.<br>
-=C2=A0 =C2=A0 RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_show_port_info,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports Tx queue setup after device started.<br>
-=C2=A0 =C2=A0 RUNTIME_TX_QUEUE_SETUP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_show_port_info,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports shared Rx queue among ports within Rx dom=
ain and switch domain.<br>
-=C2=A0 =C2=A0 RXQ_SHARE: TestPmdShellNicCapability =3D (TestPmdShell.get_c=
apabilities_show_port_info, None)<br>
-=C2=A0 =C2=A0 #: Device supports keeping flow rules across restart.<br>
-=C2=A0 =C2=A0 FLOW_RULE_KEEP: TestPmdShellNicCapability =3D (TestPmdShell.=
get_capabilities_show_port_info, None)<br>
-=C2=A0 =C2=A0 #: Device supports keeping shared flow objects across restar=
t.<br>
-=C2=A0 =C2=A0 FLOW_SHARED_OBJECT_KEEP: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_show_port_info,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports multicast address filtering.<br>
-=C2=A0 =C2=A0 MCAST_FILTERING: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_mcast_filtering,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 #: Device supports flow ctrl.<br>
-=C2=A0 =C2=A0 FLOW_CTRL: TestPmdShellNicCapability =3D (TestPmdShell.get_c=
apabilities_flow_ctrl, None)<br>
-=C2=A0 =C2=A0 #: Device is running on a physical function.<br>
-=C2=A0 =C2=A0 PHYSICAL_FUNCTION: TestPmdShellNicCapability =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdShell.get_capabilities_physical_functio=
n,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 None,<br>
-=C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 def __call__(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd_shell: TestPmdShell,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: MutableSet[Self],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: MutableSet[Self],<br=
>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Execute the associated capab=
ility retrieval function.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd_shell: :class:`TestPmdSh=
ell` object to which the function will be bound to.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported_capabilities: The dict=
ionary storing the supported capabilities<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of a given test ru=
n.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsupported_capabilities: The di=
ctionary storing the unsupported capabilities<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of a given test ru=
n.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.value(testpmd_shell, supported_capabiliti=
es, unsupported_capabilities)<br>
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/test=
bed_model/capability.py<br>
index f895b22bb3..a4a8d9b7b4 100644<br>
--- a/dts/framework/testbed_model/capability.py<br>
+++ b/dts/framework/testbed_model/capability.py<br>
@@ -26,9 +26,9 @@<br>
=C2=A0 =C2=A0 =C2=A0.. code:: python<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from framework.test_suite import TestSuit=
e, func_test<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.testbed_model.capability import=
 TopologyType, requires<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.testbed_model.capability import=
 LinkTopology, requires<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# The whole test suite (each test case wi=
thin) doesn&#39;t require any links.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires(topology_type=3DTopologyType.no_link=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires_link_topology(LinkTopology.NO_LINK)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class TestHelloWorld(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def hello_world_single_core=
(self):<br>
@@ -41,7 +41,7 @@ def hello_world_single_core(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class TestPmdBufferScatter(TestSuite):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# only the test case requir=
es the SCATTERED_RX_ENABLED capability<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# other test cases may not =
require it<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires(NicCapability.SCATTERE=
D_RX_ENABLED)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @requires_nic_capability(NicCapa=
bility.SCATTERED_RX_ENABLED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@func_test<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def test_scatter_mbuf_2048(=
self):<br>
=C2=A0&quot;&quot;&quot;<br>
@@ -50,27 +50,38 @@ def test_scatter_mbuf_2048(self):<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from collections.abc import MutableSet<br>
=C2=A0from dataclasses import dataclass<br>
-from typing import TYPE_CHECKING, Callable, ClassVar, Protocol<br>
+from typing import (<br>
+=C2=A0 =C2=A0 TYPE_CHECKING,<br>
+=C2=A0 =C2=A0 Any,<br>
+=C2=A0 =C2=A0 Callable,<br>
+=C2=A0 =C2=A0 ClassVar,<br>
+=C2=A0 =C2=A0 Concatenate,<br>
+=C2=A0 =C2=A0 ParamSpec,<br>
+=C2=A0 =C2=A0 Protocol,<br>
+=C2=A0 =C2=A0 TypeAlias,<br>
+)<br>
<br>
=C2=A0from typing_extensions import Self<br>
<br>
+from api.capabilities import LinkTopology, NicCapability<br>
=C2=A0from framework.exception import ConfigurationError, InternalError, Sk=
ippedTestException<br>
=C2=A0from framework.logger import get_dts_logger<br>
-from framework.remote_session.testpmd_shell import (<br>
-=C2=A0 =C2=A0 NicCapability,<br>
-=C2=A0 =C2=A0 TestPmdShell,<br>
-=C2=A0 =C2=A0 TestPmdShellCapabilityMethod,<br>
-=C2=A0 =C2=A0 TestPmdShellDecorator,<br>
-=C2=A0 =C2=A0 TestPmdShellMethod,<br>
-)<br>
=C2=A0from framework.testbed_model.node import Node<br>
=C2=A0from framework.testbed_model.port import DriverKind<br>
-<br>
-from .topology import Topology, TopologyType<br>
+from framework.testbed_model.topology import Topology<br>
<br>
=C2=A0if TYPE_CHECKING:<br>
+=C2=A0 =C2=A0 from api.testpmd import TestPmd<br>
=C2=A0 =C2=A0 =C2=A0from framework.test_suite import TestCase<br>
<br>
+P =3D ParamSpec(&quot;P&quot;)<br>
+TestPmdMethod =3D Callable[Concatenate[&quot;TestPmd&quot;, P], Any]<br>
+TestPmdCapabilityMethod: TypeAlias =3D Callable[<br>
+=C2=A0 =C2=A0 [&quot;TestPmd&quot;, MutableSet[&quot;NicCapability&quot;],=
 MutableSet[&quot;NicCapability&quot;]], None<br>
+]<br>
+TestPmdDecorator: TypeAlias =3D Callable[[TestPmdMethod], TestPmdMethod]<b=
r>
+TestPmdNicCapability =3D tuple[TestPmdCapabilityMethod, TestPmdDecorator |=
 None]<br>
+<br>
<br>
=C2=A0class Capability(ABC):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The base class for various capabiliti=
es.<br>
@@ -153,7 +164,7 @@ def __hash__(self) -&gt; int:<br>
<br>
=C2=A0@dataclass<br>
=C2=A0class DecoratedNicCapability(Capability):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;A wrapper around :class:`~framework.remote=
_session.testpmd_shell.NicCapability`.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;A wrapper around :class:`~api.testpmd.NicC=
apability`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0New instances should be created with the :meth:`create_=
unique` class method to ensure<br>
=C2=A0 =C2=A0 =C2=A0there are no duplicate instances.<br>
@@ -166,10 +177,69 @@ class DecoratedNicCapability(Capability):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0nic_capability: NicCapability<br>
-=C2=A0 =C2=A0 capability_fn: TestPmdShellCapabilityMethod<br>
-=C2=A0 =C2=A0 capability_decorator: TestPmdShellDecorator | None<br>
+=C2=A0 =C2=A0 capability_fn: TestPmdCapabilityMethod<br>
+=C2=A0 =C2=A0 capability_decorator: TestPmdDecorator | None<br>
=C2=A0 =C2=A0 =C2=A0_unique_capabilities: ClassVar[dict[NicCapability, Self=
]] =3D {}<br>
<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def _get_nic_capability_check(cls) -&gt; list[TestPmdNicCapa=
bility]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;A mapping between capability=
 names and the associated :class:`TestPmd` methods.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The :class:`TestPmd` capability checking metho=
d executes the command that checks<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 whether the capability is supported.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 A decorator may optionally be added to the met=
hod that will add and remove configuration<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 that&#39;s necessary to retrieve the capabilit=
y support status.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The Enum members may be assigned the method it=
self or a tuple of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (capability_checking_method, decorator_functio=
n).<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The signature of each :class:`TestPmd` capabil=
ity checking method must be::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn(self, supported_capabilities:=
 MutableSet, unsupported_capabilities: MutableSet)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The capability checking method must get whethe=
r a capability is supported or not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from a testpmd command. If multiple capabiliti=
es can be obtained from a testpmd command,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 each should be obtained in the method. These c=
apabilities should then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 be added to `supported_capabilities` or `unsup=
ported_capabilities` based on their support.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The two dictionaries are shared across all cap=
ability discovery function calls in a given<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test run so that we don&#39;t call the same fu=
nction multiple times. For example, when we find<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :attr:`SCATTERED_RX_ENABLED` in :meth:`TestPmd=
.get_capabilities_rxq_info`,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 we don&#39;t go looking for it again if a diff=
erent test case also needs it.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from api.testpmd import TestPmd, _add_remove_m=
tu<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rxq_in=
fo, _add_remove_mtu(9000)),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_VLAN_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_TCP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_TCP_LRO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_QINQ_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_OUTER_IPV4_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_MACSEC_STRIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_VLAN_FILTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_VLAN_EXTEND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_SCATTER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_TIMESTAMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_SECURITY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_KEEP_CRC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_SCTP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_OUTER_UDP_CKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_RSS_HASH<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_BUFFER_SPLIT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_CHECKSUM<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_rx_off=
load, None),=C2=A0 # RX_OFFLOAD_VLAN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_show_p=
ort_info, None),=C2=A0 # RUNTIME_RX_QUEUE_SETUP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_show_p=
ort_info, None),=C2=A0 # RUNTIME_TX_QUEUE_SETUP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_show_p=
ort_info, None),=C2=A0 # RXQ_SHARE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_show_p=
ort_info, None),=C2=A0 # FLOW_RULE_KEEP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_show_p=
ort_info, None),=C2=A0 # FLOW_SHARED_OBJECT_KEEP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_mcast_=
filtering, None),=C2=A0 # MCAST_FILTERING<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_flow_c=
trl, None),=C2=A0 # FLOW_CTRL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TestPmd.get_capabilities_physic=
al_function, None),=C2=A0 # PHYSICAL_FUNCTION<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
=C2=A0 =C2=A0 =C2=A0def get_unique(cls, nic_capability: NicCapability) -&gt=
; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Get the capability uniq=
uely identified by `nic_capability`.<br>
@@ -188,7 +258,7 @@ def get_unique(cls, nic_capability: NicCapability) -&gt=
; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Returns:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The capability uniquely ide=
ntified by `nic_capability`.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 capability_fn, decorator_fn =3D nic_capability=
.value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 capability_fn, decorator_fn =3D cls._get_nic_c=
apability_check()[nic_capability.value]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if nic_capability not in cls._unique_capa=
bilities:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cls._unique_capabilities[ni=
c_capability] =3D cls(<br>
@@ -207,9 +277,11 @@ def get_supported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Each capability is first checked whether =
it&#39;s supported/unsupported<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0before executing its `capability_fn` so t=
hat each capability is retrieved only once.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from api.testpmd import TestPmd<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_conditional_capabilities: set[&=
quot;DecoratedNicCapability&quot;] =3D set()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger =3D get_dts_logger(f&quot;{<a href=
=3D"http://node.name" rel=3D"noreferrer" target=3D"_blank">node.name</a>}.{=
cls.__name__}&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if topology.type is topology.type.no_link:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if topology.type is topology.type.NO_LINK:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;No link=
s available in the current topology, not getting NIC capabilities.&quot;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
@@ -219,7 +291,7 @@ def get_supported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cls.capabilities_to_check:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capabilities_to_check_map =
=3D cls._get_decorated_capabilities_map()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd_s=
hell:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0conditional_capability_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0capabilities,<br>
@@ -231,7 +303,7 @@ def get_supported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if conditional_capability_fn:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0capability_fn =3D conditional_capability_fn(capability_fn)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capa=
bility_fn(testpmd_shell)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capa=
bility_fn(testpmd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for capability in capabilities:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if capability.nic_capability in supported_capabilities:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_conditional_capabilities.add(capab=
ility)<br>
@@ -242,8 +314,8 @@ def get_supported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
=C2=A0 =C2=A0 =C2=A0def _get_decorated_capabilities_map(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cls,<br>
-=C2=A0 =C2=A0 ) -&gt; dict[TestPmdShellDecorator | None, set[&quot;Decorat=
edNicCapability&quot;]]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 capabilities_map: dict[TestPmdShellDecorator |=
 None, set[&quot;DecoratedNicCapability&quot;]] =3D {}<br>
+=C2=A0 =C2=A0 ) -&gt; dict[TestPmdDecorator | None, set[&quot;DecoratedNic=
Capability&quot;]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 capabilities_map: dict[TestPmdDecorator | None=
, set[&quot;DecoratedNicCapability&quot;]] =3D {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for capability in cls.capabilities_to_che=
ck:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if capability.capability_de=
corator not in capabilities_map:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capabilities_=
map[capability.capability_decorator] =3D set()<br>
@@ -257,12 +329,12 @@ def _reduce_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capabilities: set[&quot;DecoratedNicCapab=
ility&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_capabilities: MutableSet,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities: MutableSet,<br>
-=C2=A0 =C2=A0 ) -&gt; TestPmdShellMethod:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def reduced_fn(testpmd_shell: TestPmdShell) -&=
gt; None:<br>
+=C2=A0 =C2=A0 ) -&gt; TestPmdMethod:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def reduced_fn(testpmd: &quot;TestPmd&quot;) -=
&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for capability in capabilit=
ies:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if capability=
 not in supported_capabilities | unsupported_capabilities:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0capability.capability_fn(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 testpmd_shell, supported_capabilities, unsupported_capabilities<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 testpmd, supported_capabilities, unsupported_capabilities<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return reduced_fn<br>
@@ -278,11 +350,11 @@ def __repr__(self) -&gt; str:<br>
<br>
=C2=A0@dataclass<br>
=C2=A0class TopologyCapability(Capability):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;A wrapper around :class:`~.topology.Topolo=
gyType`.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;A wrapper around :class:`~.topology.LinkTo=
pology`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Each test case must be assigned a topology. It could be=
 done explicitly;<br>
-=C2=A0 =C2=A0 the implicit default is given by :meth:`~.topology.TopologyT=
ype.default`, which this class<br>
-=C2=A0 =C2=A0 returns :attr:`~.topology.TopologyType.two_links`.<br>
+=C2=A0 =C2=A0 the implicit default is given by :meth:`~.topology.LinkTopol=
ogy.default`, which this class<br>
+=C2=A0 =C2=A0 returns :attr:`~.topology.LinkTopology.TWO_LINKS`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Test case topology may be set by setting the topology f=
or the whole suite.<br>
=C2=A0 =C2=A0 =C2=A0The priority in which topology is set is as follows:<br=
>
@@ -301,7 +373,7 @@ class TopologyCapability(Capability):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0topology_type: The topology type that def=
ines each instance.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 topology_type: TopologyType<br>
+=C2=A0 =C2=A0 topology_type: LinkTopology<br>
<br>
=C2=A0 =C2=A0 =C2=A0_unique_capabilities: ClassVar[dict[str, Self]] =3D {}<=
br>
<br>
@@ -310,7 +382,7 @@ def _preprocess_required(self, test_case_or_suite: type=
[&quot;TestProtocol&quot;]) -&gt; None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_case_or_suite.topology_type =3D self=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
-=C2=A0 =C2=A0 def get_unique(cls, topology_type: TopologyType) -&gt; Self:=
<br>
+=C2=A0 =C2=A0 def get_unique(cls, topology_type: LinkTopology) -&gt; Self:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Get the capability uniq=
uely identified by `topology_type`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is a factory method that implements =
a quasi-enum pattern.<br>
@@ -338,7 +410,7 @@ def get_supported_capabilities(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~Capab=
ility.get_supported_capabilities`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_capabilities =3D set()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0topology_capability =3D cls.get_unique(to=
pology.type)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for topology_type in TopologyType:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for topology_type in LinkTopology:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0candidate_topology_type =3D=
 cls.get_unique(topology_type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if candidate_topology_type =
&lt;=3D topology_capability:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_cap=
abilities.add(candidate_topology_type)<br>
@@ -351,17 +423,17 @@ def set_required(self, test_case_or_suite: type[&quot=
;TestProtocol&quot;]) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This means we have to modify test case to=
pologies when processing the test suite topologies.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0At that point, the test case topologies h=
ave been set by the :func:`requires` decorator.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The test suite topology only affects the =
test case topologies<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not :attr:`~.topology.TopologyType.default`=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not :attr:`~.topology.LinkTopology.default`=
.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raises:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ConfigurationError: If the =
topology type requested by the test case is more complex than<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the test suit=
e&#39;s.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if inspect.isclass(test_case_or_suite):<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.topology_type is not Top=
ologyType.default():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.topology_type is not Lin=
kTopology.default():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_to_r=
equired(test_case_or_suite)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for test_case=
 in test_case_or_suite.get_test_cases():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
est_case.topology_type.topology_type is TopologyType.default():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if t=
est_case.topology_type.topology_type is LinkTopology.default():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0# test case topology has not been set, use the one set by =
the test suite<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.add_to_required(test_case)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0elif test_case.topology_type &gt; test_case_or_suite.topology_type:<br>
@@ -440,7 +512,7 @@ class TestProtocol(Protocol):<br>
=C2=A0 =C2=A0 =C2=A0#: The reason for skipping the test case or suite.<br>
=C2=A0 =C2=A0 =C2=A0skip_reason: ClassVar[str] =3D &quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0#: The topology type of the test case or suite.<br>
-=C2=A0 =C2=A0 topology_type: ClassVar[TopologyCapability] =3D TopologyCapa=
bility(TopologyType.default())<br>
+=C2=A0 =C2=A0 topology_type: ClassVar[TopologyCapability] =3D TopologyCapa=
bility(LinkTopology.default())<br>
=C2=A0 =C2=A0 =C2=A0#: The capabilities the test case or suite requires in =
order to be executed.<br>
=C2=A0 =C2=A0 =C2=A0required_capabilities: ClassVar[set[Capability]] =3D se=
t()<br>
=C2=A0 =C2=A0 =C2=A0#: The SUT ports topology configuration of the test cas=
e or suite.<br>
@@ -481,7 +553,7 @@ def _decorator(func: type[TestProtocol]) -&gt; type[Tes=
tProtocol]:<br>
<br>
=C2=A0def requires(<br>
=C2=A0 =C2=A0 =C2=A0*nic_capabilities: NicCapability,<br>
-=C2=A0 =C2=A0 topology_type: TopologyType =3D TopologyType.default(),<br>
+=C2=A0 =C2=A0 topology_type: LinkTopology =3D LinkTopology.default(),<br>
=C2=A0) -&gt; Callable[[type[TestProtocol]], type[TestProtocol]]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;A decorator that adds the required ca=
pabilities to a test case or test suite.<br>
<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index 604245d855..1f11c3e740 100644<br>
--- a/dts/framework/testbed_model/linux_session.py<br>
+++ b/dts/framework/testbed_model/linux_session.py<br>
@@ -22,7 +22,7 @@<br>
=C2=A0 =C2=A0 =C2=A0InternalError,<br>
=C2=A0 =C2=A0 =C2=A0RemoteCommandExecutionError,<br>
=C2=A0)<br>
-from framework.testbed_model.os_session import PortInfo<br>
+from framework.testbed_model.port import PortInfo<br>
=C2=A0from framework.utils import expand_range<br>
<br>
=C2=A0from .cpu import LogicalCore<br>
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/test=
bed_model/os_session.py<br>
index b6e03aa83d..c1872880da 100644<br>
--- a/dts/framework/testbed_model/os_session.py<br>
+++ b/dts/framework/testbed_model/os_session.py<br>
@@ -31,13 +31,9 @@<br>
<br>
=C2=A0from framework.config.node import NodeConfiguration<br>
=C2=A0from framework.logger import DTSLogger<br>
-from framework.remote_session import (<br>
-=C2=A0 =C2=A0 InteractiveRemoteSession,<br>
-=C2=A0 =C2=A0 RemoteSession,<br>
-=C2=A0 =C2=A0 create_interactive_session,<br>
-=C2=A0 =C2=A0 create_remote_session,<br>
-)<br>
-from framework.remote_session.remote_session import CommandResult<br>
+from framework.remote_session.interactive_remote_session import Interactiv=
eRemoteSession<br>
+from framework.remote_session.remote_session import CommandResult, RemoteS=
ession<br>
+from framework.remote_session.ssh_session import SSHSession<br>
=C2=A0from framework.settings import SETTINGS<br>
=C2=A0from framework.utils import MesonArgs, TarCompressionFormat<br>
<br>
@@ -129,8 +125,8 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._config =3D node_config<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.name" rel=3D"noref=
errer" target=3D"_blank">self.name</a> =3D name<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger =3D logger<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.remote_session =3D create_remote_session(=
node_config, name, logger)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.interactive_session =3D create_interactiv=
e_session(node_config, logger)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.remote_session =3D SSHSession(node_config=
, name, logger)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.interactive_session =3D InteractiveRemote=
Session(node_config, logger)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def is_alive(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Check whether the under=
lying remote session is still responding.&quot;&quot;&quot;<br>
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbe=
d_model/topology.py<br>
index 899ea0ad3a..09303a1f08 100644<br>
--- a/dts/framework/testbed_model/topology.py<br>
+++ b/dts/framework/testbed_model/topology.py<br>
@@ -11,33 +11,17 @@<br>
=C2=A0from collections import defaultdict<br>
=C2=A0from collections.abc import Iterator<br>
=C2=A0from dataclasses import dataclass<br>
-from enum import Enum<br>
=C2=A0from typing import Literal, NamedTuple<br>
<br>
=C2=A0from typing_extensions import Self<br>
<br>
+from api.capabilities import LinkTopology<br>
=C2=A0from framework.exception import ConfigurationError, InternalError<br>
=C2=A0from framework.testbed_model.node import Node<br>
<br>
=C2=A0from .port import DriverKind, Port, PortConfig<br>
<br>
<br>
-class TopologyType(int, Enum):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Supported topology types.&quot;&quot;&quot=
;<br>
-<br>
-=C2=A0 =C2=A0 #: A topology with no Traffic Generator.<br>
-=C2=A0 =C2=A0 no_link =3D 0<br>
-=C2=A0 =C2=A0 #: A topology with one physical link between the SUT node an=
d the TG node.<br>
-=C2=A0 =C2=A0 one_link =3D 1<br>
-=C2=A0 =C2=A0 #: A topology with two physical links between the Sut node a=
nd the TG node.<br>
-=C2=A0 =C2=A0 two_links =3D 2<br>
-<br>
-=C2=A0 =C2=A0 @classmethod<br>
-=C2=A0 =C2=A0 def default(cls) -&gt; &quot;TopologyType&quot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The default topology require=
d by test cases if not specified otherwise.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cls.two_links<br>
-<br>
-<br>
=C2=A0class PortLink(NamedTuple):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The physical, cabled connection betwe=
en the ports.&quot;&quot;&quot;<br>
<br>
@@ -71,7 +55,7 @@ class Topology:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tg_ports: The TG ports.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 type: TopologyType<br>
+=C2=A0 =C2=A0 type: LinkTopology<br>
=C2=A0 =C2=A0 =C2=A0sut_ports: list[Port]<br>
=C2=A0 =C2=A0 =C2=A0tg_ports: list[Port]<br>
=C2=A0 =C2=A0 =C2=A0pf_ports: list[Port]<br>
@@ -87,15 +71,15 @@ def from_port_links(cls, port_links: Iterator[PortLink]=
) -&gt; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raises:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ConfigurationError: If an u=
nsupported link topology is supplied.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D TopologyType.no_link<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D LinkTopology.NO_LINK<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if port_link :=3D next(port_links, None):=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D TopologyType.one_link<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D LinkTopology.ONE_LINK<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sut_ports =3D [port_link.su=
t_port]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tg_ports =3D [port_link.tg_=
port]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if port_link :=3D next(port=
_links, None):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D TopologyT=
ype.two_links<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D LinkTopol=
ogy.TWO_LINKS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sut_ports.app=
end(port_link.sut_port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tg_ports.appe=
nd(port_link.tg_port)<br>
<br>
@@ -268,9 +252,9 @@ def sut_port_ingress(self) -&gt; Port:<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def sut_port_egress(self) -&gt; Port:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The egress port of the =
SUT node.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.sut_ports[1 if self.type is Topolo=
gyType.two_links else 0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.sut_ports[1 if self.type is LinkTo=
pology.TWO_LINKS else 0]<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def tg_port_ingress(self) -&gt; Port:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The ingress port of the=
 TG node.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.tg_ports[1 if self.type is Topolog=
yType.two_links else 0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.tg_ports[1 if self.type is LinkTop=
ology.TWO_LINKS else 0]<br>
--<br>
2.39.5<br>
<br>
</blockquote></div>

--000000000000d23d9c063f2ccb36--
