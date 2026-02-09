Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3CE7E0DF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 20:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 045A6402F2;
	Mon,  9 Feb 2026 21:06:55 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 4B2D9402C3
 for <dev@dpdk.org>; Mon,  9 Feb 2026 21:06:53 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48068127f00so944635e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770667613;
 x=1771272413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQGmVr0EuW/dZNPjuuisLwsuU5pwJxWokRTkQK4b0Ik=;
 b=nVfpWeILNsNY2bFq0dPikQE90OK78h+BVfw7w1PvV8E/uAeUU2Hvs1Ek4fK7ZnJLsb
 S1cEYGIyKNQFi+0bhAoSCGE1flE5yD5LjpSpZeuuiM2u5GF4OQowZDVWuQvUqUSWoBg1
 FcEJ3AVdphKoaiPIOwaw0jtxfMTTf9L79jzsWG8vbssXISuCA55DEyOsKAkjVCaiZnpR
 yCDhv5CygJAYoVr6Ps/DtFD0dToWiG3I1JtIaIi1eqd4+WheWl7D2JRpWA7YiruKk9dy
 5TbXnHlfwLjGtFdUxaXai0CF2rKpCwLVJRk7KOC3bFnx0eY5T/xk4+QZN1vRlf3rkBA3
 nD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770667613; x=1771272413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQGmVr0EuW/dZNPjuuisLwsuU5pwJxWokRTkQK4b0Ik=;
 b=JnneY71HY3WjrxYHM/KYkc4N84Pi78zssCI7VjcKqqM5R3gYe5zX7nyTlPbBOrjVKE
 v3mVVWLverYJve7WZyVHDMOin0TwKqXnzHpvvfylZQ7jb+vPmj1I0MrtPCkUssXq+v69
 9f1rPXoWj5sdOJbuujs8SQib1aYY/i9DHtENPFh/gxgFNSBgLcVgSHbjwDUBl0oimBJ8
 xasgSOwkoFLtGq1k/ZswrmTt+fZilpQ92FM7nKAaRAHYxlSwZIJ0QzXzeSHu+HI+egm/
 ZYgcI9XcIBVJZs0vyaPml0c+SOZCKIqglEHV6rWAmMtwJLzUhEzf+VorYUGMC6RZcldB
 11bw==
X-Gm-Message-State: AOJu0Yyu4lZSgkxn+uXimvCOGs8Ss2xMZIT45iofu4vvTVEQOARIVOzc
 AzUNp4SMHjC8hUDCnKhXScP4lc3aBShS6CB7+zXVGElVXWjyDqnyHKKV5G+K+qqqw21RFaqxvWC
 pNiAm
X-Gm-Gg: AZuq6aJ3e7WL0mKSEQE241xS/PI8gdPi+qNlnd+6NSS7cwGkr2daRx8sJ7ENoDeczAT
 xVIFPji6eecG2eGaYJEEmhhAspyZbrgEYg7ULY8oUlXbHmdgc3AV+2ek3vDA+ziOwUopiEeyVHE
 M9/VczkouiAPG6WwWTu+qOOwFgySAqidkCI7FqeHxMtQOgMszoQ8ZkCOMxha8MrWL6vbxzOq7EP
 3GRkQI3WbAEcIL8fsIyfYqOnGy9TbMVeCBALsTzV1nUYo8faxW3yukVsbeMsullxA3tsx1tVumK
 XDypyL2K5oJmk8L6w+r5Yg5UxIH92Hp3Cnuf70XWmBKHG9HuBJ/NOxTZeZHG2sbD5VWCTgDSl7t
 BTkM7lenyAG31P9IAeJmAYUgM2RWoNDj/RhKGSd21aZJMG7vUot8hjk4Xrsw15kbrZ4Ehg+mKpT
 FzMTyfDt2AepZwxtd/T7QZBOm/LqwQx4euBiqAmmlmuYbJcvPmdQ==
X-Received: by 2002:a05:600c:8b6f:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-48320236963mr178149685e9.29.1770667612526; 
 Mon, 09 Feb 2026 12:06:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376bd5a074sm11905721f8f.11.2026.02.09.12.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 12:06:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/2] rte_flow API unit testing via null PMD
Date: Mon,  9 Feb 2026 12:05:41 -0800
Message-ID: <20260209200648.182725-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The rte_flow API is an important DPDK interface but has no dedicated
unit tests. This series adds stub flow ops to the null PMD and a test
suite that exercises the public API without requiring hardware.

Patch 1 adds flow_ops to net_null that validate input structure and
reject all rules with specific error types and cause pointers.

Patch 2 adds flow_api_autotest with 31 test cases covering basic
operations and error handling.

Limitations:

- Only negative-path behaviour is tested since the null PMD rejects
   all rules. Positive-path coverage requires a PMD that installs
   flows.

 - The async template API, meters, and indirect actions can be
   covered with additional stubs in a follow-up series.

 - Aged flow testing requires a PMD that creates real rules and is
   outside the scope of the null PMD stub approach.

The test code and null PMD stub were generated with AI assistance
(Claude) and reviewed/edited by the author.

Stephen Hemminger (2):
  net/null: add stub flow ops for rte_flow API testing
  app/test: add rte_flow API unit tests

 app/test/meson.build            |    1 +
 app/test/test_flow_api.c        | 1015 +++++++++++++++++++++++++++++++
 drivers/net/null/meson.build    |    6 +-
 drivers/net/null/null_flow.c    |  237 ++++++++
 drivers/net/null/null_flow.h    |   12 +
 drivers/net/null/rte_eth_null.c |   12 +
 6 files changed, 1282 insertions(+), 1 deletion(-)
 create mode 100644 app/test/test_flow_api.c
 create mode 100644 drivers/net/null/null_flow.c
 create mode 100644 drivers/net/null/null_flow.h

-- 
2.51.0

