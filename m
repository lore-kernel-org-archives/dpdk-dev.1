Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FCC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 046A9402BD;
	Thu, 17 Sep 2026 08:24:14 +0200 (CEST)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by mails.dpdk.org (Postfix) with ESMTP id 4F40D4003C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:24:12 +0200 (CEST)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso3334905e9.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1789626252; x=1790231052; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBvdgbKHOaNZBLR++9aZ68Y+m4kquUG83/hxLrQMDJ8=;
 b=eksXZC4V1bX0ON4irN1tbh6dG+UhOJ1uIoN+hJofEBJVFi+mGkEU2ZOwzYPAChhyo2
 EWmkCsoUg6GcYsoOz3H4BfU20lk+Wi20LwWgIpXPv3PCPT6NQnE3gOwVcJETdwIsTH22
 dlWwEyIPPSD9x8nUwnQbIg/HaxLJ3k7ag9ZM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789626252; x=1790231052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KBvdgbKHOaNZBLR++9aZ68Y+m4kquUG83/hxLrQMDJ8=;
 b=iQcG5SSNgl51qTstC1JCyqt1lRDVkYWjiuou74DNjyvD6BPpW0ymbciPeGM6E7Go0L
 u4aOUehpTymGj7Fl2Mtzsz3SyMG6xuh2XF8qs+EJIR8rERn6Mjhx28hm+4IrBlPbwwCZ
 1rbKfa9i0RNoGzu9sQ0a9m5zOuVnLbROvorL/7kNhD45kPAwPc8zHczTicJqbRiRXbEo
 G+dS0DWyw1nBx/MGqIvXKr2uuKKqbdmPHcdp71/gdXFRgkI8ODL5CX0mC/4D//9bZ/Uj
 ZteLj7ezMjMOdNI5D0vtihVMDtcd/luQPWum1k4SxukIWAdK77e+cY2Xtd7v5jLCOCiP
 H39Q==
X-Gm-Message-State: AFuF++kMrDwhjW9PiJUBLn4chmphmmQ9khyy3wKFB/M68mHBR76FibGG
 xvjj+K3MMI8MH5VPivWism3m0vT1UHb/TtFp8oDwModIzoM2SIaHHVhoaCH7nvH3usT4gOI9J25
 r/Bstxu9T+r9SxyMRATBiuDw+U7qZTKW1PEJzI4P5+q32zBBPgY+aIaGtVD2Ftn07UXecKZNmq4
 49mdSKiiglME9QdIQC3CjZzTgehIOro4e3ZzWE87SbT8w=
X-Gm-Gg: AYBFou3uO2wkTbsN05utsN80HriEu4qGlXA+nufqAvvejyMy9xtJP5mthwYPI4lfl+q
 1FuoxkJC6RZon5siA0+9D0yTtLjwPu1ulgQPKIcScB5Dzq65Sl+GFyMmEiRyqakbKEcL7mfFF5i
 s+kXyVLHzxqr/T+eXH5jhDnnjUOZS5YDz1nPfh5uHNtSzMZzlHjxqZqTIHqr/7QV8AyR0460JOD
 QAYx2zST0+vurpSSo0ybUHt5x72ORxEbtW9ItCmIMuvSnaGoCQVGLWoR1JSJV7w3grNpLq89jPE
 gjDjjorAkLl6GshZq80T7SytRZsqyOMzVVo/O4LdKPv0ImXVhqJMa9amFGmjEvx6CQ7V6U70GI8
 VwIPH8B+8T/Qk/husgsTeZUQYs9xJ8WPxh7mMpDXgDPaRjlpT4BIOGqTU6SQCh1Y6cgXDGPq+dP
 yf2i3fzXpECJClk/buw3S3fn2VE7Z/jaaH0JPkcu9Iu6OFia0azY5ALLYzYeQ+AeMOsBvwPT51f
 RFI4IVor0WPJoC+WhsKg82fQ3VZoP3MKyE1NLa1iccoweVvevYMSLA056uYkg==
X-Received: by 2002:a05:600c:83c8:b0:49d:28c4:b304 with SMTP id
 5b1f17b1804b1-49eb7341406mr56334755e9.29.1789626251706; 
 Wed, 16 Sep 2026 23:24:11 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490..
 (bzq-79-178-134-78.red.bezeqint.net. [79.178.134.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd17051fsm50143745e9.0.2026.09.16.23.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:24:10 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, weh@microsoft.com, stable@dpdk.org,
 Rita Ruvinsky <rita.ruvinsky@weka.io>
Subject: [PATCH v2] net/mana: fix Tx stall from send queue free-space unit
 mismatch
Date: Thu, 17 Sep 2026 09:23:50 +0300
Message-ID: <20260917062350.1482591-1-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914105809.919580-1-rita.ruvinsky@weka.io>
References: <20260914105809.919580-1-rita.ruvinsky@weka.io>
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

gdma_post_work_request() subtracted a unit count from an entry count:

  queue_free_units = queue->count - (queue->head - queue->tail);

queue->count is in entries, while head and tail are in WQE alignment
units. On a 512-entry, 128KB send queue the check saw 512 units of
capacity instead of queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE = 4096,
and returned -EBUSY with the queue one eighth full. A workload that
fills that window faster than it drains makes rte_eth_tx_burst() return
0 for long enough to look like a dead port.

The size is the authoritative capacity: rdma-core derives sq_size from
sq_count as align_hw_size(max_send_wr * get_wqe_size(max_send_sge)), and
the kernel mana driver computes the same limit in bytes in
mana_gd_wq_avail_space(). Derive it from queue->size, which is also what
the ring wrap in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs
occupy exactly one unit, so entries and units coincide.

Also report the size and computed free space in the -EBUSY debug line,
since queue->count no longer takes part in the decision.

Fixes: 56dd45c0ce7b ("net/mana: implement hardware layer operations")
Cc: stable@dpdk.org

Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
---
v2:
  - comment states the invariant rather than the old bug (Stephen Hemminger)
  - report queue->size and the computed free space in the -EBUSY debug line
    (Stephen Hemminger, Wei Hu)
  - reference mana_gd_wq_avail_space() in the commit message (Stephen Hemminger)

Independent of patchwork 167383 and 167384 from the same author.

 drivers/net/mana/gdma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mana/gdma.c b/drivers/net/mana/gdma.c
index 7f66a7a7cf..a92aef59d2 100644
--- a/drivers/net/mana/gdma.c
+++ b/drivers/net/mana/gdma.c
@@ -138,11 +138,16 @@ gdma_post_work_request(struct mana_gdma_queue *queue,
 				client_oob_size + sgl_data_size,
 			  GDMA_WQE_ALIGNMENT_UNIT_SIZE);
 	uint8_t *wq_buffer_pointer;
-	uint32_t queue_free_units = queue->count - (queue->head - queue->tail);
+	/* head and tail are in WQE alignment units, so the capacity must
+	 * come from the queue size in bytes, not the entry count.
+	 */
+	uint32_t queue_free_units = queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE -
+					(queue->head - queue->tail);
 
 	if (wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE > queue_free_units) {
-		DP_LOG(DEBUG, "WQE size %u queue count %u head %u tail %u",
-		       wqe_size, queue->count, queue->head, queue->tail);
+		DP_LOG(DEBUG, "WQE size %u queue size %u free %u head %u tail %u",
+		       wqe_size, queue->size, queue_free_units,
+		       queue->head, queue->tail);
 		return -EBUSY;
 	}
 
-- 
2.43.0

