Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F9CC02193
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F66540274;
	Fri, 31 Jan 2025 20:38:18 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id C740D402C3
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:38:15 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4677cbea36dso3588501cf.1
 for <dev@dpdk.org>; Fri, 31 Jan 2025 11:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738352295; x=1738957095; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTV2azMrxSAoPDTnOByYgix8h9/6Vj9GCNdVYzKWQqw=;
 b=JaaL/w3BfkJIxM2AflcqMUgNN25TZWqPryOnRuSzp2tGGrVVXoQSxfHFctIyPqkgLZ
 lhNJxi4+oeEEeb9ldW4AHru6NymaukJ8e91Rrr8hEhu4IqGE8BlOmJZjs/vSkyOTvapZ
 hyhKmSFQKaUucIVdgBZkQXuiOK6Kv922XQnsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738352295; x=1738957095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTV2azMrxSAoPDTnOByYgix8h9/6Vj9GCNdVYzKWQqw=;
 b=rd9FKrmjhj+8w0OWc4stcmgP2zQJQ7arIPVzY3jNeCFdCg5f39PrNqf171WgROIDVz
 zfrP6h4Q467T0Z7x/QjXGYO7d9AIA2ty145EwMsHJrxeRvTGbLooTX6Qg73hAfXrD5nq
 4/dXOQU7ooOPxWY19C2KB1GGGqE2pKQ1Qidd13d8nFe6e1y+fZ2ETkK4gARGS8rZF9QN
 6mCRGZ8oqbiyThrh8yjt5VIJ/JUqSUzIoOuEqZBbV9UkN37rh2wHkviiwSHShnrUv/y5
 YRc7jGFtYyvMp22LCQJbsn9PWENNBeN5wmJQz+R4xsCVnVSZiPnZt8SoVWETt5Z9FuHb
 f6Hw==
X-Gm-Message-State: AOJu0YzbxY24XfKku6qmXGKp8noxQk3F3ejkm/EDOar+EKu61Uw0IUMd
 UCiLAzDIjTJpzgHYmmwfn51I/z+fLSZe9EXP4+Yyc1HW94TiicpGSMHC5WRE/PU=
X-Gm-Gg: ASbGncsrI3PdpLodWKzeNkb9ocFyHI6zFsglZp2XT1Ji1E27suAQB8wPUiz3CE1cOHz
 v63kCQQJ5o0T38uW9de64jhL6+QZ3qsOAbWzJU+qPZh3O+rd7dY1ugyP2gcZeKuSw0dnj+/gJKN
 W627LZKyueeqYPPOl84JwTWSQeU3Ekc4p4WSeA+AJu+UXK262iiDwpIPSD47Zi+2YuwB2Q7CJj0
 1yW0TOcQhF65kWnflVCJ0qm3eUqf8ZCTZe0UUSBxlqyZB8/Br6bHU3ZD4O5ao7amzs0qjZc/Ht/
 RY7drpiTrb783kvqOujjsn14REipbxhkVjJs/BPuFA1EISIVXFrZO83e
X-Google-Smtp-Source: AGHT+IEJuRGJaeaR+g3cpLP2//vT5AEtA7biByzCwtzsFO8EDs5Y1JCRY2MmOD5/n+hC7NMwk+I2yQ==
X-Received: by 2002:ac8:5a0a:0:b0:461:3cd2:390 with SMTP id
 d75a77b69052e-46fd0b6885fmr68377911cf.12.1738352295112; 
 Fri, 31 Jan 2025 11:38:15 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf18a67dsm20743411cf.72.2025.01.31.11.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 11:38:14 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: yoan.picchi@foss.arm.com, thomas@monjalon.net, luca.vizzarro@arm.com,
 probb@iol.unh.edu, Honnappa.Nagarahalli@arm.com,
 stephen@networkplumber.org, paul.szczepanek@arm.com, dmarx@iol.unh.edu,
 thomas.wilks@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH 2/2] dts: rework run-time MTU adjustment test case
Date: Fri, 31 Jan 2025 14:38:03 -0500
Message-ID: <20250131193803.168498-3-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131193803.168498-1-npratte@iol.unh.edu>
References: <20250131193803.168498-1-npratte@iol.unh.edu>
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

Forwarding restarts in the run-time MTU adjustment test case have been
explicitly added, given that the 'requires_forwarding_restart' decorator
from a previous patch was removed.

Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/tests/TestSuite_mtu.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 3c96a36fc9..d1d48c2c13 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -164,20 +164,26 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
             # Configure the new MTU.
 
             # Start packet capturing.
-            testpmd.start()
 
             testpmd.set_port_mtu_all(1500, verify=True)
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
 
+            testpmd.stop()
             testpmd.set_port_mtu_all(2400, verify=True)
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 2400)
 
+            testpmd.stop()
             testpmd.set_port_mtu_all(4800, verify=True)
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 4800)
 
+            testpmd.stop()
             testpmd.set_port_mtu_all(9000, verify=True)
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 9000)
 
-- 
2.47.1

