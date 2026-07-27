Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB6C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 191C9400EF;
	Mon, 27 Jul 2026 14:49:07 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id E99DC400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 14:49:05 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-81ec29f1d07so29978777b3.1
 for <dev@dpdk.org>; Mon, 27 Jul 2026 05:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785156545; cv=none;
 d=google.com; s=arc-20260327;
 b=X3htbP5FMUsIyLzjPRGYNNt+lJJ6d2yu+loSXN692Z5clOKQeiEnpA9VwekjYsSkbP
 +fmKXz+c5pKqvTTobrNzHlviDVvCHzfP1I0jZli9sb4ma6MJr7mm7TK1XPKj3yTDaPm4
 lEb957VRmJa0sO33YRy3lePByk22jYsOF3iLHlV7sg230XeRsGvOhXfELIwGfcn7P/8v
 sFyX1eP5BmWWMhoQ6822UgdSQIKg8Q0QIFRlGrQsuyXxn5uUe5XRJW1y+Z8vD5BsmDDh
 1qzNNO2obmQKyTvYbMcPeVrlWQC52wVATwuJUX+LsQWSDNDHTXL0VNTofSbUJ3TYezMg
 NR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=uDf8XVnQYRCcal/M5Eg5Qg8AE77efRiJQ1a86MUsG2k=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=HSX7K5Yg9m0fQ57t2noLGnIk77ys9sSRWh2kf+2Pz8T9fqrZS57FsIXORt7hQeHkcD
 jlfg/ibAfNAvZoGaUntrRxDg17ehuGukStLChofY8bVdA3UyWFXfoydUUQQbJD9hPt+K
 3i4K3HNd9DY8kTeefEjY8Eqtnl/0UqQLUjD4o+J7DtVBI3m1gDYahzDBmYD2M+FPfCJC
 JCs6/OpHrrGFEFWeawV83K5r9PbEDY+LuZGLrBOrTvgJjHiQLOikr509l5U2aQr3cv6s
 JRLdx8X1/32fMuHKEFQTCTOBkKHHsJyXi79eMhlC86NFUdWugP/xW15AeOODjIo4vGpB
 /K8Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156545; x=1785761345;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uDf8XVnQYRCcal/M5Eg5Qg8AE77efRiJQ1a86MUsG2k=;
 b=IrV2Ufp3+/RQ2vMmmckFzovLsU2v9oJ0pboHkBS3uLVcxE60KPvl1go+9U4yEvJYYh
 6US7l6QldWzJJ8/ujIbly36jCnZcS+sG9yC/hCkahobIt7Rr8Wq5AMnOUeqEpEtZb8Nm
 bG+VS1j43+eObPwa/ZyBzEXzyyWEZVZsXDiaJ0HhaiLC6eNtMQMjLK4xXibwR6l4vEQa
 8Ue5Z2kKrGEBHjPzl+fUEoA5ASWhxL+mPLY8bni35Rlxqbt0PorsOzoWAzSEeH4juQ8U
 N50znTyr3FTceLVkTn7B5RweYCCFN4WIF/70yapFoZUJvJ5d7OY7NOiHseTfcNJDvyCF
 5bkg==
X-Gm-Message-State: AOJu0YwWTPO2aRRF7yxC2Dx7KQrJdS+xNoujzoMTNpIYizYwB7q7FdQx
 8QjMccon1r2QHp0pC3zS5M65kWyM/K4S/pAM/kVEscEGcZ8gXwsXneaeRQZ/CA4zbbv5hvhVjju
 2GPnn48VOxQ8QUtlLVwKZ8yNBmrgA+v8=
X-Gm-Gg: AR+sD13dSoFtPrJuDcLHg3JGJxYnlSEXhuiW6TkkkPbGXDvUEMbrVz3twXUNOxMg+p3
 Ez8RJ07KxgMR3vRNATi6Z05NTzp3JmoQjJg7HKdr5myQgT2uUoCLJ/8gCoi4W4x9WcMfB0X4wfc
 +w270sQbqHJZuS2TFMmG/B/wGiT4uPLLFdmzO7sVoDo4bIMbYc1o1w36x4D7IcppQkuK6jh5aOu
 izJtPh822Ht3rtNjRJp5ErL4eBWFB4VHzzE67Jj4EMemXveUteouPyO4lo=
