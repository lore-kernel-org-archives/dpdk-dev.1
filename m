Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF6C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 01:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E667140270;
	Fri,  8 Aug 2025 03:21:24 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2DBEB40150
 for <dev@dpdk.org>; Fri,  8 Aug 2025 03:21:24 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b42348bae1fso966361a12.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 18:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754616083; x=1755220883; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7zPAfrKsq5ZMZVcZrY5AoAH0lIGqR+OR509cmOY9TnE=;
 b=Y5gjwCvgDQP2/Bk67yjPJKYtUvNzmcIn1/UZlqiFBS8Hq5aYfvCQsE+vNlXdpa2U+o
 lN1J6S/0O6fLrlMVKsS7/9VsRwRCBK6+uLHcUy0ltppuUigfM8kLU4rkhTyhh6U0awWm
 ly/merYDcCLmAUDHnZXqujr1N+YGY22cIFL4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754616083; x=1755220883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zPAfrKsq5ZMZVcZrY5AoAH0lIGqR+OR509cmOY9TnE=;
 b=uDvMS8WFW7AxiAeEWlo3GMS0E9za8Mqr8j6QDQh1NVMGS3suYQh03XA/Jaupk7yntx
 jmjDYfvG1pQolilFU1m9mD+kWYbjnP/5nt8EBn22vqFJYj5Ggk89GlBkZA+ZPqnelzmv
 +2Ci+3ADJg3zWtjrsdoKfsJenWncrzT+DnnlIvUY4TrZpUYgLvIKcq8GmU5Beu3u1N6c
 S5JkpoGhzuHaejLu4dusdE+HR7DBGoOsxSu8sptGEBSe/xkZWvKL/dRsWVTROx5KDZGa
 OAc1e1aHCUZskgZeNqI34baMcppSbrWsNXD+jzdOhCqWDoD8PGtiTIkzAR5kgprpe2Vn
 NhSw==
X-Gm-Message-State: AOJu0Ywd9ruKHXoUQeTT6NPyqy/9l/sRual5qqY9tjB16pubkIXgkfiX
 ugGIVGhJmV7drfVMVGPZjl2sEO7WOaBIAXyzCI64OTkuZ7MU7p+AWLJNCTM1stEyJj9Dl6MpGSn
 X6IjYL2Y/qZv4vU6I7IvuVzUzC8cq7rVOboL/iaFr0g==
X-Gm-Gg: ASbGncsJRyJ4rhB3x4rplnrv4bsINVHmP/oiHiF9oMCAitAbzZmB7/+6La13+Wc6dm9
 jHCo22aC6JS7QTdI2wtBKkmAv7thJEO+nFzM9jFFNbL+vQf0VAdkgDee2lXgANpEefDxcJBWp0/
 W9DEnVNtjIVDFedy4IoeWYeZf8g58xDAW/mJuQgeUsHXbGzK396IQRWtHe+9h0DaU6YjMRWsbCH
 Ri5gEAQHywmM9dXPlfbk1BeoTdh6v4r7ko5IAk=
X-Google-Smtp-Source: AGHT+IEQo1lpFfjAw00hNB75FQeQKn/vYB4JmUCS4x5gaOu5ZLVya+35CProlq5bGaerhhk824+YWt22t5VBxZHwWrI=
X-Received: by 2002:a17:902:ce8c:b0:220:ea90:191e with SMTP id
 d9443c01a7336-242c20030ffmr14840435ad.4.1754616083105; Thu, 07 Aug 2025
 18:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-2-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-2-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 7 Aug 2025 21:15:06 -0400
X-Gm-Features: Ac12FXzCGEMK55reC-bRCJN6Lr9eiQCHDVP3Pt7s0RIRavQNXL5OgwEEOao1RsY
Message-ID: <CAJvnSUAdZJKbaxwnw587SAvre1WoVh4g+hvH3HYK-1GxtAF=HQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dts: merge RemoteSession class
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000059e2c1063bd06473"
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

--00000000000059e2c1063bd06473
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

