Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1EFF483F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 20:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C35940654;
	Mon, 23 Mar 2026 21:24:13 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2D2B740654
 for <dev@dpdk.org>; Mon, 23 Mar 2026 21:24:12 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-509006c070eso35700751cf.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774297451; x=1774902251; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1z7X9fG8xhQQMkhs+fDuMVGoBZkpjIZ2mAVnvylx8c=;
 b=Vg4smMADVIbNwTgglz0Ov0GJhcJWdFfTKrm3bGy6P+HjGzItczOt7nEPEfScHriluk
 QTIq3MpLQtdBw1l6dgMSPbN6mO8JgRxeSdZ+IFEUP+pe0XiqnabDmuBmNwEnR3RjTbXt
 XA3XLXF28ZPvgn19DObk75uN13VANxcgYq518=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297451; x=1774902251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1z7X9fG8xhQQMkhs+fDuMVGoBZkpjIZ2mAVnvylx8c=;
 b=s9lH9/AZv31GgaVwiB3N2+vh1wX/vJrVl0KR4oDbyCK/3/GPzPc7leVtsE9ND3KmVN
 tuXLPPBW17ePflEZ4Fj4rCA/uDcdOuhVNv7OsQxwyiD+phmQZ+6Q5NnbXG/lStqRn1nc
 v17YsucWYngsuGmBUPQ63FjoWZTDRg0pZW9ni5bYN9Tw4MuRlHRDWBHiaEyHdVRPBaw8
 lY5hp0yiq5hH44jkG+oGdGPovcj2sh2HFUDXS/paQisf8/zp9tC0G/MLk1m+1Mo4Vdy1
 Yy/Wxhq/eTrX2WcONvFsm+bxLmNvgJ0hmtO/xk2wpsa+z4Ng9xxNILTncl+Yn0sbiBJa
 TxCA==
X-Gm-Message-State: AOJu0YzHHx2wsv4U4Gp2kpBHiUgd2oGEB1y46YbpmmFrEJwsxko1NQBI
 7ynzfQ5jxFRz7fCtLicanlYny9jyhs3kQYZsyu/UOvBtiGeVPrneDZFLmkTiXMHVvgtWILGzjhn
 c1wnTenw=
X-Gm-Gg: ATEYQzxdyaUDuGryIH0ZCkZDUZLLNCvsTZfVNRNkdCPOV5aK5g1YYexYhEFw0IHiUDj
 zji0h6aU2ogCgSRMliCJ7JyEvpC04PMPLAeurXZr1dqQoz9uUw4uRJ4oLp6+RSnttWcoG52U4rA
 VmAQ3LRRZgnQ+UsayaRfMFFOsuwAUhIsc7aAgnalvsh3lYt03FA9wQpo9kxzwYoSVt6QBEZZVQV
 M8uxy7eErr2Aw5dQjYfM2Fym2EadMB3eyfRPIrJsL5jtCn1R0rG8Th77VyfZqL8VO3gfC9XAAS7
 UmZv0/pMDPWXe6lTn2i2rUKTqFMbI6QZ1Hq47KSHiTSp8uRxe0Jwt7fb0q8t3ld0xwgASIJFBuR
 WSAkE3fHS30Pg92RGjJyrK6DtEG2RAkQZelBvI7UYwQe2BJE+icq/cznzaAHwimD4EOpIgTACTq
 UA422oXNQNasL8DMW1ekZcjEKHaaY5syfSM1XhU1L5s9U6h6U3meK5hCNI2CE8acnN3+qM6YwJf
 g5Z66NFz9Tp
X-Received: by 2002:ac8:7c4d:0:b0:509:4845:8ab7 with SMTP id
 d75a77b69052e-50b373f66camr219287571cf.8.1774297451492; 
 Mon, 23 Mar 2026 13:24:11 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b702b85d2sm2966811cf.25.2026.03.23.13.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:24:11 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: always use ethdev ports to check capabilities
Date: Mon, 23 Mar 2026 16:20:52 -0400
Message-ID: <20260323202053.740203-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260323202053.740203-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260323202053.740203-1-probb@iol.unh.edu>
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

DTS uses its capability check step to query ethdev devices for
their capabilities, and then run or skip testsuites according
to their respective capability requirements. So, we should be
running the capability check step with the ethernet devices
in all cases. However, when crypto ports are specified, a
crypto virtual function will be used in the capability check
step in error. So, this patch changes the default behavior
when computing EAL arguments, setting the port allow list to
the ethernet devices by default. In addition, as a defensive
coding measure, the capability check now specifies its usage
of the SUT ethernet devices when acquiring capabilities.

Fixes: 76e3fdd7b5c6 ("dts: add cryptodev package to DTS")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/remote_session/dpdk_shell.py | 5 +----
 dts/framework/testbed_model/capability.py  | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index b94d336d4e..51b97d4ff6 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -46,10 +46,7 @@ def compute_eal_params(
     params.prefix = prefix
 
     if params.allowed_ports is None:
-        if ctx.topology.crypto_vf_ports:
-            params.allowed_ports = [ctx.topology.crypto_vf_ports[0]]
-        else:
-            params.allowed_ports = ctx.topology.sut_dpdk_ports
+        params.allowed_ports = ctx.topology.sut_dpdk_ports
 
     return params
 
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index b166014e0c..960370fc72 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -384,7 +384,7 @@ def get_supported_capabilities(
         )
         if cls.capabilities_to_check:
             capabilities_to_check_map = cls._get_decorated_capabilities_map()
-            with TestPmd() as testpmd:
+            with TestPmd(allowed_ports=topology.sut_dpdk_ports) as testpmd:
                 for (
                     conditional_capability_fn,
                     capabilities,
-- 
2.49.0

