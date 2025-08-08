Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A938BC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 20:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ACE3402B3;
	Fri,  8 Aug 2025 22:50:08 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id EE41140270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 22:50:06 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so4663924a12.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754686206; x=1755291006; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tyoNcmq5kpIBiXwCpBvo/rUKEyKf5rJVoex+VMvlGzI=;
 b=esAiRtyNq+3aaFBdPolpkTxYHfCc7aFm+n/fflMJmL0wQh+CHGDg/oddH7lthc5oG/
 M0bNs/XgUcsd4b6wlg+hRwJ9+u7PDxeGpV+ahctBJmYQ4orTY47A1wjTJU74cnyz6cuy
 Pt88V7V7QvRxyPbNbd/D1HombqBvvVjDXzhBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754686206; x=1755291006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyoNcmq5kpIBiXwCpBvo/rUKEyKf5rJVoex+VMvlGzI=;
 b=FftZ5oqrAe8SLeZvoxDqk8/3pp2DkRialkkG4DcipubtBQ1JHgsLtMLaXsbsLFeEvJ
 T0zAt6F9fpSwo2zm6Mm3KocJJ8rKH7+Q/C3DKwHPT7r0nKNfnZB4C+k4dsPL5HD1qqKI
 gF7oHznKwz1tFAKQiKhZfKOjEoBVLg2f18YLlq+hsWOWcmQpX+WGHghv3VdbSkKP4kyZ
 P7O2VIhXTZHq+TEzB3Y3azm9kHxeWtxiH9pUj/bR+h8VQP+GH52kFdhxShe0Nmk2XNDU
 vhy+CtK58aiSAclERbaWpvFgNtTAVd7aTHGdKz+3BfPz7/4QJ+spddpK2HD00qNabrls
 f8dw==
X-Gm-Message-State: AOJu0YzZZgBvUfS2wpaK1fbPvxs0avzJzLISaHDfe/zp5i8JNbqkfl6U
 vIhYrbDU6zytZecE8ttFEUFC75zucy1b7I6VBwmOPJHVfYBIEgFf8TxYIZYFhdaJUwXpEGoZZ91
 ijgsL6EH/yTME2mRDV5eJxlJK/+33DcGlHEjGqFLPntT7TGQE0ykY
X-Gm-Gg: ASbGnct/du9K8q7oimGX29/WTDqwBkIEIkrXtFKbW3NwZTQiSPBjIKA3G9oYDBPafGJ
 8nOhhYPWR5SFIS81XHF8gOCIiBXCHO0DcwvkWeDYTN+QlklGB+5x/usAvTCG68pdEAfGtNbofo4
 LyZQzhAjIEZkpIMWzqeNXUzZ5dlQyEfN1DBpJD6si3IB/gtoA7YnckxQDUrVEOVwMMeT0EbDcrC
 3x0gZN4Czs2cYAAu3ycKetY06fLDcW3CCVlecw7vKLue7nchg==
X-Google-Smtp-Source: AGHT+IHwx/ujt6oviw4TyW5AC+1e6xdpbpv+SFWKT2r/eHJl8Um44FupZICf8C7nVNpRtJ0p93Xu5J/X0fEisgZbilI=
X-Received: by 2002:a17:906:6a10:b0:af9:8c18:c11d with SMTP id
 a640c23a62f3a-af9c63428d8mr365748366b.8.1754686206378; Fri, 08 Aug 2025
 13:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <9e6a703e-7662-401a-a318-235bdc0bd937@arm.com>
In-Reply-To: <9e6a703e-7662-401a-a318-235bdc0bd937@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 8 Aug 2025 16:49:55 -0400
X-Gm-Features: Ac12FXxUZeGgxKzcWR7p2XYrxo_qN_aP-8Q2B2lK_mRrC98bkqvglb0RiZk6MlY
Message-ID: <CABJ3N2XQ+B0hLroTPmj2dW+MQiE7O4SJ_oxUZ4oquFY=2--CcA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: type hints updated for method arguments and
 return types
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000006173a063be0b865"
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

--00000000000006173a063be0b865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Luca for the review,

Regarding the changes to the enum in utils.py, adding type hints to the
extension method revealed an underlying issue with its interaction with
mypy. Using self.none.value within the return fstring causes an error and I
will send the details over slack shortly. I had tried to get around this by
not calling value on none but could not maintain the functionality of this
method while simultaneously keeping mypy happy. Within my patch is the only
solution that I had that worked, where calling self.tar.value was fine with
the linter when using auto().

Regards,
Andrew

On Fri, Aug 8, 2025 at 2:21=E2=80=AFPM Luca Vizzarro <Luca.Vizzarro@arm.com=
> wrote:

