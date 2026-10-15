Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0572CCA465
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 19:28:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92F5A402DA;
	Thu, 15 Oct 2026 21:28:18 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id BC5A44027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 21:28:16 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so2918397a91.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792092496;
 x=1792697296; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uNBm/PmfzB1X7hCveUQe/Ox9kuS8FS6suyo7gWXfU/4=;
 b=I1FGPhprLvyagTSWz7rLrlnVwf75oIL6MG0rZwVguFy1FHt367oBGMc+qMq6vdgXDL
 0DnWM0WZsiMx6TYJdScfR1nzKa7OoG72eiomCRZDPl81824YA+/58cZtps4mF7WF7v8o
 9u92BevddavTGoZrIJSOgmdzKUTa2ykcNpNzwaDB666KRv4OG1jFyUU8N+0qgNV8UbbT
 VCB7958Ghz/if0USsnXkV8KY7b45RSqawQ8GopaeGVF6ko/slvD9CKVtkG86HOY0PK/8
 kDzmJMrxE/tt/oD9tqIPDQ2To3wu6hgaZRm+PaKBJrL2N3CvateKZkOYkseDL+HcDeRW
 1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092496; x=1792697296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uNBm/PmfzB1X7hCveUQe/Ox9kuS8FS6suyo7gWXfU/4=;
 b=DwbRWQmvIyupivRDJANv3xtNJenJKgCeZbVa66DCEj4mQfqQUkYfGUtaYu9uJYsLHT
 lufX9NFU+wFevUwNeBbEBI2vPROTZcFgGLvGrmciUs+boHQbyfpN087S2Zi2ZFpvSndk
 BKmBtQQzrFxr+tahNhJvRYli3AKJtkUaiNOeyfg6T8Ws7aX833qf/di5HJK1QO4/zor1
 8Tks1WI98eyfwHtHHLpDzVJ/y0ebhPmpuu7zCFXIAsqWaUDO535rQVVJvhDrORMiayzy
 +wl0hzxK0oj4yapfLQgMZTv9cyYFUjWeSTHhOqc+UZQ6+l8KDCW3XYjHTi0NPWr560F+
 y0ZA==
X-Gm-Message-State: AFq9FYL60sNjFngU63bH8dC4JiOWM+5/AhbytAJM8/J2xDpZ04MljnXs
 VxTKk+dLKYwfcSeM+GqPPSoHU3zoM+q6YCW2l6DElYMswMUqa5XBl9T4Zj9d0Cyc4/NulhfMvEl
 1ZaFK
X-Gm-Gg: AYBFou3D6jJceKUiwHbM/7V/cyaNKqRHswisbxv55fZ/adJfSwcGUQL6i7I8bzNSMaP
 xQ6OEf5337/W50JUhHaMoE5M+ti8UkNd4tBrEsS89xlnUxxhr91kw5Y1eZzcyPR5SXM6OTxlWIB
 Zo0EntgIqDn9I4x68JtO8RCnhs224eGLp/G+m422SeDLZp+9EB1YBkFVxCZxLAmwm/1q5TvvxiG
 zwHwmd7VNb5W74+Ybia6Ag7m1zsJYAOasRArI0Ft20U1ZmKj4EkrPG5cdLXjimMuOWkKB9VeMbj
 7hm8W331FZd1u5Dxp3umYP3clvzL5+0sUoacwL/4ro1dmejB7WgUcBFSg53pLvzZSn5iQrqQA+3
 sp3qBf/rGX8OxZFsfuKSvKxwja52XD73KfUGS29OraLCzh1jQFjs71wRfCOLc7dN/qMYCr24TfT
 zKli4kHmfmTLi7zSHLIdVpsUX8Oa/eGtjHKbsaCQwqKWF69TxR07h3KKROdOOy/MgBpj6qr9WPn
 ZX+IML64j9f6VVvSM7Fv0yY+ENBjVRwF6r/GwNl
