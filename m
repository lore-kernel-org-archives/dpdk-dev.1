Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F83C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC35B4064C;
	Thu, 26 Jun 2025 17:28:03 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id C34C040648
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:28:01 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d38ddc198eso120220285a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750951681; x=1751556481; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=149sXDl1C9MrxMhBBf9bmTF4ovrVeTuNz1zfeesuOjc=;
 b=G/TmuRDWPxt4Vjpor7lCKvU213spSGncXI/bcEhvo00VJJAVMCvZc1Cj2N2ud0NxaP
 fLLbCiTZTAHRX6CyjqvH5LgMEjcbKsI6VRPUE7z8zhAfxF5macNIx+fyQ4sPtzdUBmCb
 knFn2+I7Q1E4Q34tM6RbW2R/H2l/wnv9Ktgfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750951681; x=1751556481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=149sXDl1C9MrxMhBBf9bmTF4ovrVeTuNz1zfeesuOjc=;
 b=deO/m1gdF7XpjKvJiHVXey0lvX1b4vh1Tyx0PwoxLVeCUQjlTSmJ9/1wM4urrmM6Si
 OPYAJb64iYxhJP5as9fWxjkvMAwdy5R8PK36+nKoQs1Gh/v8sVCOZr9KmBl6ZRYXGc1o
 FiDrHpL+M8rVxQlHqtFkK7fTFIDe/BQtBq+QihnFe8NeGV+N3BsckG6bOpRZJwDVXE0Q
 pPQGBJANRc9caHUbsXREb1uC6PWzeOvXHNeYjbSiDxIN5g3crcLbqXOYCBIrxhX3hHvD
 tImJLBDIG7CCY1ySwfpRjJC6jr3+TqmsYxu9LIoh40wDSISF9d+GeF2mMClW5yWlALl+
 19oA==
X-Gm-Message-State: AOJu0YwGwrqfTz8pHPrXfxSAHZBn/cd7VN29hOctC1vleNEMnVvvTE59
 d+nByvra2O4LEPdJpNvc01wUocoAyQDBUMxUwPRbNtbT170B4sGyHA7rbjsp1ozBi5c=
X-Gm-Gg: ASbGncvemke0TBOpqPelNBBjMZXh2eb45C7odjR5gLsLPtO1ASgjV6ahU/6WgqX69vw
 t8y4mVg5MSQlRdmleWzFy/nB9kLbYiBjV+k3+szTOUNxKLkW65VwSOO9R8uBMsws8kPXrRu36cc
 /5EgkmPFtUZEcT3JmaqF9EmL/BGgN23jtIcIExhtXyKNIXmXfYs6kth41BL7Luv3zXQz/4aCk/j
 Dek9whbVovWafFgZEXhhqwmIl8UDyNZPiyH0G20OOR7QPZDjKEVk1KO1/GhFy0aiZNCXIrOMh8x
 vzdGmk4/wnZ++HAuKy0HsSc2S6Pz5XyIoajW7VXLb1qniRAbw6YEjQNpKgmSyG3f0uaHNEyk
X-Google-Smtp-Source: AGHT+IFr5kv03h+grQZ6xVzPCklR/SLg6vcxt3662AkAS28EmhLqVvNXw+HsX0kRt+BKam1ZiXMf8Q==
X-Received: by 2002:a05:620a:248b:b0:7d3:8fa7:8880 with SMTP id
 af79cd13be357-7d429763de1mr1100313685a.55.1750951681077; 
 Thu, 26 Jun 2025 08:28:01 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443219fb7sm12287085a.80.2025.06.26.08.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:28:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 2/4] dts: remove unnecessary testpmd verification
Date: Thu, 26 Jun 2025 11:27:53 -0400
Message-ID: <20250626152755.197560-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626152755.197560-1-dmarx@iol.unh.edu>
References: <20250617201358.708638-1-dmarx@iol.unh.edu>
 <20250626152755.197560-1-dmarx@iol.unh.edu>
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

Remove unnecessary verification step in the start method
of TestPmdShell which checks the link status.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 0b9bb4070a..a035452bcf 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1578,13 +1578,6 @@ def start(self, verify: bool = True) -> None:
                 self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
                 raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
 
-            number_of_ports = len(self._app_params.allowed_ports or [])
-            for port_id in range(number_of_ports):
-                if not self.wait_link_status_up(port_id):
-                    raise InteractiveCommandExecutionError(
-                        "Not all ports came up after starting packet forwarding in testpmd."
-                    )
-
     def stop(self, verify: bool = True) -> str:
         """Stop packet forwarding.
 
-- 
2.49.0

