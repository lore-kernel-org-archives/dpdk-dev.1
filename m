Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20838C79FBF
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 16:15:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 648B8427D7;
	Thu, 10 Sep 2026 18:15:35 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2D0EB40274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 18:15:34 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-853e2610bb4so509353b3a.0
 for <dev@dpdk.org>; Thu, 10 Sep 2026 09:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056933; cv=none;
 d=google.com; s=arc-20260327;
 b=Ya9OqdgbetBz1xTxNW8Mp8dhmbEZDvWC/XrypN9QSvtuMAKerwwWwkfGf6H/vZUMwJ
 V01cLGQ/9UktlmC6I1d82uIYFUhdvk6vI9IN48gSOGyKR1crmU6O9pfLCgmTp83tqj0G
 9VcjHt07f0HRSWCs6H89hYEf0yGVZTKRyFyyxIc3ltELmbYc/UoNVKwYqF3NlUGnAw6x
 ZBAsxV0tA8tPtIyl+o3UXORjtftK6m6Fb0J15dS4/jp65XAylnVvNWnb2FrsPUw4IZ3g
 yHMkW46SjMQWnEuCA5AH3SBhsiX7+07jqZLLuhc7wglv+/LPcdq+yQlXguLNYvhFdtDt
 S0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qj8wq8v8QV/8/6t+oVX6ZsH3GwJJwXD/geaMA4V+t8g=;
 fh=JFcgtLMwde9shxF3ms3ftBJUUMhBXAJ8L7V1FfaVWU4=;
 b=U4iTFAxtzLMc4e90uoJ2mVMeJOVBfM89n7do23M6cJrPtWNRSWAow+xmie+sEEkSlR
 zyKCImS09L/0Qi5XThxNhoaMFcq5982Sa5argZ2RcJyuL9opmpkw2DpD+uy2K4q6gbon
 uZhZmyHJ/XGiUwzh+W0NU3G0jdrlYu5c10DFgGmerqStrw/zQY4knZI1r24rFVgfxegi
 EubAtA5TRqpCERYDxniBUZxvSGtRjv2W+wWAGoQQow/Sv1kIbm1Ws9kXj8jf2kNGUHhM
 m23AhksH1Xg/u0Wlk/uF9nb5QHp/Qodl6gx0PXHim7JINc4gD4ZEeumymxYNTaDYumgT
 je3w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789056933; x=1789661733; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qj8wq8v8QV/8/6t+oVX6ZsH3GwJJwXD/geaMA4V+t8g=;
 b=Crtk26aihsNqdR3f7DemPvcR6dRA9m2PoMHXhn9GxfbfwV5t3TCVJgqc9wDZB9ddh/
 rC+n1phkNxvCA4mp7CzPIYS0pkUKK3E7eyt/oTOKHR+AqqdXjCtunkI8XldltiAEPBOi
 O8YRhck6r3A2tpAgUsa+in84bA3aMGtHDpXrkaNixJ0VvknbOfGEKdEu4sLy4MXj0ZUx
 IfbT6nVIHS5576ox2VWjSnstfyWMS7BzV5UznDwdxfYgRP8vU+9hG7c6G116CWUOXUG+
 I6QRDBmt/n4jK23oB/8AZ+eUoaajNqlthi+AEmqCHSDzYDLM9vdTLQ6KFM4RXQ2xKmyx
 RK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789056933; x=1789661733;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qj8wq8v8QV/8/6t+oVX6ZsH3GwJJwXD/geaMA4V+t8g=;
 b=hkz1SGSN/HO9r2Jpwak7YLO2i2Us40IBVJGBsmOIoVxKpvPTW8pEzpbedxw/8NiKju
 LwasnteC2jTgbg/SadCEKvO6BIz2IaX11tfAwzDiwjLlvq4o8Qmtc3p+X8V/OdfJ5jdc
 ERDrrnGwStoJPUiy+2bkeh+u0dpCxN7r1w0J7RfKbjPk4X28wFgU5Qe5mIMs9p0cTbvU
 rwGU7+GiPIEla7dDguySjSE72JTcFwsiYaktyU1PL5c4DPz4KvSwx3rTJJ3I/iPlPuR9
 abbIaj+cZQslqj3QbCcbpDvdrAOVMykqVrh6C+da63d3AqkuctnzJBWB2+1RsKlgk35h
 oCFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMpLqGLAB6IwcK4+qeUz2YtBgZr3KnPHzfgcUKIkgTUj3aSmCvP3XMc4RtzaZV92QTr0U=@dpdk.org
X-Gm-Message-State: AFuF++nmPTS5cLz9zvKDU/75KxC6C9L0YpUI5UUVgDAs2I1SYdzjxLxP
 MwGKYJi49ruaKW3PoE8Jo/Bwav/7L8rBi2Y1cpE55phHYrDNvcPEoSdpb/zUs0n+VPx3dYancLT
 oswcbzGFzHydGCKGvlLw/4IvsC2EwL5s=
