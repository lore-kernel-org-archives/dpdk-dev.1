Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC924C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:28:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4CBF4027E;
	Thu,  6 Aug 2026 18:28:12 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 637A740262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:28:11 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so2479748a12.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786033690;
 x=1786638490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8s88jWLmXYtElCGsr0YiipiqV6IF91Q7qk3giBCGuM=;
 b=FY874H4WbkWmKfxmlTWbpRpDbYzcxI6dWEjA0uQ5gLPN/wKaTEHa2xKTZsrOQYAeba
 dIrrzLL82pdtPvBlcdqibaV9PCR0y/mdqOPuyHr0wyuclMXYmFeO/eQDuhBNr+/W65uA
 chZQCxd9WsrcK3jYtZl2Wj5gjRUCXix2mDPYCa10ipLTWqUah0l4POE51/ZJyFVHntZ1
 KNbuJFMLunduPofz57n/2BTfvpbiLFnllMzNmDIS92uYRalH/GMmvpWMC5Q7UtnCgX31
 K7m0k/7BVXnsdX54sN3BY79exPEdZOrMd+5eT8yedDYvPgmt4j5fwR1zyWklfj+Ec7T9
 ORKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033690; x=1786638490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8s88jWLmXYtElCGsr0YiipiqV6IF91Q7qk3giBCGuM=;
 b=PYRMw+cCXj9aFBnnZ+JUuFFUC2PlrEkzm9k5THc1Pq9GRGN2miFKDO6s1DX2dXzzf4
 nj0PmB2cslW4291rmJneIZ5trTGFbAHU8ox74Ax1KMrA5b+JVTJ3V0Ff5ZHp+ZxKi9x0
 wEW6KxjsQYJOmXZ4jMXIaqGtPyHDAs9p4zrY7X7m611U4xAOOpxFgQSBUkNawIZccJHF
 Qou5aqoU+roAHNfFvsLaXUSqX+Z7w91T/EahOEMfXj1fs6rgCf2bvJ1LFE/1CafaQzoD
 rHxA+UWFrGPguwCeKgjwzZ/p8uaNgmEBh/xW8YZN6vDTxLbJRt48WwekBxz7mQ0jEFAT
 Yy/g==
X-Gm-Message-State: AOJu0YxXgV9Kw4AXz+otw9NBTpNRq4z25k7z8AdOIKg38s6FiDraUTUH
 vsG5Iz4t6bp5BYklJ2ShPqiQI3pSQlQxAAo4NWVA1zbAoCNFD9UBUDzzYTY3TNNbzeBJvbnsT6V
 gAnbBPMQ=
X-Gm-Gg: AR+sD10IKlSqP9ds3qzGNJPh04Qq2zNoixRYmT9NXxWHvPjEGJmrfNJkIUwB8uGe5jA
 SCtmWCVQ9fXpdoqJBwr+vkIUCFqHphMCpkr4LoYhZz79wFCdLgO85oCggWUquKWsKckhMkxRWiN
 mBvqYLtvstnVcDe5K/UQfjA5AjIP8vAc50RzbHQBef/CSrBpFDfVM0U7w+919jGTlDpJ0eKRIH2
 Hgjb2TIid57EARBNVqPC/4UV9jcfdVYylRqxP8107Et/LT6LqkE5msCxHdbJ0N2FxGRa6+RLpUL
 mEHJWpi1QotoOmBniuL+Q+4I5mBCgJvHBKOfM0fZ9BLiUhWzPwIxK5EG2R3BIjOF+v9lks5/x+0
 YmUfQHVzgSFtY8nc/CqqeL5XR51yb+/IV704oRvd4xz7YNXwWlJULCatsjE2wHH5ajwizcOcCnr
 /VTo75wgAZmnFTlTBoz+AYhuSjhYn/MmHpRwGLjeUQCR1naAwaO2qaDzaU0elBpCiYv2zs40hiS
 Adw9DyYlNxY2BR5DvSaJwk6wLI=
X-Received: by 2002:a05:6a20:6a1e:b0:3c6:62e4:91eb with SMTP id
 adf61e73a8af0-3cb85e60fa9mr16665367637.24.1786033690413; 
 Thu, 06 Aug 2026 09:28:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0bfesm29946637eec.3.2026.08.06.09.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:28:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] MAINTAINERS: remove Chao Yong
Date: Thu,  6 Aug 2026 09:28:05 -0700
Message-ID: <20260806162805.680383-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Mail to chaoyong@corigine.com now bounces.
This leaves NFP devices unmaintained.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..2f7972540c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -964,7 +964,6 @@ F: doc/guides/nics/nfb.rst
 F: doc/guides/nics/features/nfb.ini
 
 Netronome nfp
-M: Chaoyong He <chaoyong.he@corigine.com>
 F: drivers/common/nfp/
 F: drivers/net/nfp/
 F: doc/guides/nics/nfp.rst
@@ -1458,7 +1457,6 @@ T: git://dpdk.org/next/dpdk-next-virtio
 F: drivers/vdpa/meson.build
 
 Corigine nfp vDPA
-M: Chaoyong He <chaoyong.he@corigine.com>
 F: drivers/vdpa/nfp/
 F: doc/guides/vdpadevs/nfp.rst
 F: doc/guides/vdpadevs/features/nfp.ini
-- 
2.53.0

