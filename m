Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69DC55822
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 18:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40CD140272;
	Mon,  3 Aug 2026 20:04:39 +0200 (CEST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6236F40269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 20:04:38 +0200 (CEST)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5bfaa014978so1684498e0c.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 11:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780277; cv=none;
 d=google.com; s=arc-20260327;
 b=cOzGeXsYJT+ZlHweKj7lmpDMLbR7vLd511S39Mvay7m2MkdDewiiILTF+CTYwaC58J
 BC0GmBFjBOb7c14xv6urLAZS7uBZj87v/KT39nUUE62RzGQyEKGLEr1nCvMzCYtUm/Cp
 DWOnPfF3gLltMLyWKKMONoB9by3f+N7gJDL0Q50k5ntx2/7EINkFyOQR4z+R7Sdmvr5w
 tosCqIKlewJ+5vx4rrGPXfqLciwlHEcYypS3q4U83Z45Nju6f09Y0vBjltA1+14xNHR6
 +M63tUJs+OhGhH4WpINPUnzR8MINPXp9IFKt/BgmJTuTQrSXJdUI8pGJEZMjLmY2NFEM
 FpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kIm1Ap8uFFHwfqec1fNam698TqmujZDF60VkHg9XPP0=;
 fh=z1K73h+yJ7HQRrUY+A9JfBaOk1E4zbg0PkouGWGfh+o=;
 b=swRN7tkCzEf72oUKk2aow2kNK+J4DLyvSy5aqnnlgHPlToEMeZFyuZloPitgTNJAxj
 2ovJ8DGYpOS5h58c00SeU9YJKsfZEHdjoQ12jdxzPB1cxs5Sd5xZul1Bppg1yQxPFKMV
 ZqIPuiX77nzazcXTDZYoAl7s9aHv09Gxkxo6lMeQhNfDJ/GhHibSZ+uqwF6Pu4bPbRU3
 E4KzsxKMtIH56DCXIA98tVmyzZtbBxfR8OL/71zfAdyqGxUMSAwzu6lrl2fv/Gzlpvtf
 I2TCkzud15R8VVJ6SczBB5VkXFC9M4wUsI8L82r08ufjbAglyXjQ7ykzj4Xt/9EdvLig
 Oxig==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785780277; x=1786385077; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kIm1Ap8uFFHwfqec1fNam698TqmujZDF60VkHg9XPP0=;
 b=u2Mup8CUXfNwvz0c9dq4ALBKRrN/QS5sRuFdyzsQ04MQmgE5UVmp0zBliFKKm6aYMx
 tXUKW9/EfyKcZ6Fz6VEc8E8U4/P66FT7jYrYwBnOCVyKxvA1dVT07ufd9LmZr2DHl51k
 dYghbqFC3B5zSbzZ1nR0YdCHZz3Ms6teaA9+CQZ0DmqigKVgp7Mx9KZHFIbqS2myTIrR
 ACvecjbALYnReoZfBLH8N7Hvgi4wTZXCB1S/q9Cq1OBnl8a/7ceykjk23BulgdVvspoc
 DF7D5ovBVch49LNhfTWs8Z0axJxm/QdVF/jli/rC0uBi6kfZAH3bAyc7M5PCIrvNBJ05
 eelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785780277; x=1786385077;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kIm1Ap8uFFHwfqec1fNam698TqmujZDF60VkHg9XPP0=;
 b=MfgL32gduBBtCWmQTVSSulq3tOvIJH8c9foV5fMhA01WLS93WYr5R8kmHx/p8mcRrM
 BZQowpo90d5dF+5SJe/IIlPD9/8Vl2LRPcrdlecQVPcnI6SyXlBFb0eEK/+viCksrX++
 AcoFn6S7us+9+5ps3uGxGMC4ytrOQau8LcjcYf5/DKG5Bbg77tTmyR4E474BOqbZWpVV
 nQZShe8d49GrP8/yHgPG18FbeR+dzKfdS+FYg1q1wyPnwj/NtT6whg5ygGEyxmngKMEt
 IapidcIdsCmeeio3RUmsD4q/6QD4B1KrYCgu++ttLjJGZEvmp5MhrePlUFIfo4RiYdXh
 pxaw==
X-Gm-Message-State: AOJu0Yy2mMQ6ZumtsbOKNGNJbNfaPW748JHQKBf/Ps3wsF4kpUZvtFY6
 FP4zUtbLmlW65W334JZTqDIJwbkmqfOVoVmj6xYxA/Q0ludeI48B1zy+KGckGjZNH112sPHIedV
 TtyRZIFYn8RYbD2hjYLwthP8lCw406UcS8+iOYgq0
X-Gm-Gg: AR+sD11SNSi5logv2u+UzyY1+r7SwvnqEnRCgJKn7sY3eyASLrFzGaU1TXPeynEfcrv
 zf9AddWx9IJJofSTj2HZOSiOWP4byLQa1jU9eHvr6boxMuCF3aw+cVcsynCHPtri6MbOLpbv6XZ
 Y4shcOe9KJg6yRCdMjVgTVVKjHyTI8LH5/afFHadDOr2sN7/FyaFGwQLcgQDMrnVvFJl/9ZeuIt
 BReAAI33hJmmYxEfCqcHNV1rv9RWxyR4QajpXHtEUV/ml67thOcL1bg4i4iILVG4s1MKqkNf48k
 lwYhbDpcuB/cFNIiPA/178bZ3XnU0md4zwhekIsP58n8nmLZX/p8jhFi7tKhDcTrmjVX9RHiwRi
 vQsBmwb3KBw==
X-Received: by 2002:a05:6102:2d09:b0:738:bce9:6afc with SMTP id
 ada2fe7eead31-75b1e83c13cmr7993599137.0.1785780276768; Mon, 03 Aug 2026
 11:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260803165304.289869-7-stephen@networkplumber.org>
In-Reply-To: <20260803165304.289869-7-stephen@networkplumber.org>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 3 Aug 2026 11:04:22 -0700
X-Gm-Features: AUfX_mz9RkOVWUiYvORWZhmfzSgOVkm6TtNrk3DniM96xp23eWEKv-G1t6nGQuQ
Message-ID: <CALuQH+UjgaZck=TfQHYGLNSEWtfD9iDh-B0YejzxRvGPaPTZRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/22] net/gve: include IP, UDP and TCP headers
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

On Mon, Aug 3, 2026 at 9:53=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This driver was getting rte_ip.h, rte_udp.h and rte_tcp.h
> implicitly through rte_ethdev.h -> rte_eth_ctrl.h -> rte_flow.h.
> Since rte_eth_ctrl.h is deprecated, better to not depend
> on that.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/gve_ethdev.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
> index c9a176ff17..8087bf98f9 100644
> --- a/drivers/net/gve/gve_ethdev.h
> +++ b/drivers/net/gve/gve_ethdev.h
> @@ -14,6 +14,9 @@
>  #include <rte_bitmap.h>
>  #include <rte_memzone.h>
>  #include <rte_thread.h>
> +#include <rte_udp.h>
> +#include <rte_tcp.h>
> +#include <rte_sctp.h>
>
>  #include "base/gve.h"
>
> --
> 2.53.0
>
