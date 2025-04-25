Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB18C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 18:18:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 709BF4025E;
	Fri, 25 Apr 2025 20:18:12 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id F21D14021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 20:18:10 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-736b94d12b6so229137b3a.1
 for <dev@dpdk.org>; Fri, 25 Apr 2025 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745605090; x=1746209890; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfU9TOV4VSjJ7QrDXDf9alr6pKgfUCHIXWpIsJNXE7Q=;
 b=aPsAd1S5OROt42iospor28Ix0wKQ+oiHICcJgk1OIylTf3y9LzkPjN2IdDNsvOrhn8
 4p5jV9piiEPfrTcNz3Fhp5oeeP6tjHnsTgivLAjP9WKFmz8p7fRP3DnSHzaKoEsgnifG
 rYX11ySg5H74k4bpKsZqrUzSon5vbS47KlUG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745605090; x=1746209890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfU9TOV4VSjJ7QrDXDf9alr6pKgfUCHIXWpIsJNXE7Q=;
 b=iz/b6x8J2QnTE97J2Zckks83tIqANco7uybsQ9GOleTIKN30INDM43m98pNSJrLs+z
 IaDRP//ZYi3cFtvnKtMp0p7Ux8rFuX9FdC6werBYXNlU4v6S940+fIK5Iwww53ayrUgD
 6VD4edmD3GWczsUrIRtTZjsX7o/ErZZynov51DKW8jdM1eH/FSEtV88uIHRFf/p2sCk4
 Ets9vbL9cKosXCnsalA3zSlrhPdBDQE0Zi5yCQ46zSjaAijym40WG9TcSMI4JGMVTn31
 KN0hPLf0btvhDlyY6FTAclNhSLE0LOSTJ0w5U+/JBnMZL4DD3Un0zUbRwCXZ3+YHTjJ3
 0l2w==
X-Gm-Message-State: AOJu0YypPODGjbQAaRoRJ9KfX8QmpBMnbvK8HleQlqfbVyHw4iWL2BWI
 BmMqF/KFCenUVWtCZ78KYfz8tiBSPcb9AmkZ015zks+k3aNnDkk60KUgGthZunGBJaSlibg3GCx
 M1i6M4ySSMDWVj9mMVIG4if8b4s8k0Qq50d16qg==
X-Gm-Gg: ASbGncu5fedDA1L80f46Rj0ZviMs/ItEp3NIxjG3cXKN+qJI64TKrZRf58yJZA+xMwR
 5BQeyNnVVLhsI6KecqxqVnH/8iFkUTZCUTa068koI8JKzZ7yFvWfQopPfts6kokWBeGaXk2Tmga
 LGgVwQDsbkG2UTaUoqjV0EXh/uqo5At5WVktZcoBv6k9dvEZQULMEXnUcH
X-Google-Smtp-Source: AGHT+IHENiZtp4RyHLkFE5WUbtJoij8guWj0whQcmwq4lyyk/yQCxQzc62sp4bA6cbwU1JEjstNW0/cyb0c9AuUJJPU=
X-Received: by 2002:a05:6a20:e608:b0:1f2:f204:fd33 with SMTP id
 adf61e73a8af0-2045b429b3dmr1874123637.0.1745605089576; Fri, 25 Apr 2025
 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-5-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-5-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 14:17:56 -0400