X-Received: by 2002:a05:690c:6c0d:b0:81e:2b86:d75f with SMTP id
 00721157ae682-81f90929c55mr1278697b3.68.1785156544829; Mon, 27 Jul 2026
 05:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260720120700.801099-1-maxime@leroys.fr>
 <20260726102742.5c9bcf34@phoenix.local>
In-Reply-To: <20260726102742.5c9bcf34@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 27 Jul 2026 14:48:53 +0200
X-Gm-Features: AUfX_mzmllilVNQYcXQf7J3fi7uI6E6iI2l8-YxtP62RRrh2rqS6CRpSaCzyQ-Q
Message-ID: <CAHHRULWNPMQFHMH=akH5ph+bY3GYisjK6sniOuXG2puO+Lx_mg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] net/tap: fix Rx queue interrupt support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Jul 26, 2026 at 7:27=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 20 Jul 2026 14:06:56 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > The tap PMD registers each queue file descriptor for Rx interrupts but =
the
> > feature is not usable through the generic API. This series fixes two
> > distinct issues against the original Rx interrupt support, plus a small
> > type cleanup.
> >
> > Patch 1 adds the missing rx_queue_intr_enable/disable ops. Without them
> > rte_eth_dev_rx_intr_enable() returns -ENOTSUP, so applications that arm
> > queues before sleeping (l3fwd-power and similar) treat tap as having no
> > interrupt support and fall back to polling.
> >
> > Patch 2 fixes a traffic stall specific to interrupt mode: the Rx burst
> > skips reading the queue fd until the SIGIO trigger advances, but in
> > interrupt mode the application wakes through epoll, a distinct signal, =
so
> > the burst can return 0 right after a wakeup and the fd stays readable w=
ith
> > no further edge. The fd is now drained unconditionally in interrupt mod=
e
> > and the SIGIO trigger is not armed on the data queue fds.
> >
> > Patch 3 converts the driver's int-as-boolean fields to bool.
> >
> > Patches 1 and 2 are candidates for stable.
> >
> > v2:
> >  - use bool for the new interrupt-mode fields instead of int (Stephen);
> >    both fit existing padding, so neither struct grows
> >  - add patch 3 converting the existing int booleans to bool
> >
> > The coding_style.rst note that discouraged bool in structures no longer
> > matches DPDK practice; it is dropped by a separate patch.
> >
> > Maxime Leroy (3):
> >   net/tap: support Rx queue interrupt enable/disable
> >   net/tap: drain queue FD in Rx interrupt mode
> >   net/tap: use bool for boolean flags
> >
> >  drivers/net/tap/rte_eth_tap.c | 25 +++++++++++++++++++-
> >  drivers/net/tap/rte_eth_tap.h | 11 ++++++---
> >  drivers/net/tap/tap_flow.c    |  4 ++--
> >  drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 78 insertions(+), 6 deletions(-)
> >
>
> Like this but detailed AI review found some things.
>
> Review of [PATCH v2 0/3] net/tap: Rx interrupt fixes
>
> Applied clean to 38f72e5. All three commits build independently under
> -Dwerror=3Dtrue, so the series is bisect-safe. No compiler diagnostics.
>
> Verified against a running tap port (/dev/net/tun, kernel-side traffic),
> not just by reading the diffs.
>
>
> Patch 1/3: net/tap: support Rx queue interrupt enable/disable
> ------------------------------------------------------------
>
> Confirmed working. rte_eth_dev_rx_intr_enable()/disable() return 0 in
> interrupt mode where they previously returned -ENOTSUP, and an
> epoll-driven receive loop delivers 100% of offered packets.
>
> The -ENOTSUP branch is not dead code: rte_eth_dev_rx_intr_enable()
> validates only the queue id and the op pointer, never intr_conf.rxq, so
> the driver is the sole guard.
>
> tap.ini already advertises "Rx interrupt =3D Y", so no features-matrix
> change is needed -- that overclaim is precisely what this patch fixes.
>
> Info: pmd->intr_mode duplicates dev->data->dev_conf.intr_conf.rxq, which
> tap_rx_intr_vec_install() already reads directly. The rx_queue copy earns
> its place on the fast path; the pmd_internals copy is redundant state
> that can drift. Not blocking.
>
It is not a copy of the current value but the one locked by the first confi=
gure.
rte_eth_dev_configure() has already written the new dev_conf by the time
tap_dev_configure() runs, so comparing against dev->data->dev_conf.intr_con=
f.rxq
would compare the new value with itself and the mode change could never be
detected.


