Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956B6C982DE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:18:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4A1442E68;
	Fri, 16 Jan 2026 18:18:39 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 9751C4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:18:38 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso20521795e9.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768583918;
 x=1769188718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDJGjRJSEk8j8qqp4/wzOX0o81DRJ3Dt1MKnPAtGC+M=;
 b=y7eS0V6303LUd5XfKrGpLAmK2QF4gm3Q/smJhyzZDivO7zXpc0UJI992fLoNd5O7H3
 mw4JMtq3mB8yCCUY7yYlYiEI3RlnoFquUvDDdJgXtYWaWn677mRoZ5SelkEBPaJCW3O4
 GjwDbiFwJa/u9BMLY+0zPRqrj733hY1ffFXZE+Uw+mgc5p/DddI2Y0X2aTpOSQldtPxu
 6LcdyeOsli1hPETzgiCy/P439sCdn24tWGgegMJ3ybqpk+cV6Yi5uTNf+U43GEcl1HBU
 h16xfunoq474T5fEy8nx7FVvSR9DbneXrJzhe+8C6wOGM/jb/gq/H+7lVtsynbfOqouH
 XQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583918; x=1769188718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oDJGjRJSEk8j8qqp4/wzOX0o81DRJ3Dt1MKnPAtGC+M=;
 b=RJ8sKsMjERmyDw8OxT1dcTyPkjAR8xbSrW675bXjfyIUfRZIi++wQYysy3VbEtu+62
 MoRmEg7tSFH2OF6nrxDQ5vCb+gOrKIu/njY2fjxerh8gnTZi1zHq+f4V/Ok8Pe/En8DD
 HlHknwNDoYtMAUA+pT6Mc6WdWEe5TK98gr4EcDMz9HhHP7FmfRo4BC3Hh85IPF8TZ25S
 HYkdpiRzWHRTJXIp8xt7Pnv9/D6VzLoe9U+eel1ALAJSgGFQMweFj8Eh31fH+fxgEjBi
 AdLgEfuWiDXOx5jy27XpPAW7udWBc2U1M1aBpy6scNQQp1s1GnqgNvf3lfbGrVLTdwq0
 g4Ew==
X-Gm-Message-State: AOJu0Ywz/sFgGrMIFv8pgblOHLZdzghm11PsXU53JC8PHtOO8I53RkTQ
 yxQRCqCUYNoMVFHxXlcd9nChA0aZy/roPbY+QjtHf+G3mzSmk4ZZJ5gi2apHFC1dRJE=
X-Gm-Gg: AY/fxX4iuozy83hMpoFTyhnnoJCZnfpX6vp/TPX16lyGtEflhqFLHUIEsrFynAUAql+
 cESO4N7orU9YmbuzPy8DtEzHewXhHz0D2wEwP/LgZIUAw3hYkcNuRhiqD71sT+ya5qVKdb+dfI4
 x6q0UITqaDYxvw4QEhFhEGlMxF51n97qCwN6k5T3nXeos/6cN9PBeE4a715MZGXs5nVy45PLDcF
 irzPQwBy6LqW/xrDxxHgnNxH6YFQIPEknNP+QU+yM2kLAxfFSotlV0phLaHr4uFZJ7dFsuGkwxg
 KpI0bOHXvGl/yU/N5/702l9AU2SmeCBu1zCeE8aG/Y6wnAtIq6fRoIH3QbNLhLweUCJ/tlzn0bx
 xAI8dQHKN62sj43XFaCYL0Sg/IyT6Sk8rKDbVoqisg7f0X+p94h7caT2m6JljKNrSvJgeZ4q6WQ
 DKIaEKeUyE4eQaFpaSHRePtHHkNVze8WFX6UxDQPbgXFEjnO+VFJcB
X-Received: by 2002:a05:600c:458f:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-4801eabee40mr38173625e9.11.1768583918004; 
 Fri, 16 Jan 2026 09:18:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e886829sm52021435e9.8.2026.01.16.09.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:18:37 -0800 (PST)
Date: Fri, 16 Jan 2026 09:18:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] mbuf: fix packet copy
Message-ID: <20260116091831.37cec333@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6566E@smartserver.smartshare.dk>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260116111621.300891-1-mb@smartsharesystems.com>
 <20260116090616.52854216@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6566E@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 16 Jan 2026 18:16:15 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 16 January 2026 18.06
> >=20
> > On Fri, 16 Jan 2026 11:16:21 +0000
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > buf: fix packet copy
> > >
> > > Requests for copying the at the end of a packet incorrectly returned =
=20
> > NULL, =20
> > > as if copying past the end of a packet.
> > >
> > > When allocating the mbuf for the copy from a mempool using pinned =20
> > external =20
> > > buffers, the external flag in this mbuf was not preserved.
> > >
> > > Fixes: c3a90c381daa ("mbuf: add a copy routine")
> > >
> > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > ---
> > > v2:
> > > * Improved comment about preserving flags for newly allocated mbuf
> > >   potentially using pinned external buffer.
> > > * Added missing spaces in expression. (Stephen)
> > > ---
> > >  lib/mbuf/rte_mbuf.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> > > index 0d931c7a15..a5d16e4c97 100644
> > > --- a/lib/mbuf/rte_mbuf.c
> > > +++ b/lib/mbuf/rte_mbuf.c
> > > @@ -675,7 +675,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct=
 =20
> > rte_mempool *mp, =20
> > >  	__rte_mbuf_sanity_check(m, 1);
> > >
> > >  	/* check for request to copy at offset past end of mbuf */
> > > -	if (unlikely(off >=3D m->pkt_len))
> > > +	if (unlikely(off > m->pkt_len))
> > >  		return NULL;
> > > =20
> >=20
> > I still think asking for a copy of data that isn't there should return
> > NULL
> > not a zero length mbuf.  Kind of academic since I dont think any code
> > uses
> > non-zero offset now. =20
>=20
> Yes, I totally agree it's kind of academic.
> But I insist that it is an off-by-one bug, so I fixed it.
>=20
> Consider the function documentation:
>=20
> * @param offset
>  *   The number of bytes to skip before copying.
>  *   If the mbuf does not have that many bytes, it is an error
>  *   and NULL is returned.
>=20
> An offset resulting in copying zero bytes is not an error according to th=
is.
>=20
> Also consider the comment at the comparison in the source code:
> /* check for request to copy at offset past end of mbuf */
>=20
> It says "past the end", not "at the end"... although I'm not confident en=
ough in my English skills to determine if this means ">=3D" or ">".
>=20

OK, the documentation does match your change. Maybe there should be a test =
for that?
