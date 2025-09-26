Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAEDCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE74A40A79;
	Fri, 26 Sep 2025 18:25:46 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 9FF1940262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:25:43 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b33d2f0f5f4so376826866b.2
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758903943;
 x=1759508743; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eXPYhVraEBQkg5npAWWmTuc4tSjm1smdegQLdcvI2w=;
 b=gXueADtbNqL574o3dqpCfIuZ1E/Vh7zrXKtrV5VEwdvWdD2t+oSdlHUEbx44paIxxh
 Z/9S7k1kohLwaCvfhSeixmhu2l0Z9nfwEUpLCxxLE4LL4W+B20g5LDZ1oNNVfdtnaXV9
 eF9m/o5GGEB7cnBK7NfqPf+OUYlljZPvimeGiT5k0NMBCpX2btIiNA6g5lzBNxHh1riJ
 VTive20vqVMvK6Es/I78Ffe9jyLPnhADT0W6h80xSMO6xtcZkNd0j7KVDVKuHZ7mLrhr
 awkMkoX0GP1Am15r9Z+IgszaAf1+7OPFXIqHZSYLTR1hZQ0KFYr1eY81IxxcarxjAZ5P
 qfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758903943; x=1759508743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5eXPYhVraEBQkg5npAWWmTuc4tSjm1smdegQLdcvI2w=;
 b=pHjNhF2YGUabEGsqm2qgo9Z1V3rMG6SQpY4jZzJWIJCAi+sGEF1goC3N0OBSUzrW8G
 R/wRj0WXSdeFtK9hKkTVdW339C26RAW20EZJaiT19rEBbzf5lH8hrB8AMT2YaUYZxg7+
 1HrcUjg4qaC02B5S+yEDL85FY56RIaVwa7VclTQDcRgcLfZfsoiw5lN7dlpfV2khf5rl
 UgKv6C/s6tSVTYI/3B48fSsUM/QzMWalYAZc8Ir5bJvrfvrCuAUiNumwD4fFX7J31BYx
 8TO9ADzcj50WGd2eQZP25IgJ/f3E1YBE4WGMJi37TPGAPBY17A0CF2s3Vo08tzQlG0B7
 c2Qw==
X-Gm-Message-State: AOJu0YxJonFbzpMIjWAkV4cOoS5RRR1waw0Uj6fd52AX6lKa79b6Q9EX
 bUCgZnWqViiIQGqt7jl4tjWnTUI0Oh8lSvKSSH5qi2EoXMb1WlipHD10CP0ZjyhXbljmDwSxAO+
 eeIpzCQk=
X-Gm-Gg: ASbGncvWqMrJ/itJTy8Bi/BmAdgUGLXgEpIFKNzqVkx+CjvkntROZ2NOs6U8vDe+pp9
 X0JL+Ope7WO9U3Ln1aoBobUbBJ0gYgVxfzgpo4Yrf+lVda0vaLHPf5vyR+Klo3lE/fxj0RQD3hx
 uR9QtfwXyqgohaUicNSypY3HUhfKyi2j5rvWTOrU6/X92xyt36UwLncahjhL6XcbU9uB25NyPN5
 cppLVCX8zwL8Gs4Zmrl0IGWyEsjgItDXZ5WFiO0gKuQ1PvT/oBZCuGl9+4POcW4tM7m1+LoW761
 gZgGwVgk+YGaz6huAf492hsZ596VLN8iCF9DKE0e5+LBCcOmo8g+m9vxcJVIvS02ElFFOhIQCMe
 0nUMmk45wYWZuCFnMbtkqXRrdRbzTY72HKcPbEXYF326T9Yir2+YuxRLNu9nmAtvhRIb9UJyQaY
 cF6G06cyE=
X-Google-Smtp-Source: AGHT+IGrHh1mOOl1XL4wUDPmD6/U28hhE43dB0hgjCMAHOTlXQtDdlIXFdJK4HgKWT7B0UU1JefnqQ==
X-Received: by 2002:a17:907:3ea6:b0:b07:6454:53f7 with SMTP id
 a640c23a62f3a-b34be9bb21bmr847942966b.52.1758903943150; 
 Fri, 26 Sep 2025 09:25:43 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efa406asm386638866b.23.2025.09.26.09.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:25:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [RFC 2/3] net/ntnic: rename hwlock
