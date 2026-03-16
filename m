Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35764F33819
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA1440611;
	Tue, 17 Mar 2026 09:40:13 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id A7C47400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:14:14 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c0c955a481so887160eec.1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674054; cv=none;
 d=google.com; s=arc-20240605;
 b=Z85NmNX3ubWjyG0bVX0V/y+Kru3I/cKevznHvgLGeqpm2LeZ1fLM8anUng2QV6HmDD
 zkpURGZsHh99zQiJLoIzGu2//rlr2Qk8C5mDuPFsqsnMkP/YryvVUkVfSbVoXh3APndt
 LdZ0TDHwSFcrAUCusNzpgBCdKC9tnwA0RxBCnQvQDQTkn/+CdpQsqIiuPoKPiQfWavGE
 6lVo7OJqCaqIxW3F1aAGpXKFEtK/J1ATdtoWz0yfR2wLGq5ORsSc51Ab8y5nEDMxNFFV
 1QOLhzcYVbdxWVOyQ/AZ0+kt3anaMoSXLFET2R/76jtttlDDi1PFMzi6MsX0ELQ7RC8a
 VzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PcacPKnYx6gJaYQD4gi8aPgUXA4eQvzSQcK7L8DdAkA=;
 fh=z6huqySSiisbIHTThxC2czaTq6fo3+gRzXgEv8VYTCs=;
 b=BqNy/vsTuNjShFdPCuf/TWGN+l21hEA6/QevSWs5km1DuZULBI3tF6MN6t3IjSY5yW
 SjRCP8XwyhAz4V/GN+gP2jhNWzjA4cnNUjI7I99EmTyNWgiVTyzERZ8IxATH+ywnD40q
 aYGa3sVnjW5WBbE9DdIVSfkD5DjwrE6wctAAUKucQbkOBuCipZftxzN4R0b551Bbhk/w
 Co5Ck6bbgN2Au82K3OejYJ9bpEOu9L+nkW8q5KunBY/C7uJz8diPge565cEr7re3F6bZ
 m+gMedq1gtXD9WAG95n3Hrzq34z8g+0g+dh4Acb0vmageylJtZJcN0M25pnGTZBGeFKk
 FEFw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773674054; x=1774278854; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PcacPKnYx6gJaYQD4gi8aPgUXA4eQvzSQcK7L8DdAkA=;
 b=M7gf5eXf52QYrYTBlHmGZ4IyZo+7apiiaYv9+pZQvNs8g6r+otynLqlm7s46QGDce2
 wPT1SXGHyU/S0jHWvAmd3EzP8Te+gfEdmWl+KqSshHujc+R1tL9xe/F36wzMHZvU7QCe
 5hkJe4yeSr8I8fTsOZaCKAMImqwOLs+OsJTusdGldygSYZZgKOsZBnPNfomr/+7CWQ9Y
 uQcSKFefCYHMAxel8HBjyuOoPkG8a+S1wI9pptpezoKa26DdMyzQUP27/n9JD7velMUY
 n9ntmnupX8hqyE1PI0YmBumisa19ZUC49B5xpwSISbiwGucWhtCv2/Hlud4fGSgsZkcn
 nstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674054; x=1774278854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcacPKnYx6gJaYQD4gi8aPgUXA4eQvzSQcK7L8DdAkA=;
 b=tI+Kd8B+RY8X/RC1Hwj2HuMB4VWmKUGSAfuhzBQDfa/M1gEeTRV19Yjh1OvfFER+TD
 1NP6ts7p5dXiYyKjUk5UMiTOdV73veKNJytSN++B87h5lyJ4Eo5tpfTm0o8sXDdKHRMv
 1FNGO5w2EP7Y3j5QAsi3Cjc6Oz7O6q1vTsdw+bbvNA3x9d/DPfs0nxp2/uHgki4UYquY
 8ZE1dnIg8JsF4P3ebDU17Kwieuv5q+8YKrRbbXPtraK+05ZEl59bZvO+Ejvpg4LvvNyb
 uzCxaSydycc7VW6iOyOq+Qy08SNvFyuoHDqali2i7rCt4Ly2Ov7waEGsMCk38DzfcYLH
 Tjvw==
X-Gm-Message-State: AOJu0YxiCZO/M/Axs3kHFvP2ifpf2E9fewAZyvr41GUguKnB0cEFeRXa
 gtg8h57CrL52WPTqf2vwrPaZamNKeFhtwYJma/0LPO/kGksGbPBYENTT9Ds0ntvFJAr1Ye3w1zo
 w6En47hRvt1ZzzR27JZfy04EOuKv5RBU=
