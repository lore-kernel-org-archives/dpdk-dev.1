Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F96C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E42240E30;
	Wed, 29 Jul 2026 19:57:56 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1D9394060A
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:48 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so713068a12.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347867;
 x=1785952667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=myd8/8w9q5qDu09PDLUwkhGcqZeeVUZbj6n521rFOOs=;
 b=sPiBJNJW2496rVy9MBpBGUoiw3yrylyHW1wH+HMUluZj/yq2iuP1wO5e1VOyXGFbkz
 1lal8IJ5cgsJb2eQXabKGoG81QR2xG3nQRLxKYV9GnY59rsz+16t+/2EJfoZoKh+MqQC
 xX4E4Xn1JodHhT0obfS4/aHQMxx+nspxJ6UkKCr7rliPOCBrCji3Rh/RQM5siCM4mmW5
 44BiNBqjM/o0L89e8S02ZN7uPisai0aFfpp/Ev6sGRuybnseMVL4ajzeqhS75YvsH76P
 uBfkpfqwwxrEZSRPP60VHYiNDVWLUxAz3DmEd6UEFVIxBGgvp37gUUNcdCWlXrc0tdFH
 SnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347867; x=1785952667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=myd8/8w9q5qDu09PDLUwkhGcqZeeVUZbj6n521rFOOs=;
 b=fkHOZ9l0T0twjXpDIt4tNEs4WeMRrPWFeMCJHa7JMyKVxL2xXe03d5D8m9rHceYwaN
 68/cHspukfUkzdYxjBAPaS234LBIlcFL63Cit9urlGz/7I1c3jEItOroqPq2m/NYfQ93
 KatHlFw1QlGapKu251VbMOW2+cSCDyQVGh696lgaiabdkuEEFxwCm9wo9lm5rpaZWTNq
 TDKNtx1Z04/OFOoIB23YA0QMfE4kMJ+rxuy9UzwNh859vsMAF1jJvWV8D21ZKB9gVGDL
 w0XOdsfCjh5ZRsTlhX+pS3/Go9U3X2/nIEvPmpyumsr/H0j2ZPpX17wMpGxjuTaNaYDe
 jMqQ==
X-Gm-Message-State: AOJu0YwMEH66DMxdSq2OBfJHinhL/aliBdbeIc6NiKFizyS2CgyXHxNG
 Qf6HnTUFwRuKD4r/fWLcqcdGCN90HpNxxlRk13d1I3OxjRm6F4d093P2KtlYgf3YbVztf0HM3gq
 Xk9JW
X-Gm-Gg: AR+sD11Jvgm5ud1oqWsr7iIxN2AoT+VTKG67VkwGKSMONXf5lLFgaBwUWQsI5+xIiIf
 n7l6yQ0iek9p5jUWRelZZYXLonK80tPsEX3G6pP8Ma9jGEbvhgCwO2jYC9DIHAixYStDm9MZY7/
 8ZcnshsGXI1wwyoGIK+DM4dcFdg+v8fc3N7EglhozwR6NwifYHy8dbVH++vdRYqiHjt0tT4Dpom
 NkBWqqfMfSIz6XrE7Rj4t0SMItbPyp7vudXfgH6bz3hQ9OTM3ytqSR9I06+bPpvk9rFlwHvFBtM
 1wik5easfrBHrQe2rzwALuNO0Ezif0dkfz9/swePmOj8xOtuwfaJiFo9YG523Tw0uHlS65M6Zw7
 R0AJxnv4T7lUkctZDxrcZDV+3RHSW5b37829M4HiEca4gz+uCVHzmv4HxpUDBcjtaPuJOJXYS4J
 gm2vaw4gnDt56/ZY5eapwZKz6OpGv4+pnbArbv19CyXrQk7sFRtJarJd+bMbsafhI65lc9RpQRU
 GCyHfXJ6vU+O4ErqCBwjR4frBw=
X-Received: by 2002:a05:6a21:6f84:b0:3bf:a624:decb with SMTP id
 adf61e73a8af0-3c8b70cf7d1mr8942238637.27.1785347867320; 
 Wed, 29 Jul 2026 10:57:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [RFC 27/32] net/thunderx: replace deprecated SMP barriers
Date: Wed, 29 Jul 2026 10:54:20 -0700
Message-ID: <20260729175715.165120-28-stephen@networkplumber.org>
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

Redefine the nicvf barrier wrappers as C11 fences and add an IO
variant. The RBDR refill barrier orders descriptor writes in DMA
memory against the doorbell register write, which is device
ordering: use the IO barrier there. The mailbox flag barriers are
genuine inter thread ordering and become release/acquire fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_hw.c   | 3 ++-
 drivers/net/thunderx/base/nicvf_plat.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_hw.c b/drivers/net/thunderx/base/nicvf_hw.c
index 5b1abe2015..d1e31ffdaa 100644
--- a/drivers/net/thunderx/base/nicvf_hw.c
+++ b/drivers/net/thunderx/base/nicvf_hw.c
@@ -499,7 +499,8 @@ nicvf_qset_rbdr_precharge(void *dev, struct nicvf *nic,
 			break;
 		}
 	}
-	nicvf_smp_wmb();
+	/* Descriptors must be visible to the device before the doorbell */
+	nicvf_io_wmb();
 	nicvf_queue_reg_write(nic, NIC_QSET_RBDR_0_1_DOOR, ridx, count);
 	rbdr->tail = nicvf_queue_reg_read(nic,
 				NIC_QSET_RBDR_0_1_TAIL, ridx) >> 3;
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 7d22563035..08ebb0cf62 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -25,8 +25,9 @@
 
 /* barrier */
 #include <rte_atomic.h>
-#define nicvf_smp_wmb() rte_smp_wmb()
+#define nicvf_smp_wmb() rte_atomic_thread_fence(rte_memory_order_release)
 #define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
+#define nicvf_io_wmb() rte_io_wmb()
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

