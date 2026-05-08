Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF4CCD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 19:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C6840666;
	Fri,  8 May 2026 21:11:17 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id A039840653
 for <dev@dpdk.org>; Fri,  8 May 2026 21:11:15 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12e332315a8so3439567c88.0
 for <dev@dpdk.org>; Fri, 08 May 2026 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778267475;
 x=1778872275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZO0wdDD4DSlLX4n4DMIO1bIJmiM8zT5Jy8kQ1B0lsk=;
 b=QwSmWU7djelRdnLYYJr0LsPuUVcq+jT1UHkDXSD0YYwBD1AZIrQZ7z6gL8wsXNwsWA
 fznOcZIVVqpNrrIpe2kfDQoLc0qB8vQXxkCLII0FLbBcp77XHwm7GvFoI6W0bnfVEuy3
 FByo8hTJ4K2HZAvmdtJnmjfwVZ2Ea8NzNjOHP8e/dt48N5LrO8t2iGdSozEFA+tpna7v
 nr4RqHzmkuP+1L/BhXWe1CkBDgx8y6whd45Jd/kWJe1ZynVqCPHSvvuO6D5bUIsx/1qk
 PNuIt2f0n7pCMaoy5F/EPuz2K/sXd8AqW/01iU7+L4jpZkCkjSlmTwnPIMJNNm5/AKKQ
 eg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267475; x=1778872275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nZO0wdDD4DSlLX4n4DMIO1bIJmiM8zT5Jy8kQ1B0lsk=;
 b=G4VRRs4HqLLSxaVrYgVyLL8yhGKSZNudTBv5Kr4gUbnZpLG1QyHv1KtC0qsrIP2y05
 6MMe+S0Uq0iHKxyUY7HsZds5wFTcorPAIh+/rf8z5SjXy/5DAt12dH8xsZuABfIbOJqe
 tfx2DfQXjt3We2+h+yFa47apyrcFMpsny/7zetsLWw58+Kk8BAzEMpN2LqhjCqJkETbZ
 WyQSwIpxmKWb/lO3uaWfSfwBJG2YU8LuB3myKtc5kJ1X2KfqytEvhfhf/XQPMhcMEIlL
 4P5HatEdlE8EhGSeR6PofkxTP3K7cNZGi3/L6wmADqpJvrIlPtaH3bryPOvwFCxQOhAv
 WChA==
X-Gm-Message-State: AOJu0YwEwto4mCDxT2IQQxp9WdbYhZyGbrnxQSbCkVXrBkqdKQ68GmDW
 ToNYh1i+LegcYI7GCNGc9efNx4cve2ERdpbMC6l+43/ur1HRN8PJZ+WyOThLO+EKITTAXA1yN97
 n3sA/
X-Gm-Gg: AeBDietszX4opZmLr3hEb+vezEKABbdH60uEM1vmVAWmCJv3OkORp+vw5L+VDJFuYRw
 AgLEYAsTl7buuLzQhaNKVwWZXtuJS61cQCXaHsnACQAnYlqj6D3Tkxe8jJgssxEsvZfyYzbc3N8
 xPEzL+/7MUj9/mquvYKiQpqhw5YQmtbUXgezKUlL9XW8fWt3WvxeDXEF7q/HK5UXAd5nvM/m5WV
 d/0uHWOureFvcEN+2S+jY7NvN+9U8F465rdKirEkdbzTp+ollZDbYnZsy8bF78MfGuZGjoXUHNX
 7fC8+NVQetvkEMK+ENyLByrhvwS8pRPXBSecjJcVKvM9m9a37YZdPuoYU2DsJ7B/q4ZAzzH2wBk
 4OrCxZcsga7TOTm1IpUqFDVp3qgz+Yjl1vZJgg2q5I3lARgyVmm9MlnlKKiy1CU5j2b4r29PNGP
 sYjm+g+ZTxZTXJpH2ypZRwpAHI1ZCi3EEp
X-Received: by 2002:a05:7022:2512:b0:130:ab68:2b72 with SMTP id
 a92af1059eb24-131851c384amr7716733c88.11.1778267474585; 
 Fri, 08 May 2026 12:11:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1329fc4bf3fsm212796c88.5.2026.05.08.12.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:11:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v2 3/4] net/axgbe: destroy mutexes on device close
Date: Fri,  8 May 2026 12:10:51 -0700
Message-ID: <20260508191109.734377-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508191109.734377-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260508191109.734377-1-stephen@networkplumber.org>
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

Four pthread mutexes (xpcs_mutex, i2c_mutex, an_mutex, phy_mutex)
are initialized in eth_axgbe_dev_init() but never destroyed in
axgbe_dev_close(). This leaks kernel resources on every device
close/reopen cycle.

Add pthread_mutex_destroy() calls to the close path.

Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 709a52acc8..c8414998b4 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2482,6 +2482,11 @@ axgbe_dev_close(struct rte_eth_dev *eth_dev)
 	/* Disable all interrupts in the hardware */
 	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
 
+	pthread_mutex_destroy(&pdata->xpcs_mutex);
+	pthread_mutex_destroy(&pdata->i2c_mutex);
+	pthread_mutex_destroy(&pdata->an_mutex);
+	pthread_mutex_destroy(&pdata->phy_mutex);
+
 	return 0;
 }
 
-- 
2.53.0

