Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBFC55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6579540B8D;
	Mon,  3 Aug 2026 18:53:30 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1119C40A6E
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:23 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cea3004256so40026705ad.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776002;
 x=1786380802; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=uPKNWIz0VR4FQR48l+4CqamUdZQTfwh0J370up8s6EkdJQJCJjsLmjfl82syZ78prN
 acwwJnh8mR0n4sq5fXRrr9lwcYgd/4lvP/Zq7VG+HDxHMPtrUlCyKRFjrh/hVlNPfwRT
 IXF/zBo3S5Eo8G4x7uxRR14W1kRFk/NmqrUCRRkxJevyJvGxB90BPLa9UHkzINdWNahr
 AyF5M+ZvLHRTXN/dSXgXhdu8+J2cmRFSfRNbo0wVD8losxKuAiajROBcgK7w9ZPtcxNL
 Z784aYnnOACS8dGCHhXoLA6CK/bLJLeCsfl0TKgl9OVNR9aMJ6Df3ddrfjKdM3xFEAiM
 sQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776002; x=1786380802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=rjayA4c71udndmetAwRGgIN4CdqiHvxAuJn84I/tKgElpGY5p9ImekEARq+3arkRg+
 pm1s0YuU+W1nGieyNaD9lfEWP0mPDYwbJrTOWFuAo9b0/F1E3VqIHclZWbYlkG8bsnlR
 6JuN8xn3ac3aIKOZ2ia2BvfnzmFhU/CTB3ATlt2LKtqwzlxOgD4eSG4nafd+wDb+RW44
 bejUzXdutZPNs+8pGmsAxWvuD6KO7+gIkCvqvaBFOubD+kMk8+c6mMeyhEolcDfbawsa
 4fdy9i1d4cW/6+wl3+LwlLWMbXOFU680tLfC/OHMfHKHS9Tu8zvpHIaxcY6gxWOwyay4
 6ebA==
X-Gm-Message-State: AOJu0YxnZY3TxxiUctEFxscNBWBScdUzRiFlYLSOv+fQYmJbt+sCgwKH
 qSjyKsokI2kDKie1Rrw9gUXPqgcHX5VdP08jBfKOUiFCk7TJ6IZANISoVw71xpE/d8w1fsXsuSy
 +yhHa
X-Gm-Gg: AR+sD10rFlTLrNgHDtHUkmuTsh5D86ZcwI7Mf877dvZnuLFBwf3tJiq+3/aXltuQotd
 6FQ+nLw9XYxZFWi4IsTkh2QYmZ8aeOsHpvCFO8fNZw8U1EQq04VnE04c47XfXn1pc/apPT+jFDu
 wYs4v6wi0iOdda30Yl6moeHD91cPJ2HFB6W8nIwZofIZ65BizTlMWz3JGuWQD00EUdQrBfBsMpU
 DOdlWAdQ9E3YEqF9qgi07mz7xHDc2v0zOPgLCtnV+SZUHhO84rlaGB9AkYOjsTawdfrvXaWYIyX
 qA35eDQ7DAq7zGm+FjD54T3xkptnMGLMhmAP3ZPrPpOs2zKHdeqKK8QU1jS+Y43uavAljGzXjQu
 xDybt2AjZrW94bq/xBF+hTb4n0h1wvWLIK7I4k2mRMYpJw4VproDhOe1AxlQNRn/P/psZuxygyH
 +ZO18XTPDxbjTb7196nHX8Nh1gkl+oS06NX/OH7esDmiUAMJHhn+MIBiAWSnab4A+fiGDUGcNGO
 Hzma/phuKLhPAf/px7mYA4BK98=
X-Received: by 2002:a17:902:cf09:b0:2cc:9179:32e with SMTP id
 d9443c01a7336-2d0521e90c3mr109895215ad.10.1785776002220; 
 Mon, 03 Aug 2026 09:53:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 15/22] net/ngbe: include network protocol headers
Date: Mon,  3 Aug 2026 09:52:01 -0700
Message-ID: <20260803165304.289869-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

Do not depend on network protocol headers getting included
via rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ngbe/ngbe_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a1389de9c0..fee984c396 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -11,6 +11,10 @@
 #include <rte_malloc.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "ngbe_logs.h"
 #include "base/ngbe.h"
-- 
2.53.0

