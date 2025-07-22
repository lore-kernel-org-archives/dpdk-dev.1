Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8344C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:30:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B80540616;
	Tue, 22 Jul 2025 16:30:57 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 39296402DE
 for <dev@dpdk.org>; Tue, 22 Jul 2025 16:30:56 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6fafd3cc8f9so71242326d6.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753194655;
 x=1753799455; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dWKRg0Wx+KWg2PJ1m0dWtjRduzSrtbJg4VuxDZPVN4=;
 b=arqHEHwCFY2wTCaLeeYv6VYN6BqOs2oSnYq7iA9U0BOlghJAoWm5EzJJ+yYUklHHiC
 2v0MDqY/Y+BeFEs1e+thVkaXyleawsJsrcCc1GhSxt6MHNDovuaY6LDWy8CXmwoi+KFH
 MHbbe1PjMZWFKgCd55bVT378WuKqua4YyJwB0ItYX44Fb2G+hC/cyPxFodYy+x6MrN4i
 CK1QIGAWD+nsn9UVLEBdjqv7DmjXktknHQ58OuOzsRsasYYqqsJ+xa26Oo0FSYCaav5A
 JHjOQCPW80qviDCWkBh5mEkjuyL6oL3QMzZcuWyIa2O7FX3s24Nb2LhLbASw9+9Mz1Kx
 sMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753194655; x=1753799455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dWKRg0Wx+KWg2PJ1m0dWtjRduzSrtbJg4VuxDZPVN4=;
 b=gM1p1wPZPAi1XUwln6LDBwTB9MRKZuzlcQ1uAdxIjUj+GFD4TF+yP5sqciAjZBWKSk
 eEBaLDCtJwEqzNbcsy1R+ezGu3qdDGGsPb+auTqqGOMe0HIBT02QmSJKg7SYmM3UkUNC
 E+TNMSz+/q185mzklKS40bNakpZdKLUEwHFhJDIKo4n7DTZ/8jw4hbf9DH6cqhPXYimK
 8Ytbkd3iuOJ8Z9gFHGxXzh29VvcjF5cOH+d7cLj4XTaHFsn98twKlLCo3AwU/xDKU4fK
 Cdx+RC53Xpd1ceCbwpnny3+O2ZGH9CK8jm9F7D/rArLhH6ImGmSVpCcXPi9/Tv5Vzy8S
 OWKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUdv7Ter1IqGTEVHwSlJaPwSeHVSs4kDlZhmW3o6eJo/7G0q0bEc7LE2DXefqpkoMlcJQ=@dpdk.org
X-Gm-Message-State: AOJu0Yx2j2CuDnPZeE2evWD7IgB7AW3cQa1aGRv1OgvKWF2eakmWbXOU
 BmmRC9JjOaCmYpmkCeGJ987OR2QYwgEBdW4fIqnvSpf6p7lEL2nyJF6xxTHl6b3hvlTJo13PzRV
 svei7n27PfKM1HRFyfi/ViuUhYYwJ3Jdvtu97lXd2aA==
X-Gm-Gg: ASbGncsa5bGY4cSMesO2wT4krUp/CPLcoT8hjSAnDIrQSuHWSlob8z/fPLJhfDdfKFV
 +STgk62yk6ZJqzsR+lD+Rrw44Mx3rMwnjbyr65JQiPIiSf/ilqqURoG8yMzV5CfbgUAj4T9x2ac
 tPer/T2exfUMwJaNlRC6kge1lYUhVI02e3uw5bh0hSJa5fU3CSVC+zfr6iA9EvoJL1XMIUX5EDP
 lxlmUgdKnIXoXSOYkMhFD1Tf10+ljgMAJx/bvp92g==
X-Google-Smtp-Source: AGHT+IE8cSYKg4gIlB6ACsDYobsMpE336FXweiT51QB691r/oTDRwQLuUHfd4jZwD1XQBVdCq+pGq/LV7xXt8VyYRsk=
X-Received: by 2002:a05:6214:21e9:b0:6fb:51c:395 with SMTP id
 6a1803df08f44-704f6bd3b12mr305492156d6.41.1753194654982; Tue, 22 Jul 2025
 07:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
In-Reply-To: <20250722063924.2f87f3f7@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 22 Jul 2025 19:30:41 +0500
X-Gm-Features: Ac12FXyZShmXEAmRQKyBOzztL7k_e2dGalkqK4GMV8rDK9x9KaEBMNrrfwHk9SE
Message-ID: <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000a200a3063a8570fa"
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

--000000000000a200a3063a8570fa
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,
Can we add only the check that fixes the segfault, or do you mean that it
should be fixed at the PMD level?

Best regards,
Khadem

On Tue, Jul 22, 2025, 18:39 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue, 22 Jul 2025 07:54:39 -0400
> Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>
> > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > +             (dev == NULL || dev->data == NULL ||
> > +             dev->data->dev_private == NULL ||
>
> dev can't be NULL and checking it here will cause a Coverity warning.
>
> There are many other ethdev calls that will fail if primary dies.
> stats, xstats, rx/tx burst, ...
>
> I don't think it is good idea to add checks here.
>

--000000000000a200a3063a8570fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Stephen,=C2=A0<div dir=3D"auto">Can we add only the ch=
eck that fixes the segfault, or do you mean that it should be fixed at the =
PMD level?<br><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,</=
div><div dir=3D"auto">Khadem</div></div></div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2=
2, 2025, 18:39 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On Tue, 22 Jul 2025 07:54:39 -0400<br>
Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uetpeshawar.edu.pk" target=
=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote=
:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rte_eal_process_type() =3D=3D RTE_PROC_SECOND=
ARY &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dev =3D=3D NULL || d=
ev-&gt;data =3D=3D NULL ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;dev_=
private =3D=3D NULL ||<br>
<br>
dev can&#39;t be NULL and checking it here will cause a Coverity warning.<b=
r>
<br>
There are many other ethdev calls that will fail if primary dies.<br>
stats, xstats, rx/tx burst, ...<br>
<br>
I don&#39;t think it is good idea to add checks here.<br>
</blockquote></div>

--000000000000a200a3063a8570fa--