> Hi Andrew,
>
> thank you for your v2! Based on the contributing guidelines [1], any
> further version should be posted in reply to the original cover letter
> if sent, otherwise the very first patch. Please review these before you
> send the next patches.
>
> A cover letter email is useful when there is more than one patch, but
> this is not the case. You can add a cover letter (if needed) below the
> commit description, the contributing guidelines describe this in chapter
> 9.8. The most important purpose of the cover letter is to describe the
> changes you made since the last version you sent.
>
> Still, based on the contributing guidelines the commit subject is to be
> in imperative form and concise. The original commit subject was fine,
> you had to change it to include the arguments. To keep it imperative and
> concise consider:
>
>    dts: add missing type hints to method signatures
>
> I notice the relevant change to .mailmap is still missing. This is
> required in order to accept any contributions.
>
> On 06/08/2025 17:29, Andrew Bailey wrote:
> > diff --git a/dts/framework/context.py b/dts/framework/context.py
> > index 4360bc8699..ba2fdf55b3 100644
> > --- a/dts/framework/context.py
> > +++ b/dts/framework/context.py
> > @@ -4,12 +4,14 @@
> >   """Runtime contexts."""
> >
> >   import functools
> > +from collections.abc import Callable
> >   from dataclasses import MISSING, dataclass, field, fields
> > -from typing import TYPE_CHECKING, ParamSpec
> > +from typing import TYPE_CHECKING, ParamSpec, Type
>
> I am wondering if you are using a wrong version of Python? In Python
> 3.12, which is the version we are supporting, `type` (lowercase t) is a
> built-in keyword, and doesn't require being imported.
>
> >
> >   from framework.exception import InternalError
> >   from framework.remote_session.shell_pool import ShellPool
> >   from framework.settings import SETTINGS
> > +from framework.testbed_model.capability import TestProtocol
> >   from framework.testbed_model.cpu import LogicalCoreCount,
> LogicalCoreList
> >   from framework.testbed_model.node import Node
> >   from framework.testbed_model.topology import Topology
> > @@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -> None:
> >
> >   def filter_cores(
> >       specifier: LogicalCoreCount | LogicalCoreList, ascending_cores:
> bool | None =3D None
> > -):
> > +) -> Callable[[Callable], Callable[[], Type[TestProtocol]]]:
> >       """Decorates functions that require a temporary update to the
> lcore specifier."""
> >
> > -    def decorator(func):
> > +    def decorator(func: Callable) -> Callable[[], Type[TestProtocol]]:
> >           @functools.wraps(func)
> > -        def wrapper(*args: P.args, **kwargs: P.kwargs):
> > +        def wrapper(*args: P.args, **kwargs: P.kwargs) ->
> Type[TestProtocol]:
>
> This is not returning TestProtocol. Here func is type[TestProtocol], so
> the return type here is whatetever `type[TestProtocol]` returns when
> called. I took some time to look into this one and unfortunately it's
> not as straightforward as I hoped. I think as a compromised you could
> use Any in the end. The signatures should look like:
>
>    filter_cores(...) -> Callable[[type[TestProtocol]], Callable]
>    decorator(func: type[TestProtocol]) -> Callable:
>    wrapper(...) -> Any
>
> Doing it this way we can enforce through mypy that the decorator is only
> used with test suites and cases.
>
> >               local_ctx =3D get_ctx().local
> >
> >               old_specifier =3D local_ctx.lcore_filter_specifier
> > diff --git a/dts/framework/logger.py b/dts/framework/logger.py
> > index f43b442bc9..fe5737f285 100644
> > --- a/dts/framework/logger.py
> > +++ b/dts/framework/logger.py
> > @@ -15,7 +15,7 @@
> >   import logging
> >   from logging import FileHandler, StreamHandler
> >   from pathlib import Path
> > -from typing import ClassVar
> > +from typing import Any, ClassVar
> >
> >   date_fmt =3D "%Y/%m/%d %H:%M:%S"
> >   stream_fmt =3D "%(asctime)s - %(stage)s - %(name)s - %(levelname)s -
> %(message)s"
> > @@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):
> >       _stage: ClassVar[str] =3D "pre_run"
> >       _extra_file_handlers: list[FileHandler] =3D []
> >
> > -    def __init__(self, *args, **kwargs):
> > +    def __init__(self, *args: str, **kwargs: str) -> None:
> we don't know they are str, should be Any.>           """Extend the
> constructor with extra file handlers."""
> >           self._extra_file_handlers =3D []
> >           super().__init__(*args, **kwargs)
> >
> > -    def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
> > +    def makeRecord(self, *args: Any, **kwargs: Any) ->
> logging.LogRecord:
> >           """Generates a record with additional stage information.
> >
> >           This is the default method for the :class:`~logging.Logger`
> class. We extend it
> > diff --git a/dts/framework/params/__init__.py
> b/dts/framework/params/__init__.py
> > index 1ae227d7b4..03476681ee 100644
> > --- a/dts/framework/params/__init__.py
> > +++ b/dts/framework/params/__init__.py
> > @@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -> FnPt=
r:
> >           FnPtr: A function that calls the given functions from left to
> right.
> >       """
> >
> > -    def reduced_fn(value):
> > +    def reduced_fn(value: Any) -> Any:
> looks like FnPtr should be using the generic T, in which case this can
> be reduced_fn(value: T) -> T. And FnPtr =3D Callable[[T], T]
>
> And this made me realise you missed _class_decorator under modify_str
>
> >           for fn in funcs:
> >               value =3D fn(value)
> >           return value
> > diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> > index 606d6e22fe..6a0a8911c9 100644
> > --- a/dts/framework/remote_session/dpdk.py
> > +++ b/dts/framework/remote_session/dpdk.py
> > @@ -62,7 +62,7 @@ class DPDKBuildEnvironment:
> > @@ -155,7 +155,7 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) ->
> None:
> >               dpdk_tree_path,
> >               self.remote_dpdk_tree_path,
> >               exclude=3D[".git", "*.o"],
> > -            compress_format=3DTarCompressionFormat.gzip,
> > +            compress_format=3DTarCompressionFormat.gz,
> This is out of the scope of this patch. Shouldn't be changed.>           =
)
> >
> >       def _validate_remote_dpdk_tarball(self, dpdk_tarball: PurePath) -=
>
> None:
> > diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> > index ad8cb273dc..c80de55d34 100644
> > --- a/dts/framework/remote_session/testpmd_shell.py
> > +++ b/dts/framework/remote_session/testpmd_shell.py
> > @@ -90,7 +99,7 @@ class VLANOffloadFlag(Flag):
> >       QINQ_STRIP =3D auto()
> >
> >       @classmethod
> > -    def from_str_dict(cls, d):
> > +    def from_str_dict(cls, d: dict) -> Self:
> we expect it to be dict[str, str] like the docstring suggests.>
>   """Makes an instance from a dict containing the flag member names with
> an "on" value.
> >
> >           Args:
> > @@ -1449,7 +1458,7 @@ def requires_stopped_ports(func:
> TestPmdShellMethod) -> TestPmdShellMethod:
> >       """
> >
> >       @functools.wraps(func)
> > -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs):
> > +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs) -> TestPmdShellMethod:
> This does not return a method, it returns whatever the method returns
> when it's called. Like I suggested in v1, you should be able to
> replicate this with a generic R variable (like for @only_active). I
> recognise now that I have been experimenting that this is really flaky
> and mypy is not interacting well with this. Please just use Any.>
>     if self.ports_started:
> >               self._logger.debug("Ports need to be stopped to continue.=
")
> >               self.stop_all_ports()
> > @@ -1470,7 +1479,7 @@ def requires_started_ports(func:
> TestPmdShellMethod) -> TestPmdShellMethod:
> >       """
> >
> >       @functools.wraps(func)
> > -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs):
> > +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs) -> TestPmdShellMethod:
> as above>           if not self.ports_started:
> >               self._logger.debug("Ports need to be started to continue.=
")
> >               self.start_all_ports()
> > @@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int =3D 1500) ->
> Callable[[TestPmdShellMethod], TestPmdShe
> >
> >       def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
> >           @functools.wraps(func)
> > -        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs):
> > +        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs:
> P.kwargs) -> TestPmdShellMethod:
> as above>               original_mtu =3D self.ports[0].mtu
> >               self.set_port_mtu_all(mtu=3Dmtu, verify=3DFalse)
> >               retval =3D func(self, *args, **kwargs)
> > diff --git a/dts/framework/testbed_model/capability.py
> b/dts/framework/testbed_model/capability.py
> > index f895b22bb3..db5753405b 100644
> > --- a/dts/framework/testbed_model/capability.py
> > +++ b/dts/framework/testbed_model/capability.py
> > @@ -385,7 +385,7 @@ def __eq__(self, other) -> bool:
> >           """
> >           return self.topology_type =3D=3D other.topology_type
> >
> > -    def __lt__(self, other) -> bool:
> > +    def __lt__(self, other: Self) -> bool:
> Unfortunately, we cannot use Self here because realistically other can
> be Any.>           """Compare the
> :attr:`~TopologyCapability.topology_type`s.
> >
> >           Args:
> > @@ -396,7 +396,7 @@ def __lt__(self, other) -> bool:
> >           """
> >           return self.topology_type < other.topology_type
> >
> > -    def __gt__(self, other) -> bool:
> > +    def __gt__(self, other: Self) -> bool:
> as above>           """Compare the
> :attr:`~TopologyCapability.topology_type`s.
> >
> >           Args:
> > @@ -407,7 +407,7 @@ def __gt__(self, other) -> bool:
> >           """
> >           return other < self
> >
> > -    def __le__(self, other) -> bool:
> > +    def __le__(self, other: Self) -> bool:
> as above>           """Compare the
> :attr:`~TopologyCapability.topology_type`s.
> >
> >           Args:
> > diff --git a/dts/framework/testbed_model/os_session.py
> b/dts/framework/testbed_model/os_session.py
> > index b6e03aa83d..de507ffe6a 100644
> > --- a/dts/framework/testbed_model/os_session.py
> > +++ b/dts/framework/testbed_model/os_session.py
> > @@ -115,7 +115,7 @@ def __init__(
> >           node_config: NodeConfiguration,
> >           name: str,
> >           logger: DTSLogger,
> > -    ):
> > +    ) -> None:
> >           """Initialize the OS-aware session.
> >
> >           Connect to the node right away and also create an interactive
> remote session.
> > @@ -266,7 +266,7 @@ def copy_dir_from(
> >           self,
> >           source_dir: str | PurePath,
> >           destination_dir: str | Path,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> None:
> >           """Copy a directory from the remote node to the local
> filesystem.
> > @@ -306,7 +306,7 @@ def copy_dir_to(
> >           self,
> >           source_dir: str | Path,
> >           destination_dir: str | PurePath,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> None:
> >           """Copy a directory from the local filesystem to the remote
> node.
> > @@ -375,7 +375,7 @@ def remove_remote_dir(
> >       def create_remote_tarball(
> >           self,
> >           remote_dir_path: str | PurePath,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> PurePosixPath:
> >           """Create a tarball from the contents of the specified remote
> directory.
> > diff --git a/dts/framework/testbed_model/posix_session.py
> b/dts/framework/testbed_model/posix_session.py
> > index c71bc93f0b..992017f113 100644
> > --- a/dts/framework/testbed_model/posix_session.py
> > +++ b/dts/framework/testbed_model/posix_session.py
> > @@ -15,6 +15,7 @@
> >   import re
> >   from collections.abc import Iterable
> >   from pathlib import Path, PurePath, PurePosixPath
> > +from typing import Any
> >
> >   from framework.exception import DPDKBuildError,
> RemoteCommandExecutionError
> >   from framework.settings import SETTINGS
> > @@ -116,7 +117,7 @@ def copy_dir_from(
> >           self,
> >           source_dir: str | PurePath,
> >           destination_dir: str | Path,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> None:
> >           """Overrides :meth:`~.os_session.OSSession.copy_dir_from`."""
> > @@ -135,7 +136,7 @@ def copy_dir_to(
> >           self,
> >           source_dir: str | Path,
> >           destination_dir: str | PurePath,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> None:
> >           """Overrides :meth:`~.os_session.OSSession.copy_dir_to`."""
> > @@ -178,12 +179,12 @@ def remove_remote_dir(
> >       def create_remote_tarball(
> >           self,
> >           remote_dir_path: str | PurePath,
> > -        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.none,
> > +        compress_format: TarCompressionFormat =3D
> TarCompressionFormat.tar,
> out of scope change>           exclude: str | list[str] | None =3D None,
> >       ) -> PurePosixPath:
> >           """Overrides
> :meth:`~.os_session.OSSession.create_remote_tarball`."""
> >
> > -        def generate_tar_exclude_args(exclude_patterns) -> str:
> > +        def generate_tar_exclude_args(exclude_patterns: Any) -> str:
> based on context this should be the same exact type signature as the
> `exclude` argument in the outer function.>               """Generate
> args to exclude patterns when creating a tarball.
> >
> >               Args:
> > diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py
> b/dts/framework/testbed_model/traffic_generator/scapy.py
> > index e21ba4ed96..40030abe7b 100644
> > --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> > +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> > @@ -296,7 +296,7 @@ class also extends
> :class:`.capturing_traffic_generator.CapturingTrafficGenerato
> >       #: Padding to add to the start of a line for python syntax
> compliance.
> >       _python_indentation: ClassVar[str] =3D " " * 4
> >
> > -    def __init__(self, tg_node: Node, config:
> ScapyTrafficGeneratorConfig, **kwargs):
> > +    def __init__(self, tg_node: Node, config:
> ScapyTrafficGeneratorConfig, **kwargs) -> None:
> missed kwargs, Any can go here>           """Extend the constructor with
> Scapy TG specifics.
> >
> >           Initializes both the traffic generator and the interactive
> shell used to handle Scapy
> > diff --git
> a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> > index 8f53b07daf..8b5fa98b89 100644
> > --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.p=
y
> > +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.p=
y
> > @@ -34,7 +34,9 @@ class TrafficGenerator(ABC):
> >       _tg_node: Node
> >       _logger: DTSLogger
> >
> > -    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig,
> **kwargs):
> > +    def __init__(
> > +        self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs:
> Node | TrafficGeneratorConfig
> kwargs is actually unused here, so it can be removed. Otherwise we
> cannot make assumption on what it is, so it should be Any> +    ) -> None=
:
> >           """Initialize the traffic generator.
> >
> >           Additional keyword arguments can be passed through `kwargs` i=
f
> needed for fulfilling other
> > diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> > index 0c81ab1b95..51f9a3c541 100644
> > --- a/dts/framework/utils.py
> > +++ b/dts/framework/utils.py
> > @@ -19,7 +19,7 @@
> >   import os
> >   import random
> >   import tarfile
> > -from enum import Enum, Flag
> > +from enum import Enum, Flag, auto
> not needed as out of scope>   from pathlib import Path
> >   from typing import Any, Callable
> >
> > @@ -136,15 +136,15 @@ class TarCompressionFormat(StrEnum):
> >       Its value is set to 'tar' to indicate that the file is an
> uncompressed tar archive.
> >       """
> >
> > -    none =3D "tar"
> > -    gzip =3D "gz"
> > -    compress =3D "Z"
> > -    bzip2 =3D "bz2"
> > -    lzip =3D "lz"
> > -    lzma =3D "lzma"
> > -    lzop =3D "lzo"
> > -    xz =3D "xz"
> > -    zstd =3D "zst"
> > +    tar =3D auto()
> > +    gz =3D auto()
> > +    Z =3D auto()
> > +    bz2 =3D auto()
> > +    lz =3D auto()
> > +    lzma =3D auto()
> > +    lzo =3D auto()
> > +    xz =3D auto()
> > +    zst =3D auto()
>
> I am really confused why you made this change, given it's not connected
> in any way to this commit. That point aside, this is a counterintuitive
> change. The original approach mapped common compression algorithm names
> to their corresponding file extensions. When we talk about compression
> algorithms we don't talk about them based on their extension.
>
> >
> >       @property
> >       def extension(self):
> > @@ -154,7 +154,7 @@ def extension(self):
> >           For other compression formats, the extension will be in the
> format
> >           'tar.{compression format}'.
> >           """
> > -        return f"{self.value}" if self =3D=3D self.none else
> f"{self.none.value}.{self.value}"
> > +        return f"{self.value}" if self =3D=3D self.tar else
> f"{self.tar.value}.{self.value}"
> out of scope>
> >
> >   def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
> > @@ -164,7 +164,7 @@ def convert_to_list_of_string(value: Any |
> list[Any]) -> list[str]:
> >
> >   def create_tarball(
> >       dir_path: Path,
> > -    compress_format: TarCompressionFormat =3D TarCompressionFormat.non=
e,
> > +    compress_format: TarCompressionFormat =3D TarCompressionFormat.tar=
,
> out of scope>       exclude: Any | list[Any] | None =3D None,
> >   ) -> Path:
> >       """Create a tarball from the contents of the specified directory.
>
> [1] https://doc.dpdk.org/guides/contributing/patches.html
>

--00000000000006173a063be0b865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Luca for the review,<div><br></div><div>Regardin=
g the changes to the enum in utils.py, adding=C2=A0type hints to the extens=
ion method revealed an underlying issue with its interaction with mypy. Usi=
ng self.none.value within the return fstring causes an error and I will sen=
d the details over slack shortly. I had tried to get around this by not cal=
ling value on none but could not maintain the functionality of this method =
while simultaneously keeping mypy happy. Within my patch is the only soluti=
on that I had that worked, where calling self.tar.value was fine with the l=
inter when using auto().</div><div><br></div><div>Regards,=C2=A0</div><div>=
Andrew</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 8, 2025 at 2:21=E2=80=AFPM Lu=
ca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@arm.com">Luca.Vizzarro@arm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi Andrew,<br>
<br>
thank you for your v2! Based on the contributing guidelines [1], any <br>
further version should be posted in reply to the original cover letter <br>
if sent, otherwise the very first patch. Please review these before you <br=
>
send the next patches.<br>
<br>
A cover letter email is useful when there is more than one patch, but <br>
this is not the case. You can add a cover letter (if needed) below the <br>
commit description, the contributing guidelines describe this in chapter <b=
r>
9.8. The most important purpose of the cover letter is to describe the <br>
changes you made since the last version you sent.<br>
<br>
Still, based on the contributing guidelines the commit subject is to be <br=
>
in imperative form and concise. The original commit subject was fine, <br>
you had to change it to include the arguments. To keep it imperative and <b=
r>
concise consider:<br>
<br>
=C2=A0 =C2=A0dts: add missing type hints to method signatures<br>
<br>
I notice the relevant change to .mailmap is still missing. This is <br>
required in order to accept any contributions.<br>
<br>
On 06/08/2025 17:29, Andrew Bailey wrote:<br>
&gt; diff --git a/dts/framework/context.py b/dts/framework/context.py<br>
&gt; index 4360bc8699..ba2fdf55b3 100644<br>
&gt; --- a/dts/framework/context.py<br>
&gt; +++ b/dts/framework/context.py<br>
&gt; @@ -4,12 +4,14 @@<br>
&gt;=C2=A0 =C2=A0&quot;&quot;&quot;Runtime contexts.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0import functools<br>
&gt; +from collections.abc import Callable<br>
&gt;=C2=A0 =C2=A0from dataclasses import MISSING, dataclass, field, fields<=
br>
&gt; -from typing import TYPE_CHECKING, ParamSpec<br>
&gt; +from typing import TYPE_CHECKING, ParamSpec, Type<br>
<br>
I am wondering if you are using a wrong version of Python? In Python <br>
3.12, which is the version we are supporting, `type` (lowercase t) is a <br=
>
built-in keyword, and doesn&#39;t require being imported.<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0from framework.exception import InternalError<br>
&gt;=C2=A0 =C2=A0from framework.remote_session.shell_pool import ShellPool<=
br>
&gt;=C2=A0 =C2=A0from framework.settings import SETTINGS<br>
&gt; +from framework.testbed_model.capability import TestProtocol<br>
&gt;=C2=A0 =C2=A0from framework.testbed_model.cpu import LogicalCoreCount, =
LogicalCoreList<br>
&gt;=C2=A0 =C2=A0from framework.testbed_model.node import Node<br>
&gt;=C2=A0 =C2=A0from framework.testbed_model.topology import Topology<br>
&gt; @@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -&gt; None:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0def filter_cores(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0specifier: LogicalCoreCount | LogicalCoreLis=
t, ascending_cores: bool | None =3D None<br>
&gt; -):<br>
&gt; +) -&gt; Callable[[Callable], Callable[[], Type[TestProtocol]]]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Decorates functions that r=
equire a temporary update to the lcore specifier.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def decorator(func):<br>
&gt; +=C2=A0 =C2=A0 def decorator(func: Callable) -&gt; Callable[[], Type[T=
estProtocol]]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(*args: P.args, **kwargs: P.kw=
args):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(*args: P.args, **kwargs: P.kw=
args) -&gt; Type[TestProtocol]:<br>
<br>
This is not returning TestProtocol. Here func is type[TestProtocol], so <br=
>
the return type here is whatetever `type[TestProtocol]` returns when <br>
called. I took some time to look into this one and unfortunately it&#39;s <=
br>
not as straightforward as I hoped. I think as a compromised you could <br>
use Any in the end. The signatures should look like:<br>
<br>
=C2=A0 =C2=A0filter_cores(...) -&gt; Callable[[type[TestProtocol]], Callabl=
e]<br>
=C2=A0 =C2=A0decorator(func: type[TestProtocol]) -&gt; Callable:<br>
=C2=A0 =C2=A0wrapper(...) -&gt; Any<br>
<br>
Doing it this way we can enforce through mypy that the decorator is only <b=
r>
used with test suites and cases.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_ctx =3D ge=
t_ctx().local<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_specifier =
=3D local_ctx.lcore_filter_specifier<br>
&gt; diff --git a/dts/framework/logger.py b/dts/framework/logger.py<br>
&gt; index f43b442bc9..fe5737f285 100644<br>
&gt; --- a/dts/framework/logger.py<br>
&gt; +++ b/dts/framework/logger.py<br>
&gt; @@ -15,7 +15,7 @@<br>
&gt;=C2=A0 =C2=A0import logging<br>
&gt;=C2=A0 =C2=A0from logging import FileHandler, StreamHandler<br>
&gt;=C2=A0 =C2=A0from pathlib import Path<br>
&gt; -from typing import ClassVar<br>
&gt; +from typing import Any, ClassVar<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0date_fmt =3D &quot;%Y/%m/%d %H:%M:%S&quot;<br>
&gt;=C2=A0 =C2=A0stream_fmt =3D &quot;%(asctime)s - %(stage)s - %(name)s - =
%(levelname)s - %(message)s&quot;<br>
&gt; @@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0_stage: ClassVar[str] =3D &quot;pre_run&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0_extra_file_handlers: list[FileHandler] =3D =
[]<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __init__(self, *args, **kwargs):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, *args: str, **kwargs: str) -&gt; Non=
e:<br>
we don&#39;t know they are str, should be Any.&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Extend the <br>
constructor with extra file handlers.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._extra_file_handlers =3D =
[]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(*args, **kwar=
gs)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def makeRecord(self, *args, **kwargs) -&gt; logging.Log=
Record:<br>
&gt; +=C2=A0 =C2=A0 def makeRecord(self, *args: Any, **kwargs: Any) -&gt; l=
ogging.LogRecord:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Generates a =
record with additional stage information.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is the default method for=
 the :class:`~logging.Logger` class. We extend it<br>
&gt; diff --git a/dts/framework/params/__init__.py b/dts/framework/params/_=
_init__.py<br>
&gt; index 1ae227d7b4..03476681ee 100644<br>
&gt; --- a/dts/framework/params/__init__.py<br>
&gt; +++ b/dts/framework/params/__init__.py<br>
&gt; @@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -&gt; =
FnPtr:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FnPtr: A function that calls t=
he given functions from left to right.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def reduced_fn(value):<br>
&gt; +=C2=A0 =C2=A0 def reduced_fn(value: Any) -&gt; Any:<br>
looks like FnPtr should be using the generic T, in which case this can <br>
be reduced_fn(value: T) -&gt; T. And FnPtr =3D Callable[[T], T]<br>
<br>
And this made me realise you missed _class_decorator under modify_str<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fn in funcs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D fn(val=
ue)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return value<br>
&gt; diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remo=
te_session/dpdk.py<br>
&gt; index 606d6e22fe..6a0a8911c9 100644<br>
&gt; --- a/dts/framework/remote_session/dpdk.py<br>
&gt; +++ b/dts/framework/remote_session/dpdk.py<br>
&gt; @@ -62,7 +62,7 @@ class DPDKBuildEnvironment:<br>
&gt; @@ -155,7 +155,7 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) -&=
gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_tree_path,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.remote_dpdk=
_tree_path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude=3D[&quot=
;.git&quot;, &quot;*.o&quot;],<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format=3DTarCompre=
ssionFormat.gzip,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format=3DTarCompre=
ssionFormat.gz,<br>
This is out of the scope of this patch. Shouldn&#39;t be changed.&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def _validate_remote_dpdk_tarball(self, dpdk=
_tarball: PurePath) -&gt; None:<br>
&gt; diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/frame=
work/remote_session/testpmd_shell.py<br>
&gt; index ad8cb273dc..c80de55d34 100644<br>
&gt; --- a/dts/framework/remote_session/testpmd_shell.py<br>
&gt; +++ b/dts/framework/remote_session/testpmd_shell.py<br>
&gt; @@ -90,7 +99,7 @@ class VLANOffloadFlag(Flag):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QINQ_STRIP =3D auto()<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@classmethod<br>
&gt; -=C2=A0 =C2=A0 def from_str_dict(cls, d):<br>
&gt; +=C2=A0 =C2=A0 def from_str_dict(cls, d: dict) -&gt; Self:<br>
we expect it to be dict[str, str] like the docstring suggests.&gt; <br>
=C2=A0 &quot;&quot;&quot;Makes an instance from a dict containing the flag =
member names with <br>
an &quot;on&quot; value.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
&gt; @@ -1449,7 +1458,7 @@ def requires_stopped_ports(func: TestPmdShellMet=
hod) -&gt; TestPmdShellMethod:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
&gt; -=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.a=
rgs, **kwargs: P.kwargs):<br>
&gt; +=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.a=
rgs, **kwargs: P.kwargs) -&gt; TestPmdShellMethod:<br>
This does not return a method, it returns whatever the method returns <br>
when it&#39;s called. Like I suggested in v1, you should be able to <br>
replicate this with a generic R variable (like for @only_active). I <br>
recognise now that I have been experimenting that this is really flaky <br>
and mypy is not interacting well with this. Please just use Any.&gt; <br>
=C2=A0 =C2=A0 if self.ports_started:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.deb=
ug(&quot;Ports need to be stopped to continue.&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.stop_all_po=
rts()<br>
&gt; @@ -1470,7 +1479,7 @@ def requires_started_ports(func: TestPmdShellMet=
hod) -&gt; TestPmdShellMethod:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
&gt; -=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.a=
rgs, **kwargs: P.kwargs):<br>
&gt; +=C2=A0 =C2=A0 def _wrapper(self: &quot;TestPmdShell&quot;, *args: P.a=
rgs, **kwargs: P.kwargs) -&gt; TestPmdShellMethod:<br>
as above&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.ports_star=
ted:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.deb=
ug(&quot;Ports need to be started to continue.&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.start_all_p=
orts()<br>
&gt; @@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int =3D 1500) -&gt; Call=
able[[TestPmdShellMethod], TestPmdShe<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def decorator(func: TestPmdShellMethod) -&gt=
; TestPmdShellMethod:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmdShell&quot=
;, *args: P.args, **kwargs: P.kwargs):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def wrapper(self: &quot;TestPmdShell&quot=
;, *args: P.args, **kwargs: P.kwargs) -&gt; TestPmdShellMethod:<br>
as above&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0original=
_mtu =3D self.ports[0].mtu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.set_port_mt=
u_all(mtu=3Dmtu, verify=3DFalse)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D func(=
self, *args, **kwargs)<br>
&gt; diff --git a/dts/framework/testbed_model/capability.py b/dts/framework=
/testbed_model/capability.py<br>
&gt; index f895b22bb3..db5753405b 100644<br>
&gt; --- a/dts/framework/testbed_model/capability.py<br>
&gt; +++ b/dts/framework/testbed_model/capability.py<br>
&gt; @@ -385,7 +385,7 @@ def __eq__(self, other) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.topology_type =3D=
=3D other.topology_type<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __lt__(self, other) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 def __lt__(self, other: Self) -&gt; bool:<br>
Unfortunately, we cannot use Self here because realistically other can <br>
be Any.&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Compa=
re the <br>
:attr:`~TopologyCapability.topology_type`s.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
&gt; @@ -396,7 +396,7 @@ def __lt__(self, other) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.topology_type &lt;=
 other.topology_type<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __gt__(self, other) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 def __gt__(self, other: Self) -&gt; bool:<br>
