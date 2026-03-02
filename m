Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A0EA4E3D
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA0A4028C;
	Mon,  2 Mar 2026 17:23:35 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id C4AE5400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 17:23:33 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cbad8e6610so513452685a.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772468613;
 x=1773073413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8WL/Xztn1FKJvzi40m3g6lSjBguoZbFZmQs0EUqFEM=;
 b=O3rJYq5CPaGj64RJZgtmR0MG2+hP4neUQyGnd6+tVBJbE238Xxdw9qQAUwjjScVG2T
 HsyIxb6IfnjM1k5fPLnq9qjdRB8PwA2ioYPyj9b8LRPUZYtDcml2aPRZ++NiRkBBIXys
 lATO8p0uY/CxFqXsXTSky6KvV5GLVm2o1xXtE2nIK8GGZShZqJpPDa6ks3luM9fmihA+
 eX5LC8af9agtfJv8c0vuL2wLJPdoVBWjtbidp+K2RfYEdjVO6d676lTdBOaJ0uB0PMkp
 uEv/U+mzaQ9h14kBuOexO2qLas1IPYIF0MTvcfQugmcR50f4TV+r+Yx+3r2L3D7mYVoN
 BweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772468613; x=1773073413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p8WL/Xztn1FKJvzi40m3g6lSjBguoZbFZmQs0EUqFEM=;
 b=UJsZSX6Sv4DyNom9W1OBo6aQYx0Y4m+Vn6Bt3pUg9k7mbu5gv5Z3oHxq+oIiKm40V9
 HsV1+YmLncLwUMy5GPLOehVtWYUWWwg+v2k/8fSCp0WY+ZhhI/9saW6IftJGEpCBPFgk
 p/p32EycvNspW9PR/rhAJ9itU8/zDdGiurKgZG6/bo/OLJKh0or5yYCWvmzZ8omwV2y8
 HQi6UIDVD3buhuapb8AiZJ5nMlspq5VgMx/7lsLnkdFALEMrJOh75i8hquDN9IzJM0yp
 BNZNkLQMjchPUo0KQ+9ZWcEstPN37bpqmJ4iGxy+27xxzmroVgPjM+yHSKL8XTHAuUcq
 rsIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgBDd53biXtorp6xZQFfaIEkH7sZWNBsXOMZlc8VdqsSSLUTmKZAYiatTKJ6adSkbPFY=@dpdk.org
X-Gm-Message-State: AOJu0Ywdpn3WQu8QZI9cAQ5x+oy7p3Yg22H6M6EFT64lmmpdnihvao3X
 X6qNDU2dOte36lHZJLcfvOR6PW2zadfd8dNtE1rBZRWoFk774kFSlp181eq2PdKCEwU=
X-Gm-Gg: ATEYQzyKRz34XgdnNjqC1b8JjR3Ve1DHqA4nI9m79qpYRmgoSPpbuDwyLtAoiye/3Fg
 o+0aFSkN5JeVd2keCEVvPIXASJ0W0K8nr39872s98aPrppjNffI/wpGuumFyFTgBemIA096Zgi+
 qUwy5UX1f8aMinQs9DVLMk3wV73qvPZ3lk4eenzDeuTtLyF6SLEQn3dLwWJyNiGTUK9/rYZilLY
 TFMOXyKeKQ7QRHDyR36WD0yToP90eciY05a5nYCXrdqUu/mPeZNJgSR3jVnHuUdfwTJMJdSPLu9
 9ak4WnhG/g9NJy0sQkmUnnrFQNjMExyOHZqD1CnkREeBl6hnncibSlmiWfciAY0Y1Mk8HlNCGyt
 0KPC/8RSJYvD6vylRjOHTIWUgrQdNUcDDvekt1/d4v/51XDAN/IimR4+aHbJokHjyMSSI256Cy/
 5JeVKSSmxHzSPT6sx909n+M3bs2WqprG0NX78IKRDZBRUuN1jB/IuT9Y+eY8diiXwQ
X-Received: by 2002:a05:620a:1a1f:b0:8ca:305b:749b with SMTP id
 af79cd13be357-8cbc8f3626bmr1619365085a.60.1772468612744; 
 Mon, 02 Mar 2026 08:23:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf7175c6sm1200564385a.37.2026.03.02.08.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:23:32 -0800 (PST)
