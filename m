Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6F9C8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 16:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A943540662;
	Fri,  4 Jul 2025 18:42:31 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id C13894028E
 for <dev@dpdk.org>; Fri,  4 Jul 2025 18:42:29 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-312e747d2d8so1820796a91.0
 for <dev@dpdk.org>; Fri, 04 Jul 2025 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751647349; x=1752252149; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xr7ZVpn2EPi4gWO0g2yRpJDq9nmltJfeOgMAAzDjoAw=;
 b=hpXQYqAd7UiH0eOhw77W9l/2GFYxRZVa7tPPU98vlsiditNGzskMj7XOR31b5QCZ2i
 DZTRwE5Ie/aGXjIuUkwVfT7N7k29nwf6oBjKqY3FhsemrRZxCRKmFVwCM49LwSI9JR4p
 o3qDxE9d1KDuxdmd0pqEdK0EgToNBbff/VZwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751647349; x=1752252149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xr7ZVpn2EPi4gWO0g2yRpJDq9nmltJfeOgMAAzDjoAw=;
 b=Fn5Mbzr0PI1GahM7YLQTJxt8BnJQf2h946c6VXzLRXkaOytnB+jnVy+WsuFsEjJr1/
 94JFUEcXgStXPN4vzO1YPqko4C3RWFIPQ2QqCndPMrZCKhgW3dxUVn9rKw3RDBd7hv37
 NBft/cdZ7D/ag+OJLS4sZOXPImwLCXcj8VZA+4nfvePEZqjLfwlHEtkQpy14D2tdfTb9
 SPjCpXQnotM75TfFXi3TvsgQP1xo4c8rcUnx4Fy6YqqkXeo8DND3JrrH1fLrKaEKxkzb
 JzfMt3LU3TFtTKkAX9MB+EjN9vOroHl//JRI1/yxmxnJVoZz7u/9dv9nKKayjBo8CSDP
 vLfQ==
X-Gm-Message-State: AOJu0Yx4zl7+R+jYk2YaLEK4mVgPPXwiJ9PWqqgpwo0KbFfk74PBHG5j
 Roil1H+EtqLIs6xtln62XOWA6fZYIWn0sMEwezrGQRteIMyYssYCeLcepNwEfGZlUt1ZPQUsNAs
 YhfiPn+sq7zrQ62TV6ZORNaUX50WqOeACyhwShxfLBA==
X-Gm-Gg: ASbGnctLH5M2cxtfKA69YAQB6YxH4Zm4CtmwulrfCaCuT4vCEL+DVXc5wjkJF6nwkrh
 IQclYoDGW59myEHaOEKNn0Ru0x8zeXRrn+eerYXYtvs6aLCtCCKwAurg4FRnEfG/NnUBW7kX6Ks
 ydMHZ4sVrhnHFPqwg8ne2VeeFZHPH9X077b12OFR9RkVu1gxePFzJCpM61ydYlzrtQNoKDUg==
X-Google-Smtp-Source: AGHT+IGtsakaCBpj70Nmg/ItRx5yGAgcllJ5QlP4HIOguSsDvur2aLGmJAjqsHnM1szblJukR4MphHuqUzxInpJSHKs=
X-Received: by 2002:a17:90b:3a05:b0:311:b5ac:6f7d with SMTP id
 98e67ed59e1d1-31aab854e04mr4796363a91.6.1751647348875; Fri, 04 Jul 2025
 09:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250704152908.683265-1-luca.vizzarro@arm.com>
 <20250704152908.683265-3-luca.vizzarro@arm.com>
In-Reply-To: <20250704152908.683265-3-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 12:36:51 -0400
X-Gm-Features: Ac12FXzX6_3C2PNDEsehBFhIHk63qX__CvyOoMyCxgWJfUkIH0J2-jEZmxyXkfs
Message-ID: <CAJvnSUA2EZaGb9p0RRH3MputmjWZFjZ8OFEnVCVaDOctQ=6QnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add generic blocking app class
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000007f2f06391d2e1d"
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

