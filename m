Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507DC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A49D42DE4;
	Thu, 13 Aug 2026 19:22:52 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id AAF9242DD4
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:50 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso2246075ad.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641770; x=1787246570; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1oBnjJS3OSYd3PNsBnR5Py/hw/VzPOmrlA+LkyiIvSE=;
 b=cDrEHqI/ed9OHuocO1yi5ucPpng3ZXDzrB1sQXJdsHjkEsW1yhCHJdilqmNz0v986o
 ZbBrDwVZKBM/ayBJKFxn6BHZ0Gtopb2PMS6J/QWnJuC8U+OmUCPqvWD0zpqmlFwj2KYQ
 O90JIg5yYTnEy8f785cCd9TQ55vCFlvxDfHIlvt2VwUx/647+sVq0dZg+WfN2GOhMlA0
 S9r5dsGYaactsbJLD7dtYHjqgfd0eVF7FKihGl/crPRgS+ow3OKGxdea3pOpMT5i+d1g
 yGmJ2u39h1zz+RD+hz4essKTSw6vyGEMCsV9t5B+9Ob2Dtze8zuBFUNdKxOA5NFRq25p
 yaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641770; x=1787246570;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oBnjJS3OSYd3PNsBnR5Py/hw/VzPOmrlA+LkyiIvSE=;
 b=QthjOGx1b/cRNA4SzIRAlMI9dR9e0h/h0ChZs+fQWW/lD8nfURZSZBpinBClWmIh4c
 hcGAFZc9KzhCIucJKgnvaOT+o13gFrjcxCvIpvo35bFgQ2zvG4cT0Oz8+yUw7mtj2Kl6
 fbAxQeloev30/CKm7+yMPX008PP3VnZG41Sd1aI992jFeiPARoK6s04PQSvvMpBXeoG0
 A9E8w/sS3OSfrfyjo9CnZQ/K6WhTjP7jVIjMziEBM/kmMxUDe0U1/aEpmzRUDIUzHoFE
 9OKWCkqum1XQu93MnTk//MGak+LGRaQO9R6YEyvkvTQSQyqaXupUIIUc2YEULYT4Et7v
 oYSw==
X-Gm-Message-State: AOJu0YyRg1Q++OtF3Y+RNXg2y+/SAcHj0voxOtjPrNvBHKiMaK9RWxC/
 bu87qcAc24txPiVWUlDjAh2MUeKeh6SP/SoGdgyrb8QMiVoPSHrC8Smh0PHGNlG3SBpjQpeGk6n
 ciONF+lIrSpjfxw==
X-Received: from plmp23.prod.google.com ([2002:a17:903:f17:b0:2d0:1fb4:d72e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1103:b0:2cf:4c0f:5127 with SMTP id
 d9443c01a7336-2d37d885fc2mr81827815ad.10.1786641769453; 
 Thu, 13 Aug 2026 10:22:49 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:28 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-4-joshwash@google.com>
Subject: [PATCH v2 03/14] net/idpf: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/intel/idpf/base/idpf_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 67bc33f2e6..64bbd00eea 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -291,13 +291,12 @@ idpf_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define idpf_usec_delay(x) rte_delay_us(x)
 #define idpf_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #ifndef IDPF_DBG_TRACE
 #define IDPF_DBG_TRACE	  BIT_ULL(0)
-- 
2.55.0.691.gc56d675ccc-goog

