Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C587CAC581
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 03:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3191F40281;
	Tue,  9 Sep 2025 05:05:15 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9F49140270
 for <dev@dpdk.org>; Tue,  9 Sep 2025 05:05:12 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-77238a3101fso3661519b3a.0
 for <dev@dpdk.org>; Mon, 08 Sep 2025 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757387112; x=1757991912; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PtUTbfjYp0pP7H7ak60HEXsE9nGp2k9Rk+n9Y/Mdl80=;
 b=YLTdF5E8eMVU4Cn7GfW8d4MeJC8MU7zuLzKMTNIj4zqEx8p18EoP9wPy3Cf0bJCQxu
 Yc8dCohfFLRDdV77tqwiaURpYu+EF1HkrVWh21ttqkBFJnZygF1it6J5tREXHiYukZNf
 obkzgwT7sHaXcas6C3ImxNbzYZNAPqGZpJWpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757387112; x=1757991912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtUTbfjYp0pP7H7ak60HEXsE9nGp2k9Rk+n9Y/Mdl80=;
 b=l6xR8lHeSnuTV1nFRHl+oY+JA6QmUDVG9lqWozyL6FARf4NGOV/2iA5rixDCivSGq8
 T3eXROADWmD9vq7cqYR3tMEraKksKKDsu8hdvHpWV5mVg9FMNM4sYsqRYr8+4MSzQKtv
 20C/JE51kuKyNN9+8cSnK9WuhLB8r3qJU7Gro7WEIwaH52w5NCLpTE7RoaYidwWtoRHy
 HyqETKirkjsbBrZpObxRCizJsrS/ic7kiZ4UJvgxjCoD1RqFZJDV3BOILHQHUGIddyRn
 VdYES57Eu+wANJaHQrpVblwQHbOuJ2OAMUpYb/N53mu0JDVAQ0iF/BgeMRnRmuzGM3sj
 MCzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW0mhnyvw/2BqKVp7/mojbgUVfsI+PIJ29duskY2l8O3w+dc341ABk1fQTNVBw0Q00L7Q=@dpdk.org
X-Gm-Message-State: AOJu0YwJGTYE8Aion10TZ/0ff801Fnl4ZihLqGtLxFT7KlHte7EEsWT+
 IiYewK7poSnViKNyJLK07McGikv9gYI1nCndWsZc6B7z3zK/C3xKyjogoKTeddYpbFwfAQeJIE2
 j5CwhxRjkzcJTM1ou0F1b3e30YlmTRC7YiW5o7b1laA==
X-Gm-Gg: ASbGncuGTZp58S+JclYkMXC6DI9rpgmf+Y1vxYB5yYQXANMLJqTbKdIHaad2yZ7Ezsk
 YO2kS/JJL+lIATPJnmpdBRHqMZ+PV1uTkCVzBy7bpitCfxoaWl6lIkJaWjsyPCj3++SKH5vShIH
 lQRFtdN+wNzgTj6H1bMTrCWwtmjSWkG4KihTkiYDP/qa71JMUFcGuSMP1Y6tLUa/fqxSpIT9MH6
 eOkQWPnazf1/mOLsBa806s=
X-Google-Smtp-Source: AGHT+IGxVfA09x8dhbUHWvFt/xhhpu3FPCxhvh0OWwaz3Ph6h5DB1ux3OLoFdDdZj2zICmuznSRjlVQL4Q06sFlv8C0=
X-Received: by 2002:a05:6a20:7f86:b0:249:3006:7580 with SMTP id
 adf61e73a8af0-25340454df6mr14037037637.25.1757387111334; Mon, 08 Sep 2025
 20:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <20250905124058.174777-1-abailey@iol.unh.edu>
 <20250905124058.174777-2-abailey@iol.unh.edu>
In-Reply-To: <20250905124058.174777-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 8 Sep 2025 22:58:18 -0400
X-Gm-Features: Ac12FXzBJjYnxmsb5Eg1I-51E7tu0BGNiTvpIHbCUT1KcCacGZ3lX3k51Q78C4Y
Message-ID: <CAJvnSUBnc6h0iu+=YprhkF4pN=TGJPUnv=THORGbaDpfzu3K-w@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dts: add missing type hints to method signatures
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000811dd2063e559272"
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

--000000000000811dd2063e559272
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v5 pushed to next-dts, thanks.

On Fri, Sep 5, 2025 at 8:41=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

