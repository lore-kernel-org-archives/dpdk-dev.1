Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A013C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 761C940A79;
	Thu,  9 Jul 2026 06:07:53 +0200 (CEST)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mails.dpdk.org (Postfix) with ESMTP id 05FC840A70
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:52 +0200 (CEST)
Received: by mail-pg1-f202.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so813513a12.0
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570071; x=1784174871; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bt1AnTSZGRyX5DQNsZgiw7BZfctfZ761SAjDz4smIAk=;
 b=qnyXGVHp7oFGHVKrQsUZh2U055AvF18z7pDUduE06Y24jetXKUiLVXhHmUVdRHNvN4
 qMd5wmiIfLhVYXrAxUmVbOj2q43kfcyu+LhjrbVIFeHmpHGulz7QE9AFhgGMhqC8Znx+
 buD++eT18rndE9AOxAMpoSHxatWJdkLmHMboUYraETs+P+VbODEiqxH33L01yhdF/e+k
 ndjnPa91ro3u/gzTlEHtIpv7TCcb6OAoQshrTkdw4U8KvoGFTtzcEw4k2VSnf980wV45
 W+nyuHmSWEL/bhekMoFYBS671n5vg7X7nq0GZdg/BhsgDwXKCislpalqp7TB80gyj3Bv
 /eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570071; x=1784174871;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bt1AnTSZGRyX5DQNsZgiw7BZfctfZ761SAjDz4smIAk=;
 b=fAhDfSMDcQBvjy2lWbMjgQSnDWQSm2J/G9c16XqP6ZT3SSnuGzcXYCDyP3eyJ9yhqN
 6UCd2uNjoy+KkuEWeJcFFaulySAG6kG6dIlyqpNg2w5grxXWuTkRi35JpLrTtX0HuRNr
 Lrb71P5P4n+WddPRozEzTvmi3BE26fAXByYu0wdUrotkgdjtojI5BUJuEwGw80YqfsOc
 yGa7sXYgsUukGee2E9rwTrwmp1qxGP2CD/onqlAd7jpbqSYYbqKriKq1exSCJlUGe2JB
 rz3/Tok1JyIT5z9FrVNgr8BC+rYFsPX3xunb8EecpVdXzpa8Nhx26kgmK9KShnVV43Mq
 2RsA==
X-Gm-Message-State: AOJu0Yz81IAdUOb+1kq4pGujuRLIWSwkticxD2Sti/ap65wV0Dm75mjN
 ME2CNTtB7k+tmBWGX2WKvUzhTpJn55QNA4bHun3koIdS+PUYPerFk7R4uN06Jx4CgXAGIvXNGXD
 bPo4alsz1hE4cMw==
X-Received: from pgbfm1.prod.google.com ([2002:a05:6a02:4981:b0:ca0:eca7:7de1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:914b:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3c0bcec9fc8mr6789273637.27.1783570070810; 
 Wed, 08 Jul 2026 21:07:50 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:33 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-6-joshwash@google.com>
Subject: [PATCH v4 5/9] net/gve: set mbuf to null in software ring after use
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>, 
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently, it is possible for mbufs to be uncleared in the sw_ring after
being returned to the application. This causes an erroneous
dual-ownership over the buffer until GVE cleans the buffer queue and
posts new mbufs, overwriting the older pointers. It is possible in such
a case for a double free to occur while tearing down rings, as both
the application and the driver could attempt to free the same mbuf.
Release ownership of the mbuf from the sw_ring as soon as appropriate to
avoid such a scenario.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Fixes: 45da16b5b181 ("net/gve: support basic Rx data path for DQO")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx.c     | 1 +
 drivers/net/gve/gve_rx_dqo.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 625649cdcf..cda87af294 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -152,6 +152,7 @@ gve_rx(struct gve_rx_queue *rxq, volatile struct gve_rx_desc *rxd, uint16_t rx_i
 
 	rxe = rxq->sw_ring[rx_id];
 	gve_rx_mbuf(rxq, rxe, frag_size, rx_id);
+	rxq->sw_ring[rx_id] = NULL;
 	rxq->stats.bytes += frag_size;
 
 	if (is_first_frag) {
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index c4e2d32067..3665d9e4cd 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -207,6 +207,7 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
+		rxq->sw_ring[rx_buf_id] = NULL;
 
 		/* Free buffer and report error. */
 		if (unlikely(rx_desc->rx_error)) {
-- 
2.55.0.795.g602f6c329a-goog

