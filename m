Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B6CD98CF
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:38:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2386A40B97;
	Mon, 15 Jun 2026 20:38:41 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 41F4A400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:38:40 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13817614cd3so7849476c88.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781548719;
 x=1782153519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xeKfr1sEwMcB/VvLL5U04dRD8qH29hxu1aa4/JnHig=;
 b=biWp7Y6oD9QtOC1GthJzUJDS34QVwVDlbEuQIE3/DhOaYEL4EMetFA0xfGTkEDUmrO
 T1gNLih09fmctPrs/l/c+DY4cjPY52CX6nE5yF4ZsZBR+BQUbEc+5q0Ki9zuFAHhKpjv
 Ejg2JKfd3bldMiscakBIZKpVjMCAmuukbIvw9BfESbl6grRbz8byOB+w3oRBwwWz3UMy
 MTkKP2lcpn4NMJurRDdIDPRzmgL/JaNDzweR6WQJ8IwYv7b+QJrt34S0wrYnju5tORn6
 bZytcDyh1dDCcfCbhsDzULd0/9d1RJ8v+9Ri0xKLkDMbAowHB3OI01hE+iykteq68BQD
 XNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548719; x=1782153519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/xeKfr1sEwMcB/VvLL5U04dRD8qH29hxu1aa4/JnHig=;
 b=Ekw/3d5I1L9uekApxdBU+U22oyI4cxlh04EJa3dQ9CQYcNlt8P39q7YaqGo4CSSF2n
 Q2VxBJtfeQLKXiJ/3oUkaYhGAZE9dYCUzGnUEUPzZeMlA86gU0CWdByfk3TEgPUdIv4E
 gY8Cp2Vao5EjBYCvpUWAHUCBRndPGBI0ZrHyg0VrI0FtITrCcBnTMNRsK2Y4APheLic9
 xgWVUTyC8g4zPGs5LLciAwoyqAxDbQ7R972j6577l1cFOfNT1kIujeGFGfxryVq/rLjf
 p8h4f6r5sL6B4GYHQYIw5OqgiD6sH6w6awgaXvl09jRh8guIBHgXsnUVIf7TqoMU8OoI
 k61A==
X-Gm-Message-State: AOJu0YxlT5fwylofvuXMlbVczHFgOQvv5xGn4SbBTEsumFMN8WWWFPwW
 vjwrZ0OZJEiCO5OOEQ6fPlEQnjSIHgKyGxUGCeawlpi4L2GpnuTPq5ASIMM8J4fV4C4=
X-Gm-Gg: Acq92OE5NV0JpyESXgt5KxdXN6zPQ1WPh1K3SECak9ydWhoJGt2XgwGn5g5jfD/x4HK
 868qZxGNWhVfPmvhpOogNjJqyL8+e9yKegfLMLr1utQPUaTTPK2CnohYURfb/FzHVXc05fNWTrN
 GC8uM92F4vqQ+UIxvhfr/t6tKBfx+3fWe6GHGN4EOYB2MPB5gPNU4YQYcWeNFrXG1fVpq+klDmx
 fMuTsTB0jtF1nWIQ/N4Fk9Opu0eN2LUQWEiB6OwnTdYaHGzNMJat3bbWp8oPOOjtF8H3jZUrS+0
 jAbjAn70IViJ+82EyLv2Q62nICRvH2dOPZtpwVS/11PGzU3vZYiHrXDnbEghkKZF6yc/4axZ4Be
 kX5g8JSt4H7EGE5kVysBQdR/O4efwlp6UYY7Xhv8XXAGFF5i6gOgqj12jv/B6DvYxN53HY6hUo+
 A19x7jW0To551mUL9ETaU7L1qbEhLtzOFlZQsUEiT6l1BSaiGWbXr752u7EnOBFSVu
X-Received: by 2002:a05:7022:f83:b0:134:df7f:910d with SMTP id
 a92af1059eb24-1386f23581dmr5499794c88.7.1781548719017; 
 Mon, 15 Jun 2026 11:38:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9110d3sm11575144c88.5.2026.06.15.11.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:38:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:38:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 4/4] net/zxdh: optimize Tx xmit pkts performance
Message-ID: <20260615113835.564bfc04@phoenix.local>
In-Reply-To: <20260615011931.940545-5-wang.junlong1@zte.com.cn>
References: <20260606063226.491848-1-wang.junlong1@zte.com.cn>
 <20260615011931.940545-1-wang.junlong1@zte.com.cn>
 <20260615011931.940545-5-wang.junlong1@zte.com.cn>
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

On Mon, 15 Jun 2026 09:19:30 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> Add simple Tx xmit functions (zxdh_xmit_pkts_simple)
> for single-segment packet xmit.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Ignore the CI AI review (9 false positives) but more detailed review found:

Series review: net/zxdh Rx/Tx optimization (v5)

The v4 issues are resolved: zxdh_queue_enable_intr() now tests
!= ENABLE and assigns ENABLE (1/4), and the fix is first in the
series against the original field name so it backports cleanly; the
simple Tx path publishes the AVAIL flag through
zxdh_queue_store_flags_packed() (rte_io_wmb); zxdh_recv_single_pkts()
now compacts surviving mbufs with rcv_pkts[nb_rx] = rxm; and a packet
that fails padding no longer has a descriptor written for it. One issue
remains.


[PATCH v5 4/4] net/zxdh: optimize Tx xmit pkts performance

Error: in submit_to_backend_simple(), when pkt_padding() fails the mbuf
is leaked and a hole is left in the packed ring.

	for (j = 0; j < N_PER_LOOP; ++j) {
		m  = *(tx_pkts + i + j);
		if (unlikely(pkt_padding(m, hw) < 0)) {
			vq->txq.stats.errors++;
			continue;
		}
		(dxp + i + j)->cookie = (void *)m;
		tx1(vq, txdp + i + j, m, id + i + j);
		zxdh_update_packet_stats(&vq->txq.stats, m);
	}

pkt_padding() returns -1 when rte_pktmbuf_prepend() finds less headroom
than dl_net_hdr_len. On that path the loop does continue, so m is never
freed and never enqueued, yet zxdh_xmit_pkts_simple() advances
vq_avail_idx / decrements vq_free_cnt by the full count and returns
nb_pkts. The application sees the packet as accepted and will not free
it -> mbuf leak.

The descriptor at txdp[id+i+j] is also left untouched, so its flags
keep the AVAIL bit from the previous ring pass while the surrounding
slots carry the current generation. The device consumes packed
descriptors in order and stops at the first slot whose AVAIL bit does
not match the current wrap, so it stalls at the hole; the
already-published packets behind it are never processed and their
cookies never reclaimed. A single padding failure can wedge the Tx
queue.

If pkt_padding() cannot fail in the simple path (single-segment, full
headroom guaranteed), the error handling is dead code and the branch
should be dropped. If it can fail, it must not desync the ring: free m
and stop the burst at the first failure, submitting only the
contiguous successfully-padded prefix and returning that count, rather
than skipping a slot mid-run.
