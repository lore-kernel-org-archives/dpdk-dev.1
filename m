Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30CCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 03:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1AB8402C4;
	Fri, 12 Sep 2025 05:27:22 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 40CF340299
 for <dev@dpdk.org>; Fri, 12 Sep 2025 05:27:22 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-722e079fa1aso14697526d6.3
 for <dev@dpdk.org>; Thu, 11 Sep 2025 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757647641;
 x=1758252441; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iOivS1S+YPsa4bpudo+IarsK91AddI4QGdzm8FLPr7w=;
 b=VRuGSeDQJmF4jfo9HU67h5AbgyPp9ajn/HXMofyZXKA2RjxoAsCf/0c4d2P0IB1tWr
 3B0MhrK9SVBB2lhvsOXQLEMi8qg4DTUwFmuKc2UIbgNiTr9iA9HBxtfvGVVppx1/MWfP
 zqHBF8s9xdtTjMrP8LXdLeIOCuUQIQoNx26oL2mCap8Fm6ObYXJhpIdst78E+MPvatvo
 KVFQVfs6vSczGg8VgWkNwGYk3pEIu+Euw44IH40IKX7xgntWEkGfRpSl7j+IpgDwgRQ9
 dNZXWyYPrhCVL17+dEv7+YsEr6n1Bl05mVeY6tRTVwzVstfFGUF3Zn0uzyn9xZj43Etm
 WanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757647641; x=1758252441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iOivS1S+YPsa4bpudo+IarsK91AddI4QGdzm8FLPr7w=;
 b=jsEEfUgdZZ45+/xpr5TE8PgdfgbmSeyiqg9dPT24ECcDpclAmjc80mBWuweRdVgsBT
 iA5kxUPFJo6hpuhPEa/In7FCHExREYXtCcgUNi7OZx6MLkEDqXtuUQoF2x57G3PZeJ91
 zKRdFA0oVSKoLDs6vfq19fIUDFWcQPjPqKo7vjhHMKN328y85D8XCExP0/+JSxat6NCA
 fM0qEYJDcaU3mBrwEDT03KHpSGbKsF91QucuRCiAcYK2NiYCyLhEufRT5Cjc1LPb3Y9K
 ZusPBD+4CUks/g6Xykkr0EBu3y2hA8I48UFmu54XsAG8mNAbL9f4dAJkpQ6lJSR3Q2Ad
 wPFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWUazmKrorYoCPJDVsayPhYrz9aWAZm0RdgiNoUsAqbawRskai9I1hA/XqCvCUc92vjjI=@dpdk.org
X-Gm-Message-State: AOJu0YzUk180QmWRxinY5zlULPJaHIyvVZiZtwEE+EI96ap0WuVnjZbh
 KQ+LML47nwxgQEpZzlfmUyPKQG7ag5YnORWtvOydDrRA/9jWZaxb2D68cqi01UC03ecfVPs3gAT
 DkQskevMYg2hyt9D6bffv1l0GDfow5LnS+Uld9MGH2g==
X-Gm-Gg: ASbGncv2o0GOaGQPNMJ4zGekQwjSM4veCOSBwaj00eExxlqwH8xjdHZGzVbSrBCnylg
 5QQXtVyaGYydcIfiSKHXEDpIgJSpFCoSt6ikmWki2zc1DCC2h0fZx/2VCyfcQAIpgdU5GWqbH0A
 1YWNZ92QwZmfppXjsznXnfRytpAvAYtEpqa6mN+QZKllfW7uKUMKpqkXQScfu+5TBag8HaIZKBy
 I82betDWhzJ2BCigill1dIC///lSj+pHTnTiwdjoBcCSoz9dY6lbg8mfLz/XSg0TFXa3Xk9rJme
 ELrJKiYXKmPCX1eB5N7z2zBxbCayoG/b3bi+mnhkTAtIGQ==
