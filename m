Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC35C36011
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 08:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C9DF4060C;
	Mon, 31 Mar 2025 10:42:47 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 1BABD402CD
 for <dev@dpdk.org>; Sat, 29 Mar 2025 20:53:45 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so21488415e9.3
 for <dev@dpdk.org>; Sat, 29 Mar 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743278024; x=1743882824; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lZdioLeaD9q2Pt9v4lfH4j5cE00Yl0Aa8XDuhmLZQhY=;
 b=J5Z2n0oPJ8HPxrEyfiScpkoDY4tDFzcRQ3IbSI9ur66tQnIjotDex+vEsc2iVLwcmf
 ohIjrHUgGwdB+2CEfMFJk8DFJq8LNee2UdTR65nRSdl4H98JmOFyVSKYljItNUDpNHor
 6CD+Nb7p+gz++tpcvPJR1INVBH2KBTcOs9oULIdPP1BRdAzC2zYE5CJ/8j1FhPoduFtw
 VbaOahLE1PtnsLX9WicahVZD2xLJRHKQbxIGjUznbS5RIUOsrx97OLmn+H89egUKlm0m
 81iAX7PSO9v4ShNiW9Ij5XzaJfXZVVgpRm5B/3p2G523Y8vPWbSQpMgKk/N9Aifl90Sm
 xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743278024; x=1743882824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZdioLeaD9q2Pt9v4lfH4j5cE00Yl0Aa8XDuhmLZQhY=;
 b=Q89g+bAOiC/4hnwe5VT2FCxGnaeX5K9DoGomtG0FfagX7BnonF19y4PB2Urm/0YLJf
 e27oMFL7sBSMhn38Kqg+pSg/G71G0ER6V9kvWrSjoes4wHPV4drE/UQm7PHhmP9BH1Du
 FOCpv2vssbxUspO5RTK3xlQcmn2iak6DGQzEle/athuQVzKtWMFW5/9XE7XPxH1z/6Wl
 LNrqHxNyyNuT0UR2xGpJt1E+Jsz+ZkfhNn/OOik2X/n536BqldqRpiCSQOTb8On7HPIx
 2mATrjX/19U+pmYvZzk6fmsqaqCiEBSpmtCx0kOAmPagbOOCYju/+nt/BncRqncw33VM
 sjWQ==
X-Gm-Message-State: AOJu0YwtzFOnwj24qd6Lfbf6x1HYMiC200c9q4QRmyZ/GMK42LBoq7Vb
 X0V6E2e+WcAyLNOq2bGBEGMFNtuZQczgChOya8vabwlZ2nXmKZooABKUy68r
X-Gm-Gg: ASbGncuCc/4bSzmYMZj0EIKd2HNswhNhbr02H4P4CmRmeUgYaQ7TIhzbHnPnwdsA/zn
 3XShikxg7rtURqlRdjGzPP19jvrN9deQ5Rx196Iua9lYQnWBxpG6OpXIx6H5l0AkxwMJraCX/zt
 iFVE4Z6nwdSuqD+Kqq3+Qs9CX2Gqhfd25de9slZoUE1a7lRvtmfjLNAResK7Loco7cgllM4Fgh+
 VFBhz3W4txZ5iiMZVmoIch/3EjzpLm3DYnRvW8tyfb8ZWq7KPoLReayTXZHax5hPqt6OlKBh1gP
 NMIP4Iuhws1BsgypVemCOKinnLAukiEeEslPzJ3YsNMB01KK/jfyqcFpmXQxlf+VSRsfIgZNjQ=
 =
X-Google-Smtp-Source: AGHT+IHdy0VkGonCLTM5/12inOhxygp+acv7oNfOQ9rdSprjn2jPzMgtwbe3BdBilErZ8HRG3PBADw==
X-Received: by 2002:a05:600c:198c:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-43db6289b35mr27260045e9.21.1743278024491; 
 Sat, 29 Mar 2025 12:53:44 -0700 (PDT)
Received: from ubuntu.localdomain ([202.165.248.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm6684145f8f.0.2025.03.29.12.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 12:53:44 -0700 (PDT)
From: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
To: orika@nvidia.com
Cc: dev@dpdk.org,
	Tanzeel Ahmed <tanzeelahmed713@gmail.com>
Subject: [PATCH] examples/flow_filtering: fix make clean
Date: Sat, 29 Mar 2025 12:53:33 -0700
Message-Id: <20250329195333.324178-1-tanzeelahmed713@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 10:42:44 +0200
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

make clean is unable to delete build directory
because *.o files are not removed.

The other way to fix this would be to add all the
c files into SRCS-y.

Signed-off-by: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
---
 examples/flow_filtering/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/flow_filtering/Makefile b/examples/flow_filtering/Makefile
index 9998ed10b5..653e3319a2 100644
--- a/examples/flow_filtering/Makefile
+++ b/examples/flow_filtering/Makefile
@@ -50,5 +50,5 @@ build:
 
 .PHONY: clean
 clean:
-	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
+	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared build/*.o
 	test -d build && rmdir -p build || true
-- 
2.25.1

