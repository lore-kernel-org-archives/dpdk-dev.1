Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B0CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5029140A7F;
	Fri,  9 Oct 2026 01:37:08 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7477840693
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:06 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-892734ce7e6so1132554b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502625;
 x=1792107425; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7abDSKLL4Lv5RNphVmTFCX67AipVyDmAgZYVZr+0piM=;
 b=eLZrpNlXFbjker55JJh2NRiHbv/jlDPPJQoqNuHv8fw+N2RREvKWAWCQvRpLQohRxM
 IgtyRDFdlWlvyBWaRs5a1yQnpUoGqbR2N2uOjKF4ctYCsbWADuxusx62m7eAuiEYOykS
 slv3SE5vldSRDAb4N99YwObdkPTo0OYvTDZBZpqso9EhKB/jFUvGe3kZ+seG9n58915R
 bZD6NufjMqFQZ1AuHBpLBytdC0itN15uyNz4mTHhknkJVOuoW94jwqqNWAU0tI6ZDq+3
 dMR7ooX/PG4tSjLP/nHZc8tKGuvmLAttoXH8jN1X6HoNVk2r/vYngXCEDLn6aiFkYhSE
 gvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502625; x=1792107425;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7abDSKLL4Lv5RNphVmTFCX67AipVyDmAgZYVZr+0piM=;
 b=sYXD51EplNrW0sq80f9xo0awDyBnRZg2xxX2MD44mTMr6YazPo9NjQQfIakHuSSRcG
 3F4C5yKHnjC3jUEkBVvBd3czeCT03BYhAJAALc30sX3SRUfRkVlAKDGZWJr7suPhRGrg
 oZrEY3hWCbFn3Hzjb9XesFMRFJ0PhaMsY1rbkB/jDfKVD5NbqO8Z37fI2luhNavt5kPC
 /iyYd+XqgVmfdm9MxGRP3vdqhq4q1Bad5M69mzUCdIMzQhiy0oc2N+gORGrb02j6boCB
 rqKUuI6n1e/G1JfyA2LqfbkMM4BTm3v6rArhzD8ivld++Dmor8kBh4z4sqoKhcWk+wOZ
 MnnQ==
X-Gm-Message-State: AFuF++nkSEbIyPSxY6Ts/LfgNhw9bSFQm1WCXwnj4daSNfElB4K+Jwt3
 6oniFEis/PFks00dw+2bEH9ZQkODHJOYYDV7qVqKvd3NAimVVIggO/OOzUg7SFoLAKHTSu2idcv
 i2J4qtcU=
X-Gm-Gg: AYBFou3vgl9R/ItjRX066YfsWZR1FBebvNlezuJGEN2KN8N2RrvGvPMM5OOnM8+i6XP
 OnHytPU20qh7u1656VBneN+t/ofF5hhq9jD9Y9KG+u9cSg1Fm+JpCP5y26MHqDX0GHmnVeb3DOM
 lrTb4WG7+wqgvNrvJKiWOynpWy+Djh9GDHYHIWWAJjS3loUomR/jtMNsX4m4R040d1FvVC4kZrL
 0gChp3jycp0frv9OrfRAMZMP+GTavIM55haJ6yr0pqI6w55YuhAHFO3iDi61ipI7IItI6fjocZR
 fcw6DNGYS7GVSYTqxk1cCzJ+b3cCM/bMaM09bFtyyst2UJaqPoj37yLtDXwSGKx73G8eKfjFPcP
 psrsTdGnPf3EJNZjmc3BY3ACbBKpP70knCkyRk2f06jb1OwxKKEoa5qCHtztATOZ5SivbNE4xAL
 hp2/DVCjr7GG80TEe/ddaAasj9U7TCUEJDUAGmCwD4b6yjtn/K0wMRHdy3CWt4FtLK0hQ8SjOfi
 yBJZF9/tOsUMMHMI0Xr46egOLQOb+xGZO1zBg==
X-Received: by 2002:a05:6a21:7a97:b0:3e1:5816:8743 with SMTP id
 adf61e73a8af0-3e16bb71247mr33148637.6.1791502625604; 
 Thu, 08 Oct 2026 16:37:05 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v3 12/29] ring: replace SMP read barrier with C11 acquire fence
Date: Thu,  8 Oct 2026 16:35:05 -0700
Message-ID: <20261008233649.1260843-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

rte_smp_rmb() is deprecated. This code is only used where
RTE_USE_C11_MEM_MODEL is unset: x86, ppc64, loongarch and ThunderX.
The acquire fence generates the same code on x86 (a compiler
barrier) and on ThunderX (dmb ishld). On ppc64 the barrier becomes
lwsync instead of sync, which still orders load against load.

The gcc implementation itself is kept: unlike the lock-free stack,
the in-tree comment records a 10% x86 performance drop with the
C11 version, which needs re-measuring with current compilers
before RTE_USE_C11_MEM_MODEL can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ring/rte_ring_gcc_pvt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 340ece28c7..9c2c58824d 100644
--- a/lib/ring/rte_ring_gcc_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 
 	*old_head = d->head;
 
-	/* add rmb barrier to avoid load/load reorder in weak
-	 * memory model. It is noop on x86
+	/* Acquire fence to avoid load/load reorder in weak
+	 * memory model. It is noop on x86.
 	 */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/*
 	 *  The subtraction is done between two unsigned 32bits value
-- 
2.53.0

