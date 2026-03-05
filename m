Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B328F3092C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E94614029D;
	Thu,  5 Mar 2026 14:21:07 +0100 (CET)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by mails.dpdk.org (Postfix) with ESMTP id 468904027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:21:06 +0100 (CET)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56adf76631cso1093010e0c.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:21:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772716865; cv=none;
 d=google.com; s=arc-20240605;
 b=NFIoRIpEq2lKOxsG/qVm+6sMCsdoWA4EAf9ecWkUOPqvzy0Ojjmdq9zTAwxBK7MUIX
 cWymrpwLE0xI+Z6RVSXGpN1HEgrl3ABurjEaVOyR1lsuJiuTgO4YoVp5r+NNuCsLXtyd
 0tMWIc4Ie8MsG0PiufhHVhkC8ZUXW7roNYlNlL69xGM0SpcT1CEh2H6zFk4rAspVlmSM
 LUO/ljmoDHAVjxwm6JaKwAxbTUq23NDQioP2D7DtQd3gA2UFgEVdyGA8NmrGk8s7DG76
 drcc2kpvtITDfKbee4dRqbz8AaEXVRinW4Q2dnngnMN7pbuIFsicLn1Ao2YTdRb9jrdl
 KRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZIAsOZExUQHabl8YRT65hKabbH/6FS5r8+566zbwTX0=;
 fh=J3a7HCx1EIriacs9f118WfqyUFUJ3b457GJ+ffmA5DM=;
 b=eyWRWjpyn/8kZidlfARyCB9ej/VInh6KBdUkIxnO/k5pngpkcm5xf2oMTfLLEGffi7
 TS/6wWvjbJ80gkDsfcyxsOxh+qDvZgkD1TyO7USU8Bn0czaagyE6gjOXhXsHXeTQO9jB
 1RmMdrYRuPegJMkP4Tli5XkfWvHqzeA/9lELjC761I/4VLcnCwltPvwKYiytJ/nzP9Dx
 1439nEVus4ySqe3iRP6EhP8vJnRdpNCIQjI59U//esDcMSerMR26uIgaHwNloWFLJpPD
 Yq/1daMjgsqErJDjKI+Gkttl6Wf/+8BH3Xoe/xk0SBeuxn6fJBJSR8DihavMeeljvgrs
 aLYQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772716865; x=1773321665; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIAsOZExUQHabl8YRT65hKabbH/6FS5r8+566zbwTX0=;
 b=Nos4Z7EW4kbBgsBwV1UfDZeh2nr1xPSe9NIKonO/6YrVy/sEM2O6xbwMZbXjOtFNZz
 FR9hyRzN6hZ1LggtJVDTZShDLSQZiaeqJjf+BPt+9zet1iWtWiJexiYZXhXuqgF0Ztss
 4Bxpe+QaJ0ZYLU7cChHo1Rtg5iC3uoxPdtUi9oBib5ojv6fKSUUYdQtVGmy6kMNxXLMa
 w+MlzDN/w19ug6UEB49/aWTXnAkW0bOn867PD1InsJfUjX4rBYNHihxoPcUk2UUwBD16
 mKB1Wq8zpBT/CFfEqCxrKIOj0zBbrCAeb7irn7B8s+HoHYWFRUklZyrfU/yg4dX7X+1M
 ZdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772716865; x=1773321665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIAsOZExUQHabl8YRT65hKabbH/6FS5r8+566zbwTX0=;
 b=K80gVvMOgvAstY/dc77/kEMwoGzQUC2PXfGb1Xv2ZjZftK6342oAkBru77M8QLeQRQ
 BYWN/3VYNuvPGlzVU96xxapQ+VqkAYfozjDvJf3i+Ey0A6hpLVWEVPf4CdvTMq/hUC96
 9Fc3n+QuwVTu+f/ZscOUoGsRir9n39ptCqHizUmHckMuXbvdv7+7r9i2ou+zCgMU/yRV
 3lByWs5ExH04J74V32zHaduk9wJ9mfigyFJdvIAzeia90jzL5kZSlmOFCGMLddbOmdCf
 ETPSNv1nwGfqi+pkwRR7UoZSDiduEsaIlxdRiDkUfFNgauvKUsRbOJDEC9B4FC0jGpNO
 +7VQ==
X-Gm-Message-State: AOJu0Yz3eXX0k6KrE4FIIWVoRXwDku7yXV3c6ij4dkZUGY8qRXeiMFy9
 vt5hXVwczIdJXzF8Z5v6PGYZPv1TyQH3ifctOJ4GnI/NEeQHw0p0A1Adle67pKrqAgw7YaiwfWr
 139GCBBa4CObvF4kY5aXZK6TXgxXRKAo=
X-Gm-Gg: ATEYQzzm6L10qL0/eQzmxKxfsX51BIrznkNYaKLQ10n3ga3KESPbmhLHEetYLgvLPI6
 gkc72z2xLbc8fvk5Xt8NsQBXLJmT5gOOVGQh1z52kfc3vgHME0JngwYCL22y+u1djNQsNV4A5yU
 o0PH+cUiyFzAEb/U8SEesXr9YOAn2qZnqMiDkId6opNnWDz8U1ZVJnXwSu4DbYbwRqQmCbGrJJH
 IDKu+UIxcSMOGRMARcEjP8djQszVijF5njoK1/4QDNzqHOQ7fBBj6mWz5zS3QuPOOUARvOJwfWO
 ubmd5wuqECvO2R/wrXAKBRaZpZBaZYUAMYNxtRqR8K1JV3rTpC0=
