Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E3C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 16:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B5384025E;
	Fri, 25 Apr 2025 18:56:22 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 5E9EF4021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 18:56:21 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso239826a91.3
 for <dev@dpdk.org>; Fri, 25 Apr 2025 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745600180; x=1746204980; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvxXHfQcB7+2Dl1MLavZEEtuO3BnPc0iS8HhvU+8TzY=;
 b=VVO5waPTNmXm4rSb8TESWF4wC/UX+iFTluIyHaf01ziB+t0oYoOhSo8U5UJAZZ4MBu
 bg6SFHWVCFvnAgGPsfTHR2JFOnb+R1dg5c7PA9XrKnsymrIVl9CfJUgOOBmZb+9ppmbp
 dPGL5bhpg/9b+jN/Vg7OxkSTUKC4JSgT8m7ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745600180; x=1746204980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvxXHfQcB7+2Dl1MLavZEEtuO3BnPc0iS8HhvU+8TzY=;
 b=KmINCkqa7xRiFzikVX7g0EolBULfBFHMN2tNEoZrOeAKVgaTftHzZjoEFp7vgsYsvu
 BjKIlMGcCKPB0N2yVGKnIZVbOxHjjPATornc2boQu9vu9nNgzDAlRlgtganMiD0FZuma
 6WbtlY3mMln6mmbG3+7Zch7oEEwlM/0utkEBPVXmnXYJbTa546ZV8YYzaCKhFm2qWjuC
 i+MA+YHqHv6JjrL4ioUOI2vF3DmJPIiOOQ7EQPkG5CzETlXZl9I3Co5U8io4gYH6UD2m
 9df9qmAjaRr+sV4sXc9D4iBYUOUWBDG+AHUyVnwk7hE8Mbz0ZVrLbWT2zOErJaQ+jPyO
 Se3Q==
X-Gm-Message-State: AOJu0Yw5upuIbvEvPVY15iypuIEPtP6M+QLufpakCEnOJocijLsDXid2
 uo7mrlRMBMGaADb8ynUSYHWQgALqyW1eaVH9TGY1YfttqgiT9DWr8iShQpYPHSjPc06UvVQjay2
 MmY0ZrdCZX8Uzrndcuw6fqNgd5JEgPqcNIEtuQQ==
X-Gm-Gg: ASbGncuc8McGJSDa4Wdppu0e2musW/cXBWHs/8AVWVVqXUL4g/S8c4qdGSggQuZUvkr
 SGVRoC3UiUzn3ERN8DT+RjdbN0QkQfyggN66PylP2h00bOHPIqu8Liatss4Thd06JrxVvOLyFj0
 hQ5l2K0Z53o9yjqOyWQgBpdIpWvI3JhmP+jbeJwvzf9DCPAznt4KZKCGsN
X-Google-Smtp-Source: AGHT+IEmJRjYCuFiZCmlEnEJJBSAAJBWljEb4+YdmcZiRswExOQxgLUAksCj5W5QoXSp6Ps5NfL18ibKSt77wm4LBHU=
X-Received: by 2002:a17:90b:3e85:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-309f7e8f5e5mr1722255a91.3.1745600180108; Fri, 25 Apr 2025
 09:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-3-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-3-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 12:56:07 -0400
X-Gm-Features: ATxdqUEji9Z3KhvACz_9PYef-aH4g2dRxgp3YZ75gKBT6YyNkQBwnyLWgtNAlLI
Message-ID: <CAKXZ7eiHuZeGL-E46Hh-SPNxLhYCnVrGDN8DvLeUr9SrifoUpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dts: add blocking dpdk app class
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

