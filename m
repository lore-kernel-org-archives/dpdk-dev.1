Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0223ACD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B97F402C5;
	Mon,  8 Jun 2026 19:46:10 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 2A7F54029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:46:09 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304fb780deaso4559243eec.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780940768;
 x=1781545568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y90EVlJasBz12j1UWB/2riK2HeJakmjH6FNNFQNujvc=;
 b=uP11cAJ5Rtmc9oXFY+KDRKTyjpNoyDfGMt16BgsmXt4euqCMLNo0zvQOJNW/nD9ajc
 EtpGlMEbUz1N+hpiv6z6P1LAz4LToCNUKVvF8cd/gEE6y/0H5CjD75RwfC4zAx1AJ8CW
 xV9A/2UUiSA9/XApWuxIkR5uQZWG7Dc9vIauC7jQbvejW6Lm5bKGuXFgAixMio33OY69
 3qHPV5u8U5XzqtzUxaQNviOpLN14Nt1TbSDotLqM4eFhO/cFvNEFZKr94SRwZmF43FEH
 Q/VtO8j46c8lD6tkfDXOfKOv72ltdSBDb8fEpqPUgtsduyBFodfNo+L3yKBK3PUWR30a
 /zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780940768; x=1781545568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y90EVlJasBz12j1UWB/2riK2HeJakmjH6FNNFQNujvc=;
 b=Ov/tazEwOLR/m1OXDH6IyITvo7U8agRkWMpMVJnqHbcpzUIiN6BaEncgcBBE82RXlD
 ZwhQcH7T7wXDGwR3zkUkVc3DSsLRjv0ihvZG5ENM+VdpnkjRUWHMGFOWBr3Wc3h4dW9d
 5AAqNOMj2NuEXR8ZOeX5PtGaVeXjx055YIueYreb/QYCQXTUqAoqPIYyNVGhdnoegbKZ
 xA5tfiKRHegAZEF7OMQlLSwJJtkDnB+IQ1m2ANTiU3xGa0/u7B34FXT+VXZKRasvoyG2
 mnvImeFdz5ZEoGWJRkR6Xj8/hatZulmRltFNtSxjJBNeNPOQc2RE51leEjPtSlxCvQFE
 vnrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+csUxS8h6p9z2SdrxZ8TOPW7uRCvc52QpXaACG1kgzZf8Fy4imZqLOJQa5Db/BJ2plsfQ=@dpdk.org
X-Gm-Message-State: AOJu0Yz/nqulYTCj59Lxj2TrpOS4wbYkQ+y6t58n1G2hPIh0B4LUsvrS
 VjC9AHrKh+pKpHcPy8Ab/EfKhRx3UhOHqA8NLpIOmpwvN/yiq58tINu91IaxhgZ6Suo=
X-Gm-Gg: Acq92OEIIz2cfIJt1rOtkE9aWHpo0AMZ3tCRCJYqvYAtp5p0Cny+yKpfY4R8uErWF8L
 h7BtMfvnjeR5HNCoPjrusLYdW/UP4tmM9ZgfmzWPkaWHz5iOTIQDGNc+GimOLhv+tGJxURjEduj
 pF1aS83reCAS5Y4RI+s+QHQW3EVW/khbSxF5BrE/Dc2sHXGqES/9GWvrkWtu7WqS3Uq2B4nXer8
 8tNU47Z0116j0BSALtZZE1GtAGazj2Y+mQXnPj7vqqaudY/lGhDKCkJDMRAbWIUhYmMFJ/Ccp3a
 1I3WBZGKA4kv2BcKiImDZvq+Uhm0QwM65t6C0qHrYDjhp0wB5Ynae9typWBVwB92RCNOBEEXIG5
 q0Zpy4PeleeDHsdOsAPbTjlDDACNuj/emteNxjal4zlJeYRYaO5Eqlvjpv8gYO+py9SZZpLDspJ
 UtIbbOPQH1VxAl8730eVa+y2guhPOyT4tUsdy3oO3LykIoKHWTtWWYSoDT5z6o51EC1ziN8ALUI
 uk=
X-Received: by 2002:a05:7300:748b:b0:2d0:239a:23cb with SMTP id
 5a478bee46e88-3077b1cc7f6mr9180536eec.16.1780940768148; 
 Mon, 08 Jun 2026 10:46:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df75ff6sm18586500eec.26.2026.06.08.10.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:46:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:16:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Jasvinder Singh
 <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Message-ID: <20260608101620.55b59803@phoenix.local>
In-Reply-To: <20250716103439.831760-1-16567adigashreesh@gmail.com>
References: <20250716103439.831760-1-16567adigashreesh@gmail.com>
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

On Wed, 16 Jul 2025 16:04:39 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Replace the clearing of lower 32 bits of XMM register with blend of
> zero register.
> Replace the clearing of upper 64 bits of XMM register with _mm_move_epi64.
> Clang is able to optimize away the AND + memory operand with the
> above sequence, however GCC is still emitting the code for AND with
> memory operands which is being explicitly eliminated here.
> 
> Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> shf_table which is 32 bytes, achieving the same functionality.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Applied to net-next
