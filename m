Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F2BC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D05840DDD;
	Wed, 29 Jul 2026 19:57:45 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 31A1540B91
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:38 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so13038665ad.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347857;
 x=1785952657; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=oqvayDW5QhKrbC19cnhgSCt3bRtY/rLx1K5FAT8XhI0gdejq78YhCDcFxBvsWkh8+L
 iMLcUGJWXytX0FOKK/WkDnjXFdSSImENhevQfsjXonAE2grONBiOOk6sDH/KyO5FI4q7
 9RRP3XIIqq/9RqFjnESS6pWWFSRifZklG1euWGYJP0sdMcUyfuNSYU40US2ZWsIT2Hmq
 1RLtfjdVxDB2nh+rsQM8FoWphzCkeeyw/02o79eOuQkHN0tmTK2mAvmvrCU54jycvkp5
 enJcz/PBCD4yQ1CimDtFOKtU8nBBloDaN2lNbXCQedjXpMLQNtlpeiRO0uR1TAYFBQdr
 ORVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347857; x=1785952657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=GJJJPDw9rzmrBSwFHEaY2bwE7FJj8JD6I6YQUOWoFlhCF+tCBE1X28iOVTWVMAuZkn
 wJnEXcRRI7uHudbTzQG4F68p2aHj3ZKvfVXY6eFb43XAf60LE04Fbs0YZUsV11/xrzF5
 NgIutB6f3+Y/hPhYpOMfcnVGpb7PQVULUR6c4O+CnubXXbFRuboeK6J2S9XwXCCmi61M
 XhX5K/rBPCaCLHQ9y/y2ydkLmHG1CdBU6MyCnHho3POvaYwwmbxzkWcSeXaDzLyuNhnE
 hq8oEEZEoyNL0xj254R9rBZea5Uxle3In4IdF97rMQWJ04fjB5ByWLpwaNSr/zlswAGi
 6T3A==
X-Gm-Message-State: AOJu0YzvrQfXDzEsfgcQm/ru7gdTkIsTjKZ/lSIUCrZ+hJswstrGyN2j
 F++drTBIgGepms0sbFcGOv09UI62GclCQOx1LKCGiDSMSJsf+SRwggen7Ngz5vzlacRxN9te7oN
 Sh95R
X-Gm-Gg: AR+sD13ek5bW0xsPrRCwFtF6Ytv817eQAapblvuO9tPishQwd4tSa/8OX4WJzKPBrPS
 CdgeW5wGDutN4yJS1lRsx+tKBaFP5j5iBkF4+USvHZLXTGBGyOOvEuOM3nX8yliITQWFbp7nbQT
 n/1esbSed4LJt9plfgzo/doQkn/u2KVq39ERgY5ZbqCH68R4wfMZ0bsC2A9VTY8KZQ/M4ubqPfJ
 O6TXsDkFjekzVy9Ru/0FBMU7Ib34U/EBhvli2fFS3BLk0yx86g5OBlwf+jPOPD9tD59yTxNKgw9
 Uuz/psivWF2i9dApi1BkLpLOPMLdbxoyj8vYHRzTA0iWLU+sqSMpTFhESIEy/zhQ1BQYlyo592O
 L1ZDzcjm6UVj9JI8oLKR2HPuhwseGgjXzgjAPRxPzWMNjQeWe8nyxtdjD+4rkEhLx9o+W5MWU6+
 tbdCaPAuBh/qAb8vSygql5Mpa+DsPJQEy/tQzf3pbiM+rf9JhzSuCjCZK5vpkGLkBLTZxoOTxFc
 hkxXDZZ6sNwSn1XPRcKtAErhTM=
X-Received: by 2002:a17:903:2f0d:b0:2cf:b68a:340 with SMTP id
 d9443c01a7336-2d015abe547mr90151005ad.10.1785347857231; 
 Wed, 29 Jul 2026 10:57:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 18/32] common/octeontx: remove redundant barrier in mbox
Date: Wed, 29 Jul 2026 10:54:11 -0700
Message-ID: <20260729175715.165120-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The SMP write barrier between writing the mailbox header and ringing
the mailbox register is redundant: rte_write64() begins with
rte_io_wmb(), which already orders the header write before the
trigger, and does so against the device rather than only within the
inner shareable domain.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/octeontx/octeontx_mbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/octeontx/octeontx_mbox.c b/drivers/common/octeontx/octeontx_mbox.c
index 9e0bbf453f..8b0da3a98e 100644
--- a/drivers/common/octeontx/octeontx_mbox.c
+++ b/drivers/common/octeontx/octeontx_mbox.c
@@ -113,8 +113,10 @@ mbox_send_request(struct mbox *m, struct octeontx_mbox_hdr *hdr,
 
 	/* Write the msg header */
 	rte_write64(new_hdr.u64, ram_mbox_hdr);
-	rte_smp_wmb();
-	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ */
+	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ.
+	 * rte_write64() issues rte_io_wmb() which orders the header write
+	 * before the trigger; no separate barrier is needed.
+	 */
 	rte_write64(0, m->reg);
 }
 
-- 
2.53.0

