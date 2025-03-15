Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066BDC28B28
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Mar 2025 21:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF6E4029E;
	Sat, 15 Mar 2025 22:28:56 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 8E64840269
 for <dev@dpdk.org>; Sat, 15 Mar 2025 22:28:55 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so1854616a91.3
 for <dev@dpdk.org>; Sat, 15 Mar 2025 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1742074135; x=1742678935; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6phbrAIcuS9xqM/Jrp7NhHXfObWn/V+kObJ9aBA7Ik0=;
 b=JIWDu9enqWu/ZiJ6piZOzGJmft9f+AI3ZezjyZkD+z3cy2vxNRzx/a9jJWsjyVFLHG
 rwIChp1Vj5FiNuWPV/MsURIYMDQFmCLG+DlscgtPCrzYH3a/XIWFjEBwV/K1CNOME3gN
 8dzSBdqjoLS2pVog5SS6j/L4YgZrg+ZqUIbPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742074135; x=1742678935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6phbrAIcuS9xqM/Jrp7NhHXfObWn/V+kObJ9aBA7Ik0=;
 b=IrIrBKxV+nVUbcY/b9+YH083laJS0FBZSpxn1zdLoUly1Icnjh/RHszo7MHX+XUyj1
 0ebnx36HieLXGoFjhzlyg+0EfXkUvZmN7vv3GuAgWObv/SaPoej21G5Nc8ygW2sF1Sqw
 I6f5wCBIMV2oQXvAUEZtvHMTrCw4Fe2K8bsP6NrHhkAqtMp1/x6GiOC0thxIWWmrgZeQ
 +uiZN9J51EX4Am58fuWCtUXJwo1nnStmk80DM/Q0lmANSd0gBycSiXJj1vVMr6zJIxJL
 M2KIXgwoauMVmNW2VruP9CJMn34oay3A+X5QGHowrSdIy/uSDy8aTi6LIQnuv1NqMni5
 0d0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOAWLjgTBxHkTcadSqrTgqdGZsp4NBgzRLiZzqIWjstiNEtSHXGKd/OFy6iTzjpt5gHPU=@dpdk.org
X-Gm-Message-State: AOJu0YwhDv7+09Ds/vIYgrAvBNnh8jNhFq47zqHkcGuCDmXVisDy8QRe
 OIuLS7H/m+Zlwe4g47I2nh53KMjdYu90Rw9ry6lYiZAef/vEzXvcHu/pyacNfb9Xrnjdo+IEn2J
 JZgBJFfx16GTFOuO7XhU8B141ENoIIx8/vlW2cg==
X-Gm-Gg: ASbGncsxmiQ0j94/pCSRUioYZFIVPhnpcuBmJIcZm5rowOrRsXCuAlo6yFNnjPzGHCh
 yluzElQb7PGDB2mcjx/nftNGQb73acRfe/eSsvaXM8Wj8qztX8PEjuyMCC0gwCz+n3L7RE38yNb
 2LJ5/LcioCUgWg9myMd/IRbI0E
X-Google-Smtp-Source: AGHT+IH9LuHW9R3GXrVFZWh8kxpxStsB+42GyAZmO1JPlksW1PS2/S4VsaDe8qk8N4GBso0yh4OYIp5mEUqGJqY6w2o=
X-Received: by 2002:a17:90b:2cd0:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-30151d8182dmr7938623a91.31.1742074134712; Sat, 15 Mar 2025
 14:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <3828431.VsPgYW4pTa@thomas>
 <CAJvnSUC+=QcAMwuxgiZpTG=LTyo7nv30QYSUbZOxBL+BwtfdSw@mail.gmail.com>
 <5232183.som1txNFv6@thomas>
In-Reply-To: <5232183.som1txNFv6@thomas>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sat, 15 Mar 2025 17:25:09 -0400
X-Gm-Features: AQ5f1JrIiX4YSVOwGEb9bWC72IniGbz3KSDvoLTr3ZU4pAi8LlwQl0HCDLoFFTE
Message-ID: <CAJvnSUD1aajcV8HbTACG8e3HmRWOQg4rxPMUATCDmprTbQaNLg@mail.gmail.com>
Subject: Re: [RFC] git: consolidate .gitignore files
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f8f71d0630683d8d"
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

--000000000000f8f71d0630683d8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:28=E2=80=AFAM Thomas Monjalon <thomas@monjalon.n=
et>
wrote:

>
> Please can you rebase next-dts on top of main?
> It will force you to make the change in the root .gitconfig
>

Thanks for the explanation this should be all set - I have rebased next-dts
and here is the updated commit:
https://git.dpdk.org/next/dpdk-next-dts/commit/?id=3D3528d203499dc4011ced10=
a314e06f2ace0a03f7

Paul I have a local backup of the old for-main if we need for any reason,
but it seems like a git edit on the commit above during the interactive
rebase is the correct way to fix this.

--000000000000f8f71d0630683d8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 14, 202=
5 at 11:28=E2=80=AFAM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon=
.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>
Please can you rebase next-dts on top of main?<br>
It will force you to make the change in the root .gitconfig<br></blockquote=
><div>=C2=A0</div><div>Thanks for the explanation this should be all set - =
I have rebased next-dts and here is the updated commit:=C2=A0<a href=3D"htt=
ps://git.dpdk.org/next/dpdk-next-dts/commit/?id=3D3528d203499dc4011ced10a31=
4e06f2ace0a03f7">https://git.dpdk.org/next/dpdk-next-dts/commit/?id=3D3528d=
203499dc4011ced10a314e06f2ace0a03f7</a></div><div><br></div><div>Paul I hav=
e a local backup of the old for-main if we need for any reason, but it seem=
s like a git edit on the commit above during the interactive rebase is the =
correct way to fix this.</div></div></div>

--000000000000f8f71d0630683d8d--
