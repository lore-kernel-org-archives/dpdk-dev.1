Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4340C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 19:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6FD942D55;
	Wed, 12 Feb 2025 20:46:11 +0100 (CET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mails.dpdk.org (Postfix) with ESMTP id F3C3A400D5
 for <dev@dpdk.org>; Wed, 12 Feb 2025 20:46:09 +0100 (CET)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-308e65891e4so144231fa.2
 for <dev@dpdk.org>; Wed, 12 Feb 2025 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739389569; x=1739994369; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyqTvoYsYLi8Oq2YQIjxSIj2alS8DwCQkaBCVn1gkOY=;
 b=NT1ta0Ay4pV5MboPfFMB1Xzaf13ZmN/z2fgzX+dKJXxXF+98MMgGgbyj9Qc0KoH19w
 +2URVQ4JQYQlYd5b3D0UnQvowo7SQtpAL4g0vY3bXPccdtPR2M9etN04qVEJbt1Lap0H
 s0gnGhpt4M6aMwWv7ppmImpWBpLt5+4Y1b5Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739389569; x=1739994369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyqTvoYsYLi8Oq2YQIjxSIj2alS8DwCQkaBCVn1gkOY=;
 b=cnJJ39jRU1MECVpzb8UiOCAMB/+NF/xfN7o7Wfn4OciNay+HsN8a7vM4HWHN7rgqy9
 LUumfjfqfPoP1iK4Khgk4rSmlV37zZrf+5yc/vCs95bdmYpT56rvqAFe7eMlx7KBNcJN
 97zMkNHBej2NxYkJVFmrOBgaSHmu+78WuCMKjf2kNbWIeLPLt5o2YBz4WPRnD37YcrDO
 xj2kznVL6GrqeJOu3edhTQP0u3bY125DUVbmXvR9jEckQEvEKWd9Ac/kzRDD5CeuxyTr
 5hKuGs1HM2amOp+aJv+bsNBDMwcKFqR6rtPOOARqd6kKR+ghMojcvoMeNKM1jkNJHKgV
 180A==
X-Gm-Message-State: AOJu0YymMxwbnBOo0AJqMgIithHNAIDhT3OPdMYaGKSokpnKuG2Eh+YH
 SRL3kDX4ORypEmGqvqc8Uu8AvJvjcJoj799cyAnYPoy9c/HFbqbjtkV6DU/sUoHRGWbU95LGDKo
 ARjTvOg6QAYhIwmqKiljWKVlBJWv5FRsrXMFm9A==
X-Gm-Gg: ASbGnct2K9f+9LlbJk4xTCO69BqjcVlGfML8/5Sr4HX2SzPiZTplq47NXREbo5dQhu5
 ejShffkeGp2NSysofPBmDhUn2Ku4dKudu99ORrZpmxoPi7vawLH7/GEQc8/hRauU/WYY5FFpPEb
 jrFpYWRIeoV+xtUTd/bBazIEgGsUfLGrM=
X-Google-Smtp-Source: AGHT+IGUoRJFnDu1/USADEeFwJ4OhUUtsSBLuAWGC2fdCQXA7FwbG6JEb7DCbJcDPohqkuH/ypm0cwIqbvPiAmy4/bg=
X-Received: by 2002:a05:651c:1991:b0:308:e8c0:ebdd with SMTP id
 38308e7fff4ca-3090463121bmr6138141fa.7.1739389568689; Wed, 12 Feb 2025
 11:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
 <20250212164600.23759-6-luca.vizzarro@arm.com>
In-Reply-To: <20250212164600.23759-6-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 12 Feb 2025 14:45:56 -0500
X-Gm-Features: AWEUYZn-iuhgUO7XfOPtd7ohZ2vY111epAqR4Fau9dshXzLd-8UpyLgzIDrsPDc
Message-ID: <CAKXZ7eic-yY6PwbQUk2xfCAhdJyC7ZQas6-jraDVkiU9RHp3gQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dts: add global runtime context
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

Definitely much easier to read, in a general sense, with these changes.

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Wed, Feb 12, 2025 at 11:46=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om> wrote:
>
> Add a new context module which holds the runtime context. The new
> context will describe the current scenario and aid underlying classes
> used by the test suites to automatically infer their parameters. This
> further simplifies the test writing process as the test writer won't need
> to be concerned about the nodes, and can directly use the tools
> implementing context awareness, e.g. TestPmdShell, as needed.
>
> Bugzilla ID: 1461
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/api/dts/framework.context.rst             |   8 ++
>  doc/api/dts/index.rst                         |   1 +
>  dts/framework/context.py                      | 117 ++++++++++++++++++
>  dts/framework/remote_session/dpdk_shell.py    |  53 +++-----
>  .../single_active_interactive_shell.py        |  14 +--
>  dts/framework/remote_session/testpmd_shell.py |  27 ++--
>  dts/framework/test_suite.py                   |  73 +++++------
>  dts/tests/TestSuite_blocklist.py              |   6 +-
>  dts/tests/TestSuite_checksum_offload.py       |  14 +--
>  dts/tests/TestSuite_dual_vlan.py              |   6 +-
>  dts/tests/TestSuite_dynamic_config.py         |   8 +-
>  dts/tests/TestSuite_dynamic_queue_conf.py     |   1 -
>  dts/tests/TestSuite_hello_world.py            |   2 +-
>  dts/tests/TestSuite_l2fwd.py                  |   9 +-
>  dts/tests/TestSuite_mac_filter.py             |  10 +-
>  dts/tests/TestSuite_mtu.py                    |  17 +--
>  dts/tests/TestSuite_pmd_buffer_scatter.py     |   9 +-
>  ...stSuite_port_restart_config_persistency.py |   8 +-
>  dts/tests/TestSuite_promisc_support.py        |   8 +-
>  dts/tests/TestSuite_smoke_tests.py            |   3 +-
>  dts/tests/TestSuite_softnic.py                |   4 +-
>  dts/tests/TestSuite_uni_pkt.py                |  14 +--
>  dts/tests/TestSuite_vlan.py                   |   8 +-
>  23 files changed, 247 insertions(+), 173 deletions(-)
>  create mode 100644 doc/api/dts/framework.context.rst
>  create mode 100644 dts/framework/context.py
>
> diff --git a/doc/api/dts/framework.context.rst b/doc/api/dts/framework.co=
ntext.rst
> new file mode 100644
> index 0000000000..a8c8b5022e
> --- /dev/null
> +++ b/doc/api/dts/framework.context.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +context - DTS execution context
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: framework.context
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
> index 534512dc17..90092014d2 100644
> --- a/doc/api/dts/index.rst
> +++ b/doc/api/dts/index.rst
> @@ -29,6 +29,7 @@ Modules
>     framework.test_suite
>     framework.test_result
>     framework.settings
> +   framework.context
>     framework.logger
>     framework.parser
>     framework.utils
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> new file mode 100644
> index 0000000000..03eaf63b88
> --- /dev/null
> +++ b/dts/framework/context.py
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Runtime contexts."""
> +
> +import functools
> +from dataclasses import MISSING, dataclass, field, fields
> +from typing import TYPE_CHECKING, ParamSpec
> +
> +from framework.exception import InternalError
> +from framework.settings import SETTINGS
> +from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreLis=
t
> +from framework.testbed_model.topology import Topology
> +
> +if TYPE_CHECKING:
> +    from framework.testbed_model.sut_node import SutNode
> +    from framework.testbed_model.tg_node import TGNode
> +
> +P =3D ParamSpec("P")
> +
> +
> +@dataclass
> +class LocalContext:
> +    """Updatable context local to test suites and cases.
> +
> +    Attributes:
> +        lcore_filter_specifier: A number of lcores/cores/sockets to use =
or a list of lcore ids to
> +            use. The default will select one lcore for each of two cores=
 on one socket, in ascending
> +            order of core ids.
> +        ascending_cores: Sort cores in ascending order (lowest to highes=
t IDs). If :data:`False`,
> +            sort in descending order.
> +        append_prefix_timestamp: If :data:`True`, will append a timestam=
p to DPDK file prefix.
> +        timeout: The timeout used for the SSH channel that is dedicated =
to this interactive
> +            shell. This timeout is for collecting output, so if reading =
from the buffer
> +            and no output is gathered within the timeout, an exception i=
s thrown.
> +    """
> +
> +    lcore_filter_specifier: LogicalCoreCount | LogicalCoreList =3D field=
(
> +        default_factory=3DLogicalCoreCount
> +    )
> +    ascending_cores: bool =3D True
> +    append_prefix_timestamp: bool =3D True
> +    timeout: float =3D SETTINGS.timeout
> +
> +    def reset(self) -> None:
> +        """Reset the local context to the default values."""
> +        for _field in fields(LocalContext):
> +            default =3D (
> +                _field.default_factory()
> +                if _field.default_factory is not MISSING
> +                else _field.default
> +            )
> +
> +            assert (
> +                default is not MISSING
> +            ), "{LocalContext.__name__} must have defaults on all fields=
!"
> +
> +            setattr(self, _field.name, default)
> +
> +
> +@dataclass(frozen=3DTrue)
> +class Context:
> +    """Runtime context."""
> +
> +    sut_node: "SutNode"
> +    tg_node: "TGNode"
> +    topology: Topology
> +    local: LocalContext =3D field(default_factory=3DLocalContext)
> +
> +
> +__current_ctx: Context | None =3D None
> +
> +
> +def get_ctx() -> Context:
> +    """Retrieve the current runtime context.
> +
> +    Raises:
> +        InternalError: If there is no context.
> +    """
> +    if __current_ctx:
> +        return __current_ctx
> +
> +    raise InternalError("Attempted to retrieve context that has not been=
 initialized yet.")
> +
> +
> +def init_ctx(ctx: Context) -> None:
> +    """Initialize context."""
> +    global __current_ctx
> +    __current_ctx =3D ctx
> +
> +
> +def filter_cores(
> +    specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool=
 | None =3D None
> +):
> +    """Decorates functions that require a temporary update to the lcore =
specifier."""
> +
> +    def decorator(func):
> +        @functools.wraps(func)
> +        def wrapper(*args: P.args, **kwargs: P.kwargs):
> +            local_ctx =3D get_ctx().local
> +
> +            old_specifier =3D local_ctx.lcore_filter_specifier
> +            local_ctx.lcore_filter_specifier =3D specifier
> +            if ascending_cores is not None:
> +                old_ascending_cores =3D local_ctx.ascending_cores
> +                local_ctx.ascending_cores =3D ascending_cores
> +
> +            try:
> +                return func(*args, **kwargs)
> +            finally:
> +                local_ctx.lcore_filter_specifier =3D old_specifier
> +                if ascending_cores is not None:
> +                    local_ctx.ascending_cores =3D old_ascending_cores
> +
> +        return wrapper
> +
> +    return decorator
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index c11d9ab81c..b55deb7fa0 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -9,54 +9,45 @@
>  from abc import ABC
>  from pathlib import PurePath
>
> +from framework.context import get_ctx
>  from framework.params.eal import EalParams
>  from framework.remote_session.single_active_interactive_shell import (
>      SingleActiveInteractiveShell,
>  )
> -from framework.settings import SETTINGS
> -from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreLis=
t
> +from framework.testbed_model.cpu import LogicalCoreList
>  from framework.testbed_model.sut_node import SutNode
>
>
>  def compute_eal_params(
> -    sut_node: SutNode,
>      params: EalParams | None =3D None,
> -    lcore_filter_specifier: LogicalCoreCount | LogicalCoreList =3D Logic=
alCoreCount(),
> -    ascending_cores: bool =3D True,
> -    append_prefix_timestamp: bool =3D True,
>  ) -> EalParams:
>      """Compute EAL parameters based on the node's specifications.
>
>      Args:
> -        sut_node: The SUT node to compute the values for.
>          params: If :data:`None`, a new object is created and returned. O=
therwise `params.lcore_list`
>              is modified according to `lcore_filter_specifier`. A DPDK fi=
le prefix is also added. If
>              `params.ports` is :data:`None`, then `sut_node.ports` is ass=
igned to it.
> -        lcore_filter_specifier: A number of lcores/cores/sockets to use =
or a list of lcore ids to
> -            use. The default will select one lcore for each of two cores=
 on one socket, in ascending
> -            order of core ids.
> -        ascending_cores: Sort cores in ascending order (lowest to highes=
t IDs). If :data:`False`,
> -            sort in descending order.
> -        append_prefix_timestamp: If :data:`True`, will append a timestam=
p to DPDK file prefix.
>      """
> +    ctx =3D get_ctx()
> +
>      if params is None:
>          params =3D EalParams()
>
>      if params.lcore_list is None:
>          params.lcore_list =3D LogicalCoreList(
> -            sut_node.filter_lcores(lcore_filter_specifier, ascending_cor=
es)
> +            ctx.sut_node.filter_lcores(ctx.local.lcore_filter_specifier,=
 ctx.local.ascending_cores)
>          )
>
>      prefix =3D params.prefix
> -    if append_prefix_timestamp:
> -        prefix =3D f"{prefix}_{sut_node.dpdk_timestamp}"
> -    prefix =3D sut_node.main_session.get_dpdk_file_prefix(prefix)
> +    if ctx.local.append_prefix_timestamp:
> +        prefix =3D f"{prefix}_{ctx.sut_node.dpdk_timestamp}"
> +    prefix =3D ctx.sut_node.main_session.get_dpdk_file_prefix(prefix)
>      if prefix:
> -        sut_node.dpdk_prefix_list.append(prefix)
> +        ctx.sut_node.dpdk_prefix_list.append(prefix)
>      params.prefix =3D prefix
>
>      if params.allowed_ports is None:
> -        params.allowed_ports =3D sut_node.ports
> +        params.allowed_ports =3D ctx.topology.sut_ports
>
>      return params
>
> @@ -74,29 +65,15 @@ class DPDKShell(SingleActiveInteractiveShell, ABC):
>
>      def __init__(
>          self,
> -        node: SutNode,
> +        name: str | None =3D None,
>          privileged: bool =3D True,
> -        timeout: float =3D SETTINGS.timeout,
> -        lcore_filter_specifier: LogicalCoreCount | LogicalCoreList =3D L=
ogicalCoreCount(),
> -        ascending_cores: bool =3D True,
> -        append_prefix_timestamp: bool =3D True,
>          app_params: EalParams =3D EalParams(),
> -        name: str | None =3D None,
>      ) -> None:
> -        """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`=
.
> -
> -        Adds the `lcore_filter_specifier`, `ascending_cores` and `append=
_prefix_timestamp` arguments
> -        which are then used to compute the EAL parameters based on the n=
ode's configuration.
> -        """
> -        app_params =3D compute_eal_params(
> -            node,
> -            app_params,
> -            lcore_filter_specifier,
> -            ascending_cores,
> -            append_prefix_timestamp,
> -        )
> +        """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`=
."""
> +        app_params =3D compute_eal_params(app_params)
> +        node =3D get_ctx().sut_node
>
> -        super().__init__(node, privileged, timeout, app_params, name)
> +        super().__init__(node, name, privileged, app_params)
>
>      def _update_real_path(self, path: PurePath) -> None:
>          """Extends :meth:`~.interactive_shell.InteractiveShell._update_r=
eal_path`.
> diff --git a/dts/framework/remote_session/single_active_interactive_shell=
.py b/dts/framework/remote_session/single_active_interactive_shell.py
> index cfe5baec14..2eec2f698a 100644
> --- a/dts/framework/remote_session/single_active_interactive_shell.py
> +++ b/dts/framework/remote_session/single_active_interactive_shell.py
> @@ -27,6 +27,7 @@
>  from paramiko import Channel, channel
>  from typing_extensions import Self
>
> +from framework.context import get_ctx
>  from framework.exception import (
>      InteractiveCommandExecutionError,
>      InteractiveSSHSessionDeadError,
> @@ -34,7 +35,6 @@
>  )
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.params import Params
> -from framework.settings import SETTINGS
>  from framework.testbed_model.node import Node
>  from framework.utils import MultiInheritanceBaseClass
>
> @@ -90,10 +90,9 @@ class SingleActiveInteractiveShell(MultiInheritanceBas=
eClass, ABC):
>      def __init__(
>          self,
>          node: Node,
> +        name: str | None =3D None,
>          privileged: bool =3D False,
> -        timeout: float =3D SETTINGS.timeout,
>          app_params: Params =3D Params(),
> -        name: str | None =3D None,
>          **kwargs,
>      ) -> None:
>          """Create an SSH channel during initialization.
> @@ -103,13 +102,10 @@ def __init__(
>
>          Args:
>              node: The node on which to run start the interactive shell.
> -            privileged: Enables the shell to run as superuser.
> -            timeout: The timeout used for the SSH channel that is dedica=
ted to this interactive
> -                shell. This timeout is for collecting output, so if read=
ing from the buffer
> -                and no output is gathered within the timeout, an excepti=
on is thrown.
> -            app_params: The command line parameters to be passed to the =
application on startup.
>              name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
>                  the name of the underlying node which it is running on.
> +            privileged: Enables the shell to run as superuser.
> +            app_params: The command line parameters to be passed to the =
application on startup.
>              **kwargs: Any additional arguments if any.
>          """
>          self._node =3D node
> @@ -118,7 +114,7 @@ def __init__(
>          self._logger =3D get_dts_logger(f"{node.name}.{name}")
>          self._app_params =3D app_params
>          self._privileged =3D privileged
> -        self._timeout =3D timeout
> +        self._timeout =3D get_ctx().local.timeout
>          # Ensure path is properly formatted for the host
>          self._update_real_path(self.path)
>          super().__init__(**kwargs)
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index 287886ec44..672ecd970f 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -32,6 +32,9 @@
>      TypeAlias,
>  )
>
> +from framework.context import get_ctx
> +from framework.testbed_model.topology import TopologyType
> +
>  if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
>      from enum import Enum as NoAliasEnum
>  else:
> @@ -40,13 +43,11 @@
>  from typing_extensions import Self, Unpack
>
>  from framework.exception import InteractiveCommandExecutionError, Intern=
alError
> -from framework.params.testpmd import SimpleForwardingModes, TestPmdParam=
s
> +from framework.params.testpmd import PortTopology, SimpleForwardingModes=
, TestPmdParams
>  from framework.params.types import TestPmdParamsDict
>  from framework.parser import ParserFn, TextParser
>  from framework.remote_session.dpdk_shell import DPDKShell
>  from framework.settings import SETTINGS
> -from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreLis=
t
> -from framework.testbed_model.sut_node import SutNode
>  from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
>
>  P =3D ParamSpec("P")
> @@ -1532,26 +1533,14 @@ class TestPmdShell(DPDKShell):
>
>      def __init__(
>          self,
> -        node: SutNode,
> -        privileged: bool =3D True,
> -        timeout: float =3D SETTINGS.timeout,
> -        lcore_filter_specifier: LogicalCoreCount | LogicalCoreList =3D L=
ogicalCoreCount(),
> -        ascending_cores: bool =3D True,
> -        append_prefix_timestamp: bool =3D True,
>          name: str | None =3D None,
> +        privileged: bool =3D True,
>          **app_params: Unpack[TestPmdParamsDict],
>      ) -> None:
>          """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes ap=
p_params to kwargs."""
> -        super().__init__(
> -            node,
> -            privileged,
> -            timeout,
> -            lcore_filter_specifier,
> -            ascending_cores,
> -            append_prefix_timestamp,
> -            TestPmdParams(**app_params),
> -            name,
> -        )
> +        if "port_topology" not in app_params and get_ctx().topology.type=
 is TopologyType.one_link:
> +            app_params["port_topology"] =3D PortTopology.loop
> +        super().__init__(name, privileged, TestPmdParams(**app_params))
>          self.ports_started =3D not self._app_params.disable_device_start
>          self._ports =3D None
>
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 3d168d522b..b9b527e40d 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -24,7 +24,7 @@
>  from ipaddress import IPv4Interface, IPv6Interface, ip_interface
>  from pkgutil import iter_modules
>  from types import ModuleType
> -from typing import ClassVar, Protocol, TypeVar, Union, cast
> +from typing import TYPE_CHECKING, ClassVar, Protocol, TypeVar, Union, ca=
st
>
>  from scapy.layers.inet import IP
>  from scapy.layers.l2 import Ether
> @@ -32,9 +32,6 @@
>  from typing_extensions import Self
>
>  from framework.testbed_model.capability import TestProtocol
> -from framework.testbed_model.port import Port
> -from framework.testbed_model.sut_node import SutNode
> -from framework.testbed_model.tg_node import TGNode
>  from framework.testbed_model.topology import Topology
>  from framework.testbed_model.traffic_generator.capturing_traffic_generat=
or import (
>      PacketFilteringConfig,
> @@ -44,6 +41,9 @@
>  from .logger import DTSLogger, get_dts_logger
>  from .utils import get_packet_summaries, to_pascal_case
>
> +if TYPE_CHECKING:
> +    from framework.context import Context
> +
>
>  class TestSuite(TestProtocol):
>      """The base class with building blocks needed by most test cases.
> @@ -69,33 +69,19 @@ class TestSuite(TestProtocol):
>
>      The test suite is aware of the testbed (the SUT and TG) it's running=
 on. From this, it can
>      properly choose the IP addresses and other configuration that must b=
e tailored to the testbed.
> -
> -    Attributes:
> -        sut_node: The SUT node where the test suite is running.
> -        tg_node: The TG node where the test suite is running.
>      """
>
> -    sut_node: SutNode
> -    tg_node: TGNode
>      #: Whether the test suite is blocking. A failure of a blocking test =
suite
>      #: will block the execution of all subsequent test suites in the cur=
rent test run.
>      is_blocking: ClassVar[bool] =3D False
> +    _ctx: "Context"
>      _logger: DTSLogger
> -    _sut_port_ingress: Port
> -    _sut_port_egress: Port
>      _sut_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>      _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
> -    _tg_port_ingress: Port
> -    _tg_port_egress: Port
>      _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
>
> -    def __init__(
> -        self,
> -        sut_node: SutNode,
> -        tg_node: TGNode,
> -        topology: Topology,
> -    ):
> +    def __init__(self):
>          """Initialize the test suite testbed information and basic confi=
guration.
>
>          Find links between ports and set up default IP addresses to be u=
sed when
> @@ -106,18 +92,25 @@ def __init__(
>              tg_node: The TG node where the test suite will run.
>              topology: The topology where the test suite will run.
>          """
> -        self.sut_node =3D sut_node
> -        self.tg_node =3D tg_node
> +        from framework.context import get_ctx
> +
> +        self._ctx =3D get_ctx()
>          self._logger =3D get_dts_logger(self.__class__.__name__)
> -        self._tg_port_egress =3D topology.tg_port_egress
> -        self._sut_port_ingress =3D topology.sut_port_ingress
> -        self._sut_port_egress =3D topology.sut_port_egress
> -        self._tg_port_ingress =3D topology.tg_port_ingress
>          self._sut_ip_address_ingress =3D ip_interface("192.168.100.2/24"=
)
>          self._sut_ip_address_egress =3D ip_interface("192.168.101.2/24")
>          self._tg_ip_address_egress =3D ip_interface("192.168.100.3/24")
>          self._tg_ip_address_ingress =3D ip_interface("192.168.101.3/24")
>
> +    @property
> +    def name(self) -> str:
> +        """The name of the test suite class."""
> +        return type(self).__name__
> +
> +    @property
> +    def topology(self) -> Topology:
> +        """The current topology in use."""
> +        return self._ctx.topology
> +
>      @classmethod
>      def get_test_cases(cls) -> list[type["TestCase"]]:
>          """A list of all the available test cases."""
> @@ -254,10 +247,10 @@ def send_packets_and_capture(
>              A list of received packets.
>          """
>          packets =3D self._adjust_addresses(packets)
> -        return self.tg_node.send_packets_and_capture(
> +        return self._ctx.tg_node.send_packets_and_capture(
>              packets,
> -            self._tg_port_egress,
> -            self._tg_port_ingress,
> +            self._ctx.topology.tg_port_egress,
> +            self._ctx.topology.tg_port_ingress,
>              filter_config,
>              duration,
>          )
> @@ -272,7 +265,7 @@ def send_packets(
>              packets: Packets to send.
>          """
>          packets =3D self._adjust_addresses(packets)
> -        self.tg_node.send_packets(packets, self._tg_port_egress)
> +        self._ctx.tg_node.send_packets(packets, self._ctx.topology.tg_po=
rt_egress)
>
>      def get_expected_packets(
>          self,
> @@ -352,15 +345,15 @@ def _adjust_addresses(self, packets: list[Packet], =
expected: bool =3D False) -> li
>              # only be the Ether src/dst.
>              if "src" not in packet.fields:
>                  packet.src =3D (
> -                    self._sut_port_egress.mac_address
> +                    self.topology.sut_port_egress.mac_address
>                      if expected
> -                    else self._tg_port_egress.mac_address
> +                    else self.topology.tg_port_egress.mac_address
>                  )
>              if "dst" not in packet.fields:
>                  packet.dst =3D (
> -                    self._tg_port_ingress.mac_address
> +                    self.topology.tg_port_ingress.mac_address
>                      if expected
> -                    else self._sut_port_ingress.mac_address
> +                    else self.topology.sut_port_ingress.mac_address
>                  )
>
>              # update l3 addresses
> @@ -400,10 +393,10 @@ def verify(self, condition: bool, failure_descripti=
on: str) -> None:
>
>      def _fail_test_case_verify(self, failure_description: str) -> None:
>          self._logger.debug("A test case failed, showing the last 10 comm=
ands executed on SUT:")
> -        for command_res in self.sut_node.main_session.remote_session.his=
tory[-10:]:
> +        for command_res in self._ctx.sut_node.main_session.remote_sessio=
n.history[-10:]:
>              self._logger.debug(command_res.command)
>          self._logger.debug("A test case failed, showing the last 10 comm=
ands executed on TG:")
> -        for command_res in self.tg_node.main_session.remote_session.hist=
ory[-10:]:
> +        for command_res in self._ctx.tg_node.main_session.remote_session=
.history[-10:]:
>              self._logger.debug(command_res.command)
>          raise TestCaseVerifyError(failure_description)
>
> @@ -517,14 +510,14 @@ def _verify_l2_frame(self, received_packet: Ether, =
l3: bool) -> bool:
>          self._logger.debug("Looking at the Ether layer.")
>          self._logger.debug(
>              f"Comparing received dst mac '{received_packet.dst}' "
> -            f"with expected '{self._tg_port_ingress.mac_address}'."
> +            f"with expected '{self.topology.tg_port_ingress.mac_address}=
'."
>          )
> -        if received_packet.dst !=3D self._tg_port_ingress.mac_address:
> +        if received_packet.dst !=3D self.topology.tg_port_ingress.mac_ad=
dress:
>              return False
>
> -        expected_src_mac =3D self._tg_port_egress.mac_address
> +        expected_src_mac =3D self.topology.tg_port_egress.mac_address
>          if l3:
> -            expected_src_mac =3D self._sut_port_egress.mac_address
> +            expected_src_mac =3D self.topology.sut_port_egress.mac_addre=
ss
>          self._logger.debug(
>              f"Comparing received src mac '{received_packet.src}' "
>              f"with expected '{expected_src_mac}'."
> diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_block=
list.py
> index b9e9cd1d1a..ce7da1cc8f 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -18,7 +18,7 @@ class TestBlocklist(TestSuite):
>
>      def verify_blocklisted_ports(self, ports_to_block: list[Port]):
>          """Runs testpmd with the given ports blocklisted and verifies th=
e ports."""
> -        with TestPmdShell(self.sut_node, allowed_ports=3D[], blocked_por=
ts=3Dports_to_block) as testpmd:
> +        with TestPmdShell(allowed_ports=3D[], blocked_ports=3Dports_to_b=
lock) as testpmd:
>              allowlisted_ports =3D {port.device_name for port in testpmd.=
show_port_info_all()}
>              blocklisted_ports =3D {port.pci for port in ports_to_block}
>
> @@ -49,7 +49,7 @@ def one_port_blocklisted(self):
>          Verify:
>              That the port was successfully blocklisted.
>          """
> -        self.verify_blocklisted_ports(self.sut_node.ports[:1])
> +        self.verify_blocklisted_ports(self.topology.sut_ports[:1])
>
>      @func_test
>      def all_but_one_port_blocklisted(self):
> @@ -60,4 +60,4 @@ def all_but_one_port_blocklisted(self):
>          Verify:
>              That all specified ports were successfully blocklisted.
>          """
> -        self.verify_blocklisted_ports(self.sut_node.ports[:-1])
> +        self.verify_blocklisted_ports(self.topology.sut_ports[:-1])
> diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuit=
e_checksum_offload.py
> index a8bb6a71f7..b38d73421b 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -128,7 +128,7 @@ def test_insert_checksums(self) -> None:
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP() / Raw(payloa=
d),
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP() / Raw(payloa=
d),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              self.setup_hw_offload(testpmd=3Dtestpmd)
> @@ -160,7 +160,7 @@ def test_no_insert_checksums(self) -> None:
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP() / Raw(payloa=
d),
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP() / Raw(payloa=
d),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              testpmd.start()
> @@ -190,7 +190,7 @@ def test_l4_rx_checksum(self) -> None:
>              Ether(dst=3Dmac_id) / IP() / UDP(chksum=3D0xF),
>              Ether(dst=3Dmac_id) / IP() / TCP(chksum=3D0xF),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              self.setup_hw_offload(testpmd=3Dtestpmd)
> @@ -223,7 +223,7 @@ def test_l3_rx_checksum(self) -> None:
>              Ether(dst=3Dmac_id) / IP(chksum=3D0xF) / UDP(),
>              Ether(dst=3Dmac_id) / IP(chksum=3D0xF) / TCP(),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              self.setup_hw_offload(testpmd=3Dtestpmd)
> @@ -260,7 +260,7 @@ def test_validate_rx_checksum(self) -> None:
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP(chksum=3D0xF),
>              Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP(chksum=3D0xF),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              self.setup_hw_offload(testpmd=3Dtestpmd)
> @@ -299,7 +299,7 @@ def test_vlan_checksum(self) -> None:
>              Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IPv6(src=3D"::1") / =
UDP(chksum=3D0xF) / Raw(payload),
>              Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IPv6(src=3D"::1") / =
TCP(chksum=3D0xF) / Raw(payload),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              self.setup_hw_offload(testpmd=3Dtestpmd)
> @@ -333,7 +333,7 @@ def test_validate_sctp_checksum(self) -> None:
>              Ether(dst=3Dmac_id) / IP() / SCTP(),
>              Ether(dst=3Dmac_id) / IP() / SCTP(chksum=3D0xF),
>          ]
> -        with TestPmdShell(node=3Dself.sut_node, enable_rx_cksum=3DTrue) =
as testpmd:
> +        with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
>              testpmd.set_verbose(level=3D1)
>              testpmd.csum_set_hw(layers=3DChecksumOffloadOptions.sctp)
> diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_=
vlan.py
> index bdbee7e8d1..6af503528d 100644
> --- a/dts/tests/TestSuite_dual_vlan.py
> +++ b/dts/tests/TestSuite_dual_vlan.py
> @@ -193,7 +193,7 @@ def insert_second_vlan(self) -> None:
>              Packets are received.
>              Packet contains two VLAN tags.
>          """
> -        with TestPmdShell(self.sut_node, forward_mode=3DSimpleForwarding=
Modes.mac) as testpmd:
> +        with TestPmdShell(forward_mode=3DSimpleForwardingModes.mac) as t=
estpmd:
>              testpmd.tx_vlan_set(port=3Dself.tx_port, enable=3DTrue, vlan=
=3Dself.vlan_insert_tag)
>              testpmd.start()
>              recv =3D self.send_packet_and_capture(
> @@ -229,7 +229,7 @@ def all_vlan_functions(self) -> None:
>              / Dot1Q(vlan=3Dself.inner_vlan_tag)
>              / Raw(b"X" * 20)
>          )
> -        with TestPmdShell(self.sut_node, forward_mode=3DSimpleForwarding=
Modes.mac) as testpmd:
> +        with TestPmdShell(forward_mode=3DSimpleForwardingModes.mac) as t=
estpmd:
>              testpmd.start()
>              recv =3D self.send_packet_and_capture(send_pkt)
>              self.verify(len(recv) > 0, "Unmodified packet was not receiv=
ed.")
> @@ -269,7 +269,7 @@ def maintains_priority(self) -> None:
>              / Dot1Q(vlan=3Dself.inner_vlan_tag, prio=3D2)
>              / Raw(b"X" * 20)
>          )
> -        with TestPmdShell(self.sut_node, forward_mode=3DSimpleForwarding=
Modes.mac) as testpmd:
> +        with TestPmdShell(forward_mode=3DSimpleForwardingModes.mac) as t=
estpmd:
>              testpmd.start()
>              recv =3D self.send_packet_and_capture(pkt)
>              self.verify(len(recv) > 0, "Did not receive any packets when=
 testing VLAN priority.")
> diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_=
dynamic_config.py
> index 5a33f6f3c2..a4bee2e90b 100644
> --- a/dts/tests/TestSuite_dynamic_config.py
> +++ b/dts/tests/TestSuite_dynamic_config.py
> @@ -88,7 +88,7 @@ def test_default_mode(self) -> None:
>          and sends two packets; one matching source MAC address and one u=
nknown.
>          Verifies that both are received.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              is_promisc =3D testpmd.show_port_info(0).is_promiscuous_mode=
_enabled
>              self.verify(is_promisc, "Promiscuous mode was not enabled by=
 default.")
>              testpmd.start()
> @@ -106,7 +106,7 @@ def test_disable_promisc(self) -> None:
>          and sends two packets; one matching source MAC address and one u=
nknown.
>          Verifies that only the matching address packet is received.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd =3D self.disable_promisc_setup(testpmd=3Dtestpmd, po=
rt_id=3D0)
>              mac =3D testpmd.show_port_info(0).mac_address
>              self.send_packet_and_verify(should_receive=3DTrue, mac_addre=
ss=3Dstr(mac))
> @@ -120,7 +120,7 @@ def test_disable_promisc_broadcast(self) -> None:
>          and sends two packets; one matching source MAC address and one b=
roadcast.
>          Verifies that both packets are received.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd =3D self.disable_promisc_setup(testpmd=3Dtestpmd, po=
rt_id=3D0)
>              mac =3D testpmd.show_port_info(0).mac_address
>              self.send_packet_and_verify(should_receive=3DTrue, mac_addre=
ss=3Dstr(mac))
> @@ -134,7 +134,7 @@ def test_disable_promisc_multicast(self) -> None:
>          and sends two packets; one matching source MAC address and one m=
ulticast.
>          Verifies that the multicast packet is only received once allmult=
icast mode is enabled.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd =3D self.disable_promisc_setup(testpmd=3Dtestpmd, po=
rt_id=3D0)
>              testpmd.set_multicast_all(on=3DFalse)
>              # 01:00:5E:00:00:01 is the first of the multicast MAC range =
of addresses
> diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSu=
ite_dynamic_queue_conf.py
> index e55716f545..344dd540eb 100644
> --- a/dts/tests/TestSuite_dynamic_queue_conf.py
> +++ b/dts/tests/TestSuite_dynamic_queue_conf.py
> @@ -84,7 +84,6 @@ def wrap(self: "TestDynamicQueueConf", is_rx_testing: b=
ool) -> None:
>              queues_to_config.add(random.randint(1, self.number_of_queues=
 - 1))
>          unchanged_queues =3D set(range(self.number_of_queues)) - queues_=
to_config
>          with TestPmdShell(
> -            self.sut_node,
>              port_topology=3DPortTopology.chained,
>              rx_queues=3Dself.number_of_queues,
>              tx_queues=3Dself.number_of_queues,
> diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hel=
lo_world.py
> index 031b94de4d..141f2bc4c9 100644
> --- a/dts/tests/TestSuite_hello_world.py
> +++ b/dts/tests/TestSuite_hello_world.py
> @@ -23,6 +23,6 @@ def test_hello_world(self) -> None:
>          Verify:
>              The testpmd session throws no errors.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.start()
>          self.log("Hello World!")
> diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
> index 0f6ff18907..0555d75ed8 100644
> --- a/dts/tests/TestSuite_l2fwd.py
> +++ b/dts/tests/TestSuite_l2fwd.py
> @@ -7,6 +7,7 @@
>  The forwarding test is performed with several packets being sent at once=
.
>  """
>
> +from framework.context import filter_cores
>  from framework.params.testpmd import EthPeer, SimpleForwardingModes
>  from framework.remote_session.testpmd_shell import TestPmdShell
>  from framework.test_suite import TestSuite, func_test
> @@ -33,6 +34,7 @@ def set_up_suite(self) -> None:
>          """
>          self.packets =3D generate_random_packets(self.NUMBER_OF_PACKETS_=
TO_SEND, self.PAYLOAD_SIZE)
>
> +    @filter_cores(LogicalCoreCount(cores_per_socket=3D4))
>      @func_test
>      def l2fwd_integrity(self) -> None:
>          """Test the L2 forwarding integrity.
> @@ -44,11 +46,12 @@ def l2fwd_integrity(self) -> None:
>          """
>          queues =3D [1, 2, 4, 8]
>
> +        self.topology.sut_ports[0]
> +        self.topology.tg_ports[0]
> +
>          with TestPmdShell(
> -            self.sut_node,
> -            lcore_filter_specifier=3DLogicalCoreCount(cores_per_socket=
=3D4),
>              forward_mode=3DSimpleForwardingModes.mac,
> -            eth_peer=3D[EthPeer(1, self.tg_node.ports[1].mac_address)],
> +            eth_peer=3D[EthPeer(1, self.topology.tg_port_ingress.mac_add=
ress)],
>              disable_device_start=3DTrue,
>          ) as shell:
>              for queues_num in queues:
> diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_=
filter.py
> index 11e4b595c7..e6c55d3ec6 100644
> --- a/dts/tests/TestSuite_mac_filter.py
> +++ b/dts/tests/TestSuite_mac_filter.py
> @@ -101,10 +101,10 @@ def test_add_remove_mac_addresses(self) -> None:
>              Remove the fake mac address from the PMD's address pool.
>              Send a packet with the fake mac address to the PMD. (Should =
not receive)
>          """
> -        with TestPmdShell(self.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.set_promisc(0, enable=3DFalse)
>              testpmd.start()
> -            mac_address =3D self._sut_port_ingress.mac_address
> +            mac_address =3D self.topology.sut_port_ingress.mac_address
>
>              # Send a packet with NIC default mac address
>              self.send_packet_and_verify(mac_address=3Dmac_address, shoul=
d_receive=3DTrue)
> @@ -137,9 +137,9 @@ def test_invalid_address(self) -> None:
>              Determine the device's mac address pool size, and fill the p=
ool with fake addresses.
>              Attempt to add another fake mac address, overloading the add=
ress pool. (Should fail)
>          """
> -        with TestPmdShell(self.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.start()
> -            mac_address =3D self._sut_port_ingress.mac_address
> +            mac_address =3D self.topology.sut_port_ingress.mac_address
>              try:
>                  testpmd.set_mac_addr(0, "00:00:00:00:00:00", add=3DTrue)
>                  self.verify(False, "Invalid mac address added.")
> @@ -191,7 +191,7 @@ def test_multicast_filter(self) -> None:
>              Remove the fake multicast address from the PMDs multicast ad=
dress filter.
>              Send a packet with the fake multicast address to the PMD. (S=
hould not receive)
>          """
> -        with TestPmdShell(self.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.start()
>              testpmd.set_promisc(0, enable=3DFalse)
>              multicast_address =3D "01:00:5E:00:00:00"
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index 4b59515bae..63e570ba03 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -51,8 +51,8 @@ def set_up_suite(self) -> None:
>              Set traffic generator MTU lengths to a size greater than sco=
pe of all
>              test cases.
>          """
> -        self.tg_node.main_session.configure_port_mtu(JUMBO_MTU + 200, se=
lf._tg_port_egress)
> -        self.tg_node.main_session.configure_port_mtu(JUMBO_MTU + 200, se=
lf._tg_port_ingress)
> +        self.topology.tg_port_egress.configure_mtu(JUMBO_MTU + 200)
> +        self.topology.tg_port_ingress.configure_mtu(JUMBO_MTU + 200)
>
>      def send_packet_and_verify(self, pkt_size: int, should_receive: bool=
) -> None:
>          """Generate, send a packet, and assess its behavior based on a g=
iven packet size.
> @@ -156,11 +156,7 @@ def test_runtime_mtu_updating_and_forwarding(self) -=
> None:
>              Verify that standard MTU packets forward, in addition to pac=
kets within the limits of
>              an MTU size set during runtime.
>          """
> -        with TestPmdShell(
> -            self.sut_node,
> -            tx_offloads=3D0x8000,
> -            mbuf_size=3D[JUMBO_MTU + 200],
> -        ) as testpmd:
> +        with TestPmdShell(tx_offloads=3D0x8000, mbuf_size=3D[JUMBO_MTU +=
 200]) as testpmd:
>              testpmd.set_port_mtu_all(1500, verify=3DTrue)
>              testpmd.start()
>              self.assess_mtu_boundary(testpmd, 1500)
> @@ -201,7 +197,6 @@ def test_cli_mtu_forwarding_for_std_packets(self) -> =
None:
>              MTU modification.
>          """
>          with TestPmdShell(
> -            self.sut_node,
>              tx_offloads=3D0x8000,
>              mbuf_size=3D[JUMBO_MTU + 200],
>              mbcache=3D200,
> @@ -230,7 +225,6 @@ def test_cli_jumbo_forwarding_for_jumbo_mtu(self) -> =
None:
>              Verify that all packets are forwarded after pre-runtime MTU =
modification.
>          """
>          with TestPmdShell(
> -            self.sut_node,
>              tx_offloads=3D0x8000,
>              mbuf_size=3D[JUMBO_MTU + 200],
>              mbcache=3D200,
> @@ -259,7 +253,6 @@ def test_cli_mtu_std_packets_for_jumbo_mtu(self) -> N=
one:
>              MTU modification.
>          """
>          with TestPmdShell(
> -            self.sut_node,
>              tx_offloads=3D0x8000,
>              mbuf_size=3D[JUMBO_MTU + 200],
>              mbcache=3D200,
> @@ -277,5 +270,5 @@ def tear_down_suite(self) -> None:
>          Teardown:
>              Set the MTU size of the traffic generator back to the standa=
rd 1518 byte size.
>          """
> -        self.tg_node.main_session.configure_port_mtu(STANDARD_MTU, self.=
_tg_port_egress)
> -        self.tg_node.main_session.configure_port_mtu(STANDARD_MTU, self.=
_tg_port_ingress)
> +        self.topology.tg_port_egress.configure_mtu(STANDARD_MTU)
> +        self.topology.tg_port_ingress.configure_mtu(STANDARD_MTU)
> diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSu=
ite_pmd_buffer_scatter.py
> index a8c111eea7..5e23f28bc6 100644
> --- a/dts/tests/TestSuite_pmd_buffer_scatter.py
> +++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
> @@ -58,8 +58,8 @@ def set_up_suite(self) -> None:
>              Increase the MTU of both ports on the traffic generator to 9=
000
>              to support larger packet sizes.
>          """
> -        self.tg_node.main_session.configure_port_mtu(9000, self._tg_port=
_egress)
> -        self.tg_node.main_session.configure_port_mtu(9000, self._tg_port=
_ingress)
> +        self.topology.tg_port_egress.configure_mtu(9000)
> +        self.topology.tg_port_ingress.configure_mtu(9000)
>
>      def scatter_pktgen_send_packet(self, pkt_size: int) -> list[Packet]:
>          """Generate and send a packet to the SUT then capture what is fo=
rwarded back.
> @@ -110,7 +110,6 @@ def pmd_scatter(self, mb_size: int, enable_offload: b=
ool =3D False) -> None:
>              Start testpmd and run functional test with preset `mb_size`.
>          """
>          with TestPmdShell(
> -            self.sut_node,
>              forward_mode=3DSimpleForwardingModes.mac,
>              mbcache=3D200,
>              mbuf_size=3D[mb_size],
> @@ -147,5 +146,5 @@ def tear_down_suite(self) -> None:
>          Teardown:
>              Set the MTU of the tg_node back to a more standard size of 1=
500.
>          """
> -        self.tg_node.main_session.configure_port_mtu(1500, self._tg_port=
_egress)
> -        self.tg_node.main_session.configure_port_mtu(1500, self._tg_port=
_ingress)
> +        self.topology.tg_port_egress.configure_mtu(1500)
> +        self.topology.tg_port_ingress.configure_mtu(1500)
> diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts=
/tests/TestSuite_port_restart_config_persistency.py
> index ad42c6c2e6..42ea221586 100644
> --- a/dts/tests/TestSuite_port_restart_config_persistency.py
> +++ b/dts/tests/TestSuite_port_restart_config_persistency.py
> @@ -61,8 +61,8 @@ def port_configuration_persistence(self) -> None:
>          Verify:
>              The configuration persists after the port is restarted.
>          """
> -        with TestPmdShell(self.sut_node, disable_device_start=3DTrue) as=
 testpmd:
> -            for port_id in range(len(self.sut_node.ports)):
> +        with TestPmdShell(disable_device_start=3DTrue) as testpmd:
> +            for port_id, _ in enumerate(self.topology.sut_ports):
>                  testpmd.set_port_mtu(port_id=3Dport_id, mtu=3DSTANDARD_M=
TU, verify=3DTrue)
>                  self.restart_port_and_verify(port_id, testpmd, "MTU")
>
> @@ -90,8 +90,8 @@ def flow_ctrl_port_configuration_persistence(self) -> N=
one:
>          Verify:
>              The configuration persists after the port is restarted.
>          """
> -        with TestPmdShell(self.sut_node, disable_device_start=3DTrue) as=
 testpmd:
> -            for port_id in range(len(self.sut_node.ports)):
> +        with TestPmdShell(disable_device_start=3DTrue) as testpmd:
> +            for port_id, _ in enumerate(self.topology.sut_ports):
>                  flow_ctrl =3D TestPmdPortFlowCtrl(rx=3DTrue)
>                  testpmd.set_flow_control(port=3Dport_id, flow_ctrl=3Dflo=
w_ctrl)
>                  self.restart_port_and_verify(port_id, testpmd, "flow_ctr=
l")
> diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite=
_promisc_support.py
> index a3ea2461f0..445f6e1d69 100644
> --- a/dts/tests/TestSuite_promisc_support.py
> +++ b/dts/tests/TestSuite_promisc_support.py
> @@ -38,10 +38,8 @@ def test_promisc_packets(self) -> None:
>          """
>          packet =3D [Ether(dst=3Dself.ALTERNATIVE_MAC_ADDRESS) / IP() / R=
aw(load=3Db"\x00" * 64)]
>
> -        with TestPmdShell(
> -            self.sut_node,
> -        ) as testpmd:
> -            for port_id in range(len(self.sut_node.ports)):
> +        with TestPmdShell() as testpmd:
> +            for port_id, _ in enumerate(self.topology.sut_ports):
>                  testpmd.set_promisc(port=3Dport_id, enable=3DTrue, verif=
y=3DTrue)
>              testpmd.start()
>
> @@ -51,7 +49,7 @@ def test_promisc_packets(self) -> None:
>
>              testpmd.stop()
>
> -            for port_id in range(len(self.sut_node.ports)):
> +            for port_id, _ in enumerate(self.topology.sut_ports):
>                  testpmd.set_promisc(port=3Dport_id, enable=3DFalse, veri=
fy=3DTrue)
>              testpmd.start()
>
> diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smo=
ke_tests.py
> index 7ed266dac0..8a5799c684 100644
> --- a/dts/tests/TestSuite_smoke_tests.py
> +++ b/dts/tests/TestSuite_smoke_tests.py
> @@ -46,6 +46,7 @@ def set_up_suite(self) -> None:
>          Setup:
>              Set the build directory path and a list of NICs in the SUT n=
ode.
>          """
> +        self.sut_node =3D self._ctx.sut_node  # FIXME: accessing the con=
text should be forbidden
>          self.dpdk_build_dir_path =3D self.sut_node.remote_dpdk_build_dir
>          self.nics_in_node =3D self.sut_node.config.ports
>
> @@ -104,7 +105,7 @@ def test_devices_listed_in_testpmd(self) -> None:
>          Test:
>              List all devices found in testpmd and verify the configured =
devices are among them.
>          """
> -        with TestPmdShell(self.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              dev_list =3D [str(x) for x in testpmd.get_devices()]
>          for nic in self.nics_in_node:
>              self.verify(
> diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic=
.py
> index 07480db392..370fd6b419 100644
> --- a/dts/tests/TestSuite_softnic.py
> +++ b/dts/tests/TestSuite_softnic.py
> @@ -32,6 +32,7 @@ def set_up_suite(self) -> None:
>          Setup:
>              Generate the random packets that will be sent and create the=
 softnic config files.
>          """
> +        self.sut_node =3D self._ctx.sut_node  # FIXME: accessing the con=
text should be forbidden
>          self.packets =3D generate_random_packets(self.NUMBER_OF_PACKETS_=
TO_SEND, self.PAYLOAD_SIZE)
>          self.cli_file =3D self.prepare_softnic_files()
>
> @@ -105,9 +106,8 @@ def softnic(self) -> None:
>
>          """
>          with TestPmdShell(
> -            self.sut_node,
>              vdevs=3D[VirtualDevice(f"net_softnic0,firmware=3D{self.cli_f=
ile},cpu_id=3D1,conn_port=3D8086")],
> -            eth_peer=3D[EthPeer(1, self.tg_node.ports[1].mac_address)],
> +            eth_peer=3D[EthPeer(1, self.topology.tg_port_ingress.mac_add=
ress)],
>              port_topology=3DNone,
>          ) as shell:
>              shell.start()
> diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt=
.py
> index 0898187675..656a69b0f1 100644
> --- a/dts/tests/TestSuite_uni_pkt.py
> +++ b/dts/tests/TestSuite_uni_pkt.py
> @@ -85,7 +85,7 @@ def test_l2_packet_detect(self) -> None:
>          mac_id =3D "00:00:00:00:00:01"
>          packet_list =3D [Ether(dst=3Dmac_id, type=3D0x88F7) / Raw(), Eth=
er(dst=3Dmac_id) / ARP() / Raw()]
>          flag_list =3D [RtePTypes.L2_ETHER_TIMESYNC, RtePTypes.L2_ETHER_A=
RP]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -118,7 +118,7 @@ def test_l3_l4_packet_detect(self) -> None:
>              RtePTypes.L4_ICMP,
>              RtePTypes.L4_FRAG | RtePTypes.L3_IPV4_EXT_UNKNOWN | RtePType=
s.L2_ETHER,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -147,7 +147,7 @@ def test_ipv6_l4_packet_detect(self) -> None:
>              RtePTypes.L4_TCP,
>              RtePTypes.L3_IPV6_EXT_UNKNOWN,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -182,7 +182,7 @@ def test_l3_tunnel_packet_detect(self) -> None:
>              RtePTypes.TUNNEL_IP | RtePTypes.INNER_L4_ICMP,
>              RtePTypes.TUNNEL_IP | RtePTypes.INNER_L3_IPV6_EXT_UNKNOWN | =
RtePTypes.INNER_L4_FRAG,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -215,7 +215,7 @@ def test_gre_tunnel_packet_detect(self) -> None:
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_SCTP,
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_ICMP,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -250,7 +250,7 @@ def test_nsh_packet_detect(self) -> None:
>              RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV4_EXT_UNKNOWN | Rte=
PTypes.L4_SCTP,
>              RtePTypes.L2_ETHER_NSH | RtePTypes.L3_IPV6_EXT_UNKNOWN | Rte=
PTypes.L4_NONFRAG,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
>
>      @func_test
> @@ -295,6 +295,6 @@ def test_vxlan_tunnel_packet_detect(self) -> None:
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L4_ICMP,
>              RtePTypes.TUNNEL_GRENAT | RtePTypes.INNER_L3_IPV6_EXT_UNKNOW=
N | RtePTypes.INNER_L4_FRAG,
>          ]
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.rx_vxlan(4789, 0, True)
>              self.setup_session(testpmd=3Dtestpmd, expected_flags=3Dflag_=
list, packet_list=3Dpacket_list)
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index c67520baef..d2a9e614d4 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -124,7 +124,7 @@ def test_vlan_receipt_no_stripping(self) -> None:
>          Test:
>              Create an interactive testpmd shell and verify a VLAN packet=
.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.vlan_setup(testpmd=3Dtestpmd, port_id=3D0, filtered_id=
=3D1)
>              testpmd.start()
>              self.send_vlan_packet_and_verify(True, strip=3DFalse, vlan_i=
d=3D1)
> @@ -137,7 +137,7 @@ def test_vlan_receipt_stripping(self) -> None:
>          Test:
>              Create an interactive testpmd shell and verify a VLAN packet=
.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.vlan_setup(testpmd=3Dtestpmd, port_id=3D0, filtered_id=
=3D1)
>              testpmd.set_vlan_strip(port=3D0, enable=3DTrue)
>              testpmd.start()
> @@ -150,7 +150,7 @@ def test_vlan_no_receipt(self) -> None:
>          Test:
>              Create an interactive testpmd shell and verify a VLAN packet=
.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              self.vlan_setup(testpmd=3Dtestpmd, port_id=3D0, filtered_id=
=3D1)
>              testpmd.start()
>              self.send_vlan_packet_and_verify(should_receive=3DFalse, str=
ip=3DFalse, vlan_id=3D2)
> @@ -162,7 +162,7 @@ def test_vlan_header_insertion(self) -> None:
>          Test:
>              Create an interactive testpmd shell and verify a non-VLAN pa=
cket.
>          """
> -        with TestPmdShell(node=3Dself.sut_node) as testpmd:
> +        with TestPmdShell() as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.mac)
>              testpmd.set_promisc(port=3D0, enable=3DFalse)
>              testpmd.stop_all_ports()
> --
> 2.43.0
>