X-Received: by 2002:a17:90b:4b85:b0:3a0:7261:d58e with SMTP id
 98e67ed59e1d1-3ab3ab60609mr16654631a91.22.1792092495632; 
 Thu, 15 Oct 2026 12:28:15 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1e1esm594596a91.1.2026.10.15.12.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:28:15 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:28:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/4] net/af_packet: do not return outgoing packets
 from rte_eth_rx_burst
Message-ID: <20261015122813.66f6df2c@phoenix.local>
In-Reply-To: <20261015111434.1470973-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261015111434.1470973-1-frank@dressler.pro>
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

On Thu, 15 Oct 2026 12:14:30 +0100
Frank Dressler <frank@dressler.pro> wrote:

> In contrast to other PMDs, the AF_PACKET PMD does not only return
> incoming but also outgoing packets from rte_eth_rx_burst(). This is
> fine for applications similar to tcpdump which usually want to see
> both. But it is not always the desired behavior. For example, the
> AF_PACKET PMD might be used in a testing environment in which no
> regular ethernet PMD works. In such an environment, the AF_PACKET
> PMD must behave like a regular one, i.e. not return sent packets
> from rte_eth_rx_burst(). One could use the AF_XDP PMD for this but
> it has different dependencies than the AF_PACKET PMD because it
> requires the bpf() syscall, for example, which might not be
> available.
> 
> For this reason, this series adds the ignore_outgoing=<0|1> devarg.
> When set, the PMD ensures that rte_eth_rx_burst() only returns
> incoming traffic. The default is 0 so that existing software works
> as before.
> 
> The ignore_outgoing test tags the frames it injects so that it can
> distinguish them from stray frames, which would otherwise be counted
> as well and could lead to a wrong result. As the pre-existing
> loopback test could suffer from stray frames as well, the first patch
> changes it to use tagged frames.
> 
> The second patch adds filtering of outgoing packets in the PMD
> because that works in all supported kernel versions and for all
> queue counts. The test creates an AF_PACKET vdev and injects frames
> at the fd end of the TAP device and via a second AF_PACKET vdev.
> Frames from the fd end arrive as incoming traffic and frames from
> the second vdev as outgoing traffic, so with ignore_outgoing=1 the
> first vdev should return only the incoming frames. The frames from
> the fd end are required to distinguish a dead device from one which
> dropped the outgoing frames.
> 
> The third patch adds PACKET_IGNORE_OUTGOING which moves the
> filtering into the kernel. It is supported since Linux 4.20 but only
> works for single-queue AF_PACKET scenarios. Multi-queue AF_PACKET
> is still filtered in the PMD.
> 
> The fourth patch adds PACKET_FANOUT_FLAG_IGNORE_OUTGOING which is
> supported since Linux 6.2 and moves the filtering into the kernel
> for the multi-queue scenarios. The kernel does not expose a direct
> way to check whether it supports PACKET_FANOUT_FLAG_IGNORE_OUTGOING
> but it also does not return an error when the sockopt is set on
> kernels that do not support it. Because of that the sockopt is set
> opportunistically. The PMD check is kept, since older kernels accept
> the flag without effect and support cannot be detected.
> 
> Overall we get the following:
> 
>               | Single Queue | Multi-Queue
>   ------------+--------------+-------------
>   Kernel 5.4+ |  in kernel   | in PMD
>   Kernel 6.2+ |  in kernel   | in kernel
> 
> I tested this on both, kernel 7.2.8 and kernel 5.4.0 with both single
> and multiple queues. My results, strace'ing testpmd 7.2.8, with the
> variants of ignore_outgoing=0|1 and single/multi-queue:
> 
> Kernel 5.4.0:
> 	qpairs=1,ignore_outgoing=0: -
> 	qpairs=1,ignore_outgoing=1: setsockopt(14, SOL_PACKET, 0x17 /* PACKET_??? */, [1], 4) = 0
> 	// 0x17 is PACKET_IGNORE_OUTGOING
> 
> 	qpairs=2,ignore_outgoing=0: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-1878917532], 4) = 0
> 	// -1878917532 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=2,ignore_outgoing=1: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-805175699], 4) = 0
> 	// -805175699 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 
> Kernel 7.2.8:
> 	qpairs=1,ignore_outgoing=0: -
> 	qpairs=1,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_IGNORE_OUTGOING, [1], 4) = 0
> 
> 	qpairs=2,ignore_outgoing=0: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-1878978899], 4) = 0
> 	// -1878978899 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=2,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-805236964], 4) = 0
> 	// -805236964 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 
> They show that the setsockopt succeeds even on the old kernel that
> does not support PACKET_FANOUT_FLAG_IGNORE_OUTGOING, so setting it
> opportunistically is fine. They also show that the code only tries to
> set PACKET_FANOUT_FLAG_IGNORE_OUTGOING or PACKET_IGNORE_OUTGOING when
> requested by ignore_outgoing=1. And it shows that
> PACKET_IGNORE_OUTGOING is used for single and
> PACKET_FANOUT_FLAG_IGNORE_OUTGOING for multi-queue.
> 
> I have also manually ran testpmd in all modes and both kernels to
> verify that ignore_outgoing works as expected, sending packets and
> checking what testpmd was receiving (``set verbose 1``).
> 
> 
> v6:
> - add tags to frames to distinguish injected ones from stray ones
> - update the loopback and ignore_outgoing tests to count only tagged
>   frames
> - inject frames as incoming to distinguish a dead port from a
>   working one in ignore_outgoing=1
> - bound the receive flush so a continuous stream cannot hang the test
> - quote rte_eth_rx_burst() with double backticks in the docs
> - use Linux 6.2 instead of v6.2 throughout the code and the docs
> - add a paragraph to af_packet.rst on single-queue and multi-queue
>   filtering

