Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D93C83F09
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 04:29:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 485FB4028B;
	Fri,  4 Jul 2025 06:29:10 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id AD01D4027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 06:29:08 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso436034a12.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 21:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751603348; x=1752208148; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ElbG/moskJoeTkSSEoOPYy7Jqm+vlJY7GuPK/WpVO8I=;
 b=DA4GwTLT/tywRcRo0vrF0dK6fQUU9E7MXIpCC5j0ObTWS28l+JlHvd8uG1UwvUeXQJ
 3cGwPARiXeGeRaDmXO2PLpErjKPx55xLXRiHxcq98ICCdSfXaPHkNJjdQ767lD3LTiCC
 Hu2u5gEqvuy8IdP5YGDG13BpZRKN5Rq9dizK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751603348; x=1752208148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElbG/moskJoeTkSSEoOPYy7Jqm+vlJY7GuPK/WpVO8I=;
 b=f2X6wwf0uPBjKI7Cf3qb9BQQy3hr+UhG/oDtjCAf52+qZ4AHZyxEVGdm4Ptm/yPgMT
 wabvfwoYwrbBsgi7q553zdREy0QPgIv24Ts11SEXLGJ2nMqXZf8RT2tAthbYtaAEw9sN
 iPQnU4comqPYruWbsEEJS9WfQxZPpipfm6otcvQVwqm0K27WTQrzEKgsrLdg7wu7yW5O
 tzfkLj7TBrji0WbrYx2mWPmVLxQhGQLHudBN30xTlJ0+gFV6ZQAUjYe4C1yi7F4X938e
 S/Ym96SVWMPsDIAl/LsXe9sqiF/+CWmtpGX9o/e2te8l6lLKdQGOMpSOZL2HvvC8HNrC
 JXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpNkWyMwVR16rED/r9F2gs/ybrIx/laa9p9GdBXJhaCuHDzA/xv4Hb/5uGD1kmIAtj7tY=@dpdk.org
X-Gm-Message-State: AOJu0Yy6pQg3I8gLjDOfZw8PEdDdygzwoe/EhdCFzU2JhdCGsIk/RGWj
 Hu1UQ67Rkzx9a42WB8VMxQZdOKDqzhHCy1Ks6dezXiETKAnka0JC3CL3Whf498SmRfVB1ALB0XQ
 8jC3EUtGuixDelIn9B+3OU359CwNpVna1DCi6eotNmA==
X-Gm-Gg: ASbGnctkhcXdt+W0Mma6U4XRY+4lpURO1j3qgdd2v6tQYTC8e+Ncd98yVWZNQvMgSPc
 FH+okW5WPMGyqtIUVRMIVi73uClk8Cd8UL5xPsOEmsyD0ulyVBXysmsv2jzjujmiKwkG1V/hk4r
 K2zgUNspcoNEXN1BCFxkmuQ4k8M7YKHdGw18o72XfYq2nGN3uuwRNkdGut9X1Ij+GzHkIkgg==
X-Google-Smtp-Source: AGHT+IEc77osgV15jBPR3fFaz4zudSnHFStXwt17vxoogkUVAFhyqd9nSMkzZD3iZ9RRdStDGF+MCdDbzrzqQ9/V7xk=
X-Received: by 2002:a17:90b:1d43:b0:313:d79d:87eb with SMTP id
 98e67ed59e1d1-31aac543d29mr1741877a91.35.1751603347770; Thu, 03 Jul 2025
 21:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <20250702162331.352313-2-dmarx@iol.unh.edu>
In-Reply-To: <20250702162331.352313-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 00:23:30 -0400
X-Gm-Features: Ac12FXzsGmKpf2F4TYmBgoGPAjMOQAX1R4-OpGd24NIuCSWJehFrqx21kilyx1M
Message-ID: <CAJvnSUAKgXksx4H4qbxb9Zt8bcga7oMBJ=Nu-XVBK9nueajWMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dts: remove unnecessary testpmd verification
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000054e6a8063912ef58"
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

--00000000000054e6a8063912ef58
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:23=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Remove unnecessary verification step in the start method
> of TestPmdShell which checks the link status.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index 299887dd80..6d75f89969 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -1578,13 +1578,6 @@ def start(self, verify: bool =3D True) -> None:
>                  self._logger.debug(f"Failed to start packet forwarding:
> \n{start_cmd_output}")
>                  raise InteractiveCommandExecutionError("Testpmd failed t=
o
> start packet forwarding.")
>
> -            number_of_ports =3D len(self._app_params.allowed_ports or []=
)
> -            for port_id in range(number_of_ports):
> -                if not self.wait_link_status_up(port_id):
> -                    raise InteractiveCommandExecutionError(
> -                        "Not all ports came up after starting packet
> forwarding in testpmd."
> -                    )
> -
>

Okay, this makes sense given how VF info presents in testpmd port info (no
link status). But, I wonder if it makes sense to preserve this in the case
of PF runs? Maybe you can raise this item at the next DTS meeting for
discussion? It could make sense to support this check for PFs for 25.11.
Anyhow we can discuss.


>      def stop(self, verify: bool =3D True) -> str:
>          """Stop packet forwarding.
>
> --
> 2.49.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--00000000000054e6a8063912ef58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 2, 2025 =
at 12:23=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" targ=
et=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Remove unnecessary verification step in th=
e start method<br>
of TestPmdShell which checks the link status.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 7 -------<br>
=C2=A01 file changed, 7 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index 299887dd80..6d75f89969 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -1578,13 +1578,6 @@ def start(self, verify: bool =3D True) -&gt; None:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._logger.=
debug(f&quot;Failed to start packet forwarding: \n{start_cmd_output}&quot;)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Interac=
tiveCommandExecutionError(&quot;Testpmd failed to start packet forwarding.&=
quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of_ports =3D len(self._ap=
p_params.allowed_ports or [])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for port_id in range(number_of_p=
orts):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.wait_l=
ink_status_up(port_id):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e InteractiveCommandExecutionError(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Not all ports came up after starting packet forwarding in =
testpmd.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
>
-<br></blockquote><div><br></div><div>Okay, this makes sense given how VF i=
nfo presents in testpmd port info (no link status). But, I wonder if it mak=
es sense to preserve this in the case of PF runs? Maybe you can raise this =
item at the next DTS meeting for discussion? It could make sense to support=
 this check for PFs for 25.11. Anyhow we can discuss.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0def stop(self, verify: bool =3D True) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Stop packet forwarding.=
<br>
<br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div>Reviewed-by: Patrick Robb &lt;<a href=3D"ma=
ilto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;<div>Tested-by: Patrick Ro=
bb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0=
</div></div></div>
</div>

--00000000000054e6a8063912ef58--
