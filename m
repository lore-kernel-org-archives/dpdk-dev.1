Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE5606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXk10gO8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9573340DDD;
	Fri, 30 Oct 2026 19:43:11 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTPS id 9B42A40DD1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 19:43:09 +0100 (CET)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so8115895ad.0
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793385788; x=1793990588; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NrVR1nPUkzWn2lGDX3f0CX95FKrQh6rzSSpXrrqwCzY=;
 b=ZXk10gO8WMqwJIIp6Qs0LcLNL92KSRyf3kVci76zYrCRucYbEa6IA7Y25am6GoW+A4
 HIUE4HTtVmln7gfHQtW1xrQlLzTU2+dnBPvt3C48hvV3A1cKqJabmYGhh96YJPhw0DvK
 vnp7J+3dzhaJPHHumi/GpmsO2/QFbd2PCuCM30QBm/4JJFT5v0Co75+Lsp4+LRdRInjN
 dnHNx5QtPviSL2LrtScJdBjX5rfwsmDiJymNOx3Pype+Ciq/Qg+k3P8ugq0KGbWriE1W
 WcAL641UAxiQc/8wE80ermXypCATiYY3rj7YWrIXh2bfLf+Lji1aFTDuWuz4xU6JD46N
 s5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385788; x=1793990588;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NrVR1nPUkzWn2lGDX3f0CX95FKrQh6rzSSpXrrqwCzY=;
 b=LqU61MsQteIwO33D6NG9fUKlq1kaiEh9V9goU3CYARmGtxm22fWGuLRvewTL2jDl9Z
 IcUcccOhm/K0XsA4D5irRjP5+i4M5n+ns60CWoHqbZEJ1cPsQxQRa4Rl6g0FSit78bJs
 zPXGrX1WxrlK7z8qa88SCDuaStncuiQvmni9fsmyC+pHjJV03NAIFjKkFR375zP0nqnw
 oO0F+bkYKcmPCdwC+WP5RBzKceWExZzT+7yAmpqAEpzAX2vh3pmxIxsGCzEHue0Rn9SQ
 zi7UKUPe+2vAgGwn5nz+WJF3GdfUbPLA1EhWRqKrgIDAXSTanXJxmTUryJiu1Ovsffoy
 uCDA==
X-Gm-Message-State: AFq9FYKIXH3yELneYJ9e1H4BGcywsUMSxxfl4yppVV2BTL1pXyuBqVNy
 LMqOojNXpnspKYq1dWy9igUMu5BP2YQt0KIjgtMJufncGmvJ2HSX3WRW/NmMGvNBZe80Hd3sSzi
 xxL5nUcOHetq+gA==
X-Received: from pllj16.prod.google.com ([2002:a17:902:7590:b0:2e2:ec03:928c])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1c1:b0:2e8:c331:fc30 with SMTP id
 d9443c01a7336-2eb3648f2a0mr27352705ad.69.1793385787775; 
 Fri, 30 Oct 2026 11:43:07 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:43:00 -0700
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030184304.508282-2-joshwash@google.com>
Subject: [PATCH v2 1/4] net/gve: fix TSO segment offset calculation
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
Reviewed-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
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
2.56.0.317.g454f8302e1-goog

