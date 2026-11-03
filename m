Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C08606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=leScmTH1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0CB540678;
	Tue,  3 Nov 2026 19:14:51 +0100 (CET)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mails.dpdk.org (Postfix) with ESMTPS id C230840678
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:14:50 +0100 (CET)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so2418185a12.3
 for <dev@dpdk.org>; Tue, 03 Nov 2026 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793729689; x=1794334489; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TDRtSMgkhtNxv2yp+Ye++RRBu35Ov/7wuxhk+/zp/uU=;
 b=leScmTH1pdEVBR9kkV1IHvG3mzOzAJrpQ8rmyY6HTMmM9b5BddebxJYdkMH5orLZmR
 9xleSPHcPxJZRV2GW1DpDH37vsUrNfAfMfAF9M0qF5l4nkRESUyCWbq6Oxzb/IoW0ZfS
 nnQ8dTZEweRBr4jAJJhQkKJoK/BF0vimxEzUHF59bQnNEdu5up4G0hUTmf3RXW5PTNZR
 6PzGUvpdcYGhP4+y5AYtUK2VELMOpA36RjRtN0+lnrM8cVQi95pyP2u27bSwq9FaKd0K
 Sul5TsDkWJUdH+xl5Dx/2cTKkoP7YYtd9GsFpuJqBFQ0vB6ksabs/fR25pvxjGRc6yJO
 UbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729689; x=1794334489;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TDRtSMgkhtNxv2yp+Ye++RRBu35Ov/7wuxhk+/zp/uU=;
 b=HQz7yzW5mDE73Nw8kZ40bTf1mCXqmZN3DIGnhOLCiot6P7dfJz5q0yTRhps35T5hcR
 nsGl3zcQRakro3//Xe3ffGz7PKLcvSJCOtDOXlB7xSpmvoDtz04O/op5z3EOmCf178K/
 bH5c4YDEi2BXawtOcL1moh3u8LCLUozh8IdfZBEHl6d6lnLrIuygfk2Bkmpbw7+BeV0r
 zx1Slq8msBW96GF+9kQWORXd5xGKBI7WFAShUX0qsk8QBaHEdxSkWwl0NCDXb2eDdW/B
 lFhjLUOzLQA7zSpAxKd02f3iHi1AqNuOEJsg2m686cPf4GNtYRd5hOzAT98KENNHTTSQ
 7iCg==
X-Gm-Message-State: APuU4Z9Y4zLEltZEZBa/1Mfl+v1aLsiJJFlz6SbJPUffqXhq7Fw9AYbL
 RoAfDIDrHzrijrl0a4RxeSdA2E678YYJdk/I5E7iuy5fuKdc2D07dqpW4HfSBw1SqMFoKZQEhNC
 YA6+onvVdLjM0Vw==
X-Received: from pgbfq27.prod.google.com
 ([2002:a05:6a02:299b:b0:cd8:c5f8:e73d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:50b:b0:3e2:117a:62ff with SMTP id
 adf61e73a8af0-3e928fca106mr12190076637.61.1793729689057; 
 Tue, 03 Nov 2026 10:14:49 -0800 (PST)
Date: Tue,  3 Nov 2026 10:14:40 -0800
In-Reply-To: <20261103181442.381856-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
 <20261103181442.381856-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103181442.381856-2-joshwash@google.com>
Subject: [PATCH v3 1/3] net/gve: fix TSO segment offset calculation
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
2.56.0.385.gac671c819a-goog