>
> Error (pre-existing, but patch 2 makes it reachable)
> ---------------------------------------------------
>
> tap_tx_queue_release() dereferences dev->data->rx_queues after ethdev has
> already freed it:
>
>   /* lib/ethdev/rte_ethdev.c */
>   reset_queues:
>         eth_dev_rx_queue_config(dev, 0);   /* rte_free(rx_queues); =3D NU=
LL */
>         eth_dev_tx_queue_config(dev, 0);   /* -> tap_tx_queue_release()  =
*/
>
>   /* drivers/net/tap/rte_eth_tap.c */
>   if (dev->data->rx_queues[qid] =3D=3D NULL)   /* rx_queues is NULL here =
*/
>
> Confirmed by three independent reproducers, all segfaulting in
> tap_tx_queue_release():
>
>   1. reconfigure that trips patch 2's new intr_mode check
>   2. reconfigure that trips the pre-existing nb_rx !=3D nb_tx check
>      (intr_conf.rxq never set -- so this is NOT introduced by the series)
>   3. rte_eth_dev_internal_reset() on a normally configured port, with no
>      dev_configure failure at all
>
> Path 3 matters independently of this series: bonding's member_remove()
> calls rte_eth_dev_internal_reset() unconditionally, so removing a tap
> port from a bonding device crashes on current main.

Agreed. I will fix it in the next version.

>
> Both ethdev call sites free rx before tx, so tap_rx_queue_release()'s
> symmetric read of dev->data->tx_queues[qid] is always safe. Only the tx
> side needs the guard, though guarding both is cheap.
>
> This is not your bug. But patch 2 adds a second failure return to
> tap_dev_configure() that fires on an ordinary reconfigure, and the commit
> message points users straight at it -- an application trying to toggle
> interrupt mode crashes instead of receiving -ENOTSUP. Suggest a
> preceding patch in the series fixing the deref, with its own Fixes: and
> Cc: stable@dpdk.org.
>
>
> Patch 2/3: net/tap: drain queue FD in Rx interrupt mode
> -------------------------------------------------------
>
> The mechanism works as designed. Verified at the kernel fd-flag level
> (/proc/PID/fdinfo) that in interrupt mode the data queue fd is created
> without O_ASYNC while the keep-alive fd retains it:
>
>   patch 1 only : ka fd O_ASYNC=3Dyes, data fd O_ASYNC=3Dyes
>   full series  : ka fd O_ASYNC=3Dyes, data fd O_ASYNC=3Dno
>
> The early return in tun_alloc() sits after the O_NONBLOCK fcntl, so
> nothing required is skipped and there is no fd leak. Reading dev_private
> is safe: rte_eth_dev_release_port() frees it on close, so "close and
> reopen the port to change it" is accurate.
>
> Warning: I could not reproduce the stall this patch fixes. With patch 1
> applied alone -- SIGIO still armed on the data fd -- three traffic
> patterns all delivered every packet with zero empty bursts after a
> wakeup:
>
>   - low-rate broadcast ARP        : 117/117 rx, 0 empty after wake
>   - flood ping, static neighbour  : 437/437 rx, 0 empty after wake
>   - strict l3fwd-power-style loop
>     (one burst per wakeup, no
>      re-poll) with bursty traffic : 100/100 rx, 0 empty after wake
>
> The full series produced identical numbers in each case. Single queue,
> single core, kernel-side tap traffic, so this does not disprove the race
> -- it may need multiple queues, higher rates than the tap path gives, or
> signal-queue pressure. But the justification is not demonstrated by any
> reproducer I could build, and the patch has real cost: a permanent
> restriction that interrupt mode cannot be toggled after configure, a new
> error path that exposes the crash above, a fast-path branch, and a
> readv() syscall on every idle burst (exactly what the SIGIO trigger
> exists to avoid).
>
> Could you share a reproducer, or describe the configuration where the
> stall appears? Note that the Rx interrupt epoll registration is
> edge-triggered (EPOLLIN|EPOLLPRI|EPOLLET in rte_intr_rx_ctl), which is
> what would turn a single missed read into a permanent stall rather than
> a spin -- that detail seems worth stating explicitly in the commit
> message, since it is the part that makes the failure non-self-healing.