X-Gm-Features: ATxdqUECevKep602Wgf88n0pyqAT69vAoB9jwvNzq27BzROGKx0PTUu_HDualII
Message-ID: <CAKXZ7eis5F0qQr-xe+S-HjXQFknUXuNuBnTEukDng_6YVAcvaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dts: revert back to a single InteractiveShell
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
> Previously InteractiveShell was split into two classes to differentiate
> a shell which execution must be controlled in a tight scope through a
> context manager, from a more looser approach. With the addition of the
> shell pool this is no longer needed as the management of shells is now
> delegated to the test run instead of the test suites.
>
> Revert back to a single InteractiveShell to simplify the code. Keep the
> context manager implementation but also render start_application and
> close public methods again.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/remote_session/dpdk_app.py      |   4 +-
>  dts/framework/remote_session/dpdk_shell.py    |   6 +-
>  .../remote_session/interactive_shell.py       | 289 ++++++++++++++++--
>  dts/framework/remote_session/python_shell.py  |   4 +
>  dts/framework/remote_session/shell_pool.py    |   2 +-
>  .../single_active_interactive_shell.py        | 275 -----------------
>  dts/framework/remote_session/testpmd_shell.py |   4 +-
>  7 files changed, 275 insertions(+), 309 deletions(-)
>  delete mode 100644 dts/framework/remote_session/single_active_interactiv=
e_shell.py
>
> diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/rem=
ote_session/dpdk_app.py
> index c9945f302d..c5aae05e02 100644
> --- a/dts/framework/remote_session/dpdk_app.py
> +++ b/dts/framework/remote_session/dpdk_app.py
> @@ -62,7 +62,7 @@ def wait_until_ready(self, end_token: str) -> None:
>          Args:
>              end_token: The string at the end of a line that indicates th=
e app is ready.
>          """
> -        self._start_application(end_token)
> +        self.start_application(end_token)
>
>      def close(self) -> None:
>          """Close the application.
> @@ -70,4 +70,4 @@ def close(self) -> None:
>          Sends a SIGINT to close the application.
>          """
>          self.send_command("\x03")
> -        self._close()
> +        super().close()
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index f7ea2588ca..24a39482ce 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -11,8 +11,8 @@
>
>  from framework.context import get_ctx
>  from framework.params.eal import EalParams
> -from framework.remote_session.single_active_interactive_shell import (
> -    SingleActiveInteractiveShell,
> +from framework.remote_session.interactive_shell import (
> +    InteractiveShell,
>  )
>  from framework.testbed_model.cpu import LogicalCoreList
>
> @@ -51,7 +51,7 @@ def compute_eal_params(
>      return params
>
>
> -class DPDKShell(SingleActiveInteractiveShell, ABC):
> +class DPDKShell(InteractiveShell, ABC):
>      """The base class for managing DPDK-based interactive shells.
>
>      This class shouldn't be instantiated directly, but instead be extend=
ed.
> diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/fram=
ework/remote_session/interactive_shell.py
> index 9ca285b604..62f9984d3b 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -1,44 +1,281 @@
>  # SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2023 University of New Hampshire
> +# Copyright(c) 2024 University of New Hampshire
>  # Copyright(c) 2024 Arm Limited
>
> -"""Interactive shell with manual stop/start functionality.
> +"""Common functionality for interactive shell handling.
>
> -Provides a class that doesn't require being started/stopped using a cont=
ext manager and can instead
> -be started and stopped manually, or have the stopping process be handled=
 at the time of garbage
> -collection.
> +The base class, :class:`InteractiveShell`, is meant to be extended by su=
bclasses that
> +contain functionality specific to that shell type. These subclasses will=
 often modify things like
