Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C18CC6B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 03:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A9704027C;
	Thu, 15 Oct 2026 05:09:31 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8CAA44025A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 05:09:30 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1707392a12.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792033769;
 x=1792638569; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BZmuixiqA1KrpGlF3qnfeOk0sN3EjKlJQmePIH3kdjI=;
 b=MtAv/qH38nP7Loa0RuHoQ4c1WtfqAAGtyc4XYrmZq19fUDoEnU6MhZsspOa4GsdZKK
 CSH7Q2lVd3dnE68pwqV4NyZ4+76VqU0LLhGHCEYgXZVM7LDxt5UHthMh9n4fFcvo6h/s
 FqKVwZ1/JcdBh4O4dzvghVxsCvABdBtwJdh3AJ07Ka7x0K69YEpoDqsR5Tmulp58eGfO
 RgIylO99rPBwctzg6Eyz4/HtR2BjIGqZkfcaybXa4YdngLeQdf+Jp/GpoqOh5P/DcJGa
 uZdncyeCwT1YFmzcmkb15rwsGYtuifz6GlU0gXYSsQDgPAxLVW/l+T69wfFWKbmMhHEg
 ZvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792033769; x=1792638569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BZmuixiqA1KrpGlF3qnfeOk0sN3EjKlJQmePIH3kdjI=;
 b=a7CbRA826ed08dFBws4qWPY/Gej/84HAoI/qT6VpUVhjxAMKGIj22IAUwoFQeRKLPP
 cwEqzgRIAPjwexT86AGBO1qfZRkt/1Zs9PBdgszRWfFvPeXSEbF2lxtCG1qXwx2+GszX
 fHZxnzF6KWpZxgNgqzRBZbyyGDP4xFonsCIHgiLwh7PcqD9Q9Rj1pEJn6V3XtiNQqZAZ
 lwd1D7QDlLXCDwpM6emJfvluL0pqF7thloHHAT5gE64x/kq8Eb5nzJB1hLstdPM8XTz9
 Xhwsv1SKDMpwtPSvNu05xoPu88qfqJD1EXMB/ZC8Lz5XUdcIWVPUHtcGN0SFYuoakCHE
 /hqQ==
X-Gm-Message-State: AFq9FYIzoeA5+PpTrfmOZlLqnjsWQh7aUbEFG8m0xFJL09R3IlBSsHKx
 10DpboGJ3QNT8z2cDemjSBRKdsegkU9GyH7JYs6fH1hLwUHSR70IHSckmS9jXx12VII=
X-Gm-Gg: AYBFou1UL+XuJtrKbWvOGUawzGgJl/GtXhph3CYU3KzJC6tb83ciBIZvTI07/saWSaT
 bAvB+UOF7XRiQOHB3IuTZpQoRgqeKZSZ6LBaUrs9KhqF5Q1Fi8MYw/peGok9uQNthJV+0/N825P
 CYmbL3DXcX0EIR3LVDhzuwOuNcCbuMLckI4sAMIUQ4Wdu2uRr8uxwtDPFoMJfxIyh54O9mobp4c
 iTRmT/H/q4hN2XEjK+WLNUJsNqwe7LP71Q9bsGW/uuh1N9UPqF3lWKmWJgkTq36LImr9txzNGFZ
 3QpmuGo+2VcPgsVNYgXHS0dgSBYHwJopJ6mr4mSM5Vf4YmzW4FWDnnEXVTtxMCzxUlODPzmSotv
 4RLkXtweCBeVgYqbgi4Q4EPeEtcLGtrbO0+EaaKF77F1MJGAft3PsmD6Dgb15HCw7ftIYISwAnF
 LfTj9W1kaoYf/wOskEo+R4hzdQK6CSeFLdLmMoIabMWre5eAKGNePPh/igu1UxUWdNZBqGtuhqB
 zcSC3mNmu2dEdKNKsJFYUltU3gCYwkVsVd2hUWBcw==
X-Received: by 2002:a17:90a:e704:b0:3aa:fc22:8aaa with SMTP id
 98e67ed59e1d1-3ab3b0951e9mr14726516a91.67.1792033769237; 
 Wed, 14 Oct 2026 20:09:29 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a31aa8sm1271647a91.0.2026.10.14.20.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:09:29 -0700 (PDT)
Date: Wed, 14 Oct 2026 20:09:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH 0/6] net/memif: lifecycle fixes and unit test
Message-ID: <20261014200925.6c35e94a@phoenix.local>
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
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

On Wed, 14 Oct 2026 11:12:51 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> This series fixes a set of error-path and lifecycle bugs in the memif
> PMD and adds a unit test for the driver.
> 
> The first five patches are fixes:
> 
>  - guard eth_memif_tx() against an empty burst so a zero-count call
>    returns before touching the burst or the ring;
>  - close file descriptor 0 instead of leaking it (the close path
>    tested for fd > 0 instead of fd >= 0);
>  - free the MAC address allocated during probe when a later step
>    fails, instead of leaking it;
>  - unwind a partially-created device on failure in memif_create(),
>    releasing the port and the process-private data rather than
>    returning with them registered and leaked;
>  - disconnect the device on close so queues and shared regions are
>    torn down, and make memif_disconnect() safe to call on a device
>    that was configured but never started.
> 
> The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest)
> that stands up a server/client vdev pair over a loopback socket and
> covers dev_info, link state, stats, single- and multi-segment loopback,
> stop/start reconnect, empty Tx burst, and close without stop.
> 
> Verified: memif_pmd_autotest passes 9/9; check-git-log and checkpatch
> are clean across the series.


