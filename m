Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2722C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 20:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC5D6402DA;
	Tue, 25 Feb 2025 21:42:32 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 01B7D402D7
 for <dev@dpdk.org>; Tue, 25 Feb 2025 21:42:31 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fcb6c42c47so9450041a91.1
 for <dev@dpdk.org>; Tue, 25 Feb 2025 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1740516151; x=1741120951; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1keVYdTwMzjyuqetjBJAgYXNzUgy9wBOSM00bn8rR7I=;
 b=XGBCbXNC+Xy8p+N2KeQz/JtxOIX0npYAPuNTG+HfUJdYfJhVhX8TrF2E6ZeENJKDPq
 heZcdQxDFC8m0e1/MPYheFmUWnx7ybK/ihFBQ01GL/B7pWyPlIw/Pl2cDaf8ETZR7Rm+
 JNeZWpwTEcet7C8mQNvTy9NnCv/5GIQxq+MqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740516151; x=1741120951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1keVYdTwMzjyuqetjBJAgYXNzUgy9wBOSM00bn8rR7I=;
 b=dRNasVf6/rrBlqN8BehX4t5mAehGgfdaN/Dmgdyp2/tdK12T5A50ljPKFAN+Y3WshL
 2ILcb7/CYOJN/K4D3bPq70FLdWeQyPi4gKKLCFHk0v3rA2NZmgyT3gghi00LPBZfHfgO
 D+cCAR00mvzfh6Qowf3N03+qAzdS34eNd5IEgB93NUtUaBpL6F/MQDZS3KDRzqgWd3Fx
 nxtvKsXAImeA3/g4QBLLCtf0xopl7esGoQSwoXO4YRyaHWKE4PRi3+in4T4vPpRsSaQT
 KisSk74ZgvR8z7zafdBq7pEwOszlgBKAPa8OW2PpmJIL9c4sj5F7fuNtoZIg9BK+1Lwm
 +LJw==
X-Gm-Message-State: AOJu0YxUMJXUsxSuwbSCq2GlcofyS7DGUyVkPwb9i9lskC9U7DN21W0/
 CLbBN1ElyJ8XRm7HZJWM5Ar/8LzhUJtn9P93LY9ByIdeUEdkwYoCz7KCvMZwuHTELDpUwUwSoS4
 gIovfSOiedxlCZTl2K0FdBzDI/8fuw1dIxrZL7w==
X-Gm-Gg: ASbGncsX7+j3tFlDlzLfdH5oo+qlEXWgw1pQ3cDSVmiNhaUeS9BpazBTd9EvXSI1WFj
 kPH+PVx+tUZ+FQmSCgKGitpFwqpKJpigC4YMy8uUWD0mwHenZeTI0FrlleCrd1ERdQz7BxWvz/1
 6Wxwnwjq2NKGot3bBLzCtzF6oSTuj8t8IdR4stWEa8
X-Google-Smtp-Source: AGHT+IEiEeJUJzaOUOOoJrTgTJReD5jwh2vJzs3ZtrKqFBIqOyocRS9iwEb9lcRTv3q2d4YSr5Y2ezD814QtTQEqAUw=
X-Received: by 2002:a17:90b:2dc6:b0:2fa:1e3e:9be5 with SMTP id
 98e67ed59e1d1-2fe68a2df32mr8840016a91.0.1740516149548; Tue, 25 Feb 2025
 12:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
In-Reply-To: <20250223214123.447579-2-ariel.otilibili@6wind.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 25 Feb 2025 15:39:03 -0500
X-Gm-Features: AWEUYZkkYC02ZV33iIWvYL34SaPAU71M_rCaTZ--iuT6SywrtQY6wYW7TmZVH9I
Message-ID: <CAJvnSUCTKvqKFXGKtsgb8Fu1sk5s4UYzKMGw3YF-u1fq3fGOQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d1f616062efd7edd"
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

--000000000000d1f616062efd7edd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-marvell-Functional

Putting in a recheck as I believe the fail CI reported is false.

On Sun, Feb 23, 2025 at 4:41=E2=80=AFPM Ariel Otilibili <ariel.otilibili@6w=
ind.com>
wrote:

