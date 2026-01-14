Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1031D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A0D4279B;
	Wed, 14 Jan 2026 23:25:53 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 6755A42792
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:51 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so2742995e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429551;
 x=1769034351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOYessxq3Yfd/vAKoffdIn2dwAXDewVzuAbAB1m+W2o=;
 b=jL4OxMDYZb7tJKbC83su7QoyrwDTrrO3FrN6jiAIY1Q9YKs4NstDqdqlscW1dNrs9+
 cL6NUDSke2LvBYTzHFqfqwE2V46uxlAVqaZH1cS/WrS3n72nLSv0CUsICqW9TObzHrnW
 07HDCIIRE4mtHMZkQa2NjaM2HaZ1GlKLtN+1QhoIFwnHXd+lM/UyoK+DkAzujF3VwcMJ
 5bCFLy/4H0xlHAdsWr57vWFSvU/yCUuJZ9EY28T4lte2SHDFmFRiGMbzc6YzB+E2sIy4
 g6XsWZzvL+Y1rggNmTJhrL2HqhMTGD7NioxJ/RX/Fgn+plMEHcnWlbZunfWw4KWT4MCS
 OrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429551; x=1769034351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gOYessxq3Yfd/vAKoffdIn2dwAXDewVzuAbAB1m+W2o=;
 b=FGvNuqe13wq5YQ3IZb8gHNx3rQvBk4H4jW864StxPD+1W5vn2F3ORsu6ARAzC9Wxlc
 bt5tytQntTUt3G3CusZAp9Ou/AbCXHNny2qvncLQYHyJR9UFVe+NhtO/PlzIGW1tIPzB
 yQ5dG/jDYvJNW2Fdpyq9xdwAhEgv/XRG1/MSPRoZbqUiGW+nbJ6izt5Co/LxwFYZomJ3
 aJyIIdgzH6Vi4HSc4pWaEc6W8N31HL3kX3jt6xg/ZJhilVpZCJ5H0Dn5t0i4i9RjsHZr
 5QkLDVtI9yxBN5ka/RpxEmpMTZgyoKYl1Whkz1D27H145k54sbT5tncnGSStWj54lOrO
 HNCA==
X-Gm-Message-State: AOJu0YyJ73utYzN9aPEJwx/1/P9goEbFWpXiwjRbOUyWVIILFVCNxrrC
 kQZY0ui4ArZ3FpyOkOt04Szh6DDnu4dmbCiI5ZRYZ1cYtEx5Ov6mAZLNl4l8yEd94vxMCkQHFwl
 QOgEt
X-Gm-Gg: AY/fxX4rA0K4C+Dz11vFr4cJDbARhOVN19sriuVRb8DHoatFl+2SIvG04I4VpzJ3YEt
 jmIwp1lrUYEf2BM/q3XsVbdrE5vorTCQ+LyeqnsM2cRHaRLqr6gsC0e702VZD9aX/B468rzPTaB
 xq+THBlaUK+nDthfP77drdUK+ff60b3Uq+fICTRbriaTzjvtOgfEPn9BkDqTMGVarVNupzknZzK
 B33YRRBvS1pzpV+WoShmYzP/i4jERBDE1NZjP/4E8iFUQkuO5jp7TGUuLFrJae9YR00ZgR2GOc5
 aYCvb6+elrP3KBEDQjbin0X7cirpcY7UX+tPa283fNEIaRa0uoORomvyz2WXTYuCm4qfaKfv1+j
 zGaMZ3bDNUQtXOZfYkqALGwCa4rxQ9YdNEvj51hMCUHT+51xVPxC0vOKBaEAB2uLOppr0NxC1io
 5SwP9+hpX+9OwBPw9/xCf5SUKZRaW0ya7uENOspaqSCIBPATMhhg==
X-Received: by 2002:a05:600c:83c3:b0:479:2651:3f9c with SMTP id
 5b1f17b1804b1-47ee32fd063mr46957795e9.14.1768429551040; 
 Wed, 14 Jan 2026 14:25:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 27/29] doc/guides: improve keep alive sample app guide
Date: Wed, 14 Jan 2026 14:22:08 -0800
Message-ID: <20260114222458.87119-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

- fix "Cores states" to "Core states"
- add missing space in heartbeat period description
- add article before "Linux environment"
- fix "Keep- Alive" typo and capitalization

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/keep_alive.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/sample_app_ug/keep_alive.rst b/doc/guides/sample_app_ug/keep_alive.rst
index 8ae9d7c689..aaefeefe7e 100644
--- a/doc/guides/sample_app_ug/keep_alive.rst
+++ b/doc/guides/sample_app_ug/keep_alive.rst
@@ -19,7 +19,7 @@ The application demonstrates how to protect against 'silent outages'
 on packet processing cores. A Keep Alive Monitor Agent Core (main)
 monitors the state of packet processing cores (worker cores) by
 dispatching pings at a regular time interval (default is 5ms) and
-monitoring the state of the cores. Cores states are: Alive, MIA, Dead
+monitoring the state of the cores. Core states are: Alive, MIA, Dead
 or Buried. MIA indicates a missed ping, and Dead indicates two missed
 pings within the specified time interval. When a core is Dead, a
 callback function is invoked to restart the packet processing core;
@@ -58,12 +58,12 @@ where,
 
 * ``q NQ``: Maximum number of queues per lcore (default is 1)
 
-* ``K PERIOD``: Heartbeat check period in ms(5ms default; 86400 max)
+* ``K PERIOD``: Heartbeat check period in ms (5ms default; 86400 max)
 
 * ``T PERIOD``: statistics will be refreshed each PERIOD seconds (0 to
   disable, 10 default, 86400 maximum).
 
-To run the application in linux environment with 4 lcores, 16 ports
+To run the application in a Linux environment with 4 lcores, 16 ports
 8 RX queues per lcore and a ping interval of 10ms, issue the command:
 
 .. code-block:: console
@@ -85,7 +85,7 @@ similar to those of the :doc:`l2_forward_real_virtual`.
 
 The Keep-Alive/'Liveliness' conceptual scheme:
 
-* A Keep- Alive Agent Runs every N Milliseconds.
+* A Keep-Alive Agent runs every N Milliseconds.
 
 * DPDK Cores respond to the keep-alive agent.
 
-- 
2.51.0

