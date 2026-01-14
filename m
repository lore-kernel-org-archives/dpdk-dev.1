Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C84D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C958E4028F;
	Wed, 14 Jan 2026 07:24:58 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 570B340289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:24:57 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so9428045e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768371897;
 x=1768976697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3wH1KlY3OkYPc9tNSYCfHlaq4KKtyT3Q9xp6salhlA=;
 b=BD16ncvjYngE5pt+kvdB9czj+cjeREfU2LQSfhSXK3X/iNtAikV18POTvTe7+rwS4b
 7LtNj40jBDFDZjc5w1bOl7upGFWyb/51rQgKKxbMZX3JxEWqgQ+Z40VX+SryTs10s1bN
 Vq+s7p8e+Wv/lqceOg2h+F8Ktj2aPPxWwFtmK+msk+B8iAdQa51gsfVeJb9UgTSYb/oR
 NvWE28vJnuRA0H60EQuCAIZKiEp2h/2yGGYSWu6pxtiP2cCfeWQCZ88mun/ZrQyE+ToW
 e5uG7rfpkHbZvyf20myAleWBihxqFKhC9q4bKLqT+QlB69COD72hpOFxwD2AIWKJpq/4
 N14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768371897; x=1768976697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n3wH1KlY3OkYPc9tNSYCfHlaq4KKtyT3Q9xp6salhlA=;
 b=gAvIEaBGtYsSN18rJ+QCOc8BC31cQHgrmQOlF+Q8g4RMptnE88N5lRRUxdEWIbNsZF
 tU074dcdlu04nnLwsIOnBq/+p4nQyLouXGIl9lLd2W3uE/CEw90YI9K+fft9cW2dDDOT
 r7DFy79BjJzhPkqljuP04DWTQ0lFUp9QOdPzRMqUooZozOOtQM46wUyIEmyvp8jukfvu
 7QzQPh12UFuMO73cHsnLNLO4ZBQsqgsI76Rc6OBkgglmE5/y7CAvEVRaZ2UrxhBqipqA
 qRpdEzCRx+TIzr/gHLH6+HbA+zdNwh5TMOy/XVdjh4faLHDtlPvb6OrMSK8BM2GLXpzW
 mWYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7CJDInBqfXnNF+u+6Zh1U++4xt0hz1VEbTUnFSTMxkEKeELHaTa3aJJWE0dFBAGf29nQ=@dpdk.org
X-Gm-Message-State: AOJu0YzdfXc+n6kUJQvfwtGarvAFd1ouVJqnw4ROipTYSd/YIiI39Lj7
 Q03elF9cp16ROOllvYSabegutodL2X28bPpF1QVz+HiF1hU3gBk0WjWWYkiDQU42l/M=
X-Gm-Gg: AY/fxX6o3hXXh7RLN9SPoN5DIrbKMw4mao9zAvgnLP77ni7EoJte8HzrvRmncLlOG+F
 rxQEGK9rkQQYemyJ6sxFwn96puNvtTtUgXZ0Dzx7U7wMqXsrK1wLHoOR2OjBV3kSX9DghE5ZSTV
 jE4TP5XLriFdrIB10KCjJGuU0iRB8gEilX9vADrY/bYY2KPmEO+Sw9jPn7dwDRgZfLY4N+4mEQN
 A0WziX08xDed/5CmcPxa73arJ9avZ6eKGZ+qJzVOpgkARM6QSKESWP9vpXh7zUVpfIm7XH2kV44
 1O21yiboETWkUkwji3RZOok9G1PyLQ4O0xTEpq0WGqnVMMChBTKw8ArAGGNsG00vxFGz0j/Y9CX
 kqRjurqfBlIx7mPqfcqOfMEXl3TAymIYBnAIvjQ/JuOPChrg3OpayQkrxPhQPWzv5xDqfXQnEY8
 g4Y21VSmKMVIdNwPM0mLJSf7eQM91iI7+ocbqUmpD6GZMuXcvTE+wX
