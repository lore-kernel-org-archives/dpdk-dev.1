Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B44C982C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A66142EE5;
	Fri, 16 Jan 2026 22:31:14 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 2323542EE3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:31:13 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so1656695f8f.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768599073;
 x=1769203873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dicFEJGZ2U6HZJAnE7g5jXEm4hvit74vCIt5gVCCnj8=;
 b=Fqgl7Y6mVpgre1wWMqZsQOUCycjrLD3xpIV+Yhq6IIiv0aayTdw/wUB5AqM76v0/3m
 bl4fjTL0Q5aqXa1NgobRszzzker1IrsQ8yNgxf4Yy4EHzDWLrbbUsQS3zh7sEmlzBadX
 gsVxV8TPlr0BKxTq8nxrZ2TgBaG2fyc2iL9X7Fzcyp/0fuZCz21He0W22qrpoX+jvCUq
 ICw+52buFM3Fn1k3gyZaqyoOBbqK9jDWQPWUIZP/oS7BrtPhkaLTuvk2bovIB43y9jgU
 ZZi46MJPULRqSPXzxCBNAwY62cJm938Ne5oZeye6gKyi+akMgDTK5iaWSsGGQeJs7bEt
 EJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599073; x=1769203873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dicFEJGZ2U6HZJAnE7g5jXEm4hvit74vCIt5gVCCnj8=;
 b=GfsDJmnr5SDH9Au6++otCYvI6Vw3plATZpdL2AQDrs4utisYLXDA7EmPnBXMPbZ9KX
 TCyqxmX7VNyx0pp5PqL6V84bWFuMxXrh+I0iv+9ngk5+aDsKVHvy9j7O6HF5O52hz37U
 /LJwIIKZB9l5pFEuH3obVi0T/a4+dBc7jyq27/trveZB42RKh4fCOjgBXulgWmK1Mf+V
 XW15wLn5QV2y7VMBkrwhPNC8XI1DpXcjekDYbphL5jtSoWU0x6aRq6sK1yetmqtR3J/n
 P3eyTPZEgpzpygCXSHkfxn4H7ucizq8XaFmaSsmucIsUrLsjJb656CkTN8LdAlfcnEfW
 jczw==
X-Gm-Message-State: AOJu0YyVCSxr8TqzyRz8Awyjd4tRbDVzguFL6ligYt9jR8ID+pXRdE/2
 izC4n8ABd+GX8rtjwNxtB7qz7PAORLViSRoDaG98+6DBL6+eAxXSHeOpgW2HE1vcjPlLL3ePD/X
 brG1Q
X-Gm-Gg: AY/fxX4WkMWZNQtBcraYhRNThgxzlFUV0szpF6KySq1AuOOW3KGEZgdSqxTK5h5683X
 /URL9ZOBl6qLB1sBtqHTOKuQc5HQpeRRpvi8VnuPBLR9h/8yaQrSmfhxGdxwV7wq6paKwzf280X
 v3gvUjlRcgazsFp/NlMbYQqcMiYt2RcamwYmi0SalMuTp94aSeGwhr8BHE/nDXAba/XQUU5N3LM
 7KT2ykkTCYftHNtVWwHlx7tc1uq2nm/LBk/k3Ld6JhoECpadnE3MyKuMVBZqtmjrBgimcHhGGAe
 rPiFECWf7W3FeR4BTuztUjucTUkQqbJ3iZBdOMw/apF2mez6/ghNYcUAp4X9xSMqD87yTLCloZR
 uXRHEfNANbuy2CoJ9EXxDcXtqLbWLvggVIT9Ld5im46phgHeMttJvAClzjOWvkHctbfxmLlgN90
 yZVy4oToB6lcvDPPqMpK7kvjkejhCD8f5MJb88hLRKytXKwGUpMJkw9KwQdrjo
X-Received: by 2002:a05:6000:400e:b0:432:c17c:3094 with SMTP id
 ffacd0b85a97d-434cc99cd37mr9744202f8f.3.1768599072688; 
 Fri, 16 Jan 2026 13:31:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm7398759f8f.28.2026.01.16.13.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:31:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 4/5] doc: correct typos in switch representation guide
Date: Fri, 16 Jan 2026 13:29:35 -0800
Message-ID: <20260116213100.110419-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116213100.110419-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
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

Two typos corrected:
- "according on" to "according to"
- "physical of virtual" to "physical or virtual"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/switch_representation.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/switch_representation.rst b/doc/guides/prog_guide/ethdev/switch_representation.rst
index 2ef2772afb..0bc88bda8f 100644
--- a/doc/guides/prog_guide/ethdev/switch_representation.rst
+++ b/doc/guides/prog_guide/ethdev/switch_representation.rst
@@ -19,7 +19,7 @@ managed by the host system and fully transparent to users and applications.
 
 On the other hand, applications typically found on hypervisors that process
 layer 2 (L2) traffic (such as OVS) need to steer traffic themselves
-according on their own criteria.
+according to their own criteria.
 
 Without a standard software interface to manage traffic steering rules
 between VFs, SFs, PFs and the various physical ports of a given device,
@@ -84,7 +84,7 @@ thought as a software "patch panel" front-end for applications.
 - Among other things, they can be used to assign MAC addresses to the
   resource they represent.
 
-- Applications can tell port representors apart from other physical of virtual
+- Applications can tell port representors apart from other physical or virtual
   port by checking the dev_flags field within their device information
   structure for the RTE_ETH_DEV_REPRESENTOR bit-field.
 
-- 
2.51.0