Date: Mon, 2 Mar 2026 08:23:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <orika@nvidia.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/1] examples/l2fwd-jobstats: add delay to show stats
Message-ID: <20260302082328.7036d809@phoenix.local>
In-Reply-To: <20240729062037.3729808-1-rkudurumalla@marvell.com>
References: <20240726053757.3653673-1-rkudurumalla@marvell.com>
 <20240729062037.3729808-1-rkudurumalla@marvell.com>
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

On Mon, 29 Jul 2024 11:50:37 +0530
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

> This patch addresses the issue by introducing a delay
> before acquiring the lock in the loop. This delay allows for better
> availability of the lock, ensuring that show_lcore_stats() can
> periodically update the statistics even when forwarding jobs are running.
>=20
> Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

A more long winded AI analysis of why this example is an architectural mess.


---

## 1. The Main Loop is Structurally Convoluted

The `l2fwd_main_loop()` is the core problem. It uses three nested loops wit=
h a spinlock held across the entire active processing path:

```
for (;;) {                          // outer: infinite
    rte_spinlock_lock(&qconf->lock);
    do {                            // middle: context loop
        // idle job inner loop
        do {                        // inner: busy-wait polling timers
            ...
        } while (!need_manage);
        rte_timer_manage();
    } while (stats_read_pending =3D=3D 0);
    rte_spinlock_unlock(&qconf->lock);
    rte_pause();
}
```

**Problems:**

The **spinlock is held during all packet processing**. It's only released b=
riefly when the stats reader sets `stats_read_pending`, which means `show_l=
core_stats()` on the main thread must wait for the datapath to notice the f=
lag *and* complete a full context cycle before it can acquire the lock. Thi=
s creates an unpredictable latency spike for stats collection and makes the=
 lock contention window essentially unbounded during normal forwarding.

The **inner idle loop is a raw busy-poll** comparing `timer.expire < now` f=
or every RX timer plus the flush timer on each iteration. With 16 ports per=
 lcore (MAX_RX_QUEUE_PER_LCORE), that's 17 comparisons per spin. There's no=
 `rte_pause()` inside the idle loop =E2=80=94 only outside the outer spinlo=
ck unlock. The recent patch you may have seen (replacing `rte_pause()` with=
 `rte_delay_us(10)` after unlock) treats the symptom, not the disease.

The **triple-loop structure makes the control flow genuinely hard to reason=
 about**. The middle `do...while` tests `stats_read_pending` which is set b=
y a remote lcore, but the inner loop checks it too (for `need_manage`). The=
 idle job abort-vs-finish logic (`repeats !=3D 1`) is a subtle optimization=
 that's easy to misread =E2=80=94 if the idle loop body executes exactly on=
ce, the job is aborted rather than finished, meaning the timer was already =
expired on entry.

## 2. The Flush Job Has an Inverted Condition (Possible Bug)

In `l2fwd_flush_job()`:

```c
if (qconf->next_flush_time[portid] <=3D now)
    continue;
```

This **skips flushing when the time has expired**, which is backwards. You'=
d expect to flush when `now >=3D next_flush_time`, i.e. skip when `now < ne=
xt_flush_time`. This means TX buffers only get flushed when they *haven't* =
expired yet =E2=80=94 the opposite of the intended drain behavior. This cou=
ld cause packets to sit in TX buffers far longer than the intended 100=CE=
=BCs drain interval, contributing directly to the "slow" feeling at low tra=
ffic rates.

Additionally, `lcore_id` and `qconf` are fetched twice at the top of this f=
unction for no reason.

## 3. MAC Address Manipulation via Aliasing Violation

In `l2fwd_simple_forward()`:

```c
tmp =3D &eth->dst_addr.addr_bytes[0];
*((uint64_t *)tmp) =3D 0x000000000002 + ((uint64_t)dst_port << 40);
```

This writes 8 bytes into a 6-byte MAC address through a `uint64_t*` cast, w=
hich is both a strict aliasing violation and writes 2 bytes past the MAC ad=
dress into the ethertype field. The intent is to write `02:00:00:00:00:xx` =
as the destination MAC, and it "works" on little-endian x86 because the exc=
ess bytes happen to overwrite `src_addr` bytes that are immediately overwri=
tten by the `rte_ether_addr_copy()` below. But this is fragile, non-portabl=
e, and undefined behavior. On a big-endian architecture this produces a com=
pletely wrong MAC.

## 4. Global Mutable State Everywhere

The application uses an excessive amount of file-scope globals:

- `l2fwd_ports_eth_addr[RTE_MAX_ETHPORTS]`
- `l2fwd_enabled_port_mask`
- `l2fwd_dst_ports[RTE_MAX_ETHPORTS]`
- `lcore_queue_conf[RTE_MAX_LCORE]`
- `tx_buffer[RTE_MAX_ETHPORTS]`
- `port_statistics[RTE_MAX_ETHPORTS]`
- `l2fwd_pktmbuf_pool`
- `hz`, `drain_tsc`, `timer_period`

