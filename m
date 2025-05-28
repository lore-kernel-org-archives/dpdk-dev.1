Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C352FC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 23:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51BCB4021F;
	Thu, 29 May 2025 01:30:47 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id A00D44003C
 for <dev@dpdk.org>; Thu, 29 May 2025 01:30:45 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6f0ad74483fso4293006d6.1
 for <dev@dpdk.org>; Wed, 28 May 2025 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748475045;
 x=1749079845; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HwBS5hgd6WP1QOcRxAh1zyzUJYzPtZz4LVaBNyp9Iu4=;
 b=hdtua2NJCl4cwac/KOM0/VPbJzfEw3fWvjH3KHjVq15o1g/pLH+wNNKepV6vhJfpxr
 zvxYM37nyNEqznimbAPotNzqtF5pa0uDxSwewxuDaZDER6C53DJbGcyWeQfx4fH6p/ou
 bs2WoWI7lK8Zj63BzttSMhAqidlBhLVzpMcIa9aWaHLUEc5X6zP9nfQadTjH91/i4O1c
 o6HlpX0eR0X3sPV+n67CtZnGOyIBxne+gGCrYA1relMwKq9wLgBACwL4u+7FEK6HrmyS
 cHelUdDVMuQAYHVFvVSfJ5dX11G1gkQydr+K1FJ4As9Txsec21e/Kqpq70SoXKRNzl/M
 QljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748475045; x=1749079845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwBS5hgd6WP1QOcRxAh1zyzUJYzPtZz4LVaBNyp9Iu4=;
 b=QpN31Jq0HrUO3wlxs5/inAcpeH8ktZVgir1op5+PB7HGffE9ZadCcaf83BisFT+ED9
 1CZAayKyNzP33RmUM7pWnfanZrZrUhzRtoLLmycxplEtzBIjOCz/+giV54Ie396UgCWf
 ulAvbd4w/NClFojgrwBpk3zTI04L1IPFoyqU4nWh3QDAAl/BcqWzIOBeSCdWLammySEq
 AFtbc3BWKJt2KtHW4MvJOPXFzniqHNRfyoPlj/8Ow7smP1dWH3COUQIjol2FJzWbMrGF
 YTPS+D7xxogmD7FksTIKjQ2CITM1gf6HSSf1QB257qHB7XP6OHVK9sGdrofdeYoSSB1k
 lpDA==
X-Gm-Message-State: AOJu0YzZIXyTnJHWzaWT/zRgVAxN1yPT8hP62P58vFa6XCRrvYtbMefe
 3cTKvVBAp22ACFLhrnvdnI8wWMlnH0iaVU2kPgEQlXwz6CnVwvA47vJM+FMRHTWGfst7U74xTh1
 1Fp4U8YM=
X-Gm-Gg: ASbGncuTtZ4c6WdNkL5e7aa3404LAQUDVBYQKLz9tAagHOC0UIVfDD2+jBZeqGD+LAj
 dmtHW8/+lJYEJGB9+pCbjN0ZYz8Vlr2WuCwA3Sw3DOuaeIjoCQMtNterxnYnfZQskzavchO3WHR
 gJPsdzyfzFXrf05Hf+ZEe24oBvRQTy7m21Y87fYrQccVtO1BWChrMLX8qsQYl6VH/Y5+1xRp/y8
 +KoUVPCpnZoZOXmf0uiqSshAhGvM1WppUvtSKm8vxuep4ypviGBO/obyX1wa155y2dUtwplbn4w
 BFx0Bu5MmOaJ/FdVq4TpEox5Cx/xnqkH0/vpFMlLj4P9fV0HPvkE44uf0a87b1K16UsVaPJXoxG
 FSaXiaRhloLzWkfVl9XWbNmVdCw==
X-Google-Smtp-Source: AGHT+IGadM0BAI21we44oWmyBSe+5ukMAJWH8MzSHBcdsb4jpeHWNeu5ytR4tF9GmP+pfKv5YBNiFw==
X-Received: by 2002:ad4:5c83:0:b0:6fa:c6ed:dc84 with SMTP id
 6a1803df08f44-6fac843097emr1878876d6.23.1748475044780; 
 Wed, 28 May 2025 16:30:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d5b3e7sm1794846d6.61.2025.05.28.16.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 16:30:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: update ABI reference version in example
Date: Wed, 28 May 2025 16:30:41 -0700
Message-ID: <20250528233041.200373-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The example should list current ABI reference version.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 8ad6b6e715..fc9844242e 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -539,7 +539,7 @@ to a different location.
 
 Sample::
 
-   DPDK_ABI_REF_VERSION=v19.11 DPDK_ABI_REF_DIR=/tmp ./devtools/test-meson-builds.sh
+   DPDK_ABI_REF_VERSION=v24.11 DPDK_ABI_REF_DIR=/tmp ./devtools/test-meson-builds.sh
 
 
 Sending Patches
-- 
2.47.2

