Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A25CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B75F40DDA;
	Mon,  5 Oct 2026 22:25:24 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 1BFA340B99
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:22 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so255707a91.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231921; x=1791836721;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WQRuKrIFi6tZGGKaP2rwPTp7BxiXh7jGPk/QxEZ5Jaw=;
 b=YOKVbuRrsfdmIq1s9IN6fGarEF1msZ0FKFZB+ZAAUJuTjTqD3mAe8MOcGjasI7pZnZ
 1+O0sPsCYWqJ2nncHY9CUp1Z4iW4IlhM6TMrnKIMUBys7ZEZ8QQRKzM+MbQnFzLLLS8Q
 lhjFIFywnRyi1bWFbknPbaN19YD7rmh4lLEwJUQliTIGMkOTA43uUnZRYcbDNR+ZddJk
 ddv4jLc1yupqVxP1hTU9GCoPcTk7TgaosVNPm3KBfJ6lNzCK5rVOPhDZwP5pbkJ2nju+
 pyMksM8oYo+lfiC/CvdErr2w0Y99nyezh8imRUQLyv3kgDzSELBxuTk6jkuTTqu+Nfr4
 P7Wg==
X-Gm-Message-State: AFq9FYJrJp369gHBbPZ6JTnb1dEEhtHnoXQNbPkXDuVC+WvKzfz3kQaQ
 z2yRAF1OGbLXr0vrJe6oI6luDzSYGnNKYOXYaYZSUkaQ4GZytD9G/VfhpcKQY3lszmJX6/yBqRx
 6QTQMdVaH0lrbM666Zd4POBxYe57/rxDg/J9aIAtYfI6UfIN7e6IUOAE9yudRht7u0Qqj/I5TjF
 9nmlqV+mdHxsapB+/7xZTuVv0LaSxzFkNYeCiLd6m7CDIm4cLYo7SCX6hGcTK9uCRVjo2RaA==
X-Gm-Gg: AYBFou0DdTH8fjw4UXspMHAOL9qrJ/Nhbgl4yEjLYxCa9NmQxkg590JE8FESXh6TAEE
 La+P3GpaJo0eIkg1zMQSGGFx4UtDrL2sRhFfiNLe4W0Ig7d1rsdJY0HRtCFDHfTrqGPQXpatJ7S
 HWMXmHCC1EZJfDLMPirQ46BhsQ3NBSr95aN0jKTxGd5SD9HZjLQ/3QT5CDUTIFzuXFl/HqjU0Xi
 Xnfx10o8Nt/j58pyZ0z/Bv8ZvI0hYP6UgZ1FLVIu/136rD+2eI2Ty4XeNWpu0X4qHUGKZZZof78
 1AUGUcW9Q8MgZcy48uz0OgOfD0RIKGG3iPEuDwKurudsqBGssmjwCLJhIMQdgS16j/dIcZLmfIH
 yf5qeiwmqlNpLL9QtZfZo6jx9TSIADM5LB0E0oiOoDFv5kLgJyGclJN9czcpYjDIXCrpBRFL+vo
 nHpbvX0UBrG7QaDJRT+/EX9HYi5+MZX/Vo1is=
X-Received: by 2002:a17:90b:388b:b0:3a6:fec5:c179 with SMTP id
 98e67ed59e1d1-3a6fec5d128mr8125034a91.41.1791231920998; 
 Mon, 05 Oct 2026 13:25:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6dca3996fsm1615701a91.0.2026.10.05.13.25.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53380b67cfdso47847601cf.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231920; x=1791836720; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WQRuKrIFi6tZGGKaP2rwPTp7BxiXh7jGPk/QxEZ5Jaw=;
 b=fTE1RrOqfp8Q3tWn3RVhCcD+MgfEbvwcL9PmJS/IUuEITAhQAnvjRtOQlifdlgNyXl
 oJgWcWD2VYwLt0RyR8gh8d/ZdhhfXLHrwzLpxfDvshCpWuuh7RHsXHiCQrGetk1JR3j4
 q8xwov8m5YXlkP/j7ZDcB8ZfZ3sl2rIQaVtz0=
X-Received: by 2002:ac8:5dd4:0:b0:535:25db:17b1 with SMTP id
 d75a77b69052e-53525db471cmr93274451cf.17.1791231919600; 
 Mon, 05 Oct 2026 13:25:19 -0700 (PDT)
X-Received: by 2002:ac8:5dd4:0:b0:535:25db:17b1 with SMTP id
 d75a77b69052e-53525db471cmr93273621cf.17.1791231918705; 
 Mon, 05 Oct 2026 13:25:18 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0c17b8esm94106166d6.43.2026.10.05.13.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:18 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix bit allocator out of bounds read
Date: Mon,  5 Oct 2026 15:25:15 -0500
Message-Id: <20261005202515.17821-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Joseph Wong <joseph.wong@broadcom.com>

In ulp_bit_alloc_list_alloc(), the loop condition could allow the
index to reach bsize_64 before the bounds check ran (the do-while
body reads blist->bdata[idx++] before the loop condition tests
idx <= bsize_64), causing an out-of-bounds read one element past
the array. Refactor the loop to check the bound before indexing.

Fixes: 0001cc58d362 ("net/bnxt: support generic hash table")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 .mailmap                               |  1 +
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..e013a7d6ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -813,6 +813,7 @@ Jonathan Tsai <jonathan1.tsai@intel.com>
 Joongi Kim <joongi@an.kaist.ac.kr>
 Jörg Thalheim <joerg@thalheim.io>
 Joseph Richard <joseph.richard@windriver.com>
+Joseph Wong <joseph.wong@broadcom.com>
 Josh Soref <jsoref@gmail.com>
 Joshua Hay <joshua.a.hay@intel.com>
 Joshua Washington <joshwash@google.com>
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
index 74cdd5c1da..d94b59286f 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
@@ -21,16 +21,15 @@ int32_t ulp_bit_alloc_list_alloc(struct bit_alloc_list *blist,
 	uint32_t bsize_64 = blist->bsize / ULP_64B_IN_BYTES;
 
 	/* Iterate all numbers that have all 1's */
-	do {
-		bentry = blist->bdata[idx++];
-	} while (bentry == -1UL && idx <= bsize_64);
-
-	if (idx <= bsize_64) {
-		if (bentry)
+	while (idx < bsize_64) {
+		bentry = blist->bdata[idx];
+		if (bentry != -1UL) {
 			jdx = rte_clz64(~bentry);
-		*index = ((idx - 1) * ULP_INDEX_BITMAP_SIZE) + jdx;
-		ULP_INDEX_BITMAP_SET(blist->bdata[(idx - 1)], jdx);
-		return 0;
+			*index = (idx * ULP_INDEX_BITMAP_SIZE) + jdx;
+			ULP_INDEX_BITMAP_SET(blist->bdata[idx], jdx);
+			return 0;
+		}
+		idx++;
 	}
 	jdx = (uint32_t)(bsize_64 * ULP_INDEX_BITMAP_SIZE);
 	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%d\n", jdx);
-- 
2.31.1

