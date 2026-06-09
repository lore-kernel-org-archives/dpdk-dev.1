Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF2CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D701402BE;
	Tue,  9 Jun 2026 11:18:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A274B4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780996736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wfxCfc56W6UUNJve/iOofEjGFzhaYRpMLvtYPC30mtw=;
 b=CWtA0Nug68L5clIt2HO/5KCBKU5ZjhuhXkMErXOkxIQJT2/7PMBTYK5k6idY6j+thdlUYX
 3HzfKekyQimGNRn3vKs86DOQkbnYTsxgEYSVFTFD7ThhWYPqnZuHUetPGAV4l0JUMPFi/r
 CPDxBxQXxriN4CmuA6IixtrPOCw0K9I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80--873ebFmPc6SvEANNM3hZg-1; Tue, 09 Jun 2026 05:18:54 -0400
X-MC-Unique: -873ebFmPc6SvEANNM3hZg-1
X-Mimecast-MFC-AGG-ID: -873ebFmPc6SvEANNM3hZg_1780996733
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa65733812so3042651e87.2
 for <dev@dpdk.org>; Tue, 09 Jun 2026 02:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780996733; x=1781601533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfxCfc56W6UUNJve/iOofEjGFzhaYRpMLvtYPC30mtw=;
 b=jWdj/hUeFPun7zDbWBlxzCh5s3OKp1eznykESvHWwBSSuotIWV7y9thYUwXV5jT2uv
 aqPQ7WZ5DuB30xpwGmls5fhhvfwi+LK74DFmp/LaGe5U+WbMwYl1uHcVPYWjwqAW6Bbk
 zd4FtMUyTtXCgO2BgN+MBEIafp/Rw1+pslmfGaEgeJXDbOBd8IpyB6luDkFvVPzRf0kS
 psqVbfbzc5/ARUrdm8YBQhZ1ja8pX/ooe7CbhJhq7+4ciajqxyEp733JLhgJ05+PCqDv
 ogpX2Qrvu9pYW9kSbSrTVbGOt8ImPPr4CWHue9MrYsQTOGmJy6vtQD2glIQ2PJl3ZElu
 zZuA==
X-Gm-Message-State: AOJu0YwtYvgxShpTIxd15BNUlQtvZwas4ryPpaFpETD8oKQ8WiW5tHem
 BMluDG/rubfiENfhTAl8ESZU8cBb00ht6TS5e/ndlCM9wGYp/hIzqadOwj09VrAhiyzoR45Xyp7
 qlmkutZQWI5D8ordbCEX0h96a0+itpzE1l9mCT72gdVwH1D4qHOcPq/7/fR5gD5105J5mbFljhh
 hr552AXlk9xbMLHck6NV15BgCRKHDaKw==
X-Gm-Gg: Acq92OHrqgafWxSNTos8OkQpQfZFqnIYjwDjjePyM5soPlZvVao8z0xTT/Urs51CvWw
 ZMa3UqwymGbAw2W7YUcvaU5jR9Q1wUoUn9b7zNvWC09SPfdP/ewFt6LgfEFcJHf24PL9fWJ8/yc
 PzLkFARrT2yNmkleGP8CX9iR12IBB0P69Y+kdtdic6njUKn0oBugvEMQTBwBraD1c2oTFYVZqyD
 ks10eSQWwHcqdduXmGAcXd6Q2N5TxF5H8g5/Zdk3a76+P004d5O5WhctDWjwHXQJAthGeOcg4Uu
 59Jg
X-Received: by 2002:a05:6512:3194:b0:5aa:8822:f27e with SMTP id
 2adb3069b0e04-5aa8822f2b3mr6191332e87.46.1780996732765; 
 Tue, 09 Jun 2026 02:18:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3194:b0:5aa:8822:f27e with SMTP id
 2adb3069b0e04-5aa8822f2b3mr6191308e87.46.1780996732098; Tue, 09 Jun 2026
 02:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260607150418.30885-1-stephen@networkplumber.org>
In-Reply-To: <20260607150418.30885-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 11:18:40 +0200
X-Gm-Features: AVVi8CdodjY99OyP_KypQTGV75BKJg3YjkHMkRjjzdYb9DQwoRKdn0HnX27YI-A
Message-ID: <CAJFAV8wBPKNErY246875FHEDbAHuKNfquYuzWbE62LQQjePq8A@mail.gmail.com>
Subject: Re: [PATCH] eal: add destructor to unregister tailq on unload
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Neil Horman <nhorman@tuxdriver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8oKgm-smfDvWAuVSrJukdrtTV812afJ88Z2EU1Hm6SA_1780996733
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 7 Jun 2026 at 17:04, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Libraries that use EAL_REGISTER_TAILQ insert a pointer to a static
> struct rte_tailq_elem into the process-local tailq list via a
> constructor, but have no matching destructor. When such a library
> is loaded as a dependency of a plugin via dlopen() and later
> unloaded via dlclose(), the list retains a dangling pointer to the
> now-unmapped static. Reloading the plugin crashes in
> rte_eal_tailq_local_register() when it traverses the stale entry.
>
> Add rte_eal_tailq_unregister() and extend the EAL_REGISTER_TAILQ
> macro to emit an RTE_FINI destructor alongside the existing
> RTE_INIT constructor. Every library that uses the macro
> automatically gets both sides; no per-library changes are needed.
>
> Bugzilla ID: 1081
> Fixes: 873a61c7526b ("tailq: introduce dynamic register system")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/eal_common_tailqs.c |  8 ++++++++
>  lib/eal/include/rte_tailq.h        | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
> index c581f43b6f..714f91d0ec 100644
> --- a/lib/eal/common/eal_common_tailqs.c
> +++ b/lib/eal/common/eal_common_tailqs.c
> @@ -148,6 +148,14 @@ rte_eal_tailq_register(struct rte_tailq_elem *t)
>         return -1;
>  }
>
> +RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)
> +void
> +rte_eal_tailq_unregister(struct rte_tailq_elem *t)
> +{
> +       TAILQ_REMOVE(&rte_tailq_elem_head, t, next);
> +       t->head = NULL;
> +}

This cleans up the local storage which is good, but it leaves an entry
reserved in the mcfg->tailq_head[] array.


-- 
David Marchand

