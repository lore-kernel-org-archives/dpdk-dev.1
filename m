Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362ECC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 227E6400EF;
	Thu, 15 Oct 2026 13:14:52 +0200 (CEST)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTP id 315AB40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:14:51 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id D9467E04F0;
 Thu, 15 Oct 2026 13:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792062890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCp+0Cttf4LzxGwPM95IqJyV6PANzGryZ7IjWYs53Gg=;
 b=mJFs3uXEGRFZEEHvxdNlTScpfX4bE5wiNA64xwqNJUHtTeJXnErFLb7FPp8h1HSZuD/nLj
 eKX06bKEFelP3sgWIMEWHae/CLXGCo5nTNu/u7j1pIDF5F9i/zuVFd61yMivpnMt48REip
 YlSmnVoL0dc2+zMvr+Hyw53hocfxfqxhIBRgGHztsVZHKCfZVbTQ9ZGsoeWE47WInN+hjy
 sbHLpzyFBubbRFN111HqqHBTImUova0hhoMdIkY15urk5LkWoBhVAfMz56oOiisLcgrcaT
 1TcbTqt/M4QqVtjJPS8IcclqYF5yJyCOANImeORbRvIOdVawSBD/lW/nd61XIQ==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 0/4] net/af_packet: do not return outgoing packets from
 rte_eth_rx_burst
Date: Thu, 15 Oct 2026 12:14:30 +0100
Message-ID: <20261015111434.1470973-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009151015.742011-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
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
requires the bpf() syscall, for example, which might not be
available.

For this reason, this series adds the ignore_outgoing=<0|1> devarg.
When set, the PMD ensures that rte_eth_rx_burst() only returns
incoming traffic. The default is 0 so that existing software works
as before.

The ignore_outgoing test tags the frames it injects so that it can
distinguish them from stray frames, which would otherwise be counted
as well and could lead to a wrong result. As the pre-existing
loopback test could suffer from stray frames as well, the first patch
changes it to use tagged frames.

The second patch adds filtering of outgoing packets in the PMD
because that works in all supported kernel versions and for all
queue counts. The test creates an AF_PACKET vdev and injects frames
at the fd end of the TAP device and via a second AF_PACKET vdev.
Frames from the fd end arrive as incoming traffic and frames from
the second vdev as outgoing traffic, so with ignore_outgoing=1 the
first vdev should return only the incoming frames. The frames from
the fd end are required to distinguish a dead device from one which
dropped the outgoing frames.

The third patch adds PACKET_IGNORE_OUTGOING which moves the
filtering into the kernel. It is supported since Linux 4.20 but only
works for single-queue AF_PACKET scenarios. Multi-queue AF_PACKET
is still filtered in the PMD.

The fourth patch adds PACKET_FANOUT_FLAG_IGNORE_OUTGOING which is
supported since Linux 6.2 and moves the filtering into the kernel
for the multi-queue scenarios. The kernel does not expose a direct
way to check whether it supports PACKET_FANOUT_FLAG_IGNORE_OUTGOING
but it also does not return an error when the sockopt is set on
kernels that do not support it. Because of that the sockopt is set
opportunistically. The PMD check is kept, since older kernels accept
the flag without effect and support cannot be detected.

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

They show that the setsockopt succeeds even on the old kernel that
does not support PACKET_FANOUT_FLAG_IGNORE_OUTGOING, so setting it
opportunistically is fine. They also show that the code only tries to
set PACKET_FANOUT_FLAG_IGNORE_OUTGOING or PACKET_IGNORE_OUTGOING when
requested by ignore_outgoing=1. And it shows that
PACKET_IGNORE_OUTGOING is used for single and
PACKET_FANOUT_FLAG_IGNORE_OUTGOING for multi-queue.

I have also manually ran testpmd in all modes and both kernels to
verify that ignore_outgoing works as expected, sending packets and
checking what testpmd was receiving (``set verbose 1``).


v6:
- add tags to frames to distinguish injected ones from stray ones
- update the loopback and ignore_outgoing tests to count only tagged
  frames
- inject frames as incoming to distinguish a dead port from a
  working one in ignore_outgoing=1
- bound the receive flush so a continuous stream cannot hang the test
- quote rte_eth_rx_burst() with double backticks in the docs
- use Linux 6.2 instead of v6.2 throughout the code and the docs
- add a paragraph to af_packet.rst on single-queue and multi-queue
  filtering
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


Frank Dressler (4):
  test/af_packet: ignore stray packets in loopback test
  net/af_packet: filter Rx of outgoing packets in the PMD
  net/af_packet: use kernel to filter single-queue Rx
  net/af_packet: use kernel to filter multi-queue Rx

 .mailmap                                  |   1 +
 app/test/test_pmd_af_packet.c             | 301 ++++++++++++++++++++--
 doc/guides/nics/af_packet.rst             |   8 +
 doc/guides/rel_notes/release_26_11.rst    |   7 +
 drivers/net/af_packet/rte_eth_af_packet.c |  50 +++-
 5 files changed, 345 insertions(+), 22 deletions(-)

-- 
2.56.0
