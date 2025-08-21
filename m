Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B617CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 20:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF3F9402BD;
	Thu, 21 Aug 2025 22:36:52 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 1A35D402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 22:36:51 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b001f55so7547995e9.0
 for <dev@dpdk.org>; Thu, 21 Aug 2025 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755808611;
 x=1756413411; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0H3Si04HclGU2q3Zj5WBEvrIvmensjOnnStRa/iU1l8=;
 b=scHLZuonacJWqGh6xHPSRJojiNFqy7Asl+9e0KOFhZ9CHjZs+49pyldJgfz3geAHpG
 wE1y3D0EhsYatyH2lL08uMvtJ6inoNIH+cO9+GX2mu3lKJGUuLc9QUcYc/rRTS1I5JwP
 AIiflWCczIrPtXQophOQexHW40OqrPRv4A+ZHeZjCZ8n3AX4WkoQfolRMS4hfWlbGVWB
 Ii9t/RXjoswtoD1PrreD+M1LXXqR+gP3Z4QSl0U157H8cTxfLHuLEptFbq7LRgUWIeYl
 c4lauswKX5nUrCtGWoYV1igsVZQhi3DmA0BCeRT6P2xk5Z82NIhrx8pwsnTwz5PXHpzb
 wJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755808611; x=1756413411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0H3Si04HclGU2q3Zj5WBEvrIvmensjOnnStRa/iU1l8=;
 b=D5iGDe9gYvC8xYPkhyJgdbbCtbMybGHBSB16Xuzx176tZxPHjAPg6E/Q1QN0EqaQXd
 UrqZJOR//BbjC4+4QqeOF+igfF65RPwrI+KmNlnUHkqehK33dxEZfv9fLAOu1Kdry4gB
 4YIfctFELyrngIRHjU1bWzm721/Ur65OxeL5AQCQTJ62ERc5voFIUEESXMaasMHqpGKL
 aZ/+mNKUkYDged4C+xYFRsYrfQsbOErKzzC3c6ylhYaB6rJ9Wy39t1lnoNr8Mm03f2qf
 M47+4INkp+ZHNBsdtwsXAwu9l9iXNo2FFSDKG9Z56eVkX1yxDc5yWt/ug8Pk6p7d0xvw
 MwgQ==
X-Gm-Message-State: AOJu0YyLzVvvd3fUt+2cS4W+CSzBzIPx6eDQ2eXODFXGiJHeucQ8+20w
 abhX8R2CQKj/8RB8+EUzv+lCn2VxYNqoBxShBIOyDiSoysIuy2ujPoaOTxPDzzSHOpCSbKv/GHP
 Oi/2c
X-Gm-Gg: ASbGncu8J9bbtHYNowEqIvGSDvz9n2oPFCFz8+LOzJat8npaYuA3+mmCQE+yPfuuP0s
 Z8TKaAD3dVN5/QDP+wndSRCz4TL11GU5b9YQLoTDrqhILPcCaDlh0RjcGDDzITVnqHoe05KBKTU
 tNsy7g475KfVoDcKcRVdHG9JK2VNVMwnTC/3ahaf1XCePFpaWz8qBDm7GDpHnTFVRfrru9/gDrn
 7QgOXRekF1ltPmfekPrnf99Omz77K18wlJLEStO5i+PGaDHm7lEbZB5N26sA/lfWMkUYe9rmV/L
 lb2xD2a+e1DbH6KXy5yURsCVkJSVC+whHPtRniO9yDBfCMhYQQ+NHWDTO+LtOoK18FuEIvjxXyd
 HAOCn+ZYIAzc1T4Vk6A8VeZ55cD+VzsePEODQQMshyBQEnD0NeIN81Fu6v1ykG5yrE4mizQiJ
X-Google-Smtp-Source: AGHT+IE6B7vropwVPJdHXpNkvxvwSvglnfk3bXwqF1vqh1bkEY+FB7DOkKtCfXNuzkc0x8dwiR/hHg==
X-Received: by 2002:a05:600c:3b26:b0:456:19b2:6aa8 with SMTP id
 5b1f17b1804b1-45b517caa99mr3287825e9.19.1755808611352; 
 Thu, 21 Aug 2025 13:36:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8de85bsm17962675e9.7.2025.08.21.13.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 13:36:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] hash: optimize compare logic
Date: Thu, 21 Aug 2025 13:35:07 -0700
Message-ID: <20250821203646.133506-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Recent discussion around handling small keys motivated furthur
examination of the compare logic.

Stephen Hemminger (3):
  hash: move table of hash compare functions out of header
  hash: reduce architecture special cases
  hash: add support for common small key sizes

 lib/hash/rte_cmp_arm64.h   |  52 ----------
 lib/hash/rte_cmp_x86.h     |  56 +----------
 lib/hash/rte_cuckoo_hash.c | 194 +++++++++++++++++++++++++++++++++++--
 lib/hash/rte_cuckoo_hash.h |  79 +--------------
 4 files changed, 187 insertions(+), 194 deletions(-)

-- 
2.47.2

