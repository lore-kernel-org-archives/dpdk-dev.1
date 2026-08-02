Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C305C55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8278D40A89;
	Sun,  2 Aug 2026 20:19:02 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0631B406B6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:54 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1574025a12.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694733;
 x=1786299533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGY2+BCkCA7XjN3Rv4/CzLgDDTHPtCO3usOiboSchw8=;
 b=E2p/y/ilk/f26T7kSrMGh6U1QGWHbTfc8vviVivXAJyTcS9PNFEXL/IP2ZQlaTGUmS
 HI+C0eKuUISHcEmTgmgcX+RTfxsDAGUzR2pPLOa5DfXz/TdAtLP98Dp0vEpGwTlm0r3y
 BbgpDC3U0eQakMeohM5oWEWpIuFfqb6/KMm806T1Ol2E8Ob9+GVKnMUNjLWS1Zr4cMWF
 wxb2vAB/LABb4xHqnFXIRdmfm4C3dtsgZix/Fs1ZkvjrCYG5u5YQbTsbWAtYb4rarJQZ
 p4Gsw98jf7jeoUBHk5mw03XJChdlkhiwnW0KCk4uOg+AOAnl6ss08v/gMm1c3Wq9kfCs
 au5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694733; x=1786299533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGY2+BCkCA7XjN3Rv4/CzLgDDTHPtCO3usOiboSchw8=;
 b=L4410YwvfNL+iBSZZT24ih5sT+SHs0xaOh3IPwLDWHER2mAWp+dzeez4SFPnz/lC2X
 PIqcWv9CVLIov1cBYnb3+bCpGZDtwTC9OIc59/FadKwYXNho+g/TE5AY/KFNWxBrA2lH
 +QMgavkWN8ISDLNw55bcWaJVWXlyiQyU3KgETwLBkCnqBFAl5UcU1olvhxuQze/0yxbV
 IZhZ+bAA4DgSpMaVV7QGs6xxnafXsn9gYpifGRhJ/2y4DVP8Gp0Ktbq4BPKULzwtCVfG
 N6Qv7UK0ptNJM7CmRVmjbxslVVBK75LU1vYzo1ioia09FkMuI2OnmvWHQ0NzfxjlK6HP
 m2tw==
X-Gm-Message-State: AOJu0YxW/NdXGWCFDIzblbXBZ3rO4sDW7VMYemIWU3FmnRjBs0kc832B
 OY3uxK2G+uTiyi6SuzQmG2b4sSTKryDekxKtM6/dadqnRLv8ATzTvXQRth7Z6li5ZvzaR/nU7vv
 EemRL
X-Gm-Gg: AR+sD13grY1o3IqYLI1Kd3Mc9/4ilxH2CaCWBykgkSIu4uCj1GbRN+O6w4P4OqIIx2k
 4C7UIT7V0epeRc5h/VNvCjYT18BZ6gwA3sOAJiOxyPLQOj5fQZp14qwpuahfhiN2+y7Y7gPhVgE
 nzWPDhfgAzwX+hDNsGpkgJ5IgvX6/SetXqFbzoF1Jm1NqT3JsjQs8WZp3yJcpTuBM8kmDispDcH
 yQg6x1OvtTRaOrk8DxpRi3MbhnM6ibgH95YNiAiWSy6/+Tnii6BpFluPHulM31ZBy7a+I74PZm+
 /w666X3rOQeg3lk/+HfTPFqfBNxTFlvDDRh7TYOayzpourHJWKdMuXHQXXonsJp0d/NOFu/oI6G
 inLJlO1gGglB14KYthFa6a1plHdViOL3Vs5uRRZpHOxHNhuHSyu8ggvUBcL2cKvPHupmb3PBWrF
 QWlq4lDPrHlUKG+1M5iqafNga4Opk5vPZngg3nfcwnKW8rccJoCkXaXf5kOEQd3PmabltJKtCFM
 lx8+bOBhhCqq6iCECzNxUhSup65+QGnfc2LlA==
X-Received: by 2002:a05:6a21:9cca:b0:3bf:6c08:fba7 with SMTP id
 adf61e73a8af0-3c92a84ec9amr7034779637.59.1785694733221; 
 Sun, 02 Aug 2026 11:18:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [RFC 14/21] net/r8169: get network headers
Date: Sun,  2 Aug 2026 11:15:19 -0700
Message-ID: <20260802181835.476887-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This driver was getting network protocol headers indirectly
via rte_ethdev.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/r8169/r8169_rxtx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 00de0471f4..b84d451bb3 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -20,6 +20,9 @@
 #include <rte_memory.h>
 #include <rte_malloc.h>
 #include <dev_driver.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include "r8169_ethdev.h"
 #include "r8169_hw.h"
-- 
2.53.0

