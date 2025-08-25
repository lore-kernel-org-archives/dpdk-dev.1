Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A4CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7350440677;
	Mon, 25 Aug 2025 05:43:17 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id B374940E24
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:15 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so755433f8f.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093395;
 x=1756698195; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IITHbEipPd9L1chou6Do0sBaKEVnfRIYp28S9EGybu4=;
 b=eqJqkIyoGKrVBVTgwGH0wLWIYAkw8pEt4HLBV/jGpian81LC15Pb/4+2jTMZ4CcUIE
 dkkOFXr7mk1mBH9IpMAmq9EpEowdn4Vc4sm/la7yvnSLE9fHnB8kno55JuQBEbJXpsz9
 wzvYnKn8IM3fZXAiAFxpj1ORTFf0GRGZrFSvwycgX+aE7NEHWVe0eJu0IFy+7dDXvag6
 FPEn+5T7EpfgeDOsurt2aKWySjPMH0GtPyRN9u77Jpm3Nn148TQxajG0GL/XO2wozD4u
 /i0EyR6zwVpBjRpA0UK3jcyUCk5z3HHKA0VGnwuGhVmYVKKxGN8WUvp/z+2ZJ0maNIPO
 tcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093395; x=1756698195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IITHbEipPd9L1chou6Do0sBaKEVnfRIYp28S9EGybu4=;
 b=rHcVLehUoYzn+QchMa5QD91rbjct2R2Rv643jrnW72l16egwHkjiA33gTr7M8FKo3Y
 N74EhUne8YxVwwd+JWcZsmkgAP4ukZTRbdkpINgguUhFbBRCOqWQ4GCyP+fTvOSxV6SC
 2+RkNdmBLLSy+Jn+RFZ4jMCSbK1IvRejXZEFBQkqGT5x+3e2gSd+yKkKFCklNgnKPv0r
 SBfPjdtJIKgZbFc7rBM3GgAdYPUJ7caOAL3PuW6zxm415rFecpnwLe0ekxb/+CHh0rsh
 H4vUgUjIM6uNv0qx3PxXmC5D8KeGRF6m1CKoK9PKHwbdEUIsMBNSfMM7XR+Kf1JhoGd4
 zT5Q==
X-Gm-Message-State: AOJu0YyLvPwHvVnfXdm6PBYnnGDEbua1dGMRnnD2wkWCO1TtN9+S4CJ0
 Ox5zkxFoV7AKf8zBHuJUYLTS7Z741tPdNwgz4fwOEWgPNpMtsWixGke6RUlSfcspm8IBmXBhDNb
 5VQ4DU+8=
X-Gm-Gg: ASbGncuGiEipEvS+0chR+tvm1iGAit3HT/6KZjxJsIfMWWGiHoByth3ne7XW290CbtB
 qMcVp4ryIWNTzcR8kHgNo+D5lYoD1gsI4BZ0zD29PTom6mZQJwH6lnX1tWYWrYPBKdqGHF1lrvN
 SXRGrRn9l9qX3KgLyMtLuTyFTu+VEXlZmk2eEhUojwg64wtqE50+PpmMDhSdkPKi/rqE0E//2Q2
 yR+/z/UXzwR4yz5EOHdGoZMzsZeSq3pI1gZTw1uhSmZ/OdyUIkQ6ndeIRAmfanU5lsX0/Kx4UIL
 I90520tgjCgO9oBgKG2uqP4+/vOriaQG/iyWttEAscd2qF1igSqzgNqoXchhe7vuNQwFwmRWKIF
 pWL2eTVNTUbAKegTBnk8ppM4v3VG3qrU+iSvLw5Njt1NAbWydE9xBnYkotTNASaV7Hv8cIhem
X-Google-Smtp-Source: AGHT+IF51viKhdLHlOO1KKG3P01ATi/bSIMm+wGkWBm8s7N2zBE1fIw+IpQa6fYJfshWIF/dhbP2gg==
X-Received: by 2002:a05:6000:2585:b0:3b9:16a3:cf9b with SMTP id
 ffacd0b85a97d-3c5da64a8fbmr8770831f8f.5.1756093395385; 
 Sun, 24 Aug 2025 20:43:15 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v2 41/43] drivers/crypto: remove use of sys_queue.h
Date: Sun, 24 Aug 2025 20:38:54 -0700
Message-ID: <20250825034126.12046-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

The system version of queue.h should not be used.
If necessary use rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/bcmfs/bcmfs_device.c | 2 +-
 drivers/crypto/bcmfs/bcmfs_device.h | 2 --
 drivers/crypto/ccp/ccp_crypto.c     | 1 -
 drivers/crypto/ccp/ccp_dev.c        | 2 +-
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/bcmfs/bcmfs_device.c b/drivers/crypto/bcmfs/bcmfs_device.c
index 46522970d5..c66e31097e 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.c
+++ b/drivers/crypto/bcmfs/bcmfs_device.c
@@ -6,8 +6,8 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_malloc.h>
 #include <rte_string_fns.h>
 
diff --git a/drivers/crypto/bcmfs/bcmfs_device.h b/drivers/crypto/bcmfs/bcmfs_device.h
index 610454dd5e..7e1eafc4de 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.h
+++ b/drivers/crypto/bcmfs/bcmfs_device.h
@@ -6,8 +6,6 @@
 #ifndef _BCMFS_DEVICE_H_
 #define _BCMFS_DEVICE_H_
 
-#include <sys/queue.h>
-
 #include <rte_spinlock.h>
 #include <bus_vdev_driver.h>
 
diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index 5899d83bae..7069265f5d 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -9,7 +9,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <openssl/sha.h>
diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index 5088d8ded6..61df5b1d7e 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -7,11 +7,11 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <sys/file.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_hexdump.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
-- 
2.47.2

