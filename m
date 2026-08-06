Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F1C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06D9940B8C;
	Thu,  6 Aug 2026 05:26:08 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id D46F340B91
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:04 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2ceb096e675so22668225ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986764;
 x=1786591564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHsNaaZd9R7zzhnVrmXetday8xDf/JlvrgYN9xgtpaU=;
 b=f7BAB7srevfjVFZXkPJ3thy1cqOcz07O6iL9h0UPmWSwcTVLIZk5yTontn/YiGJAR3
 LuQ/A6SlKfZBTE2jQg4zwtz/WAkIGpJGnziHjzQFqM+eosGGNF5qieja9vDLgSQDkrH/
 oMtgNAyB0HxOMki8dxd44nCmiil7DAQxpbSG7B8xDVS4rOI3wOqrBdXOHGbrrwE4w78X
 16QTt/+wcDzABSzvTCDRc9LgHMh3umwAmA5vYWGlhC5tC284KDO2DzuXvXPbIaHKsyrb
 nmqBwYkEM7ilLizbI9nzbkZb3GOOi/DIPsfmWbI5l9guMaPvmAVs3w56+VE1Q2B38vZP
 wo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986764; x=1786591564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CHsNaaZd9R7zzhnVrmXetday8xDf/JlvrgYN9xgtpaU=;
 b=HNn3+PptzMsO+nR3SqznmIklRzvdVmcD61iKqfpvwFgRVI2J/Bw93XAGosH7lhS3P7
 jCw/+5a62yhEFgswAKwnylwl8HEtYuMJz0o5dT/iBbaefPzSLQh+PcBX+XjRo7bNJcVy
 xtdUW9qqlmzVovPTF7k6BzuJ6VHEWZcpVI7Xvlu1GeDyStAFn4foj80UY2wVBDBCfe+p
 ZrPZCAYEbxBQezbPYm7JkNXTmPNRqLwk1EE6mxswm7Y+uGyHf1NFJY+Qn91LDRdlEZpD
 TDhmeFVqVqbgqZuyp0c5LMS/hgvOhjbv+GGtWikzc/ovcIYNL+yo8jH5meXNHqud+jy/
 svaQ==
X-Gm-Message-State: AOJu0YxCQOYfLm7Mf2/V7YlzdOGFatVJ6MuaWU71J4c2qaoXh19d4iRs
 FIKghgOR8ohMTelnmJmMzuzdhm4VIAiW4FKslPBLm9/w9rnCgkTo1IhYiaAqXfR4BBm6fXeNlgu
 gEANzJjM=
X-Gm-Gg: AR+sD10Jys1wCotJ/Awkvt7lm7vrcAVbi0Y9m4Fqfeq7fUxXwphHdQA7/uvTkEx+kHr
 qcjqgAdPQpCNWKiY/uVlOKA58GMDLb0hLy3GWWF8N4EuSAiYowXcXwB0StcadoLmXJejdGlLVMY
 NVA+ICZ4XPW661uEW17DvizL7Xm3gbDpD1gKQadahRJlPv+r99FmxqnZmTRNhANU/Guo8dkX9bb
 WbQ1Q1Y1baLrPbZGexYMq6i2odbpfMx4nvoehqkg4+NrB8NCdKrNIndctUq1WnYGtr2qNU0N5A9
 Py4U9eAasWCM2n4rNqeBaug21AN9cKyC/Kswelxdm+kgGeCCo095IYxWNcd7ITAbQWt8Q4blwxp
 62su3qh0zbnwxYqkh2F1miVtsYDUJ9vorn+3wUDh+AtE2aok+FG5OEWUdBJgGuQkwd7H4ulbxx8
 M2QEB9jsf0YOVWJN5CfU61zR40EwBnLYjYE4LeXXgqSS9NT6NXwURqaKS0SWgSmTIk+bnkiwL1/
 kcsyhfvwU77LsujXckooIBCc4E=
X-Received: by 2002:a05:6a21:610c:b0:3b4:6cae:4a50 with SMTP id
 adf61e73a8af0-3cb85e52d5emr14839925637.20.1785986764021; 
 Wed, 05 Aug 2026 20:26:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 15/24] common/dpaax: remove unused atomic wrappers
Date: Wed,  5 Aug 2026 20:23:07 -0700
Message-ID: <20260806032544.21337-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

This driver defined Linux compatability wrappers but never
used them in current code base; remove them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/dpaax/compat.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..580620caf0 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,20 +365,6 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 #define spin_lock_irqsave(x, f) spin_lock_irq(x)
 #define spin_unlock_irqrestore(x, f) spin_unlock_irq(x)
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
-
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
-
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
 
-- 
2.53.0

