Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48156F94CB3
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 21:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 645DD4028F;
	Tue, 21 Apr 2026 23:57:00 +0200 (CEST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id EB22840144
 for <dev@dpdk.org>; Tue, 21 Apr 2026 23:56:58 +0200 (CEST)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so3649693fac.3
 for <dev@dpdk.org>; Tue, 21 Apr 2026 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776808618;
 x=1777413418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJrukwb/pXnFwbd37Lbbv2KuzyAvmQVJRXd42gq/dHI=;
 b=XJ4gEFjWlCXqNaBRtQgs0Gruq8MmgIms+Y+6XgAMKxmIvYsaV2tDWyEdq0QNM9hI/f
 c4MuSb06quvvZ66geq/TgENQ6EPVUpUDbwAWanoSBCZCPSvXyKdt5ETghx6B63nIzbNg
 9YOvHp7iCiUtPs0gc5l2IYkmdv04M/nk83EF7Xi1S8JTVPzHoj/gwpwcdrah/G7GFylA
 Uy+MrgtsXYJd+0Z2dq18pqynXkbVsjumztKySg3WmwxcUu/sIMcO0QMjfsckjgHkxFFq
 B3+PAwmFULOlokYVN/0DOPzrSj2ZAfyldnTg14TFSLLmtSSi4KiOvZeD+Nk2z/aE2Mmf
 F0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808618; x=1777413418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VJrukwb/pXnFwbd37Lbbv2KuzyAvmQVJRXd42gq/dHI=;
 b=KwB93uSy7sdkOSFONpWvNQqRLvreHdXBTTP4rsPoqAULGbCOUHp0RPblK68olDLNHQ
 VkLLUZbfj2j9DlwqZHTfrGMVntjeryl6EWPRZ3ATydMQICBquoL2xdaWhkJS/R7eLm6M
 P9DpB75J+HT3ujEcNj+thAac4x3MKn45IpDNxXvxZcL7PcA6awp6ZbfWMu5Qi/PdCx/J
 2LX950H9he58xCzYoGl9vMstvhg+c3kVHehNmykCoE8VvUBSivdx3qdab0SYeZBDcwis
 hEsAsMsFukwZ6DYUQ+x/3A6ABSzM7tL/+e2Js3A+evqtozylF/CraEtvA2A4iquYebbz
 2cOw==
X-Gm-Message-State: AOJu0YyU6haSLiQ1XA+BAp6YDv7+4rJX5Zahea6LyO3VM8jmGO4mct6r
 6vh6RSiqZHxuXgckCz1jV/PjqSaSHX81R7J6Dm9LskhcF6ZCwMGMgBH5Tqe0Sh1NnJc=
X-Gm-Gg: AeBDies910ZKDD3CBAbJlvAG0oRXaq9VwNIxbpkxF9CrcWK+oIK3F+HHVRpGtH27fmG
 /lVAAh4eSFtsLFnq+5WTTzHKxHudfSa1gFFnYemn7Jwd58kukn7vsblkvrtFeiMVUjxiICLF+26
 m+G+jbojv6kMM5FERI82+qynhd8dWqQONWj8AerRYUROnL0NOlCeUp1zT0b/jI1TkwmfhLT5iYI
 gG4sDclSJ7pBfCv6nakWw09Mn8+MSVpYy4oEE4rnbioTDrGmHJp1O05rnqUrYChaq9IX3IE87w7
 8LpZvl2o7PQuHJUT50+tiX/8yWm9vPsKVKDpqAJlXE1APZJF2EkD9mPJ8Ue9VoIdIJJygA+Z2sN
 23s6W6bkHG+jftsltwbkccGKtbRIOcr5pNp1e3m7tf4fpJHtr9+mHXId/j2iFTpNA72Lq0Y0gkI
 9zf3XH8guc4XW4RngPbCCXuyRP8AjfS/FlM21z/3JKvUaXCA==
X-Received: by 2002:a05:6870:b30f:b0:423:994:9b76 with SMTP id
 586e51a60fabf-42aded1de0fmr11728830fac.24.1776808617951; 
 Tue, 21 Apr 2026 14:56:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2e8esm13481403fac.10.2026.04.21.14.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 14:56:57 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:56:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH dpdk] net/mlx5: add option to reduce Tx datapath
 compilation time
Message-ID: <20260421145654.6ee9715b@phoenix.local>
In-Reply-To: <20260421212356.573976-1-rjarry@redhat.com>
References: <20260421212356.573976-1-rjarry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 21 Apr 2026 23:23:55 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> The mlx5 Tx datapath compiles 42 variants of the burst function, each
> a specialization of mlx5_tx_burst_tmpl() with a different combination
> of offload flags. The compiler must instantiate and optimize the entire
> 3800+ line template for every variant, which dominates build time for
> all the code base.

PS: I am going to reject any new drivers that do this kind of nonsense.
The cnxk and mlx5 drivers are setting a bad precedent.
