Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65DC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 554E442E51;
	Fri, 16 Jan 2026 22:20:12 +0100 (CET)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id E775142E48
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:20:10 +0100 (CET)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12332910300so1145166c88.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768598410; x=1769203210; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wLXtPvZO8DE6jZ02vGHvKFdVYg4ZLTLNsx5JGKkh6wo=;
 b=d0EHIhc1NCNl28DPXmLCKLUMIXPIOHcU6A7El0l9ZeoN4t2+ilND39oNabtjJYQ8a+
 WcxUclP6zWVmEi4oLTFytryL00Eu4tH24cuJ9gsJhBJbWuMVUTbfgouQKU0R4jHmx+Ei
 93GEjfBrxwxNH7Bub5/Rw1ryaarFddn+hyR9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598410; x=1769203210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLXtPvZO8DE6jZ02vGHvKFdVYg4ZLTLNsx5JGKkh6wo=;
 b=Tm7boXO8+lZudh9HavtUis1tqBkLfTzu+pjX0MPiT5zAUdERkMTHnJqEJrAewUA+ni
 exKeZVQQSzTdG2NG/JeM5oK6Sd2iKbT0UED+ZrjzdsthW5S8A4cjfJR/gacrI5BW2BNX
 Kb9whfOqrI5FIJXmG4tVSeZJDCd+u2Um2d+gkAyUc0+3/vo6swGziLjoDA9J1affzTFj
 vevhIDzTUBVexgYuUVMz2W79+36jaowzzDMixchMBsFMTMu2afZ2MyMGL3P8vcSUj5+6
 U8NDO4BOsZ3LK3gfBJW8ms4xBRcsL+XZCzLXtMQCEYdACtIFH6X8nBlzDPul6N6nV5Ct
 op5Q==
X-Gm-Message-State: AOJu0Ywqy9IBVrdGtzzs+SF+QZfEVxpzsGv5fa/pDcNixNxx3ZLxHf4a
 A/e9xWZBKbBqw7xklHdaHcGVEUUBoT+Fdv6jAyc1StpiVsqC/FOAoubjD0VyUM3pr46leoXnlUK
 acmKD9pnicr3JAltietBsUpjcTM3Onm2+q20H0sbFUA==
X-Gm-Gg: AY/fxX4aNEqiO581a+82+T1w6X5Nsy2AkmwbM2X7RdNik7One08MWZP/0WyyTwBuVab
 kJ9Y/GvEeJ6vEvTIchOElgrtgbXHDW07Iiq76nM7N2Lvx+0xdNOiCqX+10A+XD3cswaZV8IIMev
 96Ky8p9ibvhxSsnHYZ6zD2l0If0hDJ1iGVGEg+jP0ShtG+bBQ8eaEhcGeoBtuuqrbvJPnzFPfd7
 Pgb+V0yOd1gcKI2L4xVWembuHZRbfmMxFDHA9XePwgGpzgesGTna7cBBGjW6pcntqrsoPq9KzBP
 y8/WUlIyfZcjYW+oSWKAZLIP1nEKpfIotvMJIUxXjA==
X-Received: by 2002:a05:7022:4588:b0:119:e569:fb9a with SMTP id
 a92af1059eb24-1244a6fc9a2mr3652879c88.9.1768598409993; Fri, 16 Jan 2026
 13:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20251121210650.328804-1-abailey@iol.unh.edu>
 <20251126141650.367633-1-abailey@iol.unh.edu>
In-Reply-To: <20251126141650.367633-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 16 Jan 2026 16:17:55 -0500
X-Gm-Features: AZwV_QhZiBxaqBpgDetKRYOgrpNb6jAjB2ZWOnqQVAd6MP7ArENLYB-l8YNq6G8
Message-ID: <CAJvnSUBp6UO2JzmxYZWmrZGwYP5zBQC6TwDY5H2JBa-7zTR_7Q@mail.gmail.com>
Subject: Re: [PATCH v2] dts: automate VFIO-PCI modprobe
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="000000000000fa76f2064887e786"
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

--000000000000fa76f2064887e786
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
>

Final nit - I think it's better to add an abstract method for load_vfio()
or similar and implement that in linux_session.py

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000fa76f2064887e786
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
on.send_command(&quot;modprobe vfio-pci&quot;)<br></blockquote><div><br></d=
iv><div>Final nit - I think it&#39;s better to add an abstract method for l=
oad_vfio() or similar and implement that in linux_session.py</div><div>=C2=
=A0</div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh=
.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--000000000000fa76f2064887e786--
