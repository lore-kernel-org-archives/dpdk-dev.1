Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5ECA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 862A7402D2;
	Fri,  9 Oct 2026 01:37:14 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id D3926402B8
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:12 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-892734ce7e6so1132595b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502632;
 x=1792107432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juElCyQVv9Sl6DDO65OhlCnvM/65YNpt3Fjee9d5t5c=;
 b=Gtrp5VsXOjZBVsDkeKO46u4O95LacHL1Z11t7ideSVtREV7ovjzPcXTFEf52+q1VAJ
 3QN+labZ0ozZbAWQaZAFSlw5mnR3oswhdfOjpH9t4CnBrjuhZpQBAHWjkhUHYogO+DoF
 aLkLYw3NlKxnGRAvM1v/z7rIr9c/V8pBdzgzwcO0eGT2HzYKGqnR60jYgVOfSYiaXkOs
 LGro2pcs8RM9skmPdq5Bwrk3wi9zy+eTFY3NvkEs/uqhpn+2Tlk9bDBYZL480dLnD7av
 00L+Yqqpn1MaiDoCc2hiAC2ZX0xjHu9apcilfDf5sVsz5dGfQRfY2vF6voeVJ0+TptZP
 Cl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502632; x=1792107432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=juElCyQVv9Sl6DDO65OhlCnvM/65YNpt3Fjee9d5t5c=;
 b=p90k7V99z9pFI6ebVstxSGx5uFjgMWrpVLl1juUa50sbl4n1F0V9ISd0rtqDK3WTIk
 PxCE/JLPJ2w52q+I9C5tbaEbRHR9YeDzsfy7fhEVOGl04jEhbqAvK4y9AZzc+5FEB1+C
 XeCGxlxL0oIxVWR0BdFgRuVrJupF3X+WDrKEhykOQMHnub4B60ZoAfHG3lI09ojsftVo
 HnIUUCGEbTsG9MZxn+3V/0ZFiCRlRzarQZYQdvxdiqZW6TZrmIDnehPyfoHaeZcZqYJ6
 x8N/crgjxM30Pa3oAVG17ceu8HfIuuisyZOSkbqvagqfuFjP0qYWnrZ8n8hF0Qryo47i
 qZhg==
X-Gm-Message-State: AFq9FYJ7rjjQ3cGzVlxVJ6Ayfg30x3fr+tDB2wRigtHlekvgBsZZM9LZ
 mVgBkY3k9dTHJj/a20H/+k+bA0hwRGh6fAlQLWroEbJmrHKtsD6ySRmIsOjglQieBxm5D+DieK/
 qdbZ8NSM=
X-Gm-Gg: AYBFou0PDf84nx26cW0uC5O0H4uj4ba/cU56sufCiVyywzGlgH+LlJc29N9ICHlxGXt
 7vrlNFODbzZOZEDdM5ssarfWOTO5+yo4yeqHSVQwRRuyQyBv0W2Ui+w2obpsr8YnfLgbXc1NQDt
 uFgqvlXKNehp6yvDJemY1vKgwt57wirYzQSGi0lWfP1qDL5ZQAIhBntV7DhRm6sQpg3jH+1/S2H
 1VQ7tzFjZPGNOjRYHxH5uRSQAMRDlSxDYQKjpEX+RO+0bhpkOYySaCKXxRGaZopXHsweoqF+GTd
 5hOpg9N/eZnDRlKfzpoV+wlAQeOHKq7YKTPnCRvl+Z8ACBhZZjn+cr1gBWhb3Y0CpvSWAqtA6Fo
 pJf+seZ+vBc9lwQMycTYdicJOa9DK3AdXkUAy7Fyg2Yl+z7JSDNGmONJIvGCw5UXk5Y+qwSy3bh
 HqQAeskCCiL+znHqVx98/GwdTVIbqfis7IUAPB/vGGOXwHwZvykhEypxLwlUPCEwYU95jK+M+2N
 I0fWh5iMBuFCzSeAnXjF3jrgxtKv0OSyq/xJHUYPCm1apb1
X-Received: by 2002:a05:6a00:3006:b0:891:6721:36df with SMTP id
 d2e1a72fcca58-897c644526fmr75889b3a.16.1791502631969; 
 Thu, 08 Oct 2026 16:37:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [PATCH v3 13/29] crypto/virtio: update comment reference to
 rte_smp_rmb
Date: Thu,  8 Oct 2026 16:35:06 -0700
Message-ID: <20261008233649.1260843-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The rte_smp_rmb helper is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/virtio/virtqueue.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index 97a3ace48c..6ef40d3593 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -302,11 +302,11 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * x86 prefers virtio_rmb over rte_atomic_load_explicit as it
 	 * reports a slightly better perf, which comes from the saved
-	 * branch by the compiler.
-	 * The if and else branches are identical with the smp and io
-	 * barriers both defined as compiler barriers on x86.
+	 * branch by the compiler: on x86 this makes the two branches
+	 * identical, since virtio_rmb(0) is rte_io_rmb(), only a
+	 * compiler barrier, and loads are not reordered with loads.
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-- 
2.53.0

