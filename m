Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFACCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 415D44064C;
	Sat, 17 Oct 2026 22:36:35 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D9B47402E7
 for <dev@dpdk.org>; Sat, 17 Oct 2026 22:36:32 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso4320555ad.1
 for <dev@dpdk.org>; Sat, 17 Oct 2026 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792269392;
 x=1792874192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R8nsrMminKZHBs9j95s9zg96bTr9Z9rAcuaYVDP1H+g=;
 b=M0t/y3V75E0BTxfj7/OdmhAxo0qrcg7kTc48O3IVRovJPNBSqzsS/lmzn8a/ITfaax
 2DN6ybmKF3YX+9CH+gy6I7CXivU7w/0M2KSqLbJ8YOP6Kdg/cMhUxXd+TMHTITW3Qn0x
 WNQ+YH6JSRkzhiDMbmQvzObp3gIGkAhu3Lxfe4slSod8CCqTEvj6j/8tk+oBKKknKtPk
 AHuXKnBuPChJTBWqQlh8sAAI50v2f1E0K4jNJ5yLB1KREZ3ojnunNxZU/rrgTZuptDsq
 Ky/DvBtloNM5g2mKalRipMcUxFzDRzJ41i1sUimZlc395E6V0zw4CZyGuap6gUKYaMJN
 1nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792269392; x=1792874192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R8nsrMminKZHBs9j95s9zg96bTr9Z9rAcuaYVDP1H+g=;
 b=k44PL+pUS/37xPc/uA3xWwNFqgbm33LARlO0/zz9bXsxr7W50Kde7SbFTkI+A3j1bA
 UXLGe8S58cWSk//t8W2X3VyT3W+DCjgW3jODbSsU3QLvmKXncWCJM6RLoRvt5PQ06w9B
 LexSwIdjtXYCI+xyPqPNLViGDHuXS/zsmFbrhiLkk1DEDFcA0IufSU2WT2BizQd/+BtZ
 WPMACEIOjDMkA5iiOKPHIXtyX5lvn0t+1sn6g/WSrtxz+cV1k0ws10TAHccRWfWvoDiQ
 n9pNTJlrNd4a3Zj9kxXsqIids+pKdKudY7OrwLU16CWZhKSF7TGh9Z2R5YhAdEGOwDBr
 aKoQ==
X-Gm-Message-State: AFq9FYIv02M+hvr9wMOXzHReSrQYw7Ib+l+EjIVoFXieEkULLVfviVxO
 EBA7DMGhfn1udmCAOKdAl1/iUNecRqp5jM0UolSozNQeE7u/oiQ/4vf0NZvrMJUO1cymYhsbvBH
 JrgXvCVg=
X-Gm-Gg: AYBFou3i57PHsDXn/riwRQbmbyaglxQ7X6fZK/RmiAetz1/pu9/gIkRpQmRHMKS8hdO
 iROdR5V3JkrHPxFgV/mGR33T0ASLcdOq64dRFMOkiUzKWAxStoFoaO18PrzVo7wj+re72jffJQo
 bz+ws6pkc65F81r/X9cpcfPlcioQ9Dhc6+X/pMK8eAqSZngMQcQA6yTU54LKc/cuAMT1qa+IQWQ
 c4bKtLNKN8O7+JYc7ZezzhNTGIt/Q5AneW1vGCHTH8pm1Am7nPv6Tpsn7PW9LmjOorgp8mUNV2x
 Dybxjx8LWLPKx7h/9PhCNjcQtAQKvC98YboHownjISaCXLXtXQ0OB2spX+fFrLQH5B7a+CMZdaX
 wRxsH114xsj2iba60Q2YZW/35A0Q57B8csfeGbNV6alSY0+R7o60LN3mOmbzdECXI9WPO1KPm4u
 XAJIEJB6ni64QFOp9HQLAXwKA1R1BhYEYH9oEoGvhYesLhhc8oYBl7QGcYzgTg8902JyvFxUogd
 8akakKuyaRFtzE4QSmvwNR9Uw7V0uCbFx8GAg==
X-Received: by 2002:a05:6a20:9191:b0:3dd:a195:dd5a with SMTP id
 adf61e73a8af0-3e22610308bmr2934996637.60.1792269391987; 
 Sat, 17 Oct 2026 13:36:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2451929b3a.32.2026.10.17.13.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:36:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Subject: [RFC 2/3] bus/pci: reset VFIO device FD after release
Date: Sat, 17 Oct 2026 13:35:04 -0700
Message-ID: <20261017203621.3136254-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017203621.3136254-1-stephen@networkplumber.org>
References: <20261017203621.3136254-1-stephen@networkplumber.org>
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

The VFIO device fd is closed by dev_vfio_release_device() but is left
in the interrupt handle, so freeing the handle on cleanup logs a bogus
FD leak warning.

Mark dev_fd invalid after release. In secondary process the request
handle also holds the device fd, reset it too.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/pci/linux/pci_vfio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index fb35bc1d49..7ee8fe809a 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1103,6 +1103,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
@@ -1142,6 +1143,8 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
+	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
-- 
2.53.0

