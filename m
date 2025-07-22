Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE67C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26A3D402D1;
	Tue, 22 Jul 2025 18:10:09 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8F2624003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:10:07 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b31e076f714so40139a12.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753200607; x=1753805407; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6fVR+1dzZNkZg3xfIrc+KyYmpDKisVux0xL1hxngpM=;
 b=iIqCtYi0KMT7TM5hDxxUaV81M6DHSzVUIk2uJZC7O8d7KQnw9oh3P90FfoAIpPYaYE
 gsNkstvTlgI3TjurTmDZ5H7Zlv2eT6kC1uToe+AEefC90Ki6kPnFz5uK20E8e0q4mb5j
 YHziBjOPOZKg4zHOqg2l7dI0HN+OKL9xE3kiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200607; x=1753805407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6fVR+1dzZNkZg3xfIrc+KyYmpDKisVux0xL1hxngpM=;
 b=Zz8QkwQa9AFqpo6ht//GyoYVuVM1ZY2+MBMRN2HbY75WiDwTAOnSvl/g2ISQuuQ6ba
 2KvVJvExvS6Inj4Mn20LyCYnNKTkZmql65/d7vir0S40Zexv1YXjc78LnapHY2BRFjkd
 tIJGhBQ7dq/BrMZ2f3cypehHmpqwuK/TXDOg7sWKaCSwNwS298uUHMSEvRO0c4qKvuTd
 SvzYlCRd8gw1GJSqale4zXDvSO5l8nVtLoSiUcsEeSmUMLeKHgY1aNbtpsbzCopckRIt
 b4NRtqSXVdyO1UnhNymw8A+u1UixRPhuviMfKOnwIueVI7wzWpc4t8y2uJ/4fI2+rfnV
 glsA==
X-Gm-Message-State: AOJu0YwYR9LPNv+vu/cIKm7cEHaWdgvO3SMMn0HWUeZ3kBxwBB+du9MS
 KwzIkfHvzHG9NvivRfW/coVCmdjWDJ5F1jrLDgbuAEXMnN23porMTRhQ6cOnImLs5x6znveDEyV
 LslasoUx4eFS4ru9LXDr/p2MVHZ4lUjipPTtG6QjnMQ==
X-Gm-Gg: ASbGnctwushnvKE0Lc3FeAdKssaWbV7R6LzDKKIQPAMmDI0p5YJr++9pggYlvaGHQKH
 jmtjwv2HXfEDclCSdqsf1OfWJSV4AnwbEN14N5cubgeiBWDrFqKK4QZSEdoTz7LXg+He3zL+8D1
 kP7l5UyrLOiXKaG2BtQQsrd199X+WOSP/EUPugfhdnEeLMZOE18I6ZvfQddrPqqKk8BsyXJKmtp
 L50LzPSthZ2jZmkL2CEow==
X-Google-Smtp-Source: AGHT+IG8T66x9FMsYQ9BepPYhvEOKljbasX2R1isK5D/PLlCapbfXLpKGCQgmeInWp//7VNmXFrFg6YGlVVj2WMNKNc=
X-Received: by 2002:a17:90b:1e05:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-31e3e12fa10mr5344702a91.6.1753200606447; Tue, 22 Jul 2025
 09:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250722160529.2659392-1-luca.vizzarro@arm.com>
In-Reply-To: <20250722160529.2659392-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 22 Jul 2025 12:04:06 -0400
X-Gm-Features: Ac12FXyBydBib2wwmn0M6IlbrQVCFSSN1FB9396R2jYUuHxAvxGEg-_HaYpg63A
Message-ID: <CAJvnSUDetAq7uRJaCwVf9+QrYn=rTAjxra3zPev_ieRVds33Sw@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update for DTS
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000005e29a4063a86d305"
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

--0000000000005e29a4063a86d305
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Patrick Robb <probb@iol.unh.edu>

I'm not sure whether my approval is needed or not, but for the record Luca
has been making contributions to DTS for more than a year now and is very
capable of acting as maintainer.

On Tue, Jul 22, 2025 at 12:07=E2=80=AFPM Luca Vizzarro <luca.vizzarro@arm.c=
om>
wrote:

> Paul is giving up his role of co-maintainer of DTS, electing Luca
> Vizzarro in his place.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..2098a68b1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -65,7 +65,7 @@ M: Maxime Coquelin <maxime.coquelin@redhat.com>
>  T: git://dpdk.org/next/dpdk-next-baseband
>
>  Next-dts Tree
> -M: Paul Szczepanek <paul.szczepanek@arm.com>
> +M: Luca Vizzarro <luca.vizzarro@arm.com>
>  M: Patrick Robb <probb@iol.unh.edu>
>  T: git://dpdk.org/next/dpdk-next-dts
>
> --
> 2.43.0
>
>

--0000000000005e29a4063a86d305
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh=
.edu">probb@iol.unh.edu</a>&gt;<div><br></div><div>I&#39;m not sure whether=
 my approval is needed or not, but for the record Luca has been making cont=
ributions to DTS for more than a year now and is very capable of acting as =
maintainer.</div></div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 22, 2025 at 12:07=E2=80=
=AFPM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com">luca.vizza=
rro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Paul is giving up his role of co-maintainer of DTS, electing Luc=
a<br>
Vizzarro in his place.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 0e9357f3a3..2098a68b1e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -65,7 +65,7 @@ M: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@=
redhat.com" target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br>
=C2=A0T: git://<a href=3D"http://dpdk.org/next/dpdk-next-baseband" rel=3D"n=
oreferrer" target=3D"_blank">dpdk.org/next/dpdk-next-baseband</a><br>
<br>
=C2=A0Next-dts Tree<br>
-M: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com" target=
=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
+M: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" target=3D"_b=
lank">luca.vizzarro@arm.com</a>&gt;<br>
=C2=A0M: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_b=
lank">probb@iol.unh.edu</a>&gt;<br>
=C2=A0T: git://<a href=3D"http://dpdk.org/next/dpdk-next-dts" rel=3D"norefe=
rrer" target=3D"_blank">dpdk.org/next/dpdk-next-dts</a><br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000005e29a4063a86d305--
