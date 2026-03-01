Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF7EFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6D1040DF5;
	Sun,  1 Mar 2026 03:07:41 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7C55240DD2
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:39 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cb3dfb3461so334380585a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330859;
 x=1772935659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=1fhb53TQXvjh6GaOE036WaK/E531nERAmjQ4eRSdK2LH2rIy7P4Tlb4iwYtW79f4Oc
 F9b9pjW9IG9DI8IWc+bQgI2ucoEQzPzjtQDvn3EtZoVQMnUlOImUhCKQOIU+ey4yIzxR
 YnxzDYnJJHODo3GtVQmATnqmTWni0ufD1OxTD8jf+/W6pojSF3xE8j6GNwyuhjc7xOtP
 Xal1MCjfGt8y3t/4NV40uo54bseZBaK6GJBkRDMFcz77PO5YetDVbt6fPQggfm7lEWQU
 f/wxKc/YCnlfC3EgkycnmRQxVbGdwM+9ks0vi6ydxK6bTJX8uVtzAADtu12vITmpGkMI
 YQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330859; x=1772935659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=dr0ayT6CVkukt6PxxFt9wKCT403N6I0BrTrsIOxGynvdF1FBMoxiCT7pYa+FYYaIsV
 fTDv4C4MxtomvpvKKoCGWlUBnhaujuoTwUJaytljCH6CLfFKX+zGEwOErt1DI64tJDl5
 8Z4pnWCr1YjBq8dDgPUnJ1X+6JqUfojXRky68xkhm97QxbUdCaR0xdnRkm1GmCREViXq
 3/v+1/t2XBJX+DlgW6ScqA+/bgSgjLLINC6ogLC9bS4CO9n5DXNte0K5AKRafFB7M8Ke
 smMHQ7J5+3rFwuP+zyTXpxDhk9JyBD/8t42MMOGi3v1aLlOyuVHjf+EI2R+3YVhHiqGG
 xOVw==
X-Gm-Message-State: AOJu0Yz5t9YBCTlLJ8dxdYKLNSq2y7G4OxBZExMCan8TcbmBMkxV0ykq
 dURQXdZPBNXgMFpKMSrBZ+egkpaj1TePTedcaaJrjijK7JAirKOlLJ3/l+qNYI2ieReS8NVyTnt
 kpaoj
X-Gm-Gg: ATEYQzwByqpCyxXucA5AWaRjaE9vBCo5EGLucW4w47PvQyo8KRKAU/nr620EijeAvXi
 uLrc5B13Q7Nm8Sze7kKTMhynD19Qu5mUhgDda2FE/9joSk4QZixm9o2HDDxuPWbiP0Qsx10gemI
 F/l9gvMGi6jh1IfVF/Q+B8+RWPcfBeoUVsNfFWpd2BCtciBjKh5eSxpyBMB6Eh1hKPf4LPTiW5F
 IJufT4yNWmsAWuQafwhZhJuTRn9Bv3QSz1M9vfSmfqvVEM0OrrgtEL4e2j0X0PeeZhDoWylUR60
 5XB5YvTgmUs2w0MBzKMLH6iFwsaTOTCWAx4LmhrjHm4K/6s/uH8+a/5j+SuRnvVrQdBVp5dCE8D
 bBbrk+bo5TAci6qx0qYWqofjPHOlQoJEFJL7Z/+c4c1CVKQaQs+V9DI0gP651rHnEYe2GriiOBP
 dXspuUw7ohJneRnEjdeFh+2zQXA3odbA6aHJfVQl6A3GE8cqlAvts0KTQ8K22JCw==
X-Received: by 2002:a05:620a:25cb:b0:8cb:4f63:dac9 with SMTP id
 af79cd13be357-8cbc8d70e6dmr986325785a.17.1772330858736; 
 Sat, 28 Feb 2026 18:07:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 04/23] net/pcap: include used headers
Date: Sat, 28 Feb 2026 18:05:37 -0800
Message-ID: <20260301020726.852401-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Include the used headers instead of relying on getting
the headers indirectly through other headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++++++-
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..4513d46d61 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,23 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-
+#include <inttypes.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
 #include <pcap.h>
 
 #include <rte_cycles.h>
+#include <rte_ring.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..a0e2b5ace9 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -6,6 +6,7 @@
 #define _RTE_PCAP_OSDEP_
 
 #include <rte_ether.h>
+#include <rte_log.h>
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
-- 
2.51.0

