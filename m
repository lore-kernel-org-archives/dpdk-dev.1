Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E410F3DEC
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 16:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0925E4021F;
	Sat, 28 Mar 2026 17:38:21 +0100 (CET)
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by mails.dpdk.org (Postfix) with ESMTP id 87340400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 17:38:19 +0100 (CET)
Received: by mail-qk1-f193.google.com with SMTP id
 af79cd13be357-8cd7c372929so341408285a.0
 for <dev@dpdk.org>; Sat, 28 Mar 2026 09:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774715899; cv=none;
 d=google.com; s=arc-20240605;
 b=b8Ysy5xfgesiJy1jihFqHnzLnRR632hK6XQ5rcHhi57wudZqW3iDveJ4r6ZWHofACR
 85JsQ4BVoFncr7NGGjZuCJYJCLR3W0pf+Ne5lD+TVzO/wCUA0wu+jl5kD0Uj0lj95AfH
 qRvYp+cXDfGHQ2EkSzmTgUnZsMOM5yzuzw5aoBY8cej2z//d4RtWZtg2d6O9lRo4y9c4
 gUETHBT2aQSqq1bp2lpkXoia5gLRpRwIdkJeAsFjyJJrClqSCIJ9+uc96ywecNCTZ1P1
 2PYrNkvyVMidEFi5eOl+fvczSvJZH06xFYzek4zsMrFujp96o5ob/VWLWYB6gSZhBWV1
 c7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wHwlyRiCuIbXNlB9ZRJopO689bHK34hYYcsE3E9ksc8=;
 fh=/BOW+Lj+scqN4W3Pg1KaSCffYNfKCmyRG4LswMt9xm4=;
 b=RS0TrQUurXY3b4sK5N1ScpHN8a6qv+lO3k3Mxw0MmUJZz2b4kQhTJyP8M0boO4rLTK
 k+/3Jhms5ez6UB3UuEnrvnWMh3ytQ+uoR1kS128klUojvglvOvEhYXTyT/jazNVncUxZ
 yMqtEk0by9Jez64cyMXuQZN7lhfnTLnTBDTQMyeROsukFmvx6HKo4KEM8YqzhB0thwlY
 zjR7VYxHM1G7v7MRPTAJfB3ljF24mujVDdOc4Nsqt8R+12kwQ0d1Y5YFEbeKbgNnUBT0
 fFuetM6VpSeDuSh3NlU5h9L7u4iMeSggCl9eANijxBEhOUIZy1Xj58VnGbqZgWd/3Gy2
 jyMg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774715899; x=1775320699; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wHwlyRiCuIbXNlB9ZRJopO689bHK34hYYcsE3E9ksc8=;
 b=lPKNEcSa58mhoqnUs8zZmyz+vTj6KXlrWPI1Nl1b5bkNjO/JLeLhYIT4aJ3QB6MSeC
 xy7DhZ797XjNi6Nb80RnfMcLDnwhO6thyoeI1KNYrx2k3Y1+RVTr69cvSt36nkFOWwQt
 VpNQEKe3/+Spit8cnth40VVohHLt6INyFbz3a7zFZcZyzz0pq5OdqNDcXPN5U0v1aEcw
 akSPD8H/fZBUKNII+wi+rFFa9ccn0PO77KO7wKfjMYMMAr8Ksc+o1/0sFmch7YYzTBFu
 JffIrVAmhPR6uqhE/DR77zAVHWP1kgT2ACc/lpd5QZNqCx5wc1X8LeqWUez+ziMX+SLe
 tn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774715899; x=1775320699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHwlyRiCuIbXNlB9ZRJopO689bHK34hYYcsE3E9ksc8=;
 b=hkxnJTOH6mclhkNvRIQQ9e+UNhbAA57Q52AgSi83PIlT7OSaJZf8pzhHgVAaS3ezrs
 MIqe7nJ85scSzjpprAo3O513iBagNLsNLMMHpMM+JV8ReqRmfoIvs4Bo+KeQkTe4Pc7l
 IJjr7qlI9e6qGm4KQEPZmEERCN5dtyIsq/eHV+rTOKEkxTO9Ya/7j6wxxHOnELvKd/y4
 rF2QyCBBJBUOlD9dyFBvDvHZXfaqLsuRfIJmyAR5m6aN0XEQQI9Hwvr3DtBasaVnmApp
 mU7i0QgGnj7mEjU4VlRyMyuVpYzL5Et7li5uvllsDLQgWy41gc9lxQqPC5kXi9Rk5aHx
 NqGQ==
