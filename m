Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD3C5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2273540691;
	Wed, 19 Aug 2026 21:11:02 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 9E90640696
 for <dev@dpdk.org>; Wed, 19 Aug 2026 21:11:01 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ccf2360620so10793455ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787166661;
 x=1787771461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKBvX3ncQvXGT21v8GYAzNhnSZ89RaJEfIehKF2QQkI=;
 b=nxeIzfeywvJIe5MEYn3NL38eS68kC2Kks3uvzc35m/aJxGK3dy481uxoL+T/yDKNIP
 FvsVcHTw72iTwlnVl/o7BwMngJEIsmHUzBMvOBmk9i16osJRbL3mNp9CLaD6Z3lV5Amc
 fVQrariT7GZtRJFZbceTgTkeNtdDD9SfCkp0pkQTH+LQlbz+bvaA7q2u67bJTRBbHLNR
 cJAixLJsors8xjvuyk+ZJKEAqxfUHvhNV1FUuxX4vAR8pgtvUN3+z2BroGZzBajM8iWB
 5kbOmjvjw/f9A2U6cDnY7f6z1VIGClb69qien+wghooWDveeq8LvktdGLuX3Mi3mrCU0
 a9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166661; x=1787771461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vKBvX3ncQvXGT21v8GYAzNhnSZ89RaJEfIehKF2QQkI=;
 b=q25ck2iBgcrZLm9lGrRm0uz+oyW+h+EzY4DXxUoM2sSywuMNq/kQ4B2/laKNNzZnAF
 ULSulodJ47qXfjbQSuIco6xMaPkMkKY8TBV0pwoVKVS1ac4wLBMCNL58/xO5I/a1XvAL
 khqJICu6lf83xNQDupmR63oqVkusBuMG983N8MuDe+dnBrAlS6O6ZynOdGyCVUDhtiX8
 NyXfJ4IX97z+p3gMBJJ2f0R2vdQFXEzqeb6Ym2Gy3BTxZ8V9K4qZ9ODvGgwsWv/VVjDZ
 xxxGdfHZNlM/i18ECBHUuHXlwnSn1+R2PAwrQsXNpZcXbk8H6PnP8YqcgAe30maBxCMu
 eTgA==
X-Gm-Message-State: AFuF++nivHGwiRY/bO0tAp8bjKgOHhhJNJTmS3DjVRF65F+gxbV3uRhv
 3dxZ0NdXMq7sAf67m+rbnCP+caCyC8BBmP0hIyRiVEm9Muhd3fBcCKk7s5GyWdF8/HLpj9BnW4O
 lQzjc
X-Gm-Gg: AR+sD11alvtcUZAKA3jbHbAJMLuxKAKlxBTZ3cdo6qzJ0kPmjwZyWLf4U5gwBohZ04F
 lVAsgKjD12JLITe/r3QrAPQlEQC9z3YVFuaicojHvZCFlLbssYBF3ax4+j0T4rMFVvVIS0NwwSF
 gpzlHjfGwkizkdlOiiAZmHMhBpZdbHej8uAa5CGfkdqhOY0D4V6IcLilsrczNP0d59X2ZUTeDia
 kfbunE5HkI/0xVcewhUK4LBCy/YPHKBBTPfqOjMuea1jcaP97tgt4LbOP6+jgAu4Wp96PXAHeyr
 m+WmE7vo9ugsV6+mmYAViNAZCq+yPwIUPRjHO+T9pD0xM32uYAfJfXfBGGptDQceVLWC7Dctl/5
 wetQ9igr+caCMt5IE4rzF7+6eii0DmOrfbjqytNwBd1NsmG32FkkNUorb4NC0T9QCwCZfMrWiCC
 c15s87ZI0WM17aCi5h4kJAHN8rH+qMP39JDoMtkI5NVou0AHWBZ8phYw9QVV47KNU7Y6aAq2maC
 4ElBcuq5TA92rq81ZIAnpuu/2M=
X-Received: by 2002:a17:902:e80d:b0:2d3:a6db:299 with SMTP id
 d9443c01a7336-2d5fd703145mr115346175ad.6.1787166660734; 
 Wed, 19 Aug 2026 12:11:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm17305416eec.8.2026.08.19.12.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:11:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 4/4] doc: add warning about control threads
Date: Wed, 19 Aug 2026 12:08:53 -0700
Message-ID: <20260819191036.679330-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819191036.679330-1-stephen@networkplumber.org>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
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

It is not obvious enough that control threads must run for
DPDK to work correctly. Add a caveat to EAL documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/env_abstraction_layer.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 0e1d044190..f36f9956c6 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -819,6 +819,20 @@ controlled with tools like taskset (Linux) or cpuset (FreeBSD),
 - with affinity restricted to 2-3, the Control Threads will end up on
   CPU 2 (main lcore, which is the default when no CPU is available).
 
+DPDK uses control threads internally and those threads need to be able to run.
+If all available CPUs are used as dataplane lcores,
+control threads fall back to the main lcore and compete with a busy polling loop.
+Ensure that at least a part of one CPU that is available for handling control events.
+
+The effects of control thread starvation are not always obvious,
+and include delayed alarms, missed device and hotplug events, unresponsive telemetry,
+and multi-process requests timing out so that secondary processes fail to start.
+
+.. warning::
+   On Linux, if DPDK lcore threads run under a real-time scheduling policy
+   such as ``SCHED_FIFO`` or ``SCHED_RR`` on the same CPU as a control thread,
+   then kernel events will be missed.
+
 .. _eal_known_issue_label:
 
 Known Issues
-- 
2.53.0

