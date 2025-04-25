Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A049C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 759B84025E;
	Fri, 25 Apr 2025 20:39:46 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id A378C4021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 20:39:45 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22403c99457so5472755ad.3
 for <dev@dpdk.org>; Fri, 25 Apr 2025 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745606385; x=1746211185; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbI9exl89zIO1RoeqIA1n1zBMoBSH/x3X/BtUXGYdzo=;
 b=O1HuB2wfuk7g4OgO/0tftIBBR6HPrA4FNRpTcob7K12Lei1BqDcPgS5RRPYWD/ag0O
 K6Pwe6yQZSPXgyYpWuraV3k8avZoofsGZHw8argGUosnVsqP9bl/ZSCk9OxBjCQDU0P1
 2UsqrR2QtaBv/9v7CGgP76Lg5NjAo/Dw0u3SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745606385; x=1746211185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbI9exl89zIO1RoeqIA1n1zBMoBSH/x3X/BtUXGYdzo=;
 b=uJCM7MwSN0rcYH0kwdw09T0l2l18Esq8oRuy0noYPEgHyfST5J9ZidPvKUkbaU2iZT
 Er32XrtbvavPtVUhB2dvHIqzzQvH9nEcTn68VUk9o3vSGBzLULNXrjNERZ9OqQMEeuV3
 Clgz8doF7imO55G5b822+4fvlz9yEebVPfUWaxFSrOt93OCddu5TPQAsX1sNCJWT1R5v
 mk6kKN7U/p65rCKCsHhWIF7wn0KV9PyFF03/VQqOU2iEbTlxR+fHSvkOmmYPqYLIbNCZ
 RmjinO/gdDWFINWbrJ5LbJ4rd2Xw3YyGe5p+QoWJ82/l+EuEOv50NmWgXG4/4F3hEvhx
 9uyw==
X-Gm-Message-State: AOJu0YwTCsOFxUyRiBM2xYOdgzXg1OjS90t+PZ05PHGtkzLB0yEvXjpV
 ycVCty3S7gqsI48/i32wx86ViTI4NQ78dwTebMgEmD5pGIeoxaB+oubbOjBZIAx5JCSyoHr9zNd
 jmdZx+ZPNNR8VJc7CC88ZjqPaqztvbklNbP9uww==
X-Gm-Gg: ASbGncuW1zoyih0bN7lPrClO07lkypeq0gIY6u8G2uAdzxdfUOGD/QG9R3GDH6u/MfN
 2MZTOKbzZu1cosvMrVziL3QHHBKbogFlsc/WRtb1S91h7gxBLgtzgWkjLI/E8IkSgilqI35jvDi
 e1mEgwfTL7k2rD+wciXcvyCsNj0h3YL77kGvgKiAFrya0IyTJ24IiqWtO+
X-Google-Smtp-Source: AGHT+IHqfW4bQ2V1Ss+s1dO8583C2vQW1qRiGShJxseEOvhs4sa5UgdDeSvvGJxiFFTeyjC8p5uWKxUp6Q8g6FRC08o=
X-Received: by 2002:a17:90b:3ec6:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-309f7e58627mr2156155a91.4.1745606384650; Fri, 25 Apr 2025
 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-7-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-7-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 25 Apr 2025 14:39:33 -0400
