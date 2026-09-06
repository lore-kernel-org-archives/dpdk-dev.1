Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4FC79F9F
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3025D40656;
	Sun,  6 Sep 2026 19:12:28 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 38E4A4060B
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:12:27 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-852c481415fso3066815b3a.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714746;
 x=1789319546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=emsW9ZrsG+7w+KV2pVYKnuczKTbhApCJIVHD2Yx0R0s+2Wk3E4/wGvNPSR+xwcFVv5
 hUvSk6RfGeMAxuwqzCeiMSVf5ROQnDHhopg2GRrpkJt4PVlV4pwh+vlGu+w+GR7SCT4h
 hZUIrpZyT151+QcZ/dyy6p3o3Z3GAJXCcu+NA0GESCgxqr5LO0k/B6A6XDJwIdbvU9c+
 qB/cfK36tz8n0LCQ9MFV35iuQULBwhXr/9hbJPcmCTK+6kcATHDEA7UuNjaKxkMf5zeJ
 Exq3J6W0DhSZA+Y+LvAMDsFMhQvd72eYA5IjKRhj5RHIG3sZsYkhbvGEMwbZBM/KZ4lf
 +jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714746; x=1789319546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=WKO+UE0Cq8+AwMPBLjliaeK3epuhnjxvwZg9S62C0lwf1tPIkxkBEdBMGOZUHDNlBC
 eHQRF8ZllXQBHIzJQa9ZBI45cXWxzQUxHPv6vJbIfvcyhQ1TuDbhNOI4N2zCnoIaxXAu
 0Kv2N0wpikHDv2Z6XSg1dPRheQ/UIUyguWkeDPxrGcfRet7DuJsJQtRJJrQdbaoAu4Uk
 0iFpLBIsTO2rjfbFUJyAua2BUXggBYKeC14wsNJ5cVl8S5XypoAfMey35xUShj99z1QE
 fV7RnXbX4zh9ZHUWBzj+UsHXna2izQO20362AJM1jtUcTVCpx35IK9AHdQxDchRd2rZz
 Tk2g==
X-Gm-Message-State: AFuF++muMDS9J6qGO1b/o35ynWFRzz0dm1pEZkdZLUZq8GjtpQfI0cTK
 c6/ePB4k1VPsGz7rjShD9r4gg05UqsBA38ikEZbVdovIjePwpV7iJxZfWRTqoULk9supGo8dq5/
 Qg8jY
X-Gm-Gg: AYBFou1jtxvzqWcaShXhNpxeHx/no0UwRwlpkJtOYsqF++4N6rNIruzF1sEIq57I2BI
 0NiKO2lobYzqH2cdPEke8mnBV5RKK/xAFesdLqmG4ESy9t4rh/Q5IGH9zsFLkpaO3ws4bFfZaBg
 nD1FCSHNoQzYx0TVkIUvVPksEFO4pywxCHwqDYEtMEa0sHVx0IT/hpitmU6mG9pVAbzkQMUObs8
 QUwsgebbTAIPbx8LD5r2X12puXaVPcDHf2MYASj9UR8ZMj0KTqbmgS6D5D7SyHLzQJjfgwunrwu
 htbgGeqUsHQMU86C3pSl/4PnFSUPmB2epPfMW+n59v1BLTRC95v2KUDkYGNN+fVHQOCFSu9CynZ
 rmweMmz6jt4BPYEm3knf+AF/4ylwslKdnWEb7PifD555RCjw86Wa/iaLEO50RengWMMSzUB7NRD
 UzilbBSCwyK+fnfpCTlgvzpophx6YjBVrIICJ47KojTAKVANy4pJ6TxI4ydEcANN4nu4g/41hWU
 BMfhrXQeG6jpZ01eH+gYLhiscs=
X-Received: by 2002:a05:6a00:300e:b0:857:7337:5dba with SMTP id
 d2e1a72fcca58-8616b373626mr27308978b3a.24.1788714746389; 
 Sun, 06 Sep 2026 10:12:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:12:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/5] arm: remove no longer used RTE_ARCH_STRICT_ALIGN
Date: Sun,  6 Sep 2026 10:09:58 -0700
Message-ID: <20260906171142.3503868-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
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

The RTE_ARCH_STRICT_ALIGN flag is no longer used anywhere
in the DPDK tree. It is safe to drop from arm.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/arm/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 27b549a052..f1f2f3e260 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -46,7 +46,6 @@ implementer_generic = {
             'compiler_options': ['-mfpu=auto'],
             'flags': [
                 ['RTE_ARCH_ARM_NEON_MEMCPY', false],
-                ['RTE_ARCH_STRICT_ALIGN', true],
                 ['RTE_ARCH_ARMv8_AARCH32', true],
                 ['RTE_ARCH', 'armv8_aarch32'],
                 ['RTE_CACHE_LINE_SIZE', 64]
-- 
2.53.0