> +the prompt to expect or the arguments to pass into the application, but =
still utilize
> +the same method for sending a command and collecting output. How this ou=
tput is handled however
> +is often application specific. If an application needs elevated privileg=
es to start it is expected
> +that the method for gaining those privileges is provided when initializi=
ng the class.
> +
> +This class is designed for applications like primary applications in DPD=
K where only one instance
> +of the application can be running at a given time and, for this reason, =
is managed using a context
> +manager. This context manager starts the application when you enter the =
context and cleans up the
> +application when you exit. Using a context manager for this is useful si=
nce it allows us to ensure
> +the application is cleaned up as soon as you leave the block regardless =
of the reason.
> +
> +The :option:`--timeout` command line argument and the :envvar:`DTS_TIMEO=
UT`
> +environment variable configure the timeout of getting the output from co=
mmand execution.
>  """
>
> -import weakref
> +from abc import ABC
> +from pathlib import PurePath
>  from typing import ClassVar
>
> -from .single_active_interactive_shell import SingleActiveInteractiveShel=
l
> +from paramiko import Channel, channel
> +from typing_extensions import Self
> +
> +from framework.exception import (
> +    InteractiveCommandExecutionError,
> +    InteractiveSSHSessionDeadError,
> +    InteractiveSSHTimeoutError,
> +)
> +from framework.logger import DTSLogger, get_dts_logger
> +from framework.params import Params
> +from framework.settings import SETTINGS
> +from framework.testbed_model.node import Node
> +from framework.utils import MultiInheritanceBaseClass
> +
> +
> +class InteractiveShell(MultiInheritanceBaseClass, ABC):
> +    """The base class for managing interactive shells.
>
> +    This class shouldn't be instantiated directly, but instead be extend=
ed. It contains
> +    methods for starting interactive shells as well as sending commands =
to these shells
> +    and collecting input until reaching a certain prompt. All interactiv=
e applications
> +    will use the same SSH connection, but each will create their own cha=
nnel on that
> +    session.
>
> -class InteractiveShell(SingleActiveInteractiveShell):
> -    """Adds manual start and stop functionality to interactive shells.
> +    Interactive shells are started and stopped using a context manager. =
This allows for the start
> +    and cleanup of the application to happen at predictable times regard=
less of exceptions or
> +    interrupts.
>
> -    Like its super-class, this class should not be instantiated directly=
 and should instead be
> -    extended. This class also provides an option for automated cleanup o=
f the application using a
> -    weakref and a finalize class. This finalize class allows for cleanup=
 of the class at the time
> -    of garbage collection and also ensures that cleanup only happens onc=
e. This way if a user
> -    initiates the closing of the shell manually it is not repeated at th=
e time of garbage
> -    collection.
> +    Attributes:
> +        is_alive: :data:`True` if the application has started successful=
ly, :data:`False`
> +            otherwise.
>      """
>
> -    _finalizer: weakref.finalize
> -    #: One attempt should be enough for shells which don't have to worry=
 about other instances
> -    #: closing before starting a new one.
> -    _init_attempts: ClassVar[int] =3D 1
> +    _node: Node
> +    _stdin: channel.ChannelStdinFile
> +    _stdout: channel.ChannelFile
> +    _ssh_channel: Channel
> +    _logger: DTSLogger
> +    _timeout: float
> +    _app_params: Params
> +    _privileged: bool
> +    _real_path: PurePath
> +
> +    #: The number of times to try starting the application before consid=
ering it a failure.
> +    _init_attempts: ClassVar[int] =3D 5
> +
> +    #: Prompt to expect at the end of output when sending a command.
> +    #: This is often overridden by subclasses.
> +    _default_prompt: ClassVar[str] =3D ""
> +
> +    #: Extra characters to add to the end of every command
> +    #: before sending them. This is often overridden by subclasses and i=
s
> +    #: most commonly an additional newline character. This additional ne=
wline
> +    #: character is used to force the line that is currently awaiting in=
put
> +    #: into the stdout buffer so that it can be consumed and checked aga=
inst
> +    #: the expected prompt.
> +    _command_extra_chars: ClassVar[str] =3D ""
> +
> +    #: Path to the executable to start the interactive application.
> +    path: ClassVar[PurePath]
> +
> +    is_alive: bool =3D False
> +
> +    def __init__(
> +        self,
> +        node: Node,
> +        name: str | None =3D None,
> +        privileged: bool =3D False,
> +        path: PurePath | None =3D None,
> +        app_params: Params =3D Params(),
> +        **kwargs,
> +    ) -> None:
> +        """Create an SSH channel during initialization.
> +
> +        Additional keyword arguments can be passed through `kwargs` if n=
eeded for fulfilling other
> +        constructors in the case of multiple inheritance.
> +
> +        Args:
> +            node: The node on which to run start the interactive shell.
> +            name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
> +                the name of the underlying node which it is running on.
> +            privileged: Enables the shell to run as superuser.
> +            path: Path to the executable. If :data:`None`, then the clas=
s' path attribute is used.
> +            app_params: The command line parameters to be passed to the =
application on startup.
> +            **kwargs: Any additional arguments if any.
> +        """
> +        self._node =3D node
> +        if name is None:
> +            name =3D type(self).__name__
> +        self._logger =3D get_dts_logger(f"{node.name}.{name}")
> +        self._app_params =3D app_params
> +        self._privileged =3D privileged
> +        self._timeout =3D SETTINGS.timeout
> +        # Ensure path is properly formatted for the host
> +        self._update_real_path(path or self.path)
> +        super().__init__(**kwargs)
> +
> +    def _setup_ssh_channel(self):
> +        self._ssh_channel =3D self._node.main_session.interactive_sessio=
n.session.invoke_shell()
> +        self._stdin =3D self._ssh_channel.makefile_stdin("w")
> +        self._stdout =3D self._ssh_channel.makefile("r")
> +        self._ssh_channel.settimeout(self._timeout)
> +        self._ssh_channel.set_combine_stderr(True)  # combines stdout an=
d stderr streams
> +
> +    def _make_start_command(self) -> str:
> +        """Makes the command that starts the interactive shell."""
> +        start_command =3D f"{self._real_path} {self._app_params or ''}"
> +        if self._privileged:
> +            start_command =3D self._node.main_session._get_privileged_co=
mmand(start_command)
> +        return start_command
> +
> +    def start_application(self, prompt: str | None =3D None) -> None:
> +        """Starts a new interactive application based on the path to the=
 app.
> +
> +        This method is often overridden by subclasses as their process f=
or starting may look
> +        different. Initialization of the shell on the host can be retrie=
d up to
> +        `self._init_attempts` - 1 times. This is done because some DPDK =
applications need slightly
> +        more time after exiting their script to clean up EAL before othe=
rs can start.
>
> -    def start_application(self) -> None:
> -        """Start the application.
> +        Args:
> +            prompt: When starting up the application, expect this string=
 at the end of stdout when
