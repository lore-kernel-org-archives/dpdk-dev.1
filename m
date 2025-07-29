Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416BC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 13:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B2E84026C;
	Tue, 29 Jul 2025 15:26:40 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id EFDF7400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 15:26:39 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-31efc10bb03so1986666a91.0
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753795599; x=1754400399; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4guJCuOOI/WgPeM6SMpTTQfxXg9RXbfWRQeZucz7hpA=;
 b=Lh2yyVlP5YzS/+yMJgohaXwSjxXgGMdIXVQNEAhWJQeCn8ZnF5p6TIFMrf7uraSGFD
 Wz4lKwkIEWwdQ0PziSPlzEEKNiNY3525qE+eau2P+YgV/wOMTBal5Tx9K6qnpPC5NskB
 byOJv++kYupq+/UHuSLfFIlRy2+j3DYhPisG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753795599; x=1754400399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4guJCuOOI/WgPeM6SMpTTQfxXg9RXbfWRQeZucz7hpA=;
 b=eA40ex6gIhcKeCFRqE56YFAXY+stIQ1P3HrRhE6iaWlQR5xgYXkY+IHp4AksGaZ+iW
 dEpUiXKnLuC1jnIiwvt5+JURCCkND4IBiO8m+rTkIwSYcmdK1HI+XGu2SAXrL/bx1SIc
 OGriYAfRXpXG74IA69OVDYSqGLM8hWnTODg2zqiGyZlavkn1tvzfdegBXfBapUaNDj8K
 4RLnkDsV/NepuauIWFeAdx3mFIDM/GF3sPpL7Thr1fn2rcq1qpu8aJT1BLNuTNjzcT93
 lvgoJZf73DwjQvI916XDAeCQ6x1keXlUgN+yxR2GLqUguQdysD2goeGlpOSnTNmd2Z9z
 t5aA==
X-Gm-Message-State: AOJu0YyXPcjyj4wHNJYl7Wk+Gq3snz5a8CG2gt1mx0bOMeyzFILEUGaS
 D6QrosHYfGyUJe90NOOthWXU1oTYr3HxZcNQU8wAxICPpoPJFft5H5rgVnvH6TffJzj2VszpH56
 Zsr6juvYayW39oK+7Vn8eN+PUBAJtXtrQx8GplNdB/g==
X-Gm-Gg: ASbGncuHB3U3zxltjwB7n2LzMozjf/o38peiAcuaeMltYr04lZUeq31MEbkJhn2nRjL
 s43xvl07owl751vQb8C9c0r7Sn7WdUW44vuN1qpUknD2+X6+1/nyv1Ttte4EESbuRMC23Bwqm/K
 jh2QOy+kuivro4IIso6hRzZZYo80xVVXqyYO+W4YCEjS8wN8qasy7ofmeitN51pPKwp9ZpWyxq7
 BU60v+8FA==
X-Google-Smtp-Source: AGHT+IEbGzk/FcVBw0B/BY6NvUIdtT3CQacobTv0fSu+XNEGETfgaJbNmba0OV3+QyErN3vZn6+sXjWOyZtVEURB1x8=
X-Received: by 2002:a17:90a:e7c5:b0:312:e9bd:5d37 with SMTP id
 98e67ed59e1d1-31e77841b26mr20869727a91.6.1753795598870; Tue, 29 Jul 2025
 06:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250725200553.1262542-1-probb@iol.unh.edu>
 <20250728213209.1834486-1-probb@iol.unh.edu>
 <f80063c1-a5a9-43c5-8284-4e1b2dfc8fef@arm.com>
In-Reply-To: <f80063c1-a5a9-43c5-8284-4e1b2dfc8fef@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 29 Jul 2025 09:20:33 -0400
X-Gm-Features: Ac12FXzSEo74sikle9Y5F-hI6uAFkcKvGlIDj2X8TULIk-4rb2CnqhfiTJAcpdA
Message-ID: <CAJvnSUAmXTUH4qxHarwThXKFRE9PvbP5voXR_N1EpvfUHRpxdg@mail.gmail.com>
Subject: Re: [PATCH v2] dts: call hugepages configure at node setup
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ae2efd063b115bce"
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

--000000000000ae2efd063b115bce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

... Woops.

Will send the correction later today.

On Tue, Jul 29, 2025 at 5:50=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> Hi Patrick,
>
> thank you for the quick v2! I am afraid you may have placed the call in
> the class constructor instead of the setup method :')
>
> Luca
>

--000000000000ae2efd063b115bce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">... Woops.<div><br></div><div>Will send the correction lat=
er today.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 29, 2025 at 5:50=E2=80=AFA=
M Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@arm.com">Luca.Vizzarro@=
arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi Patrick,<br>
<br>
thank you for the quick v2! I am afraid you may have placed the call in <br=
>
the class constructor instead of the setup method :&#39;)<br>
<br>
Luca<br>
</blockquote></div>

--000000000000ae2efd063b115bce--
