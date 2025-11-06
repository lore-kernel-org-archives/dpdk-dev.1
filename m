Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4ECCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9B77402BC;
	Thu,  6 Nov 2025 16:05:40 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id C44D24013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:05:39 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-640ace5f283so1325159a12.2
 for <dev@dpdk.org>; Thu, 06 Nov 2025 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762441539; x=1763046339; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F04pLSFe3tVT6LkoKG7jRI0mhPzNyQJCEBLW3dFxQKo=;
 b=frV/cRSLx1pMpSZuHeNBz9VzInI/I1JyX6a9QU77wXWj/ivNR/+YTGIMG64dUxllla
 pnEhPxfKdusl3GcRXYWTIoJT0gME4F6e4FCJ0wYhra1nhTt+h0bCW4kg39ufrojt4rMM
 kymyLgRL5aQpXFkeyOpukrezpL2YAdUVPoasg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762441539; x=1763046339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F04pLSFe3tVT6LkoKG7jRI0mhPzNyQJCEBLW3dFxQKo=;
 b=KR2lmFUesTE58PXwZ1UoI8dcfIXYbGZs+fITGFkjSABlXBBFHwKWnEX0quIMFm8oN2
 BW2w8SErb7L0U9tIq3eju7tRyAQFSSDZNTUNJQVbTJI9VMoSHoA4Xy+hw6KrHeqG6mOr
 HonqljfIGflxmckW1U+grL2gFvs6P2JYvnh1jmel/Czjt1P2iQN7I3E7PMmPaUmaZZyw
 /AMfwwhUN/RCSMttcxqnJ2PRbpFOfdcUC6not23zoPWb4N4bRzW+KnimBb4hoS1ziDfY
 EdWhMDZwpZGYc0Mjau/hNNttzfJZYVvbNjg6QedOCGtpNRfYjhgwEtr9t+EigkcDBg6x
 ShmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGQqUbpvOBdZs+iDqqnPA7H+K9LbQaAbCmuiBoDCrHgGG8QW+V/0ZKekKi4UMu2RdpYkI=@dpdk.org
X-Gm-Message-State: AOJu0YxTWiiX/SGNnWxLGaBj8wo2noYS1pMv17gOv7cg/LtgAK7qXBA/
 uzkhZZ3x17t4O2Z8xeXr3rSD89+qtQxfC+wevF7zTJc+GZk1UJmo/m2yvI3kZwIbT9B3wOCVu+Y
 cf5PLoFMLfQtPV0JpUtcRFVwBS6BEiEA8pa96nFgqeg==
X-Gm-Gg: ASbGncvqa8aoR+jLTyV69aGOcbmj7UCIYVTXbShRv20BntNvE8Imx5WFvXKoWECB4Tc
 gsvLu+DVjgl8QtWaxnrxlUmyoSKXVcHvq+WE32MF0V5OEDyiZyINAkB4VLpP5MqbYQryxAmng4E
 omZMl0FUTJNqXg1KFaDSfj7AlVRVFAzEqXLGycNSu8v0ruKBicWl7GT8zqaj/49sU6wGRKRVPlt
 M1tP/abJHXXlFAiFltaUeeQS6VYLO+PNmCz/mA6NivHnYOHSnu/Q3SEMoWkcb+BNYG08Duhh1X1
 eb7n0UnOep2RFDJk7A==
X-Google-Smtp-Source: AGHT+IEg2eLeS0/s23MH56zfKBLFqnnzu6vr6DllRzr3eFJU8iElv5ToDLI1B3k0w/RC/eZoBqtUmqYVz+S454aX9Bc=
X-Received: by 2002:a05:6402:50c8:b0:640:b9c5:24a1 with SMTP id
 4fb4d7f45d1cf-64105b96359mr6371623a12.38.1762441539084; Thu, 06 Nov 2025
 07:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
 <20251105194925.1507334-1-probb@iol.unh.edu>
In-Reply-To: <20251105194925.1507334-1-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Nov 2025 10:05:27 -0500
X-Gm-Features: AWmQ_blS_wUww_Nu3WwsTEokptwlfdO-royFvc0dN0yPuN22ye1NaWHd4A9L0tU
Message-ID: <CABJ3N2XcnGVT2q-BAjutbUYgHjHJH8KTn9nWNXQsdRc82CadhA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: testpmd link check on port start
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000dffe050642ee65ac"
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

--000000000000dffe050642ee65ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Raises:
+        InteractiveCommandExecutionError: If the ports has been started
but a port link will not come up.
nit: fails check-format because the line is too long.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

