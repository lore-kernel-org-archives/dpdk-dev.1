Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35532C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 19:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEDF540665;
	Fri, 14 Feb 2025 20:14:34 +0100 (CET)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by mails.dpdk.org (Postfix) with ESMTP id DB46A40651
 for <dev@dpdk.org>; Fri, 14 Feb 2025 20:14:32 +0100 (CET)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-307d4eaab17so2922951fa.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739560472; x=1740165272; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6VHKaSJdPztF0cFuUpcAFSrnC7Tcd7yS6Lgq8dQnkw=;
 b=BtsvTe/g7Hup93mJddIv7z65ExsFE5fVOWCt0Ct9vCkEew9eVKeYGf7Y5HQdhNr5k/
 XiR6SzgLUf69PnZ+9blaMLrt1lW5BxWjVNFs17xiUrL9RnwRGGfCbLRmoDu5GPc53DOY
 NioA+n2yMWOp5aKhPfK9K20EDXXA66tqT5J6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739560472; x=1740165272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6VHKaSJdPztF0cFuUpcAFSrnC7Tcd7yS6Lgq8dQnkw=;
 b=P1VWeo9pKKo369PblG5RcgzEkaekIpXD41OZaPP66Q8bZPPiyH/uz9Xo6HH4vBveCh
 LpDnQpJBthb6otXjrFTVNy1Mpr3hYG8pS0DlSCzzl+4vXwJwbH+Ecb4vbg/eBlp+1sXS
 h4gd0aqVj6SJfW/2EjANdpiHTh1ay6GFooNyFoTOVqURMlKUcQq/ErMV3VBYr5SxN3i9
 imXBR4pMhZTAeaKV1U6DG7uPUxetiB8iveh5fbMgc7Bmg/wRgp8x5tEBTj9N0oZ8HPCA
 EWlYaB5psMo1nlq3FiL+Vnm+YJnQbA5kPbvXGaL60jx52nqo7rY+gl69isaIxkOF/fVP
 Q5GA==
X-Gm-Message-State: AOJu0YyWrvPhwxwYr7kfh3YA8US717wKIas2BgWxGb3vY3MLpkG/FWbI
 xXmvTejJaiBW9MZy+xPmEC2LjsNcTZmbiaV06s4A23tJ5lP+MJgKDtq8t1UAqBqYItbsGGxB4Ja
 K7uggKF7E98Hln/JlWCR5niM3j/XiZMCdEA70HA==
X-Gm-Gg: ASbGncuhinpFBR5DH5yLnlgL1J+sx48Au11ROQLEtBIb4G5qC7BWoISdPoF1cjxPtnr
 ACwksgzajM5YDBYkgRTbhib5lNFj12ME755uHvQxqy8oNPBr3aJGvHFxkuNEq7jf8qEony6mFwK
 Px10xCUYOiKknghgpqS9B4JY2dHivAoNo=
X-Google-Smtp-Source: AGHT+IEjKrnIQoOb27jEooVhQISKHptxF3pzIKz3P5nwowgtftLJa+3XgAPoEWclmBG0bg224Hrzt2C9+otiRkhfkGI=
X-Received: by 2002:a2e:bcc2:0:b0:308:f75f:435 with SMTP id
 38308e7fff4ca-30927969458mr1016081fa.0.1739560470955; Fri, 14 Feb 2025
 11:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
 <20250212164600.23759-8-luca.vizzarro@arm.com>
