Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807AFCC062
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 18:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 885154066B;
	Fri,  6 Mar 2026 19:55:38 +0100 (CET)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id 23748402E3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 19:55:37 +0100 (CET)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-463ba60966aso3431618b6e.1
 for <dev@dpdk.org>; Fri, 06 Mar 2026 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772823336;
 x=1773428136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBE9G56KSdsllQ3tgLKdYgryoDGQceV4oUmEj8thOEo=;
 b=VbP23ZzjczLxpuapyKHcgJLaaYmGVOql5AWh70OKxizKZ6f1bUnO9pVptA6iI8AY7D
 GwQ1CYfnMKrwjhoTQJxk/6HnD+iFsJx5ZH29Swfavtp9hoFPgGb6YxHgOHBpZ2Veueao
 8KEwi2ND1ZnBH1zMW5OuInBIHJJH15GnPZFqLGLAajq10+0ol+AsaCMY/M+Ir7uaHDsx
 2gszsI83kXOaZBnof5obZ7aeepGdtTwoOE08fpugfkYq1jsAYrH8l92IR6XgMF8mBvB4
 AHa4+Xyqpv4wPZfdxYPIZVVowjAGp9BVpOkXfR3pbmRoNikB5xDDDB4z/6aSvupYeJNe
 shoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823336; x=1773428136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBE9G56KSdsllQ3tgLKdYgryoDGQceV4oUmEj8thOEo=;
 b=if/IV7ffvq44atmIhIDHr++0aaTkgyiLqavEACC/e2dZcMZMXpgWNUglCPKenL59+f
 0KdK0OSzBG7gbt8r0vMUK1jHj0bZzj9Y1k+diSLTG2qd9rX5SPfhP3I6P/N4zVdNxfpk
 tIGcN+0bgflFRuAABUgk/13w1sylmGQ3V0M7U1OWfAkGgCerm0WBrSww6VNlGOtlKAIW
 QUd8xOhvMzmJQ88MZXwwCJ2rBwb4vaSchb4XT8h1h6zhKLe05fpY2DNI1Qjzh6K57pFf
 8uy0YkC3/0tNlWDBf0/t4jsKiizYsSNQnHrLsY3ttQBQlv6wdqYOfl8nXjDgzLUAhb6c
 2Kug==
X-Gm-Message-State: AOJu0Yw5cLC5gdmLJ8/JGnqkzzz+oO4mkAw1INdkXlHzW+Q3/KRlwiWx
 28p6+Wd+OmFCP8DwNVQqK9p0JdPUOGFlziwChUe8L1PyuRxdANiQsu7C4hI78qHeQZyhwbtli5C
 Ez2oo
X-Gm-Gg: ATEYQzx4q+hF31/jvXHmxF8IABGkCjFT9BAYg/Bh4I15ev8W2rTaK+hvsKEk8nuw6qu
 WP4xIjZ9CRqyfEWxlYtGHTHihCxsQI2ekAL3tQnBTjQw6fTR+tfFyWugUuKKjH1O8r0/fwwhHml
 dWcyLB4dsQRxNFiWnuqE0cnipHqQu6CZRMZNBnXPHYV7dpuBDTFvS0uAtzoKHV/O5YOFXiA+Lb6
 Nfm90BWV9ckvEnZCXV8e74A/37lSCZtxgcRMwN+fLtdHT29n5Ta/loThoO3I7Su6xjqFHsMgiXv
 tF81spuD5sJHJx+HazMb1yEw3/ZWkGCOoviNCTQ259FWfIlaNXdVkfrWNNe68Df1MCsCn4PR18F
 FFv9F7I0TXBvm4sHUekkK60airoQ8b0Hss7ULZwUl5iEKHfO1JVpvcUcKO/BRFwVA+yJzMKvmiC
 yrkOSAWh5Yj5e/S5TL39MoGjHzNH0v+XoaRtlTa2rhsshNf7mOBOOmENYnFPiHt1Q0
X-Received: by 2002:a05:6808:4f46:b0:459:993c:6f1c with SMTP id
 5614622812f47-466dcbad2b3mr1894710b6e.31.1772823336341; 
 Fri, 06 Mar 2026 10:55:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466df96bdd1sm1167052b6e.7.2026.03.06.10.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:55:36 -0800 (PST)
Date: Fri, 6 Mar 2026 10:55:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Selwin Sebastian <selwin.sebastian@amd.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Message-ID: <20260306105533.5e8b77ff@phoenix.local>
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
> 
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
> 
> Patch 2 fixes wrapper_rx_desc_init() which only releases the
> current queue on mbuf allocation failure, leaking all mbufs
> from previously initialized queues.
> 
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close()
> for the four mutexes created during init.
> 
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring
> size. The offset is now folded into the index before masking.
> 
> 
> Stephen Hemminger (4):
>   net/axgbe: fix resource leaks in device init error paths
>   net/axgbe: fix Rx queue leak on descriptor init failure
>   net/axgbe: destroy mutexes on device close
>   net/axgbe: fix descriptor status out-of-bounds access

Since these were code review generated fixes, still holding off for
maintainer of this driver to verify