X-Received: by 2002:a05:600c:314f:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-47ee335e701mr15299755e9.24.1768371896869; 
 Tue, 13 Jan 2026 22:24:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee5910fc2sm10738515e9.13.2026.01.13.22.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:24:56 -0800 (PST)
Date: Tue, 13 Jan 2026 22:24:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: <ferruh.yigit@amd.com>, <andrew.rybchenko@oktetlabs.ru>,
 <orika@nvidia.com>, <thomas@monjalon.net>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH v5 1/1] examples/l2fwd-jobstats: fix lock availability
Message-ID: <20260113222450.42d0ee18@phoenix.local>
In-Reply-To: <20240811155957.576645-1-rkudurumalla@marvell.com>
References: <20240811065819.575759-1-rkudurumalla@marvell.com>
 <20240811155957.576645-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 11 Aug 2024 21:29:57 +0530
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

> Race condition between jobstats and time metrics
> for forwarding and flushing is maintained using spinlock.
> Timer metrics are not displayed properly due to the
> frequent unavailability of the lock.This patch fixes
> the issue by introducing a delay before acquiring
> the lock in the loop. This delay allows for betteravailability
> of the lock, ensuring that show_lcore_stats() can
> periodically update the statistics even when forwarding
> jobs are running.
>=20
> Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---

I prodded AI to review this patch and it had some good observations.
You could go farther with rte_wait_until_equal which has even better power =
performance.

Let me see the critical `l2fwd_main_loop` function to understand the full l=
ocking context:Now I have a complete picture. Let me provide my review.

---

## Patch Review: examples/l2fwd-jobstats: fix lock availability

### Commit Message Issues

**Errors:**
- Line 84: Missing space before "betteravailability" =E2=86=92 should be "b=
etter availability"
- Line 82: Missing space after period: "lock.This" =E2=86=92 should be "loc=
k. This"

**Style (minor):** The commit message is a bit verbose for what it's doing.

### Technical Analysis

The patch addresses a real problem. Looking at the code flow:

```c
/* Main loop holds lock almost continuously */
for (;;) {
    rte_spinlock_lock(&qconf->lock);      // Acquire
   =20
    do {
        /* ... lots of work ... */
        stats_read_pending =3D rte_atomic_load_explicit(...);
    } while (likely(stats_read_pending =3D=3D 0));
   =20
    rte_spinlock_unlock(&qconf->lock);    // Release
    rte_pause();                          // <-- This is too short!
    // Immediately re-acquires lock...
}
```

Meanwhile, `show_lcore_stats()` sets the flag and waits on the lock:
```c
rte_atomic_store_explicit(&qconf->stats_read_pending, 1, ...);
rte_spinlock_lock(&qconf->lock);  // Starved - main loop re-acquires too fa=
st
```

**The fix works**, but it's suboptimal:
- The 10=C2=B5s delay is an arbitrary magic number
- It delays **unconditionally**, even when no stats reader is waiting
- Wastes cycles when the system is idle

### Better Option: Wait for stats completion

The `stats_read_pending` flag already exists to coordinate this handshake b=
ut isn't used fully. The cleaner fix is to make the main loop wait until th=
e stats reader has finished:

```c
rte_spinlock_unlock(&qconf->lock);
/* Wait for stats reader to complete before reacquiring lock */
while (rte_atomic_load_explicit(&qconf->stats_read_pending,=20
                                 rte_memory_order_relaxed) !=3D 0)
    rte_pause();
```

This approach:
- Uses the existing synchronization mechanism as intended
- Only yields when stats are actually being read
- Has zero overhead when no stats read is pending
- Doesn't introduce arbitrary magic constants
- Guarantees the stats reader gets the lock (not probabilistic)

### Alternative: Conditional delay

If you want to keep the delay approach, at least make it conditional:

```c
rte_spinlock_unlock(&qconf->lock);
if (stats_read_pending)
    rte_delay_us(10);
else
    rte_pause();
```

This avoids the unconditional 10=C2=B5s penalty on every iteration.

### Verdict

**NAK as-is.** The fix works but the better solution is to properly use the=
 existing `stats_read_pending` handshake. Would suggest the author revise t=
o use the wait-for-completion pattern instead of an arbitrary delay.
