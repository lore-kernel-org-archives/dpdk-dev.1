Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73824C55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2FD9406B6;
	Sun,  2 Aug 2026 20:18:54 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2FF5D40615
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:46 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so1350734a12.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694725;
 x=1786299525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=92OCKLmgv1bkCyMdXj9IW12KK6tcZponr9vKNS/ISnU=;
 b=mIowoMlExlAJ3vDmQRbre1WWmqy+c7Xa87koRAmoEgIy7unye6SeoT8yLhSzupQWUN
 HrJcCCMvXI8BrIiGNlpDz5a3C24V+03ZTq1RaqWeGj4lwNUbISE+ncc5GrcyrfRsSV+W
 541uqo78RqDxha913wv3IPNX3alA9qc8xCW5UDbgN4AP3kut9m4nFxixr3NEk9f4ghG9
 nkXtBidLZwU1owHvEYSzIV4YeevaSjVJUePe0U6XrTTgE1HlE9YXmH34QJ5TtVpOHkGx
 cFS1lKk9P1wHZzw8QxBXMfPd4wANHh6s+ZE4hHzq2SAo/0OXgXN3A9R6cjREPtFIWpDE
 48fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694725; x=1786299525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=92OCKLmgv1bkCyMdXj9IW12KK6tcZponr9vKNS/ISnU=;
 b=GUUDgJo4EdqDG/lPZ9ePQ4bAgR9FvnxVUj+XkW0zb/LWkfv39lfXnWV0Qqa4/NHnAf
 c0IvYhiV1cWGcHDQlpF4QzsVmMD7EaQMF7Gz/3Th0JwKso3GefAwoWUMISS0/0blKZyq
 eLJ2q/EWxxFQTdpgunwdROXjLOvl+N9/F5xuryOQBoxWwM1D46AzoMXWU7O4D0GCDGnx
 DTmb8vffqBPzgniOcqGGkeQm7xEC0a3Q/IZEyvzHTAxC2yZzLprMnPaIL3yQxb/rj2f7
 MMwx+1OVhMiA3LbNvm/9uwn42VpKX12IpFYsRUWlIJp32vTuDT++B9qgG5UoTP598s5J
 wZQw==
X-Gm-Message-State: AOJu0Yyubpt65wawDe6BabdKEzeSS05flpRbZlulMwEentnsVoFxyVO/
 M+kE7+mRKxfZ+bEZKmQNGTgD6Y2N1hzc3m2qcif1uW7k5kd3QzWZcsF0waVSQInx+Aka9f0LTNd
 xG05w
X-Gm-Gg: AR+sD115ryGF8mKB55Dcwo/42UFNI2+6Sn/q70KL05JpfoJaFVI25Qoylhq6e1+Juf9
 SlUKZ6IEu0wfoJ98MhYeCUZax5H3h3Ajp7vMkU3l+t4cK+Wz5MctxA8ATp1ftxvgVbclXxgT5hd
 ztuErvNv9Wm/V2Ep/UZSNAJLxKrDmlQ02+qB2Npxm6/PelBlFk/ySXJ46magO4vc7EhkkO3PxKq
 I6GWakvqS22b+HX598g5BuiNxZjUEzR8G/RfKi4NIhEV23R5kDEtGax/LKdK9QXp0838GUIW1VQ
 Rqb604TKjHE7YrwN9nuGGc1YMqCmZK25F0pMFCrjUgSI7+xHVxRrty2YBGr4mVtfQq14HoM5os3
 PyZn0W01P7BLEh0qpMJbqitDWZKXVK0fXngiKVfaZH8oHE/davizSb1c6BqGZPrPNlaxbqCP/In
 yKNzvH+b+NQnaBgmEDfkgnL0yk2yxegfU1a0lA+XLN4tuYeAsK1GwsG7ynEwoiEuTpR82pfPGC7
 tzRSqDajYfBWMIIhumRJLBfvMk=
X-Received: by 2002:a05:6a21:998c:b0:3bf:a1e5:ff53 with SMTP id
 adf61e73a8af0-3c92a9c5751mr7507002637.48.1785694725393; 
 Sun, 02 Aug 2026 11:18:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [RFC 07/21] crypto/dpaa_sec: include UDP header
Date: Sun,  2 Aug 2026 11:15:12 -0700
Message-ID: <20260802181835.476887-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

Driver was getting udp header from headers included from rte_ethdev.h.
That will change so include the used header directly.

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

