Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0DDCA5FE0
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:00:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BAA542F29;
	Sat, 17 Jan 2026 23:00:40 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 3EDE142F19
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:39 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so2497305f8f.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687239;
 x=1769292039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u57LCF6gNL4H81w9AAJqyOS7XfOlwxvNtXdCoUMOqn0=;
 b=Hzl3liLt5A4+9bu3KeXlVuTJ6OAxfffI8i03zY3WysCPTzOXIabLPgPd2//tMXSKVi
 cGb9EtLE0HdAZRr7edYWVXLG2mWL0LzN3SSpy++WqatqcdRJSRz7S1n00rXzawHdMMfs
 EJ+2fMCJPWCDFVbjFI5daUzYs+bYPzxgPMHHvXJVLgH9KBnqI8KF6lhKrLfsr+z2g1mS
 2od0nzNsEa/eAAHEC4Jb898nfcd6en7KAE/0Adr0QZixu8XAYn0kuW0jlnl7VSrFbvqP
 TAmaht+jit9lr+ohk8dlZLt37qIEVFeahK57l1blG81zFB7lXSJT82s8X7LYBo74Y2SG
 IXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687239; x=1769292039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u57LCF6gNL4H81w9AAJqyOS7XfOlwxvNtXdCoUMOqn0=;
 b=mltFJCHQE+ubrGLn9lOkRzR2OsnFuPC64AvBkv7Dz5t7RbwnBo7pXD7JTj6www9xA2
 ANvswYaJn/wqAQPlvsQBQzBZ+OeQpHiIbTWIrL/ciTRyeFuAkRT0cYkj/cI0hrAyxZgR
 bMQmMRF3/DIupCClShqU2jDMov2bRiZH5eEB3cNFePIlO0GZLSH4AXHuzdG0laJLbba8
 0OwqUPsgjcP6NLzx7XQOTSJHhfeaD4gVQ9Oj/0NnOQs9XXgQF7AwVuJdNHmamUhAVw8u
 jQUWiKkYy6ruvKhxy/2QFNRXpbGN6M+oIEgf4Qr0ZEYVFwlWhXFjwULGRkS8F40VASms
 UhwQ==
X-Gm-Message-State: AOJu0YzTKF+8w9vacmZcAYJFWeKDRrLv43RQtx7t4oaRLzqqIKVtsnyL
 qnZ8Etn9aSteaE8G8NwkAP37xikqKLdDHZeViVWiEk+NweNeCz4yLYmxAMIG3J4NVLkG40Jk/w1
 CpR8v
X-Gm-Gg: AY/fxX4djWE8WS2wBVHKRStADx1nGS+M9ITDbus2M+w04k4klNNZGForyvqYC4UTLMN
 hihWSgI6dMlUiQ4Ue8AWdmf/rNsshmPWH78+1gBfVmpMGzdFRNV3shjs8DmwhTWQLlhiujFFnzh
 1z3PK4+LB16EJDIBriLwDRQ85Bak5Cb+vatFoaMTUcyEJGIXGBgmzUyFBJz3RoCTkyepyk1PaOQ
 uEqlw54hKNSyzKFaV54ffqTFLy00yevEE0oIcVbgTVsTSsVlVhA8AzdkA8KWZFf3P1LaXPQIVcA
 mgeAeyQnX/NY5KaOQwp8qucAwTfMPnyczcNnMhMAUbWzssceO53sOctV9AP7Gmh51u7dbFSpxv6
 yy1bGqaZkHqHOTmowx9tYz20r+uLkUY7lKHEBil5+ZxbviDIC5Cuf/2C2aWavYO7/kMdDOVaFhz
 8XxIqMbrTXSvG8fRrOeE2MoAhQ8wVIl4z4D3pg4TxTAqlTLPBAyg==
X-Received: by 2002:a5d:5f49:0:b0:432:5bac:391c with SMTP id
 ffacd0b85a97d-4356a08307cmr9920029f8f.52.1768687238291; 
 Sat, 17 Jan 2026 14:00:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 01/11] doc: update features for PCAP PMD
Date: Sat, 17 Jan 2026 13:57:00 -0800
Message-ID: <20260117220030.273471-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..060b2f4df5 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Rx Timestamp         = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

