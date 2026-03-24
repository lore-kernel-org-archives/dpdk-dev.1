Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1557FEC0E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C014060A;
	Tue, 24 Mar 2026 18:21:38 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9B5674021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:21:37 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-509061dab77so13396191cf.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372897; cv=none;
 d=google.com; s=arc-20240605;
 b=SkcunrnovUzzbY/sgzxqM/434xkX1fyzY54DP8WfeAqbzHKFWCl8oquC7TtibkCcBn
 ciFxXYjE3jvyQ/hVjidIxFMrP3vvLkJgQByKy2Gg6yH9KQ8oKvAwgNLCA4bdECJnQQkx
 5ioX5EfqaykOUWtXXipee/ydFCFL9kbAeu225zvx9h97DCx7yvLP8Z/B7Yp3BFwjWCEp
 RF61lhtjD1xvPlLQnFDe36o14TSPHExsWKWWuUuiyGpLYm1YN0Xh+Y8cWVw7crynwpQP
 wOHw5u/h1Zbk+Aa4i+HWDS/HjS/iVlpb3cR8HBOYZBb4Hb44dDFBf0pfl+BqRBxfceIJ
 PWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wE6fCejRywgMan+eabjUM+SDFWI44EqiZjEu/wddRlM=;
 fh=i2eZ1tPGqoVgDd1WGNXBuPEaLe/X9ML3i3k/niDzPL0=;
 b=aQ218njoNO5qZ570QD+LG9qms5TVUoQZPf6foT7WBdSHBuI846XnqSBJR64bTwr1H+
 m7TOiR3o6Abp7FD36uOvmGyNmziUAEOv/t5tPUErhUoVPNegDCTR2PSxqmKrNgd56CDk
 CTPJAqJwhHuvX+P1uCt3yGzSqzcls2snJpctrCDVrFVpfe0nMzSh6m5OuRGcoAsi1Fpd
 +bpww7vl8O/Iqf9wdLwFLoS3NQE7rKesktKV+P+tP/nebUHgCDgQ3FUsaz+zZ4uanViw
 cilnCIMvjJB6hrBWReEl9stEpa4an1gNIAo2I3Z2CZZJzj1im6gUc8FC/cuybpOnwKMI
 SCpg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774372897; x=1774977697; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wE6fCejRywgMan+eabjUM+SDFWI44EqiZjEu/wddRlM=;
 b=NxbFRBlvg7sc3Z4KiNsvjr6hdSSqt0pGIbZQujuwok7GSKAUdTc+CxbZr2s7esxiyy
 owSsIbcuJzdzYHq0NsdeTJNubHpNQUm71MTaMUscVq5trIqTu5NMmntMFZoz51YoQs67
 KFnyftSOSN6zw/NYkxFAKuNHq+loTkHfPJkglTLltqzU+YhdY6GgYd4aMVvg/a4sZH6P
 M0nuolyVV1t4TJluSNlJwtt5dY+bI5jxTCgZ5SzYPExbSI9HlKZi3+NM7img87YB6NPT
 DQi+hn4NTG5MyS7TEHtnPeTfLxgQA+AkbwYtOlslDPXnXoM1cXnYseaXi/uszV0xiV6W
 Orcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774372897; x=1774977697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wE6fCejRywgMan+eabjUM+SDFWI44EqiZjEu/wddRlM=;
 b=ekbjPf59J+zZoEXWkjda3IkJH62Njs1zTDn4Y9Z3qQ1enrZj32XzQKpR1AzCa305a4
 IJKU5EDK3LzC3kJGhFSsUjjqC4ni9Hj84kI/eiT8dL6U5njCk/5/3KcLNABbpS5nqUbI
 25brpaYSiSIBJ6weWlhXOnrUU67Ouu/JN5rEVMQ348YcEzQztzCx23mnysjeO5qbRvI8
 KaZN8LwVK0vcI+ju133Ao1vGI/YbodYrkk2eUK22/1tjLf7AsMylsNbrSiyB5kAhLJmb
 6/BaKUymGfkiKKjcctIumA/8FMbP4POaLLd2C+0cMNmUTDRORBDXyBdvl+6uO8fMGtpX
 aZaQ==
