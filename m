Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF7CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A7194065D;
	Tue, 16 Jun 2026 10:06:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 42966402DB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781597170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8OpEiDVGP3Y343ITPJAkqEGLMSDsk8MauGWKCO+QHA=;
 b=FJ9L0JIN8nTrMjpZepnXCtR5trmdIJlszyaQDm8J4VsD9gwQyKQngXBjNBd93NBbvmJcCH
 nSL60uEFUmvThBMgYls5z3iEWn9p2DY+Z9Z8wb5dEo4VbRHlOA1uOxFm9rxg3m5ogie1z3
 hqUU0YoDifCavBR+mKGlULmGz4gYsSU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-XIa3vJw_OXKcStzT5-2Deg-1; Tue, 16 Jun 2026 04:06:08 -0400
X-MC-Unique: XIa3vJw_OXKcStzT5-2Deg-1
X-Mimecast-MFC-AGG-ID: XIa3vJw_OXKcStzT5-2Deg_1781597167
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-396a5b0307cso17941011fa.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 01:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781597167; x=1782201967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8OpEiDVGP3Y343ITPJAkqEGLMSDsk8MauGWKCO+QHA=;
 b=EmHH1vSi6Jkj1Q/J77z+QSThAZkPkrHFpzEj6q3vQ8uDDW8fUARQsn6j+SBvQo6rs0
 eojtG+RDX3RNWYyb8U26toRaPhJ2U6Ly0MKiod/ecdI1KDkHVr2XHOetfNpfUhvKEuT2
 ea0qtUMiWZ/BbIo7VP4kciZoEloRIx6IzluMzpjqkXz0XdipgZIChazff0Io3fs40qh8
 M/iq8dvkC+yR207ZYF43I5taCr9RXvb676W9goPD7UfKyy0WwiR3zkttQQa5Ko0t/CwP
 UmE0qVz+OZS46VteG7kcK2XQejQe8X095sCxdBzm5QNZNo+YL9XXELSRAos+19e0ajdf
 fP4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SH/329zhyJpsMrLro2rOlPlSLNiUsnxbIBJ+2THkOVjh1XOr/kKmJKn46wLJX3g/Nkrc=@dpdk.org
X-Gm-Message-State: AOJu0Ywt4sMOxg1S1yRNWEdjp+NQI5UHv0glAKEa3z8rBu573JmRfUBb
 kcKFvHt9SDzGoFGo/5G9QuvoAzUgbmcta6rCXQvhbz7D+0+Y7LiLIiXN9rU7+R20BkvdUFBYxz4
 XvFG6I1JdZlB4+QUzDO7UFETwWSsFesmT8hEmEjcornQPeaU3HOBMo2zOHB8xggIX8XXmWk2XtT
 gveiMGRIdTvBEAjUg0Y/0=
X-Gm-Gg: Acq92OGhzOxUdDHIBiTKhqTYV+quCDz+qAEze0mjez3/haWnMiiupRAH/gFtaDb0ezh
 5yajtOmO8QpELyHMYWU0GXQB/8CkrlDHtXA2C6heHVs+Vg3HaScrzjyn4nlwGzM9A5FCg/2oyqQ
 gukyFGLE1zLuOf5aVaVZ2+xnsHxoejyJ3p31sj2/6NIHzvwiptAAK8hVbNXk3YfUAvkb5Snszkw
 2U1QwOTI5dS6zMqPavcD/q3EY0wN++peZ09jHGQKTntdY9/Peg/0K0Eq1ZS3a7WsYDQbw==
X-Received: by 2002:a2e:bd8b:0:b0:38e:83bc:1573 with SMTP id
 38308e7fff4ca-3995c8759e6mr8622821fa.24.1781597167001; 
 Tue, 16 Jun 2026 01:06:07 -0700 (PDT)
X-Received: by 2002:a2e:bd8b:0:b0:38e:83bc:1573 with SMTP id
 38308e7fff4ca-3995c8759e6mr8622671fa.24.1781597166401; Tue, 16 Jun 2026
 01:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-6-maxime@leroys.fr>
In-Reply-To: <20260611154926.392670-6-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 10:05:54 +0200
X-Gm-Features: AVVi8CfFlBXOBaAX80DpAB5w77pluhqdIwC6DAb2Sx-Y8tbAKHrgX1Oni1aZoXg
Message-ID: <CAJFAV8z5gLWxTcGiYYiZvkZUfe_YxgRKAx-UfU02FZFpsqN0+g@mail.gmail.com>
Subject: Re: [PATCH 5/9] net/dpaa2: support Rx queue interrupts
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tJUL61zdC4gne-lWzS4JLqeKlf0KhEM73febnX6e38g_1781597167
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

On Thu, 11 Jun 2026 at 17:51, Maxime Leroy <maxime@leroys.fr> wrote:
> diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
> index 84853924e7..947415363a 100644
> --- a/drivers/bus/fslmc/qbman/qbman_portal.c
> +++ b/drivers/bus/fslmc/qbman/qbman_portal.c
> @@ -448,6 +448,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
>         return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_IIR);
>  }
>
> +RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_set_inhibit)
>  void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)

qbman_swp_interrupt_set_inhibit is not declared as __rte_internal.

>  {
>         qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_IIR,


-- 
David Marchand

