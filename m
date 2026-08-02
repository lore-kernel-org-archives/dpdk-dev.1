Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5474C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A49640DD1;
	Sun,  2 Aug 2026 20:19:08 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 87E234068A
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:59 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1574050a12.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694739;
 x=1786299539; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mO+u250G+8B/yANE8SIkiiBc4oJhSAu5OBnpvE1jzUw=;
 b=k0WS8CNXEIakpFiMx8NgviztZSoN6R94FrHGIC1reeij7C54Tma4YNJZNvcxmReyXN
 Bey7CFf7FqJwj9vPkWLEnUP8NLrk/VctFL7Zf49LoZ+AWiiDA9veX79pV6vnBLKdCgRh
 XEK3VfH+qlqZDIJX9sN+4vb9YxPWzl4j+7njCDy71R1rXojWrGrd0DE5hRvR4JCw1OmJ
 h+aSuBMXrw90RZmSENZAag1aiuSfKW2blarFL5toa2e5aYstwzGBx5ZWxK2/VjRPzlY1
 1P+RF3Z61eFhIKUtOEj7fqPekQtYRIdam19zpPp8NhREm8Mzl0tXP7vs2Uh4obobNhtl
 tjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694739; x=1786299539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mO+u250G+8B/yANE8SIkiiBc4oJhSAu5OBnpvE1jzUw=;
 b=KB4zAUIf/tEPjrlHh9C7D66o3EbUd8cQ4y+Gf1HzWaH1No4ejU90ivpPt/HFFLBJ2s
 KDPPyLvjDyN2hm4qrqs6LPVnhg0e+oUz2aA05s+1FjlqFpKm0Q8GAr1lOxR2J2L+pPyT
 Rbd08+uNip0eG70UbFYw0MIyJrJq+XAK4bxwtvbsSxEU4H/vUbBzUg67rDUmiGOz4z9b
 6Xz6DR0PWsEl8NCoIpefB7tBun+o4MzcE6iThiafpzvG2+eqDbELFijQ35m+73y5RRt5
 Yxao7y3VVswhU85U4uBEPVi4u5SnEbfhesad3sQKTwnDO8IorS6GiYudWj9s2jT4c5jo
 kAhg==
X-Gm-Message-State: AOJu0YzYmT1ip6oSCrcul2TXm2vf5biqIlBigT0UYjxn5YDDBKkH+M7a
 3tAEywS6vVF+kDaB3qCWYspNLL4sN8Nl6weW+3n300SafuI2zNO7aXsn+GoLTf9xg97Gyz5TD6i
 UCH9x
X-Gm-Gg: AR+sD13kUIErcdaDn8MjWpAB75ozwCNALacR4ujHMitld1nAY8UzFnqVqWh/aHbePsy
 A3UX2Sf9JdAWnIMIzJ8atozR/FJ8w4JS/H4Hwakjvp/Q+GzQJAH2oZ/763v2yT2u0WpPGNu2vpY
 9kR62ZJ1ghkA3Wbo7YsgeT6AEZgZvCmEFTPnjzSVMRhMMmvC/r5i9iomVXsBAHqaUxQDN4fMvD4
 +WPwdOKRzGJUt+jC1IyIhxBEpRAFiE6zrUrVv6ETYiXVodg51Ln9+LqsJW/XQC0jQy6q2QlUaLm
 ljxxVjLFUuHedLi+hqkhNEwyT0/Xr87fxQE7ZHsA5Zefs164p+z6Eg+S39yDrBuvT0OWlTBbZwp
 NrUCDDlMigVIvLGDrT+Wzd3YaPkvhMOnGhTqrzLs4XaInO39LN7Xaucum1qwqyf7b7h5L/TXbXQ
 /G95R1a5wd//EjJRuoJ4iy1bA00MPm9QLdradcUE1zOBCdUFtbKBvLRs17by1TvlPj9O+wVbEY6
 GSW4ehvHi4HzpHa+qF7pDFotmA=
X-Received: by 2002:a05:6a21:600c:b0:3c4:13c:2ed3 with SMTP id
 adf61e73a8af0-3c92a89205emr7166601637.69.1785694738702; 
 Sun, 02 Aug 2026 11:18:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 19/21] net/intel: include network headers
Date: Sun,  2 Aug 2026 11:15:24 -0700
Message-ID: <20260802181835.476887-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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
included via rte_ethdev.h -> rte_flow.h

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

