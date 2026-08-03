Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A49C55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9CC340A87;
	Mon,  3 Aug 2026 18:53:27 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1A63C402D0
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:21 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so91399b3a.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776000;
 x=1786380800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=ZjRypAJpIWOVKoB2WZTiwBATTgtgJ3jxtvwalYkySwH2Erz5uT3nAcgcCCad40esAZ
 pK8Vxn+PEPyFl2CBkwxYxwhZM1c8B2mQlV7Cqyt6D9pdHryPw5Fv1n9O86XUyA6WKRYR
 a9f2lsnFKSfAzDlP9lZ5qalPRhWpA9Nf24nXQwFlwdX+IsqcsgSr+YSEro9lMQRPq49R
 fr9J/3UujADPPdrhPt8nLvISNBbx/4RiBnEIyRJlfANYuhSFJwagQw2rDhuZnK1lY9rw
 v+PGEDD3ymPoAufx5jPc4GqBcwpVu1UJce/hgZ18hW9NOHnV/6O30k7JQQzLcWwBAUHF
 DVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776000; x=1786380800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=bzPIvr1IRLDHybawKBBxWUaEUvSTZEj1b+Mi8qAMRGA1h2DGf5kRroK2c+CWxV9gG4
 W+/67S2rpA2v2Y4MIfxzTxyjUk6KC7T/RvktGafV8RQPlE9gRkxrKDRsg7RsUtU6I7Vh
 870Wk3K+vPb3syXaA0NiF/k1hkUhShfe2PwosCg3eV7uYO9izZfqidxxYgCzZSQQoGZD
 WfKckHY7lwTQxizunzbcIBsn+GRiOWynnUqJgHBjMIyY74+hjot3mIsWT+0xzHnKBjW+
 gODYLGCbh3lsc2Aq7qCVujZXgF8TkNPg+ZNUkoYKLV+px8xbjZX8v2zv8gGNWGAmwMfm
 ITKQ==
X-Gm-Message-State: AOJu0Yzsj2Ga3r5YqknrKC99yjdtGq15LVznF2HTnccmKPXZO2+Fc0YP
 vXxPXTG0S46cc4m3bnDaWrKXNw6wQ3IQ2lbhm0iv6vGCjgBKbIbHWQHlYlPLpd++IDAzh830mfZ
 LdU/q
X-Gm-Gg: AR+sD12/ENQtxR0rigBY6ppj3sOBEODZF2W+5NHTOUoo67pbwydLdtc8raqUUFrj7Sq
 L3/WlgT6J24fL1SeEz/N9M+PyBkuobUI2Ot+KjL2zEJwrkl4phLuYithUZF65vhTvvtaMYlIjGj
 DRymTpvWD1VqLWinJ1UnG4pn3xbEQvrGeKMFIYMu8uZtCxwRihi8MuxInut9HpxTeWIKMAkOuWK
 IQk7KRIOlJo7QJmeyrJtQT2ZaOe0cmNQD3CBL4Alr3B+JKr07rVf/2PLthwMiUiZmaTzgRVfOev
 SqJ0xOyyylH0wl9jvJ0Qc7qFKdvw/lMnqf+tOTL7VDdpedAk6Ce1Ew97Ulg2MutuS9pAKshX/Yh
 0x8rrTpYBaE4GG7CUg9YiPgYTxmkC3WPFlmGqDZeZ5poBpdcR6VhhCSFrOhs+Yj25//RUIdBsLr
 fAfkuypEtQ25uw5W9HCmv45RaG+RoRFXCMAENRQmUqd7sReD+0jXQz92OH6OPhe3oD6Uq5IOWAL
 sHm7qKoxZE2nKh5VBgPxkQVGNU=
X-Received: by 2002:a05:6a20:9e47:b0:3c0:b598:4983 with SMTP id
 adf61e73a8af0-3cb6ca54d23mr299077637.30.1785776000204; 
 Mon, 03 Aug 2026 09:53:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v2 13/22] net/rnp: include network headers
Date: Mon,  3 Aug 2026 09:51:59 -0700
Message-ID: <20260803165304.289869-14-stephen@networkplumber.org>
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

The driver was getting definition of standard network protocol
headers indirectly from rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/rnp_rxtx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 81e8c6ba44..93a3372e5a 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -8,6 +8,12 @@
 #include <rte_memzone.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
+#include <rte_gre.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "base/rnp_bdq_if.h"
 #include "base/rnp_dma_regs.h"
-- 
2.53.0

