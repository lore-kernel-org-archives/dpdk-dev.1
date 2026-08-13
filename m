Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB22C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2A6427DF;
	Thu, 13 Aug 2026 19:22:50 +0200 (CEST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mails.dpdk.org (Postfix) with ESMTP id 7037642D89
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:48 +0200 (CEST)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84f0d3ab2f4so784723b3a.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641767; x=1787246567; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QVlPsn1yfH3l/b2bu2thGOQ8AFjjqA4BapLmUKvZv74=;
 b=OBRfpxM1H1rocSh8GFdqF6k1tpcb8j+2wWt1sKudPq1hypL8xPRw8gRMxTeqiokm1K
 ybWa/5RN2MDCqRkkOVIwQ18onm41N87LyYO/VTt4jqclTgyWqiSlhVRnbaKvlJAWyyuD
 tpbF0N5BVJFhljYznUd0Pffj1RwiOwd3dJYtAEKkEty8WHmsCULfnDUTcH83qlC6GO1D
 EijyQy/c/LiIwyfLha+RiGvVhGEzdw78jckbWJdB8Auwm0v2ybuWPYn+WBqZjP/pWx0J
 oLAhw+jNyqpIZNeDKfv85KN1/OnjHR9JIz21C4L4WcYnvK7v9jlRyPM68Zic9iMSo0/X
 4RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641767; x=1787246567;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QVlPsn1yfH3l/b2bu2thGOQ8AFjjqA4BapLmUKvZv74=;
 b=E+ZKYFw1bLI2LdDViuQYz3AG2g4+bnNAKfn8BvizDMt/gawl7Ka2VilC67cOr/W5ym
 6aZarlEgaWqBmcbOw73sRp4Gt5BYqU2Kd8C5xt58b34WK4YVqatMZNhD1MBBJsdD1x0p
 RpP0KNMMnfnveNmNNfFAZFyYQ/atQ4PNQISasAUKfTdl6Kfy/1TpWP7PaATDwjbbcI7c
 0fiqRNo9kVbn7YuOvMW6AkYi+Ko5iHtVnLN8LXVABK4Fjgk1kTtvPECT2S7NdSVR+7ZD
 LkRSCa4zrNSgzbzXfo0moHohHDYUj4AC8eKsMrYnZbqY640JUZZZsbk3RsrzstEP9zxn
 gTWA==
X-Gm-Message-State: AOJu0YxMQGfxJXndiQO7ZVneTVb+W4AWTHT2VogPVCNU7k/mnwZa5oXZ
 5edFxwcfWTsXE/SSgZEjICEs8YXM1uAculo5r4jJ82UOpe13flYzZ1J7Se+ikIQy08pmbJR/Jtp
 i9kfTWTfIx8XFcg==
X-Received: from pfux38.prod.google.com ([2002:a05:6a00:be6:b0:847:878f:44f0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:930c:0:b0:84c:4b58:2cec with SMTP id
 d2e1a72fcca58-84fc6d32a03mr8656208b3a.15.1786641767368; 
 Thu, 13 Aug 2026 10:22:47 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:27 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-3-joshwash@google.com>
Subject: [PATCH v2 02/14] net/i40e: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Bruce Richardson <bruce.richardson@intel.com>
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
 drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
index 9c5a94f055..93620f5c50 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/base/i40e_osdep.h
@@ -227,12 +227,11 @@ struct i40e_spinlock {
 #define i40e_memset(a, b, c, d) memset((a), (b), (c))
 #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us_sleep(x)
 #define i40e_usec_delay(x) DELAY(x)
 #define i40e_msec_delay(x) DELAY(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000*(x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #endif /* _I40E_OSDEP_H_ */
-- 
2.55.0.691.gc56d675ccc-goog

