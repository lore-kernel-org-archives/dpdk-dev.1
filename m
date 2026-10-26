Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E425606A327
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DsLsOKk2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD9F5402E8;
	Mon, 26 Oct 2026 21:23:35 +0100 (CET)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mails.dpdk.org (Postfix) with ESMTPS id ABDC840041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:23:32 +0100 (CET)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd652c0385bso2075490a12.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793046211; x=1793651011; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qEk69ozByQLULSxVL6iuwKdtE64xVu1epgOLt+JCU2c=;
 b=DsLsOKk23QC3Ukhdz/ZEqLkQWnZpH5LkLmKmDvosxGaNv/IwYkHgjrnTuQMZPaVivE
 XGmERMXmCySaZd0OJb76g2obQM6WgrmqxcDPrtjyqdHXpZK0rwP8+hIhQcisVUyYZy/x
 8ZVUAmXjYYGJPPvxPpviyoOxdlXNSP9vH4nbjMXg3914+nkCnjd4NtXWXEB86+S0jjzb
 3GhlG3owrjp0kEhmh8EmrFO4TJ67+kqY1wDuMHgdZp+8qLAE9W7sxsuHVxfhlnRw8bH/
 SxNyue67KXIuDIDmEJOvwZEh0x/ayHubm7vSTkf1mvs0XzxNhJFLXp+VEwILT92RqG0Y
 Di8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793046211; x=1793651011;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qEk69ozByQLULSxVL6iuwKdtE64xVu1epgOLt+JCU2c=;
 b=JmB5FGJg8Na/Fwqe05fvTQO8czqZ7fxRDA9umavsri86gEQToeJqG8AoXelEPN5q/S
 99OPsiFwUVWJ9dpCjZCnrP+787PAtGYZO9XTKO/XO7Wwr9fLrB0P4fI/HSj/HLigiT9t
 6YsYWs0prH5C7CuSlISmSJYnNVgV3zBx8dRVdgyR45r2aaGU2MsnCtLMbNNStNZd/THf
 Qhbt/ZTAEtiGWQb2S8rexPjEQdn+ltWlhVdtMmjAjLrTlwDx3nOfd4QjW5NUpcbMZFCn
 Ac2RK5RmFn39QmYDlSyDQnAHau/q+OiW0mxXvlQ8nztGG9WLPa2QzXU4J7ppPaUySLiI
 IfSg==
X-Gm-Message-State: AFq9FYKEBY3cSZmoz/lYDZZDTZZEPSyy2exFSXSfuDAehTCvTsm9MFk7
 mPg5wDyYTNNEqSVQQX2/MwkHFU9UiVOLsJrFLmLuFu87nrRrOwctgI+rbd3+xJ79GqzMomachnM
 kOz4rWQE2eSV/gw==
X-Received: from pjbev18.prod.google.com ([2002:a17:90a:ead2:b0:3ab:4cf:7b95])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4985:b0:3ab:413:49b6 with SMTP id
 98e67ed59e1d1-3adeae6d3c3mr6185441a91.41.1793046210803; 
 Mon, 26 Oct 2026 13:23:30 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:23:25 -0700
In-Reply-To: <20261026202327.3897802-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026202327.3897802-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026202327.3897802-2-joshwash@google.com>
Subject: [PATCH 1/3] net/gve: fix segment TSO segment offset calculation
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>
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
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")
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
2.56.0.307.g5fe7bd680c-goog

