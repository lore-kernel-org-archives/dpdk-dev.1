Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA38CC88E65
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E7A840B8F;
	Mon, 14 Sep 2026 12:58:25 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 1624240272
 for <dev@dpdk.org>; Mon, 14 Sep 2026 12:58:24 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so34186785e9.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1789383503; x=1789988303; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u4410uXSrk0GhN1eH/lQtJBtcMyIl0EPIbNpVf38mHc=;
 b=MNK2fyrVfUoZtBx8npZlmtwvOnIPUqOkPNairaNa1OW2IeacamRWrhPyuRq6vP/uNz
 MEHlWrs3S8kqcWFbmN3WjSFJgk3KFfBu1CfC04ol+FPtO5i11hBUpeaYGiu3JMGD4VWL
 jngWsa2U5k0eg0Pa4h8pzZN03s2c4O5xck4ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383503; x=1789988303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u4410uXSrk0GhN1eH/lQtJBtcMyIl0EPIbNpVf38mHc=;
 b=W0M3u+WHsrh2nNXOTbq1uNsQFF8S3frXRc4ODqPDDRTZ2Ce/vTaW6Lyl387V5hqvuu
 HAc89J6E3rYBT+fmJVwoVlpqdB6LNswGIONF2yzYIVi4FEn4FxjcmwOaXEO3QA+VIyWs
 2jnGL2K7YFVzSs/x8pMrXrD4I3fM/KX5FaTTS8/yIh29v+uqevWz2VTIkGV06F/fTggr
 Y5YDlSCz5m1S+xMJFcJsPniS3SJYtB0HEhChvRtsHCe8CPmUxOk9AFwD3gRj2CydyqM1
 HE+ayBCz9wWL8dICIzcHFq4Df+h7sQw3SfxxiLviu/2czOuiGSbWRHwf/Tw7onKQTflu
 Xlxg==
X-Gm-Message-State: AFuF++n6sV4btcLwmIE7eax7pdwagjJsFeFILIAqI0YFjlv/KDiNgk5g
 c+7nfIQihnTlhOdrEklZ7CuQaziyHEZerOMKkDLnamKJbDD7BjcmlEmjLF86MWrhupmYZ9PxX+b
 2GbfRgF6tSCdQIBhrq8/QgnSDZxt6MdI4btrqCxvQFVjPSHIpcD+kNSwJtR8kYZofmYRej8nMdh
 Y5GkfYG0w1mF/Nos8mMuABbpN9BdaT1Z1+lL+8/FS063o=
X-Gm-Gg: AYBFou2a3oxiOrNiqQHz2wqgX+a9G9te0ALtg9ooURcNYqepd6lr1GVB0ym2lM367Cb
 n4+LhsB2b9sZfxpidF0nPKznswr8BhNeQ5Z10VTDH2mQ9T3uyaOh5g+4Jue56ahprUHlUJamAkP
 Vkfulh+H5HeNnuEErqhPzmi7wt7FiiotPkQUGmuf8uTy3ZAD4r6C/rOP1hpXoO5ReKIGlg5mE6m
 9i3PNtl7Wq0MV/eTiUiiIYgLK0seNibiN6uHHrKommB6DU1xxW8cnRkmdjRuOakSyfCVc/JJozE
 CMbjh2+hWNAiqXAg4U5honeA8ZoOdeX17U9iQ3oBNUip6D8XfJwmTTQvJeg6ajIraHaXMr/UcZf
 hNYvyoEOktrUWYxbUqFGzBVvwAHXUnbXLiCtpuO6xql1jNIf+SBeSXOiMwqMJETx+VNVZgGtunK
 Vpp3FMsiRz2XLT4aBM+KOg3tSMkiVYKOZAFyoxgUCHzQiTRmjnVLkMMRB+hctSVDSFnGMQz5L4C
 CiOTVJMiIUmuxzkexKHT7SI+9Gj7Y/Vmx63rGIuF08I+HBefiap3d0=
X-Received: by 2002:a05:600c:4f41:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49e7a685a1amr26038005e9.16.1789383503388; 
 Mon, 14 Sep 2026 03:58:23 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490.wekalab.io ([185.114.120.178])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6fc9c027sm204305165e9.1.2026.09.14.03.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:58:22 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com, stable@dpdk.org,
 Rita Ruvinsky <rita.ruvinsky@weka.io>
Subject: [PATCH] net/mana: fix Tx stall from send queue free-space unit
 mismatch
Date: Mon, 14 Sep 2026 13:58:08 +0300
Message-ID: <20260914105809.919580-1-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
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

Derive the capacity from queue->size, which is also what the ring wrap
in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs occupy
exactly one unit, so entries and units coincide.

Fixes: 56dd45c0ce7b ("net/mana: implement hardware layer operations")
Cc: stable@dpdk.org

Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
---
Independent of patchwork 167383 and 167384 (net/mana MR length
truncation / Rx WQE double free) from the same author, currently in
awaiting-upstream: this touches gdma.c only and applies cleanly with or
without them.

 drivers/net/mana/gdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mana/gdma.c b/drivers/net/mana/gdma.c
index 7f66a7a7cf..c80fc25f21 100644
--- a/drivers/net/mana/gdma.c
+++ b/drivers/net/mana/gdma.c
@@ -138,7 +138,12 @@ gdma_post_work_request(struct mana_gdma_queue *queue,
 				client_oob_size + sgl_data_size,
 			  GDMA_WQE_ALIGNMENT_UNIT_SIZE);
 	uint8_t *wq_buffer_pointer;
-	uint32_t queue_free_units = queue->count - (queue->head - queue->tail);
+	/* head/tail count WQE alignment units, so the capacity they are compared
+	 * against must too: queue->count is in entries and undercounts the
+	 * queue, stalling Tx well below capacity.
+	 */
+	uint32_t queue_free_units = queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE -
+					(queue->head - queue->tail);
 
 	if (wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE > queue_free_units) {
 		DP_LOG(DEBUG, "WQE size %u queue count %u head %u tail %u",
-- 
2.43.0

