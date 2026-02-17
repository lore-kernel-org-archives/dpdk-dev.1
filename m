Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643BE909AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0054B40678;
	Tue, 17 Feb 2026 16:06:49 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id E57524066B
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:06:46 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso3704951f8f.0
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340806;
 x=1771945606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJglfhZYxEh4TK8rjtUjZcz4mNlIisyAozn61w9twRo=;
 b=Z7SxX4vQtzhizeyDca19EVBxgGCk6RrE88sbp7uEouszgHjOxABRdNEqfW5ewfjIqU
 7ByLOl4dvApO+HuAabWbipNA04GWb92DOn/NxpNVmDP2aIWIyNPQuXNwhItgCfwaUgn9
 mMy/KixEe9rWENWJHkw+OYMxO7BOAgcBRubcu+x5EFx84CvbeqHmKc+vuxZS5fVx+Jmu
 M7I1QZo68BuuZGqifJO832mIpUxqAe0pGw4BSzSI5mwwflfz/c7Ae4m48B9LazIOn8/M
 OJWFsnfnhYNxga0s5xkOpd7r/jLuZtUbEzkZIfXhM/6tHg7xG6B7hNIkOs6/mL2u/8Ma
 22oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340806; x=1771945606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJglfhZYxEh4TK8rjtUjZcz4mNlIisyAozn61w9twRo=;
 b=dhzeQQiyyJ7ruAwWm/hY6UNJxwgW7NKr3ZY6WBRnv4I8wfbBr0rDQ4r+r7aNoZtCes
 r8OC0fyp4ZuyJy1bfldP+Q1SNqkJJxCFCHgfmB7b/maPLTsZ+v0QV955mxL2zr2196oy
 Jx4uGq86kTr+gnJdb28N2IwYusXDem4KAWkRy/WBVB2o72T7ClgWDWornrdjMlMUoQ7U
 pcU2G4pm/mSeEJaLW7RdfTyN2rhybPU4rDd4gugx8yp8dI4GdgNJPBubfTIX7e03cbb9
 sx/MNuBwtt6XTiVy63tAjzXbOijqWI4kCiDInjfH4OGN2ZcNyNn5UJc+ABG0q/dbCepA
 sHlw==
X-Gm-Message-State: AOJu0YyV/1Nt1JqWHZoLIdxZL3S56xuUX9jJlS85mfqvC8h55WeArEAE
 RRTgImcdYtPdQGeNS85tJfXyRHJOFn/UDkpbk+F+XePbCoRK2IpmKhW7Jt6ubSan2FUp/H35i+x
 TXuod
X-Gm-Gg: AZuq6aIHvAumiIlWuJpw9YTemdMhbVLOjK67bSyeI0gFhS348y1ACASt1pxR6TraXPw
 oKBA6f0F430+TbX2yoFBI3XCREDgYrzS3Qh8dt9/kYf6fZwXRkp1SURqav5AVGuBsT+aN73QA2w
 Z6ww+vSjhN+SQNkI5yMdR5GkE755cHZCym2MH4nPACx3CmElZp/ca6Mp9qnK9Rf0L2Ryc3B2ICt
 l3Eb0NzUeA/dy8Bv+ev8fOXnjBPUHlVQSDyab1cDS60eYEWeE0cFMJ2fLEDXRIDZHgRKWzoFBxp
 r6Vk1/BzxRsk0430fJJVryYpvhfxEOpXsvN7/LEUhXZB4fBbIZsbzncmGZI0Jmd+g+j5HL0GEG3
 sj1M698tDmMoEJ/GY/HVe51bWQesgwkj4AcBmk38SLTT7kYl6kGvw29pFHcRvnFIxQfNk9rL5F8
 DrUfdHJsYpRsjgSOOTdU9Gy2KJ5OfILoBWnBEKe4hElrVS7qVzxA2izitRQuU58g==
X-Received: by 2002:a05:6000:1888:b0:437:686d:aece with SMTP id
 ffacd0b85a97d-4379d622f1fmr21370044f8f.30.1771340806319; 
 Tue, 17 Feb 2026 07:06:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm28492012f8f.15.2026.02.17.07.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:06:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFT 3/4] net/mlx5: fix use-after-free in ASO management init
Date: Tue, 17 Feb 2026 07:05:01 -0800
Message-ID: <20260217150635.134031-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217150635.134031-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
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

mlx5_flow_aso_age_mng_init() and mlx5_flow_aso_ct_mng_init() each
allocate a management structure, then call mlx5_aso_queue_init().
If the queue init fails, the structure is freed but the pointer in
the shared context (sh->aso_age_mng / sh->ct_mng) is not set to
NULL.

A subsequent call to the same init function sees the non-NULL
pointer, skips re-allocation, and returns success, leaving the
caller operating on freed memory.

Set the pointer to NULL after freeing in both error paths.

Fixes: f935ed4b645a ("net/mlx5: support flow hit action for aging")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index d533ce41e1..71383f2ac7 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -459,6 +459,7 @@ mlx5_flow_aso_age_mng_init(struct mlx5_dev_ctx_shared *sh)
 	err = mlx5_aso_queue_init(sh, ASO_OPC_MOD_FLOW_HIT, 1);
 	if (err) {
 		mlx5_free(sh->aso_age_mng);
+		sh->aso_age_mng = NULL;
 		return -1;
 	}
 	rte_rwlock_init(&sh->aso_age_mng->resize_rwl);
@@ -823,6 +824,7 @@ mlx5_flow_aso_ct_mng_init(struct mlx5_dev_ctx_shared *sh)
 	err = mlx5_aso_queue_init(sh, ASO_OPC_MOD_CONNECTION_TRACKING, MLX5_ASO_CT_SQ_NUM);
 	if (err) {
 		mlx5_free(sh->ct_mng);
+		sh->ct_mng = NULL;
 		/* rte_errno should be extracted from the failure. */
 		rte_errno = EINVAL;
 		return -rte_errno;
-- 
2.51.0

