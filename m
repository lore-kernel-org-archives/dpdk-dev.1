Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6A109879F
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6B41402BB;
	Fri, 20 Mar 2026 16:46:45 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 640AA402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 16:46:44 +0100 (CET)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-79885f4a8ffso20024817b3.3
 for <dev@dpdk.org>; Fri, 20 Mar 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774021604; x=1774626404; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaAz5RZqPrl/qppryBthCPUO96KqqQrADcT8YnPwMOY=;
 b=HPp3UPLJI05QX+n0fmDTeNMGxVA3PElPhJEiPm1fjvPSVNw+sVyewJQuYu5JlKouEe
 7hTPiIYF6hmU9ovUt6sAXeMghcYEDPAHzeyUvmD8p0qaapENVJxk49N1vcIg6A+JhM/+
 tsH23MVDv6nSIIK8IKSMGcGum8C73pHfwDqB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021604; x=1774626404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oaAz5RZqPrl/qppryBthCPUO96KqqQrADcT8YnPwMOY=;
 b=qymkldI1wSlEDNWIivZrWEiKVUzasnMby1npCSQaNmfnG504+Pi/geSD4TV9wA8fa9
 UDnXB8qR9LVtFN50V9wfyObAZgxUWDH64cN4yXlVQFJo5u4hgt0u/0uamHvotVVk2p6R
 FTfHziJcN2IJCSGk/gwzPdto0D1zUrn9hNKvENoMUiWxIsniBSAxx/DEt8AKC6eC0+6x
 oH+V/o+QzC1XvaljVXRkvs5ZbA+ZcAHSn+6Oez8OTQkWOaRLs2KCd8fgU5AN5OkyEG5E
 cwglnrUzyJpvMybeaGphLR6anm7KkQe0kYBRZ00jKzI1otL6MXiolStpTUB+XvqpVsJb
 6CBQ==
X-Gm-Message-State: AOJu0YzvD6cRXJNXtsJoV4E1ae6AE7IAeKy/hUNOI5z2SJBR4LUHbctJ
 muryAzoWLl3RaJG44x40pak7srX0SefSA05Kr9Wav8ufqC6l6vkZhHDooJh8xPBwcAc=
X-Gm-Gg: ATEYQzxIgi5cwveGivH8bqNCq1Ii06Mou0WtggAiYkcmdjBSMkipQB2G6pgu5ngIgl+
 A/z/aT5cfk6R8W4LkHPc1cl0yMOYQxr54/Wty0OiFK0SqN8eFlwA3Cb75s0/ZunaqQFfzCvw5hN
 oz9Qph/RWvSZZJWmG36SNQoiroN37wHBd7q12jiVeT+49EF/qq8P6id+5FZ5HCLMQtZjhb18u8Y
 dCte5x7ZI3pPKsb2XfZnnRfUI2Ls4tt4DshuUKI8SWO8VGWQcw3oManKVMbaMbMor91lKrF6cvu
 SrBo2aYhYktyWl+TGIuAWCzjD6xMSGMm/eM4t/MBWoUwDXX0iHf3i30gg2hspNRTGgRcV7wT6tX
 VBqI3EVbc8I/T1U8YphJEsMOw/ZZ1VYuezrfX0z2RgBQ6T5oWw64Amar39dWdm+QVMn7VwT0YAa
 4LOvrWHfMuxsLnp6W/iTkEow/Z8pGUSFR7YNSYUZ4ivjEXjkF61AhwaI4xaneK2ZecLdk9EiWO
X-Received: by 2002:a05:690c:9307:b0:798:95ff:b090 with SMTP id
 00721157ae682-79a90c2f146mr28906067b3.59.1774021603593; 
 Fri, 20 Mar 2026 08:46:43 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8534f9ccsm22908056d6.39.2026.03.20.08.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:46:43 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: update overall result pass/skip logic
Date: Fri, 20 Mar 2026 11:46:41 -0400
Message-ID: <20260320154641.21334-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313182240.130379-1-dmarx@iol.unh.edu>
References: <20260313182240.130379-1-dmarx@iol.unh.edu>
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

Update overall result of test suites such that
when some cases skip and at least one passes,
the result is a pass instead of a skip. Only
when all cases skip is the result a skip.

Bugzilla ID: 1899

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/test_result.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index c6bddc55a9..66cd67fd48 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -45,11 +45,11 @@
 class Result(IntEnum):
     """The possible states that a setup, a teardown or a test case may end up in."""
 
-    #:
-    PASS = auto()
     #:
     SKIP = auto()
     #:
+    PASS = auto()
+    #:
     BLOCK = auto()
     #:
     FAIL = auto()
-- 
2.52.0