> Mypy does not check functions and methods that are not entirely type
> hinted. This prevents full checks, so they have been added where missing.
> Full checks revealed some typing errors, pattern matching was applied
> where appropriate to ensure these types were handled properly.
> Additionally, the linter raised an error "unable to assign to a method"
> that occurred within a decorator trying to manipulate the str method of
> a given class. This was changed to use the set_attr function to pass the
> linter.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  .mailmap                                      |  1 +
>  dts/framework/context.py                      | 10 +++---
>  dts/framework/exception.py                    |  8 ++---
>  dts/framework/logger.py                       |  6 ++--
>  dts/framework/params/__init__.py              |  8 ++---
>  dts/framework/remote_session/dpdk.py          | 16 ++++-----
>  dts/framework/remote_session/dpdk_shell.py    |  2 +-
>  .../remote_session/interactive_shell.py       |  6 ++--
>  dts/framework/remote_session/python_shell.py  |  2 +-
>  .../remote_session/remote_session.py          |  2 +-
>  dts/framework/remote_session/shell_pool.py    | 10 +++---
>  dts/framework/remote_session/testpmd_shell.py | 14 ++++----
>  dts/framework/runner.py                       |  2 +-
>  dts/framework/settings.py                     | 11 +++---
>  dts/framework/test_result.py                  | 10 +++---
>  dts/framework/test_run.py                     | 36 +++++++++----------
>  dts/framework/test_suite.py                   |  4 +--
>  dts/framework/testbed_model/capability.py     | 10 +++---
>  dts/framework/testbed_model/cpu.py            |  4 +--
>  dts/framework/testbed_model/node.py           |  2 +-
>  dts/framework/testbed_model/os_session.py     |  2 +-
>  dts/framework/testbed_model/port.py           |  4 +--
>  dts/framework/testbed_model/posix_session.py  |  2 +-
>  .../testbed_model/traffic_generator/scapy.py  | 14 ++++----
>  .../traffic_generator/traffic_generator.py    |  7 ++--
>  dts/framework/testbed_model/virtual_device.py |  2 +-
>  dts/framework/utils.py                        |  6 ++--
>  dts/tests/TestSuite_blocklist.py              |  8 ++---
>  dts/tests/TestSuite_dynamic_queue_conf.py     |  8 ++---
>  ...stSuite_port_restart_config_persistency.py |  2 +-
>  30 files changed, 113 insertions(+), 106 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index d4c04f3b81..7be3d8b76a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -104,6 +104,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <
> andremue@microsoft.com>
>  Andrea Arcangeli <aarcange@redhat.com>
>  Andrea Grandi <andrea.grandi@intel.com>
>  Andre Richter <andre.o.richter@gmail.com>
> +Andrew Bailey <abailey@iol.unh.edu>
>  Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
>  Andrew Harvey <agh@cisco.com>
>  Andrew Jackson <ajackson@solarflare.com>
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> index 4360bc8699..f98d31d3c1 100644
> --- a/dts/framework/context.py
> +++ b/dts/framework/context.py
> @@ -4,8 +4,9 @@
>  """Runtime contexts."""
>
>  import functools
> +from collections.abc import Callable
>  from dataclasses import MISSING, dataclass, field, fields
> -from typing import TYPE_CHECKING, ParamSpec
> +from typing import TYPE_CHECKING, Any, ParamSpec
>
>  from framework.exception import InternalError
>  from framework.remote_session.shell_pool import ShellPool
> @@ -16,6 +17,7 @@
>
>  if TYPE_CHECKING:
>      from framework.remote_session.dpdk import DPDKBuildEnvironment,
> DPDKRuntimeEnvironment
> +    from framework.testbed_model.capability import TestProtocol
>      from framework.testbed_model.traffic_generator.traffic_generator
> import TrafficGenerator
>
>  P =3D ParamSpec("P")
> @@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -> None:
>
>  def filter_cores(
>      specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool
> | None =3D None
> -):
> +) -> Callable[[type["TestProtocol"]], Callable]:
>      """Decorates functions that require a temporary update to the lcore
> specifier."""
>
> -    def decorator(func):
> +    def decorator(func: type["TestProtocol"]) -> Callable:
>          @functools.wraps(func)
> -        def wrapper(*args: P.args, **kwargs: P.kwargs):
> +        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Any:
>              local_ctx =3D get_ctx().local
>
>              old_specifier =3D local_ctx.lcore_filter_specifier
> diff --git a/dts/framework/exception.py b/dts/framework/exception.py
> index 47e3fac05c..84d42c7779 100644
> --- a/dts/framework/exception.py
> +++ b/dts/framework/exception.py
> @@ -59,7 +59,7 @@ class SSHConnectionError(DTSError):
>      _host: str
>      _errors: list[str]
>
> -    def __init__(self, host: str, errors: list[str] | None =3D None):
> +    def __init__(self, host: str, errors: list[str] | None =3D None) ->
> None:
>          """Define the meaning of the first two arguments.
>
>          Args:
> @@ -88,7 +88,7 @@ class _SSHTimeoutError(DTSError):
>      severity: ClassVar[ErrorSeverity] =3D ErrorSeverity.SSH_ERR
>      _command: str
>
> -    def __init__(self, command: str):
> +    def __init__(self, command: str) -> None:
>          """Define the meaning of the first argument.
>
>          Args:
> @@ -119,7 +119,7 @@ class _SSHSessionDeadError(DTSError):
>      severity: ClassVar[ErrorSeverity] =3D ErrorSeverity.SSH_ERR
>      _host: str
>
> -    def __init__(self, host: str):
> +    def __init__(self, host: str) -> None:
>          """Define the meaning of the first argument.
>
>          Args:
> @@ -157,7 +157,7 @@ class RemoteCommandExecutionError(DTSError):
>      _command_stderr: str
>      _command_return_code: int
>
> -    def __init__(self, command: str, command_stderr: str,
> command_return_code: int):
> +    def __init__(self, command: str, command_stderr: str,
> command_return_code: int) -> None:
>          """Define the meaning of the first two arguments.
>
>          Args:
> diff --git a/dts/framework/logger.py b/dts/framework/logger.py
> index f43b442bc9..a0c81c3c47 100644
> --- a/dts/framework/logger.py
> +++ b/dts/framework/logger.py
> @@ -15,7 +15,7 @@
>  import logging
>  from logging import FileHandler, StreamHandler
>  from pathlib import Path
> -from typing import ClassVar
> +from typing import Any, ClassVar
>
>  date_fmt =3D "%Y/%m/%d %H:%M:%S"
>  stream_fmt =3D "%(asctime)s - %(stage)s - %(name)s - %(levelname)s -
> %(message)s"
> @@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):
>      _stage: ClassVar[str] =3D "pre_run"
>      _extra_file_handlers: list[FileHandler] =3D []
>
> -    def __init__(self, *args, **kwargs):
> +    def __init__(self, *args: Any, **kwargs: Any) -> None:
>          """Extend the constructor with extra file handlers."""
>          self._extra_file_handlers =3D []
>          super().__init__(*args, **kwargs)
>
> -    def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
> +    def makeRecord(self, *args: Any, **kwargs: Any) -> logging.LogRecord=
:
>          """Generates a record with additional stage information.
>
>          This is the default method for the :class:`~logging.Logger`
> class. We extend it
> diff --git a/dts/framework/params/__init__.py
> b/dts/framework/params/__init__.py
> index 1ae227d7b4..e6a2d3c903 100644
> --- a/dts/framework/params/__init__.py
> +++ b/dts/framework/params/__init__.py
> @@ -25,7 +25,7 @@
>  T =3D TypeVar("T")
>
>  #: Type for a function taking one argument.
> -FnPtr =3D Callable[[Any], Any]
> +FnPtr =3D Callable[[T], T]
>  #: Type for a switch parameter.
>  Switch =3D Literal[True, None]
>  #: Type for a yes/no switch parameter.
> @@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -> FnPtr:
>          FnPtr: A function that calls the given functions from left to
> right.
>      """
>
> -    def reduced_fn(value):
> +    def reduced_fn(value: T) -> T:
>          for fn in funcs:
>              value =3D fn(value)
>          return value
> @@ -75,8 +75,8 @@ class BitMask(enum.Flag):
>          will allow ``BitMask`` to render as a hexadecimal value.
>      """
>
> -    def _class_decorator(original_class):
> -        original_class.__str__ =3D _reduce_functions(funcs)
> +    def _class_decorator(original_class: T) -> T:
> +        setattr(original_class, "__str__", _reduce_functions(funcs))
>          return original_class
>
>      return _class_decorator
> diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> index 606d6e22fe..7b9c0e89cb 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -62,7 +62,7 @@ class DPDKBuildEnvironment:
>
>      compiler_version: str | None
>
> -    def __init__(self, config: DPDKBuildConfiguration, node: Node):
> +    def __init__(self, config: DPDKBuildConfiguration, node: Node) ->
> None:
>          """DPDK build environment class constructor."""
>          self.config =3D config
>          self._node =3D node
> @@ -74,7 +74,7 @@ def __init__(self, config: DPDKBuildConfiguration, node=
:
> Node):
>
>          self.compiler_version =3D None
>
> -    def setup(self):
> +    def setup(self) -> None:
>          """Set up the DPDK build on the target node.
>
>          DPDK setup includes setting all internals needed for the build,
> the copying of DPDK
> @@ -118,7 +118,7 @@ def teardown(self) -> None:
>                  )
>                  self._node.main_session.remove_remote_file(tarball_path)
>
> -    def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
> +    def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath) -> None:
>          """Set the path to the remote DPDK source tree based on the
> provided DPDK location.
>
>          Verify DPDK source tree existence on the SUT node, if exists set=
s
> the
> @@ -205,7 +205,7 @@ def _prepare_and_extract_dpdk_tarball(self,
> remote_tarball_path: PurePath) -> No
>              strip_root_dir=3DTrue,
>          )
>
> -    def _set_remote_dpdk_build_dir(self, build_dir: str):
> +    def _set_remote_dpdk_build_dir(self, build_dir: str) -> None:
>          """Set the `remote_dpdk_build_dir` on the SUT.
>
>          Check existence on the SUT node and sets the
> @@ -277,7 +277,7 @@ def remote_dpdk_tree_path(self) -> PurePath:
>          return self._node.tmp_dir.joinpath(self._remote_tmp_dpdk_tree_di=
r)
>
>      @property
> -    def remote_dpdk_build_dir(self) -> str | PurePath:
> +    def remote_dpdk_build_dir(self) -> PurePath:
>          """The remote DPDK build dir path."""
>          if self._remote_dpdk_build_dir:
>              return self._remote_dpdk_build_dir
> @@ -286,7 +286,7 @@ def remote_dpdk_build_dir(self) -> str | PurePath:
>              "Failed to get remote dpdk build dir because we don't know
> the "
>              "location on the SUT node."
>          )
> -        return ""
> +        return PurePath("")
>
>      @cached_property
>      def dpdk_version(self) -> str | None:
> @@ -323,7 +323,7 @@ def __init__(
>          config: DPDKRuntimeConfiguration,
>          node: Node,
>          build_env: DPDKBuildEnvironment | None =3D None,
> -    ):
> +    ) -> None:
>          """DPDK environment constructor.
>
>          Args:
> @@ -354,7 +354,7 @@ def __init__(
>          self._ports_bound_to_dpdk =3D False
>          self._kill_session =3D None
>
> -    def setup(self):
> +    def setup(self) -> None:
>          """Set up the DPDK runtime on the target node."""
>          if self.build:
>              self.build.setup()
> diff --git a/dts/framework/remote_session/dpdk_shell.py
> b/dts/framework/remote_session/dpdk_shell.py
> index d4aa02f39b..51b97d4ff6 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -78,7 +78,7 @@ def __init__(
>      def path(self) -> PurePath:
>          """Relative path to the shell executable from the build folder."=
""
>
> -    def _make_real_path(self):
> +    def _make_real_path(self) -> PurePath:
>          """Overrides
> :meth:`~.interactive_shell.InteractiveShell._make_real_path`.
>
>          Adds the remote DPDK build directory to the path.
> diff --git a/dts/framework/remote_session/interactive_shell.py
> b/dts/framework/remote_session/interactive_shell.py
> index ba8489eafa..ce93247051 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -24,7 +24,7 @@
>  from abc import ABC, abstractmethod
>  from collections.abc import Callable
>  from pathlib import PurePath
> -from typing import ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar
> +from typing import Any, ClassVar, Concatenate, ParamSpec, TypeAlias,
> TypeVar
>
>  from paramiko import Channel, channel
>  from typing_extensions import Self
> @@ -126,7 +126,7 @@ def __init__(
>          self._privileged =3D privileged
>          self._timeout =3D SETTINGS.timeout
>
> -    def _setup_ssh_channel(self):
> +    def _setup_ssh_channel(self) -> None:
>          self._ssh_channel =3D
> self._node.main_session.interactive_session.session.invoke_shell()
>          self._stdin =3D self._ssh_channel.makefile_stdin("w")
>          self._stdout =3D self._ssh_channel.makefile("r")
> @@ -277,7 +277,7 @@ def __enter__(self) -> Self:
>          self.start_application()
>          return self
>
> -    def __exit__(self, *_) -> None:
> +    def __exit__(self, *_: Any) -> None:
>          """Exit the context block.
>
>          Upon exiting a context block with this class, we want to ensure
> that the instance of the
> diff --git a/dts/framework/remote_session/python_shell.py
> b/dts/framework/remote_session/python_shell.py
> index 5b380a5c7a..5f39a244d6 100644
> --- a/dts/framework/remote_session/python_shell.py
> +++ b/dts/framework/remote_session/python_shell.py
> @@ -33,6 +33,6 @@ def path(self) -> PurePath:
>          return PurePath("python3")
>
>      @only_active
> -    def close(self):
> +    def close(self) -> None:
>          """Close Python shell."""
>          return super().close()
> diff --git a/dts/framework/remote_session/remote_session.py
> b/dts/framework/remote_session/remote_session.py
> index 89d4618c41..f616b92f1c 100644
> --- a/dts/framework/remote_session/remote_session.py
> +++ b/dts/framework/remote_session/remote_session.py
> @@ -99,7 +99,7 @@ def __init__(
>          node_config: NodeConfiguration,
>          session_name: str,
>          logger: DTSLogger,
> -    ):
> +    ) -> None:
>          """Connect to the node during initialization.
>
>          Args:
> diff --git a/dts/framework/remote_session/shell_pool.py
> b/dts/framework/remote_session/shell_pool.py
> index da956950d5..241737eab3 100644
> --- a/dts/framework/remote_session/shell_pool.py
> +++ b/dts/framework/remote_session/shell_pool.py
> @@ -32,7 +32,7 @@ class ShellPool:
>      _logger: DTSLogger
>      _pools: list[set["InteractiveShell"]]
>
> -    def __init__(self):
> +    def __init__(self) -> None:
>          """Shell pool constructor."""
>          self._logger =3D get_dts_logger("shell_pool")
>          self._pools =3D [set()]
> @@ -50,12 +50,12 @@ def _current_pool(self) -> set["InteractiveShell"]:
>          """The pool in use for the current scope."""
>          return self._pools[-1]
>
> -    def register_shell(self, shell: "InteractiveShell"):
> +    def register_shell(self, shell: "InteractiveShell") -> None:
>          """Register a new shell to the current pool."""
>          self._logger.debug(f"Registering shell {shell} to pool level
> {self.pool_level}.")
>          self._current_pool.add(shell)
>
> -    def unregister_shell(self, shell: "InteractiveShell"):
> +    def unregister_shell(self, shell: "InteractiveShell") -> None:
>          """Unregister a shell from any pool."""
>          for level, pool in enumerate(self._pools):
>              try:
> @@ -72,12 +72,12 @@ def unregister_shell(self, shell: "InteractiveShell")=
:
>              except KeyError:
>                  pass
>
> -    def start_new_pool(self):
> +    def start_new_pool(self) -> None:
>          """Start a new shell pool."""
>          self._logger.debug(f"Starting new shell pool and advancing to
> level {self.pool_level+1}.")
>          self._pools.append(set())
>
> -    def terminate_current_pool(self):
> +    def terminate_current_pool(self) -> None:
>          """Terminate all the shells in the current pool, and restore the
> previous pool if any.
>
>          If any failure occurs while closing any shell, this is tolerated
> allowing the termination
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..1df3d5f792 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -64,7 +64,7 @@ class TestPmdDevice:
>
>      pci_address: str
>
> -    def __init__(self, pci_address_line: str):
> +    def __init__(self, pci_address_line: str) -> None:
>          """Initialize the device from the testpmd output line string.
>
>          Args:
> @@ -90,7 +90,7 @@ class VLANOffloadFlag(Flag):
>      QINQ_STRIP =3D auto()
>
>      @classmethod
> -    def from_str_dict(cls, d):
> +    def from_str_dict(cls, d: dict[str, str]) -> Self:
>          """Makes an instance from a dict containing the flag member name=
s
> with an "on" value.
>
>          Args:
> @@ -405,7 +405,7 @@ def make_device_private_info_parser() -> ParserFn:
>              function that parses the device private info from the TestPm=
d
> port info output.
>      """
>
> -    def _validate(info: str):
> +    def _validate(info: str) -> str | None:
>          info =3D info.strip()
>          if info =3D=3D "none" or info.startswith("Invalid file") or
> info.startswith("Failed to dump"):
>              return None
> @@ -1449,7 +1449,7 @@ def requires_stopped_ports(func: TestPmdShellMethod=
)
> -> TestPmdShellMethod:
>      """
>
>      @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
)
> -> Any:
>          if self.ports_started:
>              self._logger.debug("Ports need to be stopped to continue.")
>              self.stop_all_ports()
> @@ -1470,7 +1470,7 @@ def requires_started_ports(func: TestPmdShellMethod=
)
> -> TestPmdShellMethod:
>      """
>
>      @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs=
)
> -> Any:
>          if not self.ports_started:
>              self._logger.debug("Ports need to be started to continue.")
>              self.start_all_ports()
> @@ -1492,7 +1492,7 @@ def add_remove_mtu(mtu: int =3D 1500) ->
> Callable[[TestPmdShellMethod], TestPmdShe
>
>      def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
>          @functools.wraps(func)
> -        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs):
> +        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs) -> Any:
>              original_mtu =3D self.ports[0].mtu
>              self.set_port_mtu_all(mtu=3Dmtu, verify=3DFalse)
>              retval =3D func(self, *args, **kwargs)
> @@ -1644,7 +1644,7 @@ def wait_link_status_up(self, port_id: int,
> timeout=3DSETTINGS.timeout) -> bool:
>              self._logger.error(f"The link for port {port_id} did not com=
e
> up in the given timeout.")
>          return "Link status: up" in port_info
>
> -    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool
> =3D True):
> +    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool
> =3D True) -> None:
>          """Set packet forwarding mode.
>
>          Args:
> diff --git a/dts/framework/runner.py b/dts/framework/runner.py
> index 0a3d92b0c8..4f2c05bd2f 100644
> --- a/dts/framework/runner.py
> +++ b/dts/framework/runner.py
> @@ -31,7 +31,7 @@ class DTSRunner:
>      _logger: DTSLogger
>      _result: TestRunResult
>
> -    def __init__(self):
> +    def __init__(self) -> None:
>          """Initialize the instance with configuration, logger, result an=
d
> string constants."""
>          try:
>              self._configuration =3D
> load_config(ValidationContext(settings=3DSETTINGS))
> diff --git a/dts/framework/settings.py b/dts/framework/settings.py
> index 3f21615223..84b627a06a 100644
> --- a/dts/framework/settings.py
> +++ b/dts/framework/settings.py
> @@ -108,7 +108,7 @@
>  from argparse import Action, ArgumentDefaultsHelpFormatter,
> _get_action_name
>  from dataclasses import dataclass, field
>  from pathlib import Path
> -from typing import Callable
> +from typing import Callable, NoReturn
>
>  from pydantic import ValidationError
>
> @@ -174,7 +174,7 @@ def _make_env_var_name(action: Action, env_var_name:
> str | None) -> str:
>      return env_var_name
>
>
> -def _get_env_var_name(action: Action) -> str | None:
> +def _get_env_var_name(action: Action | None) -> str | None:
>      """Get the environment variable name of the given action."""
>      return getattr(action, _ENV_VAR_NAME_ATTR, None)
>
> @@ -237,12 +237,15 @@ def find_action(
>
>          return action
>
> -    def error(self, message):
> +    def error(self, message) -> NoReturn:
>          """Augments :meth:`~argparse.ArgumentParser.error` with
> environment variable awareness."""
>          for action in self._actions:
>              if _is_from_env(action):
>                  action_name =3D _get_action_name(action)
>                  env_var_name =3D _get_env_var_name(action)
> +                assert (
> +                    env_var_name is not None
> +                ), "Action was set from environment, but no environment
> variable name was found."
>                  env_var_value =3D os.environ.get(env_var_name)
>
>                  message =3D message.replace(
> @@ -257,7 +260,7 @@ def error(self, message):
>  class _EnvVarHelpFormatter(ArgumentDefaultsHelpFormatter):
>      """Custom formatter to add environment variables to the help page.""=
"
>
> -    def _get_help_string(self, action):
> +    def _get_help_string(self, action: Action) -> str | None:
>          """Overrides
> :meth:`ArgumentDefaultsHelpFormatter._get_help_string`."""
>          help =3D super()._get_help_string(action)
>
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index 8ce6cc8fbf..c6bddc55a9 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -77,13 +77,13 @@ class ResultLeaf(BaseModel):
>      result: Result
>      reason: DTSError | None =3D None
>
> -    def __lt__(self, other):
> +    def __lt__(self, other: object) -> bool:
>          """Compare another instance of the same class by
> :attr:`~ResultLeaf.result`."""
>          if isinstance(other, ResultLeaf):
>              return self.result < other.result
>          return True
>
> -    def __eq__(self, other):
> +    def __eq__(self, other: object) -> bool:
>          """Compare equality with compatible classes by
> :attr:`~ResultLeaf.result`."""
>          match other:
>              case ResultLeaf(result=3Dresult):
> @@ -128,7 +128,7 @@ def add_child(self, label: str) -> "ResultNode":
>          self.children.append(child)
>          return child
>
> -    def mark_result_as(self, result: Result, ex: Exception | None =3D No=
ne)
> -> None:
> +    def mark_result_as(self, result: Result, ex: BaseException | None =
=3D
> None) -> None:
>          """Mark result for the current step.
>
>          Args:
> @@ -149,7 +149,7 @@ def mark_result_as(self, result: Result, ex: Exceptio=
n
> | None =3D None) -> None:
>              self.children.append(ResultLeaf(result=3Dresult, reason=3Dre=
ason))
>
>      def mark_step_as(
> -        self, step: ExecutionStep, result: Result, ex: Exception | None =
=3D
> None
> +        self, step: ExecutionStep, result: Result, ex: BaseException |
> None =3D None
>      ) -> None:
>          """Mark an execution step with the given result.
>
> @@ -264,7 +264,7 @@ def serialize_errors(self, execution_errors:
> list[DTSError]) -> list[str]:
>          """Serialize errors as plain text."""
>          return [str(err) for err in execution_errors]
>
> -    def add_error(self, ex: Exception) -> None:
> +    def add_error(self, ex: BaseException) -> None:
>          """Add an execution error to the test run result."""
>          if isinstance(ex, DTSError):
>              self.execution_errors.append(ex)
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 4355aeeb4b..ca9066299e 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -162,7 +162,7 @@ class TestRun:
>      config: TestRunConfiguration
>      logger: DTSLogger
>
> -    state: "State"
> +    state: Union["State", None]
>      ctx: Context
>      result: TestRunResult
>      selected_tests: list[TestScenario]
> @@ -178,7 +178,7 @@ def __init__(
>          tests_config: dict[str, BaseConfig],
>          nodes: Iterable[Node],
>          result: TestRunResult,
> -    ):
> +    ) -> None:
>          """Test run constructor.
>
>          Args:
> @@ -226,7 +226,7 @@ def required_capabilities(self) -> set[Capability]:
>
>          return caps
>
> -    def spin(self):
> +    def spin(self) -> None:
>          """Spin the internal state machine that executes the test run.""=
"
>          self.logger.info(f"Running test run with SUT '{
> self.ctx.sut_node.name}'.")
>
> @@ -258,11 +258,11 @@ class State(Protocol):
>      test_run: TestRun
>      result: TestRunResult | ResultNode
>
> -    def before(self):
> +    def before(self) -> None:
>          """Hook before the state is processed."""
>          self.logger.set_stage(self.logger_name, self.log_file_path)
>
> -    def after(self):
> +    def after(self) -> None:
>          """Hook after the state is processed."""
>          return
>
> @@ -289,12 +289,12 @@ def log_file_path(self) -> Path | None:
>      def next(self) -> Union["State", None]:
>          """Next state."""
>
> -    def on_error(self, ex: Exception) -> Union["State", None]:
> +    def on_error(self, ex: BaseException) -> Union["State", None]:
>          """Next state on error."""
>
> -    def handle_exception(self, ex: Exception) -> Union["State", None]:
> +    def handle_exception(self, ex: BaseException) -> Union["State", None=
]:
>          """Handles an exception raised by `next`."""
> -        next_state =3D self.on_error(ex)
> +        next_state =3D self.on_error(Exception(ex))
>
>          match ex:
>              case InternalError():
> @@ -362,7 +362,7 @@ def next(self) -> State | None:
>          )
>          return TestRunExecution(test_run, self.result)
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.test_run.result.add_error(ex)
>          return TestRunTeardown(self.test_run, self.result)
> @@ -411,7 +411,7 @@ def next(self) -> State | None:
>              # No more test suites. We are done here.
>              return TestRunTeardown(test_run, self.result)
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.test_run.result.add_error(ex)
>          return TestRunTeardown(self.test_run, self.result)
> @@ -443,7 +443,7 @@ def next(self) -> State | None:
>          self.test_run.ctx.sut_node.teardown()
>          return None
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.test_run.result.add_error(ex)
>          self.logger.warning(
> @@ -491,7 +491,7 @@ def next(self) -> State | None:
>              result=3Dself.result,
>          )
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.result.mark_step_as("setup", Result.ERROR, ex)
>          return TestSuiteTeardown(self.test_run, self.test_suite,
> self.result)
> @@ -543,7 +543,7 @@ def next(self) -> State | None:
>                  # No more test cases. We are done here.
>                  return TestSuiteTeardown(self.test_run, self.test_suite,
> self.result)
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.test_run.result.add_error(ex)
>          return TestSuiteTeardown(self.test_run, self.test_suite,
> self.result)
> @@ -568,7 +568,7 @@ def next(self) -> State | None:
>          self.result.mark_step_as("teardown", Result.PASS)
>          return TestRunExecution(self.test_run, self.test_run.result)
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.logger.warning(
>              "The environment may have not been cleaned up correctly. "
> @@ -577,7 +577,7 @@ def on_error(self, ex: Exception) -> State | None:
>          self.result.mark_step_as("teardown", Result.ERROR, ex)
>          return TestRunExecution(self.test_run, self.test_run.result)
>
> -    def after(self):
> +    def after(self) -> None:
>          """Hook after state is processed."""
>          if (
>              self.result.get_overall_result() in [Result.FAIL,
> Result.ERROR]
> @@ -633,7 +633,7 @@ def next(self) -> State | None:
>              SETTINGS.re_run,
>          )
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.result.mark_step_as("setup", Result.ERROR, ex)
>          self.result.mark_result_as(Result.BLOCK)
> @@ -686,7 +686,7 @@ def next(self) -> State | None:
>              self.result,
>          )
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.result.mark_result_as(Result.ERROR, ex)
>          return TestCaseTeardown(
> @@ -720,7 +720,7 @@ def next(self) -> State | None:
>              result=3Dself.result.parent,
>          )
>
> -    def on_error(self, ex: Exception) -> State | None:
> +    def on_error(self, ex: BaseException) -> State | None:
>          """Next state on error."""
>          self.logger.warning(
>              "The environment may have not been cleaned up correctly. "
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index d4e06a567a..5ee5a039d7 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -92,7 +92,7 @@ class TestSuite(TestProtocol):
>      _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
>
> -    def __init__(self, config: BaseConfig):
> +    def __init__(self, config: BaseConfig) -> None:
>          """Initialize the test suite testbed information and basic
> configuration.
>
>          Args:
> @@ -681,7 +681,7 @@ def class_obj(self) -> type[TestSuite]:
>              InternalError: If the test suite class is missing from the
> module.
>          """
>
> -        def is_test_suite(obj) -> bool:
> +        def is_test_suite(obj: type) -> bool:
>              """Check whether `obj` is a :class:`TestSuite`.
>
>              The `obj` is a subclass of :class:`TestSuite`, but not
> :class:`TestSuite` itself.
> diff --git a/dts/framework/testbed_model/capability.py
> b/dts/framework/testbed_model/capability.py
> index f895b22bb3..87be7e6b93 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py
> @@ -50,7 +50,7 @@ def test_scatter_mbuf_2048(self):
>  from abc import ABC, abstractmethod
>  from collections.abc import MutableSet
>  from dataclasses import dataclass
> -from typing import TYPE_CHECKING, Callable, ClassVar, Protocol
> +from typing import TYPE_CHECKING, Any, Callable, ClassVar, Protocol
>
>  from typing_extensions import Self
>
> @@ -374,7 +374,7 @@ def set_required(self, test_case_or_suite:
> type["TestProtocol"]) -> None:
>          else:
>              self.add_to_required(test_case_or_suite)
>
> -    def __eq__(self, other) -> bool:
> +    def __eq__(self, other: Any) -> bool:
>          """Compare the :attr:`~TopologyCapability.topology_type`s.
>
>          Args:
> @@ -385,7 +385,7 @@ def __eq__(self, other) -> bool:
>          """
>          return self.topology_type =3D=3D other.topology_type
>
> -    def __lt__(self, other) -> bool:
> +    def __lt__(self, other: Any) -> bool:
>          """Compare the :attr:`~TopologyCapability.topology_type`s.
>
>          Args:
> @@ -396,7 +396,7 @@ def __lt__(self, other) -> bool:
>          """
>          return self.topology_type < other.topology_type
>
> -    def __gt__(self, other) -> bool:
> +    def __gt__(self, other: Any) -> bool:
>          """Compare the :attr:`~TopologyCapability.topology_type`s.
>
>          Args:
> @@ -407,7 +407,7 @@ def __gt__(self, other) -> bool:
>          """
>          return other < self
>
> -    def __le__(self, other) -> bool:
> +    def __le__(self, other: Any) -> bool:
>          """Compare the :attr:`~TopologyCapability.topology_type`s.
>
>          Args:
> diff --git a/dts/framework/testbed_model/cpu.py
> b/dts/framework/testbed_model/cpu.py
> index b8bc601c22..6e2ecca080 100644
> --- a/dts/framework/testbed_model/cpu.py
> +++ b/dts/framework/testbed_model/cpu.py
> @@ -80,7 +80,7 @@ class LogicalCoreList:
>      _lcore_list: list[int]
>      _lcore_str: str
>
> -    def __init__(self, lcore_list: list[int] | list[str] |
> list[LogicalCore] | str):
> +    def __init__(self, lcore_list: list[int] | list[str] |
> list[LogicalCore] | str) -> None:
>          """Process `lcore_list`, then sort.
>
>          There are four supported logical core list formats::
> @@ -169,7 +169,7 @@ def __init__(
>          lcore_list: list[LogicalCore],
>          filter_specifier: LogicalCoreCount | LogicalCoreList,
>          ascending: bool =3D True,
> -    ):
> +    ) -> None:
>          """Filter according to the input filter specifier.
>
>          The input `lcore_list` is copied and sorted by physical core
> before filtering.
> diff --git a/dts/framework/testbed_model/node.py
> b/dts/framework/testbed_model/node.py
> index 35cf6f1452..4f6150f18c 100644
> --- a/dts/framework/testbed_model/node.py
> +++ b/dts/framework/testbed_model/node.py
> @@ -59,7 +59,7 @@ class Node:
>      _compiler_version: str | None
>      _setup: bool
>
> -    def __init__(self, node_config: NodeConfiguration):
> +    def __init__(self, node_config: NodeConfiguration) -> None:
>          """Connect to the node and gather info during initialization.
>
>          Extra gathered information:
> diff --git a/dts/framework/testbed_model/os_session.py
> b/dts/framework/testbed_model/os_session.py
> index b6e03aa83d..b182c3bde4 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -115,7 +115,7 @@ def __init__(
>          node_config: NodeConfiguration,
>          name: str,
>          logger: DTSLogger,
> -    ):
> +    ) -> None:
>          """Initialize the OS-aware session.
>
>          Connect to the node right away and also create an interactive
> remote session.
> diff --git a/dts/framework/testbed_model/port.py
> b/dts/framework/testbed_model/port.py
> index fc58e2b993..2c0276971f 100644
> --- a/dts/framework/testbed_model/port.py
> +++ b/dts/framework/testbed_model/port.py
> @@ -49,7 +49,7 @@ class Port:
>      config: Final[PortConfig]
>      _original_driver: str | None
>
> -    def __init__(self, node: "Node", config: PortConfig):
> +    def __init__(self, node: "Node", config: PortConfig) -> None:
>          """Initialize the port from `node` and `config`.
>
>          Args:
> @@ -128,7 +128,7 @@ def bound_for_dpdk(self) -> bool:
>          """Is the port bound to the driver for DPDK?"""
>          return self.current_driver =3D=3D self.config.os_driver_for_dpdk
>
> -    def configure_mtu(self, mtu: int):
> +    def configure_mtu(self, mtu: int) -> None:
>          """Configure the port's MTU value.
>
>          Args:
> diff --git a/dts/framework/testbed_model/posix_session.py
> b/dts/framework/testbed_model/posix_session.py
> index c71bc93f0b..dec952685a 100644
> --- a/dts/framework/testbed_model/posix_session.py
> +++ b/dts/framework/testbed_model/posix_session.py
> @@ -183,7 +183,7 @@ def create_remote_tarball(
>      ) -> PurePosixPath:
>          """Overrides
> :meth:`~.os_session.OSSession.create_remote_tarball`."""
>
> -        def generate_tar_exclude_args(exclude_patterns) -> str:
> +        def generate_tar_exclude_args(exclude_patterns: str | list[str] =
|
> None) -> str:
>              """Generate args to exclude patterns when creating a tarball=
.
>
>              Args:
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py
> b/dts/framework/testbed_model/traffic_generator/scapy.py
> index e21ba4ed96..a31807e8e4 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -16,7 +16,7 @@
>  from collections.abc import Callable
>  from queue import Empty, SimpleQueue
>  from threading import Event, Thread
> -from typing import ClassVar
> +from typing import Any, ClassVar
>
>  from scapy.compat import base64_bytes
>  from scapy.data import ETHER_TYPES, IP_PROTOS
> @@ -57,7 +57,7 @@ class ScapyAsyncSniffer(PythonShell):
>
>      def __init__(
>          self, node: Node, recv_port: Port, name: str | None =3D None,
> privileged: bool =3D True
> -    ):
> +    ) -> None:
>          """Sniffer constructor.
>
>          Args:
> @@ -189,7 +189,7 @@ def close(self) -> None:
>          self._sniffer.join()
>          super().close()
>
> -    def _sniff(self, recv_port: Port):
> +    def _sniff(self, recv_port: Port) -> None:
>          """Sniff packets and use events and queue to communicate with th=
e
> main thread.
>
>          Raises:
> @@ -229,7 +229,7 @@ def _sniff(self, recv_port: Port):
>          self._logger.debug("Stop sniffing.")
>          self.send_command("\x03")  # send Ctrl+C to trigger a
> KeyboardInterrupt in `sniff`.
>
> -    def _set_packet_filter(self, filter_config: PacketFilteringConfig):
> +    def _set_packet_filter(self, filter_config: PacketFilteringConfig) -=
>
> None:
>          """Make and set a filtering function from `filter_config`.
>
>          Args:
> @@ -296,7 +296,7 @@ class also extends
> :class:`.capturing_traffic_generator.CapturingTrafficGenerato
>      #: Padding to add to the start of a line for python syntax complianc=
e.
>      _python_indentation: ClassVar[str] =3D " " * 4
>
> -    def __init__(self, tg_node: Node, config:
> ScapyTrafficGeneratorConfig, **kwargs):
> +    def __init__(self, tg_node: Node, config:
> ScapyTrafficGeneratorConfig, **kwargs: Any) -> None:
>          """Extend the constructor with Scapy TG specifics.
>
>          Initializes both the traffic generator and the interactive shell
> used to handle Scapy
> @@ -315,7 +315,7 @@ def __init__(self, tg_node: Node, config:
> ScapyTrafficGeneratorConfig, **kwargs)
>
>          super().__init__(tg_node=3Dtg_node, config=3Dconfig, **kwargs)
>
> -    def setup(self, topology: Topology):
> +    def setup(self, topology: Topology) -> None:
>          """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
>
>          Binds the TG node ports to the kernel drivers and starts up the
> async sniffer.
> @@ -332,7 +332,7 @@ def setup(self, topology: Topology):
>          self._shell.send_command("from scapy.all import *")
>          self._shell.send_command("from scapy.contrib.lldp import *")
>
> -    def close(self):
> +    def close(self) -> None:
>          """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
>
>          Stops the traffic generator and sniffer shells.
> diff --git
> a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index 8f53b07daf..cac119c183 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -9,6 +9,7 @@
>  """
>
>  from abc import ABC, abstractmethod
> +from typing import Any
>
>  from scapy.packet import Packet
>
> @@ -34,7 +35,7 @@ class TrafficGenerator(ABC):
>      _tg_node: Node
>      _logger: DTSLogger
>
> -    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig,
> **kwargs):
> +    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig,
> **kwargs: Any) -> None:
>          """Initialize the traffic generator.
>
>          Additional keyword arguments can be passed through `kwargs` if
> needed for fulfilling other
> @@ -49,10 +50,10 @@ def __init__(self, tg_node: Node, config:
> TrafficGeneratorConfig, **kwargs):
>          self._tg_node =3D tg_node
>          self._logger =3D get_dts_logger(f"{self._tg_node.name}
> {self._config.type}")
>
> -    def setup(self, topology: Topology):
> +    def setup(self, topology: Topology) -> None:
>          """Setup the traffic generator."""
>
> -    def teardown(self):
> +    def teardown(self) -> None:
>          """Teardown the traffic generator."""
>          self.close()
>
> diff --git a/dts/framework/testbed_model/virtual_device.py
> b/dts/framework/testbed_model/virtual_device.py
> index 569d67b007..1a4794e695 100644
> --- a/dts/framework/testbed_model/virtual_device.py
> +++ b/dts/framework/testbed_model/virtual_device.py
> @@ -16,7 +16,7 @@ class VirtualDevice:
>
>      name: str
>
> -    def __init__(self, name: str):
> +    def __init__(self, name: str) -> None:
>          """Initialize the virtual device.
>
>          Args:
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index 0c81ab1b95..a70c9c7d95 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -147,14 +147,14 @@ class TarCompressionFormat(StrEnum):
>      zstd =3D "zst"
>
>      @property
> -    def extension(self):
> +    def extension(self) -> str:
>          """Return the extension associated with the compression format.
>
>          If the compression format is 'none', the extension will be in th=
e
> format 'tar'.
>          For other compression formats, the extension will be in the form=
at
>          'tar.{compression format}'.
>          """
> -        return f"{self.value}" if self =3D=3D self.none else
> f"{self.none.value}.{self.value}"
> +        return f"{self.value}" if self =3D=3D self.none else
> f"{type(self).none.value}.{self.value}"
>
>
>  def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
> @@ -213,7 +213,7 @@ def filter_func(tarinfo: tarfile.TarInfo) ->
> tarfile.TarInfo | None:
>      return target_tarball_path
>
>
> -def extract_tarball(tar_path: str | Path):
> +def extract_tarball(tar_path: str | Path) -> None:
>      """Extract the contents of a tarball.
>
>      The tarball will be extracted in the same path as `tar_path` parent
> path.
> diff --git a/dts/tests/TestSuite_blocklist.py
> b/dts/tests/TestSuite_blocklist.py
> index ce7da1cc8f..c668bcd86c 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -16,7 +16,7 @@
>  class TestBlocklist(TestSuite):
>      """DPDK device blocklisting test suite."""
>
> -    def verify_blocklisted_ports(self, ports_to_block: list[Port]):
> +    def verify_blocklisted_ports(self, ports_to_block: list[Port]) ->
> None:
>          """Runs testpmd with the given ports blocklisted and verifies th=
e
> ports."""
>          with TestPmdShell(allowed_ports=3D[], blocked_ports=3Dports_to_b=
lock)
> as testpmd:
>              allowlisted_ports =3D {port.device_name for port in
> testpmd.show_port_info_all()}
> @@ -30,7 +30,7 @@ def verify_blocklisted_ports(self, ports_to_block:
> list[Port]):
>              self.verify(blocked, "At least one port was not blocklisted"=
)
>
>      @func_test
> -    def no_blocklisted(self):
> +    def no_blocklisted(self) -> None:
>          """Run testpmd with no blocklisted device.
>
>          Steps:
> @@ -41,7 +41,7 @@ def no_blocklisted(self):
>          self.verify_blocklisted_ports([])
>
>      @func_test
> -    def one_port_blocklisted(self):
> +    def one_port_blocklisted(self) -> None:
>          """Run testpmd with one blocklisted port.
>
>          Steps:
> @@ -52,7 +52,7 @@ def one_port_blocklisted(self):
>          self.verify_blocklisted_ports(self.topology.sut_ports[:1])
>
>      @func_test
> -    def all_but_one_port_blocklisted(self):
> +    def all_but_one_port_blocklisted(self) -> None:
>          """Run testpmd with all but one blocklisted port.
>
>          Steps:
> diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py
> b/dts/tests/TestSuite_dynamic_queue_conf.py
> index 0e9cda1b9f..3e2f9d816f 100644
> --- a/dts/tests/TestSuite_dynamic_queue_conf.py
> +++ b/dts/tests/TestSuite_dynamic_queue_conf.py
> @@ -277,24 +277,24 @@ def stop_queues(
>
>      @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
>      @func_test
> -    def rx_queue_stop(self):
> +    def rx_queue_stop(self) -> None:
>          """Run method for stopping queues with flag for Rx testing set t=
o
> :data:`True`."""
>          self.stop_queues(True)
>
>      @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
>      @func_test
> -    def rx_queue_configuration(self):
> +    def rx_queue_configuration(self) -> None:
>          """Run method for configuring queues with flag for Rx testing se=
t
> to :data:`True`."""
>          self.modify_ring_size(True)
>
>      @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
>      @func_test
> -    def tx_queue_stop(self):
> +    def tx_queue_stop(self) -> None:
>          """Run method for stopping queues with flag for Rx testing set t=
o
> :data:`False`."""
>          self.stop_queues(False)
>
>      @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
>      @func_test
> -    def tx_queue_configuration(self):
> +    def tx_queue_configuration(self) -> None:
>          """Run method for configuring queues with flag for Rx testing se=
t
> to :data:`False`."""
>          self.modify_ring_size(False)
> diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py
> b/dts/tests/TestSuite_port_restart_config_persistency.py
> index 42ea221586..b773bdfade 100644
> --- a/dts/tests/TestSuite_port_restart_config_persistency.py
> +++ b/dts/tests/TestSuite_port_restart_config_persistency.py
> @@ -21,7 +21,7 @@
>  class TestPortRestartConfigPersistency(TestSuite):
>      """Port config persistency test suite."""
>
> -    def restart_port_and_verify(self, id, testpmd, changed_value) -> Non=
e:
> +    def restart_port_and_verify(self, id: int, testpmd: TestPmdShell,
> changed_value: str) -> None:
>          """Fetch port config, restart and verify persistency."""
>          testpmd.start_all_ports()
>          testpmd.wait_link_status_up(port_id=3Did, timeout=3D10)
> --
> 2.50.1
>
>

--000000000000811dd2063e559272
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">v5 pushed to next-dts, thanks.</div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Sep 5, 2025 at 8:41=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abaile=
y@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Mypy does not check functions and methods=
 that are not entirely type<br>
hinted. This prevents full checks, so they have been added where missing.<b=
r>
Full checks revealed some typing errors, pattern matching was applied<br>
where appropriate to ensure these types were handled properly.<br>
Additionally, the linter raised an error &quot;unable to assign to a method=
&quot;<br>
that occurred within a decorator trying to manipulate the str method of<br>
a given class. This was changed to use the set_attr function to pass the<br=
>
linter.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0dts/framework/context.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +++---<br>
=C2=A0dts/framework/exception.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++---<br>
=C2=A0dts/framework/logger.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++--<br>
=C2=A0dts/framework/params/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 8 ++---<br>
=C2=A0dts/framework/remote_session/dpdk.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 16 ++++-----<br>
=C2=A0dts/framework/remote_session/dpdk_shell.py=C2=A0 =C2=A0 |=C2=A0 2 +-<=
br>
=C2=A0.../remote_session/interactive_shell.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 6 ++--<br>
=C2=A0dts/framework/remote_session/python_shell.py=C2=A0 |=C2=A0 2 +-<br>
=C2=A0.../remote_session/remote_session.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0dts/framework/remote_session/shell_pool.py=C2=A0 =C2=A0 | 10 +++---<b=
r>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 14 ++++----<br>
=C2=A0dts/framework/runner.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0dts/framework/settings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++---<br>
=C2=A0dts/framework/test_result.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 10 +++---<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 36 +++++++++----------<br>
=C2=A0dts/framework/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
=C2=A0dts/framework/testbed_model/capability.py=C2=A0 =C2=A0 =C2=A0| 10 +++=
---<br>
=C2=A0dts/framework/testbed_model/cpu.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 +--<br>
=C2=A0dts/framework/testbed_model/node.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +-<br>
=C2=A0dts/framework/testbed_model/os_session.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
=C2=A0dts/framework/testbed_model/port.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 4 +--<br>
=C2=A0dts/framework/testbed_model/posix_session.py=C2=A0 |=C2=A0 2 +-<br>
=C2=A0.../testbed_model/traffic_generator/scapy.py=C2=A0 | 14 ++++----<br>
=C2=A0.../traffic_generator/traffic_generator.py=C2=A0 =C2=A0 |=C2=A0 7 ++-=
-<br>
=C2=A0dts/framework/testbed_model/virtual_device.py |=C2=A0 2 +-<br>
=C2=A0dts/framework/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++--<br>
=C2=A0dts/tests/TestSuite_blocklist.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 8 ++---<br>
=C2=A0dts/tests/TestSuite_dynamic_queue_conf.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
8 ++---<br>
=C2=A0...stSuite_port_restart_config_persistency.py |=C2=A0 2 +-<br>
=C2=A030 files changed, 113 insertions(+), 106 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index d4c04f3b81..7be3d8b76a 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -104,6 +104,7 @@ Andre Muezerie &lt;<a href=3D"mailto:andremue@linux.mic=
rosoft.com" target=3D"_blank">andremue@linux.microsoft.com</a>&gt; &lt;<a h=
ref=3D"mailto:andremue@microsoft.com" target=3D"_blank">andremue@microsoft.=
com</a>&gt;<br>
=C2=A0Andrea Arcangeli &lt;<a href=3D"mailto:aarcange@redhat.com" target=3D=
"_blank">aarcange@redhat.com</a>&gt;<br>
=C2=A0Andrea Grandi &lt;<a href=3D"mailto:andrea.grandi@intel.com" target=
=3D"_blank">andrea.grandi@intel.com</a>&gt;<br>
=C2=A0Andre Richter &lt;<a href=3D"mailto:andre.o.richter@gmail.com" target=
=3D"_blank">andre.o.richter@gmail.com</a>&gt;<br>
+Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" target=3D"_blank"=
>abailey@iol.unh.edu</a>&gt;<br>
=C2=A0Andrew Boyer &lt;<a href=3D"mailto:andrew.boyer@amd.com" target=3D"_b=
lank">andrew.boyer@amd.com</a>&gt; &lt;<a href=3D"mailto:aboyer@pensando.io=
" target=3D"_blank">aboyer@pensando.io</a>&gt;<br>
=C2=A0Andrew Harvey &lt;<a href=3D"mailto:agh@cisco.com" target=3D"_blank">=
agh@cisco.com</a>&gt;<br>
=C2=A0Andrew Jackson &lt;<a href=3D"mailto:ajackson@solarflare.com" target=
=3D"_blank">ajackson@solarflare.com</a>&gt;<br>
diff --git a/dts/framework/context.py b/dts/framework/context.py<br>
index 4360bc8699..f98d31d3c1 100644<br>
--- a/dts/framework/context.py<br>
+++ b/dts/framework/context.py<br>
@@ -4,8 +4,9 @@<br>
=C2=A0&quot;&quot;&quot;Runtime contexts.&quot;&quot;&quot;<br>
<br>
=C2=A0import functools<br>
+from collections.abc import Callable<br>
=C2=A0from dataclasses import MISSING, dataclass, field, fields<br>
-from typing import TYPE_CHECKING, ParamSpec<br>
+from typing import TYPE_CHECKING, Any, ParamSpec<br>
<br>
=C2=A0from framework.exception import InternalError<br>
=C2=A0from framework.remote_session.shell_pool import ShellPool<br>
@@ -16,6 +17,7 @@<br>
<br>
=C2=A0if TYPE_CHECKING:<br>
=C2=A0 =C2=A0 =C2=A0from framework.remote_session.dpdk import DPDKBuildEnvi=
ronment, DPDKRuntimeEnvironment<br>
+=C2=A0 =C2=A0 from framework.testbed_model.capability import TestProtocol<=
br>
=C2=A0 =C2=A0 =C2=A0from framework.testbed_model.traffic_generator.traffic_=
generator import TrafficGenerator<br>
<br>
=C2=A0P =3D ParamSpec(&quot;P&quot;)<br>
@@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -&gt; None:<br>
<br>
=C2=A0def filter_cores(<br>
=C2=A0 =C2=A0 =C2=A0specifier: LogicalCoreCount | LogicalCoreList, ascendin=
g_cores: bool | None =3D None<br>
-):<br>
+) -&gt; Callable[[type[&quot;TestProtocol&quot;]], Callable]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Decorates functions that require a te=
mporary update to the lcore specifier.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def decorator(func):<br>
+=C2=A0 =C2=A0 def decorator(func: type[&quot;TestProtocol&quot;]) -&gt; Ca=
llable:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(*args: P.args, **kwargs: P.kwargs)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(*args: P.args, **kwargs: P.kwargs)=
 -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_ctx =3D get_ctx().loc=
al<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_specifier =3D local_ctx=
.lcore_filter_specifier<br>
diff --git a/dts/framework/exception.py b/dts/framework/exception.py<br>
index 47e3fac05c..84d42c7779 100644<br>
--- a/dts/framework/exception.py<br>
+++ b/dts/framework/exception.py<br>
@@ -59,7 +59,7 @@ class SSHConnectionError(DTSError):<br>
=C2=A0 =C2=A0 =C2=A0_host: str<br>
=C2=A0 =C2=A0 =C2=A0_errors: list[str]<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, host: str, errors: list[str] | None =3D N=
one):<br>
+=C2=A0 =C2=A0 def __init__(self, host: str, errors: list[str] | None =3D N=
one) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Define the meaning of t=
he first two arguments.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -88,7 +88,7 @@ class _SSHTimeoutError(DTSError):<br>
=C2=A0 =C2=A0 =C2=A0severity: ClassVar[ErrorSeverity] =3D ErrorSeverity.SSH=
_ERR<br>
=C2=A0 =C2=A0 =C2=A0_command: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, command: str):<br>
+=C2=A0 =C2=A0 def __init__(self, command: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Define the meaning of t=
he first argument.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -119,7 +119,7 @@ class _SSHSessionDeadError(DTSError):<br>
=C2=A0 =C2=A0 =C2=A0severity: ClassVar[ErrorSeverity] =3D ErrorSeverity.SSH=
_ERR<br>
=C2=A0 =C2=A0 =C2=A0_host: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, host: str):<br>
+=C2=A0 =C2=A0 def __init__(self, host: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Define the meaning of t=
he first argument.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -157,7 +157,7 @@ class RemoteCommandExecutionError(DTSError):<br>
=C2=A0 =C2=A0 =C2=A0_command_stderr: str<br>
=C2=A0 =C2=A0 =C2=A0_command_return_code: int<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, command: str, command_stderr: str, comman=
d_return_code: int):<br>
+=C2=A0 =C2=A0 def __init__(self, command: str, command_stderr: str, comman=
d_return_code: int) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Define the meaning of t=
he first two arguments.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/logger.py b/dts/framework/logger.py<br>
index f43b442bc9..a0c81c3c47 100644<br>
--- a/dts/framework/logger.py<br>
+++ b/dts/framework/logger.py<br>
@@ -15,7 +15,7 @@<br>
=C2=A0import logging<br>
=C2=A0from logging import FileHandler, StreamHandler<br>
=C2=A0from pathlib import Path<br>
-from typing import ClassVar<br>
+from typing import Any, ClassVar<br>
<br>
=C2=A0date_fmt =3D &quot;%Y/%m/%d %H:%M:%S&quot;<br>
=C2=A0stream_fmt =3D &quot;%(asctime)s - %(stage)s - %(name)s - %(levelname=
)s - %(message)s&quot;<br>
@@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):<br>
=C2=A0 =C2=A0 =C2=A0_stage: ClassVar[str] =3D &quot;pre_run&quot;<br>
=C2=A0 =C2=A0 =C2=A0_extra_file_handlers: list[FileHandler] =3D []<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, *args, **kwargs):<br>
+=C2=A0 =C2=A0 def __init__(self, *args: Any, **kwargs: Any) -&gt; None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Extend the constructor =
with extra file handlers.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._extra_file_handlers =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(*args, **kwargs)<br>
<br>
-=C2=A0 =C2=A0 def makeRecord(self, *args, **kwargs) -&gt; logging.LogRecor=
d:<br>
+=C2=A0 =C2=A0 def makeRecord(self, *args: Any, **kwargs: Any) -&gt; loggin=
g.LogRecord:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Generates a record with=
 additional stage information.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is the default method for the :class=
:`~logging.Logger` class. We extend it<br>
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init=
__.py<br>
index 1ae227d7b4..e6a2d3c903 100644<br>
--- a/dts/framework/params/__init__.py<br>
+++ b/dts/framework/params/__init__.py<br>
@@ -25,7 +25,7 @@<br>
=C2=A0T =3D TypeVar(&quot;T&quot;)<br>
<br>
=C2=A0#: Type for a function taking one argument.<br>
-FnPtr =3D Callable[[Any], Any]<br>
+FnPtr =3D Callable[[T], T]<br>
=C2=A0#: Type for a switch parameter.<br>
=C2=A0Switch =3D Literal[True, None]<br>
=C2=A0#: Type for a yes/no switch parameter.<br>
@@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -&gt; FnPtr=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FnPtr: A function that calls the given fu=
nctions from left to right.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def reduced_fn(value):<br>
+=C2=A0 =C2=A0 def reduced_fn(value: T) -&gt; T:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fn in funcs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D fn(value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return value<br>
@@ -75,8 +75,8 @@ class BitMask(enum.Flag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will allow ``BitMask`` to render as a hex=
adecimal value.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def _class_decorator(original_class):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 original_class.__str__ =3D _reduce_functions(f=
uncs)<br>
+=C2=A0 =C2=A0 def _class_decorator(original_class: T) -&gt; T:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setattr(original_class, &quot;__str__&quot;, _=
reduce_functions(funcs))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return original_class<br>
<br>
=C2=A0 =C2=A0 =C2=A0return _class_decorator<br>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_se=
ssion/dpdk.py<br>
index 606d6e22fe..7b9c0e89cb 100644<br>
--- a/dts/framework/remote_session/dpdk.py<br>
+++ b/dts/framework/remote_session/dpdk.py<br>
@@ -62,7 +62,7 @@ class DPDKBuildEnvironment:<br>
<br>
=C2=A0 =C2=A0 =C2=A0compiler_version: str | None<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, config: DPDKBuildConfiguration, node: Nod=
e):<br>
+=C2=A0 =C2=A0 def __init__(self, config: DPDKBuildConfiguration, node: Nod=
e) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK build environment =
class constructor.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.config =3D config<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._node =3D node<br>
@@ -74,7 +74,7 @@ def __init__(self, config: DPDKBuildConfiguration, node: =
Node):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.compiler_version =3D None<br>
<br>
-=C2=A0 =C2=A0 def setup(self):<br>
+=C2=A0 =C2=A0 def setup(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Set up the DPDK build o=
n the target node.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DPDK setup includes setting all internals=
 needed for the build, the copying of DPDK<br>
@@ -118,7 +118,7 @@ def teardown(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._node.ma=
in_session.remove_remote_file(tarball_path)<br>
<br>
-=C2=A0 =C2=A0 def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):<b=
r>
+=C2=A0 =C2=A0 def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath) -&=
gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Set the path to the rem=
ote DPDK source tree based on the provided DPDK location.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify DPDK source tree existence on the =
SUT node, if exists sets the<br>
@@ -205,7 +205,7 @@ def _prepare_and_extract_dpdk_tarball(self, remote_tarb=
all_path: PurePath) -&gt; No<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strip_root_dir=3DTrue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def _set_remote_dpdk_build_dir(self, build_dir: str):<br>
+=C2=A0 =C2=A0 def _set_remote_dpdk_build_dir(self, build_dir: str) -&gt; N=
one:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Set the `remote_dpdk_bu=
ild_dir` on the SUT.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Check existence on the SUT node and sets =
the<br>
@@ -277,7 +277,7 @@ def remote_dpdk_tree_path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._node.tmp_dir.joinpath(self._=
remote_tmp_dpdk_tree_dir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
-=C2=A0 =C2=A0 def remote_dpdk_build_dir(self) -&gt; str | PurePath:<br>
+=C2=A0 =C2=A0 def remote_dpdk_build_dir(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The remote DPDK build d=
ir path.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._remote_dpdk_build_dir:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._remote_dpdk_bu=
ild_dir<br>
@@ -286,7 +286,7 @@ def remote_dpdk_build_dir(self) -&gt; str | PurePath:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Failed to get remote =
dpdk build dir because we don&#39;t know the &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;location on the SUT n=
ode.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return PurePath(&quot;&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@cached_property<br>
=C2=A0 =C2=A0 =C2=A0def dpdk_version(self) -&gt; str | None:<br>
@@ -323,7 +323,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config: DPDKRuntimeConfiguration,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node: Node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_env: DPDKBuildEnvironment | None =
=3D None,<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK environment constr=
uctor.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -354,7 +354,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._ports_bound_to_dpdk =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._kill_session =3D None<br>
<br>
-=C2=A0 =C2=A0 def setup(self):<br>
+=C2=A0 =C2=A0 def setup(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Set up the DPDK runtime=
 on the target node.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.build:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.build.setup()<br>
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/rem=
ote_session/dpdk_shell.py<br>
index d4aa02f39b..51b97d4ff6 100644<br>
--- a/dts/framework/remote_session/dpdk_shell.py<br>
+++ b/dts/framework/remote_session/dpdk_shell.py<br>
@@ -78,7 +78,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0def path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Relative path to the sh=
ell executable from the build folder.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def _make_real_path(self):<br>
+=C2=A0 =C2=A0 def _make_real_path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.inte=
ractive_shell.InteractiveShell._make_real_path`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Adds the remote DPDK build directory to t=
he path.<br>
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framew=
ork/remote_session/interactive_shell.py<br>
index ba8489eafa..ce93247051 100644<br>
--- a/dts/framework/remote_session/interactive_shell.py<br>
+++ b/dts/framework/remote_session/interactive_shell.py<br>
@@ -24,7 +24,7 @@<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from collections.abc import Callable<br>
=C2=A0from pathlib import PurePath<br>
-from typing import ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar<br=
>
+from typing import Any, ClassVar, Concatenate, ParamSpec, TypeAlias, TypeV=
ar<br>
<br>
=C2=A0from paramiko import Channel, channel<br>
=C2=A0from typing_extensions import Self<br>
@@ -126,7 +126,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._privileged =3D privileged<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._timeout =3D SETTINGS.timeout<br>
<br>
-=C2=A0 =C2=A0 def _setup_ssh_channel(self):<br>
+=C2=A0 =C2=A0 def _setup_ssh_channel(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._ssh_channel =3D self._node.main_ses=
sion.interactive_session.session.invoke_shell()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._stdin =3D self._ssh_channel.makefil=
e_stdin(&quot;w&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._stdout =3D self._ssh_channel.makefi=
le(&quot;r&quot;)<br>
@@ -277,7 +277,7 @@ def __enter__(self) -&gt; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.start_application()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self<br>
<br>
-=C2=A0 =C2=A0 def __exit__(self, *_) -&gt; None:<br>
+=C2=A0 =C2=A0 def __exit__(self, *_: Any) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Exit the context block.=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Upon exiting a context block with this cl=
ass, we want to ensure that the instance of the<br>
diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework/r=
emote_session/python_shell.py<br>
index 5b380a5c7a..5f39a244d6 100644<br>
--- a/dts/framework/remote_session/python_shell.py<br>
+++ b/dts/framework/remote_session/python_shell.py<br>
@@ -33,6 +33,6 @@ def path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PurePath(&quot;python3&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@only_active<br>
-=C2=A0 =C2=A0 def close(self):<br>
+=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Close Python shell.&quo=
t;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return super().close()<br>
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework=
/remote_session/remote_session.py<br>
index 89d4618c41..f616b92f1c 100644<br>
--- a/dts/framework/remote_session/remote_session.py<br>
+++ b/dts/framework/remote_session/remote_session.py<br>
@@ -99,7 +99,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_config: NodeConfiguration,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session_name: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger: DTSLogger,<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Connect to the node dur=
ing initialization.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/rem=
ote_session/shell_pool.py<br>
index da956950d5..241737eab3 100644<br>
--- a/dts/framework/remote_session/shell_pool.py<br>
+++ b/dts/framework/remote_session/shell_pool.py<br>
@@ -32,7 +32,7 @@ class ShellPool:<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
=C2=A0 =C2=A0 =C2=A0_pools: list[set[&quot;InteractiveShell&quot;]]<br>
<br>
-=C2=A0 =C2=A0 def __init__(self):<br>
+=C2=A0 =C2=A0 def __init__(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Shell pool constructor.=
&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger =3D get_dts_logger(&quot;she=
ll_pool&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._pools =3D [set()]<br>
@@ -50,12 +50,12 @@ def _current_pool(self) -&gt; set[&quot;InteractiveShel=
l&quot;]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The pool in use for the=
 current scope.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._pools[-1]<br>
<br>
-=C2=A0 =C2=A0 def register_shell(self, shell: &quot;InteractiveShell&quot;=
):<br>
+=C2=A0 =C2=A0 def register_shell(self, shell: &quot;InteractiveShell&quot;=
) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Register a new shell to=
 the current pool.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(f&quot;Registering she=
ll {shell} to pool level {self.pool_level}.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._current_pool.add(shell)<br>
<br>
-=C2=A0 =C2=A0 def unregister_shell(self, shell: &quot;InteractiveShell&quo=
t;):<br>
+=C2=A0 =C2=A0 def unregister_shell(self, shell: &quot;InteractiveShell&quo=
t;) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Unregister a shell from=
 any pool.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for level, pool in enumerate(self._pools)=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
@@ -72,12 +72,12 @@ def unregister_shell(self, shell: &quot;InteractiveShel=
l&quot;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except KeyError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
-=C2=A0 =C2=A0 def start_new_pool(self):<br>
+=C2=A0 =C2=A0 def start_new_pool(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Start a new shell pool.=
&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(f&quot;Starting new sh=
ell pool and advancing to level {self.pool_level+1}.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._pools.append(set())<br>
<br>
-=C2=A0 =C2=A0 def terminate_current_pool(self):<br>
+=C2=A0 =C2=A0 def terminate_current_pool(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Terminate all the shell=
s in the current pool, and restore the previous pool if any.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If any failure occurs while closing any s=
hell, this is tolerated allowing the termination<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index ad8cb273dc..1df3d5f792 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -64,7 +64,7 @@ class TestPmdDevice:<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci_address: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, pci_address_line: str):<br>
+=C2=A0 =C2=A0 def __init__(self, pci_address_line: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the device f=
rom the testpmd output line string.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -90,7 +90,7 @@ class VLANOffloadFlag(Flag):<br>
=C2=A0 =C2=A0 =C2=A0QINQ_STRIP =3D auto()<br>
<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
-=C2=A0 =C2=A0 def from_str_dict(cls, d):<br>
+=C2=A0 =C2=A0 def from_str_dict(cls, d: dict[str, str]) -&gt; Self:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Makes an instance from =
a dict containing the flag member names with an &quot;on&quot; value.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -405,7 +405,7 @@ def make_device_private_info_parser() -&gt; ParserFn:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0function that parses the de=
vice private info from the TestPmd port info output.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def _validate(info: str):<br>
+=C2=A0 =C2=A0 def _validate(info: str) -&gt; str | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D info.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if info =3D=3D &quot;none&quot; or info.s=
tartswith(&quot;Invalid file&quot;) or info.startswith(&quot;Failed to dump=
&quot;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
@@ -1449,7 +1449,7 @@ def requires_stopped_ports(func: TestPmdShellMethod) =
-&gt; TestPmdShellMethod:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
-=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs):<br>
+=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs) -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.ports_started:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(&quot;Po=
rts need to be stopped to continue.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stop_all_ports()<br>
@@ -1470,7 +1470,7 @@ def requires_started_ports(func: TestPmdShellMethod) =
-&gt; TestPmdShellMethod:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
-=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs):<br>
+=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.args, =
**kwargs: P.kwargs) -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.ports_started:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(&quot;Po=
rts need to be started to continue.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.start_all_ports()<br>
@@ -1492,7 +1492,7 @@ def add_remove_mtu(mtu: int =3D 1500) -&gt; Callable[=
[TestPmdShellMethod], TestPmdShe<br>
<br>
=C2=A0 =C2=A0 =C2=A0def decorator(func: TestPmdShellMethod) -&gt; TestPmdSh=
ellMethod:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmdShell&quot;, *a=
rgs: P.args, **kwargs: P.kwargs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmdShell&quot;, *a=
rgs: P.args, **kwargs: P.kwargs) -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0original_mtu =3D self.ports=
[0].mtu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.set_port_mtu_all(mtu=
=3Dmtu, verify=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D func(self, *args=
, **kwargs)<br>
@@ -1644,7 +1644,7 @@ def wait_link_status_up(self, port_id: int, timeout=
=3DSETTINGS.timeout) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.error(f&quot;T=
he link for port {port_id} did not come up in the given timeout.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Link status: up&quot; in por=
t_info<br>
<br>
-=C2=A0 =C2=A0 def set_forward_mode(self, mode: SimpleForwardingModes, veri=
fy: bool =3D True):<br>
+=C2=A0 =C2=A0 def set_forward_mode(self, mode: SimpleForwardingModes, veri=
fy: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Set packet forwarding m=
ode.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/runner.py b/dts/framework/runner.py<br>
index 0a3d92b0c8..4f2c05bd2f 100644<br>
--- a/dts/framework/runner.py<br>
+++ b/dts/framework/runner.py<br>
@@ -31,7 +31,7 @@ class DTSRunner:<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
=C2=A0 =C2=A0 =C2=A0_result: TestRunResult<br>
<br>
-=C2=A0 =C2=A0 def __init__(self):<br>
+=C2=A0 =C2=A0 def __init__(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the instance=
 with configuration, logger, result and string constants.&quot;&quot;&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._configuration =3D loa=
d_config(ValidationContext(settings=3DSETTINGS))<br>
diff --git a/dts/framework/settings.py b/dts/framework/settings.py<br>
index 3f21615223..84b627a06a 100644<br>
--- a/dts/framework/settings.py<br>
+++ b/dts/framework/settings.py<br>
@@ -108,7 +108,7 @@<br>
=C2=A0from argparse import Action, ArgumentDefaultsHelpFormatter, _get_acti=
on_name<br>
=C2=A0from dataclasses import dataclass, field<br>
=C2=A0from pathlib import Path<br>
-from typing import Callable<br>
+from typing import Callable, NoReturn<br>
<br>
=C2=A0from pydantic import ValidationError<br>
<br>
@@ -174,7 +174,7 @@ def _make_env_var_name(action: Action, env_var_name: st=
r | None) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0return env_var_name<br>
<br>
<br>
-def _get_env_var_name(action: Action) -&gt; str | None:<br>
+def _get_env_var_name(action: Action | None) -&gt; str | None:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Get the environment variable name of =
the given action.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0return getattr(action, _ENV_VAR_NAME_ATTR, None)<br>
<br>
@@ -237,12 +237,15 @@ def find_action(<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return action<br>
<br>
-=C2=A0 =C2=A0 def error(self, message):<br>
+=C2=A0 =C2=A0 def error(self, message) -&gt; NoReturn:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Augments :meth:`~argpar=
se.ArgumentParser.error` with environment variable awareness.&quot;&quot;&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for action in self._actions:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if _is_from_env(action):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0action_name =
=3D _get_action_name(action)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_var_name =
=3D _get_env_var_name(action)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env_=
var_name is not None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ), &quot;Action wa=
s set from environment, but no environment variable name was found.&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_var_value=
 =3D os.environ.get(env_var_name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0message =3D m=
essage.replace(<br>
@@ -257,7 +260,7 @@ def error(self, message):<br>
=C2=A0class _EnvVarHelpFormatter(ArgumentDefaultsHelpFormatter):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Custom formatter to add environment v=
ariables to the help page.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def _get_help_string(self, action):<br>
+=C2=A0 =C2=A0 def _get_help_string(self, action: Action) -&gt; str | None:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`Argume=
ntDefaultsHelpFormatter._get_help_string`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help =3D super()._get_help_string(action)=
<br>
<br>
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py<br=
>
index 8ce6cc8fbf..c6bddc55a9 100644<br>
--- a/dts/framework/test_result.py<br>
+++ b/dts/framework/test_result.py<br>
@@ -77,13 +77,13 @@ class ResultLeaf(BaseModel):<br>
=C2=A0 =C2=A0 =C2=A0result: Result<br>
=C2=A0 =C2=A0 =C2=A0reason: DTSError | None =3D None<br>
<br>
-=C2=A0 =C2=A0 def __lt__(self, other):<br>
+=C2=A0 =C2=A0 def __lt__(self, other: object) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare another instanc=
e of the same class by :attr:`~ResultLeaf.result`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(other, ResultLeaf):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.result &lt; oth=
er.result<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
-=C2=A0 =C2=A0 def __eq__(self, other):<br>
+=C2=A0 =C2=A0 def __eq__(self, other: object) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare equality with c=
ompatible classes by :attr:`~ResultLeaf.result`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match other:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ResultLeaf(result=3Dre=
sult):<br>
@@ -128,7 +128,7 @@ def add_child(self, label: str) -&gt; &quot;ResultNode&=
quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.children.append(child)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return child<br>
<br>
-=C2=A0 =C2=A0 def mark_result_as(self, result: Result, ex: Exception | Non=
e =3D None) -&gt; None:<br>
+=C2=A0 =C2=A0 def mark_result_as(self, result: Result, ex: BaseException |=
 None =3D None) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Mark result for the cur=
rent step.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -149,7 +149,7 @@ def mark_result_as(self, result: Result, ex: Exception =
| None =3D None) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.children.append(Result=
Leaf(result=3Dresult, reason=3Dreason))<br>
<br>
=C2=A0 =C2=A0 =C2=A0def mark_step_as(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, step: ExecutionStep, result: Result, ex:=
 Exception | None =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, step: ExecutionStep, result: Result, ex:=
 BaseException | None =3D None<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Mark an execution step =
with the given result.<br>
<br>
@@ -264,7 +264,7 @@ def serialize_errors(self, execution_errors: list[DTSEr=
ror]) -&gt; list[str]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Serialize errors as pla=
in text.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return [str(err) for err in execution_err=
ors]<br>
<br>
-=C2=A0 =C2=A0 def add_error(self, ex: Exception) -&gt; None:<br>
+=C2=A0 =C2=A0 def add_error(self, ex: BaseException) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Add an execution error =
to the test run result.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(ex, DTSError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.execution_errors.appen=
d(ex)<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index 4355aeeb4b..ca9066299e 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -162,7 +162,7 @@ class TestRun:<br>
=C2=A0 =C2=A0 =C2=A0config: TestRunConfiguration<br>
=C2=A0 =C2=A0 =C2=A0logger: DTSLogger<br>
<br>
-=C2=A0 =C2=A0 state: &quot;State&quot;<br>
+=C2=A0 =C2=A0 state: Union[&quot;State&quot;, None]<br>
=C2=A0 =C2=A0 =C2=A0ctx: Context<br>
=C2=A0 =C2=A0 =C2=A0result: TestRunResult<br>
=C2=A0 =C2=A0 =C2=A0selected_tests: list[TestScenario]<br>
@@ -178,7 +178,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests_config: dict[str, BaseConfig],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nodes: Iterable[Node],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result: TestRunResult,<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test run constructor.<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -226,7 +226,7 @@ def required_capabilities(self) -&gt; set[Capability]:<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return caps<br>
<br>
-=C2=A0 =C2=A0 def spin(self):<br>
+=C2=A0 =C2=A0 def spin(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Spin the internal state=
 machine that executes the test run.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.logger.info" rel=
=3D"noreferrer" target=3D"_blank">self.logger.info</a>(f&quot;Running test =
run with SUT &#39;{<a href=3D"http://self.ctx.sut_node.name" rel=3D"norefer=
rer" target=3D"_blank">self.ctx.sut_node.name</a>}&#39;.&quot;)<br>
<br>
@@ -258,11 +258,11 @@ class State(Protocol):<br>
=C2=A0 =C2=A0 =C2=A0test_run: TestRun<br>
=C2=A0 =C2=A0 =C2=A0result: TestRunResult | ResultNode<br>
<br>
-=C2=A0 =C2=A0 def before(self):<br>
+=C2=A0 =C2=A0 def before(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Hook before the state i=
s processed.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.set_stage(self.logger_name, s=
elf.log_file_path)<br>
<br>
-=C2=A0 =C2=A0 def after(self):<br>
+=C2=A0 =C2=A0 def after(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Hook after the state is=
 processed.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
<br>
@@ -289,12 +289,12 @@ def log_file_path(self) -&gt; Path | None:<br>
=C2=A0 =C2=A0 =C2=A0def next(self) -&gt; Union[&quot;State&quot;, None]:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state.&quot;&quot;=
&quot;<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; Union[&quot;State&qu=
ot;, None]:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; Union[&quot;Stat=
e&quot;, None]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def handle_exception(self, ex: Exception) -&gt; Union[&quot;=
State&quot;, None]:<br>
+=C2=A0 =C2=A0 def handle_exception(self, ex: BaseException) -&gt; Union[&q=
uot;State&quot;, None]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Handles an exception ra=
ised by `next`.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 next_state =3D self.on_error(ex)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 next_state =3D self.on_error(Exception(ex))<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match ex:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case InternalError():<br>
@@ -362,7 +362,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunExecution(test_run, self.re=
sult)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.result.add_error(ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunTeardown(self.test_run, sel=
f.result)<br>
@@ -411,7 +411,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# No more test suites. We a=
re done here.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunTeardown(test=
_run, self.result)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.result.add_error(ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunTeardown(self.test_run, sel=
f.result)<br>
@@ -443,7 +443,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.ctx.sut_node.teardown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.result.add_error(ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.warning(<br>
@@ -491,7 +491,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result=3Dself.result,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_step_as(&quot;setup&quot=
;, Result.ERROR, ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestSuiteTeardown(self.test_run, s=
elf.test_suite, self.result)<br>
@@ -543,7 +543,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# No more tes=
t cases. We are done here.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestSu=
iteTeardown(self.test_run, self.test_suite, self.result)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.test_run.result.add_error(ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestSuiteTeardown(self.test_run, s=
elf.test_suite, self.result)<br>
@@ -568,7 +568,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_step_as(&quot;teardown&q=
uot;, Result.PASS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunExecution(self.test_run, se=
lf.test_run.result)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.warning(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The environment may h=
ave not been cleaned up correctly. &quot;<br>
@@ -577,7 +577,7 @@ def on_error(self, ex: Exception) -&gt; State | None:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_step_as(&quot;teardown&q=
uot;, Result.ERROR, ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestRunExecution(self.test_run, se=
lf.test_run.result)<br>
<br>
-=C2=A0 =C2=A0 def after(self):<br>
+=C2=A0 =C2=A0 def after(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Hook after state is pro=
cessed.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.get_overall_res=
ult() in [Result.FAIL, Result.ERROR]<br>
@@ -633,7 +633,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SETTINGS.re_run,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_step_as(&quot;setup&quot=
;, Result.ERROR, ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_result_as(Result.BLOCK)<=
br>
@@ -686,7 +686,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.mark_result_as(Result.ERROR, =
ex)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TestCaseTeardown(<br>
@@ -720,7 +720,7 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result=3Dself.result.parent=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def on_error(self, ex: Exception) -&gt; State | None:<br>
+=C2=A0 =C2=A0 def on_error(self, ex: BaseException) -&gt; State | None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Next state on error.&qu=
ot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.warning(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The environment may h=
ave not been cleaned up correctly. &quot;<br>
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py<br>
index d4e06a567a..5ee5a039d7 100644<br>
--- a/dts/framework/test_suite.py<br>
+++ b/dts/framework/test_suite.py<br>
@@ -92,7 +92,7 @@ class TestSuite(TestProtocol):<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_ingress: Union[IPv4Interface, IPv6Interf=
ace]<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_egress: Union[IPv4Interface, IPv6Interfa=
ce]<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, config: BaseConfig):<br>
+=C2=A0 =C2=A0 def __init__(self, config: BaseConfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the test sui=
te testbed information and basic configuration.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -681,7 +681,7 @@ def class_obj(self) -&gt; type[TestSuite]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InternalError: If the test =
suite class is missing from the module.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def is_test_suite(obj) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def is_test_suite(obj: type) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Check whe=
ther `obj` is a :class:`TestSuite`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The `obj` is a subclass of =
:class:`TestSuite`, but not :class:`TestSuite` itself.<br>
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/test=
bed_model/capability.py<br>
index f895b22bb3..87be7e6b93 100644<br>
--- a/dts/framework/testbed_model/capability.py<br>
+++ b/dts/framework/testbed_model/capability.py<br>
@@ -50,7 +50,7 @@ def test_scatter_mbuf_2048(self):<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from collections.abc import MutableSet<br>
=C2=A0from dataclasses import dataclass<br>
-from typing import TYPE_CHECKING, Callable, ClassVar, Protocol<br>
+from typing import TYPE_CHECKING, Any, Callable, ClassVar, Protocol<br>
<br>
=C2=A0from typing_extensions import Self<br>
<br>
@@ -374,7 +374,7 @@ def set_required(self, test_case_or_suite: type[&quot;T=
estProtocol&quot;]) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.add_to_required(test_c=
ase_or_suite)<br>
<br>
-=C2=A0 =C2=A0 def __eq__(self, other) -&gt; bool:<br>
+=C2=A0 =C2=A0 def __eq__(self, other: Any) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare the :attr:`~Top=
ologyCapability.topology_type`s.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -385,7 +385,7 @@ def __eq__(self, other) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.topology_type =3D=3D other.to=
pology_type<br>
<br>
-=C2=A0 =C2=A0 def __lt__(self, other) -&gt; bool:<br>
+=C2=A0 =C2=A0 def __lt__(self, other: Any) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare the :attr:`~Top=
ologyCapability.topology_type`s.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -396,7 +396,7 @@ def __lt__(self, other) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.topology_type &lt; other.topo=
logy_type<br>
<br>
-=C2=A0 =C2=A0 def __gt__(self, other) -&gt; bool:<br>
+=C2=A0 =C2=A0 def __gt__(self, other: Any) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare the :attr:`~Top=
ologyCapability.topology_type`s.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -407,7 +407,7 @@ def __gt__(self, other) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return other &lt; self<br>
<br>
-=C2=A0 =C2=A0 def __le__(self, other) -&gt; bool:<br>
+=C2=A0 =C2=A0 def __le__(self, other: Any) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compare the :attr:`~Top=
ologyCapability.topology_type`s.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/testbed_model/cpu.py b/dts/framework/testbed_mod=
el/cpu.py<br>
index b8bc601c22..6e2ecca080 100644<br>
--- a/dts/framework/testbed_model/cpu.py<br>
+++ b/dts/framework/testbed_model/cpu.py<br>
@@ -80,7 +80,7 @@ class LogicalCoreList:<br>
=C2=A0 =C2=A0 =C2=A0_lcore_list: list[int]<br>
=C2=A0 =C2=A0 =C2=A0_lcore_str: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, lcore_list: list[int] | list[str] | list[=
LogicalCore] | str):<br>
+=C2=A0 =C2=A0 def __init__(self, lcore_list: list[int] | list[str] | list[=
LogicalCore] | str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Process `lcore_list`, t=
hen sort.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0There are four supported logical core lis=
t formats::<br>
@@ -169,7 +169,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lcore_list: list[LogicalCore],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filter_specifier: LogicalCoreCount | Logi=
calCoreList,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ascending: bool =3D True,<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Filter according to the=
 input filter specifier.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The input `lcore_list` is copied and sort=
ed by physical core before filtering.<br>
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_mo=
del/node.py<br>
index 35cf6f1452..4f6150f18c 100644<br>
--- a/dts/framework/testbed_model/node.py<br>
+++ b/dts/framework/testbed_model/node.py<br>
@@ -59,7 +59,7 @@ class Node:<br>
=C2=A0 =C2=A0 =C2=A0_compiler_version: str | None<br>
=C2=A0 =C2=A0 =C2=A0_setup: bool<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, node_config: NodeConfiguration):<br>
+=C2=A0 =C2=A0 def __init__(self, node_config: NodeConfiguration) -&gt; Non=
e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Connect to the node and=
 gather info during initialization.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Extra gathered information:<br>
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/test=
bed_model/os_session.py<br>
index b6e03aa83d..b182c3bde4 100644<br>
--- a/dts/framework/testbed_model/os_session.py<br>
+++ b/dts/framework/testbed_model/os_session.py<br>
@@ -115,7 +115,7 @@ def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_config: NodeConfiguration,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger: DTSLogger,<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the OS-aware=
 session.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Connect to the node right away and also c=
reate an interactive remote session.<br>
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_mo=
del/port.py<br>
index fc58e2b993..2c0276971f 100644<br>
--- a/dts/framework/testbed_model/port.py<br>
+++ b/dts/framework/testbed_model/port.py<br>
@@ -49,7 +49,7 @@ class Port:<br>
=C2=A0 =C2=A0 =C2=A0config: Final[PortConfig]<br>
=C2=A0 =C2=A0 =C2=A0_original_driver: str | None<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, node: &quot;Node&quot;, config: PortConfi=
g):<br>
+=C2=A0 =C2=A0 def __init__(self, node: &quot;Node&quot;, config: PortConfi=
g) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the port fro=
m `node` and `config`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -128,7 +128,7 @@ def bound_for_dpdk(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Is the port bound to th=
e driver for DPDK?&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.current_driver =3D=3D self.co=
nfig.os_driver_for_dpdk<br>
<br>
-=C2=A0 =C2=A0 def configure_mtu(self, mtu: int):<br>
+=C2=A0 =C2=A0 def configure_mtu(self, mtu: int) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Configure the port&#39;=
s MTU value.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/t=
estbed_model/posix_session.py<br>
index c71bc93f0b..dec952685a 100644<br>
--- a/dts/framework/testbed_model/posix_session.py<br>
+++ b/dts/framework/testbed_model/posix_session.py<br>
@@ -183,7 +183,7 @@ def create_remote_tarball(<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; PurePosixPath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.create_remote_tarball`.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def generate_tar_exclude_args(exclude_patterns=
) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def generate_tar_exclude_args(exclude_patterns=
: str | list[str] | None) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Generate =
args to exclude patterns when creating a tarball.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/f=
ramework/testbed_model/traffic_generator/scapy.py<br>
index e21ba4ed96..a31807e8e4 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/scapy.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py<br>
@@ -16,7 +16,7 @@<br>
=C2=A0from collections.abc import Callable<br>
=C2=A0from queue import Empty, SimpleQueue<br>
=C2=A0from threading import Event, Thread<br>
-from typing import ClassVar<br>
+from typing import Any, ClassVar<br>
<br>
=C2=A0from scapy.compat import base64_bytes<br>
=C2=A0from scapy.data import ETHER_TYPES, IP_PROTOS<br>
@@ -57,7 +57,7 @@ class ScapyAsyncSniffer(PythonShell):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, node: Node, recv_port: Port, name: =
str | None =3D None, privileged: bool =3D True<br>
-=C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Sniffer constructor.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -189,7 +189,7 @@ def close(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sniffer.join()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().close()<br>
<br>
-=C2=A0 =C2=A0 def _sniff(self, recv_port: Port):<br>
+=C2=A0 =C2=A0 def _sniff(self, recv_port: Port) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Sniff packets and use e=
vents and queue to communicate with the main thread.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raises:<br>
@@ -229,7 +229,7 @@ def _sniff(self, recv_port: Port):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(&quot;Stop sniffing.&q=
uot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.send_command(&quot;\x03&quot;)=C2=A0=
 # send Ctrl+C to trigger a KeyboardInterrupt in `sniff`.<br>
<br>
-=C2=A0 =C2=A0 def _set_packet_filter(self, filter_config: PacketFilteringC=
onfig):<br>
+=C2=A0 =C2=A0 def _set_packet_filter(self, filter_config: PacketFilteringC=
onfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Make and set a filterin=
g function from `filter_config`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
@@ -296,7 +296,7 @@ class also extends :class:`.capturing_traffic_generator=
.CapturingTrafficGenerato<br>
=C2=A0 =C2=A0 =C2=A0#: Padding to add to the start of a line for python syn=
tax compliance.<br>
=C2=A0 =C2=A0 =C2=A0_python_indentation: ClassVar[str] =3D &quot; &quot; * =
4<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: ScapyTrafficGenera=
torConfig, **kwargs):<br>
+=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: ScapyTrafficGenera=
torConfig, **kwargs: Any) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Extend the constructor =
with Scapy TG specifics.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Initializes both the traffic generator an=
d the interactive shell used to handle Scapy<br>
@@ -315,7 +315,7 @@ def __init__(self, tg_node: Node, config: ScapyTrafficG=
eneratorConfig, **kwargs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(tg_node=3Dtg_node, confi=
g=3Dconfig, **kwargs)<br>
<br>
-=C2=A0 =C2=A0 def setup(self, topology: Topology):<br>
+=C2=A0 =C2=A0 def setup(self, topology: Topology) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Extends :meth:`.traffic=
_generator.TrafficGenerator.setup`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Binds the TG node ports to the kernel dri=
vers and starts up the async sniffer.<br>
@@ -332,7 +332,7 @@ def setup(self, topology: Topology):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell.send_command(&quot;from scapy=
.all import *&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell.send_command(&quot;from scapy=
.contrib.lldp import *&quot;)<br>
<br>
-=C2=A0 =C2=A0 def close(self):<br>
+=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`.traff=
ic_generator.TrafficGenerator.close`.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Stops the traffic generator and sniffer s=
hells.<br>
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generato=
r.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<b=
r>
index 8f53b07daf..cac119c183 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
@@ -9,6 +9,7 @@<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0from abc import ABC, abstractmethod<br>
+from typing import Any<br>
<br>
=C2=A0from scapy.packet import Packet<br>
<br>
@@ -34,7 +35,7 @@ class TrafficGenerator(ABC):<br>
=C2=A0 =C2=A0 =C2=A0_tg_node: Node<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: TrafficGeneratorCo=
nfig, **kwargs):<br>
+=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: TrafficGeneratorCo=
nfig, **kwargs: Any) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the traffic =
generator.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Additional keyword arguments can be passe=
d through `kwargs` if needed for fulfilling other<br>
@@ -49,10 +50,10 @@ def __init__(self, tg_node: Node, config: TrafficGenera=
torConfig, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._tg_node =3D tg_node<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger =3D get_dts_logger(f&quot;{s=
elf._<a href=3D"http://tg_node.name" rel=3D"noreferrer" target=3D"_blank">t=
g_node.name</a>} {self._config.type}&quot;)<br>
<br>
-=C2=A0 =C2=A0 def setup(self, topology: Topology):<br>
+=C2=A0 =C2=A0 def setup(self, topology: Topology) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Setup the traffic gener=
ator.&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def teardown(self):<br>
+=C2=A0 =C2=A0 def teardown(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Teardown the traffic ge=
nerator.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.close()<br>
<br>
diff --git a/dts/framework/testbed_model/virtual_device.py b/dts/framework/=
testbed_model/virtual_device.py<br>
index 569d67b007..1a4794e695 100644<br>
--- a/dts/framework/testbed_model/virtual_device.py<br>
+++ b/dts/framework/testbed_model/virtual_device.py<br>
@@ -16,7 +16,7 @@ class VirtualDevice:<br>
<br>
=C2=A0 =C2=A0 =C2=A0name: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, name: str):<br>
+=C2=A0 =C2=A0 def __init__(self, name: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the virtual =
device.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
diff --git a/dts/framework/utils.py b/dts/framework/utils.py<br>
index 0c81ab1b95..a70c9c7d95 100644<br>
--- a/dts/framework/utils.py<br>
+++ b/dts/framework/utils.py<br>
@@ -147,14 +147,14 @@ class TarCompressionFormat(StrEnum):<br>
=C2=A0 =C2=A0 =C2=A0zstd =3D &quot;zst&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
-=C2=A0 =C2=A0 def extension(self):<br>
+=C2=A0 =C2=A0 def extension(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Return the extension as=
sociated with the compression format.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If the compression format is &#39;none&#3=
9;, the extension will be in the format &#39;tar&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For other compression formats, the extens=
ion will be in the format<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tar.{compression format}&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =3D=
=3D self.none else f&quot;{self.none.value}.{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =3D=
=3D self.none else f&quot;{type(self).none.value}.{self.value}&quot;<br>
<br>
<br>
=C2=A0def convert_to_list_of_string(value: Any | list[Any]) -&gt; list[str]=
:<br>
@@ -213,7 +213,7 @@ def filter_func(tarinfo: tarfile.TarInfo) -&gt; tarfile=
.TarInfo | None:<br>
=C2=A0 =C2=A0 =C2=A0return target_tarball_path<br>
<br>
<br>
-def extract_tarball(tar_path: str | Path):<br>
+def extract_tarball(tar_path: str | Path) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Extract the contents of a tarball.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0The tarball will be extracted in the same path as `tar_=
path` parent path.<br>
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blockli=
st.py<br>
index ce7da1cc8f..c668bcd86c 100644<br>
--- a/dts/tests/TestSuite_blocklist.py<br>
+++ b/dts/tests/TestSuite_blocklist.py<br>
@@ -16,7 +16,7 @@<br>
=C2=A0class TestBlocklist(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK device blocklisting test suite.&=
quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def verify_blocklisted_ports(self, ports_to_block: list[Port=
]):<br>
+=C2=A0 =C2=A0 def verify_blocklisted_ports(self, ports_to_block: list[Port=
]) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Runs testpmd with the g=
iven ports blocklisted and verifies the ports.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with TestPmdShell(allowed_ports=3D[], blo=
cked_ports=3Dports_to_block) as testpmd:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allowlisted_ports =3D {port=
.device_name for port in testpmd.show_port_info_all()}<br>
@@ -30,7 +30,7 @@ def verify_blocklisted_ports(self, ports_to_block: list[P=
ort]):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.verify(blocked, &quot;=
At least one port was not blocklisted&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def no_blocklisted(self):<br>
+=C2=A0 =C2=A0 def no_blocklisted(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run testpmd with no blo=
cklisted device.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
@@ -41,7 +41,7 @@ def no_blocklisted(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.verify_blocklisted_ports([])<br>
<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def one_port_blocklisted(self):<br>
+=C2=A0 =C2=A0 def one_port_blocklisted(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run testpmd with one bl=
ocklisted port.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
@@ -52,7 +52,7 @@ def one_port_blocklisted(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.verify_blocklisted_ports(self.topolo=
gy.sut_ports[:1])<br>
<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def all_but_one_port_blocklisted(self):<br>
+=C2=A0 =C2=A0 def all_but_one_port_blocklisted(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run testpmd with all bu=
t one blocklisted port.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuit=
e_dynamic_queue_conf.py<br>
index 0e9cda1b9f..3e2f9d816f 100644<br>
--- a/dts/tests/TestSuite_dynamic_queue_conf.py<br>
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py<br>
@@ -277,24 +277,24 @@ def stop_queues(<br>
<br>
=C2=A0 =C2=A0 =C2=A0@requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def rx_queue_stop(self):<br>
+=C2=A0 =C2=A0 def rx_queue_stop(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run method for stopping=
 queues with flag for Rx testing set to :data:`True`.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stop_queues(True)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def rx_queue_configuration(self):<br>
+=C2=A0 =C2=A0 def rx_queue_configuration(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run method for configur=
ing queues with flag for Rx testing set to :data:`True`.&quot;&quot;&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.modify_ring_size(True)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def tx_queue_stop(self):<br>
+=C2=A0 =C2=A0 def tx_queue_stop(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run method for stopping=
 queues with flag for Rx testing set to :data:`False`.&quot;&quot;&quot;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stop_queues(False)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)<br>
=C2=A0 =C2=A0 =C2=A0@func_test<br>
-=C2=A0 =C2=A0 def tx_queue_configuration(self):<br>
+=C2=A0 =C2=A0 def tx_queue_configuration(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run method for configur=
ing queues with flag for Rx testing set to :data:`False`.&quot;&quot;&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.modify_ring_size(False)<br>
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/t=
ests/TestSuite_port_restart_config_persistency.py<br>
index 42ea221586..b773bdfade 100644<br>
--- a/dts/tests/TestSuite_port_restart_config_persistency.py<br>
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py<br>
@@ -21,7 +21,7 @@<br>
=C2=A0class TestPortRestartConfigPersistency(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Port config persistency test suite.&q=
uot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 def restart_port_and_verify(self, id, testpmd, changed_value=
) -&gt; None:<br>
+=C2=A0 =C2=A0 def restart_port_and_verify(self, id: int, testpmd: TestPmdS=
hell, changed_value: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Fetch port config, rest=
art and verify persistency.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testpmd.start_all_ports()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testpmd.wait_link_status_up(port_id=3Did,=
 timeout=3D10)<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000811dd2063e559272--