> rte_pcapng_close() might dereference a null pointer; as example,
> PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
> rte_pcapng_close() might receive a null pointer.
>
> In that case, rte_errno is set to EINVAL. The API is updated accordingly.
>
> Link: https://pvs-studio.com/en/docs/warnings/v522/
> Link:
> https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a994=
2/app/test/test_pcapng.c#L438
> Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
> ---
>  .mailmap                | 2 +-
>  lib/pcapng/rte_pcapng.c | 3 +++
>  lib/pcapng/rte_pcapng.h | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index a03d3cfb591b..ea68d6180ccc 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -135,7 +135,7 @@ Anupam Kapoor <anupam.kapoor@gmail.com>
>  Apeksha Gupta <apeksha.gupta@nxp.com>
>  Archana Muniganti <marchana@marvell.com> <
> muniganti.archana@caviumnetworks.com>
>  Archit Pandey <architpandeynitk@gmail.com>
> -Ariel Otilibili <otilibil@eurecom.fr> <ariel.otilibili@6wind.com>
> +Ariel Otilibili <ariel.otilibili@6wind.com> <otilibil@eurecom.fr>
>  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>  Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
>  Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index 16485b27cb46..d2cbcea42885 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -716,6 +716,9 @@ rte_pcapng_fdopen(int fd,
>  void
>  rte_pcapng_close(rte_pcapng_t *self)
>  {
> +       if (!self)
> +               rte_errno =3D EINVAL;
> +
>         close(self->outfd);
>         free(self);
>  }
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b5756430..f7b976987320 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -60,6 +60,8 @@ rte_pcapng_fdopen(int fd,
>   *
>   * @param self
>   *  handle to library
> +
> + * If self is NULL, rte_errno is set to EINVAL.
>   */
>  void
>  rte_pcapng_close(rte_pcapng_t *self);
> --
> 2.30.2
>
>

--000000000000d1f616062efd7edd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request: iol-marvell-Functional<div><br></div><div=
>Putting in a recheck as I believe the fail CI reported is false.</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sun, Feb 23, 2025 at 4:41=E2=80=AFPM Ariel Otilibili &=
lt;<a href=3D"mailto:ariel.otilibili@6wind.com">ariel.otilibili@6wind.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">rt=
e_pcapng_close() might dereference a null pointer; as example,<br>
PVS-Studio gives its usage in test_pcapng.c: indeed, that call to<br>
rte_pcapng_close() might receive a null pointer.<br>
<br>
In that case, rte_errno is set to EINVAL. The API is updated accordingly.<b=
r>
<br>
Link: <a href=3D"https://pvs-studio.com/en/docs/warnings/v522/" rel=3D"nore=
ferrer" target=3D"_blank">https://pvs-studio.com/en/docs/warnings/v522/</a>=
<br>
Link: <a href=3D"https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb8=
75c81f95bf3a9942/app/test/test_pcapng.c#L438" rel=3D"noreferrer" target=3D"=
_blank">https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95b=
f3a9942/app/test/test_pcapng.c#L438</a><br>
Fixes: 8d23ce8f5ee9 (&quot;pcapng: add new library for writing pcapng files=
&quot;)<br>
Signed-off-by: Ariel Otilibili &lt;<a href=3D"mailto:ariel.otilibili@6wind.=
com" target=3D"_blank">ariel.otilibili@6wind.com</a>&gt;<br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +=
-<br>
=C2=A0lib/pcapng/rte_pcapng.c | 3 +++<br>
=C2=A0lib/pcapng/rte_pcapng.h | 2 ++<br>
=C2=A03 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index a03d3cfb591b..ea68d6180ccc 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -135,7 +135,7 @@ Anupam Kapoor &lt;<a href=3D"mailto:anupam.kapoor@gmail=
.com" target=3D"_blank">anupam.kapoor@gmail.com</a>&gt;<br>
=C2=A0Apeksha Gupta &lt;<a href=3D"mailto:apeksha.gupta@nxp.com" target=3D"=
_blank">apeksha.gupta@nxp.com</a>&gt;<br>
=C2=A0Archana Muniganti &lt;<a href=3D"mailto:marchana@marvell.com" target=
=3D"_blank">marchana@marvell.com</a>&gt; &lt;<a href=3D"mailto:muniganti.ar=
chana@caviumnetworks.com" target=3D"_blank">muniganti.archana@caviumnetwork=
s.com</a>&gt;<br>
=C2=A0Archit Pandey &lt;<a href=3D"mailto:architpandeynitk@gmail.com" targe=
t=3D"_blank">architpandeynitk@gmail.com</a>&gt;<br>
-Ariel Otilibili &lt;<a href=3D"mailto:otilibil@eurecom.fr" target=3D"_blan=
k">otilibil@eurecom.fr</a>&gt; &lt;<a href=3D"mailto:ariel.otilibili@6wind.=
com" target=3D"_blank">ariel.otilibili@6wind.com</a>&gt;<br>
+Ariel Otilibili &lt;<a href=3D"mailto:ariel.otilibili@6wind.com" target=3D=
"_blank">ariel.otilibili@6wind.com</a>&gt; &lt;<a href=3D"mailto:otilibil@e=
urecom.fr" target=3D"_blank">otilibil@eurecom.fr</a>&gt;<br>
=C2=A0Arkadiusz Kubalewski &lt;<a href=3D"mailto:arkadiusz.kubalewski@intel=
.com" target=3D"_blank">arkadiusz.kubalewski@intel.com</a>&gt;<br>
=C2=A0Arkadiusz Kusztal &lt;<a href=3D"mailto:arkadiuszx.kusztal@intel.com"=
 target=3D"_blank">arkadiuszx.kusztal@intel.com</a>&gt;<br>
=C2=A0Arnaud Fiorini &lt;<a href=3D"mailto:arnaud.fiorini@polymtl.ca" targe=
t=3D"_blank">arnaud.fiorini@polymtl.ca</a>&gt;<br>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c<br>
index 16485b27cb46..d2cbcea42885 100644<br>
--- a/lib/pcapng/rte_pcapng.c<br>
+++ b/lib/pcapng/rte_pcapng.c<br>
@@ -716,6 +716,9 @@ rte_pcapng_fdopen(int fd,<br>
=C2=A0void<br>
=C2=A0rte_pcapng_close(rte_pcapng_t *self)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!self)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_errno =3D EINVA=
L;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(self-&gt;outfd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(self);<br>
=C2=A0}<br>
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h<br>
index 48f2b5756430..f7b976987320 100644<br>
--- a/lib/pcapng/rte_pcapng.h<br>
+++ b/lib/pcapng/rte_pcapng.h<br>
@@ -60,6 +60,8 @@ rte_pcapng_fdopen(int fd,<br>
=C2=A0 *<br>
=C2=A0 * @param self<br>
=C2=A0 *=C2=A0 handle to library<br>
+<br>
+ * If self is NULL, rte_errno is set to EINVAL.<br>
=C2=A0 */<br>
=C2=A0void<br>
=C2=A0rte_pcapng_close(rte_pcapng_t *self);<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--000000000000d1f616062efd7edd--
