Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA6FCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 13:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F31324021F;
	Thu,  6 Nov 2025 14:37:44 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 343474013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 14:37:44 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so162057166b.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762436264; x=1763041064; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxAwGCJjU7cCP1JZu4Do2ypKDT2aHu6rdhuTcyYs8EA=;
 b=VN3TukFM5rkXAOp065yH9z401eLsKXCZnVTMRuacnmfaOvNzpHyDTEKPxkQV4ath9B
 rsK09xBVUp+ru1B4z0daUqEzbJE0m8OgFXA7kckEehh/OaYiR4w7moK9g/Ze6okQC3Db
 hMOhMahUbxxbqpOQCy+5jH1CNjHeZAEl9J1mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762436264; x=1763041064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxAwGCJjU7cCP1JZu4Do2ypKDT2aHu6rdhuTcyYs8EA=;
 b=SjX2zooeX0OPh4NECwLUedAibKMOEensWpnig/sb7ok399j9dnZHqV3qM5MARFDSI2
 DFOUsV+iItqjZFTGoSH3muwmdcJseVJLEiLWSHOJBKAvMrxoHbtaUgkJVC9fLtOogLpt
 QBEw0ba8BoTe70scgY3IQY4+hMjUfFJfoQMQYR9yD5w0Ig4jpDisSAZDESJSqs6wNUPp
 eY8xHk+iXCGMRzcys8I5gOeIMFL3jLow5xIEMQPIjFuFCh1JINkkM8J0WKaYXlSrXcq2
 1Lf2H8Hqfb+u7IyQ2Z5MWo58v1oiP6V/xkNx4sqeNA0LHdDOVBYDsHiBqSK8yg1VB9kf
 Fpnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/EloidCvEILA4xMPvXHEZL4m1UVeEsurtyJWHBH3K5f2mWZXmdIWJ7SrDJrhFt7LFbA=@dpdk.org
X-Gm-Message-State: AOJu0YzXGcX+GV036vgmbfkt/07OEHqDWETBRuCj5/KboKwMBp9AbLEO
 ghoE0HEzxw1QJckg7afRZPAvGbK0GWTyXLY8+vcGGGYiucNgUsacXLkR7wgf2zgyvPjTS1gXQz1
 Kr0fg/Wzgt81peJGhU1UYWZ3eDT6vIUP8+iOtbvCbtg==
X-Gm-Gg: ASbGncs4yRgSDlNqCRXDIukMbhy0LGu8QpQXHU2jIfH62u398HDgPW/iVWjRmz0DRJG
 HpwmKzZOnlZbw63htXfjVrFdR0ABNON3vrgB731Fe8qgzo2eKfSnSE1RHBS/Wx3E6hpRpkaD4yp
 W5hT3Vb6yi3hg74r+cD3RSyh61bU+6zRJqXpG/XhLKdUfc2xGyrkvZeBGXmWKV9NmtMaPLLoL9q
 IfH1JIHou2ARcZd8WtLpZiGdCu55Lb9paSEfOBdkZfboGc99w3mVUy3Bztg38AvHqu+8g58bQxq
 27bihW8wXiCVfRaROQ==
X-Google-Smtp-Source: AGHT+IFTTt6DKCHP0cflAwk2Rk6ryW44eraOOpN/FdVnmH2HYlm4y214aTtz8fQk6VuOROMyTtceHF1eRhXujxUQF+w=
X-Received: by 2002:a17:907:1c26:b0:b71:ea4b:6d53 with SMTP id
 a640c23a62f3a-b726515658dmr716076866b.7.1762436263596; Thu, 06 Nov 2025
 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251105223628.1659390-2-probb@iol.unh.edu>
In-Reply-To: <20251105223628.1659390-2-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Nov 2025 08:37:31 -0500
X-Gm-Features: AWmQ_bnPqNUpLqA9t22b2v-1K9_kyfw-lOVhteWAdGPZcBiq3MVrzHeBBTYLXmQ
Message-ID: <CABJ3N2Ubi8DwHmNPYK1mgK_A+TAu5Rm6r-SueOYKBzzn6RLdng@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dts: rework traffic generator inheritance structure
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 dmarx@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000006e647d0642ed2b72"
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