After walking through code when using bonding etc, sometimes apps
send 0 packets as keepalive time call.

AI did find some other things to address..

Series applies cleanly to main (2a58f6e) and builds at every commit
with -Dwerror=true. Not run. No errors; warnings below, so no
Reviewed-by yet.


[PATCH 1/6] net/memif: guard against empty Tx burst

Warning: wrong Fixes tag. The bufs[0]->pool read in the single-pool
check came in with the Tx fast path, not the original driver:

  Fixes: b5613c8f9d0a ("net/memif: add a Tx fast path")

Info: put the check after the ring == NULL block, not before it. An
empty burst in a secondary process then still triggers the region
request through rte_eth_link_get(), as it does in zero-copy mode.


[PATCH 2/6] net/memif: close file descriptor zero

Warning: the zero-copy branch in memif_free_regions() closes an fd
the driver does not own. For i > 0 with ETH_MEMIF_FLAG_ZERO_COPY,
r->fd came from rte_memseg_get_fd() in memif_region_init_zc(), and
rte_memory.h says that fd is EAL internal and read-only. Every
zero-copy client disconnect closes EAL's hugepage fd; the next
connect passes the peer a stale (possibly reused) fd number.
Pre-existing, but this patch edits that exact line. Fix it in a
separate patch in this series instead of making it ">= 0":

	if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
		/* memseg fd is owned by EAL, do not close */
		r->addr = NULL;
		r->fd = -1;
	}

  Fixes: 43b815d88188 ("net/memif: support zero-copy slave")


[PATCH 3/6] net/memif: fix MAC address leak on probe failure

Info: the secondary-process "return -1" -> "return -ENOMEM" change
is not in the commit message. Mention it or drop it.


[PATCH 4/6] net/memif: unwind partial device on create failure

Info: the process_private leak came from multi-process support.
Add a second tag:

  Fixes: c41a04958b09 ("net/memif: support multi-process")


[PATCH 5/6] net/memif: disconnect on device close

Warning: the commit message names the wrong trigger.
rte_eth_dev_close() rejects a started port, so close never runs
"without a preceding dev_stop" on a started device. The real leak:
memif_msg_receive_init() binds pmd->cc on a server without checking
dev_started, so a server port that is stopped or never started still
accepts a peer, and pmd->cc is live at close. Say that; it is what
stable maintainers need to judge the backport.


[PATCH 6/6] test/memif: add memif PMD unit test

Warning: add the test to MAINTAINERS under Memif PMD, as done for
the other PMD tests:

  F: app/test/test_pmd_memif.c

Warning: test_memif_close_without_stop does not cover the fix it
claims to. The throwaway server never has a peer, so pmd->cc is
NULL and memif_disconnect() skips the control channel; only the
NULL queue skip is exercised. Connect a client to the unstarted
server before closing it so ASan catches a cc leak:

	/* server: configure + queue setup, do NOT start */
	ret = rte_vdev_init("net_memif_test_tmpc",
		"role=client,id=1,socket-abstract=yes,"
		"socket=memif-autotest-tmp");
	cport = find_port("net_memif_test_tmpc");
	TEST_ASSERT(configure_port(cport) == 0, "client start failed");
	usleep(CONNECT_DELAY_US);	/* server accepts, binds cc */
	ret = rte_eth_dev_close(port);	/* server, cc live */

Warning: test_memif_setup() returns TEST_SKIPPED when the server
fails to probe. memif on an abstract socket needs no privilege or
hardware, so a probe regression would be reported as a skip. Return
TEST_FAILED there, and in test_memif_close_without_stop().

Info: the Tx fast path is never exercised. Both ports use bsize=512,
which is below the mbuf data room (2048), so eth_memif_tx() always
takes the slow path and the single-pool copy loop is untested. Add a
single-segment loopback on a pair using the default bsize.

Info: stale comments in the multiseg test. BIG_PKT_LEN says
"> default pkt_buffer_size (2048)" but the pair runs bsize=512.
WRAP_PKTS is derived from RING_SIZE, which memif ignores
(nb_tx_desc is __rte_unused); the memif ring is rsize, default
2^10. It wraps only because each packet takes 8 descriptors. Make
it explicit:

	#define MEMIF_LOG2_RING	8
	/* add ",rsize=8" to both MEMIF_*_ARGS */
	#define WRAP_PKTS	((1 << MEMIF_LOG2_RING) / 8 + 8)

Info: test_memif_send_receive checks only the first payload byte,
while the commit message says payload is verified. Check it all:

	plen = PKT_LEN - sizeof(struct rte_ether_hdr);
	for (k = 0; k < plen; k++)
		if (p[k] != (uint8_t)(got + k))
			break;


Not in this series, found while reading the Tx path:

eth_memif_tx_zc() returns uint16_t but does "return -1" when the
interrupt fd is invalid, so the caller sees 65535 packets sent after
ring->head has already been published. It is reachable:
memif_init_queues() only warns and continues with fd -1 when
eventfd() fails. Skip the kick instead, as eth_memif_tx() does:

	if ((ring->flags & MEMIF_RING_FLAG_MASK_INT) == 0 &&
	    rte_intr_fd_get(mq->intr_handle) >= 0) {
		uint64_t a = 1;
		ssize_t size = write(rte_intr_fd_get(mq->intr_handle),
				     &a, sizeof(a));
		...
	}

  Fixes: aedd054c5c2a ("drivers: check interrupt file descriptor validity")
  Cc: stable@dpdk.org
