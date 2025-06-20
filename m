Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D8C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 03:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A974A4026C;
	Fri, 20 Jun 2025 05:35:28 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8A8F4400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 05:35:27 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-23649faf69fso12603145ad.0
 for <dev@dpdk.org>; Thu, 19 Jun 2025 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750390526; x=1750995326; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ofalxqA3OKw4mZwnfJIyWcs0f6aEC/FjV7YTA74tvys=;
 b=wNO0hubukR6rgh0TQvPpPJFpxQWuJEYAK1quTFMH4othDcsT+OzyW33oXuCesVudOt
 NsoZzD+pqA0KewC5OJe+yClR5THbkkPZ9+J77IAOvPH7Xbg1JxGMPngpLLhwVLNBLpcX
 RsPQHwWgaNWBQDx8lW262+mLHHTx5ZQ74wqImBkm6+ftm1pWC4irhxHSW6Z0L1IisH+j
 aF8xGxifCjMUcC2nGNd7INQYN8ojd1+KrEw38qjUTwktCecZ+2auSNu0TqRc64AfrtTg
 TI2M8ZfAfrwG4/MJOLEaQ5/xrojeprR9B5qx9+0I+cj6b3lTykFTVcc35wd2TYw0UrCS
 Z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750390526; x=1750995326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ofalxqA3OKw4mZwnfJIyWcs0f6aEC/FjV7YTA74tvys=;
 b=sNujFiUW9Hww8WBY6x2wP41cuRoc3t7uzGtAF/VqT9zeMDh+bia6QEPyHh438CpnF5
 7IkaZWiS8t9xHMhiUbq1dIkdwC/L8/IACg8GEgPD48AiEBVU4alEDppJvLaL7xxCkpjg
 JSLf1prVpVfbynFBTL+2/U8j71nu0L7k744H0Xyec5xGyMANjoJxWCcnokmTPjOdCRLl
 W6RMdIdHSZX27nxGG2P5J2xT6q19fTb8LZBTNm5Pi2lMMBjbse9T1KUIdncUqXtcihPi
 pSbzLesoh02ybvsivGTSrtHqTRC7eDdXK+G7fbFP7BUSGK28p29lZARm6qa3/ir3O7V5
 /xzQ==
X-Gm-Message-State: AOJu0Yz7tc641boicetRZq5Uaiq4pZEGF9AlLWIjJdnpupDDROMlDy0I
 UiX8mzgGJwKQRX9FpPgHmIN8+v1e1mpajjncwa97E+9ao8AIi2KtAcKqmTkuq2McCYM=
X-Gm-Gg: ASbGncu7cKAgE2RbwaqhjDRnRtXwD3KCb0AcOhtudk1TceTdpif9fiFw07AAI+W3Izy
 TRuhM2K3aMcJ3/hwAsFw78QG3coVE8rZm7h7iEWXscI3uafThN7osW+lk9kWZSUj19IRM313i+I
 vNLJPq3yUM5iSvQZeQwqPzJ09QdinhiV33QJC1uzD8QFicOPIVRMJ05x9YI7pWuabINJKJQFVY6
 Nyby+i9g9q0Un7gdh3m1+AUsC1eWqxUjA3eERwgbdelet6q7hr89M5FmKf7NCyDIdRR3e8VYi/u
 aivqjadBwjyjfMj7SFlZ25bw2Xw9mhla4bgAzPNp20yRFcwjJfu2sZFqjxTzIAxV
X-Google-Smtp-Source: AGHT+IEOXMDbCNIR0WsOoaryEymHVYYG0xHKltAal0wfSzOmusul8rEF6K98U+5DeaiT7qEFe2NAUQ==
X-Received: by 2002:a17:902:e843:b0:234:adce:3ece with SMTP id
 d9443c01a7336-237d977556fmr17346995ad.11.1750390526456; 
 Thu, 19 Jun 2025 20:35:26 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8673e1dsm6883075ad.163.2025.06.19.20.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 20:35:25 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 0/2] uadk: realize async mode
Date: Fri, 20 Jun 2025 03:35:13 +0000
Message-Id: <20250620033515.86501-1-zhangfei.gao@linaro.org>
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

