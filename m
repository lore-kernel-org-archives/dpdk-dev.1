Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634BC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53CA40E0C;
	Tue,  4 Aug 2026 17:46:20 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id E944240E0C
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:19 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so3696801a12.2
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858379;
 x=1786463179; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=Urj3mL3j1kMYJGy6dQXPHiNGGSDEtS/eB4sO3VqjxulNQVZ6R7InVrufuzAcnRS9Zc
 3IYfPPTcFnOMHSh3TQbko1kRT6s/dtYT2k97EICeOkUmpx3IU6pX0RTGN096SDqzdH1p
 OoJV9Wa+Fj3ABrjb374RWDxiMF4NfweAgRyHcO3wzrxlf+pPpXSAPnVADvLfrNIq01Bk
 z4zXVAg+TKgssc9eH0t9dhTvudDfdp1zTwITyR7f11u9Ua8ZgBvYcj5q3WhAxqUU72TP
 +E5PItxasYUEnIxrgCg0a61Zqhfn9dwoh86waJ0HF/KdWhTJhfYsfOsgb7GPvqkRnnVi
 9XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858379; x=1786463179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6oq+ryBB+5JHMFYgHEgTou6uBV3xjOuWGBVyTcYTjcc=;
 b=hN6QYOaRZGxKGZ1ifVHFIfB1zt4779iuads1KAA3wvE2hTc2x50BdFahaL4S+VY36d
 SRAecHS6vWMvB9DXYjgUOnIPDTPxpQUjdBLydpqNWJuU+vavHMcAn2YIU8jWJCyuVm11
 uVpi0fR6Pu24yEBKdPPtfu3u3soHx5AcXbHbAJzjc2vVIW3W0EtKExPF9zRZD3cyL0Wh
 DR2raDoJpynLqHXC82dRHRouCGYi6rC9TH8BM5Uk4QCK1e1r6kfXaqTenj7YAD3Z9jAb
 WLVEMbQVm2M7aahpVScg0xrgWjJO+Pz3uD5EGVkL6rBgICPZDTt0pM9e+aJ16MDejgLV
 kC7g==
X-Gm-Message-State: AOJu0YyGl/mCbkwKQpgYfHMq2kHtdX/hKXQvUEqTTYz1ZngwsDPPw6Oi
 pbfF7/ahO3vJa1kOhU4WdG7Z6CI02EAIBLbklBMxR4+qfzdApjNreGi0OI9RrlboqNwLIEYRnQq
 P1SqR
X-Gm-Gg: AR+sD11nlqCQo6mx0a+6nS8BY+RCzU6ILjM06iGCKm6XfFno9LJjCT7KSp9x//hIWsi
 o3XFPM+NrbQjQD76RugCydrFDZLVRlSGtI9pI4rNvXXlTjQueQUOceq02FNaMcau3t48Iykh1u7
 +dEPXKx1q2S2AnPXzYOfWUHwvtW4DAkxL2dVcCKdGmvUk3AENwjzcbQDg0xuVZgQzpyrdgreuKM
 loOeUcQ+lt8HrHXEHroxf/vMtOflhwN9p5hmDGgr9VZTYpzbqr5PS1sv6/wxQwnEGPNIVWqdIt1
 oMB1TPJzrtiUVw85oaKbVDLYp4A9047JUUGGEsZcRDsFwAU4RswhgIwkitge+XLchcvNTYku2W4
 40gsUqV2fbPwqW79iURVF+YDuStewei08DQb1ttA7BWKFWFAGlfsHXZ7TkNnkREotijgbWZqmi5
 XFwR1fGAyAZSPpL4VecgQFEypCnhq1Zxjju8cDZfZOnP4oUORCfIaF15MKtwpQXUbc+C+lpxArw
 w10sQGABbAe6jEqGphJxolEe2w=
X-Received: by 2002:a17:903:1850:b0:2cc:a977:4260 with SMTP id
 d9443c01a7336-2d0521eac6fmr165807975ad.21.1785858379065; 
 Tue, 04 Aug 2026 08:46:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 20/23] net/intel/common: include network headers
Date: Tue,  4 Aug 2026 08:45:08 -0700
Message-ID: <20260804154549.148691-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

This file was depending on network protocol headers getting
included via rte_ethdev.h -> rte_flow.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/common/tx_scalar.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 11ab6c08fc..dcb2ea5542 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -8,6 +8,9 @@
 #include <stdint.h>
 #include <rte_io.h>
 #include <rte_byteorder.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 /* depends on common Tx definitions. */
 #include "tx.h"
-- 
2.53.0

