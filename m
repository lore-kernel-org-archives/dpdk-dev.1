Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB2BC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 12:48:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F5484067D;
	Wed, 15 Jul 2026 14:48:26 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 0537D40288
 for <dev@dpdk.org>; Wed, 15 Jul 2026 14:48:25 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso2214167f8f.1
 for <dev@dpdk.org>; Wed, 15 Jul 2026 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784119704; x=1784724504; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sfhDyMwUFCuLDwuoH/XPxS/tkHG993BY+VqMwNWFICQ=;
 b=VQCkGRKxBB5LSzqYbiuOxkO2p59so+1z7J9AETegUt6P+n1Lsq7Y24V3KnC/0HawHI
 TXa2BtPNSiZAxNN3Vd7xzZueuHEWdGGxw/ifqcJGY8C/qk2iI0h6MrYuM0UDJGF24Hzs
 QMvvjJKxTstYZ5ThR9R7Z8sMU3Ns3cK+y2/G9kakPH3hQhPUC/COZFtey8FwG02PCaPI
 Wga/tZKZiw1tk4tNHckEmoh4YqD3C/3qmp44ixkyldEcrOz+Us+mwqxO8KUwdXaSnuXU
 sFtcouke1p608ZYHhL1PFKgFKiUUphcxkDnNOIHXkhfSL8IjutO/GbYJ3VCzmfi4t5C3
 Mj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784119704; x=1784724504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sfhDyMwUFCuLDwuoH/XPxS/tkHG993BY+VqMwNWFICQ=;
 b=SpYA45LoFTkRL++3N+dZCOXtJZDErd8fMvhSWysEXDYIWfnoWlutOBbd/ruI62QGOc
 sqJJWWKL1QDt07dUHJQ1wNIo4FcYRNXs80T9yVhxyenjPEZlKPeHAgqafKuwcD3jG0QX
 hR8eEKsihPzG7aKfyPgmT5M/N2XiNYamMb+Zm90iM1ar7VvpCNkIB2Dx/WQxC5Wa4hh+
 qagxoJh5F/ZT0XuhC/JaaKoLtJvef2DNolvBTTx6ByPAwQ+/r+z/TiMSK0eInqMT4Lgo
 vgKV2oQTzZQY5NcsL/m4Of9DrMDlFwZIylT+XM5TTWmQ3IDjii6iXpKr3xlnEc8o8aDL
 1Kmw==
X-Gm-Message-State: AOJu0Yy9VETxg3VdAqn5iG17aZc4RobGDl8CG9x/HBZnyT92M6HfVRM4
 G8/j/YX4ie4Ux45lRI4zELHtg/oZ33smP335L5nPEMJYT71QP+ucC12P9qoPiJk+y/g=
X-Gm-Gg: AfdE7clb49wrw7nQygJQhr8gyUN9K0nVdELVR8J5IQxEHjseYzrNvdDbqlvWipkAREI
 6S1sa2fgQCNot1UwRhDOxFI3KotQMWKO+Da5jNgaGBxz5w54hVp3m7+tp7fEvwkaAFrF0sLfR/i
 CDOujcQbpDzvKQi0uGSURsqAOw+KX78WS3qrFW2WdUyjqkZC128W5UvUhEY3pxh3tBsgTkDf3Rf
 gzngc4oiQm8m8kxJAMybX1OnbharZSWQj1Xfdpi8XE6zESu33binlOJt7NEMCZ6XsXbRXe9QJJl
 E6xEaZJBnBciiRW0pYtTXUAPPxp+MSVjxa+/PraDkc2MVZ4DCJY1olzfAqXE/OM8J8cFBAmz+WK
 5slZFYzuQ0se01tVoSI2bRluzcoo40hqR/s8O34LRrw5PNbVr1Yc6Xp2OXPhbGRPwiROcStICrp
 ilTLIdNnYZhAGIVjLZE9YyvLhRBFpRsM2w8UeQS3ughsiEK+6Aj5H5ADEvGjJlQTf4L4BkKzhW2
 M1cACwX4Ca/lkP44+SYs3PIxTULw1ttp3Z0Udh0MOesLaJfs0P588Pw5rSYpUQ=
X-Received: by 2002:a05:6000:26c9:b0:47e:aa42:4e42 with SMTP id
 ffacd0b85a97d-47f2dd15aa3mr21499709f8f.55.1784119704355; 
 Wed, 15 Jul 2026 05:48:24 -0700 (PDT)
Received: from ll-cherrati..
 (2a02-8428-106e-2001-e626-cafd-02ee-1254.rev.sfr.net.
 [2a02:8428:106e:2001:e626:cafd:2ee:1254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c30a9sm15651854f8f.31.2026.07.15.05.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:48:24 -0700 (PDT)
From: Sid Ali Cherrati <scherrati1@gmail.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Sid Ali Cherrati <scherrati1@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 1/2] net/i40e: fix return value of close operation
Date: Wed, 15 Jul 2026 14:48:15 +0200
Message-Id: <20260715124816.19882-1-scherrati1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710134639.108129-1-scherrati1@gmail.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
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

rte_intr_callback_unregister() returns the number of unregistered
callbacks on success. Since the close operation started returning
the ret variable instead of 0, this positive value leaks as the
return value of i40e_dev_close(), so applications checking
rte_eth_dev_close() != 0 treat a successful close as a failure.

Use a separate cb_ret variable for the unregister return value so a
successful unregister never clobbers an earlier error stored in ret,
and stop retrying once unregister fails with anything other than
-EAGAIN, since those errors are not transient.

Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Sid Ali Cherrati <scherrati1@gmail.com>
---
v2: use a temporary cb_ret variable instead of unconditionally zeroing
    ret, and stop retrying on a non-transient unregister error, so an
    earlier error is not lost or masked by a successful/failed
    unregister

 drivers/net/intel/i40e/i40e_ethdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..b5457bcf2e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2693,6 +2693,7 @@ i40e_dev_close(struct rte_eth_dev *dev)
 	uint32_t reg;
 	int i;
 	int ret;
+	int cb_ret;
 	uint8_t aq_fail = 0;
 	int retries = 0;
 
@@ -2761,14 +2762,17 @@ i40e_dev_close(struct rte_eth_dev *dev)
 	i40e_pf_host_uninit(dev);
 
 	do {
-		ret = rte_intr_callback_unregister(intr_handle,
+		cb_ret = rte_intr_callback_unregister(intr_handle,
 				i40e_dev_interrupt_handler, dev);
-		if (ret >= 0 || ret == -ENOENT) {
+		if (cb_ret >= 0 || cb_ret == -ENOENT) {
 			break;
-		} else if (ret != -EAGAIN) {
+		} else if (cb_ret != -EAGAIN) {
 			PMD_INIT_LOG(ERR,
 				 "intr callback unregister failed: %d",
-				 ret);
+				 cb_ret);
+			if (ret == 0)
+				ret = cb_ret;
+			break;
 		}
 		i40e_msec_delay(500);
 	} while (retries++ < 5);
-- 
2.34.1