X-Gm-Gg: AYBFou32IM7/5sjeAc02hMKkMSQty/LxytTFJAaV0MLvD6aXv+Zl8Oe7kRQ13OWPYEN
 ZgdTnSUOvkLM0u+em3HX3tyzk7T548u7heTO6KPs2ztmX0D6aAC8Cq/J7KxaHCpauBXzsnnsZpV
 UwusBWXP6F/CV0wPzno4k8/FA1WcoMxXsQ+iktP4ggYubpnhWZ8Z/SnWNcKdOwqK3ujsOjfx3sg
 Jw0f+F60Yo9pYwqFgTIEK4TeTMhv0hEpPs6eUIfReecP6I/oebx5sl3eTexfIDWhox4iNh/L/dg
 tS57nbmfR938gY3EyzV2kylXfyhZ1h2Mi8+qDEFlNqZ74r5qTL930e3rz5op1f3Zsu8=
X-Received: by 2002:a05:6a00:1bce:b0:853:af4d:6292 with SMTP id
 d2e1a72fcca58-869ad5b8fecmr4215558b3a.0.1789056932935; Thu, 10 Sep 2026
 09:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260910133941.77565-1-zhtfdev@gmail.com>
 <20260910085334.5dc6872a@phoenix.local>
In-Reply-To: <20260910085334.5dc6872a@phoenix.local>
From: dev zhang <zhtfdev@gmail.com>
Date: Fri, 11 Sep 2026 00:15:20 +0800
X-Gm-Features: AcwNN1Udfn_B67fjujtctciSRyAAIwNygfXf06axU52bGLRgcNUprLHDx5mEwxU
Message-ID: <CABds_aKwFV+zp1-vRS-vXZto+85dEpqQqhU1frYTPXB_s2mwyg@mail.gmail.com>
Subject: Re: [PATCH] net/txgbe: fix use-after-free in flow destroy
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f87b8f065b234697"
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

--000000000000f87b8f065b234697
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

I kept the break-then-remove pattern because destroy looks up a
single matching entry. TAILQ_FOREACH_SAFE is the right tool when the
loop must continue after removing the current node (e.g. flush).
Here the iteration should stop once the handle is found.

This file still uses <sys/queue.h>, and glibc has no
TAILQ_FOREACH_SAFE. Switching to RTE_TAILQ_FOREACH_SAFE would mix
the two until your queue macro cleanup lands.

Thanks,
Zhang Tengfei

Stephen Hemminger <stephen@networkplumber.org> =E4=BA=8E2026=E5=B9=B49=E6=
=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A

> On Thu, 10 Sep 2026 21:39:41 +0800
> Zhang Tengfei <zhtfdev@gmail.com> wrote:
>
> > TAILQ_FOREACH advances via the current node's next pointer. Removing
> > and freeing that node inside the loop reads freed memory on the next
> > iteration.
> >
> > Find the matching entry first, then remove it after the loop.
> >
> > Fixes: e342da2d438f ("net/txgbe: support destroying consistent filter")
> > Cc: stable@dpdk.org
> >
>
> OK, another option would be to use TAILQ_FOREACH_SAFE which several other
> drivers do. I have a patch series to cleanup the queue macros but waiting=
.
>

--000000000000f87b8f065b234697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the review.<br><br>I kept the break-then-remove=
 pattern because destroy looks up a<br>single matching entry. TAILQ_FOREACH=
_SAFE is the right tool when the<br>loop must continue after removing the c=
urrent node (e.g. flush).<br>Here the iteration should stop once the handle=
 is found.<br><br>This file still uses &lt;sys/queue.h&gt;, and glibc has n=
o<br>TAILQ_FOREACH_SAFE. Switching to RTE_TAILQ_FOREACH_SAFE would mix<br>t=
he two until your queue macro cleanup lands.<br><br>Thanks,<br>Zhang Tengfe=
i</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">Stephen Hemminger &lt;<a href=3D"mailto:stephen@netw=
orkplumber.org">stephen@networkplumber.org</a>&gt; =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 10 Sep 2026=
 21:39:41 +0800<br>
Zhang Tengfei &lt;<a href=3D"mailto:zhtfdev@gmail.com" target=3D"_blank">zh=
tfdev@gmail.com</a>&gt; wrote:<br>
<br>
&gt; TAILQ_FOREACH advances via the current node&#39;s next pointer. Removi=
ng<br>
&gt; and freeing that node inside the loop reads freed memory on the next<b=
r>
&gt; iteration.<br>
&gt; <br>
&gt; Find the matching entry first, then remove it after the loop.<br>
&gt; <br>
&gt; Fixes: e342da2d438f (&quot;net/txgbe: support destroying consistent fi=
lter&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.o=
rg</a><br>
&gt; <br>
<br>
OK, another option would be to use TAILQ_FOREACH_SAFE which several other<b=
r>
drivers do. I have a patch series to cleanup the queue macros but waiting.<=
br>
</blockquote></div>

--000000000000f87b8f065b234697--
