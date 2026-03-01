Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A40FD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14CD540B9B;
	Sun,  1 Mar 2026 03:07:38 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 01E5E402AA
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:36 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb4097794dso329576385a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330855;
 x=1772935655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=QgJCPAF8aY/+UjILwKEB2r0E6sGcNdgNFDyJ9mCIOii5rYPbG7k4stOIRt79IqWj85
 TC31/5+Wj5rKPp05k57UifauNWfzUuKmIWOQR01X/rEvCxh7Me4rKehwrNIauPamV/yD
 IDEKsrKNlsOlDJAyW58LK3swDnbspuSHpaW775FHMV8lRD8ckVywd3XBeQVRAStEmQHR
 PJQEbVOmfsnu45GopRzWe+c2yCTt4CICs3xun9nD0DlOaghgyf3xOn7PO6V8ERrQEe4S
 m0qIYuAzneo2YY+ANdupoOOPs9ifykBkU+MOim7PKLLX9nY1eV4/58upu+proB06SejG
 SRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330855; x=1772935655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=Hm83naWu9dvXkA9w8YMDqRNqLm4Zr7t7et6NOcHnvzRHNxSygHoOikGYIiYtf8/YU+
 Iz/uGxdcnFQbqDFdqUn40liA+OvuDc8H8zbeU3609jVsXOk1la27TR1Jc3owGDjWTWe2
 QjXhxyBtN823EGophuE4GrXDgeIoqoFPtQxwLN3tRHRh0DGP+S+2syGr/4TnyGjaumvf
 3UewhZxWNEVqVjk4VLQwR3oaEXEsGBdjBeE7hVHCFLWGe0j29ClN9Lf7LE63LSYgjYjP
 62dGCJsckBul2Bk6cYU2oU+flZhd11GaRVGF9hcHkZny7vPyi65EjlEhvE0T8hsFEsCV
 9VxQ==
X-Gm-Message-State: AOJu0Ywt8d/G2kLbrPFvJmqRIX45k7coUEwYK1LS31/Y8nfymgnuRTOQ
 BqwHds3kjamIKrtmyQSLtPvr3EED5Z8t2NETiSGTfxaGZQyg2YvhWsOPuUR6zq2J8DZJcto6lyk
 Mn9Ke
X-Gm-Gg: ATEYQzxsSZnYnIGKcn3B2ATzyLxCOdTMfTaG1jPR5OtkKMD2eXjc8X9h9mJNa4OFk4s
 tK2c1GgPzODOdkmsWI0EzDiafeOtQLH2n+lGYmv96gf4VO/Mk2U8b9sY/URvPP06h6y89UcWuPt
 9h+kEhDD7scjsrN7HwIGfngJRfwbJ3f0Qmem6905xe0bsP3WH3hSsmmKv06KgDkERFAgoDT+lVj
 qvTfpI1spvgYgnKrsiGXqajNMc5dmMhiJOqJXO0XRyt3PjoG/1+lu0NPuPshdo0f+EvHKbub0TA
 YxTAX4tMevq3gnYMGbsAzd6f6qTSmtCZQH0Jfv4mWQCBJp/cIsULZPTjo4vSco75+fYyWW+U74D
 AjBq2kKfz9tJVc7ITd+Y1Z5R0JpMn1hy7yxhbWNZhtFZ+SKCew+lBWoyuuI4hkyI6HZs7FgZBKt
 geppzAEQ4PRRwPROb1jTmESb8E6rTKJdDjKNPClZYmPwqy7TEuDGrGJpOQleYx0A==
X-Received: by 2002:a05:620a:4482:b0:8b6:134e:22f8 with SMTP id
 af79cd13be357-8cbc8e02701mr1055549785a.60.1772330855135; 
 Sat, 28 Feb 2026 18:07:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v18 01/23] maintainers: update for pcap driver
Date: Sat, 28 Feb 2026 18:05:34 -0800
Message-ID: <20260301020726.852401-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..93ac176573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

