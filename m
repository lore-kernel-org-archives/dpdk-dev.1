Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE1606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VUll6HJH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CFD440285;
	Tue, 10 Nov 2026 15:47:18 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C31440281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:47:17 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e985106c0cso15944985ad.2
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794322035;
 x=1794926835; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v9ZKdE3p5syySoti185vqG9Qj92rmcSGfD42DJV0Xys=;
 b=VUll6HJHlLn//nSJZ6OL70+SvlUN3gsP5cCVsCpa699fDCoTwVeOXISRoWq93LRMfM
 tBRxepUGpdyuWZxiM1jV+bfZsxPJ/FjpxS+W1sQIEhHezSGZVO9X/dk5BUHG+e7/L9wM
 zN+IcvSSK9DHxA7sqaDYg8fWOZj0fOZ+AQS1SPxMBcr+9FkuVEi10q1UVAf5xI4qz+pz
 ule1OPgKl21SGl16rNoGyl1v952ygjbvXdd5smC07VF7H388QXYQhoSwsbYz1VTPxXNE
 3R/QQ3t5Lbig49b9s7VGXgARuaumROwmmtiWpqOL/iVsI5SOWqosD5tT5I4VIhiFlaRv
 pYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322035; x=1794926835;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9ZKdE3p5syySoti185vqG9Qj92rmcSGfD42DJV0Xys=;
 b=xw50qYfSsKYyEH9RhFRangtGXZNmwfwlXYTTr2MLuQgJoLAy1Hur/bqQCZh4xkUgou
 zKKPRi0ie4AzFDvS7Odo+7Mw0egIXukmnMwweu01vzk10mEqO5zMMCk89Jl4zgLiNItK
 ZV/uqzujpNajwPLd+a9Og5JbHmUnwbirt3YBEoa8ZGo49cO3ZQjFv15CJ2asJHHwjfUV
 r6FQJyOQFsRP4qx2WvxqNIAr3UCfJIhCYZuHvw77tD5V074ptG5W+R6lvG3Mo4zXIS4b
 Z3E+FFevk7BfTDYMnbaPT4Y9alKmfM16PQE/duM8xEE7AspFnJdZo2agBvYh2c4QNSaf
 UqGQ==
X-Gm-Message-State: APuU4Z8piDnGqLPeQLNaGYaH5cQC9/OdizQ0p6O1a9HHLfOkxftNTpoP
 mQ7q/KyFnRuJM7iDamJcSPzGBDGQVWlTMmdlrzNd5TukkKdWiYmGePl6sM9rWh11UBE=
X-Gm-Gg: AYBFou2k+izvPzGtEowFnagf/UUtNmQZnV5rl6g2b0Uiek/85gdH4LKlDC1xs/QL2Q7
 S4YVxNBoQWXG54atzKG99Oxccp6ijnXgTnRVYXca+UAZQhVdCSWoCIyCGJFLzaSMzCWOr71DnOL
 8Sfl0P/gsWVa/3xWZIT2gJ49a4aVHJn4MukuA9xWm0f5npj/f+X8m/fjMMuP49XIWeHbhadlhHt
 3HkRmPPr3YHDcOzvooi0LGWbmzmQmsURmz5Fvbrqu/joTr6UTMOoMscgbyiUlfx/M2wzXsNE3hD
 MNzvfEXpUDM8NuCQkwT+K/STYuxFXmRlQb5uNV9y37VL4RBt+8nn33O9LpSjIXlJLurFHuXT2qs
 kJSIu5mBgnTPqt7CHB7oicQGmYnKi3kVr4vwV6yhs5F5OD1p4vTpBM6XeEUsBpKrnMXctkXr+Dm
 LSkOWbuhRe/xfipJxJ/hcyiifs2FLdxTUcNKXehz8YXq8DiLG7cxiOa/zBrE/i2nukQws/c8Mit
 jV8KqBv+hUiVJn4/WESi6zfQI57HssVY3YnUfGYoIeZTkEwiTG5zFLytyuwpen0QJwg1QDm6wEq
 feboiuuklJp8ZC5U9Kh9kfMs4ee6g7+uohgnfy5i4rjht8dhr4GcJ5H4hyh3BSsiKkgvh68=
X-Received: by 2002:a17:902:e944:b0:2ed:630:40a4 with SMTP id
 d9443c01a7336-2edb91f5535mr29717775ad.11.1794322035392; 
 Tue, 10 Nov 2026 06:47:15 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d9efd6sm9944345ad.50.2026.11.10.06.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:47:15 -0800 (PST)
