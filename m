Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CDC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7625C40A7D;
	Thu,  6 Aug 2026 07:10:26 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 9718740A71
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:24 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38101f85591so486021a91.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993024;
 x=1786597824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=NjQG0bFcDrN6uUsADGus5i4daMeqAy6DzX4J0EaHuad+hpORz8ZeH1KBHWcs4mLTC0
 VkpzvFh+SzRChAI3brpwngOPBrhA/zoKxVn4oSRprQ1nOUONJo19Sm3HBsS5e41MTRlY
 MxuDGt+aS7IP+hrfd1jDB9fIHhtZvU/MFHi72IRaqtoA+MseW/kemotrRDINMcgCCSEy
 cAFU12bUauo60oNmxCtR2m6OC8SvSLyMih0hUnbpAwBMPIwm4hQOdpXlzBCWe/b11GkO
 Tq3JMvVVugHoQ7+NikxwKaXCwQID2Ie7A/kOFMWaA5luI3nsI4RO8SLUJFXoBHaiDatC
 YwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993024; x=1786597824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQZLVj6klTDkcy47sBfEwcTsMKVlzfnccpdQbw/FiTo=;
 b=B1s1nS/MolapkHDi05O4LmP9Db+lrlxQyJ1L9orbR/xy7rb14D8PPEyKkL7KyLi+qf
 ZhSs/96snnhUC6tCz7nDunZo6zVzjb+SMydimRdvwiZ0HFU2+NaTZ5z/Ovg3kPLwXxEX
 ogdXuK/qTXAQ7DIVBhsleJEbv9JUzmwVRd266AcRWKDQPxVfVdewOpvtlrmHf8q/5zZb
 c0qHQaNhKMcRTjYvcZ9xPZDqdvCZpwa7t2YMy8Se1HcRjujYIsLpOnuSYiGWRq4UtqsW
 KbgAukl9s0IswD37/0gCDTrcONhrTaPw4QS8T5VPjQdlJ/jtb/40grxGvz8KYTMPJPk+
 LZgA==
X-Gm-Message-State: AOJu0Ywznr1QwoW5GLMUk6KjVQLxCHsjhY90B2vIwgliNxlcc6b+4/Xf
 1V54sDapEYgdf6adMrjkimaKHTuCkZJjshQh4BSUde9kZ1k+sLGL1PrMcNp2+n1+sEcnqOvg2hR
 2pEmdtD0=
X-Gm-Gg: AR+sD10EwfRKUsvQtNISIptHvxuzbDpgEqAEBTpKgPjTReSdBtbj8gHsvkJx9ULsk3O
 HiK6Ohj4S2vBeYwe0DNzv589xGZ51gouaHabxgR87DCx2edPoDb1upvEYI2Xyd6q38EFOeM/DqY
 TEuuf6drD+Tk09oNhGhSwrcrfsPjKR05KSX3Dtvx6UosjTbNf0QVHVBi6NLytAgOH1fnQR7+HA7
 AAvU7dAc8L8HejwoJc0JcfIDyDH80LJfwZZbShOkkp8MYfXnvU19PZBOPYcXqDwK2sNjPizuNLR
 tcj2Ns2g194dYzKJ8uzOEF0LyC2h6QaV90Z7B5KHImtvaZL03QF7LxaEbqjX1OF3qOfHXprvuxy
 fmYBTY6e0Lhvx2XgcvolHCku+AzjfdVGtcQUG+EEi/w0kCiwC8zfA+nYBAF7XzwLlm5ZVRQgufV
 lH4qN+2WCu1J3PyKVZKPoAeJ/Dhpwq0oNRWAuZQv9RGA+qN2kW5iEZYYAV9GR9cbFSIVmQ82Hp5
 0SjieCPFESEyRzRLPryR5OilkY=
X-Received: by 2002:a17:90b:2ec4:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-39083aba06emr2451042a91.10.1785993023602; 
 Wed, 05 Aug 2026 22:10:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v4 09/23] crypto/dpaa_sec: include UDP header
Date: Wed,  5 Aug 2026 22:09:03 -0700
Message-ID: <20260806051004.166778-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

The driver was getting the UDP header definition indirectly via
rte_ethdev.h. That will change, so include the header directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa_sec/dpaa_sec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.h b/drivers/crypto/dpaa_sec/dpaa_sec.h
index d78cad818a..bce60d9cb8 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.h
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.h
@@ -7,6 +7,8 @@
 #ifndef _DPAA_SEC_H_
 #define _DPAA_SEC_H_
 
+#include <rte_udp.h>
+
 #define CRYPTODEV_NAME_DPAA_SEC_PMD	crypto_dpaa_sec
 /**< NXP DPAA - SEC PMD device name */
 
-- 
2.53.0

