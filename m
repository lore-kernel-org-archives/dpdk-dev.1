Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD48C44501
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0FE340268;
	Wed,  8 Jul 2026 16:13:14 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5364C40265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 16:13:13 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51c21495722so2824061cf.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783519992; x=1784124792; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=toHMHi9aSgdmFLtUIyUNY7EuWyHRvn5dg0VWAk4Ehhw=;
 b=V+Jgi0LbwX8d0YdBGaV/FoZEgUHSOMmRa86i+mw4xBGodQ7E5M/OGubI6/aU1uGjmE
 i72RrwZTSIcPGzXv1iFFMFKMPDMKXU8FIcXZLeEU5QO5em5KS4xqIELG05HjVycK0AA9
 Eph3K70awXYeBVYtXD6Lys0DsrAkRaa/0IeWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783519992; x=1784124792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toHMHi9aSgdmFLtUIyUNY7EuWyHRvn5dg0VWAk4Ehhw=;
 b=f6Bse6BnBDokWNE0cF+4HH19hV2+Ejk6pdcJUITdn7iTpvEyJ+uQ4qSnBZq55xFEMm
 YdJpF+LENQXSA4E1Vdp1ThdD2A0RiMX4chRBLMlRIcbyfNI06tmrwtaPPIL12o5JStQX
 WnmgfSyfSNCvnv08xN4xqeGecb1RdrwEDwyrg82zPyTgoKtxQW67j5NOqXFv24Au6NSH
 VUe7EkJa2Cs5MqHwLmAks8HlNk3uzliGVXxIRoR7e4QCyeKtt+9XR8MQboM3qWWG3AAI
 T0/m9kUBj8CyiZqUfLOKKXg4UaUHsloz99kRm9jra1WiLMoROGmE3Og0N/B8mHp8P7+h
 GaTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqC3GW0bjWz1fWeUsLSWWO6kDw0TF8Hy4F0GcA6Bha2T08RYAriJRtXmcLG/CsE3NpGb1k=@dpdk.org
X-Gm-Message-State: AOJu0YxHGIluPcMt/9pjMx2wdYI3inylD5eGs1uz49AxZdOWOgU/1XPe
 PHRv21rQyLX8fssTt2RsQRML4MtXkJI2t9ZjiKxDT4BTMawpuStde6pKAIJYLinJOG0=
X-Gm-Gg: AfdE7ckCJZH0TbMa1fJ3g3TkkaVWYRfbsIkilZftx4rbKrek/j2pCgvVtavMNXbYXH5
 FbBqCiRyrwPX1IJQVdpCknZGfgB+ecGhOOwybP4VRQ+0sOjMtr9Nd43QeayaZwQxL/Kij/oXQF/
 DN33+QksHMvqc4UKXMdaURgH3ISsxuCW8i9Q0BhkQjZmrT7J4oYuA1M+482E2SBr8bAcTOpBZJh
 U0pRRSN+Nb+j9BsqCbyVHNJnV9dOmx9Su1U0upb4RNFWhPKwt/IxNlL8KRzGsnu4xMuSDoi70XY
 JY3sykVJ8/6hS46iIxq2g/uTSTMlGNqHrkHSpVdGTeYKT/8ElQi2fTmzM3R8+XsbD2AY4cDBoTJ
 G1gWGU3/Jo91nCTT3QRx9qu9GUrezCNJumZjsflZAYDCzeY5p0nfZeO66FU4mrpL+5Co5vQpJhW
 6EkT42ZHft4y5LYz1uowDGMZGuvYXOqcqu58Dt/I3LN589bUJWg6veZTd25cgyhLWUkzL7yV3NI
 EkPQN3CZj+Oqywaab040uQJA71bFun4k8qUpzyqGtro5xNP5qkxO+G2k1PW1unmHCdzze+khLJv
 RYFea1c+eSHG
X-Received: by 2002:ac8:5c90:0:b0:51c:c7:80a9 with SMTP id
 d75a77b69052e-51c8b40b306mr27153101cf.72.1783519992509; 
 Wed, 08 Jul 2026 07:13:12 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41b55495sm143692001cf.11.2026.07.08.07.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:13:12 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: abailey@iol.unh.edu, ahassick@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1] dts: resolve new formatting error
Date: Wed,  8 Jul 2026 10:13:09 -0400
Message-ID: <20260708141309.566874-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
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

This patch fixes another formatting error that has been caught
after updating the tool versions in the dts-check-format.sh
script.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/tests/TestSuite_cryptodev_latency.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 411196c4c5..4e7d814faa 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -99,12 +99,12 @@ def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
         print(f"{'Latency Results'.center(border_len)}\n{'=' * border_len}")
         for k, v in test_vals[0].items():
             print(f"|{k.title():<{element_len}}", end="")
-        print(f"|\n{'='*border_len}")
+        print(f"|\n{'=' * border_len}")
 
         for test_val in test_vals:
             for k, v in test_val.items():
                 print(f"|{v:<{element_len}}", end="")
-            print(f"|\n{'='*border_len}")
+            print(f"|\n{'=' * border_len}")
 
     def _verify_latency(
         self,
-- 
2.54.0

