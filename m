Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D0C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6172140268;
	Wed, 26 Aug 2026 19:38:56 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 17E9240264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:38:54 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-930f618435cso80990085a.3
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765933; x=1788370733; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kOlydHGOAoiM2p3dLMOmn/nsdNuu8+l2ccz9chMM10Q=;
 b=MN7cO5jXAW8PijiYNyJT7UHykxqClTo0daIsEWi+ii0TgSB68qpox4tnD78K46V6aa
 z8MEVe9NLXhmyVuFJHwvyk2ecuqkIMg7hIz1JcbS9aUb8qBiz6peJHILSQo/A56isQP6
 YJlhASX/o5yhWMiTA3n4xJydu2pLjoFJmHzgulXibCklsQXyYN0c6s8AUjoKCa2G8PzL
 g3s8+gudvkzySK4mkYJKz0IwVWW94L8XBuW6yOM9SlMqmU0K6Y9umPkUws481UCplz3T
 FySu6nnfsfb+fucXgyEFqAyArQWkKaCE8IhPbob4B99brcX3WY77GV0HwACcPxAMEilN
 l76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765933; x=1788370733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kOlydHGOAoiM2p3dLMOmn/nsdNuu8+l2ccz9chMM10Q=;
 b=Ml2QiHOfy4tYUc5AKo7KK+WwMBD3ycdm49RzLc2B5Mvcp+p/YvqxXirA8pLtOImkdo
 TioXZtb7PYiOul4JIuY4b++U0dxlLAI8KxGa5ri1BBOgD+/UG3GXVGsYV9qKujOxKtCd
 O39WSS3EDSEdyu/LWgvL9yS5WtXA4S7yHlv+BNNII328UOBtLXtoQh32G/pmmIyTN6UD
 TVPJVFTlp9u0pLZe2UUZHvyZQ+rZZ0uWhrQdu1S9JQmPQkwVH1uWVPOR9wK4+WNRd+0E
 MVtedT6ihzyP3v8Bf8zEon/ksJW9avhfiCaK0CZt+0RBd3D450om0OXQHTUMDOt8jz/q
 0c1w==
X-Gm-Message-State: AFuF++mDGxuLqbzFlCrGRPKcx5ZrttVvfieg+B31Xp6Fqp4d0iHMBw15
 Vhf71BFdI3DHrH3txwuDvKcIYsuIvq1jHCbkW6gc60Al46rmZr5Ee+1Q
X-Gm-Gg: AR+sD10NV0aWW1rsNE5qC8gLEBlwnvOcdhOpDisOclwle59DHfqQ25uwGPYWoGCY/WW
 eWZMhUchyTNR5oUJPtOJ/bcSYA/4fNFYX+cx7+j0hwmyO//lZbDdkAhgXdjoSuMTV4mRPrn4nVh
 WZOPfwqY4p1m9CQvJayve1Q/JRqp8kR1HnqbF/Yucz5ZqSqRhQYz+3s/ISXIeE71PCw3w8098Ci
 umWVMd2BmiStVWFoGagmNSgy5czDuiW1JdqxahbcWF6FBcaaKJ+p3liJt7nlfwF7YIwaXJcKmXc
 7ygnEyWGbe1Em2ifI3sAYHFdNZSiu+nOcotAgaqJ4wDk1bxo8wWrqIuJsMWGRzidN/2N+2w1pdk
 jdQS6VHGeMHMHB/8aCgvJgX7OR5uhGlzniUaw+NDaQ2Z6YlwcTB/2NWOWoQtvB9VZUtl8cmcYID
 kysQhDWeg9/dcvfq134cbY+0CHU7LECIeOkV2qE5OmB67nS2Q1bc+blgNncPTcT9w=
X-Received: by 2002:a05:620a:4621:b0:936:f9f5:61e3 with SMTP id
 af79cd13be357-93780107ec5mr685053585a.1.1787765933221; 
 Wed, 26 Aug 2026 10:38:53 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616605sm263115585a.29.2026.08.26.10.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:38:52 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: Changchun Ouyang <changchun.ouyang@intel.com>,
 Huawei Xie <huawei.xhw@alibaba-inc.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>,
	stable@dpdk.org
Subject: [PATCH v2 1/4] net: fix VLAN insert doc comment for shared-mbuf error
 code
Date: Wed, 26 Aug 2026 13:38:38 -0400
Message-ID: <20260826173842.1298754-1-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The implementation returns -EINVAL when the mbuf is shared or
indirect, but the doc comment inaccurately stated -EPERM.

Fixes: c974021a5949 ("ether: add soft vlan encap/decap")
Cc: stable@dpdk.org

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 lib/net/rte_ether.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index c9a0b536c3..cb10d8fb06 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -387,7 +387,8 @@ static inline int rte_vlan_strip(struct rte_mbuf *m)
  *   The packet mbuf.
  * @return
  *   - 0: On success
- *   -EPERM: mbuf is shared overwriting would be unsafe
+ *   -EINVAL: overwriting would be unsafe because mbuf is shared or
+ *            indirect, or mbuf's first segment is too short
  *   -ENOSPC: not enough headroom in mbuf
  */
 static inline int rte_vlan_insert(struct rte_mbuf **m)
-- 
2.43.0

