Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FACCF2C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 20:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B54894028B;
	Mon,  5 Jan 2026 21:28:07 +0100 (CET)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mails.dpdk.org (Postfix) with ESMTP id 64EE54026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 21:28:05 +0100 (CET)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-37d056f5703so2835961fa.0
 for <dev@dpdk.org>; Mon, 05 Jan 2026 12:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1767644884;
 x=1768249684; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jToZgLFX7eUGMM6AJZL2YpuoxAujbvPMeBT5g//WQQ=;
 b=ahYHRQUwIGOZpdCQ8b3wyzbWMf8LwKbZgH8Um4JDHDY2usB3kHQ6NqodOWM0s9feiI
 SHLlNLlqJENK5eKVTSoEA7Z+4/un2DNhJlF918/x2HI6k2AoWVa2h2WT9aTFvOMy/xu+
 Bccum5qS0gTEI+i2azSvMK5cFycfHbKTxFIl6ZtPA50DgoPo2dvFO46mz/sNsv00AnJo
 6VfWjbXhsTA3LCN2OASl0nFnhsdjPpCx8LGIiFUl9Q/Rspfw0c2gJx1+ysbu9/KIK6FN
 apZTzmx6Zt7WniTpSfO+R1h+mbjlBjxjnd4sxeyNXFguLBCYhb9ejdud2ZIglL+e2pET
 ZqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767644884; x=1768249684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jToZgLFX7eUGMM6AJZL2YpuoxAujbvPMeBT5g//WQQ=;
 b=sWa0QlPV3sjeHryJvom6HAtXQ/jPTKiq/ybprwa1CT6ZSKJ4g+pJLnSaXqqx8NtSbs
 gqr+oRU4c9l+e4LI3aRJzqFcrB8Ij8Pt4uSiWYPencvdKevTPtAcJZ1Jx0KshQ5lZTXZ
 Km3kVxd78XaiznGOS3urfV0WATvKdlkFSSOEg4WrGTYxJZhxBOb2xWdl6t0wiEY5UdTg
 E0Mr/0UTrTumHeKjYzih3N89AYNgs/xSQXNHdSN2p8JM4lCj8VEiimLl6BcVbLTJusyI
 7z8ZXAFcvdE6I2B65v9/nnd+J/OyS7oFaiVlJiPujE+mWVoGP0+msOa4JCAMN+XcfGKT
 mA0w==
X-Gm-Message-State: AOJu0Yw4jVl6OC/xyT5c8HyWnJ2Xfb07dVdY+38NTd2C4ueARGQCeY9l
 SOVXnTFSkX1EfWAF1qADzBRi1uIKgyVEossNdpr56dB/rnCrc79yktR0ksb3bMSEYVwi1V9oNBB
 dQQTdMqk8w/T51397jnM2f/N7+RU9jFWFWYbkVQYv+F1X2Cn3oJk9yMzONeD/NoICParITVxbR3
 Zw9exNP8I49A==
X-Gm-Gg: AY/fxX4xZH8fxnyP+qs+V9qS5YlbDWBBoYvQT+oviEObRJIq7WxQgLC3nJisAPmHnCo
 tAek5eheW8+rY0Kndl6F2pis6T3D1lU3lCEcZj7+SudqwiSDQvWe8GQi7cQT579s56wJlRsHuXg
 YzwqjPeTOcxFVEKwRZfK/FiNlldPLmoDSZ5iVl2+xad36LbvwNBpZTNP8zkDvTHiikyuBbcppqM
 Kty+NBa549YMkSUJgm7ZuvWeJmqApXs65LobSrq1Oqq0egNDMNXQWRYgzWfC0jQRNvM5UjWPsjb
 GZux+vU=
X-Google-Smtp-Source: AGHT+IHJA7nfdtQodIaJvT8MCqxzX5VX7NTtuJfzXsaubjMU6B7LC4Qezml0vq40PvI2XJ9dByXb2Lpy0bVaMaDr4fI=
X-Received: by 2002:a05:651c:41c6:b0:37f:e645:9aaa with SMTP id
 38308e7fff4ca-382eaa06343mr1406891fa.16.1767644884507; Mon, 05 Jan 2026
 12:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
 <f9a34decfa0340dbaeb62b8854567d58@huawei.com>