--000000000000007f2f06391d2e1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Fri, Jul 4, 2025 at 11:30=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> Add a generic blocking app class to allow a test writer to run any app
> in the background. Make the original BlockingDPDKApp class inherit from
> this one. Implement the new BlockingApp class in the packet_capture test
> suite.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/remote_session/blocking_app.py | 135 +++++++++++++++++++
>  dts/framework/remote_session/dpdk_app.py     |  80 -----------
>  dts/tests/TestSuite_packet_capture.py        |  66 +++------
>  3 files changed, 154 insertions(+), 127 deletions(-)
>  create mode 100644 dts/framework/remote_session/blocking_app.py
>  delete mode 100644 dts/framework/remote_session/dpdk_app.py
>
> diff --git a/dts/framework/remote_session/blocking_app.py
> b/dts/framework/remote_session/blocking_app.py
> new file mode 100644
> index 0000000000..8de536c259
> --- /dev/null
> +++ b/dts/framework/remote_session/blocking_app.py
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Class to run blocking apps in the background.
> +
> +The class won't automatically start the app. The start-up is done as par=
t
> of the
> +:meth:`BlockingApp.wait_until_ready` method, which will return execution
> to the caller only
> +when the desired stdout has been returned by the app. Usually this is
> used to detect when the app
> +has been loaded and ready to be used.
> +
> +This module also provides the class :class:`BlockingDPDKApp` useful to
> run any DPDK app from the
> +DPDK build dir.
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
> +from typing import Generic, TypeVar, cast
> +
> +from typing_extensions import Self
> +
> +from framework.context import get_ctx
> +from framework.params import Params
> +from framework.params.eal import EalParams
> +from framework.remote_session.dpdk_shell import compute_eal_params
> +from framework.remote_session.interactive_shell import InteractiveShell
> +from framework.testbed_model.node import Node
> +
> +P =3D TypeVar("P", bound=3DParams)
> +
> +
> +class BlockingApp(InteractiveShell, Generic[P]):
> +    """Class to manage generic blocking apps."""
> +
> +    _app_params: P
> +
> +    def __init__(
> +        self,
> +        node: Node,
> +        path: PurePath,
> +        name: str | None =3D None,
> +        privileged: bool =3D False,
> +        app_params: P | str =3D "",
> +    ) -> None:
> +        """Constructor.
> +
> +        Args:
> +            node: The node to run the app on.
> +            path: Path to the application on the node.
> +            name: Name to identify this application.
> +            privileged: Run as privileged user.
> +            app_params: The application parameters. Can be of any type
> inheriting :class:`Params` or
> +                a plain string.
> +        """
> +        if isinstance(app_params, str):
> +            params =3D Params()
> +            params.append_str(app_params)
> +            app_params =3D cast(P, params)
> +
> +        self._path =3D path
> +
> +        super().__init__(node, name, privileged, app_params)
> +
> +    @property
> +    def path(self) -> PurePath:
> +        """The path of the DPDK app relative to the DPDK build folder.""=
"
> +        return self._path
> +
> +    def wait_until_ready(self, end_token: str) -> Self:
> +        """Start app and wait until ready.
> +
> +        Args:
> +            end_token: The string at the end of a line that indicates th=
e
> app is ready.
> +
> +        Returns:
> +            Itself.
> +        """
> +        self.start_application(end_token)
> +        return self
> +
> +    def close(self) -> None:
> +        """Close the application.
> +
> +        Sends a SIGINT to close the application.
> +        """
> +        self.send_command("\x03")
> +        super().close()
> +
> +
> +PE =3D TypeVar("PE", bound=3DEalParams)
> +
> +
> +class BlockingDPDKApp(BlockingApp, Generic[PE]):
> +    """Class to manage blocking DPDK apps on the SUT."""
> +
> +    _app_params: PE
> +
> +    def __init__(
> +        self,
> +        path: PurePath,
> +        name: str | None =3D None,
> +        privileged: bool =3D True,
> +        app_params: PE | str =3D "",
> +    ) -> None:
> +        """Constructor.
> +
> +        Args:
> +            path: Path relative to the DPDK build to the executable.
> +            name: Name to identify this application.
> +            privileged: Run as privileged user.
> +            app_params: The application parameters. If a string or an
> incomplete :class:`EalParams`
> +                object are passed, the EAL params are computed based on
> the current context.
> +        """
> +        if isinstance(app_params, str):
> +            eal_params =3D compute_eal_params()
> +            eal_params.append_str(app_params)
> +            app_params =3D cast(PE, eal_params)
> +        else:
> +            app_params =3D cast(PE, compute_eal_params(app_params))
> +
> +        node =3D get_ctx().sut_node
> +        path =3D
> PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpath(self.path)
> +
> +        super().__init__(node, path, name, privileged, app_params)
> diff --git a/dts/framework/remote_session/dpdk_app.py
> b/dts/framework/remote_session/dpdk_app.py
> deleted file mode 100644
> index dc4b817bdd..0000000000
> --- a/dts/framework/remote_session/dpdk_app.py
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2025 Arm Limited
> -
> -"""Class to run blocking DPDK apps in the background.
> -
> -The class won't automatically start the app. The start-up is done as par=
t
> of the
> -:meth:`BlockingDPDKApp.wait_until_ready` method, which will return
> execution to the caller only
> -when the desired stdout has been returned by the app. Usually this is
> used to detect when the app
> -has been loaded and ready to be used.
> -
> -Example:
> -    ..code:: python
> -
> -        pdump =3D BlockingDPDKApp(
> -            PurePath("app/dpdk-pdump"),
> -            app_params=3D"--pdump 'port=3D0,queue=3D*,rx-dev=3D/tmp/rx-d=
ev.pcap'"
> -        )
> -        pdump.wait_until_ready("65535") # start app
> -
> -        # pdump is now ready to capture
> -
> -        pdump.close() # stop/close app
> -"""
> -
> -from pathlib import PurePath
> -
> -from framework.params.eal import EalParams
> -from framework.remote_session.dpdk_shell import DPDKShell
> -
> -
> -class BlockingDPDKApp(DPDKShell):
> -    """Class to manage blocking DPDK apps."""
> -
> -    def __init__(
> -        self,
> -        path: PurePath,
> -        name: str | None =3D None,
> -        privileged: bool =3D True,
> -        app_params: EalParams | str =3D "",
> -    ) -> None:
> -        """Constructor.
> -
> -        Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`.
> -
> -        Args:
> -            path: Path relative to the DPDK build to the executable.
> -            name: Name to identify this application.
> -            privileged: Run as privileged user.
> -            app_params: The application parameters. If a string or an
> incomplete :class:`EalParams`
> -                object are passed, the EAL params are computed based on
> the current context.
> -        """
> -        if isinstance(app_params, str):
> -            eal_params =3D EalParams()
> -            eal_params.append_str(app_params)
> -            app_params =3D eal_params
> -
> -        self._path =3D path
> -
> -        super().__init__(name, privileged, app_params)
> -
> -    @property
> -    def path(self) -> PurePath:
> -        """The path of the DPDK app relative to the DPDK build folder.""=
"
> -        return self._path
> -
> -    def wait_until_ready(self, end_token: str) -> None:
> -        """Start app and wait until ready.
> -
> -        Args:
> -            end_token: The string at the end of a line that indicates th=
e
> app is ready.
> -        """
> -        self.start_application(end_token)
> -
> -    def close(self) -> None:
> -        """Close the application.
> -
> -        Sends a SIGINT to close the application.
> -        """
> -        self.send_command("\x03")
> -        super().close()
> diff --git a/dts/tests/TestSuite_packet_capture.py
> b/dts/tests/TestSuite_packet_capture.py
> index e162bded87..bad243a571 100644
> --- a/dts/tests/TestSuite_packet_capture.py
> +++ b/dts/tests/TestSuite_packet_capture.py
> @@ -24,12 +24,10 @@
>  from scapy.layers.sctp import SCTP
>  from scapy.packet import Packet, Raw, raw
>  from scapy.utils import rdpcap
> -from typing_extensions import Self
>
> -from framework.context import get_ctx
>  from framework.params import Params
> +from framework.remote_session.blocking_app import BlockingApp
>  from framework.remote_session.dpdk_shell import compute_eal_params
> -from framework.remote_session.interactive_shell import InteractiveShell
>  from framework.remote_session.testpmd_shell import TestPmdShell
>  from framework.settings import SETTINGS
>  from framework.test_suite import TestSuite, func_test
> @@ -61,57 +59,31 @@ class DumpcapParams(Params):
>      packet_filter: str | None =3D field(default=3DNone,
> metadata=3DParams.short("f"))
>
>
> -class Dumpcap(InteractiveShell):
> -    """Class to spawn and manage a dpdk-dumpcap process.
> -
> -    The dpdk-dumpcap is a DPDK app but instead of providing a regular
> DPDK EAL interface to the
> -    user, it replicates the Wireshark dumpcap app.
> -    """
> -
> -    _app_params: DumpcapParams
> -
> -    def __init__(self, params: DumpcapParams) -> None:
> -        """Extends
> :meth:`~.interactive_shell.InteractiveShell.__init__`."""
> -        self.ctx =3D get_ctx()
> -        eal_params =3D compute_eal_params()
> -        params.lcore_list =3D eal_params.lcore_list
> -        params.file_prefix =3D eal_params.prefix
> -
> -        super().__init__(self.ctx.sut_node, name=3DNone, privileged=3DTr=
ue,
> app_params=3Dparams)
> -
> -    @property
> -    def path(self) -> PurePath:
> -        """Path to the shell executable."""
> -        return
> PurePath(self.ctx.dpdk_build.remote_dpdk_build_dir).joinpath("app/dpdk-du=
mpcap")
> -
> -    def wait_until_ready(self) -> Self:
> -        """Start app and wait until ready."""
> -        self.start_application(f"Capturing on
> '{self._app_params.interface}'")
> -        return self
> -
> -    def close(self) -> None:
> -        """Close the application.
> -
> -        Sends a SIGINT to close the application.
> -        """
> -        self.send_command("\x03")
> -        super().close()
> -
> -
>  @requires(topology_type=3DTopologyType.two_links)
>  class TestPacketCapture(TestSuite):
>      """Packet Capture TestSuite.
>
>      Attributes:
> -        packets: List of packets to send for testing pdump.
> -        rx_pcap_path: The remote path where to create the Rx packets pca=
p
> with pdump.
> -        tx_pcap_path: The remote path where to create the Tx packets pca=
p
> with pdump.
> +        packets: List of packets to send for testing dumpcap.
> +        rx_pcap_path: The remote path where to create the Rx packets pca=
p
> with dumpcap.
> +        tx_pcap_path: The remote path where to create the Tx packets pca=
p
> with dumpcap.
>      """
>
>      packets: list[Packet]
>      rx_pcap_path: PurePath
>      tx_pcap_path: PurePath
>
> +    def _run_dumpcap(self, params: DumpcapParams) -> BlockingApp:
> +        eal_params =3D compute_eal_params()
> +        params.lcore_list =3D eal_params.lcore_list
> +        params.file_prefix =3D eal_params.prefix
> +        return BlockingApp(
> +            self._ctx.sut_node,
> +            self._ctx.dpdk_build.get_app("dumpcap"),
> +            app_params=3Dparams,
> +            privileged=3DTrue,
> +        ).wait_until_ready(f"Capturing on '{params.interface}'")
> +
>      def set_up_suite(self) -> None:
>          """Test suite setup.
>
> @@ -147,21 +119,21 @@ def _load_pcap_packets(self, remote_pcap_path:
> PurePath) -> list[Packet]:
>      def _send_and_dump(
>          self, packet_filter: str | None =3D None, rx_only: bool =3D Fals=
e
>      ) -> list[Packet]:
> -        dumpcap_rx =3D Dumpcap(
> +        dumpcap_rx =3D self._run_dumpcap(
>              DumpcapParams(
>                  interface=3Dself.topology.sut_port_ingress.pci,
>                  output_pcap_path=3Dself.rx_pcap_path,
>                  packet_filter=3Dpacket_filter,
>              )
> -        ).wait_until_ready()
> +        )
>          if not rx_only:
> -            dumpcap_tx =3D Dumpcap(
> +            dumpcap_tx =3D self._run_dumpcap(
>                  DumpcapParams(
>                      interface=3Dself.topology.sut_port_egress.pci,
>                      output_pcap_path=3Dself.tx_pcap_path,
>                      packet_filter=3Dpacket_filter,
>                  )
> -            ).wait_until_ready()
> +            )
>
>          received_packets =3D self.send_packets_and_capture(
>              self.packets, PacketFilteringConfig(no_lldp=3DFalse)
> --
> 2.43.0
>
>

--000000000000007f2f06391d2e1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
Jul 4, 2025 at 11:30=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vi=
zzarro@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Add a generic blocking app class to al=
low a test writer to run any app<br>
in the background. Make the original BlockingDPDKApp class inherit from<br>
this one. Implement the new BlockingApp class in the packet_capture test<br=
>
suite.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/blocking_app.py | 135 ++++++++++++++++++=
+<br>
=C2=A0dts/framework/remote_session/dpdk_app.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 8=
0 -----------<br>
=C2=A0dts/tests/TestSuite_packet_capture.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 66 +++------<br>
=C2=A03 files changed, 154 insertions(+), 127 deletions(-)<br>
=C2=A0create mode 100644 dts/framework/remote_session/blocking_app.py<br>
=C2=A0delete mode 100644 dts/framework/remote_session/dpdk_app.py<br>
<br>
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/r=
emote_session/blocking_app.py<br>
new file mode 100644<br>
index 0000000000..8de536c259<br>
--- /dev/null<br>
+++ b/dts/framework/remote_session/blocking_app.py<br>
@@ -0,0 +1,135 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;Class to run blocking apps in the background.<br>
+<br>
+The class won&#39;t automatically start the app. The start-up is done as p=
art of the<br>
+:meth:`BlockingApp.wait_until_ready` method, which will return execution t=
o the caller only<br>
+when the desired stdout has been returned by the app. Usually this is used=
 to detect when the app<br>
+has been loaded and ready to be used.<br>
+<br>
+This module also provides the class :class:`BlockingDPDKApp` useful to run=
 any DPDK app from the<br>
+DPDK build dir.<br>
+<br>
+Example:<br>
+=C2=A0 =C2=A0 ..code:: python<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump =3D BlockingDPDKApp(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PurePath(&quot;app/dpdk-pdump&qu=
ot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params=3D&quot;--pdump &#39;=
port=3D0,queue=3D*,rx-dev=3D/tmp/rx-dev.pcap&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump.wait_until_ready(&quot;65535&quot;) # st=
art app<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pdump is now ready to capture<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump.close() # stop/close app<br>
+&quot;&quot;&quot;<br>
+<br>
+from pathlib import PurePath<br>
+from typing import Generic, TypeVar, cast<br>
+<br>
+from typing_extensions import Self<br>
+<br>
+from framework.context import get_ctx<br>
+from framework.params import Params<br>
+from framework.params.eal import EalParams<br>
+from framework.remote_session.dpdk_shell import compute_eal_params<br>
+from framework.remote_session.interactive_shell import InteractiveShell<br=
>
+from framework.testbed_model.node import Node<br>
+<br>
+P =3D TypeVar(&quot;P&quot;, bound=3DParams)<br>
+<br>
+<br>
+class BlockingApp(InteractiveShell, Generic[P]):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class to manage generic blocking apps.&quo=
t;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 _app_params: P<br>
+<br>
+=C2=A0 =C2=A0 def __init__(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 node: Node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path: PurePath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str | None =3D None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: bool =3D False,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: P | str =3D &quot;&quot;,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Constructor.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node: The node to run the app on=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: Path to the application on=
 the node.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: Name to identify this appl=
ication.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: Run as privileged us=
er.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: The application para=
meters. Can be of any type inheriting :class:`Params` or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a plain string.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(app_params, str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params =3D Params()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params.append_str(app_params)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params =3D cast(P, params)<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._path =3D path<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(node, name, privileged, app_p=
arams)<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The path of the DPDK app rel=
ative to the DPDK build folder.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._path<br>
+<br>
+=C2=A0 =C2=A0 def wait_until_ready(self, end_token: str) -&gt; Self:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start app and wait until rea=
dy.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_token: The string at the end=
 of a line that indicates the app is ready.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Itself.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_application(end_token)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self<br>
+<br>
+=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Close the application.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sends a SIGINT to close the application.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;\x03&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().close()<br>
+<br>
+<br>
+PE =3D TypeVar(&quot;PE&quot;, bound=3DEalParams)<br>
+<br>
+<br>
+class BlockingDPDKApp(BlockingApp, Generic[PE]):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Class to manage blocking DPDK apps on the =
SUT.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 _app_params: PE<br>
+<br>
+=C2=A0 =C2=A0 def __init__(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path: PurePath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str | None =3D None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: bool =3D True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: PE | str =3D &quot;&quot;,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Constructor.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: Path relative to the DPDK =
build to the executable.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: Name to identify this appl=
ication.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: Run as privileged us=
er.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: The application para=
meters. If a string or an incomplete :class:`EalParams`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object are passed,=
 the EAL params are computed based on the current context.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(app_params, str):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params =3D compute_eal_param=
s()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params.append_str(app_params=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params =3D cast(PE, eal_para=
ms)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params =3D cast(PE, compute_=
eal_params(app_params))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D get_ctx().sut_node<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D PurePath(get_ctx().dpdk_build.remote_=
dpdk_build_dir).joinpath(self.path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(node, path, name, privileged,=
 app_params)<br>
diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/remot=
e_session/dpdk_app.py<br>
deleted file mode 100644<br>
index dc4b817bdd..0000000000<br>
--- a/dts/framework/remote_session/dpdk_app.py<br>
+++ /dev/null<br>
@@ -1,80 +0,0 @@<br>
-# SPDX-License-Identifier: BSD-3-Clause<br>
-# Copyright(c) 2025 Arm Limited<br>
-<br>
-&quot;&quot;&quot;Class to run blocking DPDK apps in the background.<br>
-<br>
-The class won&#39;t automatically start the app. The start-up is done as p=
art of the<br>
-:meth:`BlockingDPDKApp.wait_until_ready` method, which will return executi=
on to the caller only<br>
-when the desired stdout has been returned by the app. Usually this is used=
 to detect when the app<br>
-has been loaded and ready to be used.<br>
-<br>
-Example:<br>
-=C2=A0 =C2=A0 ..code:: python<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump =3D BlockingDPDKApp(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PurePath(&quot;app/dpdk-pdump&qu=
ot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params=3D&quot;--pdump &#39;=
port=3D0,queue=3D*,rx-dev=3D/tmp/rx-dev.pcap&#39;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump.wait_until_ready(&quot;65535&quot;) # st=
art app<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pdump is now ready to capture<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdump.close() # stop/close app<br>
-&quot;&quot;&quot;<br>
-<br>
-from pathlib import PurePath<br>
-<br>
-from framework.params.eal import EalParams<br>
-from framework.remote_session.dpdk_shell import DPDKShell<br>
-<br>
-<br>
-class BlockingDPDKApp(DPDKShell):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Class to manage blocking DPDK apps.&quot;&=
quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 def __init__(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 path: PurePath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str | None =3D None,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: bool =3D True,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: EalParams | str =3D &quot;&quot;,<=
br>
-=C2=A0 =C2=A0 ) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Constructor.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Overrides :meth:`~.dpdk_shell.DPDKShell.__init=
__`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: Path relative to the DPDK =
build to the executable.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: Name to identify this appl=
ication.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged: Run as privileged us=
er.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: The application para=
meters. If a string or an incomplete :class:`EalParams`<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object are passed,=
 the EAL params are computed based on the current context.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(app_params, str):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params =3D EalParams()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params.append_str(app_params=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params =3D eal_params<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._path =3D path<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(name, privileged, app_params)=
<br>
-<br>
-=C2=A0 =C2=A0 @property<br>
-=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The path of the DPDK app rel=
ative to the DPDK build folder.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._path<br>
-<br>
-=C2=A0 =C2=A0 def wait_until_ready(self, end_token: str) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start app and wait until rea=
dy.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_token: The string at the end=
 of a line that indicates the app is ready.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_application(end_token)<br>
-<br>
-=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Close the application.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sends a SIGINT to close the application.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;\x03&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().close()<br>
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_pa=
cket_capture.py<br>
index e162bded87..bad243a571 100644<br>
--- a/dts/tests/TestSuite_packet_capture.py<br>
+++ b/dts/tests/TestSuite_packet_capture.py<br>
@@ -24,12 +24,10 @@<br>
=C2=A0from scapy.layers.sctp import SCTP<br>
=C2=A0from scapy.packet import Packet, Raw, raw<br>
=C2=A0from scapy.utils import rdpcap<br>
-from typing_extensions import Self<br>
<br>
-from framework.context import get_ctx<br>
=C2=A0from framework.params import Params<br>
+from framework.remote_session.blocking_app import BlockingApp<br>
=C2=A0from framework.remote_session.dpdk_shell import compute_eal_params<br=
>
-from framework.remote_session.interactive_shell import InteractiveShell<br=
>
=C2=A0from framework.remote_session.testpmd_shell import TestPmdShell<br>
=C2=A0from framework.settings import SETTINGS<br>
=C2=A0from framework.test_suite import TestSuite, func_test<br>
@@ -61,57 +59,31 @@ class DumpcapParams(Params):<br>
=C2=A0 =C2=A0 =C2=A0packet_filter: str | None =3D field(default=3DNone, met=
adata=3DParams.short(&quot;f&quot;))<br>
<br>
<br>
-class Dumpcap(InteractiveShell):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;Class to spawn and manage a dpdk-dumpcap p=
rocess.<br>
-<br>
-=C2=A0 =C2=A0 The dpdk-dumpcap is a DPDK app but instead of providing a re=
gular DPDK EAL interface to the<br>
-=C2=A0 =C2=A0 user, it replicates the Wireshark dumpcap app.<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 _app_params: DumpcapParams<br>
-<br>
-=C2=A0 =C2=A0 def __init__(self, params: DumpcapParams) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Extends :meth:`~.interactive=
_shell.InteractiveShell.__init__`.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ctx =3D get_ctx()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params =3D compute_eal_params()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.lcore_list =3D eal_params.lcore_list<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.file_prefix =3D eal_params.prefix<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(self.ctx.sut_node, name=3DNon=
e, privileged=3DTrue, app_params=3Dparams)<br>
-<br>
-=C2=A0 =C2=A0 @property<br>
-=C2=A0 =C2=A0 def path(self) -&gt; PurePath:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Path to the shell executable=
.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return PurePath(self.ctx.dpdk_build.remote_dpd=
k_build_dir).joinpath(&quot;app/dpdk-dumpcap&quot;)<br>
-<br>
-=C2=A0 =C2=A0 def wait_until_ready(self) -&gt; Self:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Start app and wait until rea=
dy.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.start_application(f&quot;Capturing on &#3=
9;{self._app_params.interface}&#39;&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self<br>
-<br>
-=C2=A0 =C2=A0 def close(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Close the application.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sends a SIGINT to close the application.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(&quot;\x03&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().close()<br>
-<br>
-<br>
=C2=A0@requires(topology_type=3DTopologyType.two_links)<br>
=C2=A0class TestPacketCapture(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Packet Capture TestSuite.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Attributes:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets to send for testing p=
dump.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_pcap_path: The remote path where to create =
the Rx packets pcap with pdump.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pcap_path: The remote path where to create =
the Tx packets pcap with pdump.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: List of packets to send for testing d=
umpcap.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_pcap_path: The remote path where to create =
the Rx packets pcap with dumpcap.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pcap_path: The remote path where to create =
the Tx packets pcap with dumpcap.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0packets: list[Packet]<br>
=C2=A0 =C2=A0 =C2=A0rx_pcap_path: PurePath<br>
=C2=A0 =C2=A0 =C2=A0tx_pcap_path: PurePath<br>
<br>
+=C2=A0 =C2=A0 def _run_dumpcap(self, params: DumpcapParams) -&gt; Blocking=
App:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_params =3D compute_eal_params()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.lcore_list =3D eal_params.lcore_list<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 params.file_prefix =3D eal_params.prefix<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return BlockingApp(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ctx.sut_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ctx.dpdk_build.get_app(&qu=
ot;dumpcap&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params=3Dparams,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privileged=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ).wait_until_ready(f&quot;Capturing on &#39;{p=
arams.interface}&#39;&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def set_up_suite(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test suite setup.<br>
<br>
@@ -147,21 +119,21 @@ def _load_pcap_packets(self, remote_pcap_path: PurePa=
th) -&gt; list[Packet]:<br>
=C2=A0 =C2=A0 =C2=A0def _send_and_dump(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self, packet_filter: str | None =3D None,=
 rx_only: bool =3D False<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; list[Packet]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dumpcap_rx =3D Dumpcap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dumpcap_rx =3D self._run_dumpcap(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DumpcapParams(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interface=3Ds=
elf.topology.sut_port_ingress.pci,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_pcap_p=
ath=3Dself.rx_pcap_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet_filter=
=3Dpacket_filter,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ).wait_until_ready()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not rx_only:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dumpcap_tx =3D Dumpcap(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dumpcap_tx =3D self._run_dumpcap=
(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DumpcapParams=
(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0interface=3Dself.topology.sut_port_egress.pci,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0output_pcap_path=3Dself.tx_pcap_path,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0packet_filter=3Dpacket_filter,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ).wait_until_ready()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0received_packets =3D self.send_packets_an=
d_capture(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.packets, PacketFilteri=
ngConfig(no_lldp=3DFalse)<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000007f2f06391d2e1d--
