Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07BC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1E840E0A;
	Wed, 29 Jul 2026 19:57:47 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 70A1F40BA0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:40 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so1258725a91.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347859;
 x=1785952659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=ABjznMJsoNWuAVeqFkCAIxpPAoc7d0TU4oY9CHBWVgeWDeow1IfvXV/FaJvl6zVFjL
 HkIfsaTfi7kjO3YEFpMJqJJyEhn8ui+ezpfUirCzr4f74c+jlmg4DHamb0+0Wf92QDT/
 NXFl6lqFPcjJq60iP0MUw83CnfIkcId1WuuCSeEoJLauwWfgLVWBqcwzsROsoy8lImIt
 rzr+8hH3f0WYcf1go3h+gidnIu1BylRCy8nIJldkOlVzUjDDIXyOjWgcQTlsp2JeocVB
 67bJsDXhZJ+IwomaJNAbm289NJpYOZpZGI7HXe8BKQ+Rsd1SR3zJ+qAaj7uWDsPnpP0k
 +Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347859; x=1785952659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=fb0UgLEDK5FrHzebcvpA/beM1upOHV2VH7Tk24yUc0uL0ZvFbOdG1nal7ctPF5AFVr
 6Km2WfnKsQdQetzevp0+cRf2VN1Skvn4qGGgx/V4LJbvBCo7qsn8IavudrUzZlAqn9W6
 tozleIzGNqbcZnJQKrCFZg4v92RIPrsoAW5LkmG8vWG4q0xQEuJYnQfaAl1+qvU+NdjO
 FtuAfFoimNXZTwxf6MyuEWH7w50QNJDp8fG9FDEUnAZw0CcGcPfXhsCcF7O6d7nWb9q2
 NQwW+pHL9PVK1ZpQS/3bBEUgRSwU96U3xZ4K43zV4IJckhCe8b/gWv31Yvx28NAenYsM
 jWGw==
X-Gm-Message-State: AOJu0YyPhqVFtg6bRF9+wi0W31r+6b0per+FklFxmwSU3cy7AiwQKS35
 wgWzX1CIMV21P7A892Ao/PbucMO/zvakufRYBZyeqrQFwxJPWvc60pUDTC5QpUyDGZ/Lot8GVZw
 gd2Br
X-Gm-Gg: AR+sD12nN1cHGEiIUxMotjAf4M9SHUeOaXJLjI0C7vPB+jE8V4zX5Mg0vcwEkd+KfRO
 WyWi8cHOBijiQl1i5xhfYHIGn/Scsz8OEkr/h1DgG9PtoqoPfGBgjo3Xk5UYZTDsHb8L3ng7Piv
 h6Qq65R61UflZfqXTtzdJzhd/q/XNFxjFUUw5+ekaQmNmZhEGmJh/DN9+wZAsAKQ1MQw23pw6rW
 WYy4LcWJZCiKTdLRUB2ZGDrx2tyUiPhxh74fZy57zWrbEq9ruiLkkEupx3Msntk/zh2Jci0oUlM
 l1yUXttmodw9+ALTd7If+YVYDnQY1Sz8stQuI3vjqviGLc3d52L7GYVKE1KInNByc/WzrRin4ex
 cNTFzVuMB4pqFsO6dg2UpdAtILFf7s+Mfq1snQDfK07jBtr64/8SeD40ukWJDnCCK6aMacIX3sh
 MIDWgf7rigxK9iyDL5hzf1m7rwtAwhcJUuP7qrh6+oKIfMaokJ8jG8Ka47Pnk1i6yjcmCbwYY4w
 h+3ogGrgpgfVIVxlUzMIx503do=
X-Received: by 2002:a17:90b:3cd0:b0:37f:fda5:8d9a with SMTP id
 98e67ed59e1d1-38f6a432efemr7638666a91.25.1785347859513; 
 Wed, 29 Jul 2026 10:57:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [RFC 20/32] crypto/octeontx: use IO barrier before doorbell
Date: Wed, 29 Jul 2026 10:54:13 -0700
Message-ID: <20260729175715.165120-21-stephen@networkplumber.org>
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

The doorbell is written with rte_write64_relaxed(), so the barrier
before it is what orders the queued instructions against the device.
That is device ordering, not SMP ordering: use rte_io_wmb().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/octeontx/otx_cryptodev_hw_access.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
index 3104e6d31e..096dcf8f87 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
+++ b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
@@ -203,8 +203,8 @@ static __rte_always_inline void
 otx_cpt_ring_dbell(struct cpt_instance *instance, uint16_t count)
 {
 	struct cpt_vf *cptvf = (struct cpt_vf *)instance;
-	/* Memory barrier to flush pending writes */
-	rte_smp_wmb();
+	/* Instructions must be visible to the device before the doorbell */
+	rte_io_wmb();
 	otx_cpt_write_vq_doorbell(cptvf, count);
 }
 
-- 
2.53.0

