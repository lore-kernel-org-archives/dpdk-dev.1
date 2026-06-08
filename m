Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D71CD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F547402DD;
	Mon,  8 Jun 2026 18:35:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 834B74029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780936542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Tg6chPOuzxxnbbrrdpvGxt/WSgk5F9Pu1t/UHmjRJA=;
 b=I35joF61zVDxOxUhcsWptDyu/UBQvwkTG3e3RRzybV/oKk+nDnOvDs3Nb4QWotanxtho7O
 22jYCrC2WF4Y035Bbos/n79nHlfejFSbl+uedQFt6bCdset+YPWq1339manjDEVMmXljG+
 Xgh3xpXYppp5sQHTD258Gp2Jci6CCHE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Sh87jniQNPy18eCBBnke8w-1; Mon, 08 Jun 2026 12:35:40 -0400
X-MC-Unique: Sh87jniQNPy18eCBBnke8w-1
X-Mimecast-MFC-AGG-ID: Sh87jniQNPy18eCBBnke8w_1780936539
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa932535b9so797497e87.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936539; x=1781541339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Tg6chPOuzxxnbbrrdpvGxt/WSgk5F9Pu1t/UHmjRJA=;
 b=UuWbolOwhgnQ23O+D5F+/SWDP2D/RlNH+l5Kf9fr8OYszQtzn1FkYy4tXXmarLk0B8
 y78onNJ33GB7iTTGVQnfU2ENu6p/z3PUpVqpDhjb/CcA4laNZaGtPp/eoMJeIp4V5p5e
 mJvLpdYAGo6eNGiRHx4mfq874M1pLmvAT6xy0GLUM05Ls2rAL5pPu5pPRo0V3p3bfthw
 y8jdMvBu8lGBrdKVYtbWEu+VHgF7S4oVq0qOPqqZzEc0lMEF/G1NbYyCjPTKyEVZpIKE
 lNBLRtZKUO9Pr9MMKi8+cSMNDMcf0/LV+qDqwnSLdO4KyUXZ8FcgjRnFrOqt5zbLxHs4
 NEnw==
X-Gm-Message-State: AOJu0Yy9hJqO9tq8VXKiR8mIR/sI1Ebhb+aCmVdHa+nE/iYBDX5RJtYP
 Oh0C/Ig/SWznakntAUvuGLrR1v+KtjPIKaxizPjswCXwUX3t4R8BeFOIO3vGvItgTAakeZQxxFB
 B+r3LGHmGvFEVbOHGR1e3/bJMfeSJ8FSwpN5fryBpcWcLgHqwp8cXGqKP3WUNRTgy5Ex55hqUC1
 0fWyrodFoMnFYsvAchvQg=
X-Gm-Gg: Acq92OHrN3MJiLznsaea2TkY3F6NIYRLUDA2LIOnoqGOtseMwQ4+S97+ZQ1g62g2ABm
 KZGSDf5CvrqCU1eit5LGeunhPgPGOCkXbyDkbDu3csRJgNLuJ7z4+Afche6HAwWa602g0vldrZb
 M5PazVppOozr33t2CVibTakUKMhjihOKn1kKRwQl18shhxN5R40INH0AhwsOZrUqI6pxSpzs0FO
 bBIeVOlXIgyhkE87YxRlOsnOMZ73WRrvpJGmD8Hw6FRRy8X+2pNx76B6Xu6+m7ORXVA2/ai4PwC
 qBe4
X-Received: by 2002:a05:6512:234d:b0:5a8:8df1:61bf with SMTP id
 2adb3069b0e04-5aa87be895fmr4936270e87.21.1780936539106; 
 Mon, 08 Jun 2026 09:35:39 -0700 (PDT)
X-Received: by 2002:a05:6512:234d:b0:5a8:8df1:61bf with SMTP id
 2adb3069b0e04-5aa87be895fmr4936259e87.21.1780936538572; Mon, 08 Jun 2026
 09:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260422075414.2528455-1-maxime.peim@gmail.com>
 <CAJFAV8wn26hRUTzCG4ai+apT8+bWL7+cEE1N-gV1tJt8B9a4hQ@mail.gmail.com>
In-Reply-To: <CAJFAV8wn26hRUTzCG4ai+apT8+bWL7+cEE1N-gV1tJt8B9a4hQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 8 Jun 2026 18:35:26 +0200
X-Gm-Features: AVVi8Ceb-Esm1r9X-0zReAT5l2hFVAl2frqY_SNm-rSHBhJTgXmMVkgs7x5SnFY
Message-ID: <CAJFAV8zsDEW6vU69NHmZiqUyB4xz+qDPQsw-cBBeScGeuE_Fiw@mail.gmail.com>
Subject: Re: [PATCH] eal: fix core_index for non-EAL registered threads
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h6cJUIsRAbPYoSnyd-kKQMsszKQsQsI14HSdMA4D56Y_1780936539
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

On Mon, 8 Jun 2026 at 18:10, David Marchand <david.marchand@redhat.com> wrote:
>
> On Wed, 22 Apr 2026 at 09:54, Maxime Peim <maxime.peim@gmail.com> wrote:
> >
> > Threads registered via rte_thread_register() are assigned a valid
> > lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
> > lcore_config is left at -1. This value was set during rte_eal_cpu_init()
> > for lcores with ROLE_OFF (undetected CPUs) and is never updated when the
> > lcore is later allocated to a non-EAL thread.
> >
> > As a result, rte_lcore_index() returns -1 for registered non-EAL
> > threads. Libraries that use rte_lcore_index() to select per-lcore
> > caches fall back to a shared global path when it returns -1, causing
> > severe contention under concurrent access from multiple registered
> > threads.
> >
> > A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
> > uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-core
> > cache slot. When core_index is -1, all registered threads are funneled
> > into a single shared slot protected by a spinlock. In testing with VPP
> > (which registers worker threads via rte_thread_register()), this caused
> > async flow rule insertion throughput to drop from ~6.4M rules/sec to
> > ~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
> > to spinlock contention in the ipool allocator.
> >
> > Fix by setting core_index to the next sequential index (cfg->lcore_count)
> > in eal_lcore_non_eal_allocate() before incrementing the count. Also reset
> > core_index back to -1 on the error rollback path and in
> > eal_lcore_non_eal_release() for correctness.
> >
> > Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
> Cc: stable@dpdk.org
>
> > Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> Acked-by: David Marchand <david.marchand@redhat.com>
>

Hum, I did not push the change.
Re-reading this code, we have an issue if some external thread
unregisters in the middle.

What do you think of the additional hunk:

$ git diff
diff --git a/lib/eal/common/eal_common_lcore.c
b/lib/eal/common/eal_common_lcore.c
index ae085d73e4..6f53f20d90 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -372,13 +372,16 @@ eal_lcore_non_eal_allocate(void)
        struct rte_config *cfg = rte_eal_get_configuration();
        struct lcore_callback *callback;
        struct lcore_callback *prev;
+       unsigned int index = 0;
        unsigned int lcore_id;

        rte_rwlock_write_lock(&lcore_lock);
        for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-               if (cfg->lcore_role[lcore_id] != ROLE_OFF)
+               if (cfg->lcore_role[lcore_id] != ROLE_OFF) {
+                       index++;
                        continue;
-               lcore_config[lcore_id].core_index = cfg->lcore_count;
+               }
+               lcore_config[lcore_id].core_index = index;
                cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
                cfg->lcore_count++;
                break;


-- 
David Marchand

