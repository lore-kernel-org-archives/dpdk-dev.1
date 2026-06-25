Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68245CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6AF840669;
	Thu, 25 Jun 2026 18:02:06 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 83BBB40616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:05 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-139b5e604b9so55766c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403324;
 x=1783008124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PRbrft/OSZY0057K0tzXEEdVcl/LNO8/HT7DJ9SWe68=;
 b=C/LHp9/hpOuZNDx/xfVNUznPGAxXUFyodX0InmkUIEu2FllL/+hyX3yBBeT0np6yRk
 omkrPRWptxNW/A9OpNq5rEMszKqoyzzdnrI1zWPTm05/cl7F0IHzEi0WX7nav82Gm/k2
 LfGgvXqqYWrUxCtjxa2k6CZTI9zzp1t3OS8w5c7yzYC5cF6EhFCXM6T4zvPHSRplic+F
 ywof9PiQNaV+xD7mZtU9/bXjL5ag6RbwXRMQoEueYv2xr1FvxVMX4RsXO351PX/YCQLh
 PtjKaF9eRrplYkmV56bFknjlXFLHbrd9ZUHRsoH2CxXyai3qsAj822N0TWhreC8Xr+Xk
 xu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403324; x=1783008124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRbrft/OSZY0057K0tzXEEdVcl/LNO8/HT7DJ9SWe68=;
 b=XjMYXCgazkHaDiH91poLMA4XyKOSawzYAVcfCCSFwXWqzMdidVrQSPHy/AkWd7MBfj
 cYUCSeLfB5Zb+JQys/r4NafPgzvT5lCrgSoUH4l4zgd3BUZoYBmr6i/OOr87gcwhYTzs
 t7xojI986vZYbYJkMvyf4YK+OHZGSITyokclf72+ZBL2e7UV5XiCZ4hbraKljk3IBS1N
 8MA8XN9w0BA7wE3fRLqq28qJe7/rEmeHq7YKGtaDSpDFH88Q1shU7Q6wc68+L7QbFmap
 d/arvcb6tKK8qhgHbMtrvWriCc4ACIso3iNVMQ8eo9mOFkR+MmuCiHWJNRRYNJPVxzsZ
 IQeg==
X-Gm-Message-State: AOJu0YzS1C5UTapOzt7ZyJDO+Culw3wi5mMseXFIfcKOlAiFF3jN+fQ6
 qvQRFEZ3CYoPVsZ69llPagdlp3V1V37eHkcWbLl+0LvckCIgiiQE1CjsqDF64nY/D5YZFb+F8iN
 aLywf
X-Gm-Gg: AfdE7cnNzqLKL9ki7OJC0AyO/xhv/TWjlD1uepiw7dJqxpZ3zLnThucAVa5y7flkO58
 9vEbPh/aJJfagl4o+yyrvDscHsa+d3u1AK69RUlIp2sCyZ386rMNkQZKc858udaH7CFrHcCSNYJ
 j1SFyHTHg3BMJWWUbi4BRbeLtAmbwwnmOS5dQoH3POlFEYWe9f2ixI+e53Vn3U+G8InDxVUNGKG
 3ZIdOTBevFXJfy+3gz2zu8d2V4GwJAh5nWbJ1XvPt4WbM/+lh2IycdIMd/ZJgtXTXf/fyUdDNZj
 td9+OkfOIQQc7bzEtrf5VuZhfczl1xRMvHKl8jY28lAc7+Vz9in8MXybdy9VeNmh6FMmOGAOcnO
 I5Shcm7ZGfLrDqKU58goQHJXYTU946wjIeCDleS7gTbGQcHiqfdiRehLKa+HEiirI77obRbfzWp
 ANvJ/T0Gr+l6aBcUAwNUd8/Amr6VwJs78Ak5r7Xs6wSyRfQ1r7VCQ=
X-Received: by 2002:a05:7022:6b9d:b0:138:13e9:e66c with SMTP id
 a92af1059eb24-139dba047c3mr2924668c88.6.1782403324029; 
 Thu, 25 Jun 2026 09:02:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/5] crypto: use timing-safe digest comparison
Date: Thu, 25 Jun 2026 08:56:33 -0700
Message-ID: <20260625160200.24170-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Timing attacks in DPDK crypto were fixed earlier but
several drivers did not use the new timing safe comparison
operation.

First patch drops the experimental flag off rte_memeq_timingsafe().
The function is a static inline with no exported symbol, no ABI change.
This avoids having to turn on experimental flag in other drivers.

The rest convert the digest verify comparisons in the uadk, ccp,
armv8 and cnxk PMDs.

This problem was reported for several drivers and for those
the Reported-by was added.

Stephen Hemminger (5):
  eal: take experimental flag off of rte_memeq_timingsafe
  crypto/uadk: use timing-safe digest comparison
  crypto/ccp: use timing-safe digest comparison
  crypto/armv8: use timing-safe digest comparison
  crypto/cnxk: use timing-safe digest comparison

 doc/guides/rel_notes/release_26_07.rst | 4 ++++
 drivers/crypto/armv8/rte_armv8_pmd.c   | 4 ++--
 drivers/crypto/ccp/ccp_crypto.c        | 8 ++++----
 drivers/crypto/cnxk/cnxk_se.h          | 2 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c  | 4 ++--
 lib/eal/include/rte_memory.h           | 4 ----
 6 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.53.0

