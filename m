Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE178F4BB7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 20:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB6840270;
	Tue, 24 Feb 2026 21:04:32 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 74790400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 21:04:31 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-503347dea84so65525511cf.3
 for <dev@dpdk.org>; Tue, 24 Feb 2026 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771963470; x=1772568270; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm94KKRzMFA1FbzwMbaXcvh4BpPgL8CHSVJQkz6qkxQ=;
 b=NoYbfjoUadnWpE3HGd+HHFS7Iwc9OLJApGiMmD5gGpr4NZtgHY7V/AxGTJJzbGmdVa
 kq9T/lNaGjAF1YP3aR0OTQjr6iIpRCkWaWNGJktDM35qGWG0wdKaDxqYqZK8RIJFGT6S
 UCkcLQ6DXJcWd8qeIGnU063abyNNxth8UkAlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771963470; x=1772568270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm94KKRzMFA1FbzwMbaXcvh4BpPgL8CHSVJQkz6qkxQ=;
 b=DlPK2AeNOP7DRxlDmXL+Z9KsmmQR6y56Kat5d/UnMFDGcwF95x7fthsxnnfuyekfGb
 PmoBOkHwUZ00PKifjbJeGAX0UXi3nDQVE/8SBgCW3h1hv3qsAkr45qYd+hiwSzEJf39v
 BEOdBiyS8A8/F0Rcj/OSgElMLjo3M8PbwNdcFnknJuOSBcbkCf2ODjtd9W+y1A/Av2rx
 kzMbBAJ18FxblcoSTKGoyIL044zOsLGgNKW1f9QJsTZoBuAxI/ocHvOriFoOJfkBoiFr
 JgCav1hwgGneRxB+JbaAGEQSYov9MIlApXe4OtI4bXuJD5tMUPbvD8WrOJdZ4VMLJsDl
 F9RQ==
X-Gm-Message-State: AOJu0YwHWs7qAlOtZAb7wt5z8AYIhIxr+4Dfk8Lod3tfJ9i/eM0jHwoi
 bii9Oi6SxlpduxWwQtXlbY5JrtVCJskLp0uDckwjMKSars+noFtbaxY8yOi+VWhVFJCWo7MLjhj
 JA147/3TmxV2zJ8sP8MYzN+9npC872Rjd75XuL35xVhSxctrwl58sRy+6Ycz2J0ubtp/xH1vavS
 gaZ8K+QHd1fFkkrFyebYuJAxSwYkg=
X-Gm-Gg: AZuq6aI7Zg1RuLDsqhpXVL/jJfv8G6CAiHshk3hDMSU0F3Xe4bR/IdAcHmjlO2UeLUf
 XRLlcOPvgPvVn1gpI6YDpzswkvVAoCJWb1fGctBPn561A8oTbHH9P5npVewUCdFKaTnNhshpwaJ
 sXil6YvMg4HWziYttO9xfoNhc7/oGmTMEyHbcUNH1v2niLFp0Ggbp8+3YTn6+wa/CdzEUhoVSnz
 9sO/8mUcE7W+vvXC7K5vdXbROMy12NlIhAtekRNx0VbNw923YplCgQHffV2l19nhQSD3lV9C9xJ
 UAIbTJO8nRQnDzYpVtQYvJdoIX87DWHNXeOsqG/F6p3o1OOfjpnu0dfDHctGV1E3tCovKTy33gR
 5dtFDFCDZivGesXrKYRuEBlCtV4s8t4FyztTzu+TGh/gjL8m5cfttWSqiFWeHKkVIo+PlN8IfAe
 WerZZfvIDeqEbCwMnif3ZMu6WWV9fyQfgk0dblOWEBrIvK9yR/W92hb/aQIMvDihzZ
X-Received: by 2002:a05:622a:1308:b0:4ed:dec2:301a with SMTP id
 d75a77b69052e-5070bbcc95amr185704361cf.16.1771963470110; 
 Tue, 24 Feb 2026 12:04:30 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e62f453sm104993486d6.36.2026.02.24.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 12:04:29 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: reduce precision for single-core performance test
 suite
Date: Tue, 24 Feb 2026 15:04:19 -0500
Message-ID: <20260224200419.50597-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Previously, the single-core performance test suite did not
limit the significant figures written to the result json file.
This patch limits the results for the output and the json
result file to the thousandths place.

Bugzilla ID: 1895
Fixes: d77d7f04f24c ("dts: add single-core performance test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_single_core_forward_perf.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index 8a92ba39b5..1e7ab7b036 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -91,7 +91,7 @@ def _produce_stats_table(self, test_parameters: list[dict[str, int | float]]) ->
         print("-" * len(header))
         for params in test_parameters:
             print(f"{params['frame_size']:>12} | {params['num_descriptors']:>12} | ", end="")
-            print(f"{params['measured_mpps']:>12.2f} | {params['expected_mpps']:>14.2f}")
+            print(f"{params['measured_mpps']:>12} | {params['expected_mpps']:>14}")
             print("-" * len(header))
 
         write_performance_json({"results": test_parameters})
@@ -131,10 +131,12 @@ def single_core_forward_perf(self) -> None:
             with TestPmd(
                 **driver_specific_testpmd_args,
             ) as testpmd:
-                params["measured_mpps"] = self._transmit(testpmd, frame_size)
-                params["performance_delta"] = (
-                    float(params["measured_mpps"]) - float(params["expected_mpps"])
-                ) / float(params["expected_mpps"])
+                params["measured_mpps"] = round(self._transmit(testpmd, frame_size), 3)
+                params["performance_delta"] = round(
+                    (float(params["measured_mpps"]) - float(params["expected_mpps"]))
+                    / float(params["expected_mpps"]),
+                    3,
+                )
                 params["pass"] = float(params["performance_delta"]) >= -self.delta_tolerance
 
         self._produce_stats_table(self.test_parameters)
-- 
2.50.1

