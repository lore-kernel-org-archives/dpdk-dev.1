Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA7C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 18:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 280A14025E;
	Fri, 25 Apr 2025 20:35:15 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8F77A4021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 20:35:13 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-73b71a9a991so362501b3a.2
 for <dev@dpdk.org>; Fri, 25 Apr 2025 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745606112; x=1746210912; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGEeTNXipQ4Pe+nkArfkOjTlrgbt3Jt0JGA1moLuEdA=;
 b=Rngh3oMrMLxazfxfADeBWf0l9vu5uVvgChxy8efBbn+cj1odnihqVP5sBApiDSiM2t
 qvKCMLhxklMSxypI8i+a4kk8QatBcfEcM6hLIWNThR7fvb2AD2Z9CN5JBAenbFN/eITa
 QKkMi/XFtocAiOR15Kf8o2DBoPpAhTPkcU5G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745606112; x=1746210912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGEeTNXipQ4Pe+nkArfkOjTlrgbt3Jt0JGA1moLuEdA=;
 b=NIKabcBOkvhnDHYq1LDnTxq8977h5xBv3iBxXqdsWuCYMAqW3wAxqlI9amySqOZJm2
 Nk5WvBwpuf9Zy8YI7n+AqnRHnN6vg93DNDZlDbANkFXUZYv6jqSDVbXudTmuqAQOpTM9
 BPFC7yAWesr14TdBscJFCeENxIiAvh7R9PVOLj1yGtgCyxYJN6JUnK9lXdF7kAHlaWps
 oAKBdPU+cRZIGpeJUTIPj2kxpsq27vQ0y6mu9ynan6DqtgS07R1p+SezFh33iXulSDyc
 6vkj+yX5AlFUmomhrEbSc+lC7HhPrnlEMImARRbiIBYDsHHFZugY3TbkwINDDEm4ssMz
 gRVw==
X-Gm-Message-State: AOJu0YzfAD4Iefegx/ZlV/Q12DKIHX2MSqll9AvDybsTukRiJB9lzu7H
 jQphS5whQRsOrQGbB3oavTYLlis3Ui32U8/u/hmg18LqOEb+zVe6myzKkuiztdLJlMnqeCQiEF5
 UrbbqywZOkDyHIaEwXBgfCESNlXha1nxC5vYemg==
X-Gm-Gg: ASbGncshi2gOL/GO7eBkI3wXvNQQBd5SPFxIXYn4FDeOnKTOKOKvIPhGKjFkmA0z18H
 cKxivC3+tUr5O3RPyLtTG4wziSkZviNv3XPgyij81J2L1b3KoUlYgD68w9ln49blS5w8v6jZzNn
 2o9SxqJenRTf0Vk+APl9VhyQhedztPvjbq0V8sqvTpHjpLUFFfB/UuEkN7
X-Google-Smtp-Source: AGHT+IE91ZFlja1HHvnfR/5zKxxt1qAWlp0YD/5Hz8o2D52Yz0TyK7MjknAHQgDE6DLGfs0CFWPgMrrPeOuU2nqnRRQ=
X-Received: by 2002:a05:6a00:ab8e:b0:730:915c:b70 with SMTP id
 d2e1a72fcca58-73fc7a56bf4mr1822730b3a.0.1745606112319; Fri, 25 Apr 2025
 11:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-6-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-6-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 14:35:00 -0400
