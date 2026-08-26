Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF389C5DF97
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 00:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F00F40616;
	Thu, 27 Aug 2026 01:59:58 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id ED66840664
 for <dev@dpdk.org>; Thu, 27 Aug 2026 01:59:55 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1259652a12.0
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787788795;
 x=1788393595; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ysy8UUA+j/1IrV59LDAPb1oP27yDssub0CZu0xqET4k=;
 b=abh2BmkuHB2n7UHu2JAamIAbbewnlmVPVGuF6HhWq9ZeKH85dlL+YDXMzz5Cm8XNCP
 sj+XSOnNLb3Mtp3/BcjU5oRxYEb3R1iWEmMaYNFEVKp2ntNFjKlYLdKPnspKBw82/CRT
 XN/36+igcHj3I5jljEYs/brE3agWLtpchJelSPEzD5jB8a6yn9vkYNqekxDBoTYXTUpf
 kwJJhTF41V6xY+SZ0ChrKeR99DN6TbK54TMrXpAPAWqwB9qEmVck+1IVJTkr+N7H1bU3
 gRi6OflO69n4GHsH/JE6cv8JeMheyD8sCAkt0QnhlGaUDmZtuEUrXq9Q3bA8zpVtBbED
 21wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787788795; x=1788393595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ysy8UUA+j/1IrV59LDAPb1oP27yDssub0CZu0xqET4k=;
 b=GS/qwUiPs9XVI4eOfijAxm0DEH5lIdDdvpW2YXPsyR7UO9b1B1OKOJQjqi5Ve9VhRD
 GqTNXIlL45Gu7LCM1/kMVvMW66+PUkCGhFaVBPGkRAW7tPeWQJHQQiXDFxowUFpgMNBM
 FRy1c6RQidu7P8Yk5tb9Rf41qPMpAtGRIHlXqBJpMSUigbDNHnf6taBWp09MrmQOz2pT
 C+s7nRMNb+spz9S0aK1Xhmlf5exlX7jVtzvNdh8OL77OQ927VBhC8fHLgzX2u0QvO3mC
 s2VrOzepwp60ioEfv24TfUxLVQFq+ANYLlP7ha7r/SEtIKRhwXJmT8mkbOvF8HRA3gVR
 4zLw==
X-Gm-Message-State: AFuF++n22ORUiMdDPIOdq08ZHDvJ+xsIoLsl49XpfE48xBrcPXwukYb+
 0kyOXOQSvwc3RCn3SKHyvgaz4YgnYmiOmVfUQge+Ixp3vi3v2RAC6xkS7xluiM8u0S05LzwDd9W
 6VI20
X-Gm-Gg: AR+sD11H/lx9tHz4yy9fQyzI2urqWbrHnXDPzXo8aM/OTafnsVG2mEn0Z4+H1cvC5h5
 LZGKOV+1f05dzHNTyyggjE9HhBTPWOEBuKVDvtI+pemDZelIt8GVesHv0xN0k/RlzKnWe2rNfaY
 qcZMwgfIxp1SJhvnyP8FPzgwduon4zY5C3WDLyuRr2xeHM4PGl4xjVQXc7ZAlQMaEBZdvM4Fo3x
 SZ2QZpboAAPqXEPllaba0hGonHzzKB2O5sJn0iJiJdI1SGcynn+Trgm8BBgJ1ShEpRMIFACYIL+
 wg+sTjCvboPSANjhnRcnXtBORyPb88SS/pAINgH/RbmXZL3c8Oh/tk1jARK88w73/l7acN12DhI
 i7opcGWWvE3HBinODa9zHIAgdfKh1TmXBeXGJZYmPDGh+8Guom5mWcApouE4ulVM1Vnbcq+deg4
 ps44Y7teOksKeUeBdcIx/jHz79Jn+VldoEFQtNKru0DKlrahBPSzihFHnEXQiZS3nvGKJayDTnn
 YsdCbVfnKULRDlllWpLw0y0b0I=
X-Received: by 2002:a05:6a20:a11f:b0:3cc:fb7d:a9ab with SMTP id
 adf61e73a8af0-3cf7586eccdmr18517822637.2.1787788795067; 
 Wed, 26 Aug 2026 16:59:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm11019596c88.1.2026.08.26.16.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 16:59:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengfei Han <han.chengfei@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>,
 Hanxiao Li <li.hanxiao@zte.com.cn>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 3/4] common/zsda: remove unused device counter
Date: Wed, 26 Aug 2026 16:43:03 -0700
Message-ID: <20260826235933.194681-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826235933.194681-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
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

zsda_nb_pci_devices is incremented when a PCI device is allocated and
decremented when it is released, but the count is never read.

clang 23 reports:

  zsda_device.c:10:12: warning: variable 'zsda_nb_pci_devices' set but
        not used [-Wunused-but-set-global]

Remove the counter and the three sites that update it.

Fixes: 6592da5893d3 ("common/zsda: add base driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/zsda/zsda_device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/common/zsda/zsda_device.c b/drivers/common/zsda/zsda_device.c
index 72f017c699..280a51f9b3 100644
--- a/drivers/common/zsda/zsda_device.c
+++ b/drivers/common/zsda/zsda_device.c
@@ -7,7 +7,6 @@
 
 /* per-process array of device data */
 struct zsda_device_info zsda_devs[RTE_PMD_ZSDA_MAX_PCI_DEVICES];
-static int zsda_nb_pci_devices;
 
 /*
  * The set of PCI devices this driver supports
@@ -85,7 +84,6 @@ zsda_pci_device_allocate(struct rte_pci_device *pci_dev)
 		zsda_pci_dev = mz->addr;
 		zsda_devs[zsda_pci_dev->zsda_dev_id].mz = mz;
 		zsda_devs[zsda_pci_dev->zsda_dev_id].pci_dev = pci_dev;
-		zsda_nb_pci_devices++;
 		return zsda_pci_dev;
 	}
 
@@ -114,8 +112,6 @@ zsda_pci_device_allocate(struct rte_pci_device *pci_dev)
 	zsda_pci_dev->pci_dev = pci_dev;
 	zsda_devs[zsda_dev_id].pci_dev = pci_dev;
 
-	zsda_nb_pci_devices++;
-
 	return zsda_pci_dev;
 }
 
@@ -141,7 +137,6 @@ zsda_pci_device_release(const struct rte_pci_device *pci_dev)
 			rte_memzone_free(inst->mz);
 
 		memset(inst, 0, sizeof(struct zsda_device_info));
-		zsda_nb_pci_devices--;
 	}
 	return 0;
 }
-- 
2.53.0

