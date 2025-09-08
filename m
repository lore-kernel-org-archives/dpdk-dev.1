Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06BECA101F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 02:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D19E040264;
	Mon,  8 Sep 2025 04:08:33 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id C9DF4400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 04:08:27 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so3420259a12.0
 for <dev@dpdk.org>; Sun, 07 Sep 2025 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757297307; x=1757902107; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DdEzwpyHE0G/f7d6Vgx8n4396uddovw0B48V1lSJtxw=;
 b=BkDCH4eKLiam8UWbnFhjL/qXyQ3WJgTF6l73i1EYjIr4WNPwi9X7hWwN0xF3Jol3dK
 kRU08KQf5nJW8KjDCCrNwP2nuz8tYEhj77e5BNjJphkLBDEdM1kcPyQd95nIEFwqxJXT
 jWaudX/8rkOq9YAa/w1X9ISVAovjOLe8i1uUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757297307; x=1757902107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdEzwpyHE0G/f7d6Vgx8n4396uddovw0B48V1lSJtxw=;
 b=FV8fhwZoxKX+93xAaGGmEMzCZIVRn2eBLpZT0ehKnSlOiBGui+mvYBIvY/tU6btYD1
 9yGNwGMy3LmZUXLF3skSwozcJo/TBR4eyd9OcgpQ1ISN7j/4dHRTKpkwbn1w1xHlNsK6
 HHnGS5b3qGhO3hS7+PkkxD1uPv5MCibi1m8isq0DD934ZhOU/0xOFl93D+bTAe6yHnVD
 ytavcmXC49+Q4LBd492FZEC8ZCGFC3jPI2d0sC9OoE32htWsj/Pjo2Y3cAAkLxPptqb3
 H4pua4t4gYQQkmAeh6RgPTagWXDb4pg1UTA6o/HXNqCFINNqKMAHKwB0OvCLcYgnAI5N
 PM1A==
X-Gm-Message-State: AOJu0YyNTGJSyH2JpnyAokqdpGhApH8sxMOouMtCtT+cR3I7O93bvPiG
 n7j9Y2FrzZi+nn6tgDw6TxdHZjYBZIi/0yvj93NB2Y/fCkCuCIsf6FK5L9ZcYiWr8TTUOni3Pb1
 rp8iWeG1mXc8Tr2QDgn64i9aWGGdVx1B4Kw6w5ElMZQ==
X-Gm-Gg: ASbGncv2g2DZK96sFbujjfKkz1y7udHxtieGXpCyYeAyjAv3G6AvLgUPAEFIwL5yetr
 SXW2hqIyV2OH05B6wKuuC94qLEc2GNZMbbrOT7QWZrJmcHk/iA+enm+GbC0+QQXL+KGd54Jzh5u
 ViNdKpheApt0dBvZw6VuY+FJdanCDKZwQVy9pxVZjyO8ziLW4SQnHg8sHCivFQP8Mfn29x4FCY2
 r85T4R9nIacrhyGurUP0jc=
X-Google-Smtp-Source: AGHT+IE3/l1ilvfRyfDRg5Z2TAS5Df+27L6y8opXPOd1JQYpOtilyKyZsoESLP9Lsl+4m1ddG+2tswj1k5W49Li7orA=
X-Received: by 2002:a17:90a:c10e:b0:32b:9765:c2a2 with SMTP id
 98e67ed59e1d1-32d4504bf19mr8612522a91.6.1757297306908; Sun, 07 Sep 2025
 19:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
 <CAJvnSUBJnkFP0RxcD1mQ9iZknGZMgHoKjAbGLFwG5QSijSpmjw@mail.gmail.com>
In-Reply-To: <CAJvnSUBJnkFP0RxcD1mQ9iZknGZMgHoKjAbGLFwG5QSijSpmjw@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 7 Sep 2025 22:01:36 -0400
X-Gm-Features: Ac12FXxt0gX6ycJFA0bHTL3fOJa3m6QrlFYtuTfC4_XC5x8dgpZTI0fT6Ab4LjE
Message-ID: <CAJvnSUBXYj+9K_mXNERgmqpgq-0dO-UwATXWx4dvsDDuLqGsPQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] dts: add file manager
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000be5270063e40a957"
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

--000000000000be5270063e40a957
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Thu, Sep 4, 2025 at 5:16=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:

> I think the changes in V2 make sense and I have tested it and I like the
> new way logs and pcaps are stored in dts/output. I will merge tomorrow to
> next-dts if there are no other comments. Thanks Luca.
>
>
>

--000000000000be5270063e40a957
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Sep 4, 2025 at 5:16=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb@iol=
.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">I think the changes in V2 make =
sense and I have tested it and I like the new way logs and pcaps are stored=
 in dts/output. I will merge tomorrow to next-dts if there are no other com=
ments. Thanks Luca.<div><br></div><div><br></div></div>
</blockquote></div>

--000000000000be5270063e40a957--