The drain patch, a reproducer

   https://github.com/DPDK/grout/actions/runs/30259855532/job/89956997416

 grout has an opt-in mode where an idle dataplane worker stops busy polling=
 and
 blocks on its Rx queue interrupts through rte_eth_dev_rx_intr_enable() and
 rte_epoll_wait(). Its smoke suite runs on net_tap ports, so that mode exer=
cises
 this path in CI.

 At sha b2f775810a6a the vendored DPDK carries the intr enable/disable patc=
h but
 not the drain one, which isolates it, and build-and-tests (x86_64, gcc-14,
 DPDK 25.11, FRR 10.5, adaptive-irq) fails on smoke/bgp_frr_test.sh:

   timeout: icmp_seq=3D1
   [tx p0] ICMP echo request id=3D28908 seq=3D2
   [rx p0] ICMP echo reply   id=3D28908 seq=3D1
   [rx p0] ICMP echo reply   id=3D28908 seq=3D2
   reply from 16.0.0.1: icmp_seq=3D2 ttl=3D64 time=3D0.083 ms
   error: command failed: Connection timed out (ETIMEDOUT)

 The reply to seq=3D1 sits readable in the queue fd. The burst that ran aft=
er the
 epoll wakeup returned 0, and being edge triggered there is no second wakeu=
p for
 data already queued, so it comes out only when the request for seq=3D2 cre=
ates a
 new edge: both replies at once, and the first ping times out. The previous
 revision that morning, 08f1ccd941bb, carries both patches and the same job
 passes.

 What the trace establishes is that pmd_rx_burst() ran and returned 0
with the fd
 readable, so tap_trigger had not advanced at that point. It can lag becaus=
e the
 trigger is process wide and the fd owner is the process:

       fcntl(fd, F_SETOWN, getpid());

 The signal is therefore handled by some thread of the kernel's
choosing, with no
 relation to the lcore that epoll woke for that queue, while the wakeup goe=
s
 precisely to that lcore.

 A busy polling loop does not care, which is why the trigger has been fine =
since
 2018: it re-reads the counter on the next iteration, so a late signal
costs only
 latency. Interrupt mode bursts once per edge, so it is never caught up.

 On the cost: the mode restriction is there because tap_setup_queue()
reuses queue
 fds across a reconfigure, so without it a port could mix fds with and with=
out
 O_ASYNC. And the crash that made the new error path dangerous is fixed by =
the
 queue release patch, independently of this one.

>
> For what it is worth, the EAL side is safe: tap sets
> RTE_INTR_HANDLE_EXT, so eal_intr_proc_rxtx_intr() returns early and never
> consumes packet bytes from the queue fd.
>
>
> Patch 3/3: net/tap: use bool for boolean flags
> ----------------------------------------------
>
> Warning: the conversion is incomplete on its own terms.
>
>   - tap_flow.c:1247 still reads "if (pmd->flow_init =3D=3D 0 && ...)";
>     on a bool this should be "!pmd->flow_init"
>   - the three converted fields keep "/* 1 if ... */" comments
>   - the local "int persist" in rte_pmd_tap_probe() and the "int persist"
>     parameter of pmd_init_internals() were not converted
>
> Info: rte_eth_tap.h uses bool without including <stdbool.h>, relying on a
> transitive include via ethdev_driver.h. It compiles; a direct include
> would make the header self-contained.
>
> I initially flagged the (set ^ pmd->flow_isolate) idiom in
> tap_flow_isolate() as losing idempotency for non-0/1 values under the
> bool conversion. There is a "if (set) set =3D 1;" normalization immediate=
ly
> above it, so the XOR is correct. Dropped.

Agreed. I will fix it in the next version.

>
>
> Summary
> -------
>
> Patch 1 is good and independently verified. Patch 3 needs the leftovers
> cleaned up. Patch 2 is mechanically sound but its justification is
> unreproduced here, and it should not go in ahead of a fix for the
> tap_tx_queue_release() NULL dereference it makes easy to hit.

-------------------------------
Maxime Leroy
maxime@leroys.fr
