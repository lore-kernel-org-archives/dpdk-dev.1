Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50662CA1017
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 01:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 327E840264;
	Mon,  8 Sep 2025 03:48:46 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id F259F400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 03:48:42 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e8704e9687so443708285a.1
 for <dev@dpdk.org>; Sun, 07 Sep 2025 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757296122; x=1757900922; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jwTYMBICVsocERHo9EiiIjg2Quwdw/gMrZx3bLTXU58=;
 b=fyaA+4la97KNIF0mWzFShsT7Fq4aftARClEMTXtcZrUDlUNwPXXJHkGgrmQp1VA7V/
 O68nNl6VUTq18MgBuAUpKsDdT+RuCE9bvRMlVjJ6uZBCzo3RC0+wVK20BFYDfiUuJaSH
 t609XoY3hepRpPw2V1dMvsyUgOoF/2uuyw7jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757296122; x=1757900922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwTYMBICVsocERHo9EiiIjg2Quwdw/gMrZx3bLTXU58=;
 b=HdddTcOux6bI/XwToUl7ZRZzuXTQD3q9+zmpxvxP9ulKVtkW/6DtbcPMo93M1SdGEU
 qa6qWMxRb1fgT5xEUiEErk2prvh3/nanpFNiHcFcy+duC48pLWdaEEc+bcmVR3PR2mJ4
 dgB5t4lsADhJVPFmlB/Nb0Zj8RtnDbqiiu77LLmPEHUjYwdKpGOPOT/n4l/0bUIUfCMi
 4D+ZNhMC0q6rctBLeZzma4+kldPP9S+ReMCSQRK/uw+CedzkSz7syi9aeH/h/awt9yu2
 zGxgFdFdxW5xrQFLkC5UEMgHj+sVj+jg1GehHyc0SNjWKmevUyUI1DFUXcFQPkG6x5ES
 7SkQ==
X-Gm-Message-State: AOJu0YxOdh7ZYKEM9KjV80Hao1bjv0oWgeSCvUmM7CR8AIUSWiKwR3Y9
 7VIf8QII0ZmSC15NJQda1BX8XBu53IIZ/Vb3pNtRRi8FlgpEvKorrsWFDj2I9k2JwGw=
X-Gm-Gg: ASbGncuLXYeKdDbTgzCwFngJ9c58zhP9vcYO+LxI/F/3LPgLLKoCxKjfHrh3LiX/f4f
 h/UwO/qhqIi1wy6q+SQ7kjMLVc2rYPCUjrx4/w9vELyB4EOBMmOLmF/DHmDHgZWxCEgKFmQw+Io
 PKBVSMBUNRhERsIF0RZpBTuqgKDAienz44LZUDXDLYfopQp2kmqdkPCD5DFxr7k8ueXcEo/SUGf
 w58FhHtVbrCkIA+xOnYsNW1O//LOzS0Ux4rIhIkaW1oMd+lnLj5XuCCwonGMEN3Waxsmk9fJkWw
 iGCON06dIq0uBju4hB4u+UsVpfu72yVqwIdXGyTIlxJIWNlNZmttYbiMZ/hKQDzc/tK2yKYkHW4
 XHx7/E0zDjXKnIQ0uK6ZBPTKTiQujSwgd1xs=
X-Google-Smtp-Source: AGHT+IEbJMrDL5iK/kgourlVmdP13guppl36GYWtqUJBtWB6SD9Qu4cwZhmxm2d9xe4cmEyOcAzwpQ==
X-Received: by 2002:a05:620a:2587:b0:7e6:9961:fd27 with SMTP id
 af79cd13be357-813c31ee357mr582560885a.65.1757296122061; 
 Sun, 07 Sep 2025 18:48:42 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aa62c7c98sm969758285a.14.2025.09.07.18.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Sep 2025 18:48:41 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: add dpdk shell warm up period
Date: Sun,  7 Sep 2025 21:41:54 -0400
Message-ID: <20250908014154.82938-1-probb@iol.unh.edu>
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

When running our existing DTS testsuites on a new
NIC we observed packets would not transmit from
the traffic generator to the system under test
even after DPDK testpmd and the NIC under test
had indicated readiness through the existing
readiness checks in DTS. After adding in a warm up
sleep to DPDK shells, this issue was resolved.
Correctness is more important than execution
speed in DTS, so it seems justified to slow down
the execution a little in order to make the
testing framework less fragile to such device
specific bringup behaviors.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/remote_session/dpdk_shell.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index d4aa02f39b..b0868d32fb 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -6,9 +6,12 @@
 Provides a base class to create interactive shells based on DPDK.
 """
 
+import time
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
+from typing_extensions import Self
+
 from framework.context import get_ctx
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
@@ -84,3 +87,9 @@ def _make_real_path(self):
         Adds the remote DPDK build directory to the path.
         """
         return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
+
+    def __enter__(self) -> Self:
+        """Overrides :meth:`~.interactive_shell.InteractiveShell.__enter__`."""
+        super().__enter__()
+        time.sleep(5)
+        return self
-- 
2.49.0

