Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C5CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C82B240151;
	Fri, 24 Oct 2025 20:51:00 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id A62B24014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:50:59 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4e89e689ec7so15006341cf.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761331859; x=1761936659; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=iYZWdMICXgnDpWOBcs8C0R5Z9hFThCJadVzhvmUqPlpt7yE43s1Jn1Vrlm9AcTkzfM
 b0JKHQ0aPQwjwqjyd6V6XvDRnzoJW0u0D/IOnKt3+J5EqKuYIPUzgAuxGP/OqwnRu2LG
 Me2UG+eSHDYABe9TPhR5VAnPDgaBC+35DjL/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761331859; x=1761936659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=cBPgiaN3kDd55EAqjJfWfqKJ0OzIvTbVdWosAb8exSv0ld3/pczvYBLTgC2Og0eb2A
 kjFDgQMlzgaNycN7IWQhy2LeS1lhJ5FYiBBYyfIAGML7Da5iAg7ldvCxLY2FhSHgXVWC
 cyZbRzhCfTVdPr3efKL+rKnu48SdMowaTYdS0CruRJOeJoGYqcHX5Ky2CY7cpK6p7/Yg
 V9ZvjfhN8NwJtHwAX+FEGZ8DDlH3pMis58NRVVYmPNjeg/2UoR6IpawjpXRtJfA4AzTq
 f/hLcRkclUtCDbXT26spGeri/CJMHY6/XvMICi6eY1Yn3ToY6idcL1DNZ1Luqpw06KlF
 UtxA==
X-Gm-Message-State: AOJu0YyiF7BVEl/FpYyCxSdq78rSRlP2m6vLVhf504QdnucePLn+78th
 XLu863b3FhXP+EbzvWH6JW5ak1Eo/ibXoOpu8WzZotU8rsJTjn0an2eaDVzadpMMAu8v8kfHpjn
 e7Rw6
X-Gm-Gg: ASbGnctgLRFEouX8WT9IX4vfwHyBmVad8FBe6bqBU21APxls4xHUHeomJ++kI4rfeNk
 QBPgtSnXJXurxP0IBMd7lK46U4+/kOnFG7VIG8N+r7UmsgiKCVLB1aoihgGdNMJatky2jpUtWOZ
 A10isg+0fP5ao7Gvhaz6KqUc1IT8x3UGF5azSg+/Ru5+qh+ZjyCD5F35mhxUyp2icMiFVPUpRbB
 7+STvaoracHdu0AImmmvd5Hj0M4ol4eExrdBIFq4JurHNyVA93estPA0FudrzDNerXOwJUmI2h/
 UHaM1Zl/sKZxc160g+kgPCXhxC7DIFqigt4x9rzJhx1K5nHmtZhoapqtYkdOl/0GisdrLj+UBZT
 c4nPLBLminz0QSqDFOeSIHI9WoD4lQJTZRwd6o8ArzeqTVnK05LYloVpQYZ0lrL6smcn03JR1IO
 Zz8Dw=
X-Google-Smtp-Source: AGHT+IETbFJj0HA/i1HW1w1k27zugqABLgHb2VK4PhxbzLVEZLTYBdFGRj5UN5tyl6tas6Q5sGKpYg==
X-Received: by 2002:ac8:5ccc:0:b0:4e8:a416:95e5 with SMTP id
 d75a77b69052e-4e8a4169b8bmr382172211cf.69.1761331858883; 
 Fri, 24 Oct 2025 11:50:58 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80804d81sm39830751cf.19.2025.10.24.11.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 11:50:58 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 1/3] dts: add start Tx first method to testpmd shell
Date: Fri, 24 Oct 2025 14:50:53 -0400
Message-ID: <20251024185056.607160-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024174702.600147-1-dmarx@iol.unh.edu>
References: <20251024174702.600147-1-dmarx@iol.unh.edu>
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

Add start tx_first method to testpmd shell, which sends
a specified number of burst packets prior to starting
packet forwarding.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/api/testpmd/__init__.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a060ab5639..5cf1ae7fac 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -199,6 +199,27 @@ def start(self, verify: bool = True) -> None:
                 self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
                 raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
 
+    @_requires_started_ports
+    def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
+        """Start packet forwarding after sending specified number of bursts of packets.
+
+        Args:
+            burst_num: Number of packets to send before stopping transmission.
+            verify: If :data:`True` , a second start command will be sent in an attempt to verify
+                packet forwarding started as expected.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
+                start or ports fail to come up.
+        """
+        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
+        if verify:
+            # If forwarding was already started, sending "start" again should tell us
+            start_cmd_output = self.send_command("start")
+            if "Packet forwarding already started" not in start_cmd_output:
+                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
+                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
+
     def stop(self, verify: bool = True) -> str:
         """Stop packet forwarding.
 
-- 
2.51.0

