Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70319C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29E8A40613;
	Thu, 13 Feb 2025 22:22:09 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id E84C7402F0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:06 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso31550235ad.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481726;
 x=1740086526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NE6zl8XsJ9Mi4v6+xHRRaeLGuAW7qv3igvxwRXR74us=;
 b=1FzD1BYwGVTnhmavJs2p1Gpvy18/Klv1rWqcN2/mN08C7Jq0zR65pCWdFtt+M/8PFL
 ilQBuO1WNr5i3ZGq5vH8jbqALxBfCcWxYhPAv3rsKL3tjQH1yCZKoySB0cBrpR0r7kGd
 wRGg8FOnMOfS+IuIRa7tjk5ZtLfpxUmdbxvtVR3u7bhINtFDLE0iml3iWa75c8sX2PaW
 e+aV9tVrdiTA2ohhO5/Nozwza1yWazSkhL9x+pBY51y/WUb/TqHIoPiTGphsVomawBve
 IqO4q4BWgY1I+Isc/CkV9VeefWZ14mk37n2SlJjwMZ+z6xuW1l9MedHtsBRWNFRRKmUJ
 mdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481726; x=1740086526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NE6zl8XsJ9Mi4v6+xHRRaeLGuAW7qv3igvxwRXR74us=;
 b=A6o7S52SYIvcxP8aP6JUPwdyUQbzTEdUI5z8XztosZRdz1tS8gGLIyV4oOiUxVsY/V
 gIz0JVnT4reEFRI6aWPsnQX1NmMCP+NralPqTJFzRw4bDp/VZlH/+eBWich4xD0yTvGH
 NjSREv0s45CW3qgotugD4Wo/3OW22zZxO0V1AlKt8ZkqTutfUx8WnYvUwkeMycQOIQWl
 SYSe0lo5PQEydc68gT9tbIHLCkp1QvKRdMMzuHa6/LqWLbllVaNgHBBkLlV74ZaePXP7
 tDyvW5pXy6WjmHLxQ8ozuYQ127fQkNgHH88LB1nYh36d+deTbwLD8r28yKeEv458fzGs
 qbKw==
X-Gm-Message-State: AOJu0YxfSoftTFkZDl2Z3dpBYupC300K4mkoekkK5WadpEXm40u7BlGu
 A44rGqnMJ8/k0EY74ovYDRP8hKqV+wchBpUSeypD0F98XJFeJJFQHzGR0O+3mD5ve8WmX9BuUpG
 6
X-Gm-Gg: ASbGncuic1qO65lC9MUE/j7cdSdOSQswLDTfnmADFCn5SJ8thgO5jlKXgoFSVMOQl7u
 /7kKQlakTg51uCFnYf0Vhh6Tc+xp8zysEJpgetyF3mx1SXRYiz89KDXnyhzUbCYp5U1wEFoTQ1J
 b4v1c//pw5BrBM9AIFiSXgzosGLqrnpi7j381bldqqbVYrR7mmggHGsv0ndcBraAcxJMP9OSpy9
 OZAE7H+Se3doMQKRJ3jcaIw5oOF1gpm/K+ZKG5j79oWHWBBb1qKG6AkiRNoCdkTNKzXQOq+L1l0
 i86vSPdatPw8I20y1Acn4zTq4qLpZ3gbF00GLNrB0AxfCJIUfuHyPVxbcm8LucEJjAG2
X-Google-Smtp-Source: AGHT+IH77qgWKF3Nq2LjU8LCAdDaCkaIDeLVTRZSAWn8GMTr8X7V+wxzmLk7e1LR6hUIb1XFFfeq4Q==
X-Received: by 2002:a05:6a21:e8e:b0:1ee:40e2:8f51 with SMTP id
 adf61e73a8af0-1ee6b4459b1mr8659050637.42.1739481726119; 
 Thu, 13 Feb 2025 13:22:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 4/7] latencystats: update include files
Date: Thu, 13 Feb 2025 13:20:33 -0800
Message-ID: <20250213212151.1693506-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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

Include what is used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 82c310da92..b990e5760f 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -2,17 +2,26 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <errno.h>
 #include <math.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
 
 #include <rte_common.h>
-#include <rte_string_fns.h>
-#include <rte_mbuf_dyn.h>
-#include <rte_log.h>
 #include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
 #include <rte_ethdev.h>
-#include <rte_metrics.h>
-#include <rte_memzone.h>
 #include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
+#include <rte_memzone.h>
+#include <rte_metrics.h>
+#include <rte_spinlock.h>
+#include <rte_string_fns.h>
 
 #include "rte_latencystats.h"
 
-- 
2.47.2

