Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA67F34C78
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4A8D40662;
	Mon, 13 Apr 2026 19:18:46 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 3B04840647
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:45 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso5390635eec.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100724;
 x=1776705524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ1qdAYB4+rqfLrDWp8NPkDvpEdi6D7pd0WAGnH4Yag=;
 b=RZ2apNrIkgWQXOS9/5YS+M/yLsUtEqR7sbWmUoNrUNJnj5Z8IIEny6YPqVbCMnj4d+
 XV6kociPzvf5lYQcFxCVQDAyCHsINoA2o3Z638gkNDBmcp+KuWeAJ5R4F4r89152Tztg
 Kbs6WW5bT+1VyZ/sNrj0eXNeLAILdDALJmwaaT1oSas6uK+Rm1x3VXtfELUPKTT60PIs
 /yDypKk9rCCjmJQzrpnszTUCuWL1GJZ+ilC/wP584WhzeT1CNEkhcsQYMy3L9Qw+iRup
 njD5t5o2GpJHNPbuihAistVGOjGD59gPXNSRJHGAi9Sere5oCJdtNO8vu5y0yQMuuSmW
 K++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100724; x=1776705524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJ1qdAYB4+rqfLrDWp8NPkDvpEdi6D7pd0WAGnH4Yag=;
 b=Hgkh7z61laWBrnc6SjnEI5jR5HuQbXwA05QfGCLzLrm8YZ9Upms7llmiNYTXvb1Y+4
 bPwH23DziZMFGBrdz54kDf6dS5fVgODuyVbBUwE9ZHPJMoBGMx/TvKdmH7IiJmg6cYtO
 nsL3KSA4Ku5Suoj/s001B4x/BxmQSSDAugNA1RT8scEib4eEa2PmM1ajRdRIlk5BfyPE
 Xpy8PkolsjjiTVlY0qI228TQzVc7l5xcITJpHJNhU2M5BLZ/TQSJVoFtGLz7y/77g75j
 LpgMeXR5dBaksC3GsCzQNRU7UI5gGYAx94zSYgl769tg4U7dsQpDM2qbCvOpLwOFFb2L
 4vkQ==
X-Gm-Message-State: AOJu0Yw6FHV1eGuw7rk8s4GuoFzpkcNMnNe7h/wIrKBqDV9Z6YqgUKFg
 RroCT2MPNiQsX8Ox8zl2ynprHdb2eU4TCzXhP8aGCbKnvq8YJ3gTkhLhfV+BM9lcMwMHatixTS/
 q+jp+
X-Gm-Gg: AeBDieupGHM38mjC7Q6PW2HO3VvF0txzxqHyvvv9clRh02vT3KcBhfDSDFGIuXIgygO
 RMoXrhXqbHVdxmE07wjmOaTVzPU+jcaXP0Tox8O4lN5zff3fSR2TWXALx0HZshzOlsrtzdebodk
 J9bxgJQoaoLh95v6LDorzFQCnjZdWIRxZuiALJs6efBYmvXuo0gVEsbH46z2N99BWNrpc4uV1bY
 8rWolaEtP2SK/v+kSU+TS6BJzYFV3ogVb5KOtEiCWW7jjglFs6FBYtBc9hvTVOy7bC5+RglEu1v
 Zs/93rugl5rBHMIIsKds4ttpk2bRKOOUzaq4Dofald089UeZHv6X/sbNXAnFirBtmFDsNOGNnoQ
 GbBlySnRvX2jqlLEaB16J5qaw2pWq2Qfzwl6aA8gqVAjOpnz4+emvVa/2WSXEpFgEwBZLl/0t6K
 8MAd1rGp6+wnFqd9p9oL0CjlTjGeNo4gdPVYvI9gGQtmo=
X-Received: by 2002:a05:7300:5727:b0:2be:171c:5048 with SMTP id
 5a478bee46e88-2d586380990mr7534520eec.5.1776100724298; 
 Mon, 13 Apr 2026 10:18:44 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH 4/6] net/axgbe: fix mutexes for multi-process
Date: Mon, 13 Apr 2026 10:14:48 -0700
Message-ID: <20260413171836.123467-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413171836.123467-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
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

The AXGBE driver supports secondary processes, as shown by the
explicit check in eth_axgbe_dev_init(). The xpcs_mutex, i2c_mutex,
an_mutex, and phy_mutex in axgbe_port are located in dev_private
which is in shared memory accessible by both primary and secondary
processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

Bugzilla ID: 662
Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cfcd880961..4aadf0993e 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -194,6 +194,17 @@ static const struct axgbe_xstats axgbe_xstats_strings[] = {
 #define AMD_PCI_AXGBE_DEVICE_V2A 0x1458
 #define AMD_PCI_AXGBE_DEVICE_V2B 0x1459
 
+static void
+axgbe_init_mutex(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
+
 static const struct rte_pci_id pci_id_axgbe_map[] = {
 	{RTE_PCI_DEVICE(AMD_PCI_VENDOR_ID, AMD_PCI_AXGBE_DEVICE_V2A)},
 	{RTE_PCI_DEVICE(AMD_PCI_VENDOR_ID, AMD_PCI_AXGBE_DEVICE_V2B)},
@@ -2419,10 +2430,10 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 
 	pdata->tx_desc_count = AXGBE_MAX_RING_DESC;
 	pdata->rx_desc_count = AXGBE_MAX_RING_DESC;
-	pthread_mutex_init(&pdata->xpcs_mutex, NULL);
-	pthread_mutex_init(&pdata->i2c_mutex, NULL);
-	pthread_mutex_init(&pdata->an_mutex, NULL);
-	pthread_mutex_init(&pdata->phy_mutex, NULL);
+	axgbe_init_mutex(&pdata->xpcs_mutex);
+	axgbe_init_mutex(&pdata->i2c_mutex);
+	axgbe_init_mutex(&pdata->an_mutex);
+	axgbe_init_mutex(&pdata->phy_mutex);
 
 	ret = pdata->phy_if.phy_init(pdata);
 	if (ret) {
-- 
2.53.0