as above&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Comp=
are the <br>
:attr:`~TopologyCapability.topology_type`s.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
&gt; @@ -407,7 +407,7 @@ def __gt__(self, other) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return other &lt; self<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __le__(self, other) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 def __le__(self, other: Self) -&gt; bool:<br>
as above&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Comp=
are the <br>
:attr:`~TopologyCapability.topology_type`s.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
&gt; diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework=
/testbed_model/os_session.py<br>
&gt; index b6e03aa83d..de507ffe6a 100644<br>
&gt; --- a/dts/framework/testbed_model/os_session.py<br>
&gt; +++ b/dts/framework/testbed_model/os_session.py<br>
&gt; @@ -115,7 +115,7 @@ def __init__(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_config: NodeConfiguration=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger: DTSLogger,<br>
&gt; -=C2=A0 =C2=A0 ):<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize t=
he OS-aware session.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Connect to the node right away=
 and also create an interactive remote session.<br>
&gt; @@ -266,7 +266,7 @@ def copy_dir_from(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_dir: str | PurePath,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destination_dir: str | Path,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Copy a direc=
tory from the remote node to the local filesystem.<br>
&gt; @@ -306,7 +306,7 @@ def copy_dir_to(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_dir: str | Path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destination_dir: str | PurePat=
h,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Copy a direc=
tory from the local filesystem to the remote node.<br>
&gt; @@ -375,7 +375,7 @@ def remove_remote_dir(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def create_remote_tarball(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote_dir_path: str | PurePat=
h,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; PurePosixPath:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Create a tar=
ball from the contents of the specified remote directory.<br>
&gt; diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framew=
ork/testbed_model/posix_session.py<br>
&gt; index c71bc93f0b..992017f113 100644<br>
&gt; --- a/dts/framework/testbed_model/posix_session.py<br>
&gt; +++ b/dts/framework/testbed_model/posix_session.py<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt;=C2=A0 =C2=A0import re<br>
&gt;=C2=A0 =C2=A0from collections.abc import Iterable<br>
&gt;=C2=A0 =C2=A0from pathlib import Path, PurePath, PurePosixPath<br>
&gt; +from typing import Any<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0from framework.exception import DPDKBuildError, RemoteComm=
andExecutionError<br>
&gt;=C2=A0 =C2=A0from framework.settings import SETTINGS<br>
&gt; @@ -116,7 +117,7 @@ def copy_dir_from(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_dir: str | PurePath,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destination_dir: str | Path,<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :m=
eth:`~.os_session.OSSession.copy_dir_from`.&quot;&quot;&quot;<br>
&gt; @@ -135,7 +136,7 @@ def copy_dir_to(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0source_dir: str | Path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destination_dir: str | PurePat=
h,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :m=
eth:`~.os_session.OSSession.copy_dir_to`.&quot;&quot;&quot;<br>
&gt; @@ -178,12 +179,12 @@ def remove_remote_dir(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def create_remote_tarball(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote_dir_path: str | PurePat=
h,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.none,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D=
 TarCompressionFormat.tar,<br>
out of scope change&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: st=
r | list[str] | None =3D None,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; PurePosixPath:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :m=
eth:`~.os_session.OSSession.create_remote_tarball`.&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def generate_tar_exclude_args(exclude_pat=
terns) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def generate_tar_exclude_args(exclude_pat=
terns: Any) -&gt; str:<br>
based on context this should be the same exact type signature as the <br>
`exclude` argument in the outer function.&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Generate <br>
args to exclude patterns when creating a tarball.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
&gt; diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/=
dts/framework/testbed_model/traffic_generator/scapy.py<br>
&gt; index e21ba4ed96..40030abe7b 100644<br>
&gt; --- a/dts/framework/testbed_model/traffic_generator/scapy.py<br>
&gt; +++ b/dts/framework/testbed_model/traffic_generator/scapy.py<br>
&gt; @@ -296,7 +296,7 @@ class also extends :class:`.capturing_traffic_gene=
rator.CapturingTrafficGenerato<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#: Padding to add to the start of a line for=
 python syntax compliance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0_python_indentation: ClassVar[str] =3D &quot=
; &quot; * 4<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: ScapyTrafficG=
eneratorConfig, **kwargs):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: ScapyTrafficG=
eneratorConfig, **kwargs) -&gt; None:<br>
missed kwargs, Any can go here&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;&quot;&quot;Extend the constructor with <br>
Scapy TG specifics.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Initializes both the traffic g=
enerator and the interactive shell used to handle Scapy<br>
&gt; diff --git a/dts/framework/testbed_model/traffic_generator/traffic_gen=
erator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator=
.py<br>
&gt; index 8f53b07daf..8b5fa98b89 100644<br>
&gt; --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.=
py<br>
&gt; +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.=
py<br>
&gt; @@ -34,7 +34,9 @@ class TrafficGenerator(ABC):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0_tg_node: Node<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 def __init__(self, tg_node: Node, config: TrafficGenera=
torConfig, **kwargs):<br>
&gt; +=C2=A0 =C2=A0 def __init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, tg_node: Node, config: TrafficGener=
atorConfig, **kwargs: Node | TrafficGeneratorConfig<br>
kwargs is actually unused here, so it can be removed. Otherwise we <br>
cannot make assumption on what it is, so it should be Any&gt; +=C2=A0 =C2=
=A0 ) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize t=
he traffic generator.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Additional keyword arguments c=
an be passed through `kwargs` if needed for fulfilling other<br>
&gt; diff --git a/dts/framework/utils.py b/dts/framework/utils.py<br>
&gt; index 0c81ab1b95..51f9a3c541 100644<br>
&gt; --- a/dts/framework/utils.py<br>
&gt; +++ b/dts/framework/utils.py<br>
&gt; @@ -19,7 +19,7 @@<br>
&gt;=C2=A0 =C2=A0import os<br>
&gt;=C2=A0 =C2=A0import random<br>
&gt;=C2=A0 =C2=A0import tarfile<br>
&gt; -from enum import Enum, Flag<br>
&gt; +from enum import Enum, Flag, auto<br>
not needed as out of scope&gt;=C2=A0 =C2=A0from pathlib import Path<br>
&gt;=C2=A0 =C2=A0from typing import Any, Callable<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -136,15 +136,15 @@ class TarCompressionFormat(StrEnum):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Its value is set to &#39;tar&#39; to indicat=
e that the file is an uncompressed tar archive.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 none =3D &quot;tar&quot;<br>
&gt; -=C2=A0 =C2=A0 gzip =3D &quot;gz&quot;<br>
&gt; -=C2=A0 =C2=A0 compress =3D &quot;Z&quot;<br>
&gt; -=C2=A0 =C2=A0 bzip2 =3D &quot;bz2&quot;<br>
&gt; -=C2=A0 =C2=A0 lzip =3D &quot;lz&quot;<br>
&gt; -=C2=A0 =C2=A0 lzma =3D &quot;lzma&quot;<br>
&gt; -=C2=A0 =C2=A0 lzop =3D &quot;lzo&quot;<br>
&gt; -=C2=A0 =C2=A0 xz =3D &quot;xz&quot;<br>
&gt; -=C2=A0 =C2=A0 zstd =3D &quot;zst&quot;<br>
&gt; +=C2=A0 =C2=A0 tar =3D auto()<br>
&gt; +=C2=A0 =C2=A0 gz =3D auto()<br>
&gt; +=C2=A0 =C2=A0 Z =3D auto()<br>
&gt; +=C2=A0 =C2=A0 bz2 =3D auto()<br>
&gt; +=C2=A0 =C2=A0 lz =3D auto()<br>
&gt; +=C2=A0 =C2=A0 lzma =3D auto()<br>
&gt; +=C2=A0 =C2=A0 lzo =3D auto()<br>
&gt; +=C2=A0 =C2=A0 xz =3D auto()<br>
&gt; +=C2=A0 =C2=A0 zst =3D auto()<br>
<br>
I am really confused why you made this change, given it&#39;s not connected=
 <br>
in any way to this commit. That point aside, this is a counterintuitive <br=
>
change. The original approach mapped common compression algorithm names <br=
>
to their corresponding file extensions. When we talk about compression <br>
algorithms we don&#39;t talk about them based on their extension.<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@property<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def extension(self):<br>
&gt; @@ -154,7 +154,7 @@ def extension(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For other compression formats,=
 the extension will be in the format<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tar.{compression format}&=
#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =
=3D=3D self.none else f&quot;{self.none.value}.{self.value}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =
=3D=3D self.tar else f&quot;{self.tar.value}.{self.value}&quot;<br>
out of scope&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0def convert_to_list_of_string(value: Any | list[Any]) -&gt=
; list[str]:<br>
&gt; @@ -164,7 +164,7 @@ def convert_to_list_of_string(value: Any | list[An=
y]) -&gt; list[str]:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0def create_tarball(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dir_path: Path,<br>
&gt; -=C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D TarCompressio=
nFormat.none,<br>
&gt; +=C2=A0 =C2=A0 compress_format: TarCompressionFormat =3D TarCompressio=
nFormat.tar,<br>
out of scope&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0exclude: Any | list[Any] | None =
=3D None,<br>
&gt;=C2=A0 =C2=A0) -&gt; Path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Create a tarball from the =
contents of the specified directory.<br>
<br>
[1] <a href=3D"https://doc.dpdk.org/guides/contributing/patches.html" rel=
=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/guides/contributing/=
patches.html</a><br>
</blockquote></div>

--00000000000006173a063be0b865--
