Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A1CD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B2A40658;
	Fri, 29 May 2026 02:02:06 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id F298740287
 for <dev@dpdk.org>; Fri, 29 May 2026 02:02:03 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso17298946eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780012923;
 x=1780617723; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jysx3ejLXMeTzaA1fRr9CjauoItHPteMFr8iqJMmfWg=;
 b=gEOYFGhuyi7ygfZsmWnKJWtRjeDaNtoL0LvgeZ+vuUsJDn5ldGWUk2wNkLTHQx47jI
 MrnO/mBNwEZbLV5bxwqtR3F2FOwQNw00vvOuU/yWpOBesl28wVjMRkmszCudcy33RdvF
 RoUg6FspEMSYmPqtMLt+T06/WduWk/Rug2r7EeExvLb5vhLQpjTt1iGT2XbbTc6lNEBL
 bvCKvN5V1O23GZ4HpNQxhB9o8X/IcR8QoNXHLOSEaSpqyhdTtwd3Me5en3EHvnxqLga4
 sZ1k6eq19oQ2qwInDREZZ26t3wpk3OmqO9UoQutN5L5xnKP3y7Avf7bjJUGERG2wjT9L
 F09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012923; x=1780617723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jysx3ejLXMeTzaA1fRr9CjauoItHPteMFr8iqJMmfWg=;
 b=ciiGnap3twkDMjJ60Bicv9P+daeEMqKhZse8yN1wrGQfpfA0EpdCDnaV7arNZUvoxW
 1ZloxcnBMJYtMm3OXJetp0zR7jzLc/Q+hPfYxezlMkNC7mUuX46T9dBn5EMLja0mBKzy
 C+SddSsYDcIsoFNG8K5dM+RIX//GMHvyl60NgvLZ0St+oktnNhsUv1fK/zS4LZqTKFHY
 qD8OYc2A5aCFOs7cQo0jQpHM5RCAyxByvMkQOlbh/3iEhgTSM/QHgypL4fe7KY4XOBhx
 bl5sxfDP28w2jxOhINl6vcmuR4kxy0Af93g4MpWanzRoJtvM+en2xGG584YA1LfagGMY
 zEsA==
X-Gm-Message-State: AOJu0Yxrp4ClPbh4+7Xa3uK4zArOqV14ppbi5GGmvEZEv34m94zXIskF
 qceYDORDMkWYJIvZnBtW3bVa+temwxp7fmBtFAbbW0kmTg5MzetNgSisaBpSbNR0BVjGsC39iR+
 fMg4B
X-Gm-Gg: Acq92OF2izW2cxRk5u9V5qTnb7Rsahci8SHEMCxhRFJ1nbI1CuWyy78XxCp9jA4eDJv
 AOfrN3/py5QG0p9B7Ncf51ZgnGzBE6ICnWtzcYMgGf7xLNaRGko+HaWlyH9Q/0JqC9Kt9dsHoQt
 Usl2RQ2nU6ZiVVkEJPxIPQMIwi6TvHip1axxRhHhQ+m+i5r2OjyOX+4+0EeRzTv5i8OIWBmfcWL
 PNWDelc1iHIKDKOpLJ5pQQEcvIPreSQnyJzd8s+bf5wUcw7RfxJo8+WJNXf4IIX5y15+LPhtTk/
 eB2e5A2rF7rWCSHc4ss/erscxvY5mUEed/PeJ+uhfvwmUPkJVE83hx5oWoLmvugqtLj4Pd6DwQn
 0LqD5IvRl+8eFj1Earw6t/z0iLO1D5YwnstDSYDiB0ZcDf8uwGqsULtGLVIGfN6bGti+HAcXba6
 lrNopb/ib35jy0qDkZCgOg6IxFveF4o0sCnStswFrn4B14/YsFQHNMkuto9d7SSqcR0JCKAptJ
X-Received: by 2002:a05:7300:5b9e:b0:2d9:6373:ad0a with SMTP id
 5a478bee46e88-304eae3014cmr384788eec.11.1780012922882; 
 Thu, 28 May 2026 17:02:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm53076eec.28.2026.05.28.17.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:02:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Tomasz Kulasek <tomaszx.kulasek@intel.com>
Subject: [PATCH v2 2/4] net/bonding: check mode before setting dedicated queues
Date: Thu, 28 May 2026 16:59:14 -0700
Message-ID: <20260529000157.235931-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529000157.235931-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
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
check for mode.

Fixes: 112891cd27e5 ("net/bonding: add dedicated HW queues for LACP control")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index eba713e381..d1f30229d0 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1725,7 +1725,6 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
 int
 rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
-	int retval = 0;
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
@@ -1742,17 +1741,19 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	if (dev->data->dev_started)
 		return -1;
 
+	if (internals->mode != BONDING_MODE_8023AD)
+		return -1;
+
 	internals->mode4.dedicated_queues.enabled = 1;
 
 	bond_ethdev_mode_set(dev, internals->mode);
-	return retval;
+	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable)
 int
 rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
-	int retval = 0;
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
@@ -1766,9 +1767,12 @@ rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 	if (dev->data->dev_started)
 		return -1;
 
+	if (internals->mode != BONDING_MODE_8023AD)
+		return -1;
+
 	internals->mode4.dedicated_queues.enabled = 0;
 
 	bond_ethdev_mode_set(dev, internals->mode);
 
-	return retval;
+	return 0;
 }
-- 
2.53.0

