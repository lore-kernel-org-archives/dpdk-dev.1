Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8894EF436BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA21D4065E;
	Fri, 17 Apr 2026 18:55:36 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 9DC51402B0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:55:35 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso802355eec.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776444934;
 x=1777049734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1n7ps/X2Zw37tWF2A2PrPWFHttfEhH7cQ0x+uskDYiw=;
 b=aKqI7SJLerNlumscMGizfoW8Ozgfwov1V8KVn0MzklNswxmTZ8IeJmMMmKuKXSf7sm
 FOCyWRlfu0hnvpQIRXuboZIhjH6a/jtY8+e3JgrT1RWn7xBLG5fEv1cdBmYcEn+O1k7X
 YHL/stfZEctBIzhrtUSKFo/At6TjismqZNeikr1kToYvPs2sulJ5+1CxojDv5Wp4MiQM
 HdP9OVxKAo/KzWJ8Jpxm/D5iAG6VbuhzqLQw0eAEN/hJGwLjBVUzbsld/xBssESZty/f
 lFcmm7KZ1jycWwdJVdIFMrmhoPvsqSe/n5lwBs7MLgLBbef8wmcvke0Q0P1r91ptoRHy
 9j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444934; x=1777049734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1n7ps/X2Zw37tWF2A2PrPWFHttfEhH7cQ0x+uskDYiw=;
 b=IqYEyCk9XgW8tDw1sDn40SynD4C/s927H/jxLWoa0H0JJ15eCqKNaAFd8oelHJAmc5
 i3UHT9q1OC+PNY+PBiW+ZPQDB8nx+eVLTiJbOb4Bck+J6NOvalmLOBU9VKqKKthTpdrt
 MtVyUvYckJWkx9oFCLVhIFo2k+6o5FEboVlnrmKfb8/vkYxprteHpHng6AxWdiKv68XV
 zqJQ7wU1+9dyzXzSvtXVwQttyE+MYxbFtF9uZF3xJj/s110DviUeYt/Wc2wkIAUsm8EX
 7onxdogheOMcAvA7lYj39eI5wC0puE+XOZ5OUaZEV97tg2cM64j5pVSVxV3ap78ZmMID
 bM6Q==
X-Gm-Message-State: AOJu0Yz8u9ycRvj2USqB5ann+TuIdNIUn9QInzZbh+ADOOWGr5ES+ePa
 cd3SQFVQIHg8CvIVZnjBAFrDAwLTEtOyRqU2hgKtUC8lhU6fafGo1dzevFzLXeGNK7mrKIdO8MY
 4Z4JE
X-Gm-Gg: AeBDietKRzZvKixMoibNU4HISo7O5fB1rN1uS8rgAFFK3JWkmse2N2hYMxnkuUzbp6H
 Iml2k/4HF6ao7SU2LXzuBhEST1piwi6L/U0gqhFdI9dSpqFXRnWVbQhGABo6KljdeVuJeZYv503
 aJNhauploALlH8XrjaOC41CUk96hUQjH489Q7VHt8pl5iwiShdlWZThK7AxCJusb5LLzHCmFS/D
 ovWfJueiKebnVgraEiVctfQA3UH1ze7TZ+Z2zNaPhyuugQTYv7XcXcrNTxi2tPo8VELWNjsRrii
 n10K0NJmemQFJ83OUisHwGBw9jJ/3PUm7wHPWN03K375qukHOVdqN/zeBtbFYpRIpwgxT/bnGn8
 LRslCFr0GNmVb9eLu08JV9gRnC8bl4dR8lCdxmbxA8Utq7aYI7iMtvuBgLpY9ZfChcEalEH5Gqk
 dLKzvo8pXz0K8pxXFgo8H71Bh1Ll8LgcyLpTcI8wvdvNo=
X-Received: by 2002:a05:7301:2f95:b0:2d8:43f9:532e with SMTP id
 5a478bee46e88-2e43c62c904mr1723623eec.20.1776444934521; 
 Fri, 17 Apr 2026 09:55:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm2891264eec.3.2026.04.17.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:55:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Tomasz Kulasek <tomaszx.kulasek@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH 1/3] net/bonding: restore dedicated queue state on mode set
 error
Date: Fri, 17 Apr 2026 09:51:35 -0700
Message-ID: <20260417165530.653328-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417165530.653328-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
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

The calls to enable and disable dedicated queues are missing
proper error handling. If setting bonding mode fails,
restore original state and propagate the error return value.

Fixes: 112891cd27e5 ("net/bonding: add dedicated HW queues for LACP control")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index ba88f6d261..a74b0059ac 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1727,7 +1727,7 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
 int
 rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
-	int retval = 0;
+	int ret;
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
@@ -1744,17 +1744,20 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	if (dev->data->dev_started)
 		return -1;
 
+	uint8_t old = internals->mode4.dedicated_queues.enabled;
 	internals->mode4.dedicated_queues.enabled = 1;
+	ret = bond_ethdev_mode_set(dev, internals->mode);
+	if (ret != 0)
+		internals->mode4.dedicated_queues.enabled = old;
 
-	bond_ethdev_mode_set(dev, internals->mode);
-	return retval;
+	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable)
 int
 rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
-	int retval = 0;
+	int ret;
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
@@ -1768,9 +1771,11 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 	if (dev->data->dev_started)
 		return -1;
 
+	uint8_t old = internals->mode4.dedicated_queues.enabled;
 	internals->mode4.dedicated_queues.enabled = 0;
+	ret = bond_ethdev_mode_set(dev, internals->mode);
+	if (ret != 0)
+		internals->mode4.dedicated_queues.enabled = old;
 
-	bond_ethdev_mode_set(dev, internals->mode);
-
-	return retval;
+	return ret;
 }
-- 
2.53.0

