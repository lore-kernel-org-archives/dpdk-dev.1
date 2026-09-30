Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8628ACA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 257E043265;
	Thu,  1 Oct 2026 00:44:48 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4DFC543245
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:44 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so3309920a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808283;
 x=1791413083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=KVPGUw/jyJuUQJbAKLNhb1za8tbq1nwNLmTzVMqyMwOAibtVXVWzdP2QkO1DHwg8GT
 GqlVbPZ8d0mhxPIBecfqQpP6JKPt241wflqpH46jKmYJ8lyfbOPX6S5VZURat73mkekp
 efHvfndDoABfMFUyWI4BYtCHXKERhQyjHHApFrrWGSxqTw2sJTcT0qAGfujBxhxJMUMV
 S/5/DmQmq226W+y0052wogmDaI23yXEvZweBLReHX1kFr1uX1gtx259dNpNhRpmgDGVH
 bTD79UxaU4vB7G9iiIYYYgKRw4IM22TAc/UoGwABsKO9dWNx7M4d0jd4sif+o7UO9T93
 snzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808283; x=1791413083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=nNsrcBA+aoGr/poiAtCP1vwdTDxXXQRSS339sE7ulB1EdmIMOBxu2UgR3aF3WZYwDe
 hLyWk606xRIcYlVZcTx/Um8nJbCWpxrSUwohAxCRlPdz89Td+DC9duWLdQHWBZJDiLrh
 7BOHJt0JUL/0fJKidb16WoZUX2tHy7JHvp1/JA7UMeFPv6chaaGJptsIloKUGU6UVz+I
 knuishKsmEx6f1pB7+a+4Aqv31M5ycY3bnAfxs5dh7X7w26UEGhSohfSSSl7xyloRnv/
 P9k60EmA5EVsFIgsrNCyw8v6tLRymt6IdMjFb3PnjbLDjHZQLMy3Te+BHz4Iz/RMIkj/
 my9A==
X-Gm-Message-State: AFq9FYKJi83c5nBZkA1oW/nFDTt3UtFrr0iiDB/SL/4CC9Dxs8xnuhHF
 JYE8KNC5R/DHFDz/0A3uqChOLZCTRd9ZFlS/rE9OHrwaG2kCUE1u0qY4ySXlp5iE+TCW8wNh95h
 IgWdUfWc=
X-Gm-Gg: AYBFou3HETSxSBfg0pU5aWe3bhC96RS3RycqGgLVeLmrGsnQMpVXKT2rxgwvVu69V0g
 EnICUHpRDfSCMKkoJEhODR81oNB9RN4FpHjHrOG5O/FWKilYXjpiUFJMeIMSodLCbrwN72kiaO9
 S+Lilz+SMDZvYm9BG6fmaK/Z5hy3HJBkEUpy21C8Hw+tHwC4omUu64lw5yTp72M4bHn574rcrfU
 6JNpgK35oNqDVL+2y0tEW/1zz7flK+HjMwB73f/f5k4KqGe6F8UvXlJgmDHwp5QGmfpPPyjac6H
 oMDyFlgrGFIyNLZqC7eWb2T4X3M4TWFaybrVbTZ1WF7o04qaZThBODJ8tIv//azM29kl84uIQPy
 tThIt8em2VLqLOQ0HpTk1ryFXo4dEQX2kOeswkyYiSrJ600mwXygcEAcF/PJUX8k0j9k6wNya6D
 EsCGnYRhuxTWzvWSLjVHKpYWChQ0g3SvIzot765M5pTkYdy1km1DbXV+2zSvq98icUfKaRL/ykH
 3wSKoWBd4hbk80TMFgVi2vcjR+h2LOKhXq8uA==
X-Received: by 2002:a17:90b:3ec7:b0:3a4:b0c4:1c90 with SMTP id
 98e67ed59e1d1-3a4d1b9bcb4mr2303814a91.58.1790808283355; 
 Wed, 30 Sep 2026 15:44:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 57/65] dma/hisi_acc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:15 -0700
Message-ID: <20260930224340.58580-58-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

hacc_dma_parse_queues() open codes the errno and end pointer checks the
helper performs. A queue count of zero is rejected by making one the
minimum of the accepted range, as before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_acc/hisi_acc_dmadev.c b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
index 196aaadc05..7db93852a3 100644
--- a/drivers/dma/hisi_acc/hisi_acc_dmadev.c
+++ b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
@@ -660,13 +660,10 @@ hacc_dma_parse_queues(const char *key, const char *value, void *extra_args)
 {
 	struct hacc_dma_config *config = extra_args;
 	uint64_t val;
-	char *end;
 
 	RTE_SET_USED(key);
 
-	errno = 0;
-	val = strtoull(value, &end, 0);
-	if (errno == ERANGE || value == end || *end != '\0' || val == 0) {
+	if (rte_kvargs_to_uint(value, 1, UINT64_MAX, &val) < 0) {
 		HACC_DMA_LOG(ERR, "%s invalid queues! set to default one queue!",
 			    config->dev->name);
 		config->queues = HACC_DMA_DEFAULT_QUEUES;
-- 
2.53.0

