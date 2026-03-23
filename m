Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7909CF483DD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E9F40654;
	Mon, 23 Mar 2026 19:11:34 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8623D40647
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:11:33 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cd90401034so40284685a.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774289493; x=1774894293; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OqPYT+bTSV8eGWJ6Xgy+NHSnnGsiX6OSsINhfUMvOg=;
 b=iTbRl0N8+YGvvfJV2wztqW0+jC6EI16ttV5ccYI9fbpk7Z5F+7dDzrVfqJjB6SMEvw
 1fU4k/V4L9WpNFpfBbz6IG/Nq3jqpH6LVc+kt2/W/UsEZ0FWI8rh9qhQiNEUplU8q8yA
 B/2HGO4DrT3gPsfeB0XTZHWsgzvTejLYaLe28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774289493; x=1774894293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+OqPYT+bTSV8eGWJ6Xgy+NHSnnGsiX6OSsINhfUMvOg=;
 b=llCBE0U5Ppnay+FYN/zjIy32rY9pgl8GmLAlNbGEB8AQlOxNBBFjTX1cn2/bjYOi66
 KtV/ap9LFftdmabvUQ730HV8x44+zdFqSN9pgYyPusx0LvYO50x/z7GPZ9NppD0IRd0c
 SI4n2GViEk3DtjSkA5Ts6ptJ1+Scv20maAz9EgQ2KzcjErEDrvVc4pI866Ai8rjLADMm
 sjnHJ2mFtbOAfCfHucap6ifqlCtKIK9sfkcnWO7DPOzRRJaBvsN0/7fU98xJQjrh4UuD
 FOUs8h72cYSYLCqD+KMHoBhlHc94+7uma3vBAY/Nx6d+VwGFLxJZ+zDvyEPGtAp78VMu
 k3aA==
X-Gm-Message-State: AOJu0YwoOfZcBhBsjsVm4F+eDDIt7NXCgwa5OpDYl1yXdr/tGiLxipRu
 W/iMvGnG2YJJFjie5BAxCMkF8lA2Z7eLh8vk8lY5tUbDG9S4fpKOQAoAWNpNNUyiuqA=
X-Gm-Gg: ATEYQzz0CA+4H3ruWpLZBhTQLIppURPDHDcRdJRxvwlzmhe2wD576bfTqeGPodJ9IFJ
 xHf3rF44qJPOokvLjul7bOmETw4/35vH6ykYHv1ZsCfMGXwe+zu+hKbIPthAJ0QHbVX3w3/+e16
 2RDDIeuWZuSzeUa80xca1KoU53AzcOM3oIuRVHGhntOt4sGDIszIyXAqngmpvUJugsaeP3O6mRK
 yMQSo2z/z2AeG4qRdP1A+fJK3yzOynPldUCfjbObPQfdndoM4oMJTMTgY7a67is0EMWV3DRdo9G
 z1tnZ385tWNEUGbVn/6h4kBbDvBBUGS9lIljX21CgWNbU+r6eY34A8K/bzrvLBXkwlygDRJV9qu
 YpsBQqxnTIVEYCfdzwJtPHPIvdn/lZnPFNbAsmGhWKLNLt4NPgEhWh6uvwvBxfvrUJmIeigGn8O
 cBpYxvMeHxSCLa2+3LrvE6ZcKPexI63mWMBnDuyK9mtdvdwImsjd5bE9Iwd+u9Qw5GjMB7ybOY2
 2vsHsBXbHfq
X-Received: by 2002:a05:620a:2a10:b0:8cd:972d:2fc with SMTP id
 af79cd13be357-8cfc7f7ddfemr1812364685a.63.1774289492580; 
 Mon, 23 Mar 2026 11:11:32 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc908d8cfsm841462885a.28.2026.03.23.11.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:11:32 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu, knimoji@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: avoid dpdk resources conflict
Date: Mon, 23 Mar 2026 14:08:18 -0400
Message-ID: <20260323180818.674041-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260323180818.674041-1-probb@iol.unh.edu>
References: <20260323180818.674041-1-probb@iol.unh.edu>
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

When starting and stopping DPDK applications in rapid succession,
there may be a resource conflicts on ports, memory, VFIO, etc.
Even after we send "quit" to the testpmd CLI, some resource
cleanup will happen asynchronously in the background. To avoid a
resource conflict upon starting a subsequent DPDK application,
add a very brief sleep after quitting DPDK applications.

Fixes: bfad0948df75 ("dts: rework interactive shells")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/remote_session/dpdk_shell.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 51b97d4ff6..7c79f33908 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -6,6 +6,7 @@
 Provides a base class to create interactive shells based on DPDK.
 """
 
+import time
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
@@ -84,3 +85,11 @@ def _make_real_path(self) -> PurePath:
         Adds the remote DPDK build directory to the path.
         """
         return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
+
+    def close(self) -> None:
+        """Overrides :meth:`~.interactive_shell.close`."""
+        # Allow time for VFIO and hardware resources to be released by the kernel after the
+        # DPDK process exits. Without this delay, sequential testpmd instances may have EAL
+        # errors when trying to acquire the same devices.
+        time.sleep(1)
+        return super().close()
-- 
2.49.0

