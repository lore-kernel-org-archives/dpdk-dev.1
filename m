Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF038C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 061604027E;
	Thu,  6 Aug 2026 18:30:30 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0972C40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:30:29 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so2862459b3a.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786033828;
 x=1786638628; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UZitP8ZSrXdsDJTBZZrW+hlYxGyEHoKGEuICVl6Ye0k=;
 b=pNCWDTMCgSIa5KoU/nRz0giM4rhQzCtu2wHmsw9RgqvFSEwimNSVaanuFB+l/8o5n6
 +nM+JJ5EuU/5KChl4tnEfLE9i4rziu2lIQ85VrgBILzx0gfeN53MRI2X0gbqQj3eYew/
 bUrHDxgITm2EyqhVYIFOmS+W7oLh+DetqHj4gnXVffzNyBY5SGU9x6q3EwFK0kIpjz4n
 PKZoFuUmfJthH4CilwjQSi89MyU9f8C8qtg5Njk5pkQs0OFsUSkXbgzmBdTCkjhwW/QJ
 xISiRrz0TBrkKQHegcoNqm4fUWNyEo85/UdpxEciKE62i+5AGOVOWEDpCn2lURuuBDPI
 IeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033828; x=1786638628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UZitP8ZSrXdsDJTBZZrW+hlYxGyEHoKGEuICVl6Ye0k=;
 b=bTedImibL4fTz8GHnoeHOqjTr52KkvHyyOoav2mbeNXhOQD298zHtYvqDuulYhgSdS
 ZnvDcOWCAFmNjJfxuei1j3i45PmDKrX+782igl084OnU2+FyCRxy4KJzhQjqR+piI/mU
 pFXWUAZBgvl+wFqyD1Dsxozvc0CyCxAr7x90q0iWaFBP5JrK3ZAC27GHttz/L69hpyE7
 +gV8x2x3NbtD8VOdzSwDeRDZxOnt+MyO6sM0FYJEerBbU46bkWYW1lAR1QHw1NUAuSgd
 19fi48ProKk7FBsc1AgLeWhetW8S5Ucw/5mkIpm1HS/jNULXQJm/Fh86DSq7il3AWJsq
 nazw==
X-Gm-Message-State: AOJu0YxUIygJLPW5eyLF1B3HSIMNUi5GeYbiN0+ljhpd1E6S/3eX7Fyy
 D+ciYxA1EL9s3wVk2AxbddFMImq9OU4mnLvSZdQCs++608u79RIQ9Nli7lusv0v5Qp6PbFIXKbe
 IQjZm4+8=
X-Gm-Gg: AR+sD1314+GriPID0yqMb3Mf31cJs8Z+xfya7V0qGD5beOTulcTVmuX32SXT0JgquM9
 g+iJGNJUPMeREz046oVY/Ee/QobjYPJeHGiI4endAanrS6UM08O2L8ujxViQY9IAXiIX085kIR5
 mdocn3Y6uhd29ku5s5eLefkKRXjDVHwi/mAPjM+Hr3tZoQ6Yw8R+/9w4A7TDHnsidvuI5Em5lwM
 V5ayl9u8YX4/L+1/gAIspC0Kcs8AiU5QXdfk8M8o7TfIBOfOvEdIFohK36VbIYHMtfNYRCD1YXV
 hVMjQlh4wItU557c9fy1hKsnrGc6INWIBKl13thpWC0kJuIfoMc7DkrUu00b1EM1zzJ45NDdx3F
 INbmNtPYdnS6h7uP2x1cRYgtiBWHgDrdzzJnOOXuswdzyEmLzmvR33AkvTQ/NWAIeW6hBcNYOzS
 pDlALnD1nYPNx0QeQrk1AOt9mnGww7VoEyoOUTW+pquhzf2fUX5VyZBMRu243lmAOCdONVuXiGy
 Hfb+6BKEA1oyfe/7qmIJwZn4M0=
X-Received: by 2002:a05:6300:8941:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3cb85ded99emr21012470637.10.1786033827874; 
 Thu, 06 Aug 2026 09:30:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm43018259eec.11.2026.08.06.09.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:30:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] MAINTAINERS: remove Apeksha Gupta
Date: Thu,  6 Aug 2026 09:30:23 -0700
Message-ID: <20260806163023.693196-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Mail to apeksha.gupta@nxp.com is bouncing now.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..8376a0347b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -997,7 +997,6 @@ F: doc/guides/nics/features/enetc.ini
 F: doc/guides/nics/features/enetc4.ini
 
 NXP enetfec - EXPERIMENTAL
-M: Apeksha Gupta <apeksha.gupta@nxp.com>
 M: Sachin Saxena <sachin.saxena@nxp.com>
 F: drivers/net/enetfec/
 F: doc/guides/nics/enetfec.rst
-- 
2.53.0

