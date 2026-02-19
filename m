Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FBC55184
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:09:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FDEE402C6;
	Fri, 20 Feb 2026 11:09:33 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 8741A402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:25:15 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48371119eacso6740235e9.2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493115; cv=none;
 d=google.com; s=arc-20240605;
 b=UhzpThq0m24hy7OYSMj9Ua4/ltmK5bAAXZRB6bn2ciqANynDdMrYJ+BDSSgTAOtZZk
 bE2UHRFYVjOyi1U0sTS3B+vAs3vRvTLLvtQX5BQ5v5L1SxS+TxnJ1HyB8waicrGjUQWg
 hDG1IiPCKmQbkaA2C6oyKikF7bCowb/oeAQglOMKvh0A6FLToCybdvCazEAP2780DgBr
 uybZ23loWUtfV2p0UYIUWtk1Q3DuyidlBgKeK98wWaHQZFMIzA4ajXHIuu/Lr0ziMS+X
 GazsZRdWyhrpFqOBz4h0pLvPzwWQR6c0eNWK4EZFXImuRM15uB9unK/3YRs50JTYhbQx
 +cTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=vOzi6NNr7pIQ3Cdy50Oj7C7skQs2VH0mrhQJkNehc1U=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=gvqfKXKScXCw+mC5DOGC0ht4DtGuVlLc06AjkneiCaAqKmeVlKJi143SXd+F06bmYs
 CDVffnx9z5dDG9UvGvsK3JqFTIqdGg4Wyj1wEx4WmKcrNkAFwrfXUzy8J4RZRPwtSf+i
 kr8N4MqtvfdCkYq47XlV/jzP5skvZzZBaClOMdhs3GbxBfZCDNLDpg8vug7bZdNXbLEa
 vX6XcjB2QD7TDqDQ67ZXdFmY9qjN+zgDoEF8bLF+IL18GkPDwh09v8UjIG7ieChG6HeC
 ctpnat6LLkixOnFr/6YO12xMW0Fwk1uV2T3+/UpfpHELfWtU+Ul8bBqqicjgH3x8Z5QI
 9ung==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771493115; x=1772097915; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vOzi6NNr7pIQ3Cdy50Oj7C7skQs2VH0mrhQJkNehc1U=;
 b=k72VDp/MnBjDnmNoz6HuDhfW+OLffxoykGUZsPLAo1kO7tUKvmB7IOfCLQgjIL6aXd
 11oxctDWPAhvGcU00ri+dLtX/QlIcd6xI0MDLRSaptjOZx4P5b0qjqat5DUJuQ+mAP2R
 KutuAc7LpM+uNiGXxxzF2ZCt90X3QQqEZefyv9mD4i7MaDTe232lhN2WP65KYaCS6nad
 KFkZ7ppnyvKGNmfbWFQii31eNnPvGxC8gDTmJyOFcgsyKk9g27KFhkrOel+xm14tbVAJ
 QIdzKwBj3mQgC0ZnP1D15uVMxQhj+pOsqwqHdBsRE9aYiEOjSKEN52hnoRx+F3zqpSke
 zWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771493115; x=1772097915;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vOzi6NNr7pIQ3Cdy50Oj7C7skQs2VH0mrhQJkNehc1U=;
 b=VEnJo7WAYig4Ekzwww/luT7pHcijNQ4JqDK4El+TSuoBT1RwBa+nkdoVwKS5m+8+Fc
 kOIPFu/nSJOHpsr6/usOJgrJquEd4Oo0RK+iy1+0l+dzrfrq8+8+FyOHgCAHsEVEBYit
 Rt4GaQL2rzRWqer57UBgZhtAvPqCT/8Q9FCF/KNGEk5yqlirCusxnCHaSaBvOyJ/Zy8n
 YVBcpNsg3NKh04sdn8MWn9GAwWZoyg+c9HGcFYDMqpt2NXAzv1AKhgIovUSIutwZH4Uf
 6ppkGsWY+15dms8Ofo5pY//X83YoL/EQt88fZp97Xy1DyacSN2RlJQrk3mXyAV+sPNpg
 ZTfw==
X-Gm-Message-State: AOJu0YwzHKVNIdoc0L7IZLrR+mGwhHfYRFJpkDKFD42Yhqeb+S3C3C40
 IwEFni1pw27nVLCxk4DJNtdkRuaxqyF9lYuxTF03njJlcTtNraerMhJ2oWMsInEXNy+mr3UysIU
 7pfFM+ZjOCpHysLA15+KgOGLIkipzxVBPFPtJ
X-Gm-Gg: AZuq6aJFUzG+qA8BjEzR61e8Iy9I//q8kpgDS8gozrtVgcVMLh6gxlw0ObBDVSgKDfC
 UCNx+xPVl0CdrIeGpIZoCePbQfG9uIILj1Uokd1OA9g/+R7ILPRGoxYghLW0rw+DgsQjJ5A5rd9
 cXMnQnZrzfMwGTrB6W5fKqXeOBwjUIhutwUlW4sESoF42a0BtkJgOlP/zT7662TQ4Af6DZ87Sm8
 A9DYAJChP050lM4EZJ9WJDOq2Vx6Ohb9yydyMuPXJE9Bo+EJmKGEsvmnGw+GVFGDyNfaSNYnK2G
 sPz62gQ=
X-Received: by 2002:a05:6000:2dc5:b0:435:a2f8:151c with SMTP id
 ffacd0b85a97d-43958e13c96mr7700875f8f.28.1771493114649; Thu, 19 Feb 2026
 01:25:14 -0800 (PST)
MIME-Version: 1.0
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Thu, 19 Feb 2026 14:55:02 +0530
X-Gm-Features: AaiRm51mBDVtkbIdcuDO-bkV21DDPjw8ULgMSZ5zKX17uhNh2QN7CjQ1oEg7X0A
Message-ID: <CAN33txEUWT_1wJMa2Rz_XNYQZyqGWrQgzkicWJvJEcFVi2+20A@mail.gmail.com>
Subject: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example
To: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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

From 9d87abade4e79b4377367bbcbf79a1095beed127 Mon Sep 17 00:00:00 2001
From: Harsh Raj Singh <harshraj215@gmail.com>
Date: Thu, 19 Feb 2026 14:16:16 +0530
Subject: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example

This example demonstrates usage of the DPDK ACL library
to classify packets based on:

  - protocol
  - source IPv4
  - destination IPv4
  - source port
  - destination port

Packets matching ACL rules are forwarded,
others are dropped.

The example provides a minimal reference
for developers wanting to integrate ACL
classification into packet forwarding paths.

Signed-off-by: Harsh Raj Singh <harshraj215@gmail.com>
---
 examples/l2fwd_acl/README.md   |  18 +++
 examples/l2fwd_acl/main.c      | 249 +++++++++++++++++++++++++++++++++
 examples/l2fwd_acl/meson.build |   4 +
 examples/meson.build           |   1 +
 4 files changed, 272 insertions(+)
 create mode 100644 examples/l2fwd_acl/README.md
 create mode 100644 examples/l2fwd_acl/main.c
 create mode 100644 examples/l2fwd_acl/meson.build

diff --git a/examples/l2fwd_acl/README.md b/examples/l2fwd_acl/README.md
new file mode 100644
index 0000000000..5b5494e297
--- /dev/null
+++ b/examples/l2fwd_acl/README.md
@@ -0,0 +1,18 @@
+L2 Forwarding with ACL Example
+==============================
