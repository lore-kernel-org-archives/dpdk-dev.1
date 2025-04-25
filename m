Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63412C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 18:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6524A4025E;
	Fri, 25 Apr 2025 20:50:22 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 983754021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 20:50:21 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b0459668101so172910a12.2
 for <dev@dpdk.org>; Fri, 25 Apr 2025 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745607020; x=1746211820; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=favVmlSpbwi+F0WhJ1pTMR785wz0yIkxrB+oXr+RlLk=;
 b=R/347IEM4PY+Xr71NXR5o1T0lQxjAMQUIa3IKAEa3uuhd/+fkF1ZYX2TUnTF/cyIY8
 +uDhsvykX1S5kswgOvTWt3V52485Hd25y9H3Yp39FM1nni8aGpQhjiZ5krtMFNZz5q+F
 bxai6pjvrh/IyAjh6x9mD1DctVuczo3i2o6ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745607020; x=1746211820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=favVmlSpbwi+F0WhJ1pTMR785wz0yIkxrB+oXr+RlLk=;
 b=CAYT/+JByQvM1p4XCKFGe3N3mRkz2ds+eMHiucKkADekgXTXxPPu80Oo/USHH5LEcW
 Ylc23DFV5gonvhc/F/FTL2NkhSMmaMNfvRjBbdngk2JMfVnIq8YKAqzcYk5xLI3oZBly
 mnFNt5Vu220FTUozmFNrR57bspF/BvsBmxxdWmndMfn4VQLoYqyBjALr76jmvb6l1/+K
 Jb6WZ7dgTIuqEITHcST001Y6rJhwiKOshBv9h6PlpEIPm4BxKXUhfTgFhsXk81qBVJnb
 ODzz51rLgR7zQVNALumcy1nBDMEmuO2GwltEPIB5u06Nv5hum64Pfd8uOpBYmNAtTTQK
 vbYQ==
X-Gm-Message-State: AOJu0Yz1RX2Rn8LEYnsMdCca/iRjr2ptAwPcoqf2gk8Hk6iRXwoZEDbL
 hq7oNCuZva3vNXv/Rsy69O/5IBYgeKxmGOZ3WiqAzqR7SZM3I4yYrcsS3g6OMHia0cK6itOwoiv
 awumTML7+N/MJMcOQDHcNpvnypUlujZnooRXO9g==
X-Gm-Gg: ASbGnctPXRwV4QwRClLmX8RQ64YpPaa+Cf09lF65VA06dLzwvsNuxwxlMReInp1YoiF
 8A4Uz7+rnoJo2igfjAQcH+cZ18DtxfOGQ+GZ2nzo/NKKUWGDQcFnTeKsSB4u66cfqJNGnrD/eUj
 G8I6s6Yk2Rb5NtQm621qlA3At8jjV6P/SCnC+gRxtQqZsPSdsvA1d/tPUm
X-Google-Smtp-Source: AGHT+IHu2iAoQ96haiqbAv9uYRZXO6phggEkwrxHzZxQcQq7ktMtbrRcmL3J9DpYPG4yCKLDK430WPkwA1+gqX2x6AA=
X-Received: by 2002:a05:6a00:e16:b0:730:f1b7:9ba9 with SMTP id
 d2e1a72fcca58-73fd9625c50mr1728418b3a.7.1745607020383; Fri, 25 Apr 2025
 11:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-8-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-8-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 14:50:08 -0400
