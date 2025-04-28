Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE92C369D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 00:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0611402A3;
	Tue, 29 Apr 2025 02:03:10 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 20C674026C
 for <dev@dpdk.org>; Tue, 29 Apr 2025 02:03:10 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso4750982a12.1
 for <dev@dpdk.org>; Mon, 28 Apr 2025 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745884989; x=1746489789; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CYQ8BMBXr2P31Gx4SBXLxGKkLuEw74ggss8uWNTXSGQ=;
 b=C47tqh5PnB456DRxHPxF9KuTnr6XNH8PBWzDaLqwK6RVOkQKyhsnHFcpgUlShwgj1x
 TRzq8xfRgo+46+Qx1X2ZGmBRXqNLmCwLRomDcarbMXwwaxRF3002NsjY1pg6SvFjgscy
 jEOwynW3KUiX7v7KNhw4Lkwxhk8cdW0bKuKPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745884989; x=1746489789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CYQ8BMBXr2P31Gx4SBXLxGKkLuEw74ggss8uWNTXSGQ=;
 b=KLvf45rXCQvUCMv1feBrsQnOgNeb8+nDQFGH9+F0jmGSSo4TLKQu/kmfKt5f9aZheo
 xXopwCp0uQUyMG/YC9fwmmUG/Ehu4habw1mrvlzm+acZMgS77OY1QHFrkkiSD1a98bIL
 IpW1JQT8eOIXiUKF9imqvKdHdIcUe/ebRA8457kZU2QRPpdKmEBRG/X/B74caIM0+0IR
 KRrNamDLiboai3fM1818SzaPpkP54qaARLctThy7a7c9rn7yNMRqyZ8pSImi9YRe85XK
 WVS9Kcw4KuP7hNyW6M6lI+53ufFHZMFQNi7BhrNb8YCDC47tcEldGsw0w7zdGquDTDO9
 xmAQ==
X-Gm-Message-State: AOJu0Yw17YArQIMG6N8RUj/PVKphF1rBvCKdwHkyKdQBUfR7/A5f99NR
 GDXTBWY54EubpcagQm5cIf5zawKeGUfyX9AkLSBvwqsJXKLYb7sL5thajKyKyy8QmBP6bxaKI0R
 1DYise8Qo7AIkbR3JIirzJE6V4+lr5T6J6kTi7w==
X-Gm-Gg: ASbGncuKdh9hQ/LtPbBAnzYrE9L4n0TC0LIaA1T14nNhx/5PmrorEU1tVCUIbMJ2Zbo
 TuuaxiQcngEWzZnW+hTHaayukzvpO/z0bbJ7+lJ2IdZWmltuICOHZjB7fS8nsZitDWl59W+//al
 5oZMVkfydkzXsNnXkmiDo4d6QwRPZ8GgRZL/HSGlovy0VbR54WB7273oA=
X-Google-Smtp-Source: AGHT+IGkf6BqOHB8eiHKognvAQxybg6fXzbaRHJw8zsz5HnxiUNw9JEDFVD7gcpd6VgXQw7hG9hAzcn2ejWFoozbGLE=
X-Received: by 2002:a17:90b:3504:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-30a221b8675mr1788624a91.0.1745884989037; Mon, 28 Apr 2025
 17:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250427112821.108929-1-mkashani@nvidia.com>
In-Reply-To: <20250427112821.108929-1-mkashani@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 28 Apr 2025 19:58:42 -0400
X-Gm-Features: ATxdqUEmW3PnvjCPuEzmG0A8-CBtslSAyE7BQPNzf3dqpazQoEcQFNba2VF40bg
Message-ID: <CAJvnSUDKizObzmGnnxMhCSLWFW2trgxqPuewvZjMxo39TaJVRA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5/hws: fix send queue drain on FW WQE destroy
To: Maayan Kashani <mkashani@nvidia.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009738020633df86ec"
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

--0000000000009738020633df86ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-intel-Performance

Looks like this patch was affected by an infra failure - putting in a
retest request for the CI testing system.