In-Reply-To: <20250212164600.23759-8-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 14 Feb 2025 14:14:18 -0500
X-Gm-Features: AWEUYZkBqtBJlhhv_uETZb68Fkz-G6t3D7WoJGz3_Vm1dXJXQbQZBjdarCsujF8
Message-ID: <CAKXZ7eg-rUsgTTeLjgxaroCTVZnjFi7g6oPdYFv20QvSy=Anuw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dts: remove node distinction
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Right off the bat, I like this organization a lot more. Definitely a
lot easier to navigate the code.

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Wed, Feb 12, 2025 at 11:46=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om> wrote:
>
> Remove the distinction between SUT and TG nodes for configuration
> purposes. As DPDK and the traffic generator belong to the runtime side
> of testing, and don't belong to the testbed model, these are better
> suited to be configured under the test runs.
>
> Split the DPDK configuration in DPDKBuildConfiguration and
> DPDKRuntimeConfiguration. The former stays the same but gains
> implementation in its own self-contained class. DPDKRuntimeConfiguration
> instead represents the prior dpdk options. Through a new
> DPDKRuntimeEnvironment class all the DPDK-related runtime features are
> now also self-contained. This sets a predisposition for DPDK-based
> traffic generator as well, as it'd make it easier to handle their own
> environment using the pre-existing functionality.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  doc/api/dts/framework.remote_session.dpdk.rst |   8 +
>  doc/api/dts/framework.remote_session.rst      |   1 +
>  dts/framework/config/__init__.py              |  16 +-
>  dts/framework/config/node.py                  |  73 +--
>  dts/framework/config/test_run.py              |  72 ++-
>  dts/framework/context.py                      |  11 +-
>  .../sut_node.py =3D> remote_session/dpdk.py}    | 444 +++++++++---------
>  dts/framework/remote_session/dpdk_shell.py    |  12 +-
>  .../single_active_interactive_shell.py        |   4 +-
>  dts/framework/runner.py                       |  16 +-
>  dts/framework/test_result.py                  |   2 +-
>  dts/framework/test_run.py                     |  23 +-
>  dts/framework/test_suite.py                   |   9 +-
>  dts/framework/testbed_model/capability.py     |  24 +-
>  dts/framework/testbed_model/node.py           |  87 ++--
>  dts/framework/testbed_model/tg_node.py        | 125 -----
>  .../traffic_generator/__init__.py             |   8 +-
>  .../testbed_model/traffic_generator/scapy.py  |  12 +-
>  .../traffic_generator/traffic_generator.py    |   9 +-
>  dts/tests/TestSuite_smoke_tests.py            |   6 +-
>  dts/tests/TestSuite_softnic.py                |   2 +-
>  21 files changed, 393 insertions(+), 571 deletions(-)
>  create mode 100644 doc/api/dts/framework.remote_session.dpdk.rst
>  rename dts/framework/{testbed_model/sut_node.py =3D> remote_session/dpdk=
.py} (61%)
>  delete mode 100644 dts/framework/testbed_model/tg_node.py
>
> diff --git a/doc/api/dts/framework.remote_session.dpdk.rst b/doc/api/dts/=
framework.remote_session.dpdk.rst
> new file mode 100644
> index 0000000000..830364b984
> --- /dev/null
> +++ b/doc/api/dts/framework.remote_session.dpdk.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +dpdk - DPDK Environments
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: framework.remote_session.dpdk
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/frame=
work.remote_session.rst
> index dd6f8530d7..79d65e3444 100644
> --- a/doc/api/dts/framework.remote_session.rst
> +++ b/doc/api/dts/framework.remote_session.rst
> @@ -15,6 +15,7 @@ remote\_session - Node Connections Package
>     framework.remote_session.ssh_session
>     framework.remote_session.interactive_remote_session
>     framework.remote_session.interactive_shell
> +   framework.remote_session.dpdk
>     framework.remote_session.dpdk_shell
>     framework.remote_session.testpmd_shell
>     framework.remote_session.python_shell
> diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__in=
it__.py
> index 273a5cc3a7..c42eacb748 100644
> --- a/dts/framework/config/__init__.py
> +++ b/dts/framework/config/__init__.py
> @@ -37,16 +37,12 @@
>  from framework.exception import ConfigurationError
>
>  from .common import FrozenModel, ValidationContext
> -from .node import (
> -    NodeConfigurationTypes,
> -    SutNodeConfiguration,
> -    TGNodeConfiguration,
> -)
> +from .node import NodeConfiguration
>  from .test_run import TestRunConfiguration
>
>  TestRunsConfig =3D Annotated[list[TestRunConfiguration], Field(min_lengt=
h=3D1)]
>
> -NodesConfig =3D Annotated[list[NodeConfigurationTypes], Field(min_length=
=3D1)]
> +NodesConfig =3D Annotated[list[NodeConfiguration], Field(min_length=3D1)=
]
>
>
>  class Configuration(FrozenModel):
> @@ -125,10 +121,6 @@ def validate_test_runs_against_nodes(self) -> Self:
>                  f"Test run {test_run_no}.system_under_test_node "
>                  f"({sut_node_name}) is not a valid node name."
>              )
> -            assert isinstance(sut_node, SutNodeConfiguration), (
> -                f"Test run {test_run_no}.system_under_test_node is a val=
id node name, "
> -                "but it is not a valid SUT node."
> -            )
>
>              tg_node_name =3D test_run.traffic_generator_node
>              tg_node =3D next((n for n in self.nodes if n.name =3D=3D tg_=
node_name), None)
> @@ -137,10 +129,6 @@ def validate_test_runs_against_nodes(self) -> Self:
>                  f"Test run {test_run_no}.traffic_generator_name "
>                  f"({tg_node_name}) is not a valid node name."
>              )
> -            assert isinstance(tg_node, TGNodeConfiguration), (
> -                f"Test run {test_run_no}.traffic_generator_name is a val=
id node name, "
> -                "but it is not a valid TG node."
> -            )
>
>          return self
>
> diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
> index 97e0285912..438a1bdc8f 100644
> --- a/dts/framework/config/node.py
> +++ b/dts/framework/config/node.py
> @@ -9,8 +9,7 @@
>  The root model of a node configuration is :class:`NodeConfiguration`.
>  """
>
> -from enum import Enum, auto, unique
> -from typing import Annotated, Literal
> +from enum import auto, unique
>
>  from pydantic import Field, model_validator
>  from typing_extensions import Self
> @@ -32,14 +31,6 @@ class OS(StrEnum):
>      windows =3D auto()
>
>
> -@unique
> -class TrafficGeneratorType(str, Enum):
> -    """The supported traffic generators."""
> -
> -    #:
> -    SCAPY =3D "SCAPY"
> -
> -
>  class HugepageConfiguration(FrozenModel):
>      r"""The hugepage configuration of :class:`~framework.testbed_model.n=
ode.Node`\s."""
>
> @@ -62,33 +53,6 @@ class PortConfig(FrozenModel):
>      os_driver: str =3D Field(examples=3D["i40e", "ice", "mlx5_core"])
>
>
> -class TrafficGeneratorConfig(FrozenModel):
> -    """A protocol required to define traffic generator types."""
> -
> -    #: The traffic generator type the child class is required to define =
to be distinguished among
> -    #: others.
> -    type: TrafficGeneratorType
> -
> -
> -class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
> -    """Scapy traffic generator specific configuration."""
> -
> -    type: Literal[TrafficGeneratorType.SCAPY]
> -
> -
> -#: A union type discriminating traffic generators by the `type` field.
> -TrafficGeneratorConfigTypes =3D Annotated[ScapyTrafficGeneratorConfig, F=
ield(discriminator=3D"type")]
> -
> -#: Comma-separated list of logical cores to use. An empty string or ```a=
ny``` means use all lcores.
> -LogicalCores =3D Annotated[
> -    str,
> -    Field(
> -        examples=3D["1,2,3,4,5,18-22", "10-15", "any"],
> -        pattern=3Dr"^(([0-9]+|([0-9]+-[0-9]+))(,([0-9]+|([0-9]+-[0-9]+))=
)*)?$|any",
> -    ),
> -]
> -
> -
>  class NodeConfiguration(FrozenModel):
>      r"""The configuration of :class:`~framework.testbed_model.node.Node`=
\s."""
>
> @@ -118,38 +82,3 @@ def verify_unique_port_names(self) -> Self:
>              )
>              used_port_names[port.name] =3D idx
>          return self
> -
> -
> -class DPDKConfiguration(FrozenModel):
> -    """Configuration of the DPDK EAL parameters."""
> -
> -    #: A comma delimited list of logical cores to use when running DPDK.=
 ```any```, an empty
> -    #: string or omitting this field means use any core except for the f=
irst one. The first core
> -    #: will only be used if explicitly set.
> -    lcores: LogicalCores =3D ""
> -
> -    #: The number of memory channels to use when running DPDK.
> -    memory_channels: int =3D 1
> -
> -    @property
> -    def use_first_core(self) -> bool:
> -        """Returns :data:`True` if `lcores` explicitly selects the first=
 core."""
> -        return "0" in self.lcores
> -
> -
> -class SutNodeConfiguration(NodeConfiguration):
> -    """:class:`~framework.testbed_model.sut_node.SutNode` specific confi=
guration."""
> -
> -    #: The runtime configuration for DPDK.
> -    dpdk_config: DPDKConfiguration
> -
> -
> -class TGNodeConfiguration(NodeConfiguration):
> -    """:class:`~framework.testbed_model.tg_node.TGNode` specific configu=
ration."""
> -
> -    #: The configuration of the traffic generator present on the TG node=
.
> -    traffic_generator: TrafficGeneratorConfigTypes
> -
> -
> -#: Union type for all the node configuration types.
> -NodeConfigurationTypes =3D TGNodeConfiguration | SutNodeConfiguration
> diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test=
_run.py
> index eef01d0340..1b3045730d 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -13,10 +13,10 @@
>  import tarfile
>  from collections import deque
>  from collections.abc import Iterable
> -from enum import auto, unique
> +from enum import Enum, auto, unique
>  from functools import cached_property
>  from pathlib import Path, PurePath
> -from typing import Any, Literal, NamedTuple
> +from typing import Annotated, Any, Literal, NamedTuple
>
>  from pydantic import Field, field_validator, model_validator
>  from typing_extensions import TYPE_CHECKING, Self
> @@ -361,6 +361,68 @@ def verify_distinct_nodes(self) -> Self:
>          return self
>
>
> +@unique
> +class TrafficGeneratorType(str, Enum):
> +    """The supported traffic generators."""
> +
> +    #:
> +    SCAPY =3D "SCAPY"
> +
> +
> +class TrafficGeneratorConfig(FrozenModel):
> +    """A protocol required to define traffic generator types."""
> +
> +    #: The traffic generator type the child class is required to define =
to be distinguished among
> +    #: others.
> +    type: TrafficGeneratorType
> +
> +
> +class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
> +    """Scapy traffic generator specific configuration."""
> +
> +    type: Literal[TrafficGeneratorType.SCAPY]
> +
> +
> +#: A union type discriminating traffic generators by the `type` field.
> +TrafficGeneratorConfigTypes =3D Annotated[ScapyTrafficGeneratorConfig, F=
ield(discriminator=3D"type")]
> +
> +#: Comma-separated list of logical cores to use. An empty string or ```a=
ny``` means use all lcores.
> +LogicalCores =3D Annotated[
> +    str,
> +    Field(
> +        examples=3D["1,2,3,4,5,18-22", "10-15", "any"],
> +        pattern=3Dr"^(([0-9]+|([0-9]+-[0-9]+))(,([0-9]+|([0-9]+-[0-9]+))=
)*)?$|any",
> +    ),
> +]
> +
> +
> +class DPDKRuntimeConfiguration(FrozenModel):
> +    """Configuration of the DPDK EAL parameters."""
> +
> +    #: A comma delimited list of logical cores to use when running DPDK.=
 ```any```, an empty
> +    #: string or omitting this field means use any core except for the f=
irst one. The first core
> +    #: will only be used if explicitly set.
> +    lcores: LogicalCores =3D ""
> +
> +    #: The number of memory channels to use when running DPDK.
> +    memory_channels: int =3D 1
> +
> +    #: The names of virtual devices to test.
> +    vdevs: list[str] =3D Field(default_factory=3Dlist)
> +
> +    @property
> +    def use_first_core(self) -> bool:
> +        """Returns :data:`True` if `lcores` explicitly selects the first=
 core."""
> +        return "0" in self.lcores
> +
> +
> +class DPDKConfiguration(DPDKRuntimeConfiguration):
> +    """The DPDK configuration needed to test."""
> +
> +    #: The DPDKD build configuration used to test.
> +    build: DPDKBuildConfiguration
> +
> +
>  class TestRunConfiguration(FrozenModel):
>      """The configuration of a test run.
>
> @@ -369,7 +431,9 @@ class TestRunConfiguration(FrozenModel):
>      """
>
>      #: The DPDK configuration used to test.
> -    dpdk_config: DPDKBuildConfiguration =3D Field(alias=3D"dpdk_build")
> +    dpdk: DPDKConfiguration
> +    #: The traffic generator configuration used to test.
> +    traffic_generator: TrafficGeneratorConfigTypes
>      #: Whether to run performance tests.
>      perf: bool
>      #: Whether to run functional tests.
> @@ -382,8 +446,6 @@ class TestRunConfiguration(FrozenModel):
>      system_under_test_node: str
>      #: The TG node name to use in this test run.
>      traffic_generator_node: str
> -    #: The names of virtual devices to test.
> -    vdevs: list[str] =3D Field(default_factory=3Dlist)
>      #: The seed to use for pseudo-random generation.
>      random_seed: int | None =3D None
>      #: The port links between the specified nodes to use.
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> index 03eaf63b88..8adffff57f 100644
> --- a/dts/framework/context.py
> +++ b/dts/framework/context.py
> @@ -10,11 +10,12 @@
>  from framework.exception import InternalError
>  from framework.settings import SETTINGS
>  from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreLis=
t
> +from framework.testbed_model.node import Node
>  from framework.testbed_model.topology import Topology
>
>  if TYPE_CHECKING:
> -    from framework.testbed_model.sut_node import SutNode
> -    from framework.testbed_model.tg_node import TGNode
> +    from framework.remote_session.dpdk import DPDKRuntimeEnvironment
> +    from framework.testbed_model.traffic_generator.traffic_generator imp=
ort TrafficGenerator
>
>  P =3D ParamSpec("P")
>
> @@ -62,9 +63,11 @@ def reset(self) -> None:
>  class Context:
>      """Runtime context."""
>
> -    sut_node: "SutNode"
> -    tg_node: "TGNode"
> +    sut_node: Node
> +    tg_node: Node
>      topology: Topology
> +    dpdk: "DPDKRuntimeEnvironment"
> +    tg: "TrafficGenerator"
>      local: LocalContext =3D field(default_factory=3DLocalContext)
>
>
> diff --git a/dts/framework/testbed_model/sut_node.py b/dts/framework/remo=
te_session/dpdk.py
> similarity index 61%
> rename from dts/framework/testbed_model/sut_node.py
> rename to dts/framework/remote_session/dpdk.py
> index 9007d89b1c..476d6915d3 100644
> --- a/dts/framework/testbed_model/sut_node.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -1,47 +1,40 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2010-2014 Intel Corporation
> +# SPDX-License-Identifier: BSD-3-C
>  # Copyright(c) 2023 PANTHEON.tech s.r.o.
>  # Copyright(c) 2023 University of New Hampshire
> -# Copyright(c) 2024 Arm Limited
> +# Copyright(c) 2025 Arm Limited
>
> -"""System under test (DPDK + hardware) node.
> -
> -A system under test (SUT) is the combination of DPDK
> -and the hardware we're testing with DPDK (NICs, crypto and other devices=
).
> -An SUT node is where this SUT runs.
> -"""
> +"""DPDK environment."""
>
>  import os
>  import time
>  from collections.abc import Iterable
>  from dataclasses import dataclass
> +from functools import cached_property
>  from pathlib import Path, PurePath
> +from typing import Final
>
> -from framework.config.node import (
> -    SutNodeConfiguration,
> -)
>  from framework.config.test_run import (
>      DPDKBuildConfiguration,
>      DPDKBuildOptionsConfiguration,
>      DPDKPrecompiledBuildConfiguration,
> +    DPDKRuntimeConfiguration,
>      DPDKUncompiledBuildConfiguration,
>      LocalDPDKTarballLocation,
>      LocalDPDKTreeLocation,
>      RemoteDPDKTarballLocation,
>      RemoteDPDKTreeLocation,
> -    TestRunConfiguration,
>  )
>  from framework.exception import ConfigurationError, RemoteFileNotFoundEr=
ror
> +from framework.logger import DTSLogger, get_dts_logger
>  from framework.params.eal import EalParams
>  from framework.remote_session.remote_session import CommandResult
> +from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, L=
ogicalCoreList, lcore_filter
> +from framework.testbed_model.node import Node
> +from framework.testbed_model.os_session import OSSession
>  from framework.testbed_model.port import Port
> +from framework.testbed_model.virtual_device import VirtualDevice
>  from framework.utils import MesonArgs, TarCompressionFormat
>
> -from .cpu import LogicalCore, LogicalCoreList
> -from .node import Node
> -from .os_session import OSSession, OSSessionInfo
> -from .virtual_device import VirtualDevice
> -
>
>  @dataclass(slots=3DTrue, frozen=3DTrue)
>  class DPDKBuildInfo:
> @@ -56,177 +49,36 @@ class DPDKBuildInfo:
>      compiler_version: str | None
>
>
> -class SutNode(Node):
> -    """The system under test node.
> -
> -    The SUT node extends :class:`Node` with DPDK specific features:
> -
> -        * Managing DPDK source tree on the remote SUT,
> -        * Building the DPDK from source or using a pre-built version,
> -        * Gathering of DPDK build info,
> -        * The running of DPDK apps, interactively or one-time execution,
> -        * DPDK apps cleanup.
> +class DPDKBuildEnvironment:
> +    """Class handling a DPDK build environment."""
>
> -    Building DPDK from source uses `build` configuration inside `dpdk_bu=
ild` of configuration.
> -
> -    Attributes:
> -        config: The SUT node configuration.
> -        virtual_devices: The virtual devices used on the node.
> -    """
> -
> -    config: SutNodeConfiguration
> -    virtual_devices: list[VirtualDevice]
> -    dpdk_prefix_list: list[str]
> -    dpdk_timestamp: str
> -    _env_vars: dict
> +    config: DPDKBuildConfiguration
> +    _node: Node
> +    _session: OSSession
> +    _logger: DTSLogger
>      _remote_tmp_dir: PurePath
> -    __remote_dpdk_tree_path: str | PurePath | None
> +    _remote_dpdk_tree_path: str | PurePath | None
>      _remote_dpdk_build_dir: PurePath | None
>      _app_compile_timeout: float
> -    _dpdk_kill_session: OSSession | None
> -    _dpdk_version: str | None
> -    _node_info: OSSessionInfo | None
> -    _compiler_version: str | None
> -    _path_to_devbind_script: PurePath | None
>
> -    def __init__(self, node_config: SutNodeConfiguration):
> -        """Extend the constructor with SUT node specifics.
> +    compiler_version: str | None
>
> -        Args:
> -            node_config: The SUT node's test run configuration.
> -        """
> -        super().__init__(node_config)
> -        self.lcores =3D self.filter_lcores(LogicalCoreList(self.config.d=
pdk_config.lcores))
> -        if LogicalCore(lcore=3D0, core=3D0, socket=3D0, node=3D0) in sel=
f.lcores:
> -            self._logger.info(
> -                """
> -                WARNING: First core being used;
> -                using the first core is considered risky and should only
> -                be done by advanced users.
> -                """
> -            )
> -        else:
> -            self._logger.info("Not using first core")
> -        self.virtual_devices =3D []
> -        self.dpdk_prefix_list =3D []
> -        self._env_vars =3D {}
> -        self._remote_tmp_dir =3D self.main_session.get_remote_tmp_dir()
> -        self.__remote_dpdk_tree_path =3D None
> +    def __init__(self, config: DPDKBuildConfiguration, node: Node):
> +        """DPDK build environment class constructor."""
> +        self.config =3D config
> +        self._node =3D node
> +        self._logger =3D get_dts_logger()
> +        self._session =3D node.create_session("dpdk_build")
> +
> +        self._remote_tmp_dir =3D node.main_session.get_remote_tmp_dir()
> +        self._remote_dpdk_tree_path =3D None
>          self._remote_dpdk_build_dir =3D None
>          self._app_compile_timeout =3D 90
> -        self._dpdk_kill_session =3D None
> -        self.dpdk_timestamp =3D (
> -            f"{str(os.getpid())}_{time.strftime('%Y%m%d%H%M%S', time.loc=
altime())}"
> -        )
> -        self._dpdk_version =3D None
> -        self._node_info =3D None
> -        self._compiler_version =3D None
> -        self._path_to_devbind_script =3D None
> -        self._ports_bound_to_dpdk =3D False
> -        self._logger.info(f"Created node: {self.name}")
> -
> -    @property
> -    def _remote_dpdk_tree_path(self) -> str | PurePath:
> -        """The remote DPDK tree path."""
> -        if self.__remote_dpdk_tree_path:
> -            return self.__remote_dpdk_tree_path
> -
> -        self._logger.warning(
> -            "Failed to get remote dpdk tree path because we don't know t=
he "
> -            "location on the SUT node."
> -        )
> -        return ""
> -
> -    @property
> -    def remote_dpdk_build_dir(self) -> str | PurePath:
> -        """The remote DPDK build dir path."""
> -        if self._remote_dpdk_build_dir:
> -            return self._remote_dpdk_build_dir
> -
> -        self._logger.warning(
> -            "Failed to get remote dpdk build dir because we don't know t=
he "
> -            "location on the SUT node."
> -        )
> -        return ""
> -
> -    @property
> -    def dpdk_version(self) -> str | None:
> -        """Last built DPDK version."""
> -        if self._dpdk_version is None:
> -            self._dpdk_version =3D self.main_session.get_dpdk_version(se=
lf._remote_dpdk_tree_path)
> -        return self._dpdk_version
> -
> -    @property
> -    def node_info(self) -> OSSessionInfo:
> -        """Additional node information."""
> -        if self._node_info is None:
> -            self._node_info =3D self.main_session.get_node_info()
> -        return self._node_info
> -
> -    @property
> -    def compiler_version(self) -> str | None:
> -        """The node's compiler version."""
> -        if self._compiler_version is None:
> -            self._logger.warning("The `compiler_version` is None because=
 a pre-built DPDK is used.")
>
> -        return self._compiler_version
> -
> -    @compiler_version.setter
> -    def compiler_version(self, value: str) -> None:
> -        """Set the `compiler_version` used on the SUT node.
> -
> -        Args:
> -            value: The node's compiler version.
> -        """
> -        self._compiler_version =3D value
> -
> -    @property
> -    def path_to_devbind_script(self) -> PurePath | str:
> -        """The path to the dpdk-devbind.py script on the node."""
> -        if self._path_to_devbind_script is None:
> -            self._path_to_devbind_script =3D self.main_session.join_remo=
te_path(
> -                self._remote_dpdk_tree_path, "usertools", "dpdk-devbind.=
py"
> -            )
> -        return self._path_to_devbind_script
> -
> -    def get_dpdk_build_info(self) -> DPDKBuildInfo:
> -        """Get additional DPDK build information.
> -
> -        Returns:
> -            The DPDK build information,
> -        """
> -        return DPDKBuildInfo(dpdk_version=3Dself.dpdk_version, compiler_=
version=3Dself.compiler_version)
> -
> -    def set_up_test_run(self, test_run_config: TestRunConfiguration, por=
ts: Iterable[Port]) -> None:
> -        """Extend the test run setup with vdev config and DPDK build set=
 up.
> -
> -        This method extends the setup process by configuring virtual dev=
ices and preparing the DPDK
> -        environment based on the provided configuration.
> -
> -        Args:
> -            test_run_config: A test run configuration according to which
> -                the setup steps will be taken.
> -            ports: The ports to set up for the test run.
> -        """
> -        super().set_up_test_run(test_run_config, ports)
> -        for vdev in test_run_config.vdevs:
> -            self.virtual_devices.append(VirtualDevice(vdev))
> -        self._set_up_dpdk(test_run_config.dpdk_config, ports)
> -
> -    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
> -        """Extend the test run teardown with virtual device teardown and=
 DPDK teardown.
> -
> -        Args:
> -            ports: The ports to tear down for the test run.
> -        """
> -        super().tear_down_test_run(ports)
> -        self.virtual_devices =3D []
> -        self._tear_down_dpdk(ports)
> +        self.compiler_version =3D None
>
> -    def _set_up_dpdk(
> -        self, dpdk_build_config: DPDKBuildConfiguration, ports: Iterable=
[Port]
> -    ) -> None:
> -        """Set up DPDK the SUT node and bind ports.
> +    def setup(self):
> +        """Set up the DPDK build on the target node.
>
>          DPDK setup includes setting all internals needed for the build, =
the copying of DPDK
>          sources and then building DPDK or using the exist ones from the =
`dpdk_location`. The drivers
> @@ -236,7 +88,7 @@ def _set_up_dpdk(
>              dpdk_build_config: A DPDK build configuration to test.
>              ports: The ports to use for DPDK.
>          """
> -        match dpdk_build_config.dpdk_location:
> +        match self.config.dpdk_location:
>              case RemoteDPDKTreeLocation(dpdk_tree=3Ddpdk_tree):
>                  self._set_remote_dpdk_tree_path(dpdk_tree)
>              case LocalDPDKTreeLocation(dpdk_tree=3Ddpdk_tree):
> @@ -248,24 +100,13 @@ def _set_up_dpdk(
>                  remote_tarball =3D self._copy_dpdk_tarball_to_remote(tar=
ball)
>                  self._prepare_and_extract_dpdk_tarball(remote_tarball)
>
> -        match dpdk_build_config:
> +        match self.config:
>              case DPDKPrecompiledBuildConfiguration(precompiled_build_dir=
=3Dbuild_dir):
>                  self._set_remote_dpdk_build_dir(build_dir)
>              case DPDKUncompiledBuildConfiguration(build_options=3Dbuild_=
options):
>                  self._configure_dpdk_build(build_options)
>                  self._build_dpdk()
>
> -        self.bind_ports_to_driver(ports)
> -
> -    def _tear_down_dpdk(self, ports: Iterable[Port]) -> None:
> -        """Reset DPDK variables and bind port driver to the OS driver.""=
"
> -        self._env_vars =3D {}
> -        self.__remote_dpdk_tree_path =3D None
> -        self._remote_dpdk_build_dir =3D None
> -        self._dpdk_version =3D None
> -        self.compiler_version =3D None
> -        self.bind_ports_to_driver(ports, for_dpdk=3DFalse)
> -
>      def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
>          """Set the path to the remote DPDK source tree based on the prov=
ided DPDK location.
>
> @@ -280,14 +121,14 @@ def _set_remote_dpdk_tree_path(self, dpdk_tree: Pur=
ePath):
>                  is not found.
>              ConfigurationError: If the remote DPDK source tree specified=
 is not a valid directory.
>          """
> -        if not self.main_session.remote_path_exists(dpdk_tree):
> +        if not self._session.remote_path_exists(dpdk_tree):
>              raise RemoteFileNotFoundError(
>                  f"Remote DPDK source tree '{dpdk_tree}' not found in SUT=
 node."
>              )
> -        if not self.main_session.is_remote_dir(dpdk_tree):
> +        if not self._session.is_remote_dir(dpdk_tree):
>              raise ConfigurationError(f"Remote DPDK source tree '{dpdk_tr=
ee}' must be a directory.")
>
> -        self.__remote_dpdk_tree_path =3D dpdk_tree
> +        self._remote_dpdk_tree_path =3D dpdk_tree
>
>      def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> None:
>          """Copy the DPDK source tree to the SUT.
> @@ -298,14 +139,14 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> =
None:
>          self._logger.info(
>              f"Copying DPDK source tree to SUT: '{dpdk_tree_path}' into '=
{self._remote_tmp_dir}'."
>          )
> -        self.main_session.copy_dir_to(
> +        self._session.copy_dir_to(
>              dpdk_tree_path,
>              self._remote_tmp_dir,
>              exclude=3D[".git", "*.o"],
>              compress_format=3DTarCompressionFormat.gzip,
>          )
>
> -        self.__remote_dpdk_tree_path =3D self.main_session.join_remote_p=
ath(
> +        self._remote_dpdk_tree_path =3D self._session.join_remote_path(
>              self._remote_tmp_dir, PurePath(dpdk_tree_path).name
>          )
>
> @@ -320,9 +161,9 @@ def _validate_remote_dpdk_tarball(self, dpdk_tarball:=
 PurePath) -> None:
>                  not found.
>              ConfigurationError: If the `dpdk_tarball` is a valid path bu=
t not a valid tar archive.
>          """
> -        if not self.main_session.remote_path_exists(dpdk_tarball):
> +        if not self._session.remote_path_exists(dpdk_tarball):
>              raise RemoteFileNotFoundError(f"Remote DPDK tarball '{dpdk_t=
arball}' not found in SUT.")
> -        if not self.main_session.is_remote_tarfile(dpdk_tarball):
> +        if not self._session.is_remote_tarfile(dpdk_tarball):
>              raise ConfigurationError(f"Remote DPDK tarball '{dpdk_tarbal=
l}' must be a tar archive.")
>
>      def _copy_dpdk_tarball_to_remote(self, dpdk_tarball: Path) -> PurePa=
th:
> @@ -337,8 +178,8 @@ def _copy_dpdk_tarball_to_remote(self, dpdk_tarball: =
Path) -> PurePath:
>          self._logger.info(
>              f"Copying DPDK tarball to SUT: '{dpdk_tarball}' into '{self.=
_remote_tmp_dir}'."
>          )
> -        self.main_session.copy_to(dpdk_tarball, self._remote_tmp_dir)
> -        return self.main_session.join_remote_path(self._remote_tmp_dir, =
dpdk_tarball.name)
> +        self._session.copy_to(dpdk_tarball, self._remote_tmp_dir)
> +        return self._session.join_remote_path(self._remote_tmp_dir, dpdk=
_tarball.name)
>
>      def _prepare_and_extract_dpdk_tarball(self, remote_tarball_path: Pur=
ePath) -> None:
>          """Prepare the remote DPDK tree path and extract the tarball.
> @@ -365,19 +206,19 @@ def remove_tarball_suffix(remote_tarball_path: Pure=
Path) -> PurePath:
>                      return PurePath(str(remote_tarball_path).replace(suf=
fixes_to_remove, ""))
>              return remote_tarball_path.with_suffix("")
>
> -        tarball_top_dir =3D self.main_session.get_tarball_top_dir(remote=
_tarball_path)
> -        self.__remote_dpdk_tree_path =3D self.main_session.join_remote_p=
ath(
> +        tarball_top_dir =3D self._session.get_tarball_top_dir(remote_tar=
ball_path)
> +        self._remote_dpdk_tree_path =3D self._session.join_remote_path(
>              remote_tarball_path.parent,
>              tarball_top_dir or remove_tarball_suffix(remote_tarball_path=
),
>          )
>
>          self._logger.info(
>              "Extracting DPDK tarball on SUT: "
> -            f"'{remote_tarball_path}' into '{self._remote_dpdk_tree_path=
}'."
> +            f"'{remote_tarball_path}' into '{self.remote_dpdk_tree_path}=
'."
>          )
> -        self.main_session.extract_remote_tarball(
> +        self._session.extract_remote_tarball(
>              remote_tarball_path,
> -            self._remote_dpdk_tree_path,
> +            self.remote_dpdk_tree_path,
>          )
>
>      def _set_remote_dpdk_build_dir(self, build_dir: str):
> @@ -395,10 +236,10 @@ def _set_remote_dpdk_build_dir(self, build_dir: str=
):
>              RemoteFileNotFoundError: If the `build_dir` is expected but =
does not exist on the SUT
>                  node.
>          """
> -        remote_dpdk_build_dir =3D self.main_session.join_remote_path(
> -            self._remote_dpdk_tree_path, build_dir
> +        remote_dpdk_build_dir =3D self._session.join_remote_path(
> +            self.remote_dpdk_tree_path, build_dir
>          )
> -        if not self.main_session.remote_path_exists(remote_dpdk_build_di=
r):
> +        if not self._session.remote_path_exists(remote_dpdk_build_dir):
>              raise RemoteFileNotFoundError(
>                  f"Remote DPDK build dir '{remote_dpdk_build_dir}' not fo=
und in SUT node."
>              )
> @@ -415,20 +256,18 @@ def _configure_dpdk_build(self, dpdk_build_config: =
DPDKBuildOptionsConfiguration
>              dpdk_build_config: A DPDK build configuration to test.
>          """
>          self._env_vars =3D {}
> -        self._env_vars.update(self.main_session.get_dpdk_build_env_vars(=
self.arch))
> +        self._env_vars.update(self._session.get_dpdk_build_env_vars(self=
._node.arch))
>          if compiler_wrapper :=3D dpdk_build_config.compiler_wrapper:
>              self._env_vars["CC"] =3D f"'{compiler_wrapper} {dpdk_build_c=
onfig.compiler.name}'"
>          else:
>              self._env_vars["CC"] =3D dpdk_build_config.compiler.name
>
> -        self.compiler_version =3D self.main_session.get_compiler_version=
(
> -            dpdk_build_config.compiler.name
> -        )
> +        self.compiler_version =3D self._session.get_compiler_version(dpd=
k_build_config.compiler.name)
>
> -        build_dir_name =3D f"{self.arch}-{self.config.os}-{dpdk_build_co=
nfig.compiler}"
> +        build_dir_name =3D f"{self._node.arch}-{self._node.config.os}-{d=
pdk_build_config.compiler}"
>
> -        self._remote_dpdk_build_dir =3D self.main_session.join_remote_pa=
th(
> -            self._remote_dpdk_tree_path, build_dir_name
> +        self._remote_dpdk_build_dir =3D self._session.join_remote_path(
> +            self.remote_dpdk_tree_path, build_dir_name
>          )
>
>      def _build_dpdk(self) -> None:
> @@ -437,10 +276,10 @@ def _build_dpdk(self) -> None:
>          Uses the already configured DPDK build configuration. Assumes th=
at the
>          `_remote_dpdk_tree_path` has already been set on the SUT node.
>          """
> -        self.main_session.build_dpdk(
> +        self._session.build_dpdk(
>              self._env_vars,
>              MesonArgs(default_library=3D"static", enable_kmods=3DTrue, l=
ibdir=3D"lib"),
> -            self._remote_dpdk_tree_path,
> +            self.remote_dpdk_tree_path,
>              self.remote_dpdk_build_dir,
>          )
>
> @@ -459,31 +298,120 @@ def build_dpdk_app(self, app_name: str, **meson_dp=
dk_args: str | bool) -> PurePa
>              The directory path of the built app. If building all apps, r=
eturn
>              the path to the examples directory (where all apps reside).
>          """
> -        self.main_session.build_dpdk(
> +        self._session.build_dpdk(
>              self._env_vars,
>              MesonArgs(examples=3Dapp_name, **meson_dpdk_args),  # type: =
ignore [arg-type]
>              # ^^ https://github.com/python/mypy/issues/11583
> -            self._remote_dpdk_tree_path,
> +            self.remote_dpdk_tree_path,
>              self.remote_dpdk_build_dir,
>              rebuild=3DTrue,
>              timeout=3Dself._app_compile_timeout,
>          )
>
>          if app_name =3D=3D "all":
> -            return self.main_session.join_remote_path(self.remote_dpdk_b=
uild_dir, "examples")
> -        return self.main_session.join_remote_path(
> +            return self._session.join_remote_path(self.remote_dpdk_build=
_dir, "examples")
> +        return self._session.join_remote_path(
>              self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
>          )
>
> -    def kill_cleanup_dpdk_apps(self) -> None:
> -        """Kill all dpdk applications on the SUT, then clean up hugepage=
s."""
> -        if self._dpdk_kill_session and self._dpdk_kill_session.is_alive(=
):
> -            # we can use the session if it exists and responds
> -            self._dpdk_kill_session.kill_cleanup_dpdk_apps(self.dpdk_pre=
fix_list)
> +    @property
> +    def remote_dpdk_tree_path(self) -> str | PurePath:
> +        """The remote DPDK tree path."""
> +        if self._remote_dpdk_tree_path:
> +            return self._remote_dpdk_tree_path
> +
> +        self._logger.warning(
> +            "Failed to get remote dpdk tree path because we don't know t=
he "
> +            "location on the SUT node."
> +        )
> +        return ""
> +
> +    @property
> +    def remote_dpdk_build_dir(self) -> str | PurePath:
> +        """The remote DPDK build dir path."""
> +        if self._remote_dpdk_build_dir:
> +            return self._remote_dpdk_build_dir
> +
> +        self._logger.warning(
> +            "Failed to get remote dpdk build dir because we don't know t=
he "
> +            "location on the SUT node."
> +        )
> +        return ""
> +
> +    @cached_property
> +    def dpdk_version(self) -> str | None:
> +        """Last built DPDK version."""
> +        return self._session.get_dpdk_version(self.remote_dpdk_tree_path=
)
> +
> +    def get_dpdk_build_info(self) -> DPDKBuildInfo:
> +        """Get additional DPDK build information.
> +
> +        Returns:
> +            The DPDK build information,
> +        """
> +        return DPDKBuildInfo(dpdk_version=3Dself.dpdk_version, compiler_=
version=3Dself.compiler_version)
> +
> +
> +class DPDKRuntimeEnvironment:
> +    """Class handling a DPDK runtime environment."""
> +
> +    config: Final[DPDKRuntimeConfiguration]
> +    build: Final[DPDKBuildEnvironment]
> +    _node: Final[Node]
> +    _logger: Final[DTSLogger]
> +
> +    timestamp: Final[str]
> +    _virtual_devices: list[VirtualDevice]
> +    _lcores: list[LogicalCore]
> +
> +    _env_vars: dict
> +    _kill_session: OSSession | None
> +    prefix_list: list[str]
> +
> +    def __init__(
> +        self,
> +        config: DPDKRuntimeConfiguration,
> +        node: Node,
> +        build_env: DPDKBuildEnvironment,
> +    ):
> +        """DPDK environment constructor.
> +
> +        Args:
> +            config: The configuration of DPDK.
> +            node: The target node to manage a DPDK environment.
> +            build_env: The DPDK build environment.
> +        """
> +        self.config =3D config
> +        self.build =3D build_env
> +        self._node =3D node
> +        self._logger =3D get_dts_logger()
> +
> +        self.timestamp =3D f"{str(os.getpid())}_{time.strftime('%Y%m%d%H=
%M%S', time.localtime())}"
> +        self._virtual_devices =3D [VirtualDevice(vdev) for vdev in confi=
g.vdevs]
> +
> +        self._lcores =3D node.lcores
> +        self._lcores =3D self.filter_lcores(LogicalCoreList(self.config.=
lcores))
> +        if LogicalCore(lcore=3D0, core=3D0, socket=3D0, node=3D0) in sel=
f._lcores:
> +            self._logger.warning(
> +                "First core being used; "
> +                "the first core is considered risky and should only be d=
one by advanced users."
> +            )
>          else:
> -            # otherwise, we need to (re)create it
> -            self._dpdk_kill_session =3D self.create_session("dpdk_kill")
> -        self.dpdk_prefix_list =3D []
> +            self._logger.info("Not using first core")
> +
> +        self.prefix_list =3D []
> +        self._env_vars =3D {}
> +        self._ports_bound_to_dpdk =3D False
> +        self._kill_session =3D None
> +
> +    def setup(self, ports: Iterable[Port]):
> +        """Set up the DPDK runtime on the target node."""
> +        self.build.setup()
> +        self.bind_ports_to_driver(ports)
> +
> +    def teardown(self, ports: Iterable[Port]) -> None:
> +        """Reset DPDK variables and bind port driver to the OS driver.""=
"
> +        self.bind_ports_to_driver(ports, for_dpdk=3DFalse)
>
>      def run_dpdk_app(
>          self, app_path: PurePath, eal_params: EalParams, timeout: float =
=3D 30
> @@ -501,7 +429,7 @@ def run_dpdk_app(
>          Returns:
>              The result of the DPDK app execution.
>          """
> -        return self.main_session.send_command(
> +        return self._node.main_session.send_command(
>              f"{app_path} {eal_params}", timeout, privileged=3DTrue, veri=
fy=3DTrue
>          )
>
> @@ -518,9 +446,59 @@ def bind_ports_to_driver(self, ports: Iterable[Port]=
, for_dpdk: bool =3D True) ->
>                  continue
>
>              driver =3D port.config.os_driver_for_dpdk if for_dpdk else p=
ort.config.os_driver
> -            self.main_session.send_command(
> -                f"{self.path_to_devbind_script} -b {driver} --force {por=
t.pci}",
> +            self._node.main_session.send_command(
> +                f"{self.devbind_script_path} -b {driver} --force {port.p=
ci}",
>                  privileged=3DTrue,
>                  verify=3DTrue,
>              )
>              port.bound_for_dpdk =3D for_dpdk
> +
> +    @cached_property
> +    def devbind_script_path(self) -> PurePath:
> +        """The path to the dpdk-devbind.py script on the node."""
> +        return self._node.main_session.join_remote_path(
> +            self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind=
.py"
> +        )
> +
> +    def filter_lcores(
> +        self,
> +        filter_specifier: LogicalCoreCount | LogicalCoreList,
> +        ascending: bool =3D True,
> +    ) -> list[LogicalCore]:
> +        """Filter the node's logical cores that DTS can use.
> +
> +        Logical cores that DTS can use are the ones that are present on =
the node, but filtered
> +        according to the test run configuration. The `filter_specifier` =
will filter cores from
> +        those logical cores.
> +
> +        Args:
> +            filter_specifier: Two different filters can be used, one tha=
t specifies the number
> +                of logical cores per core, cores per socket and the numb=
er of sockets,
> +                and another one that specifies a logical core list.
> +            ascending: If :data:`True`, use cores with the lowest numeri=
cal id first and continue
> +                in ascending order. If :data:`False`, start with the hig=
hest id and continue
> +                in descending order. This ordering affects which sockets=
 to consider first as well.
> +
> +        Returns:
> +            The filtered logical cores.
> +        """
> +        self._logger.debug(f"Filtering {filter_specifier} from {self._lc=
ores}.")
> +        return lcore_filter(
> +            self._lcores,
> +            filter_specifier,
> +            ascending,
> +        ).filter()
> +
> +    def kill_cleanup_dpdk_apps(self) -> None:
> +        """Kill all dpdk applications on the SUT, then clean up hugepage=
s."""
> +        if self._kill_session and self._kill_session.is_alive():
> +            # we can use the session if it exists and responds
> +            self._kill_session.kill_cleanup_dpdk_apps(self.prefix_list)
> +        else:
> +            # otherwise, we need to (re)create it
> +            self._kill_session =3D self._node.create_session("dpdk_kill"=
)
> +        self.prefix_list =3D []
> +
> +    def get_virtual_devices(self) -> Iterable[VirtualDevice]:
> +        """The available DPDK virtual devices."""
> +        return (v for v in self._virtual_devices)
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index b55deb7fa0..fc43448e06 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -15,7 +15,6 @@
>      SingleActiveInteractiveShell,
>  )
>  from framework.testbed_model.cpu import LogicalCoreList
> -from framework.testbed_model.sut_node import SutNode
>
>
>  def compute_eal_params(
> @@ -35,15 +34,15 @@ def compute_eal_params(
>
>      if params.lcore_list is None:
>          params.lcore_list =3D LogicalCoreList(
> -            ctx.sut_node.filter_lcores(ctx.local.lcore_filter_specifier,=
 ctx.local.ascending_cores)
> +            ctx.dpdk.filter_lcores(ctx.local.lcore_filter_specifier, ctx=
.local.ascending_cores)
>          )
>
>      prefix =3D params.prefix
>      if ctx.local.append_prefix_timestamp:
> -        prefix =3D f"{prefix}_{ctx.sut_node.dpdk_timestamp}"
> +        prefix =3D f"{prefix}_{ctx.dpdk.timestamp}"
>      prefix =3D ctx.sut_node.main_session.get_dpdk_file_prefix(prefix)
>      if prefix:
> -        ctx.sut_node.dpdk_prefix_list.append(prefix)
> +        ctx.dpdk.prefix_list.append(prefix)
>      params.prefix =3D prefix
>
>      if params.allowed_ports is None:
> @@ -60,7 +59,6 @@ class DPDKShell(SingleActiveInteractiveShell, ABC):
>      supplied app parameters.
>      """
>
> -    _node: SutNode
>      _app_params: EalParams
>
>      def __init__(
> @@ -80,4 +78,6 @@ def _update_real_path(self, path: PurePath) -> None:
>
>          Adds the remote DPDK build directory to the path.
>          """
> -        super()._update_real_path(PurePath(self._node.remote_dpdk_build_=
dir).joinpath(path))
> +        super()._update_real_path(
> +            PurePath(get_ctx().dpdk.build.remote_dpdk_build_dir).joinpat=
h(path)
> +        )
> diff --git a/dts/framework/remote_session/single_active_interactive_shell=
.py b/dts/framework/remote_session/single_active_interactive_shell.py
> index 2eec2f698a..c1369ef77e 100644
> --- a/dts/framework/remote_session/single_active_interactive_shell.py
> +++ b/dts/framework/remote_session/single_active_interactive_shell.py
> @@ -27,7 +27,6 @@
>  from paramiko import Channel, channel
>  from typing_extensions import Self
>
> -from framework.context import get_ctx
>  from framework.exception import (
>      InteractiveCommandExecutionError,
>      InteractiveSSHSessionDeadError,
> @@ -35,6 +34,7 @@
>  )
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.params import Params
> +from framework.settings import SETTINGS
>  from framework.testbed_model.node import Node
>  from framework.utils import MultiInheritanceBaseClass
>
> @@ -114,7 +114,7 @@ def __init__(
>          self._logger =3D get_dts_logger(f"{node.name}.{name}")
>          self._app_params =3D app_params
>          self._privileged =3D privileged
> -        self._timeout =3D get_ctx().local.timeout
> +        self._timeout =3D SETTINGS.timeout
>          # Ensure path is properly formatted for the host
>          self._update_real_path(self.path)
>          super().__init__(**kwargs)
> diff --git a/dts/framework/runner.py b/dts/framework/runner.py
> index 90aeb63cfb..801709a2aa 100644
> --- a/dts/framework/runner.py
> +++ b/dts/framework/runner.py
> @@ -15,17 +15,11 @@
>  from framework.config.common import ValidationContext
>  from framework.test_run import TestRun
>  from framework.testbed_model.node import Node
> -from framework.testbed_model.sut_node import SutNode
> -from framework.testbed_model.tg_node import TGNode
>
>  from .config import (
>      Configuration,
>      load_config,
>  )
> -from .config.node import (
> -    SutNodeConfiguration,
> -    TGNodeConfiguration,
> -)
>  from .logger import DTSLogger, get_dts_logger
>  from .settings import SETTINGS
>  from .test_result import (
> @@ -63,15 +57,7 @@ def run(self) -> None:
>              self._result.update_setup(Result.PASS)
>
>              for node_config in self._configuration.nodes:
> -                node: Node
> -
> -                match node_config:
> -                    case SutNodeConfiguration():
> -                        node =3D SutNode(node_config)
> -                    case TGNodeConfiguration():
> -                        node =3D TGNode(node_config)
> -
> -                nodes.append(node)
> +                nodes.append(Node(node_config))
>
>              # for all test run sections
>              for test_run_config in self._configuration.test_runs:
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index a59bac71bb..7f576022c7 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -32,9 +32,9 @@
>  from .config.test_run import TestRunConfiguration
>  from .exception import DTSError, ErrorSeverity
>  from .logger import DTSLogger
> +from .remote_session.dpdk import DPDKBuildInfo
>  from .testbed_model.os_session import OSSessionInfo
>  from .testbed_model.port import Port
> -from .testbed_model.sut_node import DPDKBuildInfo
>
>
>  class Result(Enum):
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 811798f57f..6801bf87fd 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -80,7 +80,7 @@
>  from functools import cached_property
>  from pathlib import Path
>  from types import MethodType
> -from typing import ClassVar, Protocol, Union, cast
> +from typing import ClassVar, Protocol, Union
>
>  from framework.config.test_run import TestRunConfiguration
>  from framework.context import Context, init_ctx
> @@ -90,6 +90,7 @@
>      TestCaseVerifyError,
>  )
>  from framework.logger import DTSLogger, get_dts_logger
> +from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRunt=
imeEnvironment
>  from framework.settings import SETTINGS
>  from framework.test_result import BaseResult, Result, TestCaseResult, Te=
stRunResult, TestSuiteResult
>  from framework.test_suite import TestCase, TestSuite
> @@ -99,9 +100,8 @@
>      test_if_supported,
>  )
>  from framework.testbed_model.node import Node
> -from framework.testbed_model.sut_node import SutNode
> -from framework.testbed_model.tg_node import TGNode
>  from framework.testbed_model.topology import PortLink, Topology
> +from framework.testbed_model.traffic_generator import create_traffic_gen=
erator
>
>  TestScenario =3D tuple[type[TestSuite], deque[type[TestCase]]]
>
> @@ -163,17 +163,18 @@ def __init__(self, config: TestRunConfiguration, no=
des: Iterable[Node], result:
>          self.logger =3D get_dts_logger()
>
>          sut_node =3D next(n for n in nodes if n.name =3D=3D config.syste=
m_under_test_node)
> -        sut_node =3D cast(SutNode, sut_node)  # Config validation must r=
ender this valid.
> -
>          tg_node =3D next(n for n in nodes if n.name =3D=3D config.traffi=
c_generator_node)
> -        tg_node =3D cast(TGNode, tg_node)  # Config validation must rend=
er this valid.
>
>          topology =3D Topology.from_port_links(
>              PortLink(sut_node.ports_by_name[link.sut_port], tg_node.port=
s_by_name[link.tg_port])
>              for link in self.config.port_topology
>          )
>
> -        self.ctx =3D Context(sut_node, tg_node, topology)
> +        dpdk_build_env =3D DPDKBuildEnvironment(config.dpdk.build, sut_n=
ode)
> +        dpdk_runtime_env =3D DPDKRuntimeEnvironment(config.dpdk, sut_nod=
e, dpdk_build_env)
> +        traffic_generator =3D create_traffic_generator(config.traffic_ge=
nerator, tg_node)
> +
> +        self.ctx =3D Context(sut_node, tg_node, topology, dpdk_runtime_e=
nv, traffic_generator)
>          self.result =3D result
>          self.selected_tests =3D list(self.config.filter_tests())
>          self.blocked =3D False
> @@ -307,11 +308,11 @@ def next(self) -> State | None:
>          test_run.init_random_seed()
>          test_run.remaining_tests =3D deque(test_run.selected_tests)
>
> -        test_run.ctx.sut_node.set_up_test_run(test_run.config, test_run.=
ctx.topology.sut_ports)
> +        test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
>
>          self.result.ports =3D test_run.ctx.topology.sut_ports + test_run=
.ctx.topology.tg_ports
>          self.result.sut_info =3D test_run.ctx.sut_node.node_info
> -        self.result.dpdk_build_info =3D test_run.ctx.sut_node.get_dpdk_b=
uild_info()
> +        self.result.dpdk_build_info =3D test_run.ctx.dpdk.build.get_dpdk=
_build_info()
>
>          self.logger.debug(f"Found capabilities to check: {test_run.requi=
red_capabilities}")
>          test_run.supported_capabilities =3D get_supported_capabilities(
> @@ -390,7 +391,7 @@ def description(self) -> str:
>
>      def next(self) -> State | None:
>          """Next state."""
> -        self.test_run.ctx.sut_node.tear_down_test_run(self.test_run.ctx.=
topology.sut_ports)
> +        self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_p=
orts)
>          self.result.update_teardown(Result.PASS)
>          return None
>
> @@ -500,7 +501,7 @@ def description(self) -> str:
>      def next(self) -> State | None:
>          """Next state."""
>          self.test_suite.tear_down_suite()
> -        self.test_run.ctx.sut_node.kill_cleanup_dpdk_apps()
> +        self.test_run.ctx.dpdk.kill_cleanup_dpdk_apps()
>          self.result.update_teardown(Result.PASS)
>          return TestRunExecution(self.test_run, self.test_run.result)
>
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index ae90997061..58da26adf0 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -34,6 +34,7 @@
>  from framework.testbed_model.capability import TestProtocol
>  from framework.testbed_model.topology import Topology
>  from framework.testbed_model.traffic_generator.capturing_traffic_generat=
or import (
> +    CapturingTrafficGenerator,
>      PacketFilteringConfig,
>  )
>
> @@ -246,8 +247,12 @@ def send_packets_and_capture(
>          Returns:
>              A list of received packets.
>          """
> +        assert isinstance(
> +            self._ctx.tg, CapturingTrafficGenerator
> +        ), "Cannot capture with a non-capturing traffic generator"
> +        # TODO: implement @requires for types of traffic generator
>          packets =3D self._adjust_addresses(packets)
> -        return self._ctx.tg_node.send_packets_and_capture(
> +        return self._ctx.tg.send_packets_and_capture(
>              packets,
>              self._ctx.topology.tg_port_egress,
>              self._ctx.topology.tg_port_ingress,
> @@ -265,7 +270,7 @@ def send_packets(
>              packets: Packets to send.
>          """
>          packets =3D self._adjust_addresses(packets)
> -        self._ctx.tg_node.send_packets(packets, self._ctx.topology.tg_po=
rt_egress)
> +        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_eg=
ress)
>
>      def get_expected_packets(
>          self,
> diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/te=
stbed_model/capability.py
> index a1d6d9dd32..ea0e647a47 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py
> @@ -63,8 +63,8 @@ def test_scatter_mbuf_2048(self):
>      TestPmdShellDecorator,
>      TestPmdShellMethod,
>  )
> +from framework.testbed_model.node import Node
>
> -from .sut_node import SutNode
>  from .topology import Topology, TopologyType
>
>  if TYPE_CHECKING:
> @@ -90,7 +90,7 @@ class Capability(ABC):
>      #: A set storing the capabilities whose support should be checked.
>      capabilities_to_check: ClassVar[set[Self]] =3D set()
>
> -    def register_to_check(self) -> Callable[[SutNode, "Topology"], set[S=
elf]]:
> +    def register_to_check(self) -> Callable[[Node, "Topology"], set[Self=
]]:
>          """Register the capability to be checked for support.
>
>          Returns:
> @@ -118,27 +118,27 @@ def _preprocess_required(self, test_case_or_suite: =
type["TestProtocol"]) -> None
>          """An optional method that modifies the required capabilities.""=
"
>
>      @classmethod
> -    def _get_and_reset(cls, sut_node: SutNode, topology: "Topology") -> =
set[Self]:
> +    def _get_and_reset(cls, node: Node, topology: "Topology") -> set[Sel=
f]:
>          """The callback method to be called after all capabilities have =
been registered.
>
>          Not only does this method check the support of capabilities,
>          but it also reset the internal set of registered capabilities
>          so that the "register, then get support" workflow works in subse=
quent test runs.
>          """
> -        supported_capabilities =3D cls.get_supported_capabilities(sut_no=
de, topology)
> +        supported_capabilities =3D cls.get_supported_capabilities(node, =
topology)
>          cls.capabilities_to_check =3D set()
>          return supported_capabilities
>
>      @classmethod
>      @abstractmethod
> -    def get_supported_capabilities(cls, sut_node: SutNode, topology: "To=
pology") -> set[Self]:
> +    def get_supported_capabilities(cls, node: Node, topology: "Topology"=
) -> set[Self]:
>          """Get the support status of each registered capability.
>
>          Each subclass must implement this method and return the subset o=
f supported capabilities
>          of :attr:`capabilities_to_check`.
>
>          Args:
> -            sut_node: The SUT node of the current test run.
> +            node: The node to check capabilities against.
>              topology: The topology of the current test run.
>
>          Returns:
> @@ -197,7 +197,7 @@ def get_unique(cls, nic_capability: NicCapability) ->=
 Self:
>
>      @classmethod
>      def get_supported_capabilities(
> -        cls, sut_node: SutNode, topology: "Topology"
> +        cls, node: Node, topology: "Topology"
>      ) -> set["DecoratedNicCapability"]:
>          """Overrides :meth:`~Capability.get_supported_capabilities`.
>
> @@ -207,7 +207,7 @@ def get_supported_capabilities(
>          before executing its `capability_fn` so that each capability is =
retrieved only once.
>          """
>          supported_conditional_capabilities: set["DecoratedNicCapability"=
] =3D set()
> -        logger =3D get_dts_logger(f"{sut_node.name}.{cls.__name__}")
> +        logger =3D get_dts_logger(f"{node.name}.{cls.__name__}")
>          if topology.type is topology.type.no_link:
>              logger.debug(
>                  "No links available in the current topology, not getting=
 NIC capabilities."
> @@ -332,7 +332,7 @@ def get_unique(cls, topology_type: TopologyType) -> S=
elf:
>
>      @classmethod
>      def get_supported_capabilities(
> -        cls, sut_node: SutNode, topology: "Topology"
> +        cls, node: Node, topology: "Topology"
>      ) -> set["TopologyCapability"]:
>          """Overrides :meth:`~Capability.get_supported_capabilities`."""
>          supported_capabilities =3D set()
> @@ -483,14 +483,14 @@ def add_required_capability(
>
>
>  def get_supported_capabilities(
> -    sut_node: SutNode,
> +    node: Node,
>      topology_config: Topology,
>      capabilities_to_check: set[Capability],
>  ) -> set[Capability]:
>      """Probe the environment for `capabilities_to_check` and return the =
supported ones.
>
>      Args:
> -        sut_node: The SUT node to check for capabilities.
> +        node: The node to check capabilities against.
>          topology_config: The topology config to check for capabilities.
>          capabilities_to_check: The capabilities to check.
>
> @@ -502,7 +502,7 @@ def get_supported_capabilities(
>          callbacks.add(capability_to_check.register_to_check())
>      supported_capabilities =3D set()
>      for callback in callbacks:
> -        supported_capabilities.update(callback(sut_node, topology_config=
))
> +        supported_capabilities.update(callback(node, topology_config))
>
>      return supported_capabilities
>
> diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_=
model/node.py
> index 1a4c825ed2..be1b4ac2ac 100644
> --- a/dts/framework/testbed_model/node.py
> +++ b/dts/framework/testbed_model/node.py
> @@ -13,25 +13,22 @@
>  The :func:`~Node.skip_setup` decorator can be used without subclassing.
>  """
>
> -from abc import ABC
> -from collections.abc import Iterable
>  from functools import cached_property
>
>  from framework.config.node import (
>      OS,
>      NodeConfiguration,
>  )
> -from framework.config.test_run import TestRunConfiguration
>  from framework.exception import ConfigurationError
>  from framework.logger import DTSLogger, get_dts_logger
>
> -from .cpu import Architecture, LogicalCore, LogicalCoreCount, LogicalCor=
eList, lcore_filter
> +from .cpu import Architecture, LogicalCore
>  from .linux_session import LinuxSession
> -from .os_session import OSSession
> +from .os_session import OSSession, OSSessionInfo
>  from .port import Port
>
>
> -class Node(ABC):
> +class Node:
>      """The base class for node management.
>
>      It shouldn't be instantiated, but rather subclassed.
> @@ -57,7 +54,8 @@ class Node(ABC):
>      ports: list[Port]
>      _logger: DTSLogger
>      _other_sessions: list[OSSession]
> -    _test_run_config: TestRunConfiguration
> +    _node_info: OSSessionInfo | None
> +    _compiler_version: str | None
>
>      def __init__(self, node_config: NodeConfiguration):
>          """Connect to the node and gather info during initialization.
> @@ -80,35 +78,13 @@ def __init__(self, node_config: NodeConfiguration):
>          self._get_remote_cpus()
>          self._other_sessions =3D []
>          self.ports =3D [Port(self, port_config) for port_config in self.=
config.ports]
> +        self._logger.info(f"Created node: {self.name}")
>
>      @cached_property
>      def ports_by_name(self) -> dict[str, Port]:
>          """Ports mapped by the name assigned at configuration."""
>          return {port.name: port for port in self.ports}
>
> -    def set_up_test_run(self, test_run_config: TestRunConfiguration, por=
ts: Iterable[Port]) -> None:
> -        """Test run setup steps.
> -
> -        Configure hugepages on all DTS node types. Additional steps can =
be added by
> -        extending the method in subclasses with the use of super().
> -
> -        Args:
> -            test_run_config: A test run configuration according to which
> -                the setup steps will be taken.
> -            ports: The ports to set up for the test run.
> -        """
> -        self._setup_hugepages()
> -
> -    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
> -        """Test run teardown steps.
> -
> -        There are currently no common execution teardown steps common to=
 all DTS node types.
> -        Additional steps can be added by extending the method in subclas=
ses with the use of super().
> -
> -        Args:
> -            ports: The ports to tear down for the test run.
> -        """
> -
>      def create_session(self, name: str) -> OSSession:
>          """Create and return a new OS-aware remote session.
>
> @@ -134,40 +110,33 @@ def create_session(self, name: str) -> OSSession:
>          self._other_sessions.append(connection)
>          return connection
>
> -    def filter_lcores(
> -        self,
> -        filter_specifier: LogicalCoreCount | LogicalCoreList,
> -        ascending: bool =3D True,
> -    ) -> list[LogicalCore]:
> -        """Filter the node's logical cores that DTS can use.
> -
> -        Logical cores that DTS can use are the ones that are present on =
the node, but filtered
> -        according to the test run configuration. The `filter_specifier` =
will filter cores from
> -        those logical cores.
> -
> -        Args:
> -            filter_specifier: Two different filters can be used, one tha=
t specifies the number
> -                of logical cores per core, cores per socket and the numb=
er of sockets,
> -                and another one that specifies a logical core list.
> -            ascending: If :data:`True`, use cores with the lowest numeri=
cal id first and continue
> -                in ascending order. If :data:`False`, start with the hig=
hest id and continue
> -                in descending order. This ordering affects which sockets=
 to consider first as well.
> -
> -        Returns:
> -            The filtered logical cores.
> -        """
> -        self._logger.debug(f"Filtering {filter_specifier} from {self.lco=
res}.")
> -        return lcore_filter(
> -            self.lcores,
> -            filter_specifier,
> -            ascending,
> -        ).filter()
> -
>      def _get_remote_cpus(self) -> None:
>          """Scan CPUs in the remote OS and store a list of LogicalCores."=
""
>          self._logger.info("Getting CPU information.")
>          self.lcores =3D self.main_session.get_remote_cpus()
>
> +    @cached_property
> +    def node_info(self) -> OSSessionInfo:
> +        """Additional node information."""
> +        return self.main_session.get_node_info()
> +
> +    @property
> +    def compiler_version(self) -> str | None:
> +        """The node's compiler version."""
> +        if self._compiler_version is None:
> +            self._logger.warning("The `compiler_version` is None because=
 a pre-built DPDK is used.")
> +
> +        return self._compiler_version
> +
> +    @compiler_version.setter
> +    def compiler_version(self, value: str) -> None:
> +        """Set the `compiler_version` used on the SUT node.
> +
> +        Args:
> +            value: The node's compiler version.
> +        """
> +        self._compiler_version =3D value
> +
>      def _setup_hugepages(self) -> None:
>          """Setup hugepages on the node.
>
> diff --git a/dts/framework/testbed_model/tg_node.py b/dts/framework/testb=
ed_model/tg_node.py
> deleted file mode 100644
> index 290a3fbd74..0000000000
> --- a/dts/framework/testbed_model/tg_node.py
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2010-2014 Intel Corporation
> -# Copyright(c) 2022 University of New Hampshire
> -# Copyright(c) 2023 PANTHEON.tech s.r.o.
> -
> -"""Traffic generator node.
> -
> -A traffic generator (TG) generates traffic that's sent towards the SUT n=
ode.
> -A TG node is where the TG runs.
> -"""
> -
> -from collections.abc import Iterable
> -
> -from scapy.packet import Packet
> -
> -from framework.config.node import TGNodeConfiguration
> -from framework.config.test_run import TestRunConfiguration
> -from framework.testbed_model.traffic_generator.capturing_traffic_generat=
or import (
> -    PacketFilteringConfig,
> -)
> -
> -from .node import Node
> -from .port import Port
> -from .traffic_generator import CapturingTrafficGenerator, create_traffic=
_generator
> -
> -
> -class TGNode(Node):
> -    """The traffic generator node.
> -
> -    The TG node extends :class:`Node` with TG specific features:
> -
> -        * Traffic generator initialization,
> -        * The sending of traffic and receiving packets,
> -        * The sending of traffic without receiving packets.
> -
> -    Not all traffic generators are capable of capturing traffic, which i=
s why there
> -    must be a way to send traffic without that.
> -
> -    Attributes:
> -        config: The traffic generator node configuration.
> -        traffic_generator: The traffic generator running on the node.
> -    """
> -
> -    config: TGNodeConfiguration
> -    traffic_generator: CapturingTrafficGenerator
> -
> -    def __init__(self, node_config: TGNodeConfiguration):
> -        """Extend the constructor with TG node specifics.
> -
> -        Initialize the traffic generator on the TG node.
> -
> -        Args:
> -            node_config: The TG node's test run configuration.
> -        """
> -        super().__init__(node_config)
> -        self._logger.info(f"Created node: {self.name}")
> -
> -    def set_up_test_run(self, test_run_config: TestRunConfiguration, por=
ts: Iterable[Port]) -> None:
> -        """Extend the test run setup with the setup of the traffic gener=
ator.
> -
> -        Args:
> -            test_run_config: A test run configuration according to which
> -                the setup steps will be taken.
> -            ports: The ports to set up for the test run.
> -        """
> -        super().set_up_test_run(test_run_config, ports)
> -        self.main_session.bring_up_link(ports)
> -        self.traffic_generator =3D create_traffic_generator(self, self.c=
onfig.traffic_generator)
> -
> -    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
> -        """Extend the test run teardown with the teardown of the traffic=
 generator.
> -
> -        Args:
> -            ports: The ports to tear down for the test run.
> -        """
> -        super().tear_down_test_run(ports)
> -        self.traffic_generator.close()
> -
> -    def send_packets_and_capture(
> -        self,
> -        packets: list[Packet],
> -        send_port: Port,
> -        receive_port: Port,
> -        filter_config: PacketFilteringConfig =3D PacketFilteringConfig()=
,
> -        duration: float =3D 1,
> -    ) -> list[Packet]:
> -        """Send `packets`, return received traffic.
> -
> -        Send `packets` on `send_port` and then return all traffic captur=
ed
> -        on `receive_port` for the given duration. Also record the captur=
ed traffic
> -        in a pcap file.
> -
> -        Args:
> -            packets: The packets to send.
> -            send_port: The egress port on the TG node.
> -            receive_port: The ingress port in the TG node.
> -            filter_config: The filter to use when capturing packets.
> -            duration: Capture traffic for this amount of time after send=
ing `packet`.
> -
> -        Returns:
> -             A list of received packets. May be empty if no packets are =
captured.
> -        """
> -        return self.traffic_generator.send_packets_and_capture(
> -            packets,
> -            send_port,
> -            receive_port,
> -            filter_config,
> -            duration,
> -        )
> -
> -    def send_packets(self, packets: list[Packet], port: Port):
> -        """Send packets without capturing resulting received packets.
> -
> -        Args:
> -            packets: Packets to send.
> -            port: Port to send the packets on.
> -        """
> -        self.traffic_generator.send_packets(packets, port)
> -
> -    def close(self) -> None:
> -        """Free all resources used by the node.
> -
> -        This extends the superclass method with TG cleanup.
> -        """
> -        super().close()
> diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/=
dts/framework/testbed_model/traffic_generator/__init__.py
> index 922875f401..2a259a6e6c 100644
> --- a/dts/framework/testbed_model/traffic_generator/__init__.py
> +++ b/dts/framework/testbed_model/traffic_generator/__init__.py
> @@ -14,7 +14,7 @@
>  and a capturing traffic generator is required.
>  """
>
> -from framework.config.node import ScapyTrafficGeneratorConfig, TrafficGe=
neratorConfig
> +from framework.config.test_run import ScapyTrafficGeneratorConfig, Traff=
icGeneratorConfig
>  from framework.exception import ConfigurationError
>  from framework.testbed_model.node import Node
>
> @@ -23,13 +23,13 @@
>
>
>  def create_traffic_generator(
> -    tg_node: Node, traffic_generator_config: TrafficGeneratorConfig
> +    traffic_generator_config: TrafficGeneratorConfig, node: Node
>  ) -> CapturingTrafficGenerator:
>      """The factory function for creating traffic generator objects from =
the test run configuration.
>
>      Args:
> -        tg_node: The traffic generator node where the created traffic ge=
nerator will be running.
>          traffic_generator_config: The traffic generator config.
> +        node: The node where the created traffic generator will be runni=
ng.
>
>      Returns:
>          A traffic generator capable of capturing received packets.
> @@ -39,6 +39,6 @@ def create_traffic_generator(
>      """
>      match traffic_generator_config:
>          case ScapyTrafficGeneratorConfig():
> -            return ScapyTrafficGenerator(tg_node, traffic_generator_conf=
ig, privileged=3DTrue)
> +            return ScapyTrafficGenerator(node, traffic_generator_config,=
 privileged=3DTrue)
>          case _:
>              raise ConfigurationError(f"Unknown traffic generator: {traff=
ic_generator_config.type}")
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts=
/framework/testbed_model/traffic_generator/scapy.py
> index c9c7dac54a..520561b2eb 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -14,13 +14,15 @@
>
>  import re
>  import time
> +from collections.abc import Iterable
>  from typing import ClassVar
>
>  from scapy.compat import base64_bytes
>  from scapy.layers.l2 import Ether
>  from scapy.packet import Packet
>
> -from framework.config.node import OS, ScapyTrafficGeneratorConfig
> +from framework.config.node import OS
> +from framework.config.test_run import ScapyTrafficGeneratorConfig
>  from framework.remote_session.python_shell import PythonShell
>  from framework.testbed_model.node import Node
>  from framework.testbed_model.port import Port
> @@ -83,6 +85,14 @@ def __init__(self, tg_node: Node, config: ScapyTraffic=
GeneratorConfig, **kwargs)
>          super().__init__(node=3Dtg_node, config=3Dconfig, tg_node=3Dtg_n=
ode, **kwargs)
>          self.start_application()
>
> +    def setup(self, ports: Iterable[Port]):
> +        """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
> +
> +        Brings up the port links.
> +        """
> +        super().setup(ports)
> +        self._tg_node.main_session.bring_up_link(ports)
> +
>      def start_application(self) -> None:
>          """Extends :meth:`framework.remote_session.interactive_shell.sta=
rt_application`.
>
> diff --git a/dts/framework/testbed_model/traffic_generator/traffic_genera=
tor.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index 9b4d5dc80a..4469273e36 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -9,10 +9,11 @@
>  """
>
>  from abc import ABC, abstractmethod
> +from typing import Iterable
>
>  from scapy.packet import Packet
>
> -from framework.config.node import TrafficGeneratorConfig
> +from framework.config.test_run import TrafficGeneratorConfig
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.testbed_model.node import Node
>  from framework.testbed_model.port import Port
> @@ -49,6 +50,12 @@ def __init__(self, tg_node: Node, config: TrafficGener=
atorConfig, **kwargs):
>          self._logger =3D get_dts_logger(f"{self._tg_node.name} {self._co=
nfig.type}")
>          super().__init__(**kwargs)
>
> +    def setup(self, ports: Iterable[Port]):
> +        """Setup the traffic generator."""
> +
> +    def teardown(self):
> +        """Teardown the traffic generator."""
> +
>      def send_packet(self, packet: Packet, port: Port) -> None:
>          """Send `packet` and block until it is fully sent.
>
> diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smo=
ke_tests.py
> index 8a5799c684..a8ea07595f 100644
> --- a/dts/tests/TestSuite_smoke_tests.py
> +++ b/dts/tests/TestSuite_smoke_tests.py
> @@ -47,7 +47,7 @@ def set_up_suite(self) -> None:
>              Set the build directory path and a list of NICs in the SUT n=
ode.
>          """
>          self.sut_node =3D self._ctx.sut_node  # FIXME: accessing the con=
text should be forbidden
> -        self.dpdk_build_dir_path =3D self.sut_node.remote_dpdk_build_dir
> +        self.dpdk_build_dir_path =3D self._ctx.dpdk.build.remote_dpdk_bu=
ild_dir
>          self.nics_in_node =3D self.sut_node.config.ports
>
>      @func_test
> @@ -79,7 +79,7 @@ def test_driver_tests(self) -> None:
>              Run the ``driver-tests`` unit test suite through meson.
>          """
>          vdev_args =3D ""
> -        for dev in self.sut_node.virtual_devices:
> +        for dev in self._ctx.dpdk.get_virtual_devices():
>              vdev_args +=3D f"--vdev {dev} "
>          vdev_args =3D vdev_args[:-1]
>          driver_tests_command =3D f"meson test -C {self.dpdk_build_dir_pa=
th} --suite driver-tests"
> @@ -125,7 +125,7 @@ def test_device_bound_to_driver(self) -> None:
>              List all devices with the ``dpdk-devbind.py`` script and ver=
ify that
>              the configured devices are bound to the proper driver.
>          """
> -        path_to_devbind =3D self.sut_node.path_to_devbind_script
> +        path_to_devbind =3D self._ctx.dpdk.devbind_script_path
>
>          all_nics_in_dpdk_devbind =3D self.sut_node.main_session.send_com=
mand(
>              f"{path_to_devbind} --status | awk '/{REGEX_FOR_PCI_ADDRESS}=
/'",
> diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic=
.py
> index 370fd6b419..eefd6d3273 100644
> --- a/dts/tests/TestSuite_softnic.py
> +++ b/dts/tests/TestSuite_softnic.py
> @@ -46,7 +46,7 @@ def prepare_softnic_files(self) -> PurePath:
>          spec_file =3D Path("rx_tx.spec")
>          rx_tx_1_file =3D Path("rx_tx_1.io")
>          rx_tx_2_file =3D Path("rx_tx_2.io")
> -        path_sut =3D self.sut_node.remote_dpdk_build_dir
> +        path_sut =3D self._ctx.dpdk.build.remote_dpdk_build_dir
>          cli_file_sut =3D self.sut_node.main_session.join_remote_path(pat=
h_sut, cli_file)
>          spec_file_sut =3D self.sut_node.main_session.join_remote_path(pa=
th_sut, spec_file)
>          rx_tx_1_file_sut =3D self.sut_node.main_session.join_remote_path=
(path_sut, rx_tx_1_file)
> --
> 2.43.0
>