Date: Fri, 26 Sep 2025 09:24:47 -0700
Message-ID: <20250926162534.401577-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926162534.401577-1-stephen@networkplumber.org>
References: <20250926162534.401577-1-stephen@networkplumber.org>
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

All global variables in driver should use common prefix.
Rename hwlock to ntnic_hwlock.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/include/stream_binary_flow_api.h |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                   | 14 +++++++-------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c      |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntnic/include/stream_binary_flow_api.h b/drivers/net/ntnic/include/stream_binary_flow_api.h
index 4ce1561033..b89f19d399 100644
--- a/drivers/net/ntnic/include/stream_binary_flow_api.h
+++ b/drivers/net/ntnic/include/stream_binary_flow_api.h
@@ -47,7 +47,7 @@
 #define RAW_ENCAP_DECAP_ELEMS_MAX 16
 
 extern uint64_t rte_tsc_freq;
-extern rte_spinlock_t hwlock;
+extern rte_spinlock_t ntnic_hwlock;
 
 /*
  * Flow eth dev profile determines how the FPGA module resources are
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 67908e3807..9c9c91deca 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -92,7 +92,7 @@ static const struct rte_pci_id nthw_pci_id_map[] = {
 
 static const struct sg_ops_s *sg_ops;
 
-rte_spinlock_t hwlock = RTE_SPINLOCK_INITIALIZER;
+rte_spinlock_t ntnic_hwlock = RTE_SPINLOCK_INITIALIZER;
 
 /*
  * Store and get adapter info
@@ -124,9 +124,9 @@ store_pdrv(struct drv_s *p_drv)
 			PCIIDENT_TO_FUNCNR(p_drv->ntdrv.pciident));
 	}
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&ntnic_hwlock);
 	_g_p_drv[p_drv->adapter_no] = p_drv;
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&ntnic_hwlock);
 }
 
 static void clear_pdrv(struct drv_s *p_drv)
@@ -134,9 +134,9 @@ static void clear_pdrv(struct drv_s *p_drv)
 	if (p_drv->adapter_no >= NUM_ADAPTER_MAX)
 		return;
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&ntnic_hwlock);
 	_g_p_drv[p_drv->adapter_no] = NULL;
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&ntnic_hwlock);
 }
 
 static struct drv_s *
@@ -144,7 +144,7 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 {
 	int i;
 	struct drv_s *p_drv = NULL;
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&ntnic_hwlock);
 
 	for (i = 0; i < NUM_ADAPTER_MAX; i++) {
 		if (_g_p_drv[i]) {
@@ -156,7 +156,7 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 		}
 	}
 
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&ntnic_hwlock);
 	return p_drv;
 }
 
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 813ac04481..b68838461d 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1187,7 +1187,7 @@ static int poll_statistics(struct pmd_internals *internals)
 
 	RTE_ASSERT(rte_tsc_freq > 0);
 
-	rte_spinlock_lock(&hwlock);
+	rte_spinlock_lock(&ntnic_hwlock);
 
 	uint64_t now_rtc = rte_get_tsc_cycles();
 
@@ -1196,7 +1196,7 @@ static int poll_statistics(struct pmd_internals *internals)
 	 * if more than a second since last stat read, do a new one
 	 */
 	if ((now_rtc - internals->last_stat_rtc) < rte_tsc_freq) {
-		rte_spinlock_unlock(&hwlock);
+		rte_spinlock_unlock(&ntnic_hwlock);
 		return 0;
 	}
 
@@ -1242,7 +1242,7 @@ static int poll_statistics(struct pmd_internals *internals)
 
 	/* Globally only once a second */
 	if ((now_rtc - last_stat_rtc) < rte_tsc_freq) {
-		rte_spinlock_unlock(&hwlock);
+		rte_spinlock_unlock(&ntnic_hwlock);
 		rte_spinlock_unlock(&p_nt_drv->stat_lck);
 		return 0;
 	}
@@ -1279,7 +1279,7 @@ static int poll_statistics(struct pmd_internals *internals)
 		}
 	}
 
-	rte_spinlock_unlock(&hwlock);
+	rte_spinlock_unlock(&ntnic_hwlock);
 	rte_spinlock_unlock(&p_nt_drv->stat_lck);
 
 	return 0;
-- 
2.47.3

