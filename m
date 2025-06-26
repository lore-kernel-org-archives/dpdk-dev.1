Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A8AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9E084025D;
	Thu, 26 Jun 2025 15:54:09 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 841AD40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:54:08 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b34a71d9208so726310a12.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946047;
 x=1751550847; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/ppp2CjZ/QXIq6P577Z8qwmhMJFKLaWb7lNCIcSnEA=;
 b=mjVNdrbJfIZXz4uPQoKvzCHCcPY9rwukFnBcbWH9iDAA+dPRtFOeKwC4DDSWaDTf1c
 bcdLRxz3C5PIOiaeJHsMkLebMWeMo2GQI/SsGlrCyjM94FdQJtFPLmGqrLloXfWIjIOi
 YP18Re9vGxjfLyTE/LS0IC/Zwsxs2dSNkeQl56dzjCkbqPtyvc3YxEklMI1ysrDVHwya
 0Qfx78WeeD4dSxFkhbxtAs2l8HzOQVeebZ+syb0LhDN0uXtuQ8uxmNi8TeZO23/fuMvP
 /NmkXSIaNQt4kt+V+2yRqFRGRhvTIl8M3wZTFolRusLK3xsgQTE6QrwJGQEe9f/cbzPK
 fqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750946047; x=1751550847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/ppp2CjZ/QXIq6P577Z8qwmhMJFKLaWb7lNCIcSnEA=;
 b=O7hHC5bnWC9Qb2nSoR3NmXKg50bbkvclR+1YGHaIXLAACNDJn1Pb+q+Gp7Kucw8vN7
 Yr2hT8oi6rzZsu+Mp7efLaH9s7ldR5tIo+65NGraMTBq9/7qdMPg2YZ/LLzqNvCLJqF0
 HdvqprWMQ90O42624xacI2uIxL+74Cdh0fUqNpMOJWvWqohEZsVt1mw5e/f49kvCBcd1
 q+OLAaKDvfADOwHV2V4kORCtM7zpb4+ZUT+IfnGJUVayKqsJtAkrrUpyl1R4NPaXGuZP
 xEaejbkshgjrB+WNPYJJ1Gp7zPD8RumYfe2Maii4sItiYKktKZyFPBLSyS52FbsVhlNR
 9NJA==
X-Gm-Message-State: AOJu0Ywp+1SY1Wmi+g1gNMJ5OCbdPf7gl2pDStHDV3sU5QxYoIsgpjBX
 WCrYtCz4xv1q0Rq9xIKujClyM+3+JOHUNY1pbqBgrp0mkRzH5BJRfEhh06l4IylPbyb7HE9lzhO
 u1XM7
X-Gm-Gg: ASbGncsC/xaBR9E5grGUke4WLZ+3bYgrC/ZU0xBIEyok7AnJLOSotPz8DRh/APPslRw
 5mNpU2sDKWnPFw+/BcZAorAHFsx0Vvpg40fBNaRlFnhjo5lA/6arwbATFhwLFZcbRk3oSKPYieA
 Hr+Ep3Sx6L84A/K9Hx+N4gWeirtyJpSsgMZj56pgdSzW4KvZCtSm4HkNE08c0qLJICD0ENm0rBQ
 NKgAkoQPXTyrsry8HibXwi9JTxD4Fk+oTaEwCP4t2OthIc880RkcANvMsQ2IVpag2/vuySm6M1B
 pI+6eF8ggKOZUzzLGW16y1yaoGdeJ0fEnnxU4cRwsVJUKA5VTlMdOereCEwnOMu4jLIBOpWdYU/
 kgfuc1kx+r7s1LRuQFUJiToe4TCbC7aH+ZDrYkCq5HzMgxus=
X-Google-Smtp-Source: AGHT+IFL6Xr31DOornv9EbziLsUQlwc+QRelnYPsNUZxlWHi/UXIUi9yvlf6k/WoJ8IlTLN6AwufwQ==
X-Received: by 2002:a05:6a21:680b:b0:220:4750:133a with SMTP id
 adf61e73a8af0-2207f2eb266mr9991299637.25.1750946047493; 
 Thu, 26 Jun 2025 06:54:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8854935sm7552530b3a.137.2025.06.26.06.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:54:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 z30015464 <zhongxuan2@huawei.com>, nikolay@cumulusnetworks.com
Subject: [PATCH iproute2] bond: fix stack smash in xstats
Date: Thu, 26 Jun 2025 06:53:55 -0700
Message-ID: <20250626135405.39274-1-stephen@networkplumber.org>
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

Building with stack smashing detection finds an off by one
in the bond xstats attribute parsing.

$ ip link xstats type bond dev bond0
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
bond0
                    LACPDU Rx 0
                    LACPDU Tx 0
                    LACPDU Unknown type Rx 0
                    LACPDU Illegal Rx 0
                    Marker Rx 0
                    Marker Tx 0
                    Marker response Rx 0
                    Marker response Tx 0
                    Marker unknown type Rx 0
*** stack smashing detected ***: terminated

Program received signal SIGABRT, Aborted.

Reported-by: z30015464 <zhongxuan2@huawei.com>
Fixes: 440c5075d662 ("ip: bond: add xstats support")
Cc: nikolay@cumulusnetworks.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink_bond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..62dd907c 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -852,7 +852,7 @@ static void bond_print_stats_attr(struct rtattr *attr, int ifindex)
 	const char *ifname = "";
 	int rem;
 
-	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX+1, RTA_DATA(attr),
+	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX, RTA_DATA(attr),
 	RTA_PAYLOAD(attr));
 	if (!bondtb[LINK_XSTATS_TYPE_BOND])
 		return;
-- 
2.47.2

