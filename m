Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A86CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:07:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2055940B9D;
	Wed,  5 Nov 2025 22:07:05 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 879B44066C
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:07:03 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b98a619f020so206371a12.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762376823;
 x=1762981623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4nJvcgVop/3xj6QnUnqHh2Qg7Qd1mTJeW18Ky2sstA=;
 b=xkM9QCkohtuGUdq4vSJFDQBCdwYeNfuRDJQO5CuzRLlpMok5Ei0LTzmgixlqQ3AR+T
 wGqzl4u8DWFhnWYwp0iEcNrgCrDWNUCnyrvIrIpW5xW4UlNrvVSCa/OT0OirS6w7b+Yv
 MzT3dUe/6x1BVLm8pUKxisweSMOz5qnv+EcXYG8ze1BkIlMrIrgfugqYGCf2X+rAgMny
 BhDlLdrfu3DZgZD04sNKwiGiHJt8B4sDNX/LHNGaugs+deVXT/FQdvyo5tDbEfCdQWhU
 9uKZyTEEOaNFivWvv0r9Rcrct5up4vBcZjmEFrx+/bhZlBFrloEqvbBv+zqbHQMUdZcg
 eWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762376823; x=1762981623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4nJvcgVop/3xj6QnUnqHh2Qg7Qd1mTJeW18Ky2sstA=;
 b=V7jtvNydT9IGROfH58uA4LOzWDMGx70cIsgSrg9nOXXYbeH+KfYbQRqqBigDb1TAeH
 HprDWDbaSCWZx4W6dsU1KyRSx38otDI/cQokkFTvnc5ljWk/ubX50Z1FahoUqrba2PRV
 d/vbYtdgNjMEvXg8pm8cuAixG12VB3hce64luzrtT8jRTFtI57DTl+mX3VetQ+Kyv20D
 ReBkRNiHq5+EsMQV1mdV8BZMlrG618C0Wf5PVOJuKxvMVGaAOd6v4S81pDI8OPWqb6IK
 O/5HxC2O1z46phF8rNfdVDFVfMR6sRND3rSwu9LbwQVxDzzObv2+o+GMY+UxczGiKhYx
 iwcg==
X-Gm-Message-State: AOJu0Yz5g3X010Al/XUXUmfLZY4L6uJ8g13XS/egb3KgypB68BmKWstR
 wKJO/uDfm5ejGV3KUc1jy7HPbTixNtQxl6OolzPSyuZrrCy91nMr5zQItqR9bnhKD2luDVmDAcw
 wCQfx
X-Gm-Gg: ASbGncuXxLFBUSYtJyJ8+zvDffvzOi5CKEPrFdR55wmbjBSzOWspuyub2TV5SOQ4+6z
 baignoj4DG1q08OrmL6sAeHPP+HqiP5IvcxYvoj8ESPiUbH/o4qVuKbvSaSYM9LJCj2Che9dvB9
 Cmj9b+Yn6q8VM2nWYE31c8D2REIJTsPXSlAaYA17bp3F6VhbpcOvvBMwqu8X+i3g2+mnRLS7bWs
 Sjh4iaKxoHP14FWnAqxPnE2D4P1suzq6ezEJO+yJ5bSj+ZN5i/1TvYZLjCxy9rutyqcEcqjJW4Y
 /ZeKN6URiFTcZwxr99ksNKR86Jf34f/PdnFhBO+XTrHfcGm8kVWwA7WrDhkdjWKd4zA2C8aRzd5
 3T+yQv55HZ/zTJNoxrCHhXK0qIWt1iLj3DC3H+d8Z1fIh0SFhMUlj2GyWkJcGkrCgmmjA4jC9wQ
 8elbVTXhMjsIUZ6XtldGipE5loFqg0wfXnvKZR4bo=
X-Google-Smtp-Source: AGHT+IGpfH3cE4rxzOxYBoDf1vCQLYkkgC6JWuQurm2eTLCXgbWOdSLe8r/iazY5KNEyfhJ5NohhJg==
X-Received: by 2002:a17:903:244b:b0:295:20b8:e0ef with SMTP id
 d9443c01a7336-2962add94fdmr57733475ad.57.1762376822572; 
 Wed, 05 Nov 2025 13:07:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5ee4dsm4725895ad.45.2025.11.05.13.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:07:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/2] test: add more tests for comments
Date: Wed,  5 Nov 2025 13:03:59 -0800
Message-ID: <20251105210657.871310-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210657.871310-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
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

Add some more cases where comment is set in pcapng file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..7e50457794 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -162,13 +162,20 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			char *comment = NULL;
+
+			/* Put comment on one out of hundred packets */
+			if ((count + i % 100) == 0)
+				asprintf(&comment, "Function: %s\nPacket %u\n",
+					 __func__, count + i);
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
 			}
+			free(comment);
 			clones[i] = mc;
 		}
 
@@ -386,7 +393,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,6 +420,13 @@ test_write_packets(void)
 		goto fail;
 	}
 
+	/* write a statistics block */
+	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	if (ret <= 0) {
+		fprintf(stderr, "Write of statistics failed\n");
+		goto fail;
+	}
+
 	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
 	if (count < 0)
 		goto fail;
-- 
2.51.0

