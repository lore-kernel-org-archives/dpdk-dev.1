Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C3C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ADCE40687;
	Thu, 20 Feb 2025 17:42:21 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 01A1E40668
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:14 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220d601886fso18197725ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069734;
 x=1740674534; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=fHSJKmSSgI7wS9sAmqK77ik7sdrQ8OqJIICp2RH+TAMJi3dzn+v8EZEhN7z6b5TqZH
 DB7oHH3/ebY1hoBaIcqsD6y67bhWku8n9hFMy+HyYeEuh9wg7TfryK0kKR/HVehSYWuH
 r1PPVPHHnH2k4schNIemPcjvZ/5nEpmYkxW3muRiRkPIa7R6kLkfb8MzUFCO7NotXo0w
 PR+SWwXcEPkewOEppnVngnkkz6wAZpm8yMYhOIY5mSt4po2d+jcbK24XoM0MTnrI3RyK
 8X5FVEMBu2zOojFQJGmdIjpBe8GdYVDPsHx6bsNjSRSk6pE4/Mlo2ZWQ1ZrzYVW4L2LQ
 xvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069734; x=1740674534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=NfPcCzzFgrbwRunUEQTOy1W7JbKk4KQGx28wvq/np22yN7lr0Mwohr0OtWCkpsqPL9
 vO0lsQygYu7w6hGfb9SUa8TSbcEP8HCsioK7JmOsLPiYyiJaA0AvSr4Sn9PunvTbTGlH
 XAoH7TUo6neeuDt3kjiylkVzkaHtaJ6hWYZEbt4tTkq/Nn01u9YD/Lqy2JD3YoWvrEe5
 k3FtQFJLai2VDuSovNPTaBp793FD6+DKF1IJ5a6kRvxsbDE1cskYTj0i3oJwiGpXcCUa
 qHycr8S4U0UGwJ87bzuQrcPEQLbe+jEyqAlKeRC5zSFffEbtQLelDFVXMX3dPsyx/Ryx
 wVPw==
X-Gm-Message-State: AOJu0Yw4g8XGaIEW0FpQzu8k37uFZGVzyquec0yQpos1DPIZEP5CUKUs
 rnobR94CXm1JU2JikwVU4AfxB8+98yasKQsb/0Il64+D+hnwE3hfMNzxTqntQYyorcCg1r1USRr
 S
X-Gm-Gg: ASbGncsRk94P2OOpwZfdlf8LbwP0YyY/CoJ5V6j30YONeoMX9QZIGcBgLsZZw4IWi/B
 reg/Y9xrZqbIoWHAoMZqFz91e6BSKWCwocV7+8KYNY1kUfMKOZdcAuOLXevMgE67EWOjSgZzoMW
 fsI0+BGyvs1EmoTIyybkXuLDckgUITeYM8ZDpW/ZPy5aMjMWzUWocVO+Ihy4+VDxFLx36zFsNU+
 fgaASglBPw1KcyxKYknMYGp/NUrx7bIM775jNOq71lcXWy7GCIm8WpnMyoa7/2is8wsvUb9yTLO
 sOrcExdluFlBiIoP2lPYBjbM6PNJ4AIUhRfiQUY+qg2273R0kvGFaYCgvfGCDUeY0Nqf
X-Google-Smtp-Source: AGHT+IFsCf2L7qcCl91BzC3SivpJ2VSseQbtcUjbsxwhE3CKBMIrhUbAm1wlc9BNAiAT+zwqnbvbew==
X-Received: by 2002:a17:902:da8e:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-221040bd2a8mr384783905ad.36.1740069734228; 
 Thu, 20 Feb 2025 08:42:14 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 13/15] net/ntnic: check result of malloc
Date: Thu, 20 Feb 2025 08:27:19 -0800
Message-ID: <20250220164151.9606-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

Need to check the result of malloc() before calling memset.
This is only place in this driver that forgot, other code
does check.

Fixes: 0d9bca480e26 ("net/ntnic: add FPGA modules for initialization")
cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/nthw_rac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..f275e64da3 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,9 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
 	return p;
 }
 
-- 
2.47.2

