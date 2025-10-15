Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021ECCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69AAC40662;
	Wed, 15 Oct 2025 20:59:52 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id C578040273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 20:59:50 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-26983b5411aso47879565ad.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760554790;
 x=1761159590; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ECEUeXkFKeZarKFXzj5GiEMFKk9q8In5G8scftzK7cw=;
 b=fuYfp+45l34N63TBXz8Jf/m6UhIdrT3jCOktvsgJrxASOPJJftXzsHNbVkfS/OonPo
 XnYTiQPEM5N5DB6WJYiEVxkT1U/pRjdgwvia80BseoX9GSjvajYjw5Qzozdji0FGmVzk
 +eNV6sliE8IeaYekk4VC/vD2r1cCor9F+GB96KWwal8f9zI0BRm8U7ZKuUrWZwnm6ItB
 HRLP3/6BHncM0zk1URlw0OuIZjCrGdu9w00BjgkJNieqYWIOvB9mHBsAtBEDddQyV8fb
 CxkqrYYhIiX6vYu5+X4D7yDuHUGcuHQd6NVDCpZ19Rnef91nt+u6CTE4ciXyfOwlMUfG
 28Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760554790; x=1761159590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECEUeXkFKeZarKFXzj5GiEMFKk9q8In5G8scftzK7cw=;
 b=as6fZwk8lfDskAG1yZWr8SG4khEgAtoWAcs3C0VooNwIJnkoMZUnweSNjMEgVezCvJ
 XQAd37us3ZwRu+cniQcZLRCDchlKHPG0W65BM1pR2HORMq/X3cXWzAFJGGd9srYtwT02
 XvqArUOPNO+VtTYGrhyaaKbx8B2NGa/gsdMkx0kuEVXjKrNxas4wRMwChBusATvZLmuc
 GsKByjAxAiwEQ2v3EY+djAob+TqMsF+iNvMjlGu39qYX5JIJB0aKUnB7/3az0BW8quFU
 zt5wGrrhSSuRqMQD4hB21WTL1DuyWzNpTrjZ3CR109EEXoS6p9e//hyOiAi7HR582yhi
 K5HA==
X-Gm-Message-State: AOJu0YzjrJ3hzW+j0gylKKvG3OIZbPWu203SYeYlUFKmGey9NHLHFup2
 RgyYUEhTZwPMXbuJCRYHyk0eAsWWuaBZS5bhFXe4WU9SzLRv1WGgZWihsxVlrcpPSV7rKvFh2Cc
 4HxFLcuo=
X-Gm-Gg: ASbGncv8Bb/dDc2SFEZx+Z2l37wcCFH2VBBnrC/JFInMEIRwzyuVcr3dfWugdj6IRP6
 /d/G3P+SsbIQkoq8V4ueRwhXOFA8sqWqY3y//xNW7O43Tf/N4RCu4IKt0lHt6GQ0SoMNE7nqTP+
 bK89IHZjrLElwQhz7KC8PBIxpfM/Hq1tjAWKmzv4+qU5F6NEvXkuXOK9uYXJ06vgIrZfLlV7Z64
 8gcFnAjVgNeL4O5yOZVp+g/x61dikAOiVJ+rCIewy1Pfbc4JdCdw/ijfC85DkaUXr0VCx6HAOlZ
 2kRhHJHi7Yced2qBo3YiE/yRExisikR2Dc+wO5NtlSRTJH4XNPuSTd1uFetCISLgB9bEx3UV8F1
 MHb+fhXuGW7JivToOwmeAxhjXFYmHiV4onUmfRjXdhpOOxq1kqiyHGgqU17ueaPrhkFlTZhp0A0
 XHIT6jIo8MOxPa8YY=
X-Google-Smtp-Source: AGHT+IF5pUL/8hYl2uQ4LcBlxepsEyTv8UdWGn041QFtvu7eGzC7t0DBRbNWcbzYHv6ULgsTtT8QUg==
X-Received: by 2002:a17:903:1b6f:b0:275:c1e7:c7f with SMTP id
 d9443c01a7336-290273ef12bmr395958265ad.34.1760554789506; 
 Wed, 15 Oct 2025 11:59:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099372c4fsm3905795ad.43.2025.10.15.11.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:59:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, pbhagavatula@marvell.com,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] dmadev: replace zero length array
Date: Wed, 15 Oct 2025 11:59:46 -0700
Message-ID: <20251015185946.338417-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

Use of zero length arrays is Gcc extension.
Found by zero_length_array.cocci.

Fixes: 9674119fbf27 ("dmadev: add enqueue/dequeue operations")
Cc: pbhagavatula@marvell.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/dmadev/rte_dmadev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 30e168825e..8ae9ee031b 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -856,7 +856,7 @@ struct rte_dma_op {
 	/** Number of destination segments. */
 	uint16_t nb_dst;
 	/** Source and destination segments. */
-	struct rte_dma_sge src_dst_seg[0];
+	struct rte_dma_sge src_dst_seg[];
 };
 
 #ifdef __cplusplus
-- 
2.47.3

