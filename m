Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD7C55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D2940E13;
	Tue,  4 Aug 2026 17:46:23 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 074DD40679
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:21 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so79605ad.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858380;
 x=1786463180; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Go3XJW5+Jl51o1tcrhS4oxtPg+y24Hoca0TlixUZ318=;
 b=cPQOVLYYLQpiL2tA4MnDpYhYP/RsK2R295n0XjDiKtcrPXzK/K5x9RtMK86g7n2fOI
 3ere/V4oUD/ETW+JU2JEQKcgMWPbvL61vhwL/RFMnciu1Sc3Y6l1FeAI/5XdjRLnGrsO
 V8mcZo7qS+b/4Ww5pYUkSc/6/25oUHsBGw5zOKWgj1OfuvoI4W+ulfXSi0UFWoffUz0B
 xO1kSHY1r5yPG2+/7PPwdSGPX+4F1E6v+OocTfGbrVo4d1LxBiTOSZGgfocRvGCtTQUr
 fcQRBVgXwYZg4YyGhQm+7U8V0bN0y3xDHvgXAoVbn4CWCmScpm86fU5nKHhmzAGIU/0t
 D/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858380; x=1786463180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go3XJW5+Jl51o1tcrhS4oxtPg+y24Hoca0TlixUZ318=;
 b=k0jIVVPJBobowP5lP5cwIh9E5a/NZ4pcSeVk3pUMUT7oz5vCX/5PmgpFyEXLSyCMbh
 T37Sz2w0v3v2XsyyTD6abKqA/7JjyqGiRXJQ0d18wek8YhoUB0VFrFgVlZRHOXGLP4cz
 5WnIuOJ5QO7sDmacwgrgQjB5/S+tthiTCfl26ezYu5h2sRqPLeFhstzWhvS4pDlueODR
 UORNQF0/NiLu2Pucn46+UFhUUR/X5yLhLGiFXuGbvSiqezQ+jIQUm1y35i4fskFVdTkB
 3iRt6yrdALgA4jSgtnoor2zCRh0/TLqMgVY/XkmGNyU5IFiBYSo8nluzy/i0prIXCDze
 M0jg==
X-Gm-Message-State: AOJu0YxilUPrP2ksBvtRHpNSwMpxmKRoJl9nbn2gaEDeh18I6EDZNWLy
 Hg+gAubp0azPvxG13/kFVbifr2pJhWMIE/ga98UNX19SBzVAkK14Wcmti5MkY4tXL0qkQBw2Psd
 ucNLB
X-Gm-Gg: AR+sD13X5f0QBE1p1srOj20Z11VuTpV1v7WAp7FSZAbApbkDwAqjoH/7+xaYF0/5/n4
 dvv+6owZr/HuxY0t/G2Q8dLzWhKI12qPovAsO+n+Cwg/HuP8TQd7hefGygGXsuUJ5BzkV/k4Uox
 WqgVXGTPHZi+EMuuKuGOEjf4tir9J2fNpDqdSdj87Cc07p6Nk3frHtYRstg4fu7lOWKRnpT/UPe
 UnDXdEvgikiSkX+bjy7bqlz2z7Vhd33XQ86dnWDfrypryLxExrrhWV/kvfN1zfu5dXCH2uKjWv6
 UUCSmflSWAqxDpbEmWQ/iHj9Nymn6B0FJJzqpFkxAujqWULQqD8jW7ejwRd524nOpuvGYEf+77A
 63QqYYMvZODNbOYlUf2HZPCBfL77U/wOw9CNbefcG2Jq3OuQbSi7SGHCxV5j0hcokuYnS17d2RX
 URpEg0Qt58zu/j7wsndzckLQ9RQE2FF7PBAdjvMg9HCEnHQJecJ3XKqsAq3I2UluubvPngjGpjY
 4RAsRidljcYfiJOsdekrCTP6bE=
X-Received: by 2002:a17:903:32cf:b0:2cf:1536:3d41 with SMTP id
 d9443c01a7336-2d052411e61mr143522405ad.28.1785858380194; 
 Tue, 04 Aug 2026 08:46:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Apeksha Gupta <apeksha.gupta@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 21/23] net/enetfec: add missing sys/types.h include
Date: Tue,  4 Aug 2026 08:45:09 -0700
Message-ID: <20260804154549.148691-22-stephen@networkplumber.org>
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

The enet_regs.h header uses BSD types 'uint' and 'ushort' which
were previously available through indirect inclusion via:
  rte_ethdev.h -> rte_flow.h -> rte_ip.h -> rte_ip[46].h -> sys/types.h

After changes to reduce rte_ethdev.h header dependencies, this
indirect inclusion no longer occurs, causing build failures on
PowerPC.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetfec/enet_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/enetfec/enet_regs.h b/drivers/net/enetfec/enet_regs.h
index c9400957f8..a834fa5889 100644
--- a/drivers/net/enetfec/enet_regs.h
+++ b/drivers/net/enetfec/enet_regs.h
@@ -5,6 +5,8 @@
 #ifndef __ENETFEC_REGS_H
 #define __ENETFEC_REGS_H
 
+#include <sys/types.h>
+
 /* Ethernet receive use control and status of buffer descriptor
  */
 #define RX_BD_TR	((ushort)0x0001) /* Truncated */
-- 
2.53.0