These are all `RTE_MAX_ETHPORTS`/`RTE_MAX_LCORE` sized arrays, statically a=
llocated regardless of actual usage. `port_statistics` is accessed from bot=
h the datapath lcores (writes) and the stats display callback (reads) with =
**no synchronization** =E2=80=94 the stats numbers can tear on platforms wi=
thout naturally atomic 64-bit loads. The `memset(&port_statistics, 0, ...)`=
 inside the per-port init loop also clears all port stats on each port init=
, not just the current port's.

## 5. The Timer-Driven Architecture Adds Complexity Without Proportional Be=
nefit

The original l2fwd example uses a simple poll loop: check TSC, drain if nee=
ded, burst RX, forward. This jobstats variant replaces that with:

- `rte_timer` for each RX port + flush timer per lcore
- `rte_jobstats` wrappers around each timer callback
- A custom `l2fwd_job_update_cb` that adjusts polling frequency via a hyste=
resis algorithm with asymmetric step sizes (`UPDATE_STEP_UP =3D 1`, `UPDATE=
_STEP_DOWN =3D 32`)

The adaptive polling idea (poll less when idle, poll more when busy) is sou=
nd in theory, but the implementation has issues. The step-up granularity of=
 1 TSC tick is so small relative to step-down of 32 that recovery from an i=
dle period is extremely slow. If the system goes idle for a period and the =
polling interval ramps up, it takes 32x as many busy iterations to ramp bac=
k down. The target of `MAX_PKT_BURST` (32 packets) as the "optimal" value i=
s hard-coded with no way to tune it.

The `rte_timer_manage()` call itself is not free =E2=80=94 it walks the tim=
er skip list on each invocation, adding overhead that a direct TSC comparis=
on in plain l2fwd avoids.

## 6. The Double RX Burst is Questionable

```c
total_nb_rx =3D rte_eth_rx_burst(portid, 0, pkts_burst, MAX_PKT_BURST);
// ... forward all ...
if (total_nb_rx =3D=3D MAX_PKT_BURST) {
    const uint16_t nb_rx =3D rte_eth_rx_burst(portid, 0, pkts_burst, MAX_PK=
T_BURST);
    // ... forward these too ...
}
```

The comment says this "allows rte_jobstats logic to see if this function mu=
st be called more frequently." The total is fed to `rte_jobstats_finish()` =
which compares against the target. But this means `total_nb_rx` can be up t=
o 64 while the target is 32, and the jobstats update callback sees `result =
> target` and decreases the period. The asymmetric step sizes make this int=
eraction even more unpredictable. This also means the prefetch pattern is s=
uboptimal =E2=80=94 the first batch is prefetched and forwarded sequentiall=
y (prefetch one, forward one), which doesn't give the prefetch enough lead =
time to be useful.

## 7. Argument Parsing Edge Cases

`l2fwd_parse_portmask()` returns `unsigned long` cast through `int` (0 mean=
s error), so a mask of 0 is indistinguishable from a parse error. On 64-bit=
 systems where `unsigned long` is 64 bits but `l2fwd_enabled_port_mask` is =
`uint32_t`, masks above 0xFFFFFFFF silently truncate. The port mask check `=
(1 << portid)` throughout the code is undefined behavior for `portid >=3D 3=
2` since `1` is an `int`.

## 8. No Graceful Shutdown

There's no signal handler. The application can only be killed with SIGKILL/=
SIGTERM, leaving ports in an undefined state (promiscuous mode enabled, pot=
entially with traffic still queued in TX buffers). The `rte_eal_cleanup()` =
at the end is unreachable during normal operation since `l2fwd_main_loop()`=
 never returns.

## Summary Recommendations

If you're looking at cleaning this up or using it as a basis for review gui=
delines:

The flush condition inversion should be treated as a bug fix. The main loop=
 should be restructured to separate the stats synchronization concern from =
the packet processing path =E2=80=94 a lock-free stats snapshot approach (d=
ouble-buffering or seqlock) would eliminate the spinlock entirely. The MAC =
address write needs to use `rte_ether_addr` properly. The adaptive polling =
logic needs tunable parameters and a more balanced step function. And ideal=
ly, the example should be reconciled with plain l2fwd to show clearly what =
jobstats *adds* rather than being a near-complete fork with structural dive=
rgence.