X-Google-Smtp-Source: AGHT+IERJUTmAcSR4zfUzDabV9tI78CBZMflcLSlOXOIbadEnTBQeVgY+tkENlpkpXDrGsjwL7BLMQgLu4kAo37111Y=
X-Received: by 2002:a05:6214:21c5:b0:70d:f50e:afe5 with SMTP id
 6a1803df08f44-767c3771b11mr20379626d6.47.1757647641447; Thu, 11 Sep 2025
 20:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911165058.31fd0101@hermes.local>
In-Reply-To: <20250911165058.31fd0101@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 12 Sep 2025 08:27:08 +0500
X-Gm-Features: AS18NWBVegnR7Zf0UIDp9-PxhXoElLgbjMHHrlWcdCKo-YdJs8d5S95G8A6ld4w
Message-ID: <CA++2-x5zZJaa_FcX8dzg13Pvmh1gSosmg-xmzAQVL2d51Yrisw@mail.gmail.com>
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000004f1d93063e923b40"
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

--0000000000004f1d93063e923b40
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Fri, Sep 12, 2025, 04:51 Stephen Hemminger <stephen@networkplumber.org>
wrote:

>
> Ok, the Windows #ifdef was confusing me then looked more closely.
> This patch is adding a set of rings so that primary and secondary
> can communicate, the adding one command.
>
> The idea is good, but there is a better way to handle this.
> There already exists a way for primary and secondary to communicate
> through the mp service. This is used for hotplug and pdump and probably
> other things as well.
>
Yeah, agree. Testpmd have also hutplug callbacks, I have tried that too,
but it is in lower layer to call any stopping fwd_engines.

>
> The communication can be either way, for example I proposed patches
> to pdump so that primary can tell secondary to participate.
>
>
> https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.12786-7-stephen@networkplumber.org/
>
> This of testpmd can be done in similar way.
> The handler in secondary should be able to act same as
> when SIGINT is received. Set the flag f_exit which will cause the main
> loop to exit.
>
> This can then happen immediately, and the proc monitor alarm function
> is only then needed to handle when primary process crashes.
>
Yeah, we can try that, my only concern is that if it can handle and stop
any numbers of secondary processes fwd_engines as the current solution can
stop.

Best regards,
Khadem

>
>
>

--0000000000004f1d93063e923b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi=C2=A0Stephen,<br><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 12, =
2025, 04:51 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.=
org">stephen@networkplumber.org</a>&gt; wrote:</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
Ok, the Windows #ifdef was confusing me then looked more closely.<br>
This patch is adding a set of rings so that primary and secondary<br>
can communicate, the adding one command.<br>
<br>
The idea is good, but there is a better way to handle this.<br>
There already exists a way for primary and secondary to communicate<br>
through the mp service. This is used for hotplug and pdump and probably<br>
other things as well.<br></blockquote></div></div><div dir=3D"auto">Yeah, a=
gree. Testpmd have also hutplug callbacks, I have tried that too, but it is=
 in lower layer to call any stopping fwd_engines.=C2=A0</div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br>
The communication can be either way, for example I proposed patches<br>
to pdump so that primary can tell secondary to participate.<br>
<br>
<a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.127=
86-7-stephen@networkplumber.org/" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.12786-7=
-stephen@networkplumber.org/</a><br>
<br>
This of testpmd can be done in similar way.<br>
The handler in secondary should be able to act same as<br>
when SIGINT is received. Set the flag f_exit which will cause the main<br>
loop to exit.<br>
<br>
This can then happen immediately, and the proc monitor alarm function<br>
is only then needed to handle when primary process crashes.<br></blockquote=
></div></div><div dir=3D"auto">Yeah, we can try that, my only concern is th=
at if it can handle and stop any numbers of secondary processes fwd_engines=
 as the current solution can stop.=C2=A0</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Best regards,</div><div dir=3D"auto">Khadem</div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><br>
<br>
</blockquote></div></div></div>

--0000000000004f1d93063e923b40--