This is perfect for my TREX implementation!

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Fri, Mar 14, 2025 at 9:19=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Add BlockingDPDKApp class. Some non-interactive applications are
> blocking and run until the user interrupts them. As their main intended
> usage is to be kept running in the background, this class exploits
> InteractiveShell to spawn a dedicated shell to keep the blocking
> application running, while detaching from it.
>
> This class works by providing the `wait_until_ready` and `close`
> methods. The former starts up the application and returns only when the
> application readiness output ends in the string provided as an argument
> to the same method. Whereas the latter works by simulating a Ctrl+C
> keystroke, therefore sending a SIGINT to the app.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/remote_session/dpdk_app.py      | 73 +++++++++++++++++++
>  dts/framework/remote_session/dpdk_shell.py    |  3 +-
>  .../single_active_interactive_shell.py        | 12 ++-
>  dts/framework/remote_session/testpmd_shell.py |  2 +-
>  4 files changed, 85 insertions(+), 5 deletions(-)
>  create mode 100644 dts/framework/remote_session/dpdk_app.py
>
> diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/rem=
ote_session/dpdk_app.py
> new file mode 100644
> index 0000000000..c9945f302d
> --- /dev/null
> +++ b/dts/framework/remote_session/dpdk_app.py
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Class to run blocking DPDK apps in the background.
> +
> +The class won't automatically start the app. The start-up is done as par=
t of the
> +:meth:`BlockingDPDKApp.wait_until_ready` method, which will return execu=
tion to the caller only
> +when the desired stdout has been returned by the app. Usually this is us=
ed to detect when the app
> +has been loaded and ready to be used.
> +
> +Example:
> +    ..code:: python
> +
> +        pdump =3D BlockingDPDKApp(
> +            PurePath("app/dpdk-pdump"),
> +            app_params=3D"--pdump 'port=3D0,queue=3D*,rx-dev=3D/tmp/rx-d=
ev.pcap'"
> +        )
> +        pdump.wait_until_ready("65535") # start app
> +
> +        # pdump is now ready to capture
> +
> +        pdump.close() # stop/close app
> +"""
> +
> +from pathlib import PurePath
> +
> +from framework.params.eal import EalParams
> +from framework.remote_session.dpdk_shell import DPDKShell
> +
> +
> +class BlockingDPDKApp(DPDKShell):
> +    """Class to manage blocking DPDK apps."""
> +
> +    def __init__(
> +        self,
> +        path: PurePath,
> +        name: str | None =3D None,
> +        privileged: bool =3D True,
> +        app_params: EalParams | str =3D "",
> +    ) -> None:
> +        """Constructor.
> +
> +        Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`.
> +
> +        Args:
> +            path: Path relative to the DPDK build to the executable.
> +            name: Name to identify this application.
> +            privileged: Run as privileged user.
> +            app_params: The application parameters. If a string or an in=
complete :class:`EalParams`
> +                object are passed, the EAL params are computed based on =
the current context.
> +        """
> +        if isinstance(app_params, str):
> +            eal_params =3D EalParams()
> +            eal_params.append_str(app_params)
> +            app_params =3D eal_params
> +
> +        super().__init__(name, privileged, path, app_params)
> +
> +    def wait_until_ready(self, end_token: str) -> None:
> +        """Start app and wait until ready.
> +
> +        Args:
> +            end_token: The string at the end of a line that indicates th=
e app is ready.
> +        """
> +        self._start_application(end_token)
> +
> +    def close(self) -> None:
> +        """Close the application.
> +
> +        Sends a SIGINT to close the application.
> +        """
> +        self.send_command("\x03")
> +        self._close()
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index 0962414876..f7ea2588ca 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -65,13 +65,14 @@ def __init__(
>          self,
>          name: str | None =3D None,
>          privileged: bool =3D True,
> +        path: PurePath | None =3D None,
>          app_params: EalParams =3D EalParams(),
>      ) -> None:
>          """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`=
."""
>          app_params =3D compute_eal_params(app_params)
>          node =3D get_ctx().sut_node
>
> -        super().__init__(node, name, privileged, app_params)
> +        super().__init__(node, name, privileged, path, app_params)
>
>      def _update_real_path(self, path: PurePath) -> None:
>          """Extends :meth:`~.interactive_shell.InteractiveShell._update_r=
eal_path`.
> diff --git a/dts/framework/remote_session/single_active_interactive_shell=
.py b/dts/framework/remote_session/single_active_interactive_shell.py
> index c1369ef77e..2257b6156b 100644
> --- a/dts/framework/remote_session/single_active_interactive_shell.py
> +++ b/dts/framework/remote_session/single_active_interactive_shell.py
> @@ -92,6 +92,7 @@ def __init__(
>          node: Node,
>          name: str | None =3D None,
>          privileged: bool =3D False,
> +        path: PurePath | None =3D None,
>          app_params: Params =3D Params(),
>          **kwargs,
>      ) -> None:
> @@ -105,6 +106,7 @@ def __init__(
>              name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
>                  the name of the underlying node which it is running on.
>              privileged: Enables the shell to run as superuser.
> +            path: Path to the executable. If :data:`None`, then the clas=
s' path attribute is used.
>              app_params: The command line parameters to be passed to the =
application on startup.
>              **kwargs: Any additional arguments if any.
>          """
> @@ -116,7 +118,7 @@ def __init__(
>          self._privileged =3D privileged
>          self._timeout =3D SETTINGS.timeout
>          # Ensure path is properly formatted for the host
> -        self._update_real_path(self.path)
> +        self._update_real_path(path or self.path)
>          super().__init__(**kwargs)
>
>      def _setup_ssh_channel(self):
> @@ -133,7 +135,7 @@ def _make_start_command(self) -> str:
>              start_command =3D self._node.main_session._get_privileged_co=
mmand(start_command)
>          return start_command
>
> -    def _start_application(self) -> None:
> +    def _start_application(self, prompt: str | None =3D None) -> None:
>          """Starts a new interactive application based on the path to the=
 app.
>
>          This method is often overridden by subclasses as their process f=
or starting may look
> @@ -141,6 +143,10 @@ def _start_application(self) -> None:
>          `self._init_attempts` - 1 times. This is done because some DPDK =
applications need slightly
>          more time after exiting their script to clean up EAL before othe=
rs can start.
>
> +        Args:
> +            prompt: When starting up the application, expect this string=
 at the end of stdout when
> +                the application is ready. If :data:`None`, the class' de=
fault prompt will be used.
> +
>          Raises:
>              InteractiveCommandExecutionError: If the application fails t=
o start within the allotted
>                  number of retries.
> @@ -151,7 +157,7 @@ def _start_application(self) -> None:
>          self.is_alive =3D True
>          for attempt in range(self._init_attempts):
>              try:
> -                self.send_command(start_command)
> +                self.send_command(start_command, prompt)
>                  break
>              except InteractiveSSHTimeoutError:
>                  self._logger.info(
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framewor=
k/remote_session/testpmd_shell.py
> index 1f291fcb68..db1bfaa9d1 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1540,7 +1540,7 @@ def __init__(
>          """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes ap=
p_params to kwargs."""
>          if "port_topology" not in app_params and get_ctx().topology.type=
 is TopologyType.one_link:
>              app_params["port_topology"] =3D PortTopology.loop
> -        super().__init__(name, privileged, TestPmdParams(**app_params))
> +        super().__init__(name, privileged, app_params=3DTestPmdParams(**=
app_params))
>          self.ports_started =3D not self._app_params.disable_device_start
>          self._ports =3D None
>
> --
> 2.43.0
>
