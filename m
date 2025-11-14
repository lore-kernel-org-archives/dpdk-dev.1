Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1ACE8D57
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:53:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0443A410D0;
	Fri, 14 Nov 2025 17:53:51 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id DA52A40EDB
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:53:49 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8b22b1d3e7fso208420785a.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139229; x=1763744029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0/6sy60zf/mmDLMk5CIQR881GxQESfV9RhKEeCqdZE=;
 b=PuWo0quzo1z8OiYWIIrPbkPi1nE7Ibt15dp9Qx/B4/ereF8OWyn1AZCZAvq/CEZrsB
 +6DpGjFyPTay40cmZaACK8/HBMEkdoFGN29upx4hH/lhNbgBHs+D3xQF6oX6q6lRY+X8
 8VVeJ9jXKaauxngnXuIF+5s6SN538+DG4iVlPRJGNjvYjfDSoe4SuWWNzKjJ8+3PlyE1
 8FkJtQKf4eGRu8NqWoIDW6+ftRhm/F6kl1u7FkYs+tMQUp83WagHNYumhzbXB5G/H3gM
 Qe1JbIwjcYsaAmL8/NpB4KKO74RDrRyuzigOwbkXTP12cg5GT0x0Wob/n2V6K9Vevjej
 APKA==
X-Gm-Message-State: AOJu0YzwSKA1yBttfzH1jO2FVMGIFo0u3QGgExox7IsG8lywANyFij6T
 g0pc838zWizObbgaCjZMPRT2RRYCPA961/o0wNFPQUqaKWDEvPJT9Qw0X/gqrpUPp5+CT3Gt20R
 YqVnDNstJ/ezlASIFlu0EtqSCuSsMFJE=
X-Gm-Gg: ASbGnctBpwkfW6hmnyoHyuqbgEiQvHtg+i9hba98ELKg/PgOTDVfkgp7bAbUUQ70BIA
 e1bG1mNPeOInn9NzHneSLs5PQe/J+0244lMaQqi6xiABF/8bkCNzqp9wGwsWj7YvQN13b1asbAN
 BknpDXUBwH5YBHno6zC3BNi/l7uFy2aCR0Hc/N3Xlbzg2c9YZdJ6ckzTNK4R0y9KMtwMD7FR72A
 HXFy96Op57QeD7T46w+jPPR+ADd1xsNKXSuUsNC3bBSLIWE4PLWun2RBEY4e74QEb/J7uKBPg97
 qps07O7qMuznVBk=
X-Google-Smtp-Source: AGHT+IEON0G/Sg6FUoLm4NkyKI0Q7Ztmu096PPKj6AIvDUlqL14afrvJmR5tt+nJll7pxRZR7eLW/EM7WmZBSBqjfBc=
X-Received: by 2002:a05:620a:4592:b0:891:e26f:512d with SMTP id
 af79cd13be357-8b2c31d2c97mr500957685a.59.1763139228889; Fri, 14 Nov 2025
 08:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
In-Reply-To: <20251114062454.2731559-1-hemant.agrawal@nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 14 Nov 2025 17:53:38 +0100
X-Gm-Features: AWmQ_bl4H4odNAgpkRoaQ7Qa1MjzwRRn2Z9f4WSHqtqPE3cRcq8_O2m-tYIy4uA
Message-ID: <CAHHRULWc4GVdYxfT9YndSNRHd2jBxTDXoNNnKzCAHpBHE=BR2A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
To: Hemant Agrawal <hemant.agrawal@nxp.com>, stephen@networkplumber.org
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006d7490064390d79f"
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

--0000000000006d7490064390d79f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen and Hemant,

It would be great if this series could be merged for rc3. I=E2=80=99ve test=
ed it
successfully with Grout on my side, and it allows us to support the DPAA2
Ethernet driver without any ugly workarounds. I=E2=80=99ve also reviewed al=
l the
patches, and everything looks good with no major risks.

Regards,
Maxime Leroy

Le ven. 14 nov. 2025, 07:25, Hemant Agrawal <hemant.agrawal@nxp.com> a
=C3=A9crit :