In-Reply-To: <f9a34decfa0340dbaeb62b8854567d58@huawei.com>
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
Date: Mon, 5 Jan 2026 23:27:28 +0300
X-Gm-Features: AQt7F2oA-XOyqraFlfFjFL3CFAo9lLLHEGbAg_6tKw4-rJU-MnCrbskSTngIWWk
Message-ID: <CAHqJCAnCbe4eGbj7GT_CKSUcagG6afAz9VaEp4ZHczAUa6H4Lw@mail.gmail.com>
Subject: Re: [PATCH] cmdline: update clear screen behavior
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000006e2b860647a9e568"
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

--0000000000006e2b860647a9e568
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:07=E2=80=AFPM Marat Khalili <marat.khalili@huawei.=
com>
wrote:
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> Tested-by: Marat Khalili <marat.khalili@huawei.com>
>
> Interestingly, currently supported combinations also miss Ctrl+U.

That can be implemented as another patch if requested.

Also existing combinations does not behave like their readline(3)
counterparts.
For example, Alt+D should kill next word but also should put it into kill
buffer to be used by Ctrl+Y.

--=20
Yasal Uyar=C4=B1:=C2=A0*Bu elektronik posta bu linki kullanarak ula=C5=9Fab=
ilece=C4=9Finiz=20
ko=C5=9Fullara tabidir:**=C2=A0**https://i2i-systems.com/email-disclaimer/=
=20
<http://i2i-systems.com/about-us/email-disclaimer/>*

--0000000000006e2b860647a9e568
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jan 5, 2026 at 6:07=E2=80=AFPM Marat Khalil=
i &lt;<a href=3D"mailto:marat.khalili@huawei.com" target=3D"_blank">marat.k=
halili@huawei.com</a>&gt; wrote:</div><div dir=3D"ltr" class=3D"gmail_attr"=
>&gt; Acked-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.co=
m" target=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>&gt; Tested-by: Ma=
rat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com" target=3D"_blan=
k">marat.khalili@huawei.com</a>&gt;<br>&gt;=C2=A0<br>&gt; Interestingly, cu=
rrently supported combinations also miss Ctrl+U.</div><div dir=3D"ltr" clas=
s=3D"gmail_attr"><br></div><div class=3D"gmail_attr">That can be implemente=
d as another patch if requested.=C2=A0</div><div class=3D"gmail_attr"><br><=
/div><div class=3D"gmail_attr">Also existing combinations does not behave l=
ike their readline(3) counterparts.=C2=A0</div><div class=3D"gmail_attr">Fo=
r example, Alt+D should kill next word but also should put it into kill buf=
fer to be used by Ctrl+Y.</div><div class=3D"gmail_attr"><br></div></div></=
div>
</div>

<br>
<div><font size=3D"1"><font color=3D"#808080"><strong style=3D"font-family:=
&quot;Times New Roman&quot;,serif"><span style=3D"font-family:&quot;Trebuch=
et MS&quot;,sans-serif">Yasal Uyar=C4=B1:=C2=A0</span></strong><b style=3D"=
font-family:Arial,Helvetica,sans-serif"><strong style=3D"font-family:&quot;=
Trebuchet MS&quot;,sans-serif">Bu elektronik posta bu linki kullanarak ula=
=C5=9Fabilece=C4=9Finiz ko=C5=9Fullara tabidir:</strong></b></font><b><span=
 style=3D"font-weight:500;color:gray;font-family:&quot;Trebuchet MS&quot;,s=
ans-serif">=C2=A0</span></b><b><font color=3D"#0066cc" face=3D"Arial, sans-=
serif"><a href=3D"http://i2i-systems.com/about-us/email-disclaimer/" target=
=3D"_blank">https://i2i-systems.c<span></span><span></span><wbr>om/email-di=
sclaimer/</a></font></b></font></div>
--0000000000006e2b860647a9e568--
