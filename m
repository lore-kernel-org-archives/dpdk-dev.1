Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED1CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 13:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 127BC40156;
	Mon,  8 Sep 2025 15:28:08 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5AC9840156
 for <dev@dpdk.org>; Mon,  8 Sep 2025 15:28:06 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so3937091a12.2
 for <dev@dpdk.org>; Mon, 08 Sep 2025 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757338085; x=1757942885; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+17T9wDTG4tWQNt3S6oTVg9lvDlOSmIy6aiPHwahHlM=;
 b=Ekec/N3n8wbtbi73x6Tl/DwECAYx2Swaa2XgBoLyKpIM+h0Dg3rBg+/ofypQJ6s3EX
 1xL/cSgGzjeoqcaK9rBSMBgRIfPsRc+M08saEe6EehD0w8D6BrSKM7dw5LrOCjmHNMn8
 3Gm24WPRz5gfftn5vhLfpetaPoRSEW0V3EkPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757338085; x=1757942885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+17T9wDTG4tWQNt3S6oTVg9lvDlOSmIy6aiPHwahHlM=;
 b=WGV2EGB0fbSLUIMcWSba+NZlb4zLnOkJIFJIIJFutyuCbRt3TTHUA2jaqUroQN3E5j
 QB2fMu0NEJYPEqgNGyomXsozwNSzyA7g3998VHh9Yjr3ZpifSF6K4u7+oox7mumY1GYf
 0ivgTJfPOBdY7gh3FrpKyhRfPfK4f78dmYypNF1d1BoIIa3bDLv9+Qpm0DZTGJSole8l
 8t6SyGmqpHHJuZGl2dYKWzMIgZyAYCMAzGxue+jmqkwT0xj1fOq0lA61bF8xdxlkO3Uh
 tccVZaGAUVJ8fG7ltptoEkMkBSu/W26aey9dN46SfuPL2+VzI+yoDs38D0QxnacO5PM5
 Omig==
X-Gm-Message-State: AOJu0YxXen2NdUTnJHfpMxsl/ecOE3pE9sbrX8FyaIGVGWfDCuwIgal9
 bTabQGUV2f4vfRztCwg83SaJYAz5KnkE/rkKmMYvdkWIbYtl/2tbdy/PR0gmNTDGNfslvwBmLvE
 RQE+LZsl7fOXjqp72vkz/8ta11GBhXGrnnxBt/xHa4A==
X-Gm-Gg: ASbGncsbKyU1z+pFoA6B+tdqk8zGRW1uixWxykOcExwmEu+DrBZ/peXsyNG120FKOVG
 db3o+pzgZgTD8+Hts/8/+08EmdnZnKXYR5tJWTJsL8ZJvN4tqRqzv/w1bt+Zf4t1TjuV3SA6rzX
 Ksgtzn/0EBDmZbPPGHZPHpG3SfbPs9KEXWx4pY/9mglcuIGa5OjvI+OimoXoVJRw/MwuaD0D2gh
 1pO3Ufjxs872dzz9wx9U9SSbbE8VtYV2OmNfHI=
X-Google-Smtp-Source: AGHT+IHdXv6bJPZXd8htYomREP3M7UcBMInmz/mIJFiuDJSmQacLbEqWQBdvWMOQIWS/xMrSvwiHqPt6oO7ZKAxZyFY=
X-Received: by 2002:a17:902:db0a:b0:24e:49ea:1c6b with SMTP id
 d9443c01a7336-251751e5cbdmr120420405ad.46.1757338085293; Mon, 08 Sep 2025
 06:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250908014154.82938-1-probb@iol.unh.edu>
 <77838cba-0bf4-4764-8094-664265162081@arm.com>
In-Reply-To: <77838cba-0bf4-4764-8094-664265162081@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 8 Sep 2025 09:21:12 -0400
X-Gm-Features: Ac12FXxNlhs12b6TN6dHTXx9axt7ERKIh2qSIr_MxhTagbcEevKjeeqaIP3Tuto
Message-ID: <CAJvnSUBGaTkbtd7GanHJH9DbOsdFo-imG5joMv61bEpRH=00Xw@mail.gmail.com>
Subject: Re: [PATCH] dts: add dpdk shell warm up period
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000531a1c063e4a2828"
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

--000000000000531a1c063e4a2828
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:03=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.com=
> wrote:

> Hi Patrick,
>
> Perfectly understand the situation, I am just afraid that adding a whole
> 5 seconds every time an InteractiveShell is spawned may slow down
> everything by a lot. These are spawned a lot of times, so it will stack
> up. Is there no other way to test for readiness?
>

Yeah. I was guessing at the math before and thought it was like +25%
execution time, but now I see it's more like +90%. Definitely not ideal.

I wasn't able to come up with any other readiness checks but maybe there
is. Anyhow let's discuss all this at the Thursday meeting as it's not
urgent.


>
> Also I think we are providing the ability to run shells outside the
> context manager as well for some scenarios where it's needed, so this
> approach won't cover that case unfortunately.
>

Good point I'll take another look.


>
> Best,
> Luca
>

--000000000000531a1c063e4a2828
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 8, =
2025 at 6:03=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@a=
rm.com">Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi Patrick,<br>
<br>
Perfectly understand the situation, I am just afraid that adding a whole <b=
r>
5 seconds every time an InteractiveShell is spawned may slow down <br>
everything by a lot. These are spawned a lot of times, so it will stack <br=
>
up. Is there no other way to test for readiness?<br></blockquote><div><br><=
/div><div>Yeah. I was guessing at the math before and thought it was like=
=C2=A0+25% execution time, but now I see it&#39;s more like=C2=A0+90%. Defi=
nitely not ideal.</div><div><br></div><div>I wasn&#39;t able to come up wit=
h any other readiness checks but maybe there is. Anyhow let&#39;s discuss a=
ll this at the Thursday meeting as it&#39;s not urgent.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also I think we are providing the ability to run shells outside the <br>
context manager as well for some scenarios where it&#39;s needed, so this <=
br>
approach won&#39;t cover that case unfortunately.<br></blockquote><div><br>=
</div><div>Good point I&#39;ll take another look.</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best,<br>
Luca<br>
</blockquote></div></div>

--000000000000531a1c063e4a2828--