Date: Tue, 10 Nov 2026 06:47:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Orgad Shaneh <orgads@gmail.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 Aditya Garg <gargaditya@microsoft.com>
Subject: Re: [PATCH] net/mana: do not block Rx interrupt calls during a reset
Message-ID: <20261110064712.6b1a3eb7@phoenix.local>
In-Reply-To: <20261110094243.151321-1-orgads@gmail.com>
References: <20261109142127.7a54ee80@phoenix.local>
 <20261110094243.151321-1-orgads@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 09:42:43 +0000
Orgad Shaneh <orgads@gmail.com> wrote:

> Rx interrupt enable and disable wait for reset_ops_lock and then
> return -EBUSY if a reset is in progress. The reset thread holds that
> lock across the teardown (mana_dev_stop(), the RESET_ENTER request
> to secondary processes, mana_dev_close()) and across the re-probe,
> and each request to the secondaries may take up to
> MANA_MP_REQ_TIMEOUT_SEC. An lcore that calls rx_intr_enable or
> rx_intr_disable during one of those steps blocks for that long,
> only to get -EBUSY.
> 
> Retry the trylock while the device is active, and return -EBUSY as
> soon as it is not. Outside a reset the lock is held only by another
> queue's doorbell write or event read, so the wait stays short; once
> a reset has started, the caller returns at once.
> 
> Suggested-by: Wei Hu <weh@microsoft.com>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---

More detailed AI review of this.

Subject: Re: [PATCH] net/mana: do not block Rx interrupt calls during a reset

The reset-path logic is right. mana_intr_handler() stores
MANA_DEV_RESET_ENTER under reset_ops_lock before the reset thread
starts, the state stays non-ACTIVE through teardown (RESET_ENTER) and
re-probe (RESET_EXIT), and ACTIVE is only stored at the end of
re-probe with the lock still held. The relaxed load in the loop is
only a hint; the acquire load after the lock is taken is the one that
matters. The PCI remove path stores RESET_FAILED, which also ends the
spin.

Warning

The commit message and the new comment say that outside a reset the
lock is held only by another queue's doorbell write or event read.
That is not true. mana_dev_stop_lock() and mana_dev_close_lock() take
reset_ops_lock with dev_state still MANA_DEV_ACTIVE and hold it
across mana_dev_stop(), which calls
mana_mp_req_on_rxtx(dev, MANA_MP_REQ_STOP_RXTX). That request can
wait MANA_MP_REQ_TIMEOUT_SEC (5 s). dev_state does not change, so an
lcore in rx_intr_enable/disable now busy-spins with rte_pause() for up
to 5 s, where before it slept in pthread_mutex_lock(). The control
ops that use mana_reset_trylock() also hold the lock from a
control thread that can be preempted.

rte_pause() is only a CPU hint ("pause" on x86). It gives pipeline
resources to the SMT sibling, not the CPU to another thread. If the
lock holder is preempted on the same CPU (a control thread or a
secondary's thread sharing the lcore's core), the spinner keeps the
CPU until its time slice runs out, and the holder cannot release the
lock until then. Yield instead:

	while (pthread_mutex_trylock(&priv->reset_ops_lock)) {
		if (rte_atomic_load_explicit(&priv->dev_state,
		    rte_memory_order_relaxed) != MANA_DEV_ACTIVE)
			return -EBUSY;
		sched_yield();
	}

Use sched_yield() rather than pthread_yield(), which is a GNU
extension deprecated since glibc 2.34.

Calling rx_intr_* concurrently with dev_stop is an application bug.
But the wait is not "short", and the commit message should not say it
is. Either fix the wording:

  Outside a reset the lock is held by another queue's Rx interrupt
  call or by a control operation. The data path must already be
  stopped before dev_stop/dev_close, so the wait is short in a correct
  application.

and the same in the comment above mana_reset_lock(). Or stop the
queues from contending with each other in the first place. The only
reason rx_intr takes the device-wide lock is to exclude teardown.
A process-shared pthread_rwlock_t would do that without the spin:
rx_intr takes the read lock with tryrdlock and returns -EBUSY on
failure, and control ops and the reset thread take the write lock.
Queues never block each other, and a writer of any kind fails the
call immediately. That fits better with the burst_state follow-up
for main than with this patch, so the wording fix is enough here.
