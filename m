Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2064EC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE12E40E1C;
	Thu,  6 Aug 2026 07:10:40 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 0BBA940DC9
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:38 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2242567a91.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993037;
 x=1786597837; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GcFF/sFUvanZy0DWq++2sAIr1beN+2AJvBNOl7T121A=;
 b=bWrYFL2SQzq/MldPCbYkphp4vMs39hp7DcJC8I+k0Ex64+RQiBr5B7HoIkBCkDDl1g
 N9pt1zrACx5JI13NhShFWzR6dVCxbU3bP3Ky1zdUgihePkMk3zLWsbLSW88GCZaJm0/Z
 afKRMFLr47ZYR+Qx9VsGcN97Ok8eEMSbJ1zRa3FlN3MSX12Cp9MYRQkHxl5VwGLS3PTt
 wg40mOb/wY/2eamg9fbIqQUd7Qecqkux2qRCTbyFInKd712iL0H/2pT3+Bm3mNkfEyQk
 uivMyrYZZFYcJE8/UzJ80HUnGn8kvIjP2/J4nP6CoVQaj96sO0JgLqDCY+wCh+8vAYu0
 R7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993037; x=1786597837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GcFF/sFUvanZy0DWq++2sAIr1beN+2AJvBNOl7T121A=;
 b=YfGXTK210r+ct59vVeAUqjZSAuUhR42vh5ih4EsbMHRLK5u1SsBg5OG+EBfWdEYxH/
 Rue1+aZYW64rS224S1P6k6/JxiGclMMPyRcox7Mnj3AZlqcxejWdONyJqKmmCo4NtCgf
 V8enXqQebpaubKmeJIJuj9EoiJ56DVl9SR6z4v2IC2yA822aUYCH9gppT3rj9e7g7mmI
 wmTLyeZVFZIBQPqhqAk40PBBBoEqJ+KB+9Xba5ZwZMm9Ou8hyqytYiRu8uZ4t0+rSnTs
 Uf4VqkNEtNjmf7DcFtSZ+WVavkWX0FnZY3QmaEQr6Y+/WOAolHQAQk5g3YWTErEHnIbk
 S8ng==
X-Gm-Message-State: AOJu0YzCA6yCm0hkHHEDTxbeQ6ps/BY35FYbG1jE+ZDIMXSSqKMLeWP+
 kClfoNmuR7HfJyoH3OsiOg40L5gXqKOs3+6oJwaobl639CJCxZbKS2N0xJJoFovhAeRbTFkxIBk
 4CYPEthg=
X-Gm-Gg: AR+sD10lJ9Og45bPobWwoGnKaxLHlF1jLtbgHiOOUXqSBf899mmEgVwSFz2+aJ1DK0c
 EXwB4MsgKp3/CanYmeOFDN8k6ahrrQpXoqq7dY4+fv1cagWJsjnz61YClvuFrpqvBZnkBt6rr2z
 ZEPMwBa3X+TCgC7BZy6xn+BzltLvv1ofbisY04UqvU1EYvC5+WJxNECIbjNOlISZ+moXAPGSYCg
 wrv7APj+3zZGWZ/RWAsr9HZPr8kl0OFJ9/Pz/IxSHarz9VERe5o4c4UlNXK4NT0LMRAPGCQ1j3e
 FEIo0ukmVnPOwmCKnpj94X95r/hbzhLHtuEczIxfD8eoBCcz1Aqanvf+Yv09TuzhQFoynovm4st
 ef8LNEcoxwe7mlTuXYZLWZLwm35k4ny91Svp1uiKlBzDziLAsXkN1zULP0F6c9OsCibM0hmd0g+
 rWlSBBCqb9xHT52wsPHf4b/4NcsERzaIY5/uV+4/6oNFwWNBPP5Oe59LDpcSBZmI7SCsZiH7iNX
 4Pwn68lffnCHwyNG2ht86MJEU/P
X-Received: by 2002:a17:90a:ec86:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-3903c537a12mr13330389a91.7.1785993037176; 
 Wed, 05 Aug 2026 22:10:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Apeksha Gupta <apeksha.gupta@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 21/23] net/enetfec: add missing sys/types.h include
Date: Wed,  5 Aug 2026 22:09:15 -0700
Message-ID: <20260806051004.166778-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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
indirect inclusion no longer occurs, causing build failures.

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

