Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A05CD37BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 20:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 219CE40A67;
	Wed, 12 Nov 2025 21:05:19 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 7C6E840151
 for <dev@dpdk.org>; Wed, 12 Nov 2025 21:05:17 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3438d4ae152so53750a91.1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762977917;
 x=1763582717; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqC3Xa3WsiWeLIszr+kHOKn+PiFfF7vlH8kQC8P7yBc=;
 b=uQeb3TUToJ+HfYX/iNCsuk/qaUTSQaxzgFOHPiG8/Hpcj+QBSkw+FERsZbt0b7W3R0
 rUNOYXWdiQ7s3TDFjs0A9Lmkt6mFT085ip2OVkg1FOXr0ILZk/4EpWlvENxfgH7mNm9i
 9vQpQTJpKWe6ylLHPtO9pNmfQnIatoABPy3fV1p7a+GU/OjesAvso+unwzCDG41DHo3a
 dp+NirZx3w4QjI6Ir4vgOjo8gR47VCwbz8rIR71asRkh6+e8hRFUxtqh5ThVOw0GdEWH
 gCHINPnby9qY2l1kFnWp0udccWlW03fuyK/jMQFZU6zEocbuVpWGnDaMrd8GiJ1WTiCt
 GeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977917; x=1763582717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WqC3Xa3WsiWeLIszr+kHOKn+PiFfF7vlH8kQC8P7yBc=;
 b=EU50BZoAhbR8V6KrHiULiOlIEPv1dQr4GEgsnJIFb/ttxxvT4RH2/a5e8L6AfSCjbb
 1b8kcBi+NFLmlsoDJBaHGdkKFoEX09eHuNpricXSSZxJwFTRQpc5Ffoa1W2Oh+Kbah2B
 jDyDGlPGsarr4OaeeVfvat1sBpofv7XJPVMaVxEUC8Na65uF6y3w0utZTmqFSGCcDjLY
 eDLSdHbY3km7U6kXX5qc6t1pkcxG+L6ddaATwZ23+cTRSLxhNit6hQmT1/xaectTLkOc
 gCgFSs0AHdDbZ0WXgtKhm762fScaEWuqO7lgV2wzSDFBhcYLYVyXj/9BCTxiq3TXb6jY
 bsgA==
X-Gm-Message-State: AOJu0YwzJppqSFsQ9ulyuRwnLq+fmuoZhqYvHx2X+D7HDiuF5DyVSBFC
 hzwp1d/b/mkez+Zu1CXCsNb5bB6TqcBaL1aZbGJjvV2Z5bzzjwP1fy/FAHjD07U/qmEw0lLPTqa
 fmntg
X-Gm-Gg: ASbGncsHxj4RTMQ3DH5/VhUk/2ffGG5bBZ7RwBAF/Y/ksYjftG32ZEolb2KU/Sctlul
 Z9VHTMCZ6LQ3X5rIvPIqu2y85+zxafms3/FhYWIZ1KkTBgVbK7Kyxf5inSsAkh5viGtpnZ/DTcX
 1/++7dvgo0AMjiA68HXHFu3n1NK/WqABN+p6KYx2I3rFy9m7dB+oFUijuqlHkqo5a4AWBFUgj/I
 m1LChaaGm7gCyjZ9lTaHQqBprhfShaSt610wH2TDyeIeCJzNV0zQYCrA6dResmwRWXUAQFz0rwl
 xVPeGFwg+MuVKN3t0Ztn3lSEXztqFHYLA+kl+1hdiFxCJk+ewYuyJQXiDT75qHQBsnbCXinNT3e
 y8/ncCEE/RAL7ID9DzuMcSEp0v4A1RaTTPnlH5sQEwPPgmsXC8XI4ODDCOU9yStdLdl+LHzgoC1
 OybgMiUjkyD2pf8f+nd+EtrAVOxWjlqVQOK2TmBY8=
X-Google-Smtp-Source: AGHT+IGeLyFpuzyJmnrbERKoS9s1G7JLDR1YIuKcURF/vFO9W/pqPhzicFPkaRZnF1Et9hBjJOqrHg==
X-Received: by 2002:a17:90b:4c07:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-343dddc6ee8mr4877630a91.5.1762977916668; 
 Wed, 12 Nov 2025 12:05:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e0714121sm3528929a91.5.2025.11.12.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:05:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH 2/2] pdump: fix race in pdump disabling
Date: Wed, 12 Nov 2025 12:05:10 -0800
Message-ID: <20251112200510.332651-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112200510.332651-1-stephen@networkplumber.org>
References: <20251112200510.332651-1-stephen@networkplumber.org>
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

There is a race where the request to disable pdump may get ahead
of the handling of pdump requests in dumpcap. The fix is to do
local removal of callbacks before forwarding same to secondary.

To reproduce:
   1. Start testpmd and start traffic
   2. Start dumpcap to capture
   3. Interrupt dumpcap with ^C

Testpmd will show missing response and dumpcap will show error:
EAL: Cannot find action: mp_pdump

Only reproducible if additional logging not enabled.

Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index c3d0ffa779..ac94efe7ff 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -576,12 +576,12 @@ __pdump_request(void *param)
 	PDUMP_LOG_LINE(DEBUG, "primary pdump %s", pdump_opname(req->op));
 
 	ret = set_pdump_rxtx_cbs(req);
-	ret = pdump_send_response(req, ret, bundle->peer);
 
 	/* Primary process is responsible for broadcasting request to all secondaries */
 	if (ret == 0)
 		pdump_request_to_secondary(req);
 
+	pdump_send_response(req, ret, bundle->peer);
 	free(bundle);
 }
 
-- 
2.51.0

