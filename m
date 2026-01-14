Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24521D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19229427C2;
	Wed, 14 Jan 2026 23:56:36 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 6DB38427CE
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:34 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12331482b8fso918907c88.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768431393; x=1769036193; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1sqjQkFZ14yeyALtc8SKWcBGLE/KkYgzy0bqVD2e+fY=;
 b=DO9rGxTUAbzZGRyOazlOSfALV/4h7Z4qweOsXHGl51aAPKMjB8rPp2eP19RAiJnJN/
 pwH3lACA8oIJ3FlU0ZuN+4A7BsOJJ7sz2sO4Pq3L8tqRHPQJ9FGlcaV3l7dRU32uLZW/
 Tkk7vQaqHV8fKjr8EtuBu3VEMoq9+k2aREjmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431393; x=1769036193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sqjQkFZ14yeyALtc8SKWcBGLE/KkYgzy0bqVD2e+fY=;
 b=og7iBXx+aldwVlCTlq8PH2M5Zd7nZLeaYGPasFXyGYBN5qXiko6vWjrZnV8FfUCMJV
 sieCW8iYWcNGx5FIVwawyAODWM/rhMoiVmGSEZxYhUXpTmdjspy0NPi1sqvvIlFsJI76
 hGrkxqvZDJw25X74wOmyAKVU86K0+HmJEcFsLNyt2TcYo6YRc7VatnfvG+7umq9V4EgA
 Ez+CUW4apEQd5HMuMT3+a4n5G8qmGGv6b+p8LJYU+r/d6Gq4DnesM8GND1NUs7VbH7+O
 GFMYYtEPifxlSNEyb3J/Zq0WbTyqXwlq1OzTbR0HYuyKIFT3/My1rDmjmeWjNYp3DwSN
 I+1A==
X-Gm-Message-State: AOJu0YyLxvz7lCqJfknnrGLMqn2WArZ95Le7Q5yEIjeAlAsUneLppJGE
 H/SFlQdKXvm95U3/gO9k1kl2XWL2TRkHd1Nx1lutwUU443303Ql6Wbc24O45GTzN+4jElJKLcuP
 4jP7nQ5EZwNHqkiCawoOZh8xOjLxUzS2UuS/CrmJTsQ==
X-Gm-Gg: AY/fxX5tA04u079uwNe5O7kyTNCuNbE0bFXjrp4M7ywRMhe6qqAISQA2RUnRiu2j8XY
 23CamcIET5YSw93QjzpbbYxl7vujLli4Z2rmxKV/2Q6Frc+T+Wk6jpTpS7j47/opC/fBfBTJBCq
 i5B3fSGvxSOqsjCeB0SwBxf1gf6aJW5UI+mQeOXo3W8FNPnEZWDmNA3jrRxFD9LxHVAsCd8baij
 o2ENhKe20x7ZjnjA/eEUuXJkUPOBaSLkQvBKJHI9MOoEU8FXSE/MQZyrvxQfRg/Ibz0Ah9csr3v
 +MCBNnhtTayNg8nDxBAmSFJJXY3J9LJyW2ebx5uBu4C5WBV45QJxJDHY3jero/7FOetnySs=
X-Received: by 2002:a05:7022:983:b0:119:e56b:9596 with SMTP id
 a92af1059eb24-1233775f45dmr3840080c88.27.1768431393563; Wed, 14 Jan 2026
 14:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20251121210650.328804-1-abailey@iol.unh.edu>
 <20251126141650.367633-1-abailey@iol.unh.edu>
In-Reply-To: <20251126141650.367633-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 14 Jan 2026 17:54:21 -0500
X-Gm-Features: AZwV_Qh2arg1WdzgBAHcXQuIZdCI07rMHpq0m8BzkIjaf8Kt814uJ7KjJq5v6cY
Message-ID: <CAJvnSUABnGXrKSRmjad0M-+HyA7XPLvxp444q-+TRFLCVgEJbw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: automate VFIO-PCI modprobe
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="00000000000005f579064861058b"
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

--00000000000005f579064861058b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 9:16=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

>
>
> +        if (
> +            test_run.ctx.topology.type !=3D LinkTopology.NO_LINK
> +            and test_run.ctx.sut_node.ports[0].config.os_driver_for_dpdk
> =3D=3D "vfio-pci"
> +        ):
> +            test_run.ctx.sut_node.main_session.send_command("modprobe
> vfio")
> +            test_run.ctx.sut_node.main_session.send_command("modprobe
> vfio-pci")
> +
>          if test_run.config.use_virtual_functions:
>              test_run.ctx.topology.instantiate_vf_ports()
>
>
>
Is there a need to check that test_run.ctx.sut_node.ports[0] is not None?

Also, what is your opinion of an os=3D=3Dlinux check? By my recollection th=
is
variable should be accessible at this stage. It would be okay to kick the
can on this aspect of supporting OS other than linux, but let's only do so
if we have an actual reason. :)

--00000000000005f579064861058b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 26,=
 2025 at 9:16=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.un=
h.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.topology.type !=3D =
LinkTopology.NO_LINK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and test_run.ctx.sut_node.ports[=
0].config.os_driver_for_dpdk =3D=3D &quot;vfio-pci&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.sut_node.main_sessi=
on.send_command(&quot;modprobe vfio&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_run.ctx.sut_node.main_sessi=
on.send_command(&quot;modprobe vfio-pci&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test_run.config.use_virtual_functions:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_run.ctx.topology.insta=
ntiate_vf_ports()<br>
<br><br></blockquote><div><br></div><div>Is there a need to check that test=
_run.ctx.sut_node.ports[0] is not None?</div><div><br></div><div>Also, what=
 is your opinion of an os=3D=3Dlinux check? By my recollection this variabl=
e should=C2=A0be accessible at this stage. It would be okay to kick the can=
 on this aspect of supporting OS other than linux, but let&#39;s only do so=
 if we have an actual reason. :)</div></div></div>

--00000000000005f579064861058b--
