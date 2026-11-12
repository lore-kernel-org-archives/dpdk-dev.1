Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17307606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=g38UcFeW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A82540E32;
	Thu, 12 Nov 2026 17:13:11 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E7E040682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 17:13:10 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-537548b811aso35699051cf.3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1794499989; x=1795104789; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GtMIH8H8ZRlNnYjoV8pbt93t9HB4XRPNI7JolEk5Onc=;
 b=g38UcFeW6pm3jv43H9WZbwRn3fU+ac2U7FwciOpmTsACbuv4UB2UbK7+0RFLrpke5L
 MPFqSuNlX5vdY21K4D7/lADRprn1j8EbFOql4nl0FtjIX134x3Qglxbe3+w/MMUqmhaz
 4SntBJ86aQieZQdo5warEU1SZQRvt2+F72u4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794499989; x=1795104789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GtMIH8H8ZRlNnYjoV8pbt93t9HB4XRPNI7JolEk5Onc=;
 b=QqlybPx4NFfRvsft9+/poYrT0PWaq1dAuXgHyHtx+XbKH2mRe7AZLQk0USswovYiDu
 ZjpTlgXGe6dAsTb8HxobAnuq8nOSkJeYMJOYbCymguGJNrNleEWTqe7sjINXqyBPf2SM
 mPJYUEeBEQ1yA4DaJ7/lQ87eeNwWQmciy/Vc7W20LZUxPlB3DU+gcDbIuAUmwG66P6wc
 Ht2ZnSS1pTIytPmAT77MoUGA3vWTWkaefKkGwXh2poPe+lYhCgFji7wqEIPZbppkTk5X
 SmQhdWUlZcaIf9JhNvyo0W/bQrhnZPs7HB9YRJiRB9/lBIGSvWgnUQDNpCcSDRdhjEpz
 wmiw==
X-Gm-Message-State: APuU4Z8ORwbdaPZc0mjHJqkb4a8CyiQZLmSgga1WUnQTrNDMvzTrNqXz
 2nVbeHje+SBze7DYTDPa+L7oHhp5PqJqo/hFCFNAONHVpyg1PswUJF1IchB6ahddIygB4ZMX6gN
 7XqDe0zL3Nu4cP4ctLXyZVdfbpoQHzQ2qfXOhWMW8cMJ+3+fVRFOkLdGa93dfciRBudw803ZNvO
 gNpnvX3dxPI+IHtZ7bHO49ITeiORs=
X-Gm-Gg: AYBFou3HwEhAdeL3kmuza/XhgPukBJdfpRb+I6wQSAQaKw/HkltPygUkO1q7sLh4G8a
 kq3oPpX0gPSW1LFecYghJpfZ9rSi4tgp/GPbDtLetu6pvLwK82EuPGnrfI6a2AHvWu9z2BB6FHV
 cUNuHBHzWFG4Ekynvi7oli0tTtXBTUuyXTLYKEYWz6H3SHY4YP92a+l06oGXhEwYqKDVAudMm8N
 /zjLoxttmmDrXNZK7zU8klBcbKpZACywSYK+NSuPM45+xYhFM7No6kCX0pcnOHKebcvcNb+ert/
 bgqXXz9f2m0/zzI7l1dFF1RrQ9Bj7Q2zSDhpVXfK+kjKs9/w68jWp65HEH/2QNL8lhbr94lffTw
 28ayNSLJLbZ4PpCsOn8Eru45F+hE8YfwwQouXCRGnlLCwWVdOqh+sPCCzz5oWgAOhbDENQBNDzX
 SuXBp7z9O7AvHojcDTYJYDYxkPqAhAil5lXovKCWHC2vsEOXjLEwSxKqNDYhPMCIOG7G4tpHO82
 vUWW6gr/AWrN60gobbCgdL+n9A1FSr+y9Dk8FgGHpGGCEVA56FO6GB2EsmefmADOM0LyDUICnGW
 kN5XbIup01Sdn9UefBSf2ZIrm8rcZTyiCSdb6Y8GOMe2YC3E4MrJpM+Qfrez5s8kiqmmV5nP
X-Received: by 2002:a05:622a:a15:b0:54d:ba24:fe2a with SMTP id
 d75a77b69052e-556c1b5b5famr83289011cf.74.1794499989052; 
 Thu, 12 Nov 2026 08:13:09 -0800 (PST)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02efa477sm50556736d6.16.2026.11.12.08.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:13:08 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, dladd@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: resolve false reports for cryptodev latency
Date: Thu, 12 Nov 2026 11:13:02 -0500
Message-ID: <20261112161302.776617-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, the crypto latency test suite would fail if a measurement
was above the baseline and still within the given delta tolerance. The
expected behavior is that it should fail if it is not within the delta
tolerance. This commit resolves this issue.

Bugzilla ID: 2103
Fixes: 2ca02cd2643c ("dts: refactor cryptodev latency test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_cryptodev_latency.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index d4693b3d4c..8349a34b96 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -248,10 +248,10 @@ def _create_summary(
 
             # result did not meet the matching parameter, check if within delta.
             if getattr(result, "avg_cycles") > expected_cycles:
-                if self.delta_tolerance > measured_delta_cycles:
+                if self.delta_tolerance < measured_delta_cycles:
                     test_result = False
             if getattr(result, "avg_time_us") > expected_time:
-                if self.delta_tolerance > measured_delta_time:
+                if self.delta_tolerance < measured_delta_time:
                     test_result = False
 
             result_list.append(
-- 
2.56.0