X-Received: by 2002:a05:6102:2923:b0:5ef:2457:8015 with SMTP id
 ada2fe7eead31-5ffaafc8e63mr2723337137.29.1772716865120; Thu, 05 Mar 2026
 05:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20260218101859.3028581-1-david.marchand@redhat.com>
 <CAJFAV8xoT+rV3J1JR_zy0hCQhM6cW6J50dcd1s=LBft1qrdMKA@mail.gmail.com>
In-Reply-To: <CAJFAV8xoT+rV3J1JR_zy0hCQhM6cW6J50dcd1s=LBft1qrdMKA@mail.gmail.com>
From: Ben Magistro <koncept1@gmail.com>
Date: Thu, 5 Mar 2026 08:20:54 -0500
X-Gm-Features: AaiRm52TsAWbP1Cz9004wKWywgeLB_oLATtqS2n85JV7TYyyTWn99CzTUYXS_HA
Message-ID: <CAKx8PBiSXZJDAgLvFAZ85UhRU+FK7VHpYEqJTo=bwHngMCjFoQ@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000086c21064c46cf6c"
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

--000000000000086c21064c46cf6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just now getting to cleaning up my mailing list folder and came across this
so apologize for reopening an older thread.  We will likely appreciate the
patch a great deal as we needed to switch to lld form clang (this past
week).  When we made this switch (had some size related issues with
sanitizer builds in our app with ld) lld definitely complained about the
symbols not being defined.

I don't have more of the output saved from when we found this, but did save
off these lines while discussing with the team.

ld.lld: error: version script assignment of 'DPDK_23' to symbol
'rte_eal_hpet_init' failed: symbol not defined
ld.lld: error: version script assignment of 'DPDK_23' to symbol
'rte_get_hpet_cycles' failed: symbol not defined
ld.lld: error: version script assignment of 'DPDK_23' to symbol
'rte_get_hpet_hz' failed: symbol not defined


On Thu, Mar 5, 2026 at 7:30=E2=80=AFAM David Marchand <david.marchand@redha=
t.com>
wrote:

> On Wed, 18 Feb 2026 at 11:19, David Marchand <david.marchand@redhat.com>
> wrote:
> >
> > The .map generation script has no clue about build configuration as it
> > relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in
> > a source file.
> >
> > As a consequence, Linux eal_exports.map contains references to
> > HPET symbols regardless of the use_hpet meson option value.
> >
> > $ meson configure build -Duse_hpet=3Dfalse
> > $ ninja -C build
> > ...
> > $ grep hpet build/lib/eal_exports.map
> >         rte_eal_hpet_init;
> >         rte_get_hpet_cycles;
> >         rte_get_hpet_hz;
> >
> > As far as I have seen, superfluous exports have no impact on generating
> > a shared library with the GNU linker, yet it might be different with
> > other linkers (MSVC linker would complain, for example).
> >
> > Moving those symbols to a dedicated source file solves this (non?) issu=
e.
> >
> > Fixes: 57c194d142d9 ("build: use dynamically generated version maps")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> Applied, thanks.
>
>
> --
> David Marchand
>
>

--000000000000086c21064c46cf6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just now getting to cleaning up my mailing list folder and=
 came across this so apologize for reopening an older thread.=C2=A0 We will=
 likely appreciate the patch a great deal as we needed to switch to lld for=
m clang (this past week).=C2=A0 When we made this switch (had some size rel=
ated issues with sanitizer builds in our app with ld) lld definitely compla=
ined about the symbols not being defined.<div><br></div><div>I don&#39;t ha=
ve more of the output saved from when we found this, but did save off these=
 lines while discussing with the team.</div><div><br></div><div>ld.lld: err=
or: version script assignment of &#39;DPDK_23&#39; to symbol &#39;rte_eal_h=
pet_init&#39; failed: symbol not defined<br>ld.lld: error: version script a=
ssignment of &#39;DPDK_23&#39; to symbol &#39;rte_get_hpet_cycles&#39; fail=
ed: symbol not defined<br>ld.lld: error: version script assignment of &#39;=
DPDK_23&#39; to symbol &#39;rte_get_hpet_hz&#39; failed: symbol not defined=
<br><br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 5, 2026 at 7:30=E2=80=AFAM =
David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.com">david.march=
and@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, 18 Feb 2026 at 11:19, David Marchand &lt;<a href=3D"m=
ailto:david.marchand@redhat.com" target=3D"_blank">david.marchand@redhat.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; The .map generation script has no clue about build configuration as it=
<br>
&gt; relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in=
<br>
&gt; a source file.<br>
&gt;<br>
&gt; As a consequence, Linux eal_exports.map contains references to<br>
&gt; HPET symbols regardless of the use_hpet meson option value.<br>
&gt;<br>
&gt; $ meson configure build -Duse_hpet=3Dfalse<br>
&gt; $ ninja -C build<br>
&gt; ...<br>
&gt; $ grep hpet build/lib/eal_exports.map<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_hpet_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_get_hpet_cycles;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_get_hpet_hz;<br>
&gt;<br>
&gt; As far as I have seen, superfluous exports have no impact on generatin=
g<br>
&gt; a shared library with the GNU linker, yet it might be different with<b=
r>
&gt; other linkers (MSVC linker would complain, for example).<br>
&gt;<br>
&gt; Moving those symbols to a dedicated source file solves this (non?) iss=
ue.<br>
&gt;<br>
&gt; Fixes: 57c194d142d9 (&quot;build: use dynamically generated version ma=
ps&quot;)<br>
&gt;<br>
&gt; Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand@red=
hat.com" target=3D"_blank">david.marchand@redhat.com</a>&gt;<br>
&gt; Acked-by: Chengwen Feng &lt;<a href=3D"mailto:fengchengwen@huawei.com"=
 target=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
<br>
Applied, thanks.<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000086c21064c46cf6c--