X-Gm-Features: ATxdqUERU-slaHnk8se0VhWbR8eEq6OV251jXsrm73TXPjHAPxo1xf24RHXOFCw
Message-ID: <CAKXZ7ehaZwJ2QG2QVCcCgBX6J5Vpfe_scp2RwM6YP218LYqidg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] dts: enable shell pooling
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Fri, Mar 14, 2025 at 9:19=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Enable the ShellPool class to be used in the test run, and let
> InteractiveShells register themselves to the pool upon shell startup.
> Moreover, to avoid the ShellPool to call InteractiveShell.close more
> than once if the shell was not unregistered correctly, add a way to
> prevent the method to be called if the shell has already been closed.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  .../remote_session/interactive_shell.py       | 24 ++++++++++++++++++-
>  dts/framework/remote_session/python_shell.py  |  3 ++-
>  dts/framework/remote_session/testpmd_shell.py |  2 ++
>  dts/framework/test_run.py                     |  5 ++++
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/fram=
ework/remote_session/interactive_shell.py
> index d7e566e5c4..ba8489eafa 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -22,12 +22,14 @@
>  """
>
>  from abc import ABC, abstractmethod
> +from collections.abc import Callable
>  from pathlib import PurePath
> -from typing import ClassVar
> +from typing import ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar
>
>  from paramiko import Channel, channel
>  from typing_extensions import Self
>
> +from framework.context import get_ctx
>  from framework.exception import (
>      InteractiveCommandExecutionError,
>      InteractiveSSHSessionDeadError,
> @@ -38,6 +40,23 @@
>  from framework.settings import SETTINGS
>  from framework.testbed_model.node import Node
>
> +P =3D ParamSpec("P")
> +T =3D TypeVar("T", bound=3D"InteractiveShell")
> +R =3D TypeVar("R")
> +InteractiveShellMethod =3D Callable[Concatenate[T, P], R]
> +InteractiveShellDecorator: TypeAlias =3D Callable[[InteractiveShellMetho=
d], InteractiveShellMethod]
> +
> +
> +def only_active(func: InteractiveShellMethod) -> InteractiveShellMethod:
> +    """This decorator will skip running the method if the SSH channel is=
 not active."""
> +
> +    def _wrapper(self: "InteractiveShell", *args: P.args, **kwargs: P.kw=
args) -> R | None:
> +        if self._ssh_channel.active:
> +            return func(self, *args, **kwargs)
> +        return None
> +
> +    return _wrapper
> +
>
>  class InteractiveShell(ABC):
>      """The base class for managing interactive shells.
> @@ -155,6 +174,7 @@ def start_application(self, prompt: str | None =3D No=
ne) -> None:
>              self.is_alive =3D False  # update state on failure to start
>              raise InteractiveCommandExecutionError("Failed to start appl=
ication.")
>          self._ssh_channel.settimeout(self._timeout)
> +        get_ctx().shell_pool.register_shell(self)
>
>      def send_command(
>          self, command: str, prompt: str | None =3D None, skip_first_line=
: bool =3D False
> @@ -219,6 +239,7 @@ def send_command(
>              self._logger.debug(f"Got output: {out}")
>          return out
>
> +    @only_active
>      def close(self) -> None:
>          """Close the shell.
>
> @@ -234,6 +255,7 @@ def close(self) -> None:
>              self._logger.debug("Application failed to exit before set ti=
meout.")
>              raise InteractiveSSHTimeoutError("Application 'exit' command=
") from e
>          self._ssh_channel.close()
> +        get_ctx().shell_pool.unregister_shell(self)
>
>      @property
>      @abstractmethod
> diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework=
/remote_session/python_shell.py
> index 6331d047c4..5b380a5c7a 100644
> --- a/dts/framework/remote_session/python_shell.py
> +++ b/dts/framework/remote_session/python_shell.py
> @@ -15,7 +15,7 @@
>  from pathlib import PurePath
>  from typing import ClassVar
>
> -from .interactive_shell import InteractiveShell
> +from .interactive_shell import InteractiveShell, only_active
>
>
>  class PythonShell(InteractiveShell):
> @@ -32,6 +32,7 @@ def path(self) -> PurePath:
>          """Path to the Python3 executable."""
>          return PurePath("python3")
>
> +    @only_active
>      def close(self):
>          """Close Python shell."""
>          return super().close()
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index 19437b6233..b1939e4a51 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -33,6 +33,7 @@
>  )
>
>  from framework.context import get_ctx
> +from framework.remote_session.interactive_shell import only_active
>  from framework.testbed_model.topology import TopologyType
>
>  if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
> @@ -2314,6 +2315,7 @@ def rx_vxlan(self, vxlan_id: int, port_id: int, ena=
ble: bool, verify: bool =3D Tru
>                  self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output=
}")
>                  raise InteractiveCommandExecutionError(f"Failed to set V=
XLAN:\n{vxlan_output}")
>
> +    @only_active
>      def close(self) -> None:
>          """Overrides :meth:`~.interactive_shell.close`."""
>          self.stop()
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index f9cfe5e908..7708fe31bd 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -430,6 +430,7 @@ def description(self) -> str:
>
>      def next(self) -> State | None:
>          """Next state."""
> +        self.test_run.ctx.shell_pool.terminate_current_pool()
>          self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_port=
s)
>          self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_p=
orts)
>          self.test_run.ctx.tg_node.teardown()
> @@ -473,6 +474,7 @@ def description(self) -> str:
>
>      def next(self) -> State | None:
>          """Next state."""
> +        self.test_run.ctx.shell_pool.start_new_pool()
>          self.test_suite.set_up_suite()
>          self.result.update_setup(Result.PASS)
>          return TestSuiteExecution(self.test_run, self.test_suite, self.r=
esult)
> @@ -544,6 +546,7 @@ def next(self) -> State | None:
>          """Next state."""
>          self.test_suite.tear_down_suite()
>          self.test_run.ctx.dpdk.kill_cleanup_dpdk_apps()
> +        self.test_run.ctx.shell_pool.terminate_current_pool()
>          self.result.update_teardown(Result.PASS)
>          return TestRunExecution(self.test_run, self.test_run.result)
>
> @@ -594,6 +597,7 @@ def description(self) -> str:
>
>      def next(self) -> State | None:
>          """Next state."""
> +        self.test_run.ctx.shell_pool.start_new_pool()
>          self.test_suite.set_up_test_case()
>          self.result.update_setup(Result.PASS)
>          return TestCaseExecution(
> @@ -670,6 +674,7 @@ def description(self) -> str:
>      def next(self) -> State | None:
>          """Next state."""
>          self.test_suite.tear_down_test_case()
> +        self.test_run.ctx.shell_pool.terminate_current_pool()
>          self.result.update_teardown(Result.PASS)
>          return TestSuiteExecution(self.test_run, self.test_suite, self.t=
est_suite_result)
>
> --
> 2.43.0
>
