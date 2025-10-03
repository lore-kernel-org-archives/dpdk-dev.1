Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46858CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 19:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16314402BB;
	Fri,  3 Oct 2025 21:27:22 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id D17DE402B5
 for <dev@dpdk.org>; Fri,  3 Oct 2025 21:27:19 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8571a0947d1so273881585a.0
 for <dev@dpdk.org>; Fri, 03 Oct 2025 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759519639; x=1760124439; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=Ya/nNRT8CNDkv30uSEwZQnGf8fQMEHP2ayrcaMHC835ZCJPu9k1XsBc209J/PckbKq
 VczC/4Kdbuomt0TOJZxbnBkZA/G1hRhlfIhl0o3NVgGaNKh1m30mbpDBbZdJ+sEUAicA
 FINRyV9dCreRpBjCflb2hYzs/EHWOB41fonmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519639; x=1760124439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LmnGS1A9CR1LubXqAmgJJ0QAWM1qnHWL42eZyx3rWs=;
 b=OAtTukVw/QNlKTo3B502dqxMQWZZF4JGhGGe73K6RzYRjMLoBytFazR1DJSG9hfA91
 mCM6C3yjN2B1+hdl3VNF8PsLbqHPynt7C1ntKa0Wk2nwdl48bwQ4bqktHK4wXYtKRO+i
 8TSWzIN8hDxq3MO5nBRVQOmDeHOxm/3UHj7OmrSbaJyJwDW1CfNJ/LLxc/7sLLL/VnnL
 rnfL2+zyPfFHaIJAr1iMeIwLxRe2+jsFDIlXVty4js+xPcCyrxh9uD0/2vQxrXzZ9ib+
 xanJevu6gLO7Es46Nxj10z9bdZH974K/1TV2wbtz+7fciwzSobkVPuN8DhotK90xT0Bm
 ci/g==
X-Gm-Message-State: AOJu0YxdyXMg4rDbZXw0S+ZDmt1vbTdJro6ekBNtsPtVEtcPdpWbSPMj
 6r8IYaYlRfvaGNyAMFc7yuC4de4NnOWKJvc9fWaQkovhjAusd11sB8VIsCImBuvavGM=
X-Gm-Gg: ASbGnctRwu6EPRcqRnjz9SVz+S4j5UIVl4AthbHVV6lZHivbmyi/QDA9ayQ+IfGHfCh
 Z5tHEQEhC0BM0QfKgU5rCXeI5zVpnpyEosY4oNNWG9v2KtpMo9QuuG1mybZeVgYmt1GzchdlKX4
 UkqvAhjFXTTglGGMsDhBivpY+zaEk4iE2z1r/uUMml4ZCW0wFRTDx7iOMls+jYasKGgrR+4M/K1
 37/S1kWEHQmwX3nH97QtU+/KcDgbWDY1twVMfzq8EKL/7C4SGxsYSu/524k5TBTELhHunvi8R9J
 TPltDaXkZbIFvaROwT71PlqAhsKr38vyl5C79WS3ncWcIh3rulqpWaxp7/6Y30isSqqZ/SWieTp
 ZRmjT94xiwBaxxuWgo44NqI3nxKr42nX/4pmnFpah9H71shmv
X-Google-Smtp-Source: AGHT+IGtx5BtcMaUGHNQv6QhgB4qxc2gLaTVn+JWrudW+KlSzy1r3sHv+HLd/HBlAWdteXH8R9Onhg==
X-Received: by 2002:a05:620a:1a91:b0:868:f241:17fa with SMTP id
 af79cd13be357-87768069f5cmr1127434385a.19.1759519639020; 
 Fri, 03 Oct 2025 12:27:19 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-877735a0664sm492490785a.30.2025.10.03.12.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:27:18 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: add start Tx first method to testpmd shell
Date: Fri,  3 Oct 2025 15:27:15 -0400
Message-ID: <20251003192717.444490-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916200458.259376-1-dmarx@iol.unh.edu>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
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

