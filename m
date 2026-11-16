Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469D606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKQb2NRS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C887F40374;
	Tue, 17 Nov 2026 08:58:25 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 5BE9D40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 18:19:11 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so647495e9.1
 for <dev@dpdk.org>; Mon, 16 Nov 2026 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794849551; x=1795454351; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3I+zqGusKk2IVmPjzdWIxQbJdNGz5FyRE84vl6laaTs=;
 b=XKQb2NRS/Xvh0MsAIZe4OY9rrjtMFyK3J2P3Imbu0kKhnTHbf4bJqUydJ1dBwntS8d
 YfO004ddGHPN+m9RnOyp+vpbrhyvTEGAnauEoYywOsYJw1NFoopfiyxF7ka7RPfrkQ5T
 otQHpxRNsYOc2kQ0N02NslFjqWSuqYm8IR5mqffVdXV6uFvceNJNb5kyZPyFe+8K45m9
 h6n34hut/vWE1dKJfPlLaQ+p5RovxGQdgG5YuGCY+44PwEnSbjpfhRza2B1Pnx0WGLjL
 Fs6Uq3a+3ArNXG/LNnWDBtNhWkJV5OgAUzr0Tb+E38FCAMxw0BI9JHu5P5CyNiJ5BHDj
 qxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849551; x=1795454351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3I+zqGusKk2IVmPjzdWIxQbJdNGz5FyRE84vl6laaTs=;
 b=LN41yyjeQA8f/7eryzbjrgEsyOa8PmMAmv+L9jKSCk00OkQHTKt0VTBCzXYi/qHPlp
 yzGMKQ00TuGqBaA5aWCGhZC87ZpTUJA33Ba+qt6uZLGB5aX8fBDx+Mrv2MbMViggYQmP
 OQUfNjaRerUNopOOTlVOMSeNBwkbFB4U1NbDTBZX1l318pPBXiwroDy+scohRVaoX7q5
 F01f0gemmbewlc7h2IJc+LkVGtSCxJBLFd3zeUhnGy4vOaJYtjYOLyZmgAF1lc76DgzW
 N29ZOcDC3u6DzuuPyCKgD+CSqvzoUqAeH2BLCQBgzF2mAvm4BbRX9aTDNA0w+9C4ncxR
 SUbA==
X-Gm-Message-State: APuU4Z9WzHxdeHaZmHwG3VS0G/NXEkyCrZrKiYelv+SlcRFGxP5bdTRE
 Cpfn/6S5XZUGUlpTfQrAYUZNuAIyNPTECQlgwNmC0b5UehQi6fbR1Ffx
X-Gm-Gg: AYBFou2UlgnheFoRyOAl+jNYUTunsezrQFm+gWWAtRzDHa4/OsQ1Z7zxGkgQixK99Ld
 swzcXCcRazlHZ/i756p+eeCRJwTqu5Ic+jUkaWxRxQoRZ+pW/kgT9eKseswIFiVmdPeqv8GkQ3N
 YMFNlDpNnCT7BaTaTtjsj1AypAsZyIxm5Ik3p2Y0c/ioBqaeLZzJCJCjTzmckwg/Bhaer5SZHdx
 aghqDb4xlocOz2CZ4enoBaOHXWxDP5dDwkc/BkRv1BOtqyz6r5NTSjJCgznxoBw8rD5gKly1dz6
 ZjCf7ZQY8q329KIwrLAdHz8ib970w9cmylkMaKSEpR9GluEaxDRhasOYxXwxOyAA9DrxYYyWwWs
 /Ksph89amPi7lNKIRf59ycLKTcF+CshVdiJ1rDMTUzuNDep7KKi6Bpm1AddLu7iVkho2EofwOYk
 H0Y3TuJu7+3bGh3T14Hca163FAqjW1iUYd+w1pJtJHTw20q6zclFGL5N3rWp/LAws+iiFOKCCoV
 J87lzYyNio2tRF0Mzr6FQHZQKki1UklNWlwix7bhS17LbsAqN6Sm2pCdwIYh5mPxtSc9vRNZi/e
 y+oSVQ7BYEo1fdTgtUaVI82wOzssrot9lHp1sgs2eBH5yuEY
X-Received: by 2002:a05:600c:1d97:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4bb78372629mr3470275e9.2.1794849550799; 
 Mon, 16 Nov 2026 09:19:10 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm68026135e9.3.2026.11.16.09.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:19:10 -0800 (PST)
From: Mark Bulatov <ms.bulatov7@gmail.com>
To: Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH v2] net/nfp: fix uninit local var in
 nfp_pre_tun_table_check_del
Date: Mon, 16 Nov 2026 20:18:56 +0300
Message-Id: <20261116171857.5306-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the search fails, it leads to a null pointer dereference when attempting
to initialize nfp_mac_idx.

Fix this by adding a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c33bdf1f18 ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
v2 changes: Correction of the Fixes tag and addition of find_entry
initialization at the point of declaration

v1 link:
https://patches.dpdk.org/project/dpdk/patch/20261113142207.5537-1-ms.bulatov7@gmail.com/

 drivers/net/nfp/flower/nfp_flower_flow.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..2372d2fdb9 100644
--- a/drivers/net/nfp/flower/nfp_flower_flow.c
+++ b/drivers/net/nfp/flower/nfp_flower_flow.c
@@ -3793,7 +3793,7 @@ nfp_pre_tun_table_check_del(struct nfp_flower_representor *repr,
 	uint16_t nfp_mac_idx;
 	struct nfp_flow_priv *priv;
 	struct nfp_pre_tun_entry *entry;
-	struct nfp_pre_tun_entry *find_entry;
+	struct nfp_pre_tun_entry *find_entry = NULL;
 	struct nfp_fl_rule_metadata *nfp_flow_meta;
 
 	priv = repr->app_fw_flower->flow_priv;
@@ -3828,6 +3828,13 @@ nfp_pre_tun_table_check_del(struct nfp_flower_representor *repr,
 	}
 
 	nfp_flow_meta = nfp_flow->payload.meta;
+
+	if (find_entry == NULL) {
+		PMD_DRV_LOG(ERR, "Pre-tunnel table search failed.");
+		ret = -EINVAL;
+		goto free_entry;
+	}
+
 	nfp_mac_idx = (find_entry->mac_index << 8) |
 			NFP_FLOWER_CMSG_PORT_TYPE_OTHER_PORT |
 			NFP_TUN_PRE_TUN_IDX_BIT;
-- 
2.39.5

