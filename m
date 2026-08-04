Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C251DC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7990C40685;
	Tue,  4 Aug 2026 17:46:01 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 5D67140647
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:45:59 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so4603788a91.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858358;
 x=1786463158; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SEd10dZejZ4JZxUwmdm9mOezE2U4jT3yrs4Cg2ehgg=;
 b=fanofMbilkaQskf97JG7xNdQH/IbTxlblozi1NZTpg54yfCJIUE1D6ZiIXsI9mPdOP
 pK+/Q4DVScw1HFVN8xIsvjo4B/KlMXAEObEBim4OnaQsUwflaUUupyAp2VnvMg+jLMbG
 2FQtQcIHJboUU3Tmi4H2MnN8jzBN2juVs/mjtGU3N7wYYYYT9HL6sDHWADSfzUGRVqxq
 s3cF3jR0TQWRQdRKrHl7kke2uK4k9/2m9orLCGvOhDg24Ot5CP14XfTW0LbSvTeZ8Apr
 09l4JLsWLyqfUhjSY4X6ie3HCntoHCiRL5UUwlxnIERxCcc2IxdpueiMPNLrP6fWWTe5
 QJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858358; x=1786463158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SEd10dZejZ4JZxUwmdm9mOezE2U4jT3yrs4Cg2ehgg=;
 b=Hj2rDHdXvo5ikHGufO/kgXIF4D3hvuIyTUChKWSMW56rHk6P8AeTG0cORU+v4scEVn
 m0WhsfjINh4KbUQTmdGalUdMf9MTb0BV9dBSraf6VrEj3mUslzUn8NMcgm20pDgfVd1h
 zXiOY0/l8bSI5ySEK6umlCt2Uous8hIubUfYm1Ji0Ii1enbBYCXjtSsVwDTvlKM6mfGh
 45ihtfyYSeXB2TCf7M5LH/9IQdtG8xpsU4u53N7ot/vEWxLj8RZJE7iICLD1bK93CBHx
 E5fnno40EBdnNZqVeeowChbok+GEzZXRazgo+cJ/bwqo68Mz1LNome5zkcyqRiDuEZCa
 uQdg==
X-Gm-Message-State: AOJu0YwEh/TfaE1Tv3QYo0SiDQ7Ebfci6AYz+aDTfEUS7lPxEIcKqb5K
 RpUfYv8VHUXxP4j3inR4tqNC5SnkxwKs4SJhlbA2C/6AXmrL2o1eeYHqnFRu0kX5WXQ3vE64On2
 JofUD
X-Gm-Gg: AR+sD11CymhEqpEXHhaZrv50r/dn02U8Q10G1P3EU8/mbmtyIYad+LgyFaGAgdHmD/e
 6sujS/ZXUbLiRivZTxnRtAGZ6jtDf4jpLTiuBtib0iGEkcRMFAQEf5PcKvSkZWvkLUc0cNmgcIQ
 DIXPlwJpaOh/iOT1Ni0DXB6eQ5pjUOKCd6EsMNNbAYsXGFGHoOd3UJlGGOD5EBplxE2wdn6GvXm
 WMuIaY5TIaRQzJ+GE9rvqEPJNL6jkEux5a2iDakNGRhwaO+SdGesKz2wf/pPr5NmZ4ZjOfGMW8g
 J4XiikZCulzRNy7GPmORA+7R0l/6dTPiDyf8MNKsjL2ShvKSDKeQnPD4aSnu2xfzRHTrsPU07BG
 A1xHinFphlGUdXanoDVqwB1K+dviLuwrDhEQIJg3vgEggobAahfjVRac8u1NEhd8lmt/CwDEm3k
 KT234gXRsaJcVnatTcB6vvgi6NpT5PzDAOUhfyZchn6OdRuMzi96fwNnsq+xc7TUuyBvljW16rI
 kHVCm5K5d4JbG367CMD/+Kz0GY=
X-Received: by 2002:a17:903:1b43:b0:2ca:d658:d874 with SMTP id
 d9443c01a7336-2d0523f9f93mr155517845ad.23.1785858358528; 
 Tue, 04 Aug 2026 08:45:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:45:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 02/23] ethdev: use DPDK byte order conversion
Date: Tue,  4 Aug 2026 08:44:50 -0700
Message-ID: <20260804154549.148691-3-stephen@networkplumber.org>
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

DPDK has its own byte order macros which are preferred
over the POSIX/libc ones in arpa/inet.h
This resolves issue where this code was inheriting the
inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/sff_8472.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..acbbcee210 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <rte_byteorder.h>
 
 #include "sff_common.h"
 
@@ -176,7 +177,7 @@ static float befloattoh(const uint32_t *source)
 		float dst;
 	} converter;
 
-	converter.src = ntohl(*source);
+	converter.src = rte_be_to_cpu_32(*source);
 	return converter.dst;
 }
 
-- 
2.53.0

