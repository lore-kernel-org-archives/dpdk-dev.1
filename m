Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5FCCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58FEF40648;
	Thu, 23 Oct 2025 14:32:41 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id A1C7E402EB
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:32:40 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8909f01bd00so78702885a.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761222760; x=1761827560; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QY7Lk3sGKeXP6b5NGRrNxPzgrTRH5X9CgjFF4SuOqx8=;
 b=DCAvv5sUrccR+TtA1lzjbf89tHZDBW/6oZQFZ4+HZq/aJow7Kebai92fjIrLgdD7w0
 +NlBD3g1lC3I11RcRjxvc+FQiyrmC3j89bxwpjywRrAHoEXlzC3Z3gsQkzDEPV3EBCXe
 JQ12X8b87ufKCcmJ7Tin+bf16+XeXeN8qcoPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761222760; x=1761827560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QY7Lk3sGKeXP6b5NGRrNxPzgrTRH5X9CgjFF4SuOqx8=;
 b=HU4aeVR9XkOmvOv+rloYcASVKAFtYXlBwh24QI4s7uspl9+aUpxDqE9MVjl/ICLYo5
 wqinIxpkSJzftoFsy8yfR5l53T35d8ymknaOywknc7rchFhTid3wilhA/NmRvsXCNRAV
 6yU+QDayuT/JhdJmMQ2YG6k/Tgw/UmrGB/8YtqnAcMDVwFgK+MY8BGWOo9+RlwFDxGnH
 LjSofBSxiYd8CdRCTQ3OXmB/OA/bc23YQgrpjt+y5U29hgXFiWcmmVFFHJRzDn/OdzJP
 C/A/iRC6fEtzSIdLwe/lust6rOKp432HxXT6EY3bF+MjRg70/ffpXJ4jrzMrWoVkXHEi
 83TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTEx4N2JGZfxYjDt8RpFXtdjX5okAOSeHnCiswL0qemNs1enivINB70lPuSK1Bzg4i/wg=@dpdk.org
X-Gm-Message-State: AOJu0YzIbVnd+rb/s3BDOdikQPBBEYRluxDpoZGXjurI7KSHHoxwYolH
 I/ePEQXRTrZ5e6Z3M531XxYOAD2Dc5gGHP82QSwedtiRfmi+Q9aF5eaK7mgMQR48ug0=
X-Gm-Gg: ASbGncvea982j8yzevBhQF3bNViSBj3Z6f0QlRHOmrUBAuVoEgJWgg6y343PsjUJwHX
 jxvJMLFwyeMtnSL3VqhSNt3N7d3UDHbUxuqpbhqqeOk/PrPA3nwLhfD7BNGY/N/+GJmTzVOD4le
 YF/8UUbZQB8VgFGAm+DEUWeKmvPFTEBw6QVSGE15XrUwXCpQ5w2fj5DhyGTSPg2pdO5T/eGAXL/
 sxRsr8zYf500sDNd/tex6je3stcvEpkspyk+SJVNm5Fy6DOOuXt6FQREML7CdfFDg1wtr4d+Tsr
 wQvYcg0cjWM576x4n9xfRQi9OdVlRGwUeuxzuf8ENkYWrLNyP9bgWOQDd/24C8bBjE9+c65JDBM
 IELGvibJ4WH4ka9bJlsGDSObhZaQdDF4fLmk1e1ii8UcJou0PcHw4NkTh4l+fm+6tItFEiXGYw2
 qjZ1Z7qRm4S51/u8xsInT8ngQ=
X-Google-Smtp-Source: AGHT+IFuomgAkS64QIce1xFFIodI4bP0oS6KSyCXyiObkSecdg1qZ8YPvPUeW3rMxz9Zy3gMUhWnZw==
X-Received: by 2002:a05:620a:190e:b0:866:f322:c6c0 with SMTP id
 af79cd13be357-8907050ce4bmr3359932585a.60.1761222757034; 
 Thu, 23 Oct 2025 05:32:37 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb805cdd6csm13137021cf.6.2025.10.23.05.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:32:36 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v9 3/3] dts: add Rx Tx offload test suite
Date: Thu, 23 Oct 2025 08:32:23 -0400
Message-ID: <20251023123223.56924-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023123223.56924-1-abailey@iol.unh.edu>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251023123223.56924-1-abailey@iol.unh.edu>
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