> +                the application is ready. If :data:`None`, the class' de=
fault prompt will be used.
>
> -        After the application has started, use :class:`weakref.finalize`=
 to manage cleanup.
> +        Raises:
> +            InteractiveCommandExecutionError: If the application fails t=
o start within the allotted
> +                number of retries.
>          """
> -        self._start_application()
> -        self._finalizer =3D weakref.finalize(self, self._close)
> +        self._setup_ssh_channel()
> +        self._ssh_channel.settimeout(5)
> +        start_command =3D self._make_start_command()
> +        self.is_alive =3D True
> +        for attempt in range(self._init_attempts):
> +            try:
> +                self.send_command(start_command, prompt)
> +                break
> +            except InteractiveSSHTimeoutError:
> +                self._logger.info(
> +                    f"Interactive shell failed to start (attempt {attemp=
t+1} out of "
> +                    f"{self._init_attempts})"
> +                )
> +        else:
> +            self._ssh_channel.settimeout(self._timeout)
> +            self.is_alive =3D False  # update state on failure to start
> +            raise InteractiveCommandExecutionError("Failed to start appl=
ication.")
> +        self._ssh_channel.settimeout(self._timeout)
> +
> +    def send_command(
> +        self, command: str, prompt: str | None =3D None, skip_first_line=
: bool =3D False
> +    ) -> str:
> +        """Send `command` and get all output before the expected ending =
string.
> +
> +        Lines that expect input are not included in the stdout buffer, s=
o they cannot
> +        be used for expect.
> +
> +        Example:
> +            If you were prompted to log into something with a username a=
nd password,
> +            you cannot expect ``username:`` because it won't yet be in t=
he stdout buffer.
> +            A workaround for this could be consuming an extra newline ch=
aracter to force
> +            the current `prompt` into the stdout buffer.
> +
> +        Args:
> +            command: The command to send.
> +            prompt: After sending the command, `send_command` will be ex=
pecting this string.
> +                If :data:`None`, will use the class's default prompt.
> +            skip_first_line: Skip the first line when capturing the outp=
ut.
> +
> +        Returns:
> +            All output in the buffer before expected string.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If attempting to send a co=
mmand to a shell that is
> +                not currently running.
> +            InteractiveSSHSessionDeadError: The session died while execu=
ting the command.
> +            InteractiveSSHTimeoutError: If command was sent but prompt c=
ould not be found in
> +                the output before the timeout.
> +        """
> +        if not self.is_alive:
> +            raise InteractiveCommandExecutionError(
> +                f"Cannot send command {command} to application because t=
he shell is not running."
> +            )
> +        self._logger.info(f"Sending: '{command}'")
> +        if prompt is None:
> +            prompt =3D self._default_prompt
> +        out: str =3D ""
> +        try:
> +            self._stdin.write(f"{command}{self._command_extra_chars}\n")
> +            self._stdin.flush()
> +            for line in self._stdout:
> +                if skip_first_line:
> +                    skip_first_line =3D False
> +                    continue
> +                if line.rstrip().endswith(prompt):
> +                    break
> +                out +=3D line
> +        except TimeoutError as e:
> +            self._logger.exception(e)
> +            self._logger.debug(
> +                f"Prompt ({prompt}) was not found in output from command=
 before timeout."
> +            )
> +            raise InteractiveSSHTimeoutError(command) from e
> +        except OSError as e:
> +            self._logger.exception(e)
> +            raise InteractiveSSHSessionDeadError(
> +                self._node.main_session.interactive_session.hostname
> +            ) from e
> +        finally:
> +            self._logger.debug(f"Got output: {out}")
> +        return out
>
>      def close(self) -> None:
> -        """Free all resources using :class:`weakref.finalize`."""
> -        self._finalizer()
> +        """Close the shell.
> +
> +        Raises:
> +            InteractiveSSHTimeoutError: If the shell failed to exit with=
in the set timeout.
> +        """
> +        try:
> +            # Ensure the primary application has terminated via readines=
s of 'stdout'.
> +            if self._ssh_channel.recv_ready():
> +                self._ssh_channel.recv(1)  # 'Waits' for a single byte t=
o enter 'stdout' buffer.
> +        except TimeoutError as e:
> +            self._logger.exception(e)
> +            self._logger.debug("Application failed to exit before set ti=
meout.")
> +            raise InteractiveSSHTimeoutError("Application 'exit' command=
") from e
> +        self._ssh_channel.close()
> +
> +    def _update_real_path(self, path: PurePath) -> None:
> +        """Updates the interactive shell's real path used at command lin=
e."""
> +        self._real_path =3D self._node.main_session.join_remote_path(pat=
h)
> +
> +    def __enter__(self) -> Self:
> +        """Enter the context block.
> +
> +        Upon entering a context block with this class, the desired behav=
ior is to create the
> +        channel for the application to use, and then start the applicati=
on.
> +
> +        Returns:
> +            Reference to the object for the application after it has bee=
n started.
> +        """
> +        self.start_application()
> +        return self
> +
> +    def __exit__(self, *_) -> None:
> +        """Exit the context block.
> +
> +        Upon exiting a context block with this class, we want to ensure =
that the instance of the
> +        application is explicitly closed and properly cleaned up using i=
ts close method. Note that
> +        because this method returns :data:`None` if an exception was rai=
sed within the block, it is
> +        not handled and will be re-raised after the application is close=
d.
> +
> +        The desired behavior is to close the application regardless of t=
he reason for exiting the
> +        context and then recreate that reason afterwards. All method arg=
uments are ignored for
> +        this reason.
> +        """
> +        self.close()
> diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework=
/remote_session/python_shell.py
> index 9d4abab12c..17e6c2559d 100644
> --- a/dts/framework/remote_session/python_shell.py
> +++ b/dts/framework/remote_session/python_shell.py
> @@ -29,3 +29,7 @@ class PythonShell(InteractiveShell):
>
>      #: The Python executable.
>      path: ClassVar[PurePath] =3D PurePath("python3")
> +
> +    def close(self):
> +        """Close Python shell."""
> +        return super().close()
> diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/r=
emote_session/shell_pool.py
> index 173aa8fd36..da956950d5 100644
> --- a/dts/framework/remote_session/shell_pool.py
> +++ b/dts/framework/remote_session/shell_pool.py
> @@ -90,7 +90,7 @@ def terminate_current_pool(self):
>          for shell in self._pools.pop():
>              self._logger.debug(f"Closing shell {shell} in shell pool lev=
el {current_pool_level}.")
>              try:
> -                shell._close()
> +                shell.close()
>              except Exception as e:
>                  self._logger.error(f"An exception has occurred while clo=
sing shell {shell}:")
>                  self._logger.exception(e)
> diff --git a/dts/framework/remote_session/single_active_interactive_shell=
.py b/dts/framework/remote_session/single_active_interactive_shell.py
> deleted file mode 100644
> index 2257b6156b..0000000000
> --- a/dts/framework/remote_session/single_active_interactive_shell.py
> +++ /dev/null
> @@ -1,275 +0,0 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2024 University of New Hampshire
> -
> -"""Common functionality for interactive shell handling.
> -
> -The base class, :class:`SingleActiveInteractiveShell`, is meant to be ex=
tended by subclasses that
> -contain functionality specific to that shell type. These subclasses will=
 often modify things like