--0000000000006e647d0642ed2b72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> From: Nicholas Pratte <npratte@iol.unh.edu>
>
> Rework TG class hierarchy to include performance traffic generators.
> As such, methods specific to capturing traffic have been moved to the
> CapturingTrafficGenerator subclass.
>
> Bugzilla ID: 1697
> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  .../capturing_traffic_generator.py            | 34 +++++++++++
>  .../performance_traffic_generator.py          | 56 +++++++++++++++++++
>  .../traffic_generator/traffic_generator.py    | 38 -------------
>  3 files changed, 90 insertions(+), 38 deletions(-)
>  create mode 100644
> dts/framework/testbed_model/traffic_generator/performance_traffic_generat=
or.py
>
> diff --git
> a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generat=
or.py
> b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generat=
or.py
> index ec0993e6b7..734a66d1f3 100644
> ---
> a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generat=
or.py
> +++
> b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generat=
or.py
> @@ -65,6 +65,40 @@ def is_capturing(self) -> bool:
>          """This traffic generator can capture traffic."""
>          return True
>
> +    def send_packet(self, packet: Packet, port: Port) -> None:
> +        """Send `packet` and block until it is fully sent.
> +
> +        Send `packet` on `port`, then wait until `packet` is fully sent.
> +
> +        Args:
> +            packet: The packet to send.
> +            port: The egress port on the TG node.
> +        """
> +        self.send_packets([packet], port)
> +
> +    def send_packets(self, packets: list[Packet], port: Port) -> None:
> +        """Send `packets` and block until they are fully sent.
> +
> +        Send `packets` on `port`, then wait until `packets` are fully
> sent.
> +
> +        Args:
> +            packets: The packets to send.
> +            port: The egress port on the TG node.
> +        """
> +        self._logger.info(f"Sending packet{'s' if len(packets) > 1 else
> ''}.")
> +        self._logger.debug(get_packet_summaries(packets))
> +        self._send_packets(packets, port)
> +
> +    @abstractmethod
> +    def _send_packets(self, packets: list[Packet], port: Port) -> None:
> +        """The implementation of :method:`send_packets`.
> +
> +        The subclasses must implement this method which sends `packets`
> on `port`.
> +        The method should block until all `packets` are fully sent.
> +
> +        What fully sent means is defined by the traffic generator.
> +        """
> +
>      def send_packets_and_capture(
>          self,
>          packets: list[Packet],
> diff --git
> a/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> b/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> new file mode 100644
> index 0000000000..09abe9a66b
> --- /dev/null
> +++
> b/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> @@ -0,0 +1,56 @@
> +"""Traffic generators for performance tests which can generate a high
> number of packets."""
> +
> +from abc import abstractmethod
> +from dataclasses import dataclass
> +
> +from scapy.packet import Packet
> +
> +from .traffic_generator import TrafficGenerator
> +
> +
> +@dataclass(slots=3DTrue)
> +class PerformanceTrafficStats:
> +    """Data structure to store performance statistics for a given test
> run.
> +
> +    Attributes:
> +        tx_pps: Recorded tx packets per second.
> +        tx_bps: Recorded tx bytes per second.
> +        rx_pps: Recorded rx packets per second.
> +        rx_bps: Recorded rx bytes per second.
> +        frame_size: The total length of the frame.
> +    """
> +
> +    tx_pps: float
> +    tx_bps: float
> +    rx_pps: float
> +    rx_bps: float
> +
> +    frame_size: int | None =3D None
> +
> +
> +class PerformanceTrafficGenerator(TrafficGenerator):
> +    """An abstract base class for all performance-oriented traffic
> generators.
> +
> +    Provides an intermediary interface for performance-based traffic
> generator.
> +    """
> +
> +    @abstractmethod
> +    def calculate_traffic_and_stats(
> +        self,
> +        packet: Packet,
> +        duration: float,
> +        send_mpps: int | None =3D None,
> +    ) -> PerformanceTrafficStats:
> +        """Send packet traffic and acquire associated statistics.
> +
> +        If `send_mpps` is provided, attempt to transmit traffic at the
> `send_mpps` rate.
> +        Otherwise, attempt to transmit at line rate.
> +
> +        Args:
> +            packet: The packet to send.
> +            duration: Performance test duration (in seconds).
> +            send_mpps: The millions packets per second send rate.
> +
> +        Returns:
> +            Performance statistics of the generated test.
> +        """
> diff --git
> a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index cac119c183..e5f246df7a 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -11,14 +11,10 @@
>  from abc import ABC, abstractmethod
>  from typing import Any
>
> -from scapy.packet import Packet
> -
>  from framework.config.test_run import TrafficGeneratorConfig
>  from framework.logger import DTSLogger, get_dts_logger
>  from framework.testbed_model.node import Node
> -from framework.testbed_model.port import Port
>  from framework.testbed_model.topology import Topology
> -from framework.utils import get_packet_summaries
>
>
>  class TrafficGenerator(ABC):
> @@ -57,40 +53,6 @@ def teardown(self) -> None:
>          """Teardown the traffic generator."""
>          self.close()
>
> -    def send_packet(self, packet: Packet, port: Port) -> None:
> -        """Send `packet` and block until it is fully sent.
> -
> -        Send `packet` on `port`, then wait until `packet` is fully sent.
> -
> -        Args:
> -            packet: The packet to send.
> -            port: The egress port on the TG node.
> -        """
> -        self.send_packets([packet], port)
> -
> -    def send_packets(self, packets: list[Packet], port: Port) -> None:
> -        """Send `packets` and block until they are fully sent.
> -
> -        Send `packets` on `port`, then wait until `packets` are fully
> sent.
> -
> -        Args:
> -            packets: The packets to send.
> -            port: The egress port on the TG node.
> -        """
> -        self._logger.info(f"Sending packet{'s' if len(packets) > 1 else
> ''}.")
> -        self._logger.debug(get_packet_summaries(packets))
> -        self._send_packets(packets, port)
> -
> -    @abstractmethod
> -    def _send_packets(self, packets: list[Packet], port: Port) -> None:
> -        """The implementation of :method:`send_packets`.
> -
> -        The subclasses must implement this method which sends `packets`
> on `port`.
> -        The method should block until all `packets` are fully sent.
> -
> -        What fully sent means is defined by the traffic generator.
> -        """
> -
>      @property
>      def is_capturing(self) -> bool:
>          """This traffic generator can't capture traffic."""
> --
> 2.49.0
>
>

--0000000000006e647d0642ed2b72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@i=
ol.unh.edu" target=3D"_blank">abailey@iol.unh.edu</a>&gt;</div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Nov 5, 2025 at 5:37=E2=80=AFPM Patrick Robb &lt;<a href=3D"mail=
to:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Nicholas Pratte &lt;<a href=3D=
"mailto:npratte@iol.unh.edu" target=3D"_blank">npratte@iol.unh.edu</a>&gt;<=
br>
<br>
Rework TG class hierarchy to include performance traffic generators.<br>
As such, methods specific to capturing traffic have been moved to the<br>
CapturingTrafficGenerator subclass.<br>
<br>
Bugzilla ID: 1697<br>
Signed-off-by: Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.unh.edu" t=
arget=3D"_blank">npratte@iol.unh.edu</a>&gt;<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Reviewed-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_=
blank">dmarx@iol.unh.edu</a>&gt;<br>
Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0.../capturing_traffic_generator.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 34 +++++++++++<br>
=C2=A0.../performance_traffic_generator.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 56 +++++++++++++++++++<br>
=C2=A0.../traffic_generator/traffic_generator.py=C2=A0 =C2=A0 | 38 --------=
-----<br>
=C2=A03 files changed, 90 insertions(+), 38 deletions(-)<br>
=C2=A0create mode 100644 dts/framework/testbed_model/traffic_generator/perf=
ormance_traffic_generator.py<br>
<br>
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffi=
c_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_tr=
affic_generator.py<br>
index ec0993e6b7..734a66d1f3 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_gener=
ator.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_gener=
ator.py<br>
@@ -65,6 +65,40 @@ def is_capturing(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;This traffic generator =
can capture traffic.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
+=C2=A0 =C2=A0 def send_packet(self, packet: Packet, port: Port) -&gt; None=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send `packet` and block unti=
l it is fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send `packet` on `port`, then wait until `pack=
et` is fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet to send.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The egress port on the TG =
node.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packets([packet], port)<br>
+<br>
+=C2=A0 =C2=A0 def send_packets(self, packets: list[Packet], port: Port) -&=
gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send `packets` and block unt=
il they are fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send `packets` on `port`, then wait until `pac=
kets` are fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: The packets to send.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The egress port on the TG =
node.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.info" rel=3D"no=
referrer" target=3D"_blank">logger.info</a>(f&quot;Sending packet{&#39;s&#3=
9; if len(packets) &gt; 1 else &#39;&#39;}.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(get_packet_summaries(packet=
s))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._send_packets(packets, port)<br>
+<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def _send_packets(self, packets: list[Packet], port: Port) -=
&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The implementation of :metho=
d:`send_packets`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The subclasses must implement this method whic=
h sends `packets` on `port`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The method should block until all `packets` ar=
e fully sent.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 What fully sent means is defined by the traffi=
c generator.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def send_packets_and_capture(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packets: list[Packet],<br>
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traf=
fic_generator.py b/dts/framework/testbed_model/traffic_generator/performanc=
e_traffic_generator.py<br>
new file mode 100644<br>
index 0000000000..09abe9a66b<br>
--- /dev/null<br>
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_gen=
erator.py<br>
@@ -0,0 +1,56 @@<br>
+&quot;&quot;&quot;Traffic generators for performance tests which can gener=
ate a high number of packets.&quot;&quot;&quot;<br>
+<br>
+from abc import abstractmethod<br>
+from dataclasses import dataclass<br>
+<br>
+from scapy.packet import Packet<br>
+<br>
+from .traffic_generator import TrafficGenerator<br>
+<br>
+<br>
+@dataclass(slots=3DTrue)<br>
+class PerformanceTrafficStats:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Data structure to store performance statis=
tics for a given test run.<br>
+<br>
+=C2=A0 =C2=A0 Attributes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pps: Recorded tx packets per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_bps: Recorded tx bytes per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_pps: Recorded rx packets per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_bps: Recorded rx bytes per second.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame_size: The total length of the frame.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 tx_pps: float<br>
+=C2=A0 =C2=A0 tx_bps: float<br>
+=C2=A0 =C2=A0 rx_pps: float<br>
+=C2=A0 =C2=A0 rx_bps: float<br>
+<br>
+=C2=A0 =C2=A0 frame_size: int | None =3D None<br>
+<br>
+<br>
+class PerformanceTrafficGenerator(TrafficGenerator):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;An abstract base class for all performance=
-oriented traffic generators.<br>
+<br>
+=C2=A0 =C2=A0 Provides an intermediary interface for performance-based tra=
ffic generator.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 @abstractmethod<br>
+=C2=A0 =C2=A0 def calculate_traffic_and_stats(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: float,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: int | None =3D None,<br>
+=C2=A0 =C2=A0 ) -&gt; PerformanceTrafficStats:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet traffic and acqu=
ire associated statistics.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 If `send_mpps` is provided, attempt to transmi=
t traffic at the `send_mpps` rate.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Otherwise, attempt to transmit at line rate.<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet to send.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: Performance test durat=
ion (in seconds).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_mpps: The millions packets =
per second send rate.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Performance statistics of the ge=
nerated test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generato=
r.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<b=
r>
index cac119c183..e5f246df7a 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py<br=
>
@@ -11,14 +11,10 @@<br>
=C2=A0from abc import ABC, abstractmethod<br>
=C2=A0from typing import Any<br>
<br>
-from scapy.packet import Packet<br>
-<br>
=C2=A0from framework.config.test_run import TrafficGeneratorConfig<br>
=C2=A0from framework.logger import DTSLogger, get_dts_logger<br>
=C2=A0from framework.testbed_model.node import Node<br>
-from framework.testbed_model.port import Port<br>
=C2=A0from framework.testbed_model.topology import Topology<br>
-from framework.utils import get_packet_summaries<br>
<br>
<br>
=C2=A0class TrafficGenerator(ABC):<br>
@@ -57,40 +53,6 @@ def teardown(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Teardown the traffic ge=
nerator.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.close()<br>
<br>
-=C2=A0 =C2=A0 def send_packet(self, packet: Packet, port: Port) -&gt; None=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send `packet` and block unti=
l it is fully sent.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send `packet` on `port`, then wait until `pack=
et` is fully sent.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: The packet to send.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The egress port on the TG =
node.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_packets([packet], port)<br>
-<br>
-=C2=A0 =C2=A0 def send_packets(self, packets: list[Packet], port: Port) -&=
gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send `packets` and block unt=
il they are fully sent.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Send `packets` on `port`, then wait until `pac=
kets` are fully sent.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets: The packets to send.<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port: The egress port on the TG =
node.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.info" rel=3D"no=
referrer" target=3D"_blank">logger.info</a>(f&quot;Sending packet{&#39;s&#3=
9; if len(packets) &gt; 1 else &#39;&#39;}.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(get_packet_summaries(packet=
s))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._send_packets(packets, port)<br>
-<br>
-=C2=A0 =C2=A0 @abstractmethod<br>
-=C2=A0 =C2=A0 def _send_packets(self, packets: list[Packet], port: Port) -=
&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The implementation of :metho=
d:`send_packets`.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The subclasses must implement this method whic=
h sends `packets` on `port`.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 The method should block until all `packets` ar=
e fully sent.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 What fully sent means is defined by the traffi=
c generator.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def is_capturing(self) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;This traffic generator =
can&#39;t capture traffic.&quot;&quot;&quot;<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--0000000000006e647d0642ed2b72--
