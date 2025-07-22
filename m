Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC060C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62B5740658;
	Tue, 22 Jul 2025 19:04:46 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 85991402D1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:04:44 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-704c5464aecso52145946d6.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753203884;
 x=1753808684; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6nm2nKHozcyion3xY5lKUM2umgsLPFZgJYfURHy0Bg=;
 b=Y7OOYu4ThPOtA08sZfcA3i5CC3w8nRTfGjguATvV2KAbN6tovOLalAOOqwYEZXtkYn
 7k85LNKXpkoKG7cGM5eUGQjCl01TD45KL3UywdwlJZYOHypLN9oEkU0n+r2Q58oqLKBu
 Oq0xmXKZhKikogSS5MapX2XyJrV6ELKHEJyDfhCrdUbWSQAak6rTdcpOWFeEPHJWu6EB
 FwMCr2mTtW6EqU9N/tQbmJI/t8IXQ6hwdwWGrv9o8rnQEZk2va14RQO5sVwv12DHepYD
 P5IRhjyZULrdqiR6BoOk986VA3GeaNwpwuK5Q+eGbR9fWjy/0cZK0i/W1rcPinH/bsK9
 q+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753203884; x=1753808684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6nm2nKHozcyion3xY5lKUM2umgsLPFZgJYfURHy0Bg=;
 b=IOjei9ceyYSuiiYA6RmcvUI/rAjgZzSQlsFiYWZ67pJi8wRqJBfXx95S4KxzcWybMr
 j696ByARq5R6ZrL3S9VsxPaT+j6zpkFiwc96z4IZTqBBqW6cvzJf6ykwF6uB/v4W+/iy
 jwlV+HoHptHVvStsmbePsnAoj5Zod7JMNcD4WRRUHGtPMdKo8+ZfV99CINW8bFMdED6J
 kab6pTAk80BYXOiG5LDwQFg5zSL6pgMlpRrt6o5YCRmPZM2orxsaDs06gbzBDrlnC5kI
 WTCZA1QZHIRF8Uf4UByiyaoGEylWey2ZP+VSAWA+Nco47ReSobObBxvfjeTLjRW/jQDN
 ++ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlX7cOjLuWy2M8wmyF6/pT83mGMus4jqEidRAzj6F3URHV509PCgrhmRFQ94Ne3A2agZM=@dpdk.org
X-Gm-Message-State: AOJu0YzrS/jfTdnXrZW2kKxePFK+hDuFiyr+SrbAhOfA58pcm8e2jfQh
 A4w9rAXx1YmVWUy1QVJ6UEKqL4U/0N9ISx/mCUdq+UAzVaD9seckDLUu7MSRf3mZT3mddIU6xIL
 Fk5OaIJ4ljCNTiBzPCJ4jfgTc3XxpGmfY9YtvqorE1A==
X-Gm-Gg: ASbGncviqkaI5bWzo0PGqxAi6dtOi1M02TFzYw87z5V9YMVvHx6a/5sEbp82D25sNwM
 SNHkftymUUdQMxuHQVzZfakQKwZw0iKmxt4j38gRv4pohbeWVJmlmEPG+XJh8AKRQEI1tUnbRxR
 dlgD5t/zxcP7yikce//HyvscOw3I+8b0z04IWQjG5gNW2t7unGyDV6hj09QXyZJuKaNG71u2kW9
 9WEefHhu6d20ELRiA==
X-Google-Smtp-Source: AGHT+IGDDz5V+FBcnNatJm85yI5IKCZr7ai0tRPzkQhIUlyZS9igW8+6L8HuqtZ2LWJhNRpehihQCoO5r5e7kkebqIo=
X-Received: by 2002:a05:6214:194c:b0:702:d3c8:5e1e with SMTP id
 6a1803df08f44-704f66ed6c9mr298226646d6.0.1753203883624; Tue, 22 Jul 2025
 10:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 22 Jul 2025 22:04:32 +0500
X-Gm-Features: Ac12FXzjfx4-tkVa0I_LuZ8_leqxSKC6PeTUiyReXaa9HSl4_Lks2_5qmEgITy8
Message-ID: <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000b3df1d063a879670"
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

--000000000000b3df1d063a879670
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agree, but I think it's also a good practice to guard against known cases
that are prone to crashes.

On Tue, Jul 22, 2025 at 9:14=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Tue, Jul 22, 2025 at 09:01:42PM +0500, Khadem Ullah wrote:
> >    Thanks for the follow up.
> >    Understood. That makes sense. However, I=E2=80=99d like to highlight=
 that
> >    applications should ideally be robust and interactive enough to hand=
le
> >    all edge cases where a segfault or unexpected error might occur. Whi=
le
> >    clear documentation is certainly important, relying solely on it may
> >    not be sufficient. In my view, potential segfaults should be handled
> >    explicitly in code to ensure stability and to prevent silent failure=
s,
> >    especially in production environments.
> >
> In fairness, where stability is the main concern, I'd generally recommend
> avoiding multi-process entirely. Or, if it has to be used, the primary
> process should be a minimal slim one, that sets up the ports and memory a=
nd
> thereafter sleeps so that it should never crash unexpectedly!
>
> Even with that, if any secondary process dies, you'll still have all the
> buffers in use by that secondary process leaked, so for any multiprocess
> system the only safe behaviour for the system is to restart all processes
> if any process unexpectedly terminate.
>
> /Bruce
>


--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--000000000000b3df1d063a879670
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Agree, but I think it&#39;s also a good practice to guard =
against known cases that are prone to crashes.=C2=A0</div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Jul 22, 2025 at 9:14=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mail=
to:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Jul 22, 20=
25 at 09:01:42PM +0500, Khadem Ullah wrote:<br>
&gt;=C2=A0 =C2=A0 Thanks for the follow up.<br>
&gt;=C2=A0 =C2=A0 Understood. That makes sense. However, I=E2=80=99d like t=
o highlight that<br>
&gt;=C2=A0 =C2=A0 applications should ideally be robust and interactive eno=
ugh to handle<br>
&gt;=C2=A0 =C2=A0 all edge cases where a segfault or unexpected error might=
 occur. While<br>
&gt;=C2=A0 =C2=A0 clear documentation is certainly important, relying solel=
y on it may<br>
&gt;=C2=A0 =C2=A0 not be sufficient. In my view, potential segfaults should=
 be handled<br>
&gt;=C2=A0 =C2=A0 explicitly in code to ensure stability and to prevent sil=
ent failures,<br>
&gt;=C2=A0 =C2=A0 especially in production environments.<br>
&gt; <br>
In fairness, where stability is the main concern, I&#39;d generally recomme=
nd<br>
avoiding multi-process entirely. Or, if it has to be used, the primary<br>
process should be a minimal slim one, that sets up the ports and memory and=
<br>
thereafter sleeps so that it should never crash unexpectedly!<br>
<br>
Even with that, if any secondary process dies, you&#39;ll still have all th=
e<br>
buffers in use by that secondary process leaked, so for any multiprocess<br=
>
system the only safe behaviour for the system is to restart all processes<b=
r>
if any process unexpectedly terminate.<br>
<br>
/Bruce<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--000000000000b3df1d063a879670--
