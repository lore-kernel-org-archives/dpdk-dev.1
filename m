Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A9BC77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 12:02:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B2CB40684;
	Tue, 24 Jun 2025 14:02:05 +0200 (CEST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by mails.dpdk.org (Postfix) with ESMTP id E6A6E40264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 14:02:03 +0200 (CEST)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5313ea766d8so96883e0c.0
 for <dev@dpdk.org>; Tue, 24 Jun 2025 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750766523;
 x=1751371323; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vja5651vfFOpcf+dF7eePE4yHz9+J9ZL1TXaAEz7JqE=;
 b=VE3aNxVKoK8WQBSANWVEoajmSZdUpiUpUm19sj+Lm54CQW8QnHbRBZ9ZEWJZLSMzuX
 kSIDlEwE6DfGQ+HQnt6X1d7V5AXsr2N7vnIuSlS/xy3vQ+WWFyF+jPZwFhViUFUsmGVK
 w84Mf1d+iQXblf7i2vlLKFmQBGpzBbHfQzEf/945x4D1SxumbcXbIyqjULiW/bbcfQOj
 fBv6UanytjLWxgdZluTsPgReLe0toEJHYm2DVsSXtOI+Xutquw3JczQQmJHKiroBizg4
 bW2Xoq2uxEmi3wC+/MJO1On7WVbtR4zNdSozFK0mlQlcNTL07B7v09IZ5esg1uwgiOi4
 OGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750766523; x=1751371323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vja5651vfFOpcf+dF7eePE4yHz9+J9ZL1TXaAEz7JqE=;
 b=SIEgc6iZW3uvYCdgSevkmkPQo8J8QNtbbc6FggLff+R0pVZjGRh9uUhRzG23BXIYwD
 fxm+9/K7MNPWj66QluK+DKi9NaUsPdImQKspaeT204aSwnHqcld3AVoxiW7wgv6qMPKf
 zWX8Wt2WemYbqD89wv4T+GP7HCDt8Dle3f7VXEL4O6OtHmnwDsDecqwcTxvurYnL9d1J
 aasnjLTt8g7CmdP2bcWAEV3PAPQxNBmffgmIoUJZ37N0mV0W3Y64b1VqaWRvcaORM5ZX
 StL6ajs0xvre19k4NP4sNCX284cCyCrbElevU/NQeo/rQUR6iCFpCBS1H0+W07fr4EIR
 GSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWo/yjsZPKHOQybHmyesRTngbCbTGPomFJgScjRwpK3PQos7tbRnJpHtjwp3zlERv6URE=@dpdk.org
X-Gm-Message-State: AOJu0YwbOzyRVG1P5do5IoKan62JhK6WVe1SxRy2vw9jfYJ5eYH8H8P/
 pONqtVOA0kIe4hSY7RSST10fwySpg04pZ4iy5o34iUnOgD7s2aDbbYN36sO+FApolZpZfoDB0dX
 Y3e4dfvX8DSCvrFIudyGeFhHuTVy5CZuG3AsAhVFdPQ==
X-Gm-Gg: ASbGncu0gA5zuqmUEQRYG5to42VK7r4siBjdl5xCLVefODlHNMEvUnLhcQlKYPJam5C
 SWtt8fi0MAgS8a6BwspAi5xxrro9NtNhuyZIFS3+24NKrj44WFTXoZVeli6Craio5Gv6JoOlK4v
 GZeBIn2D7K/7cDIvHjj2PgFhNGitGraRrNdvgG045Kh3ZuHzw2mNODFBy4eBroxY6rvG407jHva
 TM9+A==
X-Google-Smtp-Source: AGHT+IHlFLfYBu/H26Gz4TdDszTm02mjF1lGQ6ntPXw6WDh5DKoutsi72mYdtrUuVCXusPgQqmV/GZaA8KY1uqr43sc=
X-Received: by 2002:a05:6122:3d04:b0:530:65f0:7fc4 with SMTP id
 71dfb90a1353d-531ad59758dmr8034268e0c.1.1750766519251; Tue, 24 Jun 2025
 05:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250623183456.130666-1-bingz@nvidia.com>
 <20250623183456.130666-3-bingz@nvidia.com>
In-Reply-To: <20250623183456.130666-3-bingz@nvidia.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 24 Jun 2025 08:01:48 -0400
X-Gm-Features: AX0GCFv84-IiTa1dz4mG6wtMq9Gh81Tei3cnU6zfZQKPzX0UAKZHcr8Ea-WSpA8
Message-ID: <CAOaVG15O-jY-YJoFpytUVQATJQnDe+saDHD1DQZJD58xFNqhfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] net/mlx5: add new devarg for Tx queue consecutive
 memory
