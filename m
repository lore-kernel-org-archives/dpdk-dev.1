Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A500C531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 989CD40269;
	Sun, 26 Jul 2026 19:27:47 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 8A35740150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:27:46 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc97653887so22725915ad.1
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785086865;
 x=1785691665; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8CaVn9ND8WV1CtQUkl35w7VCuBoHuTmL6UeNXsOjVxA=;
 b=tcu2RYWfO4NAW3nAkQpqxznPbG13GOEyJLuCgAMcvzczoG9n9Ag9foHe/lR3ISUyn6
 17TwZeyZmMYRjTbZwsZMVlLxwP7c0K5c3L4XXeCdzKHboiA2i15MuoQiseYpkJi99V75
 FYS97MENg+QPXuxP9+e098w0bRoudOYwamtPSfaIl7ydVeTToVqPY9aVPZ+jLgR3Y14i
 LUIOEogIancpGnBdzf+iB/+dlHcIBatZ+4ghpgdfaFZNbL4Wo6GlCVs0/Av4z3i8h71A
 lOLPFDD07FTSYK6GacrgOou/3tG0Pt+d9ITU+1eY9SMXvoeHvidl/4SN2pDc9acaX01J
 4xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785086865; x=1785691665;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8CaVn9ND8WV1CtQUkl35w7VCuBoHuTmL6UeNXsOjVxA=;
 b=ettEbo8vVAGL0at0YtnIelGQC4OFK+HufaGFPXM3SeeoKDIXKlPZ/LzmHEy6hWGETc
 tCv4SACVcHg6SoFh604kqSwSwDRtORGxaGhXmOPCMq+JB14gBTpiTlBnbRLdW9QNwz2c
 s/EieeV1n7YdEOBTs8qGlAbMs9q8kPhilPHEmyTKscM3zs8ipyKcgTQKuwkS8NglLplR
 CaDON17RWI1QGOvs3V6V0vY6Mg0VA51MwhBGmlPhMJTaSmcs5bcycrzZTKklwX0Bnjmp
 CVTsbH+d4pPKX45l9iNhrsQmxbFO7zCwZ+A4Mkp1/Wjjc6miMaN3W8vi6i6IFCcvF2GV
 yUkQ==
X-Gm-Message-State: AOJu0YziuDVhJZchWiv+xJNLBR7BFwQ6cCw/l6I/1OaAUQqjSUYJI/w8
 2Pmu4eH3aLoRGJJerGCDRwGpT3vEonXnV6bRYNdDM2J2YG5tpaqFjw2aHSQJs/5G/QLr94WI1el
 1X46Q
X-Gm-Gg: AR+sD114wYBzENBv5QzTjmecUPJYcKxaZUIxxBW273/GAJXLjZkEsihWHHieRhIn6D5
 lBt8dpw2UywtCagcPliXemyXyYOyOf8ZC6q58Q21T836B6+lBTdtKz/NDXCOdEoq7KqHKUHLCSe
 WXATBJ5685JoWGYj1YNxBr2cNjc4tE5CTE13WVHoMtzDxYPoZwFbCBMm2HsxnPUvHqtTaQ4Y3Pz
 stXL4JL+W5IjUrkjVDL/e0CAEn81l3+LOJTlT2/qsJ+8spl8Cos2nO082kUqKweLevjzTZ1nMB/
 i8QrFJQUiXTMpHW+k+wjjCFzqONcxMcJ8oHSaVk8Va1p5Td4ga58hsf3zZl8gH+T5z25k5f9NYp
 SFgMAXhOzh0cAZiuueSzUj1MYev0t5cx2SmNcXMxNFDPR1MmsauaN8txeAlldSNzLT6F99Ovl6K
 Ezb1/F0XISOpY5jP4GdktbnQUp+SQ/ju5QD6sR2I0OFKw=
X-Received: by 2002:a17:903:4b4f:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2cfde795524mr54864675ad.4.1785086865383; 
 Sun, 26 Jul 2026 10:27:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc549cacsm22798116eec.16.2026.07.26.10.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:27:45 -0700 (PDT)
Date: Sun, 26 Jul 2026 10:27:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] net/tap: fix Rx queue interrupt support
Message-ID: <20260726102742.5c9bcf34@phoenix.local>
In-Reply-To: <20260720120700.801099-1-maxime@leroys.fr>
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260720120700.801099-1-maxime@leroys.fr>
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