> -the prompt to expect or the arguments to pass into the application, but =
still utilize
> -the same method for sending a command and collecting output. How this ou=
tput is handled however
> -is often application specific. If an application needs elevated privileg=
es to start it is expected
> -that the method for gaining those privileges is provided when initializi=
ng the class.
> -
> -This class is designed for applications like primary applications in DPD=
K where only one instance
> -of the application can be running at a given time and, for this reason, =
is managed using a context
> -manager. This context manager starts the application when you enter the =
context and cleans up the
> -application when you exit. Using a context manager for this is useful si=
nce it allows us to ensure
> -the application is cleaned up as soon as you leave the block regardless =
of the reason.
> -
> -The :option:`--timeout` command line argument and the :envvar:`DTS_TIMEO=
UT`
> -environment variable configure the timeout of getting the output from co=
mmand execution.
> -"""
> -
> -from abc import ABC
> -from pathlib import PurePath
> -from typing import ClassVar
> -
> -from paramiko import Channel, channel
> -from typing_extensions import Self
> -
> -from framework.exception import (
> -    InteractiveCommandExecutionError,
> -    InteractiveSSHSessionDeadError,
> -    InteractiveSSHTimeoutError,
> -)
> -from framework.logger import DTSLogger, get_dts_logger
> -from framework.params import Params
> -from framework.settings import SETTINGS
> -from framework.testbed_model.node import Node
> -from framework.utils import MultiInheritanceBaseClass
> -
> -
> -class SingleActiveInteractiveShell(MultiInheritanceBaseClass, ABC):
> -    """The base class for managing interactive shells.
> -
> -    This class shouldn't be instantiated directly, but instead be extend=
ed. It contains
> -    methods for starting interactive shells as well as sending commands =
to these shells
> -    and collecting input until reaching a certain prompt. All interactiv=
e applications
> -    will use the same SSH connection, but each will create their own cha=
nnel on that
> -    session.
> -
> -    Interactive shells are started and stopped using a context manager. =
This allows for the start
> -    and cleanup of the application to happen at predictable times regard=
less of exceptions or
> -    interrupts.
> -
> -    Attributes:
> -        is_alive: :data:`True` if the application has started successful=
ly, :data:`False`
> -            otherwise.
> -    """
> -
> -    _node: Node
> -    _stdin: channel.ChannelStdinFile
> -    _stdout: channel.ChannelFile
> -    _ssh_channel: Channel
> -    _logger: DTSLogger
> -    _timeout: float
> -    _app_params: Params
> -    _privileged: bool
> -    _real_path: PurePath
> -
> -    #: The number of times to try starting the application before consid=
ering it a failure.
> -    _init_attempts: ClassVar[int] =3D 5
> -
> -    #: Prompt to expect at the end of output when sending a command.
> -    #: This is often overridden by subclasses.
> -    _default_prompt: ClassVar[str] =3D ""
> -
> -    #: Extra characters to add to the end of every command
> -    #: before sending them. This is often overridden by subclasses and i=
s
> -    #: most commonly an additional newline character. This additional ne=
wline
> -    #: character is used to force the line that is currently awaiting in=
put
> -    #: into the stdout buffer so that it can be consumed and checked aga=
inst
> -    #: the expected prompt.
> -    _command_extra_chars: ClassVar[str] =3D ""
> -
> -    #: Path to the executable to start the interactive application.
> -    path: ClassVar[PurePath]
> -
> -    is_alive: bool =3D False
> -
> -    def __init__(
> -        self,
> -        node: Node,
> -        name: str | None =3D None,
> -        privileged: bool =3D False,
> -        path: PurePath | None =3D None,
> -        app_params: Params =3D Params(),
> -        **kwargs,
> -    ) -> None:
> -        """Create an SSH channel during initialization.
> -
> -        Additional keyword arguments can be passed through `kwargs` if n=
eeded for fulfilling other
> -        constructors in the case of multiple inheritance.
> -
> -        Args:
> -            node: The node on which to run start the interactive shell.
> -            name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
> -                the name of the underlying node which it is running on.
> -            privileged: Enables the shell to run as superuser.
> -            path: Path to the executable. If :data:`None`, then the clas=
s' path attribute is used.
> -            app_params: The command line parameters to be passed to the =
application on startup.
> -            **kwargs: Any additional arguments if any.
> -        """
> -        self._node =3D node
> -        if name is None:
> -            name =3D type(self).__name__
> -        self._logger =3D get_dts_logger(f"{node.name}.{name}")
> -        self._app_params =3D app_params
> -        self._privileged =3D privileged
> -        self._timeout =3D SETTINGS.timeout
> -        # Ensure path is properly formatted for the host
> -        self._update_real_path(path or self.path)
> -        super().__init__(**kwargs)
> -
> -    def _setup_ssh_channel(self):
> -        self._ssh_channel =3D self._node.main_session.interactive_sessio=
n.session.invoke_shell()
> -        self._stdin =3D self._ssh_channel.makefile_stdin("w")
> -        self._stdout =3D self._ssh_channel.makefile("r")
> -        self._ssh_channel.settimeout(self._timeout)
> -        self._ssh_channel.set_combine_stderr(True)  # combines stdout an=
d stderr streams
> -
> -    def _make_start_command(self) -> str:
> -        """Makes the command that starts the interactive shell."""
> -        start_command =3D f"{self._real_path} {self._app_params or ''}"
> -        if self._privileged:
> -            start_command =3D self._node.main_session._get_privileged_co=
mmand(start_command)
> -        return start_command
> -
> -    def _start_application(self, prompt: str | None =3D None) -> None:
> -        """Starts a new interactive application based on the path to the=
 app.
