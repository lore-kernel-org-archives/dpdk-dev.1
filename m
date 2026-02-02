Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC8E73141
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 07:55:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 519BB4066B;
	Mon,  2 Feb 2026 08:55:34 +0100 (CET)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) by mails.dpdk.org (Postfix) with ESMTP id 3ADBF40285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 08:55:33 +0100 (CET)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-948aec218a2so259808241.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 23:55:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770018932; cv=none;
 d=google.com; s=arc-20240605;
 b=AUqcg++cB/MGsBY22x7IRR3J+Xda1wlVuVEK8pQeBSoi936mzQ/1g8EHE9lK5kEamH
 6ZDI8Ann+6yZKCMCslr8pFinbytC2i94wsaCKyB9oRPenFvGIMFQDQqtlt9BCejcHkBR
 nlpFANFCLJDgK3k/QLuP04uMedEsyi4EB6LbbX1yFAvCCCz11zKtlfhE2p6C5CNuwhav
 X5PwkMsPT8OLifxPE1Ils8FPC5JXwwZZh4y5oJnPO/BJxKZIZ/LPWpw9TvmCbZlmZCiH
 1wuS59vSfhoNqZtf3z0GdR3mOvIAo6jTHUQRZ01ernGoqfLWD6siUgjG8/MLBs/VcVZJ
 pWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DJU27YcRcs/YV9Dj7dhjxS8Bz4V78D5DxQGkY9Lnaog=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=UFuRCicZM6qu+f3YpiXyEz8nLK7lEMPGGB91Pdh/9VdEcmFzoBgXD24OjWUQku8pCU
 aQ8LOR63NFmF0MBS+pLWeWOJq7U1q2sdViUH1qc+UEWpmBufUZB9IOp8BbtpAnq8itgm
 lpMjQdzHOdBcknRufvj0hmqTMiqaMJGthVZ3TmbePMhbEdg1JJQml4pxhETzqcnrkZhc
 eg2/K2fyYN0zoAo7T/YC2Zfp4DN6ArScrbKi8xpBqZ4HJZjVHOhFHGAqdfa0kZz8gf5F
 QOa4ryck5JXq1Fri7Ysm37mzbnu6fbAZbWGKVgN2JQ2S5ucRcnc8ngT1UDRaSkuXEBnw
 D6yQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770018932; x=1770623732; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DJU27YcRcs/YV9Dj7dhjxS8Bz4V78D5DxQGkY9Lnaog=;
 b=J7s9Bafetk5IMTtAw/VZ05/DQtqt8MtbVbDIVPNG6UyBqCBAJETqB45S+xG/yFAdWG
 yfOFEt0r+F80LewyYV3s2LYDNKqzDnOGjXoKFt9tUkgakpIYmqMNrkHbydF9QS6t6EL9
 NV+VSjQM8Rz0nuOFGtoMvN5sbkmPr4F75C91oozD6nCkmiJRY4GVr1J233ARhiZfH+aC
 nNhW+Hk1Dv3Mpc4vIohim2DGabvE+XfEIRm5S3yopRIrCQ2a5RO86U3DSbX2uMLQTGIA
 7cnCvzsTigWPm4m2ywOZOPOcXJPSc9kxqic6jXRLdEZy2SU0CsHqER/OIe551VqsRNtP
 x9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018932; x=1770623732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJU27YcRcs/YV9Dj7dhjxS8Bz4V78D5DxQGkY9Lnaog=;
 b=GWkEePr7XAgPaORRriu74BjeuiJ5gwSS470Z28RqP7/L/8Z3ZgdyPlTPQB8IJEKT+3
 YHnxgEbgsQ+SRFSPG+0gqg3XtYpsc0FVYHKDaNt5+jq/nyiFnTrjMVHj40THxhKdl6yv
 r8NaGUibf76cct5Ibnv3IYU3KFbsNMaPP25IYfz+QrLnMZ5l6c1UwsSoG3dbsMfG09DJ
 3juxI+riu7qJBSww18m02lmi/84odmcA2U8MWkLvihxeGZl7lN7wGSndnScZQ086jxPB
 Q8WrOFTCzreMNo/7wMrVK75hPQ+bGe+bj4Z95LF6J2JLe2v3I9yn7GwM0lJVYGDQyPwS
 98Vw==
X-Gm-Message-State: AOJu0Yyk6BlAa0Htyq5fICjZXJtoNM3rlwUaM9Wv59oapcvAxKCIufI1
 VMHmxomcNNGTfpqqdlKvRfKgRcZ7ivVPqv1uDe08cSIw6AjxpNjcgpN8EiKjZARvQ5kkPHbDG8p
 mX07rU2EP86HxMGUuP+o2kxQdVuZwCug=
X-Gm-Gg: AZuq6aINB/0+A77TlKVKsR2qfZXoGfieCZVqhFRcj7mDXj4rAGx5Pr9IWyZHJg++aAM
 rzX7DY0Whymy2HVZ3mqr8tPHcDQw2k7LAv6Myumm23NJrktsm8RNhXzDq97hoTaswIknosQWPzo
 fMczBuBOgArLxX3M8R2jegmBRG+NuVzdXEn7DiL+Xk1KtCLFv7k6qgWQ2AyyEiqttyne0kZ/Hc5
 CF+rQUaDYjIQPm3UWTM4wPiedPaI62JUpaQey4H3cOlj1DPgbU2g1AQQbs+sfIeHjaRVAA=
X-Received: by 2002:a67:ead2:0:b0:5f8:e2c7:a3f2 with SMTP id
 ada2fe7eead31-5f8e874ea46mr1865618137.0.1770018932458; Sun, 01 Feb 2026
 23:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20260128191032.78916-5-scott.k.mitch1@gmail.com>
 <697a8646.df0a0220.20404.ed58@mx.google.com>
In-Reply-To: <697a8646.df0a0220.20404.ed58@mx.google.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 23:55:21 -0800
X-Gm-Features: AZwV_QjZgK7hRy9pDOJxtXO1xxMbuY5RLGQHxjeBs9pwj763iNSTXeVWM860KZc
Message-ID: <CAFn2buADZwWCy0HX3sVnrvwSXri1jG2LXSu7XwWc_R_5rrjCRw@mail.gmail.com>
Subject: Re: [REVIEW] net/af_packet: software checksum
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

Will resolve comments in v4.

Also I've noticed the AI feedback often has paragraphs that end with
"this is fine". Is there any way to suppress those as they take time
to read/parse/understand?

> ## Patch 3/4: net/af_packet: tx poll control
> **Warning: Uninitialized struct pollfd when txpollnotrdy is false**
> ```c
>         if (pkt_q->txpollnotrdy) {
>                 memset(&pfd, 0, sizeof(pfd));
>                 ...
>         }
> ```
> If `txpollnotrdy` is false, `pfd` is uninitialized but referenced later in the `poll()` call. This is a potential bug - the poll path won't be taken when `txpollnotrdy` is false, but the compiler may still warn.

False positive. pfd is never used if pkt_q->txpollnotrdy is false (the
conditions below short circuits.