On Mon, 20 Jul 2026 14:06:56 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> The tap PMD registers each queue file descriptor for Rx interrupts but the
> feature is not usable through the generic API. This series fixes two
> distinct issues against the original Rx interrupt support, plus a small
> type cleanup.
> 
> Patch 1 adds the missing rx_queue_intr_enable/disable ops. Without them
> rte_eth_dev_rx_intr_enable() returns -ENOTSUP, so applications that arm
> queues before sleeping (l3fwd-power and similar) treat tap as having no
> interrupt support and fall back to polling.
> 
> Patch 2 fixes a traffic stall specific to interrupt mode: the Rx burst
> skips reading the queue fd until the SIGIO trigger advances, but in
> interrupt mode the application wakes through epoll, a distinct signal, so
> the burst can return 0 right after a wakeup and the fd stays readable with
> no further edge. The fd is now drained unconditionally in interrupt mode
> and the SIGIO trigger is not armed on the data queue fds.
> 
> Patch 3 converts the driver's int-as-boolean fields to bool.
> 
> Patches 1 and 2 are candidates for stable.
> 
> v2:
>  - use bool for the new interrupt-mode fields instead of int (Stephen);
>    both fit existing padding, so neither struct grows
>  - add patch 3 converting the existing int booleans to bool
> 
> The coding_style.rst note that discouraged bool in structures no longer
> matches DPDK practice; it is dropped by a separate patch.
> 
> Maxime Leroy (3):
>   net/tap: support Rx queue interrupt enable/disable
>   net/tap: drain queue FD in Rx interrupt mode
>   net/tap: use bool for boolean flags
> 
>  drivers/net/tap/rte_eth_tap.c | 25 +++++++++++++++++++-
>  drivers/net/tap/rte_eth_tap.h | 11 ++++++---
>  drivers/net/tap/tap_flow.c    |  4 ++--
>  drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+), 6 deletions(-)
> 

Like this but detailed AI review found some things.

Review of [PATCH v2 0/3] net/tap: Rx interrupt fixes

Applied clean to 38f72e5. All three commits build independently under
-Dwerror=true, so the series is bisect-safe. No compiler diagnostics.

Verified against a running tap port (/dev/net/tun, kernel-side traffic),
not just by reading the diffs.


Patch 1/3: net/tap: support Rx queue interrupt enable/disable
------------------------------------------------------------

Confirmed working. rte_eth_dev_rx_intr_enable()/disable() return 0 in
interrupt mode where they previously returned -ENOTSUP, and an
epoll-driven receive loop delivers 100% of offered packets.

The -ENOTSUP branch is not dead code: rte_eth_dev_rx_intr_enable()
validates only the queue id and the op pointer, never intr_conf.rxq, so
the driver is the sole guard.

tap.ini already advertises "Rx interrupt = Y", so no features-matrix
change is needed -- that overclaim is precisely what this patch fixes.

Info: pmd->intr_mode duplicates dev->data->dev_conf.intr_conf.rxq, which
tap_rx_intr_vec_install() already reads directly. The rx_queue copy earns
its place on the fast path; the pmd_internals copy is redundant state
that can drift. Not blocking.


Error (pre-existing, but patch 2 makes it reachable)
---------------------------------------------------

tap_tx_queue_release() dereferences dev->data->rx_queues after ethdev has
already freed it:

  /* lib/ethdev/rte_ethdev.c */
  reset_queues:
        eth_dev_rx_queue_config(dev, 0);   /* rte_free(rx_queues); = NULL */
        eth_dev_tx_queue_config(dev, 0);   /* -> tap_tx_queue_release()  */

  /* drivers/net/tap/rte_eth_tap.c */
  if (dev->data->rx_queues[qid] == NULL)   /* rx_queues is NULL here */

Confirmed by three independent reproducers, all segfaulting in
tap_tx_queue_release():

  1. reconfigure that trips patch 2's new intr_mode check
  2. reconfigure that trips the pre-existing nb_rx != nb_tx check
     (intr_conf.rxq never set -- so this is NOT introduced by the series)
  3. rte_eth_dev_internal_reset() on a normally configured port, with no
     dev_configure failure at all

