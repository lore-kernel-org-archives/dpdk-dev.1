Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3804C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 06:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67FC64021E;
	Wed,  9 Jul 2025 08:47:09 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 836844013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 08:47:08 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b31d578e774so537613a12.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752043627; x=1752648427; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b2jwCB+e3uFzXPwLJggncPdqvwSTr8BBTMozEKc/awc=;
 b=XXasbkT63OM5bYEJpXH+GeEkvQmqO1T4RROhqaL56qACJYfFKXcGDoGVwyGDChSCzE
 tk1vjOiGRebuTGJRe62FUKoW/OcCcPwLN7xh0CpKnRadE9Bff1QeER5xyfzXrUrqz0Ol
 CchV9EHGRQbP+WB+5cFnIVnbj5GCZKYCEKwuJCQzXjjn2WQlR0moOIyOZDDr6rNZKb6c
 u4Knvif1tQJ+PxUMsmJKpuJ7QdCuEHpbUMmPFBdPRvkK1UpuQZ7pE+UTG5rn7BnYTWdZ
 7/KhGw7huY9BjPp1MGEkstB9fesMcsjxIlwX/cieSmlswsL6jjraM2CHRsiPIPUc6xi5
 DPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752043627; x=1752648427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2jwCB+e3uFzXPwLJggncPdqvwSTr8BBTMozEKc/awc=;
 b=bhz8PkcnbF0Gx7xYZaYPOAAiX4DFOp/PKqCjjpROntWLNYDMWHKSbTuTsGFGzJfCTy
 +qlOWamL0qbJDTcHqjxPl7qk3u/MGAPK+Wk5kmV1XJrniEQhpfV7B6c9GAMQ70Qkc3Tb
 /+Dy6k/vp18EPPJQ+C9I9tDd3D0hfPISR7I9h2ZWJgMZuKb6oBeFheRxWXD1Rw6eseu+
 yvgy6VcgXFRy+OS1xOuty25L8w4nZ0KULV08O8c26wnu1vGYWpUG3cRzuTewZtMTBGQV
 PuOB4nwj966fiNI6wZyc79iK46h/mY+qhDE9CcWKIsW0gF7ze8fElS888MwN/IxAxGWo
 k/gA==
X-Gm-Message-State: AOJu0Yxj/PkrSogXAOGPM09dkTpokZ9nwwmMYgw4cBAaMag+Q0QHWcu0
 VUr3Viav6ojoDyuckXZMseV+PAL9NeXxpc4JgrDyw4kqTI4qh79Dg+GJFLYlbWyMsfVZo039bxs
 wet6iu5czvw==
X-Gm-Gg: ASbGncs5oPCUIWfEu5QzcBsRD1KOwefRjTAhCJM8PEsAyCKAvKQNRYT27IJTEKZ1LFc
 Cx9D8AYL5gUQmtZhzFzdMKyTDYEm6p4lTm/gf7pkovOtu6n1yF9MfYQ5dFD2ybP3E6rBYZVjYnG
 VbwlZwfj7x7ZG5b/7fOnzgPBzonzvNvVKlitTgmJwYaBj4L/IFnJddUSF0qwOrON9DmqJS0TxFo
 OBOcDCZt6T464ZCzdlEPQEM+5ZhG2ZEUxBseJ+8gvQA5VdF0E7x+uxFInWWNL4EgHr+Pz/SiODI
 UA/ZYuw6qzxGITqrPifCpbVEn/Ur4r4qCEMS7lQRcmi+TjOTBA+8RMg0Ch8mQCtQ
X-Google-Smtp-Source: AGHT+IHVUpnOL0bwZSwByWK93TSZZnfKd1Ixyc8dLp8RqWR/7UHxJT6Fq3855dMhM5HqMZTR8R0Ifg==
X-Received: by 2002:a17:90b:3f87:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-31c226ab117mr7949810a91.6.1752043627358; 
 Tue, 08 Jul 2025 23:47:07 -0700 (PDT)
Received: from gmail.com ([103.163.156.9]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c300b50e8sm1076317a91.31.2025.07.08.23.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 23:47:06 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 0/2] uadk: realize async mode
Date: Wed,  9 Jul 2025 06:46:59 +0000
Message-Id: <20250709064701.100676-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Realize async mode to replace sync mode for better performance

v5:
uadk do a 2.9.1 release instead of just tag
dpdk build depend on uadk 2.9.1 release

v4:
Akril pointed uadk build issue on x86
uadk 2.9.1 has fixed the issue
https://github.com/Linaro/uadk/releases/tag/v2.9.1
Update doc accordingly

v3:
uadk 2.9 is released
use different label name to fix build warning:
	"duplicate label table_uadk_versions" 

v2:
Add version check, requires uadk >= 2.9
Add version table describing DPDK and external UADK library
	version compatibility
Mention version dependence in release notes

Zhangfei Gao (2):
  compress/uadk: use async mode to replace sync mode
  crypto/uadk: use async mode to replace sync mode

 doc/guides/compressdevs/uadk.rst              |  15 +
 doc/guides/cryptodevs/uadk.rst                |  15 +
 doc/guides/rel_notes/release_25_07.rst        |   5 +
 drivers/compress/uadk/meson.build             |   4 +-
 drivers/compress/uadk/uadk_compress_pmd.c     |  94 ++++--
 .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
 drivers/crypto/uadk/meson.build               |   4 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         | 297 ++++++++++++------
 drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
 9 files changed, 320 insertions(+), 124 deletions(-)

-- 
2.25.1

