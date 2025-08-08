Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA2C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 18:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056A340611;
	Fri,  8 Aug 2025 20:21:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E315640270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 20:21:15 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1373B16F8;
 Fri,  8 Aug 2025 11:21:07 -0700 (PDT)
Received: from [10.57.1.36] (unknown [10.57.1.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376A93F738;
 Fri,  8 Aug 2025 11:21:14 -0700 (PDT)
Message-ID: <9e6a703e-7662-401a-a318-235bdc0bd937@arm.com>
Date: Fri, 8 Aug 2025 19:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: type hints updated for method arguments and
 return types
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250806162900.273571-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250806162900.273571-1-abailey@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

thank you for your v2! Based on the contributing guidelines [1], any 
further version should be posted in reply to the original cover letter 
if sent, otherwise the very first patch. Please review these before you 
send the next patches.

A cover letter email is useful when there is more than one patch, but 
this is not the case. You can add a cover letter (if needed) below the 
commit description, the contributing guidelines describe this in chapter 
9.8. The most important purpose of the cover letter is to describe the 
changes you made since the last version you sent.

Still, based on the contributing guidelines the commit subject is to be 
in imperative form and concise. The original commit subject was fine, 
you had to change it to include the arguments. To keep it imperative and 
concise consider:

   dts: add missing type hints to method signatures

I notice the relevant change to .mailmap is still missing. This is 
required in order to accept any contributions.

On 06/08/2025 17:29, Andrew Bailey wrote:
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> index 4360bc8699..ba2fdf55b3 100644
> --- a/dts/framework/context.py
> +++ b/dts/framework/context.py
> @@ -4,12 +4,14 @@
>   """Runtime contexts."""
>   
>   import functools
> +from collections.abc import Callable
>   from dataclasses import MISSING, dataclass, field, fields
> -from typing import TYPE_CHECKING, ParamSpec
> +from typing import TYPE_CHECKING, ParamSpec, Type

I am wondering if you are using a wrong version of Python? In Python 
3.12, which is the version we are supporting, `type` (lowercase t) is a 
built-in keyword, and doesn't require being imported.

>   
>   from framework.exception import InternalError
>   from framework.remote_session.shell_pool import ShellPool
>   from framework.settings import SETTINGS
> +from framework.testbed_model.capability import TestProtocol
>   from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
>   from framework.testbed_model.node import Node
>   from framework.testbed_model.topology import Topology
> @@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -> None:
>   
>   def filter_cores(
>       specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
> -):
> +) -> Callable[[Callable], Callable[[], Type[TestProtocol]]]:
>       """Decorates functions that require a temporary update to the lcore specifier."""
>   
> -    def decorator(func):
> +    def decorator(func: Callable) -> Callable[[], Type[TestProtocol]]:
>           @functools.wraps(func)
> -        def wrapper(*args: P.args, **kwargs: P.kwargs):
> +        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Type[TestProtocol]:

This is not returning TestProtocol. Here func is type[TestProtocol], so 
the return type here is whatetever `type[TestProtocol]` returns when 
called. I took some time to look into this one and unfortunately it's 
not as straightforward as I hoped. I think as a compromised you could 
use Any in the end. The signatures should look like:

   filter_cores(...) -> Callable[[type[TestProtocol]], Callable]
   decorator(func: type[TestProtocol]) -> Callable:
   wrapper(...) -> Any

Doing it this way we can enforce through mypy that the decorator is only 
used with test suites and cases.

>               local_ctx = get_ctx().local
>   
>               old_specifier = local_ctx.lcore_filter_specifier
> diff --git a/dts/framework/logger.py b/dts/framework/logger.py
> index f43b442bc9..fe5737f285 100644
> --- a/dts/framework/logger.py
> +++ b/dts/framework/logger.py
> @@ -15,7 +15,7 @@
>   import logging
>   from logging import FileHandler, StreamHandler
>   from pathlib import Path
> -from typing import ClassVar
> +from typing import Any, ClassVar
>   
>   date_fmt = "%Y/%m/%d %H:%M:%S"
>   stream_fmt = "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(message)s"
> @@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):
>       _stage: ClassVar[str] = "pre_run"
>       _extra_file_handlers: list[FileHandler] = []
>   
> -    def __init__(self, *args, **kwargs):
> +    def __init__(self, *args: str, **kwargs: str) -> None:
we don't know they are str, should be Any.>           """Extend the 
constructor with extra file handlers."""
>           self._extra_file_handlers = []
>           super().__init__(*args, **kwargs)
>   
> -    def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
> +    def makeRecord(self, *args: Any, **kwargs: Any) -> logging.LogRecord:
>           """Generates a record with additional stage information.
>   
>           This is the default method for the :class:`~logging.Logger` class. We extend it
> diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
> index 1ae227d7b4..03476681ee 100644
> --- a/dts/framework/params/__init__.py
> +++ b/dts/framework/params/__init__.py
> @@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -> FnPtr:
>           FnPtr: A function that calls the given functions from left to right.
>       """
>   
> -    def reduced_fn(value):
> +    def reduced_fn(value: Any) -> Any:
looks like FnPtr should be using the generic T, in which case this can 
be reduced_fn(value: T) -> T. And FnPtr = Callable[[T], T]

And this made me realise you missed _class_decorator under modify_str

>           for fn in funcs:
>               value = fn(value)
>           return value
> diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
> index 606d6e22fe..6a0a8911c9 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -62,7 +62,7 @@ class DPDKBuildEnvironment:
> @@ -155,7 +155,7 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> None:
>               dpdk_tree_path,
>               self.remote_dpdk_tree_path,
>               exclude=[".git", "*.o"],
> -            compress_format=TarCompressionFormat.gzip,
> +            compress_format=TarCompressionFormat.gz,
This is out of the scope of this patch. Shouldn't be changed.>           )
>   
>       def _validate_remote_dpdk_tarball(self, dpdk_tarball: PurePath) -> None:
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..c80de55d34 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -90,7 +99,7 @@ class VLANOffloadFlag(Flag):
>       QINQ_STRIP = auto()
>   
>       @classmethod
> -    def from_str_dict(cls, d):
> +    def from_str_dict(cls, d: dict) -> Self:
we expect it to be dict[str, str] like the docstring suggests.> 
  """Makes an instance from a dict containing the flag member names with 