Still see minor issues in AI reviews that need fix before it gets merged.

Subject: Re: [PATCH v6 0/4] net/af_packet: ignore_outgoing devarg

Series applies cleanly to main and builds at every commit with
-Dwerror=true (driver and dpdk-test).

Kernel side checks out: sockaddr_ll is at
TPACKET_ALIGN(sizeof(struct tpacket2_hdr)) as the kernel lays it out,
PACKET_IGNORE_OUTGOING has no effect once a socket joins a fanout
group (the group prot_hook replaces the per-socket one), and pre-6.2
fanout_add() does not validate unknown flag bits, so setting
PACKET_FANOUT_FLAG_IGNORE_OUTGOING unconditionally is safe and the
PMD-side check remains the correct fallback.

Only minor items below.


Patch 2/4 net/af_packet: filter Rx of outgoing packets in the PMD
-----------------------------------------------------------------

Info: ignore_outgoing is unsigned, log it with %u.

-	PMD_LOG(DEBUG, "%s:\tignore outgoing %d", name, ignore_outgoing);
+	PMD_LOG(DEBUG, "%s:\tignore outgoing %u", name, ignore_outgoing);

Info: test_af_packet_ignore_outgoing() defines n_inject for the TAP
side but hardcodes 4 for the af_packet side. Use one constant for
both:

-	allocated = alloc_tx_mbufs(bufs, 4);
+	allocated = alloc_tx_mbufs(bufs, n_inject);


Patch 3/4 net/af_packet: use kernel to filter single-queue Rx
-------------------------------------------------------------

Info: commit message states the 4.20 availability twice. Drop the
last paragraph and fold "DPDK requires at least Linux 5.4, so no
feature check is needed" into the second one.

Info: release notes should say what the user gets, not how it is
done. Where filtering happens (and the 6.2 dependency added in 4/4)
is already in doc/guides/nics/af_packet.rst. Suggest leaving the
release note entry as added in 2/4:

  Added ``ignore_outgoing`` devarg so ``rte_eth_rx_burst()``
  returns only incoming packets.

Info: PACKET_QDISC_BYPASS is guarded with #if defined() and 4/4 adds
a fallback define for PACKET_FANOUT_FLAG_IGNORE_OUTGOING, but
PACKET_IGNORE_OUTGOING is used bare. Fine against any 4.20+ uapi
headers; add a matching #ifndef fallback (value 23) only if you want
it consistent with 4/4.


Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