Path 3 matters independently of this series: bonding's member_remove()
calls rte_eth_dev_internal_reset() unconditionally, so removing a tap
port from a bonding device crashes on current main.

Both ethdev call sites free rx before tx, so tap_rx_queue_release()'s
symmetric read of dev->data->tx_queues[qid] is always safe. Only the tx
side needs the guard, though guarding both is cheap.

This is not your bug. But patch 2 adds a second failure return to
tap_dev_configure() that fires on an ordinary reconfigure, and the commit
message points users straight at it -- an application trying to toggle
interrupt mode crashes instead of receiving -ENOTSUP. Suggest a
preceding patch in the series fixing the deref, with its own Fixes: and
Cc: stable@dpdk.org.


Patch 2/3: net/tap: drain queue FD in Rx interrupt mode
-------------------------------------------------------

The mechanism works as designed. Verified at the kernel fd-flag level
(/proc/PID/fdinfo) that in interrupt mode the data queue fd is created
without O_ASYNC while the keep-alive fd retains it:

  patch 1 only : ka fd O_ASYNC=yes, data fd O_ASYNC=yes
  full series  : ka fd O_ASYNC=yes, data fd O_ASYNC=no

The early return in tun_alloc() sits after the O_NONBLOCK fcntl, so
nothing required is skipped and there is no fd leak. Reading dev_private
is safe: rte_eth_dev_release_port() frees it on close, so "close and
reopen the port to change it" is accurate.

Warning: I could not reproduce the stall this patch fixes. With patch 1
applied alone -- SIGIO still armed on the data fd -- three traffic
patterns all delivered every packet with zero empty bursts after a
wakeup:

  - low-rate broadcast ARP        : 117/117 rx, 0 empty after wake
  - flood ping, static neighbour  : 437/437 rx, 0 empty after wake
  - strict l3fwd-power-style loop
    (one burst per wakeup, no
     re-poll) with bursty traffic : 100/100 rx, 0 empty after wake

The full series produced identical numbers in each case. Single queue,
single core, kernel-side tap traffic, so this does not disprove the race
-- it may need multiple queues, higher rates than the tap path gives, or
signal-queue pressure. But the justification is not demonstrated by any
reproducer I could build, and the patch has real cost: a permanent
restriction that interrupt mode cannot be toggled after configure, a new
error path that exposes the crash above, a fast-path branch, and a
readv() syscall on every idle burst (exactly what the SIGIO trigger
exists to avoid).

Could you share a reproducer, or describe the configuration where the
stall appears? Note that the Rx interrupt epoll registration is
edge-triggered (EPOLLIN|EPOLLPRI|EPOLLET in rte_intr_rx_ctl), which is
what would turn a single missed read into a permanent stall rather than
a spin -- that detail seems worth stating explicitly in the commit
message, since it is the part that makes the failure non-self-healing.

For what it is worth, the EAL side is safe: tap sets
RTE_INTR_HANDLE_EXT, so eal_intr_proc_rxtx_intr() returns early and never
consumes packet bytes from the queue fd.


Patch 3/3: net/tap: use bool for boolean flags
----------------------------------------------

Warning: the conversion is incomplete on its own terms.

  - tap_flow.c:1247 still reads "if (pmd->flow_init == 0 && ...)";
    on a bool this should be "!pmd->flow_init"
  - the three converted fields keep "/* 1 if ... */" comments
  - the local "int persist" in rte_pmd_tap_probe() and the "int persist"
    parameter of pmd_init_internals() were not converted

Info: rte_eth_tap.h uses bool without including <stdbool.h>, relying on a
transitive include via ethdev_driver.h. It compiles; a direct include
would make the header self-contained.

I initially flagged the (set ^ pmd->flow_isolate) idiom in
tap_flow_isolate() as losing idempotency for non-0/1 values under the
bool conversion. There is a "if (set) set = 1;" normalization immediately
above it, so the XOR is correct. Dropped.


Summary
-------

Patch 1 is good and independently verified. Patch 3 needs the leftovers
cleaned up. Patch 2 is mechanically sound but its justification is
unreproduced here, and it should not go in ahead of a fix for the
tap_tx_queue_release() NULL dereference it makes easy to hit.
