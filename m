Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E200D59D8E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 21:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C9E4027D;
	Fri, 12 Dec 2025 22:02:45 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 860EF40268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 22:02:43 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b2a4b6876fso225396085a.3
 for <dev@dpdk.org>; Fri, 12 Dec 2025 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765573363; x=1766178163; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GoKAzRdMbvqW5NLBjP7/Sii+s0u+zYrKqzh1nec2NU=;
 b=BjcFxmcEpelr9IkhV6CzdEa7UHyRR8l8c6CW024LNLEg8avxX8qkSWaKnYySyzZtsj
 fvmhlrKqfQHYLzBp/Hcy35trWkb2Uxr65RuNN8UijozRerBrfE0Fs3dbRMfqhAcpl/Bo
 KU06yuCq3ihNJhNetO7nFNqbmgCEYYMZIlLhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765573363; x=1766178163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GoKAzRdMbvqW5NLBjP7/Sii+s0u+zYrKqzh1nec2NU=;
 b=LWpTbYfO8wM7ypncQ4L25c8PWC1/4hD2iuSs/UKUTw9twtaj0/lcPaEIfytXdeMepX
 Zf+i+p0EHObnGPzUyECBMONlweYmG7HOtO2M7nQAqVe2J8hwjB7VvJ08/WxWJbAs8Ltq
 EYe5lKOHA+EMU3aejaywKp/IsiQvewBDANGqaWOaOwaAtDVWp9HLdvWMX9Gyyan0gEC/
 hrY3ObqlkyByMjOkQXYjd3/MYCzqTF2ib7VHthf0RAE23nQb8sIkqE+z0VvJydG2nZRH
 sS2m0shXnZ/BZ0r/CLa+hDaANUs8I40A1xjUOyMqfvc+KRPJ2chlL/6zIavh6WMBry42
 ijvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPU7v7Ys5RRlkdOpV+udF5sMC/NkOOFzZc3lDwB7c+YZ/CcafE7Ew4Rw0em1FC26+g0I=@dpdk.org
X-Gm-Message-State: AOJu0YwtVlTNXn4ddmLZnIdoWBVRlivRgNJAk/6vwHj6WArmbaU1m8r3
 Hm5D4oROqKyLU3cN7VZ2CMbR0Wv7C8Nmyll+DBv8hIAyZUqB471K9dydEeYGKQY9a4A=
X-Gm-Gg: AY/fxX5m4+2UR/yqyKwibIPxmTs+lMi9dkYzH3H7SYgl0JbHS9DCoBhFNPm0AUIKHPK
 IcDykvxhAjOxdVMYoxtnMUuMhxSPMxrJiSwexOwqFkNIjnTMpsdvvhfEjpeqXdtL9aRhieAFYuG
 EqLaiLBtuRWEXbSYDQCMOEs+cY7uzIU9tZvv+QNO+BemIG8mxwvyxnHK/LV/4w8muFX8VORO0mF
 RZIN0WCfGnWqpWe8BLtxVJJikrW9/2XXO5T9LQuCdoqGvDrI4LtjaIaqn020B09yT5vToSKI2Tz
 0GJi2umudP0tev6lSm4aocLURB7x2xw7GOPA+SDX8rXwjKVslZWpfD4VKtIaBhI8R8c8HoufOA/
 NCav/KOGxUC8NtO/+gL8vk9De26pasdcAwU2V+4IsF0fBtSc5W5Cnsjkael2nsofOj8u8aO02CB
 ET32d379BPvqQghZqmuQU5eEk=
X-Google-Smtp-Source: AGHT+IF3O6lfeo29DKObf+ZRnsLExqTvtYWchDhVZaFi2SfYZ3Enia/xIqmpTgzmZZEwz45XN1wsbA==
X-Received: by 2002:a05:620a:4116:b0:8b2:e402:20b4 with SMTP id
 af79cd13be357-8bb398d914bmr577971585a.10.1765573362691; 
 Fri, 12 Dec 2025 13:02:42 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993b62653sm706386d6.16.2025.12.12.13.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 13:02:42 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: show missing NIC capabilities in DTS logs
Date: Fri, 12 Dec 2025 16:01:42 -0500
Message-ID: <20251212210142.669766-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

When a test was skipped due to a missing NIC capability, the logs should
print the name of the missing capability. This has since changed to show
only the integer representation of the missing capability. This patch
restores the previous behavior of printing the name of the missing
capability to the user.

Bugzilla ID: 1803

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/capabilities.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 243759668f..d80e59c1dc 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -219,6 +219,9 @@ class NicCapability(IntEnum):
     PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
     QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
 
+    def __str__(self):
+        """Override the default string representation to return the name of the capability."""
+        return self.name
 
 def requires_link_topology(
     link_topology: LinkTopology,
-- 
2.50.1

