Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7387AC5DF97
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA82B41104;
	Fri, 21 Aug 2026 21:31:58 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8486440DCA
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:52 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso27940235ad.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340712;
 x=1787945512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFG5tooDgrAuydVb29KYy4a2h/GCo+j6QtnljmkKfUs=;
 b=mCCJLGqWphGUCaT95LINcZc41eLD6r99y8okhjCmlWytMu/yosD/Ae8bFbeiGY33LT
 l0xIIOfV56RTCCcC75LvJlu9gThmSPgUGTM5M6pUZFCN7BNaIUnKLH25dHTWtRFa9Uv4
 1784tRWFDOXRVnXpae1uCtrzfFZgGd6uBRI6acFdNUWnYjzwCgdkKEz6kAcwMefygb9x
 lXcAa1mNFvm2oZ2wHqj2DcBcpFhj5MHDg+K+GV+kPMvCOM2B5XtGWS2xwDwE7S+336Xp
 xbGduabskJHHcVRcctkN/oREkgQagV0WXosMdzwBnCSLjXsz9f9GWNjwtZL7WDMBevX8
 G/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340712; x=1787945512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFG5tooDgrAuydVb29KYy4a2h/GCo+j6QtnljmkKfUs=;
 b=E4JdxS+E96jkqzHz8Cu8nNML7y1bWAlOEDKbX+UjEzhoAtFUQ+yxnuiHk3YmOVKH63
 dEg0xJzPw4yQibB0TOuvROyi2AkDr2b3InyCd998IXKDVcNL+VbM03g+DzZda8szHeO6
 56AvDqU4mJvrSwYcdnPvz/6qlpElgSXd5HJpywOJ7YuYJcMA1h6CU4mzHRrFiDRwdf0q
 gby+jKcCkRHkohe1BehA7nRFt9hB1j32NXxe38amOtEM1s2VjjdPceYNFto6Q0KU62an
 /+vIMc96GbxUkGcVu2ct1btIIawwZGPp3RE1aCq5e43+cl/8WwxVbI0UGvrTVwqhyH2G
 1ywQ==
X-Gm-Message-State: AFuF++kWsZ4Hd6GvrtVDdXIzFtQYNJqcsRhnwq6nyr2yBPrJTAsAj49u
 Me5qrlJMYpfnZG0iwWagm22RxFFHqahijoI4MoBVgBr/M93GRSpcSArkT5qQfu6wghvxALLHhHD
 MvEZbuIk=
X-Gm-Gg: AR+sD11qFQwv+hUGb7VEu4461Cqq8lfoSmSSuM43gOSqMg0YTiGHgMMHc4X7eyA3XnD
 a6MHZRHbccvHEFn0oIBh08SylWt6yeipWlEy4/JH6QREsnmvjcCioaCPhmkNUxa4nZtHXcbiUrj
 sn6MPV9Knz6E1etx7JsQdSIrAAF8SkiWZ78PdmfICmf07rHaQ3fwxXm+CRlq3kdlIL8HjFz5p2W
 0bl1zpRS7oriC75z2BQnSm/2CpMyyOtu43i2+4dsoSO8rog7/9XciB99G33K0y8xnnnkDWnQRmn
 XlAaFLXEReVhoE0XAaJgoBwyRwSiKbSU49GPS9RN1EWPY7jVqkMZs6bJ5N9ashWb7rz+N+EreIY
 7CKfcGBXjTp62pcEwEvuBf+cqyunf2b6cCDlyZJEC73GfjSoiK4I7VWVL7w+M6zAL+FXr16w21N
 NSPk6ZppWnz2Vx0AybEtl3f7k/1mUsyGTBAKfbbepW/EqgqLURwhO3VFo3NgjVx/ryAab9Dl3lM
 zviijucDJC58FRs0iYW8Bx6Pws=
X-Received: by 2002:a17:90b:2e4b:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-395c514b5cbmr7831159a91.10.1787340710543; 
 Fri, 21 Aug 2026 12:31:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH v2 66/68] net/xsc: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:25:01 -0700
Message-ID: <20260821192646.146382-67-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The use of rte_memcpy() when building the RSS hash key mailbox
command is control path only. Regular memcpy() has no performance
disadvantage there and gets more compile time checking of the
arguments.

The remaining uses of rte_memcpy() in xsc_tx_elts_store() are left
alone since that is on the transmit fast path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f489516..baec15d153 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -159,7 +159,7 @@ xsc_dev_rss_key_modify(struct xsc_dev *xdev, uint8_t *rss_key, uint8_t rss_key_l
 	in.hdr.opcode = rte_cpu_to_be_16(XSC_CMD_OP_MODIFY_NIC_HCA);
 
 	key_len = RTE_MIN(rss_key_len, XSC_RSS_HASH_KEY_LEN);
-	rte_memcpy(in.rss.hash_key, rss_key, key_len);
+	memcpy(in.rss.hash_key, rss_key, key_len);
 	rss_caps_mask |= RTE_BIT32(XSC_RSS_HASH_KEY_UPDATE);
 
 	in.rss.caps_mask = rss_caps_mask;
-- 
2.53.0

