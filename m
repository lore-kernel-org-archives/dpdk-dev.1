Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6601CA601D
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A202240281;
	Fri,  9 Oct 2026 17:11:05 +0200 (CEST)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTP id EFD954025A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 17:11:03 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id B9560E01C0;
 Fri,  9 Oct 2026 17:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791558663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiZBS8Fj2DRnTVIZ5h+qYn3CfPV+SUiZgtcckUYoZJI=;
 b=PdN02Vt4zWUVVhvFiWN4tpSLJzjmEAnKoqyUwgex2y8Yx0EV0Uy1D6BC4qTGNCFL07Nsdn
 lGRFNIaZMWZ/P7Eh43dqO0iqhcxSp/mskYoJwP5tsugdMZ5rKE5Y1kkuar1CAHm9Jb0/lU
 GqhOegjbNNmNGcYStD7PXo+g7r34eQAqrDjmrWWRS/zB1A2HJO/z5O9PezGwRgyMwnKSQy
 6ppWrL9AMQFyNrtzrBvPlE1/irK12i04TRE+FPOEi3OhNLDOC52okNNeQkxMmV5rg0eQKV
 IzZlAMkRjNmD3ELIiIL4bQRQNbxZ+QqYkC6OYu/3gpTERValddFUUnsvq6zyhA==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: [PATCH v5 0/3] net/af_packet: do not return outgoing packets from
 rte_eth_rx_burst
Date: Fri,  9 Oct 2026 16:10:12 +0100
Message-ID: <20261009151015.742011-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005002809.1676723-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
MIME-Version: 1.0
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

In contrast to other PMDs, the AF_PACKET PMD does not only return
incoming but also outgoing packets from rte_eth_rx_burst(). This is
fine for applications similar to tcpdump which usually want to see
both. But it is not always the desired behavior. For example, the
AF_PACKET PMD might be used in a testing environment in which no
regular ethernet PMD works. In such an environment, the AF_PACKET
PMD must behave like a regular one, i.e. not return sent packets
from rte_eth_rx_burst(). One could use the AF_XDP PMD for this but
it has different dependencies than the AF_PACKET PMD because it
requires the ``bpf()`` syscall, for example, which might not be
available.

For this reason, this series adds the ignore_outgoing=<0|1> devarg.
When set, the PMD ensures that rte_eth_rx_burst() only returns
incoming traffic. The default is 0 so that existing software works
as before.

The first patch does this filtering in the PMD because this works
in all supported kernel versions and for all queue counts.

The second patch adds PACKET_IGNORE_OUTGOING which moves the
filtering into the kernel. It is supported since v4.20 but only
works for single-queue AF_PACKET scenarios. Multi-queue AF_PACKET
is still filtered in the PMD.  

The third patch adds PACKET_FANOUT_FLAG_IGNORE_OUTGOING which is
supported since kernel v6.2 and moves the filtering into the kernel
for the multi-queue scenarios. The kernel does not expose a direct
way to check whether it supports PACKET_FANOUT_FLAG_IGNORE_OUTGOING
but it also does not return an error when the sockopt is set on
kernels that do not support it. Because of that the sockopt is set
opportunistically. For kernels v6.2 the filtering will then happen
in the kernel and for earlier versions the PMD does the filtering
for the multi-queue scenario.

Overall we get the following:

              | Single Queue | Multi-Queue
  ------------+--------------+-------------
  Kernel 5.4+ |  in kernel   | in PMD
  Kernel 6.2+ |  in kernel   | in kernel

I tested this on both, kernel 7.2.8 and kernel 5.4.0 with both single
and multiple queues. My results, strace'ing testpmd 7.2.8, with the
variants of ignore_outgoing=0|1 and single/multi-queue:

Kernel 5.4.0:
	qpairs=1,ignore_outgoing=0: -
	qpairs=1,ignore_outgoing=1: setsockopt(14, SOL_PACKET, 0x17 /* PACKET_??? */, [1], 4) = 0
	// 0x17 is PACKET_IGNORE_OUTGOING

	qpairs=2,ignore_outgoing=0: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-1878917532], 4) = 0
	// -1878917532 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
	qpairs=2,ignore_outgoing=1: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-805175699], 4) = 0
	// -805175699 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16

Kernel 7.2.8:
	qpairs=1,ignore_outgoing=0: -
	qpairs=1,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_IGNORE_OUTGOING, [1], 4) = 0

	qpairs=2,ignore_outgoing=0: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-1878978899], 4) = 0
	// -1878978899 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
	qpairs=2,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-805236964], 4) = 0
	// -805236964 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16

They show that the setsockopt succeeeds even on the old kernel that
does not support PACKET_FANOUT_FLAG_IGNORE_OUTGOING, so setting it
opportunistically is fine. They also show that the code only tries to
set PACKET_FANOUT_FLAG_IGNORE_OUTGOING or PACKET_IGNORE_OUTGOING when
requested by ignore_outgoing=1. And it shows that
PACKET_IGNORE_OUTGOING is used for single and
PACKET_FANOUT_FLAG_IGNORE_OUTGOING for multi-queue.

I have also manually ran testpmd in all modes and both kernels to
verify that ignore_outgoing works as expected, sending packets and
checking what testpmd was receiving (``set verbose 1``).


v5:
- remove Co-Authored-By line in patch 2
v4:
- split into PMD filtering, PACKET_IGNORE_OUTGOING for the
  single-queue scenario, and PACKET_FANOUT_FLAG_IGNORE_OUTGOING for
  multiple queues
- set the fanout flag for all kernel versions. kernels that do not
  support it silently ignore it and filtering falls back to the
  PMD-based approach
- changed the test to test both single and multi-queue
v3:
- drop #ifdef PACKET_IGNORE_OUTGOING (uapi since 4.20; DPDK requires kernel >= 5.4)
- fail the test if ignore_outgoing=1 cannot create a port
- drop kernel >= 4.20 notes from docs and release notes
v2:
- use PACKET_IGNORE_OUTGOING / ignore_outgoing= instead of capture_dir


Frank Dressler (3):
  net/af_packet: filter Rx of outgoing packets in the PMD
  net/af_packet: use kernel to filter single-queue Rx
  net/af_packet: use kernel to filter multi-queue Rx

 .mailmap                                  |   1 +
 app/test/test_pmd_af_packet.c             | 150 ++++++++++++++++++++++
 doc/guides/nics/af_packet.rst             |   2 +
 doc/guides/rel_notes/release_26_11.rst    |   6 +
 drivers/net/af_packet/rte_eth_af_packet.c |  50 +++++++-
 5 files changed, 208 insertions(+), 1 deletion(-)

-- 
2.56.0