X-Gm-Features: ATxdqUGitWekAyU2zYD0_fVLO15XrNGSHQHeK2ekRpvPjMFRU116D9sFGePcOcQ
Message-ID: <CAKXZ7ej8rOV2hCs3faosxdLXsKdwSSv7aqfVfs83WkwiJQxZYg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dts: remove multi-inheritance classes
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
> Multi inheritance has proven to be flaky in Python, therefore revert
> back to a simpler approach where classes will only inherit one base
> class. As part of this change, instead of making the
> ScapyTrafficGenerator class inehrit a PythonShell, use simple class
> composition, by making the shell a class attribute.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  .../remote_session/interactive_shell.py       |  9 +----
>  .../testbed_model/traffic_generator/scapy.py  | 38 +++++++++----------
>  .../traffic_generator/traffic_generator.py    |  6 +--
>  dts/framework/utils.py                        | 14 -------
>  4 files changed, 22 insertions(+), 45 deletions(-)
>
> diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/fram=
ework/remote_session/interactive_shell.py
> index 6b7ca0b6af..d7e566e5c4 100644
> --- a/dts/framework/remote_session/interactive_shell.py
> +++ b/dts/framework/remote_session/interactive_shell.py
> @@ -37,10 +37,9 @@
>  from framework.params import Params
>  from framework.settings import SETTINGS
>  from framework.testbed_model.node import Node
> -from framework.utils import MultiInheritanceBaseClass
>
>
> -class InteractiveShell(MultiInheritanceBaseClass, ABC):
> +class InteractiveShell(ABC):
>      """The base class for managing interactive shells.
>
>      This class shouldn't be instantiated directly, but instead be extend=
ed. It contains
> @@ -90,20 +89,15 @@ def __init__(
>          name: str | None =3D None,
>          privileged: bool =3D False,
>          app_params: Params =3D Params(),
> -        **kwargs,
>      ) -> None:
>          """Create an SSH channel during initialization.
>
> -        Additional keyword arguments can be passed through `kwargs` if n=
eeded for fulfilling other
> -        constructors in the case of multiple inheritance.
> -
>          Args:
>              node: The node on which to run start the interactive shell.
>              name: Name for the interactive shell to use for logging. Thi=
s name will be appended to
>                  the name of the underlying node which it is running on.
>              privileged: Enables the shell to run as superuser.
>              app_params: The command line parameters to be passed to the =
application on startup.
> -            **kwargs: Any additional arguments if any.
>          """
>          self._node =3D node
>          if name is None:
> @@ -112,7 +106,6 @@ def __init__(
>          self._app_params =3D app_params
>          self._privileged =3D privileged
>          self._timeout =3D SETTINGS.timeout
> -        super().__init__(**kwargs)
>
>      def _setup_ssh_channel(self):
>          self._ssh_channel =3D self._node.main_session.interactive_sessio=
n.session.invoke_shell()
> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts=
/framework/testbed_model/traffic_generator/scapy.py
> index 520561b2eb..78a6ded74c 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -34,7 +34,7 @@
>  from .capturing_traffic_generator import CapturingTrafficGenerator
>
>
> -class ScapyTrafficGenerator(PythonShell, CapturingTrafficGenerator):
> +class ScapyTrafficGenerator(CapturingTrafficGenerator):
>      """Provides access to scapy functions on a traffic generator node.
>
>      This class extends the base with remote execution of scapy functions=
. All methods for
> @@ -56,6 +56,8 @@ class also extends :class:`.capturing_traffic_generator=
.CapturingTrafficGenerato
>      first.
>      """
>
> +    _shell: PythonShell
> +
>      _config: ScapyTrafficGeneratorConfig
>
>      #: Name of sniffer to ensure the same is used in all places
> @@ -82,25 +84,21 @@ def __init__(self, tg_node: Node, config: ScapyTraffi=
cGeneratorConfig, **kwargs)
>              tg_node.config.os =3D=3D OS.linux
>          ), "Linux is the only supported OS for scapy traffic generation"
>
> -        super().__init__(node=3Dtg_node, config=3Dconfig, tg_node=3Dtg_n=
ode, **kwargs)
> -        self.start_application()
> +        super().__init__(tg_node=3Dtg_node, config=3Dconfig, **kwargs)
> +        self._shell =3D PythonShell(tg_node, "scapy", privileged=3DTrue)
>
>      def setup(self, ports: Iterable[Port]):
>          """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
>
> -        Brings up the port links.
> +        Starts up the traffic generator and brings up the port links.
>          """
> -        super().setup(ports)
>          self._tg_node.main_session.bring_up_link(ports)
> +        self._shell.start_application()
> +        self._shell.send_command("from scapy.all import *")
>
> -    def start_application(self) -> None:
> -        """Extends :meth:`framework.remote_session.interactive_shell.sta=
rt_application`.
> -
> -        Adds a command that imports everything from the scapy library im=
mediately after starting
> -        the shell for usage in later calls to the methods of this class.
> -        """
> -        super().start_application()
> -        self.send_command("from scapy.all import *")
> +    def close(self):
> +        """Close traffic generator."""
> +        self._shell.close()
>
>      def _send_packets(self, packets: list[Packet], port: Port) -> None:
>          """Implementation for sending packets without capturing any rece=
ived traffic.
> @@ -116,7 +114,7 @@ def _send_packets(self, packets: list[Packet], port: =
Port) -> None:
>              "verbose=3DTrue",
>              ")",
>          ]
> -        self.send_command(f"\n{self._python_indentation}".join(send_comm=
and))
> +        self._shell.send_command(f"\n{self._python_indentation}".join(se=
nd_command))
>
>      def _send_packets_and_capture(
>          self,
> @@ -155,7 +153,7 @@ def _shell_set_packet_list(self, packets: list[Packet=
]) -> None:
>              packets: The list of packets to recreate in the shell.
>          """
>          self._logger.info("Building a list of packets to send.")
> -        self.send_command(
> +        self._shell.send_command(
>              f"{self._send_packet_list_name} =3D [{', '.join(map(Packet.c=
ommand, packets))}]"
>          )
>
> @@ -202,7 +200,7 @@ def _shell_create_sniffer(
>          """
>          self._shell_set_packet_list(packets_to_send)
>
> -        self.send_command("import time")
> +        self._shell.send_command("import time")
>          sniffer_commands =3D [
>              f"{self._sniffer_name} =3D AsyncSniffer(",
>              f"iface=3D'{recv_port.logical_name}',",
> @@ -220,7 +218,7 @@ def _shell_create_sniffer(
>          if filter_config:
>              sniffer_commands.insert(-1, f"filter=3D'{filter_config}'")
>
> -        self.send_command(f"\n{self._python_indentation}".join(sniffer_c=
ommands))
> +        self._shell.send_command(f"\n{self._python_indentation}".join(sn=
iffer_commands))
>
>      def _shell_start_and_stop_sniffing(self, duration: float) -> list[Pa=
cket]:
>          """Start asynchronous sniffer, run for a set `duration`, then co=
llect received packets.
> @@ -237,12 +235,12 @@ def _shell_start_and_stop_sniffing(self, duration: =
float) -> list[Packet]:
>              A list of all packets that were received while the sniffer w=
as running.
>          """
>          sniffed_packets_name =3D "gathered_packets"
> -        self.send_command(f"{self._sniffer_name}.start()")
> +        self._shell.send_command(f"{self._sniffer_name}.start()")
>          # Insert a one second delay to prevent timeout errors from occur=
ring
>          time.sleep(duration + 1)
> -        self.send_command(f"{sniffed_packets_name} =3D {self._sniffer_na=
me}.stop(join=3DTrue)")
> +        self._shell.send_command(f"{sniffed_packets_name} =3D {self._sni=
ffer_name}.stop(join=3DTrue)")
>          # An extra newline is required here due to the nature of interac=
tive Python shells
> -        packet_strs =3D self.send_command(
> +        packet_strs =3D self._shell.send_command(
>              f"for pakt in {sniffed_packets_name}: print(bytes_base64(pak=
t.build()))\n"
>          )
>          # In the string of bytes "b'XXXX'", we only want the contents ("=
XXXX")
> diff --git a/dts/framework/testbed_model/traffic_generator/traffic_genera=
tor.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index 804662e114..fbd9771eba 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -17,10 +17,10 @@
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.testbed_model.node import Node
>  from framework.testbed_model.port import Port
> -from framework.utils import MultiInheritanceBaseClass, get_packet_summar=
ies
> +from framework.utils import get_packet_summaries
>
>
> -class TrafficGenerator(MultiInheritanceBaseClass, ABC):
> +class TrafficGenerator(ABC):
>      """The base traffic generator.
>
>      Exposes the common public methods of all traffic generators and defi=
nes private methods
> @@ -48,13 +48,13 @@ def __init__(self, tg_node: Node, config: TrafficGene=
ratorConfig, **kwargs):
>          self._config =3D config
>          self._tg_node =3D tg_node
>          self._logger =3D get_dts_logger(f"{self._tg_node.name} {self._co=
nfig.type}")
> -        super().__init__(**kwargs)
>
>      def setup(self, ports: Iterable[Port]):
>          """Setup the traffic generator."""
>
>      def teardown(self, ports: Iterable[Port]):
>          """Teardown the traffic generator."""
> +        self.close()
>
>      def send_packet(self, packet: Packet, port: Port) -> None:
>          """Send `packet` and block until it is fully sent.
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index d6f4c11d58..24277633c0 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -299,20 +299,6 @@ def _make_packet() -> Packet:
>      return [_make_packet() for _ in range(number_of)]
>
>
> -class MultiInheritanceBaseClass:
> -    """A base class for classes utilizing multiple inheritance.
> -
> -    This class enables it's subclasses to support both single and multip=
le inheritance by acting as
> -    a stopping point in the tree of calls to the constructors of supercl=
asses. This class is able
> -    to exist at the end of the Method Resolution Order (MRO) so that sub=
classes can call
> -    :meth:`super.__init__` without repercussion.
> -    """
> -
> -    def __init__(self) -> None:
> -        """Call the init method of :class:`object`."""
> -        super().__init__()
> -
> -
>  def to_pascal_case(text: str) -> str:
>      """Convert `text` from snake_case to PascalCase."""
>      return "".join([seg.capitalize() for seg in text.split("_")])
> --
> 2.43.0
>
