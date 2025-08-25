Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C05CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42F3140A89;
	Mon, 25 Aug 2025 05:42:48 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id C871C406BC
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:38 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5b8bso1232445f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093358;
 x=1756698158; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJq/DfnjEgXdDaBJ4ECxioWjiXBMzMF0qNo7WPU1g/I=;
 b=tfIbuRn9VV4ww9ReF3Hsu7iwPSX0XgXF+i+zUG2oTghD9slp3qmQGDZqy/8X8/3/y6
 jXrZtl/ET/x5+ExhXg1Poqz5Y5Uz9Lkas77XnzPt5wVN3t1yAZ5lyxdqYARavfSGBIIa
 hRS3Www3dQx3DhqfTHiYe6gPQvbG4iJl5V1lX6V/MQbW7D9VB7E+oKOf1V4CWWgHHh0K
 G5oMbfCsopalWTJZdQe7C8AzTgZp5MfiMD6qTnr+Vdq1DheqaHVb+Dy0FYIrHBybk3+L
 bWrMiuT73x2wsYodq4YZXGBnyjsH0vN4MyWtjiNK93dFsqjA5zvAy5oys85NkthjcB13
 EIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093358; x=1756698158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJq/DfnjEgXdDaBJ4ECxioWjiXBMzMF0qNo7WPU1g/I=;
 b=u3gl+52yN39pI9+/FwzBIHmy1B8J6AOZrVkskq1txEv3ZbrS7uVKP60XIpu4EG9gun
 aglzvdZasgENN7fsPQC3wISumjJeaI40ffCUTx7zAxcCIuzvg/lVtDGONfOkj2VKEm9w
 LW/6ZSIpTg2JNQNtL7AgiFJ5TSIyT7dfr4psq1WD1pewh/n+ex0IFCwqm3rPDXVEfNfi
 +Mluht93QbcB0LQXqwg6nimB0vpHvyLTXCluWK+9WHxENF2eeN9PcYHlrwj1sJZ0zV5C
 WGkBuAL6RvGY6/kuk7sRtmrhjSF/Pemz/uc7gEuf0dCYwQ1cO56oj0NxbqbhrQfKuY7s
 H7Jw==
X-Gm-Message-State: AOJu0YyqanGb7EnqN0DJpcSjx5BxTUkS1xvtc6IbJcuiWsxrzaGWS6QV
 9YZ5yg8oc7sOTzpMA67gVDHnXfctHjhtFsEbStWekWdKbteYtwtGtmdcDObqWY+HXTAjYwRSyuF
 MlR4l
X-Gm-Gg: ASbGncsfa2L9+JXVGD1vNZTfOdvkyD3khYzqZiaKsgDu/khDrZe3/mMkY6YSXk+Sf/g
 MHlY4LsLMvipMQOogt2w5vCNK4H51SdAkr+u4XG1sUttfCcmONCF+VWIHzyE2xIAV8tqlu+FCgu
 J7P1R0gAxsLxR0HSlGqdXjSRuodBFlK3dkaJvc3VcH+/2fEPLvSdr06mNI7VeKi8AYBrDF07b6u
 bYBrVMWDNwHMCAx38wuMqQ1G+wgj5CM/v4jz7GwgGRFzmlxKG7zMkaWkAkkCRH7rK/DM/YH5UP9
 KcubO2pMTDXIH/LCxK319QYcjJ8yabhzkuuxM0MVYl9Eom6Kl5NnXjEUhLP+kxYnhxhQFc7RM0U
 WV/S5qMhKF9Hspg0opnS/faXmAHyHhz8orATf7Qc6FACPI5ND+9NfiBXCZI7uqIbxfaH8KbsL
X-Google-Smtp-Source: AGHT+IHMor7oD8XIsRlKF3BKtYJdHUrSsaXn86phn4nwgol+SQq+zy6XegPZGhWELgXDU5UjqHzDbg==
X-Received: by 2002:a05:6000:381:b0:3b7:89a2:bb8c with SMTP id
 ffacd0b85a97d-3c5db0eeb6dmr9333491f8f.16.1756093358420; 
 Sun, 24 Aug 2025 20:42:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH v2 24/43] net/enic: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:37 -0700
Message-ID: <20250825034126.12046-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index dc1d16f7d5..7c16356a58 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -21,7 +21,6 @@
 #include "enic_res.h"
 #include "cq_enet_desc.h"
 #include <stdbool.h>
-#include <sys/queue.h>
 #include <rte_spinlock.h>
 
 #define DRV_NAME		"enic_pmd"
-- 
2.47.2

