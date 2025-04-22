Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D70C369D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07E6A402BB;
	Tue, 22 Apr 2025 17:06:39 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 9AC8E40151
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:06:37 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so4203991a91.1
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745334396; x=1745939196; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePn3tUCznXMd+TgBxkoknKYOPe4pazpoz5sbv1wuKY0=;
 b=iuEeTwPRbdAC8DA1X5BBCf2ITYFZ8ibWlbpKZ9//P6vhfsltofqfaYJ5pumTOtQ5S8
 OosJ8razLmGMzq8neRsfJ8oIsKdGrn5shnllcTfmVKpnLKcA/hMthxKXcWZXjwYBB3jI
 V7XryElBpeFykhn+GOAonm6tzVnPN8mQsxfHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745334396; x=1745939196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePn3tUCznXMd+TgBxkoknKYOPe4pazpoz5sbv1wuKY0=;
 b=o8H6bCfAqGYo381V0fs84O3vUaUXKcbwDoModQHyJQghRZ4pxwtYnT8caB+w1sEXCS
 mur6ku5UFpBBbr8Y5mzUu3TFJds5cnA3OCBtkWaRV8ZP2qjKfPZs5SXo8cbC5Q4TDKf0
 fpSrWQxL+FxCqzgzDUrhY6njbws0rP34eoQuOgC0IcstytV7+37o/lmkP0sO8wxzYsyY
 2zqHSpIbSaZSv4IKGciOdBgLxspASCYg82Zn5w+DnFoEI7GcH4BbvEYfqUNBy1WnmUVO
 KW7961kb/jilYX4RbfYVLe0Mlx/ZOaFeq/vY/MFimK8Dvj58nh7kWiwuoe3weghOV6PZ
 tPHw==
X-Gm-Message-State: AOJu0YzNd3iDXzFybx5xsAMFGadSRXRnFbCPPMB+No/ufu5trmonucNH
 KKzHCD055iXT4nrUrW5HkSC7XMLleC4/gc6w5KGCC2yP5Zdfk2CwplnOaA11jh0tI26VY6ODC50
 unfA11FThNY5oPKwjkTLdlloQLiemV3lXZnslwNcfDvCfjtJE
X-Gm-Gg: ASbGncsqYSs/DZupgbApS1mpO1xDoPdQ+s8JrXuN3+Slx95fVdQVyoixIDDM6yTwXrC
 /mbCudb5kJOrNKFPSS2WS2JynV7EJwC1bdzN8CepO3uyWngL/m4Sxllc7xTxYb2zdacCYBfFOTG
 DmEuG4iIOVORcqzmGFHOBHkLPhpMFO2+peZhZHS8i/DaSJmXsbwU0glVM=
X-Google-Smtp-Source: AGHT+IEatmwzpPLRhZWGfYDMI/6mC1mMm0d0+ekRPxtpkiMF59xiDUw6QRFx3VUckFOjGLumJcIPZKPtjExyuAAeCKU=
X-Received: by 2002:a17:90b:51c1:b0:2ff:71d2:ee8f with SMTP id
 98e67ed59e1d1-3087c361083mr23986778a91.13.1745334395992; Tue, 22 Apr 2025
 08:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvnSUDOJLGbjncEdSi_9k1+cP9N56Pp6VOkFktt3-V07d_R7Q@mail.gmail.com>
In-Reply-To: <CAJvnSUDOJLGbjncEdSi_9k1+cP9N56Pp6VOkFktt3-V07d_R7Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 22 Apr 2025 11:02:15 -0400
X-Gm-Features: ATxdqUHtZ7KNQRop3A0GWvDQptIS3t0iyigY4FwKsiSjCSxYxVQa0qerTrFqpKw
Message-ID: <CAJvnSUDMVNB-Po9pt9e+KAjHQaPXxA6cMq1jhnnFz1BFBAM1Ew@mail.gmail.com>
Subject: Re: Reschedule 4/24 DTS meeting
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000b022ec06335f5444"
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

--000000000000b022ec06335f5444
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The GB meeting has now been rescheduled, meaning that we can reclaim our
timeslot. Moving the DTS meeting on Thursday back to 13:00 UTC. Thanks.

On Mon, Apr 21, 2025 at 2:24=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Hello,
>
> There is a conflict between this Thursday's DPDK governing board meeting
> and the DTS meeting. So, I think we will have to push the DTS meeting bac=
k
> to 14:00 UTC.
>
> Apologies for the late notice on this.
>
> -Patrick
>

--000000000000b022ec06335f5444
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>The GB meeting has now been resc=
heduled, meaning=C2=A0that we can reclaim our timeslot. Moving the DTS meet=
ing on Thursday back to 13:00 UTC. Thanks.</div></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Apr 21, 2025 at 2:24=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:probb=
@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hello,</div><div><br=
></div><div>There is a conflict between this Thursday&#39;s DPDK governing =
board meeting and the DTS meeting. So, I think we will have to push the DTS=
 meeting back to 14:00 UTC.</div><div><br></div><div>Apologies for the late=
 notice on this.</div><div><br></div><div>-Patrick</div></div>
</blockquote></div>

--000000000000b022ec06335f5444--
