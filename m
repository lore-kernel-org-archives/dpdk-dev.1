Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F05C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 138A840613;
	Thu, 26 Jun 2025 16:30:06 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 08A7140156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:30:04 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6facf4d8e9eso12729966d6.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1750948203;
 x=1751553003; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/vRtP/0FgU2Iq3+KSs6woSi6fA5Gs3d3KlMFO1diPoY=;
 b=EaBopbfPH0BxNQU0HcHNRGWXFyl4BJK08Xt+PGifC24SNwHSDU22hgBaVl9ltffZh3
 p4gV70rVZcWGo0d6o+kcs1jio44q0iCIW+HZuL1Fz99yEQrW1IGEv+IY5bklXDqLqupW
 AhugdEqFBkMh6VYLbN1R5g+B/nQ+vuyWZyTXLRbN5lAa+USqQ1pLTXdeN7tN3zdYQEEI
 WVVLiMELD3qARZL5Oji3Y0V6PdrAUVO5+uRQOdXrMkU38gtLH0MUPcWlIp6hxmD0nr6t
 OgqHIRXQ3SENnsdkoUYSL+K92wKf8lflSw28yJpzUqe9v2GjIIFWoNsJVoAiR58rD3/D
 IGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750948203; x=1751553003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vRtP/0FgU2Iq3+KSs6woSi6fA5Gs3d3KlMFO1diPoY=;
 b=QcUjku3bGCWXttG1ZSedISHOjDraKbjna0acs6yPA1MifLjGPDJZLZ9O/09h8UPzdk
 3wgJK/6zgf+1S9FR+KlTSTSzKkZ9yB0vmXpE5msGGECtn9WLFGxCRUhJG49KhTdW9nQ2
 /Tn3zyqBGiet4M0dY5DcX9QhiAps7YgkcAGcQLbYxBUE8Jqy5ap0ZK+Zmt5N2pBqdZwJ
 V/5p0gbPr1xeg/2xXtq0cdJKAMKCoYaC7zrwV9APGXx8DuamOl9kmj7bzIIEAti0nKQN
 GxwnxBz1H9W8dJOV2d9sKrgcFChiFDeQLsInwKNJfQ4nVXjeQ3GjyAUDTFPfoSQ5I5+v
 ON2A==
X-Gm-Message-State: AOJu0YzE3LjdfapSBj6TD7b3vVHGT+BLjWgbIBOvQwWWWQcLNCZeFmtE
 uqP3zfIdfwiARXbFt+L5lBMJb6WKBN0t9TXNOH6oJEqDcxsDbbaUXhFfW/7uwgesu1bTNShjRII
 9EfQVa6T4L4xdQniPKUpu8+33yw//xx5FKwK42jtavg==
X-Gm-Gg: ASbGncv995WATUQsHg47Nz+IZdN6bCQP/DX/xjw76mrW9ubZ+T2vDvOez/Zoy9AOKX0
 zBxi5rbvtMnhlk6tXuBVOAW8+TMYGy57csA5nfcdZ1eoMirWKD98uYEwd9IJD7NZOfDiTO8R8u1
 ubAgt/cvJ9Wnkk5DU7PRU1kDRQBAZS1dBRfejfENu84CdT
X-Google-Smtp-Source: AGHT+IG2kb2Lb4i+X7ZbByBZjafdQmtivGDZKFCL/iHdxMaGHH3k9QWXKLK6wu1WkUfE6a6LZKK2ED0ccgnMxQJSkIM=
X-Received: by 2002:ad4:5ce9:0:b0:6fa:cb95:c1eb with SMTP id
 6a1803df08f44-6fd5ef3320emr118960606d6.4.1750948203141; Thu, 26 Jun 2025
 07:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250626130702.3921887-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250626133251.cfa7hd5tbclo3xjo@ds-vm-debian.local>
