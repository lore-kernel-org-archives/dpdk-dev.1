Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B033CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 15:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A32C540684;
	Mon, 24 Nov 2025 16:48:16 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7BD10402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 16:48:14 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so3887183b3a.1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763999293; x=1764604093; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0AT3zD6i5BAbLY0Bqj4NJg5F3OIOiZo2bZX7eo2u4xo=;
 b=J21AcrDcXCmIgn+2B/3u1xfLtYkNRDRyYUfTqlHk4VfHhFgFQPBinexsdLaN+CgNzB
 faERYYaF3ntQRKmI5UetZb4xRuYZQ0IkWU0Kw6xAQ1nTSisK58kuLxboFW84/CawEUeH
 p/PyOxmJOEsVDpffY2gkU8+L0FOpYgDoT5wVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999293; x=1764604093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AT3zD6i5BAbLY0Bqj4NJg5F3OIOiZo2bZX7eo2u4xo=;
 b=CoWzbGz4Oe4jk+/zZvPKXaru9ILqwGtpEPbMZ1368jMciZaKJBQvGtdU2JDpgznW1/
 8A+eYUngp/dIeCBo1wI/tmvF18vimEWSSC2tqzkIfACjC4wdO7J0hhGhZJm1yLhTTedT
 auYlABYTqCkLyvuVInd54+xTzs0+HdOG7UubrlYYzOET7fO0p/ne3MTV+GyezK63Jq+g
 R8yZJUSSV9YYOK9iksaDhppqaGvX58iOiboQuZb0zwfiiPjcPzcKZmbeVDBCAdD+VqRz
 PEoVe023n6B97VZ2/jo88vrWvjDTpupSwctnwglBtRrZMFILZlAwJMqAVjd4Zy4i0dyz
 ROYw==
X-Gm-Message-State: AOJu0YxfCRwK3Fe96faNUNJkQeZ0VIH3tlATbf77aIsAWTevcAuwroJ2
 za8qwHyJVaio2vU07uzsp1IqzrwBFsEtAhXJqTYfJd8ARUiNZ1Eimp1HnfV3e48WEMwxyLw3om9
 S8zlsxm8wvDpCLwjaiZxAgvhhgnV2dQ2gyBK8xT9nq0QqO6Tv1tKjHqJwAg==
X-Gm-Gg: ASbGncuMncVTpuG4hftZWr2qB8tFLHKy5zAHy9jK0aW0RkZk0pVpP/Cxs80CeMdhv+E
 /Ug5vG5nDbsC8T/zpm+pBDXtOFT83htjb9B8PJDOP534AyP97RAmsrexPnhUpQnA2X08tbNmXbO
 /U9LcYSDZQllzPOR9QZkVRN0AvFcBSVfqjksAlXljCJSsEZfAyGDBwFrTDxV5rP+B2HQXqYI694
 4M1PYFaoIUolOBNrqvoF7BDfbdTBwl/STmUzB5Veli0G7PN3j51ULxyCOBkKUs/XTm2XVEfCi0N
 MXtQwexAAyIb5P3tCOYw+7O1gv3v
X-Google-Smtp-Source: AGHT+IGRR9QKW4t69DrTLOCwqyepmKOseAX53IhBGBD4Sbc/X8tjGL4ilRqHqfXoRP5a0wxwR9+l6ZJESd6SVx8W5WI=
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id
 a92af1059eb24-11c9d870411mr7206844c88.35.1763999293518; Mon, 24 Nov 2025
 07:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121104052.1273637-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65588@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65588@smartserver.smartshare.dk>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 24 Nov 2025 10:46:48 -0500
X-Gm-Features: AWmQ_bloo8c7i9o5SYuxPtyhXT3IWF5Gbq-PGjSHYxoEbWLOxFls2LShKsEjVTw
Message-ID: <CAJvnSUAAQhzXXaVYRhO-wcSThvsLyW75FzrQrBRp4wcrfsCrwg@mail.gmail.com>
Subject: Re: [PATCH v3] eal/x86: optimize memcpy of small sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004644710644591728"
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

--0000000000004644710644591728
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. There are some DTS failures on this testbed due to misconfiguration
applied by us at UNH last week. I'm fixing it and rerunning testing which
will update the CI checks for your patchseries.

On Mon, Nov 24, 2025 at 8:36=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

> Recheck-request: Intel-compilation, iol-mellanox-Functional
>
>

--0000000000004644710644591728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi. There are some DTS failures on this testbed due t=
o misconfiguration applied by us at UNH last week. I&#39;m fixing it and re=
running testing=C2=A0which will update the=C2=A0CI checks for your patchser=
ies.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 24, 2025 at 8:36=E2=80=AFAM Mor=
ten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com">mb@smartsha=
resystems.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Recheck-request: Intel-compilation, iol-mellanox-Functional<br=
>
<br>
</blockquote></div>

--0000000000004644710644591728--
