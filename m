Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85185C36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F2040684;
	Thu,  3 Apr 2025 01:25:01 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id AC9324066E
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:59 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c3bf231660so34179085a.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636299;
 x=1744241099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41jQV97CL86Dj86c2tZ6rb77JT2NOKjYos6sIKH3q9w=;
 b=kTlK4HyMsX78VqkTqv0++rVfIKWjFjoPQCjSvj+z2phfDXYuMGr6v/E/9cnfAMIf2v
 1Ep2/BiN9tUXUwbYRLyRehzqZacgZTiUZiv0JpsTfrIFrZdOxp4Wnxcu0Gt4pUczu1oj
 YpiI6T8uLcbLnnaYad/W+fhG52aGF7P6oW1lfer+17fLAe99cwJlA3v8yXwEA+33g/8v
 z+c5Vdznt7Js21kZj+alR4FZSmGF8rdQJOnoZ98UQRHGaWM0e3cupCBbgY496F9huXjn
 bvsmLsgwve1uayDPALQyAyTUAI3EzHU7tqki2f3Ivg0gmx79D6XmAh/mx6tzt++3o3Zv
 X2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636299; x=1744241099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41jQV97CL86Dj86c2tZ6rb77JT2NOKjYos6sIKH3q9w=;
 b=iMK79bxOZgmZjpQTCgFVevZBBs0wfUZpQgYjKUw7lJm9L08itGN7z1I3/N3X6Eoz/k
 hV6jRx5GaqPRjjhYDCHwsyrXFWa99tEZhHi9ct5G7cNz0xiErQMgO0WK4cmdSxkm4K6u
 6kH/lwK7jYqcN8ifZ7RofBIiBcIGk016vaHKwQfONFnpWpq/zJENiR1s78lr5U97rS34
 Ma8+d7Wx/az6CoXuYlHw0l1DP8i7PyqR+ffWh/4nf/UXEraGenpYTO3NWV6aB4UV9AaJ
 l+LsbuGbKqZnn9Ib8TBkaXkXlGEQkcJLYb9vfjEQ5OHdaOF0rK/pWhJ0uF1W03XrLGd2
 hHyQ==
X-Gm-Message-State: AOJu0YxQN447dDBYorgoLBWn92JZ4rKnxj3fQerZc2Wyiap7veDJq06b
 gPS+Zpdx8YmuvuzQ0IkARpe7NwW+IwPtU5behJ+zt4eiyGaJkhfXANXduiPLP1HdHnKPZopyQhz
 Q
X-Gm-Gg: ASbGncsAbqjoH/8RSLGkdgoKwfU4DZJIu1ZH9YMlyFXu09+m5e7uhi/C5+t90sHYBGz
 lgf8re6/9y5gN+xE5nI5Z0IxFLfY9Sd1LiatOOx218Ah8X5TzMTbsD45dDdt9Knqf2NNPvIt0C1
 slniQc7+t70NgIFL3WcB7YJ3vIZyPHg6Cj6UEYpC9E50enNG/p0aMjRhwY9H2FXaSBqkc0IWWux
 fjRDo6336229mJ8+YzL7cu14J0RLb4WDpBUJM9JKm33jQLlqh+oIn9At7X6Bfo0HHFC5z5TY0Pt
 CZT5iLxWRpkiwqx+rcExwCfC+h9YU02PAG7E0968AnWQEMoGYlOxUjiughQPQQKBNUz5rODnTeP
 C4j7AGFYm0Ozsye6abA==
X-Google-Smtp-Source: AGHT+IG7Iz2lxqk1VFZ9tH8y243fCahkQLwlw+8dg9inVZGqiplXheTeG/pn5G2SrqwAMKmaZuuDyw==
X-Received: by 2002:ad4:5aa2:0:b0:6e8:89bd:2b50 with SMTP id
 6a1803df08f44-6ef0dbf8ab6mr12652776d6.7.1743636298961; 
 Wed, 02 Apr 2025 16:24:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v12 07/10] dts: replace use of sanity check in comment
Date: Wed,  2 Apr 2025 16:23:17 -0700
Message-ID: <20250402232441.440346-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Replace with better words.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 dts/tests/TestSuite_blocklist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..82109f72a1 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -22,7 +22,7 @@ def verify_blocklisted_ports(self, ports_to_block: list[Port]):
             allowlisted_ports = {port.device_name for port in testpmd.show_port_info_all()}
             blocklisted_ports = {port.pci for port in ports_to_block}
 
-            # sanity check
+            # ensure at least one port is allowed
             allowed_len = len(allowlisted_ports - blocklisted_ports)
             self.verify(allowed_len > 0, "At least one port should have been allowed")
 
-- 
2.47.2