X-Gm-Gg: ATEYQzy592SCbM3A/NeksdVnYh3VB+4yGE6iRwGKnztxwwKc98/z9EbY01+yV3xusiX
 Uu/R381qtqJqH5ozRUs/R/pAdy0ZPx174pjJuPW0Id0A0q65T+OpmINX7HTAH+9IOvf1NUkQIfR
 aD2ri3RGIgYvXTJ/tq0VGUKvnRZowzt/r+WmZap8IFlZ8lKA0VXGbzte5jhdd99PbNbgU4wZDc0
 faHRc1a62SZx7G0iJ2Xmk2EvrCvFZ5sZyQ7vPQiUisUJ3rKb3sWyKCxSNI/EmeeZRNmajBd/Mpo
 /rvzpHY=
X-Received: by 2002:a05:7300:cd91:b0:2be:833c:14a6 with SMTP id
 5a478bee46e88-2bea547bc42mr6953339eec.15.1773674053341; Mon, 16 Mar 2026
 08:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3eHOwcEg_7A1rsDFm7QuGQXd72XscEkxg0PcgkUqe8-ZVP-A@mail.gmail.com>
 <20260316085000.3492548-1-sriram.yagnaraman@ericsson.com>
In-Reply-To: <20260316085000.3492548-1-sriram.yagnaraman@ericsson.com>
From: Mike Bly <bly454@gmail.com>
Date: Mon, 16 Mar 2026 08:13:59 -0700
X-Gm-Features: AaiRm52XbY4nV8dRaAbwpaH-84Kqvbi4lwBNRYiWERr2uwwm4Yxzz6K-jNXo830
Message-ID: <CAB3eHOz3G9LvpSpcBfGmW7+9iS1T8xv_jauupoOiPW=qUS8hjA@mail.gmail.com>
Subject: Re: [PATCH v2] net/memif: Fix memif-rx buffer linking
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: dev@dpdk.org, stable@dpdk.org, jgrajcia@cisco.com
Content-Type: multipart/alternative; boundary="000000000000e59560064d25ab13"
X-Mailman-Approved-At: Tue, 17 Mar 2026 09:40:11 +0100
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

--000000000000e59560064d25ab13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sriram,

I am glad the patch worked for you. Unfortunately, I am no longer working
in this space so you will need to take the lead on getting this pulled in.

-MikeB

On Mon, Mar 16, 2026, 1:50=E2=80=AFAM Sriram Yagnaraman <
sriram.yagnaraman@ericsson.com> wrote:

> Hi Mike,
>
> Do you know the status of this patch? It looks like it hasn't received an=
y
> review since it was posted in January 2025.
>
> We've independently hit the same bug (dst_off reset per-descriptor
> instead of per-packet in the RX slow path) and your fix solves our
> issue.
>
> If this patch is stale and unlikely to be picked up, I can send a
> new patchset against the latest tree that also includes a
> boundary check for MEMIF_DESC_FLAG_NEXT when n_slots is
> exhausted.
>
> Let me know if you'd prefer to respin your series or if I should send
> a new one.
>
> Thanks,
> Sriram
>

--000000000000e59560064d25ab13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Sriram,<div dir=3D"auto"><br></div><div dir=3D"auto"=
>I am glad the patch worked for you. Unfortunately, I am no longer working =
in this space so you will need to take the lead on getting this pulled in.<=
/div><div dir=3D"auto"><br></div>-MikeB=C2=A0<br><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Ma=
r 16, 2026, 1:50=E2=80=AFAM Sriram Yagnaraman &lt;<a href=3D"mailto:sriram.=
yagnaraman@ericsson.com">sriram.yagnaraman@ericsson.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Mike,<br>
<br>
Do you know the status of this patch? It looks like it hasn&#39;t received =
any<br>
review since it was posted in January 2025.<br>
<br>
We&#39;ve independently hit the same bug (dst_off reset per-descriptor<br>
instead of per-packet in the RX slow path) and your fix solves our<br>
issue.<br>
<br>
If this patch is stale and unlikely to be picked up, I can send a<br>
new patchset against the latest tree that also includes a <br>
boundary check for MEMIF_DESC_FLAG_NEXT when n_slots is<br>
exhausted.<br>
<br>
Let me know if you&#39;d prefer to respin your series or if I should send<b=
r>
a new one.<br>
<br>
Thanks,<br>
Sriram<br>
</blockquote></div></div></div>

--000000000000e59560064d25ab13--
