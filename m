Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD08C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21D51402D8;
	Sun,  2 Aug 2026 20:18:45 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id F2B96400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:39 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2015698a12.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694719;
 x=1786299519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHu9/+XS9gUb+pLpOShhFxQbfBfhkul0wHn8eL99NL4=;
 b=PgH4guLP69/0PIpa648wVJ5Pgw/BcpQk8eetin82bt6cmk/HEqE2MBh/Idvzbd9iip
 feUsXPEYO05d71n3UudvX29Ld02FxK0O2BVp/4BAzhrEq1jPXS25MTl5rDpiS61Xh1/Z
 6Paj663jCXZUlg8zUYMklM1KIhSTkWceE9qLlEtHOmcKKxEyA0WMkrgg/FSJnMTdpGLc
 8LYbc3SjhNjnMiiXj24Is3iR7hhKpB05DJECloabiY+1GgBXQIPxWp4syY8cZHSrguWs
 B4CuSyVfajAX9hDspQwlWjwtw/1rbzwNu5FnkAlRFXG8cezkWkcNR9k+zAXGixo2nYWc
 d2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694719; x=1786299519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uHu9/+XS9gUb+pLpOShhFxQbfBfhkul0wHn8eL99NL4=;
 b=W/QghIsne6kSvjyeZ9Iw3HvCATpL6AS6iNTJXzC4q08B71O1dBqz2TyViWitJELIe6
 6uDM6OSBAERA9YS+enDuYG/5779tHqKYVRzAyMpy5dnwzx21yJa9a9dL/NDM/eX21JI8
 PlNhXHvVR30uDEdlAfcAYHuhIU6joZoJmOU69s1zl+ON9kh5oWfy3P7RZVe8ZQt/DpnV
 TzeMwtuVKjiMGtsiDVYiPhuqgDQhNv1MFqG/GCG/D0RHqj1K0XMh/ndXGhHwh30VHntg
 9Wa+1Mu0xHoG0G2GHcyFVVibmhfhHaC8NGldyjY2Brvh7uOMWpn+NBRYnOiuvT3+ZVR5
 chyA==
X-Gm-Message-State: AOJu0Ywjj3tL2FfxVl8QG9ToCWw3OUljqqHgxwXsezJcMCFDwt9YgnLQ
 sKChhSJSMdauatOY1JMNbm8jt5kuTFMD3ukUt75dnjCzb/MiFu/9j67v2ej5YUAjcYh0cvLo8PT
 dbH6z
X-Gm-Gg: AR+sD10vsE9b77Hu3rzbyM/53ZIKV50ziNyVMWmc7y2EiMpy3dk0aBLifKQIXlMmCAh
 kFxUWgqZmP1YEUveg4G0ipLoETwwH/zVOVvY68h3dRHIXimy7uR6PBrX/of60hCV500U4Em5WuB
 ihdNYAZ/IXuErsl9ZqaTidvyySmGIGo1Z2cfEDI2btQMLEIk/fWNQcFA8mEAzMqBLHlV5tnPsqQ
 EmDeYQwppEOBcV1mz6nSCicGG1oU2k+NRHuR1bynT9C7bgGVr6C0PQh4VpTO5RfflLyTv+LI6/b
 x0+jxE4wQvIYT3hdse39A15rMpXWUUaeS0H6AZ+smjuQGjJ1X77VQemdhFkp/nzhVGHDRQ9t9zb
 6A8A3FVgO5nUWFvpZnbObVsR5hvts9aEhDp9oCqFAPkwu5e1jjg5oZdewnBAGn++Zt7A5sZB/Zj
 KZSlG/gWCgN+YBRbnFFiA2PPE7GdstEVPQmdtWHxZIaY14yAgjqTgMYJfQEWRPaO7+krQKvmqXc
 a/t3icjBsMRHwrcg+CFt+MQWCg=
X-Received: by 2002:a05:6a20:3ca2:b0:3c3:9aff:7a46 with SMTP id
 adf61e73a8af0-3c92a5d35b9mr8169447637.32.1785694718949; 
 Sun, 02 Aug 2026 11:18:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 01/21] net/dpaa, net/dpaa2: remove unused include
Date: Sun,  2 Aug 2026 11:15:06 -0700
Message-ID: <20260802181835.476887-2-stephen@networkplumber.org>
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

rte_eth_ctrl.h is not needed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa/dpaa_ptp.c   | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index e9b332c571..f91d3f9ce3 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -9,7 +9,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..77d5d82b44 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -12,7 +12,6 @@
 
 #include <ethdev_driver.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
-- 
2.53.0

