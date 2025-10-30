Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C6CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 14:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14B6F4026F;
	Thu, 30 Oct 2025 15:41:50 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 29A5340150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 15:41:49 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-63c3c7d3d53so2110569a12.2
 for <dev@dpdk.org>; Thu, 30 Oct 2025 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761835309; x=1762440109; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rT0sUZJgo91+sO20UCnD0g1ryATlQU6NL2ojNqbjgck=;
 b=BUIh9/eR3Vxjb92qAp7Y8WtWhzG5S0VSLZzwDYAqf2ZK498jpTN8dz+/HuIFEo7NIT
 THFYPcVbgxeFTypcLE1jtKOxwV+X2E6MVi1tfBplxCaMBg6AqrHugpC7ACsItGANKuRR
 XQRvpjzLAIG26Ii7CqFMgbDi/PQGwic7iaH5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835309; x=1762440109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rT0sUZJgo91+sO20UCnD0g1ryATlQU6NL2ojNqbjgck=;
 b=fjgh31GFFhC8/dcOydcTCS5O9EobgV2X6Yp90c6R/646q5c6qTVYOy3IPj81cifYJS
 8W/h3Nc7/hoycUnAqx0dwwrtCTqg0iIAuTYCYLd07aU65NE1JlXgP7stwvX3eTvDw6pa
 IlRGba590UoTQi9og+ADpSd417FjN2GthmPro6xNhMgL1R3N7VzzzjT9GZVG8S58suY0
 5EJLSfzOAusTClYJ6h9l84NIPohhq6kxmKAXNjc2wKgXEcsuht7YK+Z8Sxxh6EHBsTkD
 jSmaRdBWmLCFFzGQw7xnh9am52JPZbficx2SiGbRqrLw2AxeEv30sf97iuMui/qeanWD
 Aqkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnL4prKbFfpWt0xwiweR+D7nL1BtQULT117BtaOXqgvdYBeUJs+Nbl2/VCDwAKjexIljk=@dpdk.org
X-Gm-Message-State: AOJu0YxBEh0WFDu1rHJMa4S0DOAlMNdUGM0k8d71qweoVvpG7aUiTwUJ
 TEz7tXI1CXX9Wv7e0NavDMVGcacBQ/oszmAYaa1z0tK6qYwU8BVqxej7dE5RsxZrFX8X6sw4DX+
 SjbtF1EwCT0M5WlhDcYdt1cuTB3qxDcDjzwUXypH0gA==
X-Gm-Gg: ASbGncty12OjF6whANbs8wPZKr8kJnqqZSxWbjt9i8HJN8CzbGSk0aSnbhUhDqtDCVp
 LIMoD03FB/JeCCrr9+wFVAKtuEQieZ7cndKCy+xnrHM9da29q7zx67tY77a7wm2XLGO8N3WG3H3
 v15pWoWInP4Wiz1xmOXXmmGkNRhcVD3enhQmK/awff/4I5NRirR2lB98WMUfyyGxFvD7Um1oTPe
 ke9GaOp7cXGRQ6B6QWnEMCpnp33JLOea8ICMRZvc1zzXjkmwR6zwo7hpMuv845/bLH6dymdvqQX
 UJtYtysAWr8I/CCb4spCRxwpB45h
X-Google-Smtp-Source: AGHT+IHCoIhNmaiIWIVzjLS2Lb+rYd4Uz8yy3eP6C8jtnEKscoz40MjbeaUuCJUFGPPC4T5gKEtZ/pEFdMPdcBP1CkY=
X-Received: by 2002:a05:6402:1d54:b0:61c:cf8d:e51d with SMTP id
 4fb4d7f45d1cf-64044252c81mr5949076a12.22.1761835308710; Thu, 30 Oct 2025
 07:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251023013049.1368129-2-probb@iol.unh.edu>
