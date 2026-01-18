Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F11C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817224278B;
	Sun, 18 Jan 2026 20:14:08 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id CEA1040EE1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:06 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso477167766b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763646;
 x=1769368446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3KemciKjBZJeUUvnYcifZjDKmIGa29WVYs/Yim8M+k=;
 b=TmF0WDs800F6eXu87eOVoXVOkFcFrrExCp6ESQWwC/RJJ+SpWs4B7sZBecrr+ltTg9
 wbZxzyd6TmToBDX1btYZ6IdMdcAuzl/qxNOm3VqGUFgrqeRLHKw/E1EQkYwZEqlirfpQ
 yDyFvnOVxubalyJUUhe4IsBIOZICcSHucMdQLY3CISAw/gFQMhTh4dXfqNfEY/vAc0Fi
 DpgUSy97BjorRiXBwHjU1yUjL9/0vucEImCKTRLFudSbR9y9g0CkZaV+h+l/Cq3T/xAo
 Q/Nk368bcRX75ueOcuC/2pFWkCWf5ivQklU3clVjaShNV/kafM8xeOH8lsbAcMLSxVod
 oRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763646; x=1769368446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3KemciKjBZJeUUvnYcifZjDKmIGa29WVYs/Yim8M+k=;
 b=Hr7u4H99oYMdw/viCvC9oWjx61mwo+5+0XE7/k3EM35uGS5UWqELwRbzP6V7ZQ+Y66
 bqROUNUF9H/PUNCIS99yOZeS+lE5lH2J4BiJxATlC7BWrSIBQUz9vDqsqZo0HUyPjkAh
 IAIjpYpdiCo4TB2afL4hesMC4r71uny/mdI5NgdcEYLQT6Rls3iYpA/uu2w/DWuThDm9
 1+gUK9qbaCkxFWK9kbeVMRP5BXdREdaTTeaA8fLggZdosgBYgxdPk4FPGXT80sZwWO6w
 gWgjsiRMgXZJlnH/FJL6E782Lk75IdETUlp3WnlY7GZ47Q8Y46tzDmb/Sj8UBxL2F2RA
 Hltg==
X-Gm-Message-State: AOJu0Yx2Z4S22yUWwZ0AWij+aNb6Lf7EhifdW1SsPW9KE9/cigmHW7RC
 /k2ONFLFsC/O5Pr6Tx5Dt2ZaTiQ154jJxuYbe6vzZEqeRCSCCmkI9N1x+pjjnJ2lMDtGWsPKDj+
 SiOWr
X-Gm-Gg: AY/fxX5FBSW2h0/UMLBOsl67sAZVf6EGbCbVSsEYwxQGtGuInVrv3xblJVmBY4JSojB
 NwG2GlatwgrtQ5ejWUb1IpR/GWsZ5A7iGglYsIu84dDduigcdhmsTyetc4uA9A3YpdQfmeYkO8K
 eIVAz148lABRAC111zV9EJ7kBbMsEL10blY3s0dIMGp6lNK7uZUvQXBjjLwVxYAU0g0tfHli+/w
 aMml0m5N6gBuuCnCPP2bhBua/65VHoI54N0jYD3Dlz+gR2iVnvLGiJfQLfdwQvl7aKx33DI9PI4
 pmnfIwF3817JM/tqaDYSIkaajkc//fB1U8npUEYVXRBTC2KAHr5IdxVjuBbsPxz1ShSg82aSbbI
 oWIJ1fbvzRflT2bgqMPvzaEiGTg7hElsXLOlZwIq5G2o2b2DZ8neSGim7Dg8CFHdvbytsBZgwUi
 fIcPrRP5c9AwkrGjt6oXP/wfoEUZO0Q+wl8V9p22h4MgdhGhZY22hTXQqGBKFC
X-Received: by 2002:a17:907:7b85:b0:b76:f090:7779 with SMTP id
 a640c23a62f3a-b8796afd690mr799461066b.33.1768763646172; 
 Sun, 18 Jan 2026 11:14:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 24/54] doc: correct double spaces in IPsec guide
Date: Sun, 18 Jan 2026 11:10:27 -0800
Message-ID: <20260118191323.241013-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct double spaces in "struct rte_mbuf" (two occurrences).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ipsec_lib.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/ipsec_lib.rst b/doc/guides/prog_guide/ipsec_lib.rst
index 458a82828c..bc3bc5525b 100644
--- a/doc/guides/prog_guide/ipsec_lib.rst
+++ b/doc/guides/prog_guide/ipsec_lib.rst
@@ -109,7 +109,7 @@ In that mode the library functions perform
   - generate SQN and IV
   - add outer IP header (tunnel mode) / update IP header (transport mode)
   - add ESP header and trailer, padding and IV data
-  - update *ol_flags* inside *struct  rte_mbuf* to indicate that
+  - update *ol_flags* inside *struct rte_mbuf* to indicate that
     inline-crypto processing has to be performed by HW on this packet
   - invoke *rte_security* device specific *set_pkt_metadata()* to associate
     security device specific data with the packet
@@ -126,7 +126,7 @@ In that mode the library functions perform
 
 * for outbound packets:
 
-  - update *ol_flags* inside *struct  rte_mbuf* to indicate that
+  - update *ol_flags* inside *struct rte_mbuf* to indicate that
     inline-crypto processing has to be performed by HW on this packet
   - invoke *rte_security* device specific *set_pkt_metadata()* to associate
     security device specific data with the packet
-- 
2.51.0