X-Gm-Message-State: AOJu0Ywws935D/XCYIWE/gXeApBjJggFOOFyJlU/R+fgkIFydbEXCCdv
 QoA1VIl8fCpCW54lHvrKN1PBBlWOsT0T3sWfHQnPlbElZka1NQHTDcFIqSOv4mw/XVBKLvKXTo3
 HE3t6IoTG3ixIQdqdo9Sh+YXiMrjT430=
X-Gm-Gg: ATEYQzxQVSeFW1ySpFcIzggxYnwwjBTDyEMV09fqZtriZTt+joXUqFmhRe9Rk7gIMsG
 zY6S/jHB3fOwdSftKec+e63Hh1/PLA21I0E/c1Aj/TN95i/Yg1idDwDD8xgHvSAks3BQu/sQZzS
 KBqlN/qgn8KU2ljNtLghox1KAZU6bmBhLrFiZLTnUc8xU8LMxu6s1xJyrYwrXqDNrc2xA+KLkOz
 pX2EMF7e8c4SHTDhbAQTGZrFjmUhgnV0G3eBOa0SbECJlKt3G5AtIolZN9KeYcLKIGyx/jfmEgo
 vzo=
X-Received: by 2002:a05:622a:53c5:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50b80d9ce08mr6568721cf.31.1774372896821; Tue, 24 Mar 2026
 10:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260304101232.2381567-1-rbhansali@marvell.com>
In-Reply-To: <20260304101232.2381567-1-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 22:51:09 +0530
X-Gm-Features: AaiRm53o7ILYQZ8Q1fBGp-sMC-R_l3QTlv1t5fYGrBY2cqJarsohyUT6UP-5Mwc
Message-ID: <CALBAE1PnsrvccW0tUq05_9jPxokAu3xSfNfx0hrXjPwJ+v746Q@mail.gmail.com>
Subject: Re: [PATCH] event/cnxk: fix segfault for null pointer access
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, jerinj@marvell.com, 
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 4, 2026 at 3:42=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.co=
m> wrote:
>
> The field evdev_priv will have valid event dev pointer only when
> eth_rx_adapter_queue_add() is called.
> In case of poll mode tests, queue add will not be called so this
> will be NULL.
> It is fixed by having a NULL check before access.
>
> Fixes: 01a990fe40e8 ("event/cnxk: fix OOP handling in event mode")
> Cc: stable@dpdk.org

Applied to dpdk-next-eventdev/for-main. Thanks


>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---
>  drivers/event/cnxk/cn10k_eventdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn1=
0k_eventdev.c
> index 0c1431b4e7..2e4b8aab92 100644
> --- a/drivers/event/cnxk/cn10k_eventdev.c
> +++ b/drivers/event/cnxk/cn10k_eventdev.c
> @@ -675,8 +675,12 @@ cn10k_sso_rx_offload_cb(uint16_t port_id, uint64_t f=
lags)
>         struct rte_eth_dev *dev =3D &rte_eth_devices[port_id];
>         struct cnxk_eth_dev *cnxk_eth_dev =3D dev->data->dev_private;
>         struct rte_eventdev *event_dev =3D cnxk_eth_dev->evdev_priv;
> -       struct cnxk_sso_evdev *evdev =3D cnxk_sso_pmd_priv(event_dev);
> +       struct cnxk_sso_evdev *evdev;
> +
> +       if (event_dev =3D=3D NULL)
> +               return;
>
> +       evdev =3D cnxk_sso_pmd_priv(event_dev);
>         evdev->rx_offloads |=3D flags;
>         cn10k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev)=
;
>         eventdev_fops_update(event_dev);
> --
> 2.34.1
>
