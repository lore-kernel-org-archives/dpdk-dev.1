Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECCD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 09:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0966F4021F;
	Thu, 28 May 2026 11:47:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EE224003C
 for <dev@dpdk.org>; Thu, 28 May 2026 11:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779961659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1nsuOmIai7RBgEPQomQ1+m4rqGiC3bb7O543kNTfX0=;
 b=H621Zw8eYWyRixdIh9Z69hwnVt85veTZOt6tFip//8dZNi3D5DmGUz5m19fC9yekuOoooG
 oNDmappMURDrTcInLNccjTEY9UKHH+7hH5vlBX8+rzIv6mabDEIeCw81KjEa/wvqE8INqA
 LgsNHpluFayB56PCEK7xPSdvYCtxdBM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-zVWMlAXEOByG1I4fRy6-6A-1; Thu, 28 May 2026 05:47:38 -0400
X-MC-Unique: zVWMlAXEOByG1I4fRy6-6A-1
X-Mimecast-MFC-AGG-ID: zVWMlAXEOByG1I4fRy6-6A_1779961657
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3963c5bcd47so2408631fa.2
 for <dev@dpdk.org>; Thu, 28 May 2026 02:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779961656; x=1780566456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1nsuOmIai7RBgEPQomQ1+m4rqGiC3bb7O543kNTfX0=;
 b=cjv6VMz0OdSLMvkL55ygUyIGwlJCw3D0A3pyhNHgBS7ouATqifCp+eHewUH3WIzZph
 nif8uVvI6Wf31QAEO5/uDu7u02appkh1QGYh39KGRR/j+8asD8FvNqr1JHs/AY3mjYwd
 s2Tr3TwFfB4oGU5nu8OPzVGmblJRjhWLL5ioYCCK75+vil9sG1z8N2xIPsnZAnfJEJ9c
 Iuww7XS7jZILdtGu72vSGiu7CzL6XNoKTnrGvNxx3Sa9gDPulZdxA70zGFcmGhYaxE/q
 Ska+kr510xdLjhzuMy9vYKIsBJ3eqejeiMMjGlFFim2OKdW8Ht4jDugvEbJzNyLY5nwJ
 17kA==
X-Gm-Message-State: AOJu0YwUVZ6eMJEv2LjxYCi075uiDJLkWYYhqBax23TFHaRfoj6VN3Hl
 xgx1/S8G1WIILe5j/xhu4wV/YMei42fqEWp2M0nWDHBxVtp/DW/j/VD99r4dSVdIuwYmp497mhM
 JvF7t5d0NACYAYOHnSfztqftNanrh4NnVrlMgu+vdQAanf5Uz9wtIym6YBWNdaNyyIh95Q8a67s
 nLyKM3Z0E13rRcqycvxbyYSxQUrik=
X-Gm-Gg: Acq92OG1IY77PQ8b0WuBB9ShAP4GIvMScZklFs8sVSXfIqlQ0VKog8INZpAF7+3kGFd
 GWV7Q9wxVv8BgPvArYagU4iR3M2WwzDO7w//hrFwF4R5/NtIrW3Hxpv8EAbKK4zOKYPZmsaNPoN
 xJ+4/jNe9mahUZ70oHziKfC5qSPa7gPOE1IZy77bRsUN/WyXWF5H3qWZzDiQIxxlX60a6ZLJ0OH
 0cYElM6qa9RIIWbyYcdgNnSL11sPqP2wqzGT0TWKorRoSZJrKbcKSFQ4ZeWn3Er9foWsrdexcnw
 Ph40
X-Received: by 2002:a2e:bd17:0:b0:38e:90b9:ce98 with SMTP id
 38308e7fff4ca-395d8bd2fa5mr91844951fa.6.1779961656596; 
 Thu, 28 May 2026 02:47:36 -0700 (PDT)
X-Received: by 2002:a2e:bd17:0:b0:38e:90b9:ce98 with SMTP id
 38308e7fff4ca-395d8bd2fa5mr91844851fa.6.1779961656034; Thu, 28 May 2026
 02:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260528084717.1754057-1-thomas@monjalon.net>
In-Reply-To: <20260528084717.1754057-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 28 May 2026 11:47:23 +0200
X-Gm-Features: AVHnY4Lhb0qnzO9ajwlIWpHONCHtAZUpI7S_ApENtRGpaAUmrp978D-c-ZxTJzs
Message-ID: <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
Subject: Re: [PATCH] net/sxe2: fix 32-bit SSE build
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Jie Liu <liujie5@linkdatatechnology.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fAbZbM_LV-GZR_SZLgIFf8Cf0OlbH-x11ObfapIOFa8_1779961657
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

On Thu, 28 May 2026 at 10:47, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> Seen in OBS on i586 Debian:
>
> from ../drivers/net/sxe2/sxe2_txrx_vec_sse.c:5:
>         In function =E2=80=98_mm_loadu_si128=E2=80=99,
>                 inlined from =E2=80=98rte_memcpy=E2=80=99
>                 inlined from =E2=80=98sxe2_rx_pkts_refactor=E2=80=99
>                         at ../drivers/net/sxe2/sxe2_txrx_vec_common.h:233=
:2:
>         /usr/lib/gcc/i686-linux-gnu/12/include/emmintrin.h:703:10: error:
>         array subscript 8 is outside array bounds of =E2=80=98struct rte_=
mbuf *[32]=E2=80=99
>
> The important options to reproduce are "-m32 -O2 -march=3Dcorei7".
>
> In 32-bit build the pointer array done_pkts[32] is smaller:
>         32 * 4 =3D 128 bytes
> so an SSE access  would be outside the bound.
>
> The libc memcpy does not trigger such warning
> and is a good choice to copy an array of pointers.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

I reproduced and checked Debian 13 32 bits build with OBS.
Tested-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

