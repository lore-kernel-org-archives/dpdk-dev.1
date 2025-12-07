Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C9D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 910D14067D;
	Sun,  7 Dec 2025 20:13:14 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id B2C41402D9
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:12 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so41502755e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134792;
 x=1765739592; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=yPsZpxcI4WlIUOpM8NRsl/YTpydNX+FDSO04HP8uHzgGgbGCsxsdXP3I+MIiiravnk
 Vfowo6lxLbQ5LzrEpw3GYmJI8DER8WhAhK8w1WVGkYtLXw96MnsCgGPDBN2dlJA+oTWf
 a2zQy4GuwI66danPDVwVVhNlrF79t/ppBvKrjHijWyTjGc7hU1whGqVpdvn85cgs8fgh
 y4pO0PLF2oieE0X6TGHjlR1wVuLi7ODaGE6MspNkM0wgZZpn9Iu4KoE4hfZ4S7+ScZ9G
 S/GOGWBkPD0XsdQbTrWJc6Pf8/q59x51uMEqa3OYZd9sqoYJRj13Ppo1eb0iUHUhP5FX
 0mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134792; x=1765739592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=Plj2jD8xXoOrdqNiLzkq4rL/Q5TszvfC9Jo8v07zTt+DCnpggeWf+BItgxBQO44v00
 udropQwpNSuApdVos2zvhPq6PKKZk0IpS2RpEtWSF6NpEaaChR1py6aLcgbmWZ9eOy6u
 ZpGSNRDK4EkxZuQVM400T4aDcbcbadA10RY+gZ7DuBr4WimFazYm2E2bIRhy9+WxYhXI
 JhWKPtkE21k+cSack+e8INPTggI9I7VRCVJuyRt9srguNp8WFs7oKFCde6Q7XqDCwfez
 AnkJcvpVXP8nvt5Tzj+L7IQh6QSzXZDa9GRuuI1S3lcuVST/kOeEwv/fBEZoroHDFw3B
 y2ng==
X-Gm-Message-State: AOJu0YygWDFOlo0r4QW7PEbolyImT2zmWOXo43V99V1n+MV5uNL6an1B
 3SKxRyERdY6ZW4c26sBaCcQbrLPRbYef03R8UDxbUHSw1MR6cqOKm3kFStWIC508YHie+JqwdEM
 ePrcO
X-Gm-Gg: ASbGncvY2e7LJy5RCgX8LutEwx9llJl3T/H+7dI4mt8wjxDIYQ3ldeQdj+loCsAXNT9
 uuFpMdcGnW+yFzcRQHKVeKavHOMbPam2I8ffSYTvEX20ENTP1IOoBHSay2JaEllXp502bZ+holQ
 +DcVDcsPkEzNkaCzcR3smNIb/9XGzj/3aXpmWN2ZEloJJWviY+jNfKoAfhUNyQxTZ6gLJdutdCd
 Ud2qDfl8g0hG+Z5jTfdgN+gS1/x3VPWW4L0oKDGwhvUMeSpxBzmqwp7uDhIK9vtfRmV91gVp3X4
 +IbcU9ICEPGN0KIDeaPlUA8rep07GndWeoYZ89erTQ6u2++h/GRBC1yKUUyyTNtcI90mD7KmyK8
 WA5oPZZgPgneGuGVFwyhlvUz72ARCTzOO647wg4zQB2Lzm2NuHYD7Tm1/MsKr38c5QLuGZqwe88
 y14U8ZTiO762LJ82uLK0rKEyGagSanBJk+4rrMKA+7XlJahjWT3A==
X-Google-Smtp-Source: AGHT+IFEWbStDH3rafCuKS5MgvhaG3XlwRWRPWUpMSCDHmdFZdhexnunQIgYo5FaMRe0Xspns0grzQ==
X-Received: by 2002:a05:600c:699b:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-47939e48f21mr72080165e9.30.1765134792258; 
 Sun, 07 Dec 2025 11:13:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 13/17] eal: check tailq length
Date: Sun,  7 Dec 2025 11:12:04 -0800
Message-ID: <20251207191242.165619-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_tailqs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..7502836c6d 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -67,6 +67,11 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
-- 
2.51.0

