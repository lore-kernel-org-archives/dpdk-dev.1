Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C940FC28B2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 12:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C42C340FDE;
	Thu, 13 Mar 2025 13:57:40 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 438B840EF1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 13:57:39 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22409077c06so23181555ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741870658; x=1742475458; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJEHGk0ieq/CNRfrtlaTpN0lBcbZt24U48DULMFQ6QY=;
 b=US8a1q3bvo2af5Ma+YhM3EyKZ0UY3OXO04E0ftsn0YQF1pWU5OMJhwGBM1nBgHNmsC
 zAPmH0MCs+M1pCLui7tjlDJ3w0YPyq/y6YF+f33wTNF49AFswUC4LF6bblqANZjpKUgn
 8uqzguK+AKLKlbpWE27SDqiFSHmoZTgsz2EVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741870658; x=1742475458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJEHGk0ieq/CNRfrtlaTpN0lBcbZt24U48DULMFQ6QY=;
 b=pJum69uBaskzMn49VV8/D4+ARHaRVxUH8gxUQtomX9uhVwV69Hn0iZz/sqffR6Cm1F
 S0RrrOLTcnbzGKgvIRV6T+96a7jCtFeHwgzNW/KIUtj/4lRWm7ZJx7pXT/9QnR/cblcz
 weSOVJxIEWoNQBXD1cM18gC6LQaGHhSpwpw+uj5BxDfXJ6xvihU4L0/5ui+e9p/9NW2l
 PMNocqGbCf6IcZm3gyrdnXO3mLimwla/o09y0OVnDEis29PmSRajqqVRqGvIuU8KHSmy
 HBbuUUUsBLMivL8De59mvRJj0ThVdTvoFrpejPYPaDIkdGnDXMIDj1BZZfKiUQFxF+4t
 3rcA==
X-Gm-Message-State: AOJu0YxeOm7evw8E44sCvZdjuPM7YWMhFt94PWP9fnbaXIus3cM2I3bs
 du/3Kd2rdXjfIWssbarNIf7rZYIAsAfpqi/u629Unt74k/T1I69hTpe/ikYdlJvxblz2HSANKjP
 Yxu4rTz8Tn5ld876542RPPTw/T/oMFMJeF084mg==
X-Gm-Gg: ASbGncu1Os1wMWOz7dQMeEamaTOTxuXwr5ufABObekH/ZerXk7it0uGP03y5ivoTWTA
 R0moqlFwpo2HnExwooDwxcuFdIuSG6oTRDfVVr9eiuUMh9mqjPx77bQt0AIuG6/EmZk2aKld6f3
 miEmZXjcq7en3OMAdQtZhbh4c1
X-Google-Smtp-Source: AGHT+IGyDkA9pR7ztc9R/U/zVUpXC+OHwPKUrU4Dxk0dIYcnIu8vXp3DUn6IGslehrbJTCZ+ILlKxvOC9WFKvya6YbU=
X-Received: by 2002:a17:903:2405:b0:224:376:7a21 with SMTP id
 d9443c01a7336-22428bdee20mr377318275ad.42.1741870658408; Thu, 13 Mar 2025
 05:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
 <20250313033611.1896695-1-probb@iol.unh.edu>
 <20250313033611.1896695-2-probb@iol.unh.edu>
In-Reply-To: <20250313033611.1896695-2-probb@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 08:53:56 -0400
X-Gm-Features: AQ5f1JoSG-QDRqefEYFER8b3-vRcbTZo0vgsbH_d5EFk0E5_SIpvNhotEIYgUiM
Message-ID: <CAJvnSUA+gEEZKq8r6GT_DigwUFKDuri90E+kvXkQa+JD-RGUMw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: add OS abstractions for creating virtual
 functions
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu, 
 dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000d6e75d063038dd9e"
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

--000000000000d6e75d063038dd9e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:40=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> w=
rote:

>
> +    def create_vfs(self, pf_port: Port) -> None:
> +        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
> +
> +        Raises:
> +            InternalError: If the number of VFs is greater than 0 but
> less than the
> +            maximum for `pf_port`.
> +        """
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:",
> "\\:")
> +        curr_num_vfs =3D int(self.send_command(f"cat
> {sys_bus_path}/sriov_numvfs").stdout)
> +        max_num_vfs =3D int(
> +            self.send_command(f"cat {sys_bus_path}/sriov_totalvfs",
> privileged=3DTrue).stdout
> +        )
> +        if 0 < curr_num_vfs < max_num_vfs:
> +            raise InternalError("There are existing VFs on the port whic=
h
> must be deleted.")
>

Maybe in this situation we should just delete all VFs, and then create the
new set of VFs.

--000000000000d6e75d063038dd9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 12,=
 2025 at 11:40=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.=
edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def create_vfs(self, pf_port: Port) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Overrides :meth:`~.os_sessio=
n.OSSession.create_vfs`.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If the number of =
VFs is greater than 0 but less than the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 maximum for `pf_port`.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_bus_path =3D f&quot;/sys/bus/pci/devices/{=
pf_port.pci}&quot;.replace(&quot;:&quot;, &quot;\\:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 curr_num_vfs =3D int(self.send_command(f&quot;=
cat {sys_bus_path}/sriov_numvfs&quot;).stdout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_num_vfs =3D int(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.send_command(f&quot;cat {sy=
s_bus_path}/sriov_totalvfs&quot;, privileged=3DTrue).stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if 0 &lt; curr_num_vfs &lt; max_num_vfs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InternalError(&quot;There =
are existing VFs on the port which must be deleted.&quot;)<br></blockquote>=
<div><br></div><div>Maybe in this situation we should just delete all VFs, =
and then create the new set of VFs.</div><div>=C2=A0</div></div></div>

--000000000000d6e75d063038dd9e--
