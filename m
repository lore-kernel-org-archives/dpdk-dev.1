Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68AFC369D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 01:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A08E402F0;
	Thu, 24 Apr 2025 03:48:48 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id ECFA1400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 03:48:45 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4769b16d4fbso3167561cf.2
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745459325; x=1746064125; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy5aKrnLU2EQeBsaoHyKcSKPidU3yv97w0/RIpSwRZY=;
 b=YOP+FeVPaNtP4nbLz1sQWdEXFKcLiJ7q1aKnxjZoQgkuoVZUOY5pK955UN5SuW2jqI
 daaXpj9lMtUcHTMvCVRZCXooul2WQtk+shFqkBmjroTaENPRtTLSRiSNyh//72hE5LY7
 s0gMKbWRHWNroHfSqQEtga+s3CDQXh28jv3eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745459325; x=1746064125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy5aKrnLU2EQeBsaoHyKcSKPidU3yv97w0/RIpSwRZY=;
 b=PPMlK8FvQ8s77OEX93VfQekrvsf8qSIEjmcfPPcx2UuwGnJA6M8JCOA/FYp5XHicjL
 0gM2JGwI+lWuZQBoNQ/ExElpxJ06urfqCbp+EEa4IXmWs+Sbzg1h81FhC2U3megwAjiV
 9O+2UaYs+djEkZ4x8tUe8m8hbxznaRltPZSKHEeDbu5ycPiel7JDt/cqCm8pkzlcSNH3
 J75COdpR4pQRxk5Tdhuy9e/mQiFMPWlg57RP8lQmWTkIPp5LY+xrlj8INhLlxvJUAr3W
 TxLQwX7If1bCgzlVxdtXXZXbQ4QcDRT5IImr8oM6XgvRLdzN7Nu8L4QCB3qiYNrAjygH
 1O/w==
X-Gm-Message-State: AOJu0YwdQ52KH4GOy9jmUNmnhWt/zKyPPVXZfd8EOBpEv9YN+WmRIWyL
 K9kRCRgnzxqruVhTZ8rHsT56jT+JpUVnihcIE5AaN3uYKJZ/uRSXynCLG8MITko=
X-Gm-Gg: ASbGncul2H5bq3/5L1GJ8wCy6GqmxIklbu8gLq8mk4yqrydua9H6AJIcXobsNJSPjzY
 C0JCLTRWkTugQl+pgQTGOprFL7PvVqe4oAl7lqpLzF4g6sosSPy2dDR1XXb2sRMjkoWFBSzpITS
 umzIwRtd3A8Hsp9K350yAdsT9eWAbxQsQKQHfkxRvbF1sARsENnoQuLJj3BJZFheM22M6r2hrkx
 XYnGvmefdMrAKNlUJye+P1Z+Yc/HH4fEiQN1xp6Se6wQ/I7ycCXkTe84XPTB4hjPecqZOqWcHxU
 9ekdKgNvx2qqPWXCNTV/dUz9sbNyYJRql4Zwi8QRWDuTDy6VVFGfDzIQ49otvagBN8OkFlY=
X-Google-Smtp-Source: AGHT+IFVQ4Dd2DmzA7MqinEuNFJ3FMShDRosCwago4cHxhP4Up8/0VQUtasXLTKjfjj1HTPYTbBpsg==
X-Received: by 2002:a05:622a:1354:b0:476:7d74:dd10 with SMTP id
 d75a77b69052e-47eb2aa15ffmr10869721cf.19.1745459325358; 
 Wed, 23 Apr 2025 18:48:45 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea1ba2868sm4317411cf.74.2025.04.23.18.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:48:44 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 thomas.wilks@arm.com, dmarx@iol.unh.edu,
 Jeremy Spewock <jspewock@iol.unh.edu>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 1/2] dts: add method for closing ports to testpmd
Date: Wed, 23 Apr 2025 21:44:11 -0400
Message-ID: <20250424014412.3849896-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424014412.3849896-1-probb@iol.unh.edu>
References: <20240814182005.12251-1-jspewock@iol.unh.edu>
 <20250424014412.3849896-1-probb@iol.unh.edu>
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

From: Jeremy Spewock <jspewock@iol.unh.edu>

Closing ports is a standard configuration feature that is available in
testpmd but the framework lacks the ability to access this command
through the testpmd API. This patch adds a method that performs this
action and verifies the results of sending the command to allow
developers to have more control over the state of the ports that
testpmd is aware of.

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1f291fcb68..c9c95be4b2 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1723,6 +1723,24 @@ def set_ports_queues(self, number_of: int) -> None:
         self.send_command(f"port config all rxq {number_of}")
         self.send_command(f"port config all txq {number_of}")
 
+    @requires_stopped_ports
+    def close_all_ports(self, verify: bool = True) -> None:
+        """Close all ports.
+
+        Args:
+            verify: If :data:`True` the output of the close command will be scanned in an attempt
+                to verify that all ports were stopped successfully. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and at lease one port
+                failed to close.
+        """
+        port_close_output = self.send_command("port close all")
+        if verify:
+            num_ports = len(self.ports)
+            if not all(f"Port {p_id} is closed" in port_close_output for p_id in range(num_ports)):
+                raise InteractiveCommandExecutionError("Ports were not closed successfully.")
+
     def show_port_info_all(self) -> list[TestPmdPort]:
         """Returns the information of all the ports.
 
-- 
2.48.1

