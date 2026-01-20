Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA6D262AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F0B9410F6;
	Wed, 21 Jan 2026 00:08:20 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 240E2410F6
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:08:18 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so38833065e9.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768950498; x=1769555298; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBmwvfCWNUiyI9zDGbhfZ0bw+Jl4b9xlpoBT/6PPRgg=;
 b=xpkiEQw4CHhtulxLdyk83cwK6KrcnlZJKtemuC5oNN6hha5vE6pu/Ic4ht5LRo1/Cl
 U8gp4VfhJXVV4XH3X9bNey9RfEtnCPFz/KCR7XhMC7O2R0TRg+HCMr8nxqcbNF4M1Bv9
 VC82B/HDhVn4mHrLKyDbS0vP3mKu1i10mI0lX0Yqp4lkY3XiIOPzNHRMuE9NNV1Lbk39
 DC5XuhwXSfs9PBcsB5QGH5ATZahk4mAuEi2WUBOpPoqNGqw1T0T4N07vG2U79CMAdn+T
 mNDa75FRE9SfitEx/kUwq72TFtYLCrf96AGyT7n2YZ6NbiFfuVZFuBYJRAz0YmC8aktX
 KOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768950498; x=1769555298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBmwvfCWNUiyI9zDGbhfZ0bw+Jl4b9xlpoBT/6PPRgg=;
 b=e7snDco27BO5Bcxk8LmITlYRQA3SawjtcAxRvH0aOBs4Km7mOhc6xjASwhXiDCuxzF
 3iXXXPzn18Kkwh6mEozS7sPihz6/F0QeRPGwx2y3Ig5iEsOEJs186acq7GPIyDD/nMM8
 p9CrzZf6gfY9qvqdx0uW3XYJcl952uMI88Yf/Wt6FS4a9Bkw+lPYyYdiUACjOKet8q+H
 07FD30zgQoHuXCNl6SSmAx5ZWcjmh7RLrdX2JjlnW0Bq+SqlvSdAazWnAIuzQE978myX
 m0f8ipoen02FGL7Dqv0yo50F353+bs5uzLtoV1E4rOBQwVN2nbxJO6GLavdVO2snb7WS
 GGyg==
X-Gm-Message-State: AOJu0Yw3+oDDQVdjJxsx3PsKWNAyADei1tnaK2O/B80CvzEJl++MBf2m
 m4Vb6uHtJ7fbPpGnrz1onfJWoUIiKHuhsDmPdRC7DQCLTIAsSd95iV27xOX5/MIX6RY=
X-Gm-Gg: AY/fxX5FjSky2fBzDc3bmrp1j6snfDe/Ye6ORkmW7M57NdDBT5F2wzJ8kDIJ/OyENJ/
 moCZpZu4wZyL1+jVbkAiLPsgA4939VPTF5TIIN/4HXiUzrWDn1yd9i9vyO22fw0fx0h5xehKvAg
 cDeNzvUSfRkbVwTRK3gKSNBAngznZLMHIdrI8CPXzDX7FwXsj93s24UiDcq+HjNmzlyHmpA+eR3
 +uKhU+PxYd5PMf9c23fIl+1k/IxK1VU3SjzlsSpLdkuFvC6v6eXSRvwYM4+LRMWX5UCeTjWv9q5
 FG8Gk7BGcOwvglk2MpB6yTiIF/cd1T1rFuMTNBBksSHzZqQN37SitDNWgufudK227Vz0K8+MMTp
 uKcNu+04CGecp3BJU7mrCXzyp8avqDHD2ETbD8b+y65sT1zGXRMiQ+UjgA0lOO7ac2rn/lnH/j+
 KKtMDy0R3xKUbgy1y62vhKBHAK9cJjOzMShln/ccmgecLqUg==
X-Received: by 2002:a05:600c:37c8:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4801eb0922cmr200320845e9.22.1768950497599; 
 Tue, 20 Jan 2026 15:08:17 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ffcsm31267125f8f.18.2026.01.20.15.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:08:17 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dts@dpdk.org
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v1 1/1] dts: fix invalid f-string syntax in testpmd API
Date: Wed, 21 Jan 2026 00:08:06 +0100
Message-ID: <20260120230806.192421-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260120230806.192421-1-sismis@dyna-nic.com>
References: <20260120230806.192421-1-sismis@dyna-nic.com>
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

Fix f-string syntax errors where double quotes were nested inside
f-strings that also use double quotes as delimiters.
---
 dts/api/testpmd/__init__.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index a20dedc25a..703cae487e 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool = True) -> None:
             InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
                 start or ports fail to come up.
         """
-        self.send_command(f"start tx_first {burst_num if burst_num is not None else ""}")
+        self.send_command(f"start tx_first {burst_num if burst_num is not None else ''}")
         if verify:
             # If forwarding was already started, sending "start" again should tell us
             start_cmd_output = self.send_command("start")
@@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
             vlan_settings = self.show_port_info(port_id=port).vlan_offload
             if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
                 self._logger.debug(
-                    f"Failed to {"enable" if enable else "disable"}"
+                    f"Failed to {'enable' if enable else 'disable'}"
                     f"QinQ strip on port {port}: \n{qinq_cmd_output}"
                 )
                 raise InteractiveCommandExecutionError(
-                    f"Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"
+                    f"Failed to {'enable' if enable else 'disable'} QinQ strip on port {port}"
                 )
 
     def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
@@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
             InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
         """
         mbuf_output = self.send_command(
-            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
+            f"port config {port_id} tx_offload mbuf_fast_free {'on' if on else 'off'}"
         )
 
         if verify and "Error" in mbuf_output:
-- 
2.43.7