> When rte_eth_dev_close() is called, it performs the following actions:
>
> Calls dev->dev_ops->dev_close(), which in this case is dpaa2_dev_close().
> Then calls rte_eth_dev_release_port(), which releases all device data
> and sets dev->data to NULL.
>
> Later, when rte_dev_remove() is called, the FSLMC bus invokes
> dev->remove() =E2=80=94 that is, rte_dpaa2_remove().
> However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev->dat=
a
> was already set to NULL by the previous call, this second invocation
> causes a crash.
>
> Fixes: 5964d36a2904 ("net/dpaa2: release port upon close")
> Cc: sachin.saxena@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c
> b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 7da32ce856..fcda267e0b 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -3347,14 +3347,22 @@ static int
>  rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
>  {
>         struct rte_eth_dev *eth_dev;
> -       int ret;
> +       int ret =3D 0;
> +
> +       eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
> +       if (eth_dev) {
> +               ret =3D dpaa2_dev_close(eth_dev);
> +               if (ret)
> +                       DPAA2_PMD_ERR("dpaa2_dev_close ret=3D %d", ret);
> +
> +               ret =3D rte_eth_dev_release_port(eth_dev);
> +       }
>
> -       eth_dev =3D dpaa2_dev->eth_dev;
> -       dpaa2_dev_close(eth_dev);
>         dpaa2_valid_dev--;
> -       if (!dpaa2_valid_dev)
> +       if (!dpaa2_valid_dev) {
>                 rte_mempool_free(dpaa2_tx_sg_pool);
> -       ret =3D rte_eth_dev_release_port(eth_dev);
> +               dpaa2_tx_sg_pool =3D NULL;
> +       }
>
>         return ret;
>  }
> --
> 2.25.1
>
>

--0000000000006d7490064390d79f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Stephen and Hemant,</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">It would be great if this series could be merged for =
rc3. I=E2=80=99ve tested it successfully with Grout on my side, and it allo=
ws us to support the DPAA2 Ethernet driver without any ugly workarounds. I=
=E2=80=99ve also reviewed all the patches, and everything looks good with n=
o major risks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,<=
/div><div dir=3D"auto">Maxime Leroy</div><div dir=3D"auto"><br><div class=
=3D"gmail_quote gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" class=
=3D"gmail_attr">Le ven. 14 nov. 2025, 07:25, Hemant Agrawal &lt;<a href=3D"=
mailto:hemant.agrawal@nxp.com">hemant.agrawal@nxp.com</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">When rte_eth_dev_close() is=
 called, it performs the following actions:<br>
<br>
Calls dev-&gt;dev_ops-&gt;dev_close(), which in this case is dpaa2_dev_clos=
e().<br>
Then calls rte_eth_dev_release_port(), which releases all device data<br>
and sets dev-&gt;data to NULL.<br>
<br>
Later, when rte_dev_remove() is called, the FSLMC bus invokes<br>
dev-&gt;remove() =E2=80=94 that is, rte_dpaa2_remove().<br>
However, rte_dpaa2_remove() calls dpaa2_dev_close() again. Since dev-&gt;da=
ta<br>
was already set to NULL by the previous call, this second invocation<br>
causes a crash.<br>
<br>
Fixes: 5964d36a2904 (&quot;net/dpaa2: release port upon close&quot;)<br>
Cc: <a href=3D"mailto:sachin.saxena@nxp.com" target=3D"_blank" rel=3D"noref=
errer">sachin.saxena@nxp.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"noreferrer"=
>stable@dpdk.org</a><br>
<br>
Signed-off-by: Hemant Agrawal &lt;<a href=3D"mailto:hemant.agrawal@nxp.com"=
 target=3D"_blank" rel=3D"noreferrer">hemant.agrawal@nxp.com</a>&gt;<br>
Tested-by: Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" target=3D"_=
blank" rel=3D"noreferrer">maxime@leroys.fr</a>&gt;<br>
---<br>
=C2=A0drivers/net/dpaa2/dpaa2_ethdev.c | 18 +++++++++++++-----<br>
=C2=A01 file changed, 13 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_eth=
dev.c<br>
index 7da32ce856..fcda267e0b 100644<br>
--- a/drivers/net/dpaa2/dpaa2_ethdev.c<br>
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c<br>
@@ -3347,14 +3347,22 @@ static int<br>
=C2=A0rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_dev *eth_dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0eth_dev =3D rte_eth_dev_allocated(dpaa2_dev-&gt=
;<a href=3D"http://device.name" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">device.name</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (eth_dev) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dpaa2_dev_c=
lose(eth_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0DPAA2_PMD_ERR(&quot;dpaa2_dev_close ret=3D %d&quot;, ret);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_dev=
_release_port(eth_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0eth_dev =3D dpaa2_dev-&gt;eth_dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dpaa2_dev_close(eth_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpaa2_valid_dev--;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dpaa2_valid_dev)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dpaa2_valid_dev) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_mempool_free(dp=
aa2_tx_sg_pool);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_eth_dev_release_port(eth_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpaa2_tx_sg_pool =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div></div></div>

--0000000000006d7490064390d79f--
