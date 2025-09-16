Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC3CAC592
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 20:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 902C4402C9;
	Tue, 16 Sep 2025 22:05:02 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8DE4C40288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 22:05:01 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4b5f6ae99c3so58944691cf.1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758053101; x=1758657901; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/JmMn+rv00Iez9PqR+BB0+dBMJ9r+G27TLqOsEjkrjY=;
 b=c+IVKrktHxsj9HfHcfML2Zv9AgDvaRpQumEYa4JHDRfmaYxSUVBUm1+5O3M8UT0i9r
 vcqleIxCFOtG56UcniENY+uyjaC5VEVvmXphFGCKCMYYq8avqD/VRtJBjeBr+fnm5clg
 j9Sxu7EY13zisX21ObHqpifjRl/3aIb8UEWTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758053101; x=1758657901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JmMn+rv00Iez9PqR+BB0+dBMJ9r+G27TLqOsEjkrjY=;
 b=NB8Ad6l2f4if1Xd2Iv5xOhqVlq06y3QcB09/tZCajEBY/Ph2A6JPCa9c2RfIg7nL6z
 BntNqs7ENzBvfdqxpKIk1qPmDmfBjUtBxbnqCXcaZtyZqoLKajpGMPjsg5F4c2jGsPq6
 j3RIify7VB2LmMRmOcLSYuS73BM4JHfVluCvJQTVCC8MePrHq7W/2aAqV5newTgazemT
 +n4ZLgcIvMvJoYBQ2zIUG11j9/RWJtPV9vsWuEE3SLkoUhhGoXl3MQ4dShldZ9ewPMj/
 ZEuuMXj554NnGfb9d0GI8+YveqX5gGUcVNvuokNAyCahIYDBde04lo7IYr35tOLb/5Jo
 i4Hg==
X-Gm-Message-State: AOJu0YxLArl4ZmptMW2pt07ldTLNPO9+K3mL9Qnr1OHMg1p3Yklo2NjS
 kdDaEh+apkg2SABoEJUJsUa3zWZkTWEdINMHkj5doy1JHq/5HhYIfuHAs8lQCdMq3kw=
X-Gm-Gg: ASbGnctYRBqGCoi/2JeH5jeV/njqzcC76pa+XQzdFSj3jFPt9GhDMh8Jvoqb2n1tuO6
 a2eXC2KhJ4hjRRIiaqDELzBOyHGjiGXJllAyeGLPfc8A0CGs7DN0DpPiQmK2gbLStJFki3O9ZMJ
 76AQUYKxo+WEA7PXtaFOErwevV0MPhKv7gdaQfwI+Tlzwmmh8kdHbQeA8c/Tnyo+nGU6VbFbS4c
 j9JuUdHzgTFRnXCBJo2hg/rREQYpeJ1Gr3IFWUWR42MfmwlazBRBfnLbqnu3/qhQEGu5qz+B3NA
 HIgvfqep7DG2uykvmx53z7CgyiOqeervc4iDFe9v/ES3RzyEls/e+n0tf88uySupviGjRAwJmui
 25YqCM/fxZV5fHf7vQXF2SQnfBZ1ZarRKhg==
X-Google-Smtp-Source: AGHT+IEtqcKMFJ7OUQa4+JXCDj2eyB2P44S707i39npdx5gDCRGXz2XLg2Nr1qbAWJB4gRYbDMugzA==
X-Received: by 2002:a05:622a:1b28:b0:4b7:999a:2866 with SMTP id
 d75a77b69052e-4b7999a2a80mr133170011cf.72.1758053100837; 
 Tue, 16 Sep 2025 13:05:00 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783278c7ea7sm42222796d6.46.2025.09.16.13.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 13:05:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: add start Tx first method to testpmd shell
Date: Tue, 16 Sep 2025 16:04:57 -0400
Message-ID: <20250916200458.259376-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
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
---
 dts/framework/remote_session/testpmd_shell.py | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1df3d5f792..44be5ed44f 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1578,6 +1578,27 @@ def start(self, verify: bool = True) -> None:
                 self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
                 raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
 
+    @requires_started_ports
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