In-Reply-To: <20251023013049.1368129-2-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 30 Oct 2025 10:41:36 -0400
X-Gm-Features: AWmQ_bm9xzMOpHvI-cRJN3Jp40gzZvXgFckUcWgW8dGWummpIt-Ggq7YBAJQABk
Message-ID: <CABJ3N2VFOU=gYrid1UXXy+Cs-eQ_AVYfJHehOWFx8r3_UXg7TA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dts: rework traffic generator inheritance structure
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.ed, 
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>, 
 Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000ba8e0b0642613f4f"
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

--000000000000ba8e0b0642613f4f
Content-Type: text/plain; charset="UTF-8"

The reason for the relocation of these methods is not entirely
clear given the commit message. It would be helpful to give a
brief explanation in the commit message.

 > +    def setup(self, topology: Topology) -> None:
> +        """Overrides :meth:`.traffic_generator.
TrafficGenerator.setup`."""
> +        for port in self._tg_node.ports:
> +            self._tg_node.main_session.configure_port_mtu(2000, port)

Reiterating Luca's suggestion, it is cleaner to do:
  port.configure_mtu(2000)

@dataclass(slots=True)
> +class PerformanceTrafficStats:
> +    """Data structure to store performance statistics for a given test
> run.
> +
> +    Attributes:
> +        tx_pps: Recorded tx packets per second
> +        tx_bps: Recorded tx bytes per second
> +        rx_pps: Recorded rx packets per second
> +        rx_bps: Recorded rx bytes per second
> +        frame_size: The total length of the frame
> +    """

Small nit: missing full stops on attributes.

Other than that, it looks good.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000ba8e0b0642613f4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div>The reason=C2=A0for the relocation of these methods =
is not entirely <br>clear given the commit message. It would be helpful to =
give a<br>brief explanation in the commit message.<br><br>=C2=A0<span style=
=3D"color:rgb(80,0,80)">&gt; +=C2=A0 =C2=A0 def setup(self, topology: Topol=
ogy) -&gt; None:</span></div><span style=3D"color:rgb(80,0,80)">&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`.traffic_genera=
tor.</span><span style=3D"color:rgb(80,0,80)">TrafficGenerator.setup`.&quot=
;&quot;&quot;</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:r=
gb(80,0,80)">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self._tg_node.po=
rts:</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,8=
0)">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._tg_node.main_sess=
ion.</span><span style=3D"color:rgb(80,0,80)">configure_port_mtu(2000, port=
)</span><br style=3D"color:rgb(80,0,80)"><br>Reiterating Luca&#39;s suggest=
ion, it is cleaner to do:<br>=C2=A0 port.configure_mtu(2000)<span style=3D"=
color:rgb(80,0,80)"><br><br></span><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span style=3D"color:rgb(80,0,80)">@dataclass(slots=3DTrue)</spa=
n><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+clas=
s PerformanceTrafficStats:</span><br style=3D"color:rgb(80,0,80)"><span sty=
le=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 &quot;&quot;&quot;Data structure t=
o store performance statistics for a given test run.</span><br style=3D"col=
or:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+</span><br style=3D"co=
lor:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 Attribu=
tes:</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,8=
0)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_pps: Recorded tx packets per second</sp=
an><br style=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tx_bps: Recorded tx bytes per second</span><br sty=
le=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 rx_pps: Recorded rx packets per second</span><br style=3D"co=
lor:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rx_bps: Recorded rx bytes per second</span><br style=3D"color:rgb(80=
,0,80)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fra=
me_size: The total length of the frame</span><br style=3D"color:rgb(80,0,80=
)"><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 &quot;&quot;&quot;</sp=
an>
</blockquote><div>Small nit: missing full stops on attributes.=C2=A0<br><br=
>Other than that, it looks good.</div><div><br></div><div>Reviewed-by: Andr=
ew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a=
>&gt;</div></div></div>

--000000000000ba8e0b0642613f4f--
