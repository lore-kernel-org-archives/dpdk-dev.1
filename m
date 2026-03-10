Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E7FD4F08
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 17:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE43340672;
	Tue, 10 Mar 2026 18:13:28 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6326A40662
 for <dev@dpdk.org>; Tue, 10 Mar 2026 18:13:28 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cd8347d9fdso347423985a.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773162807; x=1773767607; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F6lCjVlFyYnr+2PXmP6ycn/nx8kIOPqGO/XdLJZid8E=;
 b=A9TvC3d3YV+AqtK+QGs7wXCL77bY5AuB8id+c1gBTqdkHDTLRjQHHxuGm55DyRR6tH
 u8xwCLQTZwYV2Cv6avMYJNySadBMy09DHbK+gux4KGLrAYvgtQbUDeGs1PfmMhTOy0SI
 0+7GeC+lOFIOVmgxU8rfxVHdJ/izIgPJO1W9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773162807; x=1773767607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6lCjVlFyYnr+2PXmP6ycn/nx8kIOPqGO/XdLJZid8E=;
 b=IUhB2KNhWXHnSzU5McZ+oEE29HeV1Pwgh8H+hWw3oooiGyYAnv/C/wQDllJJHRHkrI
 GDpo4LZgjTDBCxqR3gx/y8AVxzxLVFMWhBisz2C+G/LYIsMPDJR3/6IC0KiWSLvtLfKh
 kIw9KRYBAYJ2gElmEhfP9s2FVm/spZXlwXKtxHhNBKlr7PbnbyNnwaGiaZaIDqGZS9O1
 HMDshChDLDHKiELKTL62kyO1WY5yktBtTqff9uQCBkO152iH/RcuiwfrzQh5TR2Ir/xY
 p9pN8SsChSeavRwinriIkS0Zbf9O6QFpn8E/7xOm7Y2CD73pmKfxi6V9Vs0Ck3Z97kBV
 vnuA==
X-Gm-Message-State: AOJu0Yxzezw0cJ6wEYmgaBGI4KEMlBtDQR/Lmat/37ISNU6oy3F0Tiqf
 gT/iUPEZ7UuB5AeaVTYDdUPmcPG41Iq4FvcpRjV2kBmZuozQnOcF7fj9ryyGYAuHo+k=
X-Gm-Gg: ATEYQzzG+z5N2ZUhfX0+Z6LFUtBEGi4dCosuw9QmOx53k4x4+axAwPahYtXgr1tWPi7
 o2fDLF7OidRsAOaSCKiMFOdnDIdtQJwYd2dzinTllJCFn7xq79BrM9D+4XkvvU/oHfRJhHrWWV4
 YTwxOx+5ikf5IW0maGg3Y21lxM8La7DteMi2IlOizLowyVSiuDrQyYq67PdXYkTmECfvfOuumX+
 v4IPW8OXz18Qd9LPdGBS/o8dg/MBtHArp2qoixWlqQC8tKdNy3bmO5J048tpFsRe8DHaprdaWFL
 8fD3XWQ9BiUshH4dndxrFPV6lusLXW+bQ0QJvBregkPWvKygw79CnSDLpmEIRcCdRIo5lQ2mKj3
 0rayiiL7qK4jTOcVKiGhc3pNGAUK829z4G7l4t19sm8KE40XyfKwDUp+WG8req7JwVD2sRt9lG7
 y80kv9aND++jBhHQfUizo31U8KbygobRePtyZXJWWP9KRIs22EGIO9qiOwObiJTEJBgti7Kd898
 4C8CH3pcFClYnkBBcPigO5IhZFk4/0=
X-Received: by 2002:a05:620a:c0b:b0:8cd:8142:b7e6 with SMTP id
 af79cd13be357-8cd8142c5d9mr988745685a.26.1773162807456; 
 Tue, 10 Mar 2026 10:13:27 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f53bbd7sm929050585a.32.2026.03.10.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 10:13:26 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Paul.Szczepanek@arm.com, manjunathgouda.hosamani@intel.com,
 thomas@monjalon.net, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v1] dts: only sniff inbound packets
Date: Tue, 10 Mar 2026 13:10:28 -0400
Message-ID: <20260310171028.15441-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Add a filter to the Scapy traffic generator sniffer which
forces the sniffer to ignore outbound traffic, preventing
double counting of packets. Without this change sniffing
will double count packets when DTS is being run with a
single link topology, because the Scapy packet transmission
and Scapy sniffing is happening on the same port. The
correct behavior is to only count inbound traffic which is
being returned to the traffic generator by the DTS SUT.

Fixes: dfb667368077 ("dts: add Scapy asynchronous sniffer")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/testbed_model/traffic_generator/scapy.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 9e15a31c00..c6e9006205 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -203,7 +203,7 @@ def _sniff(self, recv_port: Port) -> None:
         ready_prompt = "Ready."
         self.send_command(
             "sniff("
-            f'iface="{recv_port.logical_name}", quiet=True, store=False, '
+            f'iface="{recv_port.logical_name}", filter="inbound", quiet=True, store=False, '
             "prn=lambda p: bytes_base64(p.build()).decode(), "
             f'started_callback=lambda: print("{ready_prompt}")'
             ")",
-- 
2.49.0

