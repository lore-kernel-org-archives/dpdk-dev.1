Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2816FC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 557A540272;
	Wed, 14 Oct 2026 19:33:18 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 9796440144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:33:17 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3a80d1c98f5so495169a91.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791999196;
 x=1792603996; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l+oDtMZvIdrlk+/b2ZBgjblxfGyxhnw1LYtd5Btzsxg=;
 b=AnRQkl0EzK0mgH9LGEzljdivmoXW0qmCtbnhwn2UYMEdXSvhgTzzn8QtkYOPD3Jsjt
 6BD6mbCgOAbOPbxljvuVC5hheMDkHhLsM+RIB+oeGleWCUYozkA2HuPvUbI/IOw7tlbw
 5yDhoIbH+KMxumeOcdQY4JrCIrLlCro627hd+nXYXHmleXdDaBNIVjluYDMMK97+VszT
 /Tb8juxPoaPOzRyww1ml30X6DB3eXSmcwa5m9ivv7HrxXsCPrm1j2AggHABru3O8FnM9
 zynaxVGzwpQOLHSHEzkmrPFuflxpHhL7qu0MWl5v53adWvutlVA6mPoixW9SRm8nSG+r
 a4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791999196; x=1792603996;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l+oDtMZvIdrlk+/b2ZBgjblxfGyxhnw1LYtd5Btzsxg=;
 b=2SVOkWy/5cnbXZaGgAq/lTfkKYTtzrRHtMP3Z3FciOS9Mp1OCOyam/gaq1293Rt4l+
 LieUsPBa5UnO6A5CaqdbMr9IVquNvcJaiq7Jb4nQlHjnQhWzD1jBjSVrVf4C0DqXV6Af
 z00nA8oCdNrfSPY86O5Nk7xLTwX6ql61B6v+dTVQyexMSu6X3+r8lvMwTshHPq+5T/OH
 f5nAJRD3qkRKdOW6lSXcY4sqLT6Lw/RlpJ+X7ckvyQLiTQZwkNGYOT/F+/mhkLFfgbvm
 +bqs0xvQE4R6gTAX85i8vLaiY3kJCNf6XCfWydzpZ61IDER1wfbIoXQoBVbHvzBxQ1mc
 nLGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYwkPfKswxCS+C2EYnMhY2NQLxELZaV7bW9xRG5Iu7OzqpPxwZdwqqw2PsUO5uGtei4H0=@dpdk.org
X-Gm-Message-State: AFq9FYLSfr7B55UL46Z+bHEr8F7vw7aSXEe30NjFv7zYvcb8x0ueQQb/
 sz8zMWhtRAguJQp3v8XvR/KzetYk5W1FkXwm/funbIscLBOIQlgYTuWnid2CEPwZ4EY=
X-Gm-Gg: AYBFou04B2d3rmQ9Olgfd/zBjedL2ALKTh1Z0TmebmGVR/4axKVrdsrTFWA5wFWp0HI
 9HnsKg6K4cmgm2wl83eH1qviu8LT2is9uKBZ2cCONPDAUbCipLDrN5xVogL5zuebPniWRlx2LAe
 /VM/EsSBHwjkGYbdXQBp7Z17HuXA1PEUAT2L3B70YOhx/ZXLCSkrE9v3HUh3gZcolyDeQeFpjDQ
 g54EIKMH/qB0k5KKuu7XaNoc2Zw+eJdgEQaMWeyEcis27w/Vw/RA/htQb0GCFxlKSewnXpEidPu
 J1R3Ob3xkKzKkUCRck4CqwsfrAS/E4oBeqSn6ZK2ESPiEKYfmCpZoH6F+OVrLxSWxbPC9ad4JRu
 GEA2tpscj8V0+RF/pSQiqQOb7xkKDQHB05YyIqGHguYtxbbLBTcEdQHaWm0WRG2Ajei/PrAeVZe
 j/UjeDgXUVU9aSSTXNIdjW8D0flwxMbJC6JJmYO54S3ybh33v5httCdTh6y3s8ZcawVIiPzsoOo
 LMPYi7sC0qjX+b1wj1xzjCaor/qaiRK2POONAoM
X-Received: by 2002:a17:90b:4a45:b0:3ab:2caf:c098 with SMTP id
 98e67ed59e1d1-3ab3a32f5a5mr13561492a91.7.1791999196480; 
 Wed, 14 Oct 2026 10:33:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e74b2sm358972a91.5.2026.10.14.10.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:33:16 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:33:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shrey Khandelwal <s.khandelwal@f5.com>
Cc: weh@microsoft.com, longli@microsoft.com, dev@dpdk.org
Subject: Re: [PATCH 0/2] net/netvsc: fix stale link status and speed
Message-ID: <20261014103313.76c1bfb6@phoenix.local>
In-Reply-To: <20261014020744.13605-1-s.khandelwal@f5.com>
References: <20261014020744.13605-1-s.khandelwal@f5.com>
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

On Tue, 13 Oct 2026 19:07:42 -0700
Shrey Khandelwal <s.khandelwal@f5.com> wrote:

> With LSC enabled, the link status and speed seen by the application
> are not updated after the host reports a link change.
> 
> Patch 1 makes sure the cached link always has the current speed.
> Patch 2 updates the cached link from the host indication.
> 
> Tested on Azure with testpmd, by injecting media disconnect, media
> connect and link speed change indications. Without the patches, the
> link read in the LSC callback stays up at the old speed. With them,
> it goes down, up, then shows the new speed.
> 
> Shrey Khandelwal (2):
>   net/netvsc: fix link speed not updated
>   net/netvsc: fix link status not updated on host indication
> 
>  .mailmap                       |  1 +
>  drivers/net/netvsc/hn_ethdev.c |  8 ++-
>  drivers/net/netvsc/hn_rndis.c  | 90 ++++++++++++++++++++++++++++++++--
>  drivers/net/netvsc/hn_rndis.h  |  3 +-
>  drivers/net/netvsc/hn_rxtx.c   |  2 +-
>  drivers/net/netvsc/hn_var.h    |  4 ++
>  6 files changed, 97 insertions(+), 11 deletions(-)
> 

Looks correct and review was clean. applied to next-net
