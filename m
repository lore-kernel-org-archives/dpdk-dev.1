Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F5BC531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 07:31:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EC1402A7;
	Fri, 24 Jul 2026 09:31:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 290284029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784878296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoiAyCb4zxxCgIoCvpWk6Z3CSvY2632JoAIuDtA2m7k=;
 b=R/xVJQDIi3iyLTTLm3dZMTB5+GbuXgx2Pw5ux7IkPCsbVIOa6xPecFFA6yZIowhJOud/4Y
 vSm5HDZnniyFOzsXUN9yiLnvp7pC+J+nvlxE++hZRRVxiDJe17cDaFDUSCWXIFNsO/w1E5
 /5WV0nZc4CbAYHr89Am1DMaZkweV/T4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-op13CLRFPrmGCTFUNaxR8Q-1; Fri, 24 Jul 2026 03:31:34 -0400
X-MC-Unique: op13CLRFPrmGCTFUNaxR8Q-1
X-Mimecast-MFC-AGG-ID: op13CLRFPrmGCTFUNaxR8Q_1784878293
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39b1a8b8bb1so791841fa.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 00:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878293; x=1785483093;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yoiAyCb4zxxCgIoCvpWk6Z3CSvY2632JoAIuDtA2m7k=;
 b=PRYRd6F0RkN9Uv3Lo95fO4R4Z8CBFOxWZ7hEy2D2L7lUZGW3scAJxUCGimk07SvHs1
 8lryezq2YqzkWjsbx03D++mIRAW3WUEmJ10BxNUS/tJHBQN4aJllaJ3D3/uHO4aoSO82
 Xn20sOuGIVy1durSsHmma5wNurlHxMnUo55Z2w+ODqoovJroWJovvlnV8MCMPmCFKVUV
 76HrJvIlZf+JVkDNwufzTKsKEaL363B3zcNQGD+CeDvkH3r8t5ZgRb7dc8EoPcxYW41D
 JhZ9GGD5EMtFiZmhuA9AjPmV0V6s0cXtNFt3nGQOcSDC0z88JaL9beAPwSR6eWkpe4kV
 KDOQ==
X-Gm-Message-State: AOJu0YzR0nhvfEHgcYqKYa8gKP5WH2kWinRpSn2Y66FZ9+sng+BWh2C2
 GU3sa3GPxm/TeZC58dAD2N9S9rZfZu2Ijz+fQRX6cWVFUQ+Nw62+AbpKcFU3eyD6RdDBZUfwQnQ
 Od6hM/GXg2Ep6Lbby8w464yIm8gFQuYseZ/tVjY4W2O3tiihZDuOrx1hRYbHxVJqXN8xIStSlAu
 nne9bsyW/8C5riUuRVkTk=
X-Gm-Gg: AR+sD11TgJHUwXmLGqSFNxD+uHTijgupF5V5qX57AtI0zBIZ/Pz8E/XU/MfEpqs+u9u
 nhhnSosbtb/kFbDqlSSzRlHMtl4ahiHdJMM5rf0EInTBY2ADEodGtET5Djvh7ookMiDTr5xbOUZ
 R5zD6iXkpJfzG0OiYUbq5e+0kLyh/TsLb+gL8QqU1aX+TRge+YReQD0jFQ0lfuXvgdmDUeFZOf3
 l0eUaaZQ57N+GYyjCdLtPP03buNjGdgGSk8suVHnLEQNe9v
X-Received: by 2002:a2e:ab89:0:b0:39c:7859:a2d8 with SMTP id
 38308e7fff4ca-39f07c9b36bmr13350931fa.27.1784878293311; 
 Fri, 24 Jul 2026 00:31:33 -0700 (PDT)
X-Received: by 2002:a2e:ab89:0:b0:39c:7859:a2d8 with SMTP id
 38308e7fff4ca-39f07c9b36bmr13350861fa.27.1784878292781; Fri, 24 Jul 2026
 00:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <20260723202936.378793-6-stephen@networkplumber.org>
In-Reply-To: <20260723202936.378793-6-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 09:31:21 +0200
X-Gm-Features: AUfX_mxwzVVjPoOD-tPVc7cQdCis3aRZvRElp5J-xvJhZyVJLcp7N6k9K32H0HI
Message-ID: <CAJFAV8zH1jA+c-CDMvJXMpbmLDywcgRWKyaL=XfrLa67EuYuNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] net/e1000: remove queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8fx7TuUl9lF3L6nBeu05-vq8UvMMErTKJp-pRXhL4H4_1784878293
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

On Thu, 23 Jul 2026 at 22:30, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> @@ -2070,19 +2060,11 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
>         /* Get per-queue statuses */
>         if (qstats) {
>                 for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
> -                       /* GET TX queue statuses */
> -                       int map_id = igc->txq_stats_map[i];
> -                       if (map_id >= 0) {
> -                               qstats->q_opackets[map_id] += queue_stats->pqgptc[i];
> -                               qstats->q_obytes[map_id] += queue_stats->pqgotc[i];
> -                       }
> -                       /* Get RX queue statuses */
> -                       map_id = igc->rxq_stats_map[i];
> -                       if (map_id >= 0) {
> -                               qstats->q_ipackets[map_id] += queue_stats->pqgprc[i];
> -                               qstats->q_ibytes[map_id] += queue_stats->pqgorc[i];
> -                               qstats->q_errors[map_id] += queue_stats->rqdpc[i];
> -                       }
> +                       qstats->q_opackets[i] += queue_stats->pqgptc[i];
> +                       qstats->q_obytes[i] += queue_stats->pqgotc[i];
> +                       qstats->q_ipackets[i] += queue_stats->pqgprc[i];
> +                       qstats->q_ibytes[i] += queue_stats->pqgorc[i];
> +                       qstats->q_errors[i] += queue_stats->rqdpc[i];
>                 }
>         }
>

I suppose this is harmless.. but strange to read all queues regardless
of what has been configured.


-- 
David Marchand

