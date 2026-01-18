Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65727C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E028640DD3;
	Sun, 18 Jan 2026 18:00:14 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 3CE2840BA3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 18:00:11 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so20404055e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 09:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755611;
 x=1769360411; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ees6+GvULgZ4xSSaaCmfZI9hrdCK/qoeNeBjc00xqFg=;
 b=DxQg+gIuCxKo6CLZEnNsMB/iiOKYGD7Wrp5qOxlVUIJVDQ3p4Tu2dOL31ic00DVFZl
 qyVHXteJOKhz6y06ZoCBUgBwwgWzTGcywU3v6lZXYR+JD3UGGNfxhMmpOQ6mRpBDi07M
 NjY1ubAMkx+iOk7gzlG2uhT3xLV9vs1D/aEzydLC2Bp14hMxjNHXFut48G4QLdXRrrtx
 0dv020fwGU1Et/AhZM5mVw0ijnnceJA4vVbFWgdzZy/kyPwmECnFubWEo6NIUUsIGDbL
 fkMgHdFDx5sZtEobOFLNzpQECvDWMTqs7zHD9YAPqyTETvQNzHcej1EAEQFQ1jxOKERd
 tgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755611; x=1769360411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ees6+GvULgZ4xSSaaCmfZI9hrdCK/qoeNeBjc00xqFg=;
 b=B+r+WZlnpZQE3b4+52dttuCSwFG4dQhMup6MOHGRpxSUeKNG3wRGTTcTyEBgLyGRDc
 A4+96gzPBKInbnMBTwRJbrfGro4hoMlaAxVBBp67v+EBhzEghN2m5mgw6EiSgN77vLs0
 0n7tDn1t+2xwR2hxlsXZVLPOj87Fk9xLyxJzAMaUgBE6e+ywc7W8h0LFo7jRCAD7qs2k
 PwinwZOW3wx1E/sfrv5e1/uRTD/HKnHNRTUGKbhr+xexj947Z9QzQgt9c8h7nA3sf/lK
 YpAGMsjo5eKbPYg2LQL2e/tjPitBxMsEtlI/yQoYDPri43BdqKvgj5Q7wiRmd6NI/N3j
 4Kog==
X-Gm-Message-State: AOJu0YxhmBJiuJvfXL0PtgP5elMYHV6hgzhULld7abRyPGExfUs23QgC
 mmOYA47Q3Ng3yBQioYFXVyWoqQlBcWel/HnISiF/+e/x6GN44kUiVzA3DYfvWxH4a+6MjwOgYmU
 cEKow
X-Gm-Gg: AY/fxX77/7Zayj3j+sNpkCXbkVt4+0Uabq6sfekQdXpdZV+nIR3/PUjlmne3ZjF8ETT
 ils+jBUqWYbZLer7Tl3YLiUR5sfpaDNkPD+doCl7pFB1AMS8e5jNxGWr0F7QcuFrIB2bcf1ueVy
 ztgfnv5KtahSvJmT8XyKM1174IXXASq6K70BaKw2sJ5zk73y9WJjinpO8N7ClfDGBTrXIvItPXI
 FWjtycouVQckWlfPIjOsqbiTQ+fGKpvh/K3tBmvvQzD/82X9PyeJhiM9QUH817kI4SEwfvmV837
 ugGQTkuVayKNzDJDXsI+CnJho8IqHoTpoCQFg0y28rA4aC//hzX3vvE0qUzDl+JxCD2gvjgzMKb
 5YMskZZngxAPBXVZEO+b/gkOrEuS+fEDIBuQu2UZKR6qt9IEBXZDWR2yJ+kLGRWUBpBx85l1Vvq
 6kBj46SS8/p6J4yWtjj/6zfKmzBioaMZwrZip6w7osCT+3saKHwQ==
X-Received: by 2002:a05:600c:c170:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-4801e67082fmr117162135e9.9.1768755610784; 
 Sun, 18 Jan 2026 09:00:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.09.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:00:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 11/11] net/pcap: add release note
Date: Sun, 18 Jan 2026 08:58:46 -0800
Message-ID: <20260118165944.41374-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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

Add a release note describing the new feature
and offload changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..5550f17416 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated PCAP driver.**
+
+   * Added support for setting MTU in single interface mode.
+   * Made receive timestamp offload optional.
+   * Supports VLAN insertion and stripping.
+   * Added unit test suite.
+
 
 Removed Items
 -------------
-- 
2.51.0