To: Bing Zhao <bingz@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, dev <dev@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, rasland@nvidia.com
Content-Type: multipart/alternative; boundary="000000000000771796063850183a"
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

--000000000000771796063850183a
Content-Type: text/plain; charset="UTF-8"

Why is this needed? Need some documentation. DPDK needs less not more nerd
knobs

On Mon, Jun 23, 2025, 14:35 Bing Zhao <bingz@nvidia.com> wrote:

> With this commit, a new device argument is introduced to control
> the memory allocation for Tx queues.
>
> By default, 'txq_consec_mem' is 1 to let all the Tx queues use a
> consecutive memory area and a single MR.
>
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5.c | 14 ++++++++++++++
>  drivers/net/mlx5/mlx5.h |  1 +
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
> index b4bd43aae2..f5beebd2fd 100644
> --- a/drivers/net/mlx5/mlx5.c
> +++ b/drivers/net/mlx5/mlx5.c
> @@ -185,6 +185,9 @@
>  /* Device parameter to control representor matching in ingress/egress
> flows with HWS. */
>  #define MLX5_REPR_MATCHING_EN "repr_matching_en"
>
> +/* Using consecutive memory address and single MR for all Tx queues. */
> +#define MLX5_TXQ_CONSEC_MEM "txq_consec_mem"
> +
>  /* Shared memory between primary and secondary processes. */
>  struct mlx5_shared_data *mlx5_shared_data;
>
> @@ -1447,6 +1450,8 @@ mlx5_dev_args_check_handler(const char *key, const
> char *val, void *opaque)
>                 config->cnt_svc.cycle_time = tmp;
>         } else if (strcmp(MLX5_REPR_MATCHING_EN, key) == 0) {
>                 config->repr_matching = !!tmp;
> +       } else if (strcmp(MLX5_TXQ_CONSEC_MEM, key) == 0) {
> +               config->txq_consec_mem = !!tmp;
>         }
>         return 0;
>  }
> @@ -1486,6 +1491,7 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>                 MLX5_HWS_CNT_SERVICE_CORE,
>                 MLX5_HWS_CNT_CYCLE_TIME,
>                 MLX5_REPR_MATCHING_EN,
> +               MLX5_TXQ_CONSEC_MEM,
>                 NULL,
>         };
>         int ret = 0;
> @@ -1501,6 +1507,7 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>         config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
>         config->cnt_svc.service_core = rte_get_main_lcore();
>         config->repr_matching = 1;
> +       config->txq_consec_mem = 1;
>         if (mkvlist != NULL) {
>                 /* Process parameters. */
>                 ret = mlx5_kvargs_process(mkvlist, params,
> @@ -1584,6 +1591,7 @@ mlx5_shared_dev_ctx_args_config(struct
> mlx5_dev_ctx_shared *sh,
>                 config->allow_duplicate_pattern);
>         DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
>         DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.",
> config->repr_matching);
> +       DRV_LOG(DEBUG, "\"txq_consec_mem\" is %u.",
> config->txq_consec_mem);
>         return 0;
>  }
>
> @@ -3150,6 +3158,12 @@ mlx5_probe_again_args_validate(struct
> mlx5_common_device *cdev,
>                         sh->ibdev_name);
>                 goto error;
>         }
> +       if (sh->config.txq_consec_mem ^ config->txq_consec_mem) {
> +               DRV_LOG(ERR, "\"txq_consec_mem\" "
> +                       "configuration mismatch for shared %s context.",
> +                       sh->ibdev_name);
> +               goto error;
> +       }
>         mlx5_free(config);
>         return 0;
>  error:
> diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
> index 5695d0f54a..4e0287cbc0 100644
> --- a/drivers/net/mlx5/mlx5.h
> +++ b/drivers/net/mlx5/mlx5.h
> @@ -393,6 +393,7 @@ struct mlx5_sh_config {
>         /* Allow/Prevent the duplicate rules pattern. */
>         uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
>         uint32_t repr_matching:1; /* Enable implicit vport matching in HWS
> FDB. */
> +       uint32_t txq_consec_mem:1; /**/
>  };
>
>  /* Structure for VF VLAN workaround. */
> --
> 2.34.1
>
>