On Wed, Nov 5, 2025 at 2:50=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> When running our existing DTS testsuites on a new
> NIC we observed packets would not transmit from
> the traffic generator to the system under test
> even after DPDK testpmd and the NIC under test
> had indicated readiness. After investigation, we
> determined that the existing readiness check in DTS
> for testpmd start (checking that port is started)
> is insufficient, because on some systems the link
> will remain down for some measurable time, creating
> a race condition between the testpmd port's link
> coming up and the DTS execution reaching the packet
> transmission step. This change will ensure that
> testpmd start will block until the port is reporting
> that its link is up. In addition, the interval in
> between checking the link state has been reduced in
> order to speed up the execution.
>
> Signed-off-by: Patrick Robb <probb@iol.unh.edu>
> Tested-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/api/testpmd/__init__.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index aadb7f4e70..49a847494a 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -93,6 +93,9 @@ def _requires_started_ports(func: TestPmdMethod) ->
> TestPmdMethod:
>
>      Args:
>          func: The :class:`TestPmd` method to decorate.
> +
> +    Raises:
> +        InteractiveCommandExecutionError: If the ports has been started
> but a port link will not come up.
>      """
>
>      @functools.wraps(func)
> @@ -100,6 +103,10 @@ def _wrapper(self: "TestPmd", *args: P.args,
> **kwargs: P.kwargs) -> Any:
>          if not self.ports_started:
>              self._logger.debug("Ports need to be started to continue.")
>              self.start_all_ports()
> +        if get_ctx().topology.type is not LinkTopology.NO_LINK:
> +            for port in self.ports:
> +                if not self.wait_link_status_up(port.id):
> +                    raise InteractiveCommandExecutionError(f"Port {
> port.id} link failed to come up.")
>
>          return func(self, *args, **kwargs)
>
> @@ -265,7 +272,7 @@ def wait_link_status_up(self, port_id: int,
> timeout=3DSETTINGS.timeout) -> bool:
>              port_info =3D self.send_command(f"show port info {port_id}")
>              if "Link status: up" in port_info:
>                  break
> -            time.sleep(0.5)
> +            time.sleep(0.25)
>          else:
>              self._logger.error(f"The link for port {port_id} did not com=
e
> up in the given timeout.")
>          return "Link status: up" in port_info
> --
> 2.49.0
>
>

--000000000000dffe050642ee65ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Raises:<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveC=
ommandExecutionError: If the ports has been started but a port link will no=
t come up.<br>nit: fails check-format because the line is too long.<div><br=
>Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abai=
ley@iol.unh.edu</a>&gt;</div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 5, 2025 at 2=
:50=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@=
iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">When running our existing DTS testsuites on a new<br>
NIC we observed packets would not transmit from<br>
the traffic generator to the system under test<br>
even after DPDK testpmd and the NIC under test<br>
had indicated readiness. After investigation, we<br>
determined that the existing readiness check in DTS<br>
for testpmd start (checking that port is started)<br>
is insufficient, because on some systems the link<br>
will remain down for some measurable time, creating<br>
a race condition between the testpmd port&#39;s link<br>
coming up and the DTS execution reaching the packet<br>
transmission step. This change will ensure that<br>
testpmd start will block until the port is reporting<br>
that its link is up. In addition, the interval in<br>
between checking the link state has been reduced in<br>
order to speed up the execution.<br>
<br>
Signed-off-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"=
_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index aadb7f4e70..49a847494a 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -93,6 +93,9 @@ def _requires_started_ports(func: TestPmdMethod) -&gt; Te=
stPmdMethod:<br>
<br>
=C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0func: The :class:`TestPmd` method to deco=
rate.<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If the ports=
 has been started but a port link will not come up.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0@functools.wraps(func)<br>
@@ -100,6 +103,10 @@ def _wrapper(self: &quot;TestPmd&quot;, *args: P.args,=
 **kwargs: P.kwargs) -&gt; Any:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.ports_started:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.debug(&quot;Po=
rts need to be started to continue.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.start_all_ports()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if get_ctx().topology.type is not LinkTopology=
.NO_LINK:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in self.ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.wait_l=
ink_status_up(<a href=3D"http://port.id" rel=3D"noreferrer" target=3D"_blan=
k">port.id</a>):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(f&quot;Port {<a href=3D"http://port.id" =
rel=3D"noreferrer" target=3D"_blank">port.id</a>} link failed to come up.&q=
uot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return func(self, *args, **kwargs)<br>
<br>
@@ -265,7 +272,7 @@ def wait_link_status_up(self, port_id: int, timeout=3DS=
ETTINGS.timeout) -&gt; bool:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_info =3D self.send_com=
mand(f&quot;show port info {port_id}&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;Link status: up&qu=
ot; in port_info:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.5)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(0.25)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.error(f&quot;T=
he link for port {port_id} did not come up in the given timeout.&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;Link status: up&quot; in por=
t_info<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--000000000000dffe050642ee65ac--