> -
> -        This method is often overridden by subclasses as their process f=
or starting may look
> -        different. Initialization of the shell on the host can be retrie=
d up to
> -        `self._init_attempts` - 1 times. This is done because some DPDK =
applications need slightly
> -        more time after exiting their script to clean up EAL before othe=
rs can start.
> -
> -        Args:
> -            prompt: When starting up the application, expect this string=
 at the end of stdout when
> -                the application is ready. If :data:`None`, the class' de=
fault prompt will be used.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If the application fails t=
o start within the allotted
> -                number of retries.
> -        """
> -        self._setup_ssh_channel()
> -        self._ssh_channel.settimeout(5)
> -        start_command =3D self._make_start_command()
> -        self.is_alive =3D True
> -        for attempt in range(self._init_attempts):
> -            try:
> -                self.send_command(start_command, prompt)
> -                break
> -            except InteractiveSSHTimeoutError:
> -                self._logger.info(
> -                    f"Interactive shell failed to start (attempt {attemp=
t+1} out of "
> -                    f"{self._init_attempts})"
> -                )
> -        else:
> -            self._ssh_channel.settimeout(self._timeout)
> -            self.is_alive =3D False  # update state on failure to start
> -            raise InteractiveCommandExecutionError("Failed to start appl=
ication.")
> -        self._ssh_channel.settimeout(self._timeout)
> -
> -    def send_command(
> -        self, command: str, prompt: str | None =3D None, skip_first_line=
: bool =3D False
> -    ) -> str:
> -        """Send `command` and get all output before the expected ending =
string.
> -
> -        Lines that expect input are not included in the stdout buffer, s=
o they cannot
> -        be used for expect.
> -
> -        Example:
> -            If you were prompted to log into something with a username a=
nd password,
> -            you cannot expect ``username:`` because it won't yet be in t=
he stdout buffer.
> -            A workaround for this could be consuming an extra newline ch=
aracter to force
> -            the current `prompt` into the stdout buffer.
> -
> -        Args:
> -            command: The command to send.
> -            prompt: After sending the command, `send_command` will be ex=
pecting this string.
> -                If :data:`None`, will use the class's default prompt.
> -            skip_first_line: Skip the first line when capturing the outp=
ut.
> -
> -        Returns:
> -            All output in the buffer before expected string.
> -
> -        Raises:
> -            InteractiveCommandExecutionError: If attempting to send a co=
mmand to a shell that is
> -                not currently running.
> -            InteractiveSSHSessionDeadError: The session died while execu=
ting the command.
> -            InteractiveSSHTimeoutError: If command was sent but prompt c=
ould not be found in
> -                the output before the timeout.
> -        """
> -        if not self.is_alive:
> -            raise InteractiveCommandExecutionError(
> -                f"Cannot send command {command} to application because t=
he shell is not running."
> -            )
> -        self._logger.info(f"Sending: '{command}'")
> -        if prompt is None:
> -            prompt =3D self._default_prompt
> -        out: str =3D ""
> -        try:
> -            self._stdin.write(f"{command}{self._command_extra_chars}\n")
> -            self._stdin.flush()
> -            for line in self._stdout:
> -                if skip_first_line:
> -                    skip_first_line =3D False
> -                    continue
> -                if line.rstrip().endswith(prompt):
> -                    break
> -                out +=3D line
> -        except TimeoutError as e:
> -            self._logger.exception(e)
> -            self._logger.debug(
> -                f"Prompt ({prompt}) was not found in output from command=
 before timeout."
> -            )
> -            raise InteractiveSSHTimeoutError(command) from e
> -        except OSError as e:
> -            self._logger.exception(e)
> -            raise InteractiveSSHSessionDeadError(
> -                self._node.main_session.interactive_session.hostname
> -            ) from e
> -        finally:
> -            self._logger.debug(f"Got output: {out}")
> -        return out
> -
> -    def _close(self) -> None:
> -        try:
> -            # Ensure the primary application has terminated via readines=
s of 'stdout'.
> -            if self._ssh_channel.recv_ready():
> -                self._ssh_channel.recv(1)  # 'Waits' for a single byte t=
o enter 'stdout' buffer.
> -        except TimeoutError as e:
> -            self._logger.exception(e)
> -            self._logger.debug("Application failed to exit before set ti=
meout.")
> -            raise InteractiveSSHTimeoutError("Application 'exit' command=
") from e
> -        self._ssh_channel.close()
> -
> -    def _update_real_path(self, path: PurePath) -> None:
> -        """Updates the interactive shell's real path used at command lin=
e."""
> -        self._real_path =3D self._node.main_session.join_remote_path(pat=
h)
> -
> -    def __enter__(self) -> Self:
> -        """Enter the context block.
> -
> -        Upon entering a context block with this class, the desired behav=
ior is to create the
> -        channel for the application to use, and then start the applicati=
on.
> -
> -        Returns:
> -            Reference to the object for the application after it has bee=
n started.
> -        """
> -        self._start_application()
> -        return self
> -
> -    def __exit__(self, *_) -> None:
> -        """Exit the context block.
> -
> -        Upon exiting a context block with this class, we want to ensure =
that the instance of the
> -        application is explicitly closed and properly cleaned up using i=
ts close method. Note that
> -        because this method returns :data:`None` if an exception was rai=
sed within the block, it is
> -        not handled and will be re-raised after the application is close=
d.
> -
> -        The desired behavior is to close the application regardless of t=
he reason for exiting the
> -        context and then recreate that reason afterwards. All method arg=
uments are ignored for
> -        this reason.
> -        """
> -        self._close()
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index db1bfaa9d1..b83b0c82a0 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -2312,11 +2312,11 @@ def rx_vxlan(self, vxlan_id: int, port_id: int, e=
nable: bool, verify: bool =3D Tru
>                  self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output=
}")
>                  raise InteractiveCommandExecutionError(f"Failed to set V=
XLAN:\n{vxlan_output}")
>
> -    def _close(self) -> None:
> +    def close(self) -> None:
>          """Overrides :meth:`~.interactive_shell.close`."""
>          self.stop()
>          self.send_command("quit", "Bye...")
> -        return super()._close()
> +        return super().close()
>
>      """
>      =3D=3D=3D=3D=3D=3D Capability retrieval methods =3D=3D=3D=3D=3D=3D
> --
> 2.43.0
>
