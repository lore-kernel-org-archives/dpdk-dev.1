Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10456C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECBBF406B4;
	Thu, 20 Aug 2026 07:23:28 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id D0DDE4069F
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:27 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2234573a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203407;
 x=1787808207; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmJm0SnVO+p9PIoyWZ0Gg+zdgn06byUtmevKiazhJTI=;
 b=llZMEzaKAVaDg3uBWW5vadNlcMiBMEtFZr5rP/ruq3cQIdSjYiqlMHw9RRuTCm+rZ8
 FJ8QMQMANmyNjPKApe/9HjUz/pxOwapxNxR94PYg/2M1Ld02loxplSMDKw/g7yn3Do+w
 7olyUa5m+78BdUbmDjuwI3BkD7TJXWf30IeI5AQAqiNRkxJWnbWtdU6YyHz+6wWCK6Ka
 lJOz71E6bfpJlar30EqrB3FuPbKj7RbgDEYXw9o4xqY+6ZiPXxd6GfzP57fG9+MGI6EP
 OGkYneMwq0+O9DdsQEREQ0gW9D+0NUq0WaM0c3bzFHZaElqrDldcwLm/TMyYZ6iII3l3
 vsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203407; x=1787808207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EmJm0SnVO+p9PIoyWZ0Gg+zdgn06byUtmevKiazhJTI=;
 b=B2+CAp4wItNGpqZKnkxi7M9WMadI4dy+7KadPEKLRXLebscJNHh7bGGrwrfjiGtGvM
 kwjDimxMg7fBspkh23B7bBUEr77HN4Yz9OZwJxo3xBzhMVBUdmjK/dbq1VxqhOLyyk5T
 fEEVXsdzUia4mH/miNJsiSynrypR3lITIY2Egp3anzMttG4EnKCC3uEkGQ/ukpLmHLEF
 i8eqcuKW/iLy1IWmunYrNGPbnYrX9ISbeKDH/RRmBVUxl+aC/Z1UjFmROOBbooIoh2v7
 p6S7v/OuPHaxmTipFUjHFJMrwB6aDol+kthWM31MSroXrf1NbsgqACPvvwVIGyd/mCVP
 sk+A==
X-Gm-Message-State: AFuF++kDYuOttVWseyKQk80AJv1nsPbBeed0ltLIsmXMsTrXMtbYHHqJ
 ZYCC6QbAREFWUL8C2r4n5AJx1BGVaW3S9ojJwjVYPqhsjOcGLr39arjBmCn+bfhJnG+gddqbgeE
 kgJPS
X-Gm-Gg: AR+sD11wkilDFO8xhzStah0Zid8p8wwyKQeTY5ZkhNwdk3RS9T70hOya1/r/lMoHwnf
 F7dYHRBqCFm5z2Yg+h58BM59afo+zxZXaCdfyC+SCeInrj59xBWVBbw1LgBAJ57zmKmhu+JoJiz
 evqxtad8uqjkdgbJGNudiU8FeyxLiOjMmE1+LydM+1oD98nGfjz10Fh8WVcP2rZ7NXoJL8tP9gq
 YatrLlnxfGKPZFdLNZnY6WvhU5abN17mbLLuqXrVrjRA1D8Re0yKndiWMpyN4WxlqpnAwhVZLBV
 gTH7qk46iNQPAR/gBlaOvn1RNTBYjsnVpOFWYzdDcdYC9d/mWDIHQ4bSmZjaYW6xY3yHjV2i6n4
 40D0kdDFF5AePyH22YYen5+J/9K5cvQ/kab5cJD2NgwdhL0Ey2xFEncI6KLErj6N6NOFHDllpMd
 EEbV8k8LUbGEftxWmBffiFl52SxziD6AA5u9u51AaRwKA5L93uie/Qv5E8KEx1ZgMN0FnF5nsWa
 DfL7McTgERe6fix7VaMyDtCLmc=
X-Received: by 2002:a17:90b:4d0b:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3958127d8bdmr16886827a91.15.1787203406810; 
 Wed, 19 Aug 2026 22:23:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 06/61] acl: remove unnecessary include of rte_memcpy.h
Date: Wed, 19 Aug 2026 22:11:56 -0700
Message-ID: <20260820052251.1453273-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

rte_memcpy is no longer used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/acl/rte_acl_osdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/acl/rte_acl_osdep.h b/lib/acl/rte_acl_osdep.h
index b2c262dee7..48f29d895b 100644
--- a/lib/acl/rte_acl_osdep.h
+++ b/lib/acl/rte_acl_osdep.h
@@ -33,7 +33,6 @@
 #include <rte_vect.h>
 #include <rte_memory.h>
 #include <rte_log.h>
-#include <rte_memcpy.h>
 #include <rte_prefetch.h>
 #include <rte_byteorder.h>
 #include <rte_branch_prediction.h>
-- 
2.53.0

