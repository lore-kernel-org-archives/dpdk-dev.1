Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F91C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 15:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE7B74064E;
	Sat, 29 Aug 2026 17:47:26 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id BFA2340615
 for <dev@dpdk.org>; Sat, 29 Aug 2026 17:47:25 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so2307291a91.0
 for <dev@dpdk.org>; Sat, 29 Aug 2026 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788018445;
 x=1788623245; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtR432UWf4Kw/njd4EATcyC8HVToFv5v+MnwEgbr9cM=;
 b=o4OuOkyFxez2UVH4e0D2MU0E66BSa8o2/XAgo+3WNfg0bGLR4yZ2PcSBLR3kP8JlAe
 8pSqQxDyg+LJGrOQsYbwGs7KSQNFGsbC7JCAhbb32LfrON3YzOP1lU1xzYat1XCA8h46
 eAGp/LsLkNw+fvqIB+KzlCeLi4kR8bxm36ECqZ4jeRAES8oXGJPAj16js1l/Zn6N+PGO
 AZVGUWeX5wWdkFW3JLNxAuamjCb/3LE4h3CDC1yzsGlEXzIOv8jAU8aqVj4o90L2mVvo
 lmEnURmq13Ee1TIXLW4Kj4Jy4ZxsxfWglGf8hLhSETphf+SDmOzoczVmQwQCn+xUs3oE
 I59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018445; x=1788623245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtR432UWf4Kw/njd4EATcyC8HVToFv5v+MnwEgbr9cM=;
 b=m9EmGa0UcYx6Mk++wQkrCenRDPnBtDh2dcVZRe96zMTjA+s/evROuEzKolr6V3l/1m
 sic93OLCIoKyf/KqdqACYfmntJo+Eau5r6x+gjlDzNbovApbBhyAB8p96Px/X2i6vyb/
 96PDP5M7vfUPCI5Qgu1d2By0jSeEK6v3gY0CQTCfwReHZUl4rvlO680pizO5UsZUWX1Z
 Bt/tT/BKPRPfwa65BNY5Dhi/cGSBZAVHUop4z6q01sJARevYBpTuZvk22wO13JRR4440
 iIcuCQISU+14C68sAOTudtvovSswxfyQjh8V0yiIYbkxWzj2MWh0smYZ+9PxQ5ktM5CD
 5Bvw==
X-Gm-Message-State: AFuF++my0Xi0bZ2qcplkJ1+jIoaGE4AtdBFpT0tGinoUpTHbN4tG4X5o
 T7GOaHGjUkSqJ49MCjDYtKjqWDTO5lRJ9uW1YzbSl/A1kxyT8lqiV61IwDtkNWxoaK7E2xmIVkp
 XzEIh
X-Gm-Gg: AYBFou3pPhI93nfLb+OpxJEKtoibLhi5NUS1LMBtVcDOzSkfPxrZ5bLZOONPBJBDtbd
 uKkqHax4KeBkOW8wpSaS2NDNbwSK0L05TPRJg0Oj1OLkmeHkW63BsZN/dGeGmHFB3P6H6qjY2sy
 4HIqhWOnqqI/GENG8x19ZqTAVzSsfVYXv8yJu1CMb3bQweNqn4DaKlzrJj7bci0Zacn+5H9Gt8c
 mKr55d5m43zHUSw8zkK+y+znjwylQwcqDOeW7ylaynyIW3AoH3RbXqSTaN2ek/J4pQtJ0kHLKR/
 tLYGlTtGC+CkmTA9vQ1hEs6inR0sNVzpd+5dA4Wq3CwfxeaKVuzkAjY6eUhX6fT2e7DNgPboLiY
 DXSUBJfQjUWW5CKOlKBrZB9ky4hrn1F98iYhMJnJn3VtrLTogcrK+0Lfh4rSW2df27ZVrhZiEjd
 dgS8rqhFjntqsTwK5Zx1W0gpaXOmDlLT8Qye7Q8ugg25kVM/GR6BjWcHjTrfuXXWVS4etaIwhVp
 CupHqx48gFSO+1qwzsCjfXcLEI=
X-Received: by 2002:a17:90b:2d04:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-396d0ebfb40mr29291796a91.7.1788018444817; 
 Sat, 29 Aug 2026 08:47:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e41837c6sm13221356c88.11.2026.08.29.08.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:47:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 3/4] common/zsda: remove unused device counter
Date: Sat, 29 Aug 2026 08:44:47 -0700
Message-ID: <20260829154706.52169-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
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
The CI AI review of this patch was hallucinating and
fabricated functions that don't exist.

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

