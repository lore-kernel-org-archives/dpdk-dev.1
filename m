Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCCC02196
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 16:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 132394067B;
	Mon,  3 Feb 2025 17:39:01 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0D21F4066D
 for <dev@dpdk.org>; Mon,  3 Feb 2025 17:38:59 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-467ab37b46dso2766171cf.3
 for <dev@dpdk.org>; Mon, 03 Feb 2025 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738600738; x=1739205538; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1afO6JM828tRmiTTFJffOoMrOHrY/ZMmjNSSKiT1ls=;
 b=VQTpX/PESwBHAyoATGALLITM9oKPCRfbloh1gMrG9f3STO33el/MhM7nVMqZpFzNfY
 EA1SQFoMFjSpJSCW47e2yhEuu4fCXjmihe+EyKlDfa2FZQkcanMulBZFdQWRs3phXQT2
 mBXKyH41Sy1/TmAZxwjAXmd4DBnldkpS+a+k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600738; x=1739205538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1afO6JM828tRmiTTFJffOoMrOHrY/ZMmjNSSKiT1ls=;
 b=xEPz1nQ1Z9ORAWgmtmYurVq9x7l1MkqrLC7VgYK6CoEReT0qTNVAT7RySnlDU9zIJl
 MKx8O95vYzLUDBvnOBWI5DpsEv/kVvDUaophcNPlmfVFhsrcMUvAPEhWK1jenhVT5SLf
 r0T4jLWaN2Uei5OHzyfK4TfFefK3KZtuOj8HSYD67cWCT45Jj6bGXodkP49ErwzuEbBg
 cwZjOtVtRMTnzt6Zb5ouGpEFmllCkZqZ34tBc6/GpHIXe9i65xCgZsOt//RdyyRZhTHL
 gZTdbyXPXSWgjvsukFMFBRMXZNZiPR7Gm4rvPx5u+E2rVHN+lhcgsKYCmpmczuuWyXrc
 Yv/g==
X-Gm-Message-State: AOJu0Yx4MwPCj6dbHGmjdZ/0Hhecnps8gRbVgLnASgW9klcV7oWgxk5W
 IbCcVvvEI6hm1dINPpJCYFispfvjH0ddyUzxWu/2sByoi60WMR6S3hZJEoKkwHg=
X-Gm-Gg: ASbGncv2fGGxIrxd0VH1e1jj3OMBwtJZ7sWq+66mu7Ml0agNl4lL5c09j8pp8D181GP
 /Y/ea5xgN5Y1KjRxyZijcSthax6knWPAAxVlMPSV2RWZhaN1PGgWg5tqlOPTP7QVOdinltZ9ay9
 BYJAN33mGDiWf7kiQB2yFMyCwy0tT5JA5L7Mh+0/cZryqPV2Nf3q0BfgejdafIa8utSSBDEOi9B
 BzgJodz3I/SA94MbvAFiWiLWsMbOe9CZKVMJMzRkmOl13jpHk/a4tbUWQbiCroYRE5ZKDZVRFOf
 jL/1OJkO6jFKSgqpVwhQID+Kbt5DG14Fs5feXdZJoUV10Y8r3sBuppPu
X-Google-Smtp-Source: AGHT+IFPvNDfXUNeiubiirVjp/kevBVBsIjUnJN04TvWEwHmbpUWvYKvQna+Q5avRtBRRq+R5/O2Bw==
X-Received: by 2002:a05:622a:10d:b0:467:613d:c9bb with SMTP id
 d75a77b69052e-47017e7200emr1259201cf.8.1738600738378; 
 Mon, 03 Feb 2025 08:38:58 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0bfdsm51566711cf.41.2025.02.03.08.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:38:57 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: Honnappa.Nagarahalli@arm.com, stephen@networkplumber.org,
 thomas.wilks@arm.com, probb@iol.unh.edu, luca.vizzarro@arm.com,
 thomas@monjalon.net, dmarx@iol.unh.edu, yoan.picchi@foss.arm.com,
 paul.szczepanek@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: rework run-time MTU adjustment test case
Date: Mon,  3 Feb 2025 11:38:50 -0500
Message-ID: <20250203163850.249461-3-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203163850.249461-1-npratte@iol.unh.edu>
References: <20250131193803.168498-1-npratte@iol.unh.edu>
 <20250203163850.249461-1-npratte@iol.unh.edu>
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
 dts/tests/TestSuite_mtu.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
index 3c96a36fc9..a4a14d7b3d 100644
--- a/dts/tests/TestSuite_mtu.py
+++ b/dts/tests/TestSuite_mtu.py
@@ -164,22 +164,33 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
             # Configure the new MTU.
 
             # Start packet capturing.
-            testpmd.start()
 
             testpmd.set_port_mtu_all(1500, verify=True)
+
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
+            testpmd.stop()
 
             testpmd.set_port_mtu_all(2400, verify=True)
+
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 2400)
+            testpmd.stop()
 
             testpmd.set_port_mtu_all(4800, verify=True)
+
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 4800)
+            testpmd.stop()
 
             testpmd.set_port_mtu_all(9000, verify=True)
+
+            testpmd.start()
             self.assess_mtu_boundary(testpmd, 1500)
             self.assess_mtu_boundary(testpmd, 9000)
+            testpmd.stop()
 
     @func_test
     def test_cli_mtu_forwarding_for_std_packets(self) -> None:
-- 
2.47.1

