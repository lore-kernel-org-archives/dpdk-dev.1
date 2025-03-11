Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAACC28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F65240653;
	Tue, 11 Mar 2025 16:53:15 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7873A402E5
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:53:13 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22438c356c8so73523045ad.1
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708392;
 x=1742313192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI/cIKnupq+j7CY3I1UKQctg/e9NqYTweFh9NBbbpFo=;
 b=EGkJR5mQn+2VUFhGPL4YW+7g5S6Ze//g5Vm+GscACdxsjyog+B8Qk0s0MilfPrrAfD
 48v87+t2HOg4lUu8AmnLWpSuD1mte7LX4dWklDiUGACRWuIcsnsQKR+i4d9HO5YbvpjM
 lc+kcf4EQsLGpe8BRE/T0sCxoS/edPHfJXezwSgb550LW+4a4CUOk381EUTOJqc9FL0q
 BXry0KgChrbaeA9THcCmirrX5OYNXdDu4uu6uk8XTmInvtK/1j34LDlYXiGh8ChCct5P
 4hKiUX9l7Fv67I2adTR9zR+YGgjDQ/KbbefD9gV4F+Yo1tltJ7i2CEGk8agsQhWTa/vD
 lrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708392; x=1742313192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI/cIKnupq+j7CY3I1UKQctg/e9NqYTweFh9NBbbpFo=;
 b=jC/xGiTcQctuV3Zv7feUl+RRuHCjGfEM/XFFHnLHLqPwvxvqBfYOMkl5ttv0QRchc4
 ddIaJv/uds+/ezqhlgTBvmLv7h0mToxIW5MnpGnzp5CGfqigW2Jul0Wt/SPjZ+0Viaau
 P19CJJjxr39qDyvSYtfF7SR31h29iY2teZbSrsL4mHyBNYx03zvjl+j9Ghp36c9LFVO3
 p/l/TdkWWW7XnUsbw5gxsfA3DPTJU6OyEuHJ+LirTaskFmerTJpZbSAiUK4Qt9RW2pUE
 bX9HQOirKoXt83PB0wOg0GwLImvCs+XkL0wuiQFbyMziRw08z/gqzjmuk4lmtnVsXUkP
 JiLw==
X-Gm-Message-State: AOJu0YyW43QHpxX9E5BO7i+gYApzd41O/m/d+TWJJpuAZrVjrJLqENIw
 HxtfbyHycf9JjvOT3FwGlYu04mb04PpQ4xdAiaGRxFf2lwDpiUkI8mw2Qv24xUMZ3RTIyW7jhk2
 4
X-Gm-Gg: ASbGncul4dlWSnaadFYiMoQJJdu4MWsUZtVJGp01y0AxD+z9IEeMJPofGsnmmLtrSaw
 /HJ9AJ0pRN6tC2bYq9Png8HCnoM7RDZPAvC4DyD8pkiDjFg2SnzVGWPpQu+60ScnQMUG4noXPOj
 SNujyHugZPbMqcbLVkZ2dVGOADsIwa4fdrwcy86i97073wypd9+4AybHbwrEOBEqklTF3bSg1rI
 hOvU+TWLN7L880YCYl5+5yIWrrI8andSBn1y9nH7NuED+XEWD5hINXODcmzxZd/bomaPXTel78p
 k/4YXBMWRh7eEp0Z9cPCoWDiKiCv+KPd9qURLO9AYzYEpOeIxWT82CXTmQEsL+2+W84mj+kJWmW
 YRGhZ0IUwX9VFej+JSBBLxHTN+iWOU185
X-Google-Smtp-Source: AGHT+IEpqhtiyfM9/C7x3jqgtfQ+QhjhyQ6e4nR5nN+VBSqvFKSe7P7SuHlRil+3BTCkoGVWerkbNw==
X-Received: by 2002:a05:6a20:2d24:b0:1f5:9024:3246 with SMTP id
 adf61e73a8af0-1f590246b6amr3843866637.17.1741708392674; 
 Tue, 11 Mar 2025 08:53:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af283576bc2sm9500013a12.38.2025.03.11.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:53:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH 2/4] crypto/ionic: remove unnecessary deref of function pointer
Date: Tue, 11 Mar 2025 08:51:30 -0700
Message-ID: <20250311155300.13410-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311155300.13410-1-stephen@networkplumber.org>
References: <20250311155300.13410-1-stephen@networkplumber.org>
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

The expression *dev->intf->setup_bars and dev->intf->setup_bars
are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/ionic/ionic_crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ionic/ionic_crypto.h b/drivers/crypto/ionic/ionic_crypto.h
index db87ea0490..5a03260486 100644
--- a/drivers/crypto/ionic/ionic_crypto.h
+++ b/drivers/crypto/ionic/ionic_crypto.h
@@ -269,7 +269,7 @@ iocpt_setup_bars(struct iocpt_dev *dev)
 	if (dev->intf->setup_bars == NULL)
 		return -EINVAL;
 
-	return (*dev->intf->setup_bars)(dev);
+	return dev->intf->setup_bars(dev);
 }
 
 /** iocpt_admin_ctx - Admin command context.
-- 
2.47.2

