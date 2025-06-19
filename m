Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2642C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 12:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B032C42E71;
	Thu, 19 Jun 2025 14:45:02 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 941094025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 14:45:00 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-311c95ddfb5so498845a91.2
 for <dev@dpdk.org>; Thu, 19 Jun 2025 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750337099; x=1750941899; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GwsNQrLp0TKNOsDflh+v49gidpF0ELv6mux3StMclQM=;
 b=LDguaCMoTJNekevtyULJV12Wp20aAFXpjb4nQ4glUzO5kMezJOFAqjhOmNaH55p922
 YappFwiY83MwGVqB/I6rH+1TPKc74qzLjrWDatHf6jfwLZP76aiAlcFhnvt22jaJkzQ2
 8fU1QZ26rXaCH5SxnU1HO1M9Q/MzFAlive1YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750337099; x=1750941899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwsNQrLp0TKNOsDflh+v49gidpF0ELv6mux3StMclQM=;
 b=az0Fyi8n86eU5SqxIJpFiiZjs/3NhUiUmK2dK3HLabUNxHUg3G/BYgBEUhoqr/1hMN
 +pNOYDjq7QvugzvD0GjetTjYxjOiO/WYhL4UTRaNNPV7J88p7cbcsWDMnbDX1ON5sxYH
 o29JTcVSVXCjQBUAQMkt0jBVYCpfI/Q29vfXEPVl/iaL00IYqxm+jTttn7uBTfS75GCF
 2kFgmZ1uzYxzGg96u0SeGaFRHrkWFhtXexqa1V8GUVAnaQmaqqZk21qxhQ8UPiRPwphS
 t4mZzhk7RUZOquOpT4OryDhpk6jv0fyV8hg6ZdGY3M55GyS9px7liNsBvas+1nVzpy1D
 r7VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu+QN8SrkNxqXtn0TXYo09/05pieis6MPJGRIT2IjPlwxipO6fnJ0PIFc73Lire6RDEp0=@dpdk.org
X-Gm-Message-State: AOJu0YzMsglccssxYlDe/wDBBwJSGm0e+aVrMrx1RTqMGHy1HMtaiOjw
 T81/avPkHEJaKLxP5z7EhBt6Q7AFNjslH8oHkiwTeyZ08OintsAnYJA2gIwkpilcgzjtzMCUdQ/
 ePYDW7K+UleUyQ5yu5P5wvmXcFuPbop/i/5dSaBXTBQ==
X-Gm-Gg: ASbGncvCjTGLqPrXCLqlD5kMD7Dvdf8nwHI9l6HCijRbShMyAuoAQa1Pjd9KY2wxvTq
 Z3ie33wNrbLcg8wFg+NGo/SJkGh5Ku0EuAOoEhZnfO1F2z8/edrsMKmnPhvceURVWSEeAviwF+1
 CWsCajUfvSJ+UsO0fj2RfT9jDZ+T2uVvvh2lUPTVLA231zE9GaQiLOzJc4Fhuk2RUR2vtK36c/g
 xk=
X-Google-Smtp-Source: AGHT+IGaASe9H5GUg6FLM/v0Xa4F4nW3jFr/NRyAWdS/0eJBnS/oNmSDN+XKr6gsb2vJbjPJcLJU7wlcgASCph+nq98=
X-Received: by 2002:a17:90b:2e44:b0:313:28e7:af14 with SMTP id
 98e67ed59e1d1-313f1d5efe4mr28216454a91.19.1750337099585; Thu, 19 Jun 2025
 05:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <804d43cf-ff73-421b-a3a8-4b3dd3c3add5@arm.com>
 <20250611140530.51551-1-cfamullaconrad@suse.com>
 <4c07ffc166d99607736e0396ea01e8264406bd26.camel@suse.com>
In-Reply-To: <4c07ffc166d99607736e0396ea01e8264406bd26.camel@suse.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 19 Jun 2025 08:39:40 -0400
X-Gm-Features: AX0GCFuUFhAUWiAqNc21IXiasYhIbIWhMjzh0Di7kc_2cwo3M3L0stXoe5eT8n8
Message-ID: <CAJvnSUCyfJJTjEpRQ8B0qL0MGrsUX2FRTzwuj14oUvnh5hHi+g@mail.gmail.com>
Subject: Re: [PATCH v2] dts: fix deterministic doc
To: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
Cc: paul.szczepanek@arm.com, nd@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000efc590637ec1de7"
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

--0000000000000efc590637ec1de7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes the windows failure was unrelated to your patch - sorry about the
noise.

Looks like Paul has applied this commit to next-dts.

On Mon, Jun 16, 2025 at 4:23=E2=80=AFAM Clemens Famulla-Conrad <
cfamullaconrad@suse.com> wrote:

> > Thanks. This needs to pass the linter, see my suggestions below.
>
> Thanks for your suggestions!
>
> The CI is still failing[1] in "Windows Server 2022" =3D>
> dpdk_msvc_compile
> I don't see a relation to my change and also other patches show the
> same issue[2]. Not sure if I need to do something, do you have an
> advice?
>
> [1] http://mails.dpdk.org/archives/test-report/2025-June/885350.html
> [2] http://mails.dpdk.org/archives/test-report/2025-June/885280.html
>

--0000000000000efc590637ec1de7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes the windows failure was unrelated to your patch - sorr=
y about the noise.=C2=A0<div><br></div><div>Looks like Paul has applied thi=
s commit to next-dts.</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16, 2025 at 4:=
23=E2=80=AFAM Clemens Famulla-Conrad &lt;<a href=3D"mailto:cfamullaconrad@s=
use.com">cfamullaconrad@suse.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">&gt; Thanks. This needs to pass the linter=
, see my suggestions below.<br>
<br>
Thanks for your suggestions!<br>
<br>
The CI is still failing[1] in &quot;Windows Server 2022&quot; =3D&gt;<br>
dpdk_msvc_compile<br>
I don&#39;t see a relation to my change and also other patches show the<br>
same issue[2]. Not sure if I need to do something, do you have an<br>
advice?<br>
<br>
[1] <a href=3D"http://mails.dpdk.org/archives/test-report/2025-June/885350.=
html" rel=3D"noreferrer" target=3D"_blank">http://mails.dpdk.org/archives/t=
est-report/2025-June/885350.html</a><br>
[2] <a href=3D"http://mails.dpdk.org/archives/test-report/2025-June/885280.=
html" rel=3D"noreferrer" target=3D"_blank">http://mails.dpdk.org/archives/t=
est-report/2025-June/885280.html</a><br>
</blockquote></div>

--0000000000000efc590637ec1de7--