--000000000000771796063850183a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Why is this needed? Need some documentation. DPDK needs l=
ess not more nerd knobs=C2=A0</div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 23, 2025, 14=
:35 Bing Zhao &lt;<a href=3D"mailto:bingz@nvidia.com">bingz@nvidia.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">With =
this commit, a new device argument is introduced to control<br>
the memory allocation for Tx queues.<br>
<br>
By default, &#39;txq_consec_mem&#39; is 1 to let all the Tx queues use a<br=
>
consecutive memory area and a single MR.<br>
<br>
Signed-off-by: Bing Zhao &lt;<a href=3D"mailto:bingz@nvidia.com" target=3D"=
_blank" rel=3D"noreferrer">bingz@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/mlx5/mlx5.c | 14 ++++++++++++++<br>
=C2=A0drivers/net/mlx5/mlx5.h |=C2=A0 1 +<br>
=C2=A02 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c<br>
index b4bd43aae2..f5beebd2fd 100644<br>
--- a/drivers/net/mlx5/mlx5.c<br>
+++ b/drivers/net/mlx5/mlx5.c<br>
@@ -185,6 +185,9 @@<br>
=C2=A0/* Device parameter to control representor matching in ingress/egress=
 flows with HWS. */<br>
=C2=A0#define MLX5_REPR_MATCHING_EN &quot;repr_matching_en&quot;<br>
<br>
+/* Using consecutive memory address and single MR for all Tx queues. */<br=
>
+#define MLX5_TXQ_CONSEC_MEM &quot;txq_consec_mem&quot;<br>
+<br>
=C2=A0/* Shared memory between primary and secondary processes. */<br>
=C2=A0struct mlx5_shared_data *mlx5_shared_data;<br>
<br>
@@ -1447,6 +1450,8 @@ mlx5_dev_args_check_handler(const char *key, const ch=
ar *val, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;cnt_svc.=
cycle_time =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (strcmp(MLX5_REPR_MATCHING_EN, key) =
=3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;repr_mat=
ching =3D !!tmp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (strcmp(MLX5_TXQ_CONSEC_MEM, key) =3D=
=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;txq_cons=
ec_mem =3D !!tmp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -1486,6 +1491,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_s=
hared *sh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MLX5_HWS_CNT_SERVIC=
E_CORE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MLX5_HWS_CNT_CYCLE_=
TIME,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MLX5_REPR_MATCHING_=
EN,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLX5_TXQ_CONSEC_MEM=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
@@ -1501,6 +1507,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_s=
hared *sh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;cnt_svc.cycle_time =3D MLX5_CNT_SVC_=
CYCLE_TIME_DEFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;cnt_svc.service_core =3D rte_get_mai=
n_lcore();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;repr_matching =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;txq_consec_mem =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mkvlist !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Process paramete=
rs. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mlx5_kvargs=
_process(mkvlist, params,<br>
@@ -1584,6 +1591,7 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_s=
hared *sh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;allow_du=
plicate_pattern);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRV_LOG(DEBUG, &quot;\&quot;fdb_def_rule_en\&qu=
ot; is %u.&quot;, config-&gt;fdb_def_rule);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRV_LOG(DEBUG, &quot;\&quot;repr_matching_en\&q=
uot; is %u.&quot;, config-&gt;repr_matching);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_LOG(DEBUG, &quot;\&quot;txq_consec_mem\&quo=
t; is %u.&quot;, config-&gt;txq_consec_mem);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
@@ -3150,6 +3158,12 @@ mlx5_probe_again_args_validate(struct mlx5_common_de=
vice *cdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sh-&gt;ibdev_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sh-&gt;config.txq_consec_mem ^ config-&gt;t=
xq_consec_mem) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_LOG(ERR, &quot;=
\&quot;txq_consec_mem\&quot; &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;configuration mismatch for shared %s context.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sh-&gt;ibdev_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mlx5_free(config);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0error:<br>
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h<br>
index 5695d0f54a..4e0287cbc0 100644<br>
--- a/drivers/net/mlx5/mlx5.h<br>
+++ b/drivers/net/mlx5/mlx5.h<br>
@@ -393,6 +393,7 @@ struct mlx5_sh_config {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Allow/Prevent the duplicate rules pattern. *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t fdb_def_rule:1; /* Create FDB default =
jump rule */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t repr_matching:1; /* Enable implicit vp=
ort matching in HWS FDB. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t txq_consec_mem:1; /**/<br>
=C2=A0};<br>
<br>
=C2=A0/* Structure for VF VLAN workaround. */<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000771796063850183a--
