Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB0C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 03:16:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DB1B402CC;
	Mon, 14 Apr 2025 05:16:02 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 053FE400D7
 for <dev@dpdk.org>; Mon, 14 Apr 2025 05:16:02 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so4337481a91.2
 for <dev@dpdk.org>; Sun, 13 Apr 2025 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744600561; x=1745205361; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=urwuFExBuUIQSPRatU/MzaVmfS7dlKbrb56Q4jHVbmg=;
 b=c8XFzUpPuKubXr+3sdpPJywyqp973L4bc7UHUAr+TnQdMvav0E1e4uR9BMSrThW5CS
 gvPE7jFhUiW0M33L1Mp45bbIHlPleOavkuzxfE+wruBjfS+sBlB4NwkWu5zrTkn0BoXp
 Ho6OpVNRBK3qB7FSyCTFIk0uFta8/ETRlKrnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744600561; x=1745205361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=urwuFExBuUIQSPRatU/MzaVmfS7dlKbrb56Q4jHVbmg=;
 b=aj51DWQ283bPKvS798eFySEZUAnwdjMLrmHUZeQLiO/7nuzwdRf3t1xBvN91QX3Er4
 XaLf0xaFEZv0AU7wW8uZBVcHVB6DrzkaGe3hO8WV2CVOTUeAqdJ8Xy5HOrfgVMp3q1M6
 SLY845vslO+GqoDHbbLqyte90HhrK9GX5Gzi7nxpilRs/lPm4qxr9odolm2MHP/ycCOH
 wHOjgMVjQ1nRZOaMosUv/1Ro3PG1yihQZ7YcBQsy+gR/ZOKtrab/7GW3n277TWSssBPr
 M7Y3ZtvN4US/+PqQ/8HSmSf43FFuT+z8cFgSIvM875jzqD9k7zCw7kSJBwxPJbEIZO0W
 Z6FA==
X-Gm-Message-State: AOJu0Yz+WG6wKxj+1PZk6fKlu2lE6A1npJa1nX1YTEjUOGt8lZajKTJA
 2YI6U6u2xDLhYENVR/cUj+bbpa7YXoyhLQNZXC37d/A6Wd08D8Pv7TG8spoRD6oQ1r9WTEWhsuP
 FrpFp+vJY8FEgTKIJrFVH8u+uW+77M2qbIEpCPQ==
X-Gm-Gg: ASbGncstRU2cL2GPs9+swnamQbF/z8QQv0O6Xo8C0IOJkLBHHcwTfQ9snyVyXqQ/5dL
 +22m/6C2TuY1KW/UHPFe2xMSrPHTksq3szSfAznRnvmVoK87kTtdNIxEj3yUa85EDI2iZe5ybE+
 3bg1sNdXjj3biXhALzyA0l74YXKx9BZ5adP0SB1w==
X-Google-Smtp-Source: AGHT+IGSoCX3NvBRMYnoj2XS40dmTAxQmMK85QkCpxrDYEYskD5ceDgDTa8iKRAjaRdGePPR39rfHSThZhn7jHPvqhE=
X-Received: by 2002:a17:90b:2d87:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-3082367ef21mr15474292a91.31.1744600561163; Sun, 13 Apr 2025
 20:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240829125020.34341-1-alex.chapman@arm.com>
 <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250225153345.331216-2-thomas.wilks@arm.com>
In-Reply-To: <20250225153345.331216-2-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 13 Apr 2025 23:11:49 -0400
X-Gm-Features: ATxdqUECZu7c20aujrhr17YXwxowLgRvebmiHbPv_RMQoaueI5ItBbQWdQE_pB4
Message-ID: <CAJvnSUButQwrBjsBUzLKRbn6M_=nnVs9tROPP2pSZ3iO_K03=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dts: add RSS functions to testpmd
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Alex Chapman <alex.chapman@arm.com>
Content-Type: multipart/alternative; boundary="000000000000b9386b0632b47834"
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

--000000000000b9386b0632b47834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:34=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:

> From: Alex Chapman <alex.chapman@arm.com>
>
> This patch adds the required functionality for the RSS key_update,
> RETA, and hash test suites. This includes:
> The setting of custom RETA values for routing packets to specific
> queues.
> The setting of the RSS mode on all ports, to specify how to hash
> the packets.
> The updating of the RSS hash key used during the hashing process.
>
> Alongside this, there is the addition of a __str__ method to the
> RSSOffloadTypesFlags class, so that when flag names are cast to
> a string they will use '-' as separators, instead of '_'.
> This allows them to be directly used within testpmd RSS commands
> without any further changes.
>
> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--000000000000b9386b0632b47834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 25, 2025=
 at 10:34=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.co=
m" target=3D"_blank">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Alex Chapman &lt;<a href=3D"=
mailto:alex.chapman@arm.com" target=3D"_blank">alex.chapman@arm.com</a>&gt;=
<br>
<br>
This patch adds the required functionality for the RSS key_update,<br>
RETA, and hash test suites. This includes:<br>
The setting of custom RETA values for routing packets to specific<br>
queues.<br>
The setting of the RSS mode on all ports, to specify how to hash<br>
the packets.<br>
The updating of the RSS hash key used during the hashing process.<br>
<br>
Alongside this, there is the addition of a __str__ method to the<br>
RSSOffloadTypesFlags class, so that when flag names are cast to<br>
a string they will use &#39;-&#39; as separators, instead of &#39;_&#39;.<b=
r>
This allows them to be directly used within testpmd RSS commands<br>
without any further changes.<br>
<br>
Signed-off-by: Alex Chapman &lt;<a href=3D"mailto:alex.chapman@arm.com" tar=
get=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
Signed-off-by: Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.com" tar=
get=3D"_blank">thomas.wilks@arm.com</a>&gt;<br>
<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br><br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<=
a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">probb@iol.unh.edu</a>=
&gt;</div><div>Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.=
edu" target=3D"_blank">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>
</div>

--000000000000b9386b0632b47834--
