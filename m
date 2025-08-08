Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452DEC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 18:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109BD40611;
	Fri,  8 Aug 2025 20:16:27 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id A25F340270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 20:16:25 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23fe9a5e5e8so17385795ad.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754676985; x=1755281785; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtJfEfjg7F6y29wH1winudHcZRXBfzoqNzx3wJGgkSU=;
 b=AjVC9p5kAslXMeunLeu7G+xZpBoIPMep0MCxrcEbNdjE+4J+Om3POqWD0hL/8X0UVN
 BZhMoOfcMLJzIwJVtGSO5fTw0P3d5Gk02NsysG3aS2zOsIFDXjaVWreW2Vuzg5/10+SJ
 ZNfTuPQM7z0rJ8qjk3TNjdGBjYTLKcVW7oi1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754676985; x=1755281785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtJfEfjg7F6y29wH1winudHcZRXBfzoqNzx3wJGgkSU=;
 b=P7SVSXSvHkYVND7NueH5ZD4t6C6O0KythgnqzLjqglxYzLTfhutxL3msq3EaNec5WA
 GKK+E9c9R1PSaJcxIG89TmE7cWuNRlacpCsgNrcRgHgS0ES8DlMbkNp8AjMHbMyot4P/
 KJLsT37b3V3bVcZyCEY21DRq5pOAQN23ntUTRu8HbfyloxTl88svduYh8X+zT5+Mdv4E
 Pm6dcYo8zkw0dcAFs7ZMjuORh1ntsqlYPKBOJKB+TmPLoOeNa4bcAhSIkSyudjQdzYFW
 cy7hKkZs7qWuBR2Fwj3vsPeIuGztsuIWkZAp34hEas9voqHO29l4uJ8tN4pn0PnyVcuQ
 CWEg==
X-Gm-Message-State: AOJu0YwPyVDubL5MTRHCv40FHGMctL3ngggPACWcQ2T08xnI43vZdkCN
 DHyuK2yeeLkwXkI67zO//EC3jj1aAxbSJyxrON11+x8E3gpBsI7XIVYZICPaGRMmgRNIjI5wght
 DlXS7Pd21LjfBmqn4ALUMfBE+0uglEolP9uZ8lK4akg==
X-Gm-Gg: ASbGncuBcLawuKjba+8Mg1o3BJ/SZW20bQA04YWmx33+apUaZz7/Ukbkyfxuzyh5CkN
 xECauDm4V7LrNz1dubTZhbLmoLY5oZS1nUp6LJnvUYq8GCUg5f0nOppVuD0RFbbYhgHfNIUBauH
 RXJufT/QlneLozjxThd9n8dld5d1TmU0LjFYQ96jQphSWmj6v+iX+2ikliQWCVYxBCJiT3IonZK
 XlRZyNyv10We0ekSSNUyg==
X-Google-Smtp-Source: AGHT+IEwQkbQl4tEyoEEd9DPVjmHNtFPy9WBNcJ8sLE0HI3xsJ4fTuIOn88ct8qmhYwrVFm5/r4GhkHwdq8nKnhrJDY=
X-Received: by 2002:a17:902:d4cd:b0:234:9cdd:ffd5 with SMTP id
 d9443c01a7336-242c206d388mr51549475ad.25.1754676984701; Fri, 08 Aug 2025
 11:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-3-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-3-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 8 Aug 2025 14:10:07 -0400
X-Gm-Features: Ac12FXxvunEyVmrXbzDcSh8Z7azVj65DIe8zmVb_lvfslIWpFttEOF64Cr-YGSg
Message-ID: <CAJvnSUDFxMWFja4DWeeWzta1r6R6m-i5z1R6EXFQ7L8fmkGHmg@mail.gmail.com>
Subject: Re: [PATCH 2/6] dts: add node retriever by identifier
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000005e81e8063bde923c"
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

--0000000000005e81e8063bde923c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:15=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

> Refactor the logic to identify nodes. Add facility to retrieve current
> nodes from context.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000005e81e8063bde923c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 11:15=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro=
@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Refactor the logic to identify nodes. Add =
facility to retrieve current<br>
nodes from context.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br><br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<=
a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></=
div></div>

--0000000000005e81e8063bde923c--
