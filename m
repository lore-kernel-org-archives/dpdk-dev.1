Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0EC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 20:42:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA88840268;
	Thu, 20 Aug 2026 22:42:50 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id A3B4B400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 22:42:49 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso239635466b.0
 for <dev@dpdk.org>; Thu, 20 Aug 2026 13:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787258569; cv=none;
 d=google.com; s=arc-20260327;
 b=GULrQD9oSHRjxrtUkieBHedW3GUytJfdQr2R6ULRyk1/PSB+sRZkqNKSk4fvB9Is/q
 skkcS0qh6EgfoWwQHHDEYLMhWzY3JhfS58qiZvvtckH07Jj7bCNftuKypPMxvWxopbax
 akkfy/PQs0h5jLSsin/HY6Ep8ffVuuViEtNmOoHANeY+VZforAzt0nHTR1oOXCAJWMLx
 wMyTCPBIT4TRNuvlMM97+3CjlqyIkoT+IZ/0JNb7tUKu6F7hDxrPIpYlWjfpaDtvsuqh
 AQ6cLdup4ixjnvBSDn7AvcrUtJ4zJlTn3UJ//rJ2E7fK3EVIn2CnPYJoOOX+w40Bo0U3
 3rtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L5A1OwIG0NQPSMMebnpFrPqHs8HALaa60ZzdLg5wmX0=;
 fh=z1K73h+yJ7HQRrUY+A9JfBaOk1E4zbg0PkouGWGfh+o=;
 b=c+aC5W80ZCAsVmGvv07PXdmeCeZ57LQSVYweJwhVODM+OUwCFjr/FlVy7KglEn7cnC
 vxLQRxaWqfCiKTJSvHYt14eKRyYdeGJtO3om9sO9ZXptuhZS2dZqxSGJPWWuemfS5ZpO
 96QO5btSWX7+rI7Py3bZ04AVh8xLrKydgyjoxPNaTSn0hQMx1vcpBrqth0QDzHUHA/LG
 U1tQsLgqwdbeJQNxZic9TdEDi4ERUSxbVlmel1I9V6JFlw/XmQvWXPRHCv6bpMREmvg6
 zKJ9JQSHnPTYNr3/kD9FmHrqHdPYY8f1fVtzvUJAZe2bRxKjvwGo27NVjqYOr1q1JLrt
 DXBw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787258569; x=1787863369; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L5A1OwIG0NQPSMMebnpFrPqHs8HALaa60ZzdLg5wmX0=;
 b=VC4ArV5thh/klSMMLpkxV0m0K/6emDPnUbfGIsQJ4DDILwz2PSz9+6sqKB4R2BsRk/
 FmEEZ6+Wfs4x7Ykfhk0pPPPTMuiC3YSp/E11L8d51myHv/lHKL17vXMAWP/1wHgahRa9
 8dfg2TBmhyFFS6XMbK3OMINPQacWqXxvrqomPfmN5tpetbAY5qFnohXv0bSqHFvRFf2D
 R2KwAtgiky2+xpFPLDgli/yVr9n9hkCiZR2DG0ceOw+apajwdqkANz+7JMFAy/gNl8j2
 nFbhlRoZveofVx7a51pmpKG6TyKoclJVBdaNgJyerK0dlziThAoVLMx7fGBH7c4pr57N
 mxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787258569; x=1787863369;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5A1OwIG0NQPSMMebnpFrPqHs8HALaa60ZzdLg5wmX0=;
 b=kyTKh3vnHaooXlPvMiButsyk6k8zIdUtfMU+K23KCrRkZ5g/H445wMLQtReyHHdAIn
 NmcSeRJzSPmxQjFUuH+vNrOp0AfZMAVVDCSkeFWC1GKv/dwa10+kYNfqh/Xfi1ruT4aB
 HrpUQUd+6SizH3UcYEI58mHq0sui1fN0/ebuvqoZEbAbFjm7mMp9yac3XwjCJSVIW//k
 1dSG3xUTKxT2NxOs9AI6GCS6auE1R9xDsiWkuq7EulsgNbvDihNm8tEAQPPkq5hpPJO5
 X50lIcUTo96Nq1HD8qjCgxu4sEvPYoMJoKdXhOxf9Zkb95DHfODldeD63QqpE4LoE5uX
 9PhA==
X-Gm-Message-State: AOJu0Yx0okemxlOU7uv7HQA+KZEDS0zNiX0B9sKTvGvI0srOnbjwP0x2
 8p2kk2gqM5s+Rc7+ic0We/eGapTq9j++vYkUiBd9IGSQ6jx44dMBMC7X98CU46r/0qYaCXRudXy
 OdBOCsMDlNLtJiN+Q9ZOq1YgOX81/GEBtDI1PiU7YQeKsQEnXYCNf8IDy
X-Gm-Gg: AR+sD10jRekpU1svd4CMKqd7+hpvA1dyVTuBcL82v3S4kUjX7RMHYdUlIgtkilDRiUN
 YpKr5UHmsAsc0bHWV3QWFhl3rX9UMRHmuViyCYaT7RR7Ng/X4mHnFtoaUVPnvtfhiuEoyZHc5Qm
 E/KuUZNAXTG6+z30mywTQ139D4BwXmAPvvZxj+tPJF2S8Ml7QQo9Ta40TxGUEQ0zFy67iv+nTfm
 yTYm+++Bq7DcmSyQoDj62vmGIFpdp/7t8aHMr7g8r+NxL0TktqNw9B0fEGd68WkmJRSRvr1vu6i
 F+wxUnRsSrcYpwr2iSnBan7OZDQF2hUa+EIPQAOC8iA04g==
X-Received: by 2002:a17:907:d641:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c244d45ad42mr699026166b.1.1787258568653; Thu, 20 Aug 2026
 13:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260820052251.1453273-29-stephen@networkplumber.org>
In-Reply-To: <20260820052251.1453273-29-stephen@networkplumber.org>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 20 Aug 2026 13:42:36 -0700
X-Gm-Features: AcwNN1Uzk-PHt-rtTjEkXIxC-m7MYiwiMAOqasz77Sc7IxYxOANPrJV3s45PYGk
Message-ID: <CALuQH+XHHjcxHfQq6jm9ccSLzjZRe5pWR58KaJ_HEvDv8-8Y=A@mail.gmail.com>
Subject: Re: [PATCH 28/61] net/gve: replace use of rte_memcpy
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Jeroen de Borst <jeroendb@google.com>
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

On Wed, Aug 19, 2026 at 10:24=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Don't need rte_memcpy for fixed size value.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Joshua Washington <joshwash@google.com>

> ---
>  drivers/net/gve/base/gve_adminq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve=
_adminq.c
> index 89bf669c24..b7621a1fd1 100644
> --- a/drivers/net/gve/base/gve_adminq.c
> +++ b/drivers/net/gve/base/gve_adminq.c
> @@ -1083,7 +1083,7 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
>         }
>         priv->max_mtu =3D mtu;
>         priv->num_event_counters =3D be16_to_cpu(descriptor->counters);
> -       rte_memcpy(priv->dev_addr.addr_bytes, descriptor->mac, ETH_ALEN);
> +       memcpy(priv->dev_addr.addr_bytes, descriptor->mac, ETH_ALEN);
>         PMD_DRV_LOG(INFO, "MAC addr: " RTE_ETHER_ADDR_PRT_FMT,
>                     RTE_ETHER_ADDR_BYTES(&priv->dev_addr));
>         priv->tx_pages_per_qpl =3D be16_to_cpu(descriptor->tx_pages_per_q=
pl);
> --
> 2.53.0
>
