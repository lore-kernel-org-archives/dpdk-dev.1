Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0713C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B7FF40647;
	Sat,  8 Feb 2025 21:32:02 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id AF23640395
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:00 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-219f8263ae0so58988505ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046720;
 x=1739651520; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0tjkpHfiRhAmYxF1UXjjZsXNUmjuuO0FwTDnZIaCO8=;
 b=ejykypiXZrYdjHLIqX+LEh1YnvaFMtfdN5Srw4eDe3LalARLj9DLIKihEExgVAAkdi
 xPwdSqNaJxKXIG403IwR4zxu/ZTi9ld9LrCUWUcvnEk28onO1jz1T58saLXB5rnTwb18
 YBKmBcT5IjlzlB4vgqMcoFkwH/aihu6Mzg7qnxh4N2Axj8kIGND28BBZ56MTgnCjo8cf
 QckcKgAnrQvnV+8wmDr6/kEcreQORkhaOjHjMMbefhKSdCwCV6oT/tmlTkNuP5i1GYAF
 +NFuh664UWrNXxXRlG9XKEsts5ZWJALJt7cP/hiC+02smDfJPTM8P2Scl2HIqjlQIx7Q
 lwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046720; x=1739651520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U0tjkpHfiRhAmYxF1UXjjZsXNUmjuuO0FwTDnZIaCO8=;
 b=vMOYuD0NHUbLRmO6QDp/XqFjuKExO7+zO3PiVgXw/GviQfYkVQlf3BB8vcdXfRlAvZ
 HX+6dAa/BynHjQwtK9sEf1hYfmj9LtzAprrL9QeluUcsNbFdyIV2osfLyMsquzsbxUGu
 O5+loy3cLHcpqrbUzncanCsCA4nfn9XIzXED8WjPLNnV2MbIxa1evAoSXTR2hdyAvsDa
 k6Cipd2PTmMAYWEcNy2TeVM0NDe3HI0nuC0y8u4XBFiISfju7meq3/d+ir5wqDfeWRVA
 qav6/XetxHCqd12I4jhBgNKCvLmn6z0mSv69g2TQqRo1MQEYfu9eENjQg/BLUrUYYtoA
 yqNw==
X-Gm-Message-State: AOJu0Yyq0OCcIQNPKfGoEcQH5VPjoVNTrjYB7uTiEDGk9GK8cjHhndCp
 Z4Lfk6J/vMJDGIOKWn5tZ452oa5sxFNRWopcPpdne1OjUN1RuURnbrqCpykfBBmVC7QUAS+H0jI
 0YOw=
X-Gm-Gg: ASbGncsOIJ2icd33OnwwBJHDgP4XDU3aZZlYhKx//ETBs5rQ3QX2OD+YU+p5u/3VJ/g
 v4oMZ/QQNdYjAXWFn9mK9sBR0EemvwXEakypiQwEzuyoDvAUZeDY0XrOcs7oW2j3weYVnxAfikb
 UvgSS2FlkT9tiMl3KTjyZKsL0WS5vjzWwRa70SzG0KHr3O3hIdEoYCqidTF2bvdM8WDqrjxqnQV
 3xfbGZCRH2KXhx0/3WmHoyyZpl0I64gwcf7zx0LkF/hw2u+PX5Zgdea2HVOuB2KIo0XeQms6UBn
 r4bkhhhuUth5N274lxiE/pA+Ni2ZEj7w8f9nQrXuaR70QPBUvaeQOvgjXRfv1ysU1pp7
X-Google-Smtp-Source: AGHT+IFuE5fWxLlMabN2U+NxqhVzCP/u2uHCyAie6dospH6TVrLUnHRhjqDkr2e0UTCysMAiG0TR7Q==
X-Received: by 2002:a05:6a00:23c8:b0:730:7d3f:8c80 with SMTP id
 d2e1a72fcca58-7307d3f92acmr3222709b3a.20.1739046719882; 
 Sat, 08 Feb 2025 12:31:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 05/32] dma/dpaa2: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:21:57 -0800
Message-ID: <20250208203142.242284-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3c9a7b5485..c0e0a44e84 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -171,9 +171,7 @@ dpaa2_qdma_multi_eq(struct qdma_virt_queue *qdma_vq)
 	if (unlikely(num_tx != qdma_vq->fd_idx)) {
 		dst_idx = 0;
 		for (idx = num_tx; idx < qdma_vq->fd_idx; idx++) {
-			rte_memcpy(&qdma_vq->fd[dst_idx],
-				&qdma_vq->fd[idx],
-				sizeof(struct qbman_fd));
+			qdma_vq->fd[dst_idx] = qdma_vq->fd[idx];
 			dst_idx++;
 		}
 	}
-- 
2.47.2

