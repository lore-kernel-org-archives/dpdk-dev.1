Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838C8CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A8F40DCB;
	Fri, 22 Aug 2025 20:21:17 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 1377F40A87
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:21:15 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so1543281f8f.2
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755886875;
 x=1756491675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpiaMk3yMbQwa2dcFF5lc1nLFFsPkBzRTplJY18F5mM=;
 b=1jdEseWPscI5LI+q9skra4p7VgnPP+4X1MLi6JfIerZHVAc7e7mII0eKAOVRmQ8FOz
 cRwsEUozMV0sRviThiH97n6fli50xA4CPgOESP8B/vEL9pRTJnPcwmOJqO7jZrIxtmPO
 +L5vm9AcAxLgSqkU9SnDF1JDyxib/pXFkxcR1EvHfc3jdnNZnDnY0F2dZ4ruz/U1co0T
 db5AIf8sF/uwyI+vgy8hYiEH9iVWEAZVbzB8YurLUrDhndoyX72rORdcx42WqEcRyeJi
 mYLiQmXGrU2RuVQ+Jg3QQ594ljadWJdvjXMc4cxAZVAA/BNeXPUbrwzuOXgSbGGvxiES
 MxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755886875; x=1756491675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpiaMk3yMbQwa2dcFF5lc1nLFFsPkBzRTplJY18F5mM=;
 b=fIZXE4fC4OD1k4h0JWcTFMKGa+me4Vp0ZSybw270sixX72zaaUYX/oMgx4JmCpJEvG
 w7NWHR97eqtNRHRPYUgvw6h0/lDGpCqSf805Hcqp1KvPC7J4jjRw+lhPD32qf+WlsnYo
 h+BgI7sEcm0tdHu18LlGHxbnPGXMwbdecWwkEqYw7RkwcB/TupyYObNGsxiB47T/bfBx
 g+oBw6j/eWqZfxApEcCcNq3p90JgLU2US4QVAOWRiRCHTZLU0bgIub2G9e+FTRmDidpn
 OgDGjz/fEomt33P29QSoSW1AvV9UlKWEdwOLJQJJcKj3dPizIYfkwClMaHvHmP0TGRol
 CChA==
X-Gm-Message-State: AOJu0YzilNrqtigxZLgzlbwEWm5W6X0kKhMDFs9d12Sc4zmg55MX/71H
 6Dn3Lt1s7Qo5z4Fqnp7aOslBPu9HDTYbzMZEWvel2q4xaI1gbUlmeA5xK1/Bt38KscXdZO//RbE
 VJqh1
X-Gm-Gg: ASbGncuEQZLHt01Opf0ZQl+OVq8BiXQx2dXg0418wduMRBrGTNu5vlANowlwqwRMjYk
 H9azexTA4T4i5xaW+PHu5V8AZzBTOROeucPhSrWy04rGsh4dsRHmxtCjrL9rXjAM5+912lueqHh
 X/lEq54BDe4awi2i+Z6XoxGjU+GAWpi7dUlECv87eS32M3VMzw0aGIAgBCt0fPS2I9rUJn06bS1
 Lu0NofuWAlsOp8a+9+veYefV/LyKJLPyxEKwYWkjDm4PEin+C5LYYHNLWjXsATaeLK0HSIUZBT0
 WoHtjD81YGuLiHtCUU6d5/xswSRwCq0yITaG+frTYrMoh3DHWyg0t1SDSPEvTkkIjcR0et6kiNW
 CSqtEVhsw7W9uXsGIz3mv6IcgHHELqzPEsM1J+Y6bmEnEN0R6sp0hcnSuYOzKOtLp2c/DmGvv
X-Google-Smtp-Source: AGHT+IGCz4D1zMuzmwwzonP/wl+4gVfXKX1r0LOCprWcDktq8/Bpej9EWJfsBE4Vc7wCt/Px+wG6yg==
X-Received: by 2002:a05:6000:2dc2:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3c5daefc754mr3229138f8f.23.1755886875241; 
 Fri, 22 Aug 2025 11:21:15 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711ca61d8sm376441f8f.61.2025.08.22.11.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 11:21:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] Cuckoo hash cleanup and optimizations
Date: Fri, 22 Aug 2025 11:19:30 -0700
Message-ID: <20250822182110.27599-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821203646.133506-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
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

Stephen Hemminger (4):
  hash: move table of hash compare functions out of header
  hash: use static_assert
  hash: reduce architecture special cases
  hash: add support for common small key sizes

 app/test/test_hash.c       |   4 +-
 lib/hash/rte_cmp_arm64.h   |  56 +--------
 lib/hash/rte_cmp_generic.h |  35 ++++++
 lib/hash/rte_cmp_x86.h     |  60 +---------
 lib/hash/rte_cuckoo_hash.c | 238 +++++++++++++++++++++++++++++++++++--
 lib/hash/rte_cuckoo_hash.h |  84 +------------
 6 files changed, 275 insertions(+), 202 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

-- 
2.47.2