X-Gm-Features: ATxdqUHG3R5tKg2OVu_lV3r1rbn1R5ie_hID46DdqJ6ri_wwiLfNHoQjNTKNDCs
Message-ID: <CAKXZ7ehrgU8v8ERHt-7-1sNHH7D+MPe1gYZpHbDtgnq-7Ct_oQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dts: make shells path dynamic
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
> Turn the `path` attribute of InteractiveShell into a method property.
> This allows path to both be defined statically by the class
> implementation and also to be defined dynamically as part of the class
> construction.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/remote_session/dpdk_app.py      |  9 +++++++-
>  dts/framework/remote_session/dpdk_shell.py    | 18 ++++++++-------
>  .../remote_session/interactive_shell.py       | 22 ++++++++-----------
>  dts/framework/remote_session/python_shell.py  |  6 +++--
>  dts/framework/remote_session/testpmd_shell.py |  8 ++++---
>  5 files changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/rem=
ote_session/dpdk_app.py
> index c5aae05e02..dc4b817bdd 100644
> --- a/dts/framework/remote_session/dpdk_app.py
> +++ b/dts/framework/remote_session/dpdk_app.py
> @@ -54,7 +54,14 @@ def __init__(
>              eal_params.append_str(app_params)
>              app_params =3D eal_params
>
> -        super().__init__(name, privileged, path, app_params)
> +        self._path =3D path
> +
> +        super().__init__(name, privileged, app_params)
> +
> +    @property
> +    def path(self) -> PurePath:
> +        """The path of the DPDK app relative to the DPDK build folder.""=
"
> +        return self._path
>
>      def wait_until_ready(self, end_token: str) -> None:
>          """Start app and wait until ready.
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index 24a39482ce..2d4f91052d 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -6,7 +6,7 @@
>  Provides a base class to create interactive shells based on DPDK.
>  """
>
> -from abc import ABC
> +from abc import ABC, abstractmethod
>  from pathlib import PurePath
>
>  from framework.context import get_ctx
> @@ -65,20 +65,22 @@ def __init__(
>          self,
>          name: str | None =3D None,
>          privileged: bool =3D True,
> -        path: PurePath | None =3D None,
>          app_params: EalParams =3D EalParams(),
>      ) -> None:
>          """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`=
."""
>          app_params =3D compute_eal_params(app_params)
>          node =3D get_ctx().sut_node
>
> -        super().__init__(node, name, privileged, path, app_params)
> +        super().__init__(node, name, privileged, app_params)
>
> -    def _update_real_path(self, path: PurePath) -> None:
> -        """Extends :meth:`~.interactive_shell.InteractiveShell._update_r=
eal_path`.
> +    @property
> +    @abstractmethod
> +    def path(self) -> PurePath:
> +        """Relative path to the shell executable from the build folder."=
""
> +
> +    def _make_real_path(self):
> +        """Overrides :meth:`~.interactive_shell.InteractiveShell._make_r=
eal_path`.
>
>          Adds the remote DPDK build directory to the path.
>          """
> -        super()._update_real_path(
> -            PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpat=
h(path)
> -        )
> +        return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.=
path)
> diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/fram=
ework/remote_session/interactive_shell.py
> index 62f9984d3b..6b7ca0b6af 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -21,7 +21,7 @@
>  environment variable configure the timeout of getting the output from co=
mmand execution.
>  """
>
> -from abc import ABC
> +from abc import ABC, abstractmethod
>  from pathlib import PurePath
>  from typing import ClassVar
>
> @@ -66,7 +66,6 @@ class InteractiveShell(MultiInheritanceBaseClass, ABC):
>      _timeout: float
>      _app_params: Params
>      _privileged: bool
> -    _real_path: PurePath
>
>      #: The number of times to try starting the application before consid=
ering it a failure.
>      _init_attempts: ClassVar[int] =3D 5
> @@ -83,9 +82,6 @@ class InteractiveShell(MultiInheritanceBaseClass, ABC):
>      #: the expected prompt.
>      _command_extra_chars: ClassVar[str] =3D ""
>
> -    #: Path to the executable to start the interactive application.
> -    path: ClassVar[PurePath]
> -
>      is_alive: bool =3D False
>
>      def __init__(
> @@ -93,7 +89,6 @@ def __init__(
>          node: Node,
>          name: str | None =3D None,
>          privileged: bool =3D False,
> -        path: PurePath | None =3D None,
>          app_params: Params =3D Params(),
>          **kwargs,
>      ) -> None:
> @@ -107,7 +102,6 @@ def __init__(
>              name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
>                  the name of the underlying node which it is running on.
>              privileged: Enables the shell to run as superuser.
> -            path: Path to the executable. If :data:`None`, then the clas=
s' path attribute is used.
>              app_params: The command line parameters to be passed to the =
application on startup.
>              **kwargs: Any additional arguments if any.
>          """
> @@ -118,8 +112,6 @@ def __init__(
>          self._app_params =3D app_params
>          self._privileged =3D privileged
>          self._timeout =3D SETTINGS.timeout
> -        # Ensure path is properly formatted for the host
> -        self._update_real_path(path or self.path)
>          super().__init__(**kwargs)
>
>      def _setup_ssh_channel(self):
> @@ -131,7 +123,7 @@ def _setup_ssh_channel(self):
>
>      def _make_start_command(self) -> str:
>          """Makes the command that starts the interactive shell."""
> -        start_command =3D f"{self._real_path} {self._app_params or ''}"
> +        start_command =3D f"{self._make_real_path()} {self._app_params o=
r ''}"
>          if self._privileged:
>              start_command =3D self._node.main_session._get_privileged_co=
mmand(start_command)
>          return start_command
> @@ -250,9 +242,13 @@ def close(self) -> None:
>              raise InteractiveSSHTimeoutError("Application 'exit' command=
") from e
>          self._ssh_channel.close()
>
> -    def _update_real_path(self, path: PurePath) -> None:
> -        """Updates the interactive shell's real path used at command lin=
e."""
> -        self._real_path =3D self._node.main_session.join_remote_path(pat=
h)
> +    @property
> +    @abstractmethod
> +    def path(self) -> PurePath:
> +        """Path to the shell executable."""
> +
> +    def _make_real_path(self) -> PurePath:
> +        return self._node.main_session.join_remote_path(self.path)
>
>      def __enter__(self) -> Self:
>          """Enter the context block.
> diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework=
/remote_session/python_shell.py
> index 17e6c2559d..6331d047c4 100644
> --- a/dts/framework/remote_session/python_shell.py
> +++ b/dts/framework/remote_session/python_shell.py
> @@ -27,8 +27,10 @@ class PythonShell(InteractiveShell):
>      #: This forces the prompt to appear after sending a command.
>      _command_extra_chars: ClassVar[str] =3D "\n"
>
> -    #: The Python executable.
> -    path: ClassVar[PurePath] =3D PurePath("python3")
> +    @property
> +    def path(self) -> PurePath:
> +        """Path to the Python3 executable."""
> +        return PurePath("python3")
>
>      def close(self):
>          """Close Python shell."""
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index b83b0c82a0..19437b6233 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1520,9 +1520,6 @@ class TestPmdShell(DPDKShell):
>      _app_params: TestPmdParams
>      _ports: list[TestPmdPort] | None
>
> -    #: The path to the testpmd executable.
> -    path: ClassVar[PurePath] =3D PurePath("app", "dpdk-testpmd")
> -
>      #: The testpmd's prompt.
>      _default_prompt: ClassVar[str] =3D "testpmd>"
>
> @@ -1544,6 +1541,11 @@ def __init__(
>          self.ports_started =3D not self._app_params.disable_device_start
>          self._ports =3D None
>
> +    @property
> +    def path(self) -> PurePath:
> +        """The path to the testpmd executable."""
> +        return PurePath("app/dpdk-testpmd")
> +
>      @property
>      def ports(self) -> list[TestPmdPort]:
>          """The ports of the instance.
> --
> 2.43.0
>
