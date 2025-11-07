Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC45CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 08:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C349E402E4;
	Fri,  7 Nov 2025 09:32:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CA17A40264
 for <dev@dpdk.org>; Fri,  7 Nov 2025 09:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762504378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXLJ0hGq5jrU8xUawgp3whdVkqRSV1x6p7zGPm36vX4=;
 b=d6nvZSkSxa9LJOciftkdqFG6Ko+IHSCgc0GgH2TIhfEsJ35hu+YxyiEdhpaV0PgBovCjkV
 xQVWTxDpkd44J9F1Fw1t/zF6DdGpaalvzpO/6CKBcD+T3DgmtFpRt7BN1ZHKAL91Le2EU4
 eZcVjE/h0YsDNcRM18GSyshhCgquxgo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-wkO_SBXGM66plmizPpoilQ-1; Fri, 07 Nov 2025 03:32:57 -0500
X-MC-Unique: wkO_SBXGM66plmizPpoilQ-1
X-Mimecast-MFC-AGG-ID: wkO_SBXGM66plmizPpoilQ_1762504376
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59436279838so440029e87.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 00:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762504375; x=1763109175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uXLJ0hGq5jrU8xUawgp3whdVkqRSV1x6p7zGPm36vX4=;
 b=kqjf91Ut7ExPaOpCKHR9GJnkV9B2vdIuTbjKxr0FEvzHTUYettOPWZyRKf6ZJKSvZb
 InLldueclsg95P7w+PwyT2x4LWVMIQaGRqpyrk+tQwp9pNKmidri+TPVCWPIdvWc1N54
 uLr/uMuSSBOGaYPyc7qLgveGzYy+GR/M1iD7qUqvDtJB54blMjuYZtpdvjDW9Wu6tv7F
 DgamV/W7KbeXeCfhaAA051VoPCvQJSmZzZdYEQCzQBzPpEi4Sa1C9CzFoSEuXWU+lTcO
 R0sBff/3r3aDT1HlRHNGMX46L6aDkVgeOZNosJJ5IFwyw4lfT8mv4UKREVRQ0d0UkzwT
 lN5w==
X-Gm-Message-State: AOJu0YxS7dRaNp7NpNRFDBlvafIfmR6kM2S99oRVUgMMZHM7zmYf0W1h
 xJcT+5iAC34+9qyShymj0oBiegr/QNzFsFHVlBX7tpjK5zn0wu5Y30ujc/yQac6Fw2CXwjYK4Pw
 WhgSnJuNfZxK5ihDfdW8j6mQIbr0tBx9dYo61h6ZcfPX9Zda2XHjC051tSSEAWF2qbgV0hWMl0t
 xT2/Vc9QiA8Pw9XHDFgpk=
X-Gm-Gg: ASbGncv9fA601r4zMif00vSYdGLqXlrw0+wgRcoUvf1DU6QPDOe0NI2Hhk8iAobQWTT
 XpyVGnNvFczGK/W8Nx3NzKTfho7yD+XTQ3N7pobvwhCdG+ZB5TFEe7ROPVnIkut8nkbMG5IZfs5
 5NzBI4f8qO7Y+/H+H/k/6zJu88AuUW22jOsmMmAmXaKVA94gg3wuIm2uD0dw==
X-Received: by 2002:ac2:4e06:0:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59456cbefa1mr798972e87.47.1762504375433; 
 Fri, 07 Nov 2025 00:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCUp4flH2IxxMWWqjtTTYD0Z5djjqgSkV0rr/REDQrat8pO3UGyl/hRYQcHTTGfKiEqCXphfXOawXCsvqp+Ls=
X-Received: by 2002:ac2:4e06:0:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59456cbefa1mr798955e87.47.1762504374948; Fri, 07 Nov 2025
 00:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
In-Reply-To: <20251106163807.201451-1-hemant.agrawal@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Nov 2025 09:32:42 +0100
X-Gm-Features: AWmQ_bnacEtClyo-EX5Xks2hRm5fWpSBHaVlm_nbYrqIhVenR1Ru5JxOOu1u3v4
Message-ID: <CAJFAV8y4KCDG94OswHaYuk-0PaxdHKzO1_yG+rVVYTcBCJb1JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/dpaa2: fix duplicate calling of dpaa2 dev close
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, sachin.saxena@nxp.com, 
 stable@dpdk.org, maxime@leroys.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1rKdIe6ygEAVjIl47ErVHy7OTmeFJXWW-50xMSK--us_1762504376
X-Mimecast-Originator: redhat.com
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

Hello,

On Thu, 6 Nov 2025 at 17:38, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
>
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
> ---
>  drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_e=
thdev.c
> index 7da32ce856..f3db7982a4 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -3347,14 +3347,17 @@ static int
>  rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
>  {
>         struct rte_eth_dev *eth_dev;
> -       int ret;
> +       int ret =3D 0;
>
>         eth_dev =3D dpaa2_dev->eth_dev;

Having a back reference of the "class" object in a "device" object
seems wrong to me (and there is a dev_priv->eth_dev too...).
It breaks the separation that was introduced with rte_device years ago.

I did not look in detail, but it seems strange that after closing a
first time, there would still remain a reference of the eth_dev object
in the dpaa2 device object.
At least, it would be worth double checking that the
dpaa2_dev->eth_dev is cleared in dpaa2_dev_close.


> -       dpaa2_dev_close(eth_dev);
> +       if (eth_dev->data) {
> +               ret =3D dpaa2_dev_close(eth_dev);
> +               if (!ret)
> +                       ret =3D rte_eth_dev_release_port(eth_dev);

I don't see why you would need to decrement dpaa2_valid_dev again below.
Maybe a missing return here?


> +       }
>         dpaa2_valid_dev--;
>         if (!dpaa2_valid_dev)
>                 rte_mempool_free(dpaa2_tx_sg_pool);
> -       ret =3D rte_eth_dev_release_port(eth_dev);
>
>         return ret;
>  }


Taking a step back, the issue this patch wants to fix is a pattern
that is resolved by other drivers by checking if a eth_dev is
allocated for a rte_device.
A simpler (untested) fix seems to be:

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_eth=
dev.c
index 7da32ce856..6682a72341 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3349,7 +3349,10 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
        struct rte_eth_dev *eth_dev;
        int ret;

-       eth_dev =3D dpaa2_dev->eth_dev;
+       eth_dev =3D rte_eth_dev_allocated(dpaa2_dev->device.name);
+       if (!eth_dev)
+               return 0;
+
        dpaa2_dev_close(eth_dev);
        dpaa2_valid_dev--;
        if (!dpaa2_valid_dev)


--=20
David Marchand

