Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E5C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BA0040268;
	Mon, 21 Sep 2026 08:29:18 +0200 (CEST)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76]) by mails.dpdk.org (Postfix) with ESMTP id 6C6F64025A
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:29:17 +0200 (CEST)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a5d4688decso25326721fa.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 23:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789972157; cv=none;
 d=google.com; s=arc-20260327;
 b=FOLLbpsPzdlfKgteJGxCP7Q6DAEDB56NP5a8n1H2tRXHcD+28RpoQTiKsejGxh+ZvM
 z2emglffZOcwGk02EuMDfQKer70lbzTqIAoKPcF4cfUJmmfaMUUCJkkVhyCrFrbdg6yD
 vImBCGyE5kTV5P37gETHa9G7gp0R0NQNoM43fTBscS5ZNBjKWKPpKbQC6RUF/9UTxeih
 YijaXm69sJewEx57tyMWgnV4cBPsfeWwS+zEazm+zRUtu5X1Hoh8DFilQv2VkuXr8MJH
 cO92PSH3+f+co0eHtchQCN9xdyiNaUNjbwjU9eLAtidLlHERMK/L1u5XZl6BGsssAtvs
 Zi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EC01FHB4fRxW1wWtJXt/H2v9iYG4piD2htHmKTPlmII=;
 fh=vKI9sa4+vdCscZfchUNBw9BvnDt7FArn7k7OGjJBIlY=;
 b=ZPEM3AJ3JKpQ5EZdyAk99+IMcXB+r8LYUNCHkkRJkZxHsHBvTTt+zaZz/I2lHJiFWJ
 PClPjUgXur2rY9EYL0aMGgGSLIbi/SGFNexOi41LVbZ7ca63HQVdtuqG0V3GYaqGiQwV
 chzp84B6WqFzhBytyvhQ0UE0lch9yCzeGD9xpvK92ehNSlAMeC0iOufW5+nKRhNWHP1p
 Y389jEGRrZN+qs0e9AvoodmRuDURaCldanDnr/z3OS5FDSVoNq87eJeI89hd8JoDzXSn
 b/dgi+6wZ6ad/snUFEO1PvpxgOqCYeZh+IWQCmudKpLdADzv8Pjf1QEElOVEH32jDJ6U
 ALcw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789972157; x=1790576957; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EC01FHB4fRxW1wWtJXt/H2v9iYG4piD2htHmKTPlmII=;
 b=U68f0KlBmIhx/GYdYf72/5BEIV9SIMZ+a2wVry1jB6bfVfqyUFJ+jVbSCFWAFNewsE
 dwmyaqHS/dCB2cnsDldMj8nSIThoqp0qcMqerxdRK8IgmQCca8eWRc7/lIGFF5SfHMna
 4NXeHtzAbVIctrHR3SFsv0tHlYVujRPa6QMrGjGJmuXDGxgcEw3xYH8AkoFdwXjBde4P
 8kFaOsr/QQPI+mEyfbvlvfolAN6Du7EMDg/2Kd7O1bApNhhozPcuXMhlCzvUr9vMXKHt
 oqqXOgObGaNTXuDk6739aFxGH02OdlWJiMZtPfeAw98UsjHEO4OWTl9Ryb4W3vMowU9j
 opjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789972157; x=1790576957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EC01FHB4fRxW1wWtJXt/H2v9iYG4piD2htHmKTPlmII=;
 b=pM4RsN5R1wpXydtFdSXdk6E53EF+MLju6SgYs10UbCZ2raoorZcFMpkiTd7ZrreCn/
 h9scxTeiUcFlQehCTtlRzClF6X2lghiRfWSwHtXtdLvhNAanOurFrRS8IUAZqDzjFiPo
 Ut5/D4eWhBCALSHmrNbZZGdVOIsgAIRnZSl74qe0PLb2AwjV23aSeuUnpt7gIPHw0yD+
 UBwcuQQMm34wQESOZmgSCepoAaBTXS9SIqNczocy4oHDGTy3h7Ch/DfN4LEGJAWwx2Bk
 plrsLuau+DfibaCmx3WhQSCFpY38p9c/of/9NEMYNeUXvgFav81Pr6AOILgc4W4Jk0yx
 Lnlg==
