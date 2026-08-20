Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC19C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FE0440E13;
	Thu, 20 Aug 2026 07:26:25 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id A748D40ED6
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:24 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so393230a12.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203584;
 x=1787808384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwZxBYUQZNZPJi9vhB3XcJuz0b/bArSiGY+bg8COM24=;
 b=GpH4MgTsqtCtAHPS3qXgdXMxFAtdnpjdGesatpdR0HntwzltVxOyZItNnK0MndnBxa
 QwBvcse8NY4jdLblIOVXyXin9gqcYeajhtTvAF7T73UvYWFBOoDQgoiBvWJ7r4yR2DM/
 0Z96dal/yeKgo+jbH98budVO+cX66FBcVrrWL58BotF2rpmUbi5GtaXbs1zPK47YWUN2
 pDAd3KelMJ94i3QDJY2eDHwcolhILDaFJJAbBD6Zdha7BAvjS7EIXSyu7itPf2Fysy0J
 vWkDuHVz6BWmSMimb5IzTPOBFSaxl2yXPsZK33IQ5IP77VqSp+7PrVnpsZ55m1Ov8Q7S
 gJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203584; x=1787808384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hwZxBYUQZNZPJi9vhB3XcJuz0b/bArSiGY+bg8COM24=;
 b=Khf+tXGfBXnEdQwgjL6jJOcpLjZ2QgBeWN4vAZlrVHQ8dXXeII46UELRgb0S5Rpq0K
 6QJtDIcrdO/GHkmx6Ed6UpByGySwZcHvoZzZ10xcuowjfadt+vgNZxhf5Cu/B0t4zEct
 tkRcrkK29nyM+cQxJCekH/AghEJbvFpa7qhSvE2qIgNoVM4NIaoAIxBuPXdwnFbSIRtA
 T3wqWHebt8CvADeXwWoE62qGCmLEmflQMZi0SPhEA2/tGAgj7KxVOigUw5YPOtytQ8OS
 AlFg6d5++nYK9X2LbPczFHgeZMRLC/9uE3Xw0vJyZslXf7ZkXjvOx7vPeuejVz5oAZYy
 JSDQ==
X-Gm-Message-State: AFuF++nOH1+5IriauXDClSVyWwXoURq2n+9gdTTVDG6ZrQnP+N4+D4l2
 rz0kaNi10f4mZ63D6IwUe6rgjlv0qNA9VtBoeQNVrFszcYqcJO25zcx1yZ12wLNIgGz0BnIGwla
 KCdEa
X-Gm-Gg: AR+sD11rbvx8VNRtwnHZ8IhYM+9q8MXAWlvL1cBhBXc/8/mzifM7AUKg8emzo1+B3gu
 JD9+UHyVsz7vS3m7mT9CvrDjkcHinwFEQGwx/rEYiqlXSURn/ij9gYVrW87XaJp0JpL+W1vmbjJ
 74DVPjcUYDN/qoL2++HnJYM3QN6+o/Ax/1L1T/mxUFs5SmPMEAJND3hGJXEV34ZxubGkL6Pm6md
 uW9rSrzw1HlflbmuLkINOnHFu4nwD0QOebqLUN9iTfdsEFhpVdhQh9bzUni7Epza0oUOMJiOiQ0
 tn+kzHUgmwpAMMUXLCcFvsnH3j3zzZHZK7sbGATKus+TeJsmeQ7uiw3SxBCLbgRZAEoyAfGezT9
 /nxlSsHPhDHUQj+rWOPu63+Lp9LIBanawz5SJCWrJ/ZSMrSw24k54W65rw8JatUKY78d0I3up1U
 Opr+nyWQb815cVtiGYjpT9LoBuLCDZRWnzzdOOf6V39BfK18Om1Z9/NzvzwXtKCb916dgf9L/tR
 saHnhAWD9eoaNAwUqiO9Fbfffo=
X-Received: by 2002:a17:90b:3902:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-395a04ea8f7mr4527625a91.8.1787203583769; 
 Wed, 19 Aug 2026 22:26:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 55/61] hash: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:45 -0700
Message-ID: <20260820052251.1453273-56-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need to use rte_memcpy to copy small key value here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_thash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..931bb55f0e 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -3,13 +3,13 @@
  */
 
 #include <stdalign.h>
+#include <string.h>
 #include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_thash.h>
 #include <rte_tailq.h>
 #include <rte_random.h>
-#include <rte_memcpy.h>
 #include <rte_errno.h>
 #include <rte_eal_memconfig.h>
 #include <rte_log.h>
@@ -263,7 +263,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	ctx->flags = flags;
 
 	if (key)
-		rte_memcpy(ctx->hash_key, key, key_len);
+		memcpy(ctx->hash_key, key, key_len);
 	else {
 		for (i = 0; i < key_len; i++)
 			ctx->hash_key[i] = rte_rand();
-- 
2.53.0