X-Gm-Message-State: AOJu0Yy6iyl2vmxzjmSMp8FYv64C5+JZgXQXkdMOsCsqtowy6sVTjKJD
 B1S0PqzdB9XJm3e/RhuSpxzu4CtfOdVi66n67NbQCe8oZx4O2p/GnmYitxPxFP4qd29IgWvFrR7
 2t5q6FixhhgBCwtJaXZSSDXBVEtXGeAI=
X-Gm-Gg: ATEYQzxDenVId/2Ts9g0E5cS6BzgnCKOH7sUo0w/A6Z0zHzzqL851IyvGZjbS3PDdlX
 wrjfFJbkVbqkDwe2ir4zbv2wnV7FfssCfCS6jO2pd2+v22GypZexR0ZOqQgqmz3fFCfjISvrmwm
 Qiwdf1jgWY2OmmLrWXpenlu8YBBLpJEs8c4XlZlXz1UWWJUag7fSR/Q7S+5taMsxj1an2fTCiPq
 PPK57P/9CWkS79YEtLd3vrDBZGrfbjSfm3K5JaGhbRNCN+CRt3OnzCubkBDg9VYI3RBDK4wBm6M
 izwOxg==
X-Received: by 2002:a05:6214:5092:b0:89a:125f:37d9 with SMTP id
 6a1803df08f44-89ce8ed70a8mr89474506d6.50.1774715898480; Sat, 28 Mar 2026
 09:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260310133524.28087-1-1138222970gg@gmail.com>
 <cac6e40a-6efd-4097-9b7a-90c559279879@iscas.ac.cn>
In-Reply-To: <cac6e40a-6efd-4097-9b7a-90c559279879@iscas.ac.cn>
From: shiwei dang <1138222970gg@gmail.com>
Date: Sun, 29 Mar 2026 00:38:10 +0800
X-Gm-Features: AQROBzCy0IFqKrhXO4rZU8tWRgaXG4D8JTvlsDkGvoXuka6NuixlXX3U1ptw85g
Message-ID: <CAF-WEyHKBEwYW_E6UvjKwEL7LQO4pfFS7qtv-3gjz1B7c5cNYQ@mail.gmail.com>
Subject: Re: [PATCH] eal/riscv: implement prefetch using __builtin_prefetch
To: sunyuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, stanislaw.kardach@gmail.com, stephen@networkplumber.org, 
 david.marchand@redhat.com
Content-Type: multipart/alternative; boundary="000000000000b4cac0064e183e37"
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

--000000000000b4cac0064e183e37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ,

Thanks for the review. I'll address both points (real name in Signed-off-by
and test results) together in v2 once I have access to physical RISC-V
hardware.

Best regards, Dang Shiwei

On Sat, Mar 28, 2026 at 7:48=E2=80=AFPM sunyuechi <sunyuechi@iscas.ac.cn> w=
rote:

> Hi,
>
> In the previous prefetch discussion:
>
> "Let's hope you get such hardware by the next release. We will need
> reviews too."
>
>
> https://inbox.dpdk.org/dev/CAJFAV8zatWiYQoe4kETcM61=3DOS1k=3DQaPRsNjYSYDs=
pKC+voiQw@mail.gmail.com/
>
> Could you share your test environment and results?
>
> And DPDK requires a real name in the Signed-off-by line.
>
>

--000000000000b4cac0064e183e37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi ,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Thanks for the review. I&#39;ll address bot=
h points (real name in Signed-off-by and test results) together in v2 once =
I have access to physical RISC-V hardware.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Best regards,
Dang Shiwei</p></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 28, 2026 at 7:48=E2=80=AFP=
M sunyuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn">sunyuechi@iscas.ac=
.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi,<br>
<br>
In the previous prefetch discussion:<br>
<br>
&quot;Let&#39;s hope you get such hardware by the next release. We will nee=
d <br>
reviews too.&quot;<br>
<br>
<a href=3D"https://inbox.dpdk.org/dev/CAJFAV8zatWiYQoe4kETcM61=3DOS1k=3DQaP=
RsNjYSYDspKC+voiQw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://inbox.dpdk.org/dev/CAJFAV8zatWiYQoe4kETcM61=3DOS1k=3DQaPRsNjYSYDspKC+=
voiQw@mail.gmail.com/</a><br>
<br>
Could you share your test environment and results?<br>
<br>
And DPDK requires a real name in the Signed-off-by line.<br>
<br>
</blockquote></div>

--000000000000b4cac0064e183e37--
