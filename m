Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA93C3601A
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 13:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9FEC402CB;
	Thu,  3 Apr 2025 15:58:24 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id CA0C8402A0
 for <dev@dpdk.org>; Thu,  3 Apr 2025 15:58:23 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-af9065f0fc0so671439a12.2
 for <dev@dpdk.org>; Thu, 03 Apr 2025 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743688703; x=1744293503; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=taDr7NNw+v+w4XRYOIRQsyJ9gBkxfk/MA0zXcFQoS7c=;
 b=etmJ7gupJeULZUnAOi6Y3G33aOkzxgxeCCPQSQe2axmhitWGjD7p8IhsJBqbcmXyBS
 t6TNhZ3CpzbXna85IKbfBkuNO22R35yBLhveanRNnbw5WOu72TdKoWuk1NanDMe2ITnZ
 t8XTKYNU7LCtFg6jl30IlqjXL2KBQUzeIRUXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743688703; x=1744293503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=taDr7NNw+v+w4XRYOIRQsyJ9gBkxfk/MA0zXcFQoS7c=;
 b=AlPtv3cDceA9VEgZ639ztjIosuoOV+lZS6WdP7GT89X4nIItzKyIJGxPPj5KYEWlmE
 olEp+Fh94L06oS7VSQs5r9j0G3flnpxH/LYjMVbfdbFrI66hVMFs9vFV/h30NQRCL8jg
 lLI1iDvhCcgn3rc8txS74wnZXGRG0reVk1qNG5fmITAiiOwbKh+lIiV4duNkOgYz3IDe
 hYShjRX1XiugTR4IESoS+7VKl4n2PlIbzVkKwLO2Ju+5B8uIwUutIKsg4mzZdX8dXxWe
 s8aBLG1YkOjAg4ZpEOrESm+dVs40+jP8IyvH3zRBp/Eds06VA+bm8/ga7Mf7RvOY804V
 RLww==
X-Gm-Message-State: AOJu0YxlL4Fo4Ug3cShut+49Gygyh7FqY9rsy2EvZ/hLIUHTgqWcNioZ
 XNCeqtwDO4lPk0RTL5yNzavNGcMHCWveXpTfRy8sV3UK8ruZKvg5eWcq5S9DSpfP8t16ah3wDu2
 zm3RSQZkh151NtwhP6E7u4o9Q15x19hPT1bgMubtwNJppfCBKqrc=
X-Gm-Gg: ASbGncuN32AZwa2yh3HAbKapvaxuQBC6++53bCzoEzuJSfM8WZIwSL47DsBbGoQDJB3
 /I4k2vU8Pve5xTCWK2I+tgmXe4dzZApxiZ0LIYN6Ck58mtEZ+nME+sEsmuWOKtT/pRpOFz/qycq
 1zATjNA5yN15OTM2WE6/71Q8SOM5oJjggE8aPHc22UYjm/3OYBrjtz
X-Google-Smtp-Source: AGHT+IHigbtJybEL/U/v6o1p4TnhM9ZLJlyMcHw0GONaBDeif3WPXl+JpsLyHaW8RUkixwRkIFNTUFoDK2akng5Lqu0=
X-Received: by 2002:a17:90b:3c4d:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-3057cc004b0mr3875215a91.27.1743688702906; Thu, 03 Apr 2025
 06:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250318174051.1931041-1-luca.vizzarro@arm.com>
In-Reply-To: <20250318174051.1931041-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Apr 2025 09:54:20 -0400
X-Gm-Features: AQ5f1JqWy9M1HBXBqX6-55Tt8B-kvjKaj0VDk-QMqVrkxBowUKL3n0I4umgkiI8
Message-ID: <CAJvnSUC1V8aZL8RA1EwAqocF=eAvc59wTSLBYFkhLZ+L_JLnrA@mail.gmail.com>
Subject: Re: [PATCH] dts: add Scapy asynchronous sniffer
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000bc73b00631e029d5"
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

--000000000000bc73b00631e029d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:41=E2=80=AFPM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

>
> +    def _sniff(self, recv_port: Port):
> +        """Sniff packets and use events and queue to communicate with th=
e
> main thread.
> +
> +        Raises:
> +            InteractiveSSHSessionDeadError: If the SSH connection has
> been unexpectedly interrupted.
> +        """
> +        ready_prompt =3D "Ready."
> +        self.send_command(
> +            "sniff("
> +            f'iface=3D"{recv_port.logical_name}", quiet=3DTrue, store=3D=
False, '
> +            "prn=3Dlambda p: bytes_base64(p.build()).decode(), "
> +            f'started_callback=3Dlambda: print("{ready_prompt}")'
> +            ")",
> +            prompt=3Dready_prompt,
> +        )
> +        self._ssh_channel.settimeout(1)
>

Not a big deal at all and I don't know what the "standard" is, but is there
any reason why this number isn't higher? Like 10? I guess the point of the
timeout is to protect against hanging, versus protect against slow
operations (regardless of what the source of that slowness may be).


>
> --
> 2.43.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000bc73b00631e029d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 18,=
 2025 at 1:41=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@=
arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def _sniff(self, recv_port: Port):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sniff packets and use events=
 and queue to communicate with the main thread.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveSSHSessionDeadError: =
If the SSH connection has been unexpectedly interrupted.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ready_prompt =3D &quot;Ready.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sniff(&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&#39;iface=3D&quot;{recv_port.l=
ogical_name}&quot;, quiet=3DTrue, store=3DFalse, &#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;prn=3Dlambda p: bytes_base=
64(p.build()).decode(), &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&#39;started_callback=3Dlambda:=
 print(&quot;{ready_prompt}&quot;)&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prompt=3Dready_prompt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._ssh_channel.settimeout(1)<br></blockquot=
e><div><br></div><div>Not a big deal at all and I don&#39;t know what the &=
quot;standard&quot; is, but is there any reason why this number isn&#39;t h=
igher? Like 10? I guess the point of the timeout is to protect against hang=
ing, versus protect against slow operations (regardless of what the source =
of that slowness may be).</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>

--000000000000bc73b00631e029d5--
