Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFA8C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 19:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D0D6410D0;
	Thu, 15 May 2025 21:28:52 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2537441060
 for <dev@dpdk.org>; Thu, 15 May 2025 21:28:51 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-231c86bffc1so8919245ad.0
 for <dev@dpdk.org>; Thu, 15 May 2025 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747337330; x=1747942130; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ok2M4cUb5UZBzg5VqGGHDlSQOANJbrGkKbIXbaqp1iE=;
 b=DNaW8PQH+bL2KE93rd15YlpXIb3vkNVX1FC7PBfNgLfO+YdBXEQJS9Zme++EtV1INc
 /hhh+NnNfL0wR2d8jqtTD/8GPC5e4BGB3q88s1gj3fWbWz8+ZtGDhli0vAn9vp7KuDle
 n9DVwZ527Oe/ioUEGV7UJy1LqyTpUasNKYuBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337330; x=1747942130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ok2M4cUb5UZBzg5VqGGHDlSQOANJbrGkKbIXbaqp1iE=;
 b=VUn0YaiT4c/MNys57AK3LYdgXcd+Jv0f/Ze9XrYfpOBEt7gLg4PCZkXYi0QFOsaB5a
 23os55UdOUVMjkAqwwm47+1A+vzIRCQEFSMOlSlXtbH5ESz8FFEOg+86P1VJafQUVaf3
 ml16HPo7OH0PlA5dSKIl4y8unCL+UkCy1olZL3/wiQJ1Aptfiqf09Niq5t7bvtOSD5lj
 0mO2wLOd5nJlMiRdd0SMFLtl1M6Hi4mvniT5um4wyJks/OjRAI6wED0q+k+XybW1Qqqo
 uYH6d7ajpCQsXMUtA9sd8oW86ZqEbnMQHkb+a7gEJGwK1g5E0xP6LGiySTeoAOinGFvb
 c/Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3sLTR7wLgxnr4j8PhULstJpkw6d3jeV5r6NwM/iFH7WHrpgInzHgBO5QupUav/dFtaCc=@dpdk.org
X-Gm-Message-State: AOJu0YySlvZxpN1fRERapQkYdSt58Jq7g+c/M5YUkTX141OWmgPOWMBo
 VCWCnfmbOwAja8/b0U6Fi5csFpA0rN1RRQG4Q+UBrGrkH2wTVGtGgZfBgbwyfuMeC1at/WJCcsw
 29vrgQ57u1TaAz6OHtYZ5zMX75bGRhwNG7prCbrtbCg==
X-Gm-Gg: ASbGncto4ndX3DhG3FNkf7UyXMoXpBHals2QLTYuXeCb1I8QvkUJQBpK7W6nca2BNs3
 9UioBZg0DFUz0U7lRjEbspNpE+gdlzZJq7+X1C/w9j2N3AKRyaM++I08agVa22R6LnMQ1b/puCM
 XkgBxF9lvXySbI9KM2MBxTlQGoQdIbAUrCJcFBhisLRD7FH3MmgJC4W1VvXP88vS+R2g==
X-Google-Smtp-Source: AGHT+IEfZLFRZckQ3clF8KZ0Mr7fqcKWqJ76/aTBg3MNguLBr+L3jifeuWB3teQlUq26zMfpCQOEP24V9HKkgPqWZIQ=
X-Received: by 2002:a17:903:1b6d:b0:22e:634b:14cd with SMTP id
 d9443c01a7336-231d45360bamr8428875ad.39.1747337330183; Thu, 15 May 2025
 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250423194011.1447679-3-npratte@iol.unh.edu>
In-Reply-To: <20250423194011.1447679-3-npratte@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 15:24:06 -0400
X-Gm-Features: AX0GCFthIo8Wh-IPZoNXknKUhbIVUa88tQEpGXIB3AJcTHvxSGpHJMNeeDbgzqU
Message-ID: <CAJvnSUDs7To7F7TBH+CPn39TwFK-hu3+jzm_DMcEKxtDPqvYyg@mail.gmail.com>
Subject: Re: [RFC Patch v1 2/5] dts: rework traffic generator inheritance
 structure.
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: ian.stokes@intel.com, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, luca.vizzarro@arm.com, 
 thomas.wilks@arm.com, dmarx@iol.unh.edu, stephen@networkplumber.org, 
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000de63ef063531ac23"
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

--000000000000de63ef063531ac23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 3:40=E2=80=AFPM Nicholas Pratte <npratte@iol.unh.ed=
u> wrote:

>
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
> index 0000000000..7a384cf6e0
> --- /dev/null
> +++
> b/dts/framework/testbed_model/traffic_generator/performance_traffic_gener=
ator.py
> @@ -0,0 +1,62 @@
> +"""Performance testing capable traffic generatiors."""
> +
> +from abc import ABC, abstractmethod
> +from dataclasses import dataclass
> +from typing import Callable
> +
> +from scapy.packet import Packet
> +
> +from framework.testbed_model.traffic_generator.traffic_generator import
> TrafficGenerator
>

I think this can become:

from .traffic_generator import TrafficGenerator


> +
> +
> +@dataclass(slots=3DTrue)
> +class PerformanceTrafficStats(ABC):
> +    """Data structure for stats offered by a given traffic generator."""
> +
> +    frame_size: int
>

