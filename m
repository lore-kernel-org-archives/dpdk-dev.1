Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D192C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 18:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD40C402CC;
	Thu, 31 Jul 2025 20:31:22 +0200 (CEST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id 0C395402A0
 for <dev@dpdk.org>; Thu, 31 Jul 2025 20:31:21 +0200 (CEST)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-55b82db8fd4so75929e87.2
 for <dev@dpdk.org>; Thu, 31 Jul 2025 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753986680; x=1754591480; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qNxrjQPUpGlGPvOuKs/hOw8ARdKeY7rZuHj+scxEW0w=;
 b=f+t/zuG1GbwD320w+lvT31z9+DMpPBkDLp7qWfpDpQGzpgrqRShkzXX90GQykdxaRQ
 8VI5Ezzb6RmU7BTM0t6sSPwQXsPYYXckhP038q0MSqabg9n1n4ttPys+gElaR8TX/vVX
 6TqAouGuMWbn8seDgjOOiD2bMDL7kzMOQtdGsgZmFelsW3cCuoU6I3BLwP/WqO+7Tj8o
 6+dKZOrGljNg2oV3THML2RyRJhkU7bODiMbaYhozbOoFjoRC5jSV4Yu54IoY5XpjHeHf
 /MVvahrhPruzaUsNpheN2ZQqORTYXT0NI6Mp+n/0m+Rd2xzNKBnH7k2nh8vKxGlUOAOi
 +f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753986680; x=1754591480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNxrjQPUpGlGPvOuKs/hOw8ARdKeY7rZuHj+scxEW0w=;
 b=FFQhOyR1i2+o2/jqo9hkrjsBExbCb5p1VuKnxhaCG8Q3ksXsXLte81CQPTXOa3q5O2
 ZT4Jy3ppYQwPz1QLZnEvePJXssxnOsAYuMcVlck9xL2ZroRPMY4SnmQqztgoJJFWqw6P
 tjUNWvHmoHqW9MMjzasWJkDeDKMD994Kh2rExAoGmFXGh3cLYux2UHQJFImN8XDxvQH7
 xo/x71A0z6+GM0KSsYrKfh6jCGlCg2GreWPj395QJ6xMslyBVwbGFSIRXGQs1VuAwkiV
 x+8r2W/6H7loFpr7A1K1e49B9qd2db2wIhd0bjc4BjGhlojQziQ7XWvN/amcTupj6DSe
 SisQ==
X-Gm-Message-State: AOJu0YznuaX6UbrUZsHe/zeVKvtinKSE5nvQe2LDgtI73vWFSNlDiHdP
 w8C8gwZeG2OXQn9cUeVMs2opCsgLAC8i7i53la26lVZCOPxDHGy3grp5
X-Gm-Gg: ASbGncsj1gPxUXdbhbuz/iMrn8eeugpNri2e9N6Ruh2Rsmq7PA8ExlX0Y4LT54Yu3Wn
 IQeGR7beQzu3h5+sC1QIzjwmpBGboeanCgkF16dsOKQO0JEB7XHFOiixaS8xf/fSDLEY1ORUwaU
 drW6yDEjORhRfJ2KOD5Uhi5yOSIceEcbpk9fgiVx6/mOJmSkuTcp9sEnHY+IF+sPzkICYWu1PaN
 xuM4yEa9VIaJZ8lZXVISFQjUDPZLX7nCBe2cIlyKSYZV2Sjfwxa9fgd/yjgT+WYvE+sRQ6PiqDk
 rwVMzmiloJG+a6bo5OAD1N1duOh62MYRVeUJVpTeuNWnSfiPD3+FTx6Cc2B3NWDUhSVJY9yc0Mh
 myvxIUZ+v7hxntetOcbecL0NkAdcduAsha2X4Ho6Yh4C1vw==
X-Google-Smtp-Source: AGHT+IGuQFIQaic1mSLDBzRjR22GJUdmaoiZ2PpCYtBOqFNXqTw4bHXtSxoXY44wM+Va7aPwsDP39w==
X-Received: by 2002:a05:6512:401f:b0:553:37a7:b217 with SMTP id
 2adb3069b0e04-55b7c05ab12mr3257508e87.35.1753986679925; 
 Thu, 31 Jul 2025 11:31:19 -0700 (PDT)
Received: from thinkpad.jira.postgrespro.ru ([93.174.132.69])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b88caf6dcsm325166e87.159.2025.07.31.11.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:31:19 -0700 (PDT)
From: Tofig Aliev <t.aliev.mnt@gmail.com>
To: jingjing.wu@intel.com
Cc: dev@dpdk.org,
	Tofig Aliev <t.aliev.mnt@gmail.com>
Subject: [PATCH v2] raw/ntb: immediate return if no doorbells
Date: Fri,  1 Aug 2025 01:31:17 +0700
Message-ID: <20250731183117.87499-1-t.aliev.mnt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Added immediate return from ntb_dev_intr_handler()
if no doorbells.

Signed-off-by: Tofig Aliev <t.aliev.mnt@gmail.com>

---
Changes in v2:
Fixed incorrect patch file.
---
 drivers/raw/ntb/ntb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0ed4c14592..e298820e5f 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -158,8 +158,10 @@ ntb_dev_intr_handler(void *param)
 	}
 
 	db_bits = (*hw->ntb_ops->db_read)(dev);
-	if (!db_bits)
+	if (!db_bits) {
 		NTB_LOG(ERR, "No doorbells");
+		return;
+	}
 
 	/* Doorbell 0 is for peer device ready. */
 	if (db_bits & 1) {
-- 
2.43.0