In-Reply-To: <20250626133251.cfa7hd5tbclo3xjo@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 26 Jun 2025 19:29:50 +0500
X-Gm-Features: Ac12FXz7rcfAEmy7_i5hUIHrkil-oBeQ-5QZHT2bDHNwA1i2xg7SrwyTBLobqLk
Message-ID: <CA++2-x7rvgCkg8RYCTdCUQHHrtS_dU+drYErGE9WCG+TM3nF2g@mail.gmail.com>
Subject: Re: [PATCH v2] net/mlx5: fix segfault on indirect action age query
 with conntrack
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com, 
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Content-Type: multipart/alternative; boundary="000000000000ab381806387a6556"
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

--000000000000ab381806387a6556
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for the review and Ack.

I=E2=80=99ll make sure to include version change notes under a notes sectio=
n in
future patch versions, as per the contribution guide.

Also noted about maintainers, I had added them in v1 but missed them in v2.
I=E2=80=99ll make sure to always use `get-maintainer.sh` going forward.

Thanks again for the guidance and support.

Best regards,
Khadem Ullah


On Thu, Jun 26, 2025, 18:33 Dariusz Sosnowski <dsosnowski@nvidia.com> wrote=
:

> Thank you very much for changes and detailed descriptions.
> It helped a lot during review.
>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>
> On Thu, Jun 26, 2025 at 09:07:02AM -0400, Khadem Ullah wrote:
> > v2:
> >  - Added missing check for AGE + CT conflict in flow_dv_query().
> >  - Removed unnecessary null check from flow_aso_age_get_by_idx().
> >  - Added Fixes tag for LTS tracking.
> >  - Ensured .mailmap and Signed-off-by addresses match.
>
> In case of any future contribution would you be able to put the changes
> between versions in notes section of the patch?
> You can find the details here:
> https://doc.dpdk.org/guides/contributing/patches.html#creating-patches
>
> Also, in the future would you be able to send patches to all relevant
> maintainers? We have a script, ./devtools/get-maintainer.sh,
> which extracts the info from MAINTAINERS file.
> You can find more info here:
> https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
>
> >
> > This patch fixes a segmentation fault that occurs when querying the
> > AGE action of a flow rule that uses indirect connection tracking (CT).
> >
> > Background:
> > AGE and CT indices share a union in the mlx5 flow struct. When using CT
> > without age, the age index is invalid. Querying AGE in this case leads
> > to a crash due to reading an invalid pointer.
> >
> > Fix:
> > Add a check in `flow_dv_query()` to prevent AGE queries on indirect CT
> > actions. This is the correct fix rather than null-checking the pool.
> >
> > Steps to reproduce:
> >  1. Create an indirect CT action:
> >     flow indirect_action 0 create ingress action conntrack / end
> >
> >  2. Create a root rule with jump:
> >     flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump
> group 3 / end
> >
> >  3. Create a group 3 rule using the indirect action:
> >     flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end action=
s
> indirect 0 / jump group 5 / end
> >
> >  4. Create a group 5 rule matching CT state:
> >     flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack
> is 1 / end actions queue index 5 / end
> >
> >  5. Querying the first rule causes segfault:
> >     flow query 0 1 age
> >
> > Fixes: 2d084f69aa26 ("net/mlx5: add translation of connection tracking
> action")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>

--000000000000ab381806387a6556
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you very much for the review and Ack.<div dir=3D"au=
to"><br></div><div dir=3D"auto">I=E2=80=99ll make sure to include version c=
hange notes under a notes section in future patch versions, as per the cont=
ribution guide.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also not=
ed about maintainers, I had added them in v1 but missed them in v2. I=E2=80=
=99ll make sure to always use `get-maintainer.sh` going forward.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Thanks again for the guidance and =
support.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,=
=C2=A0=C2=A0</div><div dir=3D"auto">Khadem Ullah</div><div dir=3D"auto"><br=
></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Jun 26, 2025, 18:33 Dariusz Sosnowski=
 &lt;<a href=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Thank you very much for cha=
nges and detailed descriptions.<br>
It helped a lot during review.<br>
<br>
Acked-by: Dariusz Sosnowski &lt;<a href=3D"mailto:dsosnowski@nvidia.com" ta=
rget=3D"_blank" rel=3D"noreferrer">dsosnowski@nvidia.com</a>&gt;<br>
<br>
On Thu, Jun 26, 2025 at 09:07:02AM -0400, Khadem Ullah wrote:<br>
&gt; v2:<br>
&gt;=C2=A0 - Added missing check for AGE + CT conflict in flow_dv_query().<=
br>
&gt;=C2=A0 - Removed unnecessary null check from flow_aso_age_get_by_idx().=
<br>
&gt;=C2=A0 - Added Fixes tag for LTS tracking.<br>
&gt;=C2=A0 - Ensured .mailmap and Signed-off-by addresses match.<br>
<br>
In case of any future contribution would you be able to put the changes<br>
between versions in notes section of the patch?<br>
You can find the details here: <a href=3D"https://doc.dpdk.org/guides/contr=
ibuting/patches.html#creating-patches" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://doc.dpdk.org/guides/contributing/patches.html#creating-=
patches</a><br>
<br>
Also, in the future would you be able to send patches to all relevant<br>
maintainers? We have a script, ./devtools/get-maintainer.sh,<br>
which extracts the info from MAINTAINERS file.<br>
You can find more info here: <a href=3D"https://doc.dpdk.org/guides/contrib=
uting/patches.html#sending-patches" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://doc.dpdk.org/guides/contributing/patches.html#sending-patc=
hes</a><br>
<br>
&gt; <br>
&gt; This patch fixes a segmentation fault that occurs when querying the<br=
>
&gt; AGE action of a flow rule that uses indirect connection tracking (CT).=
<br>
&gt; <br>
&gt; Background:<br>
&gt; AGE and CT indices share a union in the mlx5 flow struct. When using C=
T<br>
&gt; without age, the age index is invalid. Querying AGE in this case leads=
<br>
&gt; to a crash due to reading an invalid pointer.<br>
&gt; <br>
&gt; Fix:<br>
&gt; Add a check in `flow_dv_query()` to prevent AGE queries on indirect CT=
<br>
&gt; actions. This is the correct fix rather than null-checking the pool.<b=
r>
&gt; <br>
&gt; Steps to reproduce:<br>
&gt;=C2=A0 1. Create an indirect CT action:<br>
&gt;=C2=A0 =C2=A0 =C2=A0flow indirect_action 0 create ingress action conntr=
ack / end<br>
&gt; <br>
&gt;=C2=A0 2. Create a root rule with jump:<br>
&gt;=C2=A0 =C2=A0 =C2=A0flow create 0 ingress pattern eth / ipv4 / tcp / en=
d actions jump group 3 / end<br>
&gt; <br>
&gt;=C2=A0 3. Create a group 3 rule using the indirect action:<br>
&gt;=C2=A0 =C2=A0 =C2=A0flow create 0 group 3 ingress pattern eth / ipv4 / =
tcp / end actions indirect 0 / jump group 5 / end<br>
&gt; <br>
&gt;=C2=A0 4. Create a group 5 rule matching CT state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0flow create 0 group 5 ingress pattern eth / ipv4 / =
tcp / conntrack is 1 / end actions queue index 5 / end<br>
&gt; <br>
&gt;=C2=A0 5. Querying the first rule causes segfault:<br>
&gt;=C2=A0 =C2=A0 =C2=A0flow query 0 1 age<br>
&gt; <br>
&gt; Fixes: 2d084f69aa26 (&quot;net/mlx5: add translation of connection tra=
cking action&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt; <br>
&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpesha=
war.edu.pk" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.ed=
u.pk</a>&gt;<br>
</blockquote></div>

--000000000000ab381806387a6556--
