Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27877606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KZWXzbE9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA07D40E2F;
	Mon,  9 Nov 2026 20:43:39 +0100 (CET)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 21C0340DCB
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:43:38 +0100 (CET)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-84c4dce8182so1783774a34.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794253417; x=1794858217; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=htBE4wPBTHFeoowB9IA9TqmmEEbDgB6UuoMwVHmYsUc=;
 b=KZWXzbE9pr/O8IRyN4TWtunFjtNqTvQtaFG8Vj4AEz9yNdd6g/Zii1Vjqvo3beMkZ9
 FZRBjpIXVeaE9L1sUNqV/g5yXi0mBu+gHylFKyDRvH5EHelxXwemX6Iv6CXhFjYEYQi+
 rW49LPi/ZBe25m3SFEFuPPsgvUNkP+QPYjpjlDTeXMIpCXHsXX93fh8b5UoRzRNrWHLL
 1RTl+v9lqiMyfxmWrwz5bMp289MB9kBjbblAI87VXVg80leuCpvhx/VFQV/jHdMACHPy
 tUb3B9HH0OK6OkxAPuc6XtLSE7MbL9Rd2MAUlJHa7k2pD1z3hr2s1q+9s4eKDWjnjUiT
 kHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253417; x=1794858217;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=htBE4wPBTHFeoowB9IA9TqmmEEbDgB6UuoMwVHmYsUc=;
 b=D3FvMNZpKwqdPvOnhR0h8eqsXsIW6xJmMgv8yyIw/8E8ZaSjpPO1OQID55EmgvdTHx
 BQRk1chHSdRPw/rHXd2gmhsRHerwtHtmFvB6IzcUQAn58GYmaBKRzEtWwusOQzZurAiA
 iKV470Tq61oOKpuhCGJjdFFzXnKdM1i3z4qJpk7EJCJ8nBIftiOiqnoR96bLLqfwxM8E
 EW197PXVBqStHZB6FLABNLn3Z6Ox1wy9adlfGw97UGGki4MMBYrY5MITRL7qGg0PU3sK
 6x7Bo/XjC3xztlbGsOpyH1rWAGWT7yjQJjuzHCVV4P+T4oTo39XK0ICo6QSY27vePIS2
 yUQQ==
X-Gm-Message-State: APuU4Z/pqvPUS/0+xKvkhyKIfFahyccRUhbRVEayHXmPxcGOFvvDOm6b
 R/l+BV5FHvbjpruhYGnsQ8tVabKfhFj09BiIs1Av3bFAR0gG05UcE2iznTDwWvGirvZc3GjTqu2
 2iqa0N3p/Lxw4GQ==
X-Received: from iocrb13-n2.prod.google.com
 ([2002:a05:6602:a58d:20b0:9e3:4940:4cc3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:168c:b0:4d6:90d3:e18f with SMTP id
 5614622812f47-5683ce25e02mr507251b6e.46.1794253416421; 
 Mon, 09 Nov 2026 11:43:36 -0800 (PST)
Date: Mon,  9 Nov 2026 11:43:29 -0800
In-Reply-To: <20261109194331.393364-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103181442.381856-1-joshwash@google.com>
 <20261109194331.393364-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109194331.393364-2-joshwash@google.com>
Subject: [PATCH v4 1/3] net/gve: fix TSO segment offset calculation
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The descriptor limit validation for TSO packets was erroneously
computing the TSO segment offset at the end of an mbuf. The first bytes
of any mbuf will be included as part of the previous TSO segment which
has not yet been completed, as indicated by seg_remain. Subtract those
seg_remain bytes from the mbuf length before computing the segment
offset.

Visual representation:

Before:
------------------------------------------------------------------
|    tso_    |    tso_    |    tso_    |    tso_    |    tso_    |
|    segsz   |    segsz   |    segsz   |    segsz   |    segsz   |
------------------------------------------------------------------
|           16K               |            16K               |   |
------------------------------------------------------------------

After:
------------------------------------------------------------------
|rem |    tso_    |    tso_    |    tso_    |    tso_    | seg_  |
|ain |    segsz   |    segsz   |    segsz   |    segsz   |offset |
------------------------------------------------------------------
|           16K               |            16K               |   |
------------------------------------------------------------------
                                                               ^
                                                        mbuf_remain

In this example, the original code would have found that tso_segsz
evenly divides mbuf_len, and that there is no tail to be considered
split across two mbufs. So the number of descriptors it would have found
would be:

  1 (for the headers) +
  0 (no segment offset) +
  0 (mbuf_remain cannot be less than 0)

For a total of one descriptor counted in num_descs for the start of
the current TSO segment.

Meanwhile, the reality would be:

  1 (for the headers) +
  1 (seg_offset != 0) +
  1 (mbuf_remain < seg_offset)

For a total of 3 descriptors counted against the descriptor limit.

This undercount can cause TSO segments to incorrectly cross up to two
extra descriptors more than the hardware limit, leading to the datapath
being disabled.

Fixes: be8f0eb81f98 ("net/gve: fix DQO TSO descriptor limit")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/gve_tx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 52fcdb285a..3a20109a5d 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -191,7 +191,7 @@ gve_tx_validate_descs(const struct gve_tx_queue *txq, struct rte_mbuf *tx_pkt,
 			return false;
 
 		if (seg_remain < mbuf_len) {
-			seg_offset = mbuf_len % tso_segsz;
+			seg_offset = (mbuf_len - seg_remain) % tso_segsz;
 			/* The MSS is bound from above by 9728B, so a
 			 * single TSO segment in the middle of an mbuf
 			 * will be part of at most two descriptors, and
-- 
2.56.0.542.g3ef89b7020-goog

