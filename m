Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897FFCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 03:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9B340270;
	Tue, 12 Aug 2025 05:32:24 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 39AB84026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:32:23 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso61411365ad.1
 for <dev@dpdk.org>; Mon, 11 Aug 2025 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754969542; x=1755574342; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+50NKLB8QWFaXURZ2idFmLmea14BbtOZNrynHB7HauI=;
 b=YwqfBrr/jmwK1egxGh2tAXdCD/dCng7GBGDZCt4cvn/CjRoLxY8RJxwM59tLuLLEGq
 ZfE5vYqmHSfkkAwsmiFcJtX2+7g8ppO3bXfLqsLSGgap55KlJvHNc3BkF8MFuDuVEqL9
 iHSPgHzW+ehBKqsds69wetD1lHe/d4/nRgLcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754969542; x=1755574342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+50NKLB8QWFaXURZ2idFmLmea14BbtOZNrynHB7HauI=;
 b=wAYeyXAlYuAVIPYrm+Dteuh0X8jHzNM7lhQzH7Iz1ocSVuF3mezkHvey7EDw7wSp/u
 PdB/WI0e7TIQYzvQpqlcAptae2B5ltCZLzWNmPg6k1Kc0A96lgeiaQEYXbu9cHkxmeEZ
 vshQEh+AoDv2yByDai8STY0gMKPL4cPaLRBln7crXUuEYCu4kEb7hSKlJcumMxR5eY39
 ntKKqY71DAJyVLiJL8MVyDodM4GW196F160Sp76JuJ6+vqEqMTfScAlKANQVImr8w40v
 d5NMB2QHWtA0RHt1+7r/ixdZ95OJ2UVoB9ZYJA1t0JqHAy6fKorGQnot2+Tau0hwThSW
 FgMw==
X-Gm-Message-State: AOJu0YwvMQXqrDd/t8QVLHgoPZH6E48ajNn8dg1UFkqe/42MK7dcpgcS
 /sDsvS83Gww9b58AMgfbL7C9GNbifDa64vIhT9fWOmYFAe1fEo2HnS+lQ+IrZvuhviRGm8dBG9N
 Y6lO+6r9mIU4ZG2dzwWegsEPXFO1bxMyO32Z9ci/8SBULOlNJ9KTL
X-Gm-Gg: ASbGncsinrRCE5xJf8pZEhAVL2pedB48e+5BXInSPS0DfJIDCuYXcGgx3bQHEyeh/Ea
 Dmdn0TBLxb/b4Sr6sRvEP4K+J02KvJRg+vgNy6X2QTVWNOPDLvGUQ/qdnXMjJDCUDKKSKDvAcux
 QTgrFlvSkjTwwU9MvLJTLSarPyufK3dffRPeki57kvVeRbq8lketaHLqdjwOgCuZG5AioGclaGb
 GHrkMdfAllDyEoqnqG1QVg=
X-Google-Smtp-Source: AGHT+IGmggno6wadlI8hqfLV4vZFcTWuWuRj3M2MBbrhvWsSD7cNazsFJNT3Ty2gr8cDDFGWZ8cislWom2Tu62Mi9xU=
X-Received: by 2002:a17:902:fc4e:b0:240:469d:beb0 with SMTP id
 d9443c01a7336-242c21fc427mr256816975ad.31.1754969542159; Mon, 11 Aug 2025
 20:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-5-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-5-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 11 Aug 2025 23:26:01 -0400
X-Gm-Features: Ac12FXyCknwkbMFhP65fLQIeh_VwPVWKSjxWWWrKEfCm12l30ex-3wlnDVlfYQQ
Message-ID: <CAJvnSUCHuZWuGbDokC8=qfQj=OXhPcA+36LMv5zVbVN-nTr6Ug@mail.gmail.com>
Subject: Re: [PATCH 4/6] dts: add artifact module
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000270b49063c22b06b"
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

--000000000000270b49063c22b06b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

> Add a new artifact module which provides DTS with remote and local file
> management capabilities. A new Artifact class is provided which acts as
> an abstract representation of a file that is present in any node in the
> testbed model. The same provides several helper file management
> functions, including open, which returns an ArtifactFile class which
> behaves like a standard Python file object for easy interoperability.
>
> Moreover, add a novel directory tree structure for both the remote
> temporary and local output directories. This structure would represent
> the test suites and test cases in structured folders as appropriate,
> where each artifact will be stored. The location of the artifact is
> determined by the time when it was first defined. If an artifact was
> defined during a test case stage, this will be placed in the test case's
> own folder.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>
> +    def touch(self, mode: int =3D 0o644) -> None:
> +        """Touch the artifact file, creating it if it does not exist.
> +
>

Oh yeah - is there a reason why we don't call touch in the init function?
running touch should be idempotent so we aren't worried about it being
called too many times. I was reminded when I saw in the softnic testsuite
that it is being called in the testsuite setup. Maybe this is extra work on
the testsuite side for no reason.

--000000000000270b49063c22b06b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro=
@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Add a new artifact module which provides D=
TS with remote and local file<br>
management capabilities. A new Artifact class is provided which acts as<br>
an abstract representation of a file that is present in any node in the<br>
testbed model. The same provides several helper file management<br>
functions, including open, which returns an ArtifactFile class which<br>
behaves like a standard Python file object for easy interoperability.<br>
<br>
Moreover, add a novel directory tree structure for both the remote<br>
temporary and local output directories. This structure would represent<br>
the test suites and test cases in structured folders as appropriate,<br>
where each artifact will be stored. The location of the artifact is<br>
determined by the time when it was first defined. If an artifact was<br>
defined during a test case stage, this will be placed in the test case&#39;=
s<br>
own folder.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br><br>
+=C2=A0 =C2=A0 def touch(self, mode: int =3D 0o644) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Touch the artifact file, cre=
ating it if it does not exist.<br>
+<br></blockquote><div><br></div><div>Oh yeah - is there a reason why we do=
n&#39;t call touch in the init function? running touch should be idempotent=
 so we aren&#39;t worried about it being called too many times. I was remin=
ded when I saw in the softnic testsuite that it is being called in the test=
suite setup. Maybe this is extra work on the testsuite side for no reason.<=
/div><div>=C2=A0</div></div></div>

--000000000000270b49063c22b06b--