an "on" value.
>   
>           Args:
> @@ -1449,7 +1458,7 @@ def requires_stopped_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
>       """
>   
>       @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
This does not return a method, it returns whatever the method returns 
when it's called. Like I suggested in v1, you should be able to 
replicate this with a generic R variable (like for @only_active). I 
recognise now that I have been experimenting that this is really flaky 
and mypy is not interacting well with this. Please just use Any.> 
    if self.ports_started:
>               self._logger.debug("Ports need to be stopped to continue.")
>               self.stop_all_ports()
> @@ -1470,7 +1479,7 @@ def requires_started_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
>       """
>   
>       @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
as above>           if not self.ports_started:
>               self._logger.debug("Ports need to be started to continue.")
>               self.start_all_ports()
> @@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShe
>   
>       def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
>           @functools.wraps(func)
> -        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
as above>               original_mtu = self.ports[0].mtu
>               self.set_port_mtu_all(mtu=mtu, verify=False)
>               retval = func(self, *args, **kwargs)
> diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
> index f895b22bb3..db5753405b 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py
> @@ -385,7 +385,7 @@ def __eq__(self, other) -> bool:
>           """
>           return self.topology_type == other.topology_type
>   
> -    def __lt__(self, other) -> bool:
> +    def __lt__(self, other: Self) -> bool:
Unfortunately, we cannot use Self here because realistically other can 
be Any.>           """Compare the 
:attr:`~TopologyCapability.topology_type`s.
>   
>           Args:
> @@ -396,7 +396,7 @@ def __lt__(self, other) -> bool:
>           """
>           return self.topology_type < other.topology_type
>   
> -    def __gt__(self, other) -> bool:
> +    def __gt__(self, other: Self) -> bool:
as above>           """Compare the 
:attr:`~TopologyCapability.topology_type`s.
>   
>           Args:
> @@ -407,7 +407,7 @@ def __gt__(self, other) -> bool:
>           """
>           return other < self
>   
> -    def __le__(self, other) -> bool:
> +    def __le__(self, other: Self) -> bool:
as above>           """Compare the 
:attr:`~TopologyCapability.topology_type`s.
>   
>           Args:
> diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
> index b6e03aa83d..de507ffe6a 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -115,7 +115,7 @@ def __init__(
>           node_config: NodeConfiguration,
>           name: str,
>           logger: DTSLogger,
> -    ):
> +    ) -> None:
>           """Initialize the OS-aware session.
>   
>           Connect to the node right away and also create an interactive remote session.
> @@ -266,7 +266,7 @@ def copy_dir_from(
>           self,
>           source_dir: str | PurePath,
>           destination_dir: str | Path,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> None:
>           """Copy a directory from the remote node to the local filesystem.
> @@ -306,7 +306,7 @@ def copy_dir_to(
>           self,
>           source_dir: str | Path,
>           destination_dir: str | PurePath,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> None:
>           """Copy a directory from the local filesystem to the remote node.
> @@ -375,7 +375,7 @@ def remove_remote_dir(
>       def create_remote_tarball(
>           self,
>           remote_dir_path: str | PurePath,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> PurePosixPath:
>           """Create a tarball from the contents of the specified remote directory.
> diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
> index c71bc93f0b..992017f113 100644
> --- a/dts/framework/testbed_model/posix_session.py
> +++ b/dts/framework/testbed_model/posix_session.py
> @@ -15,6 +15,7 @@
>   import re
>   from collections.abc import Iterable
>   from pathlib import Path, PurePath, PurePosixPath
> +from typing import Any
>   
>   from framework.exception import DPDKBuildError, RemoteCommandExecutionError
>   from framework.settings import SETTINGS
> @@ -116,7 +117,7 @@ def copy_dir_from(
>           self,
>           source_dir: str | PurePath,
>           destination_dir: str | Path,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> None:
>           """Overrides :meth:`~.os_session.OSSession.copy_dir_from`."""
> @@ -135,7 +136,7 @@ def copy_dir_to(
>           self,
>           source_dir: str | Path,
>           destination_dir: str | PurePath,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> None:
>           """Overrides :meth:`~.os_session.OSSession.copy_dir_to`."""
> @@ -178,12 +179,12 @@ def remove_remote_dir(
>       def create_remote_tarball(
>           self,
>           remote_dir_path: str | PurePath,
> -        compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope change>           exclude: str | list[str] | None = None,
>       ) -> PurePosixPath:
>           """Overrides :meth:`~.os_session.OSSession.create_remote_tarball`."""
>   
> -        def generate_tar_exclude_args(exclude_patterns) -> str:
> +        def generate_tar_exclude_args(exclude_patterns: Any) -> str:
based on context this should be the same exact type signature as the 
`exclude` argument in the outer function.>               """Generate 
args to exclude patterns when creating a tarball.
>   
>               Args:
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
> index e21ba4ed96..40030abe7b 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -296,7 +296,7 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
>       #: Padding to add to the start of a line for python syntax compliance.
>       _python_indentation: ClassVar[str] = " " * 4
>   
> -    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs):
> +    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs) -> None:
missed kwargs, Any can go here>           """Extend the constructor with 
Scapy TG specifics.
>   
>           Initializes both the traffic generator and the interactive shell used to handle Scapy
> diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index 8f53b07daf..8b5fa98b89 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -34,7 +34,9 @@ class TrafficGenerator(ABC):
>       _tg_node: Node
>       _logger: DTSLogger
>   
> -    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
> +    def __init__(
> +        self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs: Node | TrafficGeneratorConfig
kwargs is actually unused here, so it can be removed. Otherwise we 
cannot make assumption on what it is, so it should be Any> +    ) -> None:
>           """Initialize the traffic generator.
>   
>           Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index 0c81ab1b95..51f9a3c541 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -19,7 +19,7 @@
>   import os
>   import random
>   import tarfile
> -from enum import Enum, Flag
> +from enum import Enum, Flag, auto
not needed as out of scope>   from pathlib import Path
>   from typing import Any, Callable
>   
> @@ -136,15 +136,15 @@ class TarCompressionFormat(StrEnum):
>       Its value is set to 'tar' to indicate that the file is an uncompressed tar archive.
>       """
>   
> -    none = "tar"
> -    gzip = "gz"
> -    compress = "Z"
> -    bzip2 = "bz2"
> -    lzip = "lz"
> -    lzma = "lzma"
> -    lzop = "lzo"
> -    xz = "xz"
> -    zstd = "zst"
> +    tar = auto()
> +    gz = auto()
> +    Z = auto()
> +    bz2 = auto()
> +    lz = auto()
> +    lzma = auto()
> +    lzo = auto()
> +    xz = auto()
> +    zst = auto()

I am really confused why you made this change, given it's not connected 
in any way to this commit. That point aside, this is a counterintuitive 
change. The original approach mapped common compression algorithm names 
to their corresponding file extensions. When we talk about compression 
algorithms we don't talk about them based on their extension.

>   
>       @property
>       def extension(self):
> @@ -154,7 +154,7 @@ def extension(self):
>           For other compression formats, the extension will be in the format
>           'tar.{compression format}'.
>           """
> -        return f"{self.value}" if self == self.none else f"{self.none.value}.{self.value}"
> +        return f"{self.value}" if self == self.tar else f"{self.tar.value}.{self.value}"
out of scope>
>   
>   def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
> @@ -164,7 +164,7 @@ def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
>   
>   def create_tarball(
>       dir_path: Path,
> -    compress_format: TarCompressionFormat = TarCompressionFormat.none,
> +    compress_format: TarCompressionFormat = TarCompressionFormat.tar,
out of scope>       exclude: Any | list[Any] | None = None,
>   ) -> Path:
>       """Create a tarball from the contents of the specified directory.

[1] https://doc.dpdk.org/guides/contributing/patches.html
