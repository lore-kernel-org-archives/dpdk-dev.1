Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D15CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15A4C4029D;
	Tue, 23 Jun 2026 18:50:54 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 248CB4029D
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:50:52 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1397e093f90so98260c88.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782233451;
 x=1782838251; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vFQdo1wb45zy6C/LeuKq+0AtVXYxI/XMvf+wqtjIbo=;
 b=BCXXqvrnWddAL0H/+1fnC6Q5Yz6jSDVKBR8BkEtb8F2/Ih/eGYcBZLVpirpm05Wenr
 2gAP0/WwvY0P7/MlXD8zbSPnqYn0iFlgAqwAqOta+StqlWegLK6gRAgssRXngnT5scjd
 sK3w7gEpr+mNo4nT5ueQLiQOuwvdptQ00ovhhqqYIqFMVIHYS/+ZhW+Up6tmghRYGS8K
 vvtE3SAK8FCUhDzVF69tET8F48RYOU0XeaRO51LmGvx1VS8ykcqFfJk85D10cRLNrBHX
 UkjgZAR8b984HFaV8Z7MxFzH8vCyItHV1Gn+gnMFaFRkNE3k26wnp1vPQYdTs4q5anBs
 995A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782233451; x=1782838251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vFQdo1wb45zy6C/LeuKq+0AtVXYxI/XMvf+wqtjIbo=;
 b=Ksh5SYZ2AOS+d9zKav68JVVYSP8KeNegCuO8uEL72KXTRUCzsYtK+ugTz7bMPpw7KE
 8ZUMZOTrDx/QcgJPnTk/8+rinHql8miB95v4pZdyJjUT7fy+tPEmdDcNWB0KVWW4uqJn
 gg28YKeQE2VsiNYjQiUKjFxBvSfvPo4EZoT4mvtvYy+N8dUKd4IiQb6gMeBJpl7bVx2d
 LWyzO4zvTECD04eF394AfFNAJaEau2P3Dpkkf6VTq0CobJ0n08TvM010ImMVQcaZPQS6
 JsxLSmendBEZ8tT282p5prZWh2F4id9yo2FfCtJwCNeKaDUXfsyYO1kqe9Fi0tPScYxl
 UKcQ==
X-Gm-Message-State: AOJu0YzVqjBjVld3dZnM0OshloNmNGppHg3pTMguuc6+pD4xtfyS3EiI
 352uU5b8pVQcEKHqRWfycallz3xorJD9epmhu6R7LVC/21jsKwNJEcyRKFcKBWuNeFQ=
X-Gm-Gg: AfdE7clFptsGnhWYHIzG2Y45wBuS/MOCaUhT11ZhqoBj1XWkpqvhJki4GjPfzlg49Fn
 jTLo1M8tttrtghRCjcMDDnRv6EEylg7nG/1d5teF8sT1o3++Fj9/Xa6pClHPl+VDCUl8RT1HIid
 IcGq8Jvv6NZiTXZY4mxuTXmAz/1zg7O5pqsJWx9tMVkwtMy7gwSSi+LQQrGmc1WEsniNzod9nyD
 I87vUkoo8iPQL8eRyHGKvaPxMUWvWa1ePqOIy5xGFIQih78zChkDADMX+8ZkS8MZUI7gKf+he14
 5Y8RjyqRSO03rErYDARemltl2+0nyq2xDx7BCfJzzhu9lsWEMHIGV3FWZIIEI1U5OfB678QxnOO
 21qwC/W1fg/TtOw6wgtN5h/1uFRryX/HJnsyzBebNHKIOUEfQQHVhryBOT3W1fsJXGLHv7DqxvE
 0UCPg3w31s5UAZSqlqwpgBmRTi5PuJVHp2inHGj8rO4b3la2zfVgVXpg==
X-Received: by 2002:a05:7023:b89:b0:137:ae1d:5b58 with SMTP id
 a92af1059eb24-139a367272emr13057844c88.20.1782233450784; 
 Tue, 23 Jun 2026 09:50:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcaad8fsm13158685c88.1.2026.06.23.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:50:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:50:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v9 07/21] net/txgbe: fix Tx desc free logic
Message-ID: <20260623095047.7d12d5d4@phoenix.local>
In-Reply-To: <20260622111111.21024-8-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-8-zaiyuwang@trustnetic.com>
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

On Mon, 22 Jun 2026 19:10:55 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
> index e2cd9b8841..d6efb3b8cc 100644
> --- a/drivers/net/txgbe/txgbe_rxtx.c
> +++ b/drivers/net/txgbe/txgbe_rxtx.c
> @@ -98,12 +98,11 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
>  		if (tx_last_dd >= txq->nb_tx_desc)
>  			tx_last_dd -= txq->nb_tx_desc;
>  
> -		volatile uint16_t head = (uint16_t)*txq->headwb_mem;
> +		uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
> +						      rte_memory_order_acquire);

This will fail build on clang since txq->headwb_mem is declared as volatile
not _Atomic type.

Please fix, and resubmit both patch series.

$ CC=clang-21 meson setup build -Denable_stdatomic=true
$ ninja -C build
../drivers/net/txgbe/txgbe_rxtx.c:101:16: error: address argument to atomic operation must be a pointer to _Atomic type ('volatile uint32_t *' (aka 'volatile unsigned int *') invalid)
  101 |                 uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
      |                              ^                        ~~~~~~~~~~~~~~~
../lib/eal/include/rte_stdatomic.h:69:2: note: expanded from macro 'rte_atomic_load_explicit'
   69 |         atomic_load_explicit(ptr, memorder)
      |         ^                    ~~~
/usr/lib/llvm-21/lib/clang/21/include/stdatomic.h:145:30: note: expanded from macro 'atomic_load_explicit'
  145 | #define atomic_load_explicit __c11_atomic_load
      |                              ^
../drivers/net/txgbe/txgbe_rxtx.c:647:16: error: address argument to atomic operation must be a pointer to _Atomic type ('volatile uint32_t *' (aka 'volatile unsigned int *') invalid)
  647 |                 uint32_t h = rte_atomic_load_explicit(txq->headwb_mem,
      |                              ^                        ~~~~~~~~~~~~~~~
../lib/eal/include/rte_stdatomic.h:69:2: note: expanded from macro 'rte_atomic_load_explicit'
   69 |         atomic_load_explicit(ptr, memorder)
      |         ^                    ~~~
/usr/lib/llvm-21/lib/clang/21/include/stdatomic.h:145:30: note: expanded from macro 'atomic_load_explicit'
  145 | #define atomic_load_explicit __c11_atomic_load
      |                              ^
2 errors generated.