> Merge the RemoteSession class with SSHSession as there is no current use
> of a separate channel other than SSH.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  doc/api/dts/framework.remote_session.rst      |   1 -
>  .../framework.remote_session.ssh_session.rst  |   8 --
>  dts/framework/remote_session/__init__.py      |   3 +-
>  .../remote_session/remote_session.py          | 110 ++++++++++++-----
>  dts/framework/remote_session/ssh_session.py   | 116 ------------------
>  5 files changed, 79 insertions(+), 159 deletions(-)
>  delete mode 100644 doc/api/dts/framework.remote_session.ssh_session.rst
>  delete mode 100644 dts/framework/remote_session/ssh_session.py
>
> diff --git a/doc/api/dts/framework.remote_session.rst
> b/doc/api/dts/framework.remote_session.rst
> index 27c9153e64..e4ebd21ab9 100644
> --- a/doc/api/dts/framework.remote_session.rst
> +++ b/doc/api/dts/framework.remote_session.rst
> @@ -12,7 +12,6 @@ remote\_session - Node Connections Package
>     :maxdepth: 1
>
> -class RemoteSession(ABC):
> +class RemoteSession:
>      """Non-interactive remote session.
>
> -    The abstract methods must be implemented in order to connect to a
> remote host (node)
> -    and maintain a remote session.
> -    The subclasses must use (or implement) some underlying transport
> protocol (e.g. SSH)
> -    to implement the methods. On top of that, it provides some basic
> services common to all
> -    subclasses, such as keeping history and logging what's being execute=
d
> on the remote node.
> +    The connection is implemented with
> +    `the Fabric Python library <https://docs.fabfile.org/en/latest/>`_.
>
>      Attributes:
>          name: The name of the session.
> @@ -82,6 +94,7 @@ class RemoteSession(ABC):
>          password: The password used in the connection. Most frequently
> empty,
>              as the use of passwords is discouraged.
>

This isn't really about your patch but at some point we need to decide to
remove password support for real, or (re)document it in the DTS
documentation so that people can use it if they want. I'm not super keen on
us keeping around easter egg code which will break later. :) Something we
can chat about at the next DTS meeting.


>          history: The executed commands during this session.
> +        session: The underlying Fabric SSH session.
>      """
>
>      name: str
> @@ -91,6 +104,7 @@ class RemoteSession(ABC):
>      username: str
>      password: str
>      history: list[CommandResult]
> +    session: Connection
>      _logger: DTSLogger
>      _node_config: NodeConfiguration
>
> 2.43.0
>
>
Happy to see the two classes reduced into just RemoteSession.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000059e2c1063bd06473
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro=
@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Merge the RemoteSession class with SSHSess=
ion as there is no current use<br>
of a separate channel other than SSH.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/framework.remote_session.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 -<br>
=C2=A0.../framework.remote_session.ssh_session.rst=C2=A0 |=C2=A0 =C2=A08 --=
<br>
=C2=A0dts/framework/remote_session/__init__.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +-<br>
=C2=A0.../remote_session/remote_session.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 110 ++++++++++++-----<br>
=C2=A0dts/framework/remote_session/ssh_session.py=C2=A0 =C2=A0| 116 -------=
-----------<br>
=C2=A05 files changed, 79 insertions(+), 159 deletions(-)<br>
=C2=A0delete mode 100644 doc/api/dts/framework.remote_session.ssh_session.r=
st<br>
=C2=A0delete mode 100644 dts/framework/remote_session/ssh_session.py<br>
<br>
diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/framewo=
rk.remote_session.rst<br>
index 27c9153e64..e4ebd21ab9 100644<br>
--- a/doc/api/dts/framework.remote_session.rst<br>
+++ b/doc/api/dts/framework.remote_session.rst<br>
@@ -12,7 +12,6 @@ remote\_session - Node Connections Package<br>
=C2=A0 =C2=A0 :maxdepth: 1<br><br>
-class RemoteSession(ABC):<br>
+class RemoteSession:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Non-interactive remote session.<br>
<br>
-=C2=A0 =C2=A0 The abstract methods must be implemented in order to connect=
 to a remote host (node)<br>
-=C2=A0 =C2=A0 and maintain a remote session.<br>
-=C2=A0 =C2=A0 The subclasses must use (or implement) some underlying trans=
port protocol (e.g. SSH)<br>
-=C2=A0 =C2=A0 to implement the methods. On top of that, it provides some b=
asic services common to all<br>
-=C2=A0 =C2=A0 subclasses, such as keeping history and logging what&#39;s b=
eing executed on the remote node.<br>
+=C2=A0 =C2=A0 The connection is implemented with<br>
+=C2=A0 =C2=A0 `the Fabric Python library &lt;<a href=3D"https://docs.fabfi=
le.org/en/latest/" rel=3D"noreferrer" target=3D"_blank">https://docs.fabfil=
e.org/en/latest/</a>&gt;`_.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Attributes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: The name of the session.<br>
@@ -82,6 +94,7 @@ class RemoteSession(ABC):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0password: The password used in the connec=
tion. Most frequently empty,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0as the use of passwords is =
discouraged.<br></blockquote><div><br></div><div>This isn&#39;t really abou=
t your patch but at some point we need to decide to remove password support=
 for real, or (re)document it in the DTS documentation so that people can u=
se it if they want. I&#39;m not super keen on us keeping around easter egg =
code which will break later. :) Something we can chat about at the next DTS=
 meeting.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0history: The executed commands during thi=
s session.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 session: The underlying Fabric SSH session.<br=
>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0name: str<br>
@@ -91,6 +104,7 @@ class RemoteSession(ABC):<br>
=C2=A0 =C2=A0 =C2=A0username: str<br>
=C2=A0 =C2=A0 =C2=A0password: str<br>
=C2=A0 =C2=A0 =C2=A0history: list[CommandResult]<br>
+=C2=A0 =C2=A0 session: Connection<br>
=C2=A0 =C2=A0 =C2=A0_logger: DTSLogger<br>
=C2=A0 =C2=A0 =C2=A0_node_config: NodeConfiguration<br><br>
2.43.0<br>
<br></blockquote><div><br></div><div>Happy to see the two classes reduced i=
nto just RemoteSession.=C2=A0</div><div><br></div><div>Reviewed-by: Patrick=
 Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=
=A0</div></div></div>

--00000000000059e2c1063bd06473--
