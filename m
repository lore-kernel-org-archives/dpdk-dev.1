Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFF6C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11FD42E86;
	Thu, 13 Aug 2026 20:05:01 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id BE95A42E8F
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:05:00 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbeeaac53a9so122653a12.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644300;
 x=1787249100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1X3QZdUA3FJove4fTYhV5A2HuZVltk7B7T9g4DKm1jY=;
 b=yrIbWMhpt8zXf44VuwPrPE/Gb+M7VmBpvIMMX4sBPX3AKSyhhf01uSPvrO8xtiSaf0
 vMhB/DYKKJVy8qJpDiB3ZYpGS0wtQnqSGwjvTzdTn26CSFnU8eaMgEyBM3zMtTBdOLKq
 18qHQ9EFwxCxTzyXXuNyqsVr6WK8OfRkw2jYepouYauKfRDEa2VbB+OtlERBnnS6JwRr
 5xdsqMeJwlc4M3BwNEVAp1iQfT2buyQVCbC/pT29rq+PS8yaBBGa1N4vclorLqgzwePb
 ILM78zH4GfUxClDraP8aA07xogttZD93bBkUP7BmZbTvG7KKPrOZwr4xI3/4vNrZ45NA
 fvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644300; x=1787249100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1X3QZdUA3FJove4fTYhV5A2HuZVltk7B7T9g4DKm1jY=;
 b=JBy8pa3ybqnfHcUD/yEgfKRpbmDlAHIKqHOBp2ac3rqPC7zfgPRcmYDYVUSBnndiG7
 Y+NUvBNNGGIIamM6j5JqxJMo1qDfQ7hsq1iZ0kyFU/3ZDHW5bNba+xWS28Jdgxe7q1t4
 Ngcxx0wF0j1tI5UZR7kEQDFTZKj5B7MYS6AVRx/NgEbp2IQ7aZznPvTi+yeFgnutfVCm
 cCdLhQmma/uFI2K4NPcN1T2H4AJkeh777iQgC2iBjJm4tQd8ThJ1q+A8l7KWV41F73FP
 b7VrmBw4WY67yI/Z9gNkX7h5zh6AfBtCoWU/mw9CC11JYomnzJcCQv/k6wHkJGFZWqYe
 RWug==
X-Gm-Message-State: AOJu0Yw8lgWxTyPbqe34W9guRsd+g/3PHNyM13FuZlBzNoNfbvvdB699
 uWHL/t3az2AsQqU/eFjZ9QIAfAybZdVi2GYETPnePKb799qf6A6SOZnwam1qeGafb1Xfhy5s2he
 GA6QA
X-Gm-Gg: AR+sD11tIE5xN7PCjysHNru2aIKeEsjLJigTKnH6X6A8XBSzVL+O59/ZslwMWBbmSD5
 aR2mWlEObYEQvTKcQhFMLIp2AKD+lkgWO0sw5RuWlFtgPo3MunSFcf/ixPnNmpgEh9yH0VcQmwZ
 sk8HPBTu1AGlIw4L+lCfmvd1Fo2QuOkXgru9Ce/v973W6HzCjlyQxpDvejxqXEg/qFU3p/vf4bd
 VzHbHgDu1yzv63eLQ4YWjtoNtbBQie7CcqN2L7k+84rq6XQDzvsQRhEX5Tx+Mp0Fp/dnFRFTzSV
 2Zfzdv8sGWum1RgUmkDp9N4ZjF48+cMuHXCIhMSMBymUF1sikwlollkw/6JnEO6nh27AcqRMs1v
 i9u25DXQVTTD+246pfJhyQlsVDVJk7qsn0yci/TttY6vZGL0ewWRO6A+WZASHRU28kdoaSWOSEC
 LZAol3aXmOny6C9ihWw5RdIWgLPbDlZ7tdfY0FqVa2qd05AQfo3STq3lZ5bsxrjqhzBRGeQH6F4
 iznFXLGXWcwWL+ZAIvuBsJu88M=
X-Received: by 2002:a05:6a21:a342:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cc54f4b5f3mr11192662637.6.1786644299921; 
 Thu, 13 Aug 2026 11:04:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v3 13/16] net/ntnic: fix Tx errors reported as Rx queue errors
Date: Thu, 13 Aug 2026 10:55:12 -0700
Message-ID: <20260813180402.622784-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

q_errors counts received packets dropped, and is reported as the
rx_qN_errors xstat. The Tx loop fills it with the Tx error count and the
Rx loop never sets it, so rx_qN_errors is purely a Tx counter.

Tx errors are already counted in oerrors, so drop the assignment.

Fixes: effa04693274 ("net/ntnic: add statistics")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntnic_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..bee34d20d7 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -209,7 +209,6 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
 			qstats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
-			qstats->q_errors[i] = internals->txq_scg[i].err_pkts;
 		}
 		tx_total += internals->txq_scg[i].tx_pkts;
 		tx_total_b += internals->txq_scg[i].tx_bytes;
-- 
2.53.0

