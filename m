Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31963CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 23:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C76F40B9C;
	Thu, 16 Oct 2025 01:11:11 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3C59A40273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:11:10 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so38276a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760569869;
 x=1761174669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMyC7kY44PIDuGbwHCfN06dSTXj3j7aZw9ZOuTLf9JA=;
 b=SHpIWwHjrsdTUcBohlm2iCCedpfa+977Su0/KSuiEVlnY9wi4txrGuVEK+0iE38CSR
 IXoThxN6IMxBx8fCXTLfkHpmCBvYMZ851D/RYFiBTugMuAuzYlQ8ulflAEoNnivElabS
 bxtWqbM2cwkShaxMxwkwCFLGmMkHt4k5NmMR3CfHQvX+MQ6xCGdrxcHZLM1W80FPurmH
 NsiMdfiTsPtot/1CuX8uFeh0PsHkIohABXKG0KLSDHMclc11/6uXySeuLdQjvsfW9Ru6
 rN26UFiVGcUtZXWUVAFWyH9VNvwmAIWgaPktBtKevjJ2tj9BBNC9b7LBiFsQGJOCjQTZ
 VBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569869; x=1761174669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMyC7kY44PIDuGbwHCfN06dSTXj3j7aZw9ZOuTLf9JA=;
 b=h3G2lcIBUlnYKBne0kdSrfSrDX5EmTmqwC1Eg8zh1VIy5uo4Vs1UM1L8uLgEe1rXeE
 rmBtweeAYeObheW4AbHkYlAN4SaneCL53JB4RY+/QRdRFjYF+uR0SENL1iDclGBKwigK
 bpcHPtwgqhq0DJIrin3SmfrpsnSjKjyall9Fk0mSGp7q9yrAUg1D5J+f1Uk/LAGznM4M
 7nNoKu0DSFwH2avFBqcHmggA+mkSFWFKIDWRRZH+fyQG8k+VRqRhstEptmi2Vtj7N8dp
 Gh3LNpfJfoFkz01N3npsYXO/l/IqsB+US/G7gQmRCVHLUr6No9qVy0e1gb+TJhpBPmPA
 MVFg==
X-Gm-Message-State: AOJu0YwPNGA0cjpcoguZ5P0JQnbkMzGrx7tP8xFPYBaUtNXGOkRA4z9X
 VbKfqgGLAhyWAprXU/4AuatmCZtQY1sZRqIsUySHXK0DO8k9g6jFyYgcDh9lZ0QyiLOMjRgl9GO
 1FW9W51k=
X-Gm-Gg: ASbGncuxAOiyirh6qyxltFFm1gJji6nCvhHYCItN8bbLX0ALm/kmWOUYt04zujE1TIO
 UhHC3CPwSbKusbFeFEZD7/YU5fIyLCrL+bd1LifdnOWGnXGZl3kT8bxEF/EhPVrI7Mxc57alvcu
 ipijgGRy39SWprNv0rNS4rZxcmvNrkMAnj4yTtwXRTV+DcHQ1aVGJCqYdpKAqiN9XviFr12UVmV
 /I0yQkDFREnbPRRWE/uoXDMv+DVqloNAGzvkmukIwj2WdaQtbh0rfIWwWy5T+9A8toIn1vJM2Do
 TAoaLEyYnPuIAMumSjzuG+YllfZ+lsXygzEFUxp13Y4oC1pPlGeSPtlFrL5X2n9C6GVHuyi6xET
 6g0HS6mF3oVeB0tNLmJSOE+KQummWE+A8JvwAB0dW9XF5SrAzH916WCjxklyafZL652purtDYON
 7013c3F8IAVVRHlMJmbEkYLyvTm5rsNQMNkBK/hIAOFlTF2/XXIRBv952BLWjq
X-Google-Smtp-Source: AGHT+IFukvyiHDEUUqH0l9cRKRuHoRi6kMdkN2l/ryv6JdBYgt3/0FV0x+bWKgsp1/ESNxFh0jt7uQ==
X-Received: by 2002:a17:903:90d:b0:286:74e3:3889 with SMTP id
 d9443c01a7336-290272f93damr383011615ad.55.1760569869364; 
 Wed, 15 Oct 2025 16:11:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7b0f4sm7620415ad.57.2025.10.15.16.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:11:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH] net/enic: make local variable static
Date: Wed, 15 Oct 2025 16:11:06 -0700
Message-ID: <20251015231106.876172-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

Avoid global variable name conflicts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/enic/enic_sriov.c b/drivers/net/enic/enic_sriov.c
index 43072a2287..29faa31512 100644
--- a/drivers/net/enic/enic_sriov.c
+++ b/drivers/net/enic/enic_sriov.c
@@ -13,7 +13,7 @@ static int enic_check_chan_capability(struct enic *enic);
 static int enic_register_vf(struct enic *enic);
 static void enic_unregister_vf(struct enic *enic);
 
-const char *msg_type_str[ENIC_MBOX_MAX] = {
+static const char *msg_type_str[ENIC_MBOX_MAX] = {
 	"VF_CAPABILITY_REQUEST",
 	"VF_CAPABILITY_REPLY",
 	"VF_REGISTER_REQUEST",
-- 
2.47.3