Add mbuf_fast_free portion of rxtx offload testsuite from legacy dts
to next dts. The testsuite expects mbuf fast free to be enabled by
default and verifies configuration of this Tx offload capability.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_rx_tx_offload.rst |  8 +++++
 dts/tests/TestSuite_rx_tx_offload.py          | 35 +++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst

diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
new file mode 100644
index 0000000000..27834a74da
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+rx_tx_offload Test Suite
+========================
+
+.. automodule:: tests.TestSuite_rx_tx_offload
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_tx_offload.py
index 16e1b8cf93..0d0043122d 100644
--- a/dts/tests/TestSuite_rx_tx_offload.py
+++ b/dts/tests/TestSuite_rx_tx_offload.py
@@ -27,9 +27,8 @@ def _check_config(
         rxtx: RxTxLiteralSwitch,
         /,
         queue_offload: list[str | None] | None = None,
-        verify: bool = True,
     ) -> bool:
-        config: OffloadConfiguration = testpmd.get_offload_config(port_id, rxtx, verify)
+        config: OffloadConfiguration = testpmd.get_offload_config(port_id, rxtx)
         if config.port.name != port_offload:
             return False
 
@@ -40,7 +39,11 @@ def _check_config(
         return True
 
     def _set_all_queues_mbuf_fast_free(
-        self, testpmd: TestPmd, port_id: int, on: bool, num_queues: int, /, verify: bool = True
+        self,
+        testpmd: TestPmd,
+        port_id: int,
+        on: bool,
+        num_queues: int,
     ) -> None:
         for i in range(num_queues):
             testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
@@ -61,25 +64,24 @@ def test_mbuf_fast_free_configuration_per_port(self) -> None:
             * Mbuf_fast_free can be configured on per port.
         """
         with TestPmd() as testpmd:
-            to_verify = True
             port_id = 0
             testpmd.start_all_ports()
 
             # Ensure MBUF_FAST_FREE is enabled by default and verify
             verify(
-                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=to_verify),
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx"),
                 "MBUF_FAST_FREE disabled on port start.",
             )
             # disable MBUF_FAST_FREE per port and verify
-            testpmd.set_port_mbuf_fast_free(port_id, False, to_verify)
+            testpmd.set_port_mbuf_fast_free(port_id, False)
             verify(
-                self._check_config(testpmd, port_id, None, "tx", verify=to_verify),
+                self._check_config(testpmd, port_id, None, "tx"),
                 "Failed to enable MBUF_FAST_FREE on port.",
             )
             # Enable MBUF_FAST_FREE per port and verify
-            testpmd.set_port_mbuf_fast_free(port_id, True, to_verify)
+            testpmd.set_port_mbuf_fast_free(port_id, True)
             verify(
-                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", verify=to_verify),
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx"),
                 "Failed to disable MBUF_FAST_FREE on port.",
             )
 
@@ -99,7 +101,6 @@ def test_mbuf_fast_free_configuration_per_queue(self) -> None:
             * Mbuf_fast_free can be configured on per queue.
         """
         with TestPmd() as testpmd:
-            to_verify = True
             port_id = 0
             num_queues = 4
             queue_off: list[str | None] | None = [None] * num_queues
@@ -111,19 +112,23 @@ def test_mbuf_fast_free_configuration_per_queue(self) -> None:
             # Ensure mbuf_fast_free is enabled by default on port and queues
             verify(
                 self._check_config(
-                    testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, verify=to_verify
+                    testpmd,
+                    port_id,
+                    "MBUF_FAST_FREE",
+                    "tx",
+                    queue_on,
                 ),
                 "MBUF_FAST_FREE disabled on queue start.",
             )
             # Disable mbuf_fast_free per queue and verify
-            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False, num_queues, to_verify)
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False, num_queues)
             verify(
-                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_off, to_verify),
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_off),
                 "Failed to disable MBUF_FAST_FREE on all queues.",
             )
             # Disable mbuf_fast_free per queue and verify
-            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True, num_queues, to_verify)
+            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True, num_queues)
             verify(
-                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on, to_verify),
+                self._check_config(testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on),
                 "Failed to enable MBUF_FAST_FREE on all queues.",
             )
-- 
2.50.1