X-Gm-Message-State: AFuF++mZ1hKCfEWzAgMvUI4WQ3suh20uPlKzLIN2eF4ZP6Wrvgg+86DN
 2N18lY7orfmdVaHRrjUu+xiqG6zGppjXyqNSGtu5X2x86LwEqOvYb4Qc93wLv2PczvsMVqnZl5A
 MkNWLjD43M157Qwvgv0DijBuwpmIVvIA=
X-Gm-Gg: AYBFou3sDqXfl590BodnJOuHhAltvN0obfJUkVm+I6UCbIueTHghxQr3s9qr9J4++Tz
 bShYqjppiqkX2DoYMwsg2MWpkL8P/mPtLhmKs/xZr3/9LyDwtqON4tbbro9jeA0GVET5zCy0JbD
 q8aoQxoQ9VZalCAN7K0EDw3rBC2nNN37mKDq+si7FtpClQwhzmhPGMR4gwrARaiTbgQNd+H4VLF
 yydYuOjo3Hbj5lOQ8oMcJCA8kCkq2MB1Y/kJ3GS6e8cwtLSjiNDpUKfsuaAMz//mf/Ww/v2GJda
 oet+ZMet42Gc7GJpjEIt40vQ6kVolmL4F5TqxG9cW3EOYxrYS4At6GLa3OsSi3v2
X-Received: by 2002:a2e:a550:0:b0:3a5:ffc5:dd with SMTP id
 38308e7fff4ca-3a5ffc5044fmr18865721fa.23.1789972156507; 
 Sun, 20 Sep 2026 23:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260831081800.44771-1-matveichev.dmitriy@gmail.com>
In-Reply-To: <20260831081800.44771-1-matveichev.dmitriy@gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lk=?= <matveichev.dmitriy@gmail.com>
Date: Mon, 21 Sep 2026 09:29:05 +0300
X-Gm-Features: AcwNN1VnCp56HgVx74CuoINjo0YLVUhVzWcAcuzSBA7nq_DiVD2bBYDegFJ3yio
Message-ID: <CAGa_JnC41i1w7OjhgxU1cEHMiyujodD+9vgu=bO5cQUZ6S=+vQ@mail.gmail.com>
Subject: Re: [PATCH] graph: copy nb_xstats during node clone
To: thomas@monjalon.net, kirankumark@marvell.com, erinj@marvell.com
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008bebf2065bf85eb9"
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

--0000000000008bebf2065bf85eb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Thomas, my patch was delegated to you. Did you have a chance to look at it?
Or maybe it just got lost?

=D0=BF=D0=BD, 31 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 11:18, Dmi=
triy Matveichev <
matveichev.dmitriy@gmail.com>:

> Signed-off-by: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
> ---
>  lib/graph/node.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/graph/node.c b/lib/graph/node.c
> index 1fce3e6632..bb39c616de 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)
>                         goto free;
>                 }
>
> +               reg->xstats->nb_xstats =3D node->xstats->nb_xstats;
>                 for (i =3D 0; i < node->xstats->nb_xstats; i++)
>                         if (rte_strscpy(reg->xstats->xstat_desc[i],
> node->xstats->xstat_desc[i],
>                                         RTE_NODE_XSTAT_DESC_SIZE) < 0)
> --
> 2.53.0
>
>

--0000000000008bebf2065bf85eb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div>Thomas, my patch was delegated to yo=
u. Did you have a chance to look at it? Or maybe it just got lost?</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">=D0=BF=D0=BD, 31 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3=
. =D0=B2 11:18, Dmitriy Matveichev &lt;<a href=3D"mailto:matveichev.dmitriy=
@gmail.com">matveichev.dmitriy@gmail.com</a>&gt;:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Signed-off-by: Dmitriy Matveichev &lt;<a =
href=3D"mailto:matveichev.dmitriy@gmail.com" target=3D"_blank">matveichev.d=
mitriy@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/graph/node.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/graph/node.c b/lib/graph/node.c<br>
index 1fce3e6632..bb39c616de 100644<br>
--- a/lib/graph/node.c<br>
+++ b/lib/graph/node.c<br>
@@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto free;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;xstats-&gt;=
nb_xstats =3D node-&gt;xstats-&gt;nb_xstats;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt=
; node-&gt;xstats-&gt;nb_xstats; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (rte_strscpy(reg-&gt;xstats-&gt;xstat_desc[i], node-&gt;xstat=
s-&gt;xstat_desc[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_NODE=
_XSTAT_DESC_SIZE) &lt; 0)<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--0000000000008bebf2065bf85eb9--