Do we need to add an optional number of packet descriptors attribute? I
realize that is a SUT testpmd param, not a TREX param, but presumably when
we gather stats, we want to store the descriptor count with it.


> +
> +
> +class PerformanceTrafficGenerator(TrafficGenerator):
> +    """An Abstract Base Class for all performance-oriented traffic
> generators.
> +
> +    Provides an intermediary interface for performance-based traffic
> generator.
> +    """
> +
> +    _test_stats: list[PerformanceTrafficStats]
> +
> +    @property
> +    def is_capturing(self) -> bool:
> +        """Used for synchronization."""
> +        return False
> +
> +    @property
> +    def last_results(self) -> PerformanceTrafficStats | None:
> +        """Get the latest set of results from TG instance.
> +
> +        Returns:
> +            The most recent set of traffic statistics.
> +        """
> +        return self._test_stats.pop(0)
> +
> +    def generate_traffic_and_stats(
> +        self,
> +        packet: Packet,
> +        duration: float,  # Default of 60 (in seconds).
>

Should it be float =3D 60, so the default is coming from the function, and
not a "default" which is coming from the testsuite? If not, I guess the
"default" comment belongs in the testsuite?


> +    ) -> PerformanceTrafficStats:
> +        """Send packet traffic and acquire associated statistics."""
> +        return self._calculate_traffic_stats(packet, duration,
> self._generate_traffic)
> +
> +    def setup(self, ports):
> +        """Preliminary port setup prior to TG execution."""
> +        for port in self._tg_node.ports:
> +            self._tg_node.main_session.configure_port_mtu(2000, port)
>

Okay just checking... so if we do not do this, even after binding the port
to vfio-pci we cannot send traffic up to 2000 bytes?

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000de63ef063531ac23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 23,=
 2025 at 3:40=E2=80=AFPM Nicholas Pratte &lt;<a href=3D"mailto:npratte@iol.=
unh.edu">npratte@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
+<br>
=C2=A0 =C2=A0 =C2=A0def send_packets_and_capture(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packets: list[Packet],<br>
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traf=
fic_generator.py b/dts/framework/testbed_model/traffic_generator/performanc=
e_traffic_generator.py<br>
new file mode 100644<br>
index 0000000000..7a384cf6e0<br>
--- /dev/null<br>
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_gen=
erator.py<br>
@@ -0,0 +1,62 @@<br>
+&quot;&quot;&quot;Performance testing capable traffic generatiors.&quot;&q=
uot;&quot;<br>
+<br>
+from abc import ABC, abstractmethod<br>
+from dataclasses import dataclass<br>
+from typing import Callable<br>
+<br>
+from scapy.packet import Packet<br>
+<br>
+from framework.testbed_model.traffic_generator.traffic_generator import Tr=
afficGenerator<br></blockquote><div><br></div><div>I think this can become:=
=C2=A0</div><div><br></div><div>from .traffic_generator import TrafficGener=
ator</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+<br>
+@dataclass(slots=3DTrue)<br>
+class PerformanceTrafficStats(ABC):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Data structure for stats offered by a give=
n traffic generator.&quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 frame_size: int<br></blockquote><div><br></div><div>Do we ne=
ed to add an optional number of packet descriptors attribute? I realize tha=
t is a SUT testpmd param, not a TREX param, but presumably when we gather s=
tats, we want to store the descriptor count with it.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+<br>
+class PerformanceTrafficGenerator(TrafficGenerator):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;An Abstract Base Class for all performance=
-oriented traffic generators.<br>
+<br>
+=C2=A0 =C2=A0 Provides an intermediary interface for performance-based tra=
ffic generator.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 _test_stats: list[PerformanceTrafficStats]<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def is_capturing(self) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Used for synchronization.&qu=
ot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 @property<br>
+=C2=A0 =C2=A0 def last_results(self) -&gt; PerformanceTrafficStats | None:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Get the latest set of result=
s from TG instance.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The most recent set of traffic s=
tatistics.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._test_stats.pop(0)<br>
+<br>
+=C2=A0 =C2=A0 def generate_traffic_and_stats(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet: Packet,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 duration: float,=C2=A0 # Default of 60 (in sec=
onds).<br></blockquote><div><br></div><div>Should it be float =3D 60, so th=
e default is coming from the function, and not a &quot;default&quot; which =
is coming from the testsuite? If not, I guess the &quot;default&quot; comme=
nt belongs in the testsuite?</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 ) -&gt; PerformanceTrafficStats:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Send packet traffic and acqu=
ire associated statistics.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._calculate_traffic_stats(packet, d=
uration, self._generate_traffic)<br>
+<br>
+=C2=A0 =C2=A0 def setup(self, ports):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Preliminary port setup prior=
 to TG execution.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self._tg_node.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_node.main_session.confi=
gure_port_mtu(2000, port)<br></blockquote><div><br></div><div>Okay just che=
cking... so if we do not do this, even after binding the port to vfio-pci w=
e cannot send traffic up to 2000 bytes?</div><div>=C2=A0</div><div>Reviewed=
-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.ed=
u</a>&gt;</div></div></div>

--000000000000de63ef063531ac23--
