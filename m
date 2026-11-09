Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804C606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Aa7fT/M8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEBFE40285;
	Mon,  9 Nov 2026 23:21:32 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTPS id F23F340283
 for <dev@dpdk.org>; Mon,  9 Nov 2026 23:21:31 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cdb15cd8558so612961a12.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794262890;
 x=1794867690; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qbaj4kTAbsAfxrg4co03WtE/aa59ZnvxDprAZcCIUGw=;
 b=Aa7fT/M8ntJKoknytF2bJjKJ12y70t1Z51fSxZ1dDmUYZpny/UJCb5u3c9Vy0DsCDt
 E6Cl0L2NhE+pLEz/UdzlK9jXiSowMV7BsKTyrbDHQtGHW01leQzlzTOkg3olgG14mcKS
 /kIsmZus+vmARZ5w2Y77ZUSJUT3/oskHcDYc1e7ETr9ZYJUrHBiFNYZfXF3CcMTHW74W
 hdNuKVgpfXIagkMas6f03SaatYoeUn7oLGQlR7ZmNHnAMbu/yngVQYhLq5+UICUEFICu
 enPn9W3tF7nqkqaD7qzDqlsCPr5Xw6CVGTR3GjheeGkVdRcarqIDWWOnFyPWcIqzGsRY
 HGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262890; x=1794867690;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qbaj4kTAbsAfxrg4co03WtE/aa59ZnvxDprAZcCIUGw=;
 b=kE8JwHy3zaWPy+n7nHfAY5JMoZqL2xV9K1aMtP/IB/0SVTCrZAYFcul0OVVqUSPdWT
 vwBSV6HR7JWMMIk7/nNcCTe82RXQkk0sFJT0zWpiCw1sY/zTzUBEr8VfEJh5E0XW+lfc
 V+rMg6i4LqsxIK5zlgKpnLUxElHhAdG9NmZOwFFK/tl6GZekEPMfaI+AjEzWUJWLJERT
 oFZJtLntdHLT7dPbgUqTJkMqDunv2FKpE1/Qi6tIr/xfLPjh3ZCFECwzX/OKP6IYhGQ7
 Q07Y4bUroKUxKwBNge3enq1LwODFsqcr0wCAR0Dr4YW9XtZso26Hhml5bGHgniD65lLD
 fc8g==
X-Gm-Message-State: APuU4Z9kn+jwiF4jPy1f7eb2GAkiLlOWKYbbNTlYt45r0w3Y92JXBUmw
 3PBFQ56c/tX8qMGHxlJdWj9i/g9rFHRs+Aah+ukYMHiD44hBaFH9M32mabuiT+LE4o4=
X-Gm-Gg: AYBFou2/R5GH7+biulg3UyAuMXWfHnqKLfBVh9M4OI6Hhev+PvNUgAHxyHUZaAKM+gq
 uk7l98X4aATGza7Jfkn7h7M7zTMFwO9jQntlUrSrEOiFLJlm7A/cZUjyY/Nors48RW9QnB8zclk
 QmJarOfosdOW1eAAYQWhT0TVlB/tMZKRddRL6OjztpXOMc1iDqq6mchSM5bATkk9nmezwc3s9AV
 mQijjeOy4Jsj7Nsu9Ufza8lT1Bh0kv7MWct+ordN/nub6FdJaTfCB4o3fip9NeGZ9YX6V2arAuS
 qdcMpv/B7bcu/MnpWMH91tsQQu4q5biZm49J/u4mgU6yLfTLNawWdAfl5FZVPy4gw4gjDh9cLBn
 Ri6MErE4JrcCdDQTxJjpcV+auBu9/h+p1rLJ0SeaME9a641SFREdihjRhOWvTDyKgI3fhZbQthm
 l4Duy+0b3ZdJZYmtRAj4QFyNHJF9qvXmCxcKtBCscvVHMBcB2fwXTbj2wcAL0lMXsFRAEDZTShB
 t9ZX0OloLNbykYS0OYMqnhXWfB4jybxe2cvyjHS2gqd4VLipSlQ0PdvQWzAEX+tPtz7UkxPOIxQ
 pLhc1iRTlc704PqjiIQMoZGKbMQbQLClBLTWCZOytt52qbZFD/gXk8iXRel9BmsO0QmBnXw=
X-Received: by 2002:a17:90b:51c1:b0:3b0:e2a9:3466 with SMTP id
 98e67ed59e1d1-3b166cd48afmr894133a91.16.1794262890261; 
 Mon, 09 Nov 2026 14:21:30 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1676e2974sm1188073a91.9.2026.11.09.14.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:21:30 -0800 (PST)
Date: Mon, 9 Nov 2026 14:21:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Orgad Shaneh <orgads@gmail.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 stable@dpdk.org
Subject: Re: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Message-ID: <20261109142127.7a54ee80@phoenix.local>
In-Reply-To: <20261102070809.813033-2-orgads@gmail.com>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
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

On Mon,  2 Nov 2026 07:08:09 +0000
Orgad Shaneh <orgads@gmail.com> wrote:

> Rx interrupt enable and disable take the per-device reset_ops_lock
> with a trylock and return -EBUSY when it is held. Every Rx queue
> takes that lock on each enable and disable, so with two or more
> queues on different lcores the calls collide routinely. A failed
> enable leaves the CQ unarmed, and a thread that then sleeps in
> rte_epoll_wait() is not woken by the next packet; it sleeps until
> its timeout with packets in the ring. A failed disable leaves the
> event unconsumed. Applications do not expect -EBUSY from these
> calls outside a reset, and l3fwd-power ignores the return value.
> 
> Seen on Azure (MANA VF) with 2 queues and a 10 ms epoll timeout:
> about 550 lost wakeups per queue in one run, p99 latency 9.9 ms,
> and 22.7% packet loss at the higher rate tested. With one queue
> there was no loss.
> 
> The section under the lock is a doorbell write or a non-blocking
> read of the completion channel, so wait for the lock instead.
> The device state check is kept, so the calls still return -EBUSY
> while a reset is in progress; a caller that arrives while the reset
> thread holds the lock waits for that step to finish first.
> 
> Fixes: 077ca514d641 ("net/mana: support device reset")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---

Since this is better than current main I applied it to next-net

AI review noted:

Patch 2/2
---------

Info: blocking can be long while a reset is in progress.

The reset thread holds reset_ops_lock across mana_dev_stop(),
mana_mp_req_on_rxtx(RESET_ENTER) and mana_dev_close(). On reset
exit it holds it across ibv_close_device(), mana_pci_probe(),
mana_mp_req_on_rxtx(RESET_EXIT) and mana_dev_start(). Each mp
request is rte_mp_request_sync() with MANA_MP_REQ_TIMEOUT_SEC (5 s).
An lcore that calls rte_eth_dev_rx_intr_enable() during one of
those steps can block for several seconds instead of getting
-EBUSY at once.

No deadlock results: mana_reset_enter() only spins on the
burst_state busy bit, which an lcore in rx_intr_enable/disable
does not hold, and the ethdev event callbacks are all emitted after
the lock is dropped. This is acceptable for a stable fix. It would
help to say "may block for the duration of the reset teardown or
re-probe step" in the commit message, rather than "waits for that
step to finish".

The burst_state gate mentioned below the --- is the better
long-term design, since it avoids putting every queue's
sleep/wakeup through one device mutex. Fine as a follow-up for
main; not needed for this fix.