On Sun, Apr 27, 2025 at 7:28=E2=80=AFAM Maayan Kashani <mkashani@nvidia.com=
> wrote:

> Queue sync operation was skipped on rule destroy.
> Unlike on fw wqe rule create in which both fence and notify_hw
> are set to true, on destroy fence was set to false causing
> previous queue operation to be stuck in the queue forever.
> Example:
>    rule_a - HW rule, rule_b - FW WQE rule.
> Sequence:
>    rule_a destroy, burst=3D1 (HW rule put to queue but no DB)
>    rule_b destroy, burst=3D0 (FW WQE rule cmd but no queue sync)
> Outcome:
>    rule_a is stuck forever in the queue - no completion.
>
> Fixes: 338aaf911665 ("net/mlx5/hws: add send FW match STE using gen WQE")
> Cc: stable@dpdk.org
>
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  drivers/net/mlx5/hws/mlx5dr_send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c
> b/drivers/net/mlx5/hws/mlx5dr_send.c
> index e121c7f7ed5..d01fc7ef2ca 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_send.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_send.c
> @@ -339,7 +339,7 @@ void mlx5dr_send_stes_fw(struct mlx5dr_send_engine
> *queue,
>         pdn =3D ctx->pd_num;
>
>         /* Writing through FW can't HW fence, therefore we drain the queu=
e
> */
> -       if (send_attr->fence)
> +       if (send_attr->fence || send_attr->notify_hw)
>                 mlx5dr_send_queue_action(ctx,
>                                          queue_id,
>
>  MLX5DR_SEND_QUEUE_ACTION_DRAIN_SYNC);
> --
> 2.21.0
>
>

--0000000000009738020633df86ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<br><br>Looks l=
ike this patch was affected by an infra failure - putting in a retest reque=
st for the CI testing system.</div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 27, 2025 at =
7:28=E2=80=AFAM Maayan Kashani &lt;<a href=3D"mailto:mkashani@nvidia.com">m=
kashani@nvidia.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Queue sync operation was skipped on rule destroy.<br>
Unlike on fw wqe rule create in which both fence and notify_hw<br>
are set to true, on destroy fence was set to false causing<br>
previous queue operation to be stuck in the queue forever.<br>
Example:<br>
=C2=A0 =C2=A0rule_a - HW rule, rule_b - FW WQE rule.<br>
Sequence:<br>
=C2=A0 =C2=A0rule_a destroy, burst=3D1 (HW rule put to queue but no DB)<br>
=C2=A0 =C2=A0rule_b destroy, burst=3D0 (FW WQE rule cmd but no queue sync)<=
br>
Outcome:<br>
=C2=A0 =C2=A0rule_a is stuck forever in the queue - no completion.<br>
<br>
Fixes: 338aaf911665 (&quot;net/mlx5/hws: add send FW match STE using gen WQ=
E&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Alex Vesker &lt;<a href=3D"mailto:valex@nvidia.com" target=
=3D"_blank">valex@nvidia.com</a>&gt;<br>
Signed-off-by: Maayan Kashani &lt;<a href=3D"mailto:mkashani@nvidia.com" ta=
rget=3D"_blank">mkashani@nvidia.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/mlx5/hws/mlx5dr_send.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c b/drivers/net/mlx5/hws/mlx5=
dr_send.c<br>
index e121c7f7ed5..d01fc7ef2ca 100644<br>
--- a/drivers/net/mlx5/hws/mlx5dr_send.c<br>
+++ b/drivers/net/mlx5/hws/mlx5dr_send.c<br>
@@ -339,7 +339,7 @@ void mlx5dr_send_stes_fw(struct mlx5dr_send_engine *que=
ue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdn =3D ctx-&gt;pd_num;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Writing through FW can&#39;t HW fence, there=
fore we drain the queue */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (send_attr-&gt;fence)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (send_attr-&gt;fence || send_attr-&gt;notify=
_hw)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mlx5dr_send_queue_a=
ction(ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qu=
eue_id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ML=
X5DR_SEND_QUEUE_ACTION_DRAIN_SYNC);<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div>

--0000000000009738020633df86ec--
