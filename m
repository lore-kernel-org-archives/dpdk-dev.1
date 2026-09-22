Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3724BC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F0342D26;
	Tue, 22 Sep 2026 18:09:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 20C9E4278B
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790093362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqBUGA6KdzSEuVpeQKqMT5ZM6mKHFKmAZtnWdk7WqWs=;
 b=EjSpz1hyk000U3nRRel2Y/hDenfOg7M4V0e2ySK0oxEjpM1caTkzfM1WBBH9N9WGN1Q8d+
 UQbXAFXnnoSUAx4Fkkgc6NGU+QZR5Z7xOavif9uQ/9qUwfAkHC0vyn1nsTWKG5WXS6lvcs
 hqGzopiOQhND7m3PEd0d5BDMeUDn+2s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-mpC5Jy9SM--vbSEPkbVv4g-1; Tue, 22 Sep 2026 12:09:21 -0400
X-MC-Unique: mpC5Jy9SM--vbSEPkbVv4g-1
X-Mimecast-MFC-AGG-ID: mpC5Jy9SM--vbSEPkbVv4g_1790093360
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39d93d95a21so36230651fa.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 09:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790093359; x=1790698159;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tqBUGA6KdzSEuVpeQKqMT5ZM6mKHFKmAZtnWdk7WqWs=;
 b=x4xorBEOBQJ+38mk4Vqn4rApKTyjMJksiqdTOWSEsqgHEdnTu1Sz4FH+Oas1Zpadz/
 c2QmMNoY1gHT0GhS5DUy7tr5U+m0A7vQrafRHFT6ubcXeAkg+MKD45/DUMt6cebW8tLp
 +5UO5q/YbxmRHgp23hGLi/Itb9Vl+t6MIIW1UQWc/27/J7v+HyKjjwKqnWUK3kVnJzpl
 JgWmg4ORZYOlV3MWUjGPH9Tgnfkbu/RzYWAE4W9E1Q0lUuoWDjxnEakoeLeQQ6HzRJGk
 UBgpWu3iCkxYiN6YyY59xfhhL68cEFgMwJgJpkKYEqge6yb4z1ayPPLFZH1Eijbpl3DF
 zxGg==
X-Gm-Message-State: AFuF++l2jtPhQF/pIwDmfNfMC52Kc6+W2KaIy81tzFj0e0Krk7y5yNB/
 AtRK3yqKTTpDf8jUpRqW42jn/qmzLjN1EfZkxp5rBveW2a1KVvtpjwrvVD1hIRxdeJxbHMpfgER
 f4FSfrsULuKmEu6M/QpntBHV5axO3bCxIWt4lC9BDRSqaUe9CIoDRmSGJfqIIzpfdhtBnsngJ+F
 yRcl+OSEFKgHr+pAxG29A=
X-Gm-Gg: AYBFou3z5X6R41wdTIO/0fqndu9FtKFeG7ep5kGoySqv8l8tdt61AWtkzW51Gd6+QCq
 e/KD+/XgdZvIyhShrT9/oYjPs5j47OF90E4bVNhdvYmqit8sRKUEWwIFlh5o0Id47saRrckyh9U
 olE+C+6SMOqOV4Pb85OyiVHWzQHnzCEKw6yoM0uqorVp7nv2v/Xm4VFBssQPtPKB68U5Whs8XW7
 w2+8UAf72rIK9dLDrF1pBDTd4tCmCQcOKnPIDffSj7t1Rkb
X-Received: by 2002:a05:6512:2304:b0:5b6:1a7c:fd95 with SMTP id
 2adb3069b0e04-5b8c1972db1mr5813856e87.59.1790093359574; 
 Tue, 22 Sep 2026 09:09:19 -0700 (PDT)
X-Received: by 2002:a05:6512:2304:b0:5b6:1a7c:fd95 with SMTP id
 2adb3069b0e04-5b8c1972db1mr5813819e87.59.1790093358871; Tue, 22 Sep 2026
 09:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260623141930.704771-1-bruce.richardson@intel.com>
 <20260817134432.1206297-1-bruce.richardson@intel.com>
In-Reply-To: <20260817134432.1206297-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 22 Sep 2026 18:09:06 +0200
X-Gm-Features: AcwNN1WH4pVKJ8AtDwe0v29iC2GfUY3CvXTRY6o9s0ppQkiwNt6OhW9Qny5gDvQ
Message-ID: <CAJFAV8xYLWxWthUXs3be1hTfs7RsPsi+PMoSFkCnNJ_HSksr5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] lib: remove use of strncpy
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b6jUZnqP5d2cGnHDy1aCGReuYRt4e_sUyCQYRfSdIwU_1790093360
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

On Mon, 17 Aug 2026 at 15:44, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Taking a lead from the kernel, which has just finished a multi-year
> effort to remove use of strncpy[1], rework DPDK to remove use of the
> same function. This series removes all remaining uses of strncpy
> in lib directory.
>
> [1] https://www.phoronix.com/news/Linux-7.2-Drops-strncpy
>
> V2: resubmit for 26.11, applying the series-reviewed-by as individual
>     per-patch tags.
>
> Bruce Richardson (3):
>   ethdev: remove use of strncpy
>   eventdev: improve bounds checks for names in adapter create
>   vhost: remove use of strncpy
>
>  lib/ethdev/ethdev_driver.c              |  7 ++++++-
>  lib/eventdev/rte_event_eth_tx_adapter.c |  4 ++--
>  lib/vhost/socket.c                      |  4 +---
>  lib/vhost/vduse.c                       |  2 +-
>  lib/vhost/vhost.c                       | 12 +++---------
>  lib/vhost/vhost.h                       |  2 +-
>  6 files changed, 14 insertions(+), 17 deletions(-)

Series applied.

Thanks for the cleanup Bruce.


-- 
David Marchand

