Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9DCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82F1540431;
	Tue, 14 Oct 2025 09:05:32 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id B9A82402ED
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:05:30 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 661F8EC0214;
 Tue, 14 Oct 2025 03:05:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 03:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760425530; x=
 1760511930; bh=S8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=I
 w1zckwRHHs5QEdBkaUYl9+LnYbMUo1M6URVqkaSU36VdhewGi5vzkbGcmmEOqQgE
 ipED1Y7lIdF1kDMs7dZWyV8kcQfy5jTq6b+mklUHf/ejPyCe8X+kVIt216shM7V7
 dzi9uPKVT7Fhoz65KqXdt8D5c7SxP08ywwe0ADLiya5o7h3q3EUP35UQKd6XeY+c
 /iDG/LObZk9BPygdq4+X9fbrRVuboJll0JJMiVZH+5lLO/EoUgPZxiSRJOH9Ullr
 vk6q+X3PIqXbQ68hICComNph4kyOJZUnUJfIobNtcwQ+WFxrRJJO5N7YpK+Im9md
 cNsOh3QojucF4JviYpD8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760425530; x=1760511930; bh=S
 8HZcsTbrH5lG1POubh+56/8oulOXfugHauOTy6xObA=; b=EutmUD7tdAihmxpES
 jwlqicBjeaA+oI9wYvKrubVJtBlGQDygbgjnCIBsqHCT5hdWsteJN3HLrWlF0J5U
 yBz/ht5pfhT1kg+AL97drczYsKM+QnbAw3Qp0x/QmznNMM6AkmTOeEzzxo5/6IFi
 XXhfMxbCNoUQIDoCcgZYa0o5yCaIayss2SUqzqzjd1Y2hyrreOJm7xhBMnLMTa0K
 UJNo3XfSC0UUxANJOuLNT25b3EcizFhktC6A66ql8/VzR8WUcWL4RXmvbn+1U+QV
 Pkyp6ZruNukek6dqVbwePgTkIaRHohAmim7rGUDgSxiogGYeonnErRP0ZYOpeKry
 K1umQ==
X-ME-Sender: <xms:OfbtaNXD0WyAP8DJUVRYJruH8NRg4Db7r8ap-QaxAku_01mbwcN3kA>
 <xme:OfbtaGgZmg2_AKoKwU4pC66MwD-2rW86v3E9Izyg6aMyRs2YhXCw1PqJmTBYx-gif
 GzEbuenHeJDxZYXCGDuLQ35Rd3f7T4CJK9hmycbAS66XDw4tR74sw>
X-ME-Received: <xmr:OfbtaE-JiS8KLl27mrfbwekTuIzrUxlqi-Q9G1Nzm-FmIJMreHIQaXk3nIWaYNyxLm3nvKU2Wf6CG7i2HiZLP2XAxkFgtJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:OfbtaAayMd2cKBciLAzxKX-eiD82TJqxJMw0XkLmI7bi9TvhE5R9ag>
 <xmx:OfbtaD2LZW4MLMSEmmnICfIJrCDZ5ZYymucvTCi0ryxXt4tbD3hkIA>
 <xmx:OfbtaLaGfmKHzt4yBzxwkv9P8xC0qKhcjE39n_FdD2Me7oAN7KuXcA>
 <xmx:OfbtaLKuJAehDrGYsKpRgX-tdTSFa33d_tRV9l0rSK0T0xYz1iEiyw>
 <xmx:OvbtaFjlJlVxXJ521sF2RVlVViksuqTEC4TgUqc0CJR7IjbosHklOQoS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:05:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v5 2/7] mbuf: move header include for logs
Date: Tue, 14 Oct 2025 08:58:30 +0200
Message-ID: <20251014070517.922137-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014070517.922137-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
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

The header mbuf_log.h depends on rte_log.h, so it should include it.
After this move, no need to include rte_log.h in addition of mbuf_log.h.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/mbuf/mbuf_log.h | 2 ++
 lib/mbuf/rte_mbuf.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/mbuf/mbuf_log.h b/lib/mbuf/mbuf_log.h
index 8feaf20747..f163cbd71c 100644
--- a/lib/mbuf/mbuf_log.h
+++ b/lib/mbuf/mbuf_log.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause */
 
+#include <rte_log.h>
+
 extern int mbuf_logtype;
 #define RTE_LOGTYPE_MBUF	mbuf_logtype
 #define MBUF_LOG(level, ...) \
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 9e7731a8a2..22d7cfc475 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -12,7 +12,6 @@
 #include <eal_export.h>
 #include <rte_debug.h>
 #include <rte_common.h>
-#include <rte_log.h>
 #include <rte_branch_prediction.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.51.0

