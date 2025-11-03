Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A57CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4431140A76;
	Mon,  3 Nov 2025 17:49:54 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 7051C40BA2
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:49 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33ff5149ae8so3568606a91.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188588;
 x=1762793388; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+HQZGaaTj3zoxR1KSMGzVnvIOyXBukFwbDe8gEmrf8=;
 b=mpl0D1O9jW/e2IKXUQQabRJJkcQ30ewSzdfWC5cP7yW9Q5Tvo+iBQSCSw4UiOTAil5
 NnAcp8FdGeXLxHWcrnR9KyvxyDPdL99hQaoCFoISDlER7McYKWmufM3tOiu+q/wPW9s2
 mfyrM4+KiHw+8vipmuk6q3daQfLg06IHQqJGX9iKXknFThNTpc1ZjnVCJIVekpigLwto
 Opxc1l/x2VyXWGB2GRH4lLS4L6OjCN8jOOUb6u7D7IEyMeVTVHqYx1NFNAgaz29n/GS5
 ZMmVMuMqZebIUfpTLhRNKOUpE/CHub8Mr58dU3AgnNFqdvDF8KFPFYli+SaieiRjsVkR
 fx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188588; x=1762793388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+HQZGaaTj3zoxR1KSMGzVnvIOyXBukFwbDe8gEmrf8=;
 b=hTt6BOmvtJeTE77he7XJGodKAEn6d6rBI8BcaGeWhF0mbKJ59TIS704TYuN64Guwwo
 SsBKfXqSpR5iMqIKnIeC6/9jrkkN0+chDt0oFHPl2H8+KlJ8lvx0EwbRMZ+OeC9NV2e1
 a0b+6/jxBa+rbYp6EQ+Tt23cZFsz3bojPR4HTCBhY+hnFLW9hcIeFfqO+lIFikDPnfX5
 nRCoYFsae6UQvEstFda7s7WNYQSOR/lZijpQ3z7iH4riSGF6gsgxhPBWIaI1aaeKOi9Q
 n6UCN2m0gDuimN7ywURHrqXAwpfrii6vUCLJASXQIo1Gdozd9qjOofnoQOxEzLSNV/ru
 hjtg==
X-Gm-Message-State: AOJu0YyBXEh5RrrVBcW2UxK1bxEKslL6zG8ZsOSKDUUpr2NiCUD6NiFV
 IUY9TK4s1Fih88El48T7C9bJT8bKWX9nvWKlD0wdpzyNN6vHf5t/s3t5VgawOkKu5tSWtoY/VIA
 wZsmO
X-Gm-Gg: ASbGncv/1dZdFPUQ9PU6nMc0N6sB8dSc8mCAwkNQwFwnE70LBfFGvftpqJyEqmhpKyh
 n4iQtuTcEQh+ChI+p+aM01uH+I+Wd3UH14geICBBD0KtQEvIR6E1ZSMc1ZSaCTK56+F8MdCA61w
 o/mD9mqjzBomRgd/mX9ALfpt4dvJ7YLCutI4a7HaTWt5rbMXZLa5pYedj3F9jOp2LpXncZyL+3F
 r60t13yMituhpl1r8CBiaUw8wXM2V0xjVklD/ovCvfya8XIC7wOKiPK8M/HpssJilgnx8xC/Jjj
 a4SIj7nEpH8JfVk253OoXWhx3gvpMajGk0edp91pwhP7v2PDNnLdMGlu+iRowXAyGZLFhJpPLuE
 +sOfA9u/BkYyGUxPufl6ezn1gYY2W4jtv4IVeEO+AI5lj0VlDb7A5YkxKVaytCxnAo4t1/bsU+f
 cjLO+2I67ulvzfsTLXeQUykPE9EbRTCcnWVdABwNQ=
X-Google-Smtp-Source: AGHT+IEro2HyglRSMCAq+DaJSyFO07w6/dJ+SgOo+WwYiIg5Db3jmFQTs6MnT32Axf9JXIJzENTd2w==
X-Received: by 2002:a17:90b:584b:b0:340:b152:efe7 with SMTP id
 98e67ed59e1d1-340b152f234mr13551728a91.11.1762188588574; 
 Mon, 03 Nov 2025 08:49:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v3 21/44] net/bnx2x: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:26 -0800
Message-ID: <20251103164915.101713-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x_ethdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bnx2x/bnx2x_ethdev.h b/drivers/net/bnx2x/bnx2x_ethdev.h
index fa1c3ba955..3434aa0c9f 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.h
+++ b/drivers/net/bnx2x/bnx2x_ethdev.h
@@ -8,7 +8,6 @@
 #ifndef PMD_BNX2X_ETHDEV_H
 #define PMD_BNX2X_ETHDEV_H
 
-#include <sys/queue.h>
 #include <sys/param.h>
 #include <sys/user.h>
 #include <sys/stat.h>
-- 
2.51.0

