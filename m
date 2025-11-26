Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4898ED10F4F
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 14:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 266A44042F;
	Wed, 26 Nov 2025 15:16:58 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id D96A9402D1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 15:16:56 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b2dcdde698so990096285a.3
 for <dev@dpdk.org>; Wed, 26 Nov 2025 06:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1764166616; x=1764771416; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75bmXW4YkNuEjq0LwXTo8a37DYIJmZsYv8Fa7+yrQ3k=;
 b=GO78n37TrdIB2n4wdVlB6pY68jjUXWqByphP4eT7rSLjL+Q1UC0yt/KL2n92suNW6k
 8/9eK8pW9SfAKrUBKHH8rorusZJu9GvpKG7laOfkPXkHZGwanQa9ozFoD/qg/6lBHjMA
 EJ14CW/Vm8Sm0ayq46RATqdfg36MXDebHJ0UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764166616; x=1764771416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=75bmXW4YkNuEjq0LwXTo8a37DYIJmZsYv8Fa7+yrQ3k=;
 b=p3Cpi4J5Q/EJGQgRjP2KS6etu4BomkfeoucdRyOB3vzFVB1nuDSG/cn1Se0ZhP1TaD
 NfjEIHLm8LnW7464BFVbCgl/G1ZJXe8XLrAp3ayAPiX4lokLmPytEp4LrKsxK8AWlwkM
 pqgVYle0/aUfGAMlQYqz4728DFejGVfJsvFu1Iy8LU04YxRnO8OEySF53Otc0p56oj3P
 dwJ7v97ZR250YzqutBvuRzS/aIi51LGFPNn3Q4YlL5SBPZfEtvl6UTN04wgNBIzvyWJE
 Mxtc98SocgltHfwHcXbnvyoi9NsLuXZZPjn1Epl9PbnHKQ7Sb63Ftt8p/iFH5693gMmJ
 wz+A==
X-Gm-Message-State: AOJu0YygpvgBHv7STHNHFFvqkLvJQNEt6lbh/m+Mek//lA6E9hK5z9M0
 6UjlpJhla/ao0a82GRPW71rRbVWIPeTmujONgfg1sfQLYM6tG0IrunpNIuX8kVy2+q8=
X-Gm-Gg: ASbGncsd5VWMTviK7tSF+diIj8JQH7yDd058dfDfulUnHcG1i/gOmBfMx/rz73LSTWu
 QO8WWoDqNo02w77IITenCMpeBBIXsnglUSEXAr2wzrdmb3a/n6RBAxANNC9+FS7S9JnWUCiWv/F
 ttiW+EjXYCc0LapmHjgIfHg5ug+pOpGsTqwaJGFGavnuWCMfdgRDj8eXkXAm8kgamsXuQINLSi7
 uXy/g7ejMROazFWhdsw/ZgLHwQUhlRuvAmdsDlZ6j1trSF+wtMoIyIW83YgvUkYUYw4rqn6cGe7
 8UJhG/eAzQq/EEDGbJN7Am7QUToquPpwnDT7+SbId6j1nWF0+CuZ/So/sHhZiivSlEOlHg2NCIB
 l/kFR+Mc9R65rKsxcqG0Bm3WTdWNeBor6LRWhNFaOYf16B+AP0AyJavOg+X4QLRxwdlz2QghSQS
 Y6tmET90Jx1wH2zOZvHRJ2qPo=
X-Google-Smtp-Source: AGHT+IGeODGALT/WgBJKAIw/0lsiTLtA5bc5KaSC71ZsSBVUTHpKRcwrBOBqVzehiG5jeylJuh19Pw==
X-Received: by 2002:a05:6214:4a09:b0:87d:fbe9:9566 with SMTP id
 6a1803df08f44-8847c4e433cmr290103726d6.26.1764166616116; 
 Wed, 26 Nov 2025 06:16:56 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e48a64asm145590376d6.24.2025.11.26.06.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 06:16:55 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: automate VFIO-PCI modprobe
Date: Wed, 26 Nov 2025 09:16:50 -0500
Message-ID: <20251126141650.367633-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121210650.328804-1-abailey@iol.unh.edu>
References: <20251121210650.328804-1-abailey@iol.unh.edu>
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

Currently, users must modprobe vfio-pci before running DTS when using a
non-mellanox NIC. This patch automates the process on test run start up.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/test_run.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index ff0a12c9ce..9d7b6271c7 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -106,6 +106,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
+from api.capabilities import LinkTopology
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
@@ -347,6 +348,13 @@ def next(self) -> State | None:
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
+        if (
+            test_run.ctx.topology.type != LinkTopology.NO_LINK
+            and test_run.ctx.sut_node.ports[0].config.os_driver_for_dpdk == "vfio-pci"
+        ):
+            test_run.ctx.sut_node.main_session.send_command("modprobe vfio")
+            test_run.ctx.sut_node.main_session.send_command("modprobe vfio-pci")
+
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
 
-- 
2.50.1

