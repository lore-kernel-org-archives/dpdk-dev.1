Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68CC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB9740E39;
	Sun, 20 Sep 2026 20:14:25 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id D6C3340E5E
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:17 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2071442a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928057;
 x=1790532857; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=w+4zWyjsRP6Y0DtSJhjtx32JoT1r59DQdHVjdl93um+Ihj1qAZM7sX8yPmlOH9rtfb
 LzA0PmrRZqdY16ITvx5lc97EPzLFXKBRGhgSs/zS8Ytn38o8nlLR5G9iR/k4Tjh17IuJ
 ZkM9UAqlU+b/Op/aa/gsKkTwhTV+JjUwIyVgyO9OHj5aKFHIwkuIkVJqIvGQBdH9UMb/
 rn8g1OyoebKtbSy64y7nYA9mZj2MlPRnOQyf8gMgoI8oQYPbdK+WCSonc0D5GraMZeMo
 Pd8feL2cEJwBpk+5OMQ6xk+vIwOh/Cqt5wEzmhfnRn8/FVR66dVptuGO0HQRNYcD/oft
 Mafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928057; x=1790532857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AutbEqXNQU9LPX5AmSCbzwCNp+NpT+lVDpgLHM8sOzo=;
 b=dUYUxJvqWWLy95h86sQ7ietPtzC7Fdc75WSPhfueD6svqnvfIiAYoCdxlEFejVoEdg
 uZQHzVCRb109yEhZ1KzkLxjiCioWwdYtBMcUA8qovt1BGp+bbWIS+2rDBK499KnyxULK
 J2C51f9uq9Vt/CErRBNgFQRo6GuVVy+ulIwQGF24W/Uwaru41QmiZIalyHGz5Xre1+J7
 FMlc3ax9euzDr2MDGLmkFfgwdaYrWEaeSv4vNt/3n+KR/xG3iTW8R28D9zfLCGJ9Ql5a
 Xcy1/GZ8YhLDqot4UzwgzeJWRXrYVQiK4xxkNI+KaMitLjJ6lQddiSpiBtEZrhuM4ogW
 0BBw==
X-Gm-Message-State: AFuF++mw04a2lFjNvwpwD4zE6Wiapf8n9py7GG7NMqchrAEiBmbKO4wl
 q6ZhXazIcvzdaidZWu/nVrosOfgusODN024BmN+pjJNZ2DxebRwPINKTo+TsHUagqc+kRyg4iz3
 ZvMrw
X-Gm-Gg: AYBFou23pUfTU4FORCwWbf3t+CY/QoDRRHsUnJVSJ/5i8WD1Scs+x0XuCMlbtYX7EQL
 HcwR5xTPKikh9OtEDqv0dexhFvIqkYr1R/2K82HjUc5fxWw3NZJovHMIZIvK2icX44ub2Swm+s4
 jlv+FGMDnlQwI4nxnR/FBj1WcntfQTlXijl4DaJ4r4xOcf/J96h4NlxEbfCvUMG1p+m1wv33Mtr
 emEXp3FSYh0RHm/Ok12uuFUHjdhnTj8US9HaET+T3sLVTLPwky2XQMm4S03EaWaunQg/umFaFsV
 zEuSp2gpn+az2Iyt34ZArpRBuKXkXwCejGUJ55otor2klinmcG9D02O9B4dAVx064jTK6YNBHun
 KpcqfN5IGNjDCcppE74Wr2SROqBzRtjXOuiq8yI9GorI5ttC+sbpAS9Qd3Tu054vWnFmWckr8Zd
 7fBEhQzgojJ8pX0iPcyFPGpjhG/QW8Urzm51eysUd2JGXiVf+0EdSjNAqQfGjXnlp2WyThq0/gv
 yHcj72uZMX41FJZowMCcADkW562oXzQsfKh3a5EaGgQcwUp
X-Received: by 2002:a17:90b:4ac6:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39e54c01efemr13684424a91.14.1789928056918; 
 Sun, 20 Sep 2026 11:14:16 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 22/33] mempool/octeontx: use IO barrier in pool destroy
Date: Sun, 20 Sep 2026 11:10:14 -0700
Message-ID: <20260920181347.747210-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The barrier flushes outstanding writes to the FPA pool before the
teardown mailbox sequence. That is ordering against the device, so
use rte_io_wmb(). Control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/mempool/octeontx/octeontx_fpavf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/octeontx/octeontx_fpavf.c b/drivers/mempool/octeontx/octeontx_fpavf.c
index 6cd0fc057f..7051422cb7 100644
--- a/drivers/mempool/octeontx/octeontx_fpavf.c
+++ b/drivers/mempool/octeontx/octeontx_fpavf.c
@@ -616,8 +616,8 @@ octeontx_fpa_bufpool_destroy(uintptr_t handle, int node_id)
 
 	RTE_SET_USED(node_id);
 
-	/* Wait for all outstanding writes to be committed */
-	rte_smp_wmb();
+	/* Make outstanding pool writes visible to the device */
+	rte_io_wmb();
 
 	if (unlikely(!octeontx_fpa_handle_valid(handle)))
 		return -EINVAL;
-- 
2.53.0

