Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6BCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 11:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42DE3402F1;
	Wed, 13 Aug 2025 13:38:35 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id D79374021F
 for <dev@dpdk.org>; Wed, 13 Aug 2025 13:38:33 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e812394506so602144985a.1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755085113;
 x=1755689913; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nCtj6J/Pd/RujJ6s64k9KON49AxqlkcERNc+52XvVI8=;
 b=qsr6Gh1tMP41zNRIIZ1pJVol2LS5Op03FjI3fBdtsPyMFV3BcRoUgh9exa9yONEj0W
 7IEEzavWcdXoIXEeGUbJ+ks0tZDoQ7l/sYZMJF0ZzfUFSBHjP7S2vIkk1OM/ld/wfVYd
 EcwrZb52+cNBjs8wgq95qubkAdIgTOdtEw/P1IHOSMWHhe4VD2sa5ZSjFz7M8/FPIGqh
 TWAM8sf6Irnm9v+oFlEHt9HMoemt0E8q/SExgXNU/AGutJvs+RxcKzTYwu9l1oGt+JGb
 m9l4N+c1DU78LwAWkcl2WfBGCUaqOv4I/BQY2/+UXyW73OiBLUYRzyRz8Un2ckuQQg+P
 zSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755085113; x=1755689913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCtj6J/Pd/RujJ6s64k9KON49AxqlkcERNc+52XvVI8=;
 b=cmkvD15M7VBEBN4nqpbK8y9D5q7jzlOEP2owNG7ltwUMnJo6bBEPq/uwLu/ignHhLf
 3WkHQPnSnySjLnauPfL7AkLhkTlwcSIxyiWmwBsMaCV+iZ9BwRYZC6TY8gkUdyyBl5qZ
 wxNT+YfMosE6dCxUH4FAzAxMCtLAZV8hwy/zCZoh9s2VFsFpVUos3E5+xCxBVOjMlR05
 ktxEzLJ7urO6HBWJLbnS69enGCEOzsJjgvKoZLU6WRA5HPU885DdHo1v1cUYZrALAOj/
 PDRImYysLvanLrnvOxpzxnZKW9qd3Iga5RtsdIUykcNyuL2OGOwADoYWM8ZezorG/Bai
 RZeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURe5Gj39KqACH/EeI8KNq5vegLckDsvhxX8O4Ma2B6OxttzUu4ZcC968mB7WVyEbugpP0=@dpdk.org
X-Gm-Message-State: AOJu0YzspnubnOMT76ZVGQeU1fffeOg/Z5WLNFTAdTgY+uQ4Wdt9bqRJ
 XZaeud9jv4gs12PTvIuhF1plB+2+VDouKZ/CoO9y2b8JaR7btrWO5zEFx+DAZKB4mksz6GRYxz+
 Asnvd2BdnO/NrDrG6dfMaK4QCTw1o/4KC/owXSzZyAA==
X-Gm-Gg: ASbGnctu3o2YMRQe/kwG8V6f2JTcp6ogcrOkKY7N3GQcztDdBsxAH9dJNTAnXALI8AX
 fM91hSmguhxkvDUoaCOPxXGrFHi5Wga7O6D4dNQkVhuPJMJETc/B9hoh3DMHxp3Q3D2XoU9EFt3
 akc7yiEqiY8DdsvkVkeZJpuyRtVwPPesTWk/o9CafnrN0DvEEgmi+Kt7zkWCO6rgdevu/+1QOYE
 gRy5VCO
X-Google-Smtp-Source: AGHT+IGfNr8afIPGtXlt/DN6LCmWevM/yWQPpNWdsXpN26dY5ff+IqM5Ymk6zvzmjjfXjePtX36En4D9QtJeoS1Yfno=
X-Received: by 2002:a05:620a:2905:b0:7e0:cb93:6fb1 with SMTP id
 af79cd13be357-7e865223b9cmr335084985a.9.1755085113011; Wed, 13 Aug 2025
 04:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250812094323.712559-1-dsosnowski@nvidia.com>
In-Reply-To: <20250812094323.712559-1-dsosnowski@nvidia.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 13 Aug 2025 16:38:22 +0500
X-Gm-Features: Ac12FXykqMOzSz4AEgNCbrAe3TzTbhmZ0FsJoMEsRW366Zc99Bd3DvlRPQCETSc
Message-ID: <CA++2-x7GLCyeUd_dTDjrN-S5-4dtHUw33+r_rjfU88ioXH16ZQ@mail.gmail.com>
Subject: Re: [PATCH] app/testpmd: fix conntrack action query
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b64403063c3d9890"
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

--000000000000b64403063c3d9890
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

On Tue, Aug 12, 2025 at 2:45=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

> RTE_FLOW_ACTION_TYPE_CONNTRACK handling was missing in a switch case
> which filtered action types which have action query support in testpmd.
> This prevented the conntrack query to succeed.
>
> Fixes: 4d07cbefe3ba ("app/testpmd: add commands for conntrack")
> Cc: bingz@nvidia.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---
>
>

--

--000000000000b64403063c3d9890
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Acked-by: Khadem Ullah &lt;<a href=3D"mai=
lto:14pwcse1224@uetpeshawar.edu.pk">14pwcse1224@uetpeshawar.edu.pk</a>&gt;<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Aug 12, 2025 at 2:45=E2=80=AFPM Dariusz Sosnow=
ski &lt;<a href=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">RTE_F=
LOW_ACTION_TYPE_CONNTRACK handling was missing in a switch case<br>
which filtered action types which have action query support in testpmd.<br>
This prevented the conntrack query to succeed.<br>
<br>
Fixes: 4d07cbefe3ba (&quot;app/testpmd: add commands for conntrack&quot;)<b=
r>
Cc: <a href=3D"mailto:bingz@nvidia.com" target=3D"_blank">bingz@nvidia.com<=
/a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Dariusz Sosnowski &lt;<a href=3D"mailto:dsosnowski@nvidia.co=
m" target=3D"_blank">dsosnowski@nvidia.com</a>&gt;<br>
Acked-by: Bing Zhao &lt;<a href=3D"mailto:bingz@nvidia.com" target=3D"_blan=
k">bingz@nvidia.com</a>&gt;<br>
---<br><br></blockquote></div><div><br clear=3D"all"></div><br><span class=
=3D"gmail_signature_prefix">-- </span><br></div>

--000000000000b64403063c3d9890--
